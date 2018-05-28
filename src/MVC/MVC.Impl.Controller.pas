unit MVC.Impl.Controller;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Classes, Data.DB, VCL.Forms, MVC.Intf.Controller, MVC.Intf.View,
  MVC.Intf.ControlaExibicao, MVC.Intf.Conectavel;

type
  TController = class;
  TControllerClass = class of TController;

  TController = class(TInterfacedObject, IController)
  private
    FConnection: TCustomConnection;
    FView: TComponent;
  protected
    function View: TComponent;
    procedure AposCriarAView; virtual;
    procedure AoDestruirView; virtual;
    procedure AoMostrar; virtual;
  public
    class function New(): IController;
    constructor Create(); virtual;
    function RetornarConexao: TCustomConnection; virtual;
    procedure DefinirConexao(const AConexao: TCustomConnection); virtual;
    procedure setView(const AView: TComponent);
  end;

implementation

class function TController.New(): IController;
begin
  result := Create;
end;

procedure TController.AoDestruirView;
begin

end;

procedure TController.AoMostrar;
begin

end;

procedure TController.AposCriarAView;
begin

end;

constructor TController.Create();
begin

end;

procedure TController.DefinirConexao(const AConexao: TCustomConnection);
begin
  if FConnection = AConexao then
    exit;

  FConnection := AConexao;
end;

function TController.RetornarConexao: TCustomConnection;
begin
  result := FConnection;
end;

procedure TController.setView(const AView: TComponent);
begin
  FView := AView;
end;

function TController.View: TComponent;
begin
  result := FView;
end;

end.
