unit pkgUtils.Impl.ListaRetornoValidacao;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  pkgUtils.Intf.ListaRetornoValidacao;

type
  TListaRetornoValidacao = class(TInterfacedObject, IListaRetornoValidacao)
  private
    FListaRetornoValidacoes: TList<TRetornoValidacao>;
    procedure AdicionarArrayListaRetorno(const ARetornoValidacao: TArray<TRetornoValidacao>);
  public
    class function New(const ARetornoValidacao: TArray<TRetornoValidacao>): IListaRetornoValidacao;
    constructor Create(const ARetornoValidacao: TArray<TRetornoValidacao>);
    destructor Destroy; override;
    procedure AddListaValidacoes(const AListaRetornoValidacoes: IListaRetornoValidacao);
    function getQtd: Integer;
    function getValidacao(const Indice: Integer): TRetornoValidacao;
    function EstaVazio: boolean;
  end;

implementation

{ TListaValidacoes }

class function TListaRetornoValidacao.New(const ARetornoValidacao: TArray<TRetornoValidacao>)
  : IListaRetornoValidacao;
begin
  result := Create(ARetornoValidacao);
end;

procedure TListaRetornoValidacao.AdicionarArrayListaRetorno(
  const ARetornoValidacao: TArray<TRetornoValidacao>);
var
  _retornoValidacao: TRetornoValidacao;
begin
  if Length(ARetornoValidacao) = 0 then
    exit;

  for _retornoValidacao in ARetornoValidacao do
    FListaRetornoValidacoes.Add(_retornoValidacao);
end;

constructor TListaRetornoValidacao.Create(const ARetornoValidacao: TArray<TRetornoValidacao>);
begin
  FListaRetornoValidacoes := TList<TRetornoValidacao>.Create;
  AdicionarArrayListaRetorno(ARetornoValidacao);
end;

destructor TListaRetornoValidacao.Destroy;
begin
  FListaRetornoValidacoes.Clear;
  FreeAndNil(FListaRetornoValidacoes);
  inherited;
end;

function TListaRetornoValidacao.EstaVazio: boolean;
begin
  result := FListaRetornoValidacoes.Count = 0;
end;

procedure TListaRetornoValidacao.AddListaValidacoes(const AListaRetornoValidacoes
    : IListaRetornoValidacao);
var
  i: Integer;
begin
  if AListaRetornoValidacoes.EstaVazio then
    exit;

  for i := 0 to Pred(AListaRetornoValidacoes.getQtd) do
    FListaRetornoValidacoes.Add(AListaRetornoValidacoes.getValidacao(i));
end;

function TListaRetornoValidacao.getQtd: Integer;
begin
  result := FListaRetornoValidacoes.Count;
end;

function TListaRetornoValidacao.getValidacao(const Indice: Integer): TRetornoValidacao;
begin
  result := FListaRetornoValidacoes.Items[Indice];
end;

end.