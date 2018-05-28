unit umcConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Data.DB,
  umcDBForm, umcFrmConsulta,
  DataSet.Intf.ConfiguradorMetaData, GeradorSQL.Comp.Select;

type
  TfrmConsultaClass = class of TfmcConsulta;

  TfmcConsulta = class(TfmcDBForm)
    fmcFrmConsulta: TfmcFrmConsulta;
    selPesquisa: TMCSelect;
    procedure fmcFrmConsultaSelecionarClick(const DataSet: TDataSet);
  private
    procedure SelecionarRegistro;
  public
    constructor Create(AOwner: TComponent; const AConnection: TCustomConnection;
      const AConfiguradorMetaData: IConfiguradorMetaData); reintroduce;
  end;

var
  fmcConsulta: TfmcConsulta;

implementation

{$R *.dfm}

constructor TfmcConsulta.Create(AOwner: TComponent; const AConnection: TCustomConnection;
  const AConfiguradorMetaData: IConfiguradorMetaData);
begin

  Self.FormStyle := fsNormal;

end;

procedure TfmcConsulta.fmcFrmConsultaSelecionarClick(const DataSet: TDataSet);
begin
  SelecionarRegistro;
end;

procedure TfmcConsulta.SelecionarRegistro;
var
  _modalResult: TModalResult;
begin
  _modalResult := mrOk;
  if dsDataSet.DataSet.IsEmpty then
    _modalResult := mrNone;

  ModalResult := _modalResult;
end;

end.
