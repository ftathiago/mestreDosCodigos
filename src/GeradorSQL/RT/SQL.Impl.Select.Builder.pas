unit SQL.Impl.Select.Builder;

interface

uses
  SQL.Impl.Builder,
  SQL.Intf.Select,
  SQL.Intf.Select.Builder;

type
  TBuilderSelect = class(TSQLBuilder<ISQLSelect>, IBuilderSelect)
  public
    class function New: IBuilderSelect;
    procedure ConstruirNovaInstancia; override;
    procedure buildSQLAntes; virtual; abstract;
    procedure buildSQLApos; virtual; abstract;
    procedure buildLimite; virtual; abstract;
    procedure buildSalto; virtual; abstract;
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


class function TBuilderSelect.New: IBuilderSelect;
begin
  result := Create;
end;

procedure TBuilderSelect.ConstruirNovaInstancia;
begin
  inherited;
  FObjeto := TFabrica.New(getOtimizarPara).Select;
end;

end.
