object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 314
  ClientWidth = 699
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
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 699
    Height = 314
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object MCSelect: TMCSelect
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
end
