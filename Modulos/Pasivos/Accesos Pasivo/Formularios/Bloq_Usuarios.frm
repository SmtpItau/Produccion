VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form Bloq_Usuarios 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Bloqueo/Desbloqueo de Usuarios"
   ClientHeight    =   1605
   ClientLeft      =   3300
   ClientTop       =   2895
   ClientWidth     =   3735
   Icon            =   "Bloq_Usuarios.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1605
   ScaleWidth      =   3735
   Begin VB.Timer Timer1 
      Interval        =   5000
      Left            =   3120
      Top             =   2100
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   2475
      Left            =   -225
      TabIndex        =   0
      Top             =   0
      Width           =   3975
      _Version        =   65536
      _ExtentX        =   7011
      _ExtentY        =   4366
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   1
      BevelOuter      =   1
      BevelInner      =   1
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
         Left            =   1200
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   300
         Width           =   2490
      End
      Begin VB.CommandButton Cmd_Opcion 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   420
         Left            =   1710
         TabIndex        =   1
         Top             =   990
         Width           =   1365
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   690
         Left            =   420
         TabIndex        =   3
         Top             =   90
         Width           =   3420
         _Version        =   65536
         _ExtentX        =   6032
         _ExtentY        =   1217
         _StockProps     =   14
         Caption         =   "Usuario"
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
      End
      Begin VB.Image Image1 
         Height          =   690
         Left            =   600
         Picture         =   "Bloq_Usuarios.frx":2EFA
         Stretch         =   -1  'True
         Top             =   840
         Width           =   645
      End
      Begin VB.Image Image2 
         Height          =   690
         Left            =   600
         Picture         =   "Bloq_Usuarios.frx":338A
         Stretch         =   -1  'True
         Top             =   840
         Visible         =   0   'False
         Width           =   645
      End
   End
End
Attribute VB_Name = "Bloq_Usuarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim OptLocal As String

Function Bloqueo(xUsuario As String) As Boolean
Dim Datos()
Bloqueo = False

   If BAC_SQL_EXECUTE("Sp_TraeBloqueo_Usuario", Array(xUsuario)) Then
       If BAC_SQL_FETCH(Datos()) Then
          If Datos(1) = "1" Then
             Bloqueo = True
             Exit Function
          End If
       End If
   End If
End Function

Function Bloquea_Usuario(xBloquea As Boolean, xUsuario As String) As Boolean
Dim Datos()

Bloquea_Usuario = False

Envia = Array(xUsuario, IIf(xBloquea, 1, 0))

If BAC_SQL_EXECUTE("Sp_Bloquea_Gen_Usuario", Envia) Then
   Do While BAC_SQL_FETCH(Datos())
   Loop
Else
   Exit Function
End If

Bloquea_Usuario = True
End Function

Private Sub Cmb_usuario_Click()
If Bloqueo(Cmb_usuario) Then
   Image1.Visible = False
   Image2.Visible = True
   Cmd_Opcion.Caption = "Desbloquear"
Else
   Image1.Visible = True
   Image2.Visible = False
   Cmd_Opcion.Caption = "Bloquear"
End If
End Sub

Private Sub Cmd_Opcion_Click()

If Image2.Visible Then
   Image2_DblClick
Else
   Image1_DblClick
End If

Cmd_Opcion.Caption = IIf(Mid(Cmd_Opcion.Caption, 1, 1) = "B", "Desbloquear", "Bloquear")

If Cmd_Opcion.Caption = "Desbloquear" Then
   Call LogAuditoria("11", OptLocal, Me.Caption & "- Usuario: " & Cmb_usuario.Text, "", "")
Else
   Call LogAuditoria("12", OptLocal, Me.Caption & "- Usuario: " & Cmb_usuario.Text, "", "")
End If

End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, ""
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyEscape Then
      KeyCode = 0
      Unload Me
      Exit Sub
   
   End If

End Sub

Private Sub Form_Load()
OptLocal = Opt
Me.left = 0
Me.top = 0

PROC_CARGA_USUARIO Cmb_usuario

If Cmb_usuario.ListCount > 0 Then
  Cmb_usuario.ListIndex = 0

Else
  MsgBox "No Existen Usuarios para Bloquear", vbOKOnly + vbExclamation
  Unload Me
End If
    Me.Caption = Bloq_Usuarios.Caption
    Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Image1_DblClick()
If Image1.Visible Then
  If Bloquea_Usuario(True, Cmb_usuario) Then
   Image1.Visible = False              ' Desactiva Verde
   Image2.Visible = True               ' Activa Rojo
  End If
End If
End Sub

Private Sub Image2_DblClick()
If Image2.Visible Then
 If Bloquea_Usuario(False, Cmb_usuario) Then
  Image2.Visible = False             'Desactiva Rojo
  Image1.Visible = True              'Activa Verde
 End If
End If
End Sub

Private Sub Timer1_Timer()
If Bloqueo(Cmb_usuario) Then
    Image1.Visible = False
    Image2.Visible = True
Else
    Image1.Visible = True
    Image2.Visible = False
End If
End Sub
