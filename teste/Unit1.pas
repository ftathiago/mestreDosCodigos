unit Unit1;

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
  end;

implementation

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
  _builder: TBuilderColuna;
  _builderTabela: TBuilderTabela;
  _coluna: ISQLColuna;
begin
  _builder := TBuilderColunaSimples.Create;
  try
    FDirectorColuna.setBuilderColuna(_builder);
    FDirectorColuna.construirColuna;
    result := FDirectorColuna.getColuna;
  finally
    _builder.Free;
  end;
end;

function TSQLColunaTeste.getColunaSimples: ISQLColuna;
var
  _builder: TBuilderColuna;
  _coluna: ISQLColuna;
begin
  _builder := TBuilderColunaSimples.Create;
  try
    FDirectorColuna.setBuilderColuna(_builder);
    FDirectorColuna.construirColuna;
    result := FDirectorColuna.getColuna;
  finally
    _builder.Free;
  end;
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
