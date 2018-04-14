unit uICliente;

interface

uses
  pkgUtils.Intf.Validavel,
  pkgUtils.Intf.Endereco,
  pkgUtils.Intf.Email,
  pkgUtils.Intf.Telefone;

type
  ICliente = Interface(IValidavel)
    function getDataNascimeto: TDateTime;
    function getEmail: IEmail;
    function getEndereco: IEndereco;
    function getNome: string;
    function getTelefone: ITelefone;
    procedure ModificarDataNascimento(const Value: TDateTime);
    procedure ModificarEmail(const Value: IEmail);
    procedure ModificarEndereco(const Value: IEndereco);
    procedure ModificarNome(const Value: string);
    procedure ModificarTelefone(const Value: ITelefone);
    property Nome: string read getNome write ModificarNome;
    property DataNascimento: TDateTime read getDataNascimeto write ModificarDataNascimento;
    property Endereco: IEndereco read getEndereco write ModificarEndereco;
    property Email: IEmail read getEmail write ModificarEmail;
    property Telefone: ITelefone read getTelefone write ModificarTelefone;
  end;

implementation

end.
