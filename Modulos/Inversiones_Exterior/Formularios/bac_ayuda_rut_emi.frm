VERSION 5.00
Begin VB.Form bac_ayuda_riesgos 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Códigos De Riesgos"
   ClientHeight    =   4800
   ClientLeft      =   2910
   ClientTop       =   2265
   ClientWidth     =   3315
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4800
   ScaleWidth      =   3315
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Height          =   4155
      Left            =   60
      TabIndex        =   2
      Top             =   60
      Width           =   3135
      Begin VB.ListBox list 
         Height          =   3765
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   2895
      End
   End
   Begin VB.CommandButton Cmd_aceptar 
      Caption         =   "&Aceptar"
      DownPicture     =   "bac_ayuda_rut_emi.frx":0000
      Height          =   375
      Left            =   900
      TabIndex        =   1
      Top             =   4305
      Width           =   1095
   End
   Begin VB.CommandButton Cmd_cancelar 
      Caption         =   "&Cancelar"
      Height          =   375
      Left            =   2085
      TabIndex        =   0
      Top             =   4305
      Width           =   1095
   End
End
Attribute VB_Name = "bac_ayuda_riesgos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Function llena_list()
    Dim datos()
    If Bac_Sql_Execute("SP_invex_riesgos_lista_codigos") Then
        Do While Bac_SQL_Fetch(datos)
            list.AddItem datos(1) & Space(10 - Len(Trim(datos(1)))) & datos(2)
        Loop
    End If
End Function




Private Sub cmd_aceptar_Click()
    gsDato1 = Trim(Mid(list.Text, 1, 10))
    gsDato2 = Trim(Mid(list.Text, 11, 20))
    Unload Me
End Sub

Private Sub cmd_cancelar_Click()
    gsDato1 = " "
    gsDato2 = " "
    Unload Me
End Sub


Private Sub Form_Load()
    Me.Icon = BAC_Inversiones.Icon
    Call llena_list
End Sub





Private Sub list_DblClick()
    cmd_aceptar_Click
End Sub




