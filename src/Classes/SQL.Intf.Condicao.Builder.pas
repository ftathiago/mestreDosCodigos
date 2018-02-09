unit SQL.Intf.Condicao.Builder;

interface

uses
  DesignPattern.Builder.Intf.Builder,
  SQL.Enums,
  SQL.Intf.Coluna,
  SQL.Intf.Condicao;

type
  IBuilderCondicao = interface(IBuilder<ISQLCondicao>)
    ['{FB34CE34-00D8-4B1A-8E99-3D2AF86A2A7D}']
    procedure setColuna(const Coluna: ISQLColuna);
    procedure setOperadorComparacao(const OperadorComparacao: TOperadorComparacao);
    procedure setOperadorLogico(const OperadorLogico: TOperadorLogico);
    procedure setValor(const Valor: string);
    procedure buildCondicao;
  end;

implementation

end.
