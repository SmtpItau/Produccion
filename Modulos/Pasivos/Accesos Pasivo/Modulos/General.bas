Attribute VB_Name = "General"
Global Micro As Byte
Global Opt As String

Global Const vbKeySalir = 27
Global Const vbKeyGrabar = 7
Global Const vbKeyBuscar = 2
Global Const vbKeyLimpiar = 12
Global Const vbKeyEliminar = 5
Global Const vbKeyFiltrar = 6
Global Const vbKeyAyuda = vbKeyF3
Global Const vbKeyProcesar = 16
Global Const vbKeyImprimir = 9
Global Const vbKeyAnular = 1
Global Const vbKeyCalcular = 123
Global Const vbKeyArriba = 141
Global Const vbKeyAbajo = 145
Global Const vbKeyIzquierda = 26
Global Const vbKeyDerecha = 2
Global Const vbKeyAceptar = vbKeyF10
Global Const vbKeyVistaPrevia = 22
Global Const vbKeyModificar = 13
Global Const vbKeyCalzar = 0
Global Const vbKeyAnticipar = 0
Global Const vbKeyGeneraInterfaz = vbKeyF11
Global Const VbKeyNuevo = vbKeyL
Global Const VbKeyDetalle = vbKeyD
Global Const VbKeyActivar = 43
Global Const VbKeyDesactivar = 45



'Formato con 4 decimales, para la configuración regional
Public Declare Function GetDeviceCaps Lib "gdi32" (ByVal hDC As Long, ByVal nIndex As Long) As Long
'=========================================================================================================================
'============ RESCATA EL NOMBRE DEL USUARIO Y EL NOMBRE DEL TERMINAL =====================================================
Declare Function GetUserName Lib "advapi32.dll" Alias "GetUserNameA" (ByVal lpBuffer As String, nSize As Long) As Long
Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, nSize As Long) As Long

Global ComputerName As String '® Nombre Terminal
Global Usuario As String      '® Nombre Usuario
'==================================================================================================
'=========================================================================================================================

Global Const FDecimal = "#,##0.0000"
Global Const FEntero = "#,##0"
Global Const FechaYMD = "yyyymmdd"

Global Const TITSISTEMA = "Control de Accesos de Usuarios"
Global gsBAC_Login            As Boolean
Global gsBAC_User             As String
Global VerSQL                 As String
Global gsUsuario              As String
Global Const feFECHA = "yyyymmdd"

'---- LEER INI

Declare Function RegOpenKey Lib "advapi32.dll" Alias "RegOpenKeyA" (ByVal Hkey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Declare Function RegQueryValueEx Lib "advapi32.dll" Alias "RegQueryValueExA" (ByVal Hkey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, lpType As Long, lpData As Any, lpcbData As Long) As Long

Public Const HKEY_CLASSES_ROOT = &H80000000
Public Const HKEY_CURRENT_USER = &H80000001
Public Const HKEY_LOCAL_MACHINE = &H80000002
Public Const HKEY_USERS = &H80000003
Public Const HKEY_PERFORMANCE_DATA = &H80000004
Public Const REG_SZ = 1
Public Const ERROR_SUCCESS = 0&
Public Const RUTA_REGISTRO = "Software\BAC\Trader\"
'==========================================================================
'==================== GRABACION DE LOG AUDITORIA ==========================
'==========================================================================

'*****************************JuanLizama***********************************
Global sFileInicio   As String

'**************************************************************************


Public Sub LogAuditoria(Codigo_Evento As String, Codigo_Menu As String, Detalle_Trans As String, valor_antiguo As String, valor_nuevo As String)
    
    Call Grabar_Log_Auditoria("1" _
                                 , gsbac_fecp _
                                 , ComputerName _
                                 , gsUsuario _
                                 , "ADM" _
                                 , Codigo_Menu _
                                 , Codigo_Evento _
                                 , Detalle_Trans _
                                 , " " _
                                 , valor_antiguo _
                                 , valor_nuevo)
End Sub

Sub Grabar_Log_Auditoria( _
                              Entidad As String _
                            , fechaproc As Date _
                            , Terminal As String _
                            , Usuario As String _
                            , Id_Sistema As String _
                            , Codigo_Menu As String _
                            , Evento As String _
                            , Detalle_Transac As String _
                            , TablaInvolucrada As String _
                            , ValorAntiguo As String _
                            , ValorNuevo As String _
                        )

    Envia = Array()
    
    AddParam Envia, Entidad
    AddParam Envia, fechaproc
    AddParam Envia, Terminal
    AddParam Envia, Usuario
    AddParam Envia, Id_Sistema
    AddParam Envia, Codigo_Menu
    AddParam Envia, Evento
    AddParam Envia, Detalle_Transac
    AddParam Envia, TablaInvolucrada
    AddParam Envia, ValorAntiguo
    AddParam Envia, ValorNuevo

    If BAC_SQL_EXECUTE("Sp_Grabar_Log_AUDITORIA", Envia) Then
        If BAC_SQL_FETCH(Datos()) Then
            If Datos(1) = "NO" Then MsgBox "Problemas al Grabar log Auditoria", vbOKOnly + vbExclamation
        End If
    Else
      If Micro = 0 Then MsgBox "Problemas al Grabar log Auditoria", vbOKOnly + vbCritical
    End If


End Sub
'=========================================================================================
'============================= FIN GRABACION LOG AUDITORIA ===============================
'=========================================================================================

Function Proc_Carga_Parametros() As Boolean
   
   Dim Datos()
   
   Proc_Carga_Parametros = False
   
   If Not BAC_SQL_EXECUTE("sp_bacswapparametros_cargaparametros") Then
        
      Exit Function
      
   End If
     
   If BAC_SQL_FETCH(Datos()) Then
      gsbac_fecp = Datos(1)
      gsBAC_Clien = Datos(2)
   
      gsBac_FecAn = Datos(6)
      gsBAC_Fecpx = Datos(3)
   
   End If
     
   'If Not Bac_Sql_Execute("sp_bacswapparametros_traecartera") Then
   
      'Exit Function
      
   'End If
   
   
   'If Not gsc_Parametros.DatosGenerales() Then
   
      'Exit Function
      
   'End If
      
   Proc_Carga_Parametros = True

End Function

Public Function DatosGenerales() As Boolean
Dim Datos()

    DatosGenerales = False
'    Call objCentralizacion.SqlConeccion(SqlConexion, SqlResultado)
    Envia = Array("ME")
    If Not BAC_SQL_EXECUTE("sp_CargaParametros_ControlFinanciero", Envia) Then
        
        End
    
    End If
    
    If BAC_SQL_FETCH(Datos()) Then
        
        gsbac_fecp = Format(Datos(1), gsc_FechaDMA)
        gsBAC_DolarObs = CDbl(Datos(2))
        gsBAC_ValmonUF = CDbl(Datos(3))
        gsBAC_Fecpx = Datos(4)
        gsBAC_Clien = Datos(5)
        gsBAC_DolarAcuer = CDbl(Datos(6))
        giBAC_Entidad = 1
        'gsBac_Version = Trim("BacTrader " & gsBAC_Clien)
        DatosGenerales = True
    
    Else
        
        MsgBox "Falla Recuperando Parametros.", 16
        End
    
    End If

End Function

Sub NameUserTerm()
   Dim Tamaño As Long
   'Usuario
   Usuario = Space$(260)
   Tamaño = Len(Usuario)
   Call GetUserName(Usuario, Tamaño)
   Usuario = left$(Usuario, Tamaño)
    
   'Computer Name
   ComputerName = Space$(260)
   Tamaño = Len(ComputerName)
   Call GetComputerName(ComputerName, Tamaño)
   ComputerName = left$(ComputerName, Tamaño)
    
End Sub

'**********************************JuanLizama**************************************
Public Function BacInit() As Boolean
   
Dim sSeparadorFecha$

   BacInit = False

   'Traer datos generales del Sistema
   sFileInicio = "Bac-Inicio.ini"
   
   If Dir("C:\WINNT\" & sFileInicio) <> "" Then
      sFileInicio = "C:\WINNT\" & sFileInicio
      
   'ElseIf Dir("C:\WINDOWS\" & sFileInicio) <> "" Then
   '   sFileInicio = "C:\WINDOWS\" & sFileInicio
      
   ElseIf Dir("C:\BTRADER\" & sFileInicio) <> "" Then
      sFileInicio = "C:\BTRADER\" & sFileInicio
   
   ElseIf Dir("C:\" & sFileInicio) <> "" Then
      sFileInicio = "C:\" & sFileInicio
   
   ElseIf Dir(App.Path & "\" & sFileInicio) <> "" Then
      sFileInicio = App.Path & "\" & sFileInicio
   
   Else
   
      MsgBox "Archivo de Configuraciones No existe.", vbCritical, TITSISTEMA
      End
      
   End If
      
 '  Dim sFile$
 '  Dim sSeparadorFecha$

 '  BacInit = False

 '  gsBAC_User = FUNC_LEER_REGISTRO("SISTEMAS BAC", "NET", "USER_NAME")
 '  gsBAC_Term = FUNC_LEER_REGISTRO("SISTEMAS BAC", "NET", "COMPUTER_NAME")
 '  gsBAC_Pass$ = ""
   
   gsBac_RutaIni = UCase(Func_Read_INI("NET", "Path", sFileInicio))
   gsBAC_User = Func_Read_INI("ACCESO", "USERNAME", sFileInicio)
    
   sFile$ = gsBac_RutaIni & "Bac-Sistemas.ini"
   
   If Dir(sFile$) = "" Then
        MsgBox "Archivo de Configuraciones No Existe", 16, TITSISTEMA
        Exit Function
   End If
    
  
'NET y Datos Grales.
   
   GLB_Terminal_Bac = Environ("ComputerName")
   GLB_SQL_Password = ""
   
   If GLB_Terminal_Bac = "" Then
      MsgBox "Terminal no especificado" + Chr(13) + "en archivo de configuraciones", 16, TITSISTEMA
      Exit Function
   End If
  
   Call NameUserTerm
   
   gsSQL_DataBase = Func_Read_INI("SQL", "DB_ACCESO", sFile$)
'FUNC_LEER_REGISTRO("SISTEMAS BAC", "BASE DE DATOS", "DB_ACCESO")

   gsSQL_Server = Func_Read_INI("SQL", "Server_Name", sFile$)
'FUNC_LEER_REGISTRO("SISTEMAS BAC", "SQL", "SERVER_NAME")

   gsSQL_Login = Func_Read_INI("SQL", "Login_Name", sFile$)
'FUNC_LEER_REGISTRO("SISTEMAS BAC", "SQL", "LOGIN_NAME")

   gsSQL_Password = Func_Read_INI("SQL", "Password", sFile$)
'FUNC_LEER_REGISTRO("SISTEMAS BAC", "SQL", "PASSWORD")

   giSQL_LoginTimeOut = Val(Func_Read_INI("SQL", "Login_TimeOut", sFile$))
'Val (FUNC_LEER_REGISTRO("SISTEMAS BAC", "SQL", "LOGIN_TIMEOUT"))

   giSQL_QueryTimeOut = Val(Func_Read_INI("SQL", "Query_TimeOut", sFile$))
'Val (FUNC_LEER_REGISTRO("SISTEMAS BAC", "SQL", "QUERY_TIMEOUT"))

   giSQL_ConnectionMode = Val(Func_Read_INI("SQL", "Connection_Mode", sFile$))
'Val (FUNC_LEER_REGISTRO("SISTEMAS BAC", "SQL", "CONNECTION_MODE"))

   gsODBC = Func_Read_INI("SQL", "ODBC_Parametros", sFile$)
'FUNC_LEER_REGISTRO("SISTEMAS BAC", "ODBC", "ODBC_ACCESO")

   GLB_ODBC = Func_Read_INI("SQL", "ODBC_Pasivo", sFile$)


   gsSQL_Password = Func_Read_INI("SQL", "Password", sFile$)
   gsSQL_Password = Encript(Func_Read_INI("SQL", "Password1", sFile$), False)


   If gsSQL_DataBase = "" Or gsSQL_Server = "" Then
      MsgBox "Servidor No esta definido para conectarse con Base de Datos", vbCritical
      Exit Function
      
   ElseIf giSQL_LoginTimeOut <= 0 Or giSQL_QueryTimeOut <= 0 Then
      MsgBox "Tiempos de Respuesta No son los apropiados para conectarse con Base de Datos", vbCritical
      Exit Function
      
   ElseIf gsODBC = "" Then
      MsgBox "Coneccion ODBC No esta definida para conectarse con Base de Datos", vbCritical
      Exit Function
      
   End If
      
   swConeccion = "DSN=" & gsODBC
   swConeccion = swConeccion & ";UID=" & gsSQL_Login
   swConeccion = swConeccion & ";PWD=" & gsSQL_Password
   swConeccion = swConeccion & ";DSQ=" & gsSQL_DataBase
    
'   gsRpt_Path = FUNC_LEER_REGISTRO("SISTEMAS BAC", "REPORTES", "REPORTES_ACCESOS")

    Dim Attribs As String

'       Attribs = "Description=SQL_PARAMCORPBANCA" & Chr$(13)
'       Attribs = Attribs & "Server=" & GLB_SQL_Server & Chr$(13)
'       Attribs = Attribs & "Database=" & GLB_SQL_Database

       Attribs = "Description=SQL_PARAMCORPBANCA" & Chr$(13)
       Attribs = Attribs & "Server=" & gsSQL_Server & Chr$(13)
       Attribs = Attribs & "Database=" & gsSQL_DataBase

       DBEngine.RegisterDatabase GLB_ODBC, "SQL Server", True, Attribs

    
    GLB_Ubicacion_Reporte = Func_Read_INI("REPORTES", "RPT_Pasivo", sFile$)
   
    GLB_Ubicacion_Documento = Func_Read_INI("DOCUMENTOS", "DOC_Pasivo", sFile$)
    
    GLB_Lineas = Func_Read_INI("LINEAS", "Lineas", sFile$)
       
   sSeparadorFecha$ = "/"
   
   If InStr(1, Format(Date, "dd/mm/yyyy"), "-") > 0 Then
      sSeparadorFecha$ = "-"
   ElseIf InStr(1, Format(Date, "dd/mm/yyyy"), "/") > 0 Then
      sSeparadorFecha$ = "/"
   End If
    
   gsc_PuntoDecim = Mid$(Format(0#, "0.0"), 2, 1)
   
   If gsc_PuntoDecim = "." Then
      gsc_SeparadorMiles = ","
   Else
      gsc_SeparadorMiles = "."
   End If
   
   gsc_FechaDMA = "DD" + sSeparadorFecha$ + "MM" + sSeparadorFecha$ + "YYYY"
   gsc_FechaMDA = "MM" + sSeparadorFecha$ + "DD" + sSeparadorFecha$ + "YYYY"
   gsc_FechaAMD = "YYYY" + sSeparadorFecha$ + "MM" + sSeparadorFecha$ + "DD"
   gsc_FechaSeparador = sSeparadorFecha$
   
   If gsc_PuntoDecim = gsc_SeparadorMiles Then
      MsgBox "El símbolo utilizado en el separador de miles" & vbCrLf & "y del punto decimal son iguales.", vbCritical
      Exit Function
   End If
   
   If sSeparadorFecha$ <> gsc_FechaSeparador And sSeparadorFecha$ <> "-" Then
      MsgBox "El simbolo utilizado en la separación " & vbCrLf & "de la fecha no corresponde.", vbCritical
      Exit Function
   End If
  
   gbBac_Login = False
   giBAC_Entidad = 1
   gsBAC_Term = ComputerName
   
   gsBac_Version = FUNC_LEER_REGISTRO("SISTEMAS BAC", "PARAMS", "VERSION")
   
   BacInit = True
    
End Function

'*********************************************************************************

Public Sub DetectarResolucion(MDIFormx As Object, Formx As Object)
   Dim ancho As Integer, alto As Integer
   ancho = GetDeviceCaps(Formx.hDC, 8)
   alto = GetDeviceCaps(Formx.hDC, 10)
   If ancho <> 800 And alto <> 600 Then
      MDIFormx.Picture = Formx.Picture
   End If
   Unload Formx
End Sub

Public Function IsDateProc(Fecha As Date) As Boolean

    IsDateProc = True
    
    If BAC_SQL_EXECUTE("Sp_Acces_TraeFecha") Then
   
        If BAC_SQL_FETCH(Datos()) Then
        
            If Fecha < Datos(2) Then
            
                IsDateProc = False
                Exit Function
                        
            End If
        
        End If
   
    End If
    
    
End Function

   
Public Function VerPassWord(xTipo, xUsuario, xClave As String) As Boolean

   VerPassWord = False

   Envia = Array()
   AddParam Envia, xTipo
   AddParam Envia, xUsuario
   AddParam Envia, xClave


   If BAC_SQL_EXECUTE("Sp_TraePassWord", Envia) Then
   
      If BAC_SQL_FETCH(Datos()) Then
      
         If xClave = Datos(1) Then
      
            Exit Function
         
         End If
      
         If xClave = Datos(2) Then
      
            Exit Function
         
         End If
         
         If xClave = Datos(3) Then
      
            Exit Function
         
         End If
      
         If xClave = Datos(4) Then
      
            Exit Function
         
         End If
      
      End If
   
   End If

   VerPassWord = True

End Function


Sub PROC_CARGA_AYUDA(oForm As Form, NumeroF As String)
''''''Dim Datos()
''''''On Error GoTo ERRCARGAAYUDA
''''''
''''''Envia = Array()
''''''AddParam Envia, "ADM"
''''''AddParam Envia, oForm.Name + Trim(NumeroF)                      'jspp homologaciones se agrego TRIM(
''''''
''''''If Not BAC_SQL_EXECUTE("SP_CON_AYUDA_SISTEMA", Envia) Then GoTo ERRCARGAAYUDA
''''''If Not BAC_SQL_FETCH(Datos()) Then GoTo ERRCARGAAYUDA
''''''
''''''If Dir(Datos(1)) = "" Then GoTo ERRCARGAAYUDA
''''''
''''''App.HelpFile = Datos(1)
''''''oForm.HelpContextID = Datos(2)
''''''
''''''Exit Sub
''''''ERRCARGAAYUDA:
''''''   App.HelpFile = ""
''''''   oForm.HelpContextID = 0
End Sub
'*******************************JuanLizama****************************************
Function Func_Read_INI(cSection$, cKeyName$, sFilename As String) As String

Dim sret As String

sret = String(255, Chr(0))
Func_Read_INI = left(sret, GetPrivateProfileString(cSection$, ByVal cKeyName$, "", sret, Len(sret), sFilename))

End Function

'*********************************************************************************
'*****************JUANLIZAMA******************************************************
 Public Function Chequeo_Estado(sSistema As String, sCodigo As String, bMensaje As Boolean, Optional ByRef sMensaje As String) As Boolean
     Chequeo_Estado = Check_Status(sCodigo, bMensaje)
 End Function
'*********************************************************************************
'**************************JUANLIZAMA*********************************************
 Public Function Check_Status(sCodigo As String, bMensaje As Boolean) As Boolean
 'As String


'   Dim iContador           As Integer
'   Dim sMensaje            As String
'
'   Check_Status = "-1"
'
   
    Dim Datos()

   'Call Limpiar

    GLB_Envia = Array("PSV")
    ', IIf(FinMesEspecial, "1", "0"))

    If BAC_SQL_EXECUTE("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
      Do While BAC_SQL_FETCH(Datos())
         'mvarNombre = Datos(4)
         'Call Agregar(Datos(6), Datos(8), Datos(5), Datos(7), Datos(10))


   'Call Analizar_Datos
   
'   Call Cargar_Datos
'   Call Analizar_Datos
'
      If Datos(6) = "FIN" And Datos(5) = "1" Then
         lFin = True

      End If



'   sMensaje = ""
'   sCodigo = UCase(sCodigo)
'
    If Datos(6) = "FIN" Then
       If Datos(5) = "1" Then
'          Check_Status = "1"
          Check_Status = True
'          Call Evento(True, 0, objEstado(objEstado.Count).Descripcion & " ya fue realizado", objEstado(objEstado.Count).Descripcion)
'
       Else
'         For iContador = 1 To objEstado.Count
'            If objEstado(iContador).Estado = "0" Then
'               sMensaje = PROC_ERRORES(mvarSistema & "-> Chequeo Estado", sCodigo, bMensaje)
'               Call Evento(False, 400, sMensaje, objEstado(iContador).Descripcion)
'               Exit For
'
'            ElseIf objEstado(iContador).Codigo = sCodigo Then
'               Check_Status = (objEstado(iContador).Estado)
'               Call Evento(True, 0, objEstado(iContador).Descripcion, objEstado(iContador).Descripcion)
'               Exit For
'
'            End If

'         Next iContador
'
       End If
'
'      Check_Status = IIf(sMensaje = "", "0", "1")
'      Exit Function
'
    ElseIf Datos(6) = "INICIO" Then
       If Datos(5) <> 1 Then
'          Check_Status = "0"
          Check_Status = False
'         Call Evento(False, 500, "Falta realizar Inicio de día", "Inicio de día")
          Exit Function
'
       End If
'
'      For iContador = 1 To objEstado.Count
'         If objEstado(iContador).Codigo = sCodigo Then
'            If objEstado(iContador).Estado = "1" Then
'               Check_Status = "0"
'               Call Evento(True, 600, "Inicio de día ya fue realizado", "Inicio de día")
'               Exit Function
'
'            End If
'
'         End If
'
'      Next iContador
'
'      Check_Status = "0"
'      Call Evento(True, 0, "Inicio de día", "Inicio de día")
'      Exit Function
'
    End If
'
    If lFin Then
'      sMensaje = PROC_ERRORES(mvarSistema & "-> Chequeo Estado", sCodigo, bMensaje)
'
       If Datos(5) = 1 Then
'         Check_Status = IIf(sMensaje = "", "0", "1")
'         Call Evento(False, 200, "Fin de día ya realizado", "Fin de día")
'
       End If
'
       Exit Function
'
    End If
'
'   For iContador = 1 To objEstado.Count
'      If objEstado(iContador).Estado = "0" And objEstado(iContador).Orden > 0 Then
'         If objEstado(iContador).Codigo = sCodigo Then
'            Check_Status = objEstado(iContador).Estado
'            Call Evento(False, 0, objEstado(iContador).Descripcion & " no ha sido realizado", objEstado(iContador).Descripcion)
'            Exit Function
'
'         Else
'            sMensaje = PROC_ERRORES(mvarSistema & "-> Chequeo Estado", sCodigo, bMensaje)
'            Check_Status = IIf(sMensaje = "", "0", "1")
'
'            If sMensaje <> "" Then
'               Call Evento(False, 100, sMensaje, objEstado(iContador).Descripcion)
'
'            End If
'
'            Exit Function
'
'         End If
'
'         Exit For
'
'      ElseIf objEstado(iContador).Codigo = sCodigo Then
'         If objEstado(iContador).Switch = "3" Then
'            If (objEstado(iContador).Estado) Then
'               Check_Status = False
'               Call Evento(False, 700, objEstado(iContador).Descripcion & " ya fue realizado", objEstado(iContador).Descripcion)
'
'            Else
'               Check_Status = True
'               Call Evento(True, 0, objEstado(iContador).Descripcion, objEstado(iContador).Descripcion)
'
'            End If
'
'         Else
'            Check_Status = (objEstado(iContador).Estado)
'
'            If (objEstado(iContador).Estado) Then
'               Call Evento(objEstado(iContador).Estado, 0, objEstado(iContador).Descripcion & " ya fue realizado", objEstado(iContador).Descripcion)
'
'            Else
'               Call Evento(objEstado(iContador).Estado, 0, objEstado(iContador).Descripcion, objEstado(iContador).Descripcion)
'
'            End If
'
'         End If
'
'         Exit Function
'
'      End If
'
'   Next iContador
'
       Loop

    End If
 
 
 End Function
'
'**********************************************************************************






