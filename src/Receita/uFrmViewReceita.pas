unit uFrmViewReceita;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmViewCadastro, Data.DB,
  Datasnap.DBClient, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Receita.Controller, Arrays, PedidoVenda.Controller,
  System.StrUtils, ReceitaItem.Controller, PedidoVendaItem.Controller, View_ProdutoReceita.DAO,
  Vcl.ExtCtrls, TecnicoAgricola.Controller;

type
  TFrmViewReceita = class(TFrmViewCadastro)
    cdsDadosPesquisaID: TLargeintField;
    cdsDadosPesquisaID_PEDIDO: TLargeintField;
    cdsDadosPesquisaSTATUS: TStringField;
    cdsDadosPesquisaDESCRICAOSTATUS: TStringField;
    cbStatus: TComboBox;
    dsDadosItem: TDataSource;
    cdsDadosItem: TClientDataSet;
    cdsDadosItemID_PRODUTO: TLargeintField;
    cdsDadosItemNOME: TStringField;
    cdsDadosItemID_RECEITA: TLargeintField;
    edtIdReceita: TLabeledEdit;
    edtIdPedido: TLabeledEdit;
    DBGrid2: TDBGrid;
    edtIdTecnico: TLabeledEdit;
    edtNomeTecnico: TLabeledEdit;
    cdsDadosPesquisaID_TECNICOAGRICOLA: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure cdsDadosPesquisaBeforePost(DataSet: TDataSet);
    procedure edtIdTecnicoExit(Sender: TObject);
    procedure actAlterarExecute(Sender: TObject);
  private
    ReceiraController : IReceitaController;
  protected
    procedure Pesquisar; override;
    procedure CarregarDetalhes; override;
    procedure Gravar; override;
  public
  end;

var
  FrmViewReceita: TFrmViewReceita;

implementation

{$R *.dfm}

uses udmConexao,Utilitario.Mensagens, Constantes;

procedure TFrmViewReceita.actAlterarExecute(Sender: TObject);
begin
  if (Self.cdsDadosPesquisaSTATUS.AsString = cStatusPedidoConcluido) then
  begin
    msgInformar('Receita já assinada!');
  end
  else
  begin
    inherited;
  end;
end;

procedure TFrmViewReceita.CarregarDetalhes;
var  vReceitaItem : Lista<rView_ProdutoReceita>;
    vView_ProdutoReceitaDAO : IView_ProdutoReceitaDAO;
begin
  inherited;
  edtIdReceita.Text := cdsDadosPesquisaID.AsString;
  edtIdPedido.Text := cdsDadosPesquisaID_PEDIDO.AsString;

  vView_ProdutoReceitaDAO := TView_ProdutoReceitaDAO.Create(dmConexao.FDConnection1);

  vReceitaItem := vView_ProdutoReceitaDAO.Listar(cdsDadosPesquisaID.AsLargeInt);
  TTransferencia<rView_ProdutoReceita>.RecordToDataSet(cdsDadosItem, vReceitaItem);
end;

procedure TFrmViewReceita.cdsDadosPesquisaBeforePost(DataSet: TDataSet);
begin
  inherited;
  cdsDadosPesquisaDESCRICAOSTATUS.AsString      := IfThen(cdsDadosPesquisaSTATUS.AsString = 'C', 'Concluído', 'Aguardando Receita');
end;

procedure TFrmViewReceita.DBGrid1DblClick(Sender: TObject);
begin
//  inherited;
  actAlterar.Execute;
end;

procedure TFrmViewReceita.edtIdTecnicoExit(Sender: TObject);
var vTecnicoAgricolaController : ITecnicoAgricolaController;
    vTecnicoAgricola : rTecnicoAgricola;
    vValorInformado : Boolean;
begin
  inherited;
  vValorInformado := StrToInt64Def(edtIdTecnico.Text, 0) > 0;
  if vValorInformado then
  begin
    vTecnicoAgricolaController := TTecnicoAgricolaController.Create(dmConexao.FDConnection1);
    vTecnicoAgricola := vTecnicoAgricolaController.ObterRegistro(StrToInt64(edtIdTecnico.Text));

    vValorInformado := vTecnicoAgricola.Id > 0;
    if vValorInformado then
    begin
      edtIdTecnico.Text := vTecnicoAgricola.Id.ToString;
      edtNomeTecnico.Text := vTecnicoAgricola.Nome;
    end;
  end;

  if not vValorInformado then
  begin
    edtIdTecnico.Clear;
    edtNomeTecnico.Clear;
  end;
end;

procedure TFrmViewReceita.FormCreate(Sender: TObject);
begin
  inherited;
  ReceiraController := TReceitaController.Create(dmConexao.FDConnection1);

  cdsDadosItem.CreateDataSet;
end;

procedure TFrmViewReceita.Gravar;
var vPedidoVendaController : IPedidoVendaController;
begin
  inherited;
  if msgQuestionar('Confirma assitura da receita?') then
  begin
     vPedidoVendaController := TPedidoVendaController.Create(dmConexao.FDConnection1);
    dmConexao.FDConnection1.StartTransaction;
    try
      vPedidoVendaController.MarcarComoConcluido(StrToInt64(edtIdPedido.Text));
      ReceiraController.MarcarComoConcluido(StrToInt64(edtIdReceita.Text), StrToInt64Def(edtIdTecnico.Text, 0));

      dmConexao.FDConnection1.Commit;

      msgInformar('Process concluído com sucesso!');
    except
      dmConexao.FDConnection1.Rollback;
      raise;
    end;
  end;
end;

procedure TFrmViewReceita.Pesquisar;
var vLista : Lista<rReceita>;
    vStatus : string;
begin
  inherited;
  cdsDadosItem.EmptyDataSet;

  vStatus := EmptyStr;
  case cbStatus.ItemIndex of
    0: vStatus := cStatusPedidoConcluido;
    1: vStatus := cStatusPedidoAguardando;
  end;

  vLista := ReceiraController.Listar(vStatus);
  TTransferencia<rReceita>.RecordToDataSet(cdsDadosPesquisa, vLista);
end;

end.
