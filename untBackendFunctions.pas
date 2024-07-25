unit untBackendFunctions;

interface

uses
  System.SysUtils, System.Variants, System.Classes,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Comp.DataSet;

function DoesOrderContainProduct(orderId, productId: String): Boolean;
procedure DisplayOrders(whereSQL, havingSQL: String);
procedure DisplayOrderItems(orderId: String; queryComponent: TFDQuery);
function  CreateOrder: Integer;
procedure DeleteItem(orderId, productId: String);
procedure DeleteOrder(orderId: String);
procedure InsertOrderItem(orderId, productId: String; quantity: Integer; query: TFDQuery);
procedure UpdateItemQuantity(orderId, productId: String; quantity: Integer);
procedure UpdateItemPriceOnList(productId: String; quantity: Integer; queryComponent: TFDQuery);
procedure UpdateOrderDate(orderId: String);
function GetOrderDate(orderId: String): TDate;
procedure DisplayItemInfo(orderId, productId: String);


implementation

uses
  untOrders,
  untOrdersMaintenance,
  untOrderItemsMaintenance,
  untConfirmDeletion;

function DoesOrderContainProduct(orderId, productId: String): Boolean;
var query: TFDQuery;
begin
	query := frmOrderItemsMaintenance.fdqQueries;

  query.SQL.Clear;
  query.SQL.Text :=
  	'SELECT order_id FROM items ' +
    'WHERE order_id = :orderId AND product_id = :productId';
  query.ParamByName('orderId').AsString := orderId;
  query.ParamByName('productId').AsString := productId;
  query.Open;

  if query.RowsAffected = 1 then
    Result := True
  else
	  Result := False

end;

procedure DisplayOrders(whereSQL, havingSQL: String);
	var
  	ordersSQL: string;
begin
	ordersSQL :=
    'SELECT ' +
      'o.order_id AS "Nº do Pedido", ' +
      'o.order_date AS "Data do Pedido", ' +
      'SUM(i.quantity * p.price) AS "Valor Total" ' +
    'FROM orders o ' +
    'INNER JOIN items i ON i.order_id = o.order_id ' +
    'INNER JOIN products p ON i.product_id = p.product_id ' +
    ' ' + whereSQL + ' ' +
    'GROUP BY ' +
      'o.order_id, ' +
      'o.order_date ' +
    ' ' + havingSQL + ' ' +
    'ORDER BY o.order_id DESC ';


	frmOrders.fdqOrders.SQL.Text := ordersSQL;
  frmOrders.fdqOrders.Open;
end;

procedure DisplayOrderItems(orderId: String; queryComponent: TFDQuery);
	var
  	itemsSQL: string;
begin
  itemsSQL :=
  	'SELECT ' +
      'i.product_id AS "Cód. Produto", ' +
      'p.description AS "Descrição do Produto", ' +
      'i.quantity AS "Quantidade", ' +
      'p.price AS "Valor Unitário", ' +
      'i.quantity * p.price AS "Valor Total" '+
  	'FROM items i ' +
    'INNER JOIN products p ON p.product_id = i.product_id ' +
    'WHERE i.order_id = :orderId';

  queryComponent.SQL.Clear;
	queryComponent.SQL.Text := itemsSQL;
  queryComponent.ParamByName('orderId').AsString := orderId;
	queryComponent.Open;
//  queryComponent.Refresh;
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

procedure DeleteItem(orderId, productId: String);
begin
  frmOrdersMaintenance.fdqQueries.SQL.Clear;
  frmOrdersMaintenance.fdqQueries.SQL.Text :=
    'DELETE FROM items WHERE ' +
    'order_id = :orderId AND product_id = :productId';

  frmOrdersMaintenance.fdqQueries.ParamByName('orderId').AsString := orderId;
  frmOrdersMaintenance.fdqQueries.ParamByName('productId').AsString := productId;
  frmOrdersMaintenance.fdqQueries.ExecSQL;
end;

procedure DeleteOrder(orderId: String);
begin
	//Delete order items
	frmConfirmDeletion.fdqQueries.SQL.Clear;
  frmConfirmDeletion.fdqQueries.SQL.Text :=
    'DELETE FROM items WHERE order_id = :orderId';
  frmConfirmDeletion.fdqQueries.ParamByName('orderId').AsString := orderId;
  frmConfirmDeletion.fdqQueries.ExecSQL;

  //Delete order
  frmConfirmDeletion.fdqQueries.SQL.Clear;
  frmConfirmDeletion.fdqQueries.SQL.Text :=
    'DELETE FROM orders WHERE order_id = :orderId';
  frmConfirmDeletion.fdqQueries.ParamByName('orderId').AsString := orderId;
  frmConfirmDeletion.fdqQueries.ExecSQL;
end;

procedure InsertOrderItem(orderId, productId: String; quantity: Integer; query: TFDQuery);
begin
  query.SQL.Clear;
  query.SQL.Text :=
    'INSERT INTO items(order_id, product_id, quantity) ' +
    'VALUES (:orderId, :productId, :quantity)';

  query.ParamByName('orderId').AsString := orderId;
  query.ParamByName('productId').AsString := productId;
  query.ParamByName('quantity').AsInteger := quantity;
  query.ExecSQL;
end;

procedure UpdateItemQuantity(orderId, productId: String; quantity: Integer);
begin
  frmOrdersMaintenance.fdqQueries.SQL.Clear;
  frmOrdersMaintenance.fdqQueries.SQL.Text :=
    'UPDATE items SET quantity = :quantity ' +
    'WHERE order_id = :orderId AND product_id = :productId';

  frmOrdersMaintenance.fdqQueries.ParamByName('orderId').AsString := orderId;
  frmOrdersMaintenance.fdqQueries.ParamByName('productId').AsString := productId;
  frmOrdersMaintenance.fdqQueries.ParamByName('quantity').AsInteger := quantity;
  frmOrdersMaintenance.fdqQueries.ExecSQL;
end;

procedure UpdateItemPriceOnList(productId: String; quantity: Integer; queryComponent: TFDQuery);
	var unitPrice, totalPrice: Real;
  var priceQuery : TFDQuery;
begin
//	query.SQL.Text :=
//  	'SELECT price FROM products WHERE product_id = :productId';
//  query.ParamByName('productId').AsString := productId;
//
//  query.Open;
//  unitPrice := frmOrdersMaintenance.fdqQueries.FieldByName('price').AsFloat;
//  totalPrice := quantity * unitPrice;
//
//  query.FieldByName('Valor Unitário').AsString :=
//  	FormatFloat('0.00', unitPrice);
//  query.FieldByName('Valor Total').AsString :=
//  FormatFloat('0.00', totalPrice);
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

function GetOrderDate(orderId: String): TDate;
begin
	frmOrdersMaintenance.fdqQueries.SQL.Text :=
  	'SELECT order_date FROM orders WHERE order_id = :orderId';
  frmOrdersMaintenance.fdqQueries.ParamByName('orderId').AsString
  	:= frmOrders.currentOrderId;

  frmOrdersMaintenance.fdqQueries.Open;
  Result := frmOrdersMaintenance.fdqQueries.FieldByName('order_date').AsDateTime;
end;

procedure DisplayItemInfo(orderId, productId: String);
  var productName: String;
  var quantity: Integer;
begin
	if DoesOrderContainProduct(orderId, productId) then
  begin
  	frmOrderItemsMaintenance.fdqQueries.SQL.Clear;
    frmOrderItemsMaintenance.fdqQueries.SQL.Text :=
      'SELECT ' +
      'p.description AS "productName", ' +
      'i.quantity AS "quantity" ' +
      'FROM items i ' +
      'INNER JOIN products p ON p.product_id = i.product_id ' +
      'WHERE i.product_id = :productId ' +
      'AND i.order_id = :orderId';
    frmOrderItemsMaintenance.fdqQueries.ParamByName('productId').AsString := productId;
    frmOrderItemsMaintenance.fdqQueries.ParamByName('orderId').AsString := orderId;
    frmOrderItemsMaintenance.fdqQueries.Open;

    productName := frmOrderItemsMaintenance.fdqQueries.FieldByName('productName').AsString;
    quantity := frmOrderItemsMaintenance.fdqQueries.FieldByName('quantity').AsInteger;
  end
  else
	begin
		productName := frmOrdersMaintenance.dbgOrderItems.Fields[1].AsString;
    quantity := frmOrdersMaintenance.dbgOrderItems.Fields[2].AsInteger;
  end;

  frmOrderItemsMaintenance.edtProductCode.Text := productId;
  frmOrderItemsMaintenance.edtProductName.Text := productName;
  frmOrderItemsMaintenance.edtQuantity.Text := IntToStr(quantity);
end;

end.
