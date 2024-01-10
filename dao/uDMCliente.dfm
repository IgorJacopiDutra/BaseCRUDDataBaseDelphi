object DMCliente: TDMCliente
  OldCreateOrder = False
  Height = 286
  Width = 455
  object cdsSearch: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSearch'
    Left = 24
    Top = 128
    object cdsSearchID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsSearchNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 80
    end
    object cdsSearchTPDOCTO: TStringField
      FieldName = 'TPDOCTO'
      Origin = 'TPDOCTO'
      Size = 1
    end
    object cdsSearchDOCTO: TStringField
      FieldName = 'DOCTO'
      Origin = 'DOCTO'
      Size = 15
    end
    object cdsSearchTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 10
    end
  end
end
