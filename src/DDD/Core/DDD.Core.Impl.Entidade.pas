unit DDD.Core.Impl.Entidade;

interface

uses
  DDD.Core.Intf.Entidade;

type
  TEntidade = class(TInterfacedObject, IEntidade)
  private
  protected
    function GetNomeEntidade: string; virtual; abstract;
  end;

implementation

end.
