unit SQL.Impl.Juncao.Builder;

interface

uses
  DesignPattern.Builder.Impl.Builder,
  SQL.Intf.Juncao,
  SQL.Intf.Juncao.Builder;

type
  TBuilderJuncao = class(TBuilder<ISQLJuncao>, IBuilderJuncao)
  public
    class function New: IBuilderJuncao;
    procedure ConstruirNovaInstancia; override;
    procedure AdicionarTabela; virtual; abstract;
    procedure AdicionarCondicao; virtual; abstract;
  end;


implementation

uses
  SQL.Constantes,
  SQL.Impl.Fabrica;

{ TBuilderJuncao }

procedure TBuilderJuncao.ConstruirNovaInstancia;
begin
  inherited;
  FObjeto := TFabrica.New(SQL_TIPO_PADRAO).Juncao;
end;

class function TBuilderJuncao.New: IBuilderJuncao;
begin
  result := Create;
end;

end.
