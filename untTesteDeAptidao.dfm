object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 398
  ClientWidth = 706
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
    Left = 152
    Top = 27
    Width = 62
    Height = 13
    Caption = 'N'#186' do Pedido'
  end
  object btnPrint: TButton
    Left = 8
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 0
  end
  object edtOrderNumber: TEdit
    Left = 220
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object btnCreate: TButton
    Left = 448
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Incluir'
    TabOrder = 2
  end
  object btnUpdate: TButton
    Left = 536
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Alterar'
    TabOrder = 3
  end
  object btnDelete: TButton
    Left = 617
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 4
  end
  object DBGrid1: TDBGrid
    Left = 40
    Top = 72
    Width = 633
    Height = 120
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        Visible = True
      end>
  end
end
