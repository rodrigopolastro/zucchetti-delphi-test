object frmConfirmDeletion: TfrmConfirmDeletion
  Left = 0
  Top = 0
  Caption = 'Confirmar Exclus'#227'o'
  ClientHeight = 218
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object lblMessage: TLabel
    Left = 96
    Top = 64
    Width = 59
    Height = 15
    Caption = 'lblMessage'
  end
  object btnDelete: TButton
    Left = 304
    Top = 136
    Width = 78
    Height = 41
    Caption = 'Excluir'
    TabOrder = 0
    OnClick = btnDeleteClick
  end
  object btnCancel: TButton
    Left = 396
    Top = 136
    Width = 75
    Height = 41
    Caption = 'Cancelar'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object fdqQueries: TFDQuery
    Connection = fdcDatabaseConnection
    SQL.Strings = (
      '')
    Left = 184
    Top = 138
  end
  object fdcDatabaseConnection: TFDConnection
    Params.Strings = (
      'Database=XE'
      'User_Name=RODRIGO'
      'Password=LARANJA'
      'DriverID=Ora')
    Left = 80
    Top = 138
  end
end
