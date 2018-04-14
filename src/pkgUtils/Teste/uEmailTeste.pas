unit uEmailTeste;

interface

uses
  pkgUtils.Intf.Email,
  pkgUtils.Intf.ListaRetornoValidacao,
  DUnitX.TestFramework;

type

  [TestFixture]
  TEmailTeste = class(TObject)
  private
    FRetorno: IListaRetornoValidacao;
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
    procedure DadoEmailInvalidoRetornaInValido;
    [Test]
    procedure DadoEmailValidoRetornoDeveEstarVazio;
    [Test]
    procedure DadoEmailInValidoRetornoDeveConterValor;
  end;

implementation

uses
  pkgUtils.Impl.ListaRetornoValidacao,
  pkgUtils.Impl.Email;



procedure TEmailTeste.Setup;
begin
  FRetorno := TListaRetornoValidacao.New([]);
end;

procedure TEmailTeste.TearDown;
begin
  FRetorno := nil;
end;


function TEmailTeste.RetornarEmailInvalido: IEmail;
begin
  result := TEmail.New('ftathiago@');
end;

function TEmailTeste.RetornarEmailValido: IEmail;
begin
  result := TEmail.New('ftathiago@gmail.com');
end;

procedure TEmailTeste.DadoEmailInvalidoRetornaInValido;
var
  _email: IEmail;
begin
  _email := RetornarEmailInvalido;
  Assert.IsFalse(_email.Validar(FRetorno));
end;

procedure TEmailTeste.DadoEmailInValidoRetornoDeveConterValor;
var
  _email :IEmail;
begin
  _email := RetornarEmailInvalido;
  _email.Validar(FRetorno);
  Assert.IsTrue(FRetorno.getQtd > 0);
end;

procedure TEmailTeste.DadoEmailValidoRetornaValido;
var
  _email: IEmail;
begin
  _email := RetornarEmailValido;
  Assert.IsTrue(_email.Validar(FRetorno));
end;

procedure TEmailTeste.DadoEmailValidoRetornoDeveEstarVazio;
var
  _email: IEmail;
begin
  _email := RetornarEmailValido;
  _email.Validar(FRetorno);
  Assert.IsFalse(FRetorno.EstaVazio);
end;

initialization

TDUnitX.RegisterTestFixture(TEmailTeste);

end.
