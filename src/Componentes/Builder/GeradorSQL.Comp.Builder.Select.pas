unit GeradorSQL.Comp.Builder.Select;

interface

uses
  SQL.Impl.Builder,
  SQL.Intf.Builder.Select,
  SQL.Impl.Builder.Select,
  GeradorSQL.Comp.SQLDto;

type
  TSelectCollectionBuilder = class(TBuilderSelect)
  private
    FSQLDto: TSQLDto;
  protected
    function getSQLDto: TSQLDto;
  public
    procedure SetSelectCollection(const SQLDto: TSQLDto);
    procedure buildCampo; override;
    procedure buildFrom; override;
    procedure buildJuncao; override;
    procedure buildWhere; override;
  end;

implementation

{ TSelectCollectionBuilder }

procedure TSelectCollectionBuilder.buildCampo;
begin
  inherited;

end;

procedure TSelectCollectionBuilder.buildFrom;
begin
  inherited;

end;

procedure TSelectCollectionBuilder.buildJuncao;
begin
  inherited;

end;

procedure TSelectCollectionBuilder.buildWhere;
begin
  inherited;

end;

function TSelectCollectionBuilder.getSQLDto: TSQLDto;
begin
  result := FSQLDto;
end;

procedure TSelectCollectionBuilder.SetSelectCollection(const SQLDto: TSQLDto);
begin
  FSQLDto := SQLDto;
end;

end.
