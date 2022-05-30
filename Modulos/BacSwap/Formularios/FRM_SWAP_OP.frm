VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_SWAP_OP 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ingreso de Operaciones Swap."
   ClientHeight    =   9900
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10950
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   9900
   ScaleWidth      =   10950
   Begin VB.Frame Frame8 
      Caption         =   "Inter. Noc. Inicial"
      Height          =   465
      Left            =   7320
      TabIndex        =   161
      Top             =   1260
      Width           =   1750
      Begin VB.OptionButton InterNocIni 
         Caption         =   "No"
         Height          =   195
         Index           =   1
         Left            =   810
         TabIndex        =   163
         Top             =   210
         Value           =   -1  'True
         Width           =   585
      End
      Begin VB.OptionButton InterNocIni 
         Caption         =   "Si"
         Height          =   240
         Index           =   0
         Left            =   150
         TabIndex        =   162
         Top             =   195
         Width           =   495
      End
   End
   Begin VB.Frame Frame7 
      Caption         =   "Inter. Noc. Final"
      Height          =   465
      Left            =   9120
      TabIndex        =   158
      Top             =   1260
      Width           =   1750
      Begin VB.OptionButton InterNocFin 
         Caption         =   "No"
         Height          =   210
         Index           =   1
         Left            =   795
         TabIndex        =   160
         Top             =   225
         Width           =   600
      End
      Begin VB.OptionButton InterNocFin 
         Caption         =   "Si"
         Height          =   210
         Index           =   0
         Left            =   150
         TabIndex        =   159
         Top             =   225
         Value           =   -1  'True
         Width           =   600
      End
   End
   Begin VB.CheckBox chk_intramesa 
      Caption         =   "Ticket Intramesa"
      Height          =   240
      Left            =   5430
      TabIndex        =   153
      Top             =   1290
      Width           =   1935
   End
   Begin VB.CommandButton CmdCalculaFixing 
      Caption         =   "Calc. Fixing"
      Height          =   255
      Left            =   7710
      TabIndex        =   47
      Top             =   945
      Width           =   1515
   End
   Begin VB.Frame Frame4 
      Caption         =   "Fixing"
      Height          =   735
      Left            =   7515
      TabIndex        =   131
      Top             =   510
      Width           =   1830
      Begin VB.OptionButton Option2 
         Caption         =   "Fin"
         Height          =   270
         Index           =   1
         Left            =   990
         TabIndex        =   46
         Top             =   210
         Width           =   645
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Ini."
         Height          =   270
         Index           =   0
         Left            =   315
         TabIndex        =   45
         Top             =   195
         Value           =   -1  'True
         Width           =   645
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Guardar Como"
      Height          =   735
      Left            =   5445
      TabIndex        =   129
      Top             =   510
      Width           =   1995
      Begin VB.OptionButton Option1 
         Caption         =   "Cotiz."
         CausesValidation=   0   'False
         Height          =   195
         Index           =   0
         Left            =   90
         TabIndex        =   43
         Top             =   315
         Width           =   810
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Cartera"
         CausesValidation=   0   'False
         Height          =   195
         Index           =   1
         Left            =   990
         TabIndex        =   44
         Top             =   315
         Value           =   -1  'True
         Width           =   960
      End
   End
   Begin VB.ComboBox NumDecTasa 
      Height          =   315
      ItemData        =   "FRM_SWAP_OP.frx":0000
      Left            =   10230
      List            =   "FRM_SWAP_OP.frx":0013
      Style           =   2  'Dropdown List
      TabIndex        =   49
      Top             =   855
      Width           =   615
   End
   Begin VB.ComboBox NunDecimales 
      Height          =   315
      ItemData        =   "FRM_SWAP_OP.frx":0026
      Left            =   10230
      List            =   "FRM_SWAP_OP.frx":0048
      Style           =   2  'Dropdown List
      TabIndex        =   48
      Top             =   540
      Width           =   615
   End
   Begin VB.ComboBox Modalidad 
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
      Left            =   1470
      Style           =   2  'Dropdown List
      TabIndex        =   121
      Top             =   975
      Width           =   2505
   End
   Begin VB.TextBox TIKKER 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   735
      TabIndex        =   120
      Top             =   585
      Width           =   4635
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   51
      Top             =   0
      Width           =   10950
      _ExtentX        =   19315
      _ExtentY        =   900
      ButtonWidth     =   3149
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      HotImageList    =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Limpiar  "
            Key             =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Flujos  "
            Key             =   "Flujos"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "&Grabar  "
            Key             =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Generar Excel  "
            Key             =   "Generar"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Cargar Excel  "
            Key             =   "Cargar"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Cerrar  "
            Key             =   "Cerrar"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   8565
         Top             =   15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   7
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_SWAP_OP.frx":006A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_SWAP_OP.frx":0F44
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_SWAP_OP.frx":1E1E
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_SWAP_OP.frx":2CF8
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_SWAP_OP.frx":3012
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_SWAP_OP.frx":332C
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_SWAP_OP.frx":4206
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4755
      Left            =   0
      TabIndex        =   52
      Top             =   1680
      Width           =   5430
      Begin VB.ComboBox I_ReferenciaMEXUSD 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         ItemData        =   "FRM_SWAP_OP.frx":50E0
         Left            =   2760
         List            =   "FRM_SWAP_OP.frx":50E2
         Style           =   2  'Dropdown List
         TabIndex        =   167
         Top             =   3960
         Width           =   2520
      End
      Begin VB.ComboBox I_ReferenciaUSDCLP 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         ItemData        =   "FRM_SWAP_OP.frx":50E4
         Left            =   120
         List            =   "FRM_SWAP_OP.frx":50E6
         Style           =   2  'Dropdown List
         TabIndex        =   157
         Top             =   3960
         Width           =   2520
      End
      Begin VB.CheckBox I_HabilitaFecha 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   1
         Left            =   2775
         TabIndex        =   14
         Top             =   2910
         Width           =   225
      End
      Begin VB.CheckBox I_HabilitaFecha 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   0
         Left            =   1320
         TabIndex        =   12
         Top             =   2910
         Value           =   1  'Checked
         Visible         =   0   'False
         Width           =   225
      End
      Begin VB.ComboBox I_MedioPago 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   2715
         Style           =   2  'Dropdown List
         TabIndex        =   18
         Top             =   3375
         Width           =   2565
      End
      Begin VB.ComboBox I_MonPago 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         ItemData        =   "FRM_SWAP_OP.frx":50E8
         Left            =   120
         List            =   "FRM_SWAP_OP.frx":50EA
         Style           =   2  'Dropdown List
         TabIndex        =   17
         Top             =   3375
         Width           =   2520
      End
      Begin VB.ComboBox I_ConteoDias 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   150
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   2265
         Width           =   2385
      End
      Begin VB.ComboBox I_Indicador 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   150
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   1755
         Width           =   2385
      End
      Begin VB.ComboBox I_FrecuenciaCapital 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   2610
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   1230
         Width           =   2385
      End
      Begin VB.ComboBox I_FrecuenciaPago 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   150
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1230
         Width           =   2385
      End
      Begin VB.ComboBox I_Moneda 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1560
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   375
         Width           =   2685
      End
      Begin VB.CheckBox ChkAplizaOnLine 
         Alignment       =   1  'Right Justify
         Caption         =   "   Aplicar al Lado Contrario"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   0
         Left            =   2820
         TabIndex        =   56
         Top             =   120
         Width           =   2535
      End
      Begin BACControles.TXTNumero I_ValorMoneda 
         Height          =   330
         Left            =   4275
         TabIndex        =   1
         Top             =   375
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-9999"
         Max             =   "9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero I_Nocionales 
         Height          =   330
         Left            =   1575
         TabIndex        =   2
         Top             =   705
         Width           =   2130
         _ExtentX        =   3757
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "100,000,000,000.0000"
         Text            =   "100,000,000,000.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTFecha I_FechaEfectiva 
         Height          =   285
         Left            =   135
         TabIndex        =   11
         Top             =   2850
         Width           =   1155
         _ExtentX        =   2037
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "07/09/2006"
      End
      Begin BACControles.TXTFecha I_Madurez 
         Height          =   285
         Left            =   4200
         TabIndex        =   16
         Top             =   2850
         Width           =   1170
         _ExtentX        =   2064
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "07/09/2006"
      End
      Begin BACControles.TXTFecha I_PrimerPago 
         Height          =   285
         Left            =   1545
         TabIndex        =   13
         Top             =   2850
         Width           =   1170
         _ExtentX        =   2064
         _ExtentY        =   503
         BackColor       =   16777215
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "07/09/2006"
      End
      Begin BACControles.TXTFecha I_PenultimoPago 
         Height          =   285
         Left            =   3000
         TabIndex        =   15
         Top             =   2850
         Width           =   1170
         _ExtentX        =   2064
         _ExtentY        =   503
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "07/09/2006"
      End
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   4755
         Top             =   675
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   16
         ImageHeight     =   16
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   1
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_SWAP_OP.frx":50EC
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.Toolbar ToolIzqDer 
         Height          =   330
         Left            =   5025
         TabIndex        =   19
         Top             =   4320
         Width           =   345
         _ExtentX        =   609
         _ExtentY        =   582
         ButtonWidth     =   1138
         ButtonHeight    =   582
         AllowCustomize  =   0   'False
         Style           =   1
         TextAlignment   =   1
         ImageList       =   "ImageList2"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   1
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               ImageIndex      =   1
            EndProperty
         EndProperty
      End
      Begin VB.Frame Frame5 
         Height          =   1185
         Left            =   2550
         TabIndex        =   134
         Top             =   1545
         Width           =   2820
         Begin BACControles.TXTNumero I_UltimoIndice 
            Height          =   330
            Left            =   90
            TabIndex        =   6
            Top             =   285
            Width           =   1140
            _ExtentX        =   2011
            _ExtentY        =   582
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0.00000"
            Text            =   "0.00000"
            Min             =   "0"
            Max             =   "100"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero I_Spread 
            Height          =   330
            Left            =   1425
            TabIndex        =   7
            Top             =   285
            Visible         =   0   'False
            Width           =   1140
            _ExtentX        =   2011
            _ExtentY        =   582
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0.00000"
            Text            =   "0.00000"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero I_Indice_Tran 
            Height          =   330
            Left            =   90
            TabIndex        =   8
            Top             =   795
            Width           =   1140
            _ExtentX        =   2011
            _ExtentY        =   582
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0.00000"
            Text            =   "0.00000"
            Min             =   "0"
            Max             =   "100"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero I_Spread_Tran 
            Height          =   330
            Left            =   1425
            TabIndex        =   9
            Top             =   795
            Visible         =   0   'False
            Width           =   1140
            _ExtentX        =   2011
            _ExtentY        =   582
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0.00000"
            Text            =   "0.00000"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label I_Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Indice Transfer."
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
            Index           =   29
            Left            =   45
            TabIndex        =   143
            Top             =   600
            Width           =   1305
         End
         Begin VB.Label I_Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Spread Transfer."
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
            Index           =   28
            Left            =   1395
            TabIndex        =   142
            Top             =   600
            Visible         =   0   'False
            Width           =   1395
         End
         Begin VB.Label I_Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Ultimo Indice"
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
            Index           =   4
            Left            =   105
            TabIndex        =   136
            Top             =   105
            Width           =   1065
         End
         Begin VB.Label I_Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Spread"
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
            Index           =   5
            Left            =   1395
            TabIndex        =   135
            Top             =   105
            Visible         =   0   'False
            Width           =   585
         End
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Ref. Mx/USD"
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
         Index           =   33
         Left            =   2760
         TabIndex        =   168
         Top             =   3720
         Width           =   960
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Ref. USD/CLP"
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
         Index           =   32
         Left            =   120
         TabIndex        =   169
         Top             =   3720
         Width           =   1050
      End
      Begin VB.Label I_Generacion 
         AutoSize        =   -1  'True
         Caption         =   "Generación Normal"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   195
         Left            =   135
         TabIndex        =   107
         Top             =   4440
         Width           =   1350
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Traspaso Datos"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   3840
         TabIndex        =   84
         Top             =   4440
         Width           =   1125
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Medio de Pago"
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
         Index           =   25
         Left            =   2730
         TabIndex        =   81
         Top             =   3180
         Width           =   1215
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Moneda Pago"
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
         Index           =   24
         Left            =   150
         TabIndex        =   80
         Top             =   3180
         Width           =   1110
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Penultimo Pago"
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
         Index           =   18
         Left            =   2850
         TabIndex        =   75
         Top             =   2670
         Width           =   1290
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Primer Pago"
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
         Index           =   19
         Left            =   1560
         TabIndex        =   74
         Top             =   2670
         Width           =   1020
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Efectiva"
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
         Index           =   7
         Left            =   150
         TabIndex        =   73
         Top             =   2670
         Width           =   1155
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Madurez"
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
         Index           =   8
         Left            =   4230
         TabIndex        =   72
         Top             =   2670
         Width           =   720
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Conteo de Días"
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
         Index           =   6
         Left            =   150
         TabIndex        =   70
         Top             =   2070
         Width           =   1245
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Indicador"
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
         Left            =   165
         TabIndex        =   68
         Top             =   1560
         Width           =   765
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Frecuencia Capital"
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
         Index           =   22
         Left            =   2625
         TabIndex        =   65
         Top             =   1035
         Width           =   1500
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Frecuencia Pago"
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
         Left            =   165
         TabIndex        =   64
         Top             =   1035
         Width           =   1350
      End
      Begin VB.Label I_NemMon 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "USD"
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
         Left            =   1020
         TabIndex        =   61
         Top             =   705
         Width           =   525
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Nocionales"
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
         Index           =   1
         Left            =   60
         TabIndex        =   60
         Top             =   750
         Width           =   900
      End
      Begin VB.Label I_Etiquetas 
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
         Height          =   210
         Index           =   0
         Left            =   60
         TabIndex        =   58
         Top             =   420
         Width           =   660
      End
      Begin VB.Label I_Identificador 
         AutoSize        =   -1  'True
         Caption         =   "PARTE ..."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   60
         TabIndex        =   54
         Top             =   120
         Width           =   720
      End
   End
   Begin VB.Frame Frame2 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4755
      Left            =   5445
      TabIndex        =   53
      Top             =   1680
      Width           =   5430
      Begin VB.ComboBox D_ReferenciaMEXUSD 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   2685
         Style           =   2  'Dropdown List
         TabIndex        =   164
         Top             =   3960
         Width           =   2520
      End
      Begin VB.ComboBox D_ReferenciaUSDCLP 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   170
         Top             =   3960
         Width           =   2520
      End
      Begin VB.CheckBox D_HabilitaFecha 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   1
         Left            =   2775
         TabIndex        =   34
         Top             =   2910
         Width           =   225
      End
      Begin VB.CheckBox D_HabilitaFecha 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   0
         Left            =   1305
         TabIndex        =   32
         Top             =   2910
         Value           =   1  'Checked
         Visible         =   0   'False
         Width           =   225
      End
      Begin VB.ComboBox D_MedioPago 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   2685
         Style           =   2  'Dropdown List
         TabIndex        =   38
         Top             =   3375
         Width           =   2535
      End
      Begin VB.ComboBox D_MonPago 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   37
         Top             =   3375
         Width           =   2520
      End
      Begin VB.ComboBox D_ConteoDias 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   150
         Style           =   2  'Dropdown List
         TabIndex        =   30
         Top             =   2355
         Width           =   2385
      End
      Begin VB.ComboBox D_Indicador 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   150
         Style           =   2  'Dropdown List
         TabIndex        =   25
         Top             =   1755
         Width           =   2385
      End
      Begin VB.ComboBox D_FrecuenciaCapital 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   2625
         Style           =   2  'Dropdown List
         TabIndex        =   24
         Top             =   1230
         Width           =   2385
      End
      Begin VB.ComboBox D_FrecuenciaPago 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   150
         Style           =   2  'Dropdown List
         TabIndex        =   23
         Top             =   1230
         Width           =   2385
      End
      Begin VB.ComboBox D_Moneda 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1605
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   360
         Width           =   2685
      End
      Begin VB.CheckBox ChkAplizaOnLine 
         Alignment       =   1  'Right Justify
         Caption         =   "   Aplicar al Lado Contrario"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   1
         Left            =   2745
         TabIndex        =   57
         Top             =   120
         Width           =   2625
      End
      Begin BACControles.TXTNumero D_ValorMoneda 
         Height          =   330
         Left            =   4290
         TabIndex        =   21
         Top             =   360
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-9999"
         Max             =   "9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero D_Nocionales 
         Height          =   330
         Left            =   1605
         TabIndex        =   22
         Top             =   705
         Width           =   2100
         _ExtentX        =   3704
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "100,000,000,000.0000"
         Text            =   "100,000,000,000.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTFecha D_FechaEfectiva 
         Height          =   285
         Left            =   135
         TabIndex        =   31
         Top             =   2850
         Width           =   1155
         _ExtentX        =   2037
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "07/09/2006"
      End
      Begin BACControles.TXTFecha D_Madurez 
         Height          =   285
         Left            =   4215
         TabIndex        =   36
         Top             =   2850
         Width           =   1155
         _ExtentX        =   2037
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "07/09/2006"
      End
      Begin BACControles.TXTFecha D_PrimerPago 
         Height          =   285
         Left            =   1545
         TabIndex        =   33
         Top             =   2850
         Width           =   1155
         _ExtentX        =   2037
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "07/09/2006"
      End
      Begin BACControles.TXTFecha D_PenultimoPago 
         Height          =   285
         Left            =   3000
         TabIndex        =   35
         Top             =   2850
         Width           =   1170
         _ExtentX        =   2064
         _ExtentY        =   503
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "07/09/2006"
      End
      Begin MSComctlLib.ImageList ImageList3 
         Left            =   4410
         Top             =   675
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   16
         ImageHeight     =   16
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_SWAP_OP.frx":553E
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_SWAP_OP.frx":5990
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.Toolbar ToolDerIzq 
         Height          =   330
         Left            =   60
         TabIndex        =   39
         Tag             =   "3900"
         Top             =   4320
         Width           =   375
         _ExtentX        =   661
         _ExtentY        =   582
         ButtonWidth     =   1138
         ButtonHeight    =   582
         AllowCustomize  =   0   'False
         Style           =   1
         TextAlignment   =   1
         ImageList       =   "ImageList3"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   1
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               ImageIndex      =   2
            EndProperty
         EndProperty
      End
      Begin VB.Frame Frame6 
         Height          =   1185
         Left            =   2550
         TabIndex        =   137
         Top             =   1515
         Width           =   2820
         Begin BACControles.TXTNumero D_Indice_Tran 
            Height          =   330
            Left            =   105
            TabIndex        =   28
            Top             =   795
            Width           =   1140
            _ExtentX        =   2011
            _ExtentY        =   582
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0.00000"
            Text            =   "0.00000"
            Min             =   "0"
            Max             =   "100"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero D_Spread_Tran 
            Height          =   330
            Left            =   1425
            TabIndex        =   29
            Top             =   795
            Visible         =   0   'False
            Width           =   1140
            _ExtentX        =   2011
            _ExtentY        =   582
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0.00000"
            Text            =   "0.00000"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero D_UltimoIndice 
            Height          =   330
            Left            =   75
            TabIndex        =   26
            Top             =   285
            Width           =   1140
            _ExtentX        =   2011
            _ExtentY        =   582
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0.00000"
            Text            =   "0.00000"
            Min             =   "0"
            Max             =   "100"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero D_Spread 
            Height          =   330
            Left            =   1425
            TabIndex        =   27
            Top             =   285
            Visible         =   0   'False
            Width           =   1140
            _ExtentX        =   2011
            _ExtentY        =   582
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0.00000"
            Text            =   "0.00000"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label I_Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Ultimo Indice"
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
            Index           =   13
            Left            =   45
            TabIndex        =   141
            Top             =   105
            Width           =   1065
         End
         Begin VB.Label I_Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Spread"
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
            Index           =   12
            Left            =   1380
            TabIndex        =   140
            Top             =   105
            Visible         =   0   'False
            Width           =   585
         End
         Begin VB.Label I_Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Spread Transfer."
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
            Index           =   31
            Left            =   1380
            TabIndex        =   139
            Top             =   600
            Visible         =   0   'False
            Width           =   1395
         End
         Begin VB.Label I_Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Indice Transfer."
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
            Index           =   30
            Left            =   45
            TabIndex        =   138
            Top             =   600
            Width           =   1305
         End
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Ref. Mx/USD"
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
         Index           =   35
         Left            =   2760
         TabIndex        =   171
         Top             =   3720
         Width           =   960
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Ref. USD/CLP"
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
         Index           =   34
         Left            =   120
         TabIndex        =   172
         Top             =   3720
         Width           =   1050
      End
      Begin VB.Label D_Generacion 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         Caption         =   "Generación Normal"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   195
         Left            =   3960
         TabIndex        =   108
         Top             =   4440
         Width           =   1350
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Traspaso Datos"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   510
         TabIndex        =   50
         Top             =   4440
         Width           =   1125
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Medio de Pago"
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
         Index           =   27
         Left            =   2700
         TabIndex        =   83
         Top             =   3180
         Width           =   1215
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Moneda Pago"
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
         Index           =   26
         Left            =   135
         TabIndex        =   82
         Top             =   3180
         Width           =   1110
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Primer Pago"
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
         Index           =   20
         Left            =   1515
         TabIndex        =   79
         Top             =   2670
         Width           =   1020
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Penultimo Pago"
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
         Index           =   21
         Left            =   2865
         TabIndex        =   78
         Top             =   2670
         Width           =   1290
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Madurez"
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
         Index           =   10
         Left            =   4215
         TabIndex        =   77
         Top             =   2670
         Width           =   720
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Efectiva"
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
         Index           =   11
         Left            =   150
         TabIndex        =   76
         Top             =   2670
         Width           =   1155
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Conteo de Días"
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
         Index           =   9
         Left            =   150
         TabIndex        =   71
         Top             =   2130
         Width           =   1245
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Indicador"
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
         Index           =   14
         Left            =   150
         TabIndex        =   69
         Top             =   1575
         Width           =   765
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Frecuencia Capital"
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
         Index           =   23
         Left            =   2640
         TabIndex        =   67
         Top             =   1035
         Width           =   1500
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Frecuencia Pago"
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
         Index           =   15
         Left            =   150
         TabIndex        =   66
         Top             =   1035
         Width           =   1350
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Nocionales"
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
         Index           =   16
         Left            =   60
         TabIndex        =   63
         Top             =   765
         Width           =   900
      End
      Begin VB.Label D_NemMon 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "USD"
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
         Left            =   1050
         TabIndex        =   62
         Top             =   705
         Width           =   525
      End
      Begin VB.Label I_Etiquetas 
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
         Height          =   210
         Index           =   17
         Left            =   60
         TabIndex        =   59
         Top             =   420
         Width           =   660
      End
      Begin VB.Label D_Identificador 
         AutoSize        =   -1  'True
         Caption         =   "PARTE ..."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   45
         TabIndex        =   55
         Top             =   120
         Width           =   720
      End
   End
   Begin TabDlg.SSTab SSFlujos 
      Height          =   3420
      Left            =   0
      TabIndex        =   40
      Top             =   6435
      Width           =   10905
      _ExtentX        =   19235
      _ExtentY        =   6033
      _Version        =   393216
      Style           =   1
      TabHeight       =   520
      WordWrap        =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "DETALLE PARTE ..."
      TabPicture(0)   =   "FRM_SWAP_OP.frx":5DE2
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Label9(0)"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "GridTitulos"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "SSPanel2"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "I_Note"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "cd"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).ControlCount=   5
      TabCaption(1)   =   "DETALLE PARTE ...."
      TabPicture(1)   =   "FRM_SWAP_OP.frx":5DFE
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Label9(1)"
      Tab(1).Control(1)=   "SSPanel3"
      Tab(1).Control(2)=   "D_Note"
      Tab(1).ControlCount=   3
      TabCaption(2)   =   "Resultado Margen de Transferencia"
      TabPicture(2)   =   "FRM_SWAP_OP.frx":5E1A
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "SSPanel1"
      Tab(2).ControlCount=   1
      Begin Threed.SSPanel SSPanel1 
         Height          =   2925
         Left            =   -74985
         TabIndex        =   146
         Top             =   315
         Width           =   10800
         _Version        =   65536
         _ExtentX        =   19050
         _ExtentY        =   5159
         _StockProps     =   15
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         Begin Threed.SSPanel ssp_AvrOpe 
            Height          =   330
            Left            =   4875
            TabIndex        =   148
            Top             =   525
            Width           =   2775
            _Version        =   65536
            _ExtentX        =   4895
            _ExtentY        =   582
            _StockProps     =   15
            ForeColor       =   -2147483640
            BackColor       =   -2147483643
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelWidth      =   2
            BevelOuter      =   1
            Alignment       =   4
         End
         Begin Threed.SSPanel ssp_AvrTran 
            Height          =   330
            Left            =   4875
            TabIndex        =   150
            Top             =   990
            Width           =   2775
            _Version        =   65536
            _ExtentX        =   4895
            _ExtentY        =   582
            _StockProps     =   15
            ForeColor       =   -2147483640
            BackColor       =   -2147483643
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelWidth      =   2
            BevelOuter      =   1
            Alignment       =   4
         End
         Begin BACControles.TXTNumero txt_Res_Mesa_Dist 
            Height          =   330
            Left            =   4860
            TabIndex        =   155
            Top             =   1410
            Width           =   2775
            _ExtentX        =   4895
            _ExtentY        =   582
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
            Text            =   "0.00"
            Text            =   "0.00"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero txt_Res_Mesa_Dist_USD 
            Height          =   330
            Left            =   4860
            TabIndex        =   156
            Top             =   1845
            Width           =   2775
            _ExtentX        =   4895
            _ExtentY        =   582
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
            Text            =   "0.00"
            Text            =   "0.00"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Lblcheck 
            Caption         =   "Lblcheck"
            Height          =   285
            Left            =   8340
            TabIndex        =   173
            Top             =   600
            Visible         =   0   'False
            Width           =   1305
         End
         Begin VB.Label Label16 
            Alignment       =   1  'Right Justify
            AutoSize        =   -1  'True
            Caption         =   "Resultado Mesa Distribucion USD"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   1980
            TabIndex        =   152
            Top             =   1875
            Width           =   2790
         End
         Begin VB.Label Label14 
            Alignment       =   1  'Right Justify
            AutoSize        =   -1  'True
            Caption         =   "Resultado Mesa Distribucion CLP"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   1980
            TabIndex        =   151
            Top             =   1455
            Width           =   2790
         End
         Begin VB.Label Label13 
            Alignment       =   1  'Right Justify
            AutoSize        =   -1  'True
            Caption         =   "AVR Transferencia"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   1980
            TabIndex        =   149
            Top             =   1050
            Width           =   2790
         End
         Begin VB.Label Label12 
            Alignment       =   1  'Right Justify
            AutoSize        =   -1  'True
            Caption         =   "AVR Operacion"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   1980
            TabIndex        =   147
            Top             =   600
            Width           =   2790
         End
      End
      Begin MSComDlg.CommonDialog cd 
         Left            =   60
         Top             =   240
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin VB.CheckBox Intercambio 
         Caption         =   "Intercambio Nocional al Inicio"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   1
         Left            =   7980
         TabIndex        =   124
         Top             =   -300
         Visible         =   0   'False
         Width           =   2925
      End
      Begin VB.CheckBox Intercambio 
         Caption         =   "Intercambio Nocional al Inicio"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   7980
         TabIndex        =   122
         Top             =   -300
         Visible         =   0   'False
         Width           =   2925
      End
      Begin VB.TextBox I_Note 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3210
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   118
         Top             =   330
         Width           =   7605
      End
      Begin VB.TextBox D_Note 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   -71790
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   117
         Top             =   330
         Width           =   7605
      End
      Begin Threed.SSPanel SSPanel3 
         Height          =   2625
         Left            =   -74955
         TabIndex        =   85
         Top             =   675
         Width           =   10845
         _Version        =   65536
         _ExtentX        =   19129
         _ExtentY        =   4630
         _StockProps     =   15
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   0
         BevelInner      =   1
         Begin VB.ComboBox D_CmbInterNoc 
            BackColor       =   &H80000002&
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000009&
            Height          =   315
            ItemData        =   "FRM_SWAP_OP.frx":5E36
            Left            =   3600
            List            =   "FRM_SWAP_OP.frx":5E3D
            Style           =   2  'Dropdown List
            TabIndex        =   133
            Top             =   1320
            Visible         =   0   'False
            Width           =   1095
         End
         Begin VB.ComboBox D_Convencion 
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
            Left            =   4080
            Style           =   2  'Dropdown List
            TabIndex        =   111
            Top             =   165
            Width           =   1845
         End
         Begin VB.Frame D_FERIADOS_F 
            Caption         =   "Feriados Vcto Flujos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   465
            Left            =   90
            TabIndex        =   92
            Top             =   60
            Width           =   2820
            Begin VB.CheckBox D_FERIADOCHK 
               Caption         =   "INGLATERRA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   2
               Left            =   1485
               TabIndex        =   93
               Top             =   210
               Width           =   1305
            End
            Begin VB.CheckBox D_FERIADOCHK 
               Caption         =   "CHILE"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   0
               Left            =   45
               TabIndex        =   95
               Top             =   210
               Width           =   750
            End
            Begin VB.CheckBox D_FERIADOCHK 
               Caption         =   "USA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   1
               Left            =   810
               TabIndex        =   94
               Top             =   210
               Width           =   750
            End
         End
         Begin VB.Frame D_FERIADOS_L 
            Caption         =   "Feriados Fecha Liquidación"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   465
            Left            =   7845
            TabIndex        =   88
            Top             =   60
            Width           =   2910
            Begin VB.CheckBox D_FERIADOCHK 
               Caption         =   "INGLATERRA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   5
               Left            =   1485
               TabIndex        =   90
               Top             =   210
               Width           =   1305
            End
            Begin VB.CheckBox D_FERIADOCHK 
               Caption         =   "USA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   4
               Left            =   810
               TabIndex        =   91
               Top             =   210
               Width           =   750
            End
            Begin VB.CheckBox D_FERIADOCHK 
               Caption         =   "CHILE"
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
               Height          =   195
               Index           =   3
               Left            =   45
               TabIndex        =   89
               Top             =   210
               Value           =   1  'Checked
               Width           =   750
            End
         End
         Begin BACControles.TXTNumero D_Numero 
            Height          =   285
            Left            =   2295
            TabIndex        =   86
            Top             =   1350
            Visible         =   0   'False
            Width           =   1185
            _ExtentX        =   2090
            _ExtentY        =   503
            BackColor       =   -2147483646
            ForeColor       =   -2147483639
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
            Text            =   "0.0000"
            Text            =   "0.0000"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTFecha D_Fecha 
            Height          =   240
            Left            =   990
            TabIndex        =   87
            Top             =   1320
            Visible         =   0   'False
            Width           =   1035
            _ExtentX        =   1826
            _ExtentY        =   423
            BackColor       =   -2147483646
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
               Size            =   6.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   -2147483639
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "13/09/2006"
         End
         Begin MSFlexGridLib.MSFlexGrid D_Grid 
            Height          =   2000
            Left            =   90
            TabIndex        =   42
            Top             =   540
            Width           =   10650
            _ExtentX        =   18785
            _ExtentY        =   3519
            _Version        =   393216
            Rows            =   3
            Cols            =   6
            BackColor       =   -2147483633
            BackColorFixed  =   -2147483646
            ForeColorFixed  =   -2147483639
            BackColorBkg    =   -2147483636
            GridColor       =   -2147483633
            GridColorFixed  =   -2147483642
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            AllowUserResizing=   1
            Appearance      =   0
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
         Begin BACControles.TXTNumero D_DiasReset 
            Height          =   315
            Left            =   6915
            TabIndex        =   116
            Top             =   165
            Width           =   435
            _ExtentX        =   767
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
            Min             =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Label6 
            AutoSize        =   -1  'True
            Caption         =   "Días Reset"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   5970
            TabIndex        =   114
            Top             =   210
            Width           =   900
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Convención."
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   3015
            TabIndex        =   112
            Top             =   210
            Width           =   1020
         End
      End
      Begin Threed.SSPanel SSPanel2 
         Height          =   2625
         Left            =   45
         TabIndex        =   96
         Top             =   675
         Width           =   10845
         _Version        =   65536
         _ExtentX        =   19129
         _ExtentY        =   4630
         _StockProps     =   15
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   0
         BevelInner      =   1
         Begin VB.ComboBox I_CmbInterNoc 
            BackColor       =   &H80000002&
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000009&
            Height          =   315
            ItemData        =   "FRM_SWAP_OP.frx":5E50
            Left            =   3240
            List            =   "FRM_SWAP_OP.frx":5E57
            Style           =   2  'Dropdown List
            TabIndex        =   132
            Top             =   1320
            Visible         =   0   'False
            Width           =   1095
         End
         Begin BACControles.TXTNumero I_DiasReset 
            Height          =   315
            Left            =   6915
            TabIndex        =   115
            Top             =   165
            Width           =   435
            _ExtentX        =   767
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
            Min             =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.ComboBox I_Convencion 
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
            Left            =   4080
            Style           =   2  'Dropdown List
            TabIndex        =   109
            Top             =   165
            Width           =   1845
         End
         Begin VB.Frame I_FERIADOS_F 
            Caption         =   "Feriados Vcto Flujos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   465
            Left            =   90
            TabIndex        =   103
            Top             =   60
            Width           =   2820
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "INGLATERRA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   2
               Left            =   1485
               TabIndex        =   105
               Top             =   210
               Width           =   1305
            End
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "USA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   1
               Left            =   840
               TabIndex        =   106
               Top             =   210
               Width           =   750
            End
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "CHILE"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   0
               Left            =   45
               TabIndex        =   104
               Top             =   210
               Width           =   750
            End
         End
         Begin VB.Frame I_FERIADOS_L 
            Caption         =   "Feriados Fecha Liquidación"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   465
            Left            =   7845
            TabIndex        =   99
            Top             =   60
            Width           =   2910
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "INGLATERRA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   5
               Left            =   1485
               TabIndex        =   100
               Top             =   210
               Width           =   1305
            End
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "USA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   4
               Left            =   840
               TabIndex        =   102
               Top             =   210
               Width           =   750
            End
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "CHILE"
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
               Height          =   195
               Index           =   3
               Left            =   45
               TabIndex        =   101
               Top             =   210
               Value           =   1  'Checked
               Width           =   750
            End
         End
         Begin BACControles.TXTNumero I_Numero 
            Height          =   285
            Left            =   2115
            TabIndex        =   97
            Top             =   1320
            Visible         =   0   'False
            Width           =   810
            _ExtentX        =   1429
            _ExtentY        =   503
            BackColor       =   -2147483646
            ForeColor       =   -2147483639
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
            Text            =   "0.0000"
            Text            =   "0.0000"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTFecha I_Fecha 
            Height          =   255
            Left            =   1050
            TabIndex        =   98
            Top             =   1335
            Visible         =   0   'False
            Width           =   1035
            _ExtentX        =   1826
            _ExtentY        =   450
            BackColor       =   -2147483646
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
               Size            =   6.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   -2147483639
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "13/09/2006"
         End
         Begin MSFlexGridLib.MSFlexGrid I_Grid 
            Height          =   1995
            Left            =   120
            TabIndex        =   41
            Top             =   595
            Width           =   10650
            _ExtentX        =   18785
            _ExtentY        =   3519
            _Version        =   393216
            Rows            =   3
            Cols            =   6
            BackColor       =   -2147483633
            BackColorFixed  =   -2147483646
            ForeColorFixed  =   -2147483639
            BackColorBkg    =   -2147483636
            GridColor       =   -2147483633
            GridColorFixed  =   -2147483642
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            AllowUserResizing=   1
            Appearance      =   0
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
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "Días Reset"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   5970
            TabIndex        =   113
            Top             =   210
            Width           =   900
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Convención."
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   3015
            TabIndex        =   110
            Top             =   210
            Width           =   1020
         End
      End
      Begin MSFlexGridLib.MSFlexGrid GridTitulos 
         Height          =   1995
         Left            =   120
         TabIndex        =   130
         Top             =   720
         Width           =   10650
         _ExtentX        =   18785
         _ExtentY        =   3519
         _Version        =   393216
         Rows            =   3
         Cols            =   6
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483642
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
         Appearance      =   0
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
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "NOTA ..."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   -72480
         TabIndex        =   126
         Top             =   435
         Width           =   630
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "NOTA ..."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   2520
         TabIndex        =   125
         Top             =   435
         Width           =   630
      End
   End
   Begin MSFlexGridLib.MSFlexGrid I_Grid_Tran 
      Height          =   3405
      Left            =   10995
      TabIndex        =   144
      Top             =   675
      Width           =   7080
      _ExtentX        =   12488
      _ExtentY        =   6006
      _Version        =   393216
      Rows            =   3
      Cols            =   6
      BackColor       =   -2147483633
      BackColorFixed  =   -2147483646
      ForeColorFixed  =   -2147483639
      BackColorBkg    =   -2147483636
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483642
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
      AllowUserResizing=   1
      Appearance      =   0
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
   Begin MSFlexGridLib.MSFlexGrid D_Grid_Tran 
      Height          =   3180
      Left            =   11010
      TabIndex        =   145
      Top             =   4110
      Width           =   7050
      _ExtentX        =   12435
      _ExtentY        =   5609
      _Version        =   393216
      Rows            =   3
      Cols            =   6
      BackColor       =   -2147483633
      BackColorFixed  =   -2147483646
      ForeColorFixed  =   -2147483639
      BackColorBkg    =   -2147483636
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483642
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
      AllowUserResizing=   1
      Appearance      =   0
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
   Begin VB.Label I_Etiquetas 
      AutoSize        =   -1  'True
      Caption         =   "Ref. USD/CLP"
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
      Index           =   37
      Left            =   0
      TabIndex        =   166
      Top             =   0
      Width           =   1050
   End
   Begin VB.Label I_Etiquetas 
      AutoSize        =   -1  'True
      Caption         =   "Ref. Mx/USD"
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
      Index           =   36
      Left            =   2640
      TabIndex        =   165
      Top             =   0
      Width           =   960
   End
   Begin VB.Label lblOperador 
      Height          =   135
      Left            =   3360
      TabIndex        =   154
      Top             =   9000
      Visible         =   0   'False
      Width           =   2055
   End
   Begin VB.Label Label11 
      AutoSize        =   -1  'True
      Caption         =   "Dec. Tas"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   9420
      TabIndex        =   128
      Top             =   915
      Width           =   705
   End
   Begin VB.Label Label10 
      AutoSize        =   -1  'True
      Caption         =   "Dec. Am."
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   9420
      TabIndex        =   127
      Top             =   600
      Width           =   735
   End
   Begin VB.Label Label8 
      AutoSize        =   -1  'True
      Caption         =   "Modalidad Pago"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   75
      TabIndex        =   123
      Top             =   1035
      Width           =   1320
   End
   Begin VB.Label Label7 
      AutoSize        =   -1  'True
      Caption         =   "TICKER"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   45
      TabIndex        =   119
      Top             =   645
      Width           =   600
   End
End
Attribute VB_Name = "FRM_SWAP_OP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private objref As BacSwapSuda.clsRefMercado '*******PRD21657
Dim TypeSwap               As Integer
Dim resp As Integer

Dim MiObjSwap              As New Swap_OP
Dim MiObjSwapTicket        As New ClsOperacionTicket
Dim DigitoPenPago          As Boolean
Dim Aplicar                As String
Dim DecAmortizacion        As Integer
Dim AplicarFormatoExt      As String
Dim sem                     As Boolean
Dim bSwWriteResultadoClp   As Boolean
Dim bSwWriteResultadoUsd   As Boolean


Public CarteraFinanciera   As Variant
Public AreaResponsable     As Variant
Public LibroNegociacion    As Variant
Public CarteraNormativa    As Variant
Public SubCarteraNormativa As Variant
Public Observaciones       As Variant
Public RutCliente          As Variant
Public CodCliente          As Variant
Public cCarteraFinanciera  As Variant
Public cAreaResponsable    As Variant
Public cLibroNegociacion   As Variant
Public cCarteraNormativa   As Variant
Public cSubCartera         As Variant
Public iAceptar            As Boolean
Public iRut                As String
Public cNombre             As String
Public SwapModificacion    As Long
Public ValorizaTasaCero    As Long
Public gModalidad          As String


Private Const ICP = 800
Private Const IBR = 802 'PRD18662

Private Enum Lados
   [Izquierdo] = 1
   [Derecho] = 2
   [Izq_Tran] = 3
   [Der_Tran] = 4
End Enum

Private Enum Fechas
   [Fecha Efectiva] = 1
   [Fecha PrimerPago] = 2
   [Fecha PenultimoPago] = 3
   [Fecha Madurez] = 4
End Enum

   Private Enum columna
      [colNumFlujo] = 0
      [colFecVcto] = 1
      [colAmortiza] = 2
      [colTasaMasSpread] = 3
      [colInteres] = 4
      [colTotal] = 5
      [colModalidad] = 6
      [colDoctoPago] = 7
      [colSaldoAmortiza] = 8
      [colFecVctoant] = 9
      [colMontoMonOrig] = 10
      [colMontoUSD] = 11
      [colMontoCLP] = 12
      [colUbicacionDato] = 13
      [colFecLiquida] = 14
      [colFecFlujoReal] = 15
      [colFecFixing] = 16
      [colSaldoInsoluto] = 17
      [colPorcentajeAmortiza] = 18
      [colIntNoc] = 19
      [colFecValuta] = 20
      [colFlujoAdicional] = 21
      [colFXRate] = 22
      [colTasa] = 23
      [colSpread] = 24
      [colValorRazonable] = 25
         

      [colbEarlyTermination] = 26
      [colFechaInicio] = 27
      [colPeriodicidad] = 28
      
      
      
      '***************PRD21657
      [ColReferenciaUSDCLP] = 29
      [ColReferenciaMEXUSD] = 30
      [colFechaUSDCLP] = 31
      [colFechaMEXUSD] = 32
      '***************PRD21657
   
      
   End Enum

Const Chile = 6
Const EstadosUnidos = 225
Const Inglaterra = 510
Const FormatoMn = "#,##0"
Const formatoMx = "#,##0.0000"

Const Btn_Limpiar = 1
Const Btn_Flujos = 2
Const Btn_Grabar = 3
Const Btn_GenExcel = 4
Const Btn_CarExcel = 5
Const Btn_Cerrar = 6

Const xlToRight = -4161
Const xlToLeft = -4159
Const xlDown = -4121
Const xlUp = -4162
Const xlEdgeLeft = 7
Const xlEdgeRight = 10
Const xlDiagonalDown = 5
Const xlDiagonalUp = 6
Const xlEdgeBottom = 9
Const xlEdgeTop = 8
Const xlInsideHorizontal = 12
Const xlInsideVertical = 11
Const xlNone = -4142
Const xlContinuous = 1
Const xlThin = 2

Private Crea_xls    As Boolean
Private iCadena As String
Private FecVctoRec  As Date
Private FecVctoPag  As Date
Private SwCargaExcel As Long
Private ToolBoton     As Long

'CER 01/07/2008  - Flexibilización Intercambio Nocionales
Private FilMatIzq    As Long
Private FilMatDer    As Long
Private MsgInterNoc  As String
Private MatrizIzq(1000, 3)
Private MatrizDer(1000, 3)
Private iCad As String
Private SwValorICP As Long

Private I_Tasa As Double
Private I_Spre As Double
Private D_Tasa As Double
Private D_Spre As Double

Private nTotalVR_Recibe          As Double
Private nTotalVR_Recibe_Tran     As Double
Private nTotalVR_Paga            As Double
Private nTotalVR_Paga_Tran       As Double

'PROD-10967
Public Swap_Op_Threshold_LCR        As Double
Public Swap_Op_Metodologia_LCR      As Integer
Public Swap_Op_Cliente_LCR          As String








'''Private xlApp       As EXCEL.Application
'''Private xlBook      As EXCEL.Workbook

Private Function EntregaPeriodicidad(MiLado As Lados, Optional EnDias As Boolean) As Integer
   Dim Interes       As ComboBox
   Dim Capital       As ComboBox
   Dim iPeriodicidad As Integer
   Dim iDiasInteres  As Integer
   Dim iDiasCapital  As Integer

   If MiLado = Izquierdo Then
      Set Interes = I_FrecuenciaPago
      Set Capital = I_FrecuenciaCapital
   Else
      Set Interes = D_FrecuenciaPago
      Set Capital = D_FrecuenciaCapital
   End If

   iDiasInteres = 0
   If Interes.ListIndex > -1 Then
      iDiasInteres = Left(Interes.ItemData(Interes.ListIndex), 2)
      If iDiasInteres <> 12 And iDiasInteres <> -1 Then
         iDiasInteres = Val(Left(iDiasInteres, 1))
      End If
   End If

   iDiasCapital = 0
   If Capital.ListIndex > -1 Then
      iDiasCapital = Left(Capital.ItemData(Capital.ListIndex), 2)
      If iDiasCapital <> 12 And iDiasCapital <> -1 Then
         iDiasCapital = Val(Left(iDiasCapital, 1))
      End If
   End If
   If iDiasCapital > iDiasInteres Then
      iPeriodicidad = iDiasInteres
   Else
      iPeriodicidad = IIf(iDiasCapital > 0, iDiasCapital, iDiasInteres)
   End If

   If EnDias = True Then
      If iPeriodicidad = 12 Then
         iPeriodicidad = 365
      ElseIf iPeriodicidad = 6 Then
         iPeriodicidad = 180
      ElseIf iPeriodicidad = 3 Then
         iPeriodicidad = 90
      ElseIf iPeriodicidad = 1 Then
         iPeriodicidad = 30
      ElseIf iPeriodicidad = -1 Then
         iPeriodicidad = -1
      ElseIf iPeriodicidad = 0 Then
         iPeriodicidad = 0
      End If
      EntregaPeriodicidad = iPeriodicidad
   Else
      EntregaPeriodicidad = iPeriodicidad
   End If
End Function

Private Sub Proc_Cargar_Excel()

   Dim SwFrmErr As Integer
   Dim xGrid As MSFlexGrid
   
   Dim Lado As String
   Dim i   As Integer

   'CER 18/04/2008  - Req. Pantalla Ingreso Op. Swap
   ''''Let SwCargaExcel = 0
   Let SwValorICP = 0
   
   If MsgBox("Favor, debe verificar días feriados y días reset." & vbCrLf & _
           "Una vez cargado el excel, esto no se podrá realizar. " & vbCrLf & _
           "" & vbCrLf & vbCrLf & _
           "¿ Desea verificar ahora estos datos antes mencionados ? ", vbQuestion + vbYesNo) = vbYes Then
     Screen.MousePointer = vbDefault
     Exit Sub
   End If

   frmcargaxcel.Show 1
   
   If BotCargaExcel = 1 Then
      Frm_Msg_Planilla_Excel.Caption = "Problemas en Planilla Excel"
      Frm_Msg_Planilla_Excel.TxtMsg.Text = ""
      
      iCadena = ""
      SwFrmErr = 0
      ''''ToolBoton = Toolbar1.Button.Index
      rutaexcel
      
      If cd.FileName = "" Then
         MsgBox "Debe seleccionar una ruta y un nombre de archivo válidos", vbExclamation + vbOKOnly, TITSISTEMA
         Exit Sub
      End If
      
      MousePointer = vbHourglass
      
      For i = 1 To 2
         If i = 1 Then
           Lado = "I"
           Set xGrid = I_Grid
           I_Grid.Clear
         Else
           Lado = "D"
           Set xGrid = D_Grid
           D_Grid.Clear
         End If
         
         If ValidacionPlanillaExcel(Lado, i, cd.FileName) = True Then
         ' CER 21/07/2008 se agrega a condición And i = 2, para que cargue planilla
         ' después de haber validado hoja 1 y 2.
             If SwFrmErr = 0 And i = 2 Then
                 SwCargaExcel = 1
                 Call Cargar_Excel(cd.FileName)
             End If
         Else
         
             SwFrmErr = 1
         End If
      Next
      
      MousePointer = vbDefault
       
      If SwFrmErr = 1 Then
         Frm_Msg_Planilla_Excel.Show
         Frm_Msg_Planilla_Excel.ssMsgResum.Visible = True
         I_Grid.Clear
         D_Grid.Clear
         Call DefineTitulos
         ''''SwCargaExcel = 0 'La carga no fue exitosa
         Exit Sub
      Else
         If SwValorICP = 1 Then
            Toolbar1.Buttons(Btn_Grabar).Enabled = False
         Else
            Toolbar1.Buttons(Btn_Grabar).Enabled = True
            
            'SwCargaExcel = 1 'MAP Cambio de lugar
            Call Inhabilita
            MsgBox "Carga de datos realizada satisfactoriamente ." & vbCrLf, vbInformation, TITSISTEMA
         End If
       End If
   End If
   
End Sub

Private Sub Proc_Genera_Excel()

   'CER 18/04/2008  - Req. Pantalla Ingreso Op. Swap
         
   Screen.MousePointer = vbHourglass
   
   If MsgBox("¿ Seguro que desea Ingresar Amortizaciones por Excel. ?", vbQuestion + vbYesNo) = vbNo Then
      Screen.MousePointer = vbDefault
      Exit Sub
   End If
         
   If ValidacionPreGeneraExcel = True Then
   
      Call GeneracionFlujos(Izquierdo)
      Call GeneracionFlujos(Derecho)
      
      Call GeneracionFlujos(Izq_Tran)
      Call GeneracionFlujos(Der_Tran)
     
      If ChkAplizaOnLine(0).Value = 1 Then
         SSFlujos.Tab = 0
      Else
         SSFlujos.Tab = 1
      End If
      
      Call Generar_Excel
   End If
   
   MousePointer = vbDefault
   ''''ToolBoton = Button.Index
End Sub

Private Sub Proc_Genera_Flujos()

   Screen.MousePointer = vbHourglass

   If ValidacionPreGeneracio = True Then
      Let SwValorICP = 0
      
      Call GeneracionFlujos(Izquierdo)
      Call GeneracionFlujos(Derecho)
      Call GeneracionFlujos(Izq_Tran)
      Call GeneracionFlujos(Der_Tran)
      
      'CER 18/04/2008  - Req. Pantalla Ingreso Op. Swap
      'Cuando check Aplicar al Lado Contrario se active en parte Recibe
      'se mostrará flujos de parte recibe y viceversa.
      
      If ChkAplizaOnLine(0).Value = 1 Then
         Me.SSFlujos.Tab = 0
      Else
         Me.SSFlujos.Tab = 1
      End If
   Else
      Screen.MousePointer = vbDefault
      Exit Sub
   End If
   
   ''''ToolBoton = Button.Index
   
   If SwValorICP = 1 Then
      Toolbar1.Buttons(3).Enabled = False
   Else
      Toolbar1.Buttons(3).Enabled = True
   End If
   
   If ValidaFechaCierre() = False Then
      Toolbar1.Buttons(3).Enabled = False
   End If
   
   Screen.MousePointer = vbDefault

End Sub

Private Sub Proc_Grabar()

    If Me.Option1(0) Then  'Esta tratando de grabar cotización
        If MsgBox("¿ Es una COTIZACION, continúa. ?", vbQuestion + vbYesNo) = vbNo Then
            Exit Sub
        End If
    End If
    
    If ValidaMontos = True Then
        If ValidaDatosPantalla Then
            
            If Func_Grabacion() = True Then
                Call Limpiar
                Call GRABA_LOG_AUDITORIA("Opc_20302", "01", "GRABAR", "", "", "")
            Else
               If Thr_AplicaThreshold = True Then  '1° ver si aplica Threshold
                  If Thr_GrabaThreshold = False Then   'Si aplica, ver si no grabó
                     MsgBox "El usuario anuló la Operación!", vbExclamation, TITSISTEMA
                  Else
                     MsgBox "Usuario rechaza grabación o Error en proceso." & vbCrLf & "No se ha podido completar la grabación.", vbExclamation, TITSISTEMA  'PRD-4858, jbh, 15-02-2010
                  End If
               Else    'no depende del Threshold
                  MsgBox "Usuario rechaza grabación o Error en proceso." & vbCrLf & "No se ha podido completar la grabación.", vbExclamation, TITSISTEMA  'PRD-4858, jbh, 15-02-2010
               End If
            End If
        Else
            Frm_Msg_Planilla_Excel.Show
            Frm_Msg_Planilla_Excel.ssMsgResum.Visible = True
            Frm_Msg_Planilla_Excel.Caption = "Problemas en Datos de Pantalla"
    
        End If
    End If
End Sub

Private Function RetornaDifFecha(Lado As Lados) As Integer
   If Lado = Derecho Then
      RetornaDifFecha = DateDiff("D", CDate(D_FechaEfectiva.Text), CDate(D_PenultimoPago.Text))
   Else
      RetornaDifFecha = DateDiff("D", CDate(I_FechaEfectiva.Text), CDate(I_PenultimoPago.Text))
   End If
End Function

Private Sub GeneraFecha(Lado As Lados, QueFecha As Fechas, dFecha As Date, NuevaFecha As txtFecha, Optional Reversa As Boolean)
   Dim iPeriodicidad As Integer
   Dim iDias         As Integer
   Dim iPeriodos     As String
   Dim dFechaPaso    As Date

   If QueFecha = [Fecha Efectiva] Then
      iPeriodos = "D"
      iPeriodicidad = 2
      iDias = 1
      dFechaPaso = DateAdd(iPeriodos, iPeriodicidad, dFecha)
      GoTo GeneraValidacionFeriados
   End If
   If QueFecha = [Fecha PrimerPago] Then
      iPeriodos = "M"
      iDias = EntregaPeriodicidad(Lado)
      iPeriodicidad = iDias
      If Reversa = False Then
         dFechaPaso = DateAdd(iPeriodos, iPeriodicidad, dFecha)
      Else
         Dim iDifDias   As Integer
         Dim iDifFech   As Integer
         Dim iFlujos    As Integer
         Dim dFecEfect  As Date
         
         dFecEfect = IIf(Lado = Derecho, D_FechaEfectiva.Text, I_FechaEfectiva.Text)
         iDifDias = EntregaPeriodicidad(Lado, True)
         iDifFech = RetornaDifFecha(Lado)
         iFlujos = (iDifFech / iDifDias)
         dFechaPaso = DateAdd("M", (iDias * iFlujos) * -1, dFecha)
         
         If dFechaPaso < dFecEfect Then
            Do While dFechaPaso < dFecEfect
               iFlujos = iFlujos - 1
               dFechaPaso = DateAdd("M", (iDias * iFlujos) * -1, dFecha)
            Loop
         End If
         
      End If
   End If
   If QueFecha = [Fecha Madurez] Then
      iPeriodos = "YYYY"
      iPeriodicidad = 5
      dFechaPaso = DateAdd(iPeriodos, iPeriodicidad, dFecha)
   End If
   If QueFecha = [Fecha PenultimoPago] Then
      iPeriodos = "M"
      iDias = EntregaPeriodicidad(Lado) * -1
      iPeriodicidad = iDias
      dFechaPaso = DateAdd(iPeriodos, iPeriodicidad, dFecha)
   End If

   NuevaFecha.Text = dFechaPaso
Exit Sub
GeneraValidacionFeriados:
   Do While 1 = 1
      If MiDiaHabil(Str(dFechaPaso), 6) = True Then
         Exit Do
      Else
         dFechaPaso = DateAdd(iPeriodos, 1, dFechaPaso)
      End If
   Loop
   NuevaFecha.Text = dFechaPaso
End Sub

Private Function SugerirFechaPrimerVcto(MiLado As String, miFecha As Date) As Date
   Dim iDiasInteres  As Integer
   Dim iDiasCapital  As Integer
   Dim dFechaInicio  As Date
   Dim dFechaPrimVct As Date

   iDiasInteres = -1
   iDiasCapital = -1

   If MiLado = "D" Then
      If D_FrecuenciaPago.ListIndex = -1 Then
         dFechaPrimVct = DateAdd("D", 1, miFecha)
         SugerirFechaPrimerVcto = dFechaPrimVct
         Exit Function
      End If
      iDiasInteres = ValorAmort(D_FrecuenciaPago, "M")
      iDiasCapital = -1
      dFechaInicio = miFecha
   Else
      If I_FrecuenciaPago.ListIndex = -1 Then
         dFechaPrimVct = DateAdd("D", 1, miFecha)
         SugerirFechaPrimerVcto = dFechaPrimVct
         Exit Function
      End If
      iDiasInteres = ValorAmort(I_FrecuenciaPago, "M")
      iDiasCapital = -1
      dFechaInicio = miFecha
   End If
   iDiasCapital = IIf(iDiasCapital <= 0, iDiasInteres, iDiasCapital)
   dFechaPrimVct = DateAdd("M", iDiasCapital, dFechaInicio)
   SugerirFechaPrimerVcto = dFechaPrimVct
End Function
   
Private Function ParidadMoneda(ByVal Codigo As Integer) As Double
   Dim Datos()

   ParidadMoneda = 0#
   If Codigo = 999 Then
      ParidadMoneda = gsBAC_DolarObs
      Exit Function
   End If
   If Codigo = 998 Then
      ParidadMoneda = gsBAC_DolarObs / gsBAC_ValmonUF
      Exit Function
   End If
   If Codigo = 13 Then
      ParidadMoneda = 1
      Exit Function
   End If

   Envia = Array()
   AddParam Envia, Codigo
   AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_LEER_VALORMONEDA", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      ParidadMoneda = CDbl(Datos(4))
   Else
      ParidadMoneda = 0#
   End If
End Function

Private Function Conversion(ByVal Compra As Boolean) As Double
   Dim MisMonedas    As New ClsMoneda
   '>> Compra / Lado Derecho del FRM
   Dim MonedaM1      As Integer
   Dim MontoM1       As Double
   Dim ParidadM1     As Double
   Dim ValMoneda1    As Double
   Dim mnRRda1       As String
   '>> Venta / Lado Izquierdo del FRM
   Dim MonedaM2      As Integer
   Dim MontoM2       As Double
   Dim ParidadM2     As Double
   Dim ValMoneda2    As Double
   Dim mnRRda2       As String

   If I_Moneda.ListIndex = -1 Or D_Moneda.ListIndex = -1 Then
      Exit Function
   End If

   If I_Moneda.ItemData(I_Moneda.ListIndex) = D_Moneda.ItemData(D_Moneda.ListIndex) Then
      If Compra = True Then
         If I_Moneda.ItemData(I_Moneda.ListIndex) = 998 Then D_ValorMoneda.Text = I_ValorMoneda.Text
         If I_Moneda.ItemData(I_Moneda.ListIndex) <> 998 Then
            D_ValorMoneda.Text = 1#
            I_ValorMoneda.Text = 1#
         End If
      Else
         If I_Moneda.ItemData(I_Moneda.ListIndex) = 998 Then D_ValorMoneda.Text = I_ValorMoneda.Text
         If I_Moneda.ItemData(I_Moneda.ListIndex) <> 998 Then
            D_ValorMoneda.Text = 1#
            I_ValorMoneda.Text = 1#
         End If
      End If
   End If

   '>> Compra / Lado Izquierdo del FRM
   MonedaM1 = I_Moneda.ItemData(I_Moneda.ListIndex)
   MontoM1 = I_Nocionales.Text
   Call MisMonedas.LeerxCodigo(MonedaM1)
   mnRRda1 = MisMonedas.mnrrda
   If MonedaM1 <> 13 And MonedaM1 <> 999 And MonedaM1 <> 998 Then
      ParidadM1 = I_ValorMoneda.Text
   Else
      ParidadM1 = ParidadMoneda(MonedaM1)
      ValMoneda1 = I_ValorMoneda.Text
   End If

   '>> Venta / Lado Derecho del FRM
   MonedaM2 = D_Moneda.ItemData(D_Moneda.ListIndex)
   MontoM2 = D_Nocionales.Text
   Call MisMonedas.LeerxCodigo(MonedaM2)
   mnRRda2 = MisMonedas.mnrrda
   If MonedaM2 <> 13 And MonedaM2 <> 999 And MonedaM2 <> 998 Then
      ParidadM2 = D_ValorMoneda.Text
   Else
      ParidadM2 = ParidadMoneda(MonedaM2)
      ValMoneda2 = D_ValorMoneda.Text
   End If

   '>> Digita monto Compra Lado Derecho
   If Compra = True Then
      If mnRRda1 = "M" Then
         MontoM2 = MontoM1 * ParidadM1
         If mnRRda2 = "M" Then
            MontoM2 = BacDiv(MontoM2, ParidadM2)
         Else
            MontoM2 = MontoM2 * ParidadM2
         End If
      Else
         MontoM2 = BacDiv(MontoM1, ParidadM1)
         If mnRRda2 = "M" Then
            MontoM2 = BacDiv(MontoM2, ParidadM2)
         Else
            MontoM2 = MontoM2 * ParidadM2
         End If
      End If

      If MonedaM2 = 999 Then
         D_Nocionales.Text = Round(MontoM2, 0)
      Else
         If MonedaM2 = 998 Then
            D_Nocionales.Text = Round(MontoM2, 4)
         Else
            D_Nocionales.Text = Round(MontoM2, 4)
         End If
      End If
   End If

   '>> Digita monto Venta Lado Izquierdo
   If Compra = False Then
      If mnRRda2 = "M" Then
         MontoM1 = MontoM2 * ParidadM2
         If mnRRda1 = "M" Then
            MontoM1 = BacDiv(MontoM1, ParidadM1)
         Else
            MontoM1 = MontoM1 * ParidadM1
         End If
      Else
         MontoM1 = BacDiv(MontoM2, ParidadM2)
         If mnRRda1 = "M" Then
            MontoM1 = BacDiv(MontoM1, ParidadM1)
         Else
            MontoM1 = MontoM1 * ParidadM1
         End If
      End If

      If MonedaM1 = 999 Then
         I_Nocionales.Text = Round(MontoM1, 0)
      Else
         If MonedaM1 = 998 Then
            I_Nocionales.Text = Round(MontoM1, 4)
         Else
            I_Nocionales.Text = Round(MontoM1, 4)
         End If
      End If
   End If
   Set MisMonedas = Nothing
End Function

Private Function EntregaParidadBCCH(MiMnNemo As String) As Double
   Dim SQL$
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, MiMnNemo
   AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_TRAE_PARIDAD_SPOT_BCCH", Envia) Then
      MsgBox "Problemas para Rescatar Paridad del BCCH", vbCritical, "ERROR DE CALCULO"
      EntregaParidadBCCH = 1
      Exit Function
   Else
      If Bac_SQL_Fetch(Datos()) Then
         If Datos(1) = -1 Then
            EntregaParidadBCCH = 1
         Else
            EntregaParidadBCCH = Datos(1)
         End If
      End If
   End If
End Function

Private Sub CargaTasaMoneda(ByRef objCarga As ComboBox, ByVal CodMoneda As Integer, ByVal CodTasa As Integer, ByVal CodPeriodo As Integer)
   On Error Resume Next
   Dim Datos()

   Envia = Array()
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(CodMoneda)
   AddParam Envia, CDbl(CodTasa)
   AddParam Envia, CDbl(CodPeriodo)
   AddParam Envia, CDbl(4)
   
   If Not Bac_Sql_Execute("SP_RETORNA_TASAMONEDA", Envia) Then
      Exit Sub
   End If
   
   Call BacControlWindows(10)
   objCarga.Clear
   
   Do While Bac_SQL_Fetch(Datos())
      objCarga.AddItem Datos(2)
      objCarga.ItemData(objCarga.NewIndex) = CDbl(Datos(1))
   Loop
   
   If objCarga.ListCount = 0 Then
      Screen.MousePointer = vbDefault
      MsgBox "No se ha encontrado indicador para la moneda seleccionada ", vbExclamation + vbOKOnly
      
      If Me.Visible = True Then
         objCarga.SetFocus
      End If
      
      Exit Sub
   End If
   
   objCarga.ListIndex = 0
End Sub

Private Function CargaBases(Objesto As Object, Optional iProducto As Integer) As Boolean
   Dim Datos()

   Envia = Array()
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(Val(iProducto))
   If Not Bac_Sql_Execute("SP_LEEBASES", Envia) Then
      Exit Function
   End If
   Objesto.Clear
   Do While Bac_SQL_Fetch(Datos())
      Objesto.AddItem Datos(5)
      Objesto.ItemData(Objesto.NewIndex) = Val(Datos(1))
   Loop
End Function

Private Sub LeeMonedasPago(MiCombo As ComboBox, MiMonedas As Integer)
   On Error GoTo ErroCargaMonedasPago
   Dim Datos()

   Envia = Array()
   AddParam Envia, "PCS"
   AddParam Envia, MiMonedas
   If Not Bac_Sql_Execute("SP_RETORNA_MONEDA_PAGO", Envia) Then
      Exit Sub
   End If
   MiCombo.Clear
   Do While Bac_SQL_Fetch(Datos())
      MiCombo.AddItem UCase(Datos(2)) & Space(100) & UCase(Trim(Datos(3)))
      MiCombo.ItemData(MiCombo.NewIndex) = Val(Datos(1))
   Loop
   MiCombo.ListIndex = 0

   On Error GoTo 0
Exit Sub
ErroCargaMonedasPago:
   On Error GoTo 0
End Sub

Private Sub LeerMonedasSistemas(MiObjeto As ComboBox)
   On Error GoTo ErroProcLectura
   Dim Datos()

   Envia = Array()
   AddParam Envia, "PCS"
   If Not Bac_Sql_Execute("SP_LEER_MONEDAS_SISTEMA", Envia) Then
      GoTo ErroProcLectura
   End If
   Do While Bac_SQL_Fetch(Datos())
      If Datos(1) = "13" Then
         'InicioMoneda = UCase(Datos(2)) & Space(100) & UCase(Trim(Datos(3)))
      End If
      MiObjeto.AddItem UCase(Datos(2)) & Space(100) & UCase(Trim(Datos(3)))
      MiObjeto.ItemData(MiObjeto.NewIndex) = Val(Datos(1))
      'MiObjeto.ItemData  = Val(Datos(1))
   Loop
Exit Sub
ErroProcLectura:
   MsgBox "Error Lectura. " & vbCrLf & vbCrLf & "Se ha Producido un Error al Leer Monedas por Sistema.", vbExclamation, TITSISTEMA
End Sub

'************************PRD_21657
'EXTRAE REFERENCIAS DE MERCADO DESDE LA BBDD Y LAS CARGA EN UNA COLECCIÓN DENOMINADA:"REFERENCIAS",
'LOS OBJETOS  DE ESTA COLECCIÓN CORRESPONDEN A LA CLASE: "CLSREFMERCADO" CREADA.
'ESTA COLECCIÓN ESTA DISPONIBLE MIENTRAS EL FORMULARIO ESTE ACTIVO, POSTERIORMENTE SE ELIMINA
Private Sub LeerReferencias(MiObjeto As ComboBox, tipo As Integer)
   On Error GoTo ErroProcLectura
   Dim Datos()
   Dim i, X As Integer
   sem = False
   Envia = Array()
   AddParam Envia, -1 'tipo
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_MNT_REFRENCIA_MERCADO", Envia) Then
      GoTo ErroProcLectura
   End If
   Set Referencias = New Collection
   Do While Bac_SQL_Fetch(Datos())
        Set objref = New clsRefMercado
        objref.TipoSwap = Val(Datos(1))
        objref.Modalidad = UCase(Datos(2))
        objref.DiasValor = Val(Datos(3))
        objref.idtipocambio = Val(Datos(4))
        objref.Glosa = UCase(Datos(5))
        objref.Cod = UCase(Datos(6))
        Referencias.Add objref
        Set objref = Nothing
   Loop
Call RefMer
Exit Sub
ErroProcLectura:
   MsgBox "Error Lectura. " & vbCrLf & vbCrLf & "Se ha Producido un Error al Leer Monedas por Sistema.", vbExclamation, TITSISTEMA
End Sub




Private Sub Limpiar()
   
   Me.SSFlujos.Tab = 0
   SwCargaExcel = 1
   I_CmbInterNoc.Enabled = False
   I_CmbInterNoc.Visible = False
   
   ChkAplizaOnLine.Item(0).Value = 1


    'ChkRefMer.Value = 0 '**************PRD21657
    
    
    Intercambio(0).Enabled = False
    Intercambio(1).Enabled = False
    
    Option1(0) = False  '-- Guradar como Cartera es el default
    Option1(1) = True
    
    Option2(0) = True   '-- Fixing al inicioes el default
    Option2(1) = False
    
    D_Grid.Rows = 1     '-- MAP 20080519 reposicionamiento para evitar ejecución de evento change
    I_Grid.Rows = 1     '-- MAP 20080519 reposicionamiento para evitar ejecución de evento change
    
    D_Grid_Tran.Rows = 1
    I_Grid_Tran.Rows = 1
    
    
    '-- MAP 20080513
    I_FERIADOS_F.Enabled = True
    I_DiasReset.Enabled = True
    I_FERIADOS_L.Enabled = True
    I_Convencion.Enabled = True
       
    D_FERIADOS_F.Enabled = True
    D_DiasReset.Enabled = True
    D_FERIADOS_L.Enabled = True
    D_Convencion.Enabled = True
    DoEvents
   I_Moneda.ListIndex = -1
   I_NemMon.Caption = ""
   I_Nocionales.Text = 0#
   I_FrecuenciaPago.ListIndex = -1
   I_FrecuenciaCapital.ListIndex = -1
   DoEvents
   I_Indicador.ListIndex = -1
   DoEvents
   I_UltimoIndice.Text = 0#
   I_Spread.Text = 0#
   I_ConteoDias.ListIndex = -1
   I_FechaEfectiva.Text = gsBAC_Fecp
   I_Madurez.Text = gsBAC_Fecp
   I_PrimerPago.Text = gsBAC_Fecp
   I_PenultimoPago.Text = gsBAC_Fecp
   I_MonPago.ListIndex = -1
   I_MedioPago.ListIndex = -1

   
   
   
   
   

   D_Moneda.ListIndex = -1
   D_NemMon.Caption = ""
   D_Nocionales.Text = 0#
   D_FrecuenciaPago.ListIndex = -1
   D_FrecuenciaCapital.ListIndex = -1
   D_Indicador.ListIndex = -1
   D_UltimoIndice.Text = 0#
   D_Spread.Text = 0#
   D_ConteoDias.ListIndex = -1
   D_FechaEfectiva.Text = gsBAC_Fecp
   D_Madurez.Text = gsBAC_Fecp
   D_PrimerPago.Text = gsBAC_Fecp
   D_PenultimoPago.Text = gsBAC_Fecp
   
   D_MonPago.ListIndex = -1
   D_MedioPago.ListIndex = -1
   'I_ReferenciaUSDCLP.ListIndex = -1 '*************14-04-2015
   'I_ReferenciaMEXUSD.ListIndex = -1 '*************14-04-2015
   'D_ReferenciaUSDCLP.ListIndex = -1 '*************14-04-2015
  ' D_ReferenciaMEXUSD.ListIndex = -1 '*************14-04-2015
   

   TIKKER.Text = " "
   I_Note.Text = ""
   D_Note.Text = ""
   Intercambio(0).Value = 0
   Intercambio(1).Value = 0

   
   Dim iVuelta As Integer

   iVuelta = 0
   I_FechaEfectiva.Text = DateAdd("D", iVuelta, gsBAC_Fecp)
   Do While 1 = 1
      If MiDiaHabil(I_FechaEfectiva.Text, 6) = True Then
         iVuelta = iVuelta + 1
         If iVuelta = 3 Then
            Exit Do
         End If
         I_FechaEfectiva.Text = DateAdd("D", 1, I_FechaEfectiva.Text)
      Else
         I_FechaEfectiva.Text = DateAdd("D", 1, I_FechaEfectiva.Text)
      End If
   Loop

   Modalidad.Text = "COMPENSACION"

   On Error Resume Next
  '' I_Moneda.SetFocus
   I_Moneda.Text = "DOLAR USA" & Space(100) & "USD"
   On Error GoTo 0

   I_FrecuenciaPago.ListIndex = 1
   I_FrecuenciaCapital.ListIndex = I_FrecuenciaCapital.ListCount - 1
   D_FrecuenciaPago.ListIndex = 1
   D_FrecuenciaCapital.ListIndex = D_FrecuenciaCapital.ListCount - 1

   I_HabilitaFecha(1).Value = 0
   Call GeneraFecha(Izquierdo, [Fecha Efectiva], CDate(gsBAC_Fecp), I_FechaEfectiva)
   Call GeneraFecha(Izquierdo, [Fecha PrimerPago], CDate(I_FechaEfectiva.Text), I_PrimerPago)
   Call GeneraFecha(Izquierdo, [Fecha Madurez], CDate(I_FechaEfectiva.Text), I_Madurez)
   Call GeneraFecha(Izquierdo, [Fecha PenultimoPago], CDate(I_Madurez.Text), I_PenultimoPago)

   D_HabilitaFecha(1).Value = 0
   Call GeneraFecha(Derecho, [Fecha Efectiva], CDate(gsBAC_Fecp), D_FechaEfectiva)
   Call GeneraFecha(Derecho, [Fecha PrimerPago], CDate(D_FechaEfectiva.Text), D_PrimerPago)
   Call GeneraFecha(Derecho, [Fecha Madurez], CDate(D_FechaEfectiva.Text), D_Madurez)
   Call GeneraFecha(Derecho, [Fecha PenultimoPago], CDate(D_Madurez.Text), D_PenultimoPago)

   Call CargaItemCombo(I_ConteoDias, 4)
   Call CargaItemCombo(D_ConteoDias, 4)
   
   nTotalVR_Recibe = 0
   nTotalVR_Recibe_Tran = 0
   nTotalVR_Paga = 0
   nTotalVR_Paga_Tran = 0

   Me.Tag = ""
   
   ssp_AvrOpe.Caption = ""
   ssp_AvrTran.Caption = ""

   txt_Res_Mesa_Dist.Text = ""
   Let bSwWriteResultadoClp = False

   txt_Res_Mesa_Dist_USD.Text = ""
   Let bSwWriteResultadoClp = False
   
   
  
End Sub

Private Sub ChkAplizaOnLine_Click(Index As Integer)
   If ChkAplizaOnLine(0).Value = 0 And ChkAplizaOnLine(1).Value = 0 Then
      Aplicar = ""
      Exit Sub
   End If
   
   If ChkAplizaOnLine(Index).Value = 1 Then
      If Index = 0 Then
         Aplicar = "D"
         ChkAplizaOnLine(1).Value = 0
         'CER 18/04/2008  - Req. Pantalla Ingreso Op. Swap
         Me.SSFlujos.Tab = 0
         Exit Sub
      End If
      If Index = 1 Then
         Aplicar = "I"
         ChkAplizaOnLine(0).Value = 0
         'CER 18/04/2008  - Req. Pantalla Ingreso Op. Swap
         Me.SSFlujos.Tab = 1
         Exit Sub
      End If
   End If
End Sub

Private Sub cmdcancel_Click()
  ssMsgResum.Visible = False
End Sub

'*****************************PRD_21657_07-05-2015
'*****************************
'*****************************
Private Sub RefMer()
'OBTENER TIPO DE SWAP PARA BUSCAR EN COLECCIÓN DENOMINADA: "REFERENCIAS"
'If ChkRefMer.Value = 1 Then
   If I_Moneda.ListIndex = -1 Or D_Moneda.ListIndex = -1 Then
      'MsgBox "Debe seleccionar ambas monedas antes de prosegir.", vbInformation, TITSISTEMA
      TypeSwap = -1
      Exit Sub
   End If
   If I_Moneda.ItemData(I_Moneda.ListIndex) <> D_Moneda.ItemData(D_Moneda.ListIndex) Then
      TypeSwap = 2    'SWAP DE MONEDAS CCS
   Else
      If I_Indicador.ListIndex = -1 Then Exit Sub
      If I_Indicador.ItemData(I_Indicador.ListIndex) = 13 Or D_Indicador.ItemData(D_Indicador.ListIndex) = 13 Then
         TypeSwap = 4 'SWAP PROMEDIO CÁMARA ICP
      Else
         TypeSwap = 1 'SWAP DE TASAS IRF
      End If
   End If
'LIMPIAR COMBOBOXES
  I_ReferenciaUSDCLP.Clear
  I_ReferenciaMEXUSD.Clear
  D_ReferenciaUSDCLP.Clear
  D_ReferenciaMEXUSD.Clear
'RESETEO DE VALORES DE OBJETO, RELACIONADO CON LOS COMBOBOXES
MiObjSwap.A105_ReferenciaMEXUSD = 0
MiObjSwap.A104_ReferenciaUSDCLP = 0
MiObjSwap.A101_ReferenciaMEXUSD = 0
MiObjSwap.A100_ReferenciaUSDCLP = 0
'CARGA COMBOBOXES CON LOS VALORES DE LA COLECCIÓN DENOMINADA: "REFERENCIAS"
'If ChkRefMer.Value = 1 Then

  For Each obj In Referencias
   Select Case Modalidad.ListIndex
          Case 0:
                If (obj.Modalidad = "E" And obj.idtipocambio = 1 And obj.TipoSwap = TypeSwap) Then
                    If I_ReferenciaUSDCLP.Enabled Then
                        I_ReferenciaUSDCLP.AddItem obj.Glosa & Space(100) & obj.DiasValor
                        I_ReferenciaUSDCLP.ItemData(I_ReferenciaUSDCLP.NewIndex) = obj.Cod
                        I_ReferenciaUSDCLP.ListIndex = 0
                        MiObjSwap.A100_dias = CInt(Right(I_ReferenciaUSDCLP.Text, 2))
                        
                    End If
                    If D_ReferenciaUSDCLP.Enabled Then
                        D_ReferenciaUSDCLP.AddItem obj.Glosa & Space(100) & obj.DiasValor
                        D_ReferenciaUSDCLP.ItemData(D_ReferenciaUSDCLP.NewIndex) = obj.Cod
                        D_ReferenciaUSDCLP.ListIndex = 0
                        MiObjSwap.A104_dias = CInt(Right(D_ReferenciaUSDCLP.Text, 2))
                        
                    End If
                End If
                
                If (obj.Modalidad = "E" And obj.idtipocambio = 0 And obj.TipoSwap = TypeSwap) Then
                    If I_ReferenciaMEXUSD.Enabled Then
                        I_ReferenciaMEXUSD.AddItem obj.Glosa & Space(100) & obj.DiasValor
                        I_ReferenciaMEXUSD.ItemData(I_ReferenciaMEXUSD.NewIndex) = obj.Cod
                        I_ReferenciaMEXUSD.ListIndex = 0
                        MiObjSwap.A101_dias = CInt(Right(I_ReferenciaMEXUSD.Text, 2))
                        
                    End If
                    If D_ReferenciaMEXUSD.Enabled Then
                        D_ReferenciaMEXUSD.AddItem obj.Glosa & Space(100) & obj.DiasValor
                        D_ReferenciaMEXUSD.ItemData(D_ReferenciaMEXUSD.NewIndex) = obj.Cod
                        D_ReferenciaMEXUSD.ListIndex = 0
                        MiObjSwap.A105_dias = CInt(Right(D_ReferenciaMEXUSD.Text, 2))
                        
                    End If
                End If
       Case 1:
                If (obj.Modalidad = "C" And obj.idtipocambio = 1 And obj.TipoSwap = TypeSwap) Then
                    If I_ReferenciaUSDCLP.Enabled Then
                        I_ReferenciaUSDCLP.AddItem obj.Glosa & Space(100) & obj.DiasValor
                        I_ReferenciaUSDCLP.ItemData(I_ReferenciaUSDCLP.NewIndex) = obj.Cod
                        I_ReferenciaUSDCLP.ListIndex = 0
                        MiObjSwap.A100_dias = CInt(Right(I_ReferenciaUSDCLP.Text, 2))
                        
                    End If
                    If D_ReferenciaUSDCLP.Enabled Then
                        D_ReferenciaUSDCLP.AddItem obj.Glosa & Space(100) & obj.DiasValor
                        D_ReferenciaUSDCLP.ItemData(D_ReferenciaUSDCLP.NewIndex) = obj.Cod
                        D_ReferenciaUSDCLP.ListIndex = 0
                        MiObjSwap.A104_dias = CInt(Right(D_ReferenciaUSDCLP.Text, 2))
                        
                    End If
                End If
                
                If (obj.Modalidad = "C" And obj.idtipocambio = 0 And obj.TipoSwap = TypeSwap) Then
                    If I_ReferenciaMEXUSD.Enabled Then
                        I_ReferenciaMEXUSD.AddItem obj.Glosa & Space(100) & obj.DiasValor
                        I_ReferenciaMEXUSD.ItemData(I_ReferenciaMEXUSD.NewIndex) = obj.Cod
                        I_ReferenciaMEXUSD.ListIndex = 0
                        MiObjSwap.A101_dias = CInt(Right(I_ReferenciaMEXUSD.Text, 2))
                        
                    End If
                    If D_ReferenciaMEXUSD.Enabled Then
                        D_ReferenciaMEXUSD.AddItem obj.Glosa & Space(100) & obj.DiasValor
                        D_ReferenciaMEXUSD.ItemData(D_ReferenciaMEXUSD.NewIndex) = obj.Cod
                        D_ReferenciaMEXUSD.ListIndex = 0
                        MiObjSwap.A105_dias = CInt(Right(D_ReferenciaMEXUSD.Text, 2))
                        
                    End If
                End If
    End Select
Next
'End If
'***************SI NO TIENEN INFORMACIÓN EN BBDD
If I_ReferenciaUSDCLP.ListCount = 0 Then
    I_ReferenciaUSDCLP.AddItem "SIN INFORMACION"
    I_ReferenciaUSDCLP.ListIndex = 0
End If
If D_ReferenciaUSDCLP.ListCount = 0 Then
    D_ReferenciaUSDCLP.AddItem "SIN INFORMACION"
    D_ReferenciaUSDCLP.ListIndex = 0
End If
If I_ReferenciaMEXUSD.ListCount = 0 Then
    I_ReferenciaMEXUSD.AddItem "SIN INFORMACION"
    I_ReferenciaMEXUSD.ListIndex = 0
End If
If D_ReferenciaMEXUSD.ListCount = 0 Then
    D_ReferenciaMEXUSD.AddItem "SIN INFORMACION"
    D_ReferenciaMEXUSD.ListIndex = 0
End If

'***************SI NO ESTAN BLOQUEADOS
If Not I_ReferenciaUSDCLP.Enabled Then
    I_ReferenciaUSDCLP.AddItem "NO APLICA"
    I_ReferenciaUSDCLP.ListIndex = 1
End If
If Not D_ReferenciaUSDCLP.Enabled Then
    D_ReferenciaUSDCLP.AddItem "NO APLICA"
    D_ReferenciaUSDCLP.ListIndex = 1
End If
If Not I_ReferenciaMEXUSD.Enabled Then
    I_ReferenciaMEXUSD.AddItem "NO APLICA"
    I_ReferenciaMEXUSD.ListIndex = 1
End If
If Not D_ReferenciaMEXUSD.Enabled Then
    D_ReferenciaMEXUSD.AddItem "NO APLICA"
    D_ReferenciaMEXUSD.ListIndex = 1
End If
'RESETEA CHECKBOX
'ChkRefMer.Value = 0
'ChkRefMer.Enabled = False
'End If
End Sub



Private Sub CmdCalculaFixing_Click()
   If MsgBox("¿Ajusta Fecha Fixing con sistema?", vbQuestion + vbYesNo) = vbNo Then
        Screen.MousePointer = vbDefault
        Exit Sub
   Else
     'Codigo 2 indica que calculara fecha fixing
     'pivoteando al vencimiento o al inicio
     'según se indique en la pantalla
     If Not (UCase(I_Indicador.Text) Like "FIJA*") Then
         Call AplicarValidacionFeriadosExcel(Izquierdo, I_Grid, 2)
        'Call AplicarValidacionFeriadosExcel("I", I_Grid, 2)
     End If
     If Not (UCase(D_Indicador.Text) Like "FIJA*") Then
        Call AplicarValidacionFeriadosExcel(Derecho, D_Grid, 2)
     End If
   End If
End Sub

Private Sub D_CmbInterNoc_Click()
'CER 07/07/2008  - Flexibilización Intercambio Nocionales

    If D_CmbInterNoc.ListIndex <> -1 Then

        If D_CmbInterNoc.ItemData(D_CmbInterNoc.ListIndex) <> -1 Then
          D_Grid.TextMatrix(D_Grid.Row, 19) = D_CmbInterNoc.Text
           D_CmbInterNoc.Visible = False
     '       D_Grid.TextMatrix(D_Grid.Row, 19) = D_CmbInterNoc.ItemData(D_CmbInterNoc.ListIndex)
            D_CmbInterNoc.Visible = False
            D_Grid.SetFocus
        End If


            D_CmbInterNoc.Visible = False
            D_Grid.SetFocus



      If Aplicar = "I" And I_Grid.Rows = D_Grid.Rows Then
         If I_Grid.Rows = D_Grid.Rows Then
            I_Grid.RowSel = D_Grid.RowSel
            I_Grid.TextMatrix(D_Grid.RowSel, D_Grid.ColSel) = D_CmbInterNoc.Text

         Else
            For cuenta = 1 To I_Grid.Rows - 1
               If I_Grid.TextMatrix(cuenta, 1) = D_Grid.TextMatrix(D_Grid.RowSel, 1) Then
                   I_Grid.TextMatrix(cuenta, 19) = D_CmbInterNoc.Text
               End If
            Next
         End If
      End If


    End If

End Sub

Private Sub D_CmbInterNoc_GotFocus()
    D_CmbInterNoc.BackColor = vbWhite
    D_CmbInterNoc.ForeColor = vbBlack
    SendKeys ("%{Down}")
End Sub


Private Sub D_CmbInterNoc_KeyPress(KeyAscii As Integer)
'CER 07/07/2008  - Flexibilización Intercambio Nocionales
 If KeyAscii = 13 Then
    D_Grid.TextMatrix(D_Grid.Row, 19) = D_CmbInterNoc
    D_CmbInterNoc.Visible = False
    D_Grid.SetFocus
    
     If Aplicar = "I" Then
         If I_Grid.Rows = D_Grid.Rows Then
            I_Grid.RowSel = D_Grid.RowSel
            I_Grid.TextMatrix(D_Grid.RowSel, D_Grid.ColSel) = D_CmbInterNoc.Text
         End If
     End If
 End If

End Sub

'Private Sub D_DireccionCalculo_Click()
'   If D_DireccionCalculo.ItemData(D_DireccionCalculo.ListIndex) = 0 Then
'      D_PrimerPago.Enabled = False
'      D_PenultimoPago.Enabled = False
'   Else
'      D_PrimerPago.Enabled = True
'      D_PenultimoPago.Enabled = True
'   End If
'End Sub

Private Sub D_Convencion_Click()
   If D_Grid.Rows > 1 Then
      Call AplicarValidacionFeriados(Derecho, D_Grid)
     'Call AplicarValidacionFeriados("D", D_Grid)
      
      Call CalculoInteresBonos(Derecho, D_Grid)
     'Call CalculoInteresBonos("D", D_Grid)
   End If
End Sub

Private Sub D_DiasReset_Change()
'   If D_DiasReset.Text > 0 Then
      D_Grid.ColWidth(16) = 1500
     'Solo corrige fecha Fixing con vencimiento o inicio (según opción)
     'If SwCargaExcel = 1 Then
     '    If MsgBox("¿Ajusta Fecha Fixing Pierna Paga?", vbQuestion + vbYesNo) = vbNo Then
     '      Screen.MousePointer = vbDefault
     '      Exit Sub
     '    Else
     '      Call AplicarValidacionFeriadosExcel("D", D_Grid, 2)
     '    End If
     'End If ' Se deja código tal como esta en produccion
'   End If 'MAP 20080515 Se decomenta código, se vuelve a comentar 20080516, se cayo
  If I_Grid.Rows > 1 Then
    MsgBox "Hacer clic en botón Calc. Fixing o Generar Flujos para aplicar ", vbInformation
    CmdCalculaFixing.SetFocus
  End If

End Sub

Private Sub D_DiasReset_KeyDown(KeyCode As Integer, Shift As Integer)
'   If D_Grid.Rows > 1 And KeyCode = vbKeyReturn Then
'      Call AplicarValidacionFeriados("D", D_Grid)
'      Call CalculoInteresBonos("D", D_Grid)
'   End If 'MAP 20080515
End Sub

Private Sub D_DiasReset_LostFocus()
'   If D_Grid.Rows > 1 Then
'      Call AplicarValidacionFeriados("D", D_Grid)
'      Call CalculoInteresBonos("D", D_Grid)
'   End If
'   MAP 20080515
'    Call CmdCalculaFixing_Click
End Sub

Private Sub D_Fecha_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim CHI     As Boolean
   Dim USA     As Boolean
   Dim ENG     As Boolean
   Dim MiLado  As Lados

   MiLado = Derecho
   
   If KeyCode = vbKeyReturn Then
      If D_Grid.ColSel = 1 Then
         CHI = IIf(MiLado = Izquierdo, I_FERIADOCHK(0).Value, D_FERIADOCHK(0).Value)
         USA = IIf(MiLado = Izquierdo, I_FERIADOCHK(1).Value, D_FERIADOCHK(1).Value)
         ENG = IIf(MiLado = Izquierdo, I_FERIADOCHK(2).Value, D_FERIADOCHK(2).Value)
      End If
      
      If D_Grid.ColSel = 14 Then
         CHI = IIf(MiLado = Izquierdo, I_FERIADOCHK(3).Value, D_FERIADOCHK(3).Value)
         USA = IIf(MiLado = Izquierdo, I_FERIADOCHK(4).Value, D_FERIADOCHK(4).Value)
         ENG = IIf(MiLado = Izquierdo, I_FERIADOCHK(5).Value, D_FERIADOCHK(5).Value)
      End If
      
      If CHI = True And MiDiaHabil(D_Fecha.Text, Chile) = False Then
         MsgBox "Aviso." & vbCrLf & "Día seleccionado no es hábil para el calendario Chileno.", vbExclamation, TITSISTEMA
         D_Fecha.SetFocus
         Exit Sub
      End If
      
      If USA = True And MiDiaHabil(D_Fecha.Text, EstadosUnidos) = False Then
         MsgBox "Aviso." & vbCrLf & "Día seleccionado no es hábil para el calendario Estadounidense.", vbExclamation, TITSISTEMA
         D_Fecha.SetFocus
         Exit Sub
      End If
      
      If ENG = True And MiDiaHabil(D_Fecha.Text, Inglaterra) = False Then
         MsgBox "Aviso." & vbCrLf & "Día seleccionado no es hábil para el calendario Ingles.", vbExclamation, TITSISTEMA
         D_Fecha.SetFocus
         Exit Sub
      End If
      
      D_Grid.TextMatrix(D_Grid.RowSel, D_Grid.ColSel) = D_Fecha.Text
      D_Grid_Tran.TextMatrix(D_Grid.RowSel, D_Grid.ColSel) = D_Fecha.Text '--> Adrian 09-12-2009
      
      If D_Grid.ColSel = 1 Then
         If D_Grid.RowSel < (D_Grid.Rows - 1) Then
            D_Grid.TextMatrix(D_Grid.RowSel + 1, 16) = Format(ReCalculaDiasFeridos(Derecho, D_Fecha.Text, True, True), "dd/mm/yyyy")
            D_Grid_Tran.TextMatrix(D_Grid.RowSel + 1, 16) = Format(ReCalculaDiasFeridos(Der_Tran, D_Fecha.Text, True, True), "dd/mm/yyyy")  '--> Adrian 09-12-2009
         End If
         
         Call CalculoInteresBonos(Derecho, D_Grid)
         Call CalculoInteresBonos(Der_Tran, D_Grid_Tran)
      End If
      
      D_Grid.Tag = "Fechas Modificadas"
      D_Grid.Enabled = True
      D_Fecha.Visible = False
      D_Grid.SetFocus
   End If
   
   ' CER 23/07/2008 - Se agrega condición para que cuando  se modifique fecha vcto.
   ' en la pata que se encuentre chequeada la opción Aplicar al Lado Contrario,
   ' se actualice automáticamente fech vcto. correspondiente al mismo flujo en lado
   ' contrario
   
   If Aplicar = "I" Then
       I_Grid.RowSel = D_Grid.RowSel
       I_Grid.TextMatrix(D_Grid.RowSel, D_Grid.ColSel) = D_Fecha.Text
       I_Grid_Tran.RowSel = D_Grid.RowSel
       I_Grid_Tran.TextMatrix(D_Grid.RowSel, D_Grid.ColSel) = D_Fecha.Text '--> Adrian 09-12-2009
       
       Call CalculoInteresBonos(Izquierdo, I_Grid)
       Call CalculoInteresBonos(Izq_Tran, I_Grid_Tran)
   End If

   If KeyCode = vbKeyEscape Then
      D_Grid.Enabled = True
      D_Fecha.Visible = False
      D_Grid.SetFocus
   End If
   
   D_FERIADOS_F.Enabled = D_Grid.Enabled
   D_FERIADOS_L.Enabled = D_Grid.Enabled
End Sub

Private Sub D_FechaEfectiva_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call GeneraFecha(Derecho, [Fecha PrimerPago], CDate(D_FechaEfectiva.Text), D_PrimerPago)
      Call GeneraFecha(Derecho, [Fecha Madurez], CDate(D_FechaEfectiva.Text), D_Madurez)
      Call GeneraFecha(Derecho, [Fecha PenultimoPago], CDate(D_Madurez.Text), D_PenultimoPago)
      '   D_PrimerPago.Text = SugerirFechaPrimerVcto("D", D_FechaEfectiva.Text)
      '   D_PenultimoPago.Text = SugerirFechaPrimerVcto("D", D_PrimerPago.Text)
      '   D_Madurez.Text = SugerirFechaPrimerVcto("D", D_PenultimoPago.Text)
   End If
End Sub

Private Sub D_FechaEfectiva_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      DigitoPenPago = False
      D_Generacion = "Generación Normal"
   End If
End Sub

Private Sub D_Grid_Click()
'CER 07/07/2008  - Flexibilización Intercambio Nocionales
 If SwCargaExcel = 0 Then
    If D_Grid.Col = 19 Then
      D_CmbInterNoc.Top = D_Grid.Top + D_Grid.CellTop
      D_CmbInterNoc.Left = D_Grid.Left + D_Grid.CellLeft
      D_CmbInterNoc.Width = D_Grid.CellWidth
      D_CmbInterNoc.Visible = True
      D_CmbInterNoc.SetFocus
    Else
      D_CmbInterNoc.Visible = False
    End If
    
 End If

End Sub

Private Sub D_Grid_KeyPress(KeyAscii As Integer)
'CER 07/07/2008  - Flexibilización Intercambio Nocionales
 If SwCargaExcel = 0 Then
    If D_Grid.Col = 19 Then
      D_CmbInterNoc.Top = D_Grid.Top + D_Grid.CellTop
      D_CmbInterNoc.Left = D_Grid.Left + D_Grid.CellLeft
      D_CmbInterNoc.Width = D_Grid.CellWidth
      D_CmbInterNoc.Visible = True
      D_CmbInterNoc.SetFocus
    End If
 End If
End Sub

Private Sub D_Grid_Scroll()
    D_CmbInterNoc.Visible = False
End Sub

Private Sub D_Indice_Tran_Change()
   
   If Aplicar = "I" And I_Indicador.Text = D_Indicador.Text Then 'I_Indicador.Text <> "ICP" Then
      I_Indice_Tran.Text = D_Indice_Tran.Text
   End If
   
End Sub

Private Sub D_Indice_Tran_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      SendKeys "{TAB}"
   End If

End Sub

Private Sub D_Indice_Tran_LostFocus()

   D_Tasa = D_Indice_Tran.Text
   D_Spre = D_Spread_Tran.Text
   I_Tasa = I_Indice_Tran.Text
   I_Spre = I_Spread_Tran.Text
   
   If Aplicar = "I" And I_Indicador.Text = D_Indicador.Text Then 'I_Indicador.Text <> "ICP" Then
      I_Indice_Tran.Text = D_Indice_Tran.Text
   End If
   
   Call Carga_Tasa_Grilla(I_Tasa, I_Spre, I_Grid_Tran, Lados.Izq_Tran)
   Call Carga_Tasa_Grilla(D_Tasa, D_Spre, D_Grid_Tran, Lados.Der_Tran)

End Sub


Private Sub Modalidad_Change()

   If Modalidad.Text = "ENTREGA FISICA" Then
      gModalidad = "E"
   Else
      If Modalidad.Text = "COMPENSACION" Then
          gModalidad = "C"
      End If
   End If


End Sub



Private Sub Modalidad_LostFocus()

   If Modalidad.Text = "ENTREGA FISICA" Then
      gModalidad = "E"
   Else
      If Modalidad.Text = "COMPENSACION" Then
          gModalidad = "C"
      End If
   End If
End Sub

Private Sub OptInterNoc_Click(Index As Integer)
    'Call Carga_Intercambio_Nocionales
End Sub
Private Sub D_ReferenciaMEXUSD_Click()

If D_ReferenciaMEXUSD.Text <> "NO APLICA" _
And D_ReferenciaMEXUSD.Text <> "REFERENCIA" _
And D_ReferenciaMEXUSD.Text <> "" _
And D_ReferenciaMEXUSD.Text <> "SIN INFORMACION" Then
        MiObjSwap.A105_dias = CInt(Right(D_ReferenciaMEXUSD.Text, 2))
        MiObjSwap.A105_ReferenciaMEXUSD = D_ReferenciaMEXUSD.ItemData(D_ReferenciaMEXUSD.ListIndex)
        'Call DiaRef(MiObjSwap.A105_ReferenciaMEXUSD, D_PrimerPago.Text)
      End If
End Sub

Private Sub D_ReferenciaUSDCLP_Click()
If D_ReferenciaUSDCLP.Text <> "NO APLICA" _
And D_ReferenciaUSDCLP.Text <> "REFERENCIA" _
And D_ReferenciaUSDCLP.Text <> "" _
And D_ReferenciaUSDCLP.Text <> "SIN INFORMACION" Then

        MiObjSwap.A104_dias = CInt(Right(D_ReferenciaUSDCLP.Text, 2))
        MiObjSwap.A104_ReferenciaUSDCLP = D_ReferenciaUSDCLP.ItemData(D_ReferenciaUSDCLP.ListIndex)
        'Call DiaRef(MiObjSwap.A104_ReferenciaUSDCLP, D_PrimerPago.Text)
   End If
End Sub

Private Sub I_ReferenciaMEXUSD_Click()
If I_ReferenciaMEXUSD.Text <> "NO APLICA" _
And I_ReferenciaMEXUSD.Text <> "REFERENCIA" _
And I_ReferenciaMEXUSD.Text <> "" _
And I_ReferenciaMEXUSD.Text <> "SIN INFORMACION" Then
        MiObjSwap.A101_dias = CInt(Right(I_ReferenciaMEXUSD.Text, 2))
        MiObjSwap.A101_ReferenciaMEXUSD = I_ReferenciaMEXUSD.ItemData(I_ReferenciaMEXUSD.ListIndex)
        'Call DiaRef(MiObjSwap.A101_ReferenciaMEXUSD, I_PrimerPago.Text)
End If
End Sub

Private Sub I_ReferenciaUSDCLP_Click()
If I_ReferenciaUSDCLP.Text <> "NO APLICA" _
And I_ReferenciaUSDCLP.Text <> "REFERENCIA" _
And I_ReferenciaUSDCLP.Text <> "" _
And I_ReferenciaUSDCLP.Text <> "SIN INFORMACION" Then
        MiObjSwap.A100_dias = CInt(Right(I_ReferenciaUSDCLP.Text, 2))
        MiObjSwap.A100_ReferenciaUSDCLP = I_ReferenciaUSDCLP.ItemData(I_ReferenciaUSDCLP.ListIndex)
        'Call DiaRef(MiObjSwap.A100_ReferenciaUSDCLP, I_PrimerPago.Text)
 End If
End Sub

'*********************PRD21657---07-05-2015
Private Sub DiaRef(ref As Integer, primerpago As Date)
    Dim paises As String
    Dim i As Integer
   
        Select Case I_FERIADOCHK(4).Value
                Case 0: paises = IIf(I_FERIADOCHK(5).Value = 0, ";6;", ";6;510;")
                Case 1: paises = IIf(I_FERIADOCHK(5).Value = 0, ";6;255;", ";6;255;510;")
        End Select

    Envia = Array()
    AddParam Envia, CDate(primerpago)
    AddParam Envia, CInt(ref)    'Dia anterior
    AddParam Envia, CStr(paises)
    AddParam Envia, "v"
'    If MISQL.SQL_Execute(Sql) > 0 Then
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_AGREGA_N_DIAS_HABILES", Envia) Then
       Exit Sub
    End If
    If Bac_SQL_Fetch(Datos()) Then
        'cal.Text = Datos(1)
    End If
End Sub
Private Sub Modalidades(cboRefMerUSDCLP As ComboBox, _
                        cboRefMerMEXUSD As ComboBox, _
                        cboMoneda As ComboBox, _
                        cboMonPago As ComboBox)
Dim A As Integer
'CInt(Right(cboMoneda.Text, 2))=
   'If Left(Right(cboMoneda.Text, 10), 4) = 13 Then
                A = cboMoneda.ItemData(cboMoneda.ListIndex + 1)

'999=PESOS, 998=UF, 13=DOLAR USD
If cboMoneda.ListIndex <> -1 And cboMonPago.ListIndex <> -1 Then
If (cboMoneda.ItemData(cboMoneda.ListIndex) = 999 And cboMonPago.ItemData(cboMonPago.ListIndex) = 999) Or _
(cboMoneda.ItemData(cboMoneda.ListIndex) = 998 And cboMonPago.ItemData(cboMonPago.ListIndex) = 999) Then
    cboRefMerUSDCLP.Enabled = False
    cboRefMerMEXUSD.Enabled = False
    cboRefMerUSDCLP.Clear
    cboRefMerMEXUSD.Clear
    cboRefMerUSDCLP.AddItem "NO APLICA"
    cboRefMerUSDCLP.ListIndex = 0
    cboRefMerMEXUSD.AddItem "NO APLICA"
    cboRefMerMEXUSD.ListIndex = 0


Else
    If (cboMoneda.ItemData(cboMoneda.ListIndex) = 13 And cboMonPago.ItemData(cboMonPago.ListIndex) = 13) Or _
   (cboMoneda.ItemData(cboMoneda.ListIndex) = 13 And cboMonPago.ItemData(cboMonPago.ListIndex) = 999) Or _
   (cboMoneda.ItemData(cboMoneda.ListIndex) = 999 And cboMonPago.ItemData(cboMonPago.ListIndex) = 13) Or _
   (cboMoneda.ItemData(cboMoneda.ListIndex) = 998 And cboMonPago.ItemData(cboMonPago.ListIndex) = 13) Then
        cboRefMerUSDCLP.Enabled = True
        cboRefMerMEXUSD.Enabled = False
        cboRefMerUSDCLP.Clear
        cboRefMerMEXUSD.Clear
        cboRefMerUSDCLP.AddItem "REFERENCIA"
        cboRefMerUSDCLP.ListIndex = 0
        cboRefMerMEXUSD.AddItem "NO APLICA"
        cboRefMerMEXUSD.ListIndex = 0

'' Código eliminado en homologacion desarrollador
''   If Modalidad.Text = "ENTREGA FISICA" Then
''      gModalidad = "E"
   Else
         
        cboRefMerUSDCLP.Enabled = True
        cboRefMerMEXUSD.Enabled = True
        cboRefMerUSDCLP.Clear
        cboRefMerMEXUSD.Clear
        cboRefMerUSDCLP.AddItem "REFERENCIA"
        cboRefMerUSDCLP.ListIndex = 0
        cboRefMerMEXUSD.AddItem "REFERENCIA"
        cboRefMerMEXUSD.ListIndex = 0

      End If
   End If
'ChkRefMer.Value = 1
'ChkRefMer.Enabled = True
End If
End Sub
'*********************PRD21657



Private Sub Modalidad_Click()
'ChkRefMer.Value = 0
'ChkRefMer.Enabled = True
End Sub

'********Modificacion 17-06-2011*************
Private Sub txt_Res_Mesa_Dist_LostFocus()
   txt_Res_Mesa_Dist_USD.Text = Format((txt_Res_Mesa_Dist.Text / gsBAC_DolarObs), "#,##0.00")
   Let bSwWriteResultadoClp = True
End Sub
Private Sub txt_Res_Mesa_Dist_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      If txt_Res_Mesa_Dist_USD.Enabled = True Then
         Let txt_Res_Mesa_Dist_USD.Text = Format((txt_Res_Mesa_Dist.Text / gsBAC_DolarObs), "#,##0.00")
         Call txt_Res_Mesa_Dist_USD.SetFocus
      End If
   End If
   Let bSwWriteResultadoClp = True
End Sub
'********************************************

Private Sub txt_Res_Mesa_Dist_USD_KeyPress(KeyAscii As Integer)
   Let bSwWriteResultadoUsd = True
End Sub
Private Sub txt_Res_Mesa_Dist_USD_LostFocus()
   Let bSwWriteResultadoUsd = True
End Sub


'Private Sub I_DireccionCalculo_Click()
'   If I_DireccionCalculo.ItemData(I_DireccionCalculo.ListIndex) = 0 Then
'      I_PrimerPago.Enabled = False
'      I_PenultimoPago.Enabled = False
'   Else
'      I_PrimerPago.Enabled = True
'      I_PenultimoPago.Enabled = True
'   End If
'End Sub

Private Sub D_Madurez_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      DigitoPenPago = False
      D_Generacion = "Generación Normal"
   End If

End Sub

Private Sub D_MedioPago_Click()
   If D_MedioPago.ListIndex >= 0 Then
      If Aplicar = "I" Then
         On Error Resume Next
         I_MedioPago.Text = D_MedioPago.Text
         On Error GoTo 0
      End If
   End If
End Sub

Private Sub D_MonPago_Click()
   If D_MonPago.ListIndex >= 0 Then
      Call CargaFPagoxMoneda(D_MedioPago, D_MonPago.ItemData(D_MonPago.ListIndex))
      If Aplicar = "I" Then
         On Error Resume Next
         I_MonPago.Text = D_MonPago.Text
         On Error GoTo 0
      End If
   End If
'*********************PRD21657
'RESETEO DE COMBOXES DERECHOS, RELACIONADOS CON REFERENCIAS DE MERCADO
Call Modalidades(D_ReferenciaUSDCLP, D_ReferenciaMEXUSD, D_Moneda, D_MonPago)
Call RefMer
End Sub

Private Sub D_Note_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub D_PenultimoPago_GotFocus()

   If D_PenultimoPago.Enabled = False Then
      DoEvents 'no sacar, evita problema de congelamiento de sistema
      D_Madurez.SetFocus
      DoEvents 'no sacar, evita problema de congelamiento de sistema
   End If
   
End Sub

Private Sub D_PenultimoPago_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      DigitoPenPago = True
      D_Generacion = "Generación Hacia Atras"
      
      Call GeneraFecha(Derecho, [Fecha PrimerPago], CDate(D_PenultimoPago.Text), D_PrimerPago, True)
   End If
End Sub

Private Sub D_PrimerPago_Change()
   DigitoPenPago = False
   D_Generacion = "Generación Normal"
   If Aplicar = "I" Then
      I_PrimerPago.Text = D_PrimerPago.Text
   End If
End Sub

Private Sub D_PrimerPago_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      DigitoPenPago = False
      D_Generacion = "Generación Normal"
   End If
End Sub

Private Sub D_Spread_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      SendKeys "{TAB}"
   End If


End Sub

Private Sub D_Spread_LostFocus()

   D_Tasa = D_UltimoIndice.Text
   D_Spre = D_Spread.Text
   I_Tasa = I_UltimoIndice.Text
   I_Spre = I_Spread.Text

   'JBH, 17-12-2009
   'Si se modifica el valor de D_Spread, replicarlo también en D_Spread_Tran
   D_Spread_Tran.Text = D_Spread.Text
   'fin JBH

   If Aplicar = "I" Then
      If I_Spread.Visible = True Then
         I_Spread.Text = D_Spread.Text
         I_UltimoIndice.Text = D_UltimoIndice.Text
      End If
   End If
   
   Call Carga_Tasa_Grilla(D_Tasa, D_Spre, D_Grid, Derecho)
   Call Carga_Tasa_Grilla(I_Tasa, I_Spre, I_Grid, Izquierdo)
   
End Sub


Private Sub D_Spread_Tran_Change()

    If Aplicar = "I" Then
      If I_Spread_Tran.Visible = True Then
         I_Spread_Tran.Text = D_Spread_Tran.Text
      End If
    End If

End Sub

Private Sub D_Spread_Tran_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      SendKeys "{TAB}"
   End If

End Sub

Private Sub D_Spread_Tran_LostFocus()

   D_Tasa = D_Indice_Tran.Text
   D_Spre = D_Spread_Tran.Text
   I_Tasa = I_Indice_Tran.Text
   I_Spre = I_Spread_Tran.Text

   If Aplicar = "I" Then
      If I_Spread_Tran.Visible = True Then
         I_Spread_Tran.Text = D_Spread_Tran.Text
         I_Indice_Tran.Text = D_Indice_Tran.Text
      End If
   End If
   
   Call Carga_Tasa_Grilla(D_Tasa, D_Spre, D_Grid_Tran, Der_Tran)
   Call Carga_Tasa_Grilla(I_Tasa, I_Spre, I_Grid_Tran, Izq_Tran)

End Sub


Private Sub D_UltimoIndice_KeyPress(KeyAscii As Integer)

'  Se cambia todo al evento LostFocus para mejorar rendimiento de tiempo

''''   D_Tasa = D_UltimoIndice.Text
''''   D_Spre = D_Spread.Text
''''   I_Tasa = I_UltimoIndice.Text
''''   I_Spre = I_Spread.Text
''''
''''   If Aplicar = "I" And I_Indicador.Text <> "ICP" Then
''''     I_UltimoIndice.Text = D_UltimoIndice.Text
''''   End If
''''
''''   Call Carga_Tasa_Grilla(D_Tasa, D_Spre, D_Grid, Derecho)
''''   Call Carga_Tasa_Grilla(I_Tasa, I_Spre, I_Grid, Izquierdo)
   
   If D_Indicador.Text <> "Fija" Then
      D_Indice_Tran.Text = D_UltimoIndice.Text
   End If
   
''''   If KeyAscii = vbKeyReturn Then
''''      SendKeys "{TAB}"
''''      KeyAscii = 0
''''      Exit Sub
''''   End If

End Sub

Private Sub D_UltimoIndice_LostFocus()


   D_Tasa = D_UltimoIndice.Text
   D_Spre = D_Spread.Text
   I_Tasa = I_UltimoIndice.Text
   I_Spre = I_Spread.Text

   'JBH, 17-12-2009
   'Si se modificó el valor de D_UltimoIndice, repetirlo en D_Indice_Tran
   D_Indice_Tran.Text = D_UltimoIndice.Text
   'fin JBH

   If Aplicar = "I" And I_Indicador.Text = D_Indicador.Text Then 'I_Indicador.Text <> "ICP" Then
     I_UltimoIndice.Text = D_UltimoIndice.Text
   End If
   
   Call Carga_Tasa_Grilla(I_Tasa, I_Spre, I_Grid, Lados.Izquierdo)
   Call Carga_Tasa_Grilla(D_Tasa, D_Spre, D_Grid, Lados.Derecho)
End Sub


Private Sub Form_Activate()
   Me.Tag = ""
   If SwapModificacion <> 0 Then
      Me.Tag = SwapModificacion
      Call CargarCampos(SwapModificacion)
   End If
   If MiObjSwap.FormIsLoaded("FRM_MNT_NETEO_SWAP") = False Then
      FRM_MNT_NETEO_SWAP.Show
   End If
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
     ' SendKeys "{TAB}"
   End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Set MiObjSwap = Nothing
   Set Referencias = Nothing '**************PRD21657
   Unload FRM_MNT_NETEO_SWAP
End Sub

Private Sub I_CmbInterNoc_Click()
'CER 07/07/2008  - Flexibilización Intercambio Nocionales
Dim cuenta As Long

    If I_CmbInterNoc.ListIndex <> -1 Then
    
        If I_CmbInterNoc.ItemData(I_CmbInterNoc.ListIndex) <> -1 Then
            I_Grid.TextMatrix(I_Grid.Row, 19) = I_CmbInterNoc
            ''I_Grid.TextMatrix(I_Grid.Row,19) = I_CmbInterNoc.ItemData(I_CmbInterNoc.ListIndex)
            I_CmbInterNoc.Visible = False
            I_Grid.SetFocus
        End If
        
        
      If Aplicar = "D" Then
         If D_Grid.Rows = I_Grid.Rows Then
            D_Grid.RowSel = I_Grid.RowSel
            D_Grid.TextMatrix(I_Grid.RowSel, I_Grid.ColSel) = I_CmbInterNoc.Text
         Else
            For cuenta = 1 To D_Grid.Rows - 1
         
                If D_Grid.TextMatrix(cuenta, 1) = I_Grid.TextMatrix(I_Grid.RowSel, 1) Then
                    D_Grid.TextMatrix(cuenta, 19) = I_CmbInterNoc.Text
                End If
            
            Next
         End If
      End If

            
    End If

End Sub

Private Sub I_CmbInterNoc_GotFocus()
  I_CmbInterNoc.BackColor = vbWhite
  I_CmbInterNoc.ForeColor = vbBlack
  SendKeys ("%{Down}")
End Sub


Private Sub I_CmbInterNoc_KeyPress(KeyAscii As Integer)
'CER 07/07/2008  - Flexibilización Intercambio Nocionales
 If KeyAscii = 13 Then
    I_Grid.TextMatrix(I_Grid.Row, 19) = I_CmbInterNoc
    I_CmbInterNoc.Visible = False
    I_Grid.SetFocus
    
     If Aplicar = "D" Then
         If D_Grid.Rows = I_Grid.Rows Then
            D_Grid.RowSel = I_Grid.RowSel
            D_Grid.TextMatrix(I_Grid.RowSel, I_Grid.ColSel) = I_CmbInterNoc.Text
         End If
     End If
 End If

End Sub

Private Sub I_Convencion_Click()
   If I_Grid.Rows > 1 Then
      Call AplicarValidacionFeriados(Izquierdo, I_Grid)
     'Call AplicarValidacionFeriados("I", I_Grid)
      
      Call CalculoInteresBonos(Izquierdo, I_Grid)
     'Call CalculoInteresBonos("I", I_Grid)
   End If
End Sub

Private Sub I_DiasReset_Change()
 '  If I_DiasReset.Text > 0 Then
 ' Si cambian los dias reset debe aparecer siempre la fecha fixing
      I_Grid.ColWidth(16) = 1500
      'If SwCargaExcel = 1 Then
      '   If MsgBox("¿Ajusta Fecha Fixing Pierna Recibe?", vbQuestion + vbYesNo) = vbNo Then
      '     Screen.MousePointer = vbDefault
      '     Exit Sub
      '   Else
      '     Call AplicarValidacionFeriadosExcel("I", I_Grid, 2)
      '   End If
      'End If MAP 20080515 se decomenta código
  ' End If  'MAP 20080515 se decomenta IF
  If I_Grid.Rows > 1 Then
    MsgBox "Hacer clic en botón Calc. Fixing para aplicar", vbInformation
    CmdCalculaFixing.SetFocus
  End If
End Sub

Private Sub I_DiasReset_KeyDown(KeyCode As Integer, Shift As Integer)
 '  If I_Grid.Rows > 1 And KeyCode = vbKeyReturn Then
 '     Call AplicarValidacionFeriados("I", I_Grid)
 '     Call CalculoInteresBonos("I", I_Grid)
 '  End If  'MAP 20080515

End Sub

Private Sub I_DiasReset_LostFocus()
'   If I_Grid.Rows > 1 Then
'      Call AplicarValidacionFeriados("I", I_Grid)
'      Call CalculoInteresBonos("I", I_Grid)
'   End If
'   MAP 20080515
'   Call CmdCalculaFixing_Click
End Sub

Private Sub I_Fecha_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim CHI     As Boolean
   Dim USA     As Boolean
   Dim ENG     As Boolean
   Dim MiLado  As Lados

   MiLado = Izquierdo
   
   If KeyCode = vbKeyReturn Then
      If D_Grid.ColSel = 1 Then
         CHI = IIf(MiLado = Izquierdo, I_FERIADOCHK(0).Value, D_FERIADOCHK(0).Value)
         USA = IIf(MiLado = Izquierdo, I_FERIADOCHK(1).Value, D_FERIADOCHK(1).Value)
         ENG = IIf(MiLado = Izquierdo, I_FERIADOCHK(2).Value, D_FERIADOCHK(2).Value)
      End If
      
      If D_Grid.ColSel = 14 Then
         CHI = IIf(MiLado = Izquierdo, I_FERIADOCHK(3).Value, D_FERIADOCHK(3).Value)
         USA = IIf(MiLado = Izquierdo, I_FERIADOCHK(4).Value, D_FERIADOCHK(4).Value)
         ENG = IIf(MiLado = Izquierdo, I_FERIADOCHK(5).Value, D_FERIADOCHK(5).Value)
      End If
      
      If CHI = True And MiDiaHabil(I_Fecha.Text, Chile) = False Then
         MsgBox "Aviso." & vbCrLf & "Día seleccionado no es hábil para el calendario Chileno.", vbExclamation, TITSISTEMA
         Exit Sub
      End If
      
      If USA = True And MiDiaHabil(I_Fecha.Text, EstadosUnidos) = False Then
         MsgBox "Aviso." & vbCrLf & "Día seleccionado no es hábil para el calendario Estadounidense.", vbExclamation, TITSISTEMA
         Exit Sub
      End If
      
      If ENG = True And MiDiaHabil(I_Fecha.Text, Inglaterra) = False Then
         MsgBox "Aviso." & vbCrLf & "Día seleccionado no es hábil para el calendario Ingles.", vbExclamation, TITSISTEMA
         Exit Sub
      End If
      
      I_Grid.TextMatrix(I_Grid.RowSel, I_Grid.ColSel) = I_Fecha.Text
      I_Grid_Tran.TextMatrix(I_Grid.RowSel, I_Grid.ColSel) = I_Fecha.Text '--> Adrian 09-12-2009

      If I_Grid.ColSel = 1 Then
         If I_Grid.RowSel < (I_Grid.Rows - 1) Then
            I_Grid.TextMatrix(I_Grid.RowSel + 1, 16) = Format(ReCalculaDiasFeridos(Izquierdo, I_Fecha.Text, True, True), "dd/mm/yyyy")
            I_Grid_Tran.TextMatrix(I_Grid.RowSel + 1, 16) = Format(ReCalculaDiasFeridos(Izq_Tran, I_Fecha.Text, True, True), "dd/mm/yyyy")  '--> Adrian 09-12-2009
         End If
         
         Call CalculoInteresBonos(Izquierdo, I_Grid)
         DoEvents
         DoEvents
         DoEvents
         Call CalculoInteresBonos(Izq_Tran, I_Grid_Tran)
         DoEvents
         DoEvents
         DoEvents
      End If

      I_Grid.Tag = "Fechas Modificadas"
      I_Grid.Enabled = True
      I_Fecha.Visible = False
      
      I_Grid.SetFocus
   End If
   
   ' CER 23/07/2008 - Se agrega condición para que cuando  se modifique fecha vcto.
   ' en la pata que se encuentre chequeada la opción Aplicar al Lado Contrario,
   ' se actualice automáticamente fech vcto. correspondiente al mismo flujo en lado
   ' contrario
   
   If Aplicar = "D" Then
       D_Grid.RowSel = I_Grid.RowSel
       D_Grid.TextMatrix(I_Grid.RowSel, I_Grid.ColSel) = I_Fecha.Text
       D_Grid_Tran.RowSel = I_Grid.RowSel
       D_Grid_Tran.TextMatrix(I_Grid.RowSel, I_Grid.ColSel) = I_Fecha.Text
       
       Call CalculoInteresBonos(Derecho, D_Grid)
       Call CalculoInteresBonos(Der_Tran, D_Grid_Tran)
   End If

   If KeyCode = vbKeyEscape Then
      I_Grid.Enabled = True
      I_Fecha.Visible = False
      I_Grid.SetFocus
   End If
   
   I_FERIADOS_F.Enabled = I_Grid.Enabled
   I_FERIADOS_L.Enabled = I_Grid.Enabled
End Sub


Private Sub D_FechaEfectiva_Change()
   DigitoPenPago = False
   D_Generacion = "Generación Normal"
   If Aplicar = "I" Then
      I_FechaEfectiva.Text = D_FechaEfectiva.Text
   End If
End Sub

Private Sub I_FechaEfectiva_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call GeneraFecha(Izquierdo, [Fecha PrimerPago], CDate(I_FechaEfectiva.Text), I_PrimerPago)
      Call GeneraFecha(Izquierdo, [Fecha Madurez], CDate(I_FechaEfectiva.Text), I_Madurez)
      Call GeneraFecha(Izquierdo, [Fecha PenultimoPago], CDate(I_Madurez.Text), I_PenultimoPago)
     ' I_PrimerPago.Text = SugerirFechaPrimerVcto("I", I_FechaEfectiva.Text)
     ' I_PenultimoPago.Text = SugerirFechaPrimerVcto("I", I_PrimerPago.Text)
     ' I_Madurez.Text = SugerirFechaPrimerVcto("I", I_PenultimoPago.Text)
   End If
End Sub


Private Sub I_FechaEfectiva_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      DigitoPenPago = False
      D_Generacion = "Generación Normal"
   End If
End Sub

Private Sub I_FERIADOCHK_Click(Index As Integer)
   If I_Grid.Rows > 1 Then
      Call AplicarValidacionFeriados(Izquierdo, I_Grid)
      Call AplicarValidacionFeriados(Izq_Tran, I_Grid_Tran)
     'Call AplicarValidacionFeriados("I", I_Grid)
      
      Call CalculoInteresBonos(Izquierdo, I_Grid)
      Call CalculoInteresBonos(Izq_Tran, I_Grid_Tran)
     'Call CalculoInteresBonos("I", I_Grid)
   End If
   
  ' 07/08/2008 - Si se encuentra marcado check "Aplicar al Lado Contrario" respectivamente
  ' esto debe ser replicado en la pata contraria, de lo contrario debe actualizar solo el
  ' que se está marcando.
  
  If Aplicar = "D" Then
     D_FERIADOCHK(0).Value = I_FERIADOCHK(0).Value
     D_FERIADOCHK(1).Value = I_FERIADOCHK(1).Value
     D_FERIADOCHK(2).Value = I_FERIADOCHK(2).Value
     D_FERIADOCHK(3).Value = I_FERIADOCHK(3).Value
     D_FERIADOCHK(4).Value = I_FERIADOCHK(4).Value
     D_FERIADOCHK(5).Value = I_FERIADOCHK(5).Value
  End If
   
    If Index = 4 Or Index = 5 Then
        Call DiaRef(MiObjSwap.A100_ReferenciaUSDCLP, I_PrimerPago.Text)
        Call DiaRef(MiObjSwap.A101_ReferenciaMEXUSD, I_PrimerPago.Text)
        Call DiaRef(MiObjSwap.A104_ReferenciaUSDCLP, I_PrimerPago.Text)
        Call DiaRef(MiObjSwap.A105_ReferenciaMEXUSD, I_PrimerPago.Text)
    End If

End Sub

Private Sub D_FERIADOCHK_Click(Index As Integer)
   If D_Grid.Rows > 1 Then
      Call AplicarValidacionFeriados(Derecho, D_Grid)
      Call AplicarValidacionFeriados(Der_Tran, D_Grid_Tran)
      
     'Call AplicarValidacionFeriados("D", D_Grid)
     
      Call CalculoInteresBonos(Derecho, D_Grid)
      Call CalculoInteresBonos(Der_Tran, D_Grid_Tran)
     'Call CalculoInteresBonos("D", D_Grid)
   End If
   
  ' 07/08/2008 - Si se encuentra marcado check "Aplicar al Lado Contrario" respectivamente
  ' esto debe ser replicado en la pata contraria, de lo contrario debe actualizar solo el
  ' que se está marcando.
  If Aplicar = "I" Then
     I_FERIADOCHK(0).Value = D_FERIADOCHK(0).Value
     I_FERIADOCHK(1).Value = D_FERIADOCHK(1).Value
     I_FERIADOCHK(2).Value = D_FERIADOCHK(2).Value
     I_FERIADOCHK(3).Value = D_FERIADOCHK(3).Value
     I_FERIADOCHK(4).Value = D_FERIADOCHK(4).Value
     I_FERIADOCHK(5).Value = D_FERIADOCHK(5).Value
  End If
   
End Sub

Private Sub D_FrecuenciaCapital_Click()
   Call GeneraFecha(Derecho, [Fecha Efectiva], CDate(gsBAC_Fecp), D_FechaEfectiva)
   Call GeneraFecha(Derecho, [Fecha PrimerPago], CDate(D_FechaEfectiva.Text), D_PrimerPago)
   Call GeneraFecha(Derecho, [Fecha Madurez], CDate(D_FechaEfectiva.Text), D_Madurez)
   Call GeneraFecha(Derecho, [Fecha PenultimoPago], CDate(D_Madurez.Text), D_PenultimoPago)
   'D_PrimerPago.Text = SugerirFechaPrimerVcto("D", D_FechaEfectiva.Text)
   'D_PenultimoPago.Text = SugerirFechaPrimerVcto("D", D_PrimerPago.Text)
   'D_Madurez.Text = SugerirFechaPrimerVcto("D", D_PenultimoPago.Text)

   If Aplicar = "I" Then
      On Error Resume Next
      I_FrecuenciaCapital.ListIndex = D_FrecuenciaCapital.ListIndex
      On Error GoTo 0
   End If
End Sub

Private Sub D_Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyReturn Then
      
      If (D_Grid.ColSel = 1) Or (D_Grid.ColSel = 14) Then
         Call Alineacion(D_Grid, D_Fecha)
         D_FERIADOS_F.Enabled = Not D_Fecha.Enabled
         D_FERIADOS_L.Enabled = Not D_Fecha.Enabled
      End If
      
      If D_FrecuenciaCapital.ItemData(D_FrecuenciaCapital.ListIndex) = -1 Then
         If D_Grid.ColSel = 2 Then
            Select Case D_NemMon.Caption
               Case "CLP": D_Numero.CantidadDecimales = 0
               Case "UF": D_Numero.CantidadDecimales = 4
               Case Else: D_Numero.CantidadDecimales = DecAmortizacion
            End Select
            Call Alineacion(D_Grid, D_Numero)
            D_Numero.SetFocus
         End If
      End If
      
   End If
End Sub

Private Sub I_Grid_Click()
'CER 07/07/2008  - Flexibilización Intercambio Nocionales
 If SwCargaExcel = 0 Then
    If I_Grid.Col = 19 Then
      I_CmbInterNoc.Top = I_Grid.Top + I_Grid.CellTop
      I_CmbInterNoc.Left = I_Grid.Left + I_Grid.CellLeft
      I_CmbInterNoc.Width = I_Grid.CellWidth
      I_CmbInterNoc.Visible = True
      I_CmbInterNoc.SetFocus
      
   Else
      I_CmbInterNoc.Visible = False
   
   End If
   
 End If

End Sub

Private Sub I_Grid_GotFocus()
   Me.KeyPreview = False
End Sub

Private Sub I_Grid_KeyPress(KeyAscii As Integer)
 If SwCargaExcel = 0 Then
    If I_Grid.Col = 19 Then
      I_CmbInterNoc.Top = I_Grid.Top + I_Grid.CellTop
      I_CmbInterNoc.Left = I_Grid.Left + I_Grid.CellLeft
      I_CmbInterNoc.Width = I_Grid.CellWidth
      I_CmbInterNoc.Visible = True
      I_CmbInterNoc.SetFocus
   End If
 End If

End Sub

Private Sub I_Grid_LostFocus()
  'Me.KeyPreview = True
End Sub

Private Sub D_Grid_GotFocus()
   Me.KeyPreview = False
End Sub

Private Sub D_Grid_LostFocus()
  'Me.KeyPreview = True
End Sub

Private Sub I_Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyReturn Then
      If (I_Grid.ColSel = 1) Or (I_Grid.ColSel = 14) Then
         Call Alineacion(I_Grid, I_Fecha)
         I_FERIADOS_F.Enabled = Not I_Fecha.Enabled
         I_FERIADOS_L.Enabled = Not I_Fecha.Enabled
      End If
      
      If I_FrecuenciaCapital.ItemData(I_FrecuenciaCapital.ListIndex) = -1 Then
         If I_Grid.ColSel = 2 Then
            Select Case I_NemMon.Caption
               Case "CLP": I_Numero.CantidadDecimales = 0
               Case "UF": I_Numero.CantidadDecimales = 4
               Case Else: I_Numero.CantidadDecimales = DecAmortizacion
            End Select
            Call Alineacion(I_Grid, I_Numero)
            I_Numero.SetFocus
         End If
      End If
      
   End If
End Sub

Private Sub D_Madurez_Change()
   DigitoPenPago = False
   D_Generacion.Caption = "Generación Normal"
   If Aplicar = "I" Then
      I_Madurez.Text = D_Madurez.Text
   End If
End Sub

Private Sub D_Nocionales_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call Conversion(False)
   End If
End Sub

Private Sub D_ValorMoneda_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call Conversion(False)
   End If
End Sub

Private Sub Form_Load()
   Icon = BACSwap.Icon
   Me.Top = 0: Me.Left = 0
   
   NunDecimales.ListIndex = 1
   Me.NumDecTasa.ListIndex = 1
   
   DecAmortizacion = Val(NunDecimales.Text)
   AplicarFormatoExt = "#,##0." & String(DecAmortizacion, "0")

   Call LeerMonedasSistemas(I_Moneda)
      Call LeerMonedasSistemas(D_Moneda)

   Call LeerMonedasSistemas(I_MonPago)
      Call LeerMonedasSistemas(D_MonPago)

   Call LlenaComboAmortiza(I_FrecuenciaPago, 1044, "PCS"):
      Call LlenaComboAmortiza(D_FrecuenciaPago, 1044, "PCS")
   
   Call LlenaComboAmortiza(I_FrecuenciaCapital, 1043, "PCS")
      Call LlenaComboAmortiza(D_FrecuenciaCapital, 1043, "PCS")

   Call CargaBases(I_ConteoDias)
   Call CargaBases(D_ConteoDias)

   Modalidad.Clear
   Modalidad.AddItem "ENTREGA FISICA"
   Modalidad.AddItem "COMPENSACION"
   Modalidad.Text = "ENTREGA FISICA"

   Call Limpiar
   Call LeerReferencias(D_ReferenciaUSDCLP, 1) '**********PRD_21657_14-04-2015
   Call DefineTitulos

   I_Convencion.AddItem "Siguiente":            I_Convencion.ItemData(I_Convencion.NewIndex) = 1
   I_Convencion.AddItem "Anterior":             I_Convencion.ItemData(I_Convencion.NewIndex) = -1
   I_Convencion.AddItem "Siguiente Modificado": I_Convencion.ItemData(I_Convencion.NewIndex) = 2
   I_Convencion.AddItem "Anterior  Modificado": I_Convencion.ItemData(I_Convencion.NewIndex) = -2
   I_Convencion.ListIndex = 2

   D_Convencion.AddItem "Siguiente":            D_Convencion.ItemData(D_Convencion.NewIndex) = 1
   D_Convencion.AddItem "Anterior":             D_Convencion.ItemData(D_Convencion.NewIndex) = -1
   D_Convencion.AddItem "Siguiente Modificado": D_Convencion.ItemData(D_Convencion.NewIndex) = 2
   D_Convencion.AddItem "Anterior  Modificado": D_Convencion.ItemData(D_Convencion.NewIndex) = -2
   D_Convencion.ListIndex = 2
   
   Call LeeModoControlPT    'Modo de Operación del Control de Precios y Tasas
'Call Limpiar
       'Call RefMer
   
End Sub



Private Sub I_ConteoDias_Click()
   If Aplicar = "D" Then
      On Error Resume Next
      D_ConteoDias.ListIndex = I_ConteoDias.ListIndex
      On Error GoTo 0
   End If
End Sub

Private Sub D_ConteoDias_Click()
   If Aplicar = "I" Then
      On Error Resume Next
      I_ConteoDias.ListIndex = D_ConteoDias.ListIndex
      On Error GoTo 0
   End If
End Sub

Private Sub I_FechaEfectiva_Change()
   DigitoPenPago = False
   I_Generacion.Caption = "Generación Normal"

   If Aplicar = "D" Then
      D_FechaEfectiva.Text = I_FechaEfectiva.Text
   End If
End Sub

Private Sub I_FrecuenciaCapital_Click()
   Call GeneraFecha(Izquierdo, [Fecha Efectiva], CDate(gsBAC_Fecp), I_FechaEfectiva)
   Call GeneraFecha(Izquierdo, [Fecha PrimerPago], CDate(I_FechaEfectiva.Text), I_PrimerPago)
   Call GeneraFecha(Izquierdo, [Fecha Madurez], CDate(I_FechaEfectiva.Text), I_Madurez)
   Call GeneraFecha(Izquierdo, [Fecha PenultimoPago], CDate(I_Madurez.Text), I_PenultimoPago)

   'I_PrimerPago.Text = SugerirFechaPrimerVcto("I", I_FechaEfectiva.Text)
   'I_PenultimoPago.Text = SugerirFechaPrimerVcto("I", I_PrimerPago.Text)
   'I_Madurez.Text = SugerirFechaPrimerVcto("I", I_PenultimoPago.Text)

   If Aplicar = "D" Then
      On Error Resume Next
      D_FrecuenciaCapital.ListIndex = I_FrecuenciaCapital.ListIndex
      On Error GoTo 0
   End If
End Sub

Private Sub I_FrecuenciaPago_Click()
   Call GeneraFecha(Izquierdo, [Fecha Efectiva], CDate(gsBAC_Fecp), I_FechaEfectiva)
   Call GeneraFecha(Izquierdo, [Fecha PrimerPago], CDate(I_FechaEfectiva.Text), I_PrimerPago)
   Call GeneraFecha(Izquierdo, [Fecha Madurez], CDate(I_FechaEfectiva.Text), I_Madurez)
   Call GeneraFecha(Izquierdo, [Fecha PenultimoPago], CDate(I_Madurez.Text), I_PenultimoPago)
      
  'I_PrimerPago.Text = SugerirFechaPrimerVcto("I", I_FechaEfectiva.Text)
  'I_PenultimoPago.Text = SugerirFechaPrimerVcto("I", I_PrimerPago.Text)
  'I_Madurez.Text = SugerirFechaPrimerVcto("I", I_PenultimoPago.Text)

   If I_FrecuenciaPago.ListIndex > -1 And I_Moneda.ListIndex > -1 Then
      Call CargaTasaMoneda(I_Indicador, I_Moneda.ItemData(I_Moneda.ListIndex), 0, Val(Right(I_FrecuenciaPago.Text, 5)))
   End If
   If Aplicar = "D" Then
      On Error Resume Next
      D_FrecuenciaPago.ListIndex = I_FrecuenciaPago.ListIndex
      On Error GoTo 0
   End If
End Sub

Private Sub D_FrecuenciaPago_Click()
   Call GeneraFecha(Derecho, [Fecha Efectiva], CDate(gsBAC_Fecp), D_FechaEfectiva)
   Call GeneraFecha(Derecho, [Fecha PrimerPago], CDate(D_FechaEfectiva.Text), D_PrimerPago)
   Call GeneraFecha(Derecho, [Fecha Madurez], CDate(D_FechaEfectiva.Text), D_Madurez)
   Call GeneraFecha(Derecho, [Fecha PenultimoPago], CDate(D_Madurez.Text), D_PenultimoPago)
   'D_PrimerPago.Text = SugerirFechaPrimerVcto("D", D_FechaEfectiva.Text)
   'D_PenultimoPago.Text = SugerirFechaPrimerVcto("D", D_PrimerPago.Text)
   'D_Madurez.Text = SugerirFechaPrimerVcto("D", D_PenultimoPago.Text)

   If D_FrecuenciaPago.ListIndex > -1 And D_Moneda.ListIndex > -1 Then
      Call CargaTasaMoneda(D_Indicador, D_Moneda.ItemData(D_Moneda.ListIndex), 0, Val(Right(D_FrecuenciaPago.Text, 5)))
   End If
   If Aplicar = "I" Then
      On Error Resume Next
      I_FrecuenciaPago.ListIndex = D_FrecuenciaPago.ListIndex
      On Error GoTo 0
   End If
End Sub

Private Sub I_Grid_Scroll()
    I_CmbInterNoc.Visible = False
End Sub

Private Sub I_HabilitaFecha_Click(Index As Integer)
   Dim iValor As Boolean
   iValor = I_HabilitaFecha(Index).Value
   Select Case Index
      Case 0
         I_PrimerPago.Enabled = iValor
         I_FechaEfectiva.Enabled = Not iValor
      Case 1
         I_PrimerPago.Enabled = Not iValor
         I_PenultimoPago.Enabled = iValor
   End Select
End Sub

Private Sub D_HabilitaFecha_Click(Index As Integer)
   Dim iValor As Boolean
   iValor = D_HabilitaFecha(Index).Value
   Select Case Index
      Case 0
         D_PrimerPago.Enabled = iValor
         D_FechaEfectiva.Enabled = Not iValor
      Case 1
         D_PrimerPago.Enabled = Not iValor
         D_PenultimoPago.Enabled = iValor
   End Select
End Sub

Private Sub I_Indicador_Click()

   If UCase(I_Indicador.Text) Like "FIJA*" Then
      I_Identificador.Caption = "RECIBO FIJA"
      SSFlujos.TabCaption(0) = "DETALLE RECIBO FIJA"
            
      I_Indice_Tran.Enabled = True
            
      I_Spread_Tran.Enabled = False
      I_Spread_Tran.Visible = False
      I_Spread_Tran.Tag = I_Spread_Tran.Text
      I_Spread_Tran.Text = 0#
      Call I_Spread_Tran_KeyPress(vbKey0)
      
      I_Spread.Enabled = False
      I_Spread.Visible = False
      I_Spread.Tag = I_Spread.Text
      I_Spread.Text = 0#
      Call I_Spread_KeyPress(vbKey0)
      
      I_Etiquetas(5).Visible = False
      I_Etiquetas(28).Visible = False
      
      I_Etiquetas(4).Caption = "Tasa"
      I_Etiquetas(29).Caption = "Tasa Tranfer."

      I_DiasReset.Text = 0
      I_DiasReset.Enabled = False
      
      If I_Grid.Rows > 2 Then
         I_Grid.ColWidth(16) = 0 '1450
      End If
   Else
      I_Identificador.Caption = "RECIBO VARIABLE"
      SSFlujos.TabCaption(0) = "DETALLE RECIBO VARIABLE"
     
      I_Indice_Tran.Text = I_UltimoIndice.Text
      I_Indice_Tran.Enabled = False

      I_Spread_Tran.Visible = True
      I_Spread_Tran.Enabled = True
      I_Spread_Tran.Text = I_Spread_Tran.Tag
      Call I_Spread_Tran_KeyPress(vbKeyReturn)
      
      I_Spread.Enabled = True
      I_Spread.Visible = True
      I_Spread.Text = I_Spread.Tag
      Call I_Spread_Tran_KeyPress(vbKeyReturn)
      
      I_DiasReset.Text = 2
      I_DiasReset.Enabled = True
      
      I_Etiquetas(5).Visible = True
      I_Etiquetas(28).Visible = True
      
      I_Etiquetas(4).Caption = "Ultimo Indice"
      I_Etiquetas(29).Caption = "Indice Tranfer."
      
      If I_Grid.Rows > 2 Then
         I_Grid.ColWidth(16) = 1450
      End If

   End If

   I_UltimoIndice.Enabled = True
   
   If I_Indicador.Text = "ICP" Then
      I_UltimoIndice.Text = ValorMoneda(ICP, gsBAC_Fecp)
      I_UltimoIndice.Text = iValorTasaCamaraPromedio(I_Moneda.ItemData(I_Moneda.ListIndex))
      I_UltimoIndice.Enabled = False
   End If
      
   'PRD18662
   If I_Indicador.Text = "IBR" Then
      I_UltimoIndice.Text = ValorMoneda(IBR, gsBAC_Fecp)
      I_UltimoIndice.Text = iValorTasaIBR(I_Moneda.ItemData(I_Moneda.ListIndex))
      I_UltimoIndice.Enabled = False
   End If

      
   If Aplicar = "D" Then
      On Error Resume Next
      D_Indicador.ListIndex = I_Indicador.ListIndex
      On Error GoTo 0
   End If
   
'********************PRD21657
If I_Moneda.ListIndex = D_Moneda.ListIndex And I_Indicador.Text <> "ICP" _
    And D_Indicador.Text <> "ICP" Then
        TypeSwap = 1
        Exit Sub
End If
If I_Indicador.Text = "ICP" Or D_Indicador.Text = "ICP" Then
        TypeSwap = 4
        Exit Sub
End If
If I_Moneda.ListIndex <> D_Moneda.ListIndex And I_Indicador.Text <> "ICP" _
    And D_Indicador.Text <> "ICP" Then
        TypeSwap = 2
        Exit Sub
End If
'********************PRD21657
   
End Sub

Private Sub D_Indicador_Click()

   If UCase(D_Indicador.Text) Like "FIJA*" Then
      D_Identificador.Caption = "PAGO FIJA"
      SSFlujos.TabCaption(1) = "DETALLE PAGO FIJA"

      D_Indice_Tran.Enabled = True
      
      D_Spread_Tran.Visible = False
      D_Spread_Tran.Enabled = False
      D_Spread_Tran.Tag = D_Spread_Tran.Text
      D_Spread_Tran.Text = 0#
      Call D_Spread_Tran_KeyPress(vbKey0)
      
      D_Spread.Enabled = False
      D_Spread.Visible = False
      D_Spread.Tag = D_Spread.Text
      D_Spread.Text = 0#
      Call D_Spread_KeyPress(vbKey0)
      
      I_Etiquetas(12).Visible = False
      I_Etiquetas(31).Visible = False
      
      I_Etiquetas(13).Caption = "Tasa"
      I_Etiquetas(30).Caption = "Tasa Transfer."

      D_DiasReset.Text = 0
      D_DiasReset.Enabled = False
      
      If D_Grid.Rows > 2 Then
         D_Grid.ColWidth(16) = 0 '1450
      End If
   Else
      D_Identificador.Caption = "PAGO VARIABLE"
      SSFlujos.TabCaption(1) = "DETALLE PAGO VARIABLE"

      D_Indice_Tran.Text = D_UltimoIndice.Text
      D_Indice_Tran.Enabled = False
      
      D_Spread_Tran.Visible = True
      D_Spread_Tran.Enabled = True
      D_Spread_Tran.Text = D_Spread_Tran.Tag
      Call D_Spread_Tran_KeyPress(vbKeyReturn)
      
      D_Spread.Enabled = True
      D_Spread.Visible = True
      D_Spread.Text = D_Spread.Tag
      Call D_Spread_KeyPress(vbKeyReturn)
      
      I_Etiquetas(12).Visible = True
      I_Etiquetas(31).Visible = True
      
      I_Etiquetas(13).Caption = "Ultimo Indice"
      I_Etiquetas(30).Caption = "Indice Transfer."
      
      D_DiasReset.Text = 2
      D_DiasReset.Enabled = True

      If D_Grid.Rows > 2 Then
         D_Grid.ColWidth(16) = 1450
      End If


   End If

   D_UltimoIndice.Enabled = True
   If D_Indicador.Text = "ICP" Then
      D_UltimoIndice.Text = ValorMoneda(ICP, gsBAC_Fecp)
      D_UltimoIndice.Text = iValorTasaCamaraPromedio(D_Moneda.ItemData(D_Moneda.ListIndex))
      D_UltimoIndice.Enabled = False
   End If

   'PRD18662
   If D_Indicador.Text = "IBR" Then
      D_UltimoIndice.Text = ValorMoneda(IBR, gsBAC_Fecp)
      D_UltimoIndice.Text = iValorTasaIBR(D_Moneda.ItemData(D_Moneda.ListIndex))
      D_UltimoIndice.Enabled = False
   End If

   If Aplicar = "I" Then
      On Error Resume Next
      I_Indicador.ListIndex = D_Indicador.ListIndex
      On Error GoTo 0
   End If
End Sub

Private Function RetornaValMoneda(mncodmon As Integer, objeto As TXTNumero)
   Dim Moneda  As New ClsMoneda

   Call Moneda.LeerxCodigo(mncodmon)
   RetornaValMoneda = IIf(mncodmon = 13, gsBAC_DolarObs, Moneda.vmValor)
   objeto.CantidadDecimales = IIf(mncodmon = 999, 0, 4)

   objeto.Enabled = True
   If (mncodmon = 13) Or (mncodmon = 997) Or (mncodmon = 998) Or (mncodmon = 999) Then
      objeto.Enabled = False
   End If
   If (Moneda.mnmx = "C" And Moneda.mnnemo <> "USD") Then
      RetornaValMoneda = Format(CDbl(EntregaParidadBCCH(Moneda.mnnemo)), TipoFormato(Moneda.mnnemo))
   End If

   Set Moneda = Nothing
End Function

Private Sub I_Indice_Tran_Change()

   If Aplicar = "D" And D_Indicador.Text = I_Indicador.Text Then 'D_Indicador.Text <> "ICP" Then
      D_Indice_Tran.Text = I_Indice_Tran.Text
   End If
End Sub

Private Sub I_Indice_Tran_LostFocus()
   
   I_Tasa = I_Indice_Tran.Text
   I_Spre = I_Spread_Tran.Text
   D_Tasa = D_Indice_Tran.Text
   D_Spre = D_Spread_Tran.Text
   
   If Aplicar = "D" And D_Indicador.Text = I_Indicador.Text Then 'D_Indicador.Text <> "ICP" Then
      D_Indice_Tran.Text = I_Indice_Tran.Text
   End If
   
   Call Carga_Tasa_Grilla(D_Tasa, D_Spre, D_Grid_Tran, Lados.Der_Tran)
   Call Carga_Tasa_Grilla(I_Tasa, I_Spre, I_Grid_Tran, Lados.Izq_Tran)

End Sub


Private Sub I_Madurez_Change()
   DigitoPenPago = False
   I_Generacion = "Generación Normal"
   If Aplicar = "D" Then
      D_Madurez.Text = I_Madurez.Text
   End If
End Sub

Private Sub I_Madurez_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      DigitoPenPago = False
      D_Generacion = "Generación Normal"
   End If
End Sub

Private Sub I_MedioPago_Click()
   If I_MedioPago.ListIndex >= 0 Then
      If Aplicar = "D" Then
         On Error Resume Next
         D_MedioPago.Text = I_MedioPago.Text
         On Error GoTo 0
      End If
   End If
End Sub

Private Sub I_Moneda_Click()

   Dim A As Integer
   If I_Moneda.ListIndex = -1 Then
      Exit Sub
   End If
   If I_FrecuenciaPago.ListIndex > -1 And I_Moneda.ListIndex > -1 Then
      Call CargaTasaMoneda(I_Indicador, I_Moneda.ItemData(I_Moneda.ListIndex), 0, Val(Right(I_FrecuenciaPago.Text, 5)))
   End If

   I_NemMon.Caption = Trim(Right(I_Moneda.Text, 5))
   I_ValorMoneda.Text = RetornaValMoneda(I_Moneda.ItemData(I_Moneda.ListIndex), I_ValorMoneda)
   Call LeeMonedasPago(I_MonPago, I_Moneda.ItemData(I_Moneda.ListIndex))

   If Aplicar = "D" Then
      On Error Resume Next
      D_Moneda.Text = I_Moneda.Text
      On Error GoTo 0
   End If
   Call Conversion(True)
'*********************PRD21657
'RESETEO DE COMBOXES IZQUIERDOS, RELACIONADOS CON REFERENCIAS DE MERCADO

S = I_Moneda

Call Modalidades(I_ReferenciaUSDCLP, I_ReferenciaMEXUSD, I_Moneda, I_MonPago)
Call RefMer
End Sub

Private Sub D_Moneda_Click()
   If D_Moneda.ListIndex = -1 Then
      Exit Sub
   End If
   If D_FrecuenciaPago.ListIndex > -1 And D_Moneda.ListIndex > -1 Then
      Call CargaTasaMoneda(D_Indicador, D_Moneda.ItemData(D_Moneda.ListIndex), 0, Val(Right(D_FrecuenciaPago.Text, 5)))
   End If
   D_NemMon.Caption = Trim(Right(D_Moneda.Text, 5))
   D_ValorMoneda.Text = RetornaValMoneda(D_Moneda.ItemData(D_Moneda.ListIndex), D_ValorMoneda)
   Call LeeMonedasPago(D_MonPago, D_Moneda.ItemData(D_Moneda.ListIndex))

   If Aplicar = "I" Then
      On Error Resume Next
      I_Moneda.Text = D_Moneda.Text
      On Error GoTo 0
   End If
   Call Conversion(False)
'*********************PRD21657
'RESETEO DE COMBOXES DERECHOS, RELACIONADOS CON REFERENCIAS DE MERCADO
Call Modalidades(D_ReferenciaUSDCLP, D_ReferenciaMEXUSD, D_Moneda, D_MonPago)
Call RefMer
End Sub

Private Sub I_MonPago_Click()
   If I_MonPago.ListIndex >= 0 Then
      Call CargaFPagoxMoneda(I_MedioPago, I_MonPago.ItemData(I_MonPago.ListIndex))

      If Aplicar = "D" Then
         On Error Resume Next
         D_MonPago.Text = I_MonPago.Text
         On Error GoTo 0
      End If
   End If
'*********************PRD21657
'RESETEO DE COMBOXES IZQUIERDOS, RELACIONADOS CON REFERENCIAS DE MERCADO

Call Modalidades(I_ReferenciaUSDCLP, I_ReferenciaMEXUSD, I_Moneda, I_MonPago)
Call RefMer
End Sub

Private Sub I_Nocionales_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call Conversion(True)
   End If
End Sub

Private Sub I_Note_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub I_PenultimoPago_GotFocus()

   If I_PenultimoPago.Enabled = False Then
      DoEvents 'no sacar, evita problema de congelamiento de sistema
      I_Madurez.SetFocus
      DoEvents 'no sacar, evita problema de congelamiento de sistema
   End If

End Sub

Private Sub I_PenultimoPago_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      DigitoPenPago = True
      I_Generacion = "Generación Hacia Atras"
      
      Call GeneraFecha(Izquierdo, [Fecha PrimerPago], CDate(I_PenultimoPago.Text), I_PrimerPago, True)
   End If
End Sub

Private Sub I_PrimerPago_Change()
   DigitoPenPago = False
   I_Generacion = "Generación Normal"
   If Aplicar = "D" Then
      D_PrimerPago.Text = I_PrimerPago.Text
   End If
End Sub

Private Sub I_PrimerPago_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = vbKeyReturn Then
      DigitoPenPago = False
      D_Generacion = "Generación Normal"
   End If
  
End Sub

Private Sub I_Spread_Change()
   If Aplicar = "D" Then
      If D_Spread.Visible = True Then
         D_Spread.Text = I_Spread.Text
         I_Spread_Tran.Text = I_Spread.Text
      End If
   End If
End Sub

Private Sub D_Spread_Change()
 
    If Aplicar = "I" Then
      If I_Spread.Visible = True Then
         I_Spread.Text = D_Spread.Text
      End If
    End If
    If Aplicar = "D" Then
      If I_Spread.Visible = True Then
         D_Spread_Tran.Text = D_Spread.Text
      End If
    End If
   
End Sub

Private Sub I_Spread_KeyPress(KeyAscii As Integer)

   If KEYSCII = vbKeyReturn Then
      SendKeys "{TAB}"
   End If

End Sub

Private Sub I_Spread_LostFocus()

   I_Tasa = I_UltimoIndice.Text
   I_Spre = I_Spread.Text
   D_Tasa = D_UltimoIndice.Text
   D_Spre = D_Spread.Text

         
   If Aplicar = "D" Then
      If D_Spread.Visible = True Then
         D_Spread.Text = I_Spread.Text
         D_UltimoIndice.Text = I_UltimoIndice.Text
      End If
   End If
   
   Call Carga_Tasa_Grilla(I_Tasa, I_Spre, I_Grid, Derecho)
   Call Carga_Tasa_Grilla(D_Tasa, D_Spre, D_Grid, Izquierdo)


End Sub


Private Sub I_Spread_Tran_Change()
   
   If Aplicar = "D" Then
      If D_Spread_Tran.Visible = True Then
         D_Spread_Tran.Text = I_Spread_Tran.Text
      End If
   End If
   
End Sub

Private Sub I_Spread_Tran_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      SendKeys "{TAB}"
   End If

End Sub

Private Sub I_Spread_Tran_LostFocus()

  I_Tasa = I_Indice_Tran.Text
  I_Spre = I_Spread_Tran.Text
  D_Tasa = D_Indice_Tran.Text
  D_Spre = D_Spread_Tran.Text

   If Aplicar = "D" Then
      If D_Spread_Tran.Visible = True Then
         D_Spread_Tran.Text = I_Spread_Tran.Text
         D_Indice_Tran.Text = I_Indice_Tran.Text
      End If
   End If
   
   Call Carga_Tasa_Grilla(I_Tasa, I_Spre, I_Grid_Tran, Der_Tran)
   Call Carga_Tasa_Grilla(D_Tasa, D_Spre, D_Grid_Tran, Izq_Tran)

End Sub


Private Sub I_UltimoIndice_Change()
   
   If Aplicar = "D" And D_Indicador.Text = I_Indicador.Text Then 'D_Indicador.Text <> "ICP" Then
      D_UltimoIndice.Text = I_UltimoIndice.Text
   End If
   
   If I_Indicador.Text <> "Fija" Then
      I_Indice_Tran.Text = I_UltimoIndice.Text
   End If

End Sub

Private Sub d_UltimoIndice_Change()
   
   If Aplicar = "I" And I_Indicador.Text = D_Indicador.Text Then 'I_Indicador.Text <> "ICP" Then
      I_UltimoIndice.Text = D_UltimoIndice.Text
   End If
   
End Sub

Private Sub I_UltimoIndice_KeyPress(KeyAscii As Integer)
   
'se cambia todo al evento LostFocus por mejorar rendimiento de tiempo

''''   I_Tasa = I_UltimoIndice.Text
''''   I_Spre = I_Spread.Text
''''   D_Tasa = D_UltimoIndice.Text
''''   D_Spre = D_Spread.Text
''''
''''   If Aplicar = "D" And D_Indicador.Text <> "ICP" Then
''''      D_UltimoIndice.Text = I_UltimoIndice.Text
''''   End If
''''
''''   Call Carga_Tasa_Grilla(I_Tasa, I_Spre, I_Grid, Derecho)
''''   Call Carga_Tasa_Grilla(D_Tasa, D_Spre, D_Grid, Izquierdo)
 
   If I_Indicador.Text <> "FIJA" Then
      I_Indice_Tran.Text = I_UltimoIndice.Text
   End If
 
End Sub

Private Sub I_UltimoIndice_LostFocus()

   I_Tasa = I_UltimoIndice.Text
   I_Spre = I_Spread.Text
   D_Tasa = D_UltimoIndice.Text
   D_Spre = D_Spread.Text
   
   If Aplicar = "D" And D_Indicador.Text = I_Indicador.Text Then 'And D_Indicador.Text <> "ICP" Then
      D_UltimoIndice.Text = I_UltimoIndice.Text
   End If
   
   Call Carga_Tasa_Grilla(I_Tasa, I_Spre, I_Grid, Lados.Izquierdo)
   Call Carga_Tasa_Grilla(D_Tasa, D_Spre, D_Grid, Lados.Derecho)
End Sub


Private Sub I_ValorMoneda_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call Conversion(True)
   End If
End Sub

Private Sub TraspasoDatos(Origen, Desino As String)
   On Error Resume Next
   If (Origen = "I" And Desino = "D") Then
      D_Moneda.Text = I_Moneda.Text
      D_NemMon.Caption = I_NemMon.Caption
      D_Nocionales.Text = I_Nocionales.Text
      D_FrecuenciaPago.Text = I_FrecuenciaPago.Text
      D_FrecuenciaCapital.Text = I_FrecuenciaCapital.Text
      D_Indicador.Text = I_Indicador.Text
      D_UltimoIndice.Text = I_UltimoIndice.Text
      D_Indice_Tran.Text = I_Indice_Tran.Text
      D_Spread.Text = I_Spread.Text
      D_Spread_Tran.Text = I_Spread_Tran.Text
      D_ConteoDias.Text = I_ConteoDias.Text
      D_FechaEfectiva.Text = I_FechaEfectiva.Text
      D_Madurez.Text = I_Madurez.Text
      D_PrimerPago.Text = I_PrimerPago.Text
      D_PenultimoPago.Text = I_PenultimoPago.Text
      D_MonPago.Text = I_MonPago.Text
      D_MedioPago.Text = I_MedioPago.Text
      D_Indice_Tran.Text = I_Indice_Tran.Text
      D_Spread_Tran.Text = I_Indice_Tran.Text
   End If
   If (Origen = "D" And Desino = "I") Then
      I_Moneda.Text = D_Moneda.Text
      I_NemMon.Caption = D_NemMon.Caption
      I_Nocionales.Text = D_Nocionales.Text
      I_FrecuenciaPago.Text = D_FrecuenciaPago.Text
      I_FrecuenciaCapital.Text = D_FrecuenciaCapital.Text
      I_Indicador.Text = D_Indicador.Text
      I_UltimoIndice.Text = D_UltimoIndice.Text
      I_UltimoIndice.Text = D_UltimoIndice.Text
      I_Spread.Text = D_Spread.Text
      I_Spread_Tran.Text = D_Spread_Tran.Text
      I_ConteoDias.Text = D_ConteoDias.Text
      I_FechaEfectiva.Text = D_FechaEfectiva.Text
      I_Madurez.Text = D_Madurez.Text
      I_PrimerPago.Text = D_PrimerPago.Text
      I_PenultimoPago.Text = D_PenultimoPago.Text
      I_MonPago.Text = D_MonPago.Text
      I_MedioPago.Text = D_MedioPago.Text
      I_Indice_Tran.Text = D_Indice_Tran.Text
      I_Spread_Tran.Text = D_Indice_Tran.Text
   End If
   On Error GoTo 0
End Sub

Private Sub Intercambio_Click(Index As Integer)
   
   If Index = 0 Then
      Intercambio(1).Value = Intercambio(0).Value
      
      If D_Grid.Rows - 1 > 0 Then
        If Intercambio(0).Value = 0 Then
            D_Grid.TextMatrix(1, 19) = "No"
        Else
            D_Grid.TextMatrix(1, 19) = "Si"
        End If
      End If
   Else
      Intercambio(0).Value = Intercambio(1).Value
      
      If I_Grid.Rows - 1 > 0 Then
        If Intercambio(1).Value = 0 Then
            I_Grid.TextMatrix(1, 19) = "No"
        Else
            I_Grid.TextMatrix(1, 19) = "Si"
        End If
      End If
   End If
End Sub


Private Sub NunDecimales_Click()
   DecAmortizacion = Val(NunDecimales.Text)
   AplicarFormatoExt = "#,##0." & String(DecAmortizacion, "0")
   
  ' I_Nocionales.Tag = I_Nocionales.Text
  ' D_Nocionales.Tag = D_Nocionales.Text
  '    I_Nocionales.CantidadDecimales = DecAmortizacion
  '    D_Nocionales.CantidadDecimales = DecAmortizacion
  '       I_Nocionales.Text = Round(CDbl(I_Nocionales.Tag), DecAmortizacion)
  '       D_Nocionales.Text = Round(CDbl(D_Nocionales.Tag), DecAmortizacion)

End Sub


Private Sub Option1_Click(Index As Integer)
   Let Thr_Cotizacion = IIf(Index = 0, True, False)
End Sub

Private Sub TIKKER_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
  Dim valorVAC As Double
  Dim Dias As Integer
  Dim TipoSwap As String
  Dim Tasa As Double
  
   Frm_Msg_Planilla_Excel.Visible = False
   
   Select Case Button.Index
   
      Case Btn_Limpiar
         Call Limpiar
         ''''ToolBoton = Button.Index
      
      Case Btn_Flujos
               
'*********************PRD21657
   'If ChkRefMer.Enabled Then
        'MsgBox "Debe Ingresar Referencias de Mercado"
       ' Exit Sub
   ' End If
   
'*********************PRD21657
         
         
         Call Proc_Genera_Flujos
            'Aplicar Control de Precios y Tasas
            Call Simular    'Calcular el Valor Razonable para la operación (PRD-3860)

            valorVAC = CalculaVAC(TipoSwap)
            If TipoSwap = "" Then
                MsgBox "No fue posible determinar el tipo de Swap!", vbCritical, TITSISTEMA
                Exit Sub
            End If
            Dias = DateDiff("D", gsBAC_Fecp, I_Madurez.Text)
            Tasa = valorVAC
            
            'Como aun no conozco al cliente...
            Ctrlpt_RutCliente = "0"
            Ctrlpt_CodCliente = "0"
            
            If ControlPreciosTasas(TipoSwap, Dias, Tasa) = "S" Then
                If Ctrlpt_ModoOperacion <> "S" Then 'PRD-3860, modo silencioso
                    'si el modo no es silencioso, mostrar
                MsgBox Ctrlpt_Mensaje, vbExclamation, TITSISTEMA
            End If
            End If
         
        Case Btn_Grabar
            
            If FuncValidaResultadoMesa = False Then
               Exit Sub
            End If
            
            If ValidacionPreGeneracio Then
            
                'JBh, 16-12-2009. Ver el contenido del checkbox chk_intramesa
                If chk_intramesa.Value = 1 Then 'JBH, 17-12-2009 Usar 1 no True
                    ope_intramesa = True
                Else
                    ope_intramesa = False
                End If
                'fin JBH, 16-12-2009
            
                            
            'Cambios Cambios Artículo 84
            
            
             If (blnProcesoArt84Activo("PCS")) Then
            
            gblSW_Plazo = DateDiff("D", I_Madurez.Text, gsBAC_Fecp) * -1
            gblSW_MontoReserva = CDbl(I_Nocionales.Text)
            gblstrCodMonedaIBS = I_NemMon
            gblintTipoSwap = EntregaTipoSwap
                    If Option1.Item(0).Value = True Then    ' COTIZACION
                        gstrGuardaComo = "Cotiza"
                    Else
                        gstrGuardaComo = "Cartera"
                    End If
            End If
            
            
            'Fin Cambios Artículo 84
            
            
            
                Call Proc_Grabar
            End If
         
      Case Btn_GenExcel
         Call Proc_Genera_Excel
         
      Case Btn_CarExcel
         Call Proc_Cargar_Excel
      
      Case Btn_Cerrar
         SwapModificacion = 0
             
         Set Referencias = Nothing '**************PRD21657
         
         
         ''''ToolBoton = Button.Index
         On Error Resume Next
         Unload Me
         On Error GoTo 0
    End Select
End Sub

Private Function FuncValidaResultadoMesa() As Boolean
   Let FuncValidaResultadoMesa = False
   
   If bSwWriteResultadoClp = True Or bSwWriteResultadoUsd = True Then
      Call GRABA_LOG_AUDITORIA("Opc_20302", "01", "; Usuario " & gsBAC_User & " Operación Grabada con la utilidad ingresada ", "", "", "")
      Let FuncValidaResultadoMesa = True
      Exit Function
   End If
   
  If txt_Res_Mesa_Dist.Text = 0 Or txt_Res_Mesa_Dist_USD.Text = 0 Then
      Let SSFlujos.Tab = 2
      If MsgBox(" LA UTILIDAD SE ENCUENTRA EN CERO. " & vbCrLf & vbCrLf & " ¿ Desea grabar la operación ?", vbQuestion + vbYesNo, App.Title) = vbNo Then
         Exit Function
      Else
         Call GRABA_LOG_AUDITORIA("Opc_20302", "01", "; Usuario " & gsBAC_User & " Graba Operación con UTILIDAD EN CERO", "", "", "")
      End If
  Else
      Let SSFlujos.Tab = 2
      If MsgBox(" FAVOR REVISE QUE LA UTILIDAD CALCULADA SEA LA CORRECTA " & vbCrLf & vbCrLf & " ¿ Desea grabar la operación ?", vbQuestion + vbYesNo, App.Title) = vbNo Then
         Exit Function
      Else
         Call GRABA_LOG_AUDITORIA("Opc_20302", "01", "; Usuario " & gsBAC_User & " Operación Grabada con la utilidad Calculada", "", "", "")
      End If
  End If

   Let FuncValidaResultadoMesa = True
End Function

Private Sub ToolDerIzq_ButtonClick(ByVal Button As MSComctlLib.Button)
   Aplicar = ""
   
   Call TraspasoDatos("D", "I")
   
   If ChkAplizaOnLine(0).Value = 1 Then
       Aplicar = "D"
   ElseIf ChkAplizaOnLine(0).Value = 1 Then
      Aplicar = "I"
   Else
      Aplicar = ""
   End If
   
End Sub

Private Sub ToolIzqDer_ButtonClick(ByVal Button As MSComctlLib.Button)
   Aplicar = ""
   
   Call TraspasoDatos("I", "D")
   
   If ChkAplizaOnLine(0).Value = 1 Then
       Aplicar = "D"
   ElseIf ChkAplizaOnLine(0).Value = 1 Then
      Aplicar = "I"
   Else
      Aplicar = ""
   End If
   
End Sub

Private Sub DefineTitulos()
   
   I_Grid.Rows = 1
   D_Grid.Rows = 1

   I_Grid.Cols = 33 '25 '17 '32
   D_Grid.Cols = 33 '32
   I_Grid_Tran.Cols = 33 '32
   D_Grid_Tran.Cols = 33 '32

   '*******************************************************************************************************
   '********************************************** RECIBIMOS **********************************************
   '*******************************************************************************************************

   I_Grid.TextMatrix(0, 0) = "N°FLUJO":                        I_Grid.ColWidth(0) = 750
   I_Grid.TextMatrix(0, 1) = "VENCIMIENTO":                    I_Grid.ColWidth(1) = 1200
   I_Grid.TextMatrix(0, 2) = "AMORTIZACION":                   I_Grid.ColWidth(2) = 1500
   I_Grid.TextMatrix(0, 3) = "TASA + SPREAD":                  I_Grid.ColWidth(3) = 1500
   I_Grid.TextMatrix(0, 4) = "INTERES":                        I_Grid.ColWidth(4) = 1500
   I_Grid.TextMatrix(0, 5) = "TOTAL":                          I_Grid.ColWidth(5) = 1500
   I_Grid.TextMatrix(0, 6) = "MODALIDAD":                      I_Grid.ColWidth(6) = 0
   I_Grid.TextMatrix(0, 7) = "Documento Pago":                 I_Grid.ColWidth(7) = 0
   I_Grid.TextMatrix(0, 8) = "Saldo amortizar":                I_Grid.ColWidth(8) = 0
   I_Grid.TextMatrix(0, 9) = "Fecha Vcto. Anterior":           I_Grid.ColWidth(9) = 0
   I_Grid.TextMatrix(0, 10) = "Monto en moneda seleccionada":  I_Grid.ColWidth(10) = 0
   I_Grid.TextMatrix(0, 11) = "Monto en USD que paga./recib.": I_Grid.ColWidth(11) = 0
   I_Grid.TextMatrix(0, 12) = "Monto en $ que paga./recib.":   I_Grid.ColWidth(12) = 0
   I_Grid.TextMatrix(0, 13) = "Ubicacion del Dato ":           I_Grid.ColWidth(13) = 0
   I_Grid.TextMatrix(0, 14) = "LIQUIDACION":                   I_Grid.ColWidth(14) = 1200
   I_Grid.TextMatrix(0, 15) = "Fecha Flujo Real":              I_Grid.ColWidth(15) = 0
   I_Grid.TextMatrix(0, 16) = "FECHA FIXING":                  I_Grid.ColWidth(16) = 0
   I_Grid.TextMatrix(0, 17) = "SALDO INSOLUTO":                I_Grid.ColWidth(17) = 1500
   I_Grid.TextMatrix(0, 18) = "% AMORTIZA":                    I_Grid.ColWidth(18) = 1500
   I_Grid.TextMatrix(0, 19) = "INT.NOC.":                      I_Grid.ColWidth(19) = 1000
   I_Grid.TextMatrix(0, 20) = "FECHA VALUTA":                  I_Grid.ColWidth(20) = 1200
   I_Grid.TextMatrix(0, 21) = "FLUJO ADICIONAL":               I_Grid.ColWidth(21) = 1500
   I_Grid.TextMatrix(0, 22) = "FXRATE":                        I_Grid.ColWidth(22) = 1000
   I_Grid.TextMatrix(0, 23) = "TASA":                          I_Grid.ColWidth(23) = 0
   I_Grid.TextMatrix(0, 24) = "SPREAD":                        I_Grid.ColWidth(24) = 0
   
   I_Grid.TextMatrix(0, 25) = "Valor Razonable":               I_Grid.ColWidth(25) = 0
   
   I_Grid.TextMatrix(0, 26) = "bEarlyTermination":             I_Grid.ColWidth(26) = 0
   I_Grid.TextMatrix(0, 27) = "FechaInicio":                   I_Grid.ColWidth(27) = 0
   I_Grid.TextMatrix(0, 28) = "Periodicidad":                  I_Grid.ColWidth(28) = 0
   
   
   '**************************PRD21657
    I_Grid.TextMatrix(0, 29) = "ReferenciaUSDCLP":             I_Grid.ColWidth(29) = 0
    I_Grid.TextMatrix(0, 30) = "ReferenciaMEXUSD":              I_Grid.ColWidth(30) = 0
    I_Grid.TextMatrix(0, 31) = "FechaUSDCLP":                   I_Grid.ColWidth(31) = 0
    I_Grid.TextMatrix(0, 32) = "FechaMEXUSD":                   I_Grid.ColWidth(32) = 0
   '**************************PRD21657
   '*****************************************************************************************************
   '********************************************** PAGAMOS **********************************************
   '*****************************************************************************************************
   
   D_Grid.TextMatrix(0, 0) = "N°FLUJO":                        D_Grid.ColWidth(0) = 750
   D_Grid.TextMatrix(0, 1) = "VENCIMIENTO":                    D_Grid.ColWidth(1) = 1200
   D_Grid.TextMatrix(0, 2) = "AMORTIZACION":                   D_Grid.ColWidth(2) = 1500
   D_Grid.TextMatrix(0, 3) = "TASA + SPREAD":                  D_Grid.ColWidth(3) = 1500
   D_Grid.TextMatrix(0, 4) = "INTERES":                        D_Grid.ColWidth(4) = 1500
   D_Grid.TextMatrix(0, 5) = "TOTAL":                          D_Grid.ColWidth(5) = 1500
   D_Grid.TextMatrix(0, 6) = "MODALIDAD":                      D_Grid.ColWidth(6) = 0
   D_Grid.TextMatrix(0, 7) = "Documento Pago":                 D_Grid.ColWidth(7) = 0
   D_Grid.TextMatrix(0, 8) = "Saldo amortizar":                D_Grid.ColWidth(8) = 0
   D_Grid.TextMatrix(0, 9) = "Fecha Vcto. Anterior":           D_Grid.ColWidth(9) = 0
   D_Grid.TextMatrix(0, 10) = "Monto en moneda seleccionada":  D_Grid.ColWidth(10) = 0
   D_Grid.TextMatrix(0, 11) = "Monto en USD que paga./recib.": D_Grid.ColWidth(11) = 0
   D_Grid.TextMatrix(0, 12) = "Monto en $ que paga./recib.":   D_Grid.ColWidth(12) = 0
   D_Grid.TextMatrix(0, 13) = "Ubicacion del Dato ":           D_Grid.ColWidth(13) = 0
   D_Grid.TextMatrix(0, 14) = "LIQUIDACION":                   D_Grid.ColWidth(14) = 1200
   D_Grid.TextMatrix(0, 15) = "Fecha Flujo Real":              D_Grid.ColWidth(15) = 0
   D_Grid.TextMatrix(0, 16) = "FECHA FIXING":                  D_Grid.ColWidth(16) = 0
   D_Grid.TextMatrix(0, 17) = "SALDO INSOLUTO":                D_Grid.ColWidth(17) = 1500
   D_Grid.TextMatrix(0, 18) = "% AMORTIZA":                    D_Grid.ColWidth(18) = 1500
   D_Grid.TextMatrix(0, 19) = "INT.NOC.":                      D_Grid.ColWidth(19) = 1000
   D_Grid.TextMatrix(0, 20) = "FECHA VALUTA":                  D_Grid.ColWidth(20) = 1200
   D_Grid.TextMatrix(0, 21) = "FLUJO ADICIONAL":               D_Grid.ColWidth(21) = 1500
   D_Grid.TextMatrix(0, 22) = "FXRATE":                        D_Grid.ColWidth(22) = 1000
   D_Grid.TextMatrix(0, 23) = "TASA":                          D_Grid.ColWidth(23) = 0
   D_Grid.TextMatrix(0, 24) = "SPREAD":                        D_Grid.ColWidth(24) = 0
   
   D_Grid.TextMatrix(0, 25) = "Valor Razonable":               D_Grid.ColWidth(25) = 0
   
   I_Grid.TextMatrix(0, 26) = "bEarlyTermination":             I_Grid.ColWidth(26) = 0
   I_Grid.TextMatrix(0, 27) = "FechaInicio":                   I_Grid.ColWidth(27) = 0
   I_Grid.TextMatrix(0, 28) = "Periodicidad":                  I_Grid.ColWidth(28) = 0
   
   
   '**************************PRD21657
    I_Grid.TextMatrix(0, 29) = "ReferenciaUSDCLP":             I_Grid.ColWidth(29) = 0
    I_Grid.TextMatrix(0, 30) = "ReferenciaMEXUSD":              I_Grid.ColWidth(30) = 0
    I_Grid.TextMatrix(0, 31) = "FechaUSDCLP":                   I_Grid.ColWidth(31) = 0
    I_Grid.TextMatrix(0, 32) = "FechaMEXUSD":                   I_Grid.ColWidth(32) = 0
   '**************************PRD21657
   
   '*********************************************************************************************************************
   '********************************************** RECIBIMOS TRANSFERENCIA **********************************************
   '*********************************************************************************************************************
   
   I_Grid_Tran.TextMatrix(0, 0) = "N°FLUJO":                        I_Grid_Tran.ColWidth(0) = 750
   I_Grid_Tran.TextMatrix(0, 1) = "VENCIMIENTO":                    I_Grid_Tran.ColWidth(1) = 1200
   I_Grid_Tran.TextMatrix(0, 2) = "AMORTIZACION":                   I_Grid_Tran.ColWidth(2) = 1500
   I_Grid_Tran.TextMatrix(0, 3) = "TASA + SPREAD":                  I_Grid_Tran.ColWidth(3) = 1500
   I_Grid_Tran.TextMatrix(0, 4) = "INTERES":                        I_Grid_Tran.ColWidth(4) = 1500
   I_Grid_Tran.TextMatrix(0, 5) = "TOTAL":                          I_Grid_Tran.ColWidth(5) = 1500
   I_Grid_Tran.TextMatrix(0, 6) = "MODALIDAD":                      I_Grid_Tran.ColWidth(6) = 1500
   I_Grid_Tran.TextMatrix(0, 7) = "Documento Pago":                 I_Grid_Tran.ColWidth(7) = 1500
   I_Grid_Tran.TextMatrix(0, 8) = "Saldo amortizar":                I_Grid_Tran.ColWidth(8) = 1500
   I_Grid_Tran.TextMatrix(0, 9) = "Fecha Vcto. Anterior":           I_Grid_Tran.ColWidth(9) = 1500
   I_Grid_Tran.TextMatrix(0, 10) = "Monto en moneda seleccionada":  I_Grid_Tran.ColWidth(10) = 1500
   I_Grid_Tran.TextMatrix(0, 11) = "Monto en USD que paga./recib.": I_Grid_Tran.ColWidth(11) = 1500
   I_Grid_Tran.TextMatrix(0, 12) = "Monto en $ que paga./recib.":   I_Grid_Tran.ColWidth(12) = 1500
   I_Grid_Tran.TextMatrix(0, 13) = "Ubicacion del Dato ":           I_Grid_Tran.ColWidth(13) = 1500
   I_Grid_Tran.TextMatrix(0, 14) = "LIQUIDACION":                   I_Grid_Tran.ColWidth(14) = 1200
   I_Grid_Tran.TextMatrix(0, 15) = "Fecha Flujo Real":              I_Grid_Tran.ColWidth(15) = 1500
   I_Grid_Tran.TextMatrix(0, 16) = "FECHA FIXING":                  I_Grid_Tran.ColWidth(16) = 1500
   I_Grid_Tran.TextMatrix(0, 17) = "SALDO INSOLUTO":                I_Grid_Tran.ColWidth(17) = 1500
   I_Grid_Tran.TextMatrix(0, 18) = "% AMORTIZA":                    I_Grid_Tran.ColWidth(18) = 1500
   I_Grid_Tran.TextMatrix(0, 19) = "INT.NOC.":                      I_Grid_Tran.ColWidth(19) = 1000
   I_Grid_Tran.TextMatrix(0, 20) = "FECHA VALUTA":                  I_Grid_Tran.ColWidth(20) = 1200
   I_Grid_Tran.TextMatrix(0, 21) = "FLUJO ADICIONAL":               I_Grid_Tran.ColWidth(21) = 1500
   I_Grid_Tran.TextMatrix(0, 22) = "FXRATE":                        I_Grid_Tran.ColWidth(22) = 1000
   I_Grid_Tran.TextMatrix(0, 23) = "TASA":                          I_Grid_Tran.ColWidth(23) = 1000
   I_Grid_Tran.TextMatrix(0, 24) = "SPREAD":                        I_Grid_Tran.ColWidth(24) = 1000
   I_Grid_Tran.TextMatrix(0, 25) = "Valor Razonable":               I_Grid_Tran.ColWidth(25) = 1500

   I_Grid.TextMatrix(0, 26) = "bEarlyTermination":             I_Grid.ColWidth(26) = 0
   I_Grid.TextMatrix(0, 27) = "FechaInicio":                   I_Grid.ColWidth(27) = 0
   I_Grid.TextMatrix(0, 28) = "Periodicidad":                  I_Grid.ColWidth(28) = 0
   
   
   '**************************PRD21657
    I_Grid.TextMatrix(0, 29) = "ReferenciaUSDCLP":             I_Grid.ColWidth(29) = 0
    I_Grid.TextMatrix(0, 30) = "ReferenciaMEXUSD":              I_Grid.ColWidth(30) = 0
    I_Grid.TextMatrix(0, 31) = "FechaUSDCLP":                   I_Grid.ColWidth(31) = 0
    I_Grid.TextMatrix(0, 32) = "FechaMEXUSD":                   I_Grid.ColWidth(32) = 0
   '**************************PRD21657
   
   
   
   '*******************************************************************************************************************
   '********************************************** PAGAMOS TRANSFERENCIA **********************************************
   '*******************************************************************************************************************
   
   D_Grid_Tran.TextMatrix(0, 0) = "N°FLUJO":                        D_Grid_Tran.ColWidth(0) = 750
   D_Grid_Tran.TextMatrix(0, 1) = "VENCIMIENTO":                    D_Grid_Tran.ColWidth(1) = 1200
   D_Grid_Tran.TextMatrix(0, 2) = "AMORTIZACION":                   D_Grid_Tran.ColWidth(2) = 1500
   D_Grid_Tran.TextMatrix(0, 3) = "TASA + SPREAD":                  D_Grid_Tran.ColWidth(3) = 1500
   D_Grid_Tran.TextMatrix(0, 4) = "INTERES":                        D_Grid_Tran.ColWidth(4) = 1500
   D_Grid_Tran.TextMatrix(0, 5) = "TOTAL":                          D_Grid_Tran.ColWidth(5) = 1500
   D_Grid_Tran.TextMatrix(0, 6) = "MODALIDAD":                      D_Grid_Tran.ColWidth(6) = 1500
   D_Grid_Tran.TextMatrix(0, 7) = "Documento Pago":                 D_Grid_Tran.ColWidth(7) = 1500
   D_Grid_Tran.TextMatrix(0, 8) = "Saldo amortizar":                D_Grid_Tran.ColWidth(8) = 1500
   D_Grid_Tran.TextMatrix(0, 9) = "Fecha Vcto. Anterior":           D_Grid_Tran.ColWidth(9) = 1500
   D_Grid_Tran.TextMatrix(0, 10) = "Monto en moneda seleccionada":  D_Grid_Tran.ColWidth(10) = 1500
   D_Grid_Tran.TextMatrix(0, 11) = "Monto en USD que paga./recib.": D_Grid_Tran.ColWidth(11) = 1500
   D_Grid_Tran.TextMatrix(0, 12) = "Monto en $ que paga./recib.":   D_Grid_Tran.ColWidth(12) = 1500
   D_Grid_Tran.TextMatrix(0, 13) = "Ubicacion del Dato ":           D_Grid_Tran.ColWidth(13) = 1500
   D_Grid_Tran.TextMatrix(0, 14) = "LIQUIDACION":                   D_Grid_Tran.ColWidth(14) = 1200
   D_Grid_Tran.TextMatrix(0, 15) = "Fecha Flujo Real":              D_Grid_Tran.ColWidth(15) = 1500
   D_Grid_Tran.TextMatrix(0, 16) = "FECHA FIXING":                  D_Grid_Tran.ColWidth(16) = 1500
   D_Grid_Tran.TextMatrix(0, 17) = "SALDO INSOLUTO":                D_Grid_Tran.ColWidth(17) = 1500
   D_Grid_Tran.TextMatrix(0, 18) = "% AMORTIZA":                    D_Grid_Tran.ColWidth(18) = 1500
   D_Grid_Tran.TextMatrix(0, 19) = "INT.NOC.":                      D_Grid_Tran.ColWidth(19) = 1000
   D_Grid_Tran.TextMatrix(0, 20) = "FECHA VALUTA":                  D_Grid_Tran.ColWidth(20) = 1200
   D_Grid_Tran.TextMatrix(0, 21) = "FLUJO ADICIONAL":               D_Grid_Tran.ColWidth(21) = 1500
   D_Grid_Tran.TextMatrix(0, 22) = "FXRATE":                        D_Grid_Tran.ColWidth(22) = 1000
   D_Grid_Tran.TextMatrix(0, 23) = "TASA":                          D_Grid_Tran.ColWidth(23) = 1000
   D_Grid_Tran.TextMatrix(0, 24) = "SPREAD":                        D_Grid_Tran.ColWidth(24) = 1000
   D_Grid_Tran.TextMatrix(0, 25) = "Valor Razonable":               D_Grid_Tran.ColWidth(25) = 1500
   

   I_Grid.TextMatrix(0, 26) = "bEarlyTermination":             I_Grid.ColWidth(26) = 0
   I_Grid.TextMatrix(0, 27) = "FechaInicio":                   I_Grid.ColWidth(27) = 0
   I_Grid.TextMatrix(0, 28) = "Periodicidad":                  I_Grid.ColWidth(28) = 0
   
   
   '**************************PRD21657
    I_Grid.TextMatrix(0, 29) = "ReferenciaUSDCLP":             I_Grid.ColWidth(29) = 0
    I_Grid.TextMatrix(0, 30) = "ReferenciaMEXUSD":              I_Grid.ColWidth(30) = 0
    I_Grid.TextMatrix(0, 31) = "FechaUSDCLP":                   I_Grid.ColWidth(31) = 0
    I_Grid.TextMatrix(0, 32) = "FechaMEXUSD":                   I_Grid.ColWidth(32) = 0
   '**************************PRD21657



End Sub


Private Function ReCalculaDiasFeridos(MiLado As Lados, Fecha As String, FeriadosFlujos As Boolean, FechaReset As Boolean) As Date
   Dim bSwChi     As Boolean
   Dim bSwUsa     As Boolean
   Dim bSwIng     As Boolean
   Dim dHabilChi  As Boolean
   Dim dHabilUsa  As Boolean
   Dim dHabilIng  As Boolean
   Dim Modificado As Boolean
   Dim dFechaAux  As Date
   Dim nIntervalo As Integer
   Dim nVueltas   As Integer
   
   ''''nVueltas = IIf(MiLado = "D", D_Convencion.ItemData(D_Convencion.ListIndex), I_Convencion.ItemData(I_Convencion.ListIndex))
   nVueltas = IIf(MiLado = Derecho Or MiLado = Der_Tran, D_Convencion.ItemData(D_Convencion.ListIndex), I_Convencion.ItemData(I_Convencion.ListIndex))
  
   nIntervalo = IIf(nVueltas < 0, -1, 1)
   
   nVueltas = 0
   
   If FechaReset = True Then
      ''''nVueltas = IIf(MiLado = "D", D_DiasReset.Text, I_DiasReset.Text)
      nVueltas = IIf(MiLado = Derecho Or MiLado = Der_Tran, D_DiasReset.Text, I_DiasReset.Text)
      nIntervalo = -1
      '-- MAP No mover si dias reset es igual a cero.
      If nVueltas = 0 Then
        ReCalculaDiasFeridos = Fecha
        Exit Function
      End If
   End If

   Modificado = False
   If FeriadosFlujos = True Then
      If FechaReset = False Then
         ''''Modificado = IIf(MiLado = "D", IIf(D_Convencion.Text Like "*Modificado", True, False), IIf(I_Convencion.Text Like "*Modificado", True, False))
         Modificado = IIf(MiLado = Derecho Or MiLado = Der_Tran, IIf(D_Convencion.Text Like "*Modificado", True, False), IIf(I_Convencion.Text Like "*Modificado", True, False))
      End If
   End If
   
''''   bSwChi = IIf(FeriadosFlujos = True, IIf(MiLado = "D", D_FERIADOCHK(0).Value, I_FERIADOCHK(0).Value), IIf(MiLado = "D", D_FERIADOCHK(3).Value, I_FERIADOCHK(3).Value))
''''   bSwUsa = IIf(FeriadosFlujos = True, IIf(MiLado = "D", D_FERIADOCHK(1).Value, I_FERIADOCHK(1).Value), IIf(MiLado = "D", D_FERIADOCHK(4).Value, I_FERIADOCHK(4).Value))
''''   bSwIng = IIf(FeriadosFlujos = True, IIf(MiLado = "D", D_FERIADOCHK(2).Value, I_FERIADOCHK(2).Value), IIf(MiLado = "D", D_FERIADOCHK(5).Value, I_FERIADOCHK(5).Value))

   bSwChi = IIf(FeriadosFlujos = True, IIf(MiLado = Derecho Or MiLado = Der_Tran, D_FERIADOCHK(0).Value, I_FERIADOCHK(0).Value), IIf(MiLado = Derecho Or MiLado = Der_Tran, D_FERIADOCHK(3).Value, I_FERIADOCHK(3).Value))
   bSwUsa = IIf(FeriadosFlujos = True, IIf(MiLado = Derecho Or MiLado = Der_Tran, D_FERIADOCHK(1).Value, I_FERIADOCHK(1).Value), IIf(MiLado = Derecho Or MiLado = Der_Tran, D_FERIADOCHK(4).Value, I_FERIADOCHK(4).Value))
   bSwIng = IIf(FeriadosFlujos = True, IIf(MiLado = Derecho Or MiLado = Der_Tran, D_FERIADOCHK(2).Value, I_FERIADOCHK(2).Value), IIf(MiLado = Derecho Or MiLado = Der_Tran, D_FERIADOCHK(5).Value, I_FERIADOCHK(5).Value))

   If FeriadosFlujos = False And FechaReset = False Then
      bSwUsa = False
      bSwIng = False
   End If

   dHabilChi = Not bSwChi
   dHabilUsa = Not bSwUsa
   dHabilIng = Not bSwIng
   
   dFechaAux = Fecha
   
   Do While (bSwChi = True) Or (bSwUsa = True) Or (bSwIng = True)
      If bSwChi = True Then dHabilChi = MiDiaHabil(Str(dFechaAux), Chile)
      If bSwUsa = True Then dHabilUsa = MiDiaHabil(Str(dFechaAux), EstadosUnidos)
      If bSwIng = True Then dHabilIng = MiDiaHabil(Str(dFechaAux), Inglaterra)
   
      If dHabilChi = True And dHabilUsa = True And dHabilIng = True Then
         If FechaReset = True And nVueltas <> 0 Then
            nVueltas = nVueltas - 1
         Else
            Exit Do
         End If
      End If
      
      If Modificado = True And Month(DateAdd("D", nIntervalo, dFechaAux)) <> Month(dFechaAux) Then
         nIntervalo = nIntervalo * -1
         Modificado = False
      End If
      dFechaAux = DateAdd("D", nIntervalo, dFechaAux)
   Loop
   ReCalculaDiasFeridos = dFechaAux

End Function



Private Function CalculaDiasReset(MiLado As Lados, Fecha As String) As Date
   Dim bSwChi     As Boolean
   Dim bSwUsa     As Boolean
   Dim bSwIng     As Boolean
   Dim dHabilChi  As Boolean
   Dim dHabilUsa  As Boolean
   Dim dHabilIng  As Boolean
   Dim Modificado As Boolean
   Dim dFechaAux  As Date
   Dim nIntervalo As Integer
   Dim nVueltas   As Integer
   
   
   ''''nVueltas = IIf(MiLado = "D", D_DiasReset.Text, I_DiasReset.Text)
   nVueltas = IIf(MiLado = Derecho Or MiLado = Der_Tran, D_DiasReset.Text, I_DiasReset.Text)
   nIntervalo = -1
   
   '-- MAP No mover si dias reset es igual a cero.
   If nVueltas = 0 Then
      CalculaDiasReset = Fecha
      Exit Function
   End If

   'Lectura de Sw, vcto y reset utiliza feriado de Vcto (0,1,2), pago el otro (3,5,6)
''''   bSwChi = IIf(MiLado = "D", D_FERIADOCHK(0).Value, I_FERIADOCHK(0).Value)
''''   bSwUsa = IIf(MiLado = "D", D_FERIADOCHK(1).Value, I_FERIADOCHK(1).Value)
''''   bSwIng = IIf(MiLado = "D", D_FERIADOCHK(2).Value, I_FERIADOCHK(2).Value)

   bSwChi = IIf(MiLado = Derecho Or MiLado = Der_Tran, D_FERIADOCHK(0).Value, I_FERIADOCHK(0).Value)
   bSwUsa = IIf(MiLado = Derecho Or MiLado = Der_Tran, D_FERIADOCHK(1).Value, I_FERIADOCHK(1).Value)
   bSwIng = IIf(MiLado = Derecho Or MiLado = Der_Tran, D_FERIADOCHK(2).Value, I_FERIADOCHK(2).Value)

   'Verificar comentación
   'dHabilChi = Not bSwChi
   'dHabilUsa = Not bSwUsa
   'dHabilIng = Not bSwIng
   
   dFechaAux = Fecha
   
   'Si tenemos que considerar algun feriado parte el algoritmo
   'Si no hay que considerar feriados retorna la misma fecha sin
   'desplazamiento
   
   Do While nVueltas <> 0
      dFechaAux = DateAdd("D", nIntervalo, dFechaAux)
      dHabilChi = MiDiaHabil(Str(dFechaAux), Chile)
      dHabilUsa = MiDiaHabil(Str(dFechaAux), EstadosUnidos)
      dHabilIng = MiDiaHabil(Str(dFechaAux), Inglaterra)
      
      'Se cuenta como hábil solo si es hábil chileno y hay que considerar los otros paises
      If (dHabilChi = True) _
         And (dHabilUsa = True Or Not bSwUsa) _
         And (dHabilIng = True Or Not bSwIng) Then
         If nVueltas <> 0 Then
            nVueltas = nVueltas - 1
         Else
            Exit Do
         End If
      End If
   Loop
   
   CalculaDiasReset = dFechaAux

End Function

Private Function ReHaceFlujoHabil(MiLado As String, Fecha As Date, Capital As Boolean, Optional Reset As Boolean) As Date
   Dim iPasadas   As Integer
   Dim iVueltas   As Integer
   Dim CHI        As Boolean
   Dim Sw_Chile   As Boolean
   Dim USA        As Boolean
   Dim Sw_EEUU    As Boolean
   Dim ENG        As Boolean
   Dim Sw_Engl    As Boolean
   Dim dFechaAux  As Date
   Dim Intervalo  As Integer
   Dim iRetrocede As Boolean
   Dim Modificado As Boolean

   
   Intervalo = IIf(MiLado = "I", I_Convencion.ItemData(I_Convencion.ListIndex), D_Convencion.ItemData(D_Convencion.ListIndex))
   If Intervalo > 0 Then
      Intervalo = 1
   Else
      Intervalo = -1
   End If
   If MiLado = "I" Then
      Modificado = IIf(I_Convencion.Text Like "*Modificado", True, False)
   Else
      Modificado = IIf(D_Convencion.Text Like "*Modificado", True, False)
   End If
   If Reset = True Then
      Intervalo = -1 'Intervalo * -1
      iPasadas = IIf(MiLado = "I", I_DiasReset.Text, D_DiasReset.Text)
      iVueltas = 0
   End If

   If Capital = True Then
      CHI = IIf(MiLado = "I", I_FERIADOCHK(0).Value, D_FERIADOCHK(0).Value)
      USA = IIf(MiLado = "I", I_FERIADOCHK(1).Value, D_FERIADOCHK(1).Value)
      ENG = IIf(MiLado = "I", I_FERIADOCHK(2).Value, D_FERIADOCHK(2).Value)
   End If
   If Capital = False Then
      CHI = IIf(MiLado = "I", I_FERIADOCHK(3).Value, D_FERIADOCHK(3).Value)
      USA = IIf(MiLado = "I", I_FERIADOCHK(4).Value, D_FERIADOCHK(4).Value)
      ENG = IIf(MiLado = "I", I_FERIADOCHK(5).Value, D_FERIADOCHK(5).Value)
   End If

   dFechaAux = Fecha

   Sw_Chile = Not CHI
   Sw_EEUU = Not USA
   Sw_Engl = Not ENG

   If Not (CHI = True Or USA = True Or ENG = True) Then
      If Reset = True Then
         dFechaAux = DateAdd("D", ((iPasadas * Intervalo)), dFechaAux)
      End If
   End If

   Do While (CHI = True Or USA = True Or ENG = True)
      If CHI = True Then Sw_Chile = MiDiaHabil(Str(dFechaAux), Chile)
      If USA = True Then Sw_EEUU = MiDiaHabil(Str(dFechaAux), EstadosUnidos)
      If ENG = True Then Sw_Engl = MiDiaHabil(Str(dFechaAux), Inglaterra)

      If (Sw_Chile = True) And (Sw_EEUU = True) And (Sw_Engl = True) Then
         If Reset = False Then
            Exit Do
         End If

         iVueltas = iVueltas + 1
         If iPasadas < iVueltas Then
            Exit Do
         End If
         If Modificado = True Then
            If Month(dFechaAux) <> Month(DateAdd("D", Intervalo, dFechaAux)) Then
               Intervalo = Intervalo * -1
               iVueltas = 1
               dFechaAux = Fecha
            End If
         End If
         dFechaAux = DateAdd("D", Intervalo, dFechaAux)
      Else
         dFechaAux = DateAdd("D", Intervalo, dFechaAux)
      End If
   Loop
   ReHaceFlujoHabil = dFechaAux
End Function

Private Function CalculoInteresBonos(MiLado As Lados, Grd As MSFlexGrid)
   Dim Spread, Base, Tasa As Double
   Dim FechaAmortiza      As Date
   Dim FechaVencAnt       As Date
   Dim FecVAnt            As Date
   Dim DiasDif            As Long
   Dim cuenta             As Integer
   
   'CER 18/04/2008  - Req. Pantalla Ingreso Op. Swap
   'Dim MontoAmortiza      As Double
   Dim MontoGrd           As Double
   Dim Interes            As Double
   Dim Plazo              As Double
   Dim RestoCapital       As Double
   Dim TotalVenc          As Double
   Dim CodMoneda          As Integer
   Dim FactorUSD          As Double
   Dim MontoCLP           As Double
   Dim FactorCLP          As Double
   Dim MontoUSD           As Double
   Dim MonFuerteC         As Double
   Dim Referencial        As Integer
   Dim PeriDias           As String
   Dim PeriBase           As String
   Dim fecInicio          As Date
   Dim MontoCapital       As Double
   Dim CodigoMoneda       As Integer
   Dim BaseStr            As String
   Dim PlazoDias          As Double
   Dim nRedondeo          As Integer
   Dim iNeteoInteres      As Double
   Dim iNeteoAmortizacion As Double
   Dim iMontoNeteo        As Double
   Dim cSwMxC             As String
   Dim cSwMxV             As String
   Dim cRrdaV             As String
   Dim cRrdaC             As String
   
   'MAP 16/04/2008  - Req. Pantalla Ingreso Op. Swap
   Dim Amortizacion       As Double
   Dim SaldoInsoluto      As Double
   Dim AmortizaPrc        As Double  'Porcentaje Amortización
      
   Dim nParidad#
   Dim Pasito
   Dim Intercam           As Boolean
   
   Dim Indicador             As String
   Dim UltimoIndice          As Double
   Dim FechaIniFlujo         As String
   
   Dim nTipoSwap              As Integer
   Dim cProducto              As String
   Dim nTipoTasa              As Integer
   Dim nTipoFlujo             As Integer
   Dim nCodigoTasa            As Integer
   Dim nMontoFlujoAdicional   As Double
   Dim nTasaDesc              As Double
   Dim nSpreadDesc            As Double
   Dim nResultadoMD           As Double
   
  
   If Grd.Rows < 2 Then
      Exit Function
   End If
      
   Spread = 0
   FactorCLP = gsBAC_DolarObs

''''   PlazoDias = IIf(MiLado = "I", ValorAmort(I_FrecuenciaPago, "D"), ValorAmort(D_FrecuenciaPago, "D"))
''''   BaseStr = IIf(MiLado = "I", I_ConteoDias.Text, D_ConteoDias.Text)
''''   fecInicio = IIf(MiLado = "I", I_FechaEfectiva.Text, D_FechaEfectiva.Text)
''''   MontoCapital = IIf(MiLado = "I", I_Nocionales.Text, D_Nocionales.Text)
''''   CodMoneda = IIf(MiLado = "I", I_Moneda.ItemData(I_Moneda.ListIndex), D_Moneda.ItemData(D_Moneda.ListIndex))
''''   Intercam = IIf(MiLado = "I", Intercambio(1).Value, Intercambio(0).Value)
   
   PlazoDias = IIf(MiLado = Izquierdo Or MiLado = Izq_Tran, ValorAmort(I_FrecuenciaPago, "D"), ValorAmort(D_FrecuenciaPago, "D"))
   BaseStr = IIf(MiLado = Izquierdo Or MiLado = Izq_Tran, I_ConteoDias.Text, D_ConteoDias.Text)
   fecInicio = IIf(MiLado = Izquierdo Or MiLado = Izq_Tran, I_FechaEfectiva.Text, D_FechaEfectiva.Text)
   MontoCapital = IIf(MiLado = Izquierdo Or MiLado = Izq_Tran, I_Nocionales.Text, D_Nocionales.Text)
   CodMoneda = IIf(MiLado = Izquierdo Or MiLado = Izq_Tran, I_Moneda.ItemData(I_Moneda.ListIndex), D_Moneda.ItemData(D_Moneda.ListIndex))
   Intercam = IIf(MiLado = Izquierdo Or MiLado = Izq_Tran, Intercambio(1).Value, Intercambio(0).Value)
   
   nTipoSwap = EntregaTipoSwap
   cProducto = IIf(nTipoSwap = 1, "ST", IIf(nTipoSwap = 2, "SM", "SP"))
   
''''   Indicador = IIf(MiLado = "I", I_Indicador.Text, D_Indicador.Text)
''''   UltimoIndice = IIf(MiLado = "I", I_UltimoIndice.Text, D_UltimoIndice.Text)
''''   Spread = IIf(MiLado = "I", I_Spread.Text, D_Spread.Text)
         
   'PRD-4858, jbh, 16-02-2010. Asignación a variables globales para uso del Threshold
   Thr_CodProducto = nTipoSwap
   Thr_dPlazoOperacion = DateDiff("d", I_FechaEfectiva.Text, I_Madurez.Text)
   'fin PRD-4858
   
   Select Case MiLado
      Case Izquierdo
         nTipoTasa = IIf(I_Indicador.ItemData(I_Indicador.ListIndex) = 0, 0, 1)
         Indicador = I_Indicador.Text
         UltimoIndice = I_UltimoIndice.Text
         Spread = I_Spread.Text
         nTipoFlujo = 1
         nCodigoTasa = I_Indicador.ItemData(I_Indicador.ListIndex)
         nTotalVR_Recibe = 0
      Case Izq_Tran
         nTipoTasa = IIf(I_Indicador.ItemData(I_Indicador.ListIndex) = 0, 0, 1)
         Indicador = I_Indicador.Text
         UltimoIndice = I_Indice_Tran.Text
         Spread = I_Spread_Tran.Text
         nTipoFlujo = 1
         nCodigoTasa = I_Indicador.ItemData(I_Indicador.ListIndex)
         nTotalVR_Recibe_Tran = 0
      Case Derecho
         nTipoTasa = IIf(D_Indicador.ItemData(D_Indicador.ListIndex) = 0, 0, 1)
         Indicador = D_Indicador.Text
         UltimoIndice = D_UltimoIndice.Text
         Spread = D_Spread.Text
         nTipoFlujo = 2
         nCodigoTasa = D_Indicador.ItemData(D_Indicador.ListIndex)
         nTotalVR_Paga = 0
      Case Der_Tran
         nTipoTasa = IIf(D_Indicador.ItemData(D_Indicador.ListIndex) = 0, 0, 1)
         Indicador = D_Indicador.Text
         UltimoIndice = D_Indice_Tran.Text
         Spread = D_Spread_Tran.Text
         nTipoFlujo = 2
         nCodigoTasa = D_Indicador.ItemData(D_Indicador.ListIndex)
         nTotalVR_Paga_Tran = 0
      End Select
   
   FactorCLP = gsBAC_DolarObs
   Pasito = Right(BaseStr, 10)
   PeriDias = Trim(Left(Pasito, 5))
   PeriBase = Trim(Right(Pasito, 5))
   Base = IIf(PeriBase = "A", 365, PeriBase)

   If Grd.Rows > 1 Then
      DiasDif = DateDiff("d", CDate(fecInicio), CDate(Grd.TextMatrix(1, 1)))
   End If
   
   FechaVencAnt = CDate(fecInicio)
   'CER 18/04/2008  - Req. Pantalla Ingreso Op. Swap
   'MontoAmortiza = MontoCapital
   CodMoneda = IIf(CodMoneda = 0, 994, CodMoneda)

   Dim ValMonedas As New ClsMoneda
   
   If ValMonedas.LeerxCodigo(CodMoneda) Then
      FactorUSD = ValMonedas.vmValor
      MonFuerteC = ValMonedas.mnrefusd
      Referencial = ValMonedas.mnrefmerc
   End If
   
   ValMonedas.Limpiar

   Set ValMonedas = Nothing
   
   'MAP 16/04/2008  - Req. Pantalla Ingreso Op. Swap
   Let SaldoInsoluto = 0

   For cuenta = 1 To Grd.Rows - 1
      iMontoNeteo = 0#
      iNeteoInteres = 0#
      iNeteoAmortizacion = 0#
      
      nTasaDesc = 0#
      nSpreadDesc = 0#
      nFlujoDesc = 0#

      FechaAmortiza = Grd.TextMatrix(cuenta, 1)
      
      If Grd.TextMatrix(cuenta, 2) = "" Then
         MontoGrd = 0#
         RestoCapital = 0
      Else
         MontoGrd = Grd.TextMatrix(cuenta, 2)
         RestoCapital = CDbl(Grd.TextMatrix(cuenta, 2))
         'MAP 16/04/2008  - Req. Pantalla Ingreso Op. Swap
         Let Amortizacion = CDbl(Grd.TextMatrix(cuenta, 2))
      End If

      'CER 04/08/2008  - Cálculo ICP
      If cuenta = 1 Then
         FechaIniFlujo = CDate(Grd.TextMatrix(cuenta, 1))
      Else
         FechaIniFlujo = CDate(Grd.TextMatrix(cuenta - 1, 1))
      End If
      
      If Indicador = "ICP" And (CDate(gsBAC_Fecp) > CDate(FechaIniFlujo) And CDate(gsBAC_Fecp) <= CDate(CDate(Grd.TextMatrix(cuenta, 1)))) Then
         Tasa = CDbl(iValorTasaCamaraPromedio(CodMoneda, FechaIniFlujo, gsBAC_Fecp) + Spread)
         If Tasa = 0 Then
           SwValorICP = 1
         End If
      
      'PRD18662
      ElseIf Indicador = "IBR" And (CDate(gsBAC_Fecp) > CDate(FechaIniFlujo) And CDate(gsBAC_Fecp) <= CDate(CDate(Grd.TextMatrix(cuenta, 1)))) Then
           Tasa = CDbl(iValorTasaIBR(CodMoneda, FechaIniFlujo, gsBAC_Fecp) + Spread)
      Else
         Tasa = CDbl(Grd.TextMatrix(cuenta, 3))
      End If

      DiasDif = IIf(PeriDias = "A", DateDiff("d", CDate(FechaVencAnt), CDate(FechaAmortiza)), BacDifDias30(CDate(FechaVencAnt), CDate(FechaAmortiza), PeriDias)) ', PeriDias

      FecVAnt = FechaVencAnt
      FechaVencAnt = Grd.TextMatrix(cuenta, 1)
      Plazo = BacDiv(CDbl(DiasDif), CDbl(Val(Base)))
      nRedondeo = IIf(CodMoneda = 999, 0, DecAmortizacion)  '4)
      
      If CodMoneda = 998 Then
         nRedondeo = 4
      End If
      
      'Interes = Round(MontoAmortiza * (Tasa / 100) * (Plazo), nRedondeo)
      Let Interes = Round(SaldoInsoluto * (Tasa / 100) * (Plazo), nRedondeo)

      If CodMoneda = 999 Or CodMoneda = 998 Then
         MontoCLP = Round((Interes * FactorUSD), 0)
         MontoUSD = Round((BacDiv(MontoCLP, CDbl(FactorCLP))), DecAmortizacion)  '3)
      ElseIf CodMoneda = 13 Or Referencial = 1 Then
         MontoUSD = Interes
         MontoUSD = Round(MontoUSD, DecAmortizacion)  '4)
         MontoCLP = Round((MontoUSD * FactorCLP), 0)
      Else
         If MiLado = Derecho Or MiLado = Der_Tran Then
            If cSwMxV = "C" And CodMoneda <> 13 Then
               nParidad# = I_ValorMoneda.Text
               MontoUSD = IIf(cRrdaV = "M", (Interes * nParidad#), (BacDiv(Interes, nParidad#)))
            Else
               MontoUSD = IIf(Val(MonFuerteC) = 1, (Interes * FactorUSD), (BacDiv(Interes, CDbl(FactorUSD))))
            End If
         Else
            If cSwMxC = "C" And CodMoneda <> 13 Then
               nParidad# = D_ValorMoneda.Text
               MontoUSD = IIf(cRrdaV = "M", (Interes * nParidad#), (BacDiv(Interes, nParidad#)))
            Else
               MontoUSD = IIf(Val(MonFuerteC) = 1, (Interes * FactorUSD), (BacDiv(Interes, CDbl(FactorUSD))))
            End If
         End If
         
         MontoUSD = Round(MontoUSD, DecAmortizacion) '3)
         MontoCLP = Round((MontoUSD * FactorCLP), 0)
      End If
      
      Dim cxMoneda As String
      cxMoneda = IIf(MiLado = Derecho Or MiLado = Der_Tran, D_NemMon.Caption, I_NemMon.Caption)

      TotalVenc = MontoGrd + Interes
      
      Grd.TextMatrix(cuenta, 4) = Format(Interes, TipoFormato(cxMoneda))
      Grd.TextMatrix(cuenta, 5) = Format(TotalVenc, TipoFormato(cxMoneda))
      'Este es el futuro compra_saldo y venta_saldo de la base de
      'datos para el flujo i
      Grd.TextMatrix(cuenta, 8) = CDbl(SaldoInsoluto - Amortizacion)
      
      Grd.TextMatrix(cuenta, 9) = FecVAnt
      Grd.TextMatrix(cuenta, 10) = SaldoInsoluto
      
      Grd.TextMatrix(cuenta, 11) = MontoUSD
      Grd.TextMatrix(cuenta, 12) = MontoCLP
      Grd.TextMatrix(cuenta, 17) = Format(SaldoInsoluto, TipoFormato(cxMoneda))
      
      Let SaldoInsoluto = CDbl(SaldoInsoluto - Amortizacion)
      
      MontoCapital = IIf((MontoCapital = 0), 1, MontoCapital)
      Let AmortizaPrc = CDbl(100 * (CDbl(Grd.TextMatrix(cuenta, 10)) - SaldoInsoluto) / MontoCapital)
      
      Grd.TextMatrix(cuenta, 18) = AmortizaPrc
      
      Grd.TextMatrix(cuenta, 23) = CDbl(UltimoIndice)  'CDbl(Tasa)
      Grd.TextMatrix(cuenta, 24) = CDbl(Spread)
     
      iNeteoAmortizacion = CDbl(Grd.TextMatrix(cuenta, 2))
      iNeteoInteres = CDbl(Grd.TextMatrix(cuenta, 4))
      
      iMontoNeteo = 0#
            
      '*********************************************************************************************************
         
      nPlazoDesc = DateDiff("D", gsBAC_Fecp, Grd.TextMatrix(cuenta, columna.colFecLiquida))
'prd19111 ini
      If Grd.TextMatrix(cuenta, columna.colFlujoAdicional) = "" Then
          nMontoFlujoAdicional = 0
      Else
      nMontoFlujoAdicional = Grd.TextMatrix(cuenta, columna.colFlujoAdicional)
      End If
      'prd19111 fin
     ' nMontoFlujoAdicional = Grd.TextMatrix(cuenta, Columna.colFlujoAdicional)
      Amortizacion = Amortizacion * CDbl(IIf(Grd.TextMatrix(cuenta, columna.colIntNoc) = "No", 0, 1))
   
      If Grd.TextMatrix(cuenta, columna.colFecLiquida) = gsBAC_Fecp Then
         Interes = 0#
         Amortizacion = 0#
         nMontoFlujoAdicional = 0#
      End If
      
     '--> Obtiene tasa de descuento segun plazo de dias corridos.
      Envia = Array()
      AddParam Envia, CodMoneda
      AddParam Envia, nPlazoDesc
      AddParam Envia, "PCS"
      AddParam Envia, cProducto
      AddParam Envia, nTipoTasa
      AddParam Envia, nTipoFlujo
      AddParam Envia, Base 'nBase
      AddParam Envia, "C"
      AddParam Envia, nCodigoTasa
      AddParam Envia, "CERO"
      AddParam Envia, "Forward"
      
      If Not Bac_Sql_Execute("BACFWDSUDA..SP_RETORNATASAMONEDA", Envia) Then
         Screen.MousePointer = vbDefault
         MsgBox "Ha ocurrido un error al intentar buscar la tasa por moneda", vbCritical + vbOKOnly
         Exit Function
      End If
      
      If Bac_SQL_Fetch(Datos()) Then
         nTasaDesc = CDbl(Datos(1))
         nSpreadDesc = CDbl(Datos(2))
      End If
      
      If nTasaDesc = 0# Then
         nTasaDesc = 0.0001
      End If
      
      '-->       Cuabndo es Act/Act, el periodicidad de la Base es "A", se debe asumir 365.
      PeriBase = IIf(PeriBase = "A", 365, PeriBase)
      '-->       Cuabndo es Act/Act, el periodicidad de la Base es "A", se debe asumir 365.
      
      nFlujoDesc = (Interes + Amortizacion + nMontoFlujoAdicional) / ((1 + (nTasaDesc + nSpreadDesc) / 100#) ^ (nPlazoDesc / CDbl(PeriBase)))         '--Valorización Swap x Curva
     
      Grd.TextMatrix(cuenta, columna.colValorRazonable) = Format(Round(nFlujoDesc, 2), "#,##0.00")
      
      If MiLado = Lados.Izquierdo Then
         nTotalVR_Recibe = nTotalVR_Recibe + nFlujoDesc
      ElseIf MiLado = Lados.Izq_Tran Then
         nTotalVR_Recibe_Tran = nTotalVR_Recibe_Tran + nFlujoDesc
      ElseIf MiLado = Lados.Derecho Then
         nTotalVR_Paga = nTotalVR_Paga + nFlujoDesc
      ElseIf MiLado = Lados.Der_Tran Then
         nTotalVR_Paga_Tran = nTotalVR_Paga_Tran + nFlujoDesc
      End If
      
   Next cuenta
   
   '***************************************************************************************************************************
   
   If CodMoneda = 13 Then
      FactorUSD = FactorCLP
   End If

   If MiLado = Lados.Izquierdo Then
      nTotalVR_Recibe = Round((nTotalVR_Recibe * FactorUSD), 0)
   ElseIf MiLado = Lados.Izq_Tran Then
      nTotalVR_Recibe_Tran = Round((nTotalVR_Recibe_Tran * FactorUSD), 0)
   ElseIf MiLado = Lados.Derecho Then
      nTotalVR_Paga = Round((nTotalVR_Paga * FactorUSD), 0)
   ElseIf MiLado = Lados.Der_Tran Then
      nTotalVR_Paga_Tran = Round((nTotalVR_Paga_Tran * FactorUSD), 0)
   End If
   
   ssp_AvrOpe.Caption = Format((nTotalVR_Recibe - nTotalVR_Paga), "#,##0.00")
   ssp_AvrTran.Caption = Format((nTotalVR_Recibe_Tran - nTotalVR_Paga_Tran), "#,##0.00")
   nResultadoMD = (nTotalVR_Recibe - nTotalVR_Paga) - (nTotalVR_Recibe_Tran - nTotalVR_Paga_Tran)
   'ssp_Res_Mesa_Dist.Caption = Format((nTotalVR_Recibe) - Abs((nTotalVR_Paga - nTotalVR_Recibe_Tran)) - nTotalVR_Paga_Tran, "#,##0.00")

   Let bSwWriteResultadoClp = False
   txt_Res_Mesa_Dist.CantidadDecimales = 0: txt_Res_Mesa_Dist.ForeColor = IIf(nResultadoMD >= 0, vbBlack, vbRed)
   txt_Res_Mesa_Dist.Text = Format(nResultadoMD, "#,##0.00")
  
   'ssp_Res_Mesa_Dist_USD.Caption = Format((ssp_Res_Mesa_Dist.Caption / gsBAC_DolarObs), "#,##0.00")

   Let bSwWriteResultadoUsd = False
   txt_Res_Mesa_Dist_USD.CantidadDecimales = 4: txt_Res_Mesa_Dist_USD.ForeColor = IIf((nResultadoMD / gsBAC_DolarObs) >= 0, vbBlack, vbRed)
   txt_Res_Mesa_Dist_USD.Text = Format((nResultadoMD / gsBAC_DolarObs), "#,##0.0000")
   
   
   Set Grd = Nothing
   
   Call GeneraNeteo
End Function

Private Function MiDiaHabil(cFecha As String, Plaza As Integer) As Boolean
   Dim objFeriado As New clsFeriado
   Dim iAno       As Integer
   Dim iMes       As Integer
   Dim sDia       As String
   Dim gcPlaza    As String
   Dim n          As Integer

   gcPlaza = String(5 - Len(Trim(Plaza)), "0") & Trim(Str(Trim(Plaza)))

   If Weekday(cFecha) = 1 Or Weekday(cFecha) = 7 Then
      MiDiaHabil = False
      Exit Function
   End If

   iAno = DatePart("yyyy", cFecha)
   iMes = DatePart("m", cFecha)
   sDia = Format(DatePart("d", cFecha), "00")

   Call objFeriado.Leer(iAno, gcPlaza)
   Select Case iMes
      Case 1:  n = InStr(objFeriado.feene, sDia)
      Case 2:  n = InStr(objFeriado.fefeb, sDia)
      Case 3:  n = InStr(objFeriado.femar, sDia)
      Case 4:  n = InStr(objFeriado.feabr, sDia)
      Case 5:  n = InStr(objFeriado.femay, sDia)
      Case 6:  n = InStr(objFeriado.fejun, sDia)
      Case 7:  n = InStr(objFeriado.fejul, sDia)
      Case 8:  n = InStr(objFeriado.feago, sDia)
      Case 9:  n = InStr(objFeriado.fesep, sDia)
      Case 10: n = InStr(objFeriado.feoct, sDia)
      Case 11: n = InStr(objFeriado.fenov, sDia)
      Case 12: n = InStr(objFeriado.fedic, sDia)
   End Select
   Set objFeriado = Nothing

   MiDiaHabil = IIf(n > 0, False, True)
End Function

Private Sub Alineacion(nGrid As MSFlexGrid, nText As Object)
    On Error Resume Next
    nText.Top = nGrid.Top + nGrid.CellTop + 10
    nText.Left = nGrid.Left + nGrid.CellLeft + 50
    nText.Width = nGrid.CellWidth - 10
    nText.Height = nGrid.CellHeight - 10

    nText.Text = nGrid.TextMatrix(nGrid.RowSel, nGrid.ColSel)
    nText.SelStart = Len(nText.Text)
    nText.Visible = True
    nGrid.Enabled = False

    nText.SetFocus
    
    On Error GoTo 0
End Sub

Private Function ValidacionPreGeneracio() As Boolean
   'Dim iCadena As String

   ValidacionPreGeneracio = False

   iCadena = ""
   If I_Moneda.ListIndex = -1 Or D_Moneda.ListIndex = -1 Then
      iCadena = iCadena & " - Debe seleccionar las monedas." & vbCrLf
   End If
   
   'CER 25/04/2008  - Req. Pantalla Ingreso Op. Swap
   '//No permite que se generen flujos con Nocionales en cero para los IRF e ICP
   If EntregaTipoSwap <> 2 Then
        If I_Nocionales.Text = 0# Or D_Nocionales.Text = 0# Then
            iCadena = iCadena & " - Debe ingresar los nocionales." & vbCrLf
        End If
   End If
   
   If I_FrecuenciaPago.ListIndex = -1 Or D_FrecuenciaPago.ListIndex = -1 Then
      iCadena = iCadena & " - Debe seleccionar las frecuencias de pago." & vbCrLf
   End If
   If I_FrecuenciaCapital.ListIndex = -1 Or D_FrecuenciaCapital.ListIndex = -1 Then
      iCadena = iCadena & " - Debe seleccionar las frecuencias de amortización de capital." & vbCrLf
   End If
   If I_Indicador.ListIndex = -1 Or D_Indicador.ListIndex = -1 Then
      iCadena = iCadena & " - Debe seleccionar los indicadores." & vbCrLf
   End If
   If I_ConteoDias.ListIndex = -1 Or D_ConteoDias.ListIndex = -1 Then
      iCadena = iCadena & " - Debe seleecionar conteo de dias." & vbCrLf
   End If
   If (CDate(I_FechaEfectiva.Text) >= CDate(I_Madurez.Text)) Or (CDate(D_FechaEfectiva.Text) >= CDate(D_Madurez.Text)) Then
      iCadena = iCadena & " - Favor revisar las fecha de madurez" & vbCrLf
   End If
   
   Dim nCantDecimales   As Long
   Let nCantDecimales = CuentaDecimales(I_UltimoIndice.Text)
   Let nCantDecimales = IIf(nCantDecimales > CuentaDecimales(I_Spread.Text), nCantDecimales, CuentaDecimales(I_Spread.Text))
   Let nCantDecimales = IIf(nCantDecimales > CuentaDecimales(D_UltimoIndice.Text), nCantDecimales, CuentaDecimales(D_UltimoIndice.Text))
   Let nCantDecimales = IIf(nCantDecimales > CuentaDecimales(D_Spread.Text), nCantDecimales, CuentaDecimales(D_Spread.Text))
   If nCantDecimales < 2 Then
      Let nCantDecimales = 2
   End If
   
   Let NumDecTasa.Text = nCantDecimales
   
   
   '-- MAP 20080425
   If NumDecTasa.Text < (CuentaDecimales(I_UltimoIndice.Text)) Or _
      NumDecTasa.Text < (CuentaDecimales(I_Spread.Text)) Or _
      NumDecTasa.Text < (CuentaDecimales(D_UltimoIndice.Text)) Or _
      NumDecTasa.Text < (CuentaDecimales(D_Spread.Text)) Then
      iCadena = iCadena & " - valor Dec. Tas no corresponde a las tasas ingresadas" & vbCrLf
   End If

   Let nCantDecimales = CuentaDecimales(I_Nocionales.Text)
   Let nCantDecimales = IIf(nCantDecimales > CuentaDecimales(D_Nocionales.Text), nCantDecimales, CuentaDecimales(D_Nocionales.Text))
   If nCantDecimales < 2 Then
      Let nCantDecimales = 2
   End If
   
   Let NunDecimales.Text = nCantDecimales
   
   If (NunDecimales.Text < CuentaDecimales(I_Nocionales.Text) Or _
       NunDecimales.Text < CuentaDecimales(D_Nocionales.Text)) Then
      iCadena = iCadena & " - valor Dec. Am. no corresponde a los decimales del Nocional" & vbCrLf
   End If
   '-- MAP 20080425

   If iCadena = "" Then
      If ValorAmort(I_FrecuenciaCapital, "M") > DateDiff("M", I_FechaEfectiva.Text, I_Madurez.Text) Then
         iCadena = iCadena & " - No es posible cubrir la frecuencia de capitalización a la Fecha de Madurez."
      Else
         If ValorAmort(D_FrecuenciaCapital, "M") > DateDiff("M", D_FechaEfectiva.Text, D_Madurez.Text) Then
            iCadena = iCadena & " - No es posible cubrir la frecuencia de capitalización a la Fecha de Madurez."
         End If
      End If
   End If

   If iCadena <> "" Then
      MsgBox "Validación" & vbCrLf & vbCrLf & "Se ha encontrado que :" & vbCrLf & iCadena, vbExclamation, TITSISTEMA
      Exit Function
   End If
   ValidacionPreGeneracio = True
End Function

Private Sub CapitalizacionFlujos(MiLado As String, iPeriodoCapital As Integer, MiGrilla As MSFlexGrid, iMoneda As Integer)
   Dim iFactor          As Double
   Dim nRedondeo        As Integer
   Dim nCapital         As Double
   Dim dFechaTermino    As Date
   Dim dFechaInicio     As Date
   Dim dFechaAmortiza   As Date
   Dim MontoAmortCap    As Double
   Dim MontoCuadratura  As Double
   Dim iContador        As Integer
   Dim iTasa            As Double
   Dim iMontoonLine     As Double

   nCapital = IIf(MiLado = "I", I_Nocionales.Text, D_Nocionales.Text)
   dFechaTermino = IIf(MiLado = "I", I_Madurez.Text, D_Madurez.Text)
   dFechaInicio = IIf(MiLado = "I", I_FechaEfectiva.Text, D_FechaEfectiva.Text)
   dFechaAmortiza = IIf(iPeriodoCapital <= 0, dFechaTermino, DateAdd("M", iPeriodoCapital, dFechaInicio))

   MiTasa = IIf(MiLado = "I", CDbl(I_UltimoIndice.Text) + CDbl(I_Spread.Text), CDbl(D_UltimoIndice.Text) + CDbl(D_Spread.Text))

   iFactor = 1
   If iPeriodoCapital > 0 Then
      iFactor = Round((BacDiv(DateDiff("M", dFechaAmortiza, CDate(dFechaTermino)), CDbl(iPeriodoCapital)) + 1#), 0)
   End If
   nRedondeo = IIf(iMoneda = 999, 0, DecAmortizacion) '4)
   If iMoneda = 998 Then
      nRedondeo = 4
   End If
   
   MontoAmortCap = Round((CDbl(nCapital) / iFactor), nRedondeo)
   MontoCuadratura = nCapital - (MontoAmortCap * iFactor)

   iMontoonLine = 0#

   For iContador = 1 To MiGrilla.Rows - 1
      If CDate(MiGrilla.TextMatrix(iContador, 1)) = dFechaAmortiza Then
         If dFechaAmortiza = dFechaTermino Then
            MontoAmortCap = CDbl(MontoAmortCap) + CDbl(MontoCuadratura)
         End If
         MiGrilla.TextMatrix(iContador, 2) = Format(MontoAmortCap, TipoFormato(IIf(iMoneda = 999, "CLP", "UDS")))
         iMontoonLine = iMontoonLine + MontoAmortCap
         dFechaAmortiza = IIf(iPeriodoCapital <= 0, dFechaTermino, DateAdd("M", iPeriodoCapital, dFechaAmortiza))
      Else
         MiGrilla.TextMatrix(iContador, 2) = Format(0#, TipoFormato(IIf(iMoneda = 999, "CLP", "UDS")))
      End If
      MiGrilla.TextMatrix(iContador, 3) = Format(MiTasa, TipoFormato("USD"))
   Next iContador

   If MiLado = "I" Then
      If iMontoonLine < I_Nocionales.Text Then
         MiGrilla.TextMatrix(MiGrilla.Rows - 1, 2) = Format(CDbl(MontoAmortCap) + CDbl(MontoCuadratura), TipoFormato(IIf(iMoneda = 999, "CLP", "UDS")))
      End If
   End If
   If MiLado = "D" Then
      If iMontoonLine < D_Nocionales.Text Then
         MiGrilla.TextMatrix(MiGrilla.Rows - 1, 2) = Format(CDbl(MontoAmortCap) + CDbl(MontoCuadratura), TipoFormato(IIf(iMoneda = 999, "CLP", "UDS")))
      End If
   End If
End Sub

Private Sub AplicarValidacionFeriados(Lado As Lados, grillas As MSFlexGrid)
   Dim iContador     As Integer
   Dim dFechaFlujo   As Date
   Dim Inicio        As Boolean 'True Fixing al inicio, False al termino
   
   For iContador = 1 To grillas.Rows - 1
      ''''SSFlujos.Tab = IIf(Lado = "D", 1, 0)
      If Lado < 2 Then
         SSFlujos.Tab = Lado - 1
      End If

      'Vencimiento, en otras le dicen malamente Amortización
      dFechaFlujo = grillas.TextMatrix(iContador, 15)
      dFechaFlujo = ReCalculaDiasFeridos(Lado, CDate(dFechaFlujo), True, False)
      grillas.TextMatrix(iContador, 1) = Format(dFechaFlujo, "dd/mm/yyyy")
      
      'Liquidacion, pivote es siempre fecha vencimiento
      dFechaFlujo = grillas.TextMatrix(iContador, 1)
      dFechaFlujo = ReCalculaDiasFeridos(Lado, CDate(dFechaFlujo), False, False)
      grillas.TextMatrix(iContador, 14) = Format(dFechaFlujo, "dd/mm/yyyy")
      
      '************************PRD21657
      grillas.TextMatrix(iContador, 29) = IIf(Lado = Izquierdo, I_RefUSDCLP, D_RefUSDCLP)
      grillas.TextMatrix(iContador, 30) = IIf(Lado = Izquierdo, I_RefMEXUSD, D_RefMEXUSD)
      
      
      grillas.TextMatrix(iContador, 31) = Format(DateAdd("D", IIf(Lado = Izquierdo, I_RefUSDCLP, D_RefUSDCLP), Format(dFechaFlujo, "DD-MM-YYYY")))
      grillas.TextMatrix(iContador, 32) = Format(DateAdd("D", IIf(Lado = Izquierdo, I_RefMEXUSD, D_RefMEXUSD), Format(dFechaFlujo, "DD-MM-YYYY")))
      
      '************************PRD21657
      
      
      'Reset --> Fijacion Tasa
      'Pivote es la fecha de inicio o vencimiento según la opción en pantalla
      Let Inicio = Me.Option2(0)
      
      If Inicio Then
         dFechaFlujo = grillas.TextMatrix(IIf(iContador = 1, 1, iContador - 1), 1)
      Else
         dFechaFlujo = grillas.TextMatrix(iContador, 1)
      End If

      dFechaFlujo = CalculaDiasReset(Lado, CDate(dFechaFlujo))
      grillas.TextMatrix(iContador, 16) = Format(dFechaFlujo, "dd/mm/yyyy")
   Next iContador

End Sub

Private Sub AplicarValidacionFeriadosExcel(Lado As Lados, grillas As MSFlexGrid, datoFecha As Integer)
   Dim iContador     As Integer
   Dim dFechaFlujo   As Date
   Dim Inicio        As Boolean 'True Fixing al inicio, False al termino
  
   
   For iContador = 1 To grillas.Rows - 1
      ''''SSFlujos.Tab = IIf(Lado = "D", 1, 0)
      
      SSFlujos.Tab = IIf(Lado < 2, Lado, 0)

      If datoFecha = 1 Then 'Corregir Solamente Vencimiento y liquidacion segun los cuadros de chequeo
         'Amortizacion
         dFechaFlujo = grillas.TextMatrix(iContador, 1)  'Toma como pivote lo que esta como vencimiento en la grilla
         dFechaFlujo = ReCalculaDiasFeridos(Lado, CDate(dFechaFlujo), True, False)
         grillas.TextMatrix(iContador, 1) = Format(dFechaFlujo, "dd/mm/yyyy")
      
         'Liquidacion
          dFechaFlujo = grillas.TextMatrix(iContador, 14)  'Toma como pivote lo que esta en la grilla
          dFechaFlujo = ReCalculaDiasFeridos(Lado, CDate(dFechaFlujo), False, False)
          grillas.TextMatrix(iContador, 14) = Format(dFechaFlujo, "dd/mm/yyyy")
      Else
          'Reset --> Fijacion Tasa
          Let Inicio = Me.Option2(0)
          
          If Inicio Then
              dFechaFlujo = grillas.TextMatrix(IIf(iContador = 1, 1, iContador - 1), 1)
          Else
              dFechaFlujo = grillas.TextMatrix(iContador, 1)
          End If
          
          '3: Reset
          dFechaFlujo = CalculaDiasReset(Lado, CDate(dFechaFlujo))
          grillas.TextMatrix(iContador, 16) = Format(dFechaFlujo, "dd/mm/yyyy")
       End If
   Next iContador

End Sub

Private Function ChequeaAmortizaciones(MiTipoSwap As Integer) As Boolean
   Dim iContador  As Integer
   Dim iRegistros As Integer
   Dim dFecha     As Date
   Dim iMonto     As Double
   
   'MAP 20081210 chequeo de amortizaciones de Swap de Tasas
   Dim GrFecIzq(1000) As Date
   Dim GrMtoIzq(1000) As Double
   Dim GrFecDer(1000) As Date
   Dim GrMtoDer(1000) As Double
   Dim kContadorI     As Integer
   Dim kContadorD     As Integer
   Dim Existe         As Boolean
   
   'Agrupar por fecha de pago

'   If MiTipoSwap <> 2 Then
         
      'Agrupación de Amortizaciones por fecha, pata izquierda
      Let kContadorI = 0
      For iContador = 1 To I_Grid.Rows - 1
         Let Existe = False
         For jContador = 1 To kContadorI
            If GrFecIzq(jContador) = I_Grid.TextMatrix(iContador, 14) Then
               Let GrMtoIzq(kContadorI) = GrMtoIzq(kContadorI) + I_Grid.TextMatrix(iContador, 2)
               Let Existe = True
            End If
         Next jContador
         If Not (Existe) Then
            Let kContadorI = kContadorI + 1
            Let GrFecIzq(kContadorI) = I_Grid.TextMatrix(iContador, 14)
            Let GrMtoIzq(kContadorI) = I_Grid.TextMatrix(iContador, 2)
         End If
      Next iContador
      
      'Agrupación de Amortizaciones por fecha, pata derecha, revisar !!!
      Let kContadorD = 0
      For iContador = 1 To D_Grid.Rows - 1
         Let Existe = False
         For jContador = 1 To kContadorD
            If GrFecDer(jContador) = D_Grid.TextMatrix(iContador, 14) Then
               Let GrMtoDer(kContadorD) = GrMtoDer(kContadorD) + D_Grid.TextMatrix(iContador, 2)
               Let Existe = True
            End If
         Next jContador
         If Not (Existe) Then
            Let kContadorD = kContadorD + 1
            Let GrFecDer(kContadorD) = D_Grid.TextMatrix(iContador, 14)
            Let GrMtoDer(kContadorD) = D_Grid.TextMatrix(iContador, 2)
         End If
      Next iContador
         
 '  End If  Swap de monedas, sacar después
   
   iRegistros = IIf(kContadorI >= kContadorD, I_Grid.Rows, D_Grid.Rows)
   
   ChequeaAmortizaciones = False
   
   '--> Recorre la Izquierda sobre la Derecha (Flujos)
   For iContador = 1 To kContadorI
      ' 22/08/2008 - Se Cambia fecha de Vencimiento de flujo por
      ' fecha de Pago(Liquidación), columna 1 por columna 14
      dFecha = GrFecIzq(iContador)
      iMonto = GrMtoIzq(iContador)
      For iRegistros = 1 To kContadorD
         If dFecha = CDate(GrFecDer(iRegistros)) Then
            'MAP 15/07/2008 - Se agrega a condición And MiTipoSwap <> 2
            If iMonto <> CDbl(GrMtoDer(iRegistros)) And MiTipoSwap <> 2 Then
               Exit Function '--> Monto no concuerda.
            End If
            iMonto = 0#
            Exit For
         End If
      Next iRegistros
      If iMonto <> 0# Then
         Exit Function       '--> Flujo Con amortización sin Flujo Contrario
      End If
   Next iContador
   
   '--> Recorre la Derecha sobre la Izquierda (Flujos)
   For iContador = 1 To kContadorD
   ' 22/08/2008 - Se Cambia fecha de Vencimiento de flujo por
   ' fecha de Pago(Liquidación), columna 1 por columna 14
      dFecha = GrFecDer(iContador)
      iMonto = GrMtoDer(iContador)
      For iRegistros = 1 To kContadorI
         If dFecha = CDate(GrFecIzq(iRegistros)) Then
         'MAP 15/07/2008 - Se agrega a condición And MiTipoSwap <> 2
            If iMonto <> CDbl(GrMtoIzq(iRegistros)) And MiTipoSwap <> 2 Then
               Exit Function '--> Monto no concuerda.
            End If
            iMonto = 0#
            Exit For
         End If
      Next iRegistros
      If iMonto <> 0# Then
         Exit Function       '--> Flujo Con amortización sin Flujo Contrario
      End If
   Next iContador

      
   ChequeaAmortizaciones = True
   
End Function

Private Function ValidaMontos() As Boolean
   Dim iFlujo     As Integer
   Dim iContador  As Integer
   Dim iMonto     As Double
   Dim Fija       As Boolean
   Dim MiGrilla   As MSFlexGrid
   Dim iNocional  As Double
   Dim MiTipoSwap As Integer
   
   ValidaMontos = False
   MiTipoSwap = MiObjSwap.EntregaTipoSwap(Me)
   
  ' MAP 15/07/2008 - Se agrega a condición  Swap de Monedasd y Swap Promedio Cámara
   If MiTipoSwap = 1 Or MiTipoSwap = 4 Then   '' Or MiTipoSwap = 2
  ' 21/08/2008 Se comenta, ya que para Swap de monedas no se chequeará montos ni fechas.
  ' MAP 15/07/2008 - Se agrega  parámetro a  Función ChequeaAmortizaciones
      If MiTipoSwap = 4 Then ' ->>AGF<<- '25-05-2009' .- Se solicito que se puedan ingresar Amortizaciones Disparejas Para los Swap IRF. (Excluye MiTipoSwap = 1 del control).-
                             ' Ademas se solicito chequear Amortizaciones solamente para Swap Promedio Camara en Moneda UF.-
         If I_Moneda.ItemData(I_Moneda.ListIndex) = 998 Or D_Moneda.ItemData(D_Moneda.ListIndex) = 998 Then
      If ChequeaAmortizaciones(MiTipoSwap) = False Then
         MsgBox "Favor revisar las amortizaciones..." & vbCrLf & "No deben existir amortizaciones disparejas para este producto.", vbExclamation, TITSISTEMA
         Exit Function
      End If
   End If
      End If

   End If
   
   For iFlujo = 1 To 2
      If iFlujo = 1 Then
         iMonto = 0#
         iNocional = 0#
         Set MiGrilla = I_Grid
         Fija = IIf(Left(I_Indicador.Text, 4) = "FIJA", True, False)
         iNocional = Round(I_Nocionales.Text, Val(NunDecimales.Text))
      End If
      If iFlujo = 2 Then
         iMonto = 0#
         iNocional = 0#
         Set MiGrilla = D_Grid
         Fija = IIf(Left(D_Indicador.Text, 4) = "FIJA", True, False)
         iNocional = Round(D_Nocionales.Text, Val(NunDecimales.Text))
      End If

      For iContador = 1 To MiGrilla.Rows - 1
         iMonto = iMonto + CDbl(MiGrilla.TextMatrix(iContador, 2))
      Next iContador
      
      CantDecimales = Val(NunDecimales) '¡...' 'Por si se pierde la Cantidad de Decimales, la vuelve a setear' '...!'
      
' CER 15/04/2008  - Req. Pantalla Ingreso Op. Swap
      
'      If iMonto <> iNocional Then
'         If Round(iMonto, CantDecimales) > iNocional Then
'            MsgBox "Validacion Parte " & IIf(Fija = True, "FIJA", "VARIABLE") & vbCrLf & vbCrLf & "La Suma de las Amortizaciones Exceden al Nocional Especificado." & vbCrLf & Format(iMonto, TipoFormato("USD")), vbExclamation, TITSISTEMA
'            Exit Function
'         End If
'         If Round(iMonto, CantDecimales) < iNocional Then
'            MsgBox "Validacion Parte " & IIf(Fija = True, "FIJA", "VARIABLE") & vbCrLf & vbCrLf & "La Suma de las Amortizaciones es Inferior al Nocional Especificado." & vbCrLf & Format(iMonto, TipoFormato("USD")), vbExclamation, TITSISTEMA
'            Exit Function
'         End If
'      End If

      'Control de suma de amortizaciones
      If Round(iMonto, IIf(Val(NunDecimales.Text) < 1, 0, Val(NunDecimales.Text) - 1)) <> 0 Then
            MsgBox "La Suma de las Amortizaciones debe ser igual a Cero." & vbCrLf & Format(iMonto, TipoFormato("USD")), vbExclamation, TITSISTEMA
            Exit Function
      End If

      Set MiGrilla = Nothing
   Next iFlujo

   If I_MonPago.ListIndex = -1 Or I_MedioPago.ListIndex = -1 Then
      MsgBox "Debe asignar un una moneda de pago y medio de pago. ", vbExclamation, TITSISTEMA
      Exit Function
   End If
   If D_MonPago.ListIndex = -1 Or D_MedioPago.ListIndex = -1 Then
      MsgBox "Debe asignar un una moneda de pago y medio de pago. ", vbExclamation, TITSISTEMA
      Exit Function
   End If
   
   
   ValidaMontos = True
   
End Function
Private Function Simular() As Boolean
Dim procesoSim As Boolean
procesoSim = MiObjSwap.PreGrabadoSim(Me)
Simular = procesoSim
End Function
Private Function Func_Grabacion() As Boolean
   Dim TipoSwap   As Integer

   Func_Grabacion = False

   iAceptar = False
   TipoSwap = EntregaTipoSwap
   Tipo_Producto = IIf(TipoSwap = 1, "ST", IIf(TipoSwap = 2, "SM", "SP"))

   BacGrabar.MiFormulario = "Nuevo Swap"
   BacGrabar.MiTipoSwap = TipoSwap
   
   If Me.Tag <> "" Then
      BacGrabar.iModificacion = True
      BacGrabar.TxtRut.Text = iRut
      BacGrabar.txtCliente.Tag = CodCliente
      BacGrabar.txtCliente.Text = cNombre
      Call CargaItemCombo(BacGrabar.cmbCartera, cCarteraFinanciera)
      Call CargaItemCombo(BacGrabar.CmbArea, cAreaResponsable)
      Call CargaItemCombo(BacGrabar.CmbLibro, cLibroNegociacion)
      Call CargaItemCombo(BacGrabar.CmbCartNorm, cCarteraNormativa)
      Call CargaItemCombo(BacGrabar.CmbSubCartera, cSubCartera)
   End If
   
  
   
   'PRD 12712 - 21707 Early Termination, Int Noc
   'If InterNocIni.Value = True Then
   If InterNocIni(0) = True Then
        Let giMarcaInterNocIni = InterNocIni(0) 'IIf(OptInterNoc.Value, 1, 0)
        Let giInterNocIni = 1
    Else
        Let giMarcaInterNocIni = InterNocIni(1) 'IIf(OptInterNoc.Value, 1, 0)
        Let giInterNocIni = 0
    End If
    
    If InterNocFin(0) = True Then
        Let giMarcaInterNocFin = InterNocFin(0) 'IIf(OptInterNoc.Value, 1, 0)
        Let giInterNocFin = 1
    Else
        Let giMarcaInterNocFin = InterNocFin(1) 'IIf(OptInterNoc.Value, 1, 0)
        Let giInterNocFin = 0
    End If
    
   
   BacGrabar.Show vbModal
   
   
   Screen.MousePointer = vbDefault

   'Inicio PRD 12712 - 21707 Early Termination, Int Noc
    Let giAceptar_EarlyTermination = False
    Let giMarca_EarlyTermination = 0
    Let giPeriodicidad_EarlyTermination = 0
    Let giFechaInicio_EarlyTermination = "1900-01-01"
    
   If FRM_SWAP_OP.Lblcheck = 0 Then
      Call EarlyTermination.Show(vbModal)
   End If
   'Fin PRD 12712 - 21707 Early Termination, Int Noc
   
   
   If iAceptar = True Then
        If Not RutCliente = "97023000" Then
            Grabacion = MiObjSwap.PreGrabado(Me)
         
            'PROD-10967
'            If ParamMoneda_LCR = True Then
'                 Exit Function
'            End If
                    
         'PRD-4858, 16-02-2010.  Asignación del N° de operacion
         Thr_NumeroOperacion = MiObjSwap.A01_NumeroOperacion
            Func_Grabacion = Grabacion
         
            If Grabacion = False Then
            Call Limpiar
                Exit Function
            Else
                If Val(Thr_NumeroOperacion) > 0 Then
                    '*************************************************
                    ' CONFIRMACION DE PROCESO CONTROL MARGENES (ART84)
                    ' ************************************************
                    ' reviso si el Flag de encendido del proceso
                    If blnProcesoArt84Activo("PCS") Then
                        If glngNroTicket > 0 Then
                            Call GeneraConfirmacionProceso(glngNroTicket, CLng(Thr_NumeroOperacion), "PCS", gstrNrosOperacionesIBS)
                        End If
                    End If
                End If
            End If
        If Me.Option1(0) Then  'Esta tratando de grabar cotización
            MsgBox "ALERTA: Se grabó una Cotización... ", vbExclamation
        End If
        Else
            If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
               MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
               Exit Function
            End If
            
            nNumOpeTicket = MiObjSwapTicket.NuevoNumTicket
            
            GrabaOpe = MiObjSwapTicket.GrabaOpTicket(Me)
            
            If GrabaOpe Then Grabacion = MiObjSwapTicket.PreGrabaTicket(Me)
            
            Func_Grabacion = Grabacion
            If Grabacion = False Then
                If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                    MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
                    PreGrabaTicket = False
                Exit Function
            End If
                Exit Function
            Else
                If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
                    Screen.MousePointer = vbDefault
                    MsgBox "Error en la grabación" & vbCrLf & "Imposible generar transacciones.", vbExclamation, TITSISTEMA
                    Exit Function
                End If
            
            End If
            
            
        End If
      Call Limpiar
        Screen.MousePointer = vbDefault
   Else
      MsgBox "La Grabación Ha Sido Cancelada Manualmente. ", vbExclamation, TITSISTEMA
   End If
End Function

Private Function EntregaTipoSwap() As Integer
   On Error Resume Next
   If I_Moneda.ListIndex = -1 Or D_Moneda.ListIndex = -1 Then
      MsgBox "Debe seleccionar ambas monedas antes de prosegir.", vbInformation, TITSISTEMA
      EntregaTipoSwap = -1
   End If
   
   If I_Moneda.ItemData(I_Moneda.ListIndex) <> D_Moneda.ItemData(D_Moneda.ListIndex) Then
      EntregaTipoSwap = 2    '--> Swap de Monedas      CCS
   Else
      If I_Indicador.ItemData(I_Indicador.ListIndex) = 13 Or D_Indicador.ItemData(D_Indicador.ListIndex) = 13 Then
         EntregaTipoSwap = 4 '--> Swap Promedio Camara ICP
      Else
         EntregaTipoSwap = 1 '--> Swap de Tasas        IRF
      End If
   End If
Error:
   Exit Function
End Function

Private Sub CargaFPagoxMoneda(objCarga As ComboBox, iMoneda As Integer)
   Envia = Array()
   AddParam Envia, "PCS"
   AddParam Envia, iMoneda
   AddParam Envia, CDbl(2)
   If Not Bac_Sql_Execute("SP_MONEDA_DOC_PAGO", Envia) Then
      Exit Sub
   End If
   objCarga.Clear
   Do While Bac_SQL_Fetch(Datos())
      objCarga.AddItem Datos(2)
      objCarga.ItemData(objCarga.NewIndex) = Val(Datos(1))
   Loop
   objCarga.ListIndex = 0
End Sub

Private Function GeneracionFlujos(Lado As Lados) As Boolean
   Dim Datos()
   Dim grilla              As MSFlexGrid
   Dim FrecuenciaPago      As ComboBox
   Dim FrecuenciaCapital   As ComboBox
   Dim dFechaEfectiva      As Date
   Dim dFechaPrimerPago    As Date
   Dim dFechaPenultimoPago As Date
   Dim dFechaMadurez       As Date
   Dim cMoneda             As String
   Dim nTasa               As Double
   Dim nMontoNocional      As Double
   Dim iRedondeo           As Integer
   Dim iDiasInteres        As Integer
   Dim iDiasCapital        As Integer
   Dim iTipoGeneracion     As Integer
   Dim nTasaSpread         As Double
   Dim nSpread             As Double
   
   
   Select Case Lado

      Case Izquierdo, Izq_Tran
         Set FrecuenciaPago = I_FrecuenciaPago
         Set FrecuenciaCapital = I_FrecuenciaCapital
         
         If Lado = Izquierdo Then
            Set grilla = I_Grid
         Else
            Set grilla = I_Grid_Tran
         End If
         
         dFechaEfectiva = I_FechaEfectiva.Text
         dFechaPrimerPago = I_PrimerPago.Text
         dFechaPenultimoPago = I_PenultimoPago.Text
         dFechaMadurez = I_Madurez.Text
         
         cMoneda = I_NemMon.Caption
         nMontoNocional = CDbl(I_Nocionales.Text)
         
         If Lado = Izquierdo Then
            nTasaSpread = CDbl(I_UltimoIndice.Text) + CDbl(I_Spread.Text)
            nTasa = CDbl(I_UltimoIndice.Text)
            nSpread = CDbl(I_Spread.Text)
         Else
            nTasaSpread = CDbl(I_Indice_Tran.Text) + CDbl(I_Spread_Tran.Text)
            nTasa = CDbl(I_Indice_Tran.Text)
            nSpread = CDbl(I_Spread_Tran.Text)
         End If
         
         iRedondeo = DecAmortizacion
         
         If I_Moneda.ItemData(I_Moneda.ListIndex) = 998 Then
            iRedondeo = 4
         End If
         
         iTipoGeneracion = I_HabilitaFecha(1).Value
         
      Case Derecho, Der_Tran
         Set FrecuenciaPago = D_FrecuenciaPago
         Set FrecuenciaCapital = D_FrecuenciaCapital
         
         If Lado = Derecho Then
            Set grilla = D_Grid
         Else
            Set grilla = D_Grid_Tran
         End If
         
         dFechaEfectiva = D_FechaEfectiva.Text
         dFechaPrimerPago = D_PrimerPago.Text
         dFechaPenultimoPago = D_PenultimoPago.Text
         dFechaMadurez = D_Madurez.Text
         cMoneda = D_NemMon.Caption
         nMontoNocional = CDbl(D_Nocionales.Text)
         
         If Lado = Derecho Then
            nTasaSpread = CDbl(D_UltimoIndice.Text) + CDbl(D_Spread.Text)
            nTasa = CDbl(D_UltimoIndice.Text)
            nSpread = CDbl(D_Spread.Text)
         Else
            nTasaSpread = CDbl(D_Indice_Tran.Text) + CDbl(D_Spread_Tran.Text)
            nTasa = CDbl(D_Indice_Tran.Text)
            nSpread = CDbl(D_Spread_Tran.Text)
         End If
         
         iRedondeo = DecAmortizacion
         
         If D_Moneda.ItemData(D_Moneda.ListIndex) = 998 Then
            iRedondeo = 4
         End If
         
         iTipoGeneracion = D_HabilitaFecha(1).Value
   End Select

   iDiasInteres = 0
   iDiasInteres = IIf(FrecuenciaPago.ListIndex < 0, 0, Left(FrecuenciaPago.ItemData(FrecuenciaPago.ListIndex), 2))
   iDiasInteres = IIf(iDiasInteres <> 12 And iDiasInteres <> -1, Val(Left(iDiasInteres, 1)), iDiasInteres)
   
   iDiasCapital = 0
   iDiasCapital = IIf(FrecuenciaCapital.ListIndex < 0, 0, Left(FrecuenciaCapital.ItemData(FrecuenciaCapital.ListIndex), 2))
   iDiasCapital = IIf(iDiasCapital <> 12 And iDiasCapital <> -1, Val(Left(iDiasCapital, 1)), iDiasCapital)
   
   Envia = Array()
   AddParam Envia, CDbl(iDiasInteres)
   AddParam Envia, CDbl(iDiasCapital)
   AddParam Envia, Format(dFechaEfectiva, "YYYYMMDD")
   AddParam Envia, Format(dFechaPrimerPago, "YYYYMMDD")
   AddParam Envia, Format(dFechaPenultimoPago, "YYYYMMDD")
   AddParam Envia, Format(dFechaMadurez, "YYYYMMDD")
   AddParam Envia, CDbl(iTipoGeneracion)
   AddParam Envia, CDbl(nMontoNocional)
   AddParam Envia, CDbl(iRedondeo)
   
   If Not Bac_Sql_Execute("SP_GEN_CUADRO_PAGO", Envia) Then
      Exit Function
   End If
   
   grilla.Rows = 1
   
   Do While Bac_SQL_Fetch(Datos())
      grilla.Rows = grilla.Rows + 1
      grilla.TextMatrix(grilla.Rows - 1, 0) = Format(Val(Datos(1)) + 1, "##00")
      grilla.TextMatrix(grilla.Rows - 1, 1) = Format(Datos(2), "dd/mm/yyyy")
      grilla.TextMatrix(grilla.Rows - 1, 2) = Format(CDbl(Datos(4)), TipoFormato(cMoneda))
      grilla.TextMatrix(grilla.Rows - 1, 3) = Format(nTasaSpread, FormatoTasa)
      grilla.TextMatrix(grilla.Rows - 1, 4) = Format(0#, FormatoTasa)
      grilla.TextMatrix(grilla.Rows - 1, 5) = Format(0#, FormatoTasa)
      grilla.TextMatrix(grilla.Rows - 1, 14) = Format(Datos(2), "dd/mm/yyyy")
      grilla.TextMatrix(grilla.Rows - 1, 15) = Format(Datos(2), "dd/mm/yyyy")
      grilla.TextMatrix(grilla.Rows - 1, 16) = Format(Datos(2), "dd/mm/yyyy")
      
      grilla.TextMatrix(grilla.Rows - 1, 19) = IIf(DateDiff("d", CDate(Datos(2)), CDate(dFechaEfectiva)) = 0, "No", "Si")
      
      grilla.TextMatrix(grilla.Rows - 1, 20) = Format(Datos(2), "dd/mm/yyyy")
      grilla.TextMatrix(grilla.Rows - 1, 21) = 0
      grilla.TextMatrix(grilla.Rows - 1, 22) = 1
      grilla.TextMatrix(grilla.Rows - 1, 23) = Format(nTasa, FormatoTasa)
      grilla.TextMatrix(grilla.Rows - 1, 24) = Format(nSpread, FormatoTasa)
   Loop
  

   Call AplicarValidacionFeriados(Lado, grilla)
   Call CalculoInteresBonos(Lado, grilla)
   
End Function

Private Function GeneraFlujosReversa(Lado As Lados) As Boolean
   Dim Interes             As ComboBox
   Dim Capital             As ComboBox
   Dim grilla              As MSFlexGrid
   Dim Direcion            As Integer
   Dim iDiasInteres        As Integer
   Dim iDiasCapital        As Integer
   Dim iPlazo              As Integer
   Dim PlazoMin            As Integer
   Dim dInicio             As Date
   Dim dPrimerPago         As Date
   Dim dPenultimoPago      As Date
   Dim dMadurez            As Date
   Dim FechaFin            As Date
   Dim FechaVencAnt        As Date
   Dim DiaAmort            As Integer
   Dim AmortizacionCapital As Date
   Dim AmortizacionIntres  As Date
   Dim FechaAmortizacion   As Date
   Dim nRedondeo           As Integer

   Dim DivCap              As Integer
   Dim FactorDiv           As Integer
   Dim vAmortizacion       As Double
   Dim vCuadratura         As Double
   Dim vMontoCapital       As Double
   Dim vMontoGrid          As Double
   Dim vTasa               As Double
   Dim iFilas              As Integer

   GeneraFlujosReversa = False

   If Lado = Izquierdo Then
      Set Interes = I_FrecuenciaPago
      Set Capital = I_FrecuenciaCapital
      Set grilla = I_Grid
      Direcion = IIf(I_HabilitaFecha(1).Value = 0, 1, 2)

      dInicio = I_FechaEfectiva.Text
      dPrimerPago = I_PrimerPago.Text
      dPenultimoPago = I_PenultimoPago.Text
      dMadurez = I_Madurez.Text
      nRedondeo = DecAmortizacion ' IIf(I_Moneda.Text Like "PESOS*", 0, CantDecimales) '4)
      If I_Moneda.ItemData(I_Moneda.ListIndex) = 998 Then
         nRedondeo = 4
      End If
      vMontoCapital = I_Nocionales.Text
      vTasa = CDbl(I_UltimoIndice.Text) + CDbl(I_Spread.Text)
   Else
      Set Interes = D_FrecuenciaPago
      Set Capital = D_FrecuenciaCapital
      Set grilla = D_Grid
      Direcion = IIf(D_HabilitaFecha(1).Value = 0, 1, 2)

      dInicio = D_FechaEfectiva.Text
      dPrimerPago = D_PrimerPago.Text
      dPenultimoPago = D_PenultimoPago.Text
      dMadurez = D_Madurez.Text
      nRedondeo = DecAmortizacion ' IIf(D_Moneda.Text Like "PESOS*", 0, CantDecimales) '4)
      If D_Moneda.ItemData(D_Moneda.ListIndex) = 998 Then
         nRedondeo = 4
      End If
         
      vMontoCapital = D_Nocionales.Text
      vTasa = CDbl(D_UltimoIndice.Text) + CDbl(D_Spread.Text)
   End If

   iDiasInteres = 0
   If Interes.ListIndex > -1 Then
      iDiasInteres = Left(Interes.ItemData(Interes.ListIndex), 2)
      If iDiasInteres <> 12 And iDiasInteres <> -1 Then
         iDiasInteres = Val(Left(iDiasInteres, 1))
      End If
   End If
   iDiasCapital = 0
   If Capital.ListIndex > -1 Then
      iDiasCapital = Left(Capital.ItemData(Capital.ListIndex), 2)
      If iDiasCapital <> 12 And iDiasCapital <> -1 Then
         iDiasCapital = Val(Left(iDiasCapital, 1))
      End If
   End If

   If iDiasCapital > iDiasInteres Then
      PlazoMin = iDiasInteres
   Else
      PlazoMin = IIf(iDiasCapital > 0, iDiasCapital, iDiasInteres)
   End If
   
   FechaFin = CDate(dMadurez)
   FechaVencAnt = IIf(dInicio = dPrimerPago, CDate(dInicio), CDate(dPrimerPago))
   DiaAmort = Day(IIf(dInicio = dPrimerPago, CDate(dInicio), CDate(dPrimerPago)))
   If iDiasCapital = 0 Then
      AmortizacionCapital = FechaFin
   Else
      AmortizacionCapital = DateAdd("M", iDiasCapital, IIf(CDate(dInicio) = CDate(dPrimerPago), CDate(dInicio), CDate(dPrimerPago)))
   End If
   If CDate(dInicio) = CDate(dPrimerPago) Then
      AmortizacionIntres = DateAdd("M", iDiasInteres, CDate(dInicio))
   Else
      AmortizacionIntres = CDate(dPrimerPago)
   End If
   FechaAmortizacion = AmortizacionIntres

   If FechaAmortizacion > FechaFin Then
      FechaAmortizacion = FechaFin
   End If

   FactorDiv = 1
   If iDiasCapital > 0 Then
      DivCap = iDiasCapital
      FactorDiv = BacDiv(DateDiff("M", AmortizacionCapital, CDate(FechaFin)), CDbl(DivCap))
      FactorDiv = FactorDiv + 1
   End If
   If FactorDiv = 0 Then
      MsgBox "Fechas Ingresadas no concuerdan com períodos de Amortización seleccionados", vbExclamation, TITSISTEMA
      Exit Function
   End If

   vAmortizacion = Round((CDbl(vMontoCapital) / FactorDiv), nRedondeo)
   vCuadratura = vMontoCapital - (vAmortizacion * FactorDiv)

   iFilas = 1
   grilla.Rows = 1
   
   Dim cxMoneda As String
   cxMoneda = IIf(Lado = Derecho, D_NemMon.Caption, I_NemMon.Caption)
   
   Do While CDate(FechaAmortizacion) <= CDate(FechaFin)
      vMontoGrid = 0
      If FechaAmortizacion = AmortizacionCapital Then
         If AmortizacionCapital = FechaFin Then
            vAmortizacion = CDbl(vAmortizacion) + CDbl(vCuadratura)
         End If
         vMontoGrid = vAmortizacion
         AmortizacionCapital = DateAdd("M", iDiasCapital, FechaAmortizacion)
      End If

      grilla.Rows = grilla.Rows + 1
      grilla.TextMatrix(iFilas, 0) = Format(iFilas, "##00")
      grilla.TextMatrix(iFilas, 1) = Format(FechaAmortizacion, "dd/mm/yyyy")
      grilla.TextMatrix(iFilas, 2) = Format(vMontoGrid, TipoFormato(cxMoneda))
      grilla.TextMatrix(iFilas, 3) = Format(vTasa, FormatoTasa)
      grilla.TextMatrix(iFilas, 14) = Format(FechaAmortizacion, "dd/mm/yyyy")
      grilla.TextMatrix(iFilas, 15) = Format(FechaAmortizacion, "dd/mm/yyyy")
      grilla.TextMatrix(iFilas, 16) = Format(FechaAmortizacion, "dd/mm/yyyy")

      FechaVencAnt = FechaAmortizacion
      FechaAmortizacion = DateAdd("M", PlazoMin, FechaAmortizacion)

      If FechaAmortizacion > FechaFin And Abs(DateDiff("d", CDate(FechaAmortizacion), CDate(FechaFin))) <= 10 Then
         FechaAmortizacion = FechaFin
         AmortizacionCapital = FechaFin
      Else
         If FechaAmortizacion > FechaFin And CDate(grilla.TextMatrix(iFilas, 1)) < FechaFin Then
            FechaAmortizacion = FechaFin
            AmortizacionCapital = FechaFin
         ElseIf Abs(DateDiff("d", CDate(FechaFin), CDate(FechaAmortizacion))) <= 10 Then
            FechaAmortizacion = FechaFin
            AmortizacionCapital = FechaFin
         End If
      End If
      iFilas = iFilas + 1
   Loop

   If Lado = Derecho Then
      Call AplicarValidacionFeriados(Derecho, grilla)
     'Call AplicarValidacionFeriados("D", Grilla)
     
      Call CalculoInteresBonos(Derecho, grilla)
     'Call CalculoInteresBonos("D", Grilla)
   Else
      Call AplicarValidacionFeriados(Izquierdo, grilla)
     'Call AplicarValidacionFeriados("I", Grilla)
     
      Call CalculoInteresBonos(Izquierdo, grilla)
     'Call CalculoInteresBonos("I", Grilla)
   End If
   GeneraFlujosReversa = True

End Function

Private Function GeneraTablaFlujos(Lado As Lados) As Boolean
   Dim Interes             As ComboBox
   Dim Capital             As ComboBox
   Dim grilla              As MSFlexGrid
   Dim Direcion            As Integer
   Dim iDiasInteres        As Integer
   Dim iDiasCapital        As Integer
   Dim iPlazo              As Integer
   Dim PlazoMin            As Integer
   Dim dInicio             As Date
   Dim dPrimerPago         As Date
   Dim dPenultimoPago      As Date
   Dim dMadurez            As Date
   Dim FechaFin            As Date
   Dim FechaVencAnt        As Date
   Dim DiaAmort            As Integer
   Dim AmortizacionCapital As Date
   Dim AmortizacionIntres  As Date
   Dim FechaAmortizacion   As Date
   Dim nRedondeo           As Integer

   Dim DivCap              As Integer
   Dim FactorDiv           As Integer
   Dim vAmortizacion       As Double
   Dim vCuadratura         As Double
   Dim vMontoCapital       As Double
   Dim vMontoGrid          As Double
   Dim vTasa               As Double
   Dim iFilas              As Integer

   GeneraTablaFlujos = False

   If Lado = Izquierdo Then
      Set Interes = I_FrecuenciaPago
      Set Capital = I_FrecuenciaCapital
      Set grilla = I_Grid
      Direcion = IIf(I_HabilitaFecha(1).Value = 0, 1, 2)

      dInicio = I_FechaEfectiva.Text
      dPrimerPago = I_PrimerPago.Text
      dPenultimoPago = I_PenultimoPago.Text
      dMadurez = I_Madurez.Text
      nRedondeo = DecAmortizacion ' IIf(I_Moneda.Text Like "PESOS*", 0, CantDecimales) '4)
      If I_Moneda.ItemData(I_Moneda.ListIndex) = 998 Then
         nRedondeo = 4
      End If
      vMontoCapital = I_Nocionales.Text
      vTasa = CDbl(I_UltimoIndice.Text) + CDbl(I_Spread.Text)
   Else
      Set Interes = D_FrecuenciaPago
      Set Capital = D_FrecuenciaCapital
      Set grilla = D_Grid
      Direcion = IIf(D_HabilitaFecha(1).Value = 0, 1, 2)

      dInicio = D_FechaEfectiva.Text
      dPrimerPago = D_PrimerPago.Text
      dPenultimoPago = D_PenultimoPago.Text
      dMadurez = D_Madurez.Text
      nRedondeo = DecAmortizacion ' IIf(D_Moneda.Text Like "PESOS*", 0, CantDecimales) '4)
      If D_Moneda.ItemData(D_Moneda.ListIndex) = 998 Then
         nRedondeo = 4
      End If
         
      vMontoCapital = D_Nocionales.Text
      vTasa = CDbl(D_UltimoIndice.Text) + CDbl(D_Spread.Text)
   End If

   iDiasInteres = 0
   If Interes.ListIndex > -1 Then
      iDiasInteres = Left(Interes.ItemData(Interes.ListIndex), 2)
      If iDiasInteres <> 12 And iDiasInteres <> -1 Then
         iDiasInteres = Val(Left(iDiasInteres, 1))
      End If
   End If
   iDiasCapital = 0
   If Capital.ListIndex > -1 Then
      iDiasCapital = Left(Capital.ItemData(Capital.ListIndex), 2)
      If iDiasCapital <> 12 And iDiasCapital <> -1 Then
         iDiasCapital = Val(Left(iDiasCapital, 1))
      End If
   End If

   If iDiasCapital > iDiasInteres Then
      PlazoMin = iDiasInteres
   Else
      PlazoMin = IIf(iDiasCapital > 0, iDiasCapital, iDiasInteres)
   End If
   
   FechaFin = CDate(dMadurez)
   FechaVencAnt = IIf(dInicio = dPrimerPago, CDate(dInicio), CDate(dPrimerPago))
   DiaAmort = Day(IIf(dInicio = dPrimerPago, CDate(dInicio), CDate(dPrimerPago)))
   If iDiasCapital = 0 Then
      AmortizacionCapital = FechaFin
   Else
      AmortizacionCapital = DateAdd("M", iDiasCapital, IIf(CDate(dInicio) = CDate(dPrimerPago), CDate(dInicio), CDate(dPrimerPago)))
   End If
   If CDate(dInicio) = CDate(dPrimerPago) Then
      AmortizacionIntres = DateAdd("M", iDiasInteres, CDate(dInicio))
   Else
      AmortizacionIntres = CDate(dPrimerPago)
   End If
   FechaAmortizacion = AmortizacionIntres

   If FechaAmortizacion > FechaFin Then
      FechaAmortizacion = FechaFin
   End If

   FactorDiv = 1
   If iDiasCapital > 0 Then
      DivCap = iDiasCapital
      FactorDiv = BacDiv(DateDiff("M", AmortizacionCapital, CDate(FechaFin)), CDbl(DivCap))
      FactorDiv = FactorDiv + 1
   End If
   If FactorDiv = 0 Then
      MsgBox "Fechas Ingresadas no concuerdan com períodos de Amortización seleccionados", vbExclamation, TITSISTEMA
      Exit Function
   End If

   vAmortizacion = Round((CDbl(vMontoCapital) / FactorDiv), nRedondeo)
   vCuadratura = vMontoCapital - (vAmortizacion * FactorDiv)

   iFilas = 1
   grilla.Rows = 1
   
   Dim cxMoneda As String
   cxMoneda = IIf(Lado = Derecho, D_NemMon.Caption, I_NemMon.Caption)
   
   Do While CDate(FechaAmortizacion) <= CDate(FechaFin)
      vMontoGrid = 0
      If FechaAmortizacion = AmortizacionCapital Then
         If AmortizacionCapital = FechaFin Then
            vAmortizacion = CDbl(vAmortizacion) + CDbl(vCuadratura)
         End If
         vMontoGrid = vAmortizacion
         AmortizacionCapital = DateAdd("M", iDiasCapital, FechaAmortizacion)
      End If

      grilla.Rows = grilla.Rows + 1
      grilla.TextMatrix(iFilas, 0) = Format(iFilas, "##00")
      grilla.TextMatrix(iFilas, 1) = Format(FechaAmortizacion, "dd/mm/yyyy")
      grilla.TextMatrix(iFilas, 2) = Format(vMontoGrid, TipoFormato(cxMoneda))
      grilla.TextMatrix(iFilas, 3) = Format(vTasa, FormatoTasa)
      grilla.TextMatrix(iFilas, 14) = Format(FechaAmortizacion, "dd/mm/yyyy")
      grilla.TextMatrix(iFilas, 15) = Format(FechaAmortizacion, "dd/mm/yyyy")
      grilla.TextMatrix(iFilas, 16) = Format(FechaAmortizacion, "dd/mm/yyyy")

      FechaVencAnt = FechaAmortizacion
      FechaAmortizacion = DateAdd("M", PlazoMin, FechaAmortizacion)

      If FechaAmortizacion > FechaFin And Abs(DateDiff("d", CDate(FechaAmortizacion), CDate(FechaFin))) <= 10 Then
         FechaAmortizacion = FechaFin
         AmortizacionCapital = FechaFin
      Else
         If FechaAmortizacion > FechaFin And CDate(grilla.TextMatrix(iFilas, 1)) < FechaFin Then
            FechaAmortizacion = FechaFin
            AmortizacionCapital = FechaFin
         ElseIf Abs(DateDiff("d", CDate(FechaFin), CDate(FechaAmortizacion))) <= 10 Then
            FechaAmortizacion = FechaFin
            AmortizacionCapital = FechaFin
         End If
      End If
      iFilas = iFilas + 1
   Loop

   If Lado = Derecho Then
      Call AplicarValidacionFeriados(Derecho, grilla)
     'Call AplicarValidacionFeriados("D", Grilla)
     
      Call CalculoInteresBonos(Derecho, grilla)
     'Call CalculoInteresBonos("D", Grilla)
   Else
      Call AplicarValidacionFeriados(Izquierdo, grilla)
     'Call AplicarValidacionFeriados("I", Grilla)
     
      Call CalculoInteresBonos(Izquierdo, grilla)
     'Call CalculoInteresBonos("I", Grilla)
   End If
   GeneraTablaFlujos = True
End Function

Private Function ValidaFechaCierre() As Boolean
   ValidaFechaCierre = False
'CER 05/05/2008  - Req. Pantalla Ingreso Op. Swap. Se debe permitir, pero al grabar
'                  se deben grabar solo los flujos mayor o igual que la fecha de proceso.

'   If CDate(D_Grid.TextMatrix(1, 1)) < gsBAC_Fecp Then
'      MsgBox "La fecha de Vencimiento del primer flujo no debe ser superior a la fecha de Hoy.", vbExclamation, TITSISTEMA
'      Exit Function
'   End If
'   If CDate(I_Grid.TextMatrix(1, 1)) < gsBAC_Fecp Then
'      MsgBox "La fecha de Vencimiento del primer flujo no debe ser superior a la fecha de Hoy.", vbExclamation, TITSISTEMA
'      Exit Function
'   End If
   ValidaFechaCierre = True
End Function

Private Function TipoFormato(cCodMon As String)
   Select Case Trim(cCodMon$)
      Case "UF", "UFR"
         TipoFormato = "##,##0.0000"
      Case "$", "$$", "CLP"
         TipoFormato = "##,##0"
      Case Else
         TipoFormato = AplicarFormatoExt
   End Select
End Function

Private Function FomatoAmortizacion()
   FormatoTasa = "#,##0." & String(NunDecimales.Text, "0")
End Function
Private Function FormatoTasa()
   FormatoTasa = "#,##0." & String(NumDecTasa.Text, "0")
End Function

Private Sub I_Numero_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      I_Grid.TextMatrix(I_Grid.RowSel, I_Grid.ColSel) = Format(I_Numero.Text, TipoFormato(I_NemMon))
      I_Grid_Tran.TextMatrix(I_Grid.RowSel, I_Grid.ColSel) = Format(I_Numero.Text, TipoFormato(I_NemMon))
      
      If D_Grid.ColSel = 2 Then
         Call FUNC_Control_Digitacion_Amortizacion("I")
      End If

      Call CalculoInteresBonos(Izquierdo, I_Grid)
      Call CalculoInteresBonos(Izq_Tran, I_Grid_Tran)
      I_Grid.Enabled = True
      I_Numero.Visible = False
      I_Grid.SetFocus

      Call iSaldoAmortizacion(I_Grid)
      Call iSaldoAmortizacion(I_Grid_Tran)
      
      If Aplicar = "D" And D_Grid.Rows = I_Grid.Rows Then
         If D_NemMon = I_NemMon And D_Grid.Rows = I_Grid.Rows Then
            D_Grid.RowSel = I_Grid.RowSel
            D_Grid.TextMatrix(I_Grid.RowSel, I_Grid.ColSel) = Format(I_Numero.Text, TipoFormato(D_NemMon))
            D_Grid_Tran.TextMatrix(I_Grid.RowSel, I_Grid.ColSel) = Format(I_Numero.Text, TipoFormato(D_NemMon))
            Call CalculoInteresBonos(Derecho, D_Grid)
            Call CalculoInteresBonos(Der_Tran, D_Grid_Tran)
            Call iSaldoAmortizacion(D_Grid)
            Call iSaldoAmortizacion(D_Grid_Tran)
         Else
            iMonto = iMontoConv(False, I_Numero.Text, D_Nocionales.Text, I_Nocionales.Text)
            D_Grid.RowSel = I_Grid.RowSel
            D_Grid.TextMatrix(I_Grid.RowSel, I_Grid.ColSel) = Format(iMonto, TipoFormato(D_NemMon))
            D_Grid_Tran.TextMatrix(I_Grid.RowSel, I_Grid.ColSel) = Format(iMonto, TipoFormato(D_NemMon))
            
            Call CalculoInteresBonos(Derecho, D_Grid)
            Call CalculoInteresBonos(Der_Tran, D_Grid_Tran)
            
           'Call CalculoInteresBonos("D", D_Grid)
            
            Call iSaldoAmortizacion(D_Grid)
            Call iSaldoAmortizacion(D_Grid_Tran)
         End If
      End If
   End If
   
   If KeyCode = vbKeyEscape Then
      I_Grid.Enabled = True
      I_Numero.Visible = False
      I_Grid.SetFocus
   End If
End Sub

Private Function FUNC_Control_Digitacion_Amortizacion(ByVal Lado As String)
   Dim oGrilla    As MSFlexGrid
   Dim nMonto     As Double
   Dim nSuma      As Double
   Dim nContador  As Long

   
   If Lado = "D" Then
      Set oGrilla = D_Grid
      Let nMonto = D_Nocionales.Text
   Else
      Set oGrilla = I_Grid
      Let nMonto = I_Nocionales.Text
   End If
   
   For nContador = 1 To oGrilla.Rows - 1
      Let nSuma = nSuma + oGrilla.TextMatrix(nContador, 2)
   Next nContador
   
   If nSuma > nMonto Then
      Call MsgBox("Control de Amortización" & vbCrLf & vbCrLf & "El monto a Amortizar supera el Monto Nocional especificado.", vbExclamation, App.Title)
   End If
   
End Function

Private Sub D_Numero_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim iMonto     As Double
   
   If KeyCode = vbKeyReturn Then
      D_Grid.TextMatrix(D_Grid.RowSel, D_Grid.ColSel) = Format(D_Numero.Text, TipoFormato(D_NemMon))
      D_Grid_Tran.TextMatrix(D_Grid.RowSel, D_Grid.ColSel) = Format(D_Numero.Text, TipoFormato(D_NemMon))
      
      If D_Grid.ColSel = 2 Then
         Call FUNC_Control_Digitacion_Amortizacion("D")
      End If
      
      Call CalculoInteresBonos(Derecho, D_Grid)
      Call CalculoInteresBonos(Der_Tran, D_Grid_Tran)
      D_Grid.Enabled = True
      D_Numero.Visible = False
      D_Grid.SetFocus
      
      Call iSaldoAmortizacion(D_Grid)
      Call iSaldoAmortizacion(D_Grid_Tran)
      
      If Aplicar = "I" And D_Grid.Rows = I_Grid.Rows Then
         If D_NemMon = I_NemMon And D_Grid.Rows = I_Grid.Rows Then
            I_Grid.RowSel = D_Grid.RowSel
            I_Grid.TextMatrix(D_Grid.RowSel, D_Grid.ColSel) = Format(D_Numero.Text, TipoFormato(I_NemMon))
            I_Grid_Tran.TextMatrix(D_Grid.RowSel, D_Grid.ColSel) = Format(D_Numero.Text, TipoFormato(I_NemMon))
            Call CalculoInteresBonos(Izquierdo, I_Grid)
            Call CalculoInteresBonos(Izq_Tran, I_Grid_Tran)
            Call iSaldoAmortizacion(I_Grid)
            Call iSaldoAmortizacion(I_Grid_Tran)
         Else
            iMonto = iMontoConv(True, D_Numero.Text, D_Nocionales.Text, I_Nocionales.Text)
            I_Grid.RowSel = D_Grid.RowSel
            I_Grid.TextMatrix(D_Grid.RowSel, D_Grid.ColSel) = Format(iMonto, TipoFormato(I_NemMon))
            I_Grid_Tran.TextMatrix(D_Grid.RowSel, D_Grid.ColSel) = Format(iMonto, TipoFormato(I_NemMon))
            Call CalculoInteresBonos(Izquierdo, I_Grid)
            Call CalculoInteresBonos(Izq_Tran, I_Grid_Tran)
            Call iSaldoAmortizacion(I_Grid)
            Call iSaldoAmortizacion(I_Grid_Tran)
         End If
      End If
   End If
   
   If KeyCode = vbKeyEscape Then
      D_Grid.Enabled = True
      D_Numero.Visible = False
      D_Grid.SetFocus
   End If
End Sub

Private Function iMontoConv(nPagamos As Boolean, iAmortizacion As Double, Pagamos_Nocional As Double, Recibe_Nocional As Double) As Double
   If nPagamos = False Then
      iMontoConv = (iAmortizacion * (Pagamos_Nocional / Recibe_Nocional))
   Else
      iMontoConv = (iAmortizacion * (Recibe_Nocional / Pagamos_Nocional))
   End If
End Function

Private Function iSaldoAmortizacion(xGrilla As MSFlexGrid)
   Dim iSaldo              As Double
   Dim iMonto              As Double
   Dim iContador           As Integer
   Dim iFilaSeleccionada   As Integer
   Dim dMoneda             As String
   Dim iAmortizacion       As Double
   
   If xGrilla.Name = "D_Grid_Tran" Then
      iFilaSeleccionada = D_Grid.RowSel
      xGrilla.RowSel = D_Grid.RowSel
   ElseIf xGrilla.Name = "I_Grid_Tran" Then
      iFilaSeleccionada = I_Grid.RowSel
      xGrilla.RowSel = I_Grid.RowSel
   Else
   iFilaSeleccionada = xGrilla.RowSel
   End If
   
   'MAP 16/04/2008  - Req. Pantalla Ingreso Op. Swap
   'iSaldo = 0#
   Let iSaldo = IIf(xGrilla.Name = "D_Grid" Or xGrilla.Name = "D_Grid_Tran", D_Nocionales.Text, I_Nocionales.Text)
   
   iMonto = IIf(xGrilla.Name = "D_Grid" Or xGrilla.Name = "D_Grid_Tran", D_Nocionales.Text, I_Nocionales.Text)
   iAmortizacion = xGrilla.TextMatrix(xGrilla.RowSel, 2)
   
   If xGrilla.Name = "D_Grid" Or xGrilla.Name = "D_Grid_Tran" Then
      dMoneda = D_NemMon.Caption
   Else
      dMoneda = I_NemMon.Caption
   End If
   
   For iContador = 1 To xGrilla.Rows - 2
      If iContador = iFilaSeleccionada Then
      Else
         iSaldo = iSaldo + xGrilla.TextMatrix(iContador, 2)
      End If
   Next iContador
   
   If iFilaSeleccionada < (xGrilla.Rows - 1) Then
      iSaldoAmortizacion = (iMonto - iAmortizacion) - iSaldo
      xGrilla.TextMatrix(xGrilla.Rows - 1, 2) = Format(iSaldoAmortizacion, TipoFormato(dMoneda))
      
      If xGrilla.Name = "D_Grid" Or xGrilla.Name = "D_Grid_Tran" Then
         Call CalculoInteresBonos(Derecho, D_Grid)
         Call CalculoInteresBonos(Der_Tran, D_Grid_Tran)
      Else
         Call CalculoInteresBonos(Izquierdo, I_Grid)
         Call CalculoInteresBonos(Izq_Tran, I_Grid_Tran)
      End If
   End If
   
End Function

Private Sub CargaVenta(iNumero As Long)
   Dim iContador     As Integer
   Dim MiFormato     As String
   Dim iMontoAmort   As Double
   Dim rdaTos()
   
   Envia = Array()
   AddParam Envia, CDbl(iNumero)
   AddParam Envia, CDbl(2)
   If Not Bac_Sql_Execute("SP_LEE_OPERACIONES_SWAP", Envia) Then
      Exit Sub
   End If
   If Bac_SQL_Fetch(rdaTos()) Then
      TIKKER.Text = rdaTos(1)
      Modalidad.Text = rdaTos(2)
      Call CargaItemCombo(D_Moneda, rdaTos(3))
      D_NemMon.Caption = rdaTos(4)
      D_Nocionales.Text = CDbl(rdaTos(5))
      D_Nocionales.Tag = CDbl(rdaTos(5))
      
      iMontoAmort = CDbl(D_Nocionales.Text)
      Call BuscarFrecuencia(D_FrecuenciaPago, rdaTos(6))
      Call BuscarFrecuencia(D_FrecuenciaCapital, rdaTos(7))
      Call CargaItemCombo(D_Indicador, rdaTos(8))
      D_UltimoIndice.Text = CDbl(rdaTos(9))
      D_Spread.Text = CDbl(rdaTos(10))
      Call CargaItemCombo(D_ConteoDias, rdaTos(11))
      D_FechaEfectiva.Text = Format(rdaTos(12), "DD/MM/YYYY")
      D_PrimerPago.Text = Format(rdaTos(13), "DD/MM/YYYY")
      D_PenultimoPago.Text = Format(rdaTos(14), "DD/MM/YYYY")
      D_Madurez.Text = Format(rdaTos(15), "DD/MM/YYYY")
      Call CargaItemCombo(D_MonPago, rdaTos(16))
      Call CargaItemCombo(D_MedioPago, rdaTos(17))
      D_Note.Text = rdaTos(18)
      D_FERIADOCHK.Item(0).Value = rdaTos(19)
      D_FERIADOCHK.Item(1).Value = rdaTos(20)
      D_FERIADOCHK.Item(2).Value = rdaTos(21)
      D_FERIADOCHK.Item(3).Value = rdaTos(22)
      D_FERIADOCHK.Item(4).Value = rdaTos(23)
      D_FERIADOCHK.Item(5).Value = rdaTos(24)
      D_Convencion.Text = rdaTos(36)
      D_DiasReset.Text = Val(rdaTos(37))
   End If

End Sub

Private Sub CargaCompra(iNumero As Long)
   Dim iContador     As Integer
   Dim MiFormato     As String
   Dim iMontoAmort   As Double
   Dim rdaTos()
   
   iContador = 0
   iMontoAmort = 0#

   Envia = Array()
   AddParam Envia, CDbl(iNumero)
   AddParam Envia, CDbl(1)
   If Not Bac_Sql_Execute("SP_LEE_OPERACIONES_SWAP", Envia) Then
      Exit Sub
   End If
   If Bac_SQL_Fetch(rdaTos()) Then
      TIKKER.Text = rdaTos(1)
      Modalidad.Text = rdaTos(2)
      Call CargaItemCombo(I_Moneda, rdaTos(3))
      I_NemMon.Caption = rdaTos(4)
      I_Nocionales.Text = CDbl(rdaTos(5))
      I_Nocionales.Tag = CDbl(rdaTos(5))
      iMontoAmort = CDbl(I_Nocionales.Text)
      Call BuscarFrecuencia(I_FrecuenciaPago, rdaTos(6))
      Call BuscarFrecuencia(I_FrecuenciaCapital, rdaTos(7))
      Call CargaItemCombo(I_Indicador, rdaTos(8))
      I_UltimoIndice.Text = CDbl(rdaTos(9))
      I_Spread.Text = CDbl(rdaTos(10))
      Call CargaItemCombo(I_ConteoDias, rdaTos(11))
      I_FechaEfectiva.Text = Format(rdaTos(12), "DD/MM/YYYY")
      I_PrimerPago.Text = Format(rdaTos(13), "DD/MM/YYYY")
      I_PenultimoPago.Text = Format(rdaTos(14), "DD/MM/YYYY")
      I_Madurez.Text = Format(rdaTos(15), "DD/MM/YYYY")
      Call CargaItemCombo(I_MonPago, rdaTos(16))
      Call CargaItemCombo(I_MedioPago, rdaTos(17))
      I_Note.Text = rdaTos(18)
      I_FERIADOCHK.Item(0).Value = rdaTos(19)
      I_FERIADOCHK.Item(1).Value = rdaTos(20)
      I_FERIADOCHK.Item(2).Value = rdaTos(21)
      I_FERIADOCHK.Item(3).Value = rdaTos(22)
      I_FERIADOCHK.Item(4).Value = rdaTos(23)
      I_FERIADOCHK.Item(5).Value = rdaTos(24)
      I_Convencion.Text = rdaTos(36)
      I_DiasReset.Text = Val(rdaTos(37))
   
      iRut = rdaTos(38)
      cNombre = rdaTos(39)
      cCarteraFinanciera = rdaTos(40)
      cAreaResponsable = rdaTos(41)
      cLibroNegociacion = rdaTos(42)
      cCarteraNormativa = rdaTos(43)
      cSubCartera = rdaTos(44)
      CodCliente = rdaTos(45)
   End If

End Sub

Private Sub CargarCampos(Minumero As Long)
   Dim iContador     As Integer
   Dim MiFormato     As String
   Dim iMontoAmort   As Double
   Dim rdaTos()
   
   Call CargaCompra(Minumero)
   Call CargaVenta(Minumero)
   
   I_Nocionales.Text = CDbl(I_Nocionales.Tag)
   D_Nocionales.Text = CDbl(D_Nocionales.Tag)
   
   iContador = 0
   iMontoAmort = 0#
   
   Envia = Array()
   AddParam Envia, CDbl(Minumero)
   AddParam Envia, CDbl(1)
   If Not Bac_Sql_Execute("SP_LEE_OPERACIONES_SWAP", Envia) Then
      Exit Sub
   End If
   I_Grid.Rows = 1
   Do While Bac_SQL_Fetch(rdaTos())
      iContador = iContador + 1
      iMontoAmort = iMontoAmort - CDbl(rdaTos(26))
      I_Grid.Rows = I_Grid.Rows + 1
      I_Grid.TextMatrix(I_Grid.Rows - 1, 0) = Format(iContador, "00")
      I_Grid.TextMatrix(I_Grid.Rows - 1, 1) = Format(rdaTos(25), "DD/MM/YYYY")
      I_Grid.TextMatrix(I_Grid.Rows - 1, 2) = Format(rdaTos(26), TipoFormato(I_NemMon.Caption))
      I_Grid.TextMatrix(I_Grid.Rows - 1, 3) = Format(rdaTos(27), TipoFormato(I_NemMon.Caption))
      I_Grid.TextMatrix(I_Grid.Rows - 1, 4) = Format(rdaTos(28), TipoFormato(I_NemMon.Caption))
      I_Grid.TextMatrix(I_Grid.Rows - 1, 5) = Format(rdaTos(29), TipoFormato(I_NemMon.Caption))
      I_Grid.TextMatrix(I_Grid.Rows - 1, 6) = ""
      I_Grid.TextMatrix(I_Grid.Rows - 1, 7) = ""
      I_Grid.TextMatrix(I_Grid.Rows - 1, 8) = Format(iMontoAmort, TipoFormato(I_NemMon.Caption))
      I_Grid.TextMatrix(I_Grid.Rows - 1, 9) = Format(rdaTos(30), "DD/MM/YYYY")
      I_Grid.TextMatrix(I_Grid.Rows - 1, 10) = CDbl(rdaTos(32))
      I_Grid.TextMatrix(I_Grid.Rows - 1, 11) = CDbl(rdaTos(33))
      I_Grid.TextMatrix(I_Grid.Rows - 1, 12) = CDbl(rdaTos(34))
      I_Grid.TextMatrix(I_Grid.Rows - 1, 13) = ""
      I_Grid.TextMatrix(I_Grid.Rows - 1, 14) = Format(rdaTos(31), "DD/MM/YYYY")
      I_Grid.TextMatrix(I_Grid.Rows - 1, 15) = Format(rdaTos(25), "DD/MM/YYYY")
      I_Grid.TextMatrix(I_Grid.Rows - 1, 16) = Format(rdaTos(35), "DD/MM/YYYY")
   Loop
   
   iContador = 0
   iMontoAmort = 0#

   Envia = Array()
   AddParam Envia, CDbl(Minumero)
   AddParam Envia, CDbl(2)
   If Not Bac_Sql_Execute("SP_LEE_OPERACIONES_SWAP", Envia) Then
      Exit Sub
   End If
   D_Grid.Rows = 1
   Do While Bac_SQL_Fetch(rdaTos())
      iContador = iContador + 1
      iMontoAmort = iMontoAmort - CDbl(rdaTos(26))
      D_Grid.Rows = D_Grid.Rows + 1
      D_Grid.TextMatrix(D_Grid.Rows - 1, 0) = Format(iContador, "00")
      D_Grid.TextMatrix(D_Grid.Rows - 1, 1) = Format(rdaTos(25), "DD/MM/YYYY")
      D_Grid.TextMatrix(D_Grid.Rows - 1, 2) = Format(rdaTos(26), TipoFormato(D_NemMon.Caption))
      D_Grid.TextMatrix(D_Grid.Rows - 1, 3) = Format(rdaTos(27), TipoFormato(D_NemMon.Caption))
      D_Grid.TextMatrix(D_Grid.Rows - 1, 4) = Format(rdaTos(28), TipoFormato(D_NemMon.Caption))
      D_Grid.TextMatrix(D_Grid.Rows - 1, 5) = Format(rdaTos(29), TipoFormato(D_NemMon.Caption))
      D_Grid.TextMatrix(D_Grid.Rows - 1, 6) = ""
      D_Grid.TextMatrix(D_Grid.Rows - 1, 7) = ""
      D_Grid.TextMatrix(D_Grid.Rows - 1, 8) = Format(iMontoAmort, TipoFormato(D_NemMon.Caption))
      D_Grid.TextMatrix(D_Grid.Rows - 1, 9) = Format(rdaTos(30), "DD/MM/YYYY")
      D_Grid.TextMatrix(D_Grid.Rows - 1, 10) = CDbl(rdaTos(32))
      D_Grid.TextMatrix(D_Grid.Rows - 1, 11) = CDbl(rdaTos(33))
      D_Grid.TextMatrix(D_Grid.Rows - 1, 12) = CDbl(rdaTos(34))
      D_Grid.TextMatrix(D_Grid.Rows - 1, 13) = ""
      D_Grid.TextMatrix(D_Grid.Rows - 1, 14) = Format(rdaTos(31), "DD/MM/YYYY")
      D_Grid.TextMatrix(D_Grid.Rows - 1, 15) = Format(rdaTos(25), "DD/MM/YYYY")
      D_Grid.TextMatrix(D_Grid.Rows - 1, 16) = Format(rdaTos(35), "DD/MM/YYYY")
   Loop
   
End Sub

Private Sub CargaItemCombo(objeto As ComboBox, iValor As Variant)
   Dim iContador As Integer
   
   If Not IsNumeric(iValor) Then
      For iContador = 0 To objeto.ListCount - 1
         If Trim(Right(objeto.List(iContador), 5)) = iValor Then
            objeto.ListIndex = iContador
            Exit For
         End If
      Next iContador
   Else
      For iContador = 0 To objeto.ListCount - 1
         If objeto.ItemData(iContador) = Val(iValor) Then
            objeto.ListIndex = iContador
            Exit For
         End If
      Next iContador
   End If
   
End Sub

Private Sub BuscarFrecuencia(objeto As ComboBox, iValor As Variant)
   Dim iContador As Integer
   
   For iContador = 0 To objeto.ListCount - 1
      If Val(Right(objeto.List(iContador), 5)) = Val(iValor) Then
         objeto.ListIndex = iContador
         Exit For
      End If
   Next iContador
End Sub

Private Sub GeneraNeteo()
   Dim MisMonedas    As New ClsMoneda
   Dim iContador     As Integer
   Dim iTope         As Integer
   
   Dim iNemoMon      As String
   Dim iValMon       As Double
   Dim iMoneda       As Integer
   Dim iMonto        As Double
   Dim iMonUsd       As Double
   Dim iMnRrda       As String
   
   Dim dNemoMon      As String
   Dim dValMon       As Double
   Dim dMoneda       As Integer
   Dim dMonto        As Double
   Dim dMonUsd       As Double
   Dim dMnrrDa       As String
   
   Dim iNetoUsd      As Double
   
   If Not I_Grid.Rows > 1 And D_Grid.Rows > 1 Then
      Exit Sub
   End If
   
   iTope = IIf(I_Grid.Rows > D_Grid.Rows, I_Grid.Rows, D_Grid.Rows)
   
   
   iMoneda = I_Moneda.ItemData(I_Moneda.ListIndex)
   Call MisMonedas.LeerxCodigo(IIf(iMoneda = 13, 994, iMoneda))
   iValMon = I_ValorMoneda.Text ' IIf(iMoneda = 999, 1#, MisMonedas.vmValor)
   iNemoMon = I_NemMon
   iMnRrda = MisMonedas.mnrrda
   
   dMoneda = D_Moneda.ItemData(D_Moneda.ListIndex)
   Call MisMonedas.LeerxCodigo(IIf(dMoneda = 13, 994, dMoneda))
   dValMon = D_ValorMoneda.Text 'IIf(dMoneda = 999, 1#, MisMonedas.vmValor)
   dNemoMon = D_NemMon
   dMnrrDa = MisMonedas.mnrrda
   
   Dim dFechaVctoFlujo  As Date
   Dim nContador        As Long
   
   For iContador = 1 To iTope - 1
      If I_Grid.Rows > D_Grid.Rows Then
         If iContador <= I_Grid.Rows - 1 Then
            iMonto = CDbl(I_Grid.TextMatrix(iContador, 2)) + CDbl(I_Grid.TextMatrix(iContador, 4))
            dFechaVctoFlujo = CDate(I_Grid.TextMatrix(iContador, 1))
            If iMoneda = 13 Then
               iMonUsd = iMonto
            ElseIf iMoneda = 998 Then
               iMonUsd = (iMonto * gsBAC_ValmonUF) / gsBAC_DolarObs
            ElseIf iMoneda = 999 Then
               iMonUsd = iMonto / gsBAC_DolarObs
            Else
               If iMnRrda = "M" Then iMonUsd = iMonto * I_ValorMoneda.Text
               If iMnRrda = "D" Then iMonUsd = iMonto / I_ValorMoneda.Text
            End If
         
            dMonto = 0
            dMonUsd = 0
            For nContador = 1 To D_Grid.Rows - 1
               If CDate(D_Grid.TextMatrix(nContador, 1)) = dFechaVctoFlujo Then
                  dMonto = CDbl(D_Grid.TextMatrix(nContador, 2)) + CDbl(D_Grid.TextMatrix(nContador, 4))
                  If dMoneda = 13 Then
                     dMonUsd = dMonto
                  ElseIf dMoneda = 998 Then
                     dMonUsd = (dMonto * gsBAC_ValmonUF) / gsBAC_DolarObs
                  ElseIf dMoneda = 999 Then
                     dMonUsd = dMonto / gsBAC_DolarObs
                  Else
                     If dMnrrDa = "M" Then dMonUsd = dMonto * D_ValorMoneda.Text
                     If dMnrrDa = "D" Then dMonUsd = dMonto / D_ValorMoneda.Text
                  End If
                  Exit For
               End If
            Next nContador
            
         End If
         
      Else
         
         If iContador <= D_Grid.Rows - 1 Then
            dMonto = CDbl(D_Grid.TextMatrix(iContador, 2)) + CDbl(D_Grid.TextMatrix(iContador, 4))
            dFechaVctoFlujo = CDate(D_Grid.TextMatrix(iContador, 1))
            If dMoneda = 13 Then
               dMonUsd = dMonto
            ElseIf dMoneda = 998 Then
               dMonUsd = (dMonto * gsBAC_ValmonUF) / gsBAC_DolarObs
            ElseIf dMoneda = 999 Then
               dMonUsd = dMonto / gsBAC_DolarObs
            Else
               If dMnrrDa = "M" Then dMonUsd = dMonto * D_ValorMoneda.Text
               If dMnrrDa = "D" Then dMonUsd = dMonto / D_ValorMoneda.Text
            End If
            
            iMonto = 0
            iMonUsd = 0
            For nContador = 1 To I_Grid.Rows - 1
               If CDate(I_Grid.TextMatrix(nContador, 1)) = dFechaVctoFlujo Then
                  iMonto = CDbl(I_Grid.TextMatrix(nContador, 2)) + CDbl(I_Grid.TextMatrix(nContador, 4))
                  If iMoneda = 13 Then
                     iMonUsd = iMonto
                  ElseIf iMoneda = 998 Then
                     iMonUsd = (iMonto * gsBAC_ValmonUF) / gsBAC_DolarObs
                  ElseIf iMoneda = 999 Then
                     iMonUsd = iMonto / gsBAC_DolarObs
                  Else
                     If iMnRrda = "M" Then iMonUsd = iMonto * I_ValorMoneda.Text
                     If iMnRrda = "D" Then iMonUsd = iMonto / I_ValorMoneda.Text
                  End If
                  Exit For
               End If
            Next nContador
         End If
      End If
      
   iNetoUsd = 0#
   iNetoUsd = iMonUsd - dMonUsd
   gsFormatoTasa = "#,##0." & String(NumDecTasa.Text, "0")
   Call FRM_MNT_NETEO_SWAP.RefrescaDatos(iContador, iMonto, dMonto, iNetoUsd, iNemoMon, dNemoMon)
   Next iContador
   
End Sub

Private Function ValorMoneda(CodMon As Integer, fechaMon) As Double
   Dim ValorMon As New ClsMoneda

   ValorMoneda = ValorMon.ValorMoneda(CodMon, CStr(fechaMon))

   Set ValorMon = Nothing
End Function

Private Function iValorTasaCamaraPromedio(iMoneda As Integer, Optional dFecIniFlu As String, Optional dFecProc As String) As Double
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(iMoneda)
   AddParam Envia, Format(dFecIniFlu, "yyyymmdd")
   AddParam Envia, Format(dFecProc, "yyyymmdd")
   If Not Bac_Sql_Execute("SRV_CALCULO_TPCA", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) = -1 Then
         iValorTasaCamaraPromedio = Format(0#, "###0.0000000000")
         iValorTasaCamaraPromedio = Datos(0)
         MsgBox "Calculo No Realizado." & vbCrLf & vbCrLf & Datos(2) _
         & vbCrLf & "Este valor debe ser ingresado ántes de Grabar Operación", vbExclamation, TITSISTEMA
      Else
         iValorTasaCamaraPromedio = Format(Datos(1), "###0.0000000000")
         iValorTasaCamaraPromedio = Datos(1)
      End If
   End If
End Function

Private Function iValorTasaIBR(iMoneda As Integer, Optional dFecIniFlu As String, Optional dFecProc As String) As Double
'PRD18662
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(iMoneda)
   AddParam Envia, Format(dFecIniFlu, "yyyymmdd")
   AddParam Envia, Format(dFecProc, "yyyymmdd")
   If Not Bac_Sql_Execute("SRV_CALCULO_TIBR", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) = -1 Then
         iValorTasaIBR = Format(0#, "###0.0000000000")
         iValorTasaIBR = Datos(0)
         MsgBox "Calculo No Realizado." & vbCrLf & vbCrLf & Datos(2) _
         & vbCrLf & "Este valor debe ser ingresado ántes de Grabar Operación", vbExclamation, TITSISTEMA
      Else
         iValorTasaIBR = Format(Datos(1), "###0.0000000000")
         iValorTasaIBR = Datos(1)
      End If
   End If
End Function
Sub Generar_Excel()
   Dim Linea            As String
   Dim j                As Double
   Dim i                As Double
   Dim ruta             As String
   Dim retorno          As Double
   Dim Fecha            As Date
   Dim nUltFila         As Long
   Dim nContador        As Long
   Dim bExcelEnMemoria  As Boolean

   Const Filas_Buffer = 2500
   
   On Error GoTo Control_Error
   
   bExcelEnMemoria = False
   
   Screen.MousePointer = vbHourglass
        
   cd.DialogTitle = "Generación archivo excel"
   cd.InitDir = "C:\"
   cd.Flags = cdlOFNLongNames
   cd.DefaultExt = "xls"
   cd.Filter = ".xls"
   cd.CancelError = True
   cd.ShowSave
    
   If cd.FileName = "" Then   'Si presiona cancelar y no genera el archivo xls
      MsgBox "Debe especificar un nombre de archivo", vbOKOnly, TITSISTEMA
      Exit Sub
   End If
   
   If Dir(cd.FileName) <> "" Then
      If MsgBox("El archivo " + vbCrLf + vbCrLf + cd.FileName + vbCrLf + vbCrLf + " Ya existe, ¿Desea reemplazar el existente.?", vbQuestion + vbYesNo) = vbNo Then
         Screen.MousePointer = vbDefault
         Exit Sub
      Else
         Kill (cd.FileName)
      End If
   End If
        
   ruta = cd.FileName
   DoEvents
    
   Set xlapp = CreateObject("Excel.Application")
   Set xlbook = xlapp.Workbooks.Add
   Set xlsheet = xlbook.Worksheets(1)
   
   bExcelEnMemoria = True
   
   MousePointer = vbHourglass
   
   xlbook.Worksheets(3).Delete
     
   Do While xlbook.Worksheets.Count < 2
      xlbook.Worksheets.Add
   Loop
   
   xlbook.Worksheets(1).Name = "Recibe"
   xlbook.Worksheets(2).Name = "Paga"
   ''''xlbook.Worksheets(3).Name = "Recibe Transferencia"
   ''''xlbook.Worksheets(4).Name = "Paga Transferencia"
          
   '***********************
   '* Flujo Recibimos
   '***********************

   '//Aquí se carga la primera hoja
   
   xlbook.Sheets("Recibe").Activate
   Set xlsheet = xlbook.ActiveSheet
  
   i = 1
   j = 0 ' Se modifica para que enive el numero de flujo, ya que no se estaba enviando
   jj = 1
   Y = 0
   nUltFila = I_Grid.Rows

   Do While i <= I_Grid.Rows
      Do While j <= I_Grid.Cols - 1
         If (j >= 0 And j <= 2) Or (j = 14) Or (j >= 16 And j <= I_Grid.Cols - 2) Then
            If (j = 1) And Y <> 0 Or (j = 14) And Y <> 0 Or (j = 16) And Y <> 0 Or (j = 20) And Y <> 0 Then
               Fecha = IIf(j = 16 And I_Indicador = "FIJA", gsBAC_Fecp, I_Grid.TextMatrix(Y, j))
               xlsheet.Cells(i, jj).Value = CDate(Fecha)
            Else
               'Eduardo Castllo - Agrego IF, sentencia ese era la anrterior 9407
               If IsNumeric(I_Grid.TextMatrix(Y, j)) Then
                    xlsheet.Cells(i, jj).Value = CDbl(I_Grid.TextMatrix(Y, j))
               Else
               xlsheet.Cells(i, jj).Value = I_Grid.TextMatrix(Y, j)
            End If
            
            End If
            
            jj = jj + 1
         End If
      
         j = j + 1
      Loop
   
      j = 0
      jj = 1
      i = i + 1
      Y = Y + 1
   Loop
   
   xlsheet.Cells.Select
   xlsheet.Cells.EntireColumn.AutoFit
   
   GoSub Formateo_Hoja
   
   xlsheet.Range("A1").Select
   
   ''''xlSheet.Name = "Recibe"

   '***********************
   '* Flujo Pagamos
   '***********************

   '//Aquí se carga la segunda hoja
   ''''xlbook.Worksheets.Add
   '''Set xSheet = xlbook.ActiveSheet
   
   xlbook.Sheets("Paga").Activate
   Set xlsheet = xlbook.ActiveSheet

   i = 1
   j = 0  ' Se modifica para que enive el numero de flujo, ya que no se estaba enviando
   jj = 1
   Y = 0
   nUltFila = D_Grid.Rows
   
   Do While i <= D_Grid.Rows ''- 1 ¿ ?
      Do While j <= D_Grid.Cols - 1
         If (j >= 0 And j <= 2) Or (j = 14) Or (j >= 16 And j <= D_Grid.Cols - 2) Then
            If (j = 1) And Y <> 0 Or (j = 14) And Y <> 0 Or (j = 16) And Y <> 0 Or (j = 20) And Y <> 0 Then
               Fecha = IIf(j = 16 And D_Indicador = "FIJA", gsBAC_Fecp, D_Grid.TextMatrix(Y, j))
               xlsheet.Cells(i, jj).Value = CDate(Fecha)
            Else
                'Eduardo Castillo 9407
                'Agrego el If, lo de la sentncia else existía.
                If IsNumeric(D_Grid.TextMatrix(Y, j)) Then
                    xlsheet.Cells(i, jj).Value = CDbl(D_Grid.TextMatrix(Y, j))
                Else
               xlsheet.Cells(i, jj).Value = D_Grid.TextMatrix(Y, j)
            End If
            End If
            
            jj = jj + 1
         End If
         
         j = j + 1
      Loop
      
      j = 0
      jj = 1
      i = i + 1
      Y = Y + 1
   Loop
   
   xlsheet.Cells.Select
   xlsheet.Cells.EntireColumn.AutoFit
   
   GoSub Formateo_Hoja
   
   xlsheet.Range("A1").Select
   
   '***********************************************************************************************************************
   '***********************************************************************************************************************
   '******************************************** FIN GENERACION DE INFORMACION ********************************************
   '***********************************************************************************************************************
   '***********************************************************************************************************************
   
   ''''xSheet.Name = "Paga"

   xlbook.Sheets("Recibe").Activate

   Crea_xls = True
   xlbook.Application.DisplayAlerts = False

   If Crea_xls Then
      Call xlbook.SaveAs(ruta)
   Else
      xlbook.Application.Workbooks.Close
      MousePointer = vbDefault
      MsgBox "No se encontró Información para generar el Excel", vbExclamation, gsBAC_Version
      Exit Sub
   End If
    
   Screen.MousePointer = vbDefault
   MsgBox "El archivo Excel" + vbCrLf + vbCrLf + ruta + vbCrLf + vbCrLf + " Con la información, ha sido generado con exito", vbInformation, gsBAC_Version
   
   xlapp.Visible = True
   Set xlsheet = Nothing
   Set xlbook = Nothing
   Set xlapp = Nothing
   
   Exit Sub
   '***************************************************************************************************
   
Formateo_Hoja:
   xlsheet.Range("A1").Select
   xlsheet.Range(xlapp.Selection, xlapp.Selection.End(xlToRight)).Select
   
   xlapp.Selection.Interior.ColorIndex = 1
   xlapp.Selection.Interior.Pattern = xlSolid
   xlapp.Selection.Font.ColorIndex = 2
   
   xlsheet.Range(xlapp.Selection, xlapp.Selection.End(xlDown)).Select
   xlapp.Selection.Borders(xlDiagonalDown).LineStyle = xlNone
   xlapp.Selection.Borders(xlDiagonalUp).LineStyle = xlNone
   
   With xlapp.Selection.Borders(xlEdgeLeft)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With xlapp.Selection.Borders(xlEdgeTop)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With xlapp.Selection.Borders(xlEdgeBottom)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With xlapp.Selection.Borders(xlEdgeRight)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With xlapp.Selection.Borders(xlInsideVertical)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With xlapp.Selection.Borders(xlInsideHorizontal)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   
   For nContador = 3 To nUltFila Step 2
      xlsheet.Range("A" + Trim(CStr(nContador)) + ":M" + Trim(CStr(nContador))).Select
      xlapp.Selection.Interior.ColorIndex = 15
      xlapp.Selection.Interior.Pattern = xlSolid
   Next nContador

   Return
   
Control_Error:

   Screen.MousePointer = vbDefault

   If err.Number = 70 Then
       MsgBox "Permiso denegado, puede que el archivo este siendo utilizado", vbExclamation
   ElseIf err.Number = 32755 Then ''''presiono boton cancelar
       Exit Sub
   Else
      MsgBox err.Description, vbCritical + vbOKOnly
   End If
   
   If bExcelEnMemoria Then
      xlbook.Application.DisplayAlerts = False
      xlapp.Visible = False
      xlbook.Application.Workbooks.Close
      xlapp.Application.Quit
      
      Set xlsheet = Nothing
      Set xlbook = Nothing
      Set xlapp = Nothing
   End If
    
End Sub


Private Function ValidacionPreGeneraExcel() As Boolean
'Dim iCadena As String

   ValidacionPreGeneraExcel = False

   iCadena = ""
   
   If Not ValidacionPreGeneracio Then
      Screen.MousePointer = vbDefault
      Exit Function
   End If
   
   'CER 25/04/2008  - Req. Pantalla Ingreso Op. Swap
   '//No permite que se generen flujos con Nocionales en cero para los IRF e ICP
   If EntregaTipoSwap <> 2 Then
    If I_Nocionales.Text = 0# Or D_Nocionales.Text = 0# Then
        iCadena = iCadena & " - Debe ingresar los nocionales." & vbCrLf
    End If
   End If

   If (NunDecimales.Text < CuentaDecimales(I_Nocionales.Text) Or _
       NunDecimales.Text < CuentaDecimales(D_Nocionales.Text)) Then
      iCadena = iCadena & " - valor Dec. Am. no corresponde a los decimales del Nocional" & vbCrLf
   End If
   
   If iCadena <> "" Then
      Screen.MousePointer = vbDefault
      MsgBox "Validación" & vbCrLf & vbCrLf & "Se ha encontrado que :" & vbCrLf & iCadena, vbExclamation, TITSISTEMA
      Exit Function
   End If
   ValidacionPreGeneraExcel = True
End Function

Function Cargar_Excel(ruta As String)
Dim nTasa As Double
Dim cMoneda As String
Dim nTasaTran  As Double

On Error GoTo ControlError:

  DoEvents
  Set xlapp = CreateObject("Excel.Application")
  Set xlbook = xlapp.Workbooks.Open(ruta)
  
  Call DefineTitulos
  
'***************************************************************************************************************
'*********************************************** Flujo Recibimos ***********************************************
'***************************************************************************************************************
'//Aquí se carga grilla Recibimos
  
  nTasa = CDbl(I_UltimoIndice.Text) + CDbl(I_Spread.Text)
  cMoneda = I_NemMon.Caption
  nTasaTran = CDbl(I_Indice_Tran.Text) + CDbl(I_Spread_Tran.Text)
  
  If I_Indicador <> "FIJA" Then
    I_Grid.ColWidth(16) = 1500
  End If
    
  i = 2  '''1
  j = 1
  jj = 0
  Y = 1 '''0
     
  With xlbook.Worksheets(1)
   Do While .Cells(i, 1) <> ""
      Do While .Cells(i, j) <> ""
        If (jj >= 0 And jj <= 2) Or (jj = 14) Or (jj >= 16 And jj <= I_Grid.Cols - 1) Then
            If i > I_Grid.Rows Then
               I_Grid.Rows = I_Grid.Rows + 1
               I_Grid_Tran.Rows = I_Grid.Rows
            End If
            
            Select Case jj
                Case 2, 17
                    I_Grid.TextMatrix(Y, jj) = IIf(Len(xlbook.Worksheets(1).Cells(i, j).Value) = 0#, 0#, Format(xlbook.Worksheets(1).Cells(i, j).Value, TipoFormato(cMoneda)))
                    I_Grid_Tran.TextMatrix(Y, jj) = I_Grid.TextMatrix(Y, jj)
                Case Else
                    I_Grid.TextMatrix(Y, jj) = xlbook.Worksheets(1).Cells(i, j).Value
                    I_Grid_Tran.TextMatrix(Y, jj) = I_Grid.TextMatrix(Y, jj)
                    If jj = 1 Then
                        I_Grid.TextMatrix(Y, 15) = I_Grid.TextMatrix(Y, jj) ' Fecha Vcto. Cupón(Pibote)
                        I_Grid_Tran.TextMatrix(Y, columna.colFecFlujoReal) = I_Grid.TextMatrix(Y, columna.colFecFlujoReal)
                    End If
            End Select
            
            j = j + 1
        End If
        
        Select Case jj
            Case 3
                I_Grid.TextMatrix(Y, jj) = Format(nTasa, FormatoTasa)
                I_Grid_Tran.TextMatrix(Y, jj) = Format(nTasaTran, FormatoTasa)
            Case 4
                I_Grid.TextMatrix(Y, jj) = Format(0#, FormatoTasa)
                I_Grid_Tran.TextMatrix(Y, jj) = I_Grid.TextMatrix(Y, jj)
            Case 5
                I_Grid.TextMatrix(Y, jj) = Format(0#, FormatoTasa)
                I_Grid_Tran.TextMatrix(Y, jj) = I_Grid.TextMatrix(Y, jj)
        End Select

        jj = jj + 1
      Loop
      
      j = 1
      i = i + 1
      jj = 0
      Y = Y + 1
    Loop
  End With
  
  'Solo corrige vencimientos y liquid. segun cuadros de chequeo
  'esto significa el valor 1 literal
  
   Call CalculaDatos(Lados.Izquierdo, I_Grid)
   Call AplicarValidacionFeriadosExcel(Lados.Izquierdo, I_Grid, 1)
   Call CalculoInteresBonos(Lados.Izquierdo, I_Grid)
  
   Call CalculaDatos(Lados.Izq_Tran, I_Grid_Tran)
   Call AplicarValidacionFeriadosExcel(Lados.Izq_Tran, I_Grid_Tran, 1)
   Call CalculoInteresBonos(Lados.Izq_Tran, I_Grid_Tran)
  
    
'*************************************************************************************************************
'*********************************************** Flujo Pagamos ***********************************************
'*************************************************************************************************************
'//Aquí se carga grilla Pagamos

  nTasa = CDbl(D_UltimoIndice.Text) + CDbl(D_Spread.Text)
  cMoneda = D_NemMon.Caption
  nTasaTran = CDbl(D_Indice_Tran.Text) + CDbl(D_Spread_Tran.Text)
    
  If D_Indicador <> "FIJA" Then
    D_Grid.ColWidth(16) = 1500
  End If

  i = 2  '''1
  j = 1
  jj = 0
  Y = 1 '''0

  With xlbook.Worksheets(2)
    Do While .Cells(i, 1) <> ""
      Do While .Cells(i, j) <> ""
        If (jj >= 0 And jj <= 2) Or (jj = 14) Or (jj >= 16 And jj <= D_Grid.Cols - 1) Then
            If i > D_Grid.Rows Then
               D_Grid.Rows = D_Grid.Rows + 1
               D_Grid_Tran.Rows = D_Grid.Rows
            End If
            
            Select Case jj
                Case 2, 17
                    D_Grid.TextMatrix(Y, jj) = IIf(Len(xlbook.Worksheets(2).Cells(i, j).Value) = 0#, 0#, Format(xlbook.Worksheets(2).Cells(i, j).Value, TipoFormato(cMoneda)))
                    D_Grid_Tran.TextMatrix(Y, jj) = D_Grid.TextMatrix(Y, jj)
                Case Else
                    D_Grid.TextMatrix(Y, jj) = xlbook.Worksheets(2).Cells(i, j).Value
                    D_Grid_Tran.TextMatrix(Y, jj) = D_Grid.TextMatrix(Y, jj)
                    If jj = 1 Then
                        D_Grid.TextMatrix(Y, 15) = D_Grid.TextMatrix(Y, jj) ' Columna Fecha Vcto. Cupón(Pibote)
                        D_Grid_Tran.TextMatrix(Y, columna.colFecFlujoReal) = D_Grid.TextMatrix(Y, columna.colFecFlujoReal)
                    End If
            End Select
            
            j = j + 1
        End If
        
        Select Case jj
            Case 3
                D_Grid.TextMatrix(Y, jj) = Format(nTasa, FormatoTasa)
                D_Grid_Tran.TextMatrix(Y, jj) = Format(nTasaTran, FormatoTasa)
            Case 4
                D_Grid.TextMatrix(Y, jj) = Format(0#, FormatoTasa)
                D_Grid_Tran.TextMatrix(Y, jj) = D_Grid.TextMatrix(Y, jj)
            Case 5
                D_Grid.TextMatrix(Y, jj) = Format(0#, FormatoTasa)
                D_Grid_Tran.TextMatrix(Y, jj) = D_Grid.TextMatrix(Y, jj)
        End Select
        
        jj = jj + 1
      Loop
      
      j = 1
      i = i + 1
      jj = 0
      Y = Y + 1
    Loop
  End With
       
   'Solo corrige vencimientos y liquid. segun cuadros de chequeo
   'esto significa el valor 1 literal
   
   Call CalculaDatos(Lados.Derecho, D_Grid)
   Call AplicarValidacionFeriadosExcel(Lados.Derecho, D_Grid, 1)
   Call CalculoInteresBonos(Lados.Derecho, D_Grid)
   
   Call CalculaDatos(Lados.Der_Tran, D_Grid_Tran)
   Call AplicarValidacionFeriadosExcel(Lados.Der_Tran, D_Grid_Tran, 1)
   Call CalculoInteresBonos(Lados.Der_Tran, D_Grid_Tran)

   xlapp.Visible = False
   xlapp.Workbooks.Close
   xlapp.Quit
   Set xlbook = Nothing
   Set xlapp = Nothing
   
   Exit Function
    
ControlError:
   xlapp.Visible = False
   xlapp.Workbooks.Close
   xlapp.Quit
   Set xlbook = Nothing
   Set xlapp = Nothing

   Screen.MousePointer = vbDefault
   MsgBox err.Description, vbCritical + vbOKOnly
    
End Function


Private Function ValidacionPlanillaExcel(MiLado As String, Hoja As Integer, ruta As String) As Boolean
   Dim iCont            As Long
   Dim z                As Long
   Dim caux
   Dim C                As Long
   Dim iCadenaFlujo     As String
   Dim FecRepet         As String
   Dim SumAmort         As Double
   Dim SaldoIns         As Double
   Dim SumAmortPrc      As Double
 
   Dim iFil As Long
   Dim iAux As Long
   Dim pAux As Long
   Dim qAux As Long
   
   Dim Nocionales      As Double
   Dim FechaEfectiva   As Date
   Dim FecPrimerPago   As Date
   Dim FecMadurez      As Date
   Dim ParamDias       As Long
   Dim Indicador       As String
   Dim iMin                As Long
   Dim imax               As Long
   Dim pos                As Long
   Dim cArrFectemp  As String
   Dim cArrFecVcto()
   Dim cArrFecDup()
   Dim Datos()

   ValidacionPlanillaExcel = False
   
   DoEvents
   Set xlapp = CreateObject("Excel.Application")
   Set xlbook = xlapp.Workbooks.Open(ruta)
  
   iCadena = ""
   iCadenaFlujo = ""
   SumAmort = 0
   SumAmortPrc = 0
   
   
   
    If Not Bac_Sql_Execute("SP_PARAMETRO_DIAS") Then
      MsgBox "Problemas en procedimiento que trar parametros diarios. [Sp_Parametro_Dias]", vbCritical, App.Title
      Call xlbook.Close
      Call xlapp.Quit

        Set xlbook = Nothing
        Set xlapp = Nothing
        Exit Function

    End If

    If Bac_SQL_Fetch(Datos()) Then
        ParamDias = CDbl(Datos(1))
    End If
   
   
'***********************
'* Validaciones Flujos
'***********************
'//Aquí se recorre Hoja de planilla excel para validaciones

   Nocionales = IIf(MiLado = "I", I_Nocionales.Text, D_Nocionales.Text)
   FechaEfectiva = IIf(MiLado = "I", I_FechaEfectiva.Text, D_FechaEfectiva.Text)
   FecPrimerPago = IIf(MiLado = "I", I_PrimerPago.Text, D_PrimerPago.Text)
   FecMadurez = IIf(MiLado = "I", I_Madurez.Text, D_Madurez.Text)
   Indicador = IIf(MiLado = "I", I_Indicador, D_Indicador)
   
  
  i = 2
  j = 1
  iCont = 0
  iFil = 0
  
  '// Contar Columnas
  Do While xlbook.Worksheets(Hoja).Cells(1, j) <> ""
         iCont = iCont + 1
         j = j + 1
  Loop
  
  '// Contar filas
  Do While xlbook.Worksheets(Hoja).Cells(i, 1) <> ""
    iFil = iFil + 1
    i = i + 1
  Loop
  
  j = 1
  i = 2
  z = 0
  

  
 '//Se redimensiona el arreglo según el contador de filas
  ReDim cArrFecVcto(iFil)
  ReDim cArrFecDup(iFil)
  
  With xlbook.Worksheets(Hoja)
      Do While xlbook.Worksheets(Hoja).Cells(i, 1) <> ""
      Do While j <= iCont
         If (j = 2) Or (j = 4) Or (j = 5) Or (j = 9) Then
         
          '// Todas las columnas de Fechas deben tener información
           If xlbook.Worksheets(Hoja).Cells(i, j).Value = "" Then
             iCadena = iCadena & vbCrLf
             iCadena = iCadena & " - Debe ingresar Fecha " & xlbook.Worksheets(Hoja).Cells(1, j).Value & " para  flujo N° : " & i - 1 & vbCrLf
             iCadena = iCadena & "   La celda no puede estar vacía. " & vbCrLf
           End If
           
          '// Todas las Fechas salvo Fecha Vcto. del Flujo N°1 que corresponde a la
          '   Fecha Efectiva deben ser mayores  os iguales a la de proceso

           Select Case j
             Case 2
           '// Guarda Fecha Vcto. flujo en un arreglo para luego comparar
                   cArrFecVcto(z) = xlbook.Worksheets(Hoja).Cells(i, 2).Value
                   cArrFecDup(z) = xlbook.Worksheets(Hoja).Cells(i, 2).Value
                                      
           '// Validación para que Fecha de Liquidación no sea menor  la Fecha de Vcto.
             Case 4
                    
                     If (DateDiff("d", CDate(xlbook.Worksheets(Hoja).Cells(i, 2).Value), CDate(xlbook.Worksheets(Hoja).Cells(i, j).Value)) < 0) Then
                        iCadena = iCadena & vbCrLf
                        iCadena = iCadena & " - La Fecha de Liquidación : " & xlbook.Worksheets(Hoja).Cells(i, j).Value & " para  flujo N° : " & i - 1 & vbCrLf
                        iCadena = iCadena & "   debe ser mayor o igual a Fecha de Vcto. : " & xlbook.Worksheets(Hoja).Cells(i, 2).Value & vbCrLf
                    End If
                    
           '// Validación para que diferencia entre Fecha de Liquidación y Fecha de Vcto. sea menor o igual a parámetro
           '   definido por el usuario. El parámetro se traerá desde un procedimiento alcmacenado mientras no se realice
           '   la segunda etapa.
           
'               If Len(xlBook.worksheets(Hoja).Cells(i, 2).Value) <> 0 Then
                    If DateDiff("D", CDate(xlbook.Worksheets(Hoja).Cells(i, 2).Value), CDate(xlbook.Worksheets(Hoja).Cells(i, j).Value)) > CDbl(ParamDias) Then
                        iCadena = iCadena & vbCrLf
                        iCadena = iCadena & " - La diferencia entre la Fecha de Liquidación : " & xlbook.Worksheets(Hoja).Cells(i, j).Value & vbCrLf
                        iCadena = iCadena & "   y la Fecha de Vcto. : " & CDate(xlbook.Worksheets(Hoja).Cells(i, 2).Value) & vbCrLf
                        iCadena = iCadena & "   para  flujo N° : " & i - 1 & " debe ser menor o igual a : " & CDbl(ParamDias) & vbCrLf
                    End If
'               Else
'                iCadena = iCadena & vbCrLf
'                iCadena = iCadena & " - Debe Ingresar Fecha Vcto. para  flujo N° : " & i - 1 & vbCrLf
'                iCadena = iCadena & "   La celda no puede estar vacía. " & vbCrLf
'               End If
                   
           '// Se valida que la fecha Fijación Tasa de cada flujo sea menor o igual que la fecha de liquidación
             Case 5
           '20090202 - Se agrega condición para no controlar Fecha Fixing cuando la pata es Fija.
              If (DateDiff("d", CDate(xlbook.Worksheets(Hoja).Cells(i, j).Value), CDate(xlbook.Worksheets(Hoja).Cells(i, 4).Value)) < 0) And Indicador <> "FIJA" Then
                        iCadena = iCadena & vbCrLf
                        iCadena = iCadena & " - La Fecha Fijación Tasa : " & xlbook.Worksheets(2).Cells(i, j).Value & " para  flujo N° : " & i - 1 & vbCrLf
                        iCadena = iCadena & "   debe ser menor a o igual a fecha de liquidación : " & xlbook.Worksheets(Hoja).Cells(i, 4).Value & vbCrLf
              End If
                                          
                    
           End Select
           
         Else
         
           Select Case j
             Case 3, 6, 7
             '//Valida que las columnas que no sean fechas no vengan en blanco
                If Len(xlbook.Worksheets(Hoja).Cells(i, j).Value) = 0 Then
                   iCadena = iCadena & vbCrLf
                   iCadena = iCadena & " - Debe ingresar valor en la columna : " & xlbook.Worksheets(Hoja).Cells(1, j).Value & vbCrLf
                   iCadena = iCadena & "   para  flujo N° : " & i - 1 & ", sino existe valor, debe ingresar 0, " & vbCrLf
                   iCadena = iCadena & "   ya que no puede ser blanco. " & vbCrLf
                End If
                
             'CER 01/07/2008  - Flexibilización Intercambio Nocionales
             '//Se almacenan datos excel(Fec. Vcto.,Amortización e Intercambio Nocionales) en una Matriz
             Case 2, 3, 8
             
                 If Hoja = 1 Then
                     MatrizIzq(z, 1) = xlbook.Worksheets(Hoja).Cells(i, 2).Value
                     MatrizIzq(z, 2) = xlbook.Worksheets(Hoja).Cells(i, 3).Value
                     MatrizIzq(z, 3) = xlbook.Worksheets(Hoja).Cells(i, 8).Value
                     
                 Else
                     MatrizDer(z, 1) = xlbook.Worksheets(Hoja).Cells(i, 2).Value
                     MatrizDer(z, 2) = xlbook.Worksheets(Hoja).Cells(i, 3).Value
                     MatrizDer(z, 3) = xlbook.Worksheets(Hoja).Cells(i, 8).Value
                     
                 End If

           End Select
            
         End If
         
         
         '// Se valida que la columna Flujo Adicional siempre sea mayor o igual a cero
         'Eduardo Castillo 9407
         'If J = 10 Then
         '   If (CDbl(xlbook.Worksheets(Hoja).Cells(i, J).Value) < 0) Then
          '      iCadena = iCadena & vbCrLf
          '      iCadena = iCadena & " - La columna Flujo adicional para  flujo N° : " & i - 1 & vbCrLf
          '      iCadena = iCadena & "   debe ser mayor a o igual a 0 : " & xlbook.Worksheets(Hoja).Cells(i, J).Value & vbCrLf
           ' End If
        ' End If

     'CER 07/07/2008  - Se agrega condición para que se realice
     'suma siempre y cuando no existan problemas en planilla
     If iCadena = "" Then
         '// Suma Columna Amortización
         If j = 3 Then
            SumAmort = SumAmort + BacCtrlTransMonto(xlbook.Worksheets(Hoja).Cells(i, j).Value)
         End If
         
         '// Suma Columna Amortización Prc
         If j = 7 Then
            SumAmortPrc = SumAmortPrc + CDbl(xlbook.Worksheets(Hoja).Cells(i, j).Value)
         End If
      End If
         
         '//Elige carga Saldo Insoluto(0)
         If i > 3 And j = 6 And OptCargaExcel = 0 Then
          
          If Len(xlbook.Worksheets(Hoja).Cells(i, j).Value) <> 0 Then
             If (CDbl(xlbook.Worksheets(Hoja).Cells(i, j).Value) <= 0) Then
                iCadena = iCadena & vbCrLf
                iCadena = iCadena & " - La columna Saldo Insoluto para  flujo N° : " & i - 1 & vbCrLf
                iCadena = iCadena & "   no debe ser menor o igual a : " & xlbook.Worksheets(Hoja).Cells(i, j).Value & " ," & vbCrLf
                iCadena = iCadena & "   ya que se seleccionó Opción Saldo Insoluto. " & vbCrLf
             End If
          Else
                iCadena = iCadena & vbCrLf
                iCadena = iCadena & " - Debe Ingresar Saldo Insoluto para  flujo N° : " & i - 1 & vbCrLf
                iCadena = iCadena & "   ya que se seleccionó Opción Saldo Insoluto. " & vbCrLf
          End If
         End If
         
         
         j = j + 1
      Loop
      
      
      If i = 2 Then
      
      '// Valida que Flujo Adicional para Flujo 1 sea siempre igual a cero
        If (CDbl(xlbook.Worksheets(Hoja).Cells(i, 10).Value) <> 0) Then
            iCadena = iCadena & vbCrLf
            iCadena = iCadena & " - La Flujo Adicional para Flujo N° : " & i - 1 & vbCrLf
            iCadena = iCadena & "   debe ser siempre igual a 0 : " & CDbl(xlbook.Worksheets(Hoja).Cells(i, 10).Value) & vbCrLf
        End If
            
      '// Valida que Fecha Vcto. para Flujo 1 sea igual a Fecha Efectiva de Pantalla
        If (DateDiff("d", CDate(xlbook.Worksheets(Hoja).Cells(i, 2).Value), CDate(FechaEfectiva)) <> 0) Then
            iCadena = iCadena & vbCrLf
            iCadena = iCadena & " - La Fecha Vcto. para Flujo : " & i - 1 & vbCrLf
            iCadena = iCadena & "   debe ser igual a la Fecha Efectiva : " & FechaEfectiva & vbCrLf
        End If
      '// Valida que el valor de la columna de amortización del primer flujo no sea modificada
        If CDbl(xlbook.Worksheets(Hoja).Cells(i, 3).Value) <> CDbl(Nocionales) * -1 Then
            iCadena = iCadena & vbCrLf
            iCadena = iCadena & " - El Valor de la Amortización del flujo : " & i - 1 & vbCrLf
            iCadena = iCadena & "   no debe ser modificado, este debe ser : " & CDbl(Nocionales * -1) & vbCrLf
        End If
        
        '// Valida que el valor de la columna de Saldo Insoluto del primer flujo no sea modificada
        '   esta siempre debe ser 0
        If (CDbl(xlbook.Worksheets(Hoja).Cells(i, 6).Value) <> 0) Then
            iCadena = iCadena & vbCrLf
            iCadena = iCadena & " - El Valor del Saldo Insoluto del flujo : " & i - 1 & vbCrLf
            iCadena = iCadena & "   no debe ser modificado y no debe ser nulo, este debe ser : 0" & vbCrLf
        End If
        
        '// Valida que el valor de la columna % Amortiza del primer flujo no sea modificada
        '   esta siempre debe ser -100
        If CDbl(xlbook.Worksheets(Hoja).Cells(i, 7).Value) <> -100 Then
            iCadena = iCadena & vbCrLf
            iCadena = iCadena & " - El Valor de % Amortización del flujo : " & i - 1 & vbCrLf
            iCadena = iCadena & "   no debe ser modificado, este debe ser : " & -100 & vbCrLf
        End If

      End If
      

      '// Valida que Fecha Vcto. para Flujo 2 sea igual a Fecha de Primer Pago de Pantalla
      If i = 3 Then
        If (DateDiff("d", CDate(xlbook.Worksheets(Hoja).Cells(i, 2).Value), CDate(FecPrimerPago)) <> 0) Then
            iCadena = iCadena & vbCrLf
            iCadena = iCadena & " - La Fecha Vcto. para Flujo : " & i - 1 & vbCrLf
            iCadena = iCadena & "   debe ser igual a la Fecha Primer Pago : " & FecPrimerPago & vbCrLf
        End If
        
        '// Valida que Columna Saldo Insoluto para Flujo 2 sea igual al Nocional de la pata correspondiente
        '   Solo aplica cuando es IRS, si es CCS puede haber solo Flujo Adicional
        If (CDbl(xlbook.Worksheets(Hoja).Cells(i, 6).Value) <> CDbl(Nocionales)) _
            And I_Moneda.Text = D_Moneda.Text Then
            iCadena = iCadena & vbCrLf
            iCadena = iCadena & " - El Valor del Saldo Insoluto del flujo : " & i - 1 & vbCrLf
            iCadena = iCadena & "   no debe ser modificado y no debe ser nulo, este debe ser : " & vbCrLf
            iCadena = iCadena & "   igual a nocional ingresado : " & CDbl(Nocionales) & vbCrLf
        End If
        
      End If
      
      
      '// Valida que Fecha Vcto. para último Flujo sea igual a Fecha de Madurez
' 22/08/2008 - Validación se realiza al momento de Grabar
''''      If i = (iFil + 1) Then
''''        If (DateDiff("d", CDate(xlbook.Worksheets(Hoja).Cells(i, 2).Value), CDate(FecMadurez)) <> 0) Then
''''            iCadena = iCadena & vbCrLf
''''            iCadena = iCadena & " - La última Fecha Vcto. para Flujo : " & i - 1 & vbCrLf
''''            iCadena = iCadena & "   debe ser igual a la Fecha Madurez : " & FecMadurez & vbCrLf
''''        End If
''''
''''      End If
      
       If i = iFil + 1 Then
        If Hoja = 1 Then
             FecVctoPag = xlbook.Worksheets(Hoja).Cells(iFil + 1, 2).Value
        Else
             FecVctoRec = xlbook.Worksheets(Hoja).Cells(iFil + 1, 2).Value
        End If
      End If


      
      j = 1
      i = i + 1
      z = z + 1
    Loop
  End With
  
  '//Elige carga Amortización(1)
  If Round(SumAmort, NunDecimales.Text) <> 0 And OptCargaExcel = 1 Then
    iCadena = iCadena & vbCrLf
    iCadena = iCadena & " - La suma de la columna Amortización debe ser 0. " & " ," & vbCrLf
    iCadena = iCadena & "   ya que se seleccionó Opción Amortización. " & vbCrLf
  End If

  '//Elige carga Amortización Prc(2)
  If SumAmortPrc <> 0 And OptCargaExcel = 2 Then
    iCadena = iCadena & vbCrLf
    iCadena = iCadena & " - La suma de la columna  % Amortiza debe ser 0. " & " ," & vbCrLf
    iCadena = iCadena & "   ya que se seleccionó Opción Amortización. " & vbCrLf
  End If
  

  'Rutina para fechas con consultas SQL
  ''Call ValidaColFecha(xlBook.worksheets(Hoja).Name, (iFil + 1), Ruta)
  
  '//Verifica que columna Vencimiento se encuentre en orden
  
    iMin = LBound(cArrFecVcto)
    imax = UBound(cArrFecVcto)

    Do While imax > iMin
        pos = iMin

        For i = iMin To imax - 1
         If cArrFecVcto(i + 1) = "" Then
            Exit For
         End If
            
            If cArrFecVcto(i) > cArrFecVcto(i + 1) Then
            cArrFectemp = cArrFecVcto(i + 1)
            cArrFecVcto(i + 1) = cArrFecVcto(i)
            cArrFecVcto(i) = cArrFectemp
            
            pos = i
            iCadena = iCadena & vbCrLf
            iCadena = iCadena & " - Existe(n) error(es) en el orden de fechas para la columna  " & vbCrLf
            iCadena = iCadena & "    Vencimiento. Por favor verifique " & vbCrLf

            Exit Do
            End If
            
        Next i
        imax = pos
    
    Loop
    
  '//Verifica que en columna Vencimiento no haya duplicidad

    iMin = LBound(cArrFecDup)
    imax = UBound(cArrFecDup)

    Do While imax > iMin
        
        pos = iMin
        For i = iMin To imax - 1
            If cArrFecDup(i + 1) = "" Then Exit For
            If cArrFecDup(i) = cArrFecDup(i + 1) Then
            cArrFectemp = cArrFecDup(i + 1)
            cArrFecDup(i + 1) = cArrFecDup(i)
            cArrFecDup(i) = cArrFectemp
            pos = i
            iCadena = iCadena & vbCrLf
            iCadena = iCadena & " - Existe(n) error(es) de duplicidad de fechas para la columna " & vbCrLf
            iCadena = iCadena & "    Vencimiento. Por favor verifique " & vbCrLf
            Exit Do
            End If
        Next i

        imax = pos
    Loop

'' CER 03/07/2008  - Flexibilización Intercambio Nocionales
  MsgInterNoc = ""
  
  If Hoja = 2 Then
    xlbook.Close
    xlapp.Quit
    Set xlbook = Nothing
    Set xlapp = Nothing
    
'' CER 03/07/2008  - Flexibilización Intercambio Nocionales
    FilMatDer = iFil
    Call ValidaIntercamNocExcel
    
    If iCadena <> "" Or MsgInterNoc <> "" Then
''''    If iCadena <> "" Then
    
      Frm_Msg_Planilla_Excel.TxtMsg.Text = Frm_Msg_Planilla_Excel.TxtMsg.Text & vbCrLf & vbCrLf & "Para la hoja Recibe se ha encontrado que:" & vbCrLf
      '//La última fecha de vencimiento de cada pata deberán ser iguales.
      
' 22/08/2008  - Se comenta, ya que fechas pueden  ser disitintas
''''         If (DateDiff("d", CDate(FecVctoPag), CDate(FecVctoRec)) <> 0) Then
''''            iCadena = iCadena & vbCrLf
''''            iCadena = iCadena & " - Ultima Fecha de Vcto para Flujos Paga y Recibe, deben ser iguales. " & vbCrLf
''''         End If
                           
      '' CER 03/07/2008  - Flexibilización Intercambio Nocionales
        If MsgInterNoc <> "" And iCadena = "" Then
          Frm_Msg_Planilla_Excel.TxtMsg.Text = MsgInterNoc & vbCrLf
        Else
          Frm_Msg_Planilla_Excel.TxtMsg.Text = Frm_Msg_Planilla_Excel.TxtMsg.Text & vbCrLf & iCadena & vbCrLf & MsgInterNoc
          
      End If
''''         Frm_Msg_Planilla_Excel.TxtMsg.Text = Frm_Msg_Planilla_Excel.TxtMsg.Text & vbCrLf & iCadena
    Else
      ValidacionPlanillaExcel = True
    End If
    Exit Function
    
  End If
   
    '' CER 03/07/2008  - Flexibilización Intercambio Nocionales
    FilMatIzq = iFil
'''   Call Cierra_Excel
    xlbook.Close
    xlapp.Visible = False
    xlapp.Quit

    Set xlapp = Nothing
    Set xlbook = Nothing

   
    
   If iCadena <> "" Then
      Frm_Msg_Planilla_Excel.TxtMsg.Text = "Para la hoja Paga se ha encontrado que:" & vbCrLf
      Frm_Msg_Planilla_Excel.TxtMsg.Text = Frm_Msg_Planilla_Excel.TxtMsg.Text & vbCrLf & iCadena
       Exit Function
   End If
   
    
   

   ValidacionPlanillaExcel = True
   
End Function

Private Function CuentaDecimales(fNumero As Double) As Integer
'---- MAP 20080425
   Dim sNumero       As String
   Dim ParteDecimal  As Double
   Dim Largo         As Integer
   Dim i             As Integer
   
   
   Let ParteDecimal = fNumero - Int(fNumero)
   Let sNumero = Str(Format(ParteDecimal, "0.00000"))
   CuentaDecimales = Len(sNumero) - 2
'---- MAP 20080425
End Function


Private Function ValidaPorTipoCarga()
  
  
  With xlbook.Worksheets(Hoja)
  
    Do While .Cells(i, 1) <> ""
      Do While j <= iCont
         
         MsgBox xlbook.Worksheets(Hoja).Cells(i, j).Value
                 
         
         j = j + 1
      Loop
      


      
      j = 1
      i = i + 1
      z = z + 1
    Loop
  End With

      


End Function


Private Sub CalculaDatos(pLado As Lados, pGrid As MSFlexGrid)

   Dim jFil As Integer
   Dim jCol As Integer
   Dim i As Integer
   Dim z As Integer
   Dim qGrid As MSFlexGrid
   Dim cMoneda As String
   Dim SaldoInsoluto  As Double
   Dim Interes  As Double
   Dim Tasa As Double
   
   Dim Base               As Double
   Dim FechaVctoFlujo     As Date
   Dim FechaVencAnt       As Date
   Dim FecVAnt            As Date
   Dim DiasDif            As Long
   Dim PeriDias           As String
   Dim PeriBase           As String
   Dim fecInicio            As Date
   Dim BaseStr             As String
   Dim PlazoDias          As Double
   Dim nRedondeo       As Integer
   Dim CodMoneda      As Integer
   Dim Nocionales        As Double
   Dim Pasito
   
   jFil = pGrid.Rows
   jCol = pGrid.Cols


If pLado = Lados.Izquierdo Or pLado = Lados.Izq_Tran Then
    cMoneda = I_NemMon.Caption
    Nocionales = I_Nocionales.Text
Else
    cMoneda = D_NemMon.Caption
    Nocionales = D_Nocionales.Text
End If


For i = 1 To jFil
  If i = jFil Then Exit For
      Select Case OptCargaExcel
        Case 0
            If i >= 2 Then
              If i = pGrid.Rows - 1 Then
                pGrid.TextMatrix(i, 2) = Format(CDbl(pGrid.TextMatrix(i, 17)), TipoFormato(cMoneda))
                pGrid.TextMatrix(i, 18) = CDbl(100 * (pGrid.TextMatrix(i, 17) - 0#) / pGrid.TextMatrix(2, 17))
              Else
                pGrid.TextMatrix(i, 2) = Format(CDbl(pGrid.TextMatrix(i, 17) - (pGrid.TextMatrix((i + 1), 17))), TipoFormato(cMoneda))
                pGrid.TextMatrix(i, 18) = CDbl(100 * (pGrid.TextMatrix(i, 17) - (pGrid.TextMatrix((i + 1), 17))) / pGrid.TextMatrix(2, 17))
              End If
            End If

        Case 1
            If i >= 2 Then
                pGrid.TextMatrix(i, 17) = Format(CDbl(pGrid.TextMatrix(i - 1, 17) - (pGrid.TextMatrix((i - 1), 2))), TipoFormato(cMoneda))
                pGrid.TextMatrix(i, 18) = CDbl(100 * (pGrid.TextMatrix(i, 17) - 0) / pGrid.TextMatrix(2, 17))
            End If

        Case 2
            If i >= 2 Then
                pGrid.TextMatrix(i, 2) = Format(CDbl(pGrid.TextMatrix(2, 17) * (pGrid.TextMatrix(i, 18))) / 100#, TipoFormato(cMoneda))
                pGrid.TextMatrix(i, 17) = Format(CDbl(100# * (pGrid.TextMatrix(i, 17) - pGrid.TextMatrix(i, 18)) / 100#), TipoFormato(cMoneda))
                
            End If
            
        Case 3
        
            If i >= 2 Then
            
                If i = pGrid.Rows - 1 Then
                    pGrid.TextMatrix(i, 2) = Format(CDbl(Nocionales), TipoFormato(cMoneda))
                    pGrid.TextMatrix(i, 18) = Format(CDbl(100#), TipoFormato(cMoneda))
                Else
                    pGrid.TextMatrix(i, 2) = Format(0#, TipoFormato(cMoneda))
                    pGrid.TextMatrix(i, 17) = Format(Nocionales, TipoFormato(cMoneda))
                    pGrid.TextMatrix(i, 18) = Format(0#, TipoFormato(cMoneda))
                End If
                
            End If
        
        
      End Select
      

Next
End Sub

Function ValidaColFecha(nHoja As String, nFilas As Long, ruta As String)
''''''''    '// Código fuente de conexión tomado de la página de Softjaén
''''''''    '// Busca duplicados en una columna

Dim db As Database
Dim rs As Recordset
Dim rz As Recordset
Dim txtSQL As String
Dim SQLtxt As String
Dim colArr As Variant
Dim Y As Integer
Dim colTitulo As String
Dim cCont As Long

    ' Abro la hoja de cálculo, y utilizo la primera  fila de la hoja como nombres de los campos
    ' Lleno un arreglo con las columnas a utilizar
    
    ReDim colArr(4)
     
    colArr(0) = 2
    colArr(1) = 4
    colArr(2) = 5
    colArr(3) = 9
     
     cCont = 2
 'ruta = gsBac_DIREXEL & "Swap" & ".xls"
     Set db = OpenDatabase(ruta, False, False, "Excel 8.0;HDR=yes;")
     For Y = 0 To UBound(colArr)
       Select Case colArr(Y)
         Case 2       '// Se buscan duplicados y problemas de orden
           colTitulo = "vencimiento"
           txtSQL = ""
           txtSQL = "SELECT * FROM [" & nHoja & "$A1:B" & nFilas & "] WHERE "
           txtSQL = txtSQL & "" & colTitulo & " IN (SELECT " & colTitulo & " FROM [" & nHoja & "$A1:B" & nFilas & "] GROUP BY "
           txtSQL = txtSQL & "" & colTitulo & " HAVING COUNT(*) > 1);"
           
           Set rs = db.OpenRecordset(txtSQL, dbOpenDynaset)
           If Not rs.BOF And Not rs.EOF Then
             With rs
               iCadena = iCadena & " - Se han encontrado valores duplicados en la columna" & Chr(32) & UCase(colTitulo) & "," & Chr(32) & "para el(los) siguiente(s) flujo(s): " & vbCrLf
               Do While Not .EOF
                 iCadena = iCadena & "   Flujo:" & Chr(32) & rs.Fields(0).Value & Chr(32) & "-" & Chr(32) & "Fecha:" & Chr(32) & rs.Fields(1).Value & vbCrLf
                 rs.MoveNext
               Loop
               rs.Close
             End With
             Set rs = Nothing
           Else
             rs.Close
             Set rs = Nothing
           End If
           
           '// Se comparan las columnas de Fecha de vencimiento para saber si están ordenadas
           txtSQL = ""
           SQLtxt = ""
           txtSQL = "SELECT * FROM [" & nHoja & "$B1:B" & nFilas & "] ORDER BY " & colTitulo & " ASC"
           SQLtxt = "SELECT * FROM [" & nHoja & "$B1:B" & nFilas & "] "
           Set rs = db.OpenRecordset(txtSQL, dbOpenDynaset)
           Set rz = db.OpenRecordset(SQLtxt, dbOpenDynaset)
           
           If Not rs.BOF And Not rs.EOF Then
             Do While Not rs.EOF
               If rs.Fields(0).Value <> rz.Fields(0).Value Then
                 iCadena = iCadena & vbCrLf
                 iCadena = iCadena & " - Existe(n) error(es) en el orden de fechas para la columna" & vbCrLf
                 iCadena = iCadena & "  " & Chr(32) & UCase(colTitulo) & "." & Chr(32) & "Por favor verifique " & vbCrLf
                 Exit Do
                 rs.MoveNext
                 rz.MoveNext
                 cCont = cCont + 1
               Else
                 rs.MoveNext
                 rz.MoveNext
                 cCont = cCont + 1
               End If
             Loop
             rs.Close
             rz.Close
             Set rs = Nothing '
             Set rz = Nothing
           Else
             rs.Close
             rz.Close
             Set rs = Nothing
             Set rz = Nothing
           End If
           cCont = 2
           
         Case 4   '// Se buscan duplicados
           colTitulo = "liquidacion"
           txtSQL = ""
           txtSQL = "SELECT * FROM [" & nHoja & "$A1:D" & nFilas & "] WHERE "
           txtSQL = txtSQL & "" & colTitulo & " IN (SELECT " & colTitulo & " FROM [" & nHoja & "$D1:D" & nFilas & "] GROUP BY "
           txtSQL = txtSQL & "" & colTitulo & " HAVING COUNT(*) > 1);"
           
           Set rs = db.OpenRecordset(txtSQL, dbOpenDynaset)
           If Not rs.BOF And Not rs.EOF Then
             With rs
               iCadena = iCadena & " - Se han encontrado valores duplicados en la columna" & Chr(32) & UCase(colTitulo) & "," & Chr(32) & "para el(los) siguiente(s) flujo(s): " & vbCrLf
               Do While Not .EOF
                 iCadena = iCadena & "   Flujo:" & Chr(32) & rs.Fields(0).Value & Chr(32) & "-" & Chr(32) & "Fecha:" & Chr(32) & rs.Fields(3).Value & vbCrLf
                 rs.MoveNext
                 cCont = cCont + 1
               Loop
               rs.Close
             End With
             Set rs = Nothing
           Else
             rs.Close
             Set rs = Nothing
           End If
           cCont = 2
           
''''         Case 5   '// Se buscan duplicados
''''           colTitulo = "[fecha fixin]"
''''           txtSQL = ""
''''           txtSQL = "SELECT * FROM [" & nHoja & "$A1:E" & nFilas & "] WHERE "
''''           txtSQL = txtSQL & "" & colTitulo & " IN (SELECT " & colTitulo & " FROM [" & nHoja & "$E1:E" & nFilas & "] GROUP BY "
''''           txtSQL = txtSQL & "" & colTitulo & " HAVING COUNT(*) > 1);"
''''
''''           Set rs = db.OpenRecordset(txtSQL, dbOpenDynaset)
''''           If Not rs.BOF And Not rs.EOF Then
''''             With rs
''''               iCadena = iCadena & vbCrLf
''''               iCadena = iCadena & " - Se han encontrado valores duplicados en la columna" & Chr(32) & UCase(colTitulo) & "," & Chr(32) & "para el(los) siguiente(s) flujo(s): " & vbCrLf
''''               Do While Not .EOF
''''                 iCadena = iCadena & "   Flujo:" & Chr(32) & rs.Fields(0) & Chr(32) & "-" & Chr(32) & "Fecha:" & Chr(32) & rs.Fields(4).Value & vbCrLf
''''                 cCont = cCont + 1
''''                 rs.MoveNext
''''               Loop
''''               rs.Close
''''             End With
''''             Set rs = Nothing
''''           Else
''''             rs.Close
''''             Set rs = Nothing
''''           End If
''''           cCont = 1
           
         Case 9      '// Se buscan duplicados
           colTitulo = "[fecha valuta]"
           txtSQL = ""
           txtSQL = "SELECT * FROM [" & nHoja & "$A1:I" & nFilas & "] WHERE "
           txtSQL = txtSQL & "" & colTitulo & " IN (SELECT " & colTitulo & " FROM [" & nHoja & "$I1:I" & nFilas & "] GROUP BY "
           txtSQL = txtSQL & "" & colTitulo & " HAVING COUNT(*) > 1);"
           
           Set rs = db.OpenRecordset(txtSQL, dbOpenDynaset)
           If Not rs.BOF And Not rs.EOF Then
             With rs
               iCadena = iCadena & " - Se han encontrado valores duplicados en la columna" & Chr(32) & UCase(colTitulo) & "," & Chr(32) & "para el(los) siguiente(s) flujo(s): " & vbCrLf
               Do While Not .EOF
                 iCadena = iCadena & "   Flujo:" & Chr(32) & rs.Fields(0).Value & Chr(32) & "-" & Chr(32) & "Fecha:" & Chr(32) & rs.Fields(8).Value & vbCrLf
                 cCont = cCont + 1
                 rs.MoveNext
               Loop
               rs.Close
             End With
             Set rs = Nothing
           Else
             rs.Close
             Set rs = Nothing
           End If
           cCont = 1
           
       End Select
     Next
     db.Close
     Set db = Nothing

End Function

Private Sub rutaexcel()
  cd.DefaultExt = ".xls"
  cd.Filter = ".xls"
  cd.DialogTitle = "Cargar excel"
  cd.FileName = ""
  cd.InitDir = App.Path
  cd.ShowOpen
End Sub

Private Function Carga_Tasa_Grilla(Tasa As Double, Spread As Double, grilla As MSFlexGrid, MiLado As Lados)
   Dim i As Long
   
    Let i = 1
    
    Do While i <= grilla.Rows - 1
        grilla.TextMatrix(i, 3) = CDbl(Tasa + Spread)
        i = i + 1
    Loop
        
    Call CalculoInteresBonos(MiLado, grilla)

End Function

Private Sub Abre_Excel(ruta As String)
    Set xlapp = CreateObject("Excel.Application")
    Set xlbook = xlapp.Workbooks.Open(ruta)
End Sub
Private Sub Cierra_Excel()
    xlbook.Close
    xlapp.Quit
    Set xlbook = Nothing
    Set xlapp = Nothing
End Sub
 
Private Sub Inhabilita()

    Intercambio(0).Enabled = False
    Intercambio(1).Enabled = False
    
    I_FERIADOS_F.Enabled = False
    I_DiasReset.Enabled = False
    I_FERIADOS_L.Enabled = False
    I_Convencion.Enabled = False
    
    
    D_FERIADOS_F.Enabled = False
    D_DiasReset.Enabled = False
    D_FERIADOS_L.Enabled = False
    D_Convencion.Enabled = False

End Sub

Private Function ValidaDatosPantalla() As Boolean
   Dim cuenta_D As Long
   Dim cuenta_I As Long
   Dim I_cArrFecVcto()
   Dim I_cArrFecDup()
   
   Dim D_cArrFecVcto()
   Dim D_cArrFecDup()
   Dim TipoSwap               As Integer
   Dim nTasaSpread_Recibe     As Double
   Dim nTasaSpread_Paga       As Double
   Dim nTasaSpreadTran_Recibe As Double
   Dim nTasaSpreadTran_Paga   As Double
   Dim cResValidaMargenTran   As String

   
   ValidaDatosPantalla = False
   
   iCadena = ""
   
   ReDim I_cArrFecVcto(I_Grid.Rows - 1)
   ReDim I_cArrFecDup(I_Grid.Rows - 1)
   
   ReDim D_cArrFecVcto(D_Grid.Rows - 1)
   ReDim D_cArrFecDup(D_Grid.Rows - 1)

   '--> Recorre la Izquierda sobre la Derecha (Flujos)
   
   For cuenta_I = 1 To I_Grid.Rows - 1
       I_cArrFecVcto(cuenta_I) = I_Grid.TextMatrix(cuenta_I, 1)
   Next
    
   Call ValidaOrdenFechaVcto(I_cArrFecVcto)
   iCadena = iCadena & iCad
   iCad = ""
   
   Call ValidaDuplicidadFechaVcto(I_cArrFecVcto)
   iCadena = iCadena & iCad
   iCad = ""
   
   If Me.I_Grid.Rows = 1 Then
      ValidaDatosPantalla = False
       Frm_Msg_Planilla_Excel.TxtMsg.Text = "Debe generar Flujos"
       Exit Function
   End If
   
   
   If DateDiff("d", CDate(CDate(I_Madurez.Text)), CDate(D_Madurez.Text)) <> 0 Then
      iCadena = iCadena & vbCrLf
      iCadena = iCadena & " - Fecha de Madurez(Recibo)debe ser igual a Fecha de Madurez(Pago) " & vbCrLf
   Else
      If (DateDiff("d", CDate(CDate(I_Grid.TextMatrix(I_Grid.Rows - 1, 1))), CDate(D_Madurez.Text)) <> 0) And _
               (DateDiff("d", CDate(CDate(D_Grid.TextMatrix(D_Grid.Rows - 1, 1))), CDate(I_Madurez.Text)) <> 0) Then
         iCadena = iCadena & vbCrLf
         iCadena = iCadena & " - Fecha de Madurez debe ser igual a Fecha Vcto. del " & vbCrLf
         iCadena = iCadena & "   último flujo, ya sea Recibimos o Pagamos " & vbCrLf
      End If
   End If
   
   '*******************************************************************************************************************
   '************************************ VALIDACION MARGEN DE TRANSFERENCIA RECIBE ************************************
   '*******************************************************************************************************************
   
   TipoSwap = EntregaTipoSwap
   Tipo_Producto = IIf(TipoSwap = 1, "ST", IIf(TipoSwap = 2, "SM", "SP"))
  
   Call Proc_Consulta_Porcentaje_Transacciones(Tipo_Producto)
  
   nTasaSpread_Recibe = CDbl(CDbl(I_UltimoIndice.Text) + IIf(I_Spread.Visible = True, CDbl(I_Spread.Text), 0#))
   nTasaSpreadTran_Recibe = CDbl(CDbl(I_Indice_Tran.Text) + IIf(I_Spread_Tran.Visible = True, CDbl(I_Spread_Tran.Text), 0#))
  
   'nTasaSpread_Recibe = CDbl(I_UltimoIndice.Text + IIf(I_Spread.Visible = True, I_Spread.Text, 0#))
   
   'nTasaSpreadTran_Recibe = CDbl(I_Indice_Tran.Text + IIf(I_Spread_Tran.Visible = True, I_Spread_Tran.Text, 0#))
   
   cResValidaMargenTran = ""
  
   ' RECIBIMOS
   If Not Proc_Valida_Tasa_Transferencia(nTasaSpread_Recibe, nTasaSpreadTran_Recibe, cResValidaMargenTran) Then
      iCadena = iCadena & vbCrLf
      iCadena = iCadena & cResValidaMargenTran & vbCrLf
   End If
   
   '*******************************************************************************************************************
   '*******************************************************************************************************************
   '*******************************************************************************************************************
    
   If iCadena <> "" Then ''Or iCad <> ""
      Frm_Msg_Planilla_Excel.TxtMsg.Text = Frm_Msg_Planilla_Excel.TxtMsg.Text & vbCrLf & "Para la pata Recibe se ha encontrado que:" & vbCrLf
      Frm_Msg_Planilla_Excel.TxtMsg.Text = Frm_Msg_Planilla_Excel.TxtMsg.Text & vbCrLf & iCadena
      iCadena = ""
      iCad = ""
   End If

   '--> Recorre la Derecha sobre la Izquierda (Flujos)
 
   For cuenta_D = 1 To D_Grid.Rows - 1
      D_cArrFecVcto(cuenta_D) = D_Grid.TextMatrix(cuenta_D, 1)
   Next
   
   Call ValidaOrdenFechaVcto(D_cArrFecVcto)
   iCadena = iCadena & iCad
   iCad = ""
   
   Call ValidaDuplicidadFechaVcto(D_cArrFecVcto)
   iCadena = iCadena & iCad
   iCad = ""
 
   If DateDiff("d", CDate(CDate(D_Madurez.Text)), CDate(I_Madurez.Text)) <> 0 Then
      iCadena = iCadena & vbCrLf
      iCadena = iCadena & " - Fecha de Madurez(Pago)debe ser igual a Fecha de Madurez(Recibo) " & vbCrLf
   Else
      If (DateDiff("d", CDate(CDate(I_Grid.TextMatrix(I_Grid.Rows - 1, 1))), CDate(D_Madurez.Text)) <> 0) And _
             (DateDiff("d", CDate(CDate(D_Grid.TextMatrix(D_Grid.Rows - 1, 1))), CDate(I_Madurez.Text)) <> 0) Then
         iCadena = iCadena & vbCrLf
         iCadena = iCadena & " - Fecha de Madurez debe ser igual a Fecha Vcto. del " & vbCrLf
         iCadena = iCadena & "   último flujo, ya sea Recibimos o Pagamos " & vbCrLf
      End If
   End If
   
   '*****************************************************************************************************************
   '************************************ VALIDACION MARGEN DE TRANSFERENCIA PAGA ************************************
   '*****************************************************************************************************************
   
   nTasaSpread_Paga = CDbl(D_UltimoIndice.Text) + IIf(D_Spread.Visible = True, CDbl(D_Spread.Text), 0#)
   nTasaSpreadTran_Paga = CDbl(D_Indice_Tran.Text) + IIf(D_Spread_Tran.Visible = True, CDbl(D_Spread_Tran.Text), 0#)
   
   cResValidaMargenTran = ""
   
   ' PAGAMOS
   If Not Proc_Valida_Tasa_Transferencia(nTasaSpread_Paga, nTasaSpreadTran_Paga, cResValidaMargenTran) Then
      iCadena = iCadena & vbCrLf
      iCadena = iCadena & cResValidaMargenTran & vbCrLf
   End If
   
   '************************************************************************************************************
   '************************************************************************************************************
   '************************************************************************************************************
    
   If iCadena <> "" Then
      Frm_Msg_Planilla_Excel.TxtMsg.Text = Frm_Msg_Planilla_Excel.TxtMsg.Text & vbCrLf & "Para la pata Paga se ha encontrado que:" & vbCrLf
      Frm_Msg_Planilla_Excel.TxtMsg.Text = Frm_Msg_Planilla_Excel.TxtMsg.Text & vbCrLf & iCadena
      iCadena = ""
      iCad = ""
   End If
  
   If Modalidad.Text = "COMPENSACION" Then
      If I_MonPago <> D_MonPago Then
         iCadena = iCadena & vbCrLf
         iCadena = iCadena & " - Monedas de Pago deben ser iguales en ambos lados. " & vbCrLf
         Frm_Msg_Planilla_Excel.TxtMsg.Text = Frm_Msg_Planilla_Excel.TxtMsg.Text & vbCrLf & iCadena
      End If
   Else
      If I_MonPago = D_MonPago Then
         iCadena = iCadena & vbCrLf
         iCadena = iCadena & " - Monedas de Pago deben ser distintas en ambos lados. " & vbCrLf
         Frm_Msg_Planilla_Excel.TxtMsg.Text = Frm_Msg_Planilla_Excel.TxtMsg.Text & vbCrLf & iCadena
      End If
   End If
    
   If Frm_Msg_Planilla_Excel.TxtMsg.Text <> "" Then
      Exit Function
   End If
   
   ValidaDatosPantalla = True

End Function

Private Sub ValidaIntercamNocExcel()

'CER 01/07/2008  - Flexibilización Intercambio Nocionales
Dim ContIzq As Long
Dim ContDer As Long
Dim FechaIzq As Date
Dim AmortIzq As Double
Dim InterNocIzq As String
Dim FechaDer As Date
Dim AmortDer As Double
Dim InterNocDer As String
Dim Sw_Pag As Long
Dim Sw_Rec As Long
Dim MsgDet As String
Dim MsgTitPag As String
Dim MsgTitRec As String

'' CER 03/07/2008  - Flexibilización Intercambio Nocionales
Let Sw_Pag = 0
Let Sw_Rec = 0
Let MsgDet = ""
Let MsgTitPag = ""
Let MsgTitRec = ""

MsgTitPag = MsgTitPag & vbCrLf & vbCrLf & "Para la hoja Paga se ha encontrado que " & vbCrLf
MsgTitPag = MsgTitPag & vbCrLf & "Intercambio de Nocionales difiere con hoja Recibe " & vbCrLf
MsgTitPag = MsgTitPag & vbCrLf & "para las siguientes fechas: " & vbCrLf


   For ContIzq = 0 To FilMatIzq
       Let FechaIzq = MatrizIzq(ContIzq, 1)
       Let AmortIzq = MatrizIzq(ContIzq, 2)
       Let InterNocIzq = MatrizIzq(ContIzq, 3)
        
       For ContDer = 0 To FilMatDer - 1
           If FechaIzq = MatrizDer(ContDer, 1) Then
           
               If InterNocIzq <> MatrizDer(ContDer, 3) And (MatrizDer(ContDer, 2) <> 0) Then
              '---> Se comenta a Solicitud de Cristian Mascareño.- con Fecha 28-05-2009
              '''' MsgDet = MsgDet & vbCrLf
              '''' MsgDet = MsgDet & " - " & FechaIzq & vbCrLf
              '''' Sw_Pag = 1
               End If
           
           End If
       
       Next
       
   Next
   
   If Sw_Pag = 0 Then
     MsgTitPag = ""
   Else
     MsgInterNoc = MsgInterNoc & vbCrLf
     MsgInterNoc = MsgInterNoc & MsgTitPag & vbCrLf
     MsgInterNoc = MsgInterNoc & MsgDet & vbCrLf
   End If
   
 Let MsgDet = ""
   
MsgTitRec = MsgTitRec & vbCrLf & vbCrLf & "Para la hoja Recibe se ha encontrado que " & vbCrLf
MsgTitRec = MsgTitRec & vbCrLf & "Intercambio de Nocionales difiere con hoja Paga " & vbCrLf
MsgTitRec = MsgTitRec & vbCrLf & "para las siguientes fechas: " & vbCrLf
   
   
   For ContDer = 0 To FilMatDer
       FechaDer = MatrizDer(ContDer, 1)
       AmortDer = MatrizDer(ContDer, 2)
       InterNocDer = MatrizDer(ContDer, 3)
        
       For ContIzq = 0 To FilMatIzq - 1
           If FechaDer = MatrizIzq(ContIzq, 1) Then
           
               If InterNocDer <> MatrizIzq(ContIzq, 3) And (MatrizIzq(ContIzq, 2) <> 0) Then
               '---> Se comenta a Solicitud de Cristian Mascareño.- con Fecha 28-05-2009
               '''' MsgDet = MsgDet & vbCrLf
               '''' MsgDet = MsgDet & " - " & FechaDer & vbCrLf
               '''' Let Sw_Rec = 1
               End If
           
           End If
       
       Next
       
   Next
   
   If Sw_Rec = 0 Then
     MsgTitRec = ""
   Else
     MsgInterNoc = MsgInterNoc & vbCrLf
     MsgInterNoc = MsgInterNoc & MsgTitRec & vbCrLf
     MsgInterNoc = MsgInterNoc & MsgDet & vbCrLf
   End If



End Sub


Private Sub ValidaOrdenFechaVcto(cArrFecVcto)
Dim iMin               As Long
Dim imax               As Long
Dim pos                As Long


'//Verifica que columna Vencimiento se encuentre en orden
   
    iCad = ""
    iMin = LBound(cArrFecVcto)
    imax = UBound(cArrFecVcto)
    Do While imax > iMin
        
        pos = iMin
        For i = iMin To imax - 1
        
         If cArrFecVcto(i + 1) = "" Then Exit For
            If CDate(cArrFecVcto(i)) > CDate(cArrFecVcto(i + 1)) Then
               cArrFectemp = cArrFecVcto(i + 1)
               cArrFecVcto(i + 1) = cArrFecVcto(i)
               cArrFecVcto(i) = cArrFectemp
            
               pos = i
               iCad = iCad & vbCrLf
               iCad = iCad & " - Existe(n) error(es) en el orden de fechas para la columna  " & vbCrLf
               iCad = iCad & "    Vencimiento. Por favor verifique " & vbCrLf

               Exit Do
            End If
            
        Next i
        imax = pos
    
    Loop
      

End Sub


Private Sub ValidaDuplicidadFechaVcto(cArrFecDup)
Dim iMin               As Long
Dim imax               As Long
Dim pos                As Long


  '//Verifica que en columna Vencimiento no haya duplicidad
    iCad = ""
    iMin = LBound(cArrFecDup)
    imax = UBound(cArrFecDup)

    Do While imax > iMin
        
        pos = iMin
        For i = iMin To imax - 1
            If cArrFecDup(i + 1) = "" Then Exit For
            If cArrFecDup(i) = cArrFecDup(i + 1) Then
            cArrFectemp = cArrFecDup(i + 1)
            cArrFecDup(i + 1) = cArrFecDup(i)
            cArrFecDup(i) = cArrFectemp
            
            pos = i
            iCad = iCad & vbCrLf
            iCad = iCad & " - Existe(n) error(es) de duplicidad de fechas para la columna " & vbCrLf
            iCad = iCad & "    Vencimiento. Por favor verifique " & vbCrLf

            Exit Do
            End If
            
        Next i
        imax = pos
    
    Loop
End Sub

Sub CargaTicketCartera()
    MiObjSwapTicket.dFecha_operacion = gsBAC_Fecp
    MiObjSwapTicket.nNumero_Operacion = MiObjSwapTicket.NuevoNumTicket

    MeA09_Moneda = IIf(iTipoFlujo = 1, miForm.I_Moneda.ItemData(miForm.I_Moneda.ListIndex), miForm.D_Moneda.ItemData(miForm.D_Moneda.ListIndex))


End Sub
Private Function CalculaVAC(ByRef TipoSwap As String)
Dim nTipoSwap As Integer
Dim AVRMoPesos As Double
Dim AVRMo As Double
Dim KMo As Double
Dim FactorMoneda As Double
Dim MonedaDM As String
Dim CodMoneda As Integer
Dim vMonedas As New ClsMoneda
Dim TipoCambio As Double
Dim MonNemo As String

Dim origTipoSwap As Integer 'PRD-10494
Dim oTipoSwap As String     'PRD-10494

    If Val(I_Nocionales.Text) = 0 Then
        CalculaVAC = 0
        Exit Function
    End If
    If gsBAC_DolarObs = 0 Then
        CalculaVAC = 0
        Exit Function
    End If
    KMo = CDbl(I_Nocionales.Text)
    
    nTipoSwap = EntregaTipoSwap
    
    'PRD-10494 inicio
    origTipoSwap = nTipoSwap    'Tipo de Swap original
    Select Case origTipoSwap
        Case 1
            oTipoSwap = "ST"    'Swap de Tasas
        Case 2
            oTipoSwap = "SM"    'Swap de Monedas
        Case 4
            oTipoSwap = "SP"    'Swap Proemdio Cámara
    End Select
    'PRD-10494 fin
    
    If nTipoSwap = 4 Then
        TipoSwap = "ST"     'Aplicar como Swap de Tasas, PRD-3860
        nTipoSwap = 1       'Usuario definió tipo de Swap 4 tratarlo como 1
    End If
    If nTipoSwap = 1 Then   'SWAP DE TASAS
        TipoSwap = "ST"
        FactorMoneda = 1
        MonedaDM = "M"
        CodMoneda = I_Moneda.ItemData(I_Moneda.ListIndex)
        If vMonedas.LeerxCodigo(CodMoneda) Then
            FactorMoneda = vMonedas.vmValor
            MonedaDM = vMonedas.mnrrda
        End If

        If FactorMoneda = 0 Then
            FactorMoneda = 1
        End If
        'Recordar que Ctrlpt_ValorRazonable viene en CLP
        'Por requerimientos de usuario certificador cambiar algoritmo:
        '  Si moneda es no CLP pasar la moneda a CLP
        If CodMoneda = 13 Then
            FactorMoneda = gsBAC_DolarObs
        End If
        AVRMo = Ctrlpt_ValorRazonable
        If CodMoneda <> 999 Then
            KMo = KMo * FactorMoneda
        End If
        
        If KMo = 0 Then ' Ojo con la division por cero
            CalculaVAC = 0
        Else
        CalculaVAC = AVRMo / KMo
    End If
    End If
    If nTipoSwap = 2 Then   'SWAP DE MONEDAS
        'Según la moneda origen, traer el tipo de cambio.  Si es USD usar gsBAC_DolarObs, si es CLP usar 1, si otra usar vMonedas.vmValor
        CodMoneda = I_Moneda.ItemData(I_Moneda.ListIndex)
        If vMonedas.LeerxCodigo(CodMoneda) Then
            MonNemo = vMonedas.mnnemo
        End If
        Select Case MonNemo
            Case "CLP"
                TipoCambio = 1
            Case "USD"
                TipoCambio = gsBAC_DolarObs
            Case Else
                    TipoCambio = vMonedas.vmValor
        End Select
        TipoSwap = "SM"
        If Ctrlpt_ValorRazonable = 0 Then
            AVRMoPesos = 0#
        Else
                AVRMoPesos = Ctrlpt_ValorRazonable
       End If
        If (KMo * TipoCambio) = 0 Then  ' Ojo con la division por cero
            CalculaVAC = 0
        Else
            CalculaVAC = (AVRMoPesos) / (KMo * TipoCambio)
        End If
    End If
    
    TipoSwap = oTipoSwap    'PRD-10494, reestablecer el tipo swap original
End Function

