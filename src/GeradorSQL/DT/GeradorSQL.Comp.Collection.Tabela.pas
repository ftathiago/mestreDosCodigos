unit GeradorSQL.Comp.Collection.Tabela;

interface

uses
  System.Classes,
  GeradorSQL.Comp.SQLDTO;

type
  TTabela = class;
  TTabelaCollection = class;
  TTabelaCollectionItem = class;

  TTabela = class(TSQLDTO)
  private
    FAlias: string;
    FNome: string;
    procedure SetAlias(const Value: string);
    procedure SetNome(const Value: string);
  published
    property Nome: string read FNome write SetNome;
    property Alias: string read FAlias write SetAlias;
  end;

  TTabelaCollection = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TTabelaCollectionItem;
    procedure SetItem(Index: Integer; Value: TTabelaCollectionItem);
  public
    constructor Create(AOwner: TPersistent);
    property Items[Index: Integer]: TTabelaCollectionItem read GetItem write SetItem;
  end;

  TTabelaCollectionItem = class(TCollectionItem)
  private
    FTabela: TTabela;
    procedure SetTabela(const Value: TTabela);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Tabela: TTabela read FTabela write SetTabela;
  end;

implementation

{ TTabelaCollectionItem }

procedure TTabelaCollectionItem.Assign(Source: TPersistent);
var
  _source: TTabelaCollectionItem;
begin
  inherited;
  _source := (Source as TTabelaCollectionItem);
  FTabela := _source.Tabela;
end;

constructor TTabelaCollectionItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TTabelaCollectionItem.Destroy;
begin

  inherited;
end;

procedure TTabelaCollectionItem.SetTabela(const Value: TTabela);
begin
  FTabela := Value;
end;

{ TTabela }

procedure TTabela.SetAlias(const Value: string);
begin
  FAlias := Value;
end;

procedure TTabela.SetNome(const Value: string);
begin
  FNome := Value;
end;

{ TTabelaCollection }

constructor TTabelaCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TTabelaCollectionItem);
end;

function TTabelaCollection.GetItem(Index: Integer): TTabelaCollectionItem;
begin
  result := (inherited GetItem(Index)) as TTabelaCollectionItem;
end;

procedure TTabelaCollection.SetItem(Index: Integer; Value: TTabelaCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

end.
