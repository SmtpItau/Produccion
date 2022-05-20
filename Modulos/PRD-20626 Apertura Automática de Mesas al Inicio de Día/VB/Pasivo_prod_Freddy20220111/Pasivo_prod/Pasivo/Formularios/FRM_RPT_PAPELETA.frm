VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_RPT_PAPELETA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Plataforma de Control"
   ClientHeight    =   5820
   ClientLeft      =   2010
   ClientTop       =   2145
   ClientWidth     =   10710
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
   Icon            =   "FRM_RPT_PAPELETA.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5820
   ScaleWidth      =   10710
   Begin Threed.SSPanel SPl_Ordenar 
      Height          =   3675
      Left            =   4020
      TabIndex        =   26
      Top             =   1500
      Visible         =   0   'False
      Width           =   2415
      _Version        =   65536
      _ExtentX        =   4260
      _ExtentY        =   6482
      _StockProps     =   15
      ForeColor       =   -2147483630
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
      Begin Threed.SSPanel SSPanel4 
         Height          =   2835
         Index           =   1
         Left            =   30
         TabIndex        =   27
         Top             =   780
         Width           =   2355
         _Version        =   65536
         _ExtentX        =   4154
         _ExtentY        =   5001
         _StockProps     =   15
         ForeColor       =   -2147483630
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
         Begin VB.OptionButton Opt_Desc 
            Caption         =   "Option2"
            Height          =   255
            Left            =   105
            TabIndex        =   45
            Top             =   2460
            Width           =   255
         End
         Begin VB.OptionButton Opt_Asc 
            Caption         =   "Option1"
            Height          =   210
            Left            =   105
            TabIndex        =   44
            Top             =   2130
            Width           =   255
         End
         Begin Threed.SSFrame SSFrame5 
            Height          =   2025
            Left            =   45
            TabIndex        =   28
            Top             =   15
            Width           =   2250
            _Version        =   65536
            _ExtentX        =   3969
            _ExtentY        =   3572
            _StockProps     =   14
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin VB.CheckBox Chk_FormaPago 
               Caption         =   "Check6"
               Height          =   375
               Left            =   105
               TabIndex        =   40
               Top             =   1530
               Width           =   255
            End
            Begin VB.CheckBox Chk_Operacion 
               Caption         =   "Check5"
               Height          =   255
               Left            =   105
               TabIndex        =   39
               Top             =   1245
               Width           =   255
            End
            Begin VB.CheckBox Chk_Moneda 
               Caption         =   "Check4"
               Height          =   255
               Left            =   105
               TabIndex        =   38
               Top             =   885
               Width           =   255
            End
            Begin VB.CheckBox Chk_Cliente 
               Caption         =   "Check3"
               Height          =   210
               Left            =   105
               TabIndex        =   37
               Top             =   585
               Width           =   255
            End
            Begin VB.CheckBox Chk_Producto 
               Caption         =   "Check2"
               Height          =   255
               Left            =   105
               TabIndex        =   36
               Top             =   210
               Width           =   255
            End
            Begin VB.Label LBL_Cliente 
               Caption         =   "Cliente"
               ForeColor       =   &H80000007&
               Height          =   315
               Left            =   555
               TabIndex        =   33
               Top             =   585
               Width           =   1650
            End
            Begin VB.Label LBL_Instrumento 
               Caption         =   "Producto"
               ForeColor       =   &H80000007&
               Height          =   315
               Left            =   555
               TabIndex        =   32
               Top             =   255
               Width           =   1650
            End
            Begin VB.Label LBL_Moneda 
               Caption         =   "Moneda"
               ForeColor       =   &H80000007&
               Height          =   315
               Index           =   5
               Left            =   555
               TabIndex        =   31
               Top             =   915
               Width           =   1410
            End
            Begin VB.Label LBL_Tipo_Operacion 
               Caption         =   "Tipo Operación"
               ForeColor       =   &H80000007&
               Height          =   315
               Index           =   4
               Left            =   555
               TabIndex        =   30
               Top             =   1260
               Width           =   1410
            End
            Begin VB.Label LBL_Forma_Pago 
               Caption         =   "Forma de Pago"
               ForeColor       =   &H80000007&
               Height          =   315
               Index           =   3
               Left            =   555
               TabIndex        =   29
               Top             =   1620
               Width           =   1410
            End
         End
         Begin VB.Label LBL_Descendente 
            Caption         =   "Descendente"
            Height          =   255
            Left            =   585
            TabIndex        =   43
            Top             =   2490
            Width           =   1335
         End
         Begin VB.Label LBL_Ascendente 
            Caption         =   "Ascendente"
            Height          =   255
            Left            =   585
            TabIndex        =   42
            Top             =   2130
            Width           =   1575
         End
      End
      Begin Threed.SSPanel SSPanel9 
         Height          =   300
         Left            =   45
         TabIndex        =   34
         Top             =   30
         Width           =   2320
         _Version        =   65536
         _ExtentX        =   4092
         _ExtentY        =   529
         _StockProps     =   15
         Caption         =   " Ordenar"
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
      Begin MSComctlLib.Toolbar TLB_Menu3 
         Height          =   450
         Left            =   30
         TabIndex        =   35
         Top             =   345
         Width           =   2320
         _ExtentX        =   4101
         _ExtentY        =   794
         ButtonWidth     =   820
         ButtonHeight    =   794
         AllowCustomize  =   0   'False
         Style           =   1
         ImageList       =   "Img_opciones"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   2
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Aceptar"
               Object.ToolTipText     =   "Aceptar"
               ImageIndex      =   6
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Cancelar"
               Object.ToolTipText     =   "Cancelar"
               ImageIndex      =   10
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSPanel SSP_Panel2 
      Height          =   3000
      Left            =   2550
      TabIndex        =   7
      Top             =   1605
      Visible         =   0   'False
      Width           =   5670
      _Version        =   65536
      _ExtentX        =   10001
      _ExtentY        =   5292
      _StockProps     =   15
      ForeColor       =   -2147483630
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
      Begin Threed.SSPanel SSPanel4 
         Height          =   2160
         Index           =   0
         Left            =   30
         TabIndex        =   8
         Top             =   780
         Width           =   5580
         _Version        =   65536
         _ExtentX        =   9842
         _ExtentY        =   3810
         _StockProps     =   15
         ForeColor       =   -2147483630
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
            Height          =   2070
            Left            =   45
            TabIndex        =   9
            Top             =   15
            Width           =   5505
            _Version        =   65536
            _ExtentX        =   9710
            _ExtentY        =   3651
            _StockProps     =   14
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin VB.ComboBox Cmb_FormaPago 
               Height          =   330
               Left            =   1725
               Style           =   2  'Dropdown List
               TabIndex        =   25
               Top             =   1650
               Width           =   3630
            End
            Begin VB.ComboBox Cmb_Moneda 
               Height          =   330
               Left            =   1725
               Style           =   2  'Dropdown List
               TabIndex        =   4
               Top             =   1320
               Width           =   3630
            End
            Begin VB.ComboBox Cmb_Producto 
               Height          =   330
               Left            =   1725
               Style           =   2  'Dropdown List
               TabIndex        =   2
               Top             =   660
               Width           =   3630
            End
            Begin VB.ComboBox Cmb_Cliente 
               Height          =   330
               Left            =   1725
               Style           =   2  'Dropdown List
               TabIndex        =   3
               Top             =   990
               Width           =   3630
            End
            Begin Threed.SSFrame SSFrame2 
               Height          =   495
               Left            =   75
               TabIndex        =   10
               Top             =   105
               Width           =   5370
               _Version        =   65536
               _ExtentX        =   9472
               _ExtentY        =   873
               _StockProps     =   14
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ShadowStyle     =   1
               Begin Threed.SSCheck SSCTodo 
                  Height          =   255
                  Left            =   90
                  TabIndex        =   1
                  Top             =   150
                  Width           =   2565
                  _Version        =   65536
                  _ExtentX        =   4524
                  _ExtentY        =   450
                  _StockProps     =   78
                  Caption         =   "Todo"
                  ForeColor       =   -2147483630
                  BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                     Name            =   "Arial"
                     Size            =   8.25
                     Charset         =   0
                     Weight          =   700
                     Underline       =   0   'False
                     Italic          =   0   'False
                     Strikethrough   =   0   'False
                  EndProperty
                  Value           =   -1  'True
               End
            End
            Begin VB.Label LBL_Forma_Pago 
               Caption         =   "Forma de Pago"
               ForeColor       =   &H80000007&
               Height          =   315
               Index           =   2
               Left            =   105
               TabIndex        =   24
               Top             =   1710
               Width           =   1410
            End
            Begin VB.Label LBL_Moneda 
               Caption         =   "Moneda"
               ForeColor       =   &H80000007&
               Height          =   315
               Index           =   0
               Left            =   90
               TabIndex        =   23
               Top             =   1350
               Width           =   1410
            End
            Begin VB.Label LBL_Producto 
               Caption         =   "Producto"
               ForeColor       =   &H80000007&
               Height          =   315
               Left            =   90
               TabIndex        =   12
               Top             =   690
               Width           =   1650
            End
            Begin VB.Label LBL_Moneda 
               Caption         =   "Cliente"
               ForeColor       =   &H80000007&
               Height          =   315
               Index           =   1
               Left            =   90
               TabIndex        =   11
               Top             =   1020
               Width           =   1650
            End
         End
      End
      Begin Threed.SSPanel SSPanel3 
         Height          =   330
         Left            =   60
         TabIndex        =   13
         Top             =   15
         Width           =   5535
         _Version        =   65536
         _ExtentX        =   9763
         _ExtentY        =   582
         _StockProps     =   15
         Caption         =   " Filtros"
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
      Begin MSComctlLib.Toolbar TLB_Menu4 
         Height          =   450
         Left            =   30
         TabIndex        =   14
         Top             =   330
         Width           =   5565
         _ExtentX        =   9816
         _ExtentY        =   794
         ButtonWidth     =   820
         ButtonHeight    =   794
         AllowCustomize  =   0   'False
         Style           =   1
         ImageList       =   "Img_opciones"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   2
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Aceptar"
               Object.ToolTipText     =   "Aceptar"
               ImageIndex      =   6
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Cancelar"
               Object.ToolTipText     =   "Cancelar"
               ImageIndex      =   10
            EndProperty
         EndProperty
      End
   End
   Begin MSFlexGridLib.MSFlexGrid GRD_Grilla 
      Height          =   4695
      Left            =   -15
      TabIndex        =   22
      TabStop         =   0   'False
      Top             =   1065
      Width           =   10725
      _ExtentX        =   18918
      _ExtentY        =   8281
      _Version        =   393216
      Cols            =   18
      FixedCols       =   0
      RowHeightMin    =   270
      BackColor       =   -2147483644
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   -2147483644
      FocusRect       =   0
      HighLight       =   2
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
   Begin MSFlexGridLib.MSFlexGrid GrdOperaciones 
      Height          =   1605
      Left            =   1305
      TabIndex        =   21
      Top             =   7665
      Visible         =   0   'False
      Width           =   2415
      _ExtentX        =   4260
      _ExtentY        =   2831
      _Version        =   393216
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
   Begin Threed.SSPanel SSPanel1 
      Height          =   5205
      Left            =   -15
      TabIndex        =   6
      Top             =   570
      Width           =   10710
      _Version        =   65536
      _ExtentX        =   18891
      _ExtentY        =   9181
      _StockProps     =   15
      ForeColor       =   -2147483630
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
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1395
         ScaleHeight     =   315
         ScaleWidth      =   345
         TabIndex        =   18
         Top             =   570
         Visible         =   0   'False
         Width           =   345
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   600
         ScaleHeight     =   315
         ScaleWidth      =   345
         TabIndex        =   17
         Top             =   570
         Visible         =   0   'False
         Width           =   345
      End
      Begin Threed.SSFrame SSF_Fecha 
         Height          =   510
         Left            =   15
         TabIndex        =   15
         Top             =   -15
         Width           =   10665
         _Version        =   65536
         _ExtentX        =   18812
         _ExtentY        =   900
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin BACControles.TXTFecha TXT_FECHA 
            Height          =   315
            Left            =   990
            TabIndex        =   0
            TabStop         =   0   'False
            Top             =   135
            Width           =   1485
            _ExtentX        =   2619
            _ExtentY        =   556
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   402133
            MinDate         =   18264
            Text            =   "30/07/2001"
         End
         Begin VB.Label LBL_Fecha 
            Caption         =   "Fecha "
            ForeColor       =   &H80000007&
            Height          =   270
            Left            =   195
            TabIndex        =   16
            Top             =   180
            Width           =   1050
         End
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla2 
         Height          =   1740
         Left            =   0
         TabIndex        =   19
         Top             =   1620
         Visible         =   0   'False
         Width           =   8385
         _ExtentX        =   14790
         _ExtentY        =   3069
         _Version        =   393216
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
      Begin MSComctlLib.ProgressBar Progreso 
         Height          =   345
         Left            =   15
         TabIndex        =   20
         Top             =   4815
         Width           =   10680
         _ExtentX        =   18838
         _ExtentY        =   609
         _Version        =   393216
         Appearance      =   1
         Scrolling       =   1
      End
   End
   Begin MSComctlLib.Toolbar TLB_Menu1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   10710
      _ExtentX        =   18891
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   8
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar Operaciones"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Description     =   "Imprimir"
            Object.ToolTipText     =   "Imprimir Operaciones"
            ImageIndex      =   17
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Pantalla"
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   18
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Anular"
            Object.ToolTipText     =   "Anular"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Filtrar"
            Object.ToolTipText     =   "Filtrar"
            ImageIndex      =   13
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Detalle"
            Object.ToolTipText     =   "Ver Detalle"
            ImageIndex      =   25
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Ordenar"
            Description     =   "Salir"
            Object.ToolTipText     =   "Ordenar"
            ImageIndex      =   22
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   9000
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   25
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_PAPELETA.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Label Label7 
      Caption         =   "Forma de Pago"
      ForeColor       =   &H80000007&
      Height          =   315
      Index           =   5
      Left            =   0
      TabIndex        =   41
      Top             =   0
      Width           =   1410
   End
End
Attribute VB_Name = "FRM_RPT_PAPELETA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cOptLocal           As String
Dim cTipo               As String
Dim cProducto           As String
Dim cprod               As String
Dim dCliente            As Double
Dim cSistema            As String
Dim nMoneda             As Double
Dim cOperacion          As String
Dim nFormaPago          As Double
Dim Fecha               As Date
Dim cColorOriginal      As String
Dim cSerie              As String

Dim cOrden              As String
Dim nOr_Producto        As String
Dim nOr_Cliente         As String
Dim nOr_Moneda          As String
Dim nOr_Operacion       As String
Dim nOr_FormaPago       As String
Dim nOr_Asc             As String


Dim cOpt_Local As String
Dim Datos()


Private Sub Cmb_Apo_1_Click()
   LblRut_Apo1.Caption = Trim(right(Cmb_Apo_1.Text, 15))
End Sub

Private Sub Cmb_Apo_2_Click()
   LblRut_Apo2.Caption = Trim(right(Cmb_Apo_2.Text, 15))
End Sub

Private Sub Cmb_Cliente_Click()
SSCTodo.Value = False
End Sub


Private Sub Cmb_FormaPago_Click()
SSCTodo.Value = False
End Sub


Private Sub Cmb_Moneda_Click()
SSCTodo.Value = False
End Sub


Private Sub Cmb_Operacion_Click()
SSCTodo.Value = False
End Sub


Private Sub Cmb_Producto_Click()
SSCTodo.Value = False
End Sub

Private Sub Cmb_Sistema_Click()
   SSCTodo.Value = False
   Cmb_Producto.Enabled = FUNC_CargaCombos("PRODUCTO", Trim(right(Cmb_Sistema, 5)), Cmb_Producto)
   Cmb_Cliente.Enabled = FUNC_CargaCombos("CLIENTES", Trim(right(Cmb_Sistema, 5)), Cmb_Cliente)
   CMB_Moneda.Enabled = FUNC_CargaCombos("MONEDA", Trim(right(Cmb_Sistema, 5)), CMB_Moneda)
   Cmb_FormaPago.Enabled = FUNC_CargaCombos("FORMAPAGO", Trim(right(Cmb_Sistema, 5)), Cmb_FormaPago)
   
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

   Opcion = 0
      
   On Error Resume Next
      
   If KeyCode = vbKeyReturn Then
      KeyCode = 0
      FUNC_ENVIA_TECLA (vbKeyTab)
      Exit Sub
   End If
   
   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
   
      Select Case KeyCode
      
         Case VbkeyAceptar:
                          
                           If SSP_Panel2.Visible Then
                              Call TLB_Menu4_ButtonClick(TLB_Menu4.Buttons(1))
                              KeyCode = 0
                              Exit Sub
                           End If
                           
                           
                           
                           GRD_Grilla.Enabled = True
               
                           If GRD_Grilla.Enabled Then
                              GRD_Grilla.SetFocus
                              
                           End If
         
                           KeyCode = 0
      
         Case vbKeyBuscar
           If TLB_Menu1.Buttons(1).Enabled Then
             Call TLB_Menu1_ButtonClick(TLB_Menu1.Buttons(1))

            End If

        Case VbKeyImprimir
            If TLB_Menu1.Buttons(2).Enabled Then
                Call TLB_Menu1_ButtonClick(TLB_Menu1.Buttons(2))
                KeyAscii = 0
                Exit Sub
            End If

        Case vbKeyVistaPrevia
            If TLB_Menu1.Buttons(3).Enabled Then
                Call TLB_Menu1_ButtonClick(TLB_Menu1.Buttons(3))
                KeyAscii = 0
                Exit Sub
            End If

        Case VbKeyAnular
            If TLB_Menu1.Buttons(4).Enabled Then
                Call TLB_Menu1_ButtonClick(TLB_Menu1.Buttons(4))
                KeyAscii = 0
            End If

        Case vbKeyFiltrar
            If TLB_Menu1.Buttons(5).Enabled Then
                Call TLB_Menu1_ButtonClick(TLB_Menu1.Buttons(5))
            End If

        Case VbKeyDetalle
            If TLB_Menu1.Buttons(6).Enabled Then
                Call TLB_Menu1_ButtonClick(TLB_Menu1.Buttons(6))
            End If

        Case vbkeyOrdenar
            If TLB_Menu1.Buttons(7).Enabled Then
                Call TLB_Menu1_ButtonClick(TLB_Menu1.Buttons(7))
            End If

        Case vbKeySalir
      
            If SSP_Panel2.Visible Then
                Call TLB_Menu4_ButtonClick(TLB_Menu4.Buttons(2))
                KeyAscii = 0
            
            Else
                Unload Me
            End If
      
      End Select
    End If
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   Case vbKeyBuscar
      If TLB_Menu1.Buttons(1).Enabled Then
         Call TLB_Menu1_ButtonClick(TLB_Menu1.Buttons(1))

      End If

   Case VbKeyImprimir
      If TLB_Menu1.Buttons(2).Enabled Then
         Call TLB_Menu1_ButtonClick(TLB_Menu1.Buttons(2))
         KeyAscii = 0
         Exit Sub
      End If

   Case vbKeyVistaPrevia
      If TLB_Menu1.Buttons(3).Enabled Then
         Call TLB_Menu1_ButtonClick(TLB_Menu1.Buttons(3))
         KeyAscii = 0
         Exit Sub
      End If

   Case VbKeyAnular
      If TLB_Menu1.Buttons(4).Enabled Then
         Call TLB_Menu1_ButtonClick(TLB_Menu1.Buttons(4))
         KeyAscii = 0

      End If

   Case vbKeyFiltrar
      If TLB_Menu1.Buttons(5).Enabled Then
         Call TLB_Menu1_ButtonClick(TLB_Menu1.Buttons(5))

      End If

   Case VbKeyDetalle
      If TLB_Menu1.Buttons(6).Enabled Then
         Call TLB_Menu1_ButtonClick(TLB_Menu1.Buttons(6))

      End If

   Case vbKeySalir
      
      If SSP_Panel2.Visible Then
         Call TLB_Menu4_ButtonClick(TLB_Menu4.Buttons(2))
         KeyAscii = 0
            
            
      Else
         Unload Me
      
      End If
      
      

   End Select

End Sub

Private Sub Form_Load()
   cOptLocal = cOpt
   
   cSistema = ""
   cProducto = ""
   dCliente = 0
   nMoneda = 0
   cOperacion = ""
   nFormaPago = 0
   cOrden = "N"
   nOr_Producto = 0
   nOr_Cliente = 0
   nOr_Moneda = 0
   nOr_Operacion = 0
   nOr_FormaPago = 0
   nOr_Asc = 0
      
   Me.Icon = FRM_MDI_PASIVO.Icon
   Me.top = 0
   Me.left = 0
   Txt_Fecha.MaxDate = GLB_Fecha_Proceso
   Txt_Fecha.Text = GLB_Fecha_Proceso
   cColorOriginal = GRD_Grilla.CellBackColor
   Fecha = GLB_Fecha_Proceso
    
   cOpt_Local = Opt
      
   Me.Icon = FRM_MDI_PASIVO.Icon
      
   
   Call PROC_DibujaGRD_Grilla
   'Call PROC_DibujaGRD_Grilla2
   Call PROC_LlenarGRD_Grilla

   PROC_LOG_AUDITORIA "07", cOpt_Local, Me.Caption, "", ""
   
End Sub


Sub PROC_Refrescar_GRD_Grilla()

   If Txt_Fecha.Text = gsBac_Fecp Then

      Fecha = Txt_Fecha.Text

      
      
   If GRD_Grilla.Rows <> GRD_Grilla2.Rows Then
   
         PROC_LLenaGRD_GrillaRefrech
        
   End If

   End If

End Sub

Sub PROC_LlenarGRD_Grilla()
   Dim Datos()
   Dim I        As Long
   Dim nColor1  As Long
   Dim nColor2  As Long
   Dim nColor3  As Long
   Dim Format_Decimal As String
   
   Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "N", nColor1, nColor2, True) '"A"
   
   GLB_Envia = Array()
   
   PROC_AGREGA_PARAMETRO GLB_Envia, cProducto
   PROC_AGREGA_PARAMETRO GLB_Envia, dCliente
   PROC_AGREGA_PARAMETRO GLB_Envia, nMoneda
   PROC_AGREGA_PARAMETRO GLB_Envia, cOperacion
   PROC_AGREGA_PARAMETRO GLB_Envia, nFormaPago
   PROC_AGREGA_PARAMETRO GLB_Envia, Fecha
   PROC_AGREGA_PARAMETRO GLB_Envia, cOrden
   PROC_AGREGA_PARAMETRO GLB_Envia, Val(nOr_Producto)
   PROC_AGREGA_PARAMETRO GLB_Envia, Val(nOr_Cliente)
   PROC_AGREGA_PARAMETRO GLB_Envia, Val(nOr_Moneda)
   PROC_AGREGA_PARAMETRO GLB_Envia, Val(nOr_Operacion)
   PROC_AGREGA_PARAMETRO GLB_Envia, Val(nOr_FormaPago)
   PROC_AGREGA_PARAMETRO GLB_Envia, Val(nOr_Asc)
        
   
   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_PAPELETAS", GLB_Envia) Then
      MsgBox "Problemas al leer datos de plataforma", vbCritical
      Exit Sub
   End If
   
   GRD_Grilla.Redraw = False
   GRD_Grilla.Col = 0
   GRD_Grilla.Rows = 2
   Do While FUNC_LEE_RETORNO_SQL(Datos())
      With GRD_Grilla
         .Rows = .Rows + 1
         .TextMatrix(.Rows - 1, 0) = ""
         
         .TextMatrix(.Rows - 1, 1) = IIf(IsNull(Datos(1)), "", Datos(1))
         .TextMatrix(.Rows - 1, 2) = Datos(22)
         .TextMatrix(.Rows - 1, 3) = Datos(2)
         .TextMatrix(.Rows - 1, 4) = Datos(3)
         .TextMatrix(.Rows - 1, 5) = Datos(4)
         .TextMatrix(.Rows - 1, 6) = IIf(IsNull(Datos(5)), "", Datos(5))
         .TextMatrix(.Rows - 1, 7) = IIf(IsNull(Datos(6)), "", Datos(6))
         
         'EBQ - 20041105
         '**************
         If Val(Datos(23)) = 0 Then
            Format_Decimal = "#,##0"
         Else
            Format_Decimal = "#,##0." & String(Datos(23), "0")
         End If
                  
         .TextMatrix(.Rows - 1, 8) = Format(Datos(7), Format_Decimal) 'FDecimal)
         .TextMatrix(.Rows - 1, 9) = Format(Datos(8), GLB_Formato_Entero) 'FDecimal)
         .TextMatrix(.Rows - 1, 10) = Format(Datos(9), GLB_Formato_Entero) 'FDecimal)
         .TextMatrix(.Rows - 1, 11) = Datos(10)
         .TextMatrix(.Rows - 1, 12) = Datos(11)
         .TextMatrix(.Rows - 1, 13) = Datos(12)
         .TextMatrix(.Rows - 1, 14) = Datos(13)
         .TextMatrix(.Rows - 1, 15) = Datos(14)
         
         .TextMatrix(.Rows - 1, 16) = Datos(15)
      
         .TextMatrix(.Rows - 1, 20) = IIf(Datos(17) = "S", "SI", "NO")
      
                  
         .TextMatrix(.Rows - 1, 19) = Datos(16)
         
         
         .Col = 0
         
         .Row = .Rows - 1
         .CellPictureAlignment = 3
         Set .CellPicture = SinCheck.Picture
         If .TextMatrix(.Rows - 1, 18) = "A" Then
         
            Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "A", nColor1, nColor2)
            'PintaCellAnulacion Amarillo, Rojo
            PROC_PintaCellAnulacion Str(nColor1), Str(nColor2)
         
         End If
         
         If .TextMatrix(.Rows - 1, 20) = "SI" Then
            
            Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "S", nColor1, nColor2)
            'PintaCellAnulacion Rojo, Blanco
            PROC_PintaCellAnulacion nColor1, nColor2
         
         End If
         
         If .TextMatrix(.Rows - 1, 20) = "SI" And .TextMatrix(.Rows - 1, 19) = "A" Then
            
            Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "E", nColor1, nColor2)
            nColor3 = nColor1
            Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "A", nColor1, nColor2)
            'PintaCellAnulacion Rojo, Amarillo
            PROC_PintaCellAnulacion nColor1, nColor3
            
         End If
         
         
      End With
   Loop
      
   GRD_Grilla.Col = 12
   GRD_Grilla.Redraw = True


   For I = 2 To GRD_Grilla.Rows - 1

      GRD_Grilla.TextMatrix(I, 0) = ""

   Next I
   
   GrdOperaciones.Rows = 0
   
   If GRD_Grilla.Rows > GRD_Grilla.FixedRows Then
      GRD_Grilla.Enabled = True
   
   Else
      GRD_Grilla.Enabled = False
   
   End If

   TLB_Menu1.Buttons(2).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(3).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(4).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(6).Enabled = GRD_Grilla.Enabled


End Sub

Sub PROC_LLenaGRD_GrillaRefrech()
Dim Datos()
Dim X, I As Integer
Dim nColor1 As Long
Dim nColor2 As Long
Dim nColor3 As Long
Dim Format_Decimal As String
   GRD_Grilla.Enabled = False
   
   GLB_Envia = Array()
   
   PROC_AGREGA_PARAMETRO GLB_Envia, cProducto
   PROC_AGREGA_PARAMETRO GLB_Envia, dCliente
   PROC_AGREGA_PARAMETRO GLB_Envia, nMoneda
   PROC_AGREGA_PARAMETRO GLB_Envia, cOperacion
   PROC_AGREGA_PARAMETRO GLB_Envia, nFormaPago
   PROC_AGREGA_PARAMETRO GLB_Envia, Fecha
   PROC_AGREGA_PARAMETRO GLB_Envia, cOrden
   PROC_AGREGA_PARAMETRO GLB_Envia, Val(nOr_Producto)
   PROC_AGREGA_PARAMETRO GLB_Envia, Val(nOr_Cliente)
   PROC_AGREGA_PARAMETRO GLB_Envia, Val(nOr_Moneda)
   PROC_AGREGA_PARAMETRO GLB_Envia, Val(nOr_Operacion)
   PROC_AGREGA_PARAMETRO GLB_Envia, Val(nOr_FormaPago)
   PROC_AGREGA_PARAMETRO GLB_Envia, Val(nOr_Asc)
   
   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_PAPELETAS", GLB_Envia) Then
      MsgBox "Problemas al leer datos de plataforma", vbCritical
      Exit Sub
   End If
   
   GRD_Grilla.Redraw = False
   GRD_Grilla.Col = 0
   GRD_Grilla.Rows = 2
   Do While FUNC_LEE_RETORNO_SQL(Datos())
      With GRD_Grilla
         GRD_Grilla.Enabled = True
         .Rows = .Rows + 1
         .TextMatrix(.Rows - 1, 0) = ""
         .TextMatrix(.Rows - 1, 1) = IIf(IsNull(Datos(1)), "", Datos(1))
         .TextMatrix(.Rows - 1, 2) = Datos(22)
         .TextMatrix(.Rows - 1, 3) = Datos(2)
         .TextMatrix(.Rows - 1, 4) = Datos(3)
         .TextMatrix(.Rows - 1, 5) = Datos(4)
         .TextMatrix(.Rows - 1, 6) = IIf(IsNull(Datos(5)), "", Datos(5))
         .TextMatrix(.Rows - 1, 7) = IIf(IsNull(Datos(6)), "", Datos(6))
         
         'EBQ - 20041105
         '**************
         If Val(Datos(23)) = 0 Then
            Format_Decimal = "#,##0"
         Else
            Format_Decimal = "#,##0." & String(Datos(23), "0")
         End If
         
         .TextMatrix(.Rows - 1, 8) = Format(Datos(7), Format_Decimal) 'FDecimal)
         .TextMatrix(.Rows - 1, 9) = Format(Datos(8), GLB_Formato_Entero) 'FDecimal)
         .TextMatrix(.Rows - 1, 10) = Format(Datos(9), GLB_Formato_Entero) 'FDecimal)
         .TextMatrix(.Rows - 1, 11) = Datos(10)
         .TextMatrix(.Rows - 1, 12) = Datos(11)
         .TextMatrix(.Rows - 1, 13) = Datos(12)
         .TextMatrix(.Rows - 1, 14) = Datos(13)
         .TextMatrix(.Rows - 1, 15) = Datos(14)
      
         .TextMatrix(.Rows - 1, 16) = Datos(15)
         
         .TextMatrix(.Rows - 1, 20) = IIf(Datos(17) = "S", "SI", "NO")
         
         
         .TextMatrix(.Rows - 1, 19) = Datos(16)
         
         .Col = 0
         .Row = .Rows - 1
         .CellPictureAlignment = 4
         Set .CellPicture = SinCheck.Picture
         If .TextMatrix(.Rows - 1, 19) = "A" Then
         
            Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "A", nColor1, nColor2)
            'PintaCellAnulacion Amarillo, Rojo
            PROC_PintaCellAnulacion nColor1, nColor2
         
         End If
         
         If .TextMatrix(.Rows - 1, 20) = "SI" Then
         
            Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "E", nColor1, nColor2)
            'PintaCellAnulacion Rojo, Blanco
            PROC_PintaCellAnulacion nColor1, nColor2
            
         End If
         
         If .TextMatrix(.Rows - 1, 20) = "SI" And .TextMatrix(.Rows - 1, 19) = "A" Then
         
            Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "A", nColor1, nColor2)
            nColor3 = nColor1
            Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "E", nColor1, nColor2)
            'PintaCellAnulacion Rojo, Amarillo
            PROC_PintaCellAnulacion nColor1, nColor3
         
         End If
         
         
      End With
   Loop
      
   
   GRD_Grilla.Col = 12
   GRD_Grilla.Redraw = True

   TLB_Menu1.Buttons(2).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(3).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(4).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(6).Enabled = GRD_Grilla.Enabled


End Sub




Sub PROC_DibujaGRD_Grilla()
   With GRD_Grilla
      .Rows = 3
      .Cols = 21
      .FixedRows = 2
      .FixedCols = 0
      .FixedCols = 1
      
      .TextMatrix(0, 0) = "Selección"
      .TextMatrix(0, 1) = "Tipo":   .TextMatrix(1, 1) = "Producto":
      .TextMatrix(0, 2) = "Tipo":   .TextMatrix(1, 2) = "Operacion":
      .TextMatrix(0, 3) = "Número": .TextMatrix(1, 3) = "Operación":
      .TextMatrix(0, 4) = "Tipo":   .TextMatrix(1, 4) = "Operación":
      .TextMatrix(0, 5) = "Fecha":  .TextMatrix(1, 5) = "Vcto.":
      .TextMatrix(0, 6) = "Nombre": .TextMatrix(1, 6) = "Cliente":
      .TextMatrix(0, 7) = "Moneda": .TextMatrix(1, 7) = "Operación":
      .TextMatrix(0, 8) = "Nominal":  .TextMatrix(1, 8) = "":
      .TextMatrix(0, 9) = "Precio": .TextMatrix(1, 9) = "":
      .TextMatrix(0, 10) = "Monto": .TextMatrix(1, 10) = "en Pesos":
      .TextMatrix(0, 11) = "Forma": .TextMatrix(1, 11) = "Pago Recibimos":
      .TextMatrix(0, 12) = "Forma": .TextMatrix(1, 12) = "Pago Entregamos":
      .TextMatrix(0, 13) = "Id_Sistema"
      .TextMatrix(0, 14) = "Producto"
      .TextMatrix(0, 15) = "Cartera"
      .TextMatrix(0, 16) = "PRODUCTO"
      .TextMatrix(0, 17) = "Apoderado1"
      .TextMatrix(0, 18) = "Apoderado2"
      .TextMatrix(0, 19) = "Operacion"
      .TextMatrix(0, 20) = "Impreso"
   
      .ColAlignment(5) = 2
      
      .ColWidth(0) = 0
      .ColWidth(1) = 4500
      .ColWidth(2) = 1500
      .ColWidth(3) = 1000
      .ColWidth(4) = 2000
      .ColWidth(5) = 0 '1000
      .ColWidth(6) = 3500
      .ColWidth(7) = 1200
      .ColWidth(8) = 2000
      .ColWidth(9) = 0
      .ColWidth(10) = 2200
      .ColWidth(11) = 2800
      .ColWidth(12) = 0
      .ColWidth(13) = 0
      .ColWidth(14) = 0
      .ColWidth(15) = 0
      .ColWidth(16) = 0
      .ColWidth(17) = 0
      .ColWidth(18) = 0
      .ColWidth(19) = 0
      .ColWidth(20) = 0
      
      .Rows = 2
      
   End With
   
   GrdOperaciones.Cols = 2
   GrdOperaciones.Rows = 0

End Sub


Private Sub Form_Unload(Cancel As Integer)
  PROC_LOG_AUDITORIA "08", cOpt_Local, Me.Caption, "", ""
End Sub


Private Sub GRD_Grilla_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeySpace Then
   
      GRD_Grilla_Click
   
   End If

End Sub


Private Sub SSCTodo_Click(Value As Integer)

   If SSCTodo.Value Then
   
      Cmb_Producto.ListIndex = -1
      Cmb_Cliente.ListIndex = -1
      CMB_Moneda.ListIndex = -1
      Cmb_FormaPago.ListIndex = -1
      
      SSCTodo.Value = True
      
   End If

End Sub

Private Sub TLB_Menu1_ButtonClick(ByVal Button As MSComctlLib.Button)

If SPl_Ordenar.Visible = True Or SSP_Panel2.Visible = True Then
    Exit Sub
End If

Screen.MousePointer = 11
DoEvents
Select Case Button.Index
    Case 1
        TXT_FECHA_CloseUp
        Call PROC_LlenarGRD_Grilla
    Case 2
        Call PROC_Imprime(False)
    Case 3
        Call PROC_Imprime(True)

    Case 5
        If SPl_Ordenar.Visible = False Then
            Txt_Fecha.Enabled = False
            Call PROC_Carga_Combos_Todos
            Call PROC_Filtro
        End If
    Case 6
        FRM_PLATAFORMA_RECHAZADOS.Show
    Case 7
        If SSP_Panel2.Visible = False Then
            Txt_Fecha.Enabled = False
            SPl_Ordenar.Visible = True
            Opt_Asc.Value = True
            Chk_Producto.Value = 1
        End If
        
    Case 8
        Unload Me
        Screen.MousePointer = 0
        Exit Sub
End Select
Screen.MousePointer = 0

End Sub

Sub PROC_Imprime(Pantalla As Boolean)
Dim numoperacion As Long
Dim cSistema2 As String
Dim I As Integer
Dim J As Integer
Dim cTipo As String

      'FRM_MDI_PASIVO.TmrMsg.Enabled = False
      With GRD_Grilla
         .Height = 4305
         Progreso.Max = .Rows - 1

         For I = 2 To .Rows - 1
            If I > .Rows - 1 Then Exit Sub
            If Trim(.TextMatrix(I, 0)) = "X" Then
               cSistema2 = GRD_Grilla.TextMatrix(I, 1)
               numoperacion = 0
               cTipo = GRD_Grilla.TextMatrix(I, 2)
                numoperacion = CDbl(GRD_Grilla.TextMatrix(I, 3))
               
                PROC_Leer_Datos_Plataforma numoperacion, Pantalla, cTipo
               
               Progreso.Value = I
               .TextMatrix(I, 0) = "                       "
            End If

         Next I
        .Height = 4665
        Progreso.Value = 0
      End With
      'FRM_MDI_PASIVO.TmrMsg.Enabled = True
  

End Sub

Sub PROC_Filtro()
   SSP_Panel2.Visible = True
   GRD_Grilla.Enabled = False
   TLB_Menu1.Buttons(2).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(3).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(4).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(6).Enabled = GRD_Grilla.Enabled
   
   'Cmb_Producto.SetFocus
   
End Sub

Function FUNC_CargaCombos(cTipo, cSistema As String, xCombo As ComboBox) As Boolean

   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, cTipo
   PROC_AGREGA_PARAMETRO GLB_Envia, cSistema
   PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha, "YYYYMMDD")
   
   FUNC_CargaCombos = FUNC_EXECUTA_COMANDO_SQL("SP_CON_COMBOS_PAPELETAS", GLB_Envia)
       If Not FUNC_CargaCombos Then
      MsgBox "Problemas en la Obtención de Datos", vbExclamation
      Exit Function
   End If

   xCombo.Clear
   While FUNC_LEE_RETORNO_SQL(Datos())
      xCombo.AddItem Datos(2) + Space(80) + Datos(1)
   Wend
End Function

Sub PROC_Leer_Datos_Plataforma(Num As Long, Pantalla As Boolean, cTipo As String)
   Dim vDatos_Retorno()
   Dim nNumope As String
   Dim cEstado As String
   Dim cprod   As String
   
   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, Num
   PROC_AGREGA_PARAMETRO GLB_Envia, Format(Txt_Fecha.Text, "YYYYMMDD")
   
   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_DATOS_PAPELETA", GLB_Envia) Then
      
      MsgBox "Problemas al leer datos de plataforma", vbCritical
      Exit Sub
   
   End If
   
   If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
      
      nNumope = vDatos_Retorno(2)
      cprod = vDatos_Retorno(1)
      cEstado = vDatos_Retorno(3)
      
   End If
   
  If cTipo = "INGRESO" Or cTipo = "GIRO" Or cTipo = "AMORTIZACION" Then
   
      PROC_Impresion_Papeletas_Pasivo nNumope, cprod, Pantalla
   Else
      PROC_Impresion_Papeletas_ven nNumope, cprod, Pantalla
   End If

End Sub





Private Sub GRD_Grilla_Click()
Dim Col     As Integer
Dim I       As Integer
Dim nColor1 As Long
Dim nColor2 As Long


If SPl_Ordenar.Visible = True Or SSP_Panel2.Visible = True Then
    GRD_Grilla.Enabled = False
    Exit Sub
End If
   
   With GRD_Grilla
      GrdOperaciones.Rows = GrdOperaciones.Rows + 1
   
         If .TextMatrix(.Row, 0) <> "X" Then
           GRD_Grilla.Enabled = False
           Txt_Fecha.Enabled = False

           GRD_Grilla.Enabled = True
           TLB_Menu1.Buttons(2).Enabled = GRD_Grilla.Enabled
           TLB_Menu1.Buttons(3).Enabled = GRD_Grilla.Enabled
           TLB_Menu1.Buttons(4).Enabled = GRD_Grilla.Enabled
           TLB_Menu1.Buttons(6).Enabled = GRD_Grilla.Enabled

         End If
   
   If .Rows > 2 Then
      Col = .Col
      .Col = 0
      .CellPictureAlignment = 4
   
      If Trim(.TextMatrix(.Row, 0)) = "" Then

         If .TextMatrix(.Row, 18) = "A" Then
            Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "A", nColor1, nColor2)
            'PintaCellAnulacion Celeste, Rojo
            PROC_PintaCellAnulacion nColor1, nColor2
         Else
            Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "E", nColor1, nColor2)
            'PintaCellAnulacion Celeste, AzulOsc
            PROC_PintaCellAnulacion nColor1, nColor2
         End If
         
         
         .Col = 0
         .TextMatrix(.Row, 0) = "                      X"
         Set .CellPicture = ConCheck.Picture
         
         GrdOperaciones.TextMatrix(GrdOperaciones.Rows - 1, 0) = .TextMatrix(.Row, 2)
         GrdOperaciones.TextMatrix(GrdOperaciones.Rows - 1, 1) = .TextMatrix(.Row, 12)
   
      Else
         
              
            If .TextMatrix(.Row, 18) = "A" Then
            
               Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "A", nColor1, nColor2)
               'PintaCellAnulacion Amarillo, Rojo
                PROC_PintaCellAnulacion nColor1, nColor2
                
            Else
                
               Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "N", nColor1, nColor2)
               'PintaCellAnulacion cColorOriginal, AzulOsc
               'PROC_PintaCellAnulacion nColor1, nColor2
               
               'MODIFICACION PARA EFECTOS DE COLORES - ERBAQ: 20041006
               '******************************************************
                PROC_PintaCellAnulacion .BackColor, .ForeColor
                If .TextMatrix(.Row, 19) = "A" Then
                
                   Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "A", nColor1, nColor2)
                   'PintaCellAnulacion Amarillo, Rojo
                   PROC_PintaCellAnulacion nColor1, nColor2
                
                End If
                
                If .TextMatrix(.Row, 20) = "SI" Then
                
                   Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "S", nColor1, nColor2)
                   'PintaCellAnulacion Rojo, Blanco
                   PROC_PintaCellAnulacion nColor1, nColor2
                   
                End If
                
                If .TextMatrix(.Row, 20) = "SI" And .TextMatrix(.Rows - 1, 19) = "A" Then
                
                   Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "A", nColor1, nColor2)
                   nColor3 = nColor1
                   Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "E", nColor1, nColor2)
                   'PintaCellAnulacion Rojo, Amarillo
                   PROC_PintaCellAnulacion nColor1, nColor3
                
                End If
               
                .TextMatrix(.Row, 0) = "                       "
               
               'FIN MODIFICACION PARA EFECTOS DE COLORES - ERBAQ: 20041006
               '**********************************************************
               

            End If

            If .TextMatrix(.Row, 18) = "A" And .TextMatrix(.Row, 19) = "SI" Then
               Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "A", nColor1, nColor2)
               'PintaCellAnulacion Rojo, Amarillo
               PROC_PintaCellAnulacion nColor1, nColor2
            ElseIf .TextMatrix(.Row, 19) = "SI" Then
               Call FUNC_BUSCAR_COLOR_ESTADO(GLB_Usuario, "E", nColor1, nColor2)
               'PintaCellAnulacion Rojo, Blanco
               PROC_PintaCellAnulacion nColor1, nColor2
            End If

            .Col = 0
            .TextMatrix(.Row, 0) = ""
            
            Set .CellPicture = SinCheck.Picture
            GrdOperaciones.Rows = .Rows
            
'            For I = 0 To GrdOperaciones.Rows - 1
'
'               For X = 0 To GrdOperaciones.Rows - 1
'
'                     If GrdOperaciones.TextMatrix(X, 0) = .TextMatrix(.Row, 2) And GrdOperaciones.TextMatrix(X, 2) = .TextMatrix(.Row, 12) Then
'
'                     If X = 0 And GrdOperaciones.Rows = 1 Then
'                        GrdOperaciones.Rows = 0
'                        Exit For
'
'                     End If
'                     GrdOperaciones.RemoveItem (X)
'                     Exit For
'
'                  End If
'
'               Next X
'
'            Next I
   
   
      End If
      
      .Col = Col
      
      If .Col = 1 Then
      
         .ColSel = .Cols - 1
         
      End If
      
   
   
      For I = 0 To GrdOperaciones.Rows - 1
   
         For X = 0 To GrdOperaciones.Rows - 1
      
            If GrdOperaciones.TextMatrix(X, 0) = "" Then
            
               If X = 0 And GrdOperaciones.Rows = 1 Then
                  GrdOperaciones.Rows = 0
                  Exit For
               
               End If
            
               GrdOperaciones.RemoveItem (X)
               Exit For
            
            End If
         
         Next X
      
      Next I
   
   End If
   
   End With

End Sub




Private Sub TLB_Menu2_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Key)
   
      Case "ACEPTAR"
      
              
              GRD_Grilla.TextMatrix(GRD_Grilla.Row, 17) = LblRut_Apo1
              GRD_Grilla.TextMatrix(GRD_Grilla.Row, 18) = LblRut_Apo2
              If GRD_Grilla.TextMatrix(GRD_Grilla.Row, 17) = "0" Or GRD_Grilla.TextMatrix(GRD_Grilla.Row, 18) = "0" Then
                  
                  GRD_Grilla_Click
                  
              End If
      Txt_Fecha.Enabled = True
              
      Case "CANCELAR"
              If GRD_Grilla.TextMatrix(GRD_Grilla.Row, 17) = "" Or GRD_Grilla.TextMatrix(GRD_Grilla.Row, 18) = "" Then
                  GRD_Grilla_Click
              End If
              
              If GRD_Grilla.TextMatrix(GRD_Grilla.Row, 17) = "0" Or GRD_Grilla.TextMatrix(GRD_Grilla.Row, 18) = "0" Then
                  GRD_Grilla_Click
              End If
        
   End Select

   GRD_Grilla.Enabled = True

   If GRD_Grilla.Rows > GRD_Grilla.FixedRows Then
      GRD_Grilla.Enabled = True
      GRD_Grilla.SetFocus
   
   Else
      GRD_Grilla.Enabled = False
   
      End If

   TLB_Menu1.Buttons(2).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(3).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(4).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(6).Enabled = GRD_Grilla.Enabled
   Txt_Fecha.Enabled = True

End Sub
Private Sub TLB_Menu3_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Key)
    Case "ACEPTAR"
        Call PROC_Cargar_Orden
        Txt_Fecha.Enabled = True
    Case "CANCELAR"
    SPl_Ordenar.Visible = False
    Txt_Fecha.Enabled = True
End Select
End Sub

Private Sub TLB_Menu4_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Key)

         Case "ACEPTAR"
               
               cProducto = Trim(right(Cmb_Producto.Text, 5))
               Cmb_Producto.Tag = Cmb_Producto.Text
               
               dCliente = CDbl(IIf(Trim(right(Cmb_Cliente.Text, 10)) = "", 0, Trim(right(Cmb_Cliente.Text, 10))))
               Cmb_Cliente.Tag = Cmb_Cliente.Text
               
               nMoneda = Val(Trim(right(CMB_Moneda.Text, 5)))
               CMB_Moneda.Tag = CMB_Moneda.Text
               
               nFormaPago = Val(Trim(right(Cmb_FormaPago.Text, 5)))
               Cmb_FormaPago.Tag = Cmb_FormaPago.Text
               
               SSCTodo.Tag = SSCTodo.Value
               
               If cSistema = "BTR" Then
                     GRD_Grilla.TextMatrix(0, 11) = "Forma Pago": GRD_Grilla.TextMatrix(1, 11) = "Inicial":
                     GRD_Grilla.TextMatrix(0, 12) = "Forma Pago": GRD_Grilla.TextMatrix(1, 12) = "Vencimiento":
               Else
                     GRD_Grilla.TextMatrix(0, 11) = "Forma": GRD_Grilla.TextMatrix(1, 11) = "Pago Recibimos":
                     GRD_Grilla.TextMatrix(0, 12) = "Forma": GRD_Grilla.TextMatrix(1, 12) = "Pago Entregamos":
               End If
               
               Call PROC_LLenaGRD_GrillaRefrech
               Txt_Fecha.Enabled = True
         Case "CANCELAR"

               If Cmb_Producto.Tag <> "" Then Cmb_Producto.Text = Cmb_Producto.Tag
               If Cmb_Cliente.Tag <> "" Then Cmb_Cliente.Text = Cmb_Cliente.Tag
               
               SSCTodo.Value = IIf(SSCTodo.Tag = "Verdadero", True, False)
               Txt_Fecha.Enabled = True
   End Select

   SSP_Panel2.Visible = False

   If GRD_Grilla.Rows > GRD_Grilla.FixedRows Then
      GRD_Grilla.Enabled = True
      GRD_Grilla.Col = 1
      GRD_Grilla.TopRow = 2
      GRD_Grilla.LeftCol = 1
      GRD_Grilla.Row = 2
      GRD_Grilla.SetFocus
   
   Else
      GRD_Grilla.Enabled = False
   
   End If

   TLB_Menu1.Buttons(2).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(3).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(4).Enabled = GRD_Grilla.Enabled
   TLB_Menu1.Buttons(6).Enabled = GRD_Grilla.Enabled

End Sub

Private Sub TXT_FECHA_CloseUp()

   If Txt_Fecha.Text > GLB_Fecha_Proceso Then

      MsgBox "La Fecha debe ser Menor o Igual a la Fecha de Proceso", vbInformation
      Txt_Fecha.Text = Txt_Fecha.Tag
      Txt_Fecha.SetFocus
   
   Else
      
      Fecha = Txt_Fecha.Text
   
   End If

End Sub

Private Sub TXT_FECHA_GotFocus()

   Txt_Fecha.Tag = Txt_Fecha.Text

End Sub

Private Sub TXT_FECHA_LostFocus()

   TXT_FECHA_CloseUp

End Sub

Sub PROC_PintaCellAnulacion(Color, Color2)
Dim I As Integer
Dim X As Integer
   
   With GRD_Grilla
      For I = 1 To .Cols - 1
         
         .Col = I
         .CellForeColor = Color2
         .CellBackColor = Color
         
      Next I
            
      .Col = 1
      
   End With

End Sub


Sub PROC_Carga_Combos_Todos()

Cmb_Producto.Enabled = FUNC_CargaCombos("PRODUCTO_ALL", "ALL", Cmb_Producto)
Cmb_Cliente.Enabled = FUNC_CargaCombos("CLIENTE_ALL", "ALL", Cmb_Cliente)
CMB_Moneda.Enabled = FUNC_CargaCombos("MONEDA_ALL", "ALL", CMB_Moneda)
Cmb_FormaPago.Enabled = FUNC_CargaCombos("FORMAPAGO_ALL", "ALL", Cmb_FormaPago)

End Sub

Sub PROC_Cargar_Orden()
cOrden = "S"
nOr_Producto = IIf(Chk_Producto.Value = 1, 1, 0)
nOr_Cliente = IIf(Chk_Cliente.Value = 1, 1, 0)
nOr_Moneda = IIf(Chk_Moneda.Value = 1, 1, 0)
nOr_Operacion = IIf(Chk_Operacion.Value = 1, 1, 0)
nOr_FormaPago = IIf(Chk_FormaPago.Value = 1, 1, 0)

If nOr_Producto = 0 And nOr_Cliente = 0 And nOr_Moneda = 0 And nOr_Operacion = 0 And nOr_FormaPago = 0 Then
    cOrden = "N"
    SPl_Ordenar.Visible = False
Else
    nOr_Asc = IIf(Me.Opt_Asc = True, 1, 0)
    Call PROC_LLenaGRD_GrillaRefrech
    SPl_Ordenar.Visible = False
End If
End Sub


Sub PROC_Impresion_Papeletas_Pasivo(numoper1 As String, cprod As String, Pantalla As Boolean)
On Error GoTo Err_Impre
Dim Papeleta  As String
Dim nColor1 As Long
Dim nColor2 As Long

   Call PROC_LIMPIAR_CRISTAL
   
   If cprod = UCase("CORFO") Then
      Papeleta = "RPT_PAPELETAS_CREDITO.Rpt"
   ElseIf cprod = UCase("BONOS") Or cprod = UCase("LETRA") Or cprod = UCase("DPF") Or cprod = UCase("DPR") Then
      Papeleta = "RPT_PAPELETAS_BONO.Rpt"
   ElseIf cprod = UCase("SGIRO") Then
      Papeleta = "RPT_PAPELETAS_SOBREGIRO.Rpt"
   Else
      Papeleta = "RPT_PAPELETAS_BANCO.Rpt"
   End If


   If cprod = "" Then
      GRD_Grilla.Redraw = True
      MsgBox "Esta Operación no Posee Informe", vbInformation
      Exit Sub
   End If
   
   PROC_PintaCellAnulacion 255, 16777215
   GRD_Grilla.TextMatrix(GRD_Grilla.Row, 20) = "SI"
   
   FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & Papeleta
   PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
   FRM_MDI_PASIVO.Pasivo_Rpt.Destination = IIf(Pantalla, crptToWindow, crptToPrinter)
   FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = CDbl(numoper1)
   FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
   FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
   FRM_MDI_PASIVO.Pasivo_Rpt.DiscardSavedData = True
   FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
   
   
   Exit Sub
Err_Impre:
   MsgBox "Problemas al Emitir el Informe" & vbCrLf & vbCrLf & Err.Description, vbExclamation
End Sub


Sub PROC_Impresion_Papeletas_ven(numoper1 As String, cprod As String, Pantalla As Boolean)
On Error GoTo Err_Impre
Dim Papeleta  As String

   Call PROC_LIMPIAR_CRISTAL
   
   If cprod = UCase("CORFO") Then
      Papeleta = "RPT_PAP_VEN_CREDITOS.Rpt"
   ElseIf cprod = UCase("BONOS") Then
      Papeleta = "RPT_PAPELETA_PASIVO_BONO_VEN.Rpt"
   Else
      Papeleta = "RPT_PAP_VEN_CREDITOS.Rpt"
   End If

   Papeleta = "RPT_PAPELETAS_VENCIMIENTO.Rpt"

   If cprod = "" Then
      GRD_Grilla.Redraw = True
      MsgBox "Esta Operación no Posee Informe", vbInformation
      Exit Sub
   End If

   If cprod = "" Then
      GRD_Grilla.Redraw = True
      MsgBox "Esta Operación no Posee Informe", vbInformation
      Exit Sub
   End If
   
   PROC_PintaCellAnulacion 255, 16777215
   GRD_Grilla.TextMatrix(GRD_Grilla.Row, 20) = "SI"
   
   FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & Papeleta
   PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
   FRM_MDI_PASIVO.Pasivo_Rpt.Destination = IIf(Pantalla, crptToWindow, crptToPrinter)
   FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = CDbl(numoper1)
   FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = Format(Me.Txt_Fecha.Text, "YYYYMMDD")
   FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
   FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
   FRM_MDI_PASIVO.Pasivo_Rpt.DiscardSavedData = True
   FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
   
  
   Exit Sub
Err_Impre:
   MsgBox "Problemas al Emitir el Informe" & vbCrLf & vbCrLf & Err.Description, vbExclamation
End Sub
