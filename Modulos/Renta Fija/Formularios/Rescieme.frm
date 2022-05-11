VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Resp_Cierra_Mesa 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Abrir/Cerrar Mesa"
   ClientHeight    =   2655
   ClientLeft      =   2505
   ClientTop       =   3495
   ClientWidth     =   5160
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Rescieme.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2655
   ScaleWidth      =   5160
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   5160
      _ExtentX        =   9102
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   975
      Left            =   1545
      TabIndex        =   0
      Top             =   1155
      Width           =   2715
      _Version        =   65536
      _ExtentX        =   4789
      _ExtentY        =   1720
      _StockProps     =   14
      ForeColor       =   -2147483630
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.CommandButton CmdCancelar 
         Caption         =   "&Salir"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   1800
         TabIndex        =   6
         Top             =   480
         Width           =   750
      End
      Begin Threed.SSPanel SSPanel1 
         Height          =   390
         Left            =   240
         TabIndex        =   4
         Top             =   150
         Width           =   1275
         _Version        =   65536
         _ExtentX        =   2249
         _ExtentY        =   688
         _StockProps     =   15
         Caption         =   "Mesa de Dinero"
         ForeColor       =   -2147483630
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   0
         Font3D          =   2
      End
      Begin Threed.SSPanel PanelActivo 
         Height          =   330
         Left            =   120
         TabIndex        =   5
         Top             =   480
         Width           =   1275
         _Version        =   65536
         _ExtentX        =   2249
         _ExtentY        =   582
         _StockProps     =   15
         Caption         =   " "
         ForeColor       =   -2147483630
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   0
         Font3D          =   2
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   600
      Left            =   1530
      TabIndex        =   1
      Top             =   465
      Width           =   2715
      _Version        =   65536
      _ExtentX        =   4789
      _ExtentY        =   1058
      _StockProps     =   14
      ForeColor       =   -2147483630
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.CommandButton CmdAbrir 
         Caption         =   "&Abrir Mesa"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   135
         TabIndex        =   3
         Top             =   180
         Width           =   1200
      End
      Begin VB.CommandButton CmdCerrar 
         Caption         =   "&Cerrar Mesa"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   1395
         TabIndex        =   2
         Top             =   180
         Width           =   1200
      End
   End
   Begin Threed.SSFrame SSFrame3 
      Height          =   1170
      Left            =   15
      TabIndex        =   8
      Top             =   480
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   2064
      _StockProps     =   14
      ForeColor       =   -2147483630
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.Image Image1 
         Height          =   855
         Left            =   105
         Picture         =   "Rescieme.frx":0442
         Stretch         =   -1  'True
         Top             =   195
         Width           =   675
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3975
      Top             =   150
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Rescieme.frx":0884
            Key             =   "Rojo"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Rescieme.frx":0CD6
            Key             =   "Verde"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Rescieme.frx":1128
            Key             =   "Salir"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Resp_Cierra_Mesa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub CmdAbrir_Click()

  If miSQL.SQL_Execute("UPDATE MdAc SET acsw_mesa = '0'") <> 0 Then
    MsgBox "Problemas Servidor SQL", vbCritical, "PROCESOS DIARIOS"
    Unload Me
  Else
    CmdAbrir.Enabled = False
    CmdCerrar.Enabled = True
    PanelActivo.Caption = "Activa"
    'Imagen.Picture = LoadResPicture("CmdMesaActi", vbResIcon)
  End If

End Sub

Private Sub cmdCancelar_Click()
   Unload Me
End Sub

Private Sub CmdCerrar_Click()

  If miSQL.SQL_Execute("UPDATE MdAc SET acsw_mesa = '1'") <> 0 Then
    MsgBox "Problemas Servidor SQL", vbCritical, "PROCESOS DIARIOS"
    Unload Me
  Else
    CmdAbrir.Enabled = True
    CmdCerrar.Enabled = False
    PanelActivo.Caption = "Bloqueada"
    'Imagen.Picture = LoadResPicture("CmdMesaBloq", vbResIcon)
  End If

End Sub


Private Sub Form_Load()
   Dim DATOS()
   Me.Icon = BacTrader.Icon
   If Not Bac_Sql_Execute("SP_APERTURAMESA") Then
       MsgBox "Problemas Servidor SQL", vbCritical, "PROCESOS DIARIOS"
       Unload Me
   End If
  
   Do While Bac_SQL_Fetch(DATOS())
      If DATOS(1) = 0 Then
         Toolbar1.Buttons(1).Image = "Rojo"
         CmdAbrir.Enabled = False
         CmdCerrar.Enabled = True
         PanelActivo.Caption = "Activa"
      Else
         Toolbar1.Buttons(1).Image = "Verde"
         CmdAbrir.Enabled = True
         CmdCerrar.Enabled = False
         PanelActivo.Caption = "Bloqueada"
      End If
   Loop

End Sub


Sub a()


End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Toolbar1.Buttons(1).Image = "Rojo"
End Sub
