unit uFrmPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmViewCadastro, Data.DB,
  Datasnap.DBClient, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Pedido.Controller, Vcl.ExtCtrls, System.StrUtils, Cliente.Controller, TecnicoAgricola.Controller;

type
  TFrmPedidoVenda = class(TFrmViewCadastro)
    cdsDadosPesquisaID: TLargeintField;
    edtId: TLabeledEdit;
    edtCliente: TLabeledEdit;
    edtIdCliente: TLabeledEdit;
    PageControl1: TPageControl;
    tbsItens: TTabSheet;
    DBGrid2: TDBGrid;
    tbsTabelaProduto: TTabSheet;
    DBGrid3: TDBGrid;
    btnProdutoPesquisar: TButton;
    dsPedidoVendaItem: TDataSource;
    cdsPedidoVendaItem: TClientDataSet;
    cdsProduto: TClientDataSet;
    cdsProdutoID: TLargeintField;
    cdsProdutoNOME: TStringField;
    cdsProdutoVALOR: TFloatField;
    dsProduto: TDataSource;
    cdsDadosPesquisaDATA: TDateTimeField;
    cdsDadosPesquisaVALORTOTAL: TFloatField;
    cdsPedidoVendaItemNUMSEQUENCIA: TLargeintField;
    cdsPedidoVendaItemID_PRODUTO: TLargeintField;
    cdsPedidoVendaItemQT: TFloatField;
    cdsPedidoVendaItemVALORUNITARIO: TFloatField;
    cdsPedidoVendaItemNOME: TStringField;
    cdsPedidoVendaItemVLSUBTOTAL: TFloatField;
    edtData: TDateTimePicker;
    edtVlrTotal: TLabeledEdit;
    edtQtdItens: TLabeledEdit;
    cdsPedidoVendaItemVALORTOTAL: TAggregateField;
    cdsPedidoVendaItemCONTROLEESPECIAL: TStringField;
    cdsProdutoCONTROLEESPECIAL: TStringField;
    cdsDadosPesquisaSTATUS: TStringField;
    cdsDadosPesquisaSTATUS_DESCRICAO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnProdutoPesquisarClick(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure cdsPedidoVendaItemCalcFields(DataSet: TDataSet);
    procedure DBGrid3DblClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure actAlterarExecute(Sender: TObject);
    procedure cdsPedidoVendaItemAfterPost(DataSet: TDataSet);
    procedure edtIdClienteExit(Sender: TObject);
    procedure cdsDadosPesquisaBeforePost(DataSet: TDataSet);
  private
    PedidoController : IPedidoController;
  protected
    procedure Pesquisar; override;
    procedure Excluir; override;
    procedure Gravar; override;
    procedure CarregarDetalhes; override;
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FrmPedidoVenda: TFrmPedidoVenda;

implementation

uses udmConexao, Arrays, uFrmViewDetalheItem;

{$R *.dfm}

procedure TFrmPedidoVenda.actAlterarExecute(Sender: TObject);
begin
//  inherited;
end;

procedure TFrmPedidoVenda.actNovoExecute(Sender: TObject);
begin
  inherited;
  edtId.Text   := Self.PedidoController.PedidoVenda.Proximo_Id('PEDIDOVENDA').ToString;
  edtData.Date := Date;
  edtQtdItens.Text := '0';
  edtVlrTotal.Text := '0,00';
  Self.cdsPedidoVendaItem.EmptyDataSet;
  Self.cdsProduto.EmptyDataSet;
end;

procedure TFrmPedidoVenda.btnProdutoPesquisarClick(Sender: TObject);
var vLista : lista<rProduto>;
    I : Integer;
begin
  inherited;
  PedidoController := TPedidoController.Create(dmConexao.FDConnection1);
  vLista := PedidoController.Produto.Listar(EmptyStr);

  for I := Low(vLista) to High(vLista) do
  begin
    Self.cdsProduto.Append;
    Self.cdsProdutoID.AsLargeInt := vLista[I].Id;
    Self.cdsProdutoNOME.AsString := vLista[I].Nome;
    Self.cdsProdutoVALOR.AsFloat := vLista[I].Valor;
    Self.cdsProdutoCONTROLEESPECIAL.AsString := IfThen(vLista[I].ControleEspecial, 'S', 'N');
    Self.cdsProduto.Post;
  end;
end;

procedure TFrmPedidoVenda.CarregarDetalhes;
begin
end;

procedure TFrmPedidoVenda.cdsDadosPesquisaBeforePost(DataSet: TDataSet);
begin
  inherited;
  cdsDadosPesquisaSTATUS_DESCRICAO.AsString      := IfThen(cdsDadosPesquisaSTATUS.AsString = 'C', 'Concluído', 'Aguardando Receita');
end;

procedure TFrmPedidoVenda.cdsPedidoVendaItemAfterPost(DataSet: TDataSet);
begin
  inherited;
  Self.edtVlrTotal.Text := FormatFloat('#####0.00', StrToFloat(cdsPedidoVendaItemVALORTOTAL.AsString));
  Self.edtQtdItens.Text := FormatFloat('###,##0', cdsPedidoVendaItem.RecordCount);
end;

procedure TFrmPedidoVenda.cdsPedidoVendaItemCalcFields(DataSet: TDataSet);
begin
  inherited;
  cdsPedidoVendaItemVLSUBTOTAL.AsFloat := cdsPedidoVendaItemQT.AsFloat * cdsPedidoVendaItemVALORUNITARIO.AsFloat;
end;

procedure TFrmPedidoVenda.DBGrid1DblClick(Sender: TObject);
begin
  //inherited;
end;

procedure TFrmPedidoVenda.DBGrid3DblClick(Sender: TObject);
var vQuantidade : Int64;
begin
  inherited;
  if not cdsProduto.IsEmpty then
  begin
    vQuantidade := TFrmViewDetalheItem.Exibir(
                                              cdsProdutoID.AsLargeInt,
                                              cdsProdutoNOME.AsString,
                                              cdsProdutoVALOR.AsFloat
                                             );

    if ( vQuantidade > 0 ) then
    begin
      cdsPedidoVendaItem.Append;
      cdsPedidoVendaItemID_PRODUTO.AsLargeInt := cdsProdutoID.AsLargeInt;
      cdsPedidoVendaItemNOME.AsString         := cdsProdutoNOME.AsString;
      cdsPedidoVendaItemCONTROLEESPECIAL.AsString := cdsProdutoCONTROLEESPECIAL.AsString;
      cdsPedidoVendaItemQT.AsLargeInt         := vQuantidade;
      cdsPedidoVendaItemVALORUNITARIO.AsFloat := cdsProdutoVALOR.AsFloat;
      cdsPedidoVendaItemNUMSEQUENCIA.AsFloat  := cdsPedidoVendaItem.RecNo;
      cdsPedidoVendaItem.Post;
    end;
  end;
end;

procedure TFrmPedidoVenda.edtIdClienteExit(Sender: TObject);
var vCleinteController : IClienteController;
    vCliente : rCliente;
    vValorInformado : Boolean;
begin
  inherited;
  vValorInformado := StrToInt64Def(edtIdCliente.Text, 0) > 0;
  if vValorInformado then
  begin
    vCleinteController := TClienteController.Create(dmConexao.FDConnection1);
    vCliente := vCleinteController.ObterRegistro(StrToInt64(edtIdCliente.Text));

    vValorInformado := vCliente.Id > 0;
    if vValorInformado then
    begin
      edtIdCliente.Text := vCliente.Id.ToString;
      edtCliente.Text := vCliente.Nome;
    end;
  end;

  if not vValorInformado then
  begin
    edtIdCliente.Clear;
    edtCliente.Clear;
  end;
end;

procedure TFrmPedidoVenda.Excluir;
begin
  inherited;
end;

procedure TFrmPedidoVenda.FormCreate(Sender: TObject);
begin
  inherited;
  Self.cdsProduto.CreateDataSet;
  Self.cdsPedidoVendaItem.CreateDataSet;
  PedidoController := TPedidoController.Create(dmConexao.FDConnection1);
end;

procedure TFrmPedidoVenda.Gravar;
var vPedidoVenda: rPedidoVenda;
    vPedidoVendaItem: Lista<rPedidoVendaItem>;
begin
  inherited;
  vPedidoVenda.Limpar;
  vPedidoVenda.Id         := StrToInt64Def(edtId.Text, 0);
  vPedidoVenda.Data       := edtData.Date;
  vPedidoVenda.Status     := 'C';
  vPedidoVenda.ValorTotal := StrToFloat(edtVlrTotal.Text);
  vPedidoVenda.Id_Cliente := StrToInt64Def(edtIdCliente.Text, 0);

  SetLength( vPedidoVendaItem, Self.cdsPedidoVendaItem.RecordCount);
  Self.cdsPedidoVendaItem.First;
  while not Self.cdsPedidoVendaItem.Eof do
  begin
    vPedidoVendaItem[Self.cdsPedidoVendaItem.RecNo -1].ID_PEDIDO  := vPedidoVenda.Id;
    vPedidoVendaItem[Self.cdsPedidoVendaItem.RecNo -1].ID_PRODUTO := Self.cdsPedidoVendaItemID_PRODUTO.AsLargeInt;
    vPedidoVendaItem[Self.cdsPedidoVendaItem.RecNo -1].QT := Self.cdsPedidoVendaItemQT.AsFloat;
    vPedidoVendaItem[Self.cdsPedidoVendaItem.RecNo -1].VALORUNITARIO := Self.cdsPedidoVendaItemVALORUNITARIO.AsFloat;
    vPedidoVendaItem[Self.cdsPedidoVendaItem.RecNo -1]._ControleEspecial := Self.cdsPedidoVendaItemCONTROLEESPECIAL.AsString;

    Self.cdsPedidoVendaItem.Next;
  end;
  
  PedidoController.Gravar(vPedidoVenda, vPedidoVendaItem);
end;

procedure TFrmPedidoVenda.Pesquisar;
var vLista : lista<rPedidoVenda>;
begin
  inherited;
  vLista := PedidoController.PedidoVenda.Listar(0);
   TTransferencia<rPedidoVenda>.RecordToDataSet(cdsDadosPesquisa, vLista);
end;

end.
