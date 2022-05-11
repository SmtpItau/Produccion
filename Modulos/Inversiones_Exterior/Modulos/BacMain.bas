Attribute VB_Name = "BacMain"
Option Explicit
Declare Function EnvMsg Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Long) As Long

'MsgBox "Proceso Terminado en Forma Correcta", vbInformation, gsBac_Version
'MsgBox "Interfaz Generada en Forma Correcta", vbInformation, gsBac_Version
'MsgBox "Informe Generado en Forma Correcta", vbInformation, gsBac_Version
'MsgBox "Información Grabada Correctamente", vbInformation, gsBac_Version

'MsgBox "Problemas al Ejecutar Proceso", vbCritical, gsBac_Version
'MsgBox "Problemas al XXXXXXXXXXXXXXXXX", vbCritical, gsBac_Version

'MsgBox "Falta Ingresar XXXXXXXXXXX",vbExclamation, gsBac_Version
'MsgBox "XXXXXXXXXXX Mal Ingresado",vbExclamation, gsBac_Version
'MsgBox "Debe Seleccionar XXXXXXXXXXXXXX",vbExclamation, gsBac_Version

'MsgBox "No se Encontro Información Correspondiente",vbExclamation, gsBac_Version
'MsgBox "XXXXXXXXXXXXX No Existe en Sistema",vbExclamation, gsBac_Version

Global Tipo_op As String
' -----------------------------------------------------------------
' Variables Globales del Sistema.-
' -----------------------------------------------------------------
Global cTipo_Oper       As String
Global Descrip
Global Cod_cli As Double
Global Cod_emi As Double
Global Pais_invers As Double
Global Const PAISES = 1
Global Const REGION = 2
Global Const CIUDAD = 3
Global Const COMUNA = 4

Global bac_hora_id As String
Global bac_hora_dv As String
Global bac_hora_tm As String
Global bac_hora_mesa As String
Global bac_hora_fd As String

Global Opcion        As String
Global titulorpt     As String
Global titulo        As String
Global Const FDecimal = "#,#0.0000"
Global Const FEntero = "#,###"
Global Const TITSISTEMA = "BAC-BONOS EXTERIOR"
Global Const feFECHA = "yyyymmdd"   ' Formato Estandar de Fecha

Global gsBac_Login          As Boolean
Global gsBac_User           As String
Global gsBac_UserName       As String
Global gsBac_Tipo_Usuario   As String
Global gsBac_Term           As String
Global gsBac_Pass           As String
Global gsBac_Fecp           As Date
Global gsBac_Fecx           As Date
Global gsBac_Feca           As Date
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
Global gsBac_DolarMesAnt  As Double
Global gsBac_DolarObs As Double
Global gsBac_LineasDB       As String
Global gsBac_IP             As String

Global gsBac_fondos_banco_c       As String
Global gsBac_fondos_cta_c         As String
Global gsBac_fondos_pais_c        As String
Global gsBac_fondos_ciud_c        As String
Global gsBac_fondos_banco_v       As String
Global gsBac_fondos_cta_v         As String
Global gsBac_fondos_pais_v        As String
Global gsBac_fondos_ciud_v        As String


Global gsBac_Moneda_Oper        As String
Global gsBac_InterfazContable   As String

Global gsPath_Fox
' SQL
    Global giSQL_ConnectionMode As Integer
    Global gsSQL_Database       As String
    Global gsSQL_Server         As String
    Global gsSQL_Login          As String
    Global gsSQL_Password       As String
    Global giSQL_LoginTimeOut   As String
    Global giSQL_QueryTimeOut   As String
     Global gsSQL_Database_comun  As String
' -----------------------------------------------------------------
' Tipos definidos.-
' -----------------------------------------------------------------
   
'Variables para el conección del Sql Server
Global gsBaseDatosSQL    As String
Global gsServidorSQL     As String
Global gsUsuario        As String
Global gsPassword       As String


'Variable que me indica si presiono el boton Aceptar de la pantalla de Ayuda
Global giAceptar%
Global giSW             As String

'New Line, para MsgBox
Global NL   As String

'Variables Ocupadas para dar Cartera por Defecto
Global gsBac_CartRUT    As Double
Global gsBac_CartDV     As String
Global gsBac_CartNOM    As String
Global RutCartV        As String
Global DvCartV         As String
Global NomCartV        As String

Global gsBac_DIRIN      As String
Global gsBac_Version    As String
Global gsBac_DIRIBS As String

'Variable que me indica el tipo de impresion (pap/con)
Global gsTipoPapeleta As String
Global gsBac_Handler As Integer
Global gsBac_PtoDec  As String
Global gsBac_Tcamara As Integer
Global gsBac_FecValr As Date
Global gsBac_Papeleta As Integer


Global gsBac_DIRINTCONTA As String

'Variable para interfaces Contables
Global gsBac_DIRCONTA      As String


'ODBC
Global GsODBC As String
Global CONECCION As String

Global miSQL As New BTPADODB.CADODB
'
Global RptList_Path         As String
Global SwConeccion  As String
Global gsDOC_Path  As String
Global giMonLoc  As String
Global gsBac_Timer As Integer ' Timer
Global gsBac_Timer_Adicional    As Long

' Para Pantalla de Proceso
Global gsRUN_Proceso        As String

'Variables de paso para ser ocupadas en cualquier parte
Global gsBac_Sw         As Integer
Global gsBac_SwChar     As String
Global gsBac_VarString  As String
Global gsBac_VarString2 As String
Global gsBac_VarDouble  As Double
Global gsBac_VarDouble2 As Double
Global gsBac_Ayuda      As String
Global ltasfija         As String
Global instru           As String

'Variables usadas en la pantalla de Ayuda
Global gscodigo            As String
Global gsDigito            As String
Global gsDescripcion       As String
Global gsSerie             As String
Global gsGenerico          As String
Global gsrut               As String
Global gsvalor             As String
Global gsmoneda            As String
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
Global gsBac_TCambio       As Double
Global gsBac_Lineas        As String
'-------------------------------------------------------------------
'   Variables Confirmación Fax
'-------------------------------------------------------------------

Global telefono_Bech As String
Global telefono_Contra As String
Global Fax_Bech As String
Global Fax_Contra As String
Global Confirmacion As String
'-------------------------------------------------------------------

Global rut_cli
Global obseravcion
Global codigo_cartera_super
Global tipo_cart_sbif
Global Sucursal
Global Oper_Con
Global Oper_bech
Global corr_cli_bco
Global corr_cli_Cta
Global corr_cli_pais
Global corr_cli_ciu
Global corr_cli_ABA
Global corr_cli_swi
Global corr_cli_ref
Global corr_bco_bco
Global corr_bco_Cta
Global corr_bco_pais
Global corr_bco_ciu
Global corr_bco_ABA
Global corr_bco_swi
Global corr_bco_ref
Global calce
Global Tipo_Inversion
Global Area_Responsable
Global libro
Global para_quien
Global custodia
Global cusip
Global gsFormaPago
Global Nom_inst
Global Fechadet
'JBH, 19-10-2009
Global cod_mesa_origen
Global cod_mesa_destino
Global cod_cartera_destino
Global opcion_filtrado
'fin JBH, 19-10-2009
'JBH, 04-12-2009
Global ope_intramesa As Boolean
'fin JBH, 04-12-2009

Global gsDato1 As String
Global gsDato2 As String

'Variable de control de informes

Global Bac_Informe As String
Global Rut_Cart As Double
Global Num_Docu As Double

'JBH, 17-12-2009
Global Num_Relac As Double  'Num Ope para operacion relacionada Ticket Intramesa
'fin JBH

' Variables de control de usuario

Global Bac_Usr_cod As Double
Global Bac_Usr_lgn As String
Global Bac_Usr_nom As String
Global Bac_Usr_ofi As Double
Global Bac_Cambio As Double


'Definición de Queue e Impresoras
Global gsBac_IMPDEF     As String
Global gsBac_IMPWIN     As String
Global gsBac_QUEDEF     As String
Global gsBac_IMPPPC     As String
Global gsBac_QUEPPC     As String

Global Fecha_Expira                 As Date
Global gsNom_maq As String
Global gsUser_maq As String
Global gsPass_maq As String
Global gsPath_maq As String

'Numero máximo de ventanas abiertas por tipo
Global Const gcMaximoVentanas = 5
Global gSQLVar$ 'Parte Variable
Global gSQLFam$ 'Familias
Global gSQLEmi$ 'Emisores
Global gSQLMon$ 'Monedas
Global gSQLSer$ 'Series
Global gSQL$
Global gs_Cart As Integer

'JBH, 22-12-2009
Global auxUser As String
'fin JBH, 22-12-2009


Global gsBac_DIREXEL As String 'new

Global EnviarCF As String   'PRD-9287
'+++CONTROL IDD, jcampos marca de aplica linea
Global MarcaAplicaLinea As Integer
'---CONTROL IDD, jcampos marca de aplica linea
'+++ cvegasan 2017.08.08 Control Lineas IDD
Global gsBac_Url_WebService As String
Global gsBac_Url_WebMethod As String
'--- cvegasan 2017.08.08 Control Lineas IDD

Public Function busca_usuario(NOMBRE)

    'declaracion de variables locales...
    Dim Datos()

    'preparo parametros para sp...
    envia = Array()
    AddParam envia, NOMBRE

    'recupero los datos del usuario nt...
    If Bac_Sql_Execute("SVA_GEN_USR_SIS", envia) Then

        Do While Bac_SQL_Fetch(Datos)
            Bac_Usr_cod = CDbl(Datos(1))
            Bac_Usr_lgn = Datos(2)
            Bac_Usr_nom = Datos(3)
            Bac_Usr_ofi = CDbl(Datos(4))
        Loop
    End If
End Function

Public Function Chequea_ControlProcesos(pareProceso As String) As Boolean
Dim varssql    As String
Dim Datos()
Dim ssql As String


'On Error GoTo ErrChequeo

    Chequea_ControlProcesos = False
    
    '+++jcamposd 20180411 COLTES, mejora no puede cerrar si existen operaciones pendientes
        Select Case pareProceso
        Case "CM"
            ssql = ""
            ssql = ssql & "EXECUTE SP_VERIFICA_OPERACIONES_PENDIENTES_CIERRE"
            ssql = ssql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "'"
                
            If Bac_Sql_Execute(ssql) Then
                Do While Bac_SQL_Fetch(Datos)
                      If Val(Datos(1)) <> 0 Then
                        MsgBox "Existen Operaciones pendientes de aprobación", vbCritical, gsBac_Version
                        Chequea_ControlProcesos = False
                        Exit Function
                    End If
                Loop
            End If
        End Select
    
    '---jcamposd 20180411 COLTES, mejora no puede cerrar si existen operaciones pendientes
    
    
    If Bac_Sql_Execute("SVC_GEN_PRA_DRI") Then
    
        Do While Bac_SQL_Fetch(Datos)
            
            Select Case pareProceso
                Case "CM"
                    If Val(Datos(5)) = 1 Then
                        MsgBox "Fin de Dia ya se Realizo", vbExclamation, gsBac_Version
                        Chequea_ControlProcesos = False
                        Exit Function
                    Else
                        Chequea_ControlProcesos = True
                        Exit Function
                    End If
'----------------------------------------------
                Case "TC"
                    If Datos(3) = 1 Then
                        If Datos(6) = 0 Then
                            MsgBox "Debe Realizar Proceso de Ajuste De Mercado", vbExclamation, gsBac_Version
                            Chequea_ControlProcesos = False
                            Exit Function
                        Else
                            Chequea_ControlProcesos = True
                            Exit Function
                        End If
                        If Datos(4) = 1 Then
                            MsgBox "Mesa Bloqueada", vbExclamation, gsBac_Version
                            Chequea_ControlProcesos = False
                            Exit Function
                        Else
                            Chequea_ControlProcesos = True
                            Exit Function
                        End If
                    Else
                            MsgBox "Debe Realizar Proceso Devengamiento", vbExclamation, gsBac_Version
                            Chequea_ControlProcesos = False
                            Exit Function
                    End If
                    
'----------------------------------------------
                Case "ID"   ' Inicio de día
                    ' 1.- Se valida que se haya realizado el fin de día
                    ' 2.- Se debe validar que no se haya realizado apertura de mesa
                    ' 3.- se debe validar que no se haya realizado
                    If Val(Datos(5)) = 1 Then
                        Chequea_ControlProcesos = True
                        Exit Function
                    Else
                        MsgBox "No se Ha Realizado el fin de Dia", vbExclamation, gsBac_Version
                        Chequea_ControlProcesos = False
                        Exit Function
                    End If
                    
'                    If Val(datos()) = 1 Then
'                        If Val(varvDataSql(7)) = 1 Then
'                            If Val(varvDataSql(1)) = 0 Then
'                                Chequea_ControlProcesos = True
'                                Exit Function
'                            Else
'                                MsgBox "Proceso de inicio de día ya realizado, continue con proceso  de apertura de mesa", vbExclamation, gsBac_Version
'                                Exit Function
'                            End If
'                        Else
'                            MsgBox " Se ha realizado el proceso correcto de cierre", vbExclamation, gsBac_Version
'                            Exit Function
'                        End If
'                    Else
'                        MsgBox "Proceso de fin de día no se ha realizado, Verifique control de procesos. ", vbExclamation, gsBac_Version
'                        Exit Function
'                    End If
                Case "OP" ' Operaciones
                    ' 1.- Se valida que se haya realizado el Inicio de día
                    ' 2.- Se debe validar que se haya realizado apertura de mesa
                    If Val(Datos(5)) = 0 Then
                        If Val(Datos(4)) = 1 Then
                            MsgBox "Mesa bloqueada", vbCritical, gsBac_Version
                            Chequea_ControlProcesos = False
                            Exit Function
                        Else
                            Chequea_ControlProcesos = True
                            Exit Function
                        End If
                    Else
                        MsgBox "Proceso de Inicio de día NO se ha realizado, Realice este proceso antes de ingresar operaciones.", vbExclamation, gsBac_Version
                        Exit Function
                        Chequea_ControlProcesos = False
                    End If
                    
                Case "DV" ' Devengamiento
                    ' 1.- Se debe verificar que el fin de dia no este realizado
                    ' 2.- Se debe realizar proceso de cierre de mesa
                    ' 3.- Se debe realizar proceso de reventas
                    ' 4.- Se debe realizar proceso de recompras
                
                
                    If Val(Datos(5)) = 1 Then
                       MsgBox "Proceso de fin de dia ya realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    If Val(Datos(4)) = 0 Then
                       MsgBox "Proceso bloqueo de mesa no realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    Chequea_ControlProcesos = True

                    
                Case "FD" ' Fin de día
                    ' 1.- Se debe verificar que el fin de dia no este realizado
                    ' 2.- Se debe realizar proceso de cierre de mesa
                    ' 3.- Se debe realizar proceso de contabilizacion
                    ' 4.- Se debe realizar proceso de devengamiento
                    ' 5.- Se debe realizar proceso de reventas
                    ' 6.- Se debe realizar proceso de recompras
                    ' 7.- se debe realizar proceso de valorizacion Mark to Market
                    
                    If Val(Datos(5)) = 1 Then
                       MsgBox "Proceso de fin de dia ya realizado.", vbExclamation, gsBac_Version
                       Chequea_ControlProcesos = False
                       Exit Function
                    End If
                    
                    If Val(Datos(3)) = 0 Then
                       MsgBox "Proceso de Devengamiento No se ha Realizado.", vbExclamation, gsBac_Version
                       Chequea_ControlProcesos = False
                       Exit Function
                    End If

                    
                    If Val(Datos(4)) = 0 Then
                       MsgBox "Proceso cierre de mesa no realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    
                    If Val(Datos(2)) = 0 Then
                       MsgBox "Proceso Contable no realizado.", vbExclamation, gsBac_Version
                       Chequea_ControlProcesos = False
                       Exit Function
                    End If
                    
                    If Val(Datos(6)) = 0 Then
                       MsgBox "Proceso Ajuste de Mercado no realizado.", vbExclamation, gsBac_Version
                       Chequea_ControlProcesos = False
                       Exit Function
                    End If
       
                    
                    Chequea_ControlProcesos = True
                Case "TM"
                    If Val(Datos(5)) = 0 Then
                        If Val(Datos(4)) = 0 Then
                            MsgBox "Mesa Debe Estar bloqueada", vbCritical, gsBac_Version
                            Chequea_ControlProcesos = False
                            Exit Function
                        End If
                    Else
                        MsgBox "Proceso de Inicio de día NO se ha realizado, Realice este proceso antes de ingresar operaciones. ", vbExclamation, gsBac_Version
                        Exit Function
                        Chequea_ControlProcesos = False
                    End If
                    If Val(Datos(3)) = 0 Then
                       MsgBox "Proceso de Devengamiento No se ha Realizado.", vbExclamation, gsBac_Version
                       Chequea_ControlProcesos = False
                       Exit Function
                    End If
                    Chequea_ControlProcesos = True
            
                Case "CTB" ' Devengamiento
                    ' 1.- Se debe verificar que el fin de dia no este realizado
                    ' 2.- Se debe realizar proceso de cierre de mesa
                    ' 3.- Se debe realizar proceso de devengamiento
                    ' 4.- Se debe realizar proceso de recompras
                
                
                    If Val(Datos(5)) = 1 Then
                       MsgBox "Proceso de fin de dia ya realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    If Val(Datos(4)) = 0 Then
                       MsgBox "Proceso bloqueo de mesa no realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    If Val(Datos(3)) = 0 Then
                       MsgBox "Proceso Devengo no realizado.", vbExclamation, gsBac_Version
                       Exit Function
                    End If
                    
                    
                    Chequea_ControlProcesos = True

            
            End Select
            Loop
    End If
    
    Exit Function
     
ErrChequeo:
    MsgBox "Problemas en chequeo de control procesos: " & err.Description & ". Verifique", vbCritical, gsBac_Version
    Exit Function
End Function

Sub BacIrfNueVentana(ByVal sTipOper$, Optional ByVal sNomlist As Variant)
Dim iNumVentana%
Dim FrmOpr As Form
    
    Screen.MousePointer = vbHourglass

  ' Halla el número de ventana correspondiente.-
    iNumVentana% = BacIrfNumVentana(sTipOper$)
    
    If iNumVentana% = 0 Then
        Screen.MousePointer = vbDefault
        Exit Sub
    End If
    
  ' Asigna el form dependiendo del tipo
    Select Case sTipOper$
            Case "CP": Set FrmOpr = New Bac_Compras: FrmOpr.bFlagDpx = False
            'Case "CU": Set FrmOpr = New BacCP: FrmOpr.bFlagDpx = True
            Case "VP": Set FrmOpr = New Bac_Ventas_Filtro ': FrmOpr.bFlagDpx = False
            'Case "VU": Set FrmOpr = New BacVP: FrmOpr.bFlagDpx = True
           ' Case "ST": Set FrmOpr = New BacVP
            'Case "CI": Set FrmOpr = New BacCI
           ' Case "VI": Set FrmOpr = New BacVI
           ' Case "RC": Set FrmOpr = New BacRcRv
          '  Case "RV": Set FrmOpr = New BacRcRv
 '           Case "IC": Set FrmOpr = New Ingreso_captaciones

            Case Else
                   Screen.MousePointer = vbDefault
                   Exit Sub
    End Select
            
        
    ' Asigna el Tag para identificar al Form
    If sTipOper$ = "LI" Then
        FrmOpr.Tag = sTipOper$ & Format$(iNumVentana%, "00") & sNomlist
    Else
        FrmOpr.Tag = sTipOper$ & Format$(iNumVentana%, "00")
    End If
        
  ' Setean el Caption del form para la ventana correspondiente
    Select Case sTipOper$
           Case "CP": FrmOpr.Caption = iNumVentana% & ".- Compra Propia"
           Case "CU": FrmOpr.Caption = iNumVentana% & ".- Compra a Termino en dolares"
           Case "CU": FrmOpr.Caption = iNumVentana% & ".- Venta a Termino en dolares"
           Case "VP": FrmOpr.Caption = iNumVentana% & ".- Venta Definitiva"
           Case "ST": FrmOpr.Caption = iNumVentana% & ".- Sorteo de Letras"
           Case "CI": FrmOpr.Caption = iNumVentana% & ".- Compra con Pacto"
           Case "VI": FrmOpr.Caption = iNumVentana% & ".- Venta con Pacto"
           Case "RC": FrmOpr.Caption = iNumVentana% & ".- Recompra Anticipada"
           Case "RV": FrmOpr.Caption = iNumVentana% & ".- Reventa Anticipada"
           Case "LI": FrmOpr.Caption = iNumVentana% & ".- Listados"
           Case "IC": FrmOpr.Caption = iNumVentana% & ".- Ingreso de Captaciones"
    End Select
    
    FrmOpr.Show vbNormal
    
    Screen.MousePointer = vbDefault
    
End Sub

Function BacIrfNumVentana(sTipOper$) As Integer

'--------------------------------------------------------------------------
'Calcula el numero de ventana que corresponde
'En el Tag de guarda el tipo de ventana (Ej.: CP,CI,...) mas el correlativo
'de la ventana (CP01,CI03)
'De hecho el gcNumeroMaximo de ventanas debe ser menor a 10 y mayor a uno
'Devuelve 0 si excedió el numero maximo de ventanas
'-------------------------------------------------------------------------

 Dim i%, iUltVentana%, cInfo$
Dim iNumVentanas As Integer
 iNumVentanas% = 0
 For i% = 1 To Forms.Count
 
        cInfo$ = Forms(i% - 1).Tag
        If Mid$(cInfo$, 1, 2) = sTipOper$ Then
              
               iNumVentanas% = iNumVentanas% + 1
               iUltVentana% = Val(Mid$(cInfo$, 3, 2))
            
        End If
Next i%
    
If iNumVentanas% > gcMaximoVentanas Then
        MsgBox "NUMERO MAXIMO DE VENTANAS ABIERTAS EXCEDIDO", vbExclamation, gsBac_Version
        BacIrfNumVentana = 0
        iNumVentanas% = 1
Else
        If iNumVentanas% = 0 Then
               BacIrfNumVentana = 1
        Else
               BacIrfNumVentana = iNumVentanas% + 1
        End If
        
End If

End Function

Public Function guardar_hora_proceso(sw, Hora, Fecha)
    Dim Datos()
    Dim SQL
    envia = Array()
    AddParam envia, sw
    AddParam envia, Fecha
    If Bac_Sql_Execute("SVC_GEN_ACT_HOR ", envia) Then
        Do While Bac_SQL_Fetch(Datos)
        Loop
    End If
End Function

Sub limpiar_cristal()
Dim i As Integer

   For i = 0 To 20
        BAC_INVERSIONES.BacRpt.StoredProcParam(i) = ""
        BAC_INVERSIONES.BacRpt.Formulas(i) = ""
        BAC_INVERSIONES.BacRpt.SubreportToChange = ""
   Next i
   
   BAC_INVERSIONES.BacRpt.WindowTitle = ""
   BAC_INVERSIONES.BacRpt.Destination = crptToWindow
   BAC_INVERSIONES.BacRpt.CopiesToPrinter = 0

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



Public Function BACValIngNumGrid(ByVal KeyValue As Integer) As Integer
'   Function    :   BACValIngNumGrid
'   Objetivo    :   Valida el ingreso de no numericos en la grillas
'   Autor       :   Victor Barra
'   Fecha       :   Febrero 2000
'==============================================================================
    
    If Not IsNumeric(Chr(KeyValue)) And (KeyValue <> 44 And KeyValue <> 46 And KeyValue <> 8 And KeyValue <> 45) Then
        KeyValue = 0
    End If
    
    BACValIngNumGrid = KeyValue
    
End Function


Sub BacToUCase(ByRef KeyAscii As Integer)
    
    If KeyAscii = 39 Or KeyAscii = 34 Then ' Revisa comillas
       KeyAscii = 0
    End If

    If KeyAscii >= 97 Or KeyAscii <= 122 Then
       KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
    End If
    
End Sub


Public Function Proc_Valida_Fecha() As Boolean
    '=========================================================================
    'SubRutina   :   Proc_Carga_parametros
    'Objetivo    :   Verifica la fecha del sistema sea igual a la fecha MDAC
    'Fecha       :   Septiembre, 2013
    'Autor       :   Alejandro Contreras G.
    '=========================================================================
Dim cSql    As String
Dim Datos()
Dim xSistema As String
xSistema = "BEX"

On Error GoTo ErrTeso

    Proc_Valida_Fecha = False

    cSql = ""
    cSql = cSql & "EXECUTE Sp_Valida_Fechas_Cierre "
    cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "', "
    cSql = cSql & CStr(xSistema) & " "
        
        
    If Bac_Sql_Execute(cSql) Then
        Do While Bac_SQL_Fetch(Datos)
              If Val(Datos(1)) <> 0 Then
                MsgBox "Fechas no coinciden, la del Sistema con la de Proceso, el Sistema se Cerrará", vbCritical, gsBac_Version
                Exit Function
            End If
        Loop
    End If
    
    Proc_Valida_Fecha = True
    Exit Function
ErrTeso:
    MsgBox "Problemas con Procedimiento Sp_Valida_Fechas_Cierre : " & err.Description & ". Verifique.", vbCritical, gsBac_Version
    Exit Function
End Function


