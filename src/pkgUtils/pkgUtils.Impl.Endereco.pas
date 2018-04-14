unit pkgUtils.Impl.Endereco;

interface

uses
  pkgUtils.Intf.Endereco;

type
  TEndereco = class(TInterfacedObject, IEndereco)
  private
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FCEP: string;
    FBairro: string;
  public
    class function New(const ALogradouro, ANumero, AComplemento, ACEP, ABairro: string): IEndereco;
    constructor Create(const ALogradouro, ANumero, AComplemento, ACEP, ABairro: string);
    procedure ModificarBairro(const ABairro: string);
    procedure ModificarCEP(const ACEP: string);
    procedure ModificarComplemento(const AComplemento: string);
    procedure ModificarLogradouro(const ALogradouro: string);
    procedure ModificarNumero(const ANumero: string);
    function getBairro: string;
    function getCEP: string;
    function getComplemento: string;
    function getLogradouro: string;
    function getNumero: string;
  end;

implementation

{ TEndereco }

class function TEndereco.New(const ALogradouro, ANumero, AComplemento, ACEP, ABairro: string)
  : IEndereco;
begin
  result := Create(ALogradouro, ANumero, AComplemento, ACEP, ABairro);
end;

constructor TEndereco.Create(const ALogradouro, ANumero, AComplemento, ACEP, ABairro: string);
begin
  ModificarLogradouro(ALogradouro);
  ModificarNumero(ANumero);
  ModificarComplemento(AComplemento);
  ModificarCEP(ACEP);
  ModificarBairro(ABairro);
end;

function TEndereco.getBairro: string;
begin
  result := FBairro;
end;

function TEndereco.getCEP: string;
begin
  result := FCEP;
end;

function TEndereco.getComplemento: string;
begin
  result := FComplemento;
end;

function TEndereco.getLogradouro: string;
begin
  result := FLogradouro;
end;

function TEndereco.getNumero: string;
begin
  result := FNumero;
end;

procedure TEndereco.ModificarBairro(const ABairro: string);
begin
  FBairro := ABairro;
end;

procedure TEndereco.ModificarCEP(const ACEP: string);
begin
  FCEP := ACEP;
end;

procedure TEndereco.ModificarComplemento(const AComplemento: string);
begin
  FComplemento := AComplemento;
end;

procedure TEndereco.ModificarLogradouro(const ALogradouro: string);
begin
  FLogradouro := ALogradouro;
end;

procedure TEndereco.ModificarNumero(const ANumero: string);
begin
  FNumero := ANumero;
end;

end.
