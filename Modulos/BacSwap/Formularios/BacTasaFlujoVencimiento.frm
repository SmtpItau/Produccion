VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacTasaFlujoVencimiento 
   Caption         =   "Ingreso de tipos de cambio al vencimiento del flujo"
   ClientHeight    =   7395
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   13380
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   7395
   ScaleWidth      =   13380
   Begin VB.Frame Frame1 
      Height          =   555
      Left            =   60
      TabIndex        =   3
      Top             =   1050
      Width           =   11310
      Begin BACControles.TXTFecha txtFechaOperacion 
         Height          =   375
         Left            =   6840
         TabIndex        =   7
         Top             =   120
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/10/2000"
      End
      Begin VB.Label lblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Fecha"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   7
         Left            =   6150
         TabIndex        =   8
         Top             =   210
         Width           =   540
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   390
      Top             =   3630
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTasaFlujoVencimiento.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTasaFlujoVencimiento.frx":031A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTasaFlujoVencimiento.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTasaFlujoVencimiento.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTasaFlujoVencimiento.frx":1A98
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTasaFlujoVencimiento.frx":1DB2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   13380
      _ExtentX        =   23601
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdLimpiar"
            Description     =   "CmdLimpiar"
            Object.ToolTipText     =   "Limpiar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdBuscar"
            Description     =   "CmdBuscar"
            Object.ToolTipText     =   "Buscar Operaciones"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdGrabar"
            Description     =   "CmdGrabar"
            Object.ToolTipText     =   "Grabar Datos"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdSalir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "CmdReCalcula"
            Object.ToolTipText     =   "ReCalcula TC"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "CmdFiltrar"
            Description     =   "CmdFiltrar"
            Object.ToolTipText     =   "Filtro por Fechas"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame frame 
      Height          =   600
      Index           =   3
      Left            =   0
      TabIndex        =   1
      Top             =   450
      Width           =   11370
      _Version        =   65536
      _ExtentX        =   20055
      _ExtentY        =   1058
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         BackColor       =   &H00800000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "INGRESO DE TIPOS DE CAMBIO AL VENCIMIENTO DE LOS  FLUJOS"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   450
         Left            =   60
         TabIndex        =   2
         Top             =   120
         Width           =   11280
      End
   End
   Begin Threed.SSFrame frame 
      Height          =   4470
      Index           =   1
      Left            =   30
      TabIndex        =   4
      Top             =   1590
      Width           =   11325
      _Version        =   65536
      _ExtentX        =   19976
      _ExtentY        =   7885
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox Txt_Ingreso 
         BackColor       =   &H00800000&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   270
         Left            =   4140
         TabIndex        =   5
         Top             =   1860
         Visible         =   0   'False
         Width           =   1185
      End
      Begin MSFlexGridLib.MSFlexGrid mfgFlujos 
         Height          =   4260
         Left            =   60
         TabIndex        =   6
         Top             =   120
         Width           =   11190
         _ExtentX        =   19738
         _ExtentY        =   7514
         _Version        =   393216
         Cols            =   12
         FixedCols       =   0
         BackColor       =   -2147483644
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Label LblMsgProceso 
      Height          =   195
      Left            =   90
      TabIndex        =   9
      Top             =   7110
      Width           =   4095
   End
End
Attribute VB_Name = "BacTasaFlujoVencimiento"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'***********************************************************
' PROGRAMADOR   :   PATRICIO FERNANDEZ I.
' FECHA         :   10-02-2015
' REQUERIMIENTO :   PRD 21657
'***********************************************************
Option Explicit
Dim SQL   As String
Dim DatosQuery()
Dim FecProcAnt As Date
Dim lRowSel As Long
Dim lColSel As Long
Dim blnEscribeMonto As Boolean
Dim strFilasRevisa As String


'CONSTANTES DEL FORMULARIO
Const Chile = 6
Const EstadosUnidos = 225
Const Inglaterra = 510
Sub Dibuja_Grilla()

   mfgFlujos.Cols = 37 '35
   mfgFlujos.TextMatrix(0, 0) = ""
   mfgFlujos.TextMatrix(0, 1) = "Oper." 'Nro operacion
   mfgFlujos.TextMatrix(0, 2) = "Flujo" 'Nro de flujo
   mfgFlujos.TextMatrix(0, 3) = "Tipo"  '-- Tipo Flujo
   mfgFlujos.TextMatrix(0, 4) = "Swap"  '-- Tipo Swap
   mfgFlujos.TextMatrix(0, 5) = "Fec.Liquida"
   mfgFlujos.TextMatrix(0, 6) = "Cliente"
   mfgFlujos.TextMatrix(0, 7) = "Tipo Cliente"
   mfgFlujos.TextMatrix(0, 8) = "Valor TC"
   mfgFlujos.TextMatrix(0, 9) = "Mda. Cap."
   mfgFlujos.TextMatrix(0, 10) = "Modalidad"
   mfgFlujos.TextMatrix(0, 11) = "Ref.Usd"      '-- Fecha Ref. Mercado
   mfgFlujos.TextMatrix(0, 12) = "Dias"       '-- Dias ref. mercado
   mfgFlujos.TextMatrix(0, 13) = "TC"
   mfgFlujos.TextMatrix(0, 14) = "CodProducto"
   mfgFlujos.TextMatrix(0, 15) = "Mda.Pago"
   mfgFlujos.TextMatrix(0, 16) = "Feriados Chile"
   mfgFlujos.TextMatrix(0, 17) = "Feriados USA"
   mfgFlujos.TextMatrix(0, 18) = "Feriados ENG"
   mfgFlujos.TextMatrix(0, 19) = "CodMoneda"
   mfgFlujos.TextMatrix(0, 20) = "CodMonCompensa"
   mfgFlujos.TextMatrix(0, 21) = "DigitaSN"
   mfgFlujos.TextMatrix(0, 22) = "CodModalidad"
   mfgFlujos.TextMatrix(0, 23) = "Paridad"
   mfgFlujos.TextMatrix(0, 24) = "RequiereTCM"
   mfgFlujos.TextMatrix(0, 25) = "RequiereParidad"
   mfgFlujos.TextMatrix(0, 26) = "MxCap"  'Mda capital es extranjera
   mfgFlujos.TextMatrix(0, 27) = "MxLiq"  'Mda liquidacion es extranjera
   mfgFlujos.TextMatrix(0, 28) = "MinTCM" 'Valor minimo USD observado
   mfgFlujos.TextMatrix(0, 29) = "MaxTCM" 'Valor maximo USD observado
   mfgFlujos.TextMatrix(0, 30) = "MaxPar" 'Valor maximo Paridad
   mfgFlujos.TextMatrix(0, 31) = "MinPar" 'Valor minimo Paridad
   mfgFlujos.TextMatrix(0, 32) = "MdaParidad" 'Moneda que requiere paridad
   mfgFlujos.TextMatrix(0, 33) = "Indicación" 'Moneda que requiere paridad
   mfgFlujos.TextMatrix(0, 34) = "Cod Mda Cap" 'Codigo Mda Capital
   mfgFlujos.TextMatrix(0, 35) = "Ref. Mx"      'fecha Ref Mercado Mx
   mfgFlujos.TextMatrix(0, 36) = "Dias"        'Dias Ref Mercado Mx
   mfgFlujos.RowHeight(0) = 300
   mfgFlujos.ColAlignment(0) = 4:   mfgFlujos.ColWidth(0) = 300
   mfgFlujos.ColAlignment(1) = 4:   mfgFlujos.ColWidth(1) = 800
   mfgFlujos.ColAlignment(2) = 4:   mfgFlujos.ColWidth(2) = 700
   mfgFlujos.ColAlignment(3) = 4:   mfgFlujos.ColWidth(3) = 700
   mfgFlujos.ColAlignment(4) = 4:   mfgFlujos.ColWidth(4) = 800
   mfgFlujos.ColAlignment(5) = 4:   mfgFlujos.ColWidth(5) = 1000
   mfgFlujos.ColAlignment(6) = 0:   mfgFlujos.ColWidth(6) = 3500
   mfgFlujos.ColAlignment(7) = 4:   mfgFlujos.ColWidth(7) = 1725
   mfgFlujos.ColAlignment(8) = 4:   mfgFlujos.ColWidth(8) = 820
   mfgFlujos.ColAlignment(9) = 4:   mfgFlujos.ColWidth(9) = 900
   mfgFlujos.ColAlignment(10) = 4:   mfgFlujos.ColWidth(10) = 800
   mfgFlujos.ColAlignment(11) = 4:  mfgFlujos.ColWidth(11) = 1000
   mfgFlujos.ColAlignment(12) = 4:   mfgFlujos.ColWidth(12) = 500  '<--
   mfgFlujos.ColAlignment(13) = 4:   mfgFlujos.ColWidth(13) = 1100 '<--
   mfgFlujos.ColAlignment(14) = 7:   mfgFlujos.ColWidth(14) = 0
   mfgFlujos.ColAlignment(15) = 4:   mfgFlujos.ColWidth(15) = 850
   mfgFlujos.ColAlignment(16) = 7:   mfgFlujos.ColWidth(16) = 0
   mfgFlujos.ColAlignment(17) = 7:   mfgFlujos.ColWidth(17) = 0
   mfgFlujos.ColAlignment(18) = 7:   mfgFlujos.ColWidth(18) = 0
   mfgFlujos.ColAlignment(19) = 7:   mfgFlujos.ColWidth(19) = 0
   mfgFlujos.ColAlignment(20) = 7:   mfgFlujos.ColWidth(20) = 0
   mfgFlujos.ColAlignment(21) = 7:   mfgFlujos.ColWidth(21) = 750
   mfgFlujos.ColAlignment(22) = 7:   mfgFlujos.ColWidth(22) = 0
   mfgFlujos.ColAlignment(23) = 7:   mfgFlujos.ColWidth(23) = 800
   mfgFlujos.ColAlignment(24) = 7:   mfgFlujos.ColWidth(24) = 0
   mfgFlujos.ColAlignment(25) = 7:   mfgFlujos.ColWidth(25) = 0
   mfgFlujos.ColAlignment(26) = 7:   mfgFlujos.ColWidth(26) = 0
   mfgFlujos.ColAlignment(27) = 7:   mfgFlujos.ColWidth(27) = 0
   mfgFlujos.ColAlignment(28) = 7:   mfgFlujos.ColWidth(28) = 0
   mfgFlujos.ColAlignment(29) = 7:   mfgFlujos.ColWidth(29) = 0
   mfgFlujos.ColAlignment(30) = 7:   mfgFlujos.ColWidth(30) = 0
   mfgFlujos.ColAlignment(31) = 7:   mfgFlujos.ColWidth(31) = 0
   mfgFlujos.ColAlignment(32) = 7:   mfgFlujos.ColWidth(32) = 0
   mfgFlujos.ColAlignment(33) = 7:   mfgFlujos.ColWidth(33) = 800
   mfgFlujos.ColAlignment(34) = 7:   mfgFlujos.ColWidth(34) = 0
   mfgFlujos.ColAlignment(35) = 7:   mfgFlujos.ColWidth(35) = 1000
   mfgFlujos.ColAlignment(36) = 7:   mfgFlujos.ColWidth(36) = 500
End Sub
Private Sub cmdBuscar()

If gstrFechaOrigen <> "" And gstrFechaFinal <> "" Then
    Call TraeFlujosByFiltros(gstrFechaOrigen, gstrFechaFinal)
Else
    Call TraeFlujosByFecha(txtFechaOperacion.Text)
End If
'gstrFechaOrigen = ""
'gstrFechaFinal = ""
End Sub
Private Sub TraeFlujosByFecha(strFechaLiquida As String)
 Dim nNumero             As Double
    Dim Fecha               As Date
    Dim nIndicador          As Integer
    Dim intFila             As Integer
    Dim dtFecFin            As Date
    Dim strFechaFila        As String
    Dim strFechaBusqueda    As String
    Dim strFechaInicio      As String
    Dim strFechaTermino    As String
    Dim strFeriadosLiq      As String
    Dim lngNroOperacionPaso As Long
    Dim lngNroFlujoPaso     As Long
    Dim lngTipoFlujoPaso     As Long
    
    Dim dblValorFinal       As Double
    Dim dblValorPasivo       As Double
    Dim dblValorActivo       As Double
    
    intFila = 0
    Let Screen.MousePointer = vbHourglass
    
    'INHABILITO BOTON REPROCESO TC
    Toolbar1.Buttons(5).Enabled = False
    'INHABILITO BOTON GRABAR
    Toolbar1.Buttons(3).Enabled = False
    
    Let mfgFlujos.Redraw = False
    
    'OBTENGO FECHA SELECCIONADA POR EL USUARIO
    'strFechaBusqueda = strFechaLiquida
    'strFeriadosLiq = ""
    
    'ASIGNO FECHA INICIO CON FECHA DEL FILTRO DE BUSQUEDA
    'strFechaInicio = strFechaBusqueda
    
 
    '****************************************************************
    ' REVISO SI FECHAS PREVIAS AL FIN DEL FLUJO SON FECHAS INHABILES
    '****************************************************************
    'strFechaInicio = strGetFechaInicialConsulta(strFechaBusqueda)
    '********************************************************************
    ' REVISO SI FECHAS POSTERIORES AL FIN DEL FLUJO SON FECHAS INHABILES
    '********************************************************************
    'If blnFechaSiguienteValida(strFechaBusqueda) = True Then
    '   strFechaTermino = strFechaBusqueda
    'Else
     '  strFechaTermino = strGetFechaFinalConsulta(strFechaBusqueda)
    'End If
    
    '*********************************************************************
    '   REALIZO CONSULTA DE FLUJOS CON VENCIMIENTO EN FECHA SELECCIONADA
    '*********************************************************************
    Envia = Array()
    AddParam Envia, txtFechaOperacion.Text  'strFechaInicio
    AddParam Envia, txtFechaOperacion.Text  'strFechaTermino
    If Not Bac_Sql_Execute("dbo.SP_CONSULTAVENCIMIENTOSFLUJOS", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Problemas al leer procedimiento  " & vbCrLf & "SP_CONSULTAVENCIMIENTOSFLUJOS", vbCritical, TITSISTEMA)
        Exit Sub
    End If
    
    '*********************************************************************
    '  CARGO GRILLA CON REGISTROS OBTENIDOS DEL SP
    '*********************************************************************


    Call LlenaDatosGrilla
    strFechaFila = ""
    
    Let Screen.MousePointer = vbDefault
    Let mfgFlujos.Redraw = True
    If mfgFlujos.Rows < 2 Then
        Call CmdLimpiar
    Else
        frame(1).Enabled = True
        mfgFlujos.Redraw = True
        Toolbar1.Buttons(3).Enabled = True 'Permitir ejecutar Grabacion liquidaciones
        If CDate(txtFechaOperacion.Text) > CDate(gsBAC_Fecp) Then
       ' If CDate(strFechaInicio) > CDate(gsBAC_Fecp) Then
            'INHABILITO BOTON REPROCESO TC
            Toolbar1.Buttons(5).Enabled = False
            'Toolbar1.Buttons(6).Enabled = False
        Else
            'HABILITO BOTON REPROCESO TC
            Toolbar1.Buttons(5).Enabled = True
             'Toolbar1.Buttons(6).Enabled = True
        End If
    End If
  
End Sub
Private Sub TraeFlujosByFiltros(strFecIni As String, strFechaFin As String)
'Eliminar esta funcionalidad
'Solo se podrá ver para la fecha de proceso

    Dim nNumero             As Double
    Dim Fecha               As Date
    Dim nIndicador          As Integer
    Dim intFila             As Integer
    Dim dtFecFin            As Date
    Dim strFechaFila        As String
    Dim strFechaBusqueda    As String
    Dim strFechaInicio      As String
    Dim strFechaTermino    As String
    Dim strFeriadosLiq      As String
    Dim lngNroOperacionPaso As Long
    Dim lngNroFlujoPaso     As Long
    Dim lngTipoFlujoPaso     As Long
    
    Dim dblValorFinal       As Double
    Dim dblValorPasivo       As Double
    Dim dblValorActivo       As Double
    
    intFila = 0
    Let Screen.MousePointer = vbHourglass
    
    'INHABILITO BOTON REPROCESO TC
    Toolbar1.Buttons(5).Enabled = False
    'INHABILITO BOTON GRABAR
    Toolbar1.Buttons(3).Enabled = False
    Let mfgFlujos.Redraw = False

    
    Envia = Array()
    AddParam Envia, gstrFechaOrigen 'fecha correspondiente a form filtro fechas combobox 1
    AddParam Envia, gstrFechaFinal 'fecha correspondiente a form filtro fechas combobox 2
    If Not Bac_Sql_Execute("dbo.SP_CONSULTAVENCIMIENTOSFLUJOS", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Problemas al leer procedimiento  " & vbCrLf & "SP_CONSULTAVENCIMIENTOSFLUJOS", vbCritical, TITSISTEMA)
        Exit Sub
    End If
    
    '*********************************************************************
    '  CARGO GRILLA CON REGISTROS OBTENIDOS DEL SP
    '*********************************************************************
    Call LlenaDatosGrilla
        
        
    Let Screen.MousePointer = vbDefault
    Let mfgFlujos.Redraw = True
    If mfgFlujos.Rows < 2 Then
       Call CmdLimpiar
    Else
        frame(1).Enabled = True
        mfgFlujos.Redraw = True
        If CDate(strFecIni) > CDate(gsBAC_Fecp) Or gstrFechaOrigen > CDate(gsBAC_Fecp) Or gstrFechaFinal > CDate(gsBAC_Fecp) Then
            'INHABILITO BOTON REPROCESO TC
            Toolbar1.Buttons(5).Enabled = False
        Else
            'HABILITO BOTON REPROCESO TC
            Toolbar1.Buttons(5).Enabled = True
        End If
    End If
End Sub
Private Sub LlenaDatosGrilla()
Dim dblTC As Double
dblTC = 0

    Let mfgFlujos.Rows = 1
    Let mfgFlujos.TextMatrix(0, 5) = "Fec.Liquida"
    Do While Bac_SQL_Fetch(DatosQuery())
        Call BacControlWindows(1)
        Let mfgFlujos.Rows = mfgFlujos.Rows + 1
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 1) = DatosQuery(2)                                                 ' Numero Operación
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 2) = DatosQuery(7)                                                 ' Numero de Flujo
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 3) = DatosQuery(24)                                                ' Tipo de Flujo
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 4) = DatosQuery(1)                                                 ' Tipo Swap
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 5) = DatosQuery(12)                                                ' Fecha Liquidación Flujo
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 6) = DatosQuery(3)                                                 ' Nombre Cliente
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 7) = DatosQuery(26)                                                ' Tipo Cliente
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 8) = BacFormatoMonto(DatosQuery(19), 4)                            ' Valor TC
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 9) = DatosQuery(6)                                                 ' Moneda
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 10) = DatosQuery(9)                                                ' Modalidad
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 11) = DatosQuery(43)  '12 la fecha liquida                                               'Fecha Efectiva
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 12) = DatosQuery(25)                                               ' Valor Referencia Mercado
        
        dblTC = CDbl(DatosQuery(29))
        If dblTC <> 0 Then
            mfgFlujos.Row = mfgFlujos.Rows - 1
            mfgFlujos.Col = 13
            mfgFlujos.CellFontBold = True
            mfgFlujos.CellFontItalic = True
            mfgFlujos.Text = BacFormatoMonto(DatosQuery(29), 4)         '' Valor TC Propuesto
        Else
            Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 13) = "" 'BacFormatoMonto(DatosQuery(29), 4)                           ' Valor TC Propuesto
        End If
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 14) = DatosQuery(10)                                               ' Cod Producto
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 15) = DatosQuery(27)                                               ' Moneda Compensa
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 16) = DatosQuery(20)                                               ' Modalidad Pago
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 17) = DatosQuery(16)                                               ' Feriados CL
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 18) = DatosQuery(17)                                               ' Feriados USA
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 19) = DatosQuery(18)                                               ' Feriado ENG
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 20) = DatosQuery(28) 'Moneda Pago                                              ' CodMonedaCompensa
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 21) = DatosQuery(30) '"N"                                                          ' DigitaSN
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 22) = DatosQuery(20) ' CodModalidad
        
        Let dblTC = DatosQuery(31) 'Paridad
        If dblTC <> 0 Then
            mfgFlujos.Row = mfgFlujos.Rows - 1
            mfgFlujos.Col = 23
            mfgFlujos.CellFontBold = True
            mfgFlujos.CellFontItalic = True
            mfgFlujos.Text = BacFormatoMonto(DatosQuery(31), 6)         '' Valor Paridad Propuesta
        Else
            Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 23) = ""
        End If
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 24) = DatosQuery(32) 'Requiere TCM
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 25) = DatosQuery(33) 'Requiere Paridad2
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 26) = DatosQuery(34) 'Mda Cap. es extranjera "C" o no ""
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 27) = DatosQuery(35) 'Mda Liq. es extranjera "C" o no ""
        
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 28) = DatosQuery(36) 'Valor Minimo TCM
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 29) = DatosQuery(37) 'Valor Maximo TCM
        
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 30) = DatosQuery(38) 'Valor Minimo Paridad
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 31) = DatosQuery(39) 'Valor Maximo Paridad
        
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 32) = DatosQuery(40) 'Moneda que requiere paridad
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 33) = DatosQuery(41) 'Desc Moneda que req. paridad

        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 34) = CInt(DatosQuery(21)) + CInt(DatosQuery(22))    'Codigo Mda Cap.
        
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 35) = DatosQuery(44) '-- Fecha Ref Mx
        Let mfgFlujos.TextMatrix(mfgFlujos.Rows - 1, 36) = DatosQuery(42) '-- dias Ref Mx
 Loop
End Sub
Private Sub MarcaFila(intFila As Integer)

    mfgFlujos.Row = intFila
    mfgFlujos.Col = 0
    mfgFlujos.CellForeColor = &HC0&
    mfgFlujos.CellFontBold = True
    mfgFlujos.Text = "¤"
    Toolbar1.Buttons(5).Enabled = True
    mfgFlujos.Col = lColSel
End Sub
Private Sub MarcaColumna()
  If Not Toolbar1.Buttons(5).Enabled Then
    MsgBox "No se puede realizar operación a días futuros"
    Else
    mfgFlujos.Row = mfgFlujos.RowSel
    mfgFlujos.Col = 0
    If mfgFlujos.Text = "¤" Then
       mfgFlujos.Col = 0
       mfgFlujos.CellForeColor = &HC0&
       mfgFlujos.CellFontBold = True
       mfgFlujos.Text = ""
    Else
       mfgFlujos.Col = 0
       mfgFlujos.CellForeColor = &HC0&
       mfgFlujos.CellFontBold = True
       mfgFlujos.Text = "¤"
       Toolbar1.Buttons(5).Enabled = True
    End If
    End If
End Sub
Private Sub PintaFila(intFila As Integer, vbColor As OLE_COLOR)
Dim i As Integer
mfgFlujos.Row = intFila
For i = 1 To mfgFlujos.Cols - 1
    mfgFlujos.Col = i
    mfgFlujos.CellBackColor = vbColor
Next
End Sub
Private Sub cmdGrabar()
MousePointer = vbHourglass
If blnExisteSeleccion(mfgFlujos) = True Then
     If blnExistenSeleccionConCero(mfgFlujos) = False Then
         If blnVariacionIngresoValida(mfgFlujos) = False Then
             LblMsgProceso.Caption = "Grabando Valores Conversion ..."
             If GrabaFlujos Then
                LblMsgProceso.Caption = "Ejecutando Proceso Liquidacion ..."
                
                Call BacGeneral.EjecutaProcesoCalculoLiquidaciones
                LblMsgProceso.Caption = "Grabacion Terminada ..."
                
                Toolbar1.Buttons(5).Enabled = False
                Toolbar1.Buttons(3).Enabled = False
                Call cmdBuscar
             Else
                Toolbar1.Buttons(5).Enabled = True
                Toolbar1.Buttons(3).Enabled = True
             End If
             
         Else
             MsgBox " Existen flujos con variaciones en los tipos de cambio, superior al 20% ", vbInformation, "Revisar Variación de TC en los flujos destacados"
             
         End If
     Else
          MsgBox " Existen flujos modificados con valores de TC con valor 0, Debe actualizar valor de TC antes de continuar", vbInformation, TITSISTEMA
          
     End If
Else
     MsgBox "No Existen Flujos seleccionados, Debe Seleccionar flujo antes de continuar", vbInformation, TITSISTEMA
    
End If
MousePointer = vbDefault
End Sub
Private Function blnVariacionIngresoValida(grilla As MSFlexGrid)
Dim i As Integer
Dim dblValorOriginal    As Double
Dim dblValorNuevo       As Double
Dim dblVariacion        As Double
Dim blnResult           As Boolean

blnResult = False
i = 1
Do While i < grilla.Rows
    If Trim(grilla.TextMatrix(i, 0)) <> "" Then
        ' Obtengo valores desde grilla de los flujos
        If grilla.TextMatrix(i, 14) <> "" And grilla.TextMatrix(i, 13) <> "" Then
            dblValorOriginal = CDbl(grilla.TextMatrix(i, 14))
            dblValorNuevo = CDbl(grilla.TextMatrix(i, 13))
            dblVariacion = 0
            ' Valido que el valor del TC propuesto sea diferente a 0
            If dblValorNuevo <> 0 And dblValorOriginal <> 1 Then '********22-05-2015
                ' Obtengo la variación.
                If TC <> 0 Then
                   dblVariacion = Abs(dblValorNuevo - TC) / TC 'dblValorOriginal) / dblValorOriginal
                End If
                ' analiza variacion obtenido
                If (dblVariacion * 100) > 20 Then
                    If Len(strFilasRevisa) > 0 Then
                         strFilasRevisa = strFilasRevisa + "," + i
                    Else
                         strFilasRevisa = i
                    End If
                    ' analiza variacion obtenido
                    Call PintaFila(i, vbCyan)
                    blnResult = True
                End If
            End If
        End If
    End If
    i = i + 1
Loop
'RETORNO RESULTADO DE LA FUNCION
blnVariacionIngresoValida = blnResult
End Function
Private Function blnExistenSeleccionConCero(grilla As MSFlexGrid) As Boolean
blnExistenSeleccionConCero = False
Dim i As Integer
i = 1
Do While i < grilla.Rows
    If Trim(grilla.TextMatrix(i, 0)) <> "" Then
        If grilla.TextMatrix(i, 13) = "" And grilla.TextMatrix(i, 23) = "" Then
            blnExistenSeleccionConCero = True
            Exit Function
        End If
    End If
    i = i + 1
Loop
End Function
Private Function blnExisteSeleccion(grilla As MSFlexGrid) As Boolean
blnExisteSeleccion = False
Dim i As Integer
i = 1
Do While i < grilla.Rows
    If Trim(grilla.TextMatrix(i, 0)) <> "" Then
        blnExisteSeleccion = True
        Exit Function
    End If
    i = i + 1
Loop
End Function
Private Function GrabaFlujos() As Boolean
Dim X As Integer
Dim blnSuccess As Boolean
Dim sValor1 As String
Dim sValor2 As String
Dim Valor1 As Double
Dim Valor2 As Double

Dim sValor3 As String
Dim sValor4 As String
Dim Valor3 As Double
Dim Valor4 As Double


Dim sMsgNroOperacion As String

blnSuccess = False
For X = 1 To mfgFlujos.Rows - 1
     If X + 1 <= mfgFlujos.Rows - 1 Then
     '-- Validacion TCM
     Let sValor1 = mfgFlujos.TextMatrix(X, 13)
     Let sValor2 = mfgFlujos.TextMatrix(X + 1, 13)
     Let Valor1 = 0
     Let Valor2 = 0
     
     '-- Validacion Paridad
     Let sValor3 = mfgFlujos.TextMatrix(X, 23)
     Let sValor4 = mfgFlujos.TextMatrix(X + 1, 23)
     Let Valor3 = 0
     Let Valor4 = 0
     
     
     If sValor1 <> "" Then
       Let Valor1 = CDbl(sValor1)
     End If
     If sValor2 <> "" Then
       Let Valor2 = CDbl(sValor2)
     End If
     'En una misma Operación
     If CDbl(mfgFlujos.TextMatrix(X, 1)) = CDbl(mfgFlujos.TextMatrix(X + 1, 1)) Then
         Let sMsgNroOperacion = " en Op N° " + Trim(mfgFlujos.TextMatrix(X, 1))
         'Monedas Capital iguales?
         If mfgFlujos.TextMatrix(X, 9) = mfgFlujos.TextMatrix(X + 1, 9) Then
            'Monedas Compensación Iguales?
            If mfgFlujos.TextMatrix(X, 15) = mfgFlujos.TextMatrix(X + 1, 15) Then
               If Valor1 <> Valor2 Then
                   MsgBox "Error: TCM distinto " + sMsgNroOperacion
                   Let GrabaFlujos = blnSuccess
                   Exit Function
               End If
               If Valor3 <> Valor4 Then
                   MsgBox "Error: PARIDAD distinta " + sMsgNroOperacion
                   Let GrabaFlujos = blnSuccess
                   Exit Function
               End If
            Else
               'Monedas Compensadas dististas
               If Valor1 <> Valor2 Then
                   If MsgBox("Advertencia: TCM distinto " + sMsgNroOperacion + " Continua?", vbQuestion + vbYesNo, "Confirmar") = vbNo Then
                        GrabaFlujos = blnSuccess
                        Exit Function
                   End If
               End If
               If Valor3 <> Valor4 Then
                   If MsgBox("Advertencia: PARIDAD distinta " + sMsgNroOperacion + " Continua?", vbQuestion + vbYesNo, "Confirmar") = vbNo Then
                        GrabaFlujos = blnSuccess
                        Exit Function
                   End If
               End If
            End If
         Else
             'Monedas Capital distintas
             If Valor1 <> Valor2 Then
                If MsgBox("Advertencia: TCM distinto " + sMsgNroOperacion + " Continua?", vbQuestion + vbYesNo, "Confirmar") = vbNo Then
                    GrabaFlujos = blnSuccess
                    Exit Function
                End If
             End If
             If Valor3 <> Valor4 Then
                If MsgBox("Advertencia: PARIDAD distinta " + sMsgNroOperacion + " Continua?", vbQuestion + vbYesNo, "Confirmar") = vbNo Then
                    GrabaFlujos = blnSuccess
                    Exit Function
                End If
             End If
             
         End If
     End If
     End If
Next X

For X = 1 To mfgFlujos.Rows - 1
   If Trim(mfgFlujos.TextMatrix(X, 0)) <> "" Then
         If mfgFlujos.TextMatrix(X, 13) <> "" Then
                Envia = Array()
                AddParam Envia, CDbl(mfgFlujos.TextMatrix(X, 1))
                AddParam Envia, CDbl(mfgFlujos.TextMatrix(X, 2))
                AddParam Envia, CDbl(mfgFlujos.TextMatrix(X, 3))
                AddParam Envia, CDate(mfgFlujos.TextMatrix(X, 11))
                AddParam Envia, CDbl(mfgFlujos.TextMatrix(X, 13))
                AddParam Envia, Trim(mfgFlujos.TextMatrix(X, 21))  'Trim(strDigitaSN)
                AddParam Envia, "TCM"
                AddParam Envia, IIf(mfgFlujos.TextMatrix(X, 13) = "0", 1, 0) '1: Borrar
                If Not Bac_Sql_Execute("SP_MNT_CARTERA_CONVERSION", Envia) Then
                   MousePointer = vbDefault
                   MsgBox "Error en la grabación" & vbCrLf & "SP_MNT_CARTERA_CONVERSION", vbCritical, TITSISTEMA
                   Let GrabaFlujos = blnSuccess
                   Exit Function
                End If
                '--
         End If
         If mfgFlujos.TextMatrix(X, 23) <> "" Then
                '-- La moneda para la que se pidió paridad es igual
                '-- a la moneda Capital, grabar como "PARIDAD2"
                If mfgFlujos.TextMatrix(X, 32) = mfgFlujos.TextMatrix(X, 34) Then
                    Envia = Array()
                    AddParam Envia, CDbl(mfgFlujos.TextMatrix(X, 1))
                    AddParam Envia, CDbl(mfgFlujos.TextMatrix(X, 2))
                    AddParam Envia, CDbl(mfgFlujos.TextMatrix(X, 3))
                    AddParam Envia, CDate(mfgFlujos.TextMatrix(X, 35))
                    AddParam Envia, CDbl(mfgFlujos.TextMatrix(X, 23))
                    AddParam Envia, "S"
                    AddParam Envia, "PARIDAD2"
                    AddParam Envia, IIf(mfgFlujos.TextMatrix(X, 23) * 1 = "0", 1, 0) '1: Borrar
                    If Not Bac_Sql_Execute("SP_MNT_CARTERA_CONVERSION", Envia) Then
                       MousePointer = vbDefault
                       MsgBox "Error en la grabación" & vbCrLf & "SP_MNT_CARTERA_CONVERSION", vbCritical, TITSISTEMA
                       Let GrabaFlujos = blnSuccess
                       Exit Function
                    End If
                End If
                '-- La moneda para la que se pidió paridad es igual
                '-- a la moneda liquidacion, grabar como "PARIDAD3"
                If mfgFlujos.TextMatrix(X, 32) = mfgFlujos.TextMatrix(X, 20) Then
                    Envia = Array()
                    AddParam Envia, CDbl(mfgFlujos.TextMatrix(X, 1))
                    AddParam Envia, CDbl(mfgFlujos.TextMatrix(X, 2))
                    AddParam Envia, CDbl(mfgFlujos.TextMatrix(X, 3))
                    AddParam Envia, CDate(mfgFlujos.TextMatrix(X, 35))
                    AddParam Envia, CDbl(mfgFlujos.TextMatrix(X, 23))
                    AddParam Envia, "S"  'Trim(strDigitaSN)
                    AddParam Envia, "PARIDAD3"
                    AddParam Envia, IIf(mfgFlujos.TextMatrix(X, 23) * 1 = "0", 1, 0) '1: Borrar
                    If Not Bac_Sql_Execute("SP_MNT_CARTERA_CONVERSION", Envia) Then
                       MousePointer = vbDefault
                       MsgBox "Error en la grabación" & vbCrLf & "SP_MNT_CARTERA_CONVERSION", vbCritical, TITSISTEMA
                       Let GrabaFlujos = blnSuccess
                       Exit Function
                    End If
                End If
                    
                blnSuccess = True
          End If
   End If
Next X
If blnSuccess = True Then
    MsgBox "Registros grabados en forma correcta", vbOKOnly + vbInformation, TITSISTEMA
    'Call TraeFlujosByFiltros(gstrFechaOrigen, gstrFechaFinal)
    Let GrabaFlujos = blnSuccess
End If
End Function
Private Sub CmdReProcesar()
'***********************************************************
' PROCESO QUE OBTIENE VALOR TC EN BASE A FEC. REF. MERCADO
'***********************************************************
Dim iRow As Integer
Dim MArca As Integer
If blnExistenMarcados() = True Then
    iRow = 1
    Let MArca = 0
    Do While iRow < mfgFlujos.Rows
        If mfgFlujos.TextMatrix(iRow, 21) <> "S" Then
            If mfgFlujos.TextMatrix(iRow, 0) <> "" Then
               Let MArca = 1
               strDigitaSN = "N"
               mfgFlujos.TextMatrix(iRow, 21) = "N"
               mfgFlujos.Row = iRow
               mfgFlujos.Col = 1
               If mfgFlujos.CellBackColor <> vbYellow Then
                  Call ReProcesaLinea(iRow)
               End If
            End If
        End If
        iRow = iRow + 1
    Loop
    If MArca = 0 Then
       MsgBox "Flujos ya estaban digitados previamente limpiar"
    End If
Else
    MsgBox "No existen Flujos marcados, Debe procesar al menos un flujo para continuar", vbInformation, TITSISTEMA
End If
End Sub
Private Function blnExistenMarcados() As Boolean
Dim iRow  As Integer
blnExistenMarcados = False
iRow = 1
Do While iRow < mfgFlujos.Rows
    If mfgFlujos.TextMatrix(iRow, 0) <> "" Then
        blnExistenMarcados = True
        Exit Function
    End If
    iRow = iRow + 1
Loop
End Function
Private Sub ReProcesaLinea(iRow As Integer)
Dim dtFecRefMercado As Date
Dim strIdSistema As String
Dim strIdProducto As String
Dim strModalidad As String
Dim dtFechaTemporal As Date
Dim dtFechaFinal As Date
Dim intRespDias As Integer
Dim iDayTemp As Integer
Dim iDayPaso As Integer

'***********************************************************
' VARIABLES RESULTADOS
'***********************************************************
Dim dblResultTC As Double

'***************************
'VARIABLES PARA FERIADOS
'***************************
Dim intFeriadosCL As Integer
Dim intFeriadosUSA As Integer
Dim intFeriadosENG As Integer

Dim blnFeriadosCL As Boolean
Dim blnFeriadosUSA As Boolean
Dim blnFeriadosENG As Boolean
Dim paises          As String
Dim fecREP          As Date
Dim Datos()
'***********************************************************
' OBTENGO VALORES ACTUALES DE LA FILA (FLUJO)
'***********************************************************
dtFecRefMercado = CDate(mfgFlujos.TextMatrix(iRow, 11))
strIdSistema = "PCS"
strIdProducto = CStr(mfgFlujos.TextMatrix(iRow, 14))
strModalidad = CStr(mfgFlujos.TextMatrix(iRow, 22))
intFeriadosCL = CInt(mfgFlujos.TextMatrix(iRow, 17))
intFeriadosUSA = CInt(mfgFlujos.TextMatrix(iRow, 18))
intFeriadosENG = CInt(mfgFlujos.TextMatrix(iRow, 19))
intRespDias = CInt(mfgFlujos.TextMatrix(iRow, 12))


'*********************************************************************
'  REALIZO PROCESO QUE OBTIENE VALOR DEL TC EN BASE AL VALOR
'  DIA DE LA REFERENCIA MERCADO
'*********************************************************************
    'Leer = False
    
'    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
'    Sql = Sql & "sp_feleer " & idAnn & ", " & Val(IdPlaza)
    paises = ";6;255;510;"
    Envia = Array()
    AddParam Envia, CDate(dtFecRefMercado)
    AddParam Envia, CInt(intRespDias)
    AddParam Envia, CStr(paises)
    AddParam Envia, "v"
'    If MISQL.SQL_Execute(Sql) > 0 Then
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_AGREGA_N_DIAS_HABILES", Envia) Then
       Exit Sub
    End If
    If Bac_SQL_Fetch(Datos()) Then
        fecREP = Datos(1)
    End If

'*****************************************************
' OBTENGO TIPO DE CAMBIO
' EN BASE A LA FECHA OBTENIDA EN EL PROCESO ANTERIOR
'*****************************************************
dblResultTC = getValorTipoCambioByFecha(fecREP)

'***************************************
' RETORNO VALORES A LA FILA
'***************************************
mfgFlujos.Row = iRow
mfgFlujos.Col = 11
mfgFlujos.CellFontBold = True
mfgFlujos.CellFontItalic = True
mfgFlujos.CellForeColor = vbRed
mfgFlujos.Text = fecREP

mfgFlujos.Col = 13
mfgFlujos.CellFontBold = True
mfgFlujos.CellForeColor = vbRed
mfgFlujos.Text = BacFormatoMonto(dblResultTC, 4)

Call PintaFila(iRow, vbYellow)

'***************************************
' HABILITO BOTON GRABAR
'***************************************
Toolbar1.Buttons(3).Enabled = True

End Sub
Private Function getValorTipoCambioByFecha(dtFecCapturaTC As Date) As Double
    getValorTipoCambioByFecha = 0
    getValorTipoCambioByFecha = ValorMoneda(994, dtFecCapturaTC)
End Function
Private Sub CmdLimpiar()
   mfgFlujos.Clear
   mfgFlujos.Rows = 1
   Toolbar1.Buttons(3).Enabled = False
   frame(1).Enabled = False
   Call Dibuja_Grilla
End Sub
Private Sub cmdSalir()
   Unload Me
End Sub
Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   frame(1).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(5).Enabled = False
   
   Call Dibuja_Grilla
   txtFechaOperacion.Text = gsBAC_Fecp

End Sub
Private Sub mfgFlujos_DblClick()
If mfgFlujos.RowSel > 0 Then
    If mfgFlujos.ColSel = 0 Then
        Call MarcaColumna
    End If
    If mfgFlujos.ColSel = 13 And _
       mfgFlujos.TextMatrix(mfgFlujos.RowSel, 13) <> "" Then
       TC = mfgFlujos.TextMatrix(mfgFlujos.RowSel, 13)
    End If
End If
End Sub
Private Sub mfgFlujos_KeyPress(KeyAscii As Integer)
   
   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii = 13 And KeyAscii = 8 Then
      KeyAscii = 0
   End If
   '13 -> TCM
   If mfgFlujos.Col = 13 And IsNumeric(Chr(KeyAscii)) _
      And mfgFlujos.TextMatrix(mfgFlujos.RowSel, 24) = "S" Then
      blnEscribeMonto = False
      Txt_Ingreso.Text = ""
      Call PROC_POSICIONA_TEXTO(mfgFlujos, Txt_Ingreso)
      Txt_Ingreso.Text = Chr(KeyAscii)
      Txt_Ingreso.Visible = True
      Txt_Ingreso.SetFocus
      Txt_Ingreso.SelStart = 1
   End If
   
   '23 -> PARIDAD2
   If mfgFlujos.Col = 23 And IsNumeric(Chr(KeyAscii)) _
      And mfgFlujos.TextMatrix(mfgFlujos.RowSel, 25) = "S" Then
      blnEscribeMonto = False
      Txt_Ingreso.Text = ""
      Call PROC_POSICIONA_TEXTO(mfgFlujos, Txt_Ingreso)
      Txt_Ingreso.Text = Chr(KeyAscii)
      Txt_Ingreso.Visible = True
      Txt_Ingreso.SetFocus
      Txt_Ingreso.SelStart = 1
   End If
   
   
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1    ' Limpiar formulario
         Call CmdLimpiar
      Case 2    ' Buscar registros
         Call cmdBuscar

      Case 3    ' Grabar registros
         Call cmdGrabar
              Toolbar1.Buttons(3).Enabled = False
              'Toolbar1.Buttons(5).Enabled = False
         
      Case 4    ' Salir del formulario
         Call cmdSalir
      Case 5    ' Re Procesar TC flujo
         Call CmdReProcesar
      Case 6    ' Filtrar fechas de la consulta
        Call cmdFiltrar
            gstrFechaOrigen = ""
            gstrFechaFinal = ""
   End Select
End Sub
Private Sub cmdFiltrar()
    gstrFechaOrigen = ""
    gstrFechaFinal = ""
    gstrModuloOrigen = Trim(Me.Name)
    
    BacTasaFlujoVencimiento.Enabled = False

   FrmFiltroFechasFlujos.Show vbModal
   If gstrFechaOrigen <> "" And gstrFechaFinal <> "" Then
      Me.frame(1).Enabled = True
      Me.Toolbar1.Buttons(3).Enabled = True
      Me.mfgFlujos.Redraw = True
      
      BacTasaFlujoVencimiento.Enabled = True
      Call cmdBuscar
    End If
End Sub
Private Sub ToolTVar_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim iContador  As Long
   Dim Datos()
   If MsgBox("¿ Esta seguro que desea realizar el recalculo de los flujos en tasa variable. ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
      Exit Sub
   End If
   
   Screen.MousePointer = vbHourglass
   If BacBeginTransaction = False Then
      Exit Sub
   End If
   For iContador = 1 To mfgFlujos.Rows - 1
      If CDbl(mfgFlujos.TextMatrix(iContador, 7)) <> 0# Then
         Envia = Array()
         AddParam Envia, Format(gsBAC_Fecp, "YYYYMMDD")
         AddParam Envia, CDbl(mfgFlujos.TextMatrix(iContador, 1))
         If Not Bac_Sql_Execute("SP_ACTUALIZACION_VCTOTASAVARIABLE", Envia) Then
            Call BacRollBackTransaction
            MsgBox "Problemas en la actualización de vencimientos... Revise valores para tasas variables.", vbExclamation, TITSISTEMA
            Exit Sub
         End If
      Else
         Call BacRollBackTransaction
         MsgBox "Debe ingresar valores para las tasas variables de recalculo diario.", vbExclamation, TITSISTEMA
         Exit Sub
      End If
   Next iContador
   Call BacCommitTransaction
   Call cmdBuscar
   MsgBox "Proceso ha finalizado correctamente.", vbInformation, TITSISTEMA
   Screen.MousePointer = vbDefault
End Sub
Private Sub Txt_Ingreso_DblClick()
If mfgFlujos.ColSel = 13 Then
    lRowSel = mfgFlujos.RowSel
    
    gstrFechaFijacion = ""
    gstrFechaFijacion = mfgFlujos.TextMatrix(lRowSel, 11)
    
    glngCodMoneda = 0
    glngCodMoneda = 994 ' 994 = DO

    gdblValorTasaFlujo = 0
    

    BacSeleccionaValorTC.Top = BacSeleccionaValorTC.Height + Txt_Ingreso.Top - 600 '+ (Txt_Ingreso.Height + 100)  'Table1.Top 'Table1.CellTop '
    BacSeleccionaValorTC.Left = mfgFlujos.CellLeft + Txt_Ingreso.Width - BacSeleccionaValorTC.Width  '
    
    BacSeleccionaValorTC.Show vbModal
    strDigitaSN = "N"
    mfgFlujos.TextMatrix(lRowSel, 21) = "N"
    If gdblValorTasaFlujo <> 0 Then
        Txt_Ingreso.Visible = False
        mfgFlujos.TextMatrix(lRowSel, 13) = BacFormatoMonto(gdblValorTasaFlujo, 4)
        mfgFlujos.TextMatrix(lRowSel, 11) = gdblFechaTasaFlujo
        mfgFlujos.Col = 13
        mfgFlujos.CellFontBold = True
        mfgFlujos.CellFontItalic = True
        mfgFlujos.CellForeColor = vbRed

        Call MarcaFila(mfgFlujos.RowSel)
        Call PintaFila(mfgFlujos.RowSel, vbYellow)
        
        '***************************************
        ' HABILITO BOTON GRABAR
        '***************************************
        Toolbar1.Buttons(3).Enabled = True
        
        'Txt_Ingreso.Text = BacFormatoMonto(gdblValorTasaFlujo, 6)
    End If
End If
End Sub
Private Sub Txt_Ingreso_GotFocus()
'Screen.MousePointer = vbArrowQuestion
End Sub


Private Sub Txt_Ingreso_KeyPress(KeyAscii As Integer)
   lRowSel = 0
   lColSel = 0
   If KeyAscii = 27 Then
      Txt_Ingreso.Visible = False
      mfgFlujos.SetFocus
   End If
   If mfgFlujos.ColSel = 13 _
      Or mfgFlujos.ColSel = 23 Then
      'Solo columna TCM y Paridad
        If KeyAscii = 13 Then 'al terminar de digitar
           If Trim(Txt_Ingreso.Text) = "" Then
              Exit Sub
           End If
           
           lRowSel = mfgFlujos.RowSel
           lColSel = mfgFlujos.ColSel
           
''''   mfgFlujos.TextMatrix(0, 26) = "MxCap"  'Mda capital es extranjera
''''   mfgFlujos.TextMatrix(0, 27) = "MxLiq"  'Mda liquidacion es extranjera
''''   mfgFlujos.TextMatrix(0, 28) = "MinTCM" 'Valor minimo USD observado
''''   mfgFlujos.TextMatrix(0, 29) = "MaxTCM" 'Valor maximo USD observado
''''   mfgFlujos.TextMatrix(0, 30) = "MaxPar" 'Valor maximo Paridad
''''   mfgFlujos.TextMatrix(0, 31) = "MinPar" 'Valor minimo Paridad
''''   mfgFlujos.TextMatrix(0, 32) = "MdaParidad" 'Moneda que requiere paridad
''''   mfgFlujos.TextMatrix(0, 33) = "Indicación" 'Moneda que requiere paridad
           If lColSel = 13 Then 'TCM
               If Not (CDbl(Txt_Ingreso.Text) >= CDbl(mfgFlujos.TextMatrix(lRowSel, 28)) _
                And CDbl(Txt_Ingreso.Text) <= CDbl(mfgFlujos.TextMatrix(lRowSel, 29))) _
                And Txt_Ingreso.Text <> "0" Then
                    MsgBox "Valor Fuera de Rango: [" + mfgFlujos.TextMatrix(lRowSel, 28) + " - " + mfgFlujos.TextMatrix(lRowSel, 29) + "]"
                    Exit Sub
               End If
           End If
           
           If lColSel = 23 Then 'Paridad
               If Not (CDbl(Txt_Ingreso.Text) >= CDbl(mfgFlujos.TextMatrix(lRowSel, 30)) _
                And CDbl(Txt_Ingreso.Text) <= CDbl(mfgFlujos.TextMatrix(lRowSel, 31))) _
                And Txt_Ingreso.Text <> "0" Then
                    MsgBox "Valor Fuera de Rango: [" + mfgFlujos.TextMatrix(lRowSel, 30) + " - " + mfgFlujos.TextMatrix(lRowSel, 31) + "]"
                    Exit Sub
               End If
           End If
           
           
           
           strDigitaSN = "S"
           blnEscribeMonto = True
           mfgFlujos.Text = BacFormatoMonto(CDbl(Txt_Ingreso.Text), 6)
           mfgFlujos.Col = lColSel
           mfgFlujos.CellFontBold = True
           mfgFlujos.CellFontItalic = True
           mfgFlujos.CellForeColor = vbRed
           
           Call MarcaFila(mfgFlujos.RowSel)
           
           '***************************************
           ' HABILITO BOTON GRABAR
           '***************************************
           Toolbar1.Buttons(3).Enabled = True
           
           ' IDENTIFICO TC DIGITADO MANUALMENTE
           If lColSel = 13 Then
              mfgFlujos.TextMatrix(lRowSel, 21) = "S"
           End If
           Txt_Ingreso.Visible = False
           mfgFlujos.SetFocus
        End If
   
   End If
   
   
End Sub
Private Sub Form_Resize()
    On Error Resume Next
    frame.Item(3).Width = Me.Width - 150
           Label2.Width = frame.Item(3).Width - 150
           Frame1.Width = frame.Item(3).Width
    frame.Item(1).Width = frame.Item(3).Width
    frame.Item(1).Height = Me.Height - 3000
           mfgFlujos.Width = frame.Item(1).Width - 150
           mfgFlujos.Height = frame.Item(1).Height - 250
    On Error GoTo 0
End Sub
Private Sub Txt_Ingreso_LostFocus()
'    Screen.MousePointer = vbDefault
End Sub


