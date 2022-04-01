unit udmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, Data.DB,
  FireDAC.Comp.Client, Vcl.Forms, FireDAC.Moni.Base, FireDAC.Moni.FlatFile,
  Vcl.AppEvnts, Exceptions;

type
  TdmConexao = class(TDataModule)
    FDConnection1: TFDConnection;
    Driver_Firebird: TFDPhysFBDriverLink;
    FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink;
    ApplicationEvents1: TApplicationEvents;
    procedure DataModuleCreate(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
  private
    procedure IniciarlizarTecnicoAgricola;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses Helper.TFDConnection, Helper.TStringList, Utilitario.Mensagens, TecnicoAgricola.Controller;

procedure TdmConexao.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
  if (e is TExceptionBase ) then
    msgInformar(e.Message)
  else
  begin
    if not (e is EAbort ) then
    begin
        msgInformar('Ocorreu uma falha inesperada!' + sLineBreak +
                'Erro' + e.message );
    end;
  end;
end;

procedure TdmConexao.DataModuleCreate(Sender: TObject);
var vPath : string;

begin
  vPath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  vPath := TStringList.VoltarDiretorio(vPath);

  Self.Driver_Firebird.VendorHome := vPath;
  Self.Driver_Firebird.VendorLib  := 'fbclient.dll';
  Self.FDConnection1.Conectar(Format('%sdata/desafio_delphi_02.GDB', [vPath]), 'SYSDBA', 'masterkey');

  Self.IniciarlizarTecnicoAgricola;
end;

procedure TdmConexao.IniciarlizarTecnicoAgricola;
var vTecnicoAgricolaController : ITecnicoAgricolaController;
begin
  vTecnicoAgricolaController := TTecnicoAgricolaController.Create(dmConexao.FDConnection1);
  dmConexao.FDConnection1.StartTransaction;
  try
    vTecnicoAgricolaController.DadosDefault;
    dmConexao.FDConnection1.Commit;
  except
    dmConexao.FDConnection1.Rollback;
    raise;
  end;
end;

end.
