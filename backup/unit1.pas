unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  ExtCtrls, TASources;

type

  { TmyApp }

  TmyApp = class(TForm)
    myButton: TButton;
    Label1: TLabel;
    PaintBox1: TPaintBox;
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

procedure TmyApp.myButtonClick(Sender: TObject);
begin

end;

procedure TmyApp.FormCreate(Sender: TObject);
begin
  Drawing := False;
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
  PaintBox1.Canvas.Rectangle(20, 20, 100, 100);
end;

end.

