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
    FDateTimeNull: TDateTimeNull;
    function Menor: TDateTime;
    function Maior: TDateTime;
    function Igual: TDateTime;
  public
    [Setup]
    procedure Setup;
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
    [Test]
    procedure TestarEstaVazio;
  end;

implementation

uses
  System.DateUtils;

procedure TDateTimeNullTest.TestarMaiorOuIgualdade;
begin
  FDateTimeNull := Maior;
  Assert.IsTrue(FDateTimeNull >= Maior);
  Assert.IsTrue(FDateTimeNull >= Menor);
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

procedure TDateTimeNullTest.Setup;
begin
  FDateTimeNull.Limpar;
end;

procedure TDateTimeNullTest.TestarEhIgual;
begin
  FDateTimeNull := Igual;
  Assert.IsTrue(Igual = FDateTimeNull);
  Assert.IsFalse(Igual = Maior);
end;

procedure TDateTimeNullTest.TestarEstaVazio;
begin
  Assert.IsFalse(FDateTimeNull.TemValor, DateToStr(FDateTimeNull.Valor));
end;

procedure TDateTimeNullTest.TestarMaioridade;
begin
  FDateTimeNull := Maior;
  Assert.IsTrue(Maior > Igual, 'Constantes com erro');
  Assert.IsTrue(FDateTimeNull > Igual);
end;

procedure TDateTimeNullTest.TestarMenoridade;
begin
  FDateTimeNull := Menor;
  Assert.IsTrue(Double(FDateTimeNull) < Igual);
end;

procedure TDateTimeNullTest.TestarMenorOuIgual;
begin
  FDateTimeNull := Menor;
  Assert.IsTrue(FDateTimeNull <= Igual);
  Assert.IsTrue(FDateTimeNull <= Menor);
end;

initialization

TDUnitX.RegisterTestFixture(TDateTimeNullTest);

end.
