 unit umcCRUD;

interface

uses
  umcFDCrudToolbar,
  umcFrmConsulta,
  umcDBForm,
  System.Classes,
  System.Actions,
  System.ImageList,
  Vcl.Forms,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ToolWin,
  Vcl.ActnList,
  Vcl.ImgList,
  Data.DB;

type
  TfmcCRUD = class(TfmcDBForm)
    pgcCrud: TPageControl;
    tbsPesquisa: TTabSheet;
    tbsCadastro: TTabSheet;
    fmcFrmConsulta: TfmcFrmConsulta;
    CrudToolbar: TumcFDCrudToolbar;
    procedure CrudToolbarSalvarClick(const DataSet: TDataSet);
    procedure CrudToolbarDesfazerClick(const DataSet: TDataSet);
    procedure CrudToolbarApagarClick(const DataSet: TDataSet);
    procedure fmcFrmConsultaNovoClick(const DataSet: TDataSet);
    procedure fmcFrmConsultaSelecionarClick(const DataSet: TDataSet);
    procedure fmcFrmConsultaFecharClick(const DataSet: TDataSet);
  private
  protected
    { Private declarations }
  public
    procedure AfterConstruction; override;
    { Public declarations }
  end;

var
  fmcCRUD: TfmcCRUD;

implementation

{$R *.dfm}

{ TfmcCRUD }

procedure TfmcCRUD.AfterConstruction;
begin
  inherited;
  pgcCrud.ActivePage := tbsPesquisa;
end;

procedure TfmcCRUD.CrudToolbarApagarClick(const DataSet: TDataSet);
begin
  inherited;
  dsDataSet.DataSet.Delete;
end;

procedure TfmcCRUD.CrudToolbarDesfazerClick(const DataSet: TDataSet);
begin
  inherited;
  dsDataSet.DataSet.Cancel;
end;

procedure TfmcCRUD.CrudToolbarSalvarClick(const DataSet: TDataSet);
begin
  inherited;
  dsDataSet.DataSet.Post;
end;

procedure TfmcCRUD.fmcFrmConsultaFecharClick(const DataSet: TDataSet);
begin
  inherited;
  Close;
end;

procedure TfmcCRUD.fmcFrmConsultaSelecionarClick(const DataSet: TDataSet);
begin
  inherited;
  pgcCrud.ActivePage := tbsCadastro;
end;

procedure TfmcCRUD.fmcFrmConsultaNovoClick(const DataSet: TDataSet);
begin
  inherited;
  pgcCrud.ActivePage := tbsCadastro;
  dsDataSet.DataSet.Insert;
end;

end.
