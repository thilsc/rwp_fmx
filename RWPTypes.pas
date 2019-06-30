unit RWPTypes;

interface

type
  TTipoBrowser = (brwNone, brwIE, brwChrome);

  TParamFile = record
                 Name,
                 Value: string;
               end;
  TArrayParams = array of TParamFile;

implementation

end.
