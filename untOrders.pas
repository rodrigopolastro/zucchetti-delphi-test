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
  untBackendFunctions,
	untOrdersMaintenance,
  untOrderItemsMaintenance;

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
    currentItemProductId: String;
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


procedure TfrmOrders.btnCreateClick(Sender: TObject);
begin
	if currentItemProductId.IsEmpty then
  begin
    actionType := 'createOrder';
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
	currentItemProductId := frmOrders.dbgItems.Fields[0].AsString;
end;

procedure TfrmOrders.dbgOrdersCellClick(Column: TColumn);
begin
	currentItemProductId := '';
	currentOrderId := frmOrders.dbgOrders.Fields[0].AsString;
	displayOrderItems(currentOrderId, frmOrders.fdqItems);
  edtTest.Text := currentOrderId;
end;

procedure TfrmOrders.FormCreate(Sender: TObject);
begin
	displayOrders();
  frmOrders.dbgOrders.DataSource.DataSet.First;
  currentOrderId := frmOrders.dbgOrders.Fields[0].AsString;
  displayOrderItems(currentOrderId, frmOrders.fdqItems);
end;


end.
