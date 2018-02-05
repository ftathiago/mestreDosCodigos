unit uSQLCondicaoTeste;

interface

uses
  DUnitX.TestFramework,
  SQL.Intf.Condicao;

type

  [TestFixture]
  TSQLCondicaoTeste = class(TObject)
  private
    FCondicao: ISQLCondicao;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestarCondicao;
    [Test]
    procedure TestarComColuna;
  end;

implementation

uses
  System.SysUtils,
  Teste.Constantes,
  SQL.Intf.Director,
  SQL.Intf.Coluna,
  SQL.Builder.Condicao,
  SQL.Builder.Coluna;

procedure TSQLCondicaoTeste.Setup;
var
  _director: IDirector<IBuilderCondicao, ISQLCondicao>;
begin
  _director := TDirectorCondicao.New;
  _director.setBuilder(TBuilderCondicaoValor.New);
  _director.construir;
  FCondicao := _director.getObjetoPronto;
end;

procedure TSQLCondicaoTeste.TearDown;
begin
  FCondicao := nil;
end;

procedure TSQLCondicaoTeste.TestarComColuna;
var
  _director: IDirector<IBuilderColuna, ISQLColuna>;
begin
  _director := TDirectorColuna.New;
  _director.setBuilder(TBuilderColunaSimples.New);
  _director.construir;

  FCondicao.setValor(_director.getObjetoPronto);

  Assert.AreEqual(Format('(%s = %s)', [COLUNA_SEM_ALIAS, COLUNA_SEM_ALIAS]), FCondicao.ToString);

end;

procedure TSQLCondicaoTeste.TestarCondicao;
begin
  FCondicao.setValor('VALOR_DE_TESTE');
  Assert.AreEqual(Format('(%s = VALOR_DE_TESTE)', [COLUNA_SEM_ALIAS]), FCondicao.ToString);
end;

initialization

TDUnitX.RegisterTestFixture(TSQLCondicaoTeste);

end.
