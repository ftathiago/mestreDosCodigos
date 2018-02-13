unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections, GeradorSQL.Comp.Select,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    MCSelect: TMCSelect;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Text := MCSelect.GerarSQL;
end;

end.
