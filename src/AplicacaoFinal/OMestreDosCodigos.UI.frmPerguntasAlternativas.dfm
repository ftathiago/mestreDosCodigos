inherited frmPerguntasAlternativas: TfrmPerguntasAlternativas
  Caption = 'Cadastro de Perguntas'
  ClientHeight = 415
  ClientWidth = 700
  Constraints.MinHeight = 415
  Constraints.MinWidth = 700
  ExplicitWidth = 716
  ExplicitHeight = 453
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcCrud: TPageControl
    Width = 700
    Height = 415
    ActivePage = tbsCadastro
    ExplicitWidth = 700
    ExplicitHeight = 415
    inherited tbsPesquisa: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 692
      ExplicitHeight = 387
      inherited fmcFrmConsulta: TfmcFrmConsulta
        Width = 692
        Height = 387
        ExplicitWidth = 692
        ExplicitHeight = 387
      end
    end
    inherited tbsCadastro: TTabSheet
      Caption = ' Pergunta '
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 692
      ExplicitHeight = 387
      inherited CrudToolbar: TumcFDCrudToolbar
        Top = 335
        Width = 692
        SchemaAdapter = FDSchemaAdapter
        ExplicitTop = 335
        ExplicitWidth = 692
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 692
        Height = 105
        Align = alTop
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 1
        DesignSize = (
          692
          105)
        object Label1: TLabel
          Left = 8
          Top = 8
          Width = 33
          Height = 13
          Caption = 'C'#243'digo'
          FocusControl = ID
        end
        object Label3: TLabel
          Left = 8
          Top = 56
          Width = 44
          Height = 13
          Caption = 'Pergunta'
          FocusControl = DESCRICAO
        end
        object Label4: TLabel
          Left = 86
          Top = 8
          Width = 42
          Height = 13
          Caption = 'Pesquisa'
          FocusControl = PESQUISA_DESC
        end
        object ID: TDBEdit
          Left = 8
          Top = 24
          Width = 59
          Height = 21
          DataField = 'ID'
          DataSource = dsDataSet
          Enabled = False
          ReadOnly = True
          TabOrder = 0
        end
        object PESQUISA_ID: TDBEdit
          Left = 86
          Top = 24
          Width = 59
          Height = 21
          DataField = 'PESQUISA_ID'
          DataSource = dsDataSet
          TabOrder = 1
        end
        object DESCRICAO: TDBEdit
          Left = 8
          Top = 72
          Width = 676
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          DataField = 'DESCRICAO'
          DataSource = dsDataSet
          TabOrder = 2
        end
        object PESQUISA_DESC: TDBEdit
          Left = 151
          Top = 24
          Width = 533
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          DataField = 'PESQUISA_DESC'
          DataSource = dsDataSet
          Enabled = False
          ReadOnly = True
          TabOrder = 3
        end
      end
      object pnlGrade: TPanel
        Left = 0
        Top = 105
        Width = 692
        Height = 230
        Align = alClient
        Caption = 'pnlGrade'
        ShowCaption = False
        TabOrder = 2
        object grdAlternativas: TDBGrid
          Left = 1
          Top = 1
          Width = 662
          Height = 228
          Align = alClient
          DataSource = dsAlternativas
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
        object Panel2: TPanel
          Left = 663
          Top = 1
          Width = 28
          Height = 228
          Align = alRight
          BevelOuter = bvNone
          Caption = 'Panel2'
          ShowCaption = False
          TabOrder = 1
          object DBNavigator1: TDBNavigator
            Left = 0
            Top = 0
            Width = 28
            Height = 97
            DataSource = dsAlternativas
            VisibleButtons = [nbInsert, nbDelete, nbPost, nbCancel]
            Align = alTop
            Hints.Strings = (
              'Primeiro'
              'Anterior'
              'Pr'#243'ximo'
              #218'ltimo'
              'Novo'
              'Apagar'
              'Alterar'
              'Salvar'
              'Cancelar'
              'Atualizar'
              'Aplicar altera'#231#245'es'
              'Cancelar altera'#231#245'es')
            Kind = dbnVertical
            ConfirmDelete = False
            TabOrder = 0
          end
        end
      end
    end
  end
  object FDSchemaAdapter: TFDSchemaAdapter [1]
    Left = 408
    Top = 64
  end
  inherited mcsPesquisa: TMCSelect
    Coluna = <
      item
        Coluna.Nome = 'PERGUNTAS'
      end
      item
        Coluna.Nome = 'PESQUISA'
      end
      item
        Coluna.Nome = 'ATIVA'
      end
      item
        Coluna.Nome = 'ID'
      end>
    From.Nome = 'sch_perguntas'
    Condicao = <
      item
        Condicao.Coluna.Nome = 'ID'
        Condicao.Valor = '-1'
      end>
    Left = 328
    Top = 48
  end
  inherited qryPesquisa: TFDQuery
    Left = 360
    Top = 48
  end
  inherited dsDataSet: TDataSource
    DataSet = qryPerguntas
    Left = 440
    Top = 92
  end
  inherited dsPesquisa: TDataSource
    Left = 360
    Top = 80
  end
  object qryPerguntas: TFDQuery
    AfterOpen = qryPerguntasAfterOpen
    CachedUpdates = True
    SchemaAdapter = FDSchemaAdapter
    FetchOptions.AssignedValues = [evItems]
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_PERGUNTAS_ID'
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'ID'
    SQL.Strings = (
      'select PERGUNTAS.ID'
      '     , PERGUNTAS.PESQUISA_ID'
      '     , PERGUNTAS.DESCRICAO'
      '     , PESQUISA.DESCRICAO as PESQUISA_DESC'
      'from PERGUNTAS'
      '    join PESQUISA on PESQUISA.ID = PERGUNTAS.PESQUISA_ID'
      'where PERGUNTAS.ID = :ID')
    Left = 440
    Top = 64
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryPerguntasID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryPerguntasPESQUISA_ID: TIntegerField
      FieldName = 'PESQUISA_ID'
      Origin = 'PESQUISA_ID'
      Required = True
    end
    object qryPerguntasDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 1500
    end
    object qryPerguntasPESQUISA_DESC: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'PESQUISA_DESC'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 200
    end
  end
  object qryAlternativas: TFDQuery
    AfterOpen = qryAlternativasAfterOpen
    BeforeInsert = qryAlternativasBeforeInsert
    BeforeEdit = qryAlternativasBeforeEdit
    AfterPost = qryAlternativasAfterPost
    AfterDelete = qryAlternativasAfterDelete
    CachedUpdates = True
    MasterSource = dsDataSet
    MasterFields = 'ID'
    DetailFields = 'PERGUNTA_ID'
    SchemaAdapter = FDSchemaAdapter
    FetchOptions.AssignedValues = [evItems, evDetailCascade]
    FetchOptions.DetailCascade = True
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_ALTERNATIVAS_ID'
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'ID'
    SQL.Strings = (
      'select ID'
      '     , PERGUNTA_ID'
      '     , DESCRICAO'
      'from ALTERNATIVAS'
      'where PERGUNTA_ID = :ID')
    Left = 468
    Top = 64
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object mcsPerguntas: TMCSelect
    Coluna = <
      item
        Coluna.Tabela.Nome = 'PERGUNTAS'
        Coluna.Nome = 'ID'
      end
      item
        Coluna.Tabela.Nome = 'PERGUNTAS'
        Coluna.Nome = 'PESQUISA_ID'
      end
      item
        Coluna.Tabela.Nome = 'PERGUNTAS'
        Coluna.Nome = 'DESCRICAO'
      end
      item
        Coluna.Tabela.Nome = 'PESQUISA'
        Coluna.Nome = 'DESCRICAO'
        Coluna.NomeVirtual = 'PESQUISA_DESC'
      end>
    From.Nome = 'PERGUNTAS'
    Juncao = <
      item
        Tabela.Nome = 'PESQUISA'
        Condicao = <
          item
            Condicao.Coluna.Tabela.Nome = 'PESQUISA'
            Condicao.Coluna.Nome = 'ID'
            Condicao.Valor = 'PERGUNTAS.PESQUISA_ID'
          end>
      end>
    Condicao = <
      item
        Condicao.Coluna.Tabela.Nome = 'PERGUNTAS'
        Condicao.Coluna.Nome = 'ID'
        Condicao.Valor = ':ID'
      end>
    OrderBy = <>
    GroupBy = <>
    LimitarRegistros = 0
    SaltarRegistros = 0
    Left = 440
    Top = 40
  end
  object mcsAlternativas: TMCSelect
    Coluna = <
      item
        Coluna.Nome = 'ID'
      end
      item
        Coluna.Nome = 'PERGUNTA_ID'
      end
      item
        Coluna.Nome = 'DESCRICAO'
      end>
    From.Nome = 'ALTERNATIVAS'
    Juncao = <>
    Condicao = <
      item
        Condicao.Coluna.Nome = 'PERGUNTA_ID'
        Condicao.Valor = ':ID'
      end>
    OrderBy = <>
    GroupBy = <>
    LimitarRegistros = 0
    SaltarRegistros = 0
    Left = 468
    Top = 40
  end
  object dsAlternativas: TDataSource
    DataSet = qryAlternativas
    Left = 468
    Top = 92
  end
end
