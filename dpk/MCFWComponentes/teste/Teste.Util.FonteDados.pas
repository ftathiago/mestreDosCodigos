unit Teste.Util.FonteDados;

interface

uses
  DataSet.Intf.MetaDataContainer,
  Data.DB,
  FireDac.Stan.Intf,
  FireDac.Comp.Client,
  FireDac.Comp.DataSet;

type
  TFonteDados = class
  private
    { private declarations }
    FDConnection: TFDConnection;
    FMetaDataContainer: IMetaDataContainer;
  protected
    { protected declarations }
    procedure CriarEntPropriedade(ADataSet: TFDDataSet);
    procedure CriarIndiceENTIDADE(ADataSet: TFDDataSet);
  public
    { public declarations }
    constructor Create;
    function getDataSet: TFDDataSet;
    function getEntidadeCarregada: TFDDataSet;
    function getEstruturaEntidade: TFDMemTable;
    function getEstruturaEntPropriedade: TFDMemTable;
    function getEntPropriedadeCarregada: TFDDataSet;
    function getMemTable: TFDMemTable;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils,
  DataSet.Impl.MetaDataContainer,
  Conexao.Impl.Fabrica.FireDac,
  Vcl.Forms;

{ TFonteDados }

constructor TFonteDados.Create;
begin
  FDConnection := TFabricaFireDac.New.getConexao as TFDConnection;
  FMetaDataContainer := TMetaDataContainer.New(FDConnection);
end;

procedure TFonteDados.CriarEntPropriedade(ADataSet: TFDDataSet);
const
  IDX_NAME = 'IDX_ENT_PROPRIEDADE';
var
  _index: TFDIndex;
begin
  if ADataSet.IndexName.Equals(IDX_NAME) then
    exit;

  if not Assigned(ADataSet.Indexes.FindIndex(IDX_NAME)) then
  begin
    _index := ADataSet.Indexes.Add;
    _index.Name := IDX_NAME;
    _index.Fields := 'ENTIDADE_ID;NOME';
    _index.Selected := True;
    _index.Active := True;
  end;
  ADataSet.IndexesActive := True;

  ADataSet.IndexName := IDX_NAME;
end;

procedure TFonteDados.CriarIndiceENTIDADE(ADataSet: TFDDataSet);
const
  IDX_NAME = 'IDX_ENTIDADE';
var
  _index: TFDIndex;
begin
  if ADataSet.IndexName.Equals(IDX_NAME) then
    exit;

  ADataSet.Indexes.FindIndex(IDX_NAME);
  _index := ADataSet.Indexes.Add;
  _index.Name := IDX_NAME;
  _index.Fields := 'NOME';
  _index.Selected := True;
  _index.Active := True;

  ADataSet.IndexesActive := False;

  ADataSet.IndexName := IDX_NAME;
end;

destructor TFonteDados.Destroy;
begin
  FMetaDataContainer := nil;
  FDConnection.Close;
  FreeAndNil(FDConnection);
  inherited;
end;

function TFonteDados.getDataSet: TFDDataSet;
begin
  result := TFabricaFireDac.New.getQuery(FDConnection) as TFDDataSet;
end;

function TFonteDados.getEntidadeCarregada: TFDDataSet;
begin
  result := FMetaDataContainer.Entidade;
  CriarIndiceENTIDADE(result);
end;

function TFonteDados.getEntPropriedadeCarregada: TFDDataSet;
begin
  result := FMetaDataContainer.EntPropriedade;
  CriarEntPropriedade(result);
end;

function TFonteDados.getEstruturaEntidade: TFDMemTable;
begin
  result := TFDMemTable.Create(nil);
  result.Data := getEntidadeCarregada.Data;
end;

function TFonteDados.getEstruturaEntPropriedade: TFDMemTable;
begin
  result := TFDMemTable.Create(nil);
  result.Data := getEntPropriedadeCarregada.Data;
end;

function TFonteDados.getMemTable: TFDMemTable;
begin
  result := TFDMemTable.Create(nil);
end;

end.
