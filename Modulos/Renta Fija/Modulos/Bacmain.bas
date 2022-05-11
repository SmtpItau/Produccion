Attribute VB_Name = "BacMain11"
Option Explicit

' -----------------------------------------------------------------
' Variables Globales del Sistema.-
' -----------------------------------------------------------------
Global Const PAISES = 1
Global Const REGION = 2
Global Const CIUDAD = 3
Global Const COMUNA = 4

Global opcion        As String
Global titulorpt     As String
Global Titulo        As String
Global SwMx          As String
Global Const FDecimal = "#,#0.0000"
Global Const FEntero = "#,###"
Global Const TITSISTEMA = "BAC-TRADER"
Global Const feFECHA = "yyyymmdd"   ' Formato Estandar de Fecha
Global gbBac_Login          As Boolean
Global gsBac_User           As String
Global gsBac_UserName       As String
Global gsBac_Tipo_Usuario   As String
Global gsBac_Term           As String
Global gsBac_Pass           As String
Global gsBac_Fecp           As Date
Global gsBac_Fecx           As Date
Global gsBac_Feca           As Date
'+++jcamposd 20160505 dap eliminacion
Global gsALT_User As String
'---jcamposd 20160505 dap eliminacion
'FMO 20180711 variables para envio XML
Global gsALT_Canal As Integer
Global gsALT_Tipo  As Integer
'FMO 20180711 variables para envio XML

Global gsBAC_FecConFin      As Date   'PROD-10967

Global gsBac_Clien          As String
Global gsBac_RutC           As String
Global gsBac_DigC           As String
Global gsBac_RutComi        As Double
Global gsBac_OkComi         As Integer
Global gsBac_PrComi         As Double
Global gsBac_Iva            As Double
Global gsBac_CodOpe         As String
Global gsBac_Panta          As String * 3
Global gsBac_Valmon         As Double
Global gsBac_Corte          As Double
''++GRC Req007
Global gsBac_DIRSOMA        As String
''--GRC Req007
Global gsBac_IP             As String
Global gsBac_Moneda_Oper    As String
Global gsNum_Oper             As Double

Global gsBac_TCambio        As Double
    
''--REQ.6004
Global gsBac_RutBCCH        As String
Global gsBac_FPagoBCCH      As String
Global gsBac_NomBCCH        As String
Global gsBac_NomFPagoBCCH   As String
'--PRD-10449
Global gsBac_DIRPAE        As String
    
'''''NUEVO PARA LD1
Global gsBac_DIRLINEAS      As String
'''''

    
' SQL
    Global giSQL_ConnectionMode As Integer
    Global gsSQL_Database_comun As String
    Global gsBac_LineasDb       As String
    Global gsSQL_Database       As String
    Global gsSQL_Server         As String
    Global gsSQL_Login          As String
    Global gsSQL_Password       As String
    Global giSQL_LoginTimeOut   As String
    Global giSQL_QueryTimeOut   As String

 'COMUN FOX
    Global gsFox_Comun          As String
    Global gsPath_Fox           As String
    Global gsFox_Seguridad      As String
    Global gsFox_Contabco       As String
     
' MDB
    Global gsMDB_Path           As String
    Global gsMDB_Database       As String
    Global RptList_Path         As String
    Global gsMDB_SOURCE         As String   '--> VB+- 06/01/2010 Se utiliza para copiar MDB

'FM ini 22-05-2008
    Global ArchFM_in          As String
    Global ArchFM_out         As String
'FM ini 22-05-2008
    
'Documentos
    Global gsDOC_Path           As String
    
' Misceleanos
    Global gsRUN_Proceso        As String
     
' DOLAR AMERICANO
    Global Const gsBac_Dolar = "USD"
     
'LD1-COR-035
Global TIPCLI As Integer
     
' FTP
Global gsNom_maq As String
Global gsUser_maq As String
Global gsPass_maq As String
Global gsPath_maq As String

     
 Global gsCodCli  As String
 
 '--LD1-COR-035
 
 Global gsValor_DO As Double
 '--**
 Global gsValor_UF As Double
 '--**
 'Base de Parametros
Global Const giSQL_DatabaseCommon = "BacParamSuda"
Global Valida_limite_over   As Boolean
Global gsBac_PtoMiles  As String
 
 '--LD1-COR-035
' -----------------------------------------------------------------
' Tipos definidos.-
' -----------------------------------------------------------------
   

'Tipo de Datos de entrada para el valorizador
Type BacValorizaInput
    ModCal    As Integer
    FecCal    As String
    Codigo    As Long
    Mascara   As String
    MonEmi    As Integer
    fecemi    As String
    FecVen    As String
    TasEmi    As Double
    BasEmi    As Integer
    TasEst    As Long
    Nominal   As Double
    tir       As Double
    Pvp       As Double
    Mt        As Double
End Type

'Tipo de Datos de Salida para el valorizador
Type BacValorizaOutput
    Nominal     As Double
    tir         As Double
    Pvp         As Double
    Mt          As Double
    MtUM        As Double
    Mt100       As Double
    Van         As Double
    Vpar        As Double
    Numucup     As Integer
    Fecucup     As String
    Intucup     As Double
    Amoucup     As Double
    Salucup     As Double
    Numpcup     As Integer
    Fecpcup     As String
    Intpcup     As Double
    Amopcup     As Double
    Salpcup     As Double
  ' VB +- 17/06/2000 a las 00:10 para controlar Limites
    duratmac  As Double   ' Duration Macaulay
    duratmod  As Double   ' Duration Modificada
    convexid  As Double   ' Convexidad
    
End Type
   

' Estructura datos de emisión.-
Type BacDatEmiType
    iOK             As Integer
    sInstSer        As String * 12
    lRutemi         As Long
    lCodemi         As Long
    iMonemi         As Integer
    sNemo           As String
    sFecEmi         As String * 10
    sFecvct         As String * 10
    dTasEmi         As Double
    iBasemi         As Integer
    sRefNomi        As String * 1
    sLecemi         As String * 6
    sGeneri         As String * 6
    ' para datos extras en ventas
    sFecpcup        As String * 10
    dNumoper        As Double
    sTipOper        As String * 3
    sFecvtop        As String * 10
    iDiasdis        As Integer
End Type

Type BacDatGrlesMoneda
    mncodmon        As Integer
    mnnemo          As String * 8
    mnsimbol        As String * 5
    mnglosa         As String * 35
    mncodsuper      As Integer
    mnnemsuper      As String * 8
    mncodbanco      As Integer
    mnnembanco      As String * 3
    mnbase          As Integer
    mnredondeo      As Integer
    mndecimal       As Integer
    mncodpais       As Integer
    mnrrda          As String * 1
    mnfactor        As Integer
    mnrefusd        As String * 1
    mnlocal         As String * 1
    mnextranj       As String * 1
    mnvalor         As String * 1
    mnrefmerc       As String * 1
    mningval        As Integer
    mntipmon        As String * 1
    mnperiodo       As Integer
    mnmx            As String * 1
    mncodfox        As String * 6
    mnvalfox        As Integer
    mncodcor        As Integer
    codigo_pais     As Integer
    mniso_coddes    As String * 5
    mncodcorrespC   As Double
    mncodcorrespV   As Double
End Type


Global BacDatEmi    As BacDatEmiType
Global BacDatGrMon  As BacDatGrlesMoneda
'----------------------------------------------------------

'Form global multipropósito
Global BacFrmIRF    As Form
Global gsTerminal$

'Codigo de Moneda Local
Global giMonLoc As Integer

'Variables para el manejo del MDB
Global db As Database
Global WS As Workspace

'Variables para el conección del Sql Server
Global gsBaseDatosSQL    As String
Global gsServidorSQL     As String
Global gsUsuario        As String
Global gsPassword       As String

'Numero máximo de ventanas abiertas por tipo
Global Const gcMaximoVentanas = 5

'Variable que me indica si presiono el boton Aceptar de la pantalla de Ayuda
Global giAceptar%

'Variables usadas en la pantalla de Ayuda
Global gscodigo            As String
Global gsDigito            As String
Global gsDescripcion       As String
Global gsSerie             As String
Global gsGenerico          As String
Global gsrut               As String
Global gsvalor             As String
Global gsfax               As String
Global gsnombre            As String
Global gsgeneric           As String
Global gsdirecc            As String
Global gsciudad            As String
Global gsPais              As String
Global gscomuna            As String
Global gsregion            As String
Global gstipocliente       As String
Global gsEntidad           As String
Global gscalidadjuridica   As String
Global gsGrupo             As String
Global gsMercado           As String
Global gsapoderado         As String
Global gsctacte            As String
Global gsfono              As String
Global gs1Nombre           As String
Global gs2Nombre           As String
Global gs1Apellido         As String
Global gs2Apellido         As String
Global gsCtausd            As String
Global gsImplic            As String
Global gsAba               As String
Global gsChips             As String
Global gsSwift             As String
Global gsglosa             As String
Global gsredondeo          As String
Global gsnemo              As String



Global ltRutCliente     As Long
Global ltDigito         As String
Global ltNombre         As String
Global ltDireccion      As String
Global ltComuna         As Long
Global ltCiudad         As Long
Global ltPais           As Long
Global ltCodCliente     As Long
Global ltTelefono       As String
Global ltFax            As String
Global ltEMail          As String
Global ltCodRegion      As Long


'Utilizada en la pantalla para grabar las compras pendientes
Global gFormHandle As Long

'New Line, para MsgBox
Global NL   As String

'Variables Ocupadas para dar Cartera por Defecto
Global gsBac_CartRUT    As Double
Global gsBac_CartDV     As String
Global gsBac_CartNOM    As String
Global RutCartV        As String
Global DvCartV         As String
Global NomCartV        As String

'Conecciones para AS/400 BAE
'Global gsBac_SYSAS      As String
'Global gsBac_SRVAS      As String
'Global gsBac_LINCRED    As Integer
'Global gsBac_EMISVIS    As Integer
'Global gsBac_CLIEEDW    As Integer

Global gsBac_DIRIN          As String
Global gsBac_DIRCO         As String
Global gsBac_Version        As String
Global gsBac_Papeleta       As String
Global gsBac_DIREXEL     As String
Global gsBac_DIRIBS        As String

'Variable para interfaces Contables
Global gsBac_DIRCONTA      As String

'--- VARIABLE PARA RUTA DEL OFFICE M.S.A 16/10/2003
Global gsBac_Office      As String

'Definición de Queue e Impresoras
Global gsBac_IMPDEF       As String
Global gsBac_IMPWIN       As String
Global gsBac_QUEDEF      As String
Global gsBac_IMPPPC      As String
Global gsBac_QUEPPC     As String
Global gsPath_Dbf            As String

'Variable que me indica el tipo de impresion (pap/con)
Global gsTipoPapeleta As String
Global gsBac_Handler As Integer
Global gsBac_PtoDec  As String
Global gsBac_Tcamara As Integer
Global gsBac_FecValr As Date
'ODBC
Global GsODBC As String
Global CONECCION As String

Global miSQL As New BTPADODB.CADODB

'Lineas
Global gsBac_Lineas As String

'log_auditoria
Global ValorA, ValorN As String
Global Valor_antiguo As String
Global VA(100), VN(100)


'---------------------------------------------
' Variables FLI
'---------------------------------------------
Global Modificacion        As Boolean
Global Modificado          As Boolean
Global Anulacion           As Boolean
Global Tipo_Pago_total     As Boolean
Global Tipo_Pago_parcial   As Boolean
Global gsNmoper_Fli        As Double
Global gsControlCortes     As Double
Global gsBac_FecProxC      As Boolean
Global EstadoFli           As Boolean
Global mVarCortes          As String
Global gsdolar             As Double
Global gsBac_CargoAbono    As String
Global Cargo               As Boolean
Global MonOpVR             As Integer
Global gsBac_TituloLOG     As String
Global gscorrelativo       As Integer
Global Const gstipocartera = 0
Global iRutCar&, iTipCar%, iForPagI&, iForPagV&, sTipCus$
Global sRetiro$, sPagMan$, sObserv$, iRutCli&
Global iCodcli&
Global motBloqueoClt    As String   'PRD-6066, Control de bloqueos
Global codBloqueoClt    As Double   'PRD-6066
Public ocortes As New colCortes

Global EnviarCF As String   'PRD-9287


Global vTipoDeposito        As Variant
Global vCondicion           As Variant
Global vTipoEmision         As Variant

'+++CONTROL IDD, jcamposd marca de control linea IDD
Global MarcaAplicaLinea As Integer
'---CONTROL IDD, jcamposd marca de control linea IDD
'+++ cvegasan 2017.08.08 Control Lineas IDD
Global gsBac_Url_WebService As String
Global gsBac_Url_WebMethod As String
'--- cvegasan 2017.08.08 Control Lineas IDD


Public Function Validar_Tasa(Tip As String, Moneda As Integer, valor As Double, Optional tipo_inter As String) As Boolean
Dim Datos()
If Tip <> "IB" Then tipo_inter = " "
Envia = Array()
AddParam Envia, IIf(tipo_inter = "V", Tip & tipo_inter, Tip)
AddParam Envia, Moneda
AddParam Envia, valor



If Not Bac_Sql_Execute("SP_VALIDA_LIMITE_TASA", Envia) Then
    MsgBox ("Error al recuperar Limites de Tasa")
    Validar_Tasa = False
    Exit Function
End If

Do While Bac_SQL_Fetch(Datos())
        If Datos(1) <> "OK" Then
            MsgBox Datos(2), vbCritical
            Validar_Tasa = False
        Else
        Validar_Tasa = True
        End If
Loop
End Function


Public Sub GRABA_LOG_AUDITORIA(Entidad, Fechaproc, Terminal, Usuario, IdSistema, codigoMenu, CodigoEvento, _
 DetalleModificacion, TablaInvolucrada, ValorAntiguo, ValorNuevo As String)

 Envia = Array()

 AddParam Envia, Entidad
 AddParam Envia, Fechaproc
 'AddParam Envia, FechaSis
 'AddParam Envia, HoraProc
 AddParam Envia, Terminal
 AddParam Envia, Usuario
 AddParam Envia, IdSistema
 AddParam Envia, codigoMenu
 AddParam Envia, CodigoEvento
 AddParam Envia, DetalleModificacion
 AddParam Envia, TablaInvolucrada
 AddParam Envia, ValorAntiguo
 AddParam Envia, ValorNuevo
 

 If Not Bac_Sql_Execute(gsSQL_Database_comun & "..SP_LOG_AUDITORIA ", Envia) Then
     MsgBox "Problemas al Grabar Log de Auditoria.", vbCritical
 Else
     'grabacion exitosa
 End If
 
End Sub
Public Sub COMPARA_VALORES(VAnterior, VNuevo As String)
Dim Depura, Depura2 As String
Dim i, Co As Integer
Dim last_pos As Integer
Dim Arreglo()

Depura = VAnterior
Depura2 = VNuevo
last_pos = 1
Co = 0
i = 0

For i = 1 To Len(Depura)
    
    If Mid(Depura, i, 1) = ";" Then
            
        VA(Co) = Mid(Depura, last_pos, i - last_pos)
        
        'MsgBox VA(Co)
        
        Co = Co + 1
        last_pos = i + 1
        
    End If
Next

i = 0
last_pos = 1
Co = 0

For i = 1 To Len(Depura2)
    
    If Mid(Depura2, i, 1) = ";" Then
       
        VN(Co) = Mid(Depura2, last_pos, i - last_pos)
        
        'MsgBox VN(Co)
        
        Co = Co + 1
        last_pos = i + 1
                
    End If
Next

i = 0
ValorA = ""
ValorN = ""

For i = 0 To 100

    If VA(i) <> VN(i) Then
    
        ValorA = ValorA + " " + VA(i) & ";"
    
        ValorN = ValorN + " " + VN(i) & ";"
    
    End If

Next i

    'ValorA = "'" & ValorA & "'"
    'ValorN = "'" & ValorN & "'"

    'MsgBox ValorA
    'MsgBox ValorN

End Sub

'Public Sub COMPARA_VALORES(VAnterior, VNuevo As String)
'Dim Depura, Depura2 As String
'Dim i, Co As Integer
'Dim last_pos As Integer
'Dim Arreglo()
'
'Depura = VAnterior
'Depura2 = VNuevo
'last_pos = 1
'Co = 0
'i = 0
'
'For i = 1 To Len(Depura)
'
'    If Mid(Depura, i, 1) = ";" Then
'
'        VA(Co) = Mid(Depura, last_pos, i - last_pos)
'
'        'MsgBox VA(Co)
'
'        Co = Co + 1
'        last_pos = i + 1
'
'    End If
'Next
'
'i = 0
'last_pos = 1
'Co = 0
'
'For i = 1 To Len(Depura2)
'
'    If Mid(Depura2, i, 1) = ";" Then
'
'        VN(Co) = Mid(Depura2, last_pos, i - last_pos)
'
'        'MsgBox VN(Co)
'
'        Co = Co + 1
'        last_pos = i + 1
'
'    End If
'Next
'
'i = 0
'ValorA = ""
'ValorN = ""
'
'For i = 0 To 100
'
'    If VA(i) <> VN(i) Then
'
'        ValorA = ValorA + " " + VA(i) & ";"
'
'        ValorN = ValorN + " " + VN(i) & ";"
'
'    End If
'
'Next i
'
'    ValorA = "'" & ValorA & "'"
'    ValorN = "'" & ValorN & "'"
'
'    'MsgBox ValorA
'    'MsgBox ValorN
'
'End Sub
'
Public Function DiaSem(Fecha As Date, cTexto As Object) As String
   Dim cDia As Integer

   cTexto.ForeColor = vbBlue
   cDia = DatePart("w", Fecha)
   
   Select Case cDia
      Case 1:
          DiaSem = "Domingo"
          cTexto.ForeColor = vbRed
      Case 2:
          DiaSem = "Lunes"
      Case 3:
          DiaSem = "Martes"
      Case 4:
          DiaSem = "Miercoles"
      Case 5:
          DiaSem = "Jueves"
      Case 6:
          DiaSem = "Viernes"
      Case 7:
          DiaSem = "Sabado"
          cTexto.ForeColor = vbRed
   End Select
        
End Function

Public Function funcBuscaTipcambio(parCodmoneda As Integer, ByVal parFecha As String) As Double
Dim cSql As String
Dim Datos()

On Error GoTo ErrMoneda

    funcBuscaTipcambio = 0
    
    cSql = "SP_VMLEERIND "
    cSql = cSql & parCodmoneda & ",'"
    cSql = cSql & Trim(Format(parFecha, "yyyymmdd")) & "'"
    
    If miSQL.SQL_Execute(cSql) <> 0 Then
       Exit Function
    End If
       
    If Bac_SQL_Fetch(Datos()) Then
        funcBuscaTipcambio = CDbl(Datos(1))
    End If
    
    Exit Function

ErrMoneda:
    funcBuscaTipcambio = 0
    MsgBox "Problemas en busqueda de tipos de cambio: " & err.Description & ", Comunique al Administrador.", vbExclamation, gsBac_Version
    Exit Function
    
End Function

Public Function funcFindMonVal(comboMoneda As Object, ComboBase As Object, Tipo_Operacion As String) As Boolean
Dim cSql As String
Dim Datos()
On Error GoTo ErrMon

    funcFindMonVal = False
       Envia = Array()
       
    If Trim(Tipo_Operacion) = "" Then
        cSql = "SP_FINDBASE"

    Else
        AddParam Envia, Tipo_Operacion
        cSql = "SP_BUSCA_MON_PROD"
    
    End If
    
    If Bac_Sql_Execute(cSql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            comboMoneda.AddItem Datos(2)
            comboMoneda.ItemData(comboMoneda.NewIndex) = Datos(1)
        Loop
    Else
      MsgBox "No se pudo Cargar Monedas", vbCritical, TITSISTEMA
    End If
    
    funcFindMonVal = True
    Exit Function
    
ErrMon:
    MsgBox "Problemas en busqueda de base de monedas: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version
    Exit Function
    
End Function


 
Public Function funcBaseMoneda(parECodMoneda As Integer) As String
On Error GoTo ErrMon
Dim Datos()
    funcBaseMoneda = 0
    
    Call funcFindDatGralMoneda(parECodMoneda)
    
    Envia = Array()
    AddParam Envia, parECodMoneda
    
    If BacDatGrMon.mnmx = "C" Then '' Moneda Extranjera
        If Bac_Sql_Execute("SP_FINDBASEMONEDAMX", Envia) Then
            Do While Bac_SQL_Fetch(Datos())
                funcBaseMoneda = Datos(1)
            Loop
        End If

    Else
        If Bac_Sql_Execute("SP_FINDBASEMONEDA", Envia) Then
            Do While Bac_SQL_Fetch(Datos())
                funcBaseMoneda = Datos(1)
            Loop
        End If
    End If
    Exit Function
    
ErrMon:
    
    MsgBox "Problemas en busqueda de base de monedas: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version
    Exit Function
    
End Function

Public Function funcFindMoneda(comboMoneda As Object, Tipo_Operacion As String) As Boolean
' ByVal parEsMoneda As String, ByRef parsIBase As Integer) As Boolean
Dim cSql As String
Dim Datos()
On Error GoTo ErrMon

    funcFindMoneda = False
    
     Envia = Array(Tipo_Operacion)
        
'    cSql = "SP_BUSCA_MON_PROD '" & Tipo_Operacion & "'"
    
    If Bac_Sql_Execute("SP_BUSCA_MON_PROD", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            comboMoneda.AddItem Datos(2)
            comboMoneda.ItemData(comboMoneda.NewIndex) = Val(Datos(1))
        Loop
    End If
    
    funcFindMoneda = True
    
    Exit Function
    
ErrMon:
    MsgBox "Problemas en busqueda de base de monedas: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version
    Exit Function
    
End Function


Function Gen_Signo(nValor As Variant) As String

    If Val(nValor) >= 0 Then
        Gen_Signo = "+"
    Else
        Gen_Signo = "-"
    End If

End Function



Function AlinearCampo(Dato As Variant, nLargo As Integer, nDecima As Integer, cJustific As String) As String
Dim Daton As Variant
        
    Dato = CVar(Dato)
               
    If nDecima = 0 Then
        If UCase$(cJustific) = "N" Then
            AlinearCampo = Space(nLargo - Len(Trim$(CStr(Dato)))) + Trim$(CStr(Dato))
        Else
            AlinearCampo = Trim$(CStr(Dato)) + Space(nLargo - Len(Trim$(CStr(Dato))))
        End If
    Else
        Daton = ""
        Daton = CStr(Abs(Val(Mid$(CStr(Dato), 1, InStr(1, CStr(Dato), ".", 1) - 1))))
'            Daton = Daton '+  Mid$(CStr(Dato), InStr(1, CStr(Dato), ".", 1), 1)
        Daton = Daton + Mid$(CStr(Dato), InStr(1, CStr(Dato), ".", 1) + 1, Len(Trim$(CStr(Dato))))
        Daton = Daton + String(nDecima - Len(Mid$(Dato, InStr(1, CStr(Dato), ".", 1) + 1, Len(CStr(Dato)))), "0")
        AlinearCampo = Space(nLargo - Len(Trim$(CStr(Daton)))) + Trim$(CStr(Daton))
    End If
        
End Function


Function Cargar_SBIF()
Dim cRegistro   As String
Dim Sb_cRut     As String
Dim Sb_cDv      As String
Dim Sb_cSerie   As String
Dim Sb_cFecemi  As String
Dim Sb_cInst    As String
Dim Sb_cMoneda  As String
Dim Sb_cFactor  As String
Dim Sb_cNemo    As String
    
Dim ySerie      As String
Dim yFecha      As String
Dim yMoneda     As String
Dim yNemo       As String
Dim yInst       As String
Dim xInst       As String
    
Dim zSerie      As String
Dim yFormato    As String
Dim xFormato    As String
Dim xInst1      As String
Dim cSw         As String

Dim nCont       As Double
Dim nano        As Integer
Dim dFecha      As Date

Dim SQL         As String
Dim Datos()
Dim TB          As Recordset
Dim nMax        As Integer
Dim nTotReg     As Double

    If Dir(gsBac_DIRIN & "\Facsbif.txt") = "" Then
       MsgBox "NO se Encuentra Archivo " + gsBac_DIRIN + "FACSBIF.TXT", vbCritical, gsBac_Version
       Exit Function
    End If
    
    SQL = "DELETE * FROM SBIFEMI"
    db.Execute SQL
       
    If Bac_Sql_Execute("SP_SBIF_TRASEMISORES") Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO SBIFEMI VALUES (  " & Chr(10)
            SQL = SQL + Datos(1) + "," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "' );"
            db.Execute SQL
        Loop
    Else
        MsgBox "Problemas al Cargar Emisores en Sistema", vbCritical, gsBac_Version
        Exit Function
    End If

'    Sql = "SP_SBIF_ZAP '" + Format(gsBac_Fecp, "yyyymmdd") + "'"
    Envia = Array(Format(gsBac_Fecp, "yyyymmdd"))
      
    If Not Bac_Sql_Execute("SP_SBIF_ZAP", Envia) Then
        MsgBox "Problemas al Cargar Factores en Sistema", vbCritical, gsBac_Version
        Exit Function
    End If
        
    Open gsBac_DIRIN + "\FACSBIF.TXT" For Input As #1

    Set TB = db.OpenRecordset("sbifemi")
    
    nCont = 0
    Do While Not EOF(1)
    
        Line Input #1, cRegistro
        
        If nCont = 0 Then
        
            nCont = 1
            nMax = Val(Mid$(cRegistro, 13, 9)) / 2
            nTotReg = Val(Mid$(cRegistro, 13, 9))
            BacProc.Termo.FloodPercent = nMax / 1000
            
            If Val(Mid$(cRegistro, 9, 2)) <> Month(gsBac_Fecp) Then
                MsgBox "Archivo de Factores no Corresponde al Mes", vbCritical, gsBac_Version
                Close #1
                Exit Function
            End If
            
        Else
        
            If nCont Mod 2 = 0 And nCont <= nTotReg Then
                BacProc.Termo.FloodPercent = nCont / 2
            End If
            
            Sb_cRut = Mid$(cRegistro, 1, 9)
            Sb_cDv = Mid$(cRegistro, 10, 1)
            Sb_cSerie = Mid$(cRegistro, 11, 20)
            
            If Val(Mid$(cRegistro, 31, 4)) > 1900 And Val(Mid$(cRegistro, 37, 2)) > 0 And Val(Mid$(cRegistro, 35, 2)) > 0 Then
                Sb_cFecemi = CDate(Mid$(cRegistro, 37, 2) + "/" + Mid$(cRegistro, 35, 2) + "/" + Mid$(cRegistro, 31, 4))
            Else
                Sb_cFecemi = Space(8)
            End If
            
            Sb_cInst = Mid$(cRegistro, 39, 3)
            Sb_cMoneda = Mid$(cRegistro, 42, 1)
            Sb_cFactor = Val(Mid$(cRegistro, 43, 17)) / 100000
            Sb_cNemo = BacStrTran(Mid$(cRegistro, 60, 7), "'", " ")
        
            ySerie = Mid$(cRegistro, 11, 20)
            yFecha = Mid$(cRegistro, 31, 8)
            yInst = Mid$(cRegistro, 39, 3)
            yMoneda = Mid$(cRegistro, 42, 1)
            yNemo = BacStrTran(Mid$(cRegistro, 60, 7), "'", " ")
            xInst = Space(10)
                
            If Mid$(Sb_cSerie, 1, 3) = "PRD" Then
                xInst = RTrim(Sb_cSerie)
                ySerie = "PRD"
                
            ElseIf yInst = "DEB" Then
                If Len("B" + RTrim(Sb_cNemo) + "-" + RTrim(Sb_cSerie)) <= 10 Then
                    xInst = "B" + RTrim(Sb_cNemo) + "-" + RTrim(Sb_cSerie)
                Else
                    xInst = RTrim(Sb_cNemo) + "-" + RTrim(Sb_cSerie)
                End If
                
            ElseIf Mid$(ySerie, 1, 3) = "PTF" And yInst = "PRC" Then
                xInst = Mid$(ySerie, 1, 3) + "-" + Mid$(ySerie, 4, 1) + " " + Mid$(yFecha, 5, 2) + Mid$(yFecha, 3, 2)
            
            ElseIf Mid$(ySerie, 1, 3) = "PDP" And xInst = "PRC" Then
                xInst = Trim(ySerie)
            
            ElseIf yInst = "BRP" Then
                xInst = Trim(ySerie)
            
            ElseIf Mid$(ySerie, 1, 3) = "PCD" And yMoneda = "1" Then
                xInst = Trim(ySerie) + Mid$(yFecha, 7, 2) + Mid$(yFecha, 5, 2) + Mid$(yFecha, 3, 2)
            
            ElseIf Mid$(ySerie, 1, 3) = "PCD" And yMoneda = "2" Then
                xInst = Mid$(Trim(ySerie), 1, 3) + "US$" + Mid$(Trim(ySerie), 4, 4)
            
            ElseIf yInst = "PRC" And yMoneda = "1" And Mid$(ySerie, 1, 1) <> "P" Then
                xInst = Trim(yInst) + "-" + Trim(ySerie)
            
            ElseIf yInst = "LHF" Then
        
                TB.Seek "=", Val(Sb_cRut)
                If TB.NoMatch = False Then
                    yFormato = TB!Glosa
                Else
                    yFormato = ""
                End If

                Do While Len(yFormato) > 0
                
                    If InStr(ySerie, Chr(209)) > 0 Then
                        ySerie = Mid$(ySerie, 1, InStr(ySerie, Chr(209)) - 1)
                    End If
               
                    ySerie = Trim(ySerie)
                    zSerie = ySerie
               
                    If Len(ySerie) = 1 Then
                        zSerie = "-" + ySerie
                    End If
                    If InStr(yFormato, ";") = 0 Then
                        xFormato = yFormato
                    Else
                        xFormato = Mid$(yFormato, 1, InStr(yFormato, ";") - 1)
                    End If
                    xInst1 = xFormato + zSerie

                    If Len(xInst1) = 6 Or InStr(xInst1, "-") > 0 Then
                        xInst = xInst1
                        Exit Do
                    Else
                        If Len(xInst1) = 5 Then
'                            Sql = "SP_SBIF_CARGAFAC"
'                            Sql = Sql + Sb_cRut + ","
'                            Sql = Sql + "'" + Sb_cDv + "',"
'                            Sql = Sql + "'" + Sb_cSerie + "',"
'                            Sql = Sql + "'" + Format(Sb_cFecemi, "mm/dd/yyyy") + "',"
'                            Sql = Sql + "'" + Sb_cInst + "',"
'                            Sql = Sql + "'" + Sb_cMoneda + "',"
'                            Sql = Sql + Str$(Sb_cFactor) + ","
'                            Sql = Sql + "'" + Sb_cNemo + "',"
'                            Sql = Sql + "'" + xFormato + "-" + ySerie + "'"
                            
                            Envia = Array(CDbl(Sb_cRut), _
                                    Sb_cDv, _
                                    Sb_cSerie, _
                                    Format(Sb_cFecemi, "mm/dd/yyyy"), _
                                    Sb_cInst, _
                                    Sb_cMoneda, _
                                    CDbl(Sb_cFactor), _
                                    Sb_cNemo, _
                                    xFormato + "-" + ySerie)
        
                            If Not Bac_Sql_Execute("SP_SBIF_CARGAFAC", Envia) Then
                                MsgBox "Problemas en el Traspaso de Factores al Sistema", vbCritical, gsBac_Version
                                Exit Function
                            End If
                            Exit Do
                        ElseIf Len(xInst1) < 5 Or Len(xInst1) > 6 Then
                                xInst = ""
                                yFormato = Mid$(yFormato, InStr(yFormato, ";") + 1)
                        End If
                    End If
                Loop
                
            ElseIf yInst = "BSF" Or yInst = "BEF" Then
         
                'DEB Bonos Terceros
                'BSF Bonos Subordinados
                'BEF Bonos Entidades Financieras
             
                TB.Seek "=", Val(Sb_cRut)
                If TB.NoMatch = False Then
                    yFormato = TB!bonos
                Else
                    yFormato = ""
                End If

                Do While Len(yFormato) > 0
            
                    ySerie = Trim(ySerie)
                    zSerie = ySerie
                    xFormato = Mid$(yFormato, 1, InStr(yFormato, ";") - 1)
                    yFormato = Mid$(yFormato, InStr(yFormato, ";") + 1)
               
                    cSw = "1"
                    Do While cSw = "1"

                        xInst = ""
                        xInst1 = xFormato + ySerie

                        If Len(xInst1) >= 6 And (yInst = "BSF" Or yInst = "BEF") Then
                        
                            xInst1 = Mid$(xInst1, 1, 6)
                     
'                            Sql = "SP_SBIF_CARGAFAC "
'                            Sql = Sql + Sb_cRut + ","
'                            Sql = Sql + "'" + Sb_cDv + "',"
'                            Sql = Sql + "'" + Sb_cSerie + "',"
'                            Sql = Sql + "'" + Format(Sb_cFecemi, "mm/dd/yyyy") + "',"
'                            Sql = Sql + "'" + Sb_cInst + "',"
'                            Sql = Sql + "'" + Sb_cMoneda + "',"
'                            Sql = Sql + Str$(Sb_cFactor) + ","
'                            Sql = Sql + "'" + Sb_cNemo + "',"
'                            Sql = Sql + "'" + xInst1 + "'"
                            
                            Envia = Array(CDbl(Sb_cRut), _
                                    Sb_cDv, _
                                    Sb_cSerie, _
                                    Format(Sb_cFecemi, "mm/dd/yyyy"), _
                                    Sb_cInst, _
                                    Sb_cMoneda, _
                                    CDbl(Sb_cFactor), _
                                    Sb_cNemo, _
                                    xInst1)
                                    
                            If Not Bac_Sql_Execute("SP_SBIF_CARGAFAC", Envia) Then
                                MsgBox "Problemas en el Traspaso de Factores al Sistema", vbCritical, gsBac_Version
                                Exit Function
                            End If
                     
                            Exit Do
                        Else
                            If Len(xInst1) = 5 Then
                     
                                xInst1 = xFormato + ySerie
                        
'                                Sql = "SP_SBIF_CARGAFAC "
'                                Sql = Sql + Sb_cRut + ","
'                                Sql = Sql + "'" + Sb_cDv + "',"
'                                Sql = Sql + "'" + Sb_cSerie + "',"
'                                Sql = Sql + "'" + Format(Sb_cFecemi, "mm/dd/yyyy") + "',"
'                                Sql = Sql + "'" + Sb_cInst + "',"
'                                Sql = Sql + "'" + Sb_cMoneda + "',"
'                                Sql = Sql + Str$(Sb_cFactor) + ","
'                                Sql = Sql + "'" + Sb_cNemo + "',"
'                                Sql = Sql + "'" + xInst1 + "'"
                                
                                Envia = Array(CDbl(Sb_cRut), _
                                        Sb_cDv, _
                                        Sb_cSerie, _
                                        Format(Sb_cFecemi, "mm/dd/yyyy"), _
                                        Sb_cInst, _
                                        Sb_cMoneda, _
                                        CDbl(Sb_cFactor), _
                                        Sb_cNemo, _
                                        xInst1)
        
                                If Not Bac_Sql_Execute("SP_SBIF_CARGAFAC", Envia) Then
                                    MsgBox "Problemas en el Traspaso de Factores al Sistema", vbCritical, gsBac_Version
                                    Exit Function
                                End If
                        
                                xInst1 = xFormato + "-" + ySerie
                        
'                                Sql = "SP_SBIF_CARGAFAC "
'                                Sql = Sql + Sb_cRut + ","
'                                Sql = Sql + "'" + Sb_cDv + "',"
'                                Sql = Sql + "'" + Sb_cSerie + "',"
'                                Sql = Sql + "'" + Format(Sb_cFecemi, "mm/dd/yyyy") + "',"
'                                Sql = Sql + "'" + Sb_cInst + "',"
'                                Sql = Sql + "'" + Sb_cMoneda + "',"
'                                Sql = Sql + Str$(Sb_cFactor) + ","
'                                Sql = Sql + "'" + Sb_cNemo + "',"
'                                Sql = Sql + "'" + xInst1 + "'"
                                
                                Envia = Array(CDbl(Sb_cRut), _
                                        Sb_cDv, _
                                        Sb_cSerie, _
                                        Format(Sb_cFecemi, "mm/dd/yyyy"), _
                                        Sb_cInst, _
                                        Sb_cMoneda, _
                                        CDbl(Sb_cFactor), _
                                        Sb_cNemo, _
                                        xInst1)
                                        
                                If Not Bac_Sql_Execute("SP_SBIF_CARGAFAC", Envia) Then
                                    MsgBox "Problemas en el Traspaso de Factores al Sistema", vbCritical, gsBac_Version
                                    Exit Function
                                End If
                        
                                Exit Do
                            Else
                            
                                xInst1 = xFormato + "-" + ySerie
                        
'                                Sql = "SP_SBIF_CARGAFAC "
'                                Sql = Sql + Sb_cRut + ","
'                                Sql = Sql + "'" + Sb_cDv + "',"
'                                Sql = Sql + "'" + Sb_cSerie + "',"
'                                Sql = Sql + "'" + Format(Sb_cFecemi, "mm/dd/yyyy") + "',"
'                                Sql = Sql + "'" + Sb_cInst + "',"
'                                Sql = Sql + "'" + Sb_cMoneda + "',"
'                                Sql = Sql + Str$(Sb_cFactor) + ","
'                                Sql = Sql + "'" + Sb_cNemo + "',"
'                                Sql = Sql + "'" + xInst1 + "'"
                                
                                Envia = Array(CDbl(Sb_cRut), _
                                        Sb_cDv, _
                                        Sb_cSerie, _
                                        Format(Sb_cFecemi, "mm/dd/yyyy"), _
                                        Sb_cInst, _
                                        Sb_cMoneda, _
                                        CDbl(Sb_cFactor), _
                                        Sb_cNemo, _
                                        xInst1)
       
                                If Not Bac_Sql_Execute("SP_SBIF_CARGAFAC", Envia) Then
                                    MsgBox "Problemas en el Traspaso de Factores al Sistema", vbCritical, gsBac_Version
                                    Exit Function
                                End If
                                               
                                Exit Do
                            End If
                        End If
                    Loop
                Loop
            Else
                xInst = Space(10)
            End If
            
'            Sql = "SP_SBIF_CARGAFAC "
'            Sql = Sql + Sb_cRut + ","
'            Sql = Sql + "'" + Sb_cDv + "',"
'            Sql = Sql + "'" + Sb_cSerie + "',"
'            Sql = Sql + "'" + Format(Sb_cFecemi, "mm/dd/yyyy") + "',"
'            Sql = Sql + "'" + Sb_cInst + "',"
'            Sql = Sql + "'" + Sb_cMoneda + "',"
'            Sql = Sql + Str$(Sb_cFactor) + ","
'            Sql = Sql + "'" + Sb_cNemo + "',"
'            Sql = Sql + "'" + xInst + "'"
        
            Envia = Array(CDbl(Sb_cRut), _
                    Sb_cDv, _
                    Sb_cSerie, _
                    Format(Sb_cFecemi, "mm/dd/yyyy"), _
                    Sb_cInst, _
                    Sb_cMoneda, _
                    CDbl(Sb_cFactor), _
                    Sb_cNemo, _
                    xInst1)
        
            If Not Bac_Sql_Execute("SP_SBIF_CARGAFAC", Envia) Then
                MsgBox "Problemas en el Traspaso de Factores al Sistema", vbCritical, gsBac_Version
                Close #1
                Exit Function
            End If
            
        End If
        
        nCont = nCont + 1
        
    Loop
    
    TB.Close
    
    Close #1
    
    MsgBox "Carga Factores SBIF Terminada Correctamente", vbInformation, gsBac_Version

End Function


Sub ContabTM()
Dim cReg As String
Dim cCon As Boolean
Dim Datos()
   
'    Sql = "SP_CONTTM" & Chr(10)
'    Sql = Sql & gsBac_User & "," & Chr(10)
'    Sql = Sql & "'" & gsBac_Term & "'"

    Envia = Array(gsBac_User, gsBac_Term)
      
    If Not Bac_Sql_Execute("SP_CONTTM", Envia) Then
        MsgBox "Problemas en el Traspaso de Valorización SBIF", vbCritical, gsBac_Version
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        If UBound(Datos()) = 2 Then
            cCon = True
            MsgBox CStr(Datos(2)), vbInformation, gsBac_Version
            Exit Do
        End If
    Loop
    
    If cCon = False Then
        MsgBox "Traspaso de Valorización Mercado SBIF Correctamente", vbInformation, gsBac_Version
    End If

End Sub







Function RC_GrabarTx(RutCar$, Numoper$, TasaPacto$, ValorVen$, Forpav$, dValorActual#, nTasaTran#, nVPTran#, nDifTran#)
Dim Datos()
Dim cTipOper    As String * 3

'Para Control de Precios y Tasas
Dim ptcodProd As String
Dim ptPlazo As Integer
Dim ptTasa As Double
Dim ptTipoOp As String
Dim ptMoneda As String
Dim resControlPT As String

On Error GoTo RC_GrabarTx

    cTipOper = Mid$(BacTrader.ActiveForm.Tag, 1, 2) + "A"
    
    Envia = Array()
    AddParam Envia, CDbl(RutCar)
    AddParam Envia, CDbl(Numoper)
    AddParam Envia, CDbl(TasaPacto)
    AddParam Envia, CDbl(ValorVen)
    AddParam Envia, gsBac_User
    AddParam Envia, gsBac_Term
    AddParam Envia, CDbl(Forpav)
    AddParam Envia, nTasaTran#
    AddParam Envia, nVPTran#
    AddParam Envia, nDifTran
    AddParam Envia, nDifTran 'se envia dos veces este valor debido a que ya esta en pesos
    
    If Mid$(BacTrader.ActiveForm.Tag, 1, 2) = "RC" Then
        If Not Bac_Sql_Execute("SP_GRABARRCA", Envia) Then
           GoTo RC_GrabarTx
           Exit Function
        End If
    ElseIf Mid$(BacTrader.ActiveForm.Tag, 1, 2) = "RV" Then
        If Not Bac_Sql_Execute("SP_GRABARRVA", Envia) Then
           GoTo RC_GrabarTx
           Exit Function
        End If
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        RC_GrabarTx = Datos(1)
    End If
   
    Valor_antiguo = ""
    Valor_antiguo = "Operacion:" & Numoper & ";" & IIf(Mid$(BacTrader.ActiveForm.Tag, 1, 2) = "RV", "RVA", "RCA") & ";Forma de Pago Inicio:0;" & "Forma de Pago Venc:" & Forpav & "tasa Pacto:" & TasaPacto
    
    'Aplicar Control de Precios y Tasas, Grabación
    ptcodProd = Mid$(BacTrader.ActiveForm.Tag, 1, 2)
    ptTipoOp = Mid$(ptcodProd, 2, 1)
    ptTasa = CDbl(TasaPacto)
    
    resControlPT = ControlPreciosTasas(ptcodProd, Ctrlpt_Moneda, Ctrlpt_Plazo, ptTasa, False)
    If Ctrlpt_AplicarControl Then
    If Ctrlpt_ModoOperacion = "S" Then
        'Modo silencioso
        Ctrlpt_codProducto = ptcodProd
        Ctrlpt_NumOp = Numoper
        Ctrlpt_NumDocu = ""
        Ctrlpt_TipoOp = ptTipoOp
        Ctrlpt_Correlativo = 1
        Call GrabaModoSilencioso
    Else
        'grabar el instrumento ssi enviarCF = "S"
        If EnviarCF = "S" Then
        Ctrlpt_codProducto = ptcodProd
        Ctrlpt_NumOp = Numoper
        Ctrlpt_NumDocu = ""
        Ctrlpt_TipoOp = ptTipoOp
        Ctrlpt_Correlativo = 1
        Call GrabaLineaPendPrecios
                Call GrabaModoSilencioso    '--> PRD-10494 Incidencia 1
    End If
    End If
    End If
    
    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, _
     "BTR", IIf(Mid$(BacTrader.ActiveForm.Tag, 1, 2) = "RC", "Opc_20500", "Opc_20600"), "01", IIf(Mid$(BacTrader.ActiveForm.Tag, 1, 2) = "RC", "RECOMPRA ANTICIPADA", "REVENTA ANTICIPADA"), "mdmo", Valor_antiguo, " ")

   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Operacion de recompra anticipada numero: " & Numoper$ & ", grabada con exito")
    
   Exit Function

RC_GrabarTx:

    MsgBox "NO SE COMPLETO LA GRABACION DE " + IIf(Mid$(BacTrader.ActiveForm.Tag, 1, 2) = "RC", "RECOMPRAS", "REVENTAS") + " CON EXITO: " & err.Description, vbExclamation, gsBac_Version
    RC_GrabarTx = 0
    Exit Function
        
End Function



Public Function EsFeriado(Fecha As Date, plaza As String) As Boolean
Dim cFeriados As String
Dim nDia      As Integer
Dim nDiaF     As String
Dim Datos()
  
    nDia = Day(Fecha)
    'plaza = 1
    plaza = 6
    'SP_ESFERIADO '" & Format(Fecha, "mm/dd/yyyy") & "', " & Val(plaza)
    nDiaF = ""
    Envia = Array()
    AddParam Envia, Format(Fecha, "yyyymmdd")
    AddParam Envia, Val(plaza)
    If Not Bac_Sql_Execute("SP_ESFERIADO ", Envia) Then
        MsgBox "No se pudo determinar feriado", vbCritical, gsBac_Version
        EsFeriado = True
        Exit Function
    End If
  
    Do While Bac_SQL_Fetch(Datos())
        cFeriados = Datos(1)
    Loop

    If Len(Trim$(Str(nDia))) = 1 Then
        nDiaF = "0" + Trim$(Str(nDia))
    Else
        nDiaF = Trim$(Str(nDia))
    End If
  
    If InStr(cFeriados, Trim$(nDiaF)) Then
        EsFeriado = True
    Else
        EsFeriado = False
    End If
    
    If DatePart("w", Fecha) = vbSunday Or DatePart("w", Fecha) = vbSaturday Then
        EsFeriado = True
    End If
  
End Function
Function IB_GrabarTx(RutCar$, TipCar$, Forpai$, Forpav$, Retiro$, Pagom$, Observ$, RutCli$, CodCli&, BacFrm As Form, valuta$, Codigo_Libro$, AreaResp$, Ejecutivo$, Sucursal$, Rentabilidad, nmtoini_um, sTipo_Interfaz, Garantia, correla, Ind1446)

Dim sTipOper    As String
Dim sNumero     As String
Dim dNumdocu    As Double
Dim nPlazo      As Long    '--> Se Modifico
Dim iCodigo     As Integer
Dim Datos()
Dim cMascara    As String
Dim iCodAux     As Integer
Dim nMonto      As Double

'Para Control de Precios y Tasas
Dim ptPlazo As Integer
Dim ptMoneda As Integer
Dim ptTasa As Double
Dim resControlPT As String
Dim Mensaje_CPT As String
Dim optx As String
Dim nMonedaIcolOpe As Integer

    If BacFrm.ChkCol.Value = True Then
        sTipOper$ = "ICOL"
        iCodigo = 992
    Else
        sTipOper$ = "ICAP"
        iCodigo = 993
    End If
    
    
    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then

        Dim Mensaje     As String
        Dim nparidad    As Double
'------------------------------------------------
        iCodAux = iCodigo
        
        Envia = Array()
        AddParam Envia, sTipOper
        AddParam Envia, Forpai
        AddParam Envia, Forpav
        AddParam Envia, Format(BacFrm.Dtefecven.text, "yyyymmdd")
        
        If Not Bac_Sql_Execute("SP_MASCARAINTER", Envia) Then
            MsgBox "Sql-Server No Responde. Intentelo Nuevamente", 16, "BacTrader"
            Exit Function
        End If
                
        If Bac_SQL_Fetch(Datos()) Then
            cMascara = Datos(1)
            iCodAux = Datos(2)
        End If

'------------------------------------------------
        Mensaje = ""
        nparidad = FUNC_BUSCA_VALOR_MONEDA(CDbl(BacFrm.CmbMoneda.ItemData(BacFrm.CmbMoneda.ListIndex)), Format(gsBac_Fecp, "DD/MM/YYYY"))
            
        If CDbl(BacFrm.CmbMoneda.ItemData(BacFrm.CmbMoneda.ListIndex)) = 13 Then
            nMonto = CDbl(BacFrm.FltMtoini.text) * gsBac_TCambio
        ElseIf CDbl(BacFrm.CmbMoneda.ItemData(BacFrm.CmbMoneda.ListIndex)) <> 999 Then
            nMonto = CDbl(BacFrm.FltMtoini.text) * nparidad
        Else
            nMonto = CDbl(BacFrm.FltMtoini.text)
        End If
        '+++COLTROL IDD, jcamposd necesitamos la moneda para la generación del xml
        If sTipOper$ = "ICOL" Then
            nMonedaIcolOpe = CDbl(BacFrm.CmbMoneda.ItemData(BacFrm.CmbMoneda.ListIndex))
        Else
            nMonedaIcolOpe = 0
        End If
        '---COLTROL IDD, jcamposd necesitamos la moneda para la generación del xml
        
        If Not Lineas_ChequearGrabar("BTR", sTipOper, BacFrm.hWnd, BacFrm.hWnd, 1, CDbl(RutCli), CDbl(CodCli), nMonto, gsBac_TCambio, BacFrm.Dtefecven.text, 0, CDbl(BacFrm.CmbMoneda.ItemData(BacFrm.CmbMoneda.ListIndex)), BacFrm.Dtefecven.text, iCodAux, "N", nMonedaIcolOpe, "C", 0, "N", 0, gsBac_Fecp, 0, CDbl(Forpai), CDbl(BacFrm.FltTasa.text), CDbl(BacFrm.FltTasa.text), sTipOper$) Then
            GoTo BacErrorHandlerIB
        End If
        
        Mensaje = Mensaje & Lineas_Chequear("BTR", sTipOper, BacFrm.hWnd, " ", " ", " ")
        
        If Mensaje <> "" Then
        
            MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical
            
            IB_GrabarTx = 0
            
            Exit Function
            
        End If
    
    End If
    '********** Fin

    'PRD-3860
    If Ctrlpt_ModoOperacion = "S" Then
        Mensaje_CPT = ""
    Else
        Mensaje_CPT = Ctrlpt_Mensaje
    End If
    If Trim(Mensaje_CPT) <> "" Then
        If Trim(Mensaje) <> "" Then
            Mensaje_CPT = vbCrLf & vbCrLf & Mensaje_CPT
        End If
    End If
      'fin PRD-3860


    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then

       Dim Mensaje_Con As String
       Dim SwResp      As Integer

       Mensaje_Con = Lineas_ConsultaOperacion("BTR", sTipOper, BacFrm.hWnd, " ", " ", " ") & Mensaje_CPT

      If Trim(Mensaje_Con) = "" And InStr(1, UCase(Mensaje_Con), "OK") > 0 Then
        If Trim(Mensaje_Con) <> "OK" Then
           SwResp = MsgBox("ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", vbYesNo + vbExclamation, BacFrm.Caption)

           If SwResp <> vbYes Then
           
               Call Lineas_BorraConsultaOperacion("BTR", BacFrm.hWnd)

               Exit Function

           End If
           End If
           

       End If


    End If
    '********** Fin
  
    'LD1-COR-035
    '*******************************************************************************
    '**********  Validación de Limite de Endeudamiento  ****************************
    '*******************************************************************************
    Dim VALIDA_AMBOS As Boolean
     Dim Tipo_porcentaje As Integer
    
    Grt_Garantizar = False
    VALIDA_AMBOS = False
    nPlazo = DateDiff("D", Format(gsBac_Fecp, "dd/mm/yyyy"), Format(BacFrm.Dtefecven.text, "dd/mm/yyyy"))

    Grt_Garantia = 0
    Grt_GarantiaX = 0
    Grt_GarantiaOpc = 0

    If sTipOper$ = "ICAP" And CDbl(nPlazo) < 365 Then
        Grt_Plazo = CDbl(nPlazo)
        Grt_Garantia = 0
        Grt_GarantiaX = 1
        Grt_GarantiaOpc = 0
        Grt_Entidad = 1 'Capital BKB
        Tipo_porcentaje = 1

        'Do While (Grt_Garantia <> Grt_GarantiaX And VALIDA_AMBOS = False)
        
        Do While (VALIDA_AMBOS = False)
            Grt_Garantia = 0
            Grt_GarantiaX = 1

            If Not Chequea_Lineas_End(gsSistema, sTipOper, RutCli, CodCli, BacFrm.FltMtoini.text, Grt_Entidad, Tipo_porcentaje) Then Exit Function

                Select Case Grt_Datos
                
                Case 0
                       
                    If Not Grt_Garantizar Then
                      MsgBox "Operación esta Correcta. Si desea Garantizar Operación con Documentos, ingrese al módulo de garantía: garantias.corpbanca.cl", vbExclamation, gsBac_Version
                       
                      Else
                        If (BacFrm.chkgaran.Value = 1) Then
                           MsgBox "Debe Garantizar ya que marco esta operacion con Garantias", 16, TITSISTEMA
                           BacIrfGr.Toolbar1.Buttons(2).Enabled = True
                           Exit Function
                        Else
                           Grt_Garantizar = False
                        End If
                      End If
                   
                    Grt_GarantiaX = Grt_Garantia
                    VALIDA_AMBOS = True
                    
                Case 1
                
                    If MsgBox(Grt_Mensaje & Grt_MensPreg, vbQuestion + vbYesNo, TITSISTEMA) <> vbYes Then
                         MsgBox Grt_Mensaje & " . Debe Garantizar Operación con Documentos en módulo de garantías garantias.corpbanca.cl", 16, TITSISTEMA
                            Grt_Garantizar = False
                           
                            If Not Grt_Garantizar Then Exit Function
                            BacFrm.chkgaran.Value = 1 'Cbg
                            VALIDA_AMBOS = True
                        'Else
                           ' BacIrfGr.Toolbar1.Buttons(2).Enabled = True
                           ' Exit Function
                       ' End If
                    Else
                        If Grt_Entidad = 1 Then
                            Grt_Entidad = 2 'Capital Cliente
                        Else
                            Grt_Entidad = 1 'Capital BKB
                        End If
                    End If

                Case 2
                
                     MsgBox Grt_Mensaje & " . Debe Garantizar Operación con Documentos en módulo de garantías garantias.corpbanca.cl", 16, TITSISTEMA
                        Grt_Garantizar = False
                       
                        If Not Grt_Garantizar Then
                           IB_GrabarTx = 0
                           Exit Function
                        End If
                        BacFrm.chkgaran.Value = 1 'Cbg
                        Grt_Entidad = 1 'Capital BKB
                        Tipo_porcentaje = 2
                        VALIDA_AMBOS = False
                        
                                                                       
                   ' Else
                        'BacIrfGr.Toolbar1.Buttons(2).Enabled = True
                       ' IB_GrabarTx = 0
                       ' Exit Function
                    'End If
                    
                Case 3
                
                     ' Validacion del 10 % ok ahora debe validar 3 %
                       Tipo_porcentaje = 2
                       VALIDA_AMBOS = False

 '                   MsgBox Grt_Mensaje, 16, TITSISTEMA
'                    IB_GrabarTx = 0
 '                   Exit Function

                End Select
        Loop

    End If
'
'    '*******************************************************************************
'    '**********  Fin de la Validación  *********************************************
'    '*******************************************************************************
    
  
  ' Obtengo Numero de operación
  ' -----------------------------------------------------------------------------
    If Not Bac_Sql_Execute("SP_OPMDAC") Then
        GoTo BacErrorHandlerIB
    End If
                
    If Bac_SQL_Fetch(Datos()) Then
        dNumdocu = Val(Datos(1))
    End If
  ' =============================================================================
        
    nPlazo = DateDiff("D", Format(gsBac_Fecp, "dd/mm/yyyy"), Format(BacFrm.Dtefecven.text, "dd/mm/yyyy"))

    Envia = Array(dNumdocu, _
            Format(gsBac_Fecp, "yyyymmdd"), _
            CDbl(RutCar), _
            TipCar, _
            sTipOper, _
            Format(BacFrm.Dtefecven.text, "yyyymmdd"), _
            CDbl(BacFrm.FltMtoini.text), _
            CDbl(BacFrm.Lbl_ValMon.Caption), _
            CDbl(BacFrm.FltTasa.text), _
            CDbl(BacFrm.Lbl_Mt_Final.Caption), _
            CDbl(BacFrm.IntBase.text), _
            CDbl(BacFrm.CmbMoneda.ItemData(BacFrm.CmbMoneda.ListIndex)), _
            Forpai, _
            Forpav, _
            Pagom, _
            CDbl(RutCli), _
            CDbl(CodCli), _
            Retiro, _
            gsBac_User, _
            Observ$, _
            valuta, _
            Codigo_Libro$, _
            AreaResp$, _
            Ejecutivo$, Sucursal$, Rentabilidad, nmtoini_um, sTipo_Interfaz, Garantia, correla, Ind1446)

    If Not Bac_Sql_Execute("SP_GRABAINTERBANCARIO", Envia) Then
        Exit Function
    End If
        
    Do While Bac_SQL_Fetch(Datos())
        IB_GrabarTx = Val(Datos(1))
        dNumdocu = Val(Datos(1))
    Loop
    
    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then
    
        If Not Lineas_GrbOperacion("BTR", sTipOper, BacFrm.hWnd, dNumdocu, " ", " ", " ") Then
            GoTo BacErrorHandlerIB
        End If
        
        '+++CONTROL IDD, jcamposd solo las operaciones IB, ICOL controlan línea
        If sTipOper$ = "ICOL" And MarcaAplicaLinea = 1 Then
            Dim nmontoIcolArt84 As Double
            Dim nmontoFinalArt84 As Double
            Dim dblTipoCambioArt84 As Double
            
            Dim oParametrosLinea As New clsControlLineaIDD

            With oParametrosLinea
                .Modulo = "BTR"
                .Producto = "ICOL"
                .Operacion = dNumdocu
                .Documento = dNumdocu
                .Correlativo = 1
                .Accion = "Y"

                .RecuperaDatosLineaIDD
                
                nmontoIcolArt84 = CDbl(BacInter.FltMtoini.text)
                
                    If BacInter.CmbMoneda.text = "CLP" Then
                        nmontoFinalArt84 = nmontoIcolArt84
                    Else
                        dblTipoCambioArt84 = dblTraeTipoCambio(CLng(BacInter.CmbMoneda.ItemData(BacInter.CmbMoneda.ListIndex)))
                        nmontoFinalArt84 = CDbl(BacInter.FltMtoini.text) * dblTipoCambioArt84
                    End If
                nmontoIcolArt84 = Round(nmontoFinalArt84, 0)
                
                .MontoArticulo84 = nmontoIcolArt84 'debe enviar el valor calculado
                
                .EjecutaProcesoWsLineaIDD
            End With
            Set oParametrosLinea = Nothing
            On Error GoTo seguirGbrICOL

        '---CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
        
        End If
        '---CONTROL IDD, jcamposd solo las operaciones IB, ICOL controlan línea
    End If
    '********** Fin
seguirGbrICOL:
  
    Valor_antiguo = " "
    Valor_antiguo = "Operacion:" & dNumdocu & ";" & sTipOper & ";" & "Rut Cliente:" & RutCli & ";Codigo Cliente:" & CodCli & ";Forma de Pago Inicio:" & Forpai & ";Forma de Pago Venc:" & Forpav & ";Tasa Pacto:" & CDbl(BacFrm.FltTasa.text)
    
    'Control de Precios y Tasas
    ptMoneda = BacFrm.CmbMoneda.ItemData(BacFrm.CmbMoneda.ListIndex)
    ptTasa = BacFrm.FltTasa.text
    ptPlazo = BacFrm.Intdias.text
    If BacFrm.ChkCol.Value = True Then
        optx = "ICOL"
    Else
        optx = "ICAP"
    End If
    'resControlPT = ControlPreciosTasas("IB", ptMoneda, ptPlazo, ptTasa, False)
    resControlPT = ControlPreciosTasas(optx, ptMoneda, ptPlazo, ptTasa, False)
    If Ctrlpt_AplicarControl Then
    If Ctrlpt_ModoOperacion = "S" Then
        'Modo silencioso
        Ctrlpt_codProducto = "IB"   'sTipOper$
        Ctrlpt_NumOp = dNumdocu
        Ctrlpt_NumDocu = ""
            Ctrlpt_TipoOp = IIf(optx = "ICOL", "V", "C")
        Ctrlpt_Correlativo = 1
        Call GrabaModoSilencioso
    Else
        'grabar el instrumento ssi EnviarCF = "S"
        If EnviarCF = "S" Then
        Ctrlpt_codProducto = "IB"   'sTipOper$
        Ctrlpt_NumOp = dNumdocu
        Ctrlpt_NumDocu = ""
            Ctrlpt_TipoOp = IIf(optx = "ICOL", "V", "C")
        Ctrlpt_Correlativo = 1
        Call GrabaLineaPendPrecios
                Call GrabaModoSilencioso    '--> PRD-10494 Incidencia 1
    End If
    End If
    
    '******************************************************************************
'**************  Graba Limite de Endeudamiento  *******************************
'******************************************************************************

  
    Dim nMtoDeuda#
    

    If sTipOper$ = "ICAP" And CDbl(nPlazo) < 365 Then

        nMtoDeuda = CDbl(BacFrm.FltMtoini.text)

        If Grt_GarantiaX > 0 Then
            nMtoDeuda = CDbl(BacFrm.FltMtoini.text) - Grt_GarantiaX
        Else
            nMtoDeuda = CDbl(BacFrm.FltMtoini.text) - Grt_GarantiaOpc
        End If

        If nMtoDeuda < 0 Then
            nMtoDeuda = 0
        End If

        Envia = Array()
        AddParam Envia, dNumdocu                                            ' Nº Operacion
        AddParam Envia, CDbl(RutCli)                                        ' Rut Cliente
        AddParam Envia, CDbl(CodCli)                                        ' Codigo Cliente
        AddParam Envia, nMtoDeuda                                           ' Monto Operacion
        AddParam Envia, Grt_GarantiaX                                       ' Exceso
        AddParam Envia, gsUsuario                                           ' Operador
        AddParam Envia, nMtoDeuda                                           ' Monto Deuda
        AddParam Envia, sTipOper$                                           ' Tipo Operacion
        AddParam Envia, Grt_Mensaje                                         ' Mensaje
        AddParam Envia, Format(BacFrm.Dtefecven.text, "yyyymmdd")           ' Fecha de Vcto
        AddParam Envia, CDbl(nPlazo)                                        ' Plazo

        If Not Bac_Sql_Execute(giSQL_DatabaseCommon & "..Sp_GrbLimite_Deuda", Envia) Then
            MsgBox "Problemas al Grabar Limites de Endeudamiento", 16, TITSISTEMA
            Exit Function
        End If

    End If
    '******************************************************************************
    '**************  Fin Grabación Endeudamiento  *********************************
    '******************************************************************************
    
    
    
    End If
    
    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, _
            "BTR", "Opc_20700", "01", "Grabación Interbancario", "mdmo", Valor_antiguo, " ")

Exit Function


BacErrorHandlerIB:

    MsgBox "Problemas en Grabación de Operación Interbancaria: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version
    
    IB_GrabarTx = 0
    
End Function



Function IC_GrabarTx(RutCar$, TipCar$, Forpai$, Forpav$, Retiro$, Pagom$, Observ$, RutCli$, CodCli&, BacFrm As Form, custodia$, Tipo_Deposito$)
'-> LD1_035 : Se activa modulo
    On Error GoTo ErrGrabarIC
Dim SQL             As String
Dim Sql2            As String
Dim Sql1             As String
Dim sTipOper        As String
Dim sNumero         As String
Dim dNumdocu        As Double
Dim tFlag           As Boolean
Dim nRow            As Integer   ' Contador de Filas
Dim nRow2           As Integer   ' Contador correspondiente a los cortes
Dim nFactorCorte    As Double    ' Factor de los cortes
Dim nCorrelativo    As Double
Dim nTotal          As Double
Dim Datos()
Dim iCodMoneda     As Integer
    Dim oTerminal       As String

    Dim lPlazo&, iMonPact%, dTasPact#

    Let oTerminal = Mid(Environ("COMPUTERNAME"), 1, 15)
    sTipOper$ = "IC"

'-*-*--*-*
   '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then

        Dim Mensaje     As String
        Dim nparidad    As Double
'------------------------------------------------
        ''''iCodAux = 0 'iCodigo
        
'''''       /* Envia = Array()
'''''        AddParam Envia, sTipOper
'''''        AddParam Envia, Forpai
'''''        AddParam Envia, Forpav
'''''        AddParam Envia, Format(BacFrm.Dtefecven.text, "yyyymmdd")
'''''
'''''        If Not Bac_Sql_Execute("SP_MASCARAINTER", Envia) Then
'''''            MsgBox "Sql-Server No Responde. Intentelo Nuevamente", 16, "BacTrader"
'''''            Exit Function
'''''        End If
'''''
'''''        If Bac_SQL_Fetch(DATOS()) Then
'''''            cMascara = DATOS(1)
'''''            ''''iCodAux = DATOS(2)
'''''        End If

'------------------------------------------------
        Mensaje = ""
'''        nparidad = FUNC_BUSCA_VALOR_MONEDA(CDbl(BacFrm.CmbMoneda.ItemData(BacFrm.CmbMoneda.ListIndex)), Format(gsBac_Fecp, "DD/MM/YYYY"))
            
''''        If CDbl(BacFrm.CmbMoneda.ItemData(BacFrm.CmbMoneda.ListIndex)) = 13 Then
''''            nMonto = CDbl(BacFrm.FltMtoini.text) * gsBac_TCambio
''''        ElseIf CDbl(BacFrm.CmbMoneda.ItemData(BacFrm.CmbMoneda.ListIndex)) <> 999 Then
''''            nMonto = CDbl(BacFrm.FltMtoini.text) * nparidad
''''        Else
''''            nMonto = CDbl(BacFrm.FltMtoini.text)
''''        End If
        If Not Lineas_ChequearGrabar("BTR", sTipOper, BacFrm.hWnd, BacFrm.hWnd, 1, CDbl(RutCli), CDbl(CodCli), CDbl(BacFrm.Lbl_Monto_Final.Caption), gsBac_TCambio, BacFrm.Msk_Fecha_Vcto.text, 0, BacFrm.Cmb_Moneda.ItemData(BacFrm.Cmb_Moneda.ListIndex), BacFrm.Msk_Fecha_Vcto.text, 0, "N", 0, "C", 0, "N", 0, gsBac_Fecp, 0, CDbl(Forpai), CDbl(BacFrm.Msk_Tasa.text), CDbl(BacFrm.Msk_Tasa.text), sTipOper$) Then

            GoTo ErrGrabarIC
        End If
        
        Mensaje = Mensaje & Lineas_Chequear("BTR", sTipOper, BacFrm.hWnd, " ", " ", " ")
        
        If Mensaje <> "" Then
        
            MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical
            
            Exit Function
            
        End If
    
    End If
    '********** Fin

'/*-*-*-*
    '+++jcamposd debe rebajar limite trader
    
    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then

       Dim Mensaje_Con As String
       Dim SwResp      As Integer

       Mensaje_Con = Lineas_ConsultaOperacion("BTR", sTipOper, BacFrm.hWnd, " ", " ", " ") ' & Mensaje_CPT

      If Trim(Mensaje_Con) = "" And InStr(1, UCase(Mensaje_Con), "OK") > 0 Then
        If Trim(Mensaje_Con) <> "OK" Then
           SwResp = MsgBox("ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", vbYesNo + vbExclamation, BacFrm.Caption)
           If SwResp <> vbYes Then
               Call Lineas_BorraConsultaOperacion("BTR", BacFrm.hWnd)
               Exit Function
           End If
        End If
       End If
    End If
    '********** Fin
    '---jcamposd debe rebajar limite trader

'LD1-COR-035
'*******************************************************************************
    '**********  Validación de Limite de Endeudamiento  ****************************
    '*******************************************************************************
    Dim nPlazo          As Integer
    Dim VALIDA_AMBOS As Boolean
    Dim Tipo_porcentaje As Integer

    Grt_Garantizar = False
    nPlazo = DateDiff("D", Format(gsBac_Fecp, "dd/mm/yyyy"), Format(BacFrm.Msk_Fecha_Vcto.text, "dd/mm/yyyy"))

    Grt_Garantia = 0
    Grt_GarantiaX = 0
    Grt_GarantiaOpc = 0
    VALIDA_AMBOS = False

'   If sTipOper$ = "ICAP" And CDbl(nplazo) <= 365 Then

    If CDbl(nPlazo) <= 365 Then
    
        Grt_Plazo = CDbl(nPlazo)
        Grt_Garantia = 0
        Grt_GarantiaX = 1
        Grt_GarantiaOpc = 0
        Grt_Entidad = 1 'Capital BKB
        Tipo_porcentaje = 1

       'Do While Grt_Garantia <> Grt_GarantiaX
        Do While (VALIDA_AMBOS = False)
        
            Grt_Garantia = 0
            Grt_GarantiaX = 1

            If Not Chequea_Lineas_End(gsSistema, "IC", RutCli, CodCli, BacFrm.Lbl_Monto_Inicio_pesos.Caption, Grt_Entidad, Tipo_porcentaje) Then Exit Function

                Select Case Grt_Datos
                
                Case 0
                    If Not Grt_Garantizar Then
                     If TIPCLI < 4 Then
                    
                        MsgBox "Operación esta Correcta. Si desea Garantizar Operación con Documentos, ingrese al módulo de garantía: garantias.corpbanca.cl", vbExclamation, gsBac_Version
                          
                      Else
                          Grt_Garantizar = False
                      End If
                     End If
                     
                     Grt_GarantiaX = Grt_Garantia
                     VALIDA_AMBOS = True

                Case 1
                
                    If MsgBox(Grt_Mensaje & Grt_MensPreg, vbQuestion + vbYesNo, TITSISTEMA) <> vbYes Then
                         MsgBox Grt_Mensaje & " . Debe Garantizar Operación con Documentos en módulo de garantías garantias.corpbanca.cl", 16, TITSISTEMA
                            Grt_Garantizar = False
                                                      
                            VALIDA_AMBOS = True
                      '  Else
                          '  BacIrfGr.Toolbar1.Buttons(2).Enabled = True
                          '  Exit Function
                       ' End If
                    Else
                        If Grt_Entidad = 1 Then
                            Grt_Entidad = 2 'Capital Cliente
                        Else
                            Grt_Entidad = 1 'Capital BKB
                        End If
                    End If

                Case 2
                
                      MsgBox Grt_Mensaje & " . Debe Garantizar Operación con Documentos en módulo de garantías garantias.corpbanca.cl", 16, TITSISTEMA
                        Grt_Garantizar = False
                       
                        'If Not Grt_Garantizar Then
                         '  IC_GrabarTx = 0
                          ' Exit Function
                       ' End If
                        Grt_Entidad = 1 'Capital BKB
                        Tipo_porcentaje = 2
                        VALIDA_AMBOS = False
                    'Else
                      '  BacIrfGr.Toolbar1.Buttons(2).Enabled = True
                        IC_GrabarTx = 0
                      '  Exit Function
                  '  End If
                    
                Case 3
                
                      ' Validacion del 10 % ok ahora debe validar 3 %
                       Tipo_porcentaje = 2
                       VALIDA_AMBOS = False
                      'MsgBox Grt_Mensaje, 16, TITSISTEMA
                      'IC_GrabarTx = 0
                      'Exit Function

                End Select
        Loop

    End If
'
'    '*******************************************************************************
'    '**********  Fin de la Validación  *********************************************
'    '*******************************************************************************

    tFlag = False
    
    If miSQL.SQL_Execute("BEGIN TRANSACTION") <> 0 Then
        MsgBox "Problemas en inicio de transacción de grabación. " & vbCrLf & vbCrLf & "Salga del Sistema y vuelva a ingresar", vbCritical, gsBac_Version
        Exit Function
    End If
    
    tFlag = True
    
    If miSQL.SQL_Execute("EXECUTE SP_OPMDAC") <> 0 Then
       GoTo ErrGrabarIC
    End If
    If Bac_SQL_Fetch(Datos()) Then
       dNumdocu = Val(Datos(1))
    End If

    iCodMoneda = BacFrm.Cmb_Moneda.ItemData(BacFrm.Cmb_Moneda.ListIndex)
    
    nCorrelativo = 0
    
    For nRow = 1 To BacFrm.gr_cortes.Rows - 1
                        
        BacFrm.gr_cortes.Row = nRow
        BacFrm.gr_cortes.Col = 1
                
        nFactorCorte = BacFrm.gr_cortes.TextMatrix(nRow, 1)

        For nRow2 = 1 To Val(BacFrm.gr_cortes.text)
            Let VerSql = ""
            Let nCorrelativo = nCorrelativo + 1

            Envia = Array()
            Call AddParam(Envia, Format(gsBac_Fecp, "YYYYMMDD"))
            Call AddParam(Envia, CDbl(RutCar$))
            Call AddParam(Envia, Format(BacFrm.Msk_Fecha_Vcto.text, "YYYYMMDD"))
            Call AddParam(Envia, CDbl(BacFrm.Msk_Tasa.text))                                    '-> CDbl(BacStrTran(Format(BacFrm.Msk_Tasa.text, "###0.0000"), ",", ".")))
            Call AddParam(Envia, CDbl(BacFrm.Flt_TasaTran.text))                                '-> CDbl(BacStrTran(Format(BacFrm.Flt_TasaTran.text, "###0.0000"), ",", ".")))
            Call AddParam(Envia, CDbl(BacFrm.Txt_Dias.text))                                    '-> CDbl(BacStrTran(BacFrm.Txt_Dias.text, ",", ".")))
            Call AddParam(Envia, CDbl(iCodMoneda))                                              '-> CDbl(Str(iCodMoneda)))
            Call AddParam(Envia, CDbl(Forpai$))
            Call AddParam(Envia, CDbl(RutCli$))                                                 '-> CDbl(Str(RutCli$)))
            Call AddParam(Envia, CDbl(CodCli&))                                                 '-> CDbl(Str(CodCli&)))
            Call AddParam(Envia, Retiro$)
            Call AddParam(Envia, CDbl(dNumdocu))
            Call AddParam(Envia, custodia$)
            Call AddParam(Envia, Tipo_Deposito$)
            Call AddParam(Envia, CDbl(nRow))
            Call AddParam(Envia, CDbl(nCorrelativo))
            Call AddParam(Envia, CDbl(BacFrm.gr_cortes.TextMatrix(nRow, 5) / nFactorCorte))     '-> CDbl(Format(BacFrm.gr_cortes.TextMatrix(nRow, 5) / nFactorCorte, "##0.0000")))
            Call AddParam(Envia, CDbl(BacFrm.gr_cortes.TextMatrix(nRow, 2)))                    '-> CDbl(Format(BacFrm.gr_cortes.TextMatrix(nRow, 2), IIf(iCodMoneda = 13, "##0.0000", "##0"))))
            Call AddParam(Envia, CDbl(BacFrm.gr_cortes.TextMatrix(nRow, 3)))                    '-> CDbl(Format(BacFrm.gr_cortes.TextMatrix(nRow, 3), "##0.0000")))
            Call AddParam(Envia, gsBac_User)
        '-> LD1_035 : Se activa modulo, Se agregan uevos Parametros
            Call AddParam(Envia, CDbl(0))                                   '-> Ejecutivo
            Call AddParam(Envia, vCondicion)                                '-> Condicion
            Call AddParam(Envia, "0")                                       '-> Pago Hoy
            Call AddParam(Envia, "")                                        '-> Fecha Pago mañana
            Call AddParam(Envia, Mid(Observ$, 1, 50))                       '-> Observaciones
            Call AddParam(Envia, "")                                        '-> Sucursal
            Call AddParam(Envia, vTipoEmision)                              '-> Tipo de Emision
            Call AddParam(Envia, oTerminal)                                 '-> Terminal

        '-> LD1_035 : Se activa modulo, Se agregan uevos Parametros
            If Not Bac_Sql_Execute("SP_GRABA_CAPTACIONES", Envia) Then
                GoTo ErrGrabarIC
                End If
        Next nRow2
    Next nRow

    '+++jcamposd 20160504 debe grabar exceso trader
    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then
    
        If Not Lineas_GrbOperacion("BTR", sTipOper, BacFrm.hWnd, dNumdocu, " ", " ", " ") Then
            GoTo ErrGrabarIC
        End If
        
    End If
    '********** Fin
    '---jcamposd 20160504 debe grabar exceso trader
    

'******************************************************************************
'**************  Graba Limite de Endeudamiento  *******************************
'******************************************************************************
 Dim nMtoDeuda#

    Dim nDolarSpr
    ' If sTipOper$ = "ICAP" And CDbl(nplazo) < 365 Then
    '' VGS para las captaciones en USD se convierte a pesos con el dolar super 06/02/2007
     If iCodMoneda = 13 Then
        Envia = Array()
        AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")
        If Not Bac_Sql_Execute("sp_buscar_dolar_super ", Envia) Then
           MsgBox "Problemas al Recuperar Valor del Dolar Super... Verifique en Bacparametros si esta Ingresado.", vbInformation, TITSISTEMA
           GoTo ErrGrabarIC
        End If
        If Bac_SQL_Fetch(Datos()) Then
          nDolarSpr = CDbl(Datos(1))
        End If
    Else
        nDolarSpr = 1
    End If
    
    If CDbl(nPlazo) < 365 Then
      nMtoDeuda = CDbl(BacFrm.Lbl_Monto_Inicio_pesos.Caption)

      '' VGS para las captaciones en USD se convierte a pesos con el dolar super 06/02/2007
      If Grt_GarantiaX > 0 Then
          nMtoDeuda = Round(CDbl(BacFrm.Lbl_Monto_Inicio_pesos.Caption) * nDolarSpr, 0) - Grt_GarantiaX
      Else
          nMtoDeuda = Round(CDbl(BacFrm.Lbl_Monto_Inicio_pesos.Caption) * nDolarSpr, 0) - Grt_GarantiaOpc
      End If

      If nMtoDeuda < 0 Then
          nMtoDeuda = 0
      End If

      Envia = Array()
      AddParam Envia, dNumdocu                                            ' Nº Operacion
      AddParam Envia, CDbl(RutCli)                                        ' Rut Cliente
      AddParam Envia, CDbl(CodCli)                                        ' Codigo Cliente
      AddParam Envia, nMtoDeuda                                           ' Monto Operacion
      AddParam Envia, Grt_GarantiaX                                       ' Exceso
      AddParam Envia, gsUsuario                                           ' Operador
      AddParam Envia, nMtoDeuda                                           ' Monto Deuda
      AddParam Envia, "IC"                                           ' Tipo Operacion
      AddParam Envia, Grt_Mensaje                                         ' Mensaje
      AddParam Envia, Format(BacFrm.Msk_Fecha_Vcto.text, "yyyymmdd")           ' Fecha de Vcto
      AddParam Envia, CDbl(nPlazo)                                        ' Plazo

      If Not Bac_Sql_Execute(giSQL_DatabaseCommon & "..Sp_GrbLimite_Deuda", Envia) Then
          MsgBox "Problemas al Grabar Limites de Endeudamiento", 16, TITSISTEMA
          Exit Function
      End If

    End If
    '******************************************************************************
    '**************  Fin Grabación Endeudamiento  *********************************
    '******************************************************************************
 


'Grabación del control de precios y tasas
Dim resControlPT As String
Dim Mensaje_CPT As String

  'PRD-3860 (modo silencioso)
    If Ctrlpt_ModoOperacion = "S" Then
        Mensaje_CPT = ""
    Else
        Mensaje_CPT = Ctrlpt_Mensaje
    End If
    If Trim(Mensaje_CPT) <> "" Then
        Mensaje_CPT = vbCrLf & vbCrLf & Mensaje_CPT
    End If

    iMonPact% = iCodMoneda
    lPlazo& = CDbl(nPlazo)
    dTasPact# = CDbl(BacFrm.Msk_Tasa.text)

    resControlPT = ControlPreciosTasas("IC", iMonPact%, lPlazo&, dTasPact#, False)

     If miSQL.SQL_Execute("COMMIT TRANSACTION") <> 0 Then
        GoTo ErrGrabarIC
    End If

    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Operación de captación número: " & dNumdocu & ", grabada con éxito")

    IC_GrabarTx = dNumdocu

Exit Function
ErrGrabarIC:
    If tFlag = True Then
        miSQL.SQL_Execute ("ROLLBACK  TRANSACTION")
    End If
    
    MsgBox "Problemas en grabación de ingreso de captaciones :" & err.Description, vbCritical, gsBac_Version
    Exit Function
End Function

Function IC_GrabarTx_RC(RutCar$, TipCar$, Forpai$, Forpav$, Retiro$, Pagom$, Observ As String, RutCli$, CodCli&, BacFrm As Form, custodia$, Tipo_Deposito$, iRutContra$, iCodCliContra$) '--> , Ejecutivo$, cCondicion$, dFecPmH$, sucursal As String, Tipo_Emision As Integer, iRutContra$, iCodCliContra$)
    Dim SQL             As String
    Dim dNumdocu        As Double
    Dim tFlag           As Boolean
    Dim nRow            As Integer   ' Contador de Filas
    Dim Datos()
    Dim iCodMoneda      As Integer
    Dim nPlazo          As Integer
    Dim VALIDA_AMBOS    As Boolean
    Dim Tipo_porcentaje As Integer
    
    On Error GoTo ErrGrabarIC
    
    Dim oTerminal       As String
    
    Let oTerminal = Mid(Environ("COMPUTERNAME"), 1, 15)
    
    
    Dim Ejecutivo       As String: Let Ejecutivo = ""
    Dim cCondicion      As String: Let cCondicion = ""
    Dim dFecPmH         As Date:   Let dFecPmH = gsBac_Fecp
    Dim Sucursal        As String: Let Sucursal = ""
    Dim Tipo_Emision    As Long:   Let Tipo_Emision = 0
    
    'Dim iRutContra      As Long:   Let iRutContra = RutCli$
    'Dim iCodCliContra   As Long:   Let iCodCliContra = CodCli&
    
    Dim sTipOper        As String
    
'-*-*--*-*
   '********** Linea -- Mkilo
   
   sTipOper$ = "RIC"
   
    If gsBac_Lineas = "S" Then

        Dim Mensaje     As String
        Dim nparidad    As Double
        Mensaje = ""
        
        Dim transTipCambios$
        Dim transTasa$
        Dim transTotalSelec$
        
        transTipCambios$ = Replace(gsBac_TCambio, ",", ".")
        transTasa$ = Replace(CDbl(BacFrm.Msk_Tasa.text), ",", ".")
        transTotalSelec$ = Replace(CDbl(BacFrm.TxtCarteraSel.text), ",", ".")

        If Not Lineas_ChequearGrabar("BTR", sTipOper, BacFrm.hWnd, BacFrm.hWnd, 1, CDbl(RutCli), CDbl(CodCli), CDbl(BacFrm.TxtCarteraSel.text), gsBac_TCambio, BacFrm.Msk_Fecha_Vcto.text, 0, BacFrm.Cmb_Moneda.ItemData(BacFrm.Cmb_Moneda.ListIndex), BacFrm.Msk_Fecha_Vcto.text, 0, "N", 0, "C", 0, "N", 0, gsBac_Fecp, 0, CDbl(Forpai), CDbl(BacFrm.Msk_Tasa.text), CDbl(BacFrm.Msk_Tasa.text), sTipOper$) Then
        'If Not Lineas_ChequearGrabar("BTR", sTipOper, BacFrm.hWnd, BacFrm.hWnd, 1, CDbl(RutCli), CDbl(CodCli), CDbl(BacFrm.TxtCarteraSel.text), transTipCambios$, BacFrm.Msk_Fecha_Vcto.text, 0, BacFrm.Cmb_Moneda.ItemData(BacFrm.Cmb_Moneda.ListIndex), BacFrm.Msk_Fecha_Vcto.text, 0, "N", 0, "C", 0, "N", 0, gsBac_Fecp, 0, CDbl(Forpai), transTasa$, transTasa$, sTipOper$) Then
            GoTo ErrGrabarIC
        End If
        
        Mensaje = Mensaje & Lineas_Chequear("BTR", sTipOper, BacFrm.hWnd, " ", " ", " ")
        
        If Mensaje <> "" Then
        
            MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical
            
            Exit Function
            
        End If
    
    End If
    '********** Fin

'/*-*-*-*
    '+++jcamposd debe rebajar limite trader
    
    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then

       Dim Mensaje_Con As String
       Dim SwResp      As Integer

       Mensaje_Con = Lineas_ConsultaOperacion("BTR", sTipOper, BacFrm.hWnd, " ", " ", " ") ' & Mensaje_CPT

      If Trim(Mensaje_Con) = "" And InStr(1, UCase(Mensaje_Con), "OK") > 0 Then
        If Trim(Mensaje_Con) <> "OK" Then
           SwResp = MsgBox("ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", vbYesNo + vbExclamation, BacFrm.Caption)
           If SwResp <> vbYes Then
               Call Lineas_BorraConsultaOperacion("BTR", BacFrm.hWnd)
               Exit Function
           End If
        End If
       End If
    End If
    '********** Fin
    '---jcamposd debe rebajar limite trader
    
    
    
    
'   Grt_Garantizar = False
                
    nPlazo = DateDiff("D", Format(gsBac_Fecp, "dd/mm/yyyy"), Format(BacFrm.Msk_Fecha_Vcto.text, "dd/mm/yyyy"))
                
'    Grt_Garantia = 0
'    Grt_GarantiaX = 0
'    Grt_GarantiaOpc = 0
                
    VALIDA_AMBOS = False
              
'    If CDbl(nPlazo) <= 365 Then
'        Grt_Plazo = CDbl(nPlazo)
'        Grt_Garantia = 0
'        Grt_GarantiaX = 1
'        Grt_GarantiaOpc = 0
'        Grt_Entidad = 1 'Capital BKB
'        Tipo_porcentaje = 1
'    End If

    tFlag = False

    If miSQL.SQL_Execute("BEGIN TRANSACTION") <> 0 Then
        MsgBox "Problemas en inicio de transacción de grabación. " & vbCrLf & vbCrLf & "Salga del Sistema y vuelva a ingresar", vbCritical, gsBac_Version
        Exit Function
    End If
    
    tFlag = True

    If miSQL.SQL_Execute("sp_opmdac") <> 0 Then
       GoTo ErrGrabarIC
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
       dNumdocu = Val(Datos(1))
    End If
    
    iCodMoneda = BacFrm.Cmb_Moneda.ItemData(BacFrm.Cmb_Moneda.ListIndex)
    
    With BacFrm.gr_cortes
        For nRow = 1 To .Rows - 1
        
            If BacFrm.gr_cortes.TextMatrix(nRow, C_Campo_Venta) = "X" Then
                SQL = "SP_GRABA_RECOMPRA_CAPTACIONES "
                SQL = SQL & "'" & Format(gsBac_Fecp, "yyyymmdd") & "'," & vbCrLf
                SQL = SQL & RutCar$ & "," & vbCrLf
                SQL = SQL & "'" & Format(gsBac_Fecp, "yyyymmdd") & "'," & vbCrLf
                SQL = SQL & Val(BacFrm.gr_cortes.TextMatrix(nRow, C_Plazo)) & "," & vbCrLf
                SQL = SQL & Str(iCodMoneda) & "," & vbCrLf
                SQL = SQL & Forpai$ + "," & vbCrLf
                SQL = SQL & Str(RutCli$) & "," & vbCrLf
                SQL = SQL & Str(CodCli&) & "," & vbCrLf
                SQL = SQL & "'" & Retiro$ & "'," & vbCrLf
                SQL = SQL & dNumdocu & "," & vbCrLf
                SQL = SQL & "'" & Tipo_Deposito$ & "'," & vbCrLf
                SQL = SQL & "'" & Ejecutivo & "'," & vbCrLf
                SQL = SQL & "'" & cCondicion & "'," & vbCrLf
                SQL = SQL & "'" & Pagom$ & "'," & vbCrLf
                SQL = SQL & "'" + Format(dFecPmH, "yyyymmdd") + "'," & vbCrLf
                SQL = SQL & CDbl(BacFrm.gr_cortes.TextMatrix(nRow, C_Correlativo)) & ", " & vbCrLf ' Correlativo Corte
                SQL = SQL & Replace(CDbl(BacFrm.gr_cortes.TextMatrix(nRow, C_MONTO_CORTE)), ",", ".") & ", " & vbCrLf ' Monto  Corte
                SQL = SQL & Replace(CDbl(BacFrm.gr_cortes.TextMatrix(nRow, C_Tasa_Recompra)), ",", ".") & ", " & vbCrLf ' Tasa Recompra
                SQL = SQL & Replace(CDbl(BacFrm.gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar)), ",", ".") & ", " & vbCrLf ' Valor a Pagar
                SQL = SQL & Replace(CDbl(BacFrm.gr_cortes.TextMatrix(nRow, C_Interes_Pagar)), ",", ".") & ", " & vbCrLf ' Valor a Pagar
                SQL = SQL & Replace(CDbl(BacFrm.gr_cortes.TextMatrix(nRow, C_Reajuste_Pagar)), ",", ".") & ", " & vbCrLf ' Valor a Pagar
                SQL = SQL & "'" & gsBac_User & "'," & vbCrLf
                SQL = SQL & "'" & Observ$ & "'," & vbCrLf
                SQL = SQL & "'" & Sucursal & "'," & vbCrLf
                SQL = SQL & "'" & Format(Tipo_Emision, "##") & "'," & vbCrLf
                SQL = SQL & CDbl(BacFrm.IntNumoper.text) & "," & vbCrLf
                SQL = SQL & "'" & Mid$(BacFrm.gr_cortes.TextMatrix(nRow, C_Tipo_Custodia), 1, 1) & "', " & vbCrLf ' Tipo Custodia
                SQL = SQL & "'" & BacFrm.gr_cortes.TextMatrix(nRow, C_Clave_Dcv) & "', " & vbCrLf ' Clave DCV
                SQL = SQL & BacFrm.gr_cortes.TextMatrix(nRow, C_Num_Dcv) & "," & vbCrLf ' N° Certif. DCV
                SQL = SQL & iRutContra & ", " & vbCrLf
                SQL = SQL & iCodCliContra & ", " & vbCrLf
                SQL = SQL & "''" & ", " & vbCrLf
                '+++jcamposd recalculo
                SQL = SQL & Replace(CDbl(BacFrm.gr_cortes.TextMatrix(nRow, C_capital_Recomprado)), ",", ".") & ", " & vbCrLf ' capital recomprado
                SQL = SQL & Replace(CDbl(BacFrm.gr_cortes.TextMatrix(nRow, C_resultado_Recompra)), ",", ".") & ", " & vbCrLf ' resultado recompra
                SQL = SQL & Replace(CDbl(BacFrm.gr_cortes.TextMatrix(nRow, C_Interes_Dev)), ",", ".") ' interes devengado
                '---jcamposd recalculo
                
                
                If miSQL.SQL_Execute(SQL) = 0 Then
                    Do While Bac_SQL_Fetch(Datos())
                        If Datos(1) = "NO" Then
                            MsgBox Datos(3), vbExclamation, gsBac_Version
                            GoTo ErrGrabarIC
                        End If
                    Loop
                Else
                    GoTo ErrGrabarIC
                End If

            End If
        Next nRow
    End With
   
    '+++jcamposd 20160504 debe grabar exceso trader
    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then
    
        If Not Lineas_GrbOperacion("BTR", sTipOper, BacFrm.hWnd, dNumdocu, " ", " ", " ") Then
            GoTo ErrGrabarIC
        End If
        
    End If
    '********** Fin
    '---jcamposd 20160504 debe grabar exceso trader
   
   
    Dim dNumoper
    
'    dNumoper = dNumdocu
'    numope = dNumdocu
'
'    Envia = Array()
'    AddParam Envia, Format(gsBac_Fecp, feFECHA)
'    AddParam Envia, "BTR"
'    AddParam Envia, "IC"
'    AddParam Envia, dNumdocu
'    AddParam Envia, "A"
'
'    If Not Bac_Sql_Execute(giSQL_DatabaseCommon & ".dbo.sp_caja_actualizar_RentaFija", Envia) Then
'        GoTo ErrGrabarIC
'    End If

'''''    '****** Graba el detalle de la validacion IDD *********************
'''''    If Not Graba_IDD_AS400_IC(dNumdocu, dNumdocu, 630) Then 'VMGS
'''''
'''''    End If
    
    If miSQL.SQL_Execute("COMMIT TRANSACTION") <> 0 Then
        GoTo ErrGrabarIC
    End If
    
    IC_GrabarTx_RC = dNumdocu
    
    Exit Function
ErrGrabarIC:
    
    If tFlag = True Then
        miSQL.SQL_Execute ("ROLLBACK  TRANSACTION")
    End If
    
     MsgBox "Problemas en grabación de ingreso de captaciones :" & err.Description, vbCritical, gsBac_Version
End Function


Public Function BacFormatoSQL(ByVal Numero As Double) As String
Dim sCadena$

    sCadena = Str$(CDbl(Numero))
    BacFormatoSQL = sCadena$
    
End Function

Function BacAbrirBaseDatosMDB() As Boolean

   On Error GoTo BacErrorHandler
   
   BacAbrirBaseDatosMDB = False
    
   Set WS = DBEngine.Workspaces(0)
   Set db = WS.OpenDatabase(gsMDB_Path & gsMDB_Database, False, False)

   db.Execute "DELETE * FROM mdventa"
   db.Execute "DELETE * FROM mdco"
    
   BacAbrirBaseDatosMDB = True
   
   Exit Function
    
BacErrorHandler:
    
   Exit Function

End Function

Sub FUNC_COPIAR_MDB()
Dim Fuente  As String
Dim Destino As String

    On Error GoTo Fin_Copiar

    
 
    Fuente = gsMDB_SOURCE + gsMDB_Database
    Destino = gsMDB_Path + gsMDB_Database

    FileCopy Fuente, Destino
    
  '  Fuente = App.Path + "\MDBDEUT\" + Base + ".LDB"
  '  Destino = gsMDB_Path + Base + ".LDB"
    

  '  FileCopy Fuente, Destino



    Exit Sub

Fin_Copiar:

    MsgBox Error(err), vbCritical
    Exit Sub

End Sub



Function BacRepairDatabase() As Boolean

On Error GoTo BacErrorHandler

    BacRepairDatabase = False
    RepairDatabase gsMDB_Path & gsMDB_Database
    BacRepairDatabase = True
    
    Exit Function
    
BacErrorHandler:

    Exit Function

End Function
Function BacErrorHandlerMDB(CodErr%) As Boolean

    BacErrorHandlerMDB = False
    Select Case CodErr%
    
        Case 3005
            MsgBox "No Reconoce la base de datos temporal", vbCritical, gsBac_Version

        Case 3949
            MsgBox "Base de datos temporal ESTA CORRUPTA" & NL & NL & "SE PROCEDERA A REPARARLA", vbExclamation, gsBac_Version
            
            
            If BacRepairDatabase() = False Then
                MsgBox "NO PUDO REPARAR LA BASE DE DATOS", vbCritical, gsBac_Version
            Else
                BacErrorHandlerMDB = True
            End If
        Case 3428, 3049
            MsgBox "Base de datos temporal ESTA CORRUPTA" & NL & NL & "SE PROCEDERA A REPARARLA", vbExclamation, gsBac_Version
            
            
            If BacRepairDatabase() = False Then
                MsgBox "NO PUDO REPARAR LA BASE DE DATOS", vbCritical, gsBac_Version
            Else
                BacErrorHandlerMDB = True
            End If
            
        Case Else
            MsgBox "N0 SE PUDO ABRIR LA BASE DE DATOS TEMPORAL", vbCritical, gsBac_Version
    End Select
        
End Function


'Public Function BacGetSysIni(section, key) As Variant
'Dim retVal As String, AppName As String, worked As Integer
'
'    retVal = String$(255, 0)
'    worked = GetPrivateProfileString(section, key, "", retVal, Len(retVal), "System.ini")
'    If worked = 0 Then
'        BacGetSysIni = "Desconocido"
'    Else
'        BacGetSysIni = Left(retVal, InStr(retVal, Chr(0)) - 1)
'    End If
'
'End Function

Public Function BacCompactarMDB() As Boolean
Dim bufNombreMDB$, bufNombreLDB$
Dim lsNombreLDB$


On Error GoTo BacErrorHandler

    Screen.MousePointer = 11
    BacCompactarMDB = False
    ChDir gsMDB_Path
    
    bufNombreMDB$ = gsMDB_Path & "BA" & Format(Now, "ddmmyy") & ".MDB"
    bufNombreLDB$ = gsMDB_Path & "BA" & Format(Now, "ddmmyy") & ".LDB"
    lsNombreLDB$ = Mid$(gsMDB_Database, 1, Len(gsMDB_Database) - 3) & "LDB"
    
  ' Elimina si es que existiese archivos con ese nombre
    BacEliminaArchivo bufNombreMDB$
    BacEliminaArchivo bufNombreLDB$
    
    CompactDatabase gsMDB_Path & gsMDB_Database, bufNombreMDB
    
  ' Elimina la base de datos anterior
    BacEliminaArchivo gsMDB_Path & gsMDB_Database$
    BacEliminaArchivo gsMDB_Path & lsNombreLDB$
    
  ' Renombra la base de datos compactada
    Name bufNombreMDB$ As gsMDB_Path & gsMDB_Database
    Name bufNombreLDB$ As gsMDB_Path & lsNombreLDB
    
    Screen.MousePointer = 0
    BacCompactarMDB = True
    Exit Function
    
BacErrorHandler:

    Screen.MousePointer = 0
    BacCompactarMDB = False
    Exit Function
    
End Function

Public Sub BacEliminaArchivo(NombreArchivo$)

On Error GoTo BacErrorHandler
    
    Kill NombreArchivo$

    Exit Sub
    
BacErrorHandler:

    On Error GoTo 0
    Exit Sub

End Sub





Function BacBuscaComboGlosa(hCombo As ComboBox, ByVal Glosa As String) As Long

Dim i%

    For i = 0 To hCombo.ListCount - 1
        If Trim$(hCombo.List(i)) = Trim$(Glosa) Then
            BacBuscaComboGlosa = i
            Exit Function
        End If
    Next i
    
    BacBuscaComboGlosa = -1

End Function

Public Function BacExecuteMDB(SQL As String) As Boolean
Dim db As Database
Dim WS As Workspace
Dim rs As Recordset

On Error GoTo ExecuteMDBError
       
    BacExecuteMDB = True
    Set WS = DBEngine.Workspaces(0)
    Set db = WS.OpenDatabase(gsMDB_Path & gsMDB_Database, False, False)
    Set rs = db.OpenRecordset("mdcp", dbOpenTable)
            
    db.Execute SQL
    Exit Function

ExecuteMDBError:

    MsgBox Error.Descripcion, vbExclamation, gsBac_Version
    BacExecuteMDB = False
    Exit Function
    
End Function
Public Function BacValorizar(ByRef Ent As BacValorizaInput, ByRef Sal As BacValorizaOutput)
On Error GoTo ValorizarError

Dim nerror%

    BacValorizar = False
    
    Screen.MousePointer = 11
    If Mid(Ent.Mascara, 1, 6) <> "FMUTUO" Then
      If Ent.Nominal# = 0 Then
          Screen.MousePointer = 0
          Exit Function
      End If
    End If
       
'    Sql$ = "SP_VALORIZAR_CLIENT " & Chr$(10)
'    Sql$ = Sql$ & Ent.ModCal% & "," & Chr$(10)
'    Sql$ = Sql$ & "'" & Ent.FecCal$ & "'," & Chr$(10)
'    Sql$ = Sql$ & Ent.Codigo& & "," & Chr$(10)
'    Sql$ = Sql$ & "'" & Ent.Mascara$ & "'," & Chr$(10)
'    Sql$ = Sql$ & BacFormatoSQL(Ent.MonEmi) & "," & Chr$(10)
'    Sql$ = Sql$ & "'" & Ent.fecemi & "'," & Chr$(10)
'    Sql$ = Sql$ & "'" & Ent.FecVen & "'," & Chr$(10)
'    Sql$ = Sql$ & BacFormatoSQL(Ent.TasEmi) & "," & Chr$(10)
'    Sql$ = Sql$ & BacFormatoSQL(Ent.BasEmi) & "," & Chr$(10)
'    Sql$ = Sql$ & BacFormatoSQL(Ent.TasEst&) & "," & Chr$(10)
'    Sql$ = Sql$ & BacFormatoSQL(Ent.Nominal#) & "," & Chr$(10)
'    Sql$ = Sql$ & BacFormatoSQL(Ent.tir#) & "," & Chr$(10)
'    Sql$ = Sql$ & BacFormatoSQL(Ent.Pvp#) & "," & Chr$(10)
'    Sql$ = Sql$ & BacFormatoSQL(Ent.Mt#)
    
    Envia = Array(CDbl(Ent.ModCal), _
            Ent.FecCal, _
            CDbl(Ent.Codigo), _
            Ent.Mascara, _
            CDbl(Ent.MonEmi), _
            Ent.fecemi, _
            Ent.FecVen, _
            CDbl(Ent.TasEmi), _
            CDbl(Ent.BasEmi), _
            CDbl(Ent.TasEst&), _
            Ent.Nominal, _
            CDbl(Ent.tir), _
            Ent.Pvp, _
            Ent.Mt)
    
    If Not Bac_Sql_Execute("SP_VALORIZAR_CLIENT", Envia) Then
        GoTo ValorizarError
    End If
       
    Dim Datos()
    If Bac_SQL_Fetch(Datos()) Then
        nerror = Val(Datos(1))
        
        If nerror = 0 Then
            Sal.Nominal# = Datos(2)
            Sal.tir# = Datos(3)
            Sal.Pvp# = Datos(4)
            Sal.Mt# = Datos(5)
            Sal.MtUM# = Datos(6)
            Sal.Mt100# = Datos(7)
            Sal.Van# = Datos(8)
            Sal.Vpar# = Datos(9)
            Sal.Numucup% = Datos(10)
            Sal.Fecucup$ = Datos(11)
            Sal.Intucup# = Datos(12)
            Sal.Amoucup# = Datos(13)
            Sal.Salucup# = Datos(14)
            Sal.Numpcup% = Datos(15)
            Sal.Fecpcup$ = Datos(16)
            Sal.Intpcup# = Datos(17)
            Sal.Amopcup# = Datos(18)
            Sal.Salpcup# = Datos(19)
            Sal.duratmac# = Datos(20)
            Sal.convexid# = Datos(21)
            Sal.duratmod# = Datos(22)
            BacValorizar = True
            
        Else
           Screen.MousePointer = 0
           MsgBox Datos(2), vbExclamation, gsBac_Version
           Exit Function
        End If
    
    End If
   
    Screen.MousePointer = 0
  
    Exit Function
    
ValorizarError:

    Screen.MousePointer = 0

    If err <> 0 Then
'        MsgBox error(Err), vbCritical, gsBac_Version
        MsgBox Datos(2), vbCritical, gsBac_Version
    End If
    Exit Function
    
End Function
Sub BacHabilitaBotones(tipo As String)


End Sub
Function BacNumeroVentana(TipOpe As String) As Integer

'Calcula el numero de ventana que corresponde
'En el Tag de guarda el tipo de ventana (Ej.: CP,CI,...) mas el correlativo
'de la ventana (CP01,CI03)
'De hecho el gcNumeroMaximo de ventanas debe ser menor a 10 y mayor a uno
'Devuelve 0 si excedió el numero maximo de ventanas

Dim i%, Contador%, NumeroActual%
Dim FormTag As String

    Contador% = 0
    For i% = 1 To Forms.Count
        FormTag = Forms(i% - 1).Tag
        If Mid$(FormTag, 1, 2) = TipOpe Then
            Contador% = Contador% + 1
            NumeroActual% = Val(Mid$(FormTag, 3, 2))
        End If
    Next i%
    
    If Contador% > gcMaximoVentanas Then
        MsgBox "NUMERO MAXIMO DE VENTANAS ABIERTAS EXCEDIDO", vbExclamation, gsBac_Version
        BacNumeroVentana = 0
    Else
        If Contador% = 0 Then
            BacNumeroVentana = 1
        Else
            BacNumeroVentana = NumeroActual% + 1
        End If
    End If

End Function



Function BacBuscaComboIndice(hCombo As ComboBox, ByVal Codigo As Long) As Long

Dim i%

    For i = 0 To hCombo.ListCount - 1
        If hCombo.ItemData(i) = Codigo Then
            BacBuscaComboIndice = i
            Exit Function
        End If
    Next i
    
    BacBuscaComboIndice = -1

End Function

Sub BacCentrarPantalla(hForm As Form)

    hForm.Top = (Screen.Height - hForm.Height) / 2
    hForm.Left = (Screen.Width - hForm.Width) / 2

End Sub


Sub BacCaracterNumerico(ByRef KeyAscii As Integer)

    'si <> Enter y BackSpace
    If KeyAscii <> 13 And KeyAscii <> 8 Then
        'Si no es numerico
        If Not IsNumeric(Chr$(KeyAscii)) Then
            KeyAscii = 0
        End If
    End If

End Sub


Sub BacToUCase(ByRef KeyAscii As Integer)
    
    If KeyAscii = 39 Or KeyAscii = 34 Then ' Revisa comillas
       KeyAscii = 0
    End If

    If KeyAscii >= 97 Or KeyAscii <= 122 Then
       KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
    End If
    
End Sub


Public Sub Main()
On Error Resume Next
       BacTrader.Show vbNormal
End Sub
Function Chequear_RcRv()
  
    Chequear_RcRv = False
  
    If Chequea_Parametros(ACSW_RC, varGsMsgRC, 1) Or Chequea_Parametros(ACSW_RV, varGsMsgRV, 1) Then
    
        Chequear_RcRv = True
    End If
  
End Function

Function Chequear_DvNR()

    Chequear_DvNR = True
    
    If Chequea_Parametros(ACSW_DV, varGsMsgDV, 1) Then
        Chequear_DvNR = False
    End If
  
End Function

Function Chequear_DvRE()

    Chequear_DvRE = False
    
    If Chequea_Parametros(ACSW_DV, varGsMsgDV, 0) Then
        Chequear_DvRE = True
    End If
    
End Function

Function Validar_Pap_Impresas(Numoper$, tipo$)
Dim Datos()
  
    Validar_Pap_Impresas = True

    If miSQL.SQL_Execute("SP_VALIDA_PAP_CONT " + Numoper$ + ",'" + tipo$ + "'") <> 0 Then
        MsgBox "No se Pudo Validar Papeletas y Contratos", vbExclamation, gsBac_Version
        Validar_Pap_Impresas = False
        Exit Function
    End If
  
    Do While Bac_SQL_Fetch(Datos())
        If Val(Datos(1)) = 0 Then
            Validar_Pap_Impresas = False
        End If
    Loop
  
End Function

Function Chequear_Fd()
    Chequear_Fd = False
    
    If Chequea_Parametros(ACSW_FD, varGsMsgFD, 0) Then
        Chequear_Fd = True
    End If
    
End Function

Function Chequear_Pd()
  
    Chequear_Pd = False
  
    If Chequea_Parametros(ACSW_PD, varGsMsgPD, 0) Then
        Chequear_Pd = True
    End If
  
End Function




Function Chequear_Mesa()
  
    Chequear_Mesa = True
    
    If Chequea_Parametros(ACSW_MESA, varGsMsgCierre, 1) Then
            Chequear_Mesa = False
    End If
    
End Function

Function Chequear_MesaIng()
  
    Chequear_MesaIng = False
    
    If Chequea_Parametros(ACSW_MESA, varGsMsgOpen, 1) Then
            Chequear_MesaIng = True
    End If
    
End Function


Function Chequear_MesaBLQ()
  
  Chequear_MesaBLQ = True
    
  If Not Chequea_Parametros(ACSW_MESA, varGsMsgCierre, 0) Then
     Chequear_MesaBLQ = False
  End If

End Function
Function Chequear_OpePenLineas()
  
  Chequear_OpePenLineas = True
    
  If Not Chequea_OpePenLinCred() Then
     Chequear_OpePenLineas = False
  End If

End Function
Function Chequear_Cierre()
  Dim Datos()
  
  Chequear_Cierre = False
  
  If Chequea_Parametros(ACSW_PC, varGsMsgPC, 1) Then
      Chequear_Cierre = True
  End If
  
End Function

Function Calculo_Rentabilidad()

    Dim Datos()



    If Not Bac_Sql_Execute("SP_RENTABILIDAD_VERF_TCAM") Then
        MsgBox "Error en calculo de Rentabilidad", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    
    Do While Bac_SQL_Fetch(Datos())
    
        If Datos(1) <> "SI" Then
            MsgBox "No se ha Ingresado Tasa Camara", vbExclamation, gsBac_Version
            Exit Function
        End If
    
    Loop


    If Not Bac_Sql_Execute("SP_RENTABILIDAD_INTERBANCARIOS ") Then
        MsgBox "Error en calculo de Rentabilidad Interbancarias", vbExclamation, gsBac_Version
        Exit Function
    End If
  
    If Not Bac_Sql_Execute("SP_RENTABILIDAD_CARTERA_CPL ") Then
        MsgBox "Error en calculo de Rentabilidad Cartera", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    If Not Bac_Sql_Execute("SP_RENTABILIDAD_VENTAS") Then
        MsgBox "Error en calculo de Rentabilidad de Ventas Definitivas", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    If Not Bac_Sql_Execute("SP_RENTABILIDAD_PACTOS_CI") Then
        MsgBox "Error en calculo de Rentabilidad de Pactos", vbExclamation, gsBac_Version
        Exit Function
    End If

    If Not Bac_Sql_Execute("SP_RENTABILIDA_ACTSW") Then
        MsgBox "Error en calculo de Rentabilidad", vbExclamation, gsBac_Version
        Exit Function
    End If


    MsgBox "Calculo de Rentabilidad termino en forma correcta", vbInformation, gsBac_Version
    

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

Public Function funcFindDatGralMoneda(nCodMoneda As Integer) As Boolean
Dim cSql As String
Dim Datos()
On Error GoTo ErrMon

    funcFindDatGralMoneda = False
    Envia = Array(nCodMoneda)
       
    cSql = "SP_DATOSGRLESMONEDA"
   
    If Bac_Sql_Execute(cSql, Envia) Then
        With BacDatGrMon
        Do While Bac_SQL_Fetch(Datos())

            .mncodmon = Datos(1)
            .mnnemo = Datos(2)
            .mnsimbol = Datos(3)
            .mnglosa = Datos(4)
            .mncodsuper = Datos(5)
            .mnnemsuper = Datos(6)
            .mncodbanco = Datos(7)
            .mnnembanco = Datos(8)
            .mnbase = Datos(9)
            .mnredondeo = Datos(10)
            .mndecimal = Datos(11)
            .mncodpais = Datos(12)
            .mnrrda = Datos(13)
            .mnfactor = Datos(14)
            .mnrefusd = Datos(15)
            .mnlocal = Datos(16)
            .mnextranj = Datos(17)
            .mnvalor = Datos(18)
            .mnrefmerc = Datos(19)
            .mningval = Datos(20)
            .mntipmon = Datos(21)
            .mnperiodo = Datos(22)
            .mnmx = Datos(23)
            .mncodfox = Datos(24)
            .mnvalfox = Datos(25)
            .mncodcor = Datos(26)
            .codigo_pais = Datos(27)
            .mniso_coddes = Datos(28)
            .mncodcorrespC = Datos(29)
            .mncodcorrespV = Datos(30)

        Loop
        End With
    Else
      MsgBox "No se pudo Cargar Datos Generales de Monedas", vbCritical, TITSISTEMA
      Exit Function
    End If
    
    funcFindDatGralMoneda = True
    Exit Function
    
ErrMon:
    MsgBox "Problemas en la Carga Datos Generales de Monedas: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version
    Exit Function
    
End Function
