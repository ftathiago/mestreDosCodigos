unit OMestreDosCodigos.Intf.Cliente.ListaArrayDinamico;

interface

uses
  System.SysUtils;

type
  TTipoAlteracao = (taUnknow, taAdicionar, taAlterar, taRemover);
  TNotificarMudanca = procedure(const TipoAlteracao: TTipoAlteracao) of object;

  IListaArrayDinamico<T> = Interface(IInterface)
    ['{03E6135A-AF47-4B9F-9E46-EEAA71675389}']
    procedure AdicionarArray(const NovoArray: Array of T);
    procedure Adicionar(const Item: T);
    procedure Remover(const Index: integer);
    procedure Alterar(const Index: integer; const NovoItem: T);
    procedure setNotificarMudanca(const AProc: TNotificarMudanca);
    function Retornar(const Index: integer): T;
    function getTamanho: integer;
    function getNotificarMudanca: TNotificarMudanca;
    function TestarEstaVazio: boolean;
    property Tamanho: integer read getTamanho;
    property NoficarMudanca: TNotificarMudanca read getNotificarMudanca write setNotificarMudanca;
    property EstaVazio: boolean read TestarEstaVazio;
  end;

implementation

end.
