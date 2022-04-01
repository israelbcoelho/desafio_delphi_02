unit ReceitaItem.DAO;

interface

uses Interfaces, Arrays, FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Param, Helper.TFDQuery,
  Data.DB;

type
  IReceitaItemDAO = interface(ITabela)
    procedure Incluir(AValue : rReceitaItem);
    procedure Deletar(AId_Receita: Int64);
    function Listar(AId_Receita : Int64) : Lista<rReceitaItem>;
  end;

  TReceitaItemDAO = class(TTabela, IReceitaItemDAO)
  private
    function DataSet_Para_Record(ADataSet: TDataSet): rReceitaItem;
  public
    procedure Incluir(AValue : rReceitaItem);
    procedure Deletar(AId_Receita: Int64);
    function Listar(AId_Receita : Int64) : Lista<rReceitaItem>;
  end;

implementation

{ TReceitaItemDAO }

procedure TReceitaItemDAO.Deletar(AId_Receita: Int64);
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'DELETE FROM RECEITAITEM ' + sLineBreak +
          '      WHERE ID_RECEITA = :ID_RECEITA';

  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add(vSql);
    vQuery.ParamByName('ID_RECEITA').AsLargeInt :=  AId_Receita;
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

procedure TReceitaItemDAO.Incluir(AValue: rReceitaItem);
var vQuery : TFDQuery;
begin
  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add('INSERT INTO RECEITAITEM( ');
    vQuery.SQL.Add('     ID  ');
    vQuery.SQL.Add('   , ID_RECEITA ');
    vQuery.SQL.Add('   , ID_PEDIDOVENDAITEM ');
    vQuery.SQL.Add('                       )');
    vQuery.SQL.Add('     VALUES (');
    vQuery.SQL.Add('             :ID  ');
    vQuery.SQL.Add('           , :ID_RECEITA ');
    vQuery.SQL.Add('           , :ID_PEDIDOVENDAITEM ');
    vQuery.SQL.Add('            )');
    vQuery.ParamByName('ID').AsLargeInt :=  AValue.ID;
    vQuery.ParamByName('ID_RECEITA').AsLargeInt :=  AValue.ID_RECEITA;
    vQuery.ParamByName('ID_PEDIDOVENDAITEM').AsLargeInt :=  AValue.ID_PEDIDOVENDAITEM;
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;


function TReceitaItemDAO.Listar(AId_Receita: Int64): Lista<rReceitaItem>;
var vQuery : TFDQuery;
begin
  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add('SELECT * ');
    vQuery.SQL.Add('  FROM RECEITAITEM ');
    vQuery.SQL.Add(' WHERE ID_RECEITA = :ID_RECEITA');

    vQuery.ParamByName('ID_RECEITA').AsLargeInt :=  AId_Receita;
    vQuery.Abrir;


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

function TReceitaItemDAO.DataSet_Para_Record(ADataSet : TDataSet ) : rReceitaItem;
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
    if existeColuna('ID') then
      Result.Id := vField.AsLargeInt;

    if existeColuna('ID_RECEITA') then
      Result.ID_RECEITA := vField.AsLargeInt;

    if existeColuna('ID_PEDIDOVENDAITEM') then
      Result.ID_PEDIDOVENDAITEM := vField.AsLargeInt;
  end;
end;

end.

