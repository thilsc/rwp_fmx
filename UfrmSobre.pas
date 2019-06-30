unit UfrmSobre;

interface

uses
  System.SysUtils, System.Variants, System.Classes, FMX.Graphics, FMX.StdCtrls, FMX.Controls, FMX.Forms, System.StrUtils,
  FMX.ExtCtrls, FMX.Dialogs, System.Types, System.UITypes, FMX.Types, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation;

type
  TfrmSobre = class(TForm)
    Label1: TLabel;
    lblVersao: TLabel;
    Image1: TImage;
    Label3: TLabel;
    Button1: TButton;
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSobre: TfrmSobre;

implementation

{$R *.fmx}

uses
{$IFDEF MSWINDOWS}
  Winapi.ShellAPI, Winapi.Windows;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  {$IFDEF ANDROID}
    Androidapi.Helpers,
    FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText,
    Androidapi.JNI.Net, Androidapi.JNI.JavaTypes,
  {$ELSE}
  {$IFDEF IOS}
    Macapi.Helpers, iOSapi.Foundation, FMX.Helpers.iOS,
  {$ENDIF IOS}
  {$ENDIF ANDROID}
  Posix.Stdlib;
{$ENDIF POSIX}

procedure TfrmSobre.Image1Click(Sender: TObject);
var
  sCommand: string;
begin
  sCommand := 'http://www.thiagocoutinho.com';
{$IFDEF MSWINDOWS}
  ShellExecute(0, 'OPEN', PChar(sCommand), '', '', SW_SHOWNORMAL);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  //_system(System._PAnsiChar('open ' + System._AnsiString(sCommand)));
{$ENDIF POSIX}
end;

end.
