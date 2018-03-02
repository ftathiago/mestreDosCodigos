unit DataSet.Intf.ConfiguradorMetaData;

interface

uses
  Data.DB,
  FireDac.Comp.DataSet;

type
  IConfiguradorMetaData = Interface(IInterface)
    ['{CEACB0FD-B268-436D-AACE-C0CFB6EE30F8}']
    procedure setConfigurarDataSet(DataSet: TDataSet; const Entidade: TArray<string>);
  end;

implementation


end.
