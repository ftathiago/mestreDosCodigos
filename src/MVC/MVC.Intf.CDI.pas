unit MVC.Intf.CDI;

interface

uses
  VCL.Forms, MVC.Intf.Conectavel, MVC.Intf.Controller, MVC.Impl.View;

type
  ICDI = Interface(IConectavel)
    ['{29557D7A-36B1-4936-9B79-453F729351BB}']
    function TratarRequisicaoMVC(const ANomeDoForm: string):TFormView;
  end;

implementation

end.
