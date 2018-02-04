unit SQL.Builder.Tabela;

interface

uses
  SQL.Enums,
  SQL.Constantes,
  SQL.Intf.Tabela;

type
  IBuilderTabela = interface(IInterface)
    ['{ED9BF74D-D4F1-4118-8E42-48E775E85161}']
    function getTabela: ISQLTabela;
    procedure criarNovaTabela;
    procedure buildNomeTabela();
    procedure buildAliasTabela();
  end;

  TBuilderTabela = class(TInterfacedObject, IBuilderTabela)
  protected
    FTabela: ISQLTabela;
  public
    class function New: IBuilderTabela;
    function getTabela: ISQLTabela;
    procedure criarNovaTabela;
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

  TDirectorTabela = class
  private
    FTabelaBuilder: IBuilderTabela;
  public
    procedure setBuilderTabela(const ABuilderTabela: IBuilderTabela);
    procedure construirTabela();
    function getTabela: ISQLTabela;
  end;

implementation

uses
  SQL.Intf.Fabrica,
  SQL.Impl.Fabrica,
  Teste.Constantes;

{ TBuilderTabela }

procedure TBuilderTabela.criarNovaTabela;
var
  _fabrica: IFabrica;
begin
  _fabrica := TFabrica.New(SQL_TIPO_PADRAO);

  FTabela := _fabrica.Tabela;
end;

function TBuilderTabela.getTabela: ISQLTabela;
begin
  result := FTabela;
end;

class function TBuilderTabela.New: IBuilderTabela;
begin
  result := Create;
end;

{ TBuilderTabelaComNomeApenas }

procedure TBuilderTabelaComNomeApenas.buildAliasTabela;
begin
  FTabela.setAlias('');
end;

procedure TBuilderTabelaComNomeApenas.buildNomeTabela;
begin
  FTabela.setNome(TABELA_SEM_ALIAS);
end;

{ TBuilderTabelaComNomeEAlias }

procedure TBuilderTabelaComNomeEAlias.buildAliasTabela;
begin
  FTabela.setAlias(TABELA_ALIAS)
end;

procedure TBuilderTabelaComNomeEAlias.buildNomeTabela;
begin
  FTabela.setNome(TABELA_COM_ALIAS);
end;

{ TDirectorTabela }

procedure TDirectorTabela.construirTabela;
begin
  FTabelaBuilder.criarNovaTabela;
  FTabelaBuilder.buildNomeTabela;
  FTabelaBuilder.buildAliasTabela;
end;

function TDirectorTabela.getTabela: ISQLTabela;
begin
  result := FTabelaBuilder.getTabela;
end;

procedure TDirectorTabela.setBuilderTabela(const ABuilderTabela: IBuilderTabela);
begin
  FTabelaBuilder := ABuilderTabela;
end;

end.
