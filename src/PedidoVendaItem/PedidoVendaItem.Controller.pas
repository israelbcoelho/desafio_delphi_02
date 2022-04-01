unit PedidoVendaItem.Controller;

interface

uses Interfaces, Arrays, System.SysUtils, Exceptions;

type
  IPedidoVendaItemController = interface(ITabela)
    procedure Incluir(var AValue : rPedidoVendaItem);
    procedure Deletar(AId_PedidoVenda: Int64);
    function Listar(AId_PedidoVenda : Int64): Lista<rPedidoVendaItem>;
    procedure CheckList(AValue: Lista<rPedidoVendaItem>);
  end;

  TPedidoVendaItemController = class(TTabela, IPedidoVendaItemController)
  public
    procedure Incluir(var AValue : rPedidoVendaItem);
    procedure Deletar(AId_PedidoVenda: Int64);
    function Listar(AId_PedidoVenda : Int64): Lista<rPedidoVendaItem>;
    procedure CheckList(AValue: Lista<rPedidoVendaItem>);
  end;

implementation

uses PedidoVendaItem.DAO;

{ TPedidoVendaItemController }

procedure TPedidoVendaItemController.CheckList(AValue: Lista<rPedidoVendaItem>);
var vTexto : string;

  procedure Add(ATexto : string);
  begin
    if (ATexto = EmptyStr) then
      vTexto := ATexto
    else
      vTexto := vTexto + sLineBreak + ATexto
  end;

begin
  vTexto := EmptyStr;

  if (Length(AValue)  <= 0) then
    Add('Pedido sem item');

  if not vTexto.IsEmpty then
    raise TExceptionNaoInformado.Create(
                                         'Não foi informado valores obrigatórios!' + sLineBreak +
                                         vTexto
                                       );
end;

procedure TPedidoVendaItemController.Deletar(AId_PedidoVenda: Int64);
var vPedidoVendaDAO : IPedidoVendaItemDAO;
begin
  vPedidoVendaDAO := TPedidoVendaItemDAO.Create(Self.FDConnection);
  vPedidoVendaDAO.Deletar(AId_PedidoVenda);
end;

procedure TPedidoVendaItemController.Incluir(var AValue: rPedidoVendaItem);
var vPedidoVendaDAO : IPedidoVendaItemDAO;
begin
  vPedidoVendaDAO := TPedidoVendaItemDAO.Create(Self.FDConnection);

  AValue.Id := vPedidoVendaDAO.Proximo_Id('PEDIDOVENDAITEM');

  vPedidoVendaDAO.Incluir(AValue);
end;

function TPedidoVendaItemController.Listar(AId_PedidoVenda: Int64): Lista<rPedidoVendaItem>;
var vPedidoVendaDAO : IPedidoVendaItemDAO;
begin
  vPedidoVendaDAO := TPedidoVendaItemDAO.Create(Self.FDConnection);
  Result := vPedidoVendaDAO.Listar(AId_PedidoVenda);
end;

end.

