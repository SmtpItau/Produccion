VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_ASOCIA_GARANTIAS 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Asociación de Garantías con Operación"
   ClientHeight    =   7980
   ClientLeft      =   8040
   ClientTop       =   1950
   ClientWidth     =   6390
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7980
   ScaleWidth      =   6390
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame4 
      Height          =   615
      Left            =   0
      TabIndex        =   17
      Top             =   7320
      Width           =   6375
      Begin VB.Label lblMensaje 
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
         Width           =   6135
      End
   End
   Begin VB.Frame Frame3 
      Height          =   1575
      Left            =   0
      TabIndex        =   8
      Top             =   4800
      Width           =   6375
      Begin VB.TextBox txtValorRecFinal 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
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
         Left            =   3480
         TabIndex        =   16
         Top             =   1200
         Width           =   2655
      End
      Begin VB.TextBox txtFactorA 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
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
         Left            =   360
         TabIndex        =   14
         Top             =   1200
         Width           =   1455
      End
      Begin VB.TextBox txtFactorM 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
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
         Left            =   360
         TabIndex        =   11
         Top             =   480
         Width           =   1455
      End
      Begin VB.TextBox txtValorRec 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
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
         Left            =   3480
         TabIndex        =   9
         Top             =   480
         Width           =   2655
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Valor REC aplicados factores"
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
         Left            =   3480
         TabIndex        =   15
         Top             =   960
         Width           =   2505
      End
      Begin VB.Label Label5 
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
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   360
         TabIndex        =   13
         Top             =   960
         Width           =   1200
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Factor Multiplicativo"
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
         Left            =   240
         TabIndex        =   12
         Top             =   240
         Width           =   1740
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Valor REC original Operación"
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
         Left            =   3600
         TabIndex        =   10
         Top             =   240
         Width           =   2490
      End
   End
   Begin VB.Frame Frame2 
      Height          =   975
      Left            =   0
      TabIndex        =   3
      Top             =   6360
      Width           =   6375
      Begin VB.TextBox txtTotAsociado 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
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
         Left            =   3600
         TabIndex        =   6
         Top             =   240
         Width           =   2655
      End
      Begin VB.TextBox txtTotDisponible 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
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
         Left            =   3600
         TabIndex        =   4
         Top             =   600
         Width           =   2655
      End
      Begin VB.Label Label1 
         Caption         =   "Total Asociado a la Operación"
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
         Top             =   240
         Width           =   2655
      End
      Begin VB.Label Label2 
         Caption         =   "Total Disponible para Operaciones"
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
         TabIndex        =   5
         Top             =   600
         Width           =   3015
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Garantías Disponibles"
      Height          =   4215
      Left            =   0
      TabIndex        =   1
      Top             =   600
      Width           =   6375
      Begin VB.CommandButton Command2 
         BackColor       =   &H00800000&
         Height          =   255
         Left            =   4080
         Style           =   1  'Graphical
         TabIndex        =   21
         Top             =   3720
         Width           =   255
      End
      Begin VB.CommandButton Command1 
         BackColor       =   &H000040C0&
         Height          =   255
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   19
         Top             =   3720
         Width           =   255
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   3255
         Left            =   120
         TabIndex        =   2
         Top             =   240
         Width           =   6135
         _ExtentX        =   10821
         _ExtentY        =   5741
         _Version        =   393216
         Cols            =   5
         FixedCols       =   0
         BackColor       =   -2147483634
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   -2147483643
         BackColorSel    =   -2147483643
         ForeColorSel    =   8388608
         GridColorFixed  =   16777215
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
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "Garantía sin asociar"
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
         Left            =   4440
         TabIndex        =   22
         Top             =   3720
         Width           =   1740
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Garantía asociada"
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
         TabIndex        =   20
         Top             =   3720
         Width           =   1590
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6390
      _ExtentX        =   11271
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      DisabledImageList=   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Asociar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Desasociar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   7
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
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GARANTIAS.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GARANTIAS.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GARANTIAS.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GARANTIAS.frx":2C8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GARANTIAS.frx":2FA8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GARANTIAS.frx":3E82
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ASOCIA_GARANTIAS.frx":4D5C
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_ASOCIA_GARANTIAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public rRutCliente As Long
Public rCodCliente As Integer
Public rNumOper As Long
Public colorFore As Long
Public colorBack As Long
Public colSelec As Long

Private Sub FormateaGrilla()
With grilla
    .FixedRows = 1
    .ColWidth(0) = 500
    .ColWidth(1) = 1200
    .ColWidth(2) = 1400
    .ColWidth(3) = 2200
    .ColWidth(4) = 2000
    
    .FixedAlignment(0) = flexAlignLeft
    .FixedAlignment(1) = flexAlignRight
    .FixedAlignment(2) = flexAlignLeft
    .FixedAlignment(3) = flexAlignRight
    .FixedAlignment(4) = flexAlignLeft
    
    .TextMatrix(0, 0) = "Asoc."
    .TextMatrix(0, 1) = "N° Gtía."
    .TextMatrix(0, 2) = "Fecha Const."
    .TextMatrix(0, 3) = "Total Actualizado"
    .TextMatrix(0, 4) = "Fecha Vcto."
    
End With
End Sub
Private Sub Form_Load()
Dim vieneRec As Double
Call FormateaGrilla
colorFore = grilla.ForeColor
colorBack = grilla.BackColor
colSelec = &H40C0&
Call CargaParametrosGarantias
If Not LlenaGrilla() Then
    Exit Sub
End If
vieneRec = Gar_ValorRec
rNumOper = Gar_NumOper
rRutCliente = Gar_RutCliente
rCodCliente = Gar_CodCliente

Me.Caption = "Asociación de Garantías con Operación N° " & CStr(rNumOper)
txtValorRec.Text = Format(vieneRec, FDecimal)
End Sub
Private Sub CargaParametrosGarantias()
Dim vRecFin As Double
Dim vFactorM As Double
Dim vFactorA As Double
vFactorM = 0#
vFactorA = 0#
Dim DATOS()
Envia = Array()
If Not Bac_Sql_Execute("Bacparamsuda..SP_RETPARAMETROSGARANTIAS") Then
    MsgBox "Error al buscar Parámetros de Garantías!", vbExclamation, TITSISTEMA
    Exit Sub
End If
If Bac_SQL_Fetch(DATOS()) <> 0 Then
    vFactorM = CDbl(DATOS(2))
    vFactorA = CDbl(DATOS(3))
End If
txtFactorM.Text = Format(vFactorM, FDecimal)
txtFactorA.Text = Format(vFactorA, FDecimal)
vRecFin = Gar_ValorRec * vFactorM + vFactorA
txtValorRecFinal.Text = Format(vRecFin, FDecimal)
End Sub
Private Function LlenaGrilla() As Boolean
Dim fila As Integer
Dim sumaGtias As Double
Dim cntGtias As Integer
sumaGtias = 0#
cntGtias = 0
Dim DATOS()
Envia = Array()
AddParam Envia, Gar_RutCliente
AddParam Envia, Gar_CodCliente
If Not Bac_Sql_Execute("Bacparamsuda..SP_RETGARANTIASDISPONIBLES", Envia) Then
    MsgBox "Error al buscar Garantías Disponibles!", vbExclamation, TITSISTEMA
    LlenaGrilla = False
    Exit Function
End If
grilla.Clear
grilla.Rows = 2
Call FormateaGrilla
fila = 1
Do While Bac_SQL_Fetch(DATOS())
    grilla.TextMatrix(fila, 0) = "No"
    grilla.TextMatrix(fila, 1) = Format(CDbl(DATOS(1)), Fentero)
    grilla.TextMatrix(fila, 2) = DATOS(2)
    grilla.TextMatrix(fila, 3) = Format(CDbl(DATOS(3)), FDecimal)
    grilla.TextMatrix(fila, 4) = DATOS(4)
    sumaGtias = sumaGtias + CDbl(DATOS(3))
    cntGtias = cntGtias + 1
    fila = fila + 1
    grilla.Rows = grilla.Rows + 1
Loop
'Borrar la ultima fila
grilla.Rows = grilla.Rows - 1
txtTotAsociado.Text = Format(0#, FDecimal)
txtTotDisponible.Text = Format(sumaGtias, FDecimal)
If cntGtias = 0 Then
    MsgBox "Atención! El cliente no tiene Garantías disponibles para cubrir la operación!", vbExclamation, TITSISTEMA
    LlenaGrilla = False
    Exit Function
End If
LlenaGrilla = True
End Function
Private Sub grilla_DblClick()
    Dim fvGtia As Date
    Dim fila As Integer
    fila = grilla.RowSel
    If fila = 0 Then
        Exit Sub
    End If
    If grilla.TextMatrix(fila, 0) = "Sí" Then
        Call DesasociarGarantia
    Else
        fvGtia = CDate(grilla.TextMatrix(fila, 4))
        'Validar fecha Gtia contra fecha operacion
        If fvGtia < Gar_FvctoOper Then
            MsgBox "La Fecha de Vencimiento de la Garantía no debe ser inferior a la Fecha de Vencimiento de la Operación!", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        Call AsociarGarantia
    End If
End Sub
Private Sub AsociarGarantia()
    Dim fila As Integer
    Dim numGarantia As Long
    fila = grilla.RowSel
    If fila = 0 Then
        Exit Sub
    End If
    If grilla.TextMatrix(fila, 0) = "Sí" Then
        'La garantía de la fila ya estaba asociada
        Exit Sub
    End If
    numGarantia = CLng(grilla.TextMatrix(fila, 1))
    Call MarcarGarantia(numGarantia)
End Sub
Private Function MarcarGarantia(ByVal numero As Long) As Boolean
    'Marca y actualiza totales para cada una de las garantías con el número solicitado
    Dim i As Integer
    For i = 1 To grilla.Rows - 1
        If CLng(grilla.TextMatrix(i, 1)) = numero Then
            If grilla.TextMatrix(i, 0) <> "Sí" Then
                
                grilla.TextMatrix(i, 0) = "Sí"
                grilla.Row = i
                
                'grilla.Font.Bold = True
                Call PintaFila(i, colSelec, colorBack)
               
                txtTotAsociado.Text = Format(CDbl(txtTotAsociado.Text) + CDbl(grilla.TextMatrix(i, 3)), FDecimal)
                txtTotDisponible.Text = Format(CDbl(txtTotDisponible.Text) - CDbl(grilla.TextMatrix(i, 3)), FDecimal)
                If CDbl(txtTotAsociado.Text) >= CDbl(txtValorRecFinal.Text) Then
                    lblMensaje.ForeColor = vbBlue
                    lblMensaje.Caption = "El total de garantías asociadas es suficiente para cubrir la operación."
                Else
                    lblMensaje.ForeColor = vbRed
                    lblMensaje.Caption = "El total de garantías asociadas es insuficiente para cubrir la operación."
                End If
            End If
        End If
    Next i
End Function
Private Function PintaFila(ByVal fila As Integer, ByVal colF As Long, colB As Long) As Boolean
Dim i As Integer
For i = 0 To grilla.Cols - 1
    grilla.Row = fila
    grilla.Col = i
    grilla.CellForeColor = colF
    grilla.CellBackColor = colB
Next
End Function
Private Function DesmarcarGarantia(ByVal numero As Long) As Boolean
    'Desmarca y actualiza totales para cada una de las garantías con el número solicitado
    Dim i As Integer
    For i = 1 To grilla.Rows - 1
        If CLng(grilla.TextMatrix(i, 1)) = numero Then
            If grilla.TextMatrix(i, 0) <> "No" Then
                grilla.TextMatrix(i, 0) = "No"
                grilla.Row = i
                'grilla.Font.Bold = False
                Call PintaFila(i, colorFore, colorBack)
               
                txtTotAsociado.Text = Format(CDbl(txtTotAsociado.Text) - CDbl(grilla.TextMatrix(i, 3)), FDecimal)
                txtTotDisponible.Text = Format(CDbl(txtTotDisponible.Text) + CDbl(grilla.TextMatrix(i, 3)), FDecimal)
                If CDbl(txtTotAsociado.Text) >= CDbl(txtValorRecFinal.Text) Then
                    lblMensaje.ForeColor = vbBlue
                    lblMensaje.Caption = "El total de garantías asociadas es suficiente para cubrir la operación."
                Else
                    lblMensaje.ForeColor = vbRed
                    lblMensaje.Caption = "El total de garantías asociadas es insuficiente para cubrir la operación."
                End If
            End If
        End If
    Next i

End Function
Private Sub DesasociarGarantia()
    Dim fila As Integer
    Dim numGarantia As Long
    fila = grilla.RowSel
    If fila = 0 Then
        Exit Sub
    End If
    If grilla.TextMatrix(fila, 0) = "No" Then
        'La garantía de la fila ya estaba asociada
        Exit Sub
    End If
    numGarantia = CLng(grilla.TextMatrix(fila, 1))
    Call DesmarcarGarantia(numGarantia)
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim msgFalta As String
msgFalta = "Atención! El total de garantías asociadas no alcanza para cubrir la operación." & vbCrLf & "¿Desea salir sin grabar?"
Select Case Button.Index
    Case 1  'Asociar
        Call AsociarGarantia
    Case 2  'Desasociar
        Call DesasociarGarantia
    Case 3  'Grabar
        'Validar si el total de garantías asociadas alcanza para cubrir la operación
        If CDbl(txtTotAsociado.Text) < CDbl(txtValorRecFinal.Text) Then
            MsgBox "El total de garantías asociadas no alcanza para cubrir la operación!", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        'Grabar la asociación de las garantías con la operación
        Call GrabarGarantias
    Case 4  'Salir
        'Validar si el total de garantías asociadas alcanza para cubrir la operación
        If CDbl(txtTotAsociado.Text) < CDbl(txtValorRecFinal.Text) Then
            If MsgBox(msgFalta, vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
                Exit Sub
            End If
        End If
        Unload Me
End Select
End Sub
Private Sub GrabarGarantias()
Dim i As Integer
Dim grabados As String
Dim numGarantia As Long
Dim segrabo As Boolean
Dim nfallos As Integer
Dim nexitos As Integer
Dim msgOk As String
grabados = ""
nfallos = 0
nexitos = 0
For i = 1 To grilla.Rows - 1
    If grilla.TextMatrix(i, 0) = "Sí" Then
        numGarantia = CLng(grilla.TextMatrix(i, 1))
        segrabo = RevisarGrabados(grabados, numGarantia)
        If Not segrabo Then
            'Grabarlo
            If GrabaGarantia(numGarantia) Then
                grabados = grabados & grilla.TextMatrix(i, 1) & "-"
                nexitos = nexitos + 1
            Else
                nfallos = nfallos + 1
                MsgBox "Error al grabar garantía N° " & grilla.TextMatrix(i, 1), vbExclamation, TITSISTEMA
            End If
        End If
    End If
Next i
If nfallos = 0 Then
    If nexitos = 1 Then
        msgOk = "La garantía se grabó exitosamente."
    Else
        msgOk = "Las garantías se grabaron exitosamente."
    End If
        MsgBox msgOk, vbInformation, TITSISTEMA
        Unload Me
End If
End Sub
Private Function GrabaGarantia(ByVal numeroGtia As Long) As Boolean
Dim DATOS()
Envia = Array()
AddParam Envia, numeroGtia
AddParam Envia, rRutCliente
AddParam Envia, rCodCliente
AddParam Envia, Sistema
AddParam Envia, rNumOper
If Bac_Sql_Execute("Bacparamsuda..SP_GRABAOPERGARANTIAS", Envia) Then
    GrabaGarantia = True
Else
    GrabaGarantia = False
End If
End Function
Private Function RevisarGrabados(ByVal lista As String, ByVal revisar As Long) As Boolean
Dim Cual As String
Cual = CStr(revisar)
If InStr(1, lista, Cual) > 0 Then
    RevisarGrabados = True
Else
    RevisarGrabados = False
End If
End Function
