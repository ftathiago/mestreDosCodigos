unit DataSet.Impl.MetaDataContainer;

interface

uses
  FireDac.Comp.DataSet,
  FireDac.Comp.Client,
  FireDac.Stan.Option,
  DataSet.Intf.MetaDataContainer;

type
  TMetaDataContainer = class(TInterfacedObject, IMetaDataContainer)
  private
    FEntidade: TFDQuery;
    FEntPropriedade: TFDQuery;
    procedure PrepararSQLEntidade;
    procedure PrepararSQLEntPropriedade;
    procedure CriarIndiceEntidade;
    procedure CriarIndiceEntPropriedade;
    procedure OtimizarDataSet(ADataSet: TFDCustomQuery);
  public
    function Entidade: TFDDataSet;
    function EntPropriedade: TFDDataSet;
    procedure AfterConstruction; override;
    class function New(Connection: TFDCustomConnection): IMetaDataContainer;
    constructor Create(Connection: TFDCustomConnection);
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils,
  Conexao.Intf.DataFabrica,
  Conexao.Impl.Fabrica.FireDac;

{ TMetaDataContainer }

procedure TMetaDataContainer.AfterConstruction;
begin
  inherited;
  PrepararSQLEntidade;
  OtimizarDataSet(FEntidade);

  PrepararSQLEntPropriedade;
  OtimizarDataSet(FEntPropriedade);
end;

constructor TMetaDataContainer.Create(Connection: TFDCustomConnection);
var
  _fabricaFireDac: IDataFabrica;
begin
  _fabricaFireDac := TFabricaFireDac.New;

  FEntidade := _fabricaFireDac.getQuery(Connection) as TFDQuery;

  FEntPropriedade :=  _fabricaFireDac.getQuery(Connection) as TFDQuery;
end;

procedure TMetaDataContainer.CriarIndiceEntidade;
const
  IDX_NAME = 'IDX_ENTIDADE';
var
  _index: TFDIndex;
begin
  if FEntidade.IndexName.Equals(IDX_NAME) then
    exit;

  FEntidade.Indexes.FindIndex(IDX_NAME);
  _index := FEntidade.Indexes.Add;
  _index.Name := IDX_NAME;
  _index.Fields := 'NOME';
  _index.Selected := True;
  _index.Active := True;

  FEntidade.IndexesActive := False;

  FEntidade.IndexName := IDX_NAME;
end;

procedure TMetaDataContainer.CriarIndiceEntPropriedade;
const
  IDX_NAME = 'IDX_ENT_PROPRIEDADE';
var
  _index: TFDIndex;
begin
  if FEntPropriedade.IndexName.Equals(IDX_NAME) then
    exit;

  FEntPropriedade.Indexes.FindIndex(IDX_NAME);
  _index := FEntPropriedade.Indexes.Add;
  _index.Name := IDX_NAME;
  _index.Fields := 'ENTIDADE_ID;NOME';
  _index.Selected := True;
  _index.Active := True;

  FEntPropriedade.IndexesActive := False;

  FEntPropriedade.IndexName := IDX_NAME;
end;

destructor TMetaDataContainer.Destroy;
begin
  FEntidade.Close;
  FEntPropriedade.Close;
  FreeAndNil(FEntidade);
  FreeAndNil(FEntPropriedade);
  inherited;
end;

function TMetaDataContainer.Entidade: TFDDataSet;
begin
  if not FEntidade.Active then
  begin
    FEntidade.Open();
    CriarIndiceEntidade;
  end;

  result := FEntidade;
end;

function TMetaDataContainer.EntPropriedade: TFDDataSet;
begin
  if not FEntPropriedade.Active then
  begin
    FEntPropriedade.Open();
    CriarIndiceEntPropriedade;
  end;

  result := FEntPropriedade;
end;

class function TMetaDataContainer.New(Connection: TFDCustomConnection): IMetaDataContainer;
begin
  result := Create(Connection);
end;

procedure TMetaDataContainer.OtimizarDataSet(ADataSet: TFDCustomQuery);
begin
  ADataSet.FetchOptions.AssignedValues := [evItems, evCache];
  ADataSet.FetchOptions.Items := [fiDetails];
  ADataSet.FetchOptions.Cache := [fiDetails];
  ADataSet.UpdateOptions.AssignedValues := [uvEDelete, uvEInsert, uvEUpdate];
  ADataSet.UpdateOptions.EnableDelete := False;
  ADataSet.UpdateOptions.EnableInsert := False;
  ADataSet.UpdateOptions.EnableUpdate := False;
end;

procedure TMetaDataContainer.PrepararSQLEntidade;
begin
  FEntidade.SQL.Add('select *');
  FEntidade.SQL.Add('from ENTIDADE');
end;

procedure TMetaDataContainer.PrepararSQLEntPropriedade;
begin
  FEntPropriedade.SQL.Add('select *');
  FEntPropriedade.SQL.Add('from ENT_PROPRIEDADE');
end;

end.
