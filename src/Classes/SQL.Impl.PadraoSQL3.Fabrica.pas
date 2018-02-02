unit SQL.Impl.PadraoSQL3.Fabrica;

interface

uses
  SQL.Intf.Tabela,
  SQL.Intf.Coluna,
  SQL.Intf.Fabrica;

type
  TSQL3Fabrica = class(TInterfacedObject, IFabrica)
  public
    function Coluna: ISQLColuna;
    function Tabela: ISQLTabela;
  end;

implementation

uses
  SQL.Impl.PadraoSQL3.Tabela,
  SQL.Impl.PadraoSQL3.Coluna;

{ TSQL3Fabrica }

function TSQL3Fabrica.Coluna: ISQLColuna;
begin
  result := TSQL3Coluna.New;
end;

function TSQL3Fabrica.Tabela: ISQLTabela;
begin
  result := TSQL3Tabela.New;
end;

end.
