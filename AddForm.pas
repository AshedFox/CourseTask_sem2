unit AddForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Samples.Spin, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm2 = class(TForm)
    EditlbCode: TLabeledEdit;
    EditLbName: TLabeledEdit;
    EditLbProd: TLabeledEdit;
    EditSpinAmount: TSpinEdit;
    EditLbPrice: TLabeledEdit;
    EditLbVAT: TLabeledEdit;
    EditSpinAmountSold: TSpinEdit;
    LbAmount: TLabel;
    LbAmountSold: TLabel;
    BtnBitCancel: TBitBtn;
    BtnBitConfirm: TBitBtn;
    EditLbPriceSold: TLabeledEdit;
    editDateEnd: TDateTimePicker;
    lbStartDate: TLabel;
    editDateStart: TDateTimePicker;
    lbEndDate: TLabel;
    CheckBoxDate: TCheckBox;
    procedure FormShow(Sender: TObject);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EditLbPriceKeyPress(Sender: TObject; var Key: Char);
    procedure EditLbPriceSoldKeyPress(Sender: TObject; var Key: Char);
    procedure EditLbVATKeyPress(Sender: TObject; var Key: Char);
  private
    function GetCode: string;
    function GetName: string;
    function GetProd: string;
    function GetAmount: integer;
    function GetPrice: real;
    function GetVAT: integer;
    function GetAmountSold: integer;
    function GetPriceSold: real;


    function GetStartDate: TDate;
    function GetEndDate: TDate;
    function GetIncome: real;
    function GetExpense: real;
    function GetIsMonth: boolean;
    { Private declarations }
  public
    property Code: string read GetCode;
    property Name: string read GetName;
    property Prod: string read GetProd;
    property Amount: integer read GetAmount;
    property price: real read GetPrice;
    property VAT: integer read GetVAT;
    property PriceSold: real read GetPriceSold;
    property AmountSold: integer read GetAmountSold;
    property StartDate: TDate read GetStartDate;
    property EndDate: TDate read GetEndDate;
    property Income: real read GetIncome;
    property Expense: real read GetExpense;
    property IsMonth: boolean read GetIsMonth;

    function AddNewPosition :integer;
    function AddNewTotal: integer;
    function EditCurTotal (Income, Expense: real): integer;
    function EditCurPosition(Index: integer; const Code, Name, Prod: string; Amount: integer;
                          price: Real; VAT: integer;PriceSold: real;AmountSold:integer):integer;
  end;

var
  Form2: TForm2;
  PosIndex: integer;

implementation
 uses MainUnit;
{$R *.dfm}

function TForm2.AddNewPosition: integer;
begin
  caption:='Добавить позицию';
  tag:=0;

  CheckBoxDate.Visible:=False;
  editDateStart.Visible:=False;
  editDateEnd.Visible:=False;
  lbEndDate.Visible:=False;
  lbStartDate.Visible:=False;
  LbAmount.Visible:=True;
  LbAmountSold.Visible:=True;
  EditlbCode.Visible:=True;
  EditlbName.Visible:=True;
  EditLbProd.Visible:=True;
  EditSpinAmount.Visible:=True;
  EditlbPrice.Visible:=True;
  EditlbVAT.Visible:=True;

  EditlbPriceSold.Visible:=True;
  EditSpinAmountSold.Visible:=True;
  EditLbPrice.EditLabel.Caption:='Закупочная цена:';
  EditLbPriceSold.EditLabel.Caption:='Цена продажи:';
  editlbPrice.Top:=155;
  EditlbPrice.Width:=182+46;
  EditlbPriceSold.Width:=182+46;
  EditlbPriceSold.top:=155+60;
  editLbPrice.Left:=40;
  EditLbPriceSold.Left:=40;

  CheckBoxDate.Checked:=False;
  EditLbCode.text:='';
  EditLbName.text:='';
  EditLbProd.text:='';
  EditSpinAmount.text:='0';
  EditlbPrice.text:='0,00';
  EditlbVAT.text:='0';
  EditlbPriceSold.Text:='0,00';
  EditSpinAmountSold.text:='0';

  result:=ShowModal;
end;

function TForm2.AddNewTotal: integer;
begin
  caption:='Добавить период';
  tag:=2;

  CheckBoxDate.Visible:=True;
  editDateStart.Visible:=True;
  editDateEnd.Visible:=True;
  lbEndDate.Visible:=True;
  lbStartDate.Visible:=True;
  LbAmount.Visible:=False;
  LbAmountSold.Visible:=False;
  EditlbCode.Visible:=False;
  EditlbName.Visible:=False;
  EditLbProd.Visible:=False;
  EditSpinAmount.Visible:=False;
  EditlbPrice.Visible:=False;
  EditlbVAT.Visible:=False;
  EditlbPriceSold.Visible:=False;
  EditSpinAmountSold.Visible:=False;

  result:=ShowModal;
end;

function TForm2.EditCurPosition(index: integer;const Code, Name, Prod: string; Amount: integer;
  price: Real; VAT:integer; PriceSold:real; AmountSold: integer): integer;
begin
  Caption:='Изменить позицию';
  tag:=1;

  EditLbPrice.EditLabel.Caption:='Закупочная цена:';
  EditLbPriceSold.EditLabel.Caption:='Цена продажи:';

  CheckBoxDate.Visible:=False;
  editDateStart.Visible:=False;
  editDateEnd.Visible:=False;
  lbEndDate.Visible:=False;
  lbStartDate.Visible:=False;
  LbAmount.Visible:=True;
  LbAmountSold.Visible:=True;
  EditLbProd.Visible:=True;
  EditSpinAmount.Visible:=True;
  EditlbPrice.Visible:=True;
  EditlbVAT.Visible:=True;
  EditlbPriceSold.Visible:=True;
  EditSpinAmountSold.Visible:=True;
  EditLbCode.text:=code;
  EditLbName.text:=name;
  EditLbProd.text:=Prod;
  EditSpinAmount.text:=IntTOStr(Amount);
  EditlbPrice.text:=FloatToStr(Price);
  EditlbVAT.text:=IntTOStr(VAT);
  EditlbPriceSold.Text:=FloatToStr(PriceSold);
  EditSpinAmountSold.text:=IntTOStr(AmountSold);

  PosIndex:=Index;

  result:=ShowModal;
end;

function TForm2.EditCurTotal(Income, Expense: real): integer;
begin
  Caption:='Изменить позицию';
  tag:=3;

  EditLbPrice.EditLabel.Caption:='Прибыль:';
  EditLbPriceSold.EditLabel.Caption:='Траты:';
  EditlbPrice.Visible:=True;
  EditlbPriceSold.Visible:=True;
  EditlbPrice.Width:=300;
  EditlbPrice.top:=70;
  EditlbPriceSold.Width:=300;
  EditlbPriceSold.top:=180;
  editLbPrice.Left:=152;
  EditLbPriceSold.Left:=152;

  EditlbPrice.Text:=FloatToStr(Income);
  EditLbPriceSold.Text:=FloatToStr(Expense);

  CheckBoxDate.Visible:=False;
  EditlbCode.Visible:=False;
  EditLbName.Visible:=False;
  editDateStart.Visible:=False;
  editDateEnd.Visible:=False;
  lbEndDate.Visible:=False;
  lbStartDate.Visible:=False;
  LbAmount.Visible:=False;
  LbAmountSold.Visible:=False;
  EditLbProd.Visible:=False;
  EditSpinAmount.Visible:=False;
  EditlbVAT.Visible:=False;
  EditSpinAmountSold.Visible:=False;
  EditlbPrice.Text:=FloatToStr(Income);
  EditLbPriceSold.Text:=FloatToStr(Expense);
  result:=ShowModal;
end;

procedure TForm2.EditLbPriceKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '0'..'9',#8:
    ;
    '.',',':
    begin
      if key<>',' then
        Key := ',';
        if Pos(',', EditLbPrice.Text) <> 0
          then Key := Chr(0);
    end
    else
      key:=CHR(0);
  end;
end;

procedure TForm2.EditLbPriceSoldKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '0'..'9',#8:
    ;
    '.',',':
    begin
      if key<>',' then
        Key := ','; // заменим разделитель на допустимый
        if Pos(',', EditLbPriceSold.Text) <> 0
          then Key := Chr(0); // запрет ввода второго разделителя
    end
    else
      key:=CHR(0);
  end;
end;

procedure TForm2.EditLbVATKeyPress(Sender: TObject; var Key: Char);
begin
   case key of
    '0'..'9',#8: ;
     else
      key:=CHR(0);
   end;
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var res: integer;
    InputErrors: array[1..8] of string;
    i: Integer;
begin
  if ModalResult=MrOk then
  begin
    CanClose:=True;
    if (tag=0) or (tag=1) then
    begin
      i:=Low(Form1.ReportPos);
      while CanClose and (i <= High(Form1.ReportPos)) do
      begin
        if (Form1.ReportPos[i].Code=EditlbCode.Text) and (i<>PosIndex) then
            CanClose:=False;
        inc(i);
      end;
      if not CanClose then
      MessageBox(handle, PWideChar('Вы уже имеете позицию с данным кодом.'+#13),
       'Ошибка', MB_OK or MB_ICONWArning)
      else
      begin
        if EditSpinAmount.text='' then
          EditSpinAmount.text:='0';
        if EditSpinAmountSold.text='' then
          EditSpinAmountSold.text:='0';
        if EditLbPriceSold.text='' then
          EditLbPriceSold.text:='0';
        if EditLbPrice.text='' then
          EditLbPrice.text:='0';
        if EditLbVAT.text='' then
          EditLbVAT.text:='0';

        if EditlbCode.Text='' then
          InputErrors[1]:='-Код не введён'+#13;
        if EditlbName.Text='' then
          InputErrors[2]:='-Наименование не введено'+#13;
        if EditlbProd.Text='' then
          InputErrors[3]:='-Производитель не введён'+#13;
        if StrToInt(EditSpinAmount.Text)<=0 then
          InputErrors[4]:='-Количество отрицательное или нулевое'+#13;
        if StrToFloat(EditLbPrice.Text)<=0 then
          InputErrors[5]:='-Закупочная цена отрицательная или нулевая'+#13;
        if (StrToInt(EditLbVAT.Text)<0) or (StrToInt(EditLbVAT.Text)>30) then
          InputErrors[6]:='-НДС не попадает в допустимый диапазон от 0 до 30%'+#13;
        if StrToFloat(EditLbPriceSold.Text)<=StrToFloat(EditlbPrice.Text)*(StrToInt(EditlbVAT.Text)+100)/100 then
          InputErrors[7]:='-Цена продажи не превышает расходы на закупку с учётом НДС'+#13;
        if StrToInt(EditSpinAmountSold.Text)>StrToInt(EditSpinAmount.Text) then
          InputErrors[8]:='-Количество проданых товаров превышает количество имеющихся'+#13;
        for i := 1 to 8 do
          if InputErrors[i]<>'' then
            CanClose:=False;
        if not CanClose then
          MessageBox(Handle, PWideChar('Выполнение невозможно, допущены следующие ошибки:'+
              #13 + InputErrors[1]+InputErrors[2] + InputErrors[3] + InputErrors[4] + InputErrors[5]
              + InputErrors[6] + InputErrors[7] + InputErrors[8]),
              'Предупреждение', MB_Ok or MB_IconWArning);
      end;
    end;
    if tag=2 then
    begin
      if editDateStart.Date>editDateEnd.Date then
      begin
         CanClose:=False;
         MessageBox(Handle, PWideChar('Выполнение невозможно: '+#13+'Начальная дата позже конечной.')
             ,'Предупреждение', Mb_Ok or MB_ICONWARNING);
      end;
    end;
    if tag=3 then
    begin
      if EditLbPriceSold.text='' then
        EditLbPriceSold.text:='0';
      if EditLbPrice.text='' then
        EditLbPrice.text:='0';
      if StrToFloat(EditLbPrice.Text)<0 then
        InputErrors[1]:='Прибыль отрицательная'+#13;
      if StrToFloat(EditLbPriceSold.Text)<0 then
        InputErrors[2]:='Траты отрицательные'+#13;
      for i := 1 to 2 do
        if InputErrors[i]<>'' then
          CanClose:=False;
      if not CanClose then
        MessageBox(Handle, PWideChar('Выполнение невозможно, допущены следующие ошибки:'+
              #13 + InputErrors[1]+InputErrors[2]),
              'Предупреждение', MB_Ok or MB_IconWArning);
    end;
  end
  else
  begin
    res:=MessageBox(Handle, 'Уверены, что хотите закрыть без добавления?', 'Предупреждение',
        Mb_YESNO or MB_ICONWARNING);
    CanClose:=(Res=IDYES);
  end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  if form1.lvReport.Tag=0 then
    EditLbCode.SetFocus
  else
    if tag=3 then
      EditLbPrice.SetFocus;
end;

function TForm2.GetAmount: integer;
begin

  result:=StrToInt(EditSpinAmount.text);
end;

function TForm2.GetAmountSold: integer;
begin
  result:=StrToInt(EditSpinAmountSold.text);
end;

function TForm2.GetCode: string;
begin
  result:=EditlbCode.text;
end;


function TForm2.GetEndDate: TDate;
begin
  result:=editDateEnd.Date;
end;

function TForm2.GetExpense: real;
begin
  result:=StrTOFloat(EditlbPriceSold.text);
end;

function TForm2.GetIncome: real;
begin
  result:=StrToFloat(EditlbPrice.text);
end;

function TForm2.GetIsMonth: boolean;
begin
  result:=CheckBoxDate.Checked;
end;

function TForm2.GetName: string;
begin
  result:=EditLbName.text;
end;

function TForm2.GetPrice: real;
begin
  result:=StrToFLoat(EditLbPrice.text);
end;

function TForm2.GetProd: string;
begin
  result:=EditLbProd.text;
end;

function TForm2.GetStartDate: TDate;
begin
  result:=editDateStart.Date;
end;

function TForm2.GetVAT: integer;
begin
  result:=StrToInt(EditLbVat.text);
end;

function TForm2.GetPriceSold: real;
begin
  result:=StrToFloat(EditLbPriceSold.text);
end;

end.
