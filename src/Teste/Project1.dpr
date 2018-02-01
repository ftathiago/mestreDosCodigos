program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  SQL.Impl.PadraoSQL3.SQLTabela in '..\Classes\SQL.Impl.PadraoSQL3.SQLTabela.pas',
  SQL.Intf.SQLTabela in '..\Classes\SQL.Intf.SQLTabela.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
