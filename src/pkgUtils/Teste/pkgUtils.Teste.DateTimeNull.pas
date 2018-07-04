unit pkgUtils.Teste.DateTimeNull;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  pkgUtils.Impl.Types,
  DUnitX.TestFramework;

type

  [TestFixture]
  TDateTimeNullTest = class(TObject)
  private
    FCurrencyNull: CurrencyNull;
    function Menor: TDateTime;
    function Maior: TDateTime;
    function Igual: TDateTime;
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

uses
  System.DateUtils;

procedure TDateTimeNullTest.TestarMaiorOuIgualdade;
begin
  FCurrencyNull := Maior;
  Assert.IsTrue(FCurrencyNull >= Maior);
  Assert.IsTrue(FCurrencyNull >= Menor);
end;

function TDateTimeNullTest.Igual: TDateTime;
begin
  result := Now;
end;

function TDateTimeNullTest.Maior: TDateTime;
begin
  result := IncDay(Now, 1);
end;

function TDateTimeNullTest.Menor: TDateTime;
begin
  result := IncDay(Now, -1);
end;

procedure TDateTimeNullTest.TestarEhIgual;
begin
  FCurrencyNull := Igual;
  Assert.IsTrue(Igual = FCurrencyNull);
  Assert.IsFalse(Igual = Maior);
end;

procedure TDateTimeNullTest.TestarMaioridade;
begin
  FCurrencyNull := Maior;
  Assert.IsTrue(Maior > Igual, 'Constantes com erro');
  Assert.IsTrue(FCurrencyNull > Igual);
end;

procedure TDateTimeNullTest.TestarMenoridade;
begin
  FCurrencyNull := Menor;
  Assert.IsTrue(Double(FCurrencyNull) < Igual);
end;

procedure TDateTimeNullTest.TestarMenorOuIgual;
begin
  FCurrencyNull := Menor;
  Assert.IsTrue(FCurrencyNull <= Igual);
  Assert.IsTrue(FCurrencyNull <= Menor);
end;

initialization

TDUnitX.RegisterTestFixture(TDateTimeNullTest);

end.
