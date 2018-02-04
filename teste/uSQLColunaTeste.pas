unit uSQLColunaTeste;

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  SQL.Intf.Tabela,
  SQL.Intf.Coluna,
  SQL.Builder.Coluna,
  SQL.Builder.Tabela,
  Teste.Constantes;

type

  [TestFixture]
  TSQLColunaTeste = class(TObject)
  private
    FDirectorColuna: TDirectorColuna;
    FDirectorTabela: TDirectorTabela;
    function getColunaSimples: ISQLColuna;
    function getColunaComTabela: ISQLColuna;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure ColunaSimples;
    [Test]
    procedure ColunaSimplesComTabela;
    [Test]
    procedure ColunaComAlias;
    [Test]
    procedure ColunaComAliasETabela;
  end;

implementation

procedure TSQLColunaTeste.ColunaComAlias;
var
  _coluna: ISQLColuna;
begin
  _coluna := getColunaSimples;
  _coluna.setColuna(COLUNA_COM_ALIAS);
  _coluna.setNomeVirtual(COLUNA_NOME_VIRTUAL);

  Assert.AreEqual(Format('%s as %s', [COLUNA_COM_ALIAS, COLUNA_NOME_VIRTUAL]),
    _coluna.ToString);
end;

procedure TSQLColunaTeste.ColunaComAliasETabela;
var
  _coluna: ISQLColuna;
begin
  _coluna := getColunaComTabela;
  _coluna.setColuna(COLUNA_COM_ALIAS);
  _coluna.setNomeVirtual(COLUNA_NOME_VIRTUAL);

  Assert.AreEqual(Format('%s.%s as %s', [TABELA_SEM_ALIAS, COLUNA_COM_ALIAS, COLUNA_NOME_VIRTUAL]),
    _coluna.ToString);
end;

procedure TSQLColunaTeste.ColunaSimples;
begin
  Assert.AreEqual(COLUNA_SEM_ALIAS, getColunaSimples.ToString);
end;

procedure TSQLColunaTeste.ColunaSimplesComTabela;
begin
  Assert.AreEqual(
    Format('%s.%s', [TABELA_SEM_ALIAS, COLUNA_SEM_ALIAS]),
    getColunaComTabela.ToString);
end;

function TSQLColunaTeste.getColunaComTabela: ISQLColuna;
var
  _builderColuna: IBuilderColuna;
  _builderTabela: IBuilderTabela;
begin
  _builderColuna := TBuilderColunaSimples.New;
  _builderTabela := TBuilderTabelaComNomeApenas.New;
  FDirectorColuna.setBuilderColuna(_builderColuna);
  FDirectorColuna.construirColuna;

  FDirectorTabela.setBuilderTabela(_builderTabela);
  FDirectorTabela.construirTabela;

  result := FDirectorColuna.getColuna;

  result.setTabela(FDirectorTabela.getTabela);

end;

function TSQLColunaTeste.getColunaSimples: ISQLColuna;
var
  _builder: IBuilderColuna;
begin
  _builder := TBuilderColunaSimples.New;

  FDirectorColuna.setBuilderColuna(_builder);
  FDirectorColuna.construirColuna;
  result := FDirectorColuna.getColuna;

end;

procedure TSQLColunaTeste.Setup;
begin
  FDirectorTabela := TDirectorTabela.Create;
  FDirectorColuna := TDirectorColuna.Create;
end;

procedure TSQLColunaTeste.TearDown;
begin
  FreeAndNil(FDirectorTabela);
  FreeAndNil(FDirectorColuna);
end;

initialization

TDUnitX.RegisterTestFixture(TSQLColunaTeste);

end.
