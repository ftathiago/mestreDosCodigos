unit SQL.Intf.Select.Builder;

interface

uses
  SQL.Intf.Builder,
  SQL.Intf.Select;

type
  IBuilderSelect = interface(ISQLBuilder<ISQLSelect>)
    ['{ED9BF74D-D4F1-4118-8E42-48E775E85161}']
    procedure buildLimite;
    procedure buildSalto;
    procedure buildCampo;
    procedure buildFrom;
    procedure buildJuncao;
    procedure buildWhere;
    procedure buildOrderBy;
    procedure buildGroupBy;
  end;


implementation

end.
