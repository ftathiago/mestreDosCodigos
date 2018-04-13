unit SQL.Impl.Select;

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
  TSQLSelect = class(TSQL, ISQLSelect)
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
    function getSQLAntes: ISQL;
    function getSQLApos: ISQL;
    function getColunas: TListaColunaSelect;
    function getJuncoes: TListaJuncao;
    function getCondicoes: TListaCondicao;
    function getOrderBy: TListaColunaSelect;
    function getGroupBy: TListaColunaSelect;
  public
    class function New: ISQLSelect; reintroduce;
    constructor Create; override;
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


{ TSQLSelect }

uses
  System.TypInfo,
  SQL.Mensagens,
  SQL.Exceptions,
  SQL.Enums;

class function TSQLSelect.New: ISQLSelect;
begin
  result := Create;
end;

constructor TSQLSelect.Create;
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

destructor TSQLSelect.Destroy;
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

function TSQLSelect.addCondicao(const ACondicao: ISQLCondicao): ISQLSelect;
begin
  FCondicoes.Add(ACondicao);
end;

function TSQLSelect.addGroupBy(const AColuna: ISQLColuna): ISQLSelect;
begin
  FGroupBy.Add(AColuna);
end;

function TSQLSelect.addJuncao(const AJuncao: ISQLJuncao): ISQLJuncao;
begin
  FJuncoes.Add(AJuncao);
end;

function TSQLSelect.addOrderBy(const AColuna: ISQLColuna): ISQLSelect;
begin
  result := Self;
  FOrderBy.Add(AColuna);
end;

function TSQLSelect.getColunas: TListaColunaSelect;
begin
  result := FColunas;
end;

function TSQLSelect.getCondicoes: TListaCondicao;
begin
  result := FCondicoes
end;

function TSQLSelect.getGroupBy: TListaColunaSelect;
begin
  result := FGroupBy;
end;

function TSQLSelect.getJuncoes: TListaJuncao;
begin
  result := FJuncoes;
end;

function TSQLSelect.getLimite: integer;
begin
  result := FLimite;
end;

function TSQLSelect.getListaColuna: TList<SQL.Intf.Coluna.ISQLColuna>;
begin
  result := FColunas;
end;

function TSQLSelect.getListaCondicoes: TList<SQL.Intf.Condicao.ISQLCondicao>;
begin
  result := FCondicoes
end;

function TSQLSelect.getListaJuncao: TList<SQL.Intf.Juncao.ISQLJuncao>;
begin
  result := FJuncoes;
end;

function TSQLSelect.getOrderBy: TListaColunaSelect;
begin
  result := FOrderBy;
end;

function TSQLSelect.getSaltar: integer;
begin
  result := FSaltar;
end;

function TSQLSelect.getSQLAntes: ISQL;
begin
  result := FSQLAntes;
end;

function TSQLSelect.getSQLApos: ISQL;
begin
  result := FSQLApos;
end;

function TSQLSelect.getTabela: ISQLTabela;
begin
  result := FTabela
end;

function TSQLSelect.injectSQLAntes(const SQLAntes: ISQL): ISQLSelect;
begin
  result := Self;
  FSQLAntes := SQLAntes;
end;

function TSQLSelect.injectSQLApos(const SQLApos: ISQL): ISQLSelect;
begin
  result := Self;
  FSQLApos := SQLApos;
end;

function TSQLSelect.setLimite(const Registros: integer): ISQLSelect;
begin
  result := Self;

  FLimite := Registros;
end;

function TSQLSelect.setSaltar(const Registros: integer): ISQLSelect;
begin
  FSaltar := Registros;
end;

function TSQLSelect.setTabela(const ATabela: ISQLTabela): ISQLSelect;
begin
  FTabela := ATabela;
end;

function TSQLSelect.addColuna(const AColuna: ISQLColuna): ISQLSelect;
begin
  FColunas.Add(AColuna);
end;

end.
