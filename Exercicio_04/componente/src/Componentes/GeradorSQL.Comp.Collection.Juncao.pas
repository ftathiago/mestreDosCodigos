unit GeradorSQL.Comp.Collection.Juncao;

interface

uses
  System.Classes,
  System.SysUtils,
  SQL.Enums,
  GeradorSQL.Comp.SQLDTO,
  GeradorSQL.Comp.Collection.Tabela,
  GeradorSQL.Comp.Collection.Condicao;

type
  TJuncaoCollection = class;
  TJuncaoCollectionItem = class;

  TJuncaoCollectionItem = class(TSQLDTOCollectionItem)
  private
    FTabela: TTabela;
    FTipoJuncao: TTipoJuncao;
    FCondicao: TCondicaoCollection;
    procedure SetTabela(const Value: TTabela);
    procedure SetTipoJuncao(const Value: TTipoJuncao);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property TipoJuncao: TTipoJuncao read FTipoJuncao write SetTipoJuncao default tjInnerJoin;
    property Tabela: TTabela read FTabela write SetTabela;
    property Condicao: TCondicaoCollection read FCondicao write FCondicao;
  end;

  TJuncaoCollection = class(TOwnedCollection)
  protected
    function GetItem(Index: Integer): TJuncaoCollectionItem;
    procedure SetItem(Index: Integer; Value: TJuncaoCollectionItem);
  public
    constructor Create(AOwner: TPersistent);
    property Items[Index: Integer]: TJuncaoCollectionItem read GetItem write SetItem;
  end;

implementation

{ TJuncaoCollectionItem }

procedure TJuncaoCollectionItem.Assign(Source: TPersistent);
var
  _source: TJuncaoCollectionItem;
begin
  inherited;
  _source := TJuncaoCollectionItem(Source);
  FTabela := _source.Tabela;
  FTipoJuncao := _source.FTipoJuncao;
  FCondicao.Assign(_source.Condicao);
end;

constructor TJuncaoCollectionItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FCondicao := TCondicaoCollection.Create(Collection.Owner);
  FTabela := TTabela.Create;
  FTipoJuncao := tjInnerJoin;
end;

destructor TJuncaoCollectionItem.Destroy;
begin
  FCondicao.Clear;

  FreeAndNil(FTabela);
  FreeAndNil(FCondicao);
  inherited;
end;

procedure TJuncaoCollectionItem.SetTabela(const Value: TTabela);
begin
  FTabela := Value;
end;

procedure TJuncaoCollectionItem.SetTipoJuncao(const Value: TTipoJuncao);
begin
  FTipoJuncao := Value;
end;

{ TJuncaoCollection }

constructor TJuncaoCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TJuncaoCollectionItem);
end;

function TJuncaoCollection.GetItem(Index: Integer): TJuncaoCollectionItem;
begin
  result := (inherited GetItem(Index)) as TJuncaoCollectionItem;
end;

procedure TJuncaoCollection.SetItem(Index: Integer; Value: TJuncaoCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

end.
