unit Conexao.Impl.ConfiguracaoIni;

interface

uses
  System.SysUtils,
  System.IniFiles,
  Conexao.Intf.Configuracao;

type
  TCarregadorConexaoIni = class(TInterfacedObject, IConexaoCarregador)
  private
    FIniFile: TIniFile;
  public
    class function New: IConexaoCarregador;
    constructor Create;
    destructor Destroy; override;
    procedure CarregarConfiguracoes(const ConexaoConfiguracao: IConexaoConfiguracao);
    procedure SalvarConfiguracoes(const ConexaoConfiguracao: IConexaoConfiguracao);
    procedure SetNomeOrigem(const NomeOrigem: string);
  end;

implementation

const
  SECTION = 'DATABASE_CONF';

  { TConexaoConfiguracaoIni }

procedure TCarregadorConexaoIni.CarregarConfiguracoes(
  const ConexaoConfiguracao: IConexaoConfiguracao);
begin
  ConexaoConfiguracao.Server := FIniFile.ReadString(SECTION, 'Server', '127.0.0.1');
  ConexaoConfiguracao.DataBase := FIniFile.ReadString(SECTION, 'DataBase', 'DATABASE');
  ConexaoConfiguracao.Schema := FIniFile.ReadString(SECTION, 'Schema', 'SCHEMA');
  ConexaoConfiguracao.UserName := FIniFile.ReadString(SECTION, 'UserName', 'USERNAME');
  ConexaoConfiguracao.Password := FIniFile.ReadString(SECTION, 'Password', 'password');
  ConexaoConfiguracao.Protocolo := FIniFile.ReadString(SECTION, 'Protocolo', '');
  ConexaoConfiguracao.Porta := FIniFile.ReadInteger(SECTION, 'Porta',0);
  ConexaoConfiguracao.Character := FIniFile.ReadString(SECTION, 'Character', 'NONE');
  ConexaoConfiguracao.DriverID := FIniFile.ReadString(SECTION, 'DriverID', '');
  ConexaoConfiguracao.Pooled := FIniFile.ReadBool(SECTION, 'Pooled', False);
  ConexaoConfiguracao.OutrasConfiguracoes.Text := FIniFile.ReadString(SECTION,
    'OutrasConfiguracoes', '');
end;

constructor TCarregadorConexaoIni.Create;
begin

end;

destructor TCarregadorConexaoIni.Destroy;
begin
  if Assigned(FIniFile) then
    FreeAndNil(FIniFile);
  inherited;
end;

class function TCarregadorConexaoIni.New: IConexaoCarregador;
begin
  result := Create;
end;

procedure TCarregadorConexaoIni.SalvarConfiguracoes(const ConexaoConfiguracao
    : IConexaoConfiguracao);
begin
  FIniFile.WriteString(SECTION, 'Server', ConexaoConfiguracao.Server);
  FIniFile.WriteString(SECTION, 'DataBase', ConexaoConfiguracao.DataBase);
  FIniFile.WriteString(SECTION, 'Schema', ConexaoConfiguracao.Schema);
  FIniFile.WriteString(SECTION, 'UserName', ConexaoConfiguracao.UserName);
  FIniFile.WriteString(SECTION, 'Password', ConexaoConfiguracao.Password);
  FIniFile.WriteString(SECTION, 'Protocolo', ConexaoConfiguracao.Protocolo);
  FIniFile.WriteInteger(SECTION, 'Porta',  ConexaoConfiguracao.Porta);
  FIniFile.WriteString(SECTION, 'Character', ConexaoConfiguracao.Character);
  FIniFile.WriteString(SECTION, 'DriverID', ConexaoConfiguracao.DriverID);
  FIniFile.WriteBool(SECTION, 'Pooled',  ConexaoConfiguracao.Pooled);
  FIniFile.WriteString(SECTION, 'OutrasConfiguracoes',
    ConexaoConfiguracao.OutrasConfiguracoes.Text);
end;

procedure TCarregadorConexaoIni.SetNomeOrigem(const NomeOrigem: string);
begin
  FIniFile := TIniFile.Create(NomeOrigem);
end;

end.
