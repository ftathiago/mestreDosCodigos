unit Teste;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Actions,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ImgList,
  Vcl.ActnList,
  Vcl.ExtCtrls,
  Vcl.ToolWin,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.Mask,
  Vcl.DBCtrls,
  Data.DB,
  umcCRUD,
  umcCrudToolbar,
  umcFrmConsulta,
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
  TfmcCRUD1 = class(TfmcCRUD)
    FDMemTable1: TFDMemTable;
    FDMemTable1Nome: TStringField;
    DBEdit1: TDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmcCRUD1: TfmcCRUD1;

implementation

{$R *.dfm}


end.
