unit SQL.Impl.SQL;

interface

uses
  System.SysUtils,
  SQL.Intf.SQL;

type
  TSQL = class(TInterfacedObject, ISQL)
  protected
    FTextoSetado: string;
    FTexto: string;
    FSQL: ISQL;
    procedure ConstruirSQL; virtual; abstract;
  public
    constructor Create; virtual;
    class function New: ISQL;
    function setTextoSQL(const Texto: string): ISQL;
    function setSQL(const ASQL: ISQL): ISQL;
    function ToString: string; override;
    procedure SaveToFile(const FileName: TFileName);
  end;

implementation

uses
  System.Classes;

{ TSQL }

constructor TSQL.Create;
begin
  inherited Create;
  FTextoSetado := EmptyStr;
  FTexto := EmptyStr;
  FSQL := nil;
end;

class function TSQL.New: ISQL;
begin
  result := Create;
end;

procedure TSQL.SaveToFile(const FileName: TFileName);
var
  _strings: TStrings;
begin
  _strings := TStringList.Create;
  try
    _strings.add(ToString);
    _strings.SaveToFile(FileName);
  finally
    FreeAndNil(_strings);
  end;
end;

function TSQL.setSQL(const ASQL: ISQL): ISQL;
begin
  result := self;

  FSQL := ASQL;
end;

function TSQL.setTextoSQL(const Texto: string): ISQL;
begin
  FTextoSetado := Texto;
end;

function TSQL.ToString: string;
begin
  FTexto := FTextoSetado.Trim;

  if Assigned(FSQL) then
    FTexto := FSQL.ToString;

  if FTexto.IsEmpty then
    ConstruirSQL;

  result := FTexto.Trim;
end;

end.
