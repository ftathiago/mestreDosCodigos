unit pkgUtils.Impl.EMail;

interface

uses
  pkgUtils.Intf.ListaRetornoValidacao,
  pkgUtils.Intf.EMail;

type
  TEmail = class(TInterfacedObject, IEMail)
  private
    FEhValido: boolean;
    FEmail: string;
  public
    class function New(const AEMail: string): IEMail;
    constructor Create(const AEMail: string);
    function EhValido: boolean;
    procedure ModificarEmail(const ANovoEmail: string);
    function Validar: IListaRetornoValidacao;
  end;

implementation

uses
  System.RegularExpressions,
  pkgUtils.Impl.ListaRetornoValidacao;

const
  EMAIL_REGEX = '[_a-zA-Z\d\-\.]+@([_a-zA-Z\d\-]+(\.[_a-zA-Z\d\-]+)+)';


{ TEmail }

class function TEmail.New(const AEMail: string): IEMail;
begin
  Result := Create(AEMail);
end;

constructor TEmail.Create(const AEMail: string);
begin
  FEhValido := False;
  FEmail := AEMail;
end;

function TEmail.EhValido: boolean;
begin
  Validar;
  Result := FEhValido;
end;

procedure TEmail.ModificarEmail(const ANovoEmail: string);
begin
  FEmail := ANovoEmail;
  Validar;
end;

function TEmail.Validar: IListaRetornoValidacao;
var
  _retornoValidacao: TRetornoValidacao;
begin
  FEhValido := TRegEx.IsMatch(FEmail, EMAIL_REGEX);
  if not FEhValido then
  begin
    _retornoValidacao.CodigoRetorno := 1;
    _retornoValidacao.MensagemDeErro := 'E-mail inválido!';
    result := TListaRetornoValidacao.New([_retornoValidacao]);
  end;
end;

end.
