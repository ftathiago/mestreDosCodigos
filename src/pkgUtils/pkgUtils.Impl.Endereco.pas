unit pkgUtils.Impl.Endereco;

interface

uses
  pkgUtils.Intf.ListaRetornoValidacao,
  pkgUtils.Intf.Endereco;

type
  TEndereco = class(TInterfacedObject, IEndereco)
  private
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FCEP: string;
    FBairro: string;
    FCidade: string;
    FUF: string;
    function ValidarLogradouro(const RetornoValidacao: IListaRetornoValidacao): boolean;
    function ValidarNumero(const RetornoValidacao: IListaRetornoValidacao): boolean;
    function ValidarCEP(const RetornoValidacao: IListaRetornoValidacao): boolean;
    function ValidarUF(const RetornoValidcacao: IListaRetornoValidacao): boolean;
    function ValidarCidade(const RetornoValidacao: IListaRetornoValidacao): boolean;
  public
    class function New(const ALogradouro, ANumero, AComplemento, ACEP, ABairro, ACidade,
  AUF: string): IEndereco;
    constructor Create(const ALogradouro, ANumero, AComplemento, ACEP, ABairro, ACidade,
  AUF: string);
    procedure ModificarBairro(const ABairro: string);
    procedure ModificarCEP(const ACEP: string);
    procedure ModificarComplemento(const AComplemento: string);
    procedure ModificarLogradouro(const ALogradouro: string);
    procedure ModificarNumero(const ANumero: string);
    procedure ModificarCidade(const ACidade: string);
    procedure ModificarUF(const AUF: string);
    function getBairro: string;
    function getCEP: string;
    function getComplemento: string;
    function getLogradouro: string;
    function getNumero: string;
    function getCidade: string;
    function getUF: string;
    function Validar(const RetornoValidacao: IListaRetornoValidacao): boolean;
  end;

implementation

uses
  System.SysUtils,
  System.RegularExpressions;

{ TEndereco }

class function TEndereco.New(const ALogradouro, ANumero, AComplemento, ACEP, ABairro, ACidade,
  AUF: string): IEndereco;
begin
  result := Create(ALogradouro, ANumero, AComplemento, ACEP, ABairro, ACidade, AUF);
end;

function TEndereco.Validar(const RetornoValidacao: IListaRetornoValidacao): boolean;
begin
  result := False;

  if not ValidarLogradouro(RetornoValidacao) then
    exit;

  if not ValidarNumero(RetornoValidacao) then
    exit;

  if not ValidarUF(RetornoValidacao) then
    exit;

  if not ValidarCidade(RetornoValidacao) then
    exit;

  if not ValidarCEP(RetornoValidacao) then
    exit;

  result := True;
end;

function TEndereco.ValidarCEP(const RetornoValidacao: IListaRetornoValidacao): boolean;
const
  CEP_REGEX = '[0-9]{2}[0-9]{3}[0-9]{3}';
var
  _retornoValidacao: TRetornoValidacao;
begin
  result := TRegEx.IsMatch(FCEP, CEP_REGEX);
  if not result then
  begin
    _retornoValidacao.CodigoRetorno := -1;
    _retornoValidacao.MensagemDeErro := 'O CEP informado está inválido.';
    RetornoValidacao.AdicionarRetorno(_retornoValidacao);
  end;
end;

function TEndereco.ValidarCidade(const RetornoValidacao: IListaRetornoValidacao): boolean;
var
  _retorno: TRetornoValidacao;
begin
  result := not FCidade.Trim.IsEmpty;

  if not result then
  begin
    _retorno.CodigoRetorno := -1;
    _retorno.MensagemDeErro := 'A cidade não foi informada';
    RetornoValidacao.AdicionarRetorno(_retorno);
  end;
end;

function TEndereco.ValidarLogradouro(const RetornoValidacao: IListaRetornoValidacao): boolean;
var
  _retorno: TRetornoValidacao;
begin
  result := not FLogradouro.Trim.IsEmpty;
  if not result then
  begin
    _retorno.CodigoRetorno := 0;
    _retorno.MensagemDeErro := 'O campo Logradouro está vazio';
    RetornoValidacao.AdicionarRetorno(_retorno);
  end;
end;

function TEndereco.ValidarNumero(const RetornoValidacao: IListaRetornoValidacao): boolean;
var
  _retorno: TRetornoValidacao;
begin
  result := not FNumero.Trim.IsEmpty;

  if not result then
  begin
    _retorno.CodigoRetorno := 0;
    _retorno.MensagemDeErro :=
      'Não foi informadoo número da residência.' + #$D#$A +
      'Utilize "S/N" caso que não tenha numeração';
    RetornoValidacao.AdicionarRetorno(_retorno);
  end;
end;

function TEndereco.ValidarUF(const RetornoValidcacao: IListaRetornoValidacao): boolean;
const
  ARRAY_UF: array [0 .. 26] of string = ('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA',
    'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP',
    'SE', 'TO');
  UF_REGEX = '{AC|AL|AP|AM|BA|CE|DF|ES|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RJ|RN|RS|RO|RR|SC|SP|SE|TO}';
var
  _retorno: TRetornoValidacao;
begin
  result := TRegEx.IsMatch(FUF, UF_REGEX);

  if not result then
  begin
    _retorno.CodigoRetorno := -1;
    _retorno.MensagemDeErro := 'A UF digitada está inválida.';
    RetornoValidcacao.AdicionarRetorno(_retorno);
  end;
end;

constructor TEndereco.Create(const ALogradouro, ANumero, AComplemento, ACEP, ABairro, ACidade,
  AUF: string);
begin
  ModificarLogradouro(ALogradouro);
  ModificarNumero(ANumero);
  ModificarComplemento(AComplemento);
  ModificarCEP(ACEP);
  ModificarBairro(ABairro);
  ModificarCidade(ACidade);
  ModificarUF(AUF);
end;

function TEndereco.getBairro: string;
begin
  result := FBairro;
end;

function TEndereco.getCEP: string;
begin
  result := FCEP;
end;

function TEndereco.getCidade: string;
begin
  result := FCidade;
end;

function TEndereco.getComplemento: string;
begin
  result := FComplemento;
end;

function TEndereco.getLogradouro: string;
begin
  result := FLogradouro;
end;

function TEndereco.getNumero: string;
begin
  result := FNumero;
end;

function TEndereco.getUF: string;
begin

end;

procedure TEndereco.ModificarBairro(const ABairro: string);
begin
  FBairro := ABairro;
end;

procedure TEndereco.ModificarCEP(const ACEP: string);
begin
  FCEP := ACEP;
end;

procedure TEndereco.ModificarCidade(const ACidade: string);
begin
  FCidade := ACidade;
end;

procedure TEndereco.ModificarComplemento(const AComplemento: string);
begin
  FComplemento := AComplemento;
end;

procedure TEndereco.ModificarLogradouro(const ALogradouro: string);
begin
  FLogradouro := ALogradouro;
end;

procedure TEndereco.ModificarNumero(const ANumero: string);
begin
  FNumero := ANumero;
end;

procedure TEndereco.ModificarUF(const AUF: string);
begin
  FUF := AUF;
end;

end.
