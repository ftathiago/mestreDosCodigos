unit SQL.Impl.Builder;

interface

uses
  DesignPattern.Builder.Impl.Builder,
  SQL.Enums,
  SQL.Intf.Builder;

type
  TSQLBuilder<ObjetoSQL> = class(TBuilder<ObjetoSQL>, ISQLBuilder<ObjetoSQL>)
  private
    FOtimizarPara: TOtimizarPara;
  protected
    procedure setOtimizarPara(const AOtimizarPara: TOtimizarPara);
    function getOtimizarPara: TOtimizarPara;
  public
    constructor Create; reintroduce;
    procedure buildSQL; virtual; abstract;
  end;

implementation

uses
  SQL.Impl.Fabrica,
  SQL.Constantes;

{ TSQLBuilder<ObjetoSQL> }

constructor TSQLBuilder<ObjetoSQL>.Create;
begin
  inherited Create;
  FOtimizarPara := opUnknow;
end;

function TSQLBuilder<ObjetoSQL>.getOtimizarPara: TOtimizarPara;
begin
  result := FOtimizarPara;
end;

procedure TSQLBuilder<ObjetoSQL>.setOtimizarPara(const AOtimizarPara: TOtimizarPara);
begin
  FOtimizarPara := AOtimizarPara;
end;

end.
