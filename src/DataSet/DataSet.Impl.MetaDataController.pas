unit DataSet.Impl.MetaDataController;

interface

uses
  System.Classes,
  Data.DB,
  FireDac.DApt,
  FireDac.Stan.Option,
  FireDac.Comp.Client,
  FireDac.Comp.DataSet,
  DataSet.Intf.MetaDataContainer,
  DataSet.Intf.MetaDataController;

type
  TmcAtributosDeCampo = record
    SomenteLeitura: boolean;
    Requerido: boolean;
  end;

  TmcMetaDataController = class(TInterfacedObject, ImcMetaDataController)
  private
    FConnection: TFDConnection;
    FTabelas: TFDMetaInfoQuery;
    FTabelasTABLE_NAME: TWideStringField;
    FPropriedade: TFDMetaInfoQuery;
    FPropriedadeCOLUMN_NAME: TWideStringField;
    FPropriedadeCOLUMN_POSITION: TIntegerField;
    FPropriedadeCOLUMN_ATTRIBUTES: TLongWordField;
    FPropriedadeCOLUMN_PRECISION: TIntegerField;
    FPropriedadeCOLUMN_LENGTH: TIntegerField;
    FEntidadeID: integer;
    FEntPropriedadeID: integer;
    FMetaDataContainer: IMetaDataContainer;
    procedure PrepararMetaDatas;
    procedure InicializarTabela(AConnection: TFDCustomConnection);
    procedure InicializarPropriedade(AConnection: TFDCustomConnection);
    procedure DoCarregar;
    function InsertEntidade: integer;
    procedure CarregarPropriedades(const AEntidadeID: integer; const ANomeEntidade: string);
    procedure FiltrarPropriedades(const ANomeEntidade: string);
    procedure InsertPropridade(const EntidadeID: integer);
    function getProximoEntidade: integer;
    function getProximoPropriedade: integer;
    function getMaxFrom(const NomeTabela: string): integer;
    procedure DefinirAtributos(var _somenteLeitura: string; var _requerido: string);
    procedure DefinirTamanhoDisplay(var _tamanhoDisplay: integer);
    function getAtributosDoCampo(var attr: integer): TmcAtributosDeCampo;
  public
    class function New(AConnection: TFDConnection): ImcMetaDataController;
    constructor Create(AConnection: TFDConnection);
    procedure Limpar(const AIncluindoMetaData: boolean = false);
    procedure Carregar;
    procedure SetMetaDataContainer(const AMetaDataContainer: IMetaDataContainer);
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils,  System.Variants,  System.VarUtils,
  FireDac.Stan.Intf, FireDac.Phys.Intf,
  DataSet.Constantes;

{ TmcMetaDataController }

procedure TmcMetaDataController.Carregar;
begin
  if not Assigned(FMetaDataContainer) then
    raise EMetaDataControllerException.Create(METADATACONTROLLER_CONTAINER_NAO_INFORMADO);

  PrepararMetaDatas;
  DoCarregar;
end;

procedure TmcMetaDataController.CarregarPropriedades(const AEntidadeID: integer;
  const ANomeEntidade: string);
begin
  FiltrarPropriedades(ANomeEntidade);
  FPropriedade.First;
  while not FPropriedade.Eof do
  begin
    InsertPropridade(AEntidadeID);
    FPropriedade.Next;
  end;
end;

procedure TmcMetaDataController.InicializarPropriedade(AConnection: TFDCustomConnection);
begin
  if not Assigned(FPropriedade) then
    FPropriedade := TFDMetaInfoQuery.Create(nil);

  if not Assigned(FPropriedade.Connection) then
    FPropriedade.Connection := AConnection;

  FPropriedade.MetaInfoKind := mkTableFields;
  FPropriedade.TableKinds := [tkTable];

  if FPropriedade.Active then
    FPropriedade.Close;
end;

procedure TmcMetaDataController.InicializarTabela(AConnection: TFDCustomConnection);
begin
  FTabelas := TFDMetaInfoQuery.Create(nil);
  FTabelas.Connection := AConnection;
  FTabelas.TableKinds := [tkTable, tkView];
  FTabelas.Open();

  FTabelasTABLE_NAME := FTabelas.FindField('TABLE_NAME') as TWideStringField;
end;

procedure TmcMetaDataController.DefinirTamanhoDisplay(var _tamanhoDisplay: integer);
begin
  _tamanhoDisplay := FPropriedade.FieldByName('COLUMN_LENGTH').AsInteger;

  if _tamanhoDisplay = 0 then
    _tamanhoDisplay := INTEIRO_INDEFINIDO;
end;

destructor TmcMetaDataController.Destroy;
begin
  FTabelas.Close;
  FPropriedade.Close;
  FreeAndNil(FTabelas);
  FreeAndNil(FPropriedade);
  inherited;
end;

procedure TmcMetaDataController.DoCarregar;
var
  _idEntidade: integer;
begin
  FConnection.StartTransaction;
  try
    while not FTabelas.Eof do
    begin
      _idEntidade := InsertEntidade();
      CarregarPropriedades(_idEntidade, FTabelasTABLE_NAME.AsString);
      FTabelas.Next;
    end;
    FConnection.Commit;
  except
    FConnection.Rollback;
    raise;
  end;
end;

procedure TmcMetaDataController.DefinirAtributos(var _somenteLeitura: string;
  var _requerido: string);
var
  _atributos: TmcAtributosDeCampo;
  _attrInt: integer;
begin
  _somenteLeitura := BOOLEAN_FALSE;
  _requerido := BOOLEAN_FALSE;

  _attrInt := FPropriedade.FieldByName('COLUMN_ATTRIBUTES').AsInteger;

  _atributos := getAtributosDoCampo(_attrInt);

  if _atributos.SomenteLeitura then
    _somenteLeitura := BOOLEAN_TRUE;

  if _atributos.Requerido then
    _requerido := BOOLEAN_TRUE;
end;

constructor TmcMetaDataController.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
  FEntidadeID := INTEIRO_INDEFINIDO;
  FEntPropriedadeID := INTEIRO_INDEFINIDO;

  InicializarTabela(AConnection);
  InicializarPropriedade(AConnection);
end;

procedure TmcMetaDataController.FiltrarPropriedades(const ANomeEntidade: string);
const
  IDX_COLUMN_NAME = 'IDX_COLUMN_NAME';
var
  _idx: TFDIndex;
  _indiceJaCriado: boolean;
begin
  FPropriedade.Close;

  FPropriedade.ObjectName := ANomeEntidade;

  FPropriedade.Open();

  _indiceJaCriado := Assigned(FPropriedade.Indexes.FindIndex('IDX_COLUMN_NAME'));
  if not _indiceJaCriado then
  begin
    _idx := FPropriedade.Indexes.Add;
    _idx.Name := 'IDX_COLUMN_NAME';
    _idx.Fields := 'COLUMN_NAME';
    _idx.Active := True;
    _idx.Selected := True;
  end;
  FPropriedade.IndexName := 'IDX_COLUMN_NAME';
  FPropriedadeCOLUMN_NAME := FPropriedade.FindField('COLUMN_NAME') as TWideStringField;
  FPropriedadeCOLUMN_POSITION := FPropriedade.FindField('COLUMN_POSITION') as TIntegerField;
  FPropriedadeCOLUMN_ATTRIBUTES := FPropriedade.FindField('COLUMN_ATTRIBUTES') as TLongWordField;
  FPropriedadeCOLUMN_PRECISION := FPropriedade.FindField('COLUMN_PRECISION') as TIntegerField;;
  FPropriedadeCOLUMN_LENGTH := FPropriedade.FindField('COLUMN_LENGTH') as TIntegerField;;

  FPropriedade.First;
end;

function TmcMetaDataController.getAtributosDoCampo(var attr: integer): TmcAtributosDeCampo;
var
  _dataAttributes: TFDDataAttributes;
begin
  _dataAttributes := TFDDataAttributes(Pointer(@attr)^);

  result.SomenteLeitura := caReadOnly in _dataAttributes;
  result.Requerido := caAllowNull in _dataAttributes;
end;

function TmcMetaDataController.getMaxFrom(const NomeTabela: string): integer;
var
  _max: Variant;
begin
  result := 0;
  _max := FConnection.ExecSQLScalar(Format('select max(ID) from %s', [NomeTabela]));

  if VarIsNull(_max) then
    exit;

  if not VarIsNumeric(_max) then
    exit;

  result := _max;
end;

function TmcMetaDataController.getProximoEntidade: integer;
begin
  if FEntidadeID = INTEIRO_INDEFINIDO then
    FEntidadeID := getMaxFrom(Entidade);

  Inc(FEntidadeID, 1);

  result := FEntidadeID;
end;

function TmcMetaDataController.getProximoPropriedade: integer;
begin
  if FEntPropriedadeID = INTEIRO_INDEFINIDO then
    FEntPropriedadeID := getMaxFrom(ENT_PROPRIEDADE);

  Inc(FEntPropriedadeID, 1);

  result := FEntPropriedadeID;
end;

function TmcMetaDataController.InsertEntidade: integer;
var
  _id: integer;
begin
  if FMetaDataContainer.Entidade.FindKey([FTabelasTABLE_NAME.AsString]) then
  begin
    result := FMetaDataContainer.Entidade.FieldByName('ID').AsInteger;
    exit;
  end;
  _id := getProximoEntidade;

  FConnection.ExecSQL(
    INSERT_ENTIDADE,
    [
      _id
        , FTabelasTABLE_NAME.AsString
        , FTabelasTABLE_NAME.AsString
      ],
    [
      ftInteger
        , ftString
        , ftString]);

  result := _id;
end;

procedure TmcMetaDataController.InsertPropridade(const EntidadeID: integer);
var
  _id: integer;
  _tamanhoDisplay: integer;
  _requerido: string;
  _somenteLeitura: string;
begin

  if FMetaDataContainer.EntPropriedade.FindKey([EntidadeID, FPropriedadeCOLUMN_NAME.AsString]) then
    exit;

  _id := getProximoPropriedade;

  DefinirAtributos(_somenteLeitura, _requerido);
  DefinirTamanhoDisplay(_tamanhoDisplay);

  FConnection.ExecSQL(
    INSERT_PROPRIEDADE
      , [_id
        , EntidadeID
        , FPropriedadeCOLUMN_NAME.AsString
        , FPropriedadeCOLUMN_NAME.AsString
        , _requerido
        , _somenteLeitura
        , BOOLEAN_TRUE
        , _tamanhoDisplay
        , FPropriedade.FieldByName('COLUMN_POSITION').AsInteger
      ]
      , [ftInteger
        , ftInteger
        , ftString
        , ftString
        , ftFixedChar
        , ftFixedChar
        , ftFixedChar
        , ftInteger
        , ftInteger]);
end;

procedure TmcMetaDataController.Limpar(const AIncluindoMetaData: boolean = false);
var
  _sql: string;
  _where: string;
begin
  _where := EmptyStr;
  if not AIncluindoMetaData then
  begin
    _where := Format('where (NOME <> %s) and (NOME <> %s)',
      [Entidade.QuotedString, ENT_PROPRIEDADE.QuotedString]);
  end;

  _sql := Format('delete from %s %s', [Entidade, _where]);

  FConnection.StartTransaction;
  try
    FConnection.ExecSQL(_sql);
    FConnection.Commit;
  except
    FConnection.Rollback;
    raise;
  end;
end;

class function TmcMetaDataController.New(AConnection: TFDConnection): ImcMetaDataController;
begin
  result := Create(AConnection);
end;

procedure TmcMetaDataController.PrepararMetaDatas;
begin
  if not FTabelas.Active then
    InicializarTabela(FTabelas.Connection);
  FTabelas.First;

  if not FPropriedade.Active then
    InicializarPropriedade(FPropriedade.Connection);
  FiltrarPropriedades(FTabelasTABLE_NAME.AsString);
end;

procedure TmcMetaDataController.SetMetaDataContainer(const AMetaDataContainer: IMetaDataContainer);
begin
  FMetaDataContainer := nil;
  FMetaDataContainer := AMetaDataContainer;
end;

end.
