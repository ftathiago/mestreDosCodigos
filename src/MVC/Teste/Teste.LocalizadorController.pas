unit Teste.LocalizadorController;

interface

uses
  DUnitX.TestFramework, MVC.Intf.LocalizadorController;

type

  [TestFixture]
  TLocalizadorControllerTeste = class(TObject)
  private
    FLocalizador: ILocalizadorController;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure LocalizadorCriado;
    [Test]
    procedure EncontrarAClasse;
    [Test]
    procedure NaoEncontrarAClasse;
  end;

implementation

uses System.SysUtils, MVC.Impl.LocalizadorController, MVC.RegistroDeClasses, Teste.Mock.ViewMock, MVC.Anotacoes.View,
  Teste.Mock.ControllerMock, MVC.Impl.Controller;

procedure TLocalizadorControllerTeste.EncontrarAClasse;
var
  _controllerClass: TControllerClass;
begin
  _controllerClass := FLocalizador.Localizar(TViewAttribute, TViewMock.ClassName);
  Assert.IsTrue(Assigned(_controllerClass));
end;

procedure TLocalizadorControllerTeste.LocalizadorCriado;
begin
  Assert.IsTrue(Assigned(FLocalizador));
end;

procedure TLocalizadorControllerTeste.NaoEncontrarAClasse;
var
  _controllerClass: TControllerClass;
begin
  _controllerClass := FLocalizador.Localizar(TViewAttribute, TViewSemControllerMock.ClassName);
  Assert.IsTrue(not Assigned(_controllerClass));
end;

procedure TLocalizadorControllerTeste.Setup;
begin
  FLocalizador := TLocalizadorController.New(RetornarControllerLista);
end;

procedure TLocalizadorControllerTeste.TearDown;
begin
  FLocalizador := nil;
end;

initialization

TDUnitX.RegisterTestFixture(TLocalizadorControllerTeste);

end.
