VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_IBS_BAC 
   Caption         =   "Form2"
   ClientHeight    =   8190
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   11985
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   8190
   ScaleWidth      =   11985
   Begin Threed.SSPanel SSPanelmensaje 
      Height          =   1260
      Left            =   3435
      TabIndex        =   26
      Top             =   3390
      Width           =   4980
      _Version        =   65536
      _ExtentX        =   8784
      _ExtentY        =   2222
      _StockProps     =   15
      BackColor       =   14215660
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSPanel SSProgress 
         Height          =   360
         Left            =   150
         TabIndex        =   28
         Top             =   570
         Width           =   4590
         _Version        =   65536
         _ExtentX        =   8096
         _ExtentY        =   635
         _StockProps     =   15
         Caption         =   "SSPanel1"
         BackColor       =   14215660
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         BevelInner      =   2
         FloodType       =   1
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Cargando Información de Creditos y Derivados."
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
         Left            =   705
         TabIndex        =   27
         Top             =   285
         Width           =   3435
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11985
      _ExtentX        =   21140
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar / Refrescar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar / Actualizar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Definir Vista"
            ImageIndex      =   4
            Style           =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   2
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "No Relacionados"
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Relacionados"
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar Relación"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Agregar Creditos"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5010
         Top             =   0
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
               Picture         =   "FRM_MNT_IBS_BAC.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_IBS_BAC.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_IBS_BAC.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_IBS_BAC.frx":20CE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_IBS_BAC.frx":2FA8
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_IBS_BAC.frx":3E82
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FRACre 
      Enabled         =   0   'False
      Height          =   3840
      Left            =   30
      TabIndex        =   1
      Top             =   390
      Width           =   11910
      Begin MSComctlLib.Toolbar Toolbar2 
         Height          =   450
         Left            =   11325
         TabIndex        =   23
         Top             =   420
         Visible         =   0   'False
         Width           =   495
         _ExtentX        =   873
         _ExtentY        =   794
         ButtonWidth     =   767
         ButtonHeight    =   741
         Appearance      =   1
         Style           =   1
         ImageList       =   "ImageList1"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   1
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Refrescar solo Créditos"
               ImageIndex      =   1
            EndProperty
         EndProperty
         BorderStyle     =   1
      End
      Begin MSFlexGridLib.MSFlexGrid GRID_Cre 
         Height          =   2895
         Left            =   30
         TabIndex        =   11
         Top             =   900
         Width           =   11835
         _ExtentX        =   20876
         _ExtentY        =   5106
         _Version        =   393216
         Cols            =   6
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
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
      Begin BACControles.TXTFecha TXTFechaVcto_Cre 
         Height          =   315
         Left            =   7410
         TabIndex        =   9
         Top             =   495
         Width           =   1515
         _ExtentX        =   2672
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
         Text            =   "19/08/2009"
      End
      Begin VB.ComboBox CMBMoneda_Cre 
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
         Left            =   960
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   495
         Width           =   3615
      End
      Begin VB.TextBox TXTNomCliente_Cre 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   960
         Locked          =   -1  'True
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   3
         Text            =   "BANCO DEL DESARROLLO"
         Top             =   165
         Width           =   5235
      End
      Begin VB.Label EtiquetaSinInformacion 
         AutoSize        =   -1  'True
         Caption         =   "Sin Información"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   210
         Index           =   0
         Left            =   4755
         TabIndex        =   29
         Top             =   570
         Visible         =   0   'False
         Width           =   1260
      End
      Begin VB.Label LBLCodigo_Cre 
         Alignment       =   2  'Center
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "1"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Left            =   8580
         TabIndex        =   10
         Top             =   165
         Width           =   300
      End
      Begin VB.Label LBLRut_Cre 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "97053000"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Left            =   7410
         TabIndex        =   8
         Top             =   165
         Width           =   1140
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Feha Vcto."
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
         Left            =   6465
         TabIndex        =   7
         Top             =   555
         Width           =   780
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Rut"
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
         Left            =   6465
         TabIndex        =   6
         Top             =   225
         Width           =   255
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
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
         Height          =   195
         Index           =   1
         Left            =   105
         TabIndex        =   4
         Top             =   540
         Width           =   570
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
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
         Left            =   120
         TabIndex        =   2
         Top             =   210
         Width           =   495
      End
   End
   Begin VB.Frame FRADer 
      Enabled         =   0   'False
      Height          =   3840
      Left            =   45
      TabIndex        =   12
      Top             =   4155
      Width           =   11910
      Begin VB.ComboBox CMBAjusteNoc 
         BackColor       =   &H80000002&
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   315
         Left            =   4920
         Style           =   2  'Dropdown List
         TabIndex        =   25
         Top             =   1305
         Visible         =   0   'False
         Width           =   900
      End
      Begin VB.TextBox TXTNomCliente_Der 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   960
         Locked          =   -1  'True
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   16
         Text            =   "BANCO DEL DESARROLLO"
         Top             =   165
         Width           =   5235
      End
      Begin VB.ComboBox CMBMoneda_Der 
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
         Left            =   960
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   495
         Width           =   3615
      End
      Begin MSFlexGridLib.MSFlexGrid GRID_Der 
         Height          =   2895
         Left            =   15
         TabIndex        =   13
         Top             =   900
         Width           =   11835
         _ExtentX        =   20876
         _ExtentY        =   5106
         _Version        =   393216
         Cols            =   6
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
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
      Begin BACControles.TXTFecha TXTFechaVcto_Der 
         Height          =   315
         Left            =   7410
         TabIndex        =   14
         Top             =   495
         Width           =   1515
         _ExtentX        =   2672
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
         Text            =   "19/08/2009"
      End
      Begin MSComctlLib.Toolbar Toolbar3 
         Height          =   450
         Left            =   11340
         TabIndex        =   24
         Top             =   420
         Visible         =   0   'False
         Width           =   495
         _ExtentX        =   873
         _ExtentY        =   794
         ButtonWidth     =   767
         ButtonHeight    =   741
         Appearance      =   1
         Style           =   1
         ImageList       =   "ImageList1"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   1
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Refrescar solo Derivados"
               ImageIndex      =   1
            EndProperty
         EndProperty
         BorderStyle     =   1
      End
      Begin VB.Label EtiquetaSinInformacion 
         AutoSize        =   -1  'True
         Caption         =   "Sin Información"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   210
         Index           =   1
         Left            =   4875
         TabIndex        =   30
         Top             =   570
         Visible         =   0   'False
         Width           =   1260
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
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
         Left            =   120
         TabIndex        =   22
         Top             =   210
         Width           =   495
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
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
         Height          =   195
         Index           =   6
         Left            =   105
         TabIndex        =   21
         Top             =   540
         Width           =   570
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Rut"
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
         Index           =   5
         Left            =   6465
         TabIndex        =   20
         Top             =   225
         Width           =   255
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Feha Vcto."
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
         Left            =   6465
         TabIndex        =   19
         Top             =   555
         Width           =   780
      End
      Begin VB.Label LBLRut_Der 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "97053000"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Left            =   7410
         TabIndex        =   18
         Top             =   165
         Width           =   1140
      End
      Begin VB.Label LBLCodigo_Der 
         Alignment       =   2  'Center
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "1"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Left            =   8580
         TabIndex        =   17
         Top             =   165
         Width           =   300
      End
   End
End
Attribute VB_Name = "FRM_MNT_IBS_BAC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private LoadFirstTime    As Boolean          '->> Define si esta entrando por primera vez al Frm
Private EstadoFiltro     As Long             '->> Define el tipo de Filtro aplicado

Private Const Grd0_RowFix = 0                '->> Define el indicador de Fila Fija
'->> Variables de Setting de la Grilla de Creditos
Private Const Grd1_xMarca = 0
Private Const Grd1_NumCre = 1
Private Const Grd1_NomCli = 2
Private Const Grd1_RutCli = 3
Private Const Grd1_Moneda = 4
Private Const Grd1_MontoK = 5
Private Const Grd1_FecVct = 6
Private Const Grd1_nDeriv = 7
Private Const Grd1_Modulo = 8
'->> Variables de Setting de la Grilla de Derivados
Private Const Grd2_xMarca = 0
Private Const Grd2_Modulo = 1
Private Const Grd2_Produc = 2
Private Const Grd2_NumDer = 3
Private Const Grd2_NomCli = 4
Private Const Grd2_RutCli = 5
Private Const Grd2_MonAct = 6
Private Const Grd2_CapAct = 7
Private Const Grd2_MonPas = 8
Private Const Grd2_CapPas = 9
Private Const Grd2_FecVct = 10
Private Const Grd2_AjuNoc = 11
Private Const Grd2_CodCli = 12

Private Sub SETTING_GRID(ByRef xGrilla As MSFlexGrid)
   '->> Function de Seteo de Grillas, define largo, Titulo de Campos y Alineacion de la columna
   If xGrilla.Name = "GRID_Cre" Then
      Let xGrilla.Rows = 2:         Let xGrilla.Cols = (Grd1_Modulo + 1)
      Let xGrilla.FixedRows = 1:    Let xGrilla.FixedCols = 0

      Let xGrilla.TextMatrix(Grd0_RowFix, Grd1_xMarca) = "M":                Let xGrilla.ColWidth(Grd1_xMarca) = 250:  Let xGrilla.ColAlignment(Grd1_xMarca) = flexAlignRightCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd1_NumCre) = "Num. Crédito":     Let xGrilla.ColWidth(Grd1_NumCre) = 1050: Let xGrilla.ColAlignment(Grd1_NumCre) = flexAlignLeftCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd1_NomCli) = "Nombre Cliente":   Let xGrilla.ColWidth(Grd1_NomCli) = 3000: Let xGrilla.ColAlignment(Grd1_NomCli) = flexAlignLeftCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd1_RutCli) = "Rut Cliente":      Let xGrilla.ColWidth(Grd1_RutCli) = 1200: Let xGrilla.ColAlignment(Grd1_RutCli) = flexAlignLeftCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd1_Moneda) = "Moneda":           Let xGrilla.ColWidth(Grd1_Moneda) = 1200: Let xGrilla.ColAlignment(Grd1_Moneda) = flexAlignLeftCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd1_MontoK) = "Capital":          Let xGrilla.ColWidth(Grd1_MontoK) = 1500: Let xGrilla.ColAlignment(Grd1_MontoK) = flexAlignRightCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd1_FecVct) = "Fec. Vcto":        Let xGrilla.ColWidth(Grd1_FecVct) = 1200: Let xGrilla.ColAlignment(Grd1_FecVct) = flexAlignLeftCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd1_nDeriv) = "Ajuste Nac.":      Let xGrilla.ColWidth(Grd1_nDeriv) = 1050: Let xGrilla.ColAlignment(Grd1_nDeriv) = flexAlignLeftCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd1_Modulo) = "Modulo":           Let xGrilla.ColWidth(Grd1_Modulo) = 950:  Let xGrilla.ColAlignment(Grd1_Modulo) = flexAlignRightCenter
      
      Let xGrilla.FocusRect = flexFocusNone
   End If

   If xGrilla.Name = "GRID_Der" Then
      Let xGrilla.Rows = 2:         Let xGrilla.Cols = (Grd2_CodCli + 1)
      Let xGrilla.FixedRows = 1:    Let xGrilla.FixedCols = 0

      Let xGrilla.TextMatrix(Grd0_RowFix, Grd2_xMarca) = "M":                Let xGrilla.ColWidth(Grd2_xMarca) = 250:  Let xGrilla.ColAlignment(Grd2_xMarca) = flexAlignRightCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd2_Modulo) = "Modulo":           Let xGrilla.ColWidth(Grd2_Modulo) = 0:    Let xGrilla.ColAlignment(Grd2_Modulo) = flexAlignLeftCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd2_Produc) = "Producto":         Let xGrilla.ColWidth(Grd2_Produc) = 2000: Let xGrilla.ColAlignment(Grd2_Produc) = flexAlignLeftCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd2_NumDer) = "N° Oper":          Let xGrilla.ColWidth(Grd2_NumDer) = 1000: Let xGrilla.ColAlignment(Grd2_NumDer) = flexAlignRightCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd2_NomCli) = "Nombre Cliente":   Let xGrilla.ColWidth(Grd2_NomCli) = 3000: Let xGrilla.ColAlignment(Grd2_NomCli) = flexAlignLeftCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd2_RutCli) = "Rut Cliente":      Let xGrilla.ColWidth(Grd2_RutCli) = 1200: Let xGrilla.ColAlignment(Grd2_RutCli) = flexAlignRightCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd2_MonAct) = "Mon. Act":         Let xGrilla.ColWidth(Grd2_MonAct) = 850:  Let xGrilla.ColAlignment(Grd2_MonAct) = flexAlignLeftCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd2_CapAct) = "Capital Act":      Let xGrilla.ColWidth(Grd2_CapAct) = 1800: Let xGrilla.ColAlignment(Grd2_CapAct) = flexAlignRightCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd2_MonPas) = "Mon Pas":          Let xGrilla.ColWidth(Grd2_MonPas) = 850:  Let xGrilla.ColAlignment(Grd2_MonPas) = flexAlignLeftCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd2_CapPas) = "Capital Pas":      Let xGrilla.ColWidth(Grd2_CapPas) = 1800: Let xGrilla.ColAlignment(Grd2_CapPas) = flexAlignRightCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd2_FecVct) = "Fecha Vcto":       Let xGrilla.ColWidth(Grd2_FecVct) = 1200: Let xGrilla.ColAlignment(Grd2_FecVct) = flexAlignLeftCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd2_AjuNoc) = "Ajuste Noc":       Let xGrilla.ColWidth(Grd2_AjuNoc) = 1000: Let xGrilla.ColAlignment(Grd2_AjuNoc) = flexAlignLeftCenter
      Let xGrilla.TextMatrix(Grd0_RowFix, Grd2_CodCli) = "CldCliente":       Let xGrilla.ColWidth(Grd2_CodCli) = 0:    Let xGrilla.ColAlignment(Grd2_CodCli) = flexAlignLeftCenter

      Let xGrilla.FocusRect = flexFocusNone
   End If

   Let xGrilla.Font.Name = "Tahoma"
   Let xGrilla.Font.Size = 8
End Sub

Private Sub Load_Monedas(ByRef oObjeto As ComboBox)
   '->> Carga las monedas en los combos de filtro de monedas
   Dim Datos()

   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEER_MONEDA") Then
      Call MsgBox("Se ha originado un error en la lectura de las monedas.", vbExclamation, App.Title)
      Exit Sub
   End If

   Call oObjeto.Clear
   Call oObjeto.AddItem("<< TODAS >>")
   Let oObjeto.ItemData(oObjeto.NewIndex) = 0

   Do While Bac_SQL_Fetch(Datos())
      If Datos(21) = 2 Or Datos(21) = 3 Then
         Call oObjeto.AddItem(Datos(4))
         Let oObjeto.ItemData(oObjeto.NewIndex) = Datos(1)
      End If
   Loop

   Let oObjeto.ListIndex = 0
End Sub

Private Function FUNC_CARGA_CREDITOS()
   '->> Funcion de carga de Creditoas
   Dim nContador  As Long
   Dim Datos()

   Let EtiquetaSinInformacion(0).Visible = False

   Let Screen.MousePointer = vbHourglass

   If Len(LBLRut_Cre.Caption) = 0 Then
      Let LBLRut_Cre.Tag = 0
      Let LBLCodigo_Cre.Tag = 0
   Else
      Let LBLRut_Cre.Tag = Mid(LBLRut_Cre.Caption, 1, Len(LBLRut_Cre.Caption) - 2)
      Let LBLCodigo_Cre.Tag = IIf(Len(LBLCodigo_Cre.Caption) = 0, 0, LBLCodigo_Cre.Caption)
   End If

   If CMBMoneda_Cre.ListIndex < 0 Then
      CMBMoneda_Cre.Tag = 0
   Else
      CMBMoneda_Cre.Tag = CMBMoneda_Cre.ItemData(CMBMoneda_Cre.ListIndex)
   End If

   Envia = Array()
   AddParam Envia, CDbl(LBLRut_Cre.Tag)
   AddParam Envia, CDbl(LBLCodigo_Cre.Tag)
   AddParam Envia, CDbl(CMBMoneda_Cre.Tag)
   AddParam Envia, CDbl(EstadoFiltro)
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEER_CREDITOS_IBS", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha originado un error al leer cartera de derivados.", vbExclamation, App.Title)
      Exit Function
   End If

   If EstadoFiltro = 0 Then
      Let GRID_Cre.ColWidth(Grd1_nDeriv) = 0
      Let GRID_Cre.ColWidth(Grd1_Modulo) = 0
   Else
      Let GRID_Cre.ColWidth(Grd1_nDeriv) = 1050
      Let GRID_Cre.ColWidth(Grd1_Modulo) = 950
   End If

   Let GRID_Cre.Rows = 1
   Let GRID_Cre.Redraw = False
   Let nContador = 1

   Do While Bac_SQL_Fetch(Datos())
      Let GRID_Cre.Rows = GRID_Cre.Rows + 1
      Let GRID_Cre.TextMatrix(GRID_Cre.Rows - 1, Grd1_NumCre) = Datos(1)
      Let GRID_Cre.TextMatrix(GRID_Cre.Rows - 1, Grd1_NomCli) = Datos(2)
      Let GRID_Cre.TextMatrix(GRID_Cre.Rows - 1, Grd1_RutCli) = Datos(3)
      Let GRID_Cre.TextMatrix(GRID_Cre.Rows - 1, Grd1_Moneda) = Datos(4)
      Let GRID_Cre.TextMatrix(GRID_Cre.Rows - 1, Grd1_MontoK) = Format(Datos(5), IIf(Datos(4) = "CLP", FEntero, FDecimal))
      Let GRID_Cre.TextMatrix(GRID_Cre.Rows - 1, Grd1_FecVct) = Datos(6)
      Let GRID_Cre.TextMatrix(GRID_Cre.Rows - 1, Grd1_nDeriv) = Datos(7)
      Let GRID_Cre.TextMatrix(GRID_Cre.Rows - 1, Grd1_Modulo) = Datos(8)
      
      Let SSProgress.FloodPercent = ((nContador * 100#) / Datos(9))
      Let nContador = nContador + 1
   Loop

   If GRID_Cre.Rows = GRID_Cre.FixedRows Then
      Let EtiquetaSinInformacion(0).Visible = True
   End If

   Let GRID_Cre.Redraw = True

   Let Screen.MousePointer = vbDefault
End Function

Private Function FUNC_CARGA_DERIVADOS()
   Dim nNumeroDerivado  As Long
   Dim nContador        As Long
   Dim cModulo          As String
   Dim Datos()

   Let EtiquetaSinInformacion(1).Visible = False

   If EstadoFiltro = 1 Then

      If GRID_Cre.RowSel = 0 Or GRID_Cre.Rows = 1 Then
         Exit Function
      End If

      Let GRID_Der.Rows = 1
      Let nNumeroDerivado = GRID_Cre.TextMatrix(GRID_Cre.RowSel, Grd1_nDeriv)
      Let cModulo = GRID_Cre.TextMatrix(GRID_Cre.RowSel, Grd1_Modulo)

      Let LBLRut_Der.Tag = 0
      Let LBLCodigo_Der.Tag = 0
      Let CMBMoneda_Der.Tag = 0

      If nNumeroDerivado = 0 Or cModulo = "" Then
         Exit Function
      End If
   Else
      Let nNumeroDerivado = 0
      Let cModulo = ""
   
      If Len(LBLRut_Der.Caption) = 0 Then
         Let LBLRut_Der.Tag = 0
         Let LBLCodigo_Der.Tag = 0
      Else
         Let LBLRut_Der.Tag = Mid(LBLRut_Der.Caption, 1, Len(LBLRut_Der.Caption) - 2)
         Let LBLCodigo_Der.Tag = IIf(Len(LBLCodigo_Der.Caption) = 0, 0, LBLCodigo_Der.Caption)
      End If

      If CMBMoneda_Der.ListIndex < 0 Then
         Let CMBMoneda_Der.Tag = 0
      Else
         Let CMBMoneda_Der.Tag = CMBMoneda_Der.ItemData(CMBMoneda_Der.ListIndex)
      End If
   End If

   Let Screen.MousePointer = vbHourglass


   Envia = Array()
   AddParam Envia, CDbl(LBLRut_Der.Tag)
   AddParam Envia, CDbl(LBLCodigo_Der.Tag)
   AddParam Envia, ""
   AddParam Envia, Val(CMBMoneda_Der.Tag)
   AddParam Envia, CDbl(EstadoFiltro)
   AddParam Envia, CDbl(nNumeroDerivado)
   AddParam Envia, cModulo
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEE_CARTERA_DERIVADOS", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha originado un error al leer cartera de derivados.", vbExclamation, App.Title)
      Exit Function
   End If
   Let GRID_Der.Rows = 1
   Let GRID_Der.Redraw = False
   Let nContador = 1

   Do While Bac_SQL_Fetch(Datos())
      Let GRID_Der.Rows = GRID_Der.Rows + 1

      Let GRID_Der.TextMatrix(GRID_Der.Rows - 1, Grd2_Modulo) = Datos(1)
      Let GRID_Der.TextMatrix(GRID_Der.Rows - 1, Grd2_Produc) = Datos(2) & Space(100) & Datos(3)
      Let GRID_Der.TextMatrix(GRID_Der.Rows - 1, Grd2_NumDer) = Datos(4)
      Let GRID_Der.TextMatrix(GRID_Der.Rows - 1, Grd2_NomCli) = Datos(5)
      Let GRID_Der.TextMatrix(GRID_Der.Rows - 1, Grd2_RutCli) = Datos(6)
      Let GRID_Der.TextMatrix(GRID_Der.Rows - 1, Grd2_MonAct) = Datos(7)
      Let GRID_Der.TextMatrix(GRID_Der.Rows - 1, Grd2_CapAct) = Format(Datos(8), IIf(Datos(7) = "CLP", FEntero, FDecimal))
      Let GRID_Der.TextMatrix(GRID_Der.Rows - 1, Grd2_MonPas) = Datos(9)
      Let GRID_Der.TextMatrix(GRID_Der.Rows - 1, Grd2_CapPas) = Format(Datos(10), IIf(Datos(9) = "CLP", FEntero, FDecimal))
      Let GRID_Der.TextMatrix(GRID_Der.Rows - 1, Grd2_FecVct) = Datos(11)
      Let GRID_Der.TextMatrix(GRID_Der.Rows - 1, Grd2_AjuNoc) = Datos(12)
      Let GRID_Der.TextMatrix(GRID_Der.Rows - 1, Grd2_CodCli) = Datos(14)
      Let SSProgress.FloodPercent = ((nContador * 100#) / Datos(13))
      Let nContador = nContador + 1
   Loop

   If GRID_Der.Rows = GRID_Der.FixedRows Then
      Let EtiquetaSinInformacion(1).Visible = True
   End If

   Let GRID_Der.Redraw = True
   Let Screen.MousePointer = vbDefault
End Function

Private Sub FUNC_LIMPIAR()
   Let TXTNomCliente_Cre.Text = ""
   Let LBLRut_Cre.Caption = ""
   Let LBLCodigo_Cre.Caption = ""
   Let TXTFechaVcto_Cre.Text = Format(gsbac_fecp, "DD-MM-YYYY")

   Let TXTNomCliente_Der.Text = ""
   Let LBLRut_Der.Caption = ""
   Let LBLCodigo_Der.Caption = ""
   Let TXTFechaVcto_Der.Text = Format(gsbac_fecp, "DD-MM-YYYY")
End Sub

Private Sub CMBAjusteNoc_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Let Toolbar1.Enabled = True
      Let GRID_Der.Enabled = True
      Let GRID_Cre.Enabled = True
      Call GRID_Der.SetFocus
      Let GRID_Der.TextMatrix(GRID_Der.RowSel, GRID_Der.ColSel) = Mid(CMBAjusteNoc.Text, 1, 1)
      Let CMBAjusteNoc.Enabled = False
      Let CMBAjusteNoc.Visible = False
   End If
   If KeyCode = vbKeyEscape Then
      Let Toolbar1.Enabled = True
      Let GRID_Der.Enabled = True
      Let GRID_Cre.Enabled = True
      Call GRID_Der.SetFocus
      Let CMBAjusteNoc.Enabled = False
      Let CMBAjusteNoc.Visible = False
   End If
End Sub

Private Sub Form_Activate()

   If LoadFirstTime = True Then

      DoEvents: DoEvents: DoEvents: DoEvents: DoEvents

      Let LoadFirstTime = False

      Call FUNC_BUSCAR

      Let FRACre.Enabled = True
      Let FRADer.Enabled = True

      Let SSPanelmensaje.Visible = False
   End If

End Sub

Private Sub Form_Load()
   Let Me.Top = 0:   Let Me.Left = 0
   Let Me.Icon = BACSwapParametros.Icon
   Let Me.Caption = "Marca de Derivados y Créditos."
   
   Let EstadoFiltro = 0 '--> No Relacionados
   Let LoadFirstTime = True
   
   Call CMBAjusteNoc.Clear
   Call CMBAjusteNoc.AddItem("SI")
   Call CMBAjusteNoc.AddItem("NO")

   Call FUNC_LIMPIAR

   Call SETTING_GRID(GRID_Cre)
   Call SETTING_GRID(GRID_Der)
   Call Load_Monedas(CMBMoneda_Cre)
   Call Load_Monedas(CMBMoneda_Der)
   
   Let Toolbar2.Visible = True:  Let Toolbar2.Enabled = True
   Let Toolbar3.Visible = True:  Let Toolbar3.Enabled = True
End Sub

Private Sub Form_Resize()
   On Error Resume Next

   Let FRACre.Width = Me.Width - 200
   Let GRID_Cre.Width = FRACre.Width - 150

   Let FRADer.Width = Me.Width - 200
   Let GRID_Der.Width = FRADer.Width - 150

   If Me.Height < 8595 Then
      Me.Height = 8595
   End If

   On Error GoTo 0
End Sub

Private Sub GRID_Cre_Click()
   If EstadoFiltro = 1 Then
      Call FUNC_CARGA_DERIVADOS
   End If
End Sub

Private Sub GRID_Der_DblClick()
   If EstadoFiltro = 0 Then
      Call FUNC_PINTA_GRILLA(GRID_Der, GRID_Der.RowSel)
   End If
End Sub

Private Sub GRID_Der_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn And GRID_Der.ColSel = Grd2_AjuNoc Then

      Call AJObjeto(GRID_Der, CMBAjusteNoc)

      Let CMBAjusteNoc.Enabled = True
      Let CMBAjusteNoc.Visible = True

      On Error Resume Next
      Call CMBAjusteNoc.SetFocus
      On Error GoTo 0

      Let Toolbar1.Enabled = False
      Let GRID_Der.Enabled = False
      Let GRID_Cre.Enabled = False
      Let CMBAjusteNoc.Text = IIf(GRID_Der.TextMatrix(GRID_Der.RowSel, GRID_Der.ColSel) = "N", "NO", "SI")
   End If

End Sub

Private Function FUNC_DEL_RELACION()
   Dim nDerivado  As Long
   Dim nCredito   As Long

   Let nDerivado = GRID_Cre.TextMatrix(GRID_Cre.RowSel, Grd1_nDeriv)
   Let nCredito = GRID_Cre.TextMatrix(GRID_Cre.RowSel, Grd1_NumCre)

   If MsgBox("¿ Esta seguro que desea eliminar la relación Crédito N° " & nCredito & " y Derivado N° " & nDerivado & " ?", vbQuestion + vbYesNo, App.Title) = vbYes Then

      Let Screen.MousePointer = vbHourglass

      Call FUNC_DELETE_RELACION(nDerivado, nCredito)
      Call FUNC_CARGA_CREDITOS
      Call FUNC_CARGA_DERIVADOS

      Let Screen.MousePointer = vbDefault

      Call MsgBox("Se ha desvinculado el crédito del derivado en forma correcta.", vbInformation, App.Title)
   End If

End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

        Select Case Button.Index
        Case 2
            Call FUNC_BUSCAR
        Case 3
            Call FUNC_GRABAR_RELACION
        Case 5
            Call FUNC_DEL_RELACION
        Case 6
            Call FUNC_AGREGAR_CREDITO
        Case 7
            Call Unload(Me)
        End Select

End Sub

Private Sub FUNC_AGREGAR_CREDITO()
    frmAgregaCredito.Show 1
    If frmAgregaCredito.lActualizaCreditos Then
        '
        '   Actualiza grilla
        '
        Let FRACre.Enabled = False
        Let FRADer.Enabled = False
        Let SSPanelmensaje.Visible = True
        DoEvents: DoEvents: DoEvents: DoEvents: DoEvents
        
        Call FUNC_CARGA_CREDITOS
        
        DoEvents: DoEvents: DoEvents: DoEvents: DoEvents
        Let FRACre.Enabled = True
        Let FRADer.Enabled = True
        Let SSPanelmensaje.Visible = False
    
    End If
    
End Sub

Private Function FUNC_BUSCAR()

   If EstadoFiltro = 0 Then
      Let Me.Caption = "Marca de Créditos y Derivados. << VISTA : OPERACIONES NO RELACIONADAS >>"
      Let TXTNomCliente_Der.Enabled = True
      Let CMBMoneda_Der.Enabled = True
   Else
      Let Me.Caption = "Marca de Créditos y Derivados. << VISTA : OPERACIONES RELACIONADAS >>"
      Let TXTNomCliente_Der.Text = "": Let TXTNomCliente_Der.Enabled = False
      Let CMBMoneda_Der.ListIndex = 0: Let CMBMoneda_Der.Enabled = False
      Let LBLRut_Der.Caption = ""
      Let LBLCodigo_Der.Caption = ""
   End If

   DoEvents: DoEvents: DoEvents: DoEvents: DoEvents

   Let Toolbar1.Buttons(5).Enabled = IIf(EstadoFiltro = 0, False, True)
   
   Let FRACre.Enabled = False
   Let FRADer.Enabled = False
   Let SSPanelmensaje.Visible = True
   DoEvents: DoEvents: DoEvents: DoEvents: DoEvents

   Call FUNC_CARGA_CREDITOS
   Call FUNC_CARGA_DERIVADOS

   DoEvents: DoEvents: DoEvents: DoEvents: DoEvents
   Let FRACre.Enabled = True
   Let FRADer.Enabled = True
   Let SSPanelmensaje.Visible = False

End Function

Private Sub Toolbar1_ButtonMenuClick(ByVal ButtonMenu As MSComctlLib.ButtonMenu)
   Select Case ButtonMenu.Index
      Case 1
         Let EstadoFiltro = 0 '--> No Relacionados
      Case 2
         Let EstadoFiltro = 1 '--> Relacionados
   End Select

   Call FUNC_BUSCAR
End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)

   Let FRACre.Enabled = False
   Let FRADer.Enabled = False
   Let SSPanelmensaje.Visible = True
   DoEvents: DoEvents: DoEvents: DoEvents: DoEvents
   
   Call FUNC_CARGA_CREDITOS
   
   DoEvents: DoEvents: DoEvents: DoEvents: DoEvents
   Let FRACre.Enabled = True
   Let FRADer.Enabled = True
   Let SSPanelmensaje.Visible = False

End Sub
Private Sub Toolbar3_ButtonClick(ByVal Button As MSComctlLib.Button)

   Let FRACre.Enabled = False
   Let FRADer.Enabled = False
   Let SSPanelmensaje.Visible = True
   DoEvents: DoEvents: DoEvents: DoEvents: DoEvents

   Call FUNC_CARGA_DERIVADOS

   DoEvents: DoEvents: DoEvents: DoEvents: DoEvents
   Let FRACre.Enabled = True
   Let FRADer.Enabled = True
   Let SSPanelmensaje.Visible = False

End Sub

Private Sub TXTNomCliente_Cre_DblClick()
   'Let BacAyuda.Tag = "MDCL"
   'Call BacAyuda.Show(vbModal)
   'Arm Se implemta nuevo formulario ayuda
   BacAyudaCliente.Tag = "MDCL"
   Call BacAyudaCliente.Show(vbModal)
   If giAceptar = True Then
      Let TXTNomCliente_Cre.Text = gsDescripcion$
      Let LBLRut_Cre.Caption = Val(gsrut$) & "-" & gsDigito$
      Let LBLCodigo_Cre.Caption = gsValor$
   End If
End Sub

Private Sub TXTNomCliente_Cre_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyDelete Then
      Let TXTNomCliente_Cre.Text = ""
      Let LBLRut_Cre.Caption = ""
      Let LBLCodigo_Cre.Caption = ""
   End If
End Sub

Private Sub TXTNomCliente_Der_DblClick()
   'Let BacAyuda.Tag = "MDCL"
   'Call BacAyuda.Show(vbModal)
   'Arm Se implemta nuevo formulario ayuda
   BacAyudaCliente.Tag = "MDCL"
   Call BacAyudaCliente.Show(vbModal)

   If giAceptar = True Then
      Let TXTNomCliente_Der.Text = gsDescripcion$
      Let LBLRut_Der.Caption = Val(gsrut$) & "-" & gsDigito$
      Let LBLCodigo_Der.Caption = gsValor$
   End If
End Sub

Private Sub AJObjeto(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next
   Let Objeto.Top = Marco.CellTop + Marco.Top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth
   On Error GoTo 0
End Sub

Private Sub TXTNomCliente_Der_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyDelete Then
      Let TXTNomCliente_Der.Text = ""
      Let LBLRut_Der.Caption = ""
      Let LBLCodigo_Der.Caption = ""
   End If
End Sub

Private Function FUNC_VALIDA_CREDITO(ByVal nNumeroCredito As Long) As Boolean
   Dim nNumderivado  As Long
   Dim Datos()

   Let FUNC_VALIDA_CREDITO = False

   Envia = Array()
   AddParam Envia, nNumeroCredito
   If Not Bac_Sql_Execute("dbo.SP_VALIDA_ASOCIASION_DERIVADOS", Envia) Then
      Call MsgBox("Se ha generado un error en la validación de Créditos.", vbExclamation, App.Title)
      Exit Function
   End If

   If Bac_SQL_Fetch(Datos()) Then

      If Datos(1) < 0 Then

         If EstadoFiltro = 0 Then
            Call MsgBox(Datos(2), vbExclamation, App.Title)
            Exit Function
         Else
            
            Let nNumderivado = GRID_Cre.TextMatrix(GRID_Cre.RowSel, Grd1_nDeriv)
            If nNumderivado = 0 Then
               Exit Function
            End If
            Call FUNC_CARGA_DERIVADOS
            
            Exit Function
         End If

      End If
   End If

   Let FUNC_VALIDA_CREDITO = True
End Function

Private Sub GRID_Cre_DblClick()

   If GRID_Cre.Rows = GRID_Cre.FixedRows Then
      Exit Sub
   End If

   If EstadoFiltro = 0 Then
      If FUNC_VALIDA_CREDITO(GRID_Cre.TextMatrix(GRID_Cre.RowSel, 1)) = True Then
         Call FUNC_PINTA_GRILLA(GRID_Cre, GRID_Cre.RowSel)
      End If
   End If

End Sub

Private Function FUNC_DELETE_RELACION(ByVal nDerivado As Long, ByVal nCredito As Long)
   Dim SQLDatos()
   
   Envia = Array()
   AddParam Envia, nCredito
   AddParam Envia, nDerivado
   If Not Bac_Sql_Execute("dbo.SP_ELIMINA_RELACION", Envia) Then
      Call MsgBox("Se ha producido un error en la desvinculación entre crédito y derivado.", vbExclamation, App.Title)
      Exit Function
   End If
   Do While Bac_SQL_Fetch(SQLDatos())
      Call SendMail(SQLDatos(1), SQLDatos(2), SQLDatos(3), SQLDatos(4))
   Loop

End Function

Private Function FUNC_PINTA_GRILLA(ByRef xGrilla As MSFlexGrid, ByVal nFila As Long)
    Dim nFilas     As Long
    Dim nColumnas  As Long
    Dim nBACKCOLOR As Variant
    Dim nFONTCOLOR As Variant
    
    Let nBACKCOLOR = &H8000000F
    Let nFONTCOLOR = &H80000008
    
    Let xGrilla.Redraw = False
    
    Let xGrilla.Row = nFila
    
    If xGrilla.TextMatrix(xGrilla.RowSel, Grd1_xMarca) = "S" Then
        Let xGrilla.Row = xGrilla.RowSel
        Let xGrilla.TextMatrix(xGrilla.RowSel, Grd1_xMarca) = ""
        
        For nColumnas = 0 To xGrilla.Cols - 1
           Let xGrilla.Col = nColumnas
           Let xGrilla.CellBackColor = nBACKCOLOR
           Let xGrilla.CellForeColor = nFONTCOLOR
        Next nColumnas
        
        Let xGrilla.Redraw = True
        Exit Function
    End If


    '
    '   Validar
    '
    Dim nRowSelCre, nRowSelDer, i  As Integer

    If xGrilla.Name = "GRID_Cre" Then
        nRowSelCre = 0
        nRowSelDer = 0
        For i = 1 To GRID_Der.Rows - 1
            If GRID_Der.TextMatrix(i, Grd1_xMarca) = "S" Then nRowSelDer = nRowSelDer + 1
        Next
        
        For i = 1 To xGrilla.Rows - 1
            If xGrilla.TextMatrix(i, Grd1_xMarca) = "S" Then nRowSelCre = nRowSelCre + 1
        Next
        
        If nRowSelDer > 1 And nRowSelCre >= 1 Then
            xGrilla.Redraw = True
            Exit Function
        End If
    End If
    
    If xGrilla.Name = "GRID_Der" Then
        nRowSelCre = 0
        nRowSelDer = 0
        For i = 1 To GRID_Cre.Rows - 1
            If GRID_Cre.TextMatrix(i, Grd1_xMarca) = "S" Then nRowSelCre = nRowSelCre + 1
        Next
        
        For i = 1 To xGrilla.Rows - 1
            If xGrilla.TextMatrix(i, Grd1_xMarca) = "S" Then nRowSelDer = nRowSelDer + 1
        Next
        
        If nRowSelDer >= 1 And nRowSelCre > 1 Then
            xGrilla.Redraw = True
            Exit Function
        End If
    End If
    

'   For nFilas = 1 To xGrilla.Rows - 1
'      If xGrilla.TextMatrix(nFilas, Grd1_xMarca) = "S" Then
'         Let xGrilla.Row = nFilas
'         Let xGrilla.TextMatrix(nFilas, Grd1_xMarca) = ""
'
'         For nColumnas = 0 To xGrilla.Cols - 1
'            Let xGrilla.Col = nColumnas
'            Let xGrilla.CellBackColor = nBACKCOLOR
'            Let xGrilla.CellForeColor = nFONTCOLOR
'         Next nColumnas
'         Exit For
'      End If
'   Next nFilas

   
   Let nBACKCOLOR = &H8000000D
   Let nFONTCOLOR = &H8000000E
   
   Let xGrilla.TextMatrix(nFila, Grd1_xMarca) = "S"

   For nColumnas = 0 To xGrilla.Cols - 1
      Let xGrilla.Col = nColumnas
      Let xGrilla.CellBackColor = nBACKCOLOR
      Let xGrilla.CellForeColor = nFONTCOLOR
   Next nColumnas

   Let xGrilla.Redraw = True
End Function


Private Function FUNC_GRABAR_RELACION()
   Dim nContador     As Long
   Dim nCredito      As Long
   Dim nDerivado     As Long
   Dim xModulo       As String
   Dim xProducto     As String
   Dim xAjusteNoc    As String
   Dim Estado        As Integer
   Dim nRutClinete   As Long
   Dim nCodCliente   As Integer
   Dim SQLDatos()

   Let Screen.MousePointer = vbHourglass
   
   For nContador = 1 To GRID_Cre.Rows - 1
      If GRID_Cre.TextMatrix(nContador, Grd1_xMarca) = "S" Then
         Let nCredito = GRID_Cre.TextMatrix(nContador, Grd1_NumCre)
         Exit For
      End If
   Next nContador
   
   For nContador = 1 To GRID_Der.Rows - 1
      If GRID_Der.TextMatrix(nContador, Grd2_xMarca) = "S" Then
         Let nDerivado = GRID_Der.TextMatrix(nContador, Grd2_NumDer)
         Let xModulo = GRID_Der.TextMatrix(nContador, Grd2_Modulo)
         Let xProducto = CDbl(Trim(Right(GRID_Der.TextMatrix(nContador, Grd2_Produc), 50)))
         Let xAjusteNoc = GRID_Der.TextMatrix(nContador, Grd2_AjuNoc)
         Let nRutClinete = Mid(GRID_Der.TextMatrix(nContador, Grd2_RutCli), 1, Len(GRID_Der.TextMatrix(nContador, Grd2_RutCli)) - 2)
         Let nCodCliente = GRID_Der.TextMatrix(nContador, Grd2_CodCli)

         Exit For
      End If
   Next nContador
   
   If nCredito = 0 And nDerivado = 0 Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("No se ha encontrado relación entre Crédito y Derivado.", vbExclamation, App.Title)
      Exit Function
   End If
   If nCredito = 0 Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("No se ha encontrado Crédito seleccionado.", vbExclamation, App.Title)
      Exit Function
   End If
   If nDerivado = 0 Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("No se ha encontrado Crédito seleccionado.", vbExclamation, App.Title)
      Exit Function
   End If
   
   Envia = Array()
   AddParam Envia, nCredito
   AddParam Envia, nDerivado
   AddParam Envia, xModulo
   AddParam Envia, xProducto
   AddParam Envia, xAjusteNoc
   AddParam Envia, 0
   AddParam Envia, nRutClinete
   AddParam Envia, nCodCliente
   If Not Bac_Sql_Execute("dbo.SP_RELACION_CREDITO_DERIVADO", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha generado un error al crear la relación entre el Crédito y el Derivado.", vbExclamation, App.Title)
      Exit Function
   End If
   Do While Bac_SQL_Fetch(SQLDatos())
      Call SendMail(SQLDatos(1), SQLDatos(2), SQLDatos(3), SQLDatos(4))
   Loop

   Call FUNC_BUSCAR

   Call MsgBox("Se ha generado la relación entre Crédito N° :" & nCredito & " y Derivado N° :" & nDerivado, vbInformation, App.Title)

   Let Screen.MousePointer = vbDefault
End Function

Private Function SendMail(ByVal Contacto As String, ByVal Email As String, ByVal Mensaje As String, ByVal Firma As String)
   On Error Resume Next
   Dim Enviar      As Object
   Dim ObjCorreo   As Object

   Set ObjCorreo = CreateObject("Outlook.Application")
   Set Enviar = ObjCorreo.CreateItem(0)

   Enviar.To = Email
   Enviar.cc = ""
   Enviar.Subject = Mensaje
   Enviar.Body = "Estimado " & Contacto & "," & vbCrLf & vbTab & Mensaje & vbCrLf & vbCrLf & "Atte." & vbCrLf & Firma
   Enviar.Importance = 1
   Enviar.Send

   Set ObjCorreo = Nothing
   Set Enviar = Nothing

   On Error GoTo 0
End Function

