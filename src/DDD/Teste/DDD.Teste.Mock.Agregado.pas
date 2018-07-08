unit DDD.Teste.Mock.Agregado;

interface

uses DDD.Core.Impl.Agregado, DDD.Core.Intf.Agregado, DDD.Teste.Mock.Entidade, DDD.Core.Intf.ID,
  DDD.Core.Impl.IDRandomico, DDD.Modulo.Intf.Adaptador;

type
  IMockEntidadeAgregado = interface(IInterface)
    ['{9BF74447-F944-43E6-9E2B-F7BF1FC8222D}']
  end;

  TMockEntidadeAgregado = class(TAgregado<IMockEntidade>, IMockEntidadeAgregado)
  protected
    procedure CriarEntidade(var AEntidade: IMockEntidade); override;
  public
    function NovoID: IID; override;
  end;

implementation

uses
  DDD.Modulo.Intf.IDFactory, DDD.Modulo.Impl.IDFactory;

procedure TMockEntidadeAgregado.CriarEntidade(var AEntidade: IMockEntidade);
begin
  inherited;
  AEntidade := TMockEntidade.New(TIDFactory.New(tiRandomico).InicializarID(FieldByName('ID').AsInteger));
end;

function TMockEntidadeAgregado.NovoID: IID;
begin
  result := TIDFactory.New(tiRandomico).NovoID;
end;

end.
