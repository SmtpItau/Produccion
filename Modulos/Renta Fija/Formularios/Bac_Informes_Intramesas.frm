VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_Informes_Intramesas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe de Operaciones Intramesas"
   ClientHeight    =   4185
   ClientLeft      =   1500
   ClientTop       =   2130
   ClientWidth     =   6570
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4185
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
      Top             =   3400
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
      Top             =   2760
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
      Top             =   2760
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
      Caption         =   "Tipo de Informe"
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
      Height          =   2055
      Left            =   120
      TabIndex        =   1
      Top             =   680
      Width           =   6375
      Begin VB.OptionButton optCartPropia 
         Caption         =   "Cartera Propia"
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
         Left            =   3480
         TabIndex        =   14
         Top             =   300
         Width           =   1935
      End
      Begin VB.OptionButton optCartPacV 
         Caption         =   "Cartera Pactos Ventas"
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
         Left            =   3480
         TabIndex        =   13
         Top             =   1200
         Width           =   2415
      End
      Begin VB.OptionButton optCartPacC 
         Caption         =   "Cartera Pactos Compras"
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
         Left            =   3480
         TabIndex        =   12
         Top             =   750
         Width           =   2415
      End
      Begin VB.OptionButton optVentaPac 
         Caption         =   "Ventas con Pactos"
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
         Left            =   120
         TabIndex        =   11
         Top             =   1680
         Width           =   2055
      End
      Begin VB.OptionButton optCompraPac 
         Caption         =   "Compras con Pactos"
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
         Left            =   120
         TabIndex        =   10
         Top             =   1200
         Width           =   2175
      End
      Begin VB.OptionButton optVentaDef 
         Caption         =   "Ventas Definitivas"
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
         Left            =   120
         TabIndex        =   7
         Top             =   750
         Width           =   2295
      End
      Begin VB.OptionButton optCompraDef 
         Caption         =   "Compras Definitivas"
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
         Left            =   120
         TabIndex        =   6
         Top             =   300
         Width           =   2295
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
'JBH, 03-12-2009.  Formulario unico de seleccion de movimientos intramesas
Call PROC_LLENA_COMBOS(Me.cboCartera, 4, True, "", GLB_CARTERA, GLB_ID_SISTEMA)
Call LlenaMesa(cboMesa, True)
Call Limpiar
End Sub
Private Sub optCartPacC_Click()
    frmFechaInforme.Visible = False
    Me.Height = 3810
End Sub

Private Sub optCartPacV_Click()
    frmFechaInforme.Visible = False
    Me.Height = 3810
End Sub

Private Sub optCartPropia_Click()
    frmFechaInforme.Visible = False
    Me.Height = 3810
End Sub

Private Sub optCompraDef_Click()
    frmFechaInforme.Visible = True
    Me.Height = 4560
End Sub

Private Sub optCompraPac_Click()
    frmFechaInforme.Visible = True
    Me.Height = 4560
End Sub

Private Sub optVentaDef_Click()
    frmFechaInforme.Visible = True
    Me.Height = 4560
End Sub

Private Sub optVentaPac_Click()
    frmFechaInforme.Visible = True
    Me.Height = 4560
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim selCartera As Integer
Dim selMesa As Integer
Dim optCartera As String
Dim optMesa As String
Dim tipo As String
Dim opcion As Integer
On Error GoTo ErrorRpt

Select Case Button.Index
    Case 4
            Unload Me
    Case 3 'Limpiar
            Call Limpiar
    Case Else 'A pantalla o Impresora
        opcion = optSelected()
        If opcion = -1 Then
            MsgBox "No ha seleccionado el Tipo del Informe a generar", vbExclamation, gsBac_Version
            Exit Sub
        End If
        Select Case opcion
            Case 1  'CP
                Call InfCP(Button.Index)
            Case 2  'VP
                Call InfVP(Button.Index)
            Case 3  'CI
                Call InfCI(Button.Index)
            Case 4  'VI
                Call InfVI(Button.Index)
            Case 5  'Cartera Propia
                Call InfCartPropia(Button.Index)
            Case 6  'Cartera Pactos Compras
                Call InfCartPactos("CI", Button.Index)
            Case 7  'Cartera Pactos Ventas
                Call InfCartPactos("VI", Button.Index)
        End Select
End Select
Exit Sub
ErrorRpt:
MsgBox "Se ha producido un error: " & err.Description, vbCritical, gsBac_Version

End Sub
Function LlenaMesa(Combo As Object, Optional todos As Boolean = False)
'JBH, 02-12-2009
Dim nomSp As String
Dim Datos()
Envia = Array()
nomSp = "BacParamsuda.DBO.SP_LISTAPORCODIGODET"
Combo.Clear
AddParam Envia, 245
If Bac_Sql_Execute(nomSp, Envia) Then
    If todos = True Then
        Combo.AddItem "< TODOS (AS) >" & Space(110)
    End If
    Do While Bac_SQL_Fetch(Datos)
        Combo.AddItem (Datos(1)) & Space(110) & Datos(2)
    Loop
End If
If todos = True Then
    Combo.ListIndex = 0
Else
    Combo.ListIndex = -1
End If
End Function

Private Function InfCartPropia(ByVal boton As Integer)
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
    optCartera = "-1"
End If
If optMesa <> "" Then
    selMesa = CInt(optMesa)
Else
    optMesa = "-1"
End If
Call Limpiar_Cristal
BacTrader.bacrpt.StoredProcParam(0) = optCartera
BacTrader.bacrpt.StoredProcParam(1) = optMesa
BacTrader.bacrpt.ReportFileName = RptList_Path & "informe_cartera_vigente_im_rtafija.rpt"
If boton = 1 Then
    BacTrader.bacrpt.Destination = crptToWindow
Else
    BacTrader.bacrpt.Destination = crptToPrinter
End If
BacTrader.bacrpt.Connect = CONECCION
BacTrader.bacrpt.Action = 1
Exit Function
ErrorRpt:
MsgBox "Se ha producido un error: " & err.Description, vbCritical, gsBac_Version
End Function
Private Function InfCartPactos(ByVal tipo As String, ByVal boton As Integer)
Dim selCartera As Integer
Dim selMesa As Integer
Dim optCartera As String
Dim optMesa As String
On Error GoTo ErrorRpt
selCartera = -9
selMesa = -9
optCartera = Trim(Right(cboCartera.Text, 10))
optMesa = Trim(Right(cboMesa.Text, 10))
If optCartera <> "" Then
    selCartera = CInt(optCartera)
Else
    optCartera = "-1"
End If
If optMesa <> "" Then
    selMesa = CInt(optMesa)
Else
    optMesa = "-1"
End If
Call Limpiar_Cristal

BacTrader.bacrpt.ReportFileName = RptList_Path & "informe_cartvig_pactos_im_rfija.rpt"
BacTrader.bacrpt.StoredProcParam(0) = optCartera
BacTrader.bacrpt.StoredProcParam(1) = optMesa
BacTrader.bacrpt.StoredProcParam(2) = tipo
BacTrader.bacrpt.Connect = CONECCION
If boton = 1 Then
    BacTrader.bacrpt.Destination = crptToWindow
Else
    BacTrader.bacrpt.Destination = crptToPrinter
End If
BacTrader.bacrpt.Action = 1
Exit Function
ErrorRpt:
MsgBox "Se ha producido un error: " & err.Description, vbCritical, gsBac_Version
End Function
Private Function InfCP(ByVal boton As Integer)
Dim selCartera As Integer
Dim selMesa As Integer
Dim optCartera As String
Dim optMesa As String
Dim tipo As String
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
Call Limpiar_Cristal
tipo = "CP"
BacTrader.bacrpt.ReportFileName = RptList_Path & "Reporte_movtos_imcp_rtafija.rpt"
BacTrader.bacrpt.StoredProcParam(0) = tipo
BacTrader.bacrpt.StoredProcParam(1) = Format(Me.TXTFecha1.Text, "yyyymmdd")
BacTrader.bacrpt.StoredProcParam(2) = optCartera
BacTrader.bacrpt.StoredProcParam(3) = optMesa
BacTrader.bacrpt.Connect = CONECCION
If boton = 1 Then
    BacTrader.bacrpt.Destination = crptToWindow
Else
    BacTrader.bacrpt.Destination = crptToPrinter
End If
BacTrader.bacrpt.Action = 1
End Function
Private Function InfVP(ByVal boton As Integer)
Dim selCartera As Integer
Dim selMesa As Integer
Dim optCartera As String
Dim optMesa As String
Dim tipo As String
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
Call Limpiar_Cristal
tipo = "VP"
BacTrader.bacrpt.ReportFileName = RptList_Path & "Reporte_movtos_imvt_rtafija.rpt"
BacTrader.bacrpt.StoredProcParam(0) = tipo
BacTrader.bacrpt.StoredProcParam(1) = Format(Me.TXTFecha1.Text, "yyyymmdd")
BacTrader.bacrpt.StoredProcParam(2) = optCartera
BacTrader.bacrpt.StoredProcParam(3) = optMesa
BacTrader.bacrpt.Connect = CONECCION
If boton = 1 Then
    BacTrader.bacrpt.Destination = crptToWindow
Else
    BacTrader.bacrpt.Destination = crptToPrinter
End If
BacTrader.bacrpt.Action = 1
End Function
Private Function InfCI(ByVal boton As Integer)
Dim selCartera As Integer
Dim selMesa As Integer
Dim optCartera As String
Dim optMesa As String
Dim tipo As String
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
Call Limpiar_Cristal
tipo = "CI"
BacTrader.bacrpt.ReportFileName = RptList_Path & "Reporte_movtospacto_IM_rtafija.rpt"
BacTrader.bacrpt.StoredProcParam(0) = tipo
BacTrader.bacrpt.StoredProcParam(1) = Format(Me.TXTFecha1.Text, "yyyymmdd")
BacTrader.bacrpt.StoredProcParam(2) = optCartera
BacTrader.bacrpt.StoredProcParam(3) = optMesa
BacTrader.bacrpt.Connect = CONECCION
If boton = 1 Then
    BacTrader.bacrpt.Destination = crptToWindow
Else
    BacTrader.bacrpt.Destination = crptToPrinter
End If
BacTrader.bacrpt.Action = 1
End Function
Private Function InfVI(ByVal boton As Integer)
Dim selCartera As Integer
Dim selMesa As Integer
Dim optCartera As String
Dim optMesa As String
Dim tipo As String
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
Call Limpiar_Cristal
tipo = "VI"
BacTrader.bacrpt.ReportFileName = RptList_Path & "Reporte_movtospacto_IM_rtafija.rpt"
BacTrader.bacrpt.StoredProcParam(0) = tipo
BacTrader.bacrpt.StoredProcParam(1) = Format(Me.TXTFecha1.Text, "yyyymmdd")
BacTrader.bacrpt.StoredProcParam(2) = optCartera
BacTrader.bacrpt.StoredProcParam(3) = optMesa
BacTrader.bacrpt.Connect = CONECCION
If boton = 1 Then
    BacTrader.bacrpt.Destination = crptToWindow
Else
    BacTrader.bacrpt.Destination = crptToPrinter
End If
BacTrader.bacrpt.Action = 1

End Function

Private Function Limpiar()
TXTFecha1.Text = gsBac_Fecp
cboCartera.ListIndex = 0
cboMesa.ListIndex = 0
optCompraDef.Value = False
optVentaDef.Value = False
optCompraPac.Value = False
optVentaPac.Value = False
optCartPropia.Value = False
optCartPacC.Value = False
optCartPacV.Value = False
Me.Height = 3810
End Function
Private Function optSelected() As Integer
Dim salida As Integer
salida = -1
If optCompraDef.Value = True Then
    salida = 1
    optSelected = salida
    Exit Function
End If
If optVentaDef.Value = True Then
    salida = 2
    optSelected = salida
    Exit Function
End If
If optCompraPac.Value = True Then
    salida = 3
    optSelected = salida
    Exit Function
End If
If optVentaPac.Value = True Then
    salida = 4
    optSelected = salida
    Exit Function
End If
If optCartPropia.Value = True Then
    salida = 5
    optSelected = salida
    Exit Function
End If
If optCartPacV.Value = True Then
    salida = 6
    optSelected = salida
    Exit Function
End If
If optCartPacC.Value = True Then
    salida = 7
    optSelected = salida
    Exit Function
End If
optSelected = salida
End Function
