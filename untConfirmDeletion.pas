unit untConfirmDeletion;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmConfirmDeletion = class(TForm)
    lblMessage: TLabel;
    btnSave: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
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
  untOrders;

procedure TfrmConfirmDeletion.FormCreate(Sender: TObject);
begin
  if frmOrders.actionType = 'deleteOrder' then
    lblMessage.Caption := 'Confirmar exclus�o do Pedido N� ' +
      frmOrders.currentOrderId + '?'
  else if frmOrders.actionType = 'deleteItem' then
    lblMessage.Caption := 'Confirmar exclus�o do Produto de C�digo ' +
      frmOrders.currentItemProductId +
      'do Pedido N� ' + frmOrders.currentOrderId + '?'
end;

procedure TfrmConfirmDeletion.btnSaveClick(Sender: TObject);
begin
  if frmOrders.actionType = 'deleteOrder' then
    lblMessage.Caption := 'Confirmar exclus�o do Pedido N� ' +
      frmOrders.currentOrderId + '?'
  else if frmOrders.actionType = 'deleteItem' then
end;

procedure TfrmConfirmDeletion.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

end.
