unit PedidoVendaItem.DAO;

interface

uses Interfaces, Arrays, FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Param,
  Data.DB, Helper.TFDQuery;

type
  IPedidoVendaItemDAO = interface(ITabela)
    procedure Incluir(AValue : rPedidoVendaItem);
    procedure Deletar(AId: Int64);
    function Listar(AId_PedidoVenda : Int64): Lista<rPedidoVendaItem>;
  end;

  TPedidoVendaItemDAO = class(TTabela, IPedidoVendaItemDAO)
  private
    function DataSet_Para_Record(ADataSet: TDataSet): rPedidoVendaItem;
  public
    procedure Incluir(AValue : rPedidoVendaItem);
    procedure Deletar(AId: Int64);
    function Listar(AId_PedidoVenda : Int64): Lista<rPedidoVendaItem>;
  end;

implementation

{ TPedidoVendaItemDAO }

procedure TPedidoVendaItemDAO.Deletar(AId: Int64);
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'DELETE FROM PEDIDOVENDAITEM ' + sLineBreak +
          '      WHERE ID_PEDIDO = :ID_PEDIDO';

  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add(vSql);
    vQuery.ParamByName('ID_PEDIDO').AsLargeInt :=  AId;
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

procedure TPedidoVendaItemDAO.Incluir(AValue: rPedidoVendaItem);
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'DELETE FROM PEDIDOVENDAITEM ' + sLineBreak +
          '      WHERE ID_PEDIDO = :ID_PEDIDO';

  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Clear;
    vQuery.SQL.Add('INSERT INTO PEDIDOVENDAITEM( ');
    vQuery.SQL.Add('                             ID_PEDIDO  ');
    vQuery.SQL.Add('                           , ID  ');
    vQuery.SQL.Add('                           , ID_PRODUTO ');
    vQuery.SQL.Add('                           , QT ');
    vQuery.SQL.Add('                           , VALORUNITARIO ');
    vQuery.SQL.Add('                            )');
    vQuery.SQL.Add('     VALUES (');
    vQuery.SQL.Add('               :ID_PEDIDO  ');
    vQuery.SQL.Add('             , :ID  ');
    vQuery.SQL.Add('             , :ID_PRODUTO ');
    vQuery.SQL.Add('             , :QT ');
    vQuery.SQL.Add('             , :VALORUNITARIO ');
    vQuery.SQL.Add('            )');
    vQuery.ParamByName('ID_PEDIDO').AsLargeInt     := AValue.ID_PEDIDO;
    vQuery.ParamByName('ID').AsLargeInt  := AValue.Id;
    vQuery.ParamByName('ID_PRODUTO').AsLargeInt    := AValue.ID_PRODUTO;
    vQuery.ParamByName('QT').AsFloat            := AValue.QT;
    vQuery.ParamByName('VALORUNITARIO').AsFloat    := AValue.VALORUNITARIO;
    vQuery.ExecutarSQL;
  finally
    vQuery.Close;
    FreeAndNil(vQuery);
  end;
end;

function TPedidoVendaItemDAO.Listar(AId_PedidoVenda: Int64): Lista<rPedidoVendaItem>;
var vQuery : TFDQuery;
    vSql : string;
begin
  vSql := 'SELECT * ' +sLineBreak +
          '  FROM PEDIDOVENDAITEM ' + sLineBreak +
          ' WHERE 1 = 1 ' + sLineBreak +
          '   AND ID_PEDIDO = :ID_PEDIDO '+ sLineBreak +
          'ORDER BY NUMSEQUENCIA';

  vQuery := Self.NovaQuery;
  try
    vQuery.SQL.Add(vSql);

    vQuery.ParamByName('ID_PEDIDO').AsLargeInt := AId_PedidoVenda;
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

function TPedidoVendaItemDAO.DataSet_Para_Record(ADataSet : TDataSet ) : rPedidoVendaItem;
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
    if existeColuna('ID_PEDIDO') then
      Result.ID_PEDIDO := vField.AsLargeInt;

    if existeColuna('ID') then
      Result.Id := vField.AsLargeInt;

    if existeColuna('ID_PRODUTO') then
      Result.ID_PRODUTO := vField.AsLargeInt;

    if existeColuna('QT') then
      Result.QT := vField.AsFloat;

    if existeColuna('VALORUNITARIO') then
      Result.VALORUNITARIO := vField.AsFloat;
  end;
end;

end.

