unit untOrdersMaintenance;

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

  untOrderItemsMaintenance;

type
  TfrmOrdersMaintenance = class(TForm)
    edtOrderNumber: TEdit;
    lblOrderNumber: TLabel;
    lblOrderDate: TLabel;
    dtpOrderDate: TDateTimePicker;
    lblItens: TLabel;
    btnCreate: TButton;
    btnUpdate: TButton;
    btnDelete: TButton;
    DBGrid1: TDBGrid;
    btnSave: TButton;
    btnCancel: TButton;
    fdcDatabaseConnection: TFDConnection;
    fdqOrderItems: TFDQuery;
    dtsOrderItems: TDataSource;
    fdqQueries: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOrdersMaintenance: TfrmOrdersMaintenance;

implementation

{$R *.dfm}

uses
	untOrders;


procedure CommitChanges();
begin
  frmOrdersMaintenance.fdqQueries.SQL.Clear;
	frmOrdersMaintenance.fdqQueries.SQL.Text := 'COMMIT';
  frmOrdersMaintenance.fdqQueries.ExecSQL;
end;

procedure RollbackChanges();
begin
  frmOrdersMaintenance.fdqQueries.SQL.Clear;
	frmOrdersMaintenance.fdqQueries.SQL.Text := 'ROLLBACK';
  frmOrdersMaintenance.fdqQueries.ExecSQL;
end;

procedure displayOrderItems(orderId: String);
	var itemsSQL: string;
  var query: TFDQuery;
begin
  query := frmOrdersMaintenance.fdqOrderItems;
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

  query.SQL.Clear;
	query.SQL.Text := itemsSQL;
  query.ParamByName('orderId').AsString := orderId;
	query.Open;
end;

function GetNextOrderId(): Integer;
begin
	frmOrdersMaintenance.fdqQueries.SQL.Text :=
  	'select seq_order_id.NEXTVAL from user_sequences ' +
    'WHERE sequence_name = ''SEQ_ORDER_ID'' ';

  frmOrdersMaintenance.fdqQueries.Open;
  Result := frmOrdersMaintenance.fdqQueries.Fields[0].AsInteger;
end;

function GetOrderDate(orderId: String): TDate;
begin
	frmOrdersMaintenance.fdqQueries.SQL.Text :=
  	'SELECT order_date FROM orders WHERE order_id = :orderId';
  frmOrdersMaintenance.fdqQueries.ParamByName('orderId').AsString
  	:= frmOrders.currentOrderId;

  frmOrdersMaintenance.fdqQueries.Open;
  Result := frmOrdersMaintenance.fdqQueries.
  								FieldByName('order_date').AsDateTime;
end;


procedure TfrmOrdersMaintenance.btnCreateClick(Sender: TObject);
begin
	frmOrderItemsMaintenance.ShowModal;
end;

procedure TfrmOrdersMaintenance.btnSaveClick(Sender: TObject);
begin
  CommitChanges();
  Self.Close;
end;

procedure TfrmOrdersMaintenance.btnCancelClick(Sender: TObject);
begin
  RollbackChanges();
  Self.Close;
end;

procedure TfrmOrdersMaintenance.FormShow(Sender: TObject);
begin
  edtOrderNumber.Text := frmOrders.currentOrderId;
  if frmOrders.actionType = 'createOrder' then
	begin
    dtpOrderDate.Date := Now;
  end
	else if frmOrders.actionType = 'editOrder' then
  begin
    dtpOrderDate.Date := GetOrderDate(frmOrders.currentOrderId);
    displayOrderItems(frmOrders.currentOrderId);
  end;

end;

end.
