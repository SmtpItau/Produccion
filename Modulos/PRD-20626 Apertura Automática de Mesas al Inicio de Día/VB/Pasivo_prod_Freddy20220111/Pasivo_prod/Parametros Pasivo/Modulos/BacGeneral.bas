Attribute VB_Name = "BacGeneral"

Option Explicit
Public Declare Function GetDeviceCaps Lib "gdi32" (ByVal hDC As Long, ByVal nIndex As Long) As Long
Global sFile$

'=========================================================================================================================
'============ RESCATA EL NOMBRE DEL USUARIO Y EL NOMBRE DEL TERMINAL =====================================================
Declare Function GetUserName Lib "advapi32.dll" Alias "GetUserNameA" (ByVal lpBuffer As String, nSize As Long) As Long
Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, nSize As Long) As Long

'Global Class_Reporte As New clsCristalReport


Global ComputerName As String '® Nombre Terminal
Global Usuario As String      '® Nombre Usuario
'============ ® ENRIQUE NAVARRO PATIÑO =====================================================================================
'=========================================================================================================================
Global Opt As String

Global Const TITSISTEMA = "BAC-PARAMETROS"
Global Const feFecha = "yyyymmdd"
'Formato con 4 decimales, para la configuración regional
Global Const FDecimal = "#,##0.0000"
Global Const FEntero = "#,##0"
Global Const fechaymd = "yyyymmdd"

Dim MiExcel As Object
Dim BoExcel As Object
Dim ShExcel As Object


'''''''''''''''''''''' TECLAS



Global Const vbKeySalir = vbKeyEscape
Global Const vbKeyGrabar = vbKeyG
Global Const vbKeyBuscar = vbKeyB
Global Const vbKeyLimpiar = vbKeyL
Global Const vbKeyEliminar = vbKeyE
Global Const vbKeyFiltrar = vbKeyF
Global Const vbKeyAyuda = vbKeyF3
Global Const vbKeyProcesar = vbKeyP
Global Const vbKeyImprimir = vbKeyI
Global Const vbKeyAnular = vbKeyA
Global Const vbKeyNuevo = vbKeyL
Global Const vbKeyDetalle = vbKeyD
Global Const vbKeyVistaPrevia = vbKeyV
Global Const vbKeyDesMarca = vbKeyR
Global Const vbkeyAceptar = vbKeyF10
Global Const vbKeyRepartir = vbKeyR
Global Const vbKeyRefrescar = vbKeyF5
Global Const vbKeyCopiar = vbKeyC
Global Const vbKeyCalcular = vbKeyF8

Global Const vbKeyCalzar = 0
Global Const vbKeyModificar = 0
Global Const vbKeyAnticipar = 0
Global Const vbKeyGeneraInterfaz = vbKeyF12
Global Const vbKeyCarga = vbKeyF11
Global Const vbKeyFecha = 0






Global PARAMETRO1             As Variant
Global PARAMETRO2             As Variant
Global PARAMETRO3             As Variant
Global RETORNOAYUDA           As Variant
Global Linea
Global Aux
Global mon                    As Integer
Global mascarita              As String
Global RptList_Path           As String
Global mascaraux              As String
Global auxilio                As Integer
Global OPTI                   As String
Global SALIR                  As String
Global eliminame              As Integer
Global opecod
Global swa                    As Integer
'SQL
Global gsPARAMS_Version       As String
Global SwConeccion            As String
'para que funcione el mdcl
Global idtipo                 As Integer
Global gsrut                  As String
Global gsdirecc               As String
Global gsgeneric              As String
Global gsciudad               As String
Global gsPais                 As String
Global gscomuna               As String
Global gsregion               As String
Global gstipocliente          As String
Global gsEntidad              As String
Global gscalidadjuridica      As String
Global gsGrupo                As String
Global gsMercado              As String
Global gsapoderado            As String
Global gsctacte               As String
Global clie                   As String
Global gsfono                 As String
Global gs1Nombre              As String
Global gs2Nombre              As String
Global gs1Apellido            As String
Global gs2Apellido            As String
Global gsCtausd               As String
Global gsImplic               As String
Global gsAba                  As String
Global gsChips                As String
Global gsSwift                As String
Global gsGlosa                As String
Global gsCodigo               As String
Global gsDigito               As String
'VARIABLES DE ADMINISTRACION
Global gsUsuario              As String
Global gsSistema              As String
Global gsTerminal             As String
Global gsNombreUs             As String
Global gsUsuarioReal          As String
'Variables usadas en la pantalla de Ayuda
Global gsDescripcion          As String
Global gsFax                  As String
Global gsSerie                As String
Global gsNemo                 As String
Global gsRedondeo             As String
Global gsValor                As String
Global gsNombre               As String
Global gsCodCli1              As Integer
Global gsCodCli               As Double
Global GRABASINACOFI          As Integer
'********************************
Global gsBac_Version          As String
Global gsBac_PtoDec           As String

'****************JUANLIZAMA****************
Global gsBac_RutaIni  As String
'******************************************



Global Muestra$
Global gsGenerico             As String
Global gsBac_Tcamara          As Integer
Global BacFrmIRF              As Form

Global gsCodigoCircular       As String
Global gsDenominacion         As String


Global MiTag As String     'VARIABLE TAG PARA LA AYUDA
'==========================================================================
'==================== GRABACION DE LOG AUDITORIA ==========================
'==========================================================================

'*****************************JuanLizama***********************************
Global sFileInicio   As String




Function FUNC_BUSCAR_COLOR_ESTADO(sUser As String, sEstado As String, ByRef nColor1 As Long, ByRef nColor2 As Long)

Envia = Array()
AddParam Envia, sUser
AddParam Envia, sEstado

If BAC_SQL_EXECUTE("SP_CON_TRAER_COLOR_ESTADO", Envia) Then
    
    Do While BAC_SQL_FETCH(Datos())
        nColor1 = Datos(1)
        nColor2 = Datos(2)
    Loop
    
End If

End Function
Function func_carga_TD(objDialogo As Object, objGrilla As Object)
   Dim txt_FileIni, txt_PathIni As String
   
   
      objDialogo.Filter = "*.xls"
      objDialogo.Action = 1
    
    If objDialogo.FileName = "" Then
        txt_FileIni = ""
    Else
        txt_FileIni = objDialogo.FileName 'Dir(objDialogo.FileName, vbArchive)
    End If
    
      
On Error GoTo ErrorExcel

   Dim Fila          As Long
   Dim MyExcel       As New Excel.Application
      
    
    
    Set MyExcel = GetObject("", "excel.application")
        MyExcel.Workbooks.Open txt_FileIni
        MyExcel.Sheets(1).Select

        MyExcel.Application.Visible = False
        
        Fila = 2
        
        objGrilla.Rows = 1
       While Fila <> -1
       
            If MyExcel.Application.Cells(Fila, 1) = "" Then
                GoTo SALIR
            End If
             
             'VARIABLES A GUARDAR
             
                 objGrilla.AddItem (MyExcel.Application.Cells(Fila, 1) & vbTab & _
                 Format(MyExcel.Application.Cells(Fila, 2), "DD/MM/YYYY") & vbTab & _
                 Format(MyExcel.Application.Cells(Fila, 3), "##,##0.000000") & vbTab & _
                 Format(MyExcel.Application.Cells(Fila, 4), "##,##0.000000") & vbTab & _
                 Format(MyExcel.Application.Cells(Fila, 5), "##,##0.000000") & vbTab & _
                 Format(MyExcel.Application.Cells(Fila, 6), "##,##0.000000"))
                 
                  ' numero cupon
                  ' fecha vencimiento
                  ' interes
                  ' amortizacion
                  ' flujo
                  ' saldo
           Fila = Fila + 1
       Wend
SALIR:
    
    MyExcel.Application.Quit
    Set MyExcel = Nothing

    MsgBox "¡ Carga de Datos Terminada con Exito !", vbInformation

Exit Function

ErrorExcel:
   err.Description = "Carga de datos"
   MyExcel.Application.Quit
   Set MyExcel = Nothing
      
End Function

Public Sub LogAuditoria(Codigo_Evento As String, Codigo_Menu As String, Detalle_Trans As String, valor_antiguo As String, valor_nuevo As String)
    
    Call Grabar_Log_Auditoria("1" _
                                 , gsbac_fecp _
                                 , ComputerName _
                                 , gsUsuario _
                                 , "PCA" _
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
    End If

End Sub
'=========================================================================================
'============================= FIN GRABACION LOG AUDITORIA ===============================
'=========================================================================================

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

Function Valida_Configuracion_Regional() As Boolean

Valida_Configuracion_Regional = False

If CStr(Format(CDate("31/12/2000"), feFecha)) <> Format("31/12/2000", feFecha) Then
   MsgBox "Debe cambiar el formato de fecha como dd/mm/aaaa antes de ejecutar el sistema.", vbCritical
   Exit Function
End If

Valida_Configuracion_Regional = True

End Function


Public Function funcBaseMoneda(parECodMoneda As Integer) As Integer
Dim cSql As String
Dim Datos()
On Error GoTo ErrMon

    funcBaseMoneda = 0
        
'''''''''''''''''    cSql = "EXECUTE sp_findbasemoneda " & parECodMoneda
       
    Envia = Array()
    
    AddParam Envia, parECodMoneda
       
    If BAC_SQL_EXECUTE("sp_findbasemoneda", Envia) Then
        
        Do While BAC_SQL_FETCH(Datos())
            
            funcBaseMoneda = Datos(1)
        
        Loop
    
    End If
    
    Exit Function
    
ErrMon:
    
    MsgBox "Problemas en busqueda de base de monedas: " & err.Description & ". Comunique al Administrador. ", vbCritical
    
    Exit Function
    
End Function
'insertado 21/12/2000

Public Function bacLeerMonedas(Optional RetornaDatos) As Boolean

    bacLeerMonedas = False
    
    bacLeerMonedas = (BAC_SQL_EXECUTE("sp_General_Lee_Moneda "))
    
    If Not IsMissing(RetornaDatos) Then
        
        Do While BAC_SQL_FETCH(Datos())
            
            bacLeerMonedas = True
            'RetornaDatos = Datos
        
        Loop
    
    End If
    
End Function

'insertado 20/12/2000
Public Function funcFindMonVal(comboMoneda As Object, ComboBase As Object, Tipo_Operacion As String) As Boolean
Dim cSql As String
Dim Datos()
On Error GoTo ErrMon

    funcFindMonVal = False
        
    If Trim(Tipo_Operacion) = "" Then
       
       cSql = "sp_findbase"
    
    End If
    
    If BAC_SQL_EXECUTE(cSql) Then
        
        Do While BAC_SQL_FETCH(Datos())
            
            comboMoneda.AddItem Datos(2)
            comboMoneda.ItemData(comboMoneda.NewIndex) = Datos(1)
        
          ' ComboBase.AddItem datos(3)
          ' ComboBase.ItemData(comboMoneda.NewIndex) = datos(1)
        
        Loop
    
    End If
    
    funcFindMonVal = True
    
    Exit Function
    
ErrMon:
    MsgBox "Problemas en busqueda de base de monedas: " & err.Description & ". Comunique al Administrador. ", vbCritical
    Exit Function
    
End Function

Public Function funcFindMonSerie(comboMoneda As Object, ComboBase As Object, Tipo_Operacion As String) As Boolean
Dim cSql As String
Dim Datos()
On Error GoTo ErrMon

    funcFindMonSerie = False
        
    If Trim(Tipo_Operacion) = "" Then
       
       cSql = "sp_findbaseSerie"
    
    End If
    
    If BAC_SQL_EXECUTE(cSql) Then
        
        Do While BAC_SQL_FETCH(Datos())
            
            comboMoneda.AddItem Datos(2)
            comboMoneda.ItemData(comboMoneda.NewIndex) = Datos(1)
        
          ' ComboBase.AddItem datos(3)
          ' ComboBase.ItemData(comboMoneda.NewIndex) = datos(1)
        
        Loop
    
    End If
    
    funcFindMonSerie = True
    
    Exit Function
    
ErrMon:
    MsgBox "Problemas en busqueda de base de monedas: " & err.Description & ". Comunique al Administrador. ", vbCritical
    Exit Function
    
End Function

'insertado 20/12/2000
Public Function bacMonedaRRDA(Moneda As Variant) As String
Dim Sql$, Datos()
    
    bacMonedaRRDA = "D"
    If VarType(Moneda) = vbString Then
        Moneda = left(Moneda, 3)
    End If
    
    Sql = "SELECT mnrrda"
    Sql = Sql & " FROM moneda "
    Sql = Sql & " WHERE "
    If VarType(Moneda) = vbString Then
        Sql = Sql & "SUBSTRING(mnsimbol,1,3) = '" & Moneda & "'"
    Else
        Sql = Sql & "mncodmon = " & Moneda
    End If
    If Not BAC_SQL_EXECUTE(Sql) Then
        MsgBox "Referencia US$ de  " & Moneda & " no puede ser capturada", vbInformation
    Else
        If BAC_SQL_FETCH(Datos()) Then
            bacMonedaRRDA = IIf(Datos(1) = "M", "M", "D")
        End If
    End If

End Function

Public Function BacControlIni() As Boolean

    BacControlIni = True

   If gsc_Parametros.findia = "0" Then
      MsgBox "Fin de día no ha sido realizado.-", 16
      BacControlIni = False
      Exit Function

   End If

   If gsc_Parametros.iniciodia = "1" Then
      MsgBox "Inicio de día ya fue realizado.-", 16
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
           TipoFormato = "##,##0.00"
    
    End Select

End Function

Public Sub BacSetMinBox(fForm As Form, Optional bMoveForm As Variant)
Dim nStyle As Long

   If IsMissing(bMoveForm) Then
      bMoveForm = False

   End If

   'nStyle = GetWindowLong(fForm.hWnd, GWL_STYLE)
   'nStyle = nStyle Or WS_MINIMIZEBOX
'   hForm.ClipControls = True
   'Call SetWindowLong(fForm.hWnd, GWL_STYLE, nStyle)

   If (bMoveForm = True) Then
      fForm.Move 0, 0

   End If

   fForm.Refresh

End Sub

Sub PROC_POSICIONA_TEXTO(grilla As Control, texto As Control)
On Error Resume Next

    texto.top = grilla.CellTop + grilla.top
    texto.left = grilla.CellLeft + grilla.left
    texto.Height = grilla.CellHeight
    texto.Width = grilla.CellWidth

End Sub

Public Sub AsignaValoresParametros()

    gsbac_fecp = Format(gsc_Parametros.fechaproc, gsc_FechaDMA)
    gsBAC_Clien = gsc_Parametros.Nombre
    gsBAC_Rut = gsc_Parametros.Rut
    gsBAC_ValmonUF = gsc_Parametros.ValorUF
    gsBAC_DolarObs = gsc_Parametros.DolarObs

End Sub


Function bacBuscarCombo(cControl As Object, nValor As Variant) As Integer
Dim iLin    As Integer

    If VarType(nValor) = vbString Then
        nValor = Trim(nValor)
    End If

    bacBuscarCombo = -1

    For iLin = 0 To cControl.ListCount - 1
        If VarType(nValor) = vbString Then
            If left(cControl.List(iLin), Len(nValor)) = nValor Then
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

    Exit Function

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
Dim Separador As String

  For i% = 1 To Len(Tpaso)
    
    If Mid(Tpaso, i%, 1) = "0" Then
        
        Mid(Tpaso, i%, 1) = " "
    Else
        Exit For
    End If
    
  Next i%
  
  Tpaso = Replace(Tpaso, " .", "0.")
  
  Separador = left(Format(0, ".0"), 1)
  
  Tpaso = Replace(Tpaso, ".", Separador)
  
  
  If Trim(Tpaso) = "" Or Trim(Tpaso) = "." Then
    FUNC_FMT_DOUBLE = 0#
  Else
    FUNC_FMT_DOUBLE = CDbl(Tpaso)
  End If
End Function

'Public Function DiaSemana(dFecha As String, oControl As Object) As String
'
'   Dim iDia       As Integer
'   Dim Sql        As String
'
'   DiaSemana = ""
'   iDia = Weekday(Format(dFecha, gsc_FechaDMA))
''   MsgBox "El simbolo utilizado en el separador de miles" & vbCrLf & "y del punto decimal son iguales.", vbOKOnly + vbCritical, "Fatal ERROR"
'
'   oControl.ForeColor = &H8000&
'   oControl.Tag = "OK"
'
'   Select Case iDia
'   Case 0: DiaSemana = "Error"
'      oControl.ForeColor = vbBlue
'      oControl.Tag = "ER"
'
'   Case 1: DiaSemana = "Domingo"
'      oControl.ForeColor = vbRed
'      oControl.Tag = "FE"
'
'   Case 2: DiaSemana = "Lunes"
'   Case 3: DiaSemana = "Martes"
'   Case 4: DiaSemana = "Miercoles"
'   Case 5: DiaSemana = "Jueves"
'   Case 6: DiaSemana = "Viernes"
'   Case 7: DiaSemana = "Sabado"
'      oControl.ForeColor = vbRed
'      oControl.Tag = "FE"
'
'   End Select
'
''   If Not BacEsHabil(dFecha, "") Then  douglas lefin
''      oControl.ForeColor = vbRed
''      oControl.Tag = "FE"'
'
''   End If
'
'   oControl.Caption = DiaSemana
'
'End Function

'*******************************JuanLizama*****************************************
Public Function BacInit() As Boolean
   Dim MyWorkspace As Workspace
   Dim Attribs As String
   Dim sSeparadorFecha$
   Dim directorio As String
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
      
   
'   'NET y Datos Grales.
'
'   gsBAC_Term = FUNC_LEER_REGISTRO("SISTEMAS BAC", "NET", "COMPUTER_NAME")
'   gsBAC_Pass$ = ""
   
   gsBac_RutaIni = UCase(Func_Read_INI("NET", "Path", sFileInicio))
   gsBAC_User = Func_Read_INI("ACCESO", "USERNAME", sFileInicio)
    
   sFile$ = gsBac_RutaIni & "Bac-Sistemas.ini"
   
   If Dir(sFile$) = "" Then
        MsgBox "Archivo de Configuraciones No Existe", 16, TITSISTEMA
        Exit Function
   End If
   
   'NET y Datos Grales.
   
   gsBAC_Term = Environ("ComputerName")
   gsBAC_Pass$ = ""
   
   If gsBAC_Term = "" Then
      MsgBox "Terminal no especificado" + Chr(13) + "en archivo de configuraciones", 16, TITSISTEMA
      Exit Function
   End If
          
   Call NameUserTerm

'   gsBAC_User = IIf(Trim(FUNC_LEER_REGISTRO("SISTEMAS BAC", "NET", "USER_NAME")) = "", gsBAC_User, FUNC_LEER_REGISTRO("SISTEMAS BAC", "NET", "USER_NAME"))

   
   'SQL
   gsSQL_Database = Func_Read_INI("SQL", "DB_PARAMETROS_PASIVOS", sFile$)
   gsSQL_Server = Func_Read_INI("SQL", "Server_Name", sFile$)
   gsSQL_Login = Func_Read_INI("SQL", "Login_Name", sFile$)
   gsSQL_Password = Func_Read_INI("SQL", "Password", sFile$)
   gsSQL_Password = Encript(Func_Read_INI("SQL", "Password1", sFile$), False)
   giSQL_LoginTimeOut = Val(Func_Read_INI("SQL", "Login_TimeOut", sFile$))
   giSQL_QueryTimeOut = Val(Func_Read_INI("SQL", "Query_TimeOut", sFile$))
   giSQL_ConnectionMode = Val(Func_Read_INI("SQL", "Connection_Mode", sFile$))
   gsODBC = Func_Read_INI("SQL", "ODBC_Parametros", sFile$)
      
   If gsSQL_Database = "" Or gsSQL_Server = "" Then
      MsgBox "Servidor No esta definido para conectarse con Base de Datos", vbCritical
      Exit Function
      
   ElseIf gsSQL_Login = "" Then
      MsgBox "Usuario No esta definido para conectarse con Base de Datos", vbCritical, TITSISTEMA
   Exit Function
      
      
   ElseIf giSQL_LoginTimeOut <= 0 Or giSQL_QueryTimeOut <= 0 Then
      MsgBox "Tiempos de Respuesta No son los apropiados para conectarse con Base de Datos", vbCritical
      Exit Function
      
   ElseIf gsODBC = "" Then
      MsgBox "Coneccion ODBC No esta definida para conectarse con Base de Datos", vbCritical, TITSISTEMA
      Exit Function
      
   End If
       
'   '---- Coneccion ODBC
'   If gsODBC = "" Then
'      MsgBox "Coneccion ODBC No esta definida para conectarse con Base de Datos", vbCritical
'      Exit Function
'   End If
   
   '---- Define Coneccion
   
   SwConeccion = "DSN=" & gsODBC
   SwConeccion = SwConeccion & ";UID=" & gsSQL_Login
   SwConeccion = SwConeccion & ";PWD=" & gsSQL_Password
   SwConeccion = SwConeccion & ";DSQ=" & gsSQL_Database

    Set MyWorkspace = Workspaces(0)
    Attribs = "Description=" & gsODBC & Chr$(13)
    Attribs = Attribs & "Server=" & gsSQL_Server & Chr$(13)
    Attribs = Attribs & "Trusted_Connection=no" & Chr$(13)
    Attribs = Attribs & "Database=" & gsSQL_Database
    DBEngine.RegisterDatabase gsODBC, "SQL Server", True, Attribs
    MyWorkspace.Close
         
   'RPT
'   gsRPT_Path = FUNC_LEER_REGISTRO("SISTEMAS BAC", "REPORTES", "REPORTES_PARAMETROS")
    gsRPT_Path = Func_Read_INI("REPORTES", "RPT_PARAMETROS", sFile$)
   'Separadores
   sSeparadorFecha$ = Mid$(Date, 2, 2)
   
   If InStr("0123456789 ", left(sSeparadorFecha$, 1)) = 0 Then
      sSeparadorFecha$ = left(sSeparadorFecha$, 1)
   Else
      sSeparadorFecha$ = right(sSeparadorFecha$, 1)
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
      MsgBox "El simbolo utilizado en el separador de miles" & vbCrLf & "y del punto decimal son iguales.", vbCritical
      Exit Function

   End If

   If sSeparadorFecha$ <> "/" And sSeparadorFecha$ <> "-" Then
      MsgBox "El simbolo utilizado en la separación " & vbCrLf & "de la fecha no corresponde.", vbCritical
      Exit Function
   End If
   
   
'    'PARAMS
'   gsPARAMS_Version = FUNC_LEER_REGISTRO("SISTEMAS BAC", "PARAMS", "VERSION")
'   If gsPARAMS_Version = "" Then
'      MsgBox "Versión de Sistema No esta definida en el Registro", vbCritical
'      Exit Function
'   End If
'
'   gsBac_Version = FUNC_LEER_REGISTRO("SISTEMAS BAC", "PARAMS", "VERSION")
'
'   Msj = gsPARAMS_Version

   BacInit = True
   
End Function
'***********************************************************************************

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

'Public Function BuscaListIndex(COMBO As Object, BUSCA As String) As Integer
'
' '-'
' Dim Lin As Integer
'
' BuscaListIndex = 0              ' Nada en el ComboList
'
'  With COMBO
'
'    If .ListCount <> 0 Then       ' = 0 Nada
'
'        For Lin = 0 To .ListCount - 1
'            .ListIndex = Lin
'            If UCase(Trim$(.List(.ListIndex))) = UCase(Trim$(BUSCA)) Then
'                     BuscaListIndex = Lin
'                     Exit Function
'            End If
'        Next Lin
'
'    End If
'
' End With
      
'End Function
Public Function ControlRUT(tex As String, tex1 As String)
   
   Dim Valida As Integer
   Dim idRut As String
   Dim IdDig As String

   idRut = tex
   IdDig = tex1

   Valida = True

   If Trim$(idRut$) = "" Or Trim$(IdDig$) = "" Or (Trim$(idRut$) = "0" And Trim$(IdDig$) = "0") Then
      Valida = False
   
   End If
    
   If BacValidaRut(tex, tex1) = False Then
      Valida = False
   
   End If

   ControlRUT = Valida

End Function

Public Sub DetectarResolucion(MDIFormx As Object, Formx As Object)
   Dim Ancho As Integer, alto As Integer
   Ancho = GetDeviceCaps(Formx.hDC, 8)
   alto = GetDeviceCaps(Formx.hDC, 10)
   If Ancho <> 800 And alto <> 600 Then
      MDIFormx.Picture = Formx.Picture
   End If
   Unload Formx

End Sub




Function Formato_Grilla(grilla As MSFlexGrid)
   Dim X       As Integer
   With grilla
      .ForeColorSel = Azul
      .ForeColor = AzulOsc
      .GridLines = flexGridInset
      .GridLinesFixed = flexGridNone
      .ForeColorFixed = BlancoAlto
      .BackColorFixed = &H808000
      .BackColor = Gris
      .BackColorSel = AzulOsc
      .BackColorBkg = Gris 'PLOMO
      .Font.Bold = True
      .CellFontBold = True
      .ForeColorSel = blanco
      .FocusRect = flexFocusNone
      .WordWrap = False
      .BorderStyle = flexBorderSingle
      .Appearance = flex3D
      .TextStyle = flexTextFlat
      .Font.Name = "Arial"
      .GridColorFixed = RGB(0, 0, 0)
   End With
End Function


Public Function Cargar_Productos(xSistema As String, xCombo As ComboBox) As Boolean
   Dim Datos()
   Dim Hay_Datos As Boolean
   
   Hay_Datos = False
   Cargar_Productos = False
   
   Envia = Array()
   AddParam Envia, xSistema
   
   If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Producto", Envia) Then
      MsgBox "Problemas en la Carga de Productos"
      Exit Function
   End If
      
   Do While BAC_SQL_FETCH(Datos())
      If Datos(1) = 1 Or Datos(1) = 2 Or Datos(1) = 3 Then
         Hay_Datos = True
         xCombo.AddItem Datos(2)
         xCombo.ItemData(xCombo.NewIndex) = Datos(1)
      End If
   Loop
   
   If Hay_Datos = False Then
      MsgBox "No se Encontraron Productos ", vbInformation
      xCombo.Enabled = False
   Else
      xCombo.Enabled = True
      Cargar_Productos = True
   End If

End Function


Function Caracter(KeyAscii As Integer) As Integer

    Caracter = KeyAscii
    
    If InStr(1, "?¿¡ªº{}¨Ç" & Chr(34), Chr(KeyAscii)) <> 0 Then
       Caracter = 0
    End If

End Function


Public Function FUNC_DESTINO_INTERFAZ(bDestino As Boolean, cRuta_Archivo As String, vMatriz_Datos As Variant, cSeparador As String) As Boolean
On Error Resume Next

Dim vDisponible As Long
Dim Msg As Integer
Dim Numero_Fila     As Integer
Dim Numero_Columna  As Integer
Dim Interfaz As String
Dim TotalFila As Integer
Dim cTotalColumna As Integer

vDisponible = FreeFile
FUNC_DESTINO_INTERFAZ = True
TotalFila = UBound(vMatriz_Datos)

If bDestino = "False" Then
        
    If Dir(cRuta_Archivo) <> "" Then
        Msg = MsgBox(cRuta_Archivo + " ya existe" + Chr(13) + "¿ desea reemplazarlo ?", 48 + vbYesNo)
        If Msg = 6 Then
            Kill (cRuta_Archivo)
        Else
            FUNC_DESTINO_INTERFAZ = False
            Exit Function
        End If
    End If

    Open cRuta_Archivo For Output As #vDisponible
    
    For Numero_Fila = 1 To TotalFila
        Interfaz = ""
        cTotalColumna = vMatriz_Datos(Numero_Fila, 0)

        For Numero_Columna = 1 To cTotalColumna
            Interfaz = Interfaz & vMatriz_Datos(Numero_Fila, Numero_Columna)
            If Numero_Columna <> cTotalColumna Then
                 Interfaz = Interfaz & cSeparador
            End If
        Next Numero_Columna
        
        Interfaz = Interfaz
        Print #vDisponible, Interfaz
    Next Numero_Fila
    Close #vDisponible
Else
        
    Set MiExcel = CreateObject("Excel.Application")
    Set BoExcel = MiExcel.Workbooks
    
    BoExcel.Add
    For Numero_Fila = 1 To TotalFila
        Interfaz = " "
        cTotalColumna = vMatriz_Datos(Numero_Fila, 0)
        
        For Numero_Columna = 1 To cTotalColumna
            MiExcel.Cells(Numero_Fila, Numero_Columna).Value = vMatriz_Datos(Numero_Fila, Numero_Columna)
        Next Numero_Columna
        MiExcel.Visible = True
    Next Numero_Fila
End If

End Function
