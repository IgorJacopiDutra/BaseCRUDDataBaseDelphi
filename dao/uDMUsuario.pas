unit uDMUsuario;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  Datasnap.DBClient, Datasnap.Provider, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uUsuarioModel;

type
  TDMUsuario = class(TDataModule)
    qrySearch: TFDQuery;
    qrySearchID: TIntegerField;
    qrySearchNOME: TStringField;
    qrySearchTELEFONE: TStringField;
    qryInsert: TFDQuery;
    qryUpdate: TFDQuery;
    qryDelete: TFDQuery;
    dspSearch: TDataSetProvider;
    cdsSearch: TClientDataSet;
    cdsSearchID: TIntegerField;
    cdsSearchNOME: TStringField;
    cdsSearchTELEFONE: TStringField;
    qryGerarID: TFDQuery;
    qryGerarIDSEQ: TLargeintField;
    qryLoad: TFDQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField4: TStringField;
  private
    procedure ExibirPropriedades(const Usuario: TUsuarioModel);

  public
    function Delete(id: Integer; out error: string): Boolean;
    function GetID: Integer;
    function Insert(Usuario: TUsuarioModel; out error: string): Boolean;
    procedure Load(Usuario: TUsuarioModel; iId: integer);
    procedure Search(value: string);
    function Update(Usuario: TUsuarioModel; out error: string): Boolean;
    { Private declarations }

    { Public declarations }
  end;

var
  DMUsuario: TDMUsuario;

implementation

uses
  System.Rtti;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


function TDMUsuario.Delete(id: Integer; out error: string): Boolean;
begin
   with qryDelete do
   begin
      Close;
      ParamByName('ID').AsInteger := id;
      try
         ExecSQL;
         result := true;
      except
         on E: Exception do
         begin
            error := e.Message;
            result := false;
         end;
      end;
   end;
end;

function TDMUsuario.GetID: Integer;
begin
   with qryGerarID do
   begin
      Close;
      Open;
      result := FieldByName('SEQ').AsInteger;
      Close;
   end;
end;

function TDMUsuario.Insert(Usuario: TUsuarioModel; out error: string): Boolean;
begin
   with qryInsert, Usuario do
   begin
      Close;
      ParamByName('ID').AsInteger := GetID;
      ParamByName('Nome').AsString := Nome;
      ParamByName('Telefone').AsString := Telefone;
      try
         ExecSQL;
         result := true;
      except
         on E: Exception do
         begin
            error := e.Message;
            result := false;
         end;
      end;

   end;
end;

procedure TDMUsuario.Load(Usuario: TUsuarioModel; iId: integer);
begin
   with qryLoad, Usuario do
   begin
      Close;
      ParamByName('ID').AsInteger := iId;
      Open;

      id := FieldByName('ID').AsInteger;
      Nome := FieldByName('Nome').AsString;
      Telefone := FieldByName('Telefone').AsString;
   end;
end;

procedure TDMUsuario.Search(value: string);
var
   i: Integer;
begin
   with qrySearch do
   begin
      if Active then
         Close;

      for i := 0 to Params.Count - 1 do
         Params[i].AsString := '%' + value + '%';

      Open;
      First;
   end;

   if cdsSearch.Active then
      cdsSearch.Close;

   cdsSearch.Active := True;
end;

function TDMUsuario.Update(Usuario: TUsuarioModel; out error: string): Boolean;
begin
   with qryUpdate, Usuario do
   begin
      Close;
      ParamByName('ID').AsInteger := id;
      ParamByName('Nome').AsString := Nome;
      ParamByName('Telefone').AsString := Telefone;
      try
         ExecSQL;
         result := true;
      except
         on E: Exception do
         begin
            error := e.Message;
            result := false;
         end;
      end;

   end;
end;

procedure TDMUsuario.ExibirPropriedades(const Usuario: TUsuarioModel);
var
  ctx: TRttiContext;
  prop: TRttiProperty;
  propValue: TValue;
begin
  ctx := TRttiContext.Create;

  try
    for prop in ctx.GetType(TUsuarioModel).GetProperties do
    begin
      // Verifica se a propriedade é legível
      if prop.IsReadable then
      begin
        propValue := prop.GetValue(Usuario);

        // Aqui, você pode usar prop.Name e propValue para acessar os nomes e valores das propriedades
        Writeln('Propriedade: ', prop.Name, ', Valor: ', propValue.ToString);
      end;
    end;
  finally
    ctx.Free;
  end;
end;


end.
