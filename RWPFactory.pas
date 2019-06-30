unit RWPFactory;

interface

uses
  RWPInterface, System.SysUtils, FMX.Forms;

type
  TRadioWebPlayerFactory = class
  public
    class function GetInstance: IRadioWebPlayer;
  end;

implementation

uses RWPTypes, RWPRegistry, RWPUtils, UfrmRWPIE{, UfrmRWPChromium};

{ TRadioWebPlayerFactory }

class function TRadioWebPlayerFactory.GetInstance: IRadioWebPlayer;
begin
  case GetTipoBrowser of
    brwIE:
    begin
      {$IFDEF MSWINDOWS}
        TRWPRegistry.VerificaIEEmulacao;
      {$ENDIF}
      Application.CreateForm(TfrmRWPIE, frmRWPIE);
      Result := frmRWPIE;
    end;
(*    brwChrome:
    begin
      Application.CreateForm(TfrmRWPChromium, frmRWPChromium);
      Result := frmRWPChromium;
    end;*)
  else
    raise Exception.Create('Não foi possível instanciar a classe. Tipo de browser inválido.');
  end;
end;

end.

