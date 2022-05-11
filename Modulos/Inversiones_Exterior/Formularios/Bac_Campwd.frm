VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Cambio_Password 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Cambio Clave"
   ClientHeight    =   2340
   ClientLeft      =   4695
   ClientTop       =   2625
   ClientWidth     =   4995
   Icon            =   "Bac_Campwd.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2340
   ScaleWidth      =   4995
   ShowInTaskbar   =   0   'False
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
      TabIndex        =   2
      Top             =   1365
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
      Top             =   1755
      Width           =   2025
   End
   Begin VB.PictureBox Picture1 
      Height          =   1200
      Left            =   120
      Picture         =   "Bac_Campwd.frx":030A
      ScaleHeight     =   1140
      ScaleWidth      =   1155
      TabIndex        =   5
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
      TabIndex        =   1
      Top             =   990
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
            Picture         =   "Bac_Campwd.frx":4A48
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Campwd.frx":4B5A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   4
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
      TabIndex        =   9
      Top             =   1440
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
      Left            =   1500
      TabIndex        =   8
      Top             =   1830
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
      TabIndex        =   0
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
      Left            =   2100
      TabIndex        =   7
      Top             =   675
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
      Left            =   2235
      TabIndex        =   6
      Top             =   1080
      Width           =   495
   End
End
Attribute VB_Name = "Cambio_Password"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Function FUNC_GRABA_CAMBIO_CLAVE() As Boolean
   Dim datos()

   Dim dFechaHabil As Date
   
   On Error GoTo ErrGraba
   
   dFechaHabil = DateAdd("d", nDiasClave, gsBac_Fecp) 'Suma los días de expiración a la fecha de proceso
   Let dFechaExpiracion = dFechaHabil
   
   FUNC_GRABA_CAMBIO_CLAVE = False
   
   Envia = Array(LblUsuario.Caption, _
                 Encript(TxtClave.Text, True), _
                 Encript(TxtClaveNueva.Text, True), _
                 Encript(TxtClaveConfirma.Text, True), _
                 dFechaExpiracion, gsBac_Fecp)
       
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_GRABA_CAMBIO_CLAVE ", Envia) Then
      Exit Function
   End If
   
   If Bac_SQL_Fetch(datos()) Then
      If datos(1) < 0 Then
         MsgBox datos(2), vbExclamation, App.Title
         Exit Function
      End If
   End If
    
   FUNC_GRABA_CAMBIO_CLAVE = True
   
Exit Function
ErrGraba:
   MsgBox err.Description
End Function

Private Sub Form_Load()
   LblUsuario.Caption = gsBac_User
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Key
      Case "Grabar"
         giAceptar = True

         If Trim(nTipoClave) = "A" Then
            If ValidaAlfanumerico(TxtClaveNueva.Text) = False Then
              Call MsgBox("Recuerde que la Password debe estar conformada por números, letras y una letra mayúscula.", vbExclamation, App.Title)
              Exit Sub
            End If
         End If
            
         Toolbar1.Buttons(1).Enabled = True

         If MsgBox("¿Está seguro de grabar?", vbQuestion + vbYesNo) = vbNo Then
            End
         End If
            
         If Not FUNC_GRABA_CAMBIO_CLAVE() Then
           Exit Sub
         End If
         Unload Me

      Case "Salir"
         If oBligacion = True Then
            End
         Else
            Unload Me
         End If
         
         'Unload Me
   End Select
End Sub

Private Sub TxtClave_KeyPress(KeyAscii As Integer)
   
   'cs req.4116
   If Not CompruebaPWD(nTipoClave, KeyAscii) Then
      KeyAscii = 0
      Exit Sub
   End If
 
   If KeyAscii = vbKeyReturn Then
      
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
   Dim datos()
   Dim Password_Usuario As String
   
   FUNC_VALIDA_CLAVE = False
   
   Envia = Array()
   AddParam Envia, LblUsuario.Caption
   AddParam Envia, Encript(TxtClave.Text, True)
   
   If Not Bac_Sql_Execute("bacparamsuda..SP_VALIDA_INGRESO_USUARIO ", Envia) Then
      Exit Function
   End If
   
   If Bac_SQL_Fetch(datos()) Then
      If datos(1) < 0 Then
        MsgBox datos(2), vbExclamation, App.Title
        Exit Function
      End If
   End If
   
   Password_Usuario = datos(1)
  
   FUNC_VALIDA_CLAVE = True
End Function

Private Sub TxtClave_LostFocus()
      If Not FUNC_VALIDA_CLAVE() Then
         TxtClave.SetFocus
         Exit Sub
      End If
      
      TxtClave.Enabled = False
      TxtClaveNueva.Enabled = True
      TxtClaveConfirma.Enabled = True
      TxtClaveNueva.SetFocus

End Sub

Private Sub TxtClaveConfirma_KeyPress(KeyAscii As Integer)
   
   'cs req.4116
   If Not CompruebaPWD(nTipoClave, KeyAscii) Then
      KeyAscii = 0
      Exit Sub
   End If
   
   If KeyAscii = 13 And Trim(TxtClaveConfirma.Text) <> "" Then
      TxtClaveNueva.SetFocus
   End If

End Sub


Private Sub TxtClaveConfirma_LostFocus()
   Call ValidaAlfanumerico(TxtClave.Text)
End Sub

Private Sub TxtClaveNueva_KeyPress(KeyAscii As Integer)
   
   'cs req.4116
   If Not CompruebaPWD(nTipoClave, KeyAscii) Then
      KeyAscii = 0
      Exit Sub
   End If
   
   If KeyAscii = vbKeyReturn And Trim(TxtClaveNueva.Text) <> "" Then
      Toolbar1.Buttons(1).Enabled = True
       TxtClaveConfirma.SetFocus
   End If

End Sub



