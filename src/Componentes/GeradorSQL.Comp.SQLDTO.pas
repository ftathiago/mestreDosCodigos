unit GeradorSQL.Comp.SQLDTO;

interface

uses
  System.Classes;

type
  TSQLDTO = class(TPersistent)
  private
    FSQLTexto: TStrings;
    procedure SetSQLTexto(const Value: TStrings);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property SQLTexto: TStrings read FSQLTexto write SetSQLTexto;
  end;

  TSQLDTOCollectionItem = class(TCollectionItem)
  private
    FSQLTexto: TStrings;
    procedure SetSQLTexto(const Value: TStrings);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property SQLTexto: TStrings read FSQLTexto write SetSQLTexto;
  end;

implementation

uses System.SysUtils;

{ TSQLDTO }

constructor TSQLDTO.Create;
begin
  inherited;
  FSQLTexto := TStringList.Create;
end;

destructor TSQLDTO.Destroy;
begin
  FSQLTexto.Clear;
  FreeAndNil(FSQLTexto);
  inherited;
end;

procedure TSQLDTO.SetSQLTexto(const Value: TStrings);
begin
  FSQLTexto := Value;
end;

{ TSQLDTOCollectionItem }

constructor TSQLDTOCollectionItem.Create(Collection: TCollection);
begin
  inherited;
  FSQLTexto := TStringList.Create;
end;

destructor TSQLDTOCollectionItem.Destroy;
begin
  FSQLTexto.Clear;
  FreeAndNil(FSQLTexto);
  inherited;
end;

procedure TSQLDTOCollectionItem.SetSQLTexto(const Value: TStrings);
begin
  FSQLTexto := Value;
end;

end.
