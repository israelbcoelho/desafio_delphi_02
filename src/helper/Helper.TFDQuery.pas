unit Helper.TFDQuery;

interface

uses Ora, System.StrUtils, System.SysUtils, FireDAC.Comp.Client, Forms;

type
  THelperTFDQuery = class helper for TFDQuery
  private

  public
    procedure Abrir();
    procedure ExecutarSQL();
  end;

implementation

{ THelperDQuery }


procedure THelperTFDQuery.ExecutarSQL();
begin
  Self.ExecSQL;
end;

procedure THelperTFDQuery.Abrir();
begin
  Self.Open;
  Self.FetchAll;
end;

end.
