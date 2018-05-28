unit MVC.Impl.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Data.DB, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MVC.Intf.View, MVC.Intf.Controller;

type
  TFormView = class;
  TFormViewClass = class of TFormView;

  TFormView = class(TForm, IView)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FController: IController;
  protected
    function Controller: IController; virtual;
  public
    constructor Create(const AOwner: TComponent; const AController: IController); reintroduce;
  end;

implementation

{$R *.dfm}

uses MVC.Controller.Impl.Factory, MVC.Controller.Intf.Factory;

function TFormView.Controller: IController;
begin
  result := FController;
end;

constructor TFormView.Create(const AOwner: TComponent; const AController: IController);
begin
  inherited Create(AOwner);
  FController := AController;
  FController.setView(Self);
end;

procedure TFormView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FormStyle = fsMDIChild then
    Action := caFree;
end;

procedure TFormView.FormCreate(Sender: TObject);
begin
  Controller.AposCriarAView;
end;

procedure TFormView.FormDestroy(Sender: TObject);
begin
  Controller.AoDestruirView;
end;

procedure TFormView.FormShow(Sender: TObject);
begin
  Controller.AoMostrar;
end;

end.
