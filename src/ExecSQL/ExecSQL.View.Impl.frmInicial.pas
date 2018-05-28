unit ExecSQL.View.Impl.frmInicial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, MVC.Impl.View, Data.DB,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UI.frmSQL, ExecSQL.Controller.Impl.frmListaObjetos,
  ExecSQL.View.Impl.frmListaObjetos, ExecSQL.Controller.Intf.frmInicial, MVC.Impl.View.FrameView, System.ImageList,
  Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.ToolWin, Vcl.ComCtrls;

type
  TfrmInicialView = class(TFormView)
    frmSQL: TfrmSQL;
    frmListaObjetosView: TfrmListaObjetosView;
    ToolBar1: TToolBar;
    ActionList1: TActionList;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
  protected
    function Controller: IfrmInicialController; reintroduce;
  end;

implementation

{$R *.dfm}

uses
  MVC.RegistroDeClasses;

function TfrmInicialView.Controller: IfrmInicialController;
begin
  result := inherited Controller as IfrmInicialController;
end;

procedure TfrmInicialView.FormCreate(Sender: TObject);
begin
  inherited;
  frmListaObjetosView.DefinirController(Controller.frmListaObjetosController);
  Controller.frmListaObjetosController.setView(frmListaObjetosView);
end;

initialization

RegistrarView(TfrmInicialView);

end.
