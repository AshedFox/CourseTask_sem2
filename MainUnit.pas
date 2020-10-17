unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus,
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ActnMan, Vcl.ActnCtrls,
  System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, Vcl.Mask, Vcl.Buttons, comObj,
  System.Win.TaskbarCore, Vcl.Taskbar, Vcl.ButtonGroup;

type
  TReportPosRec = Record
    Code: string[30];
    Name, Prod: string[50];
    amount: integer;
    price: real;
    VAT: integer;
    VatPrice, PriceSold: real;
    AmountSold: integer;
    income: real;
  End;
  TReportRec = Record
    Date: TDate;
    Income, Expense, Total: real;
  end;
  TReportPos = array of TReportPosRec;
  TReport = array of TReportRec;
  TFilePos = file of TReportPosRec;
  TFileTotal = file of TReportRec;
  TForm1 = class(TForm)
    MenuM: TMainMenu;
    btnFile: TMenuItem;
    lvReport: TListView;
    PnlButtons: TPanel;
    actList: TActionList;
    actSave: TAction;
    actSaveAll: TAction;
    btnOpen: TMenuItem;
    btnSave: TMenuItem;
    btnSaveAs: TMenuItem;
    N5: TMenuItem;
    actExit: TAction;
    N9: TMenuItem;
    btnExit: TMenuItem;
    btnAdd: TButton;
    btnRemove: TButton;
    btnEdit: TButton;
    btnGraphic: TMenuItem;
    btnAnalyze: TMenuItem;
    actAdd: TAction;
    actEdit: TAction;
    actRemove: TAction;
    actSearch: TAction;
    EditMaskSrch: TMaskEdit;
    ComBoxSrch: TComboBox;
    labelPos: TLabel;
    LabelCat: TLabel;
    BtnCancelSrch: TBitBtn;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    btnTablePos: TMenuItem;
    btnTableSales: TMenuItem;
    N1: TMenuItem;
    btnBWSalesAmount: TMenuItem;
    btnBWSalsesIncome: TMenuItem;
    N4: TMenuItem;
    N7: TMenuItem;
    btnBWIncome: TMenuItem;
    btnBWExpense: TMenuItem;
    btnBWTotal: TMenuItem;
    pnlTables: TPanel;
    btnTable1: TButton;
    btnTable2: TButton;
    btnTotalAn: TMenuItem;
    btnClear: TButton;
    actClear: TAction;
    actGraphic: TAction;
    actBWSalesAmount: TAction;
    actBWSalesIncome: TAction;
    actMPProd: TAction;
    actTotalAn: TAction;
    actBWExpense: TAction;
    actBWIncome: TAction;
    actBWTotal: TAction;
    actSaveGraphic: TAction;
    actOpen: TAction;
    actMPNameProdAmount: TAction;
    N2: TMenuItem;
    N3: TMenuItem;
    actMPNameProdIncome: TAction;
    N6: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure actListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actRemoveExecute(Sender: TObject);
    procedure lvReportColumnClick(Sender: TObject; Column: TListColumn);
    procedure ComBoxSrchSelect(Sender: TObject);
    procedure EditMaskSrchKeyPress(Sender: TObject; var Key: Char);
    procedure BtnCancelSrchClick(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure btnTable1Click(Sender: TObject);
    procedure btnTable2Click(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actTotalAnExecute(Sender: TObject);
    procedure actBWIncomeExecute(Sender: TObject);
    procedure actBWSalesAmountExecute(Sender: TObject);
    procedure actBWSalesIncomeExecute(Sender: TObject);
    procedure actBWExpenseExecute(Sender: TObject);
    procedure actBWTotalExecute(Sender: TObject);
    procedure actGraphicExecute(Sender: TObject);
    procedure actSaveGraphicExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actSaveAllExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actExitExecute(Sender: TObject);
    procedure actMPProdExecute(Sender: TObject);
    procedure actMPNameProdAmountExecute(Sender: TObject);
    procedure actMPNameProdIncomeExecute(Sender: TObject);
  private
    procedure AnalyzeTable(CaseToAnalyze:byte);
    procedure AddTotal(StartDate, EndDate: TDate);
    procedure AddPosition(const Code, Name, Prod: string; Amount: integer;
                          price: Real; VAT: integer; PriceSold: real; AmountSold:integer);
    procedure EditTotal(i: integer; Income, Expense: real);
    procedure EditPosition(I: integer; const Code, Name, Prod: string; Amount: integer;
                          price: Real; VAT: integer; PriceSold:real; amountSold:integer);
    procedure RemovePosition(I: integer);
    procedure UpdateView(ReportUpdate: TReportPos; ReportUpdate2: TReport);
    procedure Search(text: string);
    function SearchPosSetItem(index: integer):string;
    function SearchTotalSetItem(index: integer):string;
    procedure SortModel(column: integer;var UpdateReport: TReportPos);
    function CountXSort(left, right, ColumnNum: integer;UpdateReport: TReportPos): variant;
    function Check1Sort(i: integer; x: variant; ColumnNum:integer;UpdateReport: TReportPos): boolean;
    function Check2Sort(j: integer; x: variant; ColumnNum:integer;UpdateReport: TReportPos): boolean;
    //function Check3Sort(i, j, ColumnNum:integer;UpdateReport: TReportPos): boolean;
    procedure MostPopularProd;
    procedure MostPopularProdSearch(BuferReport: TReportPos);
    procedure MostPopularNameProdAmount(BuferReport: TReportPos);
    procedure MostPopularNameProdIncome(BuferReport: TReportPos);
  public
    FileInTxtPos, FileInTxtTotal: TextFile;
    FileInPos : TFilePos;
    FileInTotal : TFileTotal;
    IsMonth: boolean;
    ReportPos: TReportPos;
    ReportTotal: TReport;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
 uses AddForm, Graphic;
{$R *.dfm}


procedure TForm1.actListUpdate(Action: TBasicAction; var Handled: Boolean);
begin                        // обновление доступности некоторых действий
  actEdit.Enabled:=(lvReport.ItemIndex<>-1)and not (BtnCancelSrch.Enabled);
  actRemove.Enabled:=(lvReport.ItemIndex<>-1)and not (BtnCancelSrch.Enabled);

  if lvReport.Tag=0 then
  begin
    actAdd.Enabled:=True;
    actClear.Enabled:=(length(ReportPos)>0);
  end
  else
    actClear.Enabled:=(length(ReportTotal)>0);
  actBWSalesAmount.Enabled:=(High(ReportPos)>0);
  actBWSalesIncome.Enabled:=(High(ReportPos)>0);
  actBWIncome.Enabled:=(High(ReportTotal)>0);
  actBWExpense.Enabled:=(High(ReportTotal)>0);
  actBWTotal.Enabled:=(High(ReportTotal)>0);

  actMPProd.Enabled:=(High(ReportPos)>=0);
  actMPNameProdAmount.Enabled:=(High(ReportPos)>=0);
  actMPNameProdIncome.Enabled:=(High(ReportPos)>=0);
  actTotalAn.Enabled:=(High(ReportTotal)>=0);

  actGraphic.Enabled:=(High(ReportTotal)>1);
end;

procedure TForm1.actMPNameProdAmountExecute(Sender: TObject);
var BuferReport: TReportPos;
begin                    //определение самого популярного наименования по производителям
                         //по количеству (с подготовкой)
  lvReport.Selected:=nil;

  BuferReport:=Copy(ReportPos);
  SortModel(3, BuferReport);

  MostPopularNameProdAmount(BuferReport);

  BuferReport:=nil;
end;

procedure TForm1.actMPNameProdIncomeExecute(Sender: TObject);
var BuferReport: TReportPos;
begin                     //определение самого популярного наименования по производителям
                         //по прибыли (с подготовкой)
  lvReport.Selected:=nil;

  BuferReport:=Copy(ReportPos);
  SortModel(3, BuferReport);

  MostPopularNameProdIncome(BuferReport);

  BuferReport:=nil;
end;

procedure TForm1.actMPProdExecute(Sender: TObject);
begin
  lvReport.Selected:=nil;
  MostPopularProd;
end;

{function TForm1.Check3Sort(i, j: integer; columnNum: integer;UpdateReport:TReportPos): boolean;
begin
  result:=False;
  case columnNum of
    1:
      if UpdateReport[i].Code>UpdateReport[j].Code then
        result:=True;
    2:
      if UpdateReport[i].Name>UpdateReport[j].Name then
        result:=True;
    3:
      if UpdateReport[i].Prod>UpdateReport[j].Prod then
        result:=True;
    4:
      if UpdateReport[i].amount>UpdateReport[j].amount then
        result:=True;
    5:
      if UpdateReport[i].price>UpdateReport[j].price then
        result:=True;
    6:
      if UpdateReport[i].VAT>UpdateReport[j].VAT then
        result:=True;
    7:
      if UpdateReport[i].VatPrice>UpdateReport[j].VatPrice then
        result:=True;
    8:
      if UpdateReport[i].PriceSold>UpdateReport[j].PriceSold then
        result:=True;
    9:
      if UpdateReport[i].AmountSold>UpdateReport[j].AmountSold then
        result:=True;
    10:
      if UpdateReport[i].income>UpdateReport[j].income then
        result:=True;
  end;
end;}


procedure TForm1.actOpenExecute(Sender: TObject);
var i: integer;
begin              //открытие файла
  with DlgOpen do
  begin
    FileName:='';
    if lvReport.Tag=0 then
    begin
      if Execute then
      begin
        if FilterIndex=1 then
        begin
          AssignFile(FileInPos, FileName);
          Reset(FileInPos);
          i:=0;
          while not Eof(FileInPos) do
          begin
            SetLength(ReportPos, i+1);
            seek(FileInPos, i);
            read(FileInPos, ReportPos[i]);
            inc(i);
          end;
          closeFile(FileInPos);
        end;
        UpdateView(ReportPos, nil);
      end;
    end
    else
    begin
      if Execute then
      begin
        if FilterIndex=1 then
        begin
          AssignFile(FileInTotal, FileName);
          Reset(FileInTotal);
          i:=0;
          while not Eof(FileInTotal) do
          begin
            SetLength(ReportTotal, i+1);
            seek(FileInTotal, i);
            read(FileInTotal, ReportTotal[i]);
            inc(i);
          end;
          closeFile(FileInTotal);
        end;
        UpdateView(nil, ReportTotal);
      end;
    end;
  end;
end;

procedure TForm1.AddPosition(const Code: string; const Name: string; const Prod: string;
               Amount: Integer; price: Real; VAT: Integer; PriceSold: real; AmountSold: Integer);
var i: integer;
begin                  // внесение добавления в массив данных о товарах
  i:= length(ReportPos);
  SetLength(ReportPos, i+1);
  ReportPos[i].Code      := code;
  ReportPos[i].Name      := name;
  ReportPos[i].Prod      := Prod;
  ReportPos[i].amount    := Amount;
  ReportPos[i].price     := price;
  ReportPos[i].VAT       := VAT;
  ReportPos[i].VatPrice  := Round(price*(100+Vat)) / 100;
  ReportPos[i].PriceSold := ROund(PriceSold*100)/100;
  ReportPos[i].AmountSold:= AmountSold;
  ReportPos[i].income    := (ReportPos[i].PriceSold-ReportPos[i].VatPrice) * AmountSold;
end;


procedure TForm1.AddTotal(StartDate, EndDate: TDate);
var i: integer;
    CurDate: TDate;
begin                   // внесение добавления в массив данных о периодах
  i:=0;
  CurDate:=StartDate;
  if NOT IsMonth then
  begin
    SetLength(ReportTotal, (Trunc(EndDate)-Trunc(StartDate)+1));
    while CurDate<=EndDate do
    begin
      ReportTotal[i].Date      := CurDate;
      ReportTotal[i].Income    := 0.00;
      ReportTotal[i].Expense   := 0.00;
      ReportTotal[i].Total     := 0.00;
      CurDate:=CurDate+1;
      inc(i);
    end;
  end
  else
  begin
    while CurDate<=EndDate do
    begin
      SetLength(ReportTotal, i+1);
      ReportTotal[i].Date      := CurDate;
      ReportTotal[i].Income    := 0.00;
      ReportTotal[i].Expense   := 0.00;
      ReportTotal[i].Total     := 0.00;
      CurDate:=incMonth(CurDate);
      inc(i);
    end;
  end;
end;

procedure TForm1.AnalyzeTable(CaseToAnalyze: byte);
var i, BestIndex, WorstIndex:integer;
    Best, Worst: variant;
begin
  case CaseToAnalyze of
    1:
    begin                            //определение худшего и лучшего товара по количеству продаж
      Best:=ReportPos[0].AmountSold;
      Worst:=ReportPos[0].AmountSold;
      BestIndex:=0; WorstIndex:=0;
      for i := low(ReportPos)+1 to High(ReportPos) do
      begin
        if ReportPos[i].AmountSold>Best then
        begin
          Best:=ReportPos[i].AmountSold;
          BestIndex:=i;
        end;
        if ReportPos[i].AmountSold<Worst then
        begin
          Worst:=ReportPos[i].AmountSold;
          WorstIndex:=i;
        end;
      end;
      MessageBox(Handle, PWideChar('Худший по количеству продаж: '+ '#' + IntToStr(WorstIndex+1) + 
      ': ' +ReportPos[Worstindex].Name+#13+'Количество: '+IntToStr(ReportPos[Worstindex].AmountSold)
       +#13 + #13 + 'Лучший по количеству продаж: '+ '#'+ IntToStr(BestIndex+1)+ ': '
       +ReportPos[bestindex].Name+#13+ 'Количество: ' + IntToStr(ReportPos[bestindex].AmountSold)
       +#13+#13), 'Результат', MB_OK);
    end;
    2:
    begin                             //определение худшего и лучшего товара по прибыли
      Best:=ReportPos[0].Income;
      Worst:=ReportPos[0].Income;
      BestIndex:=0; WorstIndex:=0;
      for i := low(ReportPos)+1 to High(ReportPos) do
      begin
        if ReportPos[i].Income>Best then
        begin
          Best:=ReportPos[i].Income;
          BestIndex:=i;
        end;
        if ReportPos[i].Income<Worst then
        begin
          Worst:=ReportPos[i].Income;
          WorstIndex:=i;
        end;
      end;
      MessageBox(Handle, PWideChar('Худший по прибыли: '+ '#' + IntToStr(WorstIndex+1) + 
      ': ' +ReportPos[Worstindex].Name+#13+'Количество: '+FLoatToStr(ReportPos[Worstindex].income)
       +#13 + #13 + 'Лучший по прибыли: '+ '#'+ IntToStr(BestIndex+1)+ ': '
       +ReportPos[bestindex].Name+#13+ 'Количество: ' + FLoatToStr(ReportPos[bestindex].income)
       +#13+#13), 'Результат', MB_OK);
    end;
    3:
    begin                                //определение худшего и лучшего периода по прибыли
      Best:=ReportTotal[0].Income;
      Worst:=ReportTotal[0].Income;
      BestIndex:=0; WorstIndex:=0;
      for i := Low(ReportTotal)+1 to High(ReportTotal) do
      begin
        if ReportTotal[i].Income>Best then
        begin
          Best:=ReportTotal[i].Income;
          BestIndex:=i;
        end;
        if (ReportTotal[i].Income<Worst) and (ReportTotal[i].Income<>Best) then
        begin
          Worst:=ReportTotal[i].Income;
          WorstIndex:=i;
        end;
      end;
      MessageBox(Handle, PWideChar('Худшая дата по прибыли: '+ DateToStr(ReportTotal[Worstindex].dATe)
       +#13+'Прибыль: ' + FloatToStr(ReportTotal[Worstindex].Income) + #13 +#13 +
        'Лучшая дата по прибыли: ' +DateTOStr(ReportTotal[bestindex].Date)+ #13
         + 'Прибыль: ' + FloatToStr(ReportTotal[bestindex].Income)+#13+#13 ), 'Результат', MB_OK);
    end;
    4:
    begin                                       //определение худшего и лучшего периода по тратам
      Best:=ReportTotal[0].expense;
      Worst:=ReportTotal[0].expense;
      BestIndex:=0; WorstIndex:=0;
      for i := Low(ReportTotal)+1 to High(ReportTotal) do
      begin
        if ReportTotal[i].expense>Worst then
        begin
          Worst:=ReportTotal[i].expense;
          WorstIndex:=i;
        end;
        if (ReportTotal[i].expense<Best) and (ReportTotal[i].expense<>Worst) then
        begin
          Best:=ReportTotal[i].expense;
          BestIndex:=i;
        end;
      end;
      MessageBox(Handle, PWideChar('Худшая дата по тратам: '+ DateToStr(ReportTotal[Worstindex].dATe)
       +#13+'Траты: ' + FloatToStr(ReportTotal[Worstindex].Expense) + #13 +#13 +
        'Лучшая дата по тратам: ' +DateTOStr(ReportTotal[bestindex].Date) + #13
         + 'Траты: ' + FloatToStr(ReportTotal[bestindex].Expense)+#13+#13 ), 'Результат', MB_OK);
    end;
    5:                                                //определение худшего и лучшего периода по итогам
    begin
      Best:=ReportTotal[0].total;
      Worst:=ReportTotal[0].total;
      BestIndex:=0; WorstIndex:=0;
      for i := Low(ReportTotal)+1 to High(ReportTotal) do
      begin
        if ReportTotal[i].total>Worst then
        begin
          Best:=ReportTotal[i].total;
          BestIndex:=i;
        end;
        if (ReportTotal[i].total<Worst) and (ReportTotal[i].total<>Best) then
        begin
          Worst:=ReportTotal[i].total;
          WorstIndex:=i;
        end;
      end;
      MessageBox(Handle, PWideChar('Худшая дата по итогу: '+ DateToStr(ReportTotal[Worstindex].dATe)
       +#13+'Итог: ' + FloatToStr(ReportTotal[Worstindex].Total) + #13 +#13 +
        'Лучшая дата по итогам: ' +DateTOStr(ReportTotal[bestindex].Date) + #13
         + 'Итог: ' + FloatToStr(ReportTotal[bestindex].Total)+#13+#13 ), 'Результат', MB_OK);
    end;
  end;

end;

procedure TForm1.BtnCancelSrchClick(Sender: TObject);
begin
  if lvReport.Tag=0 then
    UpdateView(ReportPos, nil)
  else
    UpdateView(nil, ReportTotal);
  EditMAskSrch.text:='';
  EditMaskSrch.Enabled:=True;
  ComBoxSrch.Enabled:=True;
  BtnCancelSrch.Enabled:=False;
end;

procedure TForm1.btnTable1Click(Sender: TObject);
var i: integer;
begin                                    //переключение на таблицу товаров
  lvReport.Tag:=0;
  with lvReport do
  begin
    Clear;
    Columns.Clear;
    Columns.Add; Columns[0].Caption:='#';               Column[0].Width:=30;
    Columns.Add; Columns[1].Caption:='Код';             Column[1].Width:=50;
    Columns.Add; Columns[2].Caption:='Наименование';    Column[2].Width:=150;
    Columns.Add; Columns[3].Caption:='Производитель';   Column[3].Width:=150;
    Columns.Add; Columns[4].Caption:='Количество';      Column[4].Width:=80;
    Columns.Add; Columns[5].Caption:='Закупочная цена'; Column[5].Width:=100;
    Columns.Add; Columns[6].Caption:='НДС(%)';          Column[6].Width:=60;
    Columns.Add; Columns[7].Caption:='Цена с НДС';      Column[7].Width:=100;
    Columns.Add; Columns[8].Caption:='Цена продажи';    Column[8].Width:=100;
    Columns.Add; Columns[9].Caption:='Продано';         Column[9].Width:=80;
    Columns.Add; Columns[10].Caption:='Прибыль';        Column[10].Width:=80;
  end;
  ComBoxSrch.Clear;
  comboxsrch.Items.Add('');
  for i := 1 to lvReport.Columns.Count-1 do
    comboxsrch.Items.Add(lvReport.Column[i].caption);
  EditMaskSrch.Enabled:=False;
  UpdateView(ReportPos, nil);
  btnTable1.Enabled:=False;
  btnTable2.Enabled:=True;
end;

procedure TForm1.btnTable2Click(Sender: TObject);
var i: integer;
begin                                    //переключение на таблицу итогов
  lvReport.Tag:=1;
  with lvReport do
  begin
    Clear;
    Columns.Clear;
    Columns.Add; Columns[0].Caption:='#';           Column[0].Width:=30;
    Columns.Add; Columns[1].Caption:='Дата';        Column[1].Width:=150;
    Columns.Add; Columns[2].Caption:='Прибыль';     Column[2].Width:=150;
    Columns.Add; Columns[3].Caption:='Траты';       Column[3].Width:=150;
    Columns.Add; Columns[4].Caption:='Итог';        Column[4].Width:=150;
  end;
  ComBoxSrch.Clear;
  comboxsrch.Items.Add('');
  for i := 1 to lvReport.Columns.Count-1 do
    comboxsrch.Items.Add(lvReport.Column[i].caption);
  EditMaskSrch.Enabled:=False;
  UpdateView(nil, ReportTotal);
  btnTable2.Enabled:=False;
  btnTable1.Enabled:=True;
end;


procedure TForm1.actAddExecute(Sender: TObject);
var Res: TModalResult;
    index: integer;
begin                                   // добавление (включая вызов формы для добавления)
  if (not Assigned(Form2)) then
    Form2:=TForm2.Create(Self);
  if lvReport.Tag=0 then
  begin
    Res:= Form2.AddNewPosition;
    if Res<>mrOk then Exit;
    with Form2 do
      AddPosition(Code, Name, Prod, Amount, price, VAT, PriceSold, AmountSold);
    UpdateView(ReportPos, nil);
  end
  else
  begin
    if length(ReportTotal)>0 then
    begin
      if BtnCancelSrch.Enabled then
        BtnCancelSrchClick(nil);
      SetLength(ReportTotal, length(ReportTotal)+1);
      index:=High(ReportTotal);
      if IsMonth then
        ReportTotal[index].Date:=incMonth(ReportTotal[index-1].Date)
      else
        ReportTotal[index].Date:=ReportTotal[index-1].Date+1;
      ReportTotal[index].Income:=0;
      ReportTotal[index].Expense:=0;
      ReportTotal[index].Total:=0;
    end
    else
    begin
      Res:= Form2.AddNewTotal;
      if Res<>mrOk then Exit;
      IsMonth:=Form2.IsMonth;
      with Form2 do
        AddTotal(StartDate, EndDate);
    end;
    UpdateView(nil, ReportTotal);
  end;
end;

function TForm1.SearchPosSetItem(index: integer):string;
begin
  if ComBoxSrch.Text=lvReport.Column[1].Caption then
    result:=ReportPos[index].Code
  else
  begin
    if ComBoxSrch.Text=lvReport.Column[2].Caption then
      result:=ReportPos[index].Name
    else
    begin
      if ComBoxSrch.Text=lvReport.Column[3].Caption then
        result:=ReportPos[index].Prod
      else
      begin
        if ComBoxSrch.Text=lvReport.Column[4].Caption then
          result:=IntToStr(ReportPos[index].amount)
        else
        begin
          if ComBoxSrch.Text=lvReport.Column[5].Caption then
            result:=FloatToStr(ReportPos[index].price)
          else
          begin
            if ComBoxSrch.Text=lvReport.Column[6].Caption then
              result:=IntToStr(ReportPos[index].VAT)
            else
            begin
              if ComBoxSrch.Text=lvReport.Column[7].Caption then
                result:=FloatToStr(ReportPos[index].VatPrice)
              else
              begin
                if ComBoxSrch.Text=lvReport.Column[8].Caption then
                  result:=FloatToStr(ReportPos[index].PriceSold)
                else
                begin
                  if ComBoxSrch.Text=lvReport.Column[9].Caption then
                    result:=IntToStr(ReportPos[index].AmountSold)
                  else
                    if ComBoxSrch.Text=lvReport.Column[10].Caption then
                      result:=FloatToStr(ReportPos[index].income);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TForm1.SearchTotalSetItem(index: integer): string;
begin
  if ComBoxSrch.Text=lvReport.Column[1].Caption then
    result:=DateToStr(ReportTotal[index].Date)
  else
  begin
    if ComBoxSrch.Text=lvReport.Column[2].Caption then
      result:=FloatToStr(ReportTotal[index].Income)
    else
    begin
      if ComBoxSrch.Text=lvReport.Column[3].Caption then
        result:=FloatToStr(ReportTotal[index].Expense)
      else
      begin
        if ComBoxSrch.Text=lvReport.Column[4].Caption then
          result:=FloatToStr(ReportTotal[index].Total)
      end;
    end;
  end;
end;

procedure TForm1.SortModel(column: integer;var UpdateReport: TReportPos);
var i, j: integer;
    x: variant;
    y: TReportPosRec;
Procedure Sort(left, Right: integer);        //быстрая сортировка
begin
  i:=left; j:=right;
  x:=CountXSort(left, right,column,UpdateReport);
  while i<j do
  begin
    while Check1Sort(i, x, column,UpdateReport) do
      inc(i);
    while Check2Sort(j, x, column,UpdateReport) do
      dec(j);
    if i<=j then
    begin
     //if Check3Sort(i, j, column,UpdateReport) then
     //begin
        y:=UpdateReport[i];
        UpdateReport[i]:=UpdateReport[j];
        UpdateReport[j]:=y;
     //end;
      inc(i);
      dec(j);

    end;
  end;
  if left<j then
    Sort(left, j);
  if i<right then
    Sort(i, right);
end;
begin
  Sort(Low(UpdateReport), High(UpdateReport));
end;

procedure TForm1.Search(text: string);
var BuferReport:TReportPos;
    BuferReport2:TReport;
    i: integer;
begin                                // поиск
  if lvReport.Tag=0 then
  begin
    SetLength(BuferReport, 0);
    for i := 0 to High(ReportPos) do
      if Pos(text, SearchPosSetItem(i))>0 then
      begin
        SetLength(BuferReport, length(buferReport)+1);
        BuferReport[High(BuferReport)]:=ReportPos[i]
      end;
    if length(BuferReport)>0 then
    begin
      UpdateView(BuferReport, nil);
      EditMaskSrch.enabled:=False;
      ComBoxSrch.Enabled:=False;
      BtnCancelSrch.Enabled:=True;
    end
    else
      MessageBox(Handle, 'Позиция не найдена', 'Уведомление', MB_OK or MB_ICONQUESTION);
  end
  else
  begin
    SetLength(BuferReport2,0);
    for i := 0 to High(ReportTotal) do
      if Pos(text, SearchTotalSetItem(i))>0 then
      begin
        SetLength(BuferReport2, length(buferReport2)+1);
        BuferReport2[High(BuferReport2)]:=ReportTotal[i];
      end;
    if length(BuferReport2)>0 then
    begin
      UpdateView(nil, BuferReport2);
      EditMaskSrch.enabled:=False;
      ComBoxSrch.Enabled:=False;
      BtnCancelSrch.Enabled:=True;
    end
    else
      MessageBox(Handle, 'Позиция не найдена', 'Уведомление', MB_OK or MB_ICONQUESTION);
  end;
end;

procedure TForm1.EditMaskSrchKeyPress(Sender: TObject; var Key: Char);
begin                              // обработка нажатия Enter в поле ввода для поиска
  if key = ^M then
  begin
    Search(editmaskSrch.Text);
    key:=#0;
  end;
end;

procedure TForm1.EditPosition(I: integer; const Code, Name, Prod: string;
  Amount: integer; price: Real; VAT:integer; PriceSold:real; AmountSold: integer);
begin                                   // Внесение изменений в массив товаров
  ReportPos[i].Code      := code;
  ReportPos[i].Name      := name;
  ReportPos[i].Prod      := Prod;
  ReportPos[i].amount    := Amount;
  ReportPos[i].price     := price;
  ReportPos[i].VAT       := VAT;
  ReportPos[i].VatPrice  := price*(100+Vat) / 100;
  ReportPos[i].PriceSold := PriceSold;
  ReportPos[i].AmountSold:= AmountSold;
  ReportPos[i].income    := (ReportPos[i].PriceSold-ReportPos[i].VatPrice) * AmountSold;
end;

procedure TForm1.EditTotal(i: integer;Income, Expense: real);
begin                                        // Внесение изменений в массив периодов
  ReportTotal[i].Income    := Income;
  ReportTotal[i].Expense   := Expense;
  ReportTotal[i].Total     := Round((income-Expense)*1000)/1000;
end;

procedure TForm1.actRemoveExecute(Sender: TObject);
var i: integer;
begin                                //удаление
  i:=lvReport.ItemIndex;
  RemovePosition(i);
  if lvReport.Tag=0 then
    UpdateView(ReportPos, nil)
  else
    UpdateView(nil, ReportTotal);
  if i<lvReport.Items.Count then
    lvReport.ItemIndex:=i
  else
    lvReport.ItemIndex:=i-1;
end;

procedure TForm1.actSaveAllExecute(Sender: TObject);
var i: integer;
begin                            // сохранение обоих массивов данных
   with dlgSave do
  begin
    if Length(ReportPos)>0 then
    begin
      FileName:='Таблица товаров';
      if Execute then
      begin
        if FilterIndex=1 then
        begin
          AssignFile(FileInPos, FileName);
          Rewrite(FileInPos);
          for i := Low(ReportPos) to High(ReportPos) do
            write(FileInPos, ReportPos[i]);
           CloseFile(FileInPos);
        end;
        if FilterIndex=2 then
        begin
          AssignFile(FileInTxtPos, FileName);
          Rewrite(FileInTxtPos);
          writeln(FileInTxtPos,'|','Код':30,'|','Наименование':50,'|','Производитель':50,'|','Количество','|'
                ,'Цена':10,'|','НДС','|','Цена С НДС':11,'|','Цена продажи':12,'|','Количество проданых':20,'|',
                  'Прибыль':14,'|');
          for i := Low(ReportPos) to High(ReportPos) do
          begin
            with ReportPos[i] do
                  writeln(FileInTxtPos, '|',Code:30,'|',Name:50,'|',Prod:50,'|',amount:10,'|',price:10:3
                  ,'|',VAT:3,'|',VatPrice:11,'|',PriceSold:12:3,'|',AmountSold:20,'|',income:14:3,'|');
          end;
          CloseFile(FileInTxtPos);
        end;
      end;
    end
    else
      MessageBox(Handle, 'Таблица товаров пуста, сохранение невозможно', 'Сообщение', MB_OK or MB_ICONWARNING);
    if length(ReportTotal)>0 then
     begin
       FileName:='Таблица итогов';
       if Execute then
       begin
         if FilterIndex=1 then
         begin
           AssignFile(FileInTotal, FileName);
           Rewrite(FileInTotal);
           for i := Low(ReportTotal) to High(ReportTotal) do
             write(FileInTotal, ReportTotal[i]);
           CloseFile(FileInTotal);
         end;
         if FilterIndex=2 then
         begin
           AssignFile(FileInTxtTotal, FileName);
           Rewrite(FileInTxtTotal);
           writeln(FileInTxtTotal,'|','Дата':12,'|','Прибыль':15,'|','Траты':15,'|','Итог':15,'|');
           for i := Low(ReportTotal) to High(ReportTotal) do
           begin
             with ReportTotal[i] do
               writeln(FileInTxtTotal, '|',Date:12,'|',Income:15,'|',Expense:15,'|',Total:15,'|');
           end;
           CloseFile(FileInTxtPos);
         end;
       end;
     end
     else
       MessageBox(Handle, 'Таблица итогов пуста, сохранение невозможно', 'Сообщение', MB_OK or MB_ICONWARNING);
  end;
end;

procedure TForm1.actSaveExecute(Sender: TObject);
var i: integer;
begin                              // сохранение одного из массивов данных
  with dlgSave do
  begin
    if lvReport.Items.Count>0 then
    begin
      if lvReport.Tag=0 then
      begin
        FileName:='Таблица товаров';
        if Execute then
        begin
          if FilterIndex=1 then
          begin
            AssignFile(FileInPos, FileName);
            Rewrite(FileInPos);
            for i := Low(ReportPos) to High(ReportPos) do
              write(FileInPos, ReportPos[i]);
            CloseFile(FileInPos);
          end;
          if FilterIndex=2 then
          begin
            AssignFile(FileInTxtPos, FileName);
            Rewrite(FileInTxtPos);
            writeln(FileInTxtPos,'|','Код':30,'|','Наименование':50,'|','Производитель':50,'|','Количество','|'
                ,'Цена':10,'|','НДС','|','Цена С НДС':11,'|','Цена продажи':12,'|','Количество проданых':20,'|',
                  'Прибыль':14,'|');
            for i := Low(ReportPos) to High(ReportPos) do
            begin
              with ReportPos[i] do
                  writeln(FileInTxtPos, '|',Code:30,'|',Name:50,'|',Prod:50,'|',amount:10,'|',price:10:3
                  ,'|',VAT:3,'|',VatPrice:11:3,'|',PriceSold:12:3,'|',AmountSold:20,'|',income:14:3,'|');
            end;
            CloseFile(FileInTxtPos);
          end;
        end;
      end
      else
      begin
        FileName:='Таблица итогов';
        if Execute then
        begin
          if FilterIndex=1 then
          begin
            AssignFile(FileInTotal, FileName);
            Rewrite(FileInTotal);
            for i := Low(ReportTotal) to High(ReportTotal) do
              write(FileInTotal, ReportTotal[i]);
            CloseFile(FileInTotal);
          end;
          if FilterIndex=2 then
          begin
            AssignFile(FileInTxtTotal, FileName);
            Rewrite(FileInTxtTotal);
            writeln(FileInTxtTotal,'|','Дата':12,'|','Прибыль':15,'|','Траты':15,'|','Итог':15,'|');
            for i := Low(ReportTotal) to High(ReportTotal) do
            begin
              with ReportTotal[i] do
              writeln(FileInTxtTotal, '|',Date:12,'|',Income:15:3,'|',Expense:15:3,'|',Total:15:3,'|');
            end;
            CloseFile(FileInTxtPos);
          end;
        end;
      end;
    end
    else
      MessageBox(Handle, 'Таблица пуста, сохранение невозможно', 'Сообщение', MB_OK or MB_ICONWARNING);
  end;
end;

procedure TForm1.actSaveGraphicExecute(Sender: TObject);
begin                           // сохранение графика
  with Form3 do
  begin
    with DlgSaveGraphic do
    begin
      FileName:='chart';
      if Execute then
        Image1.Picture.SaveTofile(FileName);
    end;
  end;
end;

procedure TForm1.actTotalAnExecute(Sender: TObject);
var Total, Income, Expense: real;
    I: integer;
begin                         // Определение общей прибыли, трат и итогов за периоды
  Income:=0; Expense:=0;
  for i := Low(ReportTotal) to High(ReportTotal) do
  begin
    income:=income+ReportTOtal[i].Income;
    expense:=expense+ReportTOtal[i].expense;
    Total:=Total+ReportTOtal[i].Total;
  end;
  MessageBox(Handle, PWideChar('Общая прибыль за период: ' + FloatToStr(Income) + #13#13 +
      'Общие траты за период: ' + FloatToStr(Expense) + #13#13 +
      'Общий итог за период: ' + FloatToStr(Income-Expense) +#13#13), 'Результат', MB_Ok);
end;


procedure TForm1.actBWSalesAmountExecute(Sender: TObject);
begin
  AnalyzeTable(1);
end;

procedure TForm1.actBWSalesIncomeExecute(Sender: TObject);
begin
  AnalyzeTable(2);
end;

procedure TForm1.actBWIncomeExecute(Sender: TObject);
begin
  AnalyzeTable(3);
end;

procedure TForm1.actBWExpenseExecute(Sender: TObject);
begin
  AnalyzeTable(4);
end;

procedure TForm1.actBWTotalExecute(Sender: TObject);
begin
  AnalyzeTable(5);
end;

procedure TForm1.actClearExecute(Sender: TObject);
begin                            // очистка всех данных массива, который сейчас отображается
  if BtnCancelSrch.Enabled then
    BtnCancelSrchClick(nil);
  LvReport.Clear;
  if lvReport.Tag=0 then
    ReportPos:=nil
  else
    ReportTotal:=nil;
  btnAdd.Enabled:=True;
  btnClear.Enabled:=False;
end;

procedure TForm1.actEditExecute(Sender: TObject);
var i: integer;
    res: TModalResult;
    Item: TListItem;
begin                             // изменение (с вызовом окна изменения)
  Item:=lvReport.Selected;
  i:= lvReport.ItemIndex;
    if (not Assigned(Form2)) then
      Form2:=TForm2.Create(Self);
    if lvReport.Tag=0 then
    begin
      Res:= Form2.EditCurPosition(I, ReportPos[i].Code, ReportPos[i].Name, ReportPos[i].Prod,
                                ReportPos[i].Amount, ReportPos[i].Price, ReportPos[i].Vat,
                                ReportPos[i].PriceSold, ReportPos[i].AmountSold);
      if Res<>mrOk then Exit;
      with Form2 do
        EditPosition(I, Code, Name, Prod, Amount, price, VAT, PriceSold, AmountSold);
      UpdateView(ReportPos, nil);
    end
    else
    begin
      Res:= Form2.EditCurTotal(ReportTotal[i].Income, ReportTotal[i].Expense);
      if Res<>mrOk then Exit;
      with Form2 do
        EditTotal(i, income, Expense);
      UpdateView(nil, ReportTotal);
      if i<lvReport.Items.Count-1 then
        LvReport.ItemIndex:=i+1;
    end;

end;

procedure TForm1.actExitExecute(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.actGraphicExecute(Sender: TObject);
begin               // открытие окна для анализа и прогнозирования с построением графиков
  if length(ReportTotal)<=366 then
  begin
    if (not Assigned(Form3)) then
      Form3:=TForm3.Create(Self);
    form3.Show;
  end
  else
  begin
    MessageBox(Handle, 'Превышено количество позиций (366), построение графика невозможно.',
      'Предупреждение', MB_Ok or MB_ICONWARNING);
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin                             // обработка закрытия основного окна
  canClose:=MessageBox(Handle, 'Вы точно хотите закрыть приложение (несохранённые данные могут быть утеряны)?',
      'Предупреждение', MB_OKCancel or MB_ICONWARNING)=mrOK;
  if CanClose then
  begin
    ReportPos:=nil;
    ReportTotal:=nil;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i: integer;
begin
  dlgOpen.InitialDir:=ExtractFilePath(Application.ExeName);
  dlgSave.InitialDir:=ExtractFilePath(Application.ExeName);
  form1.WindowState:=wsMaximized;
end;

procedure TForm1.RemovePosition(I: integer);
var j: integer;
begin                 // удаление
  if lvReport.Tag=0  then
  begin
    for j := i to High(ReportPos)-1 do
      ReportPos[j]:=ReportPos[j+1];
    Setlength(ReportPos, length(ReportPos)-1);
  end
  else
  begin
    for j := i to High(ReportTotal)-1 do
      ReportTotal[j]:=ReportTotal[j+1];
    Setlength(ReportTotal, length(ReportTotal)-1);
  end;
end;

function TForm1.Check1Sort(i: integer; x: variant; columnNum: integer; UpdateReport: TReportPos): boolean;
begin
  result:=False;
  case columnNum of
    1:
      if UpdateReport[i].Code<x then
        result:=True;
    2:
      if UpdateReport[i].Name<x then
        result:=True;
    3:
      if UpdateReport[i].Prod<x then
        result:=True;
    4:
      if UpdateReport[i].amount<x then
        result:=True;
    5:
      if UpdateReport[i].price<x then
        result:=True;
    6:
      if UpdateReport[i].VAT<x then
        result:=True;
    7:
      if UpdateReport[i].VatPrice<x then
        result:=True;
    8:
      if UpdateReport[i].PriceSold<x then
        result:=True;
    9:
      if UpdateReport[i].AmountSold<x then
        result:=True;
    10:
      if UpdateReport[i].income<x then
        result:=True;
  end;
end;

function TForm1.Check2Sort(j: integer; x: variant; columnNum: integer;UpdateReport:TReportPos): boolean;
begin
  result:=False;
  case columnNum of
    1:
      if UpdateReport[j].Code>x then
        result:=True;
    2:
      if UpdateReport[j].Name>x then
        result:=True;
    3:
      if UpdateReport[j].Prod>x then
        result:=True;
    4:
      if UpdateReport[j].amount>x then
        result:=True;
    5:
      if UpdateReport[j].price>x then
        result:=True;
    6:
      if UpdateReport[j].VAT>x then
        result:=True;
    7:
      if UpdateReport[j].VatPrice>x then
        result:=True;
    8:
      if UpdateReport[j].PriceSold>x then
        result:=True;
    9:
      if UpdateReport[j].AmountSold>x then
        result:=True;
    10:
      if UpdateReport[j].income>x then
        result:=True;
  end;
end;

{function TForm1.Check3Sort(i, j: integer; columnNum: integer;UpdateReport:TReportPos): boolean;
begin
  result:=False;
  case columnNum of
    1:
      if UpdateReport[i].Code>UpdateReport[j].Code then
        result:=True;
    2:
      if UpdateReport[i].Name>UpdateReport[j].Name then
        result:=True;
    3:
      if UpdateReport[i].Prod>UpdateReport[j].Prod then
        result:=True;
    4:
      if UpdateReport[i].amount>UpdateReport[j].amount then
        result:=True;
    5:
      if UpdateReport[i].price>UpdateReport[j].price then
        result:=True;
    6:
      if UpdateReport[i].VAT>UpdateReport[j].VAT then
        result:=True;
    7:
      if UpdateReport[i].VatPrice>UpdateReport[j].VatPrice then
        result:=True;
    8:
      if UpdateReport[i].PriceSold>UpdateReport[j].PriceSold then
        result:=True;
    9:
      if UpdateReport[i].AmountSold>UpdateReport[j].AmountSold then
        result:=True;
    10:
      if UpdateReport[i].income>UpdateReport[j].income then
        result:=True;
  end;
end;}

function Tform1.CountXSort(left: Integer; right: Integer; ColumnNum: Integer;UpdateReport:TReportPos) : variant;
begin
  case columnNum of
    1:  result:=UpdateReport[left+random(right-left+1)].Code;
    2:  result:=UpdateReport[left+random(right-left+1)].Name;
    3:  result:=UpdateReport[left+random(right-left+1)].Prod;
    4:  result:=UpdateReport[left+random(right-left+1)].amount;
    5:  result:=UpdateReport[left+random(right-left+1)].price;
    6:  result:=UpdateReport[left+random(right-left+1)].VAT;
    7:  result:=UpdateReport[left+random(right-left+1)].VatPrice;
    8:  result:=UpdateReport[left+random(right-left+1)].PriceSold;
    9:  result:=UpdateReport[left+random(right-left+1)].AmountSold;
    10: result:=UpdateReport[left+random(right-left+1)].income;
  end;
end;

procedure TForm1.ComBoxSrchSelect(Sender: TObject);
begin                  // обработка активации возможности ввода в поле ввода для поиска
                       // по выбору колонки для поиска
  if comboxsrch.Text='' then
  begin
    EditMaskSrch.Enabled:=False;
    EditMaskSrch.Text:='';
  end
  else
    EditMaskSrch.Enabled:=True;
end;


procedure TForm1.lvReportColumnClick(Sender: TObject; Column: TListColumn);
begin                           // обработка сортировки по нажатию на колонку списка
  if lvReport.tag=0 then
  begin
    if lvReport.Items.Count>1 then
    begin
      SortModel(Column.index, ReportPos);
      UpdateView(ReportPos, nil);
    end;
  end
  else
    MessageBox(Handle, 'Сортировка недоступна для данной таблицы', 'Сообщение', Mb_Ok or MB_ICONINFORMATION);
end;

procedure TForm1.MostPopularNameProdAmount(BuferReport: TReportPos);
  var BuferProd, NameBest, FinishLine: string;
    AmountBest, i: integer;
begin                  //определение наиболее популярного наименования по производителям по кол-ву
  i:=0;
  FinishLine:='';
  while i<=High(BuferReport) do
  begin
    BuferProd:=BuferReport[i].Prod;
    AmountBest:=0;
    while BuferProd=BuferReport[i].Prod do
    begin
      if BuferReport[i].amountSold>AmountBest then
      begin
        NameBest:=BuferReport[i].Name;
        AmountBest:=BuferReport[i].amountSold;
      end;
      inc(i);
    end;
    FinishLine:=FinishLine+'Лучший товар у производителя ' + BuferProd + ': '+ NameBest + #13 +
     'Количество: ' + IntToStr(AmountBest)+ #13+#13;
  end;
  MessageBox(Handle, PWideChar('Лучшие товары по производителям (по количеству продаж)' + #13+#13
   + FInishLine), 'Результат', MB_Ok);
end;


procedure TForm1.MostPopularNameProdIncome(BuferReport: TReportPos);
var BuferProd, NameBest, FinishLine: string;
    i: integer;
    IncomeBest: real;
begin                 //определение наиболее популярного наименования по производителям по прибыли
  i:=0;
  FinishLine:='';
  while i<=High(BuferReport) do
  begin
    BuferProd:=BuferReport[i].Prod;
    IncomeBest:=0;
    while BuferProd=BuferReport[i].Prod do
    begin
      if BuferReport[i].income>IncomeBest then
      begin
        NameBest:=BuferReport[i].Name;
        IncomeBest:=BuferReport[i].income;
      end;
      inc(i);
    end;
    FinishLine:=FinishLine+'Лучший товар у производителя ' + BuferProd + ': '+ NameBest + #13 +
     'Прибыль: ' + FloatToStr(IncomeBest)+ #13+#13;
  end;
  MessageBox(Handle, PWideChar('Лучшие товары по производителям (по прибыли)' + #13+#13
   + FInishLine), 'Результат', MB_Ok);
end;

procedure TForm1.MostPopularProd;
var BuferReport: TReportPos;
begin                    //определение самого популярного производителя (с подготовкой)
  BuferReport:=Copy(ReportPos);
  SortModel(3, BuferReport);
  MostPopularProdSearch(BuferReport);

  BuferReport:=nil;
end;

procedure TForm1.MostPopularProdSearch(BuferReport: TReportPos);
var ProdBest, ProdCur, ProdWorst: string;
    AmountBest, AmountCur, AmountWorst, i: integer;
begin                        //определение самого популярного производителя
  i:=0;
  AmountBest:=0;
  ProdBest:=BuferReport[0].Prod;
  while ProdBest=BuferReport[i].Prod do
  begin
    inc(AmountBest);
    inc(i);
  end;
  ProdWorst:=ProdBest;
  AmountWorst:=AmountBest;
  while i <= High(BuferReport) do
  begin
    AmountCur:=0;
    ProdCur:=BuferReport[i].Prod;
    while (i<=High(BuferReport)) and (ProdCur=BuferReport[i].Prod) do
    begin
      inc(AmountCur);
      inc(i);
    end;
    if AmountCur>AmountBest then
    begin
      ProdBest:=ProdCur;
      AmountBest:=AmountCur;
    end;
    if AmountCur<AmountWorst then
    begin
      ProdWorst:=ProdCur;
      AmountWorst:=AmountCur;
    end;
  end;
  if AmountBest<>AmountWorst then
    MessageBox(Handle, PChar('Наиболее популярный: ' + ProdBest+#13'Количество наименований: '
      +IntToStr(AmountBest)+#13+#13+
      'Наименее популярный: '+ProdWorst+#13+'Количество наименований: '+IntToStr(AmountWOrst)+#13+#13),
      'Наиболее и наименее популярный производитель', MB_Ok)
  else
    MessageBox(Handle, PChar('Наиболее популярный: ' + ProdBest +#13+'Количество наименований: '
      +IntToStr(AmountBest)+#13+ #13+
      'Наименее популярный не определён.'+#13+#13),
      'Наиболее и наименее популярный производитель', MB_Ok);
end;

procedure TForm1.UpdateView(ReportUpdate:TReportPos; ReportUpdate2:TReport);
var Item: TListItem;
    i: integer;
begin                       // обновление отображения
  lvReport.Items.Clear;
  if ReportUpdate2=nil then
    for i:=Low(ReportUpdate) to High(ReportUpdate) do
    begin
      Item := lvReport.Items.Add;
      Item.Caption := IntToStr(i+1);
      Item.SubItems.Add(ReportUpdate[i].Code);
      Item.SubItems.Add(ReportUpdate[i].Name);
      Item.SubItems.Add(ReportUpdate[i].Prod);
      Item.SubItems.Add(IntTostr(ReportUpdate[i].amount));
      Item.SubItems.Add(FloatToStr(ReportUpdate[i].price));
      Item.SubItems.Add(IntTostr(ReportUpdate[i].VAT));
      Item.SubItems.Add(FloatToStr(ReportUpdate[i].VatPrice));
      Item.SubItems.Add(FloatToStr(ReportUpdate[i].PriceSold));
      Item.SubItems.Add(IntTostr(ReportUpdate[i].AmountSold));
      Item.SubItems.Add(FloatToStr(ReportUpdate[i].income));
    end
  else
    for i := Low(ReportUpdate2) to High(ReportUpdate2) do
    begin
      Item := lvReport.Items.Add;
      Item.Caption := IntToStr(i+1);
      Item.SubItems.Add(DateToStr(ReportUpdate2[i].Date));
      Item.SubItems.Add(FloatToStr(ReportUpdate2[i].Income));
      Item.SubItems.Add(FloatToStr(ReportUpdate2[i].Expense));
      Item.SubItems.Add(FloatTostr(ReportUpdate2[i].Total));
    end;
end;



end.
