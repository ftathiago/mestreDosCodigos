unit SQL.Intf.SQLCondicao;

interface

uses
  Controls, SQL.Intf.SQL, SQL.Intf.SQLColuna;

type
  TOperadorLogico = (tcUnknow, tcOr, tcAnd);
  TOperadorComparacao = (ocUnknow, ocIgual, ocDiferente, ocMenorQue, ocMaiorQue, 
    ocMenorOuIgual, ocMaiorOuIgual, ocEntre);

  ISQLCondicao = interface(IInterface)
    function setOperadorLogico(const ATipoCondicao: TOperadorLogico): ISQLCondicao;
    function setColuna(const AColuna: ISQLColuna): ISQLColuna;
    function setOperadorComparacao(const AOperadorLogico: TOperadorComparacao): ISQLColuna;
    function setValor(const AColuna: ISQLColuna): ISQLCondicao; overload;
    function setValor(const AValor: string): ISQLColuna; overload;
    function setValor(const AValor: integer): ISQLColuna; overload;
    function setValor(const AValor: double): ISQLColuna; overload;
    function setValor(const AValor: TDate): ISQLColuna; overload;
    function setValor(const AValor: TDateTime): ISQLColuna; overload;
    function setTexto(const ATextoDaCondicao: string): ISQLColuna;
    function getOperadorLogico: TOperadorLogico;
  end;

implementation

end.
