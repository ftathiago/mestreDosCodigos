unit Conexao.Intf.DataFabrica;

interface

uses
  Data.DB,
  FireDac.Comp.Client;

type
  IDataFabrica = interface(IInterface)
    ['{133D5838-6EEA-46C9-A5D1-7D1B00DC2441}']
    function getConexao: TCustomConnection;
    function getQuery(Connection: TCustomConnection = nil): TDataSet;
    function getQuerySomenteLeitura(Connection: TCustomConnection = nil): TDataSet;
  end;

implementation

end.
