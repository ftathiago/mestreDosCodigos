unit SQL.Intf.Juncao;

interface

uses
  System.Generics.Collections,
  SQL.Enums,
  SQL.Intf.SQL,
  SQL.Intf.Tabela,
  SQL.Intf.Condicao;

type
  ISQLJuncao = interface(ISQL)
    function setTipoJuncao(const ATipoJuncao: TTipoJuncao = tjInnerJoin): ISQLJuncao;
    function setTabelaEstrangeira(const ATabela: ISQLTabela): ISQLJuncao;
    function getTabelaEstrangeira: ISQLTabela;
    function addCondicao(const ACondicao: ISQLCondicao): ISQLJuncao;
    function getListaCondicoes: TList<ISQLCondicao>;
  end;

implementation

end.
