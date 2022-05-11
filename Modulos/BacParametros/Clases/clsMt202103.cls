VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsMt202103"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Private ObjMt202103     As New ComAs400Internet.EPR300001
Private SqlHost         As Variant
Private SqlPort         As Variant
Private SqlProg         As Variant
Private SqlUser         As Variant
Private SqlSrv          As Variant
Private ErrorEnvio      As Variant

Private Enum Estatus
    [Error] = 1
    [ok] = 0
End Enum
Private Enum TipoCaracter
    [Numerico] = 0
    [Caracter] = 1
    [AlfaNumerico] = 2
    [Fecha] = 3
End Enum

Private Type MT202103
    A001_H01USERID      As Variant
    A002_H01PROGRM      As Variant
    A003_H01TIMSYS      As Variant
    A004_H01SCRCOD      As Variant
    A005_H01OPECOD      As Variant
    A006_H01FLGMAS      As Variant
    A007_H01FLGWK1      As Variant
    A008_H01FLGWK2      As Variant
    A009_H01FLGWK3      As Variant
    A010_E01INWUSR      As Variant
    A011_E01INWEXA      As Variant
    A012_E01INWIMT      As Variant
    A013_E01INWSQN      As Variant
    A014_E01INWTYP      As Variant
    A015_E01INWTCD      As Variant
    A016_E01INWTDM      As Variant
    A017_E01INWTDD      As Variant
    A018_E01INWTDY      As Variant
    A019_E01INWTTM      As Variant
    A020_E01INWVDM      As Variant
    A021_E01INWVDD      As Variant
    A022_E01INWVDY      As Variant
    A023_E01INWVTM      As Variant
    A024_E01INWOBN      As Variant
    A025_E01INWOBR      As Variant
    A026_E01INWOCU      As Variant
    A027_E01INWNUM      As Variant
    A028_E01INWCDE      As Variant
    A029_E01INWAMT      As Variant
    A030_E01INWTCY      As Variant
    A031_E01INWSID      As Variant
    A032_E01INWRID      As Variant
    A033_E01INWSRF      As Variant
    A034_E01INWTHF      As Variant
    A035_E01INWDBK      As Variant
    A036_E01INWDBR      As Variant
    A037_E01INWDCY      As Variant
    A038_E01INWDGL      As Variant
    A039_E01INWDAC      As Variant
    A040_E01INWDCC      As Variant
    A041_E01INWDXR      As Variant
    A042_E01INWCBK      As Variant
    A043_E01INWCBR      As Variant
    A044_E01INWCCY      As Variant
    A045_E01INWCGL      As Variant
    A046_E01INWCAC      As Variant
    A047_E01INWCCC      As Variant
    A048_E01INWCXR      As Variant
    A049_E01INWCCU      As Variant
    A050_E01INWHDY      As Variant
    A051_E11INWORC      As Variant
    A052_E21INWORC      As Variant
    A053_E31INWORC      As Variant
    A054_E41INWORC      As Variant
    A055_E01INWORO      As Variant
    A056_E11INWOBK      As Variant
    A057_E21INWOBK      As Variant
    A058_E31INWOBK      As Variant
    A059_E41INWOBK      As Variant
    A060_E01INWOBO      As Variant
    A061_E11INWINB      As Variant
    A062_E21INWINB      As Variant
    A063_E31INWINB      As Variant
    A064_E41INWINB      As Variant
    A065_E01INWINO      As Variant
    A066_E11INWBCU      As Variant
    A067_E21INWBCU      As Variant
    A068_E31INWBCU      As Variant
    A069_E41INWBCU      As Variant
    A070_E01INWBCO      As Variant
    A071_E11INWBBK      As Variant
    A072_E21INWBBK      As Variant
    A073_E31INWBBK      As Variant
    A074_E41INWBBK      As Variant
    A075_E01INWBBO      As Variant
    A076_E11INWSCB      As Variant
    A077_E21INWSCB      As Variant
    A078_E31INWSCB      As Variant
    A079_E41INWSCB      As Variant
    A080_E01INWSCO      As Variant
    A081_E11INWRCB      As Variant
    A082_E21INWRCB      As Variant
    A083_E31INWRCB      As Variant
    A084_E41INWRCB      As Variant
    A085_E01INWRBO      As Variant
    A086_E11INWDTO      As Variant
    A087_E21INWDTO      As Variant
    A088_E31INWDTO      As Variant
    A089_E41INWDTO      As Variant
    A090_E11INWDTP      As Variant
    A091_E21INWDTP      As Variant
    A092_E31INWDTP      As Variant
    A093_E41INWDTP      As Variant
    A094_E01INWCHG      As Variant
    A095_E11INWBKB      As Variant
    A096_E21INWBKB      As Variant
    A097_E31INWBKB      As Variant
    A098_E41INWBKB      As Variant
    A099_E01INWCKN      As Variant
    A100_E01INWFMT      As Variant
    A101_E01INWCOT      As Variant
    A102_E01INWCOM      As Variant
    A103_E01INWCOB      As Variant
    A104_E01INWCOR      As Variant
    A105_E01INWCOY      As Variant
    A106_E01INWCOG      As Variant
    A107_E01INWCOC      As Variant
    A108_E01INWBCA      As Variant
    A109_E01INWPVI      As Variant
    A110_E01INWDPT      As Variant
    A111_E01INWSOU      As Variant
    A112_E01INWDIB      As Variant
    A113_E01INWDSQ      As Variant
    A114_E01INWFL1      As Variant
    A115_E01INWFL2      As Variant
    A116_E01INWFL3      As Variant
    A117_E01INWIDM      As Variant
    A118_E01INWIDD      As Variant
    A119_E01INWIDY      As Variant
    A120_E11INWRTR      As Variant
    A121_E21INWRTR      As Variant
    A122_E31INWRTR      As Variant
    A123_E01INWBKO      As Variant
    A124_E01INWITC      As Variant
    A125_E01INWITA      As Variant
    A126_E01INWTTC      As Variant
    A127_E11INWTRD      As Variant
    A128_E21INWTRD      As Variant
    A129_E31INWTRD      As Variant
    A130_E41INWTRD      As Variant
    A131_E01INWTRI      As Variant
    A132_E01INWSCC      As Variant
    A133_E01INWSCA      As Variant
    A134_E01INWRCC      As Variant
    A135_E01INWRRA      As Variant
    A136_E01INWBID      As Variant
    A137_E01INWOID      As Variant
    A138_E01INWOCT      As Variant
    A139_E01INWBIS      As Variant
    A140_E01INWBAC      As Variant
    A141_E01INWRBI      As Variant
    A142_E01INWACI      As Variant
    A143_E01INWDAT      As Variant
    A144_E01INWCAT      As Variant
    A145_E01INWCNL      As Variant
    A146_E01INWPTY      As Variant
    EstadoEnivoAs400    As Estatus

    N001_E01INWSST      As Variant
    N002_E01INWFL4      As Variant
    N003_E01INWFL5      As Variant
    N004_E01INWFL6      As Variant
    N005_E01INWOIS      As Variant
    N006_E01PRUCR1      As Variant
    N007_E01PRUCR2      As Variant
    N008_E01PRUCR3      As Variant
    N009_E01PRUCR4      As Variant
    N010_E01PRUCR5      As Variant
    N011_E01PRUCR6      As Variant
    N012_E01PRUCR7      As Variant
    N013_E01PRUCR8      As Variant
    N014_E01PRUCR9      As Variant
    N015_E01PRUC10      As Variant

    G016_E01INWPYM      As Variant
    G017_E01INWPYD      As Variant
    G018_E01INWPYY      As Variant
End Type
Private CamposMt202103  As MT202103



Private Sub Class_Initialize()
   Dim ArchIni As String
   Dim DboIni  As String
    
   ArchIni = "Bac-Sistemas.ini"
   If Dir("C:\WINNT\" & ArchIni) <> "" Then
      ArchIni = "C:\WINNT\" & ArchIni
   ElseIf Dir("C:\WINDOWS\" & ArchIni) <> "" Then
      ArchIni = "C:\WINDOWS\" & ArchIni
   ElseIf Dir("C:\BTRADER\" & ArchIni) <> "" Then
      ArchIni = "C:\BTRADER\" & ArchIni
   ElseIf Dir("C:\" & ArchIni) <> "" Then
      ArchIni = "C:\" & ArchIni
   ElseIf Dir(App.Path & "\" & ArchIni) <> "" Then
      ArchIni = App.Path & "\" & ArchIni
   Else
      MsgBox "Archivo de configuraciones no existe.", vbCritical, TITSISTEMA
      End
   End If
    
   DboIni = Func_Read_INI("INI", "DBO_PATH", ArchIni) & "DBO.INI"
   SqlHost = Func_Read_INI("as400", "H", DboIni)
   SqlPort = Func_Read_INI("as400", "P", DboIni)
   SqlUser = Func_Read_INI("as400", "U", DboIni)
   SqlSrv = Func_Read_INI("as400", "S", DboIni)
   
End Sub

Private Sub Class_Terminate()
    Set ObjMt202103 = Nothing
End Sub

Function GeneraMt(ByVal NumeroOperación As Double, ByVal Sistema As String, ByVal iMoneda As String) As Boolean
   On Error GoTo ErrorCarga
   Dim Datos()
   Dim oError   As Variant
   
   BACSwapParametros.Timer1.Enabled = False
   
   GeneraMt = False
   
   If Len(Trim(SqlHost)) = 0 Then
      MsgBox "¡ El Host de destino no se encuentra especificado !" & vbCrLf & "Comuniquese con su Administrador", vbCritical, TITSISTEMA
      BACSwapParametros.Timer1.Enabled = True
      On Error GoTo 0
      Exit Function
   End If
   If Len(Trim(SqlPort)) = 0 Then
      MsgBox "¡ El Puerto de destino no se encuentra especificado !" & vbCrLf & "Comuniquese con su Administrador", vbExclamation, TITSISTEMA
      BACSwapParametros.Timer1.Enabled = True
      On Error GoTo 0
      Exit Function
   End If
   If Not IsNumeric(SqlPort) Then
      MsgBox "¡ El Puerto de Destino es Incorrecto !" & vbCrLf & "debe ser un valor numérico... Comuniquese con su Administrador", vbExclamation, TITSISTEMA
      BACSwapParametros.Timer1.Enabled = True
      On Error GoTo 0
      Exit Function
   End If
   
   Envia = Array()
   AddParam Envia, NumeroOperación
   AddParam Envia, Sistema
   AddParam Envia, gsBAC_User
   AddParam Envia, "V"
   If Not Bac_Sql_Execute("bacparamsuda.dbo.SERVICIO_LBTR", Envia) Then
      GoTo ErrorCarga
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) < 0 Then
         If Datos(1) = -4 Then
            MsgBox Trim(Datos(2)), vbCritical, TITSISTEMA
            BACSwapParametros.Timer1.Enabled = True
            On Error GoTo 0
            Exit Function
         Else
            MsgBox Trim(Datos(2)) & " : " & NumeroOperación & vbCrLf & "Sistema Origen : " & Sistema & vbCrLf & vbCrLf & "Validación Archivo LBTR " & vbCrLf & "No se puede reenviar", vbCritical, TITSISTEMA
            BACSwapParametros.Timer1.Enabled = True
            On Error GoTo 0
            Exit Function
         End If
      End If
   End If
        
   Envia = Array()
   AddParam Envia, NumeroOperación
   AddParam Envia, Sistema
   AddParam Envia, gsBAC_User
   AddParam Envia, "N"
   If Not Bac_Sql_Execute("bacparamsuda.dbo.SERVICIO_LBTR", Envia) Then
      GoTo ErrorCarga
   End If
   If Bac_SQL_Fetch(Datos()) Then
      
      '--> Agrego Log Diario para Motor de Pagos (Control de Función de Carga de Datos)
         Call EscribeLogMPagos(Sistema, CDbl(NumeroOperación), iMoneda, "Carga de Datos", "LlenarMt", "Previa Carga de Datos")
      If LlenarMt(Datos()) = Error Then
         Call EscribeLogMPagos(Sistema, CDbl(NumeroOperación), iMoneda, "Carga de Datos", "LlenarMt", "Fallo Carga de Datos")
         GoTo ErrorCarga
      End If
         Call EscribeLogMPagos(Sistema, CDbl(NumeroOperación), iMoneda, "Carga de Datos", "LlenarMt", "Carga de Datos OK")
      
      If Trim(CamposMt202103.A100_E01INWFMT) = "" Then
         BACSwapParametros.Timer1.Enabled = True
         Exit Function
      End If
      
      '--> Agrego Log Diario para Motor de Pagos (Control de Función de Envio de Datos)
         Call EscribeLogMPagos(Sistema, CDbl(NumeroOperación), iMoneda, "Carga de Datos", "EnvioMt", "Previa Envio de Datos")
      oError = EnvioMt
      If oError <> ok Then
         Call EscribeLogMPagos(Sistema, CDbl(NumeroOperación), iMoneda, "Carga de Datos", "EnvioMt", "Fallo Envio de Datos")
         MsgBox "¡¡ E R R O R !!  " & oError & vbCrLf & vbCrLf & "Algún problema de comunicación ha ocurrido " & vbCrLf & "Operación " & NumeroOperación & " del Sistema: " & Sistema & " NO HA SIDO ENVIADA" & vbCrLf & "Comuniquese con su Administrador", vbCritical, TITSISTEMA
      Else
         Call EscribeLogMPagos(Sistema, CDbl(NumeroOperación), iMoneda, "Carga de Datos", "EnvioMt", "Envio de Datos OK")
         
         
         '--> Agrego Log Diario para Motor de Pagos (Control de Función de Cambio de Estado)
         Envia = Array()
         AddParam Envia, CDbl(NumeroOperación)
         AddParam Envia, Sistema
         AddParam Envia, gsBAC_User
         AddParam Envia, "S"
         If Not Bac_Sql_Execute("bacparamsuda.dbo.SERVICIO_LBTR", Envia) Then
            Call EscribeLogMPagos(Sistema, CDbl(NumeroOperación), iMoneda, "Cambio Estado", "Change", "Fallo Cambio de Estado")
            MsgBox "Error Actualización Estado" & vbCrLf & " Error en Operación : " & CDbl(NumeroOperación) & " ... para el sistema : " & Sistema, vbExclamation, TITSISTEMA
            GoTo ErrorCarga
         End If
            Call EscribeLogMPagos(Sistema, CDbl(NumeroOperación), iMoneda, "Cambio Estado", "Change", "Cambio de Estado OK")
         GeneraMt = True
         
      End If
   End If
   
   BACSwapParametros.Timer1.Enabled = True
   On Error GoTo 0
   
Exit Function
ErrorCarga:
   On Error GoTo 0
   BACSwapParametros.Timer1.Enabled = True
   If oError = 0 Then
      Envia = Array()
      AddParam Envia, CDbl(NumeroOperación)
      AddParam Envia, Sistema
      AddParam Envia, gsBAC_User
      AddParam Envia, "S"
      If Not Bac_Sql_Execute("bacparamsuda.dbo.SERVICIO_LBTR", Envia) Then
         Call EscribeLogMPagos(Sistema, CDbl(NumeroOperación), iMoneda, "Cambio Estado", "Change", "Fallo Cambio de Estado")
         MsgBox "Error Actualización Estado" & vbCrLf & " Error en Operación : " & CDbl(NumeroOperación) & " ... para el sistema : " & Sistema, vbExclamation, TITSISTEMA
      Else
         Call EscribeLogMPagos(Sistema, CDbl(NumeroOperación), iMoneda, "Cambio Estado", "Change", "Cambio de Estado OK")
         GeneraMt = True
      End If
      Call EscribeLogError(0, "Operación Transmitida Exitosa: " & Trim(CStr(CDbl(NumeroOperación))) & " Retorno : " & Trim(CStr(CDbl(oError))))
   Else
      MsgBox Err.Description, vbExclamation, TITSISTEMA
   End If
End Function

Private Function LlenarMt(ByRef Datos As Variant) As Estatus
      On Error GoTo ErrorLlenarVariable
      Dim oCadena         As String
      
      LlenarMt = Error
    
      CamposMt202103.A001_H01USERID = fCampoInterfaz(Caracter, Datos(1), 10, 0)         '001 --> Char     (10)
      CamposMt202103.A002_H01PROGRM = fCampoInterfaz(Caracter, Datos(2), 10, 0)         '002 --> Char     (10)
      CamposMt202103.A003_H01TIMSYS = fCampoInterfaz(Numerico, Datos(3), 12, 0)         '003 --> Numeric  (12)
      CamposMt202103.A004_H01SCRCOD = fCampoInterfaz(Caracter, Datos(4), 2, 0)          '004 --> Char     (02)
      CamposMt202103.A005_H01OPECOD = fCampoInterfaz(Caracter, Datos(5), 4, 0)          '005 --> Char     (04)
      CamposMt202103.A006_H01FLGMAS = fCampoInterfaz(Caracter, Datos(6), 1, 0)          '006 --> Char     (01)
      CamposMt202103.A007_H01FLGWK1 = fCampoInterfaz(Caracter, Datos(7), 1, 0)          '007 --> Char     (01)
      CamposMt202103.A008_H01FLGWK2 = fCampoInterfaz(Caracter, Datos(8), 1, 0)          '008 --> Char     (01)
      CamposMt202103.A009_H01FLGWK3 = fCampoInterfaz(Caracter, Datos(9), 1, 0)          '009 --> Char     (01)
      CamposMt202103.A010_E01INWUSR = fCampoInterfaz(Caracter, Datos(10), 10, 0)        '010 --> Char     (10)
      
      CamposMt202103.A011_E01INWEXA = fCampoInterfaz(Caracter, Datos(11), 10, 0)        '011 --> Char     (10)
      CamposMt202103.A012_E01INWIMT = fCampoInterfaz(Caracter, Datos(12), 1, 0)         '012 --> Char     (01)
      CamposMt202103.A013_E01INWSQN = fCampoInterfaz(Numerico, Datos(13), 4, 0)         '013 --> Numeric  (04)
      CamposMt202103.A014_E01INWTYP = fCampoInterfaz(Caracter, Datos(14), 1, 0)         '014 --> Char     (01)
      CamposMt202103.A015_E01INWTCD = fCampoInterfaz(Caracter, Datos(15), 8, 0)         '015 --> Char     (08)
      CamposMt202103.A016_E01INWTDM = fCampoInterfaz(Numerico, Datos(16), 2, 0)         '016 --> Numeric  (02)
      CamposMt202103.A017_E01INWTDD = fCampoInterfaz(Numerico, Datos(17), 2, 0)         '017 --> Numeric  (02)
      CamposMt202103.A018_E01INWTDY = fCampoInterfaz(Numerico, Datos(18), 2, 0)         '018 --> Numeric  (02)
      CamposMt202103.A019_E01INWTTM = fCampoInterfaz(Numerico, Datos(19), 6, 0)         '019 --> Numeric  (06)
      CamposMt202103.A020_E01INWVDM = fCampoInterfaz(Numerico, Datos(20), 2, 0)         '020 --> Numeric  (02)
      
      CamposMt202103.A021_E01INWVDD = fCampoInterfaz(Numerico, Datos(21), 2, 0)         '021 --> Numeric  (02)
      CamposMt202103.A022_E01INWVDY = fCampoInterfaz(Numerico, Datos(22), 2, 0)         '022 --> Numeric  (02)
      CamposMt202103.A023_E01INWVTM = fCampoInterfaz(Numerico, Datos(23), 4, 0)         '023 --> Numeric  (04)
      CamposMt202103.A024_E01INWOBN = fCampoInterfaz(Caracter, Datos(24), 2, 0)         '024 --> Char     (02)
      CamposMt202103.A025_E01INWOBR = fCampoInterfaz(Numerico, Datos(25), 3, 0)         '025 --> Numeric  (03)
      CamposMt202103.A026_E01INWOCU = fCampoInterfaz(Numerico, Datos(26), 9, 0)         '026 --> Numeric  (09)
      CamposMt202103.A027_E01INWNUM = fCampoInterfaz(Numerico, Datos(27), 9, 0)         '027 --> Numeric  (09)
      CamposMt202103.A028_E01INWCDE = fCampoInterfaz(Caracter, Datos(28), 1, 0)         '028 --> Char     (01)
      CamposMt202103.A029_E01INWAMT = fCampoInterfaz(Numerico, CDbl(Datos(29)), 13, 2)        '029 --> Numeric  (15,2)
      CamposMt202103.A030_E01INWTCY = fCampoInterfaz(Caracter, Datos(30), 3, 0)         '030 --> Char     (03)
      
      CamposMt202103.A031_E01INWSID = fCampoInterfaz(Caracter, Datos(31), 12, 0)        '031 --> Char     (12)
      CamposMt202103.A032_E01INWRID = fCampoInterfaz(Caracter, Datos(32), 15, 0)        '032 --> Char     (15)
      CamposMt202103.A033_E01INWSRF = fCampoInterfaz(Caracter, Datos(33), 16, 0)        '033 --> Char     (16)
      CamposMt202103.A034_E01INWTHF = fCampoInterfaz(Caracter, Datos(34), 16, 0)        '034 --> Char     (16)
      CamposMt202103.A035_E01INWDBK = fCampoInterfaz(Caracter, Datos(35), 2, 0)         '035 --> Char     (02)
      CamposMt202103.A036_E01INWDBR = fCampoInterfaz(Numerico, Datos(36), 3, 0)         '036 --> Numeric  (03)
      CamposMt202103.A037_E01INWDCY = fCampoInterfaz(Caracter, Datos(37), 3, 0)         '037 --> Char     (03)
      CamposMt202103.A038_E01INWDGL = fCampoInterfaz(Numerico, Datos(38), 16, 0)        '038 --> Numeric  (16)
      CamposMt202103.A039_E01INWDAC = fCampoInterfaz(Numerico, Datos(39), 12, 0)        '039 --> Numeric  (16)
      CamposMt202103.A040_E01INWDCC = fCampoInterfaz(Numerico, Datos(40), 8, 0)         '040 --> Numeric  (08)
      
      CamposMt202103.A041_E01INWDXR = fCampoInterfaz(Numerico, Datos(41), 5, 6)         '041 --> Numeric  (11,6)
      CamposMt202103.A042_E01INWCBK = fCampoInterfaz(Caracter, Datos(42), 2, 0)         '042 --> Char     (02)
      CamposMt202103.A043_E01INWCBR = fCampoInterfaz(Numerico, Datos(43), 3, 0)         '043 --> Numeric  (03)
      CamposMt202103.A044_E01INWCCY = fCampoInterfaz(Caracter, Datos(44), 3, 0)         '044 --> Char     (03)
      CamposMt202103.A045_E01INWCGL = fCampoInterfaz(Numerico, Datos(45), 16, 0)        '045 --> Numeric  (16)
      CamposMt202103.A046_E01INWCAC = fCampoInterfaz(Numerico, Datos(46), 12, 0)        '046 --> Numeric  (12)
      CamposMt202103.A047_E01INWCCC = fCampoInterfaz(Numerico, Datos(47), 8, 0)         '047 --> Numeric  (08)
      CamposMt202103.A048_E01INWCXR = fCampoInterfaz(Numerico, Datos(48), 5, 6)         '048 --> Numeric  (11,6)
      CamposMt202103.A049_E01INWCCU = fCampoInterfaz(Numerico, Datos(49), 9, 0)         '049 --> Numeric  (09)
      CamposMt202103.A050_E01INWHDY = fCampoInterfaz(Numerico, Datos(50), 2, 0)         '050 --> Numeric  (02)
      
      CamposMt202103.A051_E11INWORC = fCampoInterfaz(Caracter, Datos(51), 35, 0)        '051 --> Char     (35)
      CamposMt202103.A052_E21INWORC = fCampoInterfaz(Caracter, Datos(52), 35, 0)        '052 --> Char     (35)
      CamposMt202103.A053_E31INWORC = fCampoInterfaz(Caracter, Datos(53), 35, 0)        '053 --> Char     (35)
      CamposMt202103.A054_E41INWORC = fCampoInterfaz(Caracter, Datos(54), 35, 0)        '054 --> Char     (35)
      CamposMt202103.A055_E01INWORO = fCampoInterfaz(Caracter, Datos(55), 1, 0)         '055 --> Char     (01)
      CamposMt202103.A056_E11INWOBK = fCampoInterfaz(Caracter, Datos(56), 35, 0)        '056 --> Char     (35)
      CamposMt202103.A057_E21INWOBK = fCampoInterfaz(Caracter, Datos(57), 35, 0)        '057 --> Char     (35)
      CamposMt202103.A058_E31INWOBK = fCampoInterfaz(Caracter, Datos(58), 35, 0)        '058 --> Char     (35)
      CamposMt202103.A059_E41INWOBK = fCampoInterfaz(Caracter, Datos(59), 35, 0)        '059 --> Char     (35)
      CamposMt202103.A060_E01INWOBO = fCampoInterfaz(Caracter, Datos(60), 1, 0)         '060 --> Char     (01)
      
      CamposMt202103.A061_E11INWINB = fCampoInterfaz(Caracter, Datos(61), 35, 0)        '061 --> Char     (35)
      CamposMt202103.A062_E21INWINB = fCampoInterfaz(Caracter, Datos(62), 35, 0)        '062 --> Char     (35)
      CamposMt202103.A063_E31INWINB = fCampoInterfaz(Caracter, Datos(63), 35, 0)        '063 --> Char     (35)
      CamposMt202103.A064_E41INWINB = fCampoInterfaz(Caracter, Datos(64), 35, 0)        '064 --> Char     (35)
      CamposMt202103.A065_E01INWINO = fCampoInterfaz(Caracter, Datos(65), 1, 0)         '065 --> Char     (01)
      CamposMt202103.A066_E11INWBCU = fCampoInterfaz(Caracter, Datos(66), 35, 0)        '066 --> Char     (35)
      CamposMt202103.A067_E21INWBCU = fCampoInterfaz(Caracter, Datos(67), 35, 0)        '067 --> Char     (35)
      CamposMt202103.A068_E31INWBCU = fCampoInterfaz(Caracter, Datos(68), 35, 0)        '068 --> Char     (35)
      CamposMt202103.A069_E41INWBCU = fCampoInterfaz(Caracter, Datos(69), 35, 0)        '069 --> Char     (35)
      CamposMt202103.A070_E01INWBCO = fCampoInterfaz(Caracter, Datos(70), 1, 0)         '070 --> Char     (01)
      
      CamposMt202103.A071_E11INWBBK = fCampoInterfaz(Caracter, Datos(71), 35, 0)        '071 --> Char     (35)
      CamposMt202103.A072_E21INWBBK = fCampoInterfaz(Caracter, Datos(72), 35, 0)        '072 --> Char     (35)
      CamposMt202103.A073_E31INWBBK = fCampoInterfaz(Caracter, Datos(73), 35, 0)        '073 --> Char     (35)
      CamposMt202103.A074_E41INWBBK = fCampoInterfaz(Caracter, Datos(74), 35, 0)        '074 --> Char     (35)
      CamposMt202103.A075_E01INWBBO = fCampoInterfaz(Caracter, Datos(75), 1, 0)         '075 --> Char     (01)
      CamposMt202103.A076_E11INWSCB = fCampoInterfaz(Caracter, Datos(76), 35, 0)        '076 --> Char     (35)
      CamposMt202103.A077_E21INWSCB = fCampoInterfaz(Caracter, Datos(77), 35, 0)        '077 --> Char     (35)
      CamposMt202103.A078_E31INWSCB = fCampoInterfaz(Caracter, Datos(78), 35, 0)        '078 --> Char     (35)
      CamposMt202103.A079_E41INWSCB = fCampoInterfaz(Caracter, Datos(79), 35, 0)        '079 --> Char     (35)
      CamposMt202103.A080_E01INWSCO = fCampoInterfaz(Caracter, Datos(80), 1, 0)         '080 --> Char     (01)
      
      CamposMt202103.A081_E11INWRCB = fCampoInterfaz(Caracter, Datos(81), 35, 0)        '081 --> Char     (35)
      CamposMt202103.A082_E21INWRCB = fCampoInterfaz(Caracter, Datos(82), 35, 0)        '082 --> Char     (35)
      CamposMt202103.A083_E31INWRCB = fCampoInterfaz(Caracter, Datos(83), 35, 0)        '083 --> Char     (35)
      CamposMt202103.A084_E41INWRCB = fCampoInterfaz(Caracter, Datos(84), 35, 0)        '084 --> Char     (35)
      CamposMt202103.A085_E01INWRBO = fCampoInterfaz(Caracter, Datos(85), 1, 0)         '085 --> Char     (01)
      CamposMt202103.A086_E11INWDTO = fCampoInterfaz(Caracter, Datos(86), 35, 0)        '086 --> Char     (35)
      CamposMt202103.A087_E21INWDTO = fCampoInterfaz(Caracter, Datos(87), 35, 0)        '087 --> Char     (35)
      CamposMt202103.A088_E31INWDTO = fCampoInterfaz(Caracter, Datos(88), 35, 0)        '088 --> Char     (35)
      CamposMt202103.A089_E41INWDTO = fCampoInterfaz(Caracter, Datos(89), 35, 0)        '089 --> Char     (35)
      CamposMt202103.A090_E11INWDTP = fCampoInterfaz(Caracter, Datos(90), 35, 0)        '090 --> Char     (35)
      
      CamposMt202103.A091_E21INWDTP = fCampoInterfaz(Caracter, Datos(91), 35, 0)        '091 --> Char     (35)
      CamposMt202103.A092_E31INWDTP = fCampoInterfaz(Caracter, Datos(92), 35, 0)        '092 --> Char     (35)
      CamposMt202103.A093_E41INWDTP = fCampoInterfaz(Caracter, Datos(93), 35, 0)        '093 --> Char     (35)
      CamposMt202103.A094_E01INWCHG = fCampoInterfaz(Caracter, Datos(94), 1, 0)         '094 --> Char     (01)
      CamposMt202103.A095_E11INWBKB = fCampoInterfaz(Caracter, Datos(95), 35, 0)        '095 --> Char     (35)
      CamposMt202103.A096_E21INWBKB = fCampoInterfaz(Caracter, Datos(96), 35, 0)        '096 --> Char     (35)
      CamposMt202103.A097_E31INWBKB = fCampoInterfaz(Caracter, Datos(97), 35, 0)        '097 --> Char     (35)
      CamposMt202103.A098_E41INWBKB = fCampoInterfaz(Caracter, Datos(98), 35, 0)        '098 --> Char     (35)
      CamposMt202103.A099_E01INWCKN = fCampoInterfaz(Numerico, Datos(99), 9, 0)         '099 --> Numeric  (09)
      CamposMt202103.A100_E01INWFMT = fCampoInterfaz(Caracter, Datos(100), 5, 0)        '100 --> Char     (05)
          
      CamposMt202103.A101_E01INWCOT = fCampoInterfaz(Numerico, Datos(101), 2, 0)        '101 --> Numeric  (02)
      CamposMt202103.A102_E01INWCOM = fCampoInterfaz(Numerico, Datos(102), 11, 2)       '102 --> Numeric  (13,2)
      CamposMt202103.A103_E01INWCOB = fCampoInterfaz(Caracter, Datos(103), 2, 0)        '103 --> Char     (02)
      CamposMt202103.A104_E01INWCOR = fCampoInterfaz(Numerico, Datos(104), 3, 0)        '104 --> Numeric  (03)
      CamposMt202103.A105_E01INWCOY = fCampoInterfaz(Caracter, Datos(105), 3, 0)        '105 --> Char     (03)
      CamposMt202103.A106_E01INWCOG = fCampoInterfaz(Numerico, Datos(106), 16, 0)       '106 --> Numeric  (16)
      CamposMt202103.A107_E01INWCOC = fCampoInterfaz(Numerico, Datos(107), 8, 0)        '107 --> Numeric  (08)
      CamposMt202103.A108_E01INWBCA = fCampoInterfaz(Numerico, Datos(108), 11, 2)       '108 --> Numeric  (13,2)
      CamposMt202103.A109_E01INWPVI = fCampoInterfaz(Caracter, Datos(109), 1, 0)        '109 --> Char     (01)
      CamposMt202103.A110_E01INWDPT = fCampoInterfaz(Caracter, Datos(110), 4, 0)        '110 --> Char     (04)
      
      CamposMt202103.A111_E01INWSOU = fCampoInterfaz(Caracter, Datos(111), 2, 0)        '111 --> Char     (02)
      CamposMt202103.A112_E01INWDIB = fCampoInterfaz(Caracter, Datos(112), 2, 0)        '112 --> Char     (02)
      CamposMt202103.A113_E01INWDSQ = fCampoInterfaz(Caracter, Datos(113), 4, 0)        '113 --> Char     (04)
      CamposMt202103.A114_E01INWFL1 = fCampoInterfaz(Caracter, Datos(114), 1, 0)        '114 --> Char     (01)
      CamposMt202103.A115_E01INWFL2 = fCampoInterfaz(Caracter, Datos(115), 1, 0)        '115 --> Char     (01)
      CamposMt202103.A116_E01INWFL3 = fCampoInterfaz(Caracter, Datos(116), 1, 0)        '116 --> Char     (01)
      CamposMt202103.A117_E01INWIDM = fCampoInterfaz(Numerico, Datos(117), 2, 0)        '117 --> Numeric  (02)
      CamposMt202103.A118_E01INWIDD = fCampoInterfaz(Numerico, Datos(118), 2, 0)        '118 --> Numeric  (02)
      CamposMt202103.A119_E01INWIDY = fCampoInterfaz(Numerico, Datos(119), 2, 0)        '119 --> Numeric  (02)
      CamposMt202103.A120_E11INWRTR = fCampoInterfaz(Caracter, Datos(120), 35, 0)       '120 --> Char     (35)
      
      CamposMt202103.A121_E21INWRTR = fCampoInterfaz(Caracter, Datos(121), 35, 0)       '121 --> Char     (35)
      CamposMt202103.A122_E31INWRTR = fCampoInterfaz(Caracter, Datos(122), 35, 0)       '122 --> Char     (35)
      CamposMt202103.A123_E01INWBKO = fCampoInterfaz(Caracter, Datos(123), 4, 0)        '123 --> Char     (04)
      CamposMt202103.A124_E01INWITC = fCampoInterfaz(Caracter, Datos(124), 4, 0)        '124 --> Char     (04)
      CamposMt202103.A125_E01INWITA = fCampoInterfaz(Caracter, Datos(125), 30, 0)       '125 --> Char     (30)
      CamposMt202103.A126_E01INWTTC = fCampoInterfaz(Caracter, Datos(126), 3, 0)        '126 --> Char     (03)
      CamposMt202103.A127_E11INWTRD = fCampoInterfaz(Caracter, Datos(127), 35, 0)       '127 --> Char     (35)
      CamposMt202103.A128_E21INWTRD = fCampoInterfaz(Caracter, Datos(128), 35, 0)       '128 --> Char     (35)
      CamposMt202103.A129_E31INWTRD = fCampoInterfaz(Caracter, Datos(129), 35, 0)       '129 --> Char     (35)
      CamposMt202103.A130_E41INWTRD = fCampoInterfaz(Caracter, Datos(130), 35, 0)       '130 --> Char     (35)
      
      CamposMt202103.A131_E01INWTRI = fCampoInterfaz(Caracter, Datos(131), 1, 0)        '131 --> Char     (01)
      CamposMt202103.A132_E01INWSCC = fCampoInterfaz(Caracter, Datos(132), 3, 0)        '132 --> Char     (03)
      CamposMt202103.A133_E01INWSCA = fCampoInterfaz(Numerico, Datos(133), 11, 2)       '133 --> Numeric  (13,2)
      CamposMt202103.A134_E01INWRCC = fCampoInterfaz(Caracter, Datos(134), 3, 0)        '134 --> Char     (03)
      CamposMt202103.A135_E01INWRRA = fCampoInterfaz(Numerico, Datos(135), 11, 2)       '135 --> Numeric  (13,2)
      CamposMt202103.A136_E01INWBID = fCampoInterfaz(Caracter, Datos(136), 15, 0)       '136 --> Char     (15)
      CamposMt202103.A137_E01INWOID = fCampoInterfaz(Caracter, Datos(137), 15, 0)       '137 --> Char     (15)
      CamposMt202103.A138_E01INWOCT = fCampoInterfaz(Caracter, Datos(138), 10, 0)       '138 --> Char     (10)
      CamposMt202103.A139_E01INWBIS = Trim(fCampoInterfaz(Caracter, Datos(139), 2, 0))  '139 --> Char     (02)
      CamposMt202103.A140_E01INWBAC = fCampoInterfaz(Caracter, Datos(140), 20, 0)       '140 --> Char     (20)
      
      CamposMt202103.A141_E01INWRBI = fCampoInterfaz(Caracter, Datos(141), 15, 0)       '141 --> Char     (15)
      CamposMt202103.A142_E01INWACI = fCampoInterfaz(Caracter, Datos(142), 1, 0)        '142 --> Char     (01)
      CamposMt202103.A143_E01INWDAT = fCampoInterfaz(Caracter, Datos(143), 1, 0)        '143 --> Char     (01)
      CamposMt202103.A144_E01INWCAT = fCampoInterfaz(Caracter, Datos(144), 1, 0)        '144 --> Char     (01)
      CamposMt202103.A145_E01INWCNL = fCampoInterfaz(Numerico, CDbl(Datos(145)), 13, 0)      '145 --> Numeric  (15,2)
      CamposMt202103.A146_E01INWPTY = fCampoInterfaz(Numerico, Datos(146), 2, 0)        '146 --> Numeric  (01)
    
      CamposMt202103.N001_E01INWSST = fCampoInterfaz(Caracter, Datos(147), 3, 0)       '147 --> Char     (03)
      CamposMt202103.N002_E01INWFL4 = fCampoInterfaz(Caracter, Datos(148), 1, 0)       '148 --> Char     (01)
      CamposMt202103.N003_E01INWFL5 = fCampoInterfaz(Caracter, Datos(149), 1, 0)       '149 --> Char     (01)
      CamposMt202103.N004_E01INWFL6 = fCampoInterfaz(Caracter, Datos(150), 1, 0)       '150 --> Char     (01)
      CamposMt202103.N005_E01INWOIS = fCampoInterfaz(Caracter, Datos(151), 2, 0)       '151 --> Char     (02)
      CamposMt202103.N006_E01PRUCR1 = fCampoInterfaz(Caracter, Datos(152), 15, 0)      '152 --> Char     (15)
      CamposMt202103.N007_E01PRUCR2 = fCampoInterfaz(Caracter, Datos(153), 15, 0)      '153 --> Char     (15)
      CamposMt202103.N008_E01PRUCR3 = fCampoInterfaz(Caracter, Datos(154), 15, 0)      '154 --> Char     (15)
      CamposMt202103.N009_E01PRUCR4 = fCampoInterfaz(Caracter, Datos(155), 15, 0)      '155 --> Char     (15)
      CamposMt202103.N010_E01PRUCR5 = fCampoInterfaz(Caracter, Datos(156), 15, 0)      '156 --> Char     (15)
      CamposMt202103.N011_E01PRUCR6 = fCampoInterfaz(Caracter, Datos(157), 15, 0)      '157 --> Char     (15)
      CamposMt202103.N012_E01PRUCR7 = fCampoInterfaz(Caracter, Datos(158), 15, 0)      '158 --> Char     (15)
      CamposMt202103.N013_E01PRUCR8 = fCampoInterfaz(Caracter, Datos(159), 15, 0)      '159 --> Char     (15)
      CamposMt202103.N014_E01PRUCR9 = fCampoInterfaz(Caracter, Datos(160), 15, 0)      '160 --> Char     (15)
      CamposMt202103.N015_E01PRUC10 = fCampoInterfaz(Caracter, Datos(161), 15, 0)      '161 --> Char     (15)
      
      CamposMt202103.G016_E01INWPYM = fCampoInterfaz(Numerico, Datos(162), 2, 0)       '162 --> Char     (15)
      CamposMt202103.G017_E01INWPYD = fCampoInterfaz(Numerico, Datos(163), 2, 0)       '163 --> Char     (15)
      CamposMt202103.G018_E01INWPYY = fCampoInterfaz(Numerico, Datos(164), 2, 0)       '164 --> Char     (15)
    
      LlenarMt = ok
      On Error GoTo 0
Exit Function
ErrorLlenarVariable:
      On Error GoTo 0
      Exit Function
End Function


Private Function EnvioMt() As Estatus
   On Error GoTo ErrorInterno
   On Error GoTo 0
   
   EnvioMt = Error
   
   ObjMt202103.SetField "H01USERID", SqlUser    '--> "CBCLRGD"  '--> gsBAC_User
   ObjMt202103.SetField "H01PROGRM", SqlSrv     '--> "EPR3000"
   ObjMt202103.SetField "H01TIMSYS", ObjMt202103.getTimeStamp()
   ObjMt202103.SetField "H01SCRCOD", CamposMt202103.A004_H01SCRCOD
   ObjMt202103.SetField "H01OPECOD", CamposMt202103.A005_H01OPECOD
   '           ObjMt202103.SetField "H01FLGMAS", CamposMt202103.A006_H01FLGMAS
   '           ObjMt202103.SetField "H01FLGWK1", CamposMt202103.A007_H01FLGWK1
   '           ObjMt202103.SetField "H01FLGWK2", CamposMt202103.A008_H01FLGWK2
   '           ObjMt202103.SetField "H01FLGWK3", CamposMt202103.A009_H01FLGWK3
   ObjMt202103.SetField "E01INWUSR", CamposMt202103.A010_E01INWUSR
   ObjMt202103.SetField "E01INWEXA", Trim(CamposMt202103.A011_E01INWEXA)
   ObjMt202103.SetField "E01INWIMT", CamposMt202103.A012_E01INWIMT
   ObjMt202103.SetField "E01INWSQN", CDbl(CamposMt202103.A013_E01INWSQN)
   ObjMt202103.SetField "E01INWTYP", CamposMt202103.A014_E01INWTYP
   ObjMt202103.SetField "E01INWTCD", Trim(CamposMt202103.A015_E01INWTCD)
   '           ObjMt202103.SetField "E01INWTDM", CamposMt202103.A016_E01INWTDM
   '           ObjMt202103.SetField "E01INWTDD", CamposMt202103.A017_E01INWTDD
   '           ObjMt202103.SetField "E01INWTDY", CamposMt202103.A018_E01INWTDY
   '           ObjMt202103.SetField "E01INWTTM", CamposMt202103.A019_E01INWTTM
   ObjMt202103.SetField "E01INWVDM", CDbl(CamposMt202103.A020_E01INWVDM)
   ObjMt202103.SetField "E01INWVDD", CDbl(CamposMt202103.A021_E01INWVDD)
   ObjMt202103.SetField "E01INWVDY", CDbl(CamposMt202103.A022_E01INWVDY)
   ObjMt202103.SetField "E01INWVTM", CDbl(CamposMt202103.A023_E01INWVTM)
   ObjMt202103.SetField "E01INWOBN", CamposMt202103.A024_E01INWOBN
   ObjMt202103.SetField "E01INWOBR", CDbl(CamposMt202103.A025_E01INWOBR)
   '           ObjMt202103.SetField "E01INWOCU", CamposMt202103.A026_E01INWOCU
   '           ObjMt202103.SetField "E01INWNUM", CamposMt202103.A027_E01INWNUM
   '           ObjMt202103.SetField "E01INWCDE", CamposMt202103.A028_E01INWCDE
   ObjMt202103.SetField "E01INWAMT", CDbl(CamposMt202103.A029_E01INWAMT)
   ObjMt202103.SetField "E01INWTCY", CamposMt202103.A030_E01INWTCY
   ObjMt202103.SetField "E01INWSID", Trim(CamposMt202103.A031_E01INWSID)
   ObjMt202103.SetField "E01INWRID", Trim(CamposMt202103.A032_E01INWRID)
   ObjMt202103.SetField "E01INWSRF", Trim(CamposMt202103.A033_E01INWSRF)
   '           ObjMt202103.SetField "E01INWTHF", CamposMt202103.A034_E01INWTHF
   ObjMt202103.SetField "E01INWDBK", CamposMt202103.A035_E01INWDBK
   ObjMt202103.SetField "E01INWDBR", CDbl(CamposMt202103.A036_E01INWDBR)
   ObjMt202103.SetField "E01INWDCY", CamposMt202103.A037_E01INWDCY
   ObjMt202103.SetField "E01INWDGL", Val(CamposMt202103.A038_E01INWDGL)
   ObjMt202103.SetField "E01INWDAC", CamposMt202103.A039_E01INWDAC
   '           ObjMt202103.SetField "E01INWDCC", CamposMt202103.A040_E01INWDCC
   '           ObjMt202103.SetField "E01INWDXR", CamposMt202103.A041_E01INWDXR
   ObjMt202103.SetField "E01INWCBK", CamposMt202103.A042_E01INWCBK
   ObjMt202103.SetField "E01INWCBR", CamposMt202103.A043_E01INWCBR
   ObjMt202103.SetField "E01INWCCY", CamposMt202103.A044_E01INWCCY
   ObjMt202103.SetField "E01INWCGL", Val(CamposMt202103.A045_E01INWCGL)
   ObjMt202103.SetField "E01INWCAC", CamposMt202103.A046_E01INWCAC
   '           ObjMt202103.SetField "E01INWCCC", CamposMt202103.A047_E01INWCCC
   '           ObjMt202103.SetField "E01INWCXR", CamposMt202103.A048_E01INWCXR
   '           ObjMt202103.SetField "E01INWCCU", CamposMt202103.A049_E01INWCCU
   '           ObjMt202103.SetField "E01INWHDY", CamposMt202103.A050_E01INWHDY
   ObjMt202103.SetField "E11INWORC", CamposMt202103.A051_E11INWORC
   ObjMt202103.SetField "E21INWORC", CamposMt202103.A052_E21INWORC
   ObjMt202103.SetField "E31INWORC", CamposMt202103.A053_E31INWORC
   ObjMt202103.SetField "E41INWORC", CamposMt202103.A054_E41INWORC
   '           ObjMt202103.SetField "E01INWORO", CamposMt202103.A055_E01INWORO
   '           ObjMt202103.SetField "E11INWOBK", CamposMt202103.A056_E11INWOBK
   '           ObjMt202103.SetField "E21INWOBK", CamposMt202103.A057_E21INWOBK
   '           ObjMt202103.SetField "E31INWOBK", CamposMt202103.A058_E31INWOBK
   '           ObjMt202103.SetField "E41INWOBK", CamposMt202103.A059_E41INWOBK
   '           ObjMt202103.SetField "E01INWOBO", CamposMt202103.A060_E01INWOBO
   '           ObjMt202103.SetField "E11INWINB", CamposMt202103.A061_E11INWINB
   '           ObjMt202103.SetField "E21INWINB", CamposMt202103.A062_E21INWINB
   '           ObjMt202103.SetField "E31INWINB", CamposMt202103.A063_E31INWINB
   '           ObjMt202103.SetField "E41INWINB", CamposMt202103.A064_E41INWINB
   '           ObjMt202103.SetField "E01INWINO", CamposMt202103.A065_E01INWINO
   ObjMt202103.SetField "E11INWBCU", Trim(CamposMt202103.A066_E11INWBCU)
   ObjMt202103.SetField "E21INWBCU", Trim(CamposMt202103.A067_E21INWBCU)
   ObjMt202103.SetField "E31INWBCU", Trim(CamposMt202103.A068_E31INWBCU)
   ObjMt202103.SetField "E41INWBCU", Trim(CamposMt202103.A069_E41INWBCU)
   '           ObjMt202103.SetField "E01INWBCO", CamposMt202103.A070_E01INWBCO
   ObjMt202103.SetField "E11INWBBK", Trim(CamposMt202103.A071_E11INWBBK)
   ObjMt202103.SetField "E21INWBBK", Trim(CamposMt202103.A072_E21INWBBK)
   '           ObjMt202103.SetField "E31INWBBK", CamposMt202103.A073_E31INWBBK
   '           ObjMt202103.SetField "E41INWBBK", CamposMt202103.A074_E41INWBBK
   '           ObjMt202103.SetField "E01INWBBO", CamposMt202103.A075_E01INWBBO
   '           ObjMt202103.SetField "E11INWSCB", CamposMt202103.A076_E11INWSCB
   '           ObjMt202103.SetField "E21INWSCB", CamposMt202103.A077_E21INWSCB
   '           ObjMt202103.SetField "E31INWSCB", CamposMt202103.A078_E31INWSCB
   '           ObjMt202103.SetField "E41INWSCB", CamposMt202103.A079_E41INWSCB
   '           ObjMt202103.SetField "E01INWSCO", CamposMt202103.A080_E01INWSCO
   '           ObjMt202103.SetField "E11INWRCB", CamposMt202103.A081_E11INWRCB
   '           ObjMt202103.SetField "E21INWRCB", CamposMt202103.A082_E21INWRCB
   '           ObjMt202103.SetField "E31INWRCB", CamposMt202103.A083_E31INWRCB
   '           ObjMt202103.SetField "E41INWRCB", CamposMt202103.A084_E41INWRCB
   '           ObjMt202103.SetField "E01INWRBO", CamposMt202103.A085_E01INWRBO
   ObjMt202103.SetField "E11INWDTO", CamposMt202103.A086_E11INWDTO
   '           ObjMt202103.SetField "E21INWDTO", CamposMt202103.A087_E21INWDTO
   '           ObjMt202103.SetField "E31INWDTO", CamposMt202103.A088_E31INWDTO
   '           ObjMt202103.SetField "E41INWDTO", CamposMt202103.A089_E41INWDTO
   ObjMt202103.SetField "E11INWDTP", CamposMt202103.A090_E11INWDTP
   ObjMt202103.SetField "E21INWDTP", CamposMt202103.A091_E21INWDTP
   ObjMt202103.SetField "E31INWDTP", CamposMt202103.A092_E31INWDTP
   ObjMt202103.SetField "E41INWDTP", CamposMt202103.A093_E41INWDTP
   ObjMt202103.SetField "E01INWCHG", CamposMt202103.A094_E01INWCHG
   '           ObjMt202103.SetField "E11INWBKB", CamposMt202103.A095_E11INWBKB
   '           ObjMt202103.SetField "E21INWBKB", CamposMt202103.A096_E21INWBKB
   '           ObjMt202103.SetField "E31INWBKB", CamposMt202103.A097_E31INWBKB
   '           ObjMt202103.SetField "E41INWBKB", CamposMt202103.A098_E41INWBKB
   '           ObjMt202103.SetField "E01INWCKN", CamposMt202103.A099_E01INWCKN
   ObjMt202103.SetField "E01INWFMT", CamposMt202103.A100_E01INWFMT
   '           ObjMt202103.SetField "E01INWCOT", CamposMt202103.A101_E01INWCOT
   '           ObjMt202103.SetField "E01INWCOM", CamposMt202103.A102_E01INWCOM
   '           ObjMt202103.SetField "E01INWCOB", CamposMt202103.A103_E01INWCOB
   '           ObjMt202103.SetField "E01INWCOR", CamposMt202103.A104_E01INWCOR
   '           ObjMt202103.SetField "E01INWCOY", CamposMt202103.A105_E01INWCOY
   '           ObjMt202103.SetField "E01INWCOG", CamposMt202103.A106_E01INWCOG
   '           ObjMt202103.SetField "E01INWCOC", CamposMt202103.A107_E01INWCOC
   '           ObjMt202103.SetField "E01INWBCA", CamposMt202103.A108_E01INWBCA
   ObjMt202103.SetField "E01INWPVI", CamposMt202103.A109_E01INWPVI
   '           ObjMt202103.SetField "E01INWDPT", CamposMt202103.A110_E01INWDPT
   ObjMt202103.SetField "E01INWSOU", CamposMt202103.A111_E01INWSOU
   ObjMt202103.SetField "E01INWDIB", CamposMt202103.A112_E01INWDIB
   '           ObjMt202103.SetField "E01INWDSQ", CamposMt202103.A113_E01INWDSQ
   '           ObjMt202103.SetField "E01INWFL1", CamposMt202103.A114_E01INWFL1
   '           ObjMt202103.SetField "E01INWFL2", CamposMt202103.A115_E01INWFL2
   '           ObjMt202103.SetField "E01INWFL3", CamposMt202103.A116_E01INWFL3
   ObjMt202103.SetField "E01INWIDM", CDbl(CamposMt202103.A117_E01INWIDM)
   ObjMt202103.SetField "E01INWIDD", CDbl(CamposMt202103.A118_E01INWIDD)
   ObjMt202103.SetField "E01INWIDY", CDbl(CamposMt202103.A119_E01INWIDY)
   '           ObjMt202103.SetField "E11INWRTR", CamposMt202103.A120_E11INWRTR
   '           ObjMt202103.SetField "E21INWRTR", CamposMt202103.A121_E21INWRTR
   '           ObjMt202103.SetField "E31INWRTR", CamposMt202103.A122_E31INWRTR
   '           ObjMt202103.SetField "E01INWBKO", CamposMt202103.A123_E01INWBKO
   '           ObjMt202103.SetField "E01INWITC", CamposMt202103.A124_E01INWITC
   '           ObjMt202103.SetField "E01INWITA", CamposMt202103.A125_E01INWITA
   '           ObjMt202103.SetField "E01INWTTC", CamposMt202103.A126_E01INWTTC
   '           ObjMt202103.SetField "E11INWTRD", CamposMt202103.A127_E11INWTRD
   '           ObjMt202103.SetField "E21INWTRD", CamposMt202103.A128_E21INWTRD
   '           ObjMt202103.SetField "E31INWTRD", CamposMt202103.A129_E31INWTRD
   '           ObjMt202103.SetField "E41INWTRD", CamposMt202103.A130_E41INWTRD
   '           ObjMt202103.SetField "E01INWTRI", CamposMt202103.A131_E01INWTRI
   '           ObjMt202103.SetField "E01INWSCC", CamposMt202103.A132_E01INWSCC
   '           ObjMt202103.SetField "E01INWSCA", CamposMt202103.A133_E01INWSCA
   '           ObjMt202103.SetField "E01INWRCC", CamposMt202103.A134_E01INWRCC
   '           ObjMt202103.SetField "E01INWRRA", CamposMt202103.A135_E01INWRRA
   ObjMt202103.SetField "E01INWBID", CamposMt202103.A136_E01INWBID
   ObjMt202103.SetField "E01INWOID", CamposMt202103.A137_E01INWOID
   
   ObjMt202103.SetField "E01INWOCT", CamposMt202103.A138_E01INWOCT
   
   ObjMt202103.SetField "E01INWBIS", CamposMt202103.A139_E01INWBIS
   
   ObjMt202103.SetField "E01INWBAC", CamposMt202103.A140_E01INWBAC
   ObjMt202103.SetField "E01INWRBI", CamposMt202103.A141_E01INWRBI
   ObjMt202103.SetField "E01INWACI", CamposMt202103.A142_E01INWACI
   ObjMt202103.SetField "E01INWDAT", CamposMt202103.A143_E01INWDAT
   ObjMt202103.SetField "E01INWCAT", CamposMt202103.A144_E01INWCAT
   ObjMt202103.SetField "E01INWCNL", Val(CamposMt202103.A145_E01INWCNL)
   ObjMt202103.SetField "E01INWPTY", CamposMt202103.A146_E01INWPTY
   
   ObjMt202103.SetField "E01INWSST", CamposMt202103.N001_E01INWSST
   ObjMt202103.SetField "E01INWFL4", CamposMt202103.N002_E01INWFL4
   ObjMt202103.SetField "E01INWFL5", CamposMt202103.N003_E01INWFL5
   ObjMt202103.SetField "E01INWFL6", CamposMt202103.N004_E01INWFL6
   ObjMt202103.SetField "E01INWOIS", CamposMt202103.N005_E01INWOIS
   
   ObjMt202103.SetField "E01PRUCR1", CamposMt202103.N006_E01PRUCR1
   ObjMt202103.SetField "E01PRUCR2", CamposMt202103.N007_E01PRUCR2
   ObjMt202103.SetField "E01PRUCR3", CamposMt202103.N008_E01PRUCR3
   ObjMt202103.SetField "E01PRUCR4", CamposMt202103.N009_E01PRUCR4
   ObjMt202103.SetField "E01PRUCR5", CamposMt202103.N010_E01PRUCR5
   ObjMt202103.SetField "E01PRUCR6", CamposMt202103.N011_E01PRUCR6
   ObjMt202103.SetField "E01PRUCR7", CamposMt202103.N012_E01PRUCR7
   ObjMt202103.SetField "E01PRUCR8", CamposMt202103.N013_E01PRUCR8
   ObjMt202103.SetField "E01PRUCR9", CamposMt202103.N014_E01PRUCR9
   ObjMt202103.SetField "E01PRUC10", CamposMt202103.N015_E01PRUC10
   
   ObjMt202103.SetField "E01INWPYM", CDbl(CamposMt202103.G016_E01INWPYM)
   ObjMt202103.SetField "E01INWPYD", CDbl(CamposMt202103.G017_E01INWPYD)
   ObjMt202103.SetField "E01INWPYY", CDbl(CamposMt202103.G018_E01INWPYY)
   
   ObjMt202103.Timeout = 2
   ObjMt202103.FirstErr = True
   ObjMt202103.Trace = True
   ObjMt202103.Host = SqlHost
   ObjMt202103.Port = SqlPort
   Call EscribeLogError(0, "Antes de Enviar Operación : " & Trim(CamposMt202103.A033_E01INWSRF))
   ErrorEnvio = ObjMt202103.Send
   Call EscribeLogError(0, "Despues de Enviar Operación : " & Trim(CamposMt202103.A033_E01INWSRF))
   If ErrorEnvio = 10060 Then
      EnvioMt = ok
      Call EscribeLogError(0, "Envio de Operación en forma correcta : " & Trim(CamposMt202103.A033_E01INWSRF))
      Exit Function
   End If
   
   Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "MotorAs400", "01", "Escritura Pagos", CStr(ErrorEnvio), " ", " ")
   Call EscribeLogError(ErrorEnvio, Err.Description)
   EnvioMt = Error

Exit Function
ErrorInterno:
    MsgBox Err.Description, vbExclamation, TITSISTEMA
    Call EscribeLogError(Err.Number, Err.Description)
End Function

Public Function EscribeLogError(ByVal ErrorNumero As Variant, ByVal ErrorDescripcion As Variant)
   On Error GoTo ErrorEscritura
   Dim iFileHost  As String
   Static iContador  As Integer
   iContador = 0
   
   Close #1
   Open "C:\ErrorEnvioAs400.txt" For Append As #1
   Print #1, Format(Date, "ddmmyyyy") & ";" & Format(Time, "hh:mm:ss") & ";" & CStr(ErrorNumero) & ";" & ErrorDescripcion
   Close #1
   
   On Error GoTo 0
Exit Function
ErrorEscritura:
   If Err.Number = 53 Then
      
      If iContador > 2 Then
         On Error GoTo 0
         Exit Function
      End If
      iContador = iContador + 1
      iFileHost = FreeFile
      
      Open "C:\ErrorEnvioAs400.txt" For Output As iFileHost
      Print #1, "Fecha; Hora; Error; Descripción"
      Close iFileHost
      Resume
   End If
   On Error GoTo 0
End Function

Private Function fCampoInterfaz(Formato As TipoCaracter, oCampo As Variant, largo As Integer, oCantidadDecimales As Variant) As Variant
   On Error GoTo ErrorXXX
   Dim oRetorno        As Variant
   Dim oDecimales      As Variant
   Dim oEntero         As Variant
   Dim oValorNumerico  As Double

   If Formato = Caracter Then
      If Len(oCampo) > largo Then
         oCampo = Mid(oCampo, 1, largo)
      End If
      oRetorno = oCampo & String(largo - Len(oCampo), " ")
   End If

   If Formato = Numerico Then
      If oCantidadDecimales > 0 Then
         If InStr(1, oCampo, ",") > 0 Then
            oRetorno = Replace(oCampo, ",", ".")
         End If
         oRetorno = oCampo
      Else
         oRetorno = String(largo - Len(Mid(oCampo, 1, largo)), "0") & Mid(oCampo, 1, largo)
      End If
   End If

   If Formato = Fecha Then
      oRetorno = Format(CDate(oCampo), "yyyymmdd")
   End If

   fCampoInterfaz = oRetorno
   On Error GoTo 0
   
Exit Function
ErrorXXX:
   
   On Error GoTo 0
End Function


Public Sub EscribeLogMPagos(ByVal Sistema As String, ByVal Operacion As Long, ByVal Moneda As Variant, ByVal Estado As String, ByVal Proceso As Variant, ByVal Mensaje As Variant)
   Dim oTerminal  As String
   On Error GoTo WriteRaiseError
   
   oTerminal = IIf(IsNull(UCase(Trim(Environ("ComputerName")))) = True, gsBac_IP, UCase(Trim(Environ("ComputerName"))))
      
   Envia = Array()
   AddParam Envia, CDbl(1)
   AddParam Envia, CStr(gsbac_fecp)
   AddParam Envia, CStr(gsBAC_User)
   AddParam Envia, CStr(oTerminal)
   AddParam Envia, CStr(Sistema)
   AddParam Envia, CDbl(Operacion)
   AddParam Envia, CStr(Moneda)
   AddParam Envia, CStr(Estado)
   AddParam Envia, CStr(Proceso)
   AddParam Envia, CStr(Mensaje)
   If Not Bac_Sql_Execute("SERVICIO_LOGEVENTOMOTORPAGOS", Envia) Then
      GoTo WriteRaiseError
   End If
   
   On Error GoTo 0
Exit Sub
WriteRaiseError:
   On Error GoTo 0
End Sub
