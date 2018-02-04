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
  _director: TDirectorJuncao;
begin
  _director := TDirectorJuncao.Create;
  try
    _director.setBuilderJuncao(TBuilderJuncaoApenasTabela.New);
    _director.construirJuncao;

    FJuncao := _director.getJuncao;
  finally
    FreeAndNil(_director);
  end;
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
