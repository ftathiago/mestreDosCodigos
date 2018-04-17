unit MetaDataConf.UI.ffwConfigEntidade.Relatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    lblTitulo: TRLLabel;
    lblDataHora: TRLLabel;
    FDMemTable1: TFDMemTable;
    RLDetailGrid1: TRLDetailGrid;
    dtsEntidade: TDataSource;
    RLDBText1: TRLDBText;
    RLSubDetail1: TRLSubDetail;
    dtsEntPropriedade: TDataSource;
    FDMemTable1ID: TFDAutoIncField;
    FDMemTable1NOME: TStringField;
    FDMemTable1DESCRICAO: TStringField;
    RLLabel2: TRLLabel;
    RLLabel4: TRLLabel;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
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
