unit uSQLJuncaoTeste;

interface

uses
  DUnitX.TestFramework,
  SQL.Intf.Juncao,
  SQL.Intf.Tabela,
  SQL.Intf.Coluna;

type

  [TestFixture]
  TSQLJuncaoTeste = class(TObject)
  private
    FJuncao: ISQLJuncao;
  public
    [Setup]
    procedure Setup;
    [Test]
    procedure TestarComTabelaEUmaCondicao;
  end;

implementation

uses
  SQL.Enums,
  SQL.Impl.PadraoSQL3.Coluna,
  SQL.Impl.PadraoSQL3.Juncao,
  SQL.Impl.PadraoSQL3.Condicao,
  SQL.Impl.PadraoSQL3.Tabela;

{ TSQLJuncaoTeste }

procedure TSQLJuncaoTeste.Setup;
begin
  FJuncao := TSQL3Juncao.New;
end;

procedure TSQLJuncaoTeste.TestarComTabelaEUmaCondicao;
var
  _sql: string;
begin
  _sql :=
    FJuncao
    .setTabelaEstrangeira(TSQL3Tabela.New.setNome('NOME_TABELA').setAlias('ALIAS'))
    .setTipoJuncao(tjInnerJoin)
    .addCondicao(TSQL3Condicao.New
    .setOperadorLogico(olAnd)
    .setColuna(TSQL3Coluna.New
    .setTabela(TSQL3Tabela.New.setNome('NOME_TABELA').setAlias('ALIAS'))
    .setColuna('COLUNA')
    )
    .setOperadorComparacao(TOperadorComparacao.ocIgual)
    .setValor('VALOR')
    ).ToString;

  Assert.AreEqual('INNER JOIN NOME_TABELA ALIAS on (ALIAS.COLUNA = VALOR)', _sql);
end;

initialization

TDUnitX.RegisterTestFixture(TSQLJuncaoTeste);

end.
