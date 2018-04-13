unit uEmailTeste;

interface

uses
  pkgUtils.Intf.Email,
  DUnitX.TestFramework;

type

  [TestFixture]
  TMyTestObject = class(TObject)
  private
    function RetornarEmailValido: IEmail;
    function RetornarEmailInvalido: IEmail;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure DadoEmailValidoRetornaValido;
    [Test]
    procedure DadoEmailValidoValidarDeveRetornarNil;
    [Test]
    procedure DadoEmailInvalidoRetornaInValido;
    [Test]
    procedure DadoEmailInValidoValidarNaoDeveRetornarNil;
  end;

implementation

uses
  pkgUtils.Impl.Email;



procedure TMyTestObject.Setup;
begin
end;

procedure TMyTestObject.TearDown;
begin
end;


function TMyTestObject.RetornarEmailInvalido: IEmail;
begin
  result := TEmail.New('ftathiago@');
end;

function TMyTestObject.RetornarEmailValido: IEmail;
begin
  result := TEmail.New('ftathiago@gmail.com');
end;

procedure TMyTestObject.DadoEmailInvalidoRetornaInValido;
var
  _email: IEmail;
begin
  _email := RetornarEmailInvalido;
  _email.Validar;
  Assert.IsFalse(_email.EhValido);
end;

procedure TMyTestObject.DadoEmailInValidoValidarNaoDeveRetornarNil;
var
  _email :IEmail;
begin
  _email := RetornarEmailInvalido;
  Assert.IsTrue(Assigned(_email.Validar));
end;

procedure TMyTestObject.DadoEmailValidoRetornaValido;
var
  _email: IEmail;
begin
  _email := RetornarEmailValido;
  _email.Validar;
  Assert.IsTrue(_email.EhValido);
end;

procedure TMyTestObject.DadoEmailValidoValidarDeveRetornarNil;
var
  _email: IEmail;
begin
  _email := RetornarEmailValido;
  Assert.IsFalse(Assigned(_email.Validar));
end;

initialization

TDUnitX.RegisterTestFixture(TMyTestObject);

end.
