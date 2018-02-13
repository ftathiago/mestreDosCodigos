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
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 445
    ExplicitHeight = 282
  end
  object MCSelect: TMCSelect
    Coluna = <
      item
        Coluna.Tabela.Nome = 'NOME_DA_TABELA'
        Coluna.Tabela.Alias = 'ALIAS_DA_TABELA'
        Coluna.Nome = 'NOME_DA_COLUNA'
        Coluna.NomeVirtual = 'NOME_VIRTUAL'
      end>
    From.Nome = 'NOME_DA_TABELA'
    From.Alias = 'ALIA_DA_TABELA'
    Juncao = <
      item
        Tabela.Nome = 'TABELA_DA_JUNCAO'
        Tabela.Alias = 'ALIAS_DA_TABELA_DA_JUNCAO'
        Condicao = <
          item
            Condicao.Coluna.Nome = 'COLUNA_DA_JUNCAO'
            Condicao.Valor = 'NOME_DE_UM_CAMPO_ESCRITO'
          end>
      end>
    Condicao = <
      item
        Condicao.Coluna.Tabela.Nome = 'NOME_DA_TABELA'
        Condicao.Coluna.Tabela.Alias = 'ALIAS_DA_TABELA'
        Condicao.Coluna.Nome = 'COLUNA_CONDICAO1'
        Condicao.Valor = '1'
      end
      item
        Condicao.OperadorLogico = olOr
        Condicao.Coluna.Tabela.Nome = 'NOME_DA_TABELA'
        Condicao.Coluna.Tabela.Alias = 'ALIAS_DA_TABELA'
        Condicao.Coluna.Nome = 'COLUNA_CONDICAO1'
        Condicao.Valor = '2'
      end>
    Left = 8
    Top = 32
  end
end
