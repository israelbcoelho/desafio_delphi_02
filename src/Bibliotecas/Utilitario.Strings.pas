unit Utilitario.Strings;

interface

uses
   System.SysUtils;

  function RemoverCaracteres(const pTextoOriginal: string; const pChars : array of string): string;

implementation

function RemoverCaracteres(const pTextoOriginal: string; const pChars : array of string): string;
var I: Integer;
begin
  Result := pTextoOriginal;

  for I := Low(pChars) to High(pChars) do
    Result := StringReplace(Result, pChars[I], '', [rfReplaceAll]);
end;

end.
