unit SQL.Intf.Insert;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  SQL.Intf.SQL,
  SQL.Intf.ParColunaValor,
  SQL.Intf.Tabela,
  SQL.Intf.Select;

type
  ISQLInsert = interface(ISQL)
    ['{5DF9430A-2A50-4D3D-B4C8-EEC4D799CC7E}']
    function addParColunaValor(const ParColunaValor: ISQLParColunaValor): ISQLInsert;
    function setTabela(const ATabela: ISQLTabela): ISQLInsert;
    function setSelectInsert(const Select: ISQLSelect): ISQLInsert;
  end;

implementation

end.
