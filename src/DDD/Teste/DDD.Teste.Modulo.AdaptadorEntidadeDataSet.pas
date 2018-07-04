unit DDD.Teste.Modulo.AdaptadorEntidadeDataSet;

interface

uses
  DUnitX.TestFramework, FireDac.Comp.Client, DDD.Modulo.Intf.Adaptador, DDD.Teste.Mock.Entidade;

type

  [TestFixture]
  TAdaptadorEntidadeDataSetTest = class(TObject)
  private
    FDataSet: TFDMemTable;
    FAdaptador: IAdaptador;
    FMockEntidade: IMockEntidade;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CriarAdaptador;
    [Test]
    procedure Adaptar;
    [Test]
    procedure TestarValoresForamPreenchidsoCorretamenteNoDataSet;
  end;

implementation

uses
  System.SysUtils, DDD.Modulo.Impl.Adaptador.EntidadeDataSet, DDD.Modulo.Impl.IDFactory,
  DDD.Modulo.Intf.IDFactory;

procedure TAdaptadorEntidadeDataSetTest.Setup;
begin
  FDataSet := TFDMemTable.Create(Nil);
  ConfigurarDataSet(FDataSet);
  FMockEntidade := TMockEntidade.New(TIDFactory.New(tiRandomico).NovoID);
  FMockEntidade.Campo1 := 'Francisco Thiago';
  FMockEntidade.Campo2 := 50;
end;

procedure TAdaptadorEntidadeDataSetTest.TearDown;
begin
  FDataSet.Close;
  FreeAndNil(FDataSet);
end;

procedure TAdaptadorEntidadeDataSetTest.TestarValoresForamPreenchidsoCorretamenteNoDataSet;
begin
  CriarAdaptador;
  Adaptar;
  Assert.AreEqual(FMockEntidade.ID.Valor, FDataSet.FieldByName('ID').AsInteger);
  Assert.AreEqual(FMockEntidade.Campo1, FDataSet.FieldByName('Campo1').AsString);
  Assert.AreEqual(FMockEntidade.Campo2, FDataSet.FieldByName('Campo2').AsInteger);
end;

procedure TAdaptadorEntidadeDataSetTest.CriarAdaptador;
begin
  FAdaptador := TAdaptadorEntidadeDataSet<IMockEntidade>.New(FDataSet, FMockEntidade);
  Assert.IsTrue(Assigned(FAdaptador));
end;

procedure TAdaptadorEntidadeDataSetTest.Adaptar;
begin
  CriarAdaptador;
  FAdaptador.Adaptar;
  Assert.AreEqual(1, FDataSet.RecordCount);
end;

initialization

TDUnitX.RegisterTestFixture(TAdaptadorEntidadeDataSetTest);

end.
