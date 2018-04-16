unit Conexao.Impl.Fabrica.FireDac;

interface

uses
  Data.DB,
  Conexao.Intf.Configuracao,
  Conexao.Intf.DataFabrica,
  FireDac.DApt,
  FireDac.Stan.Option,
  FireDac.Comp.Client;

type
  TFabricaFireDac = class(TInterfacedObject, IDataFabrica)
  private
  public
    class function New: IDataFabrica;
    constructor Create;
    function getConexao: TCustomConnection;
    function getQuery(Connection: TCustomConnection = nil): TDataSet;
    function getQuerySomenteLeitura(Connection: TCustomConnection = nil): TDataSet;
  end;

  TFabricaConexaoFireDac = class
  strict private
    function getConfiguracaoConexao: IConexaoConfiguracao;
  public
    function getConexao: TFDConnection;
  end;

implementation

uses
  Vcl.Forms,
  System.SysUtils,
  Conexao.Intf.Configuracao.Fabrica,
  Conexao.Impl.FDConfiguracaoDeConexao,
  Conexao.Impl.Configuracao.Fabrica,
  Conexao.Impl.Configuracao,
  Conexao.Impl.ConfiguracaoIni;

{ TFabricaFireDac }

constructor TFabricaFireDac.Create;
begin

end;

function TFabricaFireDac.getConexao: TCustomConnection;
var
  _con: TFabricaConexaoFireDac;
begin
  _con := TFabricaConexaoFireDac.Create;
  try
    result := _con.getConexao;
  finally
    FreeAndNil(_con);
  end;
end;

function TFabricaFireDac.getQuery(Connection: TCustomConnection = nil): TDataSet;
var
  _qry: TFDQuery;
  _con: TFDCustomConnection;
begin
  _qry := TFDQuery.Create(nil);
  _con := Connection as TFDCustomConnection;

  if not Assigned(_con) then
    _con := getConexao as TFDCustomConnection;

  _qry.Connection := _con;
  result := _qry;
end;

function TFabricaFireDac.getQuerySomenteLeitura(Connection: TCustomConnection = nil): TDataSet;
var
  _qry: TFDQuery;
begin
  _qry := getQuery(Connection) as TFDQuery;
  _qry.UpdateOptions.AssignedValues := [uvEDelete, uvEInsert, uvEUpdate];
  _qry.UpdateOptions.EnableDelete := False;
  _qry.UpdateOptions.EnableInsert := False;
  _qry.UpdateOptions.EnableUpdate := False;

  result := _qry;
end;

class function TFabricaFireDac.New: IDataFabrica;
begin
  result := Create;
end;

{ TFabricaConexaoFireDac }

function TFabricaConexaoFireDac.getConexao: TFDConnection;
begin
  result := TFDConnection.Create(nil);
  TFDConfiguracaoDeConexao
    .New(result)
    .SetConexaoConfiguracao(getConfiguracaoConexao)
    .Configurar;
end;

function TFabricaConexaoFireDac.getConfiguracaoConexao: IConexaoConfiguracao;
var
  _carregadorIni: IConexaoCarregador;
begin
  result := TumcConexaoConfiguracao.New;
  _carregadorIni := TFabricaCarregador.New(toIni).getCarregador;
  _carregadorIni.SetNomeOrigem(ChangeFileExt(Application.ExeName, '.ini'));
  _carregadorIni.CarregarConfiguracoes(result);
end;

end.
