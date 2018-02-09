unit GeradorSQL.Comp.Intf.Builder.Coluna;

interface

uses
  SQL.Int.Builder.Coluna,
  GeradorSQL.Comp.Collection.Coluna;

type
  IBuilderColunaCollection = interface(IBuilderColuna)
    ['{0F95620B-5C5D-401F-A86D-CE036E1A9B2F}']
    procedure SetColunaCollection(const AColunaCollection: TColunaCollection);
  end;

implementation

end.