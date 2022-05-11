VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacMntFa 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Familias de Instrumentos"
   ClientHeight    =   10695
   ClientLeft      =   4815
   ClientTop       =   1410
   ClientWidth     =   5280
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmntfa.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form10"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   10695
   ScaleWidth      =   5280
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   555
      Left            =   120
      TabIndex        =   37
      Top             =   8520
      Width           =   5055
      Begin VB.OptionButton optPzoRem 
         Caption         =   "Plazo Remanente"
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
         Left            =   300
         TabIndex        =   39
         Top             =   240
         Value           =   -1  'True
         Width           =   1815
      End
      Begin VB.OptionButton optPzoTra 
         Caption         =   "Plazo Por Tramos"
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
         Left            =   2520
         TabIndex        =   38
         Top             =   240
         Width           =   1815
      End
   End
   Begin VB.Frame Frame3 
      ForeColor       =   &H8000000D&
      Height          =   615
      Left            =   120
      TabIndex        =   35
      Top             =   9240
      Width           =   5055
      Begin VB.CommandButton BtnOpeSoma 
         Caption         =   "Operaciones SOMA"
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
         Left            =   1260
         TabIndex        =   36
         Top             =   180
         Width           =   2295
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   14
      Top             =   0
      Width           =   5280
      _ExtentX        =   9313
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
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   9915
      Left            =   0
      TabIndex        =   0
      Top             =   510
      Width           =   5625
      _Version        =   65536
      _ExtentX        =   9922
      _ExtentY        =   17489
      _StockProps     =   15
      Caption         =   "SSPanel1"
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
      BorderWidth     =   2
      BevelInner      =   1
      Begin Threed.SSPanel Panel 
         Height          =   9105
         Index           =   1
         Left            =   60
         TabIndex        =   15
         Top             =   750
         Width           =   5160
         _Version        =   65536
         _ExtentX        =   9102
         _ExtentY        =   16060
         _StockProps     =   15
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
         Begin VB.Frame Frame2 
            Height          =   615
            Left            =   120
            TabIndex        =   70
            Top             =   2880
            Width           =   5000
            Begin VB.ComboBox CmbClasinstrumento 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   330
               Left            =   2640
               Style           =   2  'Dropdown List
               TabIndex        =   71
               Top             =   170
               Width           =   2295
            End
            Begin VB.Label Lbl_clasifiInstrumento 
               AutoSize        =   -1  'True
               Caption         =   "Clasificación de Instrumento"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   210
               Index           =   24
               Left            =   100
               TabIndex        =   72
               Top             =   240
               Width           =   2370
            End
         End
         Begin TabDlg.SSTab SSTab 
            Height          =   3615
            Left            =   45
            TabIndex        =   40
            Top             =   3600
            Width           =   5055
            _ExtentX        =   8916
            _ExtentY        =   6376
            _Version        =   393216
            Tabs            =   2
            Tab             =   1
            TabHeight       =   520
            TabCaption(0)   =   "Inf.Adicional"
            TabPicture(0)   =   "Bacmntfa.frx":030A
            Tab(0).ControlEnabled=   0   'False
            Tab(0).Control(0)=   "Label(13)"
            Tab(0).Control(1)=   "Label(14)"
            Tab(0).Control(2)=   "Label(11)"
            Tab(0).Control(3)=   "Label(12)"
            Tab(0).Control(4)=   "Label(15)"
            Tab(0).Control(5)=   "Label2"
            Tab(0).Control(6)=   "Label1"
            Tab(0).Control(7)=   "Label(16)"
            Tab(0).Control(8)=   "Label(23)"
            Tab(0).Control(9)=   "Label(24)"
            Tab(0).Control(10)=   "chbEleg"
            Tab(0).Control(11)=   "ftbTotalEmitido"
            Tab(0).Control(12)=   "cmbSecurityType"
            Tab(0).Control(13)=   "CmbTipoFecha"
            Tab(0).Control(14)=   "CmbEmision"
            Tab(0).Control(15)=   "cmbCodificacion"
            Tab(0).Control(16)=   "cmbUniTiempo"
            Tab(0).Control(17)=   "TxtCodSvs"
            Tab(0).Control(18)=   "txtCodDcv"
            Tab(0).Control(19)=   "CmbInstDeuda"
            Tab(0).Control(20)=   "CmbTipoRendimiento"
            Tab(0).ControlCount=   21
            TabCaption(1)   =   "Pago"
            TabPicture(1)   =   "Bacmntfa.frx":0326
            Tab(1).ControlEnabled=   -1  'True
            Tab(1).Control(0)=   "Label(17)"
            Tab(1).Control(0).Enabled=   0   'False
            Tab(1).Control(1)=   "Label(18)"
            Tab(1).Control(1).Enabled=   0   'False
            Tab(1).Control(2)=   "Label(19)"
            Tab(1).Control(2).Enabled=   0   'False
            Tab(1).Control(3)=   "Label(20)"
            Tab(1).Control(3).Enabled=   0   'False
            Tab(1).Control(4)=   "Label(21)"
            Tab(1).Control(4).Enabled=   0   'False
            Tab(1).Control(5)=   "Label(22)"
            Tab(1).Control(5).Enabled=   0   'False
            Tab(1).Control(6)=   "CmbTipoTasa"
            Tab(1).Control(6).Enabled=   0   'False
            Tab(1).Control(7)=   "CmbComposicion"
            Tab(1).Control(7).Enabled=   0   'False
            Tab(1).Control(8)=   "CmbPeriodicidad"
            Tab(1).Control(8).Enabled=   0   'False
            Tab(1).Control(9)=   "CmbConvension"
            Tab(1).Control(9).Enabled=   0   'False
            Tab(1).Control(10)=   "CmbTasaVariable"
            Tab(1).Control(10).Enabled=   0   'False
            Tab(1).Control(11)=   "CmbPlazoSubyacente"
            Tab(1).Control(11).Enabled=   0   'False
            Tab(1).ControlCount=   12
            Begin VB.ComboBox CmbTipoRendimiento 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   330
               Left            =   -72120
               Style           =   2  'Dropdown List
               TabIndex        =   74
               Top             =   3100
               Width           =   2100
            End
            Begin VB.ComboBox CmbInstDeuda 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   330
               Left            =   -74880
               Style           =   2  'Dropdown List
               TabIndex        =   73
               Top             =   3120
               Width           =   2745
            End
            Begin VB.ComboBox CmbPlazoSubyacente 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   330
               Left            =   2700
               Style           =   2  'Dropdown List
               TabIndex        =   63
               Top             =   2160
               Width           =   2265
            End
            Begin VB.ComboBox CmbTasaVariable 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   330
               Left            =   100
               Style           =   2  'Dropdown List
               TabIndex        =   62
               Top             =   2160
               Width           =   2500
            End
            Begin VB.ComboBox CmbConvension 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   330
               Left            =   2700
               Style           =   2  'Dropdown List
               TabIndex        =   61
               Top             =   1560
               Width           =   2265
            End
            Begin VB.ComboBox CmbPeriodicidad 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   330
               Left            =   100
               Style           =   2  'Dropdown List
               TabIndex        =   60
               Top             =   1560
               Width           =   2500
            End
            Begin VB.ComboBox CmbComposicion 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   330
               Left            =   2700
               Style           =   2  'Dropdown List
               TabIndex        =   59
               Top             =   960
               Width           =   2265
            End
            Begin VB.ComboBox CmbTipoTasa 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   330
               Left            =   100
               Style           =   2  'Dropdown List
               TabIndex        =   58
               Top             =   960
               Width           =   2500
            End
            Begin VB.TextBox txtCodDcv 
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
               Left            =   -74880
               MaxLength       =   2
               TabIndex        =   54
               Text            =   "00"
               Top             =   2520
               Width           =   1380
            End
            Begin VB.TextBox TxtCodSvs 
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
               Left            =   -73320
               MaxLength       =   12
               TabIndex        =   53
               Top             =   2520
               Width           =   1275
            End
            Begin VB.ComboBox cmbUniTiempo 
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
               ItemData        =   "Bacmntfa.frx":0342
               Left            =   -71760
               List            =   "Bacmntfa.frx":0344
               Style           =   2  'Dropdown List
               TabIndex        =   52
               Top             =   2520
               Width           =   1335
            End
            Begin VB.ComboBox cmbCodificacion 
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
               Left            =   -74880
               Style           =   2  'Dropdown List
               TabIndex        =   49
               Top             =   1905
               Width           =   3165
            End
            Begin VB.ComboBox CmbEmision 
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
               Left            =   -72100
               Style           =   2  'Dropdown List
               TabIndex        =   47
               Top             =   1290
               Width           =   2000
            End
            Begin VB.ComboBox CmbTipoFecha 
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
               Left            =   -74880
               Style           =   2  'Dropdown List
               TabIndex        =   45
               Top             =   1290
               Width           =   2745
            End
            Begin VB.ComboBox cmbSecurityType 
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
               Left            =   -74880
               Style           =   2  'Dropdown List
               TabIndex        =   41
               Top             =   720
               Width           =   2745
            End
            Begin BACControles.TXTNumero ftbTotalEmitido 
               Height          =   330
               Left            =   -72120
               TabIndex        =   43
               Top             =   720
               Width           =   1215
               _ExtentX        =   2143
               _ExtentY        =   582
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
               Text            =   "0"
               Text            =   "0"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
            Begin Threed.SSCheck chbEleg 
               Height          =   255
               Left            =   -71685
               TabIndex        =   50
               Top             =   1935
               Width           =   1260
               _Version        =   65536
               _ExtentX        =   2223
               _ExtentY        =   450
               _StockProps     =   78
               Caption         =   "Elegible"
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
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Tipo De Rendimiento"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   210
               Index           =   24
               Left            =   -72120
               TabIndex        =   76
               Top             =   2880
               Width           =   1710
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Inst. Financiero de Deuda"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   210
               Index           =   23
               Left            =   -74880
               TabIndex        =   75
               Top             =   2880
               Width           =   2070
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Plazo a Tasa Variable"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   210
               Index           =   22
               Left            =   3000
               TabIndex        =   69
               Top             =   1920
               Width           =   1725
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Convención Días"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   210
               Index           =   21
               Left            =   3000
               TabIndex        =   68
               Top             =   1320
               Width           =   1365
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Composición"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   210
               Index           =   20
               Left            =   3000
               TabIndex        =   67
               Top             =   720
               Width           =   1095
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Tipo de Tasa Variable"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   210
               Index           =   19
               Left            =   105
               TabIndex        =   66
               Top             =   1920
               Width           =   1770
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Periodicidad de Pago"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   210
               Index           =   18
               Left            =   105
               TabIndex        =   65
               Top             =   1320
               Width           =   1725
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Tipo de Tasa"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00000000&
               Height          =   210
               Index           =   17
               Left            =   105
               TabIndex        =   64
               Top             =   720
               Width           =   1050
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Codificación DCV"
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
               Left            =   -74880
               TabIndex        =   57
               Top             =   2280
               Width           =   1395
            End
            Begin VB.Label Label1 
               Caption         =   "Código SVS"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Left            =   -73320
               TabIndex        =   56
               Top             =   2295
               Width           =   1395
            End
            Begin VB.Label Label2 
               Caption         =   "Unidad Tiempo"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Left            =   -71760
               TabIndex        =   55
               Top             =   2280
               Width           =   1455
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Codificación"
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
               Index           =   15
               Left            =   -74880
               TabIndex        =   51
               Top             =   1680
               Width           =   1005
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Emisión"
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
               Left            =   -72120
               TabIndex        =   48
               Top             =   1080
               Width           =   660
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Tipo Fecha"
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
               Left            =   -74880
               TabIndex        =   46
               Top             =   1080
               Width           =   885
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Total Emitido"
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
               Index           =   14
               Left            =   -72120
               TabIndex        =   44
               Top             =   480
               Width           =   1065
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Security Type"
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
               Left            =   -74880
               TabIndex        =   42
               Top             =   480
               Width           =   1125
            End
         End
         Begin VB.TextBox txtNombreEmisor 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1530
            MaxLength       =   30
            TabIndex        =   6
            Top             =   885
            Width           =   3615
         End
         Begin VB.TextBox txtMoneda 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   120
            MaxLength       =   3
            MouseIcon       =   "Bacmntfa.frx":0346
            MousePointer    =   99  'Custom
            TabIndex        =   7
            Top             =   1455
            Width           =   615
         End
         Begin VB.TextBox txtRutina 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1260
            MaxLength       =   8
            TabIndex        =   4
            Top             =   300
            Width           =   1065
         End
         Begin VB.TextBox txtCodFam 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   120
            MaxLength       =   3
            TabIndex        =   3
            Top             =   300
            Width           =   975
         End
         Begin VB.TextBox txtDigito 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1260
            MaxLength       =   1
            TabIndex        =   16
            Top             =   885
            Width           =   240
         End
         Begin VB.TextBox txtRutEmi 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   120
            MaxLength       =   10
            MouseIcon       =   "Bacmntfa.frx":0650
            MousePointer    =   99  'Custom
            TabIndex        =   5
            Top             =   885
            Width           =   975
         End
         Begin VB.TextBox txtIndTas 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   120
            MaxLength       =   3
            MouseIcon       =   "Bacmntfa.frx":095A
            MousePointer    =   99  'Custom
            TabIndex        =   10
            Top             =   2070
            Width           =   615
         End
         Begin VB.TextBox txtDesIndTas 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   765
            MaxLength       =   30
            TabIndex        =   11
            Top             =   2070
            Width           =   3285
         End
         Begin VB.TextBox txtDesMon 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   765
            MaxLength       =   30
            TabIndex        =   8
            Top             =   1455
            Width           =   3750
         End
         Begin VB.ComboBox cmbTipo 
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
            Left            =   4080
            Style           =   2  'Dropdown List
            TabIndex        =   12
            Top             =   2070
            Width           =   1035
         End
         Begin VB.TextBox txtBase 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   4545
            MaxLength       =   3
            TabIndex        =   9
            Top             =   1455
            Width           =   540
         End
         Begin Threed.SSPanel Panel 
            Height          =   360
            Index           =   3
            Left            =   1005
            TabIndex        =   17
            Top             =   2460
            Width           =   4125
            _Version        =   65536
            _ExtentX        =   7276
            _ExtentY        =   635
            _StockProps     =   15
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
            BorderWidth     =   0
            BevelOuter      =   1
            BevelInner      =   2
            Begin Threed.SSOption opbPreDes 
               Height          =   255
               Index           =   1
               Left            =   2055
               TabIndex        =   18
               TabStop         =   0   'False
               Top             =   60
               Width           =   1995
               _Version        =   65536
               _ExtentX        =   3519
               _ExtentY        =   450
               _StockProps     =   78
               Caption         =   "Tabla de Desarrollo"
               ForeColor       =   -2147483641
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
            Begin Threed.SSOption opbPreDes 
               Height          =   255
               Index           =   0
               Left            =   165
               TabIndex        =   19
               Top             =   60
               Width           =   1905
               _Version        =   65536
               _ExtentX        =   3360
               _ExtentY        =   450
               _StockProps     =   78
               Caption         =   "Tabla de Premios"
               ForeColor       =   -2147483641
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
         End
         Begin Threed.SSFrame Frame 
            Height          =   615
            Left            =   2505
            TabIndex        =   20
            Top             =   105
            Width           =   2595
            _Version        =   65536
            _ExtentX        =   4577
            _ExtentY        =   1085
            _StockProps     =   14
            Caption         =   "Nominales"
            ForeColor       =   -2147483641
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
            Begin Threed.SSOption opbNominal 
               Height          =   255
               Index           =   1
               Left            =   1140
               TabIndex        =   21
               Top             =   240
               Width           =   1395
               _Version        =   65536
               _ExtentX        =   2461
               _ExtentY        =   450
               _StockProps     =   78
               Caption         =   "Vencimiento"
               ForeColor       =   -2147483641
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
            Begin Threed.SSOption opbNominal 
               Height          =   255
               Index           =   0
               Left            =   180
               TabIndex        =   22
               Top             =   240
               Width           =   915
               _Version        =   65536
               _ExtentX        =   1614
               _ExtentY        =   450
               _StockProps     =   78
               Caption         =   "Emisión"
               ForeColor       =   -2147483641
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
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
         Begin Threed.SSCheck chbSerie 
            Height          =   255
            Left            =   120
            TabIndex        =   13
            Top             =   2520
            Width           =   675
            _Version        =   65536
            _ExtentX        =   1191
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Serie                          "
            ForeColor       =   -2147483641
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Rut Emisor"
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
            Left            =   135
            TabIndex        =   31
            Top             =   660
            Width           =   900
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Base"
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
            Left            =   4590
            TabIndex        =   30
            Top             =   1230
            Width           =   405
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Moneda"
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
            Left            =   135
            TabIndex        =   29
            Top             =   1230
            Width           =   660
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   285
            Index           =   6
            Left            =   1140
            TabIndex        =   28
            Top             =   900
            Width           =   75
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Ind. Tasa Estimada"
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
            Left            =   120
            TabIndex        =   27
            Top             =   1845
            Width           =   1530
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Nombre"
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
            Left            =   1575
            TabIndex        =   26
            Top             =   660
            Width           =   660
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Rutina"
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
            Left            =   1260
            TabIndex        =   25
            Top             =   90
            Width           =   510
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Cód. Familia"
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
            Left            =   120
            TabIndex        =   24
            Top             =   90
            Width           =   990
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
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
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   10
            Left            =   4140
            TabIndex        =   23
            Top             =   1845
            Width           =   360
         End
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   735
         Left            =   45
         TabIndex        =   32
         Top             =   15
         Width           =   5175
         _Version        =   65536
         _ExtentX        =   9128
         _ExtentY        =   1296
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
         Begin VB.TextBox txtSerie 
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
            Left            =   135
            MaxLength       =   10
            MouseIcon       =   "Bacmntfa.frx":0C64
            MousePointer    =   99  'Custom
            TabIndex        =   1
            Top             =   360
            Width           =   1095
         End
         Begin VB.TextBox txtFamilia 
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
            Left            =   1320
            MaxLength       =   30
            TabIndex        =   2
            Top             =   360
            Width           =   3765
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Nombre"
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
            Left            =   1350
            TabIndex        =   34
            Top             =   150
            Width           =   660
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Familia"
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
            Left            =   135
            TabIndex        =   33
            Top             =   150
            Width           =   570
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3015
      Top             =   45
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntfa.frx":0F6E
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntfa.frx":13C0
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntfa.frx":1812
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntfa.frx":1B2C
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacMntFa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim sql           As String
Dim DATOS()
Dim xincodigo     As Double
Dim xinglosa      As String
Dim xinrutemi     As Double
Dim xinmonemi     As Single
Dim xinbasemi     As Single
Dim xinprog       As String
Dim xinrefnomi    As String
Dim xinmdse       As String
Dim xinmdpr       As String
Dim xinmdtd       As String
Dim xintipfec     As Single
Dim xintasest     As Single
Dim xintipo       As String
Dim xinemision    As String
Dim xineleg       As String
Dim xincontab     As String
Dim xSecuritytype As String
Dim xTotalEmitido As Double
Dim emNemo        As String
Dim emcodigo      As Double
Dim mnCodfox      As String
Dim xCodificacion As String
Dim xMnCodDcv     As Variant
Dim xInCodSVS     As String              ''REQ.6010
Dim xInUnidadTiempoTasaRef     As String ''REQ.6010
Dim xInEstrucPlazoTasaRef      As String ''REQ.6010
Dim xacNomBCCH    As String              ''REQ.6010

'------------Itaú-----------------
Dim xintabla69 As String
Dim xclasifIns As String
Dim xintabla68 As String
Dim xincodrend As String
'------------Itaú-----------------

Function EliminarFamilia() As Boolean
   On Error GoTo ErrEliminar
   EliminarFamilia = False

   Envia = Array()
   AddParam Envia, txtSerie.Text
   If Bac_Sql_Execute("SP_ELIMINA_FAMILIA", Envia) Then
      Do While Bac_SQL_Fetch(DATOS())
         If DATOS(1) = "NO" Then
            Exit Function
         End If
      Loop
   End If
   Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_615 ", "03", "Eliminar Familia Instrumento", "Instrumento", " ", "Eliminar Familia ." & " " & txtSerie.Text & " " & txtFamilia.Text & " " & txtCodFam.Text)
   
   EliminarFamilia = True
Exit Function
ErrEliminar:
   Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_615 ", "03", "Error al Eliminar Familia instrumento", "Instrumento ", " ", "Error al Eliminar Familia ." & " " & txtSerie.Text & " " & txtFamilia.Text & " " & txtCodFam.Text)
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
End Function

Function GrabarFamilia() As Boolean
   On Error GoTo ErrGrabar
   
   GrabarFamilia = False
   
   Envia = Array()
   AddParam Envia, txtSerie.Text
   AddParam Envia, txtFamilia.Text
   AddParam Envia, txtCodFam.Text
   AddParam Envia, txtRutina.Text
   AddParam Envia, IIf(opbNominal(0).Value, "E", "V")
   AddParam Envia, Bac_Check_Valor(txtRutEmi.Text, 0, "N")
   AddParam Envia, Bac_Check_Valor(txtMoneda.Text, 0, "N")
   AddParam Envia, Bac_Check_Valor(txtBase.Text, 0, "N")
   AddParam Envia, Bac_Check_Valor(txtIndTas.Text, 0, "N")
   AddParam Envia, Trim(Left(cmbTipo.Text, Len(cmbTipo.Text) - 5))
   AddParam Envia, IIf(chbSerie.Value, "S", "N")
   AddParam Envia, IIf(opbPreDes(0).Value, "S", "N")
   AddParam Envia, IIf(opbPreDes(1).Value, "S", "N")
   AddParam Envia, Right(CmbTipoFecha.Text, 5)
   AddParam Envia, Trim(Left(CmbEmision.Text, Len(CmbEmision.Text) - 5))
   AddParam Envia, IIf(chbEleg.Value, "S", "N")
   AddParam Envia, "S"
   AddParam Envia, ftbTotalEmitido.Text
   AddParam Envia, Trim(Left(cmbSecurityType.Text, 2))
   AddParam Envia, Trim(Left(cmbCodificacion.Text, 3))
   AddParam Envia, Trim(Format(txtCodDcv.Text, "##,00"))
   AddParam Envia, Trim(TxtCodSvs.Text)                               'REQ.6010
   AddParam Envia, Trim(cmbUniTiempo.Text)                            'REQ.6010
   AddParam Envia, Trim(IIf(optPzoRem.Value = True, "PR", "PT"))      'REQ.6010
   
   '-------------Itaú------------------------
    AddParam Envia, Trim(Right(CmbInstDeuda.Text, 3))     '"Familias de Instrumentos Financieros de Deudas."
    AddParam Envia, Trim(Right(CmbTipoRendimiento, 3))    '"1° Digito - Tipo de Tasa."
    AddParam Envia, Trim(Right(CmbTipoTasa.Text, 2)) & _
                    Trim(Right(CmbComposicion.Text, 2)) & _
                    Trim(Right(CmbPeriodicidad.Text, 2)) & _
                    Trim(Right(CmbConvension.Text, 2)) & _
                    Trim(Right("0" & Right(CmbTasaVariable.Text, 2), 2)) & _
                    Trim(Right(CmbPlazoSubyacente.Text, 2))
    AddParam Envia, Trim(Right(CmbClasinstrumento.Text, 2))
   '-------------Itaú------------------------
   
   
   
   aux = 100
   If Bac_Sql_Execute("SP_GRABA_FAMILIA", Envia) Then
      Do While Bac_SQL_Fetch(DATOS())
         aux = 500
         If DATOS(1) = "NO" Then
            Exit Function
         End If
      Loop
   End If

   Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_615 ", "01", "Grabar Familia Instrumento", "Instrumento", " ", "Grabar Familia ." & " " & txtSerie.Text & " " & txtFamilia.Text & " " & txtCodFam.Text)
   GrabarFamilia = True
   
Exit Function
ErrGrabar:
   Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_615 ", "01", "ERROR Al Grabar Familia Instrumento", "Instrumento", " ", txtSerie.Text & " " & txtFamilia.Text & " " & txtCodFam.Text)
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
End Function

Function LeerFamilia(xFamilia As String) As Boolean
   Dim Cont As Single

   LeerFamilia = False

   Cont = 0
   Envia = Array()
   AddParam Envia, xFamilia
   If Not Bac_Sql_Execute("SP_TRAE_INSTRUMENTOS", Envia) Then
      Exit Function
   End If
   Do While Bac_SQL_Fetch(DATOS())
      Cont = Cont + 1
      xincodigo = DATOS(3)
      xinglosa = DATOS(2)
      xinrutemi = DATOS(6)
      xinmonemi = DATOS(7)
      xinbasemi = DATOS(8)
      xinprog = DATOS(4)
      xinrefnomi = DATOS(5)
      xinmdse = DATOS(11)
      xinmdpr = DATOS(12)
      xinmdtd = DATOS(13)
      xintipfec = DATOS(14)
      xintasest = DATOS(9)
      xintipo = DATOS(10)
      xinemision = DATOS(15)
      xineleg = DATOS(16)
      xincontab = DATOS(17)
      xSecuritytype = DATOS(18)
      xTotalEmitido = DATOS(19)
      xCodificacion = DATOS(21)
      xMnCodDcv = DATOS(22)
      xInCodSVS = DATOS(23)              ''REQ.6010
      xInUnidadTiempoTasaRef = DATOS(24) ''REQ.6010
      xInEstrucPlazoTasaRef = DATOS(25)  ''REQ.6010
      xacNomBCCH = DATOS(26)
      xintabla69 = DATOS(27)             ''LD1COR035
      xclasifIns = DATOS(28)             ''LD1COR035
      xintabla68 = DATOS(29)             ''LD1COR035
      xincodrend = DATOS(30)             ''LD1COR035
   Loop

   sql = "SELECT emgeneric,emcodigo FROM emisor WHERE emrut = " & xinrutemi
   If MISQL.SQL_Execute(sql) = 0 Then
      If MISQL.SQL_Fetch(DATOS()) = 0 Then
         emcodigo = CDbl(DATOS(2))
         emNemo = DATOS(1)
      End If
   Else
      Exit Function
   End If

   Envia = Array()
   AddParam Envia, xinmonemi
   If Bac_Sql_Execute("SP_FAMILIA_INS", Envia) Then
      If Bac_SQL_Fetch(DATOS()) Then
         mnCodfox = DATOS(1)
      End If
   Else
      Exit Function
   End If
   If Cont = 0 Then
      Exit Function
   End If

   LeerFamilia = True
End Function


Private Function ValidaDatos() As Boolean
    ValidaDatos = False
    
    If Trim(txtFamilia.Text) = "" Then
      MsgBox "Debe ingresar nombre de familia", vbOKOnly + vbExclamation, TITSISTEMA
      Exit Function
    End If
    
    If CDbl(txtCodFam.Text) = 0 Then
      MsgBox "Debe ingresar codigo familia", vbOKOnly + vbExclamation, TITSISTEMA
      Exit Function
    End If
    
    If Trim(txtRutina.Text) = "" Then
      MsgBox "Debe ingresar la rutina de valorización", vbOKOnly + vbCritical, TITSISTEMA
      Exit Function
    End If
    
    If CDbl(txtBase.Text) = 0 Then
      MsgBox "Debe ingresar base de calculo", vbOKOnly + vbExclamation, TITSISTEMA
      Exit Function
    End If
      
    If Trim(cmbTipo.Text) = "" Then
      MsgBox "Debe seleccionar tipo de emision", vbOKOnly + vbExclamation, TITSISTEMA
    End If
    
    If Trim(CmbTipoFecha) = "" Then
      MsgBox "Debe seleccionar tipo fecha", vbOKOnly + vbExclamation, TITSISTEMA
      Exit Function
    End If
    
    If Trim(CmbEmision) = "" Then
      MsgBox "Debe seleccionar emision", vbOKOnly + vbExclamation, TITSISTEMA
      Exit Function
    End If
    
    ''REQ.6010
    If Trim(TxtCodSvs.Text) = "" Then
      MsgBox "Debe ingresar un código SVS", vbOKOnly + vbExclamation, TITSISTEMA
      Exit Function
    End If
    
    ''LD1COR035
    If Trim(CmbClasinstrumento) = "" Then
      MsgBox "Debe seleccionar una clasifación de instrumento", vbOKOnly + vbExclamation, TITSISTEMA
      Exit Function
    End If
    
    ValidaDatos = True
  
End Function

Private Sub LimpiaControles()
   On Error GoTo Label1
   
   Screen.MousePointer = 0
   txtSerie.Enabled = True
   txtSerie.Text = ""
   txtFamilia.Text = ""
   txtRutEmi.Text = ""
   txtDigito.Text = ""
   txtNombreEmisor.Text = ""
   txtCodFam.Text = ""
   txtRutina.Text = ""
   opbNominal(0).Value = True
   txtMoneda.Text = ""
   txtDesMon.Text = ""
   txtBase.Text = ""
   txtIndTas.Text = ""
   txtDesIndTas.Text = ""
   ftbTotalEmitido.Text = ""
   chbSerie.Value = False
   opbPreDes(0).Value = False
   opbPreDes(1).Value = False
   Toolbar1.Buttons(1).Enabled = False
   Toolbar1.Buttons(2).Enabled = False
   cmbTipo.ListIndex = -1
   CmbTipoFecha.ListIndex = -1
   CmbEmision.ListIndex = -1
   cmbSecurityType.ListIndex = -1
   txtCodDcv.Text = "00"
   TxtCodSvs.Text = "" 'REQ.6010
   BtnOpeSoma.Enabled = False 'REQ.6010
   cmbUniTiempo.ListIndex = 0
   optPzoRem.Value = True
   optPzoTra.Value = False
   
   chbEleg.Value = False
   
   '--------------Itaú----------------------
    CmbInstDeuda.ListIndex = -1        '"Familias de Instrumentos Financieros de Deudas."
    CmbTipoRendimiento.ListIndex = -1  '"Tipo de Rendimiento Financiero del Instrumento."
    CmbTipoTasa.ListIndex = -1         '"1° Digito - Tipo de Tasa."
    CmbComposicion.ListIndex = -1      '"2° Digito - Composición."
    CmbPeriodicidad.ListIndex = -1     '"3° Digito - Periodicidad de Pago."
    CmbConvension.ListIndex = -1       '"4° Digito - Convensión Días."
    CmbTasaVariable.ListIndex = -1     '"5° y 6° Digito - Tipo de Tasa Variable."
    CmbPlazoSubyacente.ListIndex = -1  '"7° Digito - Plazo de Deposito Subyacente a Tasa Variable."
    CmbClasinstrumento.ListIndex = -1
   '--------------Itaú----------------------
   
Exit Sub
Label1:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
   
End Sub


Private Sub BtnOpeSoma_Click()
      ''REQ.6010
      
      If txtRutEmi.Text = xacNomBCCH Then
         MsgBox "No se puede parametrizar para Instrumentos emitidos por BCCH", vbInformation, App.Title
         Exit Sub
      End If

      Call BacMntInstSoma.Show(vbModal)
End Sub

Private Sub chbSerie_Click(Value As Integer)
   If Value = False Then
      opbPreDes(0).Value = False
      opbPreDes(1).Value = False
      Panel(3).Enabled = False
   Else
      Panel(3).Enabled = True
   End If
End Sub

Private Sub cmdEliminar_Click()
   On Error GoTo Label1
   Screen.MousePointer = 11
   If EliminarFamilia Then
      MsgBox "Se eliminó la Familia correctamente", vbOKOnly + vbInformation, TITSISTEMA
      Call LimpiaControles
   Else
      MsgBox "No se completo la eliminación de Familia", vbOKOnly + vbExclamation, TITSISTEMA
   End If
   Screen.MousePointer = 0
Exit Sub
Label1:
   Screen.MousePointer = 11
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
End Sub

Private Sub cmdGrabar_Click()
   On Error GoTo Label1

   If Not ValidaDatos Then
      Exit Sub
   End If
   Screen.MousePointer = vbHourglass
   If GrabarFamilia Then
      MsgBox "La grabación de Familia fue exitosa", vbOKOnly + vbInformation, TITSISTEMA
      Call LimpiaControles
   Else
      MsgBox "No se completo la grabación de Familia", vbOKOnly + vbExclamation, TITSISTEMA
   End If
   Screen.MousePointer = 0
Exit Sub
Label1:
   Screen.MousePointer = 0
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
End Sub


Private Sub cmdlimpiar_Click()
   Call LimpiaControles
End Sub

Private Sub cmdSalir_Click()
    Unload Me
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      SendKeys "{TAB}"
   End If
End Sub

Private Sub Form_Load()
   Me.Top = 0: Me.Left = 0
   Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_615", "07", "ingreso a Mantención Familia ", " ", " ", " ")

   On Error GoTo Label1

   If Not Llenar_Combos(cmbTipo, MDIN_TIPO) Then  '219
      MsgBox "No existen datos para categoria de 'Tipo de Instrumento'", vbOKOnly + vbExclamation, TITSISTEMA
      Unload Me
      Exit Sub
   End If
   cmbTipo.ListIndex = 0
    
   If Not Llenar_Combos(CmbTipoFecha, MDIN_TIPOFECHA) Then   '220
      MsgBox "No existen datos para categoria de 'Tipos de Fecha'", vbOKOnly + vbExclamation, TITSISTEMA
      Unload Me
      Exit Sub
   End If
   CmbTipoFecha.ListIndex = 0
   
   If Not Llenar_Combos(CmbEmision, MDIN_EMISION) Then  '221
      MsgBox "No existen datos para categoria de 'Emision'", vbOKOnly + vbExclamation, TITSISTEMA
      Unload Me
      Exit Sub
   End If
   CmbEmision.ListIndex = 0
   
   cmbSecurityType.AddItem "GO   Papeles BCCH  BR"
   cmbSecurityType.AddItem "MM  DPF,DPR,DPD,Fmutuos "
   cmbSecurityType.AddItem "MO   Letras Hipotecarias"
   cmbSecurityType.AddItem "CO   Bonos de Empresas y Bancarios"
   
   cmbSecurityType.ListIndex = 0
   cmbCodificacion.AddItem "FI   " & Space(5) & "FIXED INCOME"
   cmbCodificacion.AddItem "MM " & Space(5) & "MONEY MARKET"
   cmbCodificacion.AddItem "STD" & Space(5) & "SHORT TERM DEBT"
   cmbCodificacion.ListIndex = 0
    
   txtSerie.Enabled = True
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(1).Enabled = False

   ''REQ.6010
   BtnOpeSoma.Enabled = False
   
   cmbUniTiempo.AddItem "DIA"
   cmbUniTiempo.AddItem "MES"
   cmbUniTiempo.AddItem "AÑO"
   
   cmbUniTiempo.ListIndex = 0
   
   '-----------Itaú----------------
    SSTab.Tab = 0
    
    CmbInstDeuda.ToolTipText = "Familias de Instrumentos Financieros de Deudas."
    '----------------------------------
    If Not Llenar_Combos(CmbInstDeuda, 2457) Then
       MsgBox "No existen datos para categoria de 'Tipo Instrumento Financieros de Deuda'", vbOKOnly + vbExclamation, TITSISTEMA
       Unload Me
       Exit Sub
    End If
    CmbInstDeuda.ListIndex = 0
    
    CmbTipoRendimiento.ToolTipText = "Tipo de Rendimiento Financiero del Instrumento."
    '----------------------------------
    If Not Llenar_Combos(CmbTipoRendimiento, 2464) Then
       MsgBox "No existen datos para categoria de 'Tipo de Rendimiento Financiero'", vbOKOnly + vbExclamation, TITSISTEMA
       Unload Me
       Exit Sub
    End If
    CmbTipoRendimiento.ListIndex = 0
    Show
    CmbTipoTasa.ToolTipText = "1° Digito - Tipo de Tasa."
    '----------------------------------
    
    CmbTipoTasa.ToolTipText = "1° Digito - Tipo de Tasa."
    '----------------------------------
    If Not Llenar_Combos(CmbTipoTasa, 2458) Then
       MsgBox "No existen datos para categoria de 'Tipo de Tasa'", vbOKOnly + vbExclamation, TITSISTEMA
       Unload Me
       Exit Sub
    End If
    CmbTipoTasa.ListIndex = 0
    
    CmbComposicion.ToolTipText = "2° Digito - Composición."
    '----------------------------------
    If Not Llenar_Combos(CmbComposicion, 2459) Then
       MsgBox "No existen datos para categoria de 'Tipo Composición'", vbOKOnly + vbExclamation, TITSISTEMA
       Unload Me
       Exit Sub
    End If
    CmbComposicion.ListIndex = 0
    
    CmbPeriodicidad.ToolTipText = "3° Digito - Periodicidad de Pago."
    '----------------------------------
    If Not Llenar_Combos(CmbPeriodicidad, 2460) Then
       MsgBox "No existen datos para categoria de 'Tipo Periodicidad de Pago'", vbOKOnly + vbExclamation, TITSISTEMA
       Unload Me
       Exit Sub
    End If
    CmbPeriodicidad.ListIndex = 0
    
    CmbConvension.ToolTipText = "4° Digito - Convensión Días."
    '----------------------------------
    If Not Llenar_Combos(CmbConvension, 2461) Then
       MsgBox "No existen datos para categoria de 'Tipo Convensión Días'", vbOKOnly + vbExclamation, TITSISTEMA
       Unload Me
       Exit Sub
    End If
    CmbConvension.ListIndex = 0
    
    CmbTasaVariable.ToolTipText = "5° y 6° Digito - Tipo de Tasa Variable."
    '----------------------------------
    If Not Llenar_Combos(CmbTasaVariable, 2462) Then
       MsgBox "No existen datos para categoria de 'Tipo Tipo de Tasa Variable'", vbOKOnly + vbExclamation, TITSISTEMA
       Unload Me
       Exit Sub
    End If
    CmbTasaVariable.ListIndex = 0
    
    CmbPlazoSubyacente.ToolTipText = "7° Digito - Plazo de Deposito Subyacente a Tasa Variable."
    '----------------------------------
    If Not Llenar_Combos(CmbPlazoSubyacente, 2463) Then
       MsgBox "No existen datos para categoria de 'Tipo Plazo de Deposito Subyacente a Tasa Variable'", vbOKOnly + vbExclamation, TITSISTEMA
       Unload Me
       Exit Sub
    End If
    CmbPlazoSubyacente.ListIndex = 0
    '----------------------------------
    If Not Llenar_Combos(CmbClasinstrumento, 1622) Then
       MsgBox "No existen datos para clasificacion de 'instrumento'", vbOKOnly + vbExclamation, TITSISTEMA
       Unload Me
       Exit Sub
    End If
    CmbClasinstrumento.ListIndex = 0
    
    
      
  '-----------Itaú----------------
   
Exit Sub
Label1:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
   Unload Me
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         On Error GoTo Label1
         If Not ValidaDatos Then
            Exit Sub
         End If
         Screen.MousePointer = vbHourglass
         If GrabarFamilia Then
            If aux = 500 Then
               MsgBox "La grabación de Familia fue exitosa", vbOKOnly + vbInformation, TITSISTEMA
               Call LimpiaControles
            Else
               MsgBox "  No se completo la grabación de Familia..." & Chr(13) & Chr(13) & "- Posiblemente el nombre que le dio a la familia no exista," & Chr(13) & "  pero ya existe una familia con el codigo ingresado", vbOKOnly + vbExclamation, TITSISTEMA
            End If
         Else
            MsgBox "  No se completo la grabación de Familia..." & Chr(13) & Chr(13) & "- Posiblemente el nombre que le dio a la familia no exista," & Chr(13) & "  pero ya existe una familia con el codigo ingresado", vbOKOnly + vbExclamation, TITSISTEMA
         End If
         Screen.MousePointer = 0
Exit Sub
Label1:
   Screen.MousePointer = 0
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
      Case 2
         Dim cc
         cc = MsgBox("Seguro de Eliminar Familia :" & Chr(13) & txtFamilia.Text, vbQuestion + vbYesNo, TITSISTEMA)
         If cc = 6 Then
            On Error GoTo Label11
            Screen.MousePointer = 11
            If EliminarFamilia Then
               MsgBox "Se eliminó la Familia correctamente", vbOKOnly + vbInformation, TITSISTEMA
               LimpiaControles
            Else
               MsgBox "No se completo la eliminación de Familia", vbOKOnly + vbExclamation, TITSISTEMA
            End If
            Screen.MousePointer = 0
            On Error GoTo 0
Exit Sub
Label11:
            Screen.MousePointer = 11
            MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
            On Error GoTo 0
            Exit Sub
         End If
      Case 3
         Call LimpiaControles
      Case 4
         Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_615 ", "08", "Salir Opcion De Familia Instrumento", " ", " ", " ")
         Unload Me
   End Select
End Sub

Private Sub txtBase_KeyPress(KeyAscii As Integer)
    
    BacCaracterNumerico KeyAscii
    
End Sub

Private Sub txtCodDcv_Change()
   If Len(txtCodDcv.Text) = 0 Then
      txtCodDcv.Text = 0
   End If
   txtCodDcv.Text = Val(txtCodDcv.Text)
   txtCodDcv.SelStart = Len(txtCodDcv.Text)
   
End Sub

Private Sub txtCodFam_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
End Sub


Private Sub TxtCodSvs_KeyPress(KeyAscii As Integer)
   Let KeyAscii = Asc(UCase(Chr(KeyAscii))) 'req.6010
End Sub

Private Sub txtDesIndTas_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
End Sub

Private Sub txtFamilia_KeyPress(KeyAscii As Integer)

    BacToUCase KeyAscii
    
End Sub


Sub Ind_Tas()
   On Error GoTo Label1
   BacAyuda.Tag = "MDMN"
   BacAyuda.Show 1
   
   If giAceptar% = True Then
      txtIndTas.Text = gsCodigo$
      txtDesIndTas.Text = gsDescripcion$
      SendKeys "{TAB}"
   End If
Exit Sub
Label1:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
End Sub

Private Sub txtIndTas_DblClick()
   Call Ind_Tas
End Sub

Private Sub txtIndTas_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then
      Call Ind_Tas
   End If
End Sub

Private Sub txtIndTas_KeyPress(KeyAscii As Integer)
    BacCaracterNumerico KeyAscii
End Sub

Private Sub txtIndTas_LostFocus()
   Dim Cont As Single
   
   If Trim$(txtIndTas.Text) = "" Then
      Exit Sub
   End If
   If CDbl(txtIndTas.Text) = 0 Then
      Exit Sub
   End If

   Cont = 0
   Envia = Array()
   AddParam Envia, CDbl(txtIndTas.Text)
   If Bac_Sql_Execute("SP_TRAE_MONEDA ", Envia) Then
      Do While Bac_SQL_Fetch(DATOS())
         Cont = Cont + 1
         txtDesIndTas.Text = DATOS(1)
      Loop
   End If
   If Cont = 0 Then
      MsgBox "No existe Moneda", vbOKOnly + vbExclamation, TITSISTEMA
      txtIndTas.Text = ""
      txtDesIndTas.Text = ""
      txtIndTas.SetFocus
   End If
End Sub

Sub mone()
   On Error GoTo Label1
   BacAyuda.Tag = "MDMN"
   BacAyuda.Show 1
   If giAceptar% = True Then
      txtMoneda.Text = gsCodigo$
      txtDesMon.Text = gsDescripcion$
      SendKeys "{TAB}"
   End If
Exit Sub
Label1:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
End Sub

Private Sub txtMoneda_DblClick()
   auxilio = 100
   Call mone
End Sub
Private Sub txtMoneda_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then
      Call mone
   End If
End Sub

Private Sub txtMoneda_KeyPress(KeyAscii As Integer)
    Call BacCaracterNumerico(KeyAscii)
End Sub

Private Sub txtMoneda_LostFocus()
   Dim Cont As Single
   
   If txtMoneda.Text = "" Then
      Exit Sub
   End If
   If CDbl(txtMoneda.Text) = 0 Then
      Exit Sub
   End If

   Cont = 0
   Envia = Array()
   AddParam Envia, CDbl(txtMoneda.Text)
   If Bac_Sql_Execute("SP_TRAE_MONEDA ", Envia) Then
      Do While Bac_SQL_Fetch(DATOS())
         Cont = Cont + 1
         txtDesMon.Text = DATOS(1)
         txtBase.Text = IIf(xinbasemi = 0, CDbl(DATOS(3)), xinbasemi)
      Loop
   End If
   If DATOS(1) = "0" Then
      MsgBox "No existe Moneda", vbOKOnly + vbExclamation, TITSISTEMA
      txtMoneda.Text = ""
      txtDesMon.Text = ""
      txtMoneda.SetFocus
   End If
End Sub

Private Sub txtRutEmi_Change()
   txtDigito.Text = ""
   txtNombreEmisor.Text = ""
End Sub

Sub Rut_Emi()
   On Error GoTo Label1
   BacAyuda.Tag = "MDEM"
   BacAyuda.Show 1
   If giAceptar% = True Then
      txtRutEmi.Text = gsCodigo$
      txtDigito.Text = gsDigito$
      txtNombreEmisor.Text = gsDescripcion$
      If CDbl(txtRutEmi.Text) = 0 Or Trim$(txtDigito.Text) = "" Then
         Exit Sub
      End If
      SendKeys "{TAB}"
   End If
Exit Sub
Label1:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
End Sub

Private Sub txtRutEmi_DblClick()
   Call Rut_Emi
End Sub
Private Sub txtRutEmi_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then
      Call Rut_Emi
   End If
End Sub

Private Sub txtRutEmi_KeyPress(KeyAscii As Integer)
    Call BacCaracterNumerico(KeyAscii)
End Sub

Private Sub txtRutEmi_LostFocus()
   Dim Cont As Single
   
   If Trim$(txtRutEmi.Text) = "" Then
      Exit Sub
   End If
   If CDbl(txtRutEmi.Text) = 0 Then
      Exit Sub
   End If

   On Error GoTo Label1
   Cont = 0
   sql = "SP_TRAE_EMISOR " & CDbl(txtRutEmi.Text)
   If MISQL.SQL_Execute(sql) = 0 Then
      Do While MISQL.SQL_Fetch(DATOS()) = 0
         Cont = Cont + 1
         txtDigito.Text = DATOS(7)
         txtNombreEmisor.Text = DATOS(4) 'modificado antes datos(2)
      Loop
   End If
   If Cont = 0 Then
      MsgBox "El cliente no existe", vbOKOnly + vbExclamation, TITSISTEMA
      txtRutEmi.Text = ""
      txtDigito.Text = ""
      txtNombreEmisor.Text = ""
   End If
Exit Sub
Label1:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
End Sub

Private Sub txtRutina_KeyPress(KeyAscii As Integer)
    Call BacToUCase(KeyAscii)
End Sub

Sub TSerie()
   On Error GoTo Label1
   Call LimpiaControles
   BacAyuda.Tag = "MDIN"
   BacAyuda.Show 1
   If giAceptar% = True Then
      txtSerie.Text = gsSerie$
      txtCodFam.Text = gsCodigo$
      ''REQ.6010
      BtnOpeSoma.Enabled = True
      SendKeys "{TAB}"
   End If
   If opbNominal(0).Value = True Then
      opbNominal(0).TabStop = True
      opbNominal(1).TabStop = False
   Else
      opbNominal(0).TabStop = False
      opbNominal(1).TabStop = True
   End If
   If opbPreDes(0).Value = True Then
      opbPreDes(0).TabStop = True
      opbPreDes(1).TabStop = False
   Else
      opbPreDes(0).TabStop = False
      opbPreDes(1).TabStop = True
   End If
Exit Sub
Label1:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
End Sub
Private Sub txtSerie_DblClick()
   Call TSerie
End Sub

Private Sub txtSerie_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then
      Call TSerie
   End If
End Sub

Private Sub txtSerie_KeyPress(KeyAscii As Integer)
    Call BacToUCase(KeyAscii)
End Sub

Private Sub txtSerie_LostFocus()
   On Error GoTo Label1
   Dim Idserie    As String
   Dim iContador  As Integer

   Screen.MousePointer = vbHourglass
    
   If txtSerie.Tag = "SERIE" Then
      Screen.MousePointer = 0
      Exit Sub
   End If
   If Trim(txtSerie.Text) = "" Then
      Screen.MousePointer = 0
      Exit Sub
   End If
    
   Toolbar1.Buttons(1).Enabled = True
   txtSerie.Enabled = False
    
   If LeerFamilia(txtSerie.Text) Then
      txtCodFam.Text = xincodigo
      txtFamilia.Text = xinglosa
      txtRutEmi.Text = xinrutemi
      
      'REQ.6010--Ini--
      TxtCodSvs.Text = xInCodSVS
      cmbUniTiempo.Text = xInUnidadTiempoTasaRef
      optPzoRem.Value = IIf(xInEstrucPlazoTasaRef = "PR", True, False)
      optPzoTra.Value = IIf(xInEstrucPlazoTasaRef = "PT", True, False)
      'REQ.6010--Fin--

      Call txtRutEmi_LostFocus
      
      txtMoneda.Text = xinmonemi
      Call txtMoneda_LostFocus
      
      txtBase.Text = xinbasemi
      txtRutina.Text = xinprog
      ftbTotalEmitido.Text = xTotalEmitido
        
      If xinrefnomi = "E" Then
         opbNominal(0).Value = True
      Else
         opbNominal(1).Value = True
      End If
      chbSerie.Value = IIf(xinmdse = "S", True, False)
      opbPreDes(0).Value = IIf(xinmdpr = "S", True, False)
      opbPreDes(1).Value = IIf(xinmdtd = "S", True, False)
        
      CmbTipoFecha.ListIndex = BuscaEnCombo(CmbTipoFecha, Str(xintipfec), "C")
      txtIndTas.Text = xintasest
      Call txtIndTas_LostFocus
      cmbTipo.ListIndex = BuscaEnCombo(cmbTipo, xintipo, "G")
      CmbEmision.ListIndex = BuscaEnCombo(CmbEmision, xinemision, "G")
      CmbClasinstrumento.ListIndex = BuscaEnCombo(CmbClasinstrumento, xclasifIns, "C")
        
      For iContador = 0 To cmbSecurityType.ListCount - 1
         If Mid$(cmbSecurityType.List(iContador), 1, 2) = Trim$(xSecuritytype) Then
            cmbSecurityType.ListIndex = iContador
            Exit For
         End If
      Next iContador
      
      For iContador = 0 To cmbCodificacion.ListCount - 1
         If Trim(Mid$(cmbCodificacion.List(iContador), 1, 3)) = Trim$(xCodificacion) Then
            cmbCodificacion.ListIndex = iContador
            Exit For
         End If
      Next iContador
      
      If xineleg = "S" Then
         chbEleg.Value = True
      Else
         chbEleg.Value = False
      End If
      txtCodDcv.Text = xMnCodDcv
        
     '-----------------Itaú----------------------
        CmbInstDeuda.ListIndex = BuscaEnCombo(CmbInstDeuda, xintabla68, "C")                        '"Familias de Instrumentos Financieros de Deudas."
        CmbTipoRendimiento.ListIndex = BuscaEnCombo(CmbTipoRendimiento, xincodrend, "C")            '"Tipo de Rendimiento Financiero del Instrumento."
        CmbTipoTasa.ListIndex = BuscaEnCombo(CmbTipoTasa, Mid(xintabla69, 1, 1), "C")               '"1° Digito - Tipo de Tasa."
        CmbComposicion.ListIndex = BuscaEnCombo(CmbComposicion, Mid(xintabla69, 2, 1), "C")         '"2° Digito - Composición."
        CmbPeriodicidad.ListIndex = BuscaEnCombo(CmbPeriodicidad, Mid(xintabla69, 3, 1), "C")       '"3° Digito - Periodicidad de Pago."
        CmbConvension.ListIndex = BuscaEnCombo(CmbConvension, Mid(xintabla69, 4, 1), "C")           '"4° Digito - Convensión Días."
        CmbTasaVariable.ListIndex = BuscaEnCombo(CmbTasaVariable, Mid(xintabla69, 5, 1), "C")       '"5° y 6° Digito - Tipo de Tasa Variable."
        CmbPlazoSubyacente.ListIndex = BuscaEnCombo(CmbPlazoSubyacente, Mid(xintabla69, 6, 1), "C") '"7° Digito - Plazo de Deposito Subyacente a Tasa Variable."

     '-----------------Itaú----------------------
        
        
      Toolbar1.Buttons(2).Enabled = True
   Else
      Screen.MousePointer = 0
      Exit Sub
   End If
   txtFamilia.SetFocus
   Screen.MousePointer = 0
Exit Sub
Label1:
   Screen.MousePointer = 0
End Sub
