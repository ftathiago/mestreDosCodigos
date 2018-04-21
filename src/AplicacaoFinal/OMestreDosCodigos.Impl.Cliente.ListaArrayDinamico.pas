unit OMestreDosCodigos.Impl.Cliente.ListaArrayDinamico;

interface

uses
  System.SysUtils,
  OMestreDosCodigos.Intf.Cliente.ListaArrayDinamico;

type
  EIndexOutOfBounds = class(Exception);

  TListaArrayDinamico<T> = class(TInterfacedObject, IListaArrayDinamico<T>)
  private
    FArray: TArray<T>;
    FTamanho: Integer;
    FNotificarMudanca: TNotificarMudanca;
    function IncrementarTamanhoDoArrayEm(const Incremento: Integer): Integer;
    function UltimoIndice: Integer;
    procedure ValidarAcessoAoIndice(const Index: Integer);
    procedure NotificarMudanca(const TipoAlteracao: TTipoAlteracao);
  protected
    function TestarEstaVazio: boolean;
  public
    class function New(const Itens: Array of T): IListaArrayDinamico<T>;
    constructor Create(const Itens: Array of T);
    procedure AdicionarArray(const NovoArray: Array of T);
    procedure Adicionar(const Item: T);
    procedure Remover(const Index: Integer);
    procedure Alterar(const Index: Integer; const NovoItem: T);
    procedure setNotificarMudanca(const AProc: TNotificarMudanca);
    function Retornar(const Index: Integer): T;
    function getTamanho: Integer;
    function getNotificarMudanca: TNotificarMudanca;
    property Tamanho: Integer read getTamanho;
    property EstaVazio: boolean read TestarEstaVazio;
  end;

implementation

uses
  System.Classes;

{ TListaArrayDinamico<T> }

class function TListaArrayDinamico<T>.New(const Itens: Array of T): IListaArrayDinamico<T>;
begin
  Result := Create(Itens);
end;

procedure TListaArrayDinamico<T>.NotificarMudanca(const TipoAlteracao: TTipoAlteracao);
begin
  if Assigned(FNotificarMudanca) then
    FNotificarMudanca(TipoAlteracao);
end;

procedure TListaArrayDinamico<T>.Remover(const Index: Integer);
var
  TailElements: Cardinal;
begin
  ValidarAcessoAoIndice(Index);

  FinalizeArray(@FArray[Index], TypeInfo(T), 1);
  TailElements := Tamanho - Index;

  if TailElements > 0 then
    Move(FArray[Index + 1], FArray[Index], SizeOf(T) * TailElements);

  InitializeArray(@FArray[Tamanho - 1], TypeInfo(T), 1);
  SetLength(FArray, Tamanho - 1);
  FTamanho := DynArraySize(@FArray[0]);
  NotificarMudanca(taRemover);
end;

function TListaArrayDinamico<T>.Retornar(const Index: Integer): T;
begin
  ValidarAcessoAoIndice(Index);
  Result := FArray[Index];
end;

procedure TListaArrayDinamico<T>.setNotificarMudanca(const AProc: TNotificarMudanca);
begin
  FNotificarMudanca := AProc;
end;

function TListaArrayDinamico<T>.TestarEstaVazio: boolean;
begin
  Result := FTamanho <= 0;
end;

constructor TListaArrayDinamico<T>.Create(const Itens: Array of T);
begin
  inherited Create;
  FTamanho := 0;
  AdicionarArray(Itens);
end;

function TListaArrayDinamico<T>.getNotificarMudanca: TNotificarMudanca;
begin
  Result := FNotificarMudanca;
end;

function TListaArrayDinamico<T>.getTamanho: Integer;
begin
  Result := FTamanho;
end;

procedure TListaArrayDinamico<T>.AdicionarArray(const NovoArray: array of T);
var
  _tamanhoDoNovoArray: Integer;
  i: Integer;
begin
  _tamanhoDoNovoArray := Length(NovoArray);
  for i := 0 to Pred(_tamanhoDoNovoArray) do
    Adicionar(NovoArray[i]);

  NotificarMudanca(taAdicionar);
end;

procedure TListaArrayDinamico<T>.Alterar(const Index: Integer; const NovoItem: T);
begin
  ValidarAcessoAoIndice(Index);
  FArray[Index] := NovoItem;
  NotificarMudanca(taAlterar);
end;

procedure TListaArrayDinamico<T>.Adicionar(const Item: T);
begin
  IncrementarTamanhoDoArrayEm(1);
  FArray[UltimoIndice] := Item;
  NotificarMudanca(taAdicionar);
end;

function TListaArrayDinamico<T>.IncrementarTamanhoDoArrayEm(const Incremento: Integer): Integer;
var
  _tamanhoAtual: Integer;
begin
  Inc(FTamanho, Incremento);
  SetLength(FArray, FTamanho);
end;

function TListaArrayDinamico<T>.UltimoIndice: Integer;
begin
  Result := Pred(FTamanho);
end;

procedure TListaArrayDinamico<T>.ValidarAcessoAoIndice(const Index: Integer);
begin
  if Index >= Tamanho then
    raise EIndexOutOfBounds.Create('Índice fora intervalo');
end;

end.
