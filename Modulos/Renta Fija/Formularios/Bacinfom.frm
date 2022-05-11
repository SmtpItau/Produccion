VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacInfOma 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe Operaciones Mercado Abierto"
   ClientHeight    =   1710
   ClientLeft      =   2085
   ClientTop       =   2040
   ClientWidth     =   6255
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacinfom.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1710
   ScaleWidth      =   6255
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   6255
      _ExtentX        =   11033
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbimprimir"
            Description     =   "IMPRIMIR"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcancelar"
            Description     =   "CANCELAR"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5685
      Top             =   2895
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinfom.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinfom.frx":0624
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   750
      Left            =   15
      TabIndex        =   0
      Top             =   945
      Width           =   6225
      _Version        =   65536
      _ExtentX        =   10980
      _ExtentY        =   1323
      _StockProps     =   14
      Caption         =   "Observaciones"
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
      Begin Threed.SSPanel SSPanel2 
         Height          =   375
         Left            =   90
         TabIndex        =   1
         Top             =   285
         Width           =   6000
         _Version        =   65536
         _ExtentX        =   10583
         _ExtentY        =   661
         _StockProps     =   15
         ForeColor       =   -2147483630
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
         BevelOuter      =   1
         Autosize        =   3
         Begin VB.TextBox TxtObser 
            Height          =   345
            Left            =   15
            MaxLength       =   60
            TabIndex        =   2
            Top             =   15
            Width           =   5970
         End
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   540
      Left            =   15
      TabIndex        =   3
      Top             =   420
      Width           =   1680
      _Version        =   65536
      _ExtentX        =   2963
      _ExtentY        =   952
      _StockProps     =   14
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
      Begin Threed.SSCheck OptRectif 
         Height          =   330
         Left            =   150
         TabIndex        =   4
         Top             =   120
         Width           =   1365
         _Version        =   65536
         _ExtentX        =   2413
         _ExtentY        =   572
         _StockProps     =   78
         Caption         =   "  Rectificado"
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
         Font3D          =   4
      End
   End
   Begin Threed.SSCommand CmdCancela 
      Height          =   450
      Left            =   1395
      TabIndex        =   6
      Top             =   2910
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Cancelar"
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
   End
   Begin Threed.SSCommand CmdImprime 
      Height          =   450
      Left            =   135
      TabIndex        =   5
      Top             =   2925
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Imprime"
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
   End
End
Attribute VB_Name = "BacInfOma"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub CmdCancela_Click()
'    Unload Me
End Sub

Private Sub CmdImprime_Click()
'       Call limpiar_cristal
'      TitRpt = TxtObser
'      BacTrader.bacrpt.Destination = 0
'      BacTrader.bacrpt.ReportFileName = RptList_Path & "OMA.RPT"
'      BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
'      BacTrader.bacrpt.Formulas(0) = "titulo='" & TitRpt & "'"
'      BacTrader.bacrpt.Connect = "DSN = BACTRADER;UID = BACUSER;PWD=BACUSER;DSQ=bacparametros"
'      BacTrader.bacrpt.Action = 1
'      Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
'
'    Unload Me
End Sub


Private Sub Form_Load()
    OptRectif.Value = False
End Sub

Private Sub SSCommand1_Click()

End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
    Case "IMPRIMIR"
        Call Limpiar_Cristal
        TitRpt = TxtObser
        BacTrader.bacrpt.Destination = 0
        BacTrader.bacrpt.ReportFileName = RptList_Path & "OMA.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
        BacTrader.bacrpt.Formulas(0) = "titulo='" & TitRpt & "'"
        'BacTrader.bacrpt.Connect = "DSN = BACTRADER;UID = BACUSER;PWD=BACUSER;DSQ=bacparametros"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
        Unload Me
    Case "CANCELAR"
        Unload Me
End Select
End Sub
