unit Teste.Builder.Coluna;

interface

uses
  SQL.Impl.Coluna.Builder;

type
  TCBColunaBase = class(TBuilderColuna)
  public
    procedure AfterConstruction; override;
  end;

  TCBColunaSimples = class(TCBColunaBase)
  public
    procedure buildNome; override;
    procedure buildNomeVirtual; override;
    procedure buildTabela; override;
    procedure AfterConstruction; override;
  end;

  TCBColunaNomeVirtual = class(TCBColunaBase)
  public
    procedure buildNome(); override;
    procedure buildNomeVirtual(); override;
    procedure buildTabela; override;
  end;

  TCBColunaTotalmenteVirtual = class(TCBColunaBase)
  public
    procedure buildNome(); override;
    procedure buildNomeVirtual(); override;
    procedure buildTabela; override;
  end;

implementation

uses
  Teste.Constantes;

{ TBuilderColunaSimples }

procedure TCBColunaSimples.AfterConstruction;
begin
  inherited;

end;

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

{ TCBColunaBase }

procedure TCBColunaBase.AfterConstruction;
begin
  inherited;
  setOtimizarPara(OTIMIZAR_PARA);
end;

end.
