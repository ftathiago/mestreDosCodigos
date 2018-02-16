unit SQL.Impl.PadraoSQL3.Select;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  SQL.Intf.SQL,
  SQL.Intf.Select,
  SQL.Intf.Coluna,
  SQL.Intf.Tabela,
  SQL.Intf.Juncao,
  SQL.Intf.Condicao,
  SQL.Impl.SQL,
  SQL.Impl.Coluna.Lista,
  SQL.Impl.Condicao.Lista,
  SQL.Impl.Juncao.Lista;

type
  TSQL3Select = class(TSQL, ISQLSelect)
  private
    FColunas: TListaColunaSelect;
    FOrderBy: TListaColunaSelect;
    FGroupBy: TListaColunaSelect;
    FCondicoes: TListaCondicao;
    FJuncoes: TListaJuncao;
    FTabela: ISQLTabela;
    FLimite: integer;
    FSaltar: integer;
    FSQLAntes: ISQL;
    FSQLApos: ISQL;
  protected
    function MontarSQLAntes: string; virtual;
    function MontarLimite: string; virtual;
    function MontarSalto: string; virtual;
    function MontarColunas: string; virtual;
    function MontarFrom: string; virtual;
    function MontarJuncoes: string; virtual;
    function MontarWhere: string; virtual;
    function MontarOrderBy: string; virtual;
    function MontarGroupBy: string; virtual;
    function MontarSQLApos: string; virtual;
    procedure ConstruirSQL; override;
  public
    constructor Create; override;
    class function New: ISQLSelect; reintroduce;
    destructor Destroy; override;
    function injectSQLAntes(const SQLAntes: ISQL): ISQLSelect;
    function injectSQLApos(const SQLApos: ISQL): ISQLSelect;
    function getLimite: integer;
    function setLimite(const Registros: integer): ISQLSelect;
    function getSaltar: integer;
    function setSaltar(const Registros: integer): ISQLSelect;
    function addColuna(const AColuna: ISQLColuna): ISQLSelect;
    function addCondicao(const ACondicao: ISQLCondicao): ISQLSelect;
    function addJuncao(const AJuncao: ISQLJuncao): ISQLJuncao;
    function addOrderBy(const AColuna: ISQLColuna): ISQLSelect;
    function addGroupBy(const AColuna: ISQLColuna): ISQLSelect;
    function getListaColuna: TList<SQL.Intf.Coluna.ISQLColuna>;
    function getListaCondicoes: TList<SQL.Intf.Condicao.ISQLCondicao>;
    function getListaJuncao: TList<SQL.Intf.Juncao.ISQLJuncao>;
    function getTabela: ISQLTabela;
    function setTabela(const ATabela: ISQLTabela): ISQLSelect;
  end;

implementation


{ TSQL3Select }

uses
  System.TypInfo,
  SQL.Mensagens,
  SQL.Exceptions,
  SQL.Enums;

function TSQL3Select.addCondicao(const ACondicao: ISQLCondicao): ISQLSelect;
begin
  FCondicoes.Add(ACondicao);
end;

function TSQL3Select.addGroupBy(const AColuna: ISQLColuna): ISQLSelect;
begin
  FGroupBy.Add(AColuna);
end;

function TSQL3Select.addJuncao(const AJuncao: ISQLJuncao): ISQLJuncao;
begin
  FJuncoes.Add(AJuncao);
end;

function TSQL3Select.addOrderBy(const AColuna: ISQLColuna): ISQLSelect;
begin
  result := Self;
  FOrderBy.Add(AColuna);
end;

procedure TSQL3Select.ConstruirSQL;
var
  _sql: TStringBuilder;
begin
  inherited;
  _sql := TStringBuilder.Create;
  try
    if Assigned(FSQLAntes) then
      _sql.AppendLine(MontarSQLAntes);

    _sql.Append('select ');

    if FLimite > 0 then
      _sql.AppendLine(MontarLimite);

    _sql.AppendLine(MontarColunas);
    _sql.AppendLine(MontarFrom);
    _sql.AppendLine(MontarJuncoes);
    _sql.AppendLine(MontarWhere);
    _sql.AppendLine(MontarOrderBy);
    _sql.AppendLine(MontarGroupBy);

    if Assigned(FSQLApos) then
      _sql.AppendLine(MontarSQLApos);

    FTexto := _sql.ToString.Trim;
  finally
    _sql.Free;
  end;
end;

constructor TSQL3Select.Create;
begin
  inherited;
  FSQLAntes := nil;
  FSQLApos := nil;
  FCondicoes := TListaCondicao.Create;
  FColunas := TListaColunaSelect.Create;
  FJuncoes := TListaJuncao.Create;
  FOrderBy := TListaColunaSelect.Create;
  FGroupBy := TListaColunaSelect.Create;
end;

destructor TSQL3Select.Destroy;
begin
  FCondicoes.Clear;
  FColunas.Clear;
  FJuncoes.Clear;
  FOrderBy.Clear;
  FGroupBy.Clear;

  FreeAndNil(FCondicoes);
  FreeAndNil(FColunas);
  FreeAndNil(FJuncoes);
  FreeAndNil(FOrderBy);
  FreeAndNil(FGroupBy);
  inherited;
end;

function TSQL3Select.getLimite: integer;
begin
  result := FLimite;
end;

function TSQL3Select.getListaColuna: TList<SQL.Intf.Coluna.ISQLColuna>;
begin
  result := FColunas;
end;

function TSQL3Select.getListaCondicoes: TList<SQL.Intf.Condicao.ISQLCondicao>;
begin
  result := FCondicoes
end;

function TSQL3Select.getListaJuncao: TList<SQL.Intf.Juncao.ISQLJuncao>;
begin
  result := FJuncoes;
end;

function TSQL3Select.getSaltar: integer;
begin
  result := FSaltar;
end;

function TSQL3Select.getTabela: ISQLTabela;
begin
  result := FTabela
end;

function TSQL3Select.injectSQLAntes(const SQLAntes: ISQL): ISQLSelect;
begin
  result := Self;
  FSQLAntes := SQLAntes;
end;

function TSQL3Select.injectSQLApos(const SQLApos: ISQL): ISQLSelect;
begin
  result := Self;
  FSQLApos := SQLApos;
end;

function TSQL3Select.MontarWhere: string;
begin
  result := EmptyStr;

  if not Assigned(FCondicoes) then
    exit;

  result := FCondicoes.ToString;

  if not result.Trim.IsEmpty then
    result := Format('where %s', [result]);
end;

function TSQL3Select.MontarJuncoes: string;
begin
  result := EmptyStr;

  if not Assigned(FJuncoes) then
    exit;

  result := FJuncoes.ToString;
end;

function TSQL3Select.MontarLimite: string;
begin
  result := EmptyStr;
  if FLimite > 0 then
    result := Format('top %d', [FLimite]);
end;

function TSQL3Select.MontarOrderBy: string;
begin
  result := EmptyStr;

  if not Assigned(FOrderBy) then
    exit;

  if FOrderBy.Count <= 0 then
    exit;

  result := Format('order by %s', [FOrderBy.ToString]);
end;

function TSQL3Select.MontarSalto: string;
begin
  if FSaltar > 0 then
    raise ESQLFeatureNaoImplementada.CreateFmt(SQL_FEATURE_NAO_IMPLEMENTADA_PARA,
      ['de salto', opPadraoSQL3.getNome]);
end;

function TSQL3Select.MontarSQLAntes: string;
begin
  result := EmptyStr;
  if Assigned(FSQLAntes) then
    result := FSQLAntes.ToString;
end;

function TSQL3Select.MontarSQLApos: string;
begin
  result := EmptyStr;
  if Assigned(FSQLApos) then
    result := FSQLApos.ToString
end;

function TSQL3Select.MontarColunas: string;
begin
  result := EmptyStr;

  if not Assigned(FColunas) then
    exit;

  result := FColunas.ToString;
end;

function TSQL3Select.MontarFrom: string;
begin
  result := EmptyStr;

  if not Assigned(FTabela) then
    exit;

  result := Format('from %s', [FTabela.ToString]);
end;

function TSQL3Select.MontarGroupBy: string;
begin
  result := EmptyStr;

  if not Assigned(FGroupBy) then
    exit;

  if FGroupBy.Count <= 0 then
    exit;

  result := Format('group by %s', [FGroupBy.ToString]);
end;

class function TSQL3Select.New: ISQLSelect;
begin
  result := Create;
end;

function TSQL3Select.setLimite(const Registros: integer): ISQLSelect;
begin
  result := Self;

  FLimite := Registros;
end;

function TSQL3Select.setSaltar(const Registros: integer): ISQLSelect;
begin
  FSaltar := Registros;
end;

function TSQL3Select.setTabela(const ATabela: ISQLTabela): ISQLSelect;
begin
  FTabela := ATabela;
end;

function TSQL3Select.addColuna(const AColuna: ISQLColuna): ISQLSelect;
begin
  FColunas.Add(AColuna);
end;

end.
