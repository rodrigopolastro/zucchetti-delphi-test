object frmOrderItemsMaintenance: TfrmOrderItemsMaintenance
  Left = 0
  Top = 0
  ClientHeight = 201
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnShow = FormShow
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
    Top = 71
    Width = 89
    Height = 13
    Caption = 'C'#243'digo do Produto'
  end
  object lblQuantity: TLabel
    Left = 32
    Top = 111
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object edtProductCode: TEdit
    Left = 127
    Top = 68
    Width = 49
    Height = 21
    TabOrder = 0
    OnExit = edtProductCodeExit
  end
  object btnShowProducts: TButton
    Left = 182
    Top = 68
    Width = 26
    Height = 21
    Caption = '...'
    TabOrder = 1
    OnClick = btnShowProductsClick
  end
  object edtProductName: TEdit
    Left = 214
    Top = 68
    Width = 272
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object btnSave: TButton
    Left = 330
    Top = 135
    Width = 72
    Height = 31
    Caption = 'Salvar'
    TabOrder = 3
    OnClick = btnSaveClick
  end
  object edtQuantity: TEdit
    Left = 94
    Top = 108
    Width = 56
    Height = 21
    NumbersOnly = True
    TabOrder = 4
  end
  object btnCancel: TButton
    Left = 408
    Top = 135
    Width = 72
    Height = 31
    Caption = 'Cancelar'
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object fdcDatabaseConnection: TFDConnection
    Params.Strings = (
      'Database=SRV-ORACLE'
      'User_Name=RODRIGO_TESTE'
      'Password=LARANJA'
      'DriverID=Ora')
    Left = 80
    Top = 138
  end
  object fdqQueries: TFDQuery
    Connection = fdcDatabaseConnection
    SQL.Strings = (
      '')
    Left = 184
    Top = 146
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 24
    Top = 16
  end
end
