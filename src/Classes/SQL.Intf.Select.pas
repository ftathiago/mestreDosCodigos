unit SQL.Intf.Select;

interface

uses
  Sysutils, SQL.Intf.Coluna, SQL.Intf.Tabela, SQL.Intf.Condicao, SQL.Intf.Juncao;

type
  ISQLSelect = interface(IInterface)
    function addColuna(AColuna: ISQLColuna): ISQLSelect;
    function addTabela(ATabela: ISQLTabela): ISQLSelect;
    function addJuncao(AJuncao: ISQLJuncao): ISQLJuncao;
    function addCondicao(ACondicao: ISQLCondicao): ISQLSelect;
    function getTabela(const ANomeTabela: string; const ANomeAlias: string = ''): ISQLTabela;
    function getColuna(const ANomeColuna: string; Tabela: ISQLTabela = nil): ISQLColuna;
  end;

implementation

end.
