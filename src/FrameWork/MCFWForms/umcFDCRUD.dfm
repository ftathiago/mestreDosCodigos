inherited fmcFDCRUD: TfmcFDCRUD
  Caption = 'fmcFDCRUD'
  ClientHeight = 400
  ClientWidth = 695
  OnCreate = FormCreate
  ExplicitWidth = 711
  ExplicitHeight = 438
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcCrud: TPageControl
    Width = 695
    Height = 400
    ExplicitWidth = 695
    ExplicitHeight = 400
    inherited tbsPesquisa: TTabSheet
      ExplicitWidth = 687
      ExplicitHeight = 372
      inherited fmcFrmConsulta: TfmcFrmConsulta
        Width = 687
        Height = 372
        OnSelecionarCampoParaPesquisa = fmcFrmConsultaSelecionarCampoParaPesquisa
        ExplicitWidth = 687
        ExplicitHeight = 372
      end
    end
    inherited tbsCadastro: TTabSheet
      ExplicitWidth = 687
      ExplicitHeight = 372
      inherited CrudToolbar: TumcFDCrudToolbar
        Top = 320
        Width = 687
        ExplicitTop = 320
        ExplicitWidth = 687
      end
    end
  end
  object qryPesquisa: TFDQuery [2]
    AfterOpen = qryPesquisaAfterOpen
    Left = 96
    Top = 168
  end
  inherited dsPesquisa: TDataSource
    DataSet = qryPesquisa
  end
end
