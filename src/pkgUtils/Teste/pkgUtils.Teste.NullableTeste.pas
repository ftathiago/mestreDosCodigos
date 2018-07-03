unit pkgUtils.Teste.NullableTeste;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  pkgUtils.Impl.Types,
  DUnitX.TestFramework;

type

  [TestFixture]
  TNullableTest = class(TObject)
  private
    FintNull: IntegerNull;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestarEhIgual;
    [Test]
    procedure TestarMaioridade;
    [Test]
    procedure TesarMaiorOuIgualdade;
    [Test]
    procedure TestarMenoridade;
  end;

implementation

const
  MENOR = -1;
  IGUAL = 0;
  MAIOR = 1;

procedure TNullableTest.TesarMaiorOuIgualdade;
begin
  FintNull := MAIOR;
  Assert.IsTrue(FintNull >= MAIOR);
  Assert.IsTrue(FintNull >= MENOR);
end;

procedure TNullableTest.TestarEhIgual;
begin
  FintNull := IGUAL;
  Assert.AreEqual(IGUAL, Integer(FintNull));
  Assert.IsTrue(IGUAL = FintNull);
  Assert.IsFalse(IGUAL = MAIOR);
end;


procedure TNullableTest.TestarMaioridade;
begin
  FintNull := MAIOR;
  Assert.IsTrue(FintNull > Igual);
end;

procedure TNullableTest.TestarMenoridade;
begin
  FintNull := MENOR;
  Assert.IsTrue(Integer(FintNull) < IGUAL);
end;

procedure TNullableTest.Setup;
begin

end;

procedure TNullableTest.TearDown;
begin

end;


initialization

TDUnitX.RegisterTestFixture(TNullableTest);

end.
