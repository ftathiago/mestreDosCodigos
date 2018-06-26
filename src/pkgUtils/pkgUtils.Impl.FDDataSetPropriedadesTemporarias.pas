unit pkgUtils.Impl.FDDataSetPropriedadesTemporarias;

interface

uses
  Data.DB, FireDac.Comp.DataSet, pkgUtils.Intf.DataSetPropriedadesTemporarias;

type
  TFDDataSetPropriedadesTemporarias = class(TInterfacedObject, IDataSetPropriedadesTemporarias)
  private
    FFilter: string;
    FFiltered: boolean;
    FIndexName: string;
    FIndexFieldNames: string;
    FDataSet: TFDDataSet;
    FBookMark: TBookMark;
    procedure ArmazenarDados;
    procedure DevolverDados;
  protected
    function getFilter: string;
    function getFiltered: boolean;
    function getIndexName: string;
    function getIndexFieldNames: string;
  public
    class function New(const ADataSet: TFDDataSet): IDataSetPropriedadesTemporarias;
    constructor Create(const ADataSet: TFDDataSet);
    destructor Destroy; override;
    procedure GuardarBookMark;
    procedure IrParaBookMark;
    property Filter: string read getFilter;
    property Filtered: boolean read getFiltered;
    property IndexName: string read getIndexName;
    property IndexFieldNames: string read getIndexFieldNames;
  end;

implementation

class function TFDDataSetPropriedadesTemporarias.New(const ADataSet: TFDDataSet)
  : IDataSetPropriedadesTemporarias;
begin
  result := Create(ADataSet);
end;

constructor TFDDataSetPropriedadesTemporarias.Create(const ADataSet: TFDDataSet);
begin
  FDataSet := ADataSet;
  ArmazenarDados;
end;

destructor TFDDataSetPropriedadesTemporarias.Destroy;
begin
  DevolverDados;
  inherited;
end;

procedure TFDDataSetPropriedadesTemporarias.DevolverDados;
begin
  FDataSet.Filter := FFilter;
  FDataSet.Filtered := FFiltered;
  FDataSet.IndexName := FIndexName;
  FDataSet.IndexFieldNames := FIndexFieldNames;
end;

procedure TFDDataSetPropriedadesTemporarias.ArmazenarDados;
begin
  FFilter := FDataSet.Filter;
  FFiltered := FDataSet.Filtered;
  FIndexFieldNames := FDataSet.IndexFieldNames;
  FIndexName := FDataSet.IndexName;
end;

function TFDDataSetPropriedadesTemporarias.getFilter: string;
begin
  result := FFilter;
end;

function TFDDataSetPropriedadesTemporarias.getFiltered: boolean;
begin
  result := FFiltered;
end;

function TFDDataSetPropriedadesTemporarias.getIndexFieldNames: string;
begin
  result := FIndexFieldNames;
end;

function TFDDataSetPropriedadesTemporarias.getIndexName: string;
begin
  result := FIndexName;
end;

procedure TFDDataSetPropriedadesTemporarias.GuardarBookMark;
begin
  FBookMark := FDataSet.GetBookmark;
end;

procedure TFDDataSetPropriedadesTemporarias.IrParaBookMark;
begin
  FDataSet.GotoBookmark(FBookMark);
end;

end.
