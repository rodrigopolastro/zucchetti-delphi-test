﻿unit UConfirmDeletion;

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
  if Frm_PesqOrders.actionType = 'deleteOrder' then
    L_Message.Caption := 'Tem certeza que deseja excluir o Pedido Nº ' +
      Frm_PesqOrders.currentOrderId + '?'
  else if (Frm_PesqOrders.actionType = 'deleteItem') or
          (Frm_CadOrders.secActionType = 'deleteItem') then
    L_Message.Caption := 'Tem certeza que deseja excluir o Produto de Código ' +
      Frm_PesqOrders.currentItemProductId +
      ' do Pedido Nº ' + Frm_PesqOrders.currentOrderId + '?'
end;

procedure TFrm_ConfirmDeletion.B_DeleteClick(Sender: TObject);
begin
  if Frm_PesqOrders.actionType = 'deleteOrder' then
  begin
    DeleteOrder(Frm_PesqOrders.currentOrderId);
	  ShowMessage('Pedido excluído.');
    Frm_PesqOrders.DBG_Orders.DataSource.DataSet.Refresh;
    Frm_PesqOrders.DBG_Orders.DataSource.DataSet.First;
    Frm_PesqOrders.currentOrderId :=
    	Frm_PesqOrders.DBG_Orders.DataSource.DataSet.Fields[0].AsString;
    DisplayOrderItems(Frm_PesqOrders.currentOrderId, Frm_PesqOrders.FDQ_Items);
  end
  else if (Frm_PesqOrders.actionType = 'deleteItem') or
          (Frm_CadOrders.secActionType = 'deleteItem') then
  begin
  	DeleteItem(
    	Frm_PesqOrders.currentOrderId,
    	Frm_PesqOrders.currentItemProductId
    );
    ShowMessage('Item excluído.');
    Frm_PesqOrders.DBG_Items.DataSource.DataSet.Refresh;
  end;
  Self.Close;
end;

procedure TFrm_ConfirmDeletion.B_CancelClick(Sender: TObject);
begin
  Self.Close;
end;

end.
