unit Teste.Builder.Coluna;

interface

uses
(*
  SQL.Enums,
  SQL.Constantes,
  SQL.Intf.Director,
  SQL.Intf.Builder,
  SQL.Intf.Tabela,
  SQL.Intf.Coluna,
  SQL.Impl.Builder,
  SQL.Impl.Director,
 *)
  SQL.Impl.Coluna.Builder;
type

  TCBColunaSimples = class(TBuilderColuna)
  public
    procedure buildNome(); override;
    procedure buildNomeVirtual(); override;
  end;

  TCBColunaNomeVirtual = class(TBuilderColuna)
  public
    procedure buildNome(); override;
    procedure buildNomeVirtual(); override;
  end;

  TCBColunaTotalmenteVirtual = class(TBuilderColuna)
  public
    procedure buildNome(); override;
    procedure buildNomeVirtual(); override;
  end;

implementation

uses
  Teste.Constantes,
  SQL.Intf.Fabrica,
  SQL.Impl.Fabrica,
  SQL.Builder.Tabela;

{ TBuilderColunaSimples }

procedure TCBColunaSimples.buildNome;
begin
  FObjeto.setColuna(COLUNA_SEM_ALIAS);
end;

procedure TCBColunaSimples.buildNomeVirtual;
begin
  FObjeto.setNomeVirtual('');
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

{ TBuilderColunaTotalmenteVirtual }

procedure TCBColunaTotalmenteVirtual.buildNome;
begin
  FObjeto.setColuna('null')
end;

procedure TCBColunaTotalmenteVirtual.buildNomeVirtual;
begin
  FObjeto.setNomeVirtual(COLUNA_NOME_VIRTUAL);
end;

end.
