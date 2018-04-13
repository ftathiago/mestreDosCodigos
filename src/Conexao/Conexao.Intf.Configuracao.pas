unit Conexao.Intf.Configuracao;

interface

uses
  System.Classes,
  System.SysUtils;

type
  IConexaoConfiguracao = Interface(IInterface)
    ['{6400F405-627A-4FF2-9C64-F4FDE24E9E72}']
    function GetServer: string;
    function GetDataBase: string;
    function GetSchema: string;
    function GetUserName: string;
    function GetPassword: string;
    function GetProtocolo: string;
    function GetPorta: integer;
    function GetCharacter: string;
    function GetDriverID: string;
    function GetPooled: boolean;
    function GetOutrasConfiguracoes: TStrings;
    procedure SetDataBase(const Value: string);
    procedure SetOutrasConfiguracoes(const Value: TStrings);
    procedure SetPassword(const Value: string);
    procedure SetSchema(const Value: string);
    procedure SetServer(const Value: string);
    procedure SetUserName(const Value: string);
    procedure SetProtocolo(const Value: string);
    procedure SetPorta(const Value: integer);
    procedure SetCharacter(const Value: string);
    procedure SetDriverID(const Value: string);
    procedure SetPooled(const Value: boolean);
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

  IConexaoCarregador = Interface(IInterface)
    ['{EC150A0C-D940-43D8-9737-A15D3FB190C2}']
    procedure SetNomeOrigem(const NomeOrigem: string);
    procedure CarregarConfiguracoes(const ConexaoConfiguracao: IConexaoConfiguracao);
    procedure SalvarConfiguracoes(const ConexaoConfiguracao: IConexaoConfiguracao);
  end;

implementation

end.
