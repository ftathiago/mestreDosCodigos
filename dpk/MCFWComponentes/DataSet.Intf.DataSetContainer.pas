unit DataSet.Intf.DataSetContainer;

interface

uses
  Data.DB,
  FireDac.Comp.DataSet;

type
  IDataSetContainer = interface(IInterface)
    ['{B5F06BC3-2C79-4721-BF76-3FFEA53063DC}']
    procedure setDataSet(ADataSet: TFDDataSet);
    function getDataSet: TFDDataSet;
    property DataSet: TFDDataSet read getDataSet write setDataSet;
  end;

implementation

end.
