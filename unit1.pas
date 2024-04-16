unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  ExtCtrls, TASources, Math, fpexprpars;

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
  FParser: TFPExpressionParser;
  theResult: Double;
begin

  // Preset theResult to NaN
  theResult := NaN;
  FParser := TFPExpressionParser.Create(nil);

  // Remove "y=" if it appears at the beginning of the expression
  if Copy(expression, 1, 2) = 'y=' then
    Delete(expression, 1, 2);

  //expression := StringReplace(expression, 'x', '(' + FloatToStr(x) + ')', [rfReplaceAll]);

  try
    // Now here go through the expression and calculate it.
    FParser.BuiltIns := [bcMath];
    FParser.Identifiers.AddFloatVariable('x', x);
    FParser.Expression := expression;
    theResult := FParser.Evaluate.ResFloat;
  except
    // Do nothing, simply continue execution.
  end;

  FParser.Free;

  //ShowMessage(theResult);

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
  i: Integer;
const
  Radius = 3;
begin
  // Clear the drawing on PaintBox1
  PaintBox1.Canvas.Brush.Color := clWhite;
  PaintBox1.Canvas.FillRect(PaintBox1.ClientRect);

  PaintBox1.Canvas.Pen.Color := clBlack;
  PaintBox1.Canvas.Line(0, PaintBox1.Height div 2, 2000, PaintBox1.Height div 2);
  PaintBox1.Canvas.Line(PaintBox1.Width div 2, 0, PaintBox1.Width div 2, 2000);

  Expression := Edit1.Text;
  y := evaluateEquation(Expression, 4.0); // ADD FOR LOOPS AND STUFFS HERE ALSO
  for i := 0 to 500 do
  begin
    x := i;
    try
      y := evaluateEquation(Expression, i);
      // Convert coordinates to pixels
      x := x * 25 + PaintBox1.Width div 2; // Scale x to fit the canvas width
      x := x + 300;
      y := -y * 25 + PaintBox1.Height div 2; // Scale and invert y to fit the canvas height
      y := y + 50;

      // Plot a point
      Canvas.Brush.Color := clRed;
      Canvas.Ellipse(Round(x) - Radius, Round(y) - Radius, Round(x) + Radius, Round(y) + Radius);
    except
      // do nothing
    end;
    //ShowMessage('you got: ' + FloatToStr(y) + ' from i=' + IntToStr(i));
  end;
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

