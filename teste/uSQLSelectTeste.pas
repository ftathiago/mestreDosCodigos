unit uSQLSelectTeste;

interface

uses
  DUnitX.TestFramework,
  SQL.Intf.Director,
  SQL.Intf.Select,
  SQL.Builder.Select;

type

  [TestFixture]
  TSQLSelectTeste = class(TObject)
  private
    FDirector: IDirector<IBuilderSelect, ISQLSelect>;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestarSelect;
  end;

implementation

procedure TSQLSelectTeste.Setup;
begin
  FDirector := TDirectorSelect.New;
end;

procedure TSQLSelectTeste.TearDown;
begin
  FDirector := nil;
end;

procedure TSQLSelectTeste.TestarSelect;
var
  _builder: IBuilderSelect;
  _select: ISQLSelect;
begin
  _builder := TBuilderSelectSimples.New;
  FDirector.setBuilder(_builder);
  FDirector.Construir;

  _select := FDirector.getObjetoPronto;

  Assert.AreEqual('', _select.ToString);
end;

initialization

TDUnitX.RegisterTestFixture(TSQLSelectTeste);

end.
