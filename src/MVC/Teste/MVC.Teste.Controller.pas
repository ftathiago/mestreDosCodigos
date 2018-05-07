unit MVC.Teste.Controller;

interface

uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TControllerTeste = class(TObject)
  private
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure CriarController;
  end;

implementation

uses MVC.Impl.Controller, MVC.Intf.Controller, MVC.Intf.View;

type


procedure TControllerTeste.CriarController;
var
  _view: IView;
  _controller: IController;
begin
  _controller := TController.New;
  _controller
  _view := TFormView.Create(nil);
  Assert.IsTrue(Assigned(_view));
end;

procedure TControllerTeste.Setup;
begin
end;

procedure TControllerTeste.TearDown;
begin
end;

initialization

TDUnitX.RegisterTestFixture(TControllerTeste);

end.
