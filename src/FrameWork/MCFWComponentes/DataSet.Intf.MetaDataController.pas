unit DataSet.Intf.MetaDataController;

interface

uses
  System.SysUtils,
  DataSet.Intf.MetaDataContainer,
  Data.DB;

type
  EMetaDataControllerException = Exception;
  TMetaDataProcedimento = (mdpLimpar, mdpCarregar);
  TOnFinalizarProcesso = procedure(const AProcedimento: TMetaDataProcedimento) of object;

  ImcMetaDataController = interface(IInterface)
    procedure SetMetaDataContainer(const AMetaDataContainer: IMetaDataContainer);
    procedure Limpar(const AIncluindoMetaData :boolean = false);
    procedure Carregar;
  end;

const
  ENTIDADE = 'ENTIDADE';
  ENT_PROPRIEDADE = 'ENT_PROPRIEDADE';
  INSERT_ENTIDADE =
    'insert into ENTIDADE (ID, NOME, DESCRICAO) ' +
    'values (:ID, :NOME, :DESCRICAO);';

  INSERT_PROPRIEDADE =
    'insert into ENT_PROPRIEDADE (' +
    '  ID, ENTIDADE_ID, NOME, DESCRICAO, REQUERIDO, ' +
    '  SOMENTE_LEITURA, VISIVEL, TAMANHO_DISPLAY,POSICAO ' +
    ') values (:ID, :ENTIDADE_ID, :NOME, :DESCRICAO, :REQUERIDO, ' +
    '  :SOMENTE_LEITURA, :VISIVEL, :TAMANHO_DISPLAY, :POSICAO);';

resourcestring
  METADATACONTROLLER_CONTAINER_NAO_INFORMADO =
    'Não foi atribuída uma instância de IMetaDataContainer';

implementation

end.
