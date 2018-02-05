unit uSQLTabelaTeste;

interface

uses
  DUnitX.TestFramework,
  SQL.Intf.Tabela,
  SQL.Builder.Tabela,
  Teste.Constantes;

type

  [TestFixture]
  TSQLTabelaTeste = class(TObject)
  private
    FTabela: ISQLTabela;
    FDirectorTabela: TDirectorTabela;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure ApenasComNome;
    [Test]
    procedure ComNomeEAlias;

  end;

implementation

uses
  System.SysUtils;

{ TSQLTabelaTeste }

procedure TSQLTabelaTeste.ApenasComNome;
var
  _builderComNome: IBuilderTabela;
begin
  _builderComNome := TBuilderTabelaComNomeApenas.New;

  FDirectorTabela.setBuilder(_builderComNome);
  FDirectorTabela.construir;
  FTabela := FDirectorTabela.getObjetoPronto;

  Assert.AreEqual(TABELA_SEM_ALIAS, FTabela.ToString);

end;

procedure TSQLTabelaTeste.ComNomeEAlias;
var
  _builder: IBuilderTabela;
begin
  _builder := TBuilderTabelaComNomeEAlias.New;
  FDirectorTabela.setBuilder(_builder);
  FDirectorTabela.construir;

  FTabela := FDirectorTabela.getObjetoPronto;

  Assert.AreEqual(Format('%s %s', [TABELA_COM_ALIAS, TABELA_ALIAS]), FTabela.ToString);
end;

procedure TSQLTabelaTeste.Setup;
begin
  FDirectorTabela := TDirectorTabela.Create;
end;

procedure TSQLTabelaTeste.TearDown;
begin
  FDirectorTabela.Free;
end;

initialization

TDUnitX.RegisterTestFixture(TSQLTabelaTeste);

end.
