unit pkgUtils.Impl.Telefone;

interface

uses
  pkgUtils.Intf.ListaRetornoValidacao,
  pkgUtils.Intf.Telefone;

type
  TTelefone = class(TInterfacedObject, ITelefone)
  private
    FDDD: string;
    FTelefone: string;
    FEhValido: boolean;
    function ExtrairDDD(const Numero: string): string;
    function ExtrairTelefone(const Numero: string): string;
  public
    class function New(const TelefoneComDDD: string): ITelefone;
    constructor Create(const TelefoneComDDD: string);
    function getDDD: string;
    function getTelefone: string;
    function getTelefoneCompleto: string;
    function EhValido: boolean;
    function Validar(const RetornoValidacao: IListaRetornoValidacao):boolean;
  end;

implementation

{ TTelefone }

uses
  System.SysUtils,
  System.RegularExpressions,
  pkgUtils.Impl.ListaRetornoValidacao;

const
  TAMANHO_DDD = 2;
  TAMANHO_TELEFONE_SEM_DDD = 9;
  TAMANHO_TELEFONE = TAMANHO_DDD + TAMANHO_TELEFONE_SEM_DDD;

function TTelefone.EhValido: boolean;
begin
  result := FEhValido;
end;

function TTelefone.ExtrairDDD(const Numero: string): string;
var
  _deveExtrairDDD: boolean;
begin
  result := EmptyStr;

  _deveExtrairDDD := (Numero.Length = TAMANHO_TELEFONE);

  if _deveExtrairDDD then
    result := Numero.Substring(0, TAMANHO_DDD);
end;

function TTelefone.ExtrairTelefone(const Numero: string): string;
var
  _semDDD: boolean;
  _tamanhoNumero: integer;
begin
  _tamanhoNumero := Numero.Length;
  _semDDD := (_tamanhoNumero <> TAMANHO_TELEFONE) and (_tamanhoNumero <> TAMANHO_DDD);

  result := EmptyStr;

  if not _semDDD then
  begin
    result := Numero.Substring(Numero.Length - TAMANHO_TELEFONE_SEM_DDD);
    exit;
  end;

  result := Numero;
end;

function TTelefone.getDDD: string;
begin
  result := FDDD;
end;

function TTelefone.getTelefone: string;
begin
  result := FTelefone;
end;

function TTelefone.getTelefoneCompleto: string;
begin
  result := Format('%s%s', [FDDD, FTelefone]);
end;

class function TTelefone.New(const TelefoneComDDD: string): ITelefone;
begin
  result := Create(TelefoneComDDD);
end;

function TTelefone.Validar(const RetornoValidacao: IListaRetornoValidacao): boolean;
const
  TEL_REGEX = '(11[9][0-9]{4}[0-9]{4})|(1[2-9][5-9][0-9]{3}[0-9]{4})|([2-9][1-9][5-9][0-9]{3}[0-9]{4})';
var
  _retornoValidacao: TRetornoValidacao;
begin
  FEhValido := TRegEx.IsMatch(getTelefoneCompleto, TEL_REGEX);
  if not FEhValido then
  begin
    _retornoValidacao.CodigoRetorno := 1;
    _retornoValidacao.MensagemDeErro := 'Telefone incompleto ou inválido!';
    RetornoValidacao.AdicionarRetorno(_retornoValidacao);
  end;

  result :=  FEhValido;
end;

constructor TTelefone.Create(const TelefoneComDDD: string);
begin
  FEhValido := False;
  FDDD := ExtrairDDD(TelefoneComDDD);
  FTelefone := ExtrairTelefone(TelefoneComDDD);
end;

end.
