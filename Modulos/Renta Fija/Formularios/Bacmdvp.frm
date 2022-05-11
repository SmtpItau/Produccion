VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacVP 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Venta definitivas"
   ClientHeight    =   5505
   ClientLeft      =   1095
   ClientTop       =   2160
   ClientWidth     =   11685
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmdvp.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   NegotiateMenus  =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5505
   ScaleWidth      =   11685
   Begin BACControles.TXTNumero TEXT1 
      Height          =   300
      Left            =   1020
      TabIndex        =   21
      Top             =   2325
      Visible         =   0   'False
      Width           =   630
      _ExtentX        =   1111
      _ExtentY        =   529
      BackColor       =   12632256
      ForeColor       =   192
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
      Min             =   "-99"
      Max             =   "99999999999.9999"
      Separator       =   -1  'True
   End
   Begin VB.Frame Frame2 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1140
      Left            =   1365
      TabIndex        =   35
      Top             =   540
      Width           =   4200
      Begin VB.ComboBox TipoPago 
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
         ItemData        =   "Bacmdvp.frx":030A
         Left            =   45
         List            =   "Bacmdvp.frx":030C
         Style           =   2  'Dropdown List
         TabIndex        =   36
         Top             =   480
         Width           =   2640
      End
      Begin BACControles.TXTFecha FechaPago 
         Height          =   315
         Left            =   2700
         TabIndex        =   37
         Top             =   480
         Width           =   1425
         _ExtentX        =   2514
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   2
         Text            =   "01/01/1900"
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Modo de Pago"
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
         Index           =   2
         Left            =   60
         TabIndex        =   39
         Top             =   180
         Width           =   1245
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha de Pago"
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
         Index           =   14
         Left            =   2715
         TabIndex        =   38
         Top             =   180
         Width           =   1305
      End
   End
   Begin VB.Frame Cuadrodvp 
      Caption         =   "DVP"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1155
      Left            =   30
      TabIndex        =   25
      Top             =   525
      Width           =   1305
      Begin VB.OptionButton OptDvp 
         Caption         =   "&Si"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   720
         TabIndex        =   27
         TabStop         =   0   'False
         Top             =   510
         Width           =   510
      End
      Begin VB.OptionButton OptDvp 
         Caption         =   "&No"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   75
         TabIndex        =   26
         TabStop         =   0   'False
         Top             =   510
         Width           =   585
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4725
      Top             =   -15
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
            Picture         =   "Bacmdvp.frx":030E
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvp.frx":0760
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvp.frx":0A7A
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvp.frx":0ECC
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvp.frx":38986
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvp.frx":38DD8
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvp.frx":390F2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   "C:\BTRADER\Mdb\BACTRD.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   6555
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   "MDDI"
      Top             =   60
      Visible         =   0   'False
      Width           =   2415
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   24
      Top             =   0
      Width           =   11685
      _ExtentX        =   20611
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
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbgrabar"
            Description     =   "GRABAR"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbvende"
            Description     =   "VENDE"
            Object.ToolTipText     =   "Vende"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbrestaura"
            Description     =   "RESTAURAR"
            Object.ToolTipText     =   "Restaurar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbfiltrar"
            Description     =   "FILTRAR"
            Object.ToolTipText     =   "Filtrar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbversel"
            Description     =   "VERSELEC"
            Object.ToolTipText     =   "Ver Seleccion"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbemision"
            Description     =   "EMISION"
            Object.ToolTipText     =   "Emision"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcortes"
            Description     =   "CORTES"
            Object.ToolTipText     =   "Cortes"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "valorizaciones"
         EndProperty
      EndProperty
      BorderStyle     =   1
      Enabled         =   0   'False
   End
   Begin VB.TextBox Text2 
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   0  'None
      ForeColor       =   &H00800000&
      Height          =   240
      Left            =   285
      TabIndex        =   23
      Top             =   2340
      Visible         =   0   'False
      Width           =   720
   End
   Begin VB.ComboBox Combo1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H00800000&
      Height          =   315
      ItemData        =   "Bacmdvp.frx":3940C
      Left            =   1725
      List            =   "Bacmdvp.frx":39419
      Style           =   2  'Dropdown List
      TabIndex        =   22
      Top             =   2325
      Visible         =   0   'False
      Width           =   1440
   End
   Begin MSFlexGridLib.MSFlexGrid TABLE1 
      Height          =   3255
      Left            =   15
      TabIndex        =   20
      Top             =   1695
      Width           =   11670
      _ExtentX        =   20585
      _ExtentY        =   5741
      _Version        =   393216
      Cols            =   24
      FixedCols       =   2
      RowHeightMin    =   315
      BackColor       =   -2147483633
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   -2147483634
      ForeColorSel    =   -2147483635
      BackColorBkg    =   12632256
      FocusRect       =   2
      HighLight       =   2
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Frame FrmMontos 
      Height          =   600
      Left            =   30
      TabIndex        =   0
      Top             =   4875
      Width           =   11640
      Begin Threed.SSPanel Panel 
         Height          =   315
         Index           =   3
         Left            =   3420
         TabIndex        =   1
         Top             =   195
         Width           =   1485
         _Version        =   65536
         _ExtentX        =   2619
         _ExtentY        =   556
         _StockProps     =   15
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
         BorderWidth     =   1
         BevelOuter      =   1
         Autosize        =   3
         Begin BACControles.TXTNumero TxtInv 
            Height          =   285
            Left            =   15
            TabIndex        =   17
            Top             =   15
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   503
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0,00"
            Text            =   "0,00"
            Min             =   "-9999999999999999"
            Max             =   "9999999999999999"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
         End
      End
      Begin Threed.SSPanel Panel 
         Height          =   315
         Index           =   9
         Left            =   5685
         TabIndex        =   2
         Top             =   195
         Width           =   1500
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   556
         _StockProps     =   15
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
         BorderWidth     =   1
         BevelOuter      =   1
         Autosize        =   3
         Begin BACControles.TXTNumero TxtSel 
            Height          =   285
            Left            =   15
            TabIndex        =   18
            Top             =   15
            Width           =   1470
            _ExtentX        =   2593
            _ExtentY        =   503
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0,00"
            Text            =   "0,00"
            Min             =   "-9999999999999999"
            Max             =   "9999999999999"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
         End
      End
      Begin Threed.SSPanel Panel 
         Height          =   315
         Index           =   11
         Left            =   8040
         TabIndex        =   3
         Top             =   195
         Width           =   1605
         _Version        =   65536
         _ExtentX        =   2831
         _ExtentY        =   556
         _StockProps     =   15
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
         BorderWidth     =   1
         BevelOuter      =   1
         Autosize        =   3
         Begin BACControles.TXTNumero TxtSaldo 
            Height          =   285
            Left            =   15
            TabIndex        =   19
            Top             =   15
            Width           =   1575
            _ExtentX        =   2778
            _ExtentY        =   503
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0,00"
            Text            =   "0,00"
            Min             =   "-9999999999999999"
            Max             =   "999999999999999"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
         End
      End
      Begin Threed.SSPanel Panel 
         Height          =   315
         Index           =   4
         Left            =   885
         TabIndex        =   4
         Top             =   195
         Width           =   1590
         _Version        =   65536
         _ExtentX        =   2805
         _ExtentY        =   556
         _StockProps     =   15
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
         BorderWidth     =   1
         BevelOuter      =   1
         Autosize        =   3
         Begin BACControles.TXTNumero TxtCartera 
            Height          =   285
            Left            =   15
            TabIndex        =   16
            Top             =   15
            Width           =   1560
            _ExtentX        =   2752
            _ExtentY        =   503
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0,00"
            Text            =   "0,00"
            Max             =   "9999999999999"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
         End
      End
      Begin VB.Label Label6 
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   " Cartera"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   75
         TabIndex        =   8
         Top             =   195
         Width           =   795
      End
      Begin VB.Label Label2 
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Inversión"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   2505
         TabIndex        =   7
         Top             =   195
         Width           =   900
      End
      Begin VB.Label Label3 
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   " Selec."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   4950
         TabIndex        =   6
         Top             =   195
         Width           =   735
      End
      Begin VB.Label Label4 
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   " Saldo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   7230
         TabIndex        =   5
         Top             =   195
         Width           =   795
      End
   End
   Begin Threed.SSCommand SSC_Grabar 
      Height          =   450
      Left            =   195
      TabIndex        =   15
      TabStop         =   0   'False
      Top             =   6270
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Grabar"
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
      RoundedCorners  =   0   'False
   End
   Begin Threed.SSCommand CmdVenta 
      Height          =   450
      Left            =   1485
      TabIndex        =   14
      TabStop         =   0   'False
      Top             =   6270
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Vende"
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
      RoundedCorners  =   0   'False
   End
   Begin Threed.SSCommand CmdRestaura 
      Height          =   450
      Left            =   2670
      TabIndex        =   13
      TabStop         =   0   'False
      Top             =   6270
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Restaura"
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
      RoundedCorners  =   0   'False
   End
   Begin Threed.SSCommand CmdEmision 
      Height          =   450
      Left            =   6435
      TabIndex        =   12
      TabStop         =   0   'False
      Top             =   6270
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Emisión"
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
      RoundedCorners  =   0   'False
   End
   Begin Threed.SSCommand CmdCortes 
      Height          =   450
      Left            =   7620
      TabIndex        =   11
      TabStop         =   0   'False
      Top             =   6270
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Cortes"
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
      RoundedCorners  =   0   'False
   End
   Begin Threed.SSCommand CmdFiltro 
      Height          =   450
      Left            =   3780
      TabIndex        =   10
      TabStop         =   0   'False
      Top             =   6270
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Filtrar"
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
      RoundedCorners  =   0   'False
   End
   Begin Threed.SSCommand CmdTipoFiltro 
      Height          =   450
      Left            =   5025
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   6270
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
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
      RoundedCorners  =   0   'False
   End
   Begin VB.Frame Frame1 
      Height          =   855
      Left            =   7365
      TabIndex        =   30
      Top             =   825
      Width           =   4290
      Begin BACControles.TXTNumero TxtTotal 
         Height          =   300
         Left            =   1515
         TabIndex        =   31
         Top             =   150
         Width           =   2670
         _ExtentX        =   4710
         _ExtentY        =   529
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,00"
         Text            =   "0,00"
         Min             =   "-99999999999999.999999"
         Max             =   "99999999999999.999999"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Resultado"
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
         Left            =   45
         TabIndex        =   34
         Top             =   510
         Width           =   870
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Total Operación"
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
         Left            =   45
         TabIndex        =   33
         Top             =   210
         Width           =   1380
      End
      Begin VB.Label Flt_Result 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   1515
         TabIndex        =   32
         Top             =   480
         Width           =   2670
      End
   End
   Begin VB.Frame Frame3 
      Height          =   1140
      Left            =   5595
      TabIndex        =   40
      Top             =   540
      Width           =   1740
      Begin VB.CheckBox Chk_Dif_CLP 
         Height          =   195
         Left            =   690
         TabIndex        =   41
         Top             =   735
         Width           =   225
      End
      Begin VB.Label Label5 
         Alignment       =   2  'Center
         Caption         =   "Resultado Trans. CLP"
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
         Height          =   405
         Left            =   165
         TabIndex        =   42
         Top             =   225
         Width           =   1425
      End
   End
   Begin VB.Label PnlLibro 
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
      Height          =   285
      Left            =   7845
      TabIndex        =   29
      Top             =   540
      Width           =   3810
   End
   Begin VB.Label lbllibro 
      AutoSize        =   -1  'True
      Caption         =   "Libro"
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
      Left            =   7380
      TabIndex        =   28
      Top             =   600
      Width           =   435
   End
End
Attribute VB_Name = "BacVP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Public FiltraVentaAutomatico  As Boolean
Public bFlagDpx               As Boolean      'Permite solo el ingreso de los dpx
Public oTipoPago              As Integer
Public Fila                   As Integer
Public FiltroAutomatico       As Boolean


Dim SWPintando             As Boolean
Dim Monto                  As Double
Dim Tecla                  As String
Dim FormHandle             As Long
Dim Columna                As Integer
Dim objMonLiq              As New ClsCodigos
Dim iFlagKeyDown           As Integer
Dim bufNominal             As Double
Dim bufRutCart             As Long
Dim objDCartera            As New clsDCartera
Dim sFiltro                As String
Dim nRutCartV              As String
Dim cDvCartV               As String
Dim cNomCartV              As String
Dim valor                  As String


Dim z                      As Integer
Dim Color                  As String
Dim colorletra             As String
Dim columnita              As Integer
Dim filita                 As Integer
Dim bold                   As String

'Variables Constantes de Columnas de la grilla Table1
Const nColEstado = 0
Const nColSerie = 1
Const nColMoneda = 2
Const nColNominal = 3
Const nColTir = 4
Const nColVPar = 5
Const nColValorPresente = 6
Const nColCustodia = 7
Const nColClaveDCV = 8
Const nColTirCompra = 9
Const nColVParCompra = 10
Const nColValorCompra = 11
Const nColUtilidad = 12

Const nColTTran = 13
Const nColVTran = 14
Const nColVPTran = 15
Const nColDifTran = 16
Const nColDif_CLP = 17

Const nColCarteraSuper = 18 '13
Const nColDurationMac = 19 '14
Const nColDurationMod = 20 '15
Const nColConvex = 21 '16
Const nColLibro = 22 '17
Const nColValuta = 23 '18

'constantes de posicion de datos en arreglo de consulta para
'procedimiento SP_FILTRARCART_VP
Const Pos_RutCartera = 0
Const Pos_CartFin = 1
Const Pos_CadenaFamilia = 2
Const Pos_CadenaEmisor = 3
Const Pos_CadenaMoneda = 4
Const Pos_CadenaSerie = 5
Const Pos_CartSuper = 6
Const Pos_Usuario = 7
Const Pos_Libro = 8
            
Public cCodCartFin        As String
Public cCodLibro          As String

Public glBacCpDvpVp       As DvpCp
Public bSelPagoMañana     As Boolean

'==========================================================================
' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Limites de Permanencia
' INICIO
'==========================================================================
Public Autorizado_II            As Boolean
Public Codigo_Limite                        As String
Public Usuario_Autorizador                  As String
'==========================================================================
' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Limites de Permanencia
' FIN
'==========================================================================

Private Sub desbloquear()

   Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_venta = " & "'V'" & " OR tm_venta = " & " 'P'"
   Data1.Refresh
    
   Do While Not Data1.Recordset.EOF
      Call VENTA_DesBloquear(FormHandle, Data1)
      Data1.Recordset.MoveNext
   Loop

End Sub

Private Sub refresca()
     Dim i As Integer
     Data1.Refresh
    
   For i = 1 To Table1.Rows - 1
      Table1.Row = i
      Call Llenar_Grilla
      
      If Not Data1.Recordset.EOF Then
      Data1.Recordset.MoveNext
      End If
   Next i
   
   Table1.Refresh
End Sub
    
       
Private Function colores()
Dim Fila As Integer

Table1.Redraw = False
     
For Fila = 1 To Table1.Rows - 1
 
    If Table1.TextMatrix(Fila, 0) = "*" Then
         Color = &HC0C0C0
         colorletra = &HC0&
         bold = False
    End If
    
    If Table1.TextMatrix(Fila, 0) = "V" Then
         Color = &HFF0000
         colorletra = &HFFFFFF
         bold = True
    End If
    
    If Table1.TextMatrix(Fila, 0) = "P" Then
         Color = vbCyan
         colorletra = vbBlack
         bold = False
    End If

    If Table1.TextMatrix(Fila, 0) = "B" Then
       Color = vbBlack + vbWhite    'vbBlack
       colorletra = vbBlack
       bold = False
    End If
    
    If Table1.TextMatrix(Fila, 0) = " " Then
         Color = &HC0C0C0
         colorletra = &H800000
         bold = False
    End If
    
    
   Dim z%
   Table1.Row = Fila
      
   For z = 2 To Table1.cols - 1
      Table1.Col = z
      Table1.CellBackColor = Color
      Table1.CellForeColor = colorletra
      Table1.CellFontBold = bold
   Next z
  
Next Fila
   
   Table1.Redraw = True
   ''''Table1.Col = 2
   Table1.Col = nColMoneda

End Function

Public Function Colocardata1()
   
   Dim iContador As Integer
   
   If Table1.Rows = 1 Then
      Exit Function
   End If
   
   If Table1.TextMatrix(1, nColEstado) = "" Then
      Exit Function
   End If
   
   Monto = CDbl(Table1.TextMatrix(Table1.Row, nColNominal))
   Data1.Recordset.MoveFirst
   
   For iContador = 1 To Table1.Row - 1
      If Not (Data1.Recordset.EOF) Then   'corregido
      Data1.Recordset.MoveNext
      End If
   Next iContador
   
End Function

Private Sub Llenar_Grilla()
   Dim X            As Integer
   Dim nContador    As Integer
   Dim nTipoCambio  As Double
   Dim oDatos()
   
   
    If Data1.Recordset.RecordCount > 0 Then
        Data1.Recordset.MoveFirst
    End If


    Table1.Redraw = False
    Table1.Rows = 1
   
    Do While Not Data1.Recordset.EOF
        X = Table1.Rows
        Table1.Rows = Table1.Rows + 1
      
        With Table1
            .TextMatrix(X, nColEstado) = Data1.Recordset!tm_venta
            .TextMatrix(X, nColSerie) = Data1.Recordset!TM_INSTSER
             If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
               .ColWidth(4) = 1800
             End If
            .TextMatrix(X, nColMoneda) = Data1.Recordset!TM_NEMMON
            .TextMatrix(X, nColNominal) = Format(Data1.Recordset!tm_nominal, "#,##0.0000")
            .TextMatrix(X, nColTir) = Format(Data1.Recordset!TM_TIR, "#,##0.0000")
            .TextMatrix(X, nColVPar) = Format(Data1.Recordset!TM_Pvp, "#,##0.0000")
            .TextMatrix(X, nColValorPresente) = Format(Data1.Recordset!TM_VP, "#,##0.0000")
            .TextMatrix(X, nColCustodia) = IIf(IsNull(Data1.Recordset!tm_custodia) = True, " ", Data1.Recordset!tm_custodia)
            .TextMatrix(X, nColClaveDCV) = IIf(IsNull(Data1.Recordset!tm_clave_dcv) = True, " ", Data1.Recordset!tm_clave_dcv)
            .TextMatrix(X, nColTirCompra) = Format(Data1.Recordset!TM_tircomp, "#,##0.0000")
            .TextMatrix(X, nColVParCompra) = Format(Data1.Recordset!TM_pvpcomp, "#,##0.0000")
            .TextMatrix(X, nColValorCompra) = Format(Data1.Recordset!tm_vptirc, "#,##0.0000")
            .TextMatrix(X, nColUtilidad) = Format(CDbl(Data1.Recordset!TM_VP) - CDbl(Data1.Recordset!tm_vptirc), "#,##0")

            .TextMatrix(X, nColTTran) = IIf(Data1.Recordset!TM_TIR_TRAN <> 0, Format(Data1.Recordset!TM_TIR_TRAN, "#,##0.0000"), Format(Data1.Recordset!TM_TIR, "#,##0.0000"))
            .TextMatrix(X, nColVTran) = IIf(Data1.Recordset!TM_Pvp_TRAN <> 0, Format(Data1.Recordset!TM_Pvp_TRAN, "#,##0.0000"), Format(Data1.Recordset!TM_Pvp, "#,##0.0000"))
            .TextMatrix(X, nColVPTran) = IIf(Data1.Recordset!tm_vp_TRAN <> 0, Format(Data1.Recordset!tm_vp_TRAN, "#,##0.0000"), Format(Data1.Recordset!TM_VP, "#,##0.0000"))
            .TextMatrix(X, nColDifTran) = 0

            '--> Se cambio, la columa esta corrida en uno, la Constante nCol_UM, no tiene la moneda, si no nCol_NOMINAL
            '.TextMatrix(x, nColDifTran) = Format(Val(Data1.Recordset!TM_VPMO) - Val(Data1.Recordset!tm_VP_TRAN_MO), "#,###,###,##0" + IIf(Table1.TextMatrix(Table1.Row, nCol_UM) <> "CLP", ".0000", ""))

            .TextMatrix(X, nColDifTran) = Format(Val(Data1.Recordset!TM_VPMO) - Val(Data1.Recordset!tm_VP_TRAN_MO), "#,###,###,##0" + IIf(Trim(Table1.TextMatrix(Table1.Row, nCol_NOMINAL)) <> "CLP", ".0000", ""))
            

            .TextMatrix(X, nColDif_CLP) = Format(CDbl(Data1.Recordset!TM_VP) - CDbl(Data1.Recordset!tm_vp_TRAN), "#,##0")

            If UCase(Trim(Table1.TextMatrix(Table1.Row, nColMoneda))) = "USD" Then
                nTipoCambio = 0
                nTipoCambio = funcBuscaTipcambio(Data1.Recordset!tm_monemi, gsBac_Fecp)
                Table1.TextMatrix(Table1.Row, nColDif_CLP) = Format(Table1.TextMatrix(Table1.Row, nColDifTran) * IIf(Data1.Recordset!tm_monemi <> "CLP", nTipoCambio, 1), "#,##0")
                .TextMatrix(X, nColDif_CLP) = Format((.TextMatrix(X, nColDifTran) * nTipoCambio), "#,##0")
           'Else
           '    Table1.TextMatrix(Table1.Row, nColDif_CLP) = Table1.TextMatrix(Table1.Row, nColDifTran)
            End If

            .TextMatrix(X, nColDurationMac) = Format(Data1.Recordset!tm_durmacori, FDecimal)
            .TextMatrix(X, nColDurationMod) = Format(Data1.Recordset!tm_durmodori, FDecimal)
            .TextMatrix(X, nColConvex) = Format(Data1.Recordset!tm_convex, FDecimal)
            .TextMatrix(X, nColLibro) = IIf(IsNull(Data1.Recordset!tm_id_libro) = True, "", Trim(Data1.Recordset!tm_id_libro))
            .TextMatrix(X, nColValuta) = Data1.Recordset!tm_modpago

            Envia = Array()
            AddParam Envia, 1
            AddParam Envia, GLB_CARTERA_NORMATIVA
            AddParam Envia, GLB_ID_SISTEMA
            AddParam Envia, Trim(Data1.Recordset!tm_carterasuper)

            If Bac_Sql_Execute("SP_CON_INFO_COMBO", Envia) Then
              
                Do While Bac_SQL_Fetch(oDatos())
                    .TextMatrix(X, nColCarteraSuper) = Trim(oDatos(6))
                Loop
            Else
                .TextMatrix(X, nColCarteraSuper) = "NO ESPECIFICADO"
            End If

            If Trim(.TextMatrix(X, nColEstado)) <> "" Then
               For nContador = 0 To Table1.cols - 1
                  Table1.Col = nContador
                  .Row = X
                  Call Table1_LeaveCell
                  Call Table1_RowColChange
               Next nContador
            End If
         
        End With
        
        Data1.Recordset.MoveNext
    Loop
   
   Table1.Col = nColMoneda
   Table1.Redraw = True
End Sub
Private Sub cmbMonLiq_Change()

End Sub


Private Sub Chk_Dif_CLP_Click()

    If Chk_Dif_CLP.Value = 0 Then
        Table1.ColWidth(nColDif_CLP) = 0
    Else
        Table1.ColWidth(nColDif_CLP) = 2000
    End If

End Sub

Private Sub Combo1_GotFocus()
   Call PROC_POSI_TEXTO(Table1, Combo1)
End Sub

Private Sub Combo1_KeyDown(KeyCode As Integer, Shift As Integer)
   
If KeyCode = 27 Then
    Combo1_LostFocus
End If

If KeyCode = 13 Then
      If Not Table1.Rows = 1 Then
        Call Colocardata1
      Else
         Data1.Recordset.MoveFirst
      End If
    
        If Table1.Col = nColCustodia Then ''''7
            ' ------------------------------------------------------------------------------------
            ' +++VFBF 20180620 SE AGREGA NUEVO OPCION DE TIPO DE PAGO
            ' ------------------------------------------------------------------------------------
                  If Me.TipoPago.ListIndex = 2 Then
                    If Combo1.ListIndex <> 1 Then
                        MsgBox "Para operaciones T+2 (Contado Normal) la custodia valida solo es DCV", vbExclamation, TITSISTEMA
                        Combo1.ListIndex = 1
                    End If
                  End If
            ' ------------------------------------------------------------------------------------
            ' ---VFBF 20180620 SE AGREGA NUEVO OPCION DE TIPO DE PAGO
            ' ------------------------------------------------------------------------------------

            Data1.Recordset.Edit
            Select Case Combo1.ListIndex 'UCase$(Left(Combo1.Text, 1)) 'Chr(KeyCode))
            Case 0:
            
                Data1.Recordset("tm_custodia") = "CLIENTE"
                Data1.Recordset("tm_clave_dcv") = " "
                Table1.TextMatrix(Table1.Row, 7) = "CLIENTE"
                Table1.TextMatrix(Table1.Row, 8) = ""
                KeyCode = 13
            Case "1":
               ' If Not IsNull(Data1.Recordset("tm_custodia")) Then
               '     If Trim$(Data1.Recordset("tm_custodia")) <> "DCV" Then
               '         Data1.Recordset("tm_custodia") = "DCV"
               '         Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
               '         Table1.TextMatrix(Table1.Row, 6) = "DCV"
               '         Table1.TextMatrix(Table1.Row, 7) = Data1.Recordset("tm_clave_dcv")
               '         KeyCode = 13
               '     Else
               '         KeyCode = 0
               '     End If
               ' Else
                    Data1.Recordset("tm_custodia") = "DCV"
                    Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
                    Table1.TextMatrix(Table1.Row, 7) = "DCV"
                    Table1.TextMatrix(Table1.Row, 8) = Data1.Recordset("tm_clave_dcv")
                        
                    KeyCode = 13
               ' End If
            Case "2":
                Data1.Recordset("tm_custodia") = "PROPIA"
                Data1.Recordset("tm_clave_dcv") = " "
                Table1.TextMatrix(Table1.Row, 7) = "PROPIA"
                Table1.TextMatrix(Table1.Row, 8) = ""
                
                KeyCode = 13
            Case Else
                KeyCode = 0
            End Select
            Data1.Recordset.Update
            Combo1.Visible = False
            Table1.SetFocus
        End If
        
End If
End Sub

Private Sub Combo1_LostFocus()

    Combo1.Visible = False
    Table1.SetFocus

    If Table1.Col + 1 < Table1.cols Then
        Table1.Col = Table1.Col + 1

    End If

End Sub


Private Sub data1_Error(DataErr As Integer, Response As Integer)

    'No Current Record
    If DataErr = 3021 Then
        DataErr = 0
        Response = 0
    End If
    
End Sub

Private Sub Flt_Result_KeyDown(KeyCode As Integer, Shift As Integer)
   KeyCode = 0
End Sub

Private Sub Flt_Result_KeyPress(KeyAscii As Integer)
    KeyAscii = 0
End Sub


Private Sub Form_Activate()
Dim X As Integer
   
   Me.Tag = "VP"
   Tipo_Operacion = "VP"
   Data1.Refresh
   iFlagKeyDown = True
   Screen.MousePointer = vbHourglass
   Screen.MousePointer = vbDefault
   RutCartV = nRutCartV
   DvCartV = cDvCartV
   NomCartV = cNomCartV
        
Exit Sub

BacErrHnd:
    Screen.MousePointer = vbDefault
    On Error GoTo 0
    Exit Sub
End Sub
Sub Nombre_Grilla()

' Configurar las columnas de la grid.-
    Table1.TextMatrix(0, nColEstado) = "M"
    Table1.TextMatrix(0, nColSerie) = "Serie"
    Table1.TextMatrix(0, nColMoneda) = "UM"
    Table1.TextMatrix(0, nColNominal) = "Nominal"
    Table1.TextMatrix(0, nColTir) = "%Tir"
    Table1.TextMatrix(0, nColVPar) = "%Vpar"
    Table1.TextMatrix(0, nColValorPresente) = "Valor Presente"
    Table1.TextMatrix(0, nColCustodia) = "Custodia"
    Table1.TextMatrix(0, nColClaveDCV) = "Clave DCV"
    Table1.TextMatrix(0, nColTirCompra) = "%Tir C."
    Table1.TextMatrix(0, nColVParCompra) = "%Vpar C."
    Table1.TextMatrix(0, nColValorCompra) = "Valor de Compra"
    Table1.TextMatrix(0, nColUtilidad) = "Utilidad"
    
    Table1.TextMatrix(0, nColTTran) = "Tir Trans."
    Table1.TextMatrix(0, nColVTran) = "V.Par.Trans"
    Table1.TextMatrix(0, nColVPTran) = "VP Trans"
    Table1.TextMatrix(0, nColDifTran) = "Dif. Trans"
    
    Table1.TextMatrix(0, nColDif_CLP) = "Dif. Trans CLP"
    
    Table1.TextMatrix(0, nColCarteraSuper) = "Nombre Cartera Super"
    Table1.TextMatrix(0, nColDurationMac) = "Duration Mac"
    Table1.TextMatrix(0, nColDurationMod) = "Duration Mod"
    Table1.TextMatrix(0, nColConvex) = "Convexidad"
    Table1.TextMatrix(0, nColLibro) = "Codigo Libro"
    Table1.TextMatrix(0, nColValuta) = "Valuta" 'M = pago mañana
        
    Table1.ColWidth(nColEstado) = 400
    Table1.ColWidth(nColSerie) = 1500
    Table1.ColWidth(nColMoneda) = 500
    Table1.ColWidth(nColNominal) = 1800
    Table1.ColWidth(nColTir) = 900
    Table1.ColWidth(nColVPar) = 900
    Table1.ColWidth(nColValorPresente) = 2800 'antes 1800
    Table1.ColWidth(nColCustodia) = 1200
    Table1.ColWidth(nColClaveDCV) = 1200
    Table1.ColWidth(nColTirCompra) = 900
    Table1.ColWidth(nColVParCompra) = 900
    Table1.ColWidth(nColValorCompra) = 1800
    Table1.ColWidth(nColUtilidad) = 0 '2500
    
    Table1.ColWidth(nColTTran) = 900
    Table1.ColWidth(nColVTran) = 900
    Table1.ColWidth(nColVPTran) = 1800
    Table1.ColWidth(nColDifTran) = 0        '-> 2500
    Table1.ColWidth(nColDif_CLP) = 2500     '-> 0
    
    Table1.ColWidth(nColCarteraSuper) = 1700
    Table1.ColWidth(nColDurationMac) = 0  'Tm_Duracori
    Table1.ColWidth(nColDurationMod) = 0  'Tm_Durmodori
    Table1.ColWidth(nColConvex) = 0       'Tm_Convex
    Table1.ColWidth(nColLibro) = 0        'Codigo Libro
    Table1.ColWidth(nColValuta) = 0       'Pago Mañana
    
    Chk_Dif_CLP.Value = 0 'oculta columna de valor en pesos
    
End Sub

Private Sub Form_Load()

    TxtInv.SelStart = 1
    
    Me.Top = 0
    Me.Left = 0
    Tipo_Operacion = "VP"
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(4).Enabled = False
    Toolbar1.Buttons(5).Enabled = True
    Toolbar1.Buttons(6).Enabled = False
    Toolbar1.Buttons(7).Enabled = False
    Toolbar1.Buttons(8).Enabled = False
    
    TxtTotal.Enabled = False
    PnlLibro.Caption = ""
    
    FormHandle = Me.hWnd
    iFlagKeyDown = True
    
    Call VENTA_IniciarTx(FormHandle, Data1, "1")
    
    Call objMonLiq.LeerCodigos(22)
        
    Table1.cols = 24
    Nombre_Grilla
    
    Data1.Refresh
    Toolbar1.Buttons(6).Tag = "Ver Sel."
    FiltroAutomatico = False
    Toolbar1.Buttons(6).Enabled = False
    Table1.Enabled = False
    TxtInv.Enabled = True
    Flt_Result.Enabled = True
    
    Call TipoPago.AddItem("HOY"):    Let TipoPago.ItemData(TipoPago.NewIndex) = 0
    Call TipoPago.AddItem("MAÑANA"): Let TipoPago.ItemData(TipoPago.NewIndex) = 1
  
' ------------------------------------------------------------------------------------
' +++VFBF 20180621 SE AGREGA NUEVO OPCION DE TIPO DE PAGO
' ------------------------------------------------------------------------------------
    Call TipoPago.AddItem("T+2"): Let TipoPago.ItemData(TipoPago.NewIndex) = 2
' ------------------------------------------------------------------------------------
' ---VFBF 20180621 SE AGREGA NUEVO OPCION DE TIPO DE PAGO
' ------------------------------------------------------------------------------------
    
    Let TipoPago.ListIndex = 0
    Let oTipoPago = TipoPago.ListIndex
    
    Call Proc_Consulta_Porcentaje_Transacciones("VP")
    
    Call LeeModoControlPT   'PRD-3860, modo silencioso
    
End Sub
Private Sub Form_Resize()
'On Error GoTo BacErrHnd
'
'Dim lScaleWidth&, lScaleHeight&, lPosIni&
'
'    ' Cuando la ventana es minimizada, se ignora la rutina.-
'    If Me.WindowState = 1 Then
'        ' Pinta borde del icono.-
'        Dim x!, Y!, J%
'
'        x = Me.Width
'        Y = Me.Height
'        For J% = 1 To 15
'            Line (0, 0)-(x, 0), QBColor(Int(Rnd * 15))
'            Line (x, 0)-(x, Y), QBColor(Int(Rnd * 15))
'            Line (x, Y)-(0, Y), QBColor(Int(Rnd * 15))
'            Line (0, Y)-(0, 0), QBColor(Int(Rnd * 15))
'            DoEvents
'        Next
'        Exit Sub
'
'    End If
'
'  ' Escalas de medida de la ventana.-
'    lScaleWidth& = Me.ScaleWidth
'    lScaleHeight& = Me.ScaleHeight
'
'  ' Resize la ventana customizado.-
'    If Me.WindowState <> 1 And Me.Width > 400 And Me.Height > 2100 Then
'        Table1.Width = Me.Width - 300
'        Table1.Height = Me.Height - 2050
'        FrmMontos.Top = Me.Height - 1050
'    End If
                
      Exit Sub

BacErrHnd:
    
    On Error GoTo 0
    Resume Next

End Sub

 Private Sub Form_Unload(Cancel As Integer)
   'Elimina los registros de la tabla de bloqueados
   Call VENTA_EliminarBloqueados(Data1, FormHandle)
   'Eliminar los registros del temporal que tengan hwnd igual
   Call VENTA_BorrarTx(FormHandle)
   
   Set objMonLiq = Nothing
   Set objDCartera = Nothing
End Sub

Private Sub OptDvp_Click(Index As Integer)
   Select Case Index
      Case 0
         glBacCpDvpVp = No
      Case 1
         glBacCpDvpVp = Si
   End Select
   
   Toolbar1.Enabled = True
   Cuadrodvp.Enabled = False
   TipoPago.Enabled = False
End Sub

Private Sub SSC_Grabar_Click()
'Dim rRs As Recordset
'Data1.Refresh
'    Set rRs = db.OpenRecordset("SELECT DISTINCT tm_monemi FROM MDVENTA WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )", dbOpenSnapshot)
'
'    If rRs.RecordCount > 0 Then
'       If Not IsNull(rRs.Fields("tm_monemi")) Then
'          BacIrfGr.proMoneda = IIf(rRs.Fields("tm_monemi") = 13, gsBac_Dolar, "$$")
'       End If
'    End If
'
'    BacIrfGr.proMtoOper = TxtTotal.Text
'    BacIrfGr.proHwnd = hWnd
'
'    Call BacGrabarTX
'
'    BacControlWindows 100
'
'    If Not Grabacion_Operacion Then
'       Data1.Refresh
'    End If
    
End Sub

Private Sub Table1_ColumnChange()
   iFlagKeyDown = True
End Sub

Private Sub Table1_EnterEdit()
'    iFlagKeyDown = False
'
'    If TABLE1.ColumnIndex = Ven_NOMINAL Then
'       bufNominal = Val(Data1.Recordset("tm_nominalo"))
'    End If
End Sub

Private Sub Table1_ExitEdit()
     iFlagKeyDown = True
End Sub

Private Sub Table1_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)
'    If Col = TABLE1.ColumnIndex And Row = TABLE1.RowIndex Then
'        FgColor = BacToolTip.Color_Dest.ForeColor
'        BgColor = BacToolTip.Color_Dest.BackColor
'    Else
'        If Data1.Recordset.RecordCount > 0 Then
'            If TABLE1.ColumnText(Ven_MARCA) = "V" Then
'                FgColor = BacToolTip.Color_VentaNormal.ForeColor
'                BgColor = BacToolTip.Color_VentaNormal.BackColor
'            ElseIf TABLE1.ColumnText(Ven_MARCA) = "P" Then
'                    FgColor = BacToolTip.Color_ParcialED.ForeColor
'                    BgColor = BacToolTip.Color_ParcialED.BackColor
'            ElseIf TABLE1.ColumnText(Ven_MARCA) = "*" Then
'                    FgColor = BacToolTip.Color_Bloqueado.ForeColor
'                    BgColor = BacToolTip.Color_Bloqueado.BackColor
'          ElseIf (Col > 0 And Col < 4) Or Col > 7 Then
'                FgColor = BacToolTip.Color_No_Edit.ForeColor
'                BgColor = BacToolTip.Color_No_Edit.BackColor
'            Else
'                FgColor = BacToolTip.Color_Normal.ForeColor
'                BgColor = BacToolTip.Color_Normal.BackColor
'            End If
'
'        End If
'    End If
'
End Sub

Private Sub Table1_DblClick()
   
   If Table1.Col = nColCustodia And (Table1.TextMatrix(Table1.Row, nColEstado) = "V" Or Table1.TextMatrix(Table1.Row, nColEstado) = "P") Then
      Combo1.Visible = True
      Combo1.SetFocus
   End If
End Sub

Private Sub TABLE1_EnterCell()
'**********************************************************
    If Table1.TextMatrix(Table1.Row, nColValuta) = "M" Then
        Table1.ForeColorSel = vbRed
    Else
        Table1.BackColorSel = vbHighlight
        Table1.ForeColorSel = vbHighlightText
    End If

'**********************************************************

End Sub

Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)
columnita = Table1.Col
     
 If KeyCode = vbKeyReturn And KeyCode <> vbKeyV _
                 And KeyCode <> vbKeyR _
                 And KeyCode <> vbKeyF7 _
                 And KeyCode <> vbKeyF3 _
                 And ((Table1.Col > nColMoneda _
                 And Table1.Col < nColCustodia) Or (Table1.Col >= nColTTran And Table1.Col <= nColVPTran)) Then  ' 86 = v / 82 = r / 118 = F7 / 114 = F3
      
      BacControlWindows 100
      
      Table1.Col = columnita
      Text1.Top = Table1.CellTop + Table1.Top + 20
      Text1.Left = Table1.CellLeft + Table1.Left + 20
      Text1.Width = Table1.CellWidth - 20
      Text1.Visible = True
      
      If KeyCode > vbKey0 And KeyCode <= vbKey9 Then
         Text1.text = Chr(KeyCode)
      End If
      
      If KeyCode = vbKeyReturn Then
         Text1.text = CDbl(Table1.TextMatrix(Table1.Row, Table1.Col))
      End If
      
      Text1.SetFocus
      Exit Sub
      
 End If

On Error GoTo KeyDownError
    'El Flag es false cuando se está editando un campo
    If iFlagKeyDown = False Then
        Exit Sub
    End If
            
    Exit Sub
    
KeyDownError:

    MsgBox Error(err), vbExclamation, "Mensaje"
    Data1.Refresh
    Exit Sub

End Sub


Private Sub Table1_KeyPress(KeyAscii As Integer)
Dim i          As Integer
Dim SQL        As String
Dim Datos()
Dim reg        As Double
Dim bloq       As String
Dim fila_table As Double
Dim Fila       As Integer
Dim nRowTop    As Integer
Dim nContador  As Integer

'Variables para control de Tasas y Precios
Dim ptPlazo As Integer
Dim ptTasa As Double
Dim ptInstr As String

   nRowTop = Table1.TopRow

   Columna = Table1.Col

   If Table1.Col = nColClaveDCV And Trim(Table1.TextMatrix(Table1.Row, nColCustodia)) = "DCV" _
                    And (Trim(Table1.TextMatrix(Table1.Row, nColEstado)) = "V" _
                    Or Trim(Table1.TextMatrix(Table1.Row, nColEstado)) = "P") Then ''''8
    
      BacControlWindows 100
      
      Text2.text = Table1.TextMatrix(Table1.Row, Table1.Col)
      Text2.Visible = True
      Text2.MaxLength = 9
       
      If KeyAscii <> vbKeyReturn Then
         Text2.text = UCase(Chr(KeyAscii))
      Else
         Text2.text = Table1.TextMatrix(Table1.Row, Table1.Col)
      End If
       
      Text2.SetFocus
      BacControlWindows 100
      Exit Sub
       
   End If

   If KeyAscii <> vbKeyV And KeyAscii <> vbKeyR _
                     And KeyAscii <> vbKeyF7 _
                     And KeyAscii <> vbKeyF3 _
                     And Table1.Col = nColCustodia _
                     And (Table1.TextMatrix(Table1.Row, nColEstado) = "V" _
                     Or Table1.TextMatrix(Table1.Row, nColEstado) = "P") Then
        
      If KeyAscii = vbKeyP Or KeyAscii = 112 Then
         Combo1.ListIndex = 2

      ElseIf KeyAscii = vbKeyD Or KeyAscii = 100 Then
         Combo1.ListIndex = 1

      ElseIf KeyAscii = vbKeyC Or KeyAscii = 99 Then
         Combo1.ListIndex = 0

      End If

      Combo1.Visible = True
      Call PROC_POSI_TEXTO(Table1, Combo1)
      Combo1.SetFocus
      Exit Sub
        
   End If
       
   If KeyAscii <> vbKeyV And KeyAscii <> vbKeyR _
                     And KeyAscii <> vbKeyF7 _
                     And KeyAscii <> vbKeyF3 _
                     And ((Table1.Col > nColMoneda _
                     And Table1.Col < nColCustodia) Or (Table1.Col >= nColTTran And Table1.Col <= nColVPTran)) Then
                     
      BacControlWindows 100
      Table1.Col = columnita
      Text1.Top = Table1.CellTop + Table1.Top + 20
      Text1.Left = Table1.CellLeft + Table1.Left + 20
      Text1.Width = Table1.CellWidth - 20
      Text1.Visible = True

      If columnita = nColTir Or columnita = nColVPar Or columnita = nColTTran Or columnita = nColVTran Then
         Text1.Max = "9999.9999"
      Else
         Text1.Max = "99999999999.9999"
      End If

      
      If Table1.Col = nColValorPresente Or Table1.Col = nColVPTran Then
         If Trim(Table1.TextMatrix(Table1.Row, nColMoneda)) = "USD" Then
            Text1.CantidadDecimales = 2
         Else
            Text1.CantidadDecimales = 0
         End If

      Else
         If bFlagDpx Then
            Text1.CantidadDecimales = 2

         Else
            Text1.CantidadDecimales = 4

         End If

      End If

      If KeyAscii >= vbKey0 And KeyAscii <= vbKey9 Then
         Text1.text = Chr(KeyAscii)

      End If

      If KeyAscii = vbKeyReturn Then
         Text1.text = CDbl(Table1.TextMatrix(Table1.Row, Table1.Col))

      End If

      Text1.SetFocus
      Exit Sub

   End If

   filita = Table1.Row
   columnita = Table1.Col
   fila_table = Table1.Row - 1

   If Not Table1.Row = 1 Then
      Call Colocardata1

   Else
      Data1.Recordset.MoveFirst

   End If

   BacToUCase KeyAscii

   If UCase$(Table1.TextMatrix(Table1.Row, Table1.Col)) = "CLAVE DCV" Then
      If Trim$(Data1.Recordset("tm_custodia")) <> "DCV" Or (Trim$(Data1.Recordset("tm_venta")) = "" Or Trim$(Data1.Recordset("tm_venta")) = "*") Then
         KeyAscii = 0
         Exit Sub

      End If

   End If

   If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii = Asc(gsBac_PtoDec)

   End If

   If KeyAscii = vbKeyEscape Then
      iFlagKeyDown = True
      Exit Sub

   End If

   Select Case Table1.Col
   Case Ven_NOMINAL:

      If Not iFlagKeyDown Then
         KeyAscii = BacPunto(Table1, KeyAscii, 12, 4)

      End If

      If Not IsNumeric(Chr(KeyAscii)) And (Chr(KeyAscii) <> "," And Chr(KeyAscii) <> "." And KeyAscii <> vbKeyBack And KeyAscii <> vbKeyR And KeyAscii <> vbKeyV) Then ''''And (KeyAscii <> 44 And KeyAscii <> 46 And KeyAscii <> 8 And KeyAscii <> 82 And KeyAscii <> 86) Then
         KeyAscii = 0

      End If

   Case Ven_TIR, Ven_VPAR
      If Not iFlagKeyDown Then
         KeyAscii = BacPunto(Table1, KeyAscii, 3, 4)
      End If

      If Not IsNumeric(Chr(KeyAscii)) And (Chr(KeyAscii) <> "," And Chr(KeyAscii) <> "." And KeyAscii <> vbKeyBack And KeyAscii <> vbKeyR And KeyAscii <> vbKeyV) Then
         KeyAscii = 0
      End If

   End Select

   ' Tecla "R" - Restaura
   If KeyAscii = vbKeyR Then
      KeyAscii = 0

      Call VENTA_VerDispon(FormHandle, Data1)

      If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
         If VENTA_DesBloquear(FormHandle, Data1) Then
            Data1.Recordset.Edit
            Data1.Recordset("tm_venta") = " "
            Data1.Recordset("tm_clave_dcv") = ""
            Data1.Recordset.Update

            If Toolbar1.Buttons(6).Tag = "Ver Todos" And Table1.Rows - 1 = 1 Then
               Toolbar1.Buttons(6).Tag = "Ver Sel."
               Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1"
               Data1.Refresh

            ElseIf Toolbar1.Buttons(6).Tag = "Ver Todos" And Data1.Recordset.RecordCount > 1 Then
               Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
               Data1.Refresh

            End If

         End If

         If Data1.Recordset("tm_venta") = "*" Then
            If VENTA_VerBloqueo(FormHandle, Data1) Then
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = " "
               Data1.Recordset.Update

            End If

         End If

         If Data1.Recordset.RecordCount > 0 Then
            Call VENTA_Restaurar(Data1)
            Call VENTA_Valorizar(2, Data1, FechaPago.text, "TRAN")
         End If

         Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))

         TxtTotal.text = VENTA_SumarTotal(FormHandle)
         Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")

         If CDbl(Flt_Result.Caption) < 0 Then
            Flt_Result.ForeColor = &HFF&
            Flt_Result.Caption = Format(Abs(CDbl(Flt_Result.Caption)), "###,###,###,##0.00")

         Else
            Flt_Result.ForeColor = &H0&

         End If

         Data1.Recordset.MoveLast
         Table1.Rows = Data1.Recordset.RecordCount + 1
         Data1.Refresh

         Call Llenar_Grilla
 
         KeyAscii = 0
         BacVP.bSelPagoMañana = False
        
        For nContador = 1 To Table1.Rows - 1
            If Table1.TextMatrix(nContador, 0) = "V" And Table1.TextMatrix(nContador, nColValuta) = "M" Then
                BacVP.bSelPagoMañana = True
                Exit For
            End If
        Next nContador
        
      ElseIf Data1.Recordset("tm_venta") = "B" Then
         If VENTA_DesBloquear(0, Data1) Then
            Data1.Recordset.Edit
            Data1.Recordset("tm_venta") = " "
            Data1.Recordset.Update

            Call VENTA_Restaurar(Data1)

            Table1.TextMatrix(Table1.Row, nColEstado) = Data1.Recordset("tm_venta")

            For i = 0 To Table1.cols - 1
               Table1.Col = i
               Call Table1_LeaveCell
            Next i
         End If
      End If
   End If

   'V
   If KeyAscii = vbKeyV Then   ' Tecla "V" - Venta
      If glBacCpDvpVp = Si Then
         Dim oContador  As Long
         Dim oFilas     As Long
         For oFilas = 1 To Table1.Rows - 1
            If Table1.TextMatrix(oFilas, 0) = "V" Then
               oContador = oContador + 1
            End If
         Next oFilas
         
         If oContador = 10 Then
            MsgBox "No se permite seleccionar mas de 10 documentos por operación.", vbExclamation, TITSISTEMA
            If Table1.Enabled = True Then:
            Exit Sub
         End If
      End If
      
      Fila = Table1.Row
      Columna = Table1.Col
      Table1.ScrollBars = flexScrollBarNone

      If VENTA_VerDispon(FormHandle, Data1) Then
         If Data1.Recordset("tm_venta") = " " Or Data1.Recordset("tm_venta") = "*" Or Data1.Recordset("tm_venta") = "B" Then
            If VENTA_Bloquear(FormHandle, Data1) Then
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "V"

               If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
                  Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV

               Else
                  Data1.Recordset("tm_clave_dcv") = ""

               End If

               Data1.Recordset.Update
               'Aplicar Control de Precios y Tasas
               ptPlazo = DateDiff("D", gsBac_Fecp, Data1.Recordset("tm_fecsal"))
               'ptInstr = Data1.Recordset("tm_instser")
               ptInstr = Data1.Recordset("tm_codigo")
               ptTasa = Data1.Recordset("tm_tir")
               
               'Como aun no conozco al cliente...
               Ctrlpt_RutCliente = "0"
               Ctrlpt_CodCliente = "0"

               If ControlPreciosTasas("VP", ptInstr, ptPlazo, ptTasa) = "S" Then
                If Ctrlpt_ModoOperacion <> "S" Then 'PRD-3860, modo silencioso
                    MsgBox Ctrlpt_Mensaje, vbExclamation, TITSISTEMA
                    Table1.SetFocus
               End If
               End If
               Table1.TextMatrix(Table1.Row, nColClaveDCV) = Data1.Recordset("tm_clave_dcv")
               Call funcFindDatGralMoneda(Val(Data1.Recordset("tm_monemi")))
               SwMx = BacDatGrMon.mnmx

               Call VENTA_Valorizar(2, Data1, FechaPago.text, "TRAN")
               Call VENTA_Valorizar(2, Data1, FechaPago.text, "")

            Else
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "*"
               Data1.Recordset.Update

            End If

         End If

      End If
      Call VENTA_Valorizar(2, Data1, FechaPago.text)
      
      TxtTotal.text = VENTA_SumarTotal(FormHandle)
      Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")

      If CDbl(Flt_Result.Caption) < 0 Then
         Flt_Result.ForeColor = &HFF&
         Flt_Result.Caption = Format(Abs(CDbl(Flt_Result.Caption)), "###,###,###,##0.00")

      Else
         Flt_Result.ForeColor = &H0&
         
      End If

      Table1.TextMatrix(Table1.Row, nColEstado) = Data1.Recordset("tm_venta")

        KeyAscii = 0
        
        Call Llenar_Grilla
       
        Table1.Row = Fila
      
        BacVP.bSelPagoMañana = False
        
        For nContador = 1 To Table1.Rows - 1
            If Table1.TextMatrix(nContador, nColEstado) = "V" And Table1.TextMatrix(nContador, nColValuta) = "M" Then
                BacVP.bSelPagoMañana = True
                Exit For
            End If
        Next nContador
    
        KeyAscii = 0
        Call Llenar_Grilla
        Table1.Row = Fila
   End If

   If KeyAscii = vbKeyB Then
      If VENTA_VerDispon(FormHandle, Data1) Then
         If Data1.Recordset("tm_venta") = " " Or Data1.Recordset("tm_venta") = "*" Then
            
            If VENTA_Bloquear(0, Data1) Then
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "B"
               Data1.Recordset.Update
            Else
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "*"
               Data1.Recordset.Update
            End If

            Table1.TextMatrix(Table1.Row, nColEstado) = Data1.Recordset("tm_venta")

            For i = 0 To Table1.cols - 1
               Table1.Col = i
               Call Table1_LeaveCell

            Next i
         End If
      End If
   End If

   If filita <= Table1.Rows - 1 Then
      Table1.Row = filita

   Else
      Table1.Row = Table1.Rows - 1

   End If

   Table1.Col = Columna
   Table1.SetFocus

   Table1.ScrollBars = flexScrollBarBoth
   Table1.TopRow = nRowTop

End Sub

Private Sub Table1_Update(Row As Long, Col As Integer, Value As String)
'On Error GoTo ExitEditError
'
'Dim Columna%
'Dim reg As Double
'
'    MousePointer = 11
'
'    Columna = TABLE1.ColumnIndex
'
'    If Data1.Recordset.RecordCount = 0 Then
'        MousePointer = 0
'        Exit Sub
'    End If
'
'    Data1.Recordset.Edit
'    Data1.Recordset.Update
'
'    'Para que el datos aparezca en la grid
'    BacControlWindows 60
'
'    If Columna = Ven_NOMINAL Then
'        If VENTA_VerDispon(FormHandle, Data1) Then
'            If Val(TABLE1.ColumnText(Ven_NOMINAL)) <> Data1.Recordset("tm_nominalo") Then
'                If Val(TABLE1.ColumnText(Ven_NOMINAL)) > bufNominal Then
'                    MsgBox "Valor nominal ingresado es mayor al monto nominal disponible " & vbCrLf & vbCrLf & " Debido a esto se restaurara  el valor nominal original", vbExclamation, "Mensaje"
'                    Data1.Recordset.Edit
'                    Data1.Recordset("tm_nominal") = Data1.Recordset("tm_nominalo")
'                    Data1.Recordset.Update
'                    BacControlWindows 30
'                    If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
'                        If VENTA_DesBloquear(FormHandle, Data1) Then
'                            Data1.Recordset.Edit
'                            Data1.Recordset("tm_venta") = " "
'                            Data1.Recordset("tm_clave_dcv") = " "
'                            Data1.Recordset.Update
'                        End If
'                    End If
'                    Call VENTA_Restaurar(Data1)
'                    Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))
'                Else
'                    If VPVI_LeerCortes(Data1, FormHandle) Then
'                        If Trim(Data1.Recordset("tm_venta")) = "" And Data1.Recordset("tm_nominal") <> Data1.Recordset("tm_nominalo") Then
'                            If VENTA_Bloquear(FormHandle, Data1) Then
'                                Data1.Recordset.Edit
'                                Data1.Recordset("tm_venta") = "P"
'                                If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
'                                   Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
'                                Else
'                                   Data1.Recordset("tm_clave_dcv") = " "
'                                End If
'                                Data1.Recordset.Update
'                            Else
'                                Data1.Recordset.Edit
'                                Data1.Recordset("tm_venta") = "*"
'                                Data1.Recordset.Update
'                            End If
'                        Else
'                            If Data1.Recordset("tm_venta") = "V" Then
'                                Data1.Recordset.Edit
'                                Data1.Recordset("tm_venta") = "P"
'                                If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
'                                   Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
'                                Else
'                                   Data1.Recordset("tm_clave_dcv") = " "
'                                End If
'                                Data1.Recordset.Update
'                            End If
'                        End If
'                    Else
'                        If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
'                            If VENTA_DesBloquear(FormHandle, Data1) Then
'                                Data1.Recordset.Edit
'                                Data1.Recordset("tm_venta") = " "
'                                Data1.Recordset("tm_custodia") = " "
'                                Data1.Recordset.Update
'                            End If
'                        End If
'                        Call VENTA_Restaurar(Data1)
'                        Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlativo"))
'                    End If
'                End If
'            Else
'                If Data1.Recordset("tm_venta") = "P" Then
'                    Data1.Recordset.Edit
'                    Data1.Recordset("tm_venta") = "V"
'                    If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
'                        Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
'                    Else
'                        Data1.Recordset("tm_clave_dcv") = ""
'                    End If
'                        Data1.Recordset.Update
'
'                ElseIf Data1.Recordset("tm_venta") = " " Then
'                        If VENTA_Bloquear(FormHandle, Data1) Then
'                            Data1.Recordset.Edit
'                            Data1.Recordset("tm_venta") = "V"
'                            If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
'                               Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
'                            Else
'                               Data1.Recordset("tm_clave_dcv") = ""
'                            End If
'                            Data1.Recordset.Update
'                        Else
'                            Data1.Recordset.Edit
'                            Data1.Recordset("tm_venta") = "*"
'                            Data1.Recordset.Update
'                        End If
'                End If
'            End If
'        End If
'
'        If Val(TABLE1.ColumnText(Ven_TIR)) <> 0 Then
'            Call VENTA_Valorizar(2, Data1)
'        ElseIf Val(TABLE1.ColumnText(Ven_TIR)) <> 0 Then
'                Call VENTA_Valorizar(1, Data1)
'        ElseIf Val(TABLE1.ColumnText(Ven_VPAR)) <> 0 Then
'                Call VENTA_Valorizar(3, Data1)
'        End If
'
'    ElseIf Columna = Ven_TIR Then
'            Call VENTA_Valorizar(2, Data1)
'    ElseIf Columna = Ven_VPAR Then
'            Call VENTA_Valorizar(1, Data1)
'    ElseIf Columna = Ven_VPS Then
'            Call VENTA_Valorizar(3, Data1)
'    End If
'
'    If Columna = Ven_NOMINAL Or Columna = Ven_TIR Or Columna = Ven_VPAR Then
'    '  Verifica si la TIR se encuentra dentro de
'    '  los rangos calculados.
'        Dim Cota_SUP     As Double
'        Dim Cota_INF     As Double
'        Dim Porcentaje   As Double
'
'      ' If ValidaRango(data1.Recordset("tm_serie"), data1.Recordset("tm_fecven"), data1.Recordset("tm_tir"), Cota_SUP#, Cota_INF#, Porcentaje#) = False Then
'      '     If Cota_SUP# <> 0 Or Cota_INF# <> 0 Then
'      '         MsgBox "La TIR ingresada se encuentra fuera del RANGO establecido" & Chr(10) & "-Rango SUPERIOR   : " & Cota_SUP# & Chr(10) & "-Rango INFERIOR     : " & Cota_INF# & Chr(10) & "-Porcentaje Variación : " & Porcentaje#, 64
'      '     End If
'      ' End If
'    End If
'
'    BacControlWindows 12
'
'   'Sumar el total y desplegar.-
'    If Columna > 3 Then
'        TxtTotal.Text = VENTA_SumarTotal(FormHandle)
'        Flt_Result.caption = VENTA_SumarDif(FormHandle)
'        If Val(Flt_Result.caption) < 0 Then
'            Flt_Result.ForeColor = &HFF&
'            Flt_Result.caption = Abs(Val(Flt_Result.caption))
'        Else
'            Flt_Result.ForeColor = &H0&
'        End If
'    End If
'
'    If Columna = Ven_NOMINAL Then
'       SendKeys "{TAB 1}"
'    ElseIf Columna = Ven_TIR Then
'       SendKeys "{TAB 2}"
'    ElseIf Columna = Ven_VPAR Then
'       SendKeys "{TAB 1}"
'    End If
'
'    MousePointer = 0
'    iFlagKeyDown = True
'
'    Exit Sub
'
'ExitEditError:
'
'    MousePointer = 0
'    MsgBox Error(Err), vbExclamation, "Mensaje"
''    Resume
'    Data1.Refresh
'    iFlagKeyDown = True
'    Exit Sub
'
End Sub
'Private Sub Table1_Validate(Row As Long, Col As Integer, Value As String, Cancel As Integer)
'
'    If Data1.Recordset.RecordCount = 0 Then
'        Value = ""
'    End If
'
'    If UCase(TABLE1.ColumnName(Col)) <> "CLAVE DCV" Then
'        If IsNumeric(Value) = False Then
'            Cancel = True
'        End If
'    End If
'
'End Sub


Private Sub Table1_LeaveCell()
      
    If Mid(Table1.TextMatrix(Table1.Row, nColSerie), 1, 6) = "FMUTUO" And Table1.Col = nColTir Then
        Me.Text1.Enabled = False
        Me.Text2.Enabled = False
    Else
        Text1.Enabled = True
        Me.Text2.Enabled = True
    End If
   
    With Table1
   
        If .Row <> 0 And .Col > 1 Then
            .CellFontBold = True
            
            If .TextMatrix(.Row, nColEstado) = "V" Then
                .CellBackColor = &H800000    '--> vbBlue
                
                If .TextMatrix(.Row, nColValuta) = "M" Then
                    .CellForeColor = vbRed
                Else
                    .CellForeColor = vbWhite
                End If
                                           
            ElseIf .TextMatrix(.Row, nColEstado) = "P" Then
                .CellBackColor = vbCyan
                .CellForeColor = vbBlack
            
            ElseIf .TextMatrix(.Row, nColEstado) = "*" Then
                .CellBackColor = vbGreen + vbWhite    'vbBlack
                .CellForeColor = vbWhite
            
            ElseIf .TextMatrix(.Row, nColEstado) = "B" Then
                .CellBackColor = vbBlack + vbWhite    'vbBlack
                .CellForeColor = vbBlack
                
                If .TextMatrix(.Row, nColValuta) = "M" Then
                    .CellForeColor = vbRed
                Else
                    .CellForeColor = &H800000  '--> vbBlue
                End If
    
            End If
            
            .CellFontBold = False

        End If
    End With

End Sub

Private Sub Table1_RowColChange()

    With Table1
   
        If .Row <> 0 And .Col > nColSerie Then
            .CellFontBold = True
            
            If .TextMatrix(.Row, nColEstado) = "V" Then
                .CellBackColor = &H800000 '--> vbBlue
                .CellForeColor = vbWhite
            
            ElseIf .TextMatrix(.Row, nColEstado) = "P" Then
                .CellBackColor = vbCyan
                .CellForeColor = vbBlack
            
            ElseIf .TextMatrix(.Row, nColEstado) = "*" Then
                .CellBackColor = vbGreen + vbWhite    'vbBlack
                .CellForeColor = vbWhite
            
            ElseIf .TextMatrix(.Row, nColEstado) = "B" Then
                .CellBackColor = vbBlack + vbWhite    'vbBlack
                .CellForeColor = vbBlack
            
            Else
                .CellBackColor = vbBlack
                .CellForeColor = vbBlack
    
            End If
            
            .CellFontBold = False

        End If
    End With

End Sub


Private Sub Table1_Scroll()
Text1_LostFocus
End Sub

Private Sub Text1_GotFocus()
 
 If Table1.Col = nColValorPresente Or Table1.Col = nColVPTran Then
    Text1.SelStart = Len(Text1.text)
 Else
    If Mid(Table1.TextMatrix(Table1.Row, nColSerie), 1, 6) = "FMUTUO" And Table1.Col = nColTir Then ''''4
        Text1.Enabled = False
    Else
        Text1.Enabled = True
        If bFlagDpx Then
             Text1.SelStart = Len(Text1.text) - 3
        Else
            Text1.SelStart = Len(Text1.text) - 5
        End If
    End If
 
 End If

End Sub


Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)

Dim i As Integer
Dim Fila As Integer
Dim Anterior As Double

Dim v As String
Dim Colum As Integer
Dim nTopRow As Integer

If KeyCode = vbKeyEscape Then
   Text1.Visible = False
   Text1.text = 0
   Table1.SetFocus
End If

nTopRow = Table1.TopRow

Fila = Table1.Row
Antes_Flag = True
tipo = "VP"
Anterior = Table1.TextMatrix(Table1.Row, Table1.Col)

If KeyCode = vbKeyReturn Then
   Colum = Table1.Col
    If Not Table1.Row = 1 Then
            Call Colocardata1
    Else
            Data1.Recordset.MoveFirst
    End If
  
 ' ENTEREDIT
   iFlagKeyDown = False
   
    If Table1.Col = nColNominal Then
       bufNominal = Val(Data1.Recordset("tm_nominalo"))
    End If
 'UPDATE
 On Error GoTo ExitEditError

Dim Columna%
Dim reg As Double

    MousePointer = vbHourglass
           
    Columna = Table1.Col
    
    If Data1.Recordset.RecordCount = 0 Then
        MousePointer = vbDefault
        Exit Sub
    End If

    Data1.Recordset.Edit
    'Data1.Recordset.Update
    
    'Para que el datos aparezca en la grid
    BacControlWindows 60
    Table1.TextMatrix(Table1.Row, Table1.Col) = Text1.text
    
    If Columna = nColNominal Then
        Data1.Recordset!tm_nominal = Text1.text
        Data1.Recordset.Update
        
        If VENTA_VerDispon(FormHandle, Data1) Then
            If CDbl(Table1.TextMatrix(Table1.Row, nColNominal)) <> Data1.Recordset("tm_nominalo") Then
                If CDbl(Table1.TextMatrix(Table1.Row, nColNominal)) > bufNominal Then
                    MsgBox "Valor nominal ingresado es mayor al monto nominal disponible " & vbCrLf & vbCrLf & " Debido a esto se restaurara  el valor nominal original", vbExclamation, "Mensaje"
                    Data1.Recordset.Edit
                    Data1.Recordset("tm_nominal") = Data1.Recordset("tm_nominalo")
                    Data1.Recordset.Update
                    BacControlWindows 30
                    
                    If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
                        If VENTA_DesBloquear(FormHandle, Data1) Then
                            Data1.Recordset.Edit
                            Data1.Recordset("tm_venta") = " "
                            Data1.Recordset("tm_clave_dcv") = " "
                            Data1.Recordset.Update
                        End If
                    End If
                    
                    Call VENTA_Restaurar(Data1)
                    Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))
                Else
                    If VPVI_LeerCortes(Data1, FormHandle) Then
                        If Trim(Data1.Recordset("tm_venta")) = "" And Data1.Recordset("tm_nominal") <> Data1.Recordset("tm_nominalo") Then
                            If VENTA_Bloquear(FormHandle, Data1) Then
                                Data1.Recordset.Edit
                                Data1.Recordset("tm_venta") = "P"
                                If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
                                   Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
                                Else
                                   Data1.Recordset("tm_clave_dcv") = " "
                                End If
                              
                                Data1.Recordset.Update
                              
                            Else
                                Data1.Recordset.Edit
                                Data1.Recordset("tm_venta") = "*"
                                Data1.Recordset.Update
                               
                            End If
                        Else
                            If Data1.Recordset("tm_venta") = "V" Then
                                Data1.Recordset.Edit
                                Data1.Recordset("tm_venta") = "P"
                                If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
                                   Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
                                Else
                                   Data1.Recordset("tm_clave_dcv") = " "
                                End If
                                Data1.Recordset.Update
                            End If
                        End If
                    Else
                        If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
                            If VENTA_DesBloquear(FormHandle, Data1) Then
                                Data1.Recordset.Edit
                                Data1.Recordset("tm_venta") = " "
                                Data1.Recordset("tm_custodia") = " "
                                Data1.Recordset.Update
                            End If
                        End If
                        Call VENTA_Restaurar(Data1)
                        If Trim(Data1.Recordset("tm_venta")) <> "" Then
                            Call VENTA_DesBloquear(FormHandle, Data1)
                            Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlativo"))
                        End If
                    End If
                End If
            Else
                If Data1.Recordset("tm_venta") = "P" Then
                    Data1.Recordset.Edit
                    Data1.Recordset("tm_venta") = "V"
                    If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
                        Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
                    Else
                        Data1.Recordset("tm_clave_dcv") = ""
                    End If
             
                
                        Data1.Recordset.Update
                        
                ElseIf Data1.Recordset("tm_venta") = " " Then
                        If VENTA_Bloquear(FormHandle, Data1) Then
                            Data1.Recordset.Edit
                            Data1.Recordset("tm_venta") = "V"
                            If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
                               Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
                            Else
                               Data1.Recordset("tm_clave_dcv") = ""
                            End If
                            Data1.Recordset.Update
                        Else
                            Data1.Recordset.Edit
                            Data1.Recordset("tm_venta") = "*"
                            Data1.Recordset.Update
                        End If
                End If
            End If
        End If
                
        If CDbl(Table1.TextMatrix(Table1.Row, Ven_TIR)) <> 0 Then
            Call VENTA_Valorizar(2, Data1, FechaPago.text)
            Call VENTA_Valorizar(2, Data1, FechaPago.text, "TRAN")
        ElseIf CDbl(Table1.TextMatrix(Table1.Row, Ven_TIR)) <> 0 Then
                Call VENTA_Valorizar(1, Data1, FechaPago.text)
                Call VENTA_Valorizar(1, Data1, FechaPago.text, "TRAN")
        ElseIf CDbl(Table1.TextMatrix(Table1.Row, Ven_VPAR)) <> 0 Then
                Call VENTA_Valorizar(3, Data1, FechaPago.text)
                Call VENTA_Valorizar(3, Data1, FechaPago.text, "TRAN")
        End If
        
    ElseIf Columna = nColTir Then
        Data1.Recordset!TM_TIR = Text1.text
        Data1.Recordset.Update
        


''''MEJORA PRD-3860  -  Control de Precios
        
        'Variables para control de Tasas y Precios
        Dim ptPlazo As Integer
        Dim ptTasa As Double
        Dim ptInstr As String
 
  
        ptPlazo = DateDiff("D", gsBac_Fecp, Data1.Recordset("tm_fecsal"))
        ptInstr = Data1.Recordset("tm_codigo")
        ptTasa = Data1.Recordset("tm_tir")
        
        
               If ControlPreciosTasas("VP", ptInstr, ptPlazo, ptTasa) = "S" Then
                If Ctrlpt_ModoOperacion <> "S" Then 'PRD-3860, modo silencioso
                    MsgBox Ctrlpt_Mensaje, vbExclamation, TITSISTEMA
                    Table1.SetFocus
                End If
               End If
        
''''MEJORA PRD-3860  -  Control de Precios

        
        Call VENTA_Valorizar(2, Data1, FechaPago.text)
            
        Data1.Recordset.Edit
        Data1.Recordset!TM_TIR_TRAN = Data1.Recordset("tm_tir")
        Data1.Recordset!TM_Pvp_TRAN = Data1.Recordset("tm_pvp")
        Data1.Recordset!tm_vp_TRAN = Data1.Recordset("tm_vp")
        Data1.Recordset!tm_VP_TRAN_MO = Data1.Recordset("tm_VpMo")
        Data1.Recordset.Update


    ElseIf Columna = nColVPar Then
            Data1.Recordset!TM_Pvp = Text1.text
            Data1.Recordset.Update
            
            Call VENTA_Valorizar(1, Data1, FechaPago.text)
            
            If Not Antes_Flag Then
                Table1.TextMatrix(Table1.Row, Table1.Col) = Anterior
                Data1.Recordset.Edit
                Data1.Recordset!TM_Pvp_TRAN = Anterior
                Data1.Recordset.Update
            Else
                Data1.Recordset.Edit
                Data1.Recordset!TM_TIR_TRAN = Data1.Recordset("tm_tir")
                Data1.Recordset!TM_Pvp_TRAN = Data1.Recordset("tm_pvp")
                Data1.Recordset!tm_vp_TRAN = Data1.Recordset("tm_vp")
                Data1.Recordset!tm_VP_TRAN_MO = Data1.Recordset("tm_VpMo")
                Data1.Recordset.Update

            End If
          
    ElseIf Columna = nColValorPresente Then
            Data1.Recordset!TM_VP = Text1.text
            Data1.Recordset.Update
            
            Call VENTA_Valorizar(3, Data1, FechaPago.text)
            
            If Not Antes_Flag Then
                Table1.TextMatrix(Table1.Row, Table1.Col) = Anterior
                Data1.Recordset.Edit
                Data1.Recordset!TM_VP = Anterior
                Data1.Recordset.Update
            Else
                Data1.Recordset.Edit
                Data1.Recordset!TM_TIR_TRAN = Data1.Recordset("tm_tir")
                Data1.Recordset!TM_Pvp_TRAN = Data1.Recordset("tm_pvp")
                Data1.Recordset!tm_vp_TRAN = Data1.Recordset("tm_vp")
                Data1.Recordset!tm_VP_TRAN_MO = Data1.Recordset("tm_VpMo")
                Data1.Recordset.Update
            End If
            
    ElseIf Columna = nColTTran Then
        If Text1.text = 0# Then
           Text1.text = Table1.TextMatrix(Table1.RowSel, nColTir)
        End If
        
        Data1.Recordset!TM_TIR_TRAN = Text1.text
        Data1.Recordset.Update
        
        Call VENTA_Valorizar(2, Data1, FechaPago.text, "TRAN")
    
    ElseIf Columna = nColVTran Then
        If Text1.text = 0# Then
           Text1.text = Table1.TextMatrix(Table1.RowSel, nColVPar)
        End If
    
        Data1.Recordset!TM_Pvp_TRAN = Text1.text
        Data1.Recordset.Update
        
        Call VENTA_Valorizar(1, Data1, FechaPago.text, "TRAN")
            
    ElseIf Columna = nColVPTran Then
        If Text1.text = 0# Then
           Text1.text = Table1.TextMatrix(Table1.RowSel, nColValorPresente)
        End If

        
        Data1.Recordset!tm_vp_TRAN = Text1.text
        Data1.Recordset.Update
        
        Call VENTA_Valorizar(3, Data1, FechaPago.text, "TRAN")
    End If
    
    BacControlWindows 12

   'Sumar el total y desplegar.-
    If Columna > nColMoneda Then
        TxtTotal.text = VENTA_SumarTotal(FormHandle)
        Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")
        
        If CDbl(Flt_Result.Caption) < 0 Then
            Flt_Result.ForeColor = &HFF&
            Flt_Result.Caption = Format(Abs(CDbl(Flt_Result.Caption)), "###,###,###,##0.00")
        Else
            Flt_Result.ForeColor = &H0&
        End If
    End If
    
    If Columna = nColNominal Then
       SendKeys "{TAB 1}"
    ElseIf Columna = nColTir Then
       SendKeys "{TAB 2}"
    ElseIf Columna = nColVPar Then
       SendKeys "{TAB 1}"
    End If
    
    MousePointer = vbDefault
    iFlagKeyDown = True
    
    Call Llenar_Grilla
    
    If Columna = nColTTran Or Columna = nColVTran Or Columna = nColVPTran Then
       If Not Proc_Valida_Tasa_Transferencia(Table1.TextMatrix(Fila, nColTir), Table1.TextMatrix(Fila, nColTTran)) Then
           Text1.text = ""
           Text1.Visible = False
           Table1.Col = nColTTran
           Table1.Row = Fila
           Table1.SetFocus
           Exit Sub
       End If
    End If

    Text1.text = ""
    Text1.Visible = False
    Table1.Col = Colum
    Table1.Row = Fila
    Table1.TopRow = nTopRow

End If

    Exit Sub
    
ExitEditError:

    MousePointer = vbDefault
    iFlagKeyDown = True
    Table1.Row = Table1.Rows - 1
    Table1.TextMatrix(Table1.Row, nColNominal) = Format(Monto, "###,###,###,##0.0000")
    Text1.Visible = False
    Exit Sub

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)

    If Mid(Table1.TextMatrix(Table1.Row, nColSerie), 1, 6) = "FMUTUO" And (Table1.Col = nColTir Or Table1.Col = nColTTran) Then
        Text1.Enabled = False
    End If

End Sub

Private Sub Text1_LostFocus()
    
    On Error Resume Next

    Text1.Visible = False
    BacControlWindows 100
    Table1.SetFocus

End Sub

Private Sub Text2_GotFocus()
Call PROC_POSI_TEXTO(Table1, Text2)
Text2.SelLength = Len(Text2)
Text2.SelStart = Len(Text2)
End Sub

Private Sub Text2_KeyDown(KeyCode As Integer, Shift As Integer)
    
    Dim nFilaValida As Integer
    Dim cClaveAnterior  As String
    
    If KeyCode = 27 Then
        Text2_LostFocus
    End If

    If KeyCode = 13 Then
        
        If Not Table1.Rows = 1 Then
            Call Colocardata1
        Else
            Data1.Recordset.MoveFirst
        End If
        
        If Table1.Col = nColClaveDCV Then
            
            nFilaValida = Table1.Row
            cClaveAnterior = Trim(Table1.TextMatrix(Table1.Row, nColClaveDCV))
            
            If FUNC_VALIDA_CLAVE_DCV_DIARIA(Table1, nFilaValida, nColClaveDCV, Trim(Text2.text)) Then
                Table1.Row = nFilaValida
                Table1.Col = nColClaveDCV
            Else
                Text2.text = cClaveAnterior
            End If
        End If
        
        Data1.Recordset.Edit
        Data1.Recordset!tm_clave_dcv = Text2.text
        Data1.Recordset.Update
        Table1.TextMatrix(Table1.Row, nColClaveDCV) = Trim(Text2.text)
        Table1.SetFocus
    End If
    
End Sub

Private Sub Text2_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Text2_LostFocus()
Text2.text = ""
Text2.Visible = False
Table1.SetFocus
End Sub

Private Sub TipoPago_Click()
   Dim nCont   As Integer
   Dim nSw     As Integer

   Select Case TipoPago.ListIndex
      Case Is = 0
         FechaPago.text = Format(gsBac_Fecp, "dd/mm/yyyy")
      Case Is = 1
         FechaPago.text = Format(gsBac_Fecx, "dd/mm/yyyy")
      Case Is = 2
         nSw = 0
         nCont = 1
         Do While nSw = 0
            FechaPago.text = Format$(DateAdd("d", nCont, gsBac_Fecx), "dd/mm/yyyy")
            If EsFeriado(CDate(FechaPago.text), "00001") Then
               nCont = nCont + 1
            Else
               nSw = 1
            End If
         Loop
      Case Else
         MsgBox "Problemas con el tipo de pago"
   End Select
   Let oTipoPago = TipoPago.ListIndex
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
 'Table1.Redraw = False
Select Case Button.Key
    
    Case Is = "cmbgrabar"
        Call TOOLGRABAR
    
    Case Is = "cmbvende"
        'Call TOOLVENDE
         Screen.MousePointer = vbHourglass
         Table1_KeyPress (118)
         Screen.MousePointer = vbDefault
    
    Case Is = "cmbrestaura"
         Screen.MousePointer = vbHourglass
         Table1_KeyPress (114)
         Screen.MousePointer = vbDefault
        'Call TOOLRESTAURAR
    
    Case Is = "cmbfiltrar"
        Call TOOLFILTRAR
        
    Case Is = "cmbversel"
        Call TOOLVER_SELEC
    
    Case Is = "cmbemision"
        Call TOOLEMISION
    
    Case Is = "cmbcortes"
        Call TOOLCORTES
        
    Case Is = "valorizaciones"
     If Table1.TextMatrix(1, 1) <> "" Then
       tir = CDbl(Table1.TextMatrix(Table1.Row, nColTir))
       ValorTir = Table1.TextMatrix(Table1.Row, nColValorPresente)
       Durmacori = Table1.TextMatrix(Table1.Row, nColDurationMac)
       Durmodori = Table1.TextMatrix(Table1.Row, nColDurationMod)
       Convex = Table1.TextMatrix(Table1.Row, nColConvex)
       BacVaTasasVp.Show 1
     End If
End Select

'BacControlWindows 30

End Sub


Private Function fxTraspasoDatos(ByVal nIdCorrelativo As Long, ByVal Plazo_Minimo As Long, ByVal Días_Cartera As Long) As Long

    Debug.Print "Entro"

    Let oLimPermanencia_vp.Modulo = "BTR"
    Let oLimPermanencia_vp.Producto = "VP"
    Let oLimPermanencia_vp.NumeroOperacion = IIf((oLimPermanencia_vp.Id = -1 Or oLimPermanencia_vp.Id = 0), -1, oLimPermanencia_vp.Id)
    Let oLimPermanencia_vp.NumeroDocumento = CDbl(Data1.Recordset("tm_numdocu"))
    Let oLimPermanencia_vp.Correlativo = CDbl(Data1.Recordset("tm_correla"))
    Let oLimPermanencia_vp.Codigo = Data1.Recordset("tm_codigo")
    Let oLimPermanencia_vp.Familia = Trim(Data1.Recordset("tm_serie"))
    Let oLimPermanencia_vp.Instrumento = Trim(Data1.Recordset("tm_instser"))
    Let oLimPermanencia_vp.RutEmisor = Data1.Recordset("tm_rutemi")
    Let oLimPermanencia_vp.Trader = gsBac_User
    Let oLimPermanencia_vp.Nominal = CDbl(Data1.Recordset("tm_nominal"))
    Let oLimPermanencia_vp.Tasa = CDbl(Data1.Recordset("tm_tir"))
    Let oLimPermanencia_vp.Pvp = CDbl(Data1.Recordset("tm_pvp"))
    Let oLimPermanencia_vp.PlazoLimite = Plazo_Minimo
    Let oLimPermanencia_vp.PlazoActual = Días_Cartera
    Let oLimPermanencia_vp.Mensaje = "Los siguientes Instrumentos Anteceden Límite de Permanencia en cartera."
    Let oLimPermanencia_vp.Id = -1
    Let oLimPermanencia_vp.Estado = -1

    If oLimPermanencia_vp.Fx_Grabacion_Mensajes_LimitePermamencia = False Then
        Call MsgBox("Ha ocurrido un error al grabar los mensajes de Limites de Permanencia", vbExclamation, App.Title)
    End If

End Function


Sub TOOLGRABAR()
    Dim rRs As Recordset
    Dim nContador As Long
    
    
    '==========================================================================
    ' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Limites de Permanencia
    ' INICIO
    '==========================================================================
    
    Dim Días_Cartera As Integer
    Dim Plazo_Permanencia As Integer
    Dim vIns()
    Dim cMensaje As String
    Dim nContPm As Long
    Dim nContVendidos As Long
    Dim Plazo_Minimo As Integer
    Dim C As Integer
    Dim i As Integer
    
    Dim Datos_Error()
    Dim aTasasP()
    
    '==========================================================================
    ' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Limites de Permanencia
    ' FIN
    '==========================================================================
    
    
    'agrar for que recorra la grilla
    For nContador = 1 To Table1.Rows - 1
        If Trim(Table1.TextMatrix(nContador, nColEstado)) = "V" Then
            If Not Proc_Valida_Tasa_Transferencia(Table1.TextMatrix(nContador, nColTir), Table1.TextMatrix(nContador, nColTTran)) Then
               Table1.Col = nColTTran
               Table1.Row = nContador
               Table1.SetFocus
               Exit Sub
            End If
        End If
    Next nContador
    
    Data1.Refresh
    Set rRs = db.OpenRecordset("SELECT DISTINCT tm_monemi FROM MDVENTA WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )", dbOpenSnapshot)



    '==========================================================================
    ' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Limites de Permanencia
    ' INICIO
    '==========================================================================
    
    Call oLimPermanencia_vp.Fx_Clear                                                '-> LD1_035 (Limpia las variables de la Clase Inicializa )
    Call Data1.Recordset.MoveFirst                                                  '-> LD1_035 (Mueve el puntero de la MDB al primer registro.)

    gsCartera = CDbl(Data1.Recordset("tm_tipcart"))                                 '-> LD1_035 (Cartera Financiera)

    Let gsIndCartera = oLimPermanencia_vp.FX_CarteraNormativa(Data1.Recordset("tm_carterasuper"))
    
    If UCase(Trim(Me.Tag)) = "VP" Then
        If gsIndCartera = 2 Then       '-> If gsCartera = 2 Then                    '-> LD1_035 (Control por Cartera Normativa)
       Data1.Refresh
       'Datos_Error = Array()
       Días_Cartera = 0
       Plazo_Permanencia = 0
       vIns() = Array()
'       cMensaje = ""
'       cMensaje = "Los siguientes Instrumentos Anteceden Límite de Permanencia en cartera,¿ Desea que otro Usuario Autorice.? " + cSaltoLinea + cSaltoLinea
'       cMensaje = cMensaje + "Instrumento                Plazo Límite                Plazo Actual" + cSaltoLinea
'       cMensaje = cMensaje + "=====================================" + cSaltoLinea
       aTasasP = Array()
       Data1.Recordset.MoveFirst
       nContPm = 0
       nContVendidos = 0
           With Table1
           For i = 1 To .Rows - 1
                   If .TextMatrix(i, 0) = "V" Or .TextMatrix(i, 0) = "P" Or .TextMatrix(i, 0) = "VPM" Then
                     If CDbl(Data1.Recordset("tm_rutemi")) = 60805000 Or Data1.Recordset("tm_rutemi") = 97029000 Then
                              Días_Cartera = Valida_Limites_de_Permanencia(CDbl(Data1.Recordset("tm_numdocu")), CDbl(Data1.Recordset("tm_correla")))
                              Plazo_Minimo = Valida_Dias_de_Permanencia(CDbl(Data1.Recordset("tm_numdocu")), CDbl(Data1.Recordset("tm_correla")), gsCartera, 1, Data1.Recordset("tm_instser"))
                              If Días_Cartera < Plazo_Minimo Then
                               C = UBound(vIns) + 1
                     ReDim Preserve vIns(C)
                               vIns(C) = Array(.TextMatrix(i, 0))
'                               cMensaje = cMensaje + .TextMatrix(i, 1) & Space(25) & RELLENA_STRING(Str(Días_Cartera), 0, 5) & Space(25) & Str(Plazo_Minimo) + cSaltoLinea
                               C = UBound(aTasasP) + 1
                     ReDim Preserve aTasasP(C)
                     aTasasP(C) = Array(.TextMatrix(i, 1), Días_Cartera, Plazo_Minimo, .TextMatrix(i, 4), .TextMatrix(i, 5), DateDiff("d", gsBac_Fecp, CDate(Data1.Recordset("tm_fecven"))), .TextMatrix(i, 7), 1)
                                
                                '-> LD1_035
                                Call fxTraspasoDatos(i, Plazo_Minimo, Días_Cartera)
                                '-> LD1_035
                                
                  End If
                 End If
               End If
                 Data1.Recordset.MoveNext
           Next i
           End With
           
           ''''' Revisar funcionalidad
           
'''''         If UBound(vIns) > -1 Then
'''''           If MsgBox(cMensaje, vbYesNo + vbCritical) = vbYes Then
'''''               Autorizado_II = False
'''''               If Not Aprobacion_Pantalla(7, 1) Then
'''''                   Codigo_Limite = ""
'''''                   Usuario_Autorizador = ""
'''''                   TABLE1.SetFocus
'''''                   Exit Function
'''''               Else
'''''                   Autorizado_II = True
'''''               End If
'''''               If Not Autorizado_II Then Exit Function
'''''           Else
'''''               Exit Function
'''''           End If
'''''         End If
       End If
    End If
       
    '==========================================================================
    ' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Limites de Permanencia
    ' FIN
    '==========================================================================
    
    
    If rRs.RecordCount > 0 Then
       If Not IsNull(rRs.Fields("tm_monemi")) Then
          BacIrfGr.proMoneda = IIf(rRs.Fields("tm_monemi") = 13, gsBac_Dolar, "$$")
       End If
    End If

    If FUNC_Verifica_Papeles() Then
       MsgBox "No puede mesclar monedas MX/$ o MX/MX diferentes", vbExclamation, TITSISTEMA
       Table1.SetFocus
       Exit Sub
    End If
    
   'VB+- 21/06/2010 Se agrega validacion
    If Me.TipoPago <> "HOY" Then
        If FUNC_Valida_Papeles_PM_ICP Then
            MsgBox "No se puede realizar operacion PM con papeles en ICP", vbExclamation, TITSISTEMA
            Table1.SetFocus
            Exit Sub
        End If
    End If
    
 '' Error 6011 ''->
    BacIrfGrSinDVP.proMtoOper = TxtTotal.text
    BacIrfGrSinDVP.proHwnd = hWnd
    BacIrfGrSinDVP.oValorDVP = "glBacCpDvpVp"
    BacIrfGrSinDVP.oDVP = glBacCpDvpVp
    BacIrfGrSinDVP.cCodLibro = BacVP.cCodLibro
    BacIrfGrSinDVP.cCodCartFin = BacVP.cCodCartFin
    BacIrfGrSinDVP.MiTipoPago = oTipoPago
 '' Error 6011 ''->

   'BacIrfGr.proMtoOper = TxtTotal.Text
   'BacIrfGr.proHwnd = Hwnd
   'BacIrfGr.oValorDVP = "glBacCpDvpVp"
   'BacIrfGr.oDVP = glBacCpDvpVp
   'BacIrfGr.cCodLibro = BacVP.cCodLibro
   'BacIrfGr.cCodCartFin = BacVP.cCodCartFin
   'BacIrfGr.MiTipoPago = oTipoPago
    '' Error 6011 '->
       
    
    Call BacGrabarTX

    BacControlWindows 100

    If Not Grabacion_Operacion Then
       Data1.Refresh
      Else
        FiltraVentaAutomatico = True
        giAceptar = True
        Call Nombre_Grilla
        'Call TipoFiltro
        Me.Tag = "VP"
         Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_20200", "01", "", "", "", " ")
    End If

End Sub


'==========================================================================
' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Limites de Permanencia
' INICIO
'==========================================================================

Public Function Valida_Limites_de_Permanencia(NumDocu As Double, correla As Integer) As Integer
Dim SQL_TRADER As String
Dim DATOS_TRADER()
Dim C As Integer
Valida_Limites_de_Permanencia = 0
SQL_TRADER = "DBO.SP_TRAE_DIA_CARTERA " & _
             NumDocu & "," & _
             correla
If Not Bac_Sql_Execute(SQL_TRADER) Then
    MsgBox "Problemas al recuperar el Plazo de Permanencia" & vbCritical, TITSISTEMA
    Exit Function
Else
    If Bac_SQL_Fetch(DATOS_TRADER) Then
            Valida_Limites_de_Permanencia = DATOS_TRADER(1)
    End If
End If
End Function

Public Function Valida_Dias_de_Permanencia(NumDocu As Double, correla As Integer, Cartera As Integer, tipo As Integer, Glosa As String) As String
Dim SQL_TRADER As String
Dim DATOS_TRADER()
Dim C As Integer
Valida_Dias_de_Permanencia = 0

SQL_TRADER = "SP_TRAE_LIMITE_DE_PERMANECIA " & _
             NumDocu & "," & _
             correla & "," & _
             Cartera & "," & _
             tipo

    Envia = Array()
    AddParam Envia, NumDocu
    AddParam Envia, correla
    AddParam Envia, Cartera
    AddParam Envia, tipo
    If Not Bac_Sql_Execute("SP_TRAE_LIMITE_DE_PERMANECIA", Envia) Then
    MsgBox "Problemas al recuperar el Plazo de Permanencia", vbCritical, TITSISTEMA
    Exit Function
Else
        If Bac_SQL_Fetch(DATOS_TRADER()) Then
            Valida_Dias_de_Permanencia = DATOS_TRADER(1)
    End If
        If Valida_Dias_de_Permanencia = "NO" Then
            Valida_Dias_de_Permanencia = DATOS_TRADER(1)
            Exit Function
        End If
End If
End Function

'''''Function Aprobacion_Pantalla(Codigo_Grupo_Limite As Integer, Codigo_Limite As Integer) As Boolean
'''''
'''''    On Error GoTo ERROR_Aprobacion_Pantalla
'''''
'''''    gCodigo_Grupo_Limite = Codigo_Grupo_Limite
'''''    gCodigo_Limite = Codigo_Limite
'''''    If SW_TASA_TRAN <> 1 Then
'''''        If Codigo_Grupo_Limite <> 5 Then
'''''            BacLimiteALCO.Caption = TraeGlosaLimite(Codigo_Grupo_Limite, Codigo_Limite) + " ESTA EXCEDIDO"
'''''        Else
'''''            BacLimiteALCO.Caption = TraeGlosaLimite(Codigo_Grupo_Limite, Codigo_Limite)
'''''        End If
'''''    End If
'''''
'''''    BacLimiteALCO.Show 1
'''''
'''''
'''''
'''''
'''''    If BacLimiteALCO.Tag = "NO" Then
'''''        Aprobacion_Pantalla = False
'''''    Else
'''''        Aprobacion_Pantalla = True
'''''    End If
'''''
'''''Exit Function
'''''
'''''ERROR_Aprobacion_Pantalla:
'''''        MsgBox err.Description, vbCritical, "ERROR_Aprobacion_Pantalla"
'''''
'''''End Function

'=============================================================================
' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Limites de Permanencia
' FIN
'=============================================================================


Function FUNC_Verifica_Papeles() As Boolean
Dim nMoneda As Long

FUNC_Verifica_Papeles = False

With Data1.Recordset

    .MoveFirst
    
    Do While Not .EOF
        
        If .Fields("Tm_Venta") = "V" Or .Fields("Tm_Venta") = "P" Then
        
            If nMoneda = 0 Then
                nMoneda = .Fields("Tm_Monemi")
            End If
            
            If nMoneda <> .Fields("Tm_Monemi") Then
                Select Case nMoneda
                    Case 999, 998, 997, 995, 994, 800, 801 ' VB+- 21-06-2010 Se agregan codigos de monedas 800, 801 para depsoitos en ICP y ICPR
                        If .Fields("Tm_Monemi") = 999 Or _
                            .Fields("Tm_Monemi") = 998 Or _
                            .Fields("Tm_Monemi") = 997 Or _
                            .Fields("Tm_Monemi") = 995 Or _
                            .Fields("Tm_Monemi") = 994 Or _
                            .Fields("Tm_Monemi") = 800 Or _
                            .Fields("Tm_Monemi") = 801 Then
                            
                            FUNC_Verifica_Papeles = False
                            
                        Else
                            FUNC_Verifica_Papeles = True
                            Exit Do
                        End If
                    Case Else
                        FUNC_Verifica_Papeles = True
                        Exit Do
                End Select
            End If
            
        End If
        
        .MoveNext
        
    Loop
    .MoveFirst
    
End With

End Function


Function FUNC_Valida_Papeles_PM_ICP() As Boolean
Dim nMoneda As Integer

    Let FUNC_Valida_Papeles_PM_ICP = False
    
    
    With Data1.Recordset
    
        .MoveFirst
    
        Do While Not .EOF
            If .Fields("tm_venta") = "V" Or .Fields("tm_venta") = "P" Then
                nMoneda = .Fields("Tm_Monemi")
        
                If nMoneda = 800 Or nMoneda = 801 Then
                    FUNC_Valida_Papeles_PM_ICP = True
                    Exit Do
                End If
            End If
            .MoveNext
        Loop
        .MoveFirst
    End With
    
    
    
    
End Function


Sub TipoFiltro()

 If Toolbar1.Buttons(6).Tag = "Ver Todos" Then
        Toolbar1.Buttons(6).Tag = "Ver Sel."
        Toolbar1.Buttons(6).ToolTipText = "Ver Selección"
            'CmdTipoFiltro.Caption = "Ver Sel."
       ' Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= " & "0" ' txtplazo.Text
       ' Data1.Refresh
    Else
        filita = Table1.Row
        If TxtTotal.text > 0 Then
         Toolbar1.Buttons(6).Tag = "Ver Todos"
         Toolbar1.Buttons(6).ToolTipText = "Ver Todos"
            'CmdTipoFiltro.Caption = "Ver Todos"
        '    Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= " & "0" ' txtplazo.Text & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
        '    Data1.Refresh
        End If
    End If
    
    'TxtCartera.Text = VENTA_SumarCartera(FormHandle, txtplazo.Text, Toolbar1)
    
    Table1.Rows = 2
    Table1.Row = 0
    'Do While Not Data1.Recordset.EOF
    '   TABLE1.Rows = TABLE1.Rows + 1
    '   TABLE1.Row = TABLE1.Rows - 1
       Call Llenar_Grilla
    '   If Not Data1.Recordset.EOF Then
    '        Data1.Recordset.MoveNext
    '   End If
    'Loop
    If filita <= Table1.Rows - 1 Then
    Table1.Row = filita
   End If
    'Table1.SetFocus
 
End Sub



Function TOOLVENDE()
   filita = Table1.Row
Dim fila_table As Integer
If Table1.Row = 0 Then Exit Function 'insertado05/02/2001
If Data1.Recordset.RecordCount = 0 Then Exit Function

fila_table = Table1.Row - 1

If VENTA_VerDispon(FormHandle, Data1) Then
    If Not Table1.Row = 1 Then
            Call Colocardata1
    Else
            Data1.Recordset.MoveFirst
    End If
   If Data1.Recordset("tm_venta") = " " Or Data1.Recordset("tm_venta") = "*" Then

      If VENTA_Bloquear(FormHandle, Data1) Then
         Data1.Recordset.Edit
         Data1.Recordset("tm_venta") = "V"

         If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
            Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
         Else
            Data1.Recordset("tm_clave_dcv") = ""
         End If

         Data1.Recordset.Update
         Table1.TextMatrix(Table1.Row, 8) = Data1.Recordset("tm_clave_dcv")
      Else
         Data1.Recordset.Edit
         Data1.Recordset("tm_venta") = "*"
         Data1.Recordset.Update
      End If
       Table1.TextMatrix(Table1.Row, 0) = Data1.Recordset("tm_venta")
   End If

End If

TxtTotal.text = VENTA_SumarTotal(FormHandle)
Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")

Data1.Refresh
Data1.Recordset.Move fila_table
Call colores
Table1.SetFocus
Table1.Refresh
If filita <= Table1.Rows - 1 Then
    Table1.Row = filita
Else
    Table1.Row = Table1.Rows - 1
End If

''''Table1.Col = 2
Table1.Col = nColMoneda
Table1.SetFocus
End Function
Function TOOLRESTAURAR()
  filita = Table1.Row

valor = True

If Table1.Row = 0 Then
   Exit Function 'insertado05/02/2001
End If

If Data1.Recordset.RecordCount = 0 Then
   Exit Function
End If

If Not Table1.Row = 1 Then
    Call Colocardata1
Else
    Data1.Recordset.MoveFirst
End If

Call VENTA_VerDispon(FormHandle, Data1)

If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then

       If VENTA_DesBloquear(FormHandle, Data1) Then

            Data1.Recordset.Edit
            Data1.Recordset("tm_venta") = " "
            Data1.Recordset("tm_clave_dcv") = ""
            Data1.Recordset.Update
            Table1.TextMatrix(Table1.Row, 0) = Data1.Recordset("tm_venta")
            Table1.TextMatrix(Table1.Row, 7) = Data1.Recordset("tm_clave_dcv")

            If Toolbar1.Buttons(6).Tag = "Ver Todos" And Table1.Rows - 1 = 1 Then
               Toolbar1.Buttons(6).Tag = "Ver Sel."
               Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1"
               Data1.Refresh
            ElseIf Toolbar1.Buttons(6).Tag = "Ver Todos" And Data1.Recordset.RecordCount > 1 Then
               Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
               Data1.Refresh
            End If

       End If

    If Data1.Recordset("tm_venta") = "*" Then

       If VENTA_VerBloqueo(FormHandle, Data1) Then
          Data1.Recordset.Edit
          Data1.Recordset("tm_venta") = " "
          Data1.Recordset.Update
       End If

    End If

    If Data1.Recordset.RecordCount > 0 Then
       Call VENTA_Restaurar(Data1)
    End If
      
    Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))

      TxtTotal.text = VENTA_SumarTotal(FormHandle)
      Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")
      Data1.Recordset.MoveLast
      Table1.Rows = Data1.Recordset.RecordCount + 1
      Data1.Refresh
      Call refresca

   If filita <= Table1.Rows - 1 Then
      Table1.Row = filita
   Else
      Table1.Row = Table1.Rows - 1
   End If

    Table1.Refresh
    ''''Table1.Col = 2
    Table1.Col = nColMoneda
    Table1.SetFocus
    
End If

End Function


Function TOOLFILTRAR()
   
   Dim Envia1     As Variant
   Dim SQL        As String
   Dim Datos()
   Dim nSw%
   Dim X          As Integer
   Dim oContador  As Long
   oContador = 1

'   On Error GoTo ErrFiltro
'   Call desbloquear
   nSw = 0

   BacIrfSl.oFiltroDVP = glBacCpDvpVp
   BacIrfSl.ProTipOper = "VP"
   BacIrfSl.bFlagDpx = bFlagDpx
   BacIrfSl.MiTipoPago = oTipoPago
 ' ------------------------------------------------------------------------------------
 ' +++ VB 05/07/2018 desarrollo t+2 se envia fecha de pago para carga de papelees
 ' ------------------------------------------------------------------------------------
   BacIrfSl.fecModPago = Me.FechaPago.text
 ' ------------------------------------------------------------------------------------
 ' +++ VB 05/07/2018 desarrollo t+2 se envia fecha de pago para carga de papelees
 ' ------------------------------------------------------------------------------------
    
   
   BacIrfSl.Show vbModal
   Envia1 = Envia
   valor = True

   If giAceptar% = True Then
        Call VENTA_EliminarBloqueados(Data1, FormHandle)
        Call VENTA_BorrarTx(FormHandle)
        Envia = Envia1
        
        PnlLibro.Caption = Envia(Pos_Libro)
        Envia(Pos_Libro) = Trim(Right(Envia(Pos_Libro), 10))
        
        BacVP.cCodCartFin = Trim(Right(Envia(Pos_CartFin), 10))
        BacVP.cCodLibro = Trim(Right(Envia(Pos_Libro), 10))
    
        gsBac_CartRUT = RutCartV
        gsBac_CartDV = DvCartV
        gsBac_CartNOM = NomCartV

        nRutCartV = RutCartV
        cDvCartV = DvCartV
        cNomCartV = NomCartV

        Screen.MousePointer = vbKeyReturn
        
        AddParam Envia, CDbl(glBacCpDvpVp)
        
        If bFlagDpx Then
            SQL = "SP_FILTRARCART_VU"
        Else
            If Envia(2) = "-FMUTUO" Then
                SQL = "SP_FILTRARCART_VPFM"
            Else
                SQL = "SP_FILTRARCART_VP"
            End If
        End If
        
        
       ' ------------------------------------------------------------------------------------
       '  +++ VB 05/07/2018 desarrollo t+2 se envia fecha de pago para carga de papelees
       '  ------------------------------------------------------------------------------------
        AddParam Envia, Me.FechaPago.text
       ' ------------------------------------------------------------------------------------
       '  ---   VB 05/07/2018 desarrollo t+2 se envia fecha de pago para carga de papelees
       '  ------------------------------------------------------------------------------------
        
        
        If Bac_Sql_Execute(SQL, Envia) Then
            sFiltro = gSQL
             bSelPagoMañana = False
            
            If Data1.Recordset.RecordCount > 0 Then
               db.Execute "DELETE * FROM mdventa"
               Data1.Refresh
            End If
            
            Do While Bac_SQL_Fetch(Datos())
                If Datos(12) <> "" Then
                  Call VENTA_Agregar(Data1, Datos(), hWnd, "VP")
                  Data1.Recordset.MoveLast
                  nSw = 1
                End If
                If glBacCpDvpVp = Si Then
                  If oContador = 10 Then
                    'Exit Do
                  Else
                     oContador = oContador + 1
                  End If
               End If

            Loop
                     
            Table1.Clear
            Table1.Rows = 2
            
            Call Nombre_Grilla
            Call Llenar_Grilla
            
            If nSw > 0 Then
                Toolbar1.Buttons(6).Tag = "Ver Sel."
                Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1"
                Data1.Refresh

                TxtTotal.text = VENTA_SumarTotal(FormHandle)
                Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")
                TxtCartera.text = VENTA_SumarCartera(FormHandle, "1", Toolbar1)
                Table1.Enabled = True
            Else
                Toolbar1.Buttons(6).Tag = "Ver Sel."
                Table1.Col = nColSerie ''''1
                Toolbar1.Buttons(6).Enabled = False
                Table1.Enabled = False
                TxtInv.Enabled = True
            End If

If Table1.Row = 0 Then
   Toolbar1.Buttons(7).Enabled = False
   Toolbar1.Buttons(6).Enabled = False
   Toolbar1.Buttons(8).Enabled = False
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False
   TxtTotal.Enabled = False
End If


            If Data1.Recordset.RecordCount > 0 Then
                Toolbar1.Buttons(7).Enabled = True
                Toolbar1.Buttons(6).Enabled = True
                Toolbar1.Buttons(8).Enabled = True
                Toolbar1.Buttons(2).Enabled = True
                Toolbar1.Buttons(3).Enabled = True
                Toolbar1.Buttons(4).Enabled = True
                TxtTotal.Enabled = True
            End If


        Else
            Table1.Rows = 1

        End If

        Screen.MousePointer = vbDefault

    End If
    
    Exit Function
ErrFiltro:
    Table1.Redraw = True
    MsgBox "Problemas en filtro de cartera para ventas definitivas: " & err.Description
    Screen.MousePointer = vbDefault
    Exit Function
End Function


Function TOOLVER_SELEC()
   
   If Toolbar1.Buttons(6).ToolTipText = "Ver Todos" Then

      Toolbar1.Buttons(6).ToolTipText = "Ver Seleccion"
      Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1"
      Data1.Refresh
    
   Else
      filita = Table1.Row
      If CDbl(TxtTotal.text) > 0 Then
          'CmdTipoFiltro.Caption = "Ver Todos"
          Toolbar1.Buttons(6).Tag = "Ver Todos"
          Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
          Data1.Refresh
      End If
   End If
   
   Do While Not Data1.Recordset.EOF
      Call Llenar_Grilla
   Loop

   TxtCartera.text = VENTA_SumarCartera(FormHandle, "1", Toolbar1)
   valor = True
   If filita <= Table1.Rows - 1 Then
    Table1.Row = filita
   End If
   Table1.SetFocus

End Function
Function TOOLEMISION()
If Table1.Row = 0 Then Exit Function 'insertado05/02/2001
    BacControlWindows 100
    Data1.Refresh
    If Data1.Recordset.RecordCount = 0 Then
        Exit Function
    End If
    BacControlWindows 100
    If Not Table1.Row = 1 Then
            Call Colocardata1
    Else
            Data1.Recordset.MoveFirst
    End If
    BacControlWindows 100
    If Trim$(Data1.Recordset("tm_instser")) = "" Then
        Beep
        Exit Function
    End If

    'Guarda datos en variable global
    With BacDatEmi
        .sInstSer = Data1.Recordset("tm_instser")
        .lRutemi = Data1.Recordset("tm_rutemi")
        .iMonemi = Data1.Recordset("tm_monemi")
        .sFecEmi = Data1.Recordset("tm_fecemi")
        .sFecvct = Data1.Recordset("tm_fecven")
        .dTasEmi = Data1.Recordset("tm_tasemi")
        .iBasemi = Data1.Recordset("tm_basemi")
        
        .sFecpcup = Data1.Recordset("tm_fecpcup")
        .dNumoper = Data1.Recordset("tm_numdocu")
        .sTipOper = Data1.Recordset("tm_tipoper")
        .sFecvtop = Data1.Recordset("tm_fecsal")
        .iDiasdis = DateDiff("d", gsBac_Fecp, CDate(Data1.Recordset("tm_fecsal")))
        
    End With
       
    BacIrfDg.Tag = "VP"
    BacIrfDg.Show 1
    
    BacControlWindows 12
    Table1.SetFocus

End Function

Function TOOLCORTES()

Dim Nominal#
If Table1.Row = 0 Then Exit Function 'insertado05/02/2001
   Fila = Table1.RowSel
   If Data1.Recordset.RecordCount = 0 Then
      Exit Function
   End If

   Table1.Row = Fila

   If Not Table1.Row = 1 Then
      Call Colocardata1

   Else
      Data1.Recordset.MoveFirst

   End If

   Nominal# = CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL))
   bufNominal = Val(Data1.Recordset("tm_nominalo"))

   If Nominal = 0 Then
      Exit Function
   End If
    
   If VENTA_VerDispon(FormHandle, Data1) = False Then
      Exit Function

   End If

   Set BacFrmIRF = Me
   'Fila = Table1.Row
   BacControlWindows 30
   BacIrfCo.Show 1
   BacControlWindows 30

   
    
   If Not Table1.Row = 1 Then
      Call Colocardata1

   Else
      Data1.Recordset.MoveFirst

   End If
    
   If Table1.TextMatrix(Table1.Row, 0) <> "N" Then
      Data1.Recordset.Edit
      Data1.Recordset!tm_nominal = Table1.TextMatrix(Table1.Row, Ven_NOMINAL)
      Text1.text = Table1.TextMatrix(Table1.Row, Ven_NOMINAL)
      Data1.Recordset.Update

      If Nominal# <> CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL)) Or (Table1.TextMatrix(Table1.Row, 0) = "V") Then
         If Data1.Recordset!tm_venta <> "*" And Data1.Recordset!tm_venta <> " " Then Call VENTA_DesBloquear(FormHandle, Data1)
            If VENTA_Bloquear(FormHandle, Data1) Then
               Data1.Recordset.Edit
               If CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL)) < Nominal# Then
                  Data1.Recordset!tm_venta = "P"
               Else
                  Data1.Recordset!tm_venta = "V"
               End If
               Data1.Recordset.Update
            End If
         Else
         Data1.Recordset.Edit
         Data1.Recordset.Update
      End If

      Call Llenar_Grilla
      Table1.Row = Fila
      Table1.Col = nColNominal ''''3
      Call Text1_KeyDown(13, 0)
   Else
      Table1.TextMatrix(Table1.Row, 0) = " "

  End If
   Table1.Col = nColNominal ''''3
   Table1.SetFocus


End Function



Private Sub TxtInv_Change()
    If TxtInv.text > 0 Then
       TxtSaldo.text = TxtSel.text - TxtInv.text
    Else
       TxtSaldo.text = 0
    End If
End Sub

Private Sub TxtInv_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      KeyAscii = 0
   End If

End Sub

Private Sub TxtSel_Change()
    If TxtInv.text > 0 Then
       TxtSaldo.text = TxtSel.text - TxtInv.text
    Else
       TxtSaldo.text = 0
    End If
End Sub

Private Sub TxtTotal_Change()
     
    TxtSel.text = TxtTotal.text
    TxtTotal.text = IIf(TxtTotal.text = "", "0", TxtTotal.text)
    If Toolbar1.Buttons(6).Tag = "Ver Sel." And CDbl(TxtTotal.text) = 0 Then
        Toolbar1.Buttons(6).Enabled = False
    Else
        Toolbar1.Buttons(6).Enabled = True
    End If
    
End Sub

Private Sub TxtTotal_GotFocus()
    TxtTotal.Tag = TxtTotal.text
End Sub

Private Sub TxtTotal_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
     Tecla = "13"
Else
    Tecla = ""
End If
End Sub

Private Sub TxtTotal_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        SendKeys$ "{TAB}"
    End If
End Sub


Private Sub TxtTotal_LostFocus()
Dim dTotalNuevo#, dTotalActual#
Dim i As Integer
If Not Data1.Recordset.RecordCount = 1 Then
            Call Colocardata1
    Else
            Data1.Recordset.MoveFirst
End If
    If TxtTotal.Tag <> TxtTotal.text Then
        dTotalActual# = CDbl(TxtTotal.Tag)
        dTotalNuevo# = CDbl(TxtTotal.text)
        If VPVI_ChkTipoCambio(FormHandle&) = False Then
            MsgBox "DEBE INGRESAR EL TIPO DE CAMBIO PARA TODOS LOS INSTRUMENTOS", vbExclamation, "Mensaje"
        Else
            Call VENTA_ValorizarTotal(Data1, dTotalNuevo#, dTotalActual#)
             Data1.Refresh
'             For I = 1 To TABLE1.Rows - 1
              Table1.Row = i
              Call Llenar_Grilla
'              If Not Data1.Recordset.EOF Then
'                Data1.Recordset.MoveNext
'              End If
'            Next I
            Table1.Refresh
        End If
    End If
    
    Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")
        
    If CDbl(Flt_Result.Caption) < 0 Then
        Flt_Result.ForeColor = &HFF&
        Flt_Result.Caption = Format(Abs(CDbl(Flt_Result.Caption)), "###,###,###,##0.00")
    Else
        Flt_Result.ForeColor = &H0&
    End If
    
    Screen.MousePointer = vbDefault
'  If Tecla = "13" Then
'      TxtTotal.SetFocus
'  Else
'      Table1.SetFocus
'  End If
    
    
  
End Sub





Private Sub CmdCortes_Click()
'
'   Dim Nominal#
'
'   Fila = TABLE1.RowSel
'   If Data1.Recordset.RecordCount = 0 Then
'      Exit Sub
'   End If
'
'   TABLE1.Row = Fila
'
'   If Not TABLE1.Row = 1 Then
'      Call Colocardata1
'
'   Else
'      Data1.Recordset.MoveFirst
'
'   End If
'
'   Nominal# = CDbl(TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL))
'   bufNominal = Val(Data1.Recordset("tm_nominalo"))
'
'   If Nominal = 0 Then
'      Exit Sub
'   End If
'
'   If VENTA_VerDispon(FormHandle, Data1) = False Then
'      Exit Sub
'
'   End If
'
'   Set BacFrmIRF = Me
'
'   BacControlWindows 30
'   BacIrfCo.Show 1
'   BacControlWindows 30
'
'   TABLE1.Row = Fila
'
'   If Not TABLE1.Row = 1 Then
'      Call Colocardata1
'
'   Else
'      Data1.Recordset.MoveFirst
'
'   End If
'
'   Data1.Recordset.Edit
'   Data1.Recordset!tm_nominal = TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL)
'   Data1.Recordset.Update
'
'   If Nominal# <> CDbl(TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL)) Then
'      If VENTA_Bloquear(FormHandle, Data1) Then
'         Data1.Recordset.Edit
'         If CDbl(TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL)) < Nominal# Then
'            Data1.Recordset!tm_venta = "P"
'
'         Else
'            Data1.Recordset!tm_venta = "V"
'
'         End If
'
'         Data1.Recordset.Update
'
'      End If
'
'   Else
'      Data1.Recordset.Edit
'      Data1.Recordset.Update
'
'   End If
'
'   Call Llenar_Grilla
'
'   TABLE1.SetFocus
'
End Sub


Private Sub CmdEmision_Click()
'    BacControlWindows 100
'    Data1.Refresh
'    If Data1.Recordset.RecordCount = 0 Then
'        Exit Sub
'    End If
'    BacControlWindows 100
'    If Not TABLE1.Row = 1 Then
'            Call Colocardata1
'    Else
'            Data1.Recordset.MoveFirst
'    End If
'    BacControlWindows 100
'    If Trim$(Data1.Recordset("tm_instser")) = "" Then
'        Beep
'        Exit Sub
'    End If
'
'    'Guarda datos en variable global
'    With BacDatEmi
'        .sInstSer = Data1.Recordset("tm_instser")
'        .lRutemi = Data1.Recordset("tm_rutemi")
'        .iMonemi = Data1.Recordset("tm_monemi")
'        .sFecEmi = Data1.Recordset("tm_fecemi")
'        .sFecvct = Data1.Recordset("tm_fecven")
'        .dTasEmi = Data1.Recordset("tm_tasemi")
'        .iBasemi = Data1.Recordset("tm_basemi")
'
'        .sFecpcup = Data1.Recordset("tm_fecpcup")
'        .dNumoper = Data1.Recordset("tm_numdocu")
'        .sTipoper = Data1.Recordset("tm_tipoper")
'        .sFecvtop = Data1.Recordset("tm_fecsal")
'        .iDiasdis = DateDiff("d", gsBac_Fecp, CDate(Data1.Recordset("tm_fecsal")))
'
'    End With
'
'    BacIrfDg.Tag = "VP"
'    BacIrfDg.Show 1
'
'    BacControlWindows 12
'    TABLE1.SetFocus

End Sub

Private Sub CmdFiltro_Click()
'Dim datos()
'Dim nSw%
'Dim X As Integer
'On Error GoTo ErrFiltro
'
'        nSw = 0
'        BacIrfSl.proTipOper = "VP"
'        BacIrfSl.Show vbModal
'        Valor = True
'
'    If giAceptar% = True Then
'
'        gsBac_CartRUT = RutCartV
'        gsBac_CartDV = DvCartV
'        gsBac_CartNOM = NomCartV
'
'        nRutCartV = RutCartV
'        cDvCartV = DvCartV
'        cNomCartV = NomCartV
'
'        gSQL = "SP_FILTRARCART_VP " & gSQL
'
'        Screen.mousepointer = vbkeyreturn
'
'        Call VENTA_EliminarBloqueados(Data1, FormHandle)
'        Call VENTA_BorrarTx(FormHandle)
'
'        Data1.Refresh
'
'        If miSQL.SQL_Execute(gSQL) = 0 Then
'
'            sFiltro = gSQL
'             TABLE1.Rows = 2
'            Do While Bac_SQL_Fetch(Datos())
'
'                If datos(12) > "" Then
'                    Call VENTA_Agregar(Data1, datos(), hWnd, "VP")
'                    'Data1.Refresh
'                    Data1.Recordset.MoveLast
'                    Call Llenar_Grilla
'                    TABLE1.Rows = TABLE1.Rows + 1
'                    TABLE1.Row = TABLE1.Rows - 1
'                    nSw = 1
'                End If
'            Loop
'
'             TABLE1.Rows = TABLE1.Rows - 1
'            If nSw > 0 Then
'                CmdTipoFiltro.Caption = "Ver Sel."
'
'                Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1"
'                Data1.Refresh
'
'                TxtTotal.Text = VENTA_SumarTotal(FormHandle)
'                Flt_Result.caption = VENTA_SumarDif(FormHandle)
'                TxtCartera.Text = VENTA_SumarCartera(FormHandle, "1", CmdTipoFiltro)
'                TABLE1.Enabled = True
'            Else
'                CmdTipoFiltro.Caption = "Ver Sel."
'                TABLE1.Col = 1
'                CmdTipoFiltro.Enabled = False
'                TABLE1.Enabled = False
'                TxtInv.Enabled = True
'            End If
'
'            If Data1.Recordset.RecordCount > 0 Then
'                CmdEmision.Enabled = True
'                CmdTipoFiltro.Enabled = True
'                CmdCortes.Enabled = True
'                SSC_Grabar.Enabled = True
'                CmdVenta.Enabled = True
'                CmdRestaura.Enabled = True
'                TxtTotal.Enabled = True
'            End If
'
'
'        Else
'            TABLE1.Rows = 1
'            MsgBox "Servidor SQL no Responde", vbExclamation, gsBac_Version
'        End If
'
'        Screen.MousePointer = 0
'
'    End If
'    If TABLE1.Rows <> 1 Then TABLE1.Row = 1: TABLE1.SetFocus
'    Exit Sub
'ErrFiltro:
'    MsgBox "Problemas en filtro de cartera para ventas definitivas: " & Err.Description
'    Exit Sub
End Sub

Private Sub CmdRestaura_Click()
' filita = TABLE1.Row
'Valor = True
'
'If Data1.Recordset.RecordCount = 0 Then Exit Sub
'If Not TABLE1.Row = 1 Then
'            Call Colocardata1
'    Else
'            Data1.Recordset.MoveFirst
'End If
'
'Call VENTA_VerDispon(FormHandle, Data1)
'
'If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
'
'       If VENTA_DesBloquear(FormHandle, Data1) Then
'
'          Data1.Recordset.Edit
'          Data1.Recordset("tm_venta") = " "
'          Data1.Recordset("tm_clave_dcv") = ""
'          Data1.Recordset.Update
'          TABLE1.TextMatrix(TABLE1.Row, 0) = Data1.Recordset("tm_venta")
'          TABLE1.TextMatrix(TABLE1.Row, 7) = Data1.Recordset("tm_clave_dcv")
'          If CmdTipoFiltro.Caption = "Ver Todos" And TABLE1.Rows - 1 = 1 Then
'             CmdTipoFiltro.Caption = "Ver Sel."
'             Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1"
'             Data1.Refresh
'          ElseIf CmdTipoFiltro.Caption = "Ver Todos" And Data1.Recordset.RecordCount > 1 Then
'                 Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
'                 Data1.Refresh
'          End If
'
'       End If
'
'    'End If
'
'    If Data1.Recordset("tm_venta") = "*" Then
'
'       If VENTA_VerBloqueo(FormHandle, Data1) Then
'
'          Data1.Recordset.Edit
'          Data1.Recordset("tm_venta") = " "
'          Data1.Recordset.Update
'       End If
'
'    End If
'
'    If Data1.Recordset.RecordCount > 0 Then
'       Call VENTA_Restaurar(Data1)
'    End If
'
'    Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))
'
'    TxtTotal.Text = VENTA_SumarTotal(FormHandle)
'    Flt_Result.caption = VENTA_SumarDif(FormHandle)
'     Data1.Recordset.MoveLast
'     TABLE1.Rows = Data1.Recordset.RecordCount + 1
'     Data1.Refresh
'     Call refresca
'    'For z = 2 To TABLE1.Cols - 1
'    '  TABLE1.Col = z
'    '  TABLE1.CellBackColor = &HC0C0C0
'    '  TABLE1.CellForeColor = &H800000
'    'Next z
'    'TABLE1.Col = 0
'    'Call colores
'    'Call refresca
'
'   If filita <= TABLE1.Rows - 1 Then
'    TABLE1.Row = filita
'   Else
'    TABLE1.Row = TABLE1.Rows - 1
'   End If
'
'    TABLE1.Refresh
'    TABLE1.Col = 2
'    TABLE1.SetFocus
'End If
End Sub

Private Sub CmdTipoFiltro_Click()
'
'    If CmdTipoFiltro.Caption = "Ver Todos" Then
'        CmdTipoFiltro.Caption = "Ver Sel."
'        Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1"
'        Data1.Refresh
'
'
'    Else
'        filita = TABLE1.Row
'        If Val(TxtTotal.Text) > 0 Then
'            CmdTipoFiltro.Caption = "Ver Todos"
'            Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
'            Data1.Refresh
'        End If
'    End If
'    TABLE1.Rows = 1
'    TABLE1.Row = 0
'    Do While Not Data1.Recordset.EOF
'             TABLE1.Rows = TABLE1.Rows + 1
'             TABLE1.Row = TABLE1.Rows - 1
'             Call Llenar_Grilla
'             Data1.Recordset.MoveNext
'    Loop
'
'    TxtCartera.Text = VENTA_SumarCartera(FormHandle, "1", CmdTipoFiltro)
'    Valor = True
'    If filita <= TABLE1.Rows - 1 Then
'     TABLE1.Row = filita
'    End If
'    TABLE1.SetFocus
End Sub


Private Sub CmdVenta_Click()
'filita = TABLE1.Row
'Dim fila_table As Integer
'
'If Data1.Recordset.RecordCount = 0 Then Exit Sub
'
'fila_table = TABLE1.Row - 1
'
'If VENTA_VerDispon(FormHandle, Data1) Then
'    If Not TABLE1.Row = 1 Then
'            Call Colocardata1
'    Else
'            Data1.Recordset.MoveFirst
'    End If
'   If Data1.Recordset("tm_venta") = " " Or Data1.Recordset("tm_venta") = "*" Then
'
'      If VENTA_Bloquear(FormHandle, Data1) Then
'         Data1.Recordset.Edit
'         Data1.Recordset("tm_venta") = "V"
'
'         If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
'            Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
'         Else
'            Data1.Recordset("tm_clave_dcv") = ""
'         End If
'
'         Data1.Recordset.Update
'         TABLE1.TextMatrix(TABLE1.Row, 8) = Data1.Recordset("tm_clave_dcv")
'      Else
'         Data1.Recordset.Edit
'         Data1.Recordset("tm_venta") = "*"
'         Data1.Recordset.Update
'      End If
'       TABLE1.TextMatrix(TABLE1.Row, 0) = Data1.Recordset("tm_venta")
'   End If
'
'End If
'
'TxtTotal.Text = VENTA_SumarTotal(FormHandle)
'Flt_Result.caption = VENTA_SumarDif(FormHandle)
'
'Data1.Refresh
'Data1.Recordset.Move fila_table
'Call colores
'TABLE1.SetFocus
'TABLE1.Refresh
'If filita <= TABLE1.Rows - 1 Then
'    TABLE1.Row = filita
'Else
'    TABLE1.Row = TABLE1.Rows - 1
'End If
'
'TABLE1.Col = 2
'TABLE1.SetFocus
   
End Sub
