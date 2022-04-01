object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 308
  Width = 414
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Israel.Junior\Teste Siagri\Desafio_Delphi_02\data\de' +
        'safio_delphi_02.GDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 192
    Top = 136
  end
  object Driver_Firebird: TFDPhysFBDriverLink
    VendorHome = 'C:\Israel.Junior\Teste Siagri\Desafio_Delphi_02'
    VendorLib = 'fbclient.dll'
    Left = 256
    Top = 184
  end
  object FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink
    Left = 280
    Top = 80
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 48
    Top = 56
  end
end
