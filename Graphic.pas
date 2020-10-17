unit Graphic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ActnMan, Vcl.ActnColorMaps;

type
  TDots = array of real;
  TForm3 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    TrackBarDraw: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnDraw: TButton;
    ComBoxDraw: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ComBoxMethod: TComboBox;
    Label9: TLabel;
    Image1: TImage;
    Panel3: TPanel;
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    lbFirstGr: TLabel;
    lbSecondGr: TLabel;
    btnSaveGraphic: TButton;
    DlgSaveGraphic: TSaveDialog;
    lbCurGraphic: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    procedure btnDrawClick(Sender: TObject);
    procedure ComBoxMethodSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    DotsArray: TDots;
    procedure FindMaxMin(var HighLim, LowLim:real);
    procedure FindDotsExponential;
    procedure FindDotsAverage;
    procedure FindDotsLowSqr;
    procedure BuildGraphic(HighLim, LowLim:real);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  Method, Column: byte;

implementation
   uses MainUnit;
{$R *.dfm}

{ TForm3 }

procedure TForm3.btnDrawClick(Sender: TObject);
var HighLim, LowLim: real;
begin
  DotsArray:=nil;
  method:=ComBoxMethod.ItemIndex;
  Column:=ComBoxDraw.ItemIndex;
  if method=0 then
  begin
    FindDotsAverage;
    case column of
      0: lbCurGraphic.Caption:='Текущий график: График по таблице с прогнозом по скользящим средним по прибыли';
      1: lbCurGraphic.Caption:='Текущий график: График по таблице с прогнозом по скользящим средним по тратам';
      2: lbCurGraphic.Caption:='Текущий график: График по таблице с прогнозом по скользящим средним по итогам';
    end;
  end
  else
    if method=1 then
    begin
      FindDotsExponential;
      case column of
        0: lbCurGraphic.Caption:='Текущий график: График по таблице с графиком экспоненциального сглаживания и прогнозом по прибыли';
        1: lbCurGraphic.Caption:='Текущий график: График по таблице с графиком экспоненциального сглаживания и прогнозом по тратам';
        2: lbCurGraphic.Caption:='Текущий график: График по таблице с графиком экспоненциального сглаживания и прогнозом по итогам';
      end;
    end
    else
    begin
      FindDotsLowSqr;
      case column of
        0: lbCurGraphic.Caption:='Текущий график: График по таблице с прогнозом по методу наименьших квадратов по прибыли';
        1: lbCurGraphic.Caption:='Текущий график: График по таблице с прогнозом по методу наименьших квадратов по тратам';
        2: lbCurGraphic.Caption:='Текущий график: График по таблице с прогнозом по методу наименьших квадратов по итогам';
      end;
    end;
  FindMaxMin(HighLim, LowLim);
  BuildGraphic(HighLim, LowLim);
  Form1.actSaveGraphic.Enabled:=True;
end;

procedure TForm3.BuildGraphic(HighLim, LowLim:real);
var x, i, y, step: integer;
    m, m2: real;
begin
  x:=80;
  with image1 do
  begin
    Picture:=nil;
    PaintBox2.Refresh;
    step:=Round(width/length(DotsArray)/1.2);
    if (HighLim>=0) and (LowLim>=0) and (HighLim+LowLim<>0) then
      m:=height/ (HighLim+LowLim)/1.2
    else
      if (HighLim<0) and (LowLim<0) then
        m:=-height/ (HighLim+LowLim)/1.2
      else
        if (HighLim>=0) and (LowLim<0) then
          m:=height/(HighLim-LowLim)/1.2
        else
          m:=0;
    with canvas do
    begin
      Pen.Color:=clBlack;
      Brush.Color:=clBlack;
      moveto(x,Height);
      lineto(x,0);
      Polygon([Point(x-5,10),Point(x+5,10),Point(x,0)]);
      Brush.Color:=clWhite;
      Font.Height:=16;
      case column of
        0: TextOut(10, 0, 'Прибыль');
        1: TextOut(12, 0, 'Траты');
        2: TextOut(14, 0, 'Итоги');
      end;
      Pen.Width:=1;
      if method=1 then
      begin
        if column=2 then
        begin
          TextOut(7, Round((Height-Round(LowLim*m))/2)-16, FloatToStr(Round(100*LowLim)/100));
          TextOut(7, Round(Height/2)-16, '0');
          TextOut(7, Round((Height-Round(HighLim*m))/2)-16, FloatToStr(Round(100*HighLim)/100));
        end
        else
        begin
          TextOut(7, Height-Round(LowLim*m)-16, FloatToStr(Round(100*LowLim)/100));
          TextOut(7, Height-Round(HighLim*m)-16, FloatToStr(Round(100*HighLim)/100));
        end;
        paintbox1.Canvas.Pen.Color:=clGreen;
        paintbox1.Canvas.Brush.Color:=clGreen;
        paintBox1.Canvas.Rectangle(0,0,paintBox1.Height,paintBox2.Width);
        lbFirstGr.Caption:='График по таблице итогов';
        case column of
          0: y:= Height-Round(Form1.ReportTotal[0].Income*m)-1;
          1: y:= Height-Round(Form1.ReportTotal[0].Expense*m)-1;
          2: y:= Round((Height-Round(Form1.ReportTotal[0].Total*m))/2)-1;
        end;
        Pen.Color:=clBlack;
        Ellipse(x-1,y-2,x+1,y);
        MoveTo(x, y);
        for i := Low(Form1.ReportTotal) to High(Form1.ReportTotal)-1 do
        begin
          case column of
            0: y:=Height-Round(Form1.ReportTotal[i+1].Income*m)-1;
            1: y:=Height-Round(Form1.ReportTotal[i+1].Expense*m)-1;
            2: y:=Round((Height-Round(Form1.ReportTotal[i+1].Total*m))/2)-1
          end;
          Pen.Color:=clBlack;
          Ellipse(x+step,y-2,x+Step+1,y);
          Pen.Color:=clGreen;
          lineto(x+step, y);
          inc(x, step);
        end;
        Pen.Style:=psDot;
        if column=2 then
        begin
          y:=Round((Height-Round(DotsArray[High(Form1.ReportTotal)+1]*m))/2)-1;
          lineto(x+step, y);
          Pen.Color:=clBlack;
          Ellipse(x+step,y-2,x+Step+1,y);
        end
        else
        begin
          y:=Height-Round(DotsArray[High(Form1.ReportTotal)+1]*m)-1;
          lineto(x+step, y);
          Pen.Color:=clBlack;
          Ellipse(x+step,y-2,x+Step+1,y);
        end;
        x:=80;
        paintbox2.Canvas.Pen.Color:=clRed;
        paintbox2.Canvas.Brush.Color:=clRed;
        paintBox2.Canvas.Rectangle(0,0,paintBox1.Height,paintBox1.Width);
        lbSecondGr.Caption:='График экспоненциального сглаживания';
        Pen.Style:=psSolid;
        if column=2 then
        begin
          y:= Round((Height-Round(DotsArray[0]*m))/2)-1;
          Pen.Color:=clBlack;
          Ellipse(x,y-2,x+1,y);
          moveto(x, y);
          for i := Low(DotsArray) to High(DotsArray)-2 do
          begin
            y:=Round((Height-Round(DotsArray[i+1]*m))/2)-1;
            Pen.Color:=clBlack;
            Ellipse(x+step,y-2,x+Step+1,y);
            Pen.Color:=clRed;
            lineto(x+step, y);
            inc(x, step);
          end;
          Pen.Style:=psDot;
          y:=Round((Height-Round(DotsArray[High(DotsArray)]*m))/2)-1;
          lineto(x+step,y);
          Pen.Color:=clBlack;
          Ellipse(x+step,y-2,x+Step+1,y);
        end
        else
        begin
          y:= Height-Round(DotsArray[0]*m)-1;
          Pen.Color:=clBlack;
          Ellipse(x,y-2,x+1,y);
          MoveTo(x, y);
          for i := Low(DotsArray) to High(DotsArray)-2 do
          begin
            y:=Height-Round(DotsArray[i+1]*m)-1;
            Pen.Color:=clBlack;
            Ellipse(x+step,y-2,x+Step+1,y);
            Pen.Color:=clRed;
            lineto(x+step, y);
            inc(x, step);
          end;
          Pen.Style:=psDot;
          y:=Height-Round(DotsArray[High(DotsArray)]*m)-1;
          Pen.Color:=clBlack;
          Ellipse(x+step,y-2,x+Step+1,y);
          Pen.Color:=clRed;
          lineto(x+step, y);
        end;
      end
      else
      begin
        paintbox1.Canvas.Pen.Color:=clGreen;
        paintbox1.Canvas.Brush.Color:=clGreen;
        paintBox1.Canvas.Rectangle(0,0,paintBox1.Height,paintBox1.Width);
        lbFirstGr.Caption:='График по таблице итогов';
        lbSecondGr.Caption:='';
        Pen.Style:=psSolid;
        if (column=2) or (method=2) then
        begin
          Pen.Color:=clBlack;
          TextOut(7, Round((Height-Round(LowLim*m))/2)-16, FloatToStr(Round(100*LowLim)/100));
          TextOut(7, Round(Height/2)-16, '0');
          TextOut(7, Round((Height-Round(HighLim*m))/2)-16, FloatToStr(Round(100*HighLim)/100));
          y:= Round((Height-Round(DotsArray[0]*m))/2)-1;
          Ellipse(x,y-2,x+1,y);
          moveto(x, y);
          for i := Low(DotsArray) to High(DotsArray)-7 do
          begin
            y:=Round((Height-Round(DotsArray[i+1]*m))/2)-1;
            Pen.Color:=clBlack;
            Ellipse(x+step,y-2,x+Step+1,y);
            Pen.Color:=clGreen;
            lineto(x+step, y);
            inc(x, step);
          end;
          Pen.Style:=psDot;
          for i := High(DotsArray)-6 to High(DotsArray)-1 do
          begin
            y:=Round((Height-Round(DotsArray[i+1]*m))/2)-1;
            Pen.Color:=clBlack;
            Ellipse(x+step,y-2,x+Step+1,y);
            Pen.Color:=clGreen;
            lineto(x+step, Round((Height-Round(DotsArray[i+1]*m))/2)-1);
            inc(x, step);
          end;
        end
        else
        begin
          Pen.Color:=clBlack;
          TextOut(7, Height-Round(LowLim*m)-16, FloatToStr(Round(100*LowLim)/100));
          TextOut(7, Height-Round(HighLim*m)-16, FloatToStr(Round(100*HighLim)/100));
          y:=Height-Round(DotsArray[0]*m)-1;
          Pen.Color:=clBlack;
          Ellipse(x,y-2,x+1,y);
          MoveTo(x, y);
          for i := Low(DotsArray) to High(DotsArray)-7 do
          begin
            y:=Height-Round(DotsArray[i+1]*m)-1;
            Pen.Color:=clBlack;
            Ellipse(x+step,y-2,x+step+1,y);
            Pen.Color:=clGreen;
            lineto(x+step, Height-Round(DotsArray[i+1]*m)-1);
            inc(x, step);
          end;
          Pen.Style:=psDot;
          for i := High(DotsArray)-6 to High(DotsArray)-1 do
          begin
            y:=Height-Round(DotsArray[i+1]*m)-1;
            Pen.Color:=clBlack;
            Ellipse(x+step,y-2,x+step+1,y);
            Pen.Color:=clGreen;
            lineTo(x+step, Height-Round(DotsArray[i+1]*m)-1);
            inc(x, step);
          end;
        end;
      end;
    end;
  end;
end;

procedure TForm3.ComBoxMethodSelect(Sender: TObject);
begin
  if ComBoxMethod.ItemIndex=1 then
    TrackBarDraw.Enabled:=True
  else
    TrackBarDraw.Enabled:=False;
end;

procedure TForm3.FindDotsLowSqr;
var Total, PerTotal, Period, PeriodSqr, aCof, bCof: real;
    i, N: integer;
begin
  Total:=0;
  PerTotal:=0;
  PeriodSqr:=0;
  setlength(DotsArray, length(Form1.ReportTotal)+6);
  with Form1 do
  begin
    N:=length(ReportTotal);
    case column of
      0:
        for i := Low(ReportTotal) to N-1 do
        begin
          DotsArray[i]:=ReportTotal[i].Income;
          Total:=Total+ReportTotal[i].Income;
          PerTotal:=PerTotal+ReportTotal[i].Income*(i+1);
          PeriodSqr:=sqr(i+1)+PeriodSqr;
        end;
      1:
        for i := Low(ReportTotal) to N-1 do
        begin
          DotsArray[i]:=ReportTotal[i].Expense;
          Total:=Total+ReportTotal[i].Expense;
          PerTotal:=PerTotal+ReportTotal[i].Expense*(i+1);
          PeriodSqr:=sqr(i+1)+PeriodSqr;
        end;
      2:
        for i := Low(ReportTotal) to N-1 do
        begin
          DotsArray[i]:=ReportTotal[i].Total;
          Total:=Total+ReportTotal[i].Total;
          PerTotal:=PerTotal+ReportTotal[i].Total*(i+1);
          PeriodSqr:=sqr(i+1)+PeriodSqr;
        end;
    end;
    Period:=(N+1)*N/2;
    aCof:=(PerTotal-(Total*Period)/N)/(PeriodSqr-sqr(Period)/N);
    bCof:=(Total-aCof*Period)/N;
    for i := N to High(DotsArray) do
      DotsArray[i]:=aCof*i+bCof;
  end;
end;

procedure TForm3.FindDotsAverage;
const N=6;
var AvgArray: array[0..N] of real;
  i, index: Integer;
begin
  setlength(DotsArray, length(Form1.ReportTotal)+6);
  case column of
    0:for i := low(Form1.ReportTotal) to High(Form1.ReportTotal) do
      DotsArray[i]:=Form1.ReportTotal[i].Income;
    1:for i := low(Form1.ReportTotal) to High(Form1.ReportTotal) do
      DotsArray[i]:=Form1.ReportTotal[i].Expense;
    2: for i := low(Form1.ReportTotal) to High(Form1.ReportTotal) do
      DotsArray[i]:=Form1.ReportTotal[i].Total;
  end;
  index:= High(Form1.ReportTotal)-1;
  AvgArray[0]:=(DotsArray[index-1]+DotsArray[index]+DotsArray[index+1])/3;
  for i:=1 to N+1 do
  begin
    DotsArray[index+1]:=AvgArray[i-1]+1/3*(DotsArray[index]-DotsArray[index-1]);
    AvgArray[i]:=(DotsArray[index-1]+DotsArray[index]+DotsArray[index+1])/3;
    inc(index);
  end;
end;

procedure TForm3.FindDotsExponential;
var    cof, average: real;
       i: integer;
begin
  SetLength(DotsArray, length(Form1.ReportTotal)+1);
  cof:=TrackbarDraw.Position/10;
  average:=0;
  for i := low(Form1.ReportTotal) to High(Form1.ReportTotal) do
  begin
    case column of
      0: average:=Form1.ReportTotal[i].Income+average;
      1: average:=Form1.ReportTotal[i].Expense+average;
      2: average:=Form1.ReportTotal[i].Total+average;
    end;
  end;
  DotsArray[0]:=average/length(Form1.ReportTotal);
  for i := low(Form1.ReportTotal) to High(Form1.ReportTotal) do
  begin
    case column of
      0: DotsArray[i+1]:=cof*Form1.ReportTotal[i].Income+(1-cof)*DotsArray[i];
      1: DotsArray[i+1]:=cof*Form1.ReportTotal[i].Expense+(1-cof)*DotsArray[i];
      2: DotsArray[i+1]:=cof*Form1.ReportTotal[i].Total+(1-cof)*DotsArray[i];
    end;
  end;
end;

procedure TForm3.FindMaxMin(var HighLim, LowLim:real);
var i: Integer;
begin
  with Form1 do
  begin
    if method<>2 then
    case column of
      0:
      begin
        HighLim:=ReportTotal[0].Income;
        LowLim:=ReportTotal[0].Income;
        for i := Low(ReportTotal)+1 to High(ReportTotal) do
        begin
          if ReportTotal[i].Income>HighLim then
            HighLim:= ReportTotal[i].Income;
          if ReportTotal[i].Income<LowLim then
            LowLim:= ReportTotal[i].Income;
        end;
      end;
      1:
      begin
        HighLim:=ReportTotal[0].Expense;
        LowLim:=ReportTotal[0].Expense;
        for i := Low(ReportTotal)+1 to High(ReportTotal) do
        begin
          if ReportTotal[i].Expense>HighLim then
            HighLim:= ReportTotal[i].Expense;
          if ReportTotal[i].Expense<LowLim then
            LowLim:= ReportTotal[i].Expense;
        end;
      end;
      2:
      begin
        HighLim:=ReportTotal[0].total;
        LowLim:=ReportTotal[0].total;
        for i := Low(ReportTotal)+1 to High(ReportTotal) do
        begin
          if ReportTotal[i].total>HighLim then
            HighLim:= ReportTotal[i].total;
          if ReportTotal[i].total<LowLim then
            LowLim:= ReportTotal[i].total;
        end;
      end;
    end
    else
    begin
      HighLim:=DotsArray[0];
      LowLim:=DotsArray[0];
      for i := Low(DotsArray)+1 to High(DotsArray) do
      begin
        if DotsArray[i]>HighLim then
          HighLim:= DotsArray[i];
        if DotsArray[i]<LowLim then
          LowLim:= DotsArray[i];
      end;
    end;
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  DlgSaveGraphic.InitialDir := ExtractFilePath(Application.ExeName);
end;

end.
