unit RWPFormPosition;

interface

uses System.Classes, System.SysUtils, System.UITypes, FMX.Forms, FMX.Dialogs;

type
  TRWPPosition = packed record
                   Left, Top, Height, Width: Cardinal;
                 end;

  TRWPFormPosition = class
  private
    FPosition: TRWPPosition;
  public
    property Position: TRWPPosition read FPosition write FPosition;

    procedure Config(ALastPos, ASizeWindow: string; AIniMin: Boolean);
    procedure GravarUltimaPosicao;
    procedure SetPosition(Left, Top, Height, Width: Cardinal);

    class function GetInstance: TRWPFormPosition;
  end;

implementation

uses RWPUtils, RWPTypes;

var
  FInstance: TRWPFormPosition;

{ TRWPFormPosition }

class function TRWPFormPosition.GetInstance: TRWPFormPosition;
begin
  if (not Assigned(FInstance)) then
    FInstance := Create;

  Result := FInstance;
end;

procedure TRWPFormPosition.Config(ALastPos, ASizeWindow: string; AIniMin: Boolean);
var
  sLastPos, sSizeWindow: string;
begin
  sLastPos    := ALastPos;
  sSizeWindow := ASizeWindow;
  if (sLastPos <> '') then
  begin
    FPosition.Top  := StrToIntDef(Copy(sLastPos, 1, Pos(',', sLastPos)-1), 0);
    FPosition.Left := StrToIntDef(Copy(sLastPos, Pos(',', sLastPos)+1, Length(sLastPos)-Pos(',', sLastPos)), 0);
  end;

  if (sSizeWindow <> '') then
  begin
    FPosition.Height := StrToIntDef(Copy(sSizeWindow, 1, Pos(',', sSizeWindow)-1), 0);
    FPosition.Width  := StrToIntDef(Copy(sSizeWindow, Pos(',', sSizeWindow)+1, Length(sSizeWindow)-Pos(',', sSizeWindow)), 0);
  end;

  //Application.ShowMainForm := AIniMin;
end;

procedure TRWPFormPosition.GravarUltimaPosicao;
var
  Params: TArrayParams;
begin
  SetLength(Params, 2);
  Params[0].Name := 'LastPos';
  Params[0].Value:= IntToStr(FPosition.Top)+','+IntToStr(FPosition.Left);
  Params[1].Name := 'SizeWindow';
  Params[1].Value:= IntToStr(FPosition.Height)+','+IntToStr(FPosition.Width);
  GravarConfiguracoes(Params);
end;

procedure TRWPFormPosition.SetPosition(Left, Top, Height, Width: Cardinal);
begin
  FPosition.Left  := Left;
  FPosition.Top   := Top;
  FPosition.Height:= Height;
  FPosition.Width := Width;
end;

initialization

finalization
  try
    TRWPFormPosition.GetInstance.GravarUltimaPosicao;
  except
    on E: Exception do
      MessageDlg('Ocorreu um erro ao encerrar o RadioWebPlayer: '#13#10+E.Message,
                 System.UITypes.TMsgDlgType.mtError,
                 [System.UITypes.TMsgDlgBtn.mbOK], 0);
  end;
end.
