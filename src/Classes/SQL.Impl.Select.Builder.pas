unit SQL.Impl.Select.Builder;

interface

uses
  DesignPattern.Builder.Impl.Builder,
  SQL.Intf.Select,
  SQL.Intf.Select.Builder;

type
  TBuilderSelect = class(TBuilder<ISQLSelect>, IBuilderSelect)
  public
    class function New: IBuilderSelect;
    procedure ConstruirNovaInstancia; override;
    procedure buildCampo; virtual; abstract;
    procedure buildFrom; virtual; abstract;
    procedure buildJuncao; virtual; abstract;
    procedure buildWhere; virtual; abstract;
    procedure buildOrderBy; virtual; abstract;
  end;


implementation

uses
  SQL.Constantes,
  SQL.Impl.Fabrica;

{ TBuilderSelect }

procedure TBuilderSelect.ConstruirNovaInstancia;
begin
  inherited;
  FObjeto := TFabrica.New(SQL_TIPO_PADRAO).Select;
end;

class function TBuilderSelect.New: IBuilderSelect;
begin
  result := Create;
end;

end.
