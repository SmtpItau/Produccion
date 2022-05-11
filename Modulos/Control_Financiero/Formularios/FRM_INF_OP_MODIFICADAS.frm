VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_INF_OP_MODIFICADAS 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Informe de Operaciones Modificadas"
   ClientHeight    =   8400
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   14595
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8400
   ScaleWidth      =   14595
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame3 
      Caption         =   "Rango de Fechas"
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
      Height          =   900
      Left            =   15
      TabIndex        =   10
      Top             =   525
      Width           =   3300
      Begin BACControles.TXTFecha FechaFinal 
         Height          =   285
         Left            =   1710
         TabIndex        =   1
         Top             =   480
         Width           =   1425
         _ExtentX        =   2514
         _ExtentY        =   503
         Enabled         =   -1  'True
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
         ForeColor       =   8388608
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "06/10/2011"
      End
      Begin BACControles.TXTFecha FechaInicial 
         Height          =   300
         Left            =   60
         TabIndex        =   0
         Top             =   480
         Width           =   1410
         _ExtentX        =   2487
         _ExtentY        =   529
         Enabled         =   -1  'True
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
         ForeColor       =   8388608
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "06/10/2011"
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Final"
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
         Left            =   1695
         TabIndex        =   12
         Top             =   285
         Width           =   1005
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Inicial"
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
         Left            =   75
         TabIndex        =   11
         Top             =   255
         Width           =   1110
      End
   End
   Begin VB.Frame Frame2 
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
      Height          =   6930
      Left            =   15
      TabIndex        =   8
      Top             =   1425
      Width           =   14520
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   6690
         Left            =   30
         TabIndex        =   9
         Top             =   165
         Width           =   14445
         _ExtentX        =   25479
         _ExtentY        =   11800
         _Version        =   393216
         Cols            =   10
         BackColor       =   -2147483634
         ForeColor       =   8388608
         BackColorFixed  =   8421440
         ForeColorFixed  =   -2147483643
         BackColorSel    =   -2147483643
         ForeColorSel    =   8388608
         GridColorFixed  =   16777215
         AllowBigSelection=   0   'False
         TextStyle       =   3
         GridLinesFixed  =   1
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
   Begin VB.Frame Frame1 
      Height          =   900
      Left            =   3420
      TabIndex        =   5
      Top             =   525
      Width           =   7440
      Begin VB.ComboBox cmbCorrMod 
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
         Height          =   315
         Left            =   4620
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   480
         Width           =   2700
      End
      Begin VB.ComboBox cmbOperacion 
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
         Height          =   315
         Left            =   2715
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   480
         Width           =   1800
      End
      Begin VB.ComboBox cmbSistema 
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
         Height          =   315
         Left            =   105
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   480
         Width           =   2385
      End
      Begin VB.Label lblCorrMod 
         AutoSize        =   -1  'True
         Caption         =   "Correlativo Mod."
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
         Left            =   4650
         TabIndex        =   14
         Top             =   285
         Width           =   1410
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "N° Operación"
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
         Left            =   2715
         TabIndex        =   7
         Top             =   285
         Width           =   1155
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Sistema"
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
         Left            =   90
         TabIndex        =   6
         Top             =   285
         Width           =   675
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   14595
      _ExtentX        =   25744
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "A Pantalla"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "A Impresora"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7380
      Top             =   30
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
            Picture         =   "FRM_INF_OP_MODIFICADAS.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INF_OP_MODIFICADAS.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INF_OP_MODIFICADAS.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INF_OP_MODIFICADAS.frx":20CE
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_INF_OP_MODIFICADAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public colorFore As Long
Public colorBack As Long
Public colSelec As Long
Public oldFechaIni As String
Public oldFechaFin As String
Private Function SeteaGrilla()
   grilla.Rows = 2:        grilla.Cols = 5  '10
   grilla.FixedRows = 1:   grilla.FixedCols = 1

   grilla.RowHeightMin = 260

   grilla.TextMatrix(0, 0) = "ITEMS":               grilla.ColWidth(0) = 3600:      grilla.ColAlignment(0) = flexAlignLeft
   grilla.TextMatrix(0, 1) = "DATOS ORIGINALES":    grilla.ColWidth(1) = 4300:      grilla.ColAlignment(1) = flexAlignLeft
   grilla.TextMatrix(0, 2) = "DATOS NUEVOS":        grilla.ColWidth(2) = 4300:      grilla.ColAlignment(2) = flexAlignLeft
   grilla.TextMatrix(0, 3) = "IGUALES":             grilla.ColWidth(3) = 1000:      grilla.ColAlignment(3) = flexAlignLeft
   grilla.TextMatrix(0, 4) = "Correlativo":         grilla.ColWidth(4) = 0:         grilla.ColAlignment(4) = flexAlignLeftCenter
   
End Function


Private Sub cmbCorrMod_Click()
    Dim DATOS()
    If cmbCorrMod.Text = "" Or cmbCorrMod.ListIndex = -1 Then
        Exit Sub
    End If
    If cmbOperacion.Text = "" Or cmbOperacion.ListIndex = -1 Then
        Exit Sub
    End If
    Dim Fila As Long
    Dim OpeSel As Long
    Dim Modulo As String
    Dim Mtm_cero As Boolean
    Dim nomSp As String
    Dim OrigenOpt As String
    Dim selFolio As Long
    Dim antFolio As Long
    Dim antPosicion As Long
    Dim selPosicion As Long
    Dim xSelFolio As String
    Dim xAntFolio As String
    Dim xPSel As Long
    Dim xPAnt As Long
    Mtm_cero = True
    Envia = Array()
    OpeSel = CLng(Val(cmbOperacion.Text))
    Select Case UCase(cmbSistema.Text)
        Case "FORWARD"
            Modulo = "BFW"
            selFolio = CLng(Val(Trim(Right(cmbCorrMod.Text, 20))))
            If cmbCorrMod.ListCount = 1 Or selFolio = 1 Then
                antFolio = 0
            Else
                antFolio = CLng(Val(Trim(Right(cmbCorrMod.List(cmbCorrMod.ListIndex - 1), 20))))
            End If
            nomSp = "BacParamsuda.dbo.SP_RET_DATOS_MODIFICACIONES"
            OrigenOpt = ""
            AddParam Envia, Modulo
            AddParam Envia, OpeSel
            AddParam Envia, antFolio
            AddParam Envia, selFolio
        Case "OPCIONES"
            Modulo = "OPT"
            xSelFolio = cmbCorrMod.Text
            selFolio = CLng(Val(Trim(Right(xSelFolio, 20))))
            xPSel = InStr(xSelFolio, "-")
            selPosicion = CLng(Val(Mid$(xSelFolio, 1, xPSel - 1)))
            If cmbCorrMod.ListCount = 1 Or selPosicion = 1 Then
                antFolio = 0
                antPosicion = 0
            Else
                xAntFolio = cmbCorrMod.List(cmbCorrMod.ListIndex - 1)
                xPAnt = InStr(xAntFolio, "-")
                antFolio = CLng(Val(Trim(Right(xAntFolio, 20))))
                antPosicion = CLng(Val(Mid$(xAntFolio, 1, xPAnt - 1)))
            End If
            nomSp = "BacParamsuda.dbo.SP_RET_DATOS_OPT_MODIFICACIONES"
            OrigenOpt = Trim(Right(cmbOperacion.Text, 20))
            AddParam Envia, Modulo
            AddParam Envia, OpeSel
            AddParam Envia, OrigenOpt
            AddParam Envia, antFolio
            AddParam Envia, selFolio
            AddParam Envia, antPosicion
            AddParam Envia, selPosicion
    End Select
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        MsgBox "Se ha producido un error al ejecutar " & nomSp, vbExclamation
        Exit Sub
    End If
    Fila = 1
    grilla.Rows = 1
    Do While Bac_SQL_Fetch(DATOS())
        With grilla
            .Rows = .Rows + 1
            .TextMatrix(Fila, 0) = DATOS(2)     'Item
            .CellBackColor = vbBrown
            .TextMatrix(Fila, 1) = IIf(IsNull(DATOS(3)) = True, "", DATOS(3))   'DatosOriginales
            .TextMatrix(Fila, 2) = IIf(IsNull(DATOS(4)) = True, "", DATOS(4))    'DatosNuevos
            If .Rows = 3 Then
                If DATOS(4) <> "" Then
                    If Format(DATOS(4), gsc_FechaDMA) <> gsBAC_Fecp Then
                        Mtm_cero = False
                    End If
                End If
            End If
            
'            If Format(DATOS(5), gsc_FechaDMA) <> gsBAC_Fecp Then
'                Mtm_cero = False
'            End If
            .TextMatrix(Fila, 4) = DATOS(1)     'Correlativo
            
            If Fila = 22 Then
                If Mtm_cero = True Then
                    grilla.TextMatrix(Fila, 1) = "0"
                    grilla.TextMatrix(Fila, 2) = "0"
                    DATOS(6) = "S"
                End If
            End If
            
            If DATOS(6) = "S" Then
                .TextMatrix(Fila, 3) = "SI"
                Call PintaFila(Fila, colorFore, colorBack)
            Else
                .TextMatrix(Fila, 3) = "NO"
                Call PintaFila(Fila, colSelec, colorBack)
            End If
            
'            If Mtm_cero = True Then
'                If Fila = 22 Then
'                    Grilla.TextMatrix(22, 1) = "0"
'                    Grilla.TextMatrix(22, 2) = "0"
'                    Grilla.TextMatrix(22, 3) = "SI"
'                    Call PintaFila(22, colorFore, colorBack)
'                End If
'            End If
        End With
        Fila = Fila + 1
    Loop
    'Cambiar el valor de MTM según Mtm_cero
'    If Mtm_cero = True Then
'        Grilla.TextMatrix(22, 1) = "0"
'        Grilla.TextMatrix(22, 2) = "0"
'        Grilla.TextMatrix(22, 3) = "SI"
'        Call PintaFila(22, colorFore, colorBack)
'    End If
    cmbCorrMod.Enabled = True
    'Borrar la operación de Opciones en tabla de registro
    If Modulo = "OPT" Then
        Call BorrarOpt(OpeSel)
    End If
    SendKeys "{TAB}"
End Sub
Private Function BorrarOpt(ByVal NumOp As Long) As Boolean
    Dim DATOS()
    Dim nomSp As String
    nomSp = "BacParamsuda.dbo.SP_BORRAR_OPT_REG_MOD"
    Envia = Array()
    AddParam Envia, NumOp
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        MsgBox "Se ha producido un error al ejecutar " & nomSp, vbExclamation
        BorrarOpt = False
        Exit Function
    End If
    BorrarOpt = True
End Function
Private Sub cmbOperacion_Click()
    'Activar el combo cmbCorrMod y llenarlo con los correlativos
    Dim DATOS()
    If cmbOperacion.Text = "" Or cmbOperacion.ListIndex = -1 Then
        Exit Sub
    End If
    Dim nomSp As String
    Dim proceso As String
    Dim OpeSel As Long
    Dim origen As String
    Call LimpiaGrilla
    Call LimpiaCombos(1)
    nomSp = "BacParamsuda.dbo.SP_RET_ORDEN_MODIFICACIONES"
    Envia = Array()
    proceso = UCase(cmbSistema.Text)
    Select Case proceso
        Case "FORWARD"
            AddParam Envia, "BFW"
            OpeSel = CLng(Val(cmbOperacion.Text))
            origen = ""
        Case "OPCIONES"
            AddParam Envia, "OPT"
            OpeSel = CLng(Val(Trim(Mid$(cmbOperacion.Text, 1, 20))))
            origen = Trim(Right(cmbOperacion.Text, 10))
    End Select
    AddParam Envia, OpeSel
    AddParam Envia, origen
    AddParam Envia, Format(FechaInicial.Text, "YYYYMMDD")
    AddParam Envia, Format(FechaFinal.Text, "YYYYMMDD")
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        MsgBox "Se ha producido un error al ejecutar " & nomSp, vbExclamation
        Exit Sub
    End If
    cmbCorrMod.Enabled = True
    cmbCorrMod.Clear
    Do While Bac_SQL_Fetch(DATOS())
        cmbCorrMod.AddItem (DATOS(1) & " - " & DATOS(3) & " - " & DATOS(4) & Space(80) & DATOS(2))
    Loop
End Sub
Private Sub cmbSistema_Click()
    'Llenar la combo cmbOperacion con los números de operación ordenados ascendentemente
    Dim opcion As String
    If Not (CDate(FechaFinal.Text) >= CDate(FechaInicial.Text)) Then
        MsgBox "La Fecha Inicial no debe ser mayor a la Fecha Final!", vbExclamation
        FechaFinal.Text = FechaInicial.Text
        cmbSistema.ListIndex = -1
        Call LimpiaGrilla
        Exit Sub
    End If
    Call LimpiaCombos(2)
    cmbOperacion.Enabled = True
    opcion = cmbSistema.Text
    Select Case UCase(opcion)
        Case "FORWARD"
            Call LimpiaGrilla
            Call LlenaFolios("BFW")
        Case "OPCIONES"
            Call LimpiaGrilla
            Call LlenaFolios("OPT")
        Case Else
            cmbOperacion.Enabled = False
    End Select
    
End Sub
Private Sub LimpiaGrilla()
    grilla.Rows = 1
    Call SeteaGrilla
End Sub
Private Sub FechaFinal_Change()
    If FechaFinal.Text > CStr(gsBAC_Fecp) Then
        MsgBox "La Fecha Final no puede ser mayor a la Fecha de Proceso!", vbExclamation
        FechaFinal.Text = CStr(gsBAC_Fecp)
        Exit Sub
    End If
    Call LimpiaGrilla
    Call LimpiaCombos(3)
    Call cmbSistema_Click
End Sub
Private Sub FechaFinal_GotFocus()
    oldFechaFin = CStr(FechaFinal.Text)
End Sub

Private Sub FechaInicial_Change()
    If Not (CDate(FechaFinal.Text) >= CDate(FechaInicial.Text)) Then
        MsgBox "La Fecha Inicial no debe ser mayor a la Fecha Final!", vbExclamation
        'FechaFinal.Text = FechaInicial.Text
        FechaInicial.Text = oldFechaIni
        cmbSistema.ListIndex = -1
        Call LimpiaGrilla
        Exit Sub
    End If
    
    Call LimpiaGrilla
    Call LimpiaCombos(3)
    Call cmbSistema_Click
End Sub
Private Sub FechaInicial_GotFocus()
    oldFechaIni = CStr(FechaInicial.Text)
End Sub


Private Sub Form_Load()
    Me.top = 0
    Me.Left = 0
    colorFore = grilla.ForeColor
    colorBack = grilla.BackColor
    colSelec = &H40C0&
    cmbSistema.Clear
    cmbSistema.AddItem ("Forward")
    cmbSistema.AddItem ("Opciones")
    Call SeteaGrilla
    FechaFinal.Text = CStr(gsBAC_Fecp)
    FechaInicial.Text = CStr(gsBAC_Fecp)
    cmbCorrMod.Enabled = False
    cmbOperacion.Enabled = False
End Sub
Private Function LimpiaCombos(ByVal x As Integer)
    Select Case x
        Case 1
            If cmbCorrMod.Enabled = True Then
                cmbCorrMod.Clear
                cmbCorrMod.Enabled = False
            End If
        Case 2
            If cmbOperacion.Enabled = True Then
                cmbOperacion.Clear
                cmbOperacion.Enabled = False
            End If
            If cmbCorrMod.Enabled = True Then
                cmbCorrMod.Clear
                cmbCorrMod.Enabled = False
            End If
        Case 3
            cmbSistema.ListIndex = -1
            If cmbOperacion.Enabled = True Then
                cmbOperacion.Clear
                cmbOperacion.Enabled = False
            End If
            If cmbCorrMod.Enabled = True Then
                cmbCorrMod.Clear
                cmbCorrMod.Enabled = False
            End If
    End Select
End Function
Private Sub Limpiar()
    FechaFinal.Text = CStr(gsBAC_Fecp)
    FechaInicial.Text = CStr(gsBAC_Fecp)
    cmbCorrMod.Clear
    cmbCorrMod.Enabled = False
    cmbOperacion.Clear
    cmbOperacion.Enabled = False
    cmbSistema.ListIndex = -1
    'cmbOperacion.ListIndex = -1
    Call LimpiaGrilla
End Sub
Private Sub LlenaFolios(ByVal Modulo As String)
    'Lista de la tabla BacParamsuda.dbo.TBL_REG_MODIFICACIONES el campo FolioContrato filtrando por modulo
    Dim DATOS()
    Dim n As Long
    Dim nomSp As String
    n = 0
    cmbOperacion.Clear
    If Modulo = "BFW" Then
        nomSp = "BacParamsuda.dbo.SP_RET_FOLIOS_CONTRATOS_MOD"
    Else
        nomSp = "BacParamsuda.dbo.SP_RET_FOLIOS_OPCIONES_MOD"
    End If
    Envia = Array()
    If Modulo = "BFW" Then
        AddParam Envia, Modulo
    End If
    AddParam Envia, Format(FechaInicial.Text, "YYYYMMDD")
    AddParam Envia, Format(FechaFinal.Text, "YYYYMMDD")
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        MsgBox "Se ha producido un error al ejecutar " & nomSp, vbExclamation
        Exit Sub
    End If
    Do While Bac_SQL_Fetch(DATOS())
        n = n + 1
        If Modulo = "OPT" Then
            cmbOperacion.AddItem (DATOS(1) & Space(80) & DATOS(2))
        Else
            cmbOperacion.AddItem (DATOS(1))
        End If
    Loop
    If n = 0 Then
        cmbOperacion.ListIndex = -1
    End If
    If cmbOperacion.ListCount = 0 Then
        cmbOperacion.Enabled = False
    Else
        cmbOperacion.Enabled = True
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Call Limpiar
        Case 2  'Informe a Pantalla
            Call APantalla
        Case 3  'Informe Impreso
            Call Impreso
        Case 4
            Unload Me
    End Select
End Sub
Private Function PintaFila(ByVal Fila As Integer, ByVal colF As Long, colB As Long) As Boolean
    Dim I As Long
    For I = 1 To grilla.Cols - 1
        grilla.Row = Fila
        grilla.Col = I
        grilla.CellForeColor = colF
        grilla.CellBackColor = colB
    Next
End Function
Private Function APantalla() As Boolean
    On Error GoTo Err_Print
    Dim Modulo As String
    Dim OpeSel As Long
    Dim selFolio As Long
    Dim antFolio As Long
    Dim xSelFolio As String
    Dim xAntFolio As String
    Dim xPSel As Long
    Dim xPAnt As Long
    Dim antPosicion As Long
    Dim selPosicion As Long
    Dim OrigenOpt As String
    
    If cmbSistema.ListIndex = -1 Then
        Exit Function
    End If
    If cmbOperacion.ListIndex = -1 Then
        Exit Function
    End If
    If cmbCorrMod.ListIndex = -1 Then
        Exit Function
    End If
    selFolio = CLng(Val(Trim(Right(cmbCorrMod.Text, 20))))
    If cmbCorrMod.ListCount = 1 Or selFolio = 1 Then
        antFolio = 0
    Else
        antFolio = CLng(Val(Trim(Right(cmbCorrMod.List(cmbCorrMod.ListIndex - 1), 20))))
    End If
    OpeSel = CLng(Val(cmbOperacion.Text))
    Select Case UCase(cmbSistema.Text)
        Case "FORWARD"
            Modulo = "BFW"
            OrigenOpt = " "
        Case "OPCIONES"
            Modulo = "OPT"
            OrigenOpt = Trim(Right(cmbOperacion.Text, 20))
            xSelFolio = cmbCorrMod.Text
            selFolio = CLng(Val(Trim(Right(xSelFolio, 20))))
            xPSel = InStr(xSelFolio, "-")
            selPosicion = CLng(Val(Mid$(xSelFolio, 1, xPSel - 1)))
            If cmbCorrMod.ListCount = 1 Or selPosicion = 1 Then
                antFolio = 0
            Else
                xAntFolio = cmbCorrMod.List(cmbCorrMod.ListIndex - 1)
                xPAnt = InStr(xAntFolio, "-")
                antFolio = CLng(Val(Trim(Right(xAntFolio, 20))))
                antPosicion = CLng(Val(Mid$(xAntFolio, 1, xPAnt - 1)))
            End If
    End Select
    
    Call Limpiar_Cristal
    BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "rpt_Ope_Modificadas.rpt"
    BacControlFinanciero.CryFinanciero.Destination = crptToWindow
    
    BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format$(gsBAC_Fecp, "YYYYMMDD")
    BacControlFinanciero.CryFinanciero.StoredProcParam(1) = gsBAC_User
    BacControlFinanciero.CryFinanciero.StoredProcParam(2) = Modulo
    BacControlFinanciero.CryFinanciero.StoredProcParam(3) = OpeSel
    
    BacControlFinanciero.CryFinanciero.StoredProcParam(4) = antFolio
    BacControlFinanciero.CryFinanciero.StoredProcParam(5) = selFolio
    
    BacControlFinanciero.CryFinanciero.StoredProcParam(6) = Format(FechaInicial.Text, "YYYYMMDD")
    BacControlFinanciero.CryFinanciero.StoredProcParam(7) = Format(FechaFinal.Text, "YYYYMMDD")
    
    BacControlFinanciero.CryFinanciero.StoredProcParam(8) = OrigenOpt
    BacControlFinanciero.CryFinanciero.StoredProcParam(9) = antPosicion
    BacControlFinanciero.CryFinanciero.StoredProcParam(10) = selPosicion
    
    BacControlFinanciero.CryFinanciero.Connect = swConeccion
    BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
    BacControlFinanciero.CryFinanciero.Action = 1
    
    If Modulo = "OPT" Then
        Call BorrarOpt(OpeSel)
    End If

    Exit Function

Err_Print:
   
    MsgBox BacControlFinanciero.CryFinanciero.ReportFileName & ", " & Err.Description, vbInformation, TITSISTEMA


End Function
Private Function Impreso() As Boolean
    On Error GoTo Err_Print
    Dim Modulo As String
    Dim OpeSel As Long
    Dim selFolio As Long
    Dim antFolio As Long
    Dim xSelFolio As String
    Dim xAntFolio As String
    Dim xPSel As Long
    Dim xPAnt As Long
    Dim antPosicion As Long
    Dim selPosicion As Long
    Dim OrigenOpt As String
    
    If cmbSistema.ListIndex = -1 Then
        Exit Function
    End If
    If cmbOperacion.ListIndex = -1 Then
        Exit Function
    End If
    If cmbCorrMod.ListIndex = -1 Then
        Exit Function
    End If
    selFolio = CLng(Val(Trim(Right(cmbCorrMod.Text, 20))))
    If cmbCorrMod.ListCount = 1 Or selFolio = 1 Then
        antFolio = 0
    Else
        antFolio = CLng(Val(Trim(Right(cmbCorrMod.List(cmbCorrMod.ListIndex - 1), 20))))
    End If
    OpeSel = CLng(Val(cmbOperacion.Text))
    Select Case UCase(cmbSistema.Text)
        Case "FORWARD"
            Modulo = "BFW"
            OrigenOpt = ""
        Case "OPCIONES"
            Modulo = "OPT"
            OrigenOpt = Trim(Right(cmbOperacion.Text, 20))
            xSelFolio = cmbCorrMod.Text
            selFolio = CLng(Val(Trim(Right(xSelFolio, 20))))
            xPSel = InStr(xSelFolio, "-")
            selPosicion = CLng(Val(Mid$(xSelFolio, 1, xPSel - 1)))
            If cmbCorrMod.ListCount = 1 Or selPosicion = 1 Then
                antFolio = 0
            Else
                xAntFolio = cmbCorrMod.List(cmbCorrMod.ListIndex - 1)
                xPAnt = InStr(xAntFolio, "-")
                antFolio = CLng(Val(Trim(Right(xAntFolio, 20))))
                antPosicion = CLng(Val(Mid$(xAntFolio, 1, xPAnt - 1)))
            End If
    End Select
    
    Call Limpiar_Cristal
    BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "rpt_Ope_Modificadas.rpt"
    BacControlFinanciero.CryFinanciero.Destination = crptToPrinter
    
    BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format$(gsBAC_Fecp, "YYYYMMDD")
    BacControlFinanciero.CryFinanciero.StoredProcParam(1) = gsBAC_User
    BacControlFinanciero.CryFinanciero.StoredProcParam(2) = Modulo
    BacControlFinanciero.CryFinanciero.StoredProcParam(3) = OpeSel
    
    BacControlFinanciero.CryFinanciero.StoredProcParam(4) = antFolio
    BacControlFinanciero.CryFinanciero.StoredProcParam(5) = selFolio
    
    BacControlFinanciero.CryFinanciero.StoredProcParam(6) = Format(FechaInicial.Text, "YYYYMMDD")
    BacControlFinanciero.CryFinanciero.StoredProcParam(7) = Format(FechaFinal.Text, "YYYYMMDD")
    
    BacControlFinanciero.CryFinanciero.StoredProcParam(8) = OrigenOpt
    BacControlFinanciero.CryFinanciero.StoredProcParam(9) = antPosicion
    BacControlFinanciero.CryFinanciero.StoredProcParam(10) = selPosicion
    
    BacControlFinanciero.CryFinanciero.Connect = swConeccion
    BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
    BacControlFinanciero.CryFinanciero.Action = 1
    
    If Modulo = "OPT" Then
        Call BorrarOpt(OpeSel)
    End If

    Exit Function

Err_Print:
   
    MsgBox BacControlFinanciero.CryFinanciero.ReportFileName & ", " & Err.Description, vbInformation, TITSISTEMA

End Function
