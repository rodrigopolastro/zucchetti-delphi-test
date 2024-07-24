unit untBackendFunctions;

interface

uses
  System.SysUtils, System.Variants, System.Classes,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Comp.DataSet;

procedure DisplayOrders;
procedure DisplayOrderItems(orderId: String; queryComponent: TFDQuery);
function  CreateOrder: Integer;
procedure InsertOrderItem(orderId, productId: String; quantity: Integer);
procedure UpdateOrderDate(orderId: String);
function GetOrderDate(orderId: String): TDate;

implementation

uses
  untOrders,
  untOrdersMaintenance,
  untOrderItemsMaintenance;

procedure DisplayOrders();
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
    'GROUP BY ' +
      'o.order_id, ' +
      'o.order_date ' +
    'ORDER BY o.order_id DESC';

  frmOrders.fdqItems.SQL.Clear;
	frmOrders.fdqOrders.SQL.Add(ordersSQL);
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
  queryComponent.Refresh;
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

end.
