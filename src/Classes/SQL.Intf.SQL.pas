unit SQL.Intf.SQL;

interface

uses
  System.SysUtils,
  SQL.Enums;

type
  ISQL = interface(IInterface)
    function setTextoSQL(const Texto: string): ISQL;
    function setSQL(const ASQL: ISQL): ISQL;
    function ToString: string;
    procedure SaveToFile(const FileName: TFileName);
  end;

implementation

end.
