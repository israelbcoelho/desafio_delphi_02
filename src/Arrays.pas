unit Arrays;

interface

uses
  Winapi.Windows, System.Rtti, Data.DB, Datasnap.DBClient;

type
  rView_ProdutoReceita = record
    id_receita : Int64;
    id_Produto : Int64;
    nome : string;
    procedure Limpar;
  end;
  
  rReceitaItem = record
    ID : Int64;
    ID_RECEITA : Int64;
    ID_PEDIDOVENDAITEM  : Int64;
    procedure Limpar;
  end;

  rReceita = record
    ID : Int64;
    ID_PEDIDO : Int64;
    STATUS  : string;
    Id_TecnicoAgricola : Int64;
    procedure Limpar;

  end;

  rPedidoVenda = record
    Id : Int64;
    Data : TDateTime;
    ValorTotal : Double;
    Status : string;
    Id_Cliente : Integer;
    procedure Limpar;
  end;

  rPedidoVendaItem = record
    ID_PEDIDO : Int64;
    Id : Int64;
    ID_PRODUTO : Int64;
    QT : Double;
    VALORUNITARIO : Double;

    _ControleEspecial : string;

    procedure Limpar;
  end;

  rProduto = record
    Id : Int64;
    Nome : string;
    Valor : Double;
    ControleEspecial : Boolean;
    procedure Limpar;
  end;

  rCliente = record
    Id : Int64;
    Nome : string;
    Cpf : string;
    procedure Limpar;
  end;

  rTecnicoAgricola = record
    Id   : Integer;
    Nome : string;
    Cpf : string;
    NumeroRegistro : string;
    procedure Limpar;
  end;

  Lista<T> = array of T;

  TTransferencia<T>= class
  public
    class procedure RecordToDataSet(ADataSet: TClientDataSet; ARecord: Lista<T>) overload;
    class procedure RecordToDataSet(ADataSet : TClientDataSet; ARecord : T); overload;
  end;
  
Const
 cTecnicoAgricola : array[0..2] of rTecnicoAgricola =(
                                                       (
                                                         Id:             1;
                                                         Nome:           'TECNICO AGRICOLA 1';
                                                         Cpf:            '00000000001';
                                                         NumeroRegistro: 'NUMERO REGISTRO 1';
                                                       ),
                                                       (
                                                         Id:             2;
                                                         Nome:           'TECNICO AGRICOLA 2';
                                                         Cpf:            '00000000002';
                                                         NumeroRegistro: 'NUMERO REGISTRO 2';
                                                       ),
                                                       (
                                                         Id:             3;
                                                         Nome:           'TECNICO AGRICOLA 3';
                                                         Cpf:            '00000000003';
                                                         NumeroRegistro: 'NUMERO REGISTRO 3';
                                                       )
                                                     );

implementation

procedure rProduto.Limpar;
begin
  ZeroMemory(@Self, SizeOf(Self));
end;

{ rCliente }

procedure rCliente.Limpar;
begin
  ZeroMemory(@Self, SizeOf(Self));
end;

{ rTecnicoAgricola }

procedure rTecnicoAgricola.Limpar;
begin
  ZeroMemory(@Self, SizeOf(Self));
end;

{ rPedidoVenda }

procedure rPedidoVenda.Limpar;
begin
  ZeroMemory(@Self, SizeOf(Self));
end;

{ rPedidoVendaItem }

procedure rPedidoVendaItem.Limpar;
begin
  ZeroMemory(@Self, SizeOf(Self));
end;

{ rReceitaItem }

procedure rReceitaItem.Limpar;
begin
  ZeroMemory(@Self, SizeOf(Self));
end;

{ rReceita }

procedure rReceita.Limpar;
begin
  ZeroMemory(@Self, SizeOf(Self));
end;

{ TTransferencia<T> }
class procedure TTransferencia<T>.RecordToDataSet(ADataSet: TClientDataSet; ARecord: Lista<T>);
var I : Integer;
begin
  for I := Low(ARecord) to High(ARecord) do
    TTransferencia<T>.RecordToDataSet(ADataSet, ARecord[I])
end;

class procedure TTransferencia<T>.RecordToDataSet(ADataSet: TClientDataSet; ARecord: T);
var vRTTIType   : TRTTIType;
    vRttiField: TArray<TRttiField>;
    I         : Integer;
    vName : string;
    vField : TField;
begin
  vRTTIType := TRTTIContext.Create.GetType(TypeInfo(T));
  vRttiField := vRTTIType.GetFields;

  for I := 0 to High(vRttiField) do
  begin
    vName := vRttiField[I].Name;

    vField := ADataSet.FindField(vName);
    if Assigned(vField) then
    begin
      if not (ADataSet.State in dsEditModes) then
        ADataSet.Append;

      vField.Value := vRttiField[I].GetValue(@ARecord).ToString;
    end;
  end;

  if (ADataSet.State in dsEditModes) then
    ADataSet.Post;
end;

{ rView_ProdutoReceita }

procedure rView_ProdutoReceita.Limpar;
begin
  ZeroMemory(@Self, SizeOf(Self));
end;

end.
