unit pkgUtils.Teste.CurrencyNull;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  pkgUtils.Impl.Types,
  DUnitX.TestFramework;

type

  [TestFixture]
  TCurrencyNullTest = class(TObject)
  private
    FCurrencyNull: CurrencyNull;
  public
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
  MENOR = -1.99;
  IGUAL = 0;
  MAIOR = 1.99;

procedure TCurrencyNullTest.TestarMaiorOuIgualdade;
begin
  FCurrencyNull := MAIOR;
  Assert.IsTrue(FCurrencyNull >= MAIOR);
  Assert.IsTrue(FCurrencyNull >= MENOR);
end;

procedure TCurrencyNullTest.TestarEhIgual;
begin
  FCurrencyNull := IGUAL;
  Assert.IsTrue(IGUAL = FCurrencyNull);
  Assert.IsFalse(IGUAL = MAIOR);
end;

procedure TCurrencyNullTest.TestarMaioridade;
begin
  FCurrencyNull := MAIOR;
  Assert.IsTrue(MAIOR > IGUAL, 'Constantes com erro');
  Assert.IsTrue(FCurrencyNull > IGUAL);
end;

procedure TCurrencyNullTest.TestarMenoridade;
begin
  FCurrencyNull := MENOR;
  Assert.IsTrue(Double(FCurrencyNull) < IGUAL);
end;

procedure TCurrencyNullTest.TestarMenorOuIgual;
begin
  FCurrencyNull := MENOR;
  Assert.IsTrue(FCurrencyNull <= IGUAL);
  Assert.IsTrue(FCurrencyNull <= MENOR);
end;

initialization

TDUnitX.RegisterTestFixture(TCurrencyNullTest);

end.
