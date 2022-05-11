VERSION 5.00
Begin VB.Form Bac_Ayuda_Rut 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Búsqueda de Rut "
   ClientHeight    =   4740
   ClientLeft      =   3225
   ClientTop       =   1455
   ClientWidth     =   4050
   ClipControls    =   0   'False
   Icon            =   "frm_ayuda.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4740
   ScaleWidth      =   4050
   Begin VB.Frame Frame2 
      Height          =   615
      Left            =   75
      TabIndex        =   3
      Top             =   0
      Width           =   3855
      Begin VB.TextBox txt_rut1 
         Height          =   285
         Left            =   120
         TabIndex        =   4
         Top             =   240
         Width           =   3615
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "&Cancelar"
      Height          =   375
      Left            =   2835
      TabIndex        =   2
      Top             =   4320
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "&Aceptar"
      DownPicture     =   "frm_ayuda.frx":030A
      Height          =   375
      Left            =   1635
      TabIndex        =   1
      Top             =   4320
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Height          =   3615
      Left            =   75
      TabIndex        =   0
      Top             =   600
      Width           =   3855
      Begin VB.ListBox List1 
         Height          =   3180
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   3615
      End
   End
End
Attribute VB_Name = "Bac_Ayuda_Rut"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim a As String

Private Sub Command1_Click()
    
    Bac_inst_finan.txt_rut.Text = Bac_ayuda_rut.txt_rut1.Text
    Bac_inst_finan.txt_rut.SetFocus
    Unload Me
    
End Sub

Private Sub Command2_Click()
    Unload Me
End Sub

Private Sub Form_Activate()
    txt_rut1.SetFocus
End Sub

Private Sub txt_rut1_Change()

' Dim nPos  As Long
' Dim sText As String
'
'    sText = Trim$(txtNombre.Text)
'For nPos = 0 To lstNombre.ListCount - 1
'      If sText = Left(lstNombre.List(nPos), Len(sText)) Then
'           Exit For
'      End If
'    Next nPos
'        If sText <> lstNombre.List(nPos) Then
'            nPos = -1
'        ElseIf lstNombre.ListCount - 1 >= 0 Then
'            lstNombre.ListIndex = nPos
'        Else
'            nPos = -1
'        End If
'   If (nPos& < 0) Then
'      sText = Trim$(txtNombre.Text)
'      Select Case Trim$(Me.Tag)
'        Case "MDCL", "MDCLS"
'         Set objAyuda = New clsClientes
'             If Trim$(Me.Tag) = "MDCL" Or sText <> "" Then
'                 Call objAyuda.LeerClientes(sText)
'             Else
'                 Call objAyuda.LeerClientesSinteticos
'            End If
'                Call MDCL_LlenaGrilla
'
'        Case "MFMN"
'         Set objAyuda = New clsMonedas
'         objAyuda.LeerMonedas ("*")
'         Call objAyuda.Coleccion2Control(lstNombre)
'      End Select
'    End If
'        txtNombre.Tag = txtNombre.Text
End Sub

Private Sub txt_rut1_GotFocus()
'    txtNombre.Tag = txtNombre.Text
End Sub
Private Sub txt_rut1_KeyDown(KeyCode As Integer, Shift As Integer)
'If KeyCode = vbKeyDown Or KeyCode = vbKeyUp Then
'        lstNombre.SetFocus
'        If KeyCode = vbKeyDown Then
'            SendKeys "{DOWN}"
'        Else
'            SendKeys "{UP}"
'        End If
'    End If
End Sub

Private Sub txt_rut1_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
Case 13
    Bac_inst_finan.txt_rut.Text = Bac_ayuda_rut.txt_rut1.Text
End Select
'If KeyAscii% = vbKeyReturn Then
'        Call CmdAceptar
'Else
'      KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
'End If

End Sub

Private Sub txt_rut1_LostFocus()
Dim rut As String
If Me.txt_rut1.Text = "" Then Exit Sub
    Me.txt_rut1.Text = gfunFormatRut(Me.txt_rut1.Text)
    Me.txt_rut1.Text = gfunRutConGuion(Me.txt_rut1.Text)
    If gfunDVerificador(gfunRutSinCerosLeft(Me.txt_rut1.Text)) <> Right(Me.txt_rut1.Text, 1) Then
            Me.txt_rut1.Text = ""
            txt_rut1.SetFocus
    End If
End Sub
