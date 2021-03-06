program DDDTest;

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
  DDD.Teste.Modulo.AdaptadorDataSetEntidade in 'DDD.Teste.Modulo.AdaptadorDataSetEntidade.pas',
  DDD.Anotacao in '..\Anotacao\DDD.Anotacao.pas',
  DDD.Anotacao.Entidade.Propriedade in '..\Anotacao\DDD.Anotacao.Entidade.Propriedade.pas',
  DDD.Anotacao.Entidade in '..\Anotacao\DDD.Anotacao.Entidade.pas',
  DDD.Teste.Mock.Entidade in 'DDD.Teste.Mock.Entidade.pas',
  DDD.Teste.Entidade in 'DDD.Teste.Entidade.pas',
  DDD.Teste.Agregado in 'DDD.Teste.Agregado.pas',
  DDD.Teste.Mock.Agregado in 'DDD.Teste.Mock.Agregado.pas',
  DDD.Teste.IDRandomico in 'DDD.Teste.IDRandomico.pas',
  DDD.Modulo.Intf.IDFactory in '..\Modulo\DDD.Modulo.Intf.IDFactory.pas',
  DDD.Modulo.Intf.Adaptador in '..\Modulo\DDD.Modulo.Intf.Adaptador.pas',
  DDD.Modulo.Impl.IDFactory in '..\Modulo\DDD.Modulo.Impl.IDFactory.pas',
  DDD.Modulo.Impl.Adaptador.DataSetEntidade in '..\Modulo\DDD.Modulo.Impl.Adaptador.DataSetEntidade.pas',
  DDD.Core.Intf.ID in '..\Core\DDD.Core.Intf.ID.pas',
  DDD.Core.Intf.Entidade in '..\Core\DDD.Core.Intf.Entidade.pas',
  DDD.Core.Intf.Agregado in '..\Core\DDD.Core.Intf.Agregado.pas',
  DDD.Core.Impl.IDRandomico in '..\Core\DDD.Core.Impl.IDRandomico.pas',
  DDD.Core.Impl.Entidade in '..\Core\DDD.Core.Impl.Entidade.pas',
  DDD.Core.Impl.Agregado in '..\Core\DDD.Core.Impl.Agregado.pas',
  DDD.Modulo.Impl.Adaptador.EntidadeDataSet in '..\Modulo\DDD.Modulo.Impl.Adaptador.EntidadeDataSet.pas',
  DDD.Teste.Modulo.AdaptadorEntidadeDataSet in 'DDD.Teste.Modulo.AdaptadorEntidadeDataSet.pas';

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //tell the runner how we will log things
    //Log to the console window
    logger := TDUnitXConsoleLogger.Create(true);
    runner.AddLogger(logger);
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False; //When true, Assertions must be made during tests;

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
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
