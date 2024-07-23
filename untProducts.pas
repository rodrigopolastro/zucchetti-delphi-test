unit untProducts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmProducts = class(TForm)
    dbgProducts: TDBGrid;
    fdcDatabaseConnection: TFDConnection;
    fdqProducts: TFDQuery;
    dtsProducts: TDataSource;
    procedure dbgProductsDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProducts: TfrmProducts;

implementation

{$R *.dfm}

uses
	untOrderItemsMaintenance;


procedure TfrmProducts.dbgProductsDblClick(Sender: TObject);
begin
	frmOrderItemsMaintenance.edtProductCode.Text := dbgProducts.Fields[0].AsString;
  frmOrderItemsMaintenance.edtProductName.Text := dbgProducts.Fields[1].AsString;
  Self.Close;
end;

procedure TfrmProducts.FormCreate(Sender: TObject);
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
