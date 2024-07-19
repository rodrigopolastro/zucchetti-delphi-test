unit untOrders;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

	untPlaceOrder, Vcl.ExtCtrls;

type
  TfrmOrders = class(TForm)
    btnPrint: TButton;
    edtOrderNumber: TEdit;
    lblOrderNumber: TLabel;
    btnCreate: TButton;
    btnUpdate: TButton;
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
    procedure cbbOrderFieldChange(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure dbgOrdersCellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
  private

  public
    currentOrderId: String;
  end;

var
  frmOrders: TfrmOrders;
  test: Integer;

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


procedure TfrmOrders.btnCreateClick(Sender: TObject);
begin
	frmPlaceOrder.Show;
end;

procedure TfrmOrders.btnSearchClick(Sender: TObject);
begin
	fdqOrders.Open;
end;

procedure TfrmOrders.cbbOrderFieldChange(Sender: TObject);
var
	searchOptionIndex: Integer;
begin
	searchOptionIndex := frmOrders.cbbOrderField.ItemIndex;
	ShowHideSearchComponents(searchOptionIndex+1); //index starts at 0
end;

procedure TfrmOrders.dbgOrdersCellClick(Column: TColumn);
	var
  	itemsSQL: string;
begin
	currentOrderId := frmOrders.dbgOrders.Fields[0].AsString;
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

  fdqItems.SQL.Clear;
	fdqItems.SQL.Text := itemsSQL;
  fdqItems.ParamByName('orderId').AsString := currentOrderId;
	fdqItems.Open;
end;

procedure TfrmOrders.FormCreate(Sender: TObject);
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
      'o.order_date ';

  fdqItems.SQL.Clear;
	fdqOrders.SQL.Add(ordersSQL);
  fdqOrders.Open;
end;


end.
