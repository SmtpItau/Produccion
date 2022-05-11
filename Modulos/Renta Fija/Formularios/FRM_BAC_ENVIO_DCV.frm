VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_BAC_ENVIO_DCV 
   Caption         =   "Interfaz de Envío Operaciones al DCV."
   ClientHeight    =   5325
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10500
   FillColor       =   &H00404040&
   ForeColor       =   &H00E0E0E0&
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   5325
   ScaleWidth      =   10500
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10500
      _ExtentX        =   18521
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Filtra operaciones para enviar."
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar o Refrescar operaciones"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Enviar operaciones seleccionadas"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Vista previa del Informe"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar ventana e envio de operaciones"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   3630
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   10
         ImageHeight     =   10
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BAC_ENVIO_DCV.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BAC_ENVIO_DCV.frx":0412
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3045
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   5
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BAC_ENVIO_DCV.frx":0860
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BAC_ENVIO_DCV.frx":173A
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BAC_ENVIO_DCV.frx":2614
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BAC_ENVIO_DCV.frx":34EE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BAC_ENVIO_DCV.frx":3808
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Filtro 
      Height          =   705
      Left            =   15
      TabIndex        =   2
      Top             =   435
      Width           =   10485
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   270
         Index           =   0
         Left            =   7365
         Picture         =   "FRM_BAC_ENVIO_DCV.frx":46E2
         ScaleHeight     =   270
         ScaleWidth      =   330
         TabIndex        =   8
         Top             =   390
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   270
         Index           =   0
         Left            =   7350
         Picture         =   "FRM_BAC_ENVIO_DCV.frx":483C
         ScaleHeight     =   270
         ScaleWidth      =   375
         TabIndex        =   7
         Top             =   120
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.ComboBox cmbOperaciones 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   4320
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   165
         Width           =   2565
      End
      Begin VB.ComboBox cmbEstados 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   645
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   165
         Width           =   2565
      End
      Begin VB.Label EtiFiltro 
         AutoSize        =   -1  'True
         Caption         =   "Operaciones"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   1
         Left            =   3330
         TabIndex        =   5
         Top             =   240
         Width           =   930
      End
      Begin VB.Label EtiFiltro 
         AutoSize        =   -1  'True
         Caption         =   "Estado"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   0
         Left            =   75
         TabIndex        =   3
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.Frame Marco 
      Height          =   4275
      Left            =   0
      TabIndex        =   1
      Top             =   1050
      Width           =   10500
      Begin VB.ComboBox CmbMadurez 
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
         Left            =   8850
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   225
         Visible         =   0   'False
         Width           =   1290
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   4065
         Left            =   60
         TabIndex        =   9
         Top             =   135
         Width           =   10365
         _ExtentX        =   18283
         _ExtentY        =   7170
         _Version        =   393216
         RowHeightMin    =   310
         BackColor       =   -2147483644
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483645
         GridColor       =   -2147483644
         GridColorFixed  =   -2147483641
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
      End
   End
End
Attribute VB_Name = "FRM_BAC_ENVIO_DCV"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cEstadoFilt As String
Dim cOperacFilt As String
Dim iCorpBanca  As Boolean

Const Estado_Pendiente = "P"
Const Estado_Marcado = "M"
Const Estado_Enviado = "E"
Const Estado_Reenviar = "R"

Private Sub CargarOperaciones()
   Dim Sql     As String
   Dim Datos()
   
   Sql = "SELECT codigo_producto , descripcion FROM BacParamSuda..PRODUCTO WHERE id_sistema = 'BTR' AND codigo_producto IN('CP','VP')"
   Call Bac_Sql_Execute(Sql)
   cmbOperaciones.Clear
   cmbOperaciones.AddItem "<< Todos >>" & Space(1000) & " "
   cmbOperaciones.ItemData(cmbOperaciones.NewIndex) = 0
   Do While Bac_SQL_Fetch(Datos())
      cmbOperaciones.AddItem Datos(2) & Space(1000) & UCase(Datos(1))
      cmbOperaciones.ItemData(cmbOperaciones.NewIndex) = cmbOperaciones.ListCount
   Loop
End Sub

Private Sub CargarEstados()
   Dim Sql     As String
   Dim Datos()
   
   Sql = "SELECT Estado , Descripcion FROM ESTADOS_DCV ORDER BY Descripcion"
   Call Bac_Sql_Execute(Sql)
   cmbEstados.Clear
   
   cmbEstados.AddItem "<< Todos >>" & Space(1000) & " "
   cmbEstados.ItemData(cmbEstados.NewIndex) = 0
   Do While Bac_SQL_Fetch(Datos())
      cmbEstados.AddItem UCase(Datos(2)) & Space(1000) & Datos(1)
      cmbEstados.ItemData(cmbEstados.NewIndex) = cmbEstados.ListCount
      If Datos(1) = "P" Then
         cEstadoFilt = UCase(Datos(2)) & Space(1000) & Datos(1)
      End If
   Loop
   cmbEstados.Text = cEstadoFilt
End Sub

Private Sub Nombres()
   Grilla.Rows = 3
   Grilla.FixedRows = 2
   Grilla.Cols = 17
   Grilla.FixedCols = 0
   
   Grilla.TextMatrix(0, 0) = "Selección":    Grilla.TextMatrix(1, 0) = "":             Grilla.ColAlignment(0) = flexAlignLeftCenter:   Grilla.ColWidth(0) = 1000
   Grilla.TextMatrix(0, 1) = "Estado":       Grilla.TextMatrix(1, 1) = "":             Grilla.ColAlignment(1) = flexAlignLeftCenter:   Grilla.ColWidth(1) = 1500
   Grilla.TextMatrix(0, 2) = "Número":       Grilla.TextMatrix(1, 2) = "Documento":    Grilla.ColAlignment(2) = flexAlignRightCenter:  Grilla.ColWidth(2) = 1200
   Grilla.TextMatrix(0, 3) = "Número":       Grilla.TextMatrix(1, 3) = "Correlativo":  Grilla.ColAlignment(3) = flexAlignRightCenter:  Grilla.ColWidth(3) = 1200
   Grilla.TextMatrix(0, 4) = "Serie":        Grilla.TextMatrix(1, 4) = "Instrumento":  Grilla.ColAlignment(4) = flexAlignLeftCenter:   Grilla.ColWidth(4) = 1800
   Grilla.TextMatrix(0, 5) = "Moneda":       Grilla.TextMatrix(1, 5) = "Instrumento":  Grilla.ColAlignment(5) = flexAlignLeftCenter:   Grilla.ColWidth(5) = 800
   Grilla.TextMatrix(0, 6) = "Valor":        Grilla.TextMatrix(1, 6) = "Nominal":      Grilla.ColAlignment(6) = flexAlignRightCenter:  Grilla.ColWidth(6) = 2000
   Grilla.TextMatrix(0, 7) = "Tir":          Grilla.TextMatrix(1, 7) = "Compra":       Grilla.ColAlignment(7) = flexAlignRightCenter:  Grilla.ColWidth(7) = 1000
   Grilla.TextMatrix(0, 8) = "Valor":        Grilla.TextMatrix(1, 8) = "Par":          Grilla.ColAlignment(8) = flexAlignRightCenter:  Grilla.ColWidth(8) = 2000
   Grilla.TextMatrix(0, 9) = "Valor":        Grilla.TextMatrix(1, 9) = "Presente":     Grilla.ColAlignment(9) = flexAlignRightCenter:  Grilla.ColWidth(9) = 2000
   Grilla.TextMatrix(0, 10) = "Clave":       Grilla.TextMatrix(1, 10) = "Dcv":         Grilla.ColAlignment(10) = flexAlignLeftCenter:  Grilla.ColWidth(10) = 1200
   Grilla.TextMatrix(0, 11) = "Condición":   Grilla.TextMatrix(1, 11) = "Madurez":     Grilla.ColAlignment(11) = flexAlignLeftCenter:  Grilla.ColWidth(11) = 2000
   Grilla.TextMatrix(0, 12) = "Usuario":     Grilla.TextMatrix(1, 12) = "Selección":   Grilla.ColAlignment(12) = flexAlignLeftCenter:  Grilla.ColWidth(12) = 1500
   Grilla.TextMatrix(0, 13) = "Rut":         Grilla.TextMatrix(1, 13) = "Cliente":     Grilla.ColAlignment(13) = flexAlignLeftCenter:  Grilla.ColWidth(13) = 0
   Grilla.TextMatrix(0, 14) = "Código":      Grilla.TextMatrix(1, 14) = "Cliente":     Grilla.ColAlignment(14) = flexAlignLeftCenter:  Grilla.ColWidth(14) = 0
   Grilla.TextMatrix(0, 15) = "Nombre":      Grilla.TextMatrix(1, 15) = "Cliente":     Grilla.ColAlignment(15) = flexAlignLeftCenter:  Grilla.ColWidth(15) = 2200
   Grilla.TextMatrix(0, 16) = "UsrRespon":   Grilla.TextMatrix(1, 16) = "Responsable": Grilla.ColAlignment(16) = flexAlignLeftCenter:  Grilla.ColWidth(16) = 0
   
   Grilla.Font.Name = "Arial"
   Grilla.Font.Size = 8
   Grilla.Font.bold = False
   
End Sub

Private Sub CmbMadurez_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim iNumdocu As Long
   Dim iCorrela As Long
   Dim cEstado  As String
   
   If KeyCode = vbKeyReturn Then
      Grilla.TextMatrix(Grilla.RowSel, 11) = CmbMadurez.Text
      iNumdocu = Grilla.TextMatrix(Grilla.RowSel, 2)
      iCorrela = Grilla.TextMatrix(Grilla.RowSel, 3)
      cEstado = Left(CmbMadurez.Text, 1)
      
      Envia = Array()
      AddParam Envia, "D"
      AddParam Envia, gsBac_User
      AddParam Envia, cEstado
      AddParam Envia, iNumdocu
      AddParam Envia, iCorrela
      AddParam Envia, CDbl(0)
      If Not Bac_Sql_Execute("SVC_CAMBIO_ESTADO", Envia) Then
         Exit Sub
      End If
   
      Grilla.Enabled = True
      Grilla.SetFocus
      CmbMadurez.Visible = False
   End If
   If KeyCode = vbKeyEscape Then
      Grilla.Enabled = True
      Grilla.SetFocus
      CmbMadurez.Visible = False
   End If
   
   
End Sub

Private Sub Form_Load()
   Me.Icon = BacTrader.Icon
   Me.Top = 0: Me.Left = 0
   Toolbar1.Buttons(1).Visible = False
   
   iCorpBanca = False
   
   CmbMadurez.AddItem "C - Cualquiera"
   CmbMadurez.AddItem "I - Inmadura"
   CmbMadurez.AddItem "M - Madura"
   
   Call CargarEstados
   Call CargarOperaciones
   Call Nombres
   Call CargarOperacionesDia
End Sub

Private Sub Form_Resize()
   On Error Resume Next
   Marco.Width = Me.Width - 150
   Marco.Height = (Me.Height - Toolbar1.Height) - 950
   Filtro.Width = Marco.Width
   Filtro.Left = Marco.Left
   Grilla.Width = Marco.Width - 150
   Grilla.Height = (Marco.Height) - 350
End Sub

Private Sub CargarOperacionesDia()
   On Error GoTo ErrStoreData
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, Format(gsBac_Fecp, feFECHA)
   AddParam Envia, Trim(Right(cmbOperaciones.Text, 5))
   AddParam Envia, Trim(Right(cmbEstados.Text, 5))
   AddParam Envia, gsBac_User
   If Not Bac_Sql_Execute("SVC_REFRESCA_DATA_DCV", Envia) Then
      GoTo ErrStoreData
   End If
   Grilla.Rows = 2
   Grilla.Redraw = False
   Do While Bac_SQL_Fetch(Datos())
      Grilla.Rows = Grilla.Rows + 1
      
      If Datos(13) = gsBac_User Or Datos(13) = "" Then
         Grilla.TextMatrix(Grilla.Rows - 1, 0) = IIf(Datos(12) = "True", 1, 0)
      Else
         Call PintaCeldasBloqeadas(Grilla.Rows - 1)
         Grilla.TextMatrix(Grilla.Rows - 1, 0) = 2
      End If
      
      Grilla.TextMatrix(Grilla.Rows - 1, 1) = Datos(1)                    '--> Estado
      Grilla.TextMatrix(Grilla.Rows - 1, 2) = Datos(2)                    '--> Docu
      Grilla.TextMatrix(Grilla.Rows - 1, 3) = Datos(3)                    '--> Correla
      Grilla.TextMatrix(Grilla.Rows - 1, 4) = Datos(4)                    '--> Serie
      Grilla.TextMatrix(Grilla.Rows - 1, 5) = Datos(5)                    '--> Moneda
      Grilla.TextMatrix(Grilla.Rows - 1, 6) = Format(Datos(6), FDecimal)  '--> Nominales
      Grilla.TextMatrix(Grilla.Rows - 1, 7) = Format(Datos(7), FDecimal)  '--> Tir
      Grilla.TextMatrix(Grilla.Rows - 1, 8) = Format(Datos(8), FDecimal)  '--> Pvpar
      Grilla.TextMatrix(Grilla.Rows - 1, 9) = Format(Datos(9), FEntero)   '--> vPresente
      Grilla.TextMatrix(Grilla.Rows - 1, 10) = Datos(10)                  '--> ClaveDcv
      Grilla.TextMatrix(Grilla.Rows - 1, 11) = Datos(11)                  '--> CondMadurez
      Grilla.TextMatrix(Grilla.Rows - 1, 12) = Datos(13)                  '--> Usuario
      Grilla.TextMatrix(Grilla.Rows - 1, 13) = Datos(14)                  '--> Rut
      Grilla.TextMatrix(Grilla.Rows - 1, 14) = Datos(15)                  '--> Codigo
      Grilla.TextMatrix(Grilla.Rows - 1, 15) = Datos(16)                  '--> Nombre
      Grilla.TextMatrix(Grilla.Rows - 1, 16) = Datos(17)                  '--> Usr Responsable
      
      Call AgregarMarca(Grilla.Rows - 1, 0, Datos(12))
   Loop
   Grilla.Redraw = True
Exit Sub
ErrStoreData:
   Grilla.Redraw = True
   MsgBox "Error Carga. " & vbCrLf & vbCrLf & "Se ha producido un erroro al cargar operaciones.", vbExclamation, TITSISTEMA
End Sub

Private Sub AgregarMarca(MiFila As Integer, MiColumna As Integer, ByVal Marcado As Boolean)
   Grilla.Row = MiFila
   Grilla.Col = 0
   Grilla.CellForeColor = &H80000004
   Grilla.CellPictureAlignment = flexAlignLeftCenter
   If Marcado = False Then
      Set Grilla.CellPicture = SinCheck(0).Image
   Else
      Set Grilla.CellPicture = ConCheck(0).Image
   End If
End Sub

Private Sub PintaCeldasBloqeadas(MiFila As Integer)
   Dim iContador  As Integer
   
   Grilla.Row = MiFila
   For iContador = 0 To Grilla.Cols - 1
      Grilla.Col = iContador
      Grilla.CellBackColor = &H404040
      Grilla.CellForeColor = vbWhite
   Next iContador
End Sub

Private Sub grilla_Click()
   If Grilla.ColSel = 0 Then
      If Grilla.TextMatrix(Grilla.RowSel, 0) = 2 Then
         MsgBox "Registro se encuentra reservado por el usuario : " & Grilla.TextMatrix(Grilla.RowSel, 12), vbInformation, TITSISTEMA
         Grilla.SetFocus
         Exit Sub
      End If
      
      If Grilla.TextMatrix(Grilla.RowSel, 0) = 0 Then
         If Left(Grilla.TextMatrix(Grilla.RowSel, 1), 1) = "E" Then
            If MsgBox("Este operación se encuentra en estado Enviado por el usuario : " & Grilla.TextMatrix(Grilla.RowSel, 16) & vbCrLf & " ¿ Desea realizar el Reenvio ? ", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
               Grilla.SetFocus
               Exit Sub
            End If
         End If
         If Left(Grilla.TextMatrix(Grilla.RowSel, 1), 1) = "R" Then
            If MsgBox("Este Operación se encuentra en estado Reenviado por el usuario : " & Grilla.TextMatrix(Grilla.RowSel, 16) & vbCrLf & " ¿ Desea realizar el Reenvio ? ", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
               Grilla.SetFocus
               Exit Sub
            End If
         End If
         
         Grilla.TextMatrix(Grilla.RowSel, 0) = 1
         Grilla.TextMatrix(Grilla.RowSel, 12) = gsBac_User
         Call AgregarMarca(Grilla.RowSel, 0, True)
      Else
         Grilla.TextMatrix(Grilla.RowSel, 0) = 0
         Grilla.TextMatrix(Grilla.RowSel, 12) = ""
         Call AgregarMarca(Grilla.RowSel, 0, False)
      End If
      
      Envia = Array()
      AddParam Envia, IIf(Grilla.TextMatrix(Grilla.RowSel, 0) = 1, "S", "N")
      AddParam Envia, gsBac_User
      AddParam Envia, " "
      AddParam Envia, CDbl(Grilla.TextMatrix(Grilla.RowSel, 2))
      AddParam Envia, CDbl(Grilla.TextMatrix(Grilla.RowSel, 3))
      AddParam Envia, 0
      Call Bac_Sql_Execute("SVC_CAMBIO_ESTADO", Envia)
      Grilla.SetFocus
   End If
End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeySpace And Grilla.ColSel = 0 Then
      Call grilla_Click
   End If
   
   If KeyCode = vbKeyReturn And Grilla.ColSel = 11 And Grilla.TextMatrix(Grilla.RowSel, 12) = gsBac_User Then
      Call PROC_POSI_TEXTO(Grilla, CmbMadurez)
      CmbMadurez.Visible = True
      Grilla.Enabled = True
      CmbMadurez.Text = Grilla.TextMatrix(Grilla.RowSel, Grilla.ColSel)
      CmbMadurez.SetFocus
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call CargarOperacionesDia
      Case 3
         Call EnviarDatos
      Case 4
         Call PrintInformeOp
      Case 5
         Unload Me
   End Select
End Sub

Private Sub EnviarDatos()
   On Error GoTo ErrorEnvio
   Dim iCantidad  As String
   Dim iContador  As Integer
   Dim iNumdocu   As Long
   Dim iCorrela   As Long
   Dim iNumFile   As Long
   Dim iFileHost  As String
   Dim cCadena    As String
   Dim iFile      As String
   Dim Datos()
   Dim Operacion()
   
   Call Bac_Sql_Execute("SELECT MAX(isnull(NumInterfaz,0)) + 1  FROM OP_ENVIADAS_DCV")
   Call Bac_SQL_Fetch(Datos())
   iNumFile = IIf(Datos(1) = 0, 1, Datos(1))
   iFile = "C:\DCV" + Format(Str(iNumFile), "00000") + ".Dat"
   
   If Dir(iFile, vbArchive) <> "" Then
      On Error Resume Next
      
      On Error GoTo 0
      Kill iFile
   End If
   
   iFileHost = FreeFile
   Open iFile For Output As iFileHost
   
   Call Bac_Sql_Execute("BEGIN TRANSACTION")

   iCantidad = 0
   For iContador = 2 To Grilla.Rows - 1
      If Grilla.TextMatrix(iContador, 0) = 1 And Grilla.TextMatrix(iContador, 12) = gsBac_User Then
         iNumdocu = Grilla.TextMatrix(iContador, 2)
         iCorrela = Grilla.TextMatrix(iContador, 3)
               
         Envia = Array()
         AddParam Envia, CDbl(iNumdocu)
         AddParam Envia, CDbl(iCorrela)
         If Not Bac_Sql_Execute("SVC_GEN_INTERFAZDCV", Envia) Then
            GoTo ErrorEnvio
         End If
         Do While Bac_SQL_Fetch(Datos())
            If Datos(1) < 0 Then
               Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
               MsgBox "ERROR." & vbCrLf & vbCrLf & Datos(2), vbExclamation, TITSISTEMA
               Close #iFileHost
               Exit Sub
            End If
            
            cCadena = ""
            cCadena = cCadena & Format(Datos(3), "ddmmyyyy")                                                         '--> Fecha Operacion
            cCadena = cCadena & String(8 - Len(Datos(4)), "0") & Datos(4)                                            '--> Cuenta CorpBanca
            cCadena = cCadena & String(8 - Len(Mid(Datos(20), 1, 8)), "0") & Mid(Datos(20), 1, 8)                    '--> Contraparte
            cCadena = cCadena & String(15 - Len(Mid(Datos(5), 1, 15)), " ") & Mid(Datos(5), 1, 15)                   '--> Clave DCV
            cCadena = cCadena & Format(Datos(6), "ddmmyyyy")                                                         '--> Fecha Liquidación
            cCadena = cCadena & Datos(7)                                                                             '--> Operación
            cCadena = cCadena & Datos(8)                                                                             '--> Movimiento
            cCadena = cCadena & Datos(9) & String(12 - Len(Datos(9)), " ")                                            '--> Instrumento (Serie)
            cCadena = cCadena & Datos(10)                                                                            '--> Condición Madurez
            cCadena = cCadena & String(17 - Len(Format(Datos(11), "##0.0000")), "0") & Format(Datos(11), "##0.0000") '--> Posición Transada
            cCadena = cCadena & Datos(12)                                                                            '--> Moneda
            cCadena = cCadena & String(17 - Len(Format(Datos(13), "##0.0000")), "0") & Format(Datos(13), "##0.0000") '--> Monto Transado
            cCadena = cCadena & Datos(14)                                                                            '--> Forma de Pago
            cCadena = cCadena & Datos(15)                                                                            '--> Partida de Madurez
            cCadena = cCadena & String(1 - Len(Datos(16)), " ") + Datos(16)                                          '--> Destino Compra
            cCadena = cCadena & Datos(17)                                                                            '--> Acción
            cCadena = cCadena & "--"                                                                                 '--> Caracter Separador
            
            Print #iFileHost, cCadena
            
            iCantidad = iCantidad + 1
         Loop
         Call CambiaEstadoEnvio(iNumdocu, iCorrela, iNumFile)
      End If
   Next iContador
   Close #iFileHost
   
   Call Bac_Sql_Execute("COMMIT TRANSACTION")
   MsgBox "Se han enviado sin problemas # " & Str(iCantidad) & " registro de operaciones en forma correcta. " & vbCrLf & vbCrLf & "Interfaz : " & iFile, vbInformation, TITSISTEMA
   
   Call CargarOperacionesDia
Exit Sub
ErrorEnvio:
   Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
   MsgBox "Error de envio en la operación: " & Str(iNumdocu) + "-" + Str(iCorrela), vbExclamation, TITSISTEMA
End Sub

Private Sub CambiaEstadoEnvio(ByVal iDocu As Long, ByVal iCorrela As Long, ByVal iNumFile As Long, Optional ByVal cEstado As String)
   Envia = Array()
   AddParam Envia, " "
   AddParam Envia, gsBac_User
   AddParam Envia, cEstado
   AddParam Envia, iDocu
   AddParam Envia, iCorrela
   AddParam Envia, iNumFile
   If Not Bac_Sql_Execute("SVC_CAMBIO_ESTADO", Envia) Then
      Exit Sub
   End If
End Sub

Private Sub PrintInformeOp()
   On Error GoTo ErrImpresion
   
   Call Limpiar_Cristal
   BacTrader.bacrpt.WindowTitle = "Informe de Operaciones enviadas a DCV [DBO.SVC_INFORME_OPERACIONES]"
   BacTrader.bacrpt.ReportTitle = "Informe de Operaciones enviadas a DCV [DBO.SVC_INFORME_OPERACIONES]"
   BacTrader.bacrpt.WindowState = crptMaximized
   BacTrader.bacrpt.Destination = crptToWindow
   BacTrader.bacrpt.ReportFileName = RptList_Path & "Informe_Estado_OperacionesDcv.rpt"
                    ' Store Procedure : DBO.SVC_INFORME_OPERACIONES.sql
   BacTrader.bacrpt.StoredProcParam(0) = Format(gsBac_Fecp, "yyyy-mm-dd 00:00:00.000")
   BacTrader.bacrpt.StoredProcParam(1) = gsBac_User
   BacTrader.bacrpt.Connect = CONECCION
   BacTrader.bacrpt.Action = 1

   
   Call Limpiar_Cristal
   BacTrader.bacrpt.WindowTitle = "Informe de Operaciones enviadas a DCV [DBO.SVC_INFORME_OPERACIONES]"
   BacTrader.bacrpt.ReportTitle = "Informe de Operaciones enviadas a DCV [DBO.SVC_INFORME_OPERACIONES]"
   BacTrader.bacrpt.WindowState = crptMaximized
   BacTrader.bacrpt.Destination = crptToWindow
   BacTrader.bacrpt.ReportFileName = RptList_Path & "Informe_Operaciones_Enviadas.rpt"
                    ' Store Procedure : DBO.SVC_INFORME_OPERACIONES.sql
   BacTrader.bacrpt.StoredProcParam(0) = Format(gsBac_Fecp, "yyyy-mm-dd 00:00:00.000")
   BacTrader.bacrpt.StoredProcParam(1) = gsBac_User
   BacTrader.bacrpt.Connect = CONECCION
   BacTrader.bacrpt.Action = 1

Exit Sub
ErrImpresion:
   MsgBox "Error de impresión" & vbCrLf & vbCrLf & err.Description, vbExclamation, TITSISTEMA
End Sub
