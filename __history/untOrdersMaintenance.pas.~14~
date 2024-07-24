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

  untOrderItemsMaintenance;

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
    Edit1: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InsertOrderItem;
  end;

var
  frmOrdersMaintenance: TfrmOrdersMaintenance;
	initialNumberOfItems: Integer;

implementation

{$R *.dfm}

uses
	untOrders;


procedure InsertOrderItem(orderId, productId: String; quantity: Integer);
begin
	frmOrdersMaintenance.fdqQueries.SQL.Clear;
  frmOrdersMaintenance.fdqQueries.SQL.Text :=
    'INSERT INTO items(order_id, product_id, quantity) ' +
    'VALUES (:orderId, :productId, :quantity)';

  frmOrdersMaintenance.fdqQueries.ParamByName('orderId').AsString := orderId;
  frmOrdersMaintenance.fdqQueries.ParamByName('productId').AsString := productId;
  frmOrdersMaintenance.fdqQueries.ParamByName('quantity').AsInteger := quantity;
  frmOrdersMaintenance.fdqQueries.ExecSQL;
end;

procedure AddItemsToOrder(orderId: String);
	var i, quantity: Integer;
  var dataset: TDataSet;
  var productId: String;
begin
	dataset := frmOrdersMaintenance.dbgOrderItems.DataSource.DataSet;
	for i := initialNumberOfItems to dataset.RecordCount do
  begin
  	dataset.RecNo := i+1;
    productId := dataset.FieldByName('Cód. Produto').AsString;
    quantity := dataset.FieldByName('Quantidade').AsInteger;

    InsertOrderItem(orderId, productId, quantity);
  end;
end;

procedure UpdateOrderDate(orderId: String);
	var orderDate: String;
begin
  orderDate := DateToStr(frmOrdersMaintenance.dtpOrderDate.Date);

  frmOrdersMaintenance.fdqQueries.SQL.Clear;
  frmOrdersMaintenance.fdqQueries.SQL.Text :=
    'UPDATE orders SET order_date = :orderDate ' +
    'WHERE order_id = :orderId';

  frmOrdersMaintenance.fdqQueries.ParamByName('orderDate').AsString := orderDate;
  frmOrdersMaintenance.fdqQueries.ParamByName('orderId').AsString := orderId;
  frmOrdersMaintenance.fdqQueries.ExecSQL;
end;

function CreateOrder(): Integer;
	var orderDate : String;
begin
	orderDate := DateToStr(frmOrdersMaintenance.dtpOrderDate.Date);

  frmOrdersMaintenance.fdqQueries.SQL.Clear;
  frmOrdersMaintenance.fdqQueries.SQL.Text :=
    'INSERT INTO orders(order_id, order_date) ' +
    'VALUES (seq_order_id.NEXTVAL, :orderDate)';

  frmOrdersMaintenance.fdqQueries.ParamByName('orderDate').AsString := orderDate;
  frmOrdersMaintenance.fdqQueries.ExecSQL;

  Result := frmOrdersMaintenance.fdcDatabaseConnection
  	.GetLastAutoGenValue('seq_order_id');
end;

function GetNextOrderId(): Integer;
begin
	frmOrdersMaintenance.fdqQueries.SQL.Text :=
  	'select seq_order_id.NEXTVAL from user_sequences ' +
    'WHERE sequence_name = ''SEQ_ORDER_ID'' ';

  frmOrdersMaintenance.fdqQueries.Open;
  Result := frmOrdersMaintenance.fdqQueries.Fields[0].AsInteger;
end;

function GetOrderDate(orderId: String): TDate;
begin
	frmOrdersMaintenance.fdqQueries.SQL.Text :=
  	'SELECT order_date FROM orders WHERE order_id = :orderId';
  frmOrdersMaintenance.fdqQueries.ParamByName('orderId').AsString
  	:= frmOrders.currentOrderId;

  frmOrdersMaintenance.fdqQueries.Open;
  Result := frmOrdersMaintenance.fdqQueries.
  								FieldByName('order_date').AsDateTime;
end;


procedure TfrmOrdersMaintenance.btnCreateClick(Sender: TObject);
begin
	frmOrderItemsMaintenance.ShowModal;
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
  frmOrders.dbgOrders.DataSource.DataSet.Refresh;
  frmOrders.displayOrderItems(orderId, frmOrdersMaintenance.fdqOrderItems);
  Self.Close;
end;

procedure TfrmOrdersMaintenance.btnCancelClick(Sender: TObject);
begin
	ShowMessage('Pedido cancelado.');
  Self.Close;
end;

procedure TfrmOrdersMaintenance.FormShow(Sender: TObject);
begin
  if frmOrders.actionType = 'createOrder' then
	begin
  	lblOrderNumber.Caption := 'Novo Pedido';
    edtOrderNumber.Visible := False;
    dtpOrderDate.Date := Now;
    frmOrders.displayOrderItems('', frmOrdersMaintenance.fdqOrderItems);
    initialNumberOfItems := 0;
  end
	else if frmOrders.actionType = 'editOrder' then
  begin
  	lblOrderNumber.Caption := 'Código do Pedido';
  	edtOrderNumber.Text := frmOrders.currentOrderId;
    dtpOrderDate.Date := GetOrderDate(frmOrders.currentOrderId);
    frmOrders.displayOrderItems(frmOrders.currentOrderId, frmOrdersMaintenance.fdqOrderItems);
    initialNumberOfItems := dbgOrderItems.DataSource.DataSet.RecordCount;
  end;

end;

end.
