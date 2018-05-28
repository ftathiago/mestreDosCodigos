unit Teste.Atributos.View;

interface

uses
  System.SysUtils, DUnitX.Attributes,
  DUnitX.TestFramework, Delphi.Mocks, MVC.Anotacoes.View;

{$M+}

type

  [TestFixture]
  TViewAtributoTeste = class(TObject)
  private
    Fatributo: TViewAttribute;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Test with TestCase Attribute to supply parameters.
    [Test]
    [TestCase('Teste com algo', 'NomeClasse')]
    [TestCase('Teste vazio', '')]
    procedure TestaCriacaoERecuperacao(const Anotacao: string);

    [Test]
    [IgnoreMemoryLeaks(True)]
    procedure TestarClasseContemAnotacao;

    [Test]
    [IgnoreMemoryLeaks(True)]
    procedure TestarClasseNaoContemAnotacao;
  end;

implementation

uses System.Classes, Teste.Mock.ControllerMock;

procedure TViewAtributoTeste.Setup;
begin
  Fatributo := TViewAttribute.Create(ANOTACAO_TESTE);
end;

procedure TViewAtributoTeste.TearDown;
begin
  FreeAndNil(Fatributo);
end;

procedure TViewAtributoTeste.TestaCriacaoERecuperacao(const Anotacao: string);
var
  _atributo: TViewAttribute;
begin
  _atributo := TViewAttribute.Create(Anotacao);
  try
    Assert.AreEqual(Anotacao, _atributo.Anotacao);
  finally
    FreeAndNil(_atributo);
  end;
end;

procedure TViewAtributoTeste.TestarClasseContemAnotacao;
var
  _class: TClass;
begin
  _class := TControllerAnotadoMock;
  Assert.IsTrue(Fatributo.ClasseContemEstaAnotacao(_class));
end;

procedure TViewAtributoTeste.TestarClasseNaoContemAnotacao;
var
  _class: TClass;
begin
  _class := TControllerNaoAnotadoMock;
  Assert.IsFalse(Fatributo.ClasseContemEstaAnotacao(_class));
end;

initialization

TDUnitX.RegisterTestFixture(TViewAtributoTeste);

end.
