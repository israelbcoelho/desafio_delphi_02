inherited FrmViewDetalheItem: TFrmViewDetalheItem
  BorderIcons = []
  Caption = 'Item'
  ClientHeight = 146
  ExplicitHeight = 185
  PixelsPerInch = 96
  TextHeight = 13
  object btnConfirmar: TButton
    Left = 304
    Top = 113
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 0
    OnClick = btnConfirmarClick
  end
  object btnCancelar: TButton
    Left = 398
    Top = 113
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 1
    OnClick = btnCancelarClick
  end
  object edtIdProduto: TLabeledEdit
    Left = 16
    Top = 24
    Width = 121
    Height = 21
    TabStop = False
    Color = clInactiveCaption
    EditLabel.Width = 10
    EditLabel.Height = 13
    EditLabel.Caption = 'Id'
    ReadOnly = True
    TabOrder = 2
  end
  object edtNome: TLabeledEdit
    Left = 143
    Top = 24
    Width = 330
    Height = 21
    TabStop = False
    Color = clInactiveCaption
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Nome'
    ReadOnly = True
    TabOrder = 3
  end
  object edtQuantidade: TLabeledEdit
    Left = 16
    Top = 75
    Width = 150
    Height = 21
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = 'Qtde'
    TabOrder = 4
    OnExit = edtQuantidadeExit
  end
  object edtVlrUnitario: TLabeledEdit
    Left = 169
    Top = 75
    Width = 150
    Height = 21
    TabStop = False
    Color = clInactiveCaption
    EditLabel.Width = 53
    EditLabel.Height = 13
    EditLabel.Caption = 'Vlr.Unitario'
    ReadOnly = True
    TabOrder = 5
  end
  object edtVlSubtotal: TLabeledEdit
    Left = 323
    Top = 75
    Width = 150
    Height = 21
    TabStop = False
    Color = clInactiveCaption
    EditLabel.Width = 58
    EditLabel.Height = 13
    EditLabel.Caption = 'Vlr.SubTotal'
    ReadOnly = True
    TabOrder = 6
  end
end