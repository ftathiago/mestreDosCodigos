unit DDD.Core.Impl.Entidade;

interface

uses
  DDD.Core.Intf.ID, DDD.Core.Intf.Entidade;

type
  TEntidade = class(TInterfacedObject, IEntidade)
  private
    FID: IID;
  protected
    function GetNomeEntidade: string; virtual; abstract;
  public
    procedure DefinirNovoID(const AID: IID);
    function GetID: IID;
    property ID: IID read GetID;
  end;

implementation

{ TEntidade }

procedure TEntidade.DefinirNovoID(const AID: IID);
begin
  FID := AID;
end;

function TEntidade.GetID: IID;
begin
  result := FID;
end;

end.
