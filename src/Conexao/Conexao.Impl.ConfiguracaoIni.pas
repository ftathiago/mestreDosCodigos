//***********************************************************************************************************
// Classe especialista em carregar configurações à partir do arquivo INI
// Autor: ftathiago@gmail.com
// Data: 2018-04-12
//***********************************************************************************************************

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

uses
  Conexao.Constantes;

const
  SECTION = 'DATABASE_CONF';

  { TConexaoConfiguracaoIni }

procedure TCarregadorConexaoIni.CarregarConfiguracoes(
  const ConexaoConfiguracao: IConexaoConfiguracao);
begin
  ConexaoConfiguracao.Server := FIniFile.ReadString(SECTION, 'Server', DEFAULT_SERVER);
  ConexaoConfiguracao.DataBase := FIniFile.ReadString(SECTION, 'DataBase', DEFAULT_DATABASE);
  ConexaoConfiguracao.Schema := FIniFile.ReadString(SECTION, 'Schema', DEFAULT_SCHEMA);
  ConexaoConfiguracao.UserName := FIniFile.ReadString(SECTION, 'UserName', DEFAULT_USERNAME);
  ConexaoConfiguracao.Password := FIniFile.ReadString(SECTION, 'Password', DEFAULT_PASSWORD);
  ConexaoConfiguracao.Protocolo := FIniFile.ReadString(SECTION, 'Protocolo', DEFAULT_PROTOCOLO);
  ConexaoConfiguracao.Porta := FIniFile.ReadInteger(SECTION, 'Porta',DEFAULT_PORTA);
  ConexaoConfiguracao.Character := FIniFile.ReadString(SECTION, 'Character', DEFAULT_CHARACTER);
  ConexaoConfiguracao.DriverID := FIniFile.ReadString(SECTION, 'DriverID', DEFAULT_DRIVERID);
  ConexaoConfiguracao.Pooled := FIniFile.ReadBool(SECTION, 'Pooled', DEFAULT_POOLED);
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
