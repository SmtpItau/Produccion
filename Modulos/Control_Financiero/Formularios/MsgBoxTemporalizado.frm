VERSION 5.00
Begin VB.Form MsgBoxTemporalizado 
   Caption         =   "<Variable>"
   ClientHeight    =   2355
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   8700
   LinkTopic       =   "Form2"
   ScaleHeight     =   2355
   ScaleWidth      =   8700
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer CuentaRegresiva 
      Left            =   240
      Top             =   2040
   End
   Begin VB.CommandButton BtnCancelar 
      Caption         =   "Cancelar"
      Default         =   -1  'True
      Height          =   375
      Left            =   5760
      TabIndex        =   0
      Top             =   1560
      Width           =   1455
   End
   Begin VB.CommandButton BtnConfirmar 
      Caption         =   "Confirmar"
      Height          =   375
      Left            =   1440
      TabIndex        =   1
      Top             =   1560
      Width           =   1455
   End
   Begin VB.Timer Temporalizador 
      Interval        =   30000
      Left            =   240
      Top             =   1440
   End
   Begin VB.Label LblAvisoDeCierre 
      Alignment       =   2  'Center
      Caption         =   "Ventana se Cerrará en..."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   735
      Left            =   6240
      TabIndex        =   5
      Top             =   120
      Width           =   2295
   End
   Begin VB.Label LblFaltan 
      Alignment       =   2  'Center
      Caption         =   "30"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   375
      Left            =   6240
      TabIndex        =   4
      Top             =   960
      Width           =   2175
      WordWrap        =   -1  'True
   End
   Begin VB.Label LblAdvertencia 
      Caption         =   "Si no se elige una opción el sistema cancelará el proceso..."
      Height          =   255
      Left            =   360
      TabIndex        =   3
      Top             =   840
      Width           =   4215
   End
   Begin VB.Label LblSolicitud 
      AutoSize        =   -1  'True
      Caption         =   "<Variable>"
      Height          =   555
      Left            =   360
      TabIndex        =   2
      Top             =   240
      Width           =   5655
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "MsgBoxTemporalizado"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Titulo As String
Public Solicitud As String
Public CoorX  As Long
Public CoorY As Long
Public Respuesta As Boolean



Private Sub BtnCancelar_Click()
    Let Respuesta = False
    Unload Me
End Sub



Private Sub BtnConfirmar_Click()
    Let Respuesta = True
    Unload Me
End Sub

Private Sub CuentaRegresiva_Timer()
    If Val(Me.LblFaltan.Caption) - 1 > 0 Then
       Let LblFaltan.Caption = str(LblFaltan.Caption - 1)
       
    End If
End Sub

Private Sub Form_Load()
    'Me.BtnCancelar.SetFocus
    'me.Height
    Me.Caption = Me.Titulo
    Me.LblSolicitud = Me.Solicitud
   ' BtnCancelar.SetFocus

    Me.LblAdvertencia.top = Me.LblSolicitud.Height + 500
    Me.BtnCancelar.top = Me.LblAdvertencia.top + 500
    Me.BtnConfirmar.top = Me.LblAdvertencia.top + 500
    Me.Height = Me.BtnConfirmar.top + 1500
    Me.LblFaltan = 30
    
End Sub



Private Sub Temporalizador_Timer()
    Unload Me
End Sub
