unit untGenerateReport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, ppCtrls,
  ppBands, ppClass, ppPrnabl, ppDesignLayer, ppCache, ppDB, ppParameter, ppProd,
  ppReport, ppComm, ppRelatv, ppDBPipe,

  untOrders;

type
  TfrmGenerateReport = class(TForm)
    btnGenerate: TButton;
    btnCancel: TButton;
    dbgItems: TDBGrid;
    fdqItems: TFDQuery;
    dtsItems: TDataSource;
    ppDBPipeline: TppDBPipeline;
    ppReport: TppReport;
    ppParameterList1: TppParameterList;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    Pedidos: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppLabel3: TppLabel;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppLabel5: TppLabel;
    ppDBText8: TppDBText;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppDBText9: TppDBText;
    ppLabel8: TppLabel;
    ppShape1: TppShape;
    ppLabel4: TppLabel;
    ppShape2: TppShape;
    ppLabel9: TppLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGenerateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGenerateReport: TfrmGenerateReport;

implementation

{$R *.dfm}

procedure DisplayItems();
	var
  	itemsSQL: string;
begin

end;

procedure TfrmGenerateReport.btnCancelClick(Sender: TObject);
begin
	Self.Close;
end;

procedure TfrmGenerateReport.btnGenerateClick(Sender: TObject);
begin
	frmGenerateReport.ppReport.PrintReport;
end;

procedure TfrmGenerateReport.FormShow(Sender: TObject);
begin
//  DisplayItems();
end;

end.
