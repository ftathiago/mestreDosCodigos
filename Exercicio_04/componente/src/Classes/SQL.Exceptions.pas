unit SQL.Exceptions;

interface

uses
  System.SysUtils;

type
  EFabricaNaoImplementada = class(Exception);
  ESQLException = class(Exception);
  ECondicaoException = class(ESQLException);
  ESQLInsert = class(ESQLException);
  ESQLFeatureNaoImplementada = class(ESQLException);


implementation

end.
