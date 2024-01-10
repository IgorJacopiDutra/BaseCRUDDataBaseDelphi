unit uDMCliente;

interface

uses
   System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
   FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Datasnap.DBClient,
   Datasnap.Provider, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
   uClienteModel, System.Rtti, uClienteReq;

type
   ColumnAttribute = class(TCustomAttribute)
   end;

type
   TDMCliente = class(TDataModule)
      cdsSearch: TClientDataSet;
      cdsSearchID: TIntegerField;
      cdsSearchNOME: TStringField;
      cdsSearchTPDOCTO: TStringField;
      cdsSearchDOCTO: TStringField;
      cdsSearchTELEFONE: TStringField;
   private
      function Update<T>(obj: T; out error: string): Boolean; overload;
    { Private declarations }
   public
    { Public declarations }
      clienteReq: TclienteReq;
      procedure Search(value: string; out error: string);
      procedure Load(cliente: TClienteModel; iId: integer; out error: string);
      function Insert(cliente: TClienteModel; out error: string): Boolean;
      function Update(cliente: TClienteModel; out error: string): Boolean; overload;
      function Delete(id: Integer; out error: string): Boolean;
   end;

var
   DMCliente: TDMCliente;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMCliente }

function TDMCliente.Delete(id: Integer; out error: string): Boolean;
var
   clienteReq: TclienteReq;
begin
   clienteReq := TclienteReq.Create;
   try
      clienteReq.Delete(id, error);
   finally
      clienteReq.Free;
   end;
end;

function TDMCliente.Insert(cliente: TClienteModel; out error: string): Boolean;
var
   clienteReq: TclienteReq;
   reqContent: TStringStream;
begin
   clienteReq := TclienteReq.Create;
   try
      clienteReq.Post(cliente, error);
   finally
      clienteReq.Free;
   end;
end;

procedure TDMCliente.Load(cliente: TClienteModel; iId: integer; out error: string);
var
   clienteReq: TclienteReq;
   reqContent: TStringStream;
   clientes: TArray<TClienteModel>;
   i: Integer;
begin
   clienteReq := TclienteReq.Create;
   try
      clientes := clienteReq.Get(iId, '', error);
      for i := 0 to High(clientes) do
      begin
         cliente := clientes[i];
      end;
   finally
      FreeAndNil(clienteReq);
   end;
end;

procedure TDMCliente.Search(value: string; out error: string);
var
   clienteReq: TclienteReq;
   reqContent: TStringStream;
   clientes: TArray<TClienteModel>;
   i: Integer;
begin
   clienteReq := TclienteReq.Create;
   try
      clientes := clienteReq.Get(0, value, error);
      for i := 0 to High(clientes) do
      begin
         cdsSearch.Insert;
         cdsSearchID.AsInteger := clientes[i].id;
         cdsSearchNOME.AsString := clientes[i].Nome;
         cdsSearchTPDOCTO.AsString := clientes[i].TpDocto;
         cdsSearchDOCTO.AsString := clientes[i].Docto;
         cdsSearchTELEFONE.AsString := clientes[i].Telefone;
      end;
   finally
      FreeAndNil(clienteReq);
   end;

   if cdsSearch.Active then
      cdsSearch.Close;

   cdsSearch.Active := True;
end;

function TDMCliente.Update(cliente: TClienteModel; out error: string): Boolean;
var
   clienteReq: TclienteReq;
   reqContent: TStringStream;
begin
   clienteReq := TclienteReq.Create;
   try
      clienteReq.Put(cliente, error);
   finally
      clienteReq.Free;
   end;
end;

function TDMCliente.Update<T>(obj: T; out error: string): Boolean;
var
   ctx: TRttiContext;
   prop: TRttiProperty;
   attr: TCustomAttribute;
   propValue: TValue;
begin

end;

end.

