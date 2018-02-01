unit SQL.Intf.SQLCondicao;

interface

uses
  System.Classes, System.SysUtils, System.Rtti, SQL.Intf.SQL,
  SQL.Intf.SQLColuna;

type
  TOperadorLogico = (olUnknow, olOr, olAnd);
  TOperadorComparacao = (ocUnknow, ocIgual, ocDiferente, ocMenorQue, ocMaiorQue,
    ocMenorOuIgual, ocMaiorOuIgual, ocEntre);

  ISQLCondicao = interface(IInterface)
    function setOperadorLogico(const ATipoCondicao: TOperadorLogico)
      : ISQLCondicao;
    function setColuna(const AColuna: ISQLColuna): ISQLCondicao;
    function setOperadorComparacao(const AOperadorLogico: TOperadorComparacao)
      : ISQLCondicao;
    function setValor(const AColuna: ISQL): ISQLCondicao; overload;
    function setValor(const AValor: TValue): ISQLCondicao; overload;
    function setTexto(const ATextoDaCondicao: string): ISQLCondicao;
    function getOperadorLogico: TOperadorLogico;
  end;

  TOperadorLogicoHelper = record helper for TOperadorLogico
    function getSQLString: string; inline;
  end;

  TOperadorComparacaoHelper = record helper for TOperadorComparacao
    function getSQLString: string; inline;
  end;

implementation

uses
  System.TypInfo;

{ TOperadorLogicoHelper }

function TOperadorLogicoHelper.getSQLString: string;
begin
  case self of
    olOr:
      result := 'or';
    olAnd:
      result := 'and';
  else
    result := '';
  end;
end;

{ TOperadorComparacaoHelper }

function TOperadorComparacaoHelper.getSQLString: string;
begin
  case self of
    ocIgual:
      result := '=';
    ocDiferente:
      result := '<>';
    ocMenorQue:
      result := '<';
    ocMaiorQue:
      result := '>';
    ocMenorOuIgual:
      result := '<=';
    ocMaiorOuIgual:
      result := '>=';
    ocEntre:
      result := 'between';
  else
    raise ENotImplemented.Create(GetEnumName(TypeInfo(TOperadorComparacao),
      Ord(self)));
  end;
end;

end.
