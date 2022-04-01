inherited FrmPedidoVenda: TFrmPedidoVenda
  Caption = 'FrmPedidoVenda'
  ClientHeight = 516
  ClientWidth = 924
  ExplicitWidth = 940
  ExplicitHeight = 555
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcCadastro: TPageControl
    Width = 924
    Height = 516
    ActivePage = tbsDetalhe
    ExplicitWidth = 924
    ExplicitHeight = 516
    inherited tbsPesquisa: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 916
      ExplicitHeight = 488
      inherited DBGrid1: TDBGrid
        Width = 916
        Height = 388
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            Width = 58
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATA'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALORTOTAL'
            Width = 124
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'STATUS_DESCRICAO'
            Visible = True
          end>
      end
      inherited scbx_Baixo: TScrollBox
        Top = 447
        Width = 916
        ExplicitTop = 447
        ExplicitWidth = 916
        inherited Button1: TButton
          Left = 833
          ExplicitLeft = 833
        end
        inherited btnApagar: TButton
          Left = 86
          Visible = False
          ExplicitLeft = 86
        end
        inherited btnAlterar: TButton
          Left = 248
          Visible = False
          ExplicitLeft = 248
        end
      end
      inherited scbx_Topo: TScrollBox
        Width = 916
        ExplicitWidth = 916
        inherited btnPesquisar: TButton
          Left = 833
          Top = 23
          ExplicitLeft = 833
          ExplicitTop = 23
        end
      end
    end
    inherited tbsDetalhe: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 916
      ExplicitHeight = 488
      inherited ScrollBox1: TScrollBox
        Top = 448
        Width = 916
        ExplicitTop = 448
        ExplicitWidth = 916
        inherited Button2: TButton
          Left = 838
          ExplicitLeft = 838
        end
        inherited Button3: TButton
          Left = 757
          ExplicitLeft = 757
        end
        object edtVlrTotal: TLabeledEdit
          Left = 552
          Top = 16
          Width = 121
          Height = 21
          Color = clInactiveCaption
          EditLabel.Width = 40
          EditLabel.Height = 13
          EditLabel.Caption = 'Vlr.Total'
          ReadOnly = True
          TabOrder = 2
          Text = '0,00'
        end
        object edtQtdItens: TLabeledEdit
          Left = 400
          Top = 16
          Width = 121
          Height = 21
          Color = clInactiveCaption
          EditLabel.Width = 53
          EditLabel.Height = 13
          EditLabel.Caption = 'Qtde.Itens'
          ReadOnly = True
          TabOrder = 3
          Text = '0'
        end
      end
      object edtId: TLabeledEdit
        Left = 3
        Top = 24
        Width = 90
        Height = 21
        Color = clInactiveCaption
        EditLabel.Width = 10
        EditLabel.Height = 13
        EditLabel.Caption = 'Id'
        ReadOnly = True
        TabOrder = 1
      end
      object edtCliente: TLabeledEdit
        Left = 290
        Top = 24
        Width = 200
        Height = 21
        Color = clInactiveCaption
        EditLabel.Width = 49
        EditLabel.Height = 13
        EditLabel.Caption = 'edtCliente'
        ReadOnly = True
        TabOrder = 2
      end
      object edtIdCliente: TLabeledEdit
        Left = 199
        Top = 24
        Width = 90
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cliente'
        TabOrder = 3
        OnExit = edtIdClienteExit
      end
      object PageControl1: TPageControl
        Left = 0
        Top = 80
        Width = 916
        Height = 368
        ActivePage = tbsItens
        Align = alBottom
        TabOrder = 4
        object tbsItens: TTabSheet
          Caption = 'Itens pedido'
          object DBGrid2: TDBGrid
            Left = 0
            Top = 0
            Width = 908
            Height = 340
            Align = alClient
            DataSource = dsPedidoVendaItem
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnDrawColumnCell = DBGrid1DrawColumnCell
            Columns = <
              item
                Expanded = False
                FieldName = 'ID_PRODUTO'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NOME'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'QT'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VALORUNITARIO'
                Width = 90
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VLSUBTOTAL'
                Width = 113
                Visible = True
              end>
          end
        end
        object tbsTabelaProduto: TTabSheet
          Caption = 'Tabela produtos'
          ImageIndex = 1
          object DBGrid3: TDBGrid
            Left = 0
            Top = 48
            Width = 908
            Height = 292
            Align = alBottom
            DataSource = dsProduto
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnDrawColumnCell = DBGrid1DrawColumnCell
            OnDblClick = DBGrid3DblClick
            Columns = <
              item
                Expanded = False
                FieldName = 'ID'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NOME'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VALOR'
                Visible = True
              end>
          end
          object btnProdutoPesquisar: TButton
            Left = 816
            Top = 17
            Width = 75
            Height = 25
            Caption = 'Pesquisar'
            TabOrder = 1
            OnClick = btnProdutoPesquisarClick
          end
        end
      end
      object edtData: TDateTimePicker
        Left = 87
        Top = 24
        Width = 106
        Height = 21
        Date = 44649.000000000000000000
        Time = 0.800283321761526100
        Color = clInactiveCaption
        TabOrder = 5
      end
    end
  end
  inherited cdsDadosPesquisa: TClientDataSet
    BeforePost = cdsDadosPesquisaBeforePost
    object cdsDadosPesquisaID: TLargeintField
      DisplayLabel = 'Id'
      FieldName = 'ID'
    end
    object cdsDadosPesquisaDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
    end
    object cdsDadosPesquisaVALORTOTAL: TFloatField
      DisplayLabel = 'Vlr.Total'
      FieldName = 'VALORTOTAL'
      DisplayFormat = '###,##0.00'
    end
    object cdsDadosPesquisaSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
    object cdsDadosPesquisaSTATUS_DESCRICAO: TStringField
      DisplayLabel = 'Status'
      FieldName = 'STATUS_DESCRICAO'
    end
  end
  object dsPedidoVendaItem: TDataSource
    DataSet = cdsPedidoVendaItem
    Left = 84
    Top = 238
  end
  object cdsPedidoVendaItem: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    AfterPost = cdsPedidoVendaItemAfterPost
    OnCalcFields = cdsPedidoVendaItemCalcFields
    Left = 124
    Top = 238
    object cdsPedidoVendaItemNUMSEQUENCIA: TLargeintField
      DisplayLabel = 'Seq.'
      FieldName = 'NUMSEQUENCIA'
    end
    object cdsPedidoVendaItemID_PRODUTO: TLargeintField
      DisplayLabel = 'Id.Produto'
      FieldName = 'ID_PRODUTO'
    end
    object cdsPedidoVendaItemQT: TFloatField
      DisplayLabel = 'Qtde.'
      FieldName = 'QT'
      DisplayFormat = '###,##0'
    end
    object cdsPedidoVendaItemVALORUNITARIO: TFloatField
      DisplayLabel = 'Vlr.Unitario'
      FieldName = 'VALORUNITARIO'
      DisplayFormat = '###,##0.00'
    end
    object cdsPedidoVendaItemNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 60
    end
    object cdsPedidoVendaItemVLSUBTOTAL: TFloatField
      DisplayLabel = 'Vlr.Subtotal'
      FieldKind = fkCalculated
      FieldName = 'VLSUBTOTAL'
      DisplayFormat = '###,##0.00'
      Calculated = True
    end
    object cdsPedidoVendaItemCONTROLEESPECIAL: TStringField
      FieldName = 'CONTROLEESPECIAL'
      Size = 1
    end
    object cdsPedidoVendaItemVALORTOTAL: TAggregateField
      FieldName = 'VALORTOTAL'
      Active = True
      currency = True
      DisplayName = ''
      Expression = 'SUM( QT * VALORUNITARIO )'
    end
  end
  object cdsProduto: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 428
    Top = 214
    object cdsProdutoID: TLargeintField
      DisplayLabel = 'Id'
      FieldName = 'ID'
    end
    object cdsProdutoNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 60
    end
    object cdsProdutoCONTROLEESPECIAL: TStringField
      FieldName = 'CONTROLEESPECIAL'
      Size = 1
    end
    object cdsProdutoVALOR: TFloatField
      DisplayLabel = 'Vlr.Unit'#225'rio'
      FieldName = 'VALOR'
      DisplayFormat = '###,##0.00'
    end
  end
  object dsProduto: TDataSource
    DataSet = cdsProduto
    Left = 476
    Top = 209
  end
end
