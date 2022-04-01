program prjDesafio_Delphi_02;

uses
  Vcl.Forms,
  uFrmDesafio_Delphi_02 in 'uFrmDesafio_Delphi_02.pas' {FrmDesafio_Delphi_02},
  udmConexao in 'udmConexao.pas' {dmConexao: TDataModule},
  Helper.TFDConnection in 'helper\Helper.TFDConnection.pas',
  Helper.TStringList in 'helper\Helper.TStringList.pas',
  uFrmBaseDesafio_Delphi_02 in 'uFrmBaseDesafio_Delphi_02.pas' {FrmBaseDesafio_Delphi_02},
  uFrmViewCadastro in 'uFrmViewCadastro.pas' {FrmViewCadastro},
  Utilitario.Mensagens in 'Bibliotecas\Utilitario.Mensagens.pas',
  Interfaces in 'Interfaces.pas',
  Arrays in 'Arrays.pas',
  Produto.DAO in 'Produto\Produto.DAO.pas',
  Produto.Controller in 'Produto\Produto.Controller.pas',
  uFrmViewProduto in 'Produto\uFrmViewProduto.pas' {FrmViewProduto},
  Utilitario.Strings in 'Bibliotecas\Utilitario.Strings.pas',
  uFrmViewCliente in 'Cliente\uFrmViewCliente.pas' {FrmViewCliente},
  Cliente.Controller in 'Cliente\Cliente.Controller.pas',
  Cliente.DAO in 'Cliente\Cliente.DAO.pas',
  TecnicoAgricola.Controller in 'TecnicoAgricola\TecnicoAgricola.Controller.pas',
  TecnicoAgricola.DAO in 'TecnicoAgricola\TecnicoAgricola.DAO.pas',
  uFrmPedidoVenda in 'Pedido\uFrmPedidoVenda.pas' {FrmPedidoVenda},
  Pedido.Controller in 'Pedido\Pedido.Controller.pas',
  PedidoVenda.Controller in 'PedidoVenda\PedidoVenda.Controller.pas',
  PedidoVenda.DAO in 'PedidoVenda\PedidoVenda.DAO.pas',
  PedidoVendaItem.Controller in 'PedidoVendaItem\PedidoVendaItem.Controller.pas',
  PedidoVendaItem.DAO in 'PedidoVendaItem\PedidoVendaItem.DAO.pas',
  ControladorForm in 'ControladorForm.pas',
  Helper.TFDQuery in 'helper\Helper.TFDQuery.pas',
  uFrmViewDetalheItem in 'Pedido\uFrmViewDetalheItem.pas' {FrmViewDetalheItem},
  Exceptions in 'Exceptions.pas',
  Receita.Controller in 'Receita\Receita.Controller.pas',
  Receita.DAO in 'Receita\Receita.DAO.pas',
  ReceitaItem.Controller in 'ReceitaItem\ReceitaItem.Controller.pas',
  ReceitaItem.DAO in 'ReceitaItem\ReceitaItem.DAO.pas',
  Constantes in 'Constantes.pas',
  uFrmViewReceita in 'Receita\uFrmViewReceita.pas' {FrmViewReceita},
  View_ProdutoReceita.Controller in 'View_ProdutoReceita\View_ProdutoReceita.Controller.pas',
  View_ProdutoReceita.DAO in 'View_ProdutoReceita\View_ProdutoReceita.DAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TFrmDesafio_Delphi_02, FrmDesafio_Delphi_02);
  Application.Run;
end.
