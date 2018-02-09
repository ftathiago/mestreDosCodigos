unit SQL.Intf.Juncao.Builder;

interface

uses
  DesignPattern.Builder.Intf.Builder,
  SQL.Intf.Juncao;

type
  IBuilderJuncao = interface(IBuilder<ISQLJuncao>)
    ['{D1CDB699-1DD2-4F44-BEE4-6587AE3E2735}']
    procedure AdicionarTabela;
    procedure AdicionarCondicao;
  end;


implementation

end.
