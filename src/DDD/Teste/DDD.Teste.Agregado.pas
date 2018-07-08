unit DDD.Teste.Agregado;

interface

uses
  DUnitX.TestFramework, DDD.Core.Intf.Agregado, DDD.Teste.Mock.Entidade, DDD.Core.Impl.Agregado,
  DDD.Teste.Mock.Agregado;

type

  [TestFixture]
  TAgregadoTest = class(TObject)
  private
    FAgregado: TMockEntidadeAgregado;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CriarAgregado;
    [Test]
    procedure AgregadoCriaNovoID;
    [Test]
    procedure TestarIncluirEntidade;
    [Test]
    procedure TestarEditarEntidade;
    [Test]
    procedure TestarApagarComDados;
    [Test]
    procedure TestarApagarSemDados;
    [Test]
    procedure TestarLocalizar;
    [Test]
    procedure TestarRegistroAtualComDataSetVazio;
    [Test]
    procedure TestarRegistroAtualComDataSet;
    [Test]
    procedure MantemRegistradoODelta;
  end;

implementation

uses
  System.SysUtils, Data.DB, DDD.Core.Intf.ID, DDD.Modulo.Intf.IDFactory, DDD.Modulo.Impl.IDFactory;

procedure TAgregadoTest.Setup;
begin
  FAgregado := TMockEntidadeAgregado.Create(Nil);
  ConfigurarDataSet(FAgregado);
end;

procedure TAgregadoTest.TearDown;
begin
  FreeAndNil(FAgregado);
end;

procedure TAgregadoTest.AgregadoCriaNovoID;
var
  _id: IID;
begin
  _id := FAgregado.NovoID;
  Assert.IsTrue(Assigned(_id), 'Não criou o id');
  Assert.AreNotEqual(-1, _id.Valor);
end;

procedure TAgregadoTest.CriarAgregado;
begin
  Assert.IsTrue(Assigned(FAgregado));
end;

procedure TAgregadoTest.MantemRegistradoODelta;
var
  _mockEntidade: IMockEntidade;
  _id: IID;
begin
  _id := FAgregado.NovoID;
  _mockEntidade := TMockEntidade.New(nil);
  _mockEntidade.DefinirNovoID(_id);
  _mockEntidade.Campo1 := VALOR_CAMPO1;
  _mockEntidade.Campo2 := VALOR_CAMPO2;
  FAgregado.Incluir(_mockEntidade);
  FAgregado.MergeChangeLog;
  FAgregado.Edit;
  FAgregado.FieldByName('CAMPO1').AsString := 'Francisco Thiago de Almeida';
  FAgregado.Post;
  Assert.AreEqual(usModified, FAgregado.UpdateStatus);
  Assert.AreEqual(1, FAgregado.ChangeCount);
end;

procedure TAgregadoTest.TestarApagarComDados;
var
  _mockEntidade: IMockEntidade;
  _id: IID;
begin
  _id := FAgregado.NovoID;
  _mockEntidade := TMockEntidade.New(nil);
  _mockEntidade.DefinirNovoID(_id);
  _mockEntidade.Campo1 := VALOR_CAMPO1;
  _mockEntidade.Campo2 := VALOR_CAMPO2;
  FAgregado.Incluir(_mockEntidade);
  Assert.AreEqual(1, FAgregado.RecordCount);
  FAgregado.Apagar(_id);
  Assert.IsTrue(FAgregado.IsEmpty);
end;

procedure TAgregadoTest.TestarApagarSemDados;
var
  _id: IID;
begin
  _id := FAgregado.NovoID;
  Assert.IsTrue(FAgregado.IsEmpty);
  Assert.WillNotRaise(
    procedure
    begin
      FAgregado.Apagar(_id);
    end);
  Assert.IsTrue(FAgregado.IsEmpty);
end;

procedure TAgregadoTest.TestarEditarEntidade;
const
  NOVO_VALOR = 'Novo Valor';
var
  _mockEntidade: IMockEntidade;
begin
  _mockEntidade := TMockEntidade.New(TIDFactory.New(tiRandomico).NovoID);
  _mockEntidade.DefinirNovoID(FAgregado.NovoID);
  _mockEntidade.Campo1 := VALOR_CAMPO1;
  _mockEntidade.Campo2 := VALOR_CAMPO2;
  FAgregado.Incluir(_mockEntidade);
  _mockEntidade.Campo1 := NOVO_VALOR;

  Assert.WillNotRaise(
    procedure
    begin
      FAgregado.Incluir(_mockEntidade);
    end);

  Assert.AreEqual(1, FAgregado.RecordCount);
  Assert.AreEqual(NOVO_VALOR, FAgregado.FieldByName('CAMPO1').AsString);
end;

procedure TAgregadoTest.TestarIncluirEntidade;
var
  _mockEntidade: IMockEntidade;
begin
  _mockEntidade := TMockEntidade.New(TIDFactory.New(tiRandomico).NovoID);
  _mockEntidade.DefinirNovoID(FAgregado.NovoID);
  _mockEntidade.Campo1 := VALOR_CAMPO1;
  _mockEntidade.Campo2 := VALOR_CAMPO2;
  Assert.WillNotRaise(
    procedure
    begin
      FAgregado.Incluir(_mockEntidade);
    end);
  Assert.AreEqual(1, FAgregado.RecordCount);
end;

procedure TAgregadoTest.TestarLocalizar;
var
  _mockEntidade1: IMockEntidade;
  _mockEntidade2: IMockEntidade;
  _mockEntidade3: IMockEntidade;
begin
  _mockEntidade1 := TMockEntidade.New(TIDFactory.New(tiRandomico).NovoID);
  _mockEntidade1.DefinirNovoID(FAgregado.NovoID);
  _mockEntidade1.Campo1 := VALOR_CAMPO1;
  _mockEntidade1.Campo2 := VALOR_CAMPO2;
  FAgregado.Incluir(_mockEntidade1);

  _mockEntidade2 := TMockEntidade.New(TIDFactory.New(tiRandomico).NovoID);
  _mockEntidade2.DefinirNovoID(FAgregado.NovoID);
  _mockEntidade2.Campo1 := VALOR_CAMPO1;
  _mockEntidade2.Campo2 := VALOR_CAMPO2;
  FAgregado.Incluir(_mockEntidade2);

  _mockEntidade3 := FAgregado.Localizar(_mockEntidade1.ID);

  Assert.AreEqual(_mockEntidade3.ID.Valor, _mockEntidade1.ID.Valor);
end;

procedure TAgregadoTest.TestarRegistroAtualComDataSet;
var
  _mockEntidade: IMockEntidade;
  _registroAtual: IMockEntidade;
begin
  _mockEntidade := TMockEntidade.New(TIDFactory.New(tiRandomico).NovoID);
  _mockEntidade.DefinirNovoID(FAgregado.NovoID);
  _mockEntidade.Campo1 := VALOR_CAMPO1;
  _mockEntidade.Campo2 := VALOR_CAMPO2;
  FAgregado.Incluir(_mockEntidade);
  Assert.WillNotRaise(
    procedure
    begin
      _registroAtual := FAgregado.RegistroAtual
    end);
  Assert.IsTrue(Assigned(_registroAtual));
end;

procedure TAgregadoTest.TestarRegistroAtualComDataSetVazio;
var
  _registroAtual: IMockEntidade;
begin
  Assert.WillNotRaise(
    procedure
    begin
      _registroAtual := FAgregado.RegistroAtual
    end);
  Assert.IsFalse(Assigned(_registroAtual));
end;

initialization

TDUnitX.RegisterTestFixture(TAgregadoTest);

end.
