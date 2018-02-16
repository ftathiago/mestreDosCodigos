unit GeradorSQL.Comp.Collection.Condicao;

interface

uses
  System.Classes,
  System.SysUtils,
  SQL.Enums,
  GeradorSQL.Comp.SQLDTO,
  GeradorSQL.Comp.Collection.Coluna;

type
  TCondicao = class;
  TCondicaoCollection = class;
  TCondicaoCollectionItem = class;

  TCondicao = class(TSQLDTO)
  private
    FOperadorComparacao: TOperadorComparacao;
    FValor: String;
    FOperadorLogico: TOperadorLogico;
    FColuna: TColuna;
    procedure SetOperadorComparacao(const Value: TOperadorComparacao);
    procedure SetOperadorLogico(const Value: TOperadorLogico);
    procedure SetValor(const Value: String);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property OperadorLogico: TOperadorLogico read FOperadorLogico write SetOperadorLogico
      Default olAnd;
    property Coluna: TColuna read FColuna write FColuna;
    property OperadorComparacao: TOperadorComparacao read FOperadorComparacao
      write SetOperadorComparacao Default ocIgual;
    property Valor: String read FValor write SetValor;
  end;

  TCondicaoCollection = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TCondicaoCollectionItem;
    procedure SetItem(Index: Integer; Value: TCondicaoCollectionItem);
  public
    constructor Create(AOwner: TPersistent);
    property Items[Index: Integer]: TCondicaoCollectionItem read GetItem write SetItem;
  end;

  TCondicaoCollectionItem = class(TCollectionItem)
  private
    FCondicao: TCondicao;
    procedure SetCondicao(const Value: TCondicao);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Condicao: TCondicao read FCondicao write SetCondicao;
  end;

implementation

{ TCondicao }

constructor TCondicao.Create;
begin
  inherited;
  FColuna := TColuna.Create;
  FOperadorComparacao := ocIgual;
  FOperadorLogico := olAnd;
end;

destructor TCondicao.Destroy;
begin
  FreeAndNil(FColuna);
  inherited;
end;

procedure TCondicao.SetOperadorComparacao(const Value: TOperadorComparacao);
begin
  FOperadorComparacao := Value;
end;

procedure TCondicao.SetOperadorLogico(const Value: TOperadorLogico);
begin
  FOperadorLogico := Value;
end;

procedure TCondicao.SetValor(const Value: String);
begin
  FValor := Value;
end;

{ TCondicaoCollectionItem }

constructor TCondicaoCollectionItem.Create(Collection: TCollection);
begin
  inherited;
  FCondicao := TCondicao.Create;
end;

destructor TCondicaoCollectionItem.Destroy;
begin
  FreeAndNil(FCondicao);
  inherited;
end;

procedure TCondicaoCollectionItem.SetCondicao(const Value: TCondicao);
begin
  FCondicao := Value;
end;

{ TCondicaoCollection }

constructor TCondicaoCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TCondicaoCollectionItem);
end;

function TCondicaoCollection.GetItem(Index: Integer): TCondicaoCollectionItem;
begin
  result := (inherited GetItem(Index)) as TCondicaoCollectionItem;
end;

procedure TCondicaoCollection.SetItem(Index: Integer; Value: TCondicaoCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

end.
