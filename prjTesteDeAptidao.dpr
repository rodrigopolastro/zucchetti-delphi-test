program prjTesteDeAptidao;

uses
  Vcl.Forms,
  untOrders in 'untOrders.pas' {frmOrders},
  untOrdersMaintenance in 'untOrdersMaintenance.pas' {frmOrdersMaintenance},
  untOrderItemsMaintenance in 'untOrderItemsMaintenance.pas' {frmOrderItemsMaintenance},
  untProductsList in 'untProductsList.pas' {frmProductsList};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmOrders, frmOrders);
  Application.CreateForm(TfrmOrdersMaintenance, frmOrdersMaintenance);
  Application.CreateForm(TfrmOrderItemsMaintenance, frmOrderItemsMaintenance);
  Application.CreateForm(TfrmProductsList, frmProductsList);
  Application.Run;
end.
