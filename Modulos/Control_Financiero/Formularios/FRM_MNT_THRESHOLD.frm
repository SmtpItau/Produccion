VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_THRESHOLD 
   Caption         =   "Mantenedor de Threshold por Operación"
   ClientHeight    =   7665
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12660
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   7665
   ScaleWidth      =   12660
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   12660
      _ExtentX        =   22331
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
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5580
         Top             =   15
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
               Picture         =   "FRM_MNT_THRESHOLD.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_THRESHOLD.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_THRESHOLD.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_THRESHOLD.frx":2C8E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame SSFrame1 
      Height          =   1395
      Left            =   45
      TabIndex        =   3
      Top             =   375
      Width           =   12570
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
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   375
         Width           =   1695
      End
      Begin VB.ComboBox CmbProducto 
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
         Left            =   1815
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   375
         Width           =   3615
      End
      Begin VB.TextBox txtCliente 
         Alignment       =   1  'Right Justify
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
         Left            =   135
         Locked          =   -1  'True
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   6
         Text            =   "0"
         Top             =   945
         Width           =   1455
      End
      Begin VB.TextBox txtNombre 
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
         Left            =   1935
         Locked          =   -1  'True
         TabIndex        =   5
         Top             =   945
         Width           =   3540
      End
      Begin VB.TextBox txtCodigo 
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
         Left            =   1605
         Locked          =   -1  'True
         TabIndex        =   4
         Top             =   945
         Width           =   300
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Sistema"
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
         Left            =   150
         TabIndex        =   11
         Top             =   180
         Width           =   555
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
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
         Left            =   135
         TabIndex        =   10
         Top             =   750
         Width           =   495
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Producto"
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
         Left            =   1830
         TabIndex        =   9
         Top             =   180
         Width           =   645
      End
   End
   Begin VB.Frame Frame1 
      Height          =   5955
      Left            =   45
      TabIndex        =   1
      Top             =   1680
      Width           =   12600
      Begin VB.ComboBox CmbThreshold 
         BackColor       =   &H80000002&
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
         Height          =   315
         Left            =   9210
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   1410
         Visible         =   0   'False
         Width           =   1875
      End
      Begin BACControles.TXTNumero txtThreshold 
         Height          =   315
         Left            =   8730
         TabIndex        =   12
         Top             =   735
         Visible         =   0   'False
         Width           =   2055
         _ExtentX        =   3625
         _ExtentY        =   556
         BackColor       =   -2147483635
         ForeColor       =   -2147483634
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
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   5775
         Left            =   30
         TabIndex        =   2
         Top             =   135
         Width           =   12540
         _ExtentX        =   22119
         _ExtentY        =   10186
         _Version        =   393216
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
End
Attribute VB_Name = "FRM_MNT_THRESHOLD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Function SeteaGrilla()
   Grilla.Rows = 2:        Grilla.Cols = 12
   Grilla.FixedRows = 1:   Grilla.FixedCols = 0

   Grilla.RowHeightMin = 315

   Grilla.TextMatrix(0, 0) = "Cod Sistema":        Grilla.ColWidth(0) = 0:       Grilla.ColAlignment(0) = flexAlignLeftCenter
   Grilla.TextMatrix(0, 1) = "Módulo":             Grilla.ColWidth(1) = 1000:    Grilla.ColAlignment(1) = flexAlignLeftCenter
   Grilla.TextMatrix(0, 2) = "Cod Producto":       Grilla.ColWidth(2) = 0:       Grilla.ColAlignment(2) = flexAlignLeftCenter
   Grilla.TextMatrix(0, 3) = "Producto":           Grilla.ColWidth(3) = 2700:    Grilla.ColAlignment(3) = flexAlignLeftCenter
   Grilla.TextMatrix(0, 4) = "Rut Cliente":        Grilla.ColWidth(4) = 0:       Grilla.ColAlignment(4) = flexAlignLeftCenter
   Grilla.TextMatrix(0, 5) = "Cod Cliente":        Grilla.ColWidth(5) = 0:       Grilla.ColAlignment(5) = flexAlignLeftCenter
   Grilla.TextMatrix(0, 6) = "Nombre CLiente":     Grilla.ColWidth(6) = 4000:    Grilla.ColAlignment(6) = flexAlignLeftCenter
   Grilla.TextMatrix(0, 7) = "N° Operación":       Grilla.ColWidth(7) = 1000:    Grilla.ColAlignment(7) = flexAlignRightCenter
   Grilla.TextMatrix(0, 8) = "REC":                Grilla.ColWidth(8) = 1900:    Grilla.ColAlignment(8) = flexAlignRightCenter
   Grilla.TextMatrix(0, 9) = "Threshold":          Grilla.ColWidth(9) = 1900:    Grilla.ColAlignment(9) = flexAlignRightCenter
   Grilla.TextMatrix(0, 10) = "Threshold":         Grilla.ColWidth(10) = 0:      Grilla.ColAlignment(10) = flexAlignRightCenter
   Grilla.TextMatrix(0, 11) = "Aplica Threshold":  Grilla.ColWidth(11) = 1500:   Grilla.ColAlignment(11) = flexAlignLeftCenter
End Function

Private Sub CmbProducto_Click()
   Call LlenaGrilla
End Sub

Private Sub cmbSistemas_Click()
   If cmbSistemas.Text = "<< TODOS >>" Then
      CmbProducto.AddItem ("<< TODOS >>")
      CmbProducto.ListIndex = 0
      CmbProducto.Enabled = False
   Else
      CmbProducto.Enabled = True
      Call LlenaComboProducto(CmbProducto, cmbSistemas.Text)
      CmbProducto.ListIndex = 0
   End If
   Call LlenaGrilla
End Sub

Private Sub cmbSistemas_KeyUp(KeyCode As Integer, Shift As Integer)
   If cmbSistemas.Text = "<< TODOS >>" Then
      CmbProducto.AddItem ("<< TODOS >>")
      CmbProducto.ListIndex = 0
      CmbProducto.Enabled = False
   Else
      CmbProducto.Enabled = True
      Call LlenaComboProducto(CmbProducto, cmbSistemas.Text)
      CmbProducto.ListIndex = 0
   End If
End Sub

Private Sub Form_Load()
   Me.top = 0: Me.Left = 0
   Me.Icon = BacControlFinanciero.Icon

   Call SeteaGrilla
   Call LlenaComboSistemas(cmbSistemas)
End Sub

Private Sub Form_Resize()
   On Error Resume Next
   SSFrame1.Width = Me.Width - 200
   Frame1.Width = SSFrame1.Width
   Grilla.Width = Frame1.Width - 100
   
   Frame1.Height = Me.Height - 2200
   Grilla.Height = Frame1.Height - 200
   On Error GoTo 0
End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Grilla.ColSel = 9 Then
         Let txtThreshold.Text = Grilla.TextMatrix(Grilla.RowSel, Grilla.ColSel)
         Call FuncCentrarObjetos(Grilla, txtThreshold)
         Let txtThreshold.Visible = True
         Call BloquearObjetos
         Call txtThreshold.SetFocus
      End If

      If Grilla.ColSel = 11 Then
         Call CmbThreshold.Clear
         Call CmbThreshold.AddItem("SI"):   Call CmbThreshold.AddItem("NO")
          Let CmbThreshold.Text = Grilla.TextMatrix(Grilla.RowSel, Grilla.ColSel)
         Call FuncCentrarObjetos(Grilla, CmbThreshold)
          Let CmbThreshold.Visible = True
         Call CmbThreshold.SetFocus
      End If
   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1  'Buscar
         Call LlenaGrilla
      Case 2  'Limpiar
         Call Limpiar
      Case 3  'Grabar
         Call Grabar
      Case 4  'Salir
         Unload Me
   End Select
End Sub

Private Function Limpiar()
   Call Grilla.Clear
   Grilla.Rows = 1
   
   cmbSistemas.ListIndex = 0
   CmbProducto.ListIndex = 0
   
   txtCliente.Text = "0"
   txtCodigo.Text = ""
   TXTNombre.Text = ""
   txtThreshold.Visible = False
End Function

Private Function Grabar()
   Dim nContador  As Long

   Let Screen.MousePointer = vbHourglass

   Call BacBeginTransaction

   For nContador = 1 To Grilla.Rows - 1
      Envia = Array()
      AddParam Envia, Grilla.TextMatrix(nContador, 0)
      AddParam Envia, Grilla.TextMatrix(nContador, 2)
      AddParam Envia, CDbl(Grilla.TextMatrix(nContador, 4))
      AddParam Envia, CDbl(Grilla.TextMatrix(nContador, 5))
      AddParam Envia, CDbl(Grilla.TextMatrix(nContador, 7))
      AddParam Envia, CDbl(Grilla.TextMatrix(nContador, 9))
      AddParam Envia, Left(Grilla.TextMatrix(nContador, 11), 1)
      If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_ACTUALIZATHRESHOLDAPLICADO", Envia) Then
         Call BacRollBackTransaction
         Let Screen.MousePointer = vbDefault
         Exit Function
      End If

      Call GRABA_LOG_AUDITORIA(" ", Trim(gsBAC_Fecp), gsBac_IP, gsBAC_User, "THRESHOLD", "Opt50011", , "OPERACION N°: " & Sistema & " " & Num, "Bacparamsuda.dbo.TBL_THRESHOLD_OPERACION", Grilla.TextMatrix(nContador, 10), Grilla.TextMatrix(nContador, 9))
   Next nContador

   Call BacCommitTransaction
   Let Screen.MousePointer = vbDefault
   Call MsgBox("Se ha generado la actualización de los registros correctamente.", vbInformation, App.Title)
End Function

Private Sub txtCliente_DblClick()
    giAceptar = False
    RetornoAyuda = ""
    RetornoAyuda2 = ""
    RetornoAyuda3 = ""
'    BacAyuda.Tag = "Cliente"
'    BacAyuda.Show 1
     BacAyudaCliente.Tag = "Cliente"
     BacAyudaCliente.Show 1
    If Not giAceptar Then
        Exit Sub
    End If
    
    txtCliente.Text = RetornoAyuda
    txtCodigo.Text = CStr(Val(RetornoAyuda2))
    TXTNombre.Text = RetornoAyuda3

   If Trim(cmbSistemas.Text) = "" Then
      MsgBox "Por favor, seleccione Sistema!", vbInformation, TITSISTEMA
      cmbSistema.SetFocus
      Exit Sub
   End If
   If Trim(CmbProducto.Text) = "" Then
      MsgBox "Por favor, seleccione Producto", vbInformation, TITSISTEMA
      CmbProducto.SetFocus
      Exit Sub
   End If
End Sub

Private Function LlenaGrilla()
   Dim codSistema    As String
   Dim codProducto   As String
   Dim sp            As String
   Dim I             As Integer
   Dim Datos()
   
   Envia = Array()
   If cmbSistemas.Text = "<< TODOS >>" Then
      AddParam Envia, ""
   Else
      codSistema = LTrim(Mid$(cmbSistemas.Text, 70))
      AddParam Envia, codSistema
   End If

   If CmbProducto.Text = "<< TODOS >>" Then
      AddParam Envia, ""
   Else
      codProducto = LTrim(Mid$(CmbProducto.Text, 70))
      AddParam Envia, codProducto
   End If
   AddParam Envia, CDbl(txtCliente.Text)
   If txtCliente.Text = "0" Then
      AddParam Envia, 0
   Else
      AddParam Envia, CDbl(txtCodigo.Text)
   End If

   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_TRAEOPTHRESHOLDFILTROS", Envia) Then
      MsgBox "Error al ejecutar procedimiento " & sp, vbCritical, TITSISTEMA
      Exit Function
   End If
   Grilla.Rows = 1
   Grilla.Redraw = False
   Do While Bac_SQL_Fetch(Datos())
      Grilla.Rows = Grilla.Rows + 1
      Grilla.TextMatrix(Grilla.Rows - 1, 0) = Datos(1)
      Grilla.TextMatrix(Grilla.Rows - 1, 1) = Datos(2)
      Grilla.TextMatrix(Grilla.Rows - 1, 2) = Datos(3)
      Grilla.TextMatrix(Grilla.Rows - 1, 3) = Datos(4)
      Grilla.TextMatrix(Grilla.Rows - 1, 4) = Datos(5)
      Grilla.TextMatrix(Grilla.Rows - 1, 5) = Datos(6)
      Grilla.TextMatrix(Grilla.Rows - 1, 6) = Datos(7)
      Grilla.TextMatrix(Grilla.Rows - 1, 7) = Datos(8)
      Grilla.TextMatrix(Grilla.Rows - 1, 8) = Format(Datos(9), FEntero)
      Grilla.TextMatrix(Grilla.Rows - 1, 9) = Format(Datos(10), FEntero)
      Grilla.TextMatrix(Grilla.Rows - 1, 10) = Datos(10)
      Grilla.TextMatrix(Grilla.Rows - 1, 11) = Datos(11)
   Loop
   Grilla.Redraw = True
   
End Function


Private Function LlenaComboProducto(Combo As ComboBox, Modulo As String)
   Dim Datos()

   Combo.Clear
  
   Envia = Array()
   AddParam Envia, Trim(Right(Modulo, 5))
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_TRAEPRODUCTOS_SERVICIOSTHRESHOLD", Envia) Then
      Call MsgBox("Se ha producido un error al cargar productos.", vbExclamation, App.Title)
      Exit Function
   End If
   Combo.AddItem "<< TODOS >>"
   Do While Bac_SQL_Fetch(Datos())
      Call Combo.AddItem(Datos(1) & Space(100) & Datos(2))
   Loop
End Function

Private Function LlenaComboSistemas(Combo As ComboBox)
   Dim Datos()

   Combo.Clear

   Envia = Array()
   If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_TRAESISTEMASTHRESHOLD") Then
      Call MsgBox("Se ha producido un error al cargar sistemas.", vbExclamation, App.Title)
      Exit Function
   End If
   Call Combo.AddItem("<< TODOS >>")
   Do While Bac_SQL_Fetch(Datos())
      Call Combo.AddItem(Datos(1) & Space(100) & Datos(2))
   Loop
   Let cmbSistemas.ListIndex = 0
End Function

Private Sub CmbThreshold_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Grilla.ColSel = 11 Then
         Let Grilla.TextMatrix(Grilla.RowSel, Grilla.ColSel) = CmbThreshold.Text

         If CmbThreshold.Text = "NO" Then
            Let Grilla.TextMatrix(Grilla.RowSel, 9) = 0#
         Else
            Let Grilla.TextMatrix(Grilla.RowSel, 9) = Format(Grilla.TextMatrix(Grilla.RowSel, 10), FEntero)
         End If

         Let CmbThreshold.Visible = False
         Call DesbloquearObjetos
         Call Grilla.SetFocus
      End If
   End If
   If KeyCode = vbKeyEscape Then
      If Grilla.ColSel = 11 Then
         Let CmbThreshold.Visible = False
         Call DesbloquearObjetos
         Call Grilla.SetFocus
      End If
   End If
End Sub

Private Sub txtThreshold_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Grilla.ColSel = 9 Then
         Let Grilla.TextMatrix(Grilla.RowSel, Grilla.ColSel) = Format(txtThreshold.Text, FEntero)
         Let txtThreshold.Visible = False
         Call DesbloquearObjetos
         Call Grilla.SetFocus
      End If
   End If
   If KeyCode = vbKeyEscape Then
      If Grilla.ColSel = 9 Then
         Let txtThreshold.Visible = False
         Call DesbloquearObjetos
         Call Grilla.SetFocus
      End If
   End If
End Sub


Private Function SinPuntos(ByVal Dato As String) As String
   Dim salida  As String
   Dim car     As String
   Dim I       As Integer
   Dim n       As Integer

   salida = ""
   SinPuntos = ""

   n = Len(Dato)
   
   For I = 1 To n
      car = Mid$(Dato, I, 1)
      If car <> "," And car <> "." Then
         salida = salida + car
      End If
   Next
   SinPuntos = salida
End Function

Private Function BloquearObjetos()
   Toolbar1.Enabled = False
   SSFrame1.Enabled = False
   Grilla.Enabled = False
End Function
Private Function DesbloquearObjetos()
   Toolbar1.Enabled = True
   SSFrame1.Enabled = True
   Grilla.Enabled = True
End Function

Private Sub FuncCentrarObjetos(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next
   Let Objeto.top = Marco.CellTop + Marco.top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth
   On Error GoTo 0
End Sub

