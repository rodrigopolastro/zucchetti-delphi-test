object frmProducts: TfrmProducts
  Left = 0
  Top = 0
  Caption = 'Produtos'
  ClientHeight = 295
  ClientWidth = 591
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dbgProducts: TDBGrid
    Left = 8
    Top = 8
    Width = 575
    Height = 279
    DataSource = dtsProducts
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgProductsDblClick
  end
  object fdcDatabaseConnection: TFDConnection
    Params.Strings = (
      'Database=SRV-ORACLE'
      'User_Name=RODRIGO_TESTE'
      'Password=LARANJA'
      'DriverID=Ora')
    Left = 72
    Top = 171
  end
  object fdqProducts: TFDQuery
    Connection = fdcDatabaseConnection
    Left = 168
    Top = 176
  end
  object dtsProducts: TDataSource
    DataSet = fdqProducts
    Left = 248
    Top = 184
  end
end
