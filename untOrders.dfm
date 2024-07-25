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
  object lblOrderNumber: TLabel
    Left = 8
    Top = 13
    Width = 68
    Height = 13
    Caption = 'Filtrar Pedidos'
  end
  object btnPrint: TButton
    Left = 683
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 0
    OnClick = btnPrintClick
  end
  object edtSearchText: TEdit
    Left = 127
    Top = 38
    Width = 90
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
  object dbgOrders: TDBGrid
    Left = 8
    Top = 64
    Width = 758
    Height = 129
    DataSource = dtsOrders
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = dbgOrdersCellClick
  end
  object btnSearch: TButton
    Left = 223
    Top = 17
    Width = 75
    Height = 33
    Caption = 'Buscar'
    TabOrder = 6
    Visible = False
    OnClick = btnSearchClick
  end
  object cbbOrderField: TComboBox
    Left = 82
    Top = 9
    Width = 135
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 7
    Text = 'Todos'
    OnChange = cbbOrderFieldChange
    Items.Strings = (
      'Todos'
      'N'#250'mero'
      'Valor Total'
      'Data')
  end
  object dbgItems: TDBGrid
    Left = 8
    Top = 224
    Width = 758
    Height = 129
    DataSource = dtsItems
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = dbgItemsCellClick
  end
  object dtpOrderDate: TDateTimePicker
    Left = 119
    Top = 65
    Width = 98
    Height = 21
    Date = 45497.000000000000000000
    Time = 0.588267048609850500
    TabOrder = 9
    Visible = False
  end
  object cbbComparisonOperator: TComboBox
    Left = 82
    Top = 37
    Width = 39
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 10
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
  object fdcDatabaseConnection: TFDConnection
    Params.Strings = (
      'Database=SRV-ORACLE'
      'User_Name=RODRIGO_TESTE'
      'Password=LARANJA'
      'DriverID=Ora')
    Left = 48
    Top = 408
  end
  object fdqOrders: TFDQuery
    Connection = fdcDatabaseConnection
    SQL.Strings = (
      ''
      '')
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
