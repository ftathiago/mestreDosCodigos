unit SQL.Intf.Builder;

interface

uses
  DesignPattern.Builder.Intf.Builder,
  SQL.Enums;

type
  ISQLBuilder<T> = interface(IBuilder<T>)
    ['{0F47928E-1F1F-4564-9E81-923139328755}']
    procedure SetOtimizarPara(const AOtimizarPara: TOtimizarPara);
  end;

implementation

end.
