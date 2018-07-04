unit pkgUtils.Teste.StringNull;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  pkgUtils.Impl.Types,
  DUnitX.TestFramework;

type

  [TestFixture]
  TStringNullTest = class(TObject)
  private
    FStringNull: StringNull;
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
  MENOR = ' ';
  IGUAL = 'a';
  MAIOR = 'z';

procedure TStringNullTest.TestarMaiorOuIgualdade;
begin
  FStringNull := MAIOR;
  Assert.IsTrue(FStringNull >= MAIOR);
  Assert.IsTrue(FStringNull >= MENOR);
end;

procedure TStringNullTest.TestarEhIgual;
begin
  FStringNull := IGUAL;
  Assert.AreEqual(IGUAL, String(FStringNull));
  Assert.IsTrue(IGUAL = FStringNull);
  Assert.IsFalse(IGUAL = MAIOR);
end;

procedure TStringNullTest.TestarMaioridade;
begin
  FStringNull := MAIOR;
  Assert.IsTrue(MAIOR > IGUAL, 'Constantes com erro');
  Assert.IsTrue(FStringNull > Igual);
end;

procedure TStringNullTest.TestarMenoridade;
begin
  FStringNull := MENOR;
  Assert.IsTrue(String(FStringNull) < IGUAL);
end;

procedure TStringNullTest.TestarMenorOuIgual;
begin
  FStringNull := MENOR;
  Assert.IsTrue(FStringNull <= IGUAL);
  Assert.IsTrue(FStringNull <= MENOR);
end;

procedure TStringNullTest.Setup;
begin

end;

procedure TStringNullTest.TearDown;
begin

end;


initialization

TDUnitX.RegisterTestFixture(TStringNullTest);

end.
