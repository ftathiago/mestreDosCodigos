unit DDD.Core.Intf.Agregado;

interface

uses
  DDD.Core.Intf.ID, DDD.Core.Intf.Entidade;

type
  IAgregado<T: IEntidade> = interface(IInterface)
    ['{2D319C48-A728-43F0-8653-E80651BA5AAF}']
    procedure Incluir(const AEntidade: T);
    procedure Apagar(const AEntidade: T);
    function Localizar(const AID: IID): T;
    function NovoID: IID;
    function RegistroAtual: T;
  end;

implementation

end.
