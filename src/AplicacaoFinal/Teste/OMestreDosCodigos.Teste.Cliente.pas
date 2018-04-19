unit OMestreDosCodigos.Teste.Cliente;

interface

uses
  DUnitX.TestFramework,
  OMestreDosCodigos.Intf.Cliente;

type

  [TestFixture]
  TTesteCliente = class(TObject)
  private
    FClienteCompleto: ICliente;
    function ClienteDadosCompletos: ICliente;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure CriarCliente;
    [Test]
    procedure ClienteTemNome;
    [Test]
    procedure ClienteTemDataNascimento;
    [Test]
    procedure ClienteTemEndereco;
    [Test]
    procedure ClienteTemEmail;
    [Test]
    procedure ClienteTemTelefone;
    [Test]
    procedure ModificarNome;
    [Test]
    procedure ModificarDataNascimento;
    [Test]
    procedure ModificarEndereco;
    [Test]
    procedure AtribuirNovoEndereco;
    [Test]
    procedure ModificarEmail;
    [Test]
    procedure AtribuirNovoEmail;
    [Test]
    procedure ModificarTelefone;
    [Test]
    procedure TestarDadosClienteValido;
    [Test]
    procedure ModificarParaCEPInvalido;

  end;

implementation

uses
  System.SysUtils,
  System.DateUtils,
  pkgUtils.Intf.EMail,
  pkgUtils.Impl.EMail,
  pkgUtils.Intf.Telefone,
  pkgUtils.Impl.Telefone,
  pkgUtils.Intf.ListaRetornoValidacao,
  pkgUtils.Impl.ListaRetornoValidacao,
  pkgUtils.Intf.Endereco,
  pkgUtils.Impl.Endereco,
  OMestreDosCodigos.Intf.Cliente.Builder,
  OMestreDosCodigos.Impl.Cliente,
  OMestreDosCodigos.Impl.Cliente.Builder;

const
  LOGRADOURO = 'Av. Dr. Mario Clapier Ubinati';
  NUMERO = '16';
  BAIRRO = 'Zona 7';
  CEP = '87020000';
  COMPLEMENTO = 'apto 05';
  DATANASCIMENTO = '12/11/1984';
  EMail = 'ftathiago@gmail.com';
  NOME = 'Francisco Thiago de Almeida';
  Telefone = '67981339657';
  DDD = '67';
  CIDADE = 'Maringá';
  UF = 'PR';

procedure TTesteCliente.Setup;
begin
  FClienteCompleto := ClienteDadosCompletos;
end;

procedure TTesteCliente.TearDown;
begin
end;

procedure TTesteCliente.ClienteTemDataNascimento;
var
  _dataNascimentoVazia: TDateTime;
begin
  _dataNascimentoVazia := 0;
  Assert.AreNotEqual(_dataNascimentoVazia, FClienteCompleto.DATANASCIMENTO);
end;

procedure TTesteCliente.ClienteTemEmail;
begin
  Assert.IsTrue(Assigned(FClienteCompleto.EMail));
end;

procedure TTesteCliente.ClienteTemEndereco;
begin
  Assert.IsTrue(Assigned(FClienteCompleto.Endereco));
end;

procedure TTesteCliente.ClienteTemNome;
begin
  Assert.IsNotEmpty(FClienteCompleto.NOME);
end;

procedure TTesteCliente.ClienteTemTelefone;
begin
  Assert.IsNotEmpty(FClienteCompleto.Telefone.AsString);
end;

procedure TTesteCliente.AtribuirNovoEmail;
const
  NOVO_EMAIL = 'novoEmail@email.com';
begin
  FClienteCompleto.ModificarEmail(TEmail.New(NOVO_EMAIL));
  Assert.AreEqual(NOVO_EMAIL, FClienteCompleto.EMail.AsString);
end;

function TTesteCliente.ClienteDadosCompletos: ICliente;
var
  _clienteBuilder: IClienteBuilder;
begin
  _clienteBuilder := TClienteBuilder.New
    .NOME(NOME)
    .LOGRADOURO(LOGRADOURO)
    .NUMERO(DDD)
    .BAIRRO(BAIRRO)
    .CEP(CEP)
    .UF('PR')
    .CIDADE('Maring')
    .COMPLEMENTO(COMPLEMENTO)
    .DATANASCIMENTO(StrToDate(DATANASCIMENTO))
    .EMail(EMail)
    .Telefone(Telefone);
  _clienteBuilder.ConstruirNovaInstancia;
  result := _clienteBuilder.getObjeto;
end;

procedure TTesteCliente.CriarCliente;
var
  _cliente: ICliente;
begin
  _cliente := ClienteDadosCompletos;

  Assert.IsTrue(Assigned(_cliente));
end;

procedure TTesteCliente.ModificarDataNascimento;
begin
  FClienteCompleto.DATANASCIMENTO := Now;
  Assert.AreNotEqual(StrToDate(DATANASCIMENTO), FClienteCompleto.DATANASCIMENTO);
end;

procedure TTesteCliente.ModificarEmail;
begin
  FClienteCompleto.EMail.ModificarEmail('novoEmail@yahoo.com.br');
  Assert.AreNotEqual(EMail, FClienteCompleto.EMail.AsString);
end;

procedure TTesteCliente.ModificarEndereco;
const
  NOVO_LOGRADOURO = 'Novo logradouro';
begin
  FClienteCompleto.Endereco.ModificarLogradouro(NOVO_LOGRADOURO);
  Assert.AreEqual(NOVO_LOGRADOURO, FClienteCompleto.Endereco.LOGRADOURO);
end;

procedure TTesteCliente.ModificarNome;
begin
  FClienteCompleto.ModificarNome('Outro nome');
  Assert.AreNotEqual(NOME, FClienteCompleto.NOME);
end;

procedure TTesteCliente.ModificarParaCEPInvalido;
var
  _listaRetornoValidacao: IListaRetornoValidacao;
begin
  _listaRetornoValidacao := TListaRetornoValidacao.New([]);
  FClienteCompleto.Endereco.ModificarCEP('');
  Assert.IsFalse(FClienteCompleto.Validar(_listaRetornoValidacao));
  Assert.IsFalse(_listaRetornoValidacao.EstaVazio);
end;

procedure TTesteCliente.ModificarTelefone;
begin
  FClienteCompleto.ModificarTelefone(TTelefone.New('16999999999'));
  Assert.AreNotEqual(Telefone, FClienteCompleto.Telefone.AsString);
end;

procedure TTesteCliente.TestarDadosClienteValido;
var
  _listaRetornoValidacao: IListaRetornoValidacao;
begin
  _listaRetornoValidacao := TListaRetornoValidacao.New([]);
  Assert.IsTrue(FClienteCompleto.Validar(_listaRetornoValidacao));
end;

procedure TTesteCliente.AtribuirNovoEndereco;
var
  _enderecoOriginal: Integer;
  _enderecoAposModificacao: Integer;
  _endereco: IEndereco;
begin
  _endereco := TEndereco.New('NOVO LOGRADOURO', NUMERO, COMPLEMENTO, CEP, BAIRRO, CIDADE, UF);
  _enderecoOriginal := Integer(FClienteCompleto.Endereco);

  FClienteCompleto.ModificarEndereco(_endereco);
  _enderecoAposModificacao := Integer(FClienteCompleto.Endereco);

  Assert.AreNotEqual(_enderecoOriginal, _enderecoAposModificacao);
end;

initialization

TDUnitX.RegisterTestFixture(TTesteCliente);

end.
