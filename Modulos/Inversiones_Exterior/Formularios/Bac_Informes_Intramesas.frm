VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_Informes_Intramesas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe de Operaciones Intramesas"
   ClientHeight    =   2820
   ClientLeft      =   1500
   ClientTop       =   2130
   ClientWidth     =   6570
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2820
   ScaleWidth      =   6570
   Begin VB.Frame frmFechaInforme 
      Caption         =   "Fecha del Informe"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   685
      Left            =   120
      TabIndex        =   8
      Top             =   2040
      Width           =   6375
      Begin BACControles.TXTFecha TXTFecha1 
         Height          =   315
         Left            =   2640
         TabIndex        =   9
         Top             =   240
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
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
         Text            =   "04-11-2009"
      End
   End
   Begin VB.Frame frmMesa 
      Caption         =   "Portafolio"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   615
      Left            =   3360
      TabIndex        =   3
      Top             =   1440
      Width           =   3135
      Begin VB.ComboBox cboMesa 
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   240
         Width           =   2895
      End
   End
   Begin VB.Frame frmCartera 
      Caption         =   "Cartera Origen"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   615
      Left            =   120
      TabIndex        =   2
      Top             =   1440
      Width           =   3135
      Begin VB.ComboBox cboCartera 
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   240
         Width           =   2895
      End
   End
   Begin VB.Frame frmTipoOperacion 
      Caption         =   "Tipo de Operación"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   735
      Left            =   120
      TabIndex        =   1
      Top             =   720
      Width           =   6375
      Begin VB.OptionButton optVenta 
         Caption         =   "Ventas"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   255
         Left            =   3360
         TabIndex        =   7
         Top             =   300
         Width           =   1695
      End
      Begin VB.OptionButton optCompra 
         Caption         =   "Compras"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   255
         Left            =   960
         TabIndex        =   6
         Top             =   300
         Width           =   1575
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6570
      _ExtentX        =   11589
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir en Pantalla"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4800
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   18
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":031A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":0ED8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":11F2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":1644
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":179E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":1BF0
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":2042
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":235C
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":2676
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":27D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":2C22
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":3074
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":338E
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":36A8
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Informes_Intramesas.frx":39C2
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Bac_Informes_Intramesas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
'JBH, formulario nuevo, 06-11-2009
Me.Top = 15   'JBH, 17-12-2009

Call PROC_LLENA_COMBOS(Me.cboCartera, 4, True, "", GLB_CARTERA, GLB_ID_SISTEMA)
Call LlenaMesa(cboMesa, True)
TXTFecha1.Text = gsBac_Fecp

End Sub
Private Function LlenaMesa(COMBO As Object, Optional todos As Boolean = False)
Dim nomSp As String
Dim datos()
envia = Array()
nomSp = "SP_LISTAPORCODIGODET"
COMBO.Clear
AddParam envia, 245
If Bac_Sql_Execute(nomSp, envia) Then
    If todos = True Then
        COMBO.AddItem "< TODOS (AS) >" & Space(110)
    End If
    Do While Bac_SQL_Fetch(datos)
        COMBO.AddItem (datos(1)) & Space(110) & datos(2)
    Loop
End If
If todos = True Then
    COMBO.ListIndex = 0
Else
    COMBO.ListIndex = -1
End If
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim selCartera As Integer
Dim selMesa As Integer
Dim optCartera As String
Dim optMesa As String
Dim tipo As String
On Error GoTo ErrorRpt
selCartera = -9
selMesa = -9
optCartera = Trim(Right(cboCartera.Text, 10))
optMesa = Trim(Right(cboMesa.Text, 10))
If optCartera <> "" Then
    selCartera = CInt(optCartera)
Else
    optCartera = "T"
End If
If optMesa <> "" Then
    selMesa = CInt(optMesa)
Else
    optMesa = "T"
End If

Select Case Button.Index
    Case 1  'A pantalla
        If optCompra.Value = False And optVenta.Value = False Then
            MsgBox "No ha seleccionado el Tipo de Operación!", vbExclamation, gsBac_Version
            Exit Sub
        End If
        Call limpiar_cristal
        If optCompra.Value = True Then
            tipo = "CP"
            BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Reporte_movtos_imcp.rpt"
        Else
            tipo = "VP"
            BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Reporte_movtos_imvt.rpt"
        End If
        BAC_INVERSIONES.BacRpt.StoredProcParam(0) = tipo
        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Format(Me.TXTFecha1.Text, "yyyymmdd")
        BAC_INVERSIONES.BacRpt.StoredProcParam(2) = optCartera
        BAC_INVERSIONES.BacRpt.StoredProcParam(3) = optMesa
        
            BAC_INVERSIONES.BacRpt.Destination = crptToWindow
        BAC_INVERSIONES.BacRpt.Connect = CONECCION
        BAC_INVERSIONES.BacRpt.Action = 1
    Case 2  'A impresora
        If optCompra.Value = False And optVenta.Value = False Then
            MsgBox "No ha seleccionado el Tipo de Operación!", vbExclamation, gsBac_Version
            Exit Sub
        End If
        Call limpiar_cristal
        If optCompra.Value = True Then
            tipo = "CP"
            BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Reporte_movtos_imcp.rpt"
        Else
            tipo = "VP"
            BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Reporte_movtos_imvt.rpt"
        End If
        BAC_INVERSIONES.BacRpt.StoredProcParam(0) = tipo
        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Format(Me.TXTFecha1.Text, "yyyymmdd")
        BAC_INVERSIONES.BacRpt.StoredProcParam(2) = optCartera
        BAC_INVERSIONES.BacRpt.StoredProcParam(3) = optMesa
        BAC_INVERSIONES.BacRpt.Destination = crptToPrinter
        BAC_INVERSIONES.BacRpt.Connect = CONECCION
        BAC_INVERSIONES.BacRpt.Action = 1
    Case 3  'Limpiar
        optCompra.Value = False
        optVenta.Value = False
        cboCartera.ListIndex = 0
        cboMesa.ListIndex = 0
        TXTFecha1.Text = gsBac_Fecp
    Case 4
        Unload Me
End Select
Exit Sub
ErrorRpt:
MsgBox "Se ha producido un error: " & err.Description, vbCritical, gsBac_Version

End Sub
