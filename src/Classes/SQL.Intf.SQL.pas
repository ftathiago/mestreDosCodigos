unit SQL.Intf.SQL;

interface

uses
  SQL.Enums;

type
  ISQL = interface(IInterface)    
    procedure setBanco(const ATipoBanco: TBancoDeDados);
    function ToString: string;
  end;

implementation

end.
