unit SQL.Intf.Director;

interface

type
  IDirector<Builder, ObjetoSQL> = interface(IInterface)
    ['{15286B75-18B5-4A9D-B839-11E02BDAF6CE}']
    procedure setBuilder(const ABuilder: Builder);
    procedure Construir;
    function getObjetoPronto: ObjetoSQL;
  end;

implementation

end.
