unit SQL.Intf.Select;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  SQL.Intf.Coluna,
  SQL.Intf.Tabela,
  SQL.Intf.Condicao,
  SQL.Intf.Juncao;

type
  ISQLSelect = interface(IInterface)
    function addColuna(const AColuna: ISQLColuna): ISQLSelect;
    function setTabela(const ATabela: ISQLTabela): ISQLSelect;
    function addJuncao(const AJuncao: ISQLJuncao): ISQLJuncao;
    function addCondicao(const ACondicao: ISQLCondicao): ISQLSelect;
    function getTabela: ISQLTabela;
    function getListaColuna: TList<ISQLColuna>;
    function getListaCondicoes: TList<ISQLCondicao>;
    function getListaJuncao: TList<ISQLJuncao>;
  end;

implementation

end.
