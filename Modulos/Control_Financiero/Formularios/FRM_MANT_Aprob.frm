VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FrmManAprobaciones 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Atribuciones de Usuarios"
   ClientHeight    =   3420
   ClientLeft      =   2145
   ClientTop       =   3000
   ClientWidth     =   7440
   Icon            =   "FRM_MANT_Aprob.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3420
   ScaleWidth      =   7440
   Begin Threed.SSFrame SSFrame1 
      Height          =   2970
      Left            =   -15
      TabIndex        =   0
      Top             =   450
      Width           =   7455
      _Version        =   65536
      _ExtentX        =   13150
      _ExtentY        =   5239
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
      Begin VB.ComboBox CMB_BloqClt 
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
         Left            =   6120
         Style           =   2  'Dropdown List
         TabIndex        =   17
         Top             =   2610
         Width           =   1260
      End
      Begin VB.ComboBox CMB_LimPrecios 
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
         Left            =   6120
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   2970
         Width           =   1260
      End
      Begin BACControles.TXTNumero Txt_Monto 
         Height          =   255
         Left            =   5400
         TabIndex        =   14
         Top             =   960
         Width           =   1935
         _ExtentX        =   3413
         _ExtentY        =   450
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
      Begin Threed.SSFrame SSFrame2 
         Height          =   30
         Left            =   0
         TabIndex        =   13
         Top             =   1320
         Width           =   7455
         _Version        =   65536
         _ExtentX        =   13150
         _ExtentY        =   53
         _StockProps     =   14
         Caption         =   "SSFrame2"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.ComboBox CMB_Global 
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
         Left            =   6120
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   2250
         Width           =   1260
      End
      Begin VB.ComboBox CMB_Tasas 
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
         Left            =   6120
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   1890
         Width           =   1260
      End
      Begin VB.ComboBox CMB_Operador 
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
         Left            =   6120
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   1530
         Width           =   1260
      End
      Begin VB.ComboBox CMB_Lineas 
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
         Left            =   6030
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   600
         Width           =   1320
      End
      Begin VB.ComboBox cmbTipOpe 
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
         Left            =   3990
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   240
         Width           =   3375
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "Desbloquea Clientes por Producto"
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
         Left            =   105
         TabIndex        =   18
         Top             =   2685
         Width           =   2910
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Aprueba Exceso de Límites de Precios"
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
         Left            =   105
         TabIndex        =   16
         Top             =   3030
         Width           =   3300
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Monto Máximo de Exceso de Línea a Aprobar"
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
         TabIndex        =   12
         Top             =   975
         Width           =   3885
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Aprueba Exceso de Limites Globales "
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
         TabIndex        =   6
         Top             =   2280
         Width           =   3165
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Aprueba Exceso de Limites de Tasas de Operaciones "
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
         TabIndex        =   5
         Top             =   1920
         Width           =   4605
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Aprueba Exceso de Atribuciones por Operador "
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
         TabIndex        =   4
         Top             =   1560
         Width           =   4005
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Aprueba Exceso de Líneas"
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
         Left            =   90
         TabIndex        =   3
         Top             =   540
         Width           =   2310
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Usuario"
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
         TabIndex        =   2
         Top             =   210
         Width           =   660
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   11
      Top             =   0
      Width           =   7440
      _ExtentX        =   13123
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
            Object.Visible         =   0   'False
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
      MouseIcon       =   "FRM_MANT_Aprob.frx":000C
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
            Picture         =   "FRM_MANT_Aprob.frx":0326
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MANT_Aprob.frx":1200
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MANT_Aprob.frx":20DA
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MANT_Aprob.frx":2FB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MANT_Aprob.frx":3E8E
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FrmManAprobaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim datos()

Private Function FUNC_Valida() As Boolean
    Select Case modoOperacionCPT
        Case "N"
            If cmbTipOpe.ListIndex = -1 Or _
               CMB_Lineas.ListIndex = -1 Or _
               CMB_Operador.ListIndex = -1 Or _
               CMB_Tasas.ListIndex = -1 Or _
               CMB_Global.ListIndex = -1 Or _
               CMB_LimPrecios.ListIndex = -1 Or _
               CMB_BloqClt.ListIndex = -1 Then
               FUNC_Valida = False
               Exit Function
            End If
        Case "S"
            If cmbTipOpe.ListIndex = -1 Or _
               CMB_Lineas.ListIndex = -1 Or _
               CMB_Operador.ListIndex = -1 Or _
               CMB_Tasas.ListIndex = -1 Or _
               CMB_Global.ListIndex = -1 Or _
               CMB_BloqClt.ListIndex = -1 Then
               FUNC_Valida = False
               Exit Function
            End If
    End Select

                
FUNC_Valida = True

End Function

Private Function FUNC_Grabar() As Boolean
    
    FUNC_Grabar = False
    
    Envia = Array()
    AddParam Envia, Trim(Right(cmbTipOpe, 15))
    AddParam Envia, CDbl(Txt_Monto.Text)
    AddParam Envia, CMB_Lineas.ItemData(CMB_Lineas.ListIndex)
    AddParam Envia, CMB_Operador.ItemData(CMB_Operador.ListIndex)
    AddParam Envia, CMB_Tasas.ItemData(CMB_Tasas.ListIndex)
    AddParam Envia, CMB_Global.ItemData(CMB_Global.ListIndex)
    If modoOperacionCPT = "N" Then
        AddParam Envia, CMB_LimPrecios.ItemData(CMB_LimPrecios.ListIndex)    'nuevo campo en la tabla
    Else
        AddParam Envia, 1
    End If
    AddParam Envia, CMB_BloqClt.ItemData(CMB_BloqClt.ListIndex)     'Campo nuevo PRD-6066
    
    If Bac_Sql_Execute("SP_ACT_MATRIZ_ATRIBUCION", Envia) Then
        MsgBox "Datos Grabados Sin Problemas", vbInformation, TITSISTEMA
        FUNC_Grabar = True
    Else
        MsgBox "Problemas al Grabar Operación", vbCritical, TITSISTEMA
    End If
   
End Function

Private Function FUNC_BuscaDatos()

    If cmbTipOpe.ListIndex = -1 Then Exit Function
    
    Envia = Array()
    AddParam Envia, Trim(Right(cmbTipOpe, 15))
    
    If Bac_Sql_Execute("SP_CON_MATRIZ_ATRIBUCION", Envia) Then
        'Limpiar los combos
            CMB_Lineas.ListIndex = -1
            CMB_Operador.ListIndex = -1
            CMB_Tasas.ListIndex = -1
            CMB_Global.ListIndex = -1
            CMB_LimPrecios.ListIndex = -1
            CMB_BloqClt.ListIndex = -1
            Txt_Monto.Text = 0
        If Bac_SQL_Fetch(datos()) Then
            CMB_Lineas.ListIndex = (Val(datos(3)))
            CMB_Operador.ListIndex = (Val(datos(4)))
            CMB_Tasas.ListIndex = (Val(datos(5)))
            CMB_Global.ListIndex = (Val(datos(6)))
            CMB_LimPrecios.ListIndex = (Val(datos(7)))
            CMB_BloqClt.ListIndex = Val(datos(8))  'Campo nuevo en tabla
            Txt_Monto.Text = CDbl(datos(2))
        End If
    
    End If
   
End Function

Private Sub CargaSINO(oObj As Object)
    oObj.AddItem "SI"
    oObj.ItemData(oObj.NewIndex) = 0
    oObj.AddItem "NO"
    oObj.ItemData(oObj.NewIndex) = 1

End Sub

Private Sub CargarCombos()
Dim datos()
    cmbTipOpe.Clear
    CMB_Global.Clear
    CMB_Lineas.Clear
    CMB_Operador.Clear
    CMB_Tasas.Clear
    CMB_LimPrecios.Clear
    CMB_BloqClt.Clear
    Txt_Monto.Text = 0
    
    If Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_LEEGENUSUARIO") Then
        Do While Bac_SQL_Fetch(datos())
            cmbTipOpe.AddItem (datos(2) & Space(100) & datos(1))
        Loop
    End If
         
   cmbTipOpe.Enabled = True
   CargaSINO CMB_Global
   CargaSINO CMB_Lineas
   CargaSINO CMB_Operador
   CargaSINO CMB_Tasas
   CargaSINO CMB_LimPrecios
   CargaSINO CMB_BloqClt
   Txt_Monto.Text = 0
         
End Sub

Private Sub cmbTipOpe_Click()
    Toolbar1.Buttons(4).Enabled = True
    Toolbar1.Buttons(2).Enabled = True
    Call FUNC_BuscaDatos
End Sub

Private Sub Form_Load()
   Me.Icon = BacControlFinanciero.Icon
   Me.Left = 0:   Me.top = 0
   Call ConsultaModoOperacionControlPT
   If modoOperacionCPT = "N" Then
        Label7.Visible = True
        SSFrame1.Height = 3375
        Me.Height = 4215
   Else
        Label7.Visible = False
        SSFrame1.Height = 2970
        Me.Height = 3825
   End If
   CargarCombos
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        
            Case 2
            
                If FUNC_Valida Then
                
                    If FUNC_Grabar Then
                       CargarCombos
                    End If
                    
                End If
                
            Case 1
                Toolbar1.Buttons(2).Enabled = False
                Toolbar1.Buttons(4).Enabled = False
                CargarCombos
                
            Case 4
                 Call FUNC_BuscaDatos
                 
            Case 5
                Unload Me
            
    End Select

End Sub
