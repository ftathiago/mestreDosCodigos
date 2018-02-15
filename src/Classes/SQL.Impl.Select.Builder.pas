unit SQL.Impl.Select.Builder;

interface

uses
  SQL.Builder,
  SQL.Intf.Select,
  SQL.Intf.Select.Builder;

type
  TBuilderSelect = class(TSQLBuilder<ISQLSelect>, IBuilderSelect)
  public
    class function New: IBuilderSelect;
    procedure ConstruirNovaInstancia; override;
    procedure buildCampo; virtual; abstract;
    procedure buildFrom; virtual; abstract;
    procedure buildJuncao; virtual; abstract;
    procedure buildWhere; virtual; abstract;
    procedure buildOrderBy; virtual; abstract;
    procedure buildGroupBy; virtual; abstract;
  end;


implementation

uses
  SQL.Constantes,
  SQL.Impl.Fabrica;

{ TBuilderSelect }

procedure TBuilderSelect.ConstruirNovaInstancia;
begin
  inherited;
  FObjeto := TFabrica.New(getOtimizarPara).Select;
end;

class function TBuilderSelect.New: IBuilderSelect;
begin
  result := Create;
end;

end.
