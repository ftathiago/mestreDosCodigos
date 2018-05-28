unit umcFormFactory;

interface

uses
  System.Classes,
  umcDBForm,
  Vcl.Forms,
  Data.DB,
  DataSet.Intf.ConfiguradorMetaData,
  Conexao.Intf.ConfiguracaoDeConexao, Conexao.Intf.Configuracao;

type
  TFormFactory = class
  private
    class var CAplicacao: TFormFactory;
    function PegarFormJaCriado(const FormClass: TfmcDBFormClass; const Owner: TForm): TfmcDBForm;
  public
    class function ObterInstancia: TFormFactory;
    class function NewInstance: TObject; override;
    procedure CriarFormulario(const NomeDoForm: string; const Owner: TForm; const AConnection: TCustomConnection;
      const AConfiguradorMetaData: IConfiguradorMetaData; out obj);
  end;

implementation

uses

  System.SysUtils;

procedure TFormFactory.CriarFormulario(const NomeDoForm: string; const Owner: TForm;
  const AConnection: TCustomConnection; const AConfiguradorMetaData: IConfiguradorMetaData; out obj);
var
  _frmClass: TfmcDBFormClass;
  _form: TfmcDBForm;
begin
  _form := nil;

  _frmClass := TfmcDBFormClass(FindClass(NomeDoForm));

  if Assigned(Owner) then
    _form := PegarFormJaCriado(_frmClass, Owner);

  if not Assigned(_form) then
    _form := _frmClass.Create(Owner, AConnection, AConfiguradorMetaData);

  TfmcDBForm(obj) := _form;
end;

class function TFormFactory.NewInstance: TObject;
begin
  if not Assigned(CAplicacao) then
    CAplicacao := TFormFactory(inherited NewInstance);

  result := CAplicacao;
end;

class function TFormFactory.ObterInstancia: TFormFactory;
begin
  result := TFormFactory.Create;
end;

function TFormFactory.PegarFormJaCriado(const FormClass: TfmcDBFormClass; const Owner: TForm): TfmcDBForm;
var
  i: Integer;
begin
  result := nil;
  for i := 0 to Pred(Owner.MDIChildCount) do
  begin
    if Owner.MDIChildren[i].ClassNameIs(FormClass.ClassName) then
    begin
      result := Owner.MDIChildren[i] as TfmcDBForm;
      break;
    end;
  end;
end;

initialization

finalization

FreeAndNil(TFormFactory.CAplicacao);

end.
