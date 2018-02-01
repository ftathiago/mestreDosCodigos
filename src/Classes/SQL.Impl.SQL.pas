unit SQL.Impl.SQL;

interface

uses
  SQL.Intf.SQL;

type
  TSQL = class(TInterfacedObject, ISQL)
  public
    function ToString: string; reintroduce; virtual; abstract;
  end;

implementation

{ TSQL }

end.
