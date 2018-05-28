program MVCTeste;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}

uses
  LeakCheck,
  LeakCheck.Utils,
  System.SysUtils,
//  DUnitX.MemoryLeakMonitor.FastMM4,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  MVC.Intf.View in '..\MVC.Intf.View.pas',
  MVC.Intf.Controller in '..\MVC.Intf.Controller.pas',
  MVC.Intf.ControlaExibicao in '..\MVC.Intf.ControlaExibicao.pas',
  MVC.Intf.Conectavel in '..\MVC.Intf.Conectavel.pas',
  MVC.Impl.View in '..\MVC.Impl.View.pas' {FormView},
  MVC.Impl.View.FrameView in '..\MVC.Impl.View.FrameView.pas' {FrameView: TFrame},
  MVC.Impl.Controller in '..\MVC.Impl.Controller.pas',
  MVC.Controller.Intf.Factory in '..\MVC.Controller.Intf.Factory.pas',
  MVC.Controller.Impl.Factory in '..\MVC.Controller.Impl.Factory.pas',
  MVC.RegistroDeClasses in '..\MVC.RegistroDeClasses.pas',
  MVC.Impl.LocalizadorController in '..\MVC.Impl.LocalizadorController.pas',
  MVC.Intf.LocalizadorController in '..\MVC.Intf.LocalizadorController.pas',
  MVC.Anotacoes.View in '..\MVC.Anotacoes.View.pas',
  MVC.Anotacoes.Anotacao in '..\MVC.Anotacoes.Anotacao.pas',
  Teste.Controller.Factory in 'Teste.Controller.Factory.pas',
  Teste.Atributos.View in 'Teste.Atributos.View.pas',
  Teste.Mock.ControllerMock in 'Teste.Mock.ControllerMock.pas',
  Teste.LocalizadorController in 'Teste.LocalizadorController.pas',
  Teste.Mock.ViewMock in 'Teste.Mock.ViewMock.pas';

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
