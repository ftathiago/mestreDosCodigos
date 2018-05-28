unit Teste.Controller.Factory;

interface

uses
  DUnitX.TestFramework, Delphi.Mocks, MVC.Controller.Intf.Factory, Teste.Mock.ViewMock, MVC.Intf.Controller;

type

  [TestFixture]
  TControllerFactoryTest = class(TObject)
  private
    FFactory: IControllerFactory;
    FController: IController;
    FViewMock: TMock<TViewMock>;
    FViewSemControllerMock: TMock<TViewSemControllerMock>;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CriarFactory;
    [Test]
    procedure RetonarController;
    [Test]
    procedure NaoRetonarController;
  end;

implementation

uses System.SysUtils, System.Classes, MVC.Controller.Impl.Factory, Teste.Mock.ControllerMock;

procedure TControllerFactoryTest.NaoRetonarController;
begin
  FController := FFactory.RetornarControleDaView(FViewSemControllerMock.Instance.ClassName);
  Assert.IsFalse(Assigned(FController));
end;

procedure TControllerFactoryTest.RetonarController;
begin
  FController := FFactory.RetornarControleDaView(FViewMock.Instance.ClassName);
  Assert.IsTrue(Assigned(FController));
end;

procedure TControllerFactoryTest.Setup;
begin
  FFactory := TControllerFactory.New;

  FViewMock := TMock<TViewMock>.Create();
  FViewMock.Setup.WillReturn('TViewMock').When.ClassName;

  FViewSemControllerMock := TMock<TViewSemControllerMock>.Create;
FViewSemControllerMock.Setup.WillReturn('TViewSemControllerMock').When.ClassName;
end;

procedure TControllerFactoryTest.TearDown;
begin
  FController := nil;
end;

procedure TControllerFactoryTest.CriarFactory;
begin
  Assert.IsTrue(Assigned(FFactory));
end;

initialization

TDUnitX.RegisterTestFixture(TControllerFactoryTest);

end.
