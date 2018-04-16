unit OMestreDosCodigos.Impl.Cliente;

interface

uses
  OMestreDosCodigos.Intf.Cliente,
  pkgUtils.Intf.Email,
  pkgUtils.Intf.Endereco,
  pkgUtils.Intf.Telefone,
  pkgUtils.Intf.ListaRetornoValidacao;

type
  TCliente = class(TInterfacedObject, ICliente)
  private
    FNome: string;
    FDataNascimento: TDateTime;
    FEndereco: IEndereco;
    FTelefone: ITelefone;
    FEmail: IEmail;
    function ValidarRequeridos(const RetornoValidacao: IListaRetornoValidacao): boolean;
  public
    class function New(const ANome: string; const AEndereco: IEndereco; const AEmail: IEmail;
      const ATelefone: ITelefone; const ADataNascimento: TDateTime): ICliente;
    constructor Create(const ANome: string; const AEndereco: IEndereco; const AEmail: IEmail;
      const ATelefone: ITelefone; const ADataNascimento: TDateTime);
    procedure ModificarNome(const ANome: string);
    procedure ModificarEndereco(const AEndereco: IEndereco);
    procedure ModificarDataNascimento(const ADataNascimento: TDateTime);
    procedure ModificarEmail(const AEmail: IEmail);
    procedure ModificarTelefone(const ATelefone: ITelefone);
    function getNome: string;
    function getDataNascimeto: TDateTime;
    function getEndereco: IEndereco;
    function getTelefone: ITelefone;
    function getEmail: IEmail;
    function Validar(const RetornoValidacao: IListaRetornoValidacao): boolean;
  end;

implementation

uses
  System.SysUtils;

{ TCliente }

class function TCliente.New(const ANome: string; const AEndereco: IEndereco; const AEmail: IEmail;
  const ATelefone: ITelefone; const ADataNascimento: TDateTime): ICliente;
begin
  result := Create(ANome, AEndereco, AEmail, ATelefone, ADataNascimento);
end;

constructor TCliente.Create(const ANome: string; const AEndereco: IEndereco; const AEmail: IEmail;
  const ATelefone: ITelefone; const ADataNascimento: TDateTime);
begin
  inherited Create;
  FNome := ANome;
  FTelefone := ATelefone;
  FEndereco := AEndereco;
  FDataNascimento := ADataNascimento;
  FEmail := AEmail;
end;

function TCliente.getDataNascimeto: TDateTime;
begin
  result := FDataNascimento;
end;

function TCliente.getEmail: IEmail;
begin
  result := FEmail;
end;

function TCliente.getEndereco: IEndereco;
begin
  result := FEndereco;
end;

function TCliente.getNome: string;
begin
  result := FNome;
end;

function TCliente.getTelefone: ITelefone;
begin
  result := FTelefone;
end;

procedure TCliente.ModificarDataNascimento(const ADataNascimento: TDateTime);
begin
  FDataNascimento := ADataNascimento;
end;

procedure TCliente.ModificarEmail(const AEmail: IEmail);
begin
  FEmail := AEmail;
end;

procedure TCliente.ModificarEndereco(const AEndereco: IEndereco);
begin
  FEndereco := AEndereco;
end;

procedure TCliente.ModificarNome(const ANome: string);
begin
  FNome := ANome;
end;

procedure TCliente.ModificarTelefone(const ATelefone: ITelefone);
begin
  FTelefone := ATelefone;
end;

function TCliente.Validar(const RetornoValidacao: IListaRetornoValidacao): boolean;
begin
  result := False;

  if not ValidarRequeridos(RetornoValidacao) then
    exit;

  if not FEndereco.Validar(RetornoValidacao) then
    exit;

  if not FTelefone.Validar(RetornoValidacao) then
    exit;

  if not FEmail.Validar(RetornoValidacao) then
    exit;

  result := True;
end;

function TCliente.ValidarRequeridos(const RetornoValidacao: IListaRetornoValidacao): boolean;
var
  _retorno: TRetornoValidacao;
begin
  result := False;

  if FNome.Trim.IsEmpty then
  begin
    _retorno.CodigoRetorno := -1;
    _retorno.MensagemDeErro := 'O campo "Nome" é obrigatório';
    RetornoValidacao.AdicionarRetorno(_retorno);
    exit;
  end;

  result := True;
end;

end.
