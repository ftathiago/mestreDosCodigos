unit uSQLSelectTeste;

interface

uses
  DUnitX.TestFramework,
  DesignPattern.Builder.Intf.Director,
  SQL.Intf.Select,
  SQL.Intf.Select.Builder;

type

  [TestFixture]
  TSQLSelectTeste = class(TObject)
  private
    FDirector: IDirector<IBuilderSelect, ISQLSelect>;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestarSelect;
    [Test]
    procedure TestarSaveToFile;
  end;

implementation

uses
  System.SysUtils,
  SQL.Impl.Select.Director,
  Teste.Builder.Select;

const
  FILE_NAME = 'C:\arquivo.sql';

procedure TSQLSelectTeste.Setup;
var
  _builder: IBuilderSelect;
begin
  _builder := TCBSelectSimples.New;

  FDirector := TDirectorSelect.New;
  FDirector.setBuilder(_builder);
  FDirector.Construir;

  if FileExists(FILE_NAME) then
    DeleteFile(FILE_NAME);
end;

procedure TSQLSelectTeste.TearDown;
begin
  FDirector := nil;
end;

procedure TSQLSelectTeste.TestarSaveToFile;
var
  _select: ISQLSelect;
begin
  _select := FDirector.getObjetoPronto;
  _select.SaveToFile(FILE_NAME);
  Assert.IsTrue(FileExists(FILE_NAME));
end;

procedure TSQLSelectTeste.TestarSelect;
var
  _select: ISQLSelect;
begin
  _select := FDirector.getObjetoPronto;
  Assert.AreEqual('select COLUNA' + #$D#$A +
      ', COLUNA' + #$D#$A +
      ', COLUNA' + #$D#$A +
      ', null as NOME_VIRTUAL' + #$D#$A +
      '' + #$D#$A +
      'from ANOME_DA_TABELA T_ALIAS' + #$D#$A +
      'INNER JOIN ANOME_DA_TABELA T_ALIAS on (T_ALIAS.COLUNA = VALOR)' + #$D#$A +
      'INNER JOIN ANOME_DA_TABELA T_ALIAS on (T_ALIAS.COLUNA = VALOR)' + #$D#$A +
      'INNER JOIN ANOME_DA_TABELA T_ALIAS on (T_ALIAS.COLUNA = VALOR)' + #$D#$A +
      'INNER JOIN ANOME_DA_TABELA T_ALIAS on (T_ALIAS.COLUNA = VALOR)' + #$D#$A +
      '' + #$D#$A +
      'where (COLUNA = VALOR)' + #$D#$A +
      'OR (COLUNA = VALOR)' + #$D#$A +
      'AND (COLUNA = VALOR)' + #$D#$A +
      'order by COLUNA' + #$D#$A +
      ', COLUNA' + #$D#$A +
      ', COLUNA', _select.ToString.Trim);
end;

initialization

TDUnitX.RegisterTestFixture(TSQLSelectTeste);

end.
