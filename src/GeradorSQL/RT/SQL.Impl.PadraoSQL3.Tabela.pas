unit SQL.Impl.PadraoSQL3.Tabela;

interface

uses
  SysUtils, SQL.Impl.SQL, SQL.Intf.Tabela;

type  
  TSQL3Tabela = class(TSQL, ISQLTabela)
  private
    FNomeTabela: string;
    FAlias: string;
  public
    constructor Create; override;
    class function New: ISQLTabela;
    function setNome(const ANomeTabela: string):ISQLTabela;
    function setAlias(const AAlias: string): ISQLTabela;
    function TestarAliasEstaPreenchido: boolean;
    function ToString: string; override;
    function getAlias: string;
    function getNome: string;
  end;

implementation

{ TSQL3Tabela }

class function TSQL3Tabela.New: ISQLTabela;
begin
  result := Create;
end;

constructor TSQL3Tabela.Create;
begin
  inherited;
  FNomeTabela := '';
  FAlias := '';
end;

function TSQL3Tabela.getAlias: string;
begin
  result := FAlias;
end;

function TSQL3Tabela.getNome: string;
begin
  result := FNomeTabela;
end;

function TSQL3Tabela.setAlias(const AAlias: string): ISQLTabela;
begin
  FAlias := AAlias;
  Result := Self;
end;

function TSQL3Tabela.setNome(const ANomeTabela: string): ISQLTabela;
begin
  FNomeTabela := ANomeTabela;
  Result := Self;
end;

function TSQL3Tabela.TestarAliasEstaPreenchido: boolean;
begin
  result := not(Trim(FAlias) = EmptyStr);
end;

function TSQL3Tabela.ToString: string;
begin
  if TestarAliasEstaPreenchido then
    result := Format('%s %s',[FNomeTabela, FAlias])
  else
    result := FNomeTabela;
end;

end.
