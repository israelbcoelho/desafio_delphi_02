unit PedidoVenda.Controller;

interface

uses Interfaces, Arrays, System.SysUtils, Constantes;

type
  IPedidoVendaController = interface(ITabela)
    procedure Incluir(var AValue : rPedidoVenda);
    function Listar (AId : Int64) : Lista<rPedidoVenda>;
    procedure Deletar(AId: Int64);
    function ObterRegistro(AId_Pedido : Int64) : rPedidoVenda;
    procedure CheckList(AValue: rPedidoVenda);
    procedure MarcarAguardarReceira(AId : Int64);
    procedure MarcarComoConcluido(AId : Int64);
  end;

  TPedidoVendaController = class(TTabela, IPedidoVendaController)
  private

  public
    procedure Incluir(var AValue : rPedidoVenda);
    function Listar (AId : Int64) : Lista<rPedidoVenda>;
    procedure Deletar(AId: Int64);
    function ObterRegistro(AId_Pedido : Int64) : rPedidoVenda;
    procedure CheckList(AValue: rPedidoVenda);
    procedure MarcarAguardarReceira(AId : Int64);
    procedure MarcarComoConcluido(AId : Int64);
  end;

implementation

{ TPedidoVendaController }
uses PedidoVenda.DAO, Exceptions;

procedure TPedidoVendaController.CheckList(AValue: rPedidoVenda);
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

  if (AValue.Id  <= 0) then
    Add('Id Pedido');

  if (AValue.Data  <= 0) then
    Add('Data Pedido');

  if (AValue.ValorTotal  <= 0) then
    Add('Vlr.Total Pedido');

  if (AValue.Id_Cliente  <= 0) then
    Add('Id.Cliente');

  if not vTexto.IsEmpty then
    raise TExceptionNaoInformado.Create(
                                         'Não foi informado valores obrigatórios!' + sLineBreak +
                                         vTexto
                                       );
end;

procedure TPedidoVendaController.Deletar(AId: Int64);
var vPedidoVendaDAO : IPedidoVendaDAO;
begin
  vPedidoVendaDAO := TPedidoVendaDAO.Create(Self.FDConnection);
  vPedidoVendaDAO.Deletar(AId);
end;

procedure TPedidoVendaController.Incluir(var AValue: rPedidoVenda);
var vPedidoVendaDAO : IPedidoVendaDAO;
begin
  vPedidoVendaDAO := TPedidoVendaDAO.Create(Self.FDConnection);
//  AValue.Id := vPedidoVendaDAO.Proximo_Id('PEDIDOVENDA');
  vPedidoVendaDAO.Incluir(AValue);
end;

function TPedidoVendaController.Listar(AId : Int64): Lista<rPedidoVenda>;
var vPedidoVendaDAO : IPedidoVendaDAO;
begin
  vPedidoVendaDAO := TPedidoVendaDAO.Create(Self.FDConnection);
  Result := vPedidoVendaDAO.Listar(AId);
end;

procedure TPedidoVendaController.MarcarAguardarReceira(AId : Int64);
var vPedidoVendaDAO : IPedidoVendaDAO;
begin
  vPedidoVendaDAO := TPedidoVendaDAO.Create(Self.FDConnection);
  vPedidoVendaDAO.MudarStatus(AId, cStatusPedidoAguardando);
end;

procedure TPedidoVendaController.MarcarComoConcluido(AId : Int64);
var vPedidoVendaDAO : IPedidoVendaDAO;
begin
  vPedidoVendaDAO := TPedidoVendaDAO.Create(Self.FDConnection);
  vPedidoVendaDAO.MudarStatus(AId, cStatusPedidoConcluido);
end;

function TPedidoVendaController.ObterRegistro(AId_Pedido: Int64): rPedidoVenda;
var vLista : Lista<rPedidoVenda>;
begin
  vLista := Self.Listar(AId_Pedido);

  Result.Limpar;
  if (Length(vLista) > 0) then
    Result := vLista[0];
end;

end.

