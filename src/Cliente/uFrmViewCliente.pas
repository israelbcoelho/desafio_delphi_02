unit uFrmViewCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmViewCadastro, Data.DB,
  Datasnap.DBClient, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Arrays, Vcl.ExtCtrls, cliente.Controller, Vcl.Mask;

type
  TFrmViewCliente = class(TFrmViewCadastro)
    edtId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtPesquisaNome: TLabeledEdit;
    cdsDadosPesquisaID: TLargeintField;
    cdsDadosPesquisaNOME: TStringField;
    edtCpfCnpj: TMaskEdit;
    lblCPF: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    ClienteController : IClienteController;
  protected
    procedure Gravar; override;
    procedure Pesquisar; override;
    procedure Excluir; override;
    procedure CarregarDetalhes; override;



    { Private declarations }
  public
    { Public declarations }

  end;

var
  FrmViewCliente: TFrmViewCliente;

implementation

{$R *.dfm}

uses udmConexao;

{ TFrmViewCliente }

procedure TFrmViewCliente.CarregarDetalhes;
var vCliente : rCliente;
begin
  inherited;
  vCliente := ClienteController.ObterRegistro(cdsDadosPesquisaID.AsLargeint);

  Self.edtId.Text   := vCliente.Id.ToString;
  Self.edtNome.Text := vCliente.Nome;
  Self.edtCpfCnpj.Text := vCliente.Cpf;
end;

procedure TFrmViewCliente.Excluir;
begin
  inherited;
  ClienteController.Deletar(cdsDadosPesquisaID.AsLargeint);
end;

procedure TFrmViewCliente.FormCreate(Sender: TObject);
begin
  inherited;
  ClienteController := TClienteController.Create(dmConexao.FDConnection1);
end;

procedure TFrmViewCliente.Gravar;
var vCliente : rCliente;
begin
  inherited;
  vCliente.Limpar;

  vCliente.Id   := StrToInt64Def(edtId.Text, 0);
  vCliente.Nome := edtNome.Text;
  vCliente.Cpf := Self.edtCpfCnpj.Text;

  ClienteController.Gravar(vCliente);
end;

procedure TFrmViewCliente.Pesquisar;
var vLista : Lista<rCliente>;
begin
  inherited;
//  Self.cdsDadosPesquisa.EmptyDataSet;

  SetLength(vLista, 1);
  vLista := ClienteController.Listar(edtPesquisaNome.Text);
  TTransferencia<rCliente>.RecordToDataSet(cdsDadosPesquisa, vLista);
//  for I := Low(vLista) to High(vLista) do
//  begin
//    Self.cdsDadosPesquisa.Append;
//    Self.cdsDadosPesquisaID.AsLargeInt := vLista[I].Id;
//    Self.cdsDadosPesquisaNOME.AsString := vLista[I].Nome;
//    Self.cdsDadosPesquisa.Post;
//  end;

end;

end.
