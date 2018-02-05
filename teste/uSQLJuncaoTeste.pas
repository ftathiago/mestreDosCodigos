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
    [Test]
    procedure TestarComTabelaEDuasCondicoes;

  end;

implementation

uses
  System.SysUtils,
  SQL.Enums,
  SQL.Intf.Director,
  SQL.Impl.PadraoSQL3.Tabela,
  SQL.Impl.PadraoSQL3.Coluna,
  SQL.Impl.PadraoSQL3.Juncao,
  SQL.Impl.PadraoSQL3.Condicao,
  SQL.Builder.Juncao,
  SQL.Builder.Condicao,
  Teste.Constantes;

{ TSQLJuncaoTeste }

procedure TSQLJuncaoTeste.Setup;
var
  _director: IDirector<IBuilderJuncao, ISQLJuncao>;
begin
  _director := TDirectorJuncao.New;
  _director.setBuilder(TBuilderJuncaoApenasTabela.New);
  _director.Construir;

  FJuncao := _director.getObjetoPronto;
end;

procedure TSQLJuncaoTeste.TestarComTabelaEDuasCondicoes;
begin
  FJuncao.addCondicao(FJuncao.getListaCondicoes.Last);
  Assert.AreEqual(
    Format('INNER JOIN %s %s on (%s.COLUNA = VALOR) AND (%s.COLUNA = VALOR)',
      [TABELA_COM_ALIAS, TABELA_ALIAS, TABELA_ALIAS, TABELA_ALIAS])
      , FJuncao.ToString);
end;

procedure TSQLJuncaoTeste.TestarComTabelaEUmaCondicao;
begin
  Assert.AreEqual(
    Format('INNER JOIN %s %s on (%s.COLUNA = VALOR)', [TABELA_COM_ALIAS, TABELA_ALIAS, TABELA_ALIAS])
      , FJuncao.ToString);
end;

initialization

TDUnitX.RegisterTestFixture(TSQLJuncaoTeste);

end.
