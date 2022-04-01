unit PedidoVenda.DAO;

interface

uses Interfaces, Arrays, FireDAC.Comp.Client, System.SysUtils, System.StrUtils, FireDAC.Stan.Param,
  Data.DB, Winapi.Windows, FireDAC.DApt, Helper.TFDQuery;

type
  IPedidoVendaDAO = interface(ITabela)
    procedure Deletar(AId: Int64);
    function Listar(AId : Int64): Lista<rPedidoVenda>;
    procedure Incluir(AValor: rPedidoVenda);
    procedure MudarStatus(AId : Int64; AStatus : string);
  end;

  TPedidoVendaDAO = class(TTabela, IPedidoVendaDAO)
  private
    function DataSet_Para_Record(ADataSet: TDataSet): rPedidoVenda;

  public
    procedure Deletar(AId: Int64);
    function Listar(AId : Int64): Lista<rPedidoVenda>;
    procedure Incluir(AValor: rPedidoVenda);
    procedure MudarStatus(AId : Int64; AStatus : string);
  end;

implementation

procedure TPedidoVendaDAO.Incluir(AValor : rPedidoVenda);
var vQuery : TFDQuery;
begin
  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add('INSERT INTO PEDIDOVENDA ( ');
    vQuery.SQL.Add('                          ID  ');
    vQuery.SQL.Add('                        , DATA  ');
    vQuery.SQL.Add('                        , VALORTOTAL  ');
    vQuery.SQL.Add('                        , STATUS ');
    vQuery.SQL.Add('                        , ID_CLIENTE ');
    vQuery.SQL.Add('                        ) ');
    vQuery.SQL.Add('VALUES ( ');
    vQuery.SQL.Add('         :ID  ');
    vQuery.SQL.Add('       , :DATA  ');
    vQuery.SQL.Add('       , :VALORTOTAL  ');
    vQuery.SQL.Add('       , :STATUS ');
    vQuery.SQL.Add('       , :ID_CLIENTE ');
    vQuery.SQL.Add('       ) ');

    vQuery.ParamByName('ID').AsLargeInt  :=  AValor.Id;
    vQuery.ParamByName('DATA').AsDateTime :=  AValor.Data;
    vQuery.ParamByName('VALORTOTAL').AsFloat :=  AValor.ValorTotal;
    vQuery.ParamByName('STATUS').AsString :=  AValor.Status;
    vQuery.ParamByName('ID_CLIENTE').AsLargeInt :=  AValor.Id_Cliente;

    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

procedure TPedidoVendaDAO.Deletar(AId: Int64);
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'DELETE FROM PEDIDOVENDA ' + sLineBreak +
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

function TPedidoVendaDAO.Listar(AId : Int64): Lista<rPedidoVenda>;
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'SELECT * ' +sLineBreak +
          '  FROM PEDIDOVENDA ' +sLineBreak +
          ' WHERE 1 = 1 ';

  if (AId > 0) then
  begin
    vSql := vSql + sLineBreak +
            '   AND ID = :ID ';
  end;

  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Add(vSql);

    if (AId > 0) then
      vQuery.ParamByName('ID').AsLargeInt := AId;

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

procedure TPedidoVendaDAO.MudarStatus(AId : Int64; AStatus: string);
var vQuery : TFDQuery;
begin
  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add('UPDATE PEDIDOVENDA');
    vQuery.SQL.Add('   SET STATUS = :STATUS');
    vQuery.SQL.Add(' WHERE ID = :ID');

    vQuery.ParamByName('ID').AsLargeInt := AId;
    vQuery.ParamByName('STATUS').AsString := AStatus;
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

function TPedidoVendaDAO.DataSet_Para_Record(ADataSet : TDataSet ) : rPedidoVenda;
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

    if existeColuna('DATA') then
      Result.Data := vField.AsDateTime;

    if existeColuna('VALORTOTAL') then
      Result.ValorTotal := vField.AsFloat;

    if existeColuna('STATUS') then
      Result.Status := vField.AsString;
  end;
end;

end.
