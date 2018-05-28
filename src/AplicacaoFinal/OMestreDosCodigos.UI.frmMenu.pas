unit OMestreDosCodigos.UI.frmMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  DataSet.Intf.MetaDataContainer, DataSet.Intf.ConfiguradorMetaData,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, Vcl.StdCtrls,
  FireDAC.Moni.Base, FireDAC.Moni.Custom;

type
  TfrmMenu = class(TForm)
    MainMenu1: TMainMenu;
    mnuExercicios: TMenuItem;
    mnufrmArrayClientes: TMenuItem;
    mnuffwConfigEntidade: TMenuItem;
    mnufrmPerguntasAlternativas: TMenuItem;
    FDConnection1: TFDConnection;
    FDMoniCustomClientLink1: TFDMoniCustomClientLink;
    mnufrmCadPesquisa: TMenuItem;
    procedure AbrirForm(Sender: TObject);
    procedure AbrirCRUD(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnufrmPerguntasAlternativasClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FDMoniCustomClientLink1Output(ASender: TFDMoniClientLinkBase;
      const AClassName, AObjName, AMessage: string);
  private
    FFDConnection: TFDConnection;
    FMetaData: IMetaDataContainer;
    FConfiguradorMetaData: IConfiguradorMetaData;
  public
    function GetConnection: TFDConnection;
    function GetConfiguradorMetaData: IConfiguradorMetaData;
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.dfm}

uses
  pkgUtils.Intf.Aplicacao,
  Conexao.Impl.Fabrica.FireDAC,
  DataSet.Impl.ConfiguradorMetaData,
  DataSet.Impl.MetaDataContainer,
  umcFormFactory, umcCRUD,
  OMestreDosCodigos.Intf.Cliente,
  OMestreDosCodigos.Impl.Cliente.Builder,
  OMestreDosCodigos.Impl.Cliente, OMestreDosCodigos.UI.frmPerguntasAlternativas;

procedure TfrmMenu.mnufrmPerguntasAlternativasClick(Sender: TObject);
var
  _aplicacao: TFormFactory;
  _form: TForm;
  _nomeComponente: string;
begin
  _nomeComponente := 'TfrmPerguntasAlternativas';
  _aplicacao := TFormFactory.ObterInstancia;
  _aplicacao.CriarFormulario(_nomeComponente, Self, GetConnection, GetConfiguradorMetaData, _form);

  _form.Show;
end;

procedure TfrmMenu.FDMoniCustomClientLink1Output(ASender: TFDMoniClientLinkBase;
  const AClassName, AObjName, AMessage: string);
const
  FORMATO = '%s - %s - %s';
begin
  // Memo1.Lines.Add(Format(FORMATO,[AClassName, AObjName, AMessage]));
end;

procedure TfrmMenu.FormCreate(Sender: TObject);
begin
  FFDConnection := TFabricaFireDac.New.getConexao as TFDConnection;
  FMetaData := TMetaDataContainer.New(GetConnection);
  FConfiguradorMetaData := TConfiguradorMetaData.New(FMetaData.ENTIDADE, FMetaData.EntPropriedade);
end;

procedure TfrmMenu.FormDestroy(Sender: TObject);
begin
  FFDConnection.Close;
  FreeAndNil(FFDConnection);
end;

function TfrmMenu.GetConfiguradorMetaData: IConfiguradorMetaData;
begin
  result := FConfiguradorMetaData;
end;

function TfrmMenu.GetConnection: TFDConnection;
begin
  result := FFDConnection;
end;

procedure TfrmMenu.AbrirCRUD(Sender: TObject);
var
  _aplicacao: TFormFactory;
  _form: TForm;
  _nomeComponente: string;
begin
  _nomeComponente := 'T' + String(TComponent(Sender).Name).Substring(3);
  _aplicacao := TFormFactory.ObterInstancia;
  _aplicacao.CriarFormulario(_nomeComponente, Self, GetConnection, GetConfiguradorMetaData, _form);

  _form.Show;
end;

procedure TfrmMenu.AbrirForm(Sender: TObject);
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

end.
