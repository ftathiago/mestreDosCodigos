//***********************************************************************************************************
// Responsável por fornecer objetos especializados em obter as configurações de conexão
// Autor: ftathiago@gmail.com
// Data: 2018-04-12
//***********************************************************************************************************

unit Conexao.Impl.Configuracao.Fabrica;

interface

uses
  Conexao.Intf.Configuracao, Conexao.Intf.Configuracao.Fabrica;

type
  TFabricaCarregador = class(TInterfacedObject, IFabricaCarregador)
  private
    FTipoOrigem: TTipoOrigem;
  public
    constructor Create(const TipoOrigem: TTipoOrigem);
    class function New(const TipoOrigem: TTipoOrigem): IFabricaCarregador;
    function getCarregador: IConexaoCarregador;
  end;

implementation

{ TFabricaCarregador }

uses
  Conexao.Impl.ConfiguracaoIni;

constructor TFabricaCarregador.Create(const TipoOrigem: TTipoOrigem);
begin
  inherited Create;
  FTipoOrigem := TipoOrigem;
end;

function TFabricaCarregador.getCarregador: IConexaoCarregador;
begin
  case FTipoOrigem of
    toIni:
      result := TCarregadorConexaoIni.New;
  end;
end;

class function TFabricaCarregador.New(const TipoOrigem: TTipoOrigem): IFabricaCarregador;
begin
  result := Create(TipoOrigem);
end;

end.
