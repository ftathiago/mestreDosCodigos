unit pkgUtils.Intf.Endereco;

interface

uses
  pkgUtils.Intf.Validavel;

type
  IEndereco = Interface(IValidavel)
    function getLogradouro: string;
    function getNumero: string;
    function getBairro: string;
    function getCEP: string;
    function getComplemento: string;
    function getCidade:string;
    function getUF: string;
    procedure ModificarLogradouro(const ALogradouro: string);
    procedure ModificarNumero(const ANumero: string);
    procedure ModificarBairro(const ABairro: string);
    procedure ModificarCEP(const ACEP: string);
    procedure ModificarComplemento(const AComplemento: string);
    procedure ModificarCidade(const ACidade: string);
    procedure ModificarUF(const AUF: string);
    property Logradouro: string read getLogradouro write ModificarLogradouro;
    property Numero: string read getNumero write ModificarNumero;
    property Bairro: string read getBairro write ModificarBairro;
    property CEP: string read getCEP write ModificarCEP;
    property Complemento: string read getComplemento write ModificarComplemento;
    property Cidade: string read getCidade write ModificarCidade;
    property UF: string read getUF write ModificarUF;
  end;


implementation

end.
