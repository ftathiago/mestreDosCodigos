unit Conexao.Intf.ConfiguracaoDeConexao;

interface

uses
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
  IFDConfiguracaoDeConexao = Interface(IInterface)
    ['{95B7892E-FC1B-4746-8DDF-1E3511726632}']
    function SetConexaoConfiguracao(const ConexaoConfiguracao: IConexaoConfiguracao)
      : IFDConfiguracaoDeConexao;
    procedure Configurar;
  end;

implementation

end.
