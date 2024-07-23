unit untOrders;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,

 	//Addittional Forms
	untOrdersMaintenance;

type
  TfrmOrders = class(TForm)
    btnPrint: TButton;
    edtOrderNumber: TEdit;
    lblOrderNumber: TLabel;
    btnCreate: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    fdcDatabaseConnection: TFDConnection;
    fdqOrders: TFDQuery;
    dtsOrders: TDataSource;
    dbgOrders: TDBGrid;
    btnSearch: TButton;
    cbbOrderField: TComboBox;
    dbgItems: TDBGrid;
    fdqItems: TFDQuery;
    dtsItems: TDataSource;
    edtTest: TEdit;
    fdqActionQueries: TFDQuery;
    procedure cbbOrderFieldChange(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure dbgOrdersCellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure dbgItemsCellClick(Column: TColumn);
    procedure btnEditClick(Sender: TObject);
  private

  public
    currentOrderId: String;
    currentItemId: String;
    actionType: String;
  end;

var
  frmOrders: TfrmOrders;

implementation

{$R *.dfm}

procedure ShowHideSearchComponents(optionNumber: Integer);
begin
	frmOrders.edtTest.Text := IntToStr(optionNumber);
//	case optionNumber of
//  	1: //search one order by id;
//    2: //search by value (greater, less than or equal to)
//    3: //search by date  (before, after or at specific date)
//  end;
end;


procedure displayOrders();
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

procedure displayOrderItems(orderId: String);
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

  frmOrders.fdqItems.SQL.Clear;
	frmOrders.fdqItems.SQL.Text := itemsSQL;
  frmOrders.fdqItems.ParamByName('orderId').AsString := orderId;
	frmOrders.fdqItems.Open;
end;

procedure TfrmOrders.btnCreateClick(Sender: TObject);
begin
	actionType := 'createOrder';
	frmOrdersMaintenance.ShowModal;
end;

procedure TfrmOrders.btnEditClick(Sender: TObject);
begin
	actionType := 'editOrder';
	frmOrdersMaintenance.ShowModal;
end;

procedure TfrmOrders.btnSearchClick(Sender: TObject);
begin
//	fdqOrders.Open;
end;

procedure TfrmOrders.cbbOrderFieldChange(Sender: TObject);
var
	searchOptionIndex: Integer;
begin
	searchOptionIndex := frmOrders.cbbOrderField.ItemIndex;
	ShowHideSearchComponents(searchOptionIndex+1); //index starts at 0
end;

procedure TfrmOrders.dbgItemsCellClick(Column: TColumn);
begin
	currentItemId := frmOrders.dbgItems.Fields[0].AsString;
end;

procedure TfrmOrders.dbgOrdersCellClick(Column: TColumn);
begin
	currentOrderId := frmOrders.dbgOrders.Fields[0].AsString;
	displayOrderItems(currentOrderId);
  edtTest.Text := currentOrderId;
end;

procedure TfrmOrders.FormCreate(Sender: TObject);
begin
	displayOrders();
  currentOrderId := frmOrders.dbgOrders.Fields[0].AsString;
  displayOrderItems(currentOrderId);
end;


end.
