unit ufrmPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, untFuncoes,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, udm, Vcl.DBGrids, StrUtils;

type
  Tpedido = class

  private // atributos e metodos privados
  Fnumero :Integer;
  Fcodcli :Integer;
  Fdataemissao : TDateTime;
  Fvalortotal: double;

  Constructor Create;    // declaração do metodo construtor
  Destructor  Destroy; Override; // declaração do metodo destrutor

  protected // atributos e metodos protegidos

  public // atributos e metodos publicos
  property numero :Integer read Fnumero write Fnumero;
  property codcli :Integer read Fcodcli write Fcodcli;
  property dataemissao :TDateTime read Fdataemissao;
  property valortotal :double read Fvalortotal write Fvalortotal;

  end;

  type
  TpedidoProdutos = class

  private // atributos e metodos privados
  Fnumero :Integer;
  Fcodprod :Integer;
  Fquantidade : double;
  Fvalorunitario: double;

  Constructor Create;    // declaração do metodo construtor
  Destructor  Destroy; Override; // declaração do metodo destrutor

  protected // atributos e metodos protegidos

  public // atributos e metodos publicos
  property numero :Integer read Fnumero;
  property codprod :Integer read Fcodprod write Fcodprod;
  property quantidade :double read Fquantidade write Fquantidade;
  property valorunitario :double read Fvalorunitario write Fvalorunitario;

  end;

type
  TFrmPedidos = class(TForm)
    panelTopo: TPanel;
    btnNovo: TButton;
    btnGravar: TButton;
    PanelPedidos: TPanel;
    edtNumeroPedido: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtCodCliente: TEdit;
    edtNomeCliente: TEdit;
    Label3: TLabel;
    edtDataEmissao: TEdit;
    Panel2: TPanel;
    btnIncluirProduto: TButton;
    Panel1: TPanel;
    btnProximo: TButton;
    btnAnterior: TButton;
    PanelPedidoProdutos: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtCodProduto: TEdit;
    edtNomeProduto: TEdit;
    edtValorUnitario: TEdit;
    edtValorTotal: TEdit;
    edtQuantidade: TEdit;
    Label4: TLabel;
    gridPedidoProdutos: TStringGrid;
    PanelRodape: TPanel;
    Label5: TLabel;
    edtValorPedido: TEdit;
    btnBuscar: TButton;
    btnCancelar: TButton;
    Label9: TLabel;
    edtCidade: TEdit;
    procedure btnNovoClick(Sender: TObject);
    procedure edtNumeroPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtDataEmissaoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure gridPedidoProdutosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncluirProdutoClick(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtCodProdutoChange(Sender: TObject);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorUnitarioExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure gridPedidoProdutosClick(Sender: TObject);
  private
    /// <summary> Insere dados nos edits de pedido conforme dados da variavel PedidoAtual </summary>
    procedure alimentaEditsPedido;
    /// <summary> Controla os botões principais se devem estar visible/enabled conforme o que está sendo feito</summary>
    procedure controlaEstadoBotoes;
    /// <summary> Controla qual caption deve mostrar no botão de "Incluir Produto"</summary>
    procedure controlaCaptionProduto;
    /// <summary> Atualiza valores do grid conforme dados da variavel PedidoAtual </summary>
    procedure atualizarValoresGridProdutos(vPosicaoArray:integer);
    /// <summary> Atualiza edits do produto de pedido conforme dado presente na linha selecionado do grid </summary>
    procedure alimentaEditsPedidoProdutos;
    /// <summary> Cria objetos no array de produtos do pedido e insere valores de acordo com o que está no grid</summary>
    procedure criaObjetoPedidoProdutoAndPopula;
    /// <summary> Controla qual caption deve mostrar no botão de "Novo"</summary>
    procedure controlaCaptionNovo;
    /// <summary> Limpa todos os dados da tela, como se a mesma estivesse sido recém aberta </summary>
    procedure ResetTela;
    /// <summary> Verifica se o pedido informado existe no banco de dados </summary>
    function  isPedidoExiste(vPedido: string): boolean;
    /// <summary> Controla enabled dos botões "Próximo" e "Anterior" </summary>
    procedure controlaEstadoBotoesNavegacao;
    procedure atualizaNomeMunicipioCliente;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPedidos: TFrmPedidos;
  PedidoAtual: Tpedido;
  PedidoAtualProdutos: array of TpedidoProdutos;

implementation

{$R *.dfm}

{ Tpedido }

// metodo contrutor
constructor Tpedido.Create;
begin
  //Sugere numero do pedido
  Fnumero := dm.conexao.ExecSQLScalar('select IFNULL(max(nrPedido),0)+1 from pedido');
  //Valor inicial é 0 pois não tem nenhum produto ainda
  Fvalortotal := 0;
  //Data de emissão inicia com a data atual
  Fdataemissao := Now;
end;

// metodo destrutor
destructor Tpedido.Destroy;
begin
  SetLength(PedidoAtualProdutos,0);
  PedidoAtualProdutos := nil;
  inherited;
end;

{ Tpedido }

// metodo contrutor
constructor TpedidoProdutos.Create;
begin
  //Numero do pedido é o que já está informado
  Fnumero := PedidoAtual.Fnumero;
end;

// metodo destrutor
destructor TpedidoProdutos.Destroy;
begin
  inherited;
end;

{ TFrmPedidos }

procedure TFrmPedidos.btnAnteriorClick(Sender: TObject);
begin
  btnAnterior.SetFocus;
  gridPedidoProdutos.Row := gridPedidoProdutos.Row-1;
  controlaEstadoBotoesNavegacao;
end;

procedure TFrmPedidos.btnBuscarClick(Sender: TObject);
var
  vPedido: string;
  vQueryConsulta: TFDQuery;
  I: Integer;
  vValorCelula: string;
begin
  btnBuscar.SetFocus;

  if not InputQuery('Informe o pedido','Número do pedido',vPedido) then
    Exit;

  if not isPedidoExiste(vPedido) then
  begin
    btnBuscarClick(Sender); //Volta a chamar a propria rotina para pedir outro numero
    Exit;
  end;

  ResetTela;

  vQueryConsulta := TFDQuery.Create(dm.conexao);
  vQueryConsulta.Connection := dm.conexao;
  vQueryConsulta.FetchOptions.Mode := fmAll; //Garante que retorno todos os dados

  vQueryConsulta.SQL.Text := 'Select * from pedido where nrpedido='+vPedido;
  vQueryConsulta.Open;

  PedidoAtual := Tpedido.Create;
  with PedidoAtual do
  begin
    Fnumero       := vPedido.ToInteger;
    Fdataemissao  := vQueryConsulta.FieldByName('dataemissao').AsDateTime;
    Fvalortotal   := vQueryConsulta.FieldByName('valorTotal').AsFloat;
    Fcodcli       := vQueryConsulta.FieldByName('codCliente').AsInteger;
  end;

  alimentaEditsPedido;

  vQueryConsulta.Close;
  vQueryConsulta.SQL.Text :=
    ' Select pedido_produtos.codProduto,produto.descricao,valorUnitario,quantidade,valorTotal' +
    ' from pedido_produtos ' +
    ' inner join produto on (produto.codproduto=pedido_produtos.codproduto)' +
    ' where nrpedido='+vPedido;
  vQueryConsulta.Open;

  //Define quantidade de linhas do grid
  gridPedidoProdutos.RowCount := vQueryConsulta.RecordCount + 1;

  //Define tamanho do array
  SetLength(PedidoAtualProdutos,vQueryConsulta.RecordCount);

  while not vQueryConsulta.Eof do
  begin
    for I := 0 to gridPedidoProdutos.ColCount-1 do
    begin
      vValorCelula := vQueryConsulta.Fields[I].AsString;

      if vQueryConsulta.Fields[I].DataType = ftBCD then //Formata quantidade de casas decimais
        formataCampo(vValorCelula,TBCDField(vQueryConsulta.Fields[I]).Size);

      gridPedidoProdutos.Cells[I,vQueryConsulta.RecNo] := vValorCelula;
    end;
    vQueryConsulta.Next;
  end;

  controlaEstadoBotoes;
  controlaCaptionNovo;

  //Com dados carregados pode inserir outro produto
  btnIncluirProduto.Enabled := True;
  alteraEstadoEdits(PanelPedidoProdutos,True);

  //Chama para já deixar pronto para inserir outro produto
  //Essa rotina mesmo que vai popular o array de pedidoProdutos
  btnIncluirProdutoClick(Sender);

end;

function TFrmPedidos.isPedidoExiste(vPedido:string): boolean;
var
  vIntTemp: Integer;
begin
  if not TryStrToInt(vPedido,vIntTemp) then
  begin
    ShowMessage('Digite um valor válido!');
    Result := False;
    Exit;
  end;

  if dm.conexao.ExecSQLScalar('Select count(*) from pedido where nrpedido='+vPedido) = 0 then
  begin
    ShowMessage('Pedido não encontrado!');
    Result := False;
    Exit;
  end;
  Result := True;
end;

procedure TFrmPedidos.controlaEstadoBotoesNavegacao;
begin
  btnProximo.Enabled  := (gridPedidoProdutos.Row > 0) and (gridPedidoProdutos.Row<gridPedidoProdutos.RowCount-1);
  btnAnterior.Enabled := gridPedidoProdutos.Row > 1;
end;

procedure TFrmPedidos.atualizaNomeMunicipioCliente;
begin
  if edtCodCliente.Text <> '' then
  begin
    //Atualiza dado no array
    PedidoAtual.Fcodcli := StrToInt(edtCodCliente.Text);

    edtNomeCliente.Text := dm.conexao.ExecSQLScalar('Select Nome from Cliente where CodCliente=' + edtCodCliente.Text);
    edtCidade.Text      := dm.conexao.ExecSQLScalar('Select CONCAT(cidade,'' ('',uf,'')'')  from Cliente where CodCliente=' + edtCodCliente.Text);
  end
  else
  begin
    //Atualiza dado no array
    PedidoAtual.Fcodcli := 0;

    edtNomeCliente.Text := EmptyStr;
    edtCidade.Text      := EmptyStr;
  end;
end;

procedure TFrmPedidos.btnCancelarClick(Sender: TObject);
var
  vPedido: string;
  vSQL: string;
begin
  btnCancelar.SetFocus;

  if not InputQuery('Informe o pedido a cancelar','Número do pedido',vPedido) then
    Exit;

  if not isPedidoExiste(vPedido) then
  begin
    btnCancelarClick(Sender); //Volta a chamar a propria rotina para pedir outro numero
    Exit;
  end;

  vSQL :=
    'START TRANSACTION;' + //Inicio de transação
    'Delete from pedido_produtos where nrpedido='+vPedido+';'+ //Exclui produtos do pedido
    'Delete from pedido where nrpedido='+vPedido+';'+ //Exclui pedido
    'COMMIT;';// Fim da transação

  try
    dm.conexao.ExecSQL(vSQL);
  except
    on E: Exception do
    begin
      ShowMessage('Ocorreu um erro ao tentar cancelar o pedido!');
      dm.conexao.ExecSQL('ROLLBACK');
      Exit;
    end;
  end;

  ShowMessage('Pedido cancelado com sucesso!');

end;

procedure TFrmPedidos.btnGravarClick(Sender: TObject);
var
  I: Integer;
  vSQL: WideString;
begin
  btnGravar.SetFocus;

  if edtCodProduto.Text <> EmptyStr then
    if MessageDlg('O produto atual não foi gravado.'+#13+'Deseja continuar assim mesmo?',mtConfirmation,[mbYes,mbNo],0) <> 6 then
      Exit;

  //Inicio de transação
  vSQL := 'START TRANSACTION;';

  //Se pedido já existe, é porque está em alteração, neste caso vai remover todos os produtos para lançar de novo
  if dm.conexao.ExecSQLScalar('select count(*) from pedido where nrpedido='+PedidoAtual.Fnumero.ToString)>0 then
    vSQL := vSQL + 'delete from pedido_produtos where nrpedido='+PedidoAtual.Fnumero.ToString+';'
  else
    //SQL pedido
    vSQL := vSQL +
      'insert into pedido(nrPedido,dataEmissao,codCliente,valorTotal) values ('+
      PedidoAtual.Fnumero.ToString+','+
      QuotedStr(converterDateTimeParaMYSQL(PedidoAtual.Fdataemissao))+','+
      PedidoAtual.Fcodcli.ToString+','+
      PedidoAtual.Fvalortotal.ToString.Replace(',','.')+
      ');';

  //Pega todos os registros (menos o ultimo que é o atual que está inserindo e deve ignorar)
  for I := 0 to Length(PedidoAtualProdutos)-2 do
    vSQL := vSQL +
      'insert into pedido_produtos(nrPedido,codproduto,quantidade,valorUnitario,valorTotal) values ('+
      PedidoAtual.Fnumero.ToString+','+
      PedidoAtualProdutos[I].Fcodprod.ToString+','+
      PedidoAtualProdutos[I].quantidade.ToString.Replace(',','.')+','+
      PedidoAtualProdutos[I].valorunitario.ToString.Replace(',','.')+','+
      (PedidoAtualProdutos[I].quantidade*PedidoAtualProdutos[I].valorunitario).ToString.Replace(',','.')+
      ');';

  //Fim de transação
  vSQL := vSQL + 'COMMIT;';

  try
    dm.conexao.ExecSQL(vSQL);
  except
    on E: Exception do
    begin
      ShowMessage('Ocorreu um erro ao tentar inserir os dados!');
      dm.conexao.ExecSQL('ROLLBACK');
      Exit;
    end;
  end;

  ResetTela;
  ShowMessage('Pedido gravado com sucesso!');
end;



procedure TFrmPedidos.atualizarValoresGridProdutos(vPosicaoArray:integer);
var
  I: Integer;
  vFormatado: string;
begin

  with PedidoAtualProdutos[vPosicaoArray] do
  begin 
    gridPedidoProdutos.Cells[0,gridPedidoProdutos.Row] := Fcodprod.ToString;
    gridPedidoProdutos.Cells[1,gridPedidoProdutos.Row] := dm.conexao.ExecSQLScalar('Select descricao from produto where codProduto='+ Fcodprod.ToString);
    vFormatado := Fvalorunitario.ToString;
    formataCampo(vFormatado);
    gridPedidoProdutos.Cells[2,gridPedidoProdutos.Row] := vFormatado;
    vFormatado := Fquantidade.ToString;
    formataCampo(vFormatado,3);
    gridPedidoProdutos.Cells[3,gridPedidoProdutos.Row] := vFormatado;
    vFormatado := (Fvalorunitario*Fquantidade).ToString;
    formataCampo(vFormatado);
    gridPedidoProdutos.Cells[4,gridPedidoProdutos.Row] := vFormatado;


  end;
 
end;

procedure TFrmPedidos.btnIncluirProdutoClick(Sender: TObject);
begin
  btnIncluirProduto.SetFocus;

  if Sender <> btnBuscar then
  begin
    if not validaPreenchimentoCampos(PanelPedidos)  then
      Exit;

    //Não pode mais mudar o cliente enquanto estiver incluindo produto
    untFuncoes.alteraEstadoEdits(PanelPedidos,False);

    //Vai para ultima linha se não estiver em edição
    if edtCodProduto.Enabled then
      gridPedidoProdutos.Row := gridPedidoProdutos.RowCount-1;

    //valida se todos os campos foram preenchidos
    if Length(PedidoAtualProdutos) > 0 then
      if not validaPreenchimentoCampos(PanelPedidoProdutos) then
        Exit;

    //Salva produto
    if Length(PedidoAtualProdutos) > 0 then
    begin
      with PedidoAtualProdutos[gridPedidoProdutos.Row-1] do
      begin
        Fcodprod        := StrToInt(edtCodProduto.Text);
        Fquantidade     := StrToFloat(edtQuantidade.Text);
        Fvalorunitario  := StrToFloat(edtValorUnitario.Text);
      end;
      atualizarValoresGridProdutos(gridPedidoProdutos.Row-1);
    end;
  end;

  //Adiciona novo espaço reservado em memoria para um novo produto
  if (edtCodProduto.Enabled) OR not (edtQuantidade.Enabled) then //produto Enabled = não está em edição
  begin
    SetLength(PedidoAtualProdutos,Length(PedidoAtualProdutos)+1);
  end;

  //Sempre mantem atualizado
  criaObjetoPedidoProdutoAndPopula;

  untFuncoes.alteraEstadoEdits(PanelPedidoProdutos,True);
  gridPedidoProdutos.Enabled := True;
  
  controlaCaptionProduto;

  //Quantidade de linhas = quantidade de produtos + 1 (cabeçalho)
  gridPedidoProdutos.RowCount := Length(PedidoAtualProdutos) + 1;
  gridPedidoProdutos.Row := gridPedidoProdutos.RowCount-1;

  limpaEdits(PanelPedidoProdutos);

  if edtCodProduto.Enabled then
    edtCodProduto.SetFocus;

  btnGravar.Visible := Length(PedidoAtualProdutos) >= 2; //Deve ter 2 registros (pois o atual vai ser descartado)
end;

//Alimenta campos conforme está no objeto de 'PedidoAtual'
procedure TFrmPedidos.alimentaEditsPedido;
var
  I: Integer;
begin
  //Primeiro faz a limpeza de todos os edits
  untFuncoes.limpaEdits(PanelPedidos);

  //Agora carrega os dados
  edtNumeroPedido.Text  := PedidoAtual.Fnumero.ToString;
  edtCodCliente.Text    := PedidoAtual.Fcodcli.ToString;
  if edtCodCliente.Text = '0' then
    edtCodCliente.Text := '';
  atualizaNomeMunicipioCliente;
  edtDataEmissao.Text   := DateTimeToStr(PedidoAtual.Fdataemissao);

end;

//Alimenta campos conforme está na linha atual do grid
procedure TFrmPedidos.alimentaEditsPedidoProdutos;
var
  I: Integer;
begin
  //Primeiro faz a limpeza de todos os edits
  untFuncoes.limpaEdits(PanelPedidoProdutos);

  //Agora carrega os dados
  edtCodProduto.Text    := gridPedidoProdutos.Cells[0,gridPedidoProdutos.Row];
  edtNomeProduto.Text   := gridPedidoProdutos.Cells[1,gridPedidoProdutos.Row];
  edtValorUnitario.Text := gridPedidoProdutos.Cells[2,gridPedidoProdutos.Row];
  edtQuantidade.Text    := gridPedidoProdutos.Cells[3,gridPedidoProdutos.Row];

  //Se está em alteração não pode ficar alterando o produto
  edtCodProduto.Enabled       := False;
  gridPedidoProdutos.Enabled  := False;

  if edtValorUnitario.Enabled then
    edtValorUnitario.SetFocus;
end;

//Sempre vai recriar e repopular para que fique correto os dados entre o grid e o array
//Se houver exclusão não vai ficar um registro vazio no meio
procedure TFrmPedidos.criaObjetoPedidoProdutoAndPopula;
var
  I: Integer;
begin
  try
    edtValorPedido.Text := '0';

    //Ultimo registro não vai atualizar pois é o que está sendo inserindo atualmente
    for I := 0 to Length(PedidoAtualProdutos) - 1 do
    begin
      if PedidoAtualProdutos[I]=nil then
        PedidoAtualProdutos[I] := Tpedidoprodutos.Create;

      //Se primeiro registro está vazio sai da rotina
      if gridPedidoProdutos.Cells[0,I+1].IsEmpty then
        Exit;

      with PedidoAtualProdutos[I] do
      begin
        Fcodprod        := gridPedidoProdutos.Cells[0,I+1].ToInteger;
        Fvalorunitario  := gridPedidoProdutos.Cells[2,I+1].ToDouble;
        Fquantidade     := gridPedidoProdutos.Cells[3,I+1].ToDouble;

        edtValorPedido.Text := (StrToFloat(edtValorPedido.Text) + (Fvalorunitario*Fquantidade)).ToString;
        formataCampo(edtValorPedido);
      end;
    end;
  finally
    PedidoAtual.Fvalortotal := StrToFloat(edtValorPedido.Text);
    controlaEstadoBotoesNavegacao;
  end;
end;

procedure TFrmPedidos.btnNovoClick(Sender: TObject);
begin
  btnNovo.SetFocus;

  if PedidoAtual<>nil then
  begin
    if MessageDlg('Deseja realmente limpar?'+#13+'Os dados não salvos serão perdidos!',mtConfirmation,[mbYes,mbNo],0) <> 6 then
      Exit;

    ResetTela;
  end
  else
  begin
    //Cria pedido
    PedidoAtual := Tpedido.Create;
    alimentaEditsPedido;

    alteraEstadoEdits(PanelPedidos,true);
    controlaEstadoBotoes;

    if edtCodCliente.Enabled then
      edtCodCliente.SetFocus;
  end;

  controlaCaptionNovo;
end;

procedure TFrmPedidos.controlaEstadoBotoes;
begin
  //btnNovo.Enabled := not (edtNumeroPedido.Enabled) and (edtNumeroPedido.Text = EmptyStr);
  btnCancelar.Visible := (edtCodCliente.Text = EmptyStr) and (PedidoAtual=nil);
  btnBuscar.Visible   := btnCancelar.Visible;
  btnIncluirProduto.Enabled := (edtCodCliente.Enabled) and not (edtCodCliente.Text = EmptyStr);
  if btnNovo.Enabled then
    btnGravar.Visible := False;
end;

procedure TFrmPedidos.controlaCaptionProduto;
begin
  if Length(PedidoAtualProdutos) = 0 then
    btnIncluirProduto.Caption := 'Incluir Produto'
  else
    btnIncluirProduto.Caption := 'Incluir Próximo'
end;

procedure TFrmPedidos.controlaCaptionNovo;
begin
  if PedidoAtual = nil then
    btnNovo.Caption := 'Novo'
  else
    btnNovo.Caption := 'Limpar Dados'
end;

procedure TFrmPedidos.ResetTela;
begin
  if PedidoAtual <> nil then
  begin
    PedidoAtual.Destroy;
    PedidoAtual := nil;
  end;
  limparStringGrid(gridPedidoProdutos);
  limpaEdits(PanelPedidos);
  limpaEdits(PanelPedidoProdutos);
  limpaEdits(PanelRodape);
  alteraEstadoEdits(PanelPedidos, False);
  alteraEstadoEdits(PanelPedidoProdutos, False);
  controlaCaptionProduto;
  controlaEstadoBotoes;
  controlaCaptionNovo;
  controlaEstadoBotoesNavegacao;
end;

procedure TFrmPedidos.btnProximoClick(Sender: TObject);
begin
  btnProximo.SetFocus;
  gridPedidoProdutos.Row := gridPedidoProdutos.Row+1;
  controlaEstadoBotoesNavegacao;
end;

procedure TFrmPedidos.edtCodClienteExit(Sender: TObject);
begin
  try
    if edtCodCliente.Text <> EmptyStr then
    begin
      edtNomeCliente.Text := dm.conexao.ExecSQLScalar('Select Nome from cliente where codCliente='+edtCodCliente.Text);
      if edtNomeCliente.Text = EmptyStr then
      begin
        ShowMessage('Cliente não encontrado!'+#13+'Confira o código informado.');
        edtCodCliente.SetFocus;
        edtCodCliente.Clear;
        btnCancelar.Enabled := False;
        Exit;
      end;
    end;
  finally
    atualizaNomeMunicipioCliente;
  end;

  controlaEstadoBotoes;
  if btnIncluirProduto.Enabled then
    btnIncluirProduto.SetFocus;
end;

procedure TFrmPedidos.edtCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
  navegaProximoComponente(Sender,Key);
end;

procedure TFrmPedidos.edtCodProdutoChange(Sender: TObject);
begin
  edtValorUnitario.Text := EmptyStr;
end;

procedure TFrmPedidos.edtCodProdutoExit(Sender: TObject);
begin
  if edtCodProduto.Text = EmptyStr then
    edtCodProduto.Text := EmptyStr
  else
  begin
    edtNomeProduto.Text := dm.conexao.ExecSQLScalar('Select Descricao from produto where codProduto='+edtCodProduto.Text);
    if edtNomeProduto.Text = EmptyStr then
    begin
      ShowMessage('Produto não encontrado!'+#13+'Confira o código informado.');
      edtCodProduto.SetFocus;
      edtCodProduto.Clear;
      Exit;
    end
    else
      edtValorUnitario.Text := dm.conexao.ExecSQLScalar('Select precoVenda from produto where codProduto='+edtCodProduto.Text);

  end;
end;

procedure TFrmPedidos.edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  navegaProximoComponente(Sender,Key);
end;

procedure TFrmPedidos.edtDataEmissaoKeyPress(Sender: TObject; var Key: Char);
begin
  navegaProximoComponente(Sender,Key);
end;

procedure TFrmPedidos.edtNumeroPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  navegaProximoComponente(Sender,Key);
end;

procedure TFrmPedidos.edtQuantidadeExit(Sender: TObject);
begin
  formataCampo(Sender,3);
  btnIncluirProduto.SetFocus;
end;

procedure TFrmPedidos.edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  untFuncoes.validaCampoFloat(Sender,Key);
end;

procedure TFrmPedidos.edtValorUnitarioExit(Sender: TObject);
begin
  untFuncoes.formataCampo(Sender);
end;

procedure TFrmPedidos.edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
begin
  untFuncoes.validaCampoFloat(Sender,Key);
end;

procedure TFrmPedidos.FormCreate(Sender: TObject);
begin
  //Define titulos
  gridPedidoProdutos.Cols[0].Text := 'Produto';
  gridPedidoProdutos.Cols[2].Text := 'Valor Unitário (R$)';
  gridPedidoProdutos.Cols[3].Text := 'Quantidade';
  gridPedidoProdutos.Cols[4].Text := 'Valor Total (R$)';
  //Define largura das colunas
  gridPedidoProdutos.ColWidths[0] := 70;
  gridPedidoProdutos.ColWidths[1] := 372;
  gridPedidoProdutos.ColWidths[2] := 100;
  gridPedidoProdutos.ColWidths[3] := 78;
  gridPedidoProdutos.ColWidths[4] := 95;
end;

procedure TFrmPedidos.FormShow(Sender: TObject);
begin
  if Showing then
    btnNovo.SetFocus;

  //Testa conexão com banco de dados por meio de select simples
  try
    dm.conexao.ExecSQLScalar('Select now()');
  except
    ShowMessage('Problema na conexão com o banco de dados!');
    Application.Terminate;
  end;
end;

procedure TFrmPedidos.gridPedidoProdutosClick(Sender: TObject);
begin
  //Abort;
end;

procedure TFrmPedidos.gridPedidoProdutosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  I, Y: Integer;
begin
  //Para aceitar editar e apagar deve possuir ao menos 1 item registrado
  if gridPedidoProdutos.RowCount<=1 then
    Exit;

  if (Key=VK_RETURN) and (gridPedidoProdutos.Cells[0,gridPedidoProdutos.Row]<>'') then
  begin
    alimentaEditsPedidoProdutos
  end
  else if Key=VK_DELETE then
  begin
    Key := 0;
    if MessageDlg('Deseja realmente excluir o produto selecionado deste pedido?',mtConfirmation,[mbYes,mbNo],0) <> 6 then
      Exit;

    edtCodProduto.SetFocus;

    //Se usuário confirmou que deseja excluir o faz

    //Limpa edits
    limpaEdits(PanelPedidoProdutos);
    //habilita codprod pois pode estar em edit
    edtCodProduto.Enabled := true;

    //Primeiro: vai limpar os dados da linha atual
    for I := 0 to gridPedidoProdutos.ColCount-1 do
      gridPedidoProdutos.Cells[I,gridPedidoProdutos.Row] := EmptyStr;
    //Segundo: move dados abaixo da linha atual para a linha anterior
    for I := gridPedidoProdutos.Row+1 to gridPedidoProdutos.RowCount-1 do
      for Y := 0 to gridPedidoProdutos.ColCount-1 do
        gridPedidoProdutos.Cells[Y,I-1] := gridPedidoProdutos.Cells[Y,I];
    //Terceiro: reduz quantidade de linhas do grid
    gridPedidoProdutos.RowCount := gridPedidoProdutos.RowCount - 1;
    //Quarto: reduz array
    SetLength(PedidoAtualProdutos,Length(PedidoAtualProdutos)-1);
    //alimenta array com dados corretos
    criaObjetoPedidoProdutoAndPopula;

    btnGravar.Visible := Length(PedidoAtualProdutos) >= 2;
  end;
end;

end.
