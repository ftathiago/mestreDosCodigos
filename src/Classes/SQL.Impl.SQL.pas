unit SQL.Impl.SQL;

interface

uses
  System.SysUtils,
  SQL.Intf.SQL;

type
  TSQL = class(TInterfacedObject, ISQL)
  public
    function ToString: string; reintroduce; virtual; abstract;
    procedure SaveToFile(const FileName: TFileName);
  end;

implementation

uses
  System.Classes;

{ TSQL }

procedure TSQL.SaveToFile(const FileName: TFileName);
var
  _strings: TStrings;
begin
  _strings := TStringList.Create;
  try
    _strings.add(ToString);
    _strings.SaveToFile(FileName);
  finally
    _strings.Free;
  end;
end;

end.
