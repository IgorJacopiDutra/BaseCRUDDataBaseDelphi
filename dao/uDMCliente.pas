unit uDMCliente;

interface

uses
   System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Datasnap.DBClient,
   Datasnap.Provider, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
   uClienteModel, System.Rtti;

type
  ColumnAttribute = class(TCustomAttribute)
  end;
type
   TDMCliente = class(TDataModule)
      qrySearch: TFDQuery;
      qryInsert: TFDQuery;
      qryUpdate: TFDQuery;
      qryDelete: TFDQuery;
      dspSearch: TDataSetProvider;
      cdsSearch: TClientDataSet;
      qrySearchID: TIntegerField;
      qrySearchNOME: TStringField;
      qrySearchTPDOCTO: TStringField;
      qrySearchDOCTO: TStringField;
      qrySearchTELEFONE: TStringField;
      cdsSearchID: TIntegerField;
      cdsSearchNOME: TStringField;
      cdsSearchTPDOCTO: TStringField;
      cdsSearchDOCTO: TStringField;
      cdsSearchTELEFONE: TStringField;
      qryGerarID: TFDQuery;
      qryGerarIDSEQ: TLargeintField;
      qryLoad: TFDQuery;
      IntegerField1: TIntegerField;
      StringField1: TStringField;
      StringField2: TStringField;
      StringField3: TStringField;
      StringField4: TStringField;
   private
    function Update<T>(obj: T; out error: string): Boolean; overload;
    { Private declarations }
   public
    { Public declarations }
      function GetID(): Integer;
      procedure Search(value: string);
      procedure Load(cliente: TClienteModel; iId: integer);
      function Insert(cliente: TClienteModel; out error: string): Boolean;
      function Update(cliente: TClienteModel; out error: string): Boolean; overload;
      function Delete(id: Integer; out error: string): Boolean;
   end;

var
   DMCliente: TDMCliente;

implementation

uses
   uDM;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMCliente }

function TDMCliente.Delete(id: Integer; out error: string): Boolean;
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

function TDMCliente.GetID: Integer;
begin
   with qryGerarID do
   begin
      Close;
      Open;
      result := FieldByName('SEQ').AsInteger;
      Close;
   end;
end;

function TDMCliente.Insert(cliente: TClienteModel; out error: string): Boolean;
begin
   with qryInsert, cliente do
   begin
      Close;
      ParamByName('ID').AsInteger := GetID;
      ParamByName('Nome').AsString := Nome;
      ParamByName('TpDocto').AsString := TpDocto;
      ParamByName('Docto').AsString := Docto;
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

procedure TDMCliente.Load(cliente: TClienteModel; iId: integer);
begin
   with qryLoad, cliente do
   begin
      Close;
      ParamByName('ID').AsInteger := iId;
      Open;

      id := FieldByName('ID').AsInteger;
      Nome := FieldByName('Nome').AsString;
      TpDocto := FieldByName('TpDocto').AsString;
      Docto := FieldByName('Docto').AsString;
      Telefone := FieldByName('Telefone').AsString;
   end;
end;

procedure TDMCliente.Search(value: string);
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

function TDMCliente.Update(cliente: TClienteModel; out error: string): Boolean;
begin
   with qryUpdate, cliente do
   begin
      Close;
      ParamByName('ID').AsInteger := id;
      ParamByName('Nome').AsString := Nome;
      ParamByName('TpDocto').AsString := TpDocto;
      ParamByName('Docto').AsString := Docto;
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
function TDMCliente.Update<T>(obj: T; out error: string): Boolean;
var
  ctx: TRttiContext;
  prop: TRttiProperty;
  attr: TCustomAttribute;
  propValue:TValue;
begin

end;

end.

