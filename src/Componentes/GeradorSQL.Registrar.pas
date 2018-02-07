unit GeradorSQL.Registrar;

interface

uses
  System.Classes,
  GeradorSQL.Comp.Select;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mestre dos Codigos', [TMCSelect]);
end;

initialization

Register;

end.
