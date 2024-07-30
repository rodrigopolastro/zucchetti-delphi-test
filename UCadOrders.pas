{*********************************************************************
 TESTE DE Aptidão - Delphi
 Desenv.    : Rodrigo Silva
 Criação    : 07/2024
 Descrição  : Criação ou alteração de um pedido e seus itens
*********************************************************************}

unit UCadOrders;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPickers, Vcl.ComCtrls,
  Vcl.StdCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.Oracle,
  FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids,

  UCadOrderItems,
  UConfirmDeletion;

type
  TFrm_CadOrders = class(TForm)
    E_OrderNumber: TEdit;
    L_OrderNumber: TLabel;
    L_OrderDate: TLabel;
    DTP_OrderDate: TDateTimePicker;
    L_Items: TLabel;
    B_Create: TButton;
    B_Update: TButton;
    B_Delete: TButton;
    DBG_OrderItems: TDBGrid;
    B_Save: TButton;
    B_Cancel: TButton;
    FDQ_OrderItems: TFDQuery;
    DS_OrderItems: TDataSource;
    FDQ_Queries: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure B_SaveClick(Sender: TObject);
    procedure B_CreateClick(Sender: TObject);
    procedure B_CancelClick(Sender: TObject);
    procedure DBG_OrderItemsCellClick(Column: TColumn);
    procedure B_UpdateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure B_DeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    iCurrentNumberOfItems: Integer;
    isCadOrdersOpen : Boolean;
    sSecActionType: String;
  end;

var
  Frm_CadOrders: TFrm_CadOrders;

implementation

{$R *.dfm}

uses
  UBackendFunctions,
	UPesqOrders;

procedure SetOrderItemsDBGLabels();
begin
  Frm_CadOrders.FDQ_OrderItems.FieldByName('ITN_codPDT')
    .DisplayLabel := 'Cód. Produto';

  Frm_CadOrders.FDQ_OrderItems.FieldByName('PDT_descri')
    .DisplayLabel := 'Descrição do Produto';

  Frm_CadOrders.FDQ_OrderItems.FieldByName('ITN_qtd')
  	.DisplayLabel := 'Quantidade';

  Frm_CadOrders.FDQ_OrderItems.FieldByName('PDT_preco')
    .DisplayLabel := 'Valor Unitário';

  Frm_CadOrders.FDQ_OrderItems.FieldByName('item_total_price')
  	.DisplayLabel := 'Valor Total';
end;

procedure RemoveOrderItemFromList(sProductId: String);
begin
	Frm_CadOrders.DBG_OrderItems.DataSource.DataSet.Delete;
end;

procedure AddItemsToOrder(sOrderId: String);
	var iCounter, iQuantity: Integer;
  var FDQ_Dataset: TDataSet;
  var sProductId: String;
begin
	FDQ_Dataset := Frm_CadOrders.FDQ_OrderItems;
	for iCounter := 1 to Frm_CadOrders.iCurrentNumberOfItems do
  begin
  	Frm_CadOrders.FDQ_OrderItems.RecNo := iCounter;
    sProductId := FDQ_Dataset.FieldByName('ITN_codPDT').AsString;
    iQuantity := FDQ_Dataset.FieldByName('ITN_qtd').AsInteger;

    if DoesOrderContainProduct(sOrderId, sProductId) then
      UpdateItemQuantity(sOrderId, sProductId, iQuantity)
    else
      InsertOrderItem(sOrderId, sProductId, iQuantity, Frm_CadOrders.FDQ_Queries);
  end;
end;

procedure TFrm_CadOrders.B_SaveClick(Sender: TObject);
	var sOrderId, sSaveMessage: String;
begin
	if Frm_PesqOrders.sActionType = 'createOrder' then
  begin
  	sOrderId := IntToStr(CreateOrder());
  	sSaveMessage := 'Pedido ' + sOrderId + ' registrado com sucesso!';
  end
  else if Frm_PesqOrders.sActionType = 'editOrder' then
  begin
  	sOrderId := Frm_PesqOrders.sCurrentOrderId;
    UpdateOrderDate(sOrderId);
  	sSaveMessage := 'Pedido ' + sOrderId + ' atualizado!';
  end;

  AddItemsToOrder(sOrderId);
  ShowMessage(sSaveMessage);
  Frm_PesqOrders.DBG_Orders.DataSource.DataSet.First;
  Frm_PesqOrders.DBG_Orders.DataSource.DataSet.Refresh;
  Frm_PesqOrders.sCurrentOrderId := Frm_PesqOrders.FDQ_Orders.FieldByName('PED_codigo').AsString;
  DisplayOrderItems(sOrderId, Frm_PesqOrders.FDQ_Items);
  Self.Close;
end;

procedure TFrm_CadOrders.B_CancelClick(Sender: TObject);
begin
	ShowMessage('Pedido cancelado.');
  Self.Close;
end;

procedure TFrm_CadOrders.B_CreateClick(Sender: TObject);
begin
  sSecActionType := 'createOrderItem';
	Frm_CadOrderItems.ShowModal;
end;

procedure TFrm_CadOrders.B_DeleteClick(Sender: TObject);
begin
	if Frm_PesqOrders.sCurrentItemProductId.IsEmpty then Exit();

  if (Frm_PesqOrders.sActionType = 'editOrder') and
     (DoesOrderContainProduct(Frm_PesqOrders.sCurrentOrderId, Frm_PesqOrders.sCurrentItemProductId)) then
  begin
    DeleteItem(Frm_PesqOrders.sCurrentOrderId, Frm_PesqOrders.sCurrentItemProductId);
    sSecActionType := 'deleteItem';
    Frm_ConfirmDeletion.ShowModal;
  end;
  RemoveOrderItemFromList(Frm_PesqOrders.sCurrentItemProductId);
  Frm_PesqOrders.sCurrentItemProductId := Frm_CadOrders.FDQ_OrderItems.FieldByName('ITN_codPDT').AsString;
  Dec(Frm_CadOrders.iCurrentNumberOfItems);
end;

procedure TFrm_CadOrders.B_UpdateClick(Sender: TObject);
begin
	if Frm_PesqOrders.sCurrentItemProductId.IsEmpty then Exit();

  sSecActionType := 'editOrderItem';
  DisplayItemInfo(
    Frm_PesqOrders.sCurrentOrderId,
    Frm_PesqOrders.sCurrentItemProductId
  );
  Frm_CadOrderItems.ShowModal;
end;

procedure TFrm_CadOrders.DBG_OrderItemsCellClick(Column: TColumn);
begin
  Frm_PesqOrders.sCurrentItemProductId := Frm_CadOrders.FDQ_OrderItems.FieldByName('ITN_codPDT').AsString;
end;

procedure TFrm_CadOrders.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  isCadOrdersOpen := False;

  Frm_PesqOrders.DBG_Orders.DataSource.DataSet.First;
  Frm_PesqOrders.sCurrentOrderId :=  Frm_PesqOrders.FDQ_Orders.FieldByName('PED_codigo').AsString;
end;

procedure TFrm_CadOrders.FormShow(Sender: TObject);
begin
  isCadOrdersOpen := True;

  if Frm_PesqOrders.sActionType = 'createOrder' then
	begin
  	L_OrderNumber.Caption := 'Novo Pedido';
    E_OrderNumber.Visible := False;
    DTP_OrderDate.Date := Now;
    DisplayOrderItems('', Frm_CadOrders.FDQ_OrderItems);
    iCurrentNumberOfItems := 0;
  end
	else if Frm_PesqOrders.sActionType = 'editOrder' then
  begin
  	L_OrderNumber.Caption := 'Nº Pedido';
    E_OrderNumber.Visible := True;
  	E_OrderNumber.Text := Frm_PesqOrders.sCurrentOrderId;
    DTP_OrderDate.Date := GetOrderDate(Frm_PesqOrders.sCurrentOrderId);
    DisplayOrderItems(Frm_PesqOrders.sCurrentOrderId, Frm_CadOrders.FDQ_OrderItems);
    iCurrentNumberOfItems := DBG_OrderItems.DataSource.DataSet.RecordCount;
  end;

//  SetOrderItemsDBGLabels();
  DBG_OrderItems.DataSource.DataSet.First;
  Frm_PesqOrders.sCurrentItemProductId := Frm_CadOrders.FDQ_OrderItems.FieldByName('ITN_codPDT').AsString;
end;

end.
