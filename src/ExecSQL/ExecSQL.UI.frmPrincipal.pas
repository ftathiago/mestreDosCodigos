unit ExecSQL.UI.frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  MVC.Intf.CDI, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, System.Actions,
  Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Menus;

type
  TfrmPrincipal = class(TForm)
    MestredoscodigosConnection: TFDConnection;
    MainMenu1: TMainMenu;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ActionList1: TActionList;
    actfrmInicialView: TAction;
    procedure FormCreate(Sender: TObject);
    procedure AbrirForm(Sender: TObject);
  private
    FCDI: ICDI;
  public
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses MVC.Impl.CDI;

procedure TfrmPrincipal.AbrirForm(Sender: TObject);
var
  _nome: string;

begin
  _nome := (Sender as TComponent).Name;
  _nome := _nome.Substring(3);
  FCDI.TratarRequisicaoMVC(_nome).Show;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  FCDI := TCDI.New;
  FCDI.DefinirConexao(MestredoscodigosConnection);
end;

end.
