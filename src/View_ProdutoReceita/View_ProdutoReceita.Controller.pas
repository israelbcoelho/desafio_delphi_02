unit View_ProdutoReceita.Controller;

interface

uses Interfaces, Arrays, System.SysUtils, Exceptions;

type
  IView_ProdutoReceitaController = interface(ITabela)
    function Listar( AId_Receita : Int64) : Lista<rView_ProdutoReceita>; overload;
  end;

  TView_ProdutoReceitaController = class(TTabela, IView_ProdutoReceitaController)
  public
    function Listar( AId_Receita : Int64 ) : Lista<rView_ProdutoReceita>; overload;
  private

  end;

implementation


uses View_ProdutoReceita.DAO;

{ TView_ProdutoReceitaController }

function TView_ProdutoReceitaController.Listar(AId_Receita : Int64): Lista<rView_ProdutoReceita>;
var vView_ProdutoReceitaDAO : IView_ProdutoReceitaDAO;
begin
  vView_ProdutoReceitaDAO := TView_ProdutoReceitaDAO.Create(Self.FDConnection);
  Result := vView_ProdutoReceitaDAO.Listar(AId_Receita);
end;

end.
