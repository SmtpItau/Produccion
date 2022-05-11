VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form FrmGlosaPosicion 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Glosa Posicion Grupal"
   ClientHeight    =   2340
   ClientLeft      =   2700
   ClientTop       =   2775
   ClientWidth     =   7005
   Icon            =   "FrmGlosaPosicion.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2340
   ScaleWidth      =   7005
   Begin VB.ComboBox CmbMonCon 
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
      Left            =   1020
      Style           =   2  'Dropdown List
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   2400
      Width           =   4800
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   1770
      Left            =   0
      TabIndex        =   1
      Top             =   495
      Width           =   7005
      _Version        =   65536
      _ExtentX        =   12356
      _ExtentY        =   3122
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   2
      ShadowStyle     =   1
      Begin VB.ComboBox CmbModulo 
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
         Left            =   960
         Style           =   2  'Dropdown List
         TabIndex        =   8
         TabStop         =   0   'False
         Top             =   1080
         Width           =   4800
      End
      Begin BACControles.TXTNumero TxtCodigo 
         Height          =   300
         Left            =   960
         TabIndex        =   5
         Top             =   240
         Width           =   2000
         _ExtentX        =   3519
         _ExtentY        =   529
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.TextBox TxtGlosa 
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
         Left            =   960
         TabIndex        =   0
         Top             =   660
         Width           =   5895
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Módulo"
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
         TabIndex        =   9
         Top             =   1125
         Width           =   630
      End
      Begin VB.Label LblCodigo 
         AutoSize        =   -1  'True
         Caption         =   "Codigo"
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
         TabIndex        =   3
         Top             =   270
         Width           =   600
      End
      Begin VB.Label LblGlosa 
         AutoSize        =   -1  'True
         Caption         =   "Glosa"
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
         TabIndex        =   2
         Top             =   720
         Width           =   495
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   7005
      _ExtentX        =   12356
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   8
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu4 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu5 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu6 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu7 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu8 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "FrmGlosaPosicion.frx":000C
      OLEDropMode     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8520
      Top             =   660
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmGlosaPosicion.frx":0326
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmGlosaPosicion.frx":1200
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmGlosaPosicion.frx":20DA
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmGlosaPosicion.frx":2FB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmGlosaPosicion.frx":3E8E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Moneda"
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
      Left            =   120
      TabIndex        =   7
      Top             =   2445
      Width           =   690
   End
End
Attribute VB_Name = "FrmGlosaPosicion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub CmbModulo_Click()
    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(3).Enabled = True
End Sub

Private Sub CmbModulo_Change()
    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(3).Enabled = True
End Sub

Private Sub CmbModulo_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If TxtCodigo.Text <> "" Then
            TxtCodigo.SetFocus
            Toolbar1.Buttons(2).Enabled = True
            Toolbar1.Buttons(3).Enabled = True
        End If
    End If
End Sub

Private Sub Form_Load()
   Me.Top = 0
   Me.Left = 0

   Me.Icon = Acceso_Usuario.Icon
   Call Limpiar
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 2
             If Verificacion = True Then Call Grabar
        Case 3
             Call Eliminar
        Case 1
             Call Limpiar
             TxtCodigo.Enabled = True
             TxtCodigo.SetFocus
        Case 4
             Call Buscar
        Case 5
             Unload Me
    End Select

End Sub

Private Sub TxtCodigo_DblClick()
    BacAyuda.Tag = "PosGrupal"
    BacAyuda.Show 1
    If giAceptar = True Then
        TxtCodigo.Text = RetornoAyuda
        Call Buscar
    End If
    Toolbar1.Buttons(1).Enabled = True
End Sub

Private Sub TxtCodigo_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If TxtCodigo.Text <> "" Then
            Call Buscar
            TxtGlosa.Enabled = True
            TxtGlosa.SetFocus
        End If
    End If
End Sub



Private Function Limpiar()
    Dim Datos()
    
    TxtCodigo.Text = 0
    TxtGlosa.Text = ""
    CmbModulo.Enabled = True
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(4).Enabled = True
    
    Envia = Array()
    Envia = Array("4")
    If Not Bac_Sql_Execute("SP_BUSCA_DATOS_OPCIONALES", Envia) Then
      MsgBox "No se puede Mostrar", vbCritical, TITSISTEMA
      Exit Function
    End If
   
    CmbModulo.Clear
    Do While Bac_SQL_Fetch(Datos())
      CmbModulo.AddItem (Datos(1) & Space(100) & Datos(2))
    Loop
    
    CmbModulo.ListIndex = -1
    

End Function

Private Function Grabar()

    Envia = Array()
    AddParam Envia, "I"
    AddParam Envia, Trim(Format(TxtCodigo.Text, "00"))
    AddParam Envia, Trim(TxtGlosa.Text)
    AddParam Envia, Right(CmbModulo.Text, 3)
    If Not Bac_Sql_Execute("SP_MTN_GLOSA_GRUPAL_POSICION", Envia) Then
        MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    MsgBox "La grabacion de los datos fue correcta", vbInformation, TITSISTEMA

    Call Limpiar
    TxtCodigo.Enabled = True
    TxtCodigo.SetFocus
End Function

Private Function Eliminar()

Dim Datos()


    Envia = Array()
    AddParam Envia, "B"
    AddParam Envia, Format(TxtCodigo.Text, "00")
    AddParam Envia, Right(CmbModulo.Text, 3)
    If Not Bac_Sql_Execute("SP_MTN_DETALLE_GRUPAL", Envia) Then
        MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
        Exit Function
        
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        If Datos(1) <> "NO" Then
            MsgBox "Existen Registros Relacionados con Detalle Grupal", vbCritical, TITSISTEMA
            If MsgBox("¿ Esta seguro que desea Eliminar ?", vbYesNo + vbQuestion, TITSISTEMA) = vbNo Then
                Exit Function
                
            Else
                Exit Do
            End If
            Exit Function
            
        End If
    Loop
    
    Envia = Array()
    AddParam Envia, "E"
    AddParam Envia, Format(TxtCodigo.Text, "00")
    If Not Bac_Sql_Execute("SP_MTN_GLOSA_GRUPAL_POSICION", Envia) Then
        MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    MsgBox "La eliminacion fue correcta", vbInformation, TITSISTEMA

    Call Limpiar
    TxtCodigo.SetFocus
End Function

Private Function Buscar()
    Dim Datos()
    
    TxtGlosa.Text = ""
    
    Envia = Array()
    AddParam Envia, "B"
    AddParam Envia, Format(TxtCodigo.Text, "00")
    If Not Bac_Sql_Execute("SP_MTN_GLOSA_GRUPAL_POSICION", Envia) Then
        MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        TxtGlosa.Text = Datos(2)
        For a = 1 To CmbModulo.ListCount - 1
         CmbModulo.ListIndex = a
         If Right(CmbModulo.Text, 3) = Datos(3) Then
            CmbModulo.ListIndex = a
            Exit For
         End If
        Next a
        TxtCodigo.Enabled = False
        CmbModulo.Enabled = False
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
    Loop
    
End Function

Private Function Verificacion() As Boolean
  Verificacion = False
    If TxtCodigo.Text <> "" And TxtGlosa.Text <> "" Then
        Verificacion = True
    End If
  If Verificacion = False Then MsgBox "faltan datos para seguir con el proceso", vbExclamation, TITSISTEMA
End Function

Private Sub TxtGlosa_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If TxtGlosa.Text <> "" Then
            CmbModulo.Enabled = True
            CmbModulo.SetFocus
        End If
    End If
End Sub
