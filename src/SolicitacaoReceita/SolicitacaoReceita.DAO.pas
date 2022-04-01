unit SolicitacaoReceita.DAO;

interface

uses Interfaces, Arrays, FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Param;

type
  ISolicitacaoReceitaDAO = interface(ITabela)
    procedure Incluir(AValue : rSolicitacaoReceita);
    procedure Deletar(AId: Int64);
  end;

  TSolicitacaoReceitaDAO = class(TTabela, ISolicitacaoReceitaDAO)
  public
    procedure Incluir(AValue : rSolicitacaoReceita);
    procedure Deletar(AId: Int64);
  end;

implementation

{ TSolicitacaoReceitaDAO }

procedure TSolicitacaoReceitaDAO.Deletar(AId: Int64);
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'DELETE FROM SOLICITACAORECEITA ' + sLineBreak +
          '      WHERE ID_PEDIDO = :ID_PEDIDO';

  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add(vSql);
    vQuery.ParamByName('ID_PEDIDO').AsLargeInt :=  AId;
    vQuery.ExecSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

procedure TSolicitacaoReceitaDAO.Incluir(AValue: rSolicitacaoReceita);
begin

end;

end.

