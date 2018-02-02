unit SQL.Enums;

interface

type
  TBancoDeDados = (bdFireBird);

  TOperadorLogico = (olUnknow, olOr, olAnd);

  TOperadorComparacao = (ocUnknow, ocIgual, ocDiferente, ocMenorQue, ocMaiorQue, ocMenorOuIgual,
    ocMaiorOuIgual, ocEntre, ocContenha, ocLike);

  TTipoJuncao = (tjUnknow, tjInnerJoin, tjLeftJoin, tjRightJoin);

  { Helpers }
  TOperadorLogicoHelper = record helper for TOperadorLogico
    function getSQLString: string; inline;
    function getNome: string; inline;
  end;

  TOperadorComparacaoHelper = record helper for TOperadorComparacao
    function getSQLString: string; inline;
    function getNome: string; inline;
  end;

  FTipoJuncaoHelper = record helper for TTipoJuncao
    function getSQLString: string; inline;
    function getNome: string; inline;
  end;

implementation

uses
  System.SysUtils,
  System.TypInfo,
  SQL.Mensagens;

{ TOperadorLogicoHelper }

function TOperadorLogicoHelper.getNome: string;
begin
  result := GetEnumName(TypeInfo(TOperadorLogico), Ord(self))
end;

function TOperadorLogicoHelper.getSQLString: string;
begin
  case self of
    olOr:
      result := 'or';
    olAnd:
      result := 'and';
  else
    raise ENotImplemented.CreateFmt(SQL.Mensagens.RECURSO_NAO_IMPLEMENTADO,
      [self.getNome, TObject(self).ClassName]);
  end;
end;

{ TOperadorComparacaoHelper }

function TOperadorComparacaoHelper.getNome: string;
begin
  result := GetEnumName(TypeInfo(TOperadorComparacao), Ord(self))
end;

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
    raise ENotImplemented.CreateFmt(SQL.Mensagens.RECURSO_NAO_IMPLEMENTADO,
      [self.getNome, TObject(self).ClassName]);
  end;
end;

{ FTipoJuncaoHelper }

function FTipoJuncaoHelper.getNome: string;
begin
  result := GetEnumName(TypeInfo(TOperadorComparacao), Ord(self))
end;

function FTipoJuncaoHelper.getSQLString: string;
begin
  case self of
    tjInnerJoin:
      result := 'join';
    tjLeftJoin:
      result := 'left join';
    tjRightJoin:
      result := 'right join';
  else
    raise ENotImplemented.CreateFmt(SQL.Mensagens.RECURSO_NAO_IMPLEMENTADO,
      [self.getNome, TObject(self).ClassName]);
  end;
end;

end.
