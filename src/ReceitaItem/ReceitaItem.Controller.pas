unit ReceitaItem.Controller;

interface

uses Interfaces, Arrays;

type
  IReceitaItemController = interface(ITabela)
    procedure Incluir(AValue : rReceitaItem);
    procedure Deletar(AId_PedidoVenda: Int64);
    function Listar(AId_Receita : Int64) : Lista<rReceitaItem>;
  end;

  TReceitaItemController = class(TTabela, IReceitaItemController)
  private
    procedure Incluir(AValue : rReceitaItem);
    procedure Deletar(AId_PedidoVenda: Int64);
    function Listar(AId_Receita : Int64) : Lista<rReceitaItem>;
  end;

implementation

uses ReceitaItem.DAO;

{ TReceitaItemController }

procedure TReceitaItemController.Deletar(AId_PedidoVenda: Int64);
var vReceitaItemDAO : IReceitaItemDAO;
begin
  vReceitaItemDAO := TReceitaItemDAO.Create(Self.FDConnection);
  vReceitaItemDAO.Deletar(AId_PedidoVenda);
end;

procedure TReceitaItemController.Incluir(AValue: rReceitaItem);
var vReceitaItemDAO : IReceitaItemDAO;
begin
  vReceitaItemDAO := TReceitaItemDAO.Create(Self.FDConnection);
  AValue.ID := vReceitaItemDAO.Proximo_Id('RECEITAITEM');
  vReceitaItemDAO.Incluir(AValue);
end;

function TReceitaItemController.Listar(AId_Receita : Int64): Lista<rReceitaItem>;
var vReceitaItemDAO : IReceitaItemDAO;
begin
  vReceitaItemDAO := TReceitaItemDAO.Create(Self.FDConnection);
  Result := vReceitaItemDAO.Listar(AId_Receita);
end;

end.

