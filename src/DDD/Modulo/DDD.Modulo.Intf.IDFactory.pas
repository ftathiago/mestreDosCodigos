unit DDD.Modulo.Intf.IDFactory;

interface

uses
  DDD.Core.Intf.ID;

type
  TTipoID = (tiRandomico, tiGUID, tiSequence, tiTable);

  TTipoIDHelper = record helper for TTipoID
    function PegarClasseID: TClass;
  end;

  IIDFactory = Interface(IInterface)
    ['{531A65E0-4FE3-494F-BA1B-E705A2D14838}']
    function NovoID: IID;
    function InicializarID(const Valor: integer): IID;
  end;

implementation

uses
  DDD.Core.Impl.IDRandomico;

function TTipoIDHelper.PegarClasseID: TClass;
begin
  result := nil;

  case Self of
    tiRandomico:
      result := TIDRandomico;
    tiGUID:
      ;
    tiSequence:
      ;
    tiTable:
      ;
  end;
end;

end.
