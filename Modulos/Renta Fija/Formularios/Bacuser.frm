VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Frm_BloqUs 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Funciones de Usuarios"
   ClientHeight    =   4815
   ClientLeft      =   1290
   ClientTop       =   2040
   ClientWidth     =   6945
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacuser.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4815
   ScaleWidth      =   6945
   Begin Threed.SSFrame SSFrame1 
      Height          =   3015
      Left            =   3495
      TabIndex        =   7
      Top             =   1680
      Width           =   3375
      _Version        =   65536
      _ExtentX        =   5953
      _ExtentY        =   5318
      _StockProps     =   14
      Caption         =   "Doc.Bloqueados por sistema"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ListBox List1 
         Enabled         =   0   'False
         Height          =   2085
         Left            =   120
         Style           =   1  'Checkbox
         TabIndex        =   8
         Top             =   360
         Width           =   3105
      End
      Begin Threed.SSCommand SSCommand1 
         Height          =   300
         Left            =   720
         TabIndex        =   9
         TabStop         =   0   'False
         Top             =   2640
         Width           =   1545
         _Version        =   65536
         _ExtentX        =   2725
         _ExtentY        =   529
         _StockProps     =   78
         Caption         =   "Seleccionar Todos"
         ForeColor       =   8388608
         Font3D          =   2
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   6945
      _ExtentX        =   12250
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbdesbloquear"
            Description     =   "DESBLOQUEAR"
            Object.ToolTipText     =   "Desbloquear"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbsalir"
            Description     =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2715
      Top             =   5055
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
            Picture         =   "Bacuser.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacuser.frx":0624
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Height          =   1200
      Left            =   100
      TabIndex        =   3
      Top             =   480
      Width           =   6765
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
         Height          =   300
         Left            =   1515
         MouseIcon       =   "Bacuser.frx":093E
         MousePointer    =   99  'Custom
         TabIndex        =   0
         Top             =   780
         Width           =   1455
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Desbloqueo de Documentos"
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
         Left            =   690
         TabIndex        =   5
         Top             =   210
         Width           =   2985
      End
      Begin VB.Image Image1 
         Height          =   480
         Left            =   60
         Picture         =   "Bacuser.frx":0C48
         Top             =   150
         Width           =   480
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
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
         Left            =   780
         TabIndex        =   4
         Top             =   825
         Width           =   675
      End
   End
   Begin Threed.SSCommand Command2 
      Height          =   450
      Left            =   1260
      TabIndex        =   2
      Top             =   5100
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Salir"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin Threed.SSCommand Cmd_Procesa 
      Height          =   450
      Left            =   60
      TabIndex        =   1
      Top             =   5100
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Desbloquear"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   3015
      Left            =   105
      TabIndex        =   10
      Top             =   1680
      Width           =   3375
      _Version        =   65536
      _ExtentX        =   5953
      _ExtentY        =   5318
      _StockProps     =   14
      Caption         =   "Doc. Bloqueados por Usuario"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ListBox List2 
         Enabled         =   0   'False
         Height          =   2085
         Left            =   120
         Style           =   1  'Checkbox
         TabIndex        =   11
         Top             =   360
         Width           =   3105
      End
      Begin Threed.SSCommand SSCommand2 
         Height          =   300
         Left            =   720
         TabIndex        =   12
         TabStop         =   0   'False
         Top             =   2640
         Width           =   1545
         _Version        =   65536
         _ExtentX        =   2725
         _ExtentY        =   529
         _StockProps     =   78
         Caption         =   "Seleccionar Todos"
         ForeColor       =   8388608
         Font3D          =   2
      End
   End
End
Attribute VB_Name = "Frm_BloqUs"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private objUsuario      As Object

Private Sub Cmd_Procesa_Click()
'Dim WS As Boolean
'WS = False
'Dim Sql As String
'    Screen.MousePointer = 11
'For X = 1 To List1.ListCount
'    List1.ListIndex = X - 1
'    If List1.Selected(X - 1) = True Then
'
'       Sql = "SP_DESBLOQUEADOC " & Trim(Mid(List1, 60, 30)) & "," & Trim(Mid(List1, 90, 25)) & ",'" & RTrim(TxtUsuario) & "'," & Trim(Mid(List1, Len(List1) - 10, 20))
'
'       If Bac_SQL_Execute(" ",Envia) = 0 Then
'          WS = True
'       End If
'   End If
'Next X
'
'If WS = True Then
'   List1.Clear
'   Call CargarDocumentosBloqueados
'   List1.ListIndex = -1
'   Screen.MousePointer = 0
'   MsgBox "Documentos Han Sido Desbloqueados", 32
'Else
'   Screen.MousePointer = 0
'   List1.ListIndex = -1
'   MsgBox "Proceso Ha Fallado", 16
'End If

End Sub
Private Sub Command2_Click()
'    Unload Frm_BloqUs
End Sub

Private Sub Form_Load()
   Me.Top = 0: 'Me.Left = 0
   SSCommand1.Caption = "Tomar Todos"
   SSCommand1.Enabled = False
   List1.ListIndex = -1
   Set objUsuario = New ClsUsuarios
'   Call CargarDocumentosBloqueados
End Sub
Sub CargarDocumentosBloqueados()
   Dim Datos()
   List1.Clear
   List2.Clear
   
   'txtusuario = "ADMINISTRA"
   Envia = Array()
   AddParam Envia, Trim(TxtUsuario)
   If Bac_Sql_Execute("SP_CARGARDOCBLOQUEADOS", Envia) Then
      Do While Bac_SQL_Fetch(Datos())
         If Val(Datos(4)) = 0 Then
            List2.AddItem Datos(6) & Space(70) & Val(Datos(1)) & Space(20) & Val(Datos(2)) & Space(20) & Val(Datos(3))
            List2.Enabled = True
         Else
            List1.AddItem Datos(6) & Space(70) & Val(Datos(1)) & Space(20) & Val(Datos(2)) & Space(20) & Val(Datos(3))
            List1.Enabled = True
         End If
      Loop
   End If

   If List1.ListCount <= 0 Then
      SSCommand1.Enabled = False
   Else
      SSCommand1.Enabled = True
   End If

   If List2.ListCount <= 0 Then
      SSCommand2.Enabled = False
   Else
      SSCommand2.Enabled = True
   End If

End Sub

Private Sub SSCommand1_Click()
Static C As Integer
   For x% = 0 To List1.ListCount - 1
      List1.ListIndex = x
      If C = 0 Then
         List1.Selected(x) = True
      Else
         List1.Selected(x) = False
      End If
   Next x%
   If C = 0 Then
      C = 1
      SSCommand1.Caption = "Soltar Todos"
   Else
      C = 0
      SSCommand1.Caption = "Tomar Todos"
   End If
   List1.ListIndex = -1
End Sub

Private Sub SSCommand2_Click()
Static C As Integer
   For x% = 0 To List2.ListCount - 1
      List2.ListIndex = x
      If C = 0 Then
         List2.Selected(x) = True
      Else
         List2.Selected(x) = False
      End If
   Next x%
   If C = 0 Then
      C = 1
      SSCommand2.Caption = "Soltar Todos"
   Else
      C = 0
      SSCommand2.Caption = "Tomar Todos"
   End If
   List2.ListIndex = -1
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim iMarcados As Integer

    iMarcados = 0
    Select Case UCase(Button.Description)
        Case "DESBLOQUEAR"
            Dim WS As Boolean
            WS = False
            Dim Sql As String
            Screen.MousePointer = 11
            
            For x = 1 To List1.ListCount
                List1.ListIndex = x - 1
                If List1.Selected(x - 1) = True Then
                    iMarcados = iMarcados + 1
                    Sql = "SP_DESBLOQUEADOC " & Trim(Mid(List1, 60, 30)) & "," & Trim(Mid(List1, 90, 25)) & ",'" & RTrim(TxtUsuario) & "'," & Trim(Mid(List1, Len(List1) - 10, 20))
                    If Bac_Sql_Execute(Sql) Then
                        WS = True
                    End If
                End If
            Next x

            For x = 1 To List2.ListCount
                List2.ListIndex = x - 1
                If List2.Selected(x - 1) = True Then
                    iMarcados = iMarcados + 1
                    Sql = "SP_DESBLOQUEADOC " & Trim(Mid(List2, 60, 30)) & "," & Trim(Mid(List2, 90, 25)) & ",'" & RTrim(TxtUsuario) & "'," & Trim(Mid(List2, Len(List2) - 10, 20))
                    If Bac_Sql_Execute(Sql) Then
                        WS = True
                    End If
                End If
            Next x
            
            If WS = True Then
                List1.Clear
                List2.Clear
                Call CargarDocumentosBloqueados
                List1.ListIndex = -1
                Screen.MousePointer = 0
                MsgBox "Documentos Han Sido Desbloqueados", 32
            Else
                If List1.ListCount = 0 Or List2.ListCount = 0 Then
                    Screen.MousePointer = 0
                    MsgBox "No Existen Documentos a Desbloquear", vbInformation, Me.Caption
                ElseIf iMarcados = 0 Then
                    Screen.MousePointer = 0
                    MsgBox "Debe Marcar los Documentos a Desbloquear", vbInformation, Me.Caption
                Else
                    Screen.MousePointer = 0
                    List1.ListIndex = -1
                    MsgBox "Sql-Server No Responde. Intentelo Nuevamente", 16, Me.Caption
                End If
            End If
            
        Case "SALIR"
            Unload Frm_BloqUs
    
    End Select
End Sub

Private Sub txtUsuario_Change()
'    txtUsuario.Text = ""
End Sub


Private Sub txtUsuario_DblClick()
Call Usuarios
'Call CargarDocumentosBloqueados
End Sub
Sub Usuarios()
    BacAyuda.Tag = "BACUSER"
    BacAyuda.Show 1

    If giAceptar% = True Then
        TxtUsuario.Text = gsDescripcion$
        List1.Enabled = True
        Call CargarDocumentosBloqueados
    End If
End Sub


Private Sub TxtUsuario_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF3 Then
   Call Usuarios
End If
End Sub

Private Sub txtusuario_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Call CargarDocumentosBloqueados
   Else
      List1.Clear
      KeyAscii = Asc(UCase(Chr(KeyAscii)))
   End If
      'BacCaracterNumerico KeyAscii
End Sub


