unit Produto.Controller;

interface

uses Interfaces, Arrays, System.SysUtils, Exceptions;

type
  IProdutoController = interface(ITabela)
    procedure Incluir(AValue : rProduto);
    procedure Alterar(AValue : rProduto);
    procedure Deletar(AId: Int64);
    procedure Gravar(AValue : rProduto);
    function Listar( AValue : rProduto) : Lista<rProduto>;  overload;
    function Listar( ANome : string) : Lista<rProduto>; overload;
    function ObterRegistro( AId : Integer) : rProduto;
  end;

  TProdutoController = class(TTabela, IProdutoController)
  public
    procedure Incluir(AValue : rProduto);
    procedure Alterar(AValue : rProduto);
    procedure Gravar(AValue : rProduto);
    procedure Deletar(AId: Int64);
    function Listar( AValue : rProduto) : Lista<rProduto>;  overload;
    function Listar( ANome : string) : Lista<rProduto>; overload;
    function ObterRegistro( AId : Integer) : rProduto;
    procedure CheckList(AValue: rProduto);
  private

  end;

implementation



uses Produto.DAO;

{ TProdutoController }

procedure TProdutoController.CheckList(AValue: rProduto);
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

  if (AValue.Nome.IsEmpty) then
    Add('Nome');

  if (AValue.Valor  <= 0) then
    Add('Valor');

  if not vTexto.IsEmpty then
    raise TExceptionNaoInformado.Create(
                                         'Não foi informado valores obrigatórios!' + sLineBreak +
                                         vTexto
                                       );
end;

procedure TProdutoController.Alterar(AValue: rProduto);
var vProdutoDAO : IProdutoDAO;
begin
  vProdutoDAO := TProdutoDAO.Create(Self.FDConnection);
  vProdutoDAO.Alterar(AValue);
end;

procedure TProdutoController.Deletar(AId: Int64);
var vProdutoDAO : IProdutoDAO;
begin
  vProdutoDAO := TProdutoDAO.Create(Self.FDConnection);
  vProdutoDAO.Deletar(AId);
end;

procedure TProdutoController.Gravar(AValue: rProduto);
begin
  Self.CheckList(AValue);

  if (AValue.Id <= 0) then
    Self.Incluir(AValue)
  else
    Self.Alterar(AValue);
end;

procedure TProdutoController.Incluir(AValue: rProduto);
var vProdutoDAO : IProdutoDAO;
begin
  vProdutoDAO := TProdutoDAO.Create(Self.FDConnection);

  if (AValue.Id <= 0) then
    AValue.Id := vProdutoDAO.Proximo_Id('PRODUTO');// ObterProximoId;

  vProdutoDAO.Incluir(AValue);
end;

function TProdutoController.Listar(ANome: string): Lista<rProduto>;
begin
  SetLength(Result, 1);
  Result[0].Limpar;
  Result[0].Nome := ANome;
  Result := Self.Listar(Result[0]);
end;

function TProdutoController.ObterRegistro(AId: Integer): rProduto;
var vLista : Lista<rProduto>;
begin
  Result.Limpar;
  Result.Id := AId;
  vLista := Self.Listar(Result);

  Result.Limpar;
  if Length(vLista) > 0 then
    Result := vLista[0];
end;

function TProdutoController.Listar(AValue: rProduto): Lista<rProduto>;
var vProdutoDAO : IProdutoDAO;
begin
  vProdutoDAO := TProdutoDAO.Create(Self.FDConnection);
  Result := vProdutoDAO.Listar(AValue);
end;

end.
