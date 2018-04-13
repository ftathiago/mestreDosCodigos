unit Conexao.Intf.Configuracao.Fabrica;

interface

uses
  Conexao.Intf.Configuracao;

type
  TTipoOrigem = (toIni);

  IFabricaCarregador = Interface(IInterface)
    ['{B8F577B1-0EB8-40D1-B358-A260DA27D2A8}']
    function getCarregador: IConexaoCarregador;
  end;

 implementation

 end.