object frmPlaceOrder: TfrmPlaceOrder
  Left = 0
  Top = 0
  Caption = 'frmPlaceOrder'
  ClientHeight = 358
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBComboBox1: TDBComboBox
    Left = 88
    Top = 64
    Width = 113
    Height = 21
    DataSource = dtsProducts
    TabOrder = 0
  end
  object ValueListEditor1: TValueListEditor
    Left = 240
    Top = 64
    Width = 306
    Height = 300
    TabOrder = 1
  end
  object fdDatabaseConnection: TFDConnection
    Params.Strings = (
      'Database=SRV-ORACLE'
      'User_Name=RODRIGO_TESTE'
      'Password=LARANJA'
      'DriverID=Ora')
    Connected = True
    Left = 56
    Top = 298
  end
  object fdqProducts: TFDQuery
    Active = True
    Connection = fdDatabaseConnection
    SQL.Strings = (
      'SELECT description FROM products'
      '')
    Left = 152
    Top = 298
  end
  object dtsProducts: TDataSource
    DataSet = fdqProducts
    Left = 224
    Top = 298
  end
end
