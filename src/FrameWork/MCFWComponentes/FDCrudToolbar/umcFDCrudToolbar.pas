unit umcFDCrudToolbar;

interface

uses
  umcFrameWorkTypes,
  Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  umcCrudToolbar;

type
  TumcFDCrudToolbar = class(TCrudToolbar)
  private
    FFDDataSet: TFDDataSet;
    FOnAplicarAlteracoesClick: TDataSetClick;
    FAntesAplicarAlteracoes: TDataSetEventoCancelavel;
    FAposAplicarAlteracoes: TDataSetClick;
    FSchemaAdapter: TFDSchemaAdapter;
    procedure SetOnAplicarAlteracoesClick(const Value: TDataSetClick);
    procedure SetAntesAplicarAlteracoes(const Value: TDataSetEventoCancelavel);
    procedure SetAposAplicarAlteracoes(const Value: TDataSetClick);
    procedure SetSchemaAdapter(const Value: TFDSchemaAdapter);
  protected
    function getDataSet: TFDDataSet; reintroduce;
    procedure SincronizarBotoes; override;
    procedure AplicarAlteracoes;
    procedure CommitUpdates;
  public

    procedure Salvar; override;
    procedure Apagar; override;
    procedure Desfazer; override;
    procedure AfterConstruction; override;
  published
    property AntesAplicarAlteracoes: TDataSetEventoCancelavel read FAntesAplicarAlteracoes
      write SetAntesAplicarAlteracoes;
    property OnAplicarAlteracoesClick: TDataSetClick read FOnAplicarAlteracoesClick write SetOnAplicarAlteracoesClick;
    property AposAplicarAlteracoes: TDataSetClick read FAposAplicarAlteracoes write SetAposAplicarAlteracoes;
    property SchemaAdapter: TFDSchemaAdapter read FSchemaAdapter write SetSchemaAdapter;
  end;

implementation

procedure TumcFDCrudToolbar.AfterConstruction;
begin
  inherited;
  Name := '';
end;

procedure TumcFDCrudToolbar.Apagar;
begin
  inherited;
  AplicarAlteracoes;
  CommitUpdates;
end;

procedure TumcFDCrudToolbar.AplicarAlteracoes;
begin
  ExecutarAcao(getDataSet,
    procedure
    begin
      if Assigned(FSchemaAdapter) then
      begin
        if FSchemaAdapter.UpdatesPending then
          FSchemaAdapter.ApplyUpdates(0);
      end
      else
      begin
        if getDataSet.UpdatesPending then
          getDataSet.ApplyUpdates(0);
      end;

      if Assigned(FOnAplicarAlteracoesClick) then
        FOnAplicarAlteracoesClick(getDataSet);

    end, FAntesAplicarAlteracoes, FAposAplicarAlteracoes);
end;

procedure TumcFDCrudToolbar.CommitUpdates;
begin
  ExecutarAcao(getDataSet,
    procedure
    begin
      if Assigned(FSchemaAdapter) then
      begin
        if FSchemaAdapter.UpdatesPending then
          FSchemaAdapter.CommitUpdates;
      end
      else
      begin
        if getDataSet.UpdatesPending then
          getDataSet.CommitUpdates
      end;
    end, Nil, Nil);
end;

procedure TumcFDCrudToolbar.Desfazer;
begin
  if Assigned(FSchemaAdapter) and FSchemaAdapter.UpdatesPending then
    FSchemaAdapter.CancelUpdates;

  if getDataSet.UpdatesPending then
    getDataSet.CancelUpdates;

  inherited;
end;

function TumcFDCrudToolbar.getDataSet: TFDDataSet;
begin
  if not Assigned(FFDDataSet) then
    FFDDataSet := inherited getDataSet as TFDDataSet;

  result := FFDDataSet;
end;

procedure TumcFDCrudToolbar.Salvar;
begin
  inherited;
  AplicarAlteracoes;
  CommitUpdates;
end;

procedure TumcFDCrudToolbar.SetAntesAplicarAlteracoes(const Value: TDataSetEventoCancelavel);
begin
  FAntesAplicarAlteracoes := Value;
end;

procedure TumcFDCrudToolbar.SetAposAplicarAlteracoes(const Value: TDataSetClick);
begin
  FAposAplicarAlteracoes := Value;
end;

procedure TumcFDCrudToolbar.SetOnAplicarAlteracoesClick(const Value: TDataSetClick);
begin
  FOnAplicarAlteracoesClick := Value;
end;

procedure TumcFDCrudToolbar.SetSchemaAdapter(const Value: TFDSchemaAdapter);
begin
  FSchemaAdapter := Value;
end;

procedure TumcFDCrudToolbar.SincronizarBotoes;
var
  _temModificacoes: boolean;
  _estaEditando: boolean;
begin
  inherited;
  if not TestarDataSetAtribuido then
    exit;

  _temModificacoes := getDataSet.ChangeCount > 0;
  if Assigned(FSchemaAdapter) then
    _temModificacoes := FSchemaAdapter.ChangeCount > 0;

  _estaEditando := TestarDataSetEditavel;

  btnCrudSalvar.Enabled := btnCrudSalvar.Enabled or _temModificacoes;
  btnCrudDesfazer.Enabled := (_temModificacoes) or (_estaEditando);
  btnCrudAtualizar.Enabled := btnCrudAtualizar.Enabled and _temModificacoes;
end;

end.
