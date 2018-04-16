unit DesignPattern.Builder.Impl.Builder;

interface

uses
  DesignPattern.Builder.Intf.Builder;

type
  TBuilder<Objeto> = class(TInterfacedObject, IBuilder<Objeto>)
  protected
    FObjeto: Objeto;
  public
    procedure ConstruirNovaInstancia; virtual; abstract;
    function getObjeto: Objeto;
  end;

implementation

{ TBuilder<T> }

function TBuilder<Objeto>.getObjeto: Objeto;
begin
  result := FObjeto;
end;

end.
