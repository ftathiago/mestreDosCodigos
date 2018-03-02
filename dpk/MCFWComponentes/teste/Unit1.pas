unit Unit1;

interface

uses
  DUnitX.TestFramework,
  FireDac.Comp.DataSet,
  FireDac.Comp.Client,
  DataSet.Intf.ConfiguradorMetaData;

type

  [TestFixture]
  TConfiguradorMetaDataTeste = class(TObject)
  private
    FEntidade: TFDDataSet;
    FEntPropriedade: TFDDataSet;
    FConfiguradorMetaData: IConfiguradorMetaData;
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
    [TestCase('TestA', '1,2')]
    [TestCase('TestB', '3,4')]
    procedure TestePropriedadesTexto(const NomePropriedade: string; const ValorEsperado: string);
    [Test]
    [TestCase('TestA', '1,2')]
    [TestCase('TestB', '3,4')]
    procedure TestePropriedadesInteiro(const NomePropriedade: string; const ValorEsperado: Integer);
  end;

implementation

uses
  System.SysUtils,
  Teste.FonteDados,
  DataSet.Impl.ConfiguradorMetaData;

procedure TConfiguradorMetaDataTeste.Setup;
var
  _fonteDados: TFonteDados;
begin
  _fonteDados := TFonteDados.Create;
  try
    FEntidade := _fonteDados.getEntidadeCarregada;
    FEntPropriedade := _fonteDados.getEntPropriedadeCarregada;
    FConfiguradorMetaData := TConfiguradorMetaData.New(FEntidade, FEntPropriedade);
  finally
    _fonteDados.Free;
  end;
end;

procedure TConfiguradorMetaDataTeste.TearDown;
begin
  FreeAndNil(FEntidade);
  FreeAndNil(FEntPropriedade);
end;

procedure TConfiguradorMetaDataTeste.Test1;
begin

end;

procedure TConfiguradorMetaDataTeste.TestePropriedadesInteiro(const NomePropriedade: string;
  const ValorEsperado: Integer);
begin

end;

procedure TConfiguradorMetaDataTeste.TestePropriedadesTexto(const NomePropriedade: string; const ValorEsperado: string);
begin
end;

initialization

TDUnitX.RegisterTestFixture(TConfiguradorMetaDataTeste);

end.
