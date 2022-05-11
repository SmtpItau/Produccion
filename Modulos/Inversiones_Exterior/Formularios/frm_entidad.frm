VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Bac_entidad 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ingreso de Entidad"
   ClientHeight    =   5025
   ClientLeft      =   3570
   ClientTop       =   2445
   ClientWidth     =   6675
   Icon            =   "frm_entidad.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5025
   ScaleWidth      =   6675
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   6675
      _ExtentX        =   11774
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
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3000
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
               Picture         =   "frm_entidad.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_entidad.frx":041C
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   4455
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   6615
      Begin VB.Frame Frame3 
         Height          =   3255
         Left            =   120
         TabIndex        =   4
         Top             =   1080
         Width           =   6375
         Begin MSFlexGridLib.MSFlexGrid grilla1 
            Height          =   2895
            Left            =   120
            TabIndex        =   5
            Top             =   240
            Width           =   6135
            _ExtentX        =   10821
            _ExtentY        =   5106
            _Version        =   393216
            Cols            =   3
         End
      End
      Begin VB.Frame Frame2 
         Height          =   735
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   6375
         Begin VB.ComboBox box_entidad 
            Height          =   315
            Left            =   1920
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   240
            Width           =   4335
         End
         Begin VB.Label Label1 
            Caption         =   "Ingrese Entidad"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   255
            Left            =   240
            TabIndex        =   2
            Top             =   240
            Width           =   1455
         End
      End
   End
End
Attribute VB_Name = "Bac_entidad"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Load()
Move 0, 0
End Sub

Private Sub Grilla1_DblClick()
    
    box_entidad.Text = grilla1.TextMatrix(grilla1.Row, grilla1.Col)

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
Case 1
    
    'sql = "selectsp_ "
    'If SQL <> 0 Then
         MsgBox "El reporte se ha emitido con éxito", vbOKOnly, "Emisión de Reporte"
    'End If
Case 2
    Unload Me
    
End Select
End Sub
