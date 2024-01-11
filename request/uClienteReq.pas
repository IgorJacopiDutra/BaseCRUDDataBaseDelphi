unit uClienteReq;

interface

uses
   System.SysUtils, System.JSON, IdHTTP, System.Classes, uClienteModel,
   REST.Json;

type
   TClienteReq = class
   private
      function PerformHTTPRequest(const URL, UserName, Password, RequestMethod: string; out sError: string; RequestContent: TStream = nil): TJSONArray;
   public
      function Delete(id: Integer; out sError: string): Boolean;
      function Post(cliente: TClienteModel; out sError: string): Boolean;
      function Put(cliente: TClienteModel; out sError: string): Boolean;
      function Get(iId: integer; search: string; out sError: string): TArray<TClienteModel>;
   end;

const
   userServer = 'ADMIN';
   passServer = '123456';
   URL = 'http://LOCALHOST:8080/datasnap/rest/';
   Resource = 'TClienteControl/Cliente';

implementation

{ TClienteReq }

function TClienteReq.Delete(id: Integer; out sError: string): Boolean;
var
   endpoint: string;
   JsonArray: TJSONArray;

   procedure validFiels();
   begin
      if id.ToString() = '' then
      begin
         sError := 'Informar o ID';
      end;
   end;

begin
   validFiels();

   if sError = '' then
   begin
      endpoint := URL + Resource + '/' + id.ToString();

      try
         JsonArray := PerformHTTPRequest(endpoint, userServer, passServer, 'DELETE', sError);
         result := sError = '';
      except
         on E: Exception do
         begin
            sError := E.Message;
         end;
      end;
   end;
end;

function TClienteReq.Get(iId: integer; search: string; out sError: string): TArray<TClienteModel>;
var
   endpoint: string;
   JsonArray: TJSONArray;
   I, j: Integer;
   cli: TClienteModel;
   Clientes: TArray<TClienteModel>;
   clientesValue: TJSONValue;

   function validFiels(): Boolean;
   begin
      result := true;
   end;

begin
   validFiels();
   endpoint := URL + Resource;

   try
      if iId.ToString() <> '' then
         endpoint := endpoint + '?' + 'id=' + iId.ToString();

      if search <> '' then
         endpoint := endpoint + '?' + 'search=' + search;

      JsonArray := PerformHTTPRequest(endpoint, userServer, passServer, 'GET', sError);

      if JsonArray <> nil then
      begin
         SetLength(Clientes, JsonArray.Count);

         for I := 0 to JsonArray.Count - 1 do
         begin
            clientesValue := (JsonArray.Items[I] as TJSONObject).GetValue('cliente');

            if Assigned(clientesValue) then
            begin
               if clientesValue is TJSONArray then
               begin
                  if TJSONArray(clientesValue).Count > 0 then
                  begin
                     SetLength(Clientes, TJSONArray(clientesValue).Count);
                     for j := 0 to TJSONArray(clientesValue).Count - 1 do
                     begin
                        cli := TJson.JsonToObject<TClienteModel>(TJSONArray(clientesValue).Items[j].ToJSON);
                        Clientes[j] := cli;
                     end;
                  end
                  else
                  begin
                     sError := 'Array cliente vazio.';
                  end;
               end
               else if clientesValue is TJSONString then
               begin
                  sError := 'Valor de cliente como string: ' + (clientesValue as TJSONString).Value;
                  Continue;
               end
               else
               begin
                  sError := 'Valor inesperado para o campo cliente.';
               end;
            end
            else
            begin
               sError := 'Campo cliente não encontrado.';
            end;
         end;
      end;
   except
      on E: Exception do
      begin
         sError := E.Message;
      end;
   end;

   result := Clientes;
end;

function TClienteReq.PerformHTTPRequest(const URL, UserName, Password, RequestMethod: string; out sError: string; RequestContent: TStream = nil): TJSONArray;
var
   IdHTTP1: TIdHTTP;
   ResponseContent: string;
   JsonValue: TJSONValue;
   ResultArray: TJSONArray;
   ResultObject: TJSONObject;
   Detalhe: string;
   ResultValue: TJSONValue;
begin
   IdHTTP1 := TIdHTTP.Create(nil);

   try
      try
         with IdHTTP1 do
         begin
            ConnectTimeout := 10000;
            Request.Clear;
            Request.BasicAuthentication := True;
            Request.Username := UserName;
            Request.Password := Password;
         end;

         if Assigned(RequestContent) then
         begin
            if RequestMethod = 'PUT' then
               ResponseContent := IdHTTP1.Put(URL, RequestContent)
            else
               ResponseContent := IdHTTP1.Post(URL, RequestContent);
         end
         else if RequestMethod = 'DELETE' then
            ResponseContent := IdHTTP1.Delete(URL)
         else
         begin
            ResponseContent := IdHTTP1.Get(URL);
         end;

         JsonValue := TJSONObject.ParseJSONValue(ResponseContent);

         if Assigned(JsonValue) and (JsonValue is TJSONObject) then
         begin
            ResultArray := (JsonValue as TJSONObject).GetValue('result') as TJSONArray;

            if Assigned(ResultArray) then
            begin
               if ResultArray.Count > 0 then
               begin
                  ResultObject := ResultArray.Items[0] as TJSONObject;
                  if ResultObject.TryGetValue<TJSONValue>('result', ResultValue) then
                  begin
                     if ResultValue.TryGetValue<string>('detalhe', Detalhe) then
                     begin
                        sError := '';
                     end
                     else
                     begin
                        sError := 'Detalhe não encontrado no JSON.';
                     end;
                  end
                  else
                  begin
                     result := ResultArray;
                  end;
               end
               else
               begin
                  sError := 'Resposta inesperada do serviço - array vazio.';
               end;
            end
            else
            begin
               sError := 'Resposta inesperada do serviço - "result" não encontrado.';
            end;
         end
         else
         begin
            sError := 'Erro na solicitação: ' + IdHTTP1.ResponseText;
         end;
      except
         on E: Exception do
         begin
            sError := 'Erro: ' + E.Message;
         end;
      end;
   finally
      IdHTTP1.Free;
   end;
end;

function TClienteReq.Post(cliente: TClienteModel; out sError: string): Boolean;
var
   endpoint: string;
   RequestContent: TStringStream;
   JsonArray: TJSONArray;
begin
   if cliente.nome = '' then
   begin
      sError := 'Informar o Nome';
   end;

   if sError = '' then
   begin
      endpoint := URL + Resource;
      RequestContent := TStringStream.Create('{"nome":"' + cliente.Nome + '","tpdocto":"' + cliente.TpDocto + '","docto":"' + cliente.Docto + '","telefone":"' + cliente.Telefone + '"}', TEncoding.UTF8);

      try
         JsonArray := PerformHTTPRequest(endpoint, userServer, passServer, 'POST', sError, RequestContent);
      except
         on E: Exception do
         begin
            sError := E.Message;
         end;
      end;

      RequestContent.Free;
   end;
end;

function TClienteReq.Put(cliente: TClienteModel; out sError: string): Boolean;
var
   endpoint: string;
   RequestContent: TStringStream;
   JsonArray: TJSONArray;

   procedure validFiels();
   begin
      if cliente.ID.ToString() = '' then
      begin
         sError := 'Informar o ID';
      end;
   end;

begin
   validFiels();
   endpoint := URL + Resource + '/' + cliente.ID.ToString;
   RequestContent := TStringStream.Create('{"nome":"' + cliente.Nome + '","tpdocto":"' + cliente.TpDocto + '","docto":"' + cliente.Docto + '","telefone":"' + cliente.Telefone + '"}', TEncoding.UTF8);

   try
      JsonArray := PerformHTTPRequest(endpoint, userServer, passServer, 'PUT', sError, RequestContent);
   except
      on E: Exception do
      begin
         sError := E.Message;
      end;
   end;

   RequestContent.Free;
end;

end.

