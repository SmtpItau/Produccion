VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MANTCLAUSULAS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Cláusulas de Contrato"
   ClientHeight    =   6390
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   11925
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6390
   ScaleWidth      =   11925
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   12
      Top             =   0
      Width           =   11925
      _ExtentX        =   21034
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
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame Frame1 
      Height          =   5910
      Left            =   45
      TabIndex        =   11
      Top             =   465
      Width           =   11730
      Begin VB.CheckBox Chk_Clausula_activa 
         Alignment       =   1  'Right Justify
         Caption         =   "Clausula Activa"
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
         Height          =   270
         Left            =   3870
         TabIndex        =   22
         Top             =   1080
         Width           =   1665
      End
      Begin VB.CheckBox chkUtilizaAval 
         Caption         =   "Utiliza Avales"
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
         Height          =   225
         Left            =   8550
         TabIndex        =   8
         Top             =   5475
         Width           =   1500
      End
      Begin VB.ComboBox cmbDefault 
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
         Left            =   2490
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   5340
         Width           =   915
      End
      Begin VB.TextBox txtNomenclatura2 
         Height          =   1185
         Left            =   195
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   18
         Top             =   3720
         Visible         =   0   'False
         Width           =   1005
      End
      Begin VB.TextBox txtNomenclatura 
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
         Height          =   4635
         Left            =   11400
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   10
         Top             =   720
         Width           =   5655
      End
      Begin VB.CommandButton cmdNomenclatura 
         Caption         =   "Nomenclatura"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   8160
         TabIndex        =   9
         Top             =   1785
         Width           =   1485
      End
      Begin VB.TextBox Glosa2 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   2685
         Left            =   2500
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   6
         Top             =   2550
         Width           =   9135
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
         Left            =   2505
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   300
         Width           =   3780
      End
      Begin VB.TextBox txtGlosa1 
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
         Left            =   2500
         MaxLength       =   50
         TabIndex        =   5
         Top             =   2145
         Width           =   4935
      End
      Begin VB.TextBox txtCodClausula 
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
         Left            =   2500
         MaxLength       =   5
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   2
         Top             =   1050
         Width           =   1230
      End
      Begin VB.ComboBox cmdTipoContrato 
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
         Left            =   2505
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   675
         Width           =   5625
      End
      Begin VB.TextBox txtMarcador 
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
         Left            =   2500
         MaxLength       =   15
         TabIndex        =   3
         Top             =   1410
         Width           =   2640
      End
      Begin BACControles.TXTNumero txtIndiceOrden 
         Height          =   315
         Left            =   2505
         TabIndex        =   4
         Top             =   1785
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   556
         ForeColor       =   8388608
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
         Min             =   "0"
         Max             =   "999"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Label1 
         Caption         =   "Por Defecto"
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
         Index           =   7
         Left            =   105
         TabIndex        =   21
         Top             =   5400
         Width           =   1485
      End
      Begin VB.Label Label1 
         Caption         =   "Indice Orden Cláusula"
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
         Index           =   4
         Left            =   120
         TabIndex        =   20
         Top             =   1830
         Width           =   2280
      End
      Begin VB.Label Label1 
         Caption         =   "Tipo Contrato"
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
         Height          =   270
         Index           =   6
         Left            =   120
         TabIndex        =   19
         Top             =   720
         Width           =   1485
      End
      Begin VB.Label Label1 
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
         Height          =   315
         Index           =   5
         Left            =   120
         TabIndex        =   17
         Top             =   360
         Width           =   1485
      End
      Begin VB.Label Label1 
         Caption         =   "Texto Glosa"
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
         Height          =   330
         Index           =   3
         Left            =   120
         TabIndex        =   16
         Top             =   2565
         Width           =   1485
      End
      Begin VB.Label Label1 
         Caption         =   "Glosa Corta"
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
         Height          =   330
         Index           =   2
         Left            =   135
         TabIndex        =   15
         Top             =   2190
         Width           =   1485
      End
      Begin VB.Label Label1 
         Caption         =   "Nom.Marcador.Dcto."
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
         Index           =   1
         Left            =   120
         TabIndex        =   14
         Top             =   1425
         Width           =   2190
      End
      Begin VB.Label Label1 
         Caption         =   "Código Cláusula"
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
         Index           =   0
         Left            =   120
         TabIndex        =   13
         Top             =   1110
         Width           =   1485
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7065
      Top             =   0
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
            Picture         =   "FRM_MANTCLAUSULAS.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MANTCLAUSULAS.frx":0454
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MANTCLAUSULAS.frx":08A8
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MANTCLAUSULAS.frx":0BCC
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_MANTCLAUSULAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim msgRetorn   As String
Dim bTexto      As Boolean

Sub Proc_Busca_Clausula()

   Dim cProc_Consulta_Emitidos As String

      If cmbSistema.ListIndex = -1 Or cmdTipoContrato.ListIndex = -1 Then
         MsgBox "Debe seleccionar un SISTEMA y un CONTRATO FISICO para realizar la busqueda", vbExclamation + vbOKOnly
         Exit Sub
      End If
      
      If txtCodClausula.Text = "" Then
         MsgBox "Debe ingresar un codigo de glosa dinamica para realizar la busqueda", vbExclamation + vbOKOnly
         Exit Sub
      End If
   
      Screen.MousePointer = vbHourglass

      Envia = Array()
      AddParam Envia, Right(cmbSistema.Text, 3)
      AddParam Envia, Trim(Right(cmdTipoContrato, 10))
      AddParam Envia, Trim(txtCodClausula.Text)
      
      If Not Bac_Sql_Execute("BACPARAMSUDA..SP_CON_CLAUSULA_CONTRATO_DINAMICO", Envia) Then
         Screen.MousePointer = vbDefault
         MsgBox "Ha ocurrido un error al intenter consultar la glosa para contratos dinamicos", vbOKOnly + vbCritical
         Exit Sub
      Else
         If Bac_SQL_Fetch(Datos()) Then
            txtMarcador.Text = Trim(Datos(6))
            txtIndiceOrden.Text = Trim(Datos(7))
            txtGlosa1.Text = Trim(Datos(4))
            Glosa2.Text = Trim(Datos(5))
            cmbDefault.ListIndex = IIf(Trim(Datos(8)) = "S", 1, 0)
            chkUtilizaAval.Value = IIf(Trim(Datos(9)) = "S", 1, 0)
            Chk_Clausula_activa.Value = IIf(Trim(Datos(10)) = "S", 1, 0)
         End If
      End If
      
   Glosa2.Enabled = True
   
   If Trim(Glosa2.Text) <> "" Then
      Envia = Array()
      AddParam Envia, -999
      AddParam Envia, -999
      AddParam Envia, -999
      AddParam Envia, ""
      AddParam Envia, ""
      AddParam Envia, Trim(Right(cmdTipoContrato, 10))
      AddParam Envia, Trim(txtCodClausula.Text)
      
      If Right(cmbSistema.Text, 3) = "PCS" Then
         cProc_Consulta_Emitidos = "BACSWAPSUDA..SP_CON_CONTRATO_IMPRESO"
      ElseIf Right(cmbSistema.Text, 3) = "BFW" Then
         cProc_Consulta_Emitidos = "BACFWDSUDA..SP_CON_CONTRATO_IMPRESO"
      End If
            
      If Not Bac_Sql_Execute(cProc_Consulta_Emitidos, Envia) Then
         Screen.MousePointer = vbDefault
         MsgBox "Ha ocurrido un error al intenter validar si el contrato ya fue emitido", vbCritical + vbOKOnly
         Exit Sub
      End If
                
      If Bac_SQL_Fetch(Datos()) Then
         'el solo hecho de entrar aqui significa que existe un contrato emitido
         Glosa2.Enabled = False
      End If
   End If
      
    cmbSistema.Enabled = False
    cmdTipoContrato.Enabled = False
    txtCodClausula.Enabled = False
            
    txtMarcador.Enabled = True
    txtIndiceOrden.Enabled = True
    txtGlosa1.Enabled = True
   'Glosa2.Enabled = True
    cmbDefault.Enabled = True
    chkUtilizaAval.Enabled = True
    cmdNomenclatura.Enabled = True
    Chk_Clausula_activa.Enabled = True
    
    Screen.MousePointer = vbDefault

End Sub









Private Sub cmbSistema_Click()
    
   Dim Datos()
    
   If cmbSistema.ListIndex = -1 Then
      Exit Sub
   End If
    
   Envia = Array()
   AddParam Envia, Trim(Right(cmbSistema.Text, 10))
   
   If Not Bac_Sql_Execute("sp_TraeContrato", Envia) Then
       MsgBox "Problemas al Intentar llanar el combo", vbExclamation + vbOKOnly
       Exit Sub
   End If
   
   cmdTipoContrato.Clear

   Do While Bac_SQL_Fetch(Datos())
       cmdTipoContrato.AddItem Datos(2) & Space(80) & Datos(1)
   Loop
   
   If cmdTipoContrato.ListCount > 0 Then
       cmdTipoContrato.ListIndex = -1
   End If


End Sub

Private Sub Form_Load()
    Me.Icon = BACSwapParametros.Icon
    Me.Left = 0
    Me.Top = 0
    txtNomenclatura.Visible = False
    
    cmbSistema.Clear
    cmbSistema.AddItem "Forward" & Space(100) & "BFW"
    cmbSistema.AddItem "Swaps" & Space(100) & "PCS"
    
    cmbDefault.Clear
    cmbDefault.AddItem "NO"
    cmbDefault.AddItem "SI"
    
    Call LimpiarPantalla
    
End Sub

Private Sub cmdNomenclatura_Click()
    
    CargaNomenclatura
    
    If txtNomenclatura.Visible = False Then
        txtNomenclatura.Visible = True
        txtNomenclatura.Top = 645
        txtNomenclatura.Left = 2500
        Exit Sub
    End If
    If txtNomenclatura.Visible = True Then
        txtNomenclatura.Visible = False
        txtNomenclatura.Top = 20000
        Exit Sub
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
    Case 1
        If txtCodClausula.Text = "" Then
            MsgBox "Debe Ingresar." & Label1(0).Caption, vbExclamation, TITSISTEMA
            txtCodClausula.SetFocus
            txtCodClausula.SelStart = 0
            txtCodClausula.SelLength = Len(txtCodClausula.Text)
            Exit Sub
        Else
            If Not ValidaCodigoClau(txtCodClausula.Text) Then Exit Sub
        End If
        If txtGlosa1.Text = "" Then
            MsgBox "Debe Ingresar " & Label1(2).Caption, vbExclamation, TITSISTEMA
            txtGlosa1.SetFocus
            txtGlosa1.SelStart = 0
            txtGlosa1.SelLength = Len(txtGlosa1.Text)
            Exit Sub
        Else
            If Not ValidaGlosa1(txtGlosa1.Text) Then Exit Sub
        End If
        
        If ValidaDatos Then
            Call GrabaClausula(txtCodClausula.Text)
        End If

    Case 3
        Call LimpiarPantalla
    Case 4
        Unload Me
    End Select
End Sub

Private Sub txtCodClausula_DblClick()

   If cmbSistema.ListIndex = -1 Or cmdTipoContrato.ListIndex = -1 Then
      Exit Sub
   End If

   BacControlWindows 100
   BacAyuda.Tag = "CLAUSULA_DINAMICA"
   
   gsCodigo = Trim(Right(Me.cmbSistema.Text, 3)) + Space(2) + Trim(Right(cmdTipoContrato.Text, 10))

   BacAyuda.Show 1

   If giAceptar = True Then
      txtCodClausula.Text = gsCodigo
      txtCodClausula_KeyPress (vbKeyReturn)
   End If

End Sub

Private Sub txtCodClausula_KeyPress(KeyAscii As Integer)
    
   If KeyAscii = vbKeyReturn Then
      Proc_Busca_Clausula
      'SendKeys "{tab}"
      txtMarcador.SetFocus
   End If
    
   If KeyAscii >= Asc("a") And KeyAscii <= Asc("z") Then
      KeyAscii = KeyAscii - 32
   End If
    
End Sub


Private Sub cmbSistema_KeyPress(KeyAscii As Integer)
    If KeyAscii = vbKeyReturn Then
        SendKeys "{tab}"
    End If
End Sub

Private Sub Txtglosa1_KeyPress(KeyAscii As Integer)
    If KeyAscii = vbKeyReturn Then
        SendKeys "{tab}"
    End If
    
   If KeyAscii >= Asc("a") And KeyAscii <= Asc("z") Then
      KeyAscii = KeyAscii - 32
   End If
    
End Sub

Private Sub Txtglosa1_LostFocus()
'    If txtGlosa1.Text <> "" Then
'        If ValidaGlosa1(txtGlosa1.Text) Then
'            txtGlosa1.SetFocus
'        End If
'    End If
    
End Sub

Sub CargaNomenclatura()
    bTexto = False
    txtNomenclatura.Text = "NMC001 = Día de Proceso"
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC002 = Mes de Proceso"
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC003 = Año de Proceso"
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC004 = Nombre Corp. Apoderado1 "
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC005 = C.I. Corp. Apoderado1 "
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC006 = Nombre Corp. Apoderado2 "
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC007 = C.I. Corp.  Apoderado2 "
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC008 = Razon Social Cliente"
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC009 = R.U.T. Cliente"
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC010 = Nombre Apoderado Cliente 1"
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC011 = C.I. Apoderado Cliente 1"
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC012 = Nombre Apoderado Cliente 2"
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC013 = C.I. Apoderado Cliente 2"
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC014 = Dirección Cliente"
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC015 = Comuna  Cliente"
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC016 = Ciudad Cliente"
    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC017 = Fecha Antiguo C.c.g."
    
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC017 = R.U.T. N° Aval"
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC018 = Nombre Aval"
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC019 = Régimen Conyugal Aval"
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC020 = Profesión Aval"
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC021 = Domicilio Aval"
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC022 = Comuna Aval"
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC023 = Ciudad Aval"
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC024 = Razon Social Aval"
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC025 = Nombre Apoderado 1 Aval"
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC026 = C.I. Apoderado 1 Aval"
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC027 = Nombre Apoderado 2 Aval"
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC028 = C.I. Apoderado 2 Aval"
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC029 = Nombre Cónyuge Aval"
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC030 = Profesión Cónyuge Aval"
''''    txtNomenclatura.Text = txtNomenclatura.Text & vbCrLf & "NMC031 = R.U.T. N° Cónyuge Aval"
    txtNomenclatura2.Text = txtNomenclatura.Text
    bTexto = True
End Sub

Private Function ValidaCodigoClau(nCodClausula As String) As Boolean
    Dim Datos()
    Dim iContador  As Integer
    Dim cTexto     As String
    Dim cProducto  As String
    
    ValidaCodigoClau = True
    
    Envia = Array()
    AddParam Envia, "U"
    AddParam Envia, Trim(Right(cmbSistema.Text, 4))
    AddParam Envia, ""
    AddParam Envia, ""
    AddParam Envia, Trim(nCodClausula)
    AddParam Envia, ""
    AddParam Envia, ""
    AddParam Envia, 0
    AddParam Envia, ""
    AddParam Envia, ""
    AddParam Envia, IIf(Chk_Clausula_activa.Value = 1, "S", "N")

    If Not Bac_Sql_Execute("sp_MntTblClausula", Envia) Then
        MsgBox "Error." & vbCrLf & "Codigo Cláusula No se pudo Validar.", vbExclamation, TITSISTEMA
        ValidaCodigoClau = False
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) = 1 Then
            MsgBox "Código Cláusula, """ & nCodClausula & """, ya existe.", vbExclamation, TITSISTEMA
            ValidaCodigoClau = False
            Exit Function
        End If
    End If
End Function

Private Function GrabaClausula(nCodClausula As String) As Boolean
    Dim Datos()
    Dim iContador  As Integer
    Dim cTexto     As String
    Dim cProducto  As String
    
    GrabaClausula = True
    
    Envia = Array()
    AddParam Envia, "I"
    AddParam Envia, Trim(Right(cmbSistema.Text, 4))
    AddParam Envia, Trim(Right(cmdTipoContrato.Text, 5))
    AddParam Envia, Trim(txtMarcador.Text)
    AddParam Envia, Trim(nCodClausula)
    AddParam Envia, Trim(txtGlosa1.Text)
    AddParam Envia, Glosa2.Text
    AddParam Envia, txtIndiceOrden.Text
    AddParam Envia, Mid(cmbDefault.Text, 1, 1)
    AddParam Envia, IIf(chkUtilizaAval.Value = 1, "S", "N")
    AddParam Envia, IIf(Chk_Clausula_activa.Value = 1, "S", "N")

    If Not Bac_Sql_Execute("sp_MntTblClausula", Envia) Then
        MsgBox "Error." & vbCrLf & "Cláusula No se pudo Grabar.", vbCritical, TITSISTEMA
        GrabaClausula = False
        Exit Function
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) = "OK" Then
            MsgBox "OK." & vbCrLf & "Cláusula Grabada Correctamente.", vbInformation, TITSISTEMA
            GrabaClausula = True
            Call LimpiarPantalla
        Else
            MsgBox "Error." & vbCrLf & "Al Grabar Cláusula.", vbCritical, TITSISTEMA
            GrabaClausula = False
        End If
    End If
End Function

Private Function ValidaGlosa1(sGlosa1 As String) As Boolean
    Dim Datos()
    Dim iContador  As Integer
    Dim cTexto     As String
    Dim cProducto  As String
    
    ValidaGlosa1 = True
    
    Envia = Array()
    AddParam Envia, "G"
    AddParam Envia, Trim(Right(cmbSistema.Text, 4))
    AddParam Envia, ""
    AddParam Envia, ""
    AddParam Envia, ""
    AddParam Envia, Trim(txtGlosa1.Text)
    AddParam Envia, ""
    AddParam Envia, 0
    AddParam Envia, ""
    AddParam Envia, ""
    AddParam Envia, IIf(Chk_Clausula_activa.Value = 1, "S", "N")

    If Not Bac_Sql_Execute("sp_MntTblClausula", Envia) Then
        MsgBox "Error." & vbCrLf & "Codigo Glosa1 No se pudo Validar.", vbCritical, TITSISTEMA
        ValidaGlosa1 = False
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) = "1" Then
            MsgBox Label1(2).Caption & sGlosa1 & """ ya existe.", vbCritical, TITSISTEMA
            ValidaGlosa1 = False
            txtGlosa1.SetFocus
            Exit Function
        End If
    End If
    
End Function

Private Function ValidaDatos() As Boolean

    ValidaDatos = False
    If cmbSistema.Text = "" Then
        MsgBox "Debe seleccionar " & Label1(5).Caption, vbExclamation, TITSISTEMA
        cmbSistema.SetFocus
        Exit Function
    End If
    If cmdTipoContrato.Text = "" Then
        MsgBox "Debe seleccionar " & Label1(6).Caption, vbExclamation, TITSISTEMA
        cmdTipoContrato.SetFocus
        Exit Function
    End If
    If txtMarcador.Text = "" Then
        MsgBox "Debe seleccionar " & Label1(1).Caption, vbExclamation, TITSISTEMA
        txtMarcador.SetFocus
        Exit Function
    End If
    If Glosa2.Text = "" Then
        MsgBox "Debe Ingresar " & Label1(3).Caption, vbExclamation, TITSISTEMA
        Glosa2.SetFocus
        Exit Function
    End If
    
    If cmbDefault.Text = "" Then
        MsgBox "Debe seleccionar " & Label1(7).Caption, vbExclamation, TITSISTEMA
        cmbDefault.SetFocus
        Exit Function
    End If

    ValidaDatos = True
End Function

Sub LimpiarPantalla()

    Screen.MousePointer = vbHourglass

    txtNomenclatura.Visible = False
    txtCodClausula.Text = ""
   
    Call CargaTipContrato(cmdTipoContrato)
    
    txtGlosa1.Text = ""
    Glosa2.Text = ""
    txtIndiceOrden.Text = 0
    txtMarcador.Text = ""
    cmbDefault.ListIndex = 0
    chkUtilizaAval.Value = 0
    
    cmbSistema.Enabled = True
    cmdTipoContrato.Enabled = True
    txtCodClausula.Enabled = True
            
    txtMarcador.Enabled = False
    txtIndiceOrden.Enabled = False
    txtGlosa1.Enabled = False
    Glosa2.Enabled = False
    cmbDefault.Enabled = False
    chkUtilizaAval.Enabled = False
    Chk_Clausula_activa.Enabled = False
    
    cmdNomenclatura.Enabled = False
        
    cmbSistema.ListIndex = -1
    cmdTipoContrato.ListIndex = -1
    cmbDefault.ListIndex = 0
    
    If Me.Visible = True And cmbSistema.Enabled = True Then
      cmbSistema.SetFocus
    End If
    
    txtNomenclatura.Top = 20000
    
    Screen.MousePointer = vbDefault
    
End Sub

Private Sub txtIndiceOrden_KeyPress(KeyAscii As Integer)
    If KeyAscii = vbKeyReturn Then
        SendKeys "{tab}"
    End If
End Sub

Private Sub txtMarcador_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = vbKeyReturn Then
      SendKeys "{tab}"
   End If
    
   If KeyAscii >= Asc("a") And KeyAscii <= Asc("z") Then
      KeyAscii = KeyAscii - 32
   End If
    
End Sub

Private Sub txtNomenclatura_Change()
    If txtNomenclatura.Text <> txtNomenclatura2.Text And bTexto Then
        txtNomenclatura.Text = txtNomenclatura2.Text
        MsgBox "No se puede modificar el Texto", vbCritical, TITSISTEMA
    End If
End Sub
    
'Public Function CargaTipContrato(COMBO As ComboBox)
'    Dim DATOS()
'
'    If Not Bac_Sql_Execute("sp_TraeContrato") Then
'        MsgBox "Problemas al Intentar llanar el combo", vbExclamation + vbOKOnly
'        Exit Function
'    End If
'
'    cmdTipoContrato.Clear
'
'    Do While Bac_SQL_Fetch(DATOS())
'        cmdTipoContrato.AddItem DATOS(2) & Space(80) & DATOS(1)
'    Loop
'
'    If cmdTipoContrato.ListCount > 0 Then
'        cmdTipoContrato.ListIndex = -1
'    End If
'End Function

Private Sub txtNomenclatura_DblClick()
Dim nLargo As Long
Dim sLargo  As String

    If Len(Glosa2.Text) > 0 Then
        nLargo = Glosa2.SelStart + 1
        sLargo = Left(Glosa2.Text, nLargo)
        Glosa2.Text = Mid(Glosa2.Text, nLargo)
        Glosa2.Text = sLargo & txtNomenclatura.SelText & Trim(Glosa2.Text)
        Glosa2.SetFocus
    Else
        Glosa2.Text = txtNomenclatura.SelText
        Glosa2.SetFocus
    End If
        txtNomenclatura.Visible = False
End Sub

Private Sub txtNomenclatura_KeyDown(KeyCode As Integer, Shift As Integer)
   
    If KeyCode = vbKeyEscape Then
        If txtNomenclatura.Visible = True Then
            txtNomenclatura.Visible = False
            Exit Sub
        End If
    End If
End Sub

