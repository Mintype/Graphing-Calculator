unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  ExtCtrls, TASources;

type

  { TmyApp }

  TmyApp = class(TForm)
    Edit1: TEdit;
    myButton: TButton;
    Label1: TLabel;
    PaintBox1: TPaintBox;
    Panel1: TPanel;
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure myButtonClick(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
  private
    Drawing: Boolean;
    LastX, LastY: Integer;
  public

  end;

var
  myApp: TmyApp;

implementation

{$R *.lfm}

{ TmyApp }

function evaluateEquation(expression: string; x: Double): Double;
var
  theResult: Double;
begin
  expression := StringReplace(expression, 'x', FloatToStr(x), [rfReplaceAll]);
  //ShowMessage(expression);
  // TODO: do the parsing stuff
  evaluateEquation := theResult;
end;

procedure TmyApp.myButtonClick(Sender: TObject);
begin

end;

procedure TmyApp.FormCreate(Sender: TObject);
begin
  Drawing := False;
end;

procedure TmyApp.Edit1Change(Sender: TObject);
var
  Expression: string;
  x, y: Double;
begin
  Expression := Edit1.Text;
  y := evaluateEquation(Expression, 4.0); // ADD FOR LOOPS AND STUFFS HERE ALSO

end;

procedure TmyApp.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    Drawing := True;
    LastX := X;
    LastY := Y;
end;

procedure TmyApp.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Drawing then
  begin
    PaintBox1.Canvas.Line(LastX, LastY, X, Y);
    LastX := X;
    LastY := Y;
  end;
end;

procedure TmyApp.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Drawing := False;
end;

procedure TmyApp.PaintBox1Paint(Sender: TObject);
begin
  // Clear the canvas
  PaintBox1.Canvas.Brush.Color := clWhite;
  PaintBox1.Canvas.FillRect(PaintBox1.ClientRect);

  // Draw a rectangle
  PaintBox1.Canvas.Brush.Color := clBlue;
  PaintBox1.Canvas.Pen.Color := clBlack;
  //PaintBox1.Canvas.Rectangle(20, 20, 100, 100);
  PaintBox1.Canvas.Line(0, 251, 2000, 251);
  PaintBox1.Canvas.Line(350, 0, 350, 2000);
  PaintBox1.Canvas.Pen.Color := clRed;
end;

end.

