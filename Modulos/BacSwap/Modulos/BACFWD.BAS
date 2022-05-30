Attribute VB_Name = "BacGeneral"
Option Explicit
Public Declare Function GetDeviceCaps Lib "gdi32" (ByVal hDC As Long, ByVal nIndex As Long) As Long

Sub Sub_Busca_Item_Combo(oCombo As Object, sItem As String)
    Dim bEncontrado As Boolean
    Dim iContador As Integer
    
    bEncontrado = False
    
    If oCombo.ListCount > 0 Then
        For iContador = 0 To oCombo.ListCount - 1
            If sItem = Trim(Right(oCombo.List(iContador), 10)) Then
                oCombo.ListIndex = iContador
                bEncontrado = True
                Exit For
            End If
            
        Next iContador
    End If
    
    If bEncontrado = False Then
        oCombo.ListIndex = -1
    End If

End Sub

Sub PROC_LLENA_COMBOS(combo As Object, Opcion As Integer, bTodos As Boolean, cParametro1 As String, Optional cParametro2 As String, Optional cParametro3 As String, Optional cParametro4 As String, Optional cParametro5 As String, Optional cParametro6 As String, Optional cParametro7 As String)
Dim Datos()

    Envia = Array()
    AddParam Envia, Opcion
    AddParam Envia, IIf(Trim(cParametro1) <> "", Trim(cParametro1), "")
    AddParam Envia, IIf(Trim(cParametro2) <> "", Trim(cParametro2), "")
    AddParam Envia, IIf(Trim(cParametro3) <> "", Trim(cParametro3), "")
    AddParam Envia, IIf(Trim(cParametro4) <> "", Trim(cParametro4), "")
    AddParam Envia, IIf(Trim(cParametro5) <> "", Trim(cParametro5), "")
    AddParam Envia, IIf(Trim(cParametro6) <> "", Trim(cParametro6), "")
    AddParam Envia, IIf(Trim(cParametro7) <> "", Trim(cParametro7), "")
    
        
    If Not Bac_Sql_Execute("SP_CON_INFO_COMBO", Envia) Then
        MsgBox "Problemas al Intentar llanar el combo"
        Exit Sub
    End If
    
    combo.Clear
    
    If bTodos = True Then
        combo.AddItem "< TODOS [AS] >" & Space(110)
    End If
    
    Do While Bac_SQL_Fetch(Datos())
               
        combo.AddItem Datos(6) & Space(110) & Datos(2)
                        
    Loop
    
    If combo.ListCount > 0 Then
        combo.ListIndex = 0
    End If
End Sub



Function ActArcIni(cString As String) As Integer
        ActArcIni = WriteINI("windows", "device", cString, "win.ini")
End Function
'---------------------------------------------------
'WriteINI
'
'Escribe en archivos .INI
'---------------------------------------------------
Function WriteINI(cSection$, cKeyName$, cNewString$, sFilename As String) As Integer
    WriteINI = WritePrivateProfileString(cSection$, cKeyName$, cNewString$, sFilename)
End Function


Public Sub DetectarResolucion(MDIFormx As Object, Formx As Object)
'''''Cristian
   Dim Ancho As Integer, alto As Integer
   Ancho = GetDeviceCaps(Formx.hDC, 8)
   alto = GetDeviceCaps(Formx.hDC, 10)
   If Ancho <> 800 And alto <> 600 Then
      MDIFormx.Picture = Formx.Picture
      Unload Formx
   End If
End Sub

Public Function BacControlIni() As Boolean

    BacControlIni = True

   If gsc_Parametros.findia = "0" Then
      MsgBox "Fin de día no ha sido realizado.-", 16, "Bac Forward"
      BacControlIni = False
      Exit Function

   End If

   If gsc_Parametros.iniciodia = "1" Then
      MsgBox "Inicio de día ya fue realizado.-", 16, "Bac Forward"
      BacControlIni = False
      Exit Function

   End If

End Function

Public Function TipoFormato(cCodMon As String)

    Select Case Trim(cCodMon$)
    Case "UF", "UFR"
           TipoFormato = "##,##0.0000"
           
    Case "$", "$$", "CLP"
           TipoFormato = "##,##0"
           
    Case Else
           TipoFormato = "##,##0.0000"
    
    End Select

End Function

Public Sub BacSetMinBox(fForm As Form, Optional bMoveForm As Variant)
Dim nStyle As Long

   If IsMissing(bMoveForm) Then
      bMoveForm = False

   End If

   nStyle = GetWindowLong(fForm.hWnd, GWL_STYLE)
   nStyle = nStyle Or WS_MINIMIZEBOX
'   hForm.ClipControls = True
   Call SetWindowLong(fForm.hWnd, GWL_STYLE, nStyle)

   If (bMoveForm = True) Then
      fForm.Move 0, 0

   End If

   fForm.Refresh

End Sub

Sub PROC_POSICIONA_TEXTO(grilla As Control, texto As Control)

    texto.Top = grilla.CellTop + grilla.Top
    texto.Left = grilla.CellLeft + grilla.Left
    texto.Height = grilla.CellHeight
    texto.Width = grilla.CellWidth

End Sub

Public Sub AsignaValoresParametros()
   gsBAC_Fecp = Format(gsc_Parametros.fechaproc, gsc_FechaDMA)
   gsBAC_FecAnt = Format(gsc_Parametros.FechaAnt, gsc_FechaDMA) 'PROD-10967
   gsBAC_FecConFin = gsBAC_FecAnt 'PROD-10967
   gsBAC_Clien = gsc_Parametros.Nombre
   gsBAC_Rut = gsc_Parametros.Rut
   gsBAC_ValmonUF = gsc_Parametros.ValorUF
   gsBAC_DolarObs = gsc_Parametros.DolarObs

   If gsc_Parametros.cierreMesa = "1" Then
      BACSwap.Opc_20700.Checked = True
   Else
      BACSwap.Opc_20700.Checked = False
   End If
  ' gsBAC_Fecp = gsc_Parametros.fechaproc
End Sub
Function bacBuscarCombo(cControl As Object, nValor As Variant) As Integer
Dim iLin    As Integer

    If VarType(nValor) = vbString Then
        nValor = Trim(nValor)
    End If

    bacBuscarCombo = -1

    For iLin = 0 To cControl.ListCount - 1
        If VarType(nValor) = vbString Then
            If Left(cControl.List(iLin), Len(nValor)) = nValor Then
                bacBuscarCombo = iLin
            End If
        ElseIf cControl.ItemData(iLin) = nValor Then
            bacBuscarCombo = iLin
        End If
        If bacBuscarCombo = iLin And iLin > -1 Then
            cControl.ListIndex = iLin
            Exit For
        End If
    Next iLin

End Function
Function bacKeyPress(ByRef KeyAscii As Integer)

   If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii = Asc(gsc_PuntoDecim)

   End If

End Function

Public Function bacTranMontoSql(nMonto As Variant) As String
Dim sCadena       As String
Dim iPosicion     As Integer
Dim sFormato      As String

   bacTranMontoSql = "0.0"

   sCadena = CStr(nMonto)

   iPosicion = InStr(1, sCadena, gsc_PuntoDecim)

   If iPosicion = 0 Then
      bacTranMontoSql = sCadena

   Else
      bacTranMontoSql = Mid$(sCadena, 1, iPosicion - 1) + "." + Mid$(sCadena, iPosicion + 1)

   End If

End Function

Function FUNC_FMT_DOUBLE(Tpaso As String) As Double
Dim i%

  For i% = 1 To Len(Tpaso)
    
    If Mid(Tpaso, i%, 1) = "0" Then
        
        Mid(Tpaso, i%, 1) = " "
    Else
        Exit For
    End If
    
  Next i%
  
  If Trim(Tpaso) = "" Or Trim(Tpaso) = "." Then
    FUNC_FMT_DOUBLE = 0#
  Else
    FUNC_FMT_DOUBLE = CDbl(Tpaso)
  End If
End Function

Public Function Controla_RUT(tex As Control, tex1 As Control)
   Dim Valida As Integer
   Dim IdRut As String
   Dim IdDig As String

   IdRut = tex
   IdDig = tex1

   Valida = True

   If Trim$(IdRut$) = "" Or Trim$(IdDig$) = "" Or (Trim$(IdRut$) = "0" And Trim$(IdDig$) = "0") Then
      Valida = False
   
   End If
    
   If BacValidaRut(tex.Text, tex1.Text) = False Then
      Valida = False
   
   End If

   Controla_RUT = Valida

End Function

Public Function DiaSemana(dFecha As String, oControl As Object) As String

   Dim iDia       As Integer
   Dim SQL        As String

   DiaSemana = ""
   iDia = Weekday(Format(dFecha, gsc_FechaDMA))
'   MsgBox "El simbolo utilizado en el separador de miles" & vbCrLf & "y del punto decimal son iguales.", vbOKOnly + vbCritical, "Fatal ERROR"

   oControl.ForeColor = &H8000&
   oControl.Tag = "OK"

   Select Case iDia
   Case 0: DiaSemana = "Error"
      oControl.ForeColor = vbBlue
      oControl.Tag = "ER"

   Case 1: DiaSemana = "Domingo"
      oControl.ForeColor = vbRed
      oControl.Tag = "FE"

   Case 2: DiaSemana = "Lunes"
   Case 3: DiaSemana = "Martes"
   Case 4: DiaSemana = "Miercoles"
   Case 5: DiaSemana = "Jueves"
   Case 6: DiaSemana = "Viernes"
   Case 7: DiaSemana = "Sabado"
      oControl.ForeColor = vbRed
      oControl.Tag = "FE"

   End Select

   If Not BacEsHabil(dFecha) Then
      oControl.ForeColor = vbRed
      oControl.Tag = "FE"

   End If

   oControl.Caption = DiaSemana

End Function

Public Function Controla_RUT1(tex As String, tex1 As String)
   
   Dim Valida As Integer
   Dim IdRut As String
   Dim IdDig As String

   IdRut = tex
   IdDig = tex1

   Valida = True

   If Trim$(IdRut$) = "" Or Trim$(IdDig$) = "" Or (Trim$(IdRut$) = "0" And Trim$(IdDig$) = "0") Then
      Valida = False
   
   End If
    
   If BacValidaRut(tex, tex1) = False Then
      Valida = False
   
   End If

   Controla_RUT1 = Valida

End Function
Public Function BacInit() As Boolean
Dim Datos()
Dim SQL$
Dim sSeparadorFecha$
Dim Attribs As String
Dim MyWorkspace As Workspace
Dim sFile1$
Dim cNewqueue   As String
Dim nI As Integer
Dim cDato  As String

    BacInit = False
    
    sFile = "Bac-Sistemas.ini"
    'sFile = "Bac-Sistem.ini"
    
    If Dir("C:\WINNT\" & sFile) <> "" Then
       sFile = "C:\WINNT\" & sFile
    ElseIf Dir("C:\WINDOWS\" & sFile) <> "" Then
       sFile = "C:\WINDOWS\" & sFile
    ElseIf Dir("C:\BTRADER\" & sFile) <> "" Then
       sFile = "C:\BTRADER\" & sFile
    ElseIf Dir("C:\" & sFile) <> "" Then
       sFile = "C:\" & sFile
    ElseIf Dir(App.Path & "\" & sFile) <> "" Then
       sFile = App.Path & "\" & sFile
    Else
       MsgBox "Archivo de configuraciones no existe.", vbCritical, TITSISTEMA
       End
    End If
    
    'NET y Datos Grales.
    gsBAC_User = ReadINI("NET", "NET_UserName", sFile)
    gsBAC_Term = ReadINI("NET", "NET_ComputerName", sFile)
    gsBAC_Pass$ = ""
    
    'SQL
    gsSQL_Database = ReadINI("SQL", "DB_Swap", sFile)
    gsSQL_Server = ReadINI("SQL", "Server_Name", sFile)
    giSQL_LoginTimeOut = Val(ReadINI("SQL", "Login_TimeOut", sFile))
    giSQL_QueryTimeOut = Val(ReadINI("SQL", "Query_TimeOut", sFile))
    giSQL_ConnectionMode = Val(ReadINI("SQL", "Connection_Mode", sFile))
    gsODBC = ReadINI("SQL", "ODBC_Swap", sFile)
    
    giSQL_DatabaseCommon = ReadINI("SQL", "DB_Parametros", sFile)
    
    
    ' FTP
   gsNom_maq = ReadINI("FTP_SWAP", "NOM_SER", sFile$)
   gsUser_maq = ReadINI("FTP_SWAP", "USERNAME", sFile$)
   gsPass_maq = ReadINI("FTP_SWAP", "PASSWORD", sFile$)
   gsPath_maq = ReadINI("FTP_SWAP", "RUTA_ARCHIVO", sFile$)
   
   '*************AS400
   gsSQL_ServerAS400 = ReadINI("AS/400", "server_nameas400", sFile$)
   gsBac_as400_usuario = ReadINI("AS/400", "IDUSUARIO", sFile$)
   gsBac_as400_Password = ReadINI("AS/400", "PASWORD", sFile$)
   gsBac_as400_biblioteca = ReadINI("AS/400", "BIBLIOTECA", sFile$)
   '*************AS400
   '+++ cvegasan 2017.08.08 Control Lineas IDD
   gsBac_Url_WebService = ReadINI("WEB", "URL_WEBSERVICE", sFile$)
   gsBac_Url_WebMethod = ReadINI("WEB", "URL_WEBMETHOD", sFile$)
   '--- cvegasan 2017.08.08 Control Lineas IDD

    
    sFile1$ = ReadINI("INI", "DBO_PATH", sFile$) & "DBO.INI"
    '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
    'gsSQL_Login = ReadINI("usuario", "usuario", sFile1$)
    'gsSQL_Password = Encript(Trim(ReadINI("usuario", "password", sFile1$)), False)
    '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
    If gsSQL_Database = "" Or gsSQL_Server = "" Then
       MsgBox "Servidor No esta definido para conectarse con Base de Datos", vbCritical, TITSISTEMA
       Exit Function
    '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
    'ElseIf gsSQL_Login = "" Or gsSQL_Password = "" Then
    '   MsgBox "Usuario No esta definido para conectarse con Base de Datos", vbCritical, TITSISTEMA
    '   Exit Function
    '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
    ElseIf giSQL_LoginTimeOut <= 0 Or giSQL_QueryTimeOut <= 0 Then
       MsgBox "Tiempos de Respuesta No son los apropiados para conectarse con Base de Datos", vbCritical, TITSISTEMA
       Exit Function
    ElseIf gsODBC = "" Then
       MsgBox "Coneccion ODBC No esta definida para conectarse con Base de Datos", vbCritical, TITSISTEMA
       Exit Function
    End If
    
     'CREA OBDC EN PC USUARIO
     Set MyWorkspace = Workspaces(0)
      
     Attribs = "Description=BACTRADER" & Chr$(13)
     Attribs = Attribs & "Server=" & gsSQL_Server & Chr$(13)
        '+++cvegasan 2017.06.05 HOM Ex-Itau
        If giSQL_ConnectionMode = 3 Then
        Attribs = Attribs & "Trusted_Connection=yes" & Chr$(13)
        End If
        '---cvegasan 2017.06.05 HOM Ex-Itau
     Attribs = Attribs & "Database=" & gsSQL_Database
      
     DBEngine.RegisterDatabase gsODBC, "SQL Server", True, Attribs
      
     MyWorkspace.Close
    
    ' PARAMSe
    gsBac_Timer = Val(ReadINI("PARAMS", "Tiempo_Val", sFile$)) 'Rango tiempo del Timer
    gsBac_Timer_Adicional = Val(ReadINI("PARAMS", "ADICIONAL_TIMER", sFile$))

   '---- Define Coneccion
   '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
    'swConeccion = "DSN=" & gsODBC
    'swConeccion = swConeccion & ";UID=" & gsSQL_Login
    'swConeccion = swConeccion & ";PWD=" & gsSQL_Password
    'swConeccion = swConeccion & ";DSQ=" & gsSQL_Database
    swConeccion = "DSN=" & gsODBC
    swConeccion = swConeccion & ";TRUSTED_CONNECTION = yes"
    swConeccion = swConeccion & ";DSQ=" & gsSQL_Database
    '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
    
    gsRPT_Path = ReadINI("REPORTES", "RPT_Swap", sFile)
    
    
   'DOCUMENTOS - CONTRATOS
   gsDOC_Path = ReadINI("DOCUMENTOS", "DOC_Path", sFile)

   gsBac_Path_Interfaces = ReadINI("INTERFAZ", "PATH_SWAP", sFile)
   gsBac_Path_Contratos = ReadINI("INTERFAZ", "PATH_CONTRATOS_SWAP", sFile)
   gsBac_DIRIBS = ReadINI("INTERFAZ_IBS", "PATH_SWAP_IBS", sFile$)
   gsBac_DIRCONTA = Trim(ReadINI("INTERFAZ_CONT", "PATH_INTER_CONT ", sFile$))
   
'------------------------CREA OBDC EN PC USUARIO  --------------------------------------
''''Set MyWorkspace = Workspaces(0)
''''Attribs = "Description=BACTRADER" & Chr$(13)
''''Attribs = Attribs & "Server=" & gsSQL_Server & Chr$(13)
''''Attribs = Attribs & "Database=" & gsSQL_Database
''''DBEngine.RegisterDatabase gsODBC, "SQL Server", True, Attribs
''''MyWorkspace.Close
'---------------------------------------------------------------------------------------


'Impresoras
   gsBac_QUEDEF = ReadINI("PRINTERS", "QUEDEF", sFile$)
   gsBac_IMPDEF = ReadINI("PRINTERS", "PRNDEF", sFile$)
   gsBac_IMPWIN = ReadINI("windows", "device", "WIN.INI")
   
   'Verifica Que Exista El Dispositivo
   If UCase(Mid$(gsBac_QUEDEF, Len(gsBac_IMPDEF) + 2, Len(gsBac_QUEDEF))) <> UCase(ReadINI("Devices", gsBac_IMPDEF, "WIN.INI")) Or gsBac_QUEDEF = "" Then
         gsBac_QUEDEF = gsBac_IMPWIN
   Else
   
      cNewqueue = ""
      
      If InStr(1, gsBac_QUEDEF, "=") > 0 Then
      
         For nI = 1 To Len(gsBac_QUEDEF)
            cDato = Mid(gsBac_QUEDEF, nI, 1)
            
            If cDato = "=" Then
               cNewqueue = cNewqueue + ","
            Else
               cNewqueue = cNewqueue + cDato
            End If
            
         Next nI
         
         gsBac_QUEDEF = cNewqueue
         
      End If
      
   End If

    sSeparadorFecha$ = "/"
      
    sSeparadorFecha$ = Mid$(Date, 2, 2)                  'ReadINI("INTL", "SDATE", "WIN.INI")
   
   If InStr("0123456789 ", Left(sSeparadorFecha$, 1)) = 0 Then
      sSeparadorFecha$ = Left(sSeparadorFecha$, 1)
   Else
      sSeparadorFecha$ = Right(sSeparadorFecha$, 1)
   End If
    
   gsc_PuntoDecim = Mid$(Format(0#, "0.0"), 2, 1)       'ReadINI("INTL", "SDECIMAL", "WIN.INI")
   
   If gsc_PuntoDecim = "." Then
       gsc_SeparadorMiles = ","                         'ReadINI("INTL", "STHOUSAND", "WIN.INI")
   Else
       gsc_SeparadorMiles = "."                          'ReadINI("INTL", "STHOUSAND", "WIN.INI")
   End If
   
   gsc_FechaDMA = "DD" + sSeparadorFecha$ + "MM" + sSeparadorFecha$ + "YYYY"
   gsc_FechaMDA = "MM" + sSeparadorFecha$ + "DD" + sSeparadorFecha$ + "YYYY"
   gsc_FechaAMD = "YYYY" + sSeparadorFecha$ + "MM" + sSeparadorFecha$ + "DD"
   gsc_FechaSeparador = sSeparadorFecha$

   If gsc_PuntoDecim = gsc_SeparadorMiles Then
        MsgBox "El simbolo utilizado en el separador de miles" & vbCrLf & "y del punto decimal son iguales.", vbCritical, TITSISTEMA
        Exit Function
   End If

   If sSeparadorFecha$ <> "/" And sSeparadorFecha$ <> "-" Then
      MsgBox "El simbolo utilizado en la separación " & vbCrLf & "de la fecha no corresponde.", vbCritical, TITSISTEMA
      Exit Function
   End If

 'Lineas
   gsBac_Lineas = "S" 'Func_Read_INI("LINEAS", "Lineas", sFile$)
   gsBac_LineasDb = ReadINI("SQL", "DB_Lineas", sFile$)
   
   BacInit = True
   
End Function
Function Encriptaaaaaa(xClave As String, xEncriptar As Boolean) As String
Dim X As Single
Dim xPsw As String
Dim Letras As String
Dim Codigos As String
 
'Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYWZ1234567890ÿ[¦´«]#$%&úß¡?ý}<_>§æØáø×ƒ®ÇéåêëèïîÐ"
'Codigos = "ÿ[¦´«]#$%&úß¡?ý}<_>§æØáø×ƒ®ÇéåêëèïîÐABCDEFGHIJKLMNOPQRSTUVWXYWZ1234567890"
 
Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyz"
Codigos = "RaMbKCgTrZHYFIPAuSiQVONmLfJWzGXEDqBUx_kpjcys{dn}ve]htwl[\`@?><"
xPsw = ""
'Encript = ""
 
For X = 1 To Len(xClave)
 
 If xEncriptar Then
    xPsw = xPsw + Chr((Asc(Mid(Codigos, InStr(1, Letras, Mid(xClave, X, 1)), 1)) - X))
 Else
    xPsw = xPsw + Mid(Letras, InStr(1, Codigos, Chr(Asc(Mid(xClave, X, 1)) + X)), 1)
 End If
 
Next
 
Encriptaaaaaa = xPsw
 
End Function

Sub Grabar_Logaaaa(xSistema As String, xUsuario As String, xFechaProc As Date, xEvento As String)
 
'Sql = "Sp_Grabar_Log '" & xSistema & "'," & Chr(10)
'Sql = Sql & "'" & xUsuario & "'," & Chr(10)
'Sql = Sql & "'" & Format(xFechaProc, "yyyymmdd") & "'," & Chr(10)
'Sql = Sql & "'" & xEvento & "'"
 
'If MISQL.SQL_Execute(Sql) = 0 Then
'   If MISQL.SQL_Fetch(DATOS()) = 0 Then
'      If DATOS(1) = "NO" Then
'         MsgBox "Problemas al grabar log", vbOKOnly + vbExclamation
'      End If
'   End If
'End If
   
Envia = Array()
AddParam Envia, xSistema
AddParam Envia, Chr(10)
   
If Not Bac_Sql_Execute("SP_GRABAR_LOG", Envia) Then
   Screen.MousePointer = 0
'   Exit Function
Else
   Do While Bac_SQL_Fetch(Datos())
      If Datos(1) = "NO" Then
         MsgBox "Problemas al grabar log", vbOKOnly + vbExclamation
      End If
   Loop
End If

End Sub
Sub BacSetBotones(iOpc%, iModo%)

'    Select Case iOpc%
'
'        Case iGlbBotonGrabar%
'                BacFwd.CmdGrabar.Enabled = iModo%
'                BacFwd.CmdGrabar.Picture = BacTrd.ImgGrabar(IIf(iModo%, 1, 0)).Picture
'
'        Case iGlbBotonMValr%
'                BacFwd.CmdMValr.Enabled = iModo%
'                BacFwd.CmdMValr.Picture = BacTrd.ImgMValr(IIf(iModo%, 1, 0)).Picture
'
'        Case iGlbBotonNETrader%
'                BacFwd.CmdNet.Enabled = iModo%
'
'        Case iGlbBotonSelec%
'                BacFwd.CmdSelec.Enabled = iModo%
'                BacFwd.CmdSelec.Picture = BacTrd.ImgSelec(IIf(iModo%, 1, 0)).Picture
'
'        Case iGlbBotonAsign%
'                BacFwd.CmdAsign.Enabled = iModo%
'                BacFwd.CmdAsign.Picture = BacTrd.ImgAsign(IIf(iModo%, 1, 0)).Picture
'
'
'
'    End Select
    
End Sub


Function Valida_Configuracion_Regional() As Boolean
   Valida_Configuracion_Regional = True
   If CStr(Format(CDate("31/12/2000"), FEFecha)) <> Format("31/12/2000", FEFecha) Then
      Valida_Configuracion_Regional = False
   End If
End Function
Function ENTREGA_DIGITO_RUT(Rut As Long) As String

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim digito  As String
   Dim multi   As Double
   Dim xRut As String
    
   Suma = 0
   xRut = Format(Rut, "000000000")
   D = 2
   For i = 9 To 1 Step -1
      multi = Val(Mid$(xRut, i, 1)) * D
      Suma = Suma + multi
      D = D + 1
      
      If D = 8 Then D = 2
   Next i
    
   Divi = (Suma \ 11)
   multi = Divi * 11
   digito = Trim$(Str$(11 - (Suma - multi)))
    
   If digito = "10" Then digito = "K"
    
   If digito = "11" Then digito = "0"
   
   ENTREGA_DIGITO_RUT = digito

End Function

 Public Function Enviar_por_ftp(cruta As String, direct_carchivo As String) As Boolean
 Dim X
 Dim fName1
 Dim ifilehost
 Dim arc_scrp As String
 On Error GoTo Erroftp
 
 arc_scrp = ""
 fName1 = ""
 fName1 = cruta & "Ftpscrip.txt"                                        '  Ruta y archivo que ejecuta la instruccion para el envio
 ifilehost = FreeFile
 
 Enviar_por_ftp = True
 Open fName1 For Output As ifilehost
 Close #ifilehost

  Open fName1 For Output As ifilehost
  'Print #ifilehost, gsNom_maq                                                      ' nombre maquina
  Print #ifilehost, gsUser_maq                                                     ' USERNAME
  Print #ifilehost, gsPass_maq                                                     ' Password
  Print #ifilehost, gsPath_maq                              ' RUTA DE LA MAQUINA
  Print #ifilehost, "put " & direct_carchivo                                     ' archivo a traspasar
  Print #ifilehost, "bye"                                                               ' termina la secion
  Close #ifilehost
   
   X = Shell("ftp.exe -s:" & fName1 & " " & gsNom_maq)
   'x = Shell("ftp.exe -s:" & RTrim(LTrim(fName1)))
   Exit Function
 
Erroftp:
Enviar_por_ftp = False
Select Case err.Number
    Case 55
            Close ifilehost
               MsgBox "Error   " & err.Number & " " & err.Description
                Exit Function
    Case 53
            ifilehost = FreeFile
            Open fName1 For Output As ifilehost
            Close #ifilehost
            MsgBox "Error   " & err.Number & " " & err.Description

            Exit Function
    Case 0
        MsgBox "Error   " & err.Number & " " & err.Description
        Exit Function
    '''otro problema
End Select

Exit Function
Resume
End Function


'
'Sub CargaClientesAs400(Rut_Cliente As Double, Digito_Verificador As String)
'
'    Dim Envia()
'    Dim RutCli      As Long
'    Dim Datos()
'    Dim Str_SQLAS400 As String
'
'    On Error GoTo Error
'
'      Str_SQLAS400 = "CALL " & _
'                     gsBac_as400_biblioteca & _
'                     ".DD0099CL('" & _
'                     Format(Rut_Cliente, "000000000") & "','" & _
'                     Digito_Verificador & "')"
'
'      If miSQLAS400.SQLAS400_Execute(Str_SQLAS400) = 0 Then
'
'         Str_SQLAS400 = "SELECT CLRUTC, CLDIVE, CLNOMB, CLDIRE FROM " & _
'                        gsBac_as400_biblioteca & ".DDMADEBAC " & _
'                        "WHERE CLRUTC = " & Rut_Cliente & _
'                        " AND CLDIVE = '" & Digito_Verificador & "'"
'
'         If miSQLAS400.SQLAS400_Execute(Str_SQLAS400) = 0 Then
'
'              If miSQLAS400.SQLAS400_Fetch(Datos()) = 0 Then
'
'                 Envia = Array()
'
'                    AddParam Envia, Datos(1)                        'Rut Cliente
'                    AddParam Envia, Datos(2)                         'Digito Verificador Cliente
'                    AddParam Envia, Datos(3)                      'Primer Nombre
'                    AddParam Envia, Datos(4)                     'Dirección
'
'
'                    If Not Bac_Sql_Execute("SP_GRABA_CLIENTE_AS400", Envia) Then
'                        MsgBox "Problemas al Grabar Cliente ", vbCritical, "MENSAJE"
'                    End If
'
'
'              End If
'
'
'         End If
'
'      End If
'
'
'Exit Sub
'
'Error:
'        MsgBox "Carga de clientes con problemas!!" & vbCrLf & Err.Description, vbExclamation, "MENSAJE"
'        Screen.MousePointer = 0
'End Sub

Public Function ClienteBloqueado(ByVal Sistema As String, ByVal nRut As Double, ByVal nCod As Double, ByRef codBloqueo As Double, ByRef motBloqueo As String) As Boolean
    Dim nomSp As String
    Dim estBloqueo As String
    ClienteBloqueado = True
    codBloqueo = -1
    motBloqueo = ""
    Dim Datos()
    Envia = Array()
    AddParam Envia, 0
    AddParam Envia, nRut
    AddParam Envia, nCod
    AddParam Envia, "L"
    nomSp = "BacParamsuda.dbo.SP_MNT_BLOQUEOS_CLIENTES"
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        Exit Function
    End If
    If Not Bac_SQL_Fetch(Datos()) Then
        'No se encontró el cliente en Bloqueos, se asume no bloqueado
        motBloqueo = ""
        ClienteBloqueado = False
        Exit Function
    End If
    estBloqueo = Datos(6)
    If estBloqueo = "N" Then
        ClienteBloqueado = False
    Else
        codBloqueo = CDbl(Datos(10))
        motBloqueo = "CAUSA DE BLOQUEO: " & Datos(11)
    End If
End Function
Function GrabaBloqueoCliente(ByVal codSistema As String, ByVal codProducto As String, ByVal NumOP As Double, ByVal tipoOp As String, ByVal qBloqueo As Double, ByVal qMotivo As String) As Boolean
    Dim nomSp As String
    Dim Datos()
    Envia = Array()
    GrabaBloqueoCliente = False
    nomSp = "BacParamsuda.dbo.SP_GRABA_BLOQUEOCLIENTE_CF"
    AddParam Envia, codSistema
    AddParam Envia, codProducto
    AddParam Envia, NumOP
    AddParam Envia, tipoOp
    AddParam Envia, qMotivo
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) = "OK" And Datos(2) = "OK" Then
            GrabaBloqueoCliente = True
        End If
    End If
End Function
Public Function UsuarioConfirma(X As Long, Y As Long, Titulo As String, Solicitud As String, tiempoMinutos As Double)
    Dim Msg        As Form
    Set Msg = New MsgBoxTemporalizado
    Let Msg.Titulo = Titulo
    Let Msg.Solicitud = Solicitud
    Let Msg.CoorX = X
    Let Msg.CoorY = Y
    Let Msg.Temporalizador.Interval = tiempoMinutos * 60 * 1000 'Expresar en milisegundos
    Let Msg.CuentaRegresiva.Interval = tiempoMinutos * 60 * 1000 / 30  'Expresar en milisegundos
    Msg.Show vbModal
    UsuarioConfirma = Msg.Respuesta
End Function


Public Function Proc_Valida_Fecha() As Boolean
    '=========================================================================
    'SubRutina   :   Proc_Carga_parametros
    'Objetivo    :   Verifica la fecha del sistema sea igual a la fecha MDAC
    'Fecha       :   Septiembre, 2013
    'Autor       :   Alejandro Contreras G.
    '=========================================================================
Dim cSQL    As String
Dim Datos()
Dim xSistema As String
xSistema = "PCS"

On Error GoTo ErrTeso

    Proc_Valida_Fecha = False

    cSQL = ""
    cSQL = cSQL & "EXECUTE Sp_Valida_Fechas_Cierre "
    cSQL = cSQL & "'" & Format$(gsBAC_Fecp, "yyyymmdd") & "', "
    cSQL = cSQL & CStr(xSistema) & " "
        
        
    If Bac_Sql_Execute(cSQL) Then
        Do While Bac_SQL_Fetch(Datos)
              If Val(Datos(1)) <> 0 Then
                MsgBox "Fechas no coinciden, la del Sistema con la de Proceso, el Sistema se Cerrará", vbCritical, gsBAC_Version
                Exit Function
            End If
        Loop
    End If
    
    Proc_Valida_Fecha = True
    Exit Function
ErrTeso:
    MsgBox "Problemas con Procedimiento Sp_Valida_Fechas_Cierre : " & err.Description & ". Verifique.", vbCritical, gsBAC_Version
    Exit Function
End Function

Public Sub EjecutaProcesoCalculoLiquidaciones()
  
    '=========================================================================
    'SubRutina   :   EjecutaProcesoCalculoLiquidaciones
    'Objetivo    :   Generar registro físico de liquidaciones
    'Fecha       :   Julio, 2015
    'Autor       :   Maria Paz Navarro G.
    '=========================================================================
Dim cSQL    As String
Dim Datos()

On Error GoTo ErrTeso

    

    cSQL = ""
    cSQL = cSQL & "EXECUTE SP_GRABA_LIQUIDACION "
    cSQL = cSQL & "'" & Format$(gsBAC_Fecp, "yyyymmdd") & "' "
    
    If Bac_Sql_Execute(cSQL) Then
        Do While Bac_SQL_Fetch(Datos)
            If Val(Datos(1)) <> 0 Then
                MsgBox "ERROR " & Datos(2), vbCritical, gsBAC_Version
                Exit Sub
            End If
            MsgBox Datos(2)
        Loop
    Else
         MsgBox "ERROR Proceso liquidacion"
    End If
    
    
    
    Exit Sub
ErrTeso:
    MsgBox "Problemas con Procedimiento GENERA_TBL_CAJA_DERIVADOS : " & err.Description & ". Verifique.", vbCritical, gsBAC_Version
    Exit Sub

End Sub


Function Puede_devengar_SN() As Boolean
Dim Datos()

    Puede_devengar_SN = False
    Envia = Array()
        
    If Not Bac_Sql_Execute("SP_VALIDA_DEVENGO", Envia) Then
        MsgBox "Problemas al ejecutar SP_VALIDA_DEVENGO"
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
               
        If Datos(1) = "OK" Then
           Puede_devengar_SN = True
        Else
           MsgBox Datos(2)
        End If
        
                        
    Loop
    
End Function
