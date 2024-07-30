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
  	'SELECT ITN_PED_codigo FROM itens ' +
    'WHERE ITN_PED_codigo = :orderId AND ITN_PDT_codigo = :productId';
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
      'PED_codigo, ' +
      'PED_data, ' +
      'SUM(ITN_qtd * PDT_preco) order_total_price ' +
    'FROM pedidos ' +
    'INNER JOIN itens ON ITN_PED_codigo = PED_codigo ' +
    'INNER JOIN produtos ON ITN_PDT_codigo = PDT_codigo ' +
    ' ' + sWhereSQL + ' ' +
    'GROUP BY ' +
      'PED_codigo, ' +
      'PED_data ' +
    ' ' + sHavingSQL + ' ' +
    'ORDER BY PED_codigo DESC ';


	Frm_PesqOrders.FDQ_Orders.SQL.Text := sOrdersSQL;
  Frm_PesqOrders.FDQ_Orders.Open;
end;

procedure DisplayOrderItems(sOrderId: String; FDQ_QueryComponent: TFDQuery);
	var
  	sItemsSQL: string;
begin
  sItemsSQL :=
  	'SELECT ' +
      'ITN_PDT_codigo, ' +
      'PDT_descri, ' +
      'ITN_qtd, ' +
      'PDT_preco, ' +
      'ITN_qtd * PDT_preco item_total_price '+
  	'FROM itens ' +
    'INNER JOIN produtos ON PDT_codigo = ITN_PDT_codigo ' +
    'WHERE ITN_PED_codigo = :orderId';

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
    'INSERT INTO pedidos(PED_codigo, PED_data) ' +
    'VALUES (SEQ_Pedidos.NEXTVAL, :orderDate)';

  Frm_CadOrders.FDQ_Queries.ParamByName('orderDate').AsString := sOrderDate;
  Frm_CadOrders.FDQ_Queries.ExecSQL;

  Result := Frm_PesqOrders.FDC_DatabaseConnection
  	.GetLastAutoGenValue('SEQ_Pedidos');
end;

procedure DeleteItem(sOrderId, sProductId: String);
begin
  Frm_CadOrders.FDQ_Queries.SQL.Clear;
  Frm_CadOrders.FDQ_Queries.SQL.Text :=
    'DELETE FROM itens WHERE ' +
    'ITN_PED_codigo = :orderId AND ITN_PDT_codigo = :productId';

  Frm_CadOrders.FDQ_Queries.ParamByName('orderId').AsString := sOrderId;
  Frm_CadOrders.FDQ_Queries.ParamByName('productId').AsString := sProductId;
  Frm_CadOrders.FDQ_Queries.ExecSQL;
end;

procedure DeleteOrder(sOrderId: String);
begin
	//Delete order itens
	Frm_PesqOrders.FDQ_ActionQueries.SQL.Clear;
  Frm_PesqOrders.FDQ_ActionQueries.SQL.Text :=
    'DELETE FROM itens WHERE ITN_PED_codigo = :orderId';
  Frm_PesqOrders.FDQ_ActionQueries.ParamByName('orderId').AsString := sOrderId;
  Frm_PesqOrders.FDQ_ActionQueries.ExecSQL;

  //Delete order
  Frm_PesqOrders.FDQ_ActionQueries.SQL.Clear;
  Frm_PesqOrders.FDQ_ActionQueries.SQL.Text :=
    'DELETE FROM pedidos WHERE PED_codigo = :orderId';
  Frm_PesqOrders.FDQ_ActionQueries.ParamByName('orderId').AsString := sOrderId;
  Frm_PesqOrders.FDQ_ActionQueries.ExecSQL;
end;

procedure InsertOrderItem(sOrderId, sProductId: String; iQuantity: Integer; FDQ_Query: TFDQuery);
begin
  FDQ_Query.SQL.Clear;
  FDQ_Query.SQL.Text :=
    'INSERT INTO itens(ITN_PED_codigo, ITN_PDT_codigo, ITN_qtd) ' +
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
    'UPDATE itens SET ITN_qtd = :quantity ' +
    'WHERE ITN_PED_codigo = :orderId AND ITN_PDT_codigo = :productId';

  Frm_CadOrders.FDQ_Queries.ParamByName('orderId').AsString := sOrderId;
  Frm_CadOrders.FDQ_Queries.ParamByName('productId').AsString := sProductId;
  Frm_CadOrders.FDQ_Queries.ParamByName('quantity').AsInteger := iQuantity;
  Frm_CadOrders.FDQ_Queries.ExecSQL;
end;

procedure UpdateItemPriceOnList(sProductId: String; iQuantity: Integer; FDQ_QueryComponent: TFDQuery);
	var dUnitPrice, dTotalPrice: Double;
begin
	Frm_CadOrderItems.FDQ_Queries.SQL.Text :=
  	'SELECT PDT_preco FROM produtos WHERE PDT_codigo = :productId';
  Frm_CadOrderItems.FDQ_Queries.ParamByName('productId').AsString := sProductId;
  Frm_CadOrderItems.FDQ_Queries.Open;

  dUnitPrice := Frm_CadOrderItems.FDQ_Queries.FieldByName('PDT_preco').AsFloat;
  dTotalPrice := iQuantity * dUnitPrice;

	FDQ_QueryComponent.Edit;
  	FormatFloat('0.00', dUnitPrice);
  	FormatFloat('0.00', dTotalPrice);
end;

procedure UpdateOrderDate(sOrderId: String);
	var sOrderDate: String;
begin
  sOrderDate := DateToStr(Frm_CadOrders.DTP_OrderDate.Date);

  Frm_CadOrders.FDQ_Queries.SQL.Clear;
  Frm_CadOrders.FDQ_Queries.SQL.Text :=
    'UPDATE pedidos SET PED_data = :orderDate ' +
    'WHERE PED_codigo = :orderId';

  Frm_CadOrders.FDQ_Queries.ParamByName('orderDate').AsString := sOrderDate;
  Frm_CadOrders.FDQ_Queries.ParamByName('orderId').AsString := sOrderId;
  Frm_CadOrders.FDQ_Queries.ExecSQL;
end;

function GetOrderDate(sOrderId: String): TDate;
begin
	Frm_CadOrders.FDQ_Queries.SQL.Text :=
  	'SELECT PED_data FROM pedidos WHERE PED_codigo = :orderId';
  Frm_CadOrders.FDQ_Queries.ParamByName('orderId').AsString
  	:= Frm_PesqOrders.sCurrentOrderId;

  Frm_CadOrders.FDQ_Queries.Open;
  Result := Frm_CadOrders.FDQ_Queries.FieldByName('PED_data').AsDateTime;
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
      'PDT_descri, ' +
      'ITN_qtd ' +
      'FROM itens ' +
      'INNER JOIN produtos ON PDT_codigo = ITN_PDT_codigo ' +
      'WHERE ITN_PDT_codigo = :productId ' +
      'AND ITN_PED_codigo = :orderId';
    Frm_CadOrderItems.FDQ_Queries.ParamByName('productId').AsString := sProductId;
    Frm_CadOrderItems.FDQ_Queries.ParamByName('orderId').AsString := sOrderId;
    Frm_CadOrderItems.FDQ_Queries.Open;

    sProductName := Frm_CadOrderItems.FDQ_Queries.FieldByName('PDT_descri').AsString;
    iQuantity := Frm_CadOrderItems.FDQ_Queries.FieldByName('ITN_qtd').AsInteger;
  end
  else
  begin
    sProductName := Frm_CadOrders.FDQ_OrderItems.FieldByName('PDT_descri').AsString;
    iQuantity := Frm_CadOrders.FDQ_OrderItems.FieldByName('ITN_qtd').AsInteger;
  end;

  Frm_CadOrderItems.E_ProductCode.Text := sProductId;
  Frm_CadOrderItems.E_ProductName.Text := sProductName;
  Frm_CadOrderItems.E_Quantity.Text := IntToStr(iQuantity);
end;

end.
