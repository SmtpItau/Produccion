VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRMRepDinamicos 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Filtros para Reporte Dinamico Operaciones Moneda Nacional"
   ClientHeight    =   7215
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   10725
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7215
   ScaleWidth      =   10725
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10725
      _ExtentX        =   18918
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Aceptar"
            Description     =   "Aceptar"
            Object.ToolTipText     =   "Pantalla"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Impresion"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Ex"
            Description     =   "Salir"
            Object.ToolTipText     =   "Excel"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   7680
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   6
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRMRepDinamicos.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRMRepDinamicos.frx":0320
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRMRepDinamicos.frx":0772
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRMRepDinamicos.frx":0A8C
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRMRepDinamicos.frx":0DAC
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRMRepDinamicos.frx":3586
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   6765
      Index           =   0
      Left            =   0
      TabIndex        =   59
      Top             =   450
      Width           =   5400
      _Version        =   65536
      _ExtentX        =   9525
      _ExtentY        =   11933
      _StockProps     =   14
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   4
      Begin VB.Frame Frame4 
         Caption         =   "Tipo de Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   615
         Left            =   120
         TabIndex        =   62
         Top             =   1920
         Width           =   5160
         Begin VB.OptionButton Opt_Compra 
            Caption         =   "Compra"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   270
            Left            =   240
            TabIndex        =   6
            Top             =   240
            Width           =   855
         End
         Begin VB.OptionButton Opt_Venta 
            Caption         =   "Venta"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   2160
            TabIndex        =   7
            Top             =   240
            Width           =   795
         End
         Begin VB.OptionButton Opt_CompraVenta 
            Caption         =   "Ambas"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   300
            Left            =   4005
            TabIndex        =   8
            Top             =   240
            Width           =   840
         End
      End
      Begin VB.Frame Frame7 
         Caption         =   "Custodia"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   705
         Left            =   120
         TabIndex        =   61
         Top             =   5400
         Width           =   5160
         Begin VB.OptionButton Opt_ConDCV 
            Caption         =   "Con DCV"
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   165
            TabIndex        =   24
            Top             =   280
            Width           =   1005
         End
         Begin VB.OptionButton Opt_SinDCV 
            Caption         =   "Sin DCV"
            ForeColor       =   &H00800000&
            Height          =   345
            Left            =   2040
            TabIndex        =   25
            Top             =   280
            Width           =   960
         End
         Begin VB.OptionButton Opt_TodosDcv 
            Caption         =   "Todos"
            ForeColor       =   &H00800000&
            Height          =   300
            Left            =   4080
            TabIndex        =   26
            Top             =   280
            Value           =   -1  'True
            Width           =   960
         End
      End
      Begin VB.Frame Frame_Instrumento 
         Caption         =   "Instrumento"
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
         Height          =   585
         Left            =   120
         TabIndex        =   60
         Top             =   6120
         Width           =   5220
         Begin VB.TextBox Txt_Instrumento 
            Height          =   285
            Left            =   120
            TabIndex        =   27
            Top             =   195
            Width           =   3825
         End
         Begin VB.OptionButton Opt_InstruTodos 
            Caption         =   "Todos"
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   4080
            TabIndex        =   28
            Top             =   195
            Value           =   -1  'True
            Width           =   945
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   2955
         Left            =   120
         TabIndex        =   63
         Top             =   2520
         Width           =   5160
         _Version        =   65536
         _ExtentX        =   9102
         _ExtentY        =   5212
         _StockProps     =   14
         Caption         =   "Cliente"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.OptionButton Opt_Rut 
            Caption         =   "Rut Nro "
            ForeColor       =   &H00800000&
            Height          =   375
            Left            =   165
            TabIndex        =   10
            Top             =   645
            Width           =   930
         End
         Begin VB.OptionButton Opt_RutEntre 
            Caption         =   "Rut entre"
            ForeColor       =   &H00800000&
            Height          =   360
            Left            =   165
            TabIndex        =   20
            Top             =   2400
            Width           =   1020
         End
         Begin VB.ComboBox CmbTipoCliente 
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
            Left            =   1545
            Style           =   2  'Dropdown List
            TabIndex        =   9
            Top             =   330
            Width           =   3585
         End
         Begin VB.TextBox Txt_Digito 
            Enabled         =   0   'False
            Height          =   300
            Left            =   2685
            MaxLength       =   1
            TabIndex        =   12
            Top             =   690
            Width           =   345
         End
         Begin VB.TextBox Txt_Nombre 
            Enabled         =   0   'False
            Height          =   285
            Left            =   1095
            TabIndex        =   13
            Top             =   990
            Width           =   3990
         End
         Begin VB.OptionButton Opt_RutTodos 
            Caption         =   "Todos"
            ForeColor       =   &H00800000&
            Height          =   420
            Left            =   4080
            TabIndex        =   23
            Top             =   2400
            Value           =   -1  'True
            Width           =   840
         End
         Begin VB.Frame Frame_SubCliente 
            Caption         =   "SubCliente"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   975
            Left            =   240
            TabIndex        =   64
            Top             =   1320
            Width           =   4935
            Begin VB.TextBox Txt_CodigoEntre 
               Enabled         =   0   'False
               Height          =   285
               Left            =   1515
               TabIndex        =   18
               Top             =   585
               Width           =   1215
            End
            Begin VB.TextBox Txt_CodigoHasta 
               Enabled         =   0   'False
               Height          =   285
               Left            =   3645
               TabIndex        =   19
               Top             =   600
               Width           =   1230
            End
            Begin VB.OptionButton Opt_Codigo_Todos 
               Caption         =   "Todos"
               ForeColor       =   &H00800000&
               Height          =   300
               Left            =   2895
               TabIndex        =   16
               Top             =   240
               Value           =   -1  'True
               Width           =   840
            End
            Begin VB.TextBox Txt_Codigo 
               Enabled         =   0   'False
               Height          =   300
               Left            =   1515
               MouseIcon       =   "FRMRepDinamicos.frx":39D8
               MousePointer    =   99  'Custom
               TabIndex        =   15
               Top             =   240
               Width           =   1230
            End
            Begin VB.OptionButton Opt_Codigo_Entre 
               Caption         =   "Codigo entre"
               ForeColor       =   &H00800000&
               Height          =   300
               Left            =   240
               TabIndex        =   17
               Top             =   600
               Width           =   1200
            End
            Begin VB.OptionButton Opt_Codigo_Unico 
               Caption         =   "Codigo"
               ForeColor       =   &H00800000&
               Height          =   300
               Left            =   225
               TabIndex        =   14
               Top             =   240
               Width           =   1080
            End
            Begin VB.Label Lbl_entre 
               AutoSize        =   -1  'True
               Caption         =   "y el"
               ForeColor       =   &H00800000&
               Height          =   195
               Left            =   3000
               TabIndex        =   65
               Top             =   600
               Width           =   240
            End
         End
         Begin BACControles.TXTNumero Txt_Rut 
            Height          =   285
            Left            =   1080
            TabIndex        =   11
            Top             =   690
            Width           =   1560
            _ExtentX        =   2752
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
            Min             =   "0"
            Max             =   "999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero Txt_RutDesde 
            Height          =   285
            Left            =   1320
            TabIndex        =   21
            Top             =   2400
            Width           =   1095
            _ExtentX        =   1931
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
            Min             =   "0"
            Max             =   "999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero Txt_RutHasta 
            Height          =   285
            Left            =   2865
            TabIndex        =   22
            Top             =   2400
            Width           =   1095
            _ExtentX        =   1931
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
            Min             =   "0"
            Max             =   "999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Label1 
            Caption         =   "Tipo de Cliente"
            ForeColor       =   &H00800000&
            Height          =   285
            Left            =   120
            TabIndex        =   67
            Top             =   375
            Width           =   1260
         End
         Begin VB.Label Label8 
            AutoSize        =   -1  'True
            Caption         =   "y el"
            ForeColor       =   &H00800000&
            Height          =   195
            Left            =   2520
            TabIndex        =   66
            Top             =   2520
            Width           =   240
         End
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   1755
         Left            =   120
         TabIndex        =   68
         Top             =   165
         Width           =   5160
         _Version        =   65536
         _ExtentX        =   9102
         _ExtentY        =   3096
         _StockProps     =   14
         Caption         =   "Datos Generales"
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
         Begin VB.ComboBox CmbProducto 
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
            ItemData        =   "FRMRepDinamicos.frx":3CE2
            Left            =   960
            List            =   "FRMRepDinamicos.frx":3CE4
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   240
            Width           =   4140
         End
         Begin VB.ComboBox CmbFormadePago 
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
            ItemData        =   "FRMRepDinamicos.frx":3CE6
            Left            =   2040
            List            =   "FRMRepDinamicos.frx":3CF9
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   960
            Width           =   3060
         End
         Begin VB.ComboBox CmbMoneda 
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
            Left            =   3840
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   600
            Width           =   1260
         End
         Begin VB.ComboBox CmbTipodeCartera 
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
            Left            =   960
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   570
            Width           =   2100
         End
         Begin VB.ComboBox CmbFormadePagoFi 
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
            ItemData        =   "FRMRepDinamicos.frx":3D37
            Left            =   2040
            List            =   "FRMRepDinamicos.frx":3D4A
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   1320
            Width           =   3060
         End
         Begin VB.Label Label4 
            Caption         =   "Producto"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   225
            Left            =   120
            TabIndex        =   73
            Top             =   240
            Width           =   765
         End
         Begin VB.Label Label7 
            Caption         =   "Medios de Pago Inicio"
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
            Height          =   300
            Left            =   120
            TabIndex        =   72
            Top             =   960
            Width           =   2010
         End
         Begin VB.Label Label3 
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
            Height          =   300
            Left            =   3120
            TabIndex        =   71
            Top             =   600
            Width           =   690
         End
         Begin VB.Label Label14 
            Caption         =   "Cartera"
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
            Height          =   300
            Left            =   120
            TabIndex        =   70
            Top             =   570
            Width           =   810
         End
         Begin VB.Label Label5 
            Caption         =   "Medios de Pago Final"
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
            Height          =   300
            Left            =   120
            TabIndex        =   69
            Top             =   1320
            Width           =   2010
         End
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   6765
      Index           =   2
      Left            =   5445
      TabIndex        =   74
      Top             =   450
      Width           =   5280
      _Version        =   65536
      _ExtentX        =   9313
      _ExtentY        =   11933
      _StockProps     =   14
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   4
      Begin VB.Frame Frame5 
         Caption         =   "Fecha"
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
         Height          =   930
         Left            =   90
         TabIndex        =   86
         Top             =   720
         Width           =   5100
         Begin VB.OptionButton Opt_FechaUnica 
            Caption         =   "Específica"
            ForeColor       =   &H00800000&
            Height          =   240
            Left            =   240
            TabIndex        =   33
            Top             =   240
            Value           =   -1  'True
            Width           =   1125
         End
         Begin VB.OptionButton Opt_FechaDesde 
            Caption         =   "Rango Desde"
            ForeColor       =   &H00800000&
            Height          =   240
            Left            =   240
            TabIndex        =   35
            Top             =   585
            Width           =   1305
         End
         Begin BACControles.TXTFecha Txt_FechaDesde 
            Height          =   285
            Left            =   1560
            TabIndex        =   36
            Top             =   585
            Width           =   1335
            _ExtentX        =   2355
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
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "07/02/2002"
         End
         Begin BACControles.TXTFecha Txt_FechaEspe 
            Height          =   285
            Left            =   1560
            TabIndex        =   34
            Top             =   240
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   503
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
            Text            =   "07/02/2002"
         End
         Begin BACControles.TXTFecha Txt_FechaHasta 
            Height          =   285
            Left            =   3600
            TabIndex        =   37
            Top             =   585
            Width           =   1335
            _ExtentX        =   2355
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
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "07/02/2002"
         End
         Begin VB.Label Label13 
            Caption         =   "Hasta"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   3120
            TabIndex        =   89
            Top             =   585
            Width           =   525
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Valor Final (Nominal / Final)"
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
         Height          =   945
         Left            =   90
         TabIndex        =   83
         Top             =   4320
         Width           =   5100
         Begin VB.OptionButton Opt_ValFinDesde 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   270
            Left            =   120
            TabIndex        =   84
            Top             =   240
            Width           =   330
         End
         Begin VB.OptionButton Opt_ValFinTodos 
            Caption         =   "Todos"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   270
            Left            =   3840
            TabIndex        =   53
            Top             =   240
            Value           =   -1  'True
            Width           =   1050
         End
         Begin BACControles.TXTNumero Txt_ValFinDesde 
            Height          =   285
            Left            =   1230
            TabIndex        =   51
            Top             =   240
            Width           =   2235
            _ExtentX        =   3942
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
            Min             =   "0"
            Max             =   "99999999999.99"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero Txt_ValFinHasta 
            Height          =   285
            Left            =   1230
            TabIndex        =   52
            Top             =   600
            Width           =   2235
            _ExtentX        =   3942
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
            Min             =   "0"
            Max             =   "99999999999.99"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Label9 
            Caption         =   "Hasta"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   510
            TabIndex        =   85
            Top             =   585
            Width           =   480
         End
         Begin VB.Label Label6 
            Caption         =   "Desde"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   510
            TabIndex        =   50
            Top             =   240
            Width           =   480
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Valor Inicial (Operacion / Inicial)"
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
         Height          =   1005
         Left            =   90
         TabIndex        =   80
         Top             =   3240
         Width           =   5100
         Begin VB.OptionButton Opt_ValIniDesde 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   270
            Left            =   120
            TabIndex        =   81
            Top             =   240
            Width           =   330
         End
         Begin VB.OptionButton Opt_ValIniTodos 
            Caption         =   "Todos"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   270
            Left            =   3840
            TabIndex        =   49
            Top             =   240
            Value           =   -1  'True
            Width           =   1050
         End
         Begin BACControles.TXTNumero Txt_ValIniDesde 
            Height          =   285
            Left            =   1230
            TabIndex        =   47
            Top             =   240
            Width           =   2235
            _ExtentX        =   3942
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
            Min             =   "0"
            Max             =   "99999999999.99"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero Txt_ValIniHasta 
            Height          =   285
            Left            =   1230
            TabIndex        =   48
            Top             =   600
            Width           =   2235
            _ExtentX        =   3942
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
            Min             =   "0"
            Max             =   "99999999999.99"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Label2 
            Caption         =   "Desde"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   480
            TabIndex        =   46
            Top             =   240
            Width           =   525
         End
         Begin VB.Label Label10 
            Caption         =   "Hasta"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   480
            TabIndex        =   82
            Top             =   600
            Width           =   525
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "Número de Operación (OMD)"
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
         Height          =   660
         Left            =   90
         TabIndex        =   79
         Top             =   1680
         Width           =   5100
         Begin VB.OptionButton Opt_NumOpeDesde 
            Caption         =   "Desde"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   90
            TabIndex        =   38
            Top             =   180
            Width           =   870
         End
         Begin VB.OptionButton Opt_NumOpeTodos 
            Caption         =   "Todos"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   270
            Left            =   3840
            TabIndex        =   41
            Top             =   210
            Value           =   -1  'True
            Width           =   1050
         End
         Begin VB.TextBox Txt_NumOpDesde 
            Enabled         =   0   'False
            Height          =   270
            Left            =   960
            TabIndex        =   39
            Top             =   240
            Width           =   750
         End
         Begin VB.TextBox Txt_NumOpeHasta 
            Enabled         =   0   'False
            Height          =   270
            Left            =   2520
            TabIndex        =   40
            Top             =   240
            Width           =   810
         End
         Begin VB.Label Label12 
            Caption         =   "Hasta"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   2040
            TabIndex        =   88
            Top             =   240
            Width           =   525
         End
      End
      Begin VB.Frame Frame6 
         Caption         =   "Tasa"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   1410
         Index           =   1
         Left            =   0
         TabIndex        =   77
         Top             =   5280
         Width           =   5220
         Begin VB.OptionButton Opt_TasaDesde 
            Caption         =   "Rango Desde"
            ForeColor       =   &H00800000&
            Height          =   240
            Left            =   90
            TabIndex        =   56
            Top             =   975
            Width           =   1305
         End
         Begin VB.OptionButton Opt_TasaEspecifica 
            Caption         =   "Específica"
            ForeColor       =   &H00800000&
            Height          =   240
            Left            =   90
            TabIndex        =   54
            Top             =   420
            Width           =   1125
         End
         Begin VB.OptionButton Opt_TasaTodos 
            Caption         =   "Todos"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   270
            Left            =   3960
            TabIndex        =   58
            Top             =   360
            Value           =   -1  'True
            Width           =   1050
         End
         Begin BACControles.TXTNumero Txt_TasaHasta 
            Height          =   285
            Left            =   3480
            TabIndex        =   57
            Top             =   960
            Width           =   1095
            _ExtentX        =   1931
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
            Text            =   "0,0000"
            Text            =   "0,0000"
            Min             =   "-99999.9999"
            Max             =   "9999.9999"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero Txt_TasaDesde 
            Height          =   285
            Left            =   1470
            TabIndex        =   78
            Top             =   960
            Width           =   1095
            _ExtentX        =   1931
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
            Text            =   "0,0000"
            Text            =   "0,0000"
            Min             =   "-99999.9999"
            Max             =   "9999.9999"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero Txt_TasaEspecifica 
            Height          =   285
            Left            =   1470
            TabIndex        =   55
            Top             =   360
            Width           =   1095
            _ExtentX        =   1931
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
            Text            =   "0,0000"
            Text            =   "0,0000"
            Min             =   "-99999.9999"
            Max             =   "9999.9999"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Label11 
            Caption         =   "Hasta"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   2925
            TabIndex        =   87
            Top             =   975
            Width           =   525
         End
      End
      Begin VB.Frame Frame10 
         Caption         =   "Número de Contrato"
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
         Height          =   780
         Left            =   90
         TabIndex        =   76
         Top             =   2400
         Width           =   5100
         Begin VB.OptionButton Opt_ContratoTodos 
            Caption         =   "Todos"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   270
            Left            =   3840
            TabIndex        =   45
            Top             =   330
            Value           =   -1  'True
            Width           =   1050
         End
         Begin VB.OptionButton Opt_ContratoDesde 
            Caption         =   "Desde"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   90
            TabIndex        =   42
            Top             =   300
            Width           =   840
         End
         Begin VB.TextBox Txt_ContratoDesde 
            Enabled         =   0   'False
            Height          =   270
            Left            =   960
            TabIndex        =   43
            Top             =   360
            Width           =   750
         End
         Begin VB.TextBox Txt_ContratoHasta 
            Enabled         =   0   'False
            Height          =   270
            Left            =   2520
            TabIndex        =   44
            Top             =   360
            Width           =   810
         End
         Begin VB.Label Label15 
            Caption         =   "Hasta"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   2025
            TabIndex        =   90
            Top             =   345
            Width           =   525
         End
      End
      Begin VB.Frame frame15 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   570
         Left            =   90
         TabIndex        =   75
         Top             =   170
         Width           =   5100
         Begin VB.OptionButton Opt_FechaCurse 
            Caption         =   "Fecha Curse"
            ForeColor       =   &H00800000&
            Height          =   285
            Left            =   120
            TabIndex        =   29
            Top             =   240
            Width           =   1275
         End
         Begin VB.OptionButton Opt_FechaVcto 
            Caption         =   "Fecha Vcto."
            ForeColor       =   &H00800000&
            Height          =   285
            Left            =   1560
            TabIndex        =   30
            Top             =   240
            Width           =   1185
         End
         Begin VB.OptionButton Opt_NoAplica 
            Caption         =   "N/A"
            ForeColor       =   &H00800000&
            Height          =   285
            Left            =   4380
            TabIndex        =   32
            Top             =   240
            Value           =   -1  'True
            Width           =   645
         End
         Begin VB.OptionButton Opt_FechaVgca 
            Caption         =   "Fecha Vigencia"
            ForeColor       =   &H8000000D&
            Height          =   225
            Left            =   2820
            TabIndex        =   31
            Top             =   270
            Width           =   1425
         End
      End
   End
End
Attribute VB_Name = "FRMRepDinamicos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private ClsMonedas      As Object
Private ClsCodigos      As Object

Dim Datos()

Dim Sql                 As String
Dim Valida_Combo        As Boolean
Dim Datos_Necesario     As Boolean
Dim Digito              As String
Dim Sproducto1          As String
Dim Sproducto2          As String
Dim STipo_Cartera       As String
Dim SForma_pago         As String
Dim SForma_pagofi       As String
Dim SCompra             As String
Dim SVenta              As String
Dim Stipo_cliente       As String
Dim sMoneda             As String
Dim SRut                As String
Dim SCodigoEntre        As String
Dim SCodigoHasta        As String
Dim SRutEntre           As String
Dim SRutHasta           As String
Dim SFecha_desde        As String
Dim SFecha_hasta        As String
Dim SN_OpeDesde         As String
Dim SN_OpeHasta         As String
Dim SN_ConDesde         As String
Dim SN_ConHasta         As String
Dim SValor_Inicial      As String
Dim SValor_Final        As String
Dim SValor_Inicial2     As String
Dim SValor_Final2       As String
Dim sTasaEntre          As String
Dim sTasaHasta          As String
Dim STipo_Select        As Integer
Dim SSDCV               As String
Dim SCDCV               As String
Dim SCodigo_instru      As String

Dim objTipCar           As New ClsCodigos

Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" _
                   (ByVal hWnd As Long, ByVal lpszOp As String, _
                    ByVal lpszFile As String, ByVal lpszParams As String, _
                    ByVal LpszDir As String, ByVal FsShowCmd As Long) _
                    As Long

Function Busca_Cliente()
    Envia = Array()

    Screen.MousePointer = 11

    Busca_Cliente = False
    
    AddParam Envia, CDbl(Txt_Rut.Text)
    AddParam Envia, CDbl(Txt_Codigo.Text)
          
    If Not Bac_Sql_Execute("sp_clleerrut1", Envia) Then
        MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical, gsBac_Version
        Exit Function
    End If
          
    If Bac_SQL_Fetch(Datos()) Then
        Txt_Nombre = Datos(4)
'       cltipcli = Val(datos(10))
        Busca_Cliente = True
   
    End If
    
    Screen.MousePointer = 0

End Function


Sub EjecutaExcel()

   Dim sCadena       As String
   Dim nUltimaCol    As Integer
   Dim Sql           As String
   Dim i             As Integer


   On Error GoTo ErrArchivo
   Envia = Array()


   FileCopy RptList_Path & "Filtro_Nacional.xls", RptList_Path & "Filtro_Moneda_Nacional.xls"

   Set oconeccionexcel = New ADODB.Connection
   oconeccionexcel.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & RptList_Path & "Filtro_Moneda_Nacional.xls;Extended Properties=""Excel 8.0;HDR=NO;"""

   oconeccionexcel.Execute "UPDATE Fecha SET F1 = '" & CStr(Format(Date, "dd/mm/yyyy")) & "'"
   oconeccionexcel.Execute "UPDATE Hora  SET F1 =  '" & CStr(Time) & "'"

' Parametros
AddParam Envia, STipo_Select        '@STIPO_SELECT
AddParam Envia, Sproducto1          '@SPRODUCTO1
AddParam Envia, Sproducto2          '@SPRODUCTO2
AddParam Envia, STipo_Cartera       '@STIPOCARTERA
AddParam Envia, SForma_pago         '@SFORMA_PAGO
AddParam Envia, sMoneda             '@SMONEDA
AddParam Envia, SValor_Inicial      '@SVALOR_INICIAL
AddParam Envia, SValor_Final        '@SVALOR_FINAL
AddParam Envia, sMoneda             '@SMONEDA_FINAL
AddParam Envia, SValor_Inicial2     '@SVALOR_INICIAL2
AddParam Envia, SValor_Final2       '@SVALOR_FINAL2
AddParam Envia, SCompra             '@SCOMPRA
AddParam Envia, SVenta              '@SVENTA
AddParam Envia, SRutEntre           '@SRUTENTRE
AddParam Envia, SRutHasta           '@SRUTHASTA
AddParam Envia, SCodigoEntre        '@SCODIGOENTRE
AddParam Envia, SCodigoHasta        '@SCODIGOHASTA
AddParam Envia, SFecha_desde        '@SFECHA_DESDE
AddParam Envia, SFecha_hasta        '@SFECHA_HASTA
AddParam Envia, SN_OpeDesde         '@SN_OPEDESDE
AddParam Envia, SN_OpeHasta         '@SN_OPEHASTA
AddParam Envia, Stipo_cliente       '@STIPO_CLIENTE
AddParam Envia, SSDCV               '@SSDCV
AddParam Envia, SCDCV               '@ScDCV
AddParam Envia, CDbl(sTasaEntre)    '@STASAENTRE
AddParam Envia, CDbl(sTasaHasta)    '@STASAHASTA
AddParam Envia, SCodigo_instru      'SCODINS
AddParam Envia, SForma_pagofi       '@SFORMA_PAGOFIN
AddParam Envia, SN_ConDesde         '@SN_CONDESDE
AddParam Envia, SN_ConHasta         '@SN_CONHASTA

If Not Bac_Sql_Execute("SP_REPORTE_FILTRO_DINAMICO_BTR ", Envia) Then
    MsgBox "Grabación no tuvo exito", 16, TITSISTEMA
    Exit Sub
End If

i = 1
Do While Bac_SQL_Fetch(Datos())
    If i = 1 Then
        oconeccionexcel.Execute "UPDATE Datos SET F1 = '" & Datos(1) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F2  = '" & Datos(2) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F3  =  " & Datos(3)
        oconeccionexcel.Execute "UPDATE Datos SET F4  = '" & Datos(4) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F5  = '" & Datos(5) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F6  = '" & Datos(6) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F7  =  " & Datos(7)
        oconeccionexcel.Execute "UPDATE Datos SET F8  = '" & Datos(8) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F9  = '" & Datos(9) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F10 =  " & Datos(10)
        oconeccionexcel.Execute "UPDATE Datos SET F11 =  " & Datos(11)
        oconeccionexcel.Execute "UPDATE Datos SET F12 = '" & Datos(12) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F13 = '" & Datos(13) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F14 = '" & Datos(14) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F15 = '" & Datos(15) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F16 = '" & Datos(16) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F17 = '" & Datos(17) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F18 = '" & Datos(18) & "'"
    Else
        Sql = "INSERT INTO Datos (F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18)"
        Sql = Sql & " Values ( '" & Datos(1) & " ', '" & Datos(2) & " ', '" & Datos(3) & " ', '" & Datos(4) & " ', '" & Datos(5) & " ', '" & Datos(6) & " ', '" & Datos(7) & " ', '" & Datos(8) & " ', '" & Datos(9) & " ', '" & Datos(10) & " ', '" & Datos(11) & " ', '" & Datos(12) & " ', '" & Datos(13) & " ', '" & Datos(14) & " ', '" & Datos(15) & "','" & Datos(16) & "','" & Datos(17) & "','" & Datos(18) & " ')"
        oconeccionexcel.Execute Sql
    End If
    i = i + 1
Loop
   
    oconeccionexcel.Close
    Set oconeccionexcel = Nothing
    
    DoEvents

    ShellExecute Me.hWnd, "Open", RptList_Path & "Filtro_Moneda_Nacional.xls", "", "C:\", SW_NORMAL

Exit Sub

ErrArchivo:

If err.Number = 70 Then
     
   MsgBox "Ya esta abierto el informe debe cerrarlo para una nueva consulta!!!!", vbCritical
Else
   MsgBox err.Description
End If

End Sub

Private Function ValidaFinal() As Boolean

        ValidaFinal = True

        If CmbProducto.ListIndex = -1 Then
           MsgBox "Falta Producto", vbOKOnly, TITSISTEMA
           ValidaFinal = False
        End If
        
        If Opt_Compra.Enabled Then
        
            If Not Opt_Compra.Value And Not Opt_Venta.Value And Not Opt_CompraVenta.Value Then
                MsgBox "Falta definir Tipo de Operación", vbOKOnly, TITSISTEMA
                ValidaFinal = False
            End If
        End If

        If CmbTipoCliente.ListIndex = -1 Then
           MsgBox "Falta Tipo de Cliente", vbOKOnly, TITSISTEMA
           ValidaFinal = False
        End If

        If Opt_Rut.Value And (Txt_Rut.Text = "" Or Txt_Codigo.Text = "") Then
            MsgBox "Datos Incompletos en Cliente", vbOKOnly, TITSISTEMA
            ValidaFinal = False
        End If
        
        If Opt_RutEntre.Value And (Txt_RutDesde.Text = "") Then   'Or Txt_RutHasta.Text = "" Or Txt_CodigoEntre.Text = "" Or Txt_CodigoHasta.Text = "") Then
            MsgBox "Datos Incompletos en Cliente", vbOKOnly, TITSISTEMA
            ValidaFinal = False
        End If
        
        If Opt_ConDCV.Enabled Then
            
            If Not Opt_ConDCV.Value And Not Opt_SinDCV.Value And Not Opt_TodosDcv.Value Then
                MsgBox "Falta Definir Tipo de Custodia", vbOKOnly, TITSISTEMA
                ValidaFinal = False
            End If
        End If
        
        If Opt_NumOpeDesde.Value Then
        
            If Txt_NumOpDesde.Text = "" Or Txt_NumOpeHasta.Text = "" Then
                MsgBox "Datos Incompletos en Número de Operación (OMD)", vbOKOnly, TITSISTEMA
                ValidaFinal = False
            End If
            
            If Txt_NumOpeHasta.Text < Txt_NumOpDesde.Text Then
                MsgBox "Datos Erroneos en Número de Operación (OMD)", vbOKOnly, TITSISTEMA
                ValidaFinal = False
            End If
        End If
        
        If Opt_ContratoDesde.Value Then
        
            If Txt_ContratoDesde.Text = "" Or Txt_ContratoHasta.Text = "" Then
                MsgBox "Datos Incompletos en Número de Contrato", vbOKOnly, TITSISTEMA
                ValidaFinal = False
            End If
            
            If Txt_ContratoHasta.Text < Txt_ContratoDesde.Text Then
                MsgBox "Datos Erroneos en Número de Contrato", vbOKOnly, TITSISTEMA
                ValidaFinal = False
            End If
        End If
        
        If Opt_ValIniDesde.Value Then
            If Txt_ValIniHasta.Text = 0 Then
                MsgBox "Datos Incompletos en Valor Inicial", vbOKOnly, TITSISTEMA
                ValidaFinal = False
            End If
            
            If Txt_ValIniHasta.Text < Txt_ValIniDesde.Text Then
                MsgBox "Datos Erroneos en Valor Inicial", vbOKOnly, TITSISTEMA
                ValidaFinal = False
            End If
        End If
        
        If Opt_ValFinDesde.Value Then
            If Txt_ValFinHasta.Text = 0 Then
                MsgBox "Datos Incompletos en Valor Final", vbOKOnly, TITSISTEMA
                ValidaFinal = False
            End If
            
            If Txt_ValFinHasta.Text < Txt_ValFinDesde.Text Then
                MsgBox "Datos Erroneos en Valor Final", vbOKOnly, TITSISTEMA
                ValidaFinal = False
            End If
        End If
        
        If Opt_InstruTodos.Enabled Then
        
            If Not Opt_InstruTodos.Value And Txt_Instrumento.Text = "" Then
                MsgBox "Datos Incompletos en Instrumento", vbOKOnly, TITSISTEMA
                ValidaFinal = False
            End If
        End If
        
        'If Opt_TasaEspecifica.Value And Txt_TasaEspecifica.Text = 0 Then
        '        MsgBox "Datos Incompletos en Tasa", vbOKOnly, TITSISTEMA
        '        ValidaFinal = False
                
        'End If
        
        If Opt_TasaDesde.Value Then
        
            'If Txt_TasaHasta.Text = 0 Then
             '   MsgBox "Datos Incompletos en Tasa", vbOKOnly, TITSISTEMA
             '   ValidaFinal = False
            
            'End If
            If CDbl(Txt_TasaHasta.Text) < CDbl(Txt_TasaDesde.Text) Then
                MsgBox "Datos Erroneos en Tasa", vbOKOnly, TITSISTEMA
                ValidaFinal = False
            End If
        End If

        If CDbl(Txt_RutDesde.Text) > CDbl(Txt_RutHasta.Text) Then
            MsgBox "Rut Hasta debe ser mayor o igual que Rut desde", vbOKOnly, TITSISTEMA
            Txt_RutHasta.Text = 0
            ValidaFinal = False
            Txt_RutHasta.SetFocus
        End If

        If CDbl(Txt_ValIniDesde.Text) > CDbl(Txt_ValIniHasta.Text) Then
            MsgBox "Monto Inicial Hasta debe ser mayor o igual que Monto Inicial Desde", vbOKOnly, TITSISTEMA
            Txt_ValIniHasta.Text = 0
            ValidaFinal = False
        End If
        
End Function

Private Sub HabilitaTodo()

    Let CmbProducto.Enabled = True:         Let CmbTipodeCartera.Enabled = True
    Let CmbMoneda.Enabled = True:           Let CmbFormadePago.Enabled = True
    Let CmbFormadePagoFi.Enabled = True:    Let Opt_Compra.Enabled = True
    Let Opt_Venta.Enabled = True:           Let Opt_CompraVenta.Enabled = True
    Let CmbTipoCliente.Enabled = True:      Let Opt_ConDCV.Enabled = True
    Let Opt_SinDCV.Enabled = True:          Let Opt_TodosDcv.Enabled = True
    Let Txt_Instrumento.Enabled = True:     Let Opt_InstruTodos.Enabled = True
    Let Opt_TasaEspecifica.Enabled = True:  Let Opt_TasaDesde.Enabled = True
    Let Opt_TasaTodos.Enabled = True:       Let Opt_FechaVcto.Enabled = True
    Let Opt_FechaCurse.Enabled = True:      Let Opt_FechaVgca.Enabled = True
End Sub

Private Sub CargaCombos()
    CmbProducto.Clear
    CmbProducto.AddItem ("<< TODOS >>" & Space(100) & Trim(0))
    CmbProducto.AddItem "OPERACIONES A TERMINO" & Space(100) & Trim(1)
    CmbProducto.AddItem "OPERACIONES CON PACTO" & Space(100) & Trim(2)
    CmbProducto.AddItem "OPERACIONES INTERBANCARIAS" & Space(100) & Trim(3)
    CmbProducto.AddItem "OPERACIONES PACTOS ANTICIPADOS" & Space(100) & Trim(4)
    CmbProducto.AddItem "OPERACIONES RECOMPRA/REVENTA" & Space(100) & Trim(5)
    CmbProducto.AddItem "OPERACIONES FORWARD UF/$" & Space(100) & Trim(6)
    CmbProducto.AddItem "OPERACIONES 1446" & Space(100) & Trim(7)
    CmbProducto.AddItem "DEP. A PLAZO MATERIALES CON CUSTODIA" & Space(100) & Trim(8)
    CmbProducto.AddItem "DEP. A PLAZO MATERIALES CON ENTREGA" & Space(100) & Trim(9)
    CmbProducto.AddItem "TODOS LOS DEP. A PLAZO MATERIALES" & Space(100) & Trim(10)
    CmbProducto.AddItem "DEP. A PLAZO DESMATERIALIZADOS" & Space(100) & Trim(11)
    CmbProducto.AddItem "TODOS LOS DEPOSITOS" & Space(100) & Trim(12)

    'CmbTipodeCartera.AddItem ("<< TODOS >>" & Space(100) & Trim(0))
    'CmbTipodeCartera.AddItem "AVAILABLE FOR SALE" & Space(100) & Trim(1)
    'CmbTipodeCartera.AddItem "AVAILABLE FOR TRADING" & Space(100) & Trim(2)

    CmbTipodeCartera.Clear
    CmbTipodeCartera.AddItem ("<< TODOS >>" & Space(100) & Trim(0))
    
'LD1-COR-035
'''' corregido para traer cartera normativa --> cod 1111
    Call PROC_LLENA_COMBOS(CmbTipodeCartera, 1111, True, GLB_ID_SISTEMA, "", "", "", gsBac_User)
        
    'Call objTipCar.LeerCodigos(204)
    'Call objTipCar.Coleccion2Control(CmbTipodeCartera)
    
    'CmbTipoCliente.AddItem ("<< TODOS >>" & Space(100) & Trim(0))
    'CmbTipoCliente.AddItem "INSTITUCIONES FINANCIERAS" & Space(100) & Trim(1)
    'CmbTipoCliente.AddItem "CLIENTES CORPORATE" & Space(100) & Trim(2)
    
    CmbTipoCliente.Clear
    CmbTipoCliente.AddItem ("<< TODOS >>" & Space(100) & Trim(0))
    If Not Bac_Sql_Execute("Sp_BUSCA_TIPO_CLIENTE ") Then Exit Sub
           
    Do While Bac_SQL_Fetch(Datos())
        CmbTipoCliente.AddItem Trim(Datos(2)) & Space(100) & Trim(Datos(1))
    Loop
    
    CmbMoneda.Clear
    Call ClsMonedas.LeerMonedas
    Call ClsMonedas.Coleccion2Combo2(CmbMoneda)
    
    CmbFormadePago.Clear
    CmbFormadePago.AddItem ("<< TODOS >>" & Space(50) & Trim(0))
    Call ClsCodigos.LeerForma_de_Pago(999)
    Call ClsCodigos.Coleccion2Control(CmbFormadePago, 2)
    
    CmbFormadePagoFi.Clear
    CmbFormadePagoFi.AddItem ("<< TODOS >>" & Space(50) & Trim(0))
    Call ClsCodigos.LeerForma_de_Pago(999)
    Call ClsCodigos.Coleccion2Control(CmbFormadePagoFi, 2)
    
    Call Limpiar
    
End Sub

Private Sub CmbProducto_Click()

        Call HabilitaTodo
       
        If CmbProducto.ListIndex = 0 Then
            'Todos los productos
            CmbTipodeCartera.ListIndex = -1
            CmbTipodeCartera.Enabled = False
            CmbFormadePago.ListIndex = -1
            CmbFormadePago.Enabled = False
            CmbFormadePagoFi.ListIndex = -1
            CmbFormadePagoFi.Enabled = False

    
            Opt_Compra.Value = False
            Opt_Venta.Value = False
            Opt_CompraVenta.Value = False
            
            Opt_Compra.Enabled = False
            Opt_Venta.Enabled = False
            Opt_CompraVenta.Enabled = False
            
            Opt_ConDCV.Value = False
            Opt_SinDCV.Value = False
            Opt_TodosDcv.Value = True
            Opt_ConDCV.Enabled = False
            Opt_SinDCV.Enabled = False
            Opt_TodosDcv.Enabled = False
                                    
            Opt_InstruTodos.Value = True
            Opt_InstruTodos.Enabled = False
            Txt_Instrumento.Enabled = False
            Frame_Instrumento.Enabled = True
            CmbMoneda.ListIndex = 0
            CmbTipoCliente.ListIndex = 0
            Opt_FechaCurse.Value = True
            CmbFormadePago.ListIndex = 0
            CmbFormadePagoFi.ListIndex = 0
            CmbTipodeCartera.ListIndex = 0

        ElseIf CmbProducto.ListIndex = 3 Then
            ' Interbancarias
            Opt_Compra.Value = False
            Opt_Venta.Value = False
            Opt_CompraVenta.Value = False
            Opt_Compra.Enabled = False
            Opt_Venta.Enabled = False
            Opt_CompraVenta.Enabled = False
            Opt_TasaTodos.Value = True
            Opt_InstruTodos.Value = True
            Opt_ConDCV.Value = False
            Opt_SinDCV.Value = False
            Opt_TodosDcv.Value = True
            Opt_ConDCV.Enabled = False
            Opt_SinDCV.Enabled = False
            Opt_TodosDcv.Enabled = False
            Frame_Instrumento.Enabled = True
            Opt_InstruTodos.Value = True
            Txt_Instrumento.Text = ""
            Opt_InstruTodos.Enabled = False
            Txt_Instrumento.Enabled = False
            Frame_Instrumento.Enabled = False
            Opt_FechaCurse.Value = True
            Opt_FechaVcto.Value = False
            Opt_FechaVgca.Value = True
            CmbTipodeCartera.ListIndex = 0
            CmbTipodeCartera.Enabled = False
            CmbFormadePago.ListIndex = 0
            
        ElseIf CmbProducto.ListIndex = 6 Or CmbProducto.ListIndex = 7 Or CmbProducto.ListIndex = 8 Or CmbProducto.ListIndex = 9 Or CmbProducto.ListIndex = 10 Or CmbProducto.ListIndex = 11 Or CmbProducto.ListIndex = 12 Then
            'Forward UF/$$ y 1446
'            CmbTipodeCartera.ListIndex = -1
             CmbTipodeCartera.Enabled = False
        
            If CmbProducto.ListIndex = 6 Then
               Opt_Compra.Value = False
               Opt_Venta.Value = False
               Opt_CompraVenta.Value = False
               Opt_Compra.Enabled = True
               Opt_Venta.Enabled = True
               Opt_CompraVenta.Enabled = True
               CmbMoneda.ListIndex = 0
               CmbMoneda.Enabled = False
               CmbFormadePago.Enabled = False
               CmbFormadePagoFi.Enabled = True
             Else
               Opt_Compra.Value = False
               Opt_Venta.Value = False
               Opt_CompraVenta.Value = False
               Opt_Compra.Enabled = False
               Opt_Venta.Enabled = False
               Opt_CompraVenta.Enabled = False
               CmbFormadePago.Enabled = True
               CmbFormadePagoFi.Enabled = False
             End If
             
            Opt_ConDCV.Value = False
            Opt_SinDCV.Value = False
            Opt_TodosDcv.Value = True
            Opt_ConDCV.Enabled = False
            Opt_SinDCV.Enabled = False
            Opt_TodosDcv.Enabled = False
            Opt_InstruTodos.Value = True
            Opt_InstruTodos.Enabled = False
            Txt_Instrumento.Enabled = False
            Frame_Instrumento.Enabled = False
            If CmbProducto.ListIndex = 6 Then
                Opt_TasaEspecifica.Value = False
                Opt_TasaDesde.Value = False
                Opt_TasaTodos.Value = True
                Opt_TasaEspecifica.Enabled = False
                Opt_TasaDesde.Enabled = False
                Opt_TasaTodos.Enabled = False
            End If
            Opt_CompraVenta.Value = True
            CmbFormadePago.ListIndex = 0
            Opt_FechaVgca.Value = True 'False
            Opt_FechaVgca.Enabled = True 'False

        ElseIf CmbProducto.ListIndex = 1 Or CmbProducto.ListIndex = 2 Then
            Opt_Compra.Value = False
            Opt_Venta.Value = False
            Opt_CompraVenta.Value = True
            Opt_Compra.Enabled = True
            Opt_Venta.Enabled = True
            Opt_CompraVenta.Enabled = True
            Opt_FechaCurse.Value = True
            Opt_InstruTodos.Enabled = True
            Txt_Instrumento.Enabled = True
            Frame_Instrumento.Enabled = True
            Opt_InstruTodos.Value = True
            If CmbProducto.ListIndex = 1 Then
                Opt_ConDCV.Value = False
                Opt_SinDCV.Value = False
                Opt_TodosDcv.Value = True
                Opt_ConDCV.Enabled = True
                Opt_SinDCV.Enabled = True
                Opt_TodosDcv.Enabled = True
                Opt_InstruTodos.Value = True
                Opt_InstruTodos.Enabled = True
                Txt_Instrumento.Enabled = True
                Frame_Instrumento.Enabled = True
                CmbFormadePagoFi.ListIndex = 0
                CmbFormadePagoFi.Enabled = False
             Else
                Opt_ConDCV.Value = False
                Opt_SinDCV.Value = False
                Opt_TodosDcv.Value = True
                Opt_ConDCV.Enabled = False
                Opt_SinDCV.Enabled = False
                Opt_TodosDcv.Enabled = False
                Opt_FechaVgca.Enabled = True
             End If
            
            If CmbProducto.ListIndex = 1 Then
             Opt_FechaVcto.Value = False
             Opt_FechaVcto.Enabled = False
             Opt_FechaVgca.Value = False
             Opt_FechaVgca.Enabled = False

            End If
        ElseIf CmbProducto.ListIndex = 5 Or CmbProducto.ListIndex = 4 Then
            Opt_FechaCurse.Value = True
            Opt_FechaVcto.Value = False
'            CmbTipodeCartera.ListIndex = -1
'            CmbTipodeCartera.Enabled = False
            Opt_Compra.Value = False
            Opt_Venta.Value = False
            Opt_CompraVenta.Value = False
            Opt_Compra.Enabled = False
            Opt_Venta.Enabled = False
            Opt_CompraVenta.Enabled = False
            Opt_FechaVcto.Value = False
            Opt_FechaVcto.Enabled = False
            Opt_ConDCV.Value = False
            Opt_SinDCV.Value = False
            Opt_TodosDcv.Value = True
            Opt_ConDCV.Enabled = False
            Opt_SinDCV.Enabled = False
            Opt_TodosDcv.Enabled = False
            Opt_FechaVgca.Value = False
            Opt_FechaVgca.Enabled = False
        Else
            'el Resto de los productos
            Opt_Compra.Value = False
            Opt_Venta.Value = False
            Opt_CompraVenta.Value = False
            Opt_Compra.Enabled = False
            Opt_Venta.Enabled = False
            Opt_CompraVenta.Enabled = False
            Opt_InstruTodos.Value = True
            Frame_Instrumento.Enabled = True
            Opt_TasaTodos.Value = True
            
            If CmbProducto.ListIndex = 4 Then
               Opt_FechaCurse.Value = False
               Opt_FechaCurse.Enabled = False
               Opt_FechaVcto.Value = True
            Else
                Opt_FechaCurse.Value = True
            End If
        
            If CmbProducto.ListIndex = 1 Then
               Opt_FechaVcto.Value = False
               Opt_FechaVcto.Enabled = False
            End If
            
            CmbTipodeCartera.ListIndex = 0
            CmbFormadePago.ListIndex = 0
        End If
End Sub

Private Sub Form_Load()
            
    Set BacFrmIRF = Me
            
    Set ClsMonedas = New ClsMonedas
    Set ClsCodigos = New ClsCodigos
    
    Call CargaCombos
    
    Let Height = 7560:                          Let Width = 10800
    Let Top = 0:                                Let Left = 0
    Let Txt_FechaEspe.Text = gsBac_Fecp:        Let Txt_FechaDesde.Text = gsBac_Fecp
    Let Txt_FechaHasta.Text = gsBac_Fecp:       Let Txt_FechaDesde.Enabled = False
    Let Txt_FechaHasta.Enabled = False
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Set ClsMonedas = Nothing
    Set ClsCodigos = Nothing
    Set objTipCar = Nothing
End Sub

Private Sub Frame_Instrumento_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    Screen.MousePointer = vbDefault
End Sub

Private Sub Frame6_MouseMove(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
    Screen.MousePointer = vbDefault
End Sub

Private Sub Frame7_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    Screen.MousePointer = vbDefault
End Sub

Private Sub Opt_Codigo_Entre_Click()
    Let Txt_CodigoEntre.Enabled = True:     Let Txt_CodigoHasta.Enabled = True
    Let Txt_Codigo.Text = "":               Let Opt_Codigo_Unico.Value = False
    Let Txt_Codigo.Enabled = False:         Let Opt_Codigo_Todos.Value = False

End Sub

Private Sub Opt_Codigo_Todos_Click()
    Let Opt_Codigo_Unico.Value = False:     Let Opt_Codigo_Entre.Value = False
    Let Txt_CodigoEntre.Enabled = False:    Let Txt_CodigoHasta.Enabled = False
    Let Txt_Codigo.Enabled = False:         Let Txt_CodigoEntre.Text = ""
    Let Txt_CodigoHasta.Text = "":          Let Txt_Codigo.Text = "0"
End Sub

Private Sub Opt_Codigo_Unico_Click()
    Let Opt_Codigo_Todos.Value = False:     Let Opt_Codigo_Entre.Value = False
    Let Txt_CodigoEntre.Enabled = False:    Let Txt_CodigoHasta.Enabled = False
    Let Txt_Codigo.Enabled = True:          Let Txt_CodigoEntre.Text = ""
    Let Txt_CodigoHasta.Text = ""
End Sub

Private Sub Opt_Compra_Click()
    If CmbProducto.ListIndex = 1 Then
        SCompra = "CP "
        SVenta = "   "
    ElseIf CmbProducto.ListIndex = 6 Then
        SCompra = "C"
        SVenta = " "
    
    End If
End Sub

Private Sub Opt_CompraVenta_Click()
    If CmbProducto.ListIndex = 1 Then
        SCompra = "CP "
        SVenta = "VP "
    ElseIf CmbProducto.ListIndex = 6 Then
        SCompra = "C"
        SVenta = "V"
    End If
End Sub

Private Sub Opt_ContratoDesde_Click()
    Let Txt_ContratoDesde.Enabled = Opt_ContratoDesde.Value
    Let Txt_ContratoHasta.Enabled = Opt_ContratoDesde.Value
End Sub

Private Sub Opt_ContratoTodos_Click()

    If Opt_ContratoTodos.Value Then
        Let Txt_ContratoDesde.Text = ""
        Let Txt_ContratoHasta.Text = ""
    End If
    
    Let Txt_ContratoDesde.Enabled = Not Opt_ContratoTodos.Value
    Let Txt_ContratoHasta.Enabled = Not Opt_ContratoTodos.Value
        
End Sub

Private Sub Opt_FechaCurse_Click()

    Let Opt_FechaUnica.Value = True:        Let Opt_FechaDesde.Value = False
    Let Opt_FechaUnica.Enabled = True:      Let Opt_FechaDesde.Enabled = True
    Let Opt_FechaVcto.Value = False:        Let Opt_NoAplica.Value = False
    'Txt_FechaEspe.Enabled = True
    'Txt_FechaDesde.Enabled = True
    'Txt_FechaHasta.Enabled = True

End Sub

Private Sub Opt_FechaDesde_Click()
    Let Txt_FechaEspe.Enabled = Not Opt_FechaDesde.Value
    Let Txt_FechaDesde.Enabled = Opt_FechaDesde.Value
    Let Txt_FechaHasta.Enabled = Opt_FechaDesde.Value

End Sub

Private Sub Opt_FechaUnica_Click()
    Let Txt_FechaEspe.Enabled = Opt_FechaUnica.Value
    Let Txt_FechaDesde.Enabled = Not Opt_FechaUnica.Value
    Let Txt_FechaHasta.Enabled = Not Opt_FechaUnica.Value
End Sub

Private Sub Opt_FechaVcto_Click()

    Let Opt_FechaUnica.Value = True:        Let Opt_FechaDesde.Value = False
    Let Opt_FechaUnica.Enabled = True:      Let Opt_FechaDesde.Enabled = True
    Let Opt_FechaCurse.Value = False:       Let Opt_NoAplica.Value = False
    'Txt_FechaEspe.Enabled = True
    'Txt_FechaDesde.Enabled = True
    'Txt_FechaHasta.Enabled = True

End Sub

Private Sub Opt_FechaVgca_Click()
    Let Opt_FechaUnica.Enabled = True:      Let Txt_FechaEspe.Enabled = True
    Let Opt_FechaDesde.Enabled = True:      Let Txt_FechaDesde.Enabled = True
    Let Txt_FechaHasta.Enabled = True
End Sub

Private Sub Opt_InstruTodos_Click()
    Let Txt_Instrumento.Text = ""
    Let SCodigo_instru = 0
    FiltrosMonedaNacional.Refresh
End Sub

Private Sub Opt_InstruTodos_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    Let Screen.MousePointer = vbDefault
End Sub

Private Sub Opt_NoAplica_Click()
    Let Opt_FechaUnica.Value = False:       Let Opt_FechaDesde.Value = False
    Let Opt_FechaUnica.Enabled = False:     Let Opt_FechaDesde.Enabled = False
    Let Opt_FechaVcto.Value = False:        Let Opt_FechaCurse.Value = False
    Let Txt_FechaEspe.Enabled = False:      Let Txt_FechaDesde.Enabled = False
    Let Txt_FechaHasta.Enabled = False
End Sub

Private Sub Opt_NumOpeDesde_Click()
    Let Txt_NumOpDesde.Enabled = Opt_NumOpeDesde.Value
    Let Txt_NumOpeHasta.Enabled = Opt_NumOpeDesde.Value
End Sub

Private Sub Opt_NumOpeTodos_Click()

        If Opt_NumOpeTodos.Value Then
            Let Txt_NumOpDesde.Text = ""
            Let Txt_NumOpeHasta.Text = ""
        End If

        Let Txt_NumOpDesde.Enabled = Not Opt_NumOpeTodos.Value
        Let Txt_NumOpeHasta.Enabled = Not Opt_NumOpeTodos.Value

End Sub

Private Sub Opt_Rut_Click()

        If Opt_Rut.Value Then
            Let Txt_RutDesde.Text = "":     Let Txt_RutHasta.Text = ""
            Let Txt_CodigoEntre.Text = "":  Let Txt_CodigoHasta.Text = ""
            
        End If
        
        Let Txt_Rut.Enabled = Opt_Rut.Value
        Let Txt_RutDesde.Enabled = Not Opt_Rut.Value
        Let Txt_RutHasta.Enabled = Not Opt_Rut.Value
        Let Frame_SubCliente.Enabled = True:    Let Opt_Codigo_Unico.Enabled = True
        Let Txt_Codigo.Enabled = True:          Let Opt_Codigo_Entre.Enabled = True
        Let Txt_CodigoEntre.Enabled = False:    Let Txt_CodigoHasta.Enabled = False
        Let Lbl_entre.Enabled = True:           Let Opt_Codigo_Todos.Enabled = True
        Let Opt_Codigo_Todos.Value = True:      Txt_Rut.SetFocus

End Sub

Private Sub Opt_RutEntre_Click()

        If Opt_RutEntre.Value Then
            Let Txt_Rut.Text = "":          Let Txt_Digito.Text = ""
            Let Txt_Codigo.Text = "":       Let Txt_Nombre.Text = ""
            
        End If
        
        Let Txt_Rut.Enabled = Not Opt_RutEntre.Value
        Let Txt_RutDesde.Enabled = Opt_RutEntre.Value
        Let Txt_RutHasta.Enabled = Opt_RutEntre.Value
        Let Txt_CodigoEntre.Enabled = Opt_RutEntre.Value
        
        Let Frame_SubCliente.Enabled = False:       Let Opt_Codigo_Unico.Enabled = False
        Let Txt_Codigo.Enabled = False:             Let Opt_Codigo_Entre.Enabled = False
        Let Txt_CodigoEntre.Enabled = False:        Let Txt_CodigoHasta.Enabled = False
        Let Lbl_entre.Enabled = False:              Let Opt_Codigo_Todos.Enabled = False

End Sub

Private Sub Opt_RutTodos_Click()

    'If Opt_RutTodos.Value Then
        Let Txt_Rut.Text = "":          Let Txt_Digito.Text = ""
        Let Txt_Codigo.Text = "":       Let Txt_RutDesde.Text = ""
        Let Txt_RutHasta.Text = "":     Let Txt_CodigoEntre.Text = ""
        Let Txt_CodigoHasta.Text = "":  Let Txt_Nombre.Text = ""
        
   ' End If

    Let Txt_Rut.Enabled = Not Opt_RutTodos.Value
    Let Txt_RutDesde.Enabled = Not Opt_RutTodos.Value
    Let Txt_RutHasta.Enabled = Not Opt_RutTodos.Value
    Let Frame_SubCliente.Enabled = False:       Let Opt_Codigo_Unico.Enabled = False
    Let Txt_Codigo.Enabled = False:             Let Opt_Codigo_Entre.Enabled = False
    Let Txt_CodigoEntre.Enabled = False:        Let Txt_CodigoHasta.Enabled = False
    Let Lbl_entre.Enabled = False:              Let Opt_Codigo_Todos.Enabled = False

End Sub

Private Sub Opt_TasaDesde_Click()

    If Opt_TasaDesde.Value Then
        Txt_TasaEspecifica.Text = 0
        
    End If
    
    Let Txt_TasaEspecifica.Enabled = Not Opt_TasaDesde.Value
    Let Txt_TasaDesde.Enabled = Opt_TasaDesde.Value
    Let Txt_TasaHasta.Enabled = Opt_TasaDesde.Value
        
End Sub

Private Sub Opt_TasaEspecifica_Click()

    If Opt_TasaEspecifica.Value Then
        Let Txt_TasaDesde.Text = 0
        Let Txt_TasaHasta.Text = 0
        
    End If
    
    Let Txt_TasaEspecifica.Enabled = Opt_TasaEspecifica.Value
    Let Txt_TasaDesde.Enabled = Not Opt_TasaEspecifica.Value
    Let Txt_TasaHasta.Enabled = Not Opt_TasaEspecifica.Value
        
End Sub

Private Sub Opt_TasaTodos_Click()

    If Opt_TasaTodos.Value Then
        Let Txt_TasaEspecifica.Text = 0#
        Let Txt_TasaDesde.Text = 0#
        Let Txt_TasaHasta.Text = 0#
        
    End If
    
    Let Txt_TasaEspecifica.Enabled = Not Opt_TasaTodos.Value
    Let Txt_TasaDesde.Enabled = Not Opt_TasaTodos.Value
    Let Txt_TasaHasta.Enabled = Not Opt_TasaTodos.Value
        
End Sub

Private Sub Opt_ValFinDesde_Click()
    Let Txt_ValFinDesde.Enabled = Opt_ValFinDesde.Value
    Let Txt_ValFinHasta.Enabled = Opt_ValFinDesde.Value
        
End Sub

Private Sub Opt_ValFinTodos_Click()

    If Opt_ValFinTodos.Value Then
        Let Txt_ValFinDesde.Text = 0
        Let Txt_ValFinHasta.Text = 0
        
    End If
    
    Let Txt_ValFinDesde.Enabled = Not Opt_ValFinTodos.Value
    Let Txt_ValFinHasta.Enabled = Not Opt_ValFinTodos.Value
        
End Sub

Private Sub Opt_ValIniDesde_Click()
    Let Txt_ValIniDesde.Enabled = Opt_ValIniDesde.Value
    Let Txt_ValIniHasta.Enabled = Opt_ValIniDesde.Value
        
End Sub

Private Sub Opt_ValIniTodos_Click()

    If Opt_ValIniTodos.Value Then
        Let Txt_ValIniDesde.Text = 0
        Let Txt_ValIniHasta.Text = 0
    End If
    
    Let Txt_ValIniDesde.Enabled = Not Opt_ValIniTodos.Value
    Let Txt_ValIniHasta.Enabled = Not Opt_ValIniTodos.Value

End Sub

Private Sub Opt_Venta_Click()
    If CmbProducto.ListIndex = 1 Then
        SCompra = "   "
        SVenta = "VP "
    ElseIf CmbProducto.ListIndex = 6 Then
        SCompra = " "
        SVenta = "V"
    End If

End Sub

Private Sub SSFrame2_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    Screen.MousePointer = vbDefault
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    On Error GoTo ErrGenInforme

        Select Case Button.Index
                Case 1
                     If ValidaFinal Then
                        Call Parametros
                        Call Limpiar_Cristal
                        
                        Let Sproducto1 = IIf(Len(Sproducto1) = 0, " ", Sproducto1)
                        Let Sproducto2 = IIf(Len(Sproducto2) = 0, " ", Sproducto2)
                        Let SSDCV = IIf(Len(SSDCV) = 0, " ", SSDCV)
                        Let SCDCV = IIf(Len(SCDCV) = 0, " ", SCDCV)
                        Let SCompra = IIf(Len(SCompra) = 0, " ", SCompra)
                        Let SVenta = IIf(Len(SVenta) = 0, " ", SVenta)
                        
                        BacTrader.bacrpt.ReportFileName = RptList_Path & "Filtro_Moneda_Nacional.rpt"
                        'Parametros
                        BacTrader.bacrpt.StoredProcParam(0) = STipo_Select        '@STIPO_SELECT
                        BacTrader.bacrpt.StoredProcParam(1) = Sproducto1          '@SPRODUCTO1
                        BacTrader.bacrpt.StoredProcParam(2) = Sproducto2          '@SPRODUCTO2
                        BacTrader.bacrpt.StoredProcParam(3) = STipo_Cartera       '@STIPOCARTERA
                        BacTrader.bacrpt.StoredProcParam(4) = SForma_pago         '@SFORMA_PAGO
                        BacTrader.bacrpt.StoredProcParam(5) = sMoneda             '@SMONEDA
                        BacTrader.bacrpt.StoredProcParam(6) = SValor_Inicial      '@SVALOR_INICIAL
                        BacTrader.bacrpt.StoredProcParam(7) = SValor_Final        '@SVALOR_FINAL
                        BacTrader.bacrpt.StoredProcParam(8) = sMoneda             '@SMONEDA_FINAL
                        BacTrader.bacrpt.StoredProcParam(9) = SValor_Inicial2      '@SVALOR_INICIAL2
                        BacTrader.bacrpt.StoredProcParam(10) = SValor_Final2      '@SVALOR_FINAL2
                        BacTrader.bacrpt.StoredProcParam(11) = SCompra            '@SCOMPRA
                        BacTrader.bacrpt.StoredProcParam(12) = SVenta             '@SVENTA
                        BacTrader.bacrpt.StoredProcParam(13) = SRutEntre          '@SRUTENTRE
                        BacTrader.bacrpt.StoredProcParam(14) = SRutHasta          '@SRUTHASTA
                        BacTrader.bacrpt.StoredProcParam(15) = SCodigoEntre       '@SCODIGOENTRE
                        BacTrader.bacrpt.StoredProcParam(16) = SCodigoHasta       '@SCODIGOHASTA
                        BacTrader.bacrpt.StoredProcParam(17) = SFecha_desde       '@SFECHA_DESDE
                        BacTrader.bacrpt.StoredProcParam(18) = SFecha_hasta       '@SFECHA_HASTA
                        BacTrader.bacrpt.StoredProcParam(19) = SN_OpeDesde        '@SN_OPEDESDE
                        BacTrader.bacrpt.StoredProcParam(20) = SN_OpeHasta        '@SN_OPEHASTA
                        BacTrader.bacrpt.StoredProcParam(21) = Stipo_cliente      '@STIPO_CLIENTE
                        BacTrader.bacrpt.StoredProcParam(22) = SSDCV              '@SSDCV
                        BacTrader.bacrpt.StoredProcParam(23) = SCDCV              '@SSDCV
                        BacTrader.bacrpt.StoredProcParam(24) = CDbl(sTasaEntre)   '@STASAENTRE
                        BacTrader.bacrpt.StoredProcParam(25) = CDbl(sTasaHasta)   '@STASAHASTA
                        BacTrader.bacrpt.StoredProcParam(26) = SCodigo_instru     'SCODINS
                        BacTrader.bacrpt.StoredProcParam(27) = SForma_pagofi      '@SFORMA_PAGOFIN
                        BacTrader.bacrpt.StoredProcParam(28) = SN_ConDesde        '@SN_CONDESDE
                        BacTrader.bacrpt.StoredProcParam(29) = SN_ConHasta        '@SN_CONHASTA
                        BacTrader.bacrpt.Connect = CONECCION '-> swConeccion
                        BacTrader.bacrpt.Destination = crptToWindow
                        BacTrader.bacrpt.WindowState = crptMaximized
                        BacTrader.bacrpt.Action = 1
                     End If
                Case 2
                    If ValidaFinal Then
                        Call Parametros
                        BacTrader.bacrpt.ReportFileName = RptList_Path & "Filtro_Moneda_Nacional.rpt"
                        'Parametros
                        Call Limpiar_Cristal
                        
                        Let Sproducto1 = IIf(Len(Sproducto1) = 0, " ", Sproducto1)
                        Let Sproducto2 = IIf(Len(Sproducto2) = 0, " ", Sproducto2)
                        Let SSDCV = IIf(Len(SSDCV) = 0, " ", SSDCV)
                        Let SCDCV = IIf(Len(SCDCV) = 0, " ", SCDCV)
                        Let SCompra = IIf(Len(SCompra) = 0, " ", SCompra)
                        Let SVenta = IIf(Len(SVenta) = 0, " ", SVenta)
                        
                        BacTrader.bacrpt.StoredProcParam(0) = STipo_Select        '@STIPO_SELECT
                        BacTrader.bacrpt.StoredProcParam(1) = Sproducto1          '@SPRODUCTO1
                        BacTrader.bacrpt.StoredProcParam(2) = Sproducto2          '@SPRODUCTO2
                        BacTrader.bacrpt.StoredProcParam(3) = STipo_Cartera       '@STIPOCARTERA
                        BacTrader.bacrpt.StoredProcParam(4) = SForma_pago         '@SFORMA_PAGO
                        BacTrader.bacrpt.StoredProcParam(5) = sMoneda             '@SMONEDA
                        BacTrader.bacrpt.StoredProcParam(6) = SValor_Inicial      '@SVALOR_INICIAL
                        BacTrader.bacrpt.StoredProcParam(7) = SValor_Final        '@SVALOR_FINAL
                        BacTrader.bacrpt.StoredProcParam(8) = sMoneda             '@SMONEDA_FINAL
                        BacTrader.bacrpt.StoredProcParam(9) = SValor_Inicial2     '@SVALOR_INICIAL2
                        BacTrader.bacrpt.StoredProcParam(10) = SValor_Final2      '@SVALOR_FINAL2
                        BacTrader.bacrpt.StoredProcParam(11) = SCompra            '@SCOMPRA
                        BacTrader.bacrpt.StoredProcParam(12) = SVenta             '@SVENTA
                        BacTrader.bacrpt.StoredProcParam(13) = SRutEntre          '@SRUTENTRE
                        BacTrader.bacrpt.StoredProcParam(14) = SRutHasta          '@SRUTHASTA
                        BacTrader.bacrpt.StoredProcParam(15) = SCodigoEntre       '@SCODIGOENTRE
                        BacTrader.bacrpt.StoredProcParam(16) = SCodigoHasta       '@SCODIGOHASTA
                        BacTrader.bacrpt.StoredProcParam(17) = SFecha_desde       '@SFECHA_DESDE
                        BacTrader.bacrpt.StoredProcParam(18) = SFecha_hasta       '@SFECHA_HASTA
                        BacTrader.bacrpt.StoredProcParam(19) = SN_OpeDesde        '@SN_OPEDESDE
                        BacTrader.bacrpt.StoredProcParam(20) = SN_OpeHasta        '@SN_OPEHASTA
                        BacTrader.bacrpt.StoredProcParam(21) = Stipo_cliente      '@STIPO_CLIENTE
                        BacTrader.bacrpt.StoredProcParam(22) = SSDCV              '@SSDCV
                        BacTrader.bacrpt.StoredProcParam(23) = SCDCV              '@SCDCV
                        BacTrader.bacrpt.StoredProcParam(24) = CDbl(sTasaEntre)   'Format(CDbl(sTasaEntre), "9999.9999")  '@STASAENTRE
                        BacTrader.bacrpt.StoredProcParam(25) = CDbl(sTasaHasta)   'Format(CDbl(sTasaHasta), "9999.9999")  '@STASAHASTA
                        BacTrader.bacrpt.StoredProcParam(26) = SCodigo_instru     'SCODINS
                        BacTrader.bacrpt.StoredProcParam(27) = SForma_pagofi      '@SFORMA_PAGOFIN
                        BacTrader.bacrpt.StoredProcParam(28) = SN_ConDesde        '@SN_CONDESDE
                        BacTrader.bacrpt.StoredProcParam(29) = SN_ConHasta        '@SN_CONHASTA
                        BacTrader.bacrpt.Connect = CONECCION '-> swConeccion
                        BacTrader.bacrpt.Destination = crptToPrinter
                        BacTrader.bacrpt.WindowState = crptMaximized
                        BacTrader.bacrpt.Action = 1
                    End If
                
                Case 3
                     If ValidaFinal Then
                        Call Parametros
                        Call EjecutaExcel
                     End If
                Case 4
                     Call Limpiar
                     Call CargaCombos
                Case 5
                     Unload Me
                     
        End Select

    On Error GoTo 0
Exit Sub
ErrGenInforme:
    
'    Call MustraCristal(29)
    
    Call MsgBox(err.Description, vbExclamation, App.Title)
    On Error GoTo 0
End Sub

Private Sub Txt_Codigo_DblClick()
   BacAyuda.Tag = "SUBCLIENTE"
   gscodigo = CDbl(Txt_Rut.Text)
   BacControlWindows 100
   BacAyuda.Show 1
   If giAceptar = True Then
      Txt_Codigo.Text = gsCodCli
      Call Txt_Codigo_LostFocus
   End If

End Sub

Private Sub Txt_Codigo_LostFocus()
 
    If Val(Txt_Rut.Text) = 0 Or Trim(Txt_Digito.Text) = "" Then Exit Sub
    
    If Trim(Txt_Codigo) = "" Or Trim(Txt_Rut.Text) = "" Then
        MsgBox "Error : Datos en Blanco ", 16, TITSISTEMA
        Txt_Codigo.SetFocus
        Exit Sub
    End If
 
    If Not Busca_Cliente() Then
          MsgBox "Cliente No Existe ", 16, TITSISTEMA
          Txt_Nombre.Text = ""
    End If
End Sub

Private Sub Txt_ContratoDesde_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
       KeyAscii = 0
       
       If Val(Txt_ContratoDesde.Text) > Val(Txt_ContratoHasta.Text) And Val(Txt_ContratoHasta) > 0 Then
          MsgBox "Número Contratos DESDE debe ser Menor que Número de Contrato HASTA", vbOKOnly, TITSISTEMA
       Else
            SendKeys "{TAB}"
       End If
       
    Else
    
        If Not IsNumeric(Chr(KeyAscii)) Then
            KeyAscii = 0
        End If
    End If

End Sub

Private Sub Txt_ContratoHasta_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
       KeyAscii = 0
       
       If Val(Txt_ContratoDesde.Text) > Val(Txt_ContratoHasta.Text) Then
          MsgBox "Número Contratos HASTA debe ser Mayor que Número de Contrato DESDE", vbOKOnly, TITSISTEMA
       Else
          SendKeys "{TAB}"
       End If
    Else
        If Not IsNumeric(Chr(KeyAscii)) Then
            KeyAscii = 0
        End If
    End If
End Sub

Private Sub Txt_Digito_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      'SendKeys$ "{TAB}"
      Opt_Codigo_Unico.Value = True
      Txt_Codigo.Text = 0
      Call Txt_Codigo_LostFocus
      
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 75 Or KeyAscii = 107 Or KeyAscii = 8) Then
       KeyAscii = 0
    End If
    BacToUCase KeyAscii

End Sub

Private Sub Txt_FechaHasta_LostFocus()
     If Opt_FechaDesde.Value Then
        If CDate(Txt_FechaHasta.Text) < CDate(Txt_FechaDesde.Text) Then
            MsgBox "La Fecha no puede ser mayor que la fecha Desde", 16, TITSISTEMA
            Txt_FechaHasta.Text = Txt_FechaDesde.Text
            Txt_FechaHasta.SetFocus
        End If
    End If
End Sub

Private Sub Txt_Instrumento_DblClick()
    BacControlWindows 100
    BacAyuda.Tag = "INSTRUMENTO"
    BacAyuda.Show 1
    If giAceptar = True Then
        Txt_Instrumento.MaxLength = 25
        Txt_Instrumento.Text = gsDigito
        SCodigo_instru = gscodigo
        Opt_InstruTodos.Value = False
        'SendKeys "{TAB}"
    End If
End Sub

Private Sub Txt_Instrumento_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    Screen.MousePointer = vbArrowQuestion
End Sub

Private Sub Txt_NumOpDesde_KeyPress(KeyAscii As Integer)
        
    If KeyAscii = 13 Then
       KeyAscii = 0
       
       If Val(Txt_NumOpDesde.Text) > Val(Txt_NumOpeHasta.Text) And Val(Txt_NumOpeHasta.Text) > 0 Then
          MsgBox "Número Operación DESDE debe ser Menor que Número de Operación HASTA", vbOKOnly, TITSISTEMA
          Txt_NumOpDesde.Text = ""
       Else
          SendKeys "{TAB}"
       End If
    Else
        If Not IsNumeric(Chr(KeyAscii)) Then
            KeyAscii = 0
        End If
    End If

End Sub

Private Sub Txt_NumOpeHasta_KeyPress(KeyAscii As Integer)
      
    If KeyAscii = 13 Then
        KeyAscii = 0
        
        If Val(Txt_NumOpDesde.Text) > Val(Txt_NumOpeHasta.Text) Then
          MsgBox "Número Operación HASTA debe ser Mayor que Número de Operación DESDE", vbOKOnly, TITSISTEMA
          Txt_NumOpeHasta.Text = ""
       Else
          SendKeys "{TAB}"
       End If
    Else
        If Not IsNumeric(Chr(KeyAscii)) Then
            KeyAscii = 0
        End If
    End If
        
End Sub
Private Function TraeValor(xValor As Variant) As Double
   If xValor = "" Then
      TraeValor = 0
   Else
      TraeValor = xValor
   End If
End Function

Private Sub Txt_Rut_DblClick()
    Call Valida_Combos
    
    If Valida_Combo = True Then Exit Sub
    
    Tipo_Cliente = TraeValor(Trim(Right(CmbTipoCliente.Text, 5)))
    BacControlWindows 100
    BacAyuda.Tag = "FILTRO_CL2"
    BacAyuda.Show 1
    
    If giAceptar = True Then
        Let Txt_Rut.Text = gscodigo:        Let Txt_Digito.Text = gsDigito
        Let Txt_Codigo.Text = gsCodCli:     Let Txt_Nombre.Text = gsnombre
        Let Opt_Codigo_Unico = True
    End If
End Sub

Private Sub Valida_Combos()
    Valida_Combo = False
    If CmbTipoCliente.ListIndex = -1 Then
       MsgBox "Debe Elegir Tipo de cliente", vbCritical, TITSISTEMA
       Txt_Rut.Text = ""
       Valida_Combo = True
       Exit Sub
    End If
End Sub

Private Sub Txt_Rut_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      Txt_Digito.Enabled = True
      Txt_Digito.SetFocus
   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
   End If
   BacCaracterNumerico KeyAscii

End Sub

Private Sub Txt_Rut_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Screen.MousePointer = vbArrowQuestion
End Sub

Private Sub Txt_TasaDesde_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
        
        If Txt_TasaDesde.Text > Txt_TasaHasta.Text And Txt_TasaHasta.Text > 0 Then
            MsgBox "Tasa DESDE debe ser Menor que Tasa HASTA", vbOKOnly, TITSISTEMA
            Txt_TasaDesde.Text = 0
        Else
            SendKeys "{TAB}"
        End If
    End If

End Sub

Private Sub Txt_TasaHasta_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
        
        If CDbl(Txt_TasaDesde.Text) > CDbl(Txt_TasaHasta.Text) Then
            MsgBox "Tasa HASTA debe ser Mayor que Tasa DESDE", vbOKOnly, TITSISTEMA
            Txt_TasaHasta.Text = 0
        Else
            SendKeys "{TAB}"
        End If
    End If

End Sub

Private Sub Txt_ValFinDesde_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
        
        If Txt_ValFinDesde.Text > Txt_ValFinHasta.Text And Txt_ValFinHasta.Text > 0 Then
           MsgBox "Valor DESDE debe ser Menor que Valor HASTA", vbOKOnly, TITSISTEMA
           Txt_ValFinDesde.Text = 0
        Else
            SendKeys "{TAB}"
        End If
    End If
            
End Sub

Private Sub Txt_ValFinHasta_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
        
        If Txt_ValFinDesde.Text > Txt_ValFinHasta.Text Then
           MsgBox "Valor HASTA debe ser Mayor que Valor DESDE", vbOKOnly, TITSISTEMA
           Txt_ValFinHasta.Text = 0
        Else
            SendKeys "{TAB}"
        End If
    End If
            
End Sub

Private Sub Txt_ValIniDesde_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
       KeyAscii = 0
       
       If Txt_ValIniDesde.Text > Txt_ValIniHasta.Text And Txt_ValIniHasta.Text > 0 Then
          MsgBox "Valor DESDE debe ser Menor que Valor HASTA", vbOKOnly, TITSISTEMA
          Txt_ValIniDesde.Text = 0
       Else
          SendKeys "{TAB}"
       End If
    End If

End Sub

Private Sub Txt_ValIniHasta_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
       KeyAscii = 0
       
       If Txt_ValIniDesde.Text > Txt_ValIniHasta.Text Then
          MsgBox "Valor HASTA debe ser Mayor que Valor DESDE", vbOKOnly, TITSISTEMA
          Txt_ValIniHasta.Text = 0
       Else
          SendKeys "{TAB}"
       End If
    End If

End Sub

Private Sub Parametros()
    
    Sproducto = Trim(Right$(CmbProducto.Text, 7))
    
    If CmbProducto.ListCount > 0 Then
        Debug.Print Trim(CmbProducto.ListIndex) & " - " & CmbProducto.List(CmbProducto.ListIndex)
        Debug.Print Sproducto1 & " - " & Sproducto2 & " - "; Sproducto
        
    End If
    
    If CmbProducto.ListIndex = 2 Then
        If Opt_Compra Then
            Sproducto1 = "CI "
            Sproducto2 = "   "
        ElseIf Opt_Venta Then
            Sproducto1 = "   "
            Sproducto2 = "VI "
        Else
            Sproducto1 = "CI "
            Sproducto2 = "VI "
        End If
    ElseIf CmbProducto.ListIndex = 3 Or CmbProducto.ListIndex = 7 Then
            Sproducto1 = "IB"
            Sproducto2 = "IB"
    ElseIf CmbProducto.ListIndex = 5 Then
            Sproducto1 = "RV "
            Sproducto2 = "RC "
    ElseIf CmbProducto.ListIndex = 8 Or CmbProducto.ListIndex = 12 Or CmbProducto.ListIndex = 11 Or CmbProducto.ListIndex = 9 Or CmbProducto.ListIndex = 10 Then
            Sproducto1 = "IC "
            Sproducto2 = "IC "
    ElseIf CmbProducto.ListIndex = 4 Then
            Sproducto1 = "RCA"
            Sproducto2 = "RVA"
    End If
    
    sMoneda = Trim(Right$(CmbMoneda.Text, 7))
    Stipo_cliente = Trim(Right$(CmbTipoCliente.Text, 7))

    Let SForma_pago = "0"
    If CmbFormadePago.ListIndex >= 0 Then
        SForma_pago = CmbFormadePago.ItemData(CmbFormadePago.ListIndex)
    End If
    'SForma_pago = Trim(Right$(CmbFormadePago.Text, 7))

    Let SForma_pagofi = "0"
    If CmbFormadePagoFi.ListIndex >= 0 Then
        SForma_pagofi = CmbFormadePagoFi.ItemData(CmbFormadePagoFi.ListIndex)
    End If
    'SForma_pagofi = Trim(Right$(CmbFormadePagoFi.Text, 7))

    Let STipo_Cartera = "0"
    If CmbTipodeCartera.ListIndex >= 0 Then
        'STipo_Cartera = CmbTipodeCartera.ItemData(CmbTipodeCartera.ListIndex) 'MODIFICADO PARA LD1-COR-035
        STipo_Cartera = Trim(Right(CmbTipodeCartera.text, 5))
    End If
   'STipo_Cartera = Trim(Right$(CmbTipodeCartera.Text, 7))

    If Opt_Rut.Value = True Then
          SRutEntre = CDbl(Txt_Rut.Text)
          SRutHasta = CDbl(Txt_Rut.Text)
'          SCodigoEntre = CDbl(Txt_Codigo.text)
 '         SCodigoHasta = CDbl(Txt_Codigo.text)
    ElseIf Opt_RutEntre.Value = True Then
          SRutEntre = CDbl(Txt_RutDesde.Text)
          SRutHasta = CDbl(Txt_RutHasta.Text)
  '        SCodigoEntre = CDbl(Val(Txt_CodigoEntre.text))
  '        SCodigoHasta = CDbl(Val(Txt_CodigoHasta.text))
    Else
          SRutEntre = 1
          SRutHasta = 999999999
    '      SCodigoEntre = 0
     '     SCodigoHasta = 9999999
    End If
    
    If Opt_Codigo_Unico.Value = True Then
          SCodigoEntre = 0 ' CDbl(Txt_Codigo.Text)
          SCodigoHasta = 9999 ' CDbl(Txt_Codigo.Text)
    ElseIf Opt_Codigo_Entre.Value = True Then
          SCodigoEntre = 0 ' CDbl(Val(Txt_CodigoEntre.Text))
          SCodigoHasta = 9999 ' CDbl(Val(Txt_CodigoHasta.Text))
    Else
          SCodigoEntre = 0
          SCodigoHasta = 9999999
    End If
    
    If Opt_FechaCurse.Value = True Then
        
       If Opt_FechaUnica.Value = True Then
          SFecha_desde = Format(Txt_FechaEspe.Text, "yyyymmdd")
          SFecha_hasta = Format(Txt_FechaEspe.Text, "yyyymmdd")
       Else
           SFecha_desde = Format(Txt_FechaDesde.Text, "yyyymmdd")
           SFecha_hasta = Format(Txt_FechaHasta.Text, "yyyymmdd")
       End If
       
    ElseIf Opt_FechaVcto.Value = True Then
    
       If Opt_FechaUnica.Value = True Then
          SFecha_desde = Format(Txt_FechaEspe.Text, "yyyymmdd")
          SFecha_hasta = Format(Txt_FechaEspe.Text, "yyyymmdd")
       Else
          SFecha_desde = Format(Txt_FechaDesde.Text, "yyyymmdd")
          SFecha_hasta = Format(Txt_FechaHasta.Text, "yyyymmdd")
       End If
    ElseIf Opt_FechaVgca.Value = True Then
    
       If Opt_FechaUnica.Value = True Then
          SFecha_desde = Format(Txt_FechaEspe.Text, "yyyymmdd")
          SFecha_hasta = Format(Txt_FechaEspe.Text, "yyyymmdd")
       Else
          SFecha_desde = Format(Txt_FechaDesde.Text, "yyyymmdd")
          SFecha_hasta = Format(Txt_FechaHasta.Text, "yyyymmdd")
       End If
    
    Else
          SFecha_desde = Format("01/01/1900", "yyyymmdd")
          SFecha_hasta = Format(gsBac_Fecp, "yyyymmdd")
    End If
    
    If Opt_NumOpeDesde.Value = True Then
          SN_OpeDesde = Txt_NumOpDesde.Text
          SN_OpeHasta = Txt_NumOpeHasta.Text
    Else
          SN_OpeDesde = 1
          SN_OpeHasta = 9999999
    End If
    
    If Opt_ContratoDesde.Value = True Then
          SN_ConDesde = Txt_ContratoDesde.Text
          SN_ConHasta = Txt_ContratoHasta.Text
    Else
          SN_ConDesde = 0
          SN_ConHasta = 99999999
    End If
    
    If Opt_ValIniDesde.Value = True Then
          SValor_Inicial = CDbl(Txt_ValIniDesde.Text)
          SValor_Inicial2 = CDbl(Txt_ValIniHasta.Text)
    Else
          SValor_Inicial = 0
          SValor_Inicial2 = "99999999999999"
    End If
    
    If Opt_ValFinDesde.Value = True Then
          SValor_Final = CDbl(Txt_ValFinDesde.Text)
          SValor_Final2 = CDbl(Txt_ValFinHasta.Text)
    Else
          SValor_Final = 0
          SValor_Final2 = "99999999999999"
    End If
    
    If Opt_ConDCV.Value = True Then
            SSDCV = ""
            SCDCV = "S"
    ElseIf Opt_SinDCV.Value = True Then
            SSDCV = ""
            SCDCV = "N"
    ElseIf Opt_TodosDcv.Value = True Then
            SSDCV = ""
            SCDCV = ""
    End If
     
    If Opt_TasaEspecifica.Value = True Then
          sTasaEntre = Txt_TasaEspecifica.Text
          sTasaHasta = Txt_TasaEspecifica.Text
    ElseIf Opt_TasaDesde.Value = True Then
          sTasaEntre = Txt_TasaDesde.Text
          sTasaHasta = Txt_TasaHasta.Text
    Else
          sTasaEntre = -999.9999
          sTasaHasta = 9999.9999
    End If
    
    If Opt_InstruTodos.Value = True Then
        SCodigo_instru = 0
    End If
    
    STipo_Select = 1 '---> fusion
    
    
    If Sproducto = 0 And sMoneda = 0 And Stipo_cliente = 0 And SForma_pago = 0 And STipo_Cartera = "0" And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
        STipo_Select = 1
    ElseIf Sproducto = 0 And sMoneda <> 0 And Stipo_cliente = 0 And SForma_pago = 0 And STipo_Cartera = "0" And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 2
    ElseIf Sproducto = 0 And sMoneda = 0 And Stipo_cliente <> 0 And SForma_pago = 0 And STipo_Cartera = "0" And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 3
    ElseIf Sproducto = 0 And sMoneda = 0 And Stipo_cliente = 0 And SForma_pago = 0 And STipo_Cartera = "0" And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 4
    ElseIf Sproducto = 0 And sMoneda <> 0 And Stipo_cliente = 0 And SForma_pago = 0 And STipo_Cartera = "0" And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 5
    ElseIf Sproducto = 0 And sMoneda = 0 And Stipo_cliente <> 0 And SForma_pago = 0 And STipo_Cartera = "0" And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 6
    ElseIf Sproducto = 1 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 7
    ElseIf Sproducto = 1 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 8
    ElseIf Sproducto = 1 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 9
    ElseIf Sproducto = 1 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 10
    ElseIf Sproducto = 1 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 11
    ElseIf Sproducto = 1 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 12
    ElseIf Sproducto = 1 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 13
    ElseIf Sproducto = 1 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 14
    ElseIf Sproducto = 1 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 15
    ElseIf Sproducto = 1 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 16
    ElseIf Sproducto = 1 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 17
    ElseIf Sproducto = 1 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 18
    ElseIf Sproducto = 1 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 19
    ElseIf Sproducto = 1 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago = 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 20
    ElseIf Sproducto = 1 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 21
    ElseIf Sproducto = 1 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 22
    ElseIf Sproducto = 4 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 23
    ElseIf Sproducto = 4 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 24
    ElseIf Sproducto = 4 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 25
    ElseIf Sproducto = 4 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 26
    ElseIf Sproducto = 4 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 27
    ElseIf Sproducto = 4 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 28
    ElseIf Sproducto = 4 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 29
    ElseIf Sproducto = 4 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 30
    ElseIf Sproducto = 4 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 31
    ElseIf Sproducto = 4 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 32
    ElseIf Sproducto = 4 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 33
    ElseIf Sproducto = 4 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 34
    ElseIf Sproducto = 4 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 35
    ElseIf Sproducto = 4 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago = 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 36
    ElseIf Sproducto = 4 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 37
    ElseIf Sproducto = 4 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 38
     ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                 STipo_Select = 39
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 40
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 41
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 42
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 43
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago = 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 43
    ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 44
     ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 45
    ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 46
    ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 47
    ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 48
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 49
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 50
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 51
    ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago = 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 52
    ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 53
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente <> 0 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 54
    ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 55
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 56
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 57
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 58
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 59
    ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago = 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 60
    ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 61
    ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 62
    ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 63
    ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 64
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente = 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 65
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 66
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda <> 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 67
    ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda <> 0 And SForma_pago = 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 68
    ElseIf Sproducto <> 0 And STipo_Cartera = "0" And sMoneda = 0 And SForma_pago <> 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 69
    ElseIf Sproducto <> 0 And STipo_Cartera <> "0" And sMoneda = 0 And SForma_pago = 0 And Stipo_cliente <> 0 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 70
    End If
    If Sproducto = 8 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 71
    ElseIf Sproducto = 8 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 72
    ElseIf Sproducto = 9 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 73
    ElseIf Sproducto = 9 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 74
    ElseIf Sproducto = 10 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 75
    ElseIf Sproducto = 10 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 76
    ElseIf Sproducto = 11 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 81
    ElseIf Sproducto = 11 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 81
    ElseIf Sproducto = 12 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 77
    ElseIf Sproducto = 12 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 78
    ElseIf Sproducto = 6 And (Opt_FechaCurse.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 79
    ElseIf Sproducto = 6 And (Opt_FechaVcto.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 80
    
    ' VMGS *******  Variables para Fecha Vigencia
    
    ElseIf (Sproducto = 2 Or Sproducto = 3) And (Opt_FechaVgca.Value = True Or Opt_NoAplica.Value = True) Then ' Operaciones Renta Fija
                STipo_Select = 82
    ElseIf Sproducto = 6 And (Opt_FechaVgca.Value = True Or Opt_NoAplica.Value = True) Then ' Operaciones Forward
                STipo_Select = 83
    ElseIf Sproducto = 0 And (Opt_FechaVgca.Value = True Or Opt_NoAplica.Value = True) Then ' Todas las operaciones Operaciones
                STipo_Select = 84
    ElseIf Sproducto = 7 And (Opt_FechaVgca.Value = True Or Opt_NoAplica.Value = True) Then ' Operaciones Forward 1446
                STipo_Select = 85
    ElseIf Sproducto = 8 And (Opt_FechaVgca.Value = True Or Opt_NoAplica.Value = True) Then ' Depositos a Plazo Materiales con Custoria
                STipo_Select = 86
    ElseIf Sproducto = 9 And (Opt_FechaVgca.Value = True Or Opt_NoAplica.Value = True) Then ' Depositos a Plazo Materiales con Custoria
                STipo_Select = 87
    ElseIf Sproducto = 10 And (Opt_FechaVgca.Value = True Or Opt_NoAplica.Value = True) Then ' Todos los Dep. a Plazos materiales
                STipo_Select = 88
    ElseIf Sproducto = 11 And (Opt_FechaVgca.Value = True Or Opt_NoAplica.Value = True) Then ' Dep. a plazo Desmaterializados
                STipo_Select = 89
    ElseIf Sproducto = 12 And (Opt_FechaVgca.Value = True Or Opt_NoAplica.Value = True) Then
                STipo_Select = 90
    End If

End Sub

Sub Limpiar()

    Let CmbProducto.ListIndex = 0:          Let CmbFormadePago.ListIndex = 0
    Let CmbTipodeCartera.ListIndex = 0:     Let CmbFormadePagoFi.ListIndex = 0
    Let CmbMoneda.ListIndex = 0:            Let CmbTipoCliente.ListIndex = 0
    Let Txt_Rut.Text = "":                  Let Txt_Digito.Text = ""
    Let Txt_Nombre.Text = "":               Let Frame_SubCliente.Enabled = False
    Let Opt_Codigo_Unico.Enabled = False:   Let Txt_Codigo.Enabled = False
    Let Opt_Codigo_Entre.Enabled = False:   Let Txt_CodigoEntre.Text = ""
    Let Txt_CodigoHasta.Text = "":          Let Txt_Codigo.Text = ""
    Let Txt_CodigoEntre.Enabled = False:    Let Txt_CodigoHasta.Enabled = False
    Let Lbl_entre.Enabled = False:          Let Opt_Codigo_Todos.Enabled = False
    Let Opt_FechaCurse.Value = True:        Let Opt_InstruTodos.Value = True
    Let Txt_FechaEspe.Text = gsBac_Fecp:    Let Txt_FechaDesde.Text = gsBac_Fecp
    Let Txt_FechaHasta.Text = gsBac_Fecp:   Let Opt_RutTodos.Value = True
    Let Opt_ValIniTodos.Value = True:       Let Opt_ValFinTodos.Value = True
    Let Opt_NumOpeTodos.Value = True:       Let Opt_ContratoTodos.Value = True
    Let Opt_TasaTodos.Value = True:         Let Txt_TasaEspecifica.Text = 0#
    Let Txt_TasaDesde.Text = 0#:            Let Txt_TasaHasta.Text = 0#
    Let Opt_RutTodos.Value = True
    
End Sub
