unit Conexao.Impl.FDConfiguracaoDeConexao;

interface

uses
  Conexao.Intf.FDConfiguracaoDeConexao,
  Conexao.Intf.Configuracao,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.PGDef,
  FireDAC.Phys.IBDef,
  FireDAC.Phys.OracleDef,
  FireDAC.Phys.DB2Def,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.TDBXDef,
  FireDAC.Phys.ODBCDef,
  FireDAC.Stan.StorageBin,
  FireDAC.Stan.StorageXML,
  FireDAC.Stan.StorageJSON,
  FireDAC.Phys.ODBC,
  FireDAC.Phys.TDBXBase,
  FireDAC.Phys.TDBX,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.ODBCBase,
  FireDAC.Phys.DB2,
  FireDAC.Phys.Oracle,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.IB,
  FireDAC.Phys.PG,
  FireDAC.Phys.MySQL;

type
  TFDConfiguracaoDeConexao = class(TInterfacedObject, IFDConfiguracaoDeConexao)
  private
    FConexaoConfiguracao: IConexaoConfiguracao;
    FFDConnection: TFDConnection;
    procedure AddSchema;
    procedure AddServer;
    procedure AddProtocolo;
    procedure AddPorta;
    procedure AddCharacter;
    procedure AddOutrasConfiguracoes;
    procedure AddParam(const NomeParam, ValorParam: string);
  public
    class function New(var FDConnection: TFDConnection): IFDConfiguracaoDeConexao;
    constructor Create(var FDConnection: TFDConnection);
    procedure Configurar;
    function SetConexaoConfiguracao(const ConexaoConfiguracao: IConexaoConfiguracao)
      : IFDConfiguracaoDeConexao;
    function SetConnection(var FDConnection: TFDConnection): IFDConfiguracaoDeConexao;
  end;

implementation

uses
  System.SysUtils;

{ TFDConfiguracaoDeConexao }

procedure TFDConfiguracaoDeConexao.AddCharacter;
begin
  if FConexaoConfiguracao.Character.Trim.IsEmpty then
    exit;

  AddParam('CharacterSet', FConexaoConfiguracao.Character);
end;

procedure TFDConfiguracaoDeConexao.AddOutrasConfiguracoes;
begin
  if FConexaoConfiguracao.OutrasConfiguracoes.Count = 0 then
    exit;

  FFDConnection.Params.AddStrings(FConexaoConfiguracao.OutrasConfiguracoes);
end;

procedure TFDConfiguracaoDeConexao.AddParam(const NomeParam, ValorParam: string);
begin
  FFDConnection.Params.Add(Format('%s=%s', [NomeParam, ValorParam]));
end;

procedure TFDConfiguracaoDeConexao.AddPorta;
begin
  if FConexaoConfiguracao.Porta <= 0 then
    exit;

  AddParam('port', FConexaoConfiguracao.Porta.ToString);
end;

procedure TFDConfiguracaoDeConexao.AddProtocolo;
begin
  if FConexaoConfiguracao.Protocolo.Trim.IsEmpty then
    exit;

  AddParam('protocol', FConexaoConfiguracao.Protocolo);
end;

procedure TFDConfiguracaoDeConexao.AddSchema;
begin
  if FConexaoConfiguracao.Schema.Trim.IsEmpty then
    exit;

  AddParam('schema', FConexaoConfiguracao.Schema);
end;

procedure TFDConfiguracaoDeConexao.AddServer;
begin
  if FConexaoConfiguracao.Server.Trim.IsEmpty then
    exit;

  AddParam('server', FConexaoConfiguracao.Server);
end;

procedure TFDConfiguracaoDeConexao.Configurar;
begin
  FFDConnection.Params.Database := FConexaoConfiguracao.Database;
  FFDConnection.Params.UserName := FConexaoConfiguracao.UserName;
  FFDConnection.Params.DriverID := FConexaoConfiguracao.DriverID;
  FFDConnection.Params.Password := FConexaoConfiguracao.Password;

  AddSchema;
  AddServer;
  AddProtocolo;
  AddPorta;
  AddCharacter;
  AddOutrasConfiguracoes;
end;

constructor TFDConfiguracaoDeConexao.Create(var FDConnection: TFDConnection);
begin
  FFDConnection := FDConnection;
end;

class function TFDConfiguracaoDeConexao.New(var FDConnection: TFDConnection): IFDConfiguracaoDeConexao;
begin
  result := Create(FDConnection);
end;

function TFDConfiguracaoDeConexao.SetConexaoConfiguracao(
  const ConexaoConfiguracao: IConexaoConfiguracao): IFDConfiguracaoDeConexao;
begin
  FConexaoConfiguracao := ConexaoConfiguracao;
  result := self;
end;

function TFDConfiguracaoDeConexao.SetConnection(var FDConnection: TFDConnection): IFDConfiguracaoDeConexao;
begin
  FFDConnection := FDConnection;
  result := self;
end;

end.
