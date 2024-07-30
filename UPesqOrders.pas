{*********************************************************************
 TESTE DE Aptidão - Delphi
 Desenv.    : Rodrigo Silva
 Criação    : 07/2024
 Descrição  : Listagem dos pedidos cadastrados e seus itens
*********************************************************************}

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
    DTP_OrderDate: TDateTimePicker;
    CB_ComparisonOperator: TComboBox;
    DBG_Orders: TDBGrid;
    L_Order: TLabel;
    CB_OrderBy: TComboBox;
    rbAsc: TRadioButton;
    rbDesc: TRadioButton;
    Panel1: TPanel;
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
    sCurrentOrderId: String;
    sCurrentItemProductId: String;
    sActionType: String;
  end;

var
  Frm_PesqOrders: TFrm_PesqOrders;

implementation

{$R *.dfm}

procedure SetOrdersDBGLabels();
begin
  Frm_PesqOrders.FDQ_Orders.FieldByName('PED_codigo')
    .DisplayLabel := 'Nº do Pedido';

  Frm_PesqOrders.FDQ_Orders.FieldByName('PED_data')
    .DisplayLabel := 'Data do Pedido';

  Frm_PesqOrders.FDQ_Orders.FieldByName('order_total_price')
  	.DisplayLabel := 'Valor Total';
end;

procedure SetItemsDBGLabels();
begin
  Frm_PesqOrders.FDQ_Items.FieldByName('ITN_codPDT')
    .DisplayLabel := 'Cód. Produto';

  Frm_PesqOrders.FDQ_Items.FieldByName('PDT_descri')
    .DisplayLabel := 'Descrição do Produto';

  Frm_PesqOrders.FDQ_Items.FieldByName('ITN_qtd')
  	.DisplayLabel := 'Quantidade';

  Frm_PesqOrders.FDQ_Items.FieldByName('PDT_preco')
    .DisplayLabel := 'Valor Unitário';

  Frm_PesqOrders.FDQ_Items.FieldByName('item_total_price')
  	.DisplayLabel := 'Valor Total';
end;

procedure ShowHideSearchComponents(sSearchField: String);
begin
  if sSearchField = 'Todos' then
  begin
    Frm_PesqOrders.E_SearchText.Visible := False;
    Frm_PesqOrders.DTP_OrderDate.Visible := False;
    Frm_PesqOrders.B_Search.Visible := False;
    Frm_PesqOrders.CB_ComparisonOperator.Visible := False;
    displayOrders('', '');
  end
  else if sSearchField = 'Data' then
  begin
    Frm_PesqOrders.E_SearchText.Visible := False;
    Frm_PesqOrders.DTP_OrderDate.Visible := True;
    Frm_PesqOrders.B_Search.Visible := True;
    Frm_PesqOrders.CB_ComparisonOperator.Visible := True;

    //Move to the edit position
    Frm_PesqOrders.DTP_OrderDate.Top := Frm_PesqOrders.E_SearchText.Top;
    Frm_PesqOrders.DTP_OrderDate.Left := Frm_PesqOrders.E_SearchText.Left;
  end
  else //'Valor Total' and 'N�mero'
  begin
    Frm_PesqOrders.E_SearchText.Visible := True;
    Frm_PesqOrders.DTP_OrderDate.Visible := False;
    Frm_PesqOrders.B_Search.Visible := True;
    Frm_PesqOrders.CB_ComparisonOperator.Visible := True;
  end;
end;

procedure DisplayFilteredOrders(sSearchField, sComparisonOperator: String);
	var sOrdersWhereSQL, sOrdersHavingSQL: String;
begin
  if sSearchField = 'Número' then
  begin
  	sOrdersWhereSQL  :=
    	'WHERE PED_codigo ' +
    	sComparisonOperator + ' ' +
      Frm_PesqOrders.E_SearchText.Text;
    sOrdersHavingSQL := '';
  end
	else if sSearchField = 'Valor Total' then
  begin
  	sOrdersWhereSQL := '';
    sOrdersHavingSQL :=
    	'HAVING SUM(ITN_qtd * PDT_preco) ' +
    	sComparisonOperator + ' ' +
      StringReplace(Frm_PesqOrders.E_SearchText.Text, ',', '.', []);
  end
  else if sSearchField = 'Data' then
  begin
  	sOrdersWhereSQL :=
    	'WHERE PED_data' +
    	sComparisonOperator + ' ' +
      QuotedStr(DateToStr(Frm_PesqOrders.DTP_OrderDate.Date));
    sOrdersHavingSQL := '';
  end;

  DisplayOrders(sOrdersWhereSQL, sOrdersHavingSQL);
end;

procedure TFrm_PesqOrders.B_CreateClick(Sender: TObject);
begin
	if sCurrentItemProductId.IsEmpty then
  begin
    sActionType := 'createOrder';
    sCurrentOrderId := '';
    Frm_CadOrders.ShowModal;
  end
  else
  begin
  	sActionType := 'createItem';
    Frm_CadOrderItems.ShowModal;
  end;
end;

procedure TFrm_PesqOrders.B_EditClick(Sender: TObject);
begin
	if sCurrentItemProductId.IsEmpty then
  begin
    sActionType := 'editOrder';
    Frm_CadOrders.ShowModal;
  end
  else
  begin
  	sActionType := 'editItem';
    Frm_CadOrderItems.ShowModal;
  end;
end;

procedure TFrm_PesqOrders.B_PrintClick(Sender: TObject);
begin
	Frm_GenerateReport.Show;
end;

procedure TFrm_PesqOrders.B_DeleteClick(Sender: TObject);
begin
	if sCurrentItemProductId.IsEmpty then
  begin
    sActionType := 'deleteOrder';
    Frm_ConfirmDeletion.ShowModal;
  end
  else
  begin
  	sActionType := 'deleteItem';
    Frm_ConfirmDeletion.ShowModal;
  end;
end;

procedure TFrm_PesqOrders.B_SearchClick(Sender: TObject);
	var sSearchField, sComparisonOperator: String;
begin
	sSearchField := CB_OrderField.Text;
  sComparisonOperator := CB_ComparisonOperator.Text;

  DisplayFilteredOrders(sSearchField, sComparisonOperator);

  FDQ_Orders.First;
  sCurrentOrderId := FDQ_Orders.FieldByName('PED_codigo').AsString;
  DisplayOrderItems(sCurrentOrderId, FDQ_Items);
end;

procedure TFrm_PesqOrders.CB_OrderFieldChange(Sender: TObject);
var
	sSearchField: String;
begin
	sSearchField := Frm_PesqOrders.CB_OrderField.Text;
  ShowHideSearchComponents(sSearchField);
end;

procedure TFrm_PesqOrders.DBG_ItemsCellClick(Column: TColumn);
begin
	sCurrentItemProductId := Frm_PesqOrders.FDQ_Items.FieldByName('ITN_codPDT').AsString;
end;

procedure TFrm_PesqOrders.DBG_OrdersCellClick(Column: TColumn);
begin
	sCurrentItemProductId := '';
	sCurrentOrderId := Frm_PesqOrders.FDQ_Orders.FieldByName('PED_codigo').AsString;
	DisplayOrderItems(sCurrentOrderId, Frm_PesqOrders.FDQ_Items);
end;

procedure TFrm_PesqOrders.dtsItemsUpdateData(Sender: TObject; Field: TField);
begin
//	DisplayOrders('', '');
end;

procedure TFrm_PesqOrders.FormCreate(Sender: TObject);
begin
	DisplayOrders('', '');
  SetOrdersDBGLabels();
  Frm_PesqOrders.DBG_Orders.DataSource.DataSet.First;
  sCurrentOrderId := Frm_PesqOrders.FDQ_Orders.FieldByName('PED_codigo').AsString;
  DisplayOrderItems(sCurrentOrderId, Frm_PesqOrders.FDQ_Items);
  SetItemsDBGLabels();
end;


end.
