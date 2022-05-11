VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form Bac_anul_vtas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Anulaciones Ventas"
   ClientHeight    =   5910
   ClientLeft      =   1500
   ClientTop       =   1635
   ClientWidth     =   8850
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5910
   ScaleWidth      =   8850
   Begin VB.Frame Frame2 
      Height          =   3855
      Left            =   0
      TabIndex        =   7
      Top             =   1920
      Width           =   8775
      Begin MSFlexGridLib.MSFlexGrid MSFlexGrid1 
         Height          =   3495
         Left            =   120
         TabIndex        =   8
         Top             =   240
         Width           =   8535
         _ExtentX        =   15055
         _ExtentY        =   6165
         _Version        =   393216
         Cols            =   6
         BackColorFixed  =   8421376
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1215
      Left            =   0
      TabIndex        =   1
      Top             =   600
      Width           =   8775
      Begin MSMask.MaskEdBox MaskEdBox1 
         Height          =   255
         Left            =   6000
         TabIndex        =   9
         Top             =   720
         Width           =   2535
         _ExtentX        =   4471
         _ExtentY        =   450
         _Version        =   393216
         MaxLength       =   12
         Mask            =   "########,###"
         PromptChar      =   "0"
      End
      Begin VB.TextBox txt_numero 
         Height          =   285
         Left            =   1320
         TabIndex        =   6
         Top             =   720
         Width           =   2535
      End
      Begin VB.ComboBox box_entidad 
         Height          =   315
         Left            =   1320
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   240
         Width           =   2535
      End
      Begin VB.Label Label3 
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
         Height          =   375
         Left            =   240
         TabIndex        =   4
         Top             =   240
         Width           =   855
      End
      Begin VB.Label Label2 
         Caption         =   "Total:      $"
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
         Left            =   4920
         TabIndex        =   3
         Top             =   720
         Width           =   1335
      End
      Begin VB.Label Label1 
         Caption         =   "Nº de Venta"
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
         Left            =   240
         TabIndex        =   2
         Top             =   720
         Width           =   1095
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8850
      _ExtentX        =   15610
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Tag             =   "Grabar"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   1080
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
               Picture         =   "frm_anul_vtas.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_anul_vtas.frx":0452
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "Bac_anul_vtas"
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


