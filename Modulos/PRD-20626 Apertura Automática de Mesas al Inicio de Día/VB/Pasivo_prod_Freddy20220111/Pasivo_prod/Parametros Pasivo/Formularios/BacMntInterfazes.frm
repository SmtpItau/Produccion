VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form BacMntInterfazes 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Interfaces"
   ClientHeight    =   4995
   ClientLeft      =   1545
   ClientTop       =   2520
   ClientWidth     =   9675
   Icon            =   "BacMntInterfazes.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4995
   ScaleWidth      =   9675
   Begin Threed.SSPanel pnl_Detalle 
      Height          =   4410
      Left            =   1230
      TabIndex        =   8
      Top             =   210
      Visible         =   0   'False
      Width           =   6750
      _Version        =   65536
      _ExtentX        =   11906
      _ExtentY        =   7779
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.Frame Frame1 
         Height          =   3585
         Left            =   90
         TabIndex        =   10
         Top             =   795
         Width           =   6570
         Begin VB.Frame Frame2 
            Caption         =   "Validaciones"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   1500
            Left            =   90
            TabIndex        =   43
            Top             =   2025
            Width           =   6390
            Begin VB.CheckBox ChKMensual 
               Caption         =   "Interfaz Mensual"
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
               Left            =   3600
               TabIndex        =   45
               Top             =   240
               Width           =   1815
            End
            Begin VB.TextBox txt_Dias 
               Height          =   285
               Left            =   3585
               TabIndex        =   33
               Top             =   570
               Width           =   2655
            End
            Begin VB.OptionButton opt_Valida 
               Caption         =   "Especificar los dias en los cuales se trasmitira la interfaz"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   465
               Index           =   1
               Left            =   90
               TabIndex        =   32
               Top             =   510
               Width           =   3180
            End
            Begin VB.OptionButton opt_Valida 
               Caption         =   "Generacion de Interfaz Diariamente"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   240
               Index           =   0
               Left            =   90
               TabIndex        =   31
               Top             =   255
               Value           =   -1  'True
               Width           =   3600
            End
            Begin VB.Label Label2 
               Caption         =   "NOTA: ingrese los dias separados por comas EJ: 12,16 o 99 = ultimo dia del mes"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   435
               Left            =   120
               TabIndex        =   44
               Top             =   1020
               Width           =   6135
            End
         End
         Begin VB.TextBox txt_FileFin 
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
            Left            =   1785
            TabIndex        =   23
            Top             =   1680
            Width           =   1380
         End
         Begin VB.TextBox txt_FileIni 
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
            Left            =   1815
            MousePointer    =   14  'Arrow and Question
            TabIndex        =   14
            Top             =   1050
            Width           =   1380
         End
         Begin VB.TextBox txt_PathFin 
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
            IMEMode         =   3  'DISABLE
            Left            =   60
            MousePointer    =   14  'Arrow and Question
            TabIndex        =   21
            Top             =   1680
            Width           =   1725
         End
         Begin VB.TextBox txt_PathIni 
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
            Left            =   75
            MousePointer    =   14  'Arrow and Question
            TabIndex        =   13
            Top             =   1050
            Width           =   1725
         End
         Begin VB.ComboBox box_Casilla 
            Appearance      =   0  'Flat
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
            ItemData        =   "BacMntInterfazes.frx":2EFA
            Left            =   75
            List            =   "BacMntInterfazes.frx":2EFC
            Style           =   2  'Dropdown List
            TabIndex        =   12
            Top             =   405
            Width           =   3165
         End
         Begin VB.TextBox txt_FijoIni 
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
            Left            =   3210
            TabIndex        =   15
            ToolTipText     =   "Texto fijo del archivo"
            Top             =   1050
            Width           =   600
         End
         Begin VB.TextBox txt_FechaIni 
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
            Left            =   3825
            TabIndex        =   16
            ToolTipText     =   "Formato de fecha que contendra el archivo; Ej. ddmm, yyyymmdd"
            Top             =   1050
            Width           =   600
         End
         Begin VB.TextBox txt_ExtIni 
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
            Left            =   4440
            TabIndex        =   17
            ToolTipText     =   "extencion del archivo, sin punto"
            Top             =   1050
            Width           =   600
         End
         Begin VB.TextBox txt_FijoFin 
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
            Left            =   3195
            TabIndex        =   25
            ToolTipText     =   "Texto fijo del archivo"
            Top             =   1680
            Width           =   600
         End
         Begin VB.TextBox txt_FechaFin 
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
            Left            =   3810
            TabIndex        =   27
            ToolTipText     =   "Formato de fecha que contendra el archivo; Ej. ddmm, yyyymmdd"
            Top             =   1680
            Width           =   600
         End
         Begin VB.TextBox txt_ExtFin 
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
            Left            =   4425
            TabIndex        =   29
            ToolTipText     =   "extencion del archivo, sin punto"
            Top             =   1680
            Width           =   600
         End
         Begin Threed.SSFrame SSFrame5 
            Height          =   615
            Left            =   5130
            TabIndex        =   19
            Top             =   750
            Width           =   1335
            _Version        =   65536
            _ExtentX        =   2355
            _ExtentY        =   1085
            _StockProps     =   14
            Caption         =   "Nemotecnico"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin VB.OptionButton Opt_Ini 
               Caption         =   "Si"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   240
               Index           =   0
               Left            =   135
               TabIndex        =   20
               Top             =   330
               Width           =   465
            End
            Begin VB.OptionButton Opt_Ini 
               Caption         =   "No"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   240
               Index           =   1
               Left            =   675
               TabIndex        =   18
               Top             =   330
               Value           =   -1  'True
               Width           =   525
            End
         End
         Begin Threed.SSPanel SSPanel9 
            Height          =   300
            Left            =   75
            TabIndex        =   22
            Top             =   800
            Width           =   1245
            _Version        =   65536
            _ExtentX        =   2196
            _ExtentY        =   529
            _StockProps     =   15
            Caption         =   "Path de Inicio"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelWidth      =   0
            BorderWidth     =   0
            BevelOuter      =   0
         End
         Begin Threed.SSPanel SSPanel10 
            Height          =   300
            Left            =   75
            TabIndex        =   24
            Top             =   1410
            Width           =   1245
            _Version        =   65536
            _ExtentX        =   2196
            _ExtentY        =   529
            _StockProps     =   15
            Caption         =   "Path Destino"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelWidth      =   0
            BorderWidth     =   0
            BevelOuter      =   0
         End
         Begin Threed.SSPanel SSPanel11 
            Height          =   300
            Left            =   1920
            TabIndex        =   26
            Top             =   800
            Width           =   1380
            _Version        =   65536
            _ExtentX        =   2434
            _ExtentY        =   529
            _StockProps     =   15
            Caption         =   "Archivo"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelWidth      =   0
            BorderWidth     =   0
            BevelOuter      =   0
         End
         Begin Threed.SSPanel SSPanel12 
            Height          =   300
            Left            =   1920
            TabIndex        =   28
            Top             =   1410
            Width           =   1365
            _Version        =   65536
            _ExtentX        =   2408
            _ExtentY        =   529
            _StockProps     =   15
            Caption         =   "Archivo"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelWidth      =   0
            BorderWidth     =   0
            BevelOuter      =   0
         End
         Begin Threed.SSPanel p2_Nomotecnico 
            Height          =   300
            Index           =   0
            Left            =   3285
            TabIndex        =   34
            Top             =   800
            Width           =   420
            _Version        =   65536
            _ExtentX        =   741
            _ExtentY        =   529
            _StockProps     =   15
            Caption         =   "Fijo"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelWidth      =   0
            BorderWidth     =   0
            BevelOuter      =   0
         End
         Begin Threed.SSFrame SSFrame6 
            Height          =   615
            Left            =   5130
            TabIndex        =   30
            Top             =   1380
            Width           =   1335
            _Version        =   65536
            _ExtentX        =   2355
            _ExtentY        =   1085
            _StockProps     =   14
            Caption         =   "Nemotecnico"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin VB.OptionButton opt_Fin 
               Caption         =   "Si"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   240
               Index           =   0
               Left            =   120
               TabIndex        =   36
               Top             =   330
               Width           =   465
            End
            Begin VB.OptionButton opt_Fin 
               Caption         =   "No"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   240
               Index           =   1
               Left            =   660
               TabIndex        =   35
               Top             =   330
               Value           =   -1  'True
               Width           =   525
            End
         End
         Begin Threed.SSPanel SSPanel14 
            Height          =   300
            Left            =   135
            TabIndex        =   37
            Top             =   165
            Width           =   1365
            _Version        =   65536
            _ExtentX        =   2408
            _ExtentY        =   529
            _StockProps     =   15
            Caption         =   "Casilla Ftp"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelWidth      =   0
            BorderWidth     =   0
            BevelOuter      =   0
            Alignment       =   0
         End
         Begin Threed.SSPanel p2_Nomotecnico 
            Height          =   300
            Index           =   1
            Left            =   3900
            TabIndex        =   38
            Top             =   800
            Width           =   480
            _Version        =   65536
            _ExtentX        =   847
            _ExtentY        =   529
            _StockProps     =   15
            Caption         =   "Fecha"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelWidth      =   0
            BorderWidth     =   0
            BevelOuter      =   0
         End
         Begin Threed.SSPanel p2_Nomotecnico 
            Height          =   300
            Index           =   2
            Left            =   4560
            TabIndex        =   39
            Top             =   800
            Width           =   420
            _Version        =   65536
            _ExtentX        =   741
            _ExtentY        =   529
            _StockProps     =   15
            Caption         =   "Ext"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelWidth      =   0
            BorderWidth     =   0
            BevelOuter      =   0
         End
         Begin Threed.SSPanel p2_Nomotecnico 
            Height          =   300
            Index           =   3
            Left            =   3270
            TabIndex        =   40
            Top             =   1410
            Width           =   420
            _Version        =   65536
            _ExtentX        =   741
            _ExtentY        =   529
            _StockProps     =   15
            Caption         =   "Fijo"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelWidth      =   0
            BorderWidth     =   0
            BevelOuter      =   0
         End
         Begin Threed.SSPanel p2_Nomotecnico 
            Height          =   300
            Index           =   4
            Left            =   3900
            TabIndex        =   41
            Top             =   1410
            Width           =   480
            _Version        =   65536
            _ExtentX        =   847
            _ExtentY        =   529
            _StockProps     =   15
            Caption         =   "Fecha"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelWidth      =   0
            BorderWidth     =   0
            BevelOuter      =   0
         End
         Begin Threed.SSPanel p2_Nomotecnico 
            Height          =   300
            Index           =   5
            Left            =   4545
            TabIndex        =   42
            Top             =   1410
            Width           =   420
            _Version        =   65536
            _ExtentX        =   741
            _ExtentY        =   529
            _StockProps     =   15
            Caption         =   "Ext"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelWidth      =   0
            BorderWidth     =   0
            BevelOuter      =   0
         End
      End
      Begin MSComctlLib.Toolbar Toolbar2 
         Height          =   450
         Left            =   30
         TabIndex        =   11
         Top             =   315
         Width           =   6675
         _ExtentX        =   11774
         _ExtentY        =   794
         ButtonWidth     =   820
         ButtonHeight    =   794
         Style           =   1
         ImageList       =   "Img_opciones"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   2
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Aceptar"
               Object.ToolTipText     =   "Aceptar"
               ImageIndex      =   11
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Salir"
               Object.ToolTipText     =   "Salir"
               ImageIndex      =   2
            EndProperty
         EndProperty
         Begin MSComDlg.CommonDialog dlg_Rutas 
            Left            =   5250
            Top             =   90
            _ExtentX        =   847
            _ExtentY        =   847
            _Version        =   393216
         End
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Detalle de Interfaz"
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
         Height          =   315
         Left            =   45
         TabIndex        =   9
         Top             =   15
         Width           =   6645
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   3135
      Left            =   105
      TabIndex        =   4
      Top             =   1755
      Width           =   9495
      _Version        =   65536
      _ExtentX        =   16748
      _ExtentY        =   5530
      _StockProps     =   14
      Caption         =   "Detalles"
      ForeColor       =   -2147483641
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   1
      Begin VSFlex8LCtl.VSFlexGrid Grilla 
         Height          =   2835
         Left            =   45
         TabIndex        =   7
         Top             =   255
         Width           =   9390
         _cx             =   16563
         _cy             =   5001
         Appearance      =   1
         BorderStyle     =   1
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
         MousePointer    =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   -2147483635
         ForeColorSel    =   -2147483634
         BackColorBkg    =   -2147483636
         BackColorAlternate=   -2147483644
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483632
         TreeColor       =   -2147483632
         FloodColor      =   192
         SheetBorder     =   -2147483642
         FocusRect       =   1
         HighLight       =   1
         AllowSelection  =   -1  'True
         AllowBigSelection=   -1  'True
         AllowUserResizing=   0
         SelectionMode   =   0
         GridLines       =   2
         GridLinesFixed  =   0
         GridLineWidth   =   1
         Rows            =   2
         Cols            =   5
         FixedRows       =   1
         FixedCols       =   0
         RowHeightMin    =   0
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   0   'False
         FormatString    =   $"BacMntInterfazes.frx":2EFE
         ScrollTrack     =   0   'False
         ScrollBars      =   3
         ScrollTips      =   0   'False
         MergeCells      =   0
         MergeCompare    =   0
         AutoResize      =   -1  'True
         AutoSizeMode    =   0
         AutoSearch      =   0
         AutoSearchDelay =   2
         MultiTotals     =   -1  'True
         SubtotalPosition=   1
         OutlineBar      =   0
         OutlineCol      =   0
         Ellipsis        =   0
         ExplorerBar     =   0
         PicturesOver    =   0   'False
         FillStyle       =   0
         RightToLeft     =   0   'False
         PictureType     =   0
         TabBehavior     =   0
         OwnerDraw       =   0
         Editable        =   2
         ShowComboButton =   1
         WordWrap        =   0   'False
         TextStyle       =   0
         TextStyleFixed  =   0
         OleDragMode     =   0
         OleDropMode     =   0
         ComboSearch     =   3
         AutoSizeMouse   =   -1  'True
         FrozenRows      =   0
         FrozenCols      =   0
         AllowUserFreezing=   0
         BackColorFrozen =   0
         ForeColorFrozen =   0
         WallPaperAlignment=   9
         AccessibleName  =   ""
         AccessibleDescription=   ""
         AccessibleValue =   ""
         AccessibleRole  =   24
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   4470
      Left            =   30
      TabIndex        =   3
      Top             =   480
      Width           =   9645
      _Version        =   65536
      _ExtentX        =   17013
      _ExtentY        =   7885
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
      Begin Threed.SSFrame SSFrame4 
         Height          =   525
         Left            =   90
         TabIndex        =   6
         Top             =   660
         Width           =   4425
         _Version        =   65536
         _ExtentX        =   7805
         _ExtentY        =   926
         _StockProps     =   14
         Caption         =   "Módulo"
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
         Begin VB.ComboBox CmbSistema 
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
            Left            =   870
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   150
            Width           =   3465
         End
      End
      Begin Threed.SSFrame SSFrame3 
         Height          =   525
         Left            =   90
         TabIndex        =   5
         Top             =   120
         Width           =   4425
         _Version        =   65536
         _ExtentX        =   7805
         _ExtentY        =   926
         _StockProps     =   14
         Caption         =   "Entidad"
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
         Begin VB.ComboBox CmbEntidad 
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
            Left            =   870
            Style           =   2  'Dropdown List
            TabIndex        =   0
            Top             =   150
            Width           =   3465
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   9675
      _ExtentX        =   17066
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Detalle"
            Object.ToolTipText     =   "Ver Detalle"
            ImageIndex      =   12
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   8610
         Top             =   -120
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   12
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntInterfazes.frx":2F78
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntInterfazes.frx":33DF
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntInterfazes.frx":38D5
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntInterfazes.frx":3D68
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntInterfazes.frx":4250
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntInterfazes.frx":4763
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntInterfazes.frx":4C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntInterfazes.frx":50FC
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntInterfazes.frx":55F3
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntInterfazes.frx":59EC
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntInterfazes.frx":5DE2
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntInterfazes.frx":631F
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacMntInterfazes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim OptLocal                  As String
Dim Sistema                   As String
Dim Area                      As String
Dim codigo                    As String
Dim tipo                      As String
Dim Descripcion               As String
Dim ruta                      As String
Dim Rut_Entidad               As Double
Dim Nombre                    As String
Dim cartera                   As String
Dim CodigoInter               As String
Dim Fil                       As Integer
Dim Col                       As Integer
Dim ShellPath                 As String
Public xentidad               As Integer
Dim cCodigo                   As String
Dim nIndice                   As Integer
Dim cCodigo_anterior          As String
'--------------------------------------------------------------------------------------
'   Muestra un diálogo de buscar carpetas y devuelve el path a la carpeta escogida
'   o una cadena vacía si la operación se canceló. Nótese que este procedimiento sólo
'   devuelve carpetas del sistema de ficheros, no carpetas virtuales como Mi Ordenador o
'   el Panel de Control
'--------------------------------------------------------------------------------------
Public Function BrowseForFolder(ByVal f_HWnd As Long, _
                                Optional lpTitle As Variant) As String


   On Error Resume Next
   
   Dim lpiidl As Long, lResult As Long
   Dim lpbi As BROWSEINFO
   Dim lpszBuf As String
   Dim lpszNameSpace As String
   
   lpszBuf = String$(255, Chr$(0))
   lpszNameSpace = String$(255, Chr$(0))
   
   With lpbi
   
       .hWndOwner = f_HWnd
       .pidlRoot = vbNullString
       .lpszTitle = lpTitle
       .pszDisplayName = lpszBuf
       .uFlags = BIF_RETURNONLYFSDIRS
       .lpfn = vbNullString
       .lParam = 0&
       .iImage = 0&
       
   End With
   
   lpiidl = SHBrowseForFolder(lpbi)
   
   If lpiidl = 0 Then
      BrowseForFolder = ""
      Exit Function
   End If
      lResult = SHGetPathFromIDList(lpiidl, lpszNameSpace)
   If lResult = 1 Then
      BrowseForFolder = left$(lpszNameSpace, InStr(lpszNameSpace, Chr$(0)))
      BrowseForFolder = Replace(BrowseForFolder, Chr(0), "")
      
      If Mid(BrowseForFolder, Len(BrowseForFolder), 1) <> "\" Then
      
         BrowseForFolder = BrowseForFolder & "\"
      
      End If
      
   End If

End Function





Function FUNC_VALIDAR(bTipo As Boolean) As Boolean

FUNC_VALIDAR = True

If bTipo Then

    If Len(txt_PathIni) = 0 Then
            MsgBox "Debe ingresar Path de Inicio", vbExclamation
            FUNC_VALIDAR = False
    ElseIf Len(txt_FileIni) = 0 And Len(txt_FijoIni) = 0 Then
            MsgBox "Debe ingresar nombre de Archivo Inicio", vbExclamation
            FUNC_VALIDAR = False
    ElseIf IIf(Not Len(txt_FijoIni) = 0, Len(txt_FechaIni) = 0 Or Len(txt_ExtIni) = 0, False) Then
            MsgBox "Si elijio Nemotecnico, debe ingresar Fijo, Fecha y Extencion Inicial", vbExclamation
            FUNC_VALIDAR = False
    ElseIf Len(txt_PathFin) = 0 And box_Casilla <> "LOCAL" Then
            MsgBox "Debe ingresar Path Final", vbExclamation
            FUNC_VALIDAR = False
    ElseIf Len(txt_FileFin) = 0 And Len(txt_FijoFin) = 0 And box_Casilla <> "LOCAL" Then
            MsgBox "Debe ingresar nombre de Archivo Final", vbExclamation
            FUNC_VALIDAR = False
    ElseIf IIf(Not Len(txt_FijoFin) = 0, (Len(txt_FechaFin) = 0 Or Len(txt_ExtFin) = 0) And box_Casilla <> "LOCAL", False) Then
            MsgBox "Si elijio Nemotecnico, debe ingresar Fijo, Fecha y Extencion Final", vbExclamation
            FUNC_VALIDAR = False
    End If
    
Else

    If Len(grilla.TextMatrix(grilla.Row, 12)) = 0 Then
            MsgBox "Debe ingresar Path de Inicio", vbExclamation
            FUNC_VALIDAR = False
    ElseIf Len(grilla.TextMatrix(grilla.Row, 13)) = 0 And Len(grilla.TextMatrix(grilla.Row, 14)) = 0 Then
            MsgBox "Debe ingresar nombre de Archivo Inicio", vbExclamation
            FUNC_VALIDAR = False
    ElseIf IIf(Not Len(grilla.TextMatrix(grilla.Row, 14)) = 0, Len(grilla.TextMatrix(grilla.Row, 15)) = 0 Or Len(grilla.TextMatrix(grilla.Row, 16)) = 0, False) Then
            MsgBox "Si elijio Nemotecnico, debe ingresar Fijo, Fecha y Extencion Inicial", vbExclamation
            FUNC_VALIDAR = False
    ElseIf Len(grilla.TextMatrix(grilla.Row, 17)) = 0 And grilla.TextMatrix(grilla.Row, 10) <> "LOCAL" Then
            MsgBox "Debe ingresar Path Final", vbExclamation
            FUNC_VALIDAR = False
    ElseIf Len(grilla.TextMatrix(grilla.Row, 18)) = 0 And Len(grilla.TextMatrix(grilla.Row, 19)) = 0 And grilla.TextMatrix(grilla.Row, 10) <> "LOCAL" Then
            MsgBox "Debe ingresar nombre de Archivo Final", vbExclamation
            FUNC_VALIDAR = False
    ElseIf IIf(Not Len(grilla.TextMatrix(grilla.Row, 19)) = 0, (Len(grilla.TextMatrix(grilla.Row, 20)) = 0 Or Len(grilla.TextMatrix(grilla.Row, 21)) = 0) And grilla.TextMatrix(grilla.Row, 10) <> "LOCAL", False) Then
            MsgBox "Si elijio Nemotecnico, debe ingresar Fijo, Fecha y Extencion Final", vbExclamation
            FUNC_VALIDAR = False
    End If
    
End If

End Function

Private Sub box_Casilla_Change()
Dim vInfo()

    Call Llenar_Combo_Casilla(box_Casilla.Text, vInfo)
    
    If Len(vInfo(0)) <> 0 Then
        txt_PathFin.Text = vInfo(4)
    End If

    txt_PathFin.Enabled = (Not box_Casilla.Text = "LOCAL")
    txt_FileFin.Enabled = (Not box_Casilla.Text = "LOCAL")
    txt_FijoFin.Enabled = (Not box_Casilla.Text = "LOCAL")
    txt_FechaFin.Enabled = (Not box_Casilla.Text = "LOCAL")
    txt_ExtFin.Enabled = (Not box_Casilla.Text = "LOCAL")
    SSFrame6.Enabled = (Not box_Casilla.Text = "LOCAL")
    
    txt_PathFin.BackColor = IIf((Not box_Casilla.Text = "LOCAL"), box_Casilla.BackColor, Frame1.BackColor)
    txt_FileFin.BackColor = IIf((Not box_Casilla.Text = "LOCAL"), box_Casilla.BackColor, Frame1.BackColor)
    txt_FijoFin.BackColor = IIf((Not box_Casilla.Text = "LOCAL"), box_Casilla.BackColor, Frame1.BackColor)
    txt_FechaFin.BackColor = IIf((Not box_Casilla.Text = "LOCAL"), box_Casilla.BackColor, Frame1.BackColor)
    txt_ExtFin.BackColor = IIf((Not box_Casilla.Text = "LOCAL"), box_Casilla.BackColor, Frame1.BackColor)

End Sub

Private Sub box_Casilla_Click()
Dim vInfo()

    Call Llenar_Combo_Casilla(box_Casilla.Text, vInfo)
    
    If Len(vInfo(0)) <> 0 Then
        txt_PathFin.Text = vInfo(4)
    End If
    
    txt_PathFin.Enabled = (Not box_Casilla.Text = "LOCAL")
    txt_FileFin.Enabled = (Not box_Casilla.Text = "LOCAL")
    txt_FijoFin.Enabled = (Not box_Casilla.Text = "LOCAL")
    txt_FechaFin.Enabled = (Not box_Casilla.Text = "LOCAL")
    txt_ExtFin.Enabled = (Not box_Casilla.Text = "LOCAL")
    SSFrame6.Enabled = (Not box_Casilla.Text = "LOCAL")
    
    txt_PathFin.BackColor = IIf((Not box_Casilla.Text = "LOCAL"), box_Casilla.BackColor, Frame1.BackColor)
    txt_FileFin.BackColor = IIf((Not box_Casilla.Text = "LOCAL"), box_Casilla.BackColor, Frame1.BackColor)
    txt_FijoFin.BackColor = IIf((Not box_Casilla.Text = "LOCAL"), box_Casilla.BackColor, Frame1.BackColor)
    txt_FechaFin.BackColor = IIf((Not box_Casilla.Text = "LOCAL"), box_Casilla.BackColor, Frame1.BackColor)
    txt_ExtFin.BackColor = IIf((Not box_Casilla.Text = "LOCAL"), box_Casilla.BackColor, Frame1.BackColor)
    
    If SSFrame6.Enabled Then
        Call opt_Fin_Click(IIf(opt_Fin(0).Value, 0, 1))
    End If
    
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer


If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
If pnl_Detalle.Visible Then

    Select Case KeyCode
    
         Case vbkeyAceptar
               opcion = 1
                
         Case vbKeySalir
               opcion = 2
               
   End Select

   If opcion <> 0 Then
      KeyCode = 0
      If Toolbar2.Buttons(opcion).Enabled Then
         Call Toolbar2_ButtonClick(Toolbar2.Buttons(opcion))
      End If
   End If
   
Else
   Select Case KeyCode

         Case vbKeyLimpiar
               opcion = 1

         Case vbKeyGrabar
               opcion = 2
         
         Case vbKeyEliminar
               opcion = 3

         Case vbKeyBuscar
               opcion = 4
               
         Case vbKeyDetalle
               opcion = 5
                
         Case vbKeySalir
         
               opcion = 6
               
   End Select

   If opcion <> 0 Then
      KeyCode = 0
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
      End If
   End If
   
End If
   
End If

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
On Error Resume Next
If UCase(Me.ActiveControl.Name) <> "GRILLA" Then
   If KeyAscii = 13 Then
         Bac_SendKey vbKeyTab
   End If
End If
End Sub


Private Sub Form_Load()
    
    OptLocal = Opt
    Me.top = 0
    Me.left = 0
    
    Call Dibuja_Grilla
    Call Llenar_Combo_Entidad
    Call Llenar_Combo_Sistema
    Call Llenar_Combo_Casilla
    Limpiar_Datos
    
    Me.Toolbar1.Buttons(2).Enabled = False
    Me.Toolbar1.Buttons(3).Enabled = False

    Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
    
    Me.CmbEntidad.ListIndex = -1
    
    If CmbEntidad.ListCount > 0 Then
       Me.CmbEntidad.ListIndex = 0
    End If
    
    Me.box_Casilla.ListIndex = -1
    
End Sub

Sub Llenar_Combo_Casilla(Optional sCasilla As String, Optional ByRef vInfo As Variant)
ReDim vInfo(5)

If Len(sCasilla) = 0 Then
   box_Casilla.Clear
End If

vInfo(0) = ""
vInfo(1) = ""
vInfo(2) = ""
vInfo(3) = ""
vInfo(4) = ""

If Not BAC_SQL_EXECUTE("SP_CON_CASILLA_TRANSMISION") Then
    MsgBox "Problema al cargar Sistemas.", vbCritical
    Exit Sub
End If
   
Do While BAC_SQL_FETCH(Datos())
    
    If Len(sCasilla) = 0 Then
        box_Casilla.AddItem Datos(1)
    Else
        If sCasilla = Datos(1) Then
            ReDim vInfo(5)
            vInfo(0) = Datos(1)
            vInfo(1) = Datos(2)
            vInfo(2) = Datos(3)
            vInfo(3) = Datos(4)
            vInfo(4) = Datos(5)
            Exit Do
        End If
    End If
      
Loop
   
End Sub


Sub Dibuja_Grilla()
Dim nContador  As Long

 With grilla
 .Rows = 3
 .FixedRows = 2
 .Cols = 23
 .FixedCols = 0
 .TextMatrix(0, 0) = "Código"
 .TextMatrix(1, 0) = "Interfaz"
 .TextMatrix(0, 1) = "Nombre"
 .TextMatrix(1, 1) = "Interfaz"
 .TextMatrix(0, 2) = "Descripción"
 .TextMatrix(1, 2) = "Interfaz"
 .TextMatrix(0, 3) = "Ruta"
 .TextMatrix(1, 3) = "Acceso"
 .TextMatrix(0, 4) = "Tipo"
 .TextMatrix(1, 4) = "Interfaz"
 .TextMatrix(0, 5) = "Código"
 .TextMatrix(1, 5) = "Cartera"
 
 .RowHeight(0) = 290
 .RowHeight(1) = 290
 .RowHeight(2) = 290
 
 .ColWidth(0) = 3000
 .ColWidth(1) = 0
 .ColWidth(2) = 4800
 .ColWidth(3) = 0
 .ColWidth(6) = 0
 
 For nContador = 6 To 22
    .ColWidth(nContador) = 0
 Next
 
 .ColWidth(5) = 0
 .ColComboList(4) = ""
 .ColComboList(4) = .ColComboList(4) & "#" & 1 & ";" & "ENTRADA" & "|"
 .ColComboList(4) = .ColComboList(4) & "#" & 2 & ";" & "SALIDA"
 .FocusRect = flexFocusNone
 .Rows = 2
 .Col = 6
 
 End With
End Sub

Private Function FUNC_VALIDAR_CODIGO() As Boolean

With grilla

 cCodigo = Trim(.TextMatrix(.Row, 0))
 
 For nIndice = 1 To .Rows - 1
 
   If cCodigo = Trim(.TextMatrix(nIndice, 0)) And nIndice <> .Row And .RowHidden(nIndice) = False Then
      
      FUNC_VALIDAR_CODIGO = False
      Exit Function
      
   End If
   
 Next nIndice
 
 FUNC_VALIDAR_CODIGO = True

End With

End Function

Sub Llenar_Combo_Entidad()
   If Not BAC_SQL_EXECUTE("Sp_Busca_Entidad") Then
      MsgBox "Problema al cargar Entidades.", vbCritical
      LlenarLocalidades = False
      Exit Sub
   End If
   
   Do While BAC_SQL_FETCH(Datos())
      CmbEntidad.AddItem Datos(3) & Space(100) & Datos(1)
      xentidad = Datos(4)
      grilla.TextMatrix(grilla.Rows - 1, 5) = xentidad
   Loop
   
   
End Sub

Sub Llenar_Combo_Sistema()

 Envia = Array()
 AddParam Envia, ""
 AddParam Envia, 8
 
 If Not BAC_SQL_EXECUTE("SP_CON_TRAER_CODIGOS_GESTION", Envia) Then
      MsgBox "Problema al cargar Sistemas.", vbCritical
      LlenarLocalidades = False
      Exit Sub
   End If
   
   Do While BAC_SQL_FETCH(Datos())
      'If Datos(3) = "S" And Datos(5) = "S" Then
       CmbSistema.AddItem Datos(2) & Space(100) & Datos(1)
      'End If
   Loop
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Grilla_AfterEdit(ByVal Row As Long, ByVal Col As Long)

If Col = 0 Then
      
      If Not FUNC_VALIDAR_CODIGO Then
      
         MsgBox "Código ya existe", vbOKOnly + vbInformation
         grilla.TextMatrix(Row, 0) = cCodigo_anterior
         grilla.Col = 0
         grilla.SetFocus
         
      Else
      
         grilla.Col = 1
         grilla.SetFocus
         
      End If
      
   End If
End Sub

Private Sub Grilla_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
If Col = 0 Then
 cCodigo_anterior = grilla.TextMatrix(Row, 0)
End If
End Sub

Private Sub Grilla_KeyDownEdit(ByVal Row As Long, ByVal Col As Long, KeyCode As Integer, ByVal Shift As Integer)

    If grilla.Col = 3 And KeyCode = vbKeyF3 Then
            
              grilla.LeftCol = 3
              grilla.Col = 3
              ShellPath = ""
              ShellPath = BrowseForFolder(Me.hwnd, "Escoja una carpeta")
              
             If ShellPath <> "" Then
              
                If grilla.TextMatrix(grilla.Row, 3) = "" Then
                
                    grilla.TextMatrix(grilla.Row, 3) = UCase(ShellPath) + "\"
                    
                 Else
                
                    grilla.TextMatrix(grilla.Row, 3) = UCase(ShellPath) + "\"
                    
                 End If
             End If
    End If
    
    If KeyCode = vbKeyReturn Then

       If grilla.Col + 1 = 5 Then
         grilla.Col = 0
         grilla.LeftCol = grilla.Col
       Else
           grilla.Col = grilla.Col + 1
       End If
       grilla.SetFocus
    End If
End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)
If grilla.Col = 1 Then

    grilla.EditMaxLength = 20
    
ElseIf grilla.Col = 2 Then

    grilla.EditMaxLength = 50
    
ElseIf grilla.Col = 3 Then

    grilla.EditMaxLength = 100

End If
End Sub

Private Sub Grilla_KeyPressEdit(ByVal Row As Long, ByVal Col As Long, KeyAscii As Integer)
KeyAscii = Caracter(KeyAscii)
KeyAscii = Asc(UCase(Chr(KeyAscii)))


If Col <> 0 And Trim(grilla.TextMatrix(Row, 0)) = "" Then

   KeyAscii = 0
   MsgBox "Debe Ingresar Código", vbOKOnly + vbInformation
   grilla.Col = 0
   grilla.SetFocus
   
End If
End Sub


Private Sub opt_Fin_Click(Index As Integer)

txt_FijoFin.Enabled = (Index = 0)
txt_FechaFin.Enabled = (Index = 0)
txt_ExtFin.Enabled = (Index = 0)
txt_FileFin.Enabled = (Index <> 0)

txt_FijoFin.BackColor = IIf(txt_FijoFin.Enabled, txt_PathFin.BackColor, Frame1.BackColor)
txt_FechaFin.BackColor = IIf(txt_FijoFin.Enabled, txt_PathFin.BackColor, Frame1.BackColor)
txt_ExtFin.BackColor = IIf(txt_FijoFin.Enabled, txt_PathFin.BackColor, Frame1.BackColor)
txt_FileFin.BackColor = IIf(Not txt_FijoFin.Enabled, txt_PathFin.BackColor, Frame1.BackColor)

If opt_Fin(0).Value Then
  ' txt_PathFin.Text = ""
   txt_FileFin.Text = ""
Else
   txt_FijoFin.Text = ""
   txt_FechaFin.Text = ""
   txt_ExtFin.Text = ""
End If

End Sub

Private Sub Opt_Ini_Click(Index As Integer)
        
txt_FijoIni.Enabled = (Index = 0)
txt_FechaIni.Enabled = (Index = 0)
txt_ExtIni.Enabled = (Index = 0)
txt_FileIni.Enabled = (Index <> 0)

txt_FijoIni.BackColor = IIf(txt_FijoIni.Enabled, txt_PathIni.BackColor, Frame1.BackColor)
txt_FechaIni.BackColor = IIf(txt_FijoIni.Enabled, txt_PathIni.BackColor, Frame1.BackColor)
txt_ExtIni.BackColor = IIf(txt_FijoIni.Enabled, txt_PathIni.BackColor, Frame1.BackColor)
txt_FileIni.BackColor = IIf(Not txt_FijoIni.Enabled, txt_PathIni.BackColor, Frame1.BackColor)

If Opt_Ini(0).Value Then
 '  txt_PathIni.Text = ""
   txt_FileIni.Text = ""
Else
   txt_FijoIni.Text = ""
   txt_FechaIni.Text = ""
   txt_ExtIni.Text = ""
End If

End Sub

Private Sub opt_Valida_Click(Index As Integer)

txt_Dias.Enabled = (opt_Valida(1).Value)
txt_Dias.BackColor = IIf((opt_Valida(1).Value), box_Casilla.BackColor, Frame1.BackColor)

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim nContador As Long

   'On Error GoTo Detectar_Error
   
   Select Case Button.Index
      Case 1
         Toolbar1.Buttons(1).Enabled = True
         Call Limpiar_Datos
         CmbEntidad.SetFocus
         
      Case 2
      
         Toolbar1.Buttons(1).Enabled = True
         Call Grabar_Datos
         
      Case 3
        If MsgBox("Seguro de Eliminar las Intefaces del Módulo", vbYesNo + vbInformation) = vbYes Then
         Toolbar1.Buttons(1).Enabled = True
         Call Eliminar_Datos
        End If
      Case 4
         If CmbEntidad.Text = "" Or CmbSistema.Text = "" Then
            Exit Sub
         
         End If
         
         Toolbar1.Buttons(1).Enabled = False
         Call Buscar_Datos
      
      Case 5 'ver detalle
         
         If grilla.Rows < 3 Then
            Exit Sub
         End If
         
         pnl_Detalle.Visible = True
         SSFrame1.Enabled = False
         SSFrame2.Enabled = False
         Toolbar1.Enabled = False
         
         For nContador = 0 To box_Casilla.ListCount - 1
            If box_Casilla.List(nContador) = grilla.TextMatrix(grilla.Row, 10) Then
                box_Casilla.ListIndex = nContador
                Exit For
            End If
         Next
         
         box_Casilla_Click
         
         txt_PathIni = grilla.TextMatrix(grilla.Row, 12)
         txt_FileIni = grilla.TextMatrix(grilla.Row, 13)
         txt_FijoIni = grilla.TextMatrix(grilla.Row, 14)
         txt_FechaIni = grilla.TextMatrix(grilla.Row, 15)
         txt_ExtIni = grilla.TextMatrix(grilla.Row, 16)
         
         txt_PathFin = grilla.TextMatrix(grilla.Row, 17)
         txt_FileFin = grilla.TextMatrix(grilla.Row, 18)
         txt_FijoFin = grilla.TextMatrix(grilla.Row, 19)
         txt_FechaFin = grilla.TextMatrix(grilla.Row, 20)
         txt_ExtFin = grilla.TextMatrix(grilla.Row, 21)
         
         opt_Valida(0).Value = (Val(grilla.TextMatrix(grilla.Row, 7)) = 1)
         opt_Valida(1).Value = Not (Val(grilla.TextMatrix(grilla.Row, 7)) = 1)
         txt_Dias = grilla.TextMatrix(grilla.Row, 8)
         If right(grilla.TextMatrix(grilla.Row, 8), 1) = "." Then
                 txt_Dias.Text = left(grilla.TextMatrix(grilla.Row, 8), Len(grilla.TextMatrix(grilla.Row, 8)) - 1)
                 
         End If
         txt_Dias.Text = Replace(txt_Dias.Text, ".", ",")
           
                  
         Opt_Ini(0).Value = (Len(txt_FileIni) = 0)
         opt_Fin(0).Value = (Len(txt_FileFin) = 0)
         Opt_Ini(1).Value = (Len(txt_FileIni) <> 0)
         opt_Fin(1).Value = (Len(txt_FileFin) <> 0)
         
         If Opt_Ini(0).Value Then
            'txt_PathIni.Text = ""
            txt_FileIni.Text = ""
         Else
            txt_FijoIni.Text = ""
            txt_FechaIni.Text = ""
            txt_ExtIni.Text = ""
         End If
         
         If opt_Fin(0).Value Then
           ' txt_PathFin.Text = ""
            txt_FileFin.Text = ""
         Else
            txt_FijoFin.Text = ""
            txt_FechaFin.Text = ""
            txt_ExtFin.Text = ""
         End If

        If right(grilla.TextMatrix(grilla.Row, 9), 1) = 0 Then
           ChKMensual.Value = 0
        Else
           ChKMensual.Value = 1
        End If
                     
      Case 6
         Unload Me
         Exit Sub
   End Select
CmbEntidad.ListIndex = 0
Exit Sub
Detectar_Error:
   ShowError
   On Error Resume Next
End Sub

Sub Grabar_Datos()
Dim Datos()
Dim X

For X = 1 To grilla.Rows - 1
    If Validar_Datos() = False Or FUNC_VALIDAR(False) = False Then
        Exit Sub
    End If
Next

On Error GoTo Detectar_Error

   Envia = Array()
   AddParam Envia, Sistema                          'Sistema   --1
   AddParam Envia, ""                               'Codigo Interfaz   --2
   AddParam Envia, Rut_Entidad                      'Nombre Interfaz   --3
   AddParam Envia, ""                               'Descripcion   --4
   AddParam Envia, ""                               'Ruta acceso   --5
   AddParam Envia, ""                               'Tipo Interfaz     --6
   AddParam Envia, "E"                              'Codigo cartera / SWITCH DE ELIMINACION    --7
   AddParam Envia, ""                               'Nombre de la interfaz --8
   AddParam Envia, 0                                'Diaria - -9
   AddParam Envia, ""                               'dias - -10
   AddParam Envia, 0                                'Mensual - -11
   AddParam Envia, ""                               'Casilla - -12
   AddParam Envia, 0                                'nemotecnico - -13
   AddParam Envia, ""                               'Path_Inicio - -14
   AddParam Envia, ""                               'Archivo_Inicio - -15
   AddParam Envia, ""                               'Fijo_Inicio - -16
   AddParam Envia, ""                               'Fecha_Inicio - -17
   AddParam Envia, ""                               'Extencion_Inicio - -18
   AddParam Envia, ""                               'Path_Final - -19
   AddParam Envia, ""                               'Archivo_Final - -20
   AddParam Envia, ""                               'Fijo_Final - -21
   AddParam Envia, ""                               'Fecha_Final - -22
   AddParam Envia, ""                               'Extencion_Final - -23
        
   If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then GoTo Error_Sql
       
   If Not BAC_SQL_EXECUTE("Sp_Grabar_MntInterfaz", Envia) Then
         Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Entidad: " & CmbEntidad.Text & " Sistema: " & CmbSistema.Text, "", "")
         GoTo Error_Sql
   End If
   
   For X = grilla.FixedRows To grilla.Rows - 1
   
        If grilla.TextMatrix(X, 0) = "" Then
            Exit For
        End If
   
        Rut_Entidad = CDbl(Trim(Mid(Me.CmbEntidad, Len(Me.CmbEntidad) - 100, 120)))
        Sistema = Trim(Mid(Me.CmbSistema, Len(Me.CmbSistema) - 5, 9))
        codigo = Trim(grilla.TextMatrix(X, 0))
        Descripcion = grilla.TextMatrix(X, 2)
        ruta = grilla.TextMatrix(X, 12)
        tipo = grilla.TextMatrix(X, 4)
        cartera = grilla.TextMatrix(X, 5)
        Nombre = grilla.TextMatrix(X, 13)
      
        Envia = Array()
        AddParam Envia, Sistema                          'Sistema
        AddParam Envia, codigo                           'Codigo Interfaz
        AddParam Envia, Rut_Entidad                      'Nombre Interfaz
        AddParam Envia, Descripcion                      'Descripcion
        AddParam Envia, ruta                             'Ruta acceso
        AddParam Envia, tipo                             'Tipo Interfaz
        AddParam Envia, cartera                          'Codigo cartera
        AddParam Envia, Nombre                           'Nombre de la interfaz
        
        AddParam Envia, Val(grilla.TextMatrix(X, 7))     'Diaria - -9
        AddParam Envia, grilla.TextMatrix(X, 8)          'dias - -10
        AddParam Envia, Val(grilla.TextMatrix(X, 9))     'Mensual - -11
        AddParam Envia, grilla.TextMatrix(X, 10)         'Casilla - -12
        AddParam Envia, Val(grilla.TextMatrix(X, 11))    'nemotecnico - -13
        AddParam Envia, grilla.TextMatrix(X, 12)         'Path_Inicio - -14
        AddParam Envia, grilla.TextMatrix(X, 13)         'Archivo_Inicio - -15
        AddParam Envia, grilla.TextMatrix(X, 14)         'Fijo_Inicio - -16
        AddParam Envia, grilla.TextMatrix(X, 15)         'Fecha_Inicio - -17
        AddParam Envia, grilla.TextMatrix(X, 16)         'Extencion_Inicio - -18
        AddParam Envia, grilla.TextMatrix(X, 17)         'Path_Final - -19
        AddParam Envia, grilla.TextMatrix(X, 18)         'Archivo_Final - -20
        AddParam Envia, grilla.TextMatrix(X, 19)         'Fijo_Final - -21
        AddParam Envia, grilla.TextMatrix(X, 20)         'Fecha_Final - -22
        AddParam Envia, grilla.TextMatrix(X, 21)         'Extencion_Final - -23
   
        If Not BAC_SQL_EXECUTE("Sp_Grabar_MntInterfaz", Envia) Then
            Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Entidad: " & CmbEntidad.Text & " Sistema: " & CmbSistema.Text, "", "")
            GoTo Error_Sql
        End If
    Next
    
   If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then GoTo Error_Sql
    
   MsgBox "Grabación se Realizó Correctamente", vbInformation
   
   Call LogAuditoria("01", OptLocal, Me.Caption, "", "Entidad: " & CmbEntidad.Text & " Sistema: " & CmbSistema.Text)
   Call Limpiar_Datos

   If CmbEntidad.Enabled Then
      CmbEntidad.SetFocus
   
   End If

   Exit Sub
   
Error_Sql:

    Call BAC_SQL_EXECUTE("ROLLBACK TRANSACTION")
    MsgBox "Problemas al Grabar Interfazes", vbInformation
    Exit Sub
    
Detectar_Error:
   ShowError
   On Error Resume Next
End Sub

Sub Eliminar_Datos()
Dim Datos()
Dim i
Envia = Array()

   Envia = Array()
   AddParam Envia, Sistema                           'Sistema
   AddParam Envia, codigo                            'Codigo Interfaz
   AddParam Envia, Rut_Entidad                       'Nombre Interfaz
   AddParam Envia, Descripcion                       'Descripcion
   AddParam Envia, ruta                              'Ruta acceso
   AddParam Envia, tipo                              'Tipo Interfaz
   AddParam Envia, "E"                               'Codigo cartera / SWITCH DE ELIMINACION
   AddParam Envia, Nombre                            'Nombre de la interfaz

   If Not BAC_SQL_EXECUTE("Sp_Grabar_MntInterfaz", Envia) Then
      MsgBox "No se ha podido Eliminar La Interfaz", vbInformation
      Call LogAuditoria("03", OptLocal, Me.Caption & " Error al eliminar- Entidad: " & CmbEntidad.Text & " Sistema: " & CmbSistema.Text, "", "")
      Exit Sub
   End If

   MsgBox "Eliminación se realizo con Exito", vbInformation
   Call LogAuditoria("03", OptLocal, Me.Caption, "Entidad: " & CmbEntidad.Text & " Sistema: " & CmbSistema.Text, "")
   Call Limpiar_Datos
   Toolbar1.Buttons(4).Enabled = True
   CmbEntidad.SetFocus
End Sub

Sub Limpiar_Datos()
   
   Me.Toolbar1.Buttons(2).Enabled = False
   Me.Toolbar1.Buttons(3).Enabled = False
   
   
   grilla.LeftCol = 0
   
   CmbEntidad.ListIndex = -1
   CmbSistema.ListIndex = -1

   grilla.Redraw = False
   grilla.Rows = 1
   grilla.Col = 0
   grilla.Redraw = True

   Call Dibuja_Grilla
   CmbEntidad.Enabled = True
   CmbSistema.Enabled = True

'   Grilla.TextMatrix(Grilla.Rows - 1, 5) = xentidad
   Me.grilla.LeftCol = 0

   grilla.Enabled = False
   
   Toolbar1.Buttons(2).Enabled = grilla.Enabled
   Toolbar1.Buttons(3).Enabled = grilla.Enabled
   
   Toolbar1.Buttons(4).Enabled = Not grilla.Enabled

   
End Sub

Sub Buscar_Datos()
Dim Datos()
Dim i As Integer
i = 0
On Error Resume Next

grilla.ColComboList(0) = ""
Envia = Array()
AddParam Envia, Trim(Mid(Me.CmbSistema, Len(Me.CmbSistema) - 5, 9))
    
If BAC_SQL_EXECUTE("SP_CON_TRAE_MENU_INTERFAZ", Envia) Then
        
    Do While BAC_SQL_FETCH(Datos())
        grilla.ColComboList(0) = grilla.ColComboList(0) & "#" & Datos(2) & ";" & UCase(Datos(1)) & "|"
    Loop

End If

If grilla.ColComboList(0) = "" Then
    MsgBox "No hay opciones de Menú de Interfaces para este Módulo", vbInformation
    Exit Sub
End If




Rut_Entidad = CDbl(Trim(Mid(Me.CmbEntidad, Len(Me.CmbEntidad) - 100, 120)))
Sistema = Trim(Mid(Me.CmbSistema, Len(Me.CmbSistema) - 5, 9))

Envia = Array()
AddParam Envia, Rut_Entidad
AddParam Envia, Sistema

If Not BAC_SQL_EXECUTE("Sp_Buscar_MntInterfaz", Envia) Then
      MsgBox "Problema al Buscar la Interfaz.", vbCritical
      Exit Sub
End If
   
   Do While BAC_SQL_FETCH(Datos())
      Me.Toolbar1.Buttons(3).Enabled = True
      i = i + 1
      
      grilla.Rows = grilla.Rows + 1
      grilla.TextMatrix(grilla.Rows - 1, 0) = Datos(1)
      grilla.TextMatrix(grilla.Rows - 1, 1) = Datos(2)
      grilla.TextMatrix(grilla.Rows - 1, 2) = Datos(3)
      grilla.TextMatrix(grilla.Rows - 1, 3) = Datos(4)
      grilla.TextMatrix(grilla.Rows - 1, 4) = Datos(5)
      grilla.TextMatrix(grilla.Rows - 1, 5) = Datos(6)
      
      grilla.TextMatrix(grilla.Rows - 1, 7) = Datos(8)
      grilla.TextMatrix(grilla.Rows - 1, 8) = Datos(9)
      If InStr(1, Datos(9), ".") > 0 Then
        grilla.TextMatrix(grilla.Rows - 1, 8) = Replace(grilla.TextMatrix(grilla.Rows - 1, 8), ".", ",")
        grilla.TextMatrix(grilla.Rows - 1, 8) = Mid(grilla.TextMatrix(grilla.Rows - 1, 8), 1, Len(grilla.TextMatrix(grilla.Rows - 1, 8)) - 1) & "."
        
      End If
      
      grilla.TextMatrix(grilla.Rows - 1, 9) = Datos(10)
      grilla.TextMatrix(grilla.Rows - 1, 10) = Datos(11)
      grilla.TextMatrix(grilla.Rows - 1, 11) = Datos(12)
      grilla.TextMatrix(grilla.Rows - 1, 12) = Datos(13)
      grilla.TextMatrix(grilla.Rows - 1, 13) = Datos(14)
      grilla.TextMatrix(grilla.Rows - 1, 14) = Datos(15)
      grilla.TextMatrix(grilla.Rows - 1, 15) = Datos(16)
      grilla.TextMatrix(grilla.Rows - 1, 16) = Datos(17)
      grilla.TextMatrix(grilla.Rows - 1, 17) = Datos(18)
      grilla.TextMatrix(grilla.Rows - 1, 18) = Datos(19)
      grilla.TextMatrix(grilla.Rows - 1, 19) = Datos(20)
      grilla.TextMatrix(grilla.Rows - 1, 20) = Datos(21)
      grilla.TextMatrix(grilla.Rows - 1, 21) = Datos(22)
      
   Loop
   

CmbEntidad.Enabled = False
CmbSistema.Enabled = False

grilla.Enabled = True
Toolbar1.Buttons(1).Enabled = True

If grilla.Rows = grilla.FixedRows Then
   grilla.Rows = grilla.Rows + 1
   grilla.Col = 0
   grilla.Row = grilla.Rows - 1
   grilla.TextMatrix(grilla.Rows - 1, 5) = 1

End If

Toolbar1.Buttons(2).Enabled = grilla.Enabled
Toolbar1.Buttons(3).Enabled = grilla.Enabled
Toolbar1.Buttons(4).Enabled = Not grilla.Enabled

If grilla.Enabled Then
   grilla.Col = 0
   grilla.Row = 2
   grilla.SetFocus
End If


End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)

   Select Case KeyCode
   
      Case vbKeyF3
        If grilla.Col = 3 Then
            
              grilla.LeftCol = 3
              grilla.Col = 3
              ShellPath = ""
              ShellPath = BrowseForFolder(Me.hwnd, "Escoja una carpeta")
              
             If ShellPath <> "" Then
              
                If grilla.TextMatrix(grilla.Row, 3) = "" Then
                
                    grilla.TextMatrix(grilla.Row, 3) = UCase(ShellPath) + "\"
                    
                 Else
                
                    grilla.TextMatrix(grilla.Row, 3) = UCase(ShellPath) + "\"
                    
                 End If
             End If
        End If
      
      Case vbKeyInsert

           If CamposNulos(grilla) Then
              grilla.AddItem "", grilla.Rows
              grilla.Row = grilla.Rows - 1
              grilla.TextMatrix(grilla.Row, 5) = 1
           End If
         
      Case vbKeyDelete
      
            If grilla.Rows = grilla.FixedRows Or grilla.Rows = 3 Then
               grilla.Rows = 2
               grilla.Rows = 3
               grilla.TextMatrix(grilla.Rows - 1, 5) = 1
            Else
               Me.grilla.RemoveItem (grilla.RowSel)
            End If
                
   End Select

End Sub










Function CamposNulos(grilla As Control) As Boolean
Dim i, J As Integer

   CamposNulos = True

   With grilla

      For i = 2 To .Rows
   
         For J = 1 To .Cols - 2
                
            If .TextMatrix(.Rows - 1, J) = "" Then
            
               If J <> 5 And J <> 1 And J <> 3 And J <> 4 And J < 6 Then
                  
                  CamposNulos = False
                  Exit Function
                     
               End If
            
            End If
   
         Next J
         
      Next i

   End With

End Function

Function Validar_Datos() As Boolean
   Validar_Datos = False
   If CmbEntidad.ListIndex = -1 Then
      MsgBox "Debe Ingresar una Entidad", vbInformation
      Exit Function
   ElseIf CmbSistema.ListIndex = -1 Then
      MsgBox "Debe Ingresar un Sistema", vbInformation
      Exit Function
   ElseIf grilla.TextMatrix(grilla.Row, 0) = "" Then
      MsgBox "Debe Ingresar un Codigo de Interfaz", vbInformation
      Exit Function
   ElseIf grilla.TextMatrix(grilla.Row, 2) = "" Then
      MsgBox "Debe Ingresar una Descripcion de Interfaz", vbInformation
      Exit Function
   ElseIf grilla.TextMatrix(grilla.Row, 4) = "" Then
      MsgBox "Debe Ingresar un Tipo de Interfaz", vbInformation
      Exit Function
   End If
   Validar_Datos = True
End Function



Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim nContador   As Long

Select Case Button.Index
     Case 1
        If FUNC_VALIDAR(True) Then
            grilla.TextMatrix(grilla.Row, 10) = box_Casilla
            
            grilla.TextMatrix(grilla.Row, 12) = txt_PathIni
            grilla.TextMatrix(grilla.Row, 13) = txt_FileIni
            grilla.TextMatrix(grilla.Row, 14) = txt_FijoIni
            grilla.TextMatrix(grilla.Row, 15) = txt_FechaIni
            grilla.TextMatrix(grilla.Row, 16) = txt_ExtIni
            
            
            grilla.TextMatrix(grilla.Row, 17) = txt_PathFin
            grilla.TextMatrix(grilla.Row, 18) = txt_FileFin
            grilla.TextMatrix(grilla.Row, 19) = txt_FijoFin
            grilla.TextMatrix(grilla.Row, 20) = txt_FechaFin
            grilla.TextMatrix(grilla.Row, 21) = txt_ExtFin
            
            If opt_Valida(0).Value Then
               grilla.TextMatrix(grilla.Row, 7) = 1
               grilla.TextMatrix(grilla.Row, 8) = ""
            Else
                
               If right(txt_Dias.Text, 1) <> "." Then
                 txt_Dias.Text = txt_Dias.Text + "."
               End If
               
               grilla.TextMatrix(grilla.Row, 7) = 0
               grilla.TextMatrix(grilla.Row, 8) = txt_Dias
            End If
            
            If ChKMensual.Value = 1 Then
               grilla.TextMatrix(grilla.Row, 9) = 1
            Else
               grilla.TextMatrix(grilla.Row, 9) = 0
            End If
            
        Else
            Exit Sub
        End If
         
End Select

pnl_Detalle.Visible = False
SSFrame1.Enabled = True
SSFrame2.Enabled = True
Toolbar1.Enabled = True

End Sub


Private Sub txt_FileIni_DblClick()
    
    dlg_Rutas.Filter = "*.*"
    dlg_Rutas.Action = 1
    txt_FileIni.Text = Dir(dlg_Rutas.FileName, vbArchive)
    txt_PathIni.Text = Replace(dlg_Rutas.FileName, Dir(dlg_Rutas.FileName, vbArchive), "")
    
End Sub


Private Sub txt_PathFin_DblClick()

If box_Casilla.Text = "LOCAL" Then
    txt_PathFin = BrowseForFolder(Me.hwnd, "Seleccione Carpeta")
End If

End Sub


Private Sub txt_PathIni_DblClick()

    txt_PathIni = BrowseForFolder(Me.hwnd, "Seleccione Carpeta")
    
End Sub


