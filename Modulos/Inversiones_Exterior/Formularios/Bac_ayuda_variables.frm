VERSION 5.00
Begin VB.Form Bac_Ayuda_Variables 
   Caption         =   "Lista De Variables"
   ClientHeight    =   5550
   ClientLeft      =   3540
   ClientTop       =   1365
   ClientWidth     =   3975
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   ScaleHeight     =   5550
   ScaleWidth      =   3975
   Begin VB.Frame Frm_ayu_bot 
      Height          =   855
      Left            =   45
      TabIndex        =   2
      Top             =   4650
      Width           =   3900
      Begin VB.CommandButton cmd_cancelar 
         Caption         =   "Cancelar"
         Height          =   480
         Left            =   2655
         TabIndex        =   6
         Top             =   255
         Width           =   1065
      End
      Begin VB.CommandButton cmd_aceptar 
         Caption         =   "Aceptar"
         Height          =   495
         Left            =   1365
         TabIndex        =   5
         Top             =   225
         Width           =   1080
      End
   End
   Begin VB.Frame Frm_ayu_list 
      Height          =   3945
      Left            =   30
      TabIndex        =   1
      Top             =   705
      Width           =   3885
      Begin VB.ListBox List1 
         Height          =   3570
         Left            =   105
         TabIndex        =   4
         Top             =   240
         Width           =   3660
      End
   End
   Begin VB.Frame Frm_ayu_txt 
      Height          =   660
      Left            =   15
      TabIndex        =   0
      Top             =   30
      Width           =   3900
      Begin VB.TextBox Text1 
         Enabled         =   0   'False
         Height          =   285
         Left            =   135
         TabIndex        =   3
         Top             =   240
         Width           =   3630
      End
   End
End
Attribute VB_Name = "Bac_Ayuda_Variables"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Function llena_lista_variables()
    Dim datos()
    envia = Array()
    AddParam envia, 1
    List1.Clear
    If Bac_Sql_Execute("SVC_FMU_DAT_CAL", envia) Then
        Do While Bac_SQL_Fetch(datos)
            If Trim(datos(6)) <> "" Then
                List1.AddItem datos(2) & " - " & datos(4)
                List1.ItemData(List1.NewIndex) = Val(datos(5))
                
            End If
        Loop
    End If
End Function

Private Sub cmd_aceptar_Click()
    If List1.ListIndex <> -1 Then
        instru = List1.ItemData(List1.ListIndex)
        Dim datos()
        envia = Array()
        AddParam envia, instru
        If Bac_Sql_Execute("SVC_FMU_AYD_VAR", envia) Then
            Do While Bac_SQL_Fetch(datos)
                Bac_Formulas.For_Grilla.TextMatrix(Bac_Formulas.For_Grilla.Row, 2) = datos(1)
                Bac_Formulas.For_Grilla.TextMatrix(Bac_Formulas.For_Grilla.Row, 0) = datos(3)
            Loop
        End If
        Unload Me
    End If
    Unload Me
End Sub


Private Sub cmd_cancelar_Click()
    Unload Me
End Sub


Private Sub Form_Load()
    Me.Icon = BAC_INVERSIONES.Icon
    Call llena_lista_variables
    Dim arreglo_variables2(100)
End Sub

Private Sub List1_Click()
    text1.Text = List1.Text
End Sub

Private Sub List1_DblClick()
     Call cmd_aceptar_Click
End Sub

