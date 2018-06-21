unit DDD.Teste.Mock.Entidade;

interface

uses
  Data.DB, FireDac.Comp.Client,
  DDD.Anotacao.Entidade.Propriedade, DDD.Core.Intf.Entidade, DDD.Core.Impl.Entidade;

type
  IMockEntidade = Interface(IEntidade)
    function GetCampo1: string;
    function GetCampo2: integer;
    procedure SetCampo1(const Value: string);
    procedure SetCampo2(const Value: integer);
    property Campo1: string read GetCampo1 write SetCampo1;
    property Campo2: integer read GetCampo2 write SetCampo2;
  end;

  TMockEntidade = class(TEntidade, IMockEntidade)
  protected
    FCampo2: integer;
    FCampo1: string;
    function GetCampo1: string;
    function GetCampo2: integer;
    procedure SetCampo1(const Value: string);
    procedure SetCampo2(const Value: integer);
    function GetNomeEntidade: string; override;
  public
    class function New: IMockEntidade;
    [TPropriedade('CAMPO1', ftString, False)]
    property Campo1: string read GetCampo1 write SetCampo1;
    [TPropriedade('CAMPO2', ftInteger, False)]
    property Campo2: integer read GetCampo2 write SetCampo2;
  end;

const
  NOME_ENTIDADE_MOCK = 'NomeEntidade';
  VALOR_CAMPO1 = 'Valor campo1';
  VALOR_CAMPO2 = 1;

procedure ConfigurarDataSet(const ADataSet: TFDMemTable);
procedure InserirDadosPadrao(const ADataSet: TFDMemTable);

implementation

procedure ConfigurarDataSet(const ADataSet: TFDMemTable);
begin
  ADataSet.FieldDefs.Add('Campo1', ftString, 30);
  ADataSet.FieldDefs.Add('Campo2', ftInteger);
  ADataSet.CreateDataSet;
end;

procedure InserirDadosPadrao(const ADataSet: TFDMemTable);
begin
  ADataSet.Insert;
  ADataSet.FieldByName('CAMPO1').AsString := VALOR_CAMPO1;
  ADataSet.FieldByName('CAMPO2').AsInteger := VALOR_CAMPO2;
  ADataSet.Post;
end;

function TMockEntidade.GetCampo1: string;
begin
  result := FCampo1;
end;

function TMockEntidade.GetCampo2: integer;
begin
  result := FCampo2;
end;

function TMockEntidade.GetNomeEntidade: string;
begin
  result := NOME_ENTIDADE_MOCK;
end;

class function TMockEntidade.New: IMockEntidade;
begin
  result := Create;
end;

procedure TMockEntidade.SetCampo1(const Value: string);
begin
  FCampo1 := Value;
end;

procedure TMockEntidade.SetCampo2(const Value: integer);
begin
  FCampo2 := Value;
end;

end.
