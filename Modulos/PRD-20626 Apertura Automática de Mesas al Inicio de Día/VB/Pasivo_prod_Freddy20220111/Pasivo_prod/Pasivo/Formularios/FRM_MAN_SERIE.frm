VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_MAN_SERIE 
   Appearance      =   0  'Flat
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Series Bonos y Letras"
   ClientHeight    =   7785
   ClientLeft      =   2115
   ClientTop       =   2040
   ClientWidth     =   7860
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   Icon            =   "FRM_MAN_SERIE.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7785
   ScaleWidth      =   7860
   Begin MSComctlLib.Toolbar Barra_Menu 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   44
      Top             =   0
      Width           =   7860
      _ExtentX        =   13864
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
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
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   17
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Vista Previa"
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   18
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   6720
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
               Picture         =   "FRM_MAN_SERIE.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_SERIE.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Align           =   1  'Align Top
      Height          =   7320
      Left            =   0
      TabIndex        =   34
      Top             =   450
      Width           =   7860
      _Version        =   65536
      _ExtentX        =   13864
      _ExtentY        =   12912
      _StockProps     =   15
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
      Begin VB.Frame Frame2 
         Caption         =   "Gastos Estimados"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1395
         Left            =   120
         TabIndex        =   67
         Top             =   3840
         Width           =   5955
         Begin BACControles.TXTNumero FTB_VALOR_ESTIMADO1 
            Height          =   315
            Left            =   120
            TabIndex        =   23
            Top             =   420
            Width           =   2730
            _ExtentX        =   4815
            _ExtentY        =   556
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
            Text            =   "0,00"
            Text            =   "0,00"
            Min             =   "0"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero FTB_VALOR_ESTIMADO2 
            Height          =   315
            Left            =   90
            TabIndex        =   25
            Top             =   990
            Width           =   2730
            _ExtentX        =   4815
            _ExtentY        =   556
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
            Text            =   "0,00"
            Text            =   "0,00"
            Min             =   "0"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero FTB_VALOR_ESTIMADO3 
            Height          =   315
            Left            =   3030
            TabIndex        =   24
            Top             =   420
            Width           =   2730
            _ExtentX        =   4815
            _ExtentY        =   556
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
            Text            =   "0,00"
            Text            =   "0,00"
            Min             =   "0"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero FTB_VALOR_ESTIMADO4 
            Height          =   315
            Left            =   3000
            TabIndex        =   26
            Top             =   990
            Width           =   2730
            _ExtentX        =   4815
            _ExtentY        =   556
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
            Text            =   "0,00"
            Text            =   "0,00"
            Min             =   "0"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Label9 
            AutoSize        =   -1  'True
            Caption         =   "Comisiones Pagadas a Corredor"
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
            Left            =   105
            TabIndex        =   71
            Top             =   240
            Width           =   2685
         End
         Begin VB.Label Label8 
            AutoSize        =   -1  'True
            Caption         =   "Costo Emisión Bono"
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
            Left            =   3030
            TabIndex        =   70
            Top             =   240
            Width           =   1665
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "Descuento Bono"
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
            Left            =   105
            TabIndex        =   69
            Top             =   780
            Width           =   1350
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Otros"
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
            Left            =   3150
            TabIndex        =   68
            Top             =   780
            Width           =   465
         End
      End
      Begin VB.ComboBox Cmb_Tipo_Bono 
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
         Left            =   6240
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   33
         ToolTipText     =   "Período de Amortización de Capital"
         Top             =   4125
         Width           =   1380
      End
      Begin VB.Frame Frame1 
         Caption         =   "P36"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1905
         Left            =   120
         TabIndex        =   59
         Top             =   5280
         Width           =   5955
         Begin BACControles.TXTNumero TxtClasificadora_de_Riesgo1 
            Height          =   315
            Left            =   120
            TabIndex        =   27
            Top             =   420
            Width           =   2730
            _ExtentX        =   4815
            _ExtentY        =   556
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
            Min             =   "0"
            Max             =   "999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.TextBox TxtClasificacion_de_Riesgo2 
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
            Left            =   3150
            MaxLength       =   5
            TabIndex        =   30
            Top             =   990
            Width           =   2730
         End
         Begin VB.TextBox TxtClasificacion_de_Riesgo1 
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
            Left            =   3150
            MaxLength       =   5
            TabIndex        =   28
            Top             =   450
            Width           =   2730
         End
         Begin VB.TextBox TxtNumero_de_inscripcion 
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
            Left            =   105
            MaxLength       =   10
            TabIndex        =   31
            Top             =   1500
            Width           =   2745
         End
         Begin BACControles.TXTNumero Gastos_Colocacion 
            Height          =   330
            Left            =   3120
            TabIndex        =   32
            Top             =   1500
            Width           =   2715
            _ExtentX        =   4789
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
            Text            =   "0,0000"
            Text            =   "0,0000"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero TxtClasificadora_de_Riesgo2 
            Height          =   315
            Left            =   90
            TabIndex        =   29
            Top             =   990
            Width           =   2730
            _ExtentX        =   4815
            _ExtentY        =   556
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
            Min             =   "0"
            Max             =   "999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Label6 
            AutoSize        =   -1  'True
            Caption         =   "Clasificación de Riesgo  2"
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
            Left            =   3150
            TabIndex        =   65
            Top             =   780
            Width           =   2085
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "Clasificadora de Riesgo 2"
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
            Left            =   105
            TabIndex        =   64
            Top             =   780
            Width           =   2070
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            Caption         =   "Clasificación de Riesgo  1"
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
            Left            =   3150
            TabIndex        =   63
            Top             =   240
            Width           =   2085
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Clasificadora de Riesgo 1"
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
            Left            =   105
            TabIndex        =   62
            Top             =   240
            Width           =   2070
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Número de inscripción"
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
            Left            =   105
            TabIndex        =   61
            Top             =   1290
            Width           =   1875
         End
         Begin VB.Label Label 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Gastos Colocación"
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
            Left            =   4320
            TabIndex        =   60
            Top             =   1290
            Width           =   1530
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   975
         Index           =   0
         Left            =   105
         TabIndex        =   35
         Top             =   15
         Width           =   7680
         _Version        =   65536
         _ExtentX        =   13547
         _ExtentY        =   1720
         _StockProps     =   14
         Caption         =   " Datos Serie "
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
         Font3D          =   3
         Begin VB.TextBox Txt_Instrumento 
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
            Left            =   75
            MaxLength       =   8
            MousePointer    =   14  'Arrow and Question
            TabIndex        =   0
            Top             =   525
            Width           =   1335
         End
         Begin VB.TextBox txt_Mascara 
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
            Left            =   2670
            MaxLength       =   15
            MousePointer    =   14  'Arrow and Question
            TabIndex        =   2
            Top             =   525
            Width           =   1335
         End
         Begin VB.ComboBox Cmb_Base 
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
            Left            =   6765
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   525
            Width           =   750
         End
         Begin VB.ComboBox Cmb_Moneda 
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
            Left            =   5460
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   525
            Width           =   1170
         End
         Begin BACControles.TXTNumero ftbtera 
            Height          =   330
            Left            =   4050
            TabIndex        =   3
            Top             =   525
            Width           =   1230
            _ExtentX        =   2170
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
            Text            =   "0,0000"
            Text            =   "0,0000"
            Min             =   "-999"
            Max             =   "999"
            CantidadDecimales=   "4"
         End
         Begin BACControles.TXTNumero Txt_Familia 
            Height          =   330
            Left            =   1545
            TabIndex        =   1
            Top             =   525
            Width           =   765
            _ExtentX        =   1349
            _ExtentY        =   582
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
            Min             =   "0"
            Max             =   "5"
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            Caption         =   "Instrumento"
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
            Left            =   105
            TabIndex        =   51
            Top             =   330
            Width           =   1035
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            Caption         =   "Tera"
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
            Left            =   4050
            TabIndex        =   40
            Top             =   315
            Width           =   375
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
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
            Index           =   4
            Left            =   6795
            TabIndex        =   39
            Top             =   315
            Width           =   405
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
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
            Index           =   3
            Left            =   5460
            TabIndex        =   38
            Top             =   330
            Width           =   660
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            Caption         =   "Código"
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
            Left            =   1560
            TabIndex        =   37
            Top             =   330
            Width           =   585
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            Caption         =   "Máscara"
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
            Left            =   2700
            TabIndex        =   36
            Top             =   330
            Width           =   690
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   2880
         Index           =   1
         Left            =   105
         TabIndex        =   41
         Top             =   945
         Width           =   7695
         _Version        =   65536
         _ExtentX        =   13573
         _ExtentY        =   5080
         _StockProps     =   14
         Caption         =   " Datos de Emisión "
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
         Font3D          =   3
         Begin VB.ComboBox Cmb_Amortiza 
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
            Left            =   1860
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   20
            ToolTipText     =   "Período de Amortización de Capital"
            Top             =   2445
            Width           =   1980
         End
         Begin VB.TextBox txt_Rut_Emi 
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
            Height          =   330
            Left            =   105
            MaxLength       =   9
            MousePointer    =   14  'Arrow and Question
            TabIndex        =   6
            Top             =   525
            Width           =   1095
         End
         Begin VB.TextBox txt_Nombre_Emisor 
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
            Left            =   1635
            MaxLength       =   40
            TabIndex        =   8
            Top             =   525
            Width           =   5955
         End
         Begin VB.TextBox txt_Digito 
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
            Left            =   1320
            MaxLength       =   1
            TabIndex        =   7
            Top             =   525
            Width           =   285
         End
         Begin BACControles.TXTNumero ftbtasaemision 
            Height          =   330
            Left            =   3960
            TabIndex        =   12
            Top             =   1110
            Width           =   1095
            _ExtentX        =   1931
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
            Text            =   "0,0000"
            Text            =   "0,0000"
            Min             =   "-999"
            Max             =   "999"
            CantidadDecimales=   "4"
         End
         Begin BACControles.TXTNumero ftbplazo 
            Height          =   330
            Left            =   1500
            TabIndex        =   10
            Top             =   1110
            Width           =   855
            _ExtentX        =   1508
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
            Text            =   "0,0"
            Text            =   "0,0"
            Min             =   "0"
            Max             =   "100"
            CantidadDecimales=   "1"
         End
         Begin BACControles.TXTFecha dtbfechavcto 
            Height          =   330
            Left            =   2550
            TabIndex        =   11
            Top             =   1110
            Width           =   1365
            _ExtentX        =   2408
            _ExtentY        =   582
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
            Text            =   "09/11/2000"
         End
         Begin BACControles.TXTFecha dtbfechaemision 
            Height          =   330
            Left            =   105
            TabIndex        =   9
            Top             =   1110
            Width           =   1395
            _ExtentX        =   2461
            _ExtentY        =   582
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
            Text            =   "09/11/2000"
         End
         Begin BACControles.TXTFecha dtbprimercorte 
            Height          =   330
            Left            =   105
            TabIndex        =   14
            Top             =   1830
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   582
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
            Text            =   "09/11/2000"
         End
         Begin BACControles.TXTNumero Txt_Dia_Pago 
            Height          =   330
            Left            =   3675
            TabIndex        =   16
            Top             =   1830
            Width           =   735
            _ExtentX        =   1296
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
            Min             =   "0"
            Max             =   "99"
         End
         Begin BACControles.TXTNumero Valor_Nominal 
            Height          =   330
            Left            =   5130
            TabIndex        =   13
            Top             =   1110
            Width           =   2475
            _ExtentX        =   4366
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
            Text            =   "0,0000"
            Text            =   "0,0000"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTFecha Fecha_Colocacion 
            Height          =   330
            Left            =   1890
            TabIndex        =   15
            Top             =   1830
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   582
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
            Text            =   "09/11/2000"
         End
         Begin BACControles.TXTNumero itbcupones 
            Height          =   330
            Left            =   4890
            TabIndex        =   17
            Top             =   1815
            Width           =   780
            _ExtentX        =   1376
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
            Min             =   "0"
            Max             =   "100"
         End
         Begin BACControles.TXTNumero itbNumDecimales 
            Height          =   330
            Left            =   6300
            TabIndex        =   18
            Top             =   1815
            Width           =   1065
            _ExtentX        =   1879
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
            Min             =   "0"
            Max             =   "9"
         End
         Begin BACControles.TXTNumero itbNumAmortizacion 
            Height          =   330
            Left            =   90
            TabIndex        =   19
            Top             =   2460
            Width           =   1695
            _ExtentX        =   2990
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
            Min             =   "0"
            Max             =   "100"
            Separator       =   -1  'True
         End
         Begin Threed.SSFrame Frame 
            Height          =   570
            Index           =   3
            Left            =   4020
            TabIndex        =   58
            Top             =   2220
            Width           =   3555
            _Version        =   65536
            _ExtentX        =   6271
            _ExtentY        =   1005
            _StockProps     =   14
            Caption         =   "BONO"
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
            Font3D          =   3
            Begin VB.CheckBox CHK_Bono 
               Caption         =   "Subordinado"
               Height          =   240
               Left            =   195
               TabIndex        =   21
               Top             =   255
               Width           =   1605
            End
            Begin VB.CheckBox CHK_tasa_variable 
               Caption         =   "Tasa Variable"
               Height          =   270
               Left            =   1770
               TabIndex        =   22
               Top             =   240
               Visible         =   0   'False
               Width           =   1650
            End
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Periodo Pago Cupón"
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
            Left            =   1875
            TabIndex        =   57
            Top             =   2220
            Width           =   1680
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Nº Amortizaciones"
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
            Left            =   120
            TabIndex        =   56
            Top             =   2250
            Width           =   1515
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Nº Decimales"
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
            Left            =   6300
            TabIndex        =   55
            Top             =   1590
            Width           =   1065
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Cupones"
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
            Height          =   225
            Index           =   11
            Left            =   4920
            TabIndex        =   54
            Top             =   1590
            Width           =   750
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Fecha Limite Col."
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
            Left            =   1890
            TabIndex        =   53
            Top             =   1590
            Width           =   1410
         End
         Begin VB.Label Label 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Nominal Emisión"
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
            Left            =   5910
            TabIndex        =   52
            Top             =   870
            Width           =   1665
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Día Pago"
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
            Left            =   3675
            TabIndex        =   50
            Top             =   1590
            Width           =   690
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Fecha Primer Corte"
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
            Index           =   23
            Left            =   105
            TabIndex        =   49
            Top             =   1590
            Width           =   1605
         End
         Begin VB.Line Line1 
            X1              =   1230
            X2              =   1290
            Y1              =   675
            Y2              =   675
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Plazo (años)"
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
            Left            =   1530
            TabIndex        =   48
            Top             =   870
            Width           =   1005
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Fecha Emisión"
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
            TabIndex        =   47
            Top             =   870
            Width           =   1185
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Fecha Vcto."
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
            Left            =   2565
            TabIndex        =   46
            Top             =   870
            Width           =   945
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Tasa Emisión"
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
            Left            =   3900
            TabIndex        =   45
            Top             =   870
            Width           =   1095
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
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
            Index           =   5
            Left            =   105
            TabIndex        =   43
            Top             =   315
            Width           =   900
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
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
            Index           =   6
            Left            =   1665
            TabIndex        =   42
            Top             =   315
            Width           =   660
         End
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo Bono"
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
         Left            =   6240
         TabIndex        =   66
         Top             =   3885
         Width           =   825
      End
   End
End
Attribute VB_Name = "FRM_MAN_SERIE"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cHay_Datos      As String
Private Sub Barra_Menu_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Trim(UCase(Button.Key))
Case "LIMPIAR"
    Call PROC_LIMPIAR_PANTALLA

Case "GRABAR"

   If txt_Mascara.Text = "" Or TXT_Familia.Text = "" Then
      Exit Sub
   End If
   If Not FUNC_CHEQUEA_DATOS Then
      MsgBox ("No se ha podido realizar la grabación, debe llenar campo solicitado"), vbInformation
   Else
      Call PROC_GRABAR_SERIE
   End If

Case "ELIMINAR"
    Call PROC_ELIMINAR_SERIES

Case "BUSCAR"
    Call PROC_BUSCAR_SERIES
    
Case "IMPRIMIR"
    Call FUNC_IMPRIME_TDESARROLLO(1)

Case "VISTA PREVIA"
    Call FUNC_IMPRIME_TDESARROLLO(2)

Case "SALIR"
    Unload Me
        
End Select
End Sub



Private Sub CHK_Bono_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        CHK_tasa_variable.SetFocus
    End If

End Sub

Private Sub CHK_tasa_variable_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Me.TXT_Familia.SetFocus
    End If

End Sub

Private Sub Cmb_Amortiza_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        CHK_Bono.SetFocus
    End If

End Sub

Private Sub Cmb_Base_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        txt_Rut_Emi.SetFocus
    End If
End Sub

Private Sub Cmb_Moneda_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        CMB_Base.SetFocus
    End If
End Sub

Private Sub dtbfechaemision_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Me.ftbplazo.SetFocus
    End If

End Sub

Private Sub dtbfechaemision_LostFocus()
If dtbfechaemision.Text > GLB_Fecha_Proceso Then
    MsgBox ("Fecha de Emisión no puede ser mayor a Fecha Proceso"), vbInformation
    dtbfechaemision.Text = GLB_Fecha_Proceso
    dtbfechaemision.SetFocus
    Exit Sub
End If
Call FUNC_CALCULA_DIF_FECHAS(dtbfechaemision.Text, dtbfechavcto.Text, "Y")
End Sub

Private Sub dtbfechavcto_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        ftbtasaemision.SetFocus
    End If

End Sub

Private Sub dtbfechavcto_LostFocus()
Call FUNC_CALCULA_DIF_FECHAS(dtbfechaemision.Text, dtbfechavcto.Text, "Y")
End Sub

Private Sub dtbprimercorte_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Txt_Dia_Pago.SetFocus
    End If

End Sub

Private Sub dtbprimercorte_LostFocus()
If dtbprimercorte.Enabled Then
        
        If CDate(dtbprimercorte.Text) > CDate(Me.dtbfechavcto.Text) Then
            MsgBox ("Fecha de primer corte no puede ser mayor a fecha de vencimiento"), vbOKOnly + vbInformation
            dtbprimercorte.Text = GLB_Fecha_Proceso
            Exit Sub
        End If
        
        If CDate(dtbprimercorte.Text) < CDate(Me.dtbfechaemision.Text) Then
            MsgBox ("Fecha de primer corte no puede ser menor a fecha de emisión"), vbOKOnly + vbInformation
            dtbprimercorte.Text = GLB_Fecha_Proceso
            Exit Sub
        End If

End If

End Sub

Private Sub Form_Activate()
   Call PROC_CARGA_AYUDA(Me)
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim Opcion As Integer
   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

   Opcion = 0
   Select Case KeyCode
         Case vbKeyLimpiar
               Opcion = 1
         Case vbKeyGrabar
               Opcion = 2
         Case vbKeyEliminar
               Opcion = 3
         Case vbKeyBuscar
               Opcion = 4
         Case VbKeyImprimir
               Opcion = 5
         Case vbKeyVistaPrevia
               Opcion = 6
         Case vbKeySalir
               Opcion = 7
   End Select

   If Opcion <> 0 Then
      If Barra_Menu.Buttons(Opcion).Enabled Then
         Call Barra_Menu_ButtonClick(Barra_Menu.Buttons(Opcion))
      End If
   End If

End If

End Sub

Private Sub Form_Load()
   
   GLB_cOptLocal = cOpt
   Me.top = 0
   Me.left = 0
   Me.Icon = FRM_MDI_PASIVO.Icon
   
   Call PROC_LLENA_DATOS
   
   Barra_Menu.Buttons(1).Enabled = True
   Barra_Menu.Buttons(3).Enabled = False
   Barra_Menu.Buttons(4).Enabled = True
   Barra_Menu.Buttons(5).Enabled = False
   Barra_Menu.Buttons(6).Enabled = False

   CMB_Moneda.Enabled = True
   CMB_Base.Enabled = True
   
   Call PROC_LOG_AUDITORIA("01", GLB_cOptLocal, Me.Caption & " Ingreso a mantenedor de series ", "", "")
End Sub


Private Sub PROC_LIMPIAR_PANTALLA()
On Error GoTo Error_limpiar
    
    Barra_Menu.Buttons(1).Enabled = True
    Barra_Menu.Buttons(3).Enabled = False
    Barra_Menu.Buttons(4).Enabled = True
    Barra_Menu.Buttons(5).Enabled = False
    Barra_Menu.Buttons(6).Enabled = False
    TXT_Instrumento.Text = ""
    TXT_Familia.Tag = "FAMILIA"
    cHay_Datos = "N"
    ftbtera.TabStop = False
    txt_Mascara.Enabled = True
    TXT_Instrumento.Enabled = True
    TXT_Familia.Tag = ""
    CHK_Bono.Value = 0
    CHK_Bono.Enabled = True
    TXT_Familia.Text = ""
    txt_Mascara.Text = ""
    TXT_Digito.Text = ""
    txt_Nombre_Emisor.Text = ""
    txt_Rut_Emi.Text = ""
    TXT_Instrumento.SetFocus
    ftbplazo.Text = 0
    ftbtasaemision.Text = 0
    ftbtera.Text = 0
    Me.itbcupones.Text = 0
    Me.itbNumAmortizacion.Text = 0
    Me.itbNumDecimales.Text = 0
    Me.Txt_Dia_Pago.Text = 0
    CHK_tasa_variable.Value = 0
    Call FUNC_CON_CMBAMORTIZA(Me.Cmb_Amortiza, GLB_Sistema)
    Call FUNC_CON_TIPO_BONO(Me.Cmb_Tipo_Bono, GLB_Sistema)
    Cmb_Tipo_Bono.ListIndex = -1
    
    dtbfechaemision.Text = GLB_Fecha_Proceso
    dtbfechavcto.Text = GLB_Fecha_Proceso
    dtbprimercorte.Text = GLB_Fecha_Proceso
    Fecha_Colocacion.Text = GLB_Fecha_Proceso
    Valor_Nominal.Text = 0
    Gastos_Colocacion.Text = 0
    TxtNumero_de_inscripcion.Text = ""
    TxtClasificadora_de_Riesgo1.Text = 0
    TxtClasificacion_de_Riesgo1.Text = ""
    TxtClasificadora_de_Riesgo2.Text = 0
    TxtClasificacion_de_Riesgo2.Text = ""
    FTB_VALOR_ESTIMADO1.Text = 0
    FTB_VALOR_ESTIMADO2.Text = 0
    FTB_VALOR_ESTIMADO3.Text = 0
    FTB_VALOR_ESTIMADO4.Text = 0
    Exit Sub

Error_limpiar:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
    Exit Sub

End Sub

Private Sub ftbplazo_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        dtbfechavcto.SetFocus
    End If

End Sub

Private Sub ftbplazo_LostFocus()
    Call FUNC_SUMA_FECHAS(dtbfechaemision.Text, ftbplazo.Text)
End Sub

Private Sub ftbtasaemision_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        dtbprimercorte.SetFocus
    End If
End Sub

Private Sub ftbtera_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        CMB_Moneda.SetFocus
    End If
End Sub


Private Sub itbcupones_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Me.itbNumDecimales.SetFocus
    End If

End Sub

Private Sub itbcupones_LostFocus()
If Val(Me.itbcupones.Text) < Val(Me.itbNumAmortizacion.Text) Then
    MsgBox ("Número de Cupones no puede ser menor a Número de Amortizaciones"), vbInformation
    Me.itbcupones.Text = 0
    Me.itbcupones.SetFocus
End If
End Sub

Private Sub itbNumAmortizacion_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Me.Cmb_Amortiza.SetFocus
    End If

End Sub

Private Sub itbNumAmortizacion_LostFocus()
If Val(Me.itbNumAmortizacion.Text) > Val(Me.itbcupones.Text) Then
    MsgBox ("Número de Amortizaciones no puede ser mayor a Número de Cupones"), vbInformation
    Me.itbNumAmortizacion.Text = 0
    Me.itbNumAmortizacion.SetFocus
End If
End Sub

Private Sub itbNumDecimales_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Me.itbNumAmortizacion.SetFocus
    End If

End Sub

Private Sub Txt_Dia_Pago_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
        Me.itbcupones.SetFocus
End If

End Sub

Sub PROC_CON_FAMILIA()
   On Error GoTo Error_Con_Familia
   
   cHay_Datos = "N"
   
   Pbl_cTipo_Instrumento = "BOYLE"
   cMiTag = "MDIN"
   
   FRM_AYUDA.Show 1
   If GLB_Aceptar% = True Then
      ' GLB_codigo$       'codigo_instrumento
      ' GLB_Descripcion$  'nombre instrumento
      ' GLB_nombre$       'Descripcion
      TXT_Familia.Text = GLB_codigo$
      TXT_Instrumento.Text = GLB_nombre$
      cHay_Datos = "S"
      txt_Mascara.SetFocus
      TXT_Instrumento.Enabled = False
   End If

Exit Sub
Error_Con_Familia:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
    Exit Sub
End Sub

Function FUNC_CON_FAMILIA(cFamilia As String) As Boolean
   Dim Datos()

    FUNC_CON_FAMILIA = False

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, ""                        ' Producto
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(TXT_Familia.Text)    ' Instrumento
    PROC_AGREGA_PARAMETRO GLB_Envia, cFamilia                  ' Glosa
    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_INST_BONOS", GLB_Envia) Then
        If FUNC_LEE_RETORNO_SQL(Datos()) Then
            TXT_Familia.Text = Datos(1)
            FUNC_CON_FAMILIA = True
            TXT_Instrumento.Enabled = False
        End If
    Else
        Exit Function
    End If
    

End Function


Private Sub Txt_Dia_Pago_LostFocus()
If Txt_Dia_Pago.Enabled Then
    If CDbl(Txt_Dia_Pago.Text) > 31 Or CDbl(Txt_Dia_Pago.Text) = 0 And Me.txt_Mascara.Text <> "" Then
        MsgBox ("Día de pago mal ingresado"), vbInformation + vbOKOnly
        Txt_Dia_Pago.Text = "0"
    End If
    
End If
End Sub

Private Sub Txt_Familia_KeyPress(KeyAscii As Integer)
   PROC_TO_CASE KeyAscii
End Sub

Private Sub Txt_Instrumento_DblClick()
   Call PROC_LIMPIAR_PANTALLA
   Call PROC_CON_FAMILIA
End Sub

Private Sub Txt_Instrumento_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then
      Call PROC_CON_FAMILIA
   End If
End Sub

Private Sub Txt_Instrumento_KeyPress(KeyAscii As Integer)
   PROC_TO_CASE KeyAscii
   If KeyAscii = 13 Then
      txt_Mascara.SetFocus
   End If

End Sub

Private Sub Txt_Instrumento_LostFocus()
On Error GoTo Error_Familia

   If Trim(TXT_Instrumento.Text) = "" Then Exit Sub
    
   If Not FUNC_CON_FAMILIA(TXT_Instrumento.Text) Then
        MsgBox "Instrumento no existe", vbOKOnly + vbExclamation
        TXT_Familia.Text = ""
        TXT_Instrumento.Text = ""
        TXT_Instrumento.SetFocus
        Exit Sub
   End If
    
Exit Sub

Error_Familia:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
    Exit Sub


End Sub

Private Sub txt_Mascara_DblClick()
   Call PROC_CON_SERIES
End Sub

Private Sub txt_Mascara_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call PROC_CON_SERIES
End Sub

Private Sub txt_Mascara_KeyPress(KeyAscii As Integer)
    PROC_TO_CASE KeyAscii
    If KeyAscii = 39 Then
      KeyAscii = 0
    End If
    If KeyAscii = 13 Then
        ftbtera.SetFocus
    End If
End Sub


Sub PROC_CON_SERIES()
On Error GoTo Error_series

      If TXT_Instrumento.Text = "" Or cHay_Datos = "N" Then Exit Sub
         Pbl_cCodigo_Serie = TXT_Familia.Text
         cMiTag = "MDSE"
         FRM_AYUDA.Show 1
      If GLB_Aceptar% = True Then
         txt_Mascara.Enabled = True
         txt_Mascara.Text = GLB_codigo$
         txt_Mascara.Enabled = False
         TXT_Instrumento.Enabled = False
         Me.ftbtera.SetFocus
         Call PROC_BUSCAR_SERIES
      End If
Exit Sub
Error_series:
      MousePointer = 0
      MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
      Exit Sub
      
End Sub

Private Sub PROC_LLENA_DATOS()

   CMB_Base.AddItem "30"
   CMB_Base.AddItem "360"
   CMB_Base.AddItem "365"
   
   CMB_Moneda.Clear
   If FUNC_LLENA_MONEDA(CMB_Moneda, "", -1) Then
      CMB_Moneda.ListIndex = 0
   End If
   
   Call FUNC_CON_CMBAMORTIZA(Cmb_Amortiza, GLB_Sistema)
   Call FUNC_CON_TIPO_BONO(Me.Cmb_Tipo_Bono, GLB_Sistema)
   
   dtbfechaemision.Text = GLB_Fecha_Proceso
   dtbfechavcto.Text = GLB_Fecha_Proceso
   dtbprimercorte.Text = GLB_Fecha_Proceso
   Fecha_Colocacion.Text = GLB_Fecha_Proceso
   
End Sub



Private Sub txt_Mascara_LostFocus()
   If txt_Mascara.Text = Empty Then
      Exit Sub
   Else
      Call PROC_BUSCAR_SERIES
   End If
End Sub

Private Sub txt_Nombre_Emisor_KeyPress(KeyAscii As Integer)
   PROC_TO_CASE KeyAscii
End Sub

Private Sub txt_Rut_Emi_Change()

    TXT_Digito.Text = ""
    txt_Nombre_Emisor.Text = ""
           
End Sub

Private Sub txt_Rut_Emi_DblClick()
Call PROC_CON_EMISOR
End Sub



Sub PROC_CON_EMISOR()
   On Error GoTo Error_Emisores
    'Ayuda para Emisores
    '----------------------------------
    cMiTag = "MDEM"
    FRM_AYUDA.Show 1
    If GLB_Aceptar% = True Then
        txt_Rut_Emi.Text = GLB_rut$
        
        TXT_Digito.Text = GLB_Digito$
        txt_Nombre_Emisor.Text = GLB_Descripcion$
        dtbfechaemision.SetFocus
    End If
    Exit Sub
    
Error_Emisores:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
    Exit Sub
    
End Sub

Private Function FUNC_CALCULA_DIF_FECHAS(dFecha_Desde As Date, dFecha_Hasta As Date, cTipo As String)
Dim nDif_ano    As Double

If dFecha_Desde > dFecha_Hasta Then
    MsgBox ("Fecha Vencimiento no puede ser menor a Fecha de Emisión"), vbInformation
    dtbfechavcto.Text = GLB_Fecha_Proceso
    ftbplazo.Text = 0
    dtbfechavcto.SetFocus
    Exit Function
End If

nDif_ano = DateDiff(cTipo, dFecha_Desde, dFecha_Hasta)

ftbplazo.Text = (nDif_ano / 360)

End Function



Private Function FUNC_SUMA_FECHAS(dFecha_Desde As Date, nDias As Double)
Dim nSum_Dia    As Date

nSum_Dia = dFecha_Desde + (nDias * 365)

dtbfechavcto.Text = nSum_Dia

End Function
Function FUNC_CHEQUEA_DATOS()

   FUNC_CHEQUEA_DATOS = False

   Debug.Print CDbl(ftbtera.Text)
   Debug.Print Val(ftbtera.Text)

   If Val(TXT_Familia.Text) = 0 Then
       MsgBox ("Debe seleccionar un Instrumento"), vbInformation
       Exit Function
   ElseIf Me.txt_Mascara = "" Then
       MsgBox ("Debe seleccionar o ingresar una Mascara"), vbInformation
       Exit Function
   ElseIf CDbl(ftbtera.Text) = 0 Then
       MsgBox ("Valor Tera en cero"), vbInformation
       Exit Function
   ElseIf Me.CMB_Base.Text = "" Then
       MsgBox ("Debe ingresar Base"), vbInformation
       Exit Function
   ElseIf Me.CMB_Moneda.Text = "" Then
       MsgBox ("Debe ingresar Moneda"), vbInformation
       Exit Function
   ElseIf Me.CMB_Moneda.Text = "" Then
       MsgBox ("Debe ingresar Moneda"), vbInformation
       Exit Function
   ElseIf Me.Cmb_Tipo_Bono.Text = "" Then
       MsgBox ("Debe ingresar Tipo Bono"), vbInformation
       Exit Function
   ElseIf Me.CMB_Moneda.Text = "" Then
       MsgBox ("Debe ingresar Moneda"), vbInformation
       Exit Function
   ElseIf txt_Rut_Emi.Text = "" Or Me.txt_Nombre_Emisor = "" Or TXT_Digito = "" Then
       MsgBox ("Problemas con Emisor"), vbInformation
       Exit Function
   ElseIf Val(ftbplazo.Text) = 0 Then
       MsgBox ("Plazo en cero"), vbInformation
       Exit Function
   ElseIf CDbl(ftbtasaemision.Text) = 0 Then
       MsgBox ("Tasa emisión en cero"), vbInformation
       Exit Function
   ElseIf Val(Txt_Dia_Pago.Text) = 0 Then
       MsgBox ("Día de pago en cero"), vbInformation
       Exit Function
   ElseIf Val(itbNumAmortizacion.Text) = 0 Then
       MsgBox ("Número de Amortizaciones en Cero"), vbInformation
       Exit Function
   ElseIf Val(itbcupones.Text) = 0 Then
       MsgBox ("Número de cupones en Cero"), vbInformation
       Exit Function
   ElseIf Cmb_Amortiza.Text = "" Then
       MsgBox ("Debe Ingresar Periodo de Amortización"), vbInformation
       Exit Function
   ElseIf Cmb_Tipo_Bono.Text = "" Then
       MsgBox ("Debe Ingresar Periodo de Amortización"), vbInformation
       Exit Function
   ElseIf CDbl(Txt_Dia_Pago.Text) > 31 Or CDbl(Txt_Dia_Pago.Text) = 0 Then
       MsgBox ("Día de pago mal ingresado"), vbInformation
       Exit Function
   ElseIf CDbl(Valor_Nominal.Text) = 0 Then
       MsgBox ("Valor Nominal en Cero"), vbInformation
       Exit Function
   End If

   FUNC_CHEQUEA_DATOS = True
   
End Function
Private Sub PROC_GRABAR_SERIE()
On Error GoTo Error_graba_serie
Dim cSql   As String
Dim vDatos_Retorno()
Dim nValor_presente As Double
    
    nValor_presente = 0
  
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(TXT_Familia.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, txt_Mascara.Text
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(txt_Rut_Emi.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(ftbtasaemision.Text)   ' val(ftbtasaemision.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(CMB_Base.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(CMB_Moneda.ItemData(CMB_Moneda.ListIndex))
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(ftbtera.Text)          ' Val(ftbtera.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(Cmb_Amortiza.ItemData(Cmb_Amortiza.ListIndex))
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(itbNumAmortizacion.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(ftbplazo.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(Txt_Dia_Pago.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(itbcupones.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(dtbfechavcto.Text, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(dtbfechaemision.Text, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, IIf(CHK_Bono.Value = 1, "S", "N")
    PROC_AGREGA_PARAMETRO GLB_Envia, IIf(CHK_tasa_variable.Value = 1, "S", "N")
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(dtbprimercorte.Text, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(itbNumDecimales.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Valor_Nominal.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Colocacion.Text, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(TxtClasificadora_de_Riesgo1.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, TxtClasificacion_de_Riesgo1.Text
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(TxtClasificadora_de_Riesgo2.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, TxtClasificacion_de_Riesgo2.Text
'''''PROC_AGREGA_PARAMETRO GLB_Envia, TxtNumero_de_inscripcion.Text
   PROC_AGREGA_PARAMETRO GLB_Envia, TxtNumero_de_inscripcion.Text + "-" '''' se agrega guion debio a problemas en sql_Execute que convierte a fecha




    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Gastos_Colocacion.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, nValor_presente
    PROC_AGREGA_PARAMETRO GLB_Envia, Trim(Me.Cmb_Tipo_Bono.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(FTB_VALOR_ESTIMADO1.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(FTB_VALOR_ESTIMADO2.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(FTB_VALOR_ESTIMADO3.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(FTB_VALOR_ESTIMADO4.Text)
    
    Screen.MousePointer = 11
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_ACT_SERIE_PASIVO", GLB_Envia) Then
             Screen.MousePointer = 0
         MsgBox ("Problemas al grabar serie"), vbCritical
         Exit Sub
    Else
        MsgBox ("Serie graba correctamente"), vbInformation
        Call PROC_LOG_AUDITORIA("01", GLB_cOptLocal, Me.Caption & " Serie graba correctamente " & txt_Mascara, "", "")
        Screen.MousePointer = 0
        Call PROC_LIMPIAR_PANTALLA
    End If

Exit Sub
Error_graba_serie:
    
    Screen.MousePointer = 0
    MsgBox ("Problemas al grabar serie"), vbCritical
    Call PROC_LOG_AUDITORIA("01", GLB_cOptLocal, Me.Caption & " Problemas al grabar serie" & txt_Mascara, "", "")
End Sub
Private Sub txt_Rut_Emi_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim Datos()
   
   If KeyCode = vbKeyF3 Then Call PROC_CON_EMISOR
   
   If KeyCode = vbKeyReturn Then
      GLB_Envia = Array()
      PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(txt_Rut_Emi.Text)
      PROC_AGREGA_PARAMETRO GLB_Envia, 0
      If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_EMISORES", GLB_Envia()) Then
         Exit Sub
      End If
      If FUNC_LEE_RETORNO_SQL(Datos()) Then
         txt_Nombre_Emisor.Text = Datos(4)
         Me.TXT_Digito.Text = Datos(3)
      End If
   End If
End Sub
Private Sub PROC_BUSCAR_SERIES()
On Error GoTo Error_buscar_serie

Dim cSql   As String
Dim vDatos_Retorno()
Dim nMoneda As Integer
Dim nAmortiza As Integer
Dim sTipo_Bono As String

If Me.txt_Mascara.Text = "" Or Me.TXT_Familia.Text = "" Then
    MsgBox ("Debe ingresar Instrumento y Máscara para realizar búsqueda"), vbInformation
    TXT_Instrumento.SetFocus
    Exit Sub
End If

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(TXT_Familia.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, txt_Mascara.Text
    
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_SERIES", GLB_Envia) Then
         Screen.MousePointer = 0
         MsgBox ("Problemas al realizar búsqueda"), vbCritical
         Call PROC_LOG_AUDITORIA("01", GLB_cOptLocal, Me.Caption & " No se pudo completar la grabación ", "", "")
         Call PROC_LIMPIAR_PANTALLA
         Exit Sub
    Else
    
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            
            txt_Rut_Emi.Text = vDatos_Retorno(3)
            ftbtasaemision.Text = vDatos_Retorno(4)
            CMB_Base.Text = vDatos_Retorno(5)
            nMoneda = vDatos_Retorno(6)
            ftbtera.Text = vDatos_Retorno(7)
            nAmortiza = vDatos_Retorno(8)
            itbNumAmortizacion.Text = vDatos_Retorno(9)
            ftbplazo.Text = vDatos_Retorno(10)
            Txt_Dia_Pago.Text = vDatos_Retorno(11)
            itbcupones.Text = vDatos_Retorno(12)
            dtbfechavcto.Text = vDatos_Retorno(13)
            dtbfechaemision.Text = vDatos_Retorno(14)
            CHK_Bono.Value = IIf(vDatos_Retorno(15) = "S", 1, 0)
            CHK_tasa_variable.Value = IIf(vDatos_Retorno(16) = "S", 1, 0)
            dtbprimercorte.Text = vDatos_Retorno(17)
            itbNumDecimales.Text = vDatos_Retorno(18)
            Valor_Nominal.Text = vDatos_Retorno(24)
            Fecha_Colocacion.Text = vDatos_Retorno(25)
            TxtClasificadora_de_Riesgo1.Text = vDatos_Retorno(26)
            TxtClasificacion_de_Riesgo1.Text = vDatos_Retorno(27)
            TxtClasificadora_de_Riesgo2.Text = vDatos_Retorno(28)
            TxtClasificacion_de_Riesgo2.Text = vDatos_Retorno(29)
            '''''TxtNumero_de_inscripcion.Text = vDatos_Retorno(30)
            '''''''' se quita guion debido a problemas en sql_Execute que convierte a fecha
           TxtNumero_de_inscripcion.Text = IIf(right(vDatos_Retorno(30), 1) = "-", left(vDatos_Retorno(30), Len(vDatos_Retorno(30)) - 1), vDatos_Retorno(30))
                        
            Gastos_Colocacion.Text = vDatos_Retorno(31)
            sTipo_Bono = vDatos_Retorno(33)
            FTB_VALOR_ESTIMADO1.Text = vDatos_Retorno(34)
            FTB_VALOR_ESTIMADO2.Text = vDatos_Retorno(35)
            FTB_VALOR_ESTIMADO3.Text = vDatos_Retorno(36)
            FTB_VALOR_ESTIMADO4.Text = vDatos_Retorno(37)
            
            Barra_Menu.Buttons(2).Enabled = True
            Barra_Menu.Buttons(3).Enabled = True
            Barra_Menu.Buttons(5).Enabled = True
            Barra_Menu.Buttons(6).Enabled = True
            Barra_Menu.Buttons(7).Enabled = True
            txt_Mascara.Enabled = False
            For I% = 0 To CMB_Moneda.ListCount - 1
                If nMoneda = CMB_Moneda.ItemData(I%) Then
                   CMB_Moneda.ListIndex = I%
                   Exit For
                End If
            Next I%
            
            For I% = 0 To Cmb_Amortiza.ListCount - 1
                If nAmortiza = Cmb_Amortiza.ItemData(I%) Then
                   Cmb_Amortiza.ListIndex = I%
                   Exit For
                End If
            Next I%
            
            For I% = 0 To Cmb_Tipo_Bono.ListCount - 1
                If Trim(sTipo_Bono) = Trim(Cmb_Tipo_Bono.List(I%)) Then
                   Cmb_Tipo_Bono.ListIndex = I%
                   Exit For
                End If
            Next I%
            
            Call FUNC_CON_EMISOR(txt_Rut_Emi.Text)
            
'        Else
'            MsgBox ("Serie no encontrada"), vbInformation
'               Call PROC_LIMPIAR_PANTALLA

        End If
    End If
    Exit Sub
    
Error_buscar_serie:
        MsgBox ("Problemas en búsqueda"), vbInformation
End Sub
Private Sub txt_Rut_Emi_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        dtbfechaemision.SetFocus
    End If
End Sub
Private Sub PROC_ELIMINAR_SERIES()
On Error GoTo Error_elim_serie

Dim cSql   As String
Dim vDatos_Retorno()

If Me.txt_Mascara.Text = "" Or Me.TXT_Familia.Text = "" Then
    MsgBox ("Debe ingresar Instrumento y Máscara a eliminar"), vbInformation
    Exit Sub
End If

If MsgBox("¿Esta Seguro de Eliminar la Serie Encontrada?", vbQuestion + vbYesNo) = vbNo Then
    Exit Sub
End If

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(TXT_Familia.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, txt_Mascara.Text
    
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_ACT_ELIMINA_SERIES", GLB_Envia) Then
        Screen.MousePointer = 0
        MsgBox ("Problemas al realizar eliminación"), vbCritical
        Call PROC_LOG_AUDITORIA("01", GLB_cOptLocal, Me.Caption & " Problemas al realizar eliminación de series " & txt_Mascara, "", "")
        Call PROC_LIMPIAR_PANTALLA
        Exit Sub
    Else
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            If Val(vDatos_Retorno(1)) = 1 Then
                MsgBox ("Serie se encuentra relacionada, no puede eliminar"), vbInformation
                Call PROC_LOG_AUDITORIA("01", GLB_cOptLocal, Me.Caption & " Serie se encuentra relacionada, no puede eliminar " & txt_Mascara, "", "")
            Else
                MsgBox ("Serie fue eliminada correctamente"), vbInformation
                Call PROC_LOG_AUDITORIA("01", GLB_cOptLocal, Me.Caption & " Serie fue eliminada correctamente " & txt_Mascara, "", "")
            End If
        End If
        Call PROC_LIMPIAR_PANTALLA
    End If
    
    Exit Sub
    
Error_elim_serie:

End Sub


Private Function FUNC_CON_EMISOR(Rut_Emisor As String)
Dim vDatos_Retorno()
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(Rut_Emisor)
        
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_EMISORES", GLB_Envia) Then
        Screen.MousePointer = 0
        MsgBox ("Problemas al buscar Emisor"), vbCritical
        Call PROC_LIMPIAR_PANTALLA
        Exit Function
    Else
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            txt_Nombre_Emisor.Text = vDatos_Retorno(4)
            TXT_Digito.Text = vDatos_Retorno(3)
        End If
    End If

End Function

Private Sub TXT_Total_Emitido_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    Me.itbNumAmortizacion.SetFocus
End If
End Sub





Private Function FUNC_IMPRIME_TDESARROLLO(nTipo As Integer)
Dim cTituloRpt As String

On Error GoTo ErrImpresion:

    If nTipo = 1 Then
        FRM_MDI_PASIVO.Pasivo_Rpt.Destination = crptToPrinter
    Else
        FRM_MDI_PASIVO.Pasivo_Rpt.Destination = crptToWindow
    End If

    Call PROC_LIMPIAR_CRISTAL
     
             
   FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Tabla de desarrollo."
   FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_TABLA_DESARROLLO.rpt"
   PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
   FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = TXT_Familia.Text
   FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = txt_Mascara.Text
   FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
   FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
   FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
    
    Call PROC_LOG_AUDITORIA("10", GLB_cOptLocal, Me.Caption & " Informe tabla de desarrollo " & txt_Mascara, "", "")

    Exit Function
    
ErrImpresion:
    Call PROC_LOG_AUDITORIA("10", GLB_cOptLocal, Me.Caption & " Error al emitir reporte " & cTituloRpt, "", "")
    MsgBox "Problemas al emitir reporte " & Err.Description & ", " & Err.Number, vbCritical
    Screen.MousePointer = 0

End Function

