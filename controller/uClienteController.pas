unit uClienteController;

interface

uses
   uClienteModel;

type
   TClienteController = class
   public
      constructor Create();
      destructor Destroy();
      procedure Search(value: string);
      procedure Load(cliente: TClienteModel; id: integer);
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

procedure TClienteController.Load(cliente: TClienteModel; id: integer);
begin
   DMCliente.Load(cliente, id);
end;

procedure TClienteController.Search(value: string);
begin
   DMCliente.Search(value);
end;

function TClienteController.Update(cliente: TClienteModel; out sError: string): Boolean;
begin
   result := DMCliente.Update(cliente, sError);
end;

end.
