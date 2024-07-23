object frmProductsList: TfrmProductsList
  Left = 0
  Top = 0
  Caption = 'Produtos Cadastrados'
  ClientHeight = 304
  ClientWidth = 760
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
  object edtA: TEdit
    Left = 200
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'edtA'
  end
  object dbgProducts: TDBGrid
    Left = 8
    Top = 8
    Width = 737
    Height = 288
    DataSource = dtsProducts
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
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
    DataSet = frmOrderItemsMaintenance.fdqQueries
    Left = 296
    Top = 141
  end
end
