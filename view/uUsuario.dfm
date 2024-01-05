inherited frmUsuario: TfrmUsuario
  Caption = 'Usu'#225'rio'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pcMain: TPageControl
    ActivePage = tsSearch
    inherited tsSearch: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 705
      ExplicitHeight = 416
      inherited pnSearch: TPanel
        inherited pnList: TPanel
          inherited gdrList: TDBGrid
            DataSource = dsSearch
          end
        end
      end
    end
    inherited tsData: TTabSheet
      inherited pnData: TPanel
        object lbledtNome: TLabeledEdit
          Left = 8
          Top = 68
          Width = 393
          Height = 21
          EditLabel.Width = 27
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome'
          TabOrder = 1
        end
        object lbledtTelefone: TLabeledEdit
          Left = 271
          Top = 112
          Width = 121
          Height = 21
          EditLabel.Width = 42
          EditLabel.Height = 13
          EditLabel.Caption = 'Telefone'
          TabOrder = 2
        end
      end
      inherited pnSaveOrCancel: TPanel
        inherited sbSave: TSpeedButton
          OnClick = sbSaveClick
        end
      end
    end
  end
  inherited dsSearch: TDataSource
    DataSet = DMUsuario.cdsSearch
  end
end
