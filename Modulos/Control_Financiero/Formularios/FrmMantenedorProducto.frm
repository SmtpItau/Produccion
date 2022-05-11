VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form FrmMantenedorProducto 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor de Productos"
   ClientHeight    =   2055
   ClientLeft      =   3015
   ClientTop       =   2310
   ClientWidth     =   5580
   Icon            =   "FrmMantenedorProducto.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2055
   ScaleWidth      =   5580
   ShowInTaskbar   =   0   'False
   Begin Threed.SSFrame SSFrame1 
      Height          =   1530
      Left            =   30
      TabIndex        =   4
      Top             =   510
      Width           =   5535
      _Version        =   65536
      _ExtentX        =   9763
      _ExtentY        =   2699
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
      Begin Threed.SSCheck Opcion_1 
         Height          =   225
         Left            =   270
         TabIndex        =   2
         Top             =   1140
         Width           =   1620
         _Version        =   65536
         _ExtentX        =   2857
         _ExtentY        =   397
         _StockProps     =   78
         Caption         =   "Control Moneda"
         ForeColor       =   8388608
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
      Begin VB.ComboBox cmbPro 
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
         Left            =   915
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   660
         Width           =   4515
      End
      Begin VB.ComboBox CmbSistema 
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
         Left            =   915
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   300
         Width           =   4515
      End
      Begin Threed.SSCheck Opcion_2 
         Height          =   225
         Left            =   3300
         TabIndex        =   3
         Top             =   1125
         Width           =   1980
         _Version        =   65536
         _ExtentX        =   3492
         _ExtentY        =   397
         _StockProps     =   78
         Caption         =   "Control Forma Pago"
         ForeColor       =   8388608
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
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Producto"
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
         TabIndex        =   6
         Top             =   660
         Width           =   780
      End
      Begin VB.Label Label4 
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
         TabIndex        =   5
         Top             =   300
         Width           =   630
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   5580
      _ExtentX        =   9843
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
      MouseIcon       =   "FrmMantenedorProducto.frx":000C
      OLEDropMode     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8490
      Top             =   690
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
            Picture         =   "FrmMantenedorProducto.frx":0326
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMantenedorProducto.frx":1200
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMantenedorProducto.frx":20DA
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMantenedorProducto.frx":2FB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmMantenedorProducto.frx":3E8E
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FrmMantenedorProducto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
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
             CmbSistema.SetFocus
        Case 4
             If Verificacion = True Then Call Buscar
        Case 5
             Unload Me
    End Select

End Sub

Private Sub CmbSistema_Click()
    Call CargarCombosProducto
End Sub

Private Sub cmbPro_Click()
    Toolbar1.Buttons(4).Enabled = True
    Call Buscar
    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(3).Enabled = True
End Sub

Private Function CargarCombosSistema()
    Dim Datos()
    'Sp_CmbSistema2
    If Bac_Sql_Execute("SP_LEER_SISTAMA_CNT") Then
      Do While Bac_SQL_Fetch(Datos())
         CmbSistema.AddItem Datos(2) & Space(150) & Datos(1)
      Loop
   End If
   
End Function
    
Private Function CargarCombosProducto()
    Dim Datos()
    
    Envia = Array()
    AddParam Envia, Trim(Right(CmbSistema.Text, 3))
    If Not Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_LEEPRODUCTO", Envia) Then
        MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    cmbPro.Enabled = True
    cmbPro.Clear
    
    Do While Bac_SQL_Fetch(Datos())
        Espacio0 = 50 - Len(Datos(2))
        Espacio1 = 150 - Len(Datos(1))
        cmbPro.AddItem (Datos(2) & Space(Espacio1) & Datos(1))
    Loop

End Function

Private Function Limpiar()
    CmbSistema.Clear
    cmbPro.Clear
    Call CargarCombosSistema
    Opcion_1.Value = False
    Opcion_2.Value = False
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(4).Enabled = False
End Function

Private Function Grabar()

    Envia = Array()
    AddParam Envia, "1"
    AddParam Envia, Trim(Right(CmbSistema.Text, 3))
    AddParam Envia, Trim(Right(cmbPro.Text, 5))
    AddParam Envia, Trim(Mid(cmbPro.Text, 1, 50))
    AddParam Envia, IIf(Opcion_1.Value = True, 1, 0)
    AddParam Envia, IIf(Opcion_2.Value = True, 1, 0)
    If Not Bac_Sql_Execute("SP_MTN_PRODUCTO_SISTEMA", Envia) Then
        MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    MsgBox "La grabacion de los datos fue correcta", vbInformation, TITSISTEMA

    Call Limpiar
    CmbSistema.SetFocus
End Function

Private Function Eliminar()

    Envia = Array()
    AddParam Envia, "2"
    AddParam Envia, Trim(Right(CmbSistema.Text, 3))
    AddParam Envia, Trim(Right(cmbPro.Text, 5))
    If Not Bac_Sql_Execute("SP_MTN_PRODUCTO_SISTEMA", Envia) Then
        MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    MsgBox "La eliminacion fue correcta", vbInformation, TITSISTEMA

    Call Limpiar
    CmbSistema.SetFocus
End Function

Private Function Buscar()
    Dim Datos()
        
    Envia = Array()
    AddParam Envia, "3"
    AddParam Envia, Trim(Right(CmbSistema.Text, 3))
    AddParam Envia, Trim(Right(cmbPro.Text, 5))
    If Not Bac_Sql_Execute("SP_MTN_PRODUCTO_SISTEMA", Envia) Then
        MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
        Exit Function
    End If
        Opcion_1.Value = False
        Opcion_2.Value = False
    Do While Bac_SQL_Fetch(Datos())
        Opcion_1.Value = IIf(Datos(1) = 0, False, True)
        Opcion_2.Value = IIf(Datos(2) = 0, False, True)
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
    Loop
    
End Function

Private Function Verificacion() As Boolean
  Verificacion = False
    If CmbSistema.Text <> "" And cmbPro.Text <> "" Then
        Verificacion = True
    End If
  If Verificacion = False Then MsgBox "faltan datos para seguir con el proceso", vbExclamation, TITSISTEMA
End Function
