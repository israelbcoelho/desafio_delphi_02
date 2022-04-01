unit ControladorForm;

interface

uses
  Vcl.Forms, uFrmViewProduto, uFrmViewCliente, uFrmPedidoVenda, uFrmViewReceita;

type
  IControladorForm = interface(IInterface)
    procedure ExibirProduto;
    procedure ExibirCliente;
    procedure ExibirPedidoVenda;
    procedure ExibirReceita;
  end;

  TControladorForm = class(TInterfacedObject, IControladorForm)
  public
    procedure ExibirProduto;
    procedure ExibirCliente;
    procedure ExibirPedidoVenda;
    procedure ExibirReceita;
  private
    procedure Exibir(const Classe: TFormClass);
  end;


implementation

procedure TControladorForm.Exibir(const Classe: TFormClass);
begin
  with Classe.Create(Application) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TControladorForm.ExibirCliente;
begin
  Exibir(TFrmViewCliente);
end;

procedure TControladorForm.ExibirPedidoVenda;
begin
  Exibir(TFrmPedidoVenda);
end;


procedure TControladorForm.ExibirProduto;
begin
  Exibir(TFrmViewProduto);
end;

procedure TControladorForm.ExibirReceita;
begin
  Exibir(TFrmViewReceita);
end;

end.
