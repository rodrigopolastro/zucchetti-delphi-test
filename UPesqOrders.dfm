object Frm_PesqOrders: TFrm_PesqOrders
  Left = 0
  Top = 0
  Caption = 'Pedidos'
  ClientHeight = 472
  ClientWidth = 667
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 5
  Padding.Top = 5
  Padding.Right = 5
  Padding.Bottom = 5
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 5
    Top = 5
    Width = 657
    Height = 462
    Align = alClient
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 0
    ExplicitLeft = 2
    ExplicitTop = 2
    ExplicitWidth = 682
    DesignSize = (
      657
      462)
    object L_FilterOrders: TLabel
      Left = 10
      Top = 10
      Width = 68
      Height = 13
      Caption = 'Filtrar Pedidos'
    end
    object L_Order: TLabel
      Left = 178
      Top = 13
      Width = 59
      Height = 13
      Caption = 'Ordenar por'
      Visible = False
    end
    object rbDesc: TRadioButton
      Left = 263
      Top = 60
      Width = 79
      Height = 17
      Caption = 'Decrescente'
      TabOrder = 1
      Visible = False
    end
    object B_Create: TButton
      Left = 411
      Top = 5
      Width = 75
      Height = 34
      Anchors = [akRight]
      Caption = 'Incluir'
      TabOrder = 2
      OnClick = B_CreateClick
      ExplicitLeft = 436
    end
    object B_Delete: TButton
      Left = 573
      Top = 5
      Width = 75
      Height = 34
      Anchors = [akRight]
      Caption = 'Excluir'
      TabOrder = 3
      OnClick = B_DeleteClick
      ExplicitLeft = 598
    end
    object B_Edit: TButton
      Left = 492
      Top = 5
      Width = 75
      Height = 34
      Anchors = [akRight]
      Caption = 'Alterar'
      TabOrder = 4
      OnClick = B_EditClick
      ExplicitLeft = 517
    end
    object B_Print: TButton
      Left = 566
      Top = 366
      Width = 82
      Height = 35
      Anchors = [akTop, akRight]
      Caption = 'Imprimir'
      TabOrder = 5
      OnClick = B_PrintClick
      ExplicitLeft = 591
    end
    object B_Search: TButton
      Left = 159
      Top = 37
      Width = 98
      Height = 45
      Caption = 'Buscar'
      TabOrder = 6
      Visible = False
      OnClick = B_SearchClick
    end
    object CB_ComparisonOperator: TComboBox
      Left = 10
      Top = 55
      Width = 39
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 0
      TabOrder = 7
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
    object CB_OrderBy: TComboBox
      Left = 178
      Top = 28
      Width = 148
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 0
      TabOrder = 8
      Text = 'N'#250'mero'
      Visible = False
      Items.Strings = (
        'N'#250'mero'
        'Data'
        'Valor Total')
    end
    object CB_OrderField: TComboBox
      Left = 10
      Top = 28
      Width = 143
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 0
      TabOrder = 9
      Text = 'Todos'
      OnChange = CB_OrderFieldChange
      Items.Strings = (
        'Todos'
        'N'#250'mero'
        'Valor Total'
        'Data')
    end
    object E_SearchText: TEdit
      Left = 55
      Top = 55
      Width = 98
      Height = 21
      TabOrder = 11
      Visible = False
    end
    object DBG_Items: TDBGrid
      Left = 10
      Top = 231
      Width = 638
      Height = 129
      Anchors = [akLeft, akTop, akRight]
      DataSource = DS_Items
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 12
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = DBG_ItemsCellClick
    end
    object DBG_Orders: TDBGrid
      Left = 10
      Top = 96
      Width = 638
      Height = 129
      Anchors = [akLeft, akTop, akRight]
      DataSource = DS_Orders
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 13
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = DBG_OrdersCellClick
    end
    object DTP_OrderDate: TDateTimePicker
      Left = 55
      Top = 82
      Width = 98
      Height = 21
      Date = 45497.000000000000000000
      Time = 0.588267048609850500
      TabOrder = 10
      Visible = False
    end
    object rbAsc: TRadioButton
      Left = 178
      Top = 60
      Width = 79
      Height = 17
      Caption = 'Crescente'
      TabOrder = 0
      Visible = False
    end
  end
  object FDC_DatabaseConnection: TFDConnection
    Params.Strings = (
      'Database=SRV-ORACLE'
      'User_Name=RODRIGO_TESTE'
      'Password=LARANJA'
      'DriverID=Ora')
    Connected = True
    Left = 40
    Top = 368
  end
  object FDQ_Orders: TFDQuery
    Connection = FDC_DatabaseConnection
    Left = 56
    Top = 152
  end
  object DS_Orders: TDataSource
    DataSet = FDQ_Orders
    Left = 136
    Top = 152
  end
  object FDQ_Items: TFDQuery
    Connection = FDC_DatabaseConnection
    SQL.Strings = (
      ''
      '')
    Left = 48
    Top = 288
  end
  object DS_Items: TDataSource
    DataSet = FDQ_Items
    Left = 136
    Top = 288
  end
  object FDQ_ActionQueries: TFDQuery
    Connection = FDC_DatabaseConnection
    Left = 152
    Top = 368
  end
end
