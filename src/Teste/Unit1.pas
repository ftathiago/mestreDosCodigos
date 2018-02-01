unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    edtAlias: TEdit;
    edtTabela: TEdit;
    edtResultadoTabela: TEdit;
    Button1: TButton;
    edtNomeCampo: TEdit;
    edtCampoAliasName: TEdit;
    edtResultadoCampo: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  SQL.Intf.SQLColuna, SQL.Impl.PadraoSQL3.SQLTabela,
  SQL.Impl.PadraoSQL3.SQLColuna, SQL.Intf.SQLTabela;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  oTabela: ISQLTabela;
  oColuna: ISQLColuna;
begin
  oTabela := TSQL3Tabela.New
    .setAlias(edtAlias.Text)
    .setNome(edtTabela.Text);
  oColuna := TSQL3Coluna.New
    .setTabela(oTabela)
    .setColuna(edtNomeCampo.Text)
    .setNomeAlias(edtCampoAliasName.Text);
  edtResultadoTabela.Text := oTabela.ToString;
  edtResultadoCampo.Text := oColuna.ToString;
end;

end.
