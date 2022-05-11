VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacInter 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Interbancarios.-"
   ClientHeight    =   3225
   ClientLeft      =   1905
   ClientTop       =   1800
   ClientWidth     =   7230
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacinter.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3225
   ScaleWidth      =   7230
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   28
      Top             =   0
      Width           =   7230
      _ExtentX        =   12753
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar Pantalla"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "SAlir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4680
      Top             =   5475
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinter.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinter.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinter.frx":0A76
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   735
      Left            =   75
      TabIndex        =   0
      Top             =   525
      Width           =   7095
      _Version        =   65536
      _ExtentX        =   12515
      _ExtentY        =   1296
      _StockProps     =   14
      Caption         =   "Tipo Operación"
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
      Begin VB.CheckBox ChkContraBCCH 
         Caption         =   "Contra BCCH"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   3240
         TabIndex        =   30
         Top             =   315
         Width           =   1650
      End
      Begin Threed.SSPanel Pnl_FecProceso 
         Height          =   315
         Left            =   5040
         TabIndex        =   17
         Top             =   315
         Width           =   1440
         _Version        =   65536
         _ExtentX        =   2540
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
      End
      Begin Threed.SSCheck ChkCap 
         Height          =   315
         Left            =   195
         TabIndex        =   2
         Top             =   315
         Width           =   1110
         _Version        =   65536
         _ExtentX        =   1958
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Captación"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSCheck ChkCol 
         Height          =   315
         Left            =   1710
         TabIndex        =   1
         Top             =   315
         Width           =   1410
         _Version        =   65536
         _ExtentX        =   2487
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Colocación"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label Label1 
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
         Height          =   315
         Left            =   6525
         TabIndex        =   18
         Top             =   315
         Width           =   450
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Proceso"
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
         Left            =   5040
         TabIndex        =   12
         Top             =   120
         Width           =   1290
      End
   End
   Begin Threed.SSFrame SSFrame3 
      Height          =   1725
      Left            =   90
      TabIndex        =   4
      Top             =   1245
      Width           =   7080
      _Version        =   65536
      _ExtentX        =   12488
      _ExtentY        =   3043
      _StockProps     =   14
      Caption         =   "Operación"
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
      Begin VB.Frame FrmContraBCCH 
         BorderStyle     =   0  'None
         Height          =   675
         Left            =   3660
         TabIndex        =   22
         Top             =   180
         Visible         =   0   'False
         Width           =   1635
         Begin BACControles.TXTNumero Spread 
            Height          =   315
            Left            =   780
            TabIndex        =   24
            Top             =   360
            Width           =   810
            _ExtentX        =   1429
            _ExtentY        =   556
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
            Text            =   "0,00000"
            Text            =   "0,00000"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero TasaTpm 
            Height          =   315
            Left            =   0
            TabIndex        =   23
            Top             =   360
            Width           =   815
            _ExtentX        =   1429
            _ExtentY        =   556
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
            Text            =   "0,00000"
            Text            =   "0,00000"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Label10 
            Caption         =   "Tasa TMP"
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
            Left            =   0
            TabIndex        =   31
            Top             =   180
            Width           =   915
         End
         Begin VB.Label Label11 
            Caption         =   "Spread"
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
            Left            =   960
            TabIndex        =   32
            Top             =   180
            Width           =   615
         End
      End
      Begin BACControles.TXTNumero IntBase 
         Height          =   255
         Left            =   7080
         TabIndex        =   27
         Top             =   1080
         Visible         =   0   'False
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   450
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
         Max             =   "99999999999.9999999"
      End
      Begin BACControles.TXTFecha Dtefecven 
         Height          =   315
         Left            =   3210
         TabIndex        =   26
         Top             =   1185
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "13/11/2000"
      End
      Begin BACControles.TXTNumero Intdias 
         Height          =   315
         Left            =   2310
         TabIndex        =   25
         Top             =   1185
         Width           =   870
         _ExtentX        =   1535
         _ExtentY        =   556
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
         Min             =   "1"
         Max             =   "99999"
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero FltMtoini 
         Height          =   315
         Left            =   1680
         TabIndex        =   20
         Top             =   540
         Width           =   1935
         _ExtentX        =   3413
         _ExtentY        =   556
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
         Min             =   "0"
         Max             =   "99999999999999.999"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.ComboBox CmbMoneda 
         Appearance      =   0  'Flat
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
         ItemData        =   "Bacinter.frx":0D90
         Left            =   465
         List            =   "Bacinter.frx":0D92
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   540
         Width           =   1140
      End
      Begin Threed.SSPanel Lbl_Mt_Inicial 
         Height          =   315
         Left            =   165
         TabIndex        =   14
         Top             =   1185
         Width           =   2100
         _Version        =   65536
         _ExtentX        =   3704
         _ExtentY        =   556
         _StockProps     =   15
         Caption         =   "0"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         Alignment       =   4
      End
      Begin Threed.SSPanel Lbl_Mt_Final 
         Height          =   315
         Left            =   4620
         TabIndex        =   15
         Top             =   1185
         Width           =   2310
         _Version        =   65536
         _ExtentX        =   4075
         _ExtentY        =   556
         _StockProps     =   15
         Caption         =   "0"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         Alignment       =   4
      End
      Begin Threed.SSPanel Lbl_ValMon 
         Height          =   315
         Left            =   5280
         TabIndex        =   16
         Top             =   540
         Width           =   1650
         _Version        =   65536
         _ExtentX        =   2910
         _ExtentY        =   556
         _StockProps     =   15
         Caption         =   "0"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         Alignment       =   4
      End
      Begin Threed.SSPanel Pnl_MX 
         Height          =   315
         Left            =   105
         TabIndex        =   29
         Top             =   645
         Visible         =   0   'False
         Width           =   285
         _Version        =   65536
         _ExtentX        =   503
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   0
         BackColor       =   12582912
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
      End
      Begin BACControles.TXTNumero FltTasa 
         Height          =   315
         Left            =   3645
         TabIndex        =   21
         Top             =   540
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   556
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
         Text            =   "0,00000"
         Text            =   "0,00000"
         Min             =   "-99"
         CantidadDecimales=   "5"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
         SelStart        =   2
      End
      Begin VB.Label Label5 
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
         Height          =   330
         Left            =   3870
         TabIndex        =   19
         Top             =   1185
         Width           =   450
      End
      Begin VB.Label Lbl_Titulo_Ini 
         AutoSize        =   -1  'True
         Caption         =   "Monto Inicial $$"
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
         Left            =   840
         TabIndex        =   13
         Top             =   990
         Width           =   1410
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Valor Moneda"
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
         Left            =   5715
         TabIndex        =   11
         Top             =   345
         Width           =   1185
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "Dias"
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
         Left            =   2760
         TabIndex        =   10
         Top             =   990
         Width           =   390
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "Vencimiento"
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
         Left            =   3225
         TabIndex        =   9
         Top             =   990
         Width           =   1050
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
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
         Left            =   465
         TabIndex        =   8
         Top             =   345
         Width           =   690
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Monto Inicial $$"
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
         Left            =   1680
         TabIndex        =   7
         Top             =   345
         Width           =   1380
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Tasa Interes"
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
         Left            =   3675
         TabIndex        =   6
         Top             =   345
         Width           =   1080
      End
      Begin VB.Label Lbl_Titulo_Fin 
         AutoSize        =   -1  'True
         Caption         =   "Monto Final $$"
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
         Left            =   5265
         TabIndex        =   5
         Top             =   990
         Width           =   1275
      End
   End
End
Attribute VB_Name = "BacInter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public Moneda           As Object
Public bLoad            As Boolean
Dim Sql                 As String
Dim Formato_Monto       As String
Dim DATOS()


Private Sub Func_Grabar()
   
    If ChkCap.Value = False And ChkCol.Value = False Then
        MsgBox "Debe Ingresar Tipo de Operación", vbExclamation, "BAC Trader"
        Exit Sub
    End If
   
   If Pnl_MX.Caption = "S" Then
      BacIrfGr.proMoneda = gsBac_Dolar
   Else
      BacIrfGr.proMoneda = Trim$(Mid$(CmbMoneda.Text, 1, 3))
   End If
   
   BacIrfGr.proMtoOper = CDbl(FltMtoini.Text)
   BacIrfGr.proHwnd = Hwnd
   BacIrfGr.cCodLibro = ""

   Call BacGrabarTX

   If Grabacion_Operacion Then
      Call Proc_Limpia_Interbancario
      'FltMtoini.SetFocus
      CmbMoneda.SetFocus
      Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_20600", "01", "Graba Interbancarios", "", "", " ")
   End If

End Sub

Private Sub CalcInter(nNominal As String, nMtofin As String, nTasa As String, nValmon As String, nBase As String, dFecven As String, dfecpro As String, nmodal As String)

    If Lbl_ValMon.Caption > 0 Then
       Lbl_Mt_Inicial.Caption = Format(FltMtoini.Text / Lbl_ValMon.Caption, Formato_Monto)
    Else
       Lbl_Mt_Inicial.Caption = Format(0#, Formato_Monto)
    End If

    If nMtofin = "" Then nMtofin = "0"
    
    If CDbl(nTasa) = 0 Then Exit Sub
   
    Envia = Array(CDbl(nNominal), _
            CDbl(nMtofin), _
            CDbl(nTasa), _
            CDbl(nValmon), _
            CDbl(nBase), _
            Format(dFecven, "yyyymmdd"), _
            Format(dfecpro, "yyyymmdd"), _
            CDbl(nmodal), _
            Trim$(CmbMoneda.Text))

    If Not Bac_Sql_Execute("SP_CALCULOINTERBANCARIO", Envia) Then
        MsgBox "Falla en Calculos de Interbancario", 16
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(DATOS())
    
        FltMtoini.Text = BacCtrlTransMonto(DATOS(1))
        FltTasa.Text = BacCtrlTransMonto(DATOS(2))
        
        Lbl_Mt_Final.Caption = Format(CDbl(DATOS(3)), Formato_Monto)
        
        FltMtoini.Tag = BacCtrlTransMonto(DATOS(1))
        FltTasa.Tag = BacCtrlTransMonto(DATOS(2))
        Lbl_Mt_Final.Tag = BacCtrlTransMonto(DATOS(3))
   Loop

End Sub

Sub Proc_Limpia_Interbancario()

   Dim nSw%
   Dim nCont%

   'ChkCap.Value = True

   Pnl_FecProceso.Caption = Format(gsBac_Fecp, "dd/mm/yyyy")
   Label1.Caption = Mid$(BacDiaSem(Pnl_FecProceso.Caption), 1, 3)

   nSw = 0
   nCont = 1

   Do While nSw = 0
      Intdias.Text = nCont
      Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")

      If EsFeriado(CDate(Dtefecven.Text), "00001") Then
         nCont = nCont + 1
      Else
         nSw = 1

      End If

   Loop

   FltMtoini.Text = 0
   FltTasa.Text = 0
   Lbl_ValMon.Caption = Format(0, "#,##0.0000")
   Lbl_Mt_Inicial.Caption = Format(0, "#,##0.0000")
   Lbl_Mt_Final.Caption = Format(0, "#,##0.0000")

   'REQ.6008
   Spread.Text = 0
   TasaTpm.Text = 0
   ChkContraBCCH.Value = 0

   CmbMoneda.ListIndex = -1

   If CmbMoneda.ListCount > 1 Then
      CmbMoneda.ListIndex = 0

   End If

End Sub

Private Sub ChkCap_Click(Value As Integer)

   If ChkCap.Value = False Then
      ChkCol.Value = True

   Else
      ChkCol.Value = False

   End If

End Sub

Private Sub ChkCap_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      'FltMtoini.SetFocus
      CmbMoneda.SetFocus
   End If

End Sub

Private Sub ChkCol_Click(Value As Integer)

   If ChkCol.Value = False Then
      ChkCap.Value = True

   Else
      ChkCap.Value = False

   End If

End Sub

Private Sub ChkCol_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      'FltMtoini.SetFocus
      CmbMoneda.SetFocus
   End If

End Sub

'REQ.6008
Private Sub ChkContraBCCH_Click()
   
   If ChkContraBCCH.Value = 1 Then
      
      TasaTpm.Text = Proc_TasaPoliticaMonetaria
      
      FrmContraBCCH.Visible = True
      Label4.Visible = False
      
      TasaTpm.SetFocus
      
   ElseIf ChkContraBCCH.Value = 0# Then
   
      TasaTpm.Text = 0#
      Spread.Text = 0#
      FrmContraBCCH.Visible = False
      Label4.Visible = True
      
      
   End If
End Sub

Private Sub CmbMoneda_Click()
Dim x         As Integer
Dim decimales As Integer

    If bLoad = True Then
        Exit Sub
    End If

    If CmbMoneda.ListIndex <= -1 Then
        Exit Sub
    End If
    
    Lbl_Titulo_Ini.Caption = "Monto Inicial " + Trim(CmbMoneda.Text)
    Lbl_Titulo_Fin.Caption = "Monto Final " + Trim(CmbMoneda.Text)

    Screen.MousePointer = vbHourglass
        
    Envia = Array(CDbl(CmbMoneda.ItemData(CmbMoneda.ListIndex)), _
            Format(gsBac_Fecp, "yyyymmdd"), _
            CDbl(CmbMoneda.ItemData(CmbMoneda.ListIndex)))
         
    If Not Bac_Sql_Execute("SP_VALBASE_MONEDA", Envia) Then
       Screen.MousePointer = 0
       MsgBox "NO Encuentra Datos de Moneda Seleccionada.", 16
       Exit Sub
    End If
        
    Do While Bac_SQL_Fetch(DATOS())
       IntBase.Text = CDbl(DATOS(2))
       Pnl_MX.Caption = Mid$(DATOS(3), 1, 1)
       decimales = Val(DATOS(4))
       If Pnl_MX.Caption = "S" Then
          Lbl_ValMon.Caption = Format(1, "#,##0.0000")
          FltMtoini.CantidadDecimales = decimales
       Else
          Lbl_ValMon.Caption = Format(DATOS(1), "#,##0.0000")
          FltMtoini.CantidadDecimales = 0
       End If
    Loop

    If Lbl_ValMon.Caption = "0.0000" Or IntBase.Text = 0 Then
       MsgBox "No se encuentra Base o Valor para moneda seleccionada", vbCritical
       Me.Lbl_Mt_Inicial = 0
       Lbl_Mt_Final = 0
       Screen.MousePointer = 0
       Exit Sub
    End If
    
    If decimales = 0 Then
       Formato_Monto = "#,##0"
    Else
       Formato_Monto = "#,##0." + String(decimales, "0")
    End If
    
    If CmbMoneda.Text = "CLP" Or CmbMoneda.Text = "UF" Then
       Label3.Caption = "Monto Inicial $$"
       Lbl_ValMon.Caption = Format(Lbl_ValMon, "#,##0.0000")
    Else
       Label3.Caption = "Monto Inicial " + Trim(CmbMoneda.Text)
    End If
        
    Call funcFindDatGralMoneda(CDbl(CmbMoneda.ItemData(CmbMoneda.ListIndex)))
    SwMx = BacDatGrMon.mnmx
     
    Screen.MousePointer = 0

    Call CalcInter(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "dd/mm/yyyy"), Format(gsBac_Fecp, "dd/mm/yyyy"), " 1")

End Sub

Private Sub cmbMoneda_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      Call Bac_SendKey(vbKeyTab)

   End If

End Sub

Private Sub Dtefecven_Change()

   Label5.Caption = Mid$(BacDiaSem(Dtefecven.Text), 1, 3)
   'dtefecven_LostFocus
   


End Sub

Private Sub dtefecven_GotFocus()

   Dtefecven.Tag = Dtefecven.Text

End Sub

Private Sub dtefecven_LostFocus()

   If Dtefecven.Tag <> Dtefecven.Text Then
      If Dtefecven.Text <> Pnl_FecProceso.Caption Then
         If BacEsHabil(Dtefecven.Text) Then
            Intdias.Text = DateDiff("d", Pnl_FecProceso.Caption, Dtefecven.Text)
            Intdias.Tag = DateDiff("d", Pnl_FecProceso.Caption, Dtefecven.Text)
            Call Bac_SendKey(vbKeyTab)
            Call CalcInter(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "dd/mm/yyyy"), Format(gsBac_Fecp, "dd/mm/yyyy"), " 1")

         Else
            MsgBox "Fecha de Vcto. no es día Hábil", 16
            Intdias.Text = Intdias.Tag
            Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")

         End If

      Else
         MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
         Intdias.Text = Intdias.Tag
         Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")

      End If

   End If

   If Format(Dtefecven.Text, "yyyymmdd") <= Format(gsBac_Fecp, "yyyymmdd") Then
      MsgBox "Fecha de Vcto. debe ser Mayor a Fecha de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
      Intdias.Text = Intdias.Tag
      Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")

   End If

End Sub

Private Sub FltMtoini_GotFocus()

   FltMtoini.Tag = FltMtoini.Text

End Sub

Private Sub FltMtoini_KeyPress(KeyAscii As Integer)

'   If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
'      KeyAscii = Asc(gsBac_PtoDec)
'
'   End If
'
   If KeyAscii = 13 Then
      Call Bac_SendKey(vbKeyTab)

   End If

End Sub

Private Sub FltMtoini_LostFocus()

    If FltMtoini.Text <> FltMtoini.Tag Then
        Call CalcInter(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "dd/mm/yyyy"), Format(gsBac_Fecp, "dd/mm/yyyy"), "1")
    End If

End Sub

Private Sub FltTasa_GotFocus()

   FltTasa.Tag = FltTasa.Text

End Sub

Private Sub FltTasa_KeyPress(KeyAscii As Integer)

'   If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
'      KeyAscii = Asc(gsBac_PtoDec)
'   End If

   If KeyAscii = 13 Then
      KeyAscii = 0
      Call Bac_SendKey(vbKeyTab)
   End If

End Sub

Private Sub FltTasa_LostFocus()
'    If Not Validar_Tasa("IB", CmbMoneda.ItemData(CmbMoneda.ListIndex), CDbl(FltTasa.Text)) Then
'               FltTasa.Text = 0#
'               FltTasa.SetFocus
'              Exit Sub
'    End If
    
    Dim ptTasa As Double
    Dim ptPlazo As Integer
    Dim ptMoneda As Integer
    Dim ptOp As String

    If CDbl(FltTasa.Tag) <> CDbl(FltTasa.Text) Then
        Call CalcInter(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "dd/mm/yyyy"), Format(gsBac_Fecp, "dd/mm/yyyy"), " 1")
    End If

    'Control de Precios y Tasas
    If ChkCap.Value = False And ChkCol.Value = False Then
        MsgBox "Para realizar el control de Precios y Tasas se requiere que seleccione" & vbCrLf & "si la operación es de Captación o de Colocación."
        Exit Sub
    End If
    ptTasa = CDbl(FltTasa.Text)
    ptPlazo = CInt(Intdias.Text)
    ptMoneda = CInt(CmbMoneda.ItemData(CmbMoneda.ListIndex))
'    If ChkCap.Value = True Then
'        ptOp = "ICAP"
'    Else
'        ptOp = "ICOL"
'    End If
    If FltTasa.Text > 0 Then
    'Dado que los productos diferencian los IB ICAP e ICOL aquí también debemos hacer lo mismo!
        If ChkCap.Value = True Then
            ptOp = "ICAP"
        Else
            ptOp = "ICOL"
        End If
        
        'Aplicar Control de Precios y Tasas
        'Como aun no conozco al cliente...
        Ctrlpt_RutCliente = "0"
        Ctrlpt_CodCliente = "0"
        
        'If ControlPreciosTasas("IB", ptMoneda, ptPlazo, ptTasa) = "S" Then
        If ControlPreciosTasas(ptOp, ptMoneda, ptPlazo, ptTasa) = "S" Then
            If Ctrlpt_ModoOperacion <> "S" Then 'PRD-3860, modo silencioso
            MsgBox Ctrlpt_Mensaje, vbExclamation, TITSISTEMA
        End If
    End If
    End If
End Sub

Private Sub Form_Activate()
Tipo_Operacion = "IB"

   'FltMtoini.SetFocus
   CmbMoneda.SetFocus
   

End Sub

Private Sub Form_Load()

   Dim I                As Integer

   Me.Tag = "IB"
   Tipo_Operacion = "IB"
   Me.Top = 0
   Me.Left = 0
   bLoad = True

   Call LeeModoControlPT    'PRD-3860, modo silencioso

   If Not funcFindMoneda(CmbMoneda, "IB") Then
      Exit Sub

   End If

   bLoad = False

   Proc_Limpia_Interbancario

   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Ingreso a pantalla de interbancarios")

End Sub

Private Sub IntBase_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      Call Bac_SendKey(vbKeyTab)

   End If

End Sub

Private Sub Intdias_GotFocus()

   Intdias.Tag = Intdias.Text

End Sub

Private Sub Intdias_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      KeyAscii = 0
      Call Bac_SendKey(vbKeyTab)

   End If

End Sub

Private Sub Intdias_LostFocus()

   Dim sfec             As String
   Dim ptTasa As Double
   Dim ptPlazo As Integer
   Dim ptMoneda As Integer
   Dim ptOp As String

   If Intdias.Tag <> Intdias.Text Then
      If Intdias.Text <> 0 Then
         sfec = Format(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")

         If BacEsHabil(sfec) Then
            Dtefecven.Text = sfec
            Dtefecven.Tag = sfec
            Call Bac_SendKey(vbKeyTab)
            Call CalcInter(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "dd/mm/yyyy"), Format(gsBac_Fecp, "dd/mm/yyyy"), " 1")

         Else
            MsgBox "Fecha de Vcto. no es día Hábil", 16
            Intdias.Text = Intdias.Tag
            Intdias.SetFocus
            Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")

         End If

      Else
         MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
         Intdias.Text = Intdias.Tag
         Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")

      End If

   End If
'    'Control de Precios y Tasas
'    ptTasa = CDbl(FltTasa.Text)
'    ptPlazo = CInt(Intdias.Text)
'    ptMoneda = CInt(CmbMoneda.ItemData(CmbMoneda.ListIndex))
''    If ChkCap.Value = True Then
''        ptOp = "ICAP"
''    Else
''        ptOp = "ICOL"
''    End If
'    If FltTasa.Text > 0 Then
'        If ControlPreciosTasas("IB", ptMoneda, ptPlazo, ptTasa) = "S" Then
'            If Ctrlpt_ModoOperacion <> "S" Then 'PRD-3860, modo silencioso
'                MsgBox Ctrlpt_Mensaje, vbExclamation, TITSISTEMA
'            End If
'        End If
'    End If

End Sub
'REQ.6008
Private Sub Spread_GotFocus()
    Spread.Tag = Spread.Text
End Sub

'REQ.6008
Private Sub Spread_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Call Bac_SendKey(vbKeyTab)
   End If
End Sub

'REQ.6008
Private Sub Spread_LostFocus()
   FltTasa.Text = CDbl(TasaTpm.Text) + CDbl(Spread.Text)
   Call FltTasa_LostFocus
End Sub

'REQ.6008
Private Sub TasaTpm_GotFocus()
   TasaTpm.Tag = TasaTpm.Text
   FltTasa.Tag = CDbl(TasaTpm.Text) + CDbl(Spread.Text)
End Sub

'REQ.6008
Private Sub TasaTpm_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Call Bac_SendKey(vbKeyTab)
   End If
End Sub

'REQ.6008
Private Sub TasaTpm_LostFocus()
   FltTasa.Text = CDbl(TasaTpm.Text) + CDbl(Spread.Text)
   Call FltTasa_LostFocus
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case UCase(Button.Description)
    
        Case "GRABAR"
            If Valida_Fecha Then
                Call Func_Grabar
            End If
        
        Case "LIMPIAR"
            Call Proc_Limpia_Interbancario
            CmbMoneda.SetFocus
        
        Case "SALIR"
            Unload Me
    
    End Select

End Sub
Private Function Valida_Fecha() As Boolean

   If (Intdias.Text > 99999) Then
      Call MsgBox("Plazo ingresado supera el plazo máximo permitido.", vbExclamation, App.Title)
      Let Intdias.Text = 99999
      Call Intdias_LostFocus
      Exit Function
   End If

   If (DateDiff("D", gsBac_Fecp, Dtefecven.Text) > 99999) Then
      Call MsgBox("Plazo entre fechas supera el máximo permitido.", vbExclamation, App.Title)
      Let Intdias.Text = 99999
      Call Intdias_LostFocus
      Exit Function
   End If
   

' If Dtefecven.Tag <> Dtefecven.Text Then
      If Dtefecven.Text <> Pnl_FecProceso.Caption Then
         If BacEsHabil(Dtefecven.Text) Then
            Intdias.Text = DateDiff("d", Pnl_FecProceso.Caption, Dtefecven.Text)
            Intdias.Tag = DateDiff("d", Pnl_FecProceso.Caption, Dtefecven.Text)
            Call Bac_SendKey(vbKeyTab)
Call CalcInter(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "dd/mm/yyyy"), Format(gsBac_Fecp, "dd/mm/yyyy"), " 1")
            Valida_Fecha = True
          Else
            MsgBox "Fecha de Vcto. no es día Hábil", 16
            Intdias.Text = Intdias.Tag
            Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")
            Valida_Fecha = False
         End If

      Else
         MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
         Intdias.Text = Intdias.Tag
         Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")
         Valida_Fecha = False
      End If

'   End If

   If Format(Dtefecven.Text, "yyyymmdd") <= Format(gsBac_Fecp, "yyyymmdd") Then
      MsgBox "Fecha de Vcto. debe ser Mayor a Fecha de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
      Intdias.Text = Intdias.Tag
      Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")
      Valida_Fecha = False
  End If
  
End Function

''REQ.6008
Private Function Proc_TasaPoliticaMonetaria()
    Dim DATOS()
    Dim nTasa As Double
    
    If Not Bac_Sql_Execute("SP_TASAPOLITICAMONETARIA") Then
        MsgBox "Error al Rescatar Tasa Política Monetaria", vbInformation, App.Title
        Exit Function
    End If

    Do While Bac_SQL_Fetch(DATOS())
        nTasa = BacCtrlTransMonto(DATOS(1))
    Loop
    
    If nTasa <> 0 Then
      Proc_TasaPoliticaMonetaria = nTasa
    End If
End Function


