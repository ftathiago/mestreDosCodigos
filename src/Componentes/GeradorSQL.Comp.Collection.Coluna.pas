unit GeradorSQL.Comp.Collection.Coluna;

interface

uses
  System.Classes,
  GeradorSQL.Comp.Collection.Tabela;

type
  TColuna = class;
  TColunaCollection = class;
  TColunaCollectionItem = class;

  TColuna = class(TPersistent)
  private
    FNomeVirtual: string;
    FNome: string;
    FTabela: TTabela;
    procedure SetNome(const Value: string);
    procedure SetNomeVirtual(const Value: string);
    procedure SetTabela(const Value: TTabela);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Tabela: TTabela read FTabela write SetTabela;
    property Nome: string read FNome write SetNome;
    property NomeVirtual: string read FNomeVirtual write SetNomeVirtual;
  end;

  TColunaCollection = class(TOwnedCollection)
  protected
    function GetItem(Index: Integer): TColunaCollectionItem;
    procedure SetItem(Index: Integer; Value: TColunaCollectionItem);
  public
    constructor Create(AOwner: TPersistent);
    property Items[Index: Integer]: TColunaCollectionItem read GetItem write SetItem;
  end;

  TColunaCollectionItem = class(TCollectionItem)
  private
    FColuna: TColuna;
    procedure SetColuna(const Value: TColuna);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Coluna: TColuna read FColuna write SetColuna;
  end;

implementation

uses
  System.SysUtils;

{ TColunaCollectionItem }

constructor TColunaCollectionItem.Create(Collection: TCollection);
begin
  inherited;
  FColuna := TColuna.Create;
end;

destructor TColunaCollectionItem.Destroy;
begin
  FreeAndNil(FColuna);
  inherited;
end;

procedure TColunaCollectionItem.SetColuna(const Value: TColuna);
begin
  FColuna := Value;
end;

{ TColunaCollection }

constructor TColunaCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TColunaCollectionItem);
end;

function TColunaCollection.GetItem(Index: Integer): TColunaCollectionItem;
begin
  result := (inherited GetItem(Index)) as TColunaCollectionItem;
end;

procedure TColunaCollection.SetItem(Index: Integer; Value: TColunaCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TColuna }

constructor TColuna.Create();
begin
  inherited;
  FTabela := TTabela.Create;
end;

destructor TColuna.Destroy;
begin
  FTabela.Free;
  inherited;
end;

procedure TColuna.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TColuna.SetNomeVirtual(const Value: string);
begin
  FNomeVirtual := Value;
end;

procedure TColuna.SetTabela(const Value: TTabela);
begin
  FTabela := Value;
end;

end.
