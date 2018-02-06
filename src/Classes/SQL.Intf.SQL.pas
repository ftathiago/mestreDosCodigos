unit SQL.Intf.SQL;

interface

uses
  System.SysUtils,
  SQL.Enums;

type
  ISQL = interface(IInterface)
    function ToString: string;
    procedure SaveToFile(const FileName: TFileName);
  end;

implementation

end.
