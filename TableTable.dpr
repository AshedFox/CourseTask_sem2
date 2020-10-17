program TableTable;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {Form1},
  AddForm in 'AddForm.pas' {Form2},
  Graphic in 'Graphic.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
