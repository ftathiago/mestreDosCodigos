unit SQL.Intf.Fabrica;

interface

uses
  SQL.Enums,
  SQL.Intf.Tabela,
  SQL.Intf.Coluna;

type
  IFabrica = Interface(IInterface)
    ['{3952ECD9-2F1B-4979-B370-4D9428979E7E}']
    function Tabela: ISQLTabela;
    function Coluna: ISQLColuna;
  end;

implementation

end.
