unit SQL.Impl.Fabrica;

interface

uses
  SQL.Enums,
  SQL.Intf.Tabela,
  SQL.Intf.Coluna,
  SQL.Intf.Condicao,
  SQL.Intf.Juncao,
  SQL.Intf.Select,
  SQL.Intf.Fabrica;

type
  TFabrica = class(TInterfacedObject, IFabrica)
  private
    FBancoDeDados: TOtimizarPara;
    FFabrica: IFabrica;
    procedure InicializarFabrica;
  public
    constructor Create(const ABancoDeDados: TOtimizarPara);
    class function New(const ABancoDeDados: TOtimizarPara): IFabrica;
    function Tabela: ISQLTabela;
    function Coluna: ISQLColuna;
    function Condicao: ISQLCondicao;
    function Juncao: ISQLJuncao;
    function Select: ISQLSelect;
    procedure AfterConstruction; override;
  end;

implementation

{ TFabrica }

uses
  System.TypInfo,
  SQL.Impl.PadraoSQL3.Fabrica,
  SQL.Exceptions,
  SQL.Mensagens;

function TFabrica.Tabela: ISQLTabela;
begin
  result := FFabrica.Tabela;
end;

procedure TFabrica.AfterConstruction;
begin
  inherited;
  InicializarFabrica;
end;

function TFabrica.Coluna: ISQLColuna;
begin
  result := FFabrica.Coluna;
end;

function TFabrica.Condicao: ISQLCondicao;
begin
  result := FFabrica.Condicao;
end;

constructor TFabrica.Create(const ABancoDeDados: TOtimizarPara);
begin
  FBancoDeDados := ABancoDeDados;
  FFabrica := nil;
end;

procedure TFabrica.InicializarFabrica;
begin
  case FBancoDeDados of
    opPadraoSQL3:
      FFabrica := TSQL3Fabrica.Create;
  else
    begin
      raise EFabricaNaoImplementada.CreateFmt(FABRICA_NAO_IMPLEMENTADA, [FBancoDeDados.getNome]);
    end;
  end;
end;

function TFabrica.Juncao: ISQLJuncao;
begin
  result := FFabrica.Juncao;
end;

class function TFabrica.New(const ABancoDeDados: TOtimizarPara): IFabrica;
begin
  result := Create(ABancoDeDados);
end;

function TFabrica.Select: ISQLSelect;
begin
  result := FFabrica.Select;
end;

end.
