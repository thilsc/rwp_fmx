unit RWPVolumeControl;

interface

uses System.SysUtils, System.Classes;

type
  TVolumeRec = record
    case Integer of
      0: (LongVolume: Longint);
      1: (LeftVolume, RightVolume : Word);
    end;

  TRWPVolumeControl = class
  private
    function GetVolume(ADeviceIndex: Cardinal): Byte;
    procedure SetVolume(ADeviceIndex: Cardinal; const Value: Byte);
  public
    property Volume[ADeviceIndex: Cardinal]: Byte read GetVolume write SetVolume;

    class procedure SetMasterVolume(AValue: Byte);
    class procedure SetMute;
  end;

const
  VK_VOLUME_MUTE    = $AD;
  VK_VOLUME_DOWN    = $AE;
  VK_VOLUME_UP      = $AF;
  DEVICE_WAVE       = 0;
  DEVICE_MIDI       = 1;
  DEVICE_CD         = 2;
  DEVICE_LINEIN     = 3;
  DEVICE_MICROPHONE = 4;
  DEVICE_MASTER     = 5;
  DEVICE_PCSPEAKER  = 6;

implementation

uses WinApi.MMSystem;

{ Global Methods }

procedure SetMuteByVK;
begin
  keybd_event(VK_VOLUME_MUTE, MapVirtualKey(VK_VOLUME_MUTE,0), 0, 0);
  keybd_event(VK_VOLUME_MUTE, MapVirtualKey(VK_VOLUME_MUTE,0), KEYEVENTF_KEYUP, 0);
end;

procedure SetVolumeByVK(const Value: Byte);
var
  I:Integer;
begin
  TRWPVolumeControl.SetMute;
  for I := 0 to Value do
  begin
    keybd_event(VK_VOLUME_UP, MapVirtualKey(VK_VOLUME_UP,0), 0, 0);
    keybd_event(VK_VOLUME_UP, MapVirtualKey(VK_VOLUME_UP,0), KEYEVENTF_KEYUP, 0);
  end;
end;

{ TRWPVolumeControl }

function TRWPVolumeControl.GetVolume(ADeviceIndex: Cardinal): Byte;
var
  Vol: TVolumeRec;
begin
  AuxGetVolume(UINT(ADeviceIndex), @Vol.LongVolume);
  Result := (Vol.LeftVolume + Vol.RightVolume) shr 9;
end;

procedure TRWPVolumeControl.SetVolume(ADeviceIndex: Cardinal; const Value: Byte);
var
  Vol: TVolumeRec;
begin
   Vol.LeftVolume := Value shl 8;
   Vol.RightVolume:= Vol.LeftVolume;
   auxSetVolume(UINT(ADeviceIndex), Vol.LongVolume);
end;

class procedure TRWPVolumeControl.SetMasterVolume(AValue: Byte);
begin
  with Create do
    try
      Volume[DEVICE_MASTER] := AValue;
    finally
      Free;
    end;
end;

class procedure TRWPVolumeControl.SetMute;
begin
  with Create do
    try
      Volume[DEVICE_MASTER] := 0;
    finally
      Free;
    end;
end;

end.
