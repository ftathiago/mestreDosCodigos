unit DesignPattern.Builder.Impl.Builder;

interface

uses
  DesignPattern.Builder.Intf.Builder;

type
  TBuilder<ObjetoSQL> = class(TInterfacedObject, IBuilder<ObjetoSQL>)
  protected
    FObjeto: ObjetoSQL;
  public
    procedure ConstruirNovaInstancia; virtual; abstract;
    function getObjeto: ObjetoSQL;
  end;

implementation

{ TBuilder<T> }

function TBuilder<ObjetoSQL>.getObjeto: ObjetoSQL;
begin
  result := FObjeto;
end;

end.
