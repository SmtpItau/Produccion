VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form Crea_Usuarios 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Usuarios"
   ClientHeight    =   4335
   ClientLeft      =   3495
   ClientTop       =   2820
   ClientWidth     =   6855
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Crea_Usuarios.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4335
   ScaleWidth      =   6855
   Begin VB.Frame Frm_usuario 
      Height          =   900
      Left            =   45
      TabIndex        =   14
      Top             =   510
      Width           =   6750
      Begin VB.ComboBox Cmb_usuario 
         Appearance      =   0  'Flat
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
         Left            =   1650
         TabIndex        =   0
         Text            =   "Cmb_usuario"
         Top             =   360
         Width           =   2415
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Usuario"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   870
         TabIndex        =   15
         Top             =   405
         Width           =   630
      End
   End
   Begin MSComctlLib.Toolbar Tool_opciones 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   13
      Top             =   0
      Width           =   6855
      _ExtentX        =   12091
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpia"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Graba"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Elimina"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame frm_detalle 
      Height          =   2910
      Left            =   45
      TabIndex        =   16
      Top             =   1365
      Width           =   6750
      _Version        =   65536
      _ExtentX        =   11906
      _ExtentY        =   5133
      _StockProps     =   14
      Caption         =   "Datos Usuario"
      ForeColor       =   -2147483641
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   1
      Begin VB.CheckBox Chk_DatatecOTC 
         Height          =   195
         Left            =   5325
         TabIndex        =   12
         Top             =   2265
         Visible         =   0   'False
         Width           =   240
      End
      Begin VB.TextBox txt_email 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1620
         MaxLength       =   100
         TabIndex        =   7
         Top             =   2520
         Width           =   5055
      End
      Begin VB.CheckBox Check1 
         Caption         =   "¿Cambiar clave?"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Left            =   1650
         TabIndex        =   28
         TabStop         =   0   'False
         Top             =   1620
         Width           =   2010
      End
      Begin VB.ComboBox CmbArea 
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
         Left            =   5325
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   930
         Visible         =   0   'False
         Width           =   1365
      End
      Begin VB.ComboBox CmbClase 
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
         ItemData        =   "Crea_Usuarios.frx":2EFA
         Left            =   5325
         List            =   "Crea_Usuarios.frx":2F13
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   1260
         Visible         =   0   'False
         Width           =   1365
      End
      Begin BACControles.TXTFecha Msk_fecha_expira 
         Height          =   315
         Left            =   5325
         TabIndex        =   10
         Top             =   1590
         Width           =   1365
         _ExtentX        =   2408
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         MaxDate         =   402133
         MinDate         =   18264
         Text            =   "02/05/2001"
      End
      Begin BACControles.TXTNumero TxtLargClave 
         Height          =   285
         Left            =   1650
         TabIndex        =   4
         Top             =   1275
         Width           =   990
         _ExtentX        =   1746
         _ExtentY        =   503
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
         Text            =   "4"
         Text            =   "4"
         Min             =   "0"
         Max             =   "10"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TxtDiasExp 
         Height          =   300
         Left            =   5325
         TabIndex        =   11
         Top             =   1920
         Width           =   990
         _ExtentX        =   1746
         _ExtentY        =   529
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
         Text            =   "0"
         Text            =   "0"
         Min             =   "-10000"
         Max             =   "99999"
         Separator       =   -1  'True
      End
      Begin VB.ComboBox CmbTipoClave 
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
         Left            =   1650
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   945
         Width           =   1830
      End
      Begin VB.TextBox Txt_nombre 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   1650
         TabIndex        =   1
         Top             =   300
         Width           =   5040
      End
      Begin VB.ComboBox Cmb_tipo_usuario 
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
         Left            =   1650
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   615
         Width           =   2625
      End
      Begin VB.TextBox Txt_clave 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         IMEMode         =   3  'DISABLE
         Left            =   1620
         MaxLength       =   15
         PasswordChar    =   "*"
         TabIndex        =   5
         Top             =   1890
         Width           =   1590
      End
      Begin VB.TextBox Txt_confirma_clave 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         IMEMode         =   3  'DISABLE
         Left            =   1620
         MaxLength       =   15
         PasswordChar    =   "*"
         TabIndex        =   6
         Top             =   2205
         Width           =   1590
      End
      Begin VB.Label Label12 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Genera DATATEC"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   3855
         TabIndex        =   30
         Top             =   2250
         Visible         =   0   'False
         Width           =   1410
      End
      Begin VB.Label Label11 
         AutoSize        =   -1  'True
         Caption         =   "E-Mail"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   990
         TabIndex        =   29
         Top             =   2550
         Width           =   1200
      End
      Begin VB.Label Label10 
         Caption         =   "Area Producto"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   225
         Left            =   4050
         TabIndex        =   27
         Top             =   975
         Visible         =   0   'False
         Width           =   1470
      End
      Begin VB.Label Label8 
         Caption         =   "Categoria de Operador"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   255
         Left            =   3375
         TabIndex        =   25
         Top             =   1320
         Visible         =   0   'False
         Width           =   1920
      End
      Begin VB.Label Label9 
         BackStyle       =   0  'Transparent
         Caption         =   "Dias de Expiración"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   270
         Left            =   3765
         TabIndex        =   24
         Top             =   1935
         Width           =   1575
      End
      Begin VB.Label TxtLargoClave 
         Caption         =   "Largo Minimo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   240
         Left            =   360
         TabIndex        =   23
         Top             =   1320
         Width           =   2145
      End
      Begin VB.Label Label7 
         Caption         =   "Tipo de Clave"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   225
         Left            =   390
         TabIndex        =   22
         Top             =   990
         Width           =   1320
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Nombre Usuario"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   210
         TabIndex        =   21
         Top             =   330
         Width           =   1335
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Usuario"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   465
         TabIndex        =   20
         Top             =   660
         Width           =   1035
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Clave"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   1050
         TabIndex        =   19
         Top             =   1935
         Width           =   450
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Expiración"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   3870
         TabIndex        =   18
         Top             =   1635
         Width           =   1365
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Confirma Clave"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   255
         TabIndex        =   17
         Top             =   2250
         Width           =   1260
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3840
      Left            =   0
      TabIndex        =   26
      Top             =   495
      Width           =   6855
      _Version        =   65536
      _ExtentX        =   12091
      _ExtentY        =   6773
      _StockProps     =   15
      BackColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   1
   End
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   0
      Top             =   0
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
            Picture         =   "Crea_Usuarios.frx":2F2C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Crea_Usuarios.frx":3393
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Crea_Usuarios.frx":3889
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Crea_Usuarios.frx":3D1C
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Crea_Usuarios.frx":4204
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Crea_Usuarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim OptLocal As String
Dim Datos()
Dim sCadena             As String
Dim nCaracter           As Integer
Dim objCreaUusarios     As Object
Public objCreaUsuarios  As New clsCreaUsuarios
Dim FechaProceso        As String
Dim Clave1              As String
Dim Clave2              As String

Function FUNC_BORRA_USUARIO()

FUNC_BORRA_USUARIO = False

Envia = Array("E", Cmb_usuario.Text, "", "", "", "", "", 0, 0, "", "", "")  '"SP_GRABA_USUARIOS "

If Not BAC_SQL_EXECUTE("SP_CREA_USUARIOS_GRABA ", Envia) Then Exit Function

FUNC_BORRA_USUARIO = True

PROC_LIMPIA

End Function

Function PROC_ENTREGA_TIPO_USUARIO(Combo As Object, xTipo_usuario As String)
Combo.ListIndex = -1

For I% = 0 To Combo.ListCount - 1
    If Trim(Combo.List(I%)) = Trim(xTipo_usuario) Then
       Combo.ListIndex = I%
       Exit For
    End If
Next I%
End Function

Function FUNC_GRABA_USUARIO()

FUNC_GRABA_USUARIO = False

'If Not FUNC_BORRA_USUARIO() Then Exit Function

'Comando$ = "SP_GRABA_USUARIOS"

Envia = Array()

AddParam Envia, "G"
AddParam Envia, Cmb_usuario.Text
AddParam Envia, Encript(Txt_clave.Text, True)
AddParam Envia, Txt_nombre.Text
AddParam Envia, Cmb_tipo_usuario.Text
AddParam Envia, FUNC_FMT_FECHA(Msk_fecha_expira.Text)
AddParam Envia, left(CmbTipoClave.Text, 1)
AddParam Envia, CDbl(TxtDiasExp.Text)
AddParam Envia, CDbl(TxtLargClave.Text)
AddParam Envia, CmbClase.Text
AddParam Envia, CmbArea.Text
AddParam Envia, txt_email.Text
'AddParam Envia, Chk_DatatecOTC.Value

If Not BAC_SQL_EXECUTE("SP_CREA_USUARIOS_GRABA ", Envia) Then Exit Function

FUNC_GRABA_USUARIO = True
End Function
Function PROC_BUSCA_USUARIO() As Boolean
PROC_BUSCA_USUARIO = True
Envia = Array()

AddParam Envia, "B"
AddParam Envia, Cmb_usuario.Text
AddParam Envia, ""
AddParam Envia, ""
AddParam Envia, ""
AddParam Envia, ""
AddParam Envia, ""
'AddParam Envia, Chk_DatatecOTC.Value

'Envia = Array("B", Cmb_usuario.Text, "", "", "", "")

If Not BAC_SQL_EXECUTE("SP_GRABA_USUARIOS ", Envia) Then Exit Function

If BAC_SQL_FETCH(Datos) Then
   If Datos(1) = "NO ACTIVO" Then
      MsgBox Datos(2), vbInformation
      PROC_BUSCA_USUARIO = False
      Exit Function
   End If
   Txt_nombre.Text = Datos(1)
   txt_email.Text = Datos(7)
   
   '----------------------------------
   'EBQ: Control DATATEC/OTC
   
   'Chk_DatatecOTC.Value = Datos(8)
   '----------------------------------
   
   Msk_fecha_expira.Text = Datos(3)
   Clave1 = Encript((Datos(4)), False)
   Clave2 = Encript((Datos(4)), False)

   PROC_ENTREGA_TIPO_USUARIO Cmb_tipo_usuario, (Datos(2))
   
   Txt_clave.Text = Clave1
   Txt_confirma_clave.Text = Clave2
      
   On Error Resume Next
   CmbArea.Text = Datos(6)
   
   If Datos(5) <> "" Then CmbClase.Text = Datos(5)
   Tool_opciones.Buttons(3).Enabled = True
   
   Tool_opciones.Buttons(4).Enabled = Not Tool_opciones.Buttons(3).Enabled
   
End If

objCreaUsuarios.Busca_Tipo_Usuario Cmb_tipo_usuario
End Function

Sub PROC_LIMPIA()

   PROC_CARGA_USUARIO Cmb_usuario

   If BAC_SQL_EXECUTE("Sp_Acces_TraeFecha") Then
   
        If BAC_SQL_FETCH(Datos()) Then
        
            Msk_fecha_expira.Text = Datos(3)
            FechaProceso = Datos(2)
            Msk_fecha_expira.MinDate = Datos(3)
             
         End If
   
   End If
   
   Frm_usuario.Enabled = True
   frm_detalle.Enabled = False
   Tool_opciones.Buttons(2).Enabled = False
   Tool_opciones.Buttons(3).Enabled = False
   Tool_opciones.Buttons(4).Enabled = Not Tool_opciones.Buttons(3).Enabled

   Txt_clave.Text = ""
   Txt_confirma_clave.Text = ""
   Txt_nombre.Text = ""
   txt_email.Text = ""
   'Chk_DatatecOTC.Value = 0
   
   CmbClase.ListIndex = -1
   CmbArea.ListIndex = -1
   Cmb_tipo_usuario.ListIndex = -1
   CmbTipoClave.ListIndex = -1
   
   TxtLargClave.Text = 4
   TxtDiasExp.Text = DateDiff("d", FechaProceso, Msk_fecha_expira.Text)

End Sub

Private Sub Check1_Click()
   If Txt_clave.Enabled = False Then
      Txt_clave.Enabled = True
      Txt_confirma_clave.Enabled = True
      Txt_clave.Text = ""
      Txt_confirma_clave.Text = ""
   Else
      Txt_clave.Enabled = False
      Txt_confirma_clave.Enabled = False
      Txt_clave.Text = Clave1
      Txt_confirma_clave.Text = Clave1
   End If
End Sub

Private Sub Check1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
    If Me.Txt_clave.Enabled Then
      Me.Txt_clave.SetFocus
    Else
      Me.CmbArea.SetFocus
    End If
   
End If
End Sub

Private Sub Cmb_tipo_usuario_Change()
   If Not objCreaUsuarios.Busca_Tipo_Usuario(Cmb_tipo_usuario.Text) Then
      Exit Sub
   End If

   Busca_Opciones
   Txt_clave.Text = ""
   Txt_confirma_clave.Text = ""
End Sub

Private Sub Cmb_tipo_usuario_Click()
   If Not objCreaUsuarios.Busca_Tipo_Usuario(Cmb_tipo_usuario.Text) Then
      Exit Sub
   End If

   Busca_Opciones
   'Txt_clave.Text = ""
   'Txt_confirma_clave.Text = ""
End Sub

Private Sub Cmb_tipo_usuario_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then ''Msk_fecha_expira.SetFocus
      If Not objCreaUsuarios.Busca_Tipo_Usuario(Cmb_tipo_usuario.Text) Then
         Exit Sub
      End If

      Busca_Opciones
      
      If CmbTipoClave.Enabled Then
         CmbTipoClave.SetFocus
      End If
   End If
End Sub

Private Sub Cmb_usuario_Change()
      
   If Len(Cmb_usuario.Text) > 15 Then
      Cmb_usuario.Text = Mid(Cmb_usuario.Text, 1, 10)
   End If
End Sub


Private Sub Cmb_usuario_GotFocus()

   Clipboard.SetText UCase(Clipboard.GetText)

End Sub

Private Sub Cmb_usuario_KeyDown(KeyCode As Integer, Shift As Integer)

If KeyCode = 13 Then
'If Trim(Cmb_usuario.Text) <> "" Then Cmb_usuario_KeyPress 13

Txt_clave.Text = Clave1
Txt_confirma_clave.Text = Clave2
' Desabilitar el chetbox

' Verificar si hay realmente una clave
If Txt_clave.Text <> "" And Txt_confirma_clave.Text <> "" Then
   Check1.Value = 0
   Txt_clave.Enabled = False
   Txt_confirma_clave.Enabled = False
Else
   Check1.Value = 1
   Txt_clave.Enabled = True
   Txt_confirma_clave.Enabled = True
End If
End If
End Sub

Private Sub Cmb_usuario_KeyPress(KeyAscii As Integer)
'KeyAscii = LETRA_UPPER(KeyAscii)

   'Call BacToUCase(KeyAscii)

KeyAscii = LETRA_UPPER(KeyAscii)

If Len(Cmb_usuario.Text) >= 15 Then
   If KeyAscii <> 8 And KeyAscii <> 13 Then KeyAscii = 0
   Cmb_usuario.SelStart = Len(Cmb_usuario.Text)
End If

If KeyAscii = 13 And Trim(Cmb_usuario.Text) <> "" Then

   If Trim(Cmb_usuario.Text) = "ADMINISTRA" Then
      MsgBox "NO Puede Actualizar un Usuario Administrador.", vbExclamation
      Cmb_usuario.Text = ""
      Exit Sub
   End If

   If Not PROC_BUSCA_USUARIO Then
      Cmb_usuario.Text = ""
      Cmb_usuario.SetFocus
      Exit Sub
   End If
   Frm_usuario.Enabled = False
   frm_detalle.Enabled = True
   Tool_opciones.Buttons(2).Enabled = True
 
   Tool_opciones.Buttons(4).Enabled = Not Tool_opciones.Buttons(2).Enabled
 

'''   If Txt_clave.Enabled Then
'''      Txt_clave.SetFocus
'''   Else
'''      Txt_nombre.SetFocus
'''   End If

   Txt_nombre.SetFocus

   If Not objCreaUsuarios.DevuelveClaves(Cmb_usuario.Text) Then
      Exit Sub
   End If

   If Not objCreaUsuarios.DevuelvTipoCUs(Cmb_usuario.Text) Then
      Exit Sub
   End If

   Select Case objCreaUsuarios.TipoClave
      Case "A"
            CmbTipoClave.Text = "ALFANUMERICO"

      Case "N"
            CmbTipoClave.Text = "NUMERICO"

      Case "C"
            CmbTipoClave.Text = "CARACTER"
   End Select

   TxtDiasExp.Text = objCreaUsuarios.DiasExp
   TxtLargClave.Text = objCreaUsuarios.LargoClave
   Msk_fecha_expira.Text = DateAdd("d", CDbl(TxtDiasExp.Text), FechaProceso)

   ' Verificar si hay realmente una clave
   If Clave1 <> "" And Clave1 <> "" Then
      Check1.Value = 0
      Txt_clave.Enabled = False
      Txt_confirma_clave.Enabled = False
   Else
      Check1.Value = 1
      Txt_clave.Enabled = True
      Txt_confirma_clave.Enabled = True
   End If
End If
End Sub

Private Sub Cmb_usuario_LostFocus()
 Cmb_usuario_KeyPress vbKeyReturn
End Sub


Private Sub CmbArea_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
   Me.CmbClase.SetFocus
End If
End Sub


Private Sub CmbClase_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
  Msk_fecha_expira.SetFocus
End If

End Sub


Private Sub CmbTipoClave_Change()
   objCreaUsuarios.TipoClave = left(CmbTipoClave.Text, 1)
   Txt_clave.Text = ""
   Txt_confirma_clave.Text = ""
End Sub

Private Sub CmbTipoClave_Click()
   objCreaUsuarios.TipoClave = left(CmbTipoClave.Text, 1)

   Check1.Value = 1
   Txt_clave.Enabled = True
   Txt_confirma_clave.Enabled = True
   Txt_clave.Text = ""
   Txt_confirma_clave.Text = ""
End Sub

Private Sub CmbTipoClave_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then TxtLargClave.SetFocus
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, ""
   If Cmb_tipo_usuario.ListCount = 0 Then
      MsgBox "Debe Crear Tipos de Usuarios Antes de Crear Usuarios.", vbExclamation
      Unload Me
   End If
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   Case vbKeyLimpiar
      If Tool_opciones.Buttons(1).Enabled Then
         Call Tool_opciones_ButtonClick(Tool_opciones.Buttons(1))

      End If

   Case vbKeyGrabar
      If Tool_opciones.Buttons(2).Enabled Then
         Call Tool_opciones_ButtonClick(Tool_opciones.Buttons(2))

      End If

   Case vbKeyEliminar
      If Tool_opciones.Buttons(3).Enabled Then
         Call Tool_opciones_ButtonClick(Tool_opciones.Buttons(3))

      End If

   Case vbKeyBuscar
      If Tool_opciones.Buttons(4).Enabled Then
         Call Tool_opciones_ButtonClick(Tool_opciones.Buttons(4))

      End If

   Case vbKeySalir
      Unload Me

   End Select

End Sub

Private Sub Form_Load()
   OptLocal = Opt
   Me.top = 0
   Me.left = 0
   
   
   CmbTipoClave.AddItem "ALFANUMERICO"
   CmbTipoClave.AddItem "CARACTER"
   CmbTipoClave.AddItem "NUMERICO"

   PROC_CARGA_TIPO_USUARIO Cmb_tipo_usuario
   Call Carga_AreaProducto

   PROC_LIMPIA

   Me.Caption = Crea_Usuarios.Caption
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
   Set objCreaUsuarios = Nothing
End Sub

Private Sub Carga_AreaProducto()
   If Not BAC_SQL_EXECUTE("sp_carga_codigos_area") Then
      MsgBox "Problemas al Cargar Codigos de Area", vbExclamation
      Exit Sub
   End If

   CmbArea.Clear

   While BAC_SQL_FETCH(Datos())
      CmbArea.AddItem Datos(1)
   Wend
End Sub

Private Sub Msk_fecha_expira_Change()
   On Error Resume Next
   TxtDiasExp.Text = DateDiff("d", FechaProceso, Msk_fecha_expira.Text)
   Msk_fecha_expira.Text = Format(Msk_fecha_expira.Text, gsc_FechaDMA)
End Sub

Private Sub Msk_fecha_expira_Click()
   TxtDiasExp.Text = DateDiff("d", FechaProceso, Msk_fecha_expira.Text)
End Sub

Private Sub Msk_fecha_expira_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
   'Call Grabar
   'PROC_LIMPIA
   'Cmb_usuario.SetFocus
   TxtDiasExp.SetFocus
End If
End Sub

Private Sub Tool_opciones_ButtonClick(ByVal Button As MSComctlLib.Button)
On Error GoTo ErrorF:

Select Case Button.Index
   Case Is = 2
      Call Grabar

   Case Is = 3

      If MsgBox("Seguro de Borrar ?", 36) <> vbYes Then Exit Sub

      If Not FUNC_BORRA_USUARIO() Then
      
         MsgBox "El Usuario está Relacionado, No se Podra Eliminar", vbExclamation
         Call LogAuditoria("03", OptLocal, Me.Caption & " Error al eliminar- Usuario: " & Cmb_usuario.Text & " Nombre: " & Txt_nombre.Text & " Tipo Usuario: " & Cmb_tipo_usuario.Text & " Tipo Clave: " & CmbTipoClave.Text, "", "")
'         PROC_LIMPIA
         Exit Sub
   
      End If

      MsgBox "Eliminación Completada con Exito", vbInformation
      Call LogAuditoria("03", OptLocal, Me.Caption, "Usuario: " & Cmb_usuario.Text & " Nombre: " & Txt_nombre.Text & " Tipo Usuario: " & Cmb_tipo_usuario.Text & " Tipo Clave: " & CmbTipoClave.Text, "")

   Case Is = 4
      Cmb_usuario_KeyPress vbKeyReturn
      
      
   Case Is = 5
      Unload Me
      Exit Sub
      
   Case Is = 1
      
      PROC_LIMPIA
      
End Select

If Cmb_usuario.Enabled Then
   DoEvents
   CmbTipoClave.ListIndex = 0
   Txt_clave.Text = "1111"
   Txt_confirma_clave.Text = "11111"
   Cmb_usuario.SetFocus
   DoEvents
   
   Txt_clave.Text = ""
   Txt_confirma_clave.Text = ""
   CmbTipoClave.ListIndex = -1

End If

ErrorF:
End Sub


Private Sub Txt_clave_KeyPress(KeyAscii As Integer)

'''''If Not IsNumeric(Chr(KeyAscii)) And Not (UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z") And KeyAscii <> 13 And KeyAscii <> 8 Then
'''''  KeyAscii = 0
'''''End If
'''''
'KeyAscii = LETRA_UPPER(KeyAscii)
   
   
   'Txt_clave.MaxLength = objCreaUsuarios.LargoClave
    Txt_clave.MaxLength = 15

   If Not objCreaUsuarios.CompruebaPWD(Cmb_tipo_usuario.Text, KeyAscii) Then
      
      KeyAscii = 0
      Exit Sub
   
   End If


If KeyAscii = 13 And Trim(Txt_clave.Text) <> "" Then Txt_confirma_clave.SetFocus

End Sub

Private Sub Txt_clave_LostFocus()

   If CmbTipoClave.Text = "" Then
      MsgBox "Debe ingresar un tipo de clave ", vbOKOnly + vbExclamation
      If CmbTipoClave.Enabled Then
         CmbTipoClave.SetFocus
      End If
      Exit Sub
   
   End If

   If Len(Txt_clave) < TxtLargClave.Text Then
   
      MsgBox "La Clave debe tener un Minimo de " + Str(TxtLargClave.Text) + " Caracteres", vbOKOnly + vbExclamation
      If Txt_clave.Enabled Then
         Txt_clave.SetFocus
      End If
   
   End If

End Sub

Private Sub Txt_confirma_clave_KeyPress(KeyAscii As Integer)

   'Txt_confirma_clave.MaxLength = objCreaUsuarios.LargoClave
   
   Txt_confirma_clave.MaxLength = 10

   If Not objCreaUsuarios.CompruebaPWD(Cmb_tipo_usuario.Text, KeyAscii) Then
      
      KeyAscii = 0
      Exit Sub
   
   End If

If KeyAscii = 13 And Trim(Txt_confirma_clave.Text) <> "" Then Me.txt_email.SetFocus

End Sub

Private Sub txt_email_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Bac_SendKey (vbKeyTab)
   End If
    If KeyAscii = 39 Or KeyAscii = 34 Then
        KeyAscii = 0
    End If
End Sub

Private Sub txt_email_LostFocus()

Dim nLargo As Integer
Dim nContador As Integer
Dim cPorcion As String
Dim cPorcion_2 As String
Dim cPorcion_3 As String
Dim nUbicacion As Integer
Dim nUbicacion_2 As Integer
Dim nUbicacion_3 As Integer

   If Trim(txt_email.Text) = "" Then Exit Sub
   
   If InStr(1, Trim(txt_email.Text), ".@") > 0 Or InStr(1, Trim(txt_email.Text), "@.") > 0 Then
      MsgBox "Verifique Que su Direccion de Correo Este Correcta (.@) o (@.)", vbExclamation
         DoEvents
         txt_email.SetFocus
         Exit Sub
   End If
   
   nLargo = Len(Trim(txt_email.Text))
   nContador = 1
   While nContador < nLargo
      nUbicacion = InStr(nContador, Trim(txt_email.Text), ";")
      
      If nUbicacion = 0 Then
         nUbicacion = nLargo
      End If
      
      If nUbicacion = nLargo Then
         cPorcion = Mid(Trim(txt_email.Text), nContador, nUbicacion)
      Else
         cPorcion = Mid(Trim(txt_email.Text), nContador, nUbicacion - 1)
      End If
      
      nUbicacion_3 = InStr(1, Trim(cPorcion), "@")
      
      If nUbicacion_3 = 0 Then
         MsgBox "Verifique Que su Direccion de Correo Contenga el Caracter @ ", vbExclamation
         DoEvents
         txt_email.SetFocus
         Exit Sub
      End If
      
      nUbicacion_2 = InStr(nUbicacion_3, Trim(cPorcion), ".")
      
      If nUbicacion_2 = 0 Then
         MsgBox "Verifique Que su Direccion de Correo Contenga Punto ", vbExclamation
         DoEvents
         txt_email.SetFocus
         Exit Sub
      End If
      
      If nUbicacion = nLargo Then
         cPorcion_2 = Mid(Trim(cPorcion), nUbicacion_2 + 1, nUbicacion)
      Else
         cPorcion_2 = Mid(Trim(cPorcion), nUbicacion_2 + 1, nUbicacion - 1)
      End If
      
      cPorcion_3 = Mid(Trim(cPorcion), (nUbicacion_3 + 1), ((nUbicacion_2 - 1) - (nUbicacion_3)))
      
      If InStr(1, Trim(cPorcion), ".") = 0 Then
         MsgBox "Verifique Que su Direccion de Correo Contenga Punto ", vbExclamation
         DoEvents
         txt_email.SetFocus
         Exit Sub
      End If
      
      If cPorcion_2 = "" Then
         MsgBox "Su Direccion De Correo Debe Tener Una Extencion Despues Del Punto", vbExclamation
         DoEvents
         txt_email.SetFocus
         Exit Sub
      End If
      
      If cPorcion_3 = "" Then
         MsgBox "Su Direccion De Correo Debe Tener Host", vbExclamation
         DoEvents
         txt_email.SetFocus
         Exit Sub
      End If
      
      If IsNumeric(Mid(cPorcion, 1, 1)) Then
         MsgBox "Su Direccion De Correo No Debe Empesar Con Un Numero", vbExclamation
         DoEvents
         txt_email.SetFocus
         Exit Sub
      End If
      
      
      nContador = nUbicacion + 1
      
   Wend

End Sub

Private Sub Txt_nombre_KeyPress(KeyAscii As Integer)

Txt_nombre.MaxLength = 40

KeyAscii = LETRA_UPPER(KeyAscii)

If KeyAscii = 13 And Trim(Txt_nombre.Text) <> "" Then Cmb_tipo_usuario.SetFocus

End Sub


Sub Grabar()
   
   If CDbl(TxtLargClave.Text) < 4 Then
      MsgBox "El largo minimo de la Clave no puede ser menor a 4 caracteres", vbExclamation
      TxtLargClave.SetFocus
      Exit Sub
   End If
   
   If Trim(Txt_clave.Text) = "" And Check1.Value = 1 Then
      MsgBox "Debe Ingresar Clave.", vbExclamation
      Exit Sub
   End If
   
   If Trim(Txt_nombre.Text) = "" Then
      MsgBox "Debe Ingresar Nombre Usuario.", vbExclamation
      Exit Sub
   End If
   
   If FUNC_FMT_FECHA(Msk_fecha_expira.Text) <= FUNC_FMT_FECHA(FechaProceso) Then
      MsgBox "Fecha Expiración debe ser Mayor a Fecha Actual.", vbExclamation
      Me.Msk_fecha_expira.SetFocus
      Exit Sub
   End If
  
   If Trim(Txt_clave.Text) <> Trim(Txt_confirma_clave.Text) And Check1.Value = 1 Then
      MsgBox "La Clave de Confirmación es Distinta a la Clave.", vbExclamation
      Me.Txt_confirma_clave.SetFocus
      Exit Sub
   End If
   
   
   Txt_clave.Tag = Encript(Txt_clave.Text, True)
   
   If (Txt_clave.Tag = objCreaUsuarios.Clave Or Txt_clave.Tag = objCreaUsuarios.Clave1 Or Txt_clave.Tag = objCreaUsuarios.Clave2 Or Txt_clave.Tag = objCreaUsuarios.Clave3) And Check1.Value = 1 Then
      
      MsgBox "Esta Clave Ya fue utilizada anteriormente por este Usuario", vbExclamation
      Me.Txt_clave.SetFocus
      Exit Sub
   
   End If
     
   sCadena = "AABBCCDDEEFFGGHHIIJJKKLLMMNNÑÑOOPPQQRRSSTTUUVVWWXXYYZZ"
   sCadena = sCadena & "aabbccddeeffgghhiijjkkllmmnnññooppqqrrssttuuvvxxyyzz"
   sCadena = sCadena & "11223344556677889900"
   For nCaracter = 1 To Len(sCadena) Step 2
      If Txt_clave.Text Like "*" & Mid$(sCadena, nCaracter, 2) & "*" Then
         MsgBox "No pueden existir 2 Caracteres iguales consecutivos en la Clave.", vbExclamation
         Screen.MousePointer = 0
         Me.Txt_clave.SetFocus
         Exit Sub
      End If
   Next nCaracter
   
   If Trim(Txt_nombre.Text) = Trim(Txt_clave.Text) Then
      MsgBox "Clave no puede ser igual al Nombre de Usuario.", vbExclamation
      Me.Txt_clave.SetFocus
      Exit Sub
   End If
   If Me.Cmb_tipo_usuario.ListIndex = -1 Then
      MsgBox "Debe Ingresar Tipo de Usuario.", vbExclamation
      Me.Cmb_tipo_usuario.SetFocus
      Exit Sub
   End If
   If MsgBox("Seguro de Grabar ?", 36) <> vbYes Then Exit Sub
     
   Screen.MousePointer = 11
     
   If Not FUNC_GRABA_USUARIO() Then
      Screen.MousePointer = 0
      MsgBox "Problemas en la Grabación", vbExclamation
      Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Usuario: " & Cmb_usuario.Text & " Nombre: " & Txt_nombre.Text & " Tipo Usuario: " & Cmb_tipo_usuario.Text & " Tipo Clave: " & CmbTipoClave.Text, "", "")
      Exit Sub
   End If
   
   MsgBox "Grabación Completada con Exito", vbInformation
   Call LogAuditoria("01", OptLocal, Me.Caption, "", "Usuario: " & Cmb_usuario.Text & " Nombre: " & Txt_nombre.Text & " Tipo Usuario: " & Cmb_tipo_usuario.Text & " Tipo Clave: " & CmbTipoClave.Text)
   PROC_LIMPIA
   Screen.MousePointer = 0
   
End Sub


Sub Busca_Opciones()
      
      Select Case objCreaUsuarios.TipoClave
      
         Case "A"
               If Mid(CmbTipoClave.Text, 1, 1) <> "A" Then
                  CmbTipoClave.Text = "ALFANUMERICO"
               End If
         
         Case "N"
               If Mid(CmbTipoClave.Text, 1, 1) <> "N" Then
                  CmbTipoClave.Text = "NUMERICO"
               End If
         
         Case "C"
               If Mid(CmbTipoClave.Text, 1, 1) <> "C" Then
                  CmbTipoClave.Text = "CARACTER"
               End If
      End Select
      
      TxtDiasExp.Text = objCreaUsuarios.DiasExp
      TxtLargClave.Text = objCreaUsuarios.LargoClave

End Sub

Private Sub TxtDiasExp_Change()
On Error Resume Next

   objCreaUsuarios.DiasExp = TxtDiasExp.Text
   Msk_fecha_expira.Text = DateAdd("d", CDbl(TxtDiasExp.Text), FechaProceso)

End Sub

Private Sub TxtDiasExp_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then Txt_nombre.SetFocus

End Sub

Private Sub TxtLargClave_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      If Me.Txt_clave.Enabled = True Then
         Txt_clave.SetFocus
      Else
         Me.CmbArea.SetFocus
      End If
   End If
      

End Sub

Private Sub TxtLargClave_LostFocus()
objCreaUsuarios.LargoClave = TxtLargClave.Text


   If Len(Txt_clave.Text) < Val(TxtLargClave.Text) Then
   
      Check1.Value = 1
      Txt_clave.Enabled = True
      Txt_confirma_clave.Enabled = True
      Txt_clave.Text = ""
      Txt_confirma_clave.Text = ""
      If Me.Txt_clave.Enabled Then
         Me.Txt_clave.SetFocus
      Else
       
         If Me.CmbArea.Enabled Then Me.CmbArea.SetFocus
      End If
         
   
   End If
End Sub

