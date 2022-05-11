VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Bac_Anulacion_Password 
   Caption         =   "Password De Anulación"
   ClientHeight    =   2055
   ClientLeft      =   2250
   ClientTop       =   3720
   ClientWidth     =   4620
   LinkTopic       =   "Form1"
   ScaleHeight     =   2055
   ScaleWidth      =   4620
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   4620
      _ExtentX        =   8149
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Confirmar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
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
      ForeColor       =   &H00000000&
      Height          =   360
      Left            =   2460
      TabIndex        =   1
      Top             =   795
      Width           =   2040
   End
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
      ForeColor       =   &H00000000&
      Height          =   360
      IMEMode         =   3  'DISABLE
      Left            =   2475
      MaxLength       =   15
      PasswordChar    =   "*"
      TabIndex        =   2
      Top             =   1290
      Width           =   2025
   End
   Begin VB.PictureBox Picture1 
      DrawStyle       =   5  'Transparent
      Height          =   1200
      Left            =   195
      Picture         =   "bac_anul_pass.frx":0000
      ScaleHeight     =   1140
      ScaleWidth      =   1155
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   660
      Width           =   1215
   End
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   1590
      Top             =   1470
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
            Picture         =   "bac_anul_pass.frx":473E
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anul_pass.frx":4A58
            Key             =   ""
         EndProperty
      EndProperty
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
      Height          =   240
      Left            =   1560
      TabIndex        =   4
      Top             =   840
      Width           =   825
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
      Height          =   240
      Left            =   1755
      TabIndex        =   3
      Top             =   1185
      Width           =   615
   End
End
Attribute VB_Name = "Bac_Anulacion_Password"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Function Buscar_Usuario()
    Dim datos()
    giAceptar% = True
    envia = Array()
    AddParam envia, TxtUsuario.Text
    AddParam envia, TxtClave.Text
    If Bac_Sql_Execute("SVC_ANU_CTR_PAS", envia) Then
        Do While Bac_SQL_Fetch(datos)
            If datos(1) = "2" Then
                MsgBox datos(2), vbInformation, gsBac_Version
                giAceptar% = False
                Unload Me
            End If
        Loop
    End If
    Unload Me
End Function

Private Sub TB_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Call TxtClave_LostFocus
        Case 2
            giAceptar% = False
            Unload Me
    End Select
End Sub


Private Sub Form_Load()
    Me.Icon = BAC_INVERSIONES.Icon
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            TxtClave_LostFocus
        Case 2
            giAceptar% = False
            Unload Me
    End Select
End Sub

Private Sub TxtClave_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub


Private Sub TxtClave_LostFocus()
    Call Buscar_Usuario
End Sub


