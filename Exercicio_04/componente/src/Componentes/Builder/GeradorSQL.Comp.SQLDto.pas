unit GeradorSQL.Comp.SQLDto;

interface

uses GeradorSQL.Comp.Collection.Coluna,
  GeradorSQL.Comp.Collection.Condicao,
  GeradorSQL.Comp.Collection.Juncao,
  GeradorSQL.Comp.Collection.Tabela;

type
  TSQLDto = class
    Colunas: TColunaCollection;
    From: TTabela;
    Juncoes: TJuncaoCollection;
    Condicoes: TCondicaoCollection;
  end;

implementation


end.
