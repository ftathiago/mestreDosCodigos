unit Teste.FonteDados;

interface

uses
  Data.DB,
  FireDac.Comp.DataSet;

type
  TFonteDados = class
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function getDataSet: TFDDataSet;
    function getEntidadeCarregada: TFDDataSet;
    function getEntPropriedadeCarregada: TFDDataSet;
  end;

implementation

uses
  System.SysUtils,
  Vcl.Forms,
  FireDac.Comp.Client;

{ TFonteDados }

function TFonteDados.getDataSet: TFDDataSet;
begin
  result := TFDMemTable.Create(nil);
end;

function TFonteDados.getEntidadeCarregada: TFDDataSet;
begin
  result := getDataSet;
  result.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Entidade.fds');
end;


function TFonteDados.getEntPropriedadeCarregada: TFDDataSet;
begin
  result := getDataSet;
  result.LoadFromFile(ExtractFilePath(Application.ExeName) + 'EntPropriedade.fds');
end;

end.
