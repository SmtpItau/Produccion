VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_FACTORVCTORES 
   Caption         =   "Mantención de Factores por Producto."
   ClientHeight    =   4830
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7080
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   4830
   ScaleWidth      =   7080
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   720
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7080
      _ExtentX        =   12488
      _ExtentY        =   1270
      ButtonWidth     =   1323
      ButtonHeight    =   1111
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Buscar"
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Grabar"
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Eliminar"
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Cerrar"
            Key             =   "Cerrar"
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3585
         Top             =   60
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
               Picture         =   "FRM_MNT_FACTORVCTORES.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_FACTORVCTORES.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_FACTORVCTORES.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_FACTORVCTORES.frx":20CE
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1305
      Left            =   30
      TabIndex        =   1
      Top             =   645
      Width           =   7035
      Begin VB.ComboBox cmbProducto 
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
         Left            =   150
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   885
         Width           =   5685
      End
      Begin VB.ComboBox cmbSistema 
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
         Left            =   150
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   345
         Width           =   5685
      End
      Begin VB.Label Label1 
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
         Index           =   1
         Left            =   150
         TabIndex        =   4
         Top             =   690
         Width           =   765
      End
      Begin VB.Label Label1 
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
         Index           =   0
         Left            =   150
         TabIndex        =   2
         Top             =   135
         Width           =   690
      End
   End
   Begin VB.Frame Frame2 
      Height          =   2955
      Left            =   30
      TabIndex        =   6
      Top             =   1860
      Width           =   7035
      Begin BACControles.TXTNumero TxtIngreso 
         Height          =   195
         Left            =   1125
         TabIndex        =   8
         Top             =   465
         Visible         =   0   'False
         Width           =   885
         _ExtentX        =   1561
         _ExtentY        =   344
         BackColor       =   -2147483646
         ForeColor       =   -2147483639
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
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   2775
         Left            =   60
         TabIndex        =   7
         Top             =   135
         Width           =   6915
         _ExtentX        =   12197
         _ExtentY        =   4895
         _Version        =   393216
         Cols            =   4
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483638
         GridColorFixed  =   -2147483642
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
Attribute VB_Name = "FRM_MNT_FACTORVCTORES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Enum MisEventos
   [Sistemas] = 0
   [Productos] = 1
   [Consulta] = 2
   [Eliminar] = 3
   [Grabar] = 4
End Enum

Private Sub NombresGrilla()
   Grid.TextMatrix(0, 0) = "Pazo Desde": Grid.ColWidth(0) = 1500
   Grid.TextMatrix(0, 1) = "Pazo Hasta": Grid.ColWidth(1) = 1500
   Grid.TextMatrix(0, 2) = "Factor 1":   Grid.ColWidth(2) = 1500
   Grid.TextMatrix(0, 3) = "Factor 2":   Grid.ColWidth(3) = 1500
   Grid.RowHeightMin = 315
End Sub

Private Sub cmbProducto_Click()
   Call ConsultaFactores(Right(cmbSistema.Text, 3), Trim(Right(cmbProducto.Text, 5)))
End Sub

Private Sub cmbSistema_Click()
   Call CargarProductos(Right(cmbSistema.Text, 3))
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwapParametros.Icon
   Me.Top = 0: Me.Left = 0
   
   Call NombresGrilla
   Call CargarSistemas
End Sub

Private Sub Form_Resize()
   On Error GoTo ErrorResize
   Frame1.Width = Me.Width - 150
   Frame2.Width = Me.Width - 150
   Grid.Width = Frame2.Width - 200
   Frame2.Height = (Me.Height - Frame1.Height) - 1000
   Grid.Height = (Me.Height - Frame1.Height) - 1200
Exit Sub
ErrorResize:
   On Error GoTo 0
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If cmbSistema.Text = "" Or Me.cmbProducto.Text = "" Then
         Exit Sub
      End If
      If Grid.ColSel = 0 Then TxtIngreso.CantidadDecimales = 0
      If Grid.ColSel = 1 Then TxtIngreso.CantidadDecimales = 0
      If Grid.ColSel = 2 Then TxtIngreso.CantidadDecimales = 4
      If Grid.ColSel = 3 Then TxtIngreso.CantidadDecimales = 4
      Call CtrlObj_Alinear(Grid, TxtIngreso)
   End If
   If KeyCode = vbKeyInsert Then
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, 0) = Format(CDbl(0#), FEntero)
      Grid.TextMatrix(Grid.Rows - 1, 1) = Format(CDbl(0#), FEntero)
      Grid.TextMatrix(Grid.Rows - 1, 2) = Format(CDbl(0#), FDecimal)
      Grid.TextMatrix(Grid.Rows - 1, 3) = Format(CDbl(0#), FDecimal)
   End If
   If KeyCode = vbKeyDelete Then
      If MsgBox(" ¿ Esta seguro de querer eliminar el registro seleccionado. ? ", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
         Exit Sub
      Else
         If Grid.Rows <= 2 Then
            Grid.Rows = 1
            Grid.Rows = 2
         Else
            Grid.RemoveItem (Grid.RowSel)
         End If
      End If
      Grid.SetFocus
   End If
   

End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Key
      Case "Buscar"
         Call ConsultaFactores(Right(cmbSistema.Text, 3), Trim(Right(cmbProducto.Text, 5)))
      Case "Grabar"
         Call GrabarFactores
      Case "Eliminar"
         Call EliminarFactores
      Case "Cerrar"
         Unload Me
   End Select
End Sub

Private Sub Limpiar()
   cmbSistema.ListIndex = -1
   cmbProducto.ListIndex = -1
   Grid.Rows = 1
   Grid.Rows = 2
End Sub

Private Sub EliminarFactores()
   If MsgBox("¿ Esta seguro de querer Eliminar los Registros para el Sistema " & Trim(Left(cmbSistema.Text, 30)) & " producto " & Trim(Left(cmbProducto.Text, 30)) & " ?.", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
      Exit Sub
   End If
   
   Screen.MousePointer = vbHourglass
   Call BacBeginTransaction

   Envia = Array()
   AddParam Envia, MisEventos.Eliminar
   AddParam Envia, Trim(Right(cmbSistema.Text, 3))
   AddParam Envia, Trim(Right(cmbProducto.Text, 5))
   If Not Bac_Sql_Execute("MNT_FACTOR_VENCIMIENTI_RESIDUAL", Envia) Then
      Call BacRollBackTransaction
      Screen.MousePointer = vbDefault
      Exit Sub
   End If
   
   Call BacCommitTransaction
   Screen.MousePointer = vbDefault
   Call Limpiar
   MsgBox "Acción Finalizada." & vbCrLf & vbCrLf & "Los registros han sido eliminados.", vbInformation, TITSISTEMA
End Sub

Private Sub GrabarFactores()
   On Error GoTo ErroSavaData
   Dim iContador  As Integer
   Dim Datos()
   
   If Not BacBeginTransaction Then
      On Error GoTo 0
   End If
   
   Screen.MousePointer = vbHourglass
   
   Envia = Array()
   AddParam Envia, MisEventos.Eliminar
   AddParam Envia, Trim(Right(cmbSistema.Text, 3))
   AddParam Envia, Trim(Right(cmbProducto.Text, 5))
   If Not Bac_Sql_Execute("MNT_FACTOR_VENCIMIENTI_RESIDUAL", Envia) Then
      GoTo ErroSavaData
   End If
   
   For iContador = 1 To Grid.Rows - 1
      Envia = Array()
      AddParam Envia, MisEventos.Grabar
      AddParam Envia, Trim(Right(cmbSistema.Text, 3))
      AddParam Envia, Trim(Right(cmbProducto.Text, 5))
      AddParam Envia, CDbl(Grid.TextMatrix(iContador, 0)) '--> Desde
      AddParam Envia, CDbl(Grid.TextMatrix(iContador, 1)) '--> Hasta
      AddParam Envia, CDbl(Grid.TextMatrix(iContador, 2)) '--> Factor 1
      AddParam Envia, CDbl(Grid.TextMatrix(iContador, 3)) '--> Factor 2
      If Not Bac_Sql_Execute("MNT_FACTOR_VENCIMIENTI_RESIDUAL", Envia) Then
         GoTo ErroSavaData
      End If
   Next iContador
   
   If Not BacCommitTransaction Then
      Screen.MousePointer = vbDefault
      Exit Sub
   End If
   
   Screen.MousePointer = vbDefault
   Call Limpiar
   MsgBox "Acción Finalizada." & vbCrLf & vbCrLf & "Grabación ha finalizdo O.K. ", vbInformation, TITSISTEMA
On Error GoTo 0
Exit Sub
ErroSavaData:
   Screen.MousePointer = vbDefault
   Call BacRollBackTransaction
   MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "Error en la Grabación.", vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub

Private Sub CargarSistemas()
   On Error GoTo ErrorCargaSistemas
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, MisEventos.Sistemas
   If Not Bac_Sql_Execute("MNT_FACTOR_VENCIMIENTI_RESIDUAL", Envia) Then
      GoTo ErrorCargaSistemas
   End If
   cmbSistema.Clear
   Do While Bac_SQL_Fetch(Datos())
      cmbSistema.AddItem Datos(1) & Space(150) & Datos(2)
   Loop
   On Error GoTo 0
Exit Sub
ErrorCargaSistemas:
   MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "Error en la carga de sistemas.", vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub

Private Sub CargarProductos(MiSistema As String)
   On Error GoTo ErrorCargaProducto
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, MisEventos.Productos
   AddParam Envia, MiSistema
   If Not Bac_Sql_Execute("MNT_FACTOR_VENCIMIENTI_RESIDUAL", Envia) Then
      GoTo ErrorCargaProducto
   End If
   cmbProducto.Clear
   Do While Bac_SQL_Fetch(Datos())
      cmbProducto.AddItem Datos(1) & Space(150) & Datos(2)
   Loop
   On Error GoTo 0
Exit Sub
ErrorCargaProducto:
   MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "Error en la carga de productos.", vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub

Private Sub ConsultaFactores(MiSistema As String, MiProducto As String)
   On Error GoTo ErrorCargaFactores
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, MisEventos.Consulta
   AddParam Envia, MiSistema
   AddParam Envia, MiProducto
   If Not Bac_Sql_Execute("MNT_FACTOR_VENCIMIENTI_RESIDUAL", Envia) Then
      GoTo ErrorCargaFactores
   End If
   Grid.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, 0) = CDbl(Datos(1))
      Grid.TextMatrix(Grid.Rows - 1, 1) = CDbl(Datos(2))
      Grid.TextMatrix(Grid.Rows - 1, 2) = Format(CDbl(Datos(3)), FDecimal)
      Grid.TextMatrix(Grid.Rows - 1, 3) = Format(CDbl(Datos(4)), FDecimal)
   Loop
   On Error GoTo 0
Exit Sub
ErrorCargaFactores:
   MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "Error en la consulta.", vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub


Private Sub CtrlObj_Alinear(nGrid As MSFlexGrid, nText As Object)
    On Error Resume Next
    nText.Top = nGrid.Top + nGrid.CellTop + 10
    nText.Left = nGrid.Left + nGrid.CellLeft + 50
    nText.Width = nGrid.CellWidth - 10
    nText.Height = nGrid.CellHeight - 10
    
    nText.Text = nGrid.TextMatrix(nGrid.RowSel, nGrid.ColSel)
    nText.SelStart = Len(nText.Text)
    
    nText.Visible = True
    nText.Enabled = True
    nGrid.Enabled = False
    Toolbar1.Enabled = False
    nText.SetFocus
End Sub

Private Sub CtrlObj_Aceptar(nGrid As MSFlexGrid, oTexto As Object)
   nGrid.TextMatrix(nGrid.RowSel, nGrid.ColSel) = oTexto.Text
   oTexto.Visible = False
   
   nGrid.Enabled = True
   Toolbar1.Enabled = True
   Grid.SetFocus
End Sub

Private Sub CtrlObj_Cancelar(oTexto As Object)
   oTexto.Visible = False
   
   Grid.Enabled = True
   Toolbar1.Enabled = True
   Grid.SetFocus
End Sub

Private Sub TxtIngreso_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call CtrlObj_Aceptar(Grid, TxtIngreso)
   End If
   If KeyCode = vbKeyEscape Then
      Call CtrlObj_Cancelar(TxtIngreso)
   End If
End Sub
