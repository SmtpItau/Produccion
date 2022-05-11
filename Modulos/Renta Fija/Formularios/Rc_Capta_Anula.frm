VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form recompras_anticipadas_captaciones_Anulacion 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Anulación de Recompras Anticipadas DAP"
   ClientHeight    =   6840
   ClientLeft      =   615
   ClientTop       =   1020
   ClientWidth     =   11340
   Icon            =   "Rc_Capta_Anula.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6840
   ScaleWidth      =   11340
   Tag             =   "RI"
   Begin VB.Frame Frame3 
      BackColor       =   &H80000004&
      Caption         =   "Detalle Recompra"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000002&
      Height          =   4515
      Left            =   0
      TabIndex        =   6
      Top             =   2280
      Width           =   11295
      Begin MSFlexGridLib.MSFlexGrid gr_cortes 
         Height          =   3555
         Left            =   120
         TabIndex        =   17
         TabStop         =   0   'False
         Top             =   480
         Width           =   11100
         _ExtentX        =   19579
         _ExtentY        =   6271
         _Version        =   393216
         Cols            =   15
         FixedCols       =   2
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         ForeColorSel    =   16777215
         Redraw          =   -1  'True
         AllowBigSelection=   -1  'True
         GridLines       =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.CommandButton Cmd_DesMarcar 
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   310
         Left            =   580
         TabIndex        =   25
         ToolTipText     =   "Desmarcar Todos"
         Top             =   4095
         Width           =   440
      End
      Begin VB.CommandButton Cmd_Marcar 
         Caption         =   "+"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   310
         Left            =   120
         TabIndex        =   24
         ToolTipText     =   "Seleccionar Todos"
         Top             =   4095
         Width           =   440
      End
      Begin BACControles.TXTNumero TxtCartera 
         Height          =   310
         Left            =   5505
         TabIndex        =   27
         Top             =   4095
         Width           =   2100
         _ExtentX        =   3704
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Max             =   "99999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TxtCarteraSel 
         Height          =   310
         Left            =   9075
         TabIndex        =   30
         Top             =   4095
         Width           =   2100
         _ExtentX        =   3704
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Max             =   "99999999999999"
         Separator       =   -1  'True
      End
      Begin VB.Label Label 
         BackStyle       =   0  'Transparent
         Caption         =   "R : Restaurar Corte "
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   200
         Index           =   1
         Left            =   9240
         TabIndex        =   32
         Top             =   200
         Width           =   1935
      End
      Begin VB.Label Label 
         BackStyle       =   0  'Transparent
         Caption         =   "A : Anular Corte"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   200
         Index           =   0
         Left            =   6720
         TabIndex        =   31
         Top             =   200
         Width           =   2175
      End
      Begin VB.Label Label3 
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   " Selección"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   310
         Left            =   7680
         TabIndex        =   29
         Top             =   4095
         Width           =   1395
      End
      Begin VB.Label Label6 
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   " Cartera"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   310
         Left            =   4095
         TabIndex        =   28
         Top             =   4095
         Width           =   1395
      End
   End
   Begin VB.Frame Frm_fechas 
      Caption         =   "Datos Recompra"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000002&
      Height          =   1680
      Left            =   0
      TabIndex        =   5
      Top             =   600
      Width           =   11295
      Begin BACControles.TXTFecha TxtFechaIni 
         Height          =   315
         Left            =   5565
         TabIndex        =   33
         Top             =   555
         Width           =   1350
         _ExtentX        =   2381
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "30/06/2009"
      End
      Begin VB.TextBox IntNumoper 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   180
         MaxLength       =   10
         MouseIcon       =   "Rc_Capta_Anula.frx":030A
         MousePointer    =   99  'Custom
         TabIndex        =   26
         ToolTipText     =   "Haga Doble Click para abrir la Ayuda"
         Top             =   550
         Width           =   1215
      End
      Begin VB.CommandButton Ayuda 
         Caption         =   "?"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1440
         TabIndex        =   23
         ToolTipText     =   "Ayuda de Operaciones"
         Top             =   550
         Width           =   300
      End
      Begin VB.ComboBox CmbTipo_Emision 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "Rc_Capta_Anula.frx":045C
         Left            =   5640
         List            =   "Rc_Capta_Anula.frx":045E
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   1230
         Width           =   3855
      End
      Begin VB.ComboBox CmbCondicion 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "Rc_Capta_Anula.frx":0460
         Left            =   3720
         List            =   "Rc_Capta_Anula.frx":0462
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1230
         Width           =   1890
      End
      Begin VB.ComboBox Cmb_Tipo_Deposito 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "Rc_Capta_Anula.frx":0464
         Left            =   1860
         List            =   "Rc_Capta_Anula.frx":0466
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   1230
         Width           =   1830
      End
      Begin VB.ComboBox Cmb_Custodia 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "Rc_Capta_Anula.frx":0468
         Left            =   180
         List            =   "Rc_Capta_Anula.frx":046A
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   1230
         Width           =   1635
      End
      Begin VB.ComboBox Cmb_Moneda 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1800
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   550
         Width           =   1590
      End
      Begin BACControles.TXTNumero Msk_Tasa 
         Height          =   315
         Left            =   6975
         TabIndex        =   22
         Top             =   555
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.000000"
         Text            =   "0.000000"
         Min             =   "-999"
         Max             =   "999"
         CantidadDecimales=   "6"
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero Txt_Dias 
         Height          =   315
         Left            =   4870
         TabIndex        =   18
         Top             =   550
         Width           =   615
         _ExtentX        =   1085
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Min             =   "1"
         Max             =   "9999"
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTFecha Msk_Fecha_Vcto 
         Height          =   315
         Left            =   3450
         TabIndex        =   19
         Top             =   550
         Width           =   1350
         _ExtentX        =   2381
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "30/06/2009"
      End
      Begin BACControles.TXTNumero Flt_TasaTran 
         Height          =   315
         Left            =   8250
         TabIndex        =   20
         Top             =   555
         Width           =   1260
         _ExtentX        =   2223
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.000000"
         Text            =   "0.000000"
         Min             =   "-999"
         Max             =   "999"
         CantidadDecimales=   "6"
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Fecha_Inicio 
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha Inicio"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   5565
         TabIndex        =   34
         Top             =   330
         Width           =   1215
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Operación "
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   195
         Index           =   10
         Left            =   180
         TabIndex        =   16
         Top             =   330
         Width           =   780
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo de Emisión"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   8
         Left            =   5640
         TabIndex        =   15
         Top             =   1005
         Width           =   1095
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Condición"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   7
         Left            =   3720
         TabIndex        =   14
         Top             =   1005
         Width           =   690
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo Depósito"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   2
         Left            =   1860
         TabIndex        =   13
         Top             =   1005
         Width           =   975
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Custodia"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   180
         TabIndex        =   12
         Top             =   1005
         Width           =   630
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Tasa Tran."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   8250
         TabIndex        =   11
         Top             =   330
         Width           =   780
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Vencimiento"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   195
         Index           =   6
         Left            =   3450
         TabIndex        =   10
         Top             =   330
         Width           =   855
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   195
         Index           =   5
         Left            =   1800
         TabIndex        =   9
         Top             =   330
         Width           =   570
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Plazo "
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   4
         Left            =   4875
         TabIndex        =   8
         Top             =   330
         Width           =   420
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Tasa Emisión"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   3
         Left            =   6975
         TabIndex        =   7
         Top             =   330
         Width           =   915
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   21
      Top             =   0
      Width           =   11340
      _ExtentX        =   20003
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbgrabar"
            Description     =   "GRABAR"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmblimpiar"
            Description     =   "LIMPIAR"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "salir"
            Description     =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5880
         Top             =   240
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   25
         ImageHeight     =   25
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Rc_Capta_Anula.frx":046C
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Rc_Capta_Anula.frx":08BE
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Rc_Capta_Anula.frx":0BD8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "recompras_anticipadas_captaciones_Anulacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim nDecimales      As String
Dim nDecInteres     As String
Dim bControl        As Boolean
Dim cFormato        As String
Dim objCondicion    As New ClsCodigos
Dim Color           As String
Dim colorletra      As String
Dim marcas          As Integer
Dim nCodcli&

Private Sub Formatos()
Dim i           As Integer
Dim nGlosa      As String
        
    Select Case Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)
        'Case 998, 999: nGlosa = " " & "$$"
        Case 999: nGlosa = " " & "$$"
        Case Else: nGlosa = " " & Trim(Mid(Cmb_Moneda.text, 1, 3))
    End Select
      
    '+++jcamposd iguala formateos entre recompra y anulacion
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 999 Then
            TxtCarteraSel.CantidadDecimales = 0
            TxtCarteraSel.Max = 99999999999#
            TxtCartera.CantidadDecimales = 0
            TxtCartera.Max = 99999999999#
            
    ElseIf Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
            TxtCarteraSel.CantidadDecimales = 4
            TxtCarteraSel.Max = 99999999999.9999
            TxtCartera.CantidadDecimales = 4
            TxtCartera.Max = 99999999999.9999
    Else
            TxtCarteraSel.CantidadDecimales = 2
            TxtCarteraSel.Max = 99999999999.99
            TxtCartera.CantidadDecimales = 2
            TxtCartera.Max = 99999999999.99
    End If
    '---jcamposd iguala formateos entre recompra y anulacion
      
    gr_cortes.TextMatrix(0, C_Valor_A_Pagar) = gr_cortes.TextMatrix(0, C_Valor_A_Pagar) & nGlosa
    gr_cortes.TextMatrix(0, C_Valor_A_Pagar_Org) = gr_cortes.TextMatrix(0, C_Valor_A_Pagar_Org) & nGlosa
    gr_cortes.TextMatrix(0, C_Interes_Pagar) = gr_cortes.TextMatrix(0, C_Interes_Pagar) & IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 999, nGlosa, " UM")

    TxtCartera.text = 0
    TxtCarteraSel.text = 0
    For i = 1 To gr_cortes.Rows - 1
        gr_cortes.TextMatrix(i, C_Bloqueo) = "A"
        gr_cortes.TextMatrix(i, C_Campo_Venta) = "X"
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ' Calculo Reajuste Recompra Captacion
    '    Call Calculo_Interes_Inicial(I)
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        TxtCartera.text = CDbl(TxtCartera.text) + CDbl(gr_cortes.TextMatrix(i, C_Valor_A_Pagar))
        TxtCarteraSel.text = CDbl(TxtCarteraSel.text) + IIf(gr_cortes.TextMatrix(i%, C_Campo_Venta) = "X", CDbl(gr_cortes.TextMatrix(i%, C_Valor_A_Pagar)), 0)
        Call Colores_Marca(i)
    Next i
TxtCartera.text = Format$(CDbl(TxtCartera.text), cFormato)
TxtCarteraSel.text = TxtCartera.text
            
End Sub

Private Sub PROC_CREA_GRILLA()
    gr_cortes.WordWrap = True
    gr_cortes.cols = 22
    gr_cortes.FixedCols = 3
    gr_cortes.Rows = 1
    gr_cortes.RowHeight(0) = 600
    gr_cortes.TextMatrix(0, C_Bloqueo) = "Marca /  Bloqueo"
    gr_cortes.TextMatrix(0, C_Num_Dcv) = "N° DCV Certificado"
    gr_cortes.TextMatrix(0, C_MONTO_CORTE) = "Capital                  Final UM"
    gr_cortes.TextMatrix(0, C_Tasa_Recompra) = "TIR"
    gr_cortes.TextMatrix(0, C_Interes_Pagar) = "Interes a        Pagar"
    gr_cortes.TextMatrix(0, C_Valor_A_Pagar) = "Valor Recompra "
    gr_cortes.TextMatrix(0, C_Tipo_Custodia) = "Tipo Custodia"
    gr_cortes.TextMatrix(0, C_Clave_Dcv) = "Clave          DCV"
    gr_cortes.TextMatrix(0, C_Monto_Corte_Org) = "Capital Inicial UM Recompra"
    gr_cortes.TextMatrix(0, C_Tasa_Compra_Org) = "Tasa Compra Recompra"
    gr_cortes.TextMatrix(0, C_Valor_A_Pagar_Org) = "Valor Devengado"
    gr_cortes.TextMatrix(0, C_Valor_Recompra) = "Valor Devengado"
    gr_cortes.TextMatrix(0, C_Interes_Dev) = "Interes Devengados" 'a Pagar Recompra +++jcamposd "Interes a Pagar Recompra"
    gr_cortes.TextMatrix(0, C_Reajuste_Dev) = "Reajuste a Pagar Recompra"
    gr_cortes.TextMatrix(0, C_Campo_Venta) = "Marca de Anticipo"
    gr_cortes.TextMatrix(0, C_Correlativo) = "Correlativo"
    gr_cortes.TextMatrix(0, C_Plazo) = "Plazo"
    gr_cortes.TextMatrix(0, C_Check_Interes) = "Interes Excedido"
    gr_cortes.TextMatrix(0, C_Reajuste_Pagar) = "Reajuste a       Pagar $$"
    '+++jcamposd recalculo
    gr_cortes.TextMatrix(0, C_monto_final_cap) = "Monto Final"
    gr_cortes.TextMatrix(0, C_resultado_Recompra) = "Resultado Recompra"
    '---jcamposd recalculo
    
    gr_cortes.ColWidth(C_Bloqueo) = 700
    gr_cortes.ColWidth(C_Num_Dcv) = 1200
    gr_cortes.ColWidth(C_MONTO_CORTE) = 1600
    gr_cortes.ColWidth(C_Tasa_Recompra) = 1050
    gr_cortes.ColWidth(C_Interes_Pagar) = 1300
    gr_cortes.ColWidth(C_Valor_A_Pagar) = 1600
    gr_cortes.ColWidth(C_Tipo_Custodia) = 0 '900 +++jcamposd recalculo
    gr_cortes.ColWidth(C_Reajuste_Pagar) = 0
    gr_cortes.ColWidth(C_Clave_Dcv) = 0 '900 +++jcamposd recalculo
    gr_cortes.ColWidth(C_Monto_Corte_Org) = 0
    gr_cortes.ColWidth(C_Tasa_Compra_Org) = 0
    gr_cortes.ColWidth(C_Valor_Recompra) = 0 '1600 +++jcamposd recalculo
    gr_cortes.ColWidth(C_Valor_A_Pagar_Org) = 0
    gr_cortes.ColWidth(C_Interes_Dev) = 1600 '0 +++jcamposd recalculo
    gr_cortes.ColWidth(C_Reajuste_Dev) = 0
    gr_cortes.ColWidth(C_Campo_Venta) = 0
    gr_cortes.ColWidth(C_Correlativo) = 0
    gr_cortes.ColWidth(C_Plazo) = 0
    gr_cortes.ColWidth(C_Check_Interes) = 0
    '+++jcamposd recalculo
    gr_cortes.ColWidth(C_monto_final_cap) = 0
    gr_cortes.ColWidth(C_resultado_Recompra) = 1300
    '---jcamposd recalculo
    
    gr_cortes.Refresh

End Sub

Private Sub Proc_Limpia_Pantalla()
Dim i%

    Msk_Tasa.text = ""
    Msk_Tasa.Tag = ""
    
    IntNumoper.text = 0
    IntNumoper.Enabled = True
    
    Txt_Dias.text = 0
    Txt_Dias.Tag = 0
    
    Flt_TasaTran.text = 0
    Flt_TasaTran.Tag = 0
    
    Cmb_Moneda.ListIndex = 0
    For i% = 0 To Cmb_Moneda.ListCount - 1
        If Mid(Cmb_Moneda.List(i%), 1, 1) = "C" Then
           Cmb_Moneda.ListIndex = i%
           Exit For
        End If
    Next i%
    
    TxtCartera.text = 0
    TxtCarteraSel.text = 0
        
    Msk_Fecha_Vcto.text = Format(gsBac_Fecp, "dd/mm/yyyy")
    
    Call PROC_CREA_GRILLA
   
End Sub

Private Sub Ayuda_Click()
 BacAyuda.Tag = "MDRIC"
 BacAyuda.Show 1
    
    If giAceptar% = True Then
        IntNumoper.text = gsrut$
        SendKeys "{TAB}"
        Call IntNumoper_KeyPress(13)
    Else
    IntNumoper.SelLength = Len(IntNumoper.text)
    If IntNumoper.Enabled = True Then
        IntNumoper.SetFocus
    End If
    End If
End Sub

Private Sub Cmb_Custodia_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
       Cmb_Tipo_Deposito.SetFocus
    End If

End Sub

Private Sub Cmb_Moneda_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      KeyAscii = 0
      Bac_SendKey vbKeyTab
      Cmb_Moneda.Tag = Cmb_Moneda.text
   End If

End Sub

Private Sub Cmb_Tipo_Deposito_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      KeyAscii = 0
      Bac_SendKey vbKeyTab
   End If

End Sub

Private Sub CmbCondicion_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      KeyAscii = 0
      Bac_SendKey vbKeyTab
   End If

End Sub

Private Sub Cmd_DesMarcar_Click()
Dim i As Integer

gr_cortes.Redraw = False
    
    TxtCarteraSel.text = CDbl(0)
    For i = 1 To gr_cortes.Rows - 1
        If gr_cortes.TextMatrix(i, C_Campo_Venta) = "X" Then
            gr_cortes.TextMatrix(i, C_Bloqueo) = ""
            gr_cortes.TextMatrix(i, C_Campo_Venta) = ""
            Call Colores_Marca(i)
        End If
    Next i
gr_cortes.Redraw = True
gr_cortes.SetFocus
End Sub

Private Sub Cmd_Marcar_Click()
Dim i As Integer

gr_cortes.Redraw = False
    TxtCarteraSel.text = CDbl(0)
    For i = 1 To gr_cortes.Rows - 1
        gr_cortes.TextMatrix(i, C_Bloqueo) = "A"
        gr_cortes.TextMatrix(i, C_Campo_Venta) = "X"
        Call Colores_Marca(i) 'Call Calculo_Interes(I)
        TxtCarteraSel.text = CDbl(TxtCarteraSel.text) + CDbl(gr_cortes.TextMatrix(i, C_Valor_A_Pagar))
    Next i
gr_cortes.Redraw = True
gr_cortes.SetFocus
End Sub

Private Sub Flt_Tasatran_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      KeyAscii = 0
      Bac_SendKey vbKeyTab
   End If

End Sub

Private Sub Form_Activate()
    Numero_RIC = Val(IntNumoper.text)
    IntNumoper.SelLength = Len(IntNumoper.text)
    If IntNumoper.Enabled = True Then
        IntNumoper.SetFocus
    End If
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub Form_Load()
    bControl = False
    
    Me.Left = 0:    Me.Top = 0
   'BacIrfGr.proTipoCp = "RIC"  '-> Se utiliza para el combo de Tipo de Pago mañana
   
   'Graba_RIC = True
   'Numero_RIC = 0

Screen.MousePointer = vbHourglass

    gr_cortes.ColWidth(0) = 0

    If Not funcFindMoneda(Cmb_Moneda, "IC") Then
        Exit Sub
    End If

    Cmb_Tipo_Deposito.Clear
    Cmb_Tipo_Deposito.AddItem "RENOVABLE":  Cmb_Tipo_Deposito.ItemData(Cmb_Tipo_Deposito.NewIndex) = 0
    Cmb_Tipo_Deposito.AddItem "FIJO":       Cmb_Tipo_Deposito.ItemData(Cmb_Tipo_Deposito.NewIndex) = 1
    If Cmb_Tipo_Deposito.ListCount > 0 Then
        Cmb_Tipo_Deposito.ListIndex = 0
    End If

    Cmb_Custodia.Clear
    Cmb_Custodia.AddItem "PROPIA":          Let Cmb_Custodia.ItemData(Cmb_Custodia.NewIndex) = 1
    Cmb_Custodia.AddItem "CLIENTE":         Let Cmb_Custodia.ItemData(Cmb_Custodia.NewIndex) = 2
    Cmb_Custodia.AddItem "DCV":             Let Cmb_Custodia.ItemData(Cmb_Custodia.NewIndex) = 2
    If Cmb_Custodia.ListCount > 0 Then
        Cmb_Custodia.ListIndex = 0
    End If

    Call Fx_Load_Data("CONDICION", Me.CmbCondicion)
       'Call objCondicion.CargaSucursal("CONDICION")
       'Call objCondicion.Coleccion2Control(CmbCondicion)
    If CmbCondicion.ListCount > 0 Then
        CmbCondicion.ListIndex = 0
    End If

    Call Fx_Load_Data("DEPOSITO", Me.CmbTipo_Emision)
       'Call objCondicion.CargaSucursal("DEPOSITO")
       'Call objCondicion.Coleccion2Control(CmbTipo_Emision)
    If CmbTipo_Emision.ListCount > 0 Then
        CmbTipo_Emision.ListIndex = 0
    End If

Screen.MousePointer = vbDefault

    bControl = True

    Cmb_Moneda.Tag = Cmb_Moneda.text
    Txt_Dias.Tag = Txt_Dias.text

    Msk_Tasa.Tag = Msk_Tasa.text
    Msk_Tasa.Enabled = True

    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False

    Call bloquea_controles
    Call Proc_Limpia_Pantalla
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Numero_RIC = 0
End Sub
Private Sub Gr_Cortes_KeyPress(KeyAscii As Integer)
Dim nRow  As Integer

nRow = gr_cortes.Row
If gr_cortes.Row > gr_cortes.FixedRows - 1 And UCase(Chr(KeyAscii)) <> "*" Then
    If UCase(Chr(KeyAscii)) = "R" Then 'RESTAURAR
        If gr_cortes.TextMatrix(nRow, C_Campo_Venta) = "X" Then
            gr_cortes.TextMatrix(nRow, C_MONTO_CORTE) = gr_cortes.TextMatrix(nRow, C_Monto_Corte_Org)
            gr_cortes.TextMatrix(nRow, C_Tasa_Recompra) = gr_cortes.TextMatrix(nRow, C_Tasa_Compra_Org)
            gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar) = gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar_Org)
            gr_cortes.TextMatrix(nRow, C_Valor_Recompra) = gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar_Org)
            gr_cortes.TextMatrix(nRow, C_Interes_Pagar) = gr_cortes.TextMatrix(nRow, C_Interes_Dev)
            gr_cortes.TextMatrix(nRow, C_Reajuste_Pagar) = gr_cortes.TextMatrix(nRow, C_Reajuste_Dev)
            gr_cortes.TextMatrix(nRow, C_Bloqueo) = ""
            gr_cortes.TextMatrix(nRow, C_Campo_Venta) = ""
            gr_cortes.TextMatrix(nRow, C_Check_Interes) = ""
            Call Colores_Marca(nRow)
        End If
        gr_cortes.Row = nRow
        gr_cortes.Col = 3
        gr_cortes.SetFocus
    End If
    
    If UCase(Chr(KeyAscii)) = "A" Then
        If gr_cortes.TextMatrix(nRow, C_Campo_Venta) = "" Then
            gr_cortes.TextMatrix(nRow, C_Bloqueo) = "A"
            gr_cortes.TextMatrix(nRow, C_Campo_Venta) = "X"
            gr_cortes.TextMatrix(nRow, C_MONTO_CORTE) = gr_cortes.TextMatrix(nRow, C_Monto_Corte_Org)
            gr_cortes.TextMatrix(nRow, C_Tasa_Recompra) = gr_cortes.TextMatrix(nRow, C_Tasa_Compra_Org)
            gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar) = gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar_Org)
            gr_cortes.TextMatrix(nRow, C_Valor_Recompra) = gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar_Org)
            gr_cortes.TextMatrix(nRow, C_Interes_Pagar) = gr_cortes.TextMatrix(nRow, C_Interes_Dev)
            gr_cortes.TextMatrix(nRow, C_Reajuste_Pagar) = gr_cortes.TextMatrix(nRow, C_Reajuste_Dev)
            Call Colores_Marca(nRow)
            TxtCarteraSel.text = CDbl(TxtCarteraSel.text) + CDbl(gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar))
            gr_cortes.Row = nRow
            gr_cortes.Col = 3
            gr_cortes.SetFocus
        End If
    End If
        
Else
    KeyAscii = 0
End If

TxtCarteraSel.text = CDbl(0)
For nRow = 1 To gr_cortes.Rows - 1
    TxtCarteraSel.text = CDbl(TxtCarteraSel.text) + IIf(gr_cortes.TextMatrix(nRow, C_Campo_Venta) = "X", CDbl(gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar)), 0)
Next nRow

End Sub

Private Sub gr_cortes_LeaveCell()
    If gr_cortes.Row <> 0 And gr_cortes.Col > 1 Then
        If gr_cortes.TextMatrix(gr_cortes.Row, C_Bloqueo) = "A" Then
            gr_cortes.CellBackColor = vbRed    'vbBlack
            gr_cortes.CellForeColor = vbWhite
        Else
            gr_cortes.CellBackColor = &H80000004
            gr_cortes.CellForeColor = &H800000
        End If
    End If
End Sub

Private Sub Gr_Cortes_RowColChange()
    gr_cortes.CellBackColor = &H808000
    gr_cortes.CellForeColor = vbWhite
End Sub

Private Sub IntNumoper_DblClick()
  Call Ayuda_Click
End Sub

Private Sub bloquea_controles()
    Msk_Tasa.Enabled = False
    Cmb_Moneda.Enabled = True
    Txt_Dias.Enabled = False
    Msk_Fecha_Vcto.Enabled = False
    Flt_TasaTran.Enabled = False
    Cmb_Custodia.Enabled = False
    Cmb_Tipo_Deposito.Enabled = False
    CmbCondicion.Enabled = False
    CmbTipo_Emision.Enabled = False
End Sub


Private Sub IntNumoper_KeyPress(KeyAscii As Integer)
  
    If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 And KeyAscii <> 8 Then
        KeyAscii = 0
        Exit Sub
    End If
    
    Select Case KeyAscii
    Case 27
            gr_cortes.SetFocus
    Case 13
        SendKeys "{TAB}"
        If IntNumoper.text <> 0 Then
            MousePointer = 11
            
            If IntNumoper.text = 0 Or IntNumoper.text = "" Then
                MsgBox "Debe ingresar número de operación.", vbExclamation, Me.Caption '''fas
            Else
                If BuscaDatos_Rc(IntNumoper.text) Then
                    IntNumoper.Enabled = False
                    Cmb_Moneda.Enabled = False
                    Msk_Fecha_Vcto.Enabled = False
                    Toolbar1.Buttons(2).Enabled = True
                    Toolbar1.Buttons(3).Enabled = True
                    MousePointer = 0
                Else
                    MousePointer = 0
                    Exit Sub
                End If
            End If
        End If
    End Select
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
    Case "GRABAR"
            If Not verifica_marcas Then
                    MsgBox "No existen cortes marcados para Anular en forma Parcial o Total la Operación.", vbExclamation
                    Exit Sub
            End If
        Call TOOLGRABAR
        Msk_Tasa.Tag = ""
        Cmb_Moneda.Tag = Cmb_Moneda.text
        Txt_Dias.Tag = Txt_Dias.text
        
    Case "LIMPIAR"
        Call TOOLLIMPIAR
    
    Case "SALIR"
        Unload Me

End Select
End Sub

Private Function BuscaDatos_Rc(sNumoper As String) As Integer
Dim iRutCar$, iTipCar$, iForPagI$, sTipCus$, iForpaV$, sTipDep$
Dim sRetiro$, iRutCli$, cCondicion$, iTipEmiDep, TasaTran$
Dim Datos()

Dim DiasCorte As Integer
Dim FechaVctoCorte As Date
Dim MonedaCorte As String
Dim TasaCorte As Double
Dim custodia  As String
Dim Tipo_Deposito As String
Dim Condicion_Captacion As String
Dim nRow As Integer

    gr_cortes.Redraw = False
    
    Call PROC_CREA_GRILLA
    
    BuscaDatos_Rc = 1
    Envia = Array(CDbl(sNumoper), gsBac_User)
    

    If Bac_Sql_Execute("Execute Sp_BuscaRecompra_DAP", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "NO" Then
                MsgBox Datos(2), vbExclamation, gsBac_Version
                IntNumoper.text = 0
                IntNumoper.Enabled = True
                IntNumoper.SetFocus
                BuscaDatos_Rc = 0
                gr_cortes.Redraw = True
                Exit Function
            End If
            TxtFechaIni.text = Format(Datos(2), "DD/MM/YYYY")
            DiasCorte = Datos(24)
            FechaVctoCorte = Datos(4)
            MonedaCorte = Datos(5)
            TasaCorte = Datos(6)
            iRutCar$ = Datos(7)
            iTipCar$ = Datos(8)
            iForPagI$ = Datos(9)
            iForpaV$ = Datos(10)
            sRetiro$ = Datos(11)
            iRutCli$ = Datos(12)
            nCodcli& = Datos(13)
            
            With gr_cortes
                .Rows = .Rows + 1
                nRow = .Rows - 1
                Select Case MonedaCorte
                    Case "CLP": cFormato$ = "###,###,###,###,##0"
                                nDecimales = "###,###,###,###,##0"
                    Case "UF":  cFormato$ = "###,###,###,###,##0.###0"
                                nDecimales = "###,###,###,###,##0"
                                gr_cortes.ColWidth(C_Reajuste_Pagar) = 0 '1300 --jcamposd recalculo
                    Case Else:  cFormato$ = "###,###,###,###,##0.#0"
                                nDecimales = "###,###,###,###,##0.#0"
                End Select
                nDecInteres = cFormato$
            
                .TextMatrix(nRow, C_Correlativo) = Datos(14)
                '+++ recalculo jcamposd debe ser el monto final
                '.TextMatrix(nRow, C_MONTO_CORTE) = Format$(datos(16), cFormato)
                '.TextMatrix(nRow, C_Monto_Corte_Org) = Format$(datos(16), cFormato)
                '.TextMatrix(nRow, C_Valor_A_Pagar) = Format$(datos(27), nDecimales)
                '.TextMatrix(nRow, C_Valor_A_Pagar_Org) = Format$(datos(27), nDecimales)
                '.TextMatrix(nRow, C_Interes_Dev) = Format$(datos(28), nDecInteres)
                
                .TextMatrix(nRow, C_MONTO_CORTE) = Format$(Datos(31), cFormato)
                .TextMatrix(nRow, C_Monto_Corte_Org) = Format$(Datos(31), cFormato)
                .TextMatrix(nRow, C_Valor_A_Pagar) = Format$(Datos(32), cFormato) '--> nDecInteres
                .TextMatrix(nRow, C_Valor_A_Pagar_Org) = Format$(Datos(32), cFormato) '--> nDecInteres
                .TextMatrix(nRow, C_Interes_Dev) = Format$(Datos(33), cFormato) '--> nDecInteres
                .TextMatrix(nRow, C_resultado_Recompra) = Format$(Datos(34), cFormato) '--> nDecInteres
                '--- recalculo jcamposd debe ser el monto final
                .TextMatrix(nRow, C_Tasa_Compra_Org) = Format$(Datos(6), "0.#####0")
                .TextMatrix(nRow, C_Tasa_Recompra) = Format$(Datos(6), "0.#####0")
                .TextMatrix(nRow, C_Valor_Recompra) = Format$(Datos(27), cFormato) '--> nDecInteres
                
                .TextMatrix(nRow, C_Interes_Pagar) = Format$(Datos(28), cFormato) '--> nDecInteres
                
                .TextMatrix(nRow, C_Reajuste_Pagar) = Format$(Datos(29), cFormato) '--> nDecInteres
                .TextMatrix(nRow, C_Reajuste_Dev) = Format$(Datos(29), cFormato) '--> nDecInteres
                
                TasaTran = Datos(17)
                sTipCus$ = Datos(18)
                custodia = Datos(18)
                Tipo_Deposito = Datos(19)
                sTipDep$ = Datos(19)
                cCondicion$ = Datos(20)
                Condicion_Captacion = Datos(20)
                iTipEmiDep = Datos(21)
            
                .TextMatrix(nRow, C_Num_Dcv) = Datos(22)
                .TextMatrix(nRow, C_Plazo) = Datos(24)
                If Datos(25) = "F" Then
                    .TextMatrix(nRow, C_Tipo_Custodia) = "FISICA"
                Else
                    .TextMatrix(nRow, C_Tipo_Custodia) = "DCV"
                End If
                .TextMatrix(nRow, C_Clave_Dcv) = Datos(26)
                Msk_Fecha_Vcto.Tag = Format(Datos(30), "dd/mm/yyyy")
            End With
        Loop
        Txt_Dias.text = DiasCorte
        Cmb_Moneda.text = MonedaCorte
        Msk_Tasa.text = Format(TasaCorte, "##0.#####0")
        Flt_TasaTran.text = Format(TasaTran, "##0.#####0")
        Msk_Fecha_Vcto.text = Format(FechaVctoCorte, "dd/mm/yyyy")

        
        If custodia = "P" Then Cmb_Custodia.ListIndex = 0 Else Cmb_Custodia.ListIndex = 1
        If Tipo_Deposito = "R" Then Cmb_Tipo_Deposito.ListIndex = 0 Else Cmb_Tipo_Deposito.ListIndex = 1
        If Condicion_Captacion = "E" Then CmbCondicion.ListIndex = 0 Else CmbCondicion.ListIndex = 1
        If iTipEmiDep = 1 Then CmbTipo_Emision.ListIndex = 0 Else CmbTipo_Emision.ListIndex = 1
    End If
    Call Formatos
    gr_cortes.Redraw = True
End Function

Private Function verifica_marcas() As Boolean
Dim Cont   As Integer
Dim Fila   As Integer
Cont = 0
marcas = 0

verifica_marcas = False

For Fila = 1 To gr_cortes.Rows - 1
    If gr_cortes.TextMatrix(Fila, C_Campo_Venta) = "X" Then
        verifica_marcas = True
    End If
Next Fila

End Function

Private Function Colores_Marca(nRow As Integer)
    If gr_cortes.TextMatrix(nRow, C_Bloqueo) = "*" Then
        Color = vbGreen + vbWhite
        colorletra = vbWhite
    ElseIf gr_cortes.TextMatrix(nRow, C_Bloqueo) = "A" Then
        Color = vbRed
        colorletra = vbWhite
    Else
        Color = &H80000004
        colorletra = &H800000
    End If
    
    Dim z%
    gr_cortes.Row = nRow
    For z = 3 To gr_cortes.cols - 1
         If gr_cortes.ColWidth(z) <> 0 Then
            gr_cortes.Col = z
            gr_cortes.CellBackColor = Color
            gr_cortes.CellForeColor = colorletra
         End If
    Next z
End Function

Private Function TOOLLIMPIAR()
    Proc_Limpia_Pantalla
    Call bloquea_controles
    IntNumoper.SelLength = Len(IntNumoper.text)
    IntNumoper.SetFocus
End Function

Private Function TOOLGRABAR()
Dim nNumoper   As Double

    nNumoper = CDbl(IntNumoper.text)
    If Anular_operaciones_RIC = True Then
        Call Proc_Limpia_Pantalla
        MsgBox "La operación de Anulación ha sido un éxito.", vbInformation
    End If
    IntNumoper.text = nNumoper
    Call IntNumoper_KeyPress(13)
End Function

Private Function Anular_operaciones_RIC() As Boolean
Dim Sql             As String
Dim tFlag           As Boolean
Dim nRow            As Integer
Dim Datos()

On Error GoTo ErrAnularOperacionesRIC

    Anular_operaciones_RIC = False
    tFlag = False
    
    If miSQL.SQL_Execute("BEGIN TRANSACTION") <> 0 Then
        MsgBox "Problemas en inicio de transacción de Anulación. " & vbCrLf & vbCrLf & "Salga del Sistema y vuelva a ingresar", vbCritical, gsBac_Version
        Exit Function
    End If
    
    tFlag = True
    With gr_cortes
        For nRow = 1 To .Rows - 1
            If .TextMatrix(nRow, C_Campo_Venta) = "X" Then
                Sql = "SP_GRABA_ANULA_RECOMPRA_CAPTACIONES "
                Sql = Sql & IntNumoper.text & ", " & vbCrLf
                Sql = Sql & Replace(CDbl(.TextMatrix(nRow, C_MONTO_CORTE)), ",", ".") & ", " & vbCrLf
                Sql = Sql & Val(.TextMatrix(nRow, C_Correlativo)) & vbCrLf
                
                If miSQL.SQL_Execute(Sql) = 0 Then
                    Do While Bac_SQL_Fetch(Datos())
                        If Datos(1) = "NO" Then
                            MsgBox Datos(3), vbExclamation, gsBac_Version
                            GoTo ErrAnularOperacionesRIC
                        End If
                    Loop
                Else
                    GoTo ErrAnularOperacionesRIC
                End If
            End If
        Next nRow
    End With
    
   '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then
    
        If Not Lineas_Anular("BTR", CDbl(IntNumoper.text)) Then
'           Exit Function
        End If
        
    End If
    '********* Fin
    
    
    If miSQL.SQL_Execute("COMMIT TRANSACTION") <> 0 Then
        GoTo ErrAnularOperacionesRIC
    End If
    
    Anular_operaciones_RIC = True
    Exit Function

ErrAnularOperacionesRIC:
    If tFlag = True Then
        miSQL.SQL_Execute ("ROLLBACK  TRANSACTION")
    End If
    
     MsgBox "Problemas al anular Recompra de Captaciones :" & err.Description, vbCritical, gsBac_Version
    Exit Function
    
End Function
Private Function Fx_Load_Data(ByVal nCategoria As String, ByRef oCombo As ComboBox) As Boolean
    On Error GoTo errLoadData
    Dim SqlString   As String
    Dim SqlDatos()
    
    Let Fx_Load_Data = False
    
    If nCategoria = "CONDICION" Then
        Let SqlString = "SP_LEECONDICION "
    End If
    If nCategoria = "DEPOSITO" Then
        Let SqlString = "SP_TCLEECODIGOS1 10"
    End If
    
    Call oCombo.Clear

    If Not Bac_Sql_Execute(SqlString) Then
        Exit Function
    End If
    Do While Bac_SQL_Fetch(SqlDatos())
        Call oCombo.AddItem(SqlDatos(2))
         Let oCombo.ItemData(oCombo.NewIndex) = SqlDatos(1)
    Loop
    
    Let Fx_Load_Data = True
    
    If oCombo.ListCount > 0 Then
        Let oCombo.ListIndex = 0
    End If
    
    On Error GoTo 0
Exit Function
errLoadData:

    Call MsgBox("Error en la carga de informacion para " & nCategoria & vbCrLf & err.Description, vbExclamation, App.Title)

    On Error GoTo 0
End Function

