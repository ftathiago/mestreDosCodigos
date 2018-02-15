unit SQL.Intf.Tabela.Builder;

interface

uses
  SQL.Intf.Builder,
  SQL.Intf.Tabela;


type
  IBuilderTabela = interface(ISQLBuilder<ISQLTabela>)
    ['{ED9BF74D-D4F1-4118-8E42-48E775E85161}']
    procedure buildNomeTabela();
    procedure buildAliasTabela();
  end;

implementation

end.
