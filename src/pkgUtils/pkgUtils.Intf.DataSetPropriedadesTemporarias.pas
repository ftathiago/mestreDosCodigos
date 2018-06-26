unit pkgUtils.Intf.DataSetPropriedadesTemporarias;

interface

type
  IDataSetPropriedadesTemporarias = Interface(IInterface)
    ['{94B1229E-6DA5-4DBB-8DB9-147A7B9752BD}']
    function getFilter: string;
    function getFiltered: boolean;
    function getIndexName: string;
    function getIndexFieldNames: string;
    procedure GuardarBookMark;
    procedure IrParaBookMark;
    property Filter: string read getFilter;
    property Filtered: boolean read getFiltered;
    property IndexName: string read getIndexName;
    property IndexFieldNames: string read getIndexFieldNames;
  end;

implementation

end.
