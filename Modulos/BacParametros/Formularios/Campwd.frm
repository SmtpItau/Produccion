VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Cambio_Password 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Cambio Clave"
   ClientHeight    =   2505
   ClientLeft      =   4695
   ClientTop       =   2625
   ClientWidth     =   4995
   Icon            =   "Campwd.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2505
   ScaleWidth      =   4995
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox TxtClaveNueva 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      IMEMode         =   3  'DISABLE
      Left            =   2880
      MaxLength       =   15
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   1560
      Width           =   2025
   End
   Begin VB.TextBox TxtClaveConfirma 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      IMEMode         =   3  'DISABLE
      Left            =   2880
      MaxLength       =   15
      PasswordChar    =   "*"
      TabIndex        =   3
      Top             =   2040
      Width           =   2025
   End
   Begin VB.PictureBox Picture1 
      Height          =   1200
      Left            =   120
      Picture         =   "Campwd.frx":030A
      ScaleHeight     =   1140
      ScaleWidth      =   1155
      TabIndex        =   2
      Top             =   555
      Width           =   1215
   End
   Begin VB.TextBox TxtClave 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      IMEMode         =   3  'DISABLE
      Left            =   2880
      MaxLength       =   15
      PasswordChar    =   "*"
      TabIndex        =   0
      Top             =   1080
      Width           =   2025
   End
   Begin MSComctlLib.ImageList imlImagenes 
      Left            =   4000
      Top             =   0
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
            Picture         =   "Campwd.frx":4A48
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Campwd.frx":4B5A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   9
      Top             =   0
      Width           =   4995
      _ExtentX        =   8811
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "imlImagenes"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Clave Nueva"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   1680
      TabIndex        =   8
      Top             =   1560
      Width           =   1110
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      Caption         =   "Confirma Clave"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   1440
      TabIndex        =   7
      Top             =   2040
      Width           =   1290
   End
   Begin VB.Label LblUsuario 
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   360
      Left            =   2880
      TabIndex        =   6
      Top             =   600
      Width           =   2025
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
      Height          =   195
      Left            =   2040
      TabIndex        =   5
      Top             =   600
      Width           =   660
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Clave"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   2160
      TabIndex        =   4
      Top             =   1080
      Width           =   495
   End
End
Attribute VB_Name = "Cambio_Password"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public dFechaExpiracion  As Date 'cs req.4146
Public oObligacion       As Boolean

Private Sub cmdCancelar_Click()

   Unload Me

End Sub


Private Sub cmdGrabar_Click()

   If Trim(TxtClaveNueva.Text) = "" Or Trim(TxtClaveConfirma.Text) = "" Then
      
      MsgBox "Debe Ingresar Clave Nueva y Confirmación de Clave Nueva.", vbCritical, gsBac_Version
      Exit Sub
      
   End If
   
   If TxtClaveNueva.Text <> TxtClaveConfirma.Text Then
   
      MsgBox "La Clave Nueva y la Clave Confirmación deben ser Iguales.", vbCritical, gsBac_Version
      Exit Sub
      
   End If

   If MsgBox("Seguro de Grabar ?", 36, gsBac_Version) <> vbYes Then Exit Sub

   If Not FUNC_GRABA_CAMBIO_CLAVE() Then Exit Sub
   
   MsgBox "Clave Cambiada.", 64, gsBac_Version
   Me.Tag = ""
   
   Unload Me

End Sub

Function FUNC_GRABA_CAMBIO_CLAVE() As Boolean
   
   On Error GoTo ErrGraba
   
    FUNC_GRABA_CAMBIO_CLAVE = False
   
   Envia = Array(LblUsuario.Caption, _
                Encript(TxtClaveNueva.Text, True), _
                dFechaExpiracion)
    
   If Not Bac_Sql_Execute("SP_GRABA_CAMBIO_CLAVE ", Envia()) Then
   
     Exit Function
      
   End If
     
   If Bac_SQL_Fetch(Datos()) Then 'cs req.4146
    If Datos(1) < 0 Then
       MsgBox Datos(2), vbExclamation, App.Title
       Exit Function
    End If
   End If
     
   FUNC_GRABA_CAMBIO_CLAVE = True
   
   Exit Function
   
ErrGraba:
   MsgBox Err.Description
   Exit Function
     
End Function

Private Sub Form_Load()

'   If Trim(gsBAC_User) = "ADMINISTRA" Then
'     MsgBox "Clave de Administrador no puede ser cambiada desde el sistema", vbOKOnly + vbExclamation
'     Unload Me
'     Exit Sub
'   End If
   Call Acceso_Usuario.Busca_Tipo_Clave(gsBAC_User)
   
   LblUsuario.Caption = gsBAC_User
 End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   giAceptar = False
    
   Select Case Button.Key
     Case "Grabar"
    
            giAceptar = True
            
            If Trim(TxtClaveNueva.Text) = "" Or Trim(TxtClaveConfirma.Text) = "" Then
              MsgBox "Debe Ingresar Clave Nueva y Confirmación de Clave Nueva.", vbCritical, gsBac_Version
              Exit Sub
            End If
            
            If TxtClaveNueva.Text <> TxtClaveConfirma.Text Then
              MsgBox "La Clave Nueva y la Clave Confirmación deben ser Iguales.", vbCritical, gsBac_Version
              Exit Sub
            End If
            
            'cs req.4146
            If Trim(Acceso_Usuario.nTipoClave) = "A" Then
              If ValidaAlfanumerico(TxtClaveNueva.Text) = False Then
                 MsgBox "La clave debe ser Alfanumerica.", vbCritical, gsBac_Version
                 Exit Sub
              End If
            End If
            
         Toolbar1.Buttons(1).Enabled = True
         If Len(TxtClaveConfirma.Text) < largo_clave Then
            Call MsgBox("El largo minimo de la clave, debe ser igual a " & largo_clave & ".", vbExclamation, App.Title)
            Toolbar1.Buttons(1).Enabled = False
            Exit Sub
         End If
            
            
         If MsgBox("¿ Está seguro de grabar ?", vbQuestion + vbYesNo, App.Title) <> vbYes Then
            Exit Sub
         End If
            
            If Encript(TxtClaveNueva.Text, True) = Encript(TxtClave.Text, True) Then
              MsgBox "Esta clave ya fue usada con anterioridad.", vbInformation, TITSISTEMA
            Else
            If Not FUNC_GRABA_CAMBIO_CLAVE() Then
               Exit Sub
            End If
            
               MsgBox "La Clave fue Cambiada satisfactoriamente.", 64, gsBac_Version & TITSISTEMA
               Me.Tag = ""
               
               Unload Me
            End If
            
    Case "Salir"
         If Me.oObligacion = True Then
            End
         Else
           Unload Me
         End If
    End Select
    
End Sub
Function ValidaAlfanumerico(Valor As String)
    Dim cont_num As Integer
    Dim cont_alf As Integer
    Dim i As Integer
    
    ValidaAlfanumerico = False
    cont_num = 0
    cont_alf = 0
    
    For i = 1 To Len(Valor)
        If IsNumeric(Mid(Valor, i, 1)) Then
            cont_num = cont_num + 1
        End If
        
        If InStr("ABCDEFGHIJKLMNÑOPQRSTWVXYZ", UCase(Mid(Valor, i, 1))) > 0 Then
            cont_alf = cont_alf + 1
        End If
    Next
    
    If cont_alf > 0 And cont_num > 0 Then
        ValidaAlfanumerico = True
    End If
    
End Function

Private Sub TxtClave_KeyPress(KeyAscii As Integer)
  ' TxtClave.MaxLength = 12

  ' If Not IsNumeric(Chr(KeyAscii)) And Not (UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z") And KeyAscii <> 13 And KeyAscii <> 8 Then
  '    KeyAscii = 0
  ' End If

   'cs req.4116
   If Not Cambio_Clave.CompruebaPWD(Acceso_Usuario.nTipoClave, KeyAscii) Then
      KeyAscii = 0
      Exit Sub
   End If

   If KeyAscii = vbKeyReturn Then ' And Trim(TxtClave.Text) <> "" Then
      If Not FUNC_VALIDA_CLAVE() Then
         Exit Sub
      End If
      
      TxtClave.Enabled = False
      TxtClaveNueva.Enabled = True
      TxtClaveConfirma.Enabled = True
      
      TxtClaveNueva.SetFocus
      
   End If

End Sub


Function FUNC_VALIDA_CLAVE() As Boolean
   Dim Datos()
   Dim Password_Usuario As String

   FUNC_VALIDA_CLAVE = False
   
   Envia = Array(LblUsuario.Caption)
   
   If Not Bac_Sql_Execute(giSQL_DatabaseCommon & "..SP_VALIDA_INGRESO_USUARIO ", Envia) Then
      
      MsgBox "Usuario NO Existe.", vbCritical, gsBac_Version
      Exit Function
   End If
   
   If Bac_SQL_Fetch(Datos()) Then
   
      Password_Usuario = Datos(1)
   
   End If
   
   If Trim(Password_Usuario) <> Encript(Trim(TxtClave.Text), True) Then
      
      MsgBox "Clave Invalida." & Chr(10) & Chr(10) & "Verifique la tecla [Bloq Mayús].", vbExclamation
      Exit Function
   
   End If
   
   FUNC_VALIDA_CLAVE = True

End Function

Private Sub TxtClaveConfirma_KeyPress(KeyAscii As Integer)
   
 '  If Not IsNumeric(Chr(KeyAscii)) And Not (UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z") And KeyAscii <> 13 And KeyAscii <> 8 Then
  '    KeyAscii = 0
  ' End If
     
      'cs req.4116
   If Not Cambio_Clave.CompruebaPWD(Acceso_Usuario.nTipoClave, KeyAscii) Then
      KeyAscii = 0
      Exit Sub
   End If
     
   If KeyAscii <> vbKeyReturn And KeyAscii <> 8 Then
      Select Case tipo_clave
         Case Is = "N"
            If Not IsNumeric(Chr(KeyAscii)) Then
               KeyAscii = 0
            End If
         Case Is = "C"
            If Not UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z" Then
               KeyAscii = 0
            End If
      End Select
      
   ElseIf KeyAscii = vbKeyReturn And Trim(TxtClaveConfirma.Text) <> "" Then
      Me.Toolbar1.Buttons(1).Enabled = True
'      If Len(TxtClaveConfirma.Text) < largo_clave Then
'         Call MsgBox("El largo minimo de la clave, debe ser igual a " & largo_clave & ".", vbExclamation, App.Title)
'         Me.Toolbar1.Buttons(1).Enabled = False
'         Exit Sub
'      End If
      TxtClaveNueva.SetFocus
   End If

End Sub



Private Sub TxtClaveNueva_KeyPress(KeyAscii As Integer)

   If Not Cambio_Clave.CompruebaPWD(Acceso_Usuario.nTipoClave, KeyAscii) Then
      KeyAscii = 0
      Exit Sub
   End If


'   If Not IsNumeric(Chr(KeyAscii)) And Not (UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z") And KeyAscii <> 13 And KeyAscii <> 8 Then
 '     KeyAscii = 0
  ' End If

    If KeyAscii <> 13 And KeyAscii <> 8 Then
      
      Select Case tipo_clave
         Case Is = "N"
            If Not IsNumeric(Chr(KeyAscii)) Then
               KeyAscii = 0
            End If
         Case Is = "C"
            If Not UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z" Then
               KeyAscii = 0
            End If
      End Select
   
   End If
   
   If KeyAscii = 13 And Trim(TxtClaveNueva.Text) <> "" Then
   
      Me.Toolbar1.Buttons(1).Enabled = True
'      If Len(TxtClaveNueva.Text) < largo_clave Then
'         Call MsgBox("El largo minimo de la clave, debe ser igual a " & largo_clave & ".", vbExclamation, App.Title)
'         Me.Toolbar1.Buttons(1).Enabled = False
'         Exit Sub
'      End If
      TxtClaveConfirma.SetFocus
   
   End If

End Sub

Private Sub TxtClaveNueva_LostFocus()
If Len(TxtClaveNueva.Text) < largo_clave Then
    MsgBox "La nueva clave debe tener un minimo de " & largo_clave & " Caracteres.", vbInformation, TITSISTEMA
End If
End Sub
