VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "baccontroles.ocx"
Begin VB.Form FRM_MNT_REFTC_SISTEMA_PRODUCTO 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Referencia de Mercado por Sistema - Producto."
   ClientHeight    =   5895
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   5940
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5895
   ScaleWidth      =   5940
   Begin VB.Frame Frame2 
      Height          =   3825
      Left            =   30
      TabIndex        =   8
      Top             =   2040
      Width           =   5835
      Begin VB.TextBox TxtTextGrid 
         BackColor       =   &H80000003&
         BorderStyle     =   0  'None
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
         Height          =   195
         Left            =   1425
         TabIndex        =   12
         Top             =   1170
         Visible         =   0   'False
         Width           =   870
      End
      Begin VB.ComboBox cmbReferencia 
         BackColor       =   &H80000003&
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   315
         Left            =   1470
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   1485
         Visible         =   0   'False
         Width           =   1050
      End
      Begin VB.ComboBox cmbSiNo 
         BackColor       =   &H80000003&
         ForeColor       =   &H80000009&
         Height          =   315
         ItemData        =   "FRM_MNT_REFTC_SISTEMA_PRODUCTO.frx":0000
         Left            =   1470
         List            =   "FRM_MNT_REFTC_SISTEMA_PRODUCTO.frx":0002
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   1860
         Visible         =   0   'False
         Width           =   885
      End
      Begin BACControles.TXTNumero TxtNumGrid 
         Height          =   195
         Left            =   2370
         TabIndex        =   11
         Top             =   1170
         Visible         =   0   'False
         Width           =   885
         _ExtentX        =   1561
         _ExtentY        =   344
         BackColor       =   -2147483645
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
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   3630
         Left            =   0
         TabIndex        =   4
         Top             =   120
         Width           =   5775
         _ExtentX        =   10186
         _ExtentY        =   6403
         _Version        =   393216
         Cols            =   4
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
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
   Begin VB.Frame Frame1 
      Height          =   1455
      Left            =   30
      TabIndex        =   5
      Top             =   510
      Width           =   5865
      Begin VB.ComboBox cmbSistemas 
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
         ItemData        =   "FRM_MNT_REFTC_SISTEMA_PRODUCTO.frx":0004
         Left            =   1245
         List            =   "FRM_MNT_REFTC_SISTEMA_PRODUCTO.frx":0006
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   300
         Width           =   2790
      End
      Begin VB.ComboBox cmbProducto 
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
         Left            =   1230
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   660
         Width           =   4350
      End
      Begin VB.ComboBox CmbModalidad 
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
         Left            =   1230
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   1050
         Width           =   4365
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Sistema"
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
         Left            =   180
         TabIndex        =   13
         Top             =   360
         Width           =   690
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Producto"
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
         Left            =   165
         TabIndex        =   7
         Top             =   720
         Width           =   765
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Modalidad"
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
         Left            =   165
         TabIndex        =   6
         Top             =   1065
         Width           =   870
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   5940
      _ExtentX        =   10478
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4545
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_REFTC_SISTEMA_PRODUCTO.frx":0008
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_REFTC_SISTEMA_PRODUCTO.frx":0EE2
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_REFTC_SISTEMA_PRODUCTO.frx":11FC
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MNT_REFTC_SISTEMA_PRODUCTO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Function SettingGrid()
   Let Grid.Rows = 2:      Let Grid.Cols = 4
   Let Grid.FixedRows = 1: Let Grid.FixedCols = 0
   Let Grid.RowHeightMin = 315
   
   Let Grid.TextMatrix(0, 0) = "Referencia": Let Grid.ColWidth(0) = 3000
   Let Grid.TextMatrix(0, 1) = "Dias Valor": Let Grid.ColWidth(1) = 1000
   Let Grid.TextMatrix(0, 2) = "  Cod.Ref":    Let Grid.ColWidth(2) = 0
   Grid.TextMatrix(0, 3) = "Tipo Cambio":    Let Grid.ColWidth(3) = 1000
   Let Grid.Enabled = False
End Function
Private Sub CmbModalidad_KeyPress(KeyAscii As Integer)
    Call LoadRefProducto
    Call gKeyPress(KeyAscii)
End Sub
Private Sub cmbProducto_Click()
  ' Call LoadRefProducto
End Sub
Private Sub cmbProducto_KeyPress(KeyAscii As Integer)
    Call gKeyPress(KeyAscii)
End Sub
Private Sub cmbSiNo_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then

      Let Toolbar1.Enabled = True
      Let Grid.Enabled = True
      Call Grid.SetFocus
      'Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = cmbSiNo.List(cmbSiNo.ListIndex)
      'Let Grid.TextMatrix(Grid.RowSel, 3) = IIf(cmbSiNo.ItemData(cmbSiNo.ListIndex) = 0, "Si", "No")
      Let Grid.TextMatrix(Grid.RowSel, 3) = IIf(cmbSiNo.ListIndex = 0, "Si", "No")
      Let cmbSiNo.Visible = False

   End If

   If KeyCode = vbKeyEscape Then
      Let Toolbar1.Enabled = True
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let cmbSiNo.Visible = False

   End If
End Sub

Private Sub cmbSiNo_LostFocus()
    Let Toolbar1.Enabled = True
    Let Grid.Enabled = True
    Call Grid.SetFocus
    Let cmbSiNo.Visible = False
End Sub
Private Sub AsignaTipoCambio()
    Let Toolbar1.Enabled = True
    Let Grid.Enabled = True
    Call Grid.SetFocus
    Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = cmbSiNo.List(cmbSiNo.ListIndex)
    Let Grid.TextMatrix(Grid.RowSel, 3) = IIf(cmbSiNo.ItemData(cmbSiNo.ListIndex) = 0, "Si", "No")
    Let cmbSiNo.Visible = False
End Sub

Private Sub cmbSistemas_Click()
 Call CargaProductosSistema
End Sub
Private Sub cmbSistemas_KeyPress(KeyAscii As Integer)
    Call gKeyPress(KeyAscii)
End Sub
Private Sub CargaProductosSistema()
    Dim Linea As String
    Envia = Array()
    AddParam Envia, Trim(Right(cmbSistemas.Text, 10))
    
    Dim Datos()
    If Not Bac_Sql_Execute("[BacParamSuda].[dbo].SP_LEER_TABLA_PRODUCTOS_SISTEMAS_CONTROL", Envia) Then
        Exit Sub
    End If
    cmbProducto.Clear
    Do While Bac_SQL_Fetch(Datos())
        Linea = Datos(4) & Space(100) & Datos(3)
        cmbProducto.AddItem (Linea)
    Loop
End Sub

Private Sub cmdBuscar_Click()
    Call LoadRefProducto
'    Call gKeyPress(13)
End Sub

Private Sub Form_Load()
   'Let Me.Icon = BacParametros.Icon *************ELIMINADO 27-03-2015, PORQUE CARGA EL MANTENEDOR   ************
   
   Me.Icon = BACSwapParametros.Icon
   Let Me.Top = 0: Let Me.Left = 0
   
   'Llena combo Sistemas
   Call CargaSistema(cmbSistemas)
   'Seteo Grilla
   Call SettingGrid
   ' cargo combo con los productos
   Call Load_Producto
   'cargo combo con las modalidades existentes
   Call Load_Modalidad
   cmbSistemas.ListIndex = -1
   cmbSiNo.AddItem ("Si")
   cmbSiNo.AddItem ("No")
   
   
   
End Sub
Private Sub CargaSistema(objCarga As Object)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, "S"
   If Not Bac_Sql_Execute("BacSwapSuda.dbo.SP_MNT_MONEDA_PAGO_POR_MONEDA", Envia) Then
      Exit Sub
   End If
   objCarga.Clear
   Do While Bac_SQL_Fetch(Datos())
      objCarga.AddItem Datos(2) & Space(50) & Datos(1)
   Loop
End Sub
Private Function Load_Producto()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(0)
   If Not Bac_Sql_Execute("BacParamsuda.dbo.SP_MNT_REFERENCIA_MERCADO_PRODUCTO", Envia) Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha originado un error en la lectura de productos.", vbExclamation, App.Title)
      Exit Function
   End If
   Call cmbProducto.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call cmbProducto.AddItem(Datos(2))
       Let cmbProducto.ItemData(cmbProducto.NewIndex) = Datos(1)
   Loop
End Function
Private Function Load_Referencias()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(1)
   If Not Bac_Sql_Execute("BacParamsuda.dbo.SP_MNT_REFERENCIA_MERCADO_PRODUCTO", Envia) Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha originado un error en la lectura de referencias de mercado.", vbExclamation, App.Title)
      Exit Function
   End If
   Call cmbReferencia.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call cmbReferencia.AddItem(Datos(2))
       Let cmbReferencia.ItemData(cmbReferencia.NewIndex) = Datos(1)
   Loop
   Let cmbReferencia.ListIndex = 0
End Function
Private Function Load_Modalidad()
   Call CmbModalidad.Clear
   Call CmbModalidad.AddItem("COMPENSACION")
   Call CmbModalidad.AddItem("ENTREGA FISICA")
End Function
Private Function LoadRefProducto()
    Dim Datos()
    Dim nProducto  As String
    Dim cModalidad As String
    If cmbSistemas.ListIndex < 0 Or cmbProducto.ListIndex < 0 Or CmbModalidad.ListIndex < 0 Then
       Exit Function
    End If
    
    Let cModalidad = Mid(CmbModalidad.List(CmbModalidad.ListIndex), 1, 1)
    Envia = Array()
    AddParam Envia, CDbl(0)
    AddParam Envia, Trim(Right(cmbSistemas.Text, 10))
    AddParam Envia, CInt(Trim(Right(cmbProducto.Text, 10)))
    AddParam Envia, cModalidad
    
    If Not Bac_Sql_Execute("BacParamsuda.dbo.SP_MNT_REFERENCIA_MERCADO_SISTEMA_PRODUCTO", Envia) Then
       Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha originado un error en la lectura de productos.", vbExclamation, App.Title)
       Exit Function
    End If
    Let Grid.Rows = 1
    Do While Bac_SQL_Fetch(Datos())
       Let Grid.Rows = Grid.Rows + 1
       Let Grid.TextMatrix(Grid.Rows - 1, 0) = Datos(2)
       Let Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(3)
       Let Grid.TextMatrix(Grid.Rows - 1, 2) = Datos(1)
       Let Grid.TextMatrix(Grid.Rows - 1, 3) = Datos(3)
       Let Grid.TextMatrix(Grid.Rows - 1, 3) = IIf(Datos(4) = 1, "Si", "No")
    Loop
'    Grid.ColWidth(3) = 0
'     If nProducto = 12 Then
'         Grid.ColWidth(3) = 1020
'         Grid.ColAlignment(3) = flexAlignCenterCenter
'     End If
    
    CmbModalidad.SetFocus
    Let Grid.Enabled = True
   ' Call Grid.SetFocus
End Function
Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      
      If Grid.ColSel = 0 Then
         Call Load_Referencias
         Call PosTexto(Grid, cmbReferencia)
         Let cmbReferencia.Visible = True
         Call cmbReferencia.SetFocus

         Let Grid.Enabled = False
         Let Toolbar1.Enabled = False
      End If
      
      If Grid.ColSel = 1 Then
         Call PosTexto(Grid, TxtNumGrid)
         Let TxtNumGrid.Text = 0 '--> Val(Grid.TextMatrix(Grid.RowSel, Grid.ColSel))
         Let TxtNumGrid.Visible = True
         Call TxtNumGrid.SetFocus

         Let TxtNumGrid.SelStart = 0
         Let Grid.Enabled = False
         Let Toolbar1.Enabled = False
      End If
        If Grid.ColSel = 3 Then
            cmbSiNo.ListIndex = IIf(Grid.TextMatrix(Grid.Row, 3) = "Si", 0, 1)
            
            Call PosTexto(Grid, cmbSiNo)
            Let cmbSiNo.Visible = True
            Call cmbSiNo.SetFocus
            
            Let Grid.Enabled = False
            Let Toolbar1.Enabled = False
        End If
      
   End If
   
   If KeyCode = vbKeyInsert Then
      Let Grid.Rows = Grid.Rows + 1
      Grid.Row = Grid.Rows - 1
      Grid.Col = 0
   End If

   If KeyCode = vbKeyDelete Then
      If Grid.Rows <= 2 Then
         Let Grid.Rows = 1
      Else
         Call Grid.RemoveItem(Grid.RowSel)
      End If
   End If
End Sub
Private Sub PosTexto(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next
   Let Objeto.Top = Marco.CellTop + Marco.Top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth
   On Error GoTo 0
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call SaveData
      Case 2
         Call Unload(Me)
      Case 3
         Call LoadRefProducto
   End Select
End Sub
Private Sub TxtNumGrid_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      Let KeyAscii = 0

      Let Toolbar1.Enabled = True
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = TxtNumGrid.Text
      Let TxtNumGrid.Visible = False
   End If

   If KeyAscii = vbKeyEscape Then
      Let KeyAscii = 0

      Let Toolbar1.Enabled = True
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let TxtNumGrid.Visible = False
   End If
End Sub
Private Sub cmbReferencia_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then

      If CheckReference = False Then
         Exit Sub
      End If

      Let Toolbar1.Enabled = True
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = cmbReferencia.List(cmbReferencia.ListIndex)
      Let Grid.TextMatrix(Grid.RowSel, 2) = cmbReferencia.ItemData(cmbReferencia.ListIndex)
      Let cmbReferencia.Visible = False
      cmbSiNo.Visible = False
   End If

   If KeyCode = vbKeyEscape Then
      Let Toolbar1.Enabled = True
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let cmbReferencia.Visible = False
      cmbSiNo.Visible = False
   End If
End Sub
Private Function SaveData()
   Dim nContador  As Long
   Dim tArray() As String
   Dim cadena As String
   Dim car As String
   
   
   If cmbSistemas.ListIndex < 0 Or cmbProducto.ListIndex < 0 Or CmbModalidad.ListIndex < 0 Then
      Call MsgBox("Validación. " & vbCrLf & "Debe seleccionar un sistema, producto y la modalidad de pago.", vbInformation, App.Title)
      Exit Function
   End If
   
   If Not BacBeginTransaction Then
      Exit Function
   End If
   
   Envia = Array()
   AddParam Envia, CDbl(3)
   AddParam Envia, Trim(Right(cmbSistemas.Text, 10))
   AddParam Envia, CInt(Trim(Right(cmbProducto.Text, 10)))
   AddParam Envia, UCase(Trim(Mid(CmbModalidad.List(CmbModalidad.ListIndex), 1, 1)))
   If Not Bac_Sql_Execute("BacParamsuda.dbo.SP_MNT_REFERENCIA_MERCADO_SISTEMA_PRODUCTO", Envia) Then
      Call BacRollBackTransaction
      Call MsgBox("Error en Actualizacion de referencias de mercado.", vbExclamation, App.Title)
     'Exit Function
   End If

   For nContador = Grid.FixedRows To Grid.Rows - 1

        
         Envia = Array()
         AddParam Envia, CDbl(4)
         AddParam Envia, Trim(Right(cmbSistemas.Text, 10))
         AddParam Envia, CInt(Trim(Right(cmbProducto.Text, 10)))
         AddParam Envia, UCase(Trim(Mid(CmbModalidad.List(CmbModalidad.ListIndex), 1, 1)))
         AddParam Envia, Val(Grid.TextMatrix(nContador, 2))
         AddParam Envia, Val(Grid.TextMatrix(nContador, 1))
         AddParam Envia, Val(IIf(Grid.TextMatrix(nContador, 3) = "Si", 1, 0))

        'car = (Right(Grid.TextMatrix(nContador, 0), 1))
         'If (car Like "[0-9]") Then
            'AddParam Envia, RTrim(Mid(Grid.TextMatrix(nContador, 0), 1, Len(Grid.TextMatrix(nContador, 0)) - 3)) & " T" & Val(Grid.TextMatrix(nContador, 1))
            'Else
            'AddParam Envia, Grid.TextMatrix(nContador, 0) & " T" & Val(Grid.TextMatrix(nContador, 1))
        'End If
        If Not Bac_Sql_Execute("BacParamsuda.dbo.SP_MNT_REFERENCIA_MERCADO_SISTEMA_PRODUCTO", Envia) Then
            Call BacRollBackTransaction
            Call MsgBox("Error en Actualizacion de referencias de mercado.", vbExclamation, App.Title)
            Exit Function
         End If
     ' End If
      'End If
      Next nContador
   
   
   If Not BacCommitTransaction Then
      Exit Function
   End If
   
   Call MsgBox("Actualizacion de referencias de mercado, se ha completado exitosamente.", vbInformation, App.Title)
   Call LoadRefProducto
End Function
Private Function CheckReference() As Boolean
   Dim nContador  As Long
   Dim iIndice    As Long
   
   Let CheckReference = False
   Let iIndice = cmbReferencia.ItemData(cmbReferencia.ListIndex)
   
   For nContador = Grid.FixedRows To Grid.Rows - 1
      If Val(Grid.TextMatrix(nContador, 2)) = iIndice Then
         Call MsgBox("Validación. " & vbCrLf & "Referencia seleccionado se encuentra agregada para el Producto y la Modalidad.", vbExclamation, App.Title)
         Exit Function
      End If
   Next nContador
   Let CheckReference = True
End Function
Private Sub gKeyPress(intAscii As Integer)
    'intAscii = codigo númerico de la tecla presionada
    If intAscii = 13 Then           'detecta si la tecla presionada es Enter
        intAscii = 0                'para luego aceptar el ingreso
        SendKeys "{TAB}"
    End If
End Sub
