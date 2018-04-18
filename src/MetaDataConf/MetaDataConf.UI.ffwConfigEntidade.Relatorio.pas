unit MetaDataConf.UI.ffwConfigEntidade.Relatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, dxGDIPlusClasses;

type
  TForm1 = class(TForm)
    RLReport1: TRLReport;
    FDMemTable1: TFDMemTable;
    dtsEntidade: TDataSource;
    dtsEntPropriedade: TDataSource;
    FDMemTable1ID: TFDAutoIncField;
    FDMemTable1NOME: TStringField;
    FDMemTable1DESCRICAO: TStringField;
    FDMemTable2: TFDMemTable;
    FDMemTable2ID: TFDAutoIncField;
    FDMemTable2ENTIDADE_ID: TIntegerField;
    FDMemTable2NOME: TStringField;
    FDMemTable2DESCRICAO: TStringField;
    FDMemTable2REQUERIDO: TStringField;
    FDMemTable2SOMENTE_LEITURA: TStringField;
    FDMemTable2VISIVEL: TStringField;
    FDMemTable2TAMANHO_DISPLAY: TIntegerField;
    FDMemTable2POSICAO: TSmallintField;
    RLBand2: TRLBand;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLDBText1: TRLDBText;
    RLSubDetail1: TRLSubDetail;
    RLBand3: TRLBand;
    RLDBText2: TRLDBText;
    RLLabel4: TRLLabel;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLBand4: TRLBand;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLBand5: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel3: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    RLImage1: TRLImage;
    RLSystemInfo3: TRLSystemInfo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
