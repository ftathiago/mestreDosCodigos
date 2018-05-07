unit uSQLTabelaTeste;

interface

uses
  DUnitX.TestFramework,
  DesignPattern.Builder.Intf.Builder,
  DesignPattern.Builder.Intf.Director,
  SQL.Intf.Tabela,
  SQL.Intf.Tabela.Builder;

type

  [TestFixture]
  TSQLTabelaTeste = class(TObject)
  private
    FTabela: ISQLTabela;
    FDirectorTabela: IDirector<IBuilderTabela, ISQLTabela>;
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
  System.SysUtils,
  Teste.Constantes,
  Teste.Builder.Tabela,
  SQL.Impl.Tabela.Director;

{ TSQLTabelaTeste }

procedure TSQLTabelaTeste.ApenasComNome;
var
  _builderComNome: IBuilderTabela;
begin
  _builderComNome := TCBTabelaComNomeApenas.New;

  FDirectorTabela.setBuilder(_builderComNome);
  FDirectorTabela.construir;
  FTabela := FDirectorTabela.getObjetoPronto;

  Assert.AreEqual(TABELA_SEM_ALIAS, FTabela.ToString);
end;

procedure TSQLTabelaTeste.ComNomeEAlias;
var
  _builder: IBuilderTabela;
begin
  _builder := TCBTabelaComNomeEAlias.New;
  FDirectorTabela.setBuilder(_builder);
  FDirectorTabela.construir;

  FTabela := FDirectorTabela.getObjetoPronto;

  Assert.AreEqual(Format('%s %s', [TABELA_COM_ALIAS, TABELA_ALIAS]), FTabela.ToString);
end;

procedure TSQLTabelaTeste.Setup;
begin
  FDirectorTabela := TDirectorTabela.New;
end;

procedure TSQLTabelaTeste.TearDown;
begin

end;

initialization

TDUnitX.RegisterTestFixture(TSQLTabelaTeste);

end.
