unit uClienteController;

interface

uses
   uClienteModel;

type
   TClienteController = class
   public
      constructor Create();
      destructor Destroy();
      procedure Search(value: string; out sError: string);
      procedure Load(out cliente: TClienteModel; id: integer; out sError: string);
      function Insert(cliente: TClienteModel; out sError: string): Boolean;
      function Update(cliente: TClienteModel; out sError: string): Boolean;
      function Delete(id: Integer; out sError: string): Boolean;
   end;

implementation

uses
   uDMCliente, System.SysUtils;

{ TClienteController }


{ TClienteController }

constructor TClienteController.Create;
begin
   //DMCliente := TDMCliente.Create(nil);
end;

function TClienteController.Delete(id: Integer; out sError: string): Boolean;
begin
   result := DMCliente.Delete(id, sError);
end;

destructor TClienteController.Destroy;
begin
   //FreeAndNil(DMCliente);
end;

function TClienteController.Insert(cliente: TClienteModel; out sError: string): Boolean;
begin
   result := DMCliente.Insert(cliente, sError);
end;

procedure TClienteController.Load(out cliente: TClienteModel; id: integer; out sError: string);
begin
   DMCliente.Load(cliente, id, sError);
end;

procedure TClienteController.Search(value: string; out sError: string);
begin
   DMCliente.Search(value, sError);
end;

function TClienteController.Update(cliente: TClienteModel; out sError: string): Boolean;
begin
   result := DMCliente.Update(cliente, sError);
end;

end.

