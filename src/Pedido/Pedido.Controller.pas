unit Pedido.Controller;

interface

uses Interfaces, Arrays, Cliente.Controller, Produto.Controller,
  FireDAC.Comp.Client, PedidoVenda.Controller, PedidoVendaItem.Controller, Receita.Controller,
  ReceitaItem.Controller;

type
  IPedidoController = interface(ITabela)
    function Cliente : IClienteController;
    function Produto : IProdutoController;
    function PedidoVenda : IPedidoVendaController;
    function PedidoVendaItem : IPedidoVendaItemController;
    function Receita : IReceitaController;
    procedure Gravar(var APedidoVenda : rPedidoVenda; var APedidoVendaItem : Lista<rPedidoVendaItem>);

  end;

  TPedidoController = class(TTabela, IPedidoController)
  private
    fCliente : IClienteController;
    fProduto : IProdutoController;
    fPedidoVenda :  IPedidoVendaController;
    fPedidoVendaItem : IPedidoVendaItemController;
    fReceita : IReceitaController;
  public
    function Cliente : IClienteController;
    function Produto : IProdutoController;
    function PedidoVenda : IPedidoVendaController;
    function PedidoVendaItem : IPedidoVendaItemController;
    function Receita : IReceitaController;
    procedure Gravar(var APedidoVenda : rPedidoVenda; var APedidoVendaItem : Lista<rPedidoVendaItem>);
    constructor Create(AConnection: TFDConnection); reintroduce;
    procedure Deletar(AId_Pedido : Int64);
  end;


implementation

uses Constantes;

{ TPedidoController }

function TPedidoController.Cliente: IClienteController;
begin
  if not Assigned(fCliente) then
    fCliente := TClienteController.Create(Self.FDConnection);

  Result := fCliente;
end;

constructor TPedidoController.Create(AConnection: TFDConnection);
begin
  inherited Create(AConnection);
end;

procedure TPedidoController.Deletar(AId_Pedido: Int64);
begin
  Self.Receita.Deletar(AId_Pedido);
  Self.PedidoVendaItem.Deletar(AId_Pedido);
  Self.PedidoVenda.Deletar(AId_Pedido);
end;

procedure TPedidoController.Gravar(var APedidoVenda: rPedidoVenda; var APedidoVendaItem: Lista<rPedidoVendaItem>);
var
    I : Integer;
    vReceita : rReceita;
    vReceitaItem : rReceitaItem;
    vReceitaController : IReceitaController;
    vReceitaItemController : IReceitaItemController;
    vPedidoAguardandoReceita : Boolean;

  function IdReceita : Int64;
  begin
    if (vReceita.ID <= 0) then
    begin
      vReceita.ID_PEDIDO :=  APedidoVenda.Id;
      vReceita.STATUS := cStatusPedidoAguardando;

      vReceitaController.Incluir(vReceita);
    end;

    Result := vReceita.ID;
  end;

begin
  Self.PedidoVenda.CheckList(APedidoVenda);
  Self.PedidoVendaItem.CheckList(APedidoVendaItem);

  vReceitaController := TReceitaController.Create(Self.FDConnection);
  vReceitaItemController := TReceitaItemController.Create(Self.FDConnection);

  APedidoVenda.Status := cStatusPedidoConcluido;
  vPedidoAguardandoReceita := False;
  vReceita.Limpar;

  PedidoVenda.Incluir(APedidoVenda);

  for I := Low(APedidoVendaItem) to High(APedidoVendaItem) do
  begin
    APedidoVendaItem[I].Id_Pedido := APedidoVenda.Id;
    PedidoVendaItem.Incluir(APedidoVendaItem[I]);

    if (APedidoVendaItem[I]._ControleEspecial = 'S') then
    begin
      vReceitaItem.Limpar;
      vReceitaItem.ID_RECEITA := IdReceita;
      vReceitaItem.ID_PEDIDOVENDAITEM := APedidoVendaItem[I].Id;
      vReceitaItemController.Incluir(vReceitaItem);

      vPedidoAguardandoReceita := True;
    end;
  end;

  if vPedidoAguardandoReceita then
    PedidoVenda.MarcarAguardarReceira(APedidoVenda.Id);
end;

function TPedidoController.PedidoVenda: IPedidoVendaController;
begin
  if not Assigned(fPedidoVenda) then
    fPedidoVenda := TPedidoVendaController.Create(Self.FDConnection);

  Result := fPedidoVenda;
end;

function TPedidoController.PedidoVendaItem: IPedidoVendaItemController;
begin
  if not Assigned(fPedidoVendaItem) then
    fPedidoVendaItem := TPedidoVendaItemController.Create(Self.FDConnection);

  Result := fPedidoVendaItem;
end;

function TPedidoController.Produto: IProdutoController;
begin
  if not Assigned(fProduto) then
    fProduto := TProdutoController.Create(Self.FDConnection);

  Result := fProduto;
end;

function TPedidoController.Receita: IReceitaController;
begin
  if not Assigned(fReceita) then
    fReceita := TReceitaController.Create(Self.FDConnection);

  Result := fReceita;
end;

end.
