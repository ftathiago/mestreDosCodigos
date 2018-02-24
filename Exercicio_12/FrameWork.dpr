program FrameWork;

uses
  Vcl.Forms,
  umcForm in 'umcForm.pas' {fmcForm},
  umcDBForm in 'umcDBForm.pas' {fmcDBForm},
  umcDBPesquisa in 'umcDBPesquisa.pas' {fmcDBPesquisa},
  umcCRUD in 'umcCRUD.pas' {fmcCRUD},
  Teste in 'Teste.pas' {fmcCRUD1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmcCRUD1, fmcCRUD1);
  Application.CreateForm(TfmcCRUD, fmcCRUD);
  Application.CreateForm(TfmcForm, fmcForm);
  Application.CreateForm(TfmcDBForm, fmcDBForm);
  Application.CreateForm(TfmcDBPesquisa, fmcDBPesquisa);
  Application.Run;
end.
