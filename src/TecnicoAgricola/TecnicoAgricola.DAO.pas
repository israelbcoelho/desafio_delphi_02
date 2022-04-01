unit TecnicoAgricola.DAO;

interface

uses
  Interfaces, Arrays, FireDAC.Comp.Client, System.SysUtils, System.StrUtils, FireDAC.Stan.Param,
  Data.DB, Winapi.Windows, FireDAC.DApt, Helper.TFDQuery;

type
  ITecnicoAgricolaDAO = interface(ITabela)
    procedure Incluir(AValue : rTecnicoAgricola);
    procedure Alterar(AValue : rTecnicoAgricola);
    procedure Deletar(AId: Int64);
    function Listar( AValue : rTecnicoAgricola) : Lista<rTecnicoAgricola>;
  end;

  TTecnicoAgricolaDAO = class(TTabela, ITecnicoAgricolaDAO)
    procedure Incluir(AValue : rTecnicoAgricola);
    procedure Alterar(AValue : rTecnicoAgricola);
    procedure Deletar(AId: Int64);
    function Listar( AValue : rTecnicoAgricola) : Lista<rTecnicoAgricola>;
  private
    function DataSet_Para_Record(ADataSet: TDataSet): rTecnicoAgricola;

  end;

implementation

{ TTecnicoAgricolaDAO }

procedure TTecnicoAgricolaDAO.Alterar(AValue: rTecnicoAgricola);
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'UPDATE TECNICOAGRICOLA ' + sLineBreak +
          '   SET NOME = :NOME ' + sLineBreak +
          '     , CPF = :CPF ' + sLineBreak +
          '     , NUMEROREGISTRO = :NUMEROREGISTRO ' + sLineBreak +
          ' WHERE ID = :ID ';

  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add(vSql);
    vQuery.ParamByName('ID').AsLargeInt               := AValue.Id;
    vQuery.ParamByName('NOME').AsString               := AValue.Nome;
    vQuery.ParamByName('CPF').AsString               := AValue.Cpf;
    vQuery.ParamByName('NUMEROREGISTRO').AsString               := AValue.NumeroRegistro;
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

procedure TTecnicoAgricolaDAO.Deletar(AId: Int64);
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'DELETE FROM TECNICOAGRICOLA ' + sLineBreak +
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

procedure TTecnicoAgricolaDAO.Incluir(AValue: rTecnicoAgricola);
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'INSERT INTO TECNICOAGRICOLA( ' + sLineBreak +
          '                      ID ' + sLineBreak +
          '                    , NOME ' + sLineBreak +
          '                    , CPF ' + sLineBreak +
          '                    , NUMEROREGISTRO ' + sLineBreak +
          '                   ) ' + sLineBreak +
          'VALUES( ' +sLineBreak +
          '        :ID ' + sLineBreak +
          '      , :NOME ' + sLineBreak +
          '      , :CPF ' + sLineBreak +
          '      , :NUMEROREGISTRO ' + sLineBreak +
          '      ) ';

  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add(vSql);
    vQuery.ParamByName('ID').AsLargeInt              := AValue.Id;
    vQuery.ParamByName('NOME').AsString              := AValue.Nome;
    vQuery.ParamByName('CPF').AsString           := AValue.CPF;
    vQuery.ParamByName('NUMEROREGISTRO').AsString           := AValue.NumeroRegistro;
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

function TTecnicoAgricolaDAO.Listar(AValue: rTecnicoAgricola): Lista<rTecnicoAgricola>;
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'SELECT * ' +sLineBreak +
          '  FROM TECNICOAGRICOLA ' +sLineBreak +
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

function TTecnicoAgricolaDAO.DataSet_Para_Record(ADataSet : TDataSet ) : rTecnicoAgricola;
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

    if existeColuna('NUMEROREGISTRO') then
      Result.NumeroRegistro := vField.AsString;
  end;
end;

end.
