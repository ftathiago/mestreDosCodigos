unit SQL.Builder.Coluna;

interface

uses
  SQL.Enums,
  SQL.Constantes,
  SQL.Intf.Director,
  SQL.Intf.Builder,
  SQL.Intf.Tabela,
  SQL.Intf.Coluna,
  SQL.Impl.Builder,
  SQL.Impl.Director;

type
  IBuilderColuna = interface(IBuilder<ISQLColuna>)
    ['{0F95620B-5C5D-401F-A86D-CE036E1A9B2F}']
    procedure buildNome();
    procedure buildNomeVirtual();
    procedure AdicionarTabela(ATabela: ISQLTabela);
  end;

  TBuilderColuna = class(TBuilder<ISQLColuna>, IBuilderColuna)
  public
    class function New: IBuilderColuna;
    procedure ConstruirNovaInstancia; override;
    procedure AdicionarTabela(ATabela: ISQLTabela);
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

  TDirectorColuna = class(TDirector<IBuilderColuna, ISQLColuna>)
  private
    FTabela: ISQLTabela;
  public
    procedure setBuilderColuna(const ABuilderColuna: IBuilderColuna);
    procedure setTabela(Tabela: ISQLTabela);
    procedure Construir(); override;
  end;

implementation

uses
  Teste.Constantes,
  SQL.Intf.Fabrica,
  SQL.Impl.Fabrica,
  SQL.Builder.Tabela;

{ TBuilderColuna }

procedure TBuilderColuna.AdicionarTabela(ATabela: ISQLTabela);
begin

end;

procedure TBuilderColuna.ConstruirNovaInstancia;
begin
  FObjeto := TFabrica.New(SQL_TIPO_PADRAO).Coluna;
end;

class function TBuilderColuna.New: IBuilderColuna;
begin
  result := Create;
end;

{ TBuilderColunaSimples }

procedure TBuilderColunaSimples.buildNome;
begin
  FObjeto.setColuna(COLUNA_SEM_ALIAS);
end;

procedure TBuilderColunaSimples.buildNomeVirtual;
begin
  FObjeto.setNomeVirtual('');
end;

{ TBuilderColunaNomeVirtual }

procedure TBuilderColunaNomeVirtual.buildNome;
begin
  FObjeto.setColuna(COLUNA_COM_ALIAS);
end;

procedure TBuilderColunaNomeVirtual.buildNomeVirtual;
begin
  FObjeto.setNomeVirtual(COLUNA_NOME_VIRTUAL);
end;

{ TBuilderColunaTotalmenteVirtual }

procedure TBuilderColunaTotalmenteVirtual.buildNome;
begin
  FObjeto.setColuna('null')
end;

procedure TBuilderColunaTotalmenteVirtual.buildNomeVirtual;
begin
  FObjeto.setNomeVirtual(COLUNA_NOME_VIRTUAL);
end;

{ TDirectorTabela }

procedure TDirectorColuna.Construir;
begin
  FBuilder.ConstruirNovaInstancia;
  FBuilder.AdicionarTabela(FTabela);
  FBuilder.buildNome;
  FBuilder.buildNomeVirtual;
  FObjeto := FBuilder.getObjeto
end;

procedure TDirectorColuna.setBuilderColuna(const ABuilderColuna: IBuilderColuna);
begin
  FBuilder := ABuilderColuna;
end;

procedure TDirectorColuna.setTabela(Tabela: ISQLTabela);
begin
  FTabela := Tabela;
end;

end.
