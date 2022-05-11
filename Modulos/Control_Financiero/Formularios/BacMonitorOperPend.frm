VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacMonitorOperPend 
   BackColor       =   &H80000003&
   Caption         =   "Monitoreo de Operaciones Pendientes"
   ClientHeight    =   10950
   ClientLeft      =   1695
   ClientTop       =   1815
   ClientWidth     =   17070
   Icon            =   "BacMonitorOperPend.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   10950
   ScaleWidth      =   17070
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   17070
      _ExtentX        =   30110
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Aprobar"
            Object.ToolTipText     =   "Aprobar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Detalle"
            Object.ToolTipText     =   "Detalle"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Refrescar"
            Object.ToolTipText     =   "Refrescar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Rechazar"
            Object.ToolTipText     =   "Rechazar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame Frame1 
      Height          =   1095
      Left            =   0
      TabIndex        =   1
      Top             =   465
      Width           =   13860
      Begin VB.ComboBox Cmb_Digitador 
         Height          =   315
         Left            =   9180
         Style           =   2  'Dropdown List
         TabIndex        =   16
         Top             =   650
         Width           =   3870
      End
      Begin VB.ComboBox Cmb_Modulo 
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
         ItemData        =   "BacMonitorOperPend.frx":000C
         Left            =   1800
         List            =   "BacMonitorOperPend.frx":000E
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   240
         Width           =   3015
      End
      Begin VB.ComboBox Cmb_T_Operacion 
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
         Left            =   1800
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   650
         Width           =   3015
      End
      Begin VB.ComboBox Cmb_Usuarios 
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
         Left            =   6000
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   650
         Width           =   3015
      End
      Begin VB.ComboBox Cmb_Monedas 
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
         Left            =   6000
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   240
         Width           =   3015
      End
      Begin VB.Label Lbl_Digitador 
         AutoSize        =   -1  'True
         Caption         =   "Digitador"
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
         Left            =   9180
         TabIndex        =   15
         Top             =   405
         Width           =   780
      End
      Begin VB.Label Lbl_Mercado 
         Caption         =   "Modulo"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Left            =   195
         TabIndex        =   9
         Top             =   345
         Width           =   615
      End
      Begin VB.Label Lbl_Tipos_de_operacion 
         AutoSize        =   -1  'True
         Caption         =   "Tipo de Operación"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Left            =   195
         TabIndex        =   8
         Top             =   705
         Width           =   1515
      End
      Begin VB.Label Lbl_Usuario 
         AutoSize        =   -1  'True
         Caption         =   "Operador"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Left            =   5100
         TabIndex        =   7
         Top             =   705
         Width           =   795
      End
      Begin VB.Label Lbl_Monedas 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Left            =   5100
         TabIndex        =   6
         Top             =   345
         Width           =   675
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   12285
      Top             =   210
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
            Picture         =   "BacMonitorOperPend.frx":0010
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMonitorOperPend.frx":032A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMonitorOperPend.frx":077C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMonitorOperPend.frx":0BCE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMonitorOperPend.frx":0D28
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMonitorOperPend.frx":117A
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMonitorOperPend.frx":1494
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla_Marca 
      Height          =   945
      Left            =   7830
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   3375
      Visible         =   0   'False
      Width           =   3045
      _ExtentX        =   5371
      _ExtentY        =   1667
      _Version        =   393216
      Rows            =   1
      Cols            =   3
      FixedCols       =   0
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
   Begin VB.Timer Tmr_Operaciones 
      Interval        =   3000
      Left            =   7845
      Top             =   2445
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   3555
      Left            =   0
      TabIndex        =   11
      Top             =   1485
      Width           =   13860
      _Version        =   65536
      _ExtentX        =   24447
      _ExtentY        =   6271
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
      Begin BACControles.TXTNumero txtNumero_IDD 
         Height          =   285
         Left            =   5880
         TabIndex        =   26
         Top             =   2400
         Visible         =   0   'False
         Width           =   1545
         _ExtentX        =   2725
         _ExtentY        =   503
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
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
      Begin MSFlexGridLib.MSFlexGrid Grilla_Refresca 
         Height          =   945
         Left            =   7770
         TabIndex        =   12
         TabStop         =   0   'False
         Top             =   915
         Visible         =   0   'False
         Width           =   3045
         _ExtentX        =   5371
         _ExtentY        =   1667
         _Version        =   393216
         Rows            =   1
         Cols            =   3
         FixedCols       =   0
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
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   3330
         Left            =   30
         TabIndex        =   13
         TabStop         =   0   'False
         Top             =   165
         Width           =   13020
         _ExtentX        =   22966
         _ExtentY        =   5874
         _Version        =   393216
         ForeColor       =   8388608
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         GridColor       =   -2147483641
         GridColorFixed  =   -2147483642
         FocusRect       =   0
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
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   4770
      Left            =   15
      TabIndex        =   14
      Top             =   5055
      Width           =   13830
      _ExtentX        =   24395
      _ExtentY        =   8414
      _Version        =   393216
      Style           =   1
      Tabs            =   8
      Tab             =   1
      TabsPerRow      =   8
      TabHeight       =   520
      TabMaxWidth     =   18
      BackColor       =   -2147483644
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Líneas"
      TabPicture(0)   =   "BacMonitorOperPend.frx":17AE
      Tab(0).ControlEnabled=   0   'False
      Tab(0).Control(0)=   "Grilla_Error"
      Tab(0).ControlCount=   1
      TabCaption(1)   =   "Límites por Usuario"
      TabPicture(1)   =   "BacMonitorOperPend.frx":17CA
      Tab(1).ControlEnabled=   -1  'True
      Tab(1).Control(0)=   "Grilla_ErrLim"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).ControlCount=   1
      TabCaption(2)   =   "Tasas"
      TabPicture(2)   =   "BacMonitorOperPend.frx":17E6
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "Grilla_ErrTasa"
      Tab(2).ControlCount=   1
      TabCaption(3)   =   "Líneas Consolidadas"
      TabPicture(3)   =   "BacMonitorOperPend.frx":1802
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "Grilla_ErrGrp"
      Tab(3).ControlCount=   1
      TabCaption(4)   =   "Threshold"
      TabPicture(4)   =   "BacMonitorOperPend.frx":181E
      Tab(4).ControlEnabled=   0   'False
      Tab(4).Control(0)=   "GrillaThreshold"
      Tab(4).ControlCount=   1
      TabCaption(5)   =   "Bloqueo/Cltes."
      TabPicture(5)   =   "BacMonitorOperPend.frx":183A
      Tab(5).ControlEnabled=   0   'False
      Tab(5).Control(0)=   "grillaBloqCli"
      Tab(5).ControlCount=   1
      TabCaption(6)   =   "Precios/Tasas"
      TabPicture(6)   =   "BacMonitorOperPend.frx":1856
      Tab(6).ControlEnabled=   0   'False
      Tab(6).Control(0)=   "Grilla_ErrorPrec"
      Tab(6).ControlCount=   1
      TabCaption(7)   =   "Limite Permanencia"
      TabPicture(7)   =   "BacMonitorOperPend.frx":1872
      Tab(7).ControlEnabled=   0   'False
      Tab(7).Control(0)=   "Grilla_ErrLimPer"
      Tab(7).ControlCount=   1
      Begin MSFlexGridLib.MSFlexGrid Grilla_Error 
         Height          =   3615
         Left            =   -74985
         TabIndex        =   18
         TabStop         =   0   'False
         Top             =   345
         Width           =   13785
         _ExtentX        =   24315
         _ExtentY        =   6376
         _Version        =   393216
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483642
         FocusRect       =   0
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
      Begin MSFlexGridLib.MSFlexGrid Grilla_ErrLim 
         Height          =   2355
         Left            =   15
         TabIndex        =   19
         TabStop         =   0   'False
         Top             =   525
         Width           =   13755
         _ExtentX        =   24262
         _ExtentY        =   4154
         _Version        =   393216
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483642
         FocusRect       =   0
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
      Begin MSFlexGridLib.MSFlexGrid Grilla_ErrTasa 
         Height          =   2355
         Left            =   -75015
         TabIndex        =   20
         TabStop         =   0   'False
         Top             =   390
         Width           =   13800
         _ExtentX        =   24342
         _ExtentY        =   4154
         _Version        =   393216
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483642
         FocusRect       =   0
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
      Begin MSFlexGridLib.MSFlexGrid Grilla_ErrGrp 
         Height          =   2355
         Left            =   -74985
         TabIndex        =   21
         TabStop         =   0   'False
         Top             =   345
         Width           =   13755
         _ExtentX        =   24262
         _ExtentY        =   4154
         _Version        =   393216
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483642
         FocusRect       =   0
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
      Begin MSFlexGridLib.MSFlexGrid GrillaThreshold 
         Height          =   2355
         Left            =   -75000
         TabIndex        =   22
         TabStop         =   0   'False
         Top             =   405
         Width           =   13755
         _ExtentX        =   24262
         _ExtentY        =   4154
         _Version        =   393216
         BackColor       =   13160660
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483642
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
      Begin MSFlexGridLib.MSFlexGrid grillaBloqCli 
         Height          =   2355
         Left            =   -74985
         TabIndex        =   23
         TabStop         =   0   'False
         Top             =   450
         Width           =   13755
         _ExtentX        =   24262
         _ExtentY        =   4154
         _Version        =   393216
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483642
         FocusRect       =   0
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
      Begin MSFlexGridLib.MSFlexGrid Grilla_ErrorPrec 
         Height          =   2355
         Left            =   -74940
         TabIndex        =   24
         TabStop         =   0   'False
         Top             =   480
         Width           =   13755
         _ExtentX        =   24262
         _ExtentY        =   4154
         _Version        =   393216
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483642
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
      Begin MSFlexGridLib.MSFlexGrid Grilla_ErrLimPer 
         Height          =   2355
         Left            =   -74925
         TabIndex        =   25
         TabStop         =   0   'False
         Top             =   510
         Width           =   13755
         _ExtentX        =   24262
         _ExtentY        =   4154
         _Version        =   393216
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorSel    =   -2147483646
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483642
         FocusRect       =   0
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
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      Caption         =   "ERRORES"
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
      Height          =   195
      Left            =   6870
      TabIndex        =   17
      Top             =   5055
      Width           =   945
   End
End
Attribute VB_Name = "BacMonitorOperPend"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Sw_Sel                  As Integer
Dim x                       As Integer
Dim C                       As Integer
Dim GrillaLista             As Boolean

Public RutComder            As String
Public Rdv                  As String
Public CodigoClienteComder  As Integer
Public TipoProductoComder   As Integer
Public TipoOperacionComder  As String

'+++ cvegasan 2017.08.01 Control Lineas IDD - Variables para manejo de Grilla Operaciones
'+++ Se comenta esta sección por que los valores de las columnas ya se encuentran definidas
'Const Cons_modulo = 0
'Const Cons_NumOper = 2
'Const Cons_tipoper = 11
'Const Cons_rutcart = 12
'Const Cons_NumOperRF = 2
'--- cvegasan 2017.08.01 Control Lineas IDD - Variables para manejo de Grilla Operaciones

Private Enum Marcar
   [SI] = 1
   [NO] = 0
End Enum
Public ApruebaLinea    As Integer '+++CONTROL IDD, jcamposd, solo debe buscar linea si el perfir del usuario conectado lo amerita

'+++ cvegasan 2017.08.01 Control Lineas IDD - Variables para manejo de Grilla Operaciones
'=== INI  ===
Dim iRowActual As Integer
Dim iColActual As Integer
Dim lNumeroIdd As Long
Dim cSistema As String
Dim lNumeroOperacion As Long

Const iColSistema       As Integer = 0
Const iColTipProducto   As Integer = 1
Const iColNumOperacion  As Integer = 2
Const iColNomCliente    As Integer = 3

Const iColNumeroIDD     As Integer = 4

Const iColFirOper       As Integer = 5 '4
Const iColFirSup1       As Integer = 6 '5
Const iColFirSup2       As Integer = 7 '6
Const iColVacio         As Integer = 8 '7
Const iColMoneda        As Integer = 9 '8
Const iColMonOriginal   As Integer = 10 '9
Const iColOperador      As Integer = 11 '10
Const iColCodProducto   As Integer = 12 '11
Const iColRutCartera    As Integer = 13 '12
Const iColMarAprobacion As Integer = 14 '13
Const iColDigitador     As Integer = 15 '14
'Const iColNumeroIDD     As Integer = 15 Se mueve la columna desde esta posición a la 4
Const iColCorrelativo   As Integer = 16 '16
Const iColAfectaLinea   As Integer = 17 '17
Const iColLineaEspecial As Integer = 18 '18

Const sMensajeOperacionesCabecera As String = "Las siguientes operaciones no pudieron ser grabadas: "

Private Type RegOperacion
    Sistema As String
    codProducto As String
    NumeroOperacion As Long
    Correlativo As Integer
    NumeroIDD As Long
    AfectaLinea As String
    Seleccionado As Boolean
    GrabaRegistro As Boolean ' Si encuentra un registro en "N", lo deja pendiente
End Type

Dim arrDatosGrilla() As RegOperacion
Dim arrDatosAGrabar() As RegOperacion 'Contiene solamente los registros con Seleccionado = true
Dim sMensajeGrabar As String

'=== FIN Variables para manejo de Grilla Operaciones ===
'--- cvegasan 2017.08.01 Control Lineas IDD  - Variables para manejo de Grilla Operaciones

'+++ cvegasan 2017.08.01 Control Lineas IDD
'=== INI PROCEDIMIENTOS ===
Private Sub textovisible(Grid As MSFlexGrid, texto As Control)
    If Grid.Col = iColNumeroIDD Then
         texto.CantidadDecimales = 0
         texto.Max = "9999999999999"
         texto.text = Grid.text
         Call PROC_POSICIONA_TEXTO(Grid, texto)
         texto.Visible = True
         texto.SetFocus
     End If
End Sub

Private Sub TextoKeyDown(KEYCODE As Integer, Shift As Integer, Grid As MSFlexGrid, texto As Control)
    If KEYCODE = vbKeyReturn And Grid.Col = iColNumeroIDD Then
        '-- valida que número idd no sea cero
        If CDbl(texto.text) = 0 Then
            MsgBox "El número de IDD digitado, no puede ser CERO", vbExclamation + vbOKOnly, TITSISTEMA
            txtNumero_IDD.SetFocus
            Exit Sub
        End If
        '-- valida que número idd no sea cero
        
        '-- valida que número idd no se repita
        If Fn_Existe_Numero_IDD(Grid) = True Then
            MsgBox "El número de IDD digitado, ya se encuentra asignado", vbExclamation + vbOKOnly, TITSISTEMA
            txtNumero_IDD.SetFocus
            Exit Sub
        End If
        '-- valida que número idd no se repita
        Grid.text = texto.text
        texto.Visible = False
        Grid.SetFocus
    End If
End Sub

Private Sub prAlmacenaRegistrosAgrupados(oGrilla As MSFlexGrid)
'PROCEDIMIENTO que construye el vector, solamente con los numeros de las operaciones, para que queden agrupadas
Dim iArr As Integer
Dim iRow As Integer
Dim lPrimerNumeroOperacion As Long
Dim iContadorOperaciones As Integer
    
    iArr = 0 'Inicio redimensiona la matriz
    ReDim Preserve arrDatosGrilla(iArr)
        
    '+++ cvegasan 2018.03.08 Control Lineas IDD
    If Not IsNumeric(Grilla.TextMatrix(Grilla.Row, iColNumOperacion)) Then
        Exit Sub
    End If
    '--- cvegasan 2018.03.08 Control Lineas IDD
    lPrimerNumeroOperacion = oGrilla.TextMatrix(2, iColNumOperacion)

    '-->Parte que agrupa operaciones en arrglo
    For iRow = 2 To oGrilla.Rows - 1
        '+++ cvegasan 2018.03.15 Control Lineas IDD
        'arrDatosGrilla(iArr).Sistema = oGrilla.TextMatrix(iRow, iColSistema)
        'arrDatosGrilla(iArr).codProducto = oGrilla.TextMatrix(iRow, iColCodProducto)
        '+++ cvegasan 2018.03.15 Control Lineas IDD
        If (oGrilla.TextMatrix(iRow, iColNumOperacion) = lPrimerNumeroOperacion) And (iRow = 2) Then
            '+++ cvegasan 2018.03.15 Control Lineas IDD
            arrDatosGrilla(iArr).Sistema = oGrilla.TextMatrix(iRow, iColSistema)
            arrDatosGrilla(iArr).codProducto = oGrilla.TextMatrix(iRow, iColCodProducto)
            '+++ cvegasan 2018.03.15 Control Lineas IDD
            arrDatosGrilla(iArr).NumeroOperacion = lPrimerNumeroOperacion
        ElseIf (oGrilla.TextMatrix(iRow, iColNumOperacion) <> lPrimerNumeroOperacion) Then
            iArr = iArr + 1 'Se redimensiona la matriz
            ReDim Preserve arrDatosGrilla(iArr)
            '+++ cvegasan 2018.03.15 Control Lineas IDD
            arrDatosGrilla(iArr).Sistema = oGrilla.TextMatrix(iRow, iColSistema)
            arrDatosGrilla(iArr).codProducto = oGrilla.TextMatrix(iRow, iColCodProducto)
            '+++ cvegasan 2018.03.15 Control Lineas IDD
            lPrimerNumeroOperacion = oGrilla.TextMatrix(iRow, iColNumOperacion)
            arrDatosGrilla(iArr).NumeroOperacion = lPrimerNumeroOperacion
        End If
        
        arrDatosGrilla(iArr).Correlativo = oGrilla.TextMatrix(iRow, iColCorrelativo)
        
        arrDatosGrilla(iArr).NumeroIDD = oGrilla.TextMatrix(iRow, iColNumeroIDD)
        arrDatosGrilla(iArr).AfectaLinea = oGrilla.TextMatrix(iRow, iColAfectaLinea)
        
        arrDatosGrilla(iArr).Seleccionado = False
    Next iRow
    '--<Parte que agrupa operaciones en arrglo
End Sub

Private Sub prActualizaRegistroSeleccionado(ByRef oArray() As RegOperacion, Sistema As String, NumeroOperacion As Long, Seleccionado As Boolean)
'PROCEDIMIENTO que construye ACTUALIZA campo SELECCIONADO del vector que contiene solamente los numeros de las operaciones, para que queden agrupadas
Dim iArray As Integer
    For iArray = LBound(oArray) To UBound(oArray)
        If NumeroOperacion = oArray(iArray).NumeroOperacion And Sistema = oArray(iArray).Sistema Then
          oArray(iArray).Seleccionado = Seleccionado ' TRUE/FALSE
          Exit For
        End If
    Next iArray
End Sub

Private Sub prActualizaNumeroIDD(ByRef oArray() As RegOperacion, NumeroOperacion As Long, Sistema As String, NumeroIDD As Long)
Dim iArray As Integer
    For iArray = LBound(oArray) To UBound(oArray)
        If NumeroOperacion = oArray(iArray).NumeroOperacion And Sistema = oArray(iArray).Sistema Then
          oArray(iArray).NumeroIDD = NumeroIDD ' TRUE/FALSE
          Exit For
        End If
    Next iArray
End Sub

Private Sub prActualizaNumeroIddTablaTransaccionesIdd(ByRef oArray() As RegOperacion)
Dim iArray As Integer
Dim sSistema As String
Dim sCodProducto As String
Dim lNumeroOperacion As Long
Dim iCorrelativo As Long
Dim lNumeroIdd As Long
    If ((Not oArray) = -1) Then ' Cuando el arreglo no tiene elementos va con -1
        Exit Sub
    End If
    
    For iArray = LBound(oArray) To UBound(oArray)
        Envia = Array()
        sSistema = oArray(iArray).Sistema
        sCodProducto = oArray(iArray).codProducto
        lNumeroOperacion = oArray(iArray).NumeroOperacion
        iCorrelativo = oArray(iArray).Correlativo
        lNumeroIdd = oArray(iArray).NumeroIDD
       
        AddParam Envia, sSistema
        AddParam Envia, sCodProducto
        AddParam Envia, lNumeroOperacion
        AddParam Envia, iCorrelativo
        AddParam Envia, lNumeroIdd
        
        If Not Bac_Sql_Execute("SP_ACTUALIZA_OPERACION_NUMERO_IDD", Envia) Then
            Exit Sub
        End If
    Next iArray
End Sub
'=== FIN PROCEDIMIENTOS ===

'===  INI FUNCIONES ===
Private Function Fn_Existe_Numero_IDD(Grid As MSFlexGrid) As Boolean
    Dim dNumero_Grilla As Double
    Dim dNumero_IDD_Buscar As Double
    Dim bExiste As Boolean
    Dim dFila As Double

    Existe = False
    'La primera vez toma el primer numero IDD, para comenzar la búsqueda
    If Grid.Rows > 2 Then dNumero_IDD_Buscar = txtNumero_IDD.text
    
    For dFila = 2 To Grid.Rows - 1
        dNumero_Grilla = IIf(Grid.TextMatrix(dFila, iColNumeroIDD) = "", 0, Grid.TextMatrix(dFila, iColNumeroIDD))
        If dNumero_IDD_Buscar = dNumero_Grilla Then
            Existe = True
            Exit For
        End If
    Next
    Fn_Existe_Numero_IDD = Existe
End Function

Private Function fnSeleccionaRegistrosParaGrabar(ByRef oArray() As RegOperacion) As RegOperacion()
' FUNCION que toma el VECTOR agrupado y selecciona solamente los registros que se grabarán en la BD,
' el campo SELECCIONADO cambiará a TRUE cuando la celda cambía de color a "Morado = &HFFC0C0"

    Dim iArray As Integer
    Dim iArrayGraba As Integer
    Dim oArrayAGrabar() As RegOperacion
    
    iArrayGraba = 0
    '+++ cvegasan 2018.04.19    Control Lineas IDD Verifica que por cada número operación del vector arrDatosGrilla,
    '+++                        estén TODOS SELECCIONADOS EN LA GRILLA = "SI", de lo contrario no irá en el grupo de grabar
    
        '+++ cvegasan 2018.03.15 Control Lineas IDD
        ' Actualiza campo "SELECCIONADO" a "TRUE" si la fila está seleccionada
        'For iGrilla = 2 To Grilla.Rows - 1
        '    If Grilla.TextMatrix(iGrilla, iColMarAprobacion) = "SI" Then
        '        oArray(iGrilla - 2).Seleccionado = True
        '    End If
        'Next iGrilla
        '--- cvegasan 2018.03.15 Control Lineas IDD

    For iArray = LBound(oArray) To UBound(oArray)
        For iGrilla = 2 To Grilla.Rows - 1
            If Grilla.TextMatrix(iGrilla, iColNumOperacion) = oArray(iArray).NumeroOperacion Then
                '+++ cvegasan 2018.04.19    Control Lineas IDD Se agrega que numero IDD sea <> 0
                If Grilla.TextMatrix(iGrilla, iColMarAprobacion) = "SI" And Grilla.TextMatrix(iGrilla, iColNumeroIDD) <> 0 Then
                '--- cvegasan 2018.04.19    Control Lineas IDD Se agrega que numero IDD sea <> 0
                    oArray(iArray).Seleccionado = True
                Else
                    oArray(iArray).Seleccionado = False
                    Exit For
                End If
            End If
        Next iGrilla
    Next iArray
    '--- cvegasan 2018.04.19    Control Lineas IDD Verifica que por cada número operación del vector arrDatosGrilla,
    '---                        estén TODOS SELECCIONADOS EN LA GRILLA = "SI", de lo contrario no irá en el grupo de grabar

    For iArray = LBound(oArray) To UBound(oArray)
        If oArray(iArray).Seleccionado = True Then
            ReDim Preserve oArrayAGrabar(iArrayGraba)

            oArrayAGrabar(iArrayGraba).Sistema = oArray(iArray).Sistema
            oArrayAGrabar(iArrayGraba).codProducto = oArray(iArray).codProducto
            oArrayAGrabar(iArrayGraba).NumeroOperacion = oArray(iArray).NumeroOperacion
            oArrayAGrabar(iArrayGraba).Correlativo = oArray(iArray).Correlativo
            oArrayAGrabar(iArrayGraba).NumeroIDD = oArray(iArray).NumeroIDD
            
            oArrayAGrabar(iArrayGraba).AfectaLinea = oArray(iArray).AfectaLinea
            oArrayAGrabar(iArrayGraba).Seleccionado = oArray(iArray).Seleccionado
            oArrayAGrabar(iArrayGraba).GrabaRegistro = oArray(iArray).GrabaRegistro
            
            iArrayGraba = iArrayGraba + 1
        End If
    Next iArray
    fnSeleccionaRegistrosParaGrabar = oArrayAGrabar()
End Function

Private Function fnVerificaNoAfectaEnGrilla(Sistema As String, NumeroOperacion As Long, ByRef oArray() As RegOperacion, oGrilla As MSFlexGrid) As Boolean
' Esta función recorrerá la grilla por la operación seleccionada
Dim iGrilla As Integer
Dim AfectaLinea As Integer
Dim iArray As Integer

    AfectaLineaNO = 0 'Variable que lleva la cuenta del AFECTA_LINEA = "N"
    For iGrilla = 2 To Grilla.Rows - 1
        If NumeroOperacion = Grilla.TextMatrix(iGrilla, iColNumOperacion) And Sistema = Grilla.TextMatrix(iGrilla, iColSistema) Then
            If Grilla.TextMatrix(iGrilla, iColAfectaLinea) = "N" Then ' si Afecta linea es N retorna Falso
                AfectaLineaNO = AfectaLineaNO + 1
            End If
        End If
    Next iGrilla
    
    'Actualiza campo "GrabaOperacion=False" si se el contador "AfectaLineaNO" ("N") > 0
    For iArray = LBound(oArray) To UBound(oArray)
        If (NumeroOperacion = oArray(iArray).NumeroOperacion) Then
            oArray(iArray).GrabaRegistro = IIf(AfectaLineaNO = 0, True, False)
        End If
    Next iArray
    
    fnVerificaNoAfectaEnGrilla = IIf(AfectaLineaNO > 0, True, False)
End Function

Private Function fnMensajeOperacionesPendientesGrabacion(ByRef oArray() As RegOperacion) As String
'Funcion que retorna mensaje con las operaciones que por el valor de la columna AFECTA_LINEA="N", no se grabaron
'On Error Resume Next
Dim iArray As Integer
Dim sMensajeOperaciones As String

    sMensajeOperaciones = ""
    If ((Not oArray) = -1) Then ' Cuando el arreglo no tiene elementos va con -1
        fnMensajeOperacionesPendientesGrabacion = sMensajeOperaciones
        Exit Function
    End If
    
    For iArray = LBound(oArray) To UBound(oArray)
            If (oArray(iArray).GrabaRegistro = False) Then
                sMensajeOperaciones = sMensajeOperaciones & oArray(iArray).NumeroOperacion & " "
            End If
    Next iArray
    sMensajeOperaciones = Trim(sMensajeOperaciones)
    sMensajeOperaciones = Replace(sMensajeOperaciones, " ", ",")
fnMensajeOperacionesPendientesGrabacion = sMensajeOperaciones

End Function

Private Function fnRetornaParametroMAtrizAtribucion() As Integer
Dim iParametro As Integer
Dim Datos()
    Envia = Array()
    AddParam Envia, gsBAC_User
    
    iParametro = 1 '--> por defecto NO aprueba línea
    
    If Bac_Sql_Execute("SP_CON_MATRIZ_ATRIBUCION", Envia) Then
        If Bac_SQL_Fetch(Datos()) Then
            iParametro = (Val(Datos(3)))
        End If
    End If
    fnRetornaParametroMAtrizAtribucion = iParametro
End Function
'+++ cvegasan 2018.03.15 Control Lineas IDD
Private Function EstaArrayVacio(ByRef oArray() As RegOperacion) As Boolean
    On Error Resume Next
    EstaArrayVacio = UBound(oArray)
    EstaArrayVacio = Err.Number ' Error 9 (Subscript out of range)
End Function
'+++ cvegasan 2018.03.15 Control Lineas IDD
'===  FIN FUNCIONES ===
'--- cvegasan 2017.08.01 Control Lineas IDD

Private Sub PintarCelda(MArca As Marcar, iFila As Integer)
    Dim iContador  As Integer

    Grilla.Row = iFila

    For iContador = 0 To Grilla.Cols - 1
        Grilla.Col = iContador

        If MArca = SI Then
            Grilla.CellBackColor = &HFFC0C0
            Grilla.CellForeColor = &H0&
        Else
            Grilla.CellBackColor = &HFFFFFF        '&H80000004
            If iContador = 5 Or iContador = 6 Then
                If Grilla.TextMatrix(Grilla.Row, iContador) = "FALTA" Then
                    Grilla.CellForeColor = &HFF&
                End If
            Else
                Grilla.CellForeColor = &H800000
            End If
        End If
        
        'prd19111 ini
        Dim Operacion       As String
        Dim Sistema         As String
        '+++ cvegasan 2017.08.01 Control Lineas IDD
        'Operacion = Grilla.TextMatrix(Grilla.Row, 2)
        'Sistema = Grilla.TextMatrix(Grilla.Row, 0)
        Operacion = Grilla.TextMatrix(Grilla.Row, iColNumOperacion)
        Sistema = Grilla.TextMatrix(Grilla.Row, iColSistema)
        '--- cvegasan 2017.08.01 Control Lineas IDD
        'prd19111 fin

    Next iContador
        
    'prd19111 ini
    If valida_comder_mfca Then   'SWICH ACTIVA COMDER
        If MArca <> SI Then
            '+++ cvegasan 2017.08.01 Control Lineas IDD
            'Operacion = Grilla.TextMatrix(Grilla.Row, 2)
            'Sistema = Grilla.TextMatrix(Grilla.Row, 0)
            Operacion = Grilla.TextMatrix(Grilla.Row, iColNumOperacion)
            Sistema = Grilla.TextMatrix(Grilla.Row, iColSistema)
            '--- cvegasan 2017.08.01 Control Lineas IDD
            If BuscaComder(Operacion, Sistema) = "SI" Then
                '+++ cvegasan 2017.08.01 Control Lineas IDD
                'Grilla.Col = 0:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 1:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 2:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 3:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 4:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 5:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 6:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 7:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 8:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 9:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 10:    Grilla.CellBackColor = vbCyan
                'Grilla.Col = 11
                'Grilla.CellBackColor = vbCyan
                'Grilla.Col = 12
                'Grilla.CellBackColor = vbCyan
                
                For iCol = 0 To Grilla.Cols - 1
                    Grilla.Col = iCol: Grilla.CellBackColor = vbCyan
                Next iCol
                '--- cvegasan 2017.08.01 Control Lineas IDD
            End If
            
        Else
            Grilla.CellForeColor = &H800000
        End If
    End If
    'prd19111 fin
    '+++ cvegasan 2017.08.01 Control Lineas IDD
    Call prActualizaRegistroSeleccionado(arrDatosGrilla, Sistema, CLng(Operacion), IIf(MArca = SI, True, False))
    '--- cvegasan 2017.08.01 Control Lineas IDD
End Sub

Sub CargarGrilla_Error()
    On Error Resume Next
    Dim Datos()
    Dim i, SW        As Integer
    Dim Mensaje      As String
    Dim nContador    As Integer
    
    Mensaje = ""
    nContador = 0
    '+++ cvegasan 2017.08.01 Control Lineas IDD
    If Grilla.Rows = 2 Or Not IsNumeric(Grilla.TextMatrix(Grilla.Row, iColNumOperacion)) Then
        Exit Sub
    End If
   '--- cvegasan 2017.08.01 Control Lineas IDD
   '+++CONTROL IDD, jcamposd, solo debe buscar linea si el perfir del usuario conectado lo amerita
   If ApruebaLinea = 0 Then
        '+++ cvegasan 2017.08.01 Control Lineas IDD
        'cSistema = Grilla.TextMatrix(Grilla.Row, 0)
        'nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, 2))
        cSistema = Grilla.TextMatrix(Grilla.Row, iColSistema)
        nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, iColNumOperacion))
        '--- cvegasan 2017.08.01 Control Lineas IDD
        Envia = Array(cSistema, nNumoper)
        If Not Bac_Sql_Execute("SP_LINEAS_ERROR", Envia) Then
            Exit Sub
        End If
        
        i = 2:  SW = 0
        
        Grilla_Error.Redraw = False
        Grilla_Error.Rows = 1    '-> Grilla_Error.FixedRows
        
        Do While Bac_SQL_Fetch(Datos())
            Grilla_Error.Rows = Grilla_Error.Rows + 1
            nContador = nContador + 1
            
            SW = 1
            If Val(Datos(2)) > 0 Then
                Mensaje = " en " + Format(Datos(2), Formato_Numero)
            Else
                Mensaje = ""
            End If
            Grilla_Error.TextMatrix(Grilla_Error.Rows - 1, 0) = Trim(Datos(1)) + Mensaje  'glosa del sistema
        Loop
       
        If SW <> 0 Then
            Grilla_Error.FocusRect = flexFocusNone
            Grilla_Error.Row = Grilla_Error.FixedRows
            Grilla_Error.Col = IIf(Grilla_Error.Rows >= Grilla_Error.FixedRows + 7, 0, 1)
            Grilla_Error.Enabled = (Grilla_Error.Rows >= Grilla_Error.FixedRows + 7)
        End If
        Grilla_Error.Redraw = True
    
        SSTab1.TabCaption(0) = "LINEAS (" & Trim(Str(Grilla_Error.Rows - 1)) & ")"

    Else
    
    '---CONTROL IDD, jcamposd, solo debe buscar linea si el perfir del usuario conectado lo amerita
    Call CargarGrilla_Error_Limites
    Call CargaMensajesThrershold
    Call CargarGrilla_Error_Tasas
    Call CargarGrilla_Error_Precios
    Call CargarGrilla_Error_Grupos
   'Call CargarGrilla_Error_Precios     '-> nuevo
    Call CargarGrilla_Bloq_Clientes
    Call CargarGrilla_ErrLimPerm        '-> LD1_035
    End If '+++CONTROL IDD, jcamposd, solo debe buscar linea si el perfir del usuario conectado lo amerita

End Sub

Sub CargarGrilla_Error_Limites()
    On Error Resume Next
    Dim Datos()
    Dim i, SW        As Integer
    Dim Mensaje      As String
    Dim nContador    As Integer

    Mensaje = ""
    nContador = 0
    '+++ cvegasan 2017.08.01 Control Lineas IDD
    'If Grilla.Rows = 2 Or Not IsNumeric(Grilla.TextMatrix(Grilla.Row, 2)) Then
    '    Exit Sub
    'End If

    'cSistema = Grilla.TextMatrix(Grilla.Row, 0)
    'nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, 2))
    If Grilla.Rows = 2 Or Not IsNumeric(Grilla.TextMatrix(Grilla.Row, iColNumOperacion)) Then
        Exit Sub
    End If

    cSistema = Grilla.TextMatrix(Grilla.Row, iColSistema)
    nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, iColNumOperacion))
    '--- cvegasan 2017.08.01 Control Lineas IDD
    Envia = Array(cSistema, nNumoper)
    If Not Bac_Sql_Execute("SP_LIMITES_ERROR", Envia) Then
        Exit Sub
    Else
        i = 2
        Grilla_ErrLim.Redraw = False
        SW = 0
        Grilla_ErrLim.Rows = Grilla_ErrLim.FixedRows
        
        Do While Bac_SQL_Fetch(Datos())
            nContador = nContador + 1
            SW = 1
            Grilla_ErrLim.Rows = Grilla_ErrLim.Rows + 1
            i = Grilla_ErrLim.Rows - 1
            If Val(Datos(2)) > 0 Then
                Mensaje = " en " + Format(Datos(2), Formato_Numero)
            Else
                Mensaje = ""
            End If
            Grilla_ErrLim.TextMatrix(i, 0) = Trim(Datos(1)) + Mensaje  'glosa del sistema
        Loop
      
        Grilla_ErrLim.FocusRect = flexFocusLight
        Grilla_ErrLim.Enabled = False
        If SW <> 0 Then
            Grilla_ErrLim.FocusRect = flexFocusNone
            Grilla_ErrLim.Row = Grilla_ErrLim.FixedRows
            Grilla_ErrLim.Col = 0
            Grilla_ErrLim.Enabled = (Grilla_ErrLim.Rows >= Grilla_ErrLim.FixedRows + 7)
        End If
        Grilla_ErrLim.Redraw = True
    End If
    
    SSTab1.TabCaption(1) = "LIMITES (" & Trim(Str(nContador)) & ")"
End Sub

Sub CargarGrilla_Error_Tasas()
    On Error Resume Next
    Dim Datos()
    Dim i, SW        As Integer
    Dim Mensaje      As String
    Dim nContador    As Integer
   
    Mensaje = ""
    nContador = 0
    '+++ cvegasan 2017.08.01 Control Lineas IDD
    'If Grilla.Rows = 2 Or Not IsNumeric(Grilla.TextMatrix(Grilla.Row, 2)) Then
    '    Exit Sub
    'End If
    
    'cSistema = Grilla.TextMatrix(Grilla.Row, 0)
    'nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, 2))
    If Grilla.Rows = 2 Or Not IsNumeric(Grilla.TextMatrix(Grilla.Row, iColNumOperacion)) Then
        Exit Sub
    End If
    
    cSistema = Grilla.TextMatrix(Grilla.Row, iColSistema)
    nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, iColNumOperacion))
    '--- cvegasan 2017.08.01 Control Lineas IDD
    Envia = Array(cSistema, nNumoper)
    If Not Bac_Sql_Execute("SP_LIMITES_TASAS", Envia) Then
        Exit Sub
    Else
    i = 2
    Grilla_ErrTasa.Redraw = False
    SW = 0
    Grilla_ErrTasa.Rows = Grilla_ErrTasa.FixedRows
    Do While Bac_SQL_Fetch(Datos())
        nContador = nContador + 1
        SW = 1
        Grilla_ErrTasa.Rows = Grilla_ErrTasa.Rows + 1
        i = Grilla_ErrTasa.Rows - 1
        Grilla_ErrTasa.TextMatrix(i, 0) = Trim(Datos(1)) + Mensaje   'glosa del sistema
    Loop
    Grilla_ErrTasa.FocusRect = flexFocusLight
    Grilla_ErrTasa.Enabled = False
    If SW <> 0 Then
        Grilla_ErrTasa.FocusRect = flexFocusNone
        Grilla_ErrTasa.Row = Grilla_ErrTasa.FixedRows
        Grilla_ErrTasa.Col = 0
        Grilla_ErrTasa.Enabled = (Grilla_ErrTasa.Rows >= Grilla_ErrTasa.FixedRows + 7)
    End If
        Grilla_ErrTasa.Redraw = True
    End If

    SSTab1.TabCaption(2) = "TASAS (" & Trim(Str(nContador)) & ")"
End Sub

Sub CargarGrilla_Error_Precios()
   On Error Resume Next
   Dim Datos()
   Dim i, SW        As Integer
   Dim Mensaje      As String
   Dim nContador    As Integer
   
   Mensaje = ""
   nContador = 0
   '+++ cvegasan 2017.08.01 Control Lineas IDD
   'If Grilla.Rows = 2 Or Not IsNumeric(Grilla.TextMatrix(Grilla.Row, 2)) Then
   '   Exit Sub
   'End If
    
   'cSistema = Grilla.TextMatrix(Grilla.Row, 0)
   'nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, 2))
   If Grilla.Rows = 2 Or Not IsNumeric(Grilla.TextMatrix(Grilla.Row, iColNumOperacion)) Then
      Exit Sub
   End If
    
   cSistema = Grilla.TextMatrix(Grilla.Row, iColSistema)
   nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, iColNumOperacion))
   '--- cvegasan 2017.08.01 Control Lineas IDD
   Envia = Array(cSistema, nNumoper)
   If Not Bac_Sql_Execute("SP_LIMITES_PRECIOS", Envia) Then
      Exit Sub
   Else
      i = 2
      Grilla_ErrorPrec.Redraw = False
      SW = 0
      Grilla_ErrorPrec.Rows = Grilla_ErrorPrec.FixedRows
      Do While Bac_SQL_Fetch(Datos())
         nContador = nContador + 1
         SW = 1
         Grilla_ErrorPrec.Rows = Grilla_ErrorPrec.Rows + 1
         i = Grilla_ErrorPrec.Rows - 1
         Grilla_ErrorPrec.TextMatrix(i, 0) = Trim(Datos(1)) + Mensaje   'glosa del sistema
      Loop
      Grilla_ErrorPrec.FocusRect = flexFocusLight
      Grilla_ErrorPrec.Enabled = False
      If SW <> 0 Then
         Grilla_ErrorPrec.FocusRect = flexFocusNone
         Grilla_ErrorPrec.Row = Grilla_ErrorPrec.FixedRows
         Grilla_ErrorPrec.Col = 0
         Grilla_ErrorPrec.Enabled = (Grilla_ErrorPrec.Rows >= Grilla_ErrorPrec.FixedRows + 7)
      End If
      Grilla_ErrorPrec.Redraw = True
   End If
   SSTab1.TabCaption(6) = "PRECIOS y TASAS (" & Trim(Str(nContador)) & ")"

End Sub

Sub CargarGrilla_Bloq_Clientes()
    On Error Resume Next
    Dim Datos()
    Dim i, SW        As Integer
    Dim Mensaje      As String
    Dim nContador    As Integer
    
    Mensaje = ""
    nContador = 0
    '+++ cvegasan 2017.08.01 Control Lineas IDD
    'If Grilla.Rows = 2 Or Not IsNumeric(Grilla.TextMatrix(Grilla.Row, 2)) Then
    '   Exit Sub
    'End If
     
    'cSistema = Grilla.TextMatrix(Grilla.Row, 0)
    'nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, 2))
    If Grilla.Rows = 2 Or Not IsNumeric(Grilla.TextMatrix(Grilla.Row, iColNumOperacion)) Then
       Exit Sub
    End If
     
    cSistema = Grilla.TextMatrix(Grilla.Row, iColSistema)
    nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, iColNumOperacion))
    '--- cvegasan 2017.08.01 Control Lineas IDD
    Envia = Array(cSistema, nNumoper)
    If Not Bac_Sql_Execute("SP_LIMITES_BLOQ_CLTES", Envia) Then
        Exit Sub
    Else
        With grillaBloqCli
            i = 2
            .Redraw = False
            SW = 0
            .Rows = .FixedRows
            Do While Bac_SQL_Fetch(Datos())
               nContador = nContador + 1
               SW = 1
               .Rows = .Rows + 1
               i = .Rows - 1
               .TextMatrix(i, 0) = Trim(Datos(1)) + Mensaje   'glosa del sistema
            Loop
            .FocusRect = flexFocusLight
            .Enabled = False
            If SW <> 0 Then
               .FocusRect = flexFocusNone
               .Row = .FixedRows
               .Col = 0
               .Enabled = (.Rows >= .FixedRows + 7)
            End If
            .Redraw = True
        End With
    End If
    SSTab1.TabCaption(5) = "BLOQUEO CLIENTES (" & Trim(Str(nContador)) & ")"

End Sub

'-> LD1_035
Private Sub CargarGrilla_ErrLimPerm()
    On Error GoTo ErrLoadLimPermanencia
    Dim cSqlDatos()
    Dim nFolio      As Long
    Dim nContador   As Long
    '+++ cvegasan 2017.08.01 Control Lineas IDD
    'Let nFolio = CDbl(Grilla.TextMatrix(Grilla.RowSel, 2))
    Let nFolio = CDbl(Grilla.TextMatrix(Grilla.RowSel, iColNumOperacion))
    '--- cvegasan 2017.08.01 Control Lineas IDD
    Envia = Array()
    Call AddParam(Envia, nFolio)
    If Not Bac_Sql_Execute("BacLineas.dbo.SP_LOAD_ERROR_LIMPERMANENCIA", Envia) Then
        Exit Sub
    End If
    
    Let nContador = 0
    Let Grilla_ErrLimPer.Redraw = False

    Let Grilla_ErrLimPer.Rows = 1
    Let Grilla_ErrLimPer.TextMatrix(0, 0) = "Id":       Let Grilla_ErrLimPer.ColWidth(0) = 0
    Let Grilla_ErrLimPer.TextMatrix(0, 1) = "Mensaje":  Let Grilla_ErrLimPer.ColWidth(1) = 14000
    
    Do While Bac_SQL_Fetch(cSqlDatos())
        Let nContador = nContador + 1
        Let Grilla_ErrLimPer.Rows = Grilla_ErrLimPer.Rows + 1
        Let Grilla_ErrLimPer.Cols = 2
        
        Let Grilla_ErrLimPer.TextMatrix(Grilla_ErrLimPer.Rows - 1, 0) = (Grilla_ErrLimPer.Rows - 2)
        Let Grilla_ErrLimPer.TextMatrix(Grilla_ErrLimPer.Rows - 1, 1) = cSqlDatos(1)
    Loop
    
    Let Grilla_ErrLimPer.Redraw = True
    Let Grilla_ErrLimPer.Visible = True
    
    
    Let SSTab1.TabCaption(7) = "LIMITES DE PERMANENCIA (" & Trim(Str(nContador)) & ")"
    
    On Error GoTo 0

Exit Sub
ErrLoadLimPermanencia:

    Let Grilla_ErrLimPer.Redraw = True
    On Error GoTo 0
End Sub
'-> LD1_035

Sub CargarGrilla_Error_Grupos()
   On Error Resume Next
   Dim Datos()
   Dim i, SW        As Integer
   Dim Mensaje      As String
   Dim nContador    As Integer

   Mensaje = ""
   nContador = 0
   '+++ cvegasan 2017.08.01 Control Lineas IDD
   'If Grilla.Rows = 2 Or Not IsNumeric(Grilla.TextMatrix(Grilla.Row, 2)) Then
   '   Exit Sub
   'End If
   
   'cSistema = Grilla.TextMatrix(Grilla.Row, 0)
   'nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, 2))
   If Grilla.Rows = 2 Or Not IsNumeric(Grilla.TextMatrix(Grilla.Row, iColNumOperacion)) Then
      Exit Sub
   End If
   
   cSistema = Grilla.TextMatrix(Grilla.Row, iColSistema)
   nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, iColNumOperacion))
   '--- cvegasan 2017.08.01 Control Lineas IDD
   Envia = Array(cSistema, nNumoper)
   If Not Bac_Sql_Execute("SP_LINEAS_CONSOLIDADAS", Envia) Then
      Exit Sub
   Else
      i = 2
      Grilla_ErrGrp.Redraw = False
      SW = 0
      Grilla_ErrGrp.Rows = Grilla_ErrGrp.FixedRows
      Do While Bac_SQL_Fetch(Datos())
         nContador = nContador + 1
         SW = 1
         Grilla_ErrGrp.Rows = Grilla_ErrGrp.Rows + 1
         i = Grilla_ErrGrp.Rows - 1
         If Val(Datos(2)) > 0 Then
            Mensaje = " en " + Format(Datos(2), Formato_Numero)
         Else
            Mensaje = ""
         End If
         Grilla_ErrGrp.TextMatrix(i, 0) = Trim(Datos(1)) + Mensaje  'glosa del sistema
      Loop
      Grilla_ErrGrp.FocusRect = flexFocusLight
      Grilla_ErrGrp.Enabled = False
      If SW <> 0 Then
         Grilla_ErrGrp.FocusRect = flexFocusNone
         Grilla_ErrGrp.Row = Grilla_ErrGrp.FixedRows
         Grilla_ErrGrp.Col = 0
         Grilla_ErrGrp.Enabled = (Grilla_ErrGrp.Rows >= Grilla_ErrGrp.FixedRows + 7)
      End If
      Grilla_ErrGrp.Redraw = True
   End If
   
    SSTab1.TabCaption(3) = "CONSOLIDADOS (" & Trim(Str(nContador)) & ")"
End Sub

Sub Rechazar_Operacion()
   On Error Resume Next
   Dim Datos()

   If Sw_Sel = 0 Then
      MsgBox "No ha Selecionado Operación", vbCritical, TITSISTEMA
      Exit Sub
   End If

   For iContador = 2 To Grilla.Rows - 1
      '+++ cvegasan 2017.08.01 Control Lineas IDD
      'If Grilla.TextMatrix(iContador, 13) = "SI" Then
      '
      '   cSistema = Grilla.TextMatrix(iContador, 0)
      '   nNumoper = CDbl(Grilla.TextMatrix(iContador, 2))
      If Grilla.TextMatrix(iContador, iColMarAprobacion) = "SI" Then

         cSistema = Grilla.TextMatrix(iContador, iColSistema)
         nNumoper = CDbl(Grilla.TextMatrix(iContador, iColNumOperacion))
      '--- cvegasan 2017.08.01 Control Lineas IDD
         'Valida si es o no operacion COMDER ARM PRD 19110
          If valida_operacion_comder(CLng(nNumoper), CStr(cSistema)) Then
             Exit Sub
          End If
          
         Envia = Array(gsBAC_Fecp, cSistema, nNumoper, gsBAC_User)
         If Not Bac_Sql_Execute("SP_LINEAS_RECHAZA", Envia) Then
            MsgBox "Problemas al Rechazar Operación", vbCritical, TITSISTEMA
            Exit Sub
         End If
         If Bac_SQL_Fetch(Datos()) Then
            If Datos(1) = "NO" Then
               MsgBox Datos(2), vbOKOnly + vbExclamation
               Exit Sub
            End If
         End If
      
      End If
   Next iContador

   MsgBox "Operación fue Rechazada.", vbInformation, TITSISTEMA
    '+++ cvegasan 2017.08.01 Control Lineas IDD
    'Call CargarGrilla
    'Call LlenarGrilla_Error
    Call LlenarGrilla
    Call LlenarGrilla_Error
    Call CargarGrilla
    '--- cvegasan 2017.08.01 Control Lineas IDD
End Sub

Sub Refrescar()
    Call CargarGrilla
    
    If Grilla.Rows > Grilla.FixedRows Then
        Grilla.SetFocus
    End If
    '+++ cvegasan 2017.08.15 Control Lineas IDD
    Erase arrDatosAGrabar
    '--- cvegasan 2017.08.15 Control Lineas IDD
End Sub

Sub VerDetalle()
   Dim Datos()
   
   If Sw_Sel = 0 Then
      MsgBox "No ha Selecionado Operación", vbCritical, TITSISTEMA
      Exit Sub
   End If
    '+++ cvegasan 2017.08.01 Control Lineas IDD
    'cSistema = Grilla.TextMatrix(Grilla.Row, 0)
    'nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, 2))
    cSistema = Grilla.TextMatrix(Grilla.Row, iColSistema)
    nNumoper = CDbl(Grilla.TextMatrix(Grilla.Row, iColNumOperacion))
    '--- cvegasan 2017.08.01 Control Lineas IDD
    Envia = Array(cSistema, nNumoper, gsBAC_User)
    Tmr_Operaciones.Enabled = False

'    BacMonitorOperPend_Detalle.Show vbModal

    Tmr_Operaciones.Enabled = True

    Call LlenarGrilla

    Call CargarGrilla

End Sub

Sub LlenarGrilla()
   Grilla.Rows = 3
   '+++ cvegasan 2017.08.01 Control Lineas IDD
   Grilla.Cols = 19 'Numero_IDD+Correlativo+Flag+Lin_Especial '15       '14
  
   Grilla.FixedCols = 0
   Grilla.FixedRows = 2
   'Grilla.TextMatrix(0, 0) = "Sistema":   Grilla.TextMatrix(1, 0) = "":             Grilla.ColWidth(0) = 850
   'Grilla.TextMatrix(0, 1) = "Tipo":      Grilla.TextMatrix(1, 1) = "Producto":     Grilla.ColWidth(1) = 3000
   'Grilla.TextMatrix(0, 2) = "Número":    Grilla.TextMatrix(1, 2) = "Operación":    Grilla.ColWidth(2) = 1000
   'Grilla.TextMatrix(0, 3) = "Nombre":    Grilla.TextMatrix(1, 3) = "Cliente":      Grilla.ColWidth(3) = 3500:    Grilla.ColAlignment(3) = flexAlignLeftCenter
   'Grilla.TextMatrix(0, 4) = "Firma":     Grilla.TextMatrix(1, 4) = "Oper.":        Grilla.ColWidth(4) = 1100:    Grilla.ColAlignment(4) = flexAlignCenterCenter
   'Grilla.TextMatrix(0, 5) = "Firma":     Grilla.TextMatrix(1, 5) = "Sup.1":        Grilla.ColWidth(5) = 1100:    Grilla.ColAlignment(5) = flexAlignCenterCenter
   'Grilla.TextMatrix(0, 6) = "Firma":     Grilla.TextMatrix(1, 6) = "Sup.2":        Grilla.ColWidth(6) = 1100:    Grilla.ColAlignment(6) = flexAlignCenterCenter
   'Grilla.TextMatrix(0, 7) = "":          Grilla.TextMatrix(1, 7) = "":             Grilla.ColWidth(7) = 0 '1900
   'Grilla.TextMatrix(0, 8) = "Moneda":    Grilla.TextMatrix(1, 8) = "":             Grilla.ColWidth(8) = 800
   'Grilla.TextMatrix(0, 9) = "Monto":     Grilla.TextMatrix(1, 9) = "Original":     Grilla.ColWidth(9) = 2100
   'Grilla.TextMatrix(0, 10) = "Operador": Grilla.TextMatrix(1, 10) = "":            Grilla.ColWidth(10) = 1500
   'Grilla.TextMatrix(0, 11) = "Codigo":   Grilla.TextMatrix(1, 11) = "Producto":    Grilla.ColWidth(11) = 0
   'Grilla.TextMatrix(0, 12) = "Rut":      Grilla.TextMatrix(1, 12) = "Cartera":     Grilla.ColWidth(12) = 0
   'Grilla.TextMatrix(0, 13) = "Marca":    Grilla.TextMatrix(1, 13) = "Aprobacion":  Grilla.ColWidth(13) = 0
   'Grilla.TextMatrix(0, 14) = "Digitador": Grilla.TextMatrix(1, 14) = "":           Grilla.ColWidth(14) = 1500
    With Grilla
        .TextMatrix(0, iColSistema) = "Sistema"
        .TextMatrix(1, iColSistema) = ""
        .TextMatrix(0, iColTipProducto) = "Tipo"
        .TextMatrix(1, iColTipProducto) = "Producto"
        .TextMatrix(0, iColNumOperacion) = "Número"
        .TextMatrix(1, iColNumOperacion) = "Operación"
        .TextMatrix(0, iColNomCliente) = "Nombre"
        .TextMatrix(1, iColNomCliente) = "Cliente"
        .TextMatrix(0, iColFirOper) = "Firma"
        .TextMatrix(1, iColFirOper) = "Oper."
        .TextMatrix(0, iColFirSup1) = "Firma"
        .TextMatrix(1, iColFirSup1) = "Sup.1"
        .TextMatrix(0, iColFirSup2) = "Firma"
        .TextMatrix(1, iColFirSup2) = "Sup.2"
        .TextMatrix(0, iColVacio) = ""
        .TextMatrix(1, iColVacio) = ""
        .TextMatrix(0, iColMoneda) = "Moneda"
        .TextMatrix(1, iColMoneda) = ""
        .TextMatrix(0, iColMonOriginal) = "Monto"
        .TextMatrix(1, iColMonOriginal) = "Original"
        .TextMatrix(0, iColOperador) = "Operador"
        .TextMatrix(1, iColOperador) = ""
        .TextMatrix(0, iColCodProducto) = "Codigo"
        .TextMatrix(1, iColCodProducto) = "Producto"
        .TextMatrix(0, iColRutCartera) = "Rut"
        .TextMatrix(1, iColRutCartera) = "Cartera"
        .TextMatrix(0, iColMarAprobacion) = "Marca"
        .TextMatrix(1, iColMarAprobacion) = "Aprobacion":
        .TextMatrix(0, iColDigitador) = "Digitador"
        .TextMatrix(1, iColDigitador) = ""
        .TextMatrix(0, iColNumeroIDD) = "Número IDD"
        .TextMatrix(1, iColNumeroIDD) = ""
        .TextMatrix(0, iColCorrelativo) = "Correlativo"
        .TextMatrix(1, iColCorrelativo) = ""
        .TextMatrix(0, iColAfectaLinea) = "Flag Afecta Linea"
        .TextMatrix(1, iColAfectaLinea) = ""
        .TextMatrix(0, iColLineaEspecial) = "Línea"
        .TextMatrix(1, iColLineaEspecial) = "Especial"
        
        .ColWidth(iColSistema) = 850
        .ColWidth(iColTipProducto) = 3000
        .ColWidth(iColNumOperacion) = 1000
        .ColWidth(iColNomCliente) = 3500
        .ColAlignment(iColNomCliente) = flexAlignLeftCenter
        .ColWidth(iColFirOper) = 1100
        .ColAlignment(iColFirOper) = flexAlignCenterCenter
        .ColWidth(iColFirSup1) = 1100
        .ColAlignment(iColFirSup1) = flexAlignCenterCenter
        .ColWidth(iColFirSup2) = 1100
        .ColAlignment(iColFirSup2) = flexAlignCenterCenter
        .ColWidth(iColVacio) = 0
        .ColWidth(iColMoneda) = 800
        .ColWidth(iColMonOriginal) = 2100
        .ColWidth(iColOperador) = 1500
        .ColWidth(iColCodProducto) = 0
        .ColWidth(iColRutCartera) = 0
        .ColWidth(iColMarAprobacion) = 0
        .ColWidth(iColDigitador) = 1500
        .ColWidth(iColNumeroIDD) = 1500
        .ColWidth(iColCorrelativo) = 1500
        .ColWidth(iColAfectaLinea) = 0
        .ColWidth(iColLineaEspecial) = 1500
    End With
   '--- cvegasan 2017.08.01 Control Lineas IDD
   Grilla.RowHeightMin = 370
   Grilla.Rows = Grilla.FixedRows
   Grilla.Enabled = False
   Grilla.RowHeightMin = 250
   
  'Call Formato_Grilla(grilla)
   
   Grilla.FocusRect = flexFocusLight
End Sub

Private Function SettingGridError(ByRef oGrilla As MSFlexGrid)
    '--> +++ cvegasan 2017.08.01 Control Lineas IDD
    oGrilla.Clear
    '--< --- cvegasan 2017.08.01 Control Lineas IDD
    oGrilla.Rows = 2:       oGrilla.Cols = 2
    oGrilla.FixedRows = 1:  oGrilla.FixedCols = 0
    
    oGrilla.TextMatrix(0, 0) = "MENSAJE":        oGrilla.ColWidth(0) = 10820
    oGrilla.TextMatrix(0, 1) = "":               oGrilla.ColWidth(1) = 0
    oGrilla.FocusRect = flexFocusLight
    oGrilla.RowHeightMin = 250
    oGrilla.Enabled = True
    
End Function


Sub LlenarGrilla_Error()
    
    Call SettingGridError(Me.Grilla_Error)
    Call SettingGridError(Me.Grilla_ErrLim)
    Call SettingGridError(Me.Grilla_ErrTasa)
    Call SettingGridError(Me.Grilla_ErrGrp)
    Call SettingGridError(Me.GrillaThreshold)
    Call SettingGridError(Me.Grilla_ErrorPrec)
    Call SettingGridError(Me.grillaBloqCli)

    '-> LD1_035
    Let Grilla_ErrLimPer.Rows = 3:                      Let Grilla_ErrLimPer.Cols = 2
    Let Grilla_ErrLimPer.FixedCols = 0:                 Let Grilla_ErrLimPer.FixedRows = 1
    Let Grilla_ErrLimPer.TextMatrix(0, 0) = "Id:":      Let Grilla_ErrLimPer.ColWidth(0) = 0
    Let Grilla_ErrLimPer.TextMatrix(0, 1) = "Error:":   Let Grilla_ErrLimPer.ColWidth(1) = 14000
    Let Grilla_ErrLimPer.Font.Name = "Tahoma":          Let Grilla_ErrLimPer.Font.Size = 8
    Let Grilla_ErrLimPer.Rows = Grilla_ErrLimPer.FixedRows
    Let Grilla_ErrLimPer.FocusRect = flexFocusLight
    Let Grilla_ErrLimPer.RowHeightMin = 250
    Let Grilla_ErrLimPer.Enabled = True
    '-> LD1_035

    '+++CONTROL IDD, jcamposd solo debe mostrar a usuario aprueba linea
    If ApruebaLinea = 0 Then
        Let SSTab1.TabCaption(0) = "LINEAS (0)"
    Else
    '---CONTROL IDD, jcamposd solo debe mostrar a usuario aprueba linea
    Let SSTab1.TabCaption(1) = "LIMITES (0)"
    Let SSTab1.TabCaption(2) = "TASAS (0)"
    Let SSTab1.TabCaption(3) = "CONSOLIDADOS (0)"
    Let SSTab1.TabCaption(4) = "MENSAJES THRESHOLD ( 0 )"
    Let SSTab1.TabCaption(7) = "LIMITE DE PERMANENCIA ( 0 )"     '--> LD1_035
    
    If modoOperacionCPT = "N" Then   'PRD-3860, modo silencioso
        SSTab1.TabCaption(6) = "PRECIOS y TASAS (0)"
        SSTab1.TabCaption(5) = "BLOQUEO CLIENTES (0)"
    Else
        SSTab1.TabCaption(5) = "BLOQUEO CLIENTES (0)"
    End If
    End If '+++CONTROL IDD, jcamposd, solo debe buscar linea si el perfir del usuario conectado lo amerita
End Sub

'PRD 19111 INI
Private Function Valida_hora() As Boolean

   Dim Datos()
   Dim horaMaxima As String
   Dim horaMinima As String
   Dim hora As Variant
   
   Valida_hora = False
   If Not Bac_Sql_Execute("BDBOMESA.DBO.COMDER_ValidaHoraComDer") Then
        Exit Function
  End If

If Bac_SQL_Fetch(Datos()) Then
    Valida_hora = Datos(1)
End If
End Function
'PRD 19111 FIN

Private Sub AprobacionOperaciones()
   On Error GoTo ErrorAprobacion
   Dim iContador  As Long
   Dim cSistema   As String
   Dim iNumero    As Double
   Dim ocolOperacion   As New Collection
   Dim vNumero
   
   'Variables para comder
   Dim numope As Integer
   Dim monedaOrigen As String
   Dim montoOrigen As Double
   Dim FechaProceso As Date
   Dim Rut As String
   Dim CodCliente As Integer
   Dim tipoMensaje As String
   Dim TipoProducto As Integer
   Dim TipoOperacion As String
   Dim EstadoOperComder As Integer
   Dim MensajeHorarioComder As String
   Dim ServicioActivo As Integer
   Dim MensajeServicioComder As String
   Dim Datos()
   
  
   
   If MsgBox("Control de Aprobaciones" & vbCrLf & vbCrLf & "¿Está seguro que desea aprobar las operaciones seleccionadas?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
      Exit Sub
   End If
   
   MensajeHorarioComder = ""
   MensajeServicioComder = ""
    
    '+++jcamposd 2018.05.11 control IDD
    If ApruebaLinea = 0 Then
        '+++ cvegasan 2017.08.01 Control Lineas IDD
        ' Filtra las operaciones seleccionadas para grabación
        arrDatosAGrabar = fnSeleccionaRegistrosParaGrabar(arrDatosGrilla())
        '+++ cvegasan 2018.03.15 Control Lineas IDD
         If EstaArrayVacio(arrDatosAGrabar()) Then
            '+++ cvegasan 2018.04.19 Control Lineas IDD Se cambia mensaje
            'MsgBox "No existen registros seleccionados para APROBACIÓN", vbCritical, TITSISTEMA
            MsgBox "Existen operaciones sin seleccionar o sin número IDD, por favor revisar", vbCritical, TITSISTEMA
            '--- cvegasan 2018.04.19 Control Lineas IDD Se cambia mensaje
           Exit Sub
         End If
        '--- cvegasan 2018.03.15 Control Lineas IDD
    End If
    '---jcamposd 2018.05.11 control IDD
    
    '+++jcamposd 2018.04.03 control IDD
    If ApruebaLinea = 0 Then
        'Actualizacion Numero IDD para operaciones seleccionadas
        Call prActualizaNumeroIddTablaTransaccionesIdd(arrDatosAGrabar())
    End If
    '---jcamposd 2018.04.03 control IDD
    
    '--- cvegasan 2017.08.01 Control Lineas IDD
   For iContador = 2 To Grilla.Rows - 1
        '+++ cvegasan 2017.08.01 Control Lineas IDD
        'If Grilla.TextMatrix(iContador, 13) = "SI" Then
        If Grilla.TextMatrix(iContador, iColMarAprobacion) = "SI" Then
        
         'cSistema = Grilla.TextMatrix(iContador, 0)
         'iNumero = CDbl(Grilla.TextMatrix(iContador, 2))
         cSistema = Grilla.TextMatrix(iContador, iColSistema)
         iNumero = CDbl(Grilla.TextMatrix(iContador, iColNumOperacion))
         lNumeroIdd = Grilla.TextMatrix(iContador, iColNumeroIDD)
       
        If ApruebaLinea = 0 Then '0 = Aprueba / 1 = NO Aprueba
            ' Verificar perfil si afecta linea valida IDD<>0 de lo
            ' contrario envia mensaje y continua
            If lNumeroIdd = 0 Then
                GoTo NoGrabaNumeroIddCero 'Si numero IDD es Cero, deja pendiente y continúa el proceso
            End If
        End If
        '+++jcamposd 2018.04.03 se comenta ya que debe aprobar limites y lineas
        ' Pregunta si la operacion afecta o no línea
        '''If fnVerificaNoAfectaEnGrilla(cSistema, CLng(iNumero), arrDatosAGrabar, Grilla) = False Then
        '--- cvegasan 2017.08.01 Control Lineas IDD
        
            '
            '   Si la operacion es una operacion MX-CLP esta funcion retornara los numeros de operaciones
            '   relacionadas, sino, retorna un numero de operacion unico
            '
            Set ocolOperacion = ObtenerOperacionesRelacionadas(iNumero, cSistema)
            
            Call Bac_Sql_Execute("BEGIN TRANSACTION")
            Call BacControlWindows(5)
            
            ' PROD-19111 ini
             EstadoOperComder = 0
             ServicioActivo = 1
             Envia = Array()
             AddParam Envia, iNumero
             AddParam Envia, cSistema
            If Not Bac_Sql_Execute("BDBOMESA.DBO.COMDER_EstadoOperacion", Envia) Then
                MsgBox ("Error busca estado operacion")
            End If
            
            If Bac_SQL_Fetch(Datos()) Then
                EstadoOperComder = Datos(1)
                ServicioActivo = Datos(4)
            End If
        
            '--> Valida si es operacion Comder
            If EstadoOperComder = 1 Then
            
                'COC-23-07-2014
                If ServicioActivo = 0 Then
                    MensajeServicioComder = "El Servicio de Monitoreo de Operaciones ComDer se encuentra detenido." & vbCrLf & "No es posible continuar con el proceso." & vbCrLf & "Contacte a su Soporte Tecnico."
                Else
                    'COMDER PRD19110 11/06/2014
                    If Not Valida_hora Then
                       MensajeHorarioComder = "Envío a ComDer Fuera de Horario de Operación."
                    Else
                    
                        For Each vNumero In ocolOperacion
                          Envia = Array()
                          AddParam Envia, gsBAC_User
                          AddParam Envia, cSistema
                          AddParam Envia, vNumero
                          'idd
                          'corre
                          
                          If Not Bac_Sql_Execute("SP_CONTROL_APROBACION", Envia) Then
                             GoTo ErrorAprobacion
                          End If
                        Next
                         'Envia operacion a Monitor una vez que este aprobada - INI
                          If Bac_SQL_Fetch(Datos()) Then
                             If Datos(1) = "A" Then
                                   '+++ cvegasan 2017.08.01 Control Lineas IDD
                                   'monedaOrigen = Me.Grilla.TextMatrix(iContador, 8)
                                   'montoOrigen = Me.Grilla.TextMatrix(iContador, 9)
                                    monedaOrigen = Me.Grilla.TextMatrix(iContador, iColMoneda)
                                    montoOrigen = Me.Grilla.TextMatrix(iContador, iColMonOriginal)
                                   '--- cvegasan 2017.08.01 Control Lineas IDD
                                 If valida_comder_mfca Then  'SWICH ACTIVA COMDER
                                     If valida_operacion_comder(CLng(iNumero), cSistema) Then
                                        '+++ cvegasan 2017.08.01 Control Lineas IDD
                                        ' monedaOrigen = Me.Grilla.TextMatrix(iContador, 8)
                                        ' montoOrigen = Me.Grilla.TextMatrix(iContador, 9)
                                            monedaOrigen = Me.Grilla.TextMatrix(iContador, iColMoneda)
                                            montoOrigen = Me.Grilla.TextMatrix(iContador, iColMonOriginal)
                                        '--- cvegasan 2017.08.01 Control Lineas IDD
                                         FechaProceso = gsBAC_Fecp
                                         Rut = RutComder & Me.Rdv
                                         TipoProducto = Me.TipoProductoComder
                                         TipoOperacion = Me.TipoOperacionComder
                                         CodCliente = CodigoClienteComder
                                         Call envia_comder_monitor(CLng(iNumero), cSistema, monedaOrigen, Format(montoOrigen, FDecimal), FechaProceso, FechaProceso, Rut, CodCliente, "N", Me.TipoProductoComder, TipoOperacionComder)
                                     End If
                                 End If
                             End If
                          End If
                         'Envia operacion a Monitor una vez que este aprobada - FIN
                        
                        End If
                End If
                'COC-23-07-2014
                    
            Else
                For Each vNumero In ocolOperacion
                  Envia = Array()
                  AddParam Envia, gsBAC_User
                  AddParam Envia, cSistema
                  AddParam Envia, vNumero
                  If Not Bac_Sql_Execute("SP_CONTROL_APROBACION", Envia) Then
                     GoTo ErrorAprobacion
                  End If
                Next
         End If
       ' PROD-19111 fin
                 
         Call Bac_Sql_Execute("COMMIT TRANSACTION")
         '+++ cvegasan 2017.08.01 Control Lineas IDD
         ''''End If '+++jcamposd 2018.04.03 se comenta ya que debe aprobar limites
         '--- cvegasan 2017.08.01 Control Lineas IDD
      End If
NoGrabaNumeroIddCero:
   Next iContador
   
   'COMDER PRD-19111
   If MensajeServicioComder <> "" Then
        MsgBox MensajeServicioComder, vbExclamation, TITSISTEMA
   End If
   If MensajeHorarioComder <> "" Then
        MsgBox "Envío a ComDer Fuera de Horario de Operación.", vbExclamation, TITSISTEMA
   End If
   'COMDER PRD-19111
      
   Call RefrescarDatos
   
Exit Sub
ErrorAprobacion:
   Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
   MsgBox "Error..." & vbCrLf & "Ha ocurrido un error al tratar de aprobar operaciones." & vbcrl & "Sistema:" & cSistema & "; Numero Operación :" & iNumero, vbCritical, TITSISTEMA
End Sub

'ARM PRD 19110
Function valida_comder_mfca() As Boolean

Dim Datos()
valida_comder_mfca = False

 Envia = Array()
        
        
         If Not Bac_Sql_Execute("bdbomesa..COMDER_Valida_Comder_MFCA") Then
          '  GoTo operacion_comder
          Exit Function
         End If
         
        If Bac_SQL_Fetch(Datos()) Then
           If Datos(1) = "S" Then
               valida_comder_mfca = True
           End If
        End If

End Function
'ARM PRD 19110
Function valida_operacion_comder(numero As Long, Sistema As String) As Boolean
Dim Datos()

valida_operacion_comder = False

 Envia = Array()
        
         AddParam Envia, numero
         AddParam Envia, Sistema
         If Not Bac_Sql_Execute("bdbomesa..COMDER_Valida_Operacion_Comder", Envia) Then
          '  GoTo operacion_comder
          Exit Function
         End If
         
        If Bac_SQL_Fetch(Datos()) Then
           If Datos(1) = 1 Then
              'MsgBox "problemas al Controlar Limites del Operador" & vbCrLf & Datos(2), vbCritical
               RutComder = Datos(2)
               CodigoClienteComder = Datos(4)
               Me.Rdv = Datos(3)
               
               Me.TipoOperacionComder = Datos(5)
               Me.TipoProductoComder = Datos(6)
                              
               valida_operacion_comder = True
           
           End If
           
        End If

End Function

Function envia_comder_monitor(numero As Long, Sistema As String, monedaOrigen As String, montoOrigen As Double, FechaProceso As Date, FechaProceso1 As Date, Rut As String, CodCliente As Integer, tipoMensaje As String, TipoProducto As Integer, TipoOperacion As String)

         
       Envia = Array()
        
         AddParam Envia, numero
         AddParam Envia, Sistema
         AddParam Envia, TipoProducto
         AddParam Envia, TipoOperacion
         AddParam Envia, monedaOrigen
         AddParam Envia, montoOrigen
         AddParam Envia, FechaProceso
         AddParam Envia, FechaProceso1
         AddParam Envia, Rut
         AddParam Envia, CodCliente
         AddParam Envia, tipoMensaje
         
         If Not Bac_Sql_Execute("bdbomesa..COMDER_InsertaSolicitud", Envia) Then
          '  GoTo operacion_comder
          Exit Function
         End If
   
       
       
End Function


Function ObtenerOperacionesRelacionadas(nNumeroOperacion As Double, sSistema As String) As Collection
    Dim sSql        As String
    Dim Envia()
    Dim Datos()
    Dim oCol As New Collection
    
        If sSistema <> "BFW" Then
            oCol.Add nNumeroOperacion
            Set ObtenerOperacionesRelacionadas = oCol
            Exit Function
        End If
        
        Envia = Array()
        
        sSql = "baclineas..sp_obtener_operaciones_relacionadas_mxclp"
        AddParam Envia, nNumeroOperacion
        
        If Not Bac_Sql_Execute(sSql, Envia) Then
            Set ObtenerOperacionesRelacionadas = Nothing
            Exit Function
        End If
        
        Do While Bac_SQL_Fetch(Datos())
            oCol.Add Datos(1)
        Loop
        Set ObtenerOperacionesRelacionadas = oCol

End Function
Sub Aprobar_Operacion()
   Dim Datos()
   Dim indice           As Long
   Dim cMensaje         As String
   Dim sApruebaLineas   As String
   Dim sApruebaLimites  As String
   Dim sApruebaTasas    As String
   Dim sApruebaGrupos   As String
   Dim sApruebaPrecios  As String
   Dim sApruebaBloqueos As String   'nuevo, PRD-6066
   Dim nMontoLineas     As String
   Dim sControlLineas   As String
   Dim sControlLimites  As String
   Dim sControlTasas    As String
   Dim sControlGrupos   As String
   Dim sControlPrecios  As String
   Dim sControlBloqueos As String   'nuevo, PRD-6066

   On Error Resume Next

   If Sw_Sel = 0 Then
      MsgBox "Seleccione una Operación", vbInformation, TITSISTEMA
      If Grilla.Enabled Then
         Grilla.SetFocus
      End If
      Exit Sub
   End If

   If MsgBox("Control de Aprobaciones" & vbCrLf & vbCrLf & "¿Está seguro que desea aprobar las operaciones seleccionadas?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
      Exit Sub
   End If
    '+++ cvegasan 2017.08.01 Control Lineas IDD
   'If Grilla.Rows = 2 Or Not IsNumeric(Grilla.TextMatrix(Grilla.Row, 2)) Then
   '   Exit Sub
   'End If
    If Grilla.Rows = 2 Or Not IsNumeric(Grilla.TextMatrix(Grilla.Row, iColNumOperacion)) Then
      Exit Sub
   End If
    '--- cvegasan 2017.08.01 Control Lineas IDD
   
   Envia = Array()
   AddParam Envia, gsBAC_User
   If Not Bac_Sql_Execute("SP_CON_MATRIZ_ATRIBUCION", Envia) Then
        MsgBox "Problemas con Procedimiento 'SP_CON_MATRIZ_ATRIBUCION'", vbCritical, TITSISTEMA
      Exit Sub
   Else
      'Indica Los Privilegios que tiene el Aprobador
      Do While Bac_SQL_Fetch(Datos())
         sApruebaLineas = IIf(Datos(3) = 0, "S", "N")
         sApruebaLimites = IIf(Datos(4) = 0, "S", "N")
         sApruebaTasas = IIf(Datos(5) = 0, "S", "N")
         sApruebaGrupos = IIf(Datos(6) = 0, "S", "N")
         
         If modoOperacionCPT = "N" Then     'PRd-3860, modo silencioso
         sApruebaPrecios = IIf(Datos(7) = 0, "S", "N")  'nuevo
         Else
            sApruebaPrecios = "N"
         End If
            sApruebaBloqueos = IIf(Datos(8) = 0, "S", "N") 'PRD-6066
         
         nMontoLineas = CDbl(Datos(3))
      Loop
   End If
   
   sControlLineas = sApruebaLineas
   sControlLimites = sApruebaLimites
   sControlTasas = sApruebaTasas
   sControlGrupos = sApruebaGrupos
   
   If modoOperacionCPT = "N" Then       'PRD-3860, modo silencioso
   sControlPrecios = sApruebaPrecios    'nuevo
   Else
        sControlPrecios = "N"
   End If
    sControlBloqueos = sApruebaBloqueos
   
   indice = Grilla.Row
            
   '--> Multi Aprobacion de Lineas.
   Dim iContador  As Long
   
   cMensaje = ""
   
   For iContador = 2 To Grilla.Rows - 1
      '--> Control de Marca para Aprobación
      '+++ cvegasan 2017.08.01 Control Lineas IDD
      'If Grilla.TextMatrix(iContador, 13) = "SI" Then
      If Grilla.TextMatrix(iContador, iColMarAprobacion) = "SI" Then
      '--- cvegasan 2017.08.01 Control Lineas IDD
         Grilla.Row = iContador
         Call Grilla_Click

         Call BacControlWindows(1)
        '+++ cvegasan 2017.08.01 Control Lineas IDD
         'cSistema = Grilla.TextMatrix(iContador, 0)
         'nNumoper = CDbl(Grilla.TextMatrix(iContador, 2))
        cSistema = Grilla.TextMatrix(iContador, iColSistema)
        nNumoper = CDbl(Grilla.TextMatrix(iContador, iColNumOperacion))
        '--- cvegasan 2017.08.01 Control Lineas IDD
         cMensaje = cMensaje & "Operación N°: " & nNumoper & " Sistemas : " & cSistema & vbCrLf
      
         'Chequeo Limites Tasas Solo cuando Hay Error de Limites
         If Grilla_ErrTasa.Row = 0 Then
            sApruebaTasas = "S"
         End If
         
         'Chequeo Limites Consolidados Solo cuando Hay Error de Limites
         If Grilla_ErrGrp.Row = 0 Then
            sApruebaGrupos = "S"
         End If
         
         'Chequeo Lineas Solo cuando Hay Error de Limites
         If Grilla_Error.Row = 0 Then
            sApruebaLineas = "S"
         End If

         If modoOperacionCPT = "N" Then     'PRD-3860, modo silencioso
        'Chequeo Precios solo cuando hay Error de Precios
         If Grilla_ErrorPrec.Row = 0 Then
            sApruebaPrecios = "S"
         End If
         Else
                sApruebaPrecios = "N"
         End If
         
            'PRD-6066
            If grillaBloqCli.Row = 0 Then
                sApruebaBloqueos = "S"
            End If
            'fin PRD-6066

         If sApruebaLimites = "S" Then
            Envia = Array()
            AddParam Envia, cSistema
            AddParam Envia, nNumoper
            AddParam Envia, gsBAC_User
            AddParam Envia, "M"
            If Bac_Sql_Execute("SP_LIMITES_RECHEQUEAR", Envia) Then
               If Bac_SQL_Fetch(Datos()) Then
                  If Datos(1) = "NO" Then
                    'MsgBox "problemas al Controlar Limites del Operador" & vbCrLf & Datos(2), vbCritical
                     sApruebaLimites = "N"
                     nError = 2
                  End If
               End If
            Else
              'MsgBox "problemas al ejecutar procedimiento", vbCritical
               sApruebaLimites = "N"
               nError = 2
            End If
         End If
               
         Envia = Array()
         AddParam Envia, gsBAC_Fecp
         AddParam Envia, cSistema
         AddParam Envia, nNumoper
         AddParam Envia, gsBAC_User
         AddParam Envia, sApruebaLimites
         AddParam Envia, sApruebaLineas
         AddParam Envia, sApruebaTasas
         AddParam Envia, sApruebaGrupos
         AddParam Envia, sApruebaPrecios    'nuevo
            AddParam Envia, sApruebaBloqueos    'Nuevo, PRD-6066
         If Not Bac_Sql_Execute("SP_LINEAS_AUTORIZA", Envia) Then
            If Not BacRollBackTransaction Then
               MsgBox "Problemas de comunicación con el Servidor" & vbCrLf & "No se pudo aprobar la operación.", vbCritical, TITSISTEMA
            End If
            Exit Sub
         End If
         Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "A" Then
              'MsgBox "Operación Aprobada Correctamente", vbInformation, TITSISTEMA
               nError = 1
            Else
               If Datos(1) = "F" Then
                 'MsgBox "Operación aprobada correctamente, pero requiere de Firma Final", vbInformation, TITSISTEMA
                  nError = 3
               Else
                 'MsgBox "No Puede Aprobar Operación, No Tiene Atributos", vbInformation, TITSISTEMA
                  nError = 2
               End If
            End If
         Loop
      End If '--> Control de Marca para Aprobación
   
      sApruebaLineas = sControlLineas
      sApruebaLimites = sControlLimites
      sApruebaTasas = sControlTasas
      sApruebaGrupos = sControlGrupos
      
      If modoOperacionCPT = "N" Then
      sApruebaPrecios = sControlPrecios 'nuevo
      Else
            sApruebaPrecios = "N"
      End If
        sApruebaBloqueos = sControlBloqueos     'PRD-6066
      
   Next iContador
   
  'MsgBox "Operaciones Aprobadas Correctamente. " & vbCrLf & vbCrLf & cMensaje, vbInformation, TITSISTEMA
   
   Grilla.Rows = 2
   Grilla.Rows = 3
   Call BacControlWindows(50)
   
   Call CargarGrilla

End Sub

Sub CargarGrilla(Optional SwCarga As Boolean)
    On Error Resume Next
    Dim SqlDatos()
    Dim PosicionActual  As Long
    Dim indice          As Long
    '+++ cvegasan 2017.08.01 Control Lineas IDD
    Dim iCol As Integer
    '--- cvegasan 2017.08.01 Control Lineas IDD
    Envia = Array()
    AddParam Envia, Format(gsBAC_Fecp, FeFecha)
    AddParam Envia, gsBAC_User
    If Mid(Trim(Cmb_Modulo), 1, 11) = "<< TODOS >>" Then
        AddParam Envia, " "
    Else
        AddParam Envia, Trim(Mid(Cmb_Modulo, InStr(1, Cmb_Modulo, "CODIGO") + Len("CODIGO"), 70))
    End If
   
    If Mid(Trim(Cmb_T_Operacion), 1, 11) = "<< TODOS >>" Or Mid(Trim(Cmb_T_Operacion), 1, 11) = "<< TODAS >>" Then
        AddParam Envia, " "
    Else
        AddParam Envia, Trim(Left(Cmb_T_Operacion, 30))
    End If

    AddParam Envia, Trim(Mid(Cmb_Usuarios, InStr(1, Cmb_Usuarios, "CODIGO") + Len("CODIGO"), 70))
    AddParam Envia, Trim(Mid(Cmb_Monedas, InStr(1, Cmb_Monedas, "CODIGO") + Len("CODIGO"), 70))
    AddParam Envia, Trim(Mid(Cmb_Digitador, InStr(1, Cmb_Digitador, "CODIGO") + Len("CODIGO"), 70))
    '+++CONTROL IDD, jcamposd, nuevo parametro que indica si visualiza línea
    AddParam Envia, ApruebaLinea
    '---CONTROL IDD, jcamposd, nuevo parametro que indica si visualiza línea
    If Not Bac_Sql_Execute("SP_FILTRO_OPERACIONES_PENDIENTES", Envia) Then
        MsgBox "Problemas en la Consulta", vbExclamation, TITSISTEMA
        Exit Sub
    End If
   
'    Grilla.Redraw = False
'    Grilla.Rows = Grilla.FixedRows
    
    SwCarga = False
    
    Do While Bac_SQL_Fetch(SqlDatos())
      SwCarga = True
      Grilla.Rows = Grilla.Rows + 1
        '+++ cvegasan 2017.08.01 Control Lineas IDD
        'Grilla.TextMatrix(Grilla.Rows - 1, 0) = SqlDatos(1)                          'Identificacion sistema
        'Grilla.TextMatrix(Grilla.Rows - 1, 1) = SqlDatos(3)                          'Producto
        'Grilla.TextMatrix(Grilla.Rows - 1, 2) = SqlDatos(4)                          ''Format(datos(4), FEntero)         'Numoper
        'Grilla.TextMatrix(Grilla.Rows - 1, 3) = SqlDatos(5)                          'Cliente
        'Grilla.TextMatrix(Grilla.Rows - 1, 4) = SqlDatos(12)
        Grilla.TextMatrix(Grilla.Rows - 1, iColSistema) = SqlDatos(1)                          'Identificacion sistema
        Grilla.TextMatrix(Grilla.Rows - 1, iColTipProducto) = SqlDatos(3)                          'Producto
        Grilla.TextMatrix(Grilla.Rows - 1, iColNumOperacion) = SqlDatos(4)                          ''Format(datos(4), FEntero)         'Numoper
        Grilla.TextMatrix(Grilla.Rows - 1, iColNomCliente) = SqlDatos(5)                          'Cliente
        Grilla.TextMatrix(Grilla.Rows - 1, iColFirOper) = SqlDatos(12)
        
        If SqlDatos(12) = "FALTA" Then
         'Grilla.Row = Grilla.Rows - 1: Grilla.Col = 4: Grilla.CellForeColor = &HFF&
         Grilla.Row = Grilla.Rows - 1: Grilla.Col = iColFirOper: Grilla.CellForeColor = &HFF&
        End If
        'Grilla.TextMatrix(Grilla.Rows - 1, 5) = SqlDatos(13)
        Grilla.TextMatrix(Grilla.Rows - 1, iColFirSup1) = SqlDatos(13)
        If SqlDatos(13) = "FALTA" Then
         'Grilla.Row = Grilla.Rows - 1: Grilla.Col = 5: Grilla.CellForeColor = &HFF&
         Grilla.Row = Grilla.Rows - 1: Grilla.Col = iColFirSup1: Grilla.CellForeColor = &HFF&
        End If
        'Grilla.TextMatrix(Grilla.Rows - 1, 6) = SqlDatos(14)
        Grilla.TextMatrix(Grilla.Rows - 1, iColFirSup2) = SqlDatos(14)
        If SqlDatos(14) = "FALTA" Then
         'Grilla.Row = Grilla.Rows - 1: Grilla.Col = 6: Grilla.CellForeColor = &HFF&
         Grilla.Row = Grilla.Rows - 1: Grilla.Col = iColFirSup2: Grilla.CellForeColor = &HFF&
        End If
        
        'Grilla.TextMatrix(Grilla.Rows - 1, 8) = SqlDatos(6)
        'Grilla.TextMatrix(Grilla.Rows - 1, 9) = Format(SqlDatos(7), IIf(SqlDatos(6) = "$", FEntero, FDecimal)) 'Monto
 
        'Grilla.TextMatrix(Grilla.Rows - 1, 10) = SqlDatos(8)                                                'Operador
        'Grilla.TextMatrix(Grilla.Rows - 1, 11) = SqlDatos(10)                                               'codigo producto
        'Grilla.TextMatrix(Grilla.Rows - 1, 12) = SqlDatos(11)                                               'Rut Cartera
        'Grilla.TextMatrix(Grilla.Rows - 1, 13) = "NO"                                                    'Marca Aprobacion
      
        'Grilla.TextMatrix(Grilla.Rows - 1, 14) = SqlDatos(17)
        
        'Grilla.TextMatrix(Grilla.Rows - 1, 15) = SqlDatos(18) ' Numero_IDD
        'Grilla.TextMatrix(Grilla.Rows - 1, 16) = SqlDatos(19) ' Correlativo
        'Grilla.TextMatrix(Grilla.Rows - 1, 17) = SqlDatos(20) ' Afecta Línea
        'Grilla.TextMatrix(Grilla.Rows - 1, 18) = SqlDatos(21) ' Linea Especial (Check)
        Grilla.TextMatrix(Grilla.Rows - 1, iColMoneda) = SqlDatos(6)
        Grilla.TextMatrix(Grilla.Rows - 1, iColMonOriginal) = Format(SqlDatos(7), IIf(SqlDatos(6) = "$", FEntero, FDecimal)) 'Monto
 
        Grilla.TextMatrix(Grilla.Rows - 1, iColOperador) = SqlDatos(8)                                                'Operador
        Grilla.TextMatrix(Grilla.Rows - 1, iColCodProducto) = SqlDatos(10)                                               'codigo producto
        Grilla.TextMatrix(Grilla.Rows - 1, iColRutCartera) = SqlDatos(11)                                               'Rut Cartera
        Grilla.TextMatrix(Grilla.Rows - 1, iColMarAprobacion) = "NO"                                                    'Marca Aprobacion
      
        Grilla.TextMatrix(Grilla.Rows - 1, iColDigitador) = SqlDatos(17)
        
        Grilla.TextMatrix(Grilla.Rows - 1, iColNumeroIDD) = SqlDatos(18) ' Numero_IDD
        Grilla.TextMatrix(Grilla.Rows - 1, iColCorrelativo) = SqlDatos(19) ' Correlativo
        Grilla.TextMatrix(Grilla.Rows - 1, iColAfectaLinea) = SqlDatos(20) ' Afecta Línea
        Grilla.TextMatrix(Grilla.Rows - 1, iColLineaEspecial) = SqlDatos(21) ' Linea Especial (Check)
        '--- cvegasan 2017.08.01 Control Lineas IDD
   Loop
   
   'prd 19111 ini
    If valida_comder_mfca Then   'SWICH ACTIVA COMDER
        Dim Operacion As String
        Dim Sistema As String
        Dim i As Integer
        i = 1
        Do While i < Grilla.Rows
             '+++ cvegasan 2017.08.01 Control Lineas IDD
            'Operacion = Grilla.TextMatrix(i + 1, 2)
            'Sistema = Grilla.TextMatrix(i + 1, 0)
            Operacion = Grilla.TextMatrix(i + 1, iColNumOperacion)
            Sistema = Grilla.TextMatrix(i + 1, iColSistema)
             '--- cvegasan 2017.08.01 Control Lineas IDD
                
            If BuscaComder(Operacion, Sistema) = "SI" Then
                Grilla.Row = i + 1

                '+++ cvegasan 2017.08.01 Control Lineas IDD
                'Grilla.Col = 0:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 1:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 2:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 3:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 4:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 5:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 6:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 7:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 8:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 9:     Grilla.CellBackColor = vbCyan
                'Grilla.Col = 10:    Grilla.CellBackColor = vbCyan
                'Grilla.Col = 11:    Grilla.CellBackColor = vbCyan
                'Grilla.Col = 12:    Grilla.CellBackColor = vbCyan
                
                For iCol = 0 To Grilla.Cols - 1
                    Grilla.Col = iCol: Grilla.CellBackColor = vbCyan
                Next iCol
                '--- cvegasan 2017.08.01 Control Lineas IDD
            End If
            i = i + 1
        Loop
    End If
    'prd19111 fin
      
    If SwCarga = False Then
        MsgBox "No Existe Información", vbExclamation, TITSISTEMA
        Toolbar1.Buttons(1).Enabled = False
        Toolbar1.Buttons(2).Enabled = False
        Toolbar1.Buttons(3).Enabled = True
        
        Grilla.Enabled = False
        Grilla.Redraw = True
        
       'Call LlenarGrilla_Error
        Call CargarGrilla_Error
        Call CargarGrilla_Error_Limites
        Call CargarGrilla_Error_Tasas
        Call CargarGrilla_Error_Grupos
        Call CargarGrilla_ErrLimPerm        '-> LD1_035
        
        If modoOperacionCPT = "N" Then    'PRD-3860, si es normal, mostrar
            Call CargarGrilla_Error_Precios  'nuevo
        End If
        CargarGrilla_Bloq_Clientes    'nuevo, PRD-6066
    
    Else
        Grilla.Redraw = True
        Grilla.Row = Grilla.FixedRows
         '+++ cvegasan 2017.08.01 Control Lineas IDD
        'Grilla.Col = 1
        Grilla.Col = iColTipProducto
         '--- cvegasan 2017.08.01 Control Lineas IDD
        Grilla.Enabled = True
        Grilla.FocusRect = flexFocusNone
        
        Sw_Sel = 0
         '+++ cvegasan 2017.08.01 Control Lineas IDD
        'Grilla.Col = 0
        Grilla.Col = iColSistema
         '--- cvegasan 2017.08.01 Control Lineas IDD
           
       'Call LlenarGrilla_Error
       
        
        If ApruebaLinea = 0 Then '+++CONTROL IDD, jcamposd, solo debe buscar linea si el perfir del usuario conectado lo amerita
            Call CargarGrilla_Error
        Else '+++CONTROL IDD, jcamposd, solo debe buscar linea si el perfir del usuario conectado lo amerita
            Call CargarGrilla_Error_Limites
            Call CargarGrilla_Error_Tasas
            Call CargarGrilla_Error_Grupos
            Call CargarGrilla_ErrLimPerm        '-> LD1_035
        
            If modoOperacionCPT = "N" Then    'PRD-3860, si es normal, mostrar
                Call CargarGrilla_Error_Precios  'nuevo
            End If
            CargarGrilla_Bloq_Clientes    'nuevo, PRD-6066
        End If '+++CONTROL IDD, jcamposd, solo debe buscar linea si el perfir del usuario conectado lo amerita
        
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
    End If
   
   
   On Error GoTo 0
End Sub

Public Function BuscaComder(numope As String, Sistema As String) As String

Dim EstadoOperComder As Integer
Dim DATOSX()
    
   If LTrim(numope) = "" Or LTrim(Sistema) = "" Then
            BuscaComder = "NO"
            Exit Function
   End If
   
             BuscaComder = "SI"
             EstadoOperComder = 0
             
             Envia = Array()
             AddParam Envia, numope
             AddParam Envia, Sistema
            If Not Bac_Sql_Execute("BDBOMESA.DBO.COMDER_EstadoOperacion", Envia) Then
                MsgBox ("No ha sido posible determinar el estado de la Operación ComDer")
                BuscaComder = "NO"
                Exit Function
            End If
            
            If Bac_SQL_Fetch(DATOSX()) Then
                EstadoOperComder = DATOSX(1)
            End If
            
            '--> Valida si es operacion Comder
            If EstadoOperComder = 0 Then
               BuscaComder = "NO"
            Else
                BuscaComder = "SI"
            End If


    
    
End Function


Private Sub Cmb_Modulo_Click()
    Dim intContador As Integer
        
    intContador = Carga_Listas_Impresion("T_OPERACION", Cmb_T_Operacion, 0)
    Cmb_T_Operacion.AddItem " << TODOS >> " + Space(70) + "CODIGO" + Space(5) + ""
    Cmb_T_Operacion.ItemData(Cmb_T_Operacion.NewIndex) = 0
    Cmb_T_Operacion.tag = "0"
    Cmb_T_Operacion.ListIndex = intContador

  '''Call RefrescarDatos
End Sub


Private Sub Form_Activate()
   Call Privilegios.ACTUALIZADOR(gsBAC_User)

   If Privilegios.objPrivilegios.Monitoreo_Operaciones = 0 Then
      Let Frame1.Enabled = False
      Let Me.Caption = "Monitoreo de operaciones pendientes.- OPCION NO HABILITADA POR PERFILES DE ACCESO A LINEAS."
   Else
      Call Privilegios.CARGAR_SISTEMAS_HABILITADOS(gsBAC_User, Cmb_Modulo, 0)
      
      Let Frame1.Enabled = True
      Let SSTab1.Enabled = True
      Let Me.Caption = "Monitoreo de operaciones pendientes.-"
   End If
   
End Sub

Private Sub Form_Load()
   Dim SqlDatos() '+++CONTROL IDD, jcamposd, solo debe buscar linea si el perfir del usuario conectado lo amerita
   Me.top = 0: Me.Left = 0
    Me.Width = 14380:    Me.Height = 8685
    
   Me.Icon = BacControlFinanciero.Icon
   Me.Caption = "Monitoreo de operaciones pendientes.-"
 
   Me.Tmr_Operaciones.Interval = 1000
   Me.Tmr_Operaciones.Interval = 5000
   

    '+++CONTROL IDD, jcamposd, controlaremos el universo a visualizar según usuario conectado
    ApruebaLinea = fnRetornaParametroMAtrizAtribucion()
    '---CONTROL IDD, jcamposd, controlaremos el universo a visualizar según usuario conectado

   
   
   'PRD-3860, modo silencioso
    Call ConsultaModoOperacionControlPT

    If modoOperacionCPT = "S" Then
        'modo silencioso, no mostrar nada del control de precios y tasas
        SSTab1.TabVisible(6) = False
    Else
        SSTab1.TabVisible(6) = True
    End If

   Call Carga_Combos

   Toolbar1.Buttons(3).Enabled = True

   Call RefrescarDatos(False)
   
   '+++ cvegasan 2017.08.01 Control Lineas IDD - cuenta las operaciones por producto
   Call prAlmacenaRegistrosAgrupados(Grilla)
   '--- cvegasan 2017.08.01 Control Lineas IDD - cuenta las operaciones por producto
End Sub

Private Sub RefrescarDatos(Optional bInicio As Boolean)

    Toolbar1.Buttons(1).Enabled = False  'Aprobar
    Toolbar1.Buttons(2).Enabled = False  'Rechazar
    Toolbar1.Buttons(3).Enabled = False  'Detalle
    
    Call LlenarGrilla           '->     ESTABLECE LOS NOMBRES DE LA GRILLA
    Call LlenarGrilla_Error     '->     ESTABLECE LOS NOMBRES PARA LAS GRILLAS DE LOS ERRORES

    '+++CONTROL IDD, jcamposd, controlaremos el universo a visualizar según usuario conectado
    ApruebaLinea = fnRetornaParametroMAtrizAtribucion()
    '---CONTROL IDD, jcamposd, controlaremos el universo a visualizar según usuario conectado
    
    If bInicio = False Then
        Call CargarGrilla
    End If
    
    
    '+++ cvegasan 2017.08.15 Control Lineas IDD
    Erase arrDatosAGrabar '--Limpia arreglos (vectores)
    Erase arrDatosGrilla '--Limpia arreglos (vectores)
    
    Call prAlmacenaRegistrosAgrupados(Grilla) '--Carga datos actuales de grilla
    '--- cvegasan 2017.08.15 Control Lineas IDD
    
End Sub

Private Function CargaMensajesThrershold()
   Dim MiModulo   As String
   Dim MiContrato As Long
   Dim nMensajes  As Long
   Dim SqlDatos()
   '+++ cvegasan 2017.08.01 Control Lineas IDD
   'MiModulo = Grilla.TextMatrix(Grilla.Row, 0)
   'MiContrato = CDbl(Grilla.TextMatrix(Grilla.Row, 2))
   MiModulo = Grilla.TextMatrix(Grilla.Row, iColSistema)
   MiContrato = CDbl(Grilla.TextMatrix(Grilla.Row, iColNumOperacion))
   '--- cvegasan 2017.08.01 Control Lineas IDD
   Envia = Array()
   AddParam Envia, MiModulo
   AddParam Envia, MiContrato
   If Not Bac_Sql_Execute("dbo.SP_CARGA_MENSAJES_THRESHOLD", Envia) Then
      Exit Function
   End If
   Let GrillaThreshold.Rows = 1
   Let nMensajes = 0
   Do While Bac_SQL_Fetch(SqlDatos())
      Let nMensajes = nMensajes + 1
      Let GrillaThreshold.Rows = GrillaThreshold.Rows + 1
      Let GrillaThreshold.TextMatrix(GrillaThreshold.Rows - 1, 0) = Trim(SqlDatos(2))
      Let GrillaThreshold.ColAlignment(0) = flexAlignLeftCenter
   Loop

   Let SSTab1.TabCaption(4) = "MENSAJES THRESHOLD (" & Trim(nMensajes) & ")"
End Function


Private Sub Form_Resize()
    On Error Resume Next

    Frame1.Left = 0
    Frame1.Width = Me.Width - 150

    SSFrame1.Left = Frame1.Left:                SSFrame1.Width = Frame1.Width
    Grilla.Left = 60:                           Grilla.Width = Frame1.Width - 60

    SSTab1.Left = Frame1.Left:                  SSTab1.Width = Frame1.Width + 150
    SSTab1.Height = Me.Height - 5200

    Grilla_Error.top = 350:                     Grilla_Error.Left = 60:                         Grilla_Error.Width = SSTab1.Width - 150:        Grilla_Error.Height = SSTab1.Height - 750

    Grilla_ErrLim.top = Grilla_Error.top:       Grilla_ErrLim.Left = Grilla_Error.Left:         Grilla_ErrLim.Width = Grilla_Error.Width:       Grilla_ErrLim.Height = Grilla_Error.Height
    Grilla_ErrTasa.top = Grilla_Error.top:      Grilla_ErrTasa.Left = Grilla_Error.Left:        Grilla_ErrTasa.Width = Grilla_Error.Width:      Grilla_ErrTasa.Height = Grilla_Error.Height
    Grilla_ErrGrp.top = Grilla_Error.top:       Grilla_ErrGrp.Left = Grilla_Error.Left:         Grilla_ErrGrp.Width = Grilla_Error.Width:       Grilla_ErrGrp.Height = Grilla_Error.Height
    GrillaThreshold.top = Grilla_Error.top:     GrillaThreshold.Left = Grilla_Error.Left:       GrillaThreshold.Width = Grilla_Error.Width:     GrillaThreshold.Height = Grilla_Error.Height
    grillaBloqCli.top = Grilla_Error.top:       grillaBloqCli.Left = Grilla_Error.Left:         grillaBloqCli.Width = Grilla_Error.Width:       grillaBloqCli.Height = Grilla_Error.Height
    Grilla_ErrorPrec.top = Grilla_Error.top:    Grilla_ErrorPrec.Left = Grilla_Error.Left:      Grilla_ErrorPrec.Width = Grilla_Error.Width:    Grilla_ErrorPrec.Height = Grilla_Error.Height
    Grilla_ErrLimPer.top = Grilla_Error.top:    Grilla_ErrLimPer.Left = Grilla_Error.Left:      Grilla_ErrLimPer.Width = Grilla_Error.Width:    Grilla_ErrLimPer.Height = Grilla_Error.Height

    On Error GoTo 0
End Sub

Private Sub Grilla_Click()
    
Me.Grilla.Enabled = False
Screen.MousePointer = vbHourglass

    Sw_Sel = 1
    '+++ cvegasan 2017.08.01 Control Lineas IDD
    iRowActual = Grilla.Row
    iColActual = Grilla.Col
    '--- cvegasan 2017.08.01 Control Lineas IDD
    Call LlenarGrilla_Error
    Call CargarGrilla_Error
    
'   Call CargarGrilla_Error_Limites
'   Call CargaMensajesThrershold
'   Call CargarGrilla_Error_Precios 'nuevo
'   Call CargarGrilla_Bloq_Clientes 'nuevo, PRD-6066
'   Call CargarGrilla_ErrLimPerm        '-> LD1_035
    
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(3).Enabled = True

    'Marca Aprobación
    '+++ cvegasan 2017.08.01 Control Lineas IDD
    'If Grilla.TextMatrix(Grilla.RowSel, 13) = "NO" Then
    '    Grilla.TextMatrix(Grilla.RowSel, 13) = "SI"
    '    Call PintarCelda(SI, Grilla.RowSel)
    'Else
    '    Grilla.TextMatrix(Grilla.RowSel, 13) = "NO"
    '    Call PintarCelda(NO, Grilla.RowSel)
    'End If
    If Grilla.TextMatrix(Grilla.RowSel, iColMarAprobacion) = "NO" Then
        Grilla.TextMatrix(Grilla.RowSel, iColMarAprobacion) = "SI"
        Call PintarCelda(SI, Grilla.RowSel)
    Else
        Grilla.TextMatrix(Grilla.RowSel, iColMarAprobacion) = "NO"
        Call PintarCelda(NO, Grilla.RowSel)
    End If
    
    Grilla.Row = iRowActual
    Grilla.Col = iColActual
    '--- cvegasan 2017.08.01 Control Lineas IDD
Screen.MousePointer = vbDefault
Me.Grilla.Enabled = True

End Sub

Sub Buscar_Marcados()

   Dim indice   As Long
   Dim Contador As Long
   
   For indice = Grilla.FixedRows To Grilla.Rows - 1
      '+++ cvegasan 2017.08.01 Control Lineas IDD
      'If Grilla.TextMatrix(indice, 8) = "X" Then
      '   Contador = Contador + 1
      'End If
      If Grilla.TextMatrix(indice, iColMoneda) = "X" Then
         Contador = Contador + 1
      End If
      '--- cvegasan 2017.08.01 Control Lineas IDD
      If Contador > 2 Then
         Exit For
      End If
   Next indice

   Toolbar1.Buttons(1).Enabled = (Contador = 1)  'Aprobar
   Toolbar1.Buttons(2).Enabled = (Contador >= 1) 'Rechazar
   Toolbar1.Buttons(3).Enabled = (Contador = 1)  'Detalle
   
End Sub

Private Sub Grilla_DblClick()
   BacLeeOperaciones Grilla, 1
End Sub

Private Sub Grilla_KeyDown(KEYCODE As Integer, Shift As Integer)
    
   If KEYCODE = vbKeySpace Then
     'Marca Aprobación
     '+++ cvegasan 2017.08.01 Control Lineas IDD
      'If Grilla.TextMatrix(Grilla.RowSel, 13) = "NO" Then
      '   Grilla.TextMatrix(Grilla.RowSel, 13) = "SI"
      '   Call PintarCelda(SI, Grilla.RowSel)
      'Else
      '   Grilla.TextMatrix(Grilla.RowSel, 13) = "NO"
      '   Call PintarCelda(NO, Grilla.RowSel)
      'End If
      If Grilla.TextMatrix(Grilla.RowSel, iColMarAprobacion) = "NO" Then
         Grilla.TextMatrix(Grilla.RowSel, iColMarAprobacion) = "SI"
         Call PintarCelda(SI, Grilla.RowSel)
      Else
         Grilla.TextMatrix(Grilla.RowSel, iColMarAprobacion) = "NO"
         Call PintarCelda(NO, Grilla.RowSel)
      End If
      '--- cvegasan 2017.08.01 Control Lineas IDD
   End If
   '+++ cvegasan 2017.08.01 Control Lineas IDD
   If KEYCODE = vbKeyReturn Then
        If iColNumeroIDD = Grilla.Col _
        And Grilla.TextMatrix(Grilla.RowSel, iColNumeroIDD) = 0 _
        And Grilla.TextMatrix(Grilla.RowSel, iColAfectaLinea) = "S" Then ' Si tiene numero IDD no es editable + Columna Afecta linea="S"
           Call textovisible(Grilla, txtNumero_IDD)
        End If
    End If
    '--- cvegasan 2017.08.01 Control Lineas IDD
End Sub

Private Sub SSTab1_Click(PreviousTab As Integer)
   If Grilla.Enabled And Grilla.Visible Then
      Grilla.SetFocus
   End If
End Sub

Private Sub Tmr_Operaciones_Timer()
   On Error Resume Next
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Key
        Case Is = "Aprobar"
            Call AprobacionOperaciones
        '-> Call Aprobar_Operacion
        
        '+++ cvegasan 2017.08.01 Control Lineas IDD
        sMensajeGrabar = fnMensajeOperacionesPendientesGrabacion(arrDatosAGrabar())
        If Trim(sMensajeGrabar) <> "" Then
            MsgBox sMensajeOperacionesCabecera & sMensajeGrabar, vbInformation, TITSISTEMA
        End If
        '--- cvegasan 2017.08.01 Control Lineas IDD
        Case Is = "Rechazar"
            If MsgBox("Rechazo de Operaciones." & vbCrLf & vbCrLf & "¿ Esta seguro que desea rechazar la operación. ?", vbQuestion + vbYesNo + vbDefaultButton2, TITSISTEMA) = vbYes Then
                Call Rechazar_Operacion
            End If
        
        Case Is = "Detalle"
            Call VerDetalle
        
        Case Is = "Refrescar"
            Call RefrescarDatos
        
        Case Is = "Salir"
            Unload Me
        
        Case Else
            MsgBox Button.Key & " Operación", vbInformation, TITSISTEMA
    End Select
End Sub


Private Sub Carga_Combos()
Dim intContador As Integer
                                              
' Combo Modulos
intContador = 0
intContador = Carga_Listas_Impresion("MODULOS", Cmb_Modulo, intContador)
Cmb_Modulo.AddItem " << TODOS >> " + Space(70) + "CODIGO" + Space(5) + ""
Cmb_Modulo.ItemData(Cmb_Modulo.NewIndex) = 0
Cmb_Modulo.tag = "0"
Cmb_Modulo.ListIndex = intContador


' Combo Usuarios
intContador = 0
intContador = Carga_Listas_Impresion("USUARIOS", Cmb_Usuarios, intContador)
Cmb_Usuarios.AddItem " << TODOS >> " + Space(70) + "CODIGO" + Space(5) + ""
Cmb_Usuarios.ItemData(Cmb_Usuarios.NewIndex) = 0
Cmb_Usuarios.tag = "0"
Cmb_Usuarios.ListIndex = intContador

' Combo Tipos de Operacion
intContador = 0
intContador = Carga_Listas_Impresion("T_OPERACION", Cmb_T_Operacion, intContador)
Cmb_T_Operacion.AddItem " << TODAS >> " + Space(70) + "CODIGO" + Space(5) + ""
Cmb_T_Operacion.ItemData(Cmb_T_Operacion.NewIndex) = 0
Cmb_T_Operacion.tag = "0"
Cmb_T_Operacion.ListIndex = intContador


' Combo Monedas
intContador = 0
intContador = Carga_Listas_Impresion("MONEDAS", Cmb_Monedas, intContador)
Cmb_Monedas.AddItem " << TODAS >> " + Space(70) + "CODIGO" + Space(5) + ""
Cmb_Monedas.ItemData(Cmb_Monedas.NewIndex) = 0
Cmb_Monedas.tag = "0"
Cmb_Monedas.ListIndex = intContador

' Combo Digitadores
intContador = 0
intContador = Carga_Listas_Impresion("DIGITADOR", Cmb_Digitador, intContador)
Cmb_Digitador.AddItem " << TODOS >> " + Space(70) + "CODIGO" + Space(5) + ""
Cmb_Digitador.ItemData(Cmb_Digitador.NewIndex) = 0
Cmb_Digitador.tag = "0"
Cmb_Digitador.ListIndex = intContador


End Sub



Private Function Carga_Listas_Impresion(strSP As String, obj As Object, intContador As Integer) As Integer
Dim Datos()

Dim Mouse%
    
    Mouse = Screen.MousePointer
    Screen.MousePointer = 11
    
    SQL = "SP_BUSCA_DATOS_COMBOS_MONITOREO"
    Envia = Array()
    
Select Case UCase(strSP)
    Case "MODULOS"
        AddParam Envia, "MODU"
    Case "USUARIOS"
        AddParam Envia, "USUA"
    Case "PRODUCTOS"
        AddParam Envia, "PROD"
    Case "T_OPERACION"
        AddParam Envia, "T_OP"
        AddParam Envia, Right(Cmb_Modulo.text, 3)
    Case "MONEDAS"
        AddParam Envia, "MONE"
    Case "DIGITADOR"    'Nuevo
        AddParam Envia, "DIGI"
    Case Else
        AddParam Envia, "NADA"
    End Select
    
    If Not Bac_Sql_Execute(SQL, Envia) Then

        SQL = "No"
        Screen.MousePointer = Mouse
        Exit Function
    
    End If
    
    obj.Clear
    
    Do While Bac_SQL_Fetch(Datos())
          
    
       obj.AddItem Datos(1) + Space(70) + "CODIGO" + Space(5) + Datos(3)
        
        
        If UCase(strSP) = "USUARIOS" Then
            obj.ItemData(obj.NewIndex) = intContador + 1
        Else
            obj.ItemData(obj.NewIndex) = Val(Datos(2))
        End If
        intContador = intContador + 1

    
    Loop
    
    If obj.ListCount - 1 < 0 Then
        
'        obj.AddItem "(Sin Datos)"
'        obj.ItemData(obj.NewIndex) = -1
    
    Else
        
        obj.ListIndex = 0
    
    End If
    
    Carga_Listas_Impresion = intContador
    
    Screen.MousePointer = Mouse

End Function


Private Function BacLeeOperaciones(Grilla As Object, nTipo As Integer)
    On Error GoTo Errores
    Dim sModulo       As String
    Dim stipoper      As String
    Dim nNumOpe       As Long
    Dim nrutcart      As String
    Dim nNumOpeRF     As String
    Dim stipoperBEX   As String
    
    Dim nRow          As Integer
    Dim cTipMercado   As String
    Dim nOperacion    As Long
    Dim Operador_Origen As String
   
    With Grilla
    '+++ cvegasan 2017.08.01 Control Lineas IDD - Variables para manejo de Grilla Operaciones
      'sModulo = .TextMatrix(.Row, Cons_modulo)
      'nNumOpe = .TextMatrix(.Row, Cons_NumOper)
      'stipoper = .TextMatrix(.Row, Cons_tipoper)
      'nrutcart = .TextMatrix(.Row, Cons_rutcart)
      'nNumOpeRF = .TextMatrix(.Row, Cons_NumOperRF)
        sModulo = .TextMatrix(.Row, iColSistema)
        nNumOpe = .TextMatrix(.Row, iColNumOperacion)
        stipoper = .TextMatrix(.Row, iColCodProducto)
        nrutcart = .TextMatrix(.Row, iColRutCartera)
        nNumOpeRF = .TextMatrix(.Row, iColNumOperacion)
    '--- cvegasan 2017.08.01 Control Lineas IDD - Variables para manejo de Grilla Operaciones
      stipoperBEX = IIf(stipoper = "CP", "COMPRA", "VENTA")
            
                    If sModulo = "BCC" Then
               
                    If stipoper = "PTAS" Then
                        Call BacImprimpapeletas(nNumOpe, "bacpuntaspot.rpt", 0, 1)
                    ElseIf stipoper = "EMPR" Then
                        Call BacImprimpapeletas(nNumOpe, "bacempresa.rpt", 0, 1)
                    ElseIf stipoper = "ARBI" Then
                        Call BacImprimpapeletas(nNumOpe, "bacarbitrajes.rpt", 0, 1)
                    ElseIf stipoper = "OVER" Or nNumOpe = "WEEK" Then
                        Call BacImprimpapeletas(nNumOpe, "bacmesadin.rpt", 0, 1)
                    ElseIf stipoper = "CANJ" Then
                      Call BacImprimpapeletas(nNumOpe, "baccupoarr.rpt", 0, 1)
                    ElseIf stipoper = "VB2" Then
                        Call BacImprimpapeletas(nNumOpe, "bacrpapefur.rpt", 0, 1)
                    ElseIf stipoper = "FUTU" Or nNumOpe = "1446" Then
                        Call BacImprimpapeletas(nNumOpe, "bacrpapefur.rpt", 0, 1)
                    ElseIf stipoper = "ARRI" Then
                        Call BacImprimpapeletas(nNumOpe, "bacarriposi.rpt", 0, 1)
                    ElseIf stipoper = "CUPO" Then
                        Call BacImprimpapeletas(nNumOpe, "baccupovb2.rpt", 0, 1)
                    End If
                    
               
               
           ElseIf sModulo = "BFW" Then
                '
                '   verifica si se trata de una operacion Mx-Clp
                '
                lMxClp = IsMxClp(nNumOpe)

                '
                '   Si es una operacion Mx-Clp le asigna el codigo de producto 12 (Mx-Clp)
                '   para la impresion correcta de la papeleta
                '
                If lMxClp Then
                    stipoper = 12
                End If
                Call ImprimirPapeletaBFW(nNumOpe, 1, stipoper)

           ElseIf sModulo = "BEX" Then

                Call Imprimir_PapeletasBonex(stipoperBEX, nNumOpe, 1, "")



           ElseIf sModulo = "PCS" Then
               Select Case stipoper
                  Case "TASA"
                     Cual = 1
                  Case "MONEDA"
                     Cual = 2
                  Case "PROMEDIO CAMARA"
                     Cual = 4
                  Case Else
                     Cual = 3
               End Select

               If ImprimePapeletaSwap(nNumOpe, 1, "Pantalla", Cual) Then

               End If

            ElseIf sModulo = "BTR" Then

                 Call ImprimePapeletaBTR("", nNumOpeRF, IIf(stipoper = "AIC", "AC", stipoper), "S")
                 
            ElseIf sModulo = "OPT" Then   ' 16 Oct. 2009 No estaba imprimiendo papeleta Opciones

                Call ImprimirPapeletaOPT(nNumOpe, 1, stipoper)
     
            Else

                 MsgBox "No se ha marcado operación(es) a Imprimir", 16, TITSISTEMA

            End If
      
 End With
   
On Error GoTo 0
Exit Function

Exit Function
Errores:
    MsgBox Err.Description, , TITSISTEMA
End Function


Function IsMxClp(nOperacion As Long) As Boolean
    Dim sSql            As String
    Dim Datos()
    Dim OperacionRel    As Long

    Envia = Array()
    AddParam Envia, nOperacion
    If Not Bac_Sql_Execute("BacFwdSuda..SP_VERIFICA_MXCLP", Envia) Then
        Exit Function
    End If
    Do While Bac_SQL_Fetch(Datos())
        OperacionRel = Datos(1)
    Loop
    IsMxClp = (OperacionRel > 0)

End Function

'+++ cvegasan 2017.08.01 Control Lineas IDD
Private Sub txtNumero_IDD_KeyDown(KEYCODE As Integer, Shift As Integer)
 If KEYCODE = 13 Then
        Call TextoKeyDown(KEYCODE, Shift, Grilla, txtNumero_IDD)
        
        ' Actualiza Vector con el numero IDD desde la grilla
        lNumeroOperacion = Grilla.TextMatrix(iRowActual, iColNumOperacion)
        cSistema = Grilla.TextMatrix(iRowActual, iColSistema)
        lNumeroIdd = Grilla.TextMatrix(iRowActual, iColActual)
        
        Call prActualizaNumeroIDD(arrDatosGrilla(), lNumeroOperacion, cSistema, lNumeroIdd)
        
 ElseIf KEYCODE = vbKeyEscape Then
        txtNumero_IDD.Visible = False
        Grilla.SetFocus
    End If
End Sub

Private Sub txtNumero_IDD_LostFocus()
        txtNumero_IDD.Visible = False
        Grilla.SetFocus
End Sub
'--- cvegasan 2017.08.01 Control Lineas IDD
