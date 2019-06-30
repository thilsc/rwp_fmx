unit RWPFormController;

interface

uses
  System.Classes, System.SysUtils, System.UITypes, FMX.Forms, FMX.Types,
  RWPInterface;

type
  TRWPFormController = class
  private
    FForm: IRadioWebPlayer;
    FIndexRadio: Integer;
    FCompactView: Boolean;
    FTelaInicializada: Boolean;
    procedure SetCompactView(AValue: Boolean);
    procedure BlinkScreen;
    procedure SetIndexRadio(const Value: Integer);
    procedure ConfiguraCompactView;
  public
    property CompactView: Boolean read FCompactView write SetCompactView;
    property IndexRadio: Integer read FIndexRadio write SetIndexRadio;
    procedure RecuperaPosSizeForm;
    procedure AplicaPosSizeForm;
    procedure CallAboutForm;
    procedure CallConfigForm;
    procedure HidePlayer;
    procedure ShowPlayer;
    constructor Create(AForm: IRadioWebPlayer); overload;
    procedure Load;
  end;

implementation

uses
  RWPUtils, UfrmConfig, UfrmSobre, RWPFormPosition, System.StrUtils,
  System.Math;

constructor TRWPFormController.Create(AForm: IRadioWebPlayer);
begin
  inherited Create;
  FForm := AForm;
end;

procedure TRWPFormController.Load;
begin
  FIndexRadio := -1;
  Self.CompactView := False;
  FTelaInicializada := False;
end;

procedure TRWPFormController.ShowPlayer;
begin
  if (FIndexRadio < 0) then
    FForm.Stop;

  AplicaPosSizeForm;
  FForm.ConfigShowHide;
end;

procedure TRWPFormController.HidePlayer;
begin
  RecuperaPosSizeForm;
  FForm.ConfigShowHide;
end;

procedure TRWPFormController.CallConfigForm;
begin
  with TFrmConfig.Create(nil) do
  try
    if ((ShowModal = mrOk) and AtualizarCanais) then
      FForm.AtualizaListaRadios;
  finally
    Free;
  end;
end;

procedure TRWPFormController.CallAboutForm;
begin
  with TfrmSobre.Create(nil) do
  try
    lblVersao.Text := GetAppVersion;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TRWPFormController.RecuperaPosSizeForm;
begin
  TRWPFormPosition.GetInstance.SetPosition(FForm.Left, FForm.Top, FForm.Height, FForm.Width);
end;

procedure TRWPFormController.AplicaPosSizeForm;
begin
  with TRWPFormPosition.GetInstance do
    if ((Position.Height > 0) and (Position.Width > 0)) then
    begin
      FForm.Left := Position.Left;
      FForm.Top := Position.Top;
     // AForm.Height:= Position.Height;
     // AForm.Width := Position.Width;
    end;
end;

procedure TRWPFormController.SetCompactView(AValue: Boolean);
begin
  if (FCompactView <> AValue) then
  begin
    FCompactView := AValue;
    ConfiguraCompactView;
  end;
end;

procedure TRWPFormController.SetIndexRadio(const Value: Integer);
begin
  if (Value <> FIndexRadio) then
  begin
    FIndexRadio := Value;

    FForm.AtualizaInfoCanal;
    BlinkScreen;
  end;
end;

procedure TRWPFormController.ConfiguraCompactView;
begin
  FForm.BorderStyle := TFmxFormBorderStyle(IfThen(FCompactView, Integer(FMX.Forms.TFmxFormBorderStyle.None), Integer(FMX.Forms.TFmxFormBorderStyle.Sizeable)));
  FForm.FormStyle   := TFormStyle(IfThen(FCompactView, Integer(FMX.Types.TFormStyle.StayOnTop), Integer(FMX.Types.TFormStyle.Normal)));
  //FForm.Position    := TPosition(IfThen(FCompactView, Integer(poDesigned), Integer(poDesktopCenter)));

  if FCompactView then
  begin
    FForm.Top := Screen.Height - 80;
    FForm.Left := Screen.Width - 320;
    if (FForm.Top < 0) then
      FForm.Top := 0;
  end;

  FForm.ClientHeight:= IfThen(FCompactView, 38, 266);
  FForm.ClientWidth := IfThen(FCompactView, 320, 521);
  FForm.Refresh;
end;

procedure TRWPFormController.BlinkScreen;
begin
  if not (FForm.Visible or FTelaInicializada) then
  begin
    FForm.Show;
    Sleep(250);
    FForm.Hide;
  end;
  FTelaInicializada := True;
end;

end.

