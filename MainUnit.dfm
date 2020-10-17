object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'TableTable'
  ClientHeight = 462
  ClientWidth = 930
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MenuM
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lvReport: TListView
    Left = 0
    Top = 25
    Width = 728
    Height = 437
    Align = alClient
    Columns = <
      item
        Caption = '#'
        MaxWidth = 80
        MinWidth = 30
        Width = 30
      end
      item
        Caption = #1050#1086#1076
        MaxWidth = 100
        MinWidth = 50
      end
      item
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        MaxWidth = 300
        MinWidth = 100
        Width = 150
      end
      item
        Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
        MaxWidth = 300
        MinWidth = 100
        Width = 150
      end
      item
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        MaxWidth = 100
        MinWidth = 80
        Width = 80
      end
      item
        Caption = #1047#1072#1082#1091#1087#1086#1095#1085#1072#1103' '#1094#1077#1085#1072
        MaxWidth = 150
        MinWidth = 100
        Width = 100
      end
      item
        Caption = #1053#1044#1057' (%)'
        MaxWidth = 80
        MinWidth = 60
        Width = 60
      end
      item
        Caption = #1062#1077#1085#1072' '#1089' '#1053#1044#1057
        MaxWidth = 150
        MinWidth = 100
        Width = 100
      end
      item
        Caption = #1062#1077#1085#1072' '#1087#1088#1086#1076#1072#1078#1080
        MaxWidth = 150
        MinWidth = 100
        Width = 100
      end
      item
        Caption = #1055#1088#1086#1076#1072#1085#1086
        MaxWidth = 100
        MinWidth = 80
        Width = 80
      end
      item
        Caption = #1055#1088#1080#1073#1099#1083#1100
        MaxWidth = 160
        MinWidth = 80
        Width = 80
      end>
    DoubleBuffered = True
    ReadOnly = True
    RowSelect = True
    ParentDoubleBuffered = False
    TabOrder = 0
    ViewStyle = vsReport
    OnColumnClick = lvReportColumnClick
  end
  object PnlButtons: TPanel
    Left = 728
    Top = 25
    Width = 202
    Height = 437
    Align = alRight
    TabOrder = 1
    object labelPos: TLabel
      Left = 14
      Top = 323
      Width = 120
      Height = 16
      Caption = #1044#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1087#1086#1080#1089#1082#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LabelCat: TLabel
      Left = 14
      Top = 258
      Width = 134
      Height = 16
      Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1076#1083#1103' '#1087#1086#1080#1089#1082#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnAdd: TButton
      Left = 32
      Top = 25
      Width = 137
      Height = 33
      Action = actAdd
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 0
    end
    object btnRemove: TButton
      Left = 32
      Top = 136
      Width = 137
      Height = 33
      Action = actRemove
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
    end
    object btnEdit: TButton
      Left = 32
      Top = 80
      Width = 137
      Height = 32
      Action = actEdit
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 1
    end
    object EditMaskSrch: TMaskEdit
      Left = 14
      Top = 345
      Width = 144
      Height = 21
      Enabled = False
      TabOrder = 3
      Text = ''
      OnKeyPress = EditMaskSrchKeyPress
    end
    object ComBoxSrch: TComboBox
      Left = 14
      Top = 280
      Width = 171
      Height = 21
      Style = csDropDownList
      TabOrder = 4
      OnSelect = ComBoxSrchSelect
      Items.Strings = (
        ''
        #1050#1086#1076
        #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
        #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        #1047#1072#1082#1091#1087#1086#1095#1085#1072#1103' '#1062#1077#1085#1072
        #1053#1044#1057' (%)'
        #1062#1077#1085#1072' '#1089' '#1053#1044#1057
        #1062#1077#1085#1072' '#1087#1088#1086#1076#1072#1078#1080
        #1055#1088#1086#1076#1072#1085#1086
        #1055#1088#1080#1073#1099#1083#1100)
    end
    object BtnCancelSrch: TBitBtn
      Left = 164
      Top = 343
      Width = 25
      Height = 25
      Caption = #1061
      Enabled = False
      TabOrder = 5
      OnClick = BtnCancelSrchClick
    end
    object btnClear: TButton
      Left = 32
      Top = 193
      Width = 137
      Height = 33
      Action = actClear
      Enabled = False
      TabOrder = 6
    end
  end
  object pnlTables: TPanel
    Left = 0
    Top = 0
    Width = 930
    Height = 25
    Align = alTop
    TabOrder = 2
    object btnTable1: TButton
      Left = 16
      Top = 0
      Width = 113
      Height = 24
      Caption = #1058#1072#1073#1083#1080#1094#1072' '#1090#1086#1074#1072#1088#1086#1074
      Enabled = False
      TabOrder = 0
      OnClick = btnTable1Click
    end
    object btnTable2: TButton
      Left = 151
      Top = 0
      Width = 113
      Height = 24
      Caption = #1058#1072#1073#1083#1080#1094#1072' '#1080#1090#1086#1075#1086#1074
      TabOrder = 1
      OnClick = btnTable2Click
    end
  end
  object MenuM: TMainMenu
    Left = 808
    Top = 9
    object btnFile: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      object btnOpen: TMenuItem
        Action = actOpen
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object btnSave: TMenuItem
        Action = actSave
      end
      object btnSaveAs: TMenuItem
        Action = actSaveAll
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object btnExit: TMenuItem
        Action = actExit
      end
    end
    object btnGraphic: TMenuItem
      Action = actGraphic
    end
    object btnAnalyze: TMenuItem
      Caption = #1040#1085#1072#1083#1080#1079
      object btnTablePos: TMenuItem
        Caption = #1058#1072#1073#1083#1080#1094#1072' '#1090#1086#1074#1072#1088#1086#1074
        object N1: TMenuItem
          Caption = #1051#1091#1095#1096#1077#1077' '#1080' '#1093#1091#1076#1096#1077#1077' '#1087#1086'...'
          object btnBWSalesAmount: TMenuItem
            Action = actBWSalesAmount
          end
          object btnBWSalsesIncome: TMenuItem
            Action = actBWSalesIncome
          end
        end
        object N4: TMenuItem
          Action = actMPProd
        end
        object N2: TMenuItem
          Caption = #1051#1091#1095#1096#1080#1077' '#1090#1086#1074#1072#1088#1099' '#1087#1086' '#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1103#1084
          object N3: TMenuItem
            Action = actMPNameProdAmount
          end
          object N6: TMenuItem
            Action = actMPNameProdIncome
          end
        end
      end
      object btnTableSales: TMenuItem
        Caption = #1058#1072#1073#1083#1080#1094#1072' '#1080#1090#1086#1075#1086#1074
        object btnTotalAn: TMenuItem
          Action = actTotalAn
        end
        object N7: TMenuItem
          Caption = #1051#1091#1095#1096#1072#1103' '#1080' '#1093#1091#1076#1096#1072#1103' '#1076#1072#1090#1072' '#1087#1086'...'
          object btnBWIncome: TMenuItem
            Action = actBWIncome
          end
          object btnBWExpense: TMenuItem
            Action = actBWExpense
          end
          object btnBWTotal: TMenuItem
            Action = actBWTotal
          end
        end
      end
    end
  end
  object actList: TActionList
    OnUpdate = actListUpdate
    Left = 720
    Top = 16
    object actOpen: TAction
      Category = #1060#1072#1081#1083
      Caption = #1054#1090#1082#1088#1099#1090#1100
      ShortCut = 16463
      OnExecute = actOpenExecute
    end
    object actSave: TAction
      Category = #1060#1072#1081#1083
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ShortCut = 16467
      OnExecute = actSaveExecute
    end
    object actSaveAll: TAction
      Category = #1060#1072#1081#1083
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1089#1105
      ShortCut = 24659
      OnExecute = actSaveAllExecute
    end
    object actBWIncome: TAction
      Category = #1040#1085#1072#1083#1080#1079
      Caption = #1055#1088#1080#1073#1099#1083#1080
      OnExecute = actBWIncomeExecute
    end
    object actExit: TAction
      Category = #1060#1072#1081#1083
      Caption = #1042#1099#1093#1086#1076
      OnExecute = actExitExecute
    end
    object actAdd: TAction
      Category = #1050#1085#1086#1087#1082#1080' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1079#1080#1094#1080#1102
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Category = #1050#1085#1086#1087#1082#1080' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1079#1080#1094#1080#1102
      OnExecute = actEditExecute
    end
    object actRemove: TAction
      Category = #1050#1085#1086#1087#1082#1080' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1079#1080#1094#1080#1102
      OnExecute = actRemoveExecute
    end
    object actSearch: TAction
      Caption = #1055#1086#1080#1089#1082
      ShortCut = 16454
    end
    object actClear: TAction
      Category = #1050#1085#1086#1087#1082#1080' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
      OnExecute = actClearExecute
    end
    object actGraphic: TAction
      Category = #1043#1088#1072#1092#1080#1082#1080
      Caption = #1043#1088#1072#1092#1080#1082#1080
      OnExecute = actGraphicExecute
    end
    object actBWSalesAmount: TAction
      Category = #1040#1085#1072#1083#1080#1079
      Caption = #1087#1088#1086#1076#1072#1078#1072#1084' ('#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086')'
      OnExecute = actBWSalesAmountExecute
    end
    object actBWSalesIncome: TAction
      Category = #1040#1085#1072#1083#1080#1079
      Caption = #1087#1088#1086#1076#1072#1078#1072#1084' ('#1087#1088#1080#1073#1099#1083#1100')'
      OnExecute = actBWSalesIncomeExecute
    end
    object actMPProd: TAction
      Category = #1040#1085#1072#1083#1080#1079
      Caption = #1053#1072#1080#1073#1086#1083#1077#1077' '#1080' '#1085#1072#1080#1084#1077#1085#1077#1077' '#1087#1086#1087#1091#1083#1103#1088#1085#1099#1081' '#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
      OnExecute = actMPProdExecute
    end
    object actTotalAn: TAction
      Category = #1040#1085#1072#1083#1080#1079
      Caption = #1054#1073#1097#1080#1081' '#1080#1090#1086#1075', '#1087#1088#1080#1073#1099#1083#1100' '#1080' '#1090#1088#1072#1090#1099
      OnExecute = actTotalAnExecute
    end
    object actBWExpense: TAction
      Category = #1040#1085#1072#1083#1080#1079
      Caption = #1058#1088#1072#1090#1072#1084
      OnExecute = actBWExpenseExecute
    end
    object actBWTotal: TAction
      Category = #1040#1085#1072#1083#1080#1079
      Caption = #1048#1090#1086#1075#1072#1084
      OnExecute = actBWTotalExecute
    end
    object actSaveGraphic: TAction
      Category = #1043#1088#1072#1092#1080#1082#1080
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1043#1088#1072#1092#1080#1082
      Enabled = False
      OnExecute = actSaveGraphicExecute
    end
    object actMPNameProdAmount: TAction
      Category = #1040#1085#1072#1083#1080#1079
      Caption = #1055#1086' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1091' '#1087#1088#1086#1076#1072#1078
      OnExecute = actMPNameProdAmountExecute
    end
    object actMPNameProdIncome: TAction
      Category = #1040#1085#1072#1083#1080#1079
      Caption = #1055#1086' '#1087#1088#1080#1073#1099#1083#1080
      OnExecute = actMPNameProdIncomeExecute
    end
  end
  object dlgOpen: TOpenDialog
    DefaultExt = '.table'
    Filter = #1060#1072#1081#1083'|*.table'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing, ofDontAddToRecent]
    Left = 760
    Top = 440
  end
  object dlgSave: TSaveDialog
    DefaultExt = '.table'
    Filter = #1058#1072#1073#1083#1080#1094#1072'|*.table|'#1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1092#1072#1081#1083'|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 860
    Top = 440
  end
end
