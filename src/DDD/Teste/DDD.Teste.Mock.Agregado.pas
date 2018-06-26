unit DDD.Teste.Mock.Agregado;

interface

uses DDD.Core.Impl.Agregado, DDD.Core.Intf.Agregado, DDD.Teste.Mock.Entidade, DDD.Core.Intf.ID,
  DDD.Core.Impl.IDRandomico;

type
  IMockEntidadeAgregado = interface(IInterface)
    ['{9BF74447-F944-43E6-9E2B-F7BF1FC8222D}']
  end;

  TMockEntidadeAgregado = class(TAgregado<IMockEntidade>, IMockEntidadeAgregado)
    procedure Apagar(const AEntidade: IMockEntidade); override;
    procedure Incluir(const AEntidade: IMockEntidade); override;
    function Localizar(const AID: IID): IMockEntidade; override;
    function NovoID: IID; override;
  end;

implementation

uses
  pkgUtils.Intf.DataSetPropriedadesTemporarias, pkgUtils.Impl.FDDataSetPropriedadesTemporarias,
  DDD.Modulo.Impl.IDFactory, DDD.Modulo.Intf.IDFactory;

procedure TMockEntidadeAgregado.Apagar(const AEntidade: IMockEntidade);
var
  FDPropTemp: IDataSetPropriedadesTemporarias;
begin
  inherited;
  FDPropTemp := TFDDataSetPropriedadesTemporarias.New(Self);
  Self.IndexFieldNames := 'ID';
  if not Self.FindKey([AEntidade.ID]) then
    exit;
  Self.Delete;
end;

procedure TMockEntidadeAgregado.Incluir(const AEntidade: IMockEntidade);
begin
  inherited;

end;

function TMockEntidadeAgregado.Localizar(const AID: IID): IMockEntidade;
begin

end;

function TMockEntidadeAgregado.NovoID: IID;
begin
  result :=  TIDFactory.New(tiRandomico).NovoID;
end;

end.
