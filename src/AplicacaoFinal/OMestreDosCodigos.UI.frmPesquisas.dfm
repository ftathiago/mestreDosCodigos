inherited frmCadPesquisa: TfrmCadPesquisa
  Caption = 'Cadastro de Pesquisas'
  ClientHeight = 408
  ClientWidth = 717
  ExplicitWidth = 733
  ExplicitHeight = 446
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcCrud: TPageControl
    Width = 717
    Height = 408
    ActivePage = tbsCadastro
    ExplicitWidth = 717
    ExplicitHeight = 408
    inherited tbsPesquisa: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 709
      ExplicitHeight = 380
      inherited fmcFrmConsulta: TfmcFrmConsulta
        Width = 709
        Height = 380
        ExplicitWidth = 709
        ExplicitHeight = 380
      end
    end
    inherited tbsCadastro: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 709
      ExplicitHeight = 380
      object Label1: TLabel [0]
        Left = 8
        Top = 8
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
        FocusControl = ID
      end
      object Label2: TLabel [1]
        Left = 8
        Top = 89
        Width = 87
        Height = 13
        Caption = 'Nome da pesquisa'
        FocusControl = DESCRICAO
      end
      object Label3: TLabel [2]
        Left = 148
        Top = 8
        Width = 44
        Height = 13
        Caption = 'Cadastro'
      end
      object Label4: TLabel [3]
        Left = 8
        Top = 49
        Width = 25
        Height = 13
        Caption = 'In'#237'cio'
        FocusControl = DATA_INICIO
      end
      object Label5: TLabel [4]
        Left = 164
        Top = 49
        Width = 16
        Height = 13
        Caption = 'Fim'
        FocusControl = DATA_FIM
      end
      object DBText1: TDBText [5]
        Left = 148
        Top = 25
        Width = 53
        Height = 16
        AutoSize = True
        DataField = 'DATA_CADASTRO'
        DataSource = dsDataSet
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited CrudToolbar: TumcFDCrudToolbar
        Top = 328
        Width = 709
        TabOrder = 5
        ExplicitTop = 328
        ExplicitWidth = 709
      end
      object ID: TDBEdit
        Left = 8
        Top = 24
        Width = 134
        Height = 21
        TabStop = False
        DataField = 'ID'
        DataSource = dsDataSet
        Enabled = False
        ReadOnly = True
        TabOrder = 0
      end
      object DESCRICAO: TDBEdit
        Left = 8
        Top = 105
        Width = 586
        Height = 21
        DataField = 'DESCRICAO'
        DataSource = dsDataSet
        TabOrder = 3
      end
      object DATA_INICIO: TDBEdit
        Left = 8
        Top = 65
        Width = 150
        Height = 21
        DataField = 'DATA_INICIO'
        DataSource = dsDataSet
        TabOrder = 1
      end
      object DATA_FIM: TDBEdit
        Left = 164
        Top = 65
        Width = 150
        Height = 21
        DataField = 'DATA_FIM'
        DataSource = dsDataSet
        TabOrder = 2
      end
      object ATIVA: TDBCheckBox
        Left = 8
        Top = 132
        Width = 97
        Height = 17
        Caption = 'Ativa'
        DataField = 'ATIVA'
        DataSource = dsDataSet
        TabOrder = 4
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
  end
  inherited mcsPesquisa: TMCSelect
    Coluna = <
      item
        Coluna.Nome = 'DESCRICAO'
      end
      item
        Coluna.Nome = 'DATA_INICIO'
      end
      item
        Coluna.Nome = 'DATA_FIM'
      end
      item
        Coluna.Nome = 'ATIVA'
      end
      item
        Coluna.Nome = 'ID'
      end>
    From.Nome = 'PESQUISA'
    Condicao = <
      item
        Condicao.Coluna.Nome = 'ID'
        Condicao.Valor = '-1'
      end>
  end
  inherited dsDataSet: TDataSource
    DataSet = qryDataSet
    Left = 96
    Top = 272
  end
  inherited dsPesquisa: TDataSource
    Left = 96
    Top = 200
  end
  object qryDataSet: TFDQuery
    AfterOpen = qryPesquisaAfterOpen
    OnNewRecord = qryDataSetNewRecord
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_PESQUISA_ID'
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'ID'
    SQL.Strings = (
      'select * from pesquisa')
    Left = 96
    Top = 240
  end
  object mcsDataSet: TMCSelect
    Coluna = <
      item
        Coluna.Nome = 'ID'
      end
      item
        Coluna.Nome = 'DESCRICAO'
      end
      item
        Coluna.Nome = 'DATA_CADASTRO'
      end
      item
        Coluna.Nome = 'DATA_INICIO'
      end
      item
        Coluna.Nome = 'DATA_FIM'
      end
      item
        Coluna.Nome = 'ATIVA'
      end>
    From.Nome = 'PESQUISA'
    Juncao = <>
    Condicao = <
      item
        Condicao.Coluna.Nome = 'ID'
        Condicao.Valor = ':ID'
      end>
    OrderBy = <>
    GroupBy = <>
    LimitarRegistros = 0
    SaltarRegistros = 0
    Left = 64
    Top = 240
  end
end
