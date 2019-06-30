unit RWPUtils;

interface

uses System.Classes, System.SysUtils, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Menus,
     FMX.ListBox, RWPIniFile, RWPTypes;

function GetAppVersion:string;
procedure BringApplicationToFront;
function ArrayParamsToStringList(AArray: TArrayParams): TStringList;
function GetConfigStr(AName: string): string;
function GetConfigFileName: string;
procedure CarregarArquivoConfiguracao;
procedure GravarConfiguracoes(AParams: TArrayParams);
function GetTipoBrowser: TTipoBrowser;
function GetCanais: TStringList;
procedure SetCanais(AValue: TStringList);
procedure DefinirBrowserPadrao;
procedure PreencheListaRadios(ALista: TStrings; ASubMenu: TMenuItem; AMenuEventOnClick: TNotifyEvent);

implementation

uses
  StrUtils, RWPInterface, RWPFactory, System.UITypes, RWPFormController, RWPFormPosition, RWPConsts
  {$IFDEF MSWINDOWS}, Winapi.Windows, Winapi.ShellAPI{$ENDIF};

var
  Player: IRadioWebPlayer;
  FIniFile: TRWPIniFile;

function GetAppVersion:string;
{$IFDEF MSWINDOWS}
var
  Exe: string;
  Size, Handle: DWORD;
  Buffer: TBytes;
  FixedPtr: PVSFixedFileInfo;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  Exe := ParamStr(0);
  Size := GetFileVersionInfoSize(PChar(Exe), Handle);
  if (Size = 0) then
    RaiseLastOSError;

  SetLength(Buffer, Size);
  if not GetFileVersionInfo(PChar(Exe), Handle, Size, Buffer) then
    RaiseLastOSError;

  if not VerQueryValue(Buffer, '\', Pointer(FixedPtr), Size) then
    RaiseLastOSError;

  Result := Format('%d.%d.%d.%d', [LongRec(FixedPtr.dwFileVersionMS).Hi,   //major
                                   LongRec(FixedPtr.dwFileVersionMS).Lo,   //minor
                                   LongRec(FixedPtr.dwFileVersionLS).Hi,   //release
                                   LongRec(FixedPtr.dwFileVersionLS).Lo]); //build
{$ELSE}
  Result := VERSAO_APP;
{$ENDIF}
end;

procedure BringApplicationToFront;
{$IFDEF MSWINDOWS}
var
  Handle: HWND;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  Handle := FindWindow('TfrmRWPForm', nil);
  if (Handle > 0) then
    if IsIconic(Handle) then
      ShowWindow(Handle, SW_RESTORE)
    else
      BringWindowToTop(Handle);
{$ENDIF}
end;

function ArrayParamsToStringList(AArray: TArrayParams): TStringList;
var
  I: Integer;
begin
  Result := TStringList.Create;
  for I := 0 to Pred(Length(AArray)) do
    if (AArray[I].Name <> '') then
      Result.Values[AArray[I].Name] := AArray[I].Value;
end;

procedure DefinirBrowserPadrao;
begin
  Player := TRadioWebPlayerFactory.GetInstance;
end;

function GetConfigStr(AName: string): string;
begin
  if Assigned(FIniFile) then
    Result := FIniFile.Config[AName]
  else
    Result := EmptyStr;
end;

function GetConfigFileName: string;
begin
  Result := IncludeTrailingPathDelimiter(System.SysUtils.GetCurrentDir) + DEFAULT_INI;
end;

procedure CarregarArquivoConfiguracao;
begin
  FIniFile := TRWPIniFile.Create;
end;

procedure GravarConfiguracoes(AParams: TArrayParams);
var
  lst: TStringList;
begin
  lst := ArrayParamsToStringList(AParams);
  if Assigned(FIniFile) then
    try
      FIniFile.SetConfigs(lst);
    finally
      FreeAndNil(lst);
    end;
end;

function GetTipoBrowser: TTipoBrowser;
begin
  if Assigned(FIniFile) then
    Result := TTipoBrowser(StrToIntDef(FIniFile.Config['CarregarBrowser'], 1{IE}))
  else
    Result := brwIE;
end;

function GetCanais: TStringList;
begin
  if Assigned(FIniFile) then
    Result := FIniFile.GetCanais
  else
    Result := nil;
end;

procedure SetCanais(AValue: TStringList);
begin
  if Assigned(FIniFile) then
    FIniFile.SetCanais(AValue);
end;

procedure PreencheListaRadios(ALista: TStrings; ASubMenu: TMenuItem; AMenuEventOnClick: TNotifyEvent);
var
  I: Integer;
  MenuItem: TMenuItem;
  lstCanais: TStringList;
begin
  ALista.Clear;

  ASubMenu.Clear;
  lstCanais := GetCanais;
  try
    for I := 0 to Pred(lstCanais.Count) do
    begin
      ALista.Add(lstCanais.Names[I]);
      MenuItem := TMenuItem.Create(ASubMenu);
      MenuItem.Text := lstCanais.Names[I];

      if Assigned(AMenuEventOnClick) then
        MenuItem.OnClick := AMenuEventOnClick;

      MenuItem.Tag := I;
      ASubMenu.AddObject(MenuItem);
    end;
  finally
    FreeAndNil(lstCanais);
  end;
end;

procedure Init;
begin
  if FileExists(GetConfigFileName) then
    CarregarArquivoConfiguracao
  else
    raise Exception.CreateFmt('Não foi possível carregar o arquivo de configuração "%s"!', [GetConfigFileName]);

  //FIniFile.Config['PlayerMode']
  TRWPFormPosition.GetInstance.Config(FIniFile.Config['LastPos'],
                                      FIniFile.Config['SizeWindow'],
                                      FIniFile.Config['IniciarMinimizado'] <> 'S');
end;

initialization
  try
    Init;
  except
    on E: Exception do
    begin
      MessageDlg('Ocorreu um erro ao inicializar o RadioWebPlayer: '#13#10+E.Message,
                 System.UITypes.TMsgDlgType.mtError,
                 [System.UITypes.TMsgDlgBtn.mbOK], 0);
      //Application.Terminate;
    end;
  end;
end.

