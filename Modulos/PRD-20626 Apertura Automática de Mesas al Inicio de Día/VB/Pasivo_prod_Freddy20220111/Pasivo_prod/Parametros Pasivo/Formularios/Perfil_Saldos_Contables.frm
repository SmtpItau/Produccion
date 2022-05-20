VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form Perfil_Saldos_Contables 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Perfiles Saldos Contables"
   ClientHeight    =   6330
   ClientLeft      =   2160
   ClientTop       =   1980
   ClientWidth     =   11010
   Icon            =   "Perfil_Saldos_Contables.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6330
   ScaleWidth      =   11010
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   1995
      Top             =   5580
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   18
      ImageHeight     =   18
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Saldos_Contables.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Saldos_Contables.frx":0474
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Saldos_Contables.frx":05DE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4710
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Saldos_Contables.frx":0A30
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Saldos_Contables.frx":190A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Saldos_Contables.frx":27E4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Saldos_Contables.frx":36BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Saldos_Contables.frx":4598
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Saldos_Contables.frx":5472
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Saldos_Contables.frx":634C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   5805
      Left            =   15
      TabIndex        =   0
      Top             =   495
      Width           =   10965
      _Version        =   65536
      _ExtentX        =   19341
      _ExtentY        =   10239
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   1
      Begin Threed.SSPanel SSPanelFiltro 
         Height          =   2190
         Left            =   270
         TabIndex        =   60
         Top             =   1665
         Visible         =   0   'False
         Width           =   10440
         _Version        =   65536
         _ExtentX        =   18415
         _ExtentY        =   3863
         _StockProps     =   15
         Caption         =   ">"
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   2
         Begin MSComctlLib.Toolbar Toolbar7 
            Height          =   480
            Left            =   45
            TabIndex        =   76
            Top             =   345
            Width           =   10350
            _ExtentX        =   18256
            _ExtentY        =   847
            ButtonWidth     =   820
            ButtonHeight    =   794
            AllowCustomize  =   0   'False
            Appearance      =   1
            Style           =   1
            ImageList       =   "ImageList3"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   3
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Limpiar"
                  ImageIndex      =   1
               EndProperty
               BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Imprimir"
                  ImageIndex      =   2
               EndProperty
               BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Cerrar Ventana"
                  ImageIndex      =   3
               EndProperty
            EndProperty
            BorderStyle     =   1
         End
         Begin Threed.SSPanel SSPanel9 
            Height          =   315
            Left            =   30
            TabIndex        =   61
            Top             =   30
            Width           =   10365
            _Version        =   65536
            _ExtentX        =   18283
            _ExtentY        =   556
            _StockProps     =   15
            Caption         =   " Filtro de Perfiles"
            ForeColor       =   -2147483639
            BackColor       =   -2147483646
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
            Alignment       =   1
         End
         Begin Threed.SSPanel SSPanel10 
            Height          =   1320
            Left            =   30
            TabIndex        =   62
            Top             =   825
            Width           =   10365
            _Version        =   65536
            _ExtentX        =   18283
            _ExtentY        =   2328
            _StockProps     =   15
            BackColor       =   -2147483644
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
            Begin Threed.SSFrame SSFrame2 
               Height          =   1305
               Left            =   30
               TabIndex        =   63
               Top             =   -30
               Width           =   10290
               _Version        =   65536
               _ExtentX        =   18150
               _ExtentY        =   2302
               _StockProps     =   14
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Begin VB.ComboBox CmbMoneda2_F 
                  Enabled         =   0   'False
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
                  Left            =   6585
                  Style           =   2  'Dropdown List
                  TabIndex        =   69
                  Top             =   810
                  Width           =   3660
               End
               Begin VB.ComboBox CmbEvento_F 
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
                  Left            =   6585
                  Style           =   2  'Dropdown List
                  TabIndex        =   68
                  Top             =   150
                  Width           =   2355
               End
               Begin VB.ComboBox CmbTipoOperacion_F 
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
                  Left            =   1395
                  Style           =   2  'Dropdown List
                  TabIndex        =   67
                  Top             =   495
                  Width           =   3660
               End
               Begin VB.ComboBox CmbInstrumento_F 
                  Enabled         =   0   'False
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
                  Left            =   6585
                  Style           =   2  'Dropdown List
                  TabIndex        =   66
                  Top             =   480
                  Width           =   3660
               End
               Begin VB.ComboBox CmbMoneda1_F 
                  Enabled         =   0   'False
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
                  Left            =   1395
                  Style           =   2  'Dropdown List
                  TabIndex        =   65
                  Top             =   825
                  Width           =   3660
               End
               Begin VB.ComboBox CmbSistema_F 
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
                  Left            =   1395
                  Style           =   2  'Dropdown List
                  TabIndex        =   64
                  Top             =   165
                  Width           =   2175
               End
               Begin MSComctlLib.ImageList ImageList3 
                  Left            =   0
                  Top             =   0
                  _ExtentX        =   1005
                  _ExtentY        =   1005
                  BackColor       =   -2147483643
                  ImageWidth      =   24
                  ImageHeight     =   24
                  MaskColor       =   12632256
                  _Version        =   393216
                  BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
                     NumListImages   =   3
                     BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                        Picture         =   "Perfil_Saldos_Contables.frx":6666
                        Key             =   ""
                     EndProperty
                     BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                        Picture         =   "Perfil_Saldos_Contables.frx":7540
                        Key             =   ""
                     EndProperty
                     BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                        Picture         =   "Perfil_Saldos_Contables.frx":841A
                        Key             =   ""
                     EndProperty
                  EndProperty
               End
               Begin VB.Label Label2 
                  AutoSize        =   -1  'True
                  Caption         =   "Moneda 2"
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  ForeColor       =   &H80000007&
                  Height          =   210
                  Index           =   20
                  Left            =   5100
                  TabIndex        =   75
                  Top             =   840
                  Width           =   795
               End
               Begin VB.Label Label2 
                  AutoSize        =   -1  'True
                  Caption         =   "Tipo Evento"
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  ForeColor       =   &H80000007&
                  Height          =   210
                  Index           =   19
                  Left            =   5070
                  TabIndex        =   74
                  Top             =   225
                  Width           =   960
               End
               Begin VB.Label Label2 
                  AutoSize        =   -1  'True
                  Caption         =   "Tipo Operacion"
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  ForeColor       =   &H80000007&
                  Height          =   210
                  Index           =   18
                  Left            =   60
                  TabIndex        =   73
                  Top             =   540
                  Width           =   1245
               End
               Begin VB.Label Label2 
                  AutoSize        =   -1  'True
                  Caption         =   "Instrum./Moneda"
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  ForeColor       =   &H80000007&
                  Height          =   210
                  Index           =   17
                  Left            =   5100
                  TabIndex        =   72
                  Top             =   540
                  Width           =   1410
               End
               Begin VB.Label Label2 
                  AutoSize        =   -1  'True
                  Caption         =   "Moneda 1"
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  ForeColor       =   &H80000007&
                  Height          =   210
                  Index           =   16
                  Left            =   90
                  TabIndex        =   71
                  Top             =   855
                  Width           =   795
               End
               Begin VB.Label Label5 
                  AutoSize        =   -1  'True
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
                  ForeColor       =   &H80000007&
                  Height          =   210
                  Left            =   60
                  TabIndex        =   70
                  Top             =   225
                  Width           =   675
               End
            End
         End
      End
      Begin Threed.SSPanel SSPanel5 
         Height          =   2850
         Left            =   360
         TabIndex        =   39
         Top             =   540
         Visible         =   0   'False
         Width           =   10275
         _Version        =   65536
         _ExtentX        =   18124
         _ExtentY        =   5027
         _StockProps     =   15
         Caption         =   ">"
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
         BevelWidth      =   2
         Begin Threed.SSPanel SSPanel7 
            Height          =   315
            Left            =   30
            TabIndex        =   42
            Top             =   30
            Width           =   10215
            _Version        =   65536
            _ExtentX        =   18018
            _ExtentY        =   556
            _StockProps     =   15
            Caption         =   " Copia de Perfiles"
            ForeColor       =   -2147483639
            BackColor       =   -2147483646
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   0
            Alignment       =   1
         End
         Begin MSComctlLib.Toolbar Toolbar6 
            Height          =   450
            Left            =   45
            TabIndex        =   41
            Top             =   360
            Width           =   10200
            _ExtentX        =   17992
            _ExtentY        =   794
            ButtonWidth     =   820
            ButtonHeight    =   794
            Appearance      =   1
            Style           =   1
            ImageList       =   "ImageList4"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   2
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Aceptar"
                  ImageIndex      =   1
               EndProperty
               BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Cancelar"
                  ImageIndex      =   2
               EndProperty
            EndProperty
         End
         Begin Threed.SSPanel SSPanel6 
            Height          =   1995
            Left            =   30
            TabIndex        =   40
            Top             =   825
            Width           =   10185
            _Version        =   65536
            _ExtentX        =   17965
            _ExtentY        =   3519
            _StockProps     =   15
            BackColor       =   -2147483644
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
            Begin Threed.SSFrame SSFrame1 
               Height          =   1935
               Left            =   30
               TabIndex        =   43
               Top             =   -30
               Width           =   10095
               _Version        =   65536
               _ExtentX        =   17806
               _ExtentY        =   3413
               _StockProps     =   14
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Begin MSComctlLib.ImageList ImageList4 
                  Left            =   300
                  Top             =   690
                  _ExtentX        =   1005
                  _ExtentY        =   1005
                  BackColor       =   -2147483643
                  ImageWidth      =   24
                  ImageHeight     =   24
                  MaskColor       =   12632256
                  _Version        =   393216
                  BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
                     NumListImages   =   2
                     BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                        Picture         =   "Perfil_Saldos_Contables.frx":8734
                        Key             =   ""
                     EndProperty
                     BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                        Picture         =   "Perfil_Saldos_Contables.frx":960E
                        Key             =   ""
                     EndProperty
                  EndProperty
               End
               Begin VB.ComboBox CmbSistema_C 
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
                  Left            =   1395
                  Style           =   2  'Dropdown List
                  TabIndex        =   51
                  Top             =   165
                  Width           =   2175
               End
               Begin VB.TextBox TxtGlosa_C 
                  Enabled         =   0   'False
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
                  Left            =   1395
                  TabIndex        =   50
                  Top             =   1485
                  Width           =   8625
               End
               Begin VB.ComboBox CmbTipoVoucher_C 
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
                  ItemData        =   "Perfil_Saldos_Contables.frx":9928
                  Left            =   6585
                  List            =   "Perfil_Saldos_Contables.frx":992A
                  Style           =   2  'Dropdown List
                  TabIndex        =   49
                  Top             =   810
                  Visible         =   0   'False
                  Width           =   2355
               End
               Begin VB.ComboBox CmbMoneda1_C 
                  Enabled         =   0   'False
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
                  Left            =   1395
                  Style           =   2  'Dropdown List
                  TabIndex        =   48
                  Top             =   825
                  Width           =   3660
               End
               Begin VB.ComboBox CmbInstrumento_C 
                  Enabled         =   0   'False
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
                  Left            =   6585
                  Style           =   2  'Dropdown List
                  TabIndex        =   47
                  Top             =   480
                  Width           =   3450
               End
               Begin VB.ComboBox CmbTipoOperacion_C 
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
                  Left            =   1395
                  Style           =   2  'Dropdown List
                  TabIndex        =   46
                  Top             =   495
                  Width           =   3660
               End
               Begin VB.ComboBox CmbEvento_C 
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
                  Left            =   6585
                  Style           =   2  'Dropdown List
                  TabIndex        =   45
                  Top             =   150
                  Width           =   2355
               End
               Begin VB.ComboBox CmbMoneda2_C 
                  Enabled         =   0   'False
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
                  Left            =   1395
                  Style           =   2  'Dropdown List
                  TabIndex        =   44
                  Top             =   1155
                  Width           =   3660
               End
               Begin VB.Label Label3 
                  AutoSize        =   -1  'True
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
                  ForeColor       =   &H80000007&
                  Height          =   210
                  Left            =   60
                  TabIndex        =   59
                  Top             =   225
                  Width           =   675
               End
               Begin VB.Label Label2 
                  AutoSize        =   -1  'True
                  Caption         =   "Tipo Voucher"
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  ForeColor       =   &H80000007&
                  Height          =   210
                  Index           =   13
                  Left            =   5100
                  TabIndex        =   58
                  Top             =   855
                  Visible         =   0   'False
                  Width           =   1110
               End
               Begin VB.Label Label2 
                  AutoSize        =   -1  'True
                  Caption         =   "Glosa Voucher"
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  ForeColor       =   &H80000007&
                  Height          =   210
                  Index           =   12
                  Left            =   90
                  TabIndex        =   57
                  Top             =   1530
                  Width           =   1215
               End
               Begin VB.Label Label2 
                  AutoSize        =   -1  'True
                  Caption         =   "Moneda 1"
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  ForeColor       =   &H80000007&
                  Height          =   210
                  Index           =   11
                  Left            =   90
                  TabIndex        =   56
                  Top             =   855
                  Width           =   795
               End
               Begin VB.Label Label2 
                  AutoSize        =   -1  'True
                  Caption         =   "Instrum./Moneda"
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  ForeColor       =   &H80000007&
                  Height          =   210
                  Index           =   10
                  Left            =   5100
                  TabIndex        =   55
                  Top             =   540
                  Width           =   1410
               End
               Begin VB.Label Label2 
                  AutoSize        =   -1  'True
                  Caption         =   "Tipo Operacion"
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  ForeColor       =   &H80000007&
                  Height          =   210
                  Index           =   9
                  Left            =   60
                  TabIndex        =   54
                  Top             =   540
                  Width           =   1245
               End
               Begin VB.Label Label2 
                  AutoSize        =   -1  'True
                  Caption         =   "Tipo Evento"
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  ForeColor       =   &H80000007&
                  Height          =   210
                  Index           =   8
                  Left            =   5070
                  TabIndex        =   53
                  Top             =   165
                  Width           =   960
               End
               Begin VB.Label Label2 
                  AutoSize        =   -1  'True
                  Caption         =   "Moneda 2"
                  BeginProperty Font 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  ForeColor       =   &H80000007&
                  Height          =   210
                  Index           =   7
                  Left            =   105
                  TabIndex        =   52
                  Top             =   1185
                  Width           =   795
               End
            End
         End
      End
      Begin Threed.SSPanel SSPanel2 
         Height          =   3885
         Left            =   1530
         TabIndex        =   26
         Top             =   930
         Width           =   7980
         _Version        =   65536
         _ExtentX        =   14076
         _ExtentY        =   6853
         _StockProps     =   15
         BackColor       =   -2147483644
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   2
         Begin Threed.SSFrame Frm_perfil_PV 
            Height          =   3615
            Left            =   135
            TabIndex        =   27
            Top             =   135
            Width           =   7740
            _Version        =   65536
            _ExtentX        =   13652
            _ExtentY        =   6376
            _StockProps     =   14
            Caption         =   "Condiciones"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   3
            ShadowStyle     =   1
            Begin VB.TextBox Txt_ingreso_PV 
               BackColor       =   &H00800000&
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
               ForeColor       =   &H00FFFFFF&
               Height          =   285
               Left            =   2610
               TabIndex        =   29
               Text            =   "Text2"
               Top             =   1665
               Visible         =   0   'False
               Width           =   615
            End
            Begin VB.ComboBox Cmb_Condiciones 
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
               Left            =   1575
               Style           =   2  'Dropdown List
               TabIndex        =   28
               Top             =   300
               Width           =   5175
            End
            Begin MSFlexGridLib.MSFlexGrid Gr_perfil_PV 
               Height          =   2220
               Left            =   135
               TabIndex        =   30
               Top             =   765
               Width           =   7305
               _ExtentX        =   12885
               _ExtentY        =   3916
               _Version        =   393216
               FixedCols       =   0
               BackColor       =   -2147483644
               ForeColor       =   8388608
               BackColorFixed  =   8421376
               ForeColorFixed  =   16777215
               BackColorBkg    =   -2147483636
               GridLines       =   2
               GridLinesFixed  =   0
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
            Begin MSComctlLib.Toolbar Toolbar4 
               Height          =   600
               Left            =   4320
               TabIndex        =   31
               Top             =   120
               Visible         =   0   'False
               Width           =   3360
               _ExtentX        =   5927
               _ExtentY        =   1058
               ButtonWidth     =   609
               ButtonHeight    =   953
               Appearance      =   1
               _Version        =   393216
            End
            Begin MSComctlLib.Toolbar Toolbar3 
               Height          =   420
               Left            =   120
               TabIndex        =   32
               Top             =   3000
               Width           =   795
               _ExtentX        =   1402
               _ExtentY        =   741
               ButtonWidth     =   661
               ButtonHeight    =   635
               ImageList       =   "ImageList2"
               _Version        =   393216
               BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
                  NumButtons      =   2
                  BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     Object.ToolTipText     =   "Insertar Linea"
                     ImageIndex      =   1
                  EndProperty
                  BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     Object.ToolTipText     =   "Eliminar Linea"
                     ImageIndex      =   2
                  EndProperty
               EndProperty
            End
            Begin MSComctlLib.Toolbar Toolbar5 
               Height          =   450
               Left            =   6480
               TabIndex        =   33
               Top             =   3000
               Width           =   915
               _ExtentX        =   1614
               _ExtentY        =   794
               ButtonWidth     =   820
               ButtonHeight    =   794
               AllowCustomize  =   0   'False
               Wrappable       =   0   'False
               Style           =   1
               ImageList       =   "ImageList4"
               _Version        =   393216
               BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
                  NumButtons      =   2
                  BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     Object.ToolTipText     =   "Aceptar"
                     ImageIndex      =   1
                  EndProperty
                  BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                     Object.ToolTipText     =   "Cancelar"
                     ImageIndex      =   2
                  EndProperty
               EndProperty
            End
            Begin VB.Label Label4 
               AutoSize        =   -1  'True
               Caption         =   "Condición"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   210
               Left            =   375
               TabIndex        =   34
               Top             =   345
               Width           =   825
            End
         End
      End
      Begin VB.Frame Frm_Tipo_movimiento 
         Caption         =   "Tipo Movimiento/Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   2130
         Left            =   45
         TabIndex        =   5
         Top             =   30
         Width           =   10875
         Begin Threed.SSPanel SSPanel3 
            Height          =   240
            Left            =   150
            TabIndex        =   37
            Top             =   -30
            Width           =   2415
            _Version        =   65536
            _ExtentX        =   4260
            _ExtentY        =   423
            _StockProps     =   15
            Caption         =   "Tipo Movimiento/Operación"
            ForeColor       =   8388608
            BackColor       =   -2147483644
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
            Font3D          =   1
            Alignment       =   0
         End
         Begin VB.ComboBox CmbMoneda2 
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
            Left            =   1395
            Style           =   2  'Dropdown List
            TabIndex        =   35
            Top             =   1260
            Width           =   3660
         End
         Begin VB.ComboBox Cmb_Tipo_movimiento 
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
            Left            =   6570
            Style           =   2  'Dropdown List
            TabIndex        =   15
            Top             =   255
            Width           =   2355
         End
         Begin VB.ComboBox Cmb_Tipo_operacion 
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
            Left            =   1395
            Style           =   2  'Dropdown List
            TabIndex        =   14
            Top             =   600
            Width           =   3660
         End
         Begin VB.ComboBox Cmb_Tipo_Instrumento 
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
            Left            =   6570
            Style           =   2  'Dropdown List
            TabIndex        =   13
            Top             =   585
            Width           =   4005
         End
         Begin VB.ComboBox CmbMoneda1 
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
            Left            =   1395
            Style           =   2  'Dropdown List
            TabIndex        =   12
            Top             =   930
            Width           =   3660
         End
         Begin VB.ComboBox Cmb_Tipo_Voucher 
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
            ItemData        =   "Perfil_Saldos_Contables.frx":992C
            Left            =   6570
            List            =   "Perfil_Saldos_Contables.frx":992E
            Style           =   2  'Dropdown List
            TabIndex        =   11
            Top             =   915
            Visible         =   0   'False
            Width           =   2355
         End
         Begin VB.TextBox Txt_Glosa 
            Enabled         =   0   'False
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
            Left            =   1395
            TabIndex        =   10
            Text            =   "Text1"
            Top             =   1590
            Width           =   9165
         End
         Begin VB.CommandButton cmd_ayuda_perfil 
            Caption         =   "?"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   3465
            TabIndex        =   9
            Top             =   270
            Width           =   255
         End
         Begin VB.ComboBox Cmb_Sistema 
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
            Left            =   1395
            Style           =   2  'Dropdown List
            TabIndex        =   8
            Top             =   270
            Width           =   2070
         End
         Begin VB.ComboBox Cmb_Control_Instrumento 
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
            Left            =   8865
            Style           =   2  'Dropdown List
            TabIndex        =   7
            Top             =   390
            Visible         =   0   'False
            Width           =   585
         End
         Begin VB.ComboBox Cmb_Control_Moneda 
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
            ItemData        =   "Perfil_Saldos_Contables.frx":9930
            Left            =   9480
            List            =   "Perfil_Saldos_Contables.frx":9932
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   390
            Visible         =   0   'False
            Width           =   585
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Moneda 2"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   6
            Left            =   105
            TabIndex        =   36
            Top             =   1290
            Width           =   795
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Tipo Evento"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   0
            Left            =   5055
            TabIndex        =   23
            Top             =   300
            Width           =   960
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Tipo Operacion"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   1
            Left            =   60
            TabIndex        =   22
            Top             =   645
            Width           =   1245
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Instrum./Moneda"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   2
            Left            =   5085
            TabIndex        =   21
            Top             =   630
            Width           =   1410
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Moneda 1"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   3
            Left            =   90
            TabIndex        =   20
            Top             =   960
            Width           =   795
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Glosa Voucher"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   4
            Left            =   90
            TabIndex        =   19
            Top             =   1635
            Width           =   1215
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Tipo Voucher"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   5
            Left            =   5085
            TabIndex        =   18
            Top             =   960
            Visible         =   0   'False
            Width           =   1110
         End
         Begin VB.Label Lbl_existe_perfil 
            AutoSize        =   -1  'True
            Caption         =   "No existe perfil"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Left            =   3795
            TabIndex        =   17
            Top             =   300
            Visible         =   0   'False
            Width           =   1245
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
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
            ForeColor       =   &H80000007&
            Height          =   210
            Left            =   60
            TabIndex        =   16
            Top             =   330
            Width           =   675
         End
      End
      Begin VB.Frame Frm_Perfil 
         Caption         =   "Perfil Contable"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   3600
         Left            =   45
         TabIndex        =   1
         Top             =   2175
         Width           =   10890
         Begin MSComctlLib.Toolbar Toolbar2 
            Height          =   420
            Left            =   240
            TabIndex        =   25
            Top             =   3120
            Width           =   1185
            _ExtentX        =   2090
            _ExtentY        =   741
            ButtonWidth     =   661
            ButtonHeight    =   635
            ImageList       =   "ImageList2"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   3
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Agregar Linea"
                  ImageIndex      =   1
               EndProperty
               BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Eliminar Linea"
                  ImageIndex      =   2
               EndProperty
               BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Perfil Variable"
                  ImageIndex      =   3
               EndProperty
            EndProperty
         End
         Begin VB.TextBox Txt_ingreso_campos 
            BackColor       =   &H00800000&
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
            ForeColor       =   &H00FFFFFF&
            Height          =   285
            Left            =   1125
            TabIndex        =   2
            Text            =   "Text2"
            Top             =   1035
            Visible         =   0   'False
            Width           =   615
         End
         Begin MSFlexGridLib.MSFlexGrid Gr_perfil 
            Height          =   2850
            Left            =   45
            TabIndex        =   3
            Top             =   255
            Width           =   10785
            _ExtentX        =   19024
            _ExtentY        =   5027
            _Version        =   393216
            FixedCols       =   0
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorBkg    =   12632256
            GridLines       =   2
            GridLinesFixed  =   0
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
         Begin Threed.SSPanel SSPanel4 
            Height          =   240
            Left            =   90
            TabIndex        =   38
            Top             =   30
            Width           =   2415
            _Version        =   65536
            _ExtentX        =   4260
            _ExtentY        =   423
            _StockProps     =   15
            Caption         =   "Perfil Contable"
            ForeColor       =   -2147483641
            BackColor       =   -2147483644
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   0
            Font3D          =   1
            Alignment       =   0
         End
         Begin VB.Label Lbl_msg 
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
            Height          =   330
            Left            =   3570
            TabIndex        =   4
            Top             =   3120
            Width           =   7230
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   24
      Top             =   0
      Width           =   11010
      _ExtentX        =   19420
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Refrescar Datos"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Copiar"
            Object.ToolTipText     =   "Copiar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Reporte"
            Object.ToolTipText     =   "Reporte"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   7
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "Perfil_Saldos_Contables"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' Perfil Fijo
Const C_CAMPO = 0
Const C_DESC_CAMPO = 1
Const C_TIPO_MOV = 2
Const C_PERFIL_FIJO = 3
Const C_NCUENTA = 4
Const C_DESC_CUENTA = 5
Const C_CAMPO_VARIABLE = 6

' Perfil Variable
Const C2_VALOR = 0
Const C2_NCUENTA = 1
Const C2_DESC_CUENTA = 2
Const C2_CODIGO_CONDICION = 4
Const C2_CODIGO_VALOR = 5
Const C2_CODIGO = 0

Public Gr_Filas      As Single
Public Gr_Filas2     As Single
Public Filas         As Single
Public varpsSql      As String
Public Folio_Perfil  As Long
Public Folio_Perfil2 As Long

Dim OptLocal         As String
Dim Sql$
Dim i&

   
Dim varsSist         As String
Dim varsMov          As String
Dim varsOper         As String
Dim varsInstr        As String
Dim varsMone         As String
Dim cSql             As String
Dim varNumeros       As Integer
Dim varData()
Dim varsMone2        As String
Dim varsTipVoucher   As String

Sub Imprime()
        
    Call limpiar_cristal
           
    BAC_Parametros.BacParam.Destination = 0
    BAC_Parametros.BacParam.ReportFileName = gsRPT_Path & "Perfil Contable.rpt"
    Call PROC_ESTABLECE_UBICACION(BAC_Parametros.BacParam.RetrieveDataFiles, BAC_Parametros.BacParam)
    If Trim(right(Me.CmbSistema_F.Text, 3)) <> "" Then
      BAC_Parametros.BacParam.StoredProcParam(0) = Trim(right(Me.CmbSistema_F.Text, 3))
    Else
      BAC_Parametros.BacParam.StoredProcParam(0) = "X"
    End If
    
    If Trim(right(Me.CmbTipoOperacion_F.Text, 5)) <> "" Then
      BAC_Parametros.BacParam.StoredProcParam(1) = Trim(right(Me.CmbTipoOperacion_F.Text, 5))
    Else
      BAC_Parametros.BacParam.StoredProcParam(1) = "X"
    End If
    
    If Trim(right(Me.CmbEvento_F.Text, 5)) <> "" Then
      BAC_Parametros.BacParam.StoredProcParam(2) = Trim(right(Me.CmbEvento_F.Text, 5))
    Else
      BAC_Parametros.BacParam.StoredProcParam(2) = "X"
    End If
      
    If CmbMoneda1_F.ListIndex > -1 Then
        BAC_Parametros.BacParam.StoredProcParam(3) = CmbMoneda1_F.ItemData(CmbMoneda1_F.ListIndex)
    Else
        BAC_Parametros.BacParam.StoredProcParam(3) = 0
    End If
    If CmbMoneda2_F.ListIndex > -1 Then
        BAC_Parametros.BacParam.StoredProcParam(4) = CmbMoneda2_F.ItemData(CmbMoneda2_F.ListIndex)
    Else
        BAC_Parametros.BacParam.StoredProcParam(4) = 0
    End If
    
    If Trim(right(Me.CmbInstrumento_F.Text, 12)) <> "" Then
       BAC_Parametros.BacParam.StoredProcParam(5) = Trim(right(Me.CmbInstrumento_F.Text, 12))
    Else
      BAC_Parametros.BacParam.StoredProcParam(5) = "X"
    End If
    BAC_Parametros.BacParam.StoredProcParam(6) = "S"
    
    BAC_Parametros.BacParam.Formulas(1) = "Usuario" + "/" + gsBAC_User + "'"
    BAC_Parametros.BacParam.Formulas(0) = "Fec_Proceso='" + CStr(gsbac_fecp) + "'"
    BAC_Parametros.BacParam.Connect = SwConeccion
    BAC_Parametros.BacParam.Action = 1
    'Call Grabar_Log("BTR", gsBAC_User, gsbac_fecp, "Impresión " & TitRpt)

    'Unload Me
    

End Sub



Function BUSCAR_CUENTA(Cuenta As String) As String
Dim Sql As String
Dim Datos()

Envia = Array()
AddParam Envia, Cuenta

If Not BAC_SQL_EXECUTE("SP_BUSCA_CUENTA_CONTABLE ", Envia) Then
   MsgBox "Error : La Busqueda No Termino", vbCritical
   Exit Function
End If

Do While BAC_SQL_FETCH(Datos())
   BUSCAR_CUENTA = Trim(Datos(1))
Loop
    
End Function

Function FUNC_BUSCAR_PERFIL_VARIABLE(Filas As Single, Perfil As String)
Dim Sql  As String
Dim X    As Integer
Dim Datos()


Envia = Array()
AddParam Envia, Filas
AddParam Envia, CDbl(IIf(Perfil = "", 0, Perfil))

If Not BAC_SQL_EXECUTE("EXECUTE Sp_Buscar_Perfiles_Variables ", Envia) Then
   MsgBox "Error : en la Cargatura de Perfiles Variables", vbCritical
   Exit Function
End If

PROC_CREA_GRILLA_PERFIL_PV

X = 0
Do While BAC_SQL_FETCH(Datos())
    X = X + 1
    Call TextMatrix(Gr_perfil_PV, X, 0, Datos(2))
    Call TextMatrix(Gr_perfil_PV, X, 1, Datos(3))
    Call TextMatrix(Gr_perfil_PV, X, 2, Datos(4))
    Sql = Datos(5)
Loop

   If Cmb_Condiciones.ListCount <> 0 Then
   
      If Sql <> "" Then
         For r% = 0 To Cmb_Condiciones.ListCount - 1
             Cmb_Condiciones.ListIndex = r%
             If CDbl(Datos(5)) = CDbl(right(Cmb_Condiciones.Text, 3)) Then Exit For
         Next r%
      Else
         Cmb_Condiciones.ListIndex = 0
      End If
      
   End If

End Function

Function FUNC_GRABA_PERFIL_VARIABLE(Sistema As String, Tipo_movimiento As String, Tipo_Operacion As String)

'FUNC_GRABA_PERFIL_VARIABLE = False


FUNC_GRABA_PERFIL_VARIABLE = True

End Function

Function FUNC_VALIDA_CAMPO(Campo As String) As Integer
Dim Datos()

Screen.MousePointer = 11

FUNC_VALIDA_CAMPO = False

Envia = Array()
AddParam Envia, Campo
AddParam Envia, right(Cmb_Sistema.Text, 3)
AddParam Envia, right(Cmb_Tipo_movimiento.Text, 3)
AddParam Envia, Trim(right(Cmb_Tipo_operacion.Text, 5))

If Not BAC_SQL_EXECUTE("SP_BUSCA_CAMPO_PERFIL ", Envia) Then
   Screen.MousePointer = 0
   Exit Function
End If

Screen.MousePointer = 0

If Not BAC_SQL_FETCH(Datos()) Then
   MsgBox "Campo NO Existe.", vbExclamation
   Call TextMatrix(Gr_perfil, Gr_perfil.Row + 1, C_DESC_CAMPO, "")
   Exit Function
End If

Gr_perfil.Col = C_DESC_CAMPO
Gr_perfil.Text = Trim(Datos(1))

Gr_perfil.Col = C_CAMPO

FUNC_VALIDA_CAMPO = True

End Function

Function FUNC_VALIDA_INGRESO_FIJO() As Integer

FUNC_VALIDA_INGRESO_FIJO = False

If Gr_perfil.Col = C_CAMPO Then

   If Not FUNC_VALIDA_CAMPO(Txt_ingreso_campos.Text) Then
      Exit Function
   Else
      Gr_perfil.Text = Txt_ingreso_campos.Text
      Gr_perfil.TextMatrix(Gr_perfil.Row, C_TIPO_MOV) = "D"
   End If
   
   SendKeys "{RIGHT 2}"
End If

If Gr_perfil.Col = C_NCUENTA Then
  
   If Not FUNC_VALIDA_CUENTA(FUNC_FORMATO_CUENTA(Txt_ingreso_campos.Text, "F"), "PF") Then
      Exit Function
   Else
      Gr_perfil.Text = FUNC_FORMATO_CUENTA(Txt_ingreso_campos.Text, "F")
   End If
      
   SendKeys "{DOWN}"
   SendKeys "{HOME}"
End If
   
If Gr_perfil.Col = C_PERFIL_FIJO Then

   If Trim(Txt_ingreso_campos.Text) <> "S" And Trim(Txt_ingreso_campos.Text) <> "N" Then
      Exit Function
   Else
      Gr_perfil.Text = Trim(Txt_ingreso_campos.Text)
      
      Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_NCUENTA, "")
      Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_DESC_CUENTA, "")
       
      If Gr_perfil.Text = "N" Then
         Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_DESC_CUENTA, "PERFIL VARIABLE NO COMPLETO")
      Else
         SendKeys "{RIGHT}"
      End If
   End If
   
End If
   
If Gr_perfil.Col = C_TIPO_MOV Then

   If Trim(Txt_ingreso_campos.Text) <> "D" And Trim(Txt_ingreso_campos.Text) <> "H" Then
      Exit Function
   Else
      Gr_perfil.Text = Trim(Txt_ingreso_campos.Text)
   End If
      
   SendKeys "{RIGHT}"
End If

FUNC_VALIDA_INGRESO_FIJO = True

End Function

Function FUNC_VALIDA_INGRESO_PERFIL(grilla_valida As String) As Integer
Dim Con_info    As Integer: Con_info = False
Dim Descripcion$, i%

FUNC_VALIDA_INGRESO_PERFIL = False

Gr_perfil.Redraw = False

If grilla_valida = "PF" Then

   If Trim(Txt_Glosa.Text) = "" Then Exit Function

   For i% = 1 To Gr_perfil.Rows - 1
   
       If Trim(TextMatrix(Gr_perfil, i%, C_CAMPO, "X")) <> "" Then
       
          If Trim(TextMatrix(Gr_perfil, i%, C_TIPO_MOV, "X")) = "" Or Trim(TextMatrix(Gr_perfil, i%, C_PERFIL_FIJO, "X")) = "" Then
            Gr_perfil.Redraw = True
            Exit Function
          End If
          
'          If Trim(TextMatrix(Gr_perfil, i%, C_PERFIL_FIJO, "X")) = "N" And (InStr(TextMatrix(Gr_perfil, i%, C_DESC_CUENTA, "X"), "NO") > 0 And Mid(TextMatrix(Gr_perfil, i%, C_DESC_CUENTA, "X"), 1, 3) = "Per") Then Exit Function
          
          If Trim(TextMatrix(Gr_perfil, i%, C_PERFIL_FIJO, "X")) = "S" And Trim(TextMatrix(Gr_perfil, i%, C_NCUENTA, "X")) = "" Then
            Gr_perfil.Redraw = True
            Exit Function
          End If
          
          Con_info = True
       End If
       
   Next i%
   
End If

If grilla_valida = "PV" Then

   For i% = 1 To Gr_perfil_PV.Rows - 1
   
       If Trim(TextMatrix(Gr_perfil_PV, i%, C2_CODIGO, "X")) <> "" And Trim(TextMatrix(Gr_perfil_PV, i%, C2_NCUENTA, "X")) = "" Then Exit Function
       
       If Trim(TextMatrix(Gr_perfil_PV, i%, C2_NCUENTA, "X")) <> "" And Trim(TextMatrix(Gr_perfil_PV, i%, C2_CODIGO, "X")) = "" Then Exit Function
       
       If Trim(TextMatrix(Gr_perfil_PV, i%, C2_CODIGO, "X")) <> "" And Trim(TextMatrix(Gr_perfil_PV, i%, C2_NCUENTA, "X")) <> "" Then Con_info = True
       
   Next i%

End If

Gr_perfil.Redraw = True

FUNC_VALIDA_INGRESO_PERFIL = Con_info

End Function

Function FUNC_VALIDA_INGRESO_PV()
Dim Datos()

FUNC_VALIDA_INGRESO_PV = False
If Gr_perfil_PV.Col = 1 Then
  
   If Not FUNC_VALIDA_CUENTA(FUNC_FORMATO_CUENTA(Txt_ingreso_PV.Text, "F"), "PV") Then
      Exit Function
   Else
      Gr_perfil_PV.Text = FUNC_FORMATO_CUENTA(Txt_ingreso_PV.Text, "F")
   End If
      
   SendKeys "{RIGHT}"
End If
   
If Gr_perfil_PV.Col = 0 Then
  
   If Not FUNC_VALIDA_CAMPOV(Txt_ingreso_PV.Text, Trim(right(Cmb_Condiciones.Text, 5)) + Space(50) + Trim(right(Cmb_Tipo_operacion.Text, 5))) Then
      MsgBox "Valor No Existe", vbExclamation
      Exit Function
   End If

   Gr_perfil_PV.Text = Txt_ingreso_PV.Text
   SendKeys "{RIGHT}"
End If
   
   
FUNC_VALIDA_INGRESO_PV = True

End Function


Sub PROC_ASIGNA_COMBOS()

For i = 0 To Cmb_Sistema.ListCount - 1
    Cmb_Sistema.ListIndex = i
    If right(Cmb_Sistema.Text, 3) = Mid(Glob_Registro_Ayuda, 1, 3) Then Exit For
Next i

For i = 0 To Cmb_Tipo_movimiento.ListCount - 1
    Cmb_Tipo_movimiento.ListIndex = i
    If right(Cmb_Tipo_movimiento.Text, 3) = Mid(Glob_Registro_Ayuda, 4, 3) Then Exit For
Next i

For i = 0 To Cmb_Tipo_operacion.ListCount - 1
    Cmb_Tipo_operacion.ListIndex = i
    If right(Cmb_Tipo_operacion.Text, 3) = Mid(Glob_Registro_Ayuda, 7, 3) Then Exit For
Next i

End Sub

Sub PROC_BUSCA_PERFIL(Numero As Long, varsSist, varsOper, varsMov, varsMone, varsMone2, varsInstr As String)
Dim Datos()
Dim Sql As String
Dim X As Integer
Screen.MousePointer = 11

' Sistema = Right(Cmb_sistema.Text, 3)
' Tipo_movimiento = Right(Cmb_tipo_movimiento.Text, 3)
' Tipo_Operacion = Right(Cmb_tipo_operacion.Text, 3)
' sql = "SP_BUSCA_PERFIL 'PF'," + "'" + Sistema + "','" + Tipo_movimiento + "','" + Tipo_Operacion + "'"
' SP_BUSCAR_DETALLE_PERFILES 2

    '--------------------------------
    Envia = Array()
    AddParam Envia, Numero
    AddParam Envia, varsSist
    AddParam Envia, varsOper
    AddParam Envia, varsMov
    AddParam Envia, CDbl(varsMone)
    AddParam Envia, CDbl(varsMone2)
    AddParam Envia, varsInstr
    
    Lbl_existe_perfil.Caption = "N"
    If Not BAC_SQL_EXECUTE("sp_buscar_perfiles_Saldos ", Envia) Then
       Screen.MousePointer = 0
       Exit Sub
    End If

    If BAC_SQL_FETCH(Datos()) Then
       
       If Datos(1) = "NO HAY" Then
           
           Folio_Perfil = Datos(2)
            
            If Cmb_Tipo_movimiento <> "" Then
              
              Txt_Glosa.Text = Trim(left(Cmb_Tipo_operacion, Len(Cmb_Tipo_operacion) - 5))
              Txt_Glosa.Text = Txt_Glosa.Text & " " & Trim(left(Cmb_Tipo_movimiento, Len(Cmb_Tipo_movimiento) - 3))
              Txt_Glosa.Text = Txt_Glosa.Text + " " + Trim(Mid(Cmb_Tipo_Instrumento.Text, 1, 15))
              Txt_Glosa.Text = Txt_Glosa.Text + " " + Trim(right(CmbMoneda1, 5)) + " " + Trim(right(CmbMoneda2, 5))
            
            Else
               
               MsgBox "No existen datos", vbCritical
               Screen.MousePointer = 0
               
               Exit Sub
            
            End If
       
       Else
          
          Txt_Glosa.Text = Trim(Datos(8))
          Folio_Perfil = Datos(9)
       
       End If
    
    End If

    Envia = Array()
    AddParam Envia, Numero
    AddParam Envia, varsSist
    AddParam Envia, varsOper
    AddParam Envia, varsMov
    AddParam Envia, CDbl(varsMone)
    AddParam Envia, CDbl(varsMone2)
    AddParam Envia, varsInstr
    
    If Not BAC_SQL_EXECUTE("sp_buscar_detalle_perfiles_Saldos", Envia) Then
       Screen.MousePointer = 0
       Exit Sub
    End If
     
    X = 0
    Do While BAC_SQL_FETCH(Datos())
    
        X = X + 1
        If X > Gr_perfil.Rows - 2 Then
            Gr_perfil.Rows = Gr_perfil.Rows + 1
        End If
        
        Call TextMatrix(Gr_perfil, X, 0, CDbl(Datos(9)))
        Call TextMatrix(Gr_perfil, X, 1, Datos(13))
        Call TextMatrix(Gr_perfil, X, 2, Datos(10))
        Call TextMatrix(Gr_perfil, X, 3, Datos(11))
        Call TextMatrix(Gr_perfil, X, 4, Datos(12))
        Call TextMatrix(Gr_perfil, X, 5, IIf(Datos(11) <> "N", Datos(14), "PERFIL VARIABLE COMPLETO"))
        Call TextMatrix(Gr_perfil, X, C_CAMPO_VARIABLE, Format(CDbl(Datos(7)), "##0"))
        Call TextMatrix(Gr_perfil, X, 7, X)
    Loop

Screen.MousePointer = 0

PROC_HABILITA False

End Sub

Sub PROC_CREA_GRILLA_PERFIL_PV()

'Gr_perfil_PV.Redraw = False

Gr_perfil_PV.Rows = 1
Gr_perfil_PV.Cols = 1

Gr_perfil_PV.Rows = 100
Gr_perfil_PV.Cols = 3

Gr_perfil_PV.FixedRows = 1
Gr_perfil_PV.FixedCols = 0

Gr_perfil_PV.Row = 0
'VB+- 10/02/2000  Se saco Gr_perfil_PV.Col = C2_CONDICION: Gr_perfil_PV.Text = "Condicion"
Gr_perfil_PV.Col = C2_VALOR: Gr_perfil_PV.Text = "Valor"
Gr_perfil_PV.Col = C2_NCUENTA: Gr_perfil_PV.Text = "Cuenta"
Gr_perfil_PV.Col = C2_DESC_CUENTA: Gr_perfil_PV.Text = "Descripción Cuenta"

' VB+- 10/02/2000 Gr_perfil_PV.ColWidth(C2_CONDICION) = 2000
Gr_perfil_PV.ColWidth(C2_VALOR) = 1500
Gr_perfil_PV.ColWidth(C2_NCUENTA) = 1200
Gr_perfil_PV.ColWidth(C2_DESC_CUENTA) = 4000
' VB+- 10/02/2000 Gr_perfil_PV.ColWidth(C2_CODIGO_CONDICION) = 1
'Gr_perfil_PV.ColWidth(C2_CODIGO_VALOR) = 1

' VB+- 10/02/20000 Gr_perfil_PV.ColAlignment(C2_CONDICION) = flexAlignLeftCenter
Gr_perfil_PV.ColAlignment(C2_VALOR) = flexAlignLeftCenter
Gr_perfil_PV.ColAlignment(C2_NCUENTA) = flexAlignLeftCenter
Gr_perfil_PV.ColAlignment(C2_DESC_CUENTA) = flexAlignLeftCenter

'Gr_perfil_PV.Redraw = True

Gr_perfil_PV.Row = 1
Gr_perfil_PV.Col = 0

End Sub

Sub PROC_ELIMINA_PERFIL()
Dim Datos()
Dim Error               As Integer: Error = False
Dim Sistema             As String * 3
Dim Tipo_movimiento     As String * 3
Dim Tipo_Operacion      As String * 5
Dim correlativo_perfil  As Long


varsSist = right(Cmb_Sistema.Text, 3)
varsMov = right(Cmb_Tipo_movimiento.Text, 3)
varsOper = Trim(right(Cmb_Tipo_operacion.Text, 5))
varsInstr = IIf(Trim(right(Cmb_Tipo_Instrumento.Text, 15)) <> "", Trim(right(Cmb_Tipo_Instrumento.Text, 15)), "")
varsMone = Trim(CmbMoneda1.ItemData(CmbMoneda1.ListIndex))
varsMone2 = Trim(CmbMoneda2.ItemData(CmbMoneda2.ListIndex))
correlativo_perfil = 0

Envia = Array()
AddParam Envia, Trim(varsSist)
AddParam Envia, Trim(varsOper)
AddParam Envia, Trim(varsMov)
AddParam Envia, CDbl(varsMone)
AddParam Envia, CDbl(varsMone2)
AddParam Envia, Trim(varsInstr)
AddParam Envia, CDbl(correlativo_perfil)
AddParam Envia, CDbl(Folio_Perfil)


If Not BAC_SQL_EXECUTE("SP_ELIMINA_PERFIL_Saldos", Envia) Then
   Error = True
   GoTo END_Graba_Perfil:
End If

   MsgBox "Perfil Eliminado.", vbInformation
   Call LogAuditoria("03", OptLocal, Me.Caption, "Sistema: " & right(Cmb_Sistema.Text, 6) & " - Tipo operación: " & right(Cmb_Tipo_operacion.Text, 6) & " - Moneda 1: " & right(CmbMoneda1.Text, 6) & " - Moneda 2: " & right(CmbMoneda2.Text, 6) & " - Tipo movimiento: " & Cmb_Tipo_movimiento.Text, "")
   PROC_LIMPIA

Exit Sub

END_Graba_Perfil:
If Error Then MsgBox "Perfil NO Eliminado.", vbExclamation
Call LogAuditoria("03", OptLocal, Me.Caption & " Error al eliminar- Sistema: " & right(Cmb_Sistema.Text, 6) & " - Tipo operación: " & right(Cmb_Tipo_operacion.Text, 6) & " - Moneda 1: " & right(CmbMoneda1.Text, 6) & " - Moneda 2: " & right(CmbMoneda2.Text, 6) & " - Tipo movimiento: " & Cmb_Tipo_movimiento.Text, "", "")

End Sub
Sub PROC_GRABA_PERFIL()
Dim Datos(), r%
Dim Error            As Integer
Dim Sistema          As String * 3
Dim Tipo_movimiento  As String * 3
Dim Tipo_Operacion   As String * 5
Dim crear_perfil     As String * 1
Dim folio            As String
Dim correlativo_perfil As String

'If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then Exit Sub

Error = False
   
   If BacBeginTransaction Then

         Screen.MousePointer = 11
         
         Sistema = right(Cmb_Sistema.Text, 3)
         Tipo_movimiento = right(Cmb_Tipo_movimiento.Text, 3)
         Tipo_Operacion = Trim(right(Cmb_Tipo_operacion.Text, 5))
         
         varsSist = right(Cmb_Sistema.Text, 3)
         varsMov = right(Cmb_Tipo_movimiento.Text, 3)
         varsOper = Trim(right(Cmb_Tipo_operacion.Text, 5))
         varsInstr = IIf(Trim(right(Cmb_Tipo_Instrumento.Text, 15)) <> "", Trim(right(Cmb_Tipo_Instrumento.Text, 15)), "")
         varsMone = Trim(CmbMoneda1.ItemData(CmbMoneda1.ListIndex))
         varsMone2 = Trim(CmbMoneda2.ItemData(CmbMoneda2.ListIndex))
         folio = Folio_Perfil
         correlativo_perfil = 0

         Envia = Array()
         AddParam Envia, Trim(varsSist)
         AddParam Envia, Trim(varsOper)
         AddParam Envia, Trim(varsMov)
         AddParam Envia, CDbl(varsMone)
         AddParam Envia, CDbl(varsMone2)
         AddParam Envia, Trim(varsInstr)
         AddParam Envia, CDbl(correlativo_perfil)
         AddParam Envia, CDbl(Folio_Perfil)

         If Not BAC_SQL_EXECUTE("SP_ELIMINA_PERFIL_Saldos", Envia) Then
            Error = True
            GoTo END_Graba_Perfil:
         End If
         
         'Gr_perfil.Redraw = False
         crear_perfil = "S"
         
         For r% = 1 To Gr_perfil.Rows - 1
         
             Gr_perfil.Row = r%
             Gr_perfil.Col = C_CAMPO
         
             If Gr_perfil.Text = "" Then Exit For
         
             If CDbl(IIf(Gr_perfil.Text = "", 0, Gr_perfil.Text)) > 0 Then
              
                Envia = Array()
                AddParam Envia, crear_perfil
                AddParam Envia, Trim(right(Cmb_Sistema.Text, 3))
                AddParam Envia, Trim(right(Cmb_Tipo_operacion, 5))
                AddParam Envia, Trim(right(Cmb_Tipo_movimiento, 15))
                AddParam Envia, CmbMoneda1.ItemData(CmbMoneda1.ListIndex)
                AddParam Envia, CmbMoneda2.ItemData(CmbMoneda2.ListIndex)
                AddParam Envia, Trim(right(Cmb_Tipo_Instrumento, 15))
                AddParam Envia, left(Cmb_Tipo_Voucher, 1)
                AddParam Envia, Txt_Glosa
                         
                AddParam Envia, Folio_Perfil
                AddParam Envia, r%
                AddParam Envia, Val(TextMatrix(Gr_perfil, r%, C_CAMPO, "X"))
                AddParam Envia, TextMatrix(Gr_perfil, r%, C_TIPO_MOV, "X")
                AddParam Envia, TextMatrix(Gr_perfil, r%, C_PERFIL_FIJO, "X")
                AddParam Envia, TextMatrix(Gr_perfil, r%, C_NCUENTA, "X")
                
                crear_perfil = "N"
                
                If Not BAC_SQL_EXECUTE("Sp_Crea_Perfil_Saldos", Envia) Then
                   Error = True
                   Exit For
                End If
                
                If Mid(TextMatrix(Gr_perfil, r%, C_PERFIL_FIJO, "X"), 1, 1) = "N" Then
                
                   
                End If
                
             End If
             
         Next r%

                Envia = Array()
                AddParam Envia, Trim(right(Cmb_Sistema.Text, 3))
                AddParam Envia, Trim(right(Cmb_Tipo_operacion, 5))
                AddParam Envia, Trim(right(Cmb_Tipo_movimiento, 15))
                AddParam Envia, CmbMoneda1.ItemData(CmbMoneda1.ListIndex)
                AddParam Envia, CmbMoneda2.ItemData(CmbMoneda2.ListIndex)
                AddParam Envia, Trim(right(Cmb_Tipo_Instrumento, 15))
                         
                AddParam Envia, Folio_Perfil
                
                If Not BAC_SQL_EXECUTE("Sp_Crea_Perfil_Variable_Saldos", Envia) Then
                   Error = True
                End If
       
   End If

END_Graba_Perfil:

   
Screen.MousePointer = 0

If Not Error Then
   
   
   If BacCommitTransaction Then
   
      MsgBox "Perfil Grabado sin Problemas.", 64
      Call PROC_LIMPIA

   End If

Else
   If BacRollBackTransaction Then MsgBox "Información NO Grabada.", 16
   
End If
End Sub

Sub PROC_HABILITA(modo As Boolean)

Cmb_Sistema.Enabled = modo
Cmb_Tipo_movimiento.Enabled = modo
Cmb_Tipo_operacion.Enabled = modo
cmd_ayuda_perfil.Enabled = modo
CmbMoneda1.Enabled = modo
CmbMoneda2.Enabled = modo
Cmb_Tipo_Instrumento.Enabled = modo
Txt_Glosa.Enabled = modo
Cmb_Tipo_Voucher.Enabled = modo

End Sub
Sub PROC_HABILITA_PV(modo As Integer)
Toolbar1.Buttons(1).Enabled = modo
Toolbar1.Buttons(2).Enabled = modo
Toolbar1.Buttons(5).Enabled = modo
'Toolbar1.Buttons(4).Enabled = modo
'Cmd_Grabar.Enabled = modo   ' Grabar
'Cmd_Buscar.Enabled = modo   ' Buscar
'Cmd_Eliminar.Enabled = modo ' Anular

Frm_Tipo_movimiento.Enabled = modo
Frm_Perfil.Enabled = modo

End Sub


Sub PROC_LIMPIA()

    Cmb_Sistema.Enabled = True
    Cmb_Tipo_movimiento.Enabled = True
    Cmb_Tipo_operacion.Enabled = True
    
    PROC_HABILITA_PV True

    PROC_HABILITA True

    SSPanel2.Visible = False

    PROC_CREA_GRILLA_PERFIL

    PROC_CREA_GRILLA_PASO

    Txt_Glosa.Text = ""
    Lbl_msg.Caption = ""
    Lbl_existe_perfil.Caption = "N"
    
    Frm_Perfil.Enabled = False
    Toolbar1.Buttons(4).Enabled = True
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(2).Enabled = True

    Cmb_Tipo_Voucher.Text = "INGRESO"
    
    Gr_perfil_PV.Refresh
    Gr_perfil.Refresh
    
    Cmb_Sistema.ListIndex = -1
    Cmb_Tipo_movimiento.ListIndex = -1
    Cmb_Tipo_operacion.ListIndex = -1
    CmbMoneda1.ListIndex = -1
    CmbMoneda2.ListIndex = -1
    Cmb_Tipo_Instrumento.ListIndex = -1
'    Cmb_Tipo_Voucher.ListIndex = -1
    
    CmbMoneda1.Enabled = False
    CmbMoneda2.Enabled = False
    
    Toolbar1.Buttons(5).Enabled = False
    
End Sub



Sub PROC_CARGA_COMBO_SISTEMA()
'   ----------------------------------------------------------------------------------
'   SubRutina   :   Proc_Carga_Combo_sistema - VB
'   Objetivo    :   Realiza la carga de información en los objetos tipo Combos
'   ----------------------------------------------------------------------------------

Dim Datos()
Dim Sql As String

On Error GoTo ErrCarga

  ' Cargo Combo de sistemas
  ' ============================================================================
    Cmb_Sistema.Clear
    If BAC_SQL_EXECUTE("SP_BUSCAR_SISTEMAS") Then
        Do While BAC_SQL_FETCH(Datos())
            Cmb_Sistema.AddItem Mid$(Datos(2), 1, 20) & Space(50) & Datos(1)
            CmbSistema_C.AddItem Mid$(Datos(2), 1, 20) & Space(50) & Datos(1)
            CmbSistema_F.AddItem Mid$(Datos(2), 1, 20) & Space(50) & Datos(1)
        Loop
    Else
        MsgBox "No se pudo obtener información del servidor", vbCritical
        Exit Sub
    End If
  ' ============================================================================
  
  
  ' Cargo combo de Tipos de Voucher
  ' ============================================================================
    Cmb_Tipo_Voucher.AddItem "INGRESO"
    Cmb_Tipo_Voucher.AddItem "EGRESO"
    Cmb_Tipo_Voucher.AddItem "TRASPASO"
    Cmb_Tipo_Voucher.Text = "INGRESO"
    
    CmbTipoVoucher_C.AddItem "INGRESO"
    CmbTipoVoucher_C.AddItem "EGRESO"
    CmbTipoVoucher_C.AddItem "TRASPASO"
    CmbTipoVoucher_C.Text = "INGRESO"
        
  ' ============================================================================
  
  ' Cargo combo de Tipos de Voucher
  ' ============================================================================
  ' Cmb_tipo_movimiento.AddItem "MOVIMIENTO"
  ' Cmb_tipo_movimiento.AddItem "DEVENGAMIENTO"
  ' ============================================================================
    Cmb_Tipo_movimiento.ListIndex = -1
    Cmb_Tipo_Instrumento.ListIndex = -1
    Exit Sub
    
ErrCarga:
    MsgBox "Se detectó problemas en carga de información: " & err.Description & ". Comunique al Administrador.", vbCritical
    Exit Sub
End Sub

Function TextMatrix(Grilla As Control, Fila As Integer, Columna As Integer, Dato As Variant) As Variant
On Error GoTo ErrorF:

Dim fil_g% ' La puse yo
Dim col_g% ' La puse yo
fil_g% = Grilla.Row
col_g% = Grilla.Col

Grilla.Row = Fila
Grilla.Col = Columna

If Dato = "X" Then
   TextMatrix = Grilla.Text
Else
   Grilla.Text = Dato
End If

Grilla.Row = fil_g%
Grilla.Col = col_g%
ErrorF:
End Function

Private Sub Cmb_Condiciones_Click()
Dim Sql As String
Dim Datos()
Dim X As Integer

    For X = 1 To Gr_perfil.Rows - 1
       Call TextMatrix(Gr_perfil_PV, X, C2_VALOR, "")
       Call TextMatrix(Gr_perfil_PV, X, C2_NCUENTA, "")
       Call TextMatrix(Gr_perfil_PV, X, C2_DESC_CUENTA, "")
    Next X
    
    PROC_CREA_GRILLA_PERFIL_PV
    Envia = Array()
    AddParam Envia, Folio_Perfil
    AddParam Envia, Gr_Filas
    AddParam Envia, CDbl(right(Cmb_Condiciones.Text, 7))
    
    If Not BAC_SQL_EXECUTE("sp_buscar_periles_variables ", Envia) Then
       MsgBox "Error : Busqueda de Perfiles Variables", vbCritical
       Exit Sub
    End If
    X = 0
    Do While BAC_SQL_FETCH(Datos())
       X = X + 1
       Call TextMatrix(Gr_perfil_PV, X, C2_VALOR, Datos(1))
       Call TextMatrix(Gr_perfil_PV, X, C2_NCUENTA, Datos(2))
       Call TextMatrix(Gr_perfil_PV, X, C2_DESC_CUENTA, Datos(3))
    Loop
    
    
End Sub

Private Sub cmb_Sistema_Click()

     'PROC_CARGA_COMBO_MOVIMIENTO
     CargaCombos Cmb_Tipo_movimiento, "OPERACION"
     CargaCombos Cmb_Tipo_operacion, "PRODUCTO"
     CargaCombos Cmb_Tipo_Instrumento, "INSTRUMENTO"
     
     Cmb_Tipo_Instrumento.Enabled = IIf(Cmb_Tipo_Instrumento.ListCount > 0, True, False)
     
End Sub

Private Sub Cmb_sistema_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then Cmb_Tipo_movimiento.SetFocus

End Sub

Private Sub Cmb_Tipo_Movimiento_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then Cmb_Tipo_operacion.SetFocus

End Sub


Private Sub Cmb_tipo_operacion_Click()

   CargaCombos CmbMoneda1, "MONEDA"
   CargaCombos CmbMoneda2, "MONEDA"
   CmbMoneda1.Enabled = True
   CmbMoneda2.Enabled = True
    
End Sub

Private Sub Cmb_Tipo_Operacion_KeyPress(KeyAscii As Integer)

If Cmb_Tipo_Instrumento.Enabled Then
   Cmb_Tipo_Instrumento.SetFocus
''ElseIf Cmb_Tipo_Moneda.Enabled Then
''       Cmb_Tipo_Moneda.SetFocus
Else
   If Cmb_Tipo_Voucher.Visible = True Then Cmb_Tipo_Voucher.SetFocus
   If Cmb_Tipo_Voucher.Visible = False And Me.CmbMoneda1.Enabled = True Then Me.CmbMoneda1.SetFocus
End If

End Sub



Private Sub Cmb_tipo_voucher_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then Txt_Glosa.Enabled = True: Txt_Glosa.SetFocus

End Sub


Sub PROC_CREA_GRILLA_PASO()

' GRILLA PERFIL VARIABLE
'Gr_perfil_paso.Rows = 1
'Gr_perfil_paso.Cols = 3

End Sub


Private Sub Cmd_Agrega_Click()

End Sub

Private Sub Cmd_Agrega_PV_Click()

End Sub

Private Sub Cmd_aceptar_PV_Click()

End Sub

Private Sub CmbSistema_C_Click()

     CargaCombos CmbEvento_C, "OPERACION"
     CargaCombos CmbTipoOperacion_C, "PRODUCTO"
     CargaCombos CmbInstrumento_C, "INSTRUMENTO"
     
     CmbInstrumento_C.Enabled = IIf(CmbInstrumento_C.ListCount > 0, True, False)

End Sub

Private Sub CmbSistema_F_Click()
     CargaCombos2 Me.CmbEvento_F, "OPERACION"
     CargaCombos2 Me.CmbTipoOperacion_F, "PRODUCTO"
     CargaCombos2 Me.CmbInstrumento_F, "INSTRUMENTO"
     
     CmbInstrumento_F.Enabled = IIf(CmbInstrumento_F.ListCount > 0, True, False)
End Sub

Private Sub CmbSistema_F_GotFocus()
    CmbSistema_F.Clear
    PROC_CARGA_COMBO_SISTEMA
    
End Sub

Private Sub CmbTipoOperacion_C_Click()
   
   CargaCombos CmbMoneda1_C, "MONEDA"
   CargaCombos CmbMoneda2_C, "MONEDA"
   CmbMoneda1_C.Enabled = True
   CmbMoneda2_C.Enabled = True
   
End Sub

Private Sub CmbTipoOperacion_F_Click()
    CargaCombos2 CmbMoneda1_F, "MONEDA"
    CargaCombos2 CmbMoneda2_F, "MONEDA"
    CmbMoneda1_F.Enabled = True
    CmbMoneda2_F.Enabled = True
End Sub

Private Sub Cmd_ayuda_perfil_Click()
On Error GoTo Errores:
   
   
   MiTag = "PERFIL_SALDO"
   BacAyuda.parAyuda = "BAC_CNT_PERFIL" + IIf(Cmb_Sistema = "", "", right(Cmb_Sistema.Text, 3))
   BacAyuda.Show 1
      
   
   varsSist = right(Cmb_Sistema.Text, 3)
   varsMov = Trim(right(Cmb_Tipo_movimiento.Text, 10))
   varsOper = Trim$(right(Cmb_Tipo_operacion.Text, 5))
   
   If Cmb_Control_Instrumento.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
     varsInstr = ""
   Else
     varsInstr = Trim(right(Cmb_Tipo_Instrumento.Text, 12))
   End If
   
''   If CmbMoneda1.ListCount - 1 > -1 And CmbMoneda2.ListCount - 1 > -1 Then
''
''      varsMone = CDbl(CmbMoneda1.ItemData(CmbMoneda1.ListIndex))
''      varsMone2 = CDbl(CmbMoneda2.ItemData(CmbMoneda2.ListIndex))
''
''   End If

    If Trim(gsCodigo$) <> "" And giAceptar Then
    
       Folio_Perfil = CDbl(gsCodigo$)
    
       Envia = Array()
       AddParam Envia, Folio_Perfil
    
       If Not BAC_SQL_EXECUTE("Sp_PerfilContable_DevuelveFolio_Saldos", Envia) Then
        
            MsgBox "Problemas al Cargar Perfiles", vbExclamation
            Exit Sub
        
       End If
    
       If BAC_SQL_FETCH(Datos()) Then
                 
            Toolbar1.Buttons(5).Enabled = True
            varNumeros = 0
            varsSist = Datos(1)
            varsOper = Datos(2)
            varsMov = Datos(3)
            varsMone = Datos(4)
            varsMone2 = Datos(5)
            varsInstr = Datos(6)
            varsTipVoucher = Datos(7)
       End If
    
       Call Busca_Combos
    
       PROC_BUSCA_PERFIL CDbl(varNumeros), varsSist, varsOper, varsMov, varsMone, varsMone2, Trim(varsInstr)
       
       Frm_Perfil.Enabled = True
       Toolbar1.Buttons(4).Enabled = False
       Toolbar1.Buttons(1).Enabled = True
       Toolbar1.Buttons(2).Enabled = True
    
       Gr_perfil.Row = 1
       Gr_perfil.Col = C_CAMPO
       Gr_perfil.SetFocus
       SendKeys "^{HOME}"

    Else
       Cmb_Sistema.SetFocus
    End If
Exit Sub

Errores:
        Screen.MousePointer = 0
        MsgBox Error(err), vbExclamation
Exit Sub
End Sub

Private Sub Cmd_Buscar_Click()

End Sub





Sub PROC_MARCA_FILA_GRILLA(Objeto_grid As Control, Color1, Color2, Fila, Columna)
Dim fila_actual%, columna_actual%, estilo_fila%

    fila_actual% = Objeto_grid.Row
    'fila_rango% = Objeto_grid.RowSel
    columna_actual% = Objeto_grid.Col
    'columna_rango% = Objeto_grid.ColSel
    estilo_fila% = Objeto_grid.FillStyle
    
    Objeto_grid.Row = Fila
    'Objeto_grid.RowSel = Fila
    Objeto_grid.Col = Columna
    'Objeto_grid.ColSel = Objeto_grid.Cols - 1
    Objeto_grid.FillStyle = flexFillRepeat
    'Objeto_grid.CellBackColor = Color1
    'Objeto_grid.CellForeColor = Color2
    
    Objeto_grid.Row = fila_actual%
    'Objeto_grid.RowSel = fila_rango%
    Objeto_grid.Col = columna_actual%
    'Objeto_grid.ColSel = columna_rango%
    Objeto_grid.FillStyle = estilo_fila%

End Sub

Function FUNC_FMT_NUMERO_TXT(Numero As Double, n_enteros, n_decimales As Integer) As String
Dim fmt_numero    As String
Dim fmt_enteros   As String
Dim fmt_decimales As String

If Numero < 0 Then Numero = Numero * -1

fmt_enteros = String(n_enteros, "0")
fmt_decimales = String(n_decimales, "0")

fmt_numero = Format(Numero, fmt_enteros + "." + fmt_decimales)

FUNC_FMT_NUMERO_TXT = Mid(fmt_numero, 1, n_enteros) + Mid(fmt_numero, n_enteros + 2, n_decimales)

End Function
Private Sub Cmb_Tipo_Moneda_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
   Cmb_Tipo_Voucher.Enabled = True
   Cmb_Tipo_Voucher.SetFocus
End If

End Sub

Private Sub Cmb_Tipo_Instrumento_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then

''   If Cmb_Tipo_Moneda.Enabled Then
''      Cmb_Tipo_Moneda.SetFocus
''   Else
''      Cmb_Tipo_Voucher.SetFocus
''   End If
''
End If

End Sub

Private Sub Cmd_exit_opciones_Click()
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   Screen.MousePointer = vbNormal
End Sub

Private Sub Form_Load()
   OptLocal = Opt
   Me.top = 0
   Me.left = 0
   
   PROC_CARGA_COMBO_SISTEMA    '  Carga Combos iniciales
   
   If Cmb_Sistema.ListCount <= 0 Then
       Exit Sub
   Else
       Txt_Glosa.Enabled = True
       PROC_LIMPIA
   End If
    
   Me.SSPanelFiltro.Visible = False
   
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
      
End Sub

Function FUNC_FORMATO_CUENTA(texto As String, Formato As String) As String

If Trim(texto) = "" Then
   FUNC_FORMATO_CUENTA = ""
   Exit Function
End If
 FUNC_FORMATO_CUENTA = texto
'If Formato = "F" Then
'   FUNC_FORMATO_CUENTA = Mid(Texto, 1, 2) + "." + Mid(Texto, 3, 2) + "." + Mid(Texto, 5, 2) + "." + Mid(Texto, 7, 3)
'Else
'   FUNC_FORMATO_CUENTA = Mid(Texto, 1, 2) + Mid(Texto, 4, 2) + Mid(Texto, 7, 2) + Mid(Texto, 10, 3)
'End If

End Function


Function FUNC_VALIDA_CUENTA(Cuenta As String, tipo_perfil As String) As Integer
Dim Datos()


Screen.MousePointer = 11

FUNC_VALIDA_CUENTA = False

Envia = Array()
AddParam Envia, Cuenta

If Not BAC_SQL_EXECUTE("sp_busca_cuenta_contable ", Envia) Then
   Screen.MousePointer = 0
   Exit Function
End If

Screen.MousePointer = 0

If Not BAC_SQL_FETCH(Datos()) Then
   MsgBox "Cuenta NO Existe.", vbCritical
   Exit Function
End If

' yo lo saque

'If Trim(DATOS(5)) <> "S" Then  ' Cuenta SVS
'   MsgBox "Cuenta NO Imputable.", vbCritical
'   Exit Function
'End If
'yo lo saque
Select Case tipo_perfil
       Case "PF":  Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_DESC_CUENTA, Trim(Datos(1)))
       Case "PV":  Call TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row, C2_DESC_CUENTA, Trim(Datos(1)))
'       Case "PV2": Call TextMatrix(Gr_perfil_PV2, Gr_perfil_PV2.Row, C3_DESC_CUENTA, Trim(datos(1)))
End Select

FUNC_VALIDA_CUENTA = True

End Function

Sub PROC_CREA_GRILLA_PERFIL()

Gr_perfil.Redraw = False

Gr_perfil.FixedRows = 0
Gr_perfil.FixedCols = 0
Gr_perfil.Rows = 1
Gr_perfil.Cols = 1

Gr_perfil.Rows = 23
Gr_perfil.Cols = 8
Gr_perfil.FixedRows = 1
Gr_perfil.FixedCols = 0

Gr_perfil.Row = 0
Gr_perfil.Col = C_CAMPO: Gr_perfil.Text = "Campo"
Gr_perfil.Col = C_DESC_CAMPO: Gr_perfil.Text = "Descripción Campo"
Gr_perfil.Col = C_PERFIL_FIJO: Gr_perfil.Text = "P/F"
Gr_perfil.Col = C_TIPO_MOV: Gr_perfil.Text = "T/M"
Gr_perfil.Col = C_NCUENTA: Gr_perfil = "Cuenta"
Gr_perfil.Col = C_DESC_CUENTA: Gr_perfil.Text = "Descripción Cuenta"

Gr_perfil.ColWidth(C_CAMPO) = 700
Gr_perfil.ColWidth(C_DESC_CAMPO) = 3500
Gr_perfil.ColWidth(C_PERFIL_FIJO) = 500
Gr_perfil.ColWidth(C_TIPO_MOV) = 0
Gr_perfil.ColWidth(C_NCUENTA) = 1100
Gr_perfil.ColWidth(C_DESC_CUENTA) = 4500
Gr_perfil.ColWidth(C_CAMPO_VARIABLE) = 1
Gr_perfil.ColWidth(7) = 0



Gr_perfil.ColAlignment(C_CAMPO) = 1 'flexAlignRightCenter
Gr_perfil.ColAlignment(C_DESC_CAMPO) = 0 'flexAlignLeftCenter
Gr_perfil.ColAlignment(C_PERFIL_FIJO) = 0 'flexAlignLeftCenter
Gr_perfil.ColAlignment(C_TIPO_MOV) = 0 'flexAlignLeftCenter
Gr_perfil.ColAlignment(C_NCUENTA) = 0 'flexAlignLeftCenter
Gr_perfil.ColAlignment(C_DESC_CUENTA) = 0 'flexAlignLeftCenter
Gr_perfil.ColAlignment(C_CAMPO_VARIABLE) = 0 'flexAlignLeftCenter

'Gr_perfil.Rows = 21
'Gr_perfil.FixedRows = 1
'Gr_perfil.FixedCols = 0
Gr_perfil.Row = 1
Gr_perfil.Col = 0

Gr_perfil.Redraw = True

End Sub
Sub PROC_POSICIONA_TEXTO(Grilla As MSFlexGrid, texto As TextBox)
Dim n As Integer
Dim i As Integer
Dim f As Integer

 texto.Width = Grilla.ColWidth(Grilla.Col) - 10
 texto.Height = Grilla.RowHeight(Grilla.Row) - 10
 texto.top = (Grilla.top + Grilla.CellTop) + 10
  
 
''''' If Grilla.TopRow > 1 Then
'''''    Texto.Top = Grilla.Top + (((Grilla.Row - Grilla.TopRow) + 1) * 245)
''''' Else
'''''    Texto.Top = Grilla.Top + (Grilla.Row * 245)
''''' End If
'''''
''''' n = 0
''''' f = IIf(Grilla.Col = 0, 0, Grilla.Col - 1)
'''''
''''' If Grilla.Col > 0 Then
'''''     For I = 0 To f
'''''        n = n + Grilla.ColWidth(I) + 10
'''''     Next I
''''' End If
 
 'Texto.Left = Grilla.Left + n + 20
 
 texto.left = (Grilla.CellLeft + Grilla.left) + 10
 ' Texto.Left = Grilla.Left + (Grilla.Col * 30) + 20
End Sub


Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Gr_perfil_DblClick()
Dim Sql            As String
Dim campo_variable As Integer
Dim Datos()

Gr_Filas = Gr_perfil.Row

If Gr_perfil.Col = C_PERFIL_FIJO And Gr_perfil.TextMatrix(Gr_perfil.Row, C_CAMPO) <> "" Then

   If Trim(Gr_perfil.Text) = "S" Or Trim(Gr_perfil.Text) = "" Then Exit Sub
   
   Screen.MousePointer = 11
   
   PROC_HABILITA_PV False

   'PROC_PASA_GRILLA_PV
   
   PROC_MARCA_FILA_GRILLA Gr_perfil, G_COLOR_CLARO, G_COLOR_NEGRO, Gr_perfil.Row, 0
   
   'VicBarra
   
   Envia = Array()
   AddParam Envia, Trim(right(Cmb_Sistema, 3))
   AddParam Envia, Trim(right(Cmb_Tipo_movimiento, 3))
   AddParam Envia, Trim(right(Cmb_Tipo_operacion, 5))
   
   If Not BAC_SQL_EXECUTE("sp_leer_campos ", Envia) Then
      Screen.MousePointer = 0
      MsgBox "Problemas en la Lectura de Campos.", vbCritical
      Exit Sub
   End If
   
   Cmb_Condiciones.Clear
   
   Do While BAC_SQL_FETCH(Datos())
      Cmb_Condiciones.AddItem Datos(2) + Space(80) + Format(CDbl(Datos(1)), "#0")
   Loop
   
   FUNC_BUSCAR_PERFIL_VARIABLE Gr_Filas, Gr_perfil.TextMatrix(Gr_perfil.Row, 0)
   
   Screen.MousePointer = 0
   
   If Cmb_Condiciones.ListCount > 0 Then
      SSPanel2.Visible = True
      Gr_perfil_PV.SetFocus
        
      SendKeys "^{HOME}"
    Else
      MsgBox "No existen condiciones lógicas para este tipo de operación", vbInformation
      PROC_HABILITA_PV True
   End If
   
End If

If Gr_perfil.Col = C_CAMPO Then
   MiTag = "CAMPOS"
   BacAyuda.parFiltro = Trim(right(Cmb_Tipo_operacion.Text, 5))
   BacAyuda.parAyuda = "CON_CAMPOS_PERFIL"

   BacAyuda.Show 1
   If giAceptar% = True Then
     If Trim(gsCodigo$) <> "" Then
       Txt_ingreso_campos.MaxLength = 5
       Txt_ingreso_campos.Text = Trim(gsCodigo$)
       Txt_Ingreso_Campos_KeyPress 13
       Gr_perfil.TextMatrix(Gr_perfil.Row, 7) = Gr_perfil.Row
       Gr_perfil.TextMatrix(Gr_perfil.Row, C_TIPO_MOV) = "D"
     End If
   End If
End If

If Gr_perfil.Col = C_NCUENTA Then
 
   If Trim(TextMatrix(Gr_perfil, Gr_perfil.Row, C_PERFIL_FIJO, "X")) <> "S" Then Exit Sub
    BacAyuda.parAyuda = "CON_PLAN_CUENTAS"
    MiTag = "CUENTAS"
    BacAyuda.parFiltro = ""
    BacAyuda.Show 1
    
    If giAceptar = True Then
        If Trim(gsCodigo$) <> "" Then
            Txt_ingreso_campos.MaxLength = 12
            Txt_ingreso_campos.Text = FUNC_FORMATO_CUENTA(Trim(gsCodigo$), "D")
            Txt_Ingreso_Campos_KeyPress 13
        End If
    End If
End If

End Sub

Private Sub Gr_perfil_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
   SendKeys "{RIGHT}"
   Exit Sub
End If

KeyAscii = Asc(UCase(Chr(KeyAscii)))

If KeyAscii = 27 Or Gr_perfil.Col = C_DESC_CAMPO Or Gr_perfil.Col = C_DESC_CUENTA Then Exit Sub

If Not FUNC_VALIDA_LINEA() Then Exit Sub

'If Gr_perfil.Col <> C_CAMPO And Trim(TextMatrix(Gr_perfil, Gr_perfil.Row, C_CAMPO, "X")) = "" Then Exit Sub

'If Gr_perfil.Col = C_NCUENTA Then

'   If Mid(TextMatrix(Gr_perfil, Gr_perfil.Row, C_PERFIL_FIJO, "X"), 1, 1) <> "S" Then Exit Sub
   
'End If

'If Gr_perfil.Col = C_CAMPO Then
'   BacCaracterNumerico KeyAscii

'   If KeyAscii = 0 Then Exit Sub
'Else
'   BacToUCase KeyAscii
'End If

PROC_POSICIONA_TEXTO Gr_perfil, Txt_ingreso_campos

If KeyAscii = 8 Then

   If Gr_perfil.Col = C_NCUENTA Then
      Txt_ingreso_campos.Text = FUNC_FORMATO_CUENTA(Gr_perfil.Text, "D")
   Else
      Txt_ingreso_campos.Text = Trim(Gr_perfil.Text)
   End If
   
Else
   Txt_ingreso_campos.Text = Chr(KeyAscii)
End If

Txt_ingreso_campos.Visible = True
Txt_ingreso_campos.SetFocus
SendKeys "{END}"

End Sub


Function FUNC_VALIDA_LINEA() As Integer

FUNC_VALIDA_LINEA = False

If Gr_perfil.Row > 1 Then
    
   For r% = C_CAMPO To C_PERFIL_FIJO
       If Trim(TextMatrix(Gr_perfil, Gr_perfil.Row - 1, r%, "X")) = "" Then Exit For
   Next r%
   
   If r% <= C_PERFIL_FIJO Then Exit Function
   
End If

FUNC_VALIDA_LINEA = True

End Function


Private Sub Gr_perfil_PV_DblClick()

If Gr_perfil_PV.Row > 1 Then
   If TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row - 1, C2_CODIGO, "X") = "" Then Exit Sub
End If

If Gr_perfil_PV.Col = C2_NCUENTA Or Gr_perfil_PV.Col = 1 Then

    BacAyuda.parAyuda = "CON_PLAN_CUENTAS"
    BacAyuda.parFiltro = ""
    MiTag = "CUENTAS"
    BacAyuda.Show 1
    If giAceptar% = True Then
      If Trim(gsCodigo$) <> "" Then
         Call TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row, C2_NCUENTA, FUNC_FORMATO_CUENTA(Trim(gsCodigo$), "D"))
         Call TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row, C2_DESC_CUENTA, BUSCAR_CUENTA(Trim(gsCodigo$)))
      End If
    End If
    Gr_perfil.Redraw = True
End If

If Gr_perfil_PV.Col = C2_CODIGO Then

    BacAyuda.parAyuda = "GEN_TABLAS1"
    BacAyuda.parFiltro = Trim(right(Cmb_Condiciones.Text, 5)) + Space(50) + Trim(right(Cmb_Tipo_operacion.Text, 5))
    MiTag = "CONDICIONES"

    BacAyuda.Show 1
    If giAceptar% = True Then
      If Trim(gsCodigo$) <> "" Then
         Txt_ingreso_PV.MaxLength = 10
         Gr_perfil_PV.Text = Trim(gsCodigo$)
         Txt_ingreso_PV.Text = Trim(gsCodigo$)
         Txt_ingreso_PV_KeyPress 13
      End If
    End If
End If

End Sub

Function RELLENA_STRING(Dato As String, Pos As String, largo As Integer) As String

'rellena con blancos y completa el largo requerido
' Ejemplo : x$ = RELLENA_STRING(CStr(i#), "I", 10)
' Ejemplo : x$ = RELLENA_STRING(i$, "D", 10)

If Trim(Pos$) = "" Then Pos$ = "I"

If largo < Len(Trim(Dato)) Then
   RELLENA_STRING = Mid(Trim(Dato), 1, largo)
   Exit Function
End If

If Mid(Pos$, 1, 1) = "I" Then 'IZQUIERDA
   RELLENA_STRING = String(largo - Len(Trim(Dato)), " ") + Trim(Dato)
Else                          'DERECHA
   RELLENA_STRING = Trim(Dato) + String(largo - Len(Trim(Dato)), " ")
End If

RELLENA_STRING = Mid(RELLENA_STRING, 1, largo)

End Function

Private Sub Gr_perfil_PV_KeyPress(KeyAscii As Integer)

   'If Gr_perfil_PV.Col = 0 Or Gr_perfil_PV.Col = 2 Then
   If Gr_perfil_PV.Col = 2 Then
   
      KeyAscii = 0
      Exit Sub
   
   End If
   
   If KeyAscii = 13 Then
      
      SendKeys "{RIGHT}"
      Exit Sub
   
   End If
   
   If KeyAscii = 27 Or Gr_perfil_PV.Col = C2_DESC_CUENTA Then Exit Sub
   
   If Gr_perfil_PV.Row > 1 Then
      
      If TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row - 1, C2_CODIGO, "X") = "" Then Exit Sub
   
   End If
   
   BacToUCase KeyAscii
   
   PROC_POSICIONA_TEXTO Gr_perfil_PV, Txt_ingreso_PV
   
   If KeyAscii = 8 Then
   
      If Gr_perfil_PV.Col = C2_NCUENTA Then
         
         Txt_ingreso_PV.Text = FUNC_FORMATO_CUENTA(Gr_perfil_PV.Text, "D")
      
      Else
         
         Txt_ingreso_PV.Text = Trim(Gr_perfil_PV.Text)
      
      End If
      
   Else
      
      Txt_ingreso_PV.Text = Chr(KeyAscii)
   
   End If
   
   Txt_ingreso_PV.Visible = True
   Txt_ingreso_PV.SetFocus
   SendKeys "{END}"

End Sub


Private Sub Gr_perfil_SelChange()

Select Case Gr_perfil.Col
       Case C_CAMPO:       Lbl_msg.Caption = " Nombre Campo a Contabilizar"
       Case C_DESC_CAMPO:  Lbl_msg.Caption = " Descripción Campo"
       Case C_PERFIL_FIJO: Lbl_msg.Caption = " Perfil Fijo (S=Si / N=No), No=Condiciona Campo por Variables, Si=Ingresar Cuenta"
       Case C_TIPO_MOV:    Lbl_msg.Caption = " Tipo Movimiento (D=Debe / H=Haber)"
       Case C_NCUENTA:     Lbl_msg.Caption = " Número de Cuenta Contable"
       Case C_DESC_CUENTA: Lbl_msg.Caption = " Descripción Cuenta"
End Select

End Sub

Sub PROC_PASA_GRILLA_PV()

PROC_CREA_GRILLA_PERFIL_PV

'Gr_perfil_PV.Redraw = False

'Gr_perfil_PV.Row = 0

'For i% = 1 To Gr_perfil_paso.Rows - 1

'    Gr_perfil_paso.Row = i%
'    Gr_perfil_paso.Col = 0
    
'    If CDBL(Gr_perfil_paso.Text) = Gr_perfil.Row Then
    
'       If Gr_perfil_PV.Row + 1 > Gr_perfil_PV.Rows - 1 Then Gr_perfil_PV.AddItem ""
       
'       Gr_perfil_PV.Row = Gr_perfil_PV.Row + 1
       
'       Gr_perfil_PV.TextMatrix(Gr_perfil_PV.Row, c2_codigo) = Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, c2_codigo + 1)
       
'       Gr_perfil_PV.TextMatrix(Gr_perfil_PV.Row, C2_INDICADOR) = Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_INDICADOR + 1)
       
'       Gr_perfil_PV.TextMatrix(Gr_perfil_PV.Row, C2_NCUENTA) = Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_NCUENTA + 1)
       
'       Gr_perfil_PV.TextMatrix(Gr_perfil_PV.Row, C2_DESC_CUENTA) = Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_DESC_CUENTA + 1)
                     
'    End If
    
'Next i%

'Gr_perfil_PV.Redraw = True

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
On Error Resume Next
    
    Select Case Button.Index
    Case 1
         PROC_LIMPIA
         Cmb_Sistema.SetFocus
    
    Case 2
           If Not FUNC_VALIDA_INGRESO_PERFIL("PF") Then
              MsgBox "Falta Información para Grabar.", vbInformation
              Call LogAuditoria("01", OptLocal, Me.Caption + " Error al grabar- Sistema: " & right(Cmb_Sistema.Text, 6) & " - Tipo operación: " & right(Cmb_Tipo_operacion.Text, 6) & " - Moneda 1: " & right(CmbMoneda1.Text, 6) & " - Moneda 2: " & right(CmbMoneda2.Text, 6) & " - Tipo movimiento: " & Cmb_Tipo_movimiento.Text, "", "")
              Gr_perfil.Redraw = True
              Exit Sub
           End If

           If MsgBox("Seguro de Grabar Perfil ?", 36) <> 6 Then Exit Sub

           Screen.MousePointer = 11
           Call LogAuditoria("01", OptLocal, Me.Caption, "", "Sistema: " & right(Cmb_Sistema.Text, 6) & " - Tipo operación: " & right(Cmb_Tipo_operacion.Text, 6) & " - Moneda 1: " & right(CmbMoneda1.Text, 6) & " - Moneda 2: " & right(CmbMoneda2.Text, 6) & " - Tipo movimiento: " & Cmb_Tipo_movimiento.Text)
           PROC_GRABA_PERFIL
           
           Screen.MousePointer = 0
           Cmb_Sistema.SetFocus

    Case 3
            'If Mid(Lbl_existe_perfil.Caption, 1, 1) <> "S" Then Exit Sub
            
            If MsgBox("Seguro de Eliminar Perfil ?", 36) = 6 Then
               PROC_ELIMINA_PERFIL
            End If
             
    Case 4
        Dim varsSist    As String
        Dim varsMov     As String
        Dim varsOper    As String
        Dim varsInstr   As String
        Dim varsMone    As String
        Dim cSql        As String
        Dim varNumeros  As Integer
        Dim varData()
        Dim varsMone2   As String
        
        varsSist = right(Cmb_Sistema.Text, 3)
        varsMov = Trim(right(Cmb_Tipo_movimiento.Text, 10))
        varsOper = Trim$(right(Cmb_Tipo_operacion.Text, 5))
        
        If Cmb_Control_Instrumento.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
           
           varsInstr = ""
        
        Else
           
           varsInstr = Trim(right(Cmb_Tipo_Instrumento.Text, 12))
        
        End If
        
        varsMone = CDbl(CmbMoneda1.ItemData(CmbMoneda1.ListIndex))
        varsMone2 = CDbl(CmbMoneda2.ItemData(CmbMoneda2.ListIndex))
        PROC_BUSCA_PERFIL CDbl(varNumeros), varsSist, varsOper, varsMov, varsMone, varsMone2, Trim(varsInstr)
        Screen.MousePointer = 0
            
        Frm_Perfil.Enabled = True
        Toolbar1.Buttons(5).Enabled = True
        Toolbar1.Buttons(4).Enabled = False
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = True
            
        Gr_perfil.Row = 1
        Gr_perfil.Col = C_CAMPO
        Gr_perfil.SetFocus
        SendKeys "^{HOME}"
        
    Case 5
        
        PROC_HABILITA_PV False
        Toolbar1.Buttons(3).Enabled = False
        Call Asigna_Datos
        SSPanel5.Visible = True
        
    Case 6
        Me.SSPanelFiltro.Visible = True
        
    Case 7
        Unload Me
    End Select
End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
    Case 1
        Gr_perfil.AddItem ""
        Gr_perfil.SetFocus
    Case 2
        Call Elimina_Fila_Detalle
        
    Case 3
        Gr_perfil.Col = C_PERFIL_FIJO
        Gr_perfil_DblClick
    End Select
End Sub

Private Sub Toolbar3_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
Case 1
    Gr_perfil_PV.AddItem ""
    Gr_perfil_PV.SetFocus
Case 2
    Gr_perfil_PV.RemoveItem Gr_perfil_PV.Row
    Gr_perfil_PV.AddItem ""
    Gr_perfil_PV.SetFocus
End Select
End Sub

Private Sub Toolbar5_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
Case 1
   Call Graba_Perfil_Variable

Case 2

    PROC_HABILITA_PV True
    
    SSPanel2.Visible = False
    
    PROC_MARCA_FILA_GRILLA Gr_perfil, G_COLOR_BLANCO, G_COLOR_NEGRO, Gr_perfil.Row, 0
    Gr_perfil.Redraw = True
    Gr_perfil.SetFocus
End Select

End Sub

Private Sub Toolbar6_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
   
      Case 1
              
              
            TxtGlosa_C.Text = Trim(left(CmbTipoOperacion_C, Len(CmbTipoOperacion_C) - 5))
            TxtGlosa_C.Text = TxtGlosa_C.Text & " " & Trim(left(CmbEvento_C, Len(CmbEvento_C) - 3))
            TxtGlosa_C.Text = TxtGlosa_C.Text + " " + Trim(Mid(CmbInstrumento_C.Text, 1, 15))
            TxtGlosa_C.Text = TxtGlosa_C.Text + " " + Trim(right(CmbMoneda1_C, 5)) + " " + Trim(right(CmbMoneda2_C, 5))

      
           If MsgBox("Seguro de Hacer copia de Perfil ?", 36) <> 6 Then Exit Sub
           
            Dim varsSist    As String
            Dim varsMov     As String
            Dim varsOper    As String
            Dim varsInstr   As String
            Dim varsMone    As String
            Dim cSql        As String
            Dim varNumeros  As Integer
            Dim varData()
            Dim varsMone2   As String
            
            varsSist = right(CmbSistema_C.Text, 3)
            varsMov = Trim(right(CmbEvento_C.Text, 10))
            varsOper = Trim$(right(CmbTipoOperacion_C.Text, 5))
            
            If Not CmbInstrumento_C.Enabled Then
               
               varsInstr = ""
            
            Else
               
               varsInstr = Trim(right(CmbInstrumento_C.Text, 12))
            
            End If
            
            varsMone = CDbl(CmbMoneda1_C.ItemData(CmbMoneda1_C.ListIndex))
            varsMone2 = CDbl(CmbMoneda2_C.ItemData(CmbMoneda2_C.ListIndex))
            PROC_BUSCA_PERFIL2 CDbl(varNumeros), varsSist, varsOper, varsMov, varsMone, varsMone2, Trim(varsInstr)
                       
           Screen.MousePointer = 11
           
           PROC_GRABA_PERFIL2
           
           Screen.MousePointer = 0
           SSPanel5.Visible = False
           Toolbar1.Buttons(3).Enabled = True
           PROC_HABILITA_PV True
             
      
      Case 2
            SSPanel5.Visible = False
            Toolbar1.Buttons(3).Enabled = True
            PROC_HABILITA_PV True
      
   End Select

End Sub

Private Sub Toolbar7_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
      Case 1
        Me.CmbSistema_F.Clear
        Me.CmbTipoOperacion_F.Clear
        Me.CmbMoneda1_F.Clear
        Me.CmbMoneda2_F.Clear
        Me.CmbEvento_F.Clear
        Me.CmbInstrumento_F.Clear
'        Me.Cmb_Sistema.SetFocus
      
      Case 2
         On Error GoTo Elpt
         Me.Imprime
         Call LogAuditoria("10", OptLocal, Me.Caption & " Informe de Saldos contables", "", "")
         Exit Sub
         
Elpt:
         MsgBox "Problemas Al Emitir Informe", vbExclamation
         Call LogAuditoria("10", OptLocal, " Informe de Saldos contables- Error al emitir informe", "", "")
      
      Case 3
        Me.SSPanelFiltro.Visible = False
    End Select
End Sub

Private Sub Txt_glosa_KeyPress(KeyAscii As Integer)

Txt_Glosa.MaxLength = 70
BacToUCase KeyAscii

' VB+- Se desabilita el paso a la grilla despues de la glosa del perfil

'If KeyAscii = 13 And Trim(Txt_glosa.Text) <> "" Then
'
'   Gr_perfil.Row = 1
'   Gr_perfil.Col = C_CAMPO
'   Gr_perfil.Enabled = True
'   Gr_perfil.SetFocus
'   SendKeys "{RIGHT}"
'   SendKeys "{LEFT}"
'
'End If

End Sub


Private Sub Txt_Ingreso_Campos_KeyPress(KeyAscii As Integer)

If KeyAscii = 27 Then
   Gr_perfil.SetFocus
   Exit Sub
End If


Select Case Gr_perfil.Col
       Case C_CAMPO:
            Txt_ingreso_campos.MaxLength = 3
            PROC_FMT_NUMERICO Txt_ingreso_campos, 3, 0, KeyAscii, "+"
       Case C_PERFIL_FIJO:
            Txt_ingreso_campos.MaxLength = 1
            BacToUCase KeyAscii
       Case C_TIPO_MOV:
            Txt_ingreso_campos.MaxLength = 1
            BacToUCase KeyAscii
       Case C_NCUENTA:
            Txt_ingreso_campos.MaxLength = 11
            BacToUCase KeyAscii
End Select

If KeyAscii = 13 And Trim(Txt_ingreso_campos.Text) <> "" Then

   If Not FUNC_VALIDA_INGRESO_FIJO() Then
      Txt_ingreso_campos.Text = ""
      Exit Sub
   End If
   
   Gr_perfil.SetFocus
   
End If

End Sub

Sub PROC_FMT_NUMERICO(texto As Control, NEnteros, NDecs As Integer, ByRef tecla, Signo As String)
Dim PosPto%

If tecla = 13 Or tecla = 27 Then Exit Sub

If tecla = 45 And Signo = "+" Then tecla = 0

If tecla <> 8 And (tecla < 48 Or tecla > 57) Then
   If NDecs = 0 Then
      tecla = 0
   ElseIf tecla <> 46 And tecla <> 45 Then
          tecla = 0
   End If
End If

If tecla = 45 And Signo = "-" Then  ' Signo negativo
   If InStr(texto.Text, "-") > 0 Then
      tecla = 0
   ElseIf texto.SelStart > 0 Then
          If Mid(texto.Text, texto.SelStart, 1) <> "" Then
             tecla = 0
          End If
   End If
End If

PosPto% = InStr(texto.Text, ".")
If PosPto% > 0 And tecla = 46 Then
   tecla = 0
   Exit Sub
End If

If NDecs > 0 And PosPto% > 0 And PosPto% <= texto.SelStart Then
   PosPto% = PosPto% + 1
   If Len(Mid(texto.Text, PosPto%, NDecs)) = NDecs And tecla <> 8 Then
      tecla = 0
   Else
      Exit Sub
   End If
End If

If PosPto% > 0 And texto.SelStart < PosPto% And tecla <> 8 Then
   If Len(Mid(texto.Text, 1, PosPto% - 1)) >= NEnteros Then tecla = 0
ElseIf PosPto% = 0 And tecla <> 8 And Chr(tecla) <> "." Then
       If Len(texto.Text) >= NEnteros Then tecla = 0
End If

End Sub



Private Sub Txt_Ingreso_Campos_LostFocus()

    Txt_ingreso_campos.Visible = False

End Sub
Private Sub Txt_ingreso_PV_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 27 Then
       Gr_perfil_PV.SetFocus
       Exit Sub
    
    End If
    
    Txt_ingreso_PV.MaxLength = 11
   
    BacToUCase KeyAscii
    
    If KeyAscii = 13 And Trim(Txt_ingreso_PV.Text) <> "" Then
    
       If Not FUNC_VALIDA_INGRESO_PV() Then
          Txt_ingreso_PV.Text = ""
          Exit Sub
       End If
    
       Gr_perfil_PV.SetFocus
       
    End If

End Sub


Private Sub Txt_ingreso_PV_LostFocus()
Txt_ingreso_PV.Visible = False
End Sub




Sub CargaCombos(xCombo As ComboBox, xOperacion As String)

   Select Case UCase(xOperacion)

      Case "OPERACION"
            
               xCombo.Clear
               If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Evento") Then
               
                  MsgBox "Problemas al Buscar Operación", vbExclamation
                  Exit Sub
               
               End If
               
               While BAC_SQL_FETCH(Datos())
            
                  xCombo.AddItem Datos(2) + Space(50) + Datos(1)
            
               Wend
                           
               xCombo.ListIndex = -1
               
      Case "PRODUCTO"
      
               xCombo.Clear
               Envia = Array()
               AddParam Envia, IIf(Cmb_Sistema.Enabled = True, Trim(right(Cmb_Sistema.Text, 3)), Trim(right(CmbSistema_C.Text, 3)))
               
               If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Producto", Envia) Then
               
                  MsgBox "Problemas al Buscar Producto", vbExclamation
                  Exit Sub
               
               End If
               
               While BAC_SQL_FETCH(Datos())
            
                  xCombo.AddItem Datos(2) + Space(50) + Datos(1)
            
               Wend
            
      Case "MONEDA"
            
               xCombo.Clear
               Envia = Array()
               AddParam Envia, IIf(Cmb_Tipo_operacion.Enabled = True, Trim(right(Cmb_Tipo_operacion, 6)), Trim(right(CmbTipoOperacion_C, 6)))
               
               If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Moneda", Envia) Then
               
                  MsgBox "Problemas al Buscar Moneda", vbExclamation
                  Exit Sub
               
               End If
               
               While BAC_SQL_FETCH(Datos())
            
                  xCombo.AddItem Datos(2) + Space(80) + Datos(2)
                  xCombo.ItemData(xCombo.NewIndex) = Datos(1)
            
               Wend
            
      Case "INSTRUMENTO"
            
               xCombo.Clear
               Envia = Array()
               AddParam Envia, IIf(Cmb_Sistema.Enabled = True, Trim(right(Cmb_Sistema.Text, 3)), Trim(right(CmbSistema_C.Text, 3)))
               
               If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Instrumento", Envia) Then
               
                  MsgBox "Problemas al Buscar Moneda", vbExclamation
                  Exit Sub
               
               End If
               
               While BAC_SQL_FETCH(Datos())
            
                  xCombo.AddItem Datos(2) + Space(80) + Datos(2)
                  xCombo.ItemData(xCombo.NewIndex) = Datos(1)
            
               Wend
   
   End Select

End Sub


Sub Busca_Combos()
Dim i As Integer

''''''''    SISTEMA
        For i = 0 To Cmb_Sistema.ListCount - 1

            Cmb_Sistema.ListIndex = i
            If right(Cmb_Sistema, 3) = varsSist Then Exit For

        Next i

''''''''    TIPO OPERACION
        For i = 0 To Cmb_Tipo_operacion.ListCount - 1

            Cmb_Tipo_operacion.ListIndex = i
            If Trim(right(Cmb_Tipo_operacion, 10)) = varsOper Then Exit For

        Next i

        Call Cmb_tipo_operacion_Click

''''''''    TIPO MOVIMIENTO
        For i = 0 To Cmb_Tipo_movimiento.ListCount - 1

            Cmb_Tipo_movimiento.ListIndex = i
            If Trim(right(Cmb_Tipo_movimiento, 10)) = varsMov Then Exit For

        Next i

        

''''''''    MONEDA1
        
        For i = 0 To CmbMoneda1.ListCount - 1

            
            If CmbMoneda1.ItemData(i) = varsMone Then
               CmbMoneda1.ListIndex = i
               Exit For
            End If
        Next i

''''''''    MONEDA2
        
        For i = 0 To CmbMoneda2.ListCount - 1

            If CmbMoneda2.ItemData(i) = varsMone2 Then
               CmbMoneda2.ListIndex = i
               Exit For
            End If
        Next i

''''''''    TIPO INSTRUMENTO
        For i = 0 To Cmb_Tipo_Instrumento.ListCount - 1

            Cmb_Tipo_Instrumento.ListIndex = i
            If Trim(right(Cmb_Tipo_Instrumento, 10)) = varsInstr Then Exit For

        Next i

''''''''    TIPO VOUCHER
        For i = 0 To Cmb_Tipo_Voucher.ListCount - 1
            
            Cmb_Tipo_Voucher.ListIndex = i
            If left(Cmb_Tipo_Voucher, 1) = varsTipVoucher Then Exit For

        Next i


End Sub


Sub Asigna_Datos()

   CmbSistema_C.Text = Cmb_Sistema.Text
   CmbSistema_C_Click
   CmbTipoOperacion_C.Text = Cmb_Tipo_operacion.Text
   CmbTipoOperacion_C_Click
   CmbMoneda1_C.Text = CmbMoneda1.Text
   CmbMoneda2_C.Text = CmbMoneda2.Text
   TxtGlosa_C.Text = Txt_Glosa.Text
   CmbEvento_C.Text = Cmb_Tipo_movimiento.Text
   CmbTipoVoucher_C.Text = Cmb_Tipo_Voucher.Text
   
   If CmbInstrumento_C.Enabled Then
   
      CmbInstrumento_C.Text = Cmb_Tipo_Instrumento.Text
   
   End If
   
End Sub

Sub PROC_GRABA_PERFIL2()
Dim Datos(), r%
Dim Error            As Integer
Dim Sistema          As String * 3
Dim Tipo_movimiento  As String * 3
Dim Tipo_Operacion   As String * 5
Dim crear_perfil     As String * 1
Dim folio            As String
Dim correlativo_perfil As String

Error = False

Screen.MousePointer = 11

Sistema = right(CmbSistema_C.Text, 3)
Tipo_movimiento = right(CmbEvento_C.Text, 3)
Tipo_Operacion = Trim(right(CmbTipoOperacion_C.Text, 5))

varsSist = right(CmbSistema_C.Text, 3)
varsMov = right(CmbEvento_C.Text, 3)
varsOper = Trim(right(CmbTipoOperacion_C.Text, 5))
varsInstr = IIf(Trim(right(CmbInstrumento_C.Text, 15)) <> "", Trim(right(CmbInstrumento_C.Text, 15)), "")
varsMone = Trim(CmbMoneda1_C.ItemData(CmbMoneda1_C.ListIndex))
varsMone2 = Trim(CmbMoneda2_C.ItemData(CmbMoneda2_C.ListIndex))
folio = Folio_Perfil2
correlativo_perfil = 0

Envia = Array()
AddParam Envia, Trim(varsSist)
AddParam Envia, Trim(varsOper)
AddParam Envia, Trim(varsMov)
AddParam Envia, CDbl(varsMone)
AddParam Envia, CDbl(varsMone2)
AddParam Envia, Trim(varsInstr)
AddParam Envia, CDbl(correlativo_perfil)
AddParam Envia, CDbl(Folio_Perfil2)


If Not BAC_SQL_EXECUTE("SP_ELIMINA_PERFIL_Saldos", Envia) Then
   Error = True
   GoTo END_Graba_Perfil:
End If

crear_perfil = "S"

For r% = 1 To Gr_perfil.Rows - 1

    Gr_perfil.Row = r%
    Gr_perfil.Col = C_CAMPO

    If Gr_perfil.Text = "" Then Exit For

    If CDbl(IIf(Gr_perfil.Text = "", 0, Gr_perfil.Text)) > 0 Then
     
       Envia = Array()
       AddParam Envia, crear_perfil
       AddParam Envia, Trim(right(CmbSistema_C.Text, 3))
       AddParam Envia, Trim(right(CmbTipoOperacion_C, 5))
       AddParam Envia, Trim(right(CmbEvento_C, 15))
       AddParam Envia, CmbMoneda1_C.ItemData(CmbMoneda1_C.ListIndex)
       AddParam Envia, CmbMoneda2_C.ItemData(CmbMoneda2_C.ListIndex)
       AddParam Envia, Trim(right(CmbInstrumento_C, 15))
       AddParam Envia, left(CmbTipoVoucher_C, 1)
       AddParam Envia, TxtGlosa_C
                
       AddParam Envia, Folio_Perfil2
       AddParam Envia, r%
       AddParam Envia, Val(TextMatrix(Gr_perfil, r%, C_CAMPO, "X"))
       AddParam Envia, TextMatrix(Gr_perfil, r%, C_TIPO_MOV, "X")
       AddParam Envia, TextMatrix(Gr_perfil, r%, C_PERFIL_FIJO, "X")
       AddParam Envia, TextMatrix(Gr_perfil, r%, C_NCUENTA, "X")
       
       crear_perfil = "N"
       
       If Not BAC_SQL_EXECUTE("Sp_Crea_Perfil_Saldos", Envia) Then
          Error = True
          Exit For
       End If
       
       If Mid(TextMatrix(Gr_perfil, r%, C_PERFIL_FIJO, "X"), 1, 1) = "N" Then
       
          
       End If
       
    End If
    
Next r%

       Envia = Array()
       AddParam Envia, Trim(right(CmbSistema_C.Text, 3))
       AddParam Envia, Trim(right(CmbTipoOperacion_C, 5))
       AddParam Envia, Trim(right(CmbEvento_C, 15))
       AddParam Envia, CmbMoneda1_C.ItemData(CmbMoneda1_C.ListIndex)
       AddParam Envia, CmbMoneda2_C.ItemData(CmbMoneda2_C.ListIndex)
       AddParam Envia, Trim(right(CmbInstrumento_C, 15))
                
       AddParam Envia, Folio_Perfil2
       
       If Not BAC_SQL_EXECUTE("Sp_Crea_Perfil_Variable_Copia_Saldos", Envia) Then
          Error = True
       End If
       

END_Graba_Perfil:

   
Screen.MousePointer = 0

If Not Error Then
   MsgBox "Perfil Grabado sin Problemas.", 64
Else
   MsgBox "Información NO Grabada.", 16
End If

End Sub


Sub PROC_BUSCA_PERFIL2(Numero As Long, varsSist, varsOper, varsMov, varsMone, varsMone2, varsInstr As String)
Dim Datos()
Dim Sql As String
Dim X As Integer
Screen.MousePointer = 11

    Envia = Array()
    AddParam Envia, Numero
    AddParam Envia, varsSist
    AddParam Envia, varsOper
    AddParam Envia, varsMov
    AddParam Envia, CDbl(varsMone)
    AddParam Envia, CDbl(varsMone2)
    AddParam Envia, varsInstr
    
    Lbl_existe_perfil.Caption = "N"
    If Not BAC_SQL_EXECUTE("Sp_Buscar_Perfiles_Copiar_Saldos ", Envia) Then
       Screen.MousePointer = 0
       Exit Sub
    End If

    If BAC_SQL_FETCH(Datos()) Then
       
       If Datos(1) = "NO HAY" Then
           
           Folio_Perfil2 = Datos(2)
            
            If CmbEvento_C <> "" Then
              
'''''''''''''              TxtGlosa_C.Text = Trim(Left(CmbTipoOperacion_C, Len(CmbTipoOperacion_C) - 5))
'''''''''''''              TxtGlosa_C.Text = TxtGlosa_C.Text & " " & Trim(Left(CmbEvento_C, Len(CmbEvento_C) - 3))
            
            Else
               
               MsgBox "No existen datos", vbCritical
               Screen.MousePointer = 0
               
               Exit Sub
            
            End If
       
       Else
          
'''''''''''''          TxtGlosa_C.Text = Trim(Datos(8))
          Folio_Perfil2 = Datos(9)
       
       End If
    
    End If

Screen.MousePointer = 0

PROC_HABILITA False

End Sub
    
Sub Graba_Perfil_Variable()

    Dim Sql As String
    Dim Datos()
    Dim X As Integer
    
    Screen.MousePointer = 11
    
    Gr_perfil_PV.Redraw = False
    
    If Not FUNC_VALIDA_INGRESO_PERFIL("PV") Then
       Screen.MousePointer = 0
       MsgBox "Falta Información del Perfil Variable.", vbExclamation
       Gr_perfil_PV.Redraw = True
       Exit Sub
    End If
    
    Envia = Array()
    AddParam Envia, Gr_Filas
    
    If Not BAC_SQL_EXECUTE("SP_BORRA_PERFIL_VARIABLE ", Envia) Then
       Screen.MousePointer = 0
       Gr_perfil_PV.Redraw = True
       Exit Sub
    End If
    
    
    For X = 1 To Gr_perfil_PV.Rows - 1
        If Trim(TextMatrix(Gr_perfil_PV, X, 1, "X")) <> "" Then
            Envia = Array()
            AddParam Envia, Gr_Filas
            AddParam Envia, Folio_Perfil
            AddParam Envia, TextMatrix(Gr_perfil_PV, X, 0, "X")
            AddParam Envia, TextMatrix(Gr_perfil_PV, X, 1, "X")
            AddParam Envia, TextMatrix(Gr_perfil_PV, X, 2, "X")
            AddParam Envia, CDbl(right(Cmb_Condiciones, 7))
            
            Gr_perfil.TextMatrix(Gr_perfil.Row, 6) = Gr_Filas2
            
            If Not BAC_SQL_EXECUTE("SP_GRABA_PERFIL_VARIABLE ", Envia) Then
               Screen.MousePointer = 0
               Gr_perfil_PV.Redraw = True
               Exit Sub
            End If
        End If
    Next
    
    
    Screen.MousePointer = 0
    
    Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_DESC_CUENTA, "PERFIL VARIABLE COMPLETO")
    'Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_CAMPO_VARIABLE, Trim(Right(Cmb_Condiciones.Text, 3)))
    
    PROC_HABILITA_PV True
    
    SSPanel2.Visible = False
    
    PROC_MARCA_FILA_GRILLA Gr_perfil, G_COLOR_BLANCO, G_COLOR_NEGRO, Gr_perfil.Row, 0
    Gr_perfil_PV.Redraw = True
    Gr_perfil.SetFocus

End Sub


Sub Elimina_Fila_Detalle()
Dim i As Integer
Dim X As Integer
On Error Resume Next
   With Gr_perfil
            
            
      Envia = Array()
      If .TextMatrix(.Row - 1, 7) <> "" Then
      AddParam Envia, CDbl(.TextMatrix(.Row, 7))
      Else
      .RemoveItem (.Row)
      Exit Sub
      End If
      If Not BAC_SQL_EXECUTE("Sp_Perfil_Contable_Elimina", Envia) Then
         
      End If
      Gr_perfil.RemoveItem Gr_perfil.Row
      Gr_perfil.AddItem ""
            
            
      For i = 1 To .Rows - 1
      
         If .TextMatrix(i, 7) = "" Then Exit Sub
      
         If .TextMatrix(i, 7) <> i Then
         
            Envia = Array()
            AddParam Envia, CDbl(.TextMatrix(i, 7))
            AddParam Envia, i
         
            If Not BAC_SQL_EXECUTE("Sp_Perfil_Contable_Actualiza_Paso", Envia) Then
         
            End If
            
            .TextMatrix(i, 7) = i
         
         End If
      
      Next i

   End With

   Gr_perfil.SetFocus

End Sub


Function FUNC_VALIDA_CAMPOV(Campo As String, FILTRO As String) As Boolean
Dim Datos()

   FUNC_VALIDA_CAMPOV = False
   
   Envia = Array()
   AddParam Envia, "GEN_TABLAS1"
   AddParam Envia, Trim(left(FILTRO, 45))
   AddParam Envia, Trim(right(FILTRO, 45))
   
   If Not BAC_SQL_EXECUTE("sp_consulta_tablas ", Envia) Then
      Exit Function
   End If
   
   
   While BAC_SQL_FETCH(Datos())
   
      If Campo = Datos(1) Then
         
         FUNC_VALIDA_CAMPOV = True
         Exit Function
         
      End If
   
   Wend

End Function


Sub CargaCombos2(xCombo As ComboBox, xOperacion As String)

   Select Case UCase(xOperacion)

      Case "OPERACION"
            
               xCombo.Clear
               If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Evento") Then
               
                  MsgBox "Problemas al Buscar Operación", vbExclamation
                  Exit Sub
               
               End If
               
               While BAC_SQL_FETCH(Datos())
            
                  xCombo.AddItem Datos(2) + Space(50) + Datos(1)
            
               Wend
                           
               xCombo.ListIndex = -1
               
      Case "PRODUCTO"
      
               xCombo.Clear
               Envia = Array()
               AddParam Envia, IIf(CmbSistema_F.Enabled = True, Trim(right(CmbSistema_F.Text, 3)), Trim(right(CmbSistema_C.Text, 3)))
               
               If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Producto", Envia) Then
               
                  MsgBox "Problemas al Buscar Producto", vbExclamation
                  Exit Sub
               
               End If
               
               While BAC_SQL_FETCH(Datos())
            
                  xCombo.AddItem Datos(2) + Space(50) + Datos(1)
            
               Wend
            
      Case "MONEDA"
            
               xCombo.Clear
               Envia = Array()
               AddParam Envia, IIf(CmbTipoOperacion_F.Enabled = True, Trim(right(CmbTipoOperacion_F, 6)), Trim(right(CmbTipoOperacion_C, 6)))
               
               If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Moneda", Envia) Then
               
                  MsgBox "Problemas al Buscar Moneda", vbExclamation
                  Exit Sub
               
               End If
               
               While BAC_SQL_FETCH(Datos())
            
                  xCombo.AddItem Datos(2) + Space(80) + Datos(2)
                  xCombo.ItemData(xCombo.NewIndex) = Datos(1)
            
               Wend
            
      Case "INSTRUMENTO"
            
               xCombo.Clear
               Envia = Array()
               AddParam Envia, IIf(CmbSistema_F.Enabled = True, Trim(right(CmbSistema_F.Text, 3)), Trim(right(CmbSistema_C.Text, 3)))
               
               If Not BAC_SQL_EXECUTE("Sp_BacMntCampos_Leer_Instrumento", Envia) Then
               
                  MsgBox "Problemas al Buscar Moneda", vbExclamation
                  Exit Sub
               
               End If
               
               While BAC_SQL_FETCH(Datos())
            
                  xCombo.AddItem Datos(2) + Space(80) + Datos(2)
                  xCombo.ItemData(xCombo.NewIndex) = Datos(1)
            
               Wend
   
   End Select

End Sub


