VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form frmcargaxcel 
   Appearance      =   0  'Flat
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Elegir Base Tabla Desarrollo"
   ClientHeight    =   4575
   ClientLeft      =   840
   ClientTop       =   435
   ClientWidth     =   4575
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4575
   ScaleWidth      =   4575
   Begin ComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   9
      Top             =   0
      Width           =   4575
      _ExtentX        =   8070
      _ExtentY        =   900
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
            Key             =   "Aceptar"
            Object.ToolTipText     =   "Aceptar"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin ComctlLib.ImageList ImageList1 
         Left            =   2760
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         UseMaskColor    =   0   'False
         _Version        =   327682
         BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
            NumListImages   =   2
            BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
               Picture         =   "frmcargaxcel.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
               Picture         =   "frmcargaxcel.frx":081A
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame2 
      Height          =   3135
      Left            =   120
      TabIndex        =   2
      Top             =   1320
      Width           =   4335
      Begin VB.Frame Frame3 
         Height          =   855
         Left            =   120
         TabIndex        =   7
         Top             =   2160
         Width           =   4095
         Begin VB.Label Label2 
            Caption         =   "Al elegir la última opción se generará el calendario al estilo Bullet."
            ForeColor       =   &H00800000&
            Height          =   495
            Left            =   120
            TabIndex        =   8
            Top             =   240
            Width           =   3855
         End
      End
      Begin VB.OptionButton optcexc 
         Caption         =   "Saldos Insolutos"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   1080
         TabIndex        =   6
         Top             =   360
         Width           =   1815
      End
      Begin VB.OptionButton optcexc 
         Caption         =   "Amortizaciones"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   375
         Index           =   1
         Left            =   1080
         TabIndex        =   5
         Top             =   720
         Width           =   1815
      End
      Begin VB.OptionButton optcexc 
         Caption         =   "Porcentaje Amortizaciones "
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   375
         Index           =   2
         Left            =   1080
         TabIndex        =   4
         Top             =   1200
         Width           =   2655
      End
      Begin VB.OptionButton optcexc 
         Caption         =   "No considerar a ninguno"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   375
         Index           =   3
         Left            =   1080
         TabIndex        =   3
         Top             =   1680
         Width           =   2775
      End
   End
   Begin VB.Frame Frame1 
      Height          =   855
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   4335
      Begin VB.Label Label1 
         Caption         =   "Se cargarán todas las columnas de datos, pero se debe elegir de manera exclusiva entre:"
         ForeColor       =   &H00800000&
         Height          =   435
         Left            =   360
         TabIndex        =   1
         Top             =   240
         Width           =   3840
      End
   End
End
Attribute VB_Name = "frmcargaxcel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Form_Load()
Dim i As Integer

    optcexc.Item(0).Value = True

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
Dim i As Integer
Dim sw As Integer


Select Case Button.Index
    Case 1
    
          For i = 0 To optcexc.Count - 1
            If optcexc.Item(i).Value = True Then
                OptCargaExcel = i
            End If
          Next
          BotCargaExcel = Button.Index

          Unload frmcargaxcel

   
    Case 2
          
          BotCargaExcel = Button.Index
    
      On Error Resume Next
         Unload Me
      On Error GoTo 0
    
End Select

End Sub
