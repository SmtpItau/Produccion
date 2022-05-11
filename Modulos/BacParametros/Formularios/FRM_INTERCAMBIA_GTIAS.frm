VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_INTERCAMBIA_GTIASC 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Intercambio de Garantías Constituídas"
   ClientHeight    =   8565
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   15105
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8565
   ScaleWidth      =   15105
   Begin VB.Frame Frame7 
      Caption         =   "Valor Total a cubrir de Op. Asociadas"
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
      Left            =   11280
      TabIndex        =   20
      Top             =   600
      Width           =   3735
      Begin VB.Label lblDifCubrir 
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
         ForeColor       =   &H00C00000&
         Height          =   255
         Left            =   120
         TabIndex        =   22
         Top             =   240
         Width           =   3495
      End
   End
   Begin VB.Frame Frame6 
      Caption         =   "Mayor F. Vcto. Oper."
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
      Left            =   9120
      TabIndex        =   19
      Top             =   600
      Width           =   2055
      Begin VB.Label lblMayorFecha 
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
         ForeColor       =   &H00C00000&
         Height          =   255
         Left            =   120
         TabIndex        =   21
         Top             =   240
         Width           =   1815
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Operaciones Asociadas"
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
      Height          =   3735
      Left            =   11880
      TabIndex        =   17
      Top             =   1200
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
         Height          =   3375
         Left            =   120
         TabIndex        =   18
         Top             =   240
         Width           =   2895
      End
   End
   Begin VB.Frame Frame4 
      Height          =   615
      Left            =   0
      TabIndex        =   15
      Top             =   7850
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
         Left            =   480
         TabIndex        =   16
         Top             =   240
         Width           =   3795
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Monto Total cubierto por Garantías Disponibles"
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
      TabIndex        =   11
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
         TabIndex        =   12
         Text            =   "0.0000"
         Top             =   240
         Width           =   4455
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
      Height          =   2775
      Left            =   0
      TabIndex        =   9
      Top             =   5040
      Width           =   13935
      Begin MSFlexGridLib.MSFlexGrid grillaGtias 
         Height          =   2415
         Left            =   120
         TabIndex        =   10
         Top             =   240
         Width           =   13695
         _ExtentX        =   24156
         _ExtentY        =   4260
         _Version        =   393216
         Cols            =   10
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
   Begin VB.Frame Frame1 
      Height          =   615
      Left            =   0
      TabIndex        =   7
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
         TabIndex        =   8
         Top             =   240
         Width           =   3795
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
      TabIndex        =   5
      Top             =   600
      Width           =   9015
      Begin VB.TextBox txtNomCliente 
         BackColor       =   &H00FFFFFF&
         Enabled         =   0   'False
         Height          =   285
         Left            =   2400
         TabIndex        =   6
         Top             =   240
         Width           =   6495
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
         TabIndex        =   0
         Top             =   240
         Width           =   1575
      End
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
         TabIndex        =   1
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.Frame frmOperaciones 
      Caption         =   "Garantías Asociadas a Operaciones"
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
      TabIndex        =   2
      Top             =   1200
      Width           =   11775
      Begin MSFlexGridLib.MSFlexGrid grillaAsoc 
         Height          =   2775
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   11535
         _ExtentX        =   20346
         _ExtentY        =   4895
         _Version        =   393216
         Cols            =   10
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
      TabIndex        =   4
      Top             =   0
      Width           =   15105
      _ExtentX        =   26644
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
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Intercambiar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   10
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
         NumListImages   =   11
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIAS.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIAS.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIAS.frx":275C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIAS.frx":2A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIAS.frx":2D90
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIAS.frx":30AA
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIAS.frx":3F84
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIAS.frx":429E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIAS.frx":5178
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIAS.frx":6052
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERCAMBIA_GTIAS.frx":636C
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_INTERCAMBIA_GTIASC"
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
Public numOperAsoc As String
Public numGtiaAsoc As Long
Public colAzulOsc As Long
Public totalOperacion As Double
Public totalGarantias As Double
Public Estado As Boolean
Public FolioSel As Long
Private objCliente As Object
Private Sub Form_Load()

    Set objCliente = New clsCliente

    Me.Top = 0
    Me.Left = 0
    
    
    
    colorFore = grillaAsoc.ForeColor
    colorBack = grillaAsoc.BackColor
    colSelec = &H40C0&
    colFondo = &HFFFF80
    colFondg = &HE0E0E0
    
    Call FormateaGrillaAsoc
    Call FormateaGrillaGtias
    
    numOperSel = 0
    numGtiaSel = 0
    numOperAsoc = ""
    numGtiaAsoc = 0
    colAzulOsc = &H800000
    totalOperacion = 0#
    totalGarantias = 0#
    
    Toolbar1.Buttons(2).Enabled = False 'Asociar
    Toolbar1.Buttons(3).Enabled = False 'Grabar
    
    Estado = True
    FolioSel = 0
    
End Sub
Private Sub FormateaGrillaGtias()

    With grillaGtias
        .FixedRows = 1
        .ColWidth(0) = 510
        .ColWidth(1) = 1200
        .ColWidth(2) = 1600
        .ColWidth(3) = 800
        .ColWidth(4) = 2600
        .ColWidth(5) = 1200
        .ColWidth(6) = 1200
        .ColWidth(7) = 2600
        .ColWidth(8) = 0
        .ColWidth(9) = 0
        
        .FixedAlignment(0) = flexAlignLeft
        .FixedAlignment(1) = flexAlignRight
        .FixedAlignment(2) = flexAlignLeft
        .FixedAlignment(3) = flexAlignRight
        .FixedAlignment(4) = flexAlignLeft
        .FixedAlignment(5) = flexAlignRight
        .FixedAlignment(6) = flexAlignCenter
        .FixedAlignment(7) = flexAlignCenter
        .FixedAlignment(8) = flexAlignCenter
        .FixedAlignment(9) = flexAlignCenter
        
        .TextMatrix(0, 0) = "Asoc."
        .TextMatrix(0, 1) = "N° Garantía"
        .TextMatrix(0, 2) = "Instrumento"
        .TextMatrix(0, 3) = "Moneda"
        .TextMatrix(0, 4) = "Nominal"
        .TextMatrix(0, 5) = "Fecha Inicio"
        .TextMatrix(0, 6) = "Fecha Vcto."
        .TextMatrix(0, 7) = "Valor Presente"
        .TextMatrix(0, 8) = ""  'Suma de los Valores Presentes igual Garantía
        .TextMatrix(0, 9) = ""  '
    End With
    
End Sub
Private Sub LlenaGrillaAsoc()
Dim Fila As Long
Dim Asoc As Long
Dim Datos()

    Envia = Array()
    AddParam Envia, CLng(txtRutCliente.Text)
    AddParam Envia, CInt(txtCodCliente.Text)

    If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_GAR_RETGTIASOCUPADASCLIENTE", Envia) Then
        MsgBox "Error al buscar Operaciones para Garantías!", vbExclamation, TITSISTEMA
        Exit Sub
    End If
    
    If grillaAsoc.Enabled = False Then
        grillaAsoc.Enabled = True
    End If
    
    grillaAsoc.Clear
    grillaAsoc.Rows = 2
    
    Call FormateaGrillaAsoc
    
    Fila = 1
    Asoc = 0
    
    Do While Bac_SQL_Fetch(Datos())
        With grillaAsoc
            .TextMatrix(Fila, 0) = " "                          'Marca seleccionado
            .TextMatrix(Fila, 1) = Format(Datos(1), FEntero)    'Folio Asociación
            .TextMatrix(Fila, 2) = Format(Datos(2), FEntero)    'N° Garantia
            .TextMatrix(Fila, 3) = Datos(3)                     'Instrumento
            .TextMatrix(Fila, 4) = Datos(4)                     'Moneda
            .TextMatrix(Fila, 5) = Format(Datos(5), FDecimal)   'Nominal
            .TextMatrix(Fila, 6) = Datos(8)                     'Fecha Inicio
            .TextMatrix(Fila, 7) = Datos(9)                     'Fecha Término
            .TextMatrix(Fila, 8) = Format(Datos(10), FEntero)  'Valor Presente
            .TextMatrix(Fila, 9) = ""                           'Mayor F. Vcto. Oper. Asoc.
            .TextMatrix(Fila, 10) = 0                           'Suma Dif. a cubrir Gtias. de Oper. Asoc. (MTM-Threshold)
            Asoc = Asoc + 1
            Fila = Fila + 1
            .Rows = .Rows + 1
        End With
    Loop
'Borrar la ultima fila

    If Asoc > 0 Then
        grillaAsoc.Rows = grillaAsoc.Rows - 1
    End If
    
    If Asoc = 0 Then
        MsgBox "El cliente no registra Garantías asociadas a Operaciones!", vbInformation, TITSISTEMA
        grillaAsoc.Enabled = False
        Exit Sub
    End If
    
End Sub
Private Sub LLenaGrillaGtias()
Dim Fila            As Integer
Dim sumaGtias       As Double
Dim cntGtias        As Integer
Dim Datos()

    sumaGtias = 0#
    cntGtias = 0
    
    Envia = Array()
    AddParam Envia, CLng(txtRutCliente.Text)
    AddParam Envia, CInt(txtCodCliente.Text)
    
    
    If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_GAR_RETGTIASDISPINTERCAMBIO", Envia) Then
        MsgBox "Error al buscar Garantías Disponibles!", vbExclamation, TITSISTEMA
        Exit Sub
    End If
    
    If grillaGtias.Enabled = False Then
    
        grillaGtias.Enabled = True
        
    End If
    
    With grillaGtias
        .Clear
        .Rows = 2
        Call FormateaGrillaGtias
        Fila = 1
        Do While Bac_SQL_Fetch(Datos())
            .TextMatrix(Fila, 0) = "No"
            .TextMatrix(Fila, 1) = Format(Datos(1), FEntero)
            .TextMatrix(Fila, 2) = Datos(2)
            .TextMatrix(Fila, 3) = Datos(3)
            .TextMatrix(Fila, 4) = Format(CDbl(Datos(4)), FDecimal)
            .TextMatrix(Fila, 5) = Datos(5)
            .TextMatrix(Fila, 6) = Datos(6)
            .TextMatrix(Fila, 7) = Format(CDbl(Datos(7)), FEntero)
            .TextMatrix(Fila, 8) = CDbl(Datos(9))   'Suma de los VP de la misma garantía
            .TextMatrix(Fila, 9) = ""
            
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
        Toolbar1.Buttons(2).Enabled = False
        Toolbar1.Buttons(3).Enabled = False
        MsgBox "Atención! El cliente no tiene Garantías disponibles para realizar Intercambios!", vbExclamation, TITSISTEMA
        grillaGtias.Enabled = False
        Exit Sub
    End If
    

    Toolbar1.Buttons(2).Enabled = True
End Sub

Private Function MarcaGarantia(ByVal xfila As Long) As Boolean
Dim Msg As String
Dim sumaVPAsoc As Double
Dim sumaVPGtias As Double
Dim fvAsoc As Date
Dim fvGtia As Date
    If grillaAsoc.Enabled = False Then
        MsgBox "La Garantía no se puede marcar pues no hay Garantías Asociadas para operar!", vbExclamation, TITSISTEMA
        Exit Function
    End If
    If Trim(lblMayorFecha.Caption) = "" Then
        MsgBox "No hay Garantías Asociadas seleccionadas para intercambiar!", vbExclamation, TITSISTEMA
        Exit Function
    End If
    With grillaGtias
        If Trim(.TextMatrix(xfila, 9)) = "*" Then
            MsgBox "La Garantía está seleccionada para Intercambio!", vbExclamation, TITSISTEMA
            Exit Function
        End If
        If .TextMatrix(xfila, 0) = "Sí" Then
            MsgBox "La Garantía ya estaba marcada!", vbInformation, TITSISTEMA
            Exit Function
        End If
        'Revisar si la fecha de vencimiento de la garantía es >= a la fecha de vencimiento de la operación a la cual se va a asociar
        'fvAsoc = CDate(grillaAsoc.TextMatrix(grillaAsoc.RowSel, 6))
        fvAsoc = CDate(lblMayorFecha)
        fvGtia = CDate(.TextMatrix(xfila, 6))
        If fvGtia < fvAsoc Then
            MsgBox "La fecha de vencimiento de la garantía a intercambiar no cubre la fecha de vencimiento de las operaciones asociadas!", vbExclamation, TITSISTEMA
            Exit Function
        End If
        .TextMatrix(xfila, 0) = "Sí"
    End With
    numGtiaSel = numGtiaSel + 1
    
    
    
    txtMontoCubierto.Text = Format(CDbl(txtMontoCubierto.Text) + CDbl(grillaGtias.TextMatrix(xfila, 7)), FDecimal)
    
    
    If CDbl(txtMontoCubierto.Text) >= CDbl(txtTotalIntercambiar.Text) Then
        txtMontoCubierto.ForeColor = colAzulOsc
    Else
        txtMontoCubierto.ForeColor = vbRed
    End If
    
    Call PintaFila(grillaGtias, xfila, colSelec, colFondg)
    
End Function
Private Function DetSumaVPAsoc() As Double
Dim sumaVP As Double
Dim I As Long
'Suma los Valores Presentes de las operaciones no marcadas de grillaAsoc
sumaVP = 0
With grillaAsoc
    For I = 1 To .Rows - 1
        If .TextMatrix(I, 0) <> "*" Then
            sumaVP = sumaVP + CDbl(.TextMatrix(I, 8))
        End If
    Next I
End With
DetSumaVPAsoc = sumaVP
End Function
Private Function DetSumaVPGtias(ByVal nFila As Long) As Double
Dim sumaVP As Double
Dim I As Long
Dim numGar As String
sumaVP = 0
With grillaGtias
    numGar = .TextMatrix(nFila, 1)
    For I = 1 To .Rows - 1
        If .TextMatrix(I, 1) = numGar Then
            sumaVP = sumaVP + CDbl(.TextMatrix(I, 8))
        End If
    Next I
End With
DetSumaVPGtias = sumaVP
End Function
Private Function DesmarcaGarantia(ByVal xfila As Long) As Boolean
    With grillaGtias
        If Trim(.TextMatrix(xfila, 9)) = "*" Then
            MsgBox "La Garantía está seleccionada para Intercambio!", vbExclamation, TITSISTEMA
            Exit Function
        End If
        If .TextMatrix(xfila, 0) = "No" Then
            MsgBox "La Garantía no está marcada!", vbInformation, TITSISTEMA
            Exit Function
        End If
        .TextMatrix(xfila, 0) = "No"
    End With
    numGtiaSel = numGtiaSel - 1
    txtMontoCubierto.Text = Format(CDbl(txtMontoCubierto.Text) - CDbl(grillaGtias.TextMatrix(xfila, 7)), FDecimal)
    If CDbl(txtMontoCubierto.Text) >= CDbl(txtTotalIntercambiar.Text) Then
        txtMontoCubierto.ForeColor = colAzulOsc
    Else
        txtMontoCubierto.ForeColor = vbRed
    End If
    Call PintaFila(grillaGtias, xfila, colorFore, colorBack)
End Function
Private Function ListaOperAsoc(ByVal nFolio As Long, ByVal nFila As Long) As Boolean
Dim nomSp As String
Dim Oper As String
Dim FecVcto As Date
Dim acumCubrir As Double
nomSp = "BacParamsuda.dbo.SP_GAR_OPERASOC_FOLIO"
acumCubrir = 0
Dim Datos()
Envia = Array()
AddParam Envia, nFolio
AddParam Envia, CDbl(txtRutCliente.Text)
AddParam Envia, CDbl(txtCodCliente.Text)
If Not Bac_Sql_Execute(nomSp, Envia) Then
    ListaOperAsoc = False
    Exit Function
End If
ListOper.Clear
Do While Bac_SQL_Fetch(Datos())
    Oper = Datos(1) & " - " & Datos(2)
    ListOper.AddItem (Oper)
    FecVcto = CDate(Datos(4))
    difCubrir = CDbl(Datos(7))
    acumCubrir = acumCubrir + difCubrir
Loop
grillaAsoc.TextMatrix(nFila, 9) = CStr(FecVcto)
grillaAsoc.TextMatrix(nFila, 10) = difCubrir
lblMayorFecha.Caption = CStr(FecVcto)
lblDifCubrir.Caption = Format(difCubrir, FEntero)
ListaOperAsoc = True
End Function

Private Sub Form_Unload(Cancel As Integer)
Set objCliente = Nothing
End Sub

Private Sub grillaAsoc_DblClick()
Dim Fila As Long
Dim folio As Long
    If Not Estado Then
        Exit Sub
    End If
    With grillaAsoc
        Fila = .RowSel
        If Trim(.TextMatrix(Fila, 1)) = "" Then
            Exit Sub
        End If
        folio = .TextMatrix(Fila, 1)
        If Not ListaOperAsoc(folio, Fila) Then
            MsgBox "Se ha producido un error al leer las Operaciones Asociadas a Garantías!", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        If FolioSel = 0 Then
            FolioSel = CLng(.TextMatrix(Fila, 1))
        ElseIf CLng(.TextMatrix(Fila, 1)) <> FolioSel Then
            MsgBox "Para intercambiar garantías, éstas se deben seleccionar de un mismo Folio de Asociación!", vbExclamation, TITSISTEMA
            Exit Sub
        End If
        If .TextMatrix(Fila, 0) = " " Then  'no está marcado
            Call MarcarTodasAsoc(FolioSel)
        Else    'Está marcado
            Call DesmarcarTodasAsoc(FolioSel)
            If MarcadosAsoc(FolioSel) = 0 Then
                FolioSel = 0
                lblMayorFecha.Caption = ""
                lblDifCubrir.Caption = ""
                ListOper.Clear
            End If
        End If
    End With
End Sub
Private Function MarcarTodasAsoc(ByVal nFolio As Long) As Boolean
Dim I As Long
With grillaAsoc
    For I = 1 To .Rows - 1
        If CLng(.TextMatrix(I, 1)) = nFolio Then
            If .TextMatrix(I, 0) <> "*" Then
                .TextMatrix(I, 0) = "*"
                Call PintaFila(grillaAsoc, I, colSelec, colFondg)
            End If
        End If
    Next I
End With
MarcarTodasAsoc = True
End Function
Private Function DesmarcarTodasAsoc(ByVal nFolio As Long) As Boolean
Dim I As Long
With grillaAsoc
    For I = 1 To .Rows - 1
        If CLng(.TextMatrix(I, 1)) = nFolio Then
            If .TextMatrix(I, 0) <> " " Then
                .TextMatrix(I, 0) = " "
                Call PintaFila(grillaAsoc, I, colorFore, colorBack)
            End If
        End If
    Next I
End With
DesmarcarTodasAsoc = True
End Function
Private Function MarcarTodasDisp(ByVal nGar As Long) As Boolean
Dim I As Long
Dim v As Integer
v = 0
With grillaGtias
    For I = 1 To .Rows - 1
        If CLng(.TextMatrix(I, 1)) = nGar Then
            If .TextMatrix(I, 0) <> "Sí" Then
                .TextMatrix(I, 0) = "Sí"
                Call PintaFila(grillaGtias, I, colSelec, colFondg)
            End If
            If v = 0 Then
                txtMontoCubierto.Text = Format(CDbl(txtMontoCubierto.Text) + CDbl(.TextMatrix(I, 8)), FDecimal)
                v = 1
            End If
        End If
    Next I

End With
MarcarTodasDisp = True
End Function
Private Function DesmarcarTodasDisp(ByVal nGar As Long) As Boolean
Dim I As Long
Dim v As Integer
v = 0
With grillaGtias
    For I = 1 To .Rows - 1
        If CLng(.TextMatrix(I, 1)) = nGar Then
            If .TextMatrix(I, 0) <> "No" Then
                .TextMatrix(I, 0) = "No"
                Call PintaFila(grillaGtias, I, colorFore, colorBack)
            End If
            If v = 0 Then
                txtMontoCubierto.Text = Format(CDbl(txtMontoCubierto.Text) - CDbl(.TextMatrix(I, 8)), FDecimal)
                v = 1
            End If
        End If
    Next I
End With
DesmarcarTodasDisp = True
End Function

Private Function MarcadosAsoc(ByVal nFolio As Long) As Long
Dim n As Long
Dim esta As Long
Dim I As Long
esta = grillaAsoc.RowSel
n = 0
For I = 1 To grillaAsoc.Rows - 1
    If grillaAsoc.TextMatrix(I, 0) = "*" And grillaAsoc.TextMatrix(I, 1) = nFolio Then
        n = n + 1
    End If
Next I
grillaAsoc.RowSel = esta
MarcadosAsoc = n
End Function
Private Sub grillaAsoc_KeyPress(KeyAscii As Integer)
    If Not Estado Then
        Exit Sub
    End If
    If KeyAscii = 13 Then
        Call grillaAsoc_DblClick
    End If
End Sub
Private Sub FormateaGrillaAsoc()
With grillaAsoc
    '.Cols = 10
    .Cols = 11
    .FixedRows = 1
    .ColWidth(0) = 0
    .ColWidth(1) = 1200
    .ColWidth(2) = 1200
    .ColWidth(3) = 1600
    .ColWidth(4) = 800
    .ColWidth(5) = 2600
    .ColWidth(6) = 1200
    .ColWidth(7) = 1200
    .ColWidth(8) = 2600
    .ColWidth(9) = 0
    .ColWidth(10) = 0

    
    .FixedAlignment(0) = flexAlignLeft
    .FixedAlignment(1) = flexAlignLeft
    .FixedAlignment(2) = flexAlignRight
    .FixedAlignment(3) = flexAlignLeft
    .FixedAlignment(4) = flexAlignRight
    .FixedAlignment(5) = flexAlignLeft
    .FixedAlignment(6) = flexAlignRight
    .FixedAlignment(7) = flexAlignCenter
    .FixedAlignment(8) = flexAlignCenter
    .FixedAlignment(9) = flexAlignLeft
    .FixedAlignment(10) = flexAlignLeft

    .TextMatrix(0, 0) = ""      'Marca para indicar seleccionado
    .TextMatrix(0, 1) = "Folio Asoc."
    .TextMatrix(0, 2) = "N° Garantía"
    .TextMatrix(0, 3) = "Instrumento"
    .TextMatrix(0, 4) = "Moneda"
    .TextMatrix(0, 5) = "Nominal"
    .TextMatrix(0, 6) = "Fecha Inicio"
    .TextMatrix(0, 7) = "Fecha Vcto."
    .TextMatrix(0, 8) = "Valor Presente"
    .TextMatrix(0, 9) = ""  'Mayor Fecha de Vencimiento Operaciones
    .TextMatrix(0, 10) = ""  'Suma de diferencias a cubrir Operaciones


End With

End Sub
Private Sub grillaGtias_DblClick()
'Dim fila As Long
'    If Not Estado Then
'        Exit Sub
'    End If
'
'    With grillaGtias
'        If .Row = 0 Then
'            Exit Sub
'        End If
'        fila = .RowSel
'        If .TextMatrix(fila, 0) = "Sí" Then
'            Call DesmarcaGarantia(fila)
'        ElseIf .TextMatrix(fila, 0) = "No" Then
'            MarcaGarantia (fila)
'        End If
'    End With
Dim Fila As Long
Dim Gar As Long
    If Not Estado Then
        Exit Sub
    End If
    With grillaGtias
        Fila = .RowSel
        If Trim(.TextMatrix(Fila, 1)) = "" Then
            Exit Sub
        End If
        Gar = .TextMatrix(Fila, 1)
        If .TextMatrix(Fila, 0) = "No" Then  'no está marcado
            Call MarcarTodasDisp(Gar)
        Else    'Está marcado
            Call DesmarcarTodasDisp(Gar)
        End If
    End With
End Sub

Private Sub grillaGtias_KeyPress(KeyAscii As Integer)
    If Not Estado Then
        Exit Sub
    End If
    If KeyAscii = 13 Then
        Call grillaGtias_DblClick
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        Call Limpiar
    Case 2
        'Call Intercambiar
        Call Interchange
    Case 3
        If Grabar1() Then
            MsgBox "El intercambio de Garantías se ha realizado exitosamente!", vbInformation, TITSISTEMA
            Call Limpiar
        Else
            MsgBox "no se ha podido realizar el intercambio de las Garantías!", vbExclamation, TITSISTEMA
            Call Limpiar
        End If
    Case 4
        Unload Me
End Select
End Sub
Private Sub Limpiar()
txtRutCliente.Text = ""
txtCodCliente.Text = ""
txtNomCliente.Text = ""
If grillaAsoc.Enabled = False Then
    grillaAsoc.Enabled = True
End If
If grillaGtias.Enabled = False Then
    grillaGtias.Enabled = True
End If
grillaAsoc.Clear
grillaGtias.Clear
grillaAsoc.Rows = 2
grillaGtias.Rows = 2
Call FormateaGrillaAsoc
Call FormateaGrillaGtias
numOperAsoc = ""
txtTotalIntercambiar.Text = "0.0000"
txtMontoCubierto.Text = "0.0000"
Toolbar1.Buttons(2).Enabled = False
Toolbar1.Buttons(3).Enabled = False
If txtRutCliente.Enabled = False Then
    txtRutCliente.Enabled = True
    txtCodCliente.Enabled = True
    txtNomCliente.Enabled = True
End If
FolioAsoc = 0
lblMayorFecha.Caption = ""
lblDifCubrir.Caption = ""
ListOper.Clear
Estado = True
txtRutCliente.SetFocus
End Sub
Private Function Grabar1() As Boolean
'1. Borrar cada una de esas garantías de la tabla
'2. Si se borraron, agregar las garantías marcadas de grillaGtias a tbl_gar_AsociacionGtia
'   usando el mismo folio (FolioSel)
'3. Si todo ok, COMMIT  --> Grabar1 = True
'   Else, ROLLBACK      --> Grabar1 = False

Dim I As Long
Dim folio As Long, nGar As Long
Dim borrados As Boolean
folio = -1
borrados = False
With grillaAsoc
    For I = 1 To .Rows - 1
        If .TextMatrix(I, 0) = "*" Then
            folio = CLng(.TextMatrix(I, 1))
            Exit For
        End If
    Next I
    If folio = -1 Then
        Grabar1 = False
        Exit Function
    End If
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Grabar1 = False
        Exit Function
    End If
    If Not BorrarFolioAsoc(folio) Then
        Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
        Grabar1 = False
        Exit Function
    End If
    If Not AgregarDisp(folio) Then
        Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
        Grabar1 = False
        Exit Function
    End If
    Call Bac_Sql_Execute("COMMIT TRANSACTION")
End With
Grabar1 = True
End Function
Private Function BorrarFolioAsoc(ByVal nFolio As Long) As Boolean
Dim nomSp As String
Dim Datos()
Envia = Array()
AddParam Envia, nFolio
AddParam Envia, CDbl(txtRutCliente.Text)
AddParam Envia, CDbl(txtCodCliente.Text)
nomSp = "Bacparamsuda.dbo.SP_GAR_BORRAGARASOCFOLIO"
If Not Bac_Sql_Execute(nomSp, Envia) Then
    BorrarFolioAsoc = False
    Exit Function
End If
BorrarFolioAsoc = True
End Function
Private Function AgregarDisp(ByVal nFolio As Long) As Boolean
Dim nomSp As String
Dim Datos()
Envia = Array()
Dim I As Long
Dim pasado As Long
Dim nGar As Long
Dim v As Integer
v = 0
pasado = -1
nomSp = "Bacparamsuda.dbo.SP_GAR_AGREGADISPFOLIO"
With grillaGtias
    For I = 1 To .Rows - 1
        If .TextMatrix(I, 0) = "Sí" Then
            nGar = CLng(.TextMatrix(I, 1))
            If nGar <> pasado Then
                AddParam Envia, nFolio
                AddParam Envia, CDbl(txtRutCliente.Text)
                AddParam Envia, CDbl(txtCodCliente.Text)
                AddParam Envia, nGar
                If Not Bac_Sql_Execute(nomSp, Envia) Then
                    AgregarDisp = False
                    Exit Function
                End If
                Envia = Array()
                pasado = nGar
            End If
        End If
    Next I
End With
AgregarDisp = True
End Function
Private Function Grabar() As Boolean
Dim Error As Boolean
Dim codSistema As String
Dim numOperacion As Double
Dim I As Long
Dim cntAsoc As Long, cntGtias As Long
Dim okAsoc As Long, okGtias As Long
If grillaAsoc.Enabled = False Then
    grillaAsoc.Enabled = True
End If
If grillaGtias.Enabled = False Then
    grillaGtias.Enabled = True
End If
'Utilizar solo las filas con una "M" en la columna 9
Error = False
cntAsoc = 0
cntGtias = 0
okAsoc = 0
okGtias = 0
For I = 1 To grillaAsoc.Rows - 1
    If grillaAsoc.TextMatrix(I, 9) = "M" Then
        cntAsoc = cntAsoc + 1
    End If
Next I
For I = 1 To grillaGtias.Rows - 1
    If grillaGtias.TextMatrix(I, 9) = "M" Then
        cntGtias = cntGtias + 1
    End If
Next I

'Primero, grabar de la grilla grillaAsoc
If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
    MsgBox "Se ha producido un error en el servidor que impide grabar las operaciones!", vbExclamation, TITSISTEMA
    Grabar = False
    Exit Function
End If
For I = 1 To grillaAsoc.Rows - 1
    If grillaAsoc.TextMatrix(I, 9) = "M" Then
        codSistema = Mid(grillaAsoc.TextMatrix(I, 8), 1, 3)
        numOperacion = CDbl(Mid(grillaAsoc.TextMatrix(I, 8), 5))
        Envia = Array()
        AddParam Envia, CDbl(grillaAsoc.TextMatrix(I, 1))
        AddParam Envia, CDbl(txtRutCliente.Text)
        AddParam Envia, CInt(txtCodCliente.Text)
        AddParam Envia, codSistema
        AddParam Envia, numOperacion
        If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_GRABAOPERGARANTIAS", Envia) Then
            Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
            MsgBox "Se ha producido un error en el servidor que impidió que se grabaran las operaciones!", vbExclamation, TITSISTEMA
            Grabar = False
            Exit Function
        End If
        okAsoc = okAsoc + 1
    End If
Next I

'Segundo, grabar de la grilla grillaGtias

For I = 1 To grillaGtias.Rows - 1
    If grillaGtias.TextMatrix(I, 9) = "M" Then
        codSistema = Mid(grillaGtias.TextMatrix(I, 8), 1, 3)
        numOperacion = CDbl(Mid(grillaGtias.TextMatrix(I, 8), 5))
        Envia = Array()
        AddParam Envia, CDbl(grillaGtias.TextMatrix(I, 1))
        AddParam Envia, CDbl(txtRutCliente.Text)
        AddParam Envia, CInt(txtCodCliente.Text)
        AddParam Envia, codSistema
        AddParam Envia, numOperacion
        If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_BORRAOPERGARANTIAS", Envia) Then
            Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
            MsgBox "Se ha producido un error en el servidor que impidió que se borraran las operaciones!", vbExclamation, TITSISTEMA
            Grabar = False
            Exit Function
        End If
        okGtias = okGtias + 1
    End If
Next I
Call Bac_Sql_Execute("COMMIT TRANSACTION")
MsgBox "El intercambio de garantías se ha grabado exitosamente!", vbInformation, TITSISTEMA
Grabar = True
End Function
Private Sub Interchange()
Dim sumaVPAsoc As Double
Dim sumaVPGtias As Double
Dim sumaVPTotal As Double
'Validar que hay datos en las grillas y ya están seleccionadas
If grillaAsoc.Rows = 1 Then
    MsgBox "No hay datos para realizar el Intercambio!", vbExclamation, TITSISTEMA
    Exit Sub
End If
If grillaGtias.Rows = 1 Then
    MsgBox "No hay datos para realizar el Intercambio!", vbExclamation, TITSISTEMA
    Exit Sub
End If
'¿Hay garantías seleccionadas?
If Not SeleccionadasAsoc() Then
    MsgBox "No hay garantías Asociadas seleccionadas para intercambiar!", vbExclamation, TITSISTEMA
    Exit Sub
End If
If Not SeleccionadasDisp() Then
    MsgBox "No hay garantías Disponibles seleccionadas para intercambiar!", vbExclamation, TITSISTEMA
    Exit Sub
End If
'Aquí aplicar controles de validación.
'El intercambio ahora es como sigue:
'La(s) garantías salientes de grillaAsoc simplemente se borran de la tabla tbl_gar_AsociacionGtia
'y las garantías entrantes (de grillaGtias) se agregan a la tabla con el folio FolioSel
            
sumaVPAsoc = DetSumaVPAsoc()
sumaVPGtias = DetSumaVPGtias(xfila)
sumaVPTotal = sumaVPAsoc + sumaVPGtias
Msg = "Atención!  La suma de los Valores Presentes de las Garantías Asociadas y las Garantías Seleccionadas" & vbCrLf & "no alcanza a garantizar el monto requerido de las operaciones asociadas."
If sumaVPTotal < CDbl(lblDifCubrir) Then
    MsgBox Msg, vbExclamation, TITSISTEMA
    Exit Sub
End If
'Se cumplen las condiciones para el intercambio, bloquear grillas y habilitar botón grabar
grillaAsoc.Enabled = False
grillaGtias.Enabled = False
Toolbar1.Buttons(2).Enabled = False
Toolbar1.Buttons(3).Enabled = True
MsgBox "Las garantías seleccionadas están listas para ser intercambiadas!", vbInformation, TITSISTEMA
End Sub
Private Sub Intercambiar()
Dim marcadosUp As Long, marcadosDn As Long
marcadosUp = 0
marcadosDn = 0
'Validar que hay datos en las grillas y ya están seleccionadas
If grillaAsoc.Rows = 1 Then
    MsgBox "No hay datos para realizar el Intercambio!", vbExclamation, TITSISTEMA
    Exit Sub
End If
If grillaGtias.Rows = 1 Then
    MsgBox "No hay datos para realizar el Intercambio!", vbExclamation, TITSISTEMA
    Exit Sub
End If
'¿Hay garantías seleccionadas?
If Not Seleccionadas(grillaAsoc) Then
    MsgBox "No hay garantías Asociadas seleccionadas para intercambiar!", vbExclamation, TITSISTEMA
    Exit Sub
End If
'Aquí aplicar controles de validación.
'El intercambio ahora es como sigue:
'La(s) garantías salientes de grillaAsoc simplemente se borran de la tabla tbl_gar_AsociacionGtia
'y las garantías entrantes (de grillaGtias) se agregan a la tabla con el folio FolioSel



If Not Seleccionadas(grillaGtias) Then
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
'Recorrer GrillaAsoc y marcar con * la columna 9 si la columna 1 = Sí
Dim I As Integer
For I = 1 To grillaAsoc.Rows - 1
    If grillaAsoc.TextMatrix(I, 0) = "Sí" Then
        grillaAsoc.TextMatrix(I, 9) = "*"
        marcadosUp = marcadosUp + 1
    End If
Next I
'Recorrer GrillaGtias...
For I = 1 To grillaGtias.Rows - 1
    If grillaGtias.TextMatrix(I, 0) = "Sí" Then
        grillaGtias.TextMatrix(I, 9) = "*"
        marcadosDn = marcadosDn + 1
    End If
Next I
'Bloquear las grillas hasta que se grabe o se limpie...
If marcadosUp = 0 Then
    If marcadosDn > 0 Then
        'Desmarcar todos los marcados en grillaGtias
        For I = 1 To grillaGtias.Rows - 1
            If grillaGtias.TextMatrix(I, 9) = "*" Then
                grillaGtias.TextMatrix(I, 9) = ""
            End If
        Next I
    End If
End If
If marcadosDn = 0 Then
    If marcadosUp > 0 Then
        'Desmarcar todos los marcados en grillaAsoc
        For I = 1 To grillaAsoc.Rows - 1
            If grillaAsoc.TextMatrix(I, 9) = "*" Then
                grillaAsoc.TextMatrix(I, 9) = ""
            End If
        Next I
    End If
End If
If marcadosUp > 0 And marcadosDn > 0 Then
    'Realizar el intercambio de las garantías
    Call IntercambiarGtias
    'grillaAsoc.Enabled = False
    'grillaGtias.Enabled = False
    
End If
End Sub
Private Function Seleccionadas(ByVal grilla As MSFlexGrid) As Boolean
Dim selecc As Long
Dim I As Integer
Seleccionadas = True
selecc = 0
For I = 1 To grilla.Rows - 1
    If grilla.TextMatrix(I, 0) = "Sí" Then
        selecc = selecc + 1
    End If
Next I
If selecc = 0 Then
    Seleccionadas = False
End If
End Function
Private Function SeleccionadasAsoc() As Boolean
'*
Dim selecc As Long
Dim I As Long
SeleccionadasAsoc = True
selecc = 0
For I = 1 To grillaAsoc.Rows - 1
    If grillaAsoc.TextMatrix(I, 0) = "*" Then
        selecc = selecc + 1
    End If
Next I
If selecc = 0 Then
    SeleccionadasAsoc = False
End If

End Function
Private Function SeleccionadasDisp() As Boolean
'Sí/No
Dim selecc As Long
Dim I As Long
SeleccionadasDisp = True
selecc = 0
For I = 1 To grillaGtias.Rows - 1
    If grillaGtias.TextMatrix(I, 0) = "Sí" Then
        selecc = selecc + 1
    End If
Next I
If selecc = 0 Then
    SeleccionadasDisp = False
End If
End Function
Private Function IntercambiarGtias() As Boolean
Dim NumOper As String
Dim I As Long
For I = 1 To grillaAsoc.Rows - 1
    If grillaAsoc.TextMatrix(I, 9) = "*" And grillaAsoc.TextMatrix(I, 0) = "Sí" Then
        NumOper = grillaAsoc.TextMatrix(I, 8)
        If Trim(NumOper) <> "" Then
            Exit For
        End If
    End If
Next I

'----Primero, mover gtias. de grillaAsoc a grillaGtias

'Tomo una garantia de grillaAsoc, la "muevo" a grillaGtia y le desmarco el "*"
'Ciclo al revés porque voy a sacar fisicamente filas de la grilla
For I = grillaAsoc.Rows - 1 To 1 Step -1
    If grillaAsoc.TextMatrix(I, 9) = "*" And grillaAsoc.TextMatrix(I, 0) = "Sí" Then
        If MoverGtiaAsoc(I, NumOper) Then
            If I = 1 And grillaAsoc.Rows = 2 Then
                'Si es la fila 1, que es fija, no se puede borrar sino vaciar
                Call Vaciarfila(grillaAsoc, I)
            Else
                grillaAsoc.RemoveItem (I)
            End If
        End If
    End If
Next I

'---- Segundo, mover gtias. de grillaGtias a grillaAsoc
For I = grillaGtias.Rows - 1 To 1 Step -1
    If grillaGtias.TextMatrix(I, 9) = "*" And grillaGtias.TextMatrix(I, 0) = "Sí" Then
        If MoverGtiaGtias(I, NumOper) Then
            If I = 1 And grillaGtias.Rows = 2 Then
                Call Vaciarfila(grillaGtias, I)
            Else
                grillaGtias.RemoveItem (I)
            End If
        End If
    End If

Next I
'Ordenar la grilla grillaAsoc por la columna 8 (Operacion)
Call OrdenarAsoc(1, 8)
'Dejar habilitadas solo las opciones de Limpiar, Grabar o Salir
Toolbar1.Buttons(1).Enabled = True
Toolbar1.Buttons(2).Enabled = False
Toolbar1.Buttons(3).Enabled = True
Toolbar1.Buttons(4).Enabled = True
Estado = False
End Function
Private Function Vaciarfila(ByVal grilla As MSFlexGrid, ByVal numfila As Long) As Boolean
Dim I As Long
For I = 0 To grilla.Cols - 1
    grilla.TextMatrix(numfila, I) = ""
Next I
End Function
Private Function OrdenarAsoc(ByVal sentido As Integer, ByVal Fila As Long) As Boolean
Dim sOrden As SortSettings
Select Case sentido
    Case 1
        sOrden = flexSortStringAscending
    Case -1
        sOrden = flexSortStringDescending
End Select
grillaAsoc.Col = Fila
grillaAsoc.ColSel = Fila
grillaAsoc.Row = 1
grillaAsoc.RowSel = 1
grillaAsoc.Sort = sOrden
OrdenarAsoc = True
End Function
Private Function MoverGtiaAsoc(ByVal posicion As Long, ByVal nOper As String) As Boolean
Dim Fila As Long
Dim I As Long
Dim agregarfila As Boolean
On Error GoTo fallaMover
agregarfila = False
'Mueve fila en posicion "posicion" de la grilla grillaAsoc a la cola de la grilla grillaGtias
'cambia marcador de "*" a "M" solo para efectos de reconocerla al grabar
'Ver si hay una sola fila disponible y está vacía
If grillaGtias.Rows = 2 Then
    If FilaVacia(grillaGtias, 1) Then
        agregarfila = False
    Else
        agregarfila = True
    End If
Else
    agregarfila = True
End If
If agregarfila Then
    grillaGtias.Rows = grillaGtias.Rows + 1
End If
Fila = grillaGtias.Rows - 1
grillaGtias.TextMatrix(Fila, 0) = "--"
For I = 1 To 7
    grillaGtias.TextMatrix(Fila, I) = grillaAsoc.TextMatrix(posicion, I)
Next I
grillaGtias.TextMatrix(Fila, 8) = nOper
grillaGtias.TextMatrix(Fila, 9) = "M"
MoverGtiaAsoc = True
Exit Function
fallaMover:
MoverGtiaAsoc = False
End Function
Private Function MoverGtiaGtias(ByVal posicion As Long, ByVal nOper As String) As Boolean
Dim Fila As Long
Dim I As Long
Dim agregarfila As Boolean
On Error GoTo fallaMover
'Mueve fila en posicion "posicion" de la grilla grillaGtias a la cola de la grilla grillaAsoc
'cambia marcador de "*" a "M" solo para efectos de reconocerla al grabar
'Ver si hay una sola fila disponible y está vacía
If grillaAsoc.Rows = 2 Then
    If FilaVacia(grillaAsoc, 1) Then
        agregarfila = False
    Else
        agregarfila = True
    End If
Else
    agregarfila = True
End If
If agregarfila Then
    grillaAsoc.Rows = grillaAsoc.Rows + 1
End If

'grillaAsoc.Rows = grillaAsoc.Rows + 1
Fila = grillaAsoc.Rows - 1
grillaAsoc.TextMatrix(Fila, 0) = "--"
For I = 1 To 7
    grillaAsoc.TextMatrix(Fila, I) = grillaGtias.TextMatrix(posicion, I)
Next I
grillaAsoc.TextMatrix(Fila, 8) = nOper
grillaAsoc.TextMatrix(Fila, 9) = "M"
MoverGtiaGtias = True
Exit Function
fallaMover:
MoverGtiaGtias = False
End Function

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
        
        Call LlenaGrillaAsoc
        Call LLenaGrillaGtias
        
        If grillaAsoc.Enabled And grillaGtias.Enabled Then
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
    'Arm se implementa nuevo formulario de ayuda
        BacAyudaCliente.Tag = "MDCL"
        BacAyudaCliente.Show 1
    If giAceptar% = True Then
        txtRutCliente.Text = Val(gsrut$)
        txtCodCliente.Text = gsValor$
        txtNomCliente.Text = gsDescripcion$
        Call LlenaGrillaAsoc
        Call LLenaGrillaGtias
        If grillaAsoc.Enabled And grillaGtias.Enabled Then
            txtRutCliente.Enabled = False
            txtCodCliente.Enabled = False
            txtNomCliente.Enabled = False
        End If
       giAceptar% = False
    End If

End Sub
Private Function MarcaOperacion(ByVal xfila As Long) As Boolean
    If grillaGtias.Enabled = False Then
        MsgBox "El instrumento no se puede marcar pues no hay Garantías Disponibles para operar!", vbExclamation, TITSISTEMA
        Exit Function
    End If
    With grillaAsoc
        If .TextMatrix(xfila, 9) = "*" Then
            MsgBox "El instrumento está marcado para Intercambio!", vbExclamation, TITSISTEMA
            Exit Function
        End If
        If .TextMatrix(xfila, 0) = "Sí" Then
            MsgBox "El instrumento ya estaba marcado!", vbInformation, TITSISTEMA
            Exit Function
        End If
        If numOperAsoc <> "" Then
            If .TextMatrix(xfila, 8) <> numOperAsoc Then
                MsgBox "Atención!, los instrumentos no pueden pertenecer a distintas operaciones!", vbExclamation, TITSISTEMA
                Exit Function
            End If
        End If
        .TextMatrix(xfila, 0) = "Sí"
    End With
    numOperSel = numOperSel + 1
    If numOperSel = 1 Then
        numOperAsoc = grillaAsoc.TextMatrix(xfila, 8)
    End If
    txtTotalIntercambiar.Text = Format(CDbl(txtTotalIntercambiar.Text) + CDbl(grillaAsoc.TextMatrix(xfila, 7)), FDecimal)
    
    If CDbl(txtMontoCubierto.Text) >= CDbl(txtTotalIntercambiar.Text) Then
        txtMontoCubierto.ForeColor = colAzulOsc
    Else
        txtMontoCubierto.ForeColor = vbRed
    End If
    Call PintaFila(grillaAsoc, xfila, colSelec, colFondo)
End Function
Private Function DesmarcaOperacion(ByVal xfila As Long) As Boolean
    With grillaAsoc
        If .TextMatrix(xfila, 9) = "*" Then
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
        numOperAsoc = ""
    End If
    txtTotalIntercambiar.Text = Format(CDbl(txtTotalIntercambiar.Text) - CDbl(grillaAsoc.TextMatrix(xfila, 7)), FDecimal)
    If CDbl(txtMontoCubierto.Text) >= CDbl(txtTotalIntercambiar.Text) Then
        txtMontoCubierto.ForeColor = colAzulOsc
    Else
        txtMontoCubierto.ForeColor = vbRed
    End If
    Call PintaFila(grillaAsoc, xfila, colorFore, colorBack)
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

