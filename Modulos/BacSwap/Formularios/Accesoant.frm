VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form Acceso_Usuario 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Acceso Usuario"
   ClientHeight    =   2295
   ClientLeft      =   2535
   ClientTop       =   2745
   ClientWidth     =   4575
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Acceso.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2295
   ScaleWidth      =   4575
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin ComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   4575
      _ExtentX        =   8070
      _ExtentY        =   741
      ButtonWidth     =   635
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   2
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.TextBox TxtClave 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      IMEMode         =   3  'DISABLE
      Left            =   2370
      PasswordChar    =   "*"
      TabIndex        =   1
      Text            =   "BAC"
      Top             =   1365
      Width           =   2025
   End
   Begin VB.TextBox TxtUsuario 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   2385
      TabIndex        =   0
      Text            =   "BAC"
      Top             =   885
      Width           =   1995
   End
   Begin VB.PictureBox Picture1 
      Height          =   1200
      Left            =   135
      Picture         =   "Acceso.frx":030A
      ScaleHeight     =   1140
      ScaleWidth      =   1155
      TabIndex        =   2
      Top             =   660
      Width           =   1215
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   1125
      Top             =   1890
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   2
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "Acceso.frx":4A48
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "Acceso.frx":4D62
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Clave"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   1665
      TabIndex        =   4
      Top             =   1395
      Width           =   615
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Usuario"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   1470
      TabIndex        =   3
      Top             =   930
      Width           =   825
   End
End
Attribute VB_Name = "Acceso_Usuario"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Intentos As Integer
Private Sub CmdAceptar_Click()

TxtClave_KeyPress 13

End Sub



Private Sub cmdCancelar_Click()

Unload Me

End Sub

Private Sub Form_Load()

gsBAC_User$ = ""
Intentos = 0

End Sub

Private Sub SSPanel1_Click()

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)

    If Button.Index = 1 Then
        TxtClave_KeyPress 13
    ElseIf Button.Index = 2 Then
        Unload Me
    End If


End Sub

Private Sub TxtClave_GotFocus()

TxtClave.SelStart = 0
TxtClave.SelLength = Len(TxtClave.Text)

End Sub


Private Sub TxtClave_KeyPress(KeyAscii As Integer)

TxtClave.MaxLength = 15

KeyAscii = Asc(UCase(Chr(KeyAscii)))

If KeyAscii = 13 Then

   If FUNC_VALIDA_USUARIO() Then
      Unload Me
      Exit Sub
   Else
      Intentos = Intentos + 1
   End If
   
   If Intentos >= 3 Then
      Unload Me
      Exit Sub
   End If
   
End If

End Sub


Function FUNC_VALIDA_USUARIO() As Boolean
Dim Datos()
Dim Sql              As String
Dim Password_Usuario As String


FUNC_VALIDA_USUARIO = False

gsBAC_User$ = ""
gsBAC_Pass$ = ""
gsusuario = ""

Sql = "EXECUTE " & giSQL_DatabaseCommon & "..sp_valida_ingreso_usuario "
Sql = Sql + "'" + TxtUsuario.Text + "'"

If MISQL.SQL_Execute(Sql) <> 0 Then Exit Function

If MISQL.SQL_Fetch(Datos) <> 0 Then
   MsgBox "Usuario NO Existe.", vbCritical
   Exit Function
End If

Password_Usuario = Datos(1)
gsBac_Tipo_Usuario = Datos(2)


If Trim(Password_Usuario) <> Encript(Trim(TxtClave.Text), True) Then
    Screen.MousePointer = 0
    Call Grabar_Log("PCS", TxtUsuario.Text, CDate(gsBAC_Fecp), "Clave ingresada no es válida")
    MsgBox "Clave Invalida." & Chr(10) & Chr(10) & "Verifique la tecla [Bloq Mayús].", vbExclamation
    Exit Function
End If

gsBAC_User$ = TxtUsuario.Text
gsBAC_Pass$ = TxtClave.Text
gsusuario = TxtUsuario.Text
Login_Usuario = TxtUsuario.Text
gsBAC_Login = True
FUNC_VALIDA_USUARIO = True

End Function


Private Sub TxtUsuario_GotFocus()

TxtUsuario.SelStart = 0
TxtUsuario.SelLength = Len(TxtUsuario.Text)

End Sub



Private Sub TxtUsuario_KeyPress(KeyAscii As Integer)

TxtUsuario.MaxLength = 15

KeyAscii = Asc(UCase(Chr(KeyAscii)))

If KeyAscii = 13 And Trim(TxtUsuario.Text) <> "" Then TxtClave.SetFocus

End Sub


