VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_ACCESO_USUARIO 
   BackColor       =   &H80000009&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Acceso Usuario"
   ClientHeight    =   1740
   ClientLeft      =   5205
   ClientTop       =   4080
   ClientWidth     =   5745
   ForeColor       =   &H00C0C0C0&
   Icon            =   "FRM_ACCESO_USUARIO.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1740
   ScaleWidth      =   5745
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
      Left            =   3570
      MaxLength       =   15
      PasswordChar    =   "*"
      TabIndex        =   2
      Top             =   1140
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
      Left            =   3570
      TabIndex        =   1
      Text            =   " "
      Top             =   600
      Width           =   2040
   End
   Begin MSComctlLib.Toolbar Tlb_Acceso_Usuario 
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   975
      _ExtentX        =   1720
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
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4680
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
               Picture         =   "FRM_ACCESO_USUARIO.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACCESO_USUARIO.frx":337A
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACCESO_USUARIO.frx":3865
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACCESO_USUARIO.frx":3F45
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACCESO_USUARIO.frx":46C2
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Image Image1 
      Height          =   1215
      Left            =   0
      Picture         =   "FRM_ACCESO_USUARIO.frx":4B4D
      Top             =   480
      Width           =   2730
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackColor       =   &H80000009&
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
      Height          =   270
      Left            =   2850
      TabIndex        =   4
      Top             =   570
      Width           =   630
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackColor       =   &H80000009&
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
      Left            =   2850
      TabIndex        =   3
      Top             =   1170
      Width           =   450
   End
End
Attribute VB_Name = "FRM_ACCESO_USUARIO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Intentos As Single
Dim vDatos_Retorno()
Private Sub Form_Activate()

   PROC_CARGA_AYUDA Me

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

Dim nOpcion As Integer

    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape))) Then

        Select Case KeyCode
            
            Case vbKeySalir
                
                nOpcion = 2
        
        End Select
        
        If nOpcion > 0 Then
            
            If Tlb_Acceso_Usuario.Buttons(nOpcion).Enabled Then
                
                Tlb_Acceso_Usuario_ButtonClick Tlb_Acceso_Usuario.Buttons(nOpcion)
            
            End If
        
        End If
    
    End If

End Sub

Private Sub Form_Load()

   Me.TxtUsuario = GLB_Usuario_Bac
   Me.TxtClave = ""
  ' Me.Icon = FRM_MDI_PASIVO.Icon

   PROC_CENTRAR_FORMULARIO Me, FRM_MDI_PASIVO
   
End Sub

Private Sub Tlb_Acceso_Usuario_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
      
      Case Is = 1
         
         GLB_Usuario_Bac = Me.TxtUsuario
         TxtClave_KeyPress 13
      
      Case Is = 2
         
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

   If Not IsNumeric(Chr(KeyAscii)) And Not ((UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z") Or UCase(Chr(KeyAscii)) = "Ñ") And KeyAscii <> 13 And KeyAscii <> 8 Then
     
     KeyAscii = 0
   
   End If

   TxtClave.MaxLength = 15
   
   If KeyAscii = 13 Then

      If LTrim(RTrim(TxtUsuario.Text)) = "" Then
         MsgBox "Debe ingresar usuario", vbExclamation
         Exit Sub
      End If

      If FUNC_BLOQUEO_USUARIO(TxtUsuario.Text) Then
      
          MsgBox "Usuario esta Bloqueado", vbOKOnly + vbExclamation
          Call PROC_LOG_AUDITORIA("05", "Trader", Me.Caption & " Usuario Bloqueado- Usuario: " & TxtUsuario.Text, "", "")
          End
          
      End If
      
      If FUNC_VALIDA_USUARIO() Then
         
         If Not FUNC_FECHA_EXPIRACION(GLB_Fecha_Expira) Then
                
                Call PROC_LOG_AUDITORIA("05", "Trader", Me.Caption, "", "")
                Unload Me
                Exit Sub
         
         Else
            If Trim(TxtUsuario.Text) <> "ADMINISTRA" Then
               
               If (MsgBox("La password ha expirado " & Chr(10) & "¿ Desea Cambiarla ?", vbYesNo + vbQuestion)) = vbYes Then
                  
                  Call PROC_LOG_AUDITORIA("05", "Trader", Me.Caption & " Password expirado- Usuario: " & TxtUsuario.Text, "", "")
                  On Error GoTo Errunload
                  FRM_CAMBIO_PASSWORD.Tag = "X"
                  FRM_CAMBIO_PASSWORD.Show vbModal
                  
                  If FUNC_BLOQUEA_USUARIO(True, TxtUsuario.Text) Then
                     
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
         
         If FUNC_BLOQUEA_USUARIO(True, TxtUsuario.Text) And Trim(TxtUsuario.Text) <> "ADMINISTRA" Then
         
            MsgBox "Usuario ha sido Bloqueado", vbOKOnly + vbCritical
            
            GLB_Envia = Array(TxtUsuario.Text)
            
            If FUNC_EXECUTA_COMANDO_SQL("SP_CON_USUARIO", GLB_Envia) Then
            
               If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
               
                     Call PROC_LOG_AUDITORIA("05", "Trader", Me.Caption & " Usuario ha sido Bloqueado- Usuario: " & TxtUsuario.Text, "", "")
                     
               End If
               
            End If

         End If
         
         End
         Exit Sub
         
      End If
         
   End If

   Exit Sub

Errunload:
   
   If Err.Number = 364 Then
      
      End
   
   End If

End Sub

Function FUNC_VALIDA_USUARIO() As Boolean

Dim vDatos_Retorno()
Dim Sql              As String
Dim Password_Usuario As String

    Screen.MousePointer = vbHourglass
    
    FUNC_VALIDA_USUARIO = False
    
    GLB_Usuario_Bac = ""
    GLB_Password_Bac = ""

    GLB_Envia = Array(TxtUsuario.Text)
    
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_PRO_VALIDA_ING_USUARIO", GLB_Envia) Then
        Screen.MousePointer = 0
        Exit Function
    End If

    If Not FUNC_LEE_RETORNO_SQL(vDatos_Retorno) Then
       Screen.MousePointer = 0
       MsgBox "Usuario NO Existe.", vbCritical
       Exit Function
    End If

    GLB_Password = vDatos_Retorno(1)
    GLB_Tipo_Usuario_Bac = vDatos_Retorno(2)
    GLB_Fecha_Expira = vDatos_Retorno(3)
    Glb_Area_Bac = vDatos_Retorno(5)


    If Trim(GLB_Password) <> PROC_ENCRIPTACION(Trim(TxtClave.Text), True) Then
    
       Screen.MousePointer = 0
       MsgBox "Clave Invalida." & Chr(10) & Chr(10) & "Verifique la tecla [Bloq Mayús].", vbExclamation
       Call PROC_LOG_AUDITORIA("05", "Trader", Me.Caption & " Clave invalida- Usuario: " & TxtUsuario.Text, "", "")
       TxtClave.Text = ""
       TxtClave.SetFocus
       Exit Function
       
    End If
    
    Screen.MousePointer = vbDefault

    GLB_Usuario_Bac = TxtUsuario.Text
    GLB_Password_Bac = TxtClave.Text
    GLB_Usuario = TxtUsuario.Text
    GLB_Login_Bac = True
    
    FUNC_VALIDA_USUARIO = True

End Function

Private Sub TxtUsuario_GotFocus()

    TxtUsuario.SelStart = 0
    TxtUsuario.SelLength = Len(TxtUsuario.Text)

End Sub

Private Sub TxtUsuario_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = 27 Then
   
      Unload Me
      
   End If

End Sub

Private Sub TxtUsuario_KeyPress(KeyAscii As Integer)

    TxtUsuario.MaxLength = 15

    PROC_TO_CASE KeyAscii

    If KeyAscii = 13 And Trim(TxtUsuario.Text) <> "" Then TxtClave.SetFocus

End Sub

Private Sub txtUsuario_LostFocus()
    
    GLB_Usuario = Me.TxtUsuario

End Sub
