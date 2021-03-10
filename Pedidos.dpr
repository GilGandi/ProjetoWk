program Pedidos;

uses
  Vcl.Forms,
  ufrmPedidos in 'ufrmPedidos.pas' {FrmPedidos},
  udm in 'udm.pas' {dm},
  untFuncoes in 'untFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;

  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFrmPedidos, FrmPedidos);
  FrmPedidos.ShowModal;
end.
