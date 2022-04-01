unit View_ProdutoReceita.DAO;

interface

uses
  Interfaces, Arrays, FireDAC.Comp.Client, System.SysUtils, System.StrUtils, FireDAC.Stan.Param,
  Data.DB, Winapi.Windows, FireDAC.DApt, Helper.TFDQuery;

type
  IView_ProdutoReceitaDAO = interface(ITabela)
    function Listar( AId_Receita : Int64) : Lista<rView_ProdutoReceita>;
  end;

  TView_ProdutoReceitaDAO = class(TTabela, IView_ProdutoReceitaDAO)
    function Listar( AId_Receita : Int64 ) : Lista<rView_ProdutoReceita>;
  private
    function DataSet_Para_Record(ADataSet: TDataSet): rView_ProdutoReceita;
  end;

implementation

{ TView_ProdutoReceitaDAO }

function TView_ProdutoReceitaDAO.Listar(AId_Receita : Int64): Lista<rView_ProdutoReceita>;
var vQuery : TFDQuery;
begin
  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Add('SELECT * ');
    vQuery.SQL.Add('  FROM VIEW_PRODUTORECEITA');
    vQuery.SQL.Add(' WHERE ID_RECEITA = :ID_RECEITA ');

    vQuery.ParamByName('ID_RECEITA').AsLargeInt := AId_Receita;
    vQuery.Abrir();

    SetLength(Result, vQuery.RecordCount);
    while not vQuery.Eof do
    begin
      Result[vQuery.RecNo - 1] := Self.DataSet_Para_Record(vQuery);

      vQuery.Next;
    end;


  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

function TView_ProdutoReceitaDAO.DataSet_Para_Record(ADataSet : TDataSet ) : rView_ProdutoReceita;
var vField : TField;
    lNomeColuna : string;

  function existeColuna(ANomeColuna : string) : Boolean;
  begin
    lNomeColuna := ANomeColuna;
    vField := ADataSet.FindField(ANomeColuna);
    Result := Assigned(vField);
  end;

begin
  Result.Limpar;

  if not ADataSet.IsEmpty then
  begin
    if existeColuna('ID_RECEITA') then
      Result.id_receita := vField.AsLargeInt;

    if existeColuna('ID_PRODUTO') then
      Result.id_Produto := vField.AsLargeInt;

    if existeColuna('NOME') then
      Result.nome := vField.AsString;
  end;
end;


end.
