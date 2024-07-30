object Frm_GenerateReport: TFrm_GenerateReport
  Left = 0
  Top = 0
  Caption = 'Frm_GenerateReport'
  ClientHeight = 372
  ClientWidth = 703
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object B_Generate: TButton
    Left = 477
    Top = 296
    Width = 99
    Height = 41
    Caption = 'Gerar Relat'#243'rio'
    TabOrder = 0
    OnClick = B_GenerateClick
  end
  object B_Cancel: TButton
    Left = 582
    Top = 296
    Width = 99
    Height = 41
    Caption = 'Cancelar'
    TabOrder = 1
    OnClick = B_CancelClick
  end
  object DBG_Items: TDBGrid
    Left = 8
    Top = 24
    Width = 673
    Height = 257
    DataSource = DS_Items
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object FDQ_Items: TFDQuery
    Active = True
    Connection = Frm_PesqOrders.FDC_DatabaseConnection
    SQL.Strings = (
      'SELECT '
      'ITN_PED_codigo , '
      'PED_data , '
      'ITN_PDT_codigo , '
      'PDT_descri , '
      'ITN_qtd , '
      'PDT_preco , '
      'ITN_qtd * PDT_preco  '
      'FROM itens '
      'INNER JOIN produtos ON PDT_codigo = ITN_PDT_codigo '
      'INNER JOIN pedidos ON PED_codigo = ITN_PED_codigo'
      'ORDER BY ITN_PED_codigo, ITN_PDT_codigo')
    Left = 56
    Top = 307
  end
  object DS_Items: TDataSource
    DataSet = FDQ_Items
    Left = 128
    Top = 307
  end
  object PDB_DatabasePipeline: TppDBPipeline
    DataSource = DS_Items
    UserName = 'PDB_DatabasePipeline'
    Left = 216
    Top = 304
    object PDB_DatabasePipelineppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'ITN_PED_CODIGO'
      FieldName = 'ITN_PED_CODIGO'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 0
      Position = 0
    end
    object PDB_DatabasePipelineppField2: TppField
      FieldAlias = 'PED_DATA'
      FieldName = 'PED_DATA'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 1
    end
    object PDB_DatabasePipelineppField3: TppField
      Alignment = taRightJustify
      FieldAlias = 'ITN_PDT_CODIGO'
      FieldName = 'ITN_PDT_CODIGO'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 39
      Position = 2
    end
    object PDB_DatabasePipelineppField4: TppField
      FieldAlias = 'PDT_DESCRI'
      FieldName = 'PDT_DESCRI'
      FieldLength = 50
      DisplayWidth = 50
      Position = 3
    end
    object PDB_DatabasePipelineppField5: TppField
      Alignment = taRightJustify
      FieldAlias = 'ITN_QTD'
      FieldName = 'ITN_QTD'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 39
      Position = 4
    end
    object PDB_DatabasePipelineppField6: TppField
      Alignment = taRightJustify
      FieldAlias = 'PDT_PRECO'
      FieldName = 'PDT_PRECO'
      FieldLength = 2
      DataType = dtDouble
      DisplayWidth = 8
      Position = 5
    end
    object PDB_DatabasePipelineppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'ITN_QTD*PDT_PRECO'
      FieldName = 'ITN_QTD*PDT_PRECO'
      FieldLength = 38
      DataType = dtDouble
      DisplayWidth = 39
      Position = 6
    end
  end
  object PR_Report: TppReport
    AutoStop = False
    DataPipeline = PDB_DatabasePipeline
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Pedidos Realizados'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    Template.FileName = 
      '\\192.168.0.1\Publica\rodrigo.silva\Treinamentos\Delphi\zucchett' +
      'i-delphi-test\itemsReport.rtm'
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    ThumbnailSettings.PageHighlight.Width = 3
    ThumbnailSettings.ThumbnailSize = tsSmall
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.AllowExtract = True
    PDFSettings.EncryptSettings.AllowAssemble = True
    PDFSettings.EncryptSettings.AllowQualityPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.EncryptSettings.EncryptionType = etRC4
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PDFSettings.PDFAFormat = pafNone
    PreviewFormSettings.PageBorder.mmPadding = 0
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    XLSSettings.WorksheetName = 'Report'
    Left = 320
    Top = 304
    Version = '20.02'
    mmColumnWidth = 0
    DataPipelineName = 'PDB_DatabasePipeline'
    object ppHeaderBand1: TppHeaderBand
      Background.Brush.Style = bsClear
      Border.mmPadding = 0
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 21696
      mmPrintPosition = 0
      object Pedidos: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Pedidos'
        Border.mmPadding = 0
        Caption = 'Pedidos Realizados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 20
        Font.Style = [fsBold]
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 8467
        mmLeft = 265
        mmTop = 7408
        mmWidth = 197644
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 12435
      mmPrintPosition = 0
      object ppShape1: TppShape
        DesignLayer = ppDesignLayer1
        UserName = 'Shape1'
        mmHeight = 13229
        mmLeft = 3969
        mmTop = -794
        mmWidth = 186267
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText3'
        Border.mmPadding = 0
        DataField = 'C'#243'd. Produto'
        DataPipeline = PDB_DatabasePipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'PDB_DatabasePipeline'
        mmHeight = 4763
        mmLeft = 18256
        mmTop = 3440
        mmWidth = 9525
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText4'
        Border.mmPadding = 0
        DataField = 'Descri'#231#227'o do Produto'
        DataPipeline = PDB_DatabasePipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'PDB_DatabasePipeline'
        mmHeight = 4763
        mmLeft = 40481
        mmTop = 3440
        mmWidth = 57944
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText5: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText5'
        Border.mmPadding = 0
        DataField = 'Valor Unit'#225'rio'
        DataPipeline = PDB_DatabasePipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'PDB_DatabasePipeline'
        mmHeight = 4763
        mmLeft = 107421
        mmTop = 3440
        mmWidth = 26458
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText8: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText8'
        Border.mmPadding = 0
        DataField = 'Quantidade'
        DataPipeline = PDB_DatabasePipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'PDB_DatabasePipeline'
        mmHeight = 4763
        mmLeft = 143140
        mmTop = 3440
        mmWidth = 29633
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText9: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText9'
        Border.mmPadding = 0
        DataField = 'Valor Total'
        DataPipeline = PDB_DatabasePipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        DataPipelineName = 'PDB_DatabasePipeline'
        mmHeight = 4763
        mmLeft = 164307
        mmTop = 3440
        mmWidth = 25929
        BandType = 4
        LayerName = Foreground
      end
      object ppLabel9: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label9'
        AutoSize = False
        Border.mmPadding = 0
        Caption = 'R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
        FormFieldSettings.FormFieldType = fftNone
        Transparent = True
        mmHeight = 4763
        mmLeft = 101336
        mmTop = 3440
        mmWidth = 12435
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      Background.Brush.Style = bsClear
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 13758
      mmPrintPosition = 0
    end
    object ppGroup1: TppGroup
      BreakName = 'N'#186' do Pedido'
      DataPipeline = PDB_DatabasePipeline
      GroupFileSettings.NewFile = False
      GroupFileSettings.EmailFile = False
      OutlineSettings.CreateNode = True
      NewPage = True
      StartOnOddPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'PDB_DatabasePipeline'
      NewFile = False
      object ppGroupHeaderBand1: TppGroupHeaderBand
        Background.Brush.Style = bsClear
        Border.mmPadding = 0
        mmBottomOffset = 0
        mmHeight = 52123
        mmPrintPosition = 0
        object ppLabel1: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label1'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'N'#186' do Pedido:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 18
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 9525
          mmLeft = 3969
          mmTop = 12700
          mmWidth = 41804
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText1: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText1'
          Border.mmPadding = 0
          DataField = 'N'#186' do Pedido'
          DataPipeline = PDB_DatabasePipeline
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 18
          Font.Style = []
          Transparent = True
          DataPipelineName = 'PDB_DatabasePipeline'
          mmHeight = 9525
          mmLeft = 47890
          mmTop = 12700
          mmWidth = 40217
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel2: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label2'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Data:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 18
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 8467
          mmLeft = 132821
          mmTop = 13758
          mmWidth = 42333
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppDBText2: TppDBText
          DesignLayer = ppDesignLayer1
          UserName = 'DBText2'
          Border.mmPadding = 0
          DataField = 'Data do Pedido'
          DataPipeline = PDB_DatabasePipeline
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 18
          Font.Style = []
          Transparent = True
          DataPipelineName = 'PDB_DatabasePipeline'
          mmHeight = 7408
          mmLeft = 150548
          mmTop = 13758
          mmWidth = 39688
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel3: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Pedidos1'
          Border.mmPadding = 0
          Caption = 'Produtos do Pedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 16
          Font.Style = []
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 6350
          mmLeft = 4498
          mmTop = 32015
          mmWidth = 48683
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppShape2: TppShape
          DesignLayer = ppDesignLayer1
          UserName = 'Shape2'
          mmHeight = 9525
          mmLeft = 3969
          mmTop = 42598
          mmWidth = 186267
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel5: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label5'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Quantidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 4763
          mmLeft = 132821
          mmTop = 45244
          mmWidth = 25929
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel6: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label6'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'C'#243'd. Produto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 4763
          mmLeft = 6879
          mmTop = 45244
          mmWidth = 26988
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel7: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label7'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Valor Total'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 4763
          mmLeft = 159544
          mmTop = 45244
          mmWidth = 27517
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel8: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label8'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Valor Unit'#225'rio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 4763
          mmLeft = 97896
          mmTop = 45244
          mmWidth = 29104
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
        object ppLabel4: TppLabel
          DesignLayer = ppDesignLayer1
          UserName = 'Label4'
          AutoSize = False
          Border.mmPadding = 0
          Caption = 'Descri'#231#227'o do Produto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Name = 'Arial'
          Font.Size = 12
          Font.Style = [fsBold]
          FormFieldSettings.FormSubmitInfo.SubmitMethod = fstPost
          FormFieldSettings.FormFieldType = fftNone
          Transparent = True
          mmHeight = 4763
          mmLeft = 39952
          mmTop = 45244
          mmWidth = 44979
          BandType = 3
          GroupNo = 0
          LayerName = Foreground
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        Background.Brush.Style = bsClear
        Border.mmPadding = 0
        HideWhenOneDetail = False
        mmBottomOffset = 0
        mmHeight = 4763
        mmPrintPosition = 0
      end
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer1: TppDesignLayer
        UserName = 'Foreground'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
end
