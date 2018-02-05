unit SQL.Builder.Tabela;

interface

uses
  SQL.Intf.Builder,
  SQL.Intf.Tabela,
  SQL.Impl.Builder,
  SQL.Impl.Director;

type
  IBuilderTabela = interface(IBuilder<ISQLTabela>)
    ['{ED9BF74D-D4F1-4118-8E42-48E775E85161}']
    procedure buildNomeTabela();
    procedure buildAliasTabela();
  end;

  TDirectorTabela = class(TDirector<IBuilderTabela, ISQLTabela>)
  public
    procedure Construir; override;
  end;

  TBuilderTabela = class(TBuilder<ISQLTabela>, IBuilderTabela)
  public
    class function New: IBuilderTabela;
    procedure ConstruirNovaInstancia; override;
    procedure buildNomeTabela(); virtual; abstract;
    procedure buildAliasTabela(); virtual; abstract;
  end;

  TBuilderTabelaComNomeApenas = class(TBuilderTabela)
  public
    procedure buildAliasTabela; override;
    procedure buildNomeTabela; override;
  end;

  TBuilderTabelaComNomeEAlias = class(TBuilderTabela)
  public
    procedure buildAliasTabela; override;
    procedure buildNomeTabela; override;
  end;

implementation

uses
  SQL.Constantes,
  SQL.Intf.Fabrica,
  SQL.Impl.Fabrica,
  Teste.Constantes;

{ TBuilderTabela }

procedure TBuilderTabela.ConstruirNovaInstancia;
var
  _fabrica: IFabrica;
begin
  _fabrica := TFabrica.New(SQL_TIPO_PADRAO);

  FObjeto := _fabrica.Tabela;
end;

class function TBuilderTabela.New: IBuilderTabela;
begin
  result := Create;
end;

{ TBuilderTabelaComNomeApenas }

procedure TBuilderTabelaComNomeApenas.buildAliasTabela;
begin
  FObjeto.setAlias('');
end;

procedure TBuilderTabelaComNomeApenas.buildNomeTabela;
begin
  FObjeto.setNome(TABELA_SEM_ALIAS);
end;

{ TBuilderTabelaComNomeEAlias }

procedure TBuilderTabelaComNomeEAlias.buildAliasTabela;
begin
  FObjeto.setAlias(TABELA_ALIAS)
end;

procedure TBuilderTabelaComNomeEAlias.buildNomeTabela;
begin
  FObjeto.setNome(TABELA_COM_ALIAS);
end;

{ TDirectorTabela }

procedure TDirectorTabela.construir;
begin
  FBuilder.ConstruirNovaInstancia;
  FBuilder.buildNomeTabela;
  FBuilder.buildAliasTabela;
  FObjeto := FBuilder.getObjeto
end;

end.
