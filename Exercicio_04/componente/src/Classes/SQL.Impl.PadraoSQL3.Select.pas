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
  SQL.Impl.Select,
  SQL.Impl.Coluna.Lista,
  SQL.Impl.Condicao.Lista,
  SQL.Impl.Juncao.Lista;

type
  TSQL3Select = class(TSQLSelect)
  protected
    procedure MontarLimite(var StrBuilder: TStringBuilder);
    procedure MontarSalto(var StrBuilder: TStringBuilder);
    procedure MontarColunas(var StrBuilder: TStringBuilder);
    procedure MontarFrom(var StrBuilder: TStringBuilder);
    procedure MontarJuncoes(var StrBuilder: TStringBuilder);
    procedure MontarWhere(var StrBuilder: TStringBuilder);
    procedure MontarOrderBy(var StrBuilder: TStringBuilder);
    procedure MontarGroupBy(var StrBuilder: TStringBuilder);
    procedure MontarISQL(var StrBuilder: TStringBuilder; const ASQL: ISQL);
    procedure ConstruirSQL; override;
  end;

implementation


{ TSQL3Select }

uses
  System.TypInfo,
  SQL.Mensagens,
  SQL.Exceptions,
  SQL.Enums;

procedure TSQL3Select.ConstruirSQL;
var
  _sql: TStringBuilder;
  _sqlAntes: ISQL;
  _sqlApos: ISQL;
begin
  inherited;
  _sql := TStringBuilder.Create;
  try
    _sqlAntes := getSQLAntes;
    _sqlApos := getSQLApos;

    MontarISQL(_sql, _sqlAntes);
    _sql.Append('select ');
    MontarLimite(_sql);
    MontarColunas(_sql);
    MontarFrom(_sql);
    MontarJuncoes(_sql);
    MontarWhere(_sql);
    MontarOrderBy(_sql);
    MontarGroupBy(_sql);
    MontarISQL(_sql, _sqlApos);

    FTexto := _sql.ToString.Trim;
  finally
    _sql.Free;
  end;
end;

procedure TSQL3Select.MontarWhere(var StrBuilder: TStringBuilder);
begin
  if getCondicoes.Count <= 0 then
    exit;

  StrBuilder.AppendFormat('where %s', [getCondicoes.ToString]).AppendLine;
end;

procedure TSQL3Select.MontarJuncoes(var StrBuilder: TStringBuilder);
begin
  if getJuncoes.Count <= 0 then
    exit;

  StrBuilder.AppendLine(getJuncoes.ToString);
end;

procedure TSQL3Select.MontarLimite(var StrBuilder: TStringBuilder);
begin
  if getLimite > 0 then
    StrBuilder.AppendFormat('top %d ', [getLimite]);
end;

procedure TSQL3Select.MontarOrderBy(var StrBuilder: TStringBuilder);
begin
  if getOrderBy.Count <= 0 then
    exit;

  StrBuilder.AppendFormat('order by %s', [getOrderBy.ToString]);
end;

procedure TSQL3Select.MontarSalto(var StrBuilder: TStringBuilder);
begin
  if getSaltar > 0 then
    raise ESQLFeatureNaoImplementada.CreateFmt(SQL_FEATURE_NAO_IMPLEMENTADA_PARA,
      ['de salto', opPadraoSQL3.getNome]);
end;

procedure TSQL3Select.MontarColunas(var StrBuilder: TStringBuilder);
begin
  if getColunas.Count <= 0 then
    exit;

  StrBuilder.AppendLine(getColunas.ToString);
end;

procedure TSQL3Select.MontarFrom(var StrBuilder: TStringBuilder);
var
  _tabela: ISQLTabela;
begin
  _tabela := getTabela;

  if not Assigned(_tabela) then
    exit;

  StrBuilder
    .AppendFormat('from %s', [_tabela.ToString])
    .AppendLine;
end;

procedure TSQL3Select.MontarGroupBy(var StrBuilder: TStringBuilder);
begin
  if getGroupBy.Count <= 0 then
    exit;

  StrBuilder.AppendFormat('group by %s', [getGroupBy.ToString]);
end;

procedure TSQL3Select.MontarISQL(var StrBuilder: TStringBuilder; const ASQL: ISQL);
begin
  if Assigned(ASQL) then
    StrBuilder.AppendLine(ASQL.ToString);
end;

end.
