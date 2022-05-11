VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form Cambio_Clave 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Cambio de Clave"
   ClientHeight    =   1935
   ClientLeft      =   3735
   ClientTop       =   2925
   ClientWidth     =   3885
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Cambio_Clave.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1935
   ScaleWidth      =   3885
   Begin VB.TextBox Txt_clave_confirma 
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
      Left            =   2100
      MaxLength       =   15
      PasswordChar    =   "*"
      TabIndex        =   3
      Top             =   1440
      Width           =   1590
   End
   Begin VB.TextBox Txt_clave_nueva 
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
      Left            =   2100
      MaxLength       =   15
      PasswordChar    =   "*"
      TabIndex        =   2
      Top             =   1110
      Width           =   1590
   End
   Begin VB.TextBox Txt_clave_anterior 
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
      Left            =   2085
      MaxLength       =   15
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   600
      Width           =   1590
   End
   Begin MSComctlLib.Toolbar Tool_opciones 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   3885
      _ExtentX        =   6853
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpia"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Graba"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   3060
         Top             =   90
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
               Picture         =   "Cambio_Clave.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Cambio_Clave.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Cambio_Clave.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Cambio_Clave.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Cambio_Clave.frx":41D2
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Line Line1 
      X1              =   15
      X2              =   3885
      Y1              =   990
      Y2              =   990
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Confirma Clave Nueva"
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
      Left            =   120
      TabIndex        =   6
      Top             =   1470
      Width           =   1800
   End
   Begin VB.Label Label1 
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
      ForeColor       =   &H80000007&
      Height          =   210
      Left            =   915
      TabIndex        =   5
      Top             =   1140
      Width           =   990
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      Caption         =   "Clave Anterior"
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
      Left            =   825
      TabIndex        =   4
      Top             =   645
      Width           =   1185
   End
End
Attribute VB_Name = "Cambio_Clave"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim OptLocal            As String
Dim sCadena             As String
Dim nCaracter           As Integer

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, ""
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

   Case vbKeySalir
      Unload Me

   End Select

End Sub

Private Sub Form_Load()
   OptLocal = Opt
   Me.left = 0
   Me.top = 0
   
'   Frm_clave.Caption = "Usuario : " + Login_Usuario
   
   PROC_LIMPIA
   Me.Caption = Cambio_Clave.Caption
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Sub PROC_LIMPIA()
Screen.MousePointer = 0
Txt_clave_anterior.Text = ""
Txt_clave_nueva.Text = ""
Txt_clave_confirma.Text = ""

Txt_clave_anterior.Enabled = True
Tool_opciones.Buttons(2).Enabled = False
Txt_clave_nueva.Enabled = False
Txt_clave_confirma.Enabled = False

End Sub

Function FUNC_GRABA_CAMBIO_CLAVE() As Boolean

FUNC_GRABA_CAMBIO_CLAVE = False

Envia = Array(Login_Usuario, Encript(Txt_clave_nueva.Text, True))

If Not BAC_SQL_EXECUTE("SP_GRABA_CAMBIO_CLAVE", Envia) Then Exit Function

FUNC_GRABA_CAMBIO_CLAVE = True

End Function

Private Sub Tool_opciones_ButtonClick(ByVal Button As MSComctlLib.Button)

If Button.Index = 2 Then
Screen.MousePointer = 11
   
   If Trim(Txt_clave_nueva.Text) = "" Or Trim(Txt_clave_confirma.Text) = "" Then
      MsgBox "Debe Ingresar Clave Nueva y Confirmación de Clave Nueva.", vbExclamation
      Screen.MousePointer = 0
      Exit Sub
   End If
   
   If Txt_clave_nueva.Text <> Txt_clave_confirma.Text Then
      MsgBox "La Clave Nueva y la Clave Confirmación deben ser Iguales.", vbExclamation
      Screen.MousePointer = 0
      Exit Sub
   End If
   
   If Len(Txt_clave_nueva.Text) < 6 Then
      MsgBox "La Clave debe tener mínimo 6 caracteres", vbOKOnly + vbInformation
      Screen.MousePointer = 0
      Exit Sub
   End If
     
   sCadena = "AABBCCDDEEFFGGHHIIJJKKLLMMNNÑÑOOPPQQRRSSTTUUVVWWXXYYZZ"
   sCadena = sCadena & "aabbccddeeffgghhiijjkkllmmnnññooppqqrrssttuuvvxxyyzz"
   sCadena = sCadena & "11223344556677889900"
   For nCaracter = 1 To Len(sCadena) Step 2
      If Txt_clave_nueva.Text Like "*" & Mid$(sCadena, nCaracter, 2) & "*" Then
         MsgBox "No pueden existir 2 Caracteres iguales consecutivos", vbOKOnly + vbExclamation
         Screen.MousePointer = 0
         Exit Sub
      End If
   Next nCaracter
   
   If Trim(Txt_clave_nueva.Text) = "ADMINISTRA" Then
     MsgBox "Clave no puede ser igual al nombre del Administrador", vbOKOnly + vbExclamation
     Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Usuario: " & NSusuario, "", "")
     Screen.MousePointer = 0
     Exit Sub
   End If

   If MsgBox("Seguro de Grabar ?", 36) <> vbYes Then
     Screen.MousePointer = 0
     Exit Sub
   End If
   
   If Not FUNC_GRABA_CAMBIO_CLAVE() Then
     Screen.MousePointer = 0
     Exit Sub
   End If
End If

   Call LogAuditoria("01", OptLocal, Me.Caption, "", "Usuario: " & NSusuario)
   If Button.Index = 3 Then
      Unload Me
   Exit Sub
End If

PROC_LIMPIA
Txt_clave_anterior.SetFocus
End Sub

Private Sub Txt_clave_anterior_KeyPress(KeyAscii As Integer)
If Not IsNumeric(Chr(KeyAscii)) And Not (UCase(Chr(KeyAscii)) >= "A" And UCase(Chr(KeyAscii)) <= "Z") And KeyAscii <> 13 And KeyAscii <> 8 Then
  KeyAscii = 0
End If

'KeyAscii = LETRA_UPPER(KeyAscii)

If KeyAscii = 13 And Trim(Txt_clave_anterior.Text) <> "" Then
 
   If Not FUNC_VALIDA_CLAVE() Then Exit Sub
   
   Txt_clave_anterior.Enabled = False
   
   Txt_clave_nueva.Enabled = True
   Txt_clave_confirma.Enabled = True
   Tool_opciones.Buttons(2).Enabled = True
   
   Txt_clave_nueva.SetFocus
   
End If
End Sub

Function FUNC_VALIDA_CLAVE() As Boolean
Dim Datos()
Dim Password_Usuario As String

FUNC_VALIDA_CLAVE = False

Envia = Array(Login_Usuario)

If Not BAC_SQL_EXECUTE("SP_VALIDA_INGRESO_USUARIO ", Envia) Then Exit Function

If Not BAC_SQL_FETCH(Datos()) Then
   MsgBox "Usuario NO Existe.", vbCritical
   Exit Function
End If

Password_Usuario = Datos(1)

If Trim(Password_Usuario) <> Encript(Trim(Txt_clave_anterior.Text), True) Then
   MsgBox "Clave Anterior Invalida.", vbExclamation
   Exit Function
End If

FUNC_VALIDA_CLAVE = True

End Function

Private Sub Txt_clave_confirma_KeyPress(KeyAscii As Integer)

   sCadena = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"
   sCadena = sCadena & "abcdefghijklmnñopqrstuvxyz"
   sCadena = sCadena & "1234567890"

   If Not (sCadena Like "*" & Chr(KeyAscii) & "*") And KeyAscii <> 8 And KeyAscii <> 13 Then
      KeyAscii = 0

   End If

'KeyAscii = LETRA_UPPER(KeyAscii)
End Sub

Private Sub Txt_clave_nueva_KeyPress(KeyAscii As Integer)

   sCadena = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"
   sCadena = sCadena & "abcdefghijklmnñopqrstuvxyz"
   sCadena = sCadena & "1234567890"

   If Not (sCadena Like "*" & Chr(KeyAscii) & "*") And KeyAscii <> 8 And KeyAscii <> 13 Then
      KeyAscii = 0

   End If

'KeyAscii = LETRA_UPPER(KeyAscii)

If KeyAscii = 13 And Trim(Txt_clave_nueva.Text) <> "" Then Txt_clave_confirma.SetFocus

End Sub
