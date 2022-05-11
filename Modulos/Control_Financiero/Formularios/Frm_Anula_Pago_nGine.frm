VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form FRM_Anula_Pago_nGine 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Anula Pago nGine"
   ClientHeight    =   6540
   ClientLeft      =   -15
   ClientTop       =   270
   ClientWidth     =   17010
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6540
   ScaleWidth      =   17010
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Caption         =   "Observaciones MDP"
      Height          =   2175
      Left            =   15
      TabIndex        =   19
      Top             =   4320
      Width           =   16980
      Begin VB.ListBox ListErrores 
         Height          =   1815
         Left            =   60
         TabIndex        =   20
         Top             =   240
         Width           =   16755
      End
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   315
      Index           =   0
      Left            =   855
      Picture         =   "Frm_Anula_Pago_nGine.frx":0000
      ScaleHeight     =   315
      ScaleWidth      =   345
      TabIndex        =   6
      Top             =   4560
      Visible         =   0   'False
      Width           =   345
   End
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   315
      Index           =   0
      Left            =   465
      Picture         =   "Frm_Anula_Pago_nGine.frx":015A
      ScaleHeight     =   315
      ScaleWidth      =   345
      TabIndex        =   5
      Top             =   4560
      Visible         =   0   'False
      Width           =   345
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   17010
      _ExtentX        =   30004
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar información"
            ImageIndex      =   29
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Refrescar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Filtro"
            ImageIndex      =   23
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   48
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4005
         Top             =   105
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   54
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":02B4
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":118E
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":2068
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":2F42
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":3E1C
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":4CF6
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":5BD0
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":6AAA
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":7984
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":885E
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":9738
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":9A52
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":A92C
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":B806
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":C6E0
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":D5BA
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":E494
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":F36E
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":10248
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":1069A
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":10AEC
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":10F3E
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":11E18
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":12CF2
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":13144
               Key             =   ""
            EndProperty
            BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":13596
               Key             =   ""
            EndProperty
            BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":139E8
               Key             =   ""
            EndProperty
            BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":13E3A
               Key             =   ""
            EndProperty
            BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":14D14
               Key             =   ""
            EndProperty
            BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":15BEE
               Key             =   ""
            EndProperty
            BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":16AC8
               Key             =   ""
            EndProperty
            BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":179A2
               Key             =   ""
            EndProperty
            BeginProperty ListImage33 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":17CBC
               Key             =   ""
            EndProperty
            BeginProperty ListImage34 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":18B96
               Key             =   ""
            EndProperty
            BeginProperty ListImage35 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":19A70
               Key             =   ""
            EndProperty
            BeginProperty ListImage36 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":1A94A
               Key             =   ""
            EndProperty
            BeginProperty ListImage37 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":1B824
               Key             =   ""
            EndProperty
            BeginProperty ListImage38 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":1C6FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage39 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":1D5D8
               Key             =   ""
            EndProperty
            BeginProperty ListImage40 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":1E4B2
               Key             =   ""
            EndProperty
            BeginProperty ListImage41 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":1F38C
               Key             =   ""
            EndProperty
            BeginProperty ListImage42 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":20266
               Key             =   ""
            EndProperty
            BeginProperty ListImage43 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":21140
               Key             =   ""
            EndProperty
            BeginProperty ListImage44 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":2201A
               Key             =   ""
            EndProperty
            BeginProperty ListImage45 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":22EF4
               Key             =   ""
            EndProperty
            BeginProperty ListImage46 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":23DCE
               Key             =   ""
            EndProperty
            BeginProperty ListImage47 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":24CA8
               Key             =   ""
            EndProperty
            BeginProperty ListImage48 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":25B82
               Key             =   ""
            EndProperty
            BeginProperty ListImage49 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":25E9C
               Key             =   ""
            EndProperty
            BeginProperty ListImage50 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":26D76
               Key             =   ""
            EndProperty
            BeginProperty ListImage51 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":27C50
               Key             =   ""
            EndProperty
            BeginProperty ListImage52 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":27F6A
               Key             =   ""
            EndProperty
            BeginProperty ListImage53 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":28E44
               Key             =   ""
            EndProperty
            BeginProperty ListImage54 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Anula_Pago_nGine.frx":29D1E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FraCuadro 
      Height          =   3810
      Left            =   15
      TabIndex        =   1
      Top             =   450
      Width           =   16980
      Begin VB.ComboBox cmbEstadoEnvio 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         ItemData        =   "Frm_Anula_Pago_nGine.frx":2ABF8
         Left            =   12840
         List            =   "Frm_Anula_Pago_nGine.frx":2ABFA
         Style           =   2  'Dropdown List
         TabIndex        =   18
         Top             =   1560
         Visible         =   0   'False
         Width           =   1725
      End
      Begin Threed.SSPanel pnlFiltro 
         Height          =   2265
         Left            =   3960
         TabIndex        =   7
         Top             =   1080
         Visible         =   0   'False
         Width           =   6495
         _Version        =   65536
         _ExtentX        =   11456
         _ExtentY        =   3995
         _StockProps     =   15
         BackColor       =   13160660
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelInner      =   1
         Begin MSComctlLib.Toolbar Toolbar2 
            Height          =   510
            Left            =   45
            TabIndex        =   8
            Top             =   360
            Width           =   6390
            _ExtentX        =   11271
            _ExtentY        =   900
            ButtonWidth     =   767
            ButtonHeight    =   741
            AllowCustomize  =   0   'False
            Appearance      =   1
            ImageList       =   "ImageList1"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   2
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Aceptar"
                  ImageIndex      =   2
               EndProperty
               BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Cerra"
                  ImageIndex      =   48
               EndProperty
            EndProperty
            BorderStyle     =   1
         End
         Begin VB.Frame fraMarco 
            Height          =   1425
            Left            =   45
            TabIndex        =   9
            Top             =   795
            Width           =   6405
            Begin VB.ComboBox cmbSistema 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   330
               Left            =   1095
               Style           =   2  'Dropdown List
               TabIndex        =   12
               Top             =   480
               Width           =   5220
            End
            Begin VB.ComboBox cmbTipOper 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   330
               Left            =   1095
               Style           =   2  'Dropdown List
               TabIndex        =   11
               Top             =   825
               Width           =   5205
            End
            Begin VB.TextBox txtRutCliente 
               Alignment       =   1  'Right Justify
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   315
               Left            =   1095
               Locked          =   -1  'True
               MousePointer    =   14  'Arrow and Question
               TabIndex        =   10
               Text            =   "0"
               Top             =   150
               Width           =   1410
            End
            Begin VB.Label Label1 
               Caption         =   "Cliente"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   255
               Index           =   0
               Left            =   60
               TabIndex        =   16
               Top             =   195
               Width           =   780
            End
            Begin VB.Label txtNomCliente 
               Alignment       =   2  'Center
               BackColor       =   &H80000005&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000008&
               Height          =   315
               Left            =   2505
               TabIndex        =   15
               Top             =   150
               Width           =   3780
            End
            Begin VB.Label Label1 
               Caption         =   "Sistema"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   255
               Index           =   1
               Left            =   60
               TabIndex        =   14
               Top             =   525
               Width           =   780
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "Producto"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   210
               Index           =   2
               Left            =   60
               TabIndex        =   13
               Top             =   870
               Width           =   750
            End
         End
         Begin VB.Label lblCaption 
            BackColor       =   &H80000002&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "   Filtro de Operaciones"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000009&
            Height          =   330
            Left            =   30
            TabIndex        =   17
            Top             =   30
            Width           =   6435
         End
      End
      Begin VB.ComboBox cmbSiNo 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   480
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   1440
         Visible         =   0   'False
         Width           =   1485
      End
      Begin VB.TextBox txtDescripcion 
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   7980
         TabIndex        =   3
         Top             =   735
         Visible         =   0   'False
         Width           =   2115
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   3615
         Left            =   60
         TabIndex        =   2
         Top             =   135
         Width           =   16755
         _ExtentX        =   29554
         _ExtentY        =   6376
         _Version        =   393216
         Rows            =   3
         Cols            =   14
         FixedRows       =   2
         FixedCols       =   0
         RowHeightMin    =   330
         BackColor       =   -2147483644
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483648
         GridColor       =   -2147483644
         GridColorFixed  =   -2147483642
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_Anula_Pago_nGine"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim clrut As Long
Dim cldv As String
Dim clcodigo As Integer
Dim clDescripcion As String

'--> Variable para filtro de productos por sistema
Dim FiltroSistema As String

'--> Variable para valida estado
Dim Numoper_Valida As Long
Dim Estado_Valida As String

'--> Variable cuenta registros
Dim iRegistros As Long

'--> Variable conexion Webservice
Dim WS As eWService

'--> Parametros tabla_general_detalle
Private Enum ePago
    PendientePago = 9926    'Pendiente Pago
    EnvioPago = 9927        'Envio Pago(MAN /AUT)
    AnulaPago = 9928        'Anula Pago(MAN /AUT)
End Enum

'--> Parametros tabla_general_detalle EQUIVALENCIAS
Private Enum eEquivalencias
    UsuarioMDP = 9929       'Usuario MDP
    Sistema = 9930          'Equivalencia Sistema
    XmlParametros = 9931    'Parametros XML canal,appcod y appnombre
    Producto = 9932         'Equivalencia Producto
    FormaPago = 9933        'Equivalente forma de pago
    Valuta = 9934           'Equivalente Valuta
    Prod_System = 9935      'Equivalente producto + _SYSTEM
End Enum

'--> Enumeracion para columnas grilla
Private Enum eCol
    EnviarPago = 0
    Sistema = 1
    NumeroOperacion = 2
    TipoOperacion = 3               'oculta
    GlosaTipoOperacion = 4
    Indicador = 5                   'oculta
    FechaOperacion = 6
    Usuario = 7                     'oculta
    Moneda = 8                      'oculta
    GlosaMoneda = 9
    RutCliente = 10
    DvCliente = 11                  'oculta
    Sucursal = 12                   'oculta
    NombreCliente = 13
    FormaPago = 14                  'oculta
    GlosaFormaPago = 15
    CodigoValuta = 16               'oculta
    MontoOperacion = 17
    Banco = 18                      'oculta
    CtaCteBeneficiarioVendedor = 19 'oculta
    ClaveAbif = 20                  'oculta
    CtaComprador = 21               'oculta
    CodigoDcvComprador = 22         'oculta
    CtaVendedor = 23                'oculta
    CodigoDcvVendedor = 24          'oculta
    MontoOriginal = 25              'oculta
    FechaInicio = 26                'oculta
    TasaInteres = 27                'oculta
    Interes = 28                    'oculta
    MontoVencimiento = 29           'oculta
    FechaVencimiento = 30           'oculta
    Reajustabilidad = 31            'oculta
    TasaPacto = 32                  'oculta
    MontoFinal = 33                 'oculta
    MontoNominal = 34               'oculta
    TasaDescuento = 35              'oculta
    ValorTasa = 36                  'oculta
    Custodia = 37                   'oculta
    NumeroInstrumentos = 38         'oculta
    MontoTotal = 39                 'oculta
    CodigoMonMx = 40                'oculta
    MontoMx = 41                    'oculta
    TasaCambio = 42                 'oculta
    FechaValorMx = 43               'oculta
    FormaPagoNeg = 44               'oculta
    Sesion = 45                     'oculta
    NombreClienteBeneficiario_3 = 46 'oculta
    NombreClienteBeneficiario_4 = 47 'oculta
    UsuarioMDP = 48                 'oculta
    UsuarioIngreso = 49             'oculta
    CargoCtaCte = 50                'oculta
    SobregiroCtaCte = 51            'oculta
    PvpReferencia = 52              'oculta
    PvpMoneda = 53                  'oculta
    PvpTasaCambio = 54              'oculta
    PvpMonto = 55                   'oculta
    CodCliente = 56                 'oculta
    CodigoDcv2 = 57                 'oculta
    Estado = 58
    EstadoGlosa = 59
End Enum

'--> Estructura SP_NGINE_OPERACIONES_ENVIO_PAGO
Private Type tSPParametros
    Sistema         As String
    CodigoProducto  As String
    RutCliente      As Long
    CodCliente      As Long
    Tipcliente      As Long
    TipOperacion    As String
    EstadoConfir    As String
    Numoper         As Long
    TbCategoria     As Integer ' Variable tabla_general_detalle tbcateg
                               ' 9926=PENDIENTE PAGO/9927=ENVIO PAGO(MAN AUT)/9928=ANULA PAGO(MAN AUT)
End Type

'--> Estructura de paso al procedimiento valida estado
Private Type tSPValidaEstados
    Numoper        As Long
    Estado         As String
End Type

'--> Variables WS
Private Type eWService
        Url     As String
        Url2    As String
        Action  As String
        Action2 As String
        Action3 As String
        Action4 As String
        Action5 As String
        Action6 As String
End Type

Private Sub CargaSistema(ByRef MiObjeto As ComboBox)
    Dim Datos()
    If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_LEER_SISTEMA_CNT") Then
        Exit Sub
    End If
    MiObjeto.Clear
    MiObjeto.AddItem "  "
    Do While Bac_SQL_Fetch(Datos())
        MiObjeto.AddItem Datos(1) & " - " & Datos(2)
    Loop
End Sub

Private Sub CargaTipoOperacion(MiObjeto As ComboBox)
    Dim Datos()
   
    Envia = Array()
    AddParam Envia, FiltroSistema
    If Not Bac_Sql_Execute("bacparamsuda..SP_CARGA_TIP_OPERACION", Envia) Then
        Exit Sub
    End If
    MiObjeto.Clear
    MiObjeto.AddItem "  "
    Do While Bac_SQL_Fetch(Datos())
        MiObjeto.AddItem Datos(1) & " - " & Datos(2)
    Loop
End Sub

Private Sub CargaEstadoEnvio(MiObjeto As ComboBox)
    Dim Datos()
   
    Envia = Array()
    AddParam Envia, ePago.AnulaPago '9928
    If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_CARGA_ESTADO_ENVIO", Envia) Then
        Exit Sub
    End If
    MiObjeto.Clear
    Do While Bac_SQL_Fetch(Datos())
        MiObjeto.AddItem Left(Datos(2) & Space(40), 40) & " - " & Datos(3)
    Loop
    If MiObjeto.ListCount > 0 Then MiObjeto.ListIndex = 1
End Sub

Private Sub LimpiaControlesFiltro()
    Me.txtRutCliente.Text = 0
    txtNomCliente.Caption = ""
    If cmbSistema.ListCount > 0 Then cmbSistema.ListIndex = 0
    If cmbTipOper.ListCount > 0 Then cmbTipOper.ListIndex = 0
End Sub

Private Sub TitulosGrid()
    Grid.Cols = 60
    
    Grid.Rows = 3
    Grid.FixedRows = 2
    Grid.FixedCols = 0
   
    Grid.TextMatrix(0, eCol.EnviarPago) = "Enviar"
    Grid.TextMatrix(1, eCol.EnviarPago) = "a Pago"
    Grid.ColWidth(eCol.EnviarPago) = 700
    Grid.ColAlignment(eCol.EnviarPago) = flexAlignLeftCenter
   
    Grid.TextMatrix(0, eCol.Sistema) = "Sistema"
    Grid.TextMatrix(1, eCol.Sistema) = ""
    Grid.ColWidth(eCol.Sistema) = 1000
    Grid.ColAlignment(eCol.Sistema) = flexAlignLeftCenter
   
    Grid.TextMatrix(0, eCol.NumeroOperacion) = "Número"
    Grid.TextMatrix(1, eCol.NumeroOperacion) = "Operación"
    Grid.ColWidth(eCol.NumeroOperacion) = 1000
    Grid.ColAlignment(eCol.NumeroOperacion) = flexAlignRightCenter
   
    Grid.TextMatrix(0, eCol.TipoOperacion) = "Cód Tipo"
    Grid.TextMatrix(1, eCol.TipoOperacion) = "Operación"
    Grid.ColWidth(eCol.TipoOperacion) = 0
    Grid.ColAlignment(eCol.TipoOperacion) = flexAlignLeftCenter
    
    '--> 2021.08.04 INI cvegasan mostrar código de moneda
    'Grid.TextMatrix(0, eCol.GlosaTipoOperacion) = "Tipo"
    'Grid.TextMatrix(1, eCol.GlosaTipoOperacion) = "Operación"
    'Grid.ColWidth(eCol.GlosaTipoOperacion) = 1200
    'Grid.ColAlignment(eCol.GlosaTipoOperacion) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.GlosaTipoOperacion) = "Tipo"
    Grid.TextMatrix(1, eCol.GlosaTipoOperacion) = "Operación"
    Grid.ColWidth(eCol.GlosaTipoOperacion) = 1600
    Grid.ColAlignment(eCol.GlosaTipoOperacion) = flexAlignLeftCenter
    '--< 2021.08.04 FIN cvegasan mostrar código de moneda
   
    Grid.TextMatrix(0, eCol.Indicador) = "Indicador"
    Grid.TextMatrix(1, eCol.Indicador) = ""
    Grid.ColWidth(eCol.Indicador) = 0
    Grid.ColAlignment(eCol.Indicador) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.FechaOperacion) = "Fecha"
    Grid.TextMatrix(1, eCol.FechaOperacion) = "Operacion"
    Grid.ColWidth(eCol.FechaOperacion) = 1200
    Grid.ColAlignment(eCol.FechaOperacion) = flexAlignCenterCenter
   
    Grid.TextMatrix(0, eCol.Usuario) = "Usuario"
    Grid.TextMatrix(1, eCol.Usuario) = ""
    Grid.ColWidth(eCol.Usuario) = 0
    Grid.ColAlignment(eCol.Usuario) = flexAlignLeftCenter
    
    '--> 2021.08.04 INI cvegasan mostrar código de moneda
    'Grid.TextMatrix(0, eCol.Moneda) = "Código"
    'Grid.TextMatrix(1, eCol.Moneda) = "Moneda"
    'Grid.ColWidth(eCol.Moneda) = 0
    'Grid.ColAlignment(eCol.Moneda) = flexAlignRightCenter
    
    'Grid.TextMatrix(0, eCol.GlosaMoneda) = "Moneda"
    'Grid.TextMatrix(1, eCol.GlosaMoneda) = ""
    'Grid.ColWidth(eCol.GlosaMoneda) = 1200
    'Grid.ColAlignment(eCol.GlosaMoneda) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.Moneda) = "Moneda"
    Grid.TextMatrix(1, eCol.Moneda) = ""
    Grid.ColWidth(eCol.Moneda) = 800
    Grid.ColAlignment(eCol.Moneda) = flexAlignRightCenter
    
    Grid.TextMatrix(0, eCol.GlosaMoneda) = "Glosa"
    Grid.TextMatrix(1, eCol.GlosaMoneda) = "Moneda"
    Grid.ColWidth(eCol.GlosaMoneda) = 0
    Grid.ColAlignment(eCol.GlosaMoneda) = flexAlignLeftCenter
    '--< 2021.08.04 FIN cvegasan mostrar código de moneda
    
    Grid.TextMatrix(0, eCol.RutCliente) = "Rut"
    Grid.TextMatrix(1, eCol.RutCliente) = "Cliente"
    Grid.ColWidth(eCol.RutCliente) = 1200
    Grid.ColAlignment(eCol.RutCliente) = flexAlignRightCenter
     
    Grid.TextMatrix(0, eCol.DvCliente) = "Dv"
    Grid.TextMatrix(1, eCol.DvCliente) = "Cliente"
    Grid.ColWidth(eCol.DvCliente) = 0
    Grid.ColAlignment(eCol.DvCliente) = flexAlignRightCenter
    
    Grid.TextMatrix(0, eCol.Sucursal) = "Sucursal"
    Grid.TextMatrix(1, eCol.Sucursal) = ""
    Grid.ColWidth(eCol.Sucursal) = 0
    Grid.ColAlignment(eCol.Sucursal) = flexAlignRightCenter
    
    Grid.TextMatrix(0, eCol.MontoOperacion) = "Monto"
    Grid.TextMatrix(1, eCol.MontoOperacion) = "Operación"
    Grid.ColWidth(eCol.MontoOperacion) = 1800
    Grid.ColAlignment(eCol.MontoOperacion) = flexAlignRightCenter
    
    Grid.TextMatrix(0, eCol.FormaPago) = "Código"
    Grid.TextMatrix(1, eCol.FormaPago) = "Forma Pago"
    Grid.ColWidth(eCol.FormaPago) = 0
    Grid.ColAlignment(eCol.FormaPago) = flexAlignRightCenter
    
    Grid.TextMatrix(0, eCol.GlosaFormaPago) = "Forma"
    Grid.TextMatrix(1, eCol.GlosaFormaPago) = "Pago"
    Grid.ColWidth(eCol.GlosaFormaPago) = 2150
    Grid.ColAlignment(eCol.GlosaFormaPago) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.CodigoValuta) = "Código"
    Grid.TextMatrix(1, eCol.CodigoValuta) = "Valuta"
    Grid.ColWidth(eCol.CodigoValuta) = 0
    Grid.ColAlignment(eCol.CodigoValuta) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.NombreCliente) = "Nombre"
    Grid.TextMatrix(1, eCol.NombreCliente) = "Cliente"
    Grid.ColWidth(eCol.NombreCliente) = 2500
    Grid.ColAlignment(eCol.NombreCliente) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.Banco) = "Banco"
    Grid.TextMatrix(1, eCol.Banco) = ""
    Grid.ColWidth(eCol.Banco) = 0
    Grid.ColAlignment(eCol.Banco) = flexAlignLeftCenter
 
    Grid.TextMatrix(0, eCol.CtaCteBeneficiarioVendedor) = "CuentaCorriente"
    Grid.TextMatrix(1, eCol.CtaCteBeneficiarioVendedor) = "BeneficiarioVendedor"
    Grid.ColWidth(eCol.CtaCteBeneficiarioVendedor) = 0
    Grid.ColAlignment(eCol.CtaCteBeneficiarioVendedor) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.ClaveAbif) = "Clave"
    Grid.TextMatrix(1, eCol.ClaveAbif) = "Abif"
    Grid.ColWidth(eCol.ClaveAbif) = 0
    Grid.ColAlignment(eCol.ClaveAbif) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.CtaComprador) = "Cuenta"
    Grid.TextMatrix(1, eCol.CtaComprador) = "Comprador"
    Grid.ColWidth(eCol.CtaComprador) = 0
    Grid.ColAlignment(eCol.CtaComprador) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.CodigoDcvComprador) = "CodigoDcv"
    Grid.TextMatrix(1, eCol.CodigoDcvComprador) = "Comprador"
    Grid.ColWidth(eCol.CodigoDcvComprador) = 0
    Grid.ColAlignment(eCol.CodigoDcvComprador) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.CtaVendedor) = "Cuenta"
    Grid.TextMatrix(1, eCol.CtaVendedor) = "Vendedor"
    Grid.ColWidth(eCol.CtaVendedor) = 0
    Grid.ColAlignment(eCol.CtaVendedor) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.CodigoDcvVendedor) = "CódigoDcv"
    Grid.TextMatrix(1, eCol.CodigoDcvVendedor) = "Vendedor"
    Grid.ColWidth(eCol.CodigoDcvVendedor) = 0
    Grid.ColAlignment(eCol.CodigoDcvVendedor) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.MontoOriginal) = "Monto"
    Grid.TextMatrix(1, eCol.MontoOriginal) = "Original"
    Grid.ColWidth(eCol.MontoOriginal) = 0
    Grid.ColAlignment(eCol.MontoOriginal) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.FechaInicio) = "Fecha"
    Grid.TextMatrix(1, eCol.FechaInicio) = "Inicio"
    Grid.ColWidth(eCol.FechaInicio) = 0
    Grid.ColAlignment(eCol.FechaInicio) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.TasaInteres) = "Tasa"
    Grid.TextMatrix(1, eCol.TasaInteres) = "Interés"
    Grid.ColWidth(eCol.TasaInteres) = 0
    Grid.ColAlignment(eCol.TasaInteres) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.Interes) = "Interés"
    Grid.TextMatrix(1, eCol.Interes) = ""
    Grid.ColWidth(eCol.Interes) = 0
    Grid.ColAlignment(eCol.Interes) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.MontoVencimiento) = "Monto"
    Grid.TextMatrix(1, eCol.MontoVencimiento) = "Vencimiento"
    Grid.ColWidth(eCol.MontoVencimiento) = 0
    Grid.ColAlignment(eCol.MontoVencimiento) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.FechaVencimiento) = "Fecha"
    Grid.TextMatrix(1, eCol.FechaVencimiento) = "Vencimiento"
    Grid.ColWidth(eCol.FechaVencimiento) = 0
    Grid.ColAlignment(eCol.FechaVencimiento) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.Reajustabilidad) = "Reajustabilidad"
    Grid.TextMatrix(1, eCol.Reajustabilidad) = ""
    Grid.ColWidth(eCol.Reajustabilidad) = 0
    Grid.ColAlignment(eCol.Reajustabilidad) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.TasaPacto) = "Tasa"
    Grid.TextMatrix(1, eCol.TasaPacto) = "Pacto"
    Grid.ColWidth(eCol.TasaPacto) = 0
    Grid.ColAlignment(eCol.TasaPacto) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.MontoFinal) = "Monto"
    Grid.TextMatrix(1, eCol.MontoFinal) = "Final"
    Grid.ColWidth(eCol.MontoFinal) = 0
    Grid.ColAlignment(eCol.MontoFinal) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.MontoNominal) = "Monto"
    Grid.TextMatrix(1, eCol.MontoNominal) = "Nominal"
    Grid.ColWidth(eCol.MontoNominal) = 0
    Grid.ColAlignment(eCol.MontoNominal) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.TasaDescuento) = "Tasa"
    Grid.TextMatrix(1, eCol.TasaDescuento) = "Descuento"
    Grid.ColWidth(eCol.TasaDescuento) = 0
    Grid.ColAlignment(eCol.TasaDescuento) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.ValorTasa) = "Valor"
    Grid.TextMatrix(1, eCol.ValorTasa) = "Tasa"
    Grid.ColWidth(eCol.ValorTasa) = 0
    Grid.ColAlignment(eCol.ValorTasa) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.Custodia) = "Custodia"
    Grid.TextMatrix(1, eCol.Custodia) = ""
    Grid.ColWidth(eCol.Custodia) = 0
    Grid.ColAlignment(eCol.Custodia) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.NumeroInstrumentos) = "Número"
    Grid.TextMatrix(1, eCol.NumeroInstrumentos) = "Instrumentos"
    Grid.ColWidth(eCol.NumeroInstrumentos) = 0
    Grid.ColAlignment(eCol.NumeroInstrumentos) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.MontoTotal) = "Monto"
    Grid.TextMatrix(1, eCol.MontoTotal) = "Total"
    Grid.ColWidth(eCol.MontoTotal) = 0
    Grid.ColAlignment(eCol.MontoTotal) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.CodigoMonMx) = "Codigo Moneda"
    Grid.TextMatrix(1, eCol.CodigoMonMx) = "Mx"
    Grid.ColWidth(eCol.CodigoMonMx) = 0
    Grid.ColAlignment(eCol.CodigoMonMx) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.MontoMx) = "Monto"
    Grid.TextMatrix(1, eCol.MontoMx) = "Mx"
    Grid.ColWidth(eCol.MontoMx) = 0
    Grid.ColAlignment(eCol.MontoMx) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.TasaCambio) = "Tasa"
    Grid.TextMatrix(1, eCol.TasaCambio) = "Cambio"
    Grid.ColWidth(eCol.TasaCambio) = 0
    Grid.ColAlignment(eCol.TasaCambio) = flexAlignLeftCenter
  
    Grid.TextMatrix(0, eCol.FechaValorMx) = "Fecha Valor"
    Grid.TextMatrix(1, eCol.FechaValorMx) = "Mx"
    Grid.ColWidth(eCol.FechaValorMx) = 0
    Grid.ColAlignment(eCol.FechaValorMx) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.FormaPagoNeg) = "Forma Pago"
    Grid.TextMatrix(1, eCol.FormaPagoNeg) = "Neg"
    Grid.ColWidth(eCol.FormaPagoNeg) = 0
    Grid.ColAlignment(eCol.FormaPagoNeg) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.Sesion) = "Sesión"
    Grid.TextMatrix(1, eCol.Sesion) = ""
    Grid.ColWidth(eCol.Sesion) = 0
    Grid.ColAlignment(eCol.Sesion) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.NombreClienteBeneficiario_3) = "NombreCliente"
    Grid.TextMatrix(1, eCol.NombreClienteBeneficiario_3) = "Beneficiario_3"
    Grid.ColWidth(eCol.NombreClienteBeneficiario_3) = 0
    Grid.ColAlignment(eCol.NombreClienteBeneficiario_3) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.NombreClienteBeneficiario_4) = "NombreCliente"
    Grid.TextMatrix(1, eCol.NombreClienteBeneficiario_4) = "Beneficiario_4"
    Grid.ColWidth(eCol.NombreClienteBeneficiario_4) = 0
    Grid.ColAlignment(eCol.NombreClienteBeneficiario_4) = flexAlignLeftCenter

    Grid.TextMatrix(0, eCol.UsuarioMDP) = "UsuarioMDP"
    Grid.TextMatrix(1, eCol.UsuarioMDP) = ""
    Grid.ColWidth(eCol.UsuarioMDP) = 0
    Grid.ColAlignment(eCol.UsuarioMDP) = flexAlignLeftCenter

    Grid.TextMatrix(0, eCol.UsuarioIngreso) = "UsuarioIngreso"
    Grid.TextMatrix(1, eCol.UsuarioIngreso) = ""
    Grid.ColWidth(eCol.UsuarioIngreso) = 0
    Grid.ColAlignment(eCol.UsuarioIngreso) = flexAlignLeftCenter

    Grid.TextMatrix(0, eCol.CargoCtaCte) = "CargoCtaCte"
    Grid.TextMatrix(1, eCol.CargoCtaCte) = ""
    Grid.ColWidth(eCol.CargoCtaCte) = 0
    Grid.ColAlignment(eCol.CargoCtaCte) = flexAlignLeftCenter

    Grid.TextMatrix(0, eCol.SobregiroCtaCte) = "SobregiroCtaCte"
    Grid.TextMatrix(1, eCol.SobregiroCtaCte) = ""
    Grid.ColWidth(eCol.SobregiroCtaCte) = 0
    Grid.ColAlignment(eCol.SobregiroCtaCte) = flexAlignLeftCenter

    Grid.TextMatrix(0, eCol.PvpReferencia) = "PvpReferencia"
    Grid.TextMatrix(1, eCol.PvpReferencia) = ""
    Grid.ColWidth(eCol.PvpReferencia) = 0
    Grid.ColAlignment(eCol.PvpReferencia) = flexAlignLeftCenter

    Grid.TextMatrix(0, eCol.PvpMoneda) = "PvpMoneda"
    Grid.TextMatrix(1, eCol.PvpMoneda) = ""
    Grid.ColWidth(eCol.PvpMoneda) = 0
    Grid.ColAlignment(eCol.PvpMoneda) = flexAlignLeftCenter

    Grid.TextMatrix(0, eCol.PvpTasaCambio) = "PvpTasaCambio"
    Grid.TextMatrix(1, eCol.PvpTasaCambio) = ""
    Grid.ColWidth(eCol.PvpTasaCambio) = 0
    Grid.ColAlignment(eCol.PvpTasaCambio) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.PvpMonto) = "PvpMonto"
    Grid.TextMatrix(1, eCol.PvpMonto) = ""
    Grid.ColWidth(eCol.PvpMonto) = 0
    Grid.ColAlignment(eCol.PvpMonto) = flexAlignLeftCenter

    Grid.TextMatrix(0, eCol.CodCliente) = "Código"
    Grid.TextMatrix(1, eCol.CodCliente) = "Cliente"
    Grid.ColWidth(eCol.CodCliente) = 0
    Grid.ColAlignment(eCol.CodCliente) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.CodigoDcv2) = "Código"
    Grid.TextMatrix(1, eCol.CodigoDcv2) = "DCV2"
    Grid.ColWidth(eCol.CodigoDcv2) = 0
    Grid.ColAlignment(eCol.CodigoDcv2) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.Estado) = "Código"
    Grid.TextMatrix(1, eCol.Estado) = "Estado"
    Grid.ColWidth(eCol.Estado) = 0
    Grid.ColAlignment(eCol.Estado) = flexAlignLeftCenter
    
    Grid.TextMatrix(0, eCol.EstadoGlosa) = "Descripción"
    Grid.TextMatrix(1, eCol.EstadoGlosa) = "Estado"
    Grid.ColWidth(eCol.EstadoGlosa) = 2500
    Grid.ColAlignment(eCol.EstadoGlosa) = flexAlignLeftCenter
    Grid.RowHeightMin = 315
End Sub

Private Sub CargarDatosFiltrados(ByRef p As tSPParametros)
Dim Datos()
    Grid.Redraw = False
    iRegistros = 0
   
    Envia = Array()
    AddParam Envia, p.Sistema
    AddParam Envia, p.CodigoProducto
    AddParam Envia, p.RutCliente
    AddParam Envia, p.CodCliente
    AddParam Envia, p.Tipcliente
    AddParam Envia, p.TipOperacion
    AddParam Envia, p.EstadoConfir
    AddParam Envia, p.Numoper
    AddParam Envia, p.TbCategoria
    
    If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_OPERACIONES_ENVIO_PAGO", Envia) Then
       GoTo ErrorCargaSql
    End If
    
    Grid.Rows = 2
    Do While Bac_SQL_Fetch(Datos())
        Grid.Rows = Grid.Rows + 1
        Grid.TextMatrix(Grid.Rows - 1, eCol.EnviarPago) = Space(15) & Datos(1)
        Grid.Col = 0
        Grid.Row = (Grid.Rows - 1)
       
        If Datos(1) = "SI" Then
           Set Grid.CellPicture = Me.ConCheck(0).Image
        Else
           Set Grid.CellPicture = Me.SinCheck(0).Image
        End If

        Grid.TextMatrix(Grid.Rows - 1, eCol.Sistema) = Datos(2)
        Grid.TextMatrix(Grid.Rows - 1, eCol.NumeroOperacion) = Format(Datos(3), "#,##0")
        Grid.TextMatrix(Grid.Rows - 1, eCol.TipoOperacion) = Datos(4)
        Grid.TextMatrix(Grid.Rows - 1, eCol.GlosaTipoOperacion) = Datos(5)
        Grid.TextMatrix(Grid.Rows - 1, eCol.Indicador) = Datos(6)
        Grid.TextMatrix(Grid.Rows - 1, eCol.FechaOperacion) = Datos(7)
        Grid.TextMatrix(Grid.Rows - 1, eCol.Usuario) = Datos(8)
        Grid.TextMatrix(Grid.Rows - 1, eCol.Moneda) = Datos(9)
        Grid.TextMatrix(Grid.Rows - 1, eCol.GlosaMoneda) = Datos(10)
        Grid.TextMatrix(Grid.Rows - 1, eCol.RutCliente) = Format(Datos(11), "#,##0")
        Grid.TextMatrix(Grid.Rows - 1, eCol.DvCliente) = Datos(12)
        Grid.TextMatrix(Grid.Rows - 1, eCol.Sucursal) = Datos(13)
        Grid.TextMatrix(Grid.Rows - 1, eCol.MontoOperacion) = Format(Datos(14), "#,##0.0000")
        Grid.TextMatrix(Grid.Rows - 1, eCol.FormaPago) = Datos(15)
        Grid.TextMatrix(Grid.Rows - 1, eCol.GlosaFormaPago) = Datos(16)
        Grid.TextMatrix(Grid.Rows - 1, eCol.CodigoValuta) = Datos(17)
        Grid.TextMatrix(Grid.Rows - 1, eCol.NombreCliente) = Datos(18)
        
        Grid.TextMatrix(Grid.Rows - 1, eCol.Banco) = Datos(19)
        Grid.TextMatrix(Grid.Rows - 1, eCol.CtaCteBeneficiarioVendedor) = Datos(20)
        
        Grid.TextMatrix(Grid.Rows - 1, eCol.ClaveAbif) = Datos(21)
        
        Grid.TextMatrix(Grid.Rows - 1, eCol.CtaComprador) = Datos(22)
        Grid.TextMatrix(Grid.Rows - 1, eCol.CodigoDcvComprador) = Datos(23)
        Grid.TextMatrix(Grid.Rows - 1, eCol.CtaVendedor) = Datos(24)
        Grid.TextMatrix(Grid.Rows - 1, eCol.CodigoDcvVendedor) = Datos(25)
        
        Grid.TextMatrix(Grid.Rows - 1, eCol.MontoOriginal) = Format(Datos(26), "#,##0.0000")
        Grid.TextMatrix(Grid.Rows - 1, eCol.FechaInicio) = Datos(27)
        Grid.TextMatrix(Grid.Rows - 1, eCol.TasaInteres) = Format(Datos(28), "#,##0.0000")
        Grid.TextMatrix(Grid.Rows - 1, eCol.Interes) = Datos(29)
        Grid.TextMatrix(Grid.Rows - 1, eCol.MontoVencimiento) = Format(Datos(30), "#,##0.0000")
        Grid.TextMatrix(Grid.Rows - 1, eCol.FechaVencimiento) = Datos(31)
        Grid.TextMatrix(Grid.Rows - 1, eCol.Reajustabilidad) = Datos(32)
        Grid.TextMatrix(Grid.Rows - 1, eCol.TasaPacto) = Format(Datos(33), "#,##0.0000")
        Grid.TextMatrix(Grid.Rows - 1, eCol.MontoFinal) = Format(Datos(34), "#,##0.0000")
        Grid.TextMatrix(Grid.Rows - 1, eCol.MontoNominal) = Datos(35)
        Grid.TextMatrix(Grid.Rows - 1, eCol.TasaDescuento) = Datos(36)
        Grid.TextMatrix(Grid.Rows - 1, eCol.ValorTasa) = Datos(37)
        Grid.TextMatrix(Grid.Rows - 1, eCol.Custodia) = Datos(38)
        Grid.TextMatrix(Grid.Rows - 1, eCol.NumeroInstrumentos) = Datos(39)
        Grid.TextMatrix(Grid.Rows - 1, eCol.MontoTotal) = Datos(40)
        Grid.TextMatrix(Grid.Rows - 1, eCol.CodigoMonMx) = Datos(41)
        Grid.TextMatrix(Grid.Rows - 1, eCol.MontoMx) = Datos(42)
        Grid.TextMatrix(Grid.Rows - 1, eCol.TasaCambio) = Datos(43)
        Grid.TextMatrix(Grid.Rows - 1, eCol.FechaValorMx) = Datos(44)
        Grid.TextMatrix(Grid.Rows - 1, eCol.FormaPagoNeg) = Datos(45)
        Grid.TextMatrix(Grid.Rows - 1, eCol.Sesion) = Datos(46)
        
        Grid.TextMatrix(Grid.Rows - 1, eCol.NombreClienteBeneficiario_3) = Datos(47)
        Grid.TextMatrix(Grid.Rows - 1, eCol.NombreClienteBeneficiario_4) = Datos(48)
        Grid.TextMatrix(Grid.Rows - 1, eCol.UsuarioMDP) = gsBAC_User
        Grid.TextMatrix(Grid.Rows - 1, eCol.UsuarioIngreso) = Datos(50)
        Grid.TextMatrix(Grid.Rows - 1, eCol.CargoCtaCte) = Datos(51)
        Grid.TextMatrix(Grid.Rows - 1, eCol.SobregiroCtaCte) = Datos(52)
        
        Grid.TextMatrix(Grid.Rows - 1, eCol.PvpReferencia) = Datos(53)
        Grid.TextMatrix(Grid.Rows - 1, eCol.PvpMoneda) = Datos(54)
        Grid.TextMatrix(Grid.Rows - 1, eCol.PvpTasaCambio) = Datos(55)
        Grid.TextMatrix(Grid.Rows - 1, eCol.PvpMonto) = Datos(56)

        Grid.TextMatrix(Grid.Rows - 1, eCol.CodCliente) = Datos(57)
        Grid.TextMatrix(Grid.Rows - 1, eCol.CodigoDcv2) = Datos(58)
        Grid.TextMatrix(Grid.Rows - 1, eCol.Estado) = Datos(59)
        Grid.TextMatrix(Grid.Rows - 1, eCol.EstadoGlosa) = Datos(60)
        iRegistros = iRegistros + 1
    Loop
    Grid.Redraw = True
    If iRegistros = 0 Then MsgBox "No existen datos para el filtro seleccionado"
    Exit Sub
ErrorCargaSql:
   Grid.Redraw = True
   MsgBox "Problemas en la carga de información", vbExclamation, TITSISTEMA
End Sub

Private Sub CargarDatos()
On Error GoTo ErrorCarga
Dim p As tSPParametros
    p.Sistema = ""
    p.CodigoProducto = ""
    p.RutCliente = 0
    p.CodCliente = 0
    p.Tipcliente = 0
    p.TipOperacion = ""
    p.EstadoConfir = "A" '"S" Las operaciones deben estar con estado "A" en aprobacion_operacion
    p.Numoper = 0
    p.TbCategoria = ePago.EnvioPago '9927
    Call CargarDatosFiltrados(p)
ErrorCarga:
   Exit Sub
End Sub

Private Sub CargaConexionWS()
Dim Datos()
    ' URL Webservice (11)PaymentTrxTradersCrg,(12)CancelPaymentNGINE,(13)setPaymentDocumentNgine
    Envia = Array()
    AddParam Envia, 10
    If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_CARGA_PARAMETRIA_WS", Envia) Then
        Exit Sub
    End If
    
    WS.Url = ""
    Do While Bac_SQL_Fetch(Datos())
       WS.Url = Datos(3)
    Loop
    
    ' IngresarPagoMesaCrg
    Envia = Array()
    AddParam Envia, 11
    If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_CARGA_PARAMETRIA_WS", Envia) Then
        Exit Sub
    End If
    
    WS.Action = ""
    Do While Bac_SQL_Fetch(Datos())
       WS.Action = Datos(3)
    Loop
    
    ' AnularPagoCrg
    Envia = Array()
    AddParam Envia, 12
    If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_CARGA_PARAMETRIA_WS", Envia) Then
        Exit Sub
    End If
    
    WS.Action5 = ""
    Do While Bac_SQL_Fetch(Datos())
       WS.Action5 = Datos(3)
    Loop
    
    ' IngresarPagoDocumento
    Envia = Array()
    AddParam Envia, 13
    If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_CARGA_PARAMETRIA_WS", Envia) Then
        Exit Sub
    End If
    
    WS.Action3 = ""
    Do While Bac_SQL_Fetch(Datos())
       WS.Action3 = Datos(3)
    Loop
    
    ' URL Webservice (21) PaymentTrxTradersPiCrg
    Envia = Array()
    AddParam Envia, 20
    If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_CARGA_PARAMETRIA_WS", Envia) Then
        Exit Sub
    End If
    
    WS.Url2 = ""
    Do While Bac_SQL_Fetch(Datos())
       WS.Url2 = Datos(3)
    Loop
     
    ' IngresarPagoMesaPICrg
    Envia = Array()
    AddParam Envia, 21
    If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_CARGA_PARAMETRIA_WS", Envia) Then
        Exit Sub
    End If
    
    WS.Action2 = ""
    Do While Bac_SQL_Fetch(Datos())
       WS.Action2 = Datos(3)
    Loop

End Sub

Private Sub Anular_Pago_Automatico_Operaciones_BTR_MDP(indFila As Long)
Dim Datos()
Dim occ As New clsCC
Dim strres As String
'-- ===================================================================
'-- Retorna parametros XML CANAL, APPCOD o APPNAME para broker
'-- ===================================================================
        ' Se deben definir los valores para codigocanal,CodigoAplicacion y NombreAplicacion
        'occ.CodigoCanal = 0
        'occ.CodigoAplicacion = ""
        'occ.NombreAplicacion = ""
        Envia = Array()
        AddParam Envia, eEquivalencias.XmlParametros
        AddParam Envia, "CANAL" 'CANAL, APPCOD o APPNAME
        AddParam Envia, 0
        If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA", Envia) Then
            Exit Sub
        End If

        Do While Bac_SQL_Fetch(Datos())
            occ.CodigoCanal = Datos(1)
        Loop
        
        Envia = Array()
        AddParam Envia, eEquivalencias.XmlParametros
        AddParam Envia, "APPCOD" 'CANAL, APPCOD o APPNAME
        AddParam Envia, 0
        If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA", Envia) Then
            Exit Sub
        End If

        Do While Bac_SQL_Fetch(Datos())
            occ.CodigoAplicacion = Datos(1)
        Loop
        
        Envia = Array()
        AddParam Envia, eEquivalencias.XmlParametros
        AddParam Envia, "APPNAME" 'CANAL, APPCOD o APPNAME
        AddParam Envia, 0
        If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA", Envia) Then
            Exit Sub
        End If

        Do While Bac_SQL_Fetch(Datos())
            occ.NombreAplicacion = Datos(1)
        Loop
'-- ===================================================================
'-- Anulacion operaciones
'-- ===================================================================
    With Grid
        'Retorna codigo sistema equivalente en MDP
        Envia = Array()
        AddParam Envia, eEquivalencias.Sistema
        AddParam Envia, .TextMatrix(indFila, eCol.Sistema) 'BTR, BEX o PCS
        AddParam Envia, 0
        If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA", Envia) Then
            Exit Sub
        End If

        Do While Bac_SQL_Fetch(Datos())
            occ.CodigoProducto = Datos(1) '.TextMatrix(indFila, eCol.Sistema)
        Loop
        '--> 2021.09.24 INI cvegasan se debe enviar el equivalente del codigo del producto, no el de sistema
        'RFN RC->REC/REC->RECOMP = RC->RECOMP
        'exec bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA 9932,'RFN','RC'
        Envia = Array()
        AddParam Envia, eEquivalencias.Producto
        AddParam Envia, occ.CodigoProducto
        AddParam Envia, .TextMatrix(indFila, eCol.TipoOperacion)
        If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA", Envia) Then
            Exit Sub
        End If
        
        Do While Bac_SQL_Fetch(Datos())
            occ.CodigoProductoEquivalente = Datos(2)
        Loop
        occ.CodigoProducto = occ.CodigoProductoEquivalente
        '--< 2021.09.24 FIN cvegasan se debe enviar el equivalente del codigo del producto, no el de sistema
        
        occ.NumeroOperacion = .TextMatrix(indFila, eCol.NumeroOperacion)
        occ.UsuarioIngreso = gsUsuario
       
        'Rescatar la url del webservice y del método con el servicio SP_NGINE_CARGA_PARAMETRIA_WS
        occ.wsURL = WS.Url
    
        occ.wsACTION = WS.Action5 'Anulacion envío pago
        strres = occ.CC_ANULACIONPAGOCRG
        
        'If Trim(.TextMatrix(indFila, eCol.Sistema)) <> "BEX" Then
        '    occ.wsACTION = WS.Action5 'Anulacion envío pago
        '    strres = occ.CC_ANULACIONPAGOCRG
        'Else
        '    occ.wsACTION = WS.Action6 'Anulacion envío pago extranjero
        '    strres = occ.CC_ANULACIONPAGOPI
        'End If
    End With
    
    'Error en envio XML (Clase), muestra mensaje y termina
    '--> 2022.04.07 INI cvegasan ajuste en ventana que muestra error
    'If occ.Estado = "-1" Then
    If (occ.Estado = "-1") Or (strres <> "") Then
    '--< 2022.04.07 FIN cvegasan ajuste en ventana que muestra error
      ListErrores.AddItem (strres)
      occ.Estado = "0"
      Exit Sub
    End If
    
    'Error operacion viene con observaciones la agrega al ListErrores
    If StrComp(occ.Mensaje, "OK", vbBinaryCompare) <> 0 Then
        ListErrores.AddItem (CStr(occ.NumeroOperacion) & " " & occ.Mensaje)
    Else
        Envia = Array()
        AddParam Envia, ePago.AnulaPago
        AddParam Envia, CStr(Grid.TextMatrix(indFila, eCol.Sistema))          'Sistema
        AddParam Envia, CDbl(Grid.TextMatrix(indFila, eCol.NumeroOperacion))  'NumeroOperacion
        AddParam Envia, CStr(Grid.TextMatrix(indFila, eCol.Estado))           'Estado envío
        If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_ACTUALIZACION_ESTADO_PAGO", Envia) Then
           GoTo ErrorEnvio
        End If
    End If
ErrorEnvio:
    Exit Sub
End Sub

Private Sub GrabarEnvio()
   On Error GoTo ErrorEnvio
   Dim Datos()
   Dim iContador  As Long
   
   'Si no existen registros seleccionados muestra mensaje
   If VerificaRegistrosSeleccionados(Grid) = False Then
    MsgBox "No existen operaciones seleccionadas, para anulación pago ", vbExclamation, TITSISTEMA
    Exit Sub
   End If
   
   For iContador = 2 To Grid.Rows - 1
        If Trim(Grid.TextMatrix(iContador, eCol.EnviarPago)) = "SI" And Trim(Grid.TextMatrix(iContador, eCol.Estado)) <> "PP" Then
            If Trim(Grid.TextMatrix(iContador, eCol.Estado)) = "APM" Then
                Envia = Array()
                AddParam Envia, ePago.AnulaPago
                AddParam Envia, CStr(Grid.TextMatrix(iContador, eCol.Sistema))          'Sistema
                AddParam Envia, CDbl(Grid.TextMatrix(iContador, eCol.NumeroOperacion))  'NumeroOperacion
                AddParam Envia, CStr(Grid.TextMatrix(iContador, eCol.Estado))           'Estado envío
                If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_ACTUALIZACION_ESTADO_PAGO", Envia) Then
                   GoTo ErrorEnvio
                End If
            ElseIf Trim(Grid.TextMatrix(iContador, eCol.Estado)) = "APA" Then 'Anula Pago Automatico
                    Call Anular_Pago_Automatico_Operaciones_BTR_MDP(iContador)
            End If
        End If
    Next iContador
    
   
    If Me.ListErrores.ListCount > 0 Then
        MsgBox "Existen operaciones con observaciones. Por favor, revisar y enviar nuevamente ", vbExclamation, TITSISTEMA
    Else
         MsgBox "Operaciones pago anulado", vbExclamation, TITSISTEMA
    End If
    
    Call CargarDatos

Exit Sub
ErrorEnvio:
   MsgBox "¡ Problemas al tratar de anular pago. !", vbExclamation, TITSISTEMA
End Sub

Private Function ValidaEstadoEnvio(ByRef ve As tSPValidaEstados)
On Error GoTo ErrorEnvio
Dim Datos()
    
    ValidaEstadoEnvio = False
    
    Envia = Array()
    
    AddParam Envia, CDbl(ve.Numoper)
    AddParam Envia, CStr(ve.Estado)
    AddParam Envia, CDbl(ePago.AnulaPago)         'Estado envío
    If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_BUSCA_CODIGO_ESTADO_PAGO", Envia) Then
       GoTo ErrorEnvio
    End If
          
    Do While Bac_SQL_Fetch(Datos())
        If Datos(1) = "OK" Then ValidaEstadoEnvio = True
    Loop
    
Exit Function
ErrorEnvio:
    Exit Function
    MsgBox "¡ Problemas al tratar validar estado envio. !", vbExclamation, TITSISTEMA
End Function

Private Function VerificaRegistrosSeleccionados(ByRef oGrid As MSFlexGrid)
Dim iContador  As Long
    iRegistros = 0
    VerificaRegistrosSeleccionados = False
    
    For iContador = 2 To Grid.Rows - 1
        If Trim(oGrid.TextMatrix(iContador, eCol.EnviarPago)) = "SI" And InStr(1, "APM APA", Trim(oGrid.TextMatrix(iContador, eCol.Estado)), vbTextCompare) > 0 Then
                iRegistros = iRegistros + 1
        End If
    Next iContador
    If iRegistros > 0 Then VerificaRegistrosSeleccionados = True
Exit Function
End Function
Private Sub cmbEstadoEnvio_KeyDown(KEYCODE As Integer, Shift As Integer)
Dim ve As tSPValidaEstados
    If KEYCODE = vbKeyReturn Then
        Estado_Valida = Right(cmbEstadoEnvio.Text, 3)
        
        ve.Numoper = Numoper_Valida
        ve.Estado = Estado_Valida
        
        If ValidaEstadoEnvio(ve) = True Then
            Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = cmbEstadoEnvio.Text
            Grid.TextMatrix(Grid.RowSel, eCol.Estado) = Right(cmbEstadoEnvio.Text, 3)
        Else
            If Estado_Valida = "APA" Then 'APA/EPM
                MsgBox "¡ No se puede realizar anulación automática a un pago manual. !", vbExclamation, TITSISTEMA
            Else
                If Estado_Valida = "APM" Then 'APM/EPA
                    MsgBox "¡ No se puede realizar anulación manual a un pago automático. !", vbExclamation, TITSISTEMA
                End If
            End If
        End If
        
        Grid.Enabled = True
        cmbEstadoEnvio.Visible = False
        Grid.SetFocus
    End If
    If KEYCODE = vbKeyEscape Then
        Grid.Enabled = True
        cmbEstadoEnvio.Visible = False
        Grid.SetFocus
    End If
End Sub

Private Sub cmbSiNo_KeyDown(KEYCODE As Integer, Shift As Integer)
   If KEYCODE = vbKeyReturn Then
      Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Space(15) & cmbSiNo.Text
      Grid.Enabled = True
      cmbSiNo.Visible = False
      Grid.SetFocus
   End If
   If KEYCODE = vbKeyEscape Then
      Grid.Enabled = True
      cmbSiNo.Visible = False
      Grid.SetFocus
   End If
   
   If cmbSiNo.Text = "SI" Then
      Set Grid.CellPicture = Me.ConCheck(0).Image
   Else
      Set Grid.CellPicture = Me.SinCheck(0).Image
   End If
End Sub

Private Sub cmbSistema_Click()
    FiltroSistema = Left(cmbSistema.Text, 3)
    Call CargaTipoOperacion(Me.cmbTipOper)
End Sub

Private Sub Form_Load()
    'Me.Icon = BacGrupoProd.Icon
    Me.top = 0: Me.Left = 0
   
    cmbSiNo.AddItem "SI"
    cmbSiNo.AddItem "NO"
   
    Call TitulosGrid
    Call CargarDatos
    Call CargaEstadoEnvio(cmbEstadoEnvio)
    
    Call CargaSistema(cmbSistema)
    Call CargaTipoOperacion(cmbTipOper)
    
    Call CargaConexionWS
End Sub

Private Sub Form_Resize()
On Error Resume Next
     FraCuadro.Width = (Me.Width - 140)
    'FraCuadro.Height = (Me.Height - 850)

    Grid.Width = (FraCuadro.Width - 100)
    'Grid.Height = (FraCuadro.Height - 750)
End Sub

Private Sub Grid_DblClick()
On Error Resume Next
    Select Case Grid.ColSel
        Case eCol.EnviarPago:
            If Trim(Grid.TextMatrix(Grid.RowSel, Grid.ColSel)) = "SI" Then
               Set Grid.CellPicture = Me.SinCheck(0).Image
               Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Space(15) & "NO"
            Else
               Set Grid.CellPicture = Me.ConCheck(0).Image
               Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Space(15) & "SI"
            End If
    
        Case eCol.EstadoGlosa:
            ' Rescato el numero de operacion
            Numoper_Valida = Grid.TextMatrix(Grid.RowSel, eCol.NumeroOperacion) ' con "numero operacion" obtengo tgcodigo1 de tabla_general_detalle
            
            'Muestro combo con opciones de anulacion
            cmbEstadoEnvio.Left = Grid.CellLeft + 20
            cmbEstadoEnvio.top = (Grid.CellTop + 150)
            cmbEstadoEnvio.Width = Grid.CellWidth
            cmbEstadoEnvio.Enabled = True
            cmbEstadoEnvio.Visible = True
            If cmbEstadoEnvio.ListCount > 0 Then cmbEstadoEnvio.ListIndex = 1
            cmbEstadoEnvio.SetFocus
            Grid.Enabled = False
        Case Else
            Exit Sub
   End Select
End Sub

Private Sub Grid_KeyDown(KEYCODE As Integer, Shift As Integer)
On Error Resume Next
'   If KEYCODE = vbKeyReturn Then
'      If Grid.ColSel = 0 Then
'         cmbSiNo.Text = Trim(Grid.TextMatrix(Grid.RowSel, Grid.ColSel))
'         cmbSiNo.Left = (Grid.CellLeft + 550)
'         cmbSiNo.top = (Grid.CellTop + 150)
'         cmbSiNo.Width = (Grid.CellWidth - 490)
'         cmbSiNo.Enabled = True
'         cmbSiNo.Visible = True
'         cmbSiNo.SetFocus
'         Grid.Enabled = False
'      End If
'   End If
    If Grid.Rows > 2 Then
        If KEYCODE = vbKeyF2 Then
             If Grid.ColSel = eCol.EstadoGlosa Then
                cmbEstadoEnvio.Left = Grid.CellLeft + 20
                 cmbEstadoEnvio.top = (Grid.CellTop + 150)
                 cmbEstadoEnvio.Width = Grid.CellWidth
                 cmbEstadoEnvio.Enabled = True
                 cmbEstadoEnvio.Visible = True
                 If cmbEstadoEnvio.ListCount > 0 Then cmbEstadoEnvio.ListIndex = 1
                 cmbEstadoEnvio.SetFocus
                 Grid.Enabled = False
             End If
        End If
    End If
End Sub

' Toolbar Filtro rut,sistema y producto
Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim p As tSPParametros
   Select Case Button.Index
        Case 1
            p.Sistema = Left(cmbSistema.Text, 3)
            p.CodigoProducto = Left(Me.cmbTipOper.Text, 3)
            p.RutCliente = IIf(Me.txtRutCliente <> "0", Split(Me.txtRutCliente, "-")(0), 0)
            p.CodCliente = 0
            p.Tipcliente = 0
            p.TipOperacion = ""
            p.EstadoConfir = "A" '"S" Las operaciones deben estar con estado "A" en aprobacion_operacion
            p.Numoper = 0
            p.TbCategoria = ePago.EnvioPago
            
            Call CargarDatosFiltrados(p)
            pnlFiltro.Visible = False
            Grid.Enabled = True
        Case 2
            pnlFiltro.Visible = False
            Grid.Enabled = True
   End Select
End Sub

'Toolbar form principal
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
        Case 1
            Call GrabarEnvio
        Case 2
            Call CargarDatos
        Case 3
            Call LimpiaControlesFiltro
            pnlFiltro.Visible = True
            Grid.Enabled = False
        Case 4
            Unload Me
   End Select
End Sub

' Parámetros que vienen desde el formulario BacAyuda
Private Sub txtRutCliente_DblClick()
   BacAyuda.tag = "Clientes"
   BacAyuda.Show 1
   If giAceptar Then
      txtRutCliente.Text = gsRutDV
      txtNomCliente.Caption = RetornoAyuda3
   End If
End Sub

Private Sub txtRutCliente_KeyDown(KEYCODE As Integer, Shift As Integer)
   If KEYCODE = vbKeyDelete Then
      txtRutCliente.Text = 0
      txtRutCliente.tag = ""
      txtNomCliente.Caption = ""
      txtNomCliente.tag = 0
   End If
   If KEYCODE = vbKeyF1 Or KEYCODE = vbKeyF3 Then
      Call txtRutCliente_DblClick
   End If
End Sub
