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
    Width = 431
    Height = 185
    DataSource = dtsProducts
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
    Left = 40
    Top = 219
  end
  object fdqProducts: TFDQuery
    Connection = fdcDatabaseConnection
    Left = 144
    Top = 224
  end
  object dtsProducts: TDataSource
    DataSet = fdqProducts
    Left = 216
    Top = 216
  end
end
