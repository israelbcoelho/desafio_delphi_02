inherited FrmViewReceita: TFrmViewReceita
  Caption = 'Receita'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcCadastro: TPageControl
    ActivePage = tbsDetalhe
    inherited tbsPesquisa: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 643
      ExplicitHeight = 352
      inherited DBGrid1: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_PEDIDO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAOSTATUS'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_TECNICOAGRICOLA'
            Visible = True
          end>
      end
      inherited scbx_Baixo: TScrollBox
        inherited btnApagar: TButton
          Left = 239
          Visible = False
          ExplicitLeft = 239
        end
        inherited btnIncluir: TButton
          Left = 149
          Visible = False
          ExplicitLeft = 149
        end
        inherited btnAlterar: TButton
          Left = 4
          Width = 109
          Caption = 'Assinar receita'
          ExplicitLeft = 4
          ExplicitWidth = 109
        end
      end
      inherited scbx_Topo: TScrollBox
        object cbStatus: TComboBox
          Left = 3
          Top = 32
          Width = 145
          Height = 22
          Style = csOwnerDrawFixed
          ItemIndex = 1
          TabOrder = 1
          Text = 'A - Aguardando Receita'
          Items.Strings = (
            'C - Conclu'#237'do'
            'A - Aguardando Receita'
            'T - Todos')
        end
      end
    end
    inherited tbsDetalhe: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 643
      ExplicitHeight = 352
      object edtIdReceita: TLabeledEdit
        Left = 3
        Top = 24
        Width = 121
        Height = 21
        TabStop = False
        Color = clInactiveCaption
        EditLabel.Width = 49
        EditLabel.Height = 13
        EditLabel.Caption = 'Id Receita'
        ReadOnly = True
        TabOrder = 1
      end
      object edtIdPedido: TLabeledEdit
        Left = 130
        Top = 24
        Width = 121
        Height = 21
        TabStop = False
        Color = clInactiveCaption
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Id Pedido'
        ReadOnly = True
        TabOrder = 2
      end
      object DBGrid2: TDBGrid
        Left = 0
        Top = 51
        Width = 643
        Height = 261
        TabStop = False
        Align = alBottom
        DataSource = dsDadosItem
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 3
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = DBGrid1DrawColumnCell
        OnDblClick = DBGrid1DblClick
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
          end>
      end
      object edtIdTecnico: TLabeledEdit
        Left = 257
        Top = 24
        Width = 90
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'Tecnico'
        TabOrder = 4
        OnExit = edtIdTecnicoExit
      end
      object edtNomeTecnico: TLabeledEdit
        Left = 353
        Top = 24
        Width = 200
        Height = 21
        TabStop = False
        Color = clInactiveCaption
        EditLabel.Width = 3
        EditLabel.Height = 13
        ReadOnly = True
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
    object cdsDadosPesquisaID_PEDIDO: TLargeintField
      DisplayLabel = 'Id Pedido'
      FieldName = 'ID_PEDIDO'
    end
    object cdsDadosPesquisaSTATUS: TStringField
      DisplayLabel = 'Status'
      FieldName = 'STATUS'
      Size = 30
    end
    object cdsDadosPesquisaDESCRICAOSTATUS: TStringField
      DisplayLabel = 'Status'
      FieldName = 'DESCRICAOSTATUS'
      Size = 30
    end
    object cdsDadosPesquisaID_TECNICOAGRICOLA: TLargeintField
      DisplayLabel = 'Id Tecnico'
      FieldName = 'ID_TECNICOAGRICOLA'
    end
  end
  object dsDadosItem: TDataSource
    DataSet = cdsDadosItem
    Left = 140
    Top = 224
  end
  object cdsDadosItem: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 132
    Top = 272
    object cdsDadosItemID_PRODUTO: TLargeintField
      DisplayLabel = 'Id Produto'
      FieldName = 'ID_PRODUTO'
    end
    object cdsDadosItemNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 60
    end
    object cdsDadosItemID_RECEITA: TLargeintField
      DisplayLabel = 'Id Receita'
      FieldName = 'ID_RECEITA'
    end
  end
end
