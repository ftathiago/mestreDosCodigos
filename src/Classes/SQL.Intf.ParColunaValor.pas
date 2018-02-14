unit SQL.Intf.ParColunaValor;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  SQL.Intf.SQL,
  SQL.Intf.Coluna,
  SQL.Intf.Tabela,
  SQL.Intf.Condicao,
  SQL.Intf.Juncao;

type
  ISQLParColunaValor = interface(ISQL)
    ['{5DF9430A-2A50-4D3D-B4C8-EEC4D799CC7E}']
    function setColuna(const AColuna: ISQLColuna): ISQLParColunaValor;
    function setValor(const SQL: ISQL): ISQLParColunaValor; overload;
    function setValor(const Texto: string): ISQLParColunaValor; overload;
    function getColuna: ISQLColuna;
    function getValor: string;
  end;

implementation

end.

