unit SQL.Impl.Tabela.Builder;

interface

uses
  DesignPattern.Builder.Intf.Builder,
  DesignPattern.Builder.Impl.Builder,
  SQL.Intf.Tabela.Builder,
  SQL.Intf.Tabela;

type
  TBuilderTabela = class(TBuilder<ISQLTabela>, IBuilderTabela)
  public
    class function New: IBuilderTabela;
    procedure ConstruirNovaInstancia; override;
    procedure buildNomeTabela(); virtual; abstract;
    procedure buildAliasTabela(); virtual; abstract;
  end;


implementation

uses
  SQL.Constantes,
  SQL.Intf.Fabrica,
  SQL.Impl.Fabrica;

{ TBuilderTabela }

procedure TBuilderTabela.ConstruirNovaInstancia;
var
  _fabrica: IFabrica;
begin
  _fabrica := TFabrica.New(SQL_TIPO_PADRAO);

  FObjeto := _fabrica.Tabela;
end;

class function TBuilderTabela.New: IBuilderTabela;
begin
  result := Create;
end;

end.
