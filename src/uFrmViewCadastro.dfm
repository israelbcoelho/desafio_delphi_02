inherited FrmViewCadastro: TFrmViewCadastro
  ActiveControl = pgcCadastro
  BorderIcons = [biSystemMenu]
  Caption = 'FrmViewCadastro'
  ClientHeight = 380
  ClientWidth = 651
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 667
  ExplicitHeight = 419
  PixelsPerInch = 96
  TextHeight = 13
  object pgcCadastro: TPageControl
    Left = 0
    Top = 0
    Width = 651
    Height = 380
    ActivePage = tbsPesquisa
    Align = alClient
    TabOrder = 0
    object tbsPesquisa: TTabSheet
      Caption = 'Pesquisa'
      object DBGrid1: TDBGrid
        Left = 0
        Top = 59
        Width = 643
        Height = 252
        Align = alClient
        DataSource = dsDadosPesquisa
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = DBGrid1DrawColumnCell
        OnDblClick = DBGrid1DblClick
      end
      object scbx_Baixo: TScrollBox
        Left = 0
        Top = 311
        Width = 643
        Height = 41
        Align = alBottom
        BorderStyle = bsNone
        TabOrder = 1
        object Button1: TButton
          Left = 561
          Top = 6
          Width = 75
          Height = 25
          Action = actFechar
          TabOrder = 0
        end
        object btnApagar: TButton
          Left = 167
          Top = 6
          Width = 75
          Height = 25
          Action = actApagar
          TabOrder = 1
        end
        object btnIncluir: TButton
          Left = 5
          Top = 6
          Width = 75
          Height = 25
          Action = actNovo
          TabOrder = 2
        end
        object btnAlterar: TButton
          Left = 86
          Top = 6
          Width = 75
          Height = 25
          Action = actAlterar
          TabOrder = 3
        end
      end
      object scbx_Topo: TScrollBox
        Left = 0
        Top = 0
        Width = 643
        Height = 59
        Align = alTop
        BorderStyle = bsNone
        TabOrder = 2
        object btnPesquisar: TButton
          Left = 565
          Top = 15
          Width = 75
          Height = 25
          Action = actPesquisar
          TabOrder = 0
        end
      end
    end
    object tbsDetalhe: TTabSheet
      Caption = 'Detalhe'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 312
        Width = 643
        Height = 40
        Align = alBottom
        BorderStyle = bsNone
        TabOrder = 0
        object Button2: TButton
          Left = 549
          Top = 12
          Width = 75
          Height = 25
          Action = actCancelar
          TabOrder = 0
        end
        object Button3: TButton
          Left = 468
          Top = 12
          Width = 75
          Height = 25
          Action = actGravar
          TabOrder = 1
        end
      end
    end
  end
  object ActionList1: TActionList
    Left = 432
    Top = 104
    object actNovo: TAction
      Category = 'Pesquisar'
      Caption = 'Novo'
      OnExecute = actNovoExecute
    end
    object actAlterar: TAction
      Category = 'Pesquisar'
      Caption = 'Alterar'
      OnExecute = actAlterarExecute
    end
    object actApagar: TAction
      Category = 'Pesquisar'
      Caption = 'Apagar'
      OnExecute = actApagarExecute
    end
    object actFechar: TAction
      Category = 'Pesquisar'
      Caption = 'Fechar'
      OnExecute = actFecharExecute
    end
    object actPesquisar: TAction
      Category = 'Pesquisar'
      Caption = 'Pesquisar'
      OnExecute = actPesquisarExecute
    end
    object actCancelar: TAction
      Category = 'Detalhes'
      Caption = 'Cancelar'
      OnExecute = actCancelarExecute
    end
    object actGravar: TAction
      Category = 'Detalhes'
      Caption = 'Gravar'
      OnExecute = actGravarExecute
    end
  end
  object dsDadosPesquisa: TDataSource
    DataSet = cdsDadosPesquisa
    Left = 272
    Top = 168
  end
  object cdsDadosPesquisa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 276
    Top = 240
  end
end
