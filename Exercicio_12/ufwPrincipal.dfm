object ffwPrincipal: TffwPrincipal
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 368
  ClientWidth = 650
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      
        'Database=C:\Users\Ambiente\Documents\Delphi\mestreDosCodigos\Exe' +
        'rcicio_04\database\MESTREDOSCODIGOS.FDB'
      'Server=127.0.0.1'
      'Protocol=TCPIP'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 232
  end
  object MainMenu: TMainMenu
    Left = 320
    Top = 192
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object mnuffwConfigEntidade: TMenuItem
        Caption = 'Entidade'
        OnClick = AbrirForm
      end
    end
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 320
    Top = 200
  end
end
