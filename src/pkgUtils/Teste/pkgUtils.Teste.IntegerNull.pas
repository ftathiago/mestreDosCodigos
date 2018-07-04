unit pkgUtils.Teste.IntegerNull;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  pkgUtils.Impl.Types,
  DUnitX.TestFramework;

type

  [TestFixture]
  TIntegerNullTest = class(TObject)
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
    procedure TestarMaiorOuIgualdade;
    [Test]
    procedure TestarMenoridade;
    [Test]
    procedure TestarMenorOuIgual;
  end;

implementation

const
  MENOR = -1;
  IGUAL = 0;
  MAIOR = 1;

procedure TIntegerNullTest.TestarMaiorOuIgualdade;
begin
  FintNull := MAIOR;
  Assert.IsTrue(FintNull >= MAIOR);
  Assert.IsTrue(FintNull >= MENOR);
end;

procedure TIntegerNullTest.TestarEhIgual;
begin
  FintNull := IGUAL;
  Assert.AreEqual(IGUAL, Integer(FintNull));
  Assert.IsTrue(IGUAL = FintNull);
  Assert.IsFalse(IGUAL = MAIOR);
end;


procedure TIntegerNullTest.TestarMaioridade;
begin
  FintNull := MAIOR;
  Assert.IsTrue(FintNull > Igual);
end;

procedure TIntegerNullTest.TestarMenoridade;
begin
  FintNull := MENOR;
  Assert.IsTrue(Integer(FintNull) < IGUAL);
end;

procedure TIntegerNullTest.TestarMenorOuIgual;
begin
  FintNull := MENOR;
  Assert.IsTrue(FintNull <= IGUAL);
  Assert.IsTrue(FintNull <= MENOR);
end;

procedure TIntegerNullTest.Setup;
begin

end;

procedure TIntegerNullTest.TearDown;
begin

end;


initialization

TDUnitX.RegisterTestFixture(TIntegerNullTest);

end.
