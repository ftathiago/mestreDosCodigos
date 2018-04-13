unit uICliente;

interface

type
  ICliente = Interface(IInterface)

    property Nome: string read getNome write setNome;
    property DataNascimento: TDateTime read getDataNascimeto write setDataNascimento;
    property Endereco: string;
    property Cidade: string;
    property Email: string;
    property Telefone: string;
  end;

implementation

end.
