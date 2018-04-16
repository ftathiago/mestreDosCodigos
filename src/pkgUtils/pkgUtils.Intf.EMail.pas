unit pkgUtils.Intf.EMail;

interface

uses
  pkgUtils.Intf.Validavel;

type
  IEmail = Interface(IValidavel)
    ['{43483771-DAE8-49CD-8ACF-D6270F7EB280}']
    procedure ModificarEmail(const ANovoEmail: string);
    function AsString: string;
  end;

implementation

end.
