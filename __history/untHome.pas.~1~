unit untTesteDeAptidao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmHome = class(TForm)
    btnPrint: TButton;
    edtOrderNumber: TEdit;
    lblOrderNumber: TLabel;
    btnCreate: TButton;
    btnUpdate: TButton;
    btnDelete: TButton;
    fdDatabaseConnection: TFDConnection;
    fdDatabaseQuery: TFDQuery;
    dtsQueryResults: TDataSource;
    dbgOrdersTable: TDBGrid;
    btnSearch: TButton;
    cbbOrderField: TComboBox;
    lblTest: TLabel;
    procedure cbbOrderFieldChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHome: TfrmHome;

implementation

{$R *.dfm}

procedure ShowHideSearchComponents(optionNumber: Integer);
begin
	frmHome.lblTest.Caption := IntToStr(optionNumber);
	case optionNumber of
  	1: //search one order by id;
    2: //search by value (greater, less than or equal to)
    3: //search by date  (before, after or at specific date)
  end;
end;


procedure TfrmHome.cbbOrderFieldChange(Sender: TObject);
var
	searchOptionIndex: Integer;
begin
	searchOptionIndex := frmHome.cbbOrderField.ItemIndex;
	ShowHideSearchComponents(searchOptionIndex+1); //index starts at 0
end;

end.
