VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "PosicionCambio"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private OBJ_POSCAM   As New ComAs400Internet.EPC000101
Private SqlHost      As Variant
Private SqlPort      As Variant
Private SqlProg      As Variant
Private SqlUser      As Variant
Private SqlSrv       As Variant
Private ErrorEnvio   As Variant

Private Enum TipoCaracter
    [Numerico] = 0
    [Caracter] = 1
    [AlfaNumerico] = 2
    [Fecha] = 3
End Enum

Private Type MSG_POSCAMBIO
   A_001_H01USERID   As Variant
   A_002_H01PROGRM   As Variant
   A_003_H01TIMSYS   As Variant
   A_004_H01SCRCOD   As Variant
   A_005_H01OPECOD   As Variant
   A_006_H01FLGMAS   As Variant
   A_007_H01FLGWK1   As Variant
   A_008_H01FLGWK2   As Variant
   A_009_H01FLGWK3   As Variant
   A_010_PCFECING    As Variant
   A_011_PCNUMOPE    As Variant
   A_012_PCTIPOPE    As Variant
   A_013_PCRUTCLI    As Variant
   A_014_PCMONORI    As Variant
   A_015_PCMTOORI    As Variant
   A_016_PCMONEQU    As Variant
   A_017_PCMTOEQU    As Variant
   A_018_PCMTOCAM    As Variant
   A_019_PCPARIDA    As Variant
   A_020_PCTIPMER    As Variant
   A_021_PCFORPAG    As Variant
   A_022_PCESTADO    As Variant
   A_023_PCUSUARIO   As Variant
End Type
Private MSG_POSCAM   As MSG_POSCAMBIO

Private Sub Class_Initialize()
   Dim ArchIni       As String
   Dim DboIni        As String

   Let ArchIni = "Bac-Sistemas.ini"
   If Dir(App.Path & "\" & ArchIni) = "" Then
      Call MsgBox("Archivo de configuraciones no Encontrado.", vbExclamation, TITSISTEMA)
      End
   End If
   Let ArchIni = App.Path & "\" & ArchIni
   Let DboIni = Func_Read_INI("INI", "DBO_PATH", ArchIni) & "DBO.INI"
   
   Let SqlHost = Func_Read_INI("Spot", "H", DboIni)
   Let SqlPort = Func_Read_INI("Spot", "P", DboIni)
   Let SqlUser = Func_Read_INI("Spot", "U", DboIni)
    Let SqlSrv = Func_Read_INI("Spot", "S", DboIni)
End Sub

Private Sub Class_Terminate()
   Set OBJ_POSCAM = Nothing
End Sub

Function Llenar_Clase(ByRef Array_ As Variant) As Boolean
   On Error GoTo ERROR_DATOS
   
   Let Llenar_Clase = False
   
   Let MSG_POSCAM.A_001_H01USERID = SqlUser
   Let MSG_POSCAM.A_002_H01PROGRM = SqlSrv
   Let MSG_POSCAM.A_003_H01TIMSYS = OBJ_POSCAM.getTimeStamp()
   Let MSG_POSCAM.A_004_H01SCRCOD = fCampoInterfaz(Caracter, Array_(4), 2, 0)
   Let MSG_POSCAM.A_005_H01OPECOD = fCampoInterfaz(Caracter, Array_(5), 4, 0)
   Let MSG_POSCAM.A_006_H01FLGMAS = fCampoInterfaz(Caracter, Array_(6), 1, 0)
   Let MSG_POSCAM.A_007_H01FLGWK1 = fCampoInterfaz(Caracter, Array_(7), 1, 0)
   Let MSG_POSCAM.A_008_H01FLGWK2 = fCampoInterfaz(Caracter, Array_(8), 1, 0)
   Let MSG_POSCAM.A_009_H01FLGWK3 = fCampoInterfaz(Caracter, Array_(9), 1, 0)
    Let MSG_POSCAM.A_010_PCFECING = fCampoInterfaz(Numerico, Array_(10), 8, 0)
    Let MSG_POSCAM.A_011_PCNUMOPE = fCampoInterfaz(Numerico, Array_(11), 6, 0)
    Let MSG_POSCAM.A_012_PCTIPOPE = fCampoInterfaz(Caracter, Array_(12), 6, 0)
    Let MSG_POSCAM.A_013_PCRUTCLI = fCampoInterfaz(Caracter, Array_(13), 15, 0)
    Let MSG_POSCAM.A_014_PCMONORI = fCampoInterfaz(Caracter, Array_(14), 3, 0)
    Let MSG_POSCAM.A_015_PCMTOORI = fCampoInterfaz(Numerico, Array_(15), 17, 4)
    Let MSG_POSCAM.A_016_PCMONEQU = fCampoInterfaz(Caracter, Array_(16), 3, 0)
    Let MSG_POSCAM.A_017_PCMTOEQU = fCampoInterfaz(Numerico, Array_(17), 17, 4)
    Let MSG_POSCAM.A_018_PCMTOCAM = fCampoInterfaz(Numerico, Array_(18), 15, 4)
    Let MSG_POSCAM.A_019_PCPARIDA = fCampoInterfaz(Numerico, Array_(19), 15, 4)
    Let MSG_POSCAM.A_020_PCTIPMER = fCampoInterfaz(Numerico, Array_(20), 1, 0)
    Let MSG_POSCAM.A_021_PCFORPAG = fCampoInterfaz(Caracter, Array_(21), 30, 0)
    Let MSG_POSCAM.A_022_PCESTADO = fCampoInterfaz(Caracter, Array_(22), 1, 0)
   Let MSG_POSCAM.A_023_PCUSUARIO = fCampoInterfaz(Caracter, Array_(23), 15, 0)

   Let Llenar_Clase = True

   On Error GoTo 0
Exit Function
ERROR_DATOS:
   On Error GoTo 0
   Exit Function
End Function

Function Enviar_Mensaje(ByVal cEstado As String) As Boolean
   On Error GoTo ERROR_ENVIO
   Dim iContador     As Integer
   Dim iRegistros    As Integer
   Dim iCodEstado    As String
   Dim oDatos()

   Let Enviar_Mensaje = False
   Let Screen.MousePointer = vbHourglass
   Let iRegistros = IIf(cEstado = "E", 2, 1)
   
   For iContador = 1 To IIf(cEstado = "E", 2, 1)
      If iRegistros = 1 Then
         Let iCodEstado = "0001"                             '--> Solo Envia
      Else
         Let iCodEstado = IIf(iContador = 1, "0002", "0001") '--> Anula y Envia (Modificación Por Servicio)
      End If
      
      OBJ_POSCAM.SetField "H01USERID", MSG_POSCAM.A_001_H01USERID
      OBJ_POSCAM.SetField "H01PROGRM", MSG_POSCAM.A_002_H01PROGRM
      OBJ_POSCAM.SetField "H01TIMSYS", MSG_POSCAM.A_003_H01TIMSYS
      OBJ_POSCAM.SetField "H01SCRCOD", MSG_POSCAM.A_004_H01SCRCOD
      OBJ_POSCAM.SetField "H01OPECOD", iCodEstado '--> MSG_POSCAM.A_005_H01OPECOD
      OBJ_POSCAM.SetField "H01FLGMAS", MSG_POSCAM.A_006_H01FLGMAS
      OBJ_POSCAM.SetField "H01FLGWK1", MSG_POSCAM.A_007_H01FLGWK1
      OBJ_POSCAM.SetField "H01FLGWK2", MSG_POSCAM.A_008_H01FLGWK2
      OBJ_POSCAM.SetField "H01FLGWK3", MSG_POSCAM.A_009_H01FLGWK3
      OBJ_POSCAM.SetField "PCFECING", MSG_POSCAM.A_010_PCFECING
      OBJ_POSCAM.SetField "PCNUMOPE", MSG_POSCAM.A_011_PCNUMOPE
      OBJ_POSCAM.SetField "PCTIPOPE", MSG_POSCAM.A_012_PCTIPOPE
      OBJ_POSCAM.SetField "PCRUTCLI", MSG_POSCAM.A_013_PCRUTCLI
      OBJ_POSCAM.SetField "PCMONORI", MSG_POSCAM.A_014_PCMONORI
      OBJ_POSCAM.SetField "PCMTOORI", MSG_POSCAM.A_015_PCMTOORI
      OBJ_POSCAM.SetField "PCMONEQU", MSG_POSCAM.A_016_PCMONEQU
      OBJ_POSCAM.SetField "PCMTOEQU", MSG_POSCAM.A_017_PCMTOEQU
      OBJ_POSCAM.SetField "PCMTOCAM", MSG_POSCAM.A_018_PCMTOCAM
      OBJ_POSCAM.SetField "PCPARIDA", MSG_POSCAM.A_019_PCPARIDA
      OBJ_POSCAM.SetField "PCTIPMER", MSG_POSCAM.A_020_PCTIPMER
      OBJ_POSCAM.SetField "PCFORPAG", MSG_POSCAM.A_021_PCFORPAG
      OBJ_POSCAM.SetField "PCESTADO", MSG_POSCAM.A_022_PCESTADO
      OBJ_POSCAM.SetField "PCUSUARIO", MSG_POSCAM.A_023_PCUSUARIO

      OBJ_POSCAM.Timeout = 2
      OBJ_POSCAM.FirstErr = True
      OBJ_POSCAM.Trace = True
      OBJ_POSCAM.Host = SqlHost
      OBJ_POSCAM.Port = SqlPort

      ErrorEnvio = OBJ_POSCAM.Send

      Call BacControlWindows(10)

      If ErrorEnvio = 0 Or ErrorEnvio = 10060 Then
         
         If iRegistros = 2 Then
            Envia = Array()
            AddParam Envia, Format(gsbac_fecp)
            AddParam Envia, CDbl(MSG_POSCAM.A_011_PCNUMOPE)
            AddParam Envia, gsBAC_User
            AddParam Envia, IIf(iCodEstado = "0002", "S", "N")
            AddParam Envia, "N"
            Call Bac_Sql_Execute("BacParamSuda.dbo.SP_GENERA_LOG_POSCAM", Envia)
         End If
         
         If ErrorEnvio = 0 Then
            Let Enviar_Mensaje = True
            On Error GoTo 0
            Let Screen.MousePointer = vbDefault
            Exit Function
         End If
      Else
         Envia = Array()
         AddParam Envia, Format(gsbac_fecp)
         AddParam Envia, CDbl(MSG_POSCAM.A_011_PCNUMOPE)
         AddParam Envia, gsBAC_User
         AddParam Envia, IIf(iCodEstado = "0002", "S", "N")
         AddParam Envia, "S"
         Call Bac_Sql_Execute("BacParamSuda.dbo.SP_GENERA_LOG_POSCAM", Envia)
         
         Call WriteErrorLog(ErrorEnvio, "Error en envio de operación : " & Trim(MSG_POSCAM.A_011_PCNUMOPE))
         Exit Function
      End If
      
   Next iContador
   
   Let Screen.MousePointer = vbDefault
   
   On Error GoTo 0
Exit Function
ERROR_ENVIO:
   On Error GoTo 0
End Function


Private Function WriteErrorLog(ByVal Error_ As Variant, ByVal Description_ As Variant)
   On Error GoTo WriteError
   Static iContador  As Integer
   Dim iFileHost     As String

   iContador = 0
   
   Close #1
   Open "C:\POSCAM_ERR_.TXT" For Append As #1
   Print #1, Format(Date, "ddmmyyyy") & ";" & Format(Time, "hh:mm:ss") & ";" & CStr(Error_) & ";" & Description_
   Close #1
   
   On Error GoTo 0
Exit Function
WriteError:

   If Err.Number = 53 Then
      If iContador > 2 Then
         On Error GoTo 0
         Exit Function
      End If
      iContador = iContador + 1
      iFileHost = FreeFile
      
      Open "C:\POSCAM_ERR_.TXT" For Output As iFileHost
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

