object frmInicialView: TfrmInicialView
  Left = 0
  Top = 0
  ActiveControl = frmSQL.SQLContainer
  Caption = 'frmInicialView'
  ClientHeight = 370
  ClientWidth = 766
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inline frmSQL: TfrmSQL
    Left = 218
    Top = 29
    Width = 548
    Height = 341
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 218
    ExplicitTop = 29
    ExplicitWidth = 548
    ExplicitHeight = 341
    inherited SQLContainer: TRichEdit
      Width = 548
      Height = 341
      ExplicitWidth = 548
      ExplicitHeight = 341
    end
  end
  inline frmListaObjetosView: TfrmListaObjetosView
    Left = 0
    Top = 29
    Width = 218
    Height = 341
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitTop = 29
    ExplicitHeight = 341
    inherited ListaObjetosDados: TCategoryPanelGroup
      Height = 341
      ExplicitHeight = 341
      inherited ListaStoredProcedures: TCategoryPanel
        ExplicitWidth = 199
        inherited DBGrid3: TDBGrid
          Width = 197
        end
        inherited edtPesquisarSP: TEdit
          Width = 197
          ExplicitWidth = 197
        end
      end
      inherited ListaCampos: TCategoryPanel
        ExplicitWidth = 199
        inherited DBGrid2: TDBGrid
          Width = 197
          Columns = <
            item
              Expanded = False
              FieldName = 'COLUMN_POSITION'
              Title.Caption = 'Pos.'
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
        inherited edtPesquisarCampos: TEdit
          Width = 197
          ExplicitWidth = 197
        end
      end
      inherited ListaTabelas: TCategoryPanel
        ExplicitWidth = 199
        inherited GridTabelas: TDBGrid
          Width = 197
        end
        inherited edtPesquisarTabelas: TEdit
          Width = 197
          ExplicitWidth = 197
        end
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 766
    Height = 29
    Caption = 'ToolBar1'
    TabOrder = 2
  end
  object ActionList1: TActionList
    Left = 376
    Top = 192
  end
  object ImageList1: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Left = 456
    Top = 208
  end
end
