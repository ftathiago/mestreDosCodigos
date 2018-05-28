unit umcDBForm;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  DataSet.Intf.ConfiguradorMetaData,
  umcForm, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfmcDBFormClass = class of TfmcDBForm;

  TfmcDBForm = class(TfmcForm)
    dsDataSet: TDataSource;
  private
    FConfiguradorMetaData: IConfiguradorMetaData;
    FConnection: TCustomConnection;
    procedure SetDataSet(const Value: TDataSet);
    function getDataSet: TDataSet;
  protected
    procedure SetConnection(const AConnection: TCustomConnection); virtual;
    function getConexao: TCustomConnection; virtual;
    function ConfiguradorMetaData: IConfiguradorMetaData; virtual; final;
  public
    constructor Create(AOwner: TComponent; const AConnection: TCustomConnection;
      const AConfiguradorMetaData: IConfiguradorMetaData); reintroduce;
  published
    property DataSet: TDataSet read getDataSet write SetDataSet;
  end;

var
  fmcDBForm: TfmcDBForm;

implementation

{$R *.dfm}
{ TfmcForm1 }

function TfmcDBForm.ConfiguradorMetaData: IConfiguradorMetaData;
begin
  result := FConfiguradorMetaData;
end;

constructor TfmcDBForm.Create(AOwner: TComponent; const AConnection: TCustomConnection;
  const AConfiguradorMetaData: IConfiguradorMetaData);
begin
  inherited Create(AOwner);
  FConfiguradorMetaData := AConfiguradorMetaData;
  SetConnection(AConnection);
end;

function TfmcDBForm.getConexao: TCustomConnection;
begin
  result := FConnection;
end;

function TfmcDBForm.getDataSet: TDataSet;
begin
  result := dsDataSet.DataSet;
end;

procedure TfmcDBForm.SetConnection(const AConnection: TCustomConnection);
begin
  FConnection := AConnection;
end;

procedure TfmcDBForm.SetDataSet(const Value: TDataSet);
begin
  dsDataSet.DataSet := Value;
end;

end.
