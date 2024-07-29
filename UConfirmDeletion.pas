unit UConfirmDeletion;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TFrm_ConfirmDeletion = class(TForm)
    L_Message: TLabel;
    B_Delete: TButton;
    B_Cancel: TButton;
    procedure B_DeleteClick(Sender: TObject);
    procedure B_CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_ConfirmDeletion: TFrm_ConfirmDeletion;

implementation

{$R *.dfm}

uses
	UBackendFunctions,
  UPesqOrders,
  UCadOrders;

procedure TFrm_ConfirmDeletion.FormShow(Sender: TObject);
begin
  if frmOrders.actionType = 'deleteOrder' then
    lblMessage.Caption := 'Tem certeza que deseja excluir o Pedido Nº ' +
      frmOrders.currentOrderId + '?'
  else if (frmOrders.actionType = 'deleteItem') or
          (frmOrdersMaintenance.secActionType = 'deleteItem') then
    lblMessage.Caption := 'Tem certeza que deseja excluir o Produto de Código ' +
      frmOrders.currentItemProductId +
      ' do Pedido Nº ' + frmOrders.currentOrderId + '?'
end;

procedure TFrm_ConfirmDeletion.B_DeleteClick(Sender: TObject);
begin
  if frmOrders.actionType = 'deleteOrder' then
  begin
    DeleteOrder(frmOrders.currentOrderId);
	  ShowMessage('Pedido excluído.');
    frmOrders.dbgOrders.DataSource.DataSet.Refresh;
    frmOrders.dbgOrders.DataSource.DataSet.First;
    frmOrders.currentOrderId :=
    	frmOrders.dbgOrders.DataSource.DataSet.Fields[0].AsString;
    DisplayOrderItems(frmOrders.currentOrderId, frmOrders.fdqItems);
  end
  else if (frmOrders.actionType = 'deleteItem') or
          (frmOrdersMaintenance.secActionType = 'deleteItem') then
  begin
  	DeleteItem(
    	frmOrders.currentOrderId,
    	frmOrders.currentItemProductId
    );
    ShowMessage('Item excluído.');
    frmOrders.dbgItems.DataSource.DataSet.Refresh;
  end;
  Self.Close;
end;

procedure TFrm_ConfirmDeletion.B_CancelClick(Sender: TObject);
begin
  Self.Close;
end;

end.
