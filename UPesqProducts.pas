unit UPesqProducts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

//  UPesqOrders;

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
	UCadOrderItems,
  UPesqOrders;


procedure TFrm_PesqProducts.DBG_ProductsDblClick(Sender: TObject);
begin
	Frm_CadOrderItems.E_ProductCode.Text := DBG_Products.Fields[0].AsString;
  Frm_CadOrderItems.E_ProductName.Text := DBG_Products.Fields[1].AsString;
  Frm_CadOrderItems.productPrice := DBG_Products.Fields[2].AsFloat;
  Self.Close;
end;

procedure TFrm_PesqProducts.FormCreate(Sender: TObject);
	var sProductsSQL: String;
begin
	sProductsSQL :=
    'SELECT ' +
        'PDT_codigo AS "Código do Produto", ' +
        'PDT_descri AS "Descrição", ' +
        'PDT_preco AS "Valor Unitário" ' +
      'FROM produtos';

	FDQ_Products.SQL.Clear;
	FDQ_Products.SQL.Text := sProductsSQL;
  FDQ_Products.Open;
end;

end.
