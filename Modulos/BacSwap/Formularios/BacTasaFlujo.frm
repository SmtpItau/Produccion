VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacTasaFlujo 
   Caption         =   "Tasas de Flujos"
   ClientHeight    =   9120
   ClientLeft      =   525
   ClientTop       =   1560
   ClientWidth     =   14670
   Icon            =   "BacTasaFlujo.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   9120
   ScaleWidth      =   14670
   Begin VB.CheckBox chkSwapIBR 
      Caption         =   "Ingreso Tasas para Swap IBR "
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Left            =   90
      TabIndex        =   17
      Top             =   1605
      Width           =   5040
   End
   Begin VB.CheckBox chkSwapICP 
      Caption         =   "Ingreso Tasas para Swap Promedio Camara. ICP"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Left            =   90
      TabIndex        =   9
      Top             =   1200
      Width           =   5040
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   420
      Top             =   3660
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
            Picture         =   "BacTasaFlujo.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTasaFlujo.frx":0624
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTasaFlujo.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTasaFlujo.frx":0EC8
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTasaFlujo.frx":1DA2
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTasaFlujo.frx":20BC
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   14670
      _ExtentX        =   25876
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
            Key             =   "CmdFiltrar"
            Description     =   "CmdSalir"
            Object.ToolTipText     =   "Filtro por Fechas"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdSalir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "CmdReprocesa"
            Object.ToolTipText     =   "Re-Procesa Valor Tasa"
            ImageIndex      =   6
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
      Width           =   11280
      _Version        =   65536
      _ExtentX        =   19897
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
         Caption         =   "INGRESO DE VALORES DE TASAS DE FLUJOS"
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
         Width           =   11160
      End
   End
   Begin VB.Frame CuadroIcp 
      Enabled         =   0   'False
      Height          =   510
      Left            =   15
      TabIndex        =   6
      Top             =   990
      Width           =   11310
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   9435
         Top             =   -570
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   16
         ImageHeight     =   16
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTasaFlujo.frx":2F96
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTasaFlujo.frx":3E70
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.Toolbar ToolICP 
         Height          =   330
         Left            =   9135
         TabIndex        =   10
         Top             =   135
         Width           =   1830
         _ExtentX        =   3228
         _ExtentY        =   582
         ButtonWidth     =   2487
         ButtonHeight    =   582
         AllowCustomize  =   0   'False
         Style           =   1
         TextAlignment   =   1
         ImageList       =   "ImageList2"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   1
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Enabled         =   0   'False
               Caption         =   "Aplicar I.C.P."
               Object.ToolTipText     =   "Aplicar ICP"
               ImageIndex      =   1
            EndProperty
         EndProperty
      End
      Begin BACControles.TXTNumero txtValorIcp 
         Height          =   330
         Left            =   6330
         TabIndex        =   8
         Top             =   135
         Width           =   2700
         _ExtentX        =   4763
         _ExtentY        =   582
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Valor ICP"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   5250
         TabIndex        =   7
         Top             =   195
         Width           =   945
      End
   End
   Begin VB.Frame CuadroIBR 
      Enabled         =   0   'False
      Height          =   510
      Left            =   15
      TabIndex        =   13
      Top             =   1410
      Width           =   11310
      Begin MSComctlLib.ImageList ImageList3 
         Left            =   9435
         Top             =   -570
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   16
         ImageHeight     =   16
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTasaFlujo.frx":4D4A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTasaFlujo.frx":5C24
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.Toolbar ToolIBR 
         Height          =   330
         Left            =   9120
         TabIndex        =   14
         Top             =   120
         Width           =   1830
         _ExtentX        =   3228
         _ExtentY        =   582
         ButtonWidth     =   2461
         ButtonHeight    =   582
         AllowCustomize  =   0   'False
         Style           =   1
         TextAlignment   =   1
         ImageList       =   "ImageList2"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   1
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Enabled         =   0   'False
               Caption         =   "Aplicar I.B.R."
               Object.ToolTipText     =   "Aplicar ICP"
               ImageIndex      =   1
            EndProperty
         EndProperty
      End
      Begin BACControles.TXTNumero txtValorIbr 
         Height          =   330
         Left            =   6330
         TabIndex        =   15
         Top             =   135
         Width           =   2700
         _ExtentX        =   4763
         _ExtentY        =   582
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Valor IBR"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   5250
         TabIndex        =   16
         Top             =   195
         Width           =   945
      End
   End
   Begin VB.Frame Frame1 
      Height          =   525
      Left            =   15
      TabIndex        =   12
      Top             =   1830
      Width           =   11310
      Begin MSComctlLib.Toolbar ToolTVar 
         Height          =   330
         Left            =   9135
         TabIndex        =   11
         Top             =   135
         Width           =   2100
         _ExtentX        =   3704
         _ExtentY        =   582
         ButtonWidth     =   3731
         ButtonHeight    =   582
         AllowCustomize  =   0   'False
         Style           =   1
         TextAlignment   =   1
         ImageList       =   "ImageList2"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   1
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Enabled         =   0   'False
               Caption         =   "Aplicar Tasa Variables"
               Object.ToolTipText     =   "Aplicar Tasas Variables"
               ImageIndex      =   2
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame frame 
      Height          =   3660
      Index           =   1
      Left            =   0
      TabIndex        =   0
      Top             =   2310
      Width           =   11325
      _Version        =   65536
      _ExtentX        =   19976
      _ExtentY        =   6456
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
         Left            =   4125
         TabIndex        =   4
         Top             =   1860
         Visible         =   0   'False
         Width           =   1185
      End
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   3480
         Left            =   60
         TabIndex        =   3
         Top             =   135
         Width           =   11190
         _ExtentX        =   19738
         _ExtentY        =   6138
         _Version        =   393216
         Cols            =   12
         FixedCols       =   0
         BackColor       =   -2147483644
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         WordWrap        =   -1  'True
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
End
Attribute VB_Name = "BacTasaFlujo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim SQL   As String
Dim Datos()
Dim FecProcAnt As Date
Dim FecProcProx As Date
Dim lRowSel As Long

'CONSTANTES DEL FORMULARIO
Const Chile = 6
Const EstadosUnidos = 225
Const Inglaterra = 510

Sub Dibuja_Grilla()
   Table1.Cols = 22
   
   Table1.TextMatrix(0, 0) = ""
   Table1.TextMatrix(0, 1) = "Operacion"
   Table1.TextMatrix(0, 2) = "Nombre del Cliente"
   Table1.TextMatrix(0, 3) = "Tipo"
   Table1.TextMatrix(0, 4) = "Moneda"
   Table1.TextMatrix(0, 5) = "N° Flujo"
   Table1.TextMatrix(0, 6) = "Inic. Fljo--Vcto. Fljo."
   Table1.TextMatrix(0, 7) = "Tasa"
   Table1.TextMatrix(0, 8) = "Valor Tasa"
   Table1.TextMatrix(0, 9) = "Tipo Flujo"
   Table1.TextMatrix(0, 10) = "Moneda Tasa"
   Table1.TextMatrix(0, 11) = "Tasa Automática"
   Table1.TextMatrix(0, 12) = "Fijación"
   Table1.TextMatrix(0, 13) = "FeriadoCL"
   Table1.TextMatrix(0, 14) = "FeriadoUSA"
   Table1.TextMatrix(0, 15) = "FeriadoENG"
   Table1.TextMatrix(0, 16) = "CodTasaCompra"
   Table1.TextMatrix(0, 17) = "CodTasaVenta"
   Table1.TextMatrix(0, 18) = "CodTasaFlujo"
   Table1.TextMatrix(0, 19) = "Digita Si No"
   Table1.TextMatrix(0, 20) = "Fec. Rescate"
   Table1.TextMatrix(0, 21) = "Tasa Propuesta"
   'Table1.TextMatrix(0, 22) = "tasa_pais"
   
   
      

   Table1.RowHeight(0) = 500
   Table1.ColAlignment(0) = 0:   Table1.ColWidth(0) = 250
   Table1.ColAlignment(1) = 7:   Table1.ColWidth(1) = 1000
   Table1.ColAlignment(2) = 1:   Table1.ColWidth(2) = 3000
   Table1.ColAlignment(3) = 4:   Table1.ColWidth(3) = 1000
   Table1.ColAlignment(4) = 7:   Table1.ColWidth(4) = 1100 '1500 Moneda
   Table1.ColAlignment(5) = 4:   Table1.ColWidth(5) = 550  '1000  N° Flujo
   Table1.ColAlignment(6) = 1:   Table1.ColWidth(6) = 1850 '1000 Ini Vcto Flujo
   Table1.ColAlignment(7) = 7:   Table1.ColWidth(7) = 1200 '1500 Nombre Indice
   Table1.ColAlignment(8) = 7:   Table1.ColWidth(8) = 850 '1000 Valor Tasa
   Table1.ColAlignment(9) = 7:   Table1.ColWidth(9) = 500 '1000 Tipo Flujo
   Table1.ColAlignment(10) = 7:  Table1.ColWidth(10) = 0 '-> 2500
   Table1.ColAlignment(11) = 7:  Table1.ColWidth(11) = 0
   Table1.ColAlignment(12) = 7:  Table1.ColWidth(12) = 1000 '1200 Fecha Fijacion
   Table1.ColAlignment(13) = 7:  Table1.ColWidth(13) = 0
   Table1.ColAlignment(14) = 7:  Table1.ColWidth(14) = 0
   Table1.ColAlignment(15) = 7:  Table1.ColWidth(15) = 0
   Table1.ColAlignment(16) = 7:  Table1.ColWidth(16) = 0
   Table1.ColAlignment(17) = 7:  Table1.ColWidth(17) = 0
   Table1.ColAlignment(18) = 7:  Table1.ColWidth(18) = 0
   Table1.ColAlignment(19) = 4:  Table1.ColWidth(19) = 600  '800 Digita SN
   Table1.ColAlignment(20) = 4:  Table1.ColWidth(20) = 1000 '1200 fecha rescate
   Table1.ColAlignment(21) = 4:  Table1.ColWidth(21) = 1000 '1400 tasa propuesta
   'Table1.ColAlignment(22) = 4:  Table1.ColWidth(22) = 0

   
End Sub
Private Sub cmdBuscar()
    Dim nNumero      As Double
    Dim Fecha        As Date
    Dim nIndicador   As Integer
    Dim i            As Integer
    Dim paises       As String
    Dim dtFecFijacion  As Date
    Dim strFeriadosLiq As String
    Dim strFechaFila   As String
    Dim intFila        As Integer
    Dim Aux            As Date
    Let Screen.MousePointer = vbHourglass
    Let Table1.Redraw = False
    
    Let FecProcAnt = Format(gsc_Parametros.FechaAnt, gsc_FechaDMA)
    Let Fecha = DateAdd("d", 1, FecProcAnt)
    
    '-> Se agrega para enviar la codificacion necesaria al Sp
    '-> 1 = ICP; 2 = IBR, 0 = Todo lo que no sea ICP e IBR
    Let nIndicador = IIf(chkSwapICP.Value, 1, IIf(chkSwapIBR.Value, 2, 0))
   
'*********************PRD21657---07-05-2015

'''    No homologar este código hasta haber terminado
'''    la prueba interna.
'''    Envia = Array()
'''    AddParam Envia, CDate(gsBAC_Fecp)
'''    AddParam Envia, CInt(1)    'Dia siguiente
'''    AddParam Envia, CStr(";6;") 'Plaza Chile
'''    AddParam Envia, "v"
''''    If MISQL.SQL_Execute(Sql) > 0 Then
'''    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_AGREGA_N_DIAS_HABILES", Envia) Then
'''       Exit Sub
'''    End If
'''    If Bac_SQL_Fetch(Datos()) Then
'''        Aux = DateAdd("d", -1, Datos(1))
'''    End If
    
    Let FecProcProx = Format(gsc_Parametros.fechaprox, gsc_FechaDMA) 'MAP17-07-2015
    Let Aux = DateAdd("d", -1, FecProcProx)                          'MAP17-07-2015
   
'*************************************************************************************
    Envia = Array()
    AddParam Envia, CDbl(nIndicador)
    AddParam Envia, gsBAC_Fecp
    AddParam Envia, Aux
    If Not Bac_Sql_Execute("dbo.SP_CONSULTAFLUJOSINICIAN", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Problemas al leer procedimiento  " & vbCrLf & "SP_CONSULTAFLUJOSINICIAN", vbCritical, TITSISTEMA)
        Exit Sub
    End If
   
    Let nNumero = 0
    Let Table1.Rows = 1

    Do While Bac_SQL_Fetch(Datos())
        Call BacControlWindows(1)

        Let Table1.Rows = Table1.Rows + 1
        
        intFila = Table1.Rows - 1
        
        Let nNumero = Datos(2)
        Let Table1.TextMatrix(Table1.Rows - 1, 1) = Datos(2)                                                '-> Numero Operación
        Let Table1.TextMatrix(Table1.Rows - 1, 2) = Datos(3)                                                '-> Nombre Cliente
        Let Table1.TextMatrix(Table1.Rows - 1, 3) = Datos(1)                                                '-> Tipo Swap
        Let Table1.TextMatrix(Table1.Rows - 1, 4) = Datos(39)                                               '-> Moneda pata
        Let Table1.TextMatrix(Table1.Rows - 1, 5) = Datos(13)                                               '-> Numero de Flujo
        Let Table1.TextMatrix(Table1.Rows - 1, 6) = Datos(14)                                               '-> Fecha de Inicio de Flujo

'''        If Datos(20) = 0 Then                                                                               '-> Codigo de Tasa Activa
'''            Let Table1.TextMatrix(Table1.Rows - 1, 7) = Datos(23)                                           '-> Nombre Tasa Pasiva
'''            Let Table1.TextMatrix(Table1.Rows - 1, 8) = BacFormatoMonto(CDbl(Datos(19)), 6)                 '-> Valor  Tasa Pasiva
'''        Else
            If Datos(24) = 1 Then                                                                           '-> Tipo de Flujo
                Let Table1.TextMatrix(Table1.Rows - 1, 7) = Datos(22)                                       '-> Nombre Tasa Activa
                Let Table1.TextMatrix(Table1.Rows - 1, 8) = BacFormatoMonto(CDbl(Datos(18)), 6)             '-> Valor  Tasa Activa
            Else
                Let Table1.TextMatrix(Table1.Rows - 1, 7) = Datos(23)                                       '-> Nombre Tasa Pasiva
                Let Table1.TextMatrix(Table1.Rows - 1, 8) = BacFormatoMonto(CDbl(Datos(19)), 6)             '-> Valor  Tasa Pasiva
            End If
'''        End If
        Let Table1.TextMatrix(Table1.Rows - 1, 9) = Datos(24)                                               '-> Tipo de Flujo
        Let Table1.TextMatrix(Table1.Rows - 1, 10) = Datos(31)                                               '-> CodMoneda
        
 ''       If CDbl(Datos(35)) > 0# Then                                                                        '-> Valor Propuesto
 ''           Let Table1.TextMatrix(Table1.Rows - 1, 8) = BacFormatoMonto(Datos(35), 6)
 ''       End If
        Let Table1.TextMatrix(Table1.Rows - 1, 11) = BacFormatoMonto(Datos(26), 6)                          '-> Valor Propuesto
        Let Table1.TextMatrix(Table1.Rows - 1, 12) = Datos(27)                                              '-> Fecha Fijacion Tasa
        
        Let Table1.TextMatrix(Table1.Rows - 1, 13) = Datos(28)                                              '-> FeriadoCL
        Let Table1.TextMatrix(Table1.Rows - 1, 14) = Datos(29)                                              '-> FeriadoUSA
        Let Table1.TextMatrix(Table1.Rows - 1, 15) = Datos(30)                                              '-> FeriadoENG
        Let Table1.TextMatrix(Table1.Rows - 1, 16) = Datos(20)                                              '-> CodTasaCompra
        Let Table1.TextMatrix(Table1.Rows - 1, 17) = Datos(21)                                              '-> CodTasaVenta
        Let Table1.TextMatrix(Table1.Rows - 1, 18) = Datos(32)                                              '-> CodTasaFlujo
        Let Table1.TextMatrix(Table1.Rows - 1, 19) = Datos(33)    '"N"                                      '-> DigitaSN
        Let Table1.TextMatrix(Table1.Rows - 1, 20) = IIf(Datos(34) <> "01-01-1900", Datos(34), "") 'fecha_propuesta=fecha_rescate                                       '-> Fecha Propuesta
        Let Table1.TextMatrix(Table1.Rows - 1, 21) = IIf(Datos(35) <> 0, Datos(35), "")                                             '-> Tasa Propuesta
        'Let Table1.TextMatrix(Table1.Rows - 1, 22) = Datos(40)
        
        '****************Incorporado el día 07-04-2015 prd 21657
        For i = 0 To 21
        'If Datos(36) = "X" Or Datos(37) = "X" Then
        If Datos(40) = "X" Then
            Table1.Row = Table1.Rows - 1
            Table1.Col = i
            Table1.CellBackColor = vbYellow
            Table1.Col = 0
            'Table1.Text = "¤"
            Table1.CellForeColor = &HC0&
            Table1.CellFontBold = True
            Toolbar1.Buttons(6).Enabled = True
        End If
        Next
        '****************************************************************
            
      
            
            
            
        
       ' dtFecFijacion = CDate(Datos(27))
       ' strFeriadosLiq = Trim(Datos(28)) & "-" & Trim(Datos(29)) & "-" & Trim(Datos(30))
       ' If strFechaFila = "" Then
        '    strFechaFila = CStr(intFila) & " / " & CStr(dtFecFijacion) & " / " & strFeriadosLiq
        'Else
         '   strFechaFila = strFechaFila & "," & CStr(intFila) & " / " & CStr(dtFecFijacion) & " / " & strFeriadosLiq
        'End If
    Loop
   
   '******************************************************************
   ' REVISO SI FECHAS OBTENIDAS EN LOS FLUJOS CAEN EN DIAS NO HABILES
   '******************************************************************
    'Call ValidaFechasInhabiles(strFechaFila)
      
    Let Screen.MousePointer = vbDefault
    Let Table1.Redraw = True

    If Table1.Rows < 2 Then
        Call CmdLimpiar
    Else
        frame(1).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
        Table1.Redraw = True
    End If
End Sub
Private Sub MarcaFila(intFila As Integer)
''    Table1.Row = intFila
''    Table1.Col = 0
''    Table1.CellForeColor = &HC0&
''    Table1.CellFontBold = True
''    Table1.Text = "¤"
''    Toolbar1.Buttons(6).Enabled = True
End Sub
Private Sub MarcaColumna()
    Table1.Row = Table1.RowSel
    Table1.Col = 0
    If Table1.Text = "¤" Then
       Table1.Col = 0
       Table1.CellForeColor = &HC0&
       Table1.CellFontBold = True
       Table1.Text = ""
        ' despinto row
       Call PintaFila(Table1.RowSel, &H80000004)
    Else
       Table1.Col = 0
       Table1.CellForeColor = &HC0&
       Table1.CellFontBold = True
       'Table1.Text = "¤"
      Toolbar1.Buttons(6).Enabled = True
        ' Destaco fila
        Call PintaFila(Table1.RowSel, vbYellow)
    End If
End Sub
Private Sub PintaFila(intFila As Integer, vbColor As OLE_COLOR)
Dim i As Integer
Table1.Row = intFila
For i = 1 To Table1.Cols - 1
    Table1.Col = i
    Table1.CellBackColor = vbColor
Next
End Sub
Private Sub cmdGrabar()
   Dim sCadena As String
   Dim X
   Dim dblNroOperacion      As Double
   Dim dblNroFlujo          As Double
   Dim dblValorTasa         As Double
   Dim dblMonedaTasa        As Double
   Dim intTipoFlujo         As Integer
   Dim dtFecRescate         As Date
   Dim strDigita            As String
      
   MousePointer = vbHourglass
   
   If chkSwapIBR.Value = 0 And chkSwapICP.Value = 0 Then
   
       For X = 1 To Table1.Rows - 1
          '**********************************************************
          '     VALORES CAPTURADOS DESDE LA FILA
          '**********************************************************
          dblNroOperacion = CDbl(Table1.TextMatrix(X, 1))   ' Operacion
          dblNroFlujo = CDbl(Table1.TextMatrix(X, 5))       ' Nro Flujo
          intTipoFlujo = CInt(Table1.TextMatrix(X, 9))      ' Tipo Flujo
          dblValorTasa = CDbl(Table1.TextMatrix(X, 21))     ' valor tasa
    
          'Es feriado
''          If Trim(Table1.TextMatrix(X, 0)) <> "" _
''             And (Trim(Table1.TextMatrix(X, 19)) = "N" Or Trim(Table1.TextMatrix(X, 19)) = "S") Then
          If CDbl(Table1.TextMatrix(X, 21)) <> CDbl(Table1.TextMatrix(X, 8)) Then
            If (Trim(Table1.TextMatrix(X, 19)) = "N" Or Trim(Table1.TextMatrix(X, 19)) = "S") Then
               'Se manipulo manualmente la pantalla
               'Deja un registro de lo indicado por el usuario en Cartera_Fijacion y
               'registra el valor de tasa recalculando el interes que corresponde
               If Table1.TextMatrix(X, 20) <> "" Then
                 dtFecRescate = CDate(Table1.TextMatrix(X, 20))     ' Fecha Propuesta
               Else
                 dtFecRescate = CDate("1900-01-01")     ' Fecha Propuesta
               End If
               
               strDigita = Trim(Table1.TextMatrix(X, 19))        ' Digita SN
               Call GrabaCarteraFijacion(dblNroOperacion, dblNroFlujo, dblValorTasa, intTipoFlujo, dtFecRescate, strDigita)
            Else
               'Solo graba la tasa y calcula el interes
               Call GrabaTasaCartera(dblNroOperacion, dblNroFlujo, dblValorTasa, intTipoFlujo)
            End If
          End If
       Next X
         'Call cmdBuscar 'MAP20150717 No refrescar porque cambia la fecha y carga otras op.
       MsgBox "Registros grabados en forma correcta", vbOKOnly + vbInformation, TITSISTEMA
       'Call cmdBuscar 'MAP20150717 Referescar después del mensaje
       If filtroini <> "" Or filtrofin <> "" Then
           FrmFiltroFecha.Top = Me.Height / 2 - Me.Height / 2 / 4
           FrmFiltroFecha.Left = Me.Width / 2
           Call FrmFiltroFecha.Show
       Else
          cmdBuscar
       End If
    End If
   'End If
   MousePointer = vbDefault
   
End Sub
Private Sub GrabaCarteraFijacion(dblNroOperacion As Double, dblNroFlujo As Double, dblValorTasa As Double, dblTipoFlujo As Integer, dtFecRescate As Date, strDigita As String)
Dim X As Integer
Dim blnSuccess As Boolean
'For X = 1 To Table1.Rows - 1
'    If Trim(Table1.TextMatrix(X, 0)) <> "" Then
    Envia = Array()
    AddParam Envia, dblNroOperacion
    AddParam Envia, dblNroFlujo
    AddParam Envia, dblTipoFlujo
    AddParam Envia, dtFecRescate
    AddParam Envia, dblValorTasa
    AddParam Envia, strDigita
    If Not Bac_Sql_Execute("SP_MNT_CARTERA_FIJACION", Envia) Then
       MousePointer = vbDefault
       MsgBox "Error en la grabación" & vbCrLf & "SP_MNT_CARTERA_FIJACION", vbCritical, TITSISTEMA
       Exit Sub
    End If
'    End If
'Next X
End Sub

Private Sub GrabaTasaCartera(dblNroOperacion As Double, dblNroFlujo As Double, dblValorTasa As Double, dblTipoFlujo As Integer)
    Envia = Array()
    AddParam Envia, dblNroOperacion
    AddParam Envia, dblNroFlujo
    AddParam Envia, dblValorTasa
    AddParam Envia, dblTipoFlujo
    If Not Bac_Sql_Execute("SP_GRABATASASFLUJOSINICIAN", Envia) Then
       MousePointer = vbDefault
       MsgBox "Error en la grabación" & vbCrLf & "sp_grabaTasasFlujosInician", vbCritical, TITSISTEMA
       Exit Sub
    End If
End Sub
Private Sub CmdLimpiar()
   Table1.Clear
   Table1.Rows = 1
   Toolbar1.Buttons(3).Enabled = False
   frame(1).Enabled = False
  'ActTasaVar.Value = 0 'MAP 20080520 Mejoras pantalla Swap
   chkSwapICP.Value = 0
   
   Call Dibuja_Grilla
End Sub
Private Sub cmdSalir()
   Unload Me
End Sub
Private Sub chkSwapIBR_Click()
   If chkSwapIBR.Value = 1 Then
      CuadroIBR.Enabled = True
      ToolIBR.Buttons(1).Enabled = True
      txtValorIbr.Enabled = True
      
      chkSwapICP.Value = 0
      
      Call cmdBuscar
      Toolbar1.Buttons(3).Enabled = False 'Boton graba in-habilitado
   Else
      CuadroIBR.Enabled = False
      ToolIBR.Buttons(1).Enabled = False
      txtValorIbr.Enabled = False
      Toolbar1.Buttons(4).Enabled = True
      
      Call cmdBuscar
      Toolbar1.Buttons(3).Enabled = True 'Boton graba habilitado
   End If
End Sub

'Private Sub ActTasaVar_Click() 'MAP 20080520 Mejoras Pantalla Swap
'   If ActTasaVar.Value = 1 Then
'      Table1.ColWidth(9) = 1000
'      ToolTVar.Enabled = True
'      ToolTVar.Buttons(1).Enabled = True
'      chkSwapICP.Value = 0
'   Else
'      Table1.ColWidth(9) = 0
'      ToolTVar.Enabled = False
'      ToolTVar.Buttons(1).Enabled = False
'   End If
'End Sub

Private Sub chkSwapICP_Click()
   If chkSwapICP.Value = 1 Then
      CuadroIcp.Enabled = True
      ToolICP.Buttons(1).Enabled = True
      txtValorIcp.Enabled = True
      'ActTasaVar.Value = 0 'MAP 20080520 Mejoras Pantalla Swap
      
      chkSwapIBR.Value = 0
      
      Call cmdBuscar
      Toolbar1.Buttons(3).Enabled = False 'Boton graba inhabilitado
   Else
      CuadroIcp.Enabled = False
      ToolICP.Buttons(1).Enabled = False
      txtValorIcp.Enabled = False
      Toolbar1.Buttons(4).Enabled = True
      
      Call cmdBuscar
      Toolbar1.Buttons(3).Enabled = True 'Boton graba habilitado
   End If
End Sub



Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   frame(1).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(6).Enabled = False
   Call Dibuja_Grilla
   Call TraerValorIcp
   Call TraerValorIbr
End Sub

Private Sub TraerValorIcp()
   Dim SQL  As String
   Dim Datos()

   Let txtValorIcp.Text = 0#

  'Let SQL = "SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA , SWAPGENERAL WHERE vmcodigo = 800 AND vmfecha = fechaproc"
   Let SQL = "SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA with(nolock) WHERE vmcodigo = 800 AND vmfecha = (select fechaproc from BacSwapSuda.dbo.SWAPGENERAL with(nolock) ) "

   Call Bac_Sql_Execute(SQL)
   If Bac_SQL_Fetch(Datos()) Then
      Let txtValorIcp.Text = CDbl(Datos(1))
   End If
End Sub
Private Sub TraerValorIbr()
   Dim SQL  As String
   Dim Datos()

   Let txtValorIbr.Text = 0#

  'Let SQL = "SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA , SWAPGENERAL WHERE vmcodigo = 802 AND vmfecha = fechaproc"
   Let SQL = "SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA with(nolock) WHERE vmcodigo = 802 AND vmfecha = (select fechaproc from BacSwapSuda.dbo.SWAPGENERAL with(nolock) ) "

   Call Bac_Sql_Execute(SQL)
   If Bac_SQL_Fetch(Datos()) Then
      Let txtValorIbr.Text = CDbl(Datos(1))
   End If
End Sub



Private Sub Table1_DblClick()
''If Table1.RowSel > 0 Then
''    If Table1.ColSel = 0 Then
''        Call MarcaColumna
''    End If
''    If Table1.ColSel = 21 And Table1.TextMatrix(Table1.RowSel, 21) <> "" Then Tasa = Table1.TextMatrix(Table1.RowSel, 21)
''End If
End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)
   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii = 13 And KeyAscii = 8 Then
      KeyAscii = 0
   End If
   If Table1.Col = 21 And IsNumeric(Chr(KeyAscii)) Then 'And Table1.TextMatrix(Table1.RowSel, 3) <> "PROM" Then
      
      Txt_Ingreso.Text = ""
      Call PROC_POSICIONA_TEXTO(Table1, Txt_Ingreso)
      Txt_Ingreso.Text = Chr(KeyAscii)
      Txt_Ingreso.Visible = True
      Txt_Ingreso.SetFocus
      Txt_Ingreso.SelStart = 1
   End If
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call CmdLimpiar
      Case 2
         Call cmdBuscar
      Case 3
         Call cmdGrabar

              Toolbar1.Buttons(3).Enabled = False
              Toolbar1.Buttons(6).Enabled = False
      Case 4
        
         Call cmdFiltrar
         
              gstrFechaOrigen = ""
              gstrFechaFinal = ""
               
      Case 5
         Call cmdSalir
      Case 6
         Call CmdReProcesar
   End Select
End Sub
Private Sub CmdReProcesar()
'***********************************************************
' PROCESO QUE OBTIENE VALOR TC EN BASE A FEC. REF. MERCADO
'***********************************************************
Dim iRow As Integer
If blnExistenMarcados() = True Then
iRow = 1
Do While iRow < Table1.Rows
    If Table1.TextMatrix(iRow, 0) <> "" Then
            'Table1.Row = iRow
            'Table1.Col = 1
           ' If Table1.CellBackColor <> vbYellow Then
                Call ReProcesaLinea(iRow)
            'End If
    End If
    iRow = iRow + 1
Loop
Else
    MsgBox "No existen Flujos marcados, Debe procesar al menos un flujo para continuar", vbInformation, TITSISTEMA
End If
End Sub
Private Function blnExistenMarcados() As Boolean
Dim iRow  As Integer
blnExistenMarcados = False
iRow = 1
Do While iRow < Table1.Rows
    If Table1.TextMatrix(iRow, 0) <> "" Then
        blnExistenMarcados = True
        Exit Function
    End If
    iRow = iRow + 1
Loop
End Function

Private Sub ReProcesaLinea(iRow As Integer)
Dim dtFecFijacion As Date
Dim strIdSistema As String
Dim strIdProducto As String
Dim strModalidad As String
Dim dtFechaTemporal As Date
Dim dtFechaFinal As Date
Dim intRespDias As Integer
Dim iDayTemp As Integer
Dim iDayPaso As Integer
Dim paises As String
Dim fecREP          As Date
Dim Datos()
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

'***********************************************************
' OBTENGO VALORES ACTUALES DE LA FILA (FLUJO)
'***********************************************************
dtFechaFinal = CDate(Table1.TextMatrix(iRow, 12)) 'Fecha Fijacion



    paises = ";6;"
    Envia = Array()
    AddParam Envia, CDate(dtFechaFinal)
    AddParam Envia, CInt(-1)    'Dia anterior
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
If CInt(Table1.TextMatrix(iRow, 9)) = 1 Then                ' 1 = Flujo Activo (Compra)
    dblResultTC = getValorTasasByFecha(fecREP, CInt(Table1.TextMatrix(iRow, 10)), CInt(Table1.TextMatrix(iRow, 16)))

Else                                                        ' 2 = Flujo Pasivo (Venta)
    dblResultTC = getValorTasasByFecha(fecREP, CInt(Table1.TextMatrix(iRow, 10)), CInt(Table1.TextMatrix(iRow, 17)))

End If

'***************************************
' RETORNO VALORES A LA FILA
'***************************************
Table1.Row = iRow
Table1.Col = 21
Table1.CellFontBold = True
Table1.CellFontItalic = True
Table1.CellForeColor = vbRed
Table1.Text = BacFormatoMonto(dblResultTC, 6)

Table1.Col = 20
Table1.CellFontBold = True
Table1.CellFontItalic = True
Table1.CellForeColor = vbRed
Table1.Text = fecREP

Table1.Col = 19
Table1.Text = "N"
Toolbar1.Buttons(3).Enabled = True

End Sub
Private Function getValorTasasByFecha(dtFecha As Date, iCodMoneda As Integer, iCodTasa As Integer) As Double
Dim dblReturn As Double
dblReturn = 0
'MAP20-07-2015 Error falta la Perioricidad
Envia = Array()
AddParam Envia, Format(dtFecha, "yyyymmdd")
AddParam Envia, iCodMoneda
AddParam Envia, iCodTasa

If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_CON_TASA_MONEDAS", Envia) Then
   Exit Function
End If

If Bac_SQL_Fetch(Datos()) Then
   dblReturn = CDbl(Datos(4))
End If
getValorTasasByFecha = dblReturn

End Function


Private Sub ToolIBR_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim iContador  As Integer
   
   If MsgBox("¿ Esta seguro que desea aplicar el valor del IBR, para las Sgtes Operaciones. ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
      Exit Sub
   End If
   
   Screen.MousePointer = vbHourglass

   Envia = Array()
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(txtValorIbr.Text)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(2)  '-> Marca para el IBR
   If Not Bac_Sql_Execute("SP_GRABATASASFLUJOSINICIAN", Envia) Then
      Exit Sub
   End If
   For iContador = 1 To Table1.Rows - 1
      Envia = Array()
      AddParam Envia, Format(gsBAC_Fecp, "YYYYMMDD")
      AddParam Envia, CDbl(Table1.TextMatrix(iContador, 1))
      Call Bac_Sql_Execute("SP_ACTUALIZACION_SWAPICP", Envia)
   Next iContador
   
   Call cmdBuscar
   
   'MsgBox "Proceso ha finalizado correctamente.", vbInformation, TITSISTEMA
   Call EjecutaProcesoCalculoLiquidaciones
   Screen.MousePointer = vbDefault
End Sub
Private Sub ToolICP_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim iContador  As Integer
   
   If MsgBox("¿ Esta seguro que desea aplicar el valor del ICP, para las Sgtes Operaciones. ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
      Exit Sub
   End If
   
   Screen.MousePointer = vbHourglass
   
   Envia = Array()
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(txtValorIcp.Text)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(1)  '-> Marca para el ICP
   If Not Bac_Sql_Execute("SP_GRABATASASFLUJOSINICIAN", Envia) Then
      Exit Sub
   End If
   For iContador = 1 To Table1.Rows - 1
      Envia = Array()
      AddParam Envia, Format(gsBAC_Fecp, "YYYYMMDD")
      AddParam Envia, CDbl(Table1.TextMatrix(iContador, 1))
      Call Bac_Sql_Execute("SP_ACTUALIZACION_SWAPICP", Envia)
   Next iContador
   
   Call cmdBuscar
   
   'MsgBox "Proceso ha finalizado correctamente.", vbInformation, TITSISTEMA
   Call EjecutaProcesoCalculoLiquidaciones
   Screen.MousePointer = vbDefault
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
   
   For iContador = 1 To Table1.Rows - 1
      If CDbl(Table1.TextMatrix(iContador, 7)) <> 0# Then
         Envia = Array()
         AddParam Envia, Format(gsBAC_Fecp, "YYYYMMDD")
         AddParam Envia, CDbl(Table1.TextMatrix(iContador, 1))
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
'If Val(Txt_Ingreso.Text) = 0 Then
    lRowSel = Table1.RowSel

    'Call TraeValoresTasa(CDate(gstrFechaFijacion), glngCodTasa, glngCodMoneda)
    
    
    gstrFechaFijacion = ""
    gstrFechaFijacion = Table1.TextMatrix(lRowSel, 12)
    
    glngCodTasa = 0
    glngCodTasa = Table1.TextMatrix(lRowSel, 18)
    
    
    glngCodMoneda = 0
    glngCodMoneda = Table1.TextMatrix(lRowSel, 10)
    
    BacSeleccionaValorTasa.Top = BacSeleccionaValorTasa.Height + Txt_Ingreso.Top + (Txt_Ingreso.Height + 100)  'Table1.Top 'Table1.CellTop '
    BacSeleccionaValorTasa.Left = Table1.CellLeft + Txt_Ingreso.Width - BacSeleccionaValorTasa.Width  '
    
    BacSeleccionaValorTasa.Show vbModal
    

    
    
    strDigitaSN = "N"
    If gdblValorTasaFlujo <> 0 Then
        Txt_Ingreso.Visible = False
        
        Table1.Row = lRowSel
        Table1.Col = 21
        Table1.CellFontBold = True
        Table1.CellFontItalic = True
        Table1.CellForeColor = vbRed
        Table1.Text = BacFormatoMonto(gdblValorTasaFlujo, 6)
        
        Table1.Col = 20
        Table1.CellFontBold = True
        Table1.CellFontItalic = True
        Table1.CellForeColor = vbRed
        Table1.Text = gstrFechaFinal
        
        
        Table1.Col = 19
        Table1.Text = "N"
        

        
        
        
    
       ' Txt_Ingreso.Text = BacFormatoMonto(gdblValorTasaFlujo, 6)
    End If
    
'End If
End Sub
Private Sub Txt_Ingreso_KeyPress(KeyAscii As Integer)
   If KeyAscii = 27 Then
      Txt_Ingreso.Visible = False
      Table1.SetFocus
   End If
   If KeyAscii = 13 Then
      If Trim(Txt_Ingreso.Text) = "" Then
         Exit Sub
      End If
      strDigitaSN = "S"
     ' blnEscribeMonto = True

      If Trim(Txt_Ingreso.Text) <> 0 Then
        Table1.Text = BacFormatoMonto(CDbl(Txt_Ingreso.Text), 6)
      Else
        Table1.Text = 0
      End If
      Table1.Col = 21
      Table1.CellFontBold = True
      Table1.CellFontItalic = True
      Table1.CellForeColor = vbRed
      
      Table1.Col = 19
      Table1.Text = "S"
      Call MarcaFila(Table1.RowSel)
      
      '***************************************
      ' HABILITO BOTON GRABAR
      '***************************************
      Toolbar1.Buttons(3).Enabled = True
    
      Txt_Ingreso.Visible = False
      Table1.SetFocus
   End If
End Sub
Private Sub cmdFiltrar()
   FrmFiltroFecha.Show
   BacTasaFlujo.Enabled = False
End Sub
Private Sub Form_Resize()
    On Error Resume Next
    frame.Item(3).Width = Me.Width - 150
           Label2.Width = frame.Item(3).Width - 150
        CuadroIcp.Width = frame.Item(3).Width
        CuadroIBR.Width = frame.Item(3).Width
           Frame1.Width = frame.Item(3).Width
    frame.Item(1).Width = frame.Item(3).Width
   frame.Item(1).Height = Me.Height - 3000
           Table1.Width = frame.Item(1).Width - 150
          Table1.Height = frame.Item(1).Height - 250
    On Error GoTo 0
End Sub

