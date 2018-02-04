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
  SQL.Impl.SQL;

type
  TSQL3Select = class(TSQL, ISQLSelect)
  private
    FColunas: TList<ISQLColuna>;
    FCondicoes: TList<ISQLCondicao>;
    FJuncoes: TList<ISQLJuncao>;
    FTabela: ISQLTabela;
  protected
    function MontarResultSet: string;
    function MontarCamposDoWhere: string;
    function MontarJuncoes: string;
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

uses SQL.Mensagens;

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
  FCondicoes := TList<ISQLCondicao>.Create;
  FColunas := TList<ISQLColuna>.Create;
  FJuncoes := TList<ISQLJuncao>.Create;;
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

function TSQL3Select.getListaCondicoes
  : TList<SQL.Intf.Condicao.ISQLCondicao>;
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

function TSQL3Select.MontarCamposDoWhere: string;
const
  _sSEPARADOR = ', ';
var
  _coluna: ISQLColuna;
  _resultSet: TStringBuilder;
begin
  if FColunas.Count <= 0 then
    raise EListError.CreateFmt(LISTA_VAZIA, 'Campos');

  _resultSet := TStringBuilder.Create;
  try
    for _coluna in FCondicoes do
    begin
      _resultSet
        .Append(_sSEPARADOR)
        .Append(_coluna.ToString);
    end;
    _resultSet.Remove(0, _sSEPARADOR.Length);
    result := _resultSet.ToString;
  finally
    _resultSet.Free;
  end;
end;

function TSQL3Select.MontarJuncoes: string;
begin

end;

function TSQL3Select.MontarResultSet: string;
begin

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
begin

end;

function TSQL3Select.addColuna(const AColuna: ISQLColuna): ISQLSelect;
begin
  FColunas.Add(AColuna);
end;

end.
