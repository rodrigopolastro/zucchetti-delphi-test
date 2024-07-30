{*********************************************************************
 TESTE DE Aptidão - Delphi
 Desenv.    : Rodrigo Silva
 Criação    : 07/2024
 Descrição  : Cadastro de Itens de um pedido novo ou existente
*********************************************************************}

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

  UPesqProducts;

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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  Frm_CadOrderItems.E_ProductCode.Text := '';
  Frm_CadOrderItems.E_ProductName.Text := '';
  Frm_CadOrderItems.E_Quantity.Text := '';
end;

function DoesListContainProduct(sProductId: String): Boolean;
	var iCounter: Integer;
  var FDQ_dataset: TFDQuery;
begin
	FDQ_dataset := Frm_CadOrders.FDQ_OrderItems;
	for iCounter := 1 to Frm_CadOrders.iCurrentNumberOfItems do
  begin
  	Frm_CadOrders.FDQ_OrderItems.RecNo := iCounter;
    if FDQ_dataset.FieldByName('ITN_codPDT').AsString = sProductId then
      Result := True
    else
	    Result := False;
  end;
  Result := False;
end;

procedure AddItemToList();
  var sProductId, sProductName: String;
  var iQuantity: Integer;
  var dUnitPrice, dTotalPrice: Double;

  var FDQ_DataSet: TFDQuery;
begin
  FDQ_DataSet := Frm_CadOrders.FDQ_OrderItems;

  sProductId := Frm_CadOrderItems.E_ProductCode.Text;
  sProductName := Frm_CadOrderItems.E_ProductName.Text;
  iQuantity := StrToInt(Frm_CadOrderItems.E_Quantity.Text);
  dUnitPrice := Frm_CadOrderItems.productPrice;
  dTotalPrice := iQuantity * dUnitPrice;

  //Store items in memory, only update if the order is saved
  FDQ_DataSet.CachedUpdates := True;

	FDQ_DataSet.Append;
  FDQ_DataSet.FieldByName('ITN_codPDT').AsString := sProductId;
  FDQ_DataSet.FieldByName('PDT_descri').AsString := sProductName;
  FDQ_DataSet.FieldByName('ITN_qtd').AsString := IntToStr(iQuantity);
  FDQ_DataSet.FieldByName('PDT_preco').AsString := FormatFloat('0.00', dUnitPrice);
  FDQ_DataSet.FieldByName('item_total_price').AsString := FormatFloat('0.00', dTotalPrice);
  Inc(Frm_CadOrders.iCurrentNumberOfItems);
end;

procedure ModifyItemQuantityOnList(iQuantity: Integer; FDQ_Dataset: TFDQuery);
begin
  FDQ_Dataset.Edit;
  FDQ_Dataset.FieldByName('ITN_qtd').AsInteger := iQuantity;
end;

procedure DisplayProductName(sProductId: String);
var FDQ_Query: TFDQuery;
begin
	FDQ_Query := Frm_CadOrderItems.FDQ_Queries;

  FDQ_Query.SQL.Clear;
  FDQ_Query.SQL.Text :=
  	'SELECT PDT_descri, PDT_preco FROM produtos WHERE PDT_codigo = :productId';
  FDQ_Query.ParamByName('productId').AsString := sProductId;
  FDQ_Query.Open;

  if FDQ_Query.RowsAffected > 0 then
	begin
    Frm_CadOrderItems.E_ProductName.Text :=
    	FDQ_Query.FieldByName('PDT_descri').AsString;
    Frm_CadOrderItems.productPrice :=
    	FDQ_Query.FieldByName('PDT_preco').AsFloat;
  end
  else
	begin
    Frm_CadOrderItems.E_ProductName.Text := '';
    ShowMessage('Nenhum produto encontrado com o código ' + sProductId);
  end;
end;

procedure TFrm_CadOrderItems.B_CancelClick(Sender: TObject);
begin
  ClearFormFields();
	Self.Close;
end;

procedure TFrm_CadOrderItems.B_SaveClick(Sender: TObject);
  var sOrderId, sProductId: String;
  var iQuantity: Integer;
begin
  sOrderId := Frm_PesqOrders.sCurrentOrderId;
  sProductId := Frm_CadOrderItems.E_ProductCode.Text;
  iQuantity := StrToInt(Frm_CadOrderItems.E_Quantity.Text);

  if Frm_CadOrders.isCadOrdersOpen then
  begin
    if Frm_CadOrders.sSecActionType = 'createOrderItem' then
      if DoesListContainProduct(sProductId) then
        ShowMessage('Esse produto já faz parte desse pedido!')
      else
      begin
      	AddItemToList();
        UpdateItemPriceOnList(sProductId, iQuantity, Frm_CadOrders.FDQ_OrderItems);
        Frm_PesqOrders.sCurrentItemProductId := Frm_CadOrders.FDQ_OrderItems.FieldByName('ITN_codPDT').AsString;
      end
    else if Frm_CadOrders.sSecActionType = 'editOrderItem' then
    begin
      ModifyItemQuantityOnList(iQuantity, Frm_CadOrders.FDQ_OrderItems);
      UpdateItemPriceOnList(sProductId, iQuantity, Frm_CadOrders.FDQ_OrderItems);
      Self.Close;
    end
  end
  else if not Frm_CadOrders.isCadOrdersOpen then
  begin
    if Frm_PesqOrders.sActionType = 'createItem' then
      if DoesOrderContainProduct(sOrderId, sProductId) then
        ShowMessage('Esse produto já faz parte desse pedido!')
      else
      begin
      	InsertOrderItem(sOrderId, sProductId, iQuantity, Frm_PesqOrders.FDQ_Items);
        DisplayOrderItems(sOrderId, Frm_PesqOrders.FDQ_Items);
      end
    else if Frm_PesqOrders.sActionType = 'editItem' then
    begin
      UpdateItemQuantity(sOrderId, sProductId, iQuantity);
      ModifyItemQuantityOnList(iQuantity, Frm_PesqOrders.FDQ_Items);
      UpdateItemPriceOnList(sProductId, iQuantity, Frm_PesqOrders.FDQ_Items);
      Self.Close;
    end;
  end;

  ClearFormFields();
end;

procedure TFrm_CadOrderItems.B_ShowProductsClick(Sender: TObject);
begin
	Frm_PesqProducts.ShowModal;
end;

procedure TFrm_CadOrderItems.E_ProductCodeExit(Sender: TObject);
var sProductId: String;
begin
	sProductId := E_ProductCode.Text;
  if not sProductId.IsEmpty then
		DisplayProductName(sProductId);
end;

procedure TFrm_CadOrderItems.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
	Frm_PesqOrders.sCurrentItemProductId := '';
end;

procedure TFrm_CadOrderItems.FormShow(Sender: TObject);
begin
  if (Frm_PesqOrders.sActionType = 'createItem') or 
     (Frm_CadOrders.sSecActionType = 'createOrderItem') then
  begin
    ClearFormFields();
    E_ProductCode.ReadOnly := False;
    E_ProductName.ReadOnly := False;
  end
  else if (Frm_PesqOrders.sActionType = 'editItem') or 
          (Frm_CadOrders.sSecActionType = 'editOrderItem') then
  begin
    DisplayItemInfo(
      Frm_PesqOrders.sCurrentOrderId,
      Frm_PesqOrders.sCurrentItemProductId
    );
    E_ProductCode.ReadOnly := True;
    E_ProductName.ReadOnly := True;
  end;
end;

end.
