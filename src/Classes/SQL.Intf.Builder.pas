unit SQL.Intf.Builder;

interface

type
  IBuilder<T> = interface(IInterface)
    ['{5D20996A-F678-4288-8D59-7F5CBA3305A1}']
    procedure ConstruirNovaInstancia;
    function getObjeto: T;
  end;

implementation

end.
