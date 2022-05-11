VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_GARANTIAS_OTORGADAS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Garantías Otorgadas "
   ClientHeight    =   9375
   ClientLeft      =   5700
   ClientTop       =   3135
   ClientWidth     =   12900
   ForeColor       =   &H8000000F&
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   9375
   ScaleWidth      =   12900
   Begin TabDlg.SSTab Paleta 
      Height          =   7335
      Left            =   120
      TabIndex        =   14
      Top             =   1920
      Width           =   12735
      _ExtentX        =   22463
      _ExtentY        =   12938
      _Version        =   393216
      Tabs            =   2
      TabsPerRow      =   2
      TabHeight       =   520
      TabCaption(0)   =   "Selección de Cartera"
      TabPicture(0)   =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":0000
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Grilla"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "TxtIngreso"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).ControlCount=   2
      TabCaption(1)   =   "Cartera Otorgada en Garantía"
      TabPicture(1)   =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":001C
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "GridDetalle"
      Tab(1).Control(1)=   "GridResumen"
      Tab(1).ControlCount=   2
      Begin BACControles.TXTNumero TxtIngreso 
         Height          =   195
         Left            =   2160
         TabIndex        =   15
         Top             =   840
         Visible         =   0   'False
         Width           =   915
         _ExtentX        =   1614
         _ExtentY        =   344
         BackColor       =   16744576
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   6645
         Left            =   120
         TabIndex        =   16
         TabStop         =   0   'False
         Top             =   480
         Width           =   12330
         _ExtentX        =   21749
         _ExtentY        =   11721
         _Version        =   393216
         Cols            =   27
         FixedCols       =   2
         BackColor       =   12632256
         ForeColor       =   0
         BackColorFixed  =   8388608
         ForeColorFixed  =   16777215
         BackColorSel    =   16744576
         ForeColorSel    =   16777215
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin MSFlexGridLib.MSFlexGrid GridResumen 
         Height          =   2925
         Left            =   -74880
         TabIndex        =   17
         TabStop         =   0   'False
         Top             =   600
         Width           =   12450
         _ExtentX        =   21960
         _ExtentY        =   5159
         _Version        =   393216
         Cols            =   5
         FixedCols       =   2
         BackColor       =   12632256
         ForeColor       =   0
         BackColorFixed  =   8388608
         ForeColorFixed  =   16777215
         BackColorSel    =   16744576
         ForeColorSel    =   16777215
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         SelectionMode   =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin MSFlexGridLib.MSFlexGrid GridDetalle 
         Height          =   3525
         Left            =   -74880
         TabIndex        =   18
         TabStop         =   0   'False
         Top             =   3600
         Width           =   12450
         _ExtentX        =   21960
         _ExtentY        =   6218
         _Version        =   393216
         Cols            =   5
         FixedCols       =   2
         BackColor       =   12632256
         ForeColor       =   0
         BackColorFixed  =   8388608
         ForeColorFixed  =   16777215
         BackColorSel    =   16744576
         ForeColorSel    =   16777215
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         SelectionMode   =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Frame frmCliente 
      Height          =   1335
      Left            =   0
      TabIndex        =   9
      Top             =   500
      Width           =   12900
      Begin BACControles.TXTNumero txtFactorAditivo 
         Height          =   255
         Left            =   6720
         TabIndex        =   6
         Top             =   840
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   450
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.TextBox txtrut 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   210
         MaxLength       =   9
         MouseIcon       =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":0038
         MousePointer    =   99  'Custom
         MultiLine       =   -1  'True
         TabIndex        =   0
         Top             =   480
         Width           =   1395
      End
      Begin VB.TextBox txtDigito 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   1710
         MaxLength       =   1
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   480
         Width           =   255
      End
      Begin VB.TextBox TxtCodigo 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   2040
         MaxLength       =   5
         TabIndex        =   2
         Text            =   "1"
         Top             =   480
         Width           =   645
      End
      Begin BACControles.TXTNumero txt_totalGarantizado 
         Height          =   285
         Left            =   8640
         TabIndex        =   7
         Top             =   840
         Width           =   2295
         _ExtentX        =   4048
         _ExtentY        =   503
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
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.ComboBox Cmb_TipoDerivado 
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
         Left            =   4320
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   480
         Width           =   2295
      End
      Begin BACControles.TXTFecha txt_fechaRevision 
         Height          =   285
         Left            =   2880
         TabIndex        =   3
         Top             =   480
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   503
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
         Text            =   "15/06/2010"
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Factor Aditivo"
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
         Left            =   6720
         TabIndex        =   19
         Top             =   600
         Width           =   1200
      End
      Begin VB.Label Label2 
         Caption         =   "Rut Cliente  / Código Cliente"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   210
         TabIndex        =   13
         Top             =   240
         Width           =   2415
      End
      Begin VB.Label Label 
         Alignment       =   1  'Right Justify
         Caption         =   "Monto Garantizado"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   3
         Left            =   8640
         TabIndex        =   12
         Top             =   600
         Width           =   1695
      End
      Begin VB.Label lbl_Cliente 
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         Height          =   285
         Left            =   240
         TabIndex        =   5
         Top             =   840
         Width           =   6375
      End
      Begin VB.Label Label 
         Caption         =   "Tipo Garantía"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   2
         Left            =   4320
         TabIndex        =   11
         Top             =   240
         Width           =   1215
      End
      Begin VB.Label Label 
         Caption         =   "Fecha Revisión"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   1
         Left            =   2880
         TabIndex        =   10
         Top             =   240
         Width           =   1335
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   12120
      Top             =   600
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      UseMaskColor    =   0   'False
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   13
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":0342
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":0794
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":166E
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":1988
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":1CA2
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":20F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":240E
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":2860
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":2B7A
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":2E94
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":31AE
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":3600
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":391A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   12900
      _ExtentX        =   22754
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList2"
      DisabledImageList=   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   11
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Operación"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdFiltrar"
            Description     =   "Filtrar"
            Object.ToolTipText     =   "Filtrar Papeles"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdVender"
            Description     =   "Vender"
            Object.ToolTipText     =   "Garantizar Papel"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdRestaurar"
            Description     =   "Restaurar"
            Object.ToolTipText     =   "Restaurar Papel"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir de la Ventana"
            ImageIndex      =   13
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   0
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   13
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":3C34
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":4B0E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":59E8
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":71DA
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":8C60
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":A4E2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":BF68
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":CE42
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":DD1C
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":EBF6
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":FAD0
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":109AA
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS_OTORGADAS.frx":10CC4
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_MNT_GARANTIAS_OTORGADAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public iAceptar               As Boolean
Public CarterasFinancieras    As String
Public CarterasNormativas     As String
Public MihWnd                 As Long
Public nMaximoIngreso         As Double

Private Enum bEstado
   [Normal] = 0
   [Tomado] = 1
   [VtaTotal] = 2
   [VtaParcial] = 3
End Enum

Const FDec4Dec = "#,##0.0000"
Const FDec2Dec = "#,##0.00"
Const FDec0Dec = "#,##0"


' Constantes para la grilla de seleccion de Papeles
' --------------------------------------------------------
Const Col_Marca = 0
Const COL_Serie = 1
Const Col_Moneda = 2
Const Col_Nominal = 3
Const Col_Tir = 4
Const Col_VPar = 5
Const Col_MT = 6
Const Col_Factor = 7
Const Col_MTG = 8
Const Col_Nominal_ORIG = 9
Const Col_Tir_ORIG = 10
Const Col_VPar_ORIG = 11
Const Col_MT_ORIG = 12
Const Col_NumDocu = 13
Const Col_Correlativo = 14
Const Col_FecVen = 15
' --------------------------------------------------------


' Constantes para la grilla de seleccion de Otorgadas
' --------------------------------------------------------
Const Col_Oto_Sel = 0
Const COL_Oto_Fecha = 1
Const Col_Oto_Folio = 2
Const Col_Oto_Tipo = 3
Const Col_Oto_Presente = 4
Const Col_Oto_Monto = 5
Const Col_Oto_FactorA = 6

' -----------------------------------------------------------

' Constantes para la grilla de seleccion detalle de Otorgadas
' -----------------------------------------------------------
Const Col_det_numdocu = 0
Const COL_det_corre = 1
Const Col_det_nemo = 2
Const Col_det_Nominal = 3
Const Col_det_Tir = 4
Const Col_det_vpar = 5
Const Col_det_Valor = 6
Const Col_det_Factor = 7
Const Col_det_ValorAct = 8
' -----------------------------------------------------------


' --------------------------------------------------------






'
Dim nModoCalculo     As Integer
Dim cMascara         As String
Dim nNominal         As Double
Dim nTir             As Double
Dim nPvp             As Double
Dim nMonto           As Double
Dim cFecCal          As String
Dim nFactor          As Double
Dim nValorInicial    As Double
Dim cUsuario         As String
Dim nVentana         As Double
Dim nMontoAnterior   As Double
Dim factorAditi   As Double
Dim factorMulti   As Double

Dim cSql             As String
Private objCliente As Object

Private Function ChangeColorSetting(ByVal Fila As Long, Estado As bEstado)
Dim nContador     As Long
Dim bColorCaja    As Variant
Dim bColorFont    As Variant
Dim nColumna      As Long

    If Estado = Normal Then Let bColorCaja = vbBlack:                   Let bColorFont = vbBlack
    If Estado = Tomado Then Let bColorCaja = vbGreen + vbWhite: Let bColorFont = vbWhite
    If Estado = VtaTotal Then Let bColorCaja = vbBlue:            Let bColorFont = vbWhite
    If Estado = VtaParcial Then Let bColorCaja = vbCyan:            Let bColorFont = vbBlack
    
    Let nColumna = grilla.ColSel
    Let grilla.Row = grilla.RowSel
    Let grilla.Redraw = False
    
    For nContador = 3 To grilla.Cols - 1
    
        Let grilla.Col = nContador
        Let grilla.CellBackColor = bColorCaja
        Let grilla.CellForeColor = bColorFont
        
    Next nContador
    
    Let grilla.Col = nColumna
    
    Let grilla.Redraw = True
End Function

Private Sub subSettingGridVisible(ByRef xGrilla As MSFlexGrid)


   Let xGrilla.WordWrap = True

   Let xGrilla.Rows = 2:      Let xGrilla.Cols = 16
   Let xGrilla.Row = 1:       Let xGrilla.Col = 1
   Let xGrilla.FixedRows = 1: Let xGrilla.FixedCols = 3

   Let xGrilla.RowHeight(0) = 500
   Let xGrilla.TextMatrix(0, Col_Marca) = "M":                              Let xGrilla.ColWidth(Col_Marca) = 500:          Let xGrilla.TextMatrix(1, Col_Marca) = ""
   Let xGrilla.TextMatrix(0, COL_Serie) = "Serie":                          Let xGrilla.ColWidth(COL_Serie) = 1300:         Let xGrilla.TextMatrix(1, COL_Serie) = ""
   Let xGrilla.TextMatrix(0, Col_Moneda) = "UM":                            Let xGrilla.ColWidth(Col_Moneda) = 500:         Let xGrilla.TextMatrix(1, Col_Moneda) = ""
   Let xGrilla.TextMatrix(0, Col_Nominal) = "Nominal":                      Let xGrilla.ColWidth(Col_Nominal) = 2000:       Let xGrilla.TextMatrix(1, Col_Nominal) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_Tir) = "Tasa Referencial":                 Let xGrilla.ColWidth(Col_Tir) = 1000:           Let xGrilla.TextMatrix(1, Col_Tir) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_VPar) = "%Vpar":                           Let xGrilla.ColWidth(Col_VPar) = 900:           Let xGrilla.TextMatrix(1, Col_VPar) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_MT) = "Valor Referencial":                 Let xGrilla.ColWidth(Col_MT) = 2300:            Let xGrilla.TextMatrix(1, Col_MT) = Format(0#, FDec0Dec)
   
   Let xGrilla.TextMatrix(0, Col_Factor) = "Factor Mult.":                  Let xGrilla.ColWidth(Col_Factor) = 1000:        Let xGrilla.TextMatrix(1, Col_Factor) = Format(0#, FDec0Dec)
   Let xGrilla.TextMatrix(0, Col_MTG) = "Valor a Otorgar":                  Let xGrilla.ColWidth(Col_MTG) = 2300:           Let xGrilla.TextMatrix(1, Col_MTG) = Format(0#, FDec0Dec)

   Let xGrilla.TextMatrix(0, Col_Nominal_ORIG) = "Nom. Original":           Let xGrilla.ColWidth(Col_Nominal_ORIG) = 0:     Let xGrilla.TextMatrix(1, Col_Nominal_ORIG) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_Tir_ORIG) = "Tasa Original":               Let xGrilla.ColWidth(Col_Tir_ORIG) = 0:         Let xGrilla.TextMatrix(1, Col_Tir_ORIG) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_VPar_ORIG) = "vPar Original":              Let xGrilla.ColWidth(Col_VPar_ORIG) = 0:        Let xGrilla.TextMatrix(1, Col_VPar_ORIG) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_MT_ORIG) = "Valor Ref. Original":          Let xGrilla.ColWidth(Col_MT_ORIG) = 0:          Let xGrilla.TextMatrix(1, Col_MT_ORIG) = Format(0#, FDec4Dec)
   
   Let xGrilla.TextMatrix(0, Col_NumDocu) = "Numdocu":                      Let xGrilla.ColWidth(Col_NumDocu) = 0:          Let xGrilla.TextMatrix(1, Col_NumDocu) = Format(0#, FDec0Dec)
   Let xGrilla.TextMatrix(0, Col_Correlativo) = "Correlativo":              Let xGrilla.ColWidth(Col_Correlativo) = 0:      Let xGrilla.TextMatrix(1, Col_Correlativo) = Format(0#, FDec0Dec)
   Let xGrilla.ColWidth(Col_FecVen) = 0
End Sub


Private Sub subSettingGridOtorgadas(ByRef xGrilla As MSFlexGrid)

    Let xGrilla.WordWrap = True
    
    Let xGrilla.Rows = 2:      Let xGrilla.Cols = 7
    Let xGrilla.Row = 1:       Let xGrilla.Col = 1
    Let xGrilla.FixedRows = 1: Let xGrilla.FixedCols = 0
    
    Let xGrilla.RowHeight(0) = 500
    Let xGrilla.TextMatrix(0, Col_Oto_Sel) = "S":                        Let xGrilla.ColWidth(Col_Oto_Sel) = 500:            Let xGrilla.TextMatrix(1, Col_Oto_Sel) = ""
    Let xGrilla.TextMatrix(0, COL_Oto_Fecha) = "Fecha":                  Let xGrilla.ColWidth(COL_Oto_Fecha) = 1500:         Let xGrilla.TextMatrix(1, COL_Oto_Fecha) = ""
    Let xGrilla.TextMatrix(0, Col_Oto_Folio) = "N°Folio":                Let xGrilla.ColWidth(Col_Oto_Folio) = 1500:         Let xGrilla.TextMatrix(1, Col_Oto_Folio) = ""
    Let xGrilla.TextMatrix(0, Col_Oto_Tipo) = "Tipo Garantía":           Let xGrilla.ColWidth(Col_Oto_Tipo) = 3500:          Let xGrilla.TextMatrix(1, Col_Oto_Tipo) = ""
    Let xGrilla.TextMatrix(0, Col_Oto_Presente) = "Garantia Original":   Let xGrilla.ColWidth(Col_Oto_Presente) = 2500:      Let xGrilla.TextMatrix(1, Col_Oto_Presente) = Format(0#, FDec0Dec)
    Let xGrilla.TextMatrix(0, Col_Oto_Monto) = "Monto Actualizado":      Let xGrilla.ColWidth(Col_Oto_Monto) = 2500:         Let xGrilla.TextMatrix(1, Col_Oto_Monto) = Format(0#, FDec0Dec)
    Let xGrilla.TextMatrix(0, Col_Oto_FactorA) = "Factor Aditivo":      Let xGrilla.ColWidth(Col_Oto_FactorA) = 2500:         Let xGrilla.TextMatrix(1, Col_Oto_FactorA) = Format(0#, FDec0Dec)

End Sub


Private Sub subSettingGridOtorgadasDetalle(ByRef xGrilla As MSFlexGrid)

    Let xGrilla.WordWrap = True
    
    Let xGrilla.Rows = 2:      Let xGrilla.Cols = 9
    'Let xGrilla.Row = 1:       Let xGrilla.Col = 1
    xGrilla.RowSel = 1
    Let xGrilla.FixedRows = 1: Let xGrilla.FixedCols = 0
    
    Let xGrilla.RowHeight(0) = 500
    Let xGrilla.TextMatrix(0, Col_det_numdocu) = "Numdocu":         Let xGrilla.ColWidth(Col_det_numdocu) = 1500:            Let xGrilla.TextMatrix(1, Col_det_numdocu) = Format(0#, FDec0Dec)
    Let xGrilla.TextMatrix(0, COL_det_corre) = "Correlativo":       Let xGrilla.ColWidth(COL_det_corre) = 1000:             Let xGrilla.TextMatrix(1, COL_det_corre) = Format(0#, FDec0Dec)
    Let xGrilla.TextMatrix(0, Col_det_nemo) = "Nemotecnico":        Let xGrilla.ColWidth(Col_det_nemo) = 1500:              Let xGrilla.TextMatrix(1, Col_det_nemo) = ""
    Let xGrilla.TextMatrix(0, Col_det_Nominal) = "Nominal":         Let xGrilla.ColWidth(Col_det_Nominal) = 2500:           Let xGrilla.TextMatrix(1, Col_det_Nominal) = Format(0#, FDec4Dec)
    Let xGrilla.TextMatrix(0, Col_det_Tir) = "TIR":                 Let xGrilla.ColWidth(Col_det_Tir) = 1500:               Let xGrilla.TextMatrix(1, Col_det_Tir) = Format(0#, FDec4Dec)
    Let xGrilla.TextMatrix(0, Col_det_vpar) = "VPAR":               Let xGrilla.ColWidth(Col_det_vpar) = 1500:              Let xGrilla.TextMatrix(1, Col_det_vpar) = Format(0#, FDec4Dec)
    Let xGrilla.TextMatrix(0, Col_det_Valor) = "Valor Mercado":     Let xGrilla.ColWidth(Col_det_Valor) = 2500:             Let xGrilla.TextMatrix(1, Col_det_Valor) = Format(0#, FDec4Dec)
    Let xGrilla.TextMatrix(0, Col_det_Factor) = "Factor Mult.":     Let xGrilla.ColWidth(Col_det_Factor) = 1500:             Let xGrilla.TextMatrix(1, Col_det_Factor) = Format(0#, FDec4Dec)
    Let xGrilla.TextMatrix(0, Col_det_ValorAct) = "Valor Merc. Act.":  Let xGrilla.ColWidth(Col_det_ValorAct) = 2500:             Let xGrilla.TextMatrix(1, Col_det_ValorAct) = Format(0#, FDec4Dec)
    
End Sub

Private Function subCargaDatosFiltro() As Boolean
Dim vienen As Long

    subCargaDatosFiltro = False
    
    vienen = 0
    Envia = Array()
    AddParam Envia, gsBAC_User
    AddParam Envia, CarterasFinancieras
    AddParam Envia, CarterasNormativas
    AddParam Envia, MihWnd

    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_FILTRO_CARTERA_PARA_OTORGAR", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
        Exit Function
    End If
    
    Let grilla.Rows = 1
    
    Do While Bac_SQL_Fetch(Datos())
        vienen = vienen + 1
        Let grilla.Rows = grilla.Rows + 1
        Let grilla.TextMatrix(grilla.Rows - 1, Col_Marca) = ""
        Let grilla.TextMatrix(grilla.Rows - 1, COL_Serie) = Datos(1)
        Let grilla.TextMatrix(grilla.Rows - 1, Col_Moneda) = Datos(2)
        Let grilla.TextMatrix(grilla.Rows - 1, Col_Nominal) = Format(Datos(3), FDec4Dec)
        Let grilla.TextMatrix(grilla.Rows - 1, Col_Tir) = Format(Datos(4), FDec4Dec)
        Let grilla.TextMatrix(grilla.Rows - 1, Col_VPar) = Format(Datos(5), FDec4Dec)
        Let grilla.TextMatrix(grilla.Rows - 1, Col_MT) = Format(Datos(6), FDec0Dec)
        Let grilla.TextMatrix(grilla.Rows - 1, Col_Factor) = Format(Datos(7), FDec4Dec)
        Let grilla.TextMatrix(grilla.Rows - 1, Col_MTG) = Format(Datos(8), FDec0Dec)
        Let grilla.TextMatrix(grilla.Rows - 1, Col_Nominal_ORIG) = Format(Datos(9), FDec4Dec)
        Let grilla.TextMatrix(grilla.Rows - 1, Col_Tir_ORIG) = Format(Datos(10), FDec4Dec)
        Let grilla.TextMatrix(grilla.Rows - 1, Col_VPar_ORIG) = Format(Datos(11), FDec4Dec)
        Let grilla.TextMatrix(grilla.Rows - 1, Col_MT_ORIG) = Format(Datos(12), FDec4Dec)
        Let grilla.TextMatrix(grilla.Rows - 1, Col_NumDocu) = Format(Datos(13), FDec0Dec)
        Let grilla.TextMatrix(grilla.Rows - 1, Col_Correlativo) = Datos(14)
        Let grilla.TextMatrix(grilla.Rows - 1, Col_FecVen) = Datos(15)
        
'        Call ChangeColorSetting(Grilla.Rows - 1, Normal)
    Loop
    
    If vienen = 0 Then
        MsgBox "No se encontraron Instrumentos para el filtro seleccionado!", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    subCargaDatosFiltro = True
    
End Function
Private Function CargaTransaccionesOtorgadas(ByVal modo As Boolean) As Long
    Dim I As Long
    I = 0
    Envia = Array()
    AddParam Envia, Me.txtRut.Text
    AddParam Envia, Me.TxtCodigo.Text

    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_BUSCAR_OPERACIONES_OTORGADAS", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
        CargaTransaccionesOtorgadas = 0
        I = 0
        Exit Function
    End If
    
    Let GridResumen.Rows = 1
    
    Do While Bac_SQL_Fetch(Datos())
        If modo Then
            Let GridResumen.Rows = GridResumen.Rows + 1
            Let GridResumen.TextMatrix(GridResumen.Rows - 1, Col_Oto_Sel) = ""
            Let GridResumen.TextMatrix(GridResumen.Rows - 1, COL_Oto_Fecha) = Datos(1)
            Let GridResumen.TextMatrix(GridResumen.Rows - 1, Col_Oto_Folio) = Datos(2)
            Let GridResumen.TextMatrix(GridResumen.Rows - 1, Col_Oto_Tipo) = Datos(3)
            Let GridResumen.TextMatrix(GridResumen.Rows - 1, Col_Oto_Presente) = Format(Datos(4), FDec0Dec)
            Let GridResumen.TextMatrix(GridResumen.Rows - 1, Col_Oto_Monto) = Format(Datos(5), FDec0Dec)
            Let GridResumen.TextMatrix(GridResumen.Rows - 1, Col_Oto_FactorA) = Format(Datos(6), FDec0Dec)
        End If
        I = I + 1
    Loop
    CargaTransaccionesOtorgadas = I
End Function
Private Sub subCargaTransaccionesOtorgadasDetalle(iFolio As Long)

    Envia = Array()
    AddParam Envia, iFolio
    

    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_BUSCAR_OPERACIONES_OTORGADAS_DETALLE", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
        Exit Sub
    End If
    
    Let GridDetalle.Rows = 1
    
    Do While Bac_SQL_Fetch(Datos())
        Let GridDetalle.Rows = GridDetalle.Rows + 1
        Let GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_numdocu) = Datos(1)
        Let GridDetalle.TextMatrix(GridDetalle.Rows - 1, COL_det_corre) = Datos(2)
        Let GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_nemo) = Datos(3)
        Let GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_Nominal) = Format(Datos(4), FDec4Dec)
        Let GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_Tir) = Format(Datos(5), FDec4Dec)
        Let GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_vpar) = Format(Datos(6), FDec4Dec)
        Let GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_Valor) = Format(Datos(7), FDec0Dec)

        GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_Factor) = Format(Datos(8), FDec4Dec)
        GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_ValorAct) = Format(Datos(9), FDec0Dec)
       
    Loop
   
End Sub
Sub subGrabarGarantiasOtorgadas()
Dim nNumfolio   As Long
Dim nContador   As Long
Dim Datos()

On Error GoTo ErrGralGrabacion

    If Not funcValidaPapelesaGrabar() Then
        Exit Sub
    End If

    If MsgBox("¿Está seguro de registrar la garantía con los documentos seleccionados " & vbCrLf & vbCrLf & " Con vencimiento para el : " & Format(Me.txt_fechaRevision.Text, "dd/mm/yyyy") & "?", vbQuestion + vbYesNo + vbDefaultButton2, TITSISTEMA) = vbNo Then
        Exit Sub
        End If
    
    On Error GoTo 0
    
    Call BacBeginTransaction
    
    On Error GoTo ErrTransaction
    
    
    If Not Bac_Sql_Execute("dbo.SP_GAR_NUMFOLIO_GARANTIAS_OTORGADAS") Then
       Let Screen.MousePointer = vbDefault
       GoTo ErrTransaction
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        
        Let nNumfolio = Datos(1)
        
    End If
    
    
    Envia = Array()
    
    AddParam Envia, nNumfolio
    AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
    AddParam Envia, Str(Me.txtRut.Text)
    AddParam Envia, Str(Me.TxtCodigo.Text)
    AddParam Envia, Me.Cmb_TipoDerivado.ItemData(Me.Cmb_TipoDerivado.ListIndex)
    AddParam Envia, Format(txt_fechaRevision.Text, "yyyymmdd")
    AddParam Envia, CDbl(txtFactorAditivo.Text)
    
    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_GRABA_ENCABEZADO_GARANTIAS_OTORGADAS", Envia) Then
       Let Screen.MousePointer = vbDefault
       GoTo ErrTransaction
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) <> 0 Then
            GoTo ErrTransaction
        End If
    End If
    
    
    For nContador = 1 To grilla.Rows - 1
    
        If grilla.TextMatrix(nContador, Col_Marca) = "P" Or grilla.TextMatrix(nContador, Col_Marca) = "G" Then
            Envia = Array()
            
            AddParam Envia, nNumfolio
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_NumDocu))
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_Correlativo))
            AddParam Envia, grilla.TextMatrix(nContador, COL_Serie)
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_Nominal))
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_Tir))
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_VPar))
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_MT))
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_Factor))
            
            If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_GRABA_DETALLE_GARANTIAS_OTORGADAS", Envia) Then
               Let Screen.MousePointer = vbDefault
               GoTo ErrTransaction
            End If
            
            If Bac_SQL_Fetch(Datos()) Then
                If Datos(1) <> 0 Then
                    GoTo ErrTransaction
                End If
            End If
        
        End If
        
    Next nContador

    Call BacCommitTransaction
    On Error GoTo 0
    
    MsgBox "Se han registrado satisfactoriamente los instrumentos seleccionados como garantías otorgadas con el número: " & nNumfolio, vbInformation, TITSISTEMA
    
   
    Call Limpiar
    Exit Sub
ErrGralGrabacion:
    MsgBox "Se han presentado problemas en el proceso de grabación:" & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
    Exit Sub


ErrTransaction:
    MsgBox "Se ha producido un error en el proceso de grabacion, favor verifque informacion:" & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
    Call BacRollBackTransaction
    Exit Sub
    
End Sub





Private Sub Cmb_TipoDerivado_KeyPress(KeyAscii As Integer)

    If KeyAscii = vbKeyReturn Then
        Me.txtFactorAditivo.SetFocus
    End If

End Sub

Private Sub Form_Load()

    Let Screen.MousePointer = vbHourglass
    Let Me.Top = 0
    Let Me.Left = 0
    Set objCliente = New clsCliente
    
    Let Me.Caption = "Mantenedor de Garantías Otorgadas"
    Let MihWnd = CDbl(Me.hWnd)
    
    txtFactorAditivo.Text = factorAditi
    Paleta.TabVisible(1) = False
    txt_fechaRevision.Text = gsBAC_Fecpx
    Call subSettingGridVisible(grilla)
    Call LOAD_TiposGarantias(Cmb_TipoDerivado, "O")
    Let Screen.MousePointer = vbDefault
   
    Call BloqueaBotones(True, "3,5,6,8")
    
    grilla.Enabled = False
    
End Sub

Private Sub Form_Resize()
On Error GoTo BacErrHnd

Dim lScaleWidth&, lScaleHeight&, lPosIni&

    ' Cuando la ventana es minimizada, se ignora la rutina.-
    If Me.WindowState = 1 Then
        ' Pinta borde del icono.-
        Dim x!, Y!, j%

        x = Me.Width
        Y = Me.Height
        For j% = 1 To 15
            Line (0, 0)-(x, 0), QBColor(Int(Rnd * 15))
            Line (x, 0)-(x, Y), QBColor(Int(Rnd * 15))
            Line (x, Y)-(0, Y), QBColor(Int(Rnd * 15))
            Line (0, Y)-(0, 0), QBColor(Int(Rnd * 15))
            DoEvents
        Next
        Exit Sub

    End If

  ' Escalas de medida de la ventana.-
    lScaleWidth& = Me.ScaleWidth
    lScaleHeight& = Me.ScaleHeight

  ' Resize la ventana customizado.-
    If Me.WindowState <> 1 And Me.Width > 400 And Me.Height > 2100 Then
        grilla.Width = Me.Width - 300
        grilla.Height = Me.Height - 3000
    End If

      Exit Sub

BacErrHnd:

    On Error GoTo 0
    Resume Next

End Sub


Private Sub Form_Unload(Cancel As Integer)

    Call funcDesMarcarTodosInstrumento
    Set objCliente = Nothing
   
End Sub

Private Sub funcDesMarcarTodosInstrumento()

    Envia = Array()
    AddParam Envia, CInt(4)
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, CDbl(Me.hWnd)
    AddParam Envia, gsBAC_User
    
    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_CONTROL_BLOQUEO_GARANTIAS_OTORGADAS", Envia) Then
        Let Me.MousePointer = vbDefault
        Call MsgBox("Se ha producido un error al tratar de desmarcar el registro.", vbExclamation, App.Title)
        Exit Sub
    End If
   
End Sub







Private Sub GridResumen_Click()

    If Val(GridResumen.TextMatrix(GridResumen.RowSel, Col_Oto_Folio)) <> 0 Then
        Call subCargaTransaccionesOtorgadasDetalle(GridResumen.TextMatrix(GridResumen.RowSel, Col_Oto_Folio))
    End If
    
End Sub


Private Sub GridResumen_RowColChange()

    Call GridResumen_Click

End Sub

Private Sub Paleta_Click(PreviousTab As Integer)

    If Paleta.Tab = 0 Then
        Call BloqueaBotones(False, "3,5,6,8")
    End If

    If Paleta.Tab = 1 Then
         Call BloqueaBotones(True, "3,5,6,8")
         Call subSettingGridOtorgadas(Me.GridResumen)
         Call CargaTransaccionesOtorgadas(True)
         Call subSettingGridOtorgadasDetalle(Me.GridDetalle)
            
    End If
    
    
End Sub


Private Sub txtFactorAditivo_KeyPress(KeyAscii As Integer)

    If KeyAscii = vbKeyReturn Then
        If Trim(txtRut.Text) = "" Then
            MsgBox "No ha ingresado el Rut del Cliente!", vbExclamation, TITSISTEMA
            txtRut.SetFocus
            Exit Sub
        End If
        If (TxtCodigo.Text) = "" Then
            MsgBox "No ha ingresado el Código del Cliente!", vbExclamation, TITSISTEMA
            TxtCodigo.SetFocus
            Exit Sub
        End If
        Me.grilla.SetFocus
    End If

End Sub

Private Sub TxtIngreso_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim cFormato         As Variant
    Dim vMult As Double
    If KeyCode = vbKeyEscape Then
        Let grilla.Enabled = True
        Let Toolbar1.Enabled = True
        Let TxtIngreso.Visible = False
        Call grilla.SetFocus
    End If
    
    If KeyCode = vbKeyReturn Then
    
        If grilla.TextMatrix(grilla.RowSel, Col_Marca) = "*" Then
            Exit Sub
        End If
    
        If TxtIngreso.Text = 0 Then
            Call MsgBox("El valor ingresado no es válido...", vbExclamation, App.Title)
            Call TxtIngreso.SetFocus
            Exit Sub
        End If
        
        
        Let cFormato = IIf(TxtIngreso.CantidadDecimales = 0, FDec0Dec, FDec4Dec)
        
        If grilla.ColSel = Col_MT Then
            Let nMontoAnterior = CDbl(grilla.TextMatrix(grilla.RowSel, Col_MT))
        End If
        
        If grilla.ColSel = Col_Nominal Then
            If CDbl(grilla.TextMatrix(grilla.RowSel, Col_Nominal_ORIG)) < CDbl(TxtIngreso.Text) Then
                Call MsgBox("Nominal disponible es menor al ingresado.", vbExclamation, App.Title)
                Let TxtIngreso.Text = CDbl(grilla.TextMatrix(grilla.RowSel, Col_Nominal_ORIG))
                Call TxtIngreso.SetFocus
                Exit Sub
            End If
        End If
        
        If grilla.ColSel = Col_Factor Then
            If CDbl(grilla.TextMatrix(grilla.RowSel, Col_Factor)) <= 0 Then
                MsgBox "El valor del Factor Multiplicativo debe ser positivo!", vbExclamation, TITSISTEMA
                Call TxtIngreso.SetFocus
                Exit Sub
            Else
                vMult = CDbl(grilla.TextMatrix(grilla.RowSel, Col_MT)) * CDbl(grilla.TextMatrix(grilla.RowSel, Col_Factor))
                vMult = Round(vMult, 0)
                grilla.TextMatrix(grilla.RowSel, Col_MTG) = Format(vMult, FDec0Dec)
            End If
        End If
        
        Let grilla.Enabled = True
        Let Toolbar1.Enabled = True
        Let grilla.TextMatrix(grilla.RowSel, grilla.ColSel) = Format(TxtIngreso.Text, cFormato)
        
        Let TxtIngreso.Visible = False
        Call grilla.SetFocus
                
        If funcMarcarInstrumento() Then
            Call subValorizacionInstrumento(vbKeyReturn)
        End If
    
    End If
End Sub

Private Sub Limpiar()
    Call BloquearCliente(False)
    If grilla.Enabled = False Then
        grilla.Enabled = True
    End If
    grilla.Clear
    'Grilla.Rows = 1
    Call subSettingGridVisible(grilla)
    Paleta.TabVisible(1) = False
    Cmb_TipoDerivado.ListIndex = -1
    txtRut.Text = ""
    txtDigito.Text = ""
    TxtCodigo.Text = ""
    txt_fechaRevision.Text = gsBAC_Fecpx
    grilla.Enabled = False
    lbl_Cliente.Caption = ""
    txt_totalGarantizado.Text = 0
    txtFactorAditivo.Text = 0
    Paleta.TabVisible(0) = True
    Paleta.TabVisible(1) = False
    Call BloqueaBotones(True, "3,5,6,8")
    frmCliente.Enabled = True
End Sub
Private Function funcDesMarcarInstrumento() As Boolean
   Dim Datos()
   
   Let funcDesMarcarInstrumento = True
   
   If grilla.TextMatrix(grilla.RowSel, Col_Marca) = "G" Or grilla.TextMatrix(grilla.RowSel, Col_Marca) = "P" Then
        
        Envia = Array()
        AddParam Envia, CInt(3)
        AddParam Envia, Str(grilla.TextMatrix(grilla.RowSel, Col_NumDocu))
        AddParam Envia, Str(grilla.TextMatrix(grilla.RowSel, Col_Correlativo))
        AddParam Envia, CDbl(Me.hWnd)
        AddParam Envia, gsBAC_User
        
        If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_CONTROL_BLOQUEO_GARANTIAS_OTORGADAS", Envia) Then
            Let Me.MousePointer = vbDefault
            Call MsgBox("Se ha producido un error al tratar de desmarcar el registro.", vbExclamation, App.Title)
            Let funcDesMarcarInstrumento = False
            Exit Function
        End If

        If Bac_SQL_Fetch(Datos()) Then
            Let grilla.TextMatrix(grilla.RowSel, Col_Marca) = ""
            Call ChangeColorSetting(grilla.RowSel, Normal)
        End If
        'Dejar en Grilla.TextMatrix(Grilla.Rowsel, Col_Nominal) = Grilla.TextMatrix(Grilla.Rowsel, Col_Nominal_ORIG)
        grilla.TextMatrix(grilla.RowSel, Col_Nominal) = grilla.TextMatrix(grilla.RowSel, Col_Nominal_ORIG)
    Else
        If grilla.TextMatrix(grilla.RowSel, Col_Marca) <> "" Then
            Call MsgBox("El registro no se puede desbloquear... por que lo tiene tomado otro usuario.", vbExclamation, App.Title)
            Call grilla.SetFocus
            Let funcDesMarcarInstrumento = False
        End If
   End If
   Call subActualizaMontoGarantia
End Function

Private Function funcMarcarInstrumento() As Boolean
Dim Datos()
Dim nMarca     As String
Dim nMoninal   As Double

   
    Let funcMarcarInstrumento = True
   
   
    If grilla.TextMatrix(grilla.RowSel, Col_Marca) = "*" Then
    
        Let Me.MousePointer = vbDefault
        Call MsgBox("Documento se encuentra tomado por otro usuario.", vbExclamation, App.Title)
        
        Call grilla.SetFocus
        Let funcMarcarInstrumento = False
        
        Exit Function
        
    End If
    If Trim(grilla.TextMatrix(grilla.RowSel, Col_NumDocu)) = "" Then
        Exit Function
    End If
    If Trim(grilla.TextMatrix(grilla.RowSel, Col_NumDocu)) = "0" Then
        Exit Function
    End If
    Envia = Array()
    AddParam Envia, CInt(1)
    AddParam Envia, Str(grilla.TextMatrix(grilla.RowSel, Col_NumDocu))
    AddParam Envia, Str(grilla.TextMatrix(grilla.RowSel, Col_Correlativo))
    AddParam Envia, CDbl(Me.hWnd)
    AddParam Envia, gsBAC_User
   
    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_CONTROL_BLOQUEO_GARANTIAS_OTORGADAS", Envia) Then
        Let Me.MousePointer = vbDefault
        Call MsgBox("Se ha producido un error al tratar de tomar el registro.", vbExclamation, App.Title)
        Let funcMarcarInstrumento = False
        Exit Function
    End If
   
    If Bac_SQL_Fetch(Datos()) Then
    
        If Datos(1) < 0 Then
            Call MsgBox(Datos(2), vbExclamation, App.Title)
            Let grilla.TextMatrix(grilla.RowSel, Col_Marca) = "*"
            Call ChangeColorSetting(grilla.RowSel, Tomado)
            Let funcMarcarInstrumento = False
        Else
            Call subColorea_Registro
        End If
        
    End If
    
  ' Call subCalculaMontosIngresados
   
End Function

Private Sub subColorea_Registro()

    If CDbl(grilla.TextMatrix(grilla.RowSel, Col_Nominal_ORIG)) <> CDbl(grilla.TextMatrix(grilla.RowSel, Col_Nominal)) Then
        Let grilla.TextMatrix(grilla.RowSel, Col_Marca) = "P"
        Call ChangeColorSetting(grilla.RowSel, VtaParcial)
    Else
        Let grilla.TextMatrix(grilla.RowSel, Col_Marca) = "G"
        Call ChangeColorSetting(grilla.RowSel, VtaTotal)
    End If
    
End Sub
Private Sub txtRut_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
        If Trim(txtRut.Text) = "" Then
            Exit Sub
        End If
        SendKeys "{TAB}"
    End If
    If Not (KeyAscii > 47 And KeyAscii < 58 Or KeyAscii = 8) Then
        KeyAscii = 0
        BacCaracterNumerico KeyAscii
    End If
End Sub

Private Sub txtrut_LostFocus()

    If Len(txtRut.Text) <> 0 Then
      ' digito = BacDevuelveDig(txtrut.Text)
       txtDigito.Enabled = True
    
    End If
End Sub



Private Sub txtDigito_KeyPress(KeyAscii As Integer)
    txtDigito.Text = UCase(txtDigito.Text)

    If KeyAscii% = vbKeyReturn Then
        BacToUCase KeyAscii
        txtDigito_LostFocus
        KeyAscii% = 0
    End If
End Sub


Private Sub grilla_KeyDown(KeyCode As Integer, Shift As Integer)
Dim Datos()
Dim nColumna         As Long
Dim bPermiteEscribir As Boolean
Dim nMoninal         As Double

    
    If grilla.TextMatrix(grilla.RowSel, COL_Serie) = "" Then
        Exit Sub
    End If

    Let Me.MousePointer = vbHourglass
    Let nColumna = grilla.ColSel

    If KeyCode = vbKeyReturn Then  '->> Genera el ingreso de datos sobre la grilla, haciendo visible un texto sobre la celda seleccionada <<-'
        If grilla.TextMatrix(grilla.RowSel, Col_Marca) = "*" Then
            Me.MousePointer = vbDefault
            Exit Sub
        End If
        Let bPermiteEscribir = False
    
        If grilla.ColSel = Col_Nominal Then TxtIngreso.CantidadDecimales = 4: Let bPermiteEscribir = True
        If grilla.ColSel = Col_Tir Then TxtIngreso.CantidadDecimales = 4: Let bPermiteEscribir = True
        If grilla.ColSel = Col_MT Then TxtIngreso.CantidadDecimales = 0: Let bPermiteEscribir = True
        If grilla.ColSel = Col_Factor Then TxtIngreso.CantidadDecimales = 4: Let bPermiteEscribir = True
        
        If KeyCode = vbKeyG Or KeyCode = vbKeyR Then
            bPermiteEscribir = False
        End If
        
        If bPermiteEscribir Then
        
            Call PROC_POSI_TEXTO(grilla, TxtIngreso)
            
            TxtIngreso.Text = CDbl(grilla.TextMatrix(grilla.RowSel, grilla.ColSel))
            TxtIngreso.SelLength = Len(TxtIngreso.Text)
        
            Let TxtIngreso.Visible = True
            Let TxtIngreso.Text = grilla.TextMatrix(grilla.RowSel, grilla.ColSel)
            Let grilla.Enabled = False
            Let Toolbar1.Enabled = False
            Call TxtIngreso.SetFocus
            
        End If
        
    End If
        
        
    If KeyCode = vbKeyG Then
    
        If funcMarcarInstrumento() Then
        
            Call subValorizacionInstrumento(vbKeyG)
            
        End If
        
    End If
        
        
    If KeyCode = vbKeyR Then

        Call funcDesMarcarInstrumento
        
        Let grilla.TextMatrix(grilla.RowSel, Col_Nominal) = Format(CDbl(grilla.TextMatrix(grilla.RowSel, Col_Nominal_ORIG)), FDec4Dec)
        Let grilla.TextMatrix(grilla.RowSel, Col_Tir) = Format(CDbl(grilla.TextMatrix(grilla.RowSel, Col_Tir_ORIG)), FDec4Dec)
        Let grilla.TextMatrix(grilla.RowSel, Col_VPar) = Format(CDbl(grilla.TextMatrix(grilla.RowSel, Col_VPar_ORIG)), FDec4Dec)
        Let grilla.TextMatrix(grilla.RowSel, Col_MT) = Format(CDbl(grilla.TextMatrix(grilla.RowSel, Col_MT_ORIG)), FDec0Dec)

        Let grilla.TextMatrix(grilla.RowSel, Col_MTG) = Format(grilla.TextMatrix(grilla.RowSel, Col_MT) * grilla.TextMatrix(grilla.RowSel, Col_Factor), FDec0Dec)
        
        Call subActualizaMontoGarantia
        
    End If
        
    Let grilla.Col = nColumna
    Let Me.MousePointer = vbDefault
    
End Sub



Private Sub subSeleccionActual()

    
    If funcMarcarInstrumento() Then
    
        Call subValorizacionInstrumento(vbKeyG)
    
    End If
        
End Sub
Private Sub subDesmarcaActual()

    Call funcDesMarcarInstrumento
        
        Let grilla.TextMatrix(grilla.RowSel, Col_Nominal) = Format(CDbl(grilla.TextMatrix(grilla.RowSel, Col_Nominal_ORIG)), FDec4Dec)
        Let grilla.TextMatrix(grilla.RowSel, Col_Tir) = Format(CDbl(grilla.TextMatrix(grilla.RowSel, Col_Tir_ORIG)), FDec4Dec)
        Let grilla.TextMatrix(grilla.RowSel, Col_VPar) = Format(CDbl(grilla.TextMatrix(grilla.RowSel, Col_VPar_ORIG)), FDec4Dec)
        Let grilla.TextMatrix(grilla.RowSel, Col_MT) = Format(CDbl(grilla.TextMatrix(grilla.RowSel, Col_MT_ORIG)), FDec0Dec)

        Let grilla.TextMatrix(grilla.RowSel, Col_MTG) = Format(grilla.TextMatrix(grilla.RowSel, Col_MT) * grilla.TextMatrix(grilla.RowSel, Col_Factor), FDec0Dec)
        
        Call subActualizaMontoGarantia
    
End Sub

Private Sub txtDigito_LostFocus()

    If txtRut.Text <> "" And txtDigito.Text <> "" Then
        If BacValidaRut(txtRut.Text, txtDigito.Text) = False Then
            MsgBox "RUT Ingresado es Invalido", vbOKOnly + vbExclamation, TITSISTEMA
            txtDigito.Text = ""
            txtRut.Enabled = True
        Else
            'TxtCodigo.Enabled = True
            
            'TxtCodigo.SetFocus
        End If
    End If
End Sub



Private Sub TxtCodigo_LostFocus()
Dim idRut       As Long
Dim IdDig       As String
Dim IdCod       As Long
Dim sNombreCli  As String


    If Trim(txtRut.Text) = "" Then
        Exit Sub
    End If
    If Trim(TxtCodigo.Text) = "" Then
        Exit Sub
    End If
    objCliente.clrut = txtRut.Text
    objCliente.clcodigo = TxtCodigo.Text
    If objCliente.LeerPorRut(objCliente.clrut, objCliente.clcodigo) Then
        txtRut.Text = objCliente.clrut
        txtDigito.Text = objCliente.cldv
        TxtCodigo.Text = objCliente.clcodigo
        lbl_Cliente.Caption = objCliente.clnombre
        If CargaTransaccionesOtorgadas(False) > 0 Then
            Paleta.TabVisible(1) = True
        End If
    Else
        MsgBox "Atención!, el cliente buscado no existe.", vbExclamation, TITSISTEMA
        txtRut.Text = ""
        TxtCodigo.Text = ""
        txtDigito.Text = ""
        lbl_Cliente.Caption = ""
        txtRut.SetFocus
        Exit Sub
    End If

'    If Val(txtrut.Text) = 0 Or Trim(txtDigito.Text) = "" Then Exit Sub
'
'    If Trim(TxtCodigo) = "" Or Trim(txtrut) = "" Then
'        If Val(TxtCodigo) = 0 Then
'            MsgBox "Error : El código no puede ser cero ", 16, TITSISTEMA
'        Else
'            MsgBox "Error : Datos en Blanco ", 16, TITSISTEMA
'        End If
'
'       ' Call Limpiar
'       ' Call HabilitarControles(False)
'        txtrut.SetFocus
'        Exit Sub
'    End If
'
'    idRut = txtrut.Text
'    IdDig = txtDigito.Text
'    IdCod = TxtCodigo.Text
'
'
'    If funcBuscaClienteGARANTIA(idRut, IdDig, IdCod, sNombreCli) Then
'        lbl_Cliente.Caption = sNombreCli
'        If CargaTransaccionesOtorgadas(False) > 0 Then
'            Paleta.TabVisible(1) = True
'        End If
'    End If
    Call BloquearCliente(True)
    Call BloqueaBotones(False, "3,5,6,9")
    grilla.Enabled = True
End Sub
Private Function BloqueaBotones(ByVal bloqueo As Boolean, lista As String) As Boolean
Dim I As Integer, j As Integer, n As Integer
Dim salida()
Call llenalista(lista, salida)
If lista <> "" Then
    n = UBound(salida)
    If n > 0 Then
        For I = 1 To n
            j = salida(I)
            Toolbar1.Buttons(j).Enabled = Not bloqueo
        Next I
        Exit Function
    End If
End If
BloqueaBotones = True
End Function


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Key
        
        Case "cmdLimpiar"
            Call Limpiar
        
        Case "cmdGrabar"
            Call subGrabarGarantiasOtorgadas

        Case "cmdFiltrar"
            Call subFiltrar
            
        Case "cmdVender"
            Call subSeleccionActual
            
        Case "cmdRestaurar"
            Call subDesmarcaActual

        Case "cmdSalir"
            Call Unload(Me)

    End Select
    
End Sub
Private Sub subDevolverGarantia()
'Dim gtiaEli As String
'If Paleta.Tab <> 1 Then
'    Exit Sub
'End If
'gtiaEli = Format(GridResumen.TextMatrix(GridResumen.RowSel, 2), FEntero)
'If MsgBox("¿Confirma la devolución de la garantía N° " & gtiaEli & "?", vbQuestion + vbYesNoCancel) <> vbYes Then
'    Exit Sub
'End If
'Devolver la garantía gtiaEli
'Refrescar grillas GridResumen y GridDetalle

End Sub
Private Function subValorizacionInstrumento(ByVal xTecla As KeyCodeConstants)
Dim Datos()
Dim nNumdocu As Long
Dim nCorrelativo As Long

    If xTecla = vbKeyG Then
        Let nModoCalculo = 2
    Else
        Select Case grilla.ColSel
        
            Case Col_Marca, Col_Nominal, Col_Tir
                Let nModoCalculo = 2
                
            Case Col_MT
                Let nModoCalculo = 3
                
        End Select
        
    End If
    
    
    Let cMascara = grilla.TextMatrix(grilla.RowSel, COL_Serie)
    If Trim(cMascara) = "" Then
        Exit Function
    End If
    Let nNominal = grilla.TextMatrix(grilla.RowSel, Col_Nominal)
    Let nTir = grilla.TextMatrix(grilla.RowSel, Col_Tir)
    Let nPvp = grilla.TextMatrix(grilla.RowSel, Col_VPar)
    Let nMonto = grilla.TextMatrix(grilla.RowSel, Col_MT)
    Let nNumdocu = grilla.TextMatrix(grilla.RowSel, Col_NumDocu)
    Let nCorrelativo = grilla.TextMatrix(grilla.RowSel, Col_Correlativo)
    
    Let cFecCal = Format(gsbac_fecp, "yyyymmdd")
    Let cUsuario = gsBAC_User
    Let nVentana = MihWnd


    Envia = Array()
    AddParam Envia, gsbac_fecp
    AddParam Envia, nNumdocu
    AddParam Envia, nCorrelativo
    AddParam Envia, nNominal
    AddParam Envia, nTir
    AddParam Envia, nMonto
    AddParam Envia, nModoCalculo

    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_VALORIZA_SERIE_OTORGADO", Envia) Then
        Call MsgBox("Se ha producido un error en la Valorizacion del instrumento.", vbExclamation, App.Title)
        Call funcDesMarcarInstrumento
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
    
        If Datos(1) < 0 Then
        
            Call MsgBox(Datos(2), vbExclamation, App.Title)
            Call funcDesMarcarInstrumento
            
            Let grilla.TextMatrix(grilla.RowSel, Col_Nominal) = Format(CDbl(grilla.TextMatrix(grilla.RowSel, Col_Nominal_ORIG)), FDec4Dec)
            Let grilla.TextMatrix(grilla.RowSel, Col_Tir) = Format(CDbl(grilla.TextMatrix(grilla.RowSel, Col_Tir_ORIG)), FDec4Dec)
            Let grilla.TextMatrix(grilla.RowSel, Col_VPar) = Format(CDbl(grilla.TextMatrix(grilla.RowSel, Col_VPar_ORIG)), FDec4Dec)
            Let grilla.TextMatrix(grilla.RowSel, Col_MT) = Format(CDbl(grilla.TextMatrix(grilla.RowSel, Col_MT_ORIG)), FDec0Dec)
            Let grilla.TextMatrix(grilla.RowSel, Col_MTG) = Format(grilla.TextMatrix(grilla.RowSel, Col_MT) * grilla.TextMatrix(grilla.RowSel, Col_Factor), FDec0Dec)
            
            On Error Resume Next
            Call grilla.SetFocus
            On Error GoTo 0
            
        Else
        
            Let grilla.TextMatrix(grilla.RowSel, Col_Nominal) = Format(Datos(2), FDec4Dec)
            Let grilla.TextMatrix(grilla.RowSel, Col_Tir) = Format(Datos(3), FDec4Dec)
            Let grilla.TextMatrix(grilla.RowSel, Col_VPar) = Format(Datos(4), FDec4Dec)
            Let grilla.TextMatrix(grilla.RowSel, Col_MT) = Format(Datos(5), FDec0Dec)
            Let grilla.TextMatrix(grilla.RowSel, Col_MTG) = Format(grilla.TextMatrix(grilla.RowSel, Col_MT) * grilla.TextMatrix(grilla.RowSel, Col_Factor), FDec0Dec)
            
        End If
        
    End If
    
    Call subColorea_Registro
    Call subActualizaMontoGarantia
   
End Function

Private Sub subFiltrar()
Dim Datos()

    If Trim(Me.txtRut.Text) = "" Then
        MsgBox "Debe seleccionar cliente, antes de seleccionar instrumentos", vbExclamation, TITSISTEMA
        Exit Sub
    End If
    If Cmb_TipoDerivado.ListIndex = -1 Then
        MsgBox "Debe seleccionar el tipo de Garantía antes de seleccionar instrumentos", vbExclamation, TITSISTEMA
        Exit Sub
    End If
    
    Call subRevisaInstrumentosCargados
    
    Let Me.CarterasFinancieras = ""
    Let Me.CarterasNormativas = ""
    
    Dim miForm As String
    miForm = Me.Name
    
    FRM_FILTRO_CARTERA.Tag = miForm
    
    Call FRM_FILTRO_CARTERA.Show(vbModal)
    
    
    If Not subCargaDatosFiltro Then
        Call BloqueaBotones(True, "3,6,8")
        
    Else
        Let txt_totalGarantizado.Enabled = True
        Let Me.frmCliente.Enabled = False
        Call BloqueaBotones(False, "3,6,8")
        Let Me.MousePointer = vbDefault
    End If
    
End Sub
    

Private Sub subRevisaInstrumentosCargados()
Dim nContador  As Long

   For nContador = 1 To grilla.Rows - 1
      If grilla.TextMatrix(nContador, Col_Marca) <> "" And grilla.TextMatrix(nContador, Col_Marca) <> "*" Then
         Let grilla.Row = nContador
         Call funcDesMarcarInstrumento
      End If
   Next nContador

End Sub


Private Function funcValidaPapelesaGrabar() As Boolean
Dim nContador   As Long
Dim sMensaje    As String


    Let funcValidaPapelesaGrabar = False
    Let sMensaje = ""
    
    
    If Val(Me.txtRut.Text) = 0 Then
        sMensaje = sMensaje & " - Debe ingresar el rut de cliente a otorgar garantía" & vbCrLf & vbCrLf
    End If
    
    If Trim(Me.txtDigito.Text) = "" Then
        sMensaje = sMensaje & " - Debe ingresar digito de cliente a otorgar garantía" & vbCrLf & vbCrLf
    End If
    
    If Val(Me.TxtCodigo.Text) = 0 Then
        sMensaje = sMensaje & " - Debe ingresar código de cliente a otorgar garantía" & vbCrLf & vbCrLf
    End If
    
    If Format(Me.txt_fechaRevision.Text, "yyyymmdd") < Format(gsbac_fecp, "yyyymmdd") Then
        sMensaje = sMensaje & " - La fecha de revision debe ser superior a la fecha de proceso" & vbCrLf & vbCrLf
    End If
    
    If Me.Cmb_TipoDerivado.ListIndex = -1 Then
        sMensaje = sMensaje & " - Debe seleccionar el tipo de garantía a otorgar" & vbCrLf & vbCrLf
    End If
    
    
    If Len(sMensaje) = 0 Then
        For nContador = 1 To grilla.Rows - 1
            If grilla.TextMatrix(nContador, Col_Marca) = "P" Or grilla.TextMatrix(nContador, Col_Marca) = "G" Then
                If Format(grilla.TextMatrix(nContador, Col_FecVen), "yyyymmdd") < Format(Me.txt_fechaRevision.Text, "yyyymmdd") Then
                    sMensaje = sMensaje & " -  Papel : " & grilla.TextMatrix(nContador, COL_Serie) & " Vence (" & Format(grilla.TextMatrix(nContador, Col_FecVen), "dd/mm/yyyy") & ")  antes de la garantia" & vbCrLf & vbCrLf
                    Let funcValidaPapelesaGrabar = False
                Else
                    Let funcValidaPapelesaGrabar = IIf(Len(sMensaje) = 0, True, False)
                End If
            End If
        Next nContador
    End If
    If funcValidaPapelesaGrabar = False Then
        
        sMensaje = sMensaje & IIf(Len(sMensaje) = 0, " - No se han seleccionado instrumentos a garantizar", "")
    End If
    
    
    If Len(sMensaje) > 0 Then
        MsgBox sMensaje, vbExclamation, App.Title
        Exit Function
    End If
    
    funcValidaPapelesaGrabar = True
   
End Function
Private Sub subActualizaMontoGarantia()
Dim nMonto      As Double
Dim lContador   As Long

    Let nMonto = 0
    
    For lContador = 1 To grilla.Rows - 1
        If grilla.TextMatrix(lContador, Col_Marca) = "G" Or grilla.TextMatrix(lContador, Col_Marca) = "P" Then
            If Trim(grilla.TextMatrix(lContador, Col_MTG)) <> "" Then
                nMonto = nMonto + CDbl(grilla.TextMatrix(lContador, Col_MTG))
            End If

        End If
        
    Next lContador

    Let txt_totalGarantizado.Text = nMonto + CDbl(txtFactorAditivo.Text)
    
End Sub

Private Sub TxtRut_DblClick()
Dim xx
On Error GoTo Error
    
    BacControlWindows 100
      
    'BacAyuda.Tag = "MDCL"
    'BacAyuda.Show 1
   'Arm Se iplementa nuevo formulario ayuda
   BacAyudaCliente.Tag = "MDCL"
   BacAyudaCliente.Show 1
    If giAceptar = True Then
        txtRut.Text = Val(gsrut$)
        txtDigito.Text = gsDigito$
        txtCodigo.Text = gsValor$
        
        txtRut.Enabled = True
        txtDigito.Enabled = True
        TxtCodigo.Enabled = True
        Call BloqueaBotones(False, "1")
        txtDigito.SetFocus
        
        Call TxtCodigo_LostFocus
        
        'SendKeys "{TAB}"
    End If

Error:
  If Err.Number <> 0 Then MsgBox Err.Description
  

End Sub
Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        SendKeys "{TAB}"
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
        BacCaracterNumerico KeyAscii
    End If
End Sub
Private Function BloquearCliente(ByVal bloqueo As Boolean) As Boolean
    txtRut.Enabled = Not bloqueo
    txtDigito.Enabled = Not bloqueo
    TxtCodigo.Enabled = Not bloqueo
    lbl_Cliente.Enabled = Not bloqueo
    BloquearCliente = True
End Function
