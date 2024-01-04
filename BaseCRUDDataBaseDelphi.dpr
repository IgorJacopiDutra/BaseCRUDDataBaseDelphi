program BaseCRUDDataBaseDelphi;

uses
  Vcl.Forms,
  uPrincipal in 'View\uPrincipal.pas' {frmPrincipal},
  uClienteModel in 'model\uClienteModel.pas',
  uClienteController in 'controller\uClienteController.pas',
  uDM in 'dao\uDM.pas' {DM: TDataModule},
  uDMCliente in 'dao\uDMCliente.pas' {DMCliente: TDataModule},
  uBase in 'view\uBase.pas' {frmBase},
  uUsuario in 'view\uUsuario.pas' {frmUsuario},
  uCliente in 'view\uCliente.pas' {frmCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDMCliente, DMCliente);
  Application.CreateForm(TfrmBase, frmBase);
  Application.Run;
end.
