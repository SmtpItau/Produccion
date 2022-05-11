VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_CONTROL_TRHESHOLD 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Control de Threshold"
   ClientHeight    =   5760
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8475
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5760
   ScaleWidth      =   8475
   Begin Threed.SSPanel PnlProgress 
      Align           =   2  'Align Bottom
      Height          =   345
      Left            =   0
      TabIndex        =   19
      Top             =   5415
      Width           =   8475
      _Version        =   65536
      _ExtentX        =   14949
      _ExtentY        =   609
      _StockProps     =   15
      ForeColor       =   -2147483639
      BackColor       =   14215660
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.26
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   1
      BevelInner      =   1
      FloodType       =   1
      FloodColor      =   -2147483646
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   8475
      _ExtentX        =   14949
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
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar ventana"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3165
         Top             =   0
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
               Picture         =   "FRM_MNT_CONTROL_TRHESHOLD.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONTROL_TRHESHOLD.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONTROL_TRHESHOLD.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONTROL_TRHESHOLD.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONTROL_TRHESHOLD.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONTROL_TRHESHOLD.frx":3E82
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONTROL_TRHESHOLD.frx":4D5C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONTROL_TRHESHOLD.frx":5C36
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FRA_FILTROS 
      Height          =   765
      Left            =   30
      TabIndex        =   4
      Top             =   375
      Width           =   8445
      Begin VB.ComboBox CMBSegmento 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   60
         Style           =   2  'Dropdown List
         TabIndex        =   0
         ToolTipText     =   "Segmento Comercial"
         Top             =   330
         Width           =   4080
      End
      Begin VB.ComboBox CMBModulo 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   4155
         Style           =   2  'Dropdown List
         TabIndex        =   1
         ToolTipText     =   "Modulos"
         Top             =   330
         Width           =   4200
      End
      Begin VB.Label LBLEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Segmento Comercial."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   2
         Left            =   75
         TabIndex        =   6
         Top             =   120
         Width           =   1800
      End
      Begin VB.Label LBLEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Modulo."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   4170
         TabIndex        =   5
         Top             =   120
         Width           =   660
      End
   End
   Begin VB.Frame FRA_DETALLE 
      Enabled         =   0   'False
      Height          =   4365
      Left            =   30
      TabIndex        =   7
      Top             =   1050
      Width           =   6210
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   4200
         Left            =   30
         TabIndex        =   2
         Top             =   120
         Width           =   6150
         _ExtentX        =   10848
         _ExtentY        =   7408
         _Version        =   393216
         Rows            =   10
         Cols            =   4
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
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
   End
   Begin VB.Frame FRA_MODIFICACION 
      Enabled         =   0   'False
      Height          =   4350
      Left            =   6270
      TabIndex        =   8
      Top             =   1050
      Width           =   2190
      Begin MSComctlLib.Toolbar Toolbar2 
         Height          =   450
         Left            =   30
         TabIndex        =   18
         Top             =   3885
         Width           =   2145
         _ExtentX        =   3784
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
            NumButtons      =   4
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Style           =   3
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Aceptar Modificación"
               ImageIndex      =   7
            EndProperty
            BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Style           =   3
            EndProperty
            BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Cancelar Modificación"
               ImageIndex      =   8
            EndProperty
         EndProperty
         BorderStyle     =   1
      End
      Begin VB.ComboBox CMBClasifRiesgo 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   75
         Style           =   2  'Dropdown List
         TabIndex        =   17
         Top             =   2370
         Visible         =   0   'False
         Width           =   1995
      End
      Begin VB.ComboBox CMBControlaThreshold 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   75
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   1665
         Width           =   1995
      End
      Begin BACControles.TXTNumero TXTAños 
         Height          =   300
         Left            =   45
         TabIndex        =   11
         Top             =   960
         Width           =   990
         _ExtentX        =   1746
         _ExtentY        =   529
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
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
      Begin BACControles.TXTNumero TXTDias 
         Height          =   300
         Left            =   1080
         TabIndex        =   13
         Top             =   960
         Width           =   990
         _ExtentX        =   1746
         _ExtentY        =   529
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
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
      Begin VB.Label LBLEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Clasificación de Riesgo"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   5
         Left            =   75
         TabIndex        =   16
         Top             =   2160
         Visible         =   0   'False
         Width           =   1905
      End
      Begin VB.Label LBLEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Controla Threshold"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   4
         Left            =   75
         TabIndex        =   14
         Top             =   1440
         Width           =   1605
      End
      Begin VB.Label LBLEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Plazo Años"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   3
         Left            =   75
         TabIndex        =   12
         Top             =   750
         Width           =   915
      End
      Begin VB.Label LBLEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Plazo Dias"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   1110
         TabIndex        =   10
         Top             =   750
         Width           =   855
      End
      Begin VB.Label LBLMensaje 
         Alignment       =   2  'Center
         BackColor       =   &H8000000C&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Valores de Registro Seleccionado."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   495
         Left            =   45
         TabIndex        =   9
         Top             =   120
         Width           =   2115
      End
   End
End
Attribute VB_Name = "FRM_MNT_CONTROL_TRHESHOLD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const CATSegmentoCom = 8020

Private Function FuncSettingGrid()
   Let Grid.Rows = 2:      Grid.Cols = 5
   Let Grid.FixedRows = 1: Grid.FixedCols = 0

   Let Grid.TextMatrix(0, 0) = "Producto":      Let Grid.ColWidth(0) = 2500
   Let Grid.TextMatrix(0, 1) = "Plazo":         Let Grid.ColWidth(1) = 1100
   Let Grid.TextMatrix(0, 2) = "Threshold":     Let Grid.ColWidth(2) = 1100
   Let Grid.TextMatrix(0, 3) = "Clas. Riesgo":  Let Grid.ColWidth(3) = 1100
   Let Grid.TextMatrix(0, 4) = "CodProducto":   Let Grid.ColWidth(4) = 0
End Function

Private Function FuncLoadSegmentos()
   Dim SQLDatos()

   Let Screen.MousePointer = vbHourglass

   Envia = Array()
   If Not Bac_Sql_Execute("BacParamsuda.dbo.SP_TRAESEGMENTOCOMERCIAL") Then
      Let Screen.MousePointer = vbDefault
      Exit Function
   End If

   Call CMBSegmento.Clear

   Do While Bac_SQL_Fetch(SQLDatos())
      Call CMBSegmento.AddItem(SQLDatos(1))
       Let CMBSegmento.ItemData(CMBSegmento.NewIndex) = SQLDatos(2)
   Loop

   Let Screen.MousePointer = vbDefault
End Function

Private Function FuncLoadSistemas()
   Dim SQLDatos()

   Let Screen.MousePointer = vbHourglass

   Envia = Array()
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_TRAESISTEMASTHRESHOLD") Then
      Let Screen.MousePointer = vbDefault
      Exit Function
   End If

   Call CMBModulo.Clear

   Do While Bac_SQL_Fetch(SQLDatos())
      Call CMBModulo.AddItem(SQLDatos(1) & Space(1000) & SQLDatos(2))
   Loop
   Let Screen.MousePointer = vbDefault
End Function

Private Function FuncControlObjetos(ByVal xValor As Boolean)
   Let Toolbar1.Buttons(2).Enabled = xValor        '--> Buscar
   Let Toolbar1.Buttons(3).Enabled = Not xValor    '--> Limpiar
   Let Toolbar1.Buttons(4).Enabled = Not xValor    '--> Grabar
   Let Toolbar1.Buttons(5).Enabled = Not xValor    '--> Eliminar

   Let FRA_DETALLE.Enabled = Not xValor
   Let FRA_FILTROS.Enabled = xValor
End Function

Private Sub Form_Load()
   Let Me.top = 0:   Let Me.Left = 0
   Let Me.Icon = BacControlFinanciero.Icon
   
   Let PnlProgress.FloodType = 0 '--> Sin Formato
   Call FuncControlObjetos(True)

   Call CMBControlaThreshold.AddItem("SI")
   Call CMBControlaThreshold.AddItem("NO")

   Call CMBClasifRiesgo.AddItem("")
   Call CMBClasifRiesgo.AddItem("CON CLAS.")
   Call CMBClasifRiesgo.AddItem("SIN CLAS.")

   Call FuncLoadSegmentos
   Call FuncLoadSistemas

   Call FuncSettingGrid
End Sub

Private Function FuncClear()
   Let Grid.Rows = 1
   Call FuncControlObjetos(True)
End Function

Private Sub Grid_DblClick()
   Let FRA_MODIFICACION.Enabled = True
   Let FRA_DETALLE.Enabled = False
   Let Toolbar1.Enabled = False
   
   Let TXTDias.Text = Grid.TextMatrix(Grid.RowSel, 1)
   Let TXTAños.Text = (TXTDias.Text / 365)
   Let CMBControlaThreshold.Text = Grid.TextMatrix(Grid.RowSel, 2)

   If Grid.TextMatrix(Grid.RowSel, 3) = "" Then
      Let CMBClasifRiesgo.ListIndex = 0
   Else
      Let CMBClasifRiesgo.Text = Grid.TextMatrix(Grid.RowSel, 3)
   End If

   Let CMBClasifRiesgo.Enabled = True
   Call ControlGridColor(False)
End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
   If Button.Index = 2 Then
      Let Grid.TextMatrix(Grid.RowSel, 1) = CDbl(TXTDias.Text)
         Let Grid.TextMatrix(Grid.RowSel, 2) = CMBControlaThreshold.List(CMBControlaThreshold.ListIndex)
      Let Grid.TextMatrix(Grid.RowSel, 3) = CMBClasifRiesgo.List(CMBClasifRiesgo.ListIndex)
   End If

   Let TXTAños.Text = 0
   Let TXTDias.Text = 0
   Let CMBControlaThreshold.ListIndex = -1
   Let CMBClasifRiesgo.ListIndex = -1

   Let FRA_DETALLE.Enabled = True
   Let Toolbar1.Enabled = True
   Let FRA_MODIFICACION.Enabled = False
   Call ControlGridColor(True)
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2: Call FuncLoadDatos
      Case 3: Call FuncClear
      Case 4: Call FuncSavedata
     ' Case 5: Call FuncErasedata
      Case 7: Call Unload(Me)
   End Select
End Sub

Private Function FuncSavedata()
   Dim iContador  As Long

   If Not BacBeginTransaction Then
      Exit Function
   End If

   Let Screen.MousePointer = vbHourglass
   Let PnlProgress.FloodType = 1 '--> Right to Left
   Let PnlProgress.ForeColor = vbBlack

   For iContador = 1 To Grid.Rows - 1

      Envia = Array()
      AddParam Envia, CMBSegmento.ItemData(CMBSegmento.ListIndex)
      AddParam Envia, Right(CMBModulo.List(CMBModulo.ListIndex), 3)
      AddParam Envia, CDbl(Grid.TextMatrix(iContador, 4))
      AddParam Envia, CDbl(Grid.TextMatrix(iContador, 1))
      AddParam Envia, Grid.TextMatrix(iContador, 2)
      AddParam Envia, Grid.TextMatrix(iContador, 3)
      If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_ACTUALIZA_CONTROL_TRHESHOLD", Envia) Then
         Call BacRollBackTransaction
         Let PnlProgress.FloodType = 1
         Let Screen.MousePointer = vbDefault
         Call MsgBox("Se ha originado un error en la actualización.", vbExclamation, App.Title)
         Exit Function
      End If

      Let PnlProgress.FloodPercent = ((iContador * 100) / (Grid.Rows - 1))
      If PnlProgress.FloodPercent >= 50 Then
         Let PnlProgress.ForeColor = vbWhite
      End If

   Next iContador

   Call BacCommitTransaction

   Let Screen.MousePointer = vbDefault

   Call MsgBox("Se ha finalizado la actualización correctamente.", vbInformation, App.Title)

   Let PnlProgress.FloodType = 0

   Call FuncClear

End Function

Private Function FuncLoadDatos()
   Dim Segmento   As Long
   Dim Modulo     As String
   Dim SQLDatos()

   If CMBSegmento.ListIndex < 0 Then
      Call MsgBox("Se debe seleccionar un segmento para realizar la busqueda.", vbExclamation, App.Title)
      Exit Function
   End If
   If CMBModulo.ListIndex < 0 Then
      Call MsgBox("Se debe seleccionar un Modulo para realizar la busqueda.", vbExclamation, App.Title)
      Exit Function
   End If

   Let Screen.MousePointer = vbHourglass

   Let Segmento = CMBSegmento.ItemData(CMBSegmento.ListIndex)
   Let Modulo = Right(CMBModulo.List(CMBModulo.ListIndex), 3)

   Envia = Array()
   AddParam Envia, Segmento
   AddParam Envia, Modulo
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LER_TABLA_CONTROL", Envia) Then
      Let Screen.MousePointer = vbDefault
      Exit Function
   End If

   Let Grid.Rows = 1

   Do While Bac_SQL_Fetch(SQLDatos())
      Let Grid.Rows = Grid.Rows + 1

      Let Grid.TextMatrix(Grid.Rows - 1, 0) = SQLDatos(1)
      Let Grid.TextMatrix(Grid.Rows - 1, 1) = SQLDatos(2)
      Let Grid.TextMatrix(Grid.Rows - 1, 2) = IIf(SQLDatos(3) = "N", "NO", "SI")
      Let Grid.TextMatrix(Grid.Rows - 1, 3) = SQLDatos(4)
      Let Grid.TextMatrix(Grid.Rows - 1, 4) = SQLDatos(5)
   Loop

   Call FuncControlObjetos(False)

   Let Screen.MousePointer = vbDefault
End Function

Private Sub TXTAños_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      Let TXTDias.Text = TXTAños.Text * 365
   End If
End Sub

Private Sub TXTAños_LostFocus()
   Let TXTDias.Text = TXTAños.Text * 365
End Sub


Private Function ControlGridColor(ByVal oValor As Boolean)

    Let Grid.BackColorFixed = IIf(oValor = True, &H80000002, &H8000000C)
    Let LBLMensaje.BackColor = IIf(Not oValor = True, &H80000002, &H8000000C)

    Let Grid.Redraw = False
    Let Grid.Redraw = True
   Call Grid.Refresh
   Call BacControlWindows(10)

End Function
