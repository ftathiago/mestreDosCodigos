unit SQL.Intf.Coluna.Builder;

interface

uses
  SQL.Intf.Builder,
  SQL.Intf.Coluna,
  SQL.Intf.Tabela;

type
  IBuilderColuna = interface(ISQLBuilder<ISQLColuna>)
    ['{0F95620B-5C5D-401F-A86D-CE036E1A9B2F}']
    procedure buildNome();
    procedure buildNomeVirtual();
    procedure buildTabela();
    procedure AdicionarTabela(const ATabela: ISQLTabela);
  end;

implementation

end.
