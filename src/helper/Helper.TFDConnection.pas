unit Helper.TFDConnection;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.VCLUI.Wait, System.Classes;

type
  THelperTFDConnection = class helper for TFDConnection
  private
    procedure Inicializar;
  public
    procedure Conectar(
                        ADatabase : string;
                        AUserName : string;
                        APassword : string
                      );
  end;

implementation

{ THelperTFDConnection }

procedure THelperTFDConnection.Conectar(
                                         ADatabase : string;
                                         AUserName : string;
                                         APassword : string
                                       );
begin
  Self.Inicializar;

  Self.Params.Clear;
  Self.Params.Add(Format('Database=%s', [ADatabase]));
  Self.Params.Add(Format('User_Name=%s', [AUserName]));
  Self.Params.Add(Format('Password=%s', [APassword]));
  Self.Params.Add(Format('DriverID=%s', ['FB']));
  Self.Params.Add(Format('MonitorBy=%s', ['FlatFile']));
  Self.Connected := True;
end;

procedure THelperTFDConnection.Inicializar;
begin
  Self.Connected               := False;
  Self.TxOptions.EnableNested  := True;
  Self.TxOptions.AutoCommit    := True;
  Self.TxOptions.AutoStop      := True;
  Self.LoginPrompt             := False;
end;

end.
