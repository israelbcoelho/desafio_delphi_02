unit uFrmDesafio_Delphi_02;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Produto.DAO, Vcl.Menus, ControladorForm,
  Vcl.Buttons, System.Actions, Vcl.ActnList, dxGDIPlusClasses, Vcl.ExtCtrls;

type
  TFrmDesafio_Delphi_02 = class(TForm)
    scbxEsqueda: TScrollBox;
    scbx_topo: TScrollBox;
    scbx_Centro: TScrollBox;
    btnReceita: TSpeedButton;
    btnPedido: TSpeedButton;
    btnProduto: TSpeedButton;
    btnCliente: TSpeedButton;
    ActionList1: TActionList;
    actCliente: TAction;
    actProduto: TAction;
    actPedido: TAction;
    actReceita: TAction;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure actClienteExecute(Sender: TObject);
    procedure actProdutoExecute(Sender: TObject);
    procedure actReceitaExecute(Sender: TObject);
    procedure actPedidoExecute(Sender: TObject);
  private
    { Private declarations }
    ControladorForm : IControladorForm;
  public
    { Public declarations }
  end;

var
  FrmDesafio_Delphi_02: TFrmDesafio_Delphi_02;

implementation

{$R *.dfm}

procedure TFrmDesafio_Delphi_02.actClienteExecute(Sender: TObject);
begin
  ControladorForm.ExibirCliente;
end;

procedure TFrmDesafio_Delphi_02.actPedidoExecute(Sender: TObject);
begin
  ControladorForm.ExibirPedidoVenda;
end;

procedure TFrmDesafio_Delphi_02.actProdutoExecute(Sender: TObject);
begin
  ControladorForm.ExibirProduto;
end;

procedure TFrmDesafio_Delphi_02.actReceitaExecute(Sender: TObject);
begin
  ControladorForm.ExibirReceita;
end;

procedure TFrmDesafio_Delphi_02.FormCreate(Sender: TObject);
begin
  ControladorForm := TControladorForm.Create;
end;

end.
