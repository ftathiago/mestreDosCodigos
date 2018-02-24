unit umcDBPesquisa;

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
  umcDBForm,
  Data.DB, umcFrmConsulta;

type
  TfmcDBPesquisa = class(TfmcDBForm)
    fmcFrmConsulta1: TfmcFrmConsulta;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmcDBPesquisa: TfmcDBPesquisa;

implementation

{$R *.dfm}

end.
