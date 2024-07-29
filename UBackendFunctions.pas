unit UBackendFunctions;

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
  UPesqOrders,
  UCadOrders,
  UCadOrderItems,
  UConfirmDeletion;

function DoesOrderContainProduct(orderId, productId: String): Boolean;
var query: TFDQuery;
begin
	query := Frm_CadOrderItems.FDQ_Queries;

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


	Frm_PesqOrders.FDQ_Orders.SQL.Text := ordersSQL;
  Frm_PesqOrders.FDQ_Orders.Open;
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
	orderDate := DateToStr(Frm_CadOrders.DTP_OrderDate.Date);

  Frm_CadOrders.FDQ_Queries.SQL.Clear;
  Frm_CadOrders.FDQ_Queries.SQL.Text :=
    'INSERT INTO orders(order_id, order_date) ' +
    'VALUES (seq_order_id.NEXTVAL, :orderDate)';

  Frm_CadOrders.FDQ_Queries.ParamByName('orderDate').AsString := orderDate;
  Frm_CadOrders.FDQ_Queries.ExecSQL;

  Result := Frm_PesqOrders.FDC_DatabaseConnection
  	.GetLastAutoGenValue('seq_order_id');
end;

procedure DeleteItem(orderId, productId: String);
begin
  Frm_CadOrders.FDQ_Queries.SQL.Clear;
  Frm_CadOrders.FDQ_Queries.SQL.Text :=
    'DELETE FROM items WHERE ' +
    'order_id = :orderId AND product_id = :productId';

  Frm_CadOrders.FDQ_Queries.ParamByName('orderId').AsString := orderId;
  Frm_CadOrders.FDQ_Queries.ParamByName('productId').AsString := productId;
  Frm_CadOrders.FDQ_Queries.ExecSQL;
end;

procedure DeleteOrder(orderId: String);
begin
	//Delete order items
	Frm_PesqOrders.FDQ_ActionQueries.SQL.Clear;
  Frm_PesqOrders.FDQ_ActionQueries.SQL.Text :=
    'DELETE FROM items WHERE order_id = :orderId';
  Frm_PesqOrders.FDQ_ActionQueries.ParamByName('orderId').AsString := orderId;
  Frm_PesqOrders.FDQ_ActionQueries.ExecSQL;

  //Delete order
  Frm_PesqOrders.FDQ_ActionQueries.SQL.Clear;
  Frm_PesqOrders.FDQ_ActionQueries.SQL.Text :=
    'DELETE FROM orders WHERE order_id = :orderId';
  Frm_PesqOrders.FDQ_ActionQueries.ParamByName('orderId').AsString := orderId;
  Frm_PesqOrders.FDQ_ActionQueries.ExecSQL;
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
  Frm_CadOrders.FDQ_Queries.SQL.Clear;
  Frm_CadOrders.FDQ_Queries.SQL.Text :=
    'UPDATE items SET quantity = :quantity ' +
    'WHERE order_id = :orderId AND product_id = :productId';

  Frm_CadOrders.FDQ_Queries.ParamByName('orderId').AsString := orderId;
  Frm_CadOrders.FDQ_Queries.ParamByName('productId').AsString := productId;
  Frm_CadOrders.FDQ_Queries.ParamByName('quantity').AsInteger := quantity;
  Frm_CadOrders.FDQ_Queries.ExecSQL;
end;

procedure UpdateItemPriceOnList(productId: String; quantity: Integer; queryComponent: TFDQuery);
	var unitPrice, totalPrice: Real;
begin
	Frm_CadOrderItems.FDQ_Queries.SQL.Text :=
  	'SELECT price FROM products WHERE product_id = :productId';
  Frm_CadOrderItems.FDQ_Queries.ParamByName('productId').AsString := productId;
  Frm_CadOrderItems.FDQ_Queries.Open;

  unitPrice := Frm_CadOrderItems.FDQ_Queries.FieldByName('price').AsFloat;
  totalPrice := quantity * unitPrice;

//  queryComponent.FieldByName('Valor Unitário').AsString :=
	queryComponent.Edit;
  queryComponent.FieldByName('Valor Unitário').AsString :=
  FormatFloat('0.00', unitPrice);
  queryComponent.FieldByName('Valor Total').AsString :=
  FormatFloat('0.00', totalPrice);
end;

procedure UpdateOrderDate(orderId: String);
	var orderDate: String;
begin
  orderDate := DateToStr(Frm_CadOrders.DTP_OrderDate.Date);

  Frm_CadOrders.FDQ_Queries.SQL.Clear;
  Frm_CadOrders.FDQ_Queries.SQL.Text :=
    'UPDATE orders SET order_date = :orderDate ' +
    'WHERE order_id = :orderId';

  Frm_CadOrders.FDQ_Queries.ParamByName('orderDate').AsString := orderDate;
  Frm_CadOrders.FDQ_Queries.ParamByName('orderId').AsString := orderId;
  Frm_CadOrders.FDQ_Queries.ExecSQL;
end;

function GetOrderDate(orderId: String): TDate;
begin
	Frm_CadOrders.FDQ_Queries.SQL.Text :=
  	'SELECT order_date FROM orders WHERE order_id = :orderId';
  Frm_CadOrders.FDQ_Queries.ParamByName('orderId').AsString
  	:= Frm_PesqOrders.currentOrderId;

  Frm_CadOrders.FDQ_Queries.Open;
  Result := Frm_CadOrders.FDQ_Queries.FieldByName('order_date').AsDateTime;
end;

procedure DisplayItemInfo(orderId, productId: String);
  var productName: String;
  var quantity: Integer;
begin
	if DoesOrderContainProduct(orderId, productId) then
  begin
  	Frm_CadOrderItems.FDQ_Queries.SQL.Clear;
    Frm_CadOrderItems.FDQ_Queries.SQL.Text :=
      'SELECT ' +
      'p.description AS "productName", ' +
      'i.quantity AS "quantity" ' +
      'FROM items i ' +
      'INNER JOIN products p ON p.product_id = i.product_id ' +
      'WHERE i.product_id = :productId ' +
      'AND i.order_id = :orderId';
    Frm_CadOrderItems.FDQ_Queries.ParamByName('productId').AsString := productId;
    Frm_CadOrderItems.FDQ_Queries.ParamByName('orderId').AsString := orderId;
    Frm_CadOrderItems.FDQ_Queries.Open;

    productName := Frm_CadOrderItems.FDQ_Queries.FieldByName('productName').AsString;
    quantity := Frm_CadOrderItems.FDQ_Queries.FieldByName('quantity').AsInteger;
  end
  else
	begin
		productName := Frm_CadOrders.DBG_OrderItems.Fields[1].AsString;
    quantity := Frm_CadOrders.DBG_OrderItems.Fields[2].AsInteger;
  end;

  Frm_CadOrderItems.E_ProductCode.Text := productId;
  Frm_CadOrderItems.E_ProductName.Text := productName;
  Frm_CadOrderItems.E_Quantity.Text := IntToStr(quantity);
end;

end.
