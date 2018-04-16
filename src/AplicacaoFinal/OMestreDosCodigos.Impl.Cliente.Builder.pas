unit OMestreDosCodigos.Impl.Cliente.Builder;

interface

uses
  DesignPattern.Builder.Impl.Builder,
  DesignPattern.Builder.Intf.Builder,
  OMestreDosCodigos.Intf.Cliente.Builder,
  OMestreDosCodigos.Intf.Cliente;

type
  TClienteBuilder = class(TBuilder<ICliente>, IClienteBuilder)
    FNome: string;
    FDataNascimento: TDateTime;
    FTelefone: string;
    FEmail: string;
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FCEP: string;
    FBairro: string;
    FUF: string;
    FCidade: string;
  public
    class function New: IClienteBuilder;
    function Logradouro(const ALogradouro: string): IClienteBuilder;
    function Numero(const ANumero: string): IClienteBuilder;
    function Bairro(const ABairro: string): IClienteBuilder;
    function CEP(const ACEP: string): IClienteBuilder;
    function Complemento(const AComplemento: string): IClienteBuilder;
    function UF(const AUF: string): IClienteBuilder;
    function Cidade(const ACidade: string): IClienteBuilder;
    function DataNascimento(const Value: TDateTime): IClienteBuilder;
    function Email(const Value: string): IClienteBuilder;
    function Nome(const ANome: string): IClienteBuilder;
    function Telefone(const ATelefone: string): IClienteBuilder;
    procedure ConstruirNovaInstancia; override;
  end;

implementation

uses
  OMestreDosCodigos.Impl.Cliente,
  pkgUtils.Intf.Endereco,
  pkgUtils.Impl.Endereco,
  pkgUtils.Intf.Email,
  pkgUtils.Impl.Email,
  pkgUtils.Intf.Telefone,
  pkgUtils.Impl.Telefone;

{ TClienteBuilder }

class function TClienteBuilder.New: IClienteBuilder;
begin
  result := Create;
end;

procedure TClienteBuilder.ConstruirNovaInstancia;
begin
  inherited;
  FObjeto := TCliente.New(
    FNome,
    TEndereco.New(
      FLogradouro,
      FNumero,
      FComplemento,
      FCEP,
      FBairro,
      FCidade,
      FUF),
    TEmail.New(FEmail),
    TTelefone.New(FTelefone),
    FDataNascimento);
end;

function TClienteBuilder.Bairro(const ABairro: string): IClienteBuilder;
begin
  FBairro := ABairro;
  result := self;
end;

function TClienteBuilder.CEP(const ACEP: string): IClienteBuilder;
begin
  FCEP := ACEP;
  result := self;
end;

function TClienteBuilder.Cidade(const ACidade: string): IClienteBuilder;
begin
  FCidade := ACidade;
  result := self;
end;

function TClienteBuilder.Complemento(const AComplemento: string): IClienteBuilder;
begin
  FComplemento := AComplemento;
  result := self;
end;

function TClienteBuilder.DataNascimento(const Value: TDateTime): IClienteBuilder;
begin
  FDataNascimento := Value;
  result := self;
end;

function TClienteBuilder.Email(const Value: string): IClienteBuilder;
begin
  FEmail := Value;
  result := self;
end;

function TClienteBuilder.Logradouro(const ALogradouro: string): IClienteBuilder;
begin
  FLogradouro := ALogradouro;
  result := self;
end;

function TClienteBuilder.Nome(const ANome: string): IClienteBuilder;
begin
  FNome := ANome;
  result := self;
end;

function TClienteBuilder.Numero(const ANumero: string): IClienteBuilder;
begin
  FNumero := ANumero;
  result := self;
end;

function TClienteBuilder.Telefone(const ATelefone: string): IClienteBuilder;
begin
  FTelefone := ATelefone;
  result := self;
end;

function TClienteBuilder.UF(const AUF: string): IClienteBuilder;
begin
  FUF := AUF;
  result := self;
end;

end.
