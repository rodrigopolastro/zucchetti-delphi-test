object Frm_PesqOrders: TFrm_PesqOrders
  Left = 0
  Top = 0
  Caption = 'Pedidos'
  ClientHeight = 504
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object L_FilterOrders: TLabel
    Left = 26
    Top = 13
    Width = 68
    Height = 13
    Caption = 'Filtrar Pedidos'
  end
  object L_Order: TLabel
    Left = 194
    Top = 13
    Width = 59
    Height = 13
    Caption = 'Ordenar por'
    Visible = False
  end
  object B_Print: TButton
    Left = 697
    Top = 399
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 0
    OnClick = B_PrintClick
  end
  object E_SearchText: TEdit
    Left = 71
    Top = 60
    Width = 98
    Height = 21
    TabOrder = 1
    Visible = False
  end
  object B_Create: TButton
    Left = 529
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Incluir'
    TabOrder = 2
    OnClick = B_CreateClick
  end
  object B_Edit: TButton
    Left = 610
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Alterar'
    TabOrder = 3
    OnClick = B_EditClick
  end
  object B_Delete: TButton
    Left = 691
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 4
    OnClick = B_DeleteClick
  end
  object B_Search: TButton
    Left = 175
    Top = 42
    Width = 98
    Height = 35
    Caption = 'Buscar'
    TabOrder = 5
    Visible = False
    OnClick = B_SearchClick
  end
  object CB_OrderField: TComboBox
    Left = 26
    Top = 32
    Width = 143
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 6
    Text = 'Todos'
    OnChange = CB_OrderFieldChange
    Items.Strings = (
      'Todos'
      'N'#250'mero'
      'Valor Total'
      'Data')
  end
  object DBG_Items: TDBGrid
    Left = 14
    Top = 231
    Width = 758
    Height = 129
    DataSource = DS_Items
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBG_ItemsCellClick
  end
  object CB_ComparisonOperator: TComboBox
    Left = 26
    Top = 60
    Width = 39
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 9
    Text = '='
    Visible = False
    OnChange = CB_OrderFieldChange
    Items.Strings = (
      '='
      '<>'
      '>'
      '<'
      '>='
      '<=')
  end
  object DBG_Orders: TDBGrid
    Left = 14
    Top = 96
    Width = 758
    Height = 129
    DataSource = DS_Orders
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBG_OrdersCellClick
  end
  object CB_OrderBy: TComboBox
    Left = 298
    Top = 32
    Width = 148
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 11
    Text = 'N'#250'mero'
    Visible = False
    Items.Strings = (
      'N'#250'mero'
      'Data'
      'Valor Total')
  end
  object rbAsc: TRadioButton
    Left = 194
    Top = 60
    Width = 79
    Height = 17
    Caption = 'Crescente'
    TabOrder = 12
    Visible = False
  end
  object rbDesc: TRadioButton
    Left = 263
    Top = 60
    Width = 79
    Height = 17
    Caption = 'Decrescente'
    TabOrder = 13
    Visible = False
  end
  object DTP_OrderDate: TDateTimePicker
    Left = 71
    Top = 88
    Width = 98
    Height = 21
    Date = 45497.000000000000000000
    Time = 0.588267048609850500
    TabOrder = 8
    Visible = False
  end
  object FDC_DatabaseConnection: TFDConnection
    Params.Strings = (
      'Database=XE'
      'User_Name=RODRIGO'
      'Password=LARANJA'
      'DriverID=Ora')
    Left = 48
    Top = 416
  end
  object FDQ_Orders: TFDQuery
    Connection = FDC_DatabaseConnection
    Left = 128
    Top = 392
  end
  object DS_Orders: TDataSource
    DataSet = FDQ_Orders
    Left = 208
    Top = 392
  end
  object FDQ_Items: TFDQuery
    Connection = FDC_DatabaseConnection
    SQL.Strings = (
      ''
      '')
    Left = 128
    Top = 448
  end
  object DS_Items: TDataSource
    DataSet = FDQ_Items
    Left = 208
    Top = 448
  end
  object FDQ_ActionQueries: TFDQuery
    Connection = FDC_DatabaseConnection
    Left = 344
    Top = 424
  end
end
