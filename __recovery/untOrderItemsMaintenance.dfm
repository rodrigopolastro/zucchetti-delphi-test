object frmOrderItemsMaintenance: TfrmOrderItemsMaintenance
  Left = 0
  Top = 0
  Caption = 'Manuten'#231#227'o de Itens'
  ClientHeight = 223
  ClientWidth = 592
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
    Left = 203
    Top = 24
    Width = 155
    Height = 13
    Caption = 'Selecione os produtos do pedido'
  end
  object lblProductCode: TLabel
    Left = 32
    Top = 70
    Width = 113
    Height = 13
    Caption = 'C'#243'digo do Produto'
  end
  object lblQuantity: TLabel
    Left = 32
    Top = 94
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object edtProductCode: TEdit
    Left = 128
    Top = 67
    Width = 49
    Height = 21
    TabOrder = 0
    OnExit = edtProductCodeExit
  end
  object btnShowProducts: TButton
    Left = 183
    Top = 67
    Width = 26
    Height = 21
    Caption = '...'
    TabOrder = 1
    OnClick = btnShowProductsClick
  end
  object edtProductName: TEdit
    Left = 215
    Top = 67
    Width = 346
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 2
  end
  object btnSave: TButton
    Left = 408
    Top = 135
    Width = 72
    Height = 31
    Caption = 'Salvar'
    TabOrder = 3
    OnClick = btnSaveClick
  end
  object edtQuantity: TEdit
    Left = 32
    Top = 113
    Width = 56
    Height = 21
    NumbersOnly = True
    TabOrder = 4
  end
  object btnCancel: TButton
    Left = 486
    Top = 135
    Width = 75
    Height = 31
    Caption = 'Cancelar'
    TabOrder = 5
  end
  object Edit1: TEdit
    Left = 203
    Top = 108
    Width = 277
    Height = 21
    TabOrder = 6
  end
  object fdqQueries: TFDQuery
    Connection = fdcDatabaseConnection
    Left = 184
    Top = 144
  end
  object fdcDatabaseConnection: TFDConnection
    Params.Strings = (
      'Database=SRV-ORACLE'
      'User_Name=RODRIGO_TESTE'
      'Password=LARANJA'
      'DriverID=Ora')
    Connected = True
    Left = 72
    Top = 147
  end
end
