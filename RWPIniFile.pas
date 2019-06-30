unit RWPIniFile;

interface

uses System.SysUtils, System.IniFiles, System.Classes;

type
  TRWPIniFile = class(TIniFile)
  private
    function GetConfigStr(AName: string): string;
    procedure SetConfigStr(AName, Value: string);
    function GetCanaisStr(AName: string): string;
    procedure SetCanaisStr(AName: string; const Value: string);
  public
    property Config[AName: string]: string read GetConfigStr write SetConfigStr;
    property Canais[AName: string]: string read GetCanaisStr write SetCanaisStr;

    function GetCanais: TStringList;
    procedure SetConfigs(AList: TStringList);
    procedure SetCanais(AList: TStringList);

    constructor Create; overload;
  end;

implementation

uses RWPUtils;

{ TRWPIniFile }

constructor TRWPIniFile.Create;
begin
  inherited Create(GetConfigFileName);
end;

function TRWPIniFile.GetCanais: TStringList;
begin
  Result := TStringList.Create;
  ReadSectionValues('Canais', Result);
end;

function TRWPIniFile.GetCanaisStr(AName: string): string;
begin
  Result := ReadString('Canais', AName, EmptyStr);
end;

function TRWPIniFile.GetConfigStr(AName: string): string;
begin
  Result := ReadString('Config', AName, EmptyStr);
end;

procedure TRWPIniFile.SetCanaisStr(AName: string; const Value: string);
begin
  WriteString('Canais', AName, Value);
end;

procedure TRWPIniFile.SetConfigStr(AName, Value: string);
begin
  WriteString('Config', AName, Value);
end;

procedure TRWPIniFile.SetConfigs(AList: TStringList);
var
  I: Integer;
begin
  for I := 0 to Pred(AList.Count) do
    WriteString('Config', AList.Names[I], AList.ValueFromIndex[I]);

  UpdateFile;
end;

procedure TRWPIniFile.SetCanais(AList: TStringList);
var
  I: Integer;
begin
  EraseSection('Canais');

  for I := 0 to Pred(AList.Count) do
    WriteString('Canais', AList.Names[I], AList.ValueFromIndex[I]);

  UpdateFile;
end;

end.
