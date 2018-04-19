unit pkgUtils.Teste.Endereco;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  pkgUtils.Intf.Endereco,
  DUnitX.TestFramework;

type

  [TestFixture]
  TEnderecoTeste = class(TObject)
  private

  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure CriarEnderecoComDados;
    [Test]
    procedure CriarEnderecoVazio;
    [Test]
    procedure TestarCEPInvalido;
  end;

implementation

uses
  pkgUtils.Impl.Endereco, pkgUtils.Impl.ListaRetornoValidacao, pkgUtils.Intf.ListaRetornoValidacao;

const
  LOGRADOURO = 'Av. Dr. Mario Clapier Urbinati';
  NUMERO = '16';
  COMPLEMENTO = 'APTO 5';
  CEP = '80020-256';
  BAIRRO = 'ZONA 7';
  CIDADE = 'MARINGA';
  UF = 'PR';

procedure TEnderecoTeste.CriarEnderecoVazio;
var
  _endereco: IEndereco;
begin
  _endereco := TEndereco.New(EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr);
  Assert.IsTrue(Assigned(_endereco));
end;

procedure TEnderecoTeste.Setup;
begin

end;

procedure TEnderecoTeste.TearDown;
begin

end;

procedure TEnderecoTeste.TestarCEPInvalido;
var
  _endereco: IEndereco;
  _retorno: IListaRetornoValidacao;
begin
  _retorno := TListaRetornoValidacao.New([]);
  _endereco := TEndereco.New(LOGRADOURO, NUMERO, COMPLEMENTO, '', BAIRRO, CIDADE, UF);
  Assert.IsFalse(_endereco.Validar(_retorno));
  Assert.IsTrue(not _retorno.EstaVazio);
end;

procedure TEnderecoTeste.CriarEnderecoComDados;
var
  _endereco: IEndereco;
begin
  _endereco := TEndereco.New(LOGRADOURO, NUMERO, COMPLEMENTO, CEP, BAIRRO, CIDADE, UF);
  Assert.IsTrue(Assigned(_endereco));
end;

initialization

TDUnitX.RegisterTestFixture(TEnderecoTeste);

end.
