unit untConfirmDeletion;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TfrmConfirmDeletion = class(TForm)
    lblMessage: TLabel;
    btnDelete: TButton;
    btnCancel: TButton;
    fdqQueries: TFDQuery;
    fdcDatabaseConnection: TFDConnection;
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfirmDeletion: TfrmConfirmDeletion;

implementation

{$R *.dfm}

uses
	untBackendFunctions,
  untOrders,
  untOrdersMaintenance;

procedure TfrmConfirmDeletion.FormShow(Sender: TObject);
begin
  if frmOrders.actionType = 'deleteOrder' then
    lblMessage.Caption := 'Tem certeza que deseja excluir o Pedido Nº ' +
      frmOrders.currentOrderId + '?'
  else if (frmOrders.actionType = 'deleteItem') or
          (frmOrdersMaintenance.secActionType = 'deleteItem') then
    lblMessage.Caption := 'Tem certeza que deseja excluir o Produto de Código ' +
      frmOrders.currentItemProductId +
      ' do Pedido Nº ' + frmOrders.currentOrderId + '?'
end;

procedure TfrmConfirmDeletion.btnDeleteClick(Sender: TObject);
begin
  if frmOrders.actionType = 'deleteOrder' then
  begin
    DeleteOrder(frmOrders.currentOrderId);
	  ShowMessage('Pedido excluído.');
    frmOrders.dbgOrders.DataSource.DataSet.Refresh;
    frmOrders.dbgOrders.DataSource.DataSet.First;
    frmOrders.currentOrderId :=
    	frmOrders.dbgOrders.DataSource.DataSet.Fields[0].AsString;
    DisplayOrderItems(frmOrders.currentOrderId, frmOrders.fdqItems);
  end
  else if (frmOrders.actionType = 'deleteItem') or
          (frmOrdersMaintenance.secActionType = 'deleteItem') then
  begin
  	DeleteItem(
    	frmOrders.currentOrderId,
    	frmOrders.currentItemProductId
    );
    ShowMessage('Item excluído.');
    frmOrders.dbgItems.DataSource.DataSet.Refresh;
  end;
  Self.Close;
end;

procedure TfrmConfirmDeletion.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

end.
