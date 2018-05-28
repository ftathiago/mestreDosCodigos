unit UI.frmSQL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfrmSQL = class(TFrame)
    SQLContainer: TRichEdit;
  private
    procedure LimparFormatacao;
  public
    function TextoSQL: string;
    procedure MarcarSelecaoComErro;
    procedure MarcarTextoComErro(const ASQLComErro: string); overload;
    procedure MarcarTextoComErro(const AInicioSelecao, ATamanhoSelecao: integer); overload;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

procedure TfrmSQL.AfterConstruction;
begin
  inherited;
  exit;
  // richEdit1 of type TRichEdit
  with SQLContainer do
  begin
    // move caret to end
    SelStart := GetTextLen;
    // add one unformatted line
    SelText := 'This is the first line' + #13#10;
    // add some normal font text
    SelText := 'Formatted lines in RichEdit' + #13#10;
    // bigger text
    SelAttributes.Size := 13;
    // add bold + red
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := clRed;
    SelText := 'About';
    // only bold
    SelAttributes.Color := clWindowText;
    SelText := ' Delphi ';
    // add italic + blue
    SelAttributes.Style := [fsItalic];
    SelAttributes.Color := clBlue;
    SelText := 'Programming';
    // new line
    SelText := #13#10;
    // add normal again
    SelAttributes.Size := 8;
    SelAttributes.Color := clGreen;
    SelText := 'think of AddFormattedLine custom procedure...';
  end;
end;

procedure TfrmSQL.MarcarTextoComErro(const ASQLComErro: string);
var
  _encontradoEm: integer;
  _tamanhoSelecao: integer;
begin
  _tamanhoSelecao := TextoSQL.Length;

  if SQLContainer.SelStart = _tamanhoSelecao then
    SQLContainer.SelStart := 0;

  _tamanhoSelecao := _tamanhoSelecao - SQLContainer.SelStart;

  _encontradoEm := SQLContainer.FindText(ASQLComErro, SQLContainer.SelStart, _tamanhoSelecao,
    [stWholeWord, stMatchCase]);

  if _encontradoEm = -1 then
    exit;

  MarcarTextoComErro(_encontradoEm, ASQLComErro.Length);
end;

procedure TfrmSQL.LimparFormatacao;
var
  _tmpInicioSelecao: integer;
  _tmpTamanhoSelecao: integer;
begin
  _tmpInicioSelecao := SQLContainer.SelStart;
  _tmpTamanhoSelecao := SQLContainer.SelLength;

  SQLContainer.SelectAll;
  SQLContainer.SelAttributes.Style := [];
  SQLContainer.SelAttributes.Color := clWindowText;

  SQLContainer.SelStart := _tmpInicioSelecao;
  SQLContainer.SelLength := _tmpTamanhoSelecao;
end;

procedure TfrmSQL.MarcarSelecaoComErro;
begin
  LimparFormatacao;

  if SQLContainer.SelText.Trim.IsEmpty then
    exit;

  SQLContainer.SelAttributes.Style := [fsBold];
  SQLContainer.SelAttributes.Color := clRed;
end;

procedure TfrmSQL.MarcarTextoComErro(const AInicioSelecao, ATamanhoSelecao: integer);
begin
  SQLContainer.SelStart := AInicioSelecao;
  SQLContainer.SelLength := ATamanhoSelecao;
  MarcarSelecaoComErro;
  SQLContainer.SelLength := 0;
end;

function TfrmSQL.TextoSQL: string;
var
  _sqlRetornado: string;
begin
  _sqlRetornado := SQLContainer.SelText;
  if _sqlRetornado.Trim.IsEmpty then
    _sqlRetornado := SQLContainer.Text;

  result := _sqlRetornado;
end;

end.
