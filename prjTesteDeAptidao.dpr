program prjTesteDeAptidao;

uses
  Vcl.Forms,
  untOrders in 'untOrders.pas' {frmOrders},
  untOrdersMaintenance in 'untOrdersMaintenance.pas' {frmOrdersMaintenance},
  untOrderItemsMaintenance in 'untOrderItemsMaintenance.pas' {frmOrderItemsMaintenance},
  untProducts in 'untProducts.pas' {frmProducts},
  untBackendFunctions in 'untBackendFunctions.pas',
  untConfirmDeletion in 'untConfirmDeletion.pas' {frmConfirmDeletion},
  untGenerateReport in 'untGenerateReport.pas' {frmGenerateReport};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmOrders, frmOrders);
  Application.CreateForm(TfrmProducts, frmProducts);
  Application.CreateForm(TfrmOrdersMaintenance, frmOrdersMaintenance);
  Application.CreateForm(TfrmOrderItemsMaintenance, frmOrderItemsMaintenance);
  Application.CreateForm(TfrmConfirmDeletion, frmConfirmDeletion);
  Application.CreateForm(TfrmGenerateReport, frmGenerateReport);
  Application.Run;
end.
