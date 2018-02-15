unit SQL.Impl.Coluna.Builder;

interface

uses
  SQL.Builder,
  SQL.Intf.Coluna,
  SQL.Intf.Coluna.Builder,
  SQL.Intf.Tabela;

type
  TBuilderColuna = class(TSQLBuilder<ISQLColuna>, IBuilderColuna)
  private
    FTabela: ISQLTabela;
  protected
    function getTabela: ISQLTabela;
  public
    class function New: IBuilderColuna;
    procedure ConstruirNovaInstancia; override;
    procedure AdicionarTabela(const ATabela: ISQLTabela);
    procedure buildNome(); virtual; abstract;
    procedure buildNomeVirtual(); virtual; abstract;
    procedure buildTabela(); virtual; abstract;
  end;


implementation

uses
  SQL.Impl.Fabrica,
  SQL.Constantes;

{ TBuilderColuna }

procedure TBuilderColuna.AdicionarTabela(const ATabela: ISQLTabela);
begin
  FTabela := ATabela;
end;

procedure TBuilderColuna.ConstruirNovaInstancia;
begin
  FObjeto := TFabrica.New(getOtimizarPara).Coluna;
end;

function TBuilderColuna.getTabela: ISQLTabela;
begin
  result := FTabela
end;

class function TBuilderColuna.New: IBuilderColuna;
begin
  result := Create;
end;


end.
