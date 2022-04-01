unit SolicitacaoReceita.Controller;

interface

uses Interfaces, Arrays;

type
  ISolicitacaoReceitaController = interface(ITabela)
    procedure Incluir(AValue : rSolicitacaoReceita);
    procedure Deletar(AId_PedidoVenda: Int64);
  end;

  TSolicitacaoReceitaController = class(TTabela, ISolicitacaoReceitaController)
  private
    procedure Incluir(AValue : rSolicitacaoReceita);
    procedure Deletar(AId_PedidoVenda: Int64);
  end;

implementation

uses SolicitacaoReceita.DAO;

{ TSolicitacaoReceitaController }

procedure TSolicitacaoReceitaController.Deletar(AId_PedidoVenda: Int64);
var vPedidoVendaDAO : ISolicitacaoReceitaDAO;
begin
  vPedidoVendaDAO := TSolicitacaoReceitaDAO.Create(Self.FDConnection);
  vPedidoVendaDAO.Deletar(AId_PedidoVenda);
end;

procedure TSolicitacaoReceitaController.Incluir(AValue: rSolicitacaoReceita);
begin

end;

end.

