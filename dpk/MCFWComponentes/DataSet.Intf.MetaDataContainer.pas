unit DataSet.Intf.MetaDataContainer;

interface

uses
  FireDac.Comp.DataSet;

type
  IMetaDataContainer = interface(IInterface)
    function Entidade: TFDDataSet;
    function EntPropriedade: TFDDataSet;
  end;

implementation

end.
