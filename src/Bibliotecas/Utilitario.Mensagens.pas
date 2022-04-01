unit Utilitario.Mensagens;

interface

uses System.SysUtils, System.StrUtils;

function msgQuestionar(ATexto : string) : Boolean;
procedure msgInformar(ATexto : string); overload;

implementation

uses Forms, Winapi.Windows;


function msgExibir(ATexto : string; ATitulo : String; AFlags : Integer) : Integer;
begin
  Result := Application.MessageBox(PWideChar(ATexto),
                                   PWideChar(ATitulo),
                                   AFlags);
end;

function msgQuestionar(ATexto : string) : Boolean;
begin
  Result := msgExibir(
                      ATexto,
                      'Confirmação',
                      MB_YESNO
                     ) = IDYES;
end;

procedure msgInformar(ATexto : string);
begin
  msgExibir(
            ATexto,
            'Informação',
            MB_OK
           );
end;

end.
