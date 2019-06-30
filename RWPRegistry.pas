unit RWPRegistry;

interface

{$IFDEF MSWINDOWS}
uses WinApi.Windows, System.Win.Registry;

type
  TRWPRegistry = class(TRegistry)
  private
    procedure VerificaIE;
  public
    constructor Create; overload;
    class procedure VerificaIEEmulacao;
  end;
{$ENDIF}

implementation

{$IFDEF MSWINDOWS}
uses System.SysUtils;

{ TRWPRegistry }

constructor TRWPRegistry.Create;
begin
  inherited Create(KEY_WRITE);
  RootKey := HKEY_CURRENT_USER;
end;

procedure TRWPRegistry.VerificaIE;
var
  IEEmulationKey: string;
begin
  IEEmulationKey := 'Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION';
  if KeyExists(IEEmulationKey) then
  begin
    OpenKey(IEEmulationKey, True);
    WriteInteger('RWP.exe', 11001);
    WriteInteger('RWP_FMX.exe', 11001);
    CloseKey;
  end;
end;

class procedure TRWPRegistry.VerificaIEEmulacao;
begin
  with Create do
    try
      VerificaIE;
    finally
      Free;
    end;
end;
{$ENDIF}
end.
