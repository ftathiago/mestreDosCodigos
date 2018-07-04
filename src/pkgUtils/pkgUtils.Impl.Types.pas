unit pkgUtils.Impl.Types;

interface

uses
  System.Types, pkgUtils.Impl.Nullable;

type
  IntegerNull = Nullable<Integer>;
  StringNull = Nullable<String>;
  DoubleNull = Nullable<Double>;
  CurrencyNull = Nullable<Currency>;
  TDateTimeNull = Nullable<TDateTime>;

implementation

end.
