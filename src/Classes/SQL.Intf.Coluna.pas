unit SQL.Intf.Coluna;

interface

uses
  SQL.Intf.SQL, SQL.Intf.Tabela;

type
  ISQLColuna = interface(ISQL)
    function setTabela(const ATabela: ISQLTabela): ISQLColuna;
    function setColuna(const AColuna: string): ISQLColuna;
    function setNomeAlias(const ANomeAlias: string): ISQLColuna;
  end;

implementation

end.
