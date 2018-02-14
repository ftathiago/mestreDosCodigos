unit SQL.Impl.SQL;

interface

uses
  System.SysUtils,
  SQL.Intf.SQL;

type
  TSQL = class(TInterfacedObject, ISQL)
  protected
    FTexto: string;
    procedure ConstruirSQL; virtual;
  public
    constructor Create;
    function ToString: string; override;
    procedure SaveToFile(const FileName: TFileName);
    procedure setSQL(const Texto: string); virtual;
  end;

implementation

uses
  System.Classes;

{ TSQL }

procedure TSQL.ConstruirSQL;
begin

end;

constructor TSQL.Create;
begin
  FTexto := EmptyStr;
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
    _strings.Free;
  end;
end;

procedure TSQL.setSQL(const Texto: string);
begin
  FTexto := Texto;
end;

function TSQL.ToString: string;
begin
  ConstruirSQL;

  result := FTexto.Trim;
end;

end.
