VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_BLOQUEOCLIENTES 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Bloqueo de Productos Clientes"
   ClientHeight    =   6240
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   14985
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6240
   ScaleWidth      =   14985
   Begin MSComctlLib.ProgressBar Avance 
      Height          =   225
      Left            =   60
      TabIndex        =   14
      Top             =   1065
      Visible         =   0   'False
      Width           =   14070
      _ExtentX        =   24818
      _ExtentY        =   397
      _Version        =   393216
      BorderStyle     =   1
      Appearance      =   1
      Scrolling       =   1
   End
   Begin VB.Frame fraGrilla 
      Height          =   4980
      Left            =   30
      TabIndex        =   11
      Top             =   1245
      Width           =   14895
      Begin Threed.SSPanel infoPanel 
         Height          =   1950
         Left            =   1335
         TabIndex        =   15
         Top             =   885
         Visible         =   0   'False
         Width           =   5265
         _Version        =   65536
         _ExtentX        =   9287
         _ExtentY        =   3440
         _StockProps     =   15
         Caption         =   "Un momento, por favor.  Cargando datos..."
         ForeColor       =   8388608
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   3
         BorderWidth     =   0
         BevelInner      =   2
         FloodColor      =   8388608
         Font3D          =   1
      End
      Begin VB.ComboBox cmbMotivos 
         Height          =   315
         Left            =   3615
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   1125
         Visible         =   0   'False
         Width           =   2280
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   4770
         Left            =   30
         TabIndex        =   12
         Top             =   135
         Width           =   14760
         _ExtentX        =   26035
         _ExtentY        =   8414
         _Version        =   393216
         Cols            =   11
         FixedCols       =   0
         BackColorFixed  =   8421376
         ForeColorFixed  =   -2147483639
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
   Begin VB.Frame fraSelector 
      Height          =   555
      Left            =   15
      TabIndex        =   6
      Top             =   480
      Width           =   14910
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
         Height          =   300
         Left            =   1305
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   0
         Top             =   165
         Width           =   1215
      End
      Begin VB.ComboBox cmbTipoCliente 
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
         Left            =   11850
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   165
         Width           =   2955
      End
      Begin VB.TextBox Text4 
         BackColor       =   &H00008000&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000005&
         Height          =   315
         Left            =   10470
         TabIndex        =   10
         TabStop         =   0   'False
         Text            =   "Tipo Cliente"
         Top             =   165
         Width           =   1275
      End
      Begin VB.TextBox txtNomCli 
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
         Height          =   315
         Left            =   4605
         TabIndex        =   3
         TabStop         =   0   'False
         Text            =   "TODOS"
         Top             =   165
         Width           =   5730
      End
      Begin BACControles.TXTNumero txtCodCli 
         Height          =   315
         Left            =   4090
         TabIndex        =   2
         Top             =   165
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "1"
         Text            =   "1"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.TextBox Text2 
         BackColor       =   &H00008000&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000005&
         Height          =   315
         Left            =   3090
         TabIndex        =   9
         TabStop         =   0   'False
         Text            =   "Código"
         Top             =   165
         Width           =   900
      End
      Begin BACControles.TXTNumero txtDigito 
         Height          =   315
         Left            =   2715
         TabIndex        =   1
         Top             =   165
         Width           =   285
         _ExtentX        =   503
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.TextBox Text1 
         BackColor       =   &H00008000&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000005&
         Height          =   315
         Left            =   45
         TabIndex        =   7
         TabStop         =   0   'False
         Text            =   "Cliente"
         Top             =   165
         Width           =   1200
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   2520
         TabIndex        =   8
         Top             =   210
         Width           =   195
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   14985
      _ExtentX        =   26432
      _ExtentY        =   741
      ButtonWidth     =   767
      ButtonHeight    =   741
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   9
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6375
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   9
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_BLOQUEOCLIENTES.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_BLOQUEOCLIENTES.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_BLOQUEOCLIENTES.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_BLOQUEOCLIENTES.frx":2C8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_BLOQUEOCLIENTES.frx":3B68
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_BLOQUEOCLIENTES.frx":4A42
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_BLOQUEOCLIENTES.frx":591C
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_BLOQUEOCLIENTES.frx":67F6
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_BLOQUEOCLIENTES.frx":6B10
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label lblAvance 
      Alignment       =   1  'Right Justify
      Caption         =   "0%"
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
      Height          =   210
      Left            =   14160
      TabIndex        =   16
      Top             =   1065
      Visible         =   0   'False
      Width           =   750
   End
End
Attribute VB_Name = "FRM_MNT_BLOQUEOCLIENTES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmbMotivos_Click()
    Dim sel As Long
    Dim Fila As Long
    Dim I As Long
    Dim txt As String
    Fila = grilla.Row
    
    I = cmbMotivos.ListIndex
    txt = cmbMotivos.List(I)
    sel = -1
    
    If Trim(Mid$(txt, 90)) <> "" Then
        sel = CLng(Trim(Mid$(txt, 90)))
        grilla.TextMatrix(Fila, 10) = sel
    End If
    grilla.TextMatrix(Fila, 9) = Trim(Mid$(txt, 1, 80))
    cmbMotivos.Visible = False
End Sub
Private Sub cmbMotivos_LostFocus()
    cmbMotivos.Visible = False
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    Call LlenaCombo
    Call Limpiar
    Call LlenaComboMotivos(cmbMotivos)
End Sub

Private Sub grilla_Click()
    Call Grilla_DblClick
End Sub
Private Sub Grilla_DblClick()
    Dim xCol As Long
    Dim Fila As Long
    Dim vCod As String
    Dim p As Long
    Dim cBloqueos As Long
    Fila = grilla.Row
    xCol = grilla.Col
    If xCol < 3 Then
        Exit Sub
    End If
    If FilaVacia(grilla, Fila) Then
        Exit Sub
    End If
    cBloqueos = CantBloqueos(Fila)
    If xCol = 3 Then    'Columna TODOS
        If Trim(grilla.TextMatrix(Fila, xCol)) = "" Then
            Call PonFila("X", Fila)
        Else
            Call PonFila(" ", Fila)
            'Sacar el motivo del bloqueo
            grilla.TextMatrix(Fila, 9) = ""
            grilla.TextMatrix(Fila, 10) = -1
        End If
    End If
    If xCol >= 4 And xCol <= 8 Then
        If Trim(grilla.TextMatrix(Fila, xCol)) = "" Then
            Call PonCol("X", Fila, xCol)
            If cBloqueos = 5 And grilla.TextMatrix(Fila, 3) = "" Then
                grilla.TextMatrix(Fila, 3) = "X"
            End If
        Else
            Call PonCol(" ", Fila, xCol)
        End If
    End If
    If xCol = 9 Then
        'Activar solo si hay al menos un bloqueo en la fila
        If cBloqueos = 0 Then
            Exit Sub
        End If
        cmbMotivos.Visible = True
        Call PROC_POSI_COMBO(grilla, cmbMotivos)
    End If
End Sub
Private Function PonFila(marca As String, xfila As Long) As Boolean
    Dim I As Long
    For I = 3 To grilla.Cols - 3
        grilla.TextMatrix(xfila, I) = marca
    Next I
    If marca = " " Then
        cmbMotivos.Visible = False
        grilla.TextMatrix(xfila, 9) = ""
        grilla.TextMatrix(xfila, 10) = -1
    End If
    PonFila = True
End Function
Private Function PonCol(marca As String, xfila As Long, xCol As Long) As Boolean
    Dim xBloqueos As Long
    grilla.TextMatrix(xfila, xCol) = marca
    xBloqueos = CantBloqueos(xfila)
    If xBloqueos < 5 Then
        grilla.TextMatrix(xfila, 3) = " "
        cmbMotivos.Visible = False
    End If
    If xBloqueos = 0 Then
        grilla.TextMatrix(xfila, 3) = " "
        cmbMotivos.Visible = False
        grilla.TextMatrix(xfila, 9) = ""
        grilla.TextMatrix(xfila, 10) = -1
    End If
    PonCol = True
End Function
Private Function LlenaComboMotivos(ByVal Combo As ComboBox) As Boolean
    Dim Datos()
    Dim nomSp As String
    Combo.Clear
    Envia = Array()
    nomSp = "BacParamsuda.dbo.SP_MNT_MOTIVOS_BLOQUEOCLIENTES"
    If Not Bac_Sql_Execute(nomSp) Then
        LlenaComboMotivos = False
        Exit Function
    End If
    Do While Bac_SQL_Fetch(Datos())
        Combo.AddItem (Datos(2) & Space(90) & Datos(1))
    Loop
    LlenaComboMotivos = True
End Function
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Call Limpiar
        Case 2
            Call Buscar
        Case 3
            Call Grabar
        Case 4
            Unload Me
    End Select
End Sub
Private Sub Limpiar()
    Avance.Visible = False
    lblAvance.Visible = False
    infoPanel.Visible = False
    cmbMotivos.Visible = False
    txtRutCliente.Text = "0"
    txtDigito.Text = "0"
    txtCodCli.Text = "1"
    txtRutCliente.Enabled = True
    txtDigito.Enabled = True
    txtCodCli.Enabled = True
    cmbTipoCliente.ListIndex = 0
    txtNomCli.Text = "TODOS"
    grilla.Clear
    grilla.Rows = grilla.FixedRows
    Call defGrilla
    'txtRutCliente.SetFocus
End Sub
Private Function Grabar() As Boolean
    'Recorrer toda la grilla fila a fila.  Si hay un bloqueo, enviar una "S".  Si no hay ningún bloqueo, enviar modo "E" para eliminar al cliente de la tabla de bloqueos (si existe)
    'Primero revisar si tiene seleccionado un motivo con al menos un bloqueo.
    Dim I As Long
    Dim pcAvance As Long
    If grilla.Rows = 2 And FilaVacia(grilla, 1) Then
        MsgBox "No hay datos para grabar!", vbExclamation, "Validación de Datos"
        Exit Function
    End If
    Grabar = False
    For I = 1 To grilla.Rows - 1
        If CantBloqueos(I) > 0 Then
            If Trim(grilla.TextMatrix(I, 9)) = "" Then
                MsgBox "Atención! Falta seleccionar un motivo de bloqueo!", vbExclamation, "Validación de datos"
                Exit Function
            End If
        End If
    Next I
    Avance.Visible = True
    lblAvance.Visible = True
    
    infoPanel.Visible = True
    Call ColocaPanel("G")
    
    BacControlWindows 1
        
    Avance.Value = 0
    lblAvance.Caption = "0%"
    'Bloquear la grilla y los elementos del formulario
    grilla.Enabled = False
    fraSelector.Enabled = False
    Toolbar1.Enabled = False
    
    For I = 1 To grilla.Rows - 1
        If CantBloqueos(I) > 0 Then
            GrabaBloqueo (I)
        Else
            BorraBloqueo (I)
        End If
        pcAvance = CInt((I / grilla.Rows) * 100)
        
        'BacControlWindows 1
        DoEvents
        
        lblAvance.Caption = Str(pcAvance) & "%"
        Avance.Value = pcAvance
    Next I
    grilla.Enabled = True
    fraSelector.Enabled = True
    Toolbar1.Enabled = True
    
    infoPanel.Visible = False
    Call Limpiar
    
End Function
Private Function GrabaBloqueo(ByVal Fila As Long) As Boolean
    Dim nomSp As String
    Dim Datos()
    Envia = Array()
    nomSp = "BacParamsuda.dbo.SP_MNT_BLOQUEOS_CLIENTES"
    AddParam Envia, 0
    AddParam Envia, CLng(grilla.TextMatrix(Fila, 0))  'Rut Cliente
    AddParam Envia, CInt(grilla.TextMatrix(Fila, 1))  'Cód. Cliente
    AddParam Envia, "G"                         'Modo de Operación, Grabar
    AddParam Envia, IIf(grilla.TextMatrix(Fila, 3) = "X", "S", "N")   'Todos
    AddParam Envia, IIf(grilla.TextMatrix(Fila, 4) = "X", "S", "N")   'Forward
    AddParam Envia, IIf(grilla.TextMatrix(Fila, 5) = "X", "S", "N")   'Swaps
    AddParam Envia, IIf(grilla.TextMatrix(Fila, 6) = "X", "S", "N")   'Opciones
    AddParam Envia, IIf(grilla.TextMatrix(Fila, 7) = "X", "S", "N")   'Spot
    AddParam Envia, IIf(grilla.TextMatrix(Fila, 8) = "X", "S", "N")   'Pactos
    AddParam Envia, CInt(grilla.TextMatrix(Fila, 10))   'Cód. Motivo
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        GrabaBloqueo = False
        Exit Function
    End If
    GrabaBloqueo = True
End Function
Private Function BorraBloqueo(ByVal Fila As Long) As Boolean
    Dim nomSp As String
    Dim Datos()
    Envia = Array()
    nomSp = "BacParamsuda.dbo.SP_MNT_BLOQUEOS_CLIENTES"
    With grilla
        AddParam Envia, 0
        AddParam Envia, CLng(.TextMatrix(Fila, 0))  'Rut Cliente
        AddParam Envia, CInt(.TextMatrix(Fila, 1))  'Cód. Cliente
        AddParam Envia, "E"                         'Modo de Operación, Eliminar
    End With
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        BorraBloqueo = False
        Exit Function
    End If
    BorraBloqueo = True
End Function
Private Function CantBloqueos(ByVal xfila As Long) As Long
    Dim j As Long
    Dim van As Long
    van = 0
    For j = 4 To 8  'Revisa los bloqueos individuales
        If grilla.TextMatrix(xfila, j) = "X" Then
            van = van + 1
        End If
    Next j
    CantBloqueos = van
End Function
Private Function Buscar() As Boolean
    'Llenar grilla
    Call LlenaGrilla(txtRutCliente.Text, txtCodCli.Text, cmbTipoCliente.Text, "L")
End Function
Private Sub defGrilla()
    grilla.WordWrap = True
    grilla.Rows = 2:      grilla.Cols = 11
    grilla.Row = 1:       grilla.Col = 1
    grilla.FixedRows = 1: grilla.FixedCols = 0
    grilla.RowHeight(0) = 315
    grilla.RowHeight(1) = 315
        
    grilla.TextMatrix(0, 0) = "N° RUT":        grilla.ColWidth(0) = 1100:  grilla.TextMatrix(1, 0) = ""
    grilla.TextMatrix(0, 1) = "COD.":   grilla.ColWidth(1) = 650:   grilla.TextMatrix(1, 1) = ""
    grilla.TextMatrix(0, 2) = "NOMBRE CLIENTE":   grilla.ColWidth(2) = 5300:   grilla.TextMatrix(1, 2) = ""
    grilla.TextMatrix(0, 3) = "TODOS":   grilla.ColWidth(3) = 760:   grilla.TextMatrix(1, 3) = ""
    grilla.TextMatrix(0, 4) = "BFW":   grilla.ColWidth(4) = 600:   grilla.TextMatrix(1, 4) = ""
    grilla.TextMatrix(0, 5) = "SWAPS":   grilla.ColWidth(5) = 800:   grilla.TextMatrix(1, 5) = ""
    grilla.TextMatrix(0, 6) = "OPT":   grilla.ColWidth(6) = 600:   grilla.TextMatrix(1, 6) = ""
    grilla.TextMatrix(0, 7) = "SPOT":   grilla.ColWidth(7) = 700:   grilla.TextMatrix(1, 7) = ""
    grilla.TextMatrix(0, 8) = "PACTOS":   grilla.ColWidth(8) = 820:   grilla.TextMatrix(1, 8) = ""
    grilla.TextMatrix(0, 9) = "MOTIVO BLOQUEO":   grilla.ColWidth(9) = 3080:   grilla.TextMatrix(1, 9) = ""
    grilla.TextMatrix(0, 10) = "COD. BLOQUEO":  grilla.ColWidth(10) = 0:   grilla.TextMatrix(1, 10) = ""
    
    grilla.ColAlignment(1) = 4
    grilla.ColAlignment(2) = 1
    grilla.ColAlignment(3) = 4
    grilla.ColAlignment(4) = 4  'Centro
    grilla.ColAlignment(5) = 4
    grilla.ColAlignment(6) = 4
    grilla.ColAlignment(7) = 4
    grilla.ColAlignment(8) = 4
    grilla.ColAlignment(9) = 1
    
End Sub

Private Sub txtCodCli_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txtcodcli_LostFocus()
    'Validar si los otros datos existen
    If Trim(txtRutCliente.Text) = "" Or txtRutCliente.Text = "0" Then
        Exit Sub
    End If
    If Trim(txtDigito.Text) = "" Then
        Exit Sub
    End If
    Dim Datos()
    Envia = Array()
    AddParam Envia, CDbl(txtRutCliente.Text)
    AddParam Envia, Trim(txtDigito.Text)
    AddParam Envia, CDbl(txtCodCli.Text)
    If Not Bac_Sql_Execute("SP_MDCLLEERRUT", Envia) Then
        Exit Sub
    End If
    Do While Bac_SQL_Fetch(Datos())
        txtNomCli.Text = Datos(4)
    Loop
    If Trim(txtNomCli.Text) <> "" And Trim(txtNomCli.Text) <> "TODOS" Then
        txtRutCliente.Enabled = False
        txtDigito.Enabled = False
        txtCodCli.Enabled = False
    End If
End Sub
Private Function LlenaGrilla(ByVal rut As String, ByVal cod As String, ByVal Tipo As String, ByVal modo As String) As Boolean
On Error GoTo ErrLlena
    BacControlWindows 20
    Dim tipoClte As Integer
    Dim eRut As Long
    Dim eCod As Integer
    Dim nomSp As String
    Dim I As Long
    Dim xCod As String
    'Vaciar la grilla primero...
    grilla.Clear
    grilla.Rows = grilla.FixedRows
    Call defGrilla
    
    If Trim(Tipo) = "TODOS" Then
        tipoClte = 0
    Else
        tipoClte = CInt(Trim(Mid$(Tipo, 80)))
    End If
    Dim Datos()
    Envia = Array()
    If Trim(rut) = "" Then
        eRut = 0
    Else
        eRut = CLng(rut)
    End If
    eCod = CInt(cod)
    I = 1
    
    infoPanel.Visible = True
    Call ColocaPanel("L")
    
    BacControlWindows 1
    
    nomSp = "BacParamsuda.dbo.SP_MNT_BLOQUEOS_CLIENTES"
    AddParam Envia, tipoClte
    AddParam Envia, eRut
    AddParam Envia, eCod
    AddParam Envia, modo
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        LlenaGrilla = False
        infoPanel.Visible = True
        BacControlWindows 1
        Exit Function
    End If
    Do While Bac_SQL_Fetch(Datos())
        grilla.Rows = grilla.Rows + 1
        grilla.RowHeight(I) = 315
        grilla.TextMatrix(I, 0) = Datos(1)
        grilla.TextMatrix(I, 1) = Datos(2)
        grilla.TextMatrix(I, 2) = Datos(3)
        grilla.TextMatrix(I, 3) = IIf(Datos(4) = "S", "X", " ")
        grilla.TextMatrix(I, 4) = IIf(Datos(5) = "S", "X", " ")
        grilla.TextMatrix(I, 5) = IIf(Datos(6) = "S", "X", " ")
        grilla.TextMatrix(I, 6) = IIf(Datos(7) = "S", "X", " ")
        grilla.TextMatrix(I, 7) = IIf(Datos(8) = "S", "X", " ")
        grilla.TextMatrix(I, 8) = IIf(Datos(9) = "S", "X", " ")
        grilla.TextMatrix(I, 10) = Datos(10)
        xCod = Codigos(Datos(10))
        grilla.TextMatrix(I, 9) = xCod
        I = I + 1
    Loop
    'Si la última fila está vacía, borrarla
    If FilaVacia(grilla, grilla.Rows - 1) Then
        grilla.RemoveItem (grilla.Rows - 1)
    End If
    infoPanel.Visible = False
    BacControlWindows 1
    
    Exit Function
ErrLlena:
    infoPanel.Visible = False
    BacControlWindows 1
    
End Function
Private Function Codigos(ByVal cod As Double) As String
    Dim bCodigos As String
    If cod = -1 Then
        Codigos = " "
        Exit Function
    End If
    bCodigos = BuscaCod(cod)
    Codigos = bCodigos
End Function
Private Function ColocaPanel(ByVal Estado As String) As Boolean
    Dim xTop As Long
    Dim xLeft As Long
    xTop = CInt((grilla.Height - infoPanel.Height) / 2)
    xLeft = CInt((grilla.Width - infoPanel.Width) / 2)
    infoPanel.Top = xTop
    infoPanel.Left = xLeft
    Select Case Estado
        Case "L"
            infoPanel.Caption = "Un momento, por favor.  Cargando datos..."
        Case "G"
            infoPanel.Caption = "Un momento, por favor.  Grabando datos..."
    End Select
    ColocaPanel = True
End Function
Private Function NumCodigos(ByVal cod As String) As Long
    'Encuentra el codigo real de la combo asociado a la posición buscada
    Dim I As Long
    Dim nCod As Long
    NumCodigos = -1
    If cod = "-1" Then
        Exit Function
    End If
    For I = 0 To cmbMotivos.ListCount - 1
        nCod = CLng(Trim(Mid$(cmbMotivos.List(I), 90)))
        If nCod = CLng(cod) Then
            NumCodigos = I
            Exit For
        End If
    Next I
End Function
Private Function BuscaCod(ByVal bCod As Double) As String
    Dim nCod As Long
    Dim I As Long
    'nCod = CLng(bCod)
    BuscaCod = ""
    For I = 0 To cmbMotivos.ListCount - 1
        If Trim(Mid$(cmbMotivos.List(I), 90)) <> "" Then
        nCod = CDbl(Trim(Mid$(cmbMotivos.List(I), 90)))
            If nCod = CLng(bCod) Then
                BuscaCod = Trim(Mid$(cmbMotivos.List(I), 1, 80))
                Exit For
            End If
        End If
    Next I
End Function

Private Sub txtDigito_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        SendKeys "{TAB}"
    End If
    
End Sub

Private Sub txtRutCliente_DblClick()
    'BacAyuda.Tag = "MDCL"
    Dim sTipo As String
    If cmbTipoCliente.Text = "TODOS" Then
        sTipo = 0
    Else
        sTipo = Trim(Mid$(cmbTipoCliente.Text, 80))
    End If
'    BacAyuda.Tag = "CLIXTIPO" & sTipo
'    BacAyuda.Show 1
     BacAyudaCliente.Tag = "CLIXTIPO" & sTipo
     BacAyudaCliente.Show 1
     
    If giAceptar = True Then
        txtRutCliente.Text = Val(gsrut$)
        txtDigito.Text = gsDigito$
        txtCodCli.Text = gsValor$
        txtNomCli.Text = gsDescripcion$
        txtRutCliente.Enabled = False
        txtDigito.Enabled = False
        txtCodCli.Enabled = False
    End If
End Sub
Private Sub LlenaCombo()
    Dim Datos()
    Dim nomSp As String
    Envia = Array()
    nomSp = "BacParamsuda.dbo.SP_LEERCODIGOS"
    AddParam Envia, MDTC_TIPOCLIENTE
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        Exit Sub
    End If
    cmbTipoCliente.AddItem ("TODOS")
    Do While Bac_SQL_Fetch(Datos())
        cmbTipoCliente.AddItem (Datos(6) & Space(90) & Datos(2))
    Loop
End Sub

Private Sub txtRutCliente_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        SendKeys "{TAB}"
    End If
End Sub
Private Function PROC_POSI_COMBO(grilla As MSFlexGrid, Combo As ComboBox)
    Combo.Top = grilla.CellTop + grilla.Top + 20
    Combo.Left = grilla.CellLeft + grilla.Left + 20
    Combo.Width = grilla.CellWidth - 20
End Function
