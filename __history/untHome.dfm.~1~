object frmHome: TfrmHome
  Left = 0
  Top = 0
  Caption = 'frmHome'
  ClientHeight = 398
  ClientWidth = 774
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblOrderNumber: TLabel
    Left = 22
    Top = 11
    Width = 86
    Height = 13
    Caption = 'Buscar pedido por'
  end
  object lblTest: TLabel
    Left = 40
    Top = 48
    Width = 31
    Height = 13
    Caption = 'lblTest'
  end
  object btnPrint: TButton
    Left = 691
    Top = 365
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 0
  end
  object edtOrderNumber: TEdit
    Left = 239
    Top = 8
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
  end
  object btnUpdate: TButton
    Left = 610
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Alterar'
    TabOrder = 3
  end
  object btnDelete: TButton
    Left = 691
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 4
  end
  object dbgOrdersTable: TDBGrid
    Left = 160
    Top = 80
    Width = 460
    Height = 201
    DataSource = dtsQueryResults
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnSearch: TButton
    Left = 357
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Buscar'
    TabOrder = 6
  end
  object cbbOrderField: TComboBox
    Left = 114
    Top = 8
    Width = 119
    Height = 21
    TabOrder = 7
    Text = 'Selecione o Campo'
    OnChange = cbbOrderFieldChange
    Items.Strings = (
      'N'#250'mero'
      'Data'
      'Valor Total')
  end
  object fdDatabaseConnection: TFDConnection
    Params.Strings = (
      'Database=SRV-ORACLE'
      'User_Name=RODRIGO_TESTE'
      'Password=LARANJA'
      'DriverID=Ora')
    Connected = True
    Left = 40
    Top = 344
  end
  object fdDatabaseQuery: TFDQuery
    Active = True
    Connection = fdDatabaseConnection
    SQL.Strings = (
      'SELECT * FROM products '
      '')
    Left = 144
    Top = 344
  end
  object dtsQueryResults: TDataSource
    DataSet = fdDatabaseQuery
    Left = 232
    Top = 344
  end
end
