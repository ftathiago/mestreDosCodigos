object frmMenu: TfrmMenu
  Left = 0
  Top = 0
  Caption = 'O mestre dos c'#243'digos'
  ClientHeight = 378
  ClientWidth = 660
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClick = AbrirCRUD
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 112
    Top = 48
    object mnuExercicios: TMenuItem
      Caption = 'Exerc'#237'cios'
      object mnufrmArrayClientes: TMenuItem
        Caption = 'Array din'#226'mico...'
        OnClick = AbrirForm
      end
      object mnuffwConfigEntidade: TMenuItem
        Caption = 'Configurar Metadados...'
        OnClick = AbrirForm
      end
      object mnufrmCadPesquisa: TMenuItem
        Caption = 'Cadastro de pesquisas...'
        OnClick = AbrirCRUD
      end
      object mnufrmPerguntasAlternativas: TMenuItem
        Caption = 'Cadastro de perguntas...'
        OnClick = mnufrmPerguntasAlternativasClick
      end
    end
  end
  object FDMoniCustomClientLink1: TFDMoniCustomClientLink
    OnOutput = FDMoniCustomClientLink1Output
    Left = 40
    Top = 128
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ExtendedMetadata=True'
      'ConnectionDef=MestreDosCodigos')
    Connected = True
    Left = 40
    Top = 72
  end
end
