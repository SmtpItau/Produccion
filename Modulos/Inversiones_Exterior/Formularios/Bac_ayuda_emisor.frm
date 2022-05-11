VERSION 5.00
Begin VB.Form Bac_ayuda_emisor 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Emisores"
   ClientHeight    =   4785
   ClientLeft      =   645
   ClientTop       =   2115
   ClientWidth     =   6750
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4785
   ScaleWidth      =   6750
   Begin VB.Frame Frame1 
      Height          =   3615
      Left            =   0
      TabIndex        =   4
      Top             =   600
      Width           =   6705
      Begin VB.ListBox List1 
         Height          =   3180
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   6495
      End
   End
   Begin VB.CommandButton Command1 
      Caption         =   "&Aceptar"
      DownPicture     =   "Bac_ayuda_emisor.frx":0000
      Height          =   375
      Left            =   4395
      TabIndex        =   3
      Top             =   4335
      Width           =   1095
   End
   Begin VB.CommandButton Command2 
      Caption         =   "&Cancelar"
      Height          =   375
      Left            =   5595
      TabIndex        =   2
      Top             =   4335
      Width           =   1095
   End
   Begin VB.Frame Frame2 
      Height          =   615
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6675
      Begin VB.TextBox txt_rut1 
         Height          =   285
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   6465
      End
   End
End
Attribute VB_Name = "Bac_ayuda_emisor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
