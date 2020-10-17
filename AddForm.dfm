object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Form2'
  ClientHeight = 283
  ClientWidth = 517
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LbAmount: TLabel
    Left = 296
    Top = 59
    Width = 64
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
  end
  object LbAmountSold: TLabel
    Left = 296
    Top = 151
    Width = 118
    Height = 13
    Caption = #1055#1088#1086#1076#1072#1085#1086' ('#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086'):'
  end
  object lbStartDate: TLabel
    Left = 144
    Top = 40
    Width = 115
    Height = 13
    Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1087#1077#1088#1080#1086#1076#1072':'
  end
  object lbEndDate: TLabel
    Left = 144
    Top = 124
    Width = 133
    Height = 13
    Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1087#1077#1088#1080#1086#1076#1072':'
  end
  object EditlbCode: TLabeledEdit
    Left = 32
    Top = 32
    Width = 182
    Height = 21
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = #1050#1086#1076':'
    TabOrder = 0
  end
  object EditLbName: TLabeledEdit
    Left = 296
    Top = 32
    Width = 182
    Height = 21
    EditLabel.Width = 77
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
    TabOrder = 1
  end
  object EditLbProd: TLabeledEdit
    Left = 32
    Top = 79
    Width = 182
    Height = 21
    EditLabel.Width = 83
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100':'
    TabOrder = 2
  end
  object EditSpinAmount: TSpinEdit
    Left = 296
    Top = 78
    Width = 182
    Height = 22
    MaxValue = 999999
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object EditLbPrice: TLabeledEdit
    Left = 32
    Top = 124
    Width = 182
    Height = 21
    EditLabel.Width = 91
    EditLabel.Height = 13
    EditLabel.Caption = #1047#1072#1082#1091#1087#1086#1095#1085#1072#1103' '#1094#1077#1085#1072':'
    TabOrder = 4
    OnKeyPress = EditLbPriceKeyPress
  end
  object EditLbVAT: TLabeledEdit
    Left = 296
    Top = 124
    Width = 182
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1044#1057' (%):'
    TabOrder = 5
    OnKeyPress = EditLbVATKeyPress
  end
  object EditSpinAmountSold: TSpinEdit
    Left = 296
    Top = 170
    Width = 182
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 7
    Value = 0
  end
  object BtnBitCancel: TBitBtn
    Left = 312
    Top = 220
    Width = 153
    Height = 33
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 9
  end
  object BtnBitConfirm: TBitBtn
    Left = 45
    Top = 220
    Width = 153
    Height = 33
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 8
  end
  object EditLbPriceSold: TLabeledEdit
    Left = 32
    Top = 170
    Width = 182
    Height = 21
    EditLabel.Width = 78
    EditLabel.Height = 13
    EditLabel.Caption = #1062#1077#1085#1072' '#1087#1088#1086#1076#1072#1078#1080':'
    TabOrder = 6
    OnKeyPress = EditLbPriceSoldKeyPress
  end
  object editDateEnd: TDateTimePicker
    Left = 144
    Top = 124
    Width = 216
    Height = 21
    Date = 43966.000000000000000000
    Time = 0.603259664349025100
    DoubleBuffered = False
    ParentDoubleBuffered = False
    TabOrder = 10
    TabStop = False
  end
  object editDateStart: TDateTimePicker
    Left = 144
    Top = 59
    Width = 216
    Height = 21
    Date = 43966.000000000000000000
    Time = 0.603259664349025100
    TabOrder = 11
    TabStop = False
  end
  object CheckBoxDate: TCheckBox
    Left = 144
    Top = 175
    Width = 216
    Height = 17
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086' '#1084#1077#1089#1103#1094#1072#1084
    TabOrder = 12
  end
end
