VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_CAMBIO_PASSWORD 
   BackColor       =   &H80000009&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Cambio Clave"
   ClientHeight    =   1905
   ClientLeft      =   2325
   ClientTop       =   2715
   ClientWidth     =   5760
   Icon            =   "FRM_CAMBIO_PASSWORD.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1905
   ScaleWidth      =   5760
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox TxtClaveNueva 
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
      IMEMode         =   3  'DISABLE
      Left            =   3690
      PasswordChar    =   "*"
      TabIndex        =   3
      Top             =   1245
      Width           =   2025
   End
   Begin VB.TextBox TxtClaveConfirma 
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
      IMEMode         =   3  'DISABLE
      Left            =   3690
      PasswordChar    =   "*"
      TabIndex        =   2
      Top             =   1560
      Width           =   2025
   End
   Begin VB.TextBox TxtClave 
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
      IMEMode         =   3  'DISABLE
      Left            =   3690
      PasswordChar    =   "*"
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   915
      Width           =   2025
   End
   Begin MSComctlLib.Toolbar Tlb_Cambio_Password 
      Height          =   450
      Left            =   0
      Negotiate       =   -1  'True
      TabIndex        =   0
      Top             =   0
      Width           =   960
      _ExtentX        =   1693
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
         Left            =   4320
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
               Picture         =   "FRM_CAMBIO_PASSWORD.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CAMBIO_PASSWORD.frx":337A
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CAMBIO_PASSWORD.frx":3865
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CAMBIO_PASSWORD.frx":3F45
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CAMBIO_PASSWORD.frx":46C2
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackColor       =   &H80000009&
      Caption         =   "Clave Nueva"
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
      Left            =   2610
      TabIndex        =   8
      Top             =   1275
      Width           =   990
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      BackColor       =   &H80000009&
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
      Left            =   2340
      TabIndex        =   7
      Top             =   1605
      Width           =   1260
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
      Height          =   210
      Left            =   2985
      TabIndex        =   5
      Top             =   630
      Width           =   630
   End
   Begin VB.Image Image1 
      Height          =   1215
      Left            =   0
      Picture         =   "FRM_CAMBIO_PASSWORD.frx":4B4D
      Top             =   540
      Width           =   2730
   End
   Begin VB.Label LblUsuario 
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   315
      Left            =   3690
      TabIndex        =   6
      Top             =   585
      Width           =   2025
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
      Left            =   3150
      TabIndex        =   4
      Top             =   960
      Width           =   450
   End
End
Attribute VB_Name = "FRM_CAMBIO_PASSWORD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private cClave             As String
Private dFecha_Expira      As Date
Private cCambio_Clave      As String
Private cBloqueado         As String
Private cClave_Anterior1   As String
Private cClave_Anterior2   As String
Private cClave_Anterior3   As String
Private nLargo_Clave       As Integer
Private cTipo_Clave        As String
Private nDias_Expiracion   As Integer
Dim cOptLocal              As String

Private Sub PROC_CANCELAR_CAMBIO()

   Unload Me

End Sub

Private Sub PROC_GRABAR_CAMBIO()
   
   Dim cCadena    As String
   Dim nCaracter  As Integer
   
   If Len(TxtClaveNueva) < nLargo_Clave Then
   
      MsgBox "La Clave Debe Tener un Minimo de " + Str(Largo_Clave) + " Caracteres", vbExclamation
      If TxtClaveNueva.Enabled Then
         TxtClaveNueva.SetFocus
      End If
      Exit Sub
   
   End If
   
   
   If TxtClaveNueva.Text = "" Then
      MsgBox "Primero Debe Ingresar una Clave.", vbCritical
      Exit Sub
   End If
   
   If TxtClaveNueva.Text <> TxtClaveConfirma.Text Then
      MsgBox "La Clave Nueva y la Clave Confirmación deben ser Iguales.", vbCritical
      Exit Sub
   End If
   
   sCadena = "AABBCCDDEEFFGGHHIIJJKKLLMMNNÑÑOOPPQQRRSSTTUUVVWWXXYYZZ"
   sCadena = sCadena & "aabbccddeeffgghhiijjkkllmmnnññooppqqrrssttuuvvxxyyzz"
   sCadena = sCadena & "11223344556677889900"
   
   For nCaracter = 1 To Len(sCadena) Step 2
   
      If TxtClaveNueva.Text Like "*" & Mid$(sCadena, nCaracter, 2) & "*" Then
      
         MsgBox "No pueden existir 2 caracteres iguales consecutivos en la Clave.", vbCritical
         Screen.MousePointer = 0
         Exit Sub
         
      End If
      
   Next nCaracter
   
   If Trim(LblUsuario.Caption) = Trim(TxtClaveNueva.Text) Then
   
      MsgBox "Clave no puede ser igual al Nombre de Usuario.", vbCritical
      Call PROC_LOG_AUDITORIA("01", cOptLocal, Me.Caption & " Error al grabar- Usuario: " & LblUsuario.Caption, "", "")
      Exit Sub
      
   End If

   If MsgBox("¿Seguro de Grabar?", 36) <> vbYes Then Exit Sub

   If Not FUNC_GRABA_CAMBIO_CLAVE() Then Exit Sub
   
      MsgBox "Clave ha sido cambiada satisfactoriamente.", vbInformation
      Call PROC_LOG_AUDITORIA("01", cOptLocal, Me.Caption, "", "Usuario: " & LblUsuario.Caption)
      Me.Tag = ""
      GLB_Password = TxtClaveNueva.Text
   
   Unload Me

End Sub

Function FUNC_GRABA_CAMBIO_CLAVE() As Boolean

   On Error GoTo ErrGraba
    
   FUNC_GRABA_CAMBIO_CLAVE = False
    
   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, LblUsuario.Caption
   PROC_AGREGA_PARAMETRO GLB_Envia, PROC_ENCRIPTACION(TxtClaveNueva.Text, True)
    
   If Not FUNC_EXECUTA_COMANDO_SQL("SP_ACT_CLAVE", GLB_Envia) Then
      
      Exit Function
      
   End If
    
   FUNC_GRABA_CAMBIO_CLAVE = True

   Exit Function

ErrGraba:
  
  MsgBox Err.Description, vbExclamation
  Exit Function
  
End Function

Private Sub Form_Activate()
   
   PROC_CARGA_AYUDA Me
   
   If Me.Tag = "Z" Then
      
      TxtClave.Enabled = True
   
   Else
      
      TxtClave.Text = FRM_ACCESO_USUARIO.TxtClave.Text
      TxtClave.Enabled = False
   
   End If
   
   TxtClaveNueva.Enabled = Not TxtClave.Enabled
   TxtClaveConfirma.Enabled = Not TxtClave.Enabled

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim nOpcion As Integer
   
   nOpcion = 0
   
   If KeyCode = vbKeyReturn Then
      KeyCode = 0
      FUNC_ENVIA_TECLA vbKeyTab
      Exit Sub
   End If
   
    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
   
      Select Case KeyCode
      
         Case vbKeyGrabar:
                           nOpcion = 1
         
         Case vbKeySalir:
                           nOpcion = 2
         
      End Select
      
      If nOpcion <> 0 Then
         KeyCode = 0
         If Tlb_Cambio_Password.Buttons(nOpcion).Enabled Then
            Call Tlb_Cambio_Password_ButtonClick(Tlb_Cambio_Password.Buttons(nOpcion))
         End If
      
      End If
      
   End If
   
End Sub

Private Sub Form_Load()

   Dim vDatos_Retorno()
      
   cOptLocal = GLB_Opcion_Menu
 
   Me.Icon = FRM_MDI_PASIVO.Icon
   
   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, GLB_Usuario_Bac
   
   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_VALOR_PASSWORD", GLB_Envia) Then
   
      MsgBox "Problemas al leer registro del usuario.", vbExclamation
      End
      
   End If
   
   If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
   
      cClave = PROC_ENCRIPTACION(CStr(vDatos_Retorno(1)), False)
      dFecha_Expira = vDatos_Retorno(2)
      cCambio_Clave = vDatos_Retorno(3)
      cBloqueado = vDatos_Retorno(4)
      cClave_Anterior1 = IIf(Len(vDatos_Retorno(5)) > 0, PROC_ENCRIPTACION(CStr(vDatos_Retorno(5)), False), "")
      cClave_Anterior2 = IIf(Len(vDatos_Retorno(6)) > 0, PROC_ENCRIPTACION(CStr(vDatos_Retorno(6)), False), "")
      cClave_Anterior3 = IIf(Len(vDatos_Retorno(7)) > 0, PROC_ENCRIPTACION(CStr(vDatos_Retorno(7)), False), "")
      nLargo_Clave = vDatos_Retorno(8)
      cTipo_Clave = vDatos_Retorno(9)
      nDias_Expiracion = vDatos_Retorno(10)
      
   End If
   
   LblUsuario.Caption = GLB_Usuario_Bac
   TxtClave.MaxLength = 15
   TxtClaveNueva.MaxLength = 15
   TxtClaveConfirma.MaxLength = 15
   TxtClaveNueva.Enabled = False
   TxtClaveConfirma.Enabled = False
   
   Call PROC_LOG_AUDITORIA("07", cOptLocal, Me.Caption, "", "")

End Sub

Private Sub Form_Unload(Cancel As Integer)
   
   If Trim(Me.Tag) = "X" Then
      
      End
   
   End If
   
   Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption, "", "")

End Sub

Private Sub Tlb_Cambio_Password_ButtonClick(ByVal Button As MSComctlLib.Button)
   
   Select Case Button.Index
      
      Case 1
         
         Call PROC_GRABAR_CAMBIO
      
      Case 2
         
         Call PROC_CANCELAR_CAMBIO
   
   End Select

End Sub

Private Sub TxtClave_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
   
      If Trim(TxtClave.Text) = "" Then
         
         MsgBox "Clave actual no ha sido ingresada.", vbCritical
         TxtClave.SetFocus
         Exit Sub
      
      ElseIf Trim(TxtClave.Text) <> GLB_Password Then
         
         MsgBox "Clave actual no es válida.", vbCritical
         TxtClave.SetFocus
         Exit Sub
      
      End If
      
      If Len(TxtClave.Text) < nLargo_Clave Then
      
         MsgBox "La Clave Debe Tener un Minimo de " & nLargo_Clave & " Caracteres", vbExclamation
         TxtClave.SetFocus
         Exit Sub
         
      End If
      
      TxtClaveNueva.Enabled = True
      TxtClaveConfirma.Enabled = True
      TxtClave.Enabled = False
   
   End If

End Sub

Private Sub TxtClaveConfirma_KeyPress(KeyAscii As Integer)

   If KeyAscii <> 13 And KeyAscii <> 8 Then
   
      Select Case Tipo_Clave
      
         Case Is = "N"
         
            If Not IsNumeric(Chr(KeyAscii)) Then
            
               KeyAscii = 0
               
            End If
            
         Case Is = "C"
         
            If Not UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z" Then
            
               KeyAscii = 0
               
            End If
            
      End Select
      
   ElseIf KeyAscii = 13 And Trim(TxtClaveConfirma.Text) <> "" Then
   
   End If
End Sub

Private Sub TxtClaveNueva_KeyPress(KeyAscii As Integer)


   If KeyAscii <> 13 And KeyAscii <> 8 Then
      Select Case Tipo_Clave
      
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
   
End Sub

Private Sub TxtClaveNueva_LostFocus()
   
   If Trim(TxtClaveNueva.Text) = "" Then
   
      MsgBox "Clave nueva no ha sido ingresada.", vbCritical
      TxtClaveNueva.SetFocus
      Exit Sub
      
   End If
   
   If TxtClaveNueva.Text = clave Or TxtClaveNueva.Text = clave_anterior1 Or TxtClaveNueva.Text = clave_anterior2 Or TxtClaveNueva.Text = clave_anterior3 Then
      
      MsgBox "Clave fue utilizada anteriormente.", vbExclamation
      TxtClaveNueva.SetFocus
      Exit Sub
      
   End If

   If Len(TxtClaveNueva) < Largo_Clave Then
   
      MsgBox "La Clave Debe Tener un Minimo de " + Str(Largo_Clave) + " Caracteres", vbExclamation
      TxtClaveNueva.SetFocus
      Exit Sub
   
   End If

End Sub
