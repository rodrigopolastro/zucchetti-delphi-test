object Frm_ConfirmDeletion: TFrm_ConfirmDeletion
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
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object L_Message: TLabel
    Left = 96
    Top = 64
    Width = 57
    Height = 15
    Caption = 'L_Message'
  end
  object B_Delete: TButton
    Left = 304
    Top = 136
    Width = 78
    Height = 41
    Caption = 'Excluir'
    TabOrder = 0
    OnClick = B_DeleteClick
  end
  object B_Cancel: TButton
    Left = 396
    Top = 136
    Width = 75
    Height = 41
    Caption = 'Cancelar'
    TabOrder = 1
    OnClick = B_CancelClick
  end
end
