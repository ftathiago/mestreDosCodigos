unit SQL.Builder.Coluna;

interface

uses
  SQL.Enums,
  SQL.Constantes,
  SQL.Intf.Tabela,
  SQL.Intf.Coluna;

type
  TBuilderColuna = class
  protected
    FColuna: ISQLColuna;
  public
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
    FColunaBuilder: TBuilderColuna;
    FTabela: ISQLTabela;
  public
    procedure setBuilderColuna(var ABuilderColuna: TBuilderColuna);
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

procedure TDirectorColuna.setBuilderColuna(var ABuilderColuna: TBuilderColuna);
begin
  FColunaBuilder := ABuilderColuna;
end;

procedure TDirectorColuna.setTabela(Tabela: ISQLTabela);
begin
  FTabela := Tabela;
end;

end.
