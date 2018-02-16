unit SQL.Intf.Select;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  SQL.Intf.SQL,
  SQL.Intf.Coluna,
  SQL.Intf.Tabela,
  SQL.Intf.Condicao,
  SQL.Intf.Juncao;

type
  ISQLSelect = interface(ISQL)
    ['{5DF9430A-2A50-4D3D-B4C8-EEC4D799CC7E}']
    function injectSQLAntes(const SQLAntes: ISQL): ISQLSelect;
    function injectSQLApos(const SQLApos: ISQL): ISQLSelect;
    function addColuna(const AColuna: ISQLColuna): ISQLSelect;
    function setTabela(const ATabela: ISQLTabela): ISQLSelect;
    function addJuncao(const AJuncao: ISQLJuncao): ISQLJuncao;
    function addCondicao(const ACondicao: ISQLCondicao): ISQLSelect;
    function addOrderBy(const AColuna: ISQLColuna): ISQLSelect;
    function addGroupBy(const AColuna: ISQLColuna): ISQLSelect;
    function getTabela: ISQLTabela;
    function getListaColuna: TList<ISQLColuna>;
    function getListaCondicoes: TList<ISQLCondicao>;
    function getListaJuncao: TList<ISQLJuncao>;
    function getLimite: integer;
    function setLimite(const Registros: integer): ISQLSelect;
    function getSaltar: integer;
    function setSaltar(const Registros: integer): ISQLSelect;
  end;

implementation

end.
