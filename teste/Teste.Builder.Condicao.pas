unit Teste.Builder.Condicao;

interface

uses
  System.Rtti,
  SQL.Impl.Condicao.Builder;

type
  TCBCondicaoValor = class(TBuilderCondicao)
  public
    procedure buildColuna; override;
    procedure buildOperadorComparacao; override;
    procedure buildValor; override;
    procedure buildOperadorLogico; override;
  end;

implementation

uses
  DesignPattern.Builder.Intf.Director,
  SQL.Enums,
  SQL.Intf.Coluna,
  SQL.Intf.Coluna.Builder,
  SQL.Impl.Coluna.Director,
  Teste.Constantes,
  Teste.Builder.Coluna;
{ TBuilderCondicaoValor }

procedure TCBCondicaoValor.buildColuna;
var
  _director: IDirector<IBuilderColuna, ISQLColuna>;
  _builder: IBuilderColuna;
begin
  inherited;
  _builder := TCBColunaSimples.New;
  _director := TDirectorColuna.New;
  _director.setBuilder(_builder);
  _director.Construir;

  FObjeto.setColuna(_director.getObjetoPronto);
end;

procedure TCBCondicaoValor.buildOperadorComparacao;
begin
  inherited;
  FObjeto.setOperadorComparacao(ocIgual);
end;

procedure TCBCondicaoValor.buildOperadorLogico;
begin
  inherited;
  FObjeto.setOperadorLogico(olAnd)
end;

procedure TCBCondicaoValor.buildValor;
begin
  inherited;
  FObjeto.setValor('VALOR')
end;

end.
