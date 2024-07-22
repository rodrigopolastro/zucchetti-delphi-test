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

  untProductsList;

type
  TfrmOrderItemsMaintenance = class(TForm)
    lblTitle: TLabel;
    edtProductCode: TEdit;
    btnShowProducts: TButton;
    edtProductName: TEdit;
    btnSave: TButton;
    lblProductCode: TLabel;
    lblQuantity: TLabel;
    edtQuantity: TEdit;
    btnCancel: TButton;
    fdqQueries: TFDQuery;
    fdcDatabaseConnection: TFDConnection;
    Edit1: TEdit;
    procedure btnShowProductsClick(Sender: TObject);
    procedure edtProductCodeExit(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    selectedProductId: String;
  end;

var
  frmOrderItemsMaintenance: TfrmOrderItemsMaintenance;

implementation

uses
	untOrdersMaintenance;

{$R *.dfm}

//function IsOrderCreated();
//var query : TFDQuery;
//begin
//	query := frmOrderItemsMaintenance.fdqQueries;
//
//  query.SQL.Clear;
//  query.SQL.Text :=
//  	'INSERT INTO Orders (order_id, product_id, quantity) ' +
//    'VALUES(:orderId, :productId, :quantity)';
//
//  orderId   := frmOrdersMaintenance.edtOrderNumber.Text;
//  productId := frmOrderItemsMaintenance.edtProductCode.Text;
//  quantity  := frmOrderItemsMaintenance.edtQuantity.Text;
//
//
//  query.ParamByName('orderId').AsString := orderId;
//  query.ParamByName('productId').AsString := productId;
//  query.ParamByName('quantity').AsString := quantity;
//
//end;

procedure CreateItem();
  var orderId, productId, quantity: String;
  var query : TFDQuery;
begin
	query := frmOrderItemsMaintenance.fdqQueries;

  query.SQL.Clear;
  query.SQL.Text :=
  	'INSERT INTO items (order_id, product_id, quantity) ' +
    'VALUES(:orderId, :productId, :quantity)';

  orderId   := frmOrdersMaintenance.edtOrderNumber.Text;
  productId := frmOrderItemsMaintenance.edtProductCode.Text;
  quantity  := frmOrderItemsMaintenance.edtQuantity.Text;


  query.ParamByName('orderId').AsString := orderId;
  query.ParamByName('productId').AsString := productId;
  query.ParamByName('quantity').AsString := quantity;
end;

procedure GetProductName(productId: String);
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
    ShowMessage('Nenhum produto encontrado com o c�digo' + productId);

  end;
 	frmOrderItemsMaintenance.fdqQueries.RowsAffected
end;

procedure TfrmOrderItemsMaintenance.btnSaveClick(Sender: TObject);
begin
//	if not IsOrderCreated then
//  	CreateEmptyOrder();

	CreateItem();
end;

procedure TfrmOrderItemsMaintenance.btnShowProductsClick(Sender: TObject);
begin
	frmProductsList.ShowModal;
end;

procedure TfrmOrderItemsMaintenance.edtProductCodeExit(Sender: TObject);
var productId: String;
begin
	productId := edtProductCode.Text;
  if not productId.IsEmpty then
		GetProductName(productId);
end;

end.
