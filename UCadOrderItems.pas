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

  untProducts;

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
  frmOrderItemsMaintenance.edtProductCode.Text := '';
  frmOrderItemsMaintenance.edtProductName.Text := '';
  frmOrderItemsMaintenance.edtQuantity.Text := '';
end;

function DoesListContainProduct(productId: String): Boolean;
	var i: Integer;
  var dataset: TDataSet;
begin
	dataset := frmOrdersMaintenance.fdqOrderItems;
	for i := 1 to frmOrdersMaintenance.currentNumberOfItems do
  begin
  	frmOrdersMaintenance.fdqOrderItems.RecNo := i;
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
  dataset := frmOrdersMaintenance.fdqOrderItems;

  productId := frmOrderItemsMaintenance.edtProductCode.Text;
  productName := frmOrderItemsMaintenance.edtProductName.Text;
  quantity := StrToInt(frmOrderItemsMaintenance.edtQuantity.Text);
  unitPrice := frmOrderItemsMaintenance.productPrice;
  totalPrice := quantity * unitPrice;

  //Store items in memory, only update if the order is saved
  dataset.CachedUpdates := True;

	dataset.Append;
  dataset.FieldByName('Cód. Produto').AsString := productId;
  dataset.FieldByName('Descrição do Produto').AsString := productName;
  dataset.FieldByName('Quantidade').AsString := IntToStr(quantity);
  dataset.FieldByName('Valor Unitário').AsString := FormatFloat('0.00', unitPrice);
  dataset.FieldByName('Valor Total').AsString := FormatFloat('0.00', totalPrice);
  Inc(frmOrdersMaintenance.currentNumberOfItems);
end;

procedure ModifyItemQuantityOnList(quantity: Integer; dataset: TFDQuery);
begin
  dataset.Edit;
  dataset.FieldByName('Quantidade').AsInteger := quantity;
end;

procedure DisplayProductName(productId: String);
var query: TFDQuery;
begin
	query := frmOrderItemsMaintenance.fdqQueries;

  query.SQL.Clear;
  query.SQL.Text :=
  	'SELECT description, price FROM products WHERE product_id = :productId';
  query.ParamByName('productId').AsString := productId;
  query.Open;

  if query.RowsAffected > 0 then
	begin
    frmOrderItemsMaintenance.edtProductName.Text :=
    	query.FieldByName('description').AsString;
    frmOrderItemsMaintenance.productPrice :=
    	query.FieldByName('price').AsFloat;
  end
  else
	begin
    frmOrderItemsMaintenance.edtProductName.Text := '';
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
  orderId := frmOrders.currentOrderId;
  productId := frmOrderItemsMaintenance.edtProductCode.Text;
  quantity := StrToInt(frmOrderItemsMaintenance.edtQuantity.Text);

  if frmOrdersMaintenance.isOrdersMaintenanceOpen then
  begin
    if frmOrdersMaintenance.secActionType = 'createOrderItem' then
      if DoesListContainProduct(productId) then
        ShowMessage('Esse produto já faz parte desse pedido!')
      else
      begin
      	AddItemToList();
        UpdateItemPriceOnList(productId, quantity, frmOrdersMaintenance.fdqOrderItems);
        frmOrders.currentItemProductId := frmOrdersMaintenance.dbgOrderItems.Fields[0].AsString;
      end
    else if frmOrdersMaintenance.secActionType = 'editOrderItem' then
    begin
      ModifyItemQuantityOnList(quantity, frmOrdersMaintenance.fdqOrderItems);
      UpdateItemPriceOnList(productId, quantity, frmOrdersMaintenance.fdqOrderItems);
      Self.Close;
    end
  end
  else if not frmOrdersMaintenance.isOrdersMaintenanceOpen then
  begin
    if frmOrders.actionType = 'createItem' then
      if DoesOrderContainProduct(orderId, productId) then
        ShowMessage('Esse produto já faz parte desse pedido!')
      else
      begin
      	InsertOrderItem(orderId, productId, quantity, frmOrders.fdqItems);
        DisplayOrderItems(orderId, frmOrders.fdqItems);
      end
    else if frmOrders.actionType = 'editItem' then
    begin
      UpdateItemQuantity(orderId, productId, quantity);
      ModifyItemQuantityOnList(quantity, frmOrders.fdqItems);
      UpdateItemPriceOnList(productId, quantity, frmOrders.fdqItems);
      Self.Close;
    end;
  end;

  ClearFormFields();
end;

procedure TFrm_CadOrderItems.B_ShowProductsClick(Sender: TObject);
begin
	frmProducts.ShowModal;
end;

procedure TFrm_CadOrderItems.E_ProductCodeExit(Sender: TObject);
var productId: String;
begin
	productId := edtProductCode.Text;
  if not productId.IsEmpty then
		DisplayProductName(productId);
end;

procedure TFrm_CadOrderItems.FormShow(Sender: TObject);
begin
  if (frmOrders.actionType = 'createItem') or 
     (frmOrdersMaintenance.secActionType = 'createOrderItem') then
  begin
    ClearFormFields();
    edtProductCode.ReadOnly := False;
    edtProductName.ReadOnly := False;
  end
  else if (frmOrders.actionType = 'editItem') or 
          (frmOrdersMaintenance.secActionType = 'editOrderItem') then
  begin
    DisplayItemInfo(
      frmOrders.currentOrderId,
      frmOrders.currentItemProductId
    );
    edtProductCode.ReadOnly := True;
    edtProductName.ReadOnly := True;
  end;
end;

end.
