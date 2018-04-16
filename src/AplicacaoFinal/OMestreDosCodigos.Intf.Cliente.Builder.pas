unit OMestreDosCodigos.Intf.Cliente.Builder;

interface

uses
  DesignPattern.Builder.Impl.Builder,
  DesignPattern.Builder.Intf.Builder,
  OMestreDosCodigos.Intf.Cliente;

type
  IClienteBuilder = Interface(IBuilder<ICliente>)
    function Logradouro(const ALogradouro: string): IClienteBuilder;
    function Numero(const ANumero: string): IClienteBuilder;
    function Bairro(const ABairro: string): IClienteBuilder;
    function CEP(const ACEP: string): IClienteBuilder;
    function UF(const AUF: string): IClienteBuilder;
    function Cidade(const ACidade: string):IClienteBuilder;
    function Complemento(const AComplemento: string): IClienteBuilder;
    function DataNascimento(const Value: TDateTime): IClienteBuilder;
    function Email(const Value: string): IClienteBuilder;
    function Nome(const ANome: string): IClienteBuilder;
    function Telefone(const ATelefone: string): IClienteBuilder;
  end;

implementation

end.
