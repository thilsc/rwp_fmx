unit UfrmConfig;

interface

uses
  System.SysUtils, System.UITypes, System.Variants, System.Classes, FMX.Graphics, FMX.Controls, FMX.Forms,
  FMX.StdCtrls, FMX.Dialogs, FMX.Menus, FMX.Grid, System.Rtti, FMX.Types, FMX.Layouts, FMX.Controls.Presentation;

type
  TfrmConfig = class(TForm)
    btnOK: TButton;
    btnCancelar: TButton;
    pmnEstacoes: TPopupMenu;
    mnuEditRadio: TMenuItem;
    mnuInclRadio: TMenuItem;
    mnuExclRadio: TMenuItem;
    grpCanais: TGroupBox;
    sg: TStringGrid;
    grpGeral: TGroupBox;
    chkExibirMsg: TCheckBox;
    chkIniciarMinimizado: TCheckBox;
    chkIniciar: TCheckBox;
    lbl1: TLabel;
    colEstacoes: TStringColumn;
    colURL: TStringColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure mnuInclRadioClick(Sender: TObject);
    procedure mnuExclRadioClick(Sender: TObject);
    procedure mnuEditRadioClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnCancelarClick(Sender: TObject);
    procedure sgDblClick(Sender: TObject);
    procedure sgKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    FListaRadios: TStringList;
    FAtualizarCanais: Boolean;
    procedure CarregarCanaisNaGrid;
    { Private declarations }
  public
    { Public declarations }
    property AtualizarCanais: Boolean read FAtualizarCanais;
  end;

var
  frmConfig: TfrmConfig;

implementation

uses RWPConsts, RWPTypes, RWPUtils, StrUtils, Math;

{$R *.fmx}

procedure TfrmConfig.FormCreate(Sender: TObject);
begin
  chkIniciar.IsChecked := (GetConfigStr('IniciarWindows') = 'S');
  chkExibirMsg.IsChecked := (GetConfigStr('ExibirMsgErro') = 'S');
  chkIniciarMinimizado.IsChecked := (GetConfigStr('IniciarMinimizado') = 'S');

  FListaRadios := GetCanais;
  CarregarCanaisNaGrid;
  FAtualizarCanais := False;
end;

procedure TfrmConfig.CarregarCanaisNaGrid;
var
  iCol, iRow: Cardinal;
begin
  sg.RowCount := FListaRadios.Count + 1;
  sg.Columns[0].Header := 'Estações';
  sg.Columns[1].Header := 'URL';

  for iRow := 1 to Pred(sg.RowCount) do
    for iCol := 0 to Pred(sg.ColumnCount) do
      case iCol of
        0:
          sg.Cells[iCol, iRow] := FListaRadios.Names[iRow - 1];
        1:
          sg.Cells[iCol, iRow] := FListaRadios.ValueFromIndex[iRow - 1];
      end;
end;

procedure TfrmConfig.mnuEditRadioClick(Sender: TObject);
var
  Index: Integer;
  NomeDaRadio, UrlDaRadio, NovoValor: string;
begin
//  Index := sg.ColumnByPoint(Mouse.X, Mouse.Y).Top;
Index := 0;

  NomeDaRadio := sg.Cells[0, Index];
  UrlDaRadio := sg.Cells[1, Index];
  NovoValor := InputBox('Editar estação', NomeDaRadio, UrlDaRadio);

  if (UrlDaRadio <> NovoValor) and (Trim(NovoValor) <> EmptyStr) then
  begin
    sg.Cells[1, Index] := NovoValor;
    FListaRadios.ValueFromIndex[Pred(Index)] := NovoValor;
    FAtualizarCanais := True;
  end;
end;

procedure TfrmConfig.mnuExclRadioClick(Sender: TObject);
var
  I, IndexInicial, IndexFinal: Integer;
begin
  if MessageDlg('Tem certeza de que deseja excluir a rádio?',
                System.UITypes.TMsgDlgType.mtConfirmation,
                [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0) = mrYes then
  begin
    //colEstacoes.
    IndexInicial := 0;//Pred(sg.Columns[0].Top);
    IndexFinal   := -1;//Pred(sg.Columns[0].Bottom);

    I := IndexInicial;
    while I <= IndexFinal do
    begin
      FListaRadios.Delete(IndexInicial);
      Inc(I);
    end;

    CarregarCanaisNaGrid;
    FAtualizarCanais := True;
  end;
end;

procedure TfrmConfig.mnuInclRadioClick(Sender: TObject);
var
  NomeDaEstacao: string;
begin
  NomeDaEstacao := Trim(InputBox('Inserir Nova Estação','Estação:', EmptyStr));
  if (NomeDaEstacao <> EmptyStr) then
  begin
    FListaRadios.Add(NomeDaEstacao+'=');
    CarregarCanaisNaGrid;
    FAtualizarCanais := True;
  end;
end;

procedure TfrmConfig.sgDblClick(Sender: TObject);
begin
  mnuEditRadioClick(Sender);
end;

procedure TfrmConfig.sgKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  case Key of
    vkInsert: mnuInclRadioClick(Sender);
    vkDelete: mnuExclRadioClick(Sender);
  end;
end;

procedure TfrmConfig.btnCancelarClick(Sender: TObject);
begin
//
end;

procedure TfrmConfig.btnOKClick(Sender: TObject);
var
  Params: TArrayParams;
begin
  SetCanais(FListaRadios);

  SetLength(Params, 4);
  Params[0].Name := 'IniciarWindows';
  Params[0].Value:= IfThen(chkIniciar.IsChecked,'S','N');
  Params[1].Name := 'ExibirMsgErro';
  Params[1].Value:= IfThen(chkExibirMsg.IsChecked, 'S', 'N');
  Params[2].Name := 'IniciarMinimizado';
  Params[2].Value:= IfThen(chkIniciarMinimizado.IsChecked, 'S', 'N');
  GravarConfiguracoes(Params);
end;

procedure TfrmConfig.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FAtualizarCanais then
    case MessageDlg('Deseja salvar as alterações?',
                    System.UITypes.TMsgDlgType.mtConfirmation, mbYesNoCancel, 0) of
      mrYes:
        begin
          btnOKClick(Sender);
          CanClose := True;
        end;

      mrNo:
        begin
          ModalResult := mrCancel;
          CanClose := True;
        end;

      mrCancel:
        CanClose := False;
    end;
end;

end.


