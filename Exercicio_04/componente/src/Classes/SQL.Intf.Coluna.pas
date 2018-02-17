unit SQL.Intf.Coluna;

interface

uses
  SQL.Intf.SQL, SQL.Intf.Tabela;

type
  ISQLColuna = interface(ISQL)
    function setTabela(const ATabela: ISQLTabela): ISQLColuna;
    function setColuna(const AColuna: string): ISQLColuna;
    function setNomeVirtual(const ANomeVirtual: string): ISQLColuna;
  end;

implementation

end.
