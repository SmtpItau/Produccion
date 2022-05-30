VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_ANTICIPO_OP 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Anticipos de Swap.-"
   ClientHeight    =   6045
   ClientLeft      =   135
   ClientTop       =   150
   ClientWidth     =   13890
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6045
   ScaleWidth      =   13890
   Begin TabDlg.SSTab MiTab 
      Height          =   5520
      Left            =   6255
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   480
      Width           =   7590
      _ExtentX        =   13388
      _ExtentY        =   9737
      _Version        =   393216
      Tabs            =   4
      TabsPerRow      =   4
      TabHeight       =   520
      BackColor       =   -2147483638
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Contrato en Cartera"
      TabPicture(0)   =   "FRM_ANTICIPO_OP.frx":0000
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "GRID_CARTERA"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).ControlCount=   1
      TabCaption(1)   =   "Operacion Anticipada"
      TabPicture(1)   =   "FRM_ANTICIPO_OP.frx":001C
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "GRID_ANTICIPO"
      Tab(1).ControlCount=   1
      TabCaption(2)   =   "Operacion Saldo"
      TabPicture(2)   =   "FRM_ANTICIPO_OP.frx":0038
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "LBLMensaje"
      Tab(2).Control(1)=   "GRID_SALDO"
      Tab(2).ControlCount=   2
      TabCaption(3)   =   "Anticipo Op. Espejo"
      TabPicture(3)   =   "FRM_ANTICIPO_OP.frx":0054
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "EtiquetasEspejo"
      Tab(3).Control(1)=   "LBL_OpEspejo"
      Tab(3).Control(2)=   "GRID_ESPEJO"
      Tab(3).ControlCount=   3
      Begin MSFlexGridLib.MSFlexGrid GRID_ANTICIPO 
         Height          =   3945
         Left            =   -74925
         TabIndex        =   44
         TabStop         =   0   'False
         Top             =   345
         Width           =   6360
         _ExtentX        =   11218
         _ExtentY        =   6959
         _Version        =   393216
         Rows            =   14
         Cols            =   3
         FixedRows       =   0
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColorSel    =   -2147483624
         BackColorBkg    =   -2147483633
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483633
         GridLines       =   0
         GridLinesFixed  =   0
         BorderStyle     =   0
         Appearance      =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin MSFlexGridLib.MSFlexGrid GRID_CARTERA 
         Height          =   3945
         Left            =   75
         TabIndex        =   8
         TabStop         =   0   'False
         Top             =   345
         Width           =   7080
         _ExtentX        =   12488
         _ExtentY        =   6959
         _Version        =   393216
         Rows            =   14
         Cols            =   3
         FixedRows       =   0
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColor       =   -2147483630
         ForeColorSel    =   -2147483624
         BackColorBkg    =   -2147483633
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483633
         GridLines       =   0
         GridLinesFixed  =   0
         BorderStyle     =   0
         Appearance      =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin MSFlexGridLib.MSFlexGrid GRID_SALDO 
         Height          =   3885
         Left            =   -74925
         TabIndex        =   46
         TabStop         =   0   'False
         Top             =   345
         Width           =   6360
         _ExtentX        =   11218
         _ExtentY        =   6853
         _Version        =   393216
         Rows            =   14
         Cols            =   3
         FixedRows       =   0
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColorSel    =   -2147483624
         BackColorBkg    =   -2147483633
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483633
         GridLines       =   0
         GridLinesFixed  =   0
         BorderStyle     =   0
         Appearance      =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin MSFlexGridLib.MSFlexGrid GRID_ESPEJO 
         Height          =   3555
         Left            =   -74925
         TabIndex        =   48
         TabStop         =   0   'False
         Top             =   720
         Width           =   5475
         _ExtentX        =   9657
         _ExtentY        =   6271
         _Version        =   393216
         Rows            =   14
         Cols            =   3
         FixedRows       =   0
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColor       =   -2147483630
         ForeColorSel    =   -2147483624
         BackColorBkg    =   -2147483633
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483633
         GridLines       =   0
         GridLinesFixed  =   0
         BorderStyle     =   0
         Appearance      =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label LBL_OpEspejo 
         AutoSize        =   -1  'True
         Caption         =   "Label1"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   -72930
         TabIndex        =   50
         Top             =   405
         Width           =   570
      End
      Begin VB.Label EtiquetasEspejo 
         AutoSize        =   -1  'True
         Caption         =   "N° Operación Espejo"
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
         Left            =   -74895
         TabIndex        =   49
         Top             =   405
         Width           =   1695
      End
      Begin VB.Label LBLMensaje 
         Alignment       =   2  'Center
         Caption         =   "NO DISPONIBLE"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   26.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   1050
         Left            =   -74835
         TabIndex        =   45
         Top             =   795
         Width           =   5985
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   24
      Top             =   0
      Width           =   13890
      _ExtentX        =   24500
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   8
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar Anticipos."
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Datos de la transacción"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5670
         Top             =   -15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   5
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ANTICIPO_OP.frx":0070
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ANTICIPO_OP.frx":0F4A
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ANTICIPO_OP.frx":1E24
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ANTICIPO_OP.frx":213E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ANTICIPO_OP.frx":3018
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FRACabecera 
      Height          =   750
      Left            =   15
      TabIndex        =   25
      Top             =   375
      Width           =   4140
      Begin VB.Label LBLNumeroOperacion 
         Alignment       =   2  'Center
         BackColor       =   &H80000018&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "1152"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   2100
         TabIndex        =   14
         Top             =   360
         Width           =   1905
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Número de Operación"
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
         Left            =   2130
         TabIndex        =   27
         Top             =   150
         Width           =   1815
      End
      Begin VB.Label LBLFechaAnticipo 
         Alignment       =   2  'Center
         BackColor       =   &H80000018&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "29/11/2009"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   60
         TabIndex        =   13
         Top             =   360
         Width           =   1890
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha de Anticipación"
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
         Left            =   90
         TabIndex        =   26
         Top             =   150
         Width           =   1830
      End
   End
   Begin VB.Frame FRAModalidad 
      Enabled         =   0   'False
      Height          =   750
      Left            =   4170
      TabIndex        =   28
      Top             =   375
      Width           =   2070
      Begin VB.ComboBox CmbModalidad 
         BackColor       =   &H80000018&
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   75
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   345
         Width           =   1965
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Modalidad de Pago"
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
         Index           =   2
         Left            =   105
         TabIndex        =   29
         Top             =   150
         Width           =   1590
      End
   End
   Begin VB.Frame FRAMarkToMarket 
      Height          =   1170
      Left            =   30
      TabIndex        =   30
      Top             =   1035
      Width           =   6210
      Begin VB.CheckBox CHKTipoAnticipo 
         Caption         =   "Anticipo Total"
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
         Left            =   4335
         TabIndex        =   0
         Top             =   345
         Width           =   1560
      End
      Begin VB.Label PorMTM 
         Alignment       =   2  'Center
         BackColor       =   &H80000018&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   60
         TabIndex        =   18
         Top             =   660
         Width           =   1425
      End
      Begin VB.Label PorMtoMTM 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000018&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0.0000"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1515
         TabIndex        =   19
         Top             =   660
         Width           =   2550
      End
      Begin VB.Label LBLMTM 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000018&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "10.000.000,0000"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   675
         TabIndex        =   17
         Top             =   345
         Width           =   3390
      End
      Begin VB.Label LBLMonMTM 
         Alignment       =   2  'Center
         BackColor       =   &H80000018&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "CLP"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   45
         TabIndex        =   16
         Top             =   345
         Width           =   600
      End
      Begin VB.Label Etiquetas 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Mark to Market"
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
         Index           =   3
         Left            =   1395
         TabIndex        =   31
         Top             =   135
         Width           =   1320
      End
   End
   Begin VB.Frame FRA_ANTICIPO_TOTAL 
      Height          =   2985
      Left            =   45
      TabIndex        =   32
      Top             =   2250
      Width           =   6210
      Begin VB.TextBox TXTAnticipoOtraMda 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000004&
         BorderStyle     =   0  'None
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
         ForeColor       =   &H80000006&
         Height          =   285
         Left            =   2160
         TabIndex        =   53
         Text            =   "Eq.USD"
         Top             =   1050
         Width           =   1305
      End
      Begin BACControles.TXTNumero TXTValorAnticipoOtraMda 
         Height          =   285
         Left            =   3480
         TabIndex        =   52
         Tag             =   "0.0000"
         Top             =   1050
         Width           =   2460
         _ExtentX        =   4366
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TXTValorAnticipoTmp 
         Height          =   315
         Left            =   3480
         TabIndex        =   2
         Tag             =   "0.0000"
         Top             =   720
         Width           =   2475
         _ExtentX        =   4366
         _ExtentY        =   556
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin VB.Frame FRAValNominal 
         BorderStyle     =   0  'None
         Height          =   315
         Left            =   45
         TabIndex        =   38
         Top             =   345
         Width           =   6075
         Begin BACControles.TXTNumero TXTProcNominal 
            Height          =   315
            Left            =   2115
            TabIndex        =   1
            Top             =   0
            Width           =   1365
            _ExtentX        =   2408
            _ExtentY        =   556
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
            Text            =   "0.00000000"
            Text            =   "0.00000000"
            Min             =   "0"
            Max             =   "100"
            CantidadDecimales=   "8"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero TXTNominal 
            Height          =   315
            Left            =   3765
            TabIndex        =   9
            TabStop         =   0   'False
            Top             =   0
            Width           =   2190
            _ExtentX        =   3863
            _ExtentY        =   556
            BackColor       =   -2147483624
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
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
         Begin VB.Label Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "%"
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
            Index           =   13
            Left            =   3510
            TabIndex        =   40
            Top             =   60
            Width           =   195
         End
         Begin VB.Label Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Valor Nominal"
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
            Index           =   12
            Left            =   825
            TabIndex        =   39
            Top             =   60
            Width           =   1155
         End
      End
      Begin VB.ComboBox CMBMoneda 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   51
         Tag             =   "0"
         Top             =   720
         Width           =   1320
      End
      Begin BACControles.TXTNumero TXTValorParidad 
         Height          =   315
         Left            =   3480
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   1440
         Width           =   2475
         _ExtentX        =   4366
         _ExtentY        =   556
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TXTResultadoVta 
         Height          =   315
         Left            =   3480
         TabIndex        =   11
         TabStop         =   0   'False
         Top             =   2160
         Width           =   2475
         _ExtentX        =   4366
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TXTResultadoTrading 
         Height          =   315
         Left            =   3480
         TabIndex        =   12
         TabStop         =   0   'False
         Top             =   2520
         Width           =   2475
         _ExtentX        =   4366
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TXT_AnticipoTransf 
         Height          =   315
         Left            =   3480
         TabIndex        =   3
         Top             =   1800
         Width           =   2475
         _ExtentX        =   4366
         _ExtentY        =   556
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
      End
      Begin BACControles.TXTNumero TXTValorAnticipo 
         Height          =   315
         Left            =   2160
         TabIndex        =   10
         Tag             =   "0.0000"
         Top             =   705
         Width           =   2475
         _ExtentX        =   4366
         _ExtentY        =   556
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin VB.Label LbTCM 
         Caption         =   "TCM "
         Height          =   270
         Left            =   150
         TabIndex        =   54
         Top             =   1065
         Width           =   1560
      End
      Begin VB.Label LBLMonAnticipoTransf 
         Alignment       =   2  'Center
         BackColor       =   &H80000018&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "CLP"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2160
         TabIndex        =   21
         Top             =   1800
         Width           =   1305
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Anticipo Transferencia"
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
         Index           =   7
         Left            =   120
         TabIndex        =   47
         Top             =   1875
         Width           =   1905
      End
      Begin VB.Label LBLMonResultadoTrading 
         Alignment       =   2  'Center
         BackColor       =   &H80000018&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "CLP"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2160
         TabIndex        =   23
         Top             =   2520
         Width           =   1305
      End
      Begin VB.Label LBLMonResultadoVta 
         Alignment       =   2  'Center
         BackColor       =   &H80000018&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "CLP"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2160
         TabIndex        =   22
         Top             =   2160
         Width           =   1305
      End
      Begin VB.Label LBLParMonValParidad 
         Alignment       =   2  'Center
         BackColor       =   &H80000018&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "CLP / USD"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2160
         TabIndex        =   20
         Top             =   1440
         Width           =   1305
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Resultado Trading"
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
         Index           =   9
         Left            =   495
         TabIndex        =   37
         Top             =   2565
         Width           =   1545
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Resultado Venta"
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
         Index           =   8
         Left            =   615
         TabIndex        =   36
         Top             =   2220
         Width           =   1395
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Valor Paridad /TC"
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
         Index           =   6
         Left            =   555
         TabIndex        =   35
         Top             =   1515
         Width           =   1470
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Valor Anticipo"
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
         Index           =   5
         Left            =   855
         TabIndex        =   34
         Top             =   735
         Width           =   1170
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Anticipo Total"
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
         Index           =   4
         Left            =   75
         TabIndex        =   33
         Top             =   150
         Width           =   1170
      End
   End
   Begin VB.Frame Frame1 
      Height          =   735
      Left            =   0
      TabIndex        =   41
      Top             =   5265
      Width           =   6210
      Begin VB.ComboBox CMBMonPago 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   45
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   330
         Width           =   2955
      End
      Begin VB.ComboBox CMBFPago 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   3000
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   330
         Width           =   3150
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Moneda de Pago"
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
         Index           =   15
         Left            =   60
         TabIndex        =   43
         Top             =   120
         Width           =   1395
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Forma de Pago"
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
         Index           =   14
         Left            =   3015
         TabIndex        =   42
         Top             =   120
         Width           =   1260
      End
   End
End
Attribute VB_Name = "FRM_ANTICIPO_OP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public nNumeroOperacion    As Long
Public nTicketIntraMesa    As Boolean
Public Valor_anterior_TXTValorAnticipo As Double 'PRD-XXXX
  Dim nNominalActivo       As Double
  Dim nNominalPasivo       As Double
  Dim MTMActivo            As Double
  Dim MTMPasivo            As Double
  Dim MontoMTM             As Double

Private Function FuncSettingGrid(ByRef xGrilla As MSFlexGrid)
   '--> Funcion de Seteo para grillas contenedoras de información de contratos
   Let xGrilla.Rows = 15:                           Let xGrilla.FixedRows = 0
   Let xGrilla.Cols = 3:                            Let xGrilla.FixedCols = 0

   Let xGrilla.ColWidth(0) = 2100:                  Let xGrilla.ColAlignment(0) = flexAlignLeftCenter
   Let xGrilla.ColWidth(1) = 2100:                  Let xGrilla.ColAlignment(1) = flexAlignLeftCenter
   Let xGrilla.ColWidth(2) = 2100:                  Let xGrilla.ColAlignment(2) = flexAlignLeftCenter

   If xGrilla.Name = "GRID_ESPEJO" Then
      Let xGrilla.ColWidth(0) = 1800:                  Let xGrilla.ColAlignment(0) = flexAlignLeftCenter
      Let xGrilla.ColWidth(1) = 1800:                  Let xGrilla.ColAlignment(1) = flexAlignLeftCenter
      Let xGrilla.ColWidth(2) = 1800:                  Let xGrilla.ColAlignment(2) = flexAlignLeftCenter
   End If

   Let xGrilla.TextMatrix(0, 0) = "":               Let xGrilla.TextMatrix(0, 1) = "":   Let xGrilla.TextMatrix(0, 2) = ""
   Let xGrilla.TextMatrix(1, 0) = "Moneda":         Let xGrilla.TextMatrix(1, 1) = "":   Let xGrilla.TextMatrix(1, 2) = ""
   Let xGrilla.TextMatrix(2, 0) = "Monto":          Let xGrilla.TextMatrix(2, 1) = "":   Let xGrilla.TextMatrix(2, 2) = ""
   Let xGrilla.TextMatrix(3, 0) = "Frec. Pago":     Let xGrilla.TextMatrix(3, 1) = "":   Let xGrilla.TextMatrix(3, 2) = ""
   Let xGrilla.TextMatrix(4, 0) = "Frec. Capial":   Let xGrilla.TextMatrix(4, 1) = "":   Let xGrilla.TextMatrix(4, 2) = ""
   Let xGrilla.TextMatrix(5, 0) = "Indicador":      Let xGrilla.TextMatrix(5, 1) = "":   Let xGrilla.TextMatrix(5, 2) = ""
   Let xGrilla.TextMatrix(6, 0) = "Val. Indice":    Let xGrilla.TextMatrix(6, 1) = "":   Let xGrilla.TextMatrix(6, 2) = ""
   Let xGrilla.TextMatrix(7, 0) = "Spread":         Let xGrilla.TextMatrix(7, 1) = "":   Let xGrilla.TextMatrix(7, 2) = ""
   Let xGrilla.TextMatrix(8, 0) = "Coneto Dias":    Let xGrilla.TextMatrix(8, 1) = "":   Let xGrilla.TextMatrix(8, 2) = ""
   Let xGrilla.TextMatrix(9, 0) = "Moneda Pago":    Let xGrilla.TextMatrix(9, 1) = "":   Let xGrilla.TextMatrix(9, 2) = ""
   Let xGrilla.TextMatrix(10, 0) = "Medio  Pago":   Let xGrilla.TextMatrix(10, 1) = "":  Let xGrilla.TextMatrix(10, 2) = ""
   Let xGrilla.TextMatrix(11, 0) = "Fecha Inicio":  Let xGrilla.TextMatrix(11, 1) = "":  Let xGrilla.TextMatrix(11, 2) = ""
   Let xGrilla.TextMatrix(12, 0) = "Fecha Termino": Let xGrilla.TextMatrix(12, 1) = "":  Let xGrilla.TextMatrix(12, 2) = ""
   Let xGrilla.TextMatrix(13, 0) = "Valor MTM":     Let xGrilla.TextMatrix(13, 1) = "":  Let xGrilla.TextMatrix(13, 2) = ""
   Let xGrilla.TextMatrix(14, 0) = "AVR":           Let xGrilla.TextMatrix(14, 1) = "":  Let xGrilla.TextMatrix(14, 2) = ""
End Function

Private Function LoadModalidadPago(ObjModalidad As ComboBox)
   '--> Carga los datos de Modalidades de Pago
   Let Screen.MousePointer = vbHourglass

   Call ObjModalidad.Clear
   Call ObjModalidad.AddItem("COMPENSACION")
   Call ObjModalidad.AddItem("ENTREGA FISICA")

   Let Screen.MousePointer = vbDefault
End Function

Private Function LoadMediosPago(ByRef MiObjeto As ComboBox, ByVal MiMoneda As Long)
   Dim SqlDatos()
   
   Let Screen.MousePointer = vbHourglass
   
   Envia = Array()
   AddParam Envia, CDbl(MiMoneda)
   AddParam Envia, CDbl(MiMoneda)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(1)
   AddParam Envia, "PCS"
   If Not Bac_Sql_Execute("SP_LEER_DOCPAGOMONEDA", Envia) Then
      Call MsgBox("Se ha originado un error al tratar de leer las formas de pago.", vbExclamation, App.Title)
      Exit Function
   End If
   Call MiObjeto.Clear
   Do While Bac_SQL_Fetch(SqlDatos())
      Call MiObjeto.AddItem(SqlDatos(6))
       Let MiObjeto.ItemData(MiObjeto.NewIndex) = CDbl(SqlDatos(5))
   Loop
   
   Let Screen.MousePointer = vbDefault

End Function

Private Function LoadMonedas(ByRef objMoneda As ComboBox)
   '--> Carga los datos de Monedas
   On Error GoTo ErrorLectura
   Dim SqlDatos()

   Let Screen.MousePointer = vbHourglass

   Call objMoneda.Clear

   Envia = Array()
   AddParam Envia, "PCS"
   If Not Bac_Sql_Execute("SP_LEER_MONEDAS_SISTEMA", Envia) Then
      GoTo ErrorLectura
   End If
   Do While Bac_SQL_Fetch(SqlDatos)
      If SqlDatos(3) = "USD" Or SqlDatos(3) = "CLP" Then
         If objMoneda.Name = "CMBMoneda" Then
            Call objMoneda.AddItem(UCase(SqlDatos(3)) & Space(100) & UCase(Trim(SqlDatos(2))))
         Else
            Call objMoneda.AddItem(UCase(SqlDatos(2)) & Space(100) & UCase(Trim(SqlDatos(3))))
         End If
         Let objMoneda.ItemData(objMoneda.NewIndex) = Val(SqlDatos(1))
      End If
   Loop

   If objMoneda.ListCount > 0 Then
      Let objMoneda.ListIndex = 0
   End If

   Let Screen.MousePointer = vbDefault
   On Error GoTo 0
Exit Function
ErrorLectura:
   Let Screen.MousePointer = vbDefault
   Call MsgBox("Error Lectura." & vbCrLf & vbCrLf & "Se ha producido un error al tratar de leer las monedas.", vbExclamation, App.Title)
End Function

Private Sub Func_Limpiar()

   '--> Limpia los objetos de ingreso de información.
   Let LBLFechaAnticipo.Caption = Format(gsBAC_Fecp, "dd/mm/yyyy")
   Let LBLFechaAnticipo.Tag = LBLFechaAnticipo.Caption

   Let LblNumeroOperacion.Caption = ""
   Let LblNumeroOperacion.Tag = Val(LblNumeroOperacion.Caption)

   Let LBLMonMTM.Caption = ""
   Let LBLMonMTM.Tag = Val(LBLMonMTM.Caption)

   Let LBLMTM.Caption = ""
   Let LBLMTM.Tag = Val(LBLMTM.Caption)

   Let TXTValorAnticipo.Text = 0:                  Let cmbMoneda.ListIndex = -1
   Let TXTValorParidad.Text = 0:                   Let LBLParMonValParidad.Caption = ""
   Let TXT_AnticipoTransf.Text = 0:                Let LBLMonAnticipoTransf.Caption = "CLP"
   Let TXTResultadoVta.Text = 0:                   Let LBLMonResultadoVta.Caption = "CLP"
   Let TXTResultadoTrading.Text = 0:               Let LBLMonResultadoTrading.Caption = "CLP"
End Sub

Private Sub CHKTipoAnticipo_Click()
   '--> Check de Anticipo Total o Parcial
   
   Let lblMensaje.Caption = "NO DISPONIBLE EN ANTICIPO TOTAL"
   Let lblMensaje.WordWrap = True
   Let lblMensaje.Height = 3500

   If CHKTipoAnticipo.Value = 1 Then
      MiTab.TabVisible(2) = False   'CASS
      Let GRID_SALDO.Visible = False
      Let FRAValNominal.Visible = False
      Let TXTProcNominal.Text = 0#
      Let TXTProcNominal.Text = 100
      Let CHKTipoAnticipo.Value = 1
   Else
      MiTab.TabVisible(2) = True    'CASS
      Let GRID_SALDO.Visible = True
      Let FRAValNominal.Visible = True
   End If

   Call FuncAplicarPorcentaje
End Sub



Private Sub cmbMoneda_Click()
   
   Dim nValAnticipo     As Double
   Dim nNewValAnticipo  As Double
   Dim nValAntiTrans    As Double
   Dim nResVta          As Double
   Dim nResTra          As Double
   Dim nDecimales       As Integer

   If cmbMoneda.ListIndex >= 0 Then
      
      If cmbMoneda.ItemData(cmbMoneda.ListIndex) = 999 Then
         Let LBLParMonValParidad.Caption = "CLP"
         Let LBLMonAnticipoTransf.Caption = "CLP"
         Let TXTValorParidad.Text = 1
         Let TXTValorParidad.Enabled = False
         
         If cmbMoneda.Tag <> cmbMoneda.ItemData(cmbMoneda.ListIndex) Then
              Let TXTAnticipoOtraMda.Text = "Eq.USD"                         'PRD-XXXX
              Let TXTValorAnticipoOtraMda.CantidadDecimales = 4              'PRD-XXXX
              Let TXTValorAnticipoOtraMda.Text = TXTValorAnticipoTmp.Text    'PRD-XXXX
              
              Let nNewValAnticipo = TXTValorAnticipoTmp.Text
              Let TXTValorAnticipoTmp.CantidadDecimales = 0
              Let TXTValorAnticipoTmp.Text = FuncTransformaCLP(nNewValAnticipo)  'CASS
         End If
      End If

      If cmbMoneda.ItemData(cmbMoneda.ListIndex) = 13 Then
         Let TXTAnticipoOtraMda.Text = "Eq.CLP"                         'PRD-XXXX
         Let TXTValorAnticipoOtraMda.CantidadDecimales = 0              'PRD-XXXX
         Let TXTValorAnticipoOtraMda.Text = TXTValorAnticipoTmp.Text    'PRD-XXXX
         
         Let LBLParMonValParidad.Caption = "USD"
         Let LBLMonAnticipoTransf.Caption = "CLP" 'CASS
         Let TXTValorParidad.Text = 1
         Let TXTValorParidad.Enabled = False
         If cmbMoneda.Tag <> cmbMoneda.ItemData(cmbMoneda.ListIndex) Then
             nNewValAnticipo = TXTValorAnticipoTmp.Text
             Let TXTValorAnticipoTmp.CantidadDecimales = 4
             Let TXTValorAnticipoTmp.Text = FuncTransformaUSD(nNewValAnticipo)  'CASS
         End If
      End If

      Let nDecimales = 0
      
      If cmbMoneda.ItemData(cmbMoneda.ListIndex) <> 999 Then
         Let nDecimales = 4
      End If
      
      If CMBMonPago.ListIndex >= 0 Then
         Let CMBMonPago.ListIndex = cmbMoneda.ListIndex
      End If

     ' Let nNewValAnticipo = TXTValorAnticipoTmp.Text:   Let TXTValorAnticipoTmp.CantidadDecimales = nDecimales:     Let TXTValorAnticipoTmp.Text = nNewValAnticipo
      
      Let nValAnticipo = TXTValorAnticipo.Text:    Let TXTValorAnticipo.CantidadDecimales = nDecimales:     Let TXTValorAnticipo.Text = nValAnticipo
      'Let TXT_AnticipoTransf.CantidadDecimales = 0
      Let nValAntiTrans = TXT_AnticipoTransf.Text: Let TXT_AnticipoTransf.Text = nValAntiTrans
      

     ' Let nResVta = TXTResultadoVta.Text:          Let TXTResultadoVta.CantidadDecimales = 0:      Let TXTResultadoVta.Text = nResVta
     ' Let nResTra = TXTResultadoTrading.Text:      Let TXTResultadoTrading.CantidadDecimales = 0:  Let TXTResultadoTrading.Text = nResTra

      Let TXTValorParidad.Text = RetornaValMoneda(cmbMoneda.ItemData(cmbMoneda.ListIndex))
      
      Call FuncCalculosResultado
      
      If cmbMoneda.ItemData(cmbMoneda.ListIndex) <> CDbl(cmbMoneda.Tag) Then
            cmbMoneda.Tag = cmbMoneda.ItemData(cmbMoneda.ListIndex)
      End If
      
     
   End If

End Sub

Private Function RetornaValMoneda(ByVal mncodmon As Integer) As Double
   Dim SqlDatos()

   Let RetornaValMoneda = 1#

   If mncodmon = 999 Then
      Exit Function
   End If
   
   Envia = Array()
   AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
   If Not Bac_Sql_Execute("BacSwapSuda.dbo.SP_LEE_VALORES_MONEDA_TCRC", Envia) Then
      Exit Function
   End If
   Do While Bac_SQL_Fetch(SqlDatos())
      If Val(SqlDatos(1)) = mncodmon Then
         Let RetornaValMoneda = CDbl(SqlDatos(2))
         Exit Do
      End If
   Loop

End Function


Private Sub CMBMonPago_Click()
   '--> Carga valores para objeto de Medios de pago
   Call LoadMediosPago(cmbFPago, CMBMonPago.ItemData(CMBMonPago.ListIndex))
End Sub

Private Sub Form_Activate()
   Let LblNumeroOperacion.Caption = GlbNumeroAnticipo
   Let LblNumeroOperacion.Tag = GlbNumeroAnticipo
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    'If KeyAscii = vbKeyReturn Then
    '    Call SendKeys("{TAB}")
    'End If
End Sub

Private Sub Form_Load()
   Let Me.Icon = BACSwap.Icon

   '--> Setea las Grillas al Inicio, Independiente ue no se ocupen
   Call FuncSettingGrid(GRID_CARTERA)  '--> Grilla con datos del Cartera vigente para la Op.
   Call FuncSettingGrid(GRID_ANTICIPO) '--> Grilla con datos del Anticipo.
   Call FuncSettingGrid(GRID_SALDO)    '--> Grilla con datos del Saldo del Anticipo.
   Call FuncSettingGrid(GRID_ESPEJO)   '--> Grilla con datos del Saldo del Anticipo.

   '--> Limpia Objetos
   Call Func_Limpiar

   '--> Carga valores para objeto con datos de la Modalidad de Pago
   Call LoadModalidadPago(cmbModalidad)

   '--> Carga valores para objeto de Monedas
   Call LoadMonedas(cmbMoneda)
   Call LoadMonedas(CMBMonPago):    Let CMBMonPago.Enabled = False

   '--> Carga todas las Grillas al Inicio, deberia variar la información una vez que se manipule el anticipo
   Call FuncLoadOperacion(GRID_CARTERA, nNumeroOperacion)
   Call FuncLoadOperacion(GRID_ANTICIPO, nNumeroOperacion)
   Call FuncLoadOperacion(GRID_SALDO, nNumeroOperacion)
   
   Let PorMTM.Caption = "0 %"
   Let PorMtoMTM.Caption = 0
   
   
   If nTicketIntraMesa = True Then
      Call FuncLoadOperacion(GRID_ESPEJO, CDbl(LBL_OpEspejo.Caption))
   End If

   Let MiTab.Tab = 0
   Let MiTab.TabEnabled(0) = True
   Let MiTab.TabEnabled(1) = True 'CASS
   Let MiTab.TabEnabled(2) = True 'CASS
   Let MiTab.TabEnabled(3) = False 'CASS


   ' --> Carga Flujos de la Operacion en Cartera
   ' Call Func_Load_data(I_Grid)
   ' Call Func_Load_data(D_Grid)

   ' --> Clase de Anticipos (Valorizaciones)
   ' Call oAnticipo.Load_Datos_Operacion(nNumeroOperacion)
   ' Call oAnticipo.CalculoInteresBono("I", I_Grid)
   ' Call oAnticipo.CalculoInteresBono("D", D_Grid)

   '--> Define Pago Parcial
   Let CHKTipoAnticipo.Value = 0
   
   If ValidaCargaAnticipo = False Then
      Let Toolbar1.Buttons(2).Enabled = False
      Let Toolbar1.Buttons(3).Enabled = False
      Let Toolbar1.Buttons(4).Enabled = False
      Let Toolbar1.Buttons(5).Enabled = False
      Let Toolbar1.Buttons(6).Enabled = False
      Let Toolbar1.Buttons(7).Enabled = True

      Let FRAMarkToMarket.Enabled = False
      Let FRA_ANTICIPO_TOTAL.Enabled = False
      Let Frame1.Enabled = False
      Let MiTab.Enabled = False
      Let FRAModalidad.Enabled = False
   End If
   Let LbTCM.Caption = "Valor USD " & Format(RetornaValMoneda(13), "###.####")  'PRD-XXXX
   Let Me.Caption = "Versión Modificada Pantalla Anticipo"                          'PRD-XXXX No homologar
End Sub

Private Function Func_Load_data(ByRef MiGrilla As MSFlexGrid)
   Dim iContador     As Long
   Dim iMontoAmort   As Double
   Dim SqlDatos()
   
   Let MiGrilla.Rows = 1
   Let MiGrilla.Cols = 27

   Let MiGrilla.TextMatrix(0, 0) = "N°FLUJO":                        Let MiGrilla.ColWidth(0) = 750
   Let MiGrilla.TextMatrix(0, 1) = "VENCIMIENTO":                    Let MiGrilla.ColWidth(1) = 1200
   Let MiGrilla.TextMatrix(0, 2) = "AMORTIZACION":                   Let MiGrilla.ColWidth(2) = 1500
   Let MiGrilla.TextMatrix(0, 3) = "TASA + SPREAD":                  Let MiGrilla.ColWidth(3) = 1500
   Let MiGrilla.TextMatrix(0, 4) = "INTERES":                        Let MiGrilla.ColWidth(4) = 1500
   Let MiGrilla.TextMatrix(0, 5) = "TOTAL":                          Let MiGrilla.ColWidth(5) = 1500
   Let MiGrilla.TextMatrix(0, 6) = "MODALIDAD":                      Let MiGrilla.ColWidth(6) = 0
   Let MiGrilla.TextMatrix(0, 7) = "Documento Pago":                 Let MiGrilla.ColWidth(7) = 0
   Let MiGrilla.TextMatrix(0, 8) = "Saldo amortizar":                Let MiGrilla.ColWidth(8) = 0
   Let MiGrilla.TextMatrix(0, 9) = "Fecha Vcto. Anterior":           Let MiGrilla.ColWidth(9) = 0
   Let MiGrilla.TextMatrix(0, 10) = "Monto en moneda seleccionada":  Let MiGrilla.ColWidth(10) = 0
   Let MiGrilla.TextMatrix(0, 11) = "Monto en USD que paga./recib.": Let MiGrilla.ColWidth(11) = 0
   Let MiGrilla.TextMatrix(0, 12) = "Monto en $ que paga./recib.":   Let MiGrilla.ColWidth(12) = 0
   Let MiGrilla.TextMatrix(0, 13) = "Ubicacion del Dato ":           Let MiGrilla.ColWidth(13) = 0
   Let MiGrilla.TextMatrix(0, 14) = "LIQUIDACION":                   Let MiGrilla.ColWidth(14) = 1200
   Let MiGrilla.TextMatrix(0, 15) = "Fecha Flujo Real":              Let MiGrilla.ColWidth(15) = 0
   Let MiGrilla.TextMatrix(0, 16) = "FECHA FIXING":                  Let MiGrilla.ColWidth(16) = 0
   Let MiGrilla.TextMatrix(0, 17) = "SALDO INSOLUTO":                Let MiGrilla.ColWidth(17) = 1500
   Let MiGrilla.TextMatrix(0, 18) = "% AMORTIZA":                    Let MiGrilla.ColWidth(18) = 1500
   Let MiGrilla.TextMatrix(0, 19) = "INT.NOC.":                      Let MiGrilla.ColWidth(19) = 0
   Let MiGrilla.TextMatrix(0, 20) = "FECHA VALUTA":                  Let MiGrilla.ColWidth(20) = 0
   Let MiGrilla.TextMatrix(0, 21) = "FLUJO ADICIONAL":               Let MiGrilla.ColWidth(21) = 0
   Let MiGrilla.TextMatrix(0, 22) = "FXRATE":                        Let MiGrilla.ColWidth(22) = 0
   Let MiGrilla.TextMatrix(0, 23) = "TASA":                          Let MiGrilla.ColWidth(23) = 0
   Let MiGrilla.TextMatrix(0, 24) = "SPREAD":                        Let MiGrilla.ColWidth(24) = 0
   Let MiGrilla.TextMatrix(0, 25) = "Valor Razonable":               Let MiGrilla.ColWidth(25) = 2500
   Let MiGrilla.TextMatrix(0, 26) = "AVR":                           Let MiGrilla.ColWidth(26) = 2500
   
   Envia = Array()
   AddParam Envia, CDbl(nNumeroOperacion)
   AddParam Envia, CDbl(IIf(UCase(MiGrilla.Name) = "I_GRID", 1, 2))
   If Not Bac_Sql_Execute("SP_LEE_OPERACIONES_SWAP_ANTICIPO", Envia) Then
      Exit Function
   End If
   Let MiGrilla.Rows = 1
   Do While Bac_SQL_Fetch(SqlDatos())
      Let iContador = iContador + 1
      Let iMontoAmort = iMontoAmort - CDbl(SqlDatos(26))

      Let MiGrilla.Rows = MiGrilla.Rows + 1
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 0) = Format(iContador, "00")
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 1) = Format(SqlDatos(25), "DD/MM/YYYY")
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 2) = Format(SqlDatos(26), TipoFormato(Trim(SqlDatos(4))))
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 3) = Format(SqlDatos(27), TipoFormato("USD"))
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 4) = Format(SqlDatos(28), TipoFormato("USD"))
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 5) = Format(SqlDatos(29), TipoFormato("USD"))
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 6) = ""
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 7) = ""
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 8) = Format(iMontoAmort, TipoFormato(Trim(SqlDatos(4))))
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 9) = Format(SqlDatos(30), "DD/MM/YYYY")
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 10) = CDbl(SqlDatos(32))
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 11) = CDbl(SqlDatos(33))
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 12) = CDbl(SqlDatos(34))
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 13) = ""
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 14) = Format(SqlDatos(31), "DD/MM/YYYY")
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 15) = Format(SqlDatos(25), "DD/MM/YYYY")
      Let MiGrilla.TextMatrix(MiGrilla.Rows - 1, 16) = Format(SqlDatos(35), "DD/MM/YYYY")
   Loop

End Function


Private Function SettingLista(ByRef objCombo As ComboBox, ByVal nValor As Variant)
   '--> Busca el Items que debe quedar seleccionado
   Dim nContador  As Long
   
   For nContador = 0 To objCombo.ListCount - 1
      If objCombo.ItemData(nContador) = Val(nValor) Then
         Let objCombo.ListIndex = nContador
         Exit For
      End If
   Next nContador

End Function

Private Function ValidaCargaAnticipo() As Boolean
   Dim SqlDatos()
   
   Let ValidaCargaAnticipo = False
   
   If nTicketIntraMesa = True Then
      Let ValidaCargaAnticipo = True
   End If

   Envia = Array()
   
   AddParam Envia, "C"                                      '--> Cabecera
   AddParam Envia, CDbl(nNumeroOperacion)                   '--> N° Operacion
   AddParam Envia, IIf(nTicketIntraMesa = True, "S", "N")   '--> Define si viene de Ticket Intra Mesa o NO
   AddParam Envia, CDbl(1)                                  '--> Validación
   
   If Not Bac_Sql_Execute("BacSwapSuda.dbo.SP_LOAD_DATOS_CARTERA", Envia) Then
      Screen.MousePointer = vbDefault
      Exit Function
   End If
   
   If Bac_SQL_Fetch(SqlDatos) Then
      If SqlDatos(1) < 0 Then
         Call MsgBox(SqlDatos(2), vbExclamation, App.Title)
         Exit Function
      End If
   End If
   
   Let ValidaCargaAnticipo = True
   
End Function

Private Function FuncLoadOperacion(ByRef MiObjeto As MSFlexGrid, ByVal nNumeroOperacion As Long)
   '--> Carga las diferentes grilla con la información de cartera
   Dim SqlDatos()
   Dim nMontoAVR  As Double
   
   Screen.MousePointer = vbHourglass
   
   If MiObjeto.Name = "GRID_CARTERA" Then
      Envia = Array()
      AddParam Envia, "C"                                      '--> Cabecera
      AddParam Envia, CDbl(nNumeroOperacion)                   '--> N° Operacion
      AddParam Envia, IIf(nTicketIntraMesa = True, "S", "N")   '--> Define si viene de Ticket Intra Mesa o NO
      If Not Bac_Sql_Execute("BacSwapSuda.dbo.SP_LOAD_DATOS_CARTERA", Envia) Then
         Screen.MousePointer = vbDefault
         Call MsgBox("Se ha originado un error en la lectura de la información.", vbExclamation, App.Title)
         Exit Function
      End If
      If Bac_SQL_Fetch(SqlDatos()) Then
         Let LBLFechaAnticipo.Caption = SqlDatos(1)
         Let LblNumeroOperacion.Caption = SqlDatos(2)
         Let cmbModalidad.Text = SqlDatos(3)
         Let LBLMonMTM.Caption = SqlDatos(4)
         Let LBLMTM.Caption = Format(SqlDatos(5), TipoFormato(Trim(SqlDatos(4))))
         Let MontoMTM = SqlDatos(5)
         Call SettingLista(cmbMoneda, SqlDatos(6))
         
         If nTicketIntraMesa = True Then
            LBL_OpEspejo.Caption = SqlDatos(8)
         End If
         
         Let TXTValorAnticipo.Text = SqlDatos(5)
         Let TXTValorAnticipoTmp.Text = SqlDatos(5)
         Let TXTValorAnticipoTmp.Tag = TXTValorAnticipoTmp.Text  'PRD-XXXX OldValue
         Let TXT_AnticipoTransf.Text = SqlDatos(5)


         'PROD XXXX
         If cmbMoneda.ItemData(cmbMoneda.ListIndex) = 13 Then
           Let TXTAnticipoOtraMda.Text = "Eq.CLP"
           Let TXTValorAnticipoOtraMda.CantidadDecimales = 0
           Let TXTValorAnticipoOtraMda.Text = FuncTransformaCLP(TXTValorAnticipoTmp.Text)
         Else
           Let TXTAnticipoOtraMda.Text = "Eq.USD"
           Let TXTValorAnticipoOtraMda.CantidadDecimales = 4
           Let TXTValorAnticipoOtraMda.Text = FuncTransformaUSD(TXTValorAnticipoTmp.Text)
         End If
         
         'PROD XXXX


      End If
   End If
   
   
   Let MiObjeto.Redraw = False
   Let MiObjeto.Rows = 15

   Envia = Array()
   AddParam Envia, "P"                                      '--> Cabecera
   AddParam Envia, CDbl(nNumeroOperacion)                   '--> N° Operacion
   AddParam Envia, IIf(nTicketIntraMesa = True, "S", "N")   '--> Define si viene de Ticket Intra Mesa o NO
   
   If Not Bac_Sql_Execute("BacSwapSuda.dbo.SP_LOAD_DATOS_CARTERA", Envia) Then
      Let MiObjeto.Redraw = True
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha originado un error en la lectura de la información.", vbExclamation, App.Title)
      Exit Function
   End If
   
   If Bac_SQL_Fetch(SqlDatos()) Then
      Let MiObjeto.TextMatrix(0, 1) = ""
      Let MiObjeto.TextMatrix(1, 1) = SqlDatos(1)                                                 '--> "Moneda"
      Let MiObjeto.TextMatrix(2, 1) = Format(CDbl(SqlDatos(2)), TipoFormato(Trim(SqlDatos(1))))   '--> "Monto"
      Let MiObjeto.TextMatrix(3, 1) = SqlDatos(3)                                                 '--> "Frec. Pago"
      Let MiObjeto.TextMatrix(4, 1) = SqlDatos(4)                                                 '--> "Frec. Capial"
      Let MiObjeto.TextMatrix(5, 1) = SqlDatos(5)                                                 '--> "Indicador"
      Let MiObjeto.TextMatrix(6, 1) = Format(SqlDatos(6), TipoFormato("UFR")) '--> "Val. Indice"
      Let MiObjeto.TextMatrix(7, 1) = Format(SqlDatos(7), TipoFormato("UFR")) '--> "Spread"
      Let MiObjeto.TextMatrix(8, 1) = SqlDatos(8)                                                 '--> "Coneto Dias"
      Let MiObjeto.TextMatrix(9, 1) = SqlDatos(9)                                                 '--> "Moneda Pago"
      Let MiObjeto.TextMatrix(10, 1) = SqlDatos(10)                                                '--> "Medio  Pago"
      Let MiObjeto.TextMatrix(11, 1) = SqlDatos(11)                                                '--> "Fecha Inicio"
      Let MiObjeto.TextMatrix(12, 1) = SqlDatos(12)                                                '--> "Fecha Termino"
      Let MiObjeto.TextMatrix(13, 1) = Format(SqlDatos(13), TipoFormato("CLP"))                    '--> "Valor MTM"
      Let nMontoAVR = SqlDatos(13)
      '--> Selecciona el Capital Activo
      Let nNominalActivo = SqlDatos(2)
   End If
   
   Envia = Array()
   AddParam Envia, "R"                                      '--> Cabecera
   AddParam Envia, CDbl(nNumeroOperacion)                   '--> N° Operacion
   AddParam Envia, IIf(nTicketIntraMesa = True, "S", "N")   '--> Define si viene de Ticket Intra Mesa o NO
   
   If Not Bac_Sql_Execute("BacSwapSuda.dbo.SP_LOAD_DATOS_CARTERA", Envia) Then
      Let GRID_CARTERA.Redraw = True
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha originado un error en la lectura de la información.", vbExclamation, App.Title)
      Exit Function
   End If
   
   If Bac_SQL_Fetch(SqlDatos()) Then
      Let MiObjeto.TextMatrix(0, 2) = ""
      Let MiObjeto.TextMatrix(1, 2) = SqlDatos(1)                                                '--> "Moneda"
      Let MiObjeto.TextMatrix(2, 2) = Format(CDbl(SqlDatos(2)), TipoFormato(Trim(SqlDatos(1))))  '--> "Monto"
      Let MiObjeto.TextMatrix(3, 2) = SqlDatos(3)                                                '--> "Frec. Pago"
      Let MiObjeto.TextMatrix(4, 2) = SqlDatos(4)                                                '--> "Frec. Capial"
      Let MiObjeto.TextMatrix(5, 2) = SqlDatos(5)                                                '--> "Indicador"
      Let MiObjeto.TextMatrix(6, 2) = Format(SqlDatos(6), TipoFormato("UFR"))        '--> "Val. Indice"
      Let MiObjeto.TextMatrix(7, 2) = Format(SqlDatos(7), TipoFormato("UFR")) '--> "Spread"
      Let MiObjeto.TextMatrix(8, 2) = SqlDatos(8)                                                '--> "Coneto Dias"
      Let MiObjeto.TextMatrix(9, 2) = SqlDatos(9)                                                '--> "Moneda Pago"
      Let MiObjeto.TextMatrix(10, 2) = SqlDatos(10)                                               '--> "Medio  Pago"
      Let MiObjeto.TextMatrix(11, 2) = SqlDatos(11)                                               '--> "Fecha Inicio"
      Let MiObjeto.TextMatrix(12, 2) = SqlDatos(12)                                               '--> "Fecha Termino"
      Let MiObjeto.TextMatrix(13, 2) = Format(SqlDatos(13), TipoFormato("CLP"))                   '--> "Valor MTM"

      Let nMontoAVR = nMontoAVR - SqlDatos(13)
      Let MiObjeto.TextMatrix(14, 2) = Format(nMontoAVR, TipoFormato("CLP"))

      '--> Selecciona el Capital Activo
      Let nNominalPasivo = SqlDatos(2)
   End If
   
   Let MiObjeto.Redraw = True
   Let Screen.MousePointer = vbDefault

End Function

Private Sub Form_Unload(Cancel As Integer)
   Let nTicketIntraMesa = False
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call GrabarAnticipo
      Case 5
         Call Imprimir_Informe(crptToPrinter)
      Case 6
         Call Imprimir_Informe(crptToWindow)
      Case 8
         Call Unload(Me)
   End Select
End Sub

Private Function Imprimir_Informe(Destino As DestinationConstants)
   On Error GoTo ErrorImpresion

   If CMBMonPago.ListIndex >= 0 Then
      CMBMonPago.Tag = CMBMonPago.ItemData(CMBMonPago.ListIndex)
   Else
      CMBMonPago.Tag = 0
   End If
   If cmbFPago.ListIndex >= 0 Then
      cmbFPago.Tag = cmbFPago.ItemData(cmbFPago.ListIndex)
   Else
      cmbFPago.Tag = 0
   End If

   BACSwap.Crystal.ReportFileName = gsRPT_Path & "INFORME_NEW_UNWIND.rpt"
   
   If CHKTipoAnticipo.Value = 1 Then
      BACSwap.Crystal.StoredProcParam(0) = CDbl(LblNumeroOperacion.Caption)
      BACSwap.Crystal.StoredProcParam(1) = CDbl(100)
      BACSwap.Crystal.StoredProcParam(2) = CDbl(TXTValorAnticipo.Text)
      BACSwap.Crystal.StoredProcParam(3) = CDbl(TXT_AnticipoTransf.Text)
      BACSwap.Crystal.StoredProcParam(4) = CDbl(TXTResultadoVta.Text)
      BACSwap.Crystal.StoredProcParam(5) = CDbl(TXTResultadoTrading.Text)
      BACSwap.Crystal.StoredProcParam(6) = CDbl(CMBMonPago.Tag)
      BACSwap.Crystal.StoredProcParam(7) = CDbl(cmbFPago.Tag)
      BACSwap.Crystal.StoredProcParam(8) = gsBAC_User
      BACSwap.Crystal.StoredProcParam(9) = CDbl(TXTValorParidad.Text)
      BACSwap.Crystal.StoredProcParam(10) = Mid(cmbMoneda.Text, 1, 3)
   Else
      BACSwap.Crystal.StoredProcParam(0) = CDbl(LblNumeroOperacion.Caption)
      BACSwap.Crystal.StoredProcParam(1) = CDbl(TXTProcNominal.Text)
      BACSwap.Crystal.StoredProcParam(2) = CDbl(TXTValorAnticipo.Text)
      BACSwap.Crystal.StoredProcParam(3) = CDbl(TXT_AnticipoTransf.Text)
      BACSwap.Crystal.StoredProcParam(4) = CDbl(TXTResultadoVta.Text)
      BACSwap.Crystal.StoredProcParam(5) = CDbl(TXTResultadoTrading.Text)
      BACSwap.Crystal.StoredProcParam(6) = CDbl(CMBMonPago.Tag)
      BACSwap.Crystal.StoredProcParam(7) = CDbl(cmbFPago.Tag)
      BACSwap.Crystal.StoredProcParam(8) = gsBAC_User
      BACSwap.Crystal.StoredProcParam(9) = CDbl(TXTValorParidad.Text)
      BACSwap.Crystal.StoredProcParam(10) = Mid(cmbMoneda.Text, 1, 3)
   End If
   
   BACSwap.Crystal.WindowTitle = "Informe de Pre-Anticipo"
   BACSwap.Crystal.Destination = Destino
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1

Exit Function
ErrorImpresion:
   Call MsgBox("Error de Impresión." & vbCrLf & err.Description, vbExclamation, App.Title)
End Function

Private Function FuncNominalPorcentual(ByVal nPorcentaje As Double) As Double
   Dim sw As Boolean

   sw = False
    
   If CDbl(nPorcentaje) = 100 And CHKTipoAnticipo.Value = 0 Then
      Call MsgBox(" ¡ Esta anticipando el 100% del valor nominal, se marcara como Anticipo Total. !", vbExclamation, App.Title)
      Let CHKTipoAnticipo.Value = 1
      Let TXTProcNominal.Text = 100
      sw = True
   End If

   If nPorcentaje < 0 Then
      Let nPorcentaje = 0
      Let TXTProcNominal.Text = 0
      Call MsgBox("No se permite un porcentakje menor a Cero para Anticipo.", vbExclamation, App.Title)
   End If
   
   If nPorcentaje > 100# And Not sw Then
      Let nPorcentaje = 100
      Let CHKTipoAnticipo.Value = 1
      Let TXTProcNominal.Text = 100
      Call MsgBox("No se permite un porcentaje mayor al 100% para Anticipo.", vbExclamation, App.Title)
   End If

   Let FuncNominalPorcentual = (nNominalActivo * nPorcentaje) / 100

End Function


Private Function FuncNuevoPorcentual(ByVal nNominalNuevo As Double) As Double
   Dim sw As Boolean
   Dim nPorcentaje As Double
   
   sw = False

   Let nPorcentaje = Abs((nNominalNuevo * 100) / nNominalActivo)
  
   If CDbl(nPorcentaje) = 100 And CHKTipoAnticipo.Value = 0 Then
      Call MsgBox(" ¡ Esta anticipando el 100% del valor nominal, se marcara como Anticipo Total. !", vbExclamation, App.Title)
      Let CHKTipoAnticipo.Value = 1
      Let TXTProcNominal.Text = 100
      sw = True
   End If

   If nPorcentaje < 0 Then
      Let nPorcentaje = 0
      Let TXTProcNominal.Text = 0
      Call MsgBox("No se permite un porcentakje menor a Cero para Anticipo.", vbExclamation, App.Title)
   End If
   
   If nPorcentaje > 100# And Not sw Then
      Let nPorcentaje = 100
      Let CHKTipoAnticipo.Value = 1
      Let TXTProcNominal.Text = 100
      Call MsgBox("No se permite un porcentaje mayor al 100% para Anticipo.", vbExclamation, App.Title)
   End If

   Let FuncNuevoPorcentual = Abs((nNominalNuevo * 100) / nNominalActivo)

End Function


'Private Sub TXTNominal_KeyDown(KeyCode As Integer, Shift As Integer)
'   If KeyCode = vbKeyReturn Then
'
'      Let TXTProcNominal.Text = FuncNuevoPorcentual(CDbl(TXTNominal.Text))
'      Let TXTProcNominal.Tag = TXTProcNominal.Text
'
'      Call FuncAplicarPorcentaje
'
'      Let MiTab.Tab = 0
'      Let MiTab.TabEnabled(3) = False
'
'      If TXTProcNominal.Text > 0# Then
'         Let MiTab.TabEnabled(0) = True
'         Let MiTab.TabEnabled(1) = True
'         Let MiTab.TabEnabled(2) = True
'         Let MiTab.TabEnabled(3) = nTicketIntraMesa
'      End If
'
'      If TXTProcNominal.Text = 100 Then
'         Let MiTab.TabEnabled(0) = True
'         Let MiTab.TabEnabled(1) = True
'         Let MiTab.TabEnabled(2) = False
'         Let MiTab.TabEnabled(3) = nTicketIntraMesa
'      End If
'
'   End If
'End Sub

Private Sub TXTProcNominal_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then

      Let TXTNominal.Text = FuncNominalPorcentual(CDbl(TXTProcNominal.Text))
      Let TXTProcNominal.Tag = TXTProcNominal.Text

      Call FuncAplicarPorcentaje

      Let MiTab.Tab = 0
      Let MiTab.TabEnabled(3) = False

      If TXTProcNominal.Text > 0# Then
         Let MiTab.TabEnabled(0) = True
         Let MiTab.TabEnabled(1) = True
         Let MiTab.TabEnabled(2) = True
         Let MiTab.TabEnabled(3) = nTicketIntraMesa
      End If
      
      If TXTProcNominal.Text = 100 Then
         Let MiTab.TabEnabled(0) = True
         Let MiTab.TabEnabled(1) = True
         Let MiTab.TabEnabled(2) = False
         Let MiTab.TabEnabled(3) = nTicketIntraMesa
      End If
      
      Call TXTValorAnticipoTmp.SetFocus
   End If

End Sub

Private Sub TXTProcNominal_KeyPress(KeyAscii As Integer)
'    If KeyAscii% = vbKeyReturn Then
'            KeyAscii% = 0
'            SendKeys "{TAB}"
'    End If
End Sub

Private Sub TXTProcNominal_LostFocus()
    
    If TXTProcNominal.Tag <> TXTProcNominal.Text Then
        
        If Not CDbl(TXTProcNominal.Text) = 0 Then
            
            Call TXTProcNominal_KeyDown(vbKeyReturn, 0)
        
        End If
    
    End If

End Sub

Private Function FuncAplicarPorcentaje()
   
   Dim nPorcentaje      As Double
   Dim nSaldoPorc       As Double
   Dim nNominalActivo   As Double
   Dim nNominalPasivo   As Double
   Dim MTMActivo        As Double
   Dim MTMPasivo        As Double
   Dim MonedaActiva     As String
   Dim MonedaPasiva     As String
   Dim nMontoAVR        As Double
   
   Let nPorcentaje = TXTProcNominal.Text
   Let nSaldoPorc = (100# - nPorcentaje)

   If CHKTipoAnticipo.Value = 1 Then
      Let nPorcentaje = 100#
      Let nSaldoPorc = 0#
   End If

   Let MonedaActiva = GRID_CARTERA.TextMatrix(1, 1)      '--> Moneda  Activa
   Let MonedaPasiva = GRID_CARTERA.TextMatrix(1, 2)      '--> Moneda  Pasiva
   Let nNominalActivo = GRID_CARTERA.TextMatrix(2, 1)    '--> Nominal Activo
   Let nNominalPasivo = GRID_CARTERA.TextMatrix(2, 2)    '--> Nominal Pasivo
   Let MTMActivo = GRID_CARTERA.TextMatrix(13, 1)        '--> Nominal Activo
   Let MTMPasivo = GRID_CARTERA.TextMatrix(13, 2)        '--> Nominal Pasivo

   Let TXTNominal.Text = (nNominalActivo * nPorcentaje) / 100

   Let GRID_ANTICIPO.TextMatrix(2, 1) = Format((nNominalActivo * nPorcentaje) / 100, TipoFormato(MonedaActiva))
   Let GRID_ANTICIPO.TextMatrix(2, 2) = Format((nNominalPasivo * nPorcentaje) / 100, TipoFormato(MonedaPasiva))
   Let GRID_ANTICIPO.TextMatrix(13, 1) = Format((MTMActivo * nPorcentaje) / 100, TipoFormato("CLP"))
   Let GRID_ANTICIPO.TextMatrix(13, 2) = Format((MTMPasivo * nPorcentaje) / 100, TipoFormato("CLP"))

   Let nMontoAVR = Round((MTMActivo - MTMPasivo) * nPorcentaje / 100, 0)
   Let GRID_ANTICIPO.TextMatrix(14, 2) = Format(nMontoAVR, TipoFormato("CLP"))


   Let GRID_SALDO.TextMatrix(2, 1) = Format((nNominalActivo * nSaldoPorc) / 100, TipoFormato(MonedaActiva))
   Let GRID_SALDO.TextMatrix(2, 2) = Format((nNominalPasivo * nSaldoPorc) / 100, TipoFormato(MonedaPasiva))
   Let GRID_SALDO.TextMatrix(13, 1) = Format((MTMActivo * nSaldoPorc) / 100, TipoFormato("CLP"))
   Let GRID_SALDO.TextMatrix(13, 2) = Format((MTMPasivo * nSaldoPorc) / 100, TipoFormato("CLP"))

   Let nMontoAVR = Round((MTMActivo - MTMPasivo) * nSaldoPorc / 100, 0)
   Let GRID_SALDO.TextMatrix(14, 2) = Format(nMontoAVR, TipoFormato("CLP"))


   If nTicketIntraMesa = True Then
      Let MiTab.Tab = 3

      Let GRID_ESPEJO.TextMatrix(2, 1) = Format((nNominalPasivo * nPorcentaje) / 100, TipoFormato(MonedaActiva))
      Let GRID_ESPEJO.TextMatrix(2, 2) = Format((nNominalActivo * nPorcentaje) / 100, TipoFormato(MonedaPasiva))
      Let GRID_ESPEJO.TextMatrix(13, 1) = Format((MTMPasivo * nPorcentaje) / 100, TipoFormato("CLP"))
      Let GRID_ESPEJO.TextMatrix(13, 2) = Format((MTMActivo * nPorcentaje) / 100, TipoFormato("CLP"))

      Let nMontoAVR = ((MTMPasivo - MTMActivo) * nPorcentaje / 100)
      Let GRID_ESPEJO.TextMatrix(14, 2) = Format(nMontoAVR, TipoFormato("CLP"))
   End If


   Let TXTValorAnticipo.Text = Round(MontoMTM * (nPorcentaje / 100), 0)
   Let TXTValorAnticipoTmp.Text = Round(MontoMTM * (nPorcentaje / 100), 0) 'CASS
   

    Let TXT_AnticipoTransf.Text = TXTValorAnticipo.Text
    
    
    If cmbMoneda.ItemData(cmbMoneda.ListIndex) = 13 Then
        Let TXTValorAnticipoTmp.Text = FuncTransformaUSD(TXTValorAnticipo.Text)
    End If
   
    'PRD XXXX
    If cmbMoneda.ItemData(cmbMoneda.ListIndex) = 13 Then
       Let TXTAnticipoOtraMda.Text = "Eq.CLP"
       Let TXTValorAnticipoOtraMda.CantidadDecimales = 0
       Let TXTValorAnticipoOtraMda.Text = FuncTransformaCLP(TXTValorAnticipoTmp.Text)
    Else
       Let TXTAnticipoOtraMda.Text = "Eq.USD"
       Let TXTValorAnticipoOtraMda.CantidadDecimales = 4
       Let TXTValorAnticipoOtraMda.Text = FuncTransformaUSD(TXTValorAnticipoTmp.Text)
    End If
    'PRD XXXX
   
   Let PorMTM.Caption = CStr(nPorcentaje) & "%"
   Let PorMtoMTM.Caption = Format(Round(MontoMTM * (nPorcentaje / 100), 0), TipoFormato("CLP"))
   
   
   
   Call FuncCalculosResultado

End Function

Private Function FuncCalculosResultado()
Dim MTMAnticipo      As Double
Dim dblResVenta      As Double
Dim dblResTrading    As Double



   Let TXTResultadoVta.CantidadDecimales = 0
   Let TXTResultadoTrading.CantidadDecimales = 0

   If Len(GRID_ANTICIPO.TextMatrix(13, 1)) = 0 Or Len(GRID_ANTICIPO.TextMatrix(13, 2)) = 0 Then
      Let MTMAnticipo = 0
   Else
      Let MTMAnticipo = GRID_ANTICIPO.TextMatrix(13, 1) - GRID_ANTICIPO.TextMatrix(13, 2)
   End If

     Let dblResVenta = Round(TXTValorAnticipoTmp.Text * TXTValorParidad.Text, 0) - TXT_AnticipoTransf.Text
     Let dblResTrading = (TXT_AnticipoTransf.Text - PorMtoMTM.Caption)

  ' Let TXTResultadoVta.Text = (TXTValorAnticipo.Text - TXT_AnticipoTransf.Text) * TXTValorParidad.Text
  ' Let TXTResultadoTrading.Text = TXT_AnticipoTransf.Text - MTMAnticipo
   
   Let TXTResultadoVta.Text = dblResVenta
   Let TXTResultadoTrading.Text = dblResTrading
   
   
End Function

'CASS
Private Function FuncTransformaCLP(valor As Double)
   Dim Paridad   As Double
  
   Let Paridad = RetornaValMoneda(13)
 
   Let FuncTransformaCLP = Round(CDbl(valor) * CDbl(Paridad), 0)
      
End Function

'CASS
Private Function FuncTransformaUSD(valor As Double)
   Dim Paridad   As Double
  
   Let Paridad = RetornaValMoneda(13)  'PRD-XXXX debe seguir el nombre de la rutina
                 'RetornaValMoneda(CMBMoneda.ItemData(CMBMoneda.ListIndex))
                 
   Let FuncTransformaUSD = Round(CDbl(valor) / CDbl(Paridad), 4)
      
End Function


Private Sub TXTValorAnticipo_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call FuncCalculosResultado
   End If
End Sub

Private Sub TXTValorAnticipo_LostFocus()
   Call FuncCalculosResultado
End Sub

Private Sub TXT_AnticipoTransf_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call FuncCalculosResultado
      Call cmbFPago.SetFocus
   End If
End Sub

Private Sub TXT_AnticipoTransf_LostFocus()
   Call FuncCalculosResultado
End Sub


Private Function GrabarAnticipo()
   
   On Error GoTo ErrorAnticipo
   
   Dim xProcedimiento   As String
   
   Dim IniTransaction   As Boolean
   
   Let IniTransaction = False
   
   If MsgBox("¿ Esta seguro que desea Anticipar la Operación ?.", vbQuestion + vbYesNo, App.Title) = vbNo Then
      Exit Function
   End If
   
   If Validacion = False Then
      Exit Function
   End If
   
   Let xProcedimiento = "dbo.SP_GRABA_NEW_ANTICIPO"
   
   If nTicketIntraMesa = True Then
      Let xProcedimiento = "dbo.SP_GRABA_NEW_ANTICIPO_TICKET"
   End If
   
   If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
      Exit Function
   End If
   
   Let IniTransaction = True
   
   Envia = Array()
   AddParam Envia, nNumeroOperacion
   AddParam Envia, CDbl(TXTProcNominal.Text)
   AddParam Envia, CDbl(TXTValorAnticipoTmp.Text) '--> CDbl(TXTValorAnticipo.Text)
   AddParam Envia, CDbl(TXT_AnticipoTransf.Text)
   AddParam Envia, CDbl(TXTResultadoVta.Text)
   AddParam Envia, CDbl(TXTResultadoTrading.Text)
   AddParam Envia, Val(CMBMonPago.ItemData(CMBMonPago.ListIndex))
   AddParam Envia, Val(cmbFPago.ItemData(cmbFPago.ListIndex))
   AddParam Envia, Mid(cmbModalidad.List(cmbModalidad.ListIndex), 1, 1)
   AddParam Envia, Mid(gsBAC_User, 1, 15)
   
   If Not Bac_Sql_Execute(xProcedimiento, Envia) Then
      
      Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
      Let IniTransaction = False
      Call MsgBox("ha ocurrido un error en la grabación.", vbExclamation, App.Title)
      Exit Function
   
   End If
   
   If nTicketIntraMesa = True Then
      
      Envia = Array()
      AddParam Envia, Val(LBL_OpEspejo.Caption)
      AddParam Envia, CDbl(TXTProcNominal.Text)
      AddParam Envia, CDbl(TXTValorAnticipoTmp.Text) '--> CDbl(TXTValorAnticipo.Text)
      AddParam Envia, CDbl(TXT_AnticipoTransf.Text)
      AddParam Envia, CDbl(TXTResultadoVta.Text)
      AddParam Envia, CDbl(TXTResultadoTrading.Text)
      AddParam Envia, Val(CMBMonPago.ItemData(CMBMonPago.ListIndex))
      AddParam Envia, Val(cmbFPago.ItemData(cmbFPago.ListIndex))
      AddParam Envia, Mid(cmbModalidad.List(cmbModalidad.ListIndex), 1, 1)
      AddParam Envia, Mid(gsBAC_User, 1, 15)
      
      If Not Bac_Sql_Execute(xProcedimiento, Envia) Then
         Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
         Let IniTransaction = False
         Call MsgBox("ha ocurrido un error en la grabación. [Op. Espejo].", vbExclamation, App.Title)
         Exit Function
      End If
   
   End If
   
   Call Bac_Sql_Execute("COMMIT TRANSACTION")
   
   Let IniTransaction = False
   
   Call MsgBox("Se ha completado con exito el Anticipo de la Operación.", vbInformation, App.Title)
   
   Call Unload(Me)

Exit Function
ErrorAnticipo:
   If IniTransaction = True Then
      Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
   End If
   Call MsgBox("Ha ocurrido un error inesperado durante la grabación" & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
End Function

Private Function Validacion() As Boolean
   Dim xMensaje   As String
   Dim oCritico   As Boolean
   
   Let Validacion = False
   Let oCritico = False
   Let xMensaje = ""
   
   If TXTProcNominal.Text = 100# And CHKTipoAnticipo.Value = 0 Then
         Call MsgBox(" ¡ Esta anticipando el 100% del valor nominal, se marcara como Anticipo Total. !", vbExclamation, App.Title)
         Let CHKTipoAnticipo.Value = 1
         Let TXTProcNominal.Text = 100
   End If
    
   If TXTProcNominal.Text = 0# Then
      Let xMensaje = xMensaje & " - Porcentaje de nominal es cero." & vbCrLf
      Let oCritico = True
   End If
   
   If TXTValorAnticipo.Text = 0# Then
      Let xMensaje = xMensaje & " - Valor del Anticipo es cero." & vbCrLf
      Let oCritico = True
   End If
   
   If TXT_AnticipoTransf.Text = 0# Then
      Let xMensaje = xMensaje & " - Valor del Anticipo de Transferencia es cero." & vbCrLf
   End If

   If CMBMonPago.ListIndex = -1 Then
      Let xMensaje = xMensaje & " - No se Especifico Moneda de Pago" & vbCrLf
      Let oCritico = True
   End If
   
   If cmbFPago.ListIndex = -1 Then
      Let xMensaje = xMensaje & " - No se Especifico Forma de Pago" & vbCrLf
      Let oCritico = True
   End If

   If nTicketIntraMesa = True Then
      If Val(LBL_OpEspejo.Caption) = 0 Then
         Let xMensaje = xMensaje & " - No se encuentra N° Operación Espejo para Anticipo de Tickt Intra Mesa." & vbCrLf
         Let oCritico = True
      End If
   End If

   If Len(xMensaje) > 0 Then
      If oCritico = True Then
         Let Validacion = False
         Call MsgBox("Se ha detectado falta de información para completar la grabación." & vbCrLf & vbCrLf & xMensaje, vbCritical, App.Title)
      Else
         If MsgBox("Se ha detectado falta de información para completar la grabación." & vbCrLf & vbCrLf & xMensaje & vbCrLf & "¿ Desea Continuar ?", vbCritical + vbYesNo, App.Title) = vbYes Then
            Let Validacion = True
         End If
      End If
      
      Exit Function
   End If

   Let Validacion = True

End Function





Private Sub TXTValorAnticipoTmp_KeyPress(KeyAscii As Integer)

If KeyAscii = vbKeyReturn Then
    If cmbMoneda.ItemData(cmbMoneda.ListIndex) = 13 Then
        TXTValorAnticipo.Text = FuncTransformaCLP(TXTValorAnticipoTmp.Text)
        'TXT_AnticipoTransf.Text = FuncTransformaCLP(TXTValorAnticipoTmp.Text)         'PRD-XXXX
    End If
   
    If cmbMoneda.ItemData(cmbMoneda.ListIndex) = 999 Then
        TXTValorAnticipo.Text = TXTValorAnticipoTmp.Text
        'TXT_AnticipoTransf.Text = TXTValorAnticipoTmp.Text                            'PRD-XXXX
    End If
    Call TXT_AnticipoTransf.SetFocus
    Call FuncCalculosResultado                                                         'PRD-XXXX
End If

End Sub

Private Sub TXTValorAnticipoTmp_LostFocus()
    If cmbMoneda.ItemData(cmbMoneda.ListIndex) = 13 Then
        Let TXTAnticipoOtraMda.Text = "Eq.CLP"                                         'PRD-XXXX
        Let TXTValorAnticipoOtraMda.CantidadDecimales = 0                              'PRD-XXXX
        Let TXTValorAnticipoOtraMda.Text = FuncTransformaCLP(TXTValorAnticipoTmp.Text) 'PRD-XXXX
        
        TXTValorAnticipo.Text = FuncTransformaCLP(TXTValorAnticipoTmp.Text)
        
        'TXT_AnticipoTransf.Text = FuncTransformaCLP(TXTValorAnticipoTmp.Text) 'PRD-XXXX
    End If
    
    If cmbMoneda.ItemData(cmbMoneda.ListIndex) = 999 Then
        Let TXTAnticipoOtraMda.Text = "Eq.USD"                                         'PRD-XXXX
        Let TXTValorAnticipoOtraMda.CantidadDecimales = 4                              'PRD-XXXX
        Let TXTValorAnticipoOtraMda.Text = FuncTransformaUSD(TXTValorAnticipoTmp.Text) 'PRD-XXXX
        
        
        TXTValorAnticipo.Text = TXTValorAnticipoTmp.Text
        'TXT_AnticipoTransf.Text = TXTValorAnticipoTmp.Text   'PRD-XXXX
    End If
    Call FuncCalculosResultado                                                         'PRD-XXXX
End Sub


