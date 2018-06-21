unit DDD.Teste.Modulo.Agregado;

interface

uses
  FireDac.Comp.Client, DDD.Teste.Mock.Entidade, DDD.Modulo.Intf.Adaptador, DUnitX.TestFramework;

type

  [TestFixture]
  TAdaptadorTest = class(TObject)
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
    procedure TestarCriarAdaptador;
    [Test]
    procedure TestarAdaptar;
  end;

implementation

uses
  System.SysUtils, Data.DB, DDD.Modulo.Impl.Adaptador.DataSetEntidade;

procedure TAdaptadorTest.Setup;
begin
  FDataSet := TFDMemTable.Create(Nil);
  ConfigurarDataSet(FDataSet);
  InserirDadosPadrao(FDataSet);
  FMockEntidade := TMockEntidade.New;
;
end;

procedure TAdaptadorTest.TearDown;
begin
  FreeAndNil(FDataSet);
end;

procedure TAdaptadorTest.TestarAdaptar;
begin
  TestarCriarAdaptador;
  FAdaptador.Adaptar;
  Assert.AreEqual(VALOR_CAMPO1, FMockEntidade.Campo1, FMockEntidade.Campo1);
  Assert.AreEqual(VALOR_CAMPO2, FMockEntidade.Campo2);
end;


procedure TAdaptadorTest.TestarCriarAdaptador;
begin
  FAdaptador := TAdaptadorDataSetEntidade<IMockEntidade>.New(FDataSet, FMockEntidade);
  Assert.IsTrue(Assigned(FAdaptador));
end;

initialization

TDUnitX.RegisterTestFixture(TAdaptadorTest);

end.
