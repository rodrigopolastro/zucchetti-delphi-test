program prjTesteDeAptidao;

uses
  Vcl.Forms,
  untOrders in 'untOrders.pas' {frmOrders},
  untOrdersMaintenance in 'untOrdersMaintenance.pas' {frmOrdersMaintenance},
  untItemsMaintenance in 'untItemsMaintenance.pas' {frmItemsMaintenance};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmOrders, frmOrders);
  Application.CreateForm(TfrmOrdersMaintenance, frmOrdersMaintenance);
  Application.CreateForm(TfrmItemsMaintenance, frmItemsMaintenance);
  Application.Run;
end.
