VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Acceso_Usuario 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Acceso Usuario"
   ClientHeight    =   1860
   ClientLeft      =   4695
   ClientTop       =   2730
   ClientWidth     =   4470
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Acceso.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1860
   ScaleWidth      =   4470
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.Toolbar TB 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   4470
      _ExtentX        =   7885
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Ingresar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3720
      Top             =   105
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Acceso.frx":000C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Acceso.frx":0326
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Height          =   1395
      Left            =   45
      TabIndex        =   3
      Top             =   435
      Width           =   4425
      Begin VB.TextBox TxtUsuario 
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   2280
         TabIndex        =   0
         Top             =   330
         Width           =   2025
      End
      Begin VB.TextBox TxtClave 
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         IMEMode         =   3  'DISABLE
         Left            =   2295
         MaxLength       =   15
         PasswordChar    =   "*"
         TabIndex        =   2
         Top             =   795
         Width           =   2025
      End
      Begin VB.PictureBox Picture1 
         DrawStyle       =   5  'Transparent
         Height          =   1200
         Left            =   75
         Picture         =   "Acceso.frx":0640
         ScaleHeight     =   1140
         ScaleWidth      =   1155
         TabIndex        =   4
         Top             =   135
         Width           =   1215
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
         Left            =   1575
         TabIndex        =   6
         Top             =   840
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
         Left            =   1365
         TabIndex        =   5
         Top             =   405
         Width           =   825
      End
   End
End
Attribute VB_Name = "Acceso_Usuario"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Intentos     As Single

Private Sub Form_Load()
   Me.Icon = BAC_INVERSIONES.Icon
   gsBac_User$ = ""
   TxtUsuario.Text = Encript(GetSetting("BAC", "SISTEMAS", "ActiveUser"), False)
End Sub

Private Sub Form_Unload(Cancel As Integer)

        If Not giAceptar Or Intentos > 2 Then
            End
        End If
        '--------------------------
            Dim Datos2()
            giAceptar = False
            Envia = Array(TxtUsuario.Text)
        
            If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_BUSCARESETEO", envia) Then
                Exit Sub
            End If
            
            If Not Bac_SQL_Fetch(Datos2()) Then
                MsgBox "Usuario NO Existe.", vbCritical, TITSISTEMA
                Exit Sub
            End If
            
            Largo_Clave = Datos2(1)
            Tipo_Clave = Datos2(2)
            Reseteo = Datos2(3)
            
            If Reseteo = "1" Then
                oBligacion = True
                Cambio_Password.LblUsuario = TxtUsuario.Text
                Cambio_Password.TxtClave = "" 'TxtClave.Text
                Cambio_Password.Show 1
                Exit Sub
            End If
      '--------------------------
End Sub





Private Sub TB_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
          Case 1
            
            TxtClave_KeyPress 13
            
          Case 2
          
            Unload Me
          
   End Select
End Sub

Private Sub TxtClave_GotFocus()

TxtClave.SelStart = 0
TxtClave.SelLength = Len(TxtClave.Text)

End Sub


Private Sub TxtClave_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = 27 Then
      Unload Me
   End If
End Sub

Private Sub TxtClave_KeyPress(KeyAscii As Integer)
    giAceptar = True
   
   If KeyAscii = vbKeyEscape Then
      End
   End If
   
   If Not CompruebaPWD(nTipoClave, KeyAscii) Then
      KeyAscii = 0
      Exit Sub
   End If
   
   If KeyAscii = vbKeyReturn Then
   
      gsBac_User$ = TxtUsuario.Text
      
      If func_valida_usuario() Then
      
         Call SaveSetting("BAC", "SISTEMAS", "ActiveUser", Encript(TxtUsuario.Text, True))

         If Not expira(Fecha_Expira) Then
                    Call GRABA_LOG_AUDITORIA(1, _
                   Format(gsBac_Fecp, "yyyymmdd"), _
                   gsBac_IP, _
                   gsBac_User, _
                   "BCC", _
                   "", _
                   "05", _
                   "Ingreso al Sistema", _
                   "", _
                   "", _
                   "")
               
               Unload Me
               Exit Sub
         Else
            If Trim(TxtUsuario.Text) <> "ADMINISTRA" Then
               If (MsgBox("La password ha expirado " & Chr(10) & "¿ Desea Cambiarla ?", vbYesNo + vbQuestion)) = vbYes Then

                  On Error GoTo ErrUNLOAD
                  oBligacion = True
                  Cambio_Password.Tag = "X"
                  Cambio_Password.Show vbModal

                  If Bloquea_Usuario(True, TxtUsuario.Text) Then
                   
                   Call GRABA_LOG_AUDITORIA(1, _
                   Format(gsBac_Fecp, "yyyymmdd"), _
                   gsBac_IP, _
                   gsBac_User, _
                   "BCC", _
                   "", _
                   "05", _
                   "Ingreso al Sistema-Cambio Password", _
                   "", _
                   "", _
                   "")

                     
                     Unload Me
                     Exit Sub
                  End If
               Else
                 End
               End If
            Else
                   Call GRABA_LOG_AUDITORIA(1, _
                   Format(gsBac_Fecp, "yyyymmdd"), _
                   gsBac_IP, _
                   gsBac_User, _
                   "BCC", _
                   "", _
                   "05", _
                   "Ingreso al Sistema", _
                   "", _
                   "", _
                   "")
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
                                                     Call GRABA_LOG_AUDITORIA(1, _
                   Format(gsBac_Fecp, "yyyymmdd"), _
                   gsBac_IP, _
                   gsBac_User, _
                   "BCC", _
                   "", _
                   "05", _
                   "Ingreso al Sistema,Equivocó Password más de Tres Veces", _
                   "", _
                   "", _
                   "")

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


Function func_valida_usuario() As Boolean
   Dim datos()
   Dim Sql              As String
   Dim Password_Usuario As String

   func_valida_usuario = False
   
   gsBac_User$ = ""
   gsBac_Pass$ = ""
   gsUsuario = ""
   
   Envia = Array()
   AddParam Envia, TxtUsuario.Text
   AddParam Envia, Encript(TxtClave.Text, True)

   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_VALIDA_INGRESO_USUARIO", envia) Then
      Exit Function
   End If
   
   If Bac_SQL_Fetch(datos()) Then
      If datos(1) < 0 Then
        MsgBox datos(2), vbExclamation, App.Title
        Exit Function
      End If
   End If

   Password_Usuario = datos(1)
   gsBac_Tipo_Usuario = datos(2)
   Fecha_Expira = datos(3)
   nDiasClave = datos(5)
   Largo_Clave = IIf(datos(6) = 0, 8, datos(6))
   nTipoClave = datos(7)
   
   gsBac_User$ = TxtUsuario.Text
   gsBac_Pass$ = TxtClave.Text
   gsUsuario = TxtUsuario.Text
   gsBac_Login = True
   
   func_valida_usuario = True

End Function

Private Sub TxtUsuario_GotFocus()

TxtUsuario.SelStart = 0
TxtUsuario.SelLength = Len(TxtUsuario.Text)

End Sub



Private Sub txtUsuario_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = 27 Then
      Unload Me
   End If
End Sub

Private Sub txtUsuario_KeyPress(KeyAscii As Integer)

TxtUsuario.MaxLength = 12

KeyAscii = Asc(UCase(Chr(KeyAscii)))

If KeyAscii = 13 And Trim(TxtUsuario.Text) <> "" Then TxtClave.SetFocus

End Sub

Sub Activar_Usuario()
   Dim datos()
   Dim sw As Boolean
   Dim j As Integer
    
   j = 1
   
   sw = False
        
   gsUsuario = TxtUsuario.Text
   gsSistema = "BFW"
   
   Envia = Array()
   AddParam Envia, gsUsuario
   AddParam Envia, gsSistema
   AddParam Envia, gsBac_Fecp
   AddParam Envia, Date
                 
   If Bac_Sql_Execute("SP_Control_Bloq_Usuarios_ACTIVAR", Envia) Then
       
      Do While Bac_SQL_Fetch(datos())
                
         gsTerminal = datos(1)
         gsUsuarioReal = datos(2)
         
         If datos(1) = "LLENO" Then
            
            sw = True
         
         End If
                
      Loop
        
            
        If sw = True Then
        
            MsgBox "No Pueden Entrar Mas Usuarios al Sistema", vbCritical + vbOKOnly, "Bac-Parametros"
            End
                    
        End If
    
    End If

End Sub


Private Sub TxtUsuario_LostFocus()
'cs req.4116
 Call Busca_Tipo_Clave(TxtUsuario.Text)
End Sub





