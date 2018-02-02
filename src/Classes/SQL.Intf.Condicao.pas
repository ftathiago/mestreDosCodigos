unit SQL.Intf.Condicao;

interface

uses
  System.Rtti,
  SQL.Enums,
  SQL.Intf.SQL,
  SQL.Intf.Coluna;

type
  ISQLCondicao = interface(ISQL)
    function setOperadorLogico(const ATipoCondicao: TOperadorLogico): ISQLCondicao;
    function setColuna(const AColuna: ISQLColuna): ISQLCondicao;
    function setOperadorComparacao(const AOperadorLogico: TOperadorComparacao): ISQLCondicao;
    function setValor(const AColuna: ISQL): ISQLCondicao; overload;
    function setValor(const AValor: TValue): ISQLCondicao; overload;
    function setTexto(const ATextoDaCondicao: string): ISQLCondicao;
    function getOperadorLogico: TOperadorLogico;
  end;

implementation

end.
