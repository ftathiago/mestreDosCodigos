unit DataSet.Constantes;

interface

uses
  Data.DB;

const
  FieldTypeNumeric = [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD, ftBytes, ftVarBytes, ftAutoInc,
    ftLargeint, ftFMTBcd, ftLongWord, ftShortint, ftByte, ftExtended, ftSingle];
  FieldTypeString = [ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo];
  BOOLEAN_TRUE = 'S';
  BOOLEAN_FALSE = 'N';
  INTEIRO_INDEFINIDO = -999;

implementation

end.
