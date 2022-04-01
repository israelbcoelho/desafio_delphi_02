unit Cliente.Controller;

interface

uses Interfaces, Arrays, System.SysUtils, Exceptions;

type
  IClienteController = interface(ITabela)
    procedure Incluir(AValue : rCliente);
    procedure Alterar(AValue : rCliente);
    procedure Deletar(AId: Int64);
    procedure Gravar(AValue : rCliente);
    function Listar( AValue : rCliente) : Lista<rCliente>;  overload;
    function Listar( ANome : string) : Lista<rCliente>; overload;
    function ObterRegistro( AId : Integer) : rCliente;
  end;

  TClienteController = class(TTabela, IClienteController)
  public
    procedure Incluir(AValue : rCliente);
    procedure Alterar(AValue : rCliente);
    procedure Gravar(AValue : rCliente);
    procedure Deletar(AId: Int64);
    function Listar( AValue : rCliente) : Lista<rCliente>;  overload;
    function Listar( ANome : string) : Lista<rCliente>; overload;
    function ObterRegistro( AId : Integer) : rCliente;
  private
    procedure CheckList(AValue: rCliente);
  end;

implementation

uses Cliente.DAO;

{ TClienteController }

procedure TClienteController.Alterar(AValue: rCliente);
var vClienteDAO : IClienteDAO;
begin
  vClienteDAO := TClienteDAO.Create(Self.FDConnection);
  vClienteDAO.Alterar(AValue);
end;

procedure TClienteController.Deletar(AId: Int64);
var vClienteDAO : IClienteDAO;
begin
  vClienteDAO := TClienteDAO.Create(Self.FDConnection);
  vClienteDAO.Deletar(AId);
end;

procedure TClienteController.CheckList(AValue: rCliente);
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

  if (AValue.Cpf.IsEmpty) then
    Add('CFP');

  if not vTexto.IsEmpty then
    raise TExceptionNaoInformado.Create(
                                         'Não foi informado valores obrigatórios!' + sLineBreak +
                                         vTexto
                                       );
end;

procedure TClienteController.Gravar(AValue: rCliente);
begin
  Self.CheckList(AValue);

  if (AValue.Id <= 0) then
    Self.Incluir(AValue)
  else
    Self.Alterar(AValue);
end;

procedure TClienteController.Incluir(AValue: rCliente);
var vClienteDAO : IClienteDAO;
begin
  vClienteDAO := TClienteDAO.Create(Self.FDConnection);

  if (AValue.Id <= 0) then
    AValue.Id := vClienteDAO.Proximo_Id('CLIENTE');

  vClienteDAO.Incluir(AValue);
end;

function TClienteController.Listar(ANome: string): Lista<rCliente>;
begin
  SetLength(Result, 1);
  Result[0].Limpar;
  Result[0].Nome := ANome;
  Result := Self.Listar(Result[0]);
end;

function TClienteController.ObterRegistro(AId: Integer): rCliente;
var vLista : Lista<rCliente>;
begin
  Result.Limpar;
  Result.Id := AId;
  vLista := Self.Listar(Result);

  Result.Limpar;
  if Length(vLista) > 0 then
    Result := vLista[0];
end;

function TClienteController.Listar(AValue: rCliente): Lista<rCliente>;
var vClienteDAO : IClienteDAO;
begin
  vClienteDAO := TClienteDAO.Create(Self.FDConnection);
  Result := vClienteDAO.Listar(AValue);
end;

end.
