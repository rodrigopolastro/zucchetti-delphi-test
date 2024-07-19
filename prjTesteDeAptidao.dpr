program prjTesteDeAptidao;

uses
  Vcl.Forms,
  untOrders in 'untOrders.pas' {frmOrders},
  untOrdersMaintenance in 'untOrdersMaintenance.pas' {frmOrdersMaintenance},
  untItemsMaintenance in 'untItemsMaintenance.pas' {frmItemsMaintenance},
  untPlaceOrder in 'untPlaceOrder.pas' {frmPlaceOrder};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmOrders, frmOrders);
  Application.CreateForm(TfrmOrdersMaintenance, frmOrdersMaintenance);
  Application.CreateForm(TfrmItemsMaintenance, frmItemsMaintenance);
  Application.CreateForm(TfrmPlaceOrder, frmPlaceOrder);
  Application.Run;
end.
