unit uListaRetornoValidacaoTeste;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  pkgUtils.Intf.ListaRetornoValidacao,
  DUnitX.TestFramework;

type

  [TestFixture]
  TListaRetornoValidacaoTeste = class(TObject)
  private
    function RetonaListaDeRetornos: TArray<TRetornoValidacao>;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure CriarListaVazia;
    [Test]
    procedure CriarListaComElementos;
    [Test]
    procedure ElementosSaoDiferentes;
    [Test]
    procedure ElementosSaoDiferentesNaMemoria;
    [Test]
    procedure ElementosExistemAposAListaSerDestruida;
  end;

implementation

uses
  pkgUtils.Impl.ListaRetornoValidacao;

const
  TOTAL_ELEMENTOS = 11;

procedure TListaRetornoValidacaoTeste.Setup;
begin

end;

procedure TListaRetornoValidacaoTeste.TearDown;
begin

end;

procedure TListaRetornoValidacaoTeste.ElementosExistemAposAListaSerDestruida;
var
  _lista: IListaRetornoValidacao;
  _retorno: TRetornoValidacao;
begin
  _lista := TListaRetornoValidacao.New(RetonaListaDeRetornos);
  _retorno := _lista.getValidacao(1);
  _lista := nil;
  Assert.IsNotEmpty(_retorno.MensagemDeErro);
end;

procedure TListaRetornoValidacaoTeste.ElementosSaoDiferentes;
var
  _lista: IListaRetornoValidacao;
  _codigo1: integer;
  _codigo2: integer;
  _msg1: string;
  _msg2: string;
begin
  _lista := TListaRetornoValidacao.New(RetonaListaDeRetornos);
  _codigo1 := _lista.getValidacao(0).CodigoRetorno;
  _msg1 := _lista.getValidacao(0).MensagemDeErro;

  _codigo2 := _lista.getValidacao(1).CodigoRetorno;
  _msg2 := _lista.getValidacao(1).MensagemDeErro;

  Assert.AreNotEqual(_codigo1, _codigo2);
  Assert.AreNotEqual(_msg1, _msg2);
end;

procedure TListaRetornoValidacaoTeste.ElementosSaoDiferentesNaMemoria;
var
  _lista: IListaRetornoValidacao;
  _retorno1: TRetornoValidacao;
  _retorno2: TRetornoValidacao;
begin
  _lista := TListaRetornoValidacao.New(RetonaListaDeRetornos);
  _retorno1 := _lista.getValidacao(0);
  _retorno2 := _lista.getValidacao(1);

  Assert.AreNotEqualMemory(@_retorno1, @_retorno2, SizeOf(TRetornoValidacao));
end;

function TListaRetornoValidacaoTeste.RetonaListaDeRetornos: TArray<TRetornoValidacao>;
var
  _lista: TList<TRetornoValidacao>;
  _retorno: TRetornoValidacao;
  i: Integer;
begin
  _lista := TList<TRetornoValidacao>.Create;
  try
    for i := 0 to Pred(TOTAL_ELEMENTOS) do
    begin
      _retorno.CodigoRetorno := i;
      _retorno.MensagemDeErro := Format('MSG%d', [i]);
      _lista.Add(_retorno);
    end;
    result := _lista.ToArray;
  finally
    _lista.Clear;
    FreeAndNil(_lista);
  end;
end;

procedure TListaRetornoValidacaoTeste.CriarListaVazia;
var
  _lista: IListaRetornoValidacao;
begin
  _lista := TListaRetornoValidacao.New([]);
  Assert.AreEqual(0, _lista.getQtd);
end;

procedure TListaRetornoValidacaoTeste.CriarListaComElementos;
var
  _lista: IListaRetornoValidacao;
begin
  _lista := TListaRetornoValidacao.New(RetonaListaDeRetornos);
  Assert.AreEqual(TOTAL_ELEMENTOS, _lista.getQtd);
end;

initialization

TDUnitX.RegisterTestFixture(TListaRetornoValidacaoTeste);

end.
