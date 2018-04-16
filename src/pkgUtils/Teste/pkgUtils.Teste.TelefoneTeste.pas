unit pkgUtils.Teste.TelefoneTeste;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  pkgUtils.Intf.ListaRetornoValidacao,
  pkgUtils.Intf.Telefone,
  DUnitX.TestFramework;

type

  [TestFixture]
  TTelefoneTeste = class(TObject)
  private
    FRetorno: IListaRetornoValidacao;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure CriarTelefone;
    [Test]
    procedure CriarTelefoneVazio;
    [Test]
    procedure CriarApenasComDDD;
    [Test]
    procedure CriarApenasComTelefone;
    [Test]
    procedure CriarTelefoneCompletoTestarDDD;
    [Test]
    procedure CriarTelefoneCompletoTestarTelefone;
    [Test]
    procedure CriarTelefoneCompletoTestarTelefoneCompleto;
    [Test]
    procedure TelefoneCompletoValido;
    [Test]
    procedure TelefoneParcialmenteValido;
    [Test]
    procedure TelefoneTotalmenteInvalido;
  end;

implementation

uses
  pkgUtils.Impl.ListaRetornoValidacao,
  pkgUtils.Impl.Telefone;

const
  DDD = '67';
  Telefone = '981336957';
  TELEFONE_COMPLETO = DDD + Telefone;

  { TTelefoneTeste }

procedure TTelefoneTeste.CriarApenasComDDD;
var
  _telefone: ITelefone;
begin
  _telefone := TTelefone.New(DDD);

  Assert.IsEmpty(
    _telefone.getDDD,
    Format('O DDD deveria estar vazio [%s]', [_telefone.getDDD]));

  Assert.IsNotEmpty(_telefone.getTelefone);
  Assert.AreEqual(DDD, _telefone.getTelefone);
end;

procedure TTelefoneTeste.CriarApenasComTelefone;
var
  _telefone: ITelefone;
begin
  _telefone := TTelefone.New(Telefone);
  Assert.IsEmpty(_telefone.getDDD, 'O DDD deveria estar vazio');
  Assert.IsNotEmpty(_telefone.getTelefone);
  Assert.AreEqual(Telefone, _telefone.getTelefone);
end;

procedure TTelefoneTeste.CriarTelefone;
var
  _telefone: ITelefone;
begin
  _telefone := TTelefone.New(EmptyStr);
  Assert.IsTrue(Assigned(_telefone));
end;

procedure TTelefoneTeste.CriarTelefoneCompletoTestarDDD;
var
  _telefone: ITelefone;
begin
  _telefone := TTelefone.New(TELEFONE_COMPLETO);
  Assert.AreEqual(DDD, _telefone.getDDD);
end;

procedure TTelefoneTeste.CriarTelefoneCompletoTestarTelefone;
var
  _telefone: ITelefone;
begin
  _telefone := TTelefone.New(TELEFONE_COMPLETO);
  Assert.AreEqual(Telefone, _telefone.getTelefone);
end;

procedure TTelefoneTeste.CriarTelefoneCompletoTestarTelefoneCompleto;
var
  _telefone: ITelefone;
begin
  _telefone := TTelefone.New(TELEFONE_COMPLETO);
  Assert.AreEqual(TELEFONE_COMPLETO, _telefone.AsString);
end;

procedure TTelefoneTeste.CriarTelefoneVazio;
var
  _telefone: ITelefone;
begin
  _telefone := TTelefone.New(EmptyStr);
  Assert.IsEmpty(_telefone.getDDD);
  Assert.IsEmpty(_telefone.getTelefone);
  Assert.IsEmpty(_telefone.AsString);
end;

procedure TTelefoneTeste.Setup;
begin
  FRetorno := TListaRetornoValidacao.New([]);
end;

procedure TTelefoneTeste.TearDown;
begin

end;

procedure TTelefoneTeste.TelefoneCompletoValido;
var
  _telefone: ITelefone;
begin
  _telefone := TTelefone.New(TELEFONE_COMPLETO);
  Assert.IsTrue(_telefone.Validar(FRetorno));
end;

procedure TTelefoneTeste.TelefoneParcialmenteValido;
var
  _telefone: ITelefone;
begin
  _telefone := TTelefone.New(Telefone);
  Assert.IsFalse(_telefone.Validar(FRetorno));
end;

procedure TTelefoneTeste.TelefoneTotalmenteInvalido;
var
  _telefone: ITelefone;
begin
  _telefone := TTelefone.New(Telefone + DDD);
  Assert.IsFalse(_telefone.Validar(FRetorno));
end;

initialization

TDUnitX.RegisterTestFixture(TTelefoneTeste);

end.
