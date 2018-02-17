unit SQL.Intf.Tabela;

interface

uses
  SQL.Intf.SQL;

type
  ISQLTabela = interface(ISQL)
    function setNome(const ANomeTabela: string):ISQLTabela;
    function setAlias(const AAlias: string): ISQLTabela;
    function TestarAliasEstaPreenchido: boolean;
    function getAlias: string;
    function getNome: string;
  end;

implementation

end.
