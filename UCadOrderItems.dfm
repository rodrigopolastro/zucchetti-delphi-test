object Frm_CadOrderItems: TFrm_CadOrderItems
  Left = 0
  Top = 0
  Caption = 'Manuten'#231#227'o de Itens'
  ClientHeight = 289
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object L_Title: TLabel
    Left = 144
    Top = 16
    Width = 155
    Height = 13
    Caption = 'Selecione os produtos do pedido'
  end
  object L_ProductCode: TLabel
    Left = 32
    Top = 71
    Width = 89
    Height = 13
    Caption = 'C'#243'digo do Produto'
  end
  object L_Quantity: TLabel
    Left = 32
    Top = 111
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object E_ProductCode: TEdit
    Left = 127
    Top = 68
    Width = 49
    Height = 21
    TabOrder = 0
    OnExit = E_ProductCodeExit
  end
  object B_ShowProducts: TButton
    Left = 182
    Top = 68
    Width = 26
    Height = 21
    Caption = '...'
    TabOrder = 1
    OnClick = B_ShowProductsClick
  end
  object E_ProductName: TEdit
    Left = 214
    Top = 68
    Width = 272
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object B_Save: TButton
    Left = 330
    Top = 135
    Width = 72
    Height = 31
    Caption = 'Salvar'
    TabOrder = 3
    OnClick = B_SaveClick
  end
  object E_Quantity: TEdit
    Left = 94
    Top = 108
    Width = 56
    Height = 21
    NumbersOnly = True
    TabOrder = 4
  end
  object B_Cancel: TButton
    Left = 408
    Top = 135
    Width = 72
    Height = 31
    Caption = 'Cancelar'
    TabOrder = 5
    OnClick = B_CancelClick
  end
  object FDQ_Queries: TFDQuery
    Connection = Frm_PesqOrders.FDC_DatabaseConnection
    SQL.Strings = (
      '')
    Left = 184
    Top = 146
  end
end
