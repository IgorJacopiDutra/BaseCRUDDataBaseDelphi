unit uUsuarioController;

interface

uses
   uUsuarioModel;

type
   TUsuarioController = class
   public
      constructor Create();
      destructor Destroy();
      procedure Search(value: string);
      procedure Load(Usuario: TUsuarioModel; id: integer);
      function Insert(Usuario: TUsuarioModel; out sError: string): Boolean;
      function Update(Usuario: TUsuarioModel; out sError: string): Boolean;
      function Delete(id: Integer; out sError: string): Boolean;
   end;

implementation

uses
   uDMUsuario, System.SysUtils;

{ TUsuarioController }


{ TUsuarioController }

constructor TUsuarioController.Create;
begin
   //DMUsuario := TDMUsuario.Create(nil);
end;

function TUsuarioController.Delete(id: Integer; out sError: string): Boolean;
begin
   result := DMUsuario.Delete(id, sError);
end;

destructor TUsuarioController.Destroy;
begin
   //FreeAndNil(DMUsuario);
end;

function TUsuarioController.Insert(Usuario: TUsuarioModel; out sError: string): Boolean;
begin
   result := DMUsuario.Insert(Usuario, sError);
end;

procedure TUsuarioController.Load(Usuario: TUsuarioModel; id: integer);
begin
   DMUsuario.Load(Usuario, id);
end;

procedure TUsuarioController.Search(value: string);
begin
   DMUsuario.Search(value);
end;

function TUsuarioController.Update(Usuario: TUsuarioModel; out sError: string): Boolean;
begin
   result := DMUsuario.Update(Usuario, sError);
end;

end.

