object frmOrders: TfrmOrders
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
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblFilterOrders: TLabel
    Left = 26
    Top = 13
    Width = 68
    Height = 13
    Caption = 'Filtrar Pedidos'
  end
  object lblOrder: TLabel
    Left = 194
    Top = 13
    Width = 59
    Height = 13
    Caption = 'Ordenar por'
    Visible = False
  end
  object btnPrint: TButton
    Left = 697
    Top = 399
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 0
    OnClick = btnPrintClick
  end
  object edtSearchText: TEdit
    Left = 71
    Top = 60
    Width = 98
    Height = 21
    TabOrder = 1
    Visible = False
  end
  object btnCreate: TButton
    Left = 529
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Incluir'
    TabOrder = 2
    OnClick = btnCreateClick
  end
  object btnEdit: TButton
    Left = 610
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Alterar'
    TabOrder = 3
    OnClick = btnEditClick
  end
  object btnDelete: TButton
    Left = 691
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 4
    OnClick = btnDeleteClick
  end
  object btnSearch: TButton
    Left = 175
    Top = 42
    Width = 98
    Height = 35
    Caption = 'Buscar'
    TabOrder = 5
    Visible = False
    OnClick = btnSearchClick
  end
  object cbbOrderField: TComboBox
    Left = 26
    Top = 32
    Width = 143
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 6
    Text = 'Todos'
    OnChange = cbbOrderFieldChange
    Items.Strings = (
      'Todos'
      'N'#250'mero'
      'Valor Total'
      'Data')
  end
  object dbgItems: TDBGrid
    Left = 14
    Top = 231
    Width = 758
    Height = 129
    DataSource = dtsItems
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = dbgItemsCellClick
  end
  object dtpOrderDate: TDateTimePicker
    Left = 71
    Top = 129
    Width = 98
    Height = 21
    Date = 45497.000000000000000000
    Time = 0.588267048609850500
    TabOrder = 8
    Visible = False
  end
  object cbbComparisonOperator: TComboBox
    Left = 26
    Top = 60
    Width = 39
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 9
    Text = '='
    Visible = False
    OnChange = cbbOrderFieldChange
    Items.Strings = (
      '='
      '<>'
      '>'
      '<'
      '>='
      '<=')
  end
  object dbgOrders: TDBGrid
    Left = 14
    Top = 96
    Width = 758
    Height = 129
    DataSource = dtsOrders
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = dbgOrdersCellClick
  end
  object cbbOrderBy: TComboBox
    Left = 194
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
  object fdcDatabaseConnection: TFDConnection
    Params.Strings = (
      'Database=SRV-ORACLE'
      'User_Name=RODRIGO_TESTE'
      'Password=LARANJA'
      'DriverID=Ora')
    Connected = True
    Left = 48
    Top = 416
  end
  object fdqOrders: TFDQuery
    Connection = fdcDatabaseConnection
    Left = 128
    Top = 392
  end
  object dtsOrders: TDataSource
    DataSet = fdqOrders
    Left = 208
    Top = 392
  end
  object fdqItems: TFDQuery
    Connection = fdcDatabaseConnection
    SQL.Strings = (
      ''
      '')
    Left = 128
    Top = 448
  end
  object dtsItems: TDataSource
    DataSet = fdqItems
    Left = 208
    Top = 448
  end
  object fdqActionQueries: TFDQuery
    Connection = fdcDatabaseConnection
    Left = 344
    Top = 424
  end
end
