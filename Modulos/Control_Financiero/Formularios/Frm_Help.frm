VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Begin VB.Form Frm_Help 
   Caption         =   "Ayuda Texto de Ayuda."
   ClientHeight    =   7320
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   13560
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   11115
   ScaleWidth      =   15240
   Begin RichTextLib.RichTextBox TxtTextHelp 
      Height          =   8550
      Left            =   15
      TabIndex        =   0
      Top             =   30
      Width           =   14955
      _ExtentX        =   26379
      _ExtentY        =   15081
      _Version        =   393217
      BackColor       =   12648447
      ReadOnly        =   -1  'True
      ScrollBars      =   3
      FileName        =   "C:\Documents and Settings\agonzalf\Escritorio\Requerimientos\BAC\Control Financiero Modulo Fwd Mnt Mtz Ctrl\Ayuda.rtf"
      TextRTF         =   $"Frm_Help.frx":0000
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "Frm_Help"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
   Me.Top = 0: Me.Left = 0
   Me.Icon = BacControlFinanciero.Icon
   
End Sub

Private Sub Form_Resize()
   TxtTextHelp.Width = Me.Width - 150
   TxtTextHelp.Height = Me.Height - 500
   
End Sub

