unit ufwAplicacao;

interface

uses
  System.Classes,
  Vcl.Forms,
  Conexao.Intf.ConfiguracaoDeConexao,
  Conexao.Intf.Configuracao;

type
  TAplicacao = class
  private
  class var
    CAplicacao: TAplicacao;
    FConexaoConfiguracao: IConexaoConfiguracao;
    procedure CriarConexaoConfiguracao;
    function GetCarregadorINI: IConexaoCarregador;
    function PegarFormJaCriado(const FormClass: TFormClass; const Owner: TForm): TForm;
    constructor Create;
  public
    class function ObterInstancia: TAplicacao;
    class function NewInstance: TObject; override;
    function GetConfiguracaoConexao: IConexaoConfiguracao;
    procedure ConfigurarConexao(Configurador: IFDConfiguracaoDeConexao);
    procedure CriarFormulario(const NomeDoForm: string; const Owner: TForm; out obj);
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils,
  Conexao.Intf.Configuracao.Fabrica,
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

procedure TAplicacao.CriarFormulario(const NomeDoForm: string; const Owner: TForm; out obj);
var
  _frmClass: TFormClass;
  _form: TForm;
begin
  _frmClass := TFormClass(FindClass(NomeDoForm));

  _form := PegarFormJaCriado(_frmClass, Owner);

  if not Assigned(_form) then
    _form := _frmClass.Create(Owner);

    TForm(obj) := _form
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

function TAplicacao.PegarFormJaCriado(const FormClass: TFormClass; const Owner: TForm): TForm;
var
  i: Integer;
begin
  result := nil;
  for i := 0 to Pred(Owner.MDIChildCount) do
  begin
    if Owner.MDIChildren[i].ClassNameIs(FormClass.ClassName) then
    begin
      result := Owner.MDIChildren[i];
      break;
    end;
  end;
end;

initialization

finalization

FreeAndNil(TAplicacao.CAplicacao);

end.
