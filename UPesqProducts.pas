unit UPesqProducts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  UPesqOrders;

type
  TFrm_PesqProducts = class(TForm)
    DBG_Products: TDBGrid;
    FDQ_Products: TFDQuery;
    DS_Products: TDataSource;
    procedure DBG_ProductsDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_PesqProducts: TFrm_PesqProducts;

implementation

{$R *.dfm}

uses
	untOrderItemsMaintenance;


procedure TFrm_PesqProducts.DBG_ProductsDblClick(Sender: TObject);
begin
	frmOrderItemsMaintenance.edtProductCode.Text := dbgProducts.Fields[0].AsString;
  frmOrderItemsMaintenance.edtProductName.Text := dbgProducts.Fields[1].AsString;
  frmOrderItemsMaintenance.productPrice := dbgProducts.Fields[2].AsFloat;
  Self.Close;
end;

procedure TFrm_PesqProducts.FormCreate(Sender: TObject);
	var productsSQL: String;
begin
	productsSQL :=
    'SELECT ' +
        'product_id AS "Código do Produto", ' +
        'description AS "Descrição", ' +
        'price AS "Valor Unitário" ' +
      'FROM products';

  productsSQL := 'select * from products';

	fdqProducts.SQL.Clear;
	fdqProducts.SQL.Text := productsSQL;
  fdqProducts.Open;
end;

end.
