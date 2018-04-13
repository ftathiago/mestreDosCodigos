unit SQL.Impl.PadraoSQL3.Fabrica;

interface

uses
  SQL.Intf.Tabela,
  SQL.Intf.Coluna,
  SQL.Intf.Condicao,
  SQL.Intf.Juncao,
  SQL.Intf.Select,
  SQL.Intf.Fabrica;

type
  TSQL3Fabrica = class(TInterfacedObject, IFabrica)
  public
    function Coluna: ISQLColuna;
    function Tabela: ISQLTabela;
    function Condicao: ISQLCondicao;
    function Juncao: ISQLJuncao;
    function Select: ISQLSelect;
  end;

implementation

uses
  SQL.Impl.PadraoSQL3.Tabela,
  SQL.Impl.PadraoSQL3.Coluna,
  SQL.Impl.PadraoSQL3.Condicao,
  SQL.Impl.PadraoSQL3.Juncao,
  SQL.Impl.PadraoSQL3.Select;

{ TSQL3Fabrica }

function TSQL3Fabrica.Coluna: ISQLColuna;
begin
  result := TSQL3Coluna.New;
end;

function TSQL3Fabrica.Condicao: ISQLCondicao;
begin
  result := TSQL3Condicao.New;
end;

function TSQL3Fabrica.Juncao: ISQLJuncao;
begin
  result := TSQL3Juncao.New;
end;

function TSQL3Fabrica.Select: ISQLSelect;
begin
  result := TSQL3Select.New;
end;

function TSQL3Fabrica.Tabela: ISQLTabela;
begin
  result := TSQL3Tabela.New;
end;

end.
