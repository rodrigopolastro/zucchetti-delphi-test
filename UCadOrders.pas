unit UCadOrders;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPickers, Vcl.ComCtrls,
  Vcl.StdCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.Oracle,
  FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids,

  UCadOrderItems,
  UConfirmDeletion;

type
  TFrm_CadOrders = class(TForm)
    E_OrderNumber: TEdit;
    L_OrderNumber: TLabel;
    L_OrderDate: TLabel;
    DTP_OrderDate: TDateTimePicker;
    L_Items: TLabel;
    B_Create: TButton;
    B_Update: TButton;
    B_Delete: TButton;
    DBG_OrderItems: TDBGrid;
    B_Save: TButton;
    B_Cancel: TButton;
    FDQ_OrderItems: TFDQuery;
    DS_OrderItems: TDataSource;
    FDQ_Queries: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure B_SaveClick(Sender: TObject);
    procedure B_CreateClick(Sender: TObject);
    procedure B_CancelClick(Sender: TObject);
    procedure DBG_OrderItemsCellClick(Column: TColumn);
    procedure B_UpdateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure B_DeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    currentNumberOfItems: Integer;
    isCadOrdersOpen : Boolean;
    secActionType: String;
  end;

var
  Frm_CadOrders: TFrm_CadOrders;

implementation

{$R *.dfm}

uses
  UBackendFunctions,
	UPesqOrders;

procedure RemoveOrderItemFromList(productId: String);
begin
	Frm_CadOrders.DBG_OrderItems.DataSource.DataSet.Delete;
end;

procedure AddItemsToOrder(orderId: String);
	var i, quantity: Integer;
  var dataset: TDataSet;
  var productId: String;
begin
	dataset := Frm_CadOrders.FDQ_OrderItems;
	for i := 1 to Frm_CadOrders.currentNumberOfItems do
  begin
  	Frm_CadOrders.FDQ_OrderItems.RecNo := i;
    productId := dataset.FieldByName('Cód. Produto').AsString;
    quantity := dataset.FieldByName('Quantidade').AsInteger;

    if DoesOrderContainProduct(orderId, productId) then
      UpdateItemQuantity(orderId, productId, quantity)
    else
      InsertOrderItem(orderId, productId, quantity, Frm_CadOrders.FDQ_Queries);
  end;
end;

procedure TFrm_CadOrders.B_SaveClick(Sender: TObject);
	var orderId, saveMessage: String;
begin
	if Frm_PesqOrders.actionType = 'createOrder' then
  begin
  	orderId := IntToStr(CreateOrder());
  	saveMessage := 'Pedido ' + orderId + ' registrado com sucesso!';
  end
  else if Frm_PesqOrders.actionType = 'editOrder' then
  begin
  	orderId := Frm_PesqOrders.currentOrderId;
    UpdateOrderDate(orderId);
  	saveMessage := 'Pedido ' + orderId + ' atualizado!';
  end;

  AddItemsToOrder(orderId);
  ShowMessage(saveMessage);
  Frm_PesqOrders.DBG_Orders.DataSource.DataSet.First;
  Frm_PesqOrders.DBG_Orders.DataSource.DataSet.Refresh;
  Frm_PesqOrders.currentOrderId := Frm_PesqOrders.DBG_Orders.Fields[0].AsString;
  DisplayOrderItems(orderId, Frm_PesqOrders.FDQ_Items);
  Self.Close;
end;

procedure TFrm_CadOrders.B_CancelClick(Sender: TObject);
begin
	ShowMessage('Pedido cancelado.');
  Self.Close;
end;

procedure TFrm_CadOrders.B_CreateClick(Sender: TObject);
begin
  secActionType := 'createOrderItem';
	Frm_CadOrderItems.ShowModal;
end;

procedure TFrm_CadOrders.B_DeleteClick(Sender: TObject);
begin
	if Frm_PesqOrders.currentItemProductId.IsEmpty then Exit();

  if (Frm_PesqOrders.actionType = 'editOrder') and
     (DoesOrderContainProduct(Frm_PesqOrders.currentOrderId, Frm_PesqOrders.currentItemProductId)) then
  begin
    DeleteItem(Frm_PesqOrders.currentOrderId, Frm_PesqOrders.currentItemProductId);
    secActionType := 'deleteItem';
    Frm_ConfirmDeletion.ShowModal;
  end;
  RemoveOrderItemFromList(Frm_PesqOrders.currentItemProductId);
  Frm_PesqOrders.currentItemProductId := DBG_OrderItems.Fields[0].AsString;
  Dec(Frm_CadOrders.currentNumberOfItems);
end;

procedure TFrm_CadOrders.B_UpdateClick(Sender: TObject);
begin
	if Frm_PesqOrders.currentItemProductId.IsEmpty then Exit();

  secActionType := 'editOrderItem';
  DisplayItemInfo(
    Frm_PesqOrders.currentOrderId,
    Frm_PesqOrders.currentItemProductId
  );
  Frm_CadOrderItems.ShowModal;
end;

procedure TFrm_CadOrders.DBG_OrderItemsCellClick(Column: TColumn);
begin
  Frm_PesqOrders.currentItemProductId := DBG_OrderItems.Fields[0].AsString;
end;

procedure TFrm_CadOrders.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  isCadOrdersOpen := False;

  Frm_PesqOrders.DBG_Orders.DataSource.DataSet.First;
  Frm_PesqOrders.currentOrderId := Frm_PesqOrders.DBG_Orders.Fields[0].AsString;
end;

procedure TFrm_CadOrders.FormShow(Sender: TObject);
begin
  isCadOrdersOpen := True;

  if Frm_PesqOrders.actionType = 'createOrder' then
	begin
  	L_OrderNumber.Caption := 'Novo Pedido';
    E_OrderNumber.Visible := False;
    DTP_OrderDate.Date := Now;
    displayOrderItems('', Frm_CadOrders.FDQ_OrderItems);
    currentNumberOfItems := 0;
  end
	else if Frm_PesqOrders.actionType = 'editOrder' then
  begin
  	L_OrderNumber.Caption := 'Nº Pedido';
    E_OrderNumber.Visible := True;
  	E_OrderNumber.Text := Frm_PesqOrders.currentOrderId;
    DTP_OrderDate.Date := GetOrderDate(Frm_PesqOrders.currentOrderId);
    displayOrderItems(Frm_PesqOrders.currentOrderId, Frm_CadOrders.FDQ_OrderItems);
    currentNumberOfItems := DBG_OrderItems.DataSource.DataSet.RecordCount;
  end;

  DBG_OrderItems.DataSource.DataSet.First;
  Frm_PesqOrders.currentItemProductId := DBG_OrderItems.Fields[0].AsString;
end;

end.
