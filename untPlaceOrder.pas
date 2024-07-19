unit untPlaceOrder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.Oracle,
  FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.ValEdit;

type
  TfrmPlaceOrder = class(TForm)
    DBComboBox1: TDBComboBox;
    fdDatabaseConnection: TFDConnection;
    fdqProducts: TFDQuery;
    dtsProducts: TDataSource;
    ValueListEditor1: TValueListEditor;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPlaceOrder: TfrmPlaceOrder;

implementation

{$R *.dfm}

end.
