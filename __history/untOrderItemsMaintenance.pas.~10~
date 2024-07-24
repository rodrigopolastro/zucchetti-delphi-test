unit untOrderItemsMaintenance;

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
    here: TEdit;
    procedure btnShowProductsClick(Sender: TObject);
    procedure edtProductCodeExit(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
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
	Self.Close;
end;

procedure TfrmOrderItemsMaintenance.btnSaveClick(Sender: TObject);
begin
//	CreateItem();
	if (frmOrders.actionType = 'createOrder') or
  	 (frmOrders.actionType = 'editOrder') then
    InsertOrderItem(
      frmOrders.currentOrderId,
      frmOrderItemsMaintenance.edtProductCode.Text,
      StrToInt(frmOrderItemsMaintenance.edtProductName.Text)
    )
  else
		AddItemToList();

  ClearFormFields();
//  frmOrdersMaintenance.dtsOrderItems.DataSet.Refresh;
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

end.
