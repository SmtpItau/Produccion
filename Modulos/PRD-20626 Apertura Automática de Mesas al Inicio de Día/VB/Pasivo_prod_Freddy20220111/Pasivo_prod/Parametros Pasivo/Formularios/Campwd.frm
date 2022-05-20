VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Cambio_Password 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Cambio de Password"
   ClientHeight    =   1890
   ClientLeft      =   4485
   ClientTop       =   4395
   ClientWidth     =   6570
   Icon            =   "Campwd.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1890
   ScaleWidth      =   6570
   ShowInTaskbar   =   0   'False
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
      Left            =   4380
      PasswordChar    =   "*"
      TabIndex        =   3
      Top             =   1170
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
      Left            =   4380
      PasswordChar    =   "*"
      TabIndex        =   2
      Top             =   1485
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
      Left            =   4380
      PasswordChar    =   "*"
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   840
      Width           =   2025
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6570
      _ExtentX        =   11589
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   5400
         Top             =   -30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   16
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":4BB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":507E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":5575
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":596E
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":5D64
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":62A1
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":6762
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":6C18
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":705C
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Campwd.frx":749E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Image Image1 
      Height          =   1215
      Left            =   90
      Picture         =   "Campwd.frx":7863
      Top             =   570
      Width           =   2730
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
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
      Height          =   210
      Left            =   3240
      TabIndex        =   8
      Top             =   1200
      Width           =   990
   End
   Begin VB.Label Label4 
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
      Height          =   210
      Left            =   2970
      TabIndex        =   7
      Top             =   1530
      Width           =   1260
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
      Left            =   4380
      TabIndex        =   6
      Top             =   510
      Width           =   2025
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
      Height          =   210
      Left            =   3615
      TabIndex        =   5
      Top             =   555
      Width           =   630
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
      Height          =   210
      Left            =   3780
      TabIndex        =   4
      Top             =   885
      Width           =   450
   End
End
Attribute VB_Name = "Cambio_Password"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private clave           As String
Private fecha_expira    As Date
Private cambio_clave    As String
Private Bloqueado       As String
Private clave_anterior1 As String
Private clave_anterior2 As String
Private clave_anterior3 As String
Private Largo_Clave     As Integer
Private Tipo_Clave      As String
Private Dias_Expiracion As Integer
Dim OptLocal As String

Private Sub Cancelar()

   Unload Me

End Sub

Private Sub grabar()
   
   If Len(TxtClaveNueva) < Largo_Clave Then
   
      MsgBox "La Clave Debe Tener un Minimo de " + Str(Largo_Clave) + " Caracteres", vbExclamation
      'TxtClaveNueva.SetFocus
      
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
      MsgBox "Clave no puede ser igual al Nombre de Usuario.", vbCritical, gsBac_Version
      Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Usuario: " & LblUsuario.Caption, "", "")
      Exit Sub
   End If

   If MsgBox("¿Seguro de Grabar?", 36) <> vbYes Then Exit Sub

   If Not FUNC_GRABA_CAMBIO_CLAVE() Then Exit Sub
   
   MsgBox "Clave ha sido cambiada satisfactoriamente.", vbInformation
   Call LogAuditoria("01", OptLocal, Me.Caption, "", "Usuario: " & LblUsuario.Caption)
   Me.Tag = ""
   gsBAC_Pass$ = TxtClaveNueva.Text
   
   Unload Me

End Sub

Function FUNC_GRABA_CAMBIO_CLAVE() As Boolean
   On Error GoTo ErrGraba
    
   FUNC_GRABA_CAMBIO_CLAVE = False
    
   Envia = Array()
   AddParam Envia, LblUsuario.Caption
   AddParam Envia, Encript(TxtClaveNueva.Text, True)
    
   If Not BAC_SQL_EXECUTE("Sp_Graba_Cambio_Clave", Envia) Then
      
      Exit Function
      
   End If
    
   FUNC_GRABA_CAMBIO_CLAVE = True

   Exit Function

ErrGraba:
  
  MsgBox err.Description
  Exit Function
  
End Function


Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   If Me.Tag = "Z" Then
      TxtClave.Enabled = True
   Else
      TxtClave.Text = Acceso_Usuario.TxtClave.Text
      TxtClave.Enabled = False
   End If
   TxtClaveNueva.Enabled = Not TxtClave.Enabled
   TxtClaveConfirma.Enabled = Not TxtClave.Enabled
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer

If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
   Select Case KeyCode

         Case vbKeyGrabar
               opcion = 1
        
         Case vbKeySalir
               opcion = 2
   End Select

   If opcion <> 0 Then
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
      End If
      If opcion = 2 Then
        Unload Me
      End If

   End If

End If


End Sub

Private Sub Form_Load()
   OptLocal = Opt
   Dim Datos()
   Me.Icon = BAC_Parametros.Icon '
   
   If Not BAC_SQL_EXECUTE("Sp_ValoresPassword", Array(gsBAC_User)) Then
      MsgBox "Problemas al leer registro del usuario."
      End
   End If
   If BAC_SQL_FETCH(Datos()) Then
      clave = Encript(CStr(Datos(1)), False)
      fecha_expira = Datos(2)
      cambio_clave = Datos(3)
      Bloqueado = Datos(4)
      clave_anterior1 = IIf(Len(Datos(5)) > 0, Encript(CStr(Datos(5)), False), "")
      clave_anterior2 = IIf(Len(Datos(6)) > 0, Encript(CStr(Datos(6)), False), "")
      clave_anterior3 = IIf(Len(Datos(7)) > 0, Encript(CStr(Datos(7)), False), "")
      Largo_Clave = Datos(8)
      Tipo_Clave = Datos(9)
      Dias_Expiracion = Datos(10)
   End If
   LblUsuario.Caption = gsBAC_User
   TxtClave.MaxLength = 10
   TxtClaveNueva.MaxLength = 10
   TxtClaveConfirma.MaxLength = 10
   TxtClaveNueva.Enabled = False
   TxtClaveConfirma.Enabled = False
   
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub


Private Sub Form_Unload(Cancel As Integer)
   If Trim(Me.Tag) = "X" Then
      End
   End If
   
   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call grabar
      Case 2
         Call Cancelar
   End Select
End Sub


Private Sub TxtClave_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
   
      If Trim(TxtClave.Text) = "" Then
         
         MsgBox "Clave actual no ha sido ingresada.", vbCritical
         TxtClave.SetFocus
         Exit Sub
      
      ElseIf Trim(TxtClave.Text) <> gsBAC_Pass$ Then
         
         MsgBox "Clave actual no es válida.", vbCritical
         TxtClave.SetFocus
         Exit Sub
      
      End If
      
      If Len(TxtClave.Text) < Largo_Clave Then
      
         MsgBox "La Clave Debe Tener un Minimo de " & Largo_Clave & " Caracteres", vbExclamation
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
      TxtClaveNueva.SetFocus
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
   
   If KeyAscii = 13 Then
   
      TxtClaveConfirma.SetFocus
   
   End If
      
End Sub

Private Sub TxtClaveNueva_LostFocus()
   
   If Trim(TxtClaveNueva.Text) = "" Then
      MsgBox "Clave nueva no ha sido ingresada.", vbCritical
      TxtClaveNueva.SetFocus
      Exit Sub
   End If
   If TxtClaveNueva.Text = clave Or TxtClaveNueva.Text = clave_anterior1 Or _
      TxtClaveNueva.Text = clave_anterior2 Or TxtClaveNueva.Text = clave_anterior3 Then
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

