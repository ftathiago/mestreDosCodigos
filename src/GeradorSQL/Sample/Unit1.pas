unit Unit1;

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
  System.Generics.Collections,
  GeradorSQL.Comp.Select,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    mcsTempoExecucao: TMCSelect;
    GridPanel1: TGridPanel;
    Memo1: TMemo;
    Memo2: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    mcsDesign: TMCSelect;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SQLTempoExecucao;
    procedure SQLDesignTime;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  SQL.Enums;

{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  SQLTempoExecucao;
  SQLDesignTime;
end;

procedure TForm1.SQLDesignTime;
begin
  Memo2.Text := mcsDesign.GerarSQL;
end;

procedure TForm1.SQLTempoExecucao;
var
  _mcsTempoExecucao: TMCSelect;
begin
  _mcsTempoExecucao := TMCSelect.Create(nil);
  try
    _mcsTempoExecucao.AddColuna('Coluna_1');
    _mcsTempoExecucao.AddColuna('Coluna_2','NomeVirtual');
    _mcsTempoExecucao.AddColuna('Coluna_3','NomeVirutal2','NomeTabela','AT');
    _mcsTempoExecucao.setTabela('NomeTabela','AT');
    _mcsTempoExecucao.AddJuncao(tjInnerJoin, 'Tabela_Join Alias', 'Alias.Coluna1 = AT.Coluna2');
    _mcsTempoExecucao.AddCondicao('Coluna_2 > 0');
    Memo1.Text := _mcsTempoExecucao.GerarSQL;
  finally
    _mcsTempoExecucao.Free;
  end;
end;

end.
