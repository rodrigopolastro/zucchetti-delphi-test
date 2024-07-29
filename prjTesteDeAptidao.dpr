program prjTesteDeAptidao;

uses
  Vcl.Forms,
  UPesqOrders in 'UPesqOrders.pas' {Frm_PesqOrders},
  UCadOrders in 'UCadOrders.pas' {Frm_CadOrders},
  UCadOrderItems in 'UCadOrderItems.pas' {Frm_CadOrderItems},
  UPesqProducts in 'UPesqProducts.pas' {Frm_PesqProducts},
  UBackendFunctions in 'UBackendFunctions.pas',
  UConfirmDeletion in 'UConfirmDeletion.pas' {Frm_ConfirmDeletion},
  UGenerateReport in 'UGenerateReport.pas' {Frm_GenerateReport};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrm_PesqOrders, Frm_PesqOrders);
  Application.CreateForm(TFrm_CadOrders, Frm_CadOrders);
  Application.CreateForm(TFrm_CadOrderItems, Frm_CadOrderItems);
  Application.CreateForm(TFrm_PesqProducts, Frm_PesqProducts);
  Application.CreateForm(TFrm_ConfirmDeletion, Frm_ConfirmDeletion);
  Application.CreateForm(TFrm_GenerateReport, Frm_GenerateReport);
  Application.Run;
end.
