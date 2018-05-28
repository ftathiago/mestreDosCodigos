unit MVC.Intf.Conectavel;

interface

uses
  Data.DB;

type
  IConectavel = interface(IInterface)
    ['{9F851AC5-FDCD-4489-A7B7-7B77131F01E5}']
    procedure DefinirConexao(const AConexao: TCustomConnection);
    function RetornarConexao: TCustomConnection;
  end;

implementation

end.
