unit DDD.Modulo.Impl.Adaptador.DataSetEntidade;

interface

uses
  Data.DB, DDD.Core.Intf.Entidade, DDD.Modulo.Intf.Adaptador;

type
  TAdaptadorDataSetEntidade<T: IEntidade> = class(TInterfacedObject, IAdaptador)
  private
    FDataSet: TDataSet;
    FEntidade: IEntidade;
  public
    class function New(const ADataSet: TDataSet; const AEntidade: T): IAdaptador;
    constructor Create(const ADataSet: TDataSet; const AEntidade: T);
    procedure Adaptar;
  end;

implementation

uses
  DDD.Anotacao.Entidade.Propriedade,
  pkgUtils.Impl.RttiUtils, System.Rtti;

constructor TAdaptadorDataSetEntidade<T>.Create(const ADataSet: TDataSet; const AEntidade: T);
begin
  FDataSet := ADataSet;
  FEntidade := AEntidade;
end;

class function TAdaptadorDataSetEntidade<T>.New(const ADataSet: TDataSet; const AEntidade: T): IAdaptador;
begin
  result := Create(ADataSet, AEntidade);
end;

procedure TAdaptadorDataSetEntidade<T>.Adaptar;
var
  i: Integer;
  _propriedades: TArray<TRttiProperty>;
  _propriedade: TRttiProperty;
  _anotacao: TPropriedadeAttribute;
begin
  _propriedades := RttiUtils.getProperties(FEntidade as TObject);
  for _propriedade in _propriedades do
  begin
    _anotacao := TPropriedadeAttribute.ExtrairAnotacao(_propriedade) as TPropriedadeAttribute;
    if not Assigned(_anotacao) then
      continue;
    RttiUtils.FieldToValue(FDataSet.FieldByName(_anotacao.NomePropriedade), FEntidade as TObject,
      _propriedade.Name);
  end;
end;

end.
