VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FrmBloqueaMesa 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Abrir/Cerrar Mesa"
   ClientHeight    =   1905
   ClientLeft      =   2505
   ClientTop       =   3495
   ClientWidth     =   3000
   ForeColor       =   &H00C0C0C0&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1905
   ScaleWidth      =   3000
   Begin Threed.SSFrame SSFrame3 
      Height          =   1170
      Left            =   105
      TabIndex        =   4
      Top             =   675
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
         Index           =   0
         Left            =   30
         Picture         =   "BacBloqueaMesa.frx":0000
         Stretch         =   -1  'True
         Top             =   225
         Width           =   855
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   1170
      Left            =   1020
      TabIndex        =   0
      Top             =   675
      Width           =   1890
      _Version        =   65536
      _ExtentX        =   3334
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
      Begin Threed.SSPanel SSPanel1 
         Height          =   510
         Left            =   150
         TabIndex        =   1
         Top             =   165
         Width           =   1605
         _Version        =   65536
         _ExtentX        =   2822
         _ExtentY        =   900
         _StockProps     =   15
         Caption         =   "Mesa de Dinero"
         ForeColor       =   -2147483630
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
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
         Left            =   150
         TabIndex        =   2
         Top             =   750
         Width           =   1605
         _Version        =   65536
         _ExtentX        =   2822
         _ExtentY        =   582
         _StockProps     =   15
         Caption         =   " "
         ForeColor       =   -2147483630
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
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
   Begin Threed.SSPanel SSPanel2 
      Height          =   1260
      Left            =   45
      TabIndex        =   5
      Top             =   660
      Width           =   2940
      _Version        =   65536
      _ExtentX        =   5186
      _ExtentY        =   2222
      _StockProps     =   15
      Caption         =   "SSPanel2"
      BackColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   630
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   2985
      _ExtentX        =   5265
      _ExtentY        =   1111
      ButtonWidth     =   1032
      ButtonHeight    =   1005
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
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3090
      Top             =   15
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacBloqueaMesa.frx":0442
            Key             =   "Rojo"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacBloqueaMesa.frx":089E
            Key             =   "Verde"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacBloqueaMesa.frx":0CFA
            Key             =   "salir"
         EndProperty
      EndProperty
   End
   Begin VB.Image Image1 
      BorderStyle     =   1  'Fixed Single
      Height          =   540
      Index           =   1
      Left            =   60
      Picture         =   "BacBloqueaMesa.frx":1022
      Top             =   1950
      Visible         =   0   'False
      Width           =   540
   End
   Begin VB.Image Image1 
      BorderStyle     =   1  'Fixed Single
      Height          =   540
      Index           =   2
      Left            =   615
      Picture         =   "BacBloqueaMesa.frx":1464
      Top             =   1950
      Visible         =   0   'False
      Width           =   540
   End
End
Attribute VB_Name = "FrmBloqueaMesa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim objCierreMesa As Object

Private Sub Form_Load()
      
   Me.Left = 0
   Me.Top = 0
   Set objCierreMesa = New clsCierraMesa
   Call RefrescarMesa
End Sub
Sub RefrescarMesa()

   With objCierreMesa

      If Not .Lee_Mesa Then MsgBox "Problemas al Realizar Cierre de Mesa", vbCritical, TITSISTEMA

      If .CieMesa = "0" Then

         FrmBloqueaMesa.Image1(0).Picture = FrmBloqueaMesa.Image1(2).Picture
         FrmBloqueaMesa.Toolbar1.Buttons(1).Image = "Rojo"
         FrmBloqueaMesa.Toolbar1.Buttons(1).ToolTipText = "Bloquear Mesa"
         FrmBloqueaMesa.PanelActivo.Caption = "Activa"
         BacTrader.Opc_80200.Checked = False

      Else

         FrmBloqueaMesa.Image1(0).Picture = FrmBloqueaMesa.Image1(1).Picture
         FrmBloqueaMesa.Toolbar1.Buttons(1).Image = "Verde"
         
         FrmBloqueaMesa.Toolbar1.Buttons(1).ToolTipText = "Desbloquear Mesa"
         FrmBloqueaMesa.PanelActivo.Caption = "Bloqueada"
         BacTrader.Opc_80200.Checked = True

      End If

   End With

End Sub
Private Sub Form_Unload(Cancel As Integer)

   Set objCierreMesa = Nothing

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   
   Dim SwBloqueo As Integer
   
   With objCierreMesa
   
      Select Case Button.Index
         
         Case Is = 1

            If objCierreMesa.xValor Then
               MsgBox "No puede abrir la mesa", vbDefaultButton1, TITSISTEMA
               Exit Sub
            End If

            .xValor = Not .xValor
            
            If Not .CierreMesa Then
               
               MsgBox "Problemas con el cierre de mesa.", vbExclamation, TITSISTEMA
               Exit Sub
            
            End If
            
            Call RefrescarMesa
         
         Case Else
            
            Unload Me
      
      End Select
   
   End With

End Sub
