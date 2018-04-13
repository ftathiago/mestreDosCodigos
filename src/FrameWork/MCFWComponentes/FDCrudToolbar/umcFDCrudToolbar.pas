unit umcFDCrudToolbar;

interface

uses
  umcFrameWorkTypes,
  Data.DB,
  FireDAC.Comp.DataSet,
  umcCrudToolbar;

type
  TumcFDCrudToolbar = class(TCrudToolbar)
  private
    FFDDataSet: TFDDataSet;
    FOnAplicarAlteracoesClick: TDataSetClick;
    procedure SetOnAplicarAlteracoesClick(const Value: TDataSetClick);
  protected
    function getDataSet: TFDDataSet; reintroduce;
    procedure SincronizarBotoes; override;
  public
    procedure AplicarAlteracoes;
    property OnAplicarAlteracoesClick: TDataSetClick read FOnAplicarAlteracoesClick
      write SetOnAplicarAlteracoesClick;
  end;

implementation

{ TumcFDCrudToolbar }

procedure TumcFDCrudToolbar.AplicarAlteracoes;
begin

end;

function TumcFDCrudToolbar.getDataSet: TFDDataSet;
begin
  if not Assigned(FFDDataSet) then
    FFDDataSet := inherited getDataSet as TFDDataSet;

  result := FFDDataSet;
end;

procedure TumcFDCrudToolbar.SetOnAplicarAlteracoesClick(const Value: TDataSetClick);
begin
  FOnAplicarAlteracoesClick := Value;
end;

procedure TumcFDCrudToolbar.SincronizarBotoes;
begin
  inherited;
  if not TestarDataSetAtribuido then
    exit;
  btnCrudSalvar.Enabled := btnCrudSalvar.Enabled or (getDataSet.ChangeCount > 0);
  btnCrudDesfazer.Enabled := (getDataSet.ChangeCount > 0);
  btnCrudAtualizar.Enabled := btnCrudAtualizar.Enabled and (getDataSet.ChangeCount = 0);
end;

end.
