VERSION 5.00
Begin VB.Form Frm_Guarda_Ruta 
   Caption         =   "Destino del Archivo"
   ClientHeight    =   4155
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4560
   LinkTopic       =   "Form1"
   ScaleHeight     =   4155
   ScaleWidth      =   4560
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame fr_detalle 
      ForeColor       =   &H00C00000&
      Height          =   4095
      Left            =   60
      TabIndex        =   0
      Top             =   0
      Width           =   4455
      Begin VB.DirListBox Dir1 
         Height          =   2115
         Left            =   120
         TabIndex        =   4
         Top             =   1320
         Width           =   4095
      End
      Begin VB.CommandButton Cmdlisto 
         Caption         =   "Aceptar"
         Height          =   375
         Left            =   3120
         TabIndex        =   3
         Top             =   3600
         Width           =   1095
      End
      Begin VB.TextBox Txtpath 
         Enabled         =   0   'False
         Height          =   375
         Left            =   120
         TabIndex        =   2
         Top             =   480
         Width           =   4215
      End
      Begin VB.DriveListBox Drive1 
         Height          =   315
         Left            =   120
         TabIndex        =   1
         Top             =   960
         Width           =   2415
      End
      Begin VB.Label lblpath 
         AutoSize        =   -1  'True
         Caption         =   "Ruta Destino"
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
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   1125
      End
   End
End
Attribute VB_Name = "Frm_Guarda_Ruta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Cmdlisto_Click()
    fr_detalle.Visible = True
    
    BacInformeCarteraAVR.Tag = Txtpath.Text
    
    Unload Me
End Sub

Private Sub Drive1_Change()
On Error GoTo MensajeError
   Dir1.Path = UCase(Drive1.Drive)

Exit Sub

MensajeError:

If err.Number = 68 Then MsgBox "La unidad seleccionada no está disponible", vbInformation:
    
    Drive1.Drive = Dir1.Path
    Resume Next
End Sub

Private Sub Form_Activate()
If Dir(Txtpath.Text, vbDirectory) = "" Then
   MsgBox "Ruta específicada no existe, favor verificar", vbInformation, "Validación de Ruta"
Else
   Dir1.Path = Txtpath.Text
End If


End Sub

Private Sub Form_Load()
Dir1.Path = UCase(Txtpath.Text)
End Sub

Private Sub Dir1_Change()
Txtpath.Text = UCase(Dir1.Path)
End Sub

