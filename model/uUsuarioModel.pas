unit uUsuarioModel;

interface

type
   TUsuarioModel = class
   private
      FID: Integer;
      FTpDocto: string;
      FDocto: string;
      FNome: string;
      FTelefone: string;
      procedure setNome(const Value: string);
   public
      property ID: Integer read FID write FID;
      property Nome: string read FNome write setNome;
      property Telefone: string read FTelefone write FTelefone;
   end;

implementation

uses
   System.SysUtils;

{ TUsuario }

procedure TUsuarioModel.setNome(const Value: string);
begin
   if Value = EmptyStr then
      raise EArgumentException.Create('''Nome'' precisa ser preenchido.');

   FNome := Value;
end;

end.

