unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
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
  SQL.Intf.SQLTabela, SQL.Intf.SQLColuna, SQL.Impl.PadraoSQL3.SQLTabela, SQL.Impl.PadraoSQL3.SQLColuna;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  oTabela: ISQLTabela;
  oColuna: ISQLColuna;
begin
  oTabela := TSQL3Tabela.New
    .setAlias(Edit1.Text)
    .setNome(Edit2.Text);
  oColuna := TSQL3Coluna.New
    .setTabela(oTabela)
    .setColuna(Edit4.Text)
    .setNomeAlias(Edit5.Text);
  Edit3.Text := oTabela.ToString;
  Edit6.Text := oColuna.ToString;
end;

end.
