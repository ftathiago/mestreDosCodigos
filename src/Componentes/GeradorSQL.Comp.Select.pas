unit GeradorSQL.Comp.Select;

interface

uses
  System.Rtti,
  System.Classes,
  System.Generics.Collections,
  SQL.Enums;

type
  TTabela = class(TPersistent)
  private
    FAlias: string;
    FNome: string;
    procedure SetAlias(const Value: string);
    procedure SetNome(const Value: string);
  published
    property Nome: string read FNome write SetNome;
    property Alias: string read FAlias write SetAlias;
  end;

  TColuna = class(TPersistent)
  private
    FAlias: string;
    FNomeVirtual: string;
    FNome: string;
    procedure SetAlias(const Value: string);
    procedure SetNome(const Value: string);
    procedure SetNomeVirtual(const Value: string);
  published
    property Alias: string read FAlias write SetAlias;
    property Nome: string read FNome write SetNome;
    property NomeVirtual: string read FNomeVirtual write SetNomeVirtual;
  end;

  TColunaItem = class(TCollectionItem)
  private
    FColuna: TColuna;
    procedure SetColuna(const Value: TColuna);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Coluna: TColuna read FColuna write SetColuna;
  end;

  TCondicaoItem = class(TCollectionItem)
  private
    FOperadorComparacao: TOperadorComparacao;
    FValor: string;
    FOperadorLogico: TOperadorLogico;
    FColuna: TColuna;
    procedure SetOperadorComparacao(const Value: TOperadorComparacao);
    procedure SetOperadorLogico(const Value: TOperadorLogico);
    procedure SetValor(const Value: string);
    procedure SetColuna(const Value: TColuna);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property OperadorLogico: TOperadorLogico read FOperadorLogico write SetOperadorLogico
      Default olAnd;
    property Coluna: TColuna read FColuna write SetColuna;
    property OperadorComparacao: TOperadorComparacao read FOperadorComparacao
      write SetOperadorComparacao Default ocIgual;
    property Valor: String read FValor write SetValor;
  end;

  TJuncaoItem = class(TCollectionItem)
  private
    FTabela: TTabela;
    FTipoJuncao: TTipoJuncao;
    FCondicao: TCollection;
    procedure SetCondicao(const Value: TCollection);
    procedure SetTabela(const Value: TTabela);
    procedure SetTipoJuncao(const Value: TTipoJuncao);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property TipoJuncao: TTipoJuncao read FTipoJuncao write SetTipoJuncao default tjInnerJoin;
    property Tabela: TTabela read FTabela write SetTabela;
    property Condicao: TCollection read FCondicao write SetCondicao;
  end;

  TSelect = class(TComponent)
  private
    FOtimizarPara: TOtimizarPara;
    FFrom: TTabela;
    FColuna: TCollection;
    FCondicao: TCollection;
    FJuncao: TCollection;
    procedure SetOtimizarPara(const Value: TOtimizarPara);
    procedure SetFrom(const Value: TTabela);
    procedure SetColuna(const Value: TCollection);
    procedure SetCondicao(const Value: TCollection);
    procedure SetJuncao(const Value: TCollection);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GerarSQL: string;
  published
    property OtimizarPara: TOtimizarPara read FOtimizarPara write SetOtimizarPara
      Default opPadraoSQL3;
    property Coluna: TCollection read FColuna write SetColuna;
    property From: TTabela read FFrom write SetFrom;
    property Juncao: TCollection read FJuncao write SetJuncao;
//    property Condicao: TCollection read FCondicao write SetCondicao;
  end;

implementation

uses
  System.SysUtils;

{ TSelect }

constructor TSelect.Create(AOwner: TComponent);
begin
  inherited;
  FFrom := TTabela.Create;
  FCondicao := TCollection.Create(TCondicaoItem);
  FJuncao := TCollection.Create(TJuncaoItem);
  FColuna := TCollection.Create(TColunaItem);
  FOtimizarPara := opPadraoSQL3;
end;

destructor TSelect.Destroy;
begin
  FCondicao.Clear;
  FJuncao.Clear;
  FColuna.Clear;

  FreeAndNil(FCondicao);
  FreeAndNil(FJuncao);
  FreeAndNil(FColuna);
  FreeAndNil(FFrom);
  inherited;
end;

function TSelect.GerarSQL: string;
begin

end;

procedure TSelect.SetColuna(const Value: TCollection);
begin
  FColuna := Value;
end;

procedure TSelect.SetCondicao(const Value: TCollection);
begin
  FCondicao := Value;
end;

procedure TSelect.SetFrom(const Value: TTabela);
begin
  FFrom := Value;
end;

procedure TSelect.SetJuncao(const Value: TCollection);
begin
  FJuncao := Value;
end;

procedure TSelect.SetOtimizarPara(const Value: TOtimizarPara);
begin
  FOtimizarPara := Value;
end;

{ TColunaItem }

constructor TColunaItem.Create(Collection: TCollection);
begin
  inherited;
  FColuna := TColuna.Create;
end;

destructor TColunaItem.Destroy;
begin
  FreeAndNil(FColuna);
  inherited;
end;

procedure TColunaItem.SetColuna(const Value: TColuna);
begin
  FColuna := Value;
end;

{ TCondicaoItem }

constructor TCondicaoItem.Create(Collection: TCollection);
begin
  inherited;
  FOperadorComparacao := ocIgual;
  FOperadorLogico := olAnd;
  FColuna := TColuna.Create;
end;

destructor TCondicaoItem.Destroy;
begin
  FreeAndNil(FColuna);
  inherited;
end;

procedure TCondicaoItem.SetColuna(const Value: TColuna);
begin
  FColuna := Value;
end;

procedure TCondicaoItem.SetOperadorComparacao(const Value: TOperadorComparacao);
begin
  FOperadorComparacao := Value;
end;

procedure TCondicaoItem.SetOperadorLogico(const Value: TOperadorLogico);
begin
  FOperadorLogico := Value;
end;

procedure TCondicaoItem.SetValor(const Value: string);
begin
  FValor := Value;
end;

{ TColuna }

procedure TColuna.SetAlias(const Value: string);
begin
  FAlias := Value;
end;

procedure TColuna.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TColuna.SetNomeVirtual(const Value: string);
begin
  FNomeVirtual := Value;
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

{ TJuncao }

constructor TJuncaoItem.Create(Collection: TCollection);
begin
  inherited;
  FCondicao := TCollection.Create(TCondicaoItem);
  FTabela := TTabela.Create;
  FTipoJuncao := tjInnerJoin;
end;

destructor TJuncaoItem.Destroy;
begin
  FCondicao.Clear;

  FreeAndNil(FTabela);
  FreeAndNil(FCondicao);
  inherited;
end;

procedure TJuncaoItem.SetCondicao(const Value: TCollection);
begin
  FCondicao := Value;
end;

procedure TJuncaoItem.SetTabela(const Value: TTabela);
begin
  FTabela := Value;
end;

procedure TJuncaoItem.SetTipoJuncao(const Value: TTipoJuncao);
begin
  FTipoJuncao := Value;
end;

end.
