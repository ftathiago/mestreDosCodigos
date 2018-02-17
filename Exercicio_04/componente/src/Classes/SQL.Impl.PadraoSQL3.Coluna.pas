unit SQL.Impl.PadraoSQL3.Coluna;

interface

uses
  SysUtils,
  SQL.Intf.Tabela,
  SQL.Intf.Coluna,
  SQL.Impl.SQL;

type
  TSQL3Coluna = class(TSQL, ISQLColuna)
  private
    FTabela: ISQLTabela;
    FColuna: string;
    FNomeVirtual: string;
  protected
    function TestarNomeVirtualFoiInformado: boolean;
    function getOrigemDoCampo: string;
    procedure ConstruirSQL; override;
  public
    constructor Create; override;
    class function New: ISQLColuna; reintroduce;
    function setTabela(const ATabela: ISQLTabela): ISQLColuna;
    function setColuna(const AColuna: string): ISQLColuna;
    function setNomeVirtual(const ANomeVirtual: string): ISQLColuna;
  end;

implementation

{ TSQL3Coluna }

procedure TSQL3Coluna.ConstruirSQL;
var
  sTabelaDoCampo: string;
  sNomeVirtual: string;
begin
  inherited;

  sTabelaDoCampo := getOrigemDoCampo;

  if TestarNomeVirtualFoiInformado then
    sNomeVirtual := Format(' as %s', [FNomeVirtual]);

  FTexto := Format('%s%s%s', [sTabelaDoCampo, FColuna, sNomeVirtual]);
end;

constructor TSQL3Coluna.Create;
begin
  inherited;
  FColuna := '';
  FNomeVirtual := '';
  FTabela := nil;
end;

function TSQL3Coluna.getOrigemDoCampo: string;
begin
  result := '';

  if not Assigned(FTabela) then
    exit;

  if FTabela.getNome.Trim.IsEmpty then
    exit;

  if FTabela.TestarAliasEstaPreenchido then
    result := Format('%s.', [FTabela.getAlias])
  else
    result := Format('%s.', [FTabela.getNome]);
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

function TSQL3Coluna.setNomeVirtual(const ANomeVirtual: string): ISQLColuna;
begin
  FNomeVirtual := ANomeVirtual;
  result := Self;
end;

function TSQL3Coluna.setTabela(const ATabela: ISQLTabela): ISQLColuna;
begin
  FTabela := ATabela;
  result := Self;
end;

function TSQL3Coluna.TestarNomeVirtualFoiInformado: boolean;
begin
  result := not(Trim(FNomeVirtual) = EmptyStr);
end;

end.
