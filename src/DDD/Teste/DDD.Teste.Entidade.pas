unit DDD.Teste.Entidade;

interface

uses
  FireDac.Comp.Client, DDD.Teste.Mock.Entidade, DDD.Modulo.Intf.Adaptador, DUnitX.TestFramework;

type

  [TestFixture]
  TEntidadeTest = class(TObject)
  private
    FMockEntidade: IMockEntidade;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestarCriarEntidade;
    [Test]
    procedure TestarNomeEntidade;
  end;

implementation

uses
  System.SysUtils, Data.DB, DDD.Modulo.Impl.Adaptador.DataSetEntidade;

{ TEntidadeTest }

procedure TEntidadeTest.Setup;
begin

end;

procedure TEntidadeTest.TearDown;
begin

end;

procedure TEntidadeTest.TestarNomeEntidade;
begin
  TestarCriarEntidade;
  Assert.AreEqual(NOME_ENTIDADE_MOCK, FMockEntidade.NomeEntidade);
end;

procedure TEntidadeTest.TestarCriarEntidade;
begin
  FMockEntidade := TMockEntidade.New;
end;

initialization

TDUnitX.RegisterTestFixture(TEntidadeTest);

end.
