unit Conexao.Impl.Configuracao;

interface

uses
  System.Classes,
  Conexao.Intf.Configuracao;

type
  TumcConexaoConfiguracao = class(TInterfacedObject, IConexaoConfiguracao)
  private
    FOutrasConfiguracoes: TStrings;
    FDataBase: string;
    FPassword: string;
    FUserName: string;
    FServer: string;
    FSchema: string;
    FCharacter: String;
    FDriverID: string;
    FPooled: boolean;
    FPorta: integer;
    FProtocolo: string;
  protected
    procedure SetDataBase(const Value: string);
    procedure SetOutrasConfiguracoes(const Value: TStrings);
    procedure SetPassword(const Value: string);
    procedure SetSchema(const Value: string);
    procedure SetServer(const Value: string);
    procedure SetUserName(const Value: string);
    function GetDataBase: string;
    function GetOutrasConfiguracoes: TStrings;
    function GetPassword: string;
    function GetSchema: string;
    function GetServer: string;
    function GetUserName: string;
    function GetCharacter: string;
    function GetDriverID: string;
    function GetPooled: Boolean;
    function GetPorta: Integer;
    function GetProtocolo: string;
    procedure SetCharacter(const Value: string);
    procedure SetDriverID(const Value: string);
    procedure SetPooled(const Value: Boolean);
    procedure SetPorta(const Value: Integer);
    procedure SetProtocolo(const Value: string);
  public
    class function New: IConexaoConfiguracao;
    constructor Create(); reintroduce;
    destructor Destroy; override;
    property Server: string read GetServer write SetServer;
    property DataBase: string read GetDataBase write SetDataBase;
    property Schema: string read GetSchema write SetSchema;
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword write SetPassword;
    property Protocolo: string read GetProtocolo write SetProtocolo;
    property Porta: integer read GetPorta write SetPorta;
    property Character: string read GetCharacter write SetCharacter;
    property DriverID: string read GetDriverID write SetDriverID;
    property Pooled: boolean read GetPooled write SetPooled;
    property OutrasConfiguracoes: TStrings read GetOutrasConfiguracoes write SetOutrasConfiguracoes;
  end;

implementation

uses
  System.SysUtils;

{ TumcConfigCon }

constructor TumcConexaoConfiguracao.Create;
begin
  inherited Create;
  FOutrasConfiguracoes := TStringList.Create;
end;

destructor TumcConexaoConfiguracao.Destroy;
begin
  if Assigned(FOutrasConfiguracoes) then
    FreeAndNil(FOutrasConfiguracoes);
  inherited;
end;

function TumcConexaoConfiguracao.GetCharacter: string;
begin
  result := FCharacter;
end;

function TumcConexaoConfiguracao.GetDataBase: string;
begin
  result := FDataBase;
end;

function TumcConexaoConfiguracao.GetDriverID: string;
begin
  result := FDriverID;
end;

function TumcConexaoConfiguracao.GetOutrasConfiguracoes: TStrings;
begin
  result := FOutrasConfiguracoes;
end;

function TumcConexaoConfiguracao.GetPassword: string;
begin
  result := FPassword;
end;

function TumcConexaoConfiguracao.GetPooled: Boolean;
begin
  result := FPooled;
end;

function TumcConexaoConfiguracao.GetPorta: Integer;
begin
  result := FPorta;
end;

function TumcConexaoConfiguracao.GetProtocolo: string;
begin
  result := FProtocolo;
end;

function TumcConexaoConfiguracao.GetSchema: string;
begin
  result := FSchema;
end;

function TumcConexaoConfiguracao.GetServer: string;
begin
  result := FServer;
end;

function TumcConexaoConfiguracao.GetUserName: string;
begin
  result := FUserName;
end;

class function TumcConexaoConfiguracao.New: IConexaoConfiguracao;
begin
  result := Create;
end;

procedure TumcConexaoConfiguracao.SetCharacter(const Value: string);
begin
  FCharacter := Value;
end;

procedure TumcConexaoConfiguracao.SetDataBase(const Value: string);
begin
  FDataBase := Value;
end;

procedure TumcConexaoConfiguracao.SetDriverID(const Value: string);
begin
  FDriverID := Value;
end;

procedure TumcConexaoConfiguracao.SetOutrasConfiguracoes(const Value: TStrings);
begin
  FOutrasConfiguracoes := Value;
end;

procedure TumcConexaoConfiguracao.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure TumcConexaoConfiguracao.SetPooled(const Value: Boolean);
begin
  FPooled := Value;
end;

procedure TumcConexaoConfiguracao.SetPorta(const Value: Integer);
begin
  FPorta := Value;
end;

procedure TumcConexaoConfiguracao.SetProtocolo(const Value: string);
begin
  FProtocolo := Value;
end;

procedure TumcConexaoConfiguracao.SetSchema(const Value: string);
begin
  FSchema := Value;
end;

procedure TumcConexaoConfiguracao.SetServer(const Value: string);
begin
  FServer := Value;
end;

procedure TumcConexaoConfiguracao.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

end.
