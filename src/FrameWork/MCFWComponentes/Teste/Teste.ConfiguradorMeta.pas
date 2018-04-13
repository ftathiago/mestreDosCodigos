unit Teste.ConfiguradorMeta;

interface

uses
  Teste.Util.FonteDados,
  DUnitX.TestFramework,
  FireDac.Comp.DataSet,
  FireDac.Comp.Client,
  DataSet.Intf.MetaDataContainer,
  DataSet.Intf.ConfiguradorMetaData;

type

  [TestFixture]
  TConfiguradorMetaDataTeste = class(TObject)
  private
    FEnt: TFDDataSet;
    FentProp: TFDDataSet;
    FEntidade: TFDMemTable;
    FEntPropriedade: TFDMemTable;
    FConfiguradorMetaData: IConfiguradorMetaData;
    FFonteDados: TFonteDados;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure Test1;
    // Test with TestCase Attribute to supply parameters.
    [Test]
    [TestCase('Campo código', 'ID,Código')]
    [TestCase('Campo nome', 'NOME,Nome')]
    [TestCase('Campo descrição', 'DESCRICAO,Descrição')]
    procedure TestarENTIDADEDisplayLabelDoCampo(const NomeDoCampo: string; const ValorEsperado: string);

    [Test]
    [TestCase('Campo código', 'ID,Código')]
    [TestCase('Campo nome', 'NOME,Nome')]
    [TestCase('Campo descrição', 'DESCRICAO,Descrição')]
    procedure TestarEntPropriedadeDisplayLabelDoCampo(const NomeDoCampo: string; const ValorEsperado: string);

    [Test]
    [TestCase('TestA', '1,2')]
    [TestCase('TestB', '3,4')]
    procedure TestePropriedadesInteiro(const NomePropriedade: string; const ValorEsperado: Integer);
  end;

implementation

uses
  System.SysUtils,
  DataSet.Impl.MetaDataContainer,
  DataSet.Impl.ConfiguradorMetaData,
  uRTTIUtils;

procedure TConfiguradorMetaDataTeste.Setup;
begin
  FFonteDados := TFonteDados.Create;

  FEnt := FFonteDados.getEntidadeCarregada;
  FentProp := FFonteDados.getEntPropriedadeCarregada;

  FEntidade := FFonteDados.getEstruturaEntidade;
  FEntPropriedade := FFonteDados.getEstruturaEntPropriedade;

  FConfiguradorMetaData := TConfiguradorMetaData.New(FEnt, FentProp);
  FConfiguradorMetaData.setConfigurarDataSet(FEntidade, ['ENTIDADE']);
  FConfiguradorMetaData.setConfigurarDataSet(FEntPropriedade, ['ENT_PROPRIEDADE']);
end;

procedure TConfiguradorMetaDataTeste.TearDown;
begin
  FreeAndNil(FEntidade);
  FreeAndNil(FFonteDados);
end;

procedure TConfiguradorMetaDataTeste.Test1;
begin

end;

procedure TConfiguradorMetaDataTeste.TestePropriedadesInteiro(const NomePropriedade: string;
  const ValorEsperado: Integer);
begin
  Assert.IsTrue(FEntidade.RecordCount > 1);
end;

procedure TConfiguradorMetaDataTeste.TestarENTIDADEDisplayLabelDoCampo(const NomeDoCampo: string;
  const ValorEsperado: string);
begin
  Assert.AreEqual(FEntidade.FieldByName(NomeDoCampo).DisplayLabel, ValorEsperado);
end;

procedure TConfiguradorMetaDataTeste.TestarEntPropriedadeDisplayLabelDoCampo(const NomeDoCampo,
  ValorEsperado: string);
begin
  Assert.AreEqual(FEntPropriedade.FieldByName(NomeDoCampo).DisplayLabel, ValorEsperado);
end;

initialization

TDUnitX.RegisterTestFixture(TConfiguradorMetaDataTeste);

end.
