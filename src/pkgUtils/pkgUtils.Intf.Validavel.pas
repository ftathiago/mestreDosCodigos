unit pkgUtils.Intf.Validavel;

interface

uses
  pkgUtils.Intf.ListaRetornoValidacao;

type
  IValidavel = Interface(IInterface)
    ['{C315D238-E832-493A-96E7-07184A36F5ED}']
    function Validar(const RetornoValidacao: IListaRetornoValidacao):boolean;
  end;

implementation

end.
