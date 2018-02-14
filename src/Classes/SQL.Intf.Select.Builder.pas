unit SQL.Intf.Select.Builder;

interface

uses
  DesignPattern.Builder.Intf.Builder,
  SQL.Intf.Select;

type
  IBuilderSelect = interface(IBuilder<ISQLSelect>)
    ['{ED9BF74D-D4F1-4118-8E42-48E775E85161}']
    procedure buildCampo;
    procedure buildFrom;
    procedure buildJuncao;
    procedure buildWhere;
    procedure buildOrderBy;
  end;


implementation

end.
