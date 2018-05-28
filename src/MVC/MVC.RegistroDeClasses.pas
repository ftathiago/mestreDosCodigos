unit MVC.RegistroDeClasses;

interface

uses
  System.SysUtils, System.Generics.Collections, MVC.Impl.Controller, MVC.Impl.View.FrameView, MVC.Impl.View;

type
  TControllerPair = TPair<string, TControllerClass>;
  TControllerDictionary = TDictionary<string, TControllerClass>;
  TViewDictionary = TDictionary<String, TFormViewClass>;

  TRegistroDeClasses = class
  private
    FControllersRegistrados: TControllerDictionary;
    FViewsRegistradas: TViewDictionary;
  public
    constructor Create;
    destructor Destroy; override;
    procedure RegistrarController(AController: TControllerClass);
    procedure RegistrarView(AView: TFormViewClass);
    function RetornarController(ANomeClasseController: string): TControllerClass;
    function RetornarControllerLista: TControllerDictionary;
    function RetornarView(ANomeClasseView: string): TFormViewClass;
  end;

procedure RegistrarController(AController: TControllerClass);
procedure RegistrarView(AView: TFormViewClass);
function RetornarClassController(AController: string): TControllerClass;
function RetornarClasseView(AView: string): TFormViewClass;
function RetornarControllerLista: TControllerDictionary;

implementation

uses MVC.Exception;

var
  RegistroDeClasses: TRegistroDeClasses;

procedure RegistrarController(AController: TControllerClass);
begin
  RegistroDeClasses.RegistrarController(AController);
end;

function RetornarClassController(AController: string): TControllerClass;
begin
  result := RegistroDeClasses.RetornarController(AController);
end;

procedure RegistrarView(AView: TFormViewClass);
begin
  RegistroDeClasses.RegistrarView(AView);
end;

function RetornarClasseView(AView: string): TFormViewClass;
begin
  result := RegistroDeClasses.RetornarView(AView);
end;

function RetornarControllerLista: TControllerDictionary;
begin
  result := RegistroDeClasses.RetornarControllerLista;
end;

constructor TRegistroDeClasses.Create;
begin
  FControllersRegistrados := TControllerDictionary.Create();
  FViewsRegistradas := TViewDictionary.Create();
end;

destructor TRegistroDeClasses.Destroy;
begin
  FControllersRegistrados.Clear;
  FreeAndNil(FControllersRegistrados);

  FViewsRegistradas.Clear;
  FreeAndNil(FViewsRegistradas);
  inherited;
end;

procedure TRegistroDeClasses.RegistrarController(AController: TControllerClass);
begin
  FControllersRegistrados.Add(AController.ClassName, AController);
end;

procedure TRegistroDeClasses.RegistrarView(AView: TFormViewClass);
begin
  FViewsRegistradas.Add(AView.ClassName, AView);
end;

function TRegistroDeClasses.RetornarController(ANomeClasseController: string): TControllerClass;
begin
  if not FControllersRegistrados.TryGetValue(ANomeClasseController, result) then
    raise EMVCControllerNotFound.Create(ANomeClasseController);
end;

function TRegistroDeClasses.RetornarControllerLista: TControllerDictionary;
begin
  result := FControllersRegistrados;
end;

function TRegistroDeClasses.RetornarView(ANomeClasseView: string): TFormViewClass;
begin
  if not FViewsRegistradas.TryGetValue(ANomeClasseView, result) then
    raise EMVCViewNotFound.Create(ANomeClasseView);
end;

initialization

RegistroDeClasses := TRegistroDeClasses.Create;

finalization

FreeAndNil(RegistroDeClasses);

end.
