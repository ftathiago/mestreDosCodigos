unit SQL.Impl.SQL;

interface

uses
  SQL.Enums, SQL.Intf.SQL;

type  
  TSQL = class(TInterfacedObject, ISQL) 
  protected
    FBanco: TBancoDeDados;
  public
    procedure setBanco(const ATipoBanco: TBancoDeDados);
    function ToString: string; virtual; abstract;
  end;

implementation

{ TSQL }

procedure TSQL.setBanco(const ATipoBanco: TBancoDeDados);
begin
  FBanco := ATipoBanco;
end;

end.
