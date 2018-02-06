unit SQL.Impl.PadraoSQL3.Select;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
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
    FCondicoes: TListaCondicao;
    FJuncoes: TListaJuncao;
    FTabela: ISQLTabela;
  protected
    function MontarColunas: string; virtual;
    function MontarFrom: string; virtual;
    function MontarJuncoes: string; virtual;
    function MontarWhere: string; virtual;
  public
    constructor Create;
    class function New: ISQLSelect;
    destructor Destroy; override;
    function addColuna(const AColuna: ISQLColuna): ISQLSelect;
    function addCondicao(const ACondicao: ISQLCondicao): ISQLSelect;
    function addJuncao(const AJuncao: ISQLJuncao): ISQLJuncao;
    function getListaColuna: TList<SQL.Intf.Coluna.ISQLColuna>;
    function getListaCondicoes: TList<SQL.Intf.Condicao.ISQLCondicao>;
    function getListaJuncao: TList<SQL.Intf.Juncao.ISQLJuncao>;
    function getTabela: ISQLTabela;
    function setTabela(const ATabela: ISQLTabela): ISQLSelect;
    function ToString: string; override;
  end;

implementation


{ TSQL3Select }

uses
  SQL.Mensagens,
  SQL.Enums;

function TSQL3Select.addCondicao(const ACondicao: ISQLCondicao): ISQLSelect;
begin
  FCondicoes.Add(ACondicao);
end;

function TSQL3Select.addJuncao(const AJuncao: ISQLJuncao): ISQLJuncao;
begin
  FJuncoes.Add(AJuncao);
end;

constructor TSQL3Select.Create;
begin
  FCondicoes := TListaCondicao.Create;
  FColunas := TListaColunaSelect.Create;
  FJuncoes := TListaJuncao.Create;
end;

destructor TSQL3Select.Destroy;
begin
  FCondicoes.Clear;
  FColunas.Clear;
  FJuncoes.Clear;

  FreeAndNil(FCondicoes);
  FreeAndNil(FColunas);
  FreeAndNil(FJuncoes);
  inherited;
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

function TSQL3Select.getTabela: ISQLTabela;
begin
  result := FTabela
end;

function TSQL3Select.MontarWhere: string;
begin
  result := EmptyStr;

  if not Assigned(FCondicoes) then
    exit;

  result := FCondicoes.ToString;

  if not result.trim.IsEmpty then
    result := 'where ' + result;
end;

function TSQL3Select.MontarJuncoes: string;
begin
  result := EmptyStr;

  if not Assigned(FJuncoes) then
    exit;

  result := FJuncoes.ToString;
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

  result := FTabela.ToString;
end;

class function TSQL3Select.New: ISQLSelect;
begin
  result := Create;
end;

function TSQL3Select.setTabela(const ATabela: ISQLTabela): ISQLSelect;
begin
  FTabela := ATabela;
end;

function TSQL3Select.ToString: string;
var
  _sql: TStringBuilder;
begin
  _sql := TStringBuilder.Create;
  try
    _sql.Append('select ');
    _sql.AppendLine(MontarColunas);
    _sql.Append('from ');
    _sql.AppendLine(MontarFrom);
    _sql.AppendLine(MontarJuncoes);
    _sql.AppendLine(MontarWhere);
    result := _sql.ToString.trim;
  finally
    _sql.Free;
  end;
end;

function TSQL3Select.addColuna(const AColuna: ISQLColuna): ISQLSelect;
begin
  FColunas.Add(AColuna);
end;

end.
