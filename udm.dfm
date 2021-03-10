object dm: Tdm
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'dm'
  ClientHeight = 351
  ClientWidth = 609
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object conexao: TFDConnection
    ConnectionName = 'conexaomysql'
    Params.Strings = (
      'Database=vendas'
      'User_Name=root'
      'Password=root'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    LoginPrompt = False
    Left = 552
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrNone
    Left = 296
    Top = 184
  end
end
