VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Begin VB.Form FRM_ASOCIA_GTIAS_OPER 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Asociación de Garantías con Operaciones Disponibles por Cliente"
   ClientHeight    =   9090
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   14280
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   9090
   ScaleWidth      =   14280
   Begin VB.Frame frmMarcaGtia 
      Caption         =   "Garantías Disp."
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
      Height          =   615
      Left            =   12120
      TabIndex        =   35
      Top             =   600
      Visible         =   0   'False
      Width           =   2055
      Begin VB.CommandButton cmbGtiasTodas 
         Caption         =   "Seleccionar Todas"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   36
         Top             =   240
         Width           =   1815
      End
   End
   Begin VB.Frame frmMarcaOper 
      Caption         =   "Operaciones Disp."
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
      Height          =   615
      Left            =   9960
      TabIndex        =   33
      Top             =   600
      Visible         =   0   'False
      Width           =   2055
      Begin VB.CommandButton cmbOpTodas 
         Caption         =   "Seleccionar Todas"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   34
         Top             =   240
         Width           =   1815
      End
   End
   Begin VB.Frame Frame12 
      Caption         =   "Men. F. Vcto. Gtías"
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
      Height          =   615
      Left            =   12240
      TabIndex        =   31
      Top             =   8400
      Width           =   1935
      Begin VB.Label lblmfGar 
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
         Height          =   255
         Left            =   120
         TabIndex        =   32
         Top             =   240
         Width           =   1575
      End
   End
   Begin VB.Frame Frame11 
      Caption         =   "May. F. Vcto. Op."
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
      Height          =   615
      Left            =   12240
      TabIndex        =   29
      Top             =   4350
      Width           =   1935
      Begin VB.Label lblMfOper 
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
         Height          =   255
         Left            =   120
         TabIndex        =   30
         Top             =   240
         Width           =   1695
      End
   End
   Begin VB.Frame Frame10 
      Caption         =   "Gtías. Marcadas"
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
      Height          =   3255
      Left            =   11160
      TabIndex        =   26
      Top             =   5040
      Width           =   3015
      Begin VB.ListBox ListGar 
         Columns         =   1
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   13322
            SubFormatType   =   1
         EndProperty
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
         Height          =   2790
         Left            =   120
         MultiSelect     =   1  'Simple
         TabIndex        =   28
         Top             =   360
         Width           =   2775
      End
   End
   Begin VB.Frame Frame9 
      Caption         =   "Oper. Marcadas"
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
      Height          =   3255
      Left            =   7920
      TabIndex        =   25
      Top             =   5040
      Width           =   3135
      Begin VB.ListBox ListOper 
         Columns         =   1
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
         Height          =   2790
         Left            =   120
         MultiSelect     =   1  'Simple
         TabIndex        =   27
         Top             =   360
         Width           =   2895
      End
   End
   Begin VB.Frame Frame8 
      Caption         =   "Total Actualizado Garantías"
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
      Height          =   615
      Left            =   7920
      TabIndex        =   23
      Top             =   8400
      Width           =   4215
      Begin VB.Label lblTotalGarantias 
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
         Height          =   255
         Left            =   120
         TabIndex        =   24
         Top             =   240
         Width           =   3975
      End
   End
   Begin VB.Frame Frame7 
      Caption         =   "Total diferencia Threshold MTM Operación"
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
      Height          =   615
      Left            =   7920
      TabIndex        =   21
      Top             =   4350
      Width           =   4215
      Begin VB.Label lblTotalOperacion 
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
         Height          =   255
         Left            =   120
         TabIndex        =   22
         Top             =   240
         Width           =   3975
      End
   End
   Begin VB.Frame Frame6 
      Caption         =   "Gtías. Asoc."
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
      Height          =   615
      Left            =   6360
      TabIndex        =   19
      Top             =   8400
      Width           =   1455
      Begin VB.Label lblGtiasAsoc 
         Alignment       =   1  'Right Justify
         Caption         =   "0"
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
         Height          =   255
         Left            =   240
         TabIndex        =   20
         Top             =   240
         Width           =   1095
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Oper. Asoc."
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
      Height          =   615
      Left            =   6360
      TabIndex        =   17
      Top             =   4350
      Width           =   1455
      Begin VB.Label lblOperAsoc 
         Alignment       =   1  'Right Justify
         Caption         =   "0"
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
         Height          =   255
         Left            =   120
         TabIndex        =   18
         Top             =   240
         Width           =   1215
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Gtías. Selecc."
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
      Height          =   615
      Left            =   4800
      TabIndex        =   15
      Top             =   8400
      Width           =   1455
      Begin VB.Label lblGtiasSel 
         Alignment       =   1  'Right Justify
         Caption         =   "0"
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
         Height          =   255
         Left            =   240
         TabIndex        =   16
         Top             =   240
         Width           =   1095
      End
   End
   Begin VB.Frame Frame3 
      Height          =   615
      Left            =   0
      TabIndex        =   13
      Top             =   8400
      Width           =   4695
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "[Enter]: Selecciona/Deselecciona Garantías"
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
         Height          =   195
         Left            =   120
         TabIndex        =   14
         Top             =   240
         Width           =   3795
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Oper. Selecc."
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
      Height          =   615
      Left            =   4800
      TabIndex        =   11
      Top             =   4350
      Width           =   1455
      Begin VB.Label lblOperSel 
         Alignment       =   1  'Right Justify
         Caption         =   "0"
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
         Height          =   255
         Left            =   240
         TabIndex        =   12
         Top             =   240
         Width           =   1095
      End
   End
   Begin VB.Frame Frame1 
      Height          =   615
      Left            =   0
      TabIndex        =   9
      Top             =   4350
      Width           =   4695
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "[Enter]: Selecciona/Deselecciona Operación"
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
         Height          =   195
         Left            =   120
         TabIndex        =   10
         Top             =   240
         Width           =   3825
      End
   End
   Begin VB.Frame frmGarantias 
      Caption         =   "Garantías Disponibles del Cliente"
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
      Height          =   3255
      Left            =   0
      TabIndex        =   7
      Top             =   5040
      Width           =   7815
      Begin MSFlexGridLib.MSFlexGrid grillaGtias 
         Height          =   2895
         Left            =   120
         TabIndex        =   8
         Top             =   240
         Width           =   7575
         _ExtentX        =   13361
         _ExtentY        =   5106
         _Version        =   393216
         Cols            =   5
         FixedCols       =   0
         BackColor       =   -2147483634
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   16777215
         ForeColorSel    =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Frame frmOperaciones 
      Caption         =   "Operaciones Disponibles del Cliente"
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
      Height          =   3015
      Left            =   0
      TabIndex        =   5
      Top             =   1320
      Width           =   14175
      Begin MSFlexGridLib.MSFlexGrid grillaOper 
         Height          =   2775
         Left            =   120
         TabIndex        =   6
         Top             =   240
         Width           =   13935
         _ExtentX        =   24580
         _ExtentY        =   4895
         _Version        =   393216
         Cols            =   9
         FixedCols       =   0
         BackColor       =   -2147483634
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   -2147483634
         BackColorSel    =   -2147483643
         ForeColorSel    =   8388608
         AllowBigSelection=   0   'False
         SelectionMode   =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   14280
      _ExtentX        =   25188
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      DisabledImageList=   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Asociar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   7
         EndProperty
      EndProperty
   End
   Begin VB.Frame frmUsuario 
      Caption         =   "Seleccione Cliente"
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
      Height          =   615
      Left            =   0
      TabIndex        =   0
      Top             =   600
      Width           =   9855
      Begin VB.TextBox txtCodCliente 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
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
         Left            =   1800
         MaxLength       =   3
         TabIndex        =   4
         Top             =   240
         Width           =   495
      End
      Begin VB.TextBox txtRutCliente 
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
         Left            =   120
         MaxLength       =   9
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   3
         Top             =   240
         Width           =   1575
      End
      Begin VB.TextBox txtNomCliente 
         BackColor       =   &H00FFFFFF&
         Enabled         =   0   'False
         Height          =   285
         Left            =   2400
         TabIndex        =   2
         Top             =   240
         Width           =   7335
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8520
      Top             =   360
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GTIAS_OPER.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GTIAS_OPER.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GTIAS_OPER.frx":11F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GTIAS_OPER.frx":20CE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GTIAS_OPER.frx":23E8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GTIAS_OPER.frx":32C2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GTIAS_OPER.frx":419C
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GTIAS_OPER.frx":44B6
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_ASOCIA_GTIAS_OPER"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public colorFore As Long
Public colorBack As Long
Public colSelec As Long
Public colFondo As Long
Public colFondg As Long
Public numOperSel As Long
Public numGtiaSel As Long
Public numOperAsoc As Long
Public numGtiaAsoc As Long
Public totalOperacion As Double
Public totalGarantias As Double
Public fVencOper As Date
Public MfOper As Date
Public mfGtia As Date
Public maxFecha As Date
Public minFecha As Date
Public cgOper As Long
Public cgGtias As Long
Private objCliente As Object

Private Sub cmbGtiasTodas_Click()
'Marcar todas las Garantías Disponibles
Dim estoy As Long
Dim i As Long
With grillaGtias
    estoy = .RowSel
    For i = 1 To .Rows - 1
        If Not FilaVacia(grillaGtias, i) Then
            Call MarcaGarantia(i)
        End If
    Next i
    .RowSel = estoy
End With
End Sub

Private Sub cmbOpTodas_Click()
'Marcar Todas las Operaciones Disponibles
Dim estoy As Long
Dim i As Long
With grillaOper
    estoy = .RowSel
    For i = 1 To .Rows - 1
        If Not FilaVacia(grillaOper, i) Then
            Call MarcaOperacion(i)
        End If
    Next i
    .RowSel = estoy
End With
End Sub

Private Sub Form_Load()
Me.Top = 0
Me.Left = 0
Set objCliente = New clsCliente
maxFecha = DateAdd("yyyy", 1000, Now)
minFecha = DateAdd("yyyy", -1000, Now)
colorFore = grillaOper.ForeColor
colorBack = grillaOper.BackColor
colSelec = &H40C0&
colFondo = &HFFFF80
colFondg = &HE0E0E0
Call FormateaGrillaOper
Call FormateaGrillaGtias
numOperSel = 0
numGtiaSel = 0
numOperAsoc = 0
numGtiaAsoc = 0
totalOperacion = 0#
totalGarantias = 0#
Toolbar1.Buttons(2).Enabled = False 'Asociar
Toolbar1.Buttons(3).Enabled = False 'Grabar
End Sub

Private Sub grillaGtias_DblClick()
Dim Fila As Long
    With grillaGtias
        If .Row = 0 Then
            Exit Sub
        End If
        Fila = .RowSel
        If FilaVacia(grillaGtias, Fila) Then
            Exit Sub
        End If
        If .TextMatrix(Fila, 0) = "Sí" Then
            Call DesmarcaGarantia(Fila)
        Else
            MarcaGarantia (Fila)
        End If
    End With
End Sub
Private Sub grillaGtias_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Call grillaGtias_DblClick
    End If
End Sub
Private Sub grillaOper_DblClick()
Dim Fila As Long
    With grillaOper
        Fila = .RowSel
        If FilaVacia(grillaOper, Fila) Then
            txtRutCliente.SetFocus
            Exit Sub
        End If
        If .TextMatrix(Fila, 0) = "Sí" Then
            Call DesmarcaOperacion(Fila)
        Else
            Call MarcaOperacion(Fila)
        End If
    End With
End Sub
Private Function MarcaGarantia(ByVal xfila As Long) As Boolean
Dim fVencGtia As Date
    With grillaGtias
'        If Trim(.TextMatrix(xfila, 1)) <> "" Then
'            MsgBox "La Garantía ya está asociada!", vbExclamation, TITSISTEMA
'            Exit Function
'        End If
        If .TextMatrix(xfila, 0) = "Sí" Then
            MsgBox "La Garantía ya estaba marcada!", vbInformation, TITSISTEMA
            Exit Function
        End If
        If numOperSel = 0 Then
            MsgBox "Aún no se han marcado Operaciones a Asociar!", vbInformation, TITSISTEMA
            Exit Function
        End If
'        fVencGtia = CDate(.TextMatrix(xfila, 5))
'        If fVencGtia < fVencOper Then
'            MsgBox "La fecha de Vencimiento de la Garantía no puede ser menor a la fecha de vencimiento de la Operación!", vbExclamation, TITSISTEMA
'            Exit Function
'        End If
        .TextMatrix(xfila, 0) = "Sí"
        If numGtiaSel = 0 Then
            mfGtia = CDate(.TextMatrix(xfila, 4))
        Else
            If CDate(.TextMatrix(xfila, 4)) < mfGtia Then
                mfGtia = CDate(.TextMatrix(xfila, 4))
            End If
        End If
        lblmfGar.Caption = CStr(mfGtia)
        Call AgregaGtiaLista(xfila)
    End With
    numGtiaSel = numGtiaSel + 1
    
    totalGarantias = totalGarantias + CDbl(grillaGtias.TextMatrix(xfila, 3))
    
    If totalGarantias >= totalOperacion Then
        lblTotalGarantias.ForeColor = &H800000      'vbBlue
    Else
        lblTotalGarantias.ForeColor = vbRed
    End If
    
    lblTotalGarantias.Caption = Format(totalGarantias, FDecimal)
    
    lblGtiasSel.Caption = Format(numGtiaSel, FEntero)
    
    Call PintaFila(grillaGtias, xfila, colSelec, colFondg)
End Function
Private Function MarcaOperacion(ByVal xfila As Long) As Boolean
    With grillaOper
'        If Trim(.TextMatrix(xfila, 1)) <> "" Then
'            MsgBox "La operación ya está asociada a una garantía!", vbExclamation, TITSISTEMA
'            Exit Function
'        End If
        If .TextMatrix(xfila, 0) = "Sí" Then
            MsgBox "La operación ya estaba marcada!", vbInformation, TITSISTEMA
            Exit Function
        End If
'        If numOperSel = 1 Then
'            MsgBox "Ya hay una Operación seleccionada para asociarle Garantías!", vbExclamation, TITSISTEMA
'            Exit Function
'        End If
        .TextMatrix(xfila, 0) = "Sí"
        
        If numOperSel = 0 Then
            MfOper = CDate(.TextMatrix(xfila, 6))
        Else
            If CDate(.TextMatrix(xfila, 6)) > MfOper Then
                MfOper = CDate(.TextMatrix(xfila, 6))
            End If
        End If
        lblMfOper.Caption = CStr(MfOper)
        
        
        fVencOper = CDate(.TextMatrix(xfila, 6))
        Call AgregaOperLista(xfila)
'        ListOper.AddItem (.TextMatrix(xfila, 2) & " - " & .TextMatrix(xfila, 3))
    End With
    numOperSel = numOperSel + 1
    
    If Trim(grillaOper.TextMatrix(xfila, 9)) = "" Then
        totalOperacion = 0
    Else
        totalOperacion = CDbl(grillaOper.TextMatrix(xfila, 9))
    End If
    
    lblTotalOperacion.Caption = Format(totalOperacion, FDecimal)
    
    lblOperSel.Caption = Format(numOperSel, FEntero)
    Call PintaFila(grillaOper, xfila, colSelec, colFondo)    'colorBack)
End Function
Private Function AgregaOperLista(ByVal Fila As Long)
'Revisar ListOper por si no está ya la operación
Dim i As Long, n As Long
Dim Dato As String
Dim esta As Boolean
esta = False
n = ListOper.ListCount
Dato = grillaOper.TextMatrix(Fila, 1) & " - " & grillaOper.TextMatrix(Fila, 2)
For i = 0 To n - 1
    If ListOper.List(i) = Dato Then
        esta = True
        Exit For
    End If
Next i
If Not esta Then
    ListOper.AddItem (Dato)
End If
End Function
Private Function AgregaGtiaLista(ByVal Fila As Long)
'Revisar ListGar por si no está ya la operación
Dim i As Long, n As Long
Dim Dato As String
Dim esta As Boolean
esta = False
n = ListGar.ListCount
Dato = Space(8) & grillaGtias.TextMatrix(Fila, 1)
For i = 0 To n - 1
    If Trim(ListGar.List(i)) = Trim(Dato) Then
        esta = True
        Exit For
    End If
Next i
If Not esta Then
    ListGar.AddItem (Dato)
End If
End Function
Private Function SacaOperLista(ByVal Fila As Long)
Dim i As Long, n As Long, p As Long
Dim Dato As String
Dato = grillaOper.TextMatrix(Fila, 1) & " - " & grillaOper.TextMatrix(Fila, 2)
n = ListOper.ListCount
p = -1
For i = 0 To n - 1
    If ListOper.List(i) = Dato Then
        p = i
        Exit For
    End If
Next i
If p > -1 Then
    ListOper.RemoveItem (p)
End If
End Function
Private Function SacaGtiaLista(ByVal Fila As Long)
Dim i As Long, n As Long, p As Long
Dim Dato As String
Dato = Trim(grillaGtias.TextMatrix(Fila, 1))
n = ListGar.ListCount
p = -1
For i = 0 To n - 1
    If Trim(ListGar.List(i)) = Trim(Dato) Then
        p = i
        Exit For
    End If
Next i
If p > -1 Then
    ListGar.RemoveItem (p)
End If
End Function
Private Function DesmarcaGarantia(ByVal xfila As Long) As Boolean
    With grillaGtias
'        If Trim(.TextMatrix(xfila, 1)) <> "" Then
'            MsgBox "La Garantía ya está asociada a una Operación!", vbExclamation, TITSISTEMA
'            Exit Function
'        End If
        If .TextMatrix(xfila, 0) = "No" Then
            MsgBox "La Garantía no está marcada!", vbInformation, TITSISTEMA
            Exit Function
        End If
        '¿La fecha de vencimiento es igual a mfGtia?
        If CDate(.TextMatrix(xfila, 4)) = mfGtia Then
            'Determinar mfGtia entre los restantes movimientos, si los hay
            'si no hay movimientos, dejar mfGtia = maxFecha
            If numGtiaSel = 1 Then
                'si no hay movimientos, dejar mfGtia = maxFecha
                mfGtia = maxFecha
                lblmfGar.Caption = ""
            Else
                mfGtia = BuscaMenorFechaGtia(xfila)
                lblmfGar.Caption = CStr(mfGtia)
            End If
        End If
        'lblmfGar.Caption = CStr(mfGtia)
        .TextMatrix(xfila, 0) = "No"
        Call SacaGtiaLista(xfila)
    End With
    numGtiaSel = numGtiaSel - 1
    
    If totalGarantias >= totalOperacion Then
        lblTotalGarantias.ForeColor = &H800000         'vbBlue
    Else
        lblTotalGarantias.ForeColor = vbRed
    End If

    totalGarantias = totalGarantias - CDbl(grillaGtias.TextMatrix(xfila, 3))
    
    lblTotalGarantias.Caption = Format(totalGarantias, FDecimal)
    lblGtiasSel.Caption = Format(numGtiaSel, FEntero)
    Call PintaFila(grillaGtias, xfila, colorFore, colorBack)
End Function
Private Function BuscaMenorFechaGtia(ByVal filaex As Long) As Date
Dim i As Long, n As Long
Dim menorFecha As Date
menorFecha = maxFecha
With grillaGtias
    n = .Rows
    For i = 1 To n - 1
        If .TextMatrix(i, 0) = "Sí" Then
            If i <> filaex Then
                If CDate(.TextMatrix(i, 4)) < menorFecha Then
                    menorFecha = CDate(.TextMatrix(i, 4))
                End If
            End If
        End If
    Next i
End With
BuscaMenorFechaGtia = menorFecha
End Function
Private Function BuscaMayorFechaOper(ByVal filaex As Long) As Date
Dim i As Long, n As Long
Dim mayorFecha As Date
mayorFecha = minFecha
With grillaOper
    n = .Rows
    For i = 1 To n - 1
        If .TextMatrix(i, 0) = "Sí" Then
            If i <> filaex Then
                If CDate(.TextMatrix(i, 6)) > mayorFecha Then
                    mayorFecha = CDate(.TextMatrix(i, 6))
                End If
            End If
        End If
    Next i
End With
BuscaMayorFechaOper = mayorFecha
End Function
Private Function BuscaMenorFechaOper(ByVal filaex As Long) As Date
Dim i As Long, n As Long
Dim menorFecha As Date
menorFecha = maxFecha
With grillaOper
    n = .Rows
    For i = 1 To n - 1
        If .TextMatrix(i, 0) = "Sí" Then
            If i <> filaex Then
                If CDate(.TextMatrix(i, 6)) < menorFecha Then
                    menorFecha = CDate(.TextMatrix(i, 6))
                End If
            End If
        End If
    Next i
End With
BuscaMenorFechaOper = menorFecha
End Function
Private Function DesmarcaOperacion(ByVal xfila As Long) As Boolean
    With grillaOper
'        If Trim(.TextMatrix(xfila, 1)) <> "" Then
'            MsgBox "La operación ya está asociada a una garantía!", vbExclamation, TITSISTEMA
'            Exit Function
'        End If
        If .TextMatrix(xfila, 0) = "No" Then
            MsgBox "La operación no está marcada!", vbInformation, TITSISTEMA
            Exit Function
        End If
        
        '¿La fecha de vencimiento es igual a mfOper?
        If CDate(.TextMatrix(xfila, 6)) = MfOper Then
            'Determinar mfOper entre los restantes movimientos, si los hay
            'si no hay movimientos, dejar mfOper = maxFecha
            If numOperSel = 1 Then
                'si no hay movimientos, dejar mfOper = maxFecha
                MfOper = maxFecha
                lblMfOper.Caption = ""
            Else
                MfOper = BuscaMayorFechaOper(xfila)
                lblMfOper.Caption = CStr(MfOper)
            End If
        End If
        'lblmfOper.Caption = CStr(mfOper)
        
        .TextMatrix(xfila, 0) = "No"
        Call SacaOperLista(xfila)
    End With
    numOperSel = numOperSel - 1
    lblOperSel.Caption = Format(numOperSel, FEntero)
    totalOperacion = 0
    lblTotalOperacion.Caption = Format(0, FDecimal)
    Call PintaFila(grillaOper, xfila, colorFore, colorBack)
End Function
Private Sub grillaOper_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Call grillaOper_DblClick
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        Call Limpiar
    Case 2
        Call Asociar
    Case 3
        Call Grabar
    Case 4
        Unload Me
End Select
End Sub
Private Sub Grabar()
If ListOper.ListCount = 0 Then
    MsgBox "No hay operaciones marcadas para grabar!", vbExclamation, TITSISTEMA
    Exit Sub
End If
If ListGar.ListCount = 0 Then
    MsgBox "No hay garantías marcadas para grabar!", vbExclamation, TITSISTEMA
    Exit Sub
End If
Dim folioAsocia As Long
Dim i As Long, j As Long
'Primero, generar el nuevo folio de tbl_Parametros_Gral_Garantias
folioAsocia = NuevoFolioAsocia()
If folioAsocia = -1 Then
    MsgBox "Se ha producido un error en la generación del folio de asociación!", vbExclamation, TITSISTEMA
    Exit Sub
End If
'Primero, grabar las operaciones asociadas
If Not GrabaOpAsociadas(folioAsocia) Then
    MsgBox "Se ha producido un error al grabar Operaciones asociadas a Garantías, folio N° " & CStr(folioAsocia), vbExclamation, TITSISTEMA
    Exit Sub
End If
If Not GrabaGarAsociadas(folioAsocia) Then
    MsgBox "Se ha producido un error al grabar Garantías asociadas a Operaciones, folio N° " & CStr(folioAsocia), vbExclamation, TITSISTEMA
    Exit Sub
End If
MsgBox "La asociación de Operaciones y Garantías se ha grabado exitosamente!", vbInformation, TITSISTEMA
Call Limpiar
End Sub
Private Function NuevoFolioAsocia() As Long
Dim nomSp As String
Dim Dato As String
Dato = ""
nomSp = "Bacparamsuda.dbo.SP_GAR_FOLIOASOCIACION"
Dim Datos()
If Not Bac_Sql_Execute(nomSp) Then
    NuevoFolioAsocia = -1
    Exit Function
End If
If Bac_SQL_Fetch(Datos()) Then
    Dato = Datos(1)
End If
If IsNull(Dato) Or Dato = "" Then
    NuevoFolioAsocia = -1
    Exit Function
End If
NuevoFolioAsocia = CLng(Dato)
End Function
Private Function GrabaOpAsociadas(ByVal folio As Long) As Boolean
Dim i As Long
Dim falla As Long
Dim NumOper As String
Dim Numero As String
Dim Tipo As String
falla = 0
For i = 0 To ListOper.ListCount - 1
    NumOper = ListOper.List(i)
    Tipo = Mid$(NumOper, 1, 3)
    Numero = Mid$(NumOper, 7)
    If Not GrabaOperAsoc(folio, Tipo, Numero) Then
        falla = falla + 1
        Exit For
    End If
Next i
If falla > 0 Then
    GrabaOpAsociadas = False
Else
    GrabaOpAsociadas = True
End If
End Function
Function GrabaOperAsoc(ByVal folio As Long, ByVal tipoOp As String, ByVal numOp As String) As Boolean
Dim nomSp As String
nomSp = " BacParamsuda.dbo.SP_GAR_GRABAOPERASOC"
Dim Datos()
Envia = Array()
AddParam Envia, folio
AddParam Envia, tipoOp
AddParam Envia, CDbl(numOp)
AddParam Envia, CDbl(txtRutCliente.Text)
AddParam Envia, CDbl(txtCodCliente.Text)
If Not Bac_Sql_Execute(nomSp, Envia) Then
    GrabaOperAsoc = False
    Exit Function
End If
GrabaOperAsoc = True
End Function
Function GrabaGarAsoc(ByVal folio As Long, ByVal numGar As String) As Boolean
Dim nomSp As String
nomSp = " BacParamsuda.dbo.SP_GAR_GRABAGARASOC"
Dim Datos()
Envia = Array()
AddParam Envia, folio
AddParam Envia, CDbl(numGar)
AddParam Envia, CDbl(txtRutCliente.Text)
AddParam Envia, CDbl(txtCodCliente.Text)
If Not Bac_Sql_Execute(nomSp, Envia) Then
    GrabaGarAsoc = False
    Exit Function
End If
GrabaGarAsoc = True
End Function
Private Function GrabaGarAsociadas(ByVal folio As Long) As Boolean
Dim i As Long
Dim falla As Long
Dim numGar As String
falla = 0
For i = 0 To ListGar.ListCount - 1
    numGar = Trim(ListGar.List(i))
    If Not GrabaGarAsoc(folio, numGar) Then
        falla = falla + 1
        Exit For
    End If
Next i
If falla > 0 Then
    GrabaGarAsociadas = False
Else
    GrabaGarAsociadas = True
End If


End Function
Private Sub Grabar_old()
'Validar primero, para cada operación, si el total de garantías asociado cubre el REC ajustado de la operación
'Recorrer las garantías asociadas
Dim i As Integer
Dim j As Integer
Dim nNumOp As String
Dim tipoOp As String
Dim numOp As Long
Dim numGtia As String
Dim listaGtiasGrabadas As String
For i = 1 To grillaGtias.Rows - 1
    numGtia = grillaGtias.TextMatrix(i, 2)
    If InStr(listaGtiasGrabadas, numGtia) = 0 Then
    'Si la garantia no está en la lista de las grabadas, procesar
        If Trim(grillaGtias.TextMatrix(i, 1)) <> "" Then
            nNumOp = grillaGtias.TextMatrix(i, 1)
            tipoOp = Mid(nNumOp, 1, 3)
            numOp = CLng(Mid(nNumOp, 4))
            If GrabaGtiaOper(tipoOp, numOp, numGtia) Then
                listaGtiasGrabadas = listaGtiasGrabadas & "-" & numGtia
            End If
        End If
    End If
Next i
'Recargar las grillas con el mismo cliente
Call LlenaGrillaOper
Call LLenaGrillaGtias
End Sub
Private Function GrabaGtiaOper(ByVal Tipo As String, ByVal xOper As Long, xGtia As String) As Boolean
Dim Datos()
Envia = Array()
AddParam Envia, CLng(xGtia)
AddParam Envia, CLng(txtRutCliente.Text)
AddParam Envia, CInt(txtCodCliente.Text)
AddParam Envia, Tipo
AddParam Envia, xOper
If Bac_Sql_Execute("Bacparamsuda..SP_GRABAOPERGARANTIAS", Envia) Then
    GrabaGtiaOper = True
Else
    GrabaGtiaOper = False
End If
End Function
Private Sub Asociar()
'Revisar si hay grillas de operaciones marcadas
Dim i As Long
Dim j As Long
Dim marcOper As Long
Dim marcGtia As Long
Dim numOperacion As String
Dim posOperacion As Long
Dim fVencGtia As Date
marcOper = 0
marcGtia = 0
For i = 1 To grillaOper.Rows - 1
    If grillaOper.TextMatrix(i, 0) = "Sí" Then
        numOperacion = grillaOper.TextMatrix(i, 1) & " " & grillaOper.TextMatrix(i, 2)
        posOperacion = i
        fVencOper = CDate(grillaOper.TextMatrix(i, 6))
        marcOper = marcOper + 1
    End If
Next i
If marcOper = 0 Then
    'bloquear grabar
    Toolbar1.Buttons(3).Enabled = False
    MsgBox "No hay Operaciones marcadas para asociar a Garantías!", vbExclamation, TITSISTEMA
    Exit Sub
End If
For j = 1 To grillaGtias.Rows - 1
    If grillaGtias.TextMatrix(j, 0) = "Sí" Then
        marcGtia = marcGtia + 1
    End If
Next j
If marcGtia = 0 Then
    'bloquear grabar
    Toolbar1.Buttons(3).Enabled = False
    MsgBox "No hay Garantías marcadas para asociar a Operaciones!", vbExclamation, TITSISTEMA
    Exit Sub
End If
If mfGtia < MfOper Then
    MsgBox "No es posible Asociar! Hay operaciones que vencen después de la menor fecha de vencimiento de las Garantías!", vbExclamation, TITSISTEMA
    Exit Sub
End If
If totalGarantias < totalOperacion Then
    MsgBox "Atención!, el monto total de las Garantías asociadas no alcanza para cubrir la Operación.", vbExclamation, TITSISTEMA
    Exit Sub
End If
Toolbar1.Buttons(2).Enabled = False
Toolbar1.Buttons(3).Enabled = True
'Bloquear las grillas.  Se usará el contenido de ListOper y ListGar para el intercambio
grillaGtias.Enabled = False
grillaOper.Enabled = False
For j = 0 To ListOper.ListCount - 1
    ListOper.Selected(j) = True
Next j
For j = 0 To ListGar.ListCount - 1
    ListGar.Selected(j) = True
Next j
lblOperAsoc.Caption = Format(ListOper.ListCount, FEntero)
lblGtiasAsoc.Caption = Format(ListGar.ListCount, FEntero)
lblTotalOperacion.Caption = Format(totalOperacion, FDecimal)
lblTotalGarantias.Caption = Format(totalGarantias, FDecimal)
txtRutCliente.Enabled = False
frmMarcaGtia.Visible = False
frmMarcaOper.Visible = False
MsgBox "La(s) operación(es) seleccionada(s) se encuentra(n) asociada(s) a la(s) garantía(s)!", vbInformation, TITSISTEMA
End Sub

Private Sub txtCodCliente_KeyPress(KeyAscii As Integer)

    If KeyAscii = vbKeyReturn Then
        Call txtCodCliente_LostFocus
        Exit Sub
    End If
    
    If Not (KeyAscii > 47 And KeyAscii < 58 Or KeyAscii = 8) Then
        KeyAscii = 0
        BacCaracterNumerico KeyAscii
    End If
    
End Sub

Private Sub txtCodCliente_LostFocus()
    
    If Trim(txtRutCliente.Text) = "" Then
        Exit Sub
    End If
    
    If Trim(Me.txtCodCliente.Text) = "" Then
        Exit Sub
    End If
    
    objCliente.clrut = txtRutCliente.Text
    objCliente.clcodigo = txtCodCliente.Text
    
    If objCliente.LeerPorRut(objCliente.clrut, objCliente.clcodigo) Then
    
        txtNomCliente.Text = objCliente.clnombre
        
        Call LlenaGrillaOper
        Call LLenaGrillaGtias
        If cgOper > 0 And cgGtias > 0 Then
            frmMarcaGtia.Visible = True
            frmMarcaOper.Visible = True
        Else
            frmMarcaGtia.Visible = False
            frmMarcaOper.Visible = False
        End If
        
        txtRutCliente.Enabled = False
        txtCodCliente.Enabled = False
          
    Else
    
        MsgBox "Atención!, el cliente buscado no existe.", vbExclamation, TITSISTEMA
        txtRutCliente.Text = ""
        txtCodCliente.Text = ""
        txtNomCliente.Text = ""
        txtRutCliente.SetFocus
        Exit Sub
        
    End If
    
End Sub

Private Sub txtRutCliente_DblClick()
    'BacAyuda.Tag = "MDCL"
    'BacAyuda.Show 1
    'Arm Se implemnta nuevo formulario ayuda
    BacAyudaCliente.Tag = "MDCL"
    BacAyudaCliente.Show 1
    
    If giAceptar% = True Then
        Call Limpiar
        txtRutCliente.Text = Val(gsrut$)
        txtCodCliente.Text = gsValor$
        txtNomCliente.Text = gsDescripcion$
        
        Call txtCodCliente_LostFocus
    End If

End Sub
Private Sub FormateaGrillaGtias()
With grillaGtias
.FixedRows = 1
    .ColWidth(0) = 500
    .ColWidth(1) = 1200
    .ColWidth(2) = 1400
    .ColWidth(3) = 2800
    .ColWidth(4) = 1400
    
    .FixedAlignment(0) = flexAlignLeft
    .FixedAlignment(1) = flexAlignRight
    .FixedAlignment(2) = flexAlignLeft
    .FixedAlignment(3) = flexAlignRight
    .FixedAlignment(4) = flexAlignRight
    
    .TextMatrix(0, 0) = "Asoc."
    .TextMatrix(0, 1) = "N° Gtía."
    .TextMatrix(0, 2) = "Fecha Const."
    .TextMatrix(0, 3) = "Total Actualizado"
    .TextMatrix(0, 4) = "Fecha Vcto."
End With
End Sub
Private Sub FormateaGrillaOper()
With grillaOper
    .Cols = 11
    .FixedRows = 1
    .ColWidth(0) = 500
    '.ColWidth(1) = 1000
    .ColWidth(1) = 800
    .ColWidth(2) = 1200
    .ColWidth(3) = 800
    .ColWidth(4) = 2500
    .ColWidth(5) = 1200
    .ColWidth(6) = 1200
    .ColWidth(7) = 2200
    .ColWidth(8) = 2200
    .ColWidth(9) = 2200
    .ColWidth(10) = 1000
    
    .FixedAlignment(0) = flexAlignLeft
    .FixedAlignment(1) = flexAlignLeft
    .FixedAlignment(2) = flexAlignRight
    .FixedAlignment(3) = flexAlignLeft
    .FixedAlignment(4) = flexAlignRight
    .FixedAlignment(5) = flexAlignCenter
    .FixedAlignment(6) = flexAlignCenter
    .FixedAlignment(7) = flexAlignRight
    .FixedAlignment(8) = flexAlignRight
    .FixedAlignment(9) = flexAlignRight
    .FixedAlignment(10) = flexAlignCenter

    
    .TextMatrix(0, 0) = "Asoc."
    .TextMatrix(0, 1) = "Tipo"
    .TextMatrix(0, 2) = "N° Oper."
    .TextMatrix(0, 3) = "Moneda"
    .TextMatrix(0, 4) = "Monto Operación"
    .TextMatrix(0, 5) = "Fecha Inicio"
    .TextMatrix(0, 6) = "Fecha Vcto."
    .TextMatrix(0, 7) = "Valor MTM"
    .TextMatrix(0, 8) = "Valor Threshold"
    .TextMatrix(0, 9) = "MTM - Threshold"
    .TextMatrix(0, 10) = "Req. Gtías."

End With
End Sub
Private Sub LlenaGrillaOper()
Dim Fila As Integer
Dim dif As Double
Dim mtm As Double
Dim thr As Double
'Dim cgOper As Long
Dim Datos()
Envia = Array()
AddParam Envia, CLng(txtRutCliente.Text)
AddParam Envia, CInt(txtCodCliente.Text)
If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_GAR_OPERDISPPARAGARANTIAS", Envia) Then
    MsgBox "Error al buscar Operaciones para Garantías!", vbExclamation, TITSISTEMA
    Exit Sub
End If

grillaOper.Enabled = True
grillaOper.Clear
grillaOper.Rows = 2
Call FormateaGrillaOper
Fila = 1
cgOper = 0
Do While Bac_SQL_Fetch(Datos())
    With grillaOper
        dif = IIf(IsNull(Datos(9)), 0, Datos(9))
        mtm = IIf(IsNull(Datos(8)), 0, Datos(8))
        thr = IIf(IsNull(Datos(7)), 0, Datos(7))
        'Solicitado en Minuta del 16.12.2010 por el usuario:
        'Mostrar todas las operaciones, independiente del valor de mtm => incluir mtm < 0, mtm >= 0
        .TextMatrix(Fila, 0) = "No"
        .TextMatrix(Fila, 1) = Datos(1)
        .TextMatrix(Fila, 2) = Datos(2)
        .TextMatrix(Fila, 3) = Datos(3)
        .TextMatrix(Fila, 4) = Format(Datos(4), FDecimal)
        .TextMatrix(Fila, 5) = Datos(5)
        .TextMatrix(Fila, 6) = Datos(6)
        .TextMatrix(Fila, 7) = Format(mtm, FEntero)
        .TextMatrix(Fila, 8) = Format(thr, FEntero)
        .TextMatrix(Fila, 9) = Format(dif, FEntero)
        If mtm <= 0 Then
            .TextMatrix(Fila, 10) = "No"
        ElseIf thr = 0 Then
            .TextMatrix(Fila, 10) = "No"
        ElseIf dif > 0 Then
            .TextMatrix(Fila, 10) = "Sí"
        Else
            .TextMatrix(Fila, 10) = "No"
        End If
        Fila = Fila + 1
        .Rows = .Rows + 1
        cgOper = cgOper + 1

    End With
Loop
'Borrar la ultima fila
grillaOper.Rows = grillaOper.Rows - 1
If cgOper = 0 Then
    'bloquear grabar y asociar
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    
    grillaOper.Enabled = False
    MsgBox "Atención! El cliente no tiene Operaciones para asociar a Garantías!", vbExclamation, TITSISTEMA
    LlenaGrilla = False
    Exit Sub
End If
End Sub
Private Sub LLenaGrillaGtias()
Dim Fila As Integer
Dim sumaGtias As Double
'Dim cgGtias As Long
Dim Datos()

    sumaGtias = 0#
    cgGtias = 0

    Envia = Array()
    AddParam Envia, CLng(txtRutCliente.Text)
    AddParam Envia, CInt(txtCodCliente.Text)
    grillaGtias.Enabled = True
    
    If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_GAR_RETGARANTIASDISPONIBLES", Envia) Then
        MsgBox "Error al buscar Garantías Disponibles!", vbExclamation, TITSISTEMA
        Exit Sub
    End If
    
    With grillaGtias
        .Clear
        .Rows = 2
        .Cols = 5
        Call FormateaGrillaGtias
        Fila = 1
        Do While Bac_SQL_Fetch(Datos())
            .TextMatrix(Fila, 0) = "No"
            .TextMatrix(Fila, 1) = Format(CDbl(Datos(1)), FEntero)
            .TextMatrix(Fila, 2) = Datos(2)
            .TextMatrix(Fila, 3) = Format(CDbl(Datos(3)), FDecimal)
            .TextMatrix(Fila, 4) = Datos(4) 'Fecha vigencia
            sumaGtias = sumaGtias + CDbl(Datos(3))
            cgGtias = cgGtias + 1
            Fila = Fila + 1
            .Rows = .Rows + 1
        Loop
        'Borrar la ultima fila
        .Rows = .Rows - 1
    End With
    
    If cgGtias = 0 Then
        'bloquear grabar y asociar
        Toolbar1.Buttons(2).Enabled = False
        Toolbar1.Buttons(3).Enabled = False
        MsgBox "Atención! El cliente no tiene Garantías disponibles para asociar a Operaciones!", vbExclamation, TITSISTEMA
        
        LlenaGrilla = False
        grillaGtias.Enabled = False
        grillaOper.Enabled = False
        Exit Sub
    End If
    'habilitar asociar
    Toolbar1.Buttons(2).Enabled = True
End Sub
Private Sub Limpiar()
    txtRutCliente.Enabled = True
    txtCodCliente.Enabled = True
    frmMarcaOper.Visible = False
    frmMarcaGtia.Visible = False
    
    txtRutCliente.Text = ""
    txtCodCliente.Text = ""
    txtNomCliente.Text = ""
    grillaGtias.Enabled = True
    grillaOper.Enabled = True
    txtRutCliente.Enabled = True
    grillaOper.Clear
    grillaGtias.Clear
    grillaOper.Rows = 2
    grillaGtias.Rows = 2
    Call FormateaGrillaOper
    Call FormateaGrillaGtias
    numOperSel = 0
    numGtiaSel = 0
    numOperAsoc = 0
    numGtiaAsoc = 0
    totalOperacion = 0#
    totalGarantias = 0#
    ListOper.Clear
    ListGar.Clear
    lblmfGar.Caption = ""
    lblMfOper.Caption = ""
    lblOperSel.Caption = Format(numOperSel, FEntero)
    lblGtiasSel.Caption = Format(numGtiaSel, FEntero)
    lblOperAsoc.Caption = Format(numOperAsoc, FEntero)
    lblGtiasAsoc.Caption = Format(numGtiaAsoc, FEntero)
    lblTotalOperacion.Caption = Format(totalOperacion, FDecimal)
    lblTotalGarantias.Caption = Format(totalGarantias, FDecimal)
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    txtRutCliente.SetFocus
End Sub
Private Sub txtRutCliente_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If Trim(txtRutCliente.Text) = "" Then
            Exit Sub
        End If
        SendKeys "{TAB}"
    End If

    If Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
        BacCaracterNumerico KeyAscii
    End If
End Sub


