VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_CONVENCION_AJUSTE_INTERES 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Convencion de Ajuste Interes."
   ClientHeight    =   4440
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9765
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4440
   ScaleWidth      =   9765
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9765
      _ExtentX        =   17224
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3510
         Top             =   15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   6
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONVENCION_AJUSTE_INTERES.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONVENCION_AJUSTE_INTERES.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONVENCION_AJUSTE_INTERES.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONVENCION_AJUSTE_INTERES.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONVENCION_AJUSTE_INTERES.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CONVENCION_AJUSTE_INTERES.frx":4A42
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FRMTipTasa 
      Height          =   615
      Left            =   0
      TabIndex        =   1
      Top             =   435
      Width           =   9765
      Begin VB.ComboBox CmbTipotasa 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1245
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   180
         Width           =   3105
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Tipo de Tasa"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   135
         TabIndex        =   3
         Top             =   240
         Width           =   1050
      End
   End
   Begin VB.Frame FRA_Grilla 
      Height          =   3450
      Left            =   0
      TabIndex        =   4
      Top             =   975
      Width           =   9765
      Begin VB.ComboBox CmbBases 
         BackColor       =   &H8000000D&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   330
         Left            =   1155
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   840
         Visible         =   0   'False
         Width           =   1050
      End
      Begin BACControles.TXTNumero TxtNum 
         Height          =   225
         Left            =   1185
         TabIndex        =   5
         Top             =   480
         Visible         =   0   'False
         Width           =   930
         _ExtentX        =   1640
         _ExtentY        =   397
         BackColor       =   -2147483635
         ForeColor       =   -2147483634
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   3270
         Left            =   45
         TabIndex        =   6
         Top             =   135
         Width           =   9675
         _ExtentX        =   17066
         _ExtentY        =   5768
         _Version        =   393216
         BackColor       =   -2147483644
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483645
         GridColor       =   -2147483644
         GridColorFixed  =   -2147483642
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MNT_CONVENCION_AJUSTE_INTERES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub NombresGrilla()
   Grid.Rows = 3:    Grid.FixedRows = 2
   Grid.Cols = 4:    Grid.FixedCols = 0
   
   Grid.TextMatrix(0, 0) = "Codigo":      Grid.TextMatrix(1, 0) = "Base":     Grid.ColWidth(0) = 0:      Grid.ColAlignment(0) = flexAlignLeftCenter
   Grid.TextMatrix(0, 1) = "Tipo":        Grid.TextMatrix(1, 1) = "Base":     Grid.ColWidth(1) = 2500:   Grid.ColAlignment(1) = flexAlignLeftCenter
   Grid.TextMatrix(0, 2) = "Ajuste":      Grid.TextMatrix(1, 2) = "Pasivo":   Grid.ColWidth(2) = 1200:   Grid.ColAlignment(2) = flexAlignRightCenter
   Grid.TextMatrix(0, 3) = "Ajuste":      Grid.TextMatrix(1, 3) = "Activo":   Grid.ColWidth(3) = 1200:   Grid.ColAlignment(3) = flexAlignRightCenter
   Grid.RowHeightMin = 350
End Sub

Private Sub CargaBases()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, "CBC"
   If Not Bac_Sql_Execute("SP_MNT_CONVENCION_AJUSTE_INTERES", Envia) Then
      Exit Sub
   End If
   CmbBases.Clear
   Do While Bac_SQL_Fetch(Datos())
      CmbBases.AddItem Datos(2)
      CmbBases.ItemData(CmbBases.NewIndex) = Datos(1)
   Loop
End Sub

Private Sub CargarTipoTasa()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, "CTT"
   If Not Bac_Sql_Execute("SP_MNT_CONVENCION_AJUSTE_INTERES", Envia) Then
      Exit Sub
   End If
   CmbTipotasa.Clear
   Do While Bac_SQL_Fetch(Datos())
      CmbTipotasa.AddItem Datos(2)
      CmbTipotasa.ItemData(CmbTipotasa.NewIndex) = Datos(1)
   Loop
End Sub

Private Sub CmbTipotasa_Click()
   Dim iTipoTasa  As Integer
   
   Toolbar1.Buttons(2).Enabled = False
   iTipoTasa = IIf(CmbTipotasa.ListIndex = -1, -1, CmbTipotasa.ItemData(CmbTipotasa.ListIndex))
   If iTipoTasa = -1 Then
      Exit Sub
   End If
   Call LeerRegistros(iTipoTasa)
   Toolbar1.Buttons(2).Enabled = True
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   Me.Top = 0: Me.Left = 0
   
   Call CargarTipoTasa
   Call NombresGrilla
   Call CargaBases
End Sub

Private Sub LeerRegistros(TipoTasa As Integer)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, "CON"
   AddParam Envia, CDbl(TipoTasa)
   If Not Bac_Sql_Execute("SP_MNT_CONVENCION_AJUSTE_INTERES", Envia) Then
      Exit Sub
   End If
   Grid.Rows = 2
   Do While Bac_SQL_Fetch(Datos())
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, 0) = Datos(1)
      Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(2)
      Grid.TextMatrix(Grid.Rows - 1, 2) = Format(Datos(3), TipoFormato("USD"))
      Grid.TextMatrix(Grid.Rows - 1, 3) = Format(Datos(4), TipoFormato("USD"))
   Loop

End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 1 Then
         Call Alineacion(Grid, CmbBases)
         CmbBases.Visible = True
         Grid.Enabled = False
         On Error Resume Next
         CmbBases.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         On Error GoTo 0
         CmbBases.SetFocus
      End If
      If Grid.ColSel = 2 Or Grid.ColSel = 3 Then
         Call Alineacion(Grid, TxtNum)
         TxtNum.Visible = True
         TxtNum.Text = CDbl(Grid.TextMatrix(Grid.RowSel, Grid.ColSel))
         Grid.Enabled = False
         TxtNum.SetFocus
      End If
   End If

   If KeyCode = vbKeyDelete Then
      If Grid.Rows <= 3 Then
         Grid.Rows = 2
         Grid.Rows = 3
      Else
         Grid.RemoveItem (Grid.RowSel)
      End If
   End If

   If KeyCode = vbKeyInsert Then
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, 0) = -1
      Grid.TextMatrix(Grid.Rows - 1, 1) = ""
      Grid.TextMatrix(Grid.Rows - 1, 2) = Format(0#, TipoFormato("USD"))
      Grid.TextMatrix(Grid.Rows - 1, 3) = Format(0#, TipoFormato("USD"))
   End If

End Sub

Private Sub CmbBases_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If ValidaIngBase = False Then
         Exit Sub
      End If
      If CmbBases.ListIndex = -1 Then
         Grid.TextMatrix(Grid.RowSel, 0) = -1
         Grid.TextMatrix(Grid.RowSel, 1) = ""
      Else
         Grid.TextMatrix(Grid.RowSel, 0) = CmbBases.ItemData(CmbBases.ListIndex)
         Grid.TextMatrix(Grid.RowSel, 1) = CmbBases.List(CmbBases.ListIndex)
      End If
      Grid.Enabled = True
      CmbBases.Visible = False
      Grid.SetFocus
   End If
   
   If KeyCode = vbKeyEscape Then
      Grid.Enabled = True
      CmbBases.Visible = False
      Grid.SetFocus
   End If
End Sub


Private Sub Alineacion(nGrid As MSFlexGrid, nText As Object)
    On Error Resume Next
    nText.Top = nGrid.Top + nGrid.CellTop + 10
    nText.Left = nGrid.Left + nGrid.CellLeft + 50
    nText.Width = nGrid.CellWidth - 10
    nText.Height = nGrid.CellHeight - 10

    nText.Text = nGrid.TextMatrix(nGrid.RowSel, nGrid.ColSel)
    nText.SelStart = Len(nText.Text)
    nText.Visible = True
    nGrid.Enabled = False

    nText.SetFocus
    On Error GoTo 0
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
      Case 2
         Call Grabar
      Case 3
         Unload Me
   End Select
End Sub

Private Sub TxtNum_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Format(TxtNum.Text, TipoFormato("USD"))
      Grid.Enabled = True
      TxtNum.Visible = False
      Grid.SetFocus
   End If
   If KeyCode = vbKeyEscape Then
      Grid.Enabled = True
      TxtNum.Visible = False
      Grid.SetFocus
   End If
End Sub

Private Function ValidaIngBase() As Boolean
   Dim iContador  As Integer
   Dim iBase      As Integer
   
   ValidaIngBase = False
   
   If CmbBases.ListIndex = -1 Then
      Exit Function
   End If
   iBase = CmbBases.ItemData(CmbBases.ListIndex)
   For iContador = 2 To Grid.Rows - 1
      If iContador <> Grid.RowSel And Grid.TextMatrix(iContador, 0) = iBase Then
         MsgBox "El item seleccionado, ya se encuentra asignado.", vbExclamation, TITSISTEMA
         Exit Function
      End If
   Next iContador
   
   ValidaIngBase = True
End Function


Private Sub Grabar()
   On Error GoTo ErrorGrb
   Dim iContador  As Integer
   Dim Datos()

   If Grid.Enabled = False Then
      Exit Sub
   End If
   If CmbTipotasa.ListIndex = -1 Then
      Exit Sub
   End If

   Call BacBeginTransaction
   
   Envia = Array()
   AddParam Envia, "DEL"
   AddParam Envia, CmbTipotasa.ItemData(CmbTipotasa.ListIndex)
   If Not Bac_Sql_Execute("SP_MNT_CONVENCION_AJUSTE_INTERES", Envia) Then
      GoTo ErrorGrb
   End If

   For iContador = 2 To Grid.Rows - 1
      Envia = Array()
      AddParam Envia, "GRB"
      AddParam Envia, CmbTipotasa.ItemData(CmbTipotasa.ListIndex)
      AddParam Envia, CmbTipotasa.List(CmbTipotasa.ListIndex)
      AddParam Envia, CDbl(Grid.TextMatrix(iContador, 0))
      AddParam Envia, CDbl(Grid.TextMatrix(iContador, 2))
      AddParam Envia, CDbl(Grid.TextMatrix(iContador, 3))
      AddParam Envia, Trim(Grid.TextMatrix(iContador, 1))
      If Not Bac_Sql_Execute("SP_MNT_CONVENCION_AJUSTE_INTERES", Envia) Then
         GoTo ErrorGrb
      End If
   Next iContador

   Call BacCommitTransaction
   
   MsgBox "Actualización ha finaliado en forma correcta", vbInformation, TITSISTEMA
Exit Sub
ErrorGrb:
   Call BacRollBackTransaction
   MsgBox "Actualización ha fallado.", vbExclamation, TITSISTEMA
End Sub
