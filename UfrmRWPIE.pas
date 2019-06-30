unit UfrmRWPIE;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, UfrmRWPForm, FMX.WebBrowser,
  FMX.Media, System.Actions, FMX.ActnList, FMX.Controls, FMX.Menus, FMX.Types, FMX.ListBox, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TfrmRWPIE = class(TfrmRWPForm)
    wb1: TWebBrowser;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    function GetExibirMsgErroBrowser: Boolean; override;
    procedure SetExibirMsgErroBrowser(const Value: Boolean); override;
  public
    { Public declarations }
    procedure GoToURL(sURL: string); override;
    procedure Play; override;
    procedure Mute; override;
    procedure Stop; override;
    procedure Refresh; override;
  end;

var
  frmRWPIE: TfrmRWPIE;

implementation

uses
  RWPUtils;

{$R *.fmx}

{ TfrmRWPIE }

procedure TfrmRWPIE.FormCreate(Sender: TObject);
begin
   inherited;
   Mute;
end;

function TfrmRWPIE.GetExibirMsgErroBrowser: Boolean;
begin
  Result := False;
end;

procedure TfrmRWPIE.SetExibirMsgErroBrowser(const Value: Boolean);
begin
  //
end;

procedure TfrmRWPIE.GoToURL(sURL: string);
begin
  if (sURL <> wb1.URL) then
  begin
    wb1.Stop;
    wb1.URL := sURL;
    wb1.Navigate;
  end;
end;

procedure TfrmRWPIE.Stop;
begin
  wb1.Stop;
end;

procedure TfrmRWPIE.Mute;
begin
  GoToURL('about:blank');
end;

procedure TfrmRWPIE.Play;
begin
  GoToURL(GetCanais.ValueFromIndex[GetControllerInstance.IndexRadio]);
end;

procedure TfrmRWPIE.Refresh;
begin
  try
    wb1.Stop;
    wb1.Reload;
  except
    //
  end;
end;

end.
