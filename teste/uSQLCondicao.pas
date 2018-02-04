unit uSQLCondicao;

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
  SQL.Builder.Condicao,
  Teste.Constantes,
  SQL.Builder.Coluna;

procedure TSQLCondicaoTeste.Setup;
var
  _director: TDirectorCondicao;
begin
  _director := TDirectorCondicao.Create;
  _director.setBuilderCondicao(TBuilderCondicaoValor.New);
  _director.construirCondicao;
  FCondicao := _director.getCondicao;
end;

procedure TSQLCondicaoTeste.TearDown;
begin
end;

procedure TSQLCondicaoTeste.TestarComColuna;
var
  _director: TDirectorColuna;
begin
  _director := TDirectorColuna.Create;
  try
    _director.setBuilderColuna(TBuilderColunaSimples.New);
    _director.construirColuna;
    FCondicao.setValor(_director.getColuna);
    Assert.AreEqual(Format('(%s = %s)', [COLUNA_SEM_ALIAS, COLUNA_SEM_ALIAS]), FCondicao.ToString);
  finally
    _director.Free;
  end;
end;

procedure TSQLCondicaoTeste.TestarCondicao;
begin
  FCondicao.setValor('VALOR_DE_TESTE');
  Assert.AreEqual(Format('(%s = VALOR_DE_TESTE)', [COLUNA_SEM_ALIAS]), FCondicao.ToString);
end;

initialization

TDUnitX.RegisterTestFixture(TSQLCondicaoTeste);

end.
