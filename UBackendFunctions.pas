unit UBackendFunctions;

interface

uses
  System.SysUtils, System.Variants, System.Classes,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Comp.DataSet;

function DoesOrderContainProduct(sOrderId, sProductId: String): Boolean;
procedure DisplayOrders(sWhereSQL, SHavingSQL: String);
procedure DisplayOrderItems(sOrderId: String; FDQ_QueryComponent: TFDQuery);
function  CreateOrder: Integer;
procedure DeleteItem(sOrderId, sProductId: String);
procedure DeleteOrder(sOrderId: String);
procedure InsertOrderItem(sOrderId, sProductId: String; iQuantity: Integer; FDQ_Query: TFDQuery);
procedure UpdateItemQuantity(sOrderId, sProductId: String; iQuantity: Integer);
procedure UpdateItemPriceOnList(sProductId: String; iQuantity: Integer; FDQ_QueryComponent: TFDQuery);
procedure UpdateOrderDate(sOrderId: String);
function GetOrderDate(sOrderId: String): TDate;
procedure DisplayItemInfo(sOrderId, sProductId: String);


implementation

uses
  UPesqOrders,
  UCadOrders,
  UCadOrderItems,
  UConfirmDeletion;

function DoesOrderContainProduct(sOrderId, sProductId: String): Boolean;
	var FDQ_Query: TFDQuery;
  begin
	FDQ_Query := Frm_CadOrderItems.FDQ_Queries;

  FDQ_Query.SQL.Clear;
  FDQ_Query.SQL.Text :=
  	'SELECT order_id FROM items ' +
    'WHERE order_id = :orderId AND product_id = :productId';
  FDQ_Query.ParamByName('orderId').AsString := sOrderId;
  FDQ_Query.ParamByName('productId').AsString := sProductId;
  FDQ_Query.Open;

  if FDQ_Query.RowsAffected = 1 then
    Result := True
  else
	  Result := False
end;

procedure DisplayOrders(sWhereSQL, sHavingSQL: String);
	var
  	sOrdersSQL: string;
begin
	sOrdersSQL :=
    'SELECT ' +
      'o.order_id AS "Nº do Pedido", ' +
      'o.order_date AS "Data do Pedido", ' +
      'SUM(i.quantity * p.price) AS "Valor Total" ' +
    'FROM orders o ' +
    'INNER JOIN items i ON i.order_id = o.order_id ' +
    'INNER JOIN products p ON i.product_id = p.product_id ' +
    ' ' + sWhereSQL + ' ' +
    'GROUP BY ' +
      'o.order_id, ' +
      'o.order_date ' +
    ' ' + sHavingSQL + ' ' +
    'ORDER BY o.order_id DESC ';


	Frm_PesqOrders.FDQ_Orders.SQL.Text := sOrdersSQL;
  Frm_PesqOrders.FDQ_Orders.Open;
end;

procedure DisplayOrderItems(sOrderId: String; FDQ_QueryComponent: TFDQuery);
	var
  	sItemsSQL: string;
begin
  sItemsSQL :=
  	'SELECT ' +
      'i.product_id AS "Cód. Produto", ' +
      'p.description AS "Descrição do Produto", ' +
      'i.quantity AS "Quantidade", ' +
      'p.price AS "Valor Unitário", ' +
      'i.quantity * p.price AS "Valor Total" '+
  	'FROM items i ' +
    'INNER JOIN products p ON p.product_id = i.product_id ' +
    'WHERE i.order_id = :orderId';

  FDQ_QueryComponent.SQL.Clear;
	FDQ_QueryComponent.SQL.Text := sItemsSQL;
  FDQ_QueryComponent.ParamByName('orderId').AsString := sOrderId;
	FDQ_QueryComponent.Open;
end;

function CreateOrder(): Integer;
	var sOrderDate : String;
begin
	sOrderDate := DateToStr(Frm_CadOrders.DTP_OrderDate.Date);

  Frm_CadOrders.FDQ_Queries.SQL.Clear;
  Frm_CadOrders.FDQ_Queries.SQL.Text :=
    'INSERT INTO orders(order_id, order_date) ' +
    'VALUES (seq_order_id.NEXTVAL, :orderDate)';

  Frm_CadOrders.FDQ_Queries.ParamByName('orderDate').AsString := sOrderDate;
  Frm_CadOrders.FDQ_Queries.ExecSQL;

  Result := Frm_PesqOrders.FDC_DatabaseConnection
  	.GetLastAutoGenValue('seq_order_id');
end;

procedure DeleteItem(sOrderId, sProductId: String);
begin
  Frm_CadOrders.FDQ_Queries.SQL.Clear;
  Frm_CadOrders.FDQ_Queries.SQL.Text :=
    'DELETE FROM items WHERE ' +
    'order_id = :orderId AND product_id = :productId';

  Frm_CadOrders.FDQ_Queries.ParamByName('orderId').AsString := sOrderId;
  Frm_CadOrders.FDQ_Queries.ParamByName('productId').AsString := sProductId;
  Frm_CadOrders.FDQ_Queries.ExecSQL;
end;

procedure DeleteOrder(sOrderId: String);
begin
	//Delete order items
	Frm_PesqOrders.FDQ_ActionQueries.SQL.Clear;
  Frm_PesqOrders.FDQ_ActionQueries.SQL.Text :=
    'DELETE FROM items WHERE order_id = :orderId';
  Frm_PesqOrders.FDQ_ActionQueries.ParamByName('orderId').AsString := sOrderId;
  Frm_PesqOrders.FDQ_ActionQueries.ExecSQL;

  //Delete order
  Frm_PesqOrders.FDQ_ActionQueries.SQL.Clear;
  Frm_PesqOrders.FDQ_ActionQueries.SQL.Text :=
    'DELETE FROM orders WHERE order_id = :orderId';
  Frm_PesqOrders.FDQ_ActionQueries.ParamByName('orderId').AsString := sOrderId;
  Frm_PesqOrders.FDQ_ActionQueries.ExecSQL;
end;

procedure InsertOrderItem(sOrderId, sProductId: String; iQuantity: Integer; FDQ_Query: TFDQuery);
begin
  FDQ_Query.SQL.Clear;
  FDQ_Query.SQL.Text :=
    'INSERT INTO items(order_id, product_id, quantity) ' +
    'VALUES (:orderId, :productId, :quantity)';

  FDQ_Query.ParamByName('orderId').AsString := sOrderId;
  FDQ_Query.ParamByName('productId').AsString := sProductId;
  FDQ_Query.ParamByName('quantity').AsInteger := iQuantity;
  FDQ_Query.ExecSQL;
end;

procedure UpdateItemQuantity(sOrderId, sProductId: String; iQuantity: Integer);
begin
  Frm_CadOrders.FDQ_Queries.SQL.Clear;
  Frm_CadOrders.FDQ_Queries.SQL.Text :=
    'UPDATE items SET quantity = :quantity ' +
    'WHERE order_id = :orderId AND product_id = :productId';

  Frm_CadOrders.FDQ_Queries.ParamByName('orderId').AsString := sOrderId;
  Frm_CadOrders.FDQ_Queries.ParamByName('productId').AsString := sProductId;
  Frm_CadOrders.FDQ_Queries.ParamByName('quantity').AsInteger := iQuantity;
  Frm_CadOrders.FDQ_Queries.ExecSQL;
end;

procedure UpdateItemPriceOnList(sProductId: String; iQuantity: Integer; FDQ_QueryComponent: TFDQuery);
	var dUnitPrice, dTotalPrice: Double;
begin
	Frm_CadOrderItems.FDQ_Queries.SQL.Text :=
  	'SELECT price FROM products WHERE product_id = :productId';
  Frm_CadOrderItems.FDQ_Queries.ParamByName('productId').AsString := sProductId;
  Frm_CadOrderItems.FDQ_Queries.Open;

  dUnitPrice := Frm_CadOrderItems.FDQ_Queries.FieldByName('price').AsFloat;
  dTotalPrice := iQuantity * dUnitPrice;

	FDQ_QueryComponent.Edit;
  FDQ_QueryComponent.FieldByName('Valor Unitário').AsString :=
  	FormatFloat('0.00', dUnitPrice);
  FDQ_QueryComponent.FieldByName('Valor Total').AsString :=
  	FormatFloat('0.00', dTotalPrice);
end;

procedure UpdateOrderDate(sOrderId: String);
	var sOrderDate: String;
begin
  sOrderDate := DateToStr(Frm_CadOrders.DTP_OrderDate.Date);

  Frm_CadOrders.FDQ_Queries.SQL.Clear;
  Frm_CadOrders.FDQ_Queries.SQL.Text :=
    'UPDATE orders SET order_date = :orderDate ' +
    'WHERE order_id = :orderId';

  Frm_CadOrders.FDQ_Queries.ParamByName('orderDate').AsString := sOrderDate;
  Frm_CadOrders.FDQ_Queries.ParamByName('orderId').AsString := sOrderId;
  Frm_CadOrders.FDQ_Queries.ExecSQL;
end;

function GetOrderDate(sOrderId: String): TDate;
begin
	Frm_CadOrders.FDQ_Queries.SQL.Text :=
  	'SELECT order_date FROM orders WHERE order_id = :orderId';
  Frm_CadOrders.FDQ_Queries.ParamByName('orderId').AsString
  	:= Frm_PesqOrders.sCurrentOrderId;

  Frm_CadOrders.FDQ_Queries.Open;
  Result := Frm_CadOrders.FDQ_Queries.FieldByName('order_date').AsDateTime;
end;

procedure DisplayItemInfo(sOrderId, sProductId: String);
  var sProductName: String;
  var iQuantity: Integer;
begin
	if DoesOrderContainProduct(sOrderId, sProductId) then
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
    Frm_CadOrderItems.FDQ_Queries.ParamByName('productId').AsString := sProductId;
    Frm_CadOrderItems.FDQ_Queries.ParamByName('orderId').AsString := sOrderId;
    Frm_CadOrderItems.FDQ_Queries.Open;

    sProductName := Frm_CadOrderItems.FDQ_Queries.FieldByName('productName').AsString;
    iQuantity := Frm_CadOrderItems.FDQ_Queries.FieldByName('quantity').AsInteger;
  end
  else
	begin
		sProductName := Frm_CadOrders.DBG_OrderItems.Fields[1].AsString;
    iQuantity := Frm_CadOrders.DBG_OrderItems.Fields[2].AsInteger;
  end;

  Frm_CadOrderItems.E_ProductCode.Text := sProductId;
  Frm_CadOrderItems.E_ProductName.Text := sProductName;
  Frm_CadOrderItems.E_Quantity.Text := IntToStr(iQuantity);
end;

end.
