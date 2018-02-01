unit SQL.Intf.SQLComando;

interface

uses
  Sysutils, SQL.Intf.SQLColuna, SQL.Intf.SQLTabela, SQL.Intf.SQLCondicao, SQL.Intf.SQLJuncao;

type
  ISQLComando = interface(IInterface)
    function addColuna(AColuna: ISQLColuna): ISQLComando;
    function addTabela(ATabela: ISQLTabela): ISQLComando;
    function addJuncao(AJuncao: ISQLJuncao): ISQLJuncao;
    function addCondicao(ACondicao: ISQLCondicao): ISQLComando;
    function getTabela(const ANomeTabela: string; const ANomeAlias: string = ''): ISQLTabela;
    function getColuna(const ANomeColuna: string): ISQLColuna;
  end;

implementation

end.
