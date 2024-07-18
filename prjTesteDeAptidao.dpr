program prjTesteDeAptidao;

uses
  Vcl.Forms,
  untTesteDeAptidao in 'untTesteDeAptidao.pas' {frmHome};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHome, frmHome);
  Application.Run;
end.
