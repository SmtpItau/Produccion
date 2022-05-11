VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacLinCreGen3 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Lineas de Creditos Generales"
   ClientHeight    =   7950
   ClientLeft      =   -180
   ClientTop       =   1005
   ClientWidth     =   11955
   Icon            =   "BacLinCreGen3.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7950
   ScaleWidth      =   11955
   Begin VB.CommandButton CmdMet06 
      Caption         =   "Met 6"
      Height          =   495
      Index           =   2
      Left            =   7200
      TabIndex        =   123
      Top             =   0
      Width           =   735
   End
   Begin MSComctlLib.Toolbar Toolbar2 
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   18540
      _ExtentX        =   32703
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   9
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Elimina"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Lineas por Plazo"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Detalle Clientes"
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Reporte"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Act. y Valida Modelo VAR Bac"
            ImageIndex      =   8
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin VB.CommandButton CmdMet05 
         Caption         =   "Met 5"
         Height          =   495
         Index           =   0
         Left            =   6240
         TabIndex        =   93
         Top             =   0
         Width           =   735
      End
      Begin VB.CommandButton CmdMet03 
         Caption         =   "Met 3"
         Height          =   495
         Index           =   0
         Left            =   5280
         TabIndex        =   91
         Top             =   0
         Width           =   735
      End
      Begin VB.CommandButton CmdMet02 
         Caption         =   "Met 2"
         Height          =   495
         Index           =   0
         Left            =   4320
         TabIndex        =   89
         Top             =   0
         Width           =   735
      End
      Begin VB.CommandButton CmdLcr 
         Caption         =   "LCR"
         Height          =   420
         Index           =   0
         Left            =   3600
         TabIndex        =   87
         Top             =   30
         Width           =   495
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   6990
      Left            =   75
      TabIndex        =   3
      Top             =   915
      Width           =   11835
      _Version        =   65536
      _ExtentX        =   20876
      _ExtentY        =   12330
      _StockProps     =   15
      Caption         =   "NO HABILITADO"
      BackColor       =   14215660
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Outline         =   -1  'True
      Begin VB.Frame FRA_OTR_INST 
         Height          =   6915
         Left            =   0
         TabIndex        =   4
         Top             =   0
         Width           =   11715
         Begin Threed.SSFrame SSFrame4 
            Height          =   1680
            Left            =   45
            TabIndex        =   5
            Top             =   105
            Width           =   11595
            _Version        =   65536
            _ExtentX        =   20452
            _ExtentY        =   2963
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
            Begin VB.ComboBox CMBMonedaThreshold2 
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   315
               Left            =   10575
               Style           =   2  'Dropdown List
               TabIndex        =   88
               Top             =   930
               Width           =   945
            End
            Begin BACControles.TXTNumero TXTMtoThresHold2 
               Height          =   315
               Left            =   8385
               TabIndex        =   80
               Top             =   930
               Width           =   2280
               _ExtentX        =   4022
               _ExtentY        =   556
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Text            =   "0"
               Text            =   "0"
               Min             =   "-999999999999999"
               Max             =   "999999999999999"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
            Begin BACControles.TXTFecha TxtFecAsi2 
               Height          =   315
               Left            =   1920
               TabIndex        =   6
               Top             =   540
               Width           =   1695
               _ExtentX        =   2990
               _ExtentY        =   556
               Enabled         =   -1  'True
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "24/11/2003"
            End
            Begin BACControles.TXTFecha TxtFecVen2 
               Height          =   315
               Left            =   5625
               TabIndex        =   8
               Top             =   540
               Width           =   1695
               _ExtentX        =   2990
               _ExtentY        =   556
               Enabled         =   -1  'True
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "24/11/2003"
            End
            Begin BACControles.TXTFecha txtFecFinCon2 
               Height          =   315
               Left            =   1920
               TabIndex        =   9
               Top             =   920
               Width           =   1695
               _ExtentX        =   2990
               _ExtentY        =   556
               Enabled         =   -1  'True
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "24/11/2003"
            End
            Begin BACControles.TXTNumero TxtRut2 
               Height          =   315
               Left            =   1440
               TabIndex        =   7
               Top             =   180
               Width           =   1695
               _ExtentX        =   2990
               _ExtentY        =   556
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Text            =   "0"
               Text            =   "0"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
            Begin BACControles.TXTNumero TxtCodCli2 
               Height          =   315
               Left            =   3960
               TabIndex        =   47
               Top             =   180
               Width           =   495
               _ExtentX        =   873
               _ExtentY        =   556
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Text            =   "0"
               Text            =   "0"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
            Begin VB.Label Label33 
               Caption         =   "Ejecutivo Comercial"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   6000
               TabIndex        =   120
               Top             =   1320
               Width           =   1725
            End
            Begin VB.Label Label32 
               Caption         =   "Seg. Comercial"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   120
               TabIndex        =   119
               Top             =   1320
               Width           =   1605
            End
            Begin VB.Label LabEjecComercial2 
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   7920
               TabIndex        =   118
               Top             =   1245
               Width           =   3600
            End
            Begin VB.Label LabSegComercial2 
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   1920
               TabIndex        =   117
               Top             =   1245
               Width           =   3480
            End
            Begin VB.Label LabCodMetodologia2 
               Alignment       =   1  'Right Justify
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   8400
               TabIndex        =   106
               Top             =   555
               Width           =   315
            End
            Begin VB.Label LabNomMetod2 
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   8760
               TabIndex        =   96
               Top             =   555
               Width           =   2760
            End
            Begin VB.Label Label18 
               Caption         =   "Metodología"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   240
               Left            =   7440
               TabIndex        =   95
               Top             =   600
               Width           =   1275
            End
            Begin VB.Label LblMtoThresHold 
               Caption         =   "USD"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   225
               Left            =   11085
               TabIndex        =   85
               Top             =   915
               Width           =   405
            End
            Begin VB.Label Label12 
               Caption         =   "Monto ThresHold"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   240
               Left            =   7080
               TabIndex        =   84
               Top             =   915
               Width           =   1395
            End
            Begin VB.Label labDigVeri2 
               Alignment       =   1  'Right Justify
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   3420
               TabIndex        =   18
               Top             =   180
               Width           =   315
            End
            Begin VB.Label LabNombre2 
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   4600
               TabIndex        =   17
               Top             =   180
               Width           =   6405
            End
            Begin VB.Label Label13 
               Caption         =   "Cliente"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   90
               TabIndex        =   16
               Top             =   255
               Width           =   1155
            End
            Begin VB.Label Label14 
               Caption         =   "Fecha de Vencimiento"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   3930
               TabIndex        =   15
               Top             =   585
               Width           =   2010
            End
            Begin VB.Label Label15 
               Caption         =   "Fecha Fin Contrato"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   90
               TabIndex        =   14
               Top             =   945
               Width           =   1725
            End
            Begin VB.Label Label19 
               Caption         =   "Fecha Asignacion"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   90
               TabIndex        =   13
               Top             =   585
               Width           =   1680
            End
            Begin VB.Label Label20 
               Caption         =   "Bloqueado"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   3930
               TabIndex        =   12
               Top             =   945
               Width           =   1065
            End
            Begin VB.Label LabBloq2 
               Alignment       =   2  'Center
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H000000FF&
               Height          =   315
               Left            =   5640
               TabIndex        =   11
               Top             =   915
               Width           =   780
            End
         End
         Begin Threed.SSFrame SSFrame5 
            Height          =   1995
            Left            =   45
            TabIndex        =   19
            Top             =   1800
            Width           =   11595
            _Version        =   65536
            _ExtentX        =   20452
            _ExtentY        =   3519
            _StockProps     =   14
            Caption         =   "[ Lineas Generales ]"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin VB.PictureBox Picture1 
               Height          =   0
               Left            =   0
               ScaleHeight     =   0
               ScaleWidth      =   0
               TabIndex        =   21
               Top             =   0
               Width           =   0
            End
            Begin VB.ComboBox Cmb_MonedaLG2 
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   315
               Left            =   240
               Style           =   2  'Dropdown List
               TabIndex        =   20
               Top             =   550
               Visible         =   0   'False
               Width           =   2175
            End
            Begin BACControles.TXTNumero LabTotLin2 
               Height          =   315
               Left            =   4410
               TabIndex        =   22
               Top             =   510
               Width           =   2670
               _ExtentX        =   4710
               _ExtentY        =   556
               BackColor       =   -2147483633
               ForeColor       =   8388608
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Text            =   "0"
               Text            =   "0"
               Min             =   "-1E+15"
               Max             =   "1E+15"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
            Begin VB.Label LabGarEfect2 
               Alignment       =   1  'Right Justify
               BorderStyle     =   1  'Fixed Single
               Caption         =   "0"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   8280
               TabIndex        =   109
               Top             =   1560
               Width           =   2655
            End
            Begin VB.Label LabGarAsoc2 
               Alignment       =   1  'Right Justify
               BorderStyle     =   1  'Fixed Single
               Caption         =   "0"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   4440
               TabIndex        =   108
               Top             =   1560
               Width           =   2655
            End
            Begin VB.Label LabGarConst2 
               Alignment       =   1  'Right Justify
               BorderStyle     =   1  'Fixed Single
               Caption         =   "0"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   840
               TabIndex        =   107
               Top             =   1560
               Width           =   2655
            End
            Begin VB.Label Label23 
               Caption         =   "Total Garantías en Efectivo"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   7800
               TabIndex        =   99
               Top             =   1320
               Width           =   2880
            End
            Begin VB.Label Label22 
               Caption         =   "Total Garantías Asociadas"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   3960
               TabIndex        =   98
               Top             =   1320
               Width           =   3000
            End
            Begin VB.Label Label21 
               Caption         =   "Garantías Constituidas"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   360
               TabIndex        =   97
               Top             =   1320
               Width           =   2160
            End
            Begin VB.Label Lbl_MonedaGen2 
               Alignment       =   2  'Center
               BorderStyle     =   1  'Fixed Single
               Caption         =   "--------------------"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   255
               Left            =   240
               TabIndex        =   32
               Top             =   585
               Width           =   2175
            End
            Begin VB.Label Lbl_Auxi2 
               Height          =   255
               Left            =   1920
               TabIndex        =   31
               Top             =   360
               Visible         =   0   'False
               Width           =   495
            End
            Begin VB.Label Label8 
               Caption         =   "Moneda"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   120
               TabIndex        =   30
               Top             =   350
               Width           =   720
            End
            Begin VB.Label LabTotExe2 
               Alignment       =   1  'Right Justify
               BorderStyle     =   1  'Fixed Single
               Caption         =   "0"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   8805
               TabIndex        =   29
               Top             =   870
               Width           =   2655
            End
            Begin VB.Label LabTotOcu2 
               Alignment       =   1  'Right Justify
               BorderStyle     =   1  'Fixed Single
               Caption         =   "0"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H000000FF&
               Height          =   315
               Left            =   8805
               TabIndex        =   28
               Top             =   510
               Width           =   2655
            End
            Begin VB.Label Label30 
               Caption         =   "Total Exceso"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   7305
               TabIndex        =   27
               Top             =   915
               Width           =   1200
            End
            Begin VB.Label Label31 
               Caption         =   "Total Ocupado"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   7305
               TabIndex        =   26
               Top             =   570
               Width           =   1350
            End
            Begin VB.Label LabTotDis2 
               Alignment       =   1  'Right Justify
               BorderStyle     =   1  'Fixed Single
               Caption         =   "0"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   4410
               TabIndex        =   25
               Top             =   870
               Width           =   2655
            End
            Begin VB.Label Label35 
               Caption         =   "Total Disponible"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   2730
               TabIndex        =   24
               Top             =   915
               Width           =   1440
            End
            Begin VB.Label Label36 
               Caption         =   "Total Linea"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   2730
               TabIndex        =   23
               Top             =   570
               Width           =   1440
            End
         End
         Begin Threed.SSFrame SSFrame6 
            Height          =   3135
            Left            =   45
            TabIndex        =   33
            Top             =   3720
            Width           =   11595
            _Version        =   65536
            _ExtentX        =   20452
            _ExtentY        =   5530
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
            Begin VB.TextBox txtNumGrid2 
               Alignment       =   1  'Right Justify
               BackColor       =   &H8000000D&
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H8000000E&
               Height          =   315
               Left            =   4080
               TabIndex        =   35
               Text            =   "0"
               Top             =   930
               Width           =   2175
            End
            Begin VB.ComboBox CmbGrid2 
               BackColor       =   &H8000000D&
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H8000000E&
               Height          =   315
               Left            =   330
               Style           =   2  'Dropdown List
               TabIndex        =   34
               Top             =   930
               Visible         =   0   'False
               Width           =   1700
            End
            Begin BACControles.TXTFecha txtFecGrid2 
               Height          =   315
               Left            =   2130
               TabIndex        =   36
               Top             =   930
               Width           =   1815
               _ExtentX        =   3201
               _ExtentY        =   556
               BackColor       =   -2147483635
               Enabled         =   -1  'True
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   -2147483634
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "24/11/2003"
            End
            Begin MSFlexGridLib.MSFlexGrid GridOculta2 
               Height          =   1035
               Left            =   3615
               TabIndex        =   37
               TabStop         =   0   'False
               Top             =   3615
               Visible         =   0   'False
               Width           =   2790
               _ExtentX        =   4921
               _ExtentY        =   1826
               _Version        =   393216
               Rows            =   1
               Cols            =   14
               FixedRows       =   0
               FixedCols       =   0
               TextStyle       =   2
               TextStyleFixed  =   2
            End
            Begin MSFlexGridLib.MSFlexGrid Oculta2 
               Height          =   1080
               Left            =   6225
               TabIndex        =   38
               Top             =   3600
               Visible         =   0   'False
               Width           =   3015
               _ExtentX        =   5318
               _ExtentY        =   1905
               _Version        =   393216
               Rows            =   3
               Cols            =   3
               FixedRows       =   2
               FixedCols       =   0
            End
            Begin MSFlexGridLib.MSFlexGrid Grid2 
               Height          =   2955
               Left            =   120
               TabIndex        =   39
               Top             =   120
               Width           =   11460
               _ExtentX        =   20214
               _ExtentY        =   5212
               _Version        =   393216
               BackColor       =   -2147483633
               BackColorFixed  =   -2147483646
               ForeColorFixed  =   -2147483639
               BackColorBkg    =   -2147483636
               FocusRect       =   0
               GridLines       =   2
               GridLinesFixed  =   0
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
            Begin VB.Label Lbl_Grid1 
               Caption         =   "Lbl_Grid1"
               Height          =   615
               Left            =   1800
               TabIndex        =   40
               Top             =   360
               Visible         =   0   'False
               Width           =   2775
            End
         End
      End
      Begin VB.Frame FRA_INST_FIN 
         Height          =   6915
         Left            =   0
         TabIndex        =   41
         Top             =   0
         Width           =   11715
         Begin Threed.SSFrame SSFrame1 
            Height          =   1680
            Left            =   45
            TabIndex        =   42
            Top             =   105
            Width           =   11595
            _Version        =   65536
            _ExtentX        =   20452
            _ExtentY        =   2963
            _StockProps     =   14
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin VB.ComboBox CMBMonedaThreshold 
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   315
               Left            =   10605
               Style           =   2  'Dropdown List
               TabIndex        =   82
               Top             =   930
               Width           =   945
            End
            Begin BACControles.TXTNumero TxtMtoThresHold 
               Height          =   315
               Left            =   8385
               TabIndex        =   79
               Top             =   930
               Width           =   2280
               _ExtentX        =   4022
               _ExtentY        =   556
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Text            =   "0"
               Text            =   "0"
               Min             =   "-999999999999999"
               Max             =   "999999999999999"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
            Begin BACControles.TXTFecha TxtFecAsi 
               Height          =   315
               Left            =   1920
               TabIndex        =   43
               Top             =   540
               Width           =   1695
               _ExtentX        =   2990
               _ExtentY        =   556
               Enabled         =   -1  'True
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "24/11/2003"
            End
            Begin BACControles.TXTNumero TxtRut 
               Height          =   315
               Left            =   1440
               TabIndex        =   44
               Top             =   180
               Width           =   1695
               _ExtentX        =   2990
               _ExtentY        =   556
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Text            =   "0"
               Text            =   "0"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
            Begin BACControles.TXTFecha TxtFecVen 
               Height          =   315
               Left            =   5625
               TabIndex        =   45
               Top             =   555
               Width           =   1695
               _ExtentX        =   2990
               _ExtentY        =   556
               Enabled         =   -1  'True
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "24/11/2003"
            End
            Begin BACControles.TXTFecha txtFecFinCon 
               Height          =   315
               Left            =   1920
               TabIndex        =   46
               Top             =   920
               Width           =   1695
               _ExtentX        =   2990
               _ExtentY        =   556
               Enabled         =   -1  'True
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "24/11/2003"
            End
            Begin BACControles.TXTNumero TxtCodCli 
               Height          =   315
               Left            =   3960
               TabIndex        =   10
               Top             =   180
               Width           =   495
               _ExtentX        =   873
               _ExtentY        =   556
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Text            =   "0"
               Text            =   "0"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
            Begin VB.Label Label37 
               Caption         =   "Ejecutivo Comercial"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   6000
               TabIndex        =   116
               Top             =   1320
               Width           =   1725
            End
            Begin VB.Label Label34 
               Caption         =   "Seg. Comercial"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   120
               TabIndex        =   115
               Top             =   1320
               Width           =   1605
            End
            Begin VB.Label LabSegComercial 
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   1920
               TabIndex        =   114
               Top             =   1245
               Width           =   3480
            End
            Begin VB.Label LabEjecComercial 
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   7920
               TabIndex        =   113
               Top             =   1245
               Width           =   3600
            End
            Begin VB.Label LabCodMetodologia 
               Alignment       =   1  'Right Justify
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   8400
               TabIndex        =   105
               Top             =   555
               Width           =   315
            End
            Begin VB.Label Label28 
               Caption         =   "Metodología"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   240
               Left            =   7440
               TabIndex        =   104
               Top             =   600
               Width           =   1275
            End
            Begin VB.Label LabNomMetod 
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   8760
               TabIndex        =   103
               Top             =   555
               Width           =   2760
            End
            Begin VB.Label LblMtoThresHold2 
               Caption         =   "CLP"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   285
               Left            =   11085
               TabIndex        =   86
               Top             =   915
               Width           =   375
            End
            Begin VB.Label Label9 
               Caption         =   "Monto ThresHold"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   255
               Left            =   7080
               TabIndex        =   81
               Top             =   930
               Width           =   1515
            End
            Begin VB.Label LabCodCliCasMat 
               Alignment       =   1  'Right Justify
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   3735
               TabIndex        =   59
               Top             =   1395
               Visible         =   0   'False
               Width           =   1170
            End
            Begin VB.Label labDigVerCasMat 
               Alignment       =   1  'Right Justify
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   3405
               TabIndex        =   58
               Top             =   1395
               Visible         =   0   'False
               Width           =   315
            End
            Begin VB.Label labNomCasMat 
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   4920
               TabIndex        =   57
               Top             =   1395
               Visible         =   0   'False
               Width           =   4395
            End
            Begin VB.Label Label3 
               Caption         =   "Casa Matriz"
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   105
               TabIndex        =   56
               Top             =   1395
               Visible         =   0   'False
               Width           =   1155
            End
            Begin VB.Label LabBloq 
               Alignment       =   2  'Center
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H000000FF&
               Height          =   315
               Left            =   5640
               TabIndex        =   55
               Top             =   930
               Width           =   780
            End
            Begin VB.Label Label6 
               Caption         =   "Bloqueado"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   3930
               TabIndex        =   54
               Top             =   945
               Width           =   1065
            End
            Begin VB.Label Label5 
               Caption         =   "Fecha Asignacion"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   90
               TabIndex        =   53
               Top             =   585
               Width           =   1680
            End
            Begin VB.Label Label2 
               Caption         =   "Fecha Fin Contrato"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   90
               TabIndex        =   52
               Top             =   945
               Width           =   1725
            End
            Begin VB.Label Label1 
               Caption         =   "Fecha de Vencimiento"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   3930
               TabIndex        =   51
               Top             =   585
               Width           =   2010
            End
            Begin VB.Label Label4 
               Caption         =   "Cliente"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   90
               TabIndex        =   50
               Top             =   255
               Width           =   1155
            End
            Begin VB.Label LabNombre 
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   4600
               TabIndex        =   49
               Top             =   180
               Width           =   6405
            End
            Begin VB.Label labDigVeri 
               Alignment       =   1  'Right Justify
               BackColor       =   &H00E0E0E0&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   3420
               TabIndex        =   48
               Top             =   180
               Width           =   315
            End
         End
         Begin Threed.SSFrame SSFrame2 
            Height          =   1995
            Left            =   45
            TabIndex        =   60
            Top             =   1800
            Width           =   11595
            _Version        =   65536
            _ExtentX        =   20452
            _ExtentY        =   3519
            _StockProps     =   14
            Caption         =   "[ Lineas Generales ]"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin VB.ComboBox Cmb_MonedaLG 
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   315
               Left            =   240
               Style           =   2  'Dropdown List
               TabIndex        =   61
               Top             =   550
               Visible         =   0   'False
               Width           =   2175
            End
            Begin BACControles.TXTNumero LabTotLin 
               Height          =   315
               Left            =   4410
               TabIndex        =   62
               Top             =   510
               Width           =   2665
               _ExtentX        =   4710
               _ExtentY        =   556
               BackColor       =   -2147483633
               ForeColor       =   8388608
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
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
            Begin VB.Label LabGarEfect 
               Alignment       =   1  'Right Justify
               BorderStyle     =   1  'Fixed Single
               Caption         =   "0"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   8280
               TabIndex        =   112
               Top             =   1560
               Width           =   2655
            End
            Begin VB.Label LabGarAsoc 
               Alignment       =   1  'Right Justify
               BorderStyle     =   1  'Fixed Single
               Caption         =   "0"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   4440
               TabIndex        =   111
               Top             =   1560
               Width           =   2655
            End
            Begin VB.Label LabGarConst 
               Alignment       =   1  'Right Justify
               BorderStyle     =   1  'Fixed Single
               Caption         =   "0"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   840
               TabIndex        =   110
               Top             =   1560
               Width           =   2655
            End
            Begin VB.Label Label26 
               Caption         =   "Garantías Constituidas"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   360
               TabIndex        =   102
               Top             =   1320
               Width           =   2160
            End
            Begin VB.Label Label25 
               Caption         =   "Total Garantías Asociadas"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   3960
               TabIndex        =   101
               Top             =   1320
               Width           =   3000
            End
            Begin VB.Label Label24 
               Caption         =   "Total Garantías en Efectivo"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   7800
               TabIndex        =   100
               Top             =   1320
               Width           =   2880
            End
            Begin VB.Label Lbl_Auxi 
               Height          =   255
               Left            =   1680
               TabIndex        =   72
               Top             =   360
               Visible         =   0   'False
               Width           =   495
            End
            Begin VB.Label Lbl_MonedaGen 
               Alignment       =   2  'Center
               BorderStyle     =   1  'Fixed Single
               Caption         =   "--------------------"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   255
               Left            =   240
               TabIndex        =   71
               Top             =   585
               Width           =   2175
            End
            Begin VB.Label Label7 
               Caption         =   "Moneda"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   120
               TabIndex        =   70
               Top             =   350
               Width           =   720
            End
            Begin VB.Label Label10 
               Caption         =   "Total Linea"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   2730
               TabIndex        =   69
               Top             =   570
               Width           =   1560
            End
            Begin VB.Label Label11 
               Caption         =   "Total Disponible"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   2730
               TabIndex        =   68
               Top             =   915
               Width           =   1440
            End
            Begin VB.Label LabTotDis 
               Alignment       =   1  'Right Justify
               BorderStyle     =   1  'Fixed Single
               Caption         =   "0"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   4410
               TabIndex        =   67
               Top             =   870
               Width           =   2655
            End
            Begin VB.Label Label16 
               Caption         =   "Total Ocupado"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   7305
               TabIndex        =   66
               Top             =   570
               Width           =   1320
            End
            Begin VB.Label Label17 
               Caption         =   "Total Exceso"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   195
               Left            =   7305
               TabIndex        =   65
               Top             =   915
               Width           =   1320
            End
            Begin VB.Label LabTotOcu 
               Alignment       =   1  'Right Justify
               BorderStyle     =   1  'Fixed Single
               Caption         =   "0"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H000000FF&
               Height          =   315
               Left            =   8805
               TabIndex        =   64
               Top             =   510
               Width           =   2655
            End
            Begin VB.Label LabTotExe 
               Alignment       =   1  'Right Justify
               BorderStyle     =   1  'Fixed Single
               Caption         =   "0"
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   8805
               TabIndex        =   63
               Top             =   870
               Width           =   2655
            End
         End
         Begin Threed.SSFrame SSFrame3 
            Height          =   3135
            Left            =   45
            TabIndex        =   73
            Top             =   3720
            Width           =   11595
            _Version        =   65536
            _ExtentX        =   20452
            _ExtentY        =   5530
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
            Begin VB.TextBox txtNumGrid 
               Alignment       =   1  'Right Justify
               BackColor       =   &H8000000D&
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H8000000E&
               Height          =   315
               Left            =   4080
               TabIndex        =   75
               Text            =   "0"
               Top             =   930
               Width           =   2175
            End
            Begin VB.ComboBox CmbGrid 
               BackColor       =   &H8000000D&
               BeginProperty Font 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H8000000E&
               Height          =   315
               ItemData        =   "BacLinCreGen3.frx":000C
               Left            =   345
               List            =   "BacLinCreGen3.frx":000E
               Style           =   2  'Dropdown List
               TabIndex        =   74
               Top             =   930
               Visible         =   0   'False
               Width           =   1700
            End
            Begin BACControles.TXTFecha txtFecGrid 
               Height          =   315
               Left            =   2130
               TabIndex        =   76
               Top             =   930
               Width           =   1815
               _ExtentX        =   3201
               _ExtentY        =   556
               BackColor       =   -2147483635
               Enabled         =   -1  'True
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   -2147483634
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "24/11/2003"
            End
            Begin MSFlexGridLib.MSFlexGrid GridOculta 
               Height          =   1515
               Left            =   1050
               TabIndex        =   77
               TabStop         =   0   'False
               Top             =   4035
               Visible         =   0   'False
               Width           =   3600
               _ExtentX        =   6350
               _ExtentY        =   2672
               _Version        =   393216
               Rows            =   1
               Cols            =   14
               FixedRows       =   0
               FixedCols       =   0
               TextStyle       =   2
               TextStyleFixed  =   2
            End
            Begin MSFlexGridLib.MSFlexGrid Oculta 
               Height          =   1500
               Left            =   4665
               TabIndex        =   78
               Top             =   4050
               Visible         =   0   'False
               Width           =   4500
               _ExtentX        =   7938
               _ExtentY        =   2646
               _Version        =   393216
               Rows            =   3
               Cols            =   3
               FixedRows       =   2
               FixedCols       =   0
            End
            Begin MSFlexGridLib.MSFlexGrid Grid 
               Height          =   2955
               Left            =   120
               TabIndex        =   83
               Top             =   120
               Width           =   11460
               _ExtentX        =   20214
               _ExtentY        =   5212
               _Version        =   393216
               BackColor       =   -2147483633
               ForeColor       =   -2147483641
               BackColorFixed  =   -2147483646
               ForeColorFixed  =   -2147483634
               BackColorBkg    =   -2147483636
               FocusRect       =   0
               GridLines       =   2
               GridLinesFixed  =   0
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Tahoma"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
            Begin VB.Label Lbl_Grid 
               Height          =   615
               Left            =   120
               TabIndex        =   121
               Top             =   360
               Visible         =   0   'False
               Width           =   2775
            End
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   9540
      Top             =   -60
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLinCreGen3.frx":0010
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLinCreGen3.frx":0462
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLinCreGen3.frx":08B4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLinCreGen3.frx":0BCE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLinCreGen3.frx":1020
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLinCreGen3.frx":133A
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLinCreGen3.frx":178C
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLinCreGen3.frx":1BDE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   15
      Width           =   18540
      _ExtentX        =   32703
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   9
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Elimina"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Lineas por Producto y Plazo"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Detalle Clientes"
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Reporte"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Act. y Valida Modelo VAR Bac"
            ImageIndex      =   8
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin VB.CommandButton CmdMet05 
         Caption         =   "Met 5"
         Height          =   495
         Index           =   1
         Left            =   6240
         TabIndex        =   94
         Top             =   0
         Width           =   735
      End
      Begin VB.CommandButton CmdMet03 
         Caption         =   "Met 3"
         Height          =   495
         Index           =   1
         Left            =   5280
         TabIndex        =   92
         Top             =   0
         Width           =   735
      End
      Begin VB.CommandButton CmdMet02 
         Caption         =   "Met 2"
         Height          =   495
         Index           =   1
         Left            =   4320
         TabIndex        =   90
         Top             =   0
         Width           =   735
      End
      Begin VB.CommandButton CmdLcr 
         Caption         =   "LCR"
         Height          =   420
         Index           =   1
         Left            =   3600
         TabIndex        =   122
         Top             =   30
         Width           =   495
      End
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   330
      Left            =   75
      TabIndex        =   2
      Top             =   600
      Width           =   11835
      _ExtentX        =   20876
      _ExtentY        =   582
      _Version        =   393216
      Tabs            =   2
      TabsPerRow      =   4
      TabHeight       =   520
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Instituciones Financieras"
      TabPicture(0)   =   "BacLinCreGen3.frx":2AB8
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).ControlCount=   0
      TabCaption(1)   =   "Otras Instituciones "
      TabPicture(1)   =   "BacLinCreGen3.frx":2AD4
      Tab(1).ControlEnabled=   0   'False
      Tab(1).ControlCount=   0
   End
End
Attribute VB_Name = "BacLinCreGen3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Key
Dim TeclaPre2 As Integer
Dim key2      As Integer
Dim swexiste  As Integer
Dim SW_PadreHijo As Integer
Dim oForzado    As Integer
Public Metodologia_LCR As Integer
Private Function FuncCargaMonedaThreshold(ByRef MiObjeto As ComboBox)
   Dim SqlDatos()
   Dim cNemoDefecto  As String
   
   Call MiObjeto.Clear

   Envia = Array()
   
   If Not Bac_Sql_Execute("BacLineas.dbo.SP_LEE_MONEDAS_THRESHOLD") Then
      Call MsgBox("Se ha originado un error en la extraccion de Monedas Threshold", vbExclamation, App.Title)
      Exit Function
   End If

   '-> Orden del Retorno : 1 - Codigo de la Moneda: ej:  142 ,   13
   '->                   : 2 - Nemo   de la Moneda: ej: 'EUR', 'USD'
   '->                   : 3 - Valor  por Defecto : ej:    0 ,    1   -> USD por Defecto
 
   Do While Bac_SQL_Fetch(SqlDatos())
      '-> Si es "1" es el valor definido por defecto, Almaceno el texto que ira al Objeto
      If SqlDatos(3) = 1 Then Let cNemoDefecto = SqlDatos(2)
      
      '-> Asigna los valores al Combo segun se especifico
      Call MiObjeto.AddItem(SqlDatos(2))
       Let MiObjeto.ItemData(MiObjeto.NewIndex) = SqlDatos(1)
   Loop
   
   If MiObjeto.ListCount > 0 Then
      Let MiObjeto.Text = cNemoDefecto
   End If
End Function

Private Function FuncSettingDecimalesMonto(ByRef MiMonto As TXTNumero, ByRef miMoneda As ComboBox)
   Dim nMonto  As Double
   Dim iMoneda As Long

   If miMoneda.ListIndex < 0 Then
      Exit Function
   End If

   Let nMonto = MiMonto.Text
   Let iMoneda = miMoneda.ItemData(miMoneda.ListIndex)

   Let MiMonto.CantidadDecimales = 0
   If iMoneda <> 999 Then
      Let MiMonto.CantidadDecimales = 4
   End If
   Let MiMonto.Text = nMonto
End Function

Private Sub CMBMonedaThreshold_Click()
   Call FuncSettingDecimalesMonto(TxtMtoThresHold, CMBMonedaThreshold)
End Sub
Private Sub CMBMonedaThreshold2_Click()
   Call FuncSettingDecimalesMonto(TXTMtoThresHold2, CMBMonedaThreshold2)
End Sub
Private Sub CmdLcr_Click(Index As Integer)

    If SSTab1.Tab = 0 Then
        If TxtRut.Text = 0 Or TxtCodCli.Text = 0 Then
           Call MsgBox(" Debe Ingresar Rut y codigo", vbInformation)
           Exit Sub
        End If
    End If
    
    If SSTab1.Tab = 1 Then
        If TxtRut2.Text = 0 Or TxtCodCli2.Text = 0 Then
           Call MsgBox(" Debe Ingresar Rut y codigo", vbInformation)
           Exit Sub
        End If
    End If

    EjecutaBtnREC = True
    If Me.SSTab1.Tab = 0 Then
        FRM_DETALLE_LCR.Rut = Me.TxtRut.Text
        FRM_DETALLE_LCR.CodCli = Me.TxtCodCli.Text
        FRM_DETALLE_LCR.Det_Cliente_LCR = Me.LabNombre.Caption
        FRM_DETALLE_LCR.Det_Threshold_LCR = Me.TxtMtoThresHold.Text
        FRM_DETALLE_LCR.Det_Metodologia_LCR = Me.Metodologia_LCR
    End If
    
    If Me.SSTab1.Tab = 1 Then
        FRM_DETALLE_LCR.Rut = Me.TxtRut2.Text
        FRM_DETALLE_LCR.CodCli = Me.TxtCodCli2.Text
        FRM_DETALLE_LCR.Det_Cliente_LCR = Me.LabNombre2.Caption
        FRM_DETALLE_LCR.Det_Threshold_LCR = Me.TXTMtoThresHold2.Text
        FRM_DETALLE_LCR.Det_Metodologia_LCR = Me.Metodologia_LCR
    End If

    FRM_DETALLE_LCR.Show vbModal
End Sub


Private Sub CmdMet02_Click(Index As Integer)
MsgBox "metodologia 2"

    Dim Metodologia_LCR_Aux As Integer
    Let Metodologia_LCR_Aux = Metodologia_LCR
    Let Metodologia_LCR = 2
    If SSTab1.Tab = 0 Then
        If TxtRut.Text = 0 Or TxtCodCli.Text = 0 Then
           Call MsgBox(" Debe Ingresar Rut y codigo", vbInformation)
           Exit Sub
        End If
    End If
    If SSTab1.Tab = 1 Then
        If TxtRut2.Text = 0 Or TxtCodCli2.Text = 0 Then
           Call MsgBox(" Debe Ingresar Rut y codigo", vbInformation)
           Exit Sub
        End If
    End If
    EjecutaBtnREC = True
    If Me.SSTab1.Tab = 0 Then
        FRM_DETALLE_LCR.Rut = Me.TxtRut.Text
        FRM_DETALLE_LCR.CodCli = Me.TxtCodCli.Text
        FRM_DETALLE_LCR.Det_Cliente_LCR = Me.LabNombre.Caption
        FRM_DETALLE_LCR.Det_Threshold_LCR = Me.TxtMtoThresHold.Text
        FRM_DETALLE_LCR.Det_Metodologia_LCR = Me.Metodologia_LCR
    End If
    
    If Me.SSTab1.Tab = 1 Then
        FRM_DETALLE_LCR.Rut = Me.TxtRut2.Text
        FRM_DETALLE_LCR.CodCli = Me.TxtCodCli2.Text
        FRM_DETALLE_LCR.Det_Cliente_LCR = Me.LabNombre2.Caption
        FRM_DETALLE_LCR.Det_Threshold_LCR = Me.TXTMtoThresHold2.Text
        FRM_DETALLE_LCR.Det_Metodologia_LCR = Me.Metodologia_LCR
    End If
    
    FRM_DETALLE_LCR.Show vbModal
    Metodologia_LCR = Metodologia_LCR_Aux

End Sub

Private Sub CmdMet03_Click(Index As Integer)
MsgBox "metodologia 3"
    Dim Metodologia_LCR_Aux As Integer
    Let Metodologia_LCR_Aux = Metodologia_LCR
    Let Metodologia_LCR = 3
    
    If SSTab1.Tab = 0 Then
        If TxtRut.Text = 0 Or TxtCodCli.Text = 0 Then
           Call MsgBox(" Debe Ingresar Rut y codigo", vbInformation)
           Exit Sub
        End If
    End If
    If SSTab1.Tab = 1 Then
        If TxtRut2.Text = 0 Or TxtCodCli2.Text = 0 Then
           Call MsgBox(" Debe Ingresar Rut y codigo", vbInformation)
           Exit Sub
        End If
    End If
    EjecutaBtnREC = True
    If Me.SSTab1.Tab = 0 Then
        FRM_DETALLE_LCR.Rut = Me.TxtRut.Text
        FRM_DETALLE_LCR.CodCli = Me.TxtCodCli.Text
        FRM_DETALLE_LCR.Det_Cliente_LCR = Me.LabNombre.Caption
        FRM_DETALLE_LCR.Det_Threshold_LCR = Me.TxtMtoThresHold.Text
        FRM_DETALLE_LCR.Det_Metodologia_LCR = Me.Metodologia_LCR
    End If
    
    If Me.SSTab1.Tab = 1 Then
        FRM_DETALLE_LCR.Rut = Me.TxtRut2.Text
        FRM_DETALLE_LCR.CodCli = Me.TxtCodCli2.Text
        FRM_DETALLE_LCR.Det_Cliente_LCR = Me.LabNombre2.Caption
        FRM_DETALLE_LCR.Det_Threshold_LCR = Me.TXTMtoThresHold2.Text
        FRM_DETALLE_LCR.Det_Metodologia_LCR = Me.Metodologia_LCR
    End If
	
	 'Guarga n° Metodologia, para ser usado en form.  FRM_DETALLE_LCR.frm
     gsc_Parametros.iMetodologia = 3
       
    FRM_DETALLE_LCR.Show vbModal
    Metodologia_LCR = Metodologia_LCR_Aux
End Sub

Private Sub CmdMet05_Click(Index As Integer)
MsgBox "metodologia 5"
    Let Metodologia_LCR_Aux = Metodologia_LCR
    Let Metodologia_LCR = 5
    
    If SSTab1.Tab = 0 Then
        If TxtRut.Text = 0 Or TxtCodCli.Text = 0 Then
           Call MsgBox(" Debe Ingresar Rut y codigo", vbInformation)
           Exit Sub
        End If
    End If
    If SSTab1.Tab = 1 Then
        If TxtRut2.Text = 0 Or TxtCodCli2.Text = 0 Then
           Call MsgBox(" Debe Ingresar Rut y codigo", vbInformation)
           Exit Sub
        End If
    End If
    EjecutaBtnREC = True
    If Me.SSTab1.Tab = 0 Then
        FRM_DETALLE_LCR.Rut = Me.TxtRut.Text
        FRM_DETALLE_LCR.CodCli = Me.TxtCodCli.Text
        FRM_DETALLE_LCR.Det_Cliente_LCR = Me.LabNombre.Caption
        FRM_DETALLE_LCR.Det_Threshold_LCR = Me.TxtMtoThresHold.Text
        FRM_DETALLE_LCR.Det_Metodologia_LCR = Me.Metodologia_LCR
    End If
    
    If Me.SSTab1.Tab = 1 Then
        FRM_DETALLE_LCR.Rut = Me.TxtRut2.Text
        FRM_DETALLE_LCR.CodCli = Me.TxtCodCli2.Text
        FRM_DETALLE_LCR.Det_Cliente_LCR = Me.LabNombre2.Caption
        FRM_DETALLE_LCR.Det_Threshold_LCR = Me.TXTMtoThresHold2.Text
        FRM_DETALLE_LCR.Det_Metodologia_LCR = Me.Metodologia_LCR
    End If
    
    FRM_DETALLE_LCR.Show vbModal
    Metodologia_LCR = Metodologia_LCR_Aux
End Sub

Private Sub CmdMet06_Click(Index As Integer) ' PROD 21119 - Consumo de Línea -
                                             'cambio variación % confiabilidad al 99% y metodología VaR a 3 días
MsgBox "metodologia 6"
    Let Metodologia_LCR_Aux = Metodologia_LCR
    Let Metodologia_LCR = 6
    
    ' Instituciones Financiera
    If SSTab1.Tab = 0 Then
        If TxtRut.Text = 0 Or TxtCodCli.Text = 0 Then
           Call MsgBox(" Debe Ingresar Rut y codigo", vbInformation)
           Exit Sub
        End If
    End If
    
    ' Otras Instituciones.
    If SSTab1.Tab = 1 Then
        If TxtRut2.Text = 0 Or TxtCodCli2.Text = 0 Then
           Call MsgBox(" Debe Ingresar Rut y codigo", vbInformation)
           Exit Sub
        End If
    End If
    EjecutaBtnREC = True
    If Me.SSTab1.Tab = 0 Then
        FRM_DETALLE_LCR.Rut = Me.TxtRut.Text
        FRM_DETALLE_LCR.codcli = Me.TxtCodCli.Text
        FRM_DETALLE_LCR.Det_Cliente_LCR = Me.LabNombre.Caption
        FRM_DETALLE_LCR.Det_Threshold_LCR = 0
        'Me.TxtMtoThresHold.Text
        FRM_DETALLE_LCR.Det_Metodologia_LCR = Me.Metodologia_LCR
    End If
    
    If Me.SSTab1.Tab = 1 Then
        FRM_DETALLE_LCR.Rut = Me.TxtRut2.Text
        FRM_DETALLE_LCR.codcli = Me.TxtCodCli2.Text
        FRM_DETALLE_LCR.Det_Cliente_LCR = Me.LabNombre2.Caption
        FRM_DETALLE_LCR.Det_Threshold_LCR = 0
        'Me.TXTMtoThresHold2.Text
        FRM_DETALLE_LCR.Det_Metodologia_LCR = Me.Metodologia_LCR
    End If
    
   'Guarga n° Metodologia, para ser usado en form.  FRM_DETALLE_LCR.frm
     gsc_Parametros.iMetodologia = 6
        
    
    
    FRM_DETALLE_LCR.Show vbModal
    Metodologia_LCR = Metodologia_LCR_Aux
End Sub

Private Sub Form_Activate()
   Call Privilegios.ACTUALIZADOR(gsBAC_User)

   If Privilegios.objPrivilegios.Instituciones_Financieras = 1 Then
      Let SSTab1.TabCaption(0) = "Instituciones Financieras"
      Let FRA_INST_FIN.Visible = True
   End If
   If Privilegios.objPrivilegios.Instituciones_Financieras = 0 Then
      Let SSTab1.TabCaption(0) = "Opción Deshabilitada"
      Let FRA_INST_FIN.Visible = False
   End If
   
   If Privilegios.objPrivilegios.Otras_Instituciones = 1 Then
      Let SSTab1.TabCaption(1) = "Otras Instituciones"
      Let FRA_OTR_INST.Visible = True
   Else
      Let SSTab1.TabCaption(1) = "Opción Deshabilitada"
      Let FRA_OTR_INST.Visible = False
   End If
   
   Call SSTab1_Click(0)
End Sub



Private Sub SSTab1_Click(PreviousTab As Integer)
   If SSTab1.Tab = 0 Then
      Let Toolbar1.Enabled = IIf(Privilegios.objPrivilegios.Instituciones_Financieras = 1, True, False)
      Let Toolbar2.Enabled = False
      
      Let FRA_INST_FIN.Visible = IIf(Privilegios.objPrivilegios.Instituciones_Financieras = 1, True, False)
      Let FRA_OTR_INST.Visible = False
   End If
   
   If SSTab1.Tab = 1 Then
      Let Toolbar1.Enabled = False
      Let Toolbar2.Enabled = IIf(Privilegios.objPrivilegios.Otras_Instituciones = 1, True, False)
      
      Let FRA_INST_FIN.Visible = False
      Let FRA_OTR_INST.Visible = IIf(Privilegios.objPrivilegios.Otras_Instituciones = 1, True, False)
   End If

   Let Toolbar1.Visible = Toolbar1.Enabled
   Let Toolbar2.Visible = Toolbar2.Enabled
End Sub


Sub Proc_Cambia_Fecha_Vnto_Grilla(Grilla As MSFlexGrid, Fecha As Date, Tipo As String)
On Error GoTo Error:
Dim I As Integer

With Grilla

    For I = 2 To .Rows - 1
        If Trim(.TextMatrix(I, 0)) <> "" Then
             If Tipo = "V" Then
                .TextMatrix(I, 7) = Fecha
            Else
                .TextMatrix(I, 8) = Fecha
            End If
        End If
    Next

End With

Exit Sub

Error:
    MsgBox "Error : " & Err.Description, vbCritical

End Sub


Private Sub Cmb_MonedaLG_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    Call Cmb_MonedaLG_LostFocus
End If

End Sub

Private Sub Cmb_MonedaLG2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    Call Cmb_MonedaLG2_LostFocus
End If

End Sub


Private Sub Form_Load()
    Me.top = 0
    Me.Left = 0
    Me.Icon = BacControlFinanciero.Icon
    
    TxtRut.Text = ""
    labDigVeri.Caption = ""
    LabNombre.Caption = ""
    CmdLcr.Item(0).Enabled = False
    CmdLcr.Item(1).Enabled = False

    SSTab1.Visible = True
    SSTab1.Tab = 0
    
    Toolbar1.Buttons(1).Enabled = False
    
    Toolbar2.Buttons(1).Enabled = False
    
    '--> Llamada a cargar el combo de Monedas Threshold
    Call FuncCargaMonedaThreshold(CMBMonedaThreshold)
    Call FuncCargaMonedaThreshold(CMBMonedaThreshold2)
    '--> ----------------------------------------------

    
    
    Call Cargar
    Call CargarGrilla
    Call Cargar2
    Call CargarGrilla2
    
    Call GRABA_LOG_AUDITORIA(1, (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10002", "07", "INGRESO A OPCION DE MENU", "", "", "")
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Call GRABA_LOG_AUDITORIA(1, (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10002", "08", "SALIO DE LA OPCION DE MENU", "", "", "")
End Sub

Private Sub Lbl_MonedaGen_DblClick()
Cmb_MonedaLG.Visible = True
Lbl_MonedaGen.Visible = False
End Sub

Private Sub Lbl_MonedaGen2_DblClick()
Cmb_MonedaLG2.Visible = True
Lbl_MonedaGen2.Visible = False
End Sub

Private Sub Cmb_MonedaLG_LostFocus()
Dim Datos()

Cmb_MonedaLG.Visible = False
Lbl_MonedaGen.Visible = True
If Lbl_Auxi.Caption = "" Then
    Lbl_Auxi.Caption = 13
End If

If Cmb_MonedaLG.Text <> "" Then

    Envia = Array()

    AddParam Envia, gsBAC_Fecp
    AddParam Envia, CInt(Lbl_Auxi.Caption)
    AddParam Envia, CInt(Trim(Right(Cmb_MonedaLG.Text, 3)))
    AddParam Envia, CDbl(LabTotLin.Text)
    AddParam Envia, CDbl(LabTotOcu.Caption)
    AddParam Envia, CDbl(LabTotDis.Caption)
    AddParam Envia, CDbl(LabTotExe.Caption)

    'Lbl_Auxi.Caption = Trim(Right(Cmb_MonedaLG.Text, 3))
    If Not Bac_Sql_Execute("SP_LEER_MONEDA") Then
        MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
        Exit Sub
    End If
        
    Do While Bac_SQL_Fetch(Datos())
        If Trim(Right(Cmb_MonedaLG.Text, 3)) = Datos(1) Then
            Lbl_MonedaGen.Caption = Datos(4)
        End If
    Loop
    
    If Not Bac_Sql_Execute("SP_LINEAS_CONVERTIR", Envia) Then
        MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
        Exit Sub
    End If


    Do While Bac_SQL_Fetch(Datos())
        If Datos(1) = "ERROR" Then
            MsgBox Datos(2), vbCritical
    
            If Not Bac_Sql_Execute("SP_LEER_MONEDA") Then
                MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
        
            End If
        
            Lbl_MonedaGen.Caption = "--------------------"
            Do While Bac_SQL_Fetch(Datos())
                If Lbl_Auxi.Caption = Datos(1) Then
                    Lbl_MonedaGen.Caption = Datos(4)
                End If
            Loop


        'Lbl_Auxi.Caption = 0
            
            
        Else
            LabTotLin.Text = Datos(1)
            LabTotOcu.Caption = Format(Datos(2), FEntero)
            LabTotDis.Caption = Format(Datos(3), FEntero)
            LabTotExe.Caption = Format(Datos(4), FEntero)
        End If
    Loop
    
Else

    
End If

End Sub

Private Sub Cmb_MonedaLG2_LostFocus()
Dim Datos()
Cmb_MonedaLG2.Visible = False
Lbl_MonedaGen2.Visible = True
Dim RutCli As Double


If Lbl_Auxi2.Caption = "" Then
    Lbl_Auxi2.Caption = 13
End If


If Cmb_MonedaLG2.Text <> "" Then

    Envia = Array()

    AddParam Envia, gsBAC_Fecp
    AddParam Envia, Lbl_Auxi2.Caption
    AddParam Envia, Trim(Right(Cmb_MonedaLG2.Text, 3))
    AddParam Envia, CDbl(LabTotLin2.Text)
    AddParam Envia, CDbl(LabTotOcu2.Caption)
    AddParam Envia, CDbl(LabTotDis2.Caption)
    AddParam Envia, CDbl(LabTotExe2.Caption)
    
    
    Lbl_Auxi2.Caption = Trim(Right(Cmb_MonedaLG2.Text, 3))
    If Not Bac_Sql_Execute("SP_LEER_MONEDA") Then
        MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
        Exit Sub
    End If
        
    Do While Bac_SQL_Fetch(Datos())
        If Lbl_Auxi2.Caption = Datos(1) Then
            Lbl_MonedaGen2.Caption = Datos(4)
        End If
    Loop
    
    If Not Bac_Sql_Execute("SP_LINEAS_CONVERTIR", Envia) Then
        'MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
        MsgBox "El monto ingresado es superior al maximo permitido", vbCritical, TITSISTEMA
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(Datos())
        If Datos(1) = "ERROR" Then
            MsgBox Datos(2), vbCritical
            Exit Do
        End If
        LabTotLin2.Text = Datos(1)
        LabTotOcu2.Caption = Format(Datos(2), FEntero)
        LabTotDis2.Caption = Format(Datos(3), FEntero)
        LabTotExe2.Caption = Format(Datos(4), FEntero)
    Loop
    

Else
    Lbl_Auxi2.Caption = 0
    Lbl_MonedaGen2.Caption = "--------------------"
End If

   
   Call FuncValidaMonedaRelacion
Exit Sub
   
   
   
   Envia = Array()
   AddParam Envia, Format(Str(TxtRut2.Text), "0")
   AddParam Envia, Trim(Right(Cmb_MonedaLG2, 3))
   
   'If Not Bac_Sql_Execute("Sp_Valida_TipoMoneda_Padre_Hijo", Envia) Then
   If Not Bac_Sql_Execute("SP_VALIDA_MONEDA_RELACION", Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intenter validar el tipo de moneda", vbCritical, TITSISTEMA
      Exit Sub
   Else
      If Bac_SQL_Fetch(DATOS) Then
         If DATOS(1) <> 0 Then
            MsgBox DATOS(2), vbExclamation + vbOKOnly
         End If
      End If
   End If

End Sub

Private Function FuncValidaMonedaRelacion() As Boolean
   Dim SqlDatos()
   Dim nRut    As Long
   Dim nCod    As Long
   Dim nMoneda As Integer
   
   Let FuncValidaMonedaRelacion = False
   
      Let nRut = TxtRut2.Text
      Let nCod = TxtCodCli2.Text
   Let nMoneda = Trim(Right(Cmb_MonedaLG2.List(Cmb_MonedaLG2.ListIndex), 5))
   
   Envia = Array()
   AddParam Envia, nRut
   AddParam Envia, nCod
   AddParam Envia, nMoneda
   If Not Bac_Sql_Execute("SP_VALIDA_MONEDA_RELACION", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(SqlDatos) Then
      If SqlDatos(1) < 0 Then
         Call MsgBox(SqlDatos(2), vbExclamation, App.Title)
      End If
   End If


   Let FuncValidaMonedaRelacion = True

End Function



Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Dim I%
    Dim ERRORRR
    
    ERRORRR = 0
    
    CmbGrid.Visible = False
    txtNumGrid.Visible = False
    txtFecGrid.Visible = False
    
    If Button.Index = 2 Or Button.Index = 3 Or Button.Index = 4 Or Button.Index = 5 Or Button.Index = 7 Then
    Else
        Call Sumatorias
        Call TxtRut_LostFocus
        ''Call txtFecFinCon_LostFocus
        ''Call txtFecVen_LostFocus
    End If

    Select Case Button.Index
       Case 1
       
          If Trim(LabNombre.Caption) <> "" Then
            If CDbl(TxtMtoThresHold.Text = 0) Then
              ' MsgBox "Falta Ingresar el Monto ThresHold del Cliente, No se puede Grabar", vbExclamation, TITSISTEMA
              ' TxtMtoThresHold.SetFocus
              ' Exit Sub
            End If

            If Grid.Rows > 2 Then
                For I% = 2 To Grid.Rows - 1
                    If Trim(Grid.TextMatrix(I%, 0)) = "" Then
                        ERRORRR = 1
                        Exit For
                    End If
                    If Trim(Grid.TextMatrix(I%, 1)) = "" Then
                        ERRORRR = 1
                        Exit For
                    End If
                    If CDbl(Format(Grid.TextMatrix(I%, 2), FEntero)) < 0 Then
                        ERRORRR = 1
                        Exit For
                    End If
                    If CDbl(Format(Grid.TextMatrix(I%, 3), FEntero)) < 0 Then
                        ERRORRR = 1
                        Exit For
                    End If
                    If CDbl(Format(Grid.TextMatrix(I%, 4), FEntero)) < 0 Then
                        ERRORRR = 1
                        Exit For
                    End If
                Next I%
                
                If ERRORRR = 0 Then
                    Call Graba
                    SSTab1.Tab = 0
                    Exit Sub
                End If
                
            End If
            
        End If
        
        MsgBox "Faltan Datos por Ingresar, No se puede Grabar", vbExclamation, TITSISTEMA
        Grid.SetFocus
    
    Case 2

        res = MsgBox("Esta Seguro que Desea Eliminar?", vbQuestion + vbYesNo, TITSISTEMA)
        If res = 6 Then
            Call Elimina
            SSTab1.Tab = 0
        End If

    Case 3
    
        Toolbar1.Buttons(2).Enabled = False
        TxtRut.Text = 0
        TxtCodCli.Text = 0
        labDigVeri.Caption = ""
        LabNombre.Caption = ""
        TxtMtoThresHold.Text = 0
        
        'PRD-10967
        LabCodMetodologia.Caption = ""
        LabNomMetod.Caption = ""
        'PRD-10967
                
        Call Cargar
        Call Limpiar
        
        SSTab1.Tab = 0
        Key = 1
        TxtRut.Enabled = True
        TxtRut.SetFocus
        Grid.Enabled = False
        TxtCodCli.Enabled = True
        Toolbar1.Buttons(4).Enabled = True
        Toolbar1.Buttons(1).Enabled = False
        
    Case 4
       Call Busca
    Case 5
                    
            Call Busca(Grid.Row, Grid.Col) 'CASS
            
            If Lbl_Auxi.Caption = "" Then
                MsgBox "Debe Ingresar la moneda !!!", vbCritical
            Else
                Envia = Array( _
                                CDbl(TxtRut.Text), _
                                CDbl(TxtCodCli.Text), _
                                TxtFecAsi.Text, _
                                TxtFecVen.Text, _
                                txtFecFinCon.Text, _
                                "N", _
                                CDbl(LabTotLin.Text), _
                                CDbl(LabTotOcu.Caption), _
                                CDbl(LabTotDis.Caption), _
                                CDbl(LabTotExe.Caption), _
                                CDbl(Lbl_Auxi.Caption), CDbl(TxtMtoThresHold.Text), CMBMonedaThreshold.ItemData(CMBMonedaThreshold.ListIndex))
                If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_GRABA", Envia) Then
                    MsgBox "No se puede grabar la linea general", vbCritical, TITSISTEMA
                    Exit Sub
                End If
            
                For I% = 2 To Grid.Rows - 1
            
                    Envia = Array( _
                            CDbl(TxtRut.Text), _
                            CDbl(TxtCodCli.Text), _
                            Trim(Right(Grid.TextMatrix(I%, 0), 5)), _
                            Grid.TextMatrix(I%, 6), _
                            Grid.TextMatrix(I%, 7), _
                            Grid.TextMatrix(I%, 8), _
                            "N", _
                            CDbl(Grid.TextMatrix(I%, 2)), _
                            CDbl(Grid.TextMatrix(I%, 3)), _
                            CDbl(Grid.TextMatrix(I%, 4)), _
                            CDbl(Grid.TextMatrix(I%, 5)), _
                            Trim(Right(Grid.TextMatrix(I%, 1), 3)))
                        If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_GRABALINEASISTEMA", Envia) Then
                            MsgBox "No se puede Grabar", vbCritical, TITSISTEMA
                        End If

                Next I%
                cOptraerDatos = 0
                BacLinPlazo.Show 1
            End If

            Call Busca(Grid.Row, Grid.Col) 'CASS
    Case 7
        Unload Me
        
    Case 8  ' PROD-10967
    
        Call ImprimeInformacionLineas(CDbl(TxtRut.Text), CDbl(TxtCodCli.Text))
        
    Case 9
        If UsuarioConfirma(0, 0 _
                                , "Actualizar Modelo VaR " _
                                , "ALTO, se actualizará Modelo VaR y Matriz de Covarianza de Riesgo Financiero desde BAC. Puede generar distorsión en los calculos si se está cursando operaciones." _
                                , 0.5) Then
           Call Proc_ValidaParametrosDRV
           If UsuarioConfirma(0, 0 _
                                , "Actualizar Modelo VaR " _
                                , "Se reconstruirá la Matriz de Covarianzas " _
                                , 0.5) Then
           Call Genera_Matriz_Covarianza
              Call MsgBox("Matriz de Covarianza generada correctamente", vbInformation, App.Title)
           End If
        End If
        
    End Select
    
End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
    Dim I%
    Dim ERRORRR
    
    ERRORRR = 0
    
    CmbGrid2.Visible = False
    txtNumGrid2.Visible = False
    txtFecGrid2.Visible = False
    
    If Button.Index = 2 Or Button.Index = 3 Or Button.Index = 4 Or Button.Index = 5 Or Button.Index = 7 Then
    Else
        Call Sumatorias2
        Call TxtRut2_LostFocus
        ''Call txtFecFinCon2_LostFocus
        ''Call txtFecVen2_LostFocus
    End If

    Select Case Button.Index
       Case 1
       
          If Trim(LabNombre2.Caption) <> "" Then

            If CDbl(TXTMtoThresHold2.Text = 0) Then
                       ' MsgBox "Falta Ingresar el Monto ThresHold del Cliente, No se puede Grabar", vbExclamation, TITSISTEMA
                       ' TXTMtoThresHold2.SetFocus
                       ' Exit Sub
            End If
                    
            If Grid2.Rows > 2 Then
                For I% = 2 To Grid2.Rows - 1
                    If Trim(Grid2.TextMatrix(I%, 0)) = "" Then
                        ERRORRR = 1
                        Exit For
                    End If
                    If Trim(Grid2.TextMatrix(I%, 1)) = "" Then
                        ERRORRR = 1
                        Exit For
                    End If
                    If CDbl(Format(Grid2.TextMatrix(I%, 2), FEntero)) < 0 Then
                        ERRORRR = 1
                        Exit For
                    End If
                    If CDbl(Format(Grid2.TextMatrix(I%, 3), FEntero)) < 0 Then
                        ERRORRR = 1
                        Exit For
                    End If
                    If CDbl(Format(Grid2.TextMatrix(I%, 4), FEntero)) < 0 Then
                        ERRORRR = 1
                        Exit For
                    End If
                Next I%
                
                If ERRORRR = 0 Then
                    Call Graba2
                    SSTab1.Tab = 1
                    Exit Sub
                End If
                
            End If
            
        End If
        
        MsgBox "Faltan Datos por Ingresar, No se puede Grabar", vbExclamation, TITSISTEMA
        Grid2.SetFocus
    
    Case 2

        res = MsgBox("Esta Seguro que Desea Eliminar?", vbQuestion + vbYesNo, TITSISTEMA)
        If res = 6 Then
            Call Elimina2
            SSTab1.Tab = 1
        End If

    Case 3
    
        Toolbar2.Buttons(2).Enabled = False
        TxtRut2.Text = 0
        TxtCodCli2.Text = 0
        labDigVeri2.Caption = 0
        LabNombre2.Caption = ""
        TXTMtoThresHold2.Text = 0
        
        'PRD-10967
        LabCodMetodologia2.Caption = ""
        LabNomMetod2.Caption = ""
        'PRD-10967
        
        Call Cargar2
        Call Limpiar2
        
        SSTab1.Tab = 1
        Key = 1
        TxtRut2.Enabled = True
        TxtRut2.SetFocus
        Grid2.Enabled = False
        TxtCodCli2.Enabled = True
        Toolbar2.Buttons(4).Enabled = True
        Toolbar2.Buttons(1).Enabled = False
        
    Case 4
       Call BUSCA2
    Case 5

            If Trim(Lbl_Auxi2.Caption) = "" Then
               MsgBox "Moneda de la Línea General o Sistema, NO se encuentra definida", vbExclamation, App.Title
               Exit Sub
            End If

            Envia = Array( _
                            CDbl(TxtRut2.Text), _
                            CDbl(TxtCodCli2.Text), _
                            TxtFecAsi2.Text, _
                            TxtFecVen2.Text, _
                            txtFecFinCon2.Text, _
                            "N", _
                            CDbl(LabTotLin2.Text), _
                            CDbl(LabTotOcu2.Caption), _
                            CDbl(LabTotDis2.Caption), _
                            CDbl(LabTotExe2.Caption), _
                            CDbl(Lbl_Auxi2.Caption), CDbl(TXTMtoThresHold2.Text), CMBMonedaThreshold.ItemData(CMBMonedaThreshold.ListIndex))
            If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_GRABA", Envia) Then
                MsgBox "No se puede grabar la linea general", vbCritical, TITSISTEMA
                Exit Sub
            End If
            
            For I% = 2 To Grid2.Rows - 1
            
                    Envia = Array( _
                            CDbl(TxtRut2.Text), _
                            CDbl(TxtCodCli2.Text), _
                            Trim(Right(Grid2.TextMatrix(I%, 0), 5)), _
                            Grid2.TextMatrix(I%, 6), _
                            Grid2.TextMatrix(I%, 7), _
                            Grid2.TextMatrix(I%, 8), _
                            "N", _
                            CDbl(Grid2.TextMatrix(I%, 2)), _
                            CDbl(Grid2.TextMatrix(I%, 3)), _
                            CDbl(Grid2.TextMatrix(I%, 4)), _
                            CDbl(Grid2.TextMatrix(I%, 5)), _
                            Trim(Right(Grid2.TextMatrix(I%, 1), 3)))
                        If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_GRABALINEASISTEMA", Envia) Then
                            MsgBox "No se puede Grabar", vbCritical, TITSISTEMA
                        End If

            Next I%
            cOptraerDatos = 1
            BacLinPlazo.Show 1

    Case 7
        Unload Me
        
    Case 8  ' PROD-10967
    
        Call ImprimeInformacionLineas(CDbl(TxtRut2.Text), CDbl(TxtCodCli2.Text))
    Case 9
    
        If UsuarioConfirma(0, 0 _
                                , "Actualizar Modelo VaR " _
                                , "ALTO, se actualizará Modelo VaR y Matriz de Covarianza de Riesgo Financiero desde BAC. Puede generar distorsión en los calculos si se está cursando operaciones." _
                                , 0.5) Then
          Call Proc_ValidaParametrosDRV
           If UsuarioConfirma(0, 0 _
                                , "Actualizar Modelo VaR " _
                                , "Se reconstruirá la Matriz de Covarianzas " _
                                , 0.5) Then
          Call Genera_Matriz_Covarianza
          Call MsgBox("Matriz de Covarianza generada correctamente", vbInformation, App.Title)
        End If
        End If
    End Select
    
End Sub

Private Sub Proc_ValidaParametrosDRV()
    Dim Det_MsgError As String
    Dim CliMet_2_5 As Long
    Dim CliMet_3  As Long
    Dim VerificaSim As String
    Dim Parametros As Boolean
    Dim iCadena As String
    Dim Titulo As String
    Dim HayDatos As Boolean
    Dim DATOS()

    Let Screen.MousePointer = vbHourglass
   
    Envia = Array()
    AddParam Envia, 0 'iRut
    AddParam Envia, 0 'iCodigo
    If Not Bac_Sql_Execute("BacTraderSuda..SP_CON_CLIENTE_DERIVADOS", Envia) Then
        Let Screen.MousePointer = vbDefault
        MsgBox "Actualizacion de Lineas" & vbCrLf & vbCrLf & "Error en la carga de clientes.", vbExclamation, App.Title
        On Error GoTo 0
        Exit Sub
    End If
    
    Let CliMet_2_5 = 0
    Let CliMet_3 = 0
    Let HayDatos = False
    Do While Bac_SQL_Fetch(DATOS())
                    
        If DATOS(4) = 2 Or DATOS(4) = 5 Then
            CliMet_2_5 = CliMet_2_5 + 1
        End If
        
        If DATOS(4) = 3 Then
            CliMet_3 = CliMet_3 + 1
        End If
        Let HayDatos = True
    Loop
       
    If HayDatos = False Then
        Call MsgBox("No hay Clientes con Metodologías Netting. ", vbInformation, App.Title)
        Let Screen.MousePointer = vbDefault
        Exit Sub
    End If
    
    Let Parametros = False
    Let iCadena = ""
    Let Titulo = ""
    If CliMet_3 >= 1 Then
        Let VerificaSim = "PAR_SIMULACIONES"
        Call Proc_Verifica_Parametros(VerificaSim, Parametros, iCadena)
        If Parametros = True Then
            Let Screen.MousePointer = vbDefault
            Frm_Msg_Planilla_Excel.Show
            Frm_Msg_Planilla_Excel.ssMsgResum.Visible = True
            Frm_Msg_Planilla_Excel.Caption = "Problemas en parametros modelo VAR en Bac"
            Frm_Msg_Planilla_Excel.TxtMsg.Text = "Advertencia: Se detectaron los siguiente problemas en parametros."
            Frm_Msg_Planilla_Excel.TxtMsg.Text = Frm_Msg_Planilla_Excel.TxtMsg.Text & vbCrLf & iCadena & vbCrLf & MsgInterNoc
            
            'If MsgBox("¿Desea enviar la información por correo?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
            '    Call BacCalculoRec.Proc_EnviarMail(iCadena, Titulo)
            'End If
            Let Screen.MousePointer = vbDefault
            
            Exit Sub
        End If
    Else
        Let VerificaSim = "PAR_DIA"
        Call Proc_Verifica_Parametros(VerificaSim, Parametros, iCadena)
        If Parametros = True Then
            Frm_Msg_Planilla_Excel.Show
            Frm_Msg_Planilla_Excel.ssMsgResum.Visible = True
            Frm_Msg_Planilla_Excel.Caption = "Problemas de parametros modelo VAR en Bac"
            Frm_Msg_Planilla_Excel.TxtMsg.Text = "Advertencia: Se detectaron y no se grabaron las siguiente diferencias en bloqueo."
            Frm_Msg_Planilla_Excel.TxtMsg.Text = Frm_Msg_Planilla_Excel.TxtMsg.Text & vbCrLf & iCadena & vbCrLf & MsgInterNoc
            
            'If MsgBox("¿Desea enviar la información por correo?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
            '    Call BacCalculoRec.Proc_EnviarMail(iCadena, Titulo)
            'End If
                        
            Let Screen.MousePointer = vbDefault
            Exit Sub
        End If
    End If
    
    Let Screen.MousePointer = vbDefault

    MsgBox "Validación de parametros" & vbCrLf & "Se ha completado en forma correcta.", vbInformation, App.Title
    
End Sub


Private Sub txtFecFinCon_Change()
Proc_Cambia_Fecha_Vnto_Grilla Grid, txtFecFinCon.Text, "C"
End Sub

Private Sub txtFecFinCon_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    Proc_Cambia_Fecha_Vnto_Grilla Grid, txtFecFinCon.Text, "C"
End If
End Sub

Private Sub txtFecFinCon2_Change()
Proc_Cambia_Fecha_Vnto_Grilla Grid2, txtFecFinCon2.Text, "C"
End Sub

Private Sub txtFecFinCon2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    Proc_Cambia_Fecha_Vnto_Grilla Grid2, txtFecFinCon2.Text, "C"
End If
End Sub

Private Sub TxtFecVen_Change()
Proc_Cambia_Fecha_Vnto_Grilla Grid, TxtFecVen.Text, "V"
End Sub

Private Sub TxtFecVen2_Change()
Proc_Cambia_Fecha_Vnto_Grilla Grid2, TxtFecVen2.Text, "V"
End Sub

Private Sub TxtRut_DblClick()
'    BacAyuda.Tag = "ClienteB"
'    BacAyuda.Tag = "LINGENHELPCLI"
'    BacAyuda.TipoCliente = 1
'    BacAyuda.Show 1
    BacAyudaCliente.TipoCliente = 1
    BacAyudaCliente.Tag = "ClienteB"
    BacAyudaCliente.Tag = "LINGENHELPCLI"
    BacAyudaCliente.Show 1

    If giAceptar = True Then
        TxtRut.Text = RetornoAyuda
        TxtCodCli.Text = RetornoAyuda2
        Call Busca
      
        Metodologia_LCR = Func_Rescata_metodologia(TxtRut.Text, TxtCodCli.Text)
        CmdLcr.Item(1).Enabled = False
        If Metodologia_LCR <> 1 And Metodologia_LCR <> 4 Then
            CmdLcr.Item(1).Enabled = True
        End If
                
    End If
    If swexiste = 0 Then
        Grid.Enabled = True
        Toolbar1.Buttons(1).Enabled = True
        Key = 0
     End If
End Sub

Private Sub TxtRut2_DblClick()
'    BacAyuda.Tag = "ClienteF"
'    BacAyuda.Tag = "LINGENHELPCLI"
'    BacAyuda.TipoCliente = 2
'    BacAyuda.Show 1
'
     BacAyudaCliente.TipoCliente = 2
     BacAyudaCliente.Tag = "ClienteF"
     BacAyudaCliente.Tag = "LINGENHELPCLI"
     BacAyudaCliente.Show 1

      If giAceptar = True Then
        TxtRut2.Text = RetornoAyuda
        TxtCodCli2.Text = RetornoAyuda2
        Call BUSCA2
   
        Metodologia_LCR = Func_Rescata_metodologia(TxtRut2.Text, TxtCodCli2.Text)
       
        CmdLcr.Item(0).Enabled = False
        If Metodologia_LCR <> 1 And Metodologia_LCR <> 4 Then
            CmdLcr.Item(0).Enabled = True
        End If
    End If
    If swexiste = 0 Then
        Grid2.Enabled = True
        Toolbar2.Buttons(1).Enabled = True
        Key = 0
    End If
End Sub

Private Function Func_Rescata_metodologia(Rut As Long, CodCli As Integer)
    Dim DATOS()

    Envia = Array()
    AddParam Envia, CDbl(Rut)
    AddParam Envia, CDbl(CodCli)
    AddParam Envia, -1
    AddParam Envia, ""
   
    If Not Bac_Sql_Execute("BacSwapSuda..SP_LEER_CLIENTE", Envia) Then
        Exit Function
    End If
            
   
     
    If Bac_SQL_Fetch(DATOS()) Then
    
        clrut = Val(DATOS(1))
        cldv = DATOS(2)
        clcodigo = Val(DATOS(3))
        clnombre = UCase(DATOS(4))
        cldireccion = UCase(DATOS(5))
        clcomuna = Val(DATOS(6))
        clfono = DATOS(8)
        clfax = DATOS(9)
        cltipocliente = Val(DATOS(10))
        clciudad = DATOS(11)
        clregion = Val(DATOS(12))
        clPais = Val(DATOS(13))
        clfecha_escritura = DATOS(14)
        clnotaria = DATOS(15)
        clfecha_cond_generales = DATOS(16)
        clciudadglosa = DATOS(18)
        clcomunaglosa = DATOS(17)
        clUtilizaNuevoCgg = IIf(DATOS(19) = "S", True, False)
        clFechaNuevoCgg = DATOS(20)
        clThreshold = DATOS(21)
        clMetodologia_LCR = DATOS(22)
       
        Func_Rescata_metodologia = clMetodologia_LCR
    End If

End Function
Private Sub TxtRut_GotFocus()
    TxtRut.Tag = TxtRut.Text
End Sub

Private Sub TxtRut2_GotFocus()
    TxtRut2.Tag = TxtRut2.Text
End Sub

Private Sub TxtRut_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
        TxtCodCli.SetFocus
    End If
End Sub

Private Sub TxtRut2_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
       If TxtCodCli2.Visible = True And TxtCodCli2.Enabled = True Then
        TxtCodCli2.SetFocus
    End If
    End If
End Sub

Private Sub TxtRut_LostFocus()
    Grid.Enabled = True
End Sub

Private Sub TxtRut2_LostFocus()
    Grid2.Enabled = True
End Sub

Private Sub TxtCodCli_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      TxtFecAsi.SetFocus
   End If
End Sub

Private Sub TxtCodCli2_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      TxtFecAsi2.SetFocus
   End If
End Sub

Private Sub TxtCodCli_LostFocus()
   Call Busca
End Sub

Private Sub TxtCodCli2_LostFocus()
   Call BUSCA2
End Sub

Private Sub txtFecFinCon_LostFocus()
    If CDbl(Format(TxtFecAsi.Text, FechaYMD)) > CDbl(Format(txtFecFinCon.Text, FechaYMD)) Then
       TxtFecAsi.Text = txtFecFinCon.Text
       Exit Sub
    End If
Proc_Cambia_Fecha_Vnto_Grilla Grid, txtFecFinCon.Text, "C"
End Sub

Private Sub txtFecFinCon2_LostFocus()
    If CDbl(Format(TxtFecAsi2.Text, FechaYMD)) > CDbl(Format(txtFecFinCon2.Text, FechaYMD)) Then
       TxtFecAsi2.Text = txtFecFinCon2.Text
       Exit Sub
    End If
    Proc_Cambia_Fecha_Vnto_Grilla Grid2, txtFecFinCon2.Text, "C"
End Sub
Private Sub TxtFecVen2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    Proc_Cambia_Fecha_Vnto_Grilla Grid2, TxtFecVen2.Text, "V"
End If
End Sub
Private Sub TxtFecVen_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    Proc_Cambia_Fecha_Vnto_Grilla Grid, TxtFecVen.Text, "V"
End If
End Sub
Private Sub txtFecVen_LostFocus()
    If CDbl(Format(TxtFecAsi.Text, FechaYMD)) > CDbl(Format(TxtFecVen.Text, FechaYMD)) Then
       TxtFecAsi.Text = TxtFecVen.Text
       Exit Sub
    End If
    Proc_Cambia_Fecha_Vnto_Grilla Grid, TxtFecVen.Text, "V"
End Sub

Private Sub txtFecVen2_LostFocus()
    If CDbl(Format(TxtFecAsi2.Text, FechaYMD)) > CDbl(Format(TxtFecVen2.Text, FechaYMD)) Then
       TxtFecAsi2.Text = TxtFecVen2.Text
       Exit Sub
    End If
    Proc_Cambia_Fecha_Vnto_Grilla Grid2, TxtFecVen2.Text, "V"
End Sub

Private Sub Grid_DblClick()
    Call textovisible
End Sub

Private Sub Grid2_DblClick()
    Call TextoVisible2
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
    
    On Error Resume Next

    Dim xx%
    Dim Datos()
    Dim Tmp, I As Integer
     
    If KeyCode = 27 Then
      Unload Me
      Exit Sub
    End If
    
    
    If KeyCode = 45 Then
        
            If Grid.Rows - 2 >= CantSistema Then Exit Sub

               ' If Grid.TextMatrix(Grid.Row, 0) = "" Or Grid.TextMatrix(Grid.Row, 2) = 0 Then
               '     Exit Sub
               ' End If
    

               Grid.Rows = Grid.Rows + 1
               Grid.Row = Grid.Rows - 1
               Grid.Col = 0
               SendKeys "{HOME}"
               
               Datos3 = Array("", "", "0.0000", "0.0000", "0.0000", "0.0000", Format(TxtFecAsi.Text, "dd/mm/yyyy"), Format(TxtFecVen.Text, "dd/mm/yyyy"), Format(txtFecFinCon.Text, "dd/mm/yyyy"))
               Grid.RowHeight(Grid.Row) = 315
            
                For xx% = 0 To Grid.Cols - 1
                    Grid.CellFontBold = False
                    Grid.TextMatrix(Grid.Row, xx%) = Datos3(xx%)
                Next xx%
               
               Call Calculo
               Call Sumatorias
               
    End If

    If KeyCode = 46 Then
    
            res = MsgBox("Esta seguro que desea Eliminar?", vbQuestion + vbYesNo, TITSISTEMA)
        
            If res = 6 Then
               If Grid.TextMatrix(Grid.Row, 0) <> "" Then

                   Envia = Array( _
                                  CDbl(TxtRut.Text), _
                                  CDbl(TxtCodCli.Text), _
                                  Trim(Right(Grid.TextMatrix(Grid.Row, 0), 5)))
   
                   If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_LEE_LINEA_TRANS", Envia) Then
                       MsgBox "Error en el Sql", vbCritical, TITSISTEMA
                       Grid.SetFocus
                   End If
   
                   If Bac_SQL_Fetch(Datos()) Then
                           If Datos(1) = CDbl(TxtRut.Text) Then
                               MsgBox "Cliente con Transacciones, No se puede Eliminar", vbExclamation, TITSISTEMA
                               Grid.SetFocus
                               Exit Sub
                           End If
                   End If
               Else
                  Grid.SetFocus
               End If
               If Grid.Rows <> 3 Then
                   Grid.RemoveItem (Grid.Row)
               Else
                   CargarGrilla
                   Grid.Enabled = True
               End If

               Call Calculo
               Call Sumatorias

            End If
            
    End If
    
    If KeyCode <> 27 And KeyCode <> 45 And KeyCode <> 46 Then
        Call textovisible
    End If
    
    

End Sub

Private Sub Grid2_KeyDown(KeyCode As Integer, Shift As Integer)
    
    On Error Resume Next

    Dim xx%
    Dim Datos()
    Dim Tmp, I As Integer
     
    If KeyCode = 27 Then
      Unload Me
      Exit Sub
    End If
    

    
    If KeyCode = 45 Then
        
            If Grid2.Rows - 2 >= CantSistema Then Exit Sub

               Grid2.Rows = Grid2.Rows + 1
               Grid2.Row = Grid2.Rows - 1
               Grid2.Col = 0
               SendKeys "{HOME}"
               
               Datos3 = Array("", "", "0.0000", "0.0000", "0.0000", "0.0000", Format(TxtFecAsi.Text, "dd/mm/yyyy"), Format(TxtFecVen.Text, "dd/mm/yyyy"), Format(txtFecFinCon.Text, "dd/mm/yyyy"))
               Grid2.RowHeight(Grid2.Row) = 315
            
                For xx% = 0 To Grid2.Cols - 1
                    Grid2.CellFontBold = False
                    Grid2.TextMatrix(Grid2.Row, xx%) = Datos3(xx%)
                Next xx%
               
               Call Calculo2
               Call Sumatorias2
               
    End If

    If KeyCode = 46 Then
    
            res = MsgBox("Esta seguro que desea Eliminar?", vbQuestion + vbYesNo, TITSISTEMA)
        
            If res = 6 Then

                Envia = Array( _
                               CDbl(TxtRut2.Text), _
                               CDbl(TxtCodCli2.Text), _
                               Trim(Right(Grid2.TextMatrix(Grid2.Row, 0), 5)))

                If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_LEE_LINEA_TRANS", Envia) Then
                    MsgBox "Error en el Sql", vbCritical, TITSISTEMA
                    Grid2.SetFocus
                End If

                If Bac_SQL_Fetch(Datos()) Then
                        If Datos(1) = CDbl(TxtRut2.Text) Then
                            MsgBox "Cliente con Transacciones, No se puede Eliminar", vbExclamation, TITSISTEMA
                            Grid2.SetFocus
                            Exit Sub
                        End If
                End If

                If Grid2.Rows <> 3 Then
                    Grid2.RemoveItem (Grid2.Row)
                Else
                    CargarGrilla2
                    Grid2.Enabled = True
                End If

                Call Calculo2
                Call Sumatorias2
            
            End If
            
    End If
    
    If KeyCode <> 27 And KeyCode <> 45 And KeyCode <> 46 Then
        Call TextoVisible2
    End If


End Sub

Private Sub Grid_KeyPress(KeyAscii As Integer)
    Dim xx
    If KeyAscii > 47 And KeyAscii < 58 Then
        TeclaPre = KeyAscii
        If Grid.Col = 1 Then
        
            Call textovisible
            txtNumGrid.Text = ""
            txtNumGrid.Text = Chr(TeclaPre)
            txtNumGrid.SelStart = 1
        End If
    End If
End Sub

Private Sub Grid2_KeyPress(KeyAscii As Integer)
    Dim xx
    If KeyAscii > 47 And KeyAscii < 58 Then
        TeclaPre = KeyAscii
        If Grid2.Col = 1 Then
        
            Call TextoVisible2
            txtNumGrid2.Text = ""
            txtNumGrid2.Text = Chr(TeclaPre)
            txtNumGrid2.SelStart = 1
        End If
    End If
    
End Sub

Private Sub Grid_Scroll()
   Grid.SetFocus
   txtNumGrid.Visible = False
   txtFecGrid.Visible = False
End Sub

Private Sub Grid2_Scroll()
   Grid2.SetFocus
   txtNumGrid2.Visible = False
   txtFecGrid2.Visible = False
End Sub

Private Sub txtFecGrid_Change()
    If CDbl(Format(txtFecGrid.Text, FechaYMD)) < CDbl(Format(FechaSistema, FechaYMD)) Or 30000000 < CDbl(Format(txtFecGrid.Text, FechaYMD)) Then
        txtFecGrid.Text = Grid.Text
    End If
End Sub

Private Sub txtFecGrid2_Change()
    If CDbl(Format(txtFecGrid2.Text, FechaYMD)) < CDbl(Format(FechaSistema, FechaYMD)) Or 30000000 < CDbl(Format(txtFecGrid2.Text, FechaYMD)) Then
        txtFecGrid2.Text = Grid2.Text
    End If
End Sub

Private Sub txtFecGrid_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 27 Then
        Grid.SetFocus
    End If
    If KeyCode = 13 Then
        Grid.Text = txtFecGrid.Text
        txtFecGrid.Visible = False
        Grid.SetFocus
    End If
End Sub

Private Sub txtFecGrid2_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 27 Then
        Grid2.SetFocus
    End If
    If KeyCode = 13 Then
        Grid2.Text = txtFecGrid2.Text
        txtFecGrid2.Visible = False
        Grid2.SetFocus
    End If
End Sub

Private Sub txtFecGrid_LostFocus()
    txtFecGrid.Visible = False
End Sub

Private Sub txtFecGrid2_LostFocus()
    txtFecGrid2.Visible = False
End Sub

Private Sub CmbGrid_Change()
    Dim X%
    Dim I%
    
    If Key = 27 Then
        CmbGrid.Visible = False
        Grid.SetFocus
    End If

    If Key = 13 Then
          If Grid.Col = 1 Then
            If Not FUNC_RECAL_OCUPADO(CDbl(Grid.TextMatrix(Grid.Row, 2)), CDbl(Grid.TextMatrix(Grid.Row, 3)), Val(Right(CmbGrid.Text, 9)), Val(Grid.TextMatrix(Grid.Row, 9))) Then
                Exit Sub
            End If
          End If
          
          
          If Grid.Col = 1 Or Grid.Col = 0 Then
             Grid.Text = CmbGrid.Text
             If GRID.Col = 1 Then
             Grid.TextMatrix(Grid.Row, 9) = CmbGrid.ItemData(CmbGrid.ListIndex) 'Right(CmbGrid.Text, 3)
             Else
                 GRID.TextMatrix(GRID.Row, 0) = CmbGrid.Text
             End If
             
          End If
          If Grid.Col = 1 Or Grid.Col = 2 Then
             'Grid.TextMatrix(Grid.Row, 3) = 0
             'Grid.TextMatrix(Grid.Row, 4) = 0
             'Grid.TextMatrix(Grid.Row, 5) = 0
             Call Calculo
             Call Sumatorias
          End If
    End If
         
    Grid.SetFocus

End Sub

Private Sub CmbGrid2_Change()
    Dim X%
    Dim I%
    
    If Key = 27 Then
        CmbGrid2.Visible = False
        Grid2.SetFocus
    End If

    If Key = 13 Then
              
          If Grid2.Col = 1 Or Grid2.Col = 0 Then
             Grid2.Text = CmbGrid2
             '' Grid2.TextMatrix(Grid2.Row, 9) = Right(CmbGrid2.Text, 3)
             If Grid2.Col = 1 Then
             Grid2.TextMatrix(Grid2.Row, 9) = Right(CmbGrid2.Text, 3)
             Else
                 Grid2.TextMatrix(Grid2.Row, 0) = CmbGrid2.Text
             End If
             
          End If
       
          If Grid2.Col = 1 Or Grid2.Col = 2 Then
             Grid2.TextMatrix(Grid2.Row, 3) = 0
             Grid2.TextMatrix(Grid2.Row, 4) = 0
             Grid2.TextMatrix(Grid2.Row, 5) = 0
             Call Calculo2
             Call Sumatorias2
          End If
    End If
         
    Grid2.SetFocus

End Sub

Private Sub CmbGrid_KeyDown(KeyCode As Integer, Shift As Integer)
Dim xFila  As Integer
Dim xColumna As Integer
Key = KeyCode
   
If KeyCode = 27 Then
    CmbGrid.Visible = False
    Grid.SetFocus
End If
   
If KeyCode = 13 Then
    xFila = Grid.Row
    xColumna = Grid.Col
    For a% = 1 To Grid.Rows - 1
        If xFila <> a% Then
            If Trim(Mid(CmbGrid.Text, 1, 30)) = Trim(Mid(Grid.TextMatrix(a%, 0), 1, 30)) Then
                MsgBox "El sistema ya esta ingresado", vbInformation, TITSISTEMA
                CmbGrid.Visible = False
                Grid.Rows = Grid.Rows - 1
                Exit Sub
            End If
        End If
    Next a%

    CmbGrid_Change
    CmbGrid.Visible = False
    Grid.Col = xColumna
    Grid.SetFocus
    Grid.Enabled = True
End If

End Sub

Private Sub CmbGrid2_KeyDown(KeyCode As Integer, Shift As Integer)
Dim xFila  As Integer
Dim xColumna As Integer
Key = KeyCode
   
If Key = 27 Then
    CmbGrid2.Visible = False
    Grid2.SetFocus
End If

If KeyCode = 13 Then
    xFila = Grid2.Row
    xColumna = Grid2.Col
    For a% = 1 To Grid2.Rows - 1
        If xFila <> a% Then
            If Trim(Mid(CmbGrid2.Text, 1, 30)) = Trim(Mid(Grid2.TextMatrix(a%, 0), 1, 30)) Then
                MsgBox "El sistema ya esta ingresado", vbInformation, TITSISTEMA
                CmbGrid2.Visible = False
                Grid2.Rows = Grid2.Rows - 1
                Exit Sub
            End If
        End If
    Next a%
    CmbGrid2_Change
    CmbGrid2.Visible = False
    Grid2.Col = xColumna
    Grid2.SetFocus
    Grid2.Enabled = True
End If

End Sub

Private Sub CmbGrid_LostFocus()
On Error GoTo Mal

Dim Datos()
'----------------------------
If Lbl_Grid.Caption = "" Or Not IsNumeric(Lbl_Grid.Caption) Then
    Lbl_Grid.Caption = 13
End If
CmbGrid.Visible = False
Lbl_Grid.Visible = True
If Grid.Col = 1 Then
'    CmbGrid.Visible = False
'    Lbl_Grid.Visible = True
    
    If CmbGrid.Text <> "" And Trim(Grid.TextMatrix(Grid.Row, 9)) <> "" And IsNumeric(Trim(Right(Grid.TextMatrix(Grid.Row, 1), 3))) Then
    
        Envia = Array()
    
        AddParam Envia, gsBAC_Fecp
        AddParam Envia, CInt(Lbl_Grid.Caption)
        AddParam Envia, CInt(Trim(Right(Grid.TextMatrix(Grid.Row, 1), 3))) ' 3 ?????
        AddParam Envia, CDbl(Grid.TextMatrix(Grid.Row, 2))    ' Asignado
        AddParam Envia, CDbl(Grid.TextMatrix(Grid.Row, 3)) ' Ocupado
        AddParam Envia, CDbl(Grid.TextMatrix(Grid.Row, 4)) ' Disponible
        AddParam Envia, CDbl(Grid.TextMatrix(Grid.Row, 5)) ' Exceso
    
    
        If Not Bac_Sql_Execute("SP_LEER_MONEDA") Then
            MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
            Exit Sub
        End If
            
        Lbl_Grid.Caption = Trim(Right(CmbGrid.Text, 3))
        
        Do While Bac_SQL_Fetch(Datos())
            If Lbl_Grid.Caption = Datos(1) Then
                Grid.TextMatrix(Grid.Row, 1) = Datos(4) & Space(100) & Lbl_Grid.Caption
            End If
        Loop
        
        If Not Bac_Sql_Execute("SP_LINEAS_CONVERTIR", Envia) Then
            MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
            Exit Sub
        End If
    
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "ERROR" Then
                MsgBox Datos(2), vbCritical
                Exit Do
            End If

            Grid.TextMatrix(Grid.Row, 2) = Format(Datos(1), FEntero)
            Grid.TextMatrix(Grid.Row, 3) = Format(Datos(2), FEntero)
            Grid.TextMatrix(Grid.Row, 4) = Format(Datos(3), FEntero)
            Grid.TextMatrix(Grid.Row, 5) = Format(Datos(4), FEntero)
        Loop
        
    Grid.Col = 1
    Grid.SetFocus
    Grid.Enabled = True
        
        
        
    End If
End If

Mal:
'----------------------
End Sub

Private Sub CmbGrid2_LostFocus()
Dim Datos()
'----------------------------
CmbGrid2.Visible = False
Lbl_Grid1.Visible = True
If Grid2.Col = 1 Then
'    CmbGrid2.Visible = False
'    Lbl_Grid1.Visible = True
    If Lbl_Grid.Caption = "" Or Not IsNumeric(Lbl_Grid.Caption) Then
        Lbl_Grid.Caption = 13
    End If
    If CmbGrid2.Text <> "" And Trim(Grid2.TextMatrix(Grid2.Row, 1)) <> "" And IsNumeric(Trim(Right(Grid2.TextMatrix(Grid2.Row, 1), 3))) Then
    
        Envia = Array()
    
        AddParam Envia, gsBAC_Fecp
        AddParam Envia, CInt(Lbl_Grid.Caption)
'        AddParam Envia, CInt(Trim(Right(CmbGrid2.Text, 3)))
        AddParam Envia, CInt(Trim(Right(Grid2.TextMatrix(Grid2.Row, 1), 3)))
        AddParam Envia, CDbl(Grid2.TextMatrix(Grid2.Row, 2))    ' Asignado
        AddParam Envia, CDbl(Grid2.TextMatrix(Grid2.Row, 3)) ' Ocupado
        AddParam Envia, CDbl(Grid2.TextMatrix(Grid2.Row, 4)) ' Disponible
        AddParam Envia, CDbl(Grid2.TextMatrix(Grid2.Row, 5)) ' Exceso
    
        If Not Bac_Sql_Execute("SP_LEER_MONEDA") Then
            MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
            Exit Sub
        End If
            
        Lbl_Grid.Caption = Trim(Right(CmbGrid2.Text, 3))

        Do While Bac_SQL_Fetch(Datos())
            If Lbl_Grid.Caption = Datos(1) Then
                Grid2.TextMatrix(Grid2.Row, 1) = Datos(4) & Space(100) & Datos(1)
            End If
        Loop
        
        If Not Bac_Sql_Execute("SP_LINEAS_CONVERTIR", Envia) Then
            MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
            Exit Sub
        End If
    
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "ERROR" Then
                MsgBox Datos(2), vbCritical, TITSISTEMA
                Exit Do
            End If
            Grid2.TextMatrix(Grid2.Row, 2) = Format(Datos(1), FEntero)
            Grid2.TextMatrix(Grid2.Row, 3) = Format(Datos(2), FEntero)
            Grid2.TextMatrix(Grid2.Row, 4) = Format(Datos(3), FEntero)
            Grid2.TextMatrix(Grid2.Row, 5) = Format(Datos(4), FEntero)
        Loop

        Grid2.Col = 1
        Grid2.SetFocus
        Grid2.Enabled = True
    End If
End If
'----------------------

End Sub

Private Sub TXTNumGrid_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 27 Then
        Grid.SetFocus
    End If
    
    If KeyCode = 13 Then
        If Grid.Col = 2 Then
            
               Grid.Text = txtNumGrid.Text
               Grid.Text = Format(Grid.Text, FEntero)
               Grid.TextMatrix(Grid.Row, 2) = txtNumGrid.Text
               txtNumGrid.Visible = False
               Grid.TextMatrix(Grid.Row, 2) = CDbl(Format(Grid.TextMatrix(Grid.Row, 2), FEntero))
               Grid.TextMatrix(Grid.Row, 2) = Format(Grid.TextMatrix(Grid.Row, 2), FEntero)
               Call Calculo
               Call Sumatorias
        End If

        Grid.Col = 2
        Grid.SetFocus
        Grid.Enabled = True
    

        
    End If
End Sub

Private Sub txtNumGrid2_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 27 Then
        Grid2.SetFocus
    End If
    
    If KeyCode = 13 Then
        If Grid2.Col = 2 Then
            
               Grid2.Text = txtNumGrid2.Text
               Grid2.Text = Format(Grid2.Text, FEntero)
               Grid2.TextMatrix(Grid2.Row, 2) = txtNumGrid2.Text
               txtNumGrid2.Visible = False
               
               If Grid2.TextMatrix(Grid2.Row, 2) = "" Then Grid2.TextMatrix(Grid2.Row, 2) = 0#
               
               Grid2.TextMatrix(Grid2.Row, 2) = CDbl(Format(Grid2.TextMatrix(Grid2.Row, 2), FEntero))
               Grid2.TextMatrix(Grid2.Row, 2) = Format(Grid2.TextMatrix(Grid2.Row, 2), FEntero)
               
               Call Calculo2
               Call Sumatorias2
        End If
        Grid2.Col = 2
        Grid2.SetFocus
        Grid2.Enabled = True

    End If
    
End Sub

Private Sub txtNumGrid_LostFocus()
    txtNumGrid.Visible = False
    Grid.Col = 2
    'GRID.SetFocus
    Grid.Enabled = True
    

End Sub

Private Sub txtNumGrid2_LostFocus()
    txtNumGrid2.Visible = False
    Grid2.Col = 2
    
    If Grid2.Enabled = True Then
      Grid2.SetFocus
    End If
    Grid2.Enabled = True
    
End Sub

Private Function Cargar()
Dim Datos()

TxtFecAsi.Tag = FechaSistema
TxtFecVen.Tag = gsBAC_Fecpx
txtFecFinCon.Tag = gsBAC_Fecpx
TxtFecAsi.Text = Format(FechaSistema, "dd/mm/yyyy")
TxtFecVen.Text = Format(gsBAC_Fecpx, "dd/mm/yyyy")
txtFecFinCon.Text = Format(gsBAC_Fecpx, "dd/mm/yyyy")
LabBloq.Caption = ""
LabTotLin.Text = 0
LabTotOcu.Caption = Format(gsc_Parametros.gsBac_TotalOcupado, FEntero)
LabTotDis.Caption = "0"
LabTotExe.Caption = Format(gsc_Parametros.gsBac_TotalOcupado, FEntero)
            
If Not Bac_Sql_Execute("SP_LEER_MONEDA") Then
    MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
    Exit Function
End If
        
Do While Bac_SQL_Fetch(Datos())
    Cmb_MonedaLG.AddItem (Datos(4) & Space(50) & Datos(1))
    Cmb_MonedaLG2.AddItem (Datos(4) & Space(50) & Datos(1))
Loop
   
End Function

Private Function Cargar2()

TxtFecAsi2.Tag = FechaSistema
TxtFecVen2.Tag = gsBAC_Fecpx
txtFecFinCon2.Tag = gsBAC_Fecpx
TxtFecAsi2.Text = Format(FechaSistema, "dd/mm/yyyy")
TxtFecVen2.Text = Format(gsBAC_Fecpx, "dd/mm/yyyy")
txtFecFinCon2.Text = Format(gsBAC_Fecpx, "dd/mm/yyyy")
LabBloq2.Caption = ""
LabTotLin2.Text = 0
LabTotOcu2.Caption = Format(gsc_Parametros.gsBac_TotalOcupado, FEntero)
LabTotDis2.Caption = "0"
LabTotExe2.Caption = Format(gsc_Parametros.gsBac_TotalOcupado, FEntero)

End Function

Private Function CargarGrilla()
Dim I%
Dim xx%
Dim Ocu As String
    
    CmbGrid.Visible = False
    txtNumGrid.Visible = False
    txtFecGrid.Visible = False
    
    Grid.Rows = 3
    Grid.FixedRows = 2
    Grid.FixedCols = 0
  ' GRID.BackColorFixed = ColorVerde
  ' GRID.ForeColorFixed = ColorBlanco
  ' GRID.BackColor = ColorGris
  ' GRID.ForeColor = ColorAzul
  ' GRID.BackColorSel = ColorAzul
  ' GRID.ForeColorSel = ColorBlanco
  ' GRID.BackColorBkg = ColorGris
    Grid.Cols = 10
    
    Titulo1 = Array("       ", "      ", "Total", "Total  ", "Total     ", "Total ", "Fecha     ", "Fecha      ", "Fecha Fin", "")
    Titulo2 = Array("Sistema", "Moneda", "Linea", "Ocupado", "Disponible", "Exceso", "Asignacion", "Vencimiento", "Contrato ", "")
    Anchos = Array("1600", "1800", "2000", "2000", "2000", "2000", "5", "1100", "1100", "1")
    Ocu = Format(gsc_Parametros.gsBac_TotalOcupado, FEntero)


    If SSTab1.TabIndex = 1 Then
      Datos3 = Array("", "", "0", "0", "0", "0", Format(TxtFecAsi.Text, "dd/mm/yyyy"), Format(TxtFecVen.Text, "dd/mm/yyyy"), Format(txtFecFinCon.Text, "dd/mm/yyyy"), "")
    Else
      Datos3 = Array("", "", "0", "0", "0", "0", Format(TxtFecAsi.Text, "dd/mm/yyyy"), Format(TxtFecVen.Text, "dd/mm/yyyy"), Format(txtFecFinCon.Text, "dd/mm/yyyy"), "")
    End If
    
    For I = 0 To Grid.Cols - 1
        Grid.Col = I
        Grid.Row = 0
        Grid.ColWidth(I) = Anchos(I)
        Grid.CellFontBold = True
        Grid.Text = Titulo1(I)
        Grid.Row = 1
        Grid.CellFontBold = True
        Grid.Text = Titulo2(I)
    Next I
    
    For I = 2 To Grid.Rows - 1
        Grid.RowHeight(I%) = 315
 
        For xx% = 0 To Grid.Cols - 1
            Grid.TextMatrix(I%, xx%) = Datos3(xx%)
        Next xx%

        Grid.CellFontBold = False
    
    Next I%
    
    Grid.Row = 1
    Grid.Col = Grid.Cols - 1
    Grid.CellFontBold = True
    Grid.Col = 0: Grid.Row = 2
    Grid.CellFontBold = False
    Grid.Enabled = False
    
    If SSTab1.TabIndex = 1 Then
        Grid.ColWidth(1) = 0
        Grid.ColWidth(3) = 0
        Grid.ColWidth(4) = 0
    End If
    
End Function

Private Function CargarGrilla2()
    Dim I%
    Dim xx%
    Dim Ocu As String
    
    CmbGrid2.Visible = False
    txtNumGrid2.Visible = False
    txtFecGrid2.Visible = False
    
    Grid2.Rows = 3
    Grid2.FixedRows = 2
    Grid2.FixedCols = 0
  ' Grid2.BackColorFixed = ColorVerde
  ' Grid2.ForeColorFixed = ColorBlanco
  ' Grid2.BackColor = ColorGris
  ' Grid2.ForeColor = ColorAzul
  ' Grid2.BackColorSel = ColorAzul
  ' Grid2.ForeColorSel = ColorBlanco
  ' Grid2.BackColorBkg = ColorGris
    Grid2.Cols = 10

    Titulo1 = Array("       ", "      ", "Total", "Total  ", "Total     ", "Total ", "Fecha     ", "Fecha      ", "Fecha Fin", "")
    Titulo2 = Array("Sistema", "Moneda", "Linea", "Ocupado", "Disponible", "Exceso", "Asignacion", "Vencimiento", "Contrato ", "")
    Anchos = Array("1600", "1800", "2000", "2000", "2000", "2000", "5", "1100", "1100", "1")

    Ocu = Format(gsc_Parametros.gsBac_TotalOcupado, FEntero)

    If SSTab1.TabIndex = 1 Then
      Datos3 = Array("", "", "0", "0", "0", "0", Format(TxtFecAsi.Text, "dd/mm/yyyy"), Format(TxtFecVen.Text, "dd/mm/yyyy"), Format(txtFecFinCon.Text, "dd/mm/yyyy"), "1")
    Else
      Datos3 = Array("", "", "0", "0", "0", "0", Format(TxtFecAsi.Text, "dd/mm/yyyy"), Format(TxtFecVen.Text, "dd/mm/yyyy"), Format(txtFecFinCon.Text, "dd/mm/yyyy"), "1")
    End If
    
    For I = 0 To Grid2.Cols - 1
        Grid2.Col = I
        Grid2.Row = 0
        Grid2.ColWidth(I) = Anchos(I)
        Grid2.CellFontBold = True
        Grid2.Text = Titulo1(I)
        Grid2.Row = 1
        Grid2.CellFontBold = True
        Grid2.Text = Titulo2(I)
    Next I
    
    For I = 2 To Grid2.Rows - 1
        Grid2.RowHeight(I%) = 315
 
        For xx% = 0 To Grid2.Cols - 1
            Grid2.TextMatrix(I%, xx%) = Datos3(xx%)
        Next xx%

        Grid2.CellFontBold = False
    
    Next I%
    
    Grid2.Row = 1
    Grid2.Col = Grid2.Cols - 1
    Grid2.CellFontBold = True
    Grid2.Col = 0: Grid2.Row = 2
    Grid2.CellFontBold = False
    Grid2.Enabled = False
    
End Function

Sub Sumatorias()

    On Error Resume Next
    Dim I%
    
    LabTotOcu.Caption = Format("0", FEntero)
    LabTotDis.Caption = Format("0", FEntero)
    LabTotExe.Caption = Format("0", FEntero)
    
    For I = 2 To Grid.Rows - 1
        LabTotOcu.Caption = LabTotOcu.Caption + CDbl(Format(Grid.TextMatrix(I, 3), FEntero))
        LabTotDis.Caption = CDbl(LabTotLin.Text) - CDbl(LabTotOcu.Caption)
        LabTotExe.Caption = LabTotExe.Caption + CDbl(Format(Grid.TextMatrix(I, 5), FEntero))
    Next I%
    
    LabTotOcu.Caption = Format(LabTotOcu.Caption, FEntero)
    LabTotDis.Caption = Format(LabTotDis.Caption, FEntero)
    LabTotExe.Caption = Format(LabTotExe.Caption, FEntero)

End Sub

Sub Sumatorias2()

    On Error Resume Next
    Dim I%
    
    
    LabTotOcu2.Caption = Format("0", FEntero)
    LabTotDis2.Caption = Format("0", FEntero)
    LabTotExe2.Caption = Format("0", FEntero)
    
    For I = 2 To Grid2.Rows - 1
        LabTotOcu2.Caption = LabTotOcu2.Caption + CDbl(Format(Grid2.TextMatrix(I, 3), FEntero))
        LabTotDis2.Caption = CDbl(LabTotLin2.Text) - CDbl(LabTotOcu2.Caption)
        LabTotExe2.Caption = LabTotExe2.Caption + CDbl(Format(Grid2.TextMatrix(I, 5), FEntero))
    Next I%
    
    
    LabTotOcu2.Caption = Format(LabTotOcu2.Caption, FEntero)
    LabTotDis2.Caption = Format(LabTotDis2.Caption, FEntero)
    LabTotExe2.Caption = Format(LabTotExe2.Caption, FEntero)

End Sub

Private Function Graba()
      Dim iContador As Integer
      Dim cMoneda   As String
      
      cMoneda = Lbl_MonedaGen.Caption & "*"
      
      If Cmb_MonedaLG.ListIndex = -1 Then
         For iContador = 0 To Cmb_MonedaLG.ListCount - 1
            If Cmb_MonedaLG.List(iContador) Like cMoneda Then
               Cmb_MonedaLG.ListIndex = iContador
               Exit For
            End If
         Next iContador
      End If
                 
      Envia = Array()
      AddParam Envia, CDbl(TxtRut.Text)
      AddParam Envia, CDbl(TxtCodCli.Text)
      AddParam Envia, TxtFecAsi.Text
      AddParam Envia, TxtFecVen.Text
      AddParam Envia, txtFecFinCon.Text
      AddParam Envia, "N"
      AddParam Envia, CDbl(LabTotLin.Text)
      AddParam Envia, CDbl(LabTotOcu.Caption)
      AddParam Envia, CDbl(LabTotDis.Caption)
      AddParam Envia, CDbl(LabTotExe.Caption)
      AddParam Envia, Right(Cmb_MonedaLG.Text, 3)
      AddParam Envia, CDbl(TxtMtoThresHold.Text)
      AddParam Envia, CMBMonedaThreshold.ItemData(CMBMonedaThreshold.ListIndex)
      If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_GRABA", Envia) Then
         MsgBox "No se puede grabar la linea general", vbCritical, TITSISTEMA
         Exit Function
      End If
      For iContador = 2 To Grid.Rows - 1
         Envia = Array()
         AddParam Envia, CDbl(TxtRut.Text)
         AddParam Envia, CDbl(TxtCodCli.Text)
         AddParam Envia, Trim(Right(Grid.TextMatrix(iContador, 0), 5))
         AddParam Envia, Grid.TextMatrix(iContador, 6)
         AddParam Envia, Grid.TextMatrix(iContador, 7)
         AddParam Envia, Grid.TextMatrix(iContador, 8)
         AddParam Envia, "N"
         AddParam Envia, CDbl(Grid.TextMatrix(iContador, 2))
         AddParam Envia, CDbl(Grid.TextMatrix(iContador, 3))
         AddParam Envia, CDbl(Grid.TextMatrix(iContador, 4))
         AddParam Envia, CDbl(Grid.TextMatrix(iContador, 5))
         AddParam Envia, Trim(Grid.TextMatrix(iContador, 9))
         If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_GRABALINEASISTEMA", Envia) Then
            MsgBox "No se puede Grabar", vbCritical, TITSISTEMA
         End If
      Next iContador
      
      MsgBox "Grabacion de lineas realizada con exito", vbInformation, TITSISTEMA
   
      TxtRut.Text = ""
      TxtCodCli.Text = 0
      TxtRut.Enabled = True
      TxtCodCli.Enabled = True
      Toolbar1.Buttons(1).Enabled = False
      labDigVeri.Caption = ""
      LabNombre.Caption = ""
      TxtMtoThresHold.Text = 0
    
      Call Cargar
      Call Limpiar
    
      Grid.Enabled = False
      TxtRut.SetFocus
      
End Function

Private Function Graba2()
      Dim DATOS()
      Dim iContador As Integer
      Dim cMoneda   As String
      


oForzado = -1

      
      SW_PadreHijo = 0
      Call Busca_HijoPadre
If oForzado = 1 Then
      If SW_PadreHijo > 0 Then
         Exit Function
      End If
      
      Envia = Array()
      AddParam Envia, Format(Str(TxtRut2.Text), "0")
      AddParam Envia, CDbl(TxtCodCli2.Text)
      If Lbl_MonedaGen2.Visible = True Then
         AddParam Envia, Trim(Right(Lbl_Auxi2.Caption, 3))
      Else
         AddParam Envia, Trim(Right(Cmb_MonedaLG2, 3))
      End If
      
      'If Not Bac_Sql_Execute("Sp_Valida_TipoMoneda_Padre_Hijo", Envia) Then
      If Not Bac_Sql_Execute("SP_VALIDA_MONEDA_RELACION", Envia) Then
         Screen.MousePointer = vbDefault
         MsgBox "Ha ocurrido un error al intenter validar el tipo de moneda", vbCritical, TITSISTEMA
         Exit Function
      Else
         If Bac_SQL_Fetch(DATOS) Then
            If DATOS(1) <> 0 Then
               MsgBox DATOS(2), vbExclamation + vbOKOnly
               Exit Function
               
            End If
         End If
      End If
      
      cMoneda = Lbl_MonedaGen2.Caption & "*"
      
      If Cmb_MonedaLG2.ListIndex = -1 Then
         For iContador = 0 To Cmb_MonedaLG2.ListCount - 1
            If Cmb_MonedaLG2.List(iContador) Like cMoneda Then
               Cmb_MonedaLG2.ListIndex = iContador
               Exit For
            End If
         Next iContador
      End If
     
      Envia = Array()
      AddParam Envia, CDbl(TxtRut2.Text)
      AddParam Envia, CDbl(TxtCodCli2.Text)
      AddParam Envia, TxtFecAsi2.Text
      AddParam Envia, TxtFecVen2.Text
      AddParam Envia, txtFecFinCon2.Text
      AddParam Envia, "N"
      AddParam Envia, CDbl(LabTotLin2.Text)
      AddParam Envia, CDbl(LabTotOcu2.Caption)
      AddParam Envia, CDbl(LabTotDis2.Caption)
      AddParam Envia, CDbl(LabTotExe2.Caption)
      AddParam Envia, Right(Cmb_MonedaLG2, 3)
      AddParam Envia, CDbl(TXTMtoThresHold2.Text)
      AddParam Envia, CMBMonedaThreshold2.ItemData(CMBMonedaThreshold2.ListIndex)
      '-->agregar campo threshold
      
      If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_GRABA", Envia) Then
         MsgBox "No se puede grabar la linea general", vbCritical, TITSISTEMA
         Exit Function
      End If
      For iContador = 2 To Grid2.Rows - 1

         Envia = Array()
         AddParam Envia, CDbl(TxtRut2.Text)
         AddParam Envia, CDbl(TxtCodCli2.Text)
         AddParam Envia, Trim(Right(Grid2.TextMatrix(iContador, 0), 5))
         AddParam Envia, Grid2.TextMatrix(iContador, 6)
         AddParam Envia, Grid2.TextMatrix(iContador, 7)
         AddParam Envia, Grid2.TextMatrix(iContador, 8)
         AddParam Envia, "N"
         AddParam Envia, CDbl(Grid2.TextMatrix(iContador, 2))
         AddParam Envia, CDbl(Grid2.TextMatrix(iContador, 3))
         AddParam Envia, CDbl(Grid2.TextMatrix(iContador, 4))
         AddParam Envia, CDbl(Grid2.TextMatrix(iContador, 5))
         AddParam Envia, Grid2.TextMatrix(iContador, 9)
         If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_GRABALINEASISTEMA", Envia) Then
            MsgBox "No se puede Grabar", vbCritical, TITSISTEMA
         End If
      Next iContador
      
      MsgBox "Grabacion de lineas realizada con exito", vbInformation, TITSISTEMA
   
      TxtRut2.Text = ""
      TxtCodCli2.Text = 0
      TxtRut2.Enabled = True
      TxtCodCli2.Enabled = True
      Toolbar2.Buttons(1).Enabled = False
      labDigVeri2.Caption = ""
      LabNombre2.Caption = ""
      TXTMtoThresHold2.Text = 0
    
      Call Cargar2
      Call Limpiar2
    
      Grid2.Enabled = False
      TxtRut2.SetFocus
End If

      
End Function

Private Function Limpiar()

    Dim I As Integer

    Grid.Rows = Grid.Rows - 1
    Grid.Rows = 3
    
    If SSTab1.TabIndex = 1 Then
      Datos3 = Array("", "", "0.0000", "0.0000", "0.0000", "0.0000", Format(TxtFecAsi.Text, "dd/mm/yyyy"), Format(TxtFecVen.Text, "dd/mm/yyyy"), Format(txtFecFinCon.Text, "dd/mm/yyyy"), "")
    Else
      Datos3 = Array("", "", "0.0000", "0.0000", "0.0000", "0.0000", Format(TxtFecAsi.Text, "dd/mm/yyyy"), Format(TxtFecVen.Text, "dd/mm/yyyy"), Format(txtFecFinCon.Text, "dd/mm/yyyy"), "")
    End If
         
         For I = 2 To Grid.Rows - 1
             Grid.RowHeight(I%) = 315
             
             For xx% = 0 To Grid.Cols - 1
                 Grid.TextMatrix(I%, xx%) = Datos3(xx%)
             Next xx%

             Grid.CellFontBold = False
         Next I%
         
Lbl_Auxi.Caption = 0
Lbl_MonedaGen.Caption = "--------------------"
CmdLcr.Item(1).Enabled = False
   '->  Limpia y Setea el valor por defecto del combo
   Call FuncCargaMonedaThreshold(CMBMonedaThreshold)
   '-------------------------------------------------
End Function

Private Function Limpiar2()

    Dim I As Integer

    Grid2.Rows = Grid2.Rows - 1
    Grid2.Rows = 3
    
    If SSTab1.TabIndex = 1 Then
      Datos3 = Array("", "", "0.0000", "0.0000", "0.0000", "0.0000", Format(TxtFecAsi.Text, "dd/mm/yyyy"), Format(TxtFecVen.Text, "dd/mm/yyyy"), Format(txtFecFinCon.Text, "dd/mm/yyyy"), "")
    Else
      Datos3 = Array("", "", "0.0000", "0.0000", "0.0000", "0.0000", Format(TxtFecAsi.Text, "dd/mm/yyyy"), Format(TxtFecVen.Text, "dd/mm/yyyy"), Format(txtFecFinCon.Text, "dd/mm/yyyy"), "")
    End If
         
         For I = 2 To Grid2.Rows - 1
             Grid2.RowHeight(I%) = 315
             
             For xx% = 0 To Grid2.Cols - 1
                 Grid2.TextMatrix(I%, xx%) = Datos3(xx%)
             Next xx%

             Grid2.CellFontBold = False
         Next I%
         
Lbl_Auxi2.Caption = 0
Lbl_MonedaGen2.Caption = "--------------------"
CmdLcr.Item(0).Enabled = False
   '->  Limpia y Setea el valor por defecto del combo
   Call FuncCargaMonedaThreshold(CMBMonedaThreshold2)
   '-------------------------------------------------
         
End Function

Private Function Elimina()
    Dim Datos()
    Dim I%

    Envia = Array()
    AddParam Envia, CDbl(TxtRut.Text)
    AddParam Envia, CDbl(TxtCodCli.Text)
    
    If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_LEE_LINEA_TRANS", Envia) Then
         MsgBox "Error en las Lineas de Credito..." & Chr(10) _
            & "Imposible continuar con la Operación", vbInformation, TITSISTEMA
         Grid.SetFocus
         Exit Function
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
    
      If Datos(1) = TxtRut.Text Then
         MsgBox "Cliente con Transacciones, No se puede Eliminar", vbExclamation, TITSISTEMA
         Grid.SetFocus
         Exit Function
      End If
      
    End If
    
    Envia = Array("B")
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
         GoTo Error
         Exit Function
    End If
    
    Envia = Array( _
                  CDbl(TxtRut.Text), _
                  CDbl(TxtCodCli.Text) _
                  )
                  
    If Not Bac_Sql_Execute("SP_CLIENTES_ASOCIADOS", Envia) Then
      GoTo Error
    End If
    
    Do While Bac_SQL_Fetch(Datos())
    
        If Datos(1) = "SI" Then
            MsgBox "No puede eliminar linea de cliente, ya que existen entidades asociadas al grupo", vbExclamation, Me.Caption
            Exit Function
        End If

    Loop

    
    If Not Bac_Sql_Execute("SP_LINEACREDITOLINEA_ELIMINA", Envia) Then
      GoTo Error
    End If
    
    If Not Bac_Sql_Execute("SP_LINEACREDITOSISTEMA_ELIMINA", Envia) Then
      GoTo Error
    End If
    
    If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_ELIMINA", Envia) Then
      GoTo Error
    End If
   
    Envia = Array("C")
    
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
        GoTo Error
    End If
   
    MsgBox "Datos Eliminado en forma exitosa ", vbInformation, TITSISTEMA
    
    TxtRut.Text = ""
    TxtCodCli.Text = 0
    labDigVeri.Caption = ""
    LabNombre.Caption = ""
    
    Call Cargar
    Call Limpiar
    
    Grid.Enabled = False
    TxtRut.SetFocus
    TxtRut.Enabled = True
    TxtCodCli.Enabled = True
    Exit Function
Error:
   
   Envia = Array("R")
   
   If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
      MsgBox "ERROR: Se Produjo un Error en la Eliminación", vbCritical, TITSISTEMA
      Exit Function
   End If
   
   Grid.SetFocus
   
End Function

Private Function Elimina2()
    Dim Datos()
    Dim I%

    Envia = Array()
    AddParam Envia, CDbl(TxtRut2.Text)
    AddParam Envia, CDbl(TxtCodCli2.Text)
    
    If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_LEE_LINEA_TRANS", Envia) Then
         MsgBox "Error en las Lineas de Credito..." & Chr(10) _
            & "Imposible continuar con la Operación", vbInformation, TITSISTEMA
         Grid2.SetFocus
         Exit Function
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
    
      If DATOS(1) = CDbl(TxtRut2.Text) Then
      'If DATOS(1) = TxtRut2.Text Then
         MsgBox "Cliente con Transacciones, No se puede Eliminar", vbExclamation, TITSISTEMA
         Grid2.SetFocus
         Exit Function
      End If
      
    End If
    
    Envia = Array("B")
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
         GoTo Error
         Exit Function
    End If
    
   Envia = Array(CDbl(TxtRut2.Text), CDbl(TxtCodCli2.Text))
    If Not Bac_Sql_Execute("SP_CLIENTES_ASOCIADOS", Envia) Then
      GoTo Error
    End If
    
    Do While Bac_SQL_Fetch(Datos())
    
        If Datos(1) = "SI" Then
            MsgBox "No puede eliminar linea de cliente, ya que existen entidades asociadas al grupo", vbExclamation, Me.Caption
            Exit Function
        End If

    Loop
    
    If Not Bac_Sql_Execute("SP_LINEACREDITOLINEA_ELIMINA", Envia) Then
      GoTo Error
    End If
    
    If Not Bac_Sql_Execute("SP_LINEACREDITOSISTEMA_ELIMINA", Envia) Then
      GoTo Error
    End If
    
    If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_ELIMINA", Envia) Then
      GoTo Error
    End If
   
    Envia = Array("C")
    
    If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
        GoTo Error
    End If
   
    MsgBox "Datos Eliminado en forma exitosa ", vbInformation, TITSISTEMA
    
    TxtRut2.Text = ""
    TxtCodCli2.Text = 0
    labDigVeri2.Caption = ""
    LabNombre2.Caption = ""
    
    Call Cargar2
    Call Limpiar2
    
    Grid2.Enabled = False
    TxtRut2.SetFocus
    TxtRut2.Enabled = True
    TxtCodCli2.Enabled = True
    Exit Function
Error:
   
   Envia = Array("R")
   
   If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
      MsgBox "ERROR: Se Produjo un Error en la Eliminación", vbCritical, TITSISTEMA
      Exit Function
   End If
   
   Grid2.SetFocus
   
End Function

Private Function Busca(Optional FilaActual As String, Optional ColumnaActual As String)

    Dim Datos()
    Dim I%
    Dim SW As Integer
    Dim Fila As Integer
    Dim nSw As Integer
    Dim nAfectaLinea As Integer
    
    nSw = 0
    nAfectaLinea = 2
    If CDbl(TxtRut.Text) = 0 Or CDbl(TxtCodCli.Text) = 0 Then
        Exit Function
    End If
    
    Envia = Array()
    AddParam Envia, CDbl(TxtRut.Text)
    AddParam Envia, CDbl(TxtCodCli.Text)
    AddParam Envia, CDbl(nSw)
    
    If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_AYUDACLIENTE_BANCOS", Envia) Then
        Exit Function
    End If
    swexiste = 0
    SW = 0
    
    Toolbar1.Buttons(5).Enabled = True
    
    Do While Bac_SQL_Fetch(Datos())
    
    
        If Datos(1) = "SI" Then
            MsgBox "Entidad forma parte del grupo: " & Datos(2), vbExclamation, Me.Caption
            nSw = 1
            nAfectaLinea = DATOS(4)
        End If
            
            
            If nAfectaLinea = 0 Then
            Toolbar1.Buttons(1).Enabled = False
            Toolbar1.Buttons(2).Enabled = False
            Toolbar1.Buttons(5).Enabled = False
            TxtRut.Text = 0
            swexiste = 1
            Grid.Enabled = False
            Exit Function
            Else
                  '*****************************
                  Envia = Array()
                  AddParam Envia, CDbl(TXTRut.Text)
                  AddParam Envia, CDbl(TxtCodCli.Text)
                  AddParam Envia, CDbl(nSw)
            
                  If Not Bac_Sql_Execute("Sp_LineaCreditoGeneral_AyudaCliente_Bancos", Envia) Then
                        Exit Function
        End If
    
                  Do While Bac_SQL_Fetch(DATOS())
        labDigVeri.Caption = Datos(5)
        LabNombre.Caption = Datos(3)
        TxtMtoThresHold.Text = Datos(6)
        TxtRut.Enabled = False
        TxtCodCli.Enabled = False
        Toolbar1.Buttons(4).Enabled = False
        Toolbar1.Buttons(1).Enabled = True
        SW = 1
    
    Loop
            End If

    
    Loop
    
    If SW = 0 Then
        MsgBox "Cliente no Existe o no Corresponde a Esta Categoria", vbExclamation, Me.Caption
        Exit Function
    End If
    
    Envia = Array()
    AddParam Envia, CDbl(TxtRut.Text)
    AddParam Envia, CDbl(TxtCodCli.Text)
    If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_BUSCA", Envia) Then
        MsgBox "No se puede Mostrar", vbCritical, TITSISTEMA
    End If
    Dim xAuxi As Double
    
    With Grid
        .Rows = 2
        Do While Bac_SQL_Fetch(Datos())
            Grid.Enabled = True
            TxtFecAsi.Text = Format(Datos(5), "dd/mm/yyyy")
            TxtFecVen.Text = Format(Datos(6), "dd/mm/yyyy")
            txtFecFinCon.Text = Format(Datos(7), "dd/mm/yyyy")
            LabBloq.Caption = Datos(8)
            Lbl_Auxi.Caption = Datos(22)
            LabTotLin.Text = Datos(9)
            LabTotOcu.Caption = Format(Datos(10), FEntero)
            LabTotDis.Caption = Format(Datos(11), FEntero)
            LabTotExe.Caption = Format(Datos(12), FEntero)

            'PROD-10967
            Let CMBMonedaThreshold.Text = Trim(DATOS(27))
            LabCodMetodologia.Caption = DATOS(28)
            LabNomMetod.Caption = DATOS(29)
            LabSegComercial.Caption = DATOS(30)
            LabEjecComercial.Caption = DATOS(31)
            'PROD-10967
            
            .Rows = .Rows + 1
            .RowHeight(Grid.Rows - 1) = 315
            .TextMatrix(Grid.Rows - 1, 0) = Datos(13)
            .TextMatrix(Grid.Rows - 1, 1) = Datos(23)
            .TextMatrix(Grid.Rows - 1, 2) = Format(Datos(18), FEntero)
            .TextMatrix(Grid.Rows - 1, 3) = Format(Datos(19), FEntero)
            .TextMatrix(Grid.Rows - 1, 4) = Format(Datos(20), FEntero)
            .TextMatrix(Grid.Rows - 1, 5) = Format(Datos(21), FEntero)

            .TextMatrix(Grid.Rows - 1, 6) = Format(Datos(14), "dd/mm/yyyy")
            .TextMatrix(Grid.Rows - 1, 7) = Format(Datos(15), "dd/mm/yyyy")
            .TextMatrix(Grid.Rows - 1, 8) = Format(Datos(16), "dd/mm/yyyy")
            .TextMatrix(Grid.Rows - 1, 9) = Datos(23)
        Loop
    
    End With
    
    If Not Bac_Sql_Execute("Sp_Leer_Moneda") Then
        MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
        Exit Function
    End If
        
    Do While Bac_SQL_Fetch(Datos())
        If Lbl_Auxi.Caption = Datos(1) Then
            Lbl_MonedaGen.Caption = Datos(4)
        End If
    Loop
    
    'PROD-10967
    
        Envia = Array()
        AddParam Envia, CDbl(TxtRut.Text)
        AddParam Envia, CDbl(TxtCodCli.Text)
    If Not Bac_Sql_Execute("BacParamSuda..SP_GARANTIAS_GLOBALES", Envia) Then
        MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
        Exit Function
    End If
        
    Do While Bac_SQL_Fetch(DATOS())
            LabGarConst.Caption = Format(DATOS(3), FEntero)
            LabGarAsoc.Caption = Format(DATOS(4), FEntero)
            LabGarEfect.Caption = Format(DATOS(5), FEntero)
    Loop
    
    
    'PROD-10967

    
    
    If Grid.Rows = 2 Then
        Call Cargar
        Call CargarGrilla
        Grid.Enabled = True
        Toolbar1.Buttons(2).Enabled = False
    Else
        Toolbar1.Buttons(2).Enabled = True
        
        If Not Bac_Sql_Execute("SP_LEER_SISTAMA_CNT") Then
            MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
            Exit Function
        End If
        
        Do While Bac_SQL_Fetch(Datos())
        
            For I% = 2 To Grid.Rows - 1
                If Grid.TextMatrix(I%, 0) = Datos(1) Then
                   Grid.TextMatrix(I%, 0) = Datos(2) & Space(50) & Datos(1)
                End If
            Next I%
        
        Loop
    
    
        If Not Bac_Sql_Execute("Sp_Leer_Moneda") Then
            MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
            Exit Function
        End If
        
        Do While Bac_SQL_Fetch(Datos())
        
            For I% = 2 To Grid.Rows - 1
                If Grid.TextMatrix(I%, 1) = Datos(1) Then
                   Grid.TextMatrix(I%, 1) = Datos(4) & Space(50) & Datos(1)
                End If
            Next I%
        
        Loop
    
    
    
    End If
    
    GridOculta.Clear
    GridOculta.Rows = 1
    
    With GridOculta
    
        Envia = Array(CDbl(TxtRut.Text), _
        CDbl(TxtCodCli.Text))
        
        If Not Bac_Sql_Execute("SP_LINEACREDITOLINEA_BUSCA", Envia) Then
            MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
            Exit Function
        End If

        Do While Bac_SQL_Fetch(Datos())
            .Rows = .Rows + 1
            .Row = .Rows - 1
            .TextMatrix(.Row, 0) = Datos(1)     ' Rut Cliente
            .TextMatrix(.Row, 1) = Datos(2)     ' Código Cliente
            .TextMatrix(.Row, 2) = Datos(3)     ' Sistema
            .TextMatrix(.Row, 3) = Datos(13)    ' Nombre Producto
            .TextMatrix(.Row, 4) = Datos(4)     ' Plazo Desde
            .TextMatrix(.Row, 5) = Datos(5)     ' Plazo Hasta
            .TextMatrix(.Row, 6) = Datos(6)     ' Porcentaje
            .TextMatrix(.Row, 7) = Datos(7)     ' Total Asignado
            .TextMatrix(.Row, 8) = Datos(8)     ' Total Ocupado
            .TextMatrix(.Row, 9) = Datos(9)     ' Total Disponible
            .TextMatrix(.Row, 10) = Datos(10)   ' Total Exceso
            .TextMatrix(.Row, 11) = Datos(11)   ' Total Traspaso
            .TextMatrix(.Row, 12) = Datos(12)   ' Total Recibido
            .TextMatrix(.Row, 13) = Datos(14)   ' Código Producto

        Loop
                
    End With

    'CASS
    If Trim(FilaActual) <> "" And Trim(ColumnaActual) <> "" Then
          Grid.Row = FilaActual ' FilaActual
          Grid.Col = ColumnaActual ' FilaActual
    End If
    
End Function

Private Function BUSCA2()

    Dim Datos()
    Dim I%
    Dim SW As Integer
    Dim nSw As Integer
    Dim nAfectaLinea As Integer
    
      nSw = 0
      nAfectaLinea = 2
    If CDbl(TxtRut2.Text) = 0 Or CDbl(TxtCodCli2.Text) = 0 Then
        Exit Function
    End If
    
    Envia = Array()
    AddParam Envia, CDbl(TxtRut2.Text)
    AddParam Envia, CDbl(TxtCodCli2.Text)
    AddParam Envia, CDbl(nSw)
    
    If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_AYUDACLIENTE_NOBANCOS", Envia) Then
        Exit Function
    End If
    swexiste = 0
    SW = 0
    
    Toolbar2.Buttons(5).Enabled = True
    Do While Bac_SQL_Fetch(Datos())
    
        If Datos(1) = "SI" Then
            MsgBox "Entidad forma parte del grupo: " & Datos(2), vbExclamation, Me.Caption
            nSw = 1
            nAfectaLinea = DATOS(4)
        End If
        
        
        If nAfectaLinea = 0 Then
            Toolbar2.Buttons(1).Enabled = False
            Toolbar2.Buttons(2).Enabled = False
            Toolbar2.Buttons(5).Enabled = False
            TxtRut2.Text = 0
            Grid2.Enabled = False
            swexiste = 1
            Exit Function
        Else
               
            '*****************************
            Envia = Array()
            AddParam Envia, CDbl(TxtRut2.Text)
            AddParam Envia, CDbl(TxtCodCli2.Text)
            AddParam Envia, CDbl(nSw)

            If Not Bac_Sql_Execute("Sp_LineaCreditoGeneral_AyudaCliente_NoBancos", Envia) Then
               Exit Function
            End If
    
            Do While Bac_SQL_Fetch(DATOS())
    
        labDigVeri2.Caption = Datos(5)
        LabNombre2.Caption = Datos(3)
        TXTMtoThresHold2.Text = IIf(IsNull(Datos(7)) = True, 0, Datos(7))
    
        TxtRut2.Enabled = False
        TxtCodCli2.Enabled = False
        Toolbar2.Buttons(2).Enabled = False
        Toolbar2.Buttons(1).Enabled = True
    
        SW = 1
    
    Loop
         End If
    
    Loop

    
    
    If SW = 0 Then
        MsgBox "Cliente no Existe o no Corresponde a Esta Categoria", vbExclamation, Me.Caption
        Exit Function
    End If
    
    Envia = Array()
    AddParam Envia, CDbl(TxtRut2.Text)
    AddParam Envia, CDbl(TxtCodCli2.Text)
                
    If Not Bac_Sql_Execute("SP_LINEACREDITOGENERAL_BUSCA", Envia) Then
        MsgBox "No se puede Mostrar", vbCritical, TITSISTEMA
    End If
    
    With Grid2
    
        .Rows = 2
        
        Do While Bac_SQL_Fetch(Datos())

            Grid2.Enabled = True
            TxtFecAsi2.Text = Format(Datos(5), "dd/mm/yyyy")
            TxtFecVen2.Text = Format(Datos(6), "dd/mm/yyyy")
            txtFecFinCon2.Text = Format(Datos(7), "dd/mm/yyyy")
            LabBloq2.Caption = Datos(8)
            Lbl_Auxi2.Caption = Datos(22)
            
            LabTotLin2.Text = Datos(9)
            LabTotOcu2.Caption = Format(Datos(10), FEntero)
            LabTotDis2.Caption = Format(Datos(11), FEntero)
            LabTotExe2.Caption = Format(Datos(12), FEntero)
            
            'PROD-10967
            Let CMBMonedaThreshold2.Text = Trim(DATOS(27))
            LabCodMetodologia2.Caption = DATOS(28)
            LabNomMetod2.Caption = DATOS(29)
            LabSegComercial2.Caption = DATOS(30)
            LabEjecComercial2.Caption = DATOS(31)
            'PROD-10967
           
            .Rows = .Rows + 1
            .RowHeight(Grid2.Rows - 1) = 315
            .TextMatrix(Grid2.Rows - 1, 0) = Datos(13)
            .TextMatrix(Grid2.Rows - 1, 1) = Datos(23)
            .TextMatrix(Grid2.Rows - 1, 2) = Format(Datos(18), FEntero)
            .TextMatrix(Grid2.Rows - 1, 3) = Format(Datos(19), FEntero)
            .TextMatrix(Grid2.Rows - 1, 4) = Format(Datos(20), FEntero)
            .TextMatrix(Grid2.Rows - 1, 5) = Format(Datos(21), FEntero)

            .TextMatrix(Grid2.Rows - 1, 6) = Format(Datos(14), "dd/mm/yyyy")
            .TextMatrix(Grid2.Rows - 1, 7) = Format(Datos(15), "dd/mm/yyyy")
            .TextMatrix(Grid2.Rows - 1, 8) = Format(Datos(16), "dd/mm/yyyy")
            .TextMatrix(Grid2.Rows - 1, 9) = Datos(23)
        Loop
    
    End With
    
    If Not Bac_Sql_Execute("SP_LEER_MONEDA") Then
        MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
        Exit Function
    End If
        
    Do While Bac_SQL_Fetch(Datos())
        If Lbl_Auxi2.Caption = Datos(1) Then
            Lbl_MonedaGen2.Caption = Datos(4)
        End If
    Loop
    
    'PROD-10967
    
        Envia = Array()
        AddParam Envia, CDbl(TxtRut2.Text)
        AddParam Envia, CDbl(TxtCodCli2.Text)
    If Not Bac_Sql_Execute("BacParamSuda..SP_GARANTIAS_GLOBALES", Envia) Then
        MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
        Exit Function
    End If
        
    Do While Bac_SQL_Fetch(DATOS())
            LabGarConst2.Caption = Format(DATOS(3), FEntero)
            LabGarAsoc2.Caption = Format(DATOS(4), FEntero)
            LabGarEfect2.Caption = Format(DATOS(5), FEntero)
    Loop
    
    
    'PROD-10967
    
    
    If Grid2.Rows = 2 Then
        Call Cargar2
        Call CargarGrilla2
        Grid2.Enabled = True
        Toolbar2.Buttons(2).Enabled = False
    Else
        Toolbar2.Buttons(2).Enabled = True
        
        If Not Bac_Sql_Execute("SP_LEER_SISTAMA_CNT") Then
            MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
            Exit Function
        End If
        
        Do While Bac_SQL_Fetch(Datos())
        
            For I% = 2 To Grid2.Rows - 1
                If Grid2.TextMatrix(I%, 0) = Datos(1) Then
                   Grid2.TextMatrix(I%, 0) = Datos(2) & Space(50) & Datos(1)
                End If
            Next I%
        
        Loop
    
        If Not Bac_Sql_Execute("Sp_Leer_Moneda") Then
            MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
            Exit Function
        End If
        
        Do While Bac_SQL_Fetch(Datos())
        
            For I% = 2 To Grid2.Rows - 1
                If Grid2.TextMatrix(I%, 1) = Datos(1) Then
                   Grid2.TextMatrix(I%, 1) = Datos(4) & Space(50) & Datos(1)
                End If
            Next I%
        
        Loop
    
    
    End If
    
    GridOculta.Clear
    GridOculta.Rows = 1
    
    With GridOculta2
    
        Envia = Array(CDbl(TxtRut2.Text), _
        CDbl(TxtCodCli2.Text))
        
        If Not Bac_Sql_Execute("SP_LINEACREDITOLINEA_BUSCA", Envia) Then
            MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
            Exit Function
        End If

        Do While Bac_SQL_Fetch(Datos())
            .Rows = .Rows + 1
            .Row = .Rows - 1
            .TextMatrix(.Row, 0) = Datos(1)     ' Rut Cliente
            .TextMatrix(.Row, 1) = Datos(2)     ' Código Cliente
            .TextMatrix(.Row, 2) = Datos(3)     ' Sistema
            .TextMatrix(.Row, 3) = Datos(13)    ' Nombre Producto
            .TextMatrix(.Row, 4) = Datos(4)     ' Plazo Desde
            .TextMatrix(.Row, 5) = Datos(5)     ' Plazo Hasta
            .TextMatrix(.Row, 6) = Datos(6)     ' Porcentaje
            .TextMatrix(.Row, 7) = Datos(7)     ' Total Asignado
            .TextMatrix(.Row, 8) = Datos(8)     ' Total Ocupado
            .TextMatrix(.Row, 9) = Datos(9)     ' Total Disponible
            .TextMatrix(.Row, 10) = Datos(10)   ' Total Exceso
            .TextMatrix(.Row, 11) = Datos(11)   ' Total Traspaso
            .TextMatrix(.Row, 12) = Datos(12)   ' Total Recibido
            .TextMatrix(.Row, 13) = Datos(14)   ' Código Producto

        Loop
                
    End With

End Function

Private Function textovisible()
   Dim I%
   Dim Datos()
    
   If Not CHEQUEA_MODULOS(gsBAC_User, Trim(Right(Grid.TextMatrix(Grid.RowSel, 0), 5))) Then
      Call MsgBox("Customer Service" & vbCrLf & vbCrLf & "No se permite la manipulación de esta información.-", vbExclamation, App.Title)
      Call Grid.SetFocus
      Exit Function
   End If
    
    
    If Grid.Col = 0 Then
       If Trim(Grid.TextMatrix(Grid.Row, 0)) <> "" Then
          If Toolbar1.Buttons(2).Enabled = True Then
'              Exit Function
          End If
       End If
    
       CmbGrid.Clear
       Call PROC_POSICIONA_TEXTO(Grid, CmbGrid)
       
       If Not Bac_Sql_Execute("SP_LEER_SISTAMA_CNT") Then
          Exit Function
       End If
       
       Do While Bac_SQL_Fetch(Datos())
          CmbGrid.AddItem (Datos(2) & Space(50) & Datos(1))
       Loop
          
       For I% = 0 To CmbGrid.ListCount - 1
          CmbGrid.ListIndex = I%
          If Grid.Text = CmbGrid Then
              Exit For
          Else
              CmbGrid.ListIndex = -1
          End If
       Next I%
                
       CmbGrid.Visible = True
       CmbGrid.SetFocus
       
    ElseIf Grid.Col = 1 Then
    

       If Trim(Grid.TextMatrix(Grid.Row, 0)) <> "" Then

       End If
    
       CmbGrid.Clear
       Call PROC_POSICIONA_TEXTO(Grid, CmbGrid)
       
       
       If Not Bac_Sql_Execute("SP_LEER_MONEDA") Then
          Exit Function
       End If
       CmbGrid.Clear
       Do While Bac_SQL_Fetch(Datos())
          CmbGrid.AddItem (Datos(4) & Space(50) & Datos(1))
          CmbGrid.ItemData(CmbGrid.NewIndex) = Datos(1)
       Loop
       For I% = 0 To CmbGrid.ListCount - 1
          If CmbGrid.List(I%) Like Grid.Text & "*" Then
             CmbGrid.ListIndex = I%
             Exit For
          End If
       Next I%
       
       If Right(CmbGrid.Text, 3) <> "" Then
            Lbl_Grid.Caption = Right(CmbGrid.Text, 3)
       End If
       CmbGrid.Visible = True
       CmbGrid.SetFocus
    
    ElseIf Grid.Col = 2 Then
          Call PROC_POSICIONA_TEXTO(Grid, txtNumGrid)
          txtNumGrid.Text = BacCtrlTransMonto(CDbl(Grid.Text))
          txtNumGrid.Visible = True
          txtNumGrid.SetFocus
    
    ElseIf Grid.Col = 6 Then
       
       Call PROC_POSICIONA_TEXTO(Grid, txtFecGrid)
       txtFecGrid.Text = Grid.Text
       txtFecGrid.Visible = True
       txtFecGrid.SetFocus
    
    ElseIf Grid.Col = 7 Then
           
       Call PROC_POSICIONA_TEXTO(Grid, txtFecGrid)
       txtFecGrid.Text = Grid.Text
       txtFecGrid.Visible = True
       txtFecGrid.SetFocus
    
    ElseIf Grid.Col = 8 Then
           
       Call PROC_POSICIONA_TEXTO(Grid, txtFecGrid)
       txtFecGrid.Text = Grid.Text
       txtFecGrid.Visible = True
       txtFecGrid.SetFocus
End If

End Function

Private Function TextoVisible2()
   Dim I%
   Dim Datos()
    
   If Not CHEQUEA_MODULOS(gsBAC_User, Trim(Right(Grid2.TextMatrix(Grid2.RowSel, 0), 5))) Then
      Call MsgBox("Customer Service" & vbCrLf & vbCrLf & "No se permite la manipulación de esta información.-", vbExclamation, App.Title)
      Call Grid2.SetFocus
      Exit Function
   End If
    
    
    If Grid2.Col = 0 Then
       If Trim(Grid2.TextMatrix(Grid2.Row, 0)) <> "" Then
          If Toolbar2.Buttons(2).Enabled = True Then
'              Exit Function
          End If
       End If
    
       CmbGrid2.Clear
       Call PROC_POSICIONA_TEXTO(Grid2, CmbGrid2)
       
       If Not Bac_Sql_Execute("SP_LEER_SISTAMA_CNT") Then
          Exit Function
       End If
       
       Do While Bac_SQL_Fetch(Datos())
        If (Metodologia_LCR <> 1 And Metodologia_LCR <> 4) Then
          CmbGrid2.AddItem (Datos(2) & Space(50) & Datos(1))
        Else
           If DATOS(1) <> "DRV" Then
              CmbGrid2.AddItem (DATOS(2) & Space(50) & DATOS(1))
           End If
        End If
       Loop
          
       For I% = 0 To CmbGrid2.ListCount - 1
          CmbGrid2.ListIndex = I%
          If Grid2.Text = CmbGrid2 Then
              Exit For
          Else
              CmbGrid2.ListIndex = -1
          End If
       Next I%
                
       CmbGrid2.Visible = True
       CmbGrid2.SetFocus
       
    ElseIf Grid2.Col = 1 Then
       If Trim(Grid2.TextMatrix(Grid2.Row, 0)) <> "" Then

       End If
    
       CmbGrid2.Clear
       Call PROC_POSICIONA_TEXTO(Grid2, CmbGrid2)
       
       
       If Not Bac_Sql_Execute("SP_LEER_MONEDA") Then
          Exit Function
       End If
       
       Do While Bac_SQL_Fetch(Datos())
          CmbGrid2.AddItem (Datos(4) & Space(50) & Datos(1))
       Loop
          
       For I% = 0 To CmbGrid2.ListCount - 1
          CmbGrid2.ListIndex = I%
          If Grid2.Text = CmbGrid2 Then
              Exit For
          Else
              CmbGrid2.ListIndex = -1
          End If
       Next I%
                
       CmbGrid2.Visible = True
       CmbGrid2.SetFocus
            
            
            
    ElseIf Grid2.Col = 2 Then
          
          Call PROC_POSICIONA_TEXTO(Grid2, txtNumGrid2)
          txtNumGrid2.Text = BacCtrlTransMonto(CDbl(Grid2.Text))
          txtNumGrid2.Visible = True
          txtNumGrid2.SetFocus
    
    ElseIf Grid2.Col = 6 Then
       
       Call PROC_POSICIONA_TEXTO(Grid2, txtFecGrid2)
       txtFecGrid2.Text = Grid2.Text
       txtFecGrid2.Visible = True
       txtFecGrid2.SetFocus
    
    ElseIf Grid2.Col = 7 Then
           
       Call PROC_POSICIONA_TEXTO(Grid2, txtFecGrid2)
       txtFecGrid2.Text = Grid2.Text
       txtFecGrid2.Visible = True
       txtFecGrid2.SetFocus
    
    ElseIf Grid2.Col = 8 Then
           
       Call PROC_POSICIONA_TEXTO(Grid2, txtFecGrid2)
       txtFecGrid2.Text = Grid2.Text
       txtFecGrid2.Visible = True
       txtFecGrid2.SetFocus

   End If
End Function

Private Function Calculo()
   
    If (CDbl(Format(Grid.TextMatrix(Grid.Row, 2), FEntero))) >= (CDbl(Format(Grid.TextMatrix(Grid.Row, 3), FEntero))) Then
         Grid.TextMatrix(Grid.Row, 4) = CDbl(Format(Grid.TextMatrix(Grid.Row, 2), FEntero)) - CDbl(Format(Grid.TextMatrix(Grid.Row, 3), FEntero))
    Else
         Grid.TextMatrix(Grid.Row, 4) = 0 'CDbl(Format(Grid.TextMatrix(Grid.Row, 2), FEntero)) - CDbl(Format(Grid.TextMatrix(Grid.Row, 3), FEntero))
    End If
    
    Grid.TextMatrix(Grid.Row, 2) = Format(Grid.TextMatrix(Grid.Row, 2), FEntero)
    Grid.TextMatrix(Grid.Row, 3) = Format(Grid.TextMatrix(Grid.Row, 3), FEntero)
    Grid.TextMatrix(Grid.Row, 4) = Format(Grid.TextMatrix(Grid.Row, 4), FEntero)
    Grid.TextMatrix(Grid.Row, 5) = Format(Grid.TextMatrix(Grid.Row, 5), FEntero)
            
End Function

Private Function Calculo2()
   
    If (CDbl(Format(Grid2.TextMatrix(Grid2.Row, 2), FEntero))) >= (CDbl(Format(Grid2.TextMatrix(Grid2.Row, 3), FEntero))) Then
         Grid2.TextMatrix(Grid2.Row, 4) = CDbl(Format(Grid2.TextMatrix(Grid2.Row, 2), FEntero)) - CDbl(Format(Grid2.TextMatrix(Grid2.Row, 3), FEntero))
    Else
         Grid2.TextMatrix(Grid2.Row, 4) = CDbl(Format(Grid2.TextMatrix(Grid2.Row, 2), FEntero)) - CDbl(Format(Grid2.TextMatrix(Grid2.Row, 3), FEntero))
    End If
    
    Grid2.TextMatrix(Grid2.Row, 2) = Format(Grid2.TextMatrix(Grid2.Row, 2), FEntero)
    Grid2.TextMatrix(Grid2.Row, 3) = Format(Grid2.TextMatrix(Grid2.Row, 3), FEntero)
    Grid2.TextMatrix(Grid2.Row, 4) = Format(Grid2.TextMatrix(Grid2.Row, 4), FEntero)
    Grid2.TextMatrix(Grid2.Row, 5) = Format(Grid2.TextMatrix(Grid2.Row, 5), FEntero)
            
End Function

Private Function CantSistema() As Integer
   Dim Datos()
    
   CantSistema = 0

   If Bac_Sql_Execute("SP_LEER_SISTAMA_CNT") Then
      While Bac_SQL_Fetch(Datos())
         CantSistema = CantSistema + 1
      Wend
   End If

End Function



Private Function FUNC_RECAL_OCUPADO(nlinea As Double, nMonto As Double, nMoneda As Integer, nmonedant As Integer)
On Error GoTo Mal
   
   Dim Datos()
    
   If nMoneda = 0 Or nmonedant = 0 Then
        FUNC_RECAL_OCUPADO = True
        Exit Function
   End If
       
   
   FUNC_RECAL_OCUPADO = False
   
    Envia = Array()
    AddParam Envia, CDbl(nlinea)
    AddParam Envia, CDbl(nMonto)
    AddParam Envia, CDbl(nMoneda)
    AddParam Envia, CDbl(nmonedant)

    If Not Bac_Sql_Execute("SP_RECALCULA_OCUPADO", Envia) Then
        Exit Function
    End If

    Do While Bac_SQL_Fetch(Datos())
        If Datos(1) = "ERROR" Then
            MsgBox Datos(2), vbCritical
            Exit Function
        End If
        
        Grid.TextMatrix(Grid.Row, 2) = Datos(3)
        Grid.TextMatrix(Grid.Row, 3) = Datos(2)
        Grid.TextMatrix(Grid.Row, 4) = Datos(4)
        Grid.TextMatrix(Grid.Row, 5) = Datos(5)
    
    Loop

FUNC_RECAL_OCUPADO = True

Exit Function
Mal:

FUNC_RECAL_OCUPADO = False
End Function



Private Function Busca_HijoPadre()
Dim DATOS()
Dim Rut As Long
 Dim oMensaje    As String

Let oCodMensaje = 0



   If CDbl(TxtRut2.Text) = 0 Or CDbl(TxtCodCli2.Text) = 0 Then
         Exit Function
   End If
    
   'Envia = Array()
   'AddParam Envia, Format(Str(TxtRut2.Text), "0")
   'AddParam Envia, CDbl(TxtCodCli2.Text)
   'If Not Bac_Sql_Execute("Sp_Busca_HijosPadres", Envia) Then
      'MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
      'Exit Function
   'End If
            
   'If Bac_SQL_Fetch(DATOS()) Then
         'Rut = DATOS(1)
   'End If

   Envia = Array()
   AddParam Envia, Format(Str(TxtRut2.Text), "0")
   'AddParam Envia, CDbl(Rut)
   AddParam Envia, Format(Str(LabTotLin2.Text), "0")
   AddParam Envia, CDbl(TxtCodCli2.Text)
   'If Not Bac_Sql_Execute("Sp_Valida_MontoAsignado", Envia) Then
   If Not Bac_Sql_Execute("Sp_Valida_MontoAsignadoIng", Envia) Then
      MsgBox "Error al intentar validar el monto asignado", vbCritical, TITSISTEMA
      Exit Function
   Else
      If Bac_SQL_Fetch(DATOS) Then
         If DATOS(1) <> 0 Then
            'MsgBox DATOS(2), vbExclamation + vbOKOnly
            Let oCodMensaje = DATOS(1)
            Let oMensaje = DATOS(2)
            GoTo ErrorGrabacion
            'SW_PadreHijo = 1
            'Exit Function
         End If
      Else
         oForzado = 1
            Exit Function
         End If
      End If
   
ErrorGrabacion:
    
    
   If oMensaje = "" Then
        'MsgBox Err.Description, vbExclamation, TITSISTEMA
        MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
   Else
      If oCodMensaje = -1 Then
         If MsgBox(oMensaje & vbCrLf & vbCrLf & "¿ Esta seguro que desea grabar ?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
             oForzado = 1
            'GoTo GRABARFORZADO
         End If
      Else
         MsgBox oMensaje, vbExclamation, TITSISTEMA
   End If
    End If
   

End Function

