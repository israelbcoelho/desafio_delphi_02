unit Helper.TStringList;

interface

uses
  System.Classes, System.SysUtils;


type
  THelperTStringList= class helper for TStringList
  private

  public
    class function VoltarDiretorio(ADiretorio : string) : string;
  end;

implementation

{ THelperTStringList }

class function THelperTStringList.VoltarDiretorio(ADiretorio: string): string;
var vLista : TStringList;
    I : Integer;
    vResult : string;
begin
  vLista := TStringList.Create;
  try
    vLista.Delimiter       := '\';
    vLista.Duplicates      := dupIgnore;
    vLista.StrictDelimiter := True;
    vLista.DelimitedText   := ADiretorio;

    vResult := EmptyStr;
    for I := 0 to vLista.Count - 3 do
      vResult := vResult + Format('%s/', [vLista[I]]);

    Result := vResult;
  finally
    FreeAndNil(vLista);
  end;
end;

end.

