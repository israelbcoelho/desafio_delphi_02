unit uFrmViewProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmViewCadastro, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Produto.Controller, Datasnap.DBClient, Arrays, Vcl.ExtCtrls;

type
  TFrmViewProduto = class(TFrmViewCadastro)
    cdsDadosPesquisaID: TLargeintField;
    edtPesquisaNome: TLabeledEdit;
    cdsDadosPesquisaNOME: TStringField;
    edtNome: TLabeledEdit;
    edtId: TLabeledEdit;
    edtValor: TLabeledEdit;
    edtControleEspecial: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    ProdutoController : IProdutoController;
  protected
    procedure Excluir; override;
    procedure Pesquisar; override;
    procedure Gravar; override;
    procedure CarregarDetalhes; override;


    { Private declarations }
  public
    { Public declarations }

  end;

var
  FrmViewProduto: TFrmViewProduto;

implementation

{$R *.dfm}

uses udmConexao;

{ TFrmViewProduto }

procedure TFrmViewProduto.CarregarDetalhes;
var vProduto : rProduto;
begin
  inherited;
  vProduto := ProdutoController.ObterRegistro(cdsDadosPesquisaID.AsLargeint);

  Self.edtId.Text                   := vProduto.Id.ToString;
  Self.edtNome.Text                 := vProduto.Nome;
  Self.edtControleEspecial.Checked  := vProduto.ControleEspecial;
  Self.edtValor.Text                := vProduto.Valor.ToString;
end;

procedure TFrmViewProduto.Excluir;
begin
  inherited;
  ProdutoController.Deletar(cdsDadosPesquisaID.AsLargeint);
end;

procedure TFrmViewProduto.FormCreate(Sender: TObject);
begin
  inherited;
  ProdutoController := TProdutoController.Create(dmConexao.FDConnection1);
end;

procedure TFrmViewProduto.Gravar;
var vProduto : rProduto;
begin
  inherited;
  vProduto.Limpar;

  vProduto.Id   := StrToInt64Def(edtId.Text, 0);
  vProduto.Nome := edtNome.Text;
  vProduto.ControleEspecial := Self.edtControleEspecial.Checked;
  vProduto.Valor := StrToFloatDef(Self.edtValor.Text,0);

  ProdutoController.Gravar(vProduto);
end;

procedure TFrmViewProduto.Pesquisar;
var vLista : Lista<rProduto>;
begin
  inherited;

  vLista := ProdutoController.Listar(edtPesquisaNome.Text);
  TTransferencia<rProduto>.RecordToDataSet(cdsDadosPesquisa, vLista);
end;

end.
