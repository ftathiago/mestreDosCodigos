inherited fmcCRUD1: TfmcCRUD1
  Caption = 'fmcCRUD1'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcCrud: TPageControl
    ActivePage = tbsPesquisa
    inherited tbsCadastro: TTabSheet
      object DBEdit1: TDBEdit [0]
        Left = 3
        Top = 24
        Width = 121
        Height = 21
        DataField = 'Nome'
        DataSource = dsDataSet
        TabOrder = 0
      end
      inherited CrudToolbar: TCrudToolbar
        TabOrder = 1
        ExplicitLeft = 0
        ExplicitTop = 328
        ExplicitWidth = 689
      end
    end
  end
  inherited dsDataSet: TDataSource
    DataSet = FDMemTable1
  end
  object FDMemTable1: TFDMemTable
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 344
    Top = 208
    object FDMemTable1Nome: TStringField
      FieldName = 'Nome'
      Size = 250
    end
  end
end
