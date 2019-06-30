unit UfrmRWPForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, UfrmRWPBase,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Media,
  FMX.ListBox, FMX.WebBrowser, RWPFormController, RWPInterface, System.Actions, FMX.ActnList, FMX.Menus;

type
  TfrmRWPForm = class(TfrmRWPBase, IRadioWebPlayer)
    pnlSeletor: TPanel;
    cbb1: TComboBox;
    pnl1: TPanel;
    lblStatus: TLabel;
    ActionList1: TActionList;
    ActAtualizar: TAction;
    ActConfigurar: TAction;
    ActExecutar: TAction;
    ActParar: TAction;
    ActExibirOcultar: TAction;
    ActSobre: TAction;
    PopupMenu1: TPopupMenu;
    AbrirPlayer1: TMenuItem;
    Configurar1: TMenuItem;
    Radios1: TMenuItem;
    N2: TMenuItem;
    mnuMudo: TMenuItem;
    Atualizar1: TMenuItem;
    N1: TMenuItem;
    Sobre1: TMenuItem;
    Fechar1: TMenuItem;
    mnuItem: TMenuItem;
    btnConfig: TCornerButton;
    procedure ActAtualizarExecute(Sender: TObject);
    procedure ActConfigurarExecute(Sender: TObject);
    procedure ActExecutarExecute(Sender: TObject);
    procedure ActExibirOcultarExecute(Sender: TObject);
    procedure ActFecharExecute(Sender: TObject);
    procedure ActMudoExecute(Sender: TObject);
    procedure ActPararExecute(Sender: TObject);
    procedure ActSobreExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioMenuClick(Sender: TObject);
    procedure cbb1Change(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
  private
    { Private declarations }
    FController: TRWPFormController;
  protected
    { Protected declarations }
    function GetControllerInstance: TRWPFormController;
    function GetExibirMsgErroBrowser: Boolean; virtual; abstract;
    procedure SetExibirMsgErroBrowser(const Value: Boolean); virtual; abstract;

    procedure ConfigShowHide; virtual;
    procedure AtualizaListaRadios; virtual;
    procedure AtualizaInfoCanal; virtual;
  public
    { Public declarations }
    property ExibirMsgErroBrowser: Boolean read GetExibirMsgErroBrowser write SetExibirMsgErroBrowser;

    procedure GoToURL(sURL: string); virtual; abstract;
    procedure Play; virtual; abstract;
    procedure Mute; virtual; abstract;
    procedure Stop; virtual; abstract;
    procedure Refresh; virtual; abstract;
  end;

var
  frmRWPForm: TfrmRWPForm;

implementation

{$R *.fmx}

uses RWPUtils, System.StrUtils;

{ TfrmRWP }

procedure TfrmRWPForm.FormCreate(Sender: TObject);
begin
  FController := TRWPFormController.Create(Self);
  FController.Load;
  Caption := Application.Title + ' v' + GetAppVersion;
  AtualizaListaRadios;
end;

procedure TfrmRWPForm.FormShow(Sender: TObject);
begin
  FController.ShowPlayer;
end;

procedure TfrmRWPForm.FormHide(Sender: TObject);
begin
  FController.HidePlayer;
end;

procedure TfrmRWPForm.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  FController.RecuperaPosSizeForm;
end;

procedure TfrmRWPForm.FormDestroy(Sender: TObject);
begin
  if Assigned(FController) then
    FreeAndNil(FController);
end;

function TfrmRWPForm.GetControllerInstance: TRWPFormController;
begin
  Result := FController;
end;

procedure TfrmRWPForm.AtualizaListaRadios;
begin
  Stop;
  PreencheListaRadios(cbb1.Items, Radios1, RadioMenuClick);

end;

procedure TfrmRWPForm.btnConfigClick(Sender: TObject);
begin
  ActConfigurar.Execute;
end;

procedure TfrmRWPForm.cbb1Change(Sender: TObject);
begin
  ActExecutar.Execute;
end;

procedure TfrmRWPForm.AtualizaInfoCanal;
begin
  if (FController.IndexRadio = -1) then
  begin
    lblStatus.Text := 'Mudo';
    Mute;
  end
  else
  begin
    cbb1.ItemIndex := FController.IndexRadio;
    lblStatus.Text := 'Executando rádio: '+cbb1.Items[cbb1.ItemIndex];
    Play;
  end;
end;

procedure TfrmRWPForm.ConfigShowHide;
begin
  ActExibirOcultar.Caption := IfThen(Self.Visible, 'Ocultar', 'Exibir')+' Player';
  if (Self.Visible) then
    ExibirMsgErroBrowser := GetConfigStr('ExibirMsgErro') <> 'S';
end;

procedure TfrmRWPForm.ActAtualizarExecute(Sender: TObject);
begin
  Refresh;
end;

procedure TfrmRWPForm.ActExecutarExecute(Sender: TObject);
begin
  if (cbb1.ItemIndex >= 0) then
  begin
    FController.IndexRadio := cbb1.ItemIndex;
    Play;
  end;
end;

procedure TfrmRWPForm.ActMudoExecute(Sender: TObject);
begin
  FController.IndexRadio := -1;
  Play;
end;

procedure TfrmRWPForm.ActPararExecute(Sender: TObject);
begin
  Stop;
end;

procedure TfrmRWPForm.ActConfigurarExecute(Sender: TObject);
begin
  FController.CallConfigForm;
end;

procedure TfrmRWPForm.ActSobreExecute(Sender: TObject);
begin
  FController.CallAboutForm;
end;

procedure TfrmRWPForm.ActFecharExecute(Sender: TObject);
begin
  Stop;
  Close;
end;

procedure TfrmRWPForm.ActExibirOcultarExecute(Sender: TObject);
begin
  if Self.Visible then
    Hide
  else
  begin
    Show;
    BringApplicationToFront;
  end;
end;

procedure TfrmRWPForm.RadioMenuClick(Sender: TObject);
begin
  cbb1.ItemIndex := TMenuItem(Sender).Tag;
  ActExecutar.Execute;
end;


end.
