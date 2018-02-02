unit SQL.Intf.Juncao;

interface

uses
  SQL.Enums,
  SQL.Intf.SQL,
  SQL.Intf.Tabela,
  SQL.Intf.Condicao;

type
  ISQLJuncao = interface(ISQL)
    function setTipoJuncao(const ATipoJuncao: TTipoJuncao = tjInnerJoin): ISQLJuncao;
    function setTabelaEstrangeira(const ATabela: ISQLTabela): ISQLJuncao;
    function addCondicao(const ACondicao: ISQLCondicao): ISQLJuncao;
  end;

implementation

end.
