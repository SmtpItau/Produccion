VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form Bac_anul_compras 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Anulaciones Compras"
   ClientHeight    =   5595
   ClientLeft      =   660
   ClientTop       =   1650
   ClientWidth     =   8355
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5595
   ScaleWidth      =   8355
   Begin VB.Frame Frame2 
      Height          =   3615
      Left            =   120
      TabIndex        =   5
      Top             =   1800
      Width           =   8055
      Begin MSFlexGridLib.MSFlexGrid grid 
         Height          =   3255
         Left            =   120
         TabIndex        =   8
         Top             =   240
         Width           =   7815
         _ExtentX        =   13785
         _ExtentY        =   5741
         _Version        =   393216
         Cols            =   6
         BackColor       =   -2147483638
         BackColorFixed  =   8421376
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   8355
      _ExtentX        =   14737
      _ExtentY        =   847
      ButtonWidth     =   714
      ButtonHeight    =   688
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   2760
         Top             =   120
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   20
         ImageHeight     =   20
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_anul_compras.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_anul_compras.frx":0452
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1095
      Left            =   120
      TabIndex        =   0
      Top             =   600
      Width           =   8055
      Begin MSMask.MaskEdBox MaskEdBox1 
         Height          =   255
         Left            =   5760
         TabIndex        =   9
         Top             =   600
         Width           =   2055
         _ExtentX        =   3625
         _ExtentY        =   450
         _Version        =   393216
         MaxLength       =   12
         Mask            =   "########,###"
         PromptChar      =   "0"
      End
      Begin VB.ComboBox box_numero 
         Height          =   315
         Left            =   1560
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   600
         Width           =   2775
      End
      Begin VB.ComboBox box_entidad 
         Height          =   315
         Left            =   1560
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   240
         Width           =   2775
      End
      Begin VB.Label Label3 
         Caption         =   "Total:       $"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   375
         Left            =   4800
         TabIndex        =   4
         Top             =   600
         Width           =   1215
      End
      Begin VB.Label Label2 
         Caption         =   "Nº Documento"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   240
         TabIndex        =   3
         Top             =   600
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Entidad"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   240
         TabIndex        =   2
         Top             =   240
         Width           =   1095
      End
   End
End
Attribute VB_Name = "Bac_anul_compras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    Move 0, 0
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Buttons
        Case 2
            Unload Me
    End Select
End Sub


