unit uFrmViewCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBaseDesafio_Delphi_02, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Datasnap.DBClient, Vcl.ExtCtrls, Vcl.Mask;

type
  TEstado =(tePesquisa, teEditar, teIncluir);

  TFrmViewCadastro = class(TFrmBaseDesafio_Delphi_02)
    pgcCadastro: TPageControl;
    tbsPesquisa: TTabSheet;
    tbsDetalhe: TTabSheet;
    DBGrid1: TDBGrid;
    ActionList1: TActionList;
    actNovo: TAction;
    actAlterar: TAction;
    actApagar: TAction;
    actFechar: TAction;
    scbx_Baixo: TScrollBox;
    Button1: TButton;
    btnApagar: TButton;
    btnIncluir: TButton;
    scbx_Topo: TScrollBox;
    btnPesquisar: TButton;
    actPesquisar: TAction;
    ScrollBox1: TScrollBox;
    Button2: TButton;
    Button3: TButton;
    actCancelar: TAction;
    actGravar: TAction;
    btnAlterar: TButton;
    dsDadosPesquisa: TDataSource;
    cdsDadosPesquisa: TClientDataSet;
    procedure actNovoExecute(Sender: TObject);
    procedure actAlterarExecute(Sender: TObject);
    procedure actApagarExecute(Sender: TObject);
    procedure actFecharExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    procedure AplicarEstado(AEstado: TEstado);
    procedure Consultar;
    { Private declarations }
  protected
    procedure Excluir; virtual; abstract;
    procedure Pesquisar; virtual; abstract;
    procedure Gravar; virtual; abstract;
    procedure CarregarDetalhes; virtual; abstract;
    procedure LimparPaginaDetalhe; //virtual; abstract;
  public
    { Public declarations }
  end;

var
  FrmViewCadastro: TFrmViewCadastro;

implementation

{$R *.dfm}

uses Utilitario.Mensagens, udmConexao;

procedure TFrmViewCadastro.actAlterarExecute(Sender: TObject);
begin
  inherited;
  AplicarEstado(teEditar);
  Self.CarregarDetalhes;
end;

procedure TFrmViewCadastro.actApagarExecute(Sender: TObject);
begin
  inherited;
  if Self.cdsDadosPesquisa.IsEmpty then
    msgInformar('Não existem dados para excluir.')
  else
  begin
    if msgQuestionar('Deseja excluir registro') then
    begin
      dmConexao.FDConnection1.StartTransaction;
      try
        Self.Excluir;

        dmConexao.FDConnection1.Commit;
      except
        dmConexao.FDConnection1.Rollback;
        raise;
      end;

      actPesquisar.Execute;
    end;
  end;
end;

procedure TFrmViewCadastro.actCancelarExecute(Sender: TObject);
begin
  inherited;
  Self.AplicarEstado(tePesquisa);
end;

procedure TFrmViewCadastro.actFecharExecute(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TFrmViewCadastro.actGravarExecute(Sender: TObject);
begin
  inherited;

  dmConexao.FDConnection1.StartTransaction;
  try
    Self.Gravar;

    dmConexao.FDConnection1.Commit;
    AplicarEstado(tePesquisa);

  except
    dmConexao.FDConnection1.Rollback;
    raise;
  end;

  AplicarEstado(tePesquisa);
end;

procedure TFrmViewCadastro.actNovoExecute(Sender: TObject);
begin
  inherited;
  AplicarEstado(teIncluir);
end;


procedure TFrmViewCadastro.LimparPaginaDetalhe();
var I : Integer;
begin
  for I := 0 to Self.ComponentCount - 1 do
  begin
    If (Self.Components[I] is TWinControl) then
    begin
      if (TWinControl(Self.Components[I]).Parent = Self.tbsDetalhe) then
      begin
        if (Self.Components[I] is TLabeledEdit) then
          TLabeledEdit(Self.Components[I]).Clear;

        if (Self.Components[I] is TEdit) then
          TEdit(Self.Components[I]).Clear;

        if (Self.Components[I] is TMaskEdit) then
          TMaskEdit(Self.Components[I]).Clear;
      end;
    end;
  end;
end;

procedure TFrmViewCadastro.AplicarEstado(AEstado : TEstado);
begin
  tbsPesquisa.TabVisible := (AEstado = tePesquisa);
  tbsDetalhe.TabVisible  :=  (AEstado <> tePesquisa);

  Self.LimparPaginaDetalhe;
  case AEstado of
    tePesquisa:
    begin
      pgcCadastro.ActivePage := tbsPesquisa;
    end;

    teEditar:
    begin
      pgcCadastro.ActivePage := tbsDetalhe;
    end;

    teIncluir:
    begin
      AplicarEstado(teEditar);
    end;
  end;
end;

procedure TFrmViewCadastro.actPesquisarExecute(Sender: TObject);
begin
  inherited;
  Self.Consultar;
end;

procedure TFrmViewCadastro.Consultar;
begin
  Self.cdsDadosPesquisa.EmptyDataSet;
  Self.Pesquisar;
  Self.cdsDadosPesquisa.First;
end;

procedure TFrmViewCadastro.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if not DBGrid1.DataSource.DataSet.IsEmpty then
  begin
    AplicarEstado(teEditar);
    Self.CarregarDetalhes;
  end;
end;

procedure TFrmViewCadastro.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  nLinha: integer;
begin
  // obtém o número da (linha)
  nLinha := TDBGrid(Sender).DataSource.DataSet.RecNo;

  // verifica se o número da linha é par ou ímpar, aplicando as cores
  if Odd(nLinha) then
    TDBGrid(Sender).Canvas.Brush.Color := clMenu
  else
    TDBGrid(Sender).Canvas.Brush.Color := clMoneyGreen;

  // pinta a linha
  TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFrmViewCadastro.FormCreate(Sender: TObject);
begin
  inherited;
  Self.cdsDadosPesquisa.CreateDataSet;
end;

procedure TFrmViewCadastro.FormShow(Sender: TObject);
begin
  inherited;
  Self.AplicarEstado(tePesquisa);
end;

end.
