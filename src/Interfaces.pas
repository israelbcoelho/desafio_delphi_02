unit Interfaces;

interface

uses System.SysUtils, REST.Json.Types, FireDAC.Comp.Client;

type
  ITabela = interface(IInterface)
    function Proximo_Id( ATabela : string) : Int64;
  end;

   TTabela = class(TInterfacedObject, ITabela)
  private
    fFDConnection: TFDConnection;
  protected
    property FDConnection : TFDConnection  read fFDConnection write fFDConnection;

   public
    constructor Create(AConnection: TFDConnection); reintroduce;
    function NovaQuery : TFDQuery;
    function Proximo_Id( ATabela : string) : Int64;
   end;

implementation

{ TTabela }

uses Helper.TFDQuery;


constructor TTabela.Create(AConnection: TFDConnection);
begin
  inherited Create();
  Self.fFDConnection := AConnection;
end;

function TTabela.NovaQuery: TFDQuery;
var vResult : TFDQuery;
begin
  vResult := TFDQuery.Create(nil);
  vResult.Connection := Self.fFDConnection;
  Result := vResult;
end;

function TTabela.Proximo_Id( ATabela : string): Int64;
var vQuery : TFDQuery;
begin
  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Add(Format('SELECT GEN_ID(GN_%S, 1) PROXIMO FROM RDB$DATABASE', [ATabela]));
    vQuery.Abrir();

    Result := vQuery.FieldByName('proximo').AsLargeInt;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

end.
