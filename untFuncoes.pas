unit untFuncoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.StdCtrls, StrUtils;

/// <summary> Rotina genérica para limpar todos os TEdits que estão dentro do panel informado</summary>
procedure limpaEdits(PanelDosEdits:TPanel);
/// <summary> Rotina genérica para alterar o status (enabled) de todos os TEdits que estão dentro do panel informado</summary>
procedure alteraEstadoEdits(PanelDosEdits:TPanel; vStatus: boolean);
/// <summary> Rotina genérica ir para o próximo componente se o Enter foi apertado</summary>
///  <param name="Sender">Sender do componente que chamou o evento</param>
///  <param name="Key">Tecla que foi pressionadaa</param>
procedure navegaProximoComponente(Sender: TObject; var Key: Char);
/// <summary> Rotina genérica para garantir que o edit fique com valor válido de float</summary>
procedure validaCampoFloat(Sender: TObject; var Key: Char);
/// <summary> Formata campo float com quantidade de casas informadas </summary>
procedure formataCampo(Sender: TObject;vQtdDecimais: integer = 2); overload;
/// <summary> Formata campo float com quantidade de casas informadas </summary>
procedure formataCampo(var vCampo: string;vQtdDecimais: integer = 2); overload;
/// <summary> Remove todas as linhas do StringGrid, deixando apenas o cabeçalho </summary>
/// <remarks> Necessário pois se existir valores nas colunas o rowCount não funciona </remarks>
procedure limparStringGrid(grid: TStringGrid);
/// <summary> Valida se os campos habilitados foram preenchidos </summary>
/// <remarks> Campo não pode ser vazio e nem 0 </remarks>
function validaPreenchimentoCampos(PanelComComponentes: TPanel): boolean;
/// <summary> Todo Edit tem um Label no mesmo left. Esta função retorna o label do left informado </summary>
function capturaLabelPeloLeft(PanelComComponentes: TPanel; vLeft:Integer): String;
/// <summary> Recebe um TDateTime e retorna formatado para uso no MySQL</summary>
function converterDateTimeParaMYSQL(DataBrasil: TDateTime):string;

implementation

//Limpa edits inserindo campo vazio
procedure limpaEdits(PanelDosEdits:TPanel);
var
  I: Integer;
begin
  //Faz a limpeza de todos os edits
  for I := 0 to PanelDosEdits.ControlCount - 1 do
    if PanelDosEdits.Controls[I] is TEdit then
      TEdit(PanelDosEdits.Controls[I]).Text := EmptyStr;
end;

//Altera para permitir alterar campos (ou não) conforme parametro
procedure alteraEstadoEdits(PanelDosEdits:TPanel; vStatus: boolean);
var
  I: Integer;
begin
  //Primeiro faz a limpeza de todos os edits
  for I := 0 to PanelDosEdits.ControlCount - 1 do
    if PanelDosEdits.Controls[I] is TEdit then
      if not TEdit(PanelDosEdits.Controls[I]).ReadOnly then //Se está como readOnly é campo que não pode ser editado
        TEdit(PanelDosEdits.Controls[I]).Enabled := vStatus;
end;

procedure navegaProximoComponente(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    SendMessage(TForm(TEdit(Sender).Owner).Handle, WM_NEXTDLGCTL, 0, 0 );
    Key := #0;
  end;
end;

procedure validaCampoFloat(Sender: TObject; var Key: Char);
begin
  navegaProximoComponente(Sender,Key); //Chama primeiro esta rotina para que se for enter não tenha mais nada a tratar

  //Se for enter vai definir como #0 na rotina acima
  if Key=#0 then
    Exit;

  //Rotina só preparada para edit no momento
  if not (Sender is TEdit) then
    Exit;

  //Se digitar ponto considera como virgula
  if Key = '.' then
    Key := ',';

  //Se está sendo digitada uma virgula, valida para não deixar inserir 2 virgulas
  if Key = ',' then
  begin
    if ContainsText(Tedit(Sender).Text,',') then
      Key := #0;
  end
  else
    //0-9,VK_ESCAPE,VK_BACK,VK_DELETE,VK_RIGHT,VK_LEFT
    if not (Key in ['0'..'9',#27,#8,#46,#39,#37]) then
      Key := #0;

end;

procedure formataCampo(Sender: TObject;vQtdDecimais: integer = 2);
var
  formatado: string;
begin
  //Rotina só preparada para edit no momento
  if not (Sender is TEdit) then
    Exit;

  formatado :=  TEdit(Sender).Text;

  formataCampo(formatado,vQtdDecimais);

  TEdit(Sender).Text := formatado;
end;

procedure formataCampo(var vCampo: string;vQtdDecimais: integer = 2);
var
  vFormato:string;
  I: Integer;
begin
  if vCampo = EmptyStr then
    vCampo := '0';

  if vQtdDecimais<=0 then
    vFormato := '0'
  else
  begin
    //Adiciona quantidade de zeros
    for I := 1 to vQtdDecimais do
      vFormato := vFormato + '0';
    //Adiciona inicio da formatação
      vFormato := '0.'+vFormato;
  end;

  vCampo := FormatFloat(vFormato,StrToFloat(vCampo));

end;

procedure limparStringGrid(grid: TStringGrid);
var
  I: Integer;
begin

  //Se está no cabeçalho já está tudo limpo
  while grid.Row>=1 do
  begin
    //Vai para ultima linha
    grid.Row := grid.RowCount-1;

    for I := 0 to grid.ColCount-1 do
      grid.Cells[I,grid.Row] := EmptyStr;

    //Diminui linha que acabou de limpar
    grid.RowCount := grid.RowCount -1;
  end;
end;

function validaPreenchimentoCampos(PanelComComponentes: TPanel): boolean;
var
  I: Integer;
  vFloatTmp: double;
begin
  for I := 0 to PanelComComponentes.ControlCount-1 do
    if PanelComComponentes.Controls[I] is TEdit then
      if TEdit(PanelComComponentes.Controls[I]).Enabled then
        if Trim(TEdit(PanelComComponentes.Controls[I]).Text).IsEmpty OR (TryStrToFloat(TEdit(PanelComComponentes.Controls[I]).Text,vFloatTmp) and (vFloatTmp<=0)) then
        begin
          TEdit(PanelComComponentes.Controls[I]).SetFocus;
          ShowMessage('Você precisa informar dado para o campo '+capturaLabelPeloLeft(PanelComComponentes,TEdit(PanelComComponentes.Controls[I]).Left));
          Result := False;
          Exit;
        end;

  //Se chegou aqui validação ocorreu com sucesso
  Result := True;
end;

function capturaLabelPeloLeft(PanelComComponentes: TPanel; vLeft:Integer): String;
var
  I: Integer;
begin
  for I := 0 to PanelComComponentes.ControlCount-1 do
    if PanelComComponentes.Controls[I] is TLabel then
      if TLabel(PanelComComponentes.Controls[I]).Left = vLeft then
      begin
        //Retorna o label encontrado
        Result := TLabel(PanelComComponentes.Controls[I]).Caption;
        Exit;
      end;

end;

function converterDateTimeParaMYSQL(DataBrasil: TDateTime):string;
begin
   Result := FormatDateTime('yyyy-mm-dd hh:nn:ss',DataBrasil);
end;


end.
