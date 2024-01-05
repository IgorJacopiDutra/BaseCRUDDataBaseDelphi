unit uUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBase, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, uUsuarioModel, uUsuarioController, uDMUsuario;

type
  TfrmUsuario = class(TfrmBase)
    lbledtNome: TLabeledEdit;
    lbledtTelefone: TLabeledEdit;
    procedure sbDetailClick(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure sbEditClick(Sender: TObject);
    procedure gdrListDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    oUsuario: TUsuarioModel;
      oUsuarioController: TUsuarioController;
    procedure Detail;
    procedure Gravar;
    procedure Load;
    procedure Search;
    procedure toNew;
    procedure toAlter;
    procedure Initialized;
    procedure Delete;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuario: TfrmUsuario;

implementation

{$R *.dfm}

procedure TfrmUsuario.sbDeleteClick(Sender: TObject);
begin
   Delete;
  inherited;

end;

procedure TfrmUsuario.Delete;
var
   sError: string;
begin
   if (DMUsuario.cdsSearch.Active) and (DMUsuario.cdsSearch.RecordCount > 0) then
   begin
      if MessageDlg('Deseja realmente excluir este Usuario', mtConfirmation, [mbYes, mbNo], 0) = IdYes then
         if (oUsuarioController.Delete(DMUsuario.cdsSearchID.AsInteger, sError)) = true then
         begin
            showmessage('Excluído com sucesso');
         end
         else
         begin
            raise Exception.Create(sError);
         end;
      oUsuarioController.Search(lbledtSearch.Text);
   end
   else
      raise Exception.Create('Não há registro para ser excluído');
end;

procedure TfrmUsuario.sbDetailClick(Sender: TObject);
begin
   Detail;
  inherited;

end;


procedure TfrmUsuario.sbEditClick(Sender: TObject);
begin
   Detail;
  inherited;

end;

procedure TfrmUsuario.sbSaveClick(Sender: TObject);
begin
  inherited;
   Gravar;
end;

procedure TfrmUsuario.Detail;
begin
   Load;
end;

procedure TfrmUsuario.FormCreate(Sender: TObject);
begin
  inherited;
   Initialized();
end;

procedure TfrmUsuario.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(oUsuario);
   FreeAndNil(oUsuarioController);
end;

procedure TfrmUsuario.FormShow(Sender: TObject);
begin
  inherited;
   Search;
end;

procedure TfrmUsuario.gdrListDblClick(Sender: TObject);
begin
     Detail;
  inherited;

end;

procedure TfrmUsuario.Initialized;
begin
   oUsuario := TUsuarioModel.Create;
   oUsuarioController := TUsuarioController.Create;
   DesignOperation(opSearch);
end;

procedure TfrmUsuario.Gravar;
begin
   try
      case FOperation of
         opNew:
            toNew;
         opAlter:
            toAlter;
      end;
      oUsuarioController.Search(lbledtSearch.Text);
   except
      on E: Exception do


   end;

   ClearFields();
   if FOperation = opNew then
   begin
      if MessageDlg('Salvo com sucesso. Deseja incluir mais?', mtConfirmation, [mbYes, mbNo], 0) = IdYes then
         DesignOperation(opNew)
      else
      begin
         DesignOperation(opSearch);
         Search;
      end;
   end
   else
   begin
      showmessage('Editado com sucesso');
      DesignOperation(opSearch);
      Search;
   end;
end;

procedure TfrmUsuario.Load;
var
   UsuarioID: Integer;
begin
   UsuarioID := dsSearch.dataset.FieldByName('ID').AsInteger;
   oUsuarioController.Load(oUsuario, UsuarioID);
   if Assigned(oUsuario) then
   begin
      lbledtCodigo.Text := oUsuario.ID.ToString;
      lbledtNome.Text := oUsuario.Nome;
      lbledtTelefone.Text := oUsuario.Telefone;
   end;
end;

procedure TfrmUsuario.Search;
begin
   oUsuarioController.Search(lbledtSearch.Text);
end;

procedure TfrmUsuario.toNew;
var
   sError: string;
begin
   with oUsuario do
   begin
      ID := 0;
      Nome := lbledtNome.Text;
      Telefone := lbledtTelefone.Text;
   end;
   if (oUsuarioController.Insert(oUsuario, sError)) = false then
      raise Exception.Create(sError);
end;

procedure TfrmUsuario.toAlter;
var
   sError: string;
begin
   with oUsuario do
   begin
      ID := StrToIntDef(lbledtCodigo.text, 0);
      Nome := lbledtNome.Text;
      Telefone := lbledtTelefone.Text;
   end;
   if not oUsuarioController.Update(oUsuario, sError) then
      raise Exception.Create(sError);
end;

end.
