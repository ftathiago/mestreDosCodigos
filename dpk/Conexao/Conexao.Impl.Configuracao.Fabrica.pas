unit Conexao.Impl.Configuracao.Fabrica;

interface

uses
  Conexao.Intf.Configuracao;

type
  TTipoOrigem = (toIni);

  IFabricaCarregador = Interface(IInterface)
    ['{B8F577B1-0EB8-40D1-B358-A260DA27D2A8}']
    function getCarregador: IConexaoCarregador;
  end;

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
