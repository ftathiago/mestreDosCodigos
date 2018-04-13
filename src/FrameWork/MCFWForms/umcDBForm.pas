unit umcDBForm;

interface

uses
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
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfmcDBForm = class(TfmcForm)
    dsDataSet: TDataSource;
  private
    procedure SetDataSet(const Value: TDataSet);
    function getDataSet: TDataSet;
    { Private declarations }
  public
    { Public declarations }
  published
    property DataSet: TDataSet read getDataSet write SetDataSet;
  end;

var
  fmcDBForm: TfmcDBForm;

implementation

{$R *.dfm}

{ TfmcForm1 }

function TfmcDBForm.getDataSet: TDataSet;
begin
  result := dsDataSet.DataSet;
end;

procedure TfmcDBForm.SetDataSet(const Value: TDataSet);
begin
  dsDataSet.DataSet := Value;
end;

end.
