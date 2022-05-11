VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_INTERCAMBIA_GTIASO 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Intercambio de Garantías Otorgadas"
   ClientHeight    =   8535
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   14040
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8535
   ScaleWidth      =   14040
   Begin VB.Frame Frame4 
      Height          =   615
      Left            =   0
      TabIndex        =   15
      Top             =   7850
      Width           =   4695
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "[Enter]: Selecciona/Deselecciona Instrumentos"
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
         Left            =   480
         TabIndex        =   16
         Top             =   240
         Width           =   4035
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Monto Total cubierto por Instrumentos Disponibles"
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
      Left            =   5040
      TabIndex        =   13
      Top             =   7850
      Width           =   4935
      Begin VB.TextBox txtMontoCubierto 
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
         Left            =   240
         Locked          =   -1  'True
         TabIndex        =   14
         Text            =   "0.0000"
         Top             =   240
         Width           =   4455
      End
   End
   Begin VB.Frame Frame1 
      Height          =   615
      Left            =   0
      TabIndex        =   11
      Top             =   4400
      Width           =   4695
      Begin VB.Label Label1 
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
         Left            =   480
         TabIndex        =   12
         Top             =   240
         Width           =   3795
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Monto Total de los Instrumentos a Intercambiar"
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
      Left            =   4920
      TabIndex        =   9
      Top             =   4400
      Width           =   4935
      Begin VB.TextBox txtTotalIntercambiar 
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
         Left            =   240
         Locked          =   -1  'True
         TabIndex        =   10
         Text            =   "0.0000"
         Top             =   240
         Width           =   4455
      End
   End
   Begin VB.Frame frmOperaciones 
      Caption         =   "Garantías Otorgadas"
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
      Left            =   0
      TabIndex        =   6
      Top             =   1200
      Width           =   13935
      Begin MSFlexGridLib.MSFlexGrid grillaOtorg 
         Height          =   2775
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   13695
         _ExtentX        =   24156
         _ExtentY        =   4895
         _Version        =   393216
         Cols            =   13
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
      TabIndex        =   4
      Top             =   600
      Width           =   9615
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
         TabIndex        =   1
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
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   0
         Top             =   240
         Width           =   1575
      End
      Begin VB.TextBox txtNomCliente 
         BackColor       =   &H00FFFFFF&
         Enabled         =   0   'False
         Height          =   285
         Left            =   2400
         TabIndex        =   5
         Top             =   240
         Width           =   7095
      End
   End
   Begin VB.Frame frmGarantias 
      Caption         =   "Instrumentos Disponibles del Cliente"
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
      Height          =   2775
      Left            =   0
      TabIndex        =   2
      Top             =   5040
      Width           =   13935
      Begin MSFlexGridLib.MSFlexGrid grillaDisp 
         Height          =   2415
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   13695
         _ExtentX        =   24156
         _ExtentY        =   4260
         _Version        =   393216
         Cols            =   11
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
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   14040
      _ExtentX        =   24765
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      DisabledImageList=   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Filtrar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Intercambiar"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   11
         EndProperty
      EndProperty
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
         NumListImages   =   12
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIASO.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIASO.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIASO.frx":17B4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIASO.frx":3036
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIASO.frx":3350
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIASO.frx":366A
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIASO.frx":3984
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIASO.frx":485E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIASO.frx":4B78
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIASO.frx":5A52
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIASO.frx":692C
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIASO.frx":6C46
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_INTERCAMBIA_GTIASO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public CarterasFinancieras    As String
Public CarterasNormativas     As String
Public colorFore As Long
Public colorBack As Long
Public colSelec As Long
Public colFondo As Long
Public colFondg As Long
Public numOperSel As Long
Public numGtiaSel As Long
Public numDocOtorg As String
Public numGtiaOtorg As Long
Public colAzulOsc As Long
Public colRojOsc As Long
Public colRojo As Long
Public totalOperacion As Double
Public totalGarantias As Double
Public Estado As Boolean
Private objCliente As Object
Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    Set objCliente = New clsCliente
    colorFore = grillaOtorg.ForeColor
    colorBack = grillaOtorg.BackColor
    colSelec = &H40C0&
    colFondo = &HFFFF80
    colFondg = &HE0E0E0
    colAzulOsc = &H800000
    colRojOsc = &H80&
    colRojo = &HFF&
    Estado = True
    Call FormateagrillaOtorg
    Call FormateaGrillaDisp
    Toolbar1.Buttons(4).Enabled = False
End Sub
Private Sub Form_Unload(Cancel As Integer)
    If Not Limpiar() Then
        Cancel = -1
    Else
        Cancel = 0
    End If
    Set objCliente = Nothing
End Sub

Private Sub grillaOtorg_DblClick()
Dim Fila As Long
    If Not Estado Then
        Exit Sub
    End If
    With grillaOtorg
        Fila = .RowSel
        If .TextMatrix(Fila, 0) = "Sí" Then
            Call DesmarcaOperacion(Fila)
        ElseIf .TextMatrix(Fila, 0) = "No" Then
            Call MarcaOperacion(Fila)
        End If
    End With
End Sub
Private Sub grillaOtorg_KeyPress(KeyAscii As Integer)
    If Not Estado Then
        Exit Sub
    End If
    If KeyAscii = 13 Then
        Call grillaOtorg_DblClick
    End If
End Sub
Private Sub grillaDisp_DblClick()
Dim Fila As Long
    If Not Estado Then
        Exit Sub
    End If

    With grillaDisp
        If .Row = 0 Then
            Exit Sub
        End If
        Fila = .RowSel
        If .TextMatrix(Fila, 0) = "Sí" Then
            Call DesmarcaGarantia(Fila)
        ElseIf .TextMatrix(Fila, 0) = "No" Then
            MarcaGarantia (Fila)
        End If
    End With
End Sub
Private Sub grillaDisp_KeyPress(KeyAscii As Integer)
    If Not Estado Then
        Exit Sub
    End If
    If KeyAscii = 13 Then
        Call grillaDisp_DblClick
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        Call Limpiar
    Case 2
        Call Filtrar
    Case 3
        Call Intercambiar
    Case 4
        If Grabar() = True Then
            Call Limpiar
        End If
    Case 5
        Unload Me
End Select
End Sub
Private Sub FormateagrillaOtorg()
With grillaOtorg
    .Cols = 14
    .FixedRows = 1
    .ColWidth(0) = 510
    .ColWidth(1) = 1200
    .ColWidth(2) = 1500
    .ColWidth(3) = 800
    .ColWidth(4) = 2600
    .ColWidth(5) = 1200
    .ColWidth(6) = 1500
    .ColWidth(7) = 2600
    .ColWidth(8) = 1200
    .ColWidth(9) = 0
    .ColWidth(10) = 0
    .ColWidth(11) = 0
    .ColWidth(12) = 0
    .ColWidth(13) = 0
    
    .FixedAlignment(0) = flexAlignLeft
    .FixedAlignment(1) = flexAlignRight
    .FixedAlignment(2) = flexAlignLeft
    .FixedAlignment(3) = flexAlignLeft
    .FixedAlignment(4) = flexAlignRight
    .FixedAlignment(5) = flexAlignLeft
    .FixedAlignment(6) = flexAlignLeft
    .FixedAlignment(7) = flexAlignRight
    .FixedAlignment(8) = flexAlignRight
    .FixedAlignment(9) = flexAlignCenter
    .FixedAlignment(10) = flexAlignCenter
    .FixedAlignment(11) = flexAlignRight
    .FixedAlignment(12) = flexAlignRight
    
    .TextMatrix(0, 0) = "Sel."
    .TextMatrix(0, 1) = "N° Garantía"
    .TextMatrix(0, 2) = "Instrumento"
    .TextMatrix(0, 3) = "Moneda"
    .TextMatrix(0, 4) = "Nominal"
    .TextMatrix(0, 5) = "Fecha Inicio"
    .TextMatrix(0, 6) = "Fecha Vigencia"
    .TextMatrix(0, 7) = "Valor Presente"
    .TextMatrix(0, 8) = "N° Docto."
    .TextMatrix(0, 9) = "Correlativo"   ' columna oculta
    .TextMatrix(0, 10) = ""  'Para marcar el Intercambio (col. oculta)
    .TextMatrix(0, 11) = "TIR"
    .TextMatrix(0, 12) = "VPAR"
End With

End Sub
Private Function Vaciarfila(ByVal Grilla As MSFlexGrid, ByVal numfila As Long) As Boolean
Dim I As Long
For I = 0 To Grilla.Cols - 1
    Grilla.TextMatrix(numfila, I) = ""
Next I
End Function
Private Function Limpiar() As Boolean
If grillaOtorg.Enabled = False Then
    grillaOtorg.Enabled = True
End If
If grillaDisp.Enabled = False Then
    grillaDisp.Enabled = True
End If
'Primero, revisar la grilla grillaDisp y desmarcar las filas marcadas
If Not DesmarcarTodasFilas() Then
    MsgBox "No ha sido posible desmarcar todas las filas de la grilla!", vbExclamation, TITSISTEMA
    Limpiar = False
    Exit Function
End If
If Not DesmarcarTodosIntercambiados() Then
    MsgBox "No ha sido posible desmarcar todas las filas de la grilla!", vbExclamation, TITSISTEMA
    Limpiar = False
    Exit Function
End If
txtRutCliente.Text = ""
txtCodCliente.Text = ""
txtNomCliente.Text = ""
grillaOtorg.Clear
grillaDisp.Clear
grillaOtorg.Rows = 2
grillaDisp.Rows = 2
Call FormateagrillaOtorg
Call FormateaGrillaDisp
numDocOtorg = ""
txtTotalIntercambiar.Text = "0.0000"
txtMontoCubierto.Text = "0.0000"
Toolbar1.Buttons(3).Enabled = False
Toolbar1.Buttons(4).Enabled = False
If txtRutCliente.Enabled = False Then
    txtRutCliente.Enabled = True
    txtCodCliente.Enabled = True
    txtNomCliente.Enabled = True
End If
Estado = True
Limpiar = True
Toolbar1.Buttons(2).Enabled = True
txtRutCliente.SetFocus
End Function
Private Sub FormateaGrillaDisp()
With grillaDisp
    .Cols = 12
    .FixedRows = 1
    .ColWidth(0) = 510
    .ColWidth(1) = 1800
    .ColWidth(2) = 800
    .ColWidth(3) = 2600
    .ColWidth(4) = 2600
    .ColWidth(5) = 1300
    .ColWidth(6) = 0
    .ColWidth(7) = 0
    .ColWidth(8) = 0
    .ColWidth(9) = 0
    .ColWidth(10) = 0
    .ColWidth(11) = 0
    
    .FixedAlignment(0) = flexAlignLeft
    .FixedAlignment(1) = flexAlignLeft
    .FixedAlignment(2) = flexAlignLeft
    .FixedAlignment(3) = flexAlignRight
    .FixedAlignment(4) = flexAlignRight
    .FixedAlignment(5) = flexAlignRight
    .FixedAlignment(6) = flexAlignLeft
    .FixedAlignment(7) = flexAlignLeft
    .FixedAlignment(8) = flexAlignLeft
    .FixedAlignment(9) = flexAlignLeft
    
    .TextMatrix(0, 0) = "Asoc."
    .TextMatrix(0, 1) = "Instrumento"
    .TextMatrix(0, 2) = "Moneda"
    .TextMatrix(0, 3) = "Nominal"
    .TextMatrix(0, 4) = "Valor Presente"
    .TextMatrix(0, 5) = "N° Docto."
    .TextMatrix(0, 6) = "Correlativo"
    .TextMatrix(0, 7) = ""  'Para marcar el Intercambio
    .TextMatrix(0, 8) = "TIR"
    .TextMatrix(0, 9) = "Valor Par"
    .TextMatrix(0, 10) = "Folio"
    .TextMatrix(0, 11) = "tipo Garantia"
    
End With

End Sub
Private Sub Intercambiar()
Dim marcadosUp As Long, marcadosDn As Long
marcadosUp = 0
marcadosDn = 0
'Validar que hay datos en las grillas y ya están seleccionadas
If grillaOtorg.Rows = 1 Then
    MsgBox "No hay datos para realizar el Intercambio!", vbExclamation, TITSISTEMA
    Exit Sub
End If
If grillaDisp.Rows = 1 Then
    MsgBox "No hay datos para realizar el Intercambio!", vbExclamation, TITSISTEMA
    Exit Sub
End If
If grillaOtorg.Rows = 2 Then
    If FilaVacia(grillaOtorg, 1) Then
        MsgBox "No hay datos para realizar el Intercambio!", vbExclamation, TITSISTEMA
        Exit Sub
    End If
End If
If grillaDisp.Rows = 2 Then
    If FilaVacia(grillaDisp, 1) Then
        MsgBox "No hay datos para realizar el Intercambio!", vbExclamation, TITSISTEMA
        Exit Sub
    End If
End If
'¿Hay Garantías Seleccionadas?
If Not Seleccionadas(grillaOtorg) Then
    MsgBox "No hay garantías Otorgadas seleccionadas para intercambiar!", vbExclamation, TITSISTEMA
    Exit Sub
End If
If Not Seleccionadas(grillaDisp) Then
    MsgBox "No hay garantías Disponibles seleccionadas para intercambiar!", vbExclamation, TITSISTEMA
    Exit Sub
End If
If CDbl(txtMontoCubierto.Text) < CDbl(txtTotalIntercambiar.Text) Then
    MsgBox "El monto total de las garantías disponibles no alcanza para cubrir las garantías a intercambiar!", vbExclamation, TITSISTEMA
    Exit Sub
End If
If MsgBox("¿Confirma el intercambio entre las garantías seleccionadas?", vbYesNoCancel + vbQuestion, TITSISTEMA) <> vbYes Then
    Exit Sub
End If
'Recorrer grillaOtorg y marcar con * la columna 9 si la columna 1 = Sí
Dim I As Integer
For I = 1 To grillaOtorg.Rows - 1
    If grillaOtorg.TextMatrix(I, 0) = "Sí" Then
        grillaOtorg.TextMatrix(I, 10) = "*"
        marcadosUp = marcadosUp + 1
    End If
Next I
'Recorrer grillaDisp...
For I = 1 To grillaDisp.Rows - 1
    If grillaDisp.TextMatrix(I, 0) = "Sí" Then
        grillaDisp.TextMatrix(I, 7) = "*"
        marcadosDn = marcadosDn + 1
    End If
Next I
'Bloquear las grillas hata que se grabe o se limpie...
If marcadosUp = 0 Then
    If marcadosDn > 0 Then
        'Desmarcar todos los marcados en grillaDisp
        For I = 1 To grillaDisp.Rows - 1
            If grillaDisp.TextMatrix(I, 7) = "*" Then
                grillaDisp.TextMatrix(I, 7) = ""
            End If
        Next I
    End If
End If
If marcadosDn = 0 Then
    If marcadosUp > 0 Then
        'Desmarcar todos los marcados en grillaOtorg
        For I = 1 To grillaOtorg.Rows - 1
            If grillaOtorg.TextMatrix(I, 10) = "*" Then
                grillaOtorg.TextMatrix(I, 10) = ""
            End If
        Next I
    End If
End If
If marcadosUp > 0 And marcadosDn > 0 Then
    'Realizar el intercambio de las garantías
    Call IntercambiarGtias
    'grillaOtorg.Enabled = False
    'grillaDisp.Enabled = False
    Toolbar1.Buttons(4).Enabled = True
    
End If
End Sub
Private Function Seleccionadas(ByVal Grilla As MSFlexGrid) As Boolean
Dim selecc As Long
Dim I As Integer
Seleccionadas = True
selecc = 0
For I = 1 To Grilla.Rows - 1
    If Grilla.TextMatrix(I, 0) = "Sí" Then
        selecc = selecc + 1
    End If
Next I
If selecc = 0 Then
    Seleccionadas = False
End If
End Function

Private Function IntercambiarGtias() As Boolean
Dim NumOper As String
Dim mayorFechaVig As Date
Dim I As Long
For I = 1 To grillaOtorg.Rows - 1
    If grillaOtorg.TextMatrix(I, 10) = "*" And grillaOtorg.TextMatrix(I, 0) = "Sí" Then
        NumOper = grillaOtorg.TextMatrix(I, 7)
        mayorFechaVig = CDate(grillaOtorg.TextMatrix(I, 6))
        If Trim(NumOper) <> "" Then
            Exit For
        End If
    End If
Next I

'----Primero, mover gtias. de grillaOtorg a grillaDisp

'Tomo una garantia de grillaOtorg, la "muevo" a grillaGtia y le desmarco el "*"
'Ciclo al revés porque voy a sacar fisicamente filas de la grilla
For I = grillaOtorg.Rows - 1 To 1 Step -1
    If grillaOtorg.TextMatrix(I, 10) = "*" And grillaOtorg.TextMatrix(I, 0) = "Sí" Then
    
        If CDate(grillaOtorg.TextMatrix(I, 6)) > mayorFechaVig Then
            mayorFechaVig = CDate(grillaOtorg.TextMatrix(I, 6))
        End If
        
        If MoverGtiaOtorg(I, NumOper) = True Then
            If I = 1 And grillaOtorg.Rows = 2 Then
                Call Vaciarfila(grillaOtorg, I)
            Else
                grillaOtorg.RemoveItem (I)
            End If
        End If
        
    End If
Next I

'---- Segundo, mover gtias. de grillaDisp a grillaOtorg
For I = grillaDisp.Rows - 1 To 1 Step -1
    If grillaDisp.TextMatrix(I, 7) = "*" And grillaDisp.TextMatrix(I, 0) = "Sí" Then
        If MoverGtiaDisp(I, NumOper, mayorFechaVig) = True Then
            If I = 1 And grillaDisp.Rows = 2 Then
                Call Vaciarfila(grillaOtorg, I)
            Else
                grillaDisp.RemoveItem (I)
            End If
        End If
    End If

Next I
'Ordenar la grilla grillaOtorg por la columna 8 (Operacion)
Call OrdenarOtorg(1, 8)
'Dejar habilitadas solo las opciones de Limpiar, Grabar o Salir
Toolbar1.Buttons(1).Enabled = True
Toolbar1.Buttons(2).Enabled = False
Toolbar1.Buttons(3).Enabled = False
Toolbar1.Buttons(4).Enabled = True
Toolbar1.Buttons(5).Enabled = True
Estado = False
End Function
Private Function MoverGtiaOtorg(ByVal posicion As Long, ByVal nOper As String) As Boolean
Dim Fila As Long
Dim I As Long
On Error GoTo fallaMover

'Mueve fila en posicion "posicion" de la grilla grillaOtorg a la cola de la grilla grillaDisp
'cambia marcador de "*" a "M" solo para efectos de reconocerla al grabar
'Antes de agregar fila, ver si la actual está disponible (vacía)

    If Not FilaVacia(grillaDisp, grillaDisp.Rows - 1) Then
        'No está vacía, agregar
        grillaDisp.Rows = grillaDisp.Rows + 1
    End If
    
    Fila = grillaDisp.Rows - 1
    grillaDisp.TextMatrix(Fila, 0) = "--"
    
    'Mover las columnas una a una
    
    grillaDisp.TextMatrix(Fila, 1) = grillaOtorg.TextMatrix(posicion, 2)    'Instrumento
    grillaDisp.TextMatrix(Fila, 2) = grillaOtorg.TextMatrix(posicion, 3)    'Moneda
    grillaDisp.TextMatrix(Fila, 3) = grillaOtorg.TextMatrix(posicion, 4)    'Nominal
    grillaDisp.TextMatrix(Fila, 4) = grillaOtorg.TextMatrix(posicion, 7)    'Valor Presente
    grillaDisp.TextMatrix(Fila, 5) = Format(grillaOtorg.TextMatrix(posicion, 8), FEntero)   'N° Documento
    grillaDisp.TextMatrix(Fila, 6) = grillaOtorg.TextMatrix(posicion, 9)    'Correlativo
    grillaDisp.TextMatrix(Fila, 7) = "M"
    grillaDisp.TextMatrix(Fila, 10) = grillaOtorg.TextMatrix(posicion, 1)
    grillaDisp.TextMatrix(Fila, 11) = grillaOtorg.TextMatrix(posicion, 13)
    
    Call PintaFila(grillaDisp, Fila, colRojo, grillaDisp.BackColor)
    
    MoverGtiaOtorg = True
    Exit Function
    
fallaMover:
    MoverGtiaOtorg = False
End Function
Private Function OrdenarOtorg(ByVal sentido As Integer, ByVal Fila As Long) As Boolean
Dim sOrden As SortSettings
Select Case sentido
    Case 1
        sOrden = flexSortStringAscending
    Case -1
        sOrden = flexSortStringDescending
End Select
grillaOtorg.Col = Fila
grillaOtorg.ColSel = Fila
grillaOtorg.Row = 1
grillaOtorg.RowSel = 1
grillaOtorg.Sort = sOrden
OrdenarOtorg = True
End Function
Private Function MoverGtiaDisp(ByVal posicion As Long, ByVal nOper As String, ByVal fechaVigencia As Date) As Boolean
Dim Fila As Long
Dim I As Long
On Error GoTo fallaMover
'Mueve fila en posicion "posicion" de la grilla grillaDisp a la cola de la grilla grillaOtorg
'cambia marcador de "*" a "M" solo para efectos de reconocerla al grabar

'Antes de agregar fila, ver si la actual está disponible (vacía)
If Not FilaVacia(grillaOtorg, grillaOtorg.Rows - 1) Then
    'No está vacía, agregar
    grillaOtorg.Rows = grillaOtorg.Rows + 1
End If

'grillaOtorg.Rows = grillaOtorg.Rows + 1
Fila = grillaOtorg.Rows - 1
grillaOtorg.TextMatrix(Fila, 0) = "--"
'Mover una a una las columnas en fila = "fila"
grillaOtorg.TextMatrix(Fila, 2) = grillaDisp.TextMatrix(posicion, 1) 'Instrumento
grillaOtorg.TextMatrix(Fila, 3) = grillaDisp.TextMatrix(posicion, 2) 'Moneda
grillaOtorg.TextMatrix(Fila, 4) = grillaDisp.TextMatrix(posicion, 3) 'Nominal
grillaOtorg.TextMatrix(Fila, 5) = gsbac_fecp
grillaOtorg.TextMatrix(Fila, 6) = fechaVigencia
grillaOtorg.TextMatrix(Fila, 7) = grillaDisp.TextMatrix(posicion, 4) 'Valor Presente <-- Valor Pte. Actualizado
grillaOtorg.TextMatrix(Fila, 8) = Format(grillaDisp.TextMatrix(posicion, 5), FEntero) 'N° Docto.
grillaOtorg.TextMatrix(Fila, 9) = grillaDisp.TextMatrix(posicion, 6) 'Correlativo
grillaOtorg.TextMatrix(Fila, 10) = "M"
grillaOtorg.TextMatrix(Fila, 11) = grillaDisp.TextMatrix(posicion, 8)
grillaOtorg.TextMatrix(Fila, 12) = grillaDisp.TextMatrix(posicion, 9)

Call PintaFila(grillaOtorg, Fila, colRojo, grillaOtorg.BackColor)
MoverGtiaDisp = True
Exit Function
fallaMover:
MoverGtiaDisp = False
End Function
Private Sub Filtrar()
Dim vacias As Long, I As Long
vacias = 0
    If grillaOtorg.Rows <= 2 Then
        For I = 1 To grillaOtorg.Rows - 1
            If FilaVacia(grillaOtorg, I) Then
                vacias = vacias + 1
            End If
        Next I
        If (vacias = grillaOtorg.Rows - 1) Then
            'No traer datos pues no hay filas en la grilla de garantías otorgadas
            MsgBox "La grilla de Garantías Otorgadas está vacía!", vbInformation, TITSISTEMA
            Exit Sub
        End If
    End If

    CarterasFinancieras = ""
    CarterasNormativas = ""

    Dim miForm As String
    miForm = Me.Name

    FRM_FILTRO_CARTERA.Tag = miForm

    Call FRM_FILTRO_CARTERA.Show(vbModal)
        
    Call LLenaGrillaDisp
    Toolbar1.Buttons(2).Enabled = False
End Sub

Private Sub txtCodCliente_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
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
        txtRutCliente.Text = objCliente.clrut
        txtCodCliente.Text = objCliente.clcodigo
        txtNomCliente.Text = objCliente.clnombre
        Call LlenagrillaOtorg
        If grillaOtorg.Enabled And grillaDisp.Enabled Then
            txtRutCliente.Enabled = False
            txtCodCliente.Enabled = False
            txtNomCliente.Enabled = False
        End If
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
    'Arm Se implementa nuevo formulario de Ayuda
    BacAyudaCliente.Tag = "MDCL"
    BacAyudaCliente.Show 1
    If giAceptar% = True Then
        txtRutCliente.Text = Val(gsrut$)
        txtCodCliente.Text = gsValor$
        txtNomCliente.Text = gsDescripcion$
        Call LlenagrillaOtorg
        'Call LLenagrillaDisp
        If grillaOtorg.Enabled And grillaDisp.Enabled Then
            txtRutCliente.Enabled = False
            txtCodCliente.Enabled = False
            txtNomCliente.Enabled = False
        End If
     giAceptar% = False
    End If

End Sub
Private Sub LlenagrillaOtorg()
Dim Fila As Integer
Dim Otorg As Integer
Dim Datos()


    Envia = Array()
    AddParam Envia, CLng(txtRutCliente.Text)
    AddParam Envia, CInt(txtCodCliente.Text)
    
    If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_RETGTIASOTORGADASCLIENTE", Envia) Then
        MsgBox "Error al buscar Garantías Otorgadas!", vbExclamation, TITSISTEMA
        Exit Sub
    End If
    
    If grillaOtorg.Enabled = False Then
        grillaOtorg.Enabled = True
    End If
    
    grillaOtorg.Clear
    grillaOtorg.Rows = 2
    
    Call FormateagrillaOtorg
    
    Fila = 1
    Otorg = 0
    
    Do While Bac_SQL_Fetch(Datos())
    
        With grillaOtorg
            .TextMatrix(Fila, 0) = "No"
            .TextMatrix(Fila, 1) = Format(Datos(1), FEntero)        'N° Garantia
            .TextMatrix(Fila, 2) = Datos(3)         'Instrumento
            .TextMatrix(Fila, 3) = Datos(4)         'Moneda
            .TextMatrix(Fila, 4) = Format(Datos(9), FDecimal)   'Nominal
            .TextMatrix(Fila, 5) = Datos(7)                     'Fecha Inicio
            .TextMatrix(Fila, 6) = Datos(8)                     'Fecha Vigencia
            .TextMatrix(Fila, 7) = Format(Datos(10), FEntero)  'Valor Presente
            .TextMatrix(Fila, 8) = Format(Datos(11), FEntero)                   'Operacion
            .TextMatrix(Fila, 9) = Datos(2)     'Correlativo
            .TextMatrix(Fila, 10) = ""      'Marca
            .TextMatrix(Fila, 11) = Datos(12)      'TIR, oculto
            .TextMatrix(Fila, 12) = Datos(13)      'VPAR, oculto
            .TextMatrix(Fila, 13) = Datos(14)       ' tipo garajmntia
            
            Otorg = Otorg + 1
            Fila = Fila + 1
            .Rows = .Rows + 1
        End With
        
    Loop
    
    If Otorg > 0 Then
        grillaOtorg.Rows = grillaOtorg.Rows - 1
    End If
    
    If Otorg = 0 Then
        MsgBox "El cliente no registra Garantías asociadas a Operaciones!", vbInformation, TITSISTEMA
        grillaOtorg.Enabled = False
        Exit Sub
    End If
    
End Sub
Private Sub LLenaGrillaDisp()
Dim Fila As Integer
Dim sumaGtias As Double
Dim cntGtias As Integer

    sumaGtias = 0#
    cntGtias = 0

    vienen = 0
    Envia = Array()
    AddParam Envia, gsBAC_User
    AddParam Envia, CarterasFinancieras
    AddParam Envia, CarterasNormativas
    AddParam Envia, Me.hWnd

    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_FILTRO_CARTERA_PARA_OTORGAR", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
        Exit Sub
    End If


    If grillaDisp.Enabled = False Then
        grillaDisp.Enabled = True
    End If
    
With grillaDisp
    .Clear
    .Rows = 2
    Call FormateaGrillaDisp
    Fila = 1
    Do While Bac_SQL_Fetch(Datos())
        .TextMatrix(Fila, 0) = "No"
        .TextMatrix(Fila, 1) = Datos(1)        'Instrumento
        .TextMatrix(Fila, 2) = Datos(2)        'Moneda
        .TextMatrix(Fila, 3) = Format(CDbl(Datos(3)), FDecimal)     'Nominal
        .TextMatrix(Fila, 4) = Format(CDbl(Datos(8)), FEntero)     'Valor Presente
        .TextMatrix(Fila, 5) = Format(CDbl(Datos(13)), FEntero)     'N° docto.
        .TextMatrix(Fila, 6) = Format(CDbl(Datos(14)), FEntero)    'Correlativo
        .TextMatrix(Fila, 7) = ""
        .TextMatrix(Fila, 8) = Datos(4)     'TIR, campo oculto
        .TextMatrix(Fila, 9) = Datos(5)    'Valor Par, campo oculto
        cntGtias = cntGtias + 1
        Fila = Fila + 1
        .Rows = .Rows + 1
    Loop
    If cntGtias > 0 Then
        'Borrar la ultima fila
        .Rows = .Rows - 1
    End If
End With

If cntGtias = 0 Then
    'bloquear grabar e intercambiar
    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(4).Enabled = False
    MsgBox "Atención! El cliente no tiene Instrumentos disponibles para realizar Intercambios!", vbExclamation, TITSISTEMA
    grillaDisp.Enabled = False
    Exit Sub
End If
'habilitar asociar
Toolbar1.Buttons(3).Enabled = True
'Deshabilitar filtro
Toolbar1.Buttons(2).Enabled = False


End Sub



Private Function MarcaOperacion(ByVal xfila As Long) As Boolean

    If grillaDisp.Enabled = False Then
        MsgBox "El instrumento no se puede marcar pues no hay Garantías Disponibles para operar!", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    With grillaOtorg
        If .TextMatrix(xfila, 10) = "*" Then
            MsgBox "El instrumento está marcado para Intercambio!", vbExclamation, TITSISTEMA
            Exit Function
        End If
        If .TextMatrix(xfila, 0) = "Sí" Then
            MsgBox "El instrumento ya estaba marcado!", vbInformation, TITSISTEMA
            Exit Function
        End If
        
        If numDocOtorg <> "" Then
            If .TextMatrix(xfila, 1) <> numDocOtorg Then
                MsgBox "Atención!, los instrumentos no pueden pertenecer a distintas garantias!", vbExclamation, TITSISTEMA
                Exit Function
            End If
        End If
        
        .TextMatrix(xfila, 0) = "Sí"
        
    End With
    
    numOperSel = numOperSel + 1
    
    numDocOtorg = grillaOtorg.TextMatrix(xfila, 1)
    
    txtTotalIntercambiar.Text = Format(CDbl(txtTotalIntercambiar.Text) + CDbl(grillaOtorg.TextMatrix(xfila, 7)), FDecimal)
    
    If CDbl(txtMontoCubierto.Text) >= CDbl(txtTotalIntercambiar.Text) Then
        txtMontoCubierto.ForeColor = colAzulOsc
    Else
        txtMontoCubierto.ForeColor = vbRed
    End If
    Call PintaFila(grillaOtorg, xfila, colSelec, colFondo)
End Function
Private Function DesmarcaOperacion(ByVal xfila As Long) As Boolean
    With grillaOtorg
        If .TextMatrix(xfila, 10) = "*" Then
            MsgBox "El instrumento está marcado para Intercambio!", vbExclamation, TITSISTEMA
            Exit Function
        End If
        If .TextMatrix(xfila, 0) = "No" Then
            MsgBox "El instrumento no está marcado!", vbInformation, TITSISTEMA
            Exit Function
        End If
        .TextMatrix(xfila, 0) = "No"
    End With
    numOperSel = numOperSel - 1
    
    If numOperSel = 0 Then
        numDocOtorg = ""
    End If
    
    txtTotalIntercambiar.Text = Format(CDbl(txtTotalIntercambiar.Text) - CDbl(grillaOtorg.TextMatrix(xfila, 7)), FDecimal)
    If CDbl(txtMontoCubierto.Text) >= CDbl(txtTotalIntercambiar.Text) Then
        txtMontoCubierto.ForeColor = colAzulOsc
    Else
        txtMontoCubierto.ForeColor = vbRed
    End If
    Call PintaFila(grillaOtorg, xfila, colorFore, colorBack)
End Function
Private Function MarcaGarantia(ByVal xfila As Long) As Boolean
Dim resul As String
    'Revisar primero si la grilla opuesta está Enabled
    If grillaOtorg.Enabled = False Then
        MsgBox "La Garantía no se puede marcar pues no hay Garantías Otorgadas para operar!", vbExclamation, TITSISTEMA
        Exit Function
    End If
    With grillaDisp
        If Trim(.TextMatrix(xfila, 7)) = "*" Then
            MsgBox "La Garantía está seleccionada para Intercambio!", vbExclamation, TITSISTEMA
            Exit Function
        End If
        If .TextMatrix(xfila, 0) = "Sí" Then
            MsgBox "La Garantía ya estaba marcada!", vbInformation, TITSISTEMA
            Exit Function
        End If
        'Marcar la Operación, si se puede
        resul = MarcarMDBL(grillaDisp.TextMatrix(xfila, 5), grillaDisp.TextMatrix(xfila, 6), "M")
        If resul = "Error" Then
            'Se produjo un error Sql y no se pudo consultar la operación!
            MsgBox "Se ha producido un error en el servidor al consultar la operación!", vbExclamation, tisistema
            Exit Function
        ElseIf resul = "NO" Then
            'No se pudo marcar, está ocupado --> sacarlo de la grilla
            If xfila = 1 Then
                Call Vaciarfila(grillaDisp, xfila)
            Else
                grillaDisp.RemoveItem (xfila)
            End If
            MsgBox "La operación se encuentra ocupada y no es posible asociarla." & vbCrLf & "La operación ha sido eliminada de la grilla de trabajo.", vbInformation, TITSISTEMA
            Exit Function
        End If
        .TextMatrix(xfila, 0) = "Sí"
    End With
    numGtiaSel = numGtiaSel + 1
    
    txtMontoCubierto.Text = Format(CDbl(txtMontoCubierto.Text) + CDbl(grillaDisp.TextMatrix(xfila, 4)), FDecimal)
    
    If CDbl(txtMontoCubierto.Text) >= CDbl(txtTotalIntercambiar.Text) Then
        txtMontoCubierto.ForeColor = colAzulOsc
    Else
        txtMontoCubierto.ForeColor = vbRed
    End If
    
    Call PintaFila(grillaDisp, xfila, colSelec, colFondg)
End Function
Private Function MarcarMDBL(ByVal NumOper As String, ByVal Correl As String, ByVal modo As String) As String
Dim Datos()
MarcarMDBL = "NO"
If modo = "M" Then
    Envia = Array()
    AddParam Envia, CDbl(NumOper)
    AddParam Envia, CDbl(Correl)
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_GAR_OPERSINMARCAR", Envia) Then
        MarcarMDBL = "Error"
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) = "NO" Then 'Está ocupada la operación
        MarcarMDBL = "NO"
        Exit Function
        End If
    End If
    'La operación está libre...! Marcarla!
End If
Envia = Array()
AddParam Envia, modo
AddParam Envia, CDbl(NumOper)
AddParam Envia, CDbl(Correl)
AddParam Envia, gsBAC_User
AddParam Envia, Me.hWnd
AddParam Envia, CDbl(txtRutCliente.Text)
If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_GAR_MARCAROPERACION", Envia) Then
    MarcarMDBL = "Error"
    Exit Function
End If
If Bac_SQL_Fetch(Datos()) Then
    MarcarMDBL = Datos(1)
End If
End Function
Private Function DesmarcaGarantia(ByVal xfila As Long, Optional ByVal Silencio As Boolean = False) As Boolean
    With grillaDisp
        If Trim(.TextMatrix(xfila, 7)) = "*" Then
            MsgBox "La Garantía está seleccionada para Intercambio!", vbExclamation, TITSISTEMA
            DesmarcaGarantia = False
            Exit Function
        End If
        If .TextMatrix(xfila, 0) = "No" Then
            MsgBox "La Garantía no está marcada!", vbInformation, TITSISTEMA
            DesmarcaGarantia = False
            Exit Function
        End If
        'Desmarcar la Operación
        resul = MarcarMDBL(grillaDisp.TextMatrix(xfila, 5), grillaDisp.TextMatrix(xfila, 6), "D")
        If resul = "Error" And Not Silencio Then
            'Se produjo un error Sql y no se pudo consultar la operación!
            MsgBox "Se ha producido un error en el servidor al consultar la operación!", vbExclamation, tisistema
            DesmarcaGarantia = False
            Exit Function
        ElseIf resul = "NO" And Not Silencio Then
            'No se pudo desmarcar
            MsgBox "No fue posible desmarcar la operación!", vbExclamation, TITSISTEMA
            DesmarcaGarantia = False
            Exit Function
        End If
        DesmarcaGarantia = True
        .TextMatrix(xfila, 0) = "No"
    End With
    numGtiaSel = numGtiaSel - 1
    txtMontoCubierto.Text = Format(CDbl(txtMontoCubierto.Text) - CDbl(grillaDisp.TextMatrix(xfila, 4)), FDecimal)
    If CDbl(txtMontoCubierto.Text) >= CDbl(txtTotalIntercambiar.Text) Then
        txtMontoCubierto.ForeColor = colAzulOsc
    Else
        txtMontoCubierto.ForeColor = vbRed
    End If
    Call PintaFila(grillaDisp, xfila, colorFore, colorBack)
End Function
Private Function DesmarcaIntercambiado(ByVal xfila As Long, Optional ByVal Silencio As Boolean = False) As Boolean
    With grillaOtorg
        'Desmarcar la Operación
        resul = MarcarMDBL(.TextMatrix(xfila, 8), .TextMatrix(xfila, 9), "D")
        If resul = "Error" And Not Silencio Then
            MsgBox "Se ha producido un error en el servidor al consultar la operación!", vbExclamation, tisistema
            DesmarcaIntercambiado = False
            Exit Function
        ElseIf resul = "NO" And Not Silencio Then
            'No se pudo desmarcar
            MsgBox "No fue posible desmarcar la operación!", vbExclamation, TITSISTEMA
            DesmarcaIntercambiado = False
            Exit Function
        End If
        DesmarcaIntercambiado = True
    End With
End Function
Private Function DesmarcarTodasFilas() As Boolean
Dim I As Long, dm As Long, mc As Long
dm = 0
mc = 0
With grillaDisp
    For I = 1 To .Rows - 1
        If .TextMatrix(I, 0) = "Sí" Then
            mc = mc + 1
            If DesmarcaGarantia(I, True) Then
                dm = dm + 1
            End If
        End If
    Next I
End With
If dm = mc Then
    DesmarcarTodasFilas = True
Else
    DesmarcarTodasFilas = False
End If
End Function
Private Function DesmarcarTodosIntercambiados() As Boolean
Dim I As Long, dm As Long, mc As Long
dm = 0
mc = 0
With grillaOtorg
    For I = 1 To .Rows - 1
        If .TextMatrix(I, 0) = "--" And .TextMatrix(I, 10) = "M" Then
            mc = mc + 1
            If DesmarcaIntercambiado(I, True) Then
                dm = dm + 1
            End If
        End If
    Next I
End With
If dm = mc Then
    DesmarcarTodosIntercambiados = True
Else
    DesmarcarTodosIntercambiados = False
End If
End Function
Private Function Grabar() As Boolean
Dim Error               As Boolean
Dim codSistema          As String
Dim numOperacion        As Double
Dim I                   As Long
Dim cntOtorg            As Long
Dim cntDisp             As Long
Dim okOtorg             As Long
Dim okDisp              As Long
Dim nNumfolio           As Long
Dim iTipoGarantia       As Long
Dim dFechaVig           As Date

    If grillaOtorg.Enabled = False Then
        grillaOtorg.Enabled = True
    End If
    
    If grillaDisp.Enabled = False Then
        grillaDisp.Enabled = True
    End If
    
'Utilizar solo las filas con una "M" en la columna 10 (grillaOtorg) y 8 (grillaDisp)

    Error = False
    cntOtorg = 0
    cntDisp = 0
    okOtorg = 0
    okDisp = 0
    
    
    For I = 1 To grillaOtorg.Rows - 1
        If grillaOtorg.TextMatrix(I, 0) = "--" And grillaOtorg.TextMatrix(I, 10) = "M" Then
            dFechaVig = grillaOtorg.TextMatrix(I, 6)
            cntOtorg = cntOtorg + 1
        End If
    Next I
    
    For I = 1 To grillaDisp.Rows - 1
        If grillaDisp.TextMatrix(I, 0) = "--" And grillaDisp.TextMatrix(I, 7) = "M" Then
            iTipoGarantia = grillaDisp.TextMatrix(I, 11)


            cntDisp = cntDisp + 1
        End If
    Next I

    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        MsgBox "Se ha producido un error en el servidor que impide grabar las Garantías!", vbExclamation, TITSISTEMA
        Grabar = False
        Exit Function
    End If
    
    If Not Bac_Sql_Execute("dbo.SP_GAR_NUMFOLIO_GARANTIAS_OTORGADAS") Then
        Let Screen.MousePointer = vbDefault
        GoTo ErrTransaction
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        Let nNumfolio = Datos(1)  ''--> aGREGAR EL TIPO DE GARANTIA
    End If

    Envia = Array()
    
    AddParam Envia, nNumfolio
    AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
    AddParam Envia, Str(Me.txtRutCliente.Text)
    AddParam Envia, Str(Me.txtCodCliente.Text)
    AddParam Envia, Str(iTipoGarantia)
    AddParam Envia, Format(dFechaVig, "yyyymmdd")
    AddParam Envia, Str(0)
    
    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_GRABA_ENCABEZADO_GARANTIAS_OTORGADAS", Envia) Then
       Let Screen.MousePointer = vbDefault
       GoTo ErrTransaction
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) <> 0 Then
            GoTo ErrTransaction
        End If
    End If
    
    
    For I = 1 To grillaOtorg.Rows - 1
    
        If grillaOtorg.TextMatrix(I, 0) = "--" And grillaOtorg.TextMatrix(I, 10) = "M" Then
    
            Envia = Array()
            
            AddParam Envia, nNumfolio
            AddParam Envia, Str(grillaOtorg.TextMatrix(I, 8))
            AddParam Envia, Str(grillaOtorg.TextMatrix(I, 9))
            AddParam Envia, grillaOtorg.TextMatrix(I, 2)
            AddParam Envia, Str(grillaOtorg.TextMatrix(I, 4))
            AddParam Envia, Str(grillaOtorg.TextMatrix(I, 11))
            AddParam Envia, Str(grillaOtorg.TextMatrix(I, 12))
            AddParam Envia, Str(grillaOtorg.TextMatrix(I, 7))
            AddParam Envia, Str(1)
            
            If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_GRABA_DETALLE_GARANTIAS_OTORGADAS", Envia) Then
               Let Screen.MousePointer = vbDefault
               GoTo ErrTransaction
            End If
            
            If Bac_SQL_Fetch(Datos()) Then
                If Datos(1) <> 0 Then
                    GoTo ErrTransaction
                End If
            End If

    '        Envia = Array()
    '        AddParam Envia, CDate(grillaOtorg.TextMatrix(I, 5)) 'Fecha
    '        AddParam Envia, CDbl(txtRutCliente.Text)            'RutCliente
    '        AddParam Envia, CDbl(txtCodCliente.Text)            'CodCliente
    '        AddParam Envia, CDate(grillaOtorg.TextMatrix(I, 6)) 'Fecha Vigencia
    '        AddParam Envia, CDbl(grillaOtorg.TextMatrix(I, 8))  'N° Docto.
    '        AddParam Envia, CDbl(grillaOtorg.TextMatrix(I, 9))  'Correlativo
    '        AddParam Envia, grillaOtorg.TextMatrix(I, 2)        'Nemotécnico
    '        AddParam Envia, CDbl(grillaOtorg.TextMatrix(I, 4))  'Nominal
    '        AddParam Envia, CDbl(grillaOtorg.TextMatrix(I, 11)) 'TIR
    '        AddParam Envia, CDbl(grillaOtorg.TextMatrix(I, 12)) 'VPAR
    '        AddParam Envia, CDbl(grillaOtorg.TextMatrix(I, 7))  'Valor Presente
    '        If Not Bac_Sql_Execute("Bacparamsuda.dbo.sp_GrabaGtiasOtorgadas", Envia) Then
    '            Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
    '            MsgBox "Se ha producido un error en el servidor que impidió que se grabaran las operaciones!", vbExclamation, TITSISTEMA
    '            Grabar = False
    '            Exit Function
    '        End If
            okOtorg = okOtorg + 1
        End If
    Next I

    Dim iFolioGtias  As Long
    iFolioGtias = 0
    
    For I = 1 To grillaDisp.Rows - 1
    
        If grillaDisp.TextMatrix(I, 0) = "--" And grillaDisp.TextMatrix(I, 7) = "M" Then
        
            Envia = Array()
            AddParam Envia, Str(grillaDisp.TextMatrix(I, 10))    'Folio Garantia
            AddParam Envia, Str(grillaDisp.TextMatrix(I, 5))    'Numdocu
            AddParam Envia, Str(grillaDisp.TextMatrix(I, 6))    'Correlativo
            AddParam Envia, grillaDisp.TextMatrix(I, 1)         'Nemotecnico
            
            If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_BORRAGTIASOTORGADAS", Envia) Then
                GoTo ErrTransaction
                Grabar = False
                Exit Function
            End If
            
            If okDisp = 0 Then
                iFolioGtias = grillaDisp.TextMatrix(I, 10)
            End If
            

            okDisp = okDisp + 1
            
        End If
        
    Next I
    
    
    Envia = Array()
    AddParam Envia, Str(iFolioGtias)    'Folio Garantia
    
    If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_ACTUALIZAGTIASOTORGADAS", Envia) Then
        GoTo ErrTransaction
        Grabar = False
        Exit Function
    End If

    
    Call BacCommitTransaction
    
    MsgBox "El intercambio de garantías se ha grabado exitosamente!", vbInformation, TITSISTEMA
    Grabar = True
    
    Exit Function
    
ErrTransaction:
    MsgBox "Se ha producido un error en el proceso de grabacion, favor verifque informacion:" & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
    Call BacRollBackTransaction
    Exit Function


End Function

Private Sub txtRutCliente_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If Trim(txtRutCliente.Text) = "" Then
            Exit Sub
        End If
        SendKeys "{TAB}"
    End If
    If Not (KeyAscii > 47 And KeyAscii < 58 Or KeyAscii = 8) Then
        KeyAscii = 0
        BacCaracterNumerico KeyAscii
    End If
End Sub
