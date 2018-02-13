unit SQL.Impl.Condicao.Builder;

interface

uses
  DesignPattern.Builder.Impl.Builder,
  SQL.Enums,
  SQL.Intf.Coluna,
  SQL.Intf.Condicao,
  SQL.Intf.Condicao.Builder;

type
  TBuilderCondicao = class(TBuilder<ISQLCondicao>, IBuilderCondicao)
  private
    FColuna: ISQLColuna;
    FOperadorLogico: TOperadorLogico;
    FOperadorComparacao: TOperadorComparacao;
    FValor: string;
  protected
    procedure setColuna(const Coluna: ISQLColuna);
    procedure setOperadorComparacao(const OperadorComparacao: TOperadorComparacao);
    procedure setOperadorLogico(const OperadorLogico: TOperadorLogico);
    procedure setValor(const Valor: string);
  public
    class function New: IBuilderCondicao;
    procedure ConstruirNovaInstancia; override;
    procedure buildColuna; virtual; abstract;
    procedure buildOperadorComparacao; virtual; abstract;
    procedure buildOperadorLogico; virtual; abstract;
    procedure buildValor; virtual; abstract;
  end;

implementation

uses
  SQL.Constantes,
  SQL.Impl.Fabrica;

{ TBuilderCondicao }

procedure TBuilderCondicao.ConstruirNovaInstancia;
begin
  inherited;
  FObjeto := TFabrica.New(SQL_TIPO_PADRAO).Condicao;
end;

class function TBuilderCondicao.New: IBuilderCondicao;
begin
  result := Create;
end;

procedure TBuilderCondicao.setColuna(const Coluna: ISQLColuna);
begin
  FColuna := Coluna;
end;

procedure TBuilderCondicao.setOperadorComparacao(const OperadorComparacao: TOperadorComparacao);
begin
  FOperadorComparacao := OperadorComparacao;
end;

procedure TBuilderCondicao.setOperadorLogico(const OperadorLogico: TOperadorLogico);
begin
  FOperadorLogico := OperadorLogico;
end;

procedure TBuilderCondicao.setValor(const Valor: string);
begin
  FValor := Valor;
end;

end.
