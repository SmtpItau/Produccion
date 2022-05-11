VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_CODIGO_DCV 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Asignación de Codigos DCV a Clientes."
   ClientHeight    =   6855
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7800
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6855
   ScaleWidth      =   7800
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7800
      _ExtentX        =   13758
      _ExtentY        =   794
      ButtonWidth     =   2117
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      DisabledImageList=   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Actualizar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Volver"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   6390
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CODIGO_DCV.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CODIGO_DCV.frx":0EDA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   795
      Left            =   30
      TabIndex        =   1
      Top             =   390
      Width           =   7740
      Begin VB.TextBox TXTCliente 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   3570
         TabIndex        =   6
         Top             =   390
         Width           =   4095
      End
      Begin VB.ComboBox cmbTipoCliente 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   60
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   390
         Width           =   3495
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Nombre de Cliente"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   3570
         TabIndex        =   5
         Top             =   180
         Width           =   1320
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Tipo de Clientes"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   75
         TabIndex        =   3
         Top             =   165
         Width           =   1140
      End
   End
   Begin VB.Frame Frame2 
      Height          =   5700
      Left            =   30
      TabIndex        =   2
      Top             =   1110
      Width           =   7740
      Begin BACControles.TXTNumero TXTIngreso 
         Height          =   195
         Left            =   2040
         TabIndex        =   8
         Top             =   465
         Visible         =   0   'False
         Width           =   915
         _ExtentX        =   1614
         _ExtentY        =   344
         BackColor       =   -2147483646
         ForeColor       =   -2147483639
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Appearance      =   0
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   5505
         Left            =   30
         TabIndex        =   7
         Top             =   135
         Width           =   7665
         _ExtentX        =   13520
         _ExtentY        =   9710
         _Version        =   393216
         Cols            =   4
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483640
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
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
End
Attribute VB_Name = "FRM_MNT_CODIGO_DCV"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Function SettingGrid()
   Let Grid.Rows = 2:         Let Grid.Cols = 5
   Let Grid.FixedRows = 1:    Let Grid.FixedCols = 0

   Let Grid.AllowUserResizing = flexResizeColumns

   Let Grid.TextMatrix(0, 0) = "Rut Cliente":         Let Grid.ColWidth(0) = 1100:     Let Grid.ColAlignment(0) = flexAlignRightCenter
   Let Grid.TextMatrix(0, 1) = "Cod Cliente":         Let Grid.ColWidth(1) = 1000:     Let Grid.ColAlignment(1) = flexAlignRightCenter
   Let Grid.TextMatrix(0, 2) = "Nombre Cliente":      Let Grid.ColWidth(2) = 4200:     Let Grid.ColAlignment(2) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, 3) = "DCV":                 Let Grid.ColWidth(3) = 1000:     Let Grid.ColAlignment(3) = flexAlignRightCenter
   Let Grid.TextMatrix(0, 4) = "MARCA":               Let Grid.ColWidth(4) = 0:        Let Grid.ColAlignment(4) = flexAlignLeftCenter

   Let Grid.RowHeightMin = 300

End Function

Private Sub cmbTipoCliente_Click()
   Call CargarClientes
End Sub

Private Sub Form_Load()
   Let Me.Icon = BACSwapParametros.Icon
   Call SettingGrid
   Call CargarTipoCliente
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2:  Call FuncActualizacion
      Case 3:  Call Unload(Me)
   End Select
End Sub

Private Sub TXTCliente_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call CargarClientes
   End If
End Sub

Private Sub TXTCliente_KeyPress(KeyAscii As Integer)
   Let KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Function CargarTipoCliente()
   Dim Sqldatos()

   Envia = Array()
   AddParam Envia, CDbl(0) '-->  CARGA DE TIPOS DE CLIENTES
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, ""
   If Not Bac_Sql_Execute("dbo.SP_MNT_TBL_CODIGO_CLIENTE_DCV", Envia) Then
      Exit Function
   End If

   Call cmbTipoCliente.Clear
   Call cmbTipoCliente.AddItem("TODOS")
    Let cmbTipoCliente.ItemData(cmbTipoCliente.NewIndex) = 0

   Do While Bac_SQL_Fetch(Sqldatos())
      Call cmbTipoCliente.AddItem(Sqldatos(2))
       Let cmbTipoCliente.ItemData(cmbTipoCliente.NewIndex) = Sqldatos(1)
   Loop
   
End Function

Private Function CargarClientes()
   Dim MiTipoCliente    As Integer
   Dim MiNombreCliente  As String
   Dim Sqldatos()

   Let Screen.MousePointer = vbHourglass

   Let MiTipoCliente = 0
   If cmbTipoCliente.ListCount > 0 And cmbTipoCliente.ListIndex >= 0 Then
      Let MiTipoCliente = cmbTipoCliente.ItemData(cmbTipoCliente.ListIndex)
   End If

   Let MiNombreCliente = TXTCliente.Text

   Envia = Array()
   AddParam Envia, CDbl(1)          '--> CARGA DE CLIENTES
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, MiTipoCliente    '-->  FILTROS
   AddParam Envia, MiNombreCliente  '-->  FILTROS
   If Not Bac_Sql_Execute("dbo.SP_MNT_TBL_CODIGO_CLIENTE_DCV", Envia) Then
      Exit Function
   End If

   Let Grid.Rows = 1

   Do While Bac_SQL_Fetch(Sqldatos())
      Let Grid.Rows = Grid.Rows + 1

      Let Grid.TextMatrix(Grid.Rows - 1, 0) = Sqldatos(1)
      Let Grid.TextMatrix(Grid.Rows - 1, 1) = Sqldatos(2)
      Let Grid.TextMatrix(Grid.Rows - 1, 2) = Sqldatos(3)
      Let Grid.TextMatrix(Grid.Rows - 1, 3) = Sqldatos(4)
      Let Grid.TextMatrix(Grid.Rows - 1, 4) = ""
   Loop

   Let Screen.MousePointer = vbDefault
End Function

Private Function FuncActualizacion()
   Dim Sqldatos()
   Dim nContador     As Long
   Dim MiRutcliente  As Long
   Dim MiCodCliente  As Long
   Dim MiCodDCV      As Long

   For nContador = 1 To Grid.Rows - 1
      If Grid.TextMatrix(nContador, 4) = "M" Then

         Let MiRutcliente = Grid.TextMatrix(nContador, 0)
         Let MiCodCliente = Grid.TextMatrix(nContador, 1)
             Let MiCodDCV = Grid.TextMatrix(nContador, 3)

         Envia = Array()
         AddParam Envia, CDbl(2)          '--> CARGA DE CLIENTES
         AddParam Envia, CDbl(MiRutcliente)
         AddParam Envia, CDbl(MiCodCliente)
         AddParam Envia, CDbl(MiCodDCV)
         AddParam Envia, CDbl(0)
         AddParam Envia, ""
         If Not Bac_Sql_Execute("dbo.SP_MNT_TBL_CODIGO_CLIENTE_DCV", Envia) Then
            Exit Function
         End If

      End If
   Next nContador

   Call MsgBox("Se han actualizado correctamente los registros modificados.", vbInformation, App.Title)
End Function

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 3 Then
         Call FuncSettingTexto(Grid, TXTIngreso)
         Let TXTIngreso.Enabled = True: Let TXTIngreso.Visible = True
         Let TXTIngreso.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         
         If TXTIngreso.Text < 0 Then
            Let TXTIngreso.Text = ""
         End If
         
         Call TXTIngreso.SetFocus
         Let Grid.Enabled = False
      End If
   End If
End Sub

Private Sub TXTIngreso_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = TXTIngreso.Text
      Let Grid.TextMatrix(Grid.RowSel, 4) = "M"
      Let Grid.Enabled = True
      Let TXTIngreso.Visible = False
      Call Grid.SetFocus
   End If
   If KeyCode = vbKeyEscape Then
      Let Grid.Enabled = True
      Let TXTIngreso.Visible = False
      Call Grid.SetFocus
   End If
End Sub

Private Function FuncSettingTexto(ByRef Grilla As Object, ByRef Texto As Object)
   On Error Resume Next
   Const PosDefecto = 20
   
      Let Texto.Top = Grilla.CellTop + Grilla.Top + PosDefecto
     Let Texto.Left = Grilla.CellLeft + Grilla.Left + PosDefecto
    Let Texto.Width = Grilla.CellWidth - PosDefecto
   Let Texto.Height = Grilla.CellHeight

   Let Texto.BackColor = vbBlue
   Let Texto.ForeColor = vbWhite
   
   On Error GoTo 0
End Function

