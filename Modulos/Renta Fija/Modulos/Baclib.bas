Attribute VB_Name = "BacLib"
''============================
''Historial de Modificaciones
''============================
''Dia 07/04/2005
''Por Victor Gonzalez S.   : Cambio normativo de la SBIF restriccion para utilizar Instrumentos distintos del BCCH
''                           por moneda.
''                           1.- Papales distintos del BCCH y en CLP,USD u OBS minimo 30 Días
''                           2.- Papales distintos del BCCH y en UF,IVP u otras minimo 90 Días
''                           Solicitado por Cristian Mascareño.

'----------------------------------------------------------------------------------------------------------------------------
Public Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
'----------------------------------------------------------------------------------------------------------------------------

Public Declare Function GetDeviceCaps Lib "gdi32" (ByVal hdc As Long, ByVal nIndex As Long) As Long

' Option Explicit
' 1  Formas de Pago
' 2  Tipo de Mercado
' 3  Tipo de Custodia
' 4  Tipo de Cartera
' 5  Retiro
' 6  Comunas
' 7  Tipo de Cliente
' 8  Sector Economico
' 9  Monedas de Pacto
'10  Tipo de Emisor
'11  Base de Calculo
'12  Tipo de Amortizscion
'13  Tipo de operacion
'14  Estados de Registro
'15  Plazas
'16  Periodo
Global Tipo_Cliente
'Constantes Para la Tabla de Clientes
'------------------------------------
'Constantes Para la Tabla de Clientes
'------------------------------------
Global Const MDTC_COMUNAS = 44
Global Const MDTC_TIPOCLIENTE = 72
Global Const MDTC_SECECONOMICO = 41
Global Const MDTC_CIUDAD = 3
Global Const MDTC_ENTIDAD = 234
Global Const MDTC_MERCADO = 202
Global Const MDTC_GRUPO = 233
Global Const MDTC_Pais = 180
Global Const MDTC_CALIDADJURIDICA = 39 'antes 36
Global Const MDTC_RGBANCO = 40
Global Const MDTC_RELACION = 32
Global Const MDTC_CATEGORIADEUDOR = 42
Global Const MDTC_COMINSTITUCIONAL = 41
Global Const MDTC_CLASIFICACION = 103
Global Const MDTC_ACTIVIDADECONOMICA = 13

'Constantes Para La Tabla de Emisores
'------------------------------------
Global Const MDEM_TIPOEMISOR = 10

'Constantes Para la Tabla de Monedas
'-----------------------------------
Global Const MDMN_PERIODO = 216
Global Const MDMN_BASE = 211
Global Const MDMN_TIPOMONEDA = 217

'Constantes Para la Tabla de Feriados
'------------------------------------
Global Const MDFE_PLAZA = 215

'Constantes para la tabla de instrumentos
'--------------------------------------------
Global Const MDIN_BASES = 211
Global Const MDIN_TIPOFECHA = 220
Global Const MDIN_TIPO = 219
Global Const MDIN_EMISION = 221

Global gsBac_Timer As Integer ' Timer
Global gsBac_Timer_Adicional As Long ' Timer

'Constantes Para la Tabla de Series
'--------------------------------------------
Global Const MDSE_TIPOAMORTIZACION = 212
Global Const MDSE_TIPOPERIODO = 216

Global Cartera                      As Boolean
Global XCarteraSuper                As String
Global xentidad                     As String

Global xRut                         As Long
Global xCodigo                      As Long
Global xFecha                       As Date

'Constantes para Form. de Plan de Cuentas
Global Const MDPC_TIPO = 23
Global Glob_Archivo_Ayuda               As String
Global Glob_Filtro_Ayuda                As String
Global Glob_Registro_Ayuda              As String
Global Fecha_Expira                     As Date
Global DIAS_PACTO_PAPEL_NO_CENTRAL      As Integer
Global DIAS_PACTO_PAPEL_NO_CENTRAL_90   As Integer
Global MONTO_PATRIMONIO_EFECTIVO        As Double

'Cambio de clave
Global Largo_Clave  As Integer
Global Tipo_Clave   As String
Global Antes_Flag   As Boolean
Global tipo         As String
Global devolver     As String

Global nPorcentaje As Double
Global nPorcMinimo As Double
Global nPorcMaximo As Double

'Constantes para llenado de combos de nuevos campos - libro - tipo cartera - Categoria cartera super
Global Const GLB_CARTERA = "204"
Global Const GLB_CATEG = "245"
Global Const GLB_CARTERA_NORMATIVA = "1111"
Global Const GLB_LIBRO = "1552"
Global Const GLB_AREA_RESPONSABLE = "1553"
Global Const GLB_SUB_CARTERA_NORMATIVA = "1554"

Global Const GLB_ID_SISTEMA = "BTR"

'LD1-COR-035 FUSION--> IMPLEMENTAR CARTERA VOLCKER RULE
Global Const GBL_CARTERA_VOLCKER_RULE = "206"


Public Sub BacLLenaComboMes(cbx As Object)
   
   cbx.Clear
   
   cbx.AddItem "Enero"
   cbx.ItemData(cbx.NewIndex) = 1
   cbx.AddItem "Febrero"
   cbx.ItemData(cbx.NewIndex) = 2
   cbx.AddItem "Marzo"
   cbx.ItemData(cbx.NewIndex) = 3
   cbx.AddItem "Abril"
   cbx.ItemData(cbx.NewIndex) = 4
   cbx.AddItem "Mayo"
   cbx.ItemData(cbx.NewIndex) = 5
   cbx.AddItem "Junio"
   cbx.ItemData(cbx.NewIndex) = 6
   cbx.AddItem "Julio"
   cbx.ItemData(cbx.NewIndex) = 7
   cbx.AddItem "Agosto"
   cbx.ItemData(cbx.NewIndex) = 8
   cbx.AddItem "Septiembre"
   cbx.ItemData(cbx.NewIndex) = 9
   cbx.AddItem "Octubre"
   cbx.ItemData(cbx.NewIndex) = 10
   cbx.AddItem "Noviembre"
   cbx.ItemData(cbx.NewIndex) = 11
   cbx.AddItem "Diciembre"
   cbx.ItemData(cbx.NewIndex) = 12
   
   cbx.ListIndex = -1
   
End Sub

Function bacBuscarCombo(cControl As Object, nValor As Variant)

   Dim iLin    As Integer

   With cControl
      For iLin = 0 To .ListCount - 1
         If .ItemData(iLin) = nValor Then
            .ListIndex = iLin
           
            Exit For

         End If

      Next iLin

   End With

End Function
Function FUNC_VALIDA_CLAVE_DCV_DIARIA(oGrilla As MSFlexGrid, nFilaValida As Integer, nColClaveDCV, cClaveValida As String) As Boolean

    Dim Datos()
    Dim nContador        As Integer
    
    FUNC_VALIDA_CLAVE_DCV_DIARIA = False
    
    Envia = Array()
    AddParam Envia, cClaveValida
        
    If Not Bac_Sql_Execute("SP_VALIDA_CLAVE_DCV", Envia) <> 0 Then
        Screen.MousePointer = vbDefault
        MsgBox "A ocurrido un error al intentar validar la clave DCV", vbCritical
        Exit Function
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) <> "" Then
            Screen.MousePointer = vbDefault
            MsgBox "Clave DCV ya fue utilizada durante el dia de hoy.", vbExclamation
            Exit Function
        End If
    End If
        
    With oGrilla
        If .Rows > 2 Then
            For nContador = 1 To .Rows - 1
                If Trim(.TextMatrix(nContador, nColClaveDCV)) = cClaveValida Then
                    Screen.MousePointer = vbDefault
                    MsgBox "Clave DCV ya fue utilizada en esta operacion y no se podrá volver a repetir durante el dia.", vbExclamation
                    Exit Function
                End If
            Next nContador
        End If
    End With
    
       
    FUNC_VALIDA_CLAVE_DCV_DIARIA = True

End Function

Sub PROC_POSI_TEXTO(GRILLA As Control, texto As Control)
 On Error Resume Next
    texto.Top = GRILLA.CellTop + GRILLA.Top ' + 20
    texto.Left = GRILLA.CellLeft + GRILLA.Left ' + 20
    texto.Width = GRILLA.CellWidth ' - 20
    texto.Height = GRILLA.CellHeight
End Sub
Function RELLENA_STRING(Dato As String, Pos As String, Largo As Integer) As String
'rellena con blancos y completa el largo requerido
' Ejemplo : x$ = RELLENA_STRING(CStr(i#), "I", 10)
' Ejemplo : x$ = RELLENA_STRING(i$, "D", 10)

If Trim(Pos$) = "" Then Pos$ = "I"

If Largo < Len(Trim(Dato)) Then
   RELLENA_STRING = Mid(Trim(Dato), 1, Largo)
   Exit Function
End If

If Mid(Pos$, 1, 1) = "I" Then 'IZQUIERDA
   RELLENA_STRING = String(Largo - Len(Trim(Dato)), " ") + Trim(Dato)
Else                          'DERECHA
   RELLENA_STRING = Trim(Dato) + String(Largo - Len(Trim(Dato)), " ")
End If

RELLENA_STRING = Mid(RELLENA_STRING, 1, Largo)

End Function
Sub Limpiar_Cristal()
Dim i As Integer
   For i = 0 To 20
        BacTrader.bacrpt.StoredProcParam(i) = ""
        BacTrader.bacrpt.Formulas(i) = ""
   Next i

End Sub

Sub PROC_POSICIONA_TEXTO(GRILLA As MSFlexGrid, texto As Control)
Dim n As Integer
Dim i As Integer
Dim F As Integer

 texto.Width = GRILLA.ColWidth(GRILLA.Col)
 texto.Height = GRILLA.RowHeight(GRILLA.Row)
 
 If GRILLA.TopRow > 1 Then
    texto.Top = GRILLA.Top + (((GRILLA.Row - GRILLA.TopRow) + 1) * 245) + 30
 Else
    texto.Top = GRILLA.Top + (GRILLA.Row * 245) + 30
 End If
 
 n = 0
 F = IIf(GRILLA.Col = 0, 0, GRILLA.Col - 1)
 
 If GRILLA.Col > 0 Then
     For i = 0 To F
        n = n + GRILLA.ColWidth(i) + 10
     Next i
 End If
 
 texto.Left = GRILLA.Left + n + 10
 ' Texto.Left = Grilla.Left + (Grilla.Col * 30) + 20
End Sub


Public Sub BacControlWindows(n%)

    Dim i%
    For i% = 1 To n%
          DoEvents
    Next
    
End Sub

Public Function BacEnCript(USR_PSW$, bEncript As Boolean) As String

Const LEN_PSW = 15
'Const KEY_PSW = "jm*sx/ch^yr<=ze"
Const KEY_PSW = "zbcdefghijklmno"
Const nMAGIC1 = 5
Const nMAGIC2 = 11
Const nMAGIC3 = 253

Dim iDir%, jDir%, kDir%, nAnt%, nAsc%, nKey%, nPsw%, cPsw$

    nAnt% = nMAGIC1
    jDir% = IIf(bEncript, Len(USR_PSW$), 1)
    kDir% = 0

    For iDir% = 1 To Len(USR_PSW$)

        If iDir% > LEN_PSW Then kDir% = 1 Else kDir% = kDir% + 1
        
            nAsc% = Asc(Mid$(USR_PSW$, jDir%, 1))
            nKey% = Asc(Mid$(KEY_PSW$, kDir%, 1))
            nPsw% = nAsc% Xor nKey% Xor nAnt% Xor ((i% / nMAGIC2) Mod nMAGIC3)
            
            If bEncript Then
                cPsw$ = cPsw$ & Chr$(nPsw%)
                nAnt% = nAsc%
                jDir% = jDir% - 1
           Else
                cPsw$ = Chr$(nPsw%) & cPsw$
                nAnt% = nPsw%
                jDir% = jDir% + 1
        End If

    Next
       
BacEnCript = cPsw$
       
End Function

Public Function BacExtraer(ByRef sBuff$) As String
       
       Dim iPos%
       iPos% = InStr(sBuff$, "|")
       
       If iPos% > 0 Then
             BacExtraer = Mid$(sBuff$, 1, iPos% - 1)
             sBuff$ = Mid$(sBuff$, iPos% + 1)
       Else
             BacExtraer = sBuff$
             sBuff$ = ""
       End If
       
End Function


Public Function BacInit() As Boolean
   
   Dim sFile$       ', datos()
   Dim sFile1$
   Dim cDato       As String
   Dim nI          As Integer
   Dim cNewqueue   As String

   BacInit = False

   'Traer datos generales del Sistema
   sFile$ = "Bac-Sistemas.ini"
      
   If Dir("C:\WINNT\" & sFile$) <> "" Then
      
      sFile$ = "C:\WINNT\" & sFile$
      
   ElseIf Dir("C:\WINDOWS\" & sFile$) <> "" Then
      
      sFile$ = "C:\WINDOWS\" & sFile$
      
   ElseIf Dir("C:\BTRADER\" & sFile$) <> "" Then
      
      sFile$ = "C:\BTRADER\" & sFile$
   
   ElseIf Dir("C:\" & sFile$) <> "" Then
      
      sFile$ = "C:\" & sFile$
   
   ElseIf Dir(App.Path & "\" & sFile$) <> "" Then
      
      sFile$ = App.Path & "\" & sFile$
   
   Else
      
      MsgBox "Archivo de configuraciones no existe.", vbCritical, TITSISTEMA
      End
   
   End If

   'NET y Datos Grales.administra
   
   gsBac_User = Func_Read_INI("NET", "NET_UserName", sFile$)
   gsBac_Term = Func_Read_INI("NET", "NET_ComputerName", sFile$)
   sFile1$ = Func_Read_INI("INI", "DBO_PATH", sFile$) & "DBO.INI"
   gsBac_Pass$ = ""
   
   ' FTP
   gsNom_maq = Func_Read_INI("FTP_TRADER", "NOM_SER", sFile$)
   gsUser_maq = Func_Read_INI("FTP_TRADER", "USERNAME", sFile$)
   gsPass_maq = Func_Read_INI("FTP_TRADER", "PASSWORD", sFile$)
   gsPath_maq = Func_Read_INI("FTP_TRADER", "RUTA_ARCHIVO", sFile$)
   
    'DBF
    gsPath_Dbf = Func_Read_INI("INTERFAZ", "PATH_DBF", sFile$)
    
   'SQL
   gsSQL_Database = Func_Read_INI("SQL", "DB_Trader", sFile$)
   gsSQL_Server = Func_Read_INI("SQL", "Server_Name", sFile$)
   '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   'gsSQL_Login = Func_Read_INI("usuario", "usuario", sFile1$)
   'gsSQL_Password = Encript(Trim(Func_Read_INI("usuario", "password", sFile1$)), False)
   '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   giSQL_LoginTimeOut = Val(Func_Read_INI("SQL", "Login_TimeOut", sFile$))
   giSQL_QueryTimeOut = Val(Func_Read_INI("SQL", "Query_TimeOut", sFile$))
   giSQL_ConnectionMode = Val(Func_Read_INI("SQL", "Connection_Mode", sFile$))
   GsODBC = Func_Read_INI("SQL", "ODBC_Trader", sFile$)
   gsSQL_Database_comun = Func_Read_INI("SQL", "DB_Parametros", sFile$)
   '+++jcamposd 20160505 dap anulación por altamira
   gsALT_User = Func_Read_INI("ALTAMIRA", "ALT_User", sFile$)
   '---jcamposd 20160505 dap
   '+++ cvegasan 2017.08.08 Control Lineas IDD
   gsBac_Url_WebService = Func_Read_INI("WEB", "URL_WEBSERVICE", sFile$)
   gsBac_Url_WebMethod = Func_Read_INI("WEB", "URL_WEBMETHOD", sFile$)
   '--- cvegasan 2017.08.08 Control Lineas IDD

   gsALT_Canal = Func_Read_INI("ALTAMIRA", "Canal", sFile$)
   gsALT_Tipo = Func_Read_INI("ALTAMIRA", "Tipo_Tran", sFile$)
   
   
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
      
   ElseIf GsODBC = "" Then
      MsgBox "Coneccion ODBC No esta definida para conectarse con Base de Datos", vbCritical, TITSISTEMA
      Exit Function
      
   End If
   '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   'SwConeccion = "DSN=" & GsODBC
   'SwConeccion = SwConeccion & ";UID=" & gsSQL_Login
   'SwConeccion = SwConeccion & ";PWD=" & gsSQL_Password
   'SwConeccion = SwConeccion & ";DSQ=" & gsSQL_Database
    SwConeccion = "DSN=" & GsODBC
    SwConeccion = SwConeccion & ";TRUSTED_CONNECTION = yes"
    SwConeccion = SwConeccion & ";DSQ=" & gsSQL_Database
   '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   CONECCION = SwConeccion
   
   gsMDB_Path = Func_Read_INI("MDB", "MDB_Path", sFile$)
   gsMDB_Database = Func_Read_INI("MDB", "MDB_Trader", sFile$)
   gsMDB_SOURCE = Func_Read_INI("MDB", "MDB_Source", sFile$)       '--> VB+- 06/01/2010 Se utiliza para copiar MDB
   
  
   
'   RptList_Path = App.Path & "\" & Func_Read_INI("REPORTES", "RPT_Trader", sFile$)
   RptList_Path = Func_Read_INI("REPORTES", "RPT_Trader", sFile$)

   gsDOC_Path = Func_Read_INI("DOCUMENTOS", "DOC_Trader", sFile$)

  ' PARAMSe
    giMonLoc = Val(Func_Read_INI("PARAMS", "MonedaLocal", sFile$))
    gsBac_Timer = Val(Func_Read_INI("PARAMS", "Tiempo_Val", sFile$)) 'Rango tiempo del Timer
    gsBac_Timer_Adicional = Val(Func_Read_INI("PARAMS", "ADICIONAL_TIMER", sFile$))
    
  ' Doc Fondos Mutuos
    ArchFM_in = Func_Read_INI("FONDOS_MUTUOS", "ARCHIVO_CUOTAS_IN", sFile$)
    ArchFM_out = Func_Read_INI("FONDOS_MUTUOS", "ARCHIVO_CUOTAS_OUT", sFile$)
  
  ' Definición Busqueda de Archivos TXT
    gsBac_DIRIN = Trim(Func_Read_INI("INTERFAZ", "PATH_BTR", sFile$))
    gsBac_DIRCO = Trim(Func_Read_INI("INTERFAZ", "PATH_CO", sFile$))
    gsBac_Version = Trim(Func_Read_INI("PARAMS", "VERSION", sFile$))
    gsBac_Papeleta = Trim(Func_Read_INI("PARAMS", "PAPELETA", sFile$))
    gsBac_DIREXEL = Trim(Func_Read_INI("INTERFAZ", "PATH_EXEL", sFile$))
    gsBac_DIRIBS = Trim(Func_Read_INI("INTERFAZ_IBS", "PATH_BTR_IBS", sFile$))
    gsBac_Office = Trim(Func_Read_INI("PROGRAM_EXTER", "RUTA_OFFICE", sFile$))
    gsBac_DIRCONTA = Trim(Func_Read_INI("INTERFAZ_CONT", "PATH_INTER_CONT ", sFile$))
    gsBac_DIRSOMA = Trim(Func_Read_INI("TXT", "SOMA_Path", sFile$))  ' PRD-6010
    gsBac_DIRPAE = Trim(Func_Read_INI("TXT", "Dir_PAE", sFile$))  ' PRD-10449
    gsBac_DIRLINEAS = Trim(Func_Read_INI("TXT", "Dir_Lineas", sFile$))  ' NUEVO PARA LD1

    If gsBac_Papeleta = "" Then
        gsBac_Papeleta = 1            'Salida de las papeletas a impresora
    End If

  ' Impresora y Cola de Impresión a Utilizar Bac-Trader
    gsBac_IMPDEF = Func_Read_INI("PRINTERS", "PRNDEF", sFile$)
    gsBac_QUEDEF = Func_Read_INI("PRINTERS", "QUEDEF", sFile$)
    gsBac_IMPPPC = Func_Read_INI("PRINTERS", "PRNPPC", sFile$)
    gsBac_QUEPPC = Func_Read_INI("PRINTERS", "QUEPPC", sFile$)
    
  'Lineas
    gsBac_Lineas = Func_Read_INI("LINEAS", "Lineas", sFile$)
    gsBac_Lineas = "S"
    gsBac_LineasDb = Func_Read_INI("SQL", "DB_Lineas", sFile$)
    
  ' Impresoras o Colas de Impresión por defecto Windows
    gsBac_IMPWIN = Func_Read_INI("windows", "device", "WIN.INI")
    
   If UCase(Mid$(gsBac_QUEDEF, Len(gsBac_IMPDEF) + 2, Len(gsBac_QUEDEF))) <> UCase(Func_Read_INI("Devices", gsBac_IMPDEF, "WIN.INI")) Or gsBac_QUEDEF = "" Then
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
    
   'Impresora de Matriz de Punto que Imprime Pases por Caja de Ricardo Estay
   If InStr(1, UCase(Func_Read_INI("Devices", gsBac_IMPPPC, "WIN.INI")), "RESTAY") > 0 Then
       gsBac_QUEPPC = Func_Read_INI("PRINTERS", "QUEPPO", sFile$)
   End If
            
  ' Otros.-
   
   gbBac_Login = False
   gsBac_PtoDec = Mid(Format(0#, "0.0"), 2, 1)
   
      'Creación automatica de ODBC
   Dim Attribs As String
   Dim MyWorkspace As Workspace
   Set MyWorkspace = Workspaces(0)

   Attribs = "Description=BacTrader" & Chr$(13)
   Attribs = Attribs & "Server=" & gsSQL_Server & Chr$(13)
   '+++cvegasan 2017.06.05 HOM Ex-Itau
    If giSQL_ConnectionMode = 3 Then
    Attribs = Attribs & "Trusted_Connection=yes" & Chr$(13)
    End If
   '---cvegasan 2017.06.05 HOM Ex-Itau
   Attribs = Attribs & "Database=" & gsSQL_Database

   DBEngine.RegisterDatabase GsODBC, "SQL Server", True, Attribs

   MyWorkspace.Close
   'Fin

    Call FUNC_COPIAR_MDB  ' +-VB 06/01/2010 copia base de access desde el servidor al PC
  
   'Abrir Base de datos MDB.-
   If Not BacAbrirBaseDatosMDB() Then
      MsgBox "No se encuentra archivos MDB.", vbCritical, TITSISTEMA
      Exit Function
   End If
   
   BacInit = True
   
End Function
'---------------------------------------------------
' BacLogFile
' Esta rutina escribe en el archivo LOG del usuario.
'---------------------------------------------------
Public Sub BacLogFile(sLogEvent$)

Dim hFile%
hFile% = FreeFile

Open App.Path & "\btrader.log" For Append Access Write Shared As #hFile%
Write #hFile%, Format$(Now, "dd/mm/yyyy hh:mm:ss") & ": " & sLogEvent$
Close #hFile%

End Sub

Public Function BacFormatoFecha(cFormato As String, dFecha As Variant) As String
' cFormato ( DDMMAA )  =>  Día de Mes de Año
' cFormato ( MMDDAA )  =>  Mes, Día de Año
   If cFormato = "DDMMAA" Then
      BacFormatoFecha = Format(dFecha, "d") + " de " + Format(dFecha, "mmmm") + " de " + Format(dFecha, "yyyy")
   Else
      BacFormatoFecha = Format(dFecha, "mmmm ,") + Format(dFecha, "d") + " de " + Format(dFecha, "yyyy")
   End If
End Function

Public Function BacStrTran(sCadena$, sFind$, sReplace$) As String
         
'Función que quita las comas dependiendo del formato windows
'Al SqlServer no se le puede pasar un valor numérico con comas

Dim iPos%
Dim iLen%
         
    If Trim$(sCadena$) = "" Then
       sCadena$ = "0"
    End If
    
    iPos% = 1
    
    iLen% = Len(sFind$)
    
    Do While True
        iPos% = InStr(1, sCadena$, sFind$)
        If iPos% = 0 Then
                Exit Do
        End If
        sCadena$ = Mid$(sCadena$, 1, iPos% - 1) + sReplace$ + Mid$(sCadena$, iPos% + iLen%)
    Loop
    
    BacStrTran = Trim$(CStr(sCadena$))
         
End Function

Public Function BacBuscaCodigo(obj As Object, codi As Integer) As Long
        Dim F   As Long
        Dim Max As Long
        
            BacBuscaCodigo = -1
            
            Max = obj.coleccion.Count
            
            For F = 1 To Max
                If obj.coleccion(F).Codigo = codi Then
                   BacBuscaCodigo = F - 1
                   Exit For
                End If
            Next F

End Function

Public Function BacBuscaGlosa(obj As Object, codi As String) As Long

        Dim F   As Long
        Dim Max As Long
        
            BacBuscaGlosa = -1
            
            Max = obj.coleccion.Count
            
            For F = 1 To Max
                If Trim$(obj.coleccion(F).Glosa) = Trim(codi) Then
                   BacBuscaGlosa = F - 1
                   Exit For
                End If
            Next F
            
End Function


Public Function BacDiaSem(sfec$) As String

    BacDiaSem = ""
    
    If IsDate(sfec$) Then
        Select Case Weekday(sfec$)
            Case 1
                BacDiaSem = "Domingo"
            Case 2
                BacDiaSem = "Lunes"
            Case 3
                BacDiaSem = "Martes"
            Case 4
                BacDiaSem = "Miércoles"
            Case 5
                BacDiaSem = "Jueves"
            Case 6
                BacDiaSem = "Viernes"
            Case 7
                BacDiaSem = "Sábado"
        End Select
    End If

End Function
Function BacEsHabil(cFecha As String) As Boolean

Dim objFeriado As New clsFeriado

Dim iAno       As Integer
Dim iMes       As Integer
Dim cDia       As String
Dim gcPlaza    As String
Dim n          As Integer

            

            ' Temporalmente.-
            '-----------------
'            gcPlaza = "00001"
            gcPlaza = "00006"
            sDia = BacDiaSem(cFecha)
            If sDia = "Sábado" Or sDia = "Domingo" Then
                        BacEsHabil = False
                        Exit Function
            End If

            iAno = DatePart("yyyy", cFecha)
            iMes = DatePart("m", cFecha)
            cDia = Format(DatePart("d", cFecha), "00")

            objFeriado.Leer iAno, gcPlaza

            Select Case iMes
                   Case 1:  n = InStr(objFeriado.feene, cDia)
                   Case 2:  n = InStr(objFeriado.fefeb, cDia)
                   Case 3:  n = InStr(objFeriado.femar, cDia)
                   Case 4:  n = InStr(objFeriado.feabr, cDia)
                   Case 5:  n = InStr(objFeriado.femay, cDia)
                   Case 6:  n = InStr(objFeriado.fejun, cDia)
                   Case 7:  n = InStr(objFeriado.fejul, cDia)
                   Case 8:  n = InStr(objFeriado.feago, cDia)
                   Case 9:  n = InStr(objFeriado.fesep, cDia)
                   Case 10: n = InStr(objFeriado.feoct, cDia)
                   Case 11: n = InStr(objFeriado.fenov, cDia)
                   Case 12: n = InStr(objFeriado.fedic, cDia)
            End Select

            Set objFeriado = Nothing

            If n > 0 Then
                 BacEsHabil = False
            Else
                 BacEsHabil = True
            End If


End Function

Private Sub Respaldo_de_constantes()
    
    '/* ----------------------------------------------------------------------------------------
    '**
    '**              Contantes Globales para Los Mensajes de Clientes
    '**
    '*/ ----------------------------------------------------------------------------------------
    'Global Const MSG_CLConeccion = 10001     ', "No se puede conectar a tabla de clientes.-"
    'Global Const MSG_CLBorrar = 10002        ', "No se puede eliminar este cliente.-"
    'Global Const MSG_CLGrabar = 10003        ', "No se puede grabar este cliente.-"
    'Global Const MSG_ClValRut = 10004        ', "El rut del cliente es incorrecto.-"
    'Global Const MSG_ClValNombre = 10005     ', "No ingres¢ nombre del cliente.-"
    'Global Const MSG_CLValDireccion = 10006  ', "No ingres¢ direcci¢n del cliente.-"
    'Global Const MSG_CLValComuna = 10007     ', "No ingres¢ comuna del cliente.-"
    'Global Const MSG_CLValTipCli = 10008     ', "No ingres¢ tipo de cliente.-"
    'Global Const MSG_CLValSecEcon = 10009    ', "No ingres¢ setor econ¢mico del cliente.-"
    'Global Const MSG_CLGrabarOK = 10010      ', "Registro cliente ha sido grabado.-"
    'Global Const MSG_CLBorrarOK = 10011      ', "Registro cliente ha sido eliminado.-"
    'Global Const MSG_CLPregunta = 10012      ', "Seguro de eliminar cliente" : idvalor = "PR"
    
    '/* ----------------------------------------------------------------------------------------
    '**
    '**              Contantes Globales para Los Mensajes de Emisores
    '**
    '*/ ----------------------------------------------------------------------------------------
    'Global Const MSG_EMConeccion = 11001    ', "No se puede conectar a tabla de emisores.-"'
    'Global Const MSG_EMGrabar = 11002       ', "No se puede grabar registro en la tabla de emisores.-"
    'Global Const MSG_EMBorrar = 11003       ', "No se puede eliminar registro de la tabla de emisores.-"
    'Global Const MSG_EMValRut = 11004       ', "El rut el emisor es incorrecto._"
    'Global Const MSG_EMValNombre = 11005    ', "No ha ingresado nombre.-"
    'Global Const MSG_EMValGenerico = 11006  ', "No ha ingresado nenérico.-"
    'Global Const MSG_EMValDirec = 11007     ', "No ha ingresado dirección.-"
    'Global Const MSG_EMValComuna = 11008    ', "No ha ingresado comuna.-"
    'Global Const MSG_EMGrabarOK = 11009     ', "El registro de emisor se grab¢ con éxito.-"
    'Global Const MSG_EMBorrarOK = 11010     ', "El registro de emisor ha sido eliminado.-"
    'Global Const MSG_EMPregunta = 11011     ', "Seguro de eliminar emisor" : idvalor = "PR"
    '/* ----------------------------------------------------------------------------------------
    '**
    '**              Contantes Globales para Los Mensajes de Tablas de Uso General
    '**
    '*/ ----------------------------------------------------------------------------------------
    'Global Const MSG_TGConeccion = 12001      ', "No se puede conectar a tablas de uso general.-"
    'Global Const MSG_TGGrabar = 12002         ', "No se puede grabar registro en tablas generales.-"
    'Global Const MSG_TGBorrar = 12003         ', "No se pudo eliminar registro en tablas generales.-"
    'Global Const MSG_TGBegin = 12004          ', "No se puede grabar registro en tablas generales. Error en Begin Trans.-"
    'Global Const MSG_TGBorrarRollBack = 12005 ', "No se puede eliminar registro en tablas generales. Error en RollBack Trans.-"
    'Global Const MSG_TGGrabarRollback = 12006 ', "No se puede grabar registro en tablas generales. Error en RollBack Trans.-"
    'Global Const MSG_TGCommit = 12007         ', "No se puede grabar registro en tablas generales. Error en Commit Trans.-"
    'Global Const MSG_TGValCodigos = 12008     ', "Algunos c¢digos no est n ingresados.-"
    'Global Const MSG_TGValElemento = 12009    ', "No ha seleccionado elemento de la lista.-"
    'Global Const MSG_TGGrabarOK = 12010       ', "Grabaci¢n se realiz¢ con éxito.-"
    
    
    '/* ----------------------------------------------------------------------------------------
    '**
    '**              Contantes Globales para Los Mensajes de Monedas
    '**
    '*/ ----------------------------------------------------------------------------------------
    'Global Const MSG_MNConeccion = 13001     ', "No se puede conectar a tabla de monedas.-"
    'Global Const MSG_MNGrabar = 13002        ', "No se Puede grabar registro en la tabla de monedas.-"
    'Global Const MSG_MNBorrar = 13003        ', "No se puede eliminar registro de la tabla monedas.-"
    'Global Const MSG_MNValCodMon = 13004     ', "El c¢digo de moneda incorrecto.-"
    'Global Const MSG_MNValGlosa = 13005      ', "No ha ingresado glosa de moneda.-"
    'Global Const MSG_MNValNemo = 13006       ', "No ha ingresado nemot‚cnico.-"
    'Global Const MSG_MNValSimbolo = 13007    ', "No ha ingresado s¡mbolo.-"
    'Global Const MSG_MNGrabarOK = 13008      ', "Registro de moneda ha sido grabado.-"
    'Global Const MSG_MNBorrarOK = 13009      ', "Registro de moneda ha sido eliminado.-"
    'Global Const MSG_MNPregunta = 13010      ', "Seguro de eliminar moneda.-"
    
    '/* ----------------------------------------------------------------------------------------
    '**
    '**              Contantes Globales para Los Mensajes de Dueños de Carteras
    '**
    '*/ ----------------------------------------------------------------------------------------
    'Global Const MSG_DCConeccion = 14001     ', "No se puede conectar a tabla de due¤o de cartera.-"
    'Global Const MSG_DCGrabar = 14002        ', "No se puede grabar registro en tabla de d. de cartera.-"
    'Global Const MSG_DCBorrar = 14003        ', "No se puede eliminar registro en tabla de d. de cartera.-"
    'Global Const MSG_DCValrut = 14004        ', "El rut de due¤o de cratera es incorrecto.-"
    'Global Const MSG_DCValDescrip = 14005    ', "No ha ingresado descripci¢n de due¤os de cartera.-"
    'Global Const MSG_DCValcodigo = 14006     ', "No ha ingresado c¢digo de due¤os de cartera.-"
    'Global Const MSG_DCGrabarOK = 14007      ', "Registro de due¤os de cartera ha sido grabado.-"
    'Global Const MSG_DCBorrarOK = 14008      ', "Registro de due¤os de cartera ha sido eliminado.-"
    'Global Const MSG_DCPregunta = 14009      ', "Seguro de eliminar due¤o de cartera" : idvalor = "PR"
    
    '/* ----------------------------------------------------------------------------------------
    '**
    '**              Contantes Globales para Los Mensajes de Valores de Monedas
    '**
    '*/ ----------------------------------------------------------------------------------------
    'Global Const MSG_VMConeccion = 15001      ', "No se puede conectar a tabla de valores de monedas" : idvalor = "ST"
    'Global Const MSG_VMGrabar = 15002         ', "No se puede grabar registros de valores de monedas" : idvalor = "ST"
    'Global Const MSG_VMGrabarBegin = 15003    ', "No se puede grabar registros de valores de monedas, error en Begin Trans" : idvalor = "ST"
    'Global Const MSG_VMGrabarRollback = 15004 ', "No se puede grabar registros de valores de monedas, error en Rollback Trans" : idvalor = "ST"
    'Global Const MSG_VMGrabarCommit = 15005   ', "No se puede grabar registros de valores de monedas, error en Commit Trans" : idvalor = "ST"
    'Global Const MSG_VMValMes = 15006         ', "No ha elegido mes" : idvalor = "VA"
    'Global Const MSG_VMGrabarOK = 15007       ', "Valores de monedas se grabaron exitosamente" : idvalor = "OK"
    
    '/* ----------------------------------------------------------------------------------------
    '**
    '**              Contantes Globales para Los Mensajes de Feriados
    '**
    '*/ ----------------------------------------------------------------------------------------
    'Global Const MSG_FEConeccion = 16001      ', "No se puede conectar a tabla de feriados" : idvalor = "ST"
    'Global Const MSG_FEGrabar = 16002         ', "No se puede grabar registro en tabla de feriados" : idvalor = "ST"
    'Global Const MSG_FEValMes = 16003         ', "No ha seleccionado el mes" : idvalor = "VA"
    'Global Const MSG_FEValPlaza = 16004       ', "No ha seleccionado la plaza" : idvalor = "VA"
    'Global Const MSG_FEValAno = 16005         ', "El a¤o est  en blanco" : idvalor = "VA"
    'Global Const MSG_FEValDiasFer = 16006     ', "Existen mas de 10 dias feriados" : idvalor = "VA"
    'Global Const MSG_FEGrabarOK = 16007       ', "Registros de feriados se grabaron exitosamente" : idvalor = "OK"

End Sub


Public Function BacValidaRut(Rut As String, dig As String) As Integer
Dim i       As Integer
Dim D       As Integer
Dim Divi    As Long
Dim Suma    As Long
Dim Digito  As String
Dim Multi   As Double

    BacValidaRut = False
    
    If Trim$(Rut) = "" Or Trim$(dig) = "" Then
       Exit Function
    End If
    
    Rut = Format(Rut, "00000000")
    D = 2
    For i = 8 To 1 Step -1
        Multi = Val(Mid$(Rut, i, 1)) * D
        Suma = Suma + Multi
        D = D + 1
        If D = 8 Then
           D = 2
        End If
    Next i
    
    Divi = (Suma \ 11)
    Multi = Divi * 11
    Digito = Trim$(Str$(11 - (Suma - Multi)))
    
    If Digito = "10" Then
       Digito = "K"
    End If
    
    If Digito = "11" Then
       Digito = "0"
    End If
    
    'baccliente.txtDigito = Digito
    devolver = Digito
    
    If Trim$(UCase$(Digito)) = UCase$(Trim$(dig)) Then
       BacValidaRut = True
    End If
    
End Function



Function FUNC_GENERA_CLAVE_DCV() As String
Dim SQL As String
Dim Datos()

FUNC_GENERA_CLAVE_DCV = ""
'Exit Function

If miSQL.SQL_Execute("SP_ENTREGA_FOLIO 'DCV'") <> 0 Then
   MsgBox "Falla SP_ENTREGA_FOLIO.", vbCritical, gsBac_Version
   Exit Function
End If
    
If Bac_SQL_Fetch(Datos()) Then
   FUNC_GENERA_CLAVE_DCV = "COPR" + Format(Datos(1), "000000")
End If

End Function


Public Sub DetectarResolucion(MDIFormx As Object, Formx As Object)
   Dim Ancho As Integer, alto As Integer
   Ancho = GetDeviceCaps(Formx.hdc, 8)
   alto = GetDeviceCaps(Formx.hdc, 10)
   If Ancho <> 800 And alto <> 600 Then
      MDIFormx.Picture = Formx.Picture
      Unload Formx
   End If
End Sub

Public Function DiaSemanaDos(dFecha As String, oControl As Object) As String

   Dim iDia       As Integer
   Dim SQL        As String

   DiaSemanaDos = ""
   iDia = Weekday(Format(dFecha, gsc_fechadma))
'   MsgBox "El simbolo utilizado en el separador de miles" & vbCrLf & "y del punto decimal son iguales.", vbOKOnly + vbCritical, "Fatal ERROR"

   oControl.ForeColor = &H8000&
   oControl.Tag = "OK"

   Select Case iDia
   Case 0: DiaSemanaDos = "Error"
      oControl.ForeColor = vbBlue
      oControl.Tag = "ER"

   Case 1: DiaSemanaDos = "Domingo"
      oControl.ForeColor = vbRed
      oControl.Tag = "FE"

   Case 2: DiaSemanaDos = "Lunes"
   Case 3: DiaSemanaDos = "Martes"
   Case 4: DiaSemanaDos = "Miercoles"
   Case 5: DiaSemanaDos = "Jueves"
   Case 6: DiaSemanaDos = "Viernes"
   Case 7: DiaSemanaDos = "Sabado"
      oControl.ForeColor = vbRed
      oControl.Tag = "FE"

   End Select

   If Not BacEsHabilDos(dFecha, "") Then
      oControl.ForeColor = vbRed
      oControl.Tag = "FE"

   End If

   oControl.Caption = DiaSemanaDos

End Function

Function BacEsHabilDos(cFecha As String, plaza As String) As Boolean

   Dim objFeriado As New clsFeriado
   
   Dim iAno       As Integer
   Dim iMes       As Integer
   Dim sDia       As String
    Dim n          As Integer
   
   sDia = BacDiaSem(cFecha)
   If sDia = "Sábado" Or sDia = "Domingo" Then
      BacEsHabilDos = False
      Exit Function
      
   End If
   
   iAno = DatePart("yyyy", cFecha)
   iMes = DatePart("m", cFecha)
   sDia = Format(DatePart("d", cFecha), "00")
   
   objFeriado.Leer iAno, plaza
   
   Select Case iMes
   Case 1:  n = InStr(objFeriado.feene, sDia)
   Case 2:  n = InStr(objFeriado.fefeb, sDia)
   Case 3:  n = InStr(objFeriado.femar, sDia)
   Case 4:  n = InStr(objFeriado.feabr, sDia)
   Case 5:  n = InStr(objFeriado.femay, sDia)
   Case 6:  n = InStr(objFeriado.fejun, sDia)
   Case 7:  n = InStr(objFeriado.fejul, sDia)
   Case 8:  n = InStr(objFeriado.feago, sDia)
   Case 9:  n = InStr(objFeriado.fesep, sDia)
   Case 10: n = InStr(objFeriado.feoct, sDia)
   Case 11: n = InStr(objFeriado.fenov, sDia)
   Case 12: n = InStr(objFeriado.fedic, sDia)
   End Select
   
   Set objFeriado = Nothing
   
   If n > 0 Then
      BacEsHabilDos = False
   
   Else
      BacEsHabilDos = True
   
   End If

End Function


Public Function BacMontoFli(ByVal xMonto As Variant) As String
   Dim sCadena       As String
   Dim iPosicion     As Integer
   Dim sFormato      As String
   Dim tmpValor      As String

   tmpValor = xMonto

   gsc_PuntoDecim = Mid$(Format(0#, "0.0"), 2, 1)

   If gsc_PuntoDecim = "," Then

      Mc = InStr(1, xMonto, ",")

      If Mc > 0 Then

         tmpValor = Mid(xMonto, 1, Mc - 1) & "." & Mid(xMonto, Mc + 1)
               

      End If

   End If

   BacMontoFli = tmpValor

End Function

'=====================================================
' LD1_COR_035 , Tema: Mantenedor Plazo Permanencia
' INICIO
'=====================================================
Public Sub LLENA_COMBO_ESTADO(cmb As Control)
Dim Datos()
    cmb.Clear
    If Not Bac_Sql_Execute("Sp_Busca_Estados") Then
        MsgBox " No encuentra datos", 16
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        cmb.AddItem Datos(1)
        cmb.ItemData(cmb.NewIndex) = Datos(2)
    Loop
       
End Sub

Function FUNC_POSICION_COMBO(Cmb_Control As Control, texto As String, Posicion As Integer) As Integer
Dim i%
Dim encontro As Boolean
  FUNC_POSICION_COMBO = 0
    For i% = 0 To Cmb_Control.ListCount - 1
      Cmb_Control.ListIndex = i%
        If Trim(Mid(Cmb_Control.text, 1, Posicion)) = Trim(texto) Then
          encontro = True
          FUNC_POSICION_COMBO = i%
          Exit For
        End If
    Next i%
End Function

Function bacKeyPress(ByRef KeyAscii As Integer)
Exit Function
   If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii = Asc(gsc_PuntoDecim)

   End If

End Function
'=====================================================
' LD1_COR_035 , Tema: Mantenedor Plazo Permanencia
' FIN
'=====================================================

'------------ LD1-COR-035 LIMITES ALCO
Public Function Valida_Instrumento(nCodigo, nRutemi) As Boolean
Dim Datos()
Valida_Instrumento = True
Envia = Array(nCodigo)
AddParam Envia, nRutemi

If Bac_Sql_Execute("sp_valida_Instrum_Limites_Alco ", Envia) Then
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) = "NO" Then
          Valida_Instrumento = False
      End If
   Else
      MsgBox "Problemas en Rescate de set de datos de retorno SQL para validar el instrumento en los limites ALCCO", vbCritical, TITSISTEMA
      Valida_Instrumento = False
   End If
Else
   MsgBox "Problemas al ejecutar la consulta SQL para validar el instrumento en los limites ALCCO", vbCritical, TITSISTEMA
   Valida_Instrumento = False
End If

End Function
Sub LimpiarCristal()

   Dim X                      As Integer

   For X = 0 To 40
        BacTrader.bacrpt.StoredProcParam(X) = ""
        BacTrader.bacrpt.Formulas(X) = ""
   Next

End Sub
    
Sub MustraCristal(ByVal nTope As Long)
   Dim X As Integer
    Dim cString As String
    
    Let cString = ""
    
   For X = 0 To nTope
        If BacTrader.bacrpt.StoredProcParam(X) = " " Then
            cString = cString & "' '" & ", "
        Else
            cString = cString & BacTrader.bacrpt.StoredProcParam(X) & ", "
        End If
   Next

    Debug.Print cString
End Sub

'BeginNewConnection
Public Function GetNewConnection() As ADODB.Connection
    
    Dim oCn As New ADODB.Connection
    Dim CadenaConexion As String
  
    CadenaConexion = ""
    
    If gsSQL_Login$ = "bacuser" Then
      CadenaConexion = CadenaConexion & "Provider=SQLOLEDB; "
      CadenaConexion = CadenaConexion & "Initial Catalog=" & gsSQL_Database & ";"
      CadenaConexion = CadenaConexion & "Data Source=" & gsSQL_Server$ & ";"
      CadenaConexion = CadenaConexion & "User Id=" & gsSQL_Login$ & ";"
      CadenaConexion = CadenaConexion & "Password=" & gsSQL_Password$ & ";"
    Else
      CadenaConexion = "Provider=SQLOLEDB;Data Source=" & gsSQL_Server & ";Database=" & gsSQL_Database & ";trusted_connection=yes;Connect Timeout=" & giSQL_LoginTimeOut
    End If
    
    oCn.Open CadenaConexion
  
    If oCn.State = adStateOpen Then
        Set GetNewConnection = oCn
    End If
  
End Function
'EndNewConnection

