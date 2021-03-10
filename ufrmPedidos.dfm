object FrmPedidos: TFrmPedidos
  Left = 0
  Top = 0
  Caption = 'Pedidos de Venda'
  ClientHeight = 505
  ClientWidth = 739
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object panelTopo: TPanel
    Left = 0
    Top = 0
    Width = 739
    Height = 31
    Align = alTop
    Color = clHighlight
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = 3
    object btnNovo: TButton
      Left = 16
      Top = 3
      Width = 89
      Height = 25
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnGravar: TButton
      Left = 111
      Top = 3
      Width = 89
      Height = 25
      Caption = 'Gravar Pedido'
      TabOrder = 1
      Visible = False
      OnClick = btnGravarClick
    end
    object btnBuscar: TButton
      Left = 301
      Top = 3
      Width = 89
      Height = 25
      Caption = 'Buscar Pedido'
      TabOrder = 2
      OnClick = btnBuscarClick
    end
    object btnCancelar: TButton
      Left = 206
      Top = 3
      Width = 89
      Height = 25
      Caption = 'Cancelar Pedido'
      TabOrder = 3
      OnClick = btnCancelarClick
    end
  end
  object PanelPedidos: TPanel
    Left = 0
    Top = 31
    Width = 739
    Height = 57
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    ExplicitLeft = -8
    ExplicitTop = 34
    object Label1: TLabel
      Left = 16
      Top = 9
      Width = 50
      Height = 13
      Caption = 'Nr. Pedido'
    end
    object Label2: TLabel
      Left = 87
      Top = 9
      Width = 33
      Height = 13
      Caption = 'Cliente'
    end
    object Label3: TLabel
      Left = 604
      Top = 9
      Width = 79
      Height = 13
      Caption = 'Data de Emiss'#227'o'
    end
    object Label9: TLabel
      Left = 423
      Top = 9
      Width = 50
      Height = 13
      Caption = 'Cidade/UF'
    end
    object edtNumeroPedido: TEdit
      Left = 16
      Top = 28
      Width = 65
      Height = 21
      Enabled = False
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 0
      OnKeyPress = edtNumeroPedidoKeyPress
    end
    object edtCodCliente: TEdit
      Left = 87
      Top = 28
      Width = 58
      Height = 21
      Enabled = False
      NumbersOnly = True
      TabOrder = 1
      OnExit = edtCodClienteExit
      OnKeyPress = edtCodClienteKeyPress
    end
    object edtNomeCliente: TEdit
      Left = 151
      Top = 28
      Width = 266
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 2
    end
    object edtDataEmissao: TEdit
      Left = 604
      Top = 28
      Width = 116
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      OnKeyPress = edtDataEmissaoKeyPress
    end
    object edtCidade: TEdit
      Left = 423
      Top = 28
      Width = 175
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      OnKeyPress = edtDataEmissaoKeyPress
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 88
    Width = 739
    Height = 31
    Align = alTop
    Color = clHighlight
    ParentBackground = False
    TabOrder = 2
    object btnIncluirProduto: TButton
      Left = 16
      Top = 3
      Width = 89
      Height = 25
      Caption = 'Incluir Produto'
      Enabled = False
      TabOrder = 0
      OnClick = btnIncluirProdutoClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 440
    Width = 739
    Height = 34
    Align = alBottom
    Color = clWhite
    ParentBackground = False
    TabOrder = 3
    DesignSize = (
      739
      34)
    object btnProximo: TButton
      Left = 647
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Pr'#243'ximo >'
      Enabled = False
      TabOrder = 0
      TabStop = False
      OnClick = btnProximoClick
    end
    object btnAnterior: TButton
      Left = 16
      Top = 3
      Width = 89
      Height = 25
      Caption = '< Anterior'
      Enabled = False
      TabOrder = 1
      TabStop = False
      OnClick = btnAnteriorClick
    end
  end
  object PanelPedidoProdutos: TPanel
    Left = 0
    Top = 119
    Width = 739
    Height = 57
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 4
    object Label6: TLabel
      Left = 16
      Top = 9
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object Label7: TLabel
      Left = 448
      Top = 9
      Width = 88
      Height = 13
      Caption = 'Valor Unit'#225'rio (R$)'
    end
    object Label8: TLabel
      Left = 625
      Top = 9
      Width = 75
      Height = 13
      Caption = 'Valor Total (R$)'
    end
    object Label4: TLabel
      Left = 549
      Top = 9
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object edtCodProduto: TEdit
      Left = 16
      Top = 28
      Width = 58
      Height = 21
      Enabled = False
      NumbersOnly = True
      TabOrder = 0
      OnChange = edtCodProdutoChange
      OnExit = edtCodProdutoExit
      OnKeyPress = edtCodProdutoKeyPress
    end
    object edtNomeProduto: TEdit
      Left = 80
      Top = 28
      Width = 362
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtValorUnitario: TEdit
      Left = 448
      Top = 28
      Width = 95
      Height = 21
      Enabled = False
      TabOrder = 2
      OnExit = edtValorUnitarioExit
      OnKeyPress = edtValorUnitarioKeyPress
    end
    object edtValorTotal: TEdit
      Left = 625
      Top = 28
      Width = 95
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 3
    end
    object edtQuantidade: TEdit
      Left = 549
      Top = 28
      Width = 70
      Height = 21
      Enabled = False
      TabOrder = 4
      OnExit = edtQuantidadeExit
      OnKeyPress = edtQuantidadeKeyPress
    end
  end
  object gridPedidoProdutos: TStringGrid
    Left = 0
    Top = 176
    Width = 739
    Height = 264
    TabStop = False
    Align = alClient
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 5
    OnClick = gridPedidoProdutosClick
    OnKeyUp = gridPedidoProdutosKeyUp
    ExplicitTop = 174
  end
  object PanelRodape: TPanel
    Left = 0
    Top = 474
    Width = 739
    Height = 31
    Align = alBottom
    Color = cl3DDkShadow
    ParentBackground = False
    TabOrder = 6
    DesignSize = (
      739
      31)
    object Label5: TLabel
      Left = 543
      Top = 8
      Width = 98
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Valor Pedido (R$)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtValorPedido: TEdit
      Left = 647
      Top = 5
      Width = 79
      Height = 21
      Anchors = [akTop, akRight]
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
  end
end
