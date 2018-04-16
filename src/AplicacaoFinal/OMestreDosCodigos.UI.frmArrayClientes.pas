unit OMestreDosCodigos.UI.frmArrayClientes;

interface

uses
  OMestreDosCodigos.Intf.Cliente.ListaArrayDinamico,
  OMestreDosCodigos.Intf.Cliente,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  umcForm,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.ComCtrls,
  System.Actions,
  Vcl.ActnList,
  System.ImageList,
  Vcl.ImgList;

type
  TfrmArrayClientes = class(TfmcForm)
    Panel1: TPanel;
    lstClientes: TListBox;
    Label1: TLabel;
    NOME: TEdit;
    TELEFONE: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EMAIL: TEdit;
    LOGRADOURO: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    NUMERO: TEdit;
    COMPLEMENTO: TEdit;
    Label6: TLabel;
    CEP: TEdit;
    Label7: TLabel;
    BAIRRO: TEdit;
    Label8: TLabel;
    DATANASCIMENTO: TDateTimePicker;
    Label9: TLabel;
    Label10: TLabel;
    lblTamanhoArray: TLabel;
    Label11: TLabel;
    lblIndiceSelecionado: TLabel;
    ActionList1: TActionList;
    ImageList1: TImageList;
    actIncluir: TAction;
    actAlterar: TAction;
    actExcluir: TAction;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    GroupBox1: TGroupBox;
    CIDADE: TEdit;
    Label12: TLabel;
    UF: TComboBox;
    Label13: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lstClientesClick(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actAlterarExecute(Sender: TObject);
  private
    { Private declarations }
    FIndiceClienteAtivo: integer;
    FListaClientes: IListaArrayDinamico<ICliente>;
    procedure CarregarLista;
    procedure AlterarSelecionado(const Indice: integer);
    procedure CarregarDadosDoClienteNaInterface(const ACliente: ICliente);

    procedure AdicionarCliente;
    function CriarClienteDaInterface: ICliente;
    procedure RemoverCliente;
    procedure SalvarCliente;
    procedure DepoisAlterarArray(const TipoAlteracao: TTipoAlteracao);
    procedure DepoisAlterarSelecao;
    procedure LimparDadosInterface;

    function Validar(const ACliente: ICliente): boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


uses
  pkgUtils.Intf.ListaRetornoValidacao,
  pkgUtils.Impl.ListaRetornoValidacao,
  OMestreDosCodigos.Impl.Cliente.ListaArrayDinamico,
  OMestreDosCodigos.Intf.Cliente.Builder,
  OMestreDosCodigos.Impl.Cliente.Builder;

{ TfmcForm1 }

procedure TfrmArrayClientes.CarregarLista;
var
  i: integer;
begin
  lstClientes.Clear;

  for i := 0 to Pred(FListaClientes.Tamanho) do
    lstClientes.Items.Add(FListaClientes.Retornar(i).NOME);

  AlterarSelecionado(FIndiceClienteAtivo);
end;

procedure TfrmArrayClientes.AlterarSelecionado(const Indice: integer);
var
  _cliente: ICliente;
begin
  FIndiceClienteAtivo := Indice;
  DepoisAlterarSelecao;

  if FIndiceClienteAtivo > Pred(FListaClientes.Tamanho) then
  begin
    Dec(FIndiceClienteAtivo);
    AlterarSelecionado(FIndiceClienteAtivo);
    exit;
  end;

  if FIndiceClienteAtivo < 0 then
    exit;

  _cliente := FListaClientes.Retornar(Indice);
  CarregarDadosDoClienteNaInterface(_cliente);
end;

procedure TfrmArrayClientes.CarregarDadosDoClienteNaInterface(const ACliente: ICliente);
begin
  NOME.Text := ACliente.NOME;
  DATANASCIMENTO.DateTime := ACliente.DATANASCIMENTO;
  TELEFONE.Text := ACliente.TELEFONE.AsString;
  EMAIL.Text := ACliente.EMAIL.AsString;
  LOGRADOURO.Text := ACliente.Endereco.LOGRADOURO;
  NUMERO.Text := ACliente.Endereco.NUMERO;
  COMPLEMENTO.Text := ACliente.Endereco.COMPLEMENTO;
  BAIRRO.Text := ACliente.Endereco.BAIRRO;
  CEP.Text := ACliente.Endereco.CEP;
  CIDADE.Text := ACliente.Endereco.CIDADE;
  UF.Text := ACliente.Endereco.UF;
end;

procedure TfrmArrayClientes.actAlterarExecute(Sender: TObject);
begin
  inherited;
  SalvarCliente;
end;

procedure TfrmArrayClientes.actExcluirExecute(Sender: TObject);
begin
  inherited;
  RemoverCliente;
end;

procedure TfrmArrayClientes.actIncluirExecute(Sender: TObject);
begin
  inherited;
  AdicionarCliente;
end;

procedure TfrmArrayClientes.AdicionarCliente;
var
  _cliente: ICliente;
begin
  _cliente := CriarClienteDaInterface;
  if not Validar(_cliente) then
    exit;

  Inc(FIndiceClienteAtivo);
  FListaClientes.Adicionar(CriarClienteDaInterface);
  AlterarSelecionado(Pred(FListaClientes.Tamanho));
end;

function TfrmArrayClientes.CriarClienteDaInterface: ICliente;
var
  _clienteBuilder: IClienteBuilder;
begin
  _clienteBuilder := TClienteBuilder.New
    .NOME(NOME.Text)
    .LOGRADOURO(LOGRADOURO.Text)
    .NUMERO(NUMERO.Text)
    .BAIRRO(BAIRRO.Text)
    .CEP(CEP.Text)
    .COMPLEMENTO(COMPLEMENTO.Text)
    .UF(UF.Text)
    .CIDADE(CIDADE.Text)
    .DATANASCIMENTO(DATANASCIMENTO.DateTime)
    .EMAIL(EMAIL.Text)
    .TELEFONE(TELEFONE.Text);
  _clienteBuilder.ConstruirNovaInstancia;
  result := _clienteBuilder.getObjeto;
end;

procedure TfrmArrayClientes.RemoverCliente;
begin
  if FIndiceClienteAtivo >= 0 then
    FListaClientes.Remover(FIndiceClienteAtivo);
end;

procedure TfrmArrayClientes.SalvarCliente;
var
  _cliente: ICliente;
begin
  _cliente := CriarClienteDaInterface;
  if not Validar(_cliente) then
    exit;

  FListaClientes.Alterar(FIndiceClienteAtivo, _cliente);
end;

function TfrmArrayClientes.Validar(const ACliente: ICliente): boolean;
var
  _retornoValidacao: IListaRetornoValidacao;
begin
  result := True;
  _retornoValidacao := TListaRetornoValidacao.New([]);
  if ACliente.Validar(_retornoValidacao) then
    exit;
  ShowMessage(_retornoValidacao.ToString);
  result := False;
end;

procedure TfrmArrayClientes.DepoisAlterarArray(const TipoAlteracao: TTipoAlteracao);
begin
  LimparDadosInterface;
  CarregarLista;
  lblTamanhoArray.Caption := FListaClientes.Tamanho.ToString();
  actAlterar.Enabled := not FListaClientes.EstaVazio;
end;

procedure TfrmArrayClientes.DepoisAlterarSelecao;
begin
  lstClientes.ItemIndex := FIndiceClienteAtivo;
  lblIndiceSelecionado.Caption := FIndiceClienteAtivo.ToString();
end;

procedure TfrmArrayClientes.FormCreate(Sender: TObject);
begin
  inherited;
  FIndiceClienteAtivo := -1;
  FListaClientes := TListaArrayDinamico<ICliente>.New([]);
  FListaClientes.NoficarMudanca := DepoisAlterarArray;
end;

procedure TfrmArrayClientes.LimparDadosInterface;
var
  _clienteBuilder: IClienteBuilder;
begin
  _clienteBuilder := TClienteBuilder.New;
  _clienteBuilder.ConstruirNovaInstancia;
  CarregarDadosDoClienteNaInterface(_clienteBuilder.getObjeto);
end;

procedure TfrmArrayClientes.lstClientesClick(Sender: TObject);
begin
  inherited;
  AlterarSelecionado(lstClientes.ItemIndex);
end;

initialization

RegisterClass(TfrmArrayClientes);

end.
