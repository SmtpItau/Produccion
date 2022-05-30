VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_COBERTURA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Coberturas."
   ClientHeight    =   6705
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   11985
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6705
   ScaleWidth      =   11985
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11985
      _ExtentX        =   21140
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "Filtrar"
            Object.ToolTipText     =   "Filtrar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cerrar"
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   7215
         Top             =   30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   5
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_COBERTURA.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_COBERTURA.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_COBERTURA.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_COBERTURA.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_COBERTURA.frx":2FA8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame CudroDerivado 
      Height          =   2190
      Left            =   15
      TabIndex        =   1
      Top             =   435
      Width           =   8445
      Begin VB.TextBox ClienteDerivado 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1875
         TabIndex        =   15
         Text            =   "97.051.000-1          --          BANCO DEL DESARROLLO"
         Top             =   495
         Width           =   6465
      End
      Begin VB.TextBox MonedaDerivado 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1875
         TabIndex        =   13
         Text            =   "USD"
         Top             =   825
         Width           =   1140
      End
      Begin BACControles.TXTNumero NumeroDerivado 
         Height          =   315
         Left            =   1875
         TabIndex        =   5
         Top             =   165
         Width           =   1140
         _ExtentX        =   2011
         _ExtentY        =   556
         BackColor       =   -2147483644
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero CorrelativoDerivado 
         Height          =   315
         Left            =   6060
         TabIndex        =   6
         Top             =   165
         Width           =   1140
         _ExtentX        =   2011
         _ExtentY        =   556
         BackColor       =   -2147483644
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero MontoDerivado 
         Height          =   315
         Left            =   1875
         TabIndex        =   7
         Top             =   1155
         Width           =   2280
         _ExtentX        =   4022
         _ExtentY        =   556
         BackColor       =   -2147483644
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
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
      Begin BACControles.TXTNumero MontoCubierto 
         Height          =   315
         Left            =   1875
         TabIndex        =   9
         Top             =   1485
         Width           =   2280
         _ExtentX        =   4022
         _ExtentY        =   556
         BackColor       =   -2147483644
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
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
      Begin BACControles.TXTNumero MontoPorCubrir 
         Height          =   315
         Left            =   1875
         TabIndex        =   11
         Top             =   1815
         Width           =   2280
         _ExtentX        =   4022
         _ExtentY        =   556
         BackColor       =   -2147483644
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
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
      Begin BACControles.TXTNumero ValorRazonableOcupado 
         Height          =   315
         Left            =   6060
         TabIndex        =   20
         Top             =   1485
         Width           =   2280
         _ExtentX        =   4022
         _ExtentY        =   556
         BackColor       =   -2147483644
         ForeColor       =   -2147483635
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero ValorRazonableDisponible 
         Height          =   315
         Left            =   6060
         TabIndex        =   22
         Top             =   1815
         Width           =   2280
         _ExtentX        =   4022
         _ExtentY        =   556
         BackColor       =   -2147483644
         ForeColor       =   -2147483635
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero ValorRazonableMonto 
         Height          =   315
         Left            =   6060
         TabIndex        =   27
         Top             =   1155
         Width           =   2280
         _ExtentX        =   4022
         _ExtentY        =   556
         BackColor       =   -2147483644
         ForeColor       =   -2147483635
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Etiquetas 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Valor Razonable"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000002&
         Height          =   315
         Index           =   9
         Left            =   4155
         TabIndex        =   28
         Top             =   1155
         Width           =   1890
      End
      Begin VB.Label Etiquetas 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Valor Razonable"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000002&
         Height          =   315
         Index           =   11
         Left            =   4155
         TabIndex        =   21
         Top             =   1815
         Width           =   1890
      End
      Begin VB.Label Etiquetas 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Valor Razonable"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000002&
         Height          =   315
         Index           =   10
         Left            =   4155
         TabIndex        =   19
         Top             =   1485
         Width           =   1890
      End
      Begin VB.Label Etiquetas 
         Caption         =   "Cliente Derivado"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   6
         Left            =   90
         TabIndex        =   14
         Top             =   510
         Width           =   1785
      End
      Begin VB.Label Etiquetas 
         Caption         =   "Moneda Derivado"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   5
         Left            =   90
         TabIndex        =   12
         Top             =   840
         Width           =   1785
      End
      Begin VB.Label Etiquetas 
         Caption         =   "Monto Disponible"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Index           =   4
         Left            =   90
         TabIndex        =   10
         Top             =   1860
         Width           =   1785
      End
      Begin VB.Label Etiquetas 
         Caption         =   "Monto Ocupado"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   3
         Left            =   90
         TabIndex        =   8
         Top             =   1530
         Width           =   1785
      End
      Begin VB.Label Etiquetas 
         Caption         =   "Monto Derivado"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   2
         Left            =   75
         TabIndex        =   4
         Top             =   1185
         Width           =   1785
      End
      Begin VB.Label Etiquetas 
         Caption         =   "Correlativo Derivado"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   1
         Left            =   4260
         TabIndex        =   3
         Top             =   180
         Width           =   1785
      End
      Begin VB.Label Etiquetas 
         Caption         =   "Número Derivado"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   0
         Left            =   90
         TabIndex        =   2
         Top             =   180
         Width           =   1785
      End
   End
   Begin VB.Frame Frame2 
      Height          =   2190
      Left            =   8460
      TabIndex        =   23
      Top             =   435
      Width           =   3525
      Begin BACControles.TXTNumero SumatoriaValorRazonable 
         Height          =   330
         Left            =   1470
         TabIndex        =   29
         Top             =   1740
         Width           =   1920
         _ExtentX        =   3387
         _ExtentY        =   582
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.ComboBox cmbProducto 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   70
         Style           =   2  'Dropdown List
         TabIndex        =   25
         Top             =   495
         Width           =   3390
      End
      Begin VB.ComboBox cmbSistema 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   70
         Style           =   2  'Dropdown List
         TabIndex        =   24
         Top             =   150
         Width           =   3390
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Suma Valores Razonables"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   7
         Left            =   90
         TabIndex        =   30
         Top             =   1485
         Width           =   2145
      End
      Begin VB.Label LBLNUMCOBERTURA 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "156"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   18
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   510
         Left            =   75
         TabIndex        =   26
         Top             =   840
         Width           =   3390
      End
   End
   Begin VB.Frame Frame1 
      Height          =   4155
      Left            =   15
      TabIndex        =   16
      Top             =   2535
      Width           =   11970
      Begin BACControles.TXTNumero txtGrilla 
         Height          =   210
         Left            =   5265
         TabIndex        =   18
         Top             =   480
         Visible         =   0   'False
         Width           =   945
         _ExtentX        =   1667
         _ExtentY        =   370
         BackColor       =   -2147483644
         ForeColor       =   -2147483641
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   3975
         Left            =   60
         TabIndex        =   17
         Top             =   135
         Width           =   11850
         _ExtentX        =   20902
         _ExtentY        =   7011
         _Version        =   393216
         Cols            =   9
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483644
         GridColorFixed  =   -2147483642
         FocusRect       =   0
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
Attribute VB_Name = "FRM_MNT_COBERTURA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Enum MiCargaMasiva
   [Sistemas] = 1
   [Productos] = 2
End Enum
Dim bEsCobertura        As Boolean
Dim nCobertura          As Double
Dim iOpRelacionadas     As Long
Public Derivado         As Long
Public Correlativo      As Long
Public Modulo           As String
Private objMoneda       As Object
Private objProducto     As Object
Private objMensajes     As Object
Private clsOperacion    As Object
Private ObjCliente      As Object

Private Const gModulo = 0
Private Const gOperacion = 1
Private Const gCorrelativo = 2
Private Const gSerie = 3
Private Const gMoneda = 4
Private Const gNominalOperacion = 5
Private Const gvRazvMercado = 6
Private Const gNominalCubrir = 7
Private Const gvRazonable = 8
Private Const gMontoDerivado = 9
Private Const gvRazonableDerivado = 10
Private Const gPorcentaje = 11
Private Const gMarca = 12

Private Sub NombresGrilla()
    Grid.Rows = 1
    Grid.Cols = 13

    Grid.AllowUserResizing = flexResizeColumns
    
    Grid.TextMatrix(0, gModulo) = "Módulo":                                Grid.ColWidth(gModulo) = 750
    Grid.TextMatrix(0, gOperacion) = "N° Operación":                       Grid.ColWidth(gOperacion) = 1150
    Grid.TextMatrix(0, gCorrelativo) = "N° Correlativo":                   Grid.ColWidth(gCorrelativo) = 1200
    Grid.TextMatrix(0, gSerie) = "Serie":                                  Grid.ColWidth(gSerie) = 1200
    Grid.TextMatrix(0, gMoneda) = "Moneda":                                Grid.ColWidth(gMoneda) = 950
    Grid.TextMatrix(0, gNominalOperacion) = "Nominales Operación":         Grid.ColWidth(gNominalOperacion) = 2100
    Grid.TextMatrix(0, gvRazvMercado) = "vRazonable vMercado":             Grid.ColWidth(gvRazvMercado) = 2200
    Grid.TextMatrix(0, gNominalCubrir) = "Nominales a Cubrir":             Grid.ColWidth(gNominalCubrir) = 2100
    Grid.TextMatrix(0, gvRazonable) = "Valor Razonable":                   Grid.ColWidth(gvRazonable) = 2100
    Grid.TextMatrix(0, gMontoDerivado) = "Mto. Derivado a Asignar":        Grid.ColWidth(gMontoDerivado) = 2200
    Grid.TextMatrix(0, gvRazonableDerivado) = "Valor Razonable Derivado":  Grid.ColWidth(gvRazonableDerivado) = 2200
    Grid.TextMatrix(0, gPorcentaje) = "Porcentaje":                        Grid.ColWidth(gPorcentaje) = 1400
    Grid.TextMatrix(0, gMarca) = "Marca":                                  Grid.ColWidth(gMarca) = 0
End Sub

Private Sub cmbSistema_Click()
   Call CargaObj(Productos, cmbProducto, Right(cmbSistema, 5))
End Sub

Private Sub Form_Activate()
   If bEsCobertura = False Then
      Unload Me
   End If
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   CudroDerivado.Enabled = False
   Me.Toolbar1.Buttons.Item(2).Visible = False
   bEsCobertura = False
   iOpRelacionadas = 1
   
   Call NombresGrilla
   Call CargaObj(Sistemas, cmbSistema)
   
   Call CargarDerivado
   Call CargarDatos("", "")
End Sub

Private Sub CargarDerivado()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(1)
   AddParam Envia, Modulo
   AddParam Envia, CDbl(Derivado)
   AddParam Envia, CDbl(Correlativo)
   If Not Bac_Sql_Execute("BacTraderSuda..SP_LEE_OPERACION_COBERTURA", Envia) Then
      Exit Sub
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(6) <> "C" Then
         MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "La operación seleccionada, no se encuentra asociadad a la cartera Cobertura.", vbExclamation, TITSISTEMA
         Exit Sub
      End If
      
      bEsCobertura = True
      
      NumeroDerivado.Text = Datos(1)
      CorrelativoDerivado.Text = Datos(2)
      ClienteDerivado.Text = Datos(3)
      MonedaDerivado.Text = Datos(4)
      MontoDerivado.Text = Datos(5)
      ValorRazonableMonto.CantidadDecimales = 0
      ValorRazonableMonto.Text = CDbl(Datos(7)) '--> fRes_Obtenido
      
      If ValorRazonableMonto.Text = 0# Then
         ValorRazonableMonto.Text = ValorizacionOnLine(Derivado)
      End If
      
      MontoPorCubrir.Text = MontoDerivado.Text

      ValorRazonableDisponible.Text = ValorRazonableDerivado(MontoDerivado.Text, MontoPorCubrir.Text, ValorRazonableMonto.Text)
      ValorRazonableOcupado.Text = ValorRazonableDerivado(MontoDerivado.Text, MontoCubierto.Text, ValorRazonableMonto.Text)
      
      Call VerOcupado
   Else
      MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "La operación no se encuentra vigente o no se encuentra asociadad a la cartera Cobertura.", vbExclamation, TITSISTEMA
      Exit Sub
   End If
End Sub

Private Sub VerOcupado()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, Modulo
   AddParam Envia, CDbl(Derivado)
   AddParam Envia, CDbl(Correlativo)
   If Not Bac_Sql_Execute("BacTraderSuda..SP_LEE_OPERACION_COBERTURA", Envia) Then
      Exit Sub
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) >= 0 Then
         nCobertura = CDbl(Datos(3))
         MontoDerivado.Text = CDbl(Datos(4))
         MontoCubierto.Text = CDbl(Datos(5))
         MontoPorCubrir.Text = CDbl(Datos(6))
         LBLNUMCOBERTURA.Caption = "N°: " & nCobertura
      
         ValorRazonableDisponible.Text = ValorRazonableDerivado(MontoDerivado.Text, MontoPorCubrir.Text, ValorRazonableMonto.Text)
         ValorRazonableOcupado.Text = ValorRazonableDerivado(MontoDerivado.Text, MontoCubierto.Text, ValorRazonableMonto.Text)

         Call CargaOpRelacionadas
      Else
         LBLNUMCOBERTURA.Caption = "N°: 0 / Nueva"
         nCobertura = CDbl(Datos(3))
      End If
   End If
End Sub

Private Sub CargaOpRelacionadas()
   Dim Datos()
   Dim MiFormato As String
   
   Envia = Array()
   AddParam Envia, CDbl(3)
   AddParam Envia, Modulo
   AddParam Envia, CDbl(Derivado)
   AddParam Envia, CDbl(Correlativo)
   AddParam Envia, CDbl(nCobertura)
   If Not Bac_Sql_Execute("BacTraderSuda..SP_LEE_OPERACION_COBERTURA", Envia) Then
      Exit Sub
   End If
   Grid.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Grid.Rows = Grid.Rows + 1
      MiFormato = "#,##0.0000"
      If Left(Datos(5), 3) = "CLP" Then
         MiFormato = "#,##0"
      End If
      Grid.TextMatrix(Grid.Rows - 1, gModulo) = Datos(1)
      Grid.TextMatrix(Grid.Rows - 1, gOperacion) = Datos(2)
      Grid.TextMatrix(Grid.Rows - 1, gCorrelativo) = Datos(3)
      Grid.TextMatrix(Grid.Rows - 1, gSerie) = Datos(4)
      Grid.TextMatrix(Grid.Rows - 1, gMoneda) = Datos(5)
      Grid.TextMatrix(Grid.Rows - 1, gNominalOperacion) = Format(Datos(6), MiFormato)
      Grid.TextMatrix(Grid.Rows - 1, gvRazvMercado) = Format(Datos(7), MiFormato)
      Grid.TextMatrix(Grid.Rows - 1, gNominalCubrir) = Format(Datos(8), MiFormato)
      Grid.TextMatrix(Grid.Rows - 1, gvRazonable) = Format(Datos(9), MiFormato)
      Grid.TextMatrix(Grid.Rows - 1, gMontoDerivado) = Format(Datos(10), "#,##0.0000")
      Grid.TextMatrix(Grid.Rows - 1, gvRazonableDerivado) = Format(Datos(11), "#,##0.0000")
      Grid.TextMatrix(Grid.Rows - 1, gPorcentaje) = Format(Datos(12), "#,##0.0000")
      Grid.TextMatrix(Grid.Rows - 1, gMarca) = ""
   Loop
   iOpRelacionadas = Grid.Rows
End Sub

Private Sub CargarDatos(ByVal cModulo As String, ByVal cProducto As String)
   On Error GoTo GetData
   Dim Datos()
   Dim iContador  As Long
   Dim bExiste    As Boolean
   Dim MiFormato  As String
   
   Screen.MousePointer = vbHourglass

   Envia = Array()
   AddParam Envia, Format(gsBAC_Fecp, "YYYYMMDD")
   AddParam Envia, Trim(cModulo)
   AddParam Envia, Trim(cProducto)
   AddParam Envia, CDbl(nCobertura)
   If Not Bac_Sql_Execute("BacTraderSuda..SP_CARGA_OPERACIONES_COBERTURA", Envia) Then
      GoTo GetData
   End If
   Grid.Rows = iOpRelacionadas
   Do While Bac_SQL_Fetch(Datos())
      Grid.Rows = Grid.Rows + 1
      MiFormato = "#,##0.0000"
      If Left(Datos(5), 3) = "CLP" Then
         MiFormato = "#,##0"
      End If
      
      Grid.TextMatrix(Grid.Rows - 1, gModulo) = Datos(1)
      Grid.TextMatrix(Grid.Rows - 1, gOperacion) = Datos(2)
      Grid.TextMatrix(Grid.Rows - 1, gCorrelativo) = Datos(3)
      Grid.TextMatrix(Grid.Rows - 1, gSerie) = Datos(4)
      Grid.TextMatrix(Grid.Rows - 1, gMoneda) = Datos(5)
      Grid.TextMatrix(Grid.Rows - 1, gNominalOperacion) = Format(Datos(6), "#,##0.0000")
      Grid.TextMatrix(Grid.Rows - 1, gvRazvMercado) = Format(Datos(8), "#,##0.0000")
      Grid.TextMatrix(Grid.Rows - 1, gNominalCubrir) = Format(0#, "#,##0.0000")
      Grid.TextMatrix(Grid.Rows - 1, gvRazonable) = Format(0#, "#,##0.0000")
      Grid.TextMatrix(Grid.Rows - 1, gMontoDerivado) = Format(0#, "#,##0.0000")
      Grid.TextMatrix(Grid.Rows - 1, gvRazonableDerivado) = Format(0#, "#,##0.0000")
      Grid.TextMatrix(Grid.Rows - 1, gPorcentaje) = Format(0#, "#,##0.0000")
      Grid.TextMatrix(Grid.Rows - 1, gMarca) = ""
   Loop
   Grid.Redraw = True

   SumatoriaValorRazonable.Text = SumaColumna(gvRazonable)
   
   Screen.MousePointer = vbDefault
Exit Sub
GetData:
   Grid.Redraw = True
   Screen.MousePointer = vbDefault
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = gNominalCubrir Or Grid.ColSel = gMontoDerivado Then
         Call PROC_POSICIONA_TEXTO(Grid, txtGrilla)
         txtGrilla.CantidadDecimales = 4
         txtGrilla.Text = CDbl(Grid.TextMatrix(Grid.RowSel, Grid.ColSel))
         txtGrilla.Visible = True
         txtGrilla.SetFocus
         Grid.Enabled = False
         Toolbar1.Enabled = False
         Frame2.Enabled = False
      End If
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Key
      Case "Buscar"
         Call CargarDatos(Right(cmbSistema.Text, 3), Right(cmbProducto.Text, 5))
      Case "Grabar"
         Call GrabarRelacion
      Case "Eliminar"
         Call BorrarRelacion
      Case "Cerrar"
         Unload Me
   End Select
End Sub

Private Sub CargaObj(miCarga As MiCargaMasiva, objCarga As ComboBox, Optional MiValor As Variant)
   Dim SQL     As String
   Dim Datos()
   
   SQL = ""
   If miCarga = Sistemas Then
      SQL = "SELECT nombre_sistema , id_sistema FROM BacParamSuda..SISTEMA_CNT WHERE operativo = 'S' AND gestion = 'N' "
   Else
      If MiValor = "" Then
         Exit Sub
      End If
      SQL = "SELECT descripcion , codigo_producto FROM BacParamSuda..PRODUCTO WHERE id_sistema ='" & Trim(MiValor) & "' ORDER BY descripcion "
   End If
   
   Call Bac_Sql_Execute(SQL)
   objCarga.Clear
   If miCarga = Sistemas Then
      objCarga.AddItem "<< TODOS >>" & Space(100) & "   "
   End If
   Do While Bac_SQL_Fetch(Datos())
      objCarga.AddItem Datos(1) & Space(100) & Datos(2)
   Loop
End Sub

Private Sub txtGrilla_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim iMonto              As Double
   Dim cMoneda             As String
   Dim iSuma               As Double
   Dim nValRazonable       As Double
   Dim MiFormato           As String
   
   If KeyCode = vbKeyReturn Then
      cMoneda = Trim(Right(Grid.TextMatrix(Grid.RowSel, gMoneda), 3))
      iMonto = txtGrilla.Text
      
      If ValorRazonableMonto.Text = 0# Then
         ValorRazonableMonto.Text = ValorizacionOnLine(NumeroDerivado.Text)
      End If
      
      If Grid.ColSel = gMontoDerivado Then
         iSuma = SumaOperaciones(gMontoDerivado)
         If MontoDerivado.Text < iSuma Then
            MsgBox "Monto a Utilizar Supera el Monto del Derivado.", vbExclamation, TITSISTEMA
            Exit Sub
         End If
         
         MontoCubierto.Text = Format(iSuma, "#,##0.0000")
         MontoPorCubrir.Text = CDbl(MontoDerivado.Text) - iSuma
         Grid.TextMatrix(Grid.RowSel, gMontoDerivado) = Format(iMonto, "#,##0.0000")
         '-- Valor Razonable en Factor del Monto Total Ocupado del Derivado
         ValorRazonableOcupado.Text = ValorRazonableDerivado(MontoDerivado.Text, MontoCubierto.Text, ValorRazonableMonto.Text)
         '-- Valor Razonable en Factor del Monto Total Disponible del Derivado
         ValorRazonableDisponible.Text = ValorRazonableDerivado(MontoDerivado.Text, MontoPorCubrir.Text, ValorRazonableMonto.Text)
         '-- Valor Razonable en Factor del Monto Asignado del Derivado
         Grid.TextMatrix(Grid.RowSel, gvRazonableDerivado) = Format(ValorRazonableDerivado(MontoDerivado.Text, CDbl(Grid.TextMatrix(Grid.RowSel, gMontoDerivado)), ValorRazonableMonto.Text), "#,##0.0000")
         '-- Porcentaje Efectividad
         Grid.TextMatrix(Grid.RowSel, gPorcentaje) = Format(iPorcentajeEfectividad(CDbl(Grid.TextMatrix(Grid.RowSel, gvRazonableDerivado)), CDbl(Grid.TextMatrix(Grid.RowSel, gvRazonable))), "#,##0.0000")
         
         '-- Determina Registro Modificado
         Grid.TextMatrix(Grid.RowSel, gMarca) = "X"
         GoTo Habilita
         Exit Sub
      End If
      If Grid.ColSel = gNominalCubrir Then
         MiFormato = "#,##0.0000"
         If cMoneda = 999 Then
            MiFormato = "#,##0"
         End If
         
         '-- Monto Nominal a Cubrir
         Grid.TextMatrix(Grid.RowSel, gNominalCubrir) = Format(txtGrilla.Text, MiFormato)
         '-- Valor Razonable Porcentual al Nominal a Cubrir
         Grid.TextMatrix(Grid.RowSel, gvRazonable) = Format(ValorRazonableDerivado(CDbl(Grid.TextMatrix(Grid.RowSel, gNominalOperacion)), CDbl(Grid.TextMatrix(Grid.RowSel, gNominalCubrir)), CDbl(Grid.TextMatrix(Grid.RowSel, gvRazvMercado))), MiFormato)
         '-- Porcentaje Efectividad
         Grid.TextMatrix(Grid.RowSel, gPorcentaje) = Format(iPorcentajeEfectividad(CDbl(Grid.TextMatrix(Grid.RowSel, gvRazonableDerivado)), CDbl(Grid.TextMatrix(Grid.RowSel, gvRazonable))), "#,##0.0000")
         '-- Sumatoria
         SumatoriaValorRazonable.Text = SumaColumna(gvRazonable)
         
         '-- Determina Registro Modificado
         Grid.TextMatrix(Grid.RowSel, gMarca) = "X"
         GoTo Habilita
         Exit Sub
      End If
   End If
   If KeyCode = vbKeyEscape Then
      GoTo Habilita
   End If

Exit Sub
Habilita:
   Grid.Enabled = True
   Toolbar1.Enabled = True
   Frame2.Enabled = True
   txtGrilla.Visible = False
   Grid.SetFocus

End Sub

Private Function SumaOperaciones(ByVal MiColumna As Integer) As Double
   Dim iContador  As Integer
   Dim iMonto     As Double
   Dim iMontoAux  As Double
   
   iMontoAux = (CDbl(txtGrilla.Text) - CDbl(Grid.TextMatrix(Grid.RowSel, MiColumna)))
   
   iMonto = 0#
   For iContador = 1 To Grid.Rows - 1
      iMonto = iMonto + CDbl(Grid.TextMatrix(iContador, MiColumna))
   Next iContador
   
   SumaOperaciones = (iMonto + iMontoAux)
End Function

Private Sub GrabarRelacion()
   On Error GoTo ErrorSaveCobertura
   Dim Datos()
   Dim iContador  As Integer
   Dim Indicador  As Boolean
   Dim Efectivo   As Double
   Dim bPasa      As Boolean
   
   Indicador = False
   
   Call BacBeginTransaction
   
   Envia = Array()
   AddParam Envia, Format(gsBAC_Fecp, "YYYYMMDD")
   AddParam Envia, CDbl(nCobertura)
   AddParam Envia, Modulo
   AddParam Envia, CDbl(Derivado)
   AddParam Envia, CDbl(Correlativo)
   AddParam Envia, CDbl(MontoDerivado.Text)
   AddParam Envia, CDbl(MontoCubierto.Text)
   AddParam Envia, CDbl(MontoPorCubrir.Text)
   AddParam Envia, CDbl(ValorRazonableOcupado.Text)
   AddParam Envia, CDbl(ValorRazonableDisponible.Text)
   AddParam Envia, CDbl(ValorRazonableMonto.Text)
   If Not Bac_Sql_Execute("BacTraderSuda..SP_GRABAR_COBERTURA", Envia) Then
      GoTo ErrorSaveCobertura
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If nCobertura <> CDbl(Datos(1)) Then
         nCobertura = CDbl(Datos(1))
      End If
   End If
   
   For iContador = 1 To Grid.Rows - 1
      If Grid.TextMatrix(iContador, gMarca) = "X" Then
         Efectivo = CDbl(Grid.TextMatrix(iContador, gPorcentaje))
         bPasa = True
         If Not (Efectivo >= 80# And Efectivo <= 125#) Then
            bPasa = False
            If CDbl(Grid.TextMatrix(iContador, gNominalCubrir)) = 0# Or CDbl(Grid.TextMatrix(iContador, gMontoDerivado)) = 0# Then
               bPasa = True
            Else
               bPasa = False
            End If
         End If
         If bPasa = True Then
            Envia = Array()
            AddParam Envia, CDbl(nCobertura)
            AddParam Envia, Grid.TextMatrix(iContador, gModulo)
            AddParam Envia, CDbl(Grid.TextMatrix(iContador, gOperacion))
            AddParam Envia, CDbl(Grid.TextMatrix(iContador, gCorrelativo))
            AddParam Envia, Grid.TextMatrix(iContador, gSerie)
            AddParam Envia, Val(Trim(Right(Grid.TextMatrix(iContador, gMoneda), 3)))
            AddParam Envia, CDbl(Grid.TextMatrix(iContador, gNominalOperacion))
            AddParam Envia, CDbl(Grid.TextMatrix(iContador, gvRazvMercado))
            AddParam Envia, CDbl(Grid.TextMatrix(iContador, gNominalCubrir))
            AddParam Envia, CDbl(Grid.TextMatrix(iContador, gvRazonable))
            AddParam Envia, CDbl(Grid.TextMatrix(iContador, gMontoDerivado))
            AddParam Envia, CDbl(Grid.TextMatrix(iContador, gvRazonableDerivado))
            AddParam Envia, CDbl(Grid.TextMatrix(iContador, gPorcentaje))
            AddParam Envia, Format(gsBAC_Fecp, "YYYYMMDD")
            If Not Bac_Sql_Execute("BacTraderSuda..SP_GRABAR_DETALLE_COBERTURA", Envia) Then
               GoTo ErrorSaveCobertura
            End If
            Indicador = True
         Else
            MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "Operación : " & CDbl(Grid.TextMatrix(iContador, gOperacion)) & " No cumple con el porcentaje de efectividad (" & Efectivo & ") .... Reasigne.", vbExclamation, TITSISTEMA
            Call BacRollBackTransaction
            Exit Sub
         End If
      End If
   Next iContador

   Envia = Array()
   AddParam Envia, CDbl(nCobertura)
   If Not Bac_Sql_Execute("BacTraderSuda..SP_LIMPIA_DETALLE_COBERTURAS", Envia) Then
      GoTo ErrorSaveCobertura
   End If
   If Indicador = True Then
      Call BacCommitTransaction
   Else
      Call BacRollBackTransaction
   End If
   LBLNUMCOBERTURA.Caption = "N°: " & Str(nCobertura)
   MsgBox "Cobertura N°: " & Trim(nCobertura) & vbCrLf & vbCrLf & "La grabación de las coberturas se ha realizado en forma correcta.", vbInformation, TITSISTEMA
Exit Sub
ErrorSaveCobertura:
   Call BacRollBackTransaction
   MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "Ha ocurrido un error en la grabación de las coberturas.", vbCritical, TITSISTEMA
End Sub

Private Sub BorrarRelacion()
   If MsgBox("¿ Esta seguro de eliminar en forma permanente la cobertura. ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
      Exit Sub
   End If

   Envia = Array()
   AddParam Envia, CDbl(nCobertura)
   If Not Bac_Sql_Execute("BacTraderSuda..SP_ELIMINAR_COBERTURA", Envia) Then
      Exit Sub
   End If

   MsgBox "Acción Finalizada" & vbCrLf & vbCrLf & "La cobertura ha sido eliminada en forma permanente.", vbInformation, TITSISTEMA
   Unload Me
End Sub

Private Function ValorRazonableDerivado(ByVal nMontoOriginal As Double, ByVal nMontoCubrir As Double, ByVal nValorRazonable As Double) As Double
   ValorRazonableDerivado = BacDiv((nMontoCubrir * nValorRazonable), nMontoOriginal)
End Function

Private Function ValorRazonableOperacion(cSistema As String, nNumDocu As Long, nCorrela As Long, nMonto As Double, nMontoVar As Double) As Double
   On Error GoTo ErrorCalcVRaz
   Dim Datos()
   Dim MiValorRazonable As Double
   
   ValorRazonableOperacion = 0#
   MiValorRazonable = 0#
   
   Envia = Array()
   AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
   AddParam Envia, cSistema
   AddParam Envia, CDbl(nNumDocu)
   AddParam Envia, CDbl(nCorrela)
   If Not Bac_Sql_Execute("BacTraderSuda..SP_VALOR_RAZONABLE", Envia) Then
      GoTo ErrorCalcVRaz
   End If
   If Bac_SQL_Fetch(Datos()) Then
      MiValorRazonable = CDbl(Datos(1))
      ValorRazonableOperacion = BacDiv((nMontoVar * MiValorRazonable), nMonto)
   End If
Exit Function
ErrorCalcVRaz:
   ValorRazonableOperacion = 0#
End Function

Private Function SumaColumna(ByVal MiColumna As Integer) As Double
   Dim iContador  As Integer
   Dim iMonto     As Double
   
   iMonto = 0#
   For iContador = 1 To Grid.Rows - 1
      iMonto = iMonto + CDbl(Grid.TextMatrix(iContador, MiColumna))
   Next iContador
   SumaColumna = iMonto
End Function

Private Function iPorcentajeEfectividad(nValRazDerivado As Double, nValRazonableOpe As Double) As Double
   iPorcentajeEfectividad = Round(BacDiv(nValRazDerivado, nValRazonableOpe) * 100#, 4#)
End Function

Private Function ValorizacionOnLine(MiDerivado As Long) As Double
   On Error GoTo ErrorValorizacion
   Dim Datos()
   
   ValorizacionOnLine = 0#
   
   Envia = Array()
   AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
   AddParam Envia, CDbl(MiDerivado)
   AddParam Envia, Modulo
   If Not Bac_Sql_Execute("BacTraderSuda..SP_VALORIZACION_BFW", Envia) Then
      GoTo ErrorValorizacion
   End If
   If Bac_SQL_Fetch(Datos()) Then
      ValorizacionOnLine = CDbl(Datos(2))
   End If
Exit Function
ErrorValorizacion:
   MsgBox "Problemas en la Obtención del Valor Razonable.", vbExclamation, TITSISTEMA

End Function
