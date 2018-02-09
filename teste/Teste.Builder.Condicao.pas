unit Teste.Builder.Condicao;

interface

uses
  System.Rtti,
  DesignPattern.Builder.Intf.Builder,
  DesignPattern.Builder.Intf.Director,
  SQL.Intf.Coluna.Builder,
  SQL.Intf.Coluna,
  SQL.Intf.Condicao,
  SQL.Impl.Builder,
  SQL.Impl.Director,
  SQL.Impl.Coluna.Director,
  SQL.Impl.Condicao.Builder;

type
  TBuilderCondicaoValor = class(TBuilderCondicao)
  public
    procedure buildCondicao(); override;
  end;

implementation

uses
  Teste.Constantes,
  SQL.Enums,
  SQL.Constantes,
  SQL.Intf.Fabrica,
  SQL.Impl.Fabrica,
  SQL.Builder.Tabela,
  Teste.Builder.Coluna;

{ TBuilderCondicaoValor }

procedure TBuilderCondicaoValor.buildCondicao;
begin
  FObjeto.setValor('VALOR')
end;

end.
