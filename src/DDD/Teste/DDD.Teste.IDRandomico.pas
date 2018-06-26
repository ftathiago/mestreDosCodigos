unit DDD.Teste.IDRandomico;

interface

uses
  DUnitX.TestFramework, DDD.Core.Intf.ID;

type

  [TestFixture]
  TIDRandomicoTest = class(TObject)
  private
    FID: IID;
    FIDInicializado: IID;
  public
    [Setup]
    procedure Setup;
    [Test]
    procedure IDCriado;
    [Test]
    procedure MantemOMesmoValor;
    [Test]
    procedure CriamValoresDiferentes;
    [Test]
    procedure CriarInicializado;
  end;

const
  VALOR_INICIALIZADO = 10;

implementation

uses
  DDD.Core.Impl.IDRandomico, DDD.Modulo.Impl.IDFactory, DDD.Modulo.Intf.IDFactory;

procedure TIDRandomicoTest.Setup;
begin
  FID := TIDFactory.New(tiRandomico).NovoID;
  FIDInicializado := TIDFactory.New(tiRandomico).InicializarID(VALOR_INICIALIZADO);
end;

procedure TIDRandomicoTest.CriamValoresDiferentes;
var
  _id: IID;
begin
  _id := TIDRandomico.New;
  Assert.AreNotEqual(_id.Valor, FID.Valor);
end;

procedure TIDRandomicoTest.CriarInicializado;
begin
  Assert.AreEqual(VALOR_INICIALIZADO, FIDInicializado.Valor);
end;

procedure TIDRandomicoTest.IDCriado;
begin
  Assert.IsTrue(Assigned(FID));
end;

procedure TIDRandomicoTest.MantemOMesmoValor;
var
  _idValor: integer;
begin
  _idValor := FID.Valor;
  Assert.AreEqual(_idValor, FID.Valor);
end;

initialization

TDUnitX.RegisterTestFixture(TIDRandomicoTest);

end.
