unit DataSet.Impl.ConfiguradorMetaData;

interface

uses
  DataSet.Intf.ConfiguradorMetaData,
  Data.DB,
  FireDac.Comp.DataSet;


type
  TConfiguradorMetaData = class(TInterfacedObject, IConfiguradorMetaData)
  private
    FEntidade: TFDDataSet;
    FEntPropriedade: TFDDataSet;
    function LocalizarEntidade(const NomeEntidade: string):boolean;
  public
    procedure setConfigurarDataSet(DataSet: TDataSet; const Entidade: TArray<string>);
    class function New(AEntidade, AEntPropriedade: TFDDataSet):IConfiguradorMetaData;
    constructor Create(AEntidade, AEntPropriedade: TFDDataSet); reintroduce;
  end;

implementation

{ TConfiguradorMetaData }

constructor TConfiguradorMetaData.Create(AEntidade, AEntPropriedade: TFDDataSet);
begin
  inherited Create;
  FEntidade := AEntidade;
  FEntPropriedade := AEntPropriedade;
end;

function TConfiguradorMetaData.LocalizarEntidade(const NomeEntidade: string): boolean;
begin
  result := FEntidade.FindKey([NomeEntidade]);
end;

class function TConfiguradorMetaData.New(AEntidade, AEntPropriedade: TFDDataSet): IConfiguradorMetaData;
begin
  Result :=  Create(AEntidade, AEntPropriedade);
end;

procedure TConfiguradorMetaData.setConfigurarDataSet(DataSet: TDataSet;
  const Entidade: TArray<string>);
begin

end;

end.
