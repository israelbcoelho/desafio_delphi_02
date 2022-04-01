inherited FrmViewCliente: TFrmViewCliente
  Caption = 'Cliente'
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
      object lblCPF: TLabel [0]
        Left = 19
        Top = 113
        Width = 29
        Height = 13
        Caption = 'lblCPF'
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
        TabOrder = 1
      end
      object edtNome: TLabeledEdit
        Left = 19
        Top = 79
        Width = 326
        Height = 21
        CharCase = ecUpperCase
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 2
      end
      object edtCpfCnpj: TMaskEdit
        Left = 19
        Top = 128
        Width = 142
        Height = 21
        EditMask = '!999.999.999-99;0; '
        MaxLength = 14
        TabOrder = 3
        Text = ''
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
