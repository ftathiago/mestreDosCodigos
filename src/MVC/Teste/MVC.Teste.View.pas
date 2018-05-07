unit MVC.Teste.View;

interface

uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TViewTeste = class(TObject)
  private
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure CriarView;
  end;

implementation

uses MVC.Intf.View, MVC.Impl.View;

procedure TViewTeste.CriarView;
var
  _view: IView;
begin
  _view := TFormView.Create(nil);
  Assert.IsTrue(Assigned(_view));
end;

procedure TViewTeste.Setup;
begin
end;

procedure TViewTeste.TearDown;
begin
end;

initialization

TDUnitX.RegisterTestFixture(TViewTeste);

end.
