unit UPesqOrders;
 
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
  UBackendFunctions,
	UCadOrders,
  UCadOrderItems,
  UConfirmDeletion,
  UGenerateReport;

type
  TFrm_PesqOrders = class(TForm)
    B_Print: TButton;
    E_SearchText: TEdit;
    L_FilterOrders: TLabel;
    B_Create: TButton;
    B_Edit: TButton;
    B_Delete: TButton;
    FDC_DatabaseConnection: TFDConnection;
    FDQ_Orders: TFDQuery;
    DS_Orders: TDataSource;
    B_Search: TButton;
    CB_OrderField: TComboBox;
    DBG_Items: TDBGrid;
    FDQ_Items: TFDQuery;
    DS_Items: TDataSource;
    FDQ_ActionQueries: TFDQuery;
    dtpOrderDate: TDateTimePicker;
    CB_ComparisonOperator: TComboBox;
    DBG_Orders: TDBGrid;
    L_Order: TLabel;
    CB_OrderBy: TComboBox;
    rbAsc: TRadioButton;
    rbDesc: TRadioButton;
    procedure CB_OrderFieldChange(Sender: TObject);
    procedure B_CreateClick(Sender: TObject);
    procedure DBG_OrdersCellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure B_SearchClick(Sender: TObject);
    procedure DBG_ItemsCellClick(Column: TColumn);
    procedure B_EditClick(Sender: TObject);
    procedure B_DeleteClick(Sender: TObject);
    procedure B_PrintClick(Sender: TObject);
    procedure dtsItemsUpdateData(Sender: TObject; Field: TField);
  private

  public
    currentOrderId: String;
    currentItemProductId: String;
    actionType: String;
  end;

var
  Frm_PesqOrders: TFrm_PesqOrders;

implementation

{$R *.dfm}

procedure ShowHideSearchComponents(searchField: String);
begin
  if searchField = 'Todos' then
  begin
    Frm_PesqOrders.E_SearchText.Visible := False;
    Frm_PesqOrders.dtpOrderDate.Visible := False;
    Frm_PesqOrders.B_Search.Visible := False;
    Frm_PesqOrders.CB_ComparisonOperator.Visible := False;
    displayOrders('', '');
  end
  else if searchField = 'Data' then
  begin
    Frm_PesqOrders.E_SearchText.Visible := False;
    Frm_PesqOrders.dtpOrderDate.Visible := True;
    Frm_PesqOrders.B_Search.Visible := True;
    Frm_PesqOrders.CB_ComparisonOperator.Visible := True;
  end
  else //'Valor Total' and 'N�mero'
  begin
    Frm_PesqOrders.E_SearchText.Visible := True;
    Frm_PesqOrders.dtpOrderDate.Visible := False;
    Frm_PesqOrders.B_Search.Visible := True;
    Frm_PesqOrders.CB_ComparisonOperator.Visible := True;
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
      Frm_PesqOrders.E_SearchText.Text;
    ordersHavingSQL := '';
  end
	else if searchField = 'Valor Total' then
  begin
  	ordersWhereSQL := '';
    ordersHavingSQL :=
    	'HAVING SUM(i.quantity * p.price) ' +
    	comparisonOperator + ' ' +
      StringReplace(Frm_PesqOrders.E_SearchText.Text, ',', '.', []);
  end
  else if searchField = 'Data' then
  begin
  	ordersWhereSQL :=
    	'WHERE o.order_date' +
    	comparisonOperator + ' ' +
      QuotedStr(DateToStr(Frm_PesqOrders.dtpOrderDate.Date));
    ordersHavingSQL := '';
  end;

  DisplayOrders(ordersWhereSQL, ordersHavingSQL);
end;

procedure TFrm_PesqOrders.B_CreateClick(Sender: TObject);
begin
	if currentItemProductId.IsEmpty then
  begin
    actionType := 'createOrder';
    currentOrderId := '';
    Frm_CadOrders.ShowModal;
  end
  else
  begin
  	actionType := 'createItem';
    Frm_CadOrderItems.ShowModal;
  end;
end;

procedure TFrm_PesqOrders.B_EditClick(Sender: TObject);
begin
	if currentItemProductId.IsEmpty then
  begin
    actionType := 'editOrder';
    Frm_CadOrders.ShowModal;
  end
  else
  begin
  	actionType := 'editItem';
    Frm_CadOrderItems.ShowModal;
  end;
end;

procedure TFrm_PesqOrders.B_PrintClick(Sender: TObject);
begin
showmessage(currentOrderId);
//	Frm_GenerateReport.Show;
end;

procedure TFrm_PesqOrders.B_DeleteClick(Sender: TObject);
begin
	if currentItemProductId.IsEmpty then
  begin
    actionType := 'deleteOrder';
    Frm_ConfirmDeletion.ShowModal;
  end
  else
  begin
  	actionType := 'deleteItem';
    Frm_ConfirmDeletion.ShowModal;
  end;
end;

procedure TFrm_PesqOrders.B_SearchClick(Sender: TObject);
	var searchField, comparisonOperator: String;
begin
	searchField := CB_OrderField.Text;
  comparisonOperator := CB_ComparisonOperator.Text;

  DisplayFilteredOrders(searchField, comparisonOperator);

  FDQ_Orders.First;
  currentOrderId := FDQ_Orders.Fields[0].AsString;
  displayOrderItems(currentOrderId, FDQ_Items);
end;

procedure TFrm_PesqOrders.CB_OrderFieldChange(Sender: TObject);
var
	searchField: String;
begin
	searchField := Frm_PesqOrders.CB_OrderField.Text;
  ShowHideSearchComponents(searchField);
end;

procedure TFrm_PesqOrders.DBG_ItemsCellClick(Column: TColumn);
begin
	currentItemProductId := Frm_PesqOrders.DBG_Items.Fields[0].AsString;
end;

procedure TFrm_PesqOrders.DBG_OrdersCellClick(Column: TColumn);
begin
	currentItemProductId := '';
	currentOrderId := Frm_PesqOrders.DBG_Orders.Fields[0].AsString;
	displayOrderItems(currentOrderId, Frm_PesqOrders.FDQ_Items);
end;

procedure TFrm_PesqOrders.dtsItemsUpdateData(Sender: TObject; Field: TField);
begin
//	DisplayOrders('', '');
end;

procedure TFrm_PesqOrders.FormCreate(Sender: TObject);
begin
	dtpOrderDate.Top := E_SearchText.Top;
  dtpOrderDate.Left := E_SearchText.Left;

	displayOrders('', '');
  Frm_PesqOrders.DBG_Orders.DataSource.DataSet.First;
  currentOrderId := Frm_PesqOrders.DBG_Orders.Fields[0].AsString;
  displayOrderItems(currentOrderId, Frm_PesqOrders.FDQ_Items);
end;


end.
