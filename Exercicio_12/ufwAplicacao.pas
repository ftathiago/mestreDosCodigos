unit ufwAplicacao;

interface

uses
  System.Classes,
  Vcl.Forms,
  Conexao.Intf.FDConfiguracaoDeConexao,
  Conexao.Intf.Configuracao;

type
  TAplicacao = class
  private
  class var
    CAplicacao: TAplicacao;
    FConexaoConfiguracao: IConexaoConfiguracao;
    procedure CriarConexaoConfiguracao;
    function GetCarregadorINI: IConexaoCarregador;
    constructor Create;
  public
    class function ObterInstancia: TAplicacao;
    class function NewInstance: TObject; override;
    function GetConfiguracaoConexao: IConexaoConfiguracao;
    procedure ConfigurarConexao(Configurador: IFDConfiguracaoDeConexao);
    procedure CriarFormulario(const NomeDoForm: string; const Owner: TComponent; out obj);
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils,
  Conexao.Impl.Configuracao,
  Conexao.Impl.Configuracao.Fabrica;

{ TAplicacao }

procedure TAplicacao.ConfigurarConexao(Configurador: IFDConfiguracaoDeConexao);
begin
  Configurador
    .SetConexaoConfiguracao(GetConfiguracaoConexao)
    .Configurar;
end;

constructor TAplicacao.Create;
begin
  CriarConexaoConfiguracao
end;

procedure TAplicacao.CriarConexaoConfiguracao;
begin
  FConexaoConfiguracao := TumcConexaoConfiguracao.New;
  GetCarregadorINI.CarregarConfiguracoes(FConexaoConfiguracao);
end;

procedure TAplicacao.CriarFormulario(const NomeDoForm: string; const Owner: TComponent; out obj);
var
  _frmClass: TFormClass;
begin
  _frmClass := TFormClass(FindClass(NomeDoForm));
  TForm(obj) := _frmClass.Create(Owner);
end;

destructor TAplicacao.Destroy;
begin
  GetCarregadorINI.SalvarConfiguracoes(FConexaoConfiguracao);
  inherited;
end;

function TAplicacao.GetCarregadorINI: IConexaoCarregador;
begin
  result := TFabricaCarregador.New(toIni).getCarregador;
  result.SetNomeOrigem(ChangeFileExt(Application.ExeName, '.ini'));
end;

function TAplicacao.GetConfiguracaoConexao: IConexaoConfiguracao;
begin
  result := FConexaoConfiguracao;
end;

class function TAplicacao.NewInstance: TObject;
begin
  if not Assigned(CAplicacao) then
    CAplicacao := TAplicacao(inherited NewInstance);

  result := CAplicacao;
end;

class function TAplicacao.ObterInstancia: TAplicacao;
begin
  result := TAplicacao.Create;
end;

initialization

finalization

FreeAndNil(TAplicacao.CAplicacao);

end.
