VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Acceso_Usuario 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Acceso Usuario"
   ClientHeight    =   1755
   ClientLeft      =   4545
   ClientTop       =   4410
   ClientWidth     =   5985
   FillStyle       =   0  'Solid
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Acceso.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1755
   ScaleWidth      =   5985
   ShowInTaskbar   =   0   'False
   Begin VB.TextBox TxtClave 
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
      Left            =   3780
      MaxLength       =   15
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   1110
      Width           =   2040
   End
   Begin VB.TextBox TxtUsuario 
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
      Left            =   3780
      TabIndex        =   0
      Text            =   " "
      Top             =   600
      Width           =   2040
   End
   Begin MSComctlLib.Toolbar TB 
      Height          =   450
      Left            =   0
      Negotiate       =   -1  'True
      TabIndex        =   2
      Top             =   0
      Width           =   930
      _ExtentX        =   1640
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3720
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
            Picture         =   "Acceso.frx":000C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Acceso.frx":048C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Acceso.frx":0977
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Acceso.frx":1057
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Acceso.frx":17D4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label Label2 
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
      Left            =   3150
      TabIndex        =   4
      Top             =   1170
      Width           =   510
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
      Left            =   3000
      TabIndex        =   3
      Top             =   630
      Width           =   630
   End
   Begin VB.Image Image1 
      Height          =   1215
      Left            =   0
      Picture         =   "Acceso.frx":1C5F
      Top             =   480
      Width           =   2730
   End
End
Attribute VB_Name = "Acceso_Usuario"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Intentos As Integer
Dim OptLocal As String

Private Sub cmdAceptar_Click()
   TxtClave_KeyPress 13
End Sub

Private Sub cmdCancelar_Click()
   End
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   'TxtClave.SetFocus
End Sub

Private Sub Form_Load()
      OptLocal = Opt
      Me.TxtUsuario = gsBAC_User$
      Me.TxtClave = ""

   PROC_CENTRAR_FORMULARIO Me, BAC_Parametros
      
   
   Intentos = 0
End Sub

Private Sub TB_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
   Case 2
      gsUsuario = Me.TxtUsuario.Text
      TxtClave_KeyPress 13
   Case 3
      End

End Select
End Sub

Private Sub TxtClave_GotFocus()
   TxtClave.SelStart = 0
   TxtClave.SelLength = Len(TxtClave.Text)
End Sub


Private Sub TxtClave_KeyPress(KeyAscii As Integer)
If Not IsNumeric(Chr(KeyAscii)) And Not (UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z") And KeyAscii <> 13 And KeyAscii <> 8 Then
  KeyAscii = 0
End If
TxtClave.MaxLength = 15

'KeyAscii = Asc(UCase(Chr(KeyAscii)))

giAceptar = False

If KeyAscii = 13 Then
   
   giAceptar = True
   
    If Bloqueado(TxtUsuario.Text) Then
              
       MsgBox "Usuario está Bloqueado", vbOKOnly + vbExclamation
       
        Call LogAuditoria("05", "Acceso_Usuario", "Sistema Parámetro(Usuario está Bloqueado)", "", "")
       
       End
   
   End If
   
   If FUNC_VALIDA_USUARIO() Then
    
    If Not Expira(fecha_expira) Then
        
        If Bloquea_Usuario(True, TxtUsuario.Text) Then
                                    
            Unload Me
            
            Exit Sub
        
        End If
    
    Else
        If Trim(TxtUsuario.Text) <> "ADMINISTRA" Then
         
         If (MsgBox("La password ha expirado " & Chr(10) & "¿ Desea Cambiarla ?", vbYesNo + vbQuestion)) = vbYes Then
          
            Call LogAuditoria("05", "Acceso_Usuario", "Sistema Parámetro(La password ha expirado)", "", "")
          
          On Error GoTo ErrUNLOAD
             
             Cambio_Password.Tag = "X"
             Cambio_Password.Show vbModal
            
            If Bloquea_Usuario(True, TxtUsuario.Text) Then
                                    
             Unload Me
             
             Exit Sub
            
            End If
         
         Else
           
           End
         
         End If
       
       Else
             
             Unload Me
             
             Exit Sub
       
       End If
    
    End If
   
   Else
      
      Intentos = Intentos + 1
   
   End If

    If Intentos > 2 Then
          
          If Bloquea_Usuario(True, TxtUsuario.Text) And Trim(TxtUsuario.Text) <> "ADMINISTRA" Then
           
          MsgBox "Usuario ha sido Bloqueado", vbOKOnly + vbCritical
          
          Envia = Array(TxtUsuario.Text)
          If BAC_SQL_EXECUTE("Sp_Busca_Usuario", Envia) Then
               If BAC_SQL_FETCH(Datos()) Then
                  Call LogAuditoria("05", "Acceso_Usuario", "Sistema Parámetro(Usuario ha sido Bloqueado)", "", "")
               End If
          End If
         
          End If
          
          Unload Me
          
          Exit Sub
       
       End If
    
    End If

Exit Sub

ErrUNLOAD:
   
   If err.Number = 364 Then
      
      End
   
   End If



End Sub


Function FUNC_VALIDA_USUARIO() As Boolean

Dim Datos()
Dim Sql              As String
Dim Password_Usuario As String

Screen.MousePointer = 11

FUNC_VALIDA_USUARIO = False

gsBAC_User$ = ""
gsBAC_Pass$ = ""
'gsUsuario = ""

'Sql = "EXECUTE sp_valida_ingreso_usuario "
'Sql = Sql + "'" + TxtUsuario.Text + "'"

Envia = Array(TxtUsuario.Text)

If Not BAC_SQL_EXECUTE("sp_valida_ingreso_usuario", Envia) Then
   
   Screen.MousePointer = 0
   
   Exit Function

End If

If Not BAC_SQL_FETCH(Datos) Then
   
   Screen.MousePointer = 0
   MsgBox "Usuario NO Existe.", vbCritical
   
      
   Exit Function

End If

Password_Usuario = Datos(1)
gsBac_Tipo_Usuario = Datos(2)
fecha_expira = Datos(3)

If Trim(Password_Usuario) <> Encript(Trim(TxtClave.Text), True) Then
   Screen.MousePointer = 0
   MsgBox "Clave Invalida." & Chr(10) & Chr(10) & "Verifique la tecla [Bloq Mayús].", vbExclamation
   TxtClave.Text = ""
   Call LogAuditoria("05", "Acceso_Usuario", "Sistema Parámetro(Clave Invalida)", "", "")
   
   Exit Function

End If

    Call LogAuditoria("05", "Acceso_Usuario", "Sistema Parámetro", "", "")


Screen.MousePointer = 0

gsBAC_User$ = TxtUsuario.Text
gsBAC_Pass$ = TxtClave.Text
gsUsuario = TxtUsuario.Text
gsBAC_Login = True

FUNC_VALIDA_USUARIO = True

End Function


Private Sub TxtUsuario_GotFocus()

TxtUsuario.SelStart = 0
TxtUsuario.SelLength = Len(TxtUsuario.Text)

End Sub



Private Sub TxtUsuario_KeyPress(KeyAscii As Integer)

   If KeyAscii = 27 Then
      End
   End If

   TxtUsuario.MaxLength = 15

   KeyAscii = Asc(UCase(Chr(KeyAscii)))

   If KeyAscii = 13 And Trim(TxtUsuario.Text) <> "" Then
      TxtClave.SetFocus
   End If

End Sub



Private Sub TxtUsuario_LostFocus()
    gsUsuario = Me.TxtUsuario.Text
End Sub
