unit uPrincipal;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Vcl.StdCtrls, FireDAC.Phys.FBDef, FireDAC.Stan.Intf, FireDAC.Phys,
   FireDAC.Phys.IBBase, FireDAC.Phys.FB;

type
   TfrmPrincipal = class(TForm)
      btnCliente: TButton;
      FDPhysFBDriverLink1: TFDPhysFBDriverLink;
      btnUsuario: TButton;
      procedure btnClienteClick(Sender: TObject);
      procedure btnUsuarioClick(Sender: TObject);
   private
    { Private declarations }
   public
    { Public declarations }
   end;

var
   frmPrincipal: TfrmPrincipal;

implementation

uses
   uCliente, uUsuario;

{$R *.dfm}

procedure TfrmPrincipal.btnClienteClick(Sender: TObject);
begin
   frmCliente := TfrmCliente.Create(nil);
   try
      frmCliente.ShowModal;
   finally
      FreeAndNil(frmCliente);
   end;

end;

procedure TfrmPrincipal.btnUsuarioClick(Sender: TObject);
begin
   frmUsuario := TfrmUsuario.Create(nil);
   try
      frmUsuario.ShowModal;
   finally
      FreeAndNil(frmUsuario);
   end;

end;

end.

