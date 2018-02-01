unit SQL.Impl.PadraoSQL3.SQLCondicao;

interface

uses
  System.Rtti, SQL.Impl.SQL, SQL.Intf.SQL, SQL.Intf.SQLCondicao,
  SQL.Intf.SQLColuna;

type
  TSQL3Condicao = class(TSQL, ISQLCondicao)
  private
    FOperadorLogico: TOperadorLogico;
    FOperadorComparacao: TOperadorComparacao;
    FColuna: string;
    FTextoDaCondicao: string;
    FValor: string;
  public
    constructor Create;
    class function New: ISQLCondicao;
    function getOperadorLogico: TOperadorLogico;
    function setColuna(const AColuna: ISQLColuna): ISQLCondicao;
    function setOperadorComparacao(const AOperadorComparacao
      : TOperadorComparacao): ISQLCondicao;
    function setOperadorLogico(const AOperadorLogico: TOperadorLogico)
      : ISQLCondicao;
    function setTexto(const ATextoDaCondicao: string): ISQLCondicao;
    function setValor(const AColuna: ISQL): ISQLCondicao; overload;
    function setValor(const AValor: TValue): ISQLCondicao; overload;
    function ToString: string; override;
  end;

implementation

uses
  System.TypInfo, System.SysUtils;

{ TSQL3Condicao }

constructor TSQL3Condicao.Create;
begin
  FOperadorLogico := olUnknow;
  FOperadorComparacao := ocUnknow;
  FColuna := EmptyStr;
  FTextoDaCondicao := EmptyStr;
  FValor := EmptyStr;
end;

function TSQL3Condicao.getOperadorLogico: TOperadorLogico;
begin
  result := FOperadorLogico;
end;

class function TSQL3Condicao.New: ISQLCondicao;
begin
  result := Create;
end;

function TSQL3Condicao.setColuna(const AColuna: ISQLColuna): ISQLCondicao;
begin
  FColuna := AColuna.ToString;
  result := self;
end;

function TSQL3Condicao.setOperadorComparacao(const AOperadorComparacao
  : TOperadorComparacao): ISQLCondicao;
begin
  FOperadorComparacao := AOperadorComparacao;
  result := self;
end;

function TSQL3Condicao.setOperadorLogico(const AOperadorLogico: TOperadorLogico)
  : ISQLCondicao;
begin
  FOperadorLogico := AOperadorLogico;
  result := self;
end;

function TSQL3Condicao.setTexto(const ATextoDaCondicao: string): ISQLCondicao;
begin
  FTextoDaCondicao := ATextoDaCondicao;
  result := self;
end;

function TSQL3Condicao.setValor(const AValor: TValue): ISQLCondicao;
begin
  FValor := AValor.ToString;
  result := self;
end;

function TSQL3Condicao.ToString: string;
var
  _comparadoCom: string;
begin
  _comparadoCom := FOperadorComparacao.getSQLString;
  result := Format('(%s %s %s)', [FColuna, _comparadoCom, FValor]);
end;

function TSQL3Condicao.setValor(const AColuna: ISQL): ISQLCondicao;
begin
  FValor := AColuna.ToString;
  result := self;
end;

end.
