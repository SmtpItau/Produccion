VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Acceso_Control_Usuario 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Acceso Usuario"
   ClientHeight    =   1605
   ClientLeft      =   4815
   ClientTop       =   4545
   ClientWidth     =   5625
   ControlBox      =   0   'False
   FillColor       =   &H80000005&
   FillStyle       =   0  'Solid
   ForeColor       =   &H80000005&
   Icon            =   "Acceso_Control_Usuario.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1605
   ScaleWidth      =   5625
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   450
      Left            =   0
      Negotiate       =   -1  'True
      TabIndex        =   4
      Top             =   0
      Width           =   945
      _ExtentX        =   1667
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Login"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
   Begin VB.TextBox txtClave 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      IMEMode         =   3  'DISABLE
      Left            =   3510
      MaxLength       =   15
      PasswordChar    =   "*"
      TabIndex        =   3
      Top             =   1140
      Width           =   2040
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4560
      Top             =   -60
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
            Picture         =   "Acceso_Control_Usuario.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Acceso_Control_Usuario.frx":078A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Acceso_Control_Usuario.frx":0C75
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Acceso_Control_Usuario.frx":1355
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Acceso_Control_Usuario.frx":1AD2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Image Image1 
      Height          =   1215
      Left            =   -30
      Picture         =   "Acceso_Control_Usuario.frx":1F5D
      Top             =   450
      Width           =   2730
   End
   Begin VB.Label Lbl_usuario 
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "ADMINISTRA"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   360
      Left            =   3525
      TabIndex        =   2
      Top             =   660
      Width           =   2040
   End
   Begin VB.Label lblEtiquetas 
      Alignment       =   1  'Right Justify
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
      Index           =   1
      Left            =   2730
      TabIndex        =   1
      Top             =   1200
      Width           =   450
   End
   Begin VB.Label lblEtiquetas 
      Alignment       =   1  'Right Justify
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
      Index           =   0
      Left            =   2745
      TabIndex        =   0
      Top             =   690
      Width           =   630
   End
End
Attribute VB_Name = "Acceso_Control_Usuario"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Intentos As Integer
Function FUNC_VALIDA_USUARIO() As Boolean
Dim Datos()
Dim Sql              As String
Dim Password_Usuario As String

Screen.MousePointer = 11

FUNC_VALIDA_USUARIO = False

gsBAC_User = ""
gsBAC_Pass$ = ""
'gsUsuario = ""

Sql = "sp_valida_ingreso_usuario "
Sql = Sql + "'" + Lbl_usuario.Caption + "'"

enviar = Array(Lbl_usuario.Caption)

If Not BAC_SQL_EXECUTE("sp_valida_ingreso_usuario ", enviar) Then
   Screen.MousePointer = 0
   Exit Function
End If

If Not BAC_SQL_FETCH(Datos) Then
   Screen.MousePointer = 0
   MsgBox "Usuario NO Existe.", vbCritical
   LogAuditoria "05", "Acceso", Me.Caption + ": " + "Usuario NO Existe. " + Lbl_usuario.Caption, "", ""
   Exit Function
End If

Password_Usuario = Datos(1)
gsBac_Tipo_Usuario = Datos(2)
Fecha_Expira = Datos(3)

If Trim(Password_Usuario) <> Encript(Trim(txtClave.Text), True) Then
   Screen.MousePointer = 0
   MsgBox "Clave Invalida." & Chr(10) & Chr(10) & "Verifique la tecla [Bloq Mayús].", vbExclamation
   LogAuditoria "05", "Acceso", Me.Caption + ": " + "Clave Invalida. " + Lbl_usuario.Caption, "", ""
   Exit Function
End If

Screen.MousePointer = 0

gsBAC_User = Lbl_usuario.Caption
gsBAC_Pass$ = txtClave.Text
gsUsuario = Lbl_usuario.Caption
gsBAC_Login = True

FUNC_VALIDA_USUARIO = True

End Function

Private Sub Form_Activate()
    gsUsuario = Me.Lbl_usuario.Caption
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Select Case KeyCode
   Case vbKeyAceptar
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(1))
   Case vbKeySalir
      Unload Me

   End Select
End Sub

Private Sub Form_Load()
    Intentos = 0

    PROC_CENTRAR_FORMULARIO Me, Menu_Principal
    PROC_ImagenFondo Me
    
   
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    
    If Button.Index = 1 Then
        txtClave_KeyPress 13
    Else
        Unload Me
    End If
    
End Sub

Private Sub txtClave_GotFocus()
    txtClave.SelStart = 0
    txtClave.SelLength = Len(txtClave.Text)
End Sub

Private Sub txtClave_KeyPress(KeyAscii As Integer)
If Not IsNumeric(Chr(KeyAscii)) And Not (UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z") And KeyAscii <> 13 And KeyAscii <> 8 Then
  KeyAscii = 0
End If

If KeyAscii = 13 Then
   Login_Operador = ""


   If FUNC_VALIDA_USUARIO() Then
      Login_Usuario = Lbl_usuario.Caption
      LogAuditoria "05", "Acceso", Me.Caption + ": " + Login_Usuario + " ingreso sin problemas al sistema", "", ""
      NSusuario = Lbl_usuario.Caption
      Unload Me
   Else
      Intentos = Intentos + 1
   End If

   If Intentos > 2 Then
      LogAuditoria "05", "Acceso", Me.Caption + " Usuario ha sido bloqueado: " + Lbl_usuario.Caption, "", ""
      Unload Me
      Exit Sub
   End If
End If
End Sub

Private Sub txtUsuario_GotFocus()
    TxtUsuario.SelStart = 0
    TxtUsuario.SelLength = Len(TxtUsuario.Text)
End Sub

Private Sub txtUsuario_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        txtClave.SetFocus
    End If
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
Private Sub PROC_Wallpaper()

    Dim strError As String
    
    With clsWall
        .TransparentColor = vbGreen
        .ExeName = App.Path & "\" & App.ExeName & ".exe"
        .RunningInIDE = PROC_RunningInIde
        .MDIForm = Me
        Call .CreateFormPicture(Me, 4, strError)
    End With
    
End Sub
