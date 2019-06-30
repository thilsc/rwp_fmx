unit RWPInterface;

interface

uses FMX.Forms, FMX.Types;

type
  IRWPForm = interface
    ['{AFF8D883-3F13-4B2A-AE1C-551DBDCCCA71}']
    function GetBorderStyle: TFmxFormBorderStyle;
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

    procedure SetBorderStyle(Value: TFmxFormBorderStyle);
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
    procedure Show;
    procedure Hide;

    property BorderStyle: TFmxFormBorderStyle read GetBorderStyle write SetBorderStyle;
    property Caption: string  read GetCaption write SetCaption;
    property ClientHeight: Integer read GetClientHeight write SetClientHeight;
    property ClientWidth: Integer read GetClientWidth write SetClientWidth;
    property FormStyle: TFormStyle read GetFormStyle write SetFormStyle;
    property Height: Integer read GetHeight  write SetHeight;
    property Left: Integer read GetLeft    write SetLeft;
    property Position: TFormPosition read GetPosition write SetPosition;
    property Top: Integer read GetTop     write SetTop;
    property Visible: Boolean read GetVisible write SetVisible;
    property Width: Integer read GetWidth   write SetWidth;
  end;

  IRadioWebPlayer = interface(IRWPForm)
  ['{6D701796-18F6-415E-9C85-6C70A19B52E3}']
    function GetExibirMsgErroBrowser: Boolean;
    procedure SetExibirMsgErroBrowser(const Value: Boolean);

    procedure AtualizaListaRadios;
    procedure AtualizaInfoCanal;
    procedure ConfigShowHide;
    procedure Play;
    procedure Mute;
    procedure Stop;
    procedure Refresh;

    property ExibirMsgErroBrowser: Boolean read GetExibirMsgErroBrowser write SetExibirMsgErroBrowser;
  end;

implementation

end.


