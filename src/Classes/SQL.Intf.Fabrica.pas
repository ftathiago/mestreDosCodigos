unit SQL.Intf.Fabrica;

interface

uses
  SQL.Enums,
  SQL.Intf.Tabela,
  SQL.Intf.Coluna,
  SQL.Intf.Condicao,
  SQL.Intf.Juncao,
  SQL.Intf.Select;

type
  IFabrica = Interface(IInterface)
    ['{3952ECD9-2F1B-4979-B370-4D9428979E7E}']
    function Tabela: ISQLTabela;
    function Coluna: ISQLColuna;
    function Condicao: ISQLCondicao;
    function Juncao: ISQLJuncao;
    function Select: ISQLSelect;
  end;

implementation

end.
