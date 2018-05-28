inherited frmListaObjetosView: TfrmListaObjetosView
  Width = 218
  Height = 448
  ParentFont = False
  ExplicitWidth = 218
  ExplicitHeight = 448
  object ListaObjetosDados: TCategoryPanelGroup
    Left = 0
    Top = 0
    Width = 218
    Height = 448
    VertScrollBar.Tracking = True
    Align = alClient
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'Tahoma'
    HeaderFont.Style = []
    TabOrder = 0
    object ListaStoredProcedures: TCategoryPanel
      Top = 400
      Height = 30
      Caption = 'Stored Procedures'
      Collapsed = True
      TabOrder = 0
      ExplicitTop = 230
      object DBGrid3: TDBGrid
        Left = 0
        Top = 21
        Width = 214
        Height = 153
        Align = alClient
        DataSource = dtsSP
        Options = [dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'PROC_NAME'
            Visible = True
          end>
      end
      object edtPesquisarSP: TEdit
        Left = 0
        Top = 0
        Width = 214
        Height = 21
        Align = alTop
        TabOrder = 1
        Text = 'Pequisar...'
        OnChange = edtPesquisarSPChange
      end
    end
    object ListaCampos: TCategoryPanel
      Top = 200
      Caption = 'Campos'
      TabOrder = 1
      object DBGrid2: TDBGrid
        Left = 0
        Top = 21
        Width = 214
        Height = 153
        Align = alClient
        DataSource = dtsCampos
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'COLUMN_POSITION'
            Title.Caption = 'Pos.'
            Width = 22
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COLUMN_NAME'
            Title.Caption = 'Campo'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COLUMN_TYPENAME'
            Title.Caption = 'Tipo'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COLUMN_ATTRIBUTES'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COLUMN_PRECISION'
            Title.Caption = 'Precis'#227'o'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COLUMN_SCALE'
            Title.Caption = 'Escala'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COLUMN_LENGTH'
            Title.Caption = 'Tamanho'
            Visible = True
          end>
      end
      object edtPesquisarCampos: TEdit
        Left = 0
        Top = 0
        Width = 214
        Height = 21
        Align = alTop
        TabOrder = 1
        Text = 'Pesquisar...'
        OnChange = edtPesquisarCamposChange
      end
    end
    object ListaTabelas: TCategoryPanel
      Top = 0
      Caption = 'Tabelas'
      TabOrder = 2
      object GridTabelas: TDBGrid
        Left = 0
        Top = 21
        Width = 214
        Height = 153
        Align = alClient
        DataSource = dtsTabelas
        Options = [dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'TABLE_NAME'
            Visible = True
          end>
      end
      object edtPesquisarTabelas: TEdit
        Left = 0
        Top = 0
        Width = 214
        Height = 21
        Align = alTop
        TabOrder = 1
        Text = 'Pesquisar...'
        OnChange = edtPesquisarTabelasChange
      end
    end
  end
  object qryCampos: TFDMetaInfoQuery
    Active = True
    Connection = MestredoscodigosConnection
    MetaInfoKind = mkTableFields
    ObjectName = 'asdf'
    Left = 88
    Top = 190
  end
  object qrySP: TFDMetaInfoQuery
    Active = True
    Connection = MestredoscodigosConnection
    MetaInfoKind = mkProcs
    Left = 88
    Top = 222
  end
  object qryTabelas: TFDMetaInfoQuery
    AfterScroll = qryTabelasAfterScroll
    Left = 88
    Top = 158
  end
  object dtsTabelas: TDataSource
    DataSet = qryTabelas
    Left = 120
    Top = 158
  end
  object MestredoscodigosConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=MestreDosCodigos')
    Connected = True
    LoginPrompt = False
    Left = 142
    Top = 65207
  end
  object dtsCampos: TDataSource
    DataSet = qryCampos
    Left = 120
    Top = 190
  end
  object dtsSP: TDataSource
    DataSet = qrySP
    Left = 120
    Top = 222
  end
end
