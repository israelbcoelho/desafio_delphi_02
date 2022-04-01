unit Receita.Controller;

interface

uses Interfaces, Arrays;

type
  IReceitaController = interface(ITabela)
    procedure Incluir(var AValue : rReceita);
    procedure Deletar(AId_PedidoVenda: Int64);
    function Listar(AStatus : string) : Lista<rReceita>;
    procedure MarcarComoConcluido(AId : Int64; AIdTecnicoAgricola : Integer);
  end;

  TReceitaController = class(TTabela, IReceitaController)
  private
    procedure Incluir(var AValue : rReceita);
    procedure Deletar(AId_PedidoVenda: Int64);
    function Listar(AStatus : string) : Lista<rReceita>;
    procedure MarcarComoConcluido(AId : Int64; AIdTecnicoAgricola : Integer);
  end;

implementation

uses Receita.DAO, Constantes, Exceptions;

{ TReceitaController }

procedure TReceitaController.Deletar(AId_PedidoVenda: Int64);
var vReceitaDAO : IReceitaDAO;
begin
  vReceitaDAO := TReceitaDAO.Create(Self.FDConnection);
  vReceitaDAO.Deletar(AId_PedidoVenda);
end;

procedure TReceitaController.Incluir(var AValue: rReceita);
var vReceitaDAO : IReceitaDAO;
begin
  vReceitaDAO := TReceitaDAO.Create(Self.FDConnection);
  AValue.ID := vReceitaDAO.Proximo_Id('RECEITA');
  vReceitaDAO.Incluir(AValue);
end;

function TReceitaController.Listar(AStatus : string): Lista<rReceita>;
var vReceitaDAO : IReceitaDAO;
begin
  vReceitaDAO := TReceitaDAO.Create(Self.FDConnection);
  Result := vReceitaDAO.Listar(AStatus);
end;

procedure TReceitaController.MarcarComoConcluido(AId: Int64; AIdTecnicoAgricola : Integer);
var vReceitaDAO : IReceitaDAO;
begin
  if (AIdTecnicoAgricola <= 0) then
    raise TExceptionNaoInformado.Create('Técnico Agrícola não informado.');

  vReceitaDAO := TReceitaDAO.Create(Self.FDConnection);
  vReceitaDAO.MudarStatus(AId, cStatusPedidoConcluido, AIdTecnicoAgricola);
end;

end.

