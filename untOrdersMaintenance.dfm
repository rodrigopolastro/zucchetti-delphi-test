object frmOrdersMaintenance: TfrmOrdersMaintenance
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
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 13
  object lblOrderNumber: TLabel
    Left = 24
    Top = 32
    Width = 62
    Height = 13
    Caption = 'N'#186' do Pedido'
  end
  object lblOrderDate: TLabel
    Left = 208
    Top = 32
    Width = 23
    Height = 13
    Caption = 'Data'
  end
  object lblItens: TLabel
    Left = 274
    Top = 72
    Width = 25
    Height = 13
    Caption = 'Itens'
  end
  object edtOrderNumber: TEdit
    Left = 92
    Top = 29
    Width = 93
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 0
    Text = 'edtOrderNumber'
  end
  object dtpOrderDate: TDateTimePicker
    Left = 237
    Top = 29
    Width = 102
    Height = 21
    Date = 45495.000000000000000000
    Time = 0.250000000000000000
    TabOrder = 1
  end
  object btnCreate: TButton
    Left = 361
    Top = 67
    Width = 75
    Height = 25
    Caption = 'Incluir'
    TabOrder = 2
    OnClick = btnCreateClick
  end
  object btnUpdate: TButton
    Left = 442
    Top = 67
    Width = 75
    Height = 25
    Caption = 'Alterar'
    TabOrder = 3
    OnClick = btnUpdateClick
  end
  object btnDelete: TButton
    Left = 523
    Top = 67
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 4
  end
  object dbgOrderItems: TDBGrid
    Left = 24
    Top = 120
    Width = 689
    Height = 120
    DataSource = dtsOrderItems
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = dbgOrderItemsCellClick
  end
  object btnSave: TButton
    Left = 442
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 6
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 523
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 7
    OnClick = btnCancelClick
  end
  object Edit1: TEdit
    Left = 80
    Top = 328
    Width = 449
    Height = 21
    TabOrder = 8
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 616
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 9
  end
  object fdcDatabaseConnection: TFDConnection
    Params.Strings = (
      'Database=XE'
      'User_Name=RODRIGO'
      'Password=LARANJA'
      'DriverID=Ora')
    Left = 56
    Top = 267
  end
  object fdqOrderItems: TFDQuery
    Connection = fdcDatabaseConnection
    Left = 160
    Top = 267
  end
  object dtsOrderItems: TDataSource
    DataSet = fdqOrderItems
    Left = 248
    Top = 267
  end
  object fdqQueries: TFDQuery
    Connection = fdcDatabaseConnection
    Left = 360
    Top = 251
  end
end
