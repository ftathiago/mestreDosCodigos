unit MetaDataConf.UI.ffwPrincipal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.PGDef,
  FireDAC.Phys.IBDef,
  FireDAC.Phys.OracleDef,
  FireDAC.Phys.DB2Def,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.TDBXDef,
  FireDAC.Phys.ODBCDef,
  FireDAC.Stan.StorageBin,
  FireDAC.Stan.StorageXML,
  FireDAC.Stan.StorageJSON,
  FireDAC.Phys.ODBC,
  FireDAC.Phys.TDBXBase,
  FireDAC.Phys.TDBX,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.ODBCBase,
  FireDAC.Phys.DB2,
  FireDAC.Phys.Oracle,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.IB,
  FireDAC.Phys.PG,
  FireDAC.Phys.MySQL,
  Conexao.Intf.Configuracao,
  Conexao.Intf.ConfiguracaoDeConexao,
  Vcl.Menus,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  System.ImageList,
  Vcl.ImgList,
  Vcl.ToolWin,
  Vcl.ComCtrls,
  System.Actions,
  Vcl.ActnList;

type
  TffwPrincipal = class(TForm)
    FDConnection: TFDConnection;
    MainMenu: TMainMenu;
    Cadastro1: TMenuItem;
    mnuffwConfigEntidade: TMenuItem;
    FDMemTable1: TFDMemTable;
    ToolBar1: TToolBar;
    iml32: TImageList;
    ToolButton1: TToolButton;
    ActionList: TActionList;
    actffwConfigEntidade: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure AbrirForm(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarIni;
  public
    { Public declarations }
  end;

var
  ffwPrincipal: TffwPrincipal;

implementation

{$R *.dfm}


uses
  System.VarUtils,
  pkgUtils.Intf.Aplicacao,
  Conexao.Impl.FDConfiguracaoDeConexao;

procedure TffwPrincipal.AbrirForm(Sender: TObject);
var
  _aplicacao: TAplicacao;
  _form: TForm;
  _nomeComponente: string;
begin
  _nomeComponente := 'T' + String(TComponent(Sender).Name).Substring(3);
  _aplicacao := TAplicacao.ObterInstancia;
  _aplicacao.CriarFormulario(_nomeComponente, Self, _form);

  _form.Show;
end;

procedure TffwPrincipal.Button2Click(Sender: TObject);
var
  _aplicacao: TAplicacao;
  _form: TForm;
begin
  _aplicacao := TAplicacao.ObterInstancia;
  _aplicacao.CriarFormulario('TfmcCRUD1', Self, _form);
  _form.Show;
end;

procedure TffwPrincipal.CarregarIni;
begin
  TAplicacao.ObterInstancia.ConfigurarConexao(
    TFDConfiguracaoDeConexao.New(FDConnection));
end;

procedure TffwPrincipal.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  CarregarIni;
end;

end.
