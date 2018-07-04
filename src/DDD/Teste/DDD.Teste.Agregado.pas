unit DDD.Teste.Agregado;

interface

uses
  DUnitX.TestFramework, DDD.Core.Intf.Agregado, DDD.Teste.Mock.Entidade, DDD.Core.Impl.Agregado,
  DDD.Teste.Mock.Agregado;

type

  [TestFixture]
  TAgregadoTest = class(TObject)
  private
    FAgregado: TMockEntidadeAgregado;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CriarAgregado;
    [Test]
    procedure AgregadoCriaNovoID;
    [Test]
    procedure TestarIncluirEntidade;
  end;

implementation

uses
  System.SysUtils, DDD.Core.Intf.ID, DDD.Modulo.Intf.IDFactory, DDD.Modulo.Impl.IDFactory;

procedure TAgregadoTest.AgregadoCriaNovoID;
var
  _id: IID;
begin
  _id := FAgregado.NovoID;
  Assert.IsTrue(Assigned(_id), 'Não criou o id');
  Assert.AreNotEqual(-1, _id.Valor);
end;

procedure TAgregadoTest.CriarAgregado;
begin
  Assert.IsTrue(Assigned(FAgregado));
end;

procedure TAgregadoTest.Setup;
begin
  FAgregado := TMockEntidadeAgregado.Create(Nil);
  ConfigurarDataSet(FAgregado);
end;

procedure TAgregadoTest.TearDown;
begin
  FreeAndNil(FAgregado);
end;

procedure TAgregadoTest.TestarIncluirEntidade;
var
  _mockEntidade: IMockEntidade;
begin
  _mockEntidade := TMockEntidade.New(TIDFactory.New(tiRandomico).NovoID);
  _mockEntidade.DefinirNovoID(FAgregado.NovoID);
  _mockEntidade.Campo1 := VALOR_CAMPO1;
  _mockEntidade.Campo2 := VALOR_CAMPO2;
  Assert.WillNotRaise(
    procedure
    begin
      FAgregado.Incluir(_mockEntidade);
    end);
  Assert.AreEqual(1, FAgregado.RecordCount);
end;

initialization

TDUnitX.RegisterTestFixture(TAgregadoTest);

end.
