unit SQL.Impl.PadraoSQL3.Fabrica.Coluna;

interface

uses
  SQL.Intf.Coluna,
  SQL.Intf.Fabrica.Coluna,
  SQL.Impl.Fabrica;

type
  TSQL3FabricaColuna = class(TFabrica, IFabricaDeColuna)
  public
    function Simples(const NomeColuna: string): ISQLColuna;
  end;

implementation

{ TSQL3FabricaColuna }

uses
  SQL.Impl.PadraoSQL3.Coluna;

function TSQL3FabricaColuna.Simples(const NomeColuna: string): ISQLColuna;
begin
  result := TSQL3Coluna.New;
end;

end.
