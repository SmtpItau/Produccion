VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "Comctl32.ocx"
Begin VB.Form BacInformeProtocoloDef 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Protocolo de Definiciones"
   ClientHeight    =   2190
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4170
   Icon            =   "BacInformeProtocoloDef.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2190
   ScaleWidth      =   4170
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   4140
      _ExtentX        =   7303
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   2
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Imprimir"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Height          =   1785
      Left            =   0
      TabIndex        =   0
      Top             =   375
      Width           =   4155
      Begin VB.CommandButton btnInforme 
         Caption         =   "&Informe"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   780
         Left            =   1305
         Picture         =   "BacInformeProtocoloDef.frx":0442
         Style           =   1  'Graphical
         TabIndex        =   2
         ToolTipText     =   "Informe directo a Impresora"
         Top             =   1965
         Visible         =   0   'False
         Width           =   1185
      End
      Begin VB.CommandButton btnSalir 
         Caption         =   "&Salir"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   780
         Left            =   2580
         Picture         =   "BacInformeProtocoloDef.frx":074C
         Style           =   1  'Graphical
         TabIndex        =   1
         ToolTipText     =   "Salir Pantalla"
         Top             =   1965
         Visible         =   0   'False
         Width           =   1185
      End
      Begin VB.Label EtqMensaje 
         Caption         =   "Label1"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   1050
         TabIndex        =   4
         Top             =   1290
         Width           =   2895
      End
      Begin VB.Label etqPresentacion 
         Caption         =   "Definiciones utilizadas en contratos de Swap y Forward de Monedas en Mercado Local"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   690
         Left            =   1080
         TabIndex        =   3
         Top             =   495
         Width           =   2625
      End
      Begin VB.Image Image1 
         Height          =   480
         Left            =   360
         Picture         =   "BacInformeProtocoloDef.frx":0A56
         Top             =   405
         Width           =   480
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   315
      Top             =   2940
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   2
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacInformeProtocoloDef.frx":0E98
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacInformeProtocoloDef.frx":11B2
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacInformeProtocoloDef"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub btnInforme_Click()
Dim m

If ProtocoloContrato Then
    Me.MousePointer = 11
    EtqMensaje.Caption = "Informe enviado a Impresora!"
    
    For m = 1 To 100000
        DoEvents
    
    Next
    EtqMensaje.Caption = ""
    Me.MousePointer = 0
End If

End Sub

Private Sub btnSalir_Click()

    Unload Me
    
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
    EtqMensaje.Caption = ""

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
Select Case Button.Index
   Case 1
      Call btnInforme_Click
   Case 2
      Unload Me
End Select
End Sub
