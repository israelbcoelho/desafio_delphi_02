unit uFrmViewDetalheItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBaseDesafio_Delphi_02, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TFrmViewDetalheItem = class(TFrmBaseDesafio_Delphi_02)
    btnConfirmar: TButton;
    btnCancelar: TButton;
    edtIdProduto: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtQuantidade: TLabeledEdit;
    edtVlrUnitario: TLabeledEdit;
    edtVlSubtotal: TLabeledEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
  private
    { Private declarations }
  public
    class function Exibir(
                           AId_Produto : Int64;
                           ANome : string;
                           AVlrUnitario : Double
                         ) : Int64;
  end;

var
  FrmViewDetalheItem: TFrmViewDetalheItem;

implementation

{$R *.dfm}

procedure TFrmViewDetalheItem.btnCancelarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TFrmViewDetalheItem.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TFrmViewDetalheItem.edtQuantidadeExit(Sender: TObject);
var vVlSubTotal : Double;
begin
  inherited;
  vVlSubTotal := StrToInt64Def(edtQuantidade.Text, 1) * StrToFloat(edtVlrUnitario.Text);
  edtVlSubtotal.Text := FormatFloat('###,##0.00', vVlSubTotal);
end;

class function TFrmViewDetalheItem.Exibir(AId_Produto: Int64; ANome: string;  AVlrUnitario: Double): Int64;
begin
  Result := 0;
  Application.CreateForm(TFrmViewDetalheItem, FrmViewDetalheItem);
  try
    FrmViewDetalheItem.edtIdProduto.Text    := AId_Produto.ToString;
    FrmViewDetalheItem.edtNome.Text         := ANome;
    FrmViewDetalheItem.edtQuantidade.Text   := '1';
    FrmViewDetalheItem.edtVlrUnitario.Text  := FloatToStr(AVlrUnitario);
    FrmViewDetalheItem.edtQuantidadeExit(FrmViewDetalheItem.edtQuantidade);

    if (FrmViewDetalheItem.ShowModal = mrOk) then
      Result := StrToInt64Def(FrmViewDetalheItem.edtQuantidade.Text, 1)
  finally
    FreeAndNil(FrmViewDetalheItem);
  end;
end;

end.
