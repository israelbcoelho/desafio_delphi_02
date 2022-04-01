unit Receita.DAO;

interface

uses Interfaces, Arrays, FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Param,
  Data.DB, Helper.TFDQuery;

type
  IReceitaDAO = interface(ITabela)
    procedure Incluir(AValue : rReceita);
    procedure Deletar(AId: Int64);
    function Listar(AStatus : string) : Lista<rReceita>;
    procedure MudarStatus(AId : Int64; AStatus : string; AIdTecnicoAgricola : Integer);
  end;

  TReceitaDAO = class(TTabela, IReceitaDAO)
  private
    function DataSet_Para_Record(ADataSet: TDataSet): rReceita;
  public
    procedure Incluir(AValue : rReceita);
    procedure Deletar(AId: Int64);
    function Listar(AStatus : string) : Lista<rReceita>;
    procedure MudarStatus(AId : Int64; AStatus : string; AIdTecnicoAgricola : Integer);
  end;

implementation

{ TReceitaDAO }

procedure TReceitaDAO.Deletar(AId: Int64);
var vQuery : TFDQuery;
begin
  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add('DELETE FROM RECEITA ');
    vQuery.SQL.Add('      WHERE ID = :ID ');
    vQuery.ParamByName('ID').AsLargeInt :=  AId;
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

procedure TReceitaDAO.Incluir(AValue: rReceita);
var vQuery : TFDQuery;
begin
  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add('INSERT INTO RECEITA( ');
    vQuery.SQL.Add('     ID  ');
    vQuery.SQL.Add('   , ID_PEDIDO ');
    vQuery.SQL.Add('   , STATUS ');
    vQuery.SQL.Add('                       )');
    vQuery.SQL.Add('     VALUES (');
    vQuery.SQL.Add('             :ID  ');
    vQuery.SQL.Add('           , :ID_PEDIDO ');
    vQuery.SQL.Add('           , :STATUS ');
    vQuery.SQL.Add('            )');
    vQuery.ParamByName('ID').AsLargeInt :=  AValue.ID;
    vQuery.ParamByName('ID_PEDIDO').AsLargeInt :=  AValue.ID_PEDIDO;
    vQuery.ParamByName('STATUS').AsString :=  AValue.STATUS;
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

function TReceitaDAO.Listar(AStatus : string): Lista<rReceita>;
var vQuery : TFDQuery;
begin
  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add('SELECT * ');
    vQuery.SQL.Add('  FROM RECEITA ');
    vQuery.SQL.Add(' WHERE 1 = 1 ');

    if not AStatus.IsEmpty then
    begin
      vQuery.SQL.Add('   AND STATUS = :STATUS ');
      vQuery.ParamByName('STATUS').AsString := AStatus;
    end;

    vQuery.Abrir;

    vQuery.FetchAll;

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

procedure TReceitaDAO.MudarStatus(AId: Int64; AStatus: string; AIdTecnicoAgricola : Integer);
var vQuery : TFDQuery;
begin
  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add('UPDATE RECEITA');
    vQuery.SQL.Add('   SET STATUS = :STATUS');

    if (AIdTecnicoAgricola > 0) then
      vQuery.SQL.Add('     , ID_TECNICOAGRICOLA = :ID_TECNICOAGRICOLA');

    vQuery.SQL.Add(' WHERE ID = :ID');

    vQuery.ParamByName('ID').AsLargeInt := AId;
    vQuery.ParamByName('STATUS').AsString := AStatus;

    if (AIdTecnicoAgricola > 0) then
      vQuery.ParamByName('ID_TECNICOAGRICOLA').AsLargeInt := AIdTecnicoAgricola;

    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

function TReceitaDAO.DataSet_Para_Record(ADataSet : TDataSet ) : rReceita;
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

    if existeColuna('ID_PEDIDO') then
      Result.ID_PEDIDO := vField.AsLargeInt;

    if existeColuna('STATUS') then
      Result.STATUS := vField.AsString;

    if existeColuna('ID_TECNICOAGRICOLA') then
      Result.Id_TecnicoAgricola := vField.AsLargeInt;
  end;
end;

end.

