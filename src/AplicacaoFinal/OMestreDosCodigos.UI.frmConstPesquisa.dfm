inherited frmConsPesquisa: TfrmConsPesquisa
  Caption = 'Consulta de Pesquisas'
  ClientHeight = 368
  ClientWidth = 450
  ExplicitWidth = 456
  ExplicitHeight = 396
  PixelsPerInch = 96
  TextHeight = 13
  inherited fmcFrmConsulta: TfmcFrmConsulta
    Width = 450
    Height = 368
    OnPesquisar = fmcFrmConsultaPesquisar
    OnSelecionarCampoParaPesquisa = fmcFrmConsultaSelecionarCampoParaPesquisa
    ExplicitWidth = 450
    ExplicitHeight = 368
  end
  inherited selPesquisa: TMCSelect
    Coluna = <
      item
        Coluna.Nome = 'DESCRICAO'
      end
      item
        Coluna.Nome = 'DATA_FIM'
      end
      item
      end
      item
        Coluna.Nome = 'ATIVA'
      end>
    From.Nome = 'PESQUISA'
    Condicao = <
      item
      end>
  end
  object qryPesquisa: TFDQuery
    AfterOpen = qryPesquisaAfterOpen
    Left = 368
    Top = 64
  end
end
