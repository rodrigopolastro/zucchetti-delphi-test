object frmProductsList: TfrmProductsList
  Left = 0
  Top = 0
  Caption = 'Produtos Cadastrados'
  ClientHeight = 201
  ClientWidth = 668
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
    Left = 896
    Top = 88
    Width = 672
    Height = 201
    DataSource = dtsProducts
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgProductsDblClick
  end
  object edtA: TEdit
    Left = 200
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'edtA'
  end
  object fdcDatabaseConnection: TFDConnection
    Params.Strings = (
      'Database=SRV-ORACLE'
      'User_Name=RODRIGO_TESTE'
      'Password=LARANJA'
      'DriverID=Ora')
    Connected = True
    Left = 120
    Top = 141
  end
  object fdqProducts: TFDQuery
    Connection = fdcDatabaseConnection
    SQL.Strings = (
      '')
    Left = 216
    Top = 141
  end
  object dtsProducts: TDataSource
    DataSet = fdqProducts
    Left = 296
    Top = 141
  end
end
