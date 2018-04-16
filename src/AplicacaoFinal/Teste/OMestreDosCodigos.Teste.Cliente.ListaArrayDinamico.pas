unit OMestreDosCodigos.Teste.Cliente.ListaArrayDinamico;

interface

uses
  DUnitX.TestFramework,
  OMestreDosCodigos.Intf.Cliente.ListaArrayDinamico,
  OMestreDosCodigos.Impl.Cliente.ListaArrayDinamico,
  OMestreDosCodigos.Intf.Cliente;

type

  [TestFixture]
  TTesteArrayDinamico = class(TObject)
  private
    FListaArrayDinamico: IListaArrayDinamico<ICliente>;
    FArrayQuatroInteiros: TArray<Integer>;
    FArrayQuatroClientes: TArray<ICliente>;
    function ClienteDadosCompletos(const index: Integer = 0): ICliente;
    function getListaComQuatroCoisas: IListaArrayDinamico<ICliente>;
    procedure RetirarOIndice20;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CriarListaArrayDinamico;
    [Test]
    procedure CriarListaInicializada;
    [Test]
    procedure AdicionarItem;
    [Test]
    procedure AdicionarArray;
    [Test]
    procedure RemoverIndiceMaiorQueOTamanho;
    [Test]
    [TestCase('Remover o primeiro', '0')]
    [TestCase('Remover o último', '4')]
    [TestCase('Remover do meio', '2')]
    procedure RemoverItem(const index: Integer);
    [Test]
    [TestCase('Alterar o primeiro', '1,Chico')]
    [TestCase('Alterar o último', '3,Tico')]
    [TestCase('Alterar do meio', '2,FT')]
    procedure AlterarNome(const index: Integer; const NovoNome: string);
    [Test]
    [TestCase('Alterar o primeiro', '1')]
    [TestCase('Alterar o último', '3')]
    [TestCase('Alterar do meio', '2')]
    procedure RecuperarODoMeio(const index: Integer);
    [Test]
    procedure AlterarRegistro;
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

  { TTesteArrayDinamico }

procedure TTesteArrayDinamico.AdicionarArray;
begin
  FListaArrayDinamico := TListaArrayDinamico<ICliente>.New([]);
  FListaArrayDinamico.AdicionarArray(FArrayQuatroClientes);
  Assert.AreEqual(SizeOf(FArrayQuatroInteiros), FListaArrayDinamico.Tamanho);
end;

procedure TTesteArrayDinamico.AdicionarItem;
begin
  FListaArrayDinamico := TListaArrayDinamico<ICliente>.New(FArrayQuatroClientes);

  FListaArrayDinamico.Adicionar(ClienteDadosCompletos);

  Assert.AreEqual(SizeOf(FArrayQuatroInteiros) + 1, FListaArrayDinamico.Tamanho);
end;

procedure TTesteArrayDinamico.AlterarNome(const index: Integer; const NovoNome: string);
var
  _cliente: ICliente;
begin
  FListaArrayDinamico := getListaComQuatroCoisas;
  _cliente := FListaArrayDinamico.Retornar(Index);
  _cliente.NOME := NovoNome;
  Assert.IsTrue(Assigned(_cliente));
  Assert.AreEqual(NovoNome, _cliente.NOME);
  Assert.AreNotEqual(NovoNome, FListaArrayDinamico.Retornar(0).NOME);
end;

procedure TTesteArrayDinamico.AlterarRegistro;
begin
  FListaArrayDinamico := getListaComQuatroCoisas;
  FListaArrayDinamico.Alterar(0, ClienteDadosCompletos(-1));
  Assert.AreEqual(NOME + IntToStr(-1), FListaArrayDinamico.Retornar(0).NOME);
end;

function TTesteArrayDinamico.ClienteDadosCompletos(const index: Integer): ICliente;
var
  _clienteBuilder: IClienteBuilder;
begin
  _clienteBuilder := TClienteBuilder.New
    .NOME(NOME + IntToStr(index))
    .LOGRADOURO(LOGRADOURO)
    .NUMERO(DDD)
    .BAIRRO(BAIRRO)
    .CEP(CEP)
    .COMPLEMENTO(COMPLEMENTO)
    .DATANASCIMENTO(StrToDate(DATANASCIMENTO))
    .EMail(EMail)
    .Telefone(Telefone);
  _clienteBuilder.ConstruirNovaInstancia;
  result := _clienteBuilder.getObjeto;
end;

procedure TTesteArrayDinamico.CriarListaArrayDinamico;
begin
  FListaArrayDinamico := getListaComQuatroCoisas;
  Assert.IsTrue(Assigned(FListaArrayDinamico));
end;

procedure TTesteArrayDinamico.CriarListaInicializada;
begin
  FListaArrayDinamico := getListaComQuatroCoisas;
  Assert.IsTrue(Assigned(FListaArrayDinamico));
end;

procedure TTesteArrayDinamico.RecuperarODoMeio(const index: Integer);
var
  _cliente: ICliente;
begin
  FListaArrayDinamico := getListaComQuatroCoisas;
  _cliente := FListaArrayDinamico.Retornar(Index);

  Assert.AreEqual(NOME + IntToStr(index), _cliente.NOME);
end;

procedure TTesteArrayDinamico.RemoverIndiceMaiorQueOTamanho;
begin
  FListaArrayDinamico := getListaComQuatroCoisas;
  Assert.WillRaiseAny(RetirarOIndice20, 'quis tirar 20');
end;

procedure TTesteArrayDinamico.RemoverItem;
var
  _tamanhoAntesRemover: Integer;
begin
  FListaArrayDinamico := getListaComQuatroCoisas;
  _tamanhoAntesRemover := FListaArrayDinamico.Tamanho;
  FListaArrayDinamico.Remover(0);
  Assert.AreEqual(_tamanhoAntesRemover - 1, FListaArrayDinamico.Tamanho);
end;

procedure TTesteArrayDinamico.RetirarOIndice20;
begin
  FListaArrayDinamico.Remover(20);
end;

procedure TTesteArrayDinamico.Setup;
begin
  FArrayQuatroInteiros := [1, 2, 3, 4];
  FArrayQuatroClientes := [
    ClienteDadosCompletos(0),
    ClienteDadosCompletos(1),
    ClienteDadosCompletos(2),
    ClienteDadosCompletos(3)];
end;

procedure TTesteArrayDinamico.TearDown;
begin
  FListaArrayDinamico := nil;
end;

function TTesteArrayDinamico.getListaComQuatroCoisas: IListaArrayDinamico<ICliente>;
begin
  result := TListaArrayDinamico<ICliente>.New(FArrayQuatroClientes);
end;

initialization

TDUnitX.RegisterTestFixture(TTesteArrayDinamico);

end.
