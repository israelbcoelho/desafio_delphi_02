unit uFrmBaseDesafio_Delphi_02;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrmBaseDesafio_Delphi_02 = class(TForm)
    procedure SomenteValorMoeda(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBaseDesafio_Delphi_02: TFrmBaseDesafio_Delphi_02;

implementation

{$R *.dfm}

uses Utilitario.Strings;

procedure TFrmBaseDesafio_Delphi_02.SomenteValorMoeda(Sender: TObject; var Key: Char);
var vTexto : string;
begin
   if not CharInSet(key, ['0'..'9', #13, #27, #8, ',']) then
     Abort
   else
   begin
     {Não valida Enter, Delete, BlackSpace}
     if not CharInSet(key, [#13, #27, #8]) then
     begin
       vTexto := TEdit(Sender).Text;

       if vTexto.IndexOf(',') > 0 then
       begin
         if CharInSet(key, [',']) then
           Abort
         else
         begin
           vTexto := RemoverCaracteres(vTexto, ['.']);

           if frac(StrToFloat(vTexto)).ToString().Length >= 4 then
             Abort;
         end;
       end;
     end;
   end;
end;

end.
