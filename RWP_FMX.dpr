program RWP_FMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  RWPConsts in 'RWPConsts.pas',
  RWPFactory in 'RWPFactory.pas',
  RWPFormController in 'RWPFormController.pas',
  RWPFormPosition in 'RWPFormPosition.pas',
  RWPIniFile in 'RWPIniFile.pas',
  RWPInterface in 'RWPInterface.pas',
  RWPRegistry in 'RWPRegistry.pas',
  RWPTypes in 'RWPTypes.pas',
  RWPUtils in 'RWPUtils.pas',
  UfrmConfig in 'UfrmConfig.pas' {frmConfig},
  UfrmSobre in 'UfrmSobre.pas' {frmSobre},
  UfrmRWPBase in 'UfrmRWPBase.pas' {frmRWPBase},
  UfrmRWPForm in 'UfrmRWPForm.pas' {frmRWPForm},
  UfrmRWPIE in 'UfrmRWPIE.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Radio Web Player';
  DefinirBrowserPadrao;
  Application.Run;
end.
