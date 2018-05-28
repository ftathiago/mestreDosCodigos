unit ExecSQL.Controller.Impl.frmPesquisaSQL;

interface

uses
  MVC.Impl.Controller, ExecSQL.Controller.Intf.frmPesquisaSQL;

type
  TfrmPesquisaSQLController = class(TController, IfrmPesquisaSQLController)
  public
    procedure MarcarTextoComErro(const Texto: string);
    procedure MarcarSelecaoComErro;
    class function New: IfrmPesquisaSQLController;
  end;

implementation

{ TfrmPesquisaSQLController }

procedure TfrmPesquisaSQLController.MarcarSelecaoComErro;
begin

end;

procedure TfrmPesquisaSQLController.MarcarTextoComErro(const Texto: string);
begin

end;

class function TfrmPesquisaSQLController.New: IfrmPesquisaSQLController;
begin
  result := Create;
end;

end.
