object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 461
  ClientWidth = 862
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GridPanel1: TGridPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 461
    Align = alClient
    Caption = 'GridPanel1'
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = Label1
        Row = 0
      end
      item
        Column = 1
        Control = Label2
        Row = 0
      end
      item
        Column = 0
        Control = Memo1
        Row = 1
      end
      item
        Column = 1
        Control = Memo2
        Row = 1
      end>
    RowCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 20.000000000000000000
      end
      item
        Value = 100.000000000000000000
      end>
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = 32
    ExplicitTop = 56
    ExplicitWidth = 654
    ExplicitHeight = 285
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 430
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Gerado em tempo de execu'#231#227'o'
      ExplicitWidth = 149
    end
    object Label2: TLabel
      Left = 431
      Top = 1
      Width = 430
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Gerado em tempo de design'
      ExplicitWidth = 134
    end
    object Memo1: TMemo
      Left = 1
      Top = 21
      Width = 430
      Height = 439
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Memo2: TMemo
      Left = 431
      Top = 21
      Width = 430
      Height = 439
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object mcsTempoExecucao: TMCSelect
    Coluna = <
      item
        Coluna.Tabela.Nome = 'NOME_TABELA'
        Coluna.Tabela.Alias = 'ALIAS_TABELA'
        Coluna.Nome = 'NOME_COLUNA'
        Coluna.NomeVirtual = 'NOME_VIRTUAL'
      end>
    From.Nome = 'NOME_TABELA'
    From.Alias = 'ALIAS_TABELA'
    Juncao = <>
    Condicao = <
      item
        Condicao.Coluna.Nome = 'asdf'
        Condicao.Coluna.NomeVirtual = 'werwe'
      end>
    OrderBy = <
      item
        Coluna.Nome = 'COLUNA_ORDER'
      end>
    GroupBy = <
      item
        Coluna.Nome = 'coluna1'
      end>
    LimitarRegistros = 10
    SaltarRegistros = 0
    SQLTexto.Strings = (
      '')
    Left = 104
    Top = 48
  end
  object mcsDesign: TMCSelect
    Coluna = <
      item
        Coluna.Tabela.Nome = 'NOME_TABELA'
        Coluna.Tabela.Alias = 'ALIAS_TABELA'
        Coluna.Nome = 'NOME_COLUNA'
        Coluna.NomeVirtual = 'NOME_VIRTUAL'
      end>
    From.Nome = 'NOME_TABELA'
    From.Alias = 'ALIAS_TABELA'
    Juncao = <>
    Condicao = <
      item
        Condicao.Coluna.Nome = 'asdf'
        Condicao.Coluna.NomeVirtual = 'werwe'
      end>
    OrderBy = <
      item
        Coluna.Nome = 'COLUNA_ORDER'
      end>
    GroupBy = <
      item
        Coluna.Nome = 'coluna1'
      end>
    LimitarRegistros = 10
    SaltarRegistros = 0
    SQLTexto.Strings = (
      '')
    Left = 440
    Top = 48
  end
end
