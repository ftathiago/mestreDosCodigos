unit MVC.Impl.CDI;

interface

uses
  System.Classes, System.SysUtils, VCL.Forms, Data.DB, MVC.Intf.CDI, MVC.Intf.View,
  MVC.Impl.View, MVC.Intf.Controller, MVC.Impl.Controller;

type
  TCDI = class(TInterfacedObject, ICDI)
  private
    FConnection: TCustomConnection;
    function Owner: TForm;
    function TratarNomeDoForm(const ANomeDoForm: string): string;
    function PegarFormJaCriado(const FormClass: TFormClass; const Owner: TForm): TFormView;
    function ConstruirController(const AFormViewClassName: string): IController;
    procedure ConfigurarController(const AController: IController);
    function ConstruirView(const FormClass: TFormViewClass; const AController: IController): TFormView;
    function TestarViewJaCriada(const AFormViewClass: TFormViewClass; out AView: TFormView): boolean;
    procedure CriarViewController(const ANomeDoForm: string; AFormClass: TFormViewClass; var AView: TFormView);
  public
    class function New: ICDI;
    procedure DefinirConexao(const AConexao: TCustomConnection);
    function RetornarConexao: TCustomConnection;
    function TratarRequisicaoMVC(const ANomeDoForm: string): TFormView;
  end;

implementation

uses MVC.Intf.Conectavel, MVC.RegistroDeClasses, MVC.Controller.Impl.Factory, MVC.Controller.Intf.Factory,
  MVC.Exception;

class function TCDI.New: ICDI;
begin
  result := Create;
end;

function TCDI.TratarRequisicaoMVC(const ANomeDoForm: string): TFormView;
var
  _view: TFormView;
  _nomeDoForm: string;
var
  _frmClass: TFormViewClass;
begin
  _view := nil;

  _nomeDoForm := TratarNomeDoForm(ANomeDoForm);
  _frmClass := RetornarClasseView(_nomeDoForm);

  if TestarViewJaCriada(_frmClass, _view) then
    exit(_view);

  CriarViewController(_nomeDoForm, _frmClass, _view);

  if not Assigned(_view) then
    raise EMVCViewNotFound.Create(_nomeDoForm);

  result := _view;
end;

function TCDI.TestarViewJaCriada(const AFormViewClass: TFormViewClass; out AView: TFormView): boolean;
begin
  AView := PegarFormJaCriado(AFormViewClass, Owner);

  result := Assigned(AView);
end;

procedure TCDI.CriarViewController(const ANomeDoForm: string; AFormClass: TFormViewClass; var AView: TFormView);
var
  _controller: IController;
begin
  _controller := ConstruirController(AFormClass.ClassName);

  if not Assigned(_controller) then
    raise EMVCControllerNotFound.Create(AFormClass.ClassName);

  ConfigurarController(_controller);
  AView := ConstruirView(AFormClass, _controller);
end;

function TCDI.TratarNomeDoForm(const ANomeDoForm: string): string;
begin
  result := ANomeDoForm;

  if ANomeDoForm.StartsWith('T') then
    exit;

  result := Format('T%s', [ANomeDoForm]);
end;

function TCDI.ConstruirView(const FormClass: TFormViewClass; const AController: IController): TFormView;
begin
  result := FormClass.Create(Owner, AController);
end;

function TCDI.PegarFormJaCriado(const FormClass: TFormClass; const Owner: TForm): TFormView;
var
  i: integer;
begin
  result := nil;
  if Owner.FormStyle <> fsMDIForm then
    exit;

  for i := 0 to Pred(Owner.MDIChildCount) do
  begin
    if Owner.MDIChildren[i].ClassNameIs(FormClass.ClassName) then
    begin
      result := Owner.MDIChildren[i] as TFormView;
      break;
    end;
  end;
end;

procedure TCDI.ConfigurarController(const AController: IController);
begin
  AController.DefinirConexao(RetornarConexao);
end;

function TCDI.ConstruirController(const AFormViewClassName: string): IController;
var
  _controllerFactory: IControllerFactory;
begin
  _controllerFactory := TControllerFactory.New;
  result := _controllerFactory.RetornarControleDaView(AFormViewClassName);
end;

procedure TCDI.DefinirConexao(const AConexao: TCustomConnection);
begin
  FConnection := AConexao;
end;

function TCDI.Owner: TForm;
begin
  result := Application.MainForm
end;

function TCDI.RetornarConexao: TCustomConnection;
begin
  result := FConnection;
end;

end.
