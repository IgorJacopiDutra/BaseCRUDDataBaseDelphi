program BaseCRUDDataBaseDelphi;

uses
  Vcl.Forms,
  uPrincipal in 'View\uPrincipal.pas' {frmPrincipal},
  uClienteModel in 'model\uClienteModel.pas',
  uClienteController in 'controller\uClienteController.pas',
  uDM in 'dao\uDM.pas' {DM: TDataModule},
  uDMCliente in 'dao\uDMCliente.pas' {DMCliente: TDataModule},
  uBase in 'view\uBase.pas' {frmBase},
  uCliente in 'view\uCliente.pas' {frmCliente},
  uUsuario in 'view\uUsuario.pas' {frmUsuario},
  uUsuarioController in 'controller\uUsuarioController.pas',
  uUsuarioModel in 'model\uUsuarioModel.pas',
  uDMUsuario in 'dao\uDMUsuario.pas' {DMUsuario: TDataModule},
  uToolsRTTI in 'uToolsRTTI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDMCliente, DMCliente);
  Application.CreateForm(TfrmBase, frmBase);
  Application.CreateForm(TfrmUsuario, frmUsuario);
  Application.CreateForm(TDMUsuario, DMUsuario);
  Application.Run;
end.
