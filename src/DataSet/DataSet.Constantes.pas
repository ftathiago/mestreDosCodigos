unit DataSet.Constantes;

interface

uses
  Data.DB;

const
  FieldTypeNumeric = [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD, ftBytes, ftVarBytes, ftAutoInc,
    ftLargeint, ftFMTBcd, ftLongWord, ftShortint, ftByte, ftExtended, ftSingle];
  FieldTypeString = [ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo];
  FieldTypeInteiro = [ftSmallint, ftInteger, ftWord, ftBytes, ftAutoInc, ftLargeint, ftLongWord, ftShortint, ftByte, ftSingle];
  FieldTypeReal = [ ftFloat, ftCurrency, ftBCD, ftFMTBcd, ftExtended];
  BOOLEAN_TRUE = 'S';
  BOOLEAN_FALSE = 'N';
  INTEIRO_INDEFINIDO = -999;

implementation

end.
