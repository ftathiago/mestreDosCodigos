unit DDD.Core.Intf.Entidade;

interface

uses
  DDD.Core.Intf.ID;

type
  IEntidade = interface(IInterface)
    ['{C64A8AA2-D53F-4A84-A103-ADDB672DA24E}']
    function GetID: IID;
    procedure DefinirNovoID(const AID: IID);
    function GetNomeEntidade: string;
    property NomeEntidade: string read GetNomeEntidade;
    property ID: IID read GetID;
  end;

implementation

end.
