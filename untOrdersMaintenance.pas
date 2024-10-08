unit untOrdersMaintenance;

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

  untOrderItemsMaintenance,
  untConfirmDeletion;

type
  TfrmOrdersMaintenance = class(TForm)
    edtOrderNumber: TEdit;
    lblOrderNumber: TLabel;
    lblOrderDate: TLabel;
    dtpOrderDate: TDateTimePicker;
    lblItens: TLabel;
    btnCreate: TButton;
    btnUpdate: TButton;
    btnDelete: TButton;
    dbgOrderItems: TDBGrid;
    btnSave: TButton;
    btnCancel: TButton;
    fdcDatabaseConnection: TFDConnection;
    fdqOrderItems: TFDQuery;
    dtsOrderItems: TDataSource;
    fdqQueries: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure dbgOrderItemsCellClick(Column: TColumn);
    procedure btnUpdateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    currentNumberOfItems: Integer;
    isOrdersMaintenanceOpen : Boolean;
    secActionType: String;
  end;

var
  frmOrdersMaintenance: TfrmOrdersMaintenance;

implementation

{$R *.dfm}

uses
  untBackendFunctions,
	untOrders;

procedure RemoveOrderItemFromList(productId: String);
begin
	frmOrdersMaintenance.dbgOrderItems.DataSource.DataSet.Delete;
end;

procedure AddItemsToOrder(orderId: String);
	var i, quantity: Integer;
  var dataset: TDataSet;
  var productId: String;
begin
	dataset := frmOrdersMaintenance.fdqOrderItems;
	for i := 1 to frmOrdersMaintenance.currentNumberOfItems do
  begin
  	frmOrdersMaintenance.fdqOrderItems.RecNo := i;
    productId := dataset.FieldByName('C�d. Produto').AsString;
    quantity := dataset.FieldByName('Quantidade').AsInteger;

    if DoesOrderContainProduct(orderId, productId) then
      UpdateItemQuantity(orderId, productId, quantity)
    else
      InsertOrderItem(orderId, productId, quantity, frmOrdersMaintenance.fdqQueries);
  end;
end;

procedure TfrmOrdersMaintenance.btnSaveClick(Sender: TObject);
	var orderId, saveMessage: String;
begin
	if frmOrders.actionType = 'createOrder' then
  begin
  	orderId := IntToStr(CreateOrder());
  	saveMessage := 'Pedido ' + orderId + ' registrado com sucesso!';
  end
  else if frmOrders.actionType = 'editOrder' then
  begin
  	orderId := frmOrders.currentOrderId;
    UpdateOrderDate(orderId);
  	saveMessage := 'Pedido ' + orderId + ' atualizado!';
  end;

  AddItemsToOrder(orderId);
  ShowMessage(saveMessage);
  frmOrders.dbgOrders.DataSource.DataSet.First;
  frmOrders.dbgOrders.DataSource.DataSet.Refresh;
  frmOrders.currentOrderId := frmOrders.dbgOrders.Fields[0].AsString;
  DisplayOrderItems(orderId, frmOrders.fdqItems);
  Self.Close;
end;

procedure TfrmOrdersMaintenance.btnCancelClick(Sender: TObject);
begin
	ShowMessage('Pedido cancelado.');
  Self.Close;
end;

procedure TfrmOrdersMaintenance.btnCreateClick(Sender: TObject);
begin
  secActionType := 'createOrderItem';
	frmOrderItemsMaintenance.ShowModal;
end;

procedure TfrmOrdersMaintenance.btnDeleteClick(Sender: TObject);
begin
	if frmOrders.currentItemProductId.IsEmpty then Exit();

  if (frmOrders.actionType = 'editOrder') and
     (DoesOrderContainProduct(frmOrders.currentOrderId, frmOrders.currentItemProductId)) then
  begin
    DeleteItem(frmOrders.currentOrderId, frmOrders.currentItemProductId);
    secActionType := 'deleteItem';
    frmConfirmDeletion.ShowModal;
  end;
  RemoveOrderItemFromList(frmOrders.currentItemProductId);
  frmOrders.currentItemProductId := dbgOrderItems.Fields[0].AsString;
  Dec(frmOrdersMaintenance.currentNumberOfItems);
end;

procedure TfrmOrdersMaintenance.btnUpdateClick(Sender: TObject);
begin
	if frmOrders.currentItemProductId.IsEmpty then Exit();

  secActionType := 'editOrderItem';
  DisplayItemInfo(
    frmOrders.currentOrderId,
    frmOrders.currentItemProductId
  );
  frmOrderItemsMaintenance.ShowModal;
end;

procedure TfrmOrdersMaintenance.dbgOrderItemsCellClick(Column: TColumn);
begin
  frmOrders.currentItemProductId := dbgOrderItems.Fields[0].AsString;
end;

procedure TfrmOrdersMaintenance.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  isOrdersMaintenanceOpen := False;
end;

procedure TfrmOrdersMaintenance.FormShow(Sender: TObject);
begin
  isOrdersMaintenanceOpen := True;

  if frmOrders.actionType = 'createOrder' then
	begin
  	lblOrderNumber.Caption := 'Novo Pedido';
    edtOrderNumber.Visible := False;
    dtpOrderDate.Date := Now;
    displayOrderItems('', frmOrdersMaintenance.fdqOrderItems);
    currentNumberOfItems := 0;
  end
	else if frmOrders.actionType = 'editOrder' then
  begin
  	lblOrderNumber.Caption := 'N� Pedido';
    edtOrderNumber.Visible := True;
  	edtOrderNumber.Text := frmOrders.currentOrderId;
    dtpOrderDate.Date := GetOrderDate(frmOrders.currentOrderId);
    displayOrderItems(frmOrders.currentOrderId, frmOrdersMaintenance.fdqOrderItems);
    currentNumberOfItems := dbgOrderItems.DataSource.DataSet.RecordCount;
  end;

  dbgOrderItems.DataSource.DataSet.First;
  frmOrders.currentItemProductId := dbgOrderItems.Fields[0].AsString;
end;

end.
