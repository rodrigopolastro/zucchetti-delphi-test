﻿unit untOrderItemsMaintenance;

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
  TfrmOrderItemsMaintenance = class(TForm)
    lblTitle: TLabel;
    edtProductCode: TEdit;
    btnShowProducts: TButton;
    edtProductName: TEdit;
    btnSave: TButton;
    lblProductCode: TLabel;
    lblQuantity: TLabel;
    fdqQueries: TFDQuery;
    fdcDatabaseConnection: TFDConnection;
    edtQuantity: TEdit;
    btnCancel: TButton;
    procedure btnShowProductsClick(Sender: TObject);
    procedure edtProductCodeExit(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    selectedProductId: String;
    productPrice: Real;
  end;

var
  frmOrderItemsMaintenance: TfrmOrderItemsMaintenance;

implementation

uses
  untBackendFunctions,
	untOrdersMaintenance,
  untOrders;

{$R *.dfm}

procedure ClearFormFields();
begin
  frmOrderItemsMaintenance.edtProductCode.Text := '';
  frmOrderItemsMaintenance.edtProductName.Text := '';
  frmOrderItemsMaintenance.edtQuantity.Text := '';
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
end;

procedure ApplyChangesToList();
  var dataSet: TFDQuery;
begin
  dataset := frmOrdersMaintenance.fdqOrderItems;

  dataset.FieldByName('Cód.Produto').AsString := '777';
end;

procedure DisplayProductName(productId: String);
var query: TFDQuery;
begin
	query := frmOrderItemsMaintenance.fdqQueries;

  query.SQL.Clear;
  query.SQL.Text :=
  	'SELECT description FROM products WHERE product_id = :productId';
  query.ParamByName('productId').AsString := productId;
  query.Open;

  if query.RowsAffected > 0 then
	begin
    frmOrderItemsMaintenance.edtProductName.Text :=
    	query.FieldByName('description').AsString;
  end
  else
	begin
    frmOrderItemsMaintenance.edtProductName.Text := '';
    ShowMessage('Nenhum produto encontrado com o código ' + productId);
  end;
end;

procedure TfrmOrderItemsMaintenance.btnCancelClick(Sender: TObject);
begin
  ClearFormFields();
	Self.Close;
end;

procedure TfrmOrderItemsMaintenance.btnSaveClick(Sender: TObject);
  var orderId, productId: String;
  var quantity: Integer;
begin
  Inc(frmOrdersMaintenance.currentNumberOfItems);

  orderId := frmOrders.currentOrderId;
  productId := frmOrderItemsMaintenance.edtProductCode.Text;
  quantity := StrToInt(frmOrderItemsMaintenance.edtQuantity.Text);

  if frmOrders.actionType = 'createItem' then
    if DoesOrderContainProduct(orderId, productId) then
      ShowMessage('Esse produto já faz parte desse pedido!')
    else
    begin
      if frmOrdersMaintenance.isOrdersMaintenanceOpen then
        AddItemToList()
      else
      begin
        InsertOrderItem(orderId, productId, quantity);
        frmOrders.dbgItems.DataSource.DataSet.Refresh;
      end;
      ClearFormFields();
    end
  else if frmOrders.actionType = 'editItem' then
  begin
    if frmOrdersMaintenance.isOrdersMaintenanceOpen then
      ApplyChangesToList()
    else
//      UpdateItem(orderId, productId, quantity);
//    Self.Close();
    ClearFormFields();
  end;

end;

procedure TfrmOrderItemsMaintenance.btnShowProductsClick(Sender: TObject);
begin
	frmProducts.ShowModal;
end;

procedure TfrmOrderItemsMaintenance.edtProductCodeExit(Sender: TObject);
var productId: String;
begin
	productId := edtProductCode.Text;
  if not productId.IsEmpty then
		DisplayProductName(productId);
end;

procedure TfrmOrderItemsMaintenance.FormShow(Sender: TObject);
begin
  if frmOrders.actionType = 'createItem' then
  begin
    ClearFormFields();
    edtProductCode.ReadOnly := True;
    edtProductName.ReadOnly := True;
  end
  else if frmOrders.actionType = 'editItem' then
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
