unit MVC.Exception;

interface

uses
  System.SysUtils;

type
  EMVCException = class(Exception);

  EMVCViewNotFound = class(EMVCException)
    constructor Create(const AViewNome: string); reintroduce;
  end;

  EMVCControllerNotFound = class(EMVCException)
    constructor Create(const AControllerNome: string); reintroduce;
  end;

implementation

{ EMVCControllerNotFound }

constructor EMVCControllerNotFound.Create(const AControllerNome: string);
begin
  inherited CreateFMT('Não foi localizado um controller com a anotação [%s].', [AControllerNome]);
end;

{ EMVCViewNotFound }

constructor EMVCViewNotFound.Create(const AViewNome: string);
begin
  inherited CreateFMT('A View %s não foi localizada.', [AViewNome]);
end;

end.
