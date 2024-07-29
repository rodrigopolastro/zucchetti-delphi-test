unit UCadOrderItems;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.Oracle,
  FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.ValEdit,

  UPesqProducts;

type
  TFrm_CadOrderItems = class(TForm)
    L_Title: TLabel;
    E_ProductCode: TEdit;
    B_ShowProducts: TButton;
    E_ProductName: TEdit;
    B_Save: TButton;
    L_ProductCode: TLabel;
    L_Quantity: TLabel;
    FDQ_Queries: TFDQuery;
    E_Quantity: TEdit;
    B_Cancel: TButton;
    procedure B_ShowProductsClick(Sender: TObject);
    procedure E_ProductCodeExit(Sender: TObject);
    procedure B_SaveClick(Sender: TObject);
    procedure B_CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    selectedProductId: String;
    productPrice: Real;
  end;

var
  Frm_CadOrderItems: TFrm_CadOrderItems;

implementation

uses
  UBackendFunctions,
	UCadOrders,
  UPesqOrders;

{$R *.dfm}

procedure ClearFormFields();
begin
  Frm_CadOrderItems.E_ProductCode.Text := '';
  Frm_CadOrderItems.E_ProductName.Text := '';
  Frm_CadOrderItems.E_Quantity.Text := '';
end;

function DoesListContainProduct(productId: String): Boolean;
	var i: Integer;
  var dataset: TDataSet;
begin
	dataset := Frm_CadOrders.FDQ_OrderItems;
	for i := 1 to Frm_CadOrders.currentNumberOfItems do
  begin
  	Frm_CadOrders.FDQ_OrderItems.RecNo := i;
    if dataset.FieldByName('Cód. Produto').AsString = productId then
      Result := True;
  end;

  Result := False;
end;

procedure AddItemToList();
  var productId, productName: String;
  var quantity: Integer;
  var unitPrice, totalPrice: Real;

  var dataSet: TFDQuery;
begin
  dataset := Frm_CadOrders.FDQ_OrderItems;

  productId := Frm_CadOrderItems.E_ProductCode.Text;
  productName := Frm_CadOrderItems.E_ProductName.Text;
  quantity := StrToInt(Frm_CadOrderItems.E_Quantity.Text);
  unitPrice := Frm_CadOrderItems.productPrice;
  totalPrice := quantity * unitPrice;

  //Store items in memory, only update if the order is saved
  dataset.CachedUpdates := True;

	dataset.Append;
  dataset.FieldByName('Cód. Produto').AsString := productId;
  dataset.FieldByName('Descrição do Produto').AsString := productName;
  dataset.FieldByName('Quantidade').AsString := IntToStr(quantity);
  dataset.FieldByName('Valor Unitário').AsString := FormatFloat('0.00', unitPrice);
  dataset.FieldByName('Valor Total').AsString := FormatFloat('0.00', totalPrice);
  Inc(Frm_CadOrders.currentNumberOfItems);
end;

procedure ModifyItemQuantityOnList(quantity: Integer; dataset: TFDQuery);
begin
  dataset.Edit;
  dataset.FieldByName('Quantidade').AsInteger := quantity;
end;

procedure DisplayProductName(productId: String);
var query: TFDQuery;
begin
	query := Frm_CadOrderItems.FDQ_Queries;

  query.SQL.Clear;
  query.SQL.Text :=
  	'SELECT description, price FROM products WHERE product_id = :productId';
  query.ParamByName('productId').AsString := productId;
  query.Open;

  if query.RowsAffected > 0 then
	begin
    Frm_CadOrderItems.E_ProductName.Text :=
    	query.FieldByName('description').AsString;
    Frm_CadOrderItems.productPrice :=
    	query.FieldByName('price').AsFloat;
  end
  else
	begin
    Frm_CadOrderItems.E_ProductName.Text := '';
    ShowMessage('Nenhum produto encontrado com o código ' + productId);
  end;
end;

procedure TFrm_CadOrderItems.B_CancelClick(Sender: TObject);
begin
  ClearFormFields();
	Self.Close;
end;

procedure TFrm_CadOrderItems.B_SaveClick(Sender: TObject);
  var orderId, productId: String;
  var quantity: Integer;
begin
  orderId := Frm_PesqOrders.currentOrderId;
  productId := Frm_CadOrderItems.E_ProductCode.Text;
  quantity := StrToInt(Frm_CadOrderItems.E_Quantity.Text);

  if Frm_CadOrders.isCadOrdersOpen then
  begin
    if Frm_CadOrders.secActionType = 'createOrderItem' then
      if DoesListContainProduct(productId) then
        ShowMessage('Esse produto já faz parte desse pedido!')
      else
      begin
      	AddItemToList();
        UpdateItemPriceOnList(productId, quantity, Frm_CadOrders.FDQ_OrderItems);
        Frm_PesqOrders.currentItemProductId := Frm_CadOrders.DBG_OrderItems.Fields[0].AsString;
      end
    else if Frm_CadOrders.secActionType = 'editOrderItem' then
    begin
      ModifyItemQuantityOnList(quantity, Frm_CadOrders.FDQ_OrderItems);
      UpdateItemPriceOnList(productId, quantity, Frm_CadOrders.FDQ_OrderItems);
      Self.Close;
    end
  end
  else if not Frm_CadOrders.isCadOrdersOpen then
  begin
    if Frm_PesqOrders.actionType = 'createItem' then
      if DoesOrderContainProduct(orderId, productId) then
        ShowMessage('Esse produto já faz parte desse pedido!')
      else
      begin
      	InsertOrderItem(orderId, productId, quantity, Frm_PesqOrders.FDQ_Items);
        DisplayOrderItems(orderId, Frm_PesqOrders.FDQ_Items);
      end
    else if Frm_PesqOrders.actionType = 'editItem' then
    begin
      UpdateItemQuantity(orderId, productId, quantity);
      ModifyItemQuantityOnList(quantity, Frm_PesqOrders.FDQ_Items);
      UpdateItemPriceOnList(productId, quantity, Frm_PesqOrders.FDQ_Items);
      Self.Close;
    end;
  end;

  ClearFormFields();
end;

procedure TFrm_CadOrderItems.B_ShowProductsClick(Sender: TObject);
begin
	Frm_PesqProducts.ShowModal;
end;

procedure TFrm_CadOrderItems.E_ProductCodeExit(Sender: TObject);
var productId: String;
begin
	productId := E_ProductCode.Text;
  if not productId.IsEmpty then
		DisplayProductName(productId);
end;

procedure TFrm_CadOrderItems.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
	Frm_PesqOrders.currentItemProductId := '';
end;

procedure TFrm_CadOrderItems.FormShow(Sender: TObject);
begin
  if (Frm_PesqOrders.actionType = 'createItem') or 
     (Frm_CadOrders.secActionType = 'createOrderItem') then
  begin
    ClearFormFields();
    E_ProductCode.ReadOnly := False;
    E_ProductName.ReadOnly := False;
  end
  else if (Frm_PesqOrders.actionType = 'editItem') or 
          (Frm_CadOrders.secActionType = 'editOrderItem') then
  begin
    DisplayItemInfo(
      Frm_PesqOrders.currentOrderId,
      Frm_PesqOrders.currentItemProductId
    );
    E_ProductCode.ReadOnly := True;
    E_ProductName.ReadOnly := True;
  end;
end;

end.
