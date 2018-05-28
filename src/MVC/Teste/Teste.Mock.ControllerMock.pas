unit Teste.Mock.ControllerMock;

interface

uses
  MVC.Anotacoes.View, MVC.Impl.Controller;
const
  ANOTACAO_TESTE = 'TViewMock';

type

  [TViewAttribute(ANOTACAO_TESTE)]
  TControllerAnotadoMock = class(TController)
  end;

  TConctrollerAnotadoMockClass = class of TControllerAnotadoMock;

  TControllerNaoAnotadoMock = class(TController)
  end;

  TControllerNaoAnotadoClass = class of TControllerNaoAnotadoMock;

implementation

uses MVC.RegistroDeClasses, MVC.Controller.Impl.Factory;

initialization
  RegistrarController(TControllerAnotadoMock);
  RegistrarController(TControllerNaoAnotadoMock);

end.
