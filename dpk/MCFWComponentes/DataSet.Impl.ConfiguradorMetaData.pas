unit DataSet.Impl.ConfiguradorMetaData;

interface

uses
  DataSet.Intf.ConfiguradorMetaData,
  Data.DB,
  DataSet.Intf.DataSetContainer,
  FireDac.Comp.DataSet;

type
  TEntPropriedadeContainer = class;
  IDSCEntPropriedade = interface;

  TConfiguradorMetaData = class(TInterfacedObject, IConfiguradorMetaData)
  private
    FEntidade: TFDDataSet;
    FEntPropriedade: IDSCEntPropriedade;
    function LocalizarEntidade(const NomeEntidade: string): boolean;
    procedure ConfigurarEntidade(const Entidade: string; DataSet: TDataSet);
  public
    procedure setConfigurarDataSet(DataSet: TDataSet; const Entidade: TArray<string>);
    class function New(AEntidade, AEntPropriedade: TFDDataSet): IConfiguradorMetaData;
    constructor Create(AEntidade, AEntPropriedade: TFDDataSet); reintroduce;
  end;

  IDSCEntPropriedade = Interface(IDataSetContainer)
    ['{2B0FA82A-3590-46E3-B6D7-FD5A3A3E0292}']
    procedure FiltrarEntidade(const EntidadeID: Integer);
    procedure SetCasasDecimais(const Value: integer);
    procedure SetDescricao(const Value: string);
    procedure SetEntidadeId(const Value: integer);
    procedure SetId(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetPosicao(const Value: integer);
    procedure SetRequerido(const Value: boolean);
    procedure SetSomenteLeitura(const Value: boolean);
    procedure SetTamanho(const Value: integer);
    procedure SetTamanhoDisplay(const Value: integer);
    procedure SetVisivel(const Value: boolean);
    function getCasasDecimais: integer;
    function getDescricao: string;
    function getEntidadeId: integer;
    function getId: integer;
    function getNome: string;
    function getPosicao: integer;
    function getRequerido: boolean;
    function getSomenteLeitura: boolean;
    function getTamanho: integer;
    function getTamanhoDisplay: integer;
    function getVisivel: boolean;
    property Id: integer read getId write SetId;
    property EntidadeId: integer read getEntidadeId write SetEntidadeId;
    property Nome: string read getNome write SetNome;
    property Descricao: string read getDescricao write SetDescricao;
    property Tamanho: integer read getTamanho write SetTamanho;
    property CasasDecimais: integer read getCasasDecimais write SetCasasDecimais;
    property Requerido: boolean read getRequerido write SetRequerido;
    property SomenteLeitura: boolean read getSomenteLeitura write SetSomenteLeitura;
    property Visivel: boolean read getVisivel write SetVisivel;
    property TamanhoDisplay: integer read getTamanhoDisplay write SetTamanhoDisplay;
    property Posicao: integer read getPosicao write SetPosicao;
  end;

  TEntPropriedadeContainer = class(TInterfacedObject, IDSCEntPropriedade)
  private
    FDataSet: TFDDataSet;
    FId: TField;
    FEntidadeId: TField;
    FNome: TField;
    FDescricao: TField;
    FTamanho: TField;
    FCasasDecimais: TField;
    FRequerido: TField;
    FSomenteLeitura: TField;
    FVisivel: TField;
    FTamanhoDisplay: TField;
    FPosicao: TField;
    function DataSet: TDataSet;
    procedure SetCasasDecimais(const Value: integer);
    procedure SetDescricao(const Value: string);
    procedure SetEntidadeId(const Value: integer);
    procedure SetId(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetPosicao(const Value: integer);
    procedure SetRequerido(const Value: boolean);
    procedure SetSomenteLeitura(const Value: boolean);
    procedure SetTamanho(const Value: integer);
    procedure SetTamanhoDisplay(const Value: integer);
    procedure SetVisivel(const Value: boolean);
    function getCasasDecimais: integer;
    function getDescricao: string;
    function getEntidadeId: integer;
    function getId: integer;
    function getNome: string;
    function getPosicao: integer;
    function getRequerido: boolean;
    function getSomenteLeitura: boolean;
    function getTamanho: integer;
    function getTamanhoDisplay: integer;
    function getVisivel: boolean;
  public
    procedure FiltrarEntidade(const EntidadeID: Integer);
    procedure SetDataSet(ADataSet: TFDDataSet);
    function GetDataSet: TFDDataSet;
    class function New(ADataSet: TFDDataSet):IDSCEntPropriedade;
    constructor Create(ADataSet: TFDDataSet);
  end;

implementation

{ TConfiguradorMetaData }

uses
  FireDAC.Stan.Intf,
  System.Rtti,
  System.SysUtils,
  umcConstantes,
  uRTTIUtils;

procedure TConfiguradorMetaData.ConfigurarEntidade(const Entidade: string; DataSet: TDataSet);
var
  _field: TField;
begin
  if not LocalizarEntidade(Entidade) then
    exit;

  FEntPropriedade.FiltrarEntidade(FEntidade.FieldByName('ID').AsInteger);

  if FEntPropriedade.DataSet.IsEmpty then
    exit;

  FEntPropriedade.DataSet.First;

  while not FEntPropriedade.DataSet.Eof do
  begin
    _field := DataSet.FindField(FEntPropriedade.Nome);

    if not Assigned(_field) then
    begin
      FEntPropriedade.DataSet.Next;
      Continue;
    end;

    _field.Required := FEntPropriedade.Requerido;
    _field.ReadOnly := FEntPropriedade.SomenteLeitura;
    _field.Visible := FEntPropriedade.Visivel;

    if not (FEntPropriedade.Posicao = INTEIRO_INDEFINIDO) then
      _field.Index := Pred(FEntPropriedade.Posicao);

    if not FEntPropriedade.Descricao.Trim.IsEmpty then
      _field.DisplayLabel := FEntPropriedade.Descricao;

    if not (FEntPropriedade.TamanhoDisplay = INTEIRO_INDEFINIDO) then
      _field.DisplayWidth := FEntPropriedade.TamanhoDisplay;

    FEntPropriedade.DataSet.Next;
  end;
end;

constructor TConfiguradorMetaData.Create(AEntidade, AEntPropriedade: TFDDataSet);
begin
  inherited Create;
  FEntidade := AEntidade;
  FEntPropriedade := TEntPropriedadeContainer.New(AEntPropriedade);
end;

function TConfiguradorMetaData.LocalizarEntidade(const NomeEntidade: string): boolean;
begin
  result := FEntidade.FindKey([NomeEntidade]);
end;

class function TConfiguradorMetaData.New(AEntidade, AEntPropriedade: TFDDataSet)
  : IConfiguradorMetaData;
begin
  result := Create(AEntidade, AEntPropriedade);
end;

procedure TConfiguradorMetaData.setConfigurarDataSet(DataSet: TDataSet;
  const Entidade: TArray<string>);
var
  i: integer;
begin
  for i := 0 to Pred(Length(Entidade)) do
    ConfigurarEntidade(Entidade[i], DataSet);
end;

{ TEntPropriedadeContainer }


constructor TEntPropriedadeContainer.Create(ADataSet: TFDDataSet);
begin
  SetDataSet(ADataSet);
end;

function TEntPropriedadeContainer.DataSet: TDataSet;
begin
  result := FDataSet;
end;

procedure TEntPropriedadeContainer.FiltrarEntidade(const EntidadeID: Integer);
begin
  FDataSet.Filter := Format('ENTIDADE_ID = %d', [EntidadeID]);
  FDataSet.Filtered := True;
end;

function TEntPropriedadeContainer.getCasasDecimais: integer;
begin
  result := FCasasDecimais.AsInteger;
end;

function TEntPropriedadeContainer.GetDataSet: TFDDataSet;
begin
  result := FDataSet;
end;

function TEntPropriedadeContainer.getDescricao: string;
begin
  result := FDescricao.AsString
end;

function TEntPropriedadeContainer.getEntidadeId: integer;
begin
  result := FEntidadeId.AsInteger;
end;

function TEntPropriedadeContainer.getId: integer;
begin
  result := FId.AsInteger;
end;

function TEntPropriedadeContainer.getNome: string;
begin
  result := FNome.AsString;
end;

function TEntPropriedadeContainer.getPosicao: integer;
begin
  result := FPosicao.AsInteger;
end;

function TEntPropriedadeContainer.getRequerido: boolean;
begin
  result := FRequerido.AsString.Equals(BOOLEAN_TRUE);
end;

function TEntPropriedadeContainer.getSomenteLeitura: boolean;
begin
  result := FSomenteLeitura.AsString.Equals(BOOLEAN_TRUE)
end;

function TEntPropriedadeContainer.getTamanho: integer;
begin
  result := FTamanho.AsInteger;
end;

function TEntPropriedadeContainer.getTamanhoDisplay: integer;
begin
  result := FTamanhoDisplay.AsInteger;
end;

function TEntPropriedadeContainer.getVisivel: boolean;
begin
  result := FVisivel.AsString.Equals(BOOLEAN_TRUE);
end;

class function TEntPropriedadeContainer.New(ADataSet: TFDDataSet): IDSCEntPropriedade;
begin
  result := Create(ADataSet);
end;

procedure TEntPropriedadeContainer.SetCasasDecimais(const Value: integer);
begin
  DataSet.Edit;
  FCasasDecimais.AsInteger := Value;
end;

procedure TEntPropriedadeContainer.SetDataSet(ADataSet: TFDDataSet);
begin
  if ADataSet <> FDataSet then
  begin
    FDataSet := ADataSet;
    FId := FDataSet.FindField('ID');
    FEntidadeId := FDataSet.FindField('ENTIDADE_ID');
    FNome := FDataSet.FindField('NOME');
    FDescricao := FDataSet.FindField('DESCRICAO');
    FTamanho := FDataSet.FindField('TAMANHO');
    FCasasDecimais := FDataSet.FindField('CASAS_DECIMAIS');
    FRequerido := FDataSet.FindField('REQUERIDO');
    FSomenteLeitura := FDataSet.FindField('SOMENTE_LEITURA');
    FVisivel := FDataSet.FindField('VISIVEL');
    FTamanhoDisplay := FDataSet.FindField('TAMANHO_DISPLAY');
    FPosicao := FDataSet.FindField('POSICAO');
  end;
end;

procedure TEntPropriedadeContainer.SetDescricao(const Value: string);
begin
  DataSet.Edit;
  FDescricao.AsString := Value;
end;

procedure TEntPropriedadeContainer.SetEntidadeId(const Value: integer);
begin
  DataSet.Edit;
  FEntidadeId.AsInteger := Value;
end;

procedure TEntPropriedadeContainer.SetId(const Value: integer);
begin
  DataSet.Edit;
  FId.AsInteger := Value;
end;

procedure TEntPropriedadeContainer.SetNome(const Value: string);
begin
    DataSet.Edit;
  FNome.AsString := Value;
end;

procedure TEntPropriedadeContainer.SetPosicao(const Value: integer);
begin
  DataSet.Edit;
  FPosicao.AsInteger := Value;
end;

procedure TEntPropriedadeContainer.SetRequerido(const Value: boolean);
begin
  DataSet.Edit;
  if Value then
    FRequerido.AsString := BOOLEAN_TRUE
  else
    FRequerido.AsString := BOOLEAN_FALSE;
end;

procedure TEntPropriedadeContainer.SetSomenteLeitura(const Value: boolean);
begin
  DataSet.Edit;
  if Value then
    FSomenteLeitura.AsString := BOOLEAN_TRUE
  else
    FSomenteLeitura.AsString := BOOLEAN_FALSE;
end;

procedure TEntPropriedadeContainer.SetTamanho(const Value: integer);
begin
  DataSet.Edit;
  FTamanho.AsInteger := Value;
end;

procedure TEntPropriedadeContainer.SetTamanhoDisplay(const Value: integer);
begin
  DataSet.Edit;
  FTamanhoDisplay.AsInteger := Value;
end;

procedure TEntPropriedadeContainer.SetVisivel(const Value: boolean);
begin
  DataSet.Edit;
  if Value then
    FVisivel.AsString := BOOLEAN_TRUE
  else
    FVisivel.AsString := BOOLEAN_FALSE;
end;


end.
