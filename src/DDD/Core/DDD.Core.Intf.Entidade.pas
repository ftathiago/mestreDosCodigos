unit DDD.Core.Intf.Entidade;

interface

type
  IEntidade = interface(IInterface)
    ['{C64A8AA2-D53F-4A84-A103-ADDB672DA24E}']
    function GetNomeEntidade: string;
    property NomeEntidade: string read GetNomeEntidade;
  end;

implementation

end.
