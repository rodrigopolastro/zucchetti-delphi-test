object frmOrders: TfrmOrders
  Left = 0
  Top = 0
  Caption = 'Pedidos'
  ClientHeight = 504
  ClientWidth = 774
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object lblOrderNumber: TLabel
    Left = 187
    Top = 13
    Width = 87
    Height = 13
    Caption = 'N'#250'mero do Pedido'
  end
  object btnPrint: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 0
  end
  object edtOrderNumber: TEdit
    Left = 279
    Top = 10
    Width = 112
    Height = 21
    TabOrder = 1
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
  end
  object dbgOrders: TDBGrid
    Left = 8
    Top = 56
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
    Left = 397
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Buscar'
    TabOrder = 6
    OnClick = btnSearchClick
  end
  object cbbOrderField: TComboBox
    Left = 610
    Top = 434
    Width = 119
    Height = 21
    TabOrder = 7
    Text = 'Selecione o Campo'
    Visible = False
    OnChange = cbbOrderFieldChange
    Items.Strings = (
      'N'#250'mero'
      'Data'
      'Valor Total')
  end
  object dbgItems: TDBGrid
    Left = 8
    Top = 208
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
  object edtTest: TEdit
    Left = 8
    Top = 343
    Width = 721
    Height = 21
    TabOrder = 9
    Text = 'edtTest'
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
