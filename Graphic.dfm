object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1043#1088#1072#1092#1080#1082#1080
  ClientHeight = 496
  ClientWidth = 880
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 33
    Width = 880
    Height = 361
    Align = alClient
    Center = True
    IncrementalDisplay = True
    Stretch = True
    ExplicitTop = 30
    ExplicitWidth = 870
    ExplicitHeight = 375
  end
  object Panel1: TPanel
    Left = 0
    Top = 418
    Width = 880
    Height = 78
    Align = alBottom
    Caption = #1043#1088#1072#1092#1080#1082#1080
    TabOrder = 0
    DesignSize = (
      880
      78)
    object Label1: TLabel
      Left = 51
      Top = 55
      Width = 16
      Height = 13
      Caption = '0.2'
    end
    object Label2: TLabel
      Left = 208
      Top = 55
      Width = 16
      Height = 13
      Caption = '0.7'
    end
    object Label4: TLabel
      Left = 110
      Top = 55
      Width = 16
      Height = 13
      Caption = '0.4'
    end
    object Label3: TLabel
      Left = 85
      Top = 55
      Width = 16
      Height = 13
      Caption = '0.3'
    end
    object Label5: TLabel
      Left = 320
      Top = 13
      Width = 109
      Height = 13
      Anchors = [akTop, akRight, akBottom]
      Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1075#1088#1072#1092#1080#1082' '#1087#1086
    end
    object Label6: TLabel
      Left = 35
      Top = 6
      Width = 139
      Height = 13
      Anchors = [akLeft, akTop, akBottom]
      Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1089#1075#1083#1072#1078#1080#1074#1072#1085#1080#1103
    end
    object Label7: TLabel
      Left = 144
      Top = 55
      Width = 16
      Height = 13
      Caption = '0.5'
    end
    object Label8: TLabel
      Left = 176
      Top = 55
      Width = 16
      Height = 13
      Caption = '0.6'
    end
    object Label9: TLabel
      Left = 521
      Top = 13
      Width = 144
      Height = 13
      Anchors = [akLeft, akTop, akBottom]
      Caption = #1052#1077#1090#1086#1076' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1103' '#1087#1088#1086#1075#1085#1086#1079#1072
    end
    object Label10: TLabel
      Left = 240
      Top = 55
      Width = 16
      Height = 13
      Caption = '0.8'
    end
    object Label11: TLabel
      Left = 272
      Top = 55
      Width = 16
      Height = 13
      Caption = '0.9'
    end
    object Label12: TLabel
      Left = 19
      Top = 55
      Width = 16
      Height = 13
      Caption = '0.1'
    end
    object TrackBarDraw: TTrackBar
      Left = 19
      Top = 25
      Width = 269
      Height = 27
      Anchors = [akLeft, akTop, akBottom]
      Enabled = False
      Max = 9
      Min = 1
      Position = 2
      TabOrder = 0
      TabStop = False
    end
    object btnDraw: TButton
      Left = 736
      Top = 16
      Width = 128
      Height = 45
      Anchors = [akTop, akRight, akBottom]
      Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100
      TabOrder = 1
      OnClick = btnDrawClick
    end
    object ComBoxDraw: TComboBox
      Left = 320
      Top = 32
      Width = 163
      Height = 22
      Style = csOwnerDrawFixed
      Anchors = [akTop, akRight, akBottom]
      ItemIndex = 0
      TabOrder = 2
      Text = #1055#1088#1080#1073#1099#1083#1080
      Items.Strings = (
        #1055#1088#1080#1073#1099#1083#1080
        #1058#1088#1072#1090#1072#1084
        #1048#1090#1086#1075#1072#1084)
    end
    object ComBoxMethod: TComboBox
      Left = 521
      Top = 32
      Width = 188
      Height = 22
      Style = csOwnerDrawFixed
      Anchors = [akLeft, akTop, akBottom]
      ItemIndex = 0
      TabOrder = 3
      Text = #1057#1082#1086#1083#1100#1079#1103#1097#1077#1075#1086' '#1089#1088#1077#1076#1085#1077#1075#1086
      OnSelect = ComBoxMethodSelect
      Items.Strings = (
        #1057#1082#1086#1083#1100#1079#1103#1097#1077#1075#1086' '#1089#1088#1077#1076#1085#1077#1075#1086
        #1069#1082#1089#1087#1086#1085#1077#1085#1094#1080#1072#1083#1100#1085#1086#1075#1086' '#1089#1075#1083#1072#1078#1080#1074#1072#1085#1080#1103
        #1053#1072#1080#1084#1077#1085#1100#1096#1080#1093' '#1082#1074#1072#1076#1088#1072#1090#1086#1074)
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 880
    Height = 33
    Align = alTop
    TabOrder = 1
    DesignSize = (
      880
      33)
    object lbCurGraphic: TLabel
      Left = 11
      Top = 7
      Width = 3
      Height = 13
    end
    object btnSaveGraphic: TButton
      Left = 719
      Top = 2
      Width = 145
      Height = 25
      Action = Form1.actSaveGraphic
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 394
    Width = 880
    Height = 24
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      880
      24)
    object PaintBox1: TPaintBox
      Left = 286
      Top = 1
      Width = 26
      Height = 20
      Anchors = [akLeft, akTop, akBottom]
    end
    object PaintBox2: TPaintBox
      Left = 489
      Top = 1
      Width = 26
      Height = 20
      Anchors = [akTop, akRight, akBottom]
      ExplicitLeft = 479
    end
    object lbFirstGr: TLabel
      Left = 328
      Top = 5
      Width = 3
      Height = 13
      Anchors = [akLeft, akTop, akRight, akBottom]
    end
    object lbSecondGr: TLabel
      Left = 521
      Top = 6
      Width = 3
      Height = 13
      Anchors = [akTop, akRight, akBottom]
      ExplicitLeft = 511
    end
  end
  object DlgSaveGraphic: TSaveDialog
    DefaultExt = '.jpeg'
    FileName = 'D:\univer\'#1089#1077#1084'_2\course_tst2\chart.jpg'
    Filter = 'JPEG|*.jpg|Bitmap|*.bmp'
    InitialDir = '/'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Left = 560
  end
end
