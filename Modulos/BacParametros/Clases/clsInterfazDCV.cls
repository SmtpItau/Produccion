VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsInterfazDCV"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private PathFile                  As String

Public Enum CodFileImput
   [01 Archivo de Notificaciones] = 3
   [02_Archivo Diario de Generaciones] = 4
   [03_Valorizacion de Contratos] = 5
   [04_Informe de Vencimientos] = 6
   [05_Informe_Generacion_Solicitud] = 7
End Enum

Private Enum Estatus
    [Error] = 1
    [ok] = 0
End Enum

Private Enum TipoCaracter
    [Numerico] = 0
    [Caracter] = 1
    [AlfaNumerico] = 2
    [Fecha] = 3
    [Monto] = 4
End Enum

Private Enum xDescripction
   [Maxima Fecha Suscripcion] = 7
   [Modalidad Cumplimiento] = 9
   [Fecha de Pago] = 13
   [Forma de Pago] = 14
   [T/Cambio Ref.] = 16
End Enum

Public DCV_RutBanco               As Variant
Public DCV_Codbanco               As Variant
Public DCV_RutDCV                 As Variant
Public DCV_CodDCV                 As Variant

Private Type DCV_RegIdentificador
   DCV101_TipoRegistro            As Variant
   DCV102_FechaGeneracion         As Variant
   DCV103_HoraGeneracion          As Variant
   DCV104_DescripcionArchivo      As Variant
   DCV105_NombreLogico            As Variant
   DCV106_RutOriginador           As Variant
   DCV107_CodClienteOrig          As Variant
   DCV108_RutDestinatario         As Variant
   DCV109_CodDCVClienteDestino    As Variant
End Type
Private DCV_RegistroIdentificador As DCV_RegIdentificador

Private Type DCV_RegContrato
   DCV201_TipoRegistro            As Variant
   DCV202_IdContrato              As Variant
   DCV203_FechaRegistro           As Variant
   DCV204_TipoOperacion           As Variant
   DCV205_TipoTransaccion         As Variant
   DCV206_RutContraparte          As Variant
   DCV207_CodDepositante          As Variant
   DCV208_FechaMaxSuscripcion     As Variant
   DCV209_FechaVencimiento        As Variant
   DCV210_ModalidadCumplimiento   As Variant
   DCV211_MontoContrato           As Variant
   DCV212_PrecioForward           As Variant
   DCV213_PrecioPactado           As Variant
   DCV214_FechaPago               As Variant
   DCV215_FormaPago               As Variant
   DCV216_MonedaCompensacion      As Variant
   DCV217_TipoContrato            As Variant
End Type
Private DCV_Registro              As DCV_RegContrato

Private Type DCV_RegControl
   DCV901_TipoRegistro            As Variant
   DCV902_TotalRegistros          As Variant
   DCV903_TotalNocional           As Variant
   DCV904_TotalPrecio             As Variant
End Type
Private DVC_RegistroControl       As DCV_RegControl

Public Enum ArchivosDCV
            [ARCHIVO DE CONTRATOS] = 1 '--> 3.1
         [ARCHIVO DE NOTIFICACION] = 3.2
   [INFORME DE CONTRATOS VIGENTES] = 4.1
     [INFORME CONTRATOS SUSCRITOS] = 4.2
              [INFORME VENCIMINTO] = 5.1
               [INFORME SOLICITUD] = 6.1
End Enum

'->    Recepcion de Archivos
Public DCV_Recep_01_TipoRegistro          As Integer
Public DCV_Recep_02_FechaGeneracion       As String
Public DCV_Recep_03_HoraGeneracion        As String
Public DCV_Recep_04_DescripcionArchivo    As String
Public DCV_Recep_05_NombreLogico          As String
Public DCV_Recep_06_RutOriginador         As Long
Public DCV_Recep_07_CodOriginador         As Long
Public DCV_Recep_08_RutDestinatario       As Long
Public DCV_Recep_09_CodDestinatario       As Long
Public DCV_Recep_10_DatosMensaje          As String
Public DCV_Recep_11_CodigoMensaje         As Long
Public DCV_Recep_12_DescripcionMensaje    As String
'->    Recepcion de Archivos


Public Function FuncChekFileIn(ByVal nRegister As Variant, ByRef nFileImput As Variant) As Boolean
   Dim cNombreLogico    As String
   Dim Sqldatos()

   Let FuncChekFileIn = False

   Let cNombreLogico = Mid(nRegister, 54, 15)

   Envia = Array()
   AddParam Envia, cNombreLogico
   If Not Bac_Sql_Execute("dbo.SP_CHECKIN", Envia) Then
      Let FuncChekFileIn = False:         Let nFileImput = -1
   End If
   If Bac_SQL_Fetch(Sqldatos()) Then
      Let FuncChekFileIn = Sqldatos(1):   Let nFileImput = Sqldatos(2)
   End If

   Let FuncChekFileIn = True
End Function

Public Function FuncSavePathDefault(ByVal NewPath As String, ByVal nCodFile As ArchivosDCV) As String
   Dim cSql    As String
   Dim xPath   As String
   Dim iFile   As Integer
   
   Let xPath = CurDir(NewPath) & "\"
   
   Let iFile = 0
   Let iFile = nCodFile
   Let iFile = 99
   
   Let cSql = ""
   Let cSql = cSql & " UPDATE BacParamSuda.dbo.TBL_ARCHIVOS "
   Let cSql = cSql & "    SET PathDestino = '" & xPath & "' "
   Let cSql = cSql & "  WHERE IdArchivo   = " & iFile
   
   If Not Bac_Sql_Execute(cSql) Then
      Exit Function
   End If
End Function

Public Function FuncLoadPathArchivos() As String
   Dim Sqldatos()
   
   If Not Bac_Sql_Execute("dbo.SP_LOADPATHFILEDCV") Then
      Let FuncLoadPathArchivos = "C:\"
      Exit Function
   End If
   If Bac_SQL_Fetch(Sqldatos()) Then
      If Right(Sqldatos(1), 1) <> "\" Then
         Let Sqldatos(1) = Sqldatos(1) & "\"
      End If
      Let FuncLoadPathArchivos = Sqldatos(1)
   End If

End Function

Private Sub Class_Initialize()
   Dim Sqldatos()
   
   Envia = Array()
   If Not Bac_Sql_Execute("dbo.SP_LEER_DATOS_REG_TIPO_1") Then
      Exit Sub
   End If
   If Bac_SQL_Fetch(Sqldatos()) Then
      Let DCV_RutBanco = Sqldatos(1)
      Let DCV_Codbanco = Sqldatos(2)
        Let DCV_RutDCV = Sqldatos(3)
        Let DCV_CodDCV = Sqldatos(4)
   End If
End Sub

Private Function FuncGenRegControl(xNocional As Double, xPrecio As Double, nCantRegistros As Long) As String

   Let DVC_RegistroControl.DCV901_TipoRegistro = "9"
   Let DVC_RegistroControl.DCV902_TotalRegistros = xFormatField(Numerico, nCantRegistros, 5, 0)
   Let DVC_RegistroControl.DCV903_TotalNocional = xFormatField(Monto, xNocional, 14, 10)
   Let DVC_RegistroControl.DCV904_TotalPrecio = xFormatField(Monto, xPrecio, 14, 10)

   Let FuncGenRegControl = ""
   Let FuncGenRegControl = FuncGenRegControl & DVC_RegistroControl.DCV901_TipoRegistro
   Let FuncGenRegControl = FuncGenRegControl & DVC_RegistroControl.DCV902_TotalRegistros
   Let FuncGenRegControl = FuncGenRegControl & DVC_RegistroControl.DCV903_TotalNocional
   Let FuncGenRegControl = FuncGenRegControl & DVC_RegistroControl.DCV904_TotalPrecio
   
End Function

Private Function FuncGenRegIdentificacion(ByVal sFilename As String) As Variant
   Dim xRutBanco  As String

   Let DCV_RegistroIdentificador.DCV101_TipoRegistro = 1
   Let DCV_RegistroIdentificador.DCV102_FechaGeneracion = Format(gsbac_fecp, "yyyymmdd")
   Let DCV_RegistroIdentificador.DCV103_HoraGeneracion = Format(Time, "hhmm")
   Let DCV_RegistroIdentificador.DCV104_DescripcionArchivo = "Registro Masivo de operaciones Forward. "
   Let DCV_RegistroIdentificador.DCV105_NombreLogico = "FWD_REGISTRO   "
   Let DCV_RegistroIdentificador.DCV106_RutOriginador = DCV_RutBanco
   Let DCV_RegistroIdentificador.DCV107_CodClienteOrig = DCV_Codbanco
   Let DCV_RegistroIdentificador.DCV108_RutDestinatario = DCV_RutDCV
   Let DCV_RegistroIdentificador.DCV109_CodDCVClienteDestino = DCV_CodDCV

   Let FuncGenRegIdentificacion = ""
   Let FuncGenRegIdentificacion = FuncGenRegIdentificacion & DCV_RegistroIdentificador.DCV101_TipoRegistro
   Let FuncGenRegIdentificacion = FuncGenRegIdentificacion & DCV_RegistroIdentificador.DCV102_FechaGeneracion
   Let FuncGenRegIdentificacion = FuncGenRegIdentificacion & DCV_RegistroIdentificador.DCV103_HoraGeneracion
   Let FuncGenRegIdentificacion = FuncGenRegIdentificacion & DCV_RegistroIdentificador.DCV104_DescripcionArchivo
   Let FuncGenRegIdentificacion = FuncGenRegIdentificacion & DCV_RegistroIdentificador.DCV105_NombreLogico
   Let FuncGenRegIdentificacion = FuncGenRegIdentificacion & DCV_RegistroIdentificador.DCV106_RutOriginador
   Let FuncGenRegIdentificacion = FuncGenRegIdentificacion & DCV_RegistroIdentificador.DCV107_CodClienteOrig
   Let FuncGenRegIdentificacion = FuncGenRegIdentificacion & DCV_RegistroIdentificador.DCV108_RutDestinatario
   Let FuncGenRegIdentificacion = FuncGenRegIdentificacion & DCV_RegistroIdentificador.DCV109_CodDCVClienteDestino

End Function

Public Function FuncGenIntDcv_Contratos(ByRef MiGrilla As MSFlexGrid, ByVal nCodFile As ArchivosDCV, ByVal nIndicadorGrupo As Long) As Boolean
   Dim SqlRetornoEnvia()
   Dim Sqldatos()
   Dim nRow             As Long
   Dim nFileName        As String
   Dim cRegCabecera     As String
   Dim cRegDetalle01    As String
   Dim cRegDetalle02    As String
   Dim cRegDetalle03    As String
   Dim cRegDetalle04    As String
   Dim cRegControl      As String
   Dim cPathFile        As String
   Dim xZumatoriaNoc    As Double
   Dim xZumatoriaPrc    As Double
   Dim nRegistrosDet    As Long
     
   Let FuncGenIntDcv_Contratos = False
   
   Let nRegistrosDet = 0
   
   SqlRetornoEnvia = Array()
   
   Envia = Array()
   Call AddParam(Envia, nIndicadorGrupo)
   If Not Bac_Sql_Execute("dbo.SP_LEER_OPERACIONES_GRUPO", Envia) Then
      Exit Function
   End If
   Do While Bac_SQL_Fetch(Sqldatos())
      Call AddParam(SqlRetornoEnvia, Sqldatos(2) & Space(100) & Sqldatos(1))
   Loop

   Let xZumatoriaNoc = 0#
   Let xZumatoriaPrc = 0#

   Let cRegDetalle01 = ""
   Let cRegDetalle02 = ""
   Let cRegDetalle03 = ""
   Let cRegDetalle04 = ""

   Let nFileName = FuncLeerNombreArchivo(nCodFile, nIndicadorGrupo)
   
   If Dir(PathFile & nFileName) <> "" Then
      Call Kill(PathFile & nFileName)
   End If

   Open (PathFile & nFileName) For Output As #1

   Print #1, FuncGenRegIdentificacion(nFileName)

   For nRow = LBound(SqlRetornoEnvia) To UBound(SqlRetornoEnvia)

      Envia = Array()
      Call AddParam(Envia, CDbl(Trim(Mid(SqlRetornoEnvia(nRow), 1, 50))))
      Call AddParam(Envia, Trim(Right(SqlRetornoEnvia(nRow), 5)))
      If Not Bac_Sql_Execute("dbo.SVC_RETORNA_ENVIO", Envia) Then
         GoTo ErrorClose
         Exit Function
      End If
      Do While Bac_SQL_Fetch(Sqldatos())
         Let nRegistrosDet = nRegistrosDet + 1

         Let DCV_Registro.DCV201_TipoRegistro = xFormatField(Caracter, Sqldatos(2), 1, 0)
         Let DCV_Registro.DCV202_IdContrato = xFormatField(Caracter, Sqldatos(5), 20, 0)
         Let DCV_Registro.DCV203_FechaRegistro = xFormatField(Fecha, Sqldatos(6), 8, 0)
         Let DCV_Registro.DCV204_TipoOperacion = xFormatField(Caracter, Sqldatos(7), 20, 0)
         Let DCV_Registro.DCV205_TipoTransaccion = xFormatField(Caracter, Sqldatos(8), 3, 0)
         Let DCV_Registro.DCV206_RutContraparte = xFormatField(Caracter, Sqldatos(9), 10, 0)
         Let DCV_Registro.DCV207_CodDepositante = xFormatField(Numerico, Sqldatos(10), 5, 0)
         Let DCV_Registro.DCV208_FechaMaxSuscripcion = xFormatField(Numerico, Sqldatos(11), 1, 0)     '-->  Codificacion : [1= hasta el dia del vcto]; [2=entre el dia y el siguiente habil]
         Let DCV_Registro.DCV209_FechaVencimiento = xFormatField(Fecha, Sqldatos(12), 8, 0)
         Let DCV_Registro.DCV210_ModalidadCumplimiento = xFormatField(Numerico, Sqldatos(13), 1, 0)
         Let DCV_Registro.DCV211_MontoContrato = xFormatField(Monto, Sqldatos(14), 12, 4)
         Let DCV_Registro.DCV212_PrecioForward = xFormatField(Monto, Sqldatos(15), 12, 10)
         Let DCV_Registro.DCV213_PrecioPactado = xFormatField(Monto, Sqldatos(16), 14, 4)
         Let DCV_Registro.DCV214_FechaPago = xFormatField(Numerico, Sqldatos(17), 1, 0)
         Let DCV_Registro.DCV215_FormaPago = xFormatField(Numerico, Sqldatos(18), 1, 0)
         Let DCV_Registro.DCV216_MonedaCompensacion = xFormatField(Caracter, Sqldatos(19), 3, 0)
         Let DCV_Registro.DCV217_TipoContrato = xFormatField(Numerico, Sqldatos(20), 2, 0)

         Let xZumatoriaNoc = xZumatoriaNoc + Sqldatos(14)
         Let xZumatoriaPrc = xZumatoriaPrc + Sqldatos(15)

         If Sqldatos(2) = 1 Then
            Let cRegDetalle01 = cRegDetalle01 & ""
            Print #1, cRegDetalle01
         End If

         If Sqldatos(2) = 2 Then
            Let cRegDetalle02 = ""
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV201_TipoRegistro
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV202_IdContrato
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV203_FechaRegistro
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV204_TipoOperacion
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV205_TipoTransaccion
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV206_RutContraparte
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV207_CodDepositante
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV208_FechaMaxSuscripcion
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV209_FechaVencimiento
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV210_ModalidadCumplimiento
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV211_MontoContrato
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV212_PrecioForward
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV213_PrecioPactado
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV214_FechaPago
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV215_FormaPago
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV216_MonedaCompensacion
            Let cRegDetalle02 = cRegDetalle02 & DCV_Registro.DCV217_TipoContrato
            Print #1, cRegDetalle02
         End If

         If Sqldatos(2) = 3 Then
            Let cRegDetalle03 = cRegDetalle03 & ""
            Print #1, cRegDetalle02
         End If
         If Sqldatos(2) = 4 Then
            Let cRegDetalle04 = cRegDetalle04 & ""
            Print #1, cRegDetalle02
         End If
      Loop

   Next nRow
   
   Print #1, FuncGenRegControl(xZumatoriaNoc, xZumatoriaPrc, nRegistrosDet)

   Close #1

   Envia = Array()
   Call AddParam(Envia, nIndicadorGrupo)
   Call AddParam(Envia, "S")
   If Not Bac_Sql_Execute("dbo.SP_LEER_OPERACIONES_GRUPO", Envia) Then
      Exit Function
   End If

   Let FuncGenIntDcv_Contratos = True

   Call MsgBox("[ Control de Generación ]" & vbCrLf & vbCrLf & "Archivo generado correctamente en :" & vbCrLf & vbCrLf & PathFile & nFileName, vbInformation, App.Title)

Exit Function
ErrorClose:
   Close #1
End Function


Private Function FuncLeerNombreArchivo(ByVal nCodInterfaz As ArchivosDCV, ByVal nCodNumerico As Long) As String
   Dim Sqldatos()
   Dim xTmp          As String
   Dim xFileName     As String
   Dim nCantNumeros  As Long
   
   Let FuncLeerNombreArchivo = ""

   Envia = Array()
   AddParam Envia, nCodInterfaz
   If Not Bac_Sql_Execute("dbo.SP_READNOMFILE", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Sqldatos()) Then
      If Sqldatos(1) > 0 Then
         Let xFileName = Sqldatos(2)
         Let PathFile = Sqldatos(3)
      End If
   End If
   
   If Right(PathFile, 1) <> "\" Then
      Let PathFile = PathFile & "\"
   End If

   Let xFileName = Replace(xFileName, "DDMMYYYY", Format(gsbac_fecp, "DDMMYYYY"))
   Let xFileName = Replace(xFileName, "YYYYMMDD", Format(gsbac_fecp, "YYYYMMDD"))
   Let xFileName = Replace(xFileName, "DDMMYY", Format(gsbac_fecp, "DDMMYY"))
   Let xFileName = Replace(xFileName, "YYMMDD", Format(gsbac_fecp, "YYMMDD"))
   Let xFileName = Replace(xFileName, "HHMMSS", Format(Time, "HHMMSS"))
   Let xFileName = Replace(xFileName, "HHMM", Format(Time, "HHMM"))
   
   Let xFileName = Replace(xFileName, "coddep", Format(nCodNumerico, "0000"))
   
   Let nCantNumeros = FuncReadCantNumber(xFileName)
   If nCantNumeros > 0 Then
      Let xTmp = Format(nCodNumerico, String(nCantNumeros, "0"))
      Let xFileName = Replace(xFileName, String(nCantNumeros, "X"), xTmp)
   End If
   
   Let FuncLeerNombreArchivo = xFileName
End Function

Private Function FuncReadCantNumber(ByVal MyFile As String) As Long
   Dim nContador  As Long
   Dim nCantidad  As Long
   
   Let FuncReadCantNumber = 0
   Let nCantidad = FuncReadCantNumber
   
   For nContador = 1 To Len(MyFile)
      If UCase(Mid(MyFile, nContador, 1)) = "X" Then
         Let nCantidad = nCantidad + 1
      End If
   Next nContador
   
   Let FuncReadCantNumber = nCantidad
End Function

Public Function GetName_FileNotification() As String
   Let GetName_FileNotification = FuncLeerNombreArchivo([ARCHIVO DE NOTIFICACION], 2)
End Function

Private Function xFormatField(Formato As TipoCaracter, oCampo As Variant, largo As Integer, oCantidadDecimales As Variant) As Variant
   On Error GoTo ErrorXXX
   Dim oRetorno        As Variant
   Dim oDecimales      As Variant
   Dim oEntero         As Variant
   Dim oValorNumerico  As Double
   Dim nFormatdec      As String
   Let nFormatdec = "0." & String(oCantidadDecimales, "0")

   If Formato = Caracter Then
      If Len(oCampo) > largo Then
         oCampo = Mid(oCampo, 1, largo)
      End If
      oRetorno = oCampo & String(largo - Len(oCampo), " ")
   End If

   If Formato = Monto Then
      If oCantidadDecimales > 0 Then
         oRetorno = Replace(oCampo, ",", ".")
         oEntero = Int(oRetorno)
         oDecimales = Round(CDbl(oRetorno) - oEntero, 4)

         '--> [12, 4] = 12345678.1234     = 12
         '--> oRetorno = String(((largo - oCantidadDecimales) - Len(oEntero)), "0") & oEntero & Mid(Trim(Format(oDecimales, nFormatdec)), 3)
         '--> [12, 4] = 123456789012.1234 = 16
         oRetorno = String((largo) - Len(oEntero), "0") & oEntero & Mid(Trim(Format(oDecimales, nFormatdec)), 3)
      Else
         oRetorno = Replace(oCampo, ",", ".")
         oEntero = Int(oRetorno)
         oDecimales = 0

         '--> [12, 4] = 12345678.1234     = 12
         '--> oRetorno = String(((largo - oCantidadDecimales) - Len(oEntero)), "0") & oEntero & Mid(Trim(Format(oDecimales, nFormatdec)), 3)
         '--> [12, 4] = 123456789012.1234 = 16
         oRetorno = String((largo) - Len(oEntero), "0") & oEntero & Mid(Trim(Format(oDecimales, nFormatdec)), 3)
      End If
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

   xFormatField = oRetorno
   On Error GoTo 0
Exit Function
ErrorXXX:
   On Error GoTo 0
End Function


Public Function FuncParcelaInterfaz(ByVal cString As String, ByVal nCodFile As Integer, ByVal iRegistro As Long, ByRef oGrilla As MSFlexGrid) As String
   On Error GoTo ErrorLectura
   Dim nLong   As Long
   Dim nRow    As Long
   Dim nCol    As Long
   
   '->   Se define para contener el Largo acumulado del Registro y Marcar la posición de inicio de corte
   Dim oLargoCompuesto  As Long
   Let oLargoCompuesto = 1
   '----------------------------------------------------------------------------------------------------
   
   '->  parcela la interfaz en su registro de cabecera
   If iRegistro = 1 Then
      If nCodFile = CodFileImput.[04_Informe de Vencimientos] Then
         Let oGrilla.TextMatrix(1, 0) = Mid(cString, oLargoCompuesto, 2):     Let oLargoCompuesto = oLargoCompuesto + 2    '-> Tipo de Registro
         Let oGrilla.TextMatrix(1, 1) = Mid(cString, oLargoCompuesto, 8):     Let oLargoCompuesto = oLargoCompuesto + 8:   '-> Fecha de Generación
         Let oGrilla.TextMatrix(1, 2) = Mid(cString, oLargoCompuesto, 4):     Let oLargoCompuesto = oLargoCompuesto + 4:   '-> Hora de Generación
         Let oGrilla.TextMatrix(1, 3) = Mid(cString, oLargoCompuesto, 40):    Let oLargoCompuesto = oLargoCompuesto + 40   '-> Descripcion del Archivo
         Let oGrilla.TextMatrix(1, 4) = Mid(cString, oLargoCompuesto, 15):    Let oLargoCompuesto = oLargoCompuesto + 15   '-> Nombre Logico del Archivo
         Let oGrilla.TextMatrix(1, 5) = Mid(cString, oLargoCompuesto, 10):    Let oLargoCompuesto = oLargoCompuesto + 10   '-> Rut del Originador
         Let oGrilla.TextMatrix(1, 6) = Mid(cString, oLargoCompuesto, 5):     Let oLargoCompuesto = oLargoCompuesto + 5    '-> Codigo Originador
         Let oGrilla.TextMatrix(1, 7) = Mid(cString, oLargoCompuesto, 10):    Let oLargoCompuesto = oLargoCompuesto + 10   '-> Rut Destinatario
         Let oGrilla.TextMatrix(1, 8) = Mid(cString, oLargoCompuesto, 10):    Let oLargoCompuesto = oLargoCompuesto + 5    '-> Codigo Destinatario
      Else
         Let oGrilla.TextMatrix(1, 0) = Mid(cString, oLargoCompuesto, 1):     Let oLargoCompuesto = oLargoCompuesto + 1    '-> Tipo de Registro
         Let oGrilla.TextMatrix(1, 1) = Mid(cString, oLargoCompuesto, 8):     Let oLargoCompuesto = oLargoCompuesto + 8:   '-> Fecha de Generación
         Let oGrilla.TextMatrix(1, 2) = Mid(cString, oLargoCompuesto, 4):     Let oLargoCompuesto = oLargoCompuesto + 4:   '-> Hora de Generación
         Let oGrilla.TextMatrix(1, 3) = Mid(cString, oLargoCompuesto, 40):    Let oLargoCompuesto = oLargoCompuesto + 40   '-> Descripcion del Archivo
         Let oGrilla.TextMatrix(1, 4) = Mid(cString, oLargoCompuesto, 15):    Let oLargoCompuesto = oLargoCompuesto + 15   '-> Nombre Logico del Archivo
         Let oGrilla.TextMatrix(1, 5) = Mid(cString, oLargoCompuesto, 10):    Let oLargoCompuesto = oLargoCompuesto + 10   '-> Rut del Originador
         Let oGrilla.TextMatrix(1, 6) = Mid(cString, oLargoCompuesto, 5):     Let oLargoCompuesto = oLargoCompuesto + 5    '-> Codigo Originador
         Let oGrilla.TextMatrix(1, 7) = Mid(cString, oLargoCompuesto, 10):    Let oLargoCompuesto = oLargoCompuesto + 10   '-> Rut Destinatario
         Let oGrilla.TextMatrix(1, 8) = Mid(cString, oLargoCompuesto, 10):    Let oLargoCompuesto = oLargoCompuesto + 10   '-> Codigo Destinatario
      End If
   End If
   '----------------------------------------------------------------------------------------------------
   
   '->  parcela la interfaz en sus registros de cuerpo o contenido
   If iRegistro > 1 Then
      '->   Si es el registro de Control, retira la fila asignada para la carga. (9: Determina el Registro de Control; 0: Determina Registro NO Valido)
      If nCodFile = CodFileImput.[04_Informe de Vencimientos] Then
         If Val(Mid(cString, oLargoCompuesto, 2)) = 9 Or Val(Mid(cString, oLargoCompuesto, 2)) = 0 Then
            Exit Function
         End If
      Else
         If Val(Mid(cString, oLargoCompuesto, 1)) = 9 Or Val(Mid(cString, oLargoCompuesto, 1)) = 0 Then
            Exit Function
         End If
      End If

      Let oGrilla.Rows = oGrilla.Rows + 1
              Let nRow = oGrilla.Rows - 1
              Let nCol = 0
      '->   Parcela según las especificaciones del Archivo Seleccionado. (nCodFile)
      If nCodFile = CodFileImput.[01 Archivo de Notificaciones] Then
         Let nLong = 1:    Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> Según (1) : Tipo de Registro (1   Largo)
         Let nLong = 139:  Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> Según (2) : Datos Enviados   (140 Largo)
         Let nLong = 3:    Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> Codigo mensaje               (3   Largo)
         Let nLong = 100:  Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> Descripcion Mensaje          (100 Largo)
      End If
      If nCodFile = CodFileImput.[02_Archivo Diario de Generaciones] Then
         Let nLong = 1:    Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
         Let nLong = 178:  Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 02 - Según (1)
         Let nLong = 50:   Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 03 - Según (2)
         Let nLong = 656:  Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 04 - Según (3)
      End If
      If nCodFile = CodFileImput.[03_Valorizacion de Contratos] Then
         Let nLong = 1:    Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
         Let nLong = 95:   Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 02 - Segun (1)
         Let nLong = 15:   Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 03 - Segun (2)
         Let nLong = 15:   Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 03 - Segun (3)
         Let nLong = 49:   Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 04 - Segun (4)
         Let nLong = 58:   Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 05 - Segun (5)
      End If
      If nCodFile = CodFileImput.[04_Informe de Vencimientos] Then
         Let nLong = 2:    Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> Según (1) : Tipo de Registro (2   Largo)
         Let nLong = 107:  Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> Según (1)
         Let nLong = 53:   Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> Según (2)
         Let nLong = 103:  Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> Según (3)
         Let nLong = 25:   Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> Según (4)
         Let nLong = 74:   Let oGrilla.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> Según (4)
      End If
      
   End If
   '----------------------------------------------------------------------------------------------------
   On Error GoTo 0
Exit Function
ErrorLectura:
   On Error Resume Next

   Call MsgBox("W - Advertencia." & vbCrLf & vbCrLf & "El archivo presenta problemas en su carga.", vbExclamation, App.Title)
   On Error GoTo 0
End Function

Public Function FuncShowDetaill(ByRef SourceGrd As MSFlexGrid, ByRef DesainGrd As MSFlexGrid, ByVal oFileType As CodFileImput)
   Dim cString          As String
   Dim nLong            As Long
   Dim nRow             As Long
   Dim nCol             As Long
   Dim oLargoCompuesto  As Long

  '-> Setea por defecto la Grilla de Detalle en 2 filas (1 Fiaja; 1 Datos), Posiciona en Fila 1 y Columna 0, para comenzar a recibir datos.
   Let DesainGrd.Rows = 2
   Let nRow = 1
   Let nCol = 0
   Let cString = SourceGrd.TextMatrix(SourceGrd.RowSel, 0) & SourceGrd.TextMatrix(SourceGrd.RowSel, 1)
   Let oLargoCompuesto = 1

   If oFileType = [01 Archivo de Notificaciones] Then
      Call FuncSettingTitleDettail([01 Archivo de Notificaciones], DesainGrd)

      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 20:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 02 - Id Contrato
      Let nLong = 8:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 03 - Fecha de Registro
      Let nLong = 20:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 04 - Tipo de Operación
      Let nLong = 3:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 05 - Tipo de Transacción
      Let nLong = 10:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 06 - Rut Contraparte
      Let nLong = 5:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 07 - Cod Depositante Contraparte
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 08 - Fecha Maxima Suscripción
      Let nLong = 8:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Fecha de vencimiento
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 10 - Modalidad Cumplimiento
      Let nLong = 16:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 11 - Monto Contrato
      Let nLong = 22:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 12 - Precio Forward
      Let nLong = 18:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 13 - Precio Pactado
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 14 - Fecha de Pago
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 15 - Forma de Pago
      Let nLong = 3:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 16 - Moneda Compensación
      Let nLong = 2:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 17 - Tipo Cambio Ref

      '-> Actualiza Definiciones o Descripciones
      Let nCol = 7:     Let DesainGrd.TextMatrix(nRow, nCol) = FuncDescription([Maxima Fecha Suscripcion], DesainGrd.TextMatrix(nRow, nCol))
      Let nCol = 9:     Let DesainGrd.TextMatrix(nRow, nCol) = FuncDescription([Modalidad Cumplimiento], DesainGrd.TextMatrix(nRow, nCol))
      Let nCol = 13:    Let DesainGrd.TextMatrix(nRow, nCol) = FuncDescription([Forma de Pago], DesainGrd.TextMatrix(nRow, nCol))
      Let nCol = 14:    Let DesainGrd.TextMatrix(nRow, nCol) = FuncDescription([Forma de Pago], DesainGrd.TextMatrix(nRow, nCol))
      Let nCol = 16:    Let DesainGrd.TextMatrix(nRow, nCol) = FuncDescription([T/Cambio Ref.], DesainGrd.TextMatrix(nRow, nCol))
   End If
   
   If oFileType = [02_Archivo Diario de Generaciones] Then
      Call FuncSettingTitleDettail([02_Archivo Diario de Generaciones], DesainGrd)

      Let cString = cString & SourceGrd.TextMatrix(SourceGrd.RowSel, 2) & SourceGrd.TextMatrix(SourceGrd.RowSel, 3)

      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 20:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 02 - Id Contrato
      Let nLong = 20:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 03 - Folio Dcv
      Let nLong = 20:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 04 - Folio Contraparte
      Let nLong = 8:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 05 - Fecha del registro
      Let nLong = 20:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 06 - Tipo Operacion
      Let nLong = 3:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 07 - Tipo Transaccion
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 08 - Modalidad
      Let nLong = 3:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Moneda Comp.
      Let nLong = 10:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 10 - Rut Contraparte
      Let nLong = 5:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 11 - Codigo Contraparte
      Let nLong = 2:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 12 - Tipo de Cambio Ref.
      Let nLong = 16:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 13 - Monto Contrato
      Let nLong = 22:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 14 - Precio Forward
      Let nLong = 18:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 15 - Precio Pactado
      Let nLong = 8:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 16 - Fecha Vcto
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 17 - Fecha de Pago
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 18 - Forma de Pago
      Let nLong = 50:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 19 - Estado Conttato
      Let nLong = 150:  Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 20 - Firma Parte 1
      Let nLong = 12:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 21 - Rut   Parte 1
      Let nLong = 150:  Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 22 - Firma Parte 2
      Let nLong = 12:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 23 - Rut   Parte 2
      Let nLong = 150:  Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 24 - Firma Contraparte 1
      Let nLong = 12:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 25 - Rut   Contraparte 1
      Let nLong = 150:  Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 26 - Firma Contraparte 2
      Let nLong = 12:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 27 - Rut   Contraparte 2
      Let nLong = 8:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 28 - Fecha Suscripción
   End If

   If oFileType = [03_Valorizacion de Contratos] Then
      Call FuncSettingTitleDettail([03_Valorizacion de Contratos], DesainGrd)

      Let cString = cString & SourceGrd.TextMatrix(SourceGrd.RowSel, 2) & SourceGrd.TextMatrix(SourceGrd.RowSel, 3)
      Let cString = cString & SourceGrd.TextMatrix(SourceGrd.RowSel, 4) & SourceGrd.TextMatrix(SourceGrd.RowSel, 5)

      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 20:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 02 - Id del Contrato
      Let nLong = 20:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 03 - Folio Entregado por el DCV
      Let nLong = 20:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 04 - Id Contrato Contraparte
      Let nLong = 8:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 05 - Fecha de Registro
      Let nLong = 20:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 06 - Tipo de Operacion
      Let nLong = 3:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 07 - Tipo de Transaccion
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 08 - Modalidad de Cumplimiento
      Let nLong = 3:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Moneda de Compensacion
      Let nLong = 10:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Moneda de Compensacion
      Let nLong = 5:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Moneda de Compensacion
      Let nLong = 10:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Moneda de Compensacion
      Let nLong = 5:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Moneda de Compensacion
      Let nLong = 12:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Moneda de Compensacion
      Let nLong = 16:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Moneda de Compensacion
      Let nLong = 22:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Moneda de Compensacion
      Let nLong = 8:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Moneda de Compensacion
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Moneda de Compensacion
      Let nLong = 22:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Moneda de Compensacion
      Let nLong = 18:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Moneda de Compensacion
      Let nLong = 18:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 09 - Moneda de Compensacion
   End If

   If oFileType = [04_Informe de Vencimientos] Then
      Call FuncSettingTitleDettail([04_Informe de Vencimientos], DesainGrd)
      
      Let cString = cString & SourceGrd.TextMatrix(SourceGrd.RowSel, 2) & SourceGrd.TextMatrix(SourceGrd.RowSel, 3)
      Let cString = cString & SourceGrd.TextMatrix(SourceGrd.RowSel, 4) & SourceGrd.TextMatrix(SourceGrd.RowSel, 5)
      
      Let nLong = 2:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 20:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 20:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 20:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 8:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 20:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 3:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 10:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 5:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 3:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 2:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 16:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 8:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 22:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 22:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 18:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 18:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 16:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 3:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 16:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 10:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 25:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 11:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 16:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 3:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 16:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 3:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 16:   Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 3:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
      Let nLong = 1:    Let DesainGrd.TextMatrix(nRow, nCol) = Mid(cString, oLargoCompuesto, nLong):  Let oLargoCompuesto = oLargoCompuesto + nLong:    Let nCol = nCol + 1  '-> 01 - Tipo de registro
   End If
   
   

End Function


Private Function FuncSettingTitleDettail(ByVal iFileType As CodFileImput, ByRef oGrid As MSFlexGrid)
   Dim oRow    As Long
   Dim oCol    As Long

   Let oRow = 0
   Let oCol = 0
   
   If iFileType = [01 Archivo de Notificaciones] Then
      Let oGrid.Rows = 2:             Let oGrid.Cols = 17
      Let oGrid.FixedRows = 1:        Let oGrid.FixedCols = 0
      Let oGrid.AllowUserResizing = flexResizeColumns
      Let oGrid.Rows = 1: Let oGrid.Rows = 2:
      
      Let oGrid.TextMatrix(oRow, oCol) = "Tipo Reg.":               Let oGrid.ColWidth(oCol) = 550:    Let oGrid.ColAlignment(oCol) = flexAlignRightCenter:  Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Id Contrato":             Let oGrid.ColWidth(oCol) = 950:    Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fecha":                   Let oGrid.ColWidth(oCol) = 950:    Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Operación":               Let oGrid.ColWidth(oCol) = 1800:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Transacción":             Let oGrid.ColWidth(oCol) = 1200:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Rut Contraparte":         Let oGrid.ColWidth(oCol) = 1500:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Código":                  Let oGrid.ColWidth(oCol) = 1200:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fecha Max. Suscripción":  Let oGrid.ColWidth(oCol) = 4500:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fec. Vcto.":              Let oGrid.ColWidth(oCol) = 950:    Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Modalidad.":              Let oGrid.ColWidth(oCol) = 1600:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Monto Nocional":          Let oGrid.ColWidth(oCol) = 2800:   Let oGrid.ColAlignment(oCol) = flexAlignRightCenter:  Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Precio Forward":          Let oGrid.ColWidth(oCol) = 2800:   Let oGrid.ColAlignment(oCol) = flexAlignRightCenter:  Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Precio Pactado":          Let oGrid.ColWidth(oCol) = 2800:   Let oGrid.ColAlignment(oCol) = flexAlignRightCenter:  Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fecha de Pago":           Let oGrid.ColWidth(oCol) = 4500:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Forma de Pago":           Let oGrid.ColWidth(oCol) = 2500:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Mon. Compensación":       Let oGrid.ColWidth(oCol) = 2500:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Tipo Cambio Ref.":        Let oGrid.ColWidth(oCol) = 2500:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
   End If
   If iFileType = [02_Archivo Diario de Generaciones] Then
      Let oGrid.Rows = 2:             Let oGrid.Cols = 29
      Let oGrid.FixedRows = 1:        Let oGrid.FixedCols = 0
      Let oGrid.AllowUserResizing = flexResizeColumns
      Let oGrid.Rows = 1: Let oGrid.Rows = 2:
      
      Let oGrid.TextMatrix(oRow, oCol) = "Tipo Reg.":               Let oGrid.ColWidth(oCol) = 550:    Let oGrid.ColAlignment(oCol) = flexAlignRightCenter:  Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Id  Contrato":            Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:  Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Folio Entregado DCV":     Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Id Contrato Contraparte": Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fecha Registro":          Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Tipo Operación":          Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Tipo Transacción":        Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Modalidad":               Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Moneda Comp.":            Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Rut Contraparte":         Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Cod. Dep. Contraparte":   Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Tipo de Cambio Ref.":     Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Monto Contratado":        Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Precio Forward":          Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Precio Pactado":          Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fecha Vencimiento":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fecha de Pago":           Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Forma de Pago":           Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Estado Contrato":         Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Firma Part 1":            Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Rut   Part 1":            Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Firma Part 2":            Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Rut   Part 2":            Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Firma Contrap. 1":        Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Rut   Contrap. 1":        Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Firma Contrap. 2":        Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Rut   Contrap. 2":        Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fecha Suscripción":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
   End If
   If iFileType = [03_Valorizacion de Contratos] Then
      Let oGrid.Rows = 2:             Let oGrid.Cols = 21
      Let oGrid.FixedRows = 1:        Let oGrid.FixedCols = 0
      Let oGrid.AllowUserResizing = flexResizeColumns
      Let oGrid.Rows = 1: Let oGrid.Rows = 2:
      
      Let oGrid.TextMatrix(oRow, oCol) = "Tipo Reg.":               Let oGrid.ColWidth(oCol) = 1500:   Let oGrid.ColAlignment(oCol) = flexAlignRightCenter:  Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Id  Contrato":            Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Folio Entregado DCV":     Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Id Contrato Contraparte": Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fecha Registro":          Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Tipo Operación":          Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Tipo Transacción":        Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Modalidad":               Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Moneda Comp.":            Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Rut Participante":        Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Código Dep. Part.":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Rut Contraparte":         Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Código Dep. Contrap.":    Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "T/C referencial":         Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Monto Contratado":        Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Precio Forward":          Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fecha Vencimiento":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fecha de Pago":           Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Valor Referencial":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Precio Pactado":          Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Valor Total Contrato":    Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
   End If
   
   If iFileType = [04_Informe de Vencimientos] Then
      Let oGrid.Rows = 2:             Let oGrid.Cols = 38
      Let oGrid.FixedRows = 1:        Let oGrid.FixedCols = 0
      Let oGrid.AllowUserResizing = flexResizeColumns
      Let oGrid.Rows = 1:             Let oGrid.Rows = 2:

      Let oGrid.TextMatrix(oRow, oCol) = "Tipo Reg.":               Let oGrid.ColWidth(oCol) = 1500:   Let oGrid.ColAlignment(oCol) = flexAlignRightCenter:  Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Id  Contrato":            Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fol. Entregado DCV":      Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Id Contrato Contraparte": Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fecha de Registro":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Tipo de Operación":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Tipo de Transacción":     Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Modalidad Cumplimiento":  Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Rut Contraparte":         Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Cod. Depositante Contr.": Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Moneda Extranjera":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "TC Índice Ref.":          Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Monto Contrato Noc.":     Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fecha Vcto":              Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fecha de Pago":           Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Forma de Pago":           Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Precio Forward":          Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Precio Pactado":          Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Valor T/C Ref":           Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Valor Total Contrato":    Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Dif. precios":            Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Moneda Compensación":     Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Monto a Pagar":           Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Rol Participante":        Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Estado Contrato":         Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Modalidad Cumpl. Ant.":   Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Parte que Compensa":      Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Mto. de Pago Ant.":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Mon. de Pago Ant.":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fec. de pago Ant.":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Mto. de Pago Ant.":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Mon. de Pago Ant.":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "F    de Pago Ant.":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fec. de Pago Ant.":       Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Mto  de Pag. Ant. Cli":   Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Mon. de Pag. Ant. Cli":   Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "F.   de Pag. Ant. Cli":   Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
      Let oGrid.TextMatrix(oRow, oCol) = "Fec. de Pag. Ant. Cli":   Let oGrid.ColWidth(oCol) = 2000:   Let oGrid.ColAlignment(oCol) = flexAlignLeftCenter:   Let oCol = oCol + 1
   End If
End Function


Private Function FuncDescription(ByVal nCampo As xDescripction, ByVal oValor As Variant) As String
   Let FuncDescription = ""

   If nCampo = [Maxima Fecha Suscripcion] Then
      If oValor = 1 Then Let FuncDescription = oValor & "- Suscripción hasta el mismo día del registro"
      If oValor = 2 Then Let FuncDescription = oValor & "- Suscripción entre el el mismo día hasta el día habil siguiente al registro."
   End If
   If nCampo = [Modalidad Cumplimiento] Then
      If oValor = 1 Then Let FuncDescription = oValor & "- Compensacion"
      If oValor = 2 Then Let FuncDescription = oValor & "- Entrega Física"
   End If
   If nCampo = [Fecha de Pago] Then
      If oValor = 1 Then Let FuncDescription = oValor & "- Mismo día del vencimiento"
      If oValor = 2 Then Let FuncDescription = oValor & "- Día haábil siguiente al día de vencimiento"
   End If
   If nCampo = [Forma de Pago] Then
      If oValor = 1 Then Let FuncDescription = oValor & "- Abono en cuenta corriente"
      If oValor = 2 Then Let FuncDescription = oValor & "- Con documentos"
      If oValor = 3 Then Let FuncDescription = oValor & "- Combanc"
   End If
   If nCampo = [T/Cambio Ref.] Then
      If oValor = "01" Then Let FuncDescription = oValor & "- Dólar Observado"
      If oValor = "02" Then Let FuncDescription = oValor & "- Unidad de Fomento del vencimiento"
   End If

   If Len(FuncDescription) = 0 Then Let FuncDescription = oValor & "- Valor no reconocido ..."
End Function


Public Function FuncAutoSizeGrid(ByRef oGrilla As MSFlexGrid, ByVal iArchivo As CodFileImput)
   On Error Resume Next
   Dim nColumnas        As Long
   Dim nContador        As Long
   Dim oTexto           As String
   Dim nAnchoPromedio   As Long

   Let oGrilla.AllowUserResizing = flexResizeColumns
   Let oGrilla.FixedCols = True
   Let nColumnas = oGrilla.Cols - 1

   If iArchivo = [01 Archivo de Notificaciones] Then
      Let oGrilla.TextMatrix(0, 0) = "Id":               Let oGrilla.ColWidth(0) = 750:      Let oGrilla.ColAlignment(0) = flexAlignRightCenter
      Let oGrilla.TextMatrix(0, 1) = "DATOS Contrato":   Let oGrilla.ColWidth(1) = 10000:    Let oGrilla.ColAlignment(1) = flexAlignLeftCenter
      Let oGrilla.TextMatrix(0, 2) = "Código":           Let oGrilla.ColWidth(2) = 1000:     Let oGrilla.ColAlignment(2) = flexAlignRightCenter
      Let oGrilla.TextMatrix(0, 3) = "Descripción":      Let oGrilla.ColWidth(3) = 4000:     Let oGrilla.ColAlignment(3) = flexAlignLeftCenter
   End If
   If iArchivo = [02_Archivo Diario de Generaciones] Then
      Let oGrilla.TextMatrix(0, 0) = "Id":               Let oGrilla.ColWidth(0) = 750:      Let oGrilla.ColAlignment(0) = flexAlignRightCenter
      Let oGrilla.TextMatrix(0, 1) = "Según (1)":        Let oGrilla.ColWidth(1) = 5000:     Let oGrilla.ColAlignment(1) = flexAlignLeftCenter
      Let oGrilla.TextMatrix(0, 2) = "Según (2)":        Let oGrilla.ColWidth(2) = 5000:     Let oGrilla.ColAlignment(2) = flexAlignLeftCenter
      Let oGrilla.TextMatrix(0, 3) = "Según (3)":        Let oGrilla.ColWidth(3) = 5000:     Let oGrilla.ColAlignment(3) = flexAlignLeftCenter
   End If
   If iArchivo = [03_Valorizacion de Contratos] Then
      Let oGrilla.TextMatrix(0, 0) = "Id":               Let oGrilla.ColWidth(0) = 750:      Let oGrilla.ColAlignment(0) = flexAlignRightCenter
      Let oGrilla.TextMatrix(0, 1) = "Según (1)":        Let oGrilla.ColWidth(1) = 5000:     Let oGrilla.ColAlignment(1) = flexAlignLeftCenter
      Let oGrilla.TextMatrix(0, 2) = "Según (2)":        Let oGrilla.ColWidth(2) = 2500:     Let oGrilla.ColAlignment(2) = flexAlignLeftCenter
      Let oGrilla.TextMatrix(0, 3) = "Según (3)":        Let oGrilla.ColWidth(3) = 2500:     Let oGrilla.ColAlignment(3) = flexAlignLeftCenter
      Let oGrilla.TextMatrix(0, 4) = "Según (4)":        Let oGrilla.ColWidth(4) = 2500:     Let oGrilla.ColAlignment(4) = flexAlignLeftCenter
      Let oGrilla.TextMatrix(0, 5) = "Según (5)":        Let oGrilla.ColWidth(5) = 2500:     Let oGrilla.ColAlignment(5) = flexAlignLeftCenter
   End If
   If iArchivo = [04_Informe de Vencimientos] Then
      Let oGrilla.TextMatrix(0, 0) = "Id":               Let oGrilla.ColWidth(0) = 750:      Let oGrilla.ColAlignment(0) = flexAlignRightCenter
      Let oGrilla.TextMatrix(0, 1) = "Ségun (1)":        Let oGrilla.ColWidth(1) = 5000:     Let oGrilla.ColAlignment(1) = flexAlignLeftCenter
      Let oGrilla.TextMatrix(0, 2) = "Ségun (2)":        Let oGrilla.ColWidth(2) = 5000:     Let oGrilla.ColAlignment(2) = flexAlignLeftCenter
      Let oGrilla.TextMatrix(0, 3) = "Ségun (3)":        Let oGrilla.ColWidth(3) = 5000:     Let oGrilla.ColAlignment(3) = flexAlignLeftCenter
      Let oGrilla.TextMatrix(0, 4) = "Estado":           Let oGrilla.ColWidth(4) = 2000:     Let oGrilla.ColAlignment(4) = flexAlignLeftCenter
      Let oGrilla.TextMatrix(0, 5) = "Ségun (4)":        Let oGrilla.ColWidth(5) = 5000:     Let oGrilla.ColAlignment(5) = flexAlignLeftCenter
   End If
   On Error GoTo 0
End Function


