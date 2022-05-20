Attribute VB_Name = "MOD_FUNCIONES"
'---- LEER INI

Declare Function RegOpenKey Lib "advapi32.dll" Alias "RegOpenKeyA" (ByVal Hkey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Declare Function RegQueryValueEx Lib "advapi32.dll" Alias "RegQueryValueExA" (ByVal Hkey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, lpType As Long, lpData As Any, lpcbData As Long) As Long

Declare Function RegCreateKey Lib "advapi32.dll" Alias "RegCreateKeyA" (ByVal Hkey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Declare Function RegSetValueEx Lib "advapi32.dll" Alias "RegSetValueExA" (ByVal Hkey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, lpData As Any, ByVal cbData As Long) As Long
Declare Function RegCloseKey Lib "advapi32.dll" (ByVal Hkey As Long) As Long



Public Const HKEY_CLASSES_ROOT = &H80000000
Public Const HKEY_CURRENT_USER = &H80000001
Public Const HKEY_LOCAL_MACHINE = &H80000002
Public Const HKEY_USERS = &H80000003
Public Const HKEY_PERFORMANCE_DATA = &H80000004
Public Const REG_SZ = 1
Public Const ERROR_SUCCESS = 0&
Public Const RUTA_REGISTRO = "Software\BAC\Trader\"
Global sFileInicio   As String
Public lFin As Boolean

Public Function FUNC_BLOQUEO_USUARIO(cUsuario As String) As Boolean

Dim vDatos_Retorno()

FUNC_BLOQUEO_USUARIO = False

   
   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, cUsuario

   If FUNC_EXECUTA_COMANDO_SQL("SP_CON_BLOQUEO_USUARIO", GLB_Envia) Then
       
       If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
          
          If vDatos_Retorno(1) = "0" Then
             
             FUNC_BLOQUEO_USUARIO = True
             Exit Function
          
          End If
       
       End If
   
   End If
   
End Function

Function FUNC_FECHA_EXPIRACION(dFechaExpira As Date) As Boolean
   
   FUNC_FECHA_EXPIRACION = False
   
   If Format(GLB_Fecha_Proceso, "yyyymmdd") < Format(dFechaExpira, "yyyymmdd") Then
   
      Exit Function
   
   End If

   FUNC_FECHA_EXPIRACION = True

End Function

Function FUNC_BLOQUEA_USUARIO(bBloquea As Boolean, cUsuario As String) As Boolean

Dim vDatos_Retorno()

   FUNC_BLOQUEA_USUARIO = False

   
      GLB_Envia = Array()
      PROC_AGREGA_PARAMETRO GLB_Envia, cUsuario
      PROC_AGREGA_PARAMETRO GLB_Envia, IIf(bBloquea, 1, 0)
   
      If FUNC_EXECUTA_COMANDO_SQL("SP_PRO_BLOQUEA_USUARIO", GLB_Envia) Then
      
         Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
         Loop
      
      Else
         
         Exit Function
      
      End If

   FUNC_BLOQUEA_USUARIO = True

End Function

Function FUNC_VALIDA_CONFIGURACION_REGIONAL() As Boolean

    FUNC_VALIDA_CONFIGURACION_REGIONAL = False
    
    If CStr(Format(CDate("31/12/2000"), GLB_FORMATO_FECHA_REGIONAL)) <> Format("31/12/2000", GLB_FORMATO_FECHA_REGIONAL) Then
       
       Exit Function
    
    End If
    
    FUNC_VALIDA_CONFIGURACION_REGIONAL = True

End Function

Function FUNC_DESCONECTAR_SQL() As Boolean

On Error GoTo ErrDesconectar
  
  FUNC_DESCONECTAR_SQL = False

   GLB_Sql_Conexion.Close

   Set GLB_Sql_Conexion = Nothing

  FUNC_DESCONECTAR_SQL = True
  
Exit Function

ErrDesconectar:
     
     MsgBox "Error al desconectar: " & Err.Description, vbOKOnly + vbExclamation
     
     Exit Function

End Function

Public Function FUNC_INICIO_SISTEMA() As Boolean
   
   Dim Datos()
   Dim cDato       As String
   Dim nI          As Integer
   Dim cNewqueue   As String

   FUNC_INICIO_SISTEMA = False

   'Traer datos generales del Sistema

   'NET y Datos Grales.
   GLB_Terminal_Bac = FUNC_LEER_REGISTRO("SISTEMAS BAC", "NET", "COMPUTER_NAME")
   GLB_SQL_Password = ""
   'GLB_Sistema = "PSV"
   
   Call PROC_NOMBRE_USUARIO_TERMINAL

   GLB_Usuario_Bac = IIf(Trim(FUNC_LEER_REGISTRO("SISTEMAS BAC", "NET", "USER_NAME")) = "", GLB_Usuario_Bac, FUNC_LEER_REGISTRO("SISTEMAS BAC", "NET", "USER_NAME"))
   
   'SQL
   GLB_SQL_Database = FUNC_LEER_REGISTRO("SISTEMAS BAC", "BASE DE DATOS", "DB_PASIVO")
   GLB_SQL_Server = FUNC_LEER_REGISTRO("SISTEMAS BAC", "SQL", "SERVER_NAME")
   GLB_SQL_Login = FUNC_LEER_REGISTRO("SISTEMAS BAC", "SQL", "LOGIN_NAME")
   GLB_SQL_Password = FUNC_LEER_REGISTRO("SISTEMAS BAC", "SQL", "PASSWORD")
   GLB_SQL_LoginTimeOut = Val(FUNC_LEER_REGISTRO("SISTEMAS BAC", "SQL", "LOGIN_TIMEOUT"))
   GLB_SQL_QueryTimeOut = Val(FUNC_LEER_REGISTRO("SISTEMAS BAC", "SQL", "QUERY_TIMEOUT"))
   GLB_SQL_ConnectionMode = Val(FUNC_LEER_REGISTRO("SISTEMAS BAC", "SQL", "CONNECTION_MODE"))
   GLB_ODBC = FUNC_LEER_REGISTRO("SISTEMAS BAC", "ODBC", "ODBC_PASIVO")

   If GLB_SQL_Database = "" Or GLB_SQL_Server = "" Then
   
      MsgBox "Servidor No esta definido para conectarse con Base de Datos", vbCritical
      Exit Function
      
   ElseIf GLB_SQL_LoginTimeOut <= 0 Or GLB_SQL_QueryTimeOut <= 0 Then
   
      MsgBox "Tiempos de Respuesta No son los apropiados para conectarse con Base de Datos", vbCritical
      Exit Function
      
   ElseIf GLB_ODBC = "" Then
   
      MsgBox "Coneccion ODBC No esta definida para conectarse con Base de Datos", vbCritical
      Exit Function
      
   End If
      
   SwConeccion = "DSN=" & GLB_ODBC
   SwConeccion = SwConeccion & ";UID=" & GLB_SQL_Login
   SwConeccion = SwConeccion & ";PWD=" & GLB_SQL_Password
   SwConeccion = SwConeccion & ";DSQ=" & GLB_SQL_Database
   GLB_CONECCION = SwConeccion
   
   
    Set MyWorkspace = Workspaces(0)
    Attribs = "Description=" & GLB_ODBC & Chr$(13)
    Attribs = Attribs & "Server=" & GLB_SQL_Server & Chr$(13)
    Attribs = Attribs & "Trusted_Connection=yes" & Chr$(13)
    Attribs = Attribs & "Database=" & GLB_SQL_Database
    DBEngine.RegisterDatabase GLB_ODBC, "SQL Server", True, Attribs
    MyWorkspace.Close

 '  gsMDB_Path = Func_Read_INI("MDB", "MDB_Path", sFile$)
   
   GLB_Ubicacion_Reporte = FUNC_LEER_REGISTRO("SISTEMAS BAC", "REPORTES", "REPORTES_PASIVO")

   GLB_Ubicacion_Documento = FUNC_LEER_REGISTRO("SISTEMAS BAC", "DOCUMENTOS", "DOC_PASIVO")

  ' PARAMSe
    GLB_Moneda_Local = Val(FUNC_LEER_REGISTRO("SISTEMAS BAC", "PARAMS", "MONEDA_LOCAL"))
  
  ' Definición Busqueda de Archivos TXT
    GLB_Dirin = Trim(FUNC_LEER_REGISTRO("SISTEMAS BAC", "PARAMS", "DIRECTORIO_INICIAL"))
    GLB_Version_Sistema = Trim(FUNC_LEER_REGISTRO("SISTEMAS BAC", "PARAMS", "VERSION"))

    If GLB_Papeleta = "" Then
        GLB_Papeleta = "1"            'Salida de las papeletas a impresora
    End If

  ' Otros.-
   
   GLB_Login = False
   GLB_Punto_Decimal = Mid(Format(0#, "0.0"), 2, 1)
    
   If GLB_Punto_Decimal = "." Then
       gsc_SeparadorMiles = ","
       
   Else
       gsc_SeparadorMiles = "."

   End If

  'Lineas
   GLB_Lineas = FUNC_LEER_REGISTRO("SISTEMAS BAC", "LINEAS", "CONTROL")
   
   'Servicios
   GLB_Servicio = FUNC_LEER_REGISTRO("SISTEMAS BAC", "SERVICIO", "CONTROL")
   

   FUNC_INICIO_SISTEMA = True
   
End Function

Public Function BacInit() As Boolean

   Dim sSeparadorFecha$

   BacInit = False

   'Traer datos generales del Sistema
   sFileInicio = "Bac-Inicio.ini"
   
   If Dir(App.Path & "\" & sFileInicio) <> "" Then
      sFileInicio = App.Path & "\" & sFileInicio
      
   ElseIf Dir("C:\WINNT\" & sFileInicio) <> "" Then
      sFileInicio = "C:\WINNT\" & sFileInicio
      
   ElseIf Dir("C:\WINDOWS\" & sFileInicio) <> "" Then
      sFileInicio = "C:\WINDOWS\" & sFileInicio
      
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
      
   gsBac_RutaIni = UCase(Func_Read_INI("NET", "Path", sFileInicio))
   gsBAC_User = Func_Read_INI("ACCESO", "USERNAME", sFileInicio)
   
   sfile$ = gsBac_RutaIni & "Bac-Sistemas.ini"
   
   If Dir(sfile$) = "" Then
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
   
   'SQL
   GLB_SQL_Database = Func_Read_INI("SQL", "DB_Pasivo", sfile$)
   GLB_SQL_Server = Func_Read_INI("SQL", "Server_Name", sfile$)
   GLB_SQL_Login = Func_Read_INI("SQL", "Login_Name", sfile$)
   GLB_SQL_Password = Func_Read_INI("SQL", "Password", sfile$)
   GLB_SQL_Password = Encript(Func_Read_INI("SQL", "Password1", sfile$), False)
   GLB_SQL_LoginTimeOut = Val(Func_Read_INI("SQL", "Login_TimeOut", sfile$))
   GLB_SQL_QueryTimeOut = Val(Func_Read_INI("SQL", "Query_TimeOut", sfile$))
   GLB_SQL_ConnectionMode = Val(Func_Read_INI("SQL", "Connection_Mode", sfile$))
   GLB_ODBC = Func_Read_INI("SQL", "ODBC_Pasivo", sfile$)
   GLB_Ruta_Int_Contable = Func_Read_INI("RUTA_INTERFAZ_CONTABLE", "RutaInterfazContable", sfile$)
   GLB_Ruta_Int_Descalce = Func_Read_INI("RUTA_INTERFAZ_DESCALCE", "RutaInterfazDescalce", sfile$)
   
   
   gsIp_MaqCtbNeo = Func_Read_INI("NEOSOFT", "IP_SERV_NEO", sfile$)
   gsUser_maqNeo = Func_Read_INI("NEOSOFT", "USERNAME_NEO", sfile$)
   gsPass_maqNeo = Func_Read_INI("NEOSOFT", "PASSWORD_NEO", sfile$)
   gsPath_maqNeo = Func_Read_INI("NEOSOFT", "RUTA_ARCHIVO_NEO", sfile$)
   
   GLB_Ruta_Int_P36 = Func_Read_INI("RUTA_INTERFAZ_P36", "RutaInterfazP36", sfile$)
   '**************************************JPL*************************************************
   GLB_Ruta_Int_C40 = Func_Read_INI("RUTA_INTERFAZ_C40", "RutaInterfazC40", sfile$)
   '******************************************************************************************
   '**************************************JPL*************************************************
   GLB_Ruta_Int_Operaciones = Func_Read_INI("RUTA_INTERFAZ_OPERACIONES", "RutaInterfazOperaciones", sfile$)
   '******************************************************************************************
   '**************************************JPL*************************************************
   GLB_Ruta_Int_Flujos = Func_Read_INI("RUTA_INTERFAZ_FLUJOS", "RutaInterfazFlujos", sfile$)
   '******************************************************************************************
   '**************************************JPL*************************************************
   GLB_Ruta_Int_Balance = Func_Read_INI("RUTA_INTERFAZ_BALANCE", "RutaInterfazBalance", sfile$)
   '******************************************************************************************
   '**************************************JPL*************************************************
   GLB_Ruta_Int_ClienteOperacion = Func_Read_INI("RUTA_INTERFAZ_CLIENTEOPERACION", "RutaInterfazClienteOperacion", sfile$)
   '******************************************************************************************
   
   GLB_Version_Sistema = "8.0"
   'gsBAC_Autorizado = Func_Read_INI("DATAOTC", "Autorizado", sFile$)
   'giSQL_ControlFin = Func_Read_INI("SQL", "DB_ControlFin", sFile$)
   'gsSQL_DatabaseHis = Func_Read_INI("SQLHIS", "DBHIS_Forward", sFile$)
   
   '-- INI - Control de Precios
   'giSQL_DatabaseCommon = Func_Read_INI("SQL", "DB_Parametros", sFile$)
   '-- FIN - Control de Precios
   
   If GLB_SQL_Database = "" Or GLB_SQL_Database = "" Then
      MsgBox "Servidor No esta definido para conectarse con Base de Datos", vbCritical, TITSISTEMA
      Exit Function
      
   ElseIf GLB_SQL_Login = "" Then 'Or GLB_SQL_Password = "" Then
      MsgBox "Usuario No esta definido para conectarse con Base de Datos", vbCritical, TITSISTEMA
      Exit Function
      
   ElseIf GLB_SQL_LoginTimeOut <= 0 Or GLB_SQL_QueryTimeOut <= 0 Then
      MsgBox "Tiempos de Respuesta No son los apropiados para conectarse con Base de Datos", vbCritical, TITSISTEMA
      Exit Function
      
   ElseIf GLB_ODBC = "" Then
      MsgBox "Coneccion ODBC No esta definida para conectarse con Base de Datos", vbCritical, TITSISTEMA
      Exit Function
      
   End If
      
   SwConeccion = "DSN=" & GLB_ODBC 'gsODBC
   SwConeccion = SwConeccion & ";UID=" & GLB_SQL_Login 'gsSQL_Login
   SwConeccion = SwConeccion & ";PWD=" & GLB_SQL_Password 'gsSQL_Password1
   SwConeccion = SwConeccion & ";DSQ=" & GLB_SQL_Database 'gsSQL_Database
   
   
   GLB_CONECCION = SwConeccion
   
        Dim Attribs As String

       Attribs = "Description=SQL_PASIVOCORPBANCA" & Chr$(13)
       Attribs = Attribs & "Server=" & GLB_SQL_Server & Chr$(13)
       Attribs = Attribs & "Database=" & GLB_SQL_Database

       DBEngine.RegisterDatabase GLB_ODBC, "SQL Server", True, Attribs
       
       
   GLB_Ubicacion_Reporte = Func_Read_INI("REPORTES", "RPT_Pasivo", sfile$)
   
   GLB_Ubicacion_Documento = Func_Read_INI("DOCUMENTOS", "DOC_Pasivo", sfile$)
   
   'Interfaces
   'gsTXT_Path = Func_Read_INI("TXT", "Sinacofi", sFile$)
   
   
   'If right(gsTXT_Path, 1) <> "\" And left(right(gsTXT_Path, 2), 1) <> ":" Then
   '   gsTXT_Path = gsTXT_Path & "\"
   'End If
   
   'Lineas
   GLB_Lineas = Func_Read_INI("LINEAS", "Lineas", sfile$)

   
   'gsDatatec_Path = Func_Read_INI("TXT", "Datatec_Path", sFile$)
   'gsDatatec_Name = Func_Read_INI("TXT", "Datatec_Name", sFile$)
   'gsOTC_Path = Func_Read_INI("TXT", "OTC_Path", sFile$)
   'gsOTC_Name = Func_Read_INI("TXT", "OTC_Name", sFile$)
   
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
      MsgBox "El simbolo utilizado en el separador de miles" & vbCrLf & "y del punto decimal son iguales.", vbCritical, TITSISTEMA
      Exit Function

   End If

   If sSeparadorFecha$ <> "/" And sSeparadorFecha$ <> "-" Then
      MsgBox "El simbolo utilizado en la separación " & vbCrLf & "de la fecha no corresponde.", vbCritical, TITSISTEMA
      Exit Function

   End If
   
   BacInit = True

End Function
Function Encript(xClave As String, xEncriptar As Boolean) As String
Dim X As Single
Dim xPsw As String
Dim Letras As String
Dim Codigos As String

Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyz_"
Codigos = "RaMbKCgTrZHYFIPAuSiQVONmLfJWzGXEDqBUx_kpjcys{dn}ve]htwl[\`@?><2"
xPsw = ""
Encript = ""

For X = 1 To Len(xClave)
 
 If xEncriptar Then
    xPsw = xPsw + Chr((Asc(Mid(Codigos, InStr(1, Letras, Mid(xClave, X, 1)), 1)) - X))
 Else
    xPsw = xPsw + Mid(Letras, InStr(1, Codigos, Chr(Asc(Mid(xClave, X, 1)) + X)), 1)
 End If
 
Next

Encript = xPsw

End Function

Sub NameUserTerm()
   
   Dim Tamaño As Long

   'Usuario
   usuario = Space$(260)
   Tamaño = Len(usuario)
   Call GetUserName(usuario, Tamaño)
   usuario = left$(usuario, Tamaño)
    
   'Computer Name
   ComputerName = Space$(260)
   Tamaño = Len(ComputerName)
   Call GetComputerName(ComputerName, Tamaño)
   ComputerName = left$(ComputerName, Tamaño)
    
End Sub
Function Func_Read_INI(cSection$, cKeyName$, sFilename As String) As String

Dim sret As String

sret = String(255, Chr(0))
Func_Read_INI = left(sret, GetPrivateProfileString(cSection$, ByVal cKeyName$, "", sret, Len(sret), sFilename))

End Function

Function FUNC_BAC_LOGIN(sUser$, sPWD$) As Boolean

On Error GoTo ErrConectar

  FUNC_BAC_LOGIN = False
  
  GLB_Conexion = "Connect Timeout=" & GLB_SQL_LoginTimeOut & _
             ";Extended Properties='DRIVER=SQL Server;SERVER=" & Trim(GLB_SQL_Server) & _
             ";UID=" & Trim(GLB_SQL_Login) & _
             ";PWD=" & Trim(GLB_SQL_Password) & _
             ";WSID=" & GLB_Terminal_Bac & _
             ";DATABASE=" & Trim(GLB_SQL_Database) & "'"

 Set GLB_Sql_Conexion = New ADODB.Connection
 
 GLB_Sql_Conexion.CommandTimeout = GLB_SQL_QueryTimeOut
 
 GLB_Sql_Conexion.Open GLB_Conexion

 Set GLB_Sql_Resultado = New ADODB.Recordset
 
 GLB_Sql_Resultado.CursorLocation = adUseClient

  FUNC_BAC_LOGIN = True

    Exit Function
    
ErrConectar:

       MsgBox "Error al conectar a Sql" & Chr(10) & Chr(10) & Err.Description, vbOKOnly + vbExclamation
       Exit Function

End Function

Public Function FUNC_LLAMA_FORMULARIO(ByVal sFormName As String) As Boolean
Dim nContador As Integer

   FUNC_LLAMA_FORMULARIO = False

   For nContador = 0 To Forms.Count - 1
   
      If UCase(Forms(nContador).Name) = UCase(sFormName) Then
         
         FUNC_LLAMA_FORMULARIO = True
         
      End If
      
   Next nContador
      

End Function

Function FUNC_DECIMALES(nNumero_Decimales As Integer) As String

Dim cFormato      As String
Dim nContador     As Integer
   
   cFormato = "#,##0"
   FUNC_DECIMALES = Formato
   
   If nNumero_Decimales = 0 Then
      Exit Function
   End If
   
   If nNumero_Decimales > 0 Then
      cFormato = cFormato + "."
      For nContador = 1 To nNumero_Decimales - 1
         cFormato = cFormato + "#"
      Next
      cFormato = cFormato + "0"
   End If
   
   FUNC_DECIMALES = cFormato

End Function

Function FUNC_LEER_REGISTRO(cNombre_APP As String, cSeccion As String, cLlave As String) As String


   FUNC_LEER_REGISTRO = ""
   'FUNC_LEER_REGISTRO = GetString(HKEY_CURRENT_USER, RUTA_REGISTRO & cSeccion, cLlave)


End Function

Public Function FUNC_ENVIA_TECLA(ByVal nKey As Integer)
 
   KeyBD_Event nKey, 0, 0, 0
 
End Function

Function FUNC_FORMATO_GRILLA(Grilla As MSFlexGrid)

   With Grilla
      .ForeColor = GLB_AzulOsc
      .GridLines = flexGridInset
      .GridLinesFixed = flexGridNone
      .ForeColorFixed = GLB_Blanco
      .BackColorFixed = GLB_Verde
      .BackColor = GLB_Gris
      .BackColorBkg = GLB_Gris
      .Font.Name = "Arial"
      .Font.Bold = True
      .Font.Size = 8

   End With

End Function


Public Function FUNC_LLENA_MONEDA(comboMoneda As Object, Tipo_Operacion As String, nTipo_Moneda As Integer) As Boolean
   Dim cSql As String
   Dim vDatos_Retorno()
   
   On Error GoTo ErrMon

   FUNC_LLENA_MONEDA = False
        
   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, 0
   PROC_AGREGA_PARAMETRO GLB_Envia, ""
   PROC_AGREGA_PARAMETRO GLB_Envia, ""
   PROC_AGREGA_PARAMETRO GLB_Envia, ""
   PROC_AGREGA_PARAMETRO GLB_Envia, RTrim(LTrim(Str(nTipo_Moneda)))
   PROC_AGREGA_PARAMETRO GLB_Envia, Tipo_Operacion
   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_MONEDA", GLB_Envia) Then
      Exit Function
   End If
   
   comboMoneda.Clear
   Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
      If Tipo_Operacion = "1" Then
         comboMoneda.AddItem vDatos_Retorno(4)
      Else
         comboMoneda.AddItem vDatos_Retorno(2)
      End If
      comboMoneda.ItemData(comboMoneda.NewIndex) = vDatos_Retorno(1)
   Loop
   
   If comboMoneda.ListCount = 0 Then
      MsgBox "No se han definido tasas", vbInformation
   End If
   
   FUNC_LLENA_MONEDA = True
    
Exit Function
ErrMon:
   MsgBox "Problemas en consulta de monedas: " & Err.Description & ". Comunique al Administrador. ", vbCritical
   Exit Function
End Function


Function FUNC_FORMATO_DECIMALES(vDecimales As Variant) As String

   FUNC_FORMATO_DECIMALES = "#,##0"
   If vDecimales > 0 Then
      FUNC_FORMATO_DECIMALES = FUNC_FORMATO_DECIMALES + "."
      FUNC_FORMATO_DECIMALES = FUNC_FORMATO_DECIMALES + String(vDecimales, "#")
      FUNC_FORMATO_DECIMALES = Mid(FUNC_FORMATO_DECIMALES, 1, Len(FUNC_FORMATO_DECIMALES) - 1) + "0"
   End If
   

End Function

Public Function FUNC_CON_CARTERAS(cNombre As String, cObjeto As Object) As Boolean
Dim vDatos_Retorno()

    FUNC_CON_CARTERAS = False

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, cNombre
             
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_CARTERAS", GLB_Envia) Then
        Exit Function
    End If
    cObjeto.Clear
       
    Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
        
        With cObjeto
            cObjeto.AddItem vDatos_Retorno(4)
            cObjeto.ItemData(cObjeto.NewIndex) = vDatos_Retorno(1)
        End With
        
    Loop
    cObjeto.ListIndex = 0
    FUNC_CON_CARTERAS = True
 
End Function

Public Function FUNC_CON_SUCURSAL(cObjeto As Object, nSucursal As Variant) As Boolean
Dim vDatos_Retorno()

    FUNC_CON_SUCURSAL = False
    
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Trim(Str(nSucursal))

    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_SUCURSAL", GLB_Envia) Then
        Exit Function
    End If
    cObjeto.Clear
    Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
        
        With cObjeto
            cObjeto.AddItem vDatos_Retorno(2)
            cObjeto.ItemData(cObjeto.NewIndex) = vDatos_Retorno(1)
        End With
        
    Loop
    cObjeto.ListIndex = 0
    FUNC_CON_SUCURSAL = True
 
End Function

Public Function FUNC_CON_AREARESP(cObjeto As Object) As Boolean
Dim vDatos_Retorno()

    FUNC_CON_AREARESP = False

    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_AREARESPONSABLE") Then
        Exit Function
    End If
    cObjeto.Clear
    Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
        
        With cObjeto
            cObjeto.AddItem vDatos_Retorno(2)
            'cObjeto.ItemData(cObjeto.NewIndex) = vDatos_retorno(1)
        End With
        
    Loop
    cObjeto.ListIndex = 0
    FUNC_CON_AREARESP = True
 
End Function


Public Function FUNC_CON_TIPO_CARTERA(cObjeto As Object, cProducto As String) As Boolean
Dim vDatos_Retorno()

    FUNC_CON_TIPO_CARTERA = False

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, GLB_Sistema
    PROC_AGREGA_PARAMETRO GLB_Envia, cProducto
    
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_TIPO_CARTERA", GLB_Envia) Then
        Exit Function
    End If
    cObjeto.Clear
    Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
        
        With cObjeto
            cObjeto.AddItem vDatos_Retorno(5)
            cObjeto.ItemData(cObjeto.NewIndex) = vDatos_Retorno(4)
        End With
        
    Loop
    cObjeto.ListIndex = 0
    FUNC_CON_TIPO_CARTERA = True
 
End Function


Public Function FUNC_CON_FORMA_DE_PAGO(cObjeto As Object, nForma As String, cMoneda As String) As Boolean
Dim vDatos_Retorno()
Dim cResultado_Ok As String

cResultado_Ok = "N"

    FUNC_CON_FORMA_DE_PAGO = False

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, cMoneda
    PROC_AGREGA_PARAMETRO GLB_Envia, GLB_Sistema
    
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_FORMA_PAGO", GLB_Envia) Then
        Exit Function
    End If
    cObjeto.Clear
    Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
        
        With cObjeto
            cObjeto.AddItem vDatos_Retorno(2)
            cObjeto.ItemData(cObjeto.NewIndex) = vDatos_Retorno(1)
        End With
        cResultado_Ok = "S"
    Loop
    
    If cResultado_Ok = "S" Then
        cObjeto.ListIndex = 0
    End If
    FUNC_CON_FORMA_DE_PAGO = True
 
End Function


Public Function FUNC_CON_MERCADO(cObjeto As Object, nMercado As Integer) As Boolean
Dim vDatos_Retorno()

    FUNC_CON_MERCADO = False

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, nMercado
    
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_MERCADO", GLB_Envia) Then
        Exit Function
    End If
    cObjeto.Clear
    Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
        
        With cObjeto
            cObjeto.AddItem vDatos_Retorno(2)
            cObjeto.ItemData(cObjeto.NewIndex) = vDatos_Retorno(1)
        End With
        
    Loop
    cObjeto.ListIndex = 0
    FUNC_CON_MERCADO = True
 
End Function

Public Function FUNC_LLENA_BASES(comboMoneda As Object, Tipo_Base As String) As Boolean
Dim cSql As String
Dim vDatos_Retorno()
On Error GoTo ErrMon

    FUNC_LLENA_BASES = False
   
       GLB_Envia = Array()
       PROC_AGREGA_PARAMETRO GLB_Envia, GLB_Sistema
       PROC_AGREGA_PARAMETRO GLB_Envia, 0
       
       cSql = "SP_CON_TIPO_BASE"
    
    If FUNC_EXECUTA_COMANDO_SQL(cSql, GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
            
            comboMoneda.AddItem vDatos_Retorno(2)
            comboMoneda.ItemData(comboMoneda.NewIndex) = vDatos_Retorno(2)
        
        Loop
    
    End If
    
   If comboMoneda.ListCount = 0 Then
      MsgBox "No se ha definido tipo de base", vbInformation
   End If
   
    FUNC_LLENA_BASES = True
    
    Exit Function
    
ErrMon:
    MsgBox "Problemas en consulta de monedas: " & Err.Description & ". Comunique al Administrador. ", vbCritical
    Exit Function
    
End Function

Function FUNC_CON_CMBAMORTIZA(ByRef combo As ComboBox, queSistema As String)

Dim cSql   As String
Dim vDatos_Retorno()
Dim I As Integer
    
    combo.Clear
    
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, 0
    PROC_AGREGA_PARAMETRO GLB_Envia, queSistema
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_TIPO_AMORTIZA", GLB_Envia) Then
       Screen.MousePointer = 0
       Exit Function
    Else
       Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
          combo.AddItem vDatos_Retorno(2)
          combo.ItemData(combo.NewIndex) = Val(vDatos_Retorno(1))
       Loop
    End If
           
End Function
Function FUNC_CON_TIPO_BONO(ByRef combo As ComboBox, queSistema As String)

Dim cSql   As String
Dim vDatos_Retorno()
Dim I As Integer
    
    combo.Clear
    
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, 0
    PROC_AGREGA_PARAMETRO GLB_Envia, queSistema
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_TIPO_BONO", GLB_Envia) Then
       Screen.MousePointer = 0
       Exit Function
    Else
       Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
          combo.AddItem vDatos_Retorno(2)
          combo.ItemData(combo.NewIndex) = Val(vDatos_Retorno(1))
       Loop
    End If
           
End Function

Function FUNC_DEVUELVEDIG(Rut As String) As String

   Dim I          As Integer
   Dim D          As Integer
   Dim Divi       As Long
   Dim Suma       As Long
   Dim Digito     As String
   Dim Multi      As Double

   FUNC_DEVUELVEDIG = ""

   Rut = Format(Rut, Mid$("00000000000", 1, Len(Rut)))

   D = 2

   For I = Len(Rut) To 1 Step -1
      Multi = Val(Mid$(Rut, I, 1)) * D
      Suma = Suma + Multi
      D = D + 1

      If D = 8 Then
         D = 2

      End If

   Next I

   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))

   If Digito = "10" Then
      Digito = "K"

   End If

   If Digito = "11" Then
      Digito = "0"

   End If

   FUNC_DEVUELVEDIG = UCase(Digito)

End Function

Public Function FUNC_CONTROLA_MONTO(xMonto As Variant) As String

   Dim cTemp_Valor   As String
   
   FUNC_CONTROLA_MONTO = xMonto
   
Exit Function
   
   cTemp_Valor = xMonto
   
   If Pbl_Punto_Decimal = "," Then
   
      Mc = InStr(1, xMonto, ",")
      
      If Mc > 0 Then
      
         cTemp_Valor = Mid(xMonto, 1, Mc - 1) & "." & Mid(xMonto, Mc + 1)
         
      End If
      
   End If
   
   FUNC_CONTROLA_MONTO = cTemp_Valor
   
End Function


Public Function FUNC_LLENA_MONEDA_PRODUCTO(comboMoneda As Object, Tipo_Producto As String) As Boolean
Dim cSql As String
Dim vDatos_Retorno()

On Error GoTo ErrMon

    FUNC_LLENA_MONEDA_PRODUCTO = False
    bExiste = False
    
       GLB_Envia = Array()
       PROC_AGREGA_PARAMETRO GLB_Envia, GLB_Sistema
       PROC_AGREGA_PARAMETRO GLB_Envia, Tipo_Producto
       cSql = "SP_CON_MONEDA_PRODUCTO"
        
    
    If FUNC_EXECUTA_COMANDO_SQL(cSql, GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
            
            comboMoneda.AddItem vDatos_Retorno(2)

            comboMoneda.ItemData(comboMoneda.NewIndex) = vDatos_Retorno(1)
            
        
        Loop
    
    End If
    
    If comboMoneda.ListCount = 0 Then
      MsgBox "No se encuentran definidas la monedas por producto.", vbInformation
    End If
    
    FUNC_LLENA_MONEDA_PRODUCTO = True
    
    Exit Function
    
ErrMon:
    MsgBox "Problemas en consulta de monedas: " & Err.Description & ". Comunique al Administrador. ", vbCritical
    Exit Function
    
End Function



Public Function FUNC_CON_VALOR_MONEDA(ocomboMoneda As Object, ovalor_tasa As Object) As Boolean
Dim cSql As String
Dim vDatos_Retorno()

On Error GoTo ErrMon

    FUNC_CON_VALOR_MONEDA = False
        
    
       GLB_Envia = Array()
       If ocomboMoneda.ListIndex = -1 Then
        PROC_AGREGA_PARAMETRO GLB_Envia, 0
       Else
        PROC_AGREGA_PARAMETRO GLB_Envia, ocomboMoneda.ItemData(ocomboMoneda.ListIndex)
       End If
       PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proceso, "YYYYMMDD")
       cSql = "SP_CON_VALOR_MONEDA"
        
    
    If FUNC_EXECUTA_COMANDO_SQL(cSql, GLB_Envia) Then
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
' ************* Esto hay q verificarlo lizama***********************
'            ovalor_tasa.Text = CDbl(vDatos_Retorno(1))
            FUNC_CON_VALOR_MONEDA = CDbl(vDatos_Retorno(1))
        End If
    
    End If
    
    
    
    Exit Function
    
ErrMon:
    MsgBox "Problemas en consulta de monedas: " & Err.Description & ". Comunique al Administrador. ", vbCritical
    Exit Function
    
End Function


Function FUNC_TIENE_FORMULA(nCodigo As Integer)
Dim cSql As String
Dim vDatos_Retorno()


On Error GoTo ErrMon

    FUNC_TIENE_FORMULA = False
        
    
       GLB_Envia = Array()
       PROC_AGREGA_PARAMETRO GLB_Envia, nCodigo
       cSql = "SP_CON_FORMULA_INTERES_TD"
        
    
    If FUNC_EXECUTA_COMANDO_SQL(cSql, GLB_Envia) Then
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            If vDatos_Retorno(1) = 1 Then
                FUNC_TIENE_FORMULA = True
            End If
        End If
    
    End If
       
    
    Exit Function
    
ErrMon:
    MsgBox "Problemas en consulta de Fórmulas: " & Err.Description & ". Comunique al Administrador. ", vbCritical
    Exit Function



End Function

Public Function FUNC_Format_Fecha(cFecha As String, Optional Fomat_Dia As String, Optional Format_Mes As String, Optional Format_Año As String) As String

   Dim nFecFormat    As String
   Dim nDia          As Integer
   Dim Dia_Semana    As String
   Dim Largo         As Integer
   Dim nMes          As Integer
   Dim Mes_Año       As String
   Dim For_Año       As String

   nDia = Weekday(cFecha)

   Select Case nDia
   Case 1: Dia_Semana = "Domingo"
   Case 2: Dia_Semana = "Lunes"
   Case 3: Dia_Semana = "Martes"
   Case 4: Dia_Semana = "Miércoles"
   Case 5: Dia_Semana = "Jueves"
   Case 6: Dia_Semana = "Viernes"
   Case 7: Dia_Semana = "Sábado"
   End Select

   Largo = IIf(Len(Fomat_Dia) <= 3, 3, 15)

   Dia_Semana = Mid(Dia_Semana, 1, Largo)
   nMes = Month(cFecha)

   Select Case nMes
   Case 1:  Mes_Año = "Enero"
   Case 2:  Mes_Año = "Febrero"
   Case 3:  Mes_Año = "Marzo"
   Case 4:  Mes_Año = "Abril"
   Case 5:  Mes_Año = "Mayo"
   Case 6:  Mes_Año = "Junio"
   Case 7:  Mes_Año = "Julio"
   Case 8:  Mes_Año = "Agosto"
   Case 9:  Mes_Año = "Septiembre"
   Case 10: Mes_Año = "Octubre"
   Case 11: Mes_Año = "Noviembre"
   Case 12: Mes_Año = "Diciembre"
   End Select
   
   Largo = IIf(Len(Format_Mes) <= 3, 3, 15)
   Mes_Año = Mid(Mes_Año, 1, Largo)

   If Len(Format_Año) > 0 Then
      For_Año = right(Year(cFecha), Len(Format_Año))

   Else
      For_Año = Year(cFecha)

   End If

   FUNC_Format_Fecha = Dia_Semana & ", " & Day(cFecha) & " de " & Mes_Año & " del " & For_Año

End Function

Public Function FUNC_VALIDA_FECHA_FERIADO(dFecha As Date, nPlaza As Integer, nSw As Integer) As Boolean

Dim vDatos_Retorno()
    
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(dFecha, "yyyymmdd")
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(nPlaza)
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(nSw)
    
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_FECHAHABIL ", GLB_Envia) Then
        
        MsgBox "No se pudo determinar feriado", vbCritical
        FUNC_VALIDA_FECHA_FERIADO = True
        Exit Function
    
    End If
  
  
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_LEER_TABLA_FERIADO ", GLB_Envia) Then
        
        MsgBox "No se pudo leer tabla Temporal", vbCritical
        FUNC_VALIDA_FECHA_FERIADO = True
        Exit Function
    
    End If
  
    If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
         
         If vDatos_Retorno(1) = "0" Then
             
             FUNC_VALIDA_FECHA_FERIADO = False
         
         Else
             
             FUNC_VALIDA_FECHA_FERIADO = True
         
         End If

    End If
  
End Function


Function FUNC_EXISTEN_DATOS() As Boolean

On Error GoTo ErrDatos
  
   FUNC_EXISTEN_DATOS = False

  If GLB_Sql_Resultado.RecordCount = 0 Then
  
      Exit Function
      
  End If

   FUNC_EXISTEN_DATOS = True

 Exit Function

ErrDatos:
   
   If Err.Number <> 3704 Then
     
     MsgBox "Error al recuperar datos desde Sql :" & Chr(10) & Chr(10) & Err.Description, vbOKOnly + vbExclamation
   
   End If
     
     Exit Function

End Function
Public Sub PROC_POSI_TEXTO(MiTexto As Control, MiGrid As Control)
   On Error Resume Next
   MiTexto.top = MiGrid.CellTop + MiGrid.top + 20
   MiTexto.left = MiGrid.CellLeft + MiGrid.left + 30
   MiTexto.Width = MiGrid.CellWidth - 20
   MiTexto.Height = MiGrid.CellHeight
End Sub
Function FUNC_BUSCAR_COLOR_ESTADO(sUser As String, sEstado As String, ByRef nColor1 As Long, ByRef nColor2 As Long, Optional lReload As Boolean)
Static vEstado()
Static vColor1()
Static vColor2()
Dim vDatos_Retorno()
Dim nContador   As Long

If lReload Then

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, sUser
    PROC_AGREGA_PARAMETRO GLB_Envia, sEstado
    PROC_AGREGA_PARAMETRO GLB_Envia, 1
    
    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_TRAER_COLOR_ESTADO", GLB_Envia) Then
        
        Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
            ReDim Preserve vEstado(nContador + 1)
            ReDim Preserve vColor1(nContador + 1)
            ReDim Preserve vColor2(nContador + 1)
            vEstado(UBound(vEstado) - 1) = vDatos_Retorno(1)
            vColor1(UBound(vEstado) - 1) = vDatos_Retorno(2)
            vColor2(UBound(vEstado) - 1) = vDatos_Retorno(3)
            nContador = nContador + 1
        Loop
        
    End If
    
Else
    
    For nContador = 0 To UBound(vEstado) - 1
        If sEstado = vEstado(nContador) Then
            nColor1 = vColor1(nContador)
            nColor2 = vColor2(nContador)
            Exit Function
        End If
    Next
    
End If

End Function
'*****************JUANLIZAMA***********************************
 Public Function Chequeo_Estado(sSistema As String, sCodigo As String, bMensaje As Boolean, Optional ByRef sMensaje As String) As Boolean

''   Set mvarColEstado = New CLS_COL_ESTADOS
''
''   mvarColEstado.Sistema = sSistema
''
'    Call SqlConeccion(GLB_Sql_Conexion, GLB_Sql_Resultado)
''
''   Call Cargar_Datos
''
''   mvarColEstado.FinMesEspecial = FinMesEspecial
''
     Chequeo_Estado = Check_Status(sCodigo, bMensaje)

''   mvarEstado =  mvarColEstado.Estado
''   mvarError  =  mvarColEstado.Error
''   mvarMensaje = mvarColEstado.Mensaje
''   mvarRetorno = mvarColEstado.Retorno

 End Function
'**************************************************************
'******************JuanLizama**********************************
Public Function Grabar_Estado(sSistema As String, sCodigo As String, sEstado As String, bMensaje As Boolean) As Boolean
 
   'Set mvarColEstado = New CLS_COL_ESTADOS

   'mvarColEstado.Sistema = sSistema

   'Call SqlConeccion(GLB_Sql_Conexion, GLB_Sql_Resultado)
   
   'Call Cargar_Datos

    Grabar_Estado = Grabar_Status(sCodigo, sEstado, bMensaje)

   'mvarEstado = mvarColEstado.Estado
   'mvarError = mvarColEstado.Error
   'mvarMensaje = mvarColEstado.Mensaje
   'mvarRetorno = mvarColEstado.Retorno

End Function
'**************************************************************
''*******************JuanLizama*********************************
'Public Sub SqlConeccion(sSqlCon As Object, sSqlResul As Object)
'
'   Set GLB_Sql_Conexion = sSqlCon
'   Set GLB_Sql_Resultado = sSqlResul
'
'End Sub
''**************************************************************
'***************************JuanLizama*************************
'Public Function Cargar_Datos()
'
'   Dim Datos()
'
'   'Call Limpiar
'
'    GLB_Envia = Array("PSV")
'    ', IIf(FinMesEspecial, "1", "0"))
'
'    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
'      Do While FUNC_LEE_RETORNO_SQL(Datos())
'         'mvarNombre = Datos(4)
'         'Call Agregar(Datos(6), Datos(8), Datos(5), Datos(7), Datos(10))
'
'       Loop
'
'    End If
'
'   'Call Analizar_Datos
'
'End Function
'**************************************************************
'**********************JuanLizama******************************
Public Function Grabar_Status(sCodigo As String, sEstado As String, bMensaje As Boolean) As Boolean

   Dim Datos()
   Dim sMensaje         As String

   Grabar_Status = False

   'If Check_Status(sCodigo, bMensaje) = "-1" Then
   '   Exit Function

   'End If

    GLB_Envia = Array(GLB_Sistema, sCodigo, sEstado)

    If FUNC_EXECUTA_COMANDO_SQL("SP_GRA_ESTADO_SWITCH", GLB_Envia) Then
      Do While FUNC_LEE_RETORNO_SQL(Datos())
         If Datos(1) <> "OK" Then
     '       sMensaje = PROC_ERRORES("Grabar Estado", sCodigo, bMensaje)
            MsgBox "Error al grabar estado", vbCritical
         Else
            Grabar_Status = True

         End If

      Loop

    End If

   If Grabar_Status Then
     ' Call Evento(True, 0, "", "GRABAR SWITCH OPERATIVO")
     ' FUNC_GENERA_MENSAJE mvarSistema, sCodigo
   Else
   '   Call Evento(False, 0, sMensaje, "GRABAR SWITCH OPERATIVO")

   End If

End Function
'**************************************************************

Public Function Carga_Parametros() As Boolean

   Dim Datos()
   Dim cSql       As String

   Carga_Parametros = True


    If FUNC_EXECUTA_COMANDO_SQL("sp_parametros_sistema") Then
        
        If FUNC_LEE_RETORNO_SQL(Datos()) Then
      
            GLB_Fecha_Anterior = Datos(16)
            GLB_Fecha_Proceso = Datos(1)
            GLB_Cliente_Bac = Datos(2)
            GLB_Fecha_Proxima = Datos(3)
            GLB_Rut_Cliente = Datos(4)
            GLB_Dig_Cliente = Datos(5)
            GLB_Rut_Comision = Datos(6)
            GLB_Precio_Comision = Datos(7)
            GLB_IVA = Datos(8)
            GLB_UF = Datos(12)
            GLB_DO = Datos(13)
            
            'GLB_Fecha_FinMes = .FechaCierreMesNuevo
            GLB_Rut_Cartera = Datos(9)
            GLB_Dv_Cartera = Datos(10)
            GLB_Nombre_Cartera = Datos(11)
            
            GLB_Inicio_Dia = Datos(18)
            GLB_Fin_Dia = Datos(19)
            GLB_Devengamiento = Datos(20)
            GLB_Contabilidad = Datos(21)

            
            mvarFechaCierreMesNuevo = DateAdd("M", 1, GLB_Fecha_Proceso)
'            mvarFechaCierreMesNuevo = DateAdd("D", DatePart("D", GLB_Fecha_Proceso) * -1, mvarFechaCierreMesNuevo)
            mvarFechaCierreMesNuevo = DateAdd("d", -1, DateValue("01-" & CStr(DatePart("m", DateAdd("m", 1, GLB_Fecha_Proceso))) & "-" & CStr(DatePart("yyyy", DateAdd("m", 1, GLB_Fecha_Proceso)))))

           
            GLB_Fecha_FinMes = mvarFechaCierreMesNuevo
'             GLB_Fecha_FinMes = Datos(23)
         
            If GLB_Fecha_Proceso < GLB_Fecha_FinMes And GLB_Fecha_Proxima > GLB_Fecha_FinMes Then
                mvarFinMesEspecial = True

            Else
                mvarFinMesEspecial = False

            End If
            
            
            Carga_Parametros = True




         'mvarFechaProceso =
         'mvarNombreCliente =
         'mvarFechaProximoProceso =
         'mvarRutCliente =
         'mvarDigitoCliente =
         'mvarRutComi =
         'mvarPrComi =
         'mvarIva =
         'mvarUFdia =
         'mvarDolarObservadoDia =
         'mvarRutCartera =
         'mvarDigitoCartera =
         'mvarNombreCartera =
         'mvarFechaAnterior =
         'mvarPuerto_UDP = CSng(Datos(17))

         'mvarDiasPactadoNoBCCH = Datos(14)
         'mvarMontoPatrimonioEfectivo = Datos(15)

         'mvarFechaCierreMesAnterior = DateAdd("D", DatePart("D", mvarFechaProceso) * -1, mvarFechaProceso)
         'mvarFechaCierreMesNuevo = DateAdd("M", 1, mvarFechaProceso)
         'mvarFechaCierreMesNuevo = DateAdd("D", DatePart("D", mvarFechaCierreMesNuevo) * -1, mvarFechaCierreMesNuevo)

         'If mvarFechaProceso < mvarFechaCierreMesNuevo And mvarFechaProximoProceso > mvarFechaCierreMesNuevo Then
         '   mvarFinMesEspecial = True

         'Else
         '   mvarFinMesEspecial = False

         'End If

         'gsBac_InicioDia = Datos(18)   ' Falta este campo

         'gsBac_OperPendiente = Datos(27) ' Falta este campo

         ' Variable que contiene el plazo minimo de pactos para papeles no BCCH

      End If

   Else
      Carga_Parametros = False
      Exit Function

   End If

End Function
'**************************cambiar_esto****************************************
 Public Function Check_Status(sCodigo As String, bMensaje As Boolean) As Boolean
 'As String


'   Dim iContador           As Integer
'   Dim sMensaje            As String
'
'   Check_Status = "-1"
'
   
    Dim Datos()

    lFin = False
    Check_Status = True
   'Call Limpiar

    GLB_Envia = Array("PSV")
    ', IIf(FinMesEspecial, "1", "0"))

    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
      Do While FUNC_LEE_RETORNO_SQL(Datos())
         'mvarNombre = Datos(4)
         'Call Agregar(Datos(6), Datos(8), Datos(5), Datos(7), Datos(10))


   'Call Analizar_Datos
   
'   Call Cargar_Datos
'   Call Analizar_Datos
'
      If Datos(6) = "FIN" And Datos(5) = "1" Then
         lFin = True
         MsgBox "Fin de dìa realizado", vbExclamation
      End If

      If Datos(6) = "DEVENGAMIENTO" And Datos(5) = "1" Then
         lFin = True
         MsgBox "Devengamiento realizado", vbExclamation
      End If
      
      If Datos(6) = "CONTABILIDAD" And Datos(5) = "1" Then
         lFin = True
         MsgBox "Contabilidad realizada", vbExclamation
      End If

'   sMensaje = ""
'   sCodigo = UCase(sCodigo)
'
    If Datos(6) = "FIN" Or Datos(6) = "DEVENGAMIENTO" Or Datos(6) = "CONTABILIDAD" Then
       If Datos(5) = "1" Then
'          Check_Status = "1"
          Check_Status = False
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
'******************************************************************************
'*************************JUANLIZAMA*******************************************
'Public Function Analizar_Datos()
'
'   Dim iContador     As Integer
'
'   lFin = False
'
'   ' For iContador = 1 To objEstado.Count
'      If Datos(6) = "FIN" And Datos(5) = "1" Then
'         lFin = True
'
'      End If
'
'   ' Next iContador
'
'End Function

'*****************************************************************************


Function Grabar_Operacion(ByRef rst_Mensajes As ADODB.Recordset, Recordset_Cabecera As ADODB.Recordset, Optional Recordset_Detalle As ADODB.Recordset, Optional Fecha_Proceso As Date) As Boolean
On Error GoTo ERRGRABAROPERACION
Dim bSinDetalle As Boolean
Dim nEstado As Integer
Dim nNumero_Ope As Single
Dim cProducto As String
Dim nCodigo As Double
Dim nNumero As Double
Dim nnumero_anterior As Double
Dim nCodigo_Instrumento As Double
Dim dFecha_Proceso As Date
Dim nmoneda_operacion As Integer
Dim dfecha_ini As Date
Dim Datos()


 Set rst_Mensajes = FUNC_RETORNA_RECORDSET_ERRORES()
 
 Grabar_Operacion = False
 
' If Not FUNC_INFORMACION_CONEXION(rst_Mensajes) Then
'    GoTo ERRGRABAROPERACION
' End If
'
' If Not CONECTAR(rst_Mensajes) Then
'    GoTo ERRGRABAROPERACION
' End If
 
If Not Recordset_Cabecera.EOF Then
    Recordset_Cabecera.MoveFirst
End If

If Not Recordset_Detalle.EOF Then
    Recordset_Detalle.MoveFirst
End If


nEstado = 0

'SQL_EXECUTE "BEGIN TRANSACTION"

FUNC_EXECUTA_COMANDO_SQL ("BEGIN TRANSACTION")

With Campos_Grabacion
     
     Do While FUNC_LEER_RECORDSET_CABECERA(rst_Mensajes, Recordset_Cabecera)
        If FUNC_HAY_ERROR(rst_Mensajes, BT_Data_Incorrecta) Then
           GoTo ERRGRABAROPERACION
        End If
        
                'CABEZERA
                Envia = Array()
                AddParam Envia, .centidad_cartera
                AddParam Envia, .icodigo_instrumento
                AddParam Envia, .inumero_operacion
                AddParam Envia, .inumero_correlativo
                AddParam Envia, .iNumero_Acuerdo
                AddParam Envia, .cnombre_serie
                AddParam Envia, .dfecha_emision
                AddParam Envia, .dfecha_vencimiento
                AddParam Envia, .dfecha_proximo_cupon
                AddParam Envia, .dfecha_anterior_cupon
                AddParam Envia, .dfecha_colocacion
                AddParam Envia, .irut_emisor
                AddParam Envia, .cgenerico_emisor
                AddParam Envia, .irut_cliente
                AddParam Envia, .ccodigo_cliente
                AddParam Envia, .inumero_cuotas
                AddParam Envia, .iperido_amortizacion
                AddParam Envia, .imoneda_emision
                AddParam Envia, .nnominal
                AddParam Envia, .nnominal_pesos
                AddParam Envia, .ntasa_emision
                AddParam Envia, .ibase_emision
                AddParam Envia, .nvalor_emision_pesos
                AddParam Envia, .nvalor_emision_um
                AddParam Envia, .nvalorvtocuptasemi
                AddParam Envia, .nreajuste_emision
                AddParam Envia, .ninteres_emision
                AddParam Envia, .nvalor_presente_emi
                AddParam Envia, .nvalor_proxpre_emi
                AddParam Envia, .nvalor_par_emi
                AddParam Envia, .ntasa_colocacion
                AddParam Envia, .ibase_colocacion
                AddParam Envia, .nvalor_colocacion_pesos
                AddParam Envia, .nvalor_colocacion_um
                AddParam Envia, .nreajuste_colocacion
                AddParam Envia, .ninteres_colocacion
                AddParam Envia, .nvalor_presente_colocacion
                AddParam Envia, .nvalor_proxpre_colocacion
                AddParam Envia, .nvalor_par_colocacion
                AddParam Envia, .iforma_pago
                AddParam Envia, .itipo_tasa
                AddParam Envia, .ntasa_spread
                AddParam Envia, .iretiro_documento
                AddParam Envia, .irut_acreedor
                AddParam Envia, .cdigito_acreedor
                AddParam Envia, .cnombre_acreedor
                AddParam Envia, .ccodigo_area
                AddParam Envia, .csucursal
                AddParam Envia, .coperador
                AddParam Envia, .cTerminal
                AddParam Envia, .chora
                AddParam Envia, .ctipo_mercado
                AddParam Envia, .cimpreso
                AddParam Envia, .cpago_hoy_man
                AddParam Envia, .cobservacion
                AddParam Envia, .cnumero_pu
                AddParam Envia, .nkeyid_deskmanager
                AddParam Envia, .ilibro_deskmanager
                AddParam Envia, .inumero_anterior
                AddParam Envia, .cProducto
                AddParam Envia, .iforma_pago_ven
                AddParam Envia, .nDecimales
                AddParam Envia, .nPeriodo_Gracia
                AddParam Envia, .cValorEstimado1
                AddParam Envia, .cValorEstimado2
                AddParam Envia, .cValorEstimado3
                AddParam Envia, .cValorEstimado4
                AddParam Envia, .cValorColocacion
                AddParam Envia, CDbl(.cTasa_Efectiva)
                
                If .cProducto <> "BONOS" And .cProducto <> "LETRA" Then
                    nCodigo = .icodigo_instrumento
                    nNumero = .inumero_operacion
                    nnumero_anterior = .inumero_anterior
                    dFecha_Proceso = Fecha_Proceso
                    nmoneda_operacion = .imoneda_emision
                    dfecha_ini = .dfecha_emision
                Else
                    nCodigo = 0
                    nNumero = 0
                End If
                
                'If Not SQL_EXECUTE("SP_ACT_OPERACION_PASIVO", Envia) Then
                
                If Not FUNC_EXECUTA_COMANDO_SQL("SP_ACT_OPERACION_PASIVO", Envia) Then
                    If .nvalor_presente_colocacion > 99999999999999# Then
                        PROC_GRABA_ERROR rst_Mensajes, BT_falla_transaccion, "Error Monto ha Superado largo permitido", ""
                        GoTo ERRGRABAROPERACION
                    Else
                        PROC_GRABA_ERROR rst_Mensajes, BT_falla_transaccion, "Error inesperado en la grabacion de operaciones", ""
                        GoTo ERRGRABAROPERACION
                    End If
                Else
                   
                    'If SQL_FETCH(Datos()) Then
                    If FUNC_LEE_RETORNO_SQL(Datos()) Then
                       If Datos(1) = -1 Then
                         PROC_GRABA_ERROR rst_Mensajes, BT_falla_transaccion, (Datos(2)), ""
                         GoTo ERRGRABAROPERACION
                       Else
                         PROC_GRABA_ERROR rst_Mensajes, BT_Tran_Exitosa, "Operación Nº " & Format(Datos(1), "#,###0") & " grabada con éxito", FUNC_RETORNA_NUMERO_REFERENCIA(.inumero_operacion, (.inumero_correlativo), .inumero_operacion)
                       End If
                    End If
                End If
                If bSinDetalle Then Exit Do

     Loop
     
 End With
 
 With Campos_Detalle
     
     Do While FUNC_LEER_RECORDSET_DETALLE(rst_Mensajes, Recordset_Detalle)
        If FUNC_HAY_ERROR(rst_Mensajes, BT_Data_Incorrecta) Then
           GoTo ERRGRABAROPERACION
        End If
        
              
                'DETALLE
                Envia = Array()
                AddParam Envia, .centidad_cartera
                AddParam Envia, .icodigo_instrumento
                AddParam Envia, .inumero_operacion
                AddParam Envia, .inumero_correlativo
                AddParam Envia, .dfecha_movimiento
                AddParam Envia, .dfecha_vencimientos
                AddParam Envia, .ncuota_correlativo
                AddParam Envia, .ncuota_capital
                AddParam Envia, .ncuota_interes
                AddParam Envia, .ncuota_flujo
                AddParam Envia, .ncuota_saldo
                AddParam Envia, .ncuota_tasa
                AddParam Envia, .ctipo_cuota
               
                'If Not SQL_EXECUTE("SP_ACT_OPERACION_DETALLE", Envia) Then
                If Not FUNC_EXECUTA_COMANDO_SQL("SP_ACT_OPERACION_DETALLE", Envia) Then
                   PROC_GRABA_ERROR rst_Mensajes, BT_falla_transaccion, "Error inesperado en la grabacion de operaciones", ""
                   GoTo ERRGRABAROPERACION
                Else
                   
                    'If SQL_FETCH(Datos()) Then
                    If FUNC_LEE_RETORNO_SQL(Datos()) Then
                       If Datos(1) = -1 Then
                         PROC_GRABA_ERROR rst_Mensajes, BT_falla_transaccion, (Datos(2)), ""
                         GoTo ERRGRABAROPERACION
                       Else
                         PROC_GRABA_ERROR rst_Mensajes, BT_Tran_Exitosa, "Operación Nº " & Format(Datos(1), "#,###0") & " grabada con éxito", FUNC_RETORNA_NUMERO_REFERENCIA(.inumero_operacion, (.inumero_correlativo), .inumero_operacion)
                       End If
                    End If
                End If
                If bSinDetalle Then Exit Do

     Loop
     
 End With
  
    If nCodigo <> 0 And nnumero_anterior = 0 Then
                
                Envia = Array()
                AddParam Envia, nNumero
                AddParam Envia, nCodigo
                
                
                'If Not SQL_EXECUTE("SP_PRO_REAJUSTE_INTERES", Envia) Then
                If Not FUNC_EXECUTA_COMANDO_SQL("SP_PRO_REAJUSTE_INTERES", Envia) Then
                   PROC_GRABA_ERROR rst_Mensajes, BT_falla_transaccion, "Error inesperado en la grabacion de operaciones", ""
                   GoTo ERRGRABAROPERACION
                Else
                   
                    'If SQL_FETCH(Datos()) Then
                    If FUNC_LEE_RETORNO_SQL(Datos()) Then
                       If Datos(1) = -1 Then
                         PROC_GRABA_ERROR rst_Mensajes, BT_falla_transaccion, (Datos(2)), ""
                         GoTo ERRGRABAROPERACION
                       Else
                         PROC_GRABA_ERROR rst_Mensajes, BT_Tran_Exitosa, "Operación Nº " & Format(Datos(1), "#,###0") & " grabada con éxito", FUNC_RETORNA_NUMERO_REFERENCIA(nNumero, (nNumero), nNumero)
                       End If
                    End If
                End If
    End If
                
    If nnumero_anterior <> 0 Then
                If nnumero_anterior <> nNumero Then
                    nNumero = nnumero_anterior
                End If
    
                Envia = Array()
                AddParam Envia, nNumero
                AddParam Envia, nCodigo
                AddParam Envia, Format(Fecha_Proceso, "YYYYMMDD")
                AddParam Envia, nmoneda_operacion
                AddParam Envia, Format(dfecha_ini, "YYYYMMDD")
                
                'If Not SQL_EXECUTE("SP_PRO_RESULTADO_PREPAGO", Envia) Then
                If Not FUNC_EXECUTA_COMANDO_SQL("SP_PRO_RESULTADO_PREPAGO", Envia) Then
                   PROC_GRABA_ERROR rst_Mensajes, BT_falla_transaccion, "Error inesperado en la grabacion de operaciones", ""
                   GoTo ERRGRABAROPERACION
                Else
                    'If SQL_FETCH(Datos()) Then
                    If FUNC_LEE_RETORNO_SQL(Datos()) Then
                       If Datos(1) = -1 Then
                         PROC_GRABA_ERROR rst_Mensajes, BT_falla_transaccion, (Datos(2)), ""
                         GoTo ERRGRABAROPERACION
                       Else
                         PROC_GRABA_ERROR rst_Mensajes, BT_Tran_Exitosa, "Operación Nº " & Format(Datos(1), "#,###0") & " grabada con éxito", FUNC_RETORNA_NUMERO_REFERENCIA(nNumero, (nNumero), nNumero)
                       End If
                    End If
                End If
    End If
    
   
 If Not FUNC_HAY_ERROR(rst_Mensajes, BT_Tran_Exitosa) Then
    GoTo ERRGRABAROPERACION
 End If
 
 'SQL_EXECUTE "COMMIT TRANSACTION"
 
FUNC_EXECUTA_COMANDO_SQL ("COMMIT TRANSACTION")
 
 Grabar_Operacion = True
 
Exit Function

ERRGRABAROPERACION:

'SQL_EXECUTE "ROLLBACK TRANSACTION"
FUNC_EXECUTA_COMANDO_SQL ("ROLLBACK TRANSACTION")
 
End Function


Private Function FUNC_LEER_RECORDSET_DETALLE(ByRef rst_Mensajes As ADODB.Recordset, Recordset_Detalle As ADODB.Recordset) As Boolean
On Error GoTo errvalidar

FUNC_LEER_RECORDSET_DETALLE = False

    If Recordset_Detalle.RecordCount = 0 Then
       PROC_GRABA_ERROR rst_Mensajes, BT_Data_Incorrecta, "No existen registros para grabar", ""
       GoTo errvalidar
    End If

'    If Recordset_Detalle.EOF Then
'       Exit Function
'    End If
    
        
   With Campos_Detalle
       
     
    If Not Recordset_Detalle!inumero_operacion = 0 Then
         .inumero_operacion = Recordset_Detalle!inumero_operacion
    End If
       
    .centidad_cartera = Recordset_Detalle!centidad_cartera
    .icodigo_instrumento = Recordset_Detalle!icodigo_instrumento
    .inumero_operacion = Recordset_Detalle!inumero_operacion
    .inumero_correlativo = Recordset_Detalle!inumero_correlativo
    .dfecha_movimiento = Recordset_Detalle!dfecha_movimiento
    .dfecha_vencimientos = Recordset_Detalle!dfecha_vencimientos
    .ncuota_correlativo = Recordset_Detalle!ncuota_correlativo
    .ncuota_capital = Recordset_Detalle!ncuota_capital
    .ncuota_interes = Recordset_Detalle!ncuota_interes
    .ncuota_flujo = Recordset_Detalle!ncuota_flujo
    .ncuota_saldo = Recordset_Detalle!ncuota_saldo
    .ncuota_tasa = Recordset_Detalle!ncuota_tasa
    .ctipo_cuota = Recordset_Detalle!ctipo_cuota
    
   End With

Recordset_Detalle.MoveNext

FUNC_LEER_RECORDSET_DETALLE = True
Exit Function

errvalidar:
    PROC_GRABA_ERROR rst_Mensajes, BT_Data_Incorrecta, "La recuperación de registros no se pudo completar por lo siguiente:" & Err.Description, ""
    Exit Function
End Function

Function FUNC_HAY_ERROR(ByRef rst_Mensajes As ADODB.Recordset, iCodigo_Error As Tipo_Error) As Boolean
On Error GoTo errhayerror
FUNC_HAY_ERROR = False
With rst_Mensajes
    If Not .EOF Then
      .MoveFirst
    End If
    
    .Find "iCodigo_error=" & iCodigo_Error, , adSearchForward
    
    If .EOF Then
      Exit Function
    End If
End With

FUNC_HAY_ERROR = True

errhayerror:

End Function

Private Function FUNC_LEER_RECORDSET_CABECERA(ByRef rst_Mensajes As ADODB.Recordset, Recordset_Cabecera As ADODB.Recordset) As Boolean
On Error GoTo errvalidar

FUNC_LEER_RECORDSET_CABECERA = False
    
    If Recordset_Cabecera.RecordCount = 0 Then
       PROC_GRABA_ERROR rst_Mensajes, BT_Data_Incorrecta, "No existen registros para grabar", ""
       GoTo errvalidar
    End If

    If Recordset_Cabecera.EOF Then
       Exit Function
    End If
    
        
   With Campos_Grabacion
       
     
    If Not Recordset_Cabecera!inumero_operacion = 0 Then
         .inumero_operacion = Recordset_Cabecera!inumero_operacion
    End If
       
    .centidad_cartera = Recordset_Cabecera!centidad_cartera
    .icodigo_instrumento = Recordset_Cabecera!icodigo_instrumento
    .inumero_operacion = Recordset_Cabecera!inumero_operacion
    .inumero_correlativo = Recordset_Cabecera!inumero_correlativo
    .iNumero_Acuerdo = Recordset_Cabecera!iNumero_Acuerdo
    .cnombre_serie = Recordset_Cabecera!cnombre_serie
    .dfecha_emision = Recordset_Cabecera!dfecha_emision
    .dfecha_vencimiento = Recordset_Cabecera!dfecha_vencimiento
    .dfecha_proximo_cupon = Recordset_Cabecera!dfecha_proximo_cupon
    .dfecha_anterior_cupon = Recordset_Cabecera!dfecha_anterior_cupon
    .dfecha_colocacion = Recordset_Cabecera!dfecha_colocacion
    .irut_emisor = Recordset_Cabecera!irut_emisor
    .cgenerico_emisor = Recordset_Cabecera!cgenerico_emisor
    .irut_cliente = Val(Recordset_Cabecera!irut_cliente)
    
    .ccodigo_cliente = Recordset_Cabecera!ccodigo_cliente
    .inumero_cuotas = Recordset_Cabecera!inumero_cuotas
    .iperido_amortizacion = Recordset_Cabecera!iperido_amortizacion
    .imoneda_emision = Recordset_Cabecera!imoneda_emision
    .nnominal = Recordset_Cabecera!nnominal
    .nnominal_pesos = Recordset_Cabecera!nnominal_pesos
    .ntasa_emision = Recordset_Cabecera!ntasa_emision
    .ibase_emision = Recordset_Cabecera!ibase_emision
    .nvalor_emision_pesos = Recordset_Cabecera!nvalor_emision_pesos
    .nvalor_emision_um = Recordset_Cabecera!nvalor_emision_um
    .nvalorvtocuptasemi = Recordset_Cabecera!nvalorvtocuptasemi
    .nreajuste_emision = Recordset_Cabecera!nreajuste_emision
    .ninteres_emision = Recordset_Cabecera!ninteres_emision
    .nvalor_presente_emi = Recordset_Cabecera!nvalor_presente_emi
    .nvalor_proxpre_emi = Recordset_Cabecera!nvalor_proxpre_emi
    .nvalor_par_emi = Recordset_Cabecera!nvalor_par_emi
    .ntasa_colocacion = Recordset_Cabecera!ntasa_colocacion
    .ibase_colocacion = Recordset_Cabecera!ibase_colocacion
    .nvalor_colocacion_pesos = Recordset_Cabecera!nvalor_colocacion_pesos
    .nvalor_colocacion_um = Recordset_Cabecera!nvalor_colocacion_um
    .nreajuste_colocacion = Recordset_Cabecera!nreajuste_colocacion
    .ninteres_colocacion = Recordset_Cabecera!ninteres_colocacion
    .nvalor_presente_colocacion = Recordset_Cabecera!nvalor_presente_colocacion
    .nvalor_proxpre_colocacion = Recordset_Cabecera!nvalor_proxpre_colocacion
    .nvalor_par_colocacion = Recordset_Cabecera!nvalor_par_colocacion
    .iforma_pago = Recordset_Cabecera!iforma_pago
    .ctipo_operacion = Recordset_Cabecera!ctipo_operacion
    .itipo_tasa = Recordset_Cabecera!itipo_tasa
    .ntasa_spread = Recordset_Cabecera!ntasa_spread
    .iretiro_documento = Recordset_Cabecera!iretiro_documento
    .irut_acreedor = Recordset_Cabecera!irut_acreedor
    .ccodigo_area = Recordset_Cabecera!ccodigo_area
    .csucursal = Recordset_Cabecera!csucursal
    .coperador = Recordset_Cabecera!coperador
    .cTerminal = Recordset_Cabecera!cTerminal
    .chora = Recordset_Cabecera!chora
    .ctipo_mercado = Recordset_Cabecera!ctipo_mercado
    .cimpreso = Recordset_Cabecera!cimpreso
    .cpago_hoy_man = Recordset_Cabecera!cpago_hoy_man
    .cobservacion = Recordset_Cabecera!cobservacion
    .cdigito_acreedor = Recordset_Cabecera!cdigito_acreedor
    .cnombre_acreedor = Recordset_Cabecera!cnombre_acreedor
    .cnumero_pu = Recordset_Cabecera!cnumero_pu
    .nkeyid_deskmanager = Recordset_Cabecera!nkeyid_deskmanager
    .ilibro_deskmanager = Recordset_Cabecera!ilibro_deskmanager
    .inumero_anterior = Recordset_Cabecera!inumero_anterior
    .cProducto = Recordset_Cabecera!cProducto
    .cPantalla = Recordset_Cabecera!cPantalla
    .iforma_pago_ven = Recordset_Cabecera!iforma_pago_ven
    .nDecimales = Recordset_Cabecera!nDecimales
    .nPeriodo_Gracia = Recordset_Cabecera!nPeriodo_Gracia
    .cValorEstimado1 = Recordset_Cabecera!cValorEstimado1
    .cValorEstimado2 = Recordset_Cabecera!cValorEstimado2
    .cValorEstimado3 = Recordset_Cabecera!cValorEstimado3
    .cValorEstimado4 = Recordset_Cabecera!cValorEstimado4
    .cValorColocacion = Recordset_Cabecera!cValorColocacion
    .cTasa_Efectiva = Recordset_Cabecera!cTasa_Efectiva
   End With

Recordset_Cabecera.MoveNext

FUNC_LEER_RECORDSET_CABECERA = True
Exit Function

errvalidar:
    PROC_GRABA_ERROR rst_Mensajes, BT_Data_Incorrecta, "La recuperación de registros no se pudo completar por lo siguiente:" & Err.Description, ""
    Exit Function
End Function



Private Function FUNC_RETORNA_NUMERO_REFERENCIA(inumero_operacion As Double, iCorrelativo As Double, iNumero_Acuerdo As Double) As String
FUNC_RETORNA_NUMERO_REFERENCIA = ""

FUNC_RETORNA_NUMERO_REFERENCIA = cId_Sistema + "." + _
                                 Format(inumero_operacion, "0000000000") + "." + _
                                 Format(iCorrelativo, "000") + "." + _
                                 Format(iNumero_Acuerdo, "0000000000")

End Function

Private Sub PROC_GRABA_ERROR(ByRef rstErrores As ADODB.Recordset, iCodigo_Error As Tipo_Error, cDescripcion_Error As String, cNumero_Referencia As String, Optional nNumero_Operacion_BacPasivo As Double)
On Error GoTo errgrabaerror

      With rstErrores
         .AddNew "iCodigo_Error", iCodigo_Error
         .Update "cDescripcion_Error", cDescripcion_Error
         .Update "cNumero_Referencia", cNumero_Referencia
         .Update "nNumero_Operacion_BacPasivo", nNumero_Operacion_BacPasivo
         .Update
      End With

errgrabaerror:

End Sub

Function FUNC_RETORNA_MENSAJE(ByRef rst_Mensajes As ADODB.Recordset) As String
Dim nCodigo_Error_Auxiliar As Integer
 FUNC_RETORNA_MENSAJE = ""
With rst_Mensajes
 
 If .RecordCount > 0 Then
    .MoveFirst
 End If
 
 nCodigo_Error_Auxiliar = -1
 
 Do While Not .EOF
  If nCodigo_Error_Auxiliar <> !iCodigo_Error Then
   FUNC_RETORNA_MENSAJE = FUNC_RETORNA_MENSAJE & Trim(!cDescripcion_Error) & vbCrLf
   nCodigo_Error_Auxiliar = !iCodigo_Error
  End If
   .MoveNext
 Loop
 
 If .RecordCount > 0 Then
    .MoveFirst
 End If
 
End With

End Function

Private Function FUNC_RETORNA_RECORDSET_ERRORES() As ADODB.Recordset
On Error GoTo errRetorna
Set FUNC_RETORNA_RECORDSET_ERRORES = New ADODB.Recordset


   With FUNC_RETORNA_RECORDSET_ERRORES.Fields
      .Append "iCodigo_Error", adInteger
      .Append "cDescripcion_Error", adChar, 255
      .Append "cNumero_Referencia", adChar, 50
      .Append "nNumero_Operacion_BacPasivo", adDouble
   End With

    FUNC_RETORNA_RECORDSET_ERRORES.Open

errRetorna:

End Function

Function FUNC_RETORNA_RECORDSET_CABECERA() As ADODB.Recordset
On Error GoTo Error_Recordset

Set FUNC_RETORNA_RECORDSET_CABECERA = New ADODB.Recordset
 
   With FUNC_RETORNA_RECORDSET_CABECERA.Fields
        .Append "centidad_cartera", adChar, 1
        .Append "icodigo_instrumento", adInteger
        .Append "inumero_operacion", adDouble
        .Append "inumero_correlativo", adDouble
        .Append "inumero_acuerdo", adDouble
        .Append "cnombre_serie", adChar, 15
        .Append "dfecha_emision", adDate
        .Append "dfecha_vencimiento", adDate
        .Append "dfecha_proximo_cupon", adDate
        .Append "dfecha_anterior_cupon", adDate
        .Append "dfecha_colocacion", adDate
        .Append "irut_emisor", adInteger
        .Append "cgenerico_emisor", adChar, 5
        .Append "irut_cliente", adDouble
        .Append "ccodigo_cliente", adInteger
        .Append "inumero_cuotas", adInteger
        .Append "iperido_amortizacion", adInteger
        .Append "imoneda_emision", adInteger
        .Append "nnominal", adDouble
        .Append "nnominal_pesos", adDouble
        .Append "ntasa_emision", adDouble
        .Append "ibase_emision", adDouble
        .Append "nvalor_emision_pesos", adDouble
        .Append "nvalor_emision_um", adDouble
        .Append "nvalorvtocuptasemi", adDouble
        .Append "nreajuste_emision", adDouble
        .Append "ninteres_emision", adDouble
        .Append "nvalor_presente_emi", adDouble
        .Append "nvalor_proxpre_emi", adDouble
        .Append "nvalor_par_emi", adDouble
        .Append "ntasa_colocacion", adDouble
        .Append "ibase_colocacion", adDouble
        .Append "nvalor_colocacion_pesos", adDouble
        .Append "nvalor_colocacion_um", adDouble
        .Append "nreajuste_colocacion", adDouble
        .Append "ninteres_colocacion", adDouble
        .Append "nvalor_presente_colocacion", adDouble
        .Append "nvalor_proxpre_colocacion", adDouble
        .Append "nvalor_par_colocacion", adDouble
        .Append "iforma_pago", adDouble
        .Append "ctipo_operacion", adChar, 3
        .Append "itipo_tasa", adInteger
        .Append "ntasa_spread", adDouble
        .Append "iretiro_documento", adInteger
        .Append "irut_acreedor", adDouble
        .Append "ccodigo_area", adVarChar, 5
        .Append "csucursal", adVarChar, 5
        .Append "coperador", adChar, 15
        .Append "cterminal", adChar, 10
        .Append "chora", adChar, 10
        .Append "ctipo_mercado", adChar, 1
        .Append "cimpreso", adChar, 1
        .Append "cpago_hoy_man", adChar, 1
        .Append "cobservacion", adChar, 70
        .Append "cdigito_acreedor", adChar, 1
        .Append "cnombre_acreedor", adChar, 35
        .Append "cnumero_pu", adChar, 20
        .Append "nkeyid_deskmanager", adDouble
        .Append "ilibro_deskmanager", adInteger
        .Append "inumero_anterior", adDouble
        .Append "cproducto", adChar, 5
        .Append "cPantalla", adChar, 20
        .Append "iforma_pago_ven", adDouble
        .Append "nDecimales", adInteger
        .Append "nPeriodo_Gracia", adInteger
        .Append "cValorEstimado1", adDouble
        .Append "cValorEstimado2", adDouble
        .Append "cValorEstimado3", adDouble
        .Append "cValorEstimado4", adDouble
        .Append "cValorColocacion", adDouble
        .Append "cTasa_Efectiva", adDouble
   End With
   
   FUNC_RETORNA_RECORDSET_CABECERA.Open
   
Error_Recordset:
     
End Function


Function FUNC_RETORNA_RECORDSET_DETALLE() As ADODB.Recordset
On Error GoTo Error_Recordset

Set FUNC_RETORNA_RECORDSET_DETALLE = New ADODB.Recordset
 
   With FUNC_RETORNA_RECORDSET_DETALLE.Fields
        .Append "centidad_cartera", adChar, 1
        .Append "icodigo_instrumento", adInteger
        .Append "inumero_operacion", adDouble
        .Append "inumero_correlativo", adDouble
        .Append "dfecha_movimiento", adDate
        .Append "dfecha_vencimientos", adDate
        .Append "ncuota_correlativo", adDouble
        .Append "ncuota_capital", adDouble
        .Append "ncuota_interes", adDouble
        .Append "ncuota_flujo", adDouble
        .Append "ncuota_saldo", adDouble
        .Append "ncuota_tasa", adDouble
        .Append "ctipo_cuota", adChar, 1
   End With
   
   FUNC_RETORNA_RECORDSET_DETALLE.Open
   
Error_Recordset:
     
End Function


Public Function valida_mesa() As Boolean
Dim Datos()
 
   GLB_Envia = Array("PSV")
   
    valida_mesa = False
     
     If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
    
            If Datos(5) = 0 And Datos(6) = "MESA" Then

                 MsgBox "¡Debe Bloquear la Mesa Antes de Reprocesar!", vbExclamation
                 
                 
                 
               Exit Function
    
           End If

              
        Loop
        
 valida_mesa = True
 
 End If
 
End Function
