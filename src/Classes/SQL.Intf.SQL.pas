unit SQL.Intf.SQL;

interface

uses
  SQL.Enums;

type
  ISQL = interface(IInterface)
    function ToString: string;
  end;

implementation

end.
