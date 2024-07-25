unit untOrders;
 
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.ComCtrls,

 	//Addittional Forms
  untBackendFunctions,
	untOrdersMaintenance,
  untOrderItemsMaintenance,
  untConfirmDeletion,
  untGenerateReport;

type
  TfrmOrders = class(TForm)
    btnPrint: TButton;
    edtSearchText: TEdit;
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
    fdqActionQueries: TFDQuery;
    dtpOrderDate: TDateTimePicker;
    cbbComparisonOperator: TComboBox;
    procedure cbbOrderFieldChange(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure dbgOrdersCellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure dbgItemsCellClick(Column: TColumn);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private

  public
    currentOrderId: String;
    currentItemProductId: String;
    actionType: String;
  end;

var
  frmOrders: TfrmOrders;

implementation

{$R *.dfm}

procedure ShowHideSearchComponents(searchField: String);
begin
  if searchField = 'Todos' then
  begin
    frmOrders.edtSearchText.Visible := False;
    frmOrders.dtpOrderDate.Visible := False;
    frmOrders.btnSearch.Visible := False;
    frmOrders.cbbComparisonOperator.Visible := False;
    displayOrders('', '');
  end
  else if searchField = 'Data' then
  begin
    frmOrders.edtSearchText.Visible := False;
    frmOrders.dtpOrderDate.Visible := True;
    frmOrders.btnSearch.Visible := True;
    frmOrders.cbbComparisonOperator.Visible := True;
  end
  else //'Valor Total' and 'N�mero'
  begin
    frmOrders.edtSearchText.Visible := True;
    frmOrders.dtpOrderDate.Visible := False;
    frmOrders.btnSearch.Visible := True;
    frmOrders.cbbComparisonOperator.Visible := True;
  end;
end;

procedure DisplayFilteredOrders(searchField, comparisonOperator: String);
	var ordersWhereSQL, ordersHavingSQL: String;
begin
  if searchField = 'Número' then
  begin
  	ordersWhereSQL  :=
    	'WHERE o.order_id ' +
    	comparisonOperator + ' ' +
      frmOrders.edtSearchText.Text;
    ordersHavingSQL := '';
  end
	else if searchField = 'Valor Total' then
  begin
  	ordersWhereSQL := '';
    ordersHavingSQL :=
    	'HAVING SUM(i.quantity * p.price) ' +
    	comparisonOperator + ' ' +
      StringReplace(frmOrders.edtSearchText.Text, ',', '.', []);
  end
  else if searchField = 'Data' then
  begin
  	ordersWhereSQL :=
    	'WHERE o.order_date' +
    	comparisonOperator + ' ' +
      QuotedStr(DateToStr(frmOrders.dtpOrderDate.Date));
    ordersHavingSQL := '';
  end;

  DisplayOrders(ordersWhereSQL, ordersHavingSQL);
end;

procedure TfrmOrders.btnCreateClick(Sender: TObject);
begin
	if currentItemProductId.IsEmpty then
  begin
    actionType := 'createOrder';
    currentOrderId := '';
    frmOrdersMaintenance.ShowModal;
  end
  else
  begin
  	actionType := 'createItem';
    frmOrderItemsMaintenance.ShowModal;
  end;
end;

procedure TfrmOrders.btnEditClick(Sender: TObject);
begin
	if currentItemProductId.IsEmpty then
  begin
    actionType := 'editOrder';
    frmOrdersMaintenance.ShowModal;
  end
  else
  begin
  	actionType := 'editItem';
    frmOrderItemsMaintenance.ShowModal;
  end;
end;

procedure TfrmOrders.btnPrintClick(Sender: TObject);
begin
	frmGenerateReport.Show;
end;

procedure TfrmOrders.btnDeleteClick(Sender: TObject);
begin
	if currentItemProductId.IsEmpty then
  begin
    actionType := 'deleteOrder';
    frmConfirmDeletion.ShowModal;
  end
  else
  begin
  	actionType := 'deleteItem';
    frmConfirmDeletion.ShowModal;
  end;
end;

procedure TfrmOrders.btnSearchClick(Sender: TObject);
	var searchField, comparisonOperator: String;
begin
	searchField := cbbOrderField.Text;
  comparisonOperator := cbbComparisonOperator.Text;

  DisplayFilteredOrders(searchField, comparisonOperator);

  fdqOrders.First;
  currentOrderId := fdqOrders.Fields[0].AsString;
  displayOrderItems(currentOrderId, fdqItems);
end;

procedure TfrmOrders.cbbOrderFieldChange(Sender: TObject);
var
	searchField: String;
begin
	searchField := frmOrders.cbbOrderField.Text;
  ShowHideSearchComponents(searchField);
end;

procedure TfrmOrders.dbgItemsCellClick(Column: TColumn);
begin
	currentItemProductId := frmOrders.dbgItems.Fields[0].AsString;
end;

procedure TfrmOrders.dbgOrdersCellClick(Column: TColumn);
begin
	currentItemProductId := '';
	currentOrderId := frmOrders.dbgOrders.Fields[0].AsString;
	displayOrderItems(currentOrderId, frmOrders.fdqItems);
end;

procedure TfrmOrders.FormCreate(Sender: TObject);
begin
	dtpOrderDate.Top := edtSearchText.Top;
  dtpOrderDate.Left := edtSearchText.Left;

	displayOrders('', '');
  frmOrders.dbgOrders.DataSource.DataSet.First;
  currentOrderId := frmOrders.dbgOrders.Fields[0].AsString;
  displayOrderItems(currentOrderId, frmOrders.fdqItems);
end;


end.
