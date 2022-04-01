unit Produto.DAO;

interface

uses
  Interfaces, Arrays, FireDAC.Comp.Client, System.SysUtils, System.StrUtils, FireDAC.Stan.Param,
  Data.DB, Winapi.Windows, FireDAC.DApt, Helper.TFDQuery;

type
  IProdutoDAO = interface(ITabela)
    procedure Incluir(AValue : rProduto);
    procedure Alterar(AValue : rProduto);
    procedure Deletar(AId: Int64);
    function Listar( AValue : rProduto) : Lista<rProduto>;
  end;

  TProdutoDAO = class(TTabela, IProdutoDAO)
    procedure Incluir(AValue : rProduto);
    procedure Alterar(AValue : rProduto);
    procedure Deletar(AId: Int64);
    function Listar( AValue : rProduto) : Lista<rProduto>;
  private
    function DataSet_Para_Record(ADataSet: TDataSet): rProduto;
  end;

implementation

{ TProdutoDAO }

procedure TProdutoDAO.Alterar(AValue: rProduto);
var vQuery : TFDQuery;
begin
  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add('UPDATE PRODUTO ');
    vQuery.SQL.Add('   SET NOME = :NOME ');
    vQuery.SQL.Add('     , VALOR = :VALOR ');
    vQuery.SQL.Add('     , CONTROLEESPECIAL = :CONTROLEESPECIAL ');
    vQuery.SQL.Add(' WHERE ID = :ID ');

    vQuery.ParamByName('ID').AsLargeInt               := AValue.Id;
    vQuery.ParamByName('NOME').AsString               := AValue.Nome;
    vQuery.ParamByName('VALOR').AsFloat               := AValue.Valor;
    vQuery.ParamByName('CONTROLEESPECIAL').AsString   := IfThen(AValue.ControleEspecial, 'S', 'N');
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

procedure TProdutoDAO.Deletar(AId: Int64);
var vQuery : TFDQuery;
begin
  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add('DELETE FROM PRODUTO ');
    vQuery.SQL.Add('      WHERE ID = :ID');

    vQuery.ParamByName('ID').AsLargeInt :=  AId;
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

procedure TProdutoDAO.Incluir(AValue: rProduto);
var vQuery : TFDQuery;
begin
  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add('INSERT INTO PRODUTO( ');
    vQuery.SQL.Add('                      ID ');
    vQuery.SQL.Add('                    , NOME ');
    vQuery.SQL.Add('                    , VALOR ');
    vQuery.SQL.Add('                    , CONTROLEESPECIAL ');
    vQuery.SQL.Add('                   ) ');
    vQuery.SQL.Add('VALUES( ');
    vQuery.SQL.Add('        :ID ');
    vQuery.SQL.Add('      , :NOME ');
    vQuery.SQL.Add('      , :VALOR ');
    vQuery.SQL.Add('      , :CONTROLEESPECIAL ');
    vQuery.SQL.Add('      ) ');
    vQuery.ParamByName('ID').AsLargeInt               := AValue.Id;
    vQuery.ParamByName('NOME').AsString               := AValue.Nome;
    vQuery.ParamByName('VALOR').AsFloat               := AValue.Valor;
    vQuery.ParamByName('CONTROLEESPECIAL').AsString   := IfThen(AValue.ControleEspecial, 'S', 'N');
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

function TProdutoDAO.Listar(AValue: rProduto): Lista<rProduto>;
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'SELECT * ' +sLineBreak +
          '  FROM PRODUTO ' +sLineBreak +
          ' WHERE 1 = 1 ';

  if (AValue.Id > 0) then
  begin
    vSql := vSql + sLineBreak +
            '   AND ID = :ID ';
  end;

  if not AValue.Nome.IsEmpty then
  begin
    vSql := vSql + sLineBreak +
            '   AND NOME LIKE :NOME';
  end;

  vSql := vSql + sLineBreak +
          'ORDER BY ID';

  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Add(vSql);

    if (AValue.Id > 0) then
      vQuery.ParamByName('ID').AsLargeInt := AValue.Id;

    if not AValue.Nome.IsEmpty then
      vQuery.ParamByName('NOME').AsString := AValue.Nome + '%';

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

function TProdutoDAO.DataSet_Para_Record(ADataSet : TDataSet ) : rProduto;
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

    if existeColuna('NOME') then
      Result.Nome := vField.AsString;

    if existeColuna('VALOR') then
      Result.Valor := vField.AsFloat;

    if existeColuna('CONTROLEESPECIAL') then
      Result.ControleEspecial := vField.AsString = 'S';
  end;
end;


end.
