unit Cliente.DAO;

interface

uses
  Interfaces, Arrays, FireDAC.Comp.Client, System.SysUtils, System.StrUtils, FireDAC.Stan.Param,
  Data.DB, Winapi.Windows, FireDAC.DApt, Helper.TFDQuery;

type
  IClienteDAO = interface(ITabela)
    procedure Incluir(AValue : rCliente);
    procedure Alterar(AValue : rCliente);
    procedure Deletar(AId: Int64);
    function Listar( AValue : rCliente) : Lista<rCliente>;
//    function ObterProximoId: Int64;
  end;

  TClienteDAO = class(TTabela, IClienteDAO)
    procedure Incluir(AValue : rCliente);
    procedure Alterar(AValue : rCliente);
    procedure Deletar(AId: Int64);
    function Listar( AValue : rCliente) : Lista<rCliente>;
//    function ObterProximoId: Int64;
  private
    function DataSet_Para_Record(ADataSet: TDataSet): rCliente;

  end;

implementation

{ TClienteDAO }

procedure TClienteDAO.Alterar(AValue: rCliente);
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'UPDATE Cliente ' + sLineBreak +
          '   SET NOME = :NOME ' + sLineBreak +
          '     , CPF = :CPF ' + sLineBreak +
          ' WHERE ID = :ID ';

  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add(vSql);
    vQuery.ParamByName('ID').AsLargeInt               := AValue.Id;
    vQuery.ParamByName('NOME').AsString               := AValue.Nome;
    vQuery.ParamByName('CPF').AsString               := AValue.Cpf;
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

procedure TClienteDAO.Deletar(AId: Int64);
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'DELETE FROM CLIENTE ' + sLineBreak +
          '      WHERE ID = :ID';

  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add(vSql);
    vQuery.ParamByName('ID').AsLargeInt :=  AId;
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

procedure TClienteDAO.Incluir(AValue: rCliente);
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'INSERT INTO Cliente( ' + sLineBreak +
          '                      ID ' + sLineBreak +
          '                    , NOME ' + sLineBreak +
          '                    , CPF ' + sLineBreak +
          '                   ) ' + sLineBreak +
          'VALUES( ' +sLineBreak +
          '        :ID ' + sLineBreak +
          '      , :NOME ' + sLineBreak +
          '      , :CPF ' + sLineBreak +
          '      ) ';

  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add(vSql);
    vQuery.ParamByName('ID').AsLargeInt              := AValue.Id;
    vQuery.ParamByName('NOME').AsString              := AValue.Nome;
    vQuery.ParamByName('CPF').AsString           := AValue.Cpf;
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

function TClienteDAO.Listar(AValue: rCliente): Lista<rCliente>;
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'SELECT * ' +sLineBreak +
          '  FROM Cliente ' +sLineBreak +
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

function TClienteDAO.DataSet_Para_Record(ADataSet : TDataSet ) : rCliente;
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

    if existeColuna('CPF') then
      Result.Cpf := vField.AsString;
  end;
end;

end.
