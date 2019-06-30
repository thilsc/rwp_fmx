unit UfrmRWPBase;

interface

uses
  System.SysUtils, System.Variants, System.Classes, FMX.Graphics,
  FMX.Controls, FMX.ExtCtrls, FMX.Forms, FMX.Dialogs, System.Actions, FMX.ActnList,
  FMX.Menus, FMX.StdCtrls, FMX.Types, RWPInterface;

type
  TfrmRWPBase = class(TForm, IRWPForm)
  private
    { Private declarations }
  protected
    { Protected declarations }
    function GetBorderStyle: TFMXFormBorderStyle;
    function GetCaption: string;
    function GetClientHeight: Integer;
    function GetClientWidth: Integer;
    function GetFormStyle: TFormStyle;
    function GetHeight: Integer;
    function GetLeft: Integer;
    function GetPosition: TFormPosition;
    function GetTop: Integer;
    function GetVisible: Boolean;
    function GetWidth: Integer;

    procedure SetBorderStyle(Value: TFMXFormBorderStyle);
    procedure SetCaption(Value: string);
    procedure SetClientHeight(Value: Integer);
    procedure SetClientWidth(Value: Integer);
    procedure SetFormStyle(Value: TFormStyle);
    procedure SetHeight(Value: Integer);
    procedure SetLeft(Value: Integer);
    procedure SetPosition(Value: TFormPosition);
    procedure SetTop(Value: Integer);
    procedure SetVisible(Value: Boolean);
    procedure SetWidth(Value: Integer);
  public
    { Public declarations }
    property BorderStyle: TFMXFormBorderStyle read GetBorderStyle write SetBorderStyle;
    property Caption: string  read GetCaption write SetCaption;
    property ClientHeight: Integer read GetClientHeight write SetClientHeight;
    property ClientWidth: Integer read GetClientWidth write SetClientWidth;
    property FormStyle: TFormStyle read GetFormStyle write SetFormStyle;
    property Height: Integer read GetHeight  write SetHeight;
    property Left: Integer read GetLeft    write SetLeft;
    property Position: TFormPosition read GetPosition write SetPosition;
    property Top: Integer read GetTop     write SetTop;
    property Width: Integer read GetWidth   write SetWidth;
  end;

var
  frmRWPBase: TfrmRWPBase;

implementation

{$R *.fmx}

{ TfrmRWPBase }

function TfrmRWPBase.GetBorderStyle: TFmxFormBorderStyle;
begin
  Result := inherited BorderStyle;
end;

function TfrmRWPBase.GetCaption: string;
begin
  Result := inherited Caption;
end;

function TfrmRWPBase.GetClientHeight: Integer;
begin
  Result := inherited ClientHeight;
end;

function TfrmRWPBase.GetClientWidth: Integer;
begin
  Result := inherited ClientWidth;
end;

function TfrmRWPBase.GetFormStyle: TFormStyle;
begin
  Result := inherited FormStyle;
end;

function TfrmRWPBase.GetHeight: Integer;
begin
  Result := inherited Height;
end;

function TfrmRWPBase.GetLeft: Integer;
begin
  Result := inherited Left;
end;

function TfrmRWPBase.GetPosition: TFormPosition;
begin
  Result := inherited Position;
end;

function TfrmRWPBase.GetTop: Integer;
begin
  Result := inherited Top;
end;

function TfrmRWPBase.GetVisible: Boolean;
begin
  Result := inherited Visible;
end;

function TfrmRWPBase.GetWidth: Integer;
begin
  Result := inherited Width;
end;

procedure TfrmRWPBase.SetBorderStyle(Value: TFMXFormBorderStyle);
begin
  inherited BorderStyle := Value;
end;

procedure TfrmRWPBase.SetCaption(Value: string);
begin
  inherited Caption := Value;
end;

procedure TfrmRWPBase.SetClientHeight(Value: Integer);
begin
  inherited ClientHeight := Value;
end;

procedure TfrmRWPBase.SetClientWidth(Value: Integer);
begin
  inherited ClientWidth := Value;
end;

procedure TfrmRWPBase.SetFormStyle(Value: TFormStyle);
begin
  inherited FormStyle := Value;
end;

procedure TfrmRWPBase.SetHeight(Value: Integer);
begin
  inherited Height := Value;
end;

procedure TfrmRWPBase.SetLeft(Value: Integer);
begin
  inherited Left := Value;
end;

procedure TfrmRWPBase.SetPosition(Value: TFormPosition);
begin
  inherited Position := Value;
end;

procedure TfrmRWPBase.SetTop(Value: Integer);
begin
  inherited Top := Value;
end;

procedure TfrmRWPBase.SetVisible(Value: Boolean);
begin
  inherited Visible := Value;
end;

procedure TfrmRWPBase.SetWidth(Value: Integer);
begin
  inherited Width := Value;
end;

end.
