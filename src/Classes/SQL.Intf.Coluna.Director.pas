unit SQL.Intf.Coluna.Director;

interface

uses
  DesignPattern.Builder.Intf.Director,
  SQL.Intf.Tabela,
  SQL.Intf.Coluna,
  SQL.Intf.Coluna.Builder;

type
  IDirectorColuna = interface(IDirector<IBuilderColuna, ISQLColuna>)
    ['{13F31459-2977-418D-B1D4-D4BF06FFFED3}']
  end;

implementation

end.
