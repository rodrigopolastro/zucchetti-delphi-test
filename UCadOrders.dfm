object Frm_CadOrders: TFrm_CadOrders
  Left = 0
  Top = 0
  Caption = 'Manuten'#231#227'o de Pedidos'
  ClientHeight = 375
  ClientWidth = 756
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
  object L_OrderNumber: TLabel
    Left = 24
    Top = 32
    Width = 62
    Height = 13
    Caption = 'N'#186' do Pedido'
  end
  object L_OrderDate: TLabel
    Left = 208
    Top = 32
    Width = 23
    Height = 13
    Caption = 'Data'
  end
  object L_Items: TLabel
    Left = 274
    Top = 72
    Width = 25
    Height = 13
    Caption = 'Itens'
  end
  object E_OrderNumber: TEdit
    Left = 92
    Top = 29
    Width = 93
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 0
    Text = 'E_OrderNumber'
  end
  object DTP_OrderDate: TDateTimePicker
    Left = 237
    Top = 29
    Width = 102
    Height = 21
    Date = 45495.000000000000000000
    Time = 0.250000000000000000
    TabOrder = 1
  end
  object B_Create: TButton
    Left = 361
    Top = 67
    Width = 75
    Height = 25
    Caption = 'Incluir'
    TabOrder = 2
    OnClick = B_CreateClick
  end
  object B_Update: TButton
    Left = 442
    Top = 67
    Width = 75
    Height = 25
    Caption = 'Alterar'
    TabOrder = 3
    OnClick = B_UpdateClick
  end
  object B_Delete: TButton
    Left = 523
    Top = 67
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 4
    OnClick = B_DeleteClick
  end
  object DBG_OrderItems: TDBGrid
    Left = 24
    Top = 120
    Width = 689
    Height = 120
    DataSource = DS_OrderItems
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBG_OrderItemsCellClick
  end
  object B_Save: TButton
    Left = 442
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 6
    OnClick = B_SaveClick
  end
  object B_Cancel: TButton
    Left = 523
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 7
    OnClick = B_CancelClick
  end
  object FDQ_OrderItems: TFDQuery
    Left = 128
    Top = 251
  end
  object DS_OrderItems: TDataSource
    DataSet = FDQ_OrderItems
    Left = 224
    Top = 251
  end
  object FDQ_Queries: TFDQuery
    Left = 360
    Top = 251
  end
end
