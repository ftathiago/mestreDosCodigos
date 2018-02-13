unit Teste.Builder.Coluna;

interface

uses
  SQL.Impl.Coluna.Builder;

type
  TCBColunaSimples = class(TBuilderColuna)
  public
    procedure buildNome; override;
    procedure buildNomeVirtual; override;
    procedure buildTabela; override;
  end;

  TCBColunaNomeVirtual = class(TBuilderColuna)
  public
    procedure buildNome(); override;
    procedure buildNomeVirtual(); override;
    procedure buildTabela; override;
  end;

  TCBColunaTotalmenteVirtual = class(TBuilderColuna)
  public
    procedure buildNome(); override;
    procedure buildNomeVirtual(); override;
    procedure buildTabela; override;
  end;

implementation

uses
  Teste.Constantes;

{ TBuilderColunaSimples }

procedure TCBColunaSimples.buildNome;
begin
  FObjeto.setColuna(COLUNA_SEM_ALIAS);
end;

procedure TCBColunaSimples.buildNomeVirtual;
begin
  FObjeto.setNomeVirtual('');
end;

procedure TCBColunaSimples.buildTabela;
begin
  inherited;

end;

{ TBuilderColunaNomeVirtual }

procedure TCBColunaNomeVirtual.buildNome;
begin
  FObjeto.setColuna(COLUNA_COM_ALIAS);
end;

procedure TCBColunaNomeVirtual.buildNomeVirtual;
begin
  FObjeto.setNomeVirtual(COLUNA_NOME_VIRTUAL);
end;

procedure TCBColunaNomeVirtual.buildTabela;
begin
  inherited;

end;

{ TBuilderColunaTotalmenteVirtual }

procedure TCBColunaTotalmenteVirtual.buildNome;
begin
  FObjeto.setColuna('null')
end;

procedure TCBColunaTotalmenteVirtual.buildNomeVirtual;
begin
  FObjeto.setNomeVirtual(COLUNA_NOME_VIRTUAL);
end;

procedure TCBColunaTotalmenteVirtual.buildTabela;
begin
  inherited;

end;

end.
