program TesteSQL;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}


uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  Teste.Constantes in 'Teste.Constantes.pas',
  SQL.Builder.Tabela in 'SQL.Builder.Tabela.pas',
  SQL.Builder.Coluna in 'SQL.Builder.Coluna.pas',
  SQL.Builder.Condicao in 'SQL.Builder.Condicao.pas',
  SQL.Builder.Juncao in 'SQL.Builder.Juncao.pas',
  uSQLTabelaTeste in 'uSQLTabelaTeste.pas',
  uSQLColunaTeste in 'uSQLColunaTeste.pas',
  uSQLCondicaoTeste in 'uSQLCondicaoTeste.pas',
  uSQLJuncaoTeste in 'uSQLJuncaoTeste.pas',
  SQL.Impl.Juncao.Lista in 'SQL.Impl.Juncao.Lista.pas',
  SQL.Builder.Select in 'SQL.Builder.Select.pas',
  uSQLSelectTeste in 'uSQLSelectTeste.pas';

var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger: ITestLogger;

begin
  ReportMemoryLeaksOnShutdown := True;
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    // Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    // Create the test runner
    runner := TDUnitX.CreateRunner;
    // Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    // tell the runner how we will log things
    // Log to the console window
    logger := TDUnitXConsoleLogger.Create(True);
    runner.AddLogger(logger);
    // Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False; // When true, Assertions must be made during tests;

    // Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

{$IFNDEF CI}
    // We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
{$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;

end.
