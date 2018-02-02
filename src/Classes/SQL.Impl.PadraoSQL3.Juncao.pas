unit SQL.Impl.PadraoSQL3.Juncao;

interface

uses
  System.Generics.Collections,
  SQL.Enums,
  SQL.Exceptions,
  SQL.Impl.SQL,
  SQL.Intf.Juncao,
  SQL.Intf.Tabela,
  SQL.Intf.Condicao;

type
  TSQL3Juncao = class(TSQL, ISQLJuncao)
  private
    FTipoJuncao: TTipoJuncao;
    FTabelaEstrangeira: ISQLTabela;
    FCondicoes: TList<ISQLCondicao>;
    function PegarCondicoesEmString: string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: ISQLJuncao;
    function setTipoJuncao(const ATipoJuncao: TTipoJuncao = tjInnerJoin): ISQLJuncao;
    function setTabelaEstrangeira(const ATabela: ISQLTabela): ISQLJuncao;
    function addCondicao(const ACondicao: ISQLCondicao): ISQLJuncao;
    function ToString: string; override;
  end;

implementation

uses
  System.SysUtils,
  System.TypInfo,
  SQL.Mensagens;

{ TSQL3Juncao }

function TSQL3Juncao.addCondicao(const ACondicao: ISQLCondicao): ISQLJuncao;
begin
  FCondicoes.Add(ACondicao);
  result := self;
end;

constructor TSQL3Juncao.Create;
begin
  inherited;
  FTipoJuncao := TTipoJuncao.tjInnerJoin;
  FTabelaEstrangeira := nil;
  FCondicoes := TList<ISQLCondicao>.Create;
end;

destructor TSQL3Juncao.Destroy;
begin
  FCondicoes.Clear;
  FreeAndNil(FCondicoes);
  inherited;
end;

class function TSQL3Juncao.New: ISQLJuncao;
begin
  result := Create;
end;

function TSQL3Juncao.PegarCondicoesEmString: string;
var
  _condicoes: ISQLCondicao;
  _sql: TStringBuilder;
begin
  if FCondicoes.Count = 0 then
    raise ECondicaoException.CreateFmt(SQL.Mensagens.LISTA_VAZIA, ['Condições']);

  _sql := TStringBuilder.Create;
  try
    for _condicoes in FCondicoes do
    begin
      _sql
        .Append(_condicoes.getOperadorLogico.getSQLString)
        .Append(' ')
        .Append(_condicoes.ToString);
    end;
    _sql.Remove(0, FCondicoes[0].getOperadorLogico.getSQLString.Length + 1);

    result := _sql.ToString;
  finally
    _sql.Free;
  end;
end;

function TSQL3Juncao.setTabelaEstrangeira(const ATabela: ISQLTabela): ISQLJuncao;
begin
  FTabelaEstrangeira := ATabela;
  result := self;
end;

function TSQL3Juncao.setTipoJuncao(const ATipoJuncao: TTipoJuncao): ISQLJuncao;
begin
  FTipoJuncao := ATipoJuncao;
  result := self;
end;

function TSQL3Juncao.ToString: string;
begin
  result := Format('%s %s on %s',
    [FTipoJuncao.getSQLString, FTabelaEstrangeira.ToString, PegarCondicoesEmString]);
end;

end.
