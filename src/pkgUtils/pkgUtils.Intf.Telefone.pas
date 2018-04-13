unit pkgUtils.Intf.Telefone;

interface

uses
  pkgUtils.Intf.Validavel;

type
  ITelefone = Interface(IValidavel)
    ['{981EB473-7D12-4D4D-B7F7-8E7ED411D673}']
    function getDDD(): string;
    function getTelefone(): string;
    function getTelefoneCompleto(): string;
  end;

implementation

end.
