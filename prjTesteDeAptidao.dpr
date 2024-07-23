program prjTesteDeAptidao;

uses
  Vcl.Forms,
  untOrders in 'untOrders.pas' {frmOrders},
  untOrdersMaintenance in 'untOrdersMaintenance.pas' {frmOrdersMaintenance},
  untOrderItemsMaintenance in 'untOrderItemsMaintenance.pas' {frmOrderItemsMaintenance},
  untProductsList in 'untProductsList.pas' {frmProductsList},
  untProducts in 'untProducts.pas' {frmProducts};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmProductsList, frmProductsList);
  Application.CreateForm(TfrmOrders, frmOrders);
  Application.CreateForm(TfrmOrdersMaintenance, frmOrdersMaintenance);
  Application.CreateForm(TfrmOrderItemsMaintenance, frmOrderItemsMaintenance);
  Application.CreateForm(TfrmProducts, frmProducts);
  Application.Run;
end.
