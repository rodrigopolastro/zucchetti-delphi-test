unit untProductsList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls;

type
  TfrmProductsList = class(TForm)
    fdcDatabaseConnection: TFDConnection;
    fdqProducts: TFDQuery;
    dtsProducts: TDataSource;
    edtA: TEdit;
    dbgProducts: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure dbgProductsDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProductsList: TfrmProductsList;

implementation

{$R *.dfm}

uses
	untOrderItemsMaintenance;

procedure TfrmProductsList.dbgProductsDblClick(Sender: TObject);
begin
	frmOrderItemsMaintenance.edtProductCode.Text := dbgProducts.Fields[0].AsString;
  frmOrderItemsMaintenance.edtProductName.Text := dbgProducts.Fields[1].AsString;
  Self.Close;
end;

procedure TfrmProductsList.FormCreate(Sender: TObject);
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
