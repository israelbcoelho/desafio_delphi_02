unit TecnicoAgricola.Controller;

interface

uses Interfaces, Arrays;

type
  ITecnicoAgricolaController = interface(ITabela)
    procedure Incluir(AValue : rTecnicoAgricola);
    function Listar( AValue : rTecnicoAgricola) : Lista<rTecnicoAgricola>;  overload;
    function ObterRegistro( AId : Integer) : rTecnicoAgricola;
    procedure DadosDefault();
  end;

  TTecnicoAgricolaController = class(TTabela, ITecnicoAgricolaController)
  public
    procedure Incluir(AValue : rTecnicoAgricola);
    function Listar( AValue : rTecnicoAgricola) : Lista<rTecnicoAgricola>;  overload;
    function ObterRegistro( AId : Integer) : rTecnicoAgricola;
    procedure DadosDefault();
  private
  end;

implementation

uses TecnicoAgricola.DAO;

{ TTecnicoAgricolaController }

procedure TTecnicoAgricolaController.DadosDefault;
var I : Integer;
    vTecnicoAgricola : rTecnicoAgricola;
begin
  for I := Low(cTecnicoAgricola) to High(cTecnicoAgricola) do
  begin
    if (Self.ObterRegistro(cTecnicoAgricola[I].Id).Id <= 0) then
    begin
      vTecnicoAgricola.Limpar;
      vTecnicoAgricola.Id             := cTecnicoAgricola[I].Id;
      vTecnicoAgricola.Nome           := cTecnicoAgricola[I].Nome;
      vTecnicoAgricola.Cpf            := cTecnicoAgricola[I].Cpf;
      vTecnicoAgricola.NumeroRegistro := cTecnicoAgricola[I].NumeroRegistro;

      Self.Incluir(vTecnicoAgricola);
    end;
  end;
end;

procedure TTecnicoAgricolaController.Incluir(AValue: rTecnicoAgricola);
var vTecnicoAgricolaDAO : ITecnicoAgricolaDAO;
begin
  vTecnicoAgricolaDAO := TTecnicoAgricolaDAO.Create(Self.FDConnection);

  vTecnicoAgricolaDAO.Incluir(AValue);
end;


function TTecnicoAgricolaController.ObterRegistro(AId: Integer): rTecnicoAgricola;
var vLista : Lista<rTecnicoAgricola>;
begin
  Result.Limpar;
  Result.Id := AId;
  vLista := Self.Listar(Result);

  Result.Limpar;
  if Length(vLista) > 0 then
    Result := vLista[0];
end;

function TTecnicoAgricolaController.Listar(AValue: rTecnicoAgricola): Lista<rTecnicoAgricola>;
var vTecnicoAgricolaDAO : ITecnicoAgricolaDAO;
begin
  vTecnicoAgricolaDAO := TTecnicoAgricolaDAO.Create(Self.FDConnection);
  Result := vTecnicoAgricolaDAO.Listar(AValue);
end;

end.
