unit SQL.Builder.Coluna;

interface

uses
  SQL.Enums,
  SQL.Constantes,
  SQL.Intf.Tabela,
  SQL.Intf.Coluna;

type
  IBuilderColuna = interface(IInterface)
    ['{0F95620B-5C5D-401F-A86D-CE036E1A9B2F}']
    function getColuna: ISQLColuna;
    procedure criarNovaColuna(ATabela: ISQLTabela);
    procedure buildNome();
    procedure buildNomeVirtual();
  end;

  TBuilderColuna = class(TInterfacedObject, IBuilderColuna)
  protected
    FColuna: ISQLColuna;
  public
    class function New: IBuilderColuna;
    function getColuna: ISQLColuna;
    procedure criarNovaColuna(ATabela: ISQLTabela);
    procedure buildNome(); virtual; abstract;
    procedure buildNomeVirtual(); virtual; abstract;
  end;

  TBuilderColunaSimples = class(TBuilderColuna)
  public
    procedure buildNome(); override;
    procedure buildNomeVirtual(); override;
  end;

  TBuilderColunaNomeVirtual = class(TBuilderColuna)
  public
    procedure buildNome(); override;
    procedure buildNomeVirtual(); override;
  end;

  TBuilderColunaTotalmenteVirtual = class(TBuilderColuna)
  public
    procedure buildNome(); override;
    procedure buildNomeVirtual(); override;
  end;

  TDirectorColuna = class
  private
    FColunaBuilder: IBuilderColuna;
    FTabela: ISQLTabela;
  public
    procedure setBuilderColuna(const ABuilderColuna: IBuilderColuna);
    procedure setTabela(Tabela: ISQLTabela);
    procedure construirColuna();
    function getColuna: ISQLColuna;
  end;

implementation

uses
  Teste.Constantes,
  SQL.Intf.Fabrica,
  SQL.Impl.Fabrica,
  SQL.Builder.Tabela;

{ TBuilderColuna }

procedure TBuilderColuna.criarNovaColuna(ATabela: ISQLTabela);
begin
  FColuna := TFabrica.New(SQL_TIPO_PADRAO).Coluna;

  if Assigned(ATabela) then
    FColuna.setTabela(ATabela);
end;

function TBuilderColuna.getColuna: ISQLColuna;
begin
  result := FColuna;
end;

class function TBuilderColuna.New: IBuilderColuna;
begin
  result := Create;
end;

{ TBuilderColunaSimples }

procedure TBuilderColunaSimples.buildNome;
begin
  FColuna.setColuna(COLUNA_SEM_ALIAS);
end;

procedure TBuilderColunaSimples.buildNomeVirtual;
begin
  FColuna.setNomeVirtual('');
end;

{ TBuilderColunaNomeVirtual }

procedure TBuilderColunaNomeVirtual.buildNome;
begin
  FColuna.setColuna(COLUNA_COM_ALIAS);
end;

procedure TBuilderColunaNomeVirtual.buildNomeVirtual;
begin
  FColuna.setNomeVirtual(COLUNA_NOME_VIRTUAL);
end;

{ TBuilderColunaTotalmenteVirtual }

procedure TBuilderColunaTotalmenteVirtual.buildNome;
begin
  FColuna.setColuna('null')
end;

procedure TBuilderColunaTotalmenteVirtual.buildNomeVirtual;
begin
  FColuna.setNomeVirtual(COLUNA_NOME_VIRTUAL);
end;

{ TDirectorTabela }

procedure TDirectorColuna.construirColuna;
begin
  FColunaBuilder.criarNovaColuna(FTabela);
  FColunaBuilder.buildNome;
  FColunaBuilder.buildNomeVirtual;
end;

function TDirectorColuna.getColuna: ISQLColuna;
begin
  result := FColunaBuilder.getColuna;
end;

procedure TDirectorColuna.setBuilderColuna(const ABuilderColuna: IBuilderColuna);
begin
  FColunaBuilder := ABuilderColuna;
end;

procedure TDirectorColuna.setTabela(Tabela: ISQLTabela);
begin
  FTabela := Tabela;
end;

end.
