object frmPlaceOrder: TfrmPlaceOrder
  Left = 0
  Top = 0
  ClientHeight = 415
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblTitle: TLabel
    Left = 144
    Top = 16
    Width = 155
    Height = 13
    Caption = 'Selecione os produtos do pedido'
  end
  object lblProductCode: TLabel
    Left = 32
    Top = 49
    Width = 89
    Height = 13
    Caption = 'C'#243'digo do Produto'
  end
  object lblQuantity: TLabel
    Left = 352
    Top = 49
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object edtProductCode: TEdit
    Left = 32
    Top = 68
    Width = 49
    Height = 21
    TabOrder = 0
    Text = 'edtProductCode'
  end
  object btnShowProducts: TButton
    Left = 87
    Top = 68
    Width = 26
    Height = 21
    Caption = '...'
    TabOrder = 1
  end
  object edtProductName: TEdit
    Left = 119
    Top = 68
    Width = 218
    Height = 21
    TabOrder = 2
    Text = 'edtProductCode'
  end
  object btnAddItem: TButton
    Left = 303
    Top = 95
    Width = 105
    Height = 31
    Caption = 'Adicionar'
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 352
    Top = 68
    Width = 56
    Height = 21
    NumbersOnly = True
    TabOrder = 4
  end
  object fdDatabaseConnection: TFDConnection
    Params.Strings = (
      'Database=SRV-ORACLE'
      'User_Name=RODRIGO_TESTE'
      'Password=LARANJA'
      'DriverID=Ora')
    Left = 56
    Top = 346
  end
  object fdqProducts: TFDQuery
    Connection = fdDatabaseConnection
    SQL.Strings = (
      'SELECT description FROM products'
      '')
    Left = 152
    Top = 354
  end
  object dtsProducts: TDataSource
    DataSet = fdqProducts
    Left = 240
    Top = 346
  end
end
