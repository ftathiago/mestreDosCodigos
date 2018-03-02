unit umcRegistrationUnit;

interface

procedure Register;

implementation

uses
  Classes,
  TreeIntf,
  Vcl.Forms,
  DesignIntf,
  umcFrmConsulta,
  umcCrudToolbar;

type
  TFrameClass = class of TFrame;

const
  PAGE = 'Mestre dos Códigos';

procedure RegisterFramesAsComponents(const PAGE: string; const FrameClasses: array of TFrameClass);
var
  FrameClass: TFrameClass;
begin
  for FrameClass in FrameClasses do
  begin
    RegisterComponents(PAGE, [FrameClass]);
    RegisterSprigType(FrameClass, TComponentSprig);
  end;
end;

procedure Register;
begin
//  RegisterFramesAsComponents(PAGE, [TfmcFrmConsulta]);
  RegisterComponents(PAGE, [TfmcFrmConsulta]);
  RegisterFramesAsComponents(PAGE, [TCrudToolBar]);
end;

end.
