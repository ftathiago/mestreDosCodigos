program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  SQL.Enums in '..\Classes\SQL.Enums.pas',
  SQL.Impl.PadraoSQL3.SQLColuna in '..\Classes\SQL.Impl.PadraoSQL3.SQLColuna.pas',
  SQL.Impl.PadraoSQL3.SQLTabela in '..\Classes\SQL.Impl.PadraoSQL3.SQLTabela.pas',
  SQL.Impl.SQL in '..\Classes\SQL.Impl.SQL.pas',
  SQL.Intf.SQL in '..\Classes\SQL.Intf.SQL.pas',
  SQL.Intf.SQLColuna in '..\Classes\SQL.Intf.SQLColuna.pas',
  SQL.Intf.SQLSelect in '..\Classes\SQL.Intf.SQLSelect.pas',
  SQL.Intf.SQLCondicao in '..\Classes\SQL.Intf.SQLCondicao.pas',
  SQL.Intf.SQLJuncao in '..\Classes\SQL.Intf.SQLJuncao.pas',
  SQL.Intf.SQLTabela in '..\Classes\SQL.Intf.SQLTabela.pas',
  SQL.Impl.PadraoSQL3.SQLCondicao in '..\Classes\SQL.Impl.PadraoSQL3.SQLCondicao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
