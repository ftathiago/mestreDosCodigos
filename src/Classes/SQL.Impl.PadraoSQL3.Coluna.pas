unit SQL.Impl.PadraoSQL3.Coluna;

interface

uses
  SysUtils, SQL.Intf.Tabela, SQL.Intf.Coluna, SQL.Impl.SQL ;

type
  TSQL3Coluna = class(TSQL, ISQLColuna)
  private
    FTabela: ISQLTabela;
    FColuna: string;
    FNomeAlias: string;
  protected
    function TestarNomeAliasEstaPreenchido: boolean;
  public
    constructor Create;
    class function New: ISQLColuna;
    function setTabela(const ATabela: ISQLTabela): ISQLColuna;
    function setColuna(const AColuna: string): ISQLColuna;
    function setNomeAlias(const ANomeAlias: string): ISQLColuna;
    function ToString: string; override;
  end;

implementation

{ TSQL3Coluna }

constructor TSQL3Coluna.Create;
begin
  FColuna := '';
  FNomeAlias := '';
  FTabela := nil;
end;

class function TSQL3Coluna.New: ISQLColuna;
begin
  result := Create;
end;

function TSQL3Coluna.setColuna(const AColuna: string): ISQLColuna;
begin
  FColuna := AColuna;
  result := Self;
end;

function TSQL3Coluna.setNomeAlias(const ANomeAlias: string): ISQLColuna;
begin
  FNomeAlias := ANomeAlias;
  result := Self;  
end;

function TSQL3Coluna.setTabela(const ATabela: ISQLTabela): ISQLColuna;
begin
  FTabela := ATabela;
  result := Self;  
end;

function TSQL3Coluna.TestarNomeAliasEstaPreenchido: boolean;
begin
  result := not (Trim(FNomeAlias) = EmptyStr);
end;

function TSQL3Coluna.ToString: string;
var
  sAlias: string;
  sAliasCampo: string;
begin
  if FTabela.TestarAliasEstaPreenchido then
    sAlias := Format('%s.',[FTabela.getAlias])
  else
    sAlias := Format('%s.',[FTabela.getNome]);

  if TestarNomeAliasEstaPreenchido then
    sAliasCampo := Format(' as %s',[FNomeAlias]);

  result := Format('%s%s%s',[sAlias, FColuna, sAliasCampo]);
end;

end.
