inherited FrmViewProduto: TFrmViewProduto
  Caption = 'Produto'
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
            FieldName = 'NOME'
            Visible = True
          end>
      end
      inherited scbx_Topo: TScrollBox
        inherited btnPesquisar: TButton
          Top = 23
          ExplicitTop = 23
        end
        object edtPesquisaNome: TLabeledEdit
          Left = 3
          Top = 25
          Width = 326
          Height = 21
          CharCase = ecUpperCase
          EditLabel.Width = 27
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome'
          TabOrder = 1
        end
      end
    end
    inherited tbsDetalhe: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 643
      ExplicitHeight = 352
      object edtNome: TLabeledEdit
        Left = 19
        Top = 78
        Width = 326
        Height = 21
        CharCase = ecUpperCase
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
      end
      object edtId: TLabeledEdit
        Left = 19
        Top = 33
        Width = 70
        Height = 21
        TabStop = False
        Color = clInactiveCaption
        EditLabel.Width = 10
        EditLabel.Height = 13
        EditLabel.Caption = 'Id'
        ReadOnly = True
        TabOrder = 2
      end
      object edtValor: TLabeledEdit
        Left = 19
        Top = 123
        Width = 158
        Height = 21
        EditLabel.Width = 24
        EditLabel.Height = 13
        EditLabel.Caption = 'Valor'
        TabOrder = 3
        OnKeyPress = SomenteValorMoeda
      end
      object edtControleEspecial: TCheckBox
        Left = 19
        Top = 168
        Width = 97
        Height = 17
        Caption = 'Controle especial'
        TabOrder = 4
      end
    end
  end
  inherited cdsDadosPesquisa: TClientDataSet
    object cdsDadosPesquisaID: TLargeintField
      DisplayLabel = 'Id'
      FieldName = 'ID'
    end
    object cdsDadosPesquisaNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 60
    end
  end
end
