unit pkgUtils.Teste.DoubleNull;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  pkgUtils.Impl.Types,
  DUnitX.TestFramework;

type

  [TestFixture]
  TDoubleNullTest = class(TObject)
  private
    FDoubleNull: DoubleNull;
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
  MENOR = -999999999999999.9999999999999;
  IGUAL = 0;
  MAIOR = 999999999999999.9999999999999;

procedure TDoubleNullTest.TestarMaiorOuIgualdade;
begin
  FDoubleNull := MAIOR;
  Assert.IsTrue(FDoubleNull >= MAIOR);
  Assert.IsTrue(FDoubleNull >= MENOR);
end;

procedure TDoubleNullTest.TestarEhIgual;
begin
  FDoubleNull := IGUAL;
  Assert.IsTrue(IGUAL = FDoubleNull);
  Assert.IsFalse(IGUAL = MAIOR);
end;

procedure TDoubleNullTest.TestarMaioridade;
begin
  FDoubleNull := MAIOR;
  Assert.IsTrue(MAIOR > IGUAL, 'Constantes com erro');
  Assert.IsTrue(FDoubleNull > IGUAL);
end;

procedure TDoubleNullTest.TestarMenoridade;
begin
  FDoubleNull := MENOR;
  Assert.IsTrue(Double(FDoubleNull) < IGUAL);
end;

procedure TDoubleNullTest.TestarMenorOuIgual;
begin
  FDoubleNull := MENOR;
  Assert.IsTrue(FDoubleNull <= IGUAL);
  Assert.IsTrue(FDoubleNull <= MENOR);
end;

initialization

TDUnitX.RegisterTestFixture(TDoubleNullTest);

end.
