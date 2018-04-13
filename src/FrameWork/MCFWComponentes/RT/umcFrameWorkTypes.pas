unit umcFrameWorkTypes;

interface

uses
  Data.Db;

type
  TAcoes = (aSelecionar, aNovo, aFechar, aImprimir, aAtualizar);
  TAcoesSet = set of TAcoes;

  TCRUDAcoes = (crudSalvar, crudCancelar, crudApagar, crudAtualizar, crudImprimir);
  TCRUDAcoesSet = set of TCRUDAcoes;

  TDataSetClick = procedure(const DataSet: TDataSet) of Object;
  TDataSetAtualizarClick = procedure(const DataSet: TDataSet; Atualizado: boolean = false) of object;
  TPesquisarClick = procedure(const Conteudo: string; const Campo: TField) of object;

implementation

end.
