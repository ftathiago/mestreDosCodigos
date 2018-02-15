unit SQL.Impl.Select.Director;

interface

uses
  DesignPattern.Builder.Impl.Director,
  SQL.Intf.Select,
  SQL.Intf.Select.Builder;

type
  TDirectorSelect = class(TDirector<IBuilderSelect, ISQLSelect>)
  public
    procedure Construir; override;
  end;

implementation

{ TDirectorSelect }

procedure TDirectorSelect.Construir;
begin
  inherited;
  FBuilder.ConstruirNovaInstancia;
  FBuilder.buildCampo;
  FBuilder.buildFrom;
  FBuilder.buildJuncao;
  FBuilder.buildWhere;
  FBuilder.buildOrderBy;
  FBuilder.buildGroupBy;

  FObjeto := FBuilder.getObjeto;
end;

end.
