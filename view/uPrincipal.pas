unit uPrincipal;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Vcl.StdCtrls;

type
   TfrmPrincipal = class(TForm)
      btnCliente: TButton;
      procedure btnClienteClick(Sender: TObject);
   private
    { Private declarations }
      procedure OpenCliente();
   public
    { Public declarations }
   end;

var
   frmPrincipal: TfrmPrincipal;

implementation

uses
   uCliente;

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

procedure TfrmPrincipal.OpenCliente;
begin

end;

end.

