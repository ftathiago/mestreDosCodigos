inherited fmcCRUD: TfmcCRUD
  Caption = 'fmcCRUD'
  ClientHeight = 408
  ClientWidth = 697
  ExplicitWidth = 713
  ExplicitHeight = 446
  PixelsPerInch = 96
  TextHeight = 13
  object pgcCrud: TPageControl [0]
    Left = 0
    Top = 0
    Width = 697
    Height = 408
    ActivePage = tbsCadastro
    Align = alClient
    TabOrder = 0
    object tbsPesquisa: TTabSheet
      Caption = ' Pesquisa '
      object fmcFrmConsulta: TfmcFrmConsulta
        Left = 0
        Top = 0
        Width = 689
        Height = 380
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        DataSource = dsDataSet
        OnSelecionarClick = fmcFrmConsultaSelecionarClick
        OnNovoClick = fmcFrmConsultaNovoClick
        OnFecharClick = fmcFrmConsultaFecharClick
        ExplicitLeft = 96
        ExplicitTop = 72
        ExplicitWidth = 494
        ExplicitHeight = 240
      end
    end
    object tbsCadastro: TTabSheet
      Caption = ' Cadastro '
      ImageIndex = 1
      object CrudToolbar: TCrudToolbar
        Left = 0
        Top = 328
        Width = 689
        Height = 52
        Align = alBottom
        TabOrder = 0
        DataSource = dsDataSet
        OnSalvarClick = CrudToolbarSalvarClick
        OnDesfazerClick = CrudToolbarDesfazerClick
        OnApagarClick = CrudToolbarApagarClick
        ExplicitLeft = 232
        ExplicitTop = 168
        ExplicitWidth = 232
      end
    end
  end
  inherited dsDataSet: TDataSource
    Left = 660
    Top = 8
  end
end
