object DMUsuario: TDMUsuario
  OldCreateOrder = False
  Height = 481
  Width = 556
  object qrySearch: TFDQuery
    Connection = DM.con
    SQL.Strings = (
      'SELECT *'
      'FROM USUARIOS'
      'WHERE nome like :nome'
      'or telefone like :telefone')
    Left = 24
    Top = 16
    ParamData = <
      item
        Name = 'NOME'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TELEFONE'
        DataType = ftString
        ParamType = ptInput
        Size = 10
      end>
    object qrySearchID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrySearchNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 80
    end
    object qrySearchTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 10
    end
  end
  object qryInsert: TFDQuery
    Connection = DM.con
    SQL.Strings = (
      'INSERT INTO usuarios (id, nome, telefone)'
      'VALUES (:id, :nome, :telefone);')
    Left = 80
    Top = 16
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'NOME'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TELEFONE'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qryUpdate: TFDQuery
    Connection = DM.con
    SQL.Strings = (
      'UPDATE USUARIOS'
      'set nome = :nome'
      ',telefone = :telefone'
      'WHERE id = :id;')
    Left = 136
    Top = 16
    ParamData = <
      item
        Name = 'NOME'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TELEFONE'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object qryDelete: TFDQuery
    Connection = DM.con
    SQL.Strings = (
      'DELETE FROM USUARIOS WHERE ID = :ID')
    Left = 184
    Top = 16
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object dspSearch: TDataSetProvider
    DataSet = qrySearch
    Left = 24
    Top = 72
  end
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
    object cdsSearchTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 10
    end
  end
  object qryGerarID: TFDQuery
    Connection = DM.con
    SQL.Strings = (
      'SELECT COALESCE(MAX(ID),1) + 1 AS SEQ FROM USUARIOS')
    Left = 232
    Top = 16
    object qryGerarIDSEQ: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'SEQ'
      Origin = 'SEQ'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object qryLoad: TFDQuery
    Connection = DM.con
    SQL.Strings = (
      'SELECT *'
      'FROM USUARIOS'
      'WHERE id = :id')
    Left = 288
    Top = 16
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object IntegerField1: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object StringField1: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 80
    end
    object StringField4: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 10
    end
  end
end
