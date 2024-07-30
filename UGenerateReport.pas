{*********************************************************************
 TESTE DE Aptidão - Delphi
 Desenv.    : Rodrigo Silva
 Criação    : 07/2024
 Descrição  : Geração de Relatório com os pedidos realizados e seus itens
*********************************************************************}

unit UGenerateReport;

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
  ppReport, ppComm, ppRelatv, ppDBPipe;

//  UPesqOrders;

type
  TFrm_GenerateReport = class(TForm)
    B_Generate: TButton;
    B_Cancel: TButton;
    DBG_Items: TDBGrid;
    FDQ_Items: TFDQuery;
    DS_Items: TDataSource;
    PDB_DatabasePipeline: TppDBPipeline;
    PR_Report: TppReport;
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
    procedure B_CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure B_GenerateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_GenerateReport: TFrm_GenerateReport;

implementation

uses
	UPesqOrders;

{$R *.dfm}

procedure DisplayItems();
	var
  	itemsSQL: string;
begin

end;

procedure TFrm_GenerateReport.B_CancelClick(Sender: TObject);
begin
	Self.Close;
end;

procedure TFrm_GenerateReport.B_GenerateClick(Sender: TObject);
begin
	Frm_GenerateReport.PR_Report.PrintReport;
end;

procedure TFrm_GenerateReport.FormShow(Sender: TObject);
begin
//  DisplayItems();
end;

end.
