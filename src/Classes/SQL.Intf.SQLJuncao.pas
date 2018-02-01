unit SQL.Intf.SQLJuncao;

interface

uses
  SQL.Intf.SQL, SQL.Intf.SQLTabela, SQL.Intf.SQLCondicao;

type
  TTipoJuncao = (tjUnknow, tjInnerJoin, tjLeftJoin, tjRightJoin);
  ISQLJuncao = interface(ISQL)
    function setTipoJuncao(const ATipoJuncao: TTipoJuncao = tjInnerJoin): ISQLJuncao;
    function addTabelaPrincipal(const ATabela: ISQLTabela): ISQLJuncao;
    function addTabelaEstrangeira(const ATabela: ISQLTabela): ISQLJuncao;
    function addCondicao(const ACondicao: ISQLCondicao): ISQLJuncao;
  end;

implementation

end.
