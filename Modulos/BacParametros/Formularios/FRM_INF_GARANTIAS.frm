VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_INF_GARANTIAS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informes de Garantías"
   ClientHeight    =   5370
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7440
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5370
   ScaleWidth      =   7440
   Begin VB.Frame fraGrilla 
      Caption         =   "Seleccione Garantía"
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
      Height          =   3135
      Left            =   120
      TabIndex        =   10
      Top             =   2160
      Visible         =   0   'False
      Width           =   7215
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   2775
         Left            =   120
         TabIndex        =   11
         Top             =   240
         Width           =   6975
         _ExtentX        =   12303
         _ExtentY        =   4895
         _Version        =   393216
         Cols            =   8
         FixedCols       =   0
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   -2147483643
         ForeColorSel    =   -2147483635
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
   Begin VB.Frame fraTipo 
      Caption         =   "Tipo de Garantías"
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
      Height          =   855
      Left            =   2040
      TabIndex        =   6
      Top             =   1320
      Visible         =   0   'False
      Width           =   5295
      Begin VB.OptionButton optOtorgadas 
         Caption         =   "Otorgadas"
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
         Left            =   3120
         TabIndex        =   8
         Top             =   360
         Width           =   1935
      End
      Begin VB.OptionButton optConstituidas 
         Caption         =   "Constituídas"
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
         TabIndex        =   7
         Top             =   360
         Width           =   2175
      End
   End
   Begin VB.Frame fraFecha 
      Caption         =   "Fecha Informe"
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
      Height          =   855
      Left            =   120
      TabIndex        =   3
      Top             =   1320
      Visible         =   0   'False
      Width           =   1695
      Begin BACControles.TXTFecha TXTFecha1 
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   360
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   450
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
         Text            =   "29-12-2010"
      End
   End
   Begin VB.Frame fraOpciones 
      Caption         =   "Informe"
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
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   7215
      Begin VB.OptionButton optInfCartera 
         Caption         =   "Informe de Cartera"
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
         Left            =   2280
         TabIndex        =   9
         Top             =   240
         Visible         =   0   'False
         Width           =   1935
      End
      Begin VB.OptionButton optPapeleta 
         Caption         =   "Papeleta de Movimientos"
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
         Left            =   4320
         TabIndex        =   4
         Top             =   240
         Width           =   2775
      End
      Begin VB.OptionButton optMovtoDiario 
         Caption         =   "Movimiento Diario"
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
         TabIndex        =   2
         Top             =   240
         Width           =   2055
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7440
      _ExtentX        =   13123
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
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "A pantalla"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "A impresora"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4800
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INF_GARANTIAS.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INF_GARANTIAS.frx":0324
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INF_GARANTIAS.frx":11FE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INF_GARANTIAS.frx":20D8
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_INF_GARANTIAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Activate()
    Call Limpiar
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    Call Limpiar
End Sub
Private Sub FormateaGrilla()
With grilla
    .Cols = 6
    .FixedRows = 1
    .ColWidth(0) = 1200
    .ColWidth(1) = 1200
    .ColWidth(2) = 1200
    .ColWidth(3) = 1200
    .ColWidth(4) = 700
    .ColWidth(5) = 2800
              
    .FixedAlignment(0) = flexAlignRight
    .FixedAlignment(1) = flexAlignLeft
    .FixedAlignment(2) = flexAlignLeft
    .FixedAlignment(3) = flexAlignLeft
    .FixedAlignment(4) = flexAlignCenter
    .FixedAlignment(5) = flexAlignLeft
    
    .TextMatrix(0, 0) = "N° de Gtía."
    .TextMatrix(0, 1) = "Fecha Const."
    .TextMatrix(0, 2) = "Fecha Vcto."
    .TextMatrix(0, 3) = "Rut Cliente"
    .TextMatrix(0, 4) = "Cód."
    .TextMatrix(0, 5) = "Nombre Cliente"
End With
End Sub
Private Sub LlenaGrilla()
Dim nomSp As String
Dim van As Long
Dim Tipo As String
Dim Fila As Long
Dim Datos()
Envia = Array()
nomSp = "Bacparamsuda.dbo.SP_GAR_RETRESUMENGTIAS"
If optConstituidas.Value = False And optOtorgadas.Value = False Then
    Exit Sub
End If
If Me.optConstituidas.Value Then
    Tipo = "C"
Else
    Tipo = "O"
End If
van = 0
AddParam Envia, CStr(TXTFecha1.Text)
AddParam Envia, Tipo
If Not Bac_Sql_Execute(nomSp, Envia) Then
    MsgBox "Error al buscar Resúmen de Garantías por Tipo!", vbExclamation, TITSISTEMA
    Exit Sub
End If
Fila = 1
grilla.Rows = 2
Do While Bac_SQL_Fetch(Datos())
    With grilla
        .TextMatrix(Fila, 0) = Format(Datos(1), FEntero)
        .TextMatrix(Fila, 1) = Datos(2)
        .TextMatrix(Fila, 2) = Datos(3)
        .TextMatrix(Fila, 3) = Datos(4)
        .TextMatrix(Fila, 4) = Datos(5)
        .TextMatrix(Fila, 5) = Datos(6)
    End With
    Fila = Fila + 1
    van = van + 1
    grilla.Rows = grilla.Rows + 1
Loop
If van = 0 Then
    MsgBox "No hay datos para seleccionar!", vbInformation, TITSISTEMA
End If

End Sub
Private Sub optConstituidas_Click()
    fraTipo.Enabled = False
    Me.Height = 5745
    fraGrilla.Visible = True
    fraFecha.Enabled = False
    Call FormateaGrilla
    Call LlenaGrilla
End Sub

Private Sub optInfCartera_Click()
    Me.Caption = "Informes de Garantías - Informe de Cartera"
    fraOpciones.Enabled = False
End Sub

Private Sub optMovtoDiario_Click()
    Me.Caption = "Informes de Garantías - Movimiento Diario"
    fraOpciones.Enabled = False
    Me.Height = 2640
    fraFecha.Visible = True
    TXTFecha1.Text = gsbac_fecp
    
End Sub

Private Sub optOtorgadas_Click()
    fraTipo.Enabled = False
    Me.Height = 5745
    fraGrilla.Visible = True
    fraFecha.Enabled = False
    Call FormateaGrilla
    Call LlenaGrilla
End Sub

Private Sub optPapeleta_Click()
    Me.Caption = "Informes de Garantías - Papeleta de Movimiento"
    fraOpciones.Enabled = False
    Me.Height = 2640
    fraFecha.Visible = True
    TXTFecha1.Text = gsbac_fecp
    fraTipo.Enabled = True
    fraTipo.Visible = True
    optConstituidas.Value = False
    optOtorgadas.Value = False
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1  'Limpiar
        Call Limpiar
    Case 2  'Pantalla Crystal
        Call Imprime(0)
    Case 3  'Impresora
        Call Imprime(1)
    Case 4  'Salir
        Unload Me
End Select

End Sub
Private Function Imprime(ByVal destino As Integer) As Boolean
'destino = 0  --> Pantalla
'destino = 1 ---> Impresora
    Dim tipoGar As String
    Dim folio As String
    
    On Error GoTo Control:
    folio = 2
    If optMovtoDiario.Value = False And optInfCartera.Value = False And optPapeleta.Value = False Then
        Exit Function
    End If
    
    If optPapeleta.Value And Trim(grilla.TextMatrix(grilla.RowSel, 0)) = "" Then
        Exit Function
    End If
    If fraFecha.Enabled Then
        fraFecha.Enabled = False
    End If

    Call limpiar_cristal
    Screen.MousePointer = vbHourglass
    If destino = 0 Then
         BACSwapParametros.BACParam.Destination = crptToWindow
    Else
         BACSwapParametros.BACParam.Destination = crptToPrinter
    End If
    If optMovtoDiario.Value Then
        BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "garMovtoDiario.rpt"
        BACSwapParametros.BACParam.WindowTitle = "INFORME DE MOVIMIENTO DIARIO"
        BACSwapParametros.BACParam.StoredProcParam(0) = Format(TXTFecha1.Text, "yyyy-mm-dd 00:00:00.000")
        BACSwapParametros.BACParam.Connect = SwConeccion
        BACSwapParametros.BACParam.WindowState = crptMaximized
        BACSwapParametros.BACParam.Action = 1
        Screen.MousePointer = vbDefault
    End If
    If optInfCartera.Value Then
    
    
    End If
    If optPapeleta.Value Then
        BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "Papeleta_Garantias.rpt"
        BACSwapParametros.BACParam.WindowTitle = "INFORME DE PAPELETA DE MOVIMIENTOS"
        BACSwapParametros.BACParam.StoredProcParam(0) = CLng(grilla.TextMatrix(grilla.RowSel, 0))
        If Me.optConstituidas.Value Then
            tipoGar = "C"
        Else
            tipoGar = "O"
        End If
        BACSwapParametros.BACParam.StoredProcParam(1) = tipoGar
        BACSwapParametros.BACParam.Connect = SwConeccion
        BACSwapParametros.BACParam.WindowState = crptMaximized
        BACSwapParametros.BACParam.Action = 1
        Screen.MousePointer = vbDefault
    End If
Exit Function

Control:

    MsgBox "Se ha producido un error al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0

End Function

Private Sub Limpiar()
    If grilla.Enabled Then
        grilla.Clear
    End If
    fraFecha.Enabled = True
    fraOpciones.Visible = True
    fraOpciones.Enabled = True
    fraFecha.Visible = False
    fraTipo.Visible = False
    fraGrilla.Visible = False
    Me.Height = 1695
    optMovtoDiario.Value = False
    optInfCartera.Value = False
    optPapeleta.Value = False
End Sub
