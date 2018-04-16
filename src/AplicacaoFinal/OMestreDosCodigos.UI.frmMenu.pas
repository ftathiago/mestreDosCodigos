unit OMestreDosCodigos.UI.frmMenu;

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
  Vcl.Menus;

type
  TfrmMenu = class(TForm)
    MainMenu1: TMainMenu;
    mnuExercicios: TMenuItem;
    mnufrmArrayClientes: TMenuItem;
    mnuffwConfigEntidade: TMenuItem;
    procedure AbrirForm(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.dfm}


uses
  pkgUtils.Intf.Aplicacao,
  OMestreDosCodigos.Intf.Cliente,
  OMestreDosCodigos.Impl.Cliente.Builder,
  OMestreDosCodigos.Impl.Cliente;

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
