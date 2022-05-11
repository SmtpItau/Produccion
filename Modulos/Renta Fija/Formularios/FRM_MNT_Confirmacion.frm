VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_MNT_Confirmacion 
   Caption         =   "Confirmación de Operaciones."
   ClientHeight    =   4245
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   14880
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   4245
   ScaleWidth      =   14880
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   315
      Index           =   0
      Left            =   855
      Picture         =   "FRM_MNT_Confirmacion.frx":0000
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
      Picture         =   "FRM_MNT_Confirmacion.frx":015A
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
      Width           =   14880
      _ExtentX        =   26247
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
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
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "DEGREGAR"
            ImageIndex      =   46
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "AGREGAR"
            ImageIndex      =   47
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
               Picture         =   "FRM_MNT_Confirmacion.frx":02B4
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":118E
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":2068
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":2F42
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":3E1C
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":4CF6
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":5BD0
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":6AAA
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":7984
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":885E
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":9738
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":9A52
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":A92C
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":B806
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":C6E0
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":D5BA
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":E494
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":F36E
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":10248
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":1069A
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":10AEC
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":10F3E
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":11E18
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":12CF2
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":13144
               Key             =   ""
            EndProperty
            BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":13596
               Key             =   ""
            EndProperty
            BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":139E8
               Key             =   ""
            EndProperty
            BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":13E3A
               Key             =   ""
            EndProperty
            BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":14D14
               Key             =   ""
            EndProperty
            BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":15BEE
               Key             =   ""
            EndProperty
            BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":16AC8
               Key             =   ""
            EndProperty
            BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":179A2
               Key             =   ""
            EndProperty
            BeginProperty ListImage33 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":17CBC
               Key             =   ""
            EndProperty
            BeginProperty ListImage34 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":18B96
               Key             =   ""
            EndProperty
            BeginProperty ListImage35 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":19A70
               Key             =   ""
            EndProperty
            BeginProperty ListImage36 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":1A94A
               Key             =   ""
            EndProperty
            BeginProperty ListImage37 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":1B824
               Key             =   ""
            EndProperty
            BeginProperty ListImage38 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":1C6FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage39 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":1D5D8
               Key             =   ""
            EndProperty
            BeginProperty ListImage40 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":1E4B2
               Key             =   ""
            EndProperty
            BeginProperty ListImage41 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":1F38C
               Key             =   ""
            EndProperty
            BeginProperty ListImage42 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":20266
               Key             =   ""
            EndProperty
            BeginProperty ListImage43 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":21140
               Key             =   ""
            EndProperty
            BeginProperty ListImage44 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":2201A
               Key             =   ""
            EndProperty
            BeginProperty ListImage45 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":22EF4
               Key             =   ""
            EndProperty
            BeginProperty ListImage46 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":23DCE
               Key             =   ""
            EndProperty
            BeginProperty ListImage47 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":24CA8
               Key             =   ""
            EndProperty
            BeginProperty ListImage48 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":25B82
               Key             =   ""
            EndProperty
            BeginProperty ListImage49 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":25E9C
               Key             =   ""
            EndProperty
            BeginProperty ListImage50 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":26D76
               Key             =   ""
            EndProperty
            BeginProperty ListImage51 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":27C50
               Key             =   ""
            EndProperty
            BeginProperty ListImage52 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":27F6A
               Key             =   ""
            EndProperty
            BeginProperty ListImage53 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":28E44
               Key             =   ""
            EndProperty
            BeginProperty ListImage54 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Confirmacion.frx":29D1E
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
      Width           =   14820
      Begin Threed.SSPanel pnlFiltro 
         Height          =   2505
         Left            =   3210
         TabIndex        =   7
         Top             =   540
         Visible         =   0   'False
         Width           =   6495
         _Version        =   65536
         _ExtentX        =   11456
         _ExtentY        =   4419
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
            Height          =   1665
            Left            =   45
            TabIndex        =   9
            Top             =   795
            Width           =   6405
            Begin VB.ComboBox cmbTipCli 
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
               TabIndex        =   13
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
               TabIndex        =   12
               Top             =   825
               Width           =   5205
            End
            Begin VB.ComboBox cmbEstados 
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
               Left            =   1080
               Style           =   2  'Dropdown List
               TabIndex        =   11
               Top             =   1170
               Width           =   2130
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
               TabIndex        =   18
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
               TabIndex        =   17
               Top             =   150
               Width           =   3780
            End
            Begin VB.Label Label1 
               Caption         =   "Tipo"
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
               TabIndex        =   16
               Top             =   525
               Width           =   780
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "Operación"
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
               TabIndex        =   15
               Top             =   870
               Width           =   840
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "Estados"
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
               Index           =   3
               Left            =   75
               TabIndex        =   14
               Top             =   1215
               Width           =   660
            End
         End
         Begin VB.Label lblCaption 
            BackColor       =   &H80000002&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "   Filtro de Operaciones-"
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
            TabIndex        =   19
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
         Left            =   3390
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   870
         Visible         =   0   'False
         Width           =   765
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
         Width           =   14730
         _ExtentX        =   25982
         _ExtentY        =   6376
         _Version        =   393216
         Rows            =   3
         Cols            =   18
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
Attribute VB_Name = "FRM_MNT_Confirmacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim SistemaOrigen As String
Dim RutCliente    As Long
Dim CodCliente    As Long
Dim Tipcliente    As Long
Dim TipOperacion  As String
Dim EstadoConfir  As String
Dim Numoper       As Long

Enum objMostar
   [Agrupado] = -1
   [Degregado] = 0
End Enum
Dim Mostrar       As objMostar

Private Sub CargaTipoOperacion(MiObjeto As ComboBox)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, SistemaOrigen
   If Not Bac_Sql_Execute("bacparamsuda..SP_CARGA_TIP_OPERACION", Envia) Then
      Exit Sub
   End If
   MiObjeto.Clear
   MiObjeto.AddItem "  "
   Do While Bac_SQL_Fetch(Datos())
      MiObjeto.AddItem Datos(1) & " - " & Datos(2)
   Loop
   
End Sub


Private Sub CargaraDatos()
   On Error GoTo ErrorCarga
   Dim Datos()
   
   Grid.Redraw = False
   
   Envia = Array()
   AddParam Envia, SistemaOrigen
   AddParam Envia, RutCliente
   AddParam Envia, CodCliente
   AddParam Envia, Tipcliente
   AddParam Envia, TipOperacion
   AddParam Envia, EstadoConfir
   AddParam Envia, Mostrar
   AddParam Envia, Numoper
   If Not Bac_Sql_Execute("bacparamsuda..SP_CONFIRMACION_OPERACIONES", Envia) Then
      GoTo ErrorCarga
   End If
   Grid.Rows = 2
   Do While Bac_SQL_Fetch(Datos())
      Grid.Rows = Grid.Rows + 1
      
      Grid.TextMatrix(Grid.Rows - 1, 0) = Space(15) & Datos(1)
      Grid.Col = 0
      Grid.Row = (Grid.Rows - 1)
      
      If Datos(1) = "SI" Then
         Set Grid.CellPicture = Me.ConCheck(0).Image
      Else
         Set Grid.CellPicture = Me.SinCheck(0).Image
      End If
      
      Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(2)
      Grid.TextMatrix(Grid.Rows - 1, 2) = Format(Datos(3), "#,##0")
      Grid.TextMatrix(Grid.Rows - 1, 3) = Format(Datos(4), "#,##0")
      Grid.TextMatrix(Grid.Rows - 1, 4) = Format(Datos(5), "#,##0")
      Grid.TextMatrix(Grid.Rows - 1, 5) = Format(Mid(Datos(6), 1, InStr(1, Datos(6), "-") - 1), "#,##0") & Mid(Datos(6), InStr(1, Datos(6), "-"))
      Grid.TextMatrix(Grid.Rows - 1, 6) = Datos(7)
      Grid.TextMatrix(Grid.Rows - 1, 7) = Datos(8)
      Grid.TextMatrix(Grid.Rows - 1, 8) = Format(Datos(9), "#,##0.0000")
      Grid.TextMatrix(Grid.Rows - 1, 9) = Format(Datos(10), "#,##0")
      Grid.TextMatrix(Grid.Rows - 1, 10) = Format(Datos(11), "#,##0.0000")
      Grid.TextMatrix(Grid.Rows - 1, 11) = Format(Datos(12), "#,##0")
      Grid.TextMatrix(Grid.Rows - 1, 12) = Datos(13)
      Grid.TextMatrix(Grid.Rows - 1, 13) = Datos(14)
      Grid.TextMatrix(Grid.Rows - 1, 14) = Datos(15)
      Grid.TextMatrix(Grid.Rows - 1, 15) = Datos(16)
      Grid.TextMatrix(Grid.Rows - 1, 16) = Datos(17)
      Grid.TextMatrix(Grid.Rows - 1, 17) = Datos(18)
      Grid.TextMatrix(Grid.Rows - 1, 18) = Datos(19)
      
      '-- Uso interno no Ocupar --'
      Grid.TextMatrix(Grid.Rows - 1, Grid.Cols - 1) = ""
      '-- ===================== --'
   Loop
   Grid.Redraw = True
Exit Sub
ErrorCarga:
   Grid.Redraw = True
   MsgBox "Problemas en la carga de información...", vbExclamation, TITSISTEMA
End Sub

Private Sub NombresGrid()
   Grid.Rows = 3:  Grid.FixedRows = 2
   Grid.Cols = 20: Grid.FixedCols = 0
   
   Grid.TextMatrix(0, 0) = "Estado":        Grid.TextMatrix(1, 0) = "Confirmación":  Grid.ColWidth(0) = 1200:   Grid.ColAlignment(0) = flexAlignLeftCenter
   Grid.TextMatrix(0, 1) = "Tipo":          Grid.TextMatrix(1, 1) = "Operación":     Grid.ColWidth(1) = 2200:   Grid.ColAlignment(1) = flexAlignLeftCenter
   Grid.TextMatrix(0, 2) = "Número":        Grid.TextMatrix(1, 2) = "Operación":     Grid.ColWidth(2) = 1500:   Grid.ColAlignment(2) = flexAlignRightCenter
   Grid.TextMatrix(0, 3) = "Número":        Grid.TextMatrix(1, 3) = "Documento":     Grid.ColWidth(3) = 1500:   Grid.ColAlignment(3) = flexAlignRightCenter
   Grid.TextMatrix(0, 4) = "Número":        Grid.TextMatrix(1, 4) = "Correlativo":   Grid.ColWidth(4) = 1000:   Grid.ColAlignment(4) = flexAlignRightCenter
   Grid.TextMatrix(0, 5) = "Datos":         Grid.TextMatrix(1, 5) = "Cliente":       Grid.ColWidth(5) = 3500:   Grid.ColAlignment(5) = flexAlignLeftCenter
   Grid.TextMatrix(0, 6) = "Moneda":        Grid.TextMatrix(1, 6) = "":              Grid.ColWidth(6) = 1200:   Grid.ColAlignment(6) = flexAlignLeftCenter
   Grid.TextMatrix(0, 7) = "Serie":         Grid.TextMatrix(1, 7) = "Instrumento":   Grid.ColWidth(7) = 3000:   Grid.ColAlignment(7) = flexAlignLeftCenter
   Grid.TextMatrix(0, 8) = "Valor":         Grid.TextMatrix(1, 8) = "Moninal":       Grid.ColWidth(8) = 1500:   Grid.ColAlignment(8) = flexAlignRightCenter
   Grid.TextMatrix(0, 9) = "Valor":         Grid.TextMatrix(1, 9) = "Inicia":        Grid.ColWidth(9) = 1500:   Grid.ColAlignment(9) = flexAlignRightCenter
  Grid.TextMatrix(0, 10) = "Tir":          Grid.TextMatrix(1, 10) = "":             Grid.ColWidth(10) = 1500:  Grid.ColAlignment(10) = flexAlignRightCenter
  Grid.TextMatrix(0, 11) = "Valor":        Grid.TextMatrix(1, 11) = "Final":        Grid.ColWidth(11) = 1500:  Grid.ColAlignment(11) = flexAlignRightCenter
  Grid.TextMatrix(0, 12) = "Forma Pago":   Grid.TextMatrix(1, 12) = "Inicial":      Grid.ColWidth(12) = 2000:  Grid.ColAlignment(12) = flexAlignLeftCenter
  Grid.TextMatrix(0, 13) = "Forma Pago":   Grid.TextMatrix(1, 13) = "Final":        Grid.ColWidth(13) = 2000:  Grid.ColAlignment(13) = flexAlignLeftCenter
  Grid.TextMatrix(0, 14) = "Hora":         Grid.TextMatrix(1, 14) = "Confirmación": Grid.ColWidth(14) = 2000:  Grid.ColAlignment(14) = flexAlignLeftCenter
  Grid.TextMatrix(0, 15) = "Operador":     Grid.TextMatrix(1, 15) = "Confirmante":  Grid.ColWidth(15) = 2000:  Grid.ColAlignment(15) = flexAlignLeftCenter
  Grid.TextMatrix(0, 16) = "Contraparte":  Grid.TextMatrix(1, 16) = "Confirmante":  Grid.ColWidth(16) = 2000:  Grid.ColAlignment(16) = flexAlignLeftCenter
  Grid.TextMatrix(0, 17) = "Código":       Grid.TextMatrix(1, 17) = "Discrepancia": Grid.ColWidth(17) = 2000:  Grid.ColAlignment(17) = flexAlignLeftCenter
  Grid.TextMatrix(0, 18) = "Glosa":        Grid.TextMatrix(1, 18) = "Discrepancia": Grid.ColWidth(18) = 2000:  Grid.ColAlignment(18) = flexAlignLeftCenter
    
   Grid.TextMatrix(0, Grid.Cols - 1) = "UsoInterno": Grid.TextMatrix(1, Grid.Cols - 1) = "NoOcupar":  Grid.ColWidth(Grid.Cols - 1) = 0: Grid.ColAlignment(Grid.Cols - 1) = flexAlignLeftCenter
   
   Grid.RowHeightMin = 315
End Sub

Private Sub cmbSiNo_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Space(15) & cmbSiNo.Text
      Grid.Enabled = True
      cmbSiNo.Visible = False
      Grid.SetFocus
   End If
   If KeyCode = vbKeyEscape Then
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

Private Sub Form_Load()
   Me.Icon = BacTrader.Icon
   Me.Top = 0: Me.Left = 0
   
   SistemaOrigen = "BTR"
   RutCliente = 0
   CodCliente = 0
   Tipcliente = 0
   TipOperacion = ""
   EstadoConfir = "N"
   Mostrar = Agrupado
   Numoper = 0
   
   cmbSiNo.AddItem "SI"
   cmbSiNo.AddItem "NO"
   
   Call CargaTipoOperacion(cmbTipOper)
   
   cmbEstados.AddItem " "
   cmbEstados.AddItem "CONFIRMADAS"
   cmbEstados.AddItem "NO CONFIRMADAS"
   
   Call CargaTipoCliente
   Call NombresGrid
   
   Call CargaraDatos
   
End Sub

Private Sub CargaTipoCliente()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(72)
   If Not Bac_Sql_Execute("BacParamSuda..SP_LEERCODIGOS", Envia) Then
      MsgBox "Probelmas en la carga de Tipos de Cliente", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   cmbTipCli.Clear
   cmbTipCli.AddItem " "
   cmbTipCli.ItemData(cmbTipCli.NewIndex) = 0
   Do While Bac_SQL_Fetch(Datos())
      cmbTipCli.AddItem UCase(Datos(6))
      cmbTipCli.ItemData(cmbTipCli.NewIndex) = CDbl(Datos(2))
   Loop
   
End Sub

Private Sub Form_Resize()
   On Error Resume Next
   FraCuadro.Width = (Me.Width - 150)
   FraCuadro.Height = (Me.Height - 850)
   
   Grid.Width = (FraCuadro.Width - 100)
   Grid.Height = (FraCuadro.Height - 200)
   On Error GoTo 0
End Sub


Private Sub Grid_DblClick()
   On Error Resume Next
   If Grid.ColSel = 0 Then
      If Trim(Grid.TextMatrix(Grid.RowSel, Grid.ColSel)) = "SI" Then
         Set Grid.CellPicture = Me.SinCheck(0).Image
         Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Space(15) & "NO"
      Else
         Set Grid.CellPicture = Me.ConCheck(0).Image
         Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Space(15) & "SI"
      End If
      'cmbSiNo.Text = Trim(Grid.TextMatrix(Grid.RowSel, Grid.ColSel))
      'cmbSiNo.Left = (Grid.CellLeft + 550)
      'cmbSiNo.Top = (Grid.CellTop + 150)
      'cmbSiNo.Width = (Grid.CellWidth - 490)
      'cmbSiNo.Enabled = True
      'cmbSiNo.Visible = True
      'cmbSiNo.SetFocus
      'Grid.Enabled = False
   Else
      BacAyuda.Tag = "DESCREP"
      BacAyuda.Show 1
      If giAceptar% Then
         Grid.TextMatrix(Grid.RowSel, 14) = Format(Time, "hh:mm:ss")
         Grid.TextMatrix(Grid.RowSel, 15) = gsBac_User
         Grid.TextMatrix(Grid.RowSel, 17) = Val(gscodigo$)
         Grid.TextMatrix(Grid.RowSel, 18) = gsDescripcion$
         If Val(gscodigo$) = 0 Or gsDescripcion$ Like "*OTRA*" Then
            Grid.Row = Grid.RowSel
            Grid.Col = 18
            txtDescripcion.Text = gsDescripcion$
            txtDescripcion.Left = (Grid.CellLeft + 40)
            txtDescripcion.Top = (Grid.CellTop + 150)
            txtDescripcion.Height = (Grid.CellHeight - 10)
            txtDescripcion.Width = (Grid.CellWidth + 10)
            txtDescripcion.MaxLength = 100
            txtDescripcion.Visible = True
            txtDescripcion.SetFocus
            Grid.Enabled = False
         End If
      End If
   End If
   On Error GoTo 0
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   On Error Resume Next
   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 0 Then
         cmbSiNo.Text = Trim(Grid.TextMatrix(Grid.RowSel, Grid.ColSel))
         cmbSiNo.Left = (Grid.CellLeft + 550)
         cmbSiNo.Top = (Grid.CellTop + 150)
         cmbSiNo.Width = (Grid.CellWidth - 490)
         cmbSiNo.Enabled = True
         cmbSiNo.Visible = True
         cmbSiNo.SetFocus
         Grid.Enabled = False
      End If
      If Grid.ColSel = 16 Then
         txtDescripcion.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         txtDescripcion.Left = (Grid.CellLeft + 40)
         txtDescripcion.Top = (Grid.CellTop + 150)
         txtDescripcion.Height = (Grid.CellHeight - 10)
         txtDescripcion.Width = (Grid.CellWidth + 10)
         txtDescripcion.MaxLength = 100
         txtDescripcion.Visible = True
         txtDescripcion.SetFocus
         Grid.Enabled = False
      End If
   End If
   On Error GoTo 0
End Sub

Private Sub Image1_Click()

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call GrabarConfirmación
      Case 2
         Call CargaraDatos
      Case 3
         pnlFiltro.Visible = True
         Grid.Enabled = False
      Case 4
         Unload Me
      
      Case 6
         Toolbar1.Buttons(6).Visible = False
         Toolbar1.Buttons(7).Visible = True
         Mostrar = Degregado
         
         If Grid.TextMatrix(Grid.RowSel, 2) = "" Then
            Numoper = 0
         Else
            Numoper = CDbl(Grid.TextMatrix(Grid.RowSel, 2))
         End If

         Call CargaraDatos
      Case 7
         Toolbar1.Buttons(6).Visible = True
         Toolbar1.Buttons(7).Visible = False
         Mostrar = Agrupado
         
         If Grid.TextMatrix(Grid.RowSel, 2) = "" Then
            Numoper = 0
         Else
            Numoper = CDbl(Grid.TextMatrix(Grid.RowSel, 2))
         End If
         Numoper = 0
         Call CargaraDatos
   End Select
End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         RutCliente = Val(txtRutCliente.Text)
         CodCliente = Val(txtRutCliente.Tag)
         If cmbTipCli.ListIndex = -1 Then
            Tipcliente = 0
         Else
            Tipcliente = cmbTipCli.ItemData(cmbTipCli.ListIndex)
         End If
         If cmbTipOper.ListIndex = -1 Or Trim(cmbTipOper.Text) = "" Then
            TipOperacion = ""
         Else
            TipOperacion = Trim(Mid(cmbTipOper.Text, 1, InStr(1, cmbTipOper.Text, "-") - 1))
         End If
         If cmbEstados.Text = "CONFIRMADAS" Then
            EstadoConfir = "S"
         ElseIf cmbEstados.Text = "NO CONFIRMADAS" Then
            EstadoConfir = "N"
         Else
            EstadoConfir = " "
         End If
         Numoper = 0
         Mostrar = Agrupado
   End Select
   
   pnlFiltro.Visible = False
   Grid.Enabled = True
   
   Call CargaraDatos
End Sub

Private Sub txtDescripcion_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Trim(txtDescripcion.Text)
      Grid.Enabled = True
      txtDescripcion.Visible = False
      Grid.SetFocus
   End If
   If KeyCode = vbKeyEscape Then
      Grid.Enabled = True
      txtDescripcion.Visible = False
      Grid.SetFocus
   End If
End Sub

Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub GrabarConfirmación()
   On Error GoTo ErrorConfirmacion
   Dim Datos()
   Dim iContador  As Long
   Dim iMensaje   As String
   
   Envia = Array()
   AddParam Envia, "B"
   Call Bac_Sql_Execute("bacparamsuda..SP_GRABACION_CONFIRMACIONES", Envia)
   
   iMensaje = ""
   For iContador = 2 To Grid.Rows - 1
     ' If Right(Grid.TextMatrix(iContador, 0), 2) = "SI" Then
         If ValidaInformación(iContador, iMensaje) = True Then
            Envia = Array()
            AddParam Envia, SistemaOrigen                              'Sistema
            AddParam Envia, CDbl(Grid.TextMatrix(iContador, 2))        'NumeroOperacin
            AddParam Envia, CDbl(Grid.TextMatrix(iContador, 3))        'NumeroDocumento
            AddParam Envia, CDbl(Grid.TextMatrix(iContador, 4))        'NumeroCorrelativo
            AddParam Envia, CStr(Trim(Grid.TextMatrix(iContador, 0)))  'Confirmacion
            AddParam Envia, CDbl(Grid.TextMatrix(iContador, 17))       'Codigo
            AddParam Envia, CStr(Grid.TextMatrix(iContador, 18))       'Glosa
            AddParam Envia, CStr(Grid.TextMatrix(iContador, 14))       'Hora
            AddParam Envia, CStr(Grid.TextMatrix(iContador, 15))       'Usuario
            AddParam Envia, CStr(Grid.TextMatrix(iContador, 16))       'Usuario Contraparte
            AddParam Envia, " "                                        'Indicador Transacciones
            If Not Bac_Sql_Execute("bacparamsuda..SP_GRABACION_CONFIRMACIONES", Envia) Then
               GoTo ErrorConfirmacion
            End If
         End If
     ' End If
   Next iContador

   Envia = Array()
   AddParam Envia, "C"
   Call Bac_Sql_Execute("bacparamsuda..SP_GRABACION_CONFIRMACIONES", Envia)

   If Len(iMensaje) = 0 Then
      MsgBox "¡ Confirmación realizada con exito. !", vbInformation, TITSISTEMA
   Else
      MsgBox "¡ Algunas operaciones no fueron confirmadas debido a :" & vbCrLf & vbCrLf & iMensaje & " !", vbExclamation, TITSISTEMA
   End If
   
   On Error GoTo 0
Exit Sub
ErrorConfirmacion:
   Envia = Array()
   AddParam Envia, "R"
   Call Bac_Sql_Execute("bacparamsuda..SP_GRABACION_CONFIRMACIONES", Envia)

   MsgBox "¡ Problemas al tratar de grabar la información de confirmación. !", vbExclamation, TITSISTEMA
End Sub

Private Function ValidaInformación(ByVal iFila As Long, ByRef xMensaje As Variant) As Boolean
   Dim iGlosa  As String
   
   ValidaInformación = False
   
   If Trim(Grid.TextMatrix(iFila, 0)) = "NO" Then
      ValidaInformación = True
      Exit Function
   End If
   
   
   iGlosa = ""
   If Val(Grid.TextMatrix(iFila, 17)) = 0 Or Trim(Grid.TextMatrix(iFila, 18)) = "-" And Not Trim(Grid.TextMatrix(iFila, 18)) Like "*OTRA*" Then
      iGlosa = iGlosa & vbCrLf & " - Discrepancia no definida."
   End If
   If Trim(Grid.TextMatrix(iFila, 16)) = "-" Or Len(Trim(Grid.TextMatrix(iFila, 16))) = 0 Then
      iGlosa = iGlosa & vbCrLf & " - Usuario Contraparte no definido."
   End If
   
   If Len(iGlosa) = 0 Then
      ValidaInformación = True
   Else
      xMensaje = xMensaje & "Operación: " & CStr(Grid.TextMatrix(iFila, 3)) & " " & iGlosa
   End If
End Function

Private Sub txtRutCliente_DblClick()
   
   BacAyuda.Tag = "MDCL"
   BacAyuda.Show 1
   If giAceptar% Then
      txtRutCliente.Text = Val(gscodigo$)
      txtNomCliente.Tag = gsDigito$
      txtNomCliente.Caption = gsDescripcion$
      txtRutCliente.Tag = gsvalor
   End If
End Sub

Private Sub txtRutCliente_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyDelete Then
      txtRutCliente.Text = 0
      txtRutCliente.Tag = ""
      txtNomCliente.Caption = ""
      txtNomCliente.Tag = 0
   End If
   If KeyCode = vbKeyF1 Or KeyCode = vbKeyF3 Then
      Call txtRutCliente_DblClick
   End If
End Sub
