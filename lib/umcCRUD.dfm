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
    ActivePage = tbsPesquisa
    Align = alClient
    TabOrder = 0
    object tbsPesquisa: TTabSheet
      Caption = ' Pesquisa '
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
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
        DataSource = dsPesquisa
        OnSelecionarClick = fmcFrmConsultaSelecionarClick
        OnNovoClick = fmcFrmConsultaNovoClick
        OnFecharClick = fmcFrmConsultaFecharClick
        OnPesquisar = fmcFrmConsultaPesquisar
      end
    end
    object tbsCadastro: TTabSheet
      Caption = ' Cadastro '
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object CrudToolbar: TumcFDCrudToolbar
        Left = 0
        Top = 328
        Width = 689
        Height = 52
        Align = alBottom
        AutoSize = True
        TabOrder = 0
        DataSource = dsDataSet
      end
    end
  end
  object mcsPesquisa: TMCSelect [1]
    Coluna = <>
    Juncao = <>
    Condicao = <>
    OrderBy = <>
    GroupBy = <>
    LimitarRegistros = 0
    SaltarRegistros = 0
    Left = 64
    Top = 168
  end
  inherited dsDataSet: TDataSource
    Left = 660
    Top = 8
  end
  object dsPesquisa: TDataSource
    Left = 624
    Top = 8
  end
end
