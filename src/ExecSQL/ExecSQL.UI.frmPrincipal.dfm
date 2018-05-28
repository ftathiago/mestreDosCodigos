object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'frmPrincipal'
  ClientHeight = 411
  ClientWidth = 734
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 734
    Height = 21
    AutoSize = True
    ButtonHeight = 21
    ButtonWidth = 61
    Caption = 'ToolBar1'
    DragMode = dmAutomatic
    DrawingStyle = dsGradient
    ShowCaptions = True
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actfrmInicialView
      AutoSize = True
    end
  end
  object MestredoscodigosConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=MestreDosCodigos')
    LoginPrompt = False
    Left = 543
    Top = 85
  end
  object MainMenu1: TMainMenu
    Left = 104
    Top = 72
  end
  object ActionList1: TActionList
    Left = 424
    Top = 136
    object actfrmInicialView: TAction
      Caption = 'Form Inicial'
      OnExecute = AbrirForm
    end
  end
end
