VERSION 5.00
Begin VB.Form bac_ayuda 
   Caption         =   "BAC Ayuda"
   ClientHeight    =   5595
   ClientLeft      =   3615
   ClientTop       =   1365
   ClientWidth     =   4440
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   5595
   ScaleWidth      =   4440
   Begin VB.Frame Frame2 
      Height          =   735
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   4455
      Begin VB.TextBox txt_ins 
         Height          =   285
         Left            =   240
         TabIndex        =   5
         Top             =   240
         Width           =   3975
      End
   End
   Begin VB.Frame FRAME1 
      Height          =   4815
      Left            =   0
      TabIndex        =   0
      Top             =   735
      Width           =   4455
      Begin VB.CommandButton Command2 
         Caption         =   "Cancelar"
         Height          =   435
         Left            =   3120
         TabIndex        =   3
         Top             =   4080
         Width           =   1095
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Aceptar"
         Height          =   435
         Left            =   1800
         TabIndex        =   2
         Top             =   4080
         Width           =   1095
      End
      Begin VB.ListBox List1 
         Height          =   3180
         Left            =   240
         TabIndex        =   1
         Top             =   510
         Width           =   4080
      End
      Begin VB.Label Label1 
         Caption         =   "Instrumentos"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   180
         Left            =   255
         TabIndex        =   6
         Top             =   210
         Width           =   2460
      End
   End
End
Attribute VB_Name = "bac_ayuda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Function llena_lista()
    Dim Sql As String
    Dim datos()
    
    List1.Clear
        
    If Bac_Sql_Execute("src_invex_series_mntllena_list") Then
        Do While Bac_SQL_Fetch(datos)
            List1.AddItem datos(2) & Space(20 - Len(datos(2))) & "(" & Format(datos(3), "dd/mm/yyyy") & ")"
            List1.ItemData(List1.NewIndex) = Val(datos(1))
        Loop
        
    End If

End Function

Private Sub Command1_Click()
    gsBac_VarString = Trim(Mid(txt_ins.Text, 22, 10))
    instru = Trim(Mid(txt_ins.Text, 1, 20))
    giAceptar = True
    Unload Me
End Sub

Private Sub Command2_Click()

    giAceptar = False
    
    Unload Me
    
End Sub

Private Sub Form_Load()
    Me.Icon = BAC_Inversiones.Icon
    Me.Caption = Bac_instrumentos.Caption
    If gsBac_Ayuda = "INSTRUM" Then
                Call llena_lista
    End If
    giAceptar = False
End Sub



Private Sub List1_Click()
    txt_ins.Text = List1.Text
End Sub


Private Sub List1_DblClick()
    txt_ins.Text = List1.Text
    Call Command1_Click

'   Call llena_datos_inst
'   Unload Me
End Sub

Private Sub List1_KeyPress(KeyAscii As Integer)
'   Call llena_datos_inst
'   Unload Me
End Sub


