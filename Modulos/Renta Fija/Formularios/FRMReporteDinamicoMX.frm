VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRMReporteDinamicoMX 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Filtros Reporte Dinámico Moneda Extranjera"
   ClientHeight    =   7080
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   11595
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7080
   ScaleWidth      =   11595
   Begin VB.Frame Frame2 
      Height          =   5850
      Left            =   5715
      TabIndex        =   68
      Top             =   1200
      Width           =   5835
      Begin Threed.SSFrame SSFrame8 
         Height          =   885
         Left            =   105
         TabIndex        =   69
         Top             =   600
         Width           =   5610
         _Version        =   65536
         _ExtentX        =   9895
         _ExtentY        =   1561
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
         Begin VB.OptionButton Opt_Especifica1 
            Caption         =   "Especifica"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   195
            Left            =   135
            TabIndex        =   29
            Top             =   225
            Width           =   1455
         End
         Begin VB.OptionButton Opt_Rango 
            Caption         =   "Rango Desde"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   195
            Left            =   135
            TabIndex        =   31
            Top             =   555
            Width           =   1545
         End
         Begin BACControles.TXTFecha TxtFechaEspecifica 
            Height          =   285
            Left            =   1755
            TabIndex        =   30
            Top             =   195
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   503
            Enabled         =   -1  'True
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
            ForeColor       =   -2147483646
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "09/10/2001"
         End
         Begin BACControles.TXTFecha TxtFechaHasta 
            Height          =   285
            Left            =   3855
            TabIndex        =   33
            Top             =   510
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   503
            Enabled         =   -1  'True
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
            ForeColor       =   -2147483646
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "09/10/2001"
         End
         Begin BACControles.TXTFecha TxtFechaRango 
            Height          =   285
            Left            =   1755
            TabIndex        =   32
            Top             =   510
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   503
            Enabled         =   -1  'True
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
            ForeColor       =   -2147483646
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "09/10/2001"
         End
         Begin VB.Label label 
            Caption         =   "Hasta"
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
            Height          =   285
            Index           =   18
            Left            =   3270
            TabIndex        =   70
            Top             =   540
            Width           =   570
         End
      End
      Begin Threed.SSFrame SSFrame_Compensacion 
         Height          =   720
         Left            =   105
         TabIndex        =   71
         Top             =   2130
         Width           =   5610
         _Version        =   65536
         _ExtentX        =   9895
         _ExtentY        =   1270
         _StockProps     =   14
         Caption         =   "Tipo de Compensación"
         ForeColor       =   128
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.OptionButton Opt_Afavor 
            Caption         =   "A favor"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   280
            Left            =   720
            TabIndex        =   38
            Top             =   330
            Width           =   1125
         End
         Begin VB.OptionButton Opt_Encontra 
            Caption         =   "En Contra"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   280
            Left            =   2235
            TabIndex        =   39
            Top             =   330
            Width           =   1170
         End
         Begin VB.OptionButton Opt_todos 
            Caption         =   "Todos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   280
            Left            =   3855
            TabIndex        =   40
            Top             =   315
            Value           =   -1  'True
            Width           =   1125
         End
      End
      Begin Threed.SSFrame SSFrame6 
         Height          =   480
         Left            =   105
         TabIndex        =   72
         Top             =   120
         Width           =   5640
         _Version        =   65536
         _ExtentX        =   9948
         _ExtentY        =   847
         _StockProps     =   14
         Caption         =   "Fecha"
         ForeColor       =   128
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.OptionButton Opt_Vigencia 
            Caption         =   "Fecha Vigencia"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   195
            Left            =   3060
            TabIndex        =   27
            Top             =   210
            Width           =   1650
         End
         Begin VB.OptionButton Opt_FechaVcto 
            Caption         =   "Fecha Vcto"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   195
            Left            =   1620
            TabIndex        =   26
            Top             =   225
            Width           =   1350
         End
         Begin VB.OptionButton Opt_Fecha 
            Caption         =   "Fecha Curse"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   195
            Left            =   150
            TabIndex        =   25
            Top             =   225
            Width           =   1530
         End
         Begin VB.OptionButton Opt_sfiltro 
            Caption         =   "N/A"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   195
            Left            =   4890
            TabIndex        =   28
            Top             =   210
            Width           =   675
         End
      End
      Begin Threed.SSFrame SSFrame7 
         Height          =   630
         Left            =   90
         TabIndex        =   73
         Top             =   1500
         Width           =   5595
         _Version        =   65536
         _ExtentX        =   9869
         _ExtentY        =   1111
         _StockProps     =   14
         Caption         =   "Número de Operación"
         ForeColor       =   128
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.TextBox txtN_OpeHasta 
            Alignment       =   1  'Right Justify
            Enabled         =   0   'False
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
            Height          =   285
            Left            =   3360
            MaxLength       =   6
            MouseIcon       =   "FRMReporteDinamicoMX.frx":0000
            MultiLine       =   -1  'True
            TabIndex        =   36
            Top             =   240
            Width           =   1125
         End
         Begin VB.TextBox txtN_OpeDesde 
            Alignment       =   1  'Right Justify
            Enabled         =   0   'False
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
            Height          =   285
            Left            =   1350
            MaxLength       =   6
            MouseIcon       =   "FRMReporteDinamicoMX.frx":030A
            MultiLine       =   -1  'True
            TabIndex        =   35
            Top             =   240
            Width           =   1125
         End
         Begin VB.OptionButton Opt_Todos2 
            Caption         =   "Todos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   195
            Left            =   4650
            TabIndex        =   37
            Top             =   300
            Value           =   -1  'True
            Width           =   915
         End
         Begin VB.OptionButton Opt_Desde1 
            Caption         =   "Desde"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   195
            Left            =   345
            TabIndex        =   34
            Top             =   300
            Width           =   915
         End
         Begin VB.Label label 
            Caption         =   "Hasta"
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
            Height          =   165
            Index           =   10
            Left            =   2670
            TabIndex        =   74
            Top             =   270
            Width           =   570
         End
      End
      Begin Threed.SSFrame SSFrame4 
         Height          =   1470
         Left            =   75
         TabIndex        =   75
         Top             =   2835
         Width           =   5655
         _Version        =   65536
         _ExtentX        =   9975
         _ExtentY        =   2593
         _StockProps     =   14
         Caption         =   "Moneda Transada"
         ForeColor       =   128
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.OptionButton Opt_Desde2 
            Caption         =   "Desde"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   195
            Left            =   150
            TabIndex        =   42
            Top             =   735
            Width           =   885
         End
         Begin VB.OptionButton Opt_Todos3 
            Caption         =   "Todos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   195
            Left            =   4650
            TabIndex        =   44
            Top             =   705
            Value           =   -1  'True
            Width           =   855
         End
         Begin VB.ComboBox CmbMonedaInicial 
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
            Left            =   1080
            Style           =   2  'Dropdown List
            TabIndex        =   41
            Top             =   345
            Width           =   3420
         End
         Begin BACControles.TXTNumero TxtValor_Inicial 
            Height          =   285
            Left            =   1080
            TabIndex        =   43
            Top             =   705
            Width           =   2745
            _ExtentX        =   4842
            _ExtentY        =   503
            ForeColor       =   -2147483646
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
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
            Max             =   "999999999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero txtValor_Final 
            Height          =   285
            Left            =   1080
            TabIndex        =   45
            Top             =   1065
            Width           =   2745
            _ExtentX        =   4842
            _ExtentY        =   503
            ForeColor       =   -2147483646
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
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
            Max             =   "999999999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label label 
            Caption         =   "Hasta"
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
            Left            =   435
            TabIndex        =   77
            Top             =   1110
            Width           =   510
         End
         Begin VB.Label label 
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
            Index           =   11
            Left            =   180
            TabIndex        =   76
            Top             =   405
            Width           =   690
         End
      End
      Begin Threed.SSFrame SSFrame5 
         Height          =   1410
         Left            =   75
         TabIndex        =   78
         Top             =   4290
         Width           =   5655
         _Version        =   65536
         _ExtentX        =   9975
         _ExtentY        =   2487
         _StockProps     =   14
         Caption         =   "Moneda Contravalor"
         ForeColor       =   128
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.ComboBox CmbMonedaFinal 
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
            Left            =   1080
            Style           =   2  'Dropdown List
            TabIndex        =   46
            Top             =   315
            Width           =   3420
         End
         Begin VB.OptionButton Opt_Todos6 
            Caption         =   "Todos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   280
            Left            =   4650
            TabIndex        =   50
            Top             =   660
            Value           =   -1  'True
            Width           =   855
         End
         Begin VB.OptionButton Opt_Desde4 
            Caption         =   "Desde"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   280
            Left            =   150
            TabIndex        =   47
            Top             =   675
            Width           =   885
         End
         Begin BACControles.TXTNumero TxtValor_Inicial2 
            Height          =   285
            Left            =   1080
            TabIndex        =   48
            Top             =   675
            Width           =   2745
            _ExtentX        =   4842
            _ExtentY        =   503
            ForeColor       =   -2147483646
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
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
            Max             =   "99999999999999"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero txtValor_Final2 
            Height          =   285
            Left            =   1080
            TabIndex        =   49
            Top             =   1035
            Width           =   2745
            _ExtentX        =   4842
            _ExtentY        =   503
            ForeColor       =   -2147483646
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
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
            Max             =   "99999999999999"
            Separator       =   -1  'True
         End
         Begin VB.Label label 
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
            Index           =   17
            Left            =   180
            TabIndex        =   80
            Top             =   375
            Width           =   720
         End
         Begin VB.Label label 
            Caption         =   "Hasta"
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
            Height          =   285
            Index           =   16
            Left            =   435
            TabIndex        =   79
            Top             =   1080
            Width           =   570
         End
      End
   End
   Begin VB.Frame Frame1 
      Height          =   5880
      Left            =   45
      TabIndex        =   51
      Top             =   1185
      Width           =   5655
      Begin Threed.SSFrame SSFrame1 
         Height          =   1890
         Left            =   90
         TabIndex        =   52
         Top             =   120
         Width           =   5505
         _Version        =   65536
         _ExtentX        =   9710
         _ExtentY        =   3334
         _StockProps     =   14
         Caption         =   "Datos Generales"
         ForeColor       =   128
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
            ItemData        =   "FRMReporteDinamicoMX.frx":0614
            Left            =   2340
            List            =   "FRMReporteDinamicoMX.frx":0616
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   195
            Width           =   3015
         End
         Begin VB.ComboBox CmbModalidad 
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
            ItemData        =   "FRMReporteDinamicoMX.frx":0618
            Left            =   2340
            List            =   "FRMReporteDinamicoMX.frx":061A
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   510
            Width           =   3015
         End
         Begin VB.ComboBox CmbFormadePagoMN 
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
            Left            =   2340
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   840
            Width           =   3015
         End
         Begin VB.ComboBox CmbFormadePagoMX 
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
            Left            =   2340
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   1155
            Width           =   3015
         End
         Begin VB.ComboBox CmbTipoCartera 
            Enabled         =   0   'False
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
            Left            =   2340
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   1470
            Width           =   3015
         End
         Begin VB.Label label 
            Caption         =   "Producto"
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
            Index           =   0
            Left            =   330
            TabIndex        =   57
            Top             =   270
            Width           =   1770
         End
         Begin VB.Label label 
            Caption         =   "Modalidad de Pago"
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
            Index           =   1
            Left            =   330
            TabIndex        =   56
            Top             =   540
            Width           =   1770
         End
         Begin VB.Label label 
            Caption         =   "Forma de Pago M/N"
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
            Index           =   3
            Left            =   330
            TabIndex        =   55
            Top             =   870
            Width           =   1770
         End
         Begin VB.Label label 
            Caption         =   "Forma de Pago M/X"
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
            Index           =   4
            Left            =   330
            TabIndex        =   54
            Top             =   1170
            Width           =   1770
         End
         Begin VB.Label label 
            Caption         =   "Tipo de Cartera"
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
            Index           =   2
            Left            =   330
            TabIndex        =   53
            Top             =   1500
            Width           =   1770
         End
      End
      Begin Threed.SSFrame PanelCV 
         Height          =   555
         Left            =   90
         TabIndex        =   58
         Top             =   1980
         Width           =   5505
         _Version        =   65536
         _ExtentX        =   9710
         _ExtentY        =   979
         _StockProps     =   14
         Caption         =   "Tipo de Operación"
         ForeColor       =   128
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.OptionButton Opt_Compra 
            Caption         =   "Compra"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   280
            Left            =   720
            TabIndex        =   7
            Top             =   240
            Width           =   1125
         End
         Begin VB.OptionButton Opt_Venta 
            Caption         =   "Venta"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   280
            Left            =   2220
            TabIndex        =   8
            Top             =   240
            Width           =   1125
         End
         Begin VB.OptionButton Opt_Ambas 
            Caption         =   "Ambas"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   280
            Left            =   3840
            TabIndex        =   9
            Top             =   240
            Value           =   -1  'True
            Width           =   1125
         End
      End
      Begin Threed.SSFrame SSFrame3 
         Height          =   3345
         Left            =   75
         TabIndex        =   59
         Top             =   2490
         Width           =   5505
         _Version        =   65536
         _ExtentX        =   9710
         _ExtentY        =   5900
         _StockProps     =   14
         Caption         =   "Cliente"
         ForeColor       =   128
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.ComboBox CmbSectorEconomico 
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
            Left            =   1920
            Style           =   2  'Dropdown List
            TabIndex        =   11
            Top             =   480
            Width           =   3405
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
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1920
            Style           =   2  'Dropdown List
            TabIndex        =   10
            Top             =   165
            Width           =   3405
         End
         Begin VB.OptionButton Opt_NRut 
            Caption         =   "Rut"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   280
            Left            =   105
            TabIndex        =   63
            Top             =   1185
            Width           =   660
         End
         Begin VB.OptionButton Opt_EntreRut 
            Caption         =   "Rut entre el"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   195
            Left            =   210
            TabIndex        =   21
            Top             =   2805
            Width           =   1455
         End
         Begin VB.OptionButton Opt_Todos1 
            Caption         =   "Todos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   280
            Left            =   225
            TabIndex        =   22
            Top             =   3015
            Value           =   -1  'True
            Width           =   1455
         End
         Begin VB.TextBox txtRut 
            Alignment       =   1  'Right Justify
            Enabled         =   0   'False
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
            Height          =   285
            Left            =   780
            MaxLength       =   9
            MouseIcon       =   "FRMReporteDinamicoMX.frx":061C
            MousePointer    =   99  'Custom
            MultiLine       =   -1  'True
            TabIndex        =   13
            Top             =   1170
            Width           =   1125
         End
         Begin VB.TextBox txtDigito 
            Enabled         =   0   'False
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
            Height          =   285
            Left            =   1935
            MaxLength       =   1
            TabIndex        =   62
            Top             =   1170
            Width           =   315
         End
         Begin VB.TextBox TxtNombre 
            Enabled         =   0   'False
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
            Height          =   285
            Left            =   780
            MaxLength       =   40
            TabIndex        =   14
            TabStop         =   0   'False
            Top             =   1455
            Width           =   4635
         End
         Begin VB.Frame Frame_SubCliente 
            Caption         =   "SubCliente"
            Enabled         =   0   'False
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
            Height          =   1065
            Left            =   60
            TabIndex        =   60
            Top             =   1710
            Width           =   5355
            Begin VB.TextBox Txt_CodigoEntre 
               Enabled         =   0   'False
               Height          =   285
               Left            =   1530
               TabIndex        =   19
               Top             =   495
               Width           =   1215
            End
            Begin VB.TextBox Txt_CodigoHasta 
               Enabled         =   0   'False
               Height          =   285
               Left            =   3660
               TabIndex        =   20
               Top             =   480
               Width           =   1230
            End
            Begin VB.OptionButton Opt_Codigo_Todos 
               Caption         =   "Todos"
               Enabled         =   0   'False
               ForeColor       =   &H00800000&
               Height          =   300
               Left            =   225
               TabIndex        =   17
               Top             =   735
               Value           =   -1  'True
               Width           =   840
            End
            Begin VB.TextBox TxtCodigo 
               Enabled         =   0   'False
               Height          =   300
               Left            =   1545
               MousePointer    =   99  'Custom
               TabIndex        =   18
               Top             =   180
               Width           =   1230
            End
            Begin VB.OptionButton Opt_Codigo_Entre 
               Caption         =   "Codigo entre"
               Enabled         =   0   'False
               ForeColor       =   &H00800000&
               Height          =   300
               Left            =   225
               TabIndex        =   16
               Top             =   495
               Width           =   1200
            End
            Begin VB.OptionButton Opt_Codigo_Unico 
               Caption         =   "Codigo"
               Enabled         =   0   'False
               ForeColor       =   &H00800000&
               Height          =   300
               Left            =   225
               TabIndex        =   15
               Top             =   210
               Width           =   1080
            End
            Begin VB.Label Lbl_entre 
               AutoSize        =   -1  'True
               Caption         =   "y el"
               Enabled         =   0   'False
               ForeColor       =   &H00800000&
               Height          =   195
               Left            =   2985
               TabIndex        =   61
               Top             =   495
               Width           =   240
            End
         End
         Begin VB.TextBox CmbRutEntre 
            Enabled         =   0   'False
            Height          =   285
            Left            =   1695
            TabIndex        =   23
            Top             =   2820
            Width           =   1530
         End
         Begin VB.TextBox CmbRutHasta 
            Enabled         =   0   'False
            Height          =   285
            Left            =   3810
            TabIndex        =   24
            Top             =   2805
            Width           =   1515
         End
         Begin VB.ComboBox CmbMercado 
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
            Left            =   1920
            Style           =   2  'Dropdown List
            TabIndex        =   12
            Top             =   780
            Width           =   3405
         End
         Begin VB.Label label 
            Caption         =   "Sector Económico"
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
            Index           =   12
            Left            =   90
            TabIndex        =   67
            Top             =   525
            Width           =   1770
         End
         Begin VB.Label label 
            Caption         =   "Tipo de Cliente"
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
            Index           =   13
            Left            =   75
            TabIndex        =   66
            Top             =   240
            Width           =   1770
         End
         Begin VB.Label label 
            AutoSize        =   -1  'True
            Caption         =   "y el"
            Enabled         =   0   'False
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
            Index           =   7
            Left            =   3360
            TabIndex        =   65
            Top             =   2835
            Width           =   315
         End
         Begin VB.Label label 
            Caption         =   "Tipo Mercado"
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
            Index           =   5
            Left            =   75
            TabIndex        =   64
            Top             =   795
            Width           =   1770
         End
      End
   End
   Begin Threed.SSFrame SSFrm_Sistema 
      Height          =   720
      Left            =   15
      TabIndex        =   0
      Top             =   480
      Width           =   11520
      _Version        =   65536
      _ExtentX        =   20320
      _ExtentY        =   1270
      _StockProps     =   14
      Caption         =   "Sistemas"
      ForeColor       =   128
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ComboBox CmbSistemas 
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
         Left            =   3960
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   270
         Width           =   2895
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5205
      Top             =   0
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
            Picture         =   "FRMReporteDinamicoMX.frx":0926
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRMReporteDinamicoMX.frx":0C46
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRMReporteDinamicoMX.frx":1098
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRMReporteDinamicoMX.frx":13B2
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRMReporteDinamicoMX.frx":16D2
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRMReporteDinamicoMX.frx":3EAC
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRMReporteDinamicoMX.frx":42FE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   81
      Top             =   0
      Width           =   11595
      _ExtentX        =   20452
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Pantalla"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Excel"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Volver"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "FRMReporteDinamicoMX"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Datos()
Dim Sql As String
Dim Valida_Combo As Boolean
Dim Datos_Necesario As Boolean
Dim Digito  As String
Dim Sproducto As String
Dim Smodalida As String
Dim sSistema As String
Dim Sforma_pago_mn As String
Dim Sforma_pago_mx As String
Dim SCompra As String
Dim SVenta As String
Dim Stipo_cliente As String
Dim Ssector_economico As String
Dim SMoneda_Inicial As String
Dim SMoneda_Final  As String
Dim SRut As String
Dim SCodigoEntre As String
Dim SCodigoHasta As String
Dim SRutEntre As String
Dim SRutHasta As String
Dim SFecha_desde As String
Dim SFecha_hasta As String
Dim SN_OpeDesde As String
Dim SN_OpeHasta As String
Dim SValor_Inicial As String
Dim SValor_Final As String
Dim SValor_Inicial2 As String
Dim SValor_Final2 As String
Dim STipo_Fecha As String
Dim STipo_Select As Integer
Dim STipo_Cliente_Desde As Integer
Dim STipo_Cliente_Hasta As Integer
Dim SSector_Economico_Desde As Integer
Dim SSector_Economico_Hasta As Integer
Dim STipo_Cartera As String
Dim SMercado As Integer

Dim sAfavor As Double
Dim sEncontra As Double
Dim oconeccionexcel As Object
Dim SW_NORMAL As Integer
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" _
                   (ByVal hWnd As Long, ByVal lpszOp As String, _
                    ByVal lpszFile As String, ByVal lpszParams As String, _
                    ByVal LpszDir As String, ByVal FsShowCmd As Long) _
                    As Long

Private Sub CmbProducto_Change()
Call CmbProducto_LostFocus
End Sub

Private Sub CmbProducto_Click()
    Call CmbProducto_LostFocus
End Sub

Private Sub CmbProducto_LostFocus()

Envia = Array()
AddParam Envia, Trim(Right$(CmbSistemas.Text, 3))
AddParam Envia, Trim(Right$(CmbProducto.Text, 7))

If Trim(Right$(CmbProducto.Text, 7)) = "OVER" Then
   Opt_Compra.Enabled = False
   Opt_Venta.Enabled = False
   Opt_Ambas.Value = True
   Opt_Ambas.Enabled = False
Else
   Opt_Compra.Enabled = True
   Opt_Venta.Enabled = True
   Opt_Ambas.Value = True
   Opt_Ambas.Enabled = True
End If

If Trim(Right$(CmbProducto.Text, 7)) = "0" Then ' Todos
    CmbMonedaInicial.Clear
    CmbMonedaInicial.AddItem ("<< TODOS >>" & Space(100) & Trim(0))

    CmbMonedaFinal.Clear
    CmbMonedaFinal.AddItem ("<< TODOS >>" & Space(100) & Trim(0))

   If Trim(Right$(CmbSistemas.Text, 3)) = "BCC" Then
      Envia = Array()
      AddParam Envia, "BCC"
      AddParam Envia, "PTAS"

      If Not Bac_Sql_Execute("Sp_Marca_X", Envia) Then
         Exit Sub
      Else
         Do While Bac_SQL_Fetch(Datos())
            CmbMonedaInicial.AddItem Trim(Datos(5)) & Space(100) & Trim(Datos(2))
            CmbMonedaFinal.AddItem Trim(Datos(5)) & Space(100) & Trim(Datos(2))
         Loop

      End If
   End If
   CmbMonedaInicial.ListIndex = 0
   CmbMonedaFinal.ListIndex = 0

Else
    
    If Not Bac_Sql_Execute("Sp_Marca_X", Envia) Then
        Exit Sub
    Else
         If Trim(Right$(CmbProducto.Text, 7)) = "1" Or _
            Trim(Right$(CmbProducto.Text, 7)) = "5" Then ' SegCmb , 1446
           
            CmbMonedaInicial.Clear
            CmbMonedaInicial.AddItem "DOLAR AMERICANO" & Space(100) & "13"
         
'         CmbMonedaFinal.Clear
         CmbMonedaFinal.AddItem ("<< TODOS >>" & Space(100) & Trim(0))
         Do While Bac_SQL_Fetch(Datos())
            CmbMonedaFinal.AddItem Trim(Datos(5)) & Space(100) & Trim(Datos(2))
         Loop
         CmbMonedaInicial.ListIndex = 0
         CmbMonedaFinal.ListIndex = 0
      End If
    
      If Trim(Right$(CmbProducto.Text, 7)) = "CANJ" Or _
         Trim(Right$(CmbProducto.Text, 7)) = "1446" Or _
         Trim(Right$(CmbProducto.Text, 7)) = "AJUS" Or _
         Trim(Right$(CmbProducto.Text, 7)) = "FUTU" Or _
         Trim(Right$(CmbProducto.Text, 7)) = "INFO" Then 'Canje
         
            
         CmbMonedaFinal.Clear
         CmbMonedaFinal.AddItem "PESOS" & Space(100) & "999"
            
         CmbMonedaInicial.Clear
         CmbMonedaInicial.AddItem "DOLAR AMERICANO" & Space(100) & "13"
                        
         CmbMonedaInicial.ListIndex = 0
         CmbMonedaFinal.ListIndex = 0
      End If
      
      If Trim(Right$(CmbProducto.Text, 7)) = "PTAS" Or _
         Trim(Right$(CmbProducto.Text, 7)) = "EMPR" Then 'Ptas, Empr
         
            
         CmbMonedaFinal.Clear
         CmbMonedaFinal.AddItem "<< TODOS >>" & Space(100) & "0"
         CmbMonedaFinal.AddItem "PESOS" & Space(100) & "999"
         CmbMonedaFinal.AddItem "DOLAR AMERICANO" & Space(100) & "13"
         
         CmbMonedaInicial.Clear
         CmbMonedaInicial.AddItem ("<< TODOS >>" & Space(100) & Trim(0))
         Do While Bac_SQL_Fetch(Datos())
            CmbMonedaInicial.AddItem Trim(Datos(5)) & Space(100) & Trim(Datos(2))
         Loop
            
         CmbMonedaInicial.ListIndex = 0
         CmbMonedaFinal.ListIndex = 0
      End If
        
        
      If Trim(Right$(CmbProducto.Text, 7)) = "OVER" Or _
         Trim(Right$(CmbProducto.Text, 7)) = "TRAN" Then
         
         CmbMonedaInicial.Clear
         CmbMonedaInicial.AddItem "DOLAR AMERICANO" & Space(100) & "13"
         
         CmbMonedaFinal.Clear
         CmbMonedaFinal.AddItem "DOLAR AMERICANO" & Space(100) & "13"
            
         CmbMonedaInicial.ListIndex = 0
         CmbMonedaFinal.ListIndex = 0

      End If

      If Trim(Right$(CmbProducto.Text, 7)) = "VB2" Or _
         Trim(Right$(CmbProducto.Text, 7)) = "CUPO" Or _
         Trim(Right$(CmbProducto.Text, 7)) = "ARRI" Then
            
         CmbMonedaFinal.Clear
         CmbMonedaInicial.Clear
         CmbMonedaFinal.AddItem ("<< TODOS >>" & Space(100) & Trim(0))
         CmbMonedaInicial.AddItem "DOLAR AMERICANO" & Space(100) & "13"

         CmbMonedaInicial.ListIndex = 0
         CmbMonedaFinal.ListIndex = 0
      End If
        
      If Trim(Right$(CmbProducto.Text, 7)) = "2" Or _
         Trim(Right$(CmbProducto.Text, 7)) = "ARBI" Then  ' ArbFut, ArbSpt
            
         CmbMonedaFinal.Clear
         CmbMonedaFinal.AddItem "DOLAR AMERICANO" & Space(100) & "13"
         CmbMonedaInicial.Clear
         CmbMonedaInicial.AddItem ("<< TODOS >>" & Space(100) & Trim(0))
         CmbMonedaFinal.AddItem ("<< TODOS >>" & Space(100) & Trim(0))

         Do While Bac_SQL_Fetch(Datos())
            CmbMonedaInicial.AddItem Trim(Datos(5)) & Space(100) & Trim(Datos(2))
            CmbMonedaFinal.AddItem Trim(Datos(5)) & Space(100) & Trim(Datos(2))
         Loop
         CmbMonedaInicial.ListIndex = 0
         CmbMonedaFinal.ListIndex = 0
      End If
        
      If Trim(Right$(CmbProducto.Text, 7)) = "3" Then  ' SegInf
         CmbMonedaInicial.Clear
         CmbMonedaInicial.AddItem "UNIDAD FOMENTO" & Space(100) & "998"
         CmbMonedaFinal.Clear
         Do While Bac_SQL_Fetch(Datos())
            CmbMonedaFinal.AddItem Trim(Datos(5)) & Space(100) & Trim(Datos(2))
         Loop

         CmbMonedaInicial.ListIndex = 0
         CmbMonedaFinal.ListIndex = 0
      End If
   End If
End If
End Sub

Private Sub Form_Activate()
    Opt_Todos1.Value = True
    Opt_Especifica1.Value = True
End Sub

Private Sub Form_Load()
Me.Top = 0
Me.Left = 0
'FRMReporteDinamicoMX.Height = 1560
'FRMReporteDinamicoMX.Width = 11700

Opt_Fecha.Value = True
Opt_Todos1.Value = True
Opt_Todos2.Value = True
Opt_Todos3.Value = True
Opt_Todos6.Value = True

Toolbar1.Buttons(2).Enabled = False
Toolbar1.Buttons(3).Enabled = False
Toolbar1.Buttons(4).Enabled = False
Toolbar1.Buttons(5).Enabled = False
Toolbar1.Buttons(6).Enabled = False

TxtFechaEspecifica.Text = gsBac_Fecp
TxtFechaRango.Text = gsBac_Fecp
TxtFechaHasta.Text = gsBac_Fecp
    
'Carga combo Sistema
CmbSistemas.AddItem ("FORWARD " & Space(100) & Trim("BFW"))
CmbSistemas.AddItem ("SPOT" & Space(100) & Trim("BCC"))
CmbSistemas.AddItem ("SWAP" & Space(100) & Trim("PCS"))
CmbSistemas.ListIndex = 0

End Sub

Sub PROC_CARGA_COMBOS(sistema As String)
On Error GoTo ErrCarga
        
FRMReporteDinamicoMX.Height = 7410
FRMReporteDinamicoMX.Width = 11700
SSFrm_Sistema.Enabled = False
Toolbar1.Buttons(1).Enabled = False
Toolbar1.Buttons(2).Enabled = True
Toolbar1.Buttons(3).Enabled = True
Toolbar1.Buttons(4).Enabled = True
Toolbar1.Buttons(5).Enabled = True
Toolbar1.Buttons(6).Enabled = True


If sistema = "BFW" Or sistema = "PCS" Then
   CmbModalidad.Clear
   CmbModalidad.Enabled = True
   CmbModalidad.AddItem ("<< TODOS >>" & Space(100) & Trim(0))
   CmbModalidad.AddItem ("COMPENSACIÓN" & Space(100) & Trim("C"))
   CmbModalidad.AddItem ("ENTREGA FÍSICA" & Space(100) & Trim("E"))
   CmbModalidad.ListIndex = 0
   Opt_FechaVcto.Enabled = True
   SSFrame_Compensacion.Enabled = True
   Opt_Afavor.Enabled = True
   Opt_Encontra.Enabled = True
   Opt_todos.Enabled = True
   Label(1).Enabled = True
   Label(2).Enabled = True

   Label(5).Enabled = True
   cmbMercado.Enabled = True
   cmbMercado.Clear
   cmbMercado.AddItem ("<< TODOS >>" & Space(100) & Trim(0))
   cmbMercado.AddItem ("Mercado Local" & Space(100) & Trim(1))
   cmbMercado.AddItem ("Mercado Externo" & Space(100) & Trim(2))

   If sistema = "BFW" Then
      Label(2).Enabled = True
      CmbTipoCartera.Enabled = True
      CmbTipoCartera.Clear
      CmbTipoCartera.AddItem ("<< TODOS >>" & Space(100) & Trim(0))

'LD1-COR-035
'''' corregido para traer cartera normativa --> cod 1111
    Call PROC_LLENA_COMBOS(CmbTipoCartera, 1111, True, GLB_ID_SISTEMA, "", "", "", gsBac_User)

     ' If Not Bac_Sql_Execute("BacFwdSuda.dbo.sp_mdrcleercodigo", Array(1)) Then
        ' Exit Sub
     ' Else
       '  Do While Bac_SQL_Fetch(DATOS())
          '  CmbTipoCartera.AddItem Trim(DATOS(2)) & Space(100) & Trim(DATOS(1))
        ' Loop
    '  End If
      CmbTipoCartera.ListIndex = 0
      Label(3).Caption = "Forma de Pago M/N"
      Label(4).Caption = "Forma de Pago M/X"
   Else
      CmbTipoCartera.Enabled = False
      Label(2).Enabled = False
      Label(3).Caption = "Forma de Pago Rec."
      Label(4).Caption = "Forma de Pago Pag."


   End If

   cmbMercado.ListIndex = 0
   Opt_FechaVcto.Enabled = True
   Opt_Vigencia.Enabled = True
   Opt_sfiltro.Enabled = True

ElseIf sistema = "BCC" Then
   CmbModalidad.Enabled = False
   CmbTipoCartera.Enabled = False
   Opt_FechaVcto.Enabled = True
   Opt_Vigencia.Enabled = False
   Opt_sfiltro.Enabled = True
   Opt_Ambas.Enabled = False
   SSFrame_Compensacion.Enabled = False
   Opt_Afavor.Enabled = False
   Opt_Encontra.Enabled = False
   Opt_todos.Enabled = False
   Label(1).Enabled = False
   Label(2).Enabled = False
   Label(5).Enabled = False
   cmbMercado.Enabled = False

End If
        
CmbSectorEconomico.Clear
CmbSectorEconomico.AddItem Trim("<< TODOS >>" & Space(100) & Trim(0))
        
CmbTipoCliente.Clear
CmbTipoCliente.AddItem ("<< TODOS >>" & Space(100) & Trim(0))
        
CmbProducto.Clear
CmbProducto.AddItem ("<< TODOS >>" & Space(50) & Trim(0))
        
CmbFormadePagoMX.Clear
CmbFormadePagoMX.AddItem ("<< TODOS >>" & Space(100) & Trim(0))
        

CmbFormadePagoMN.Clear
CmbFormadePagoMN.AddItem ("<< TODOS >>" & Space(100) & Trim(0))
    If sistema <> "0" Then
        If Not Bac_Sql_Execute("Sp_LeerProductos_forward ", Array(sistema)) Then
            Exit Sub
        Else
             Do While Bac_SQL_Fetch(Datos())
                 CmbProducto.AddItem Trim$(Datos(2)) & Space(50) & Datos(1)
             Loop
        End If
     End If
        If Not Bac_Sql_Execute("Sp_BUSCA_ACTIVIDAD_ECONOMICA ") Then
            Exit Sub
        Else
             Do While Bac_SQL_Fetch(Datos())
                 CmbSectorEconomico.AddItem Trim(Datos(2)) & Space(100) & Trim(Datos(1))
             Loop
        End If
        
        If Not Bac_Sql_Execute("Sp_BUSCA_TIPO_CLIENTE ") Then
            Exit Sub
        Else
             Do While Bac_SQL_Fetch(Datos())
                 CmbTipoCliente.AddItem Trim(Datos(2)) & Space(100) & Trim(Datos(1))
             Loop
        End If
        
        If Not Bac_Sql_Execute("Sp_BUSCA_TRAE_FORMA_DE_PAGO ") Then
            Exit Sub
        Else
             Do While Bac_SQL_Fetch(Datos())
                  If Datos(3) = "S" Then
                     CmbFormadePagoMX.AddItem Trim(Datos(2)) & Space(100) & Trim(Datos(1))
                  Else
                     CmbFormadePagoMN.AddItem Trim(Datos(2)) & Space(100) & Trim(Datos(1))
                  End If
            Loop
        End If

        
CmbProducto.ListIndex = 0
CmbSectorEconomico.ListIndex = 0
CmbTipoCliente.ListIndex = 0
CmbFormadePagoMX.ListIndex = 0
CmbFormadePagoMN.ListIndex = 0


Call CmbProducto_LostFocus
             
Exit Sub
        
ErrCarga:
         MsgBox "Se detectó problemas en carga de información: " & err.Description & ". Comunique al Administrador.", vbCritical, TITSISTEMA
End Sub



Private Sub Opt_Codigo_Entre_Click()
Txt_CodigoEntre.Enabled = True
Txt_CodigoHasta.Enabled = True
Lbl_entre.Enabled = True
TxtCodigo.Text = ""
TxtCodigo.Enabled = False
End Sub

Private Sub Opt_Codigo_Todos_Click()

TxtCodigo.Text = ""
Txt_CodigoEntre.Text = ""
Txt_CodigoHasta.Text = ""

TxtCodigo.Enabled = False
Txt_CodigoEntre.Enabled = False
Txt_CodigoHasta.Enabled = False
Lbl_entre.Enabled = False
End Sub

Private Sub Opt_Codigo_Unico_Click()
TxtCodigo.Enabled = True
Txt_CodigoEntre.Text = ""
Txt_CodigoHasta.Text = ""
Txt_CodigoEntre.Enabled = False
Txt_CodigoHasta.Enabled = False
Lbl_entre.Enabled = False

End Sub

Private Sub Opt_Fecha_Click()
Opt_Especifica1.Enabled = True
TxtFechaEspecifica.Enabled = True
Opt_Rango.Enabled = True
TxtFechaRango.Enabled = True
Label(18).Enabled = True
TxtFechaHasta.Enabled = True
End Sub

Private Sub Opt_FechaVcto_Click()
Opt_Especifica1.Enabled = True
TxtFechaEspecifica.Enabled = True
Opt_Rango.Enabled = True
TxtFechaRango.Enabled = True
Label(18).Enabled = True
TxtFechaHasta.Enabled = True
End Sub

Private Sub Opt_sfiltro_Click()
Opt_Especifica1.Enabled = False
TxtFechaEspecifica.Enabled = False
Opt_Rango.Enabled = False
TxtFechaRango.Enabled = False
Label(18).Enabled = False
TxtFechaHasta.Enabled = False
End Sub

Private Sub Opt_Vigencia_Click()
Opt_Especifica1.Enabled = True
TxtFechaEspecifica.Enabled = True
Opt_Rango.Enabled = False
TxtFechaRango.Enabled = False
Label(18).Enabled = False
TxtFechaHasta.Enabled = False
End Sub

Private Sub txtcodigo_DblClick()
   BacAyuda.Tag = "SUBCLIENTE"
   gscodigo = txtRut.Text
   BacControlWindows 100
   BacAyuda.Show 1
   If giAceptar = True Then
      TxtCodigo.Text = gsCodCli
      Call txtCodigo_LostFocus
   End If


End Sub

Private Sub TxtCodigo_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Screen.MousePointer = vbArrowQuestion
End Sub

Private Sub TxtFechaHasta_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   Opt_Todos2.SetFocus
End If
End Sub

Private Sub TxtFechaRango_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   TxtFechaHasta.SetFocus
End If
End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)
Call Valida_Combos

If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   txtDigito.Enabled = True
   txtDigito.SetFocus
ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
   KeyAscii = 0
End If

BacCaracterNumerico KeyAscii

End Sub

Private Sub Valida_Combos()
    Valida_Combo = False
    
    If CmbTipoCliente.ListIndex = -1 Then
       MsgBox "Debe Elegir Tipo de cliente", vbCritical, TITSISTEMA
       txtRut.Text = ""
       Valida_Combo = True
       CmbTipoCliente.SetFocus
       Exit Sub
    ElseIf CmbSectorEconomico.ListIndex = -1 Then
       MsgBox "Debe Elegir Sector Económico", vbCritical, TITSISTEMA
       txtRut.Text = ""
       Valida_Combo = True
       CmbSectorEconomico.SetFocus
       Exit Sub
    End If

End Sub

Private Sub txtrut_LostFocus()
    If Len(txtRut.Text) > 5 Then
       Digito = BacDevuelveDig(txtRut.Text)
       txtDigito.Enabled = True
    End If
End Sub

Private Sub txtDigito_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{TAB}"
Else
    If Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 75 Or KeyAscii = 107 Or KeyAscii = 8) Then
        KeyAscii = 0
End If
End If

BacToUCase KeyAscii
   
   
End Sub

Private Sub txtDigito_LostFocus()

If txtRut.Text <> "" Then
   If Digito <> txtDigito.Text Then
      MsgBox "Digito No corresponde al RUT.", vbOKOnly + vbExclamation, TITSISTEMA
      txtDigito.Text = ""
      txtDigito.SetFocus
   Else
      If TxtCodigo.Enabled = False Then Exit Sub
      TxtCodigo.Text = gsvalor$
        TxtCodigo.SetFocus
   End If
End If

End Sub

Private Sub txtcodigo_KeyPress(KeyAscii As Integer)

    If KeyAscii% = vbKeyReturn Then
       KeyAscii% = 0
       SendKeys "{TAB}"
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
       KeyAscii = 0
       BacCaracterNumerico KeyAscii
    End If

End Sub

Private Sub txtCodigo_LostFocus()
    Dim idRut     As Long
    Dim IdDig     As String
    Dim IdCod     As Long
    Dim i As Long
      
    If Val(txtRut.Text) = 0 Or Trim(txtDigito.Text) = "" Then Exit Sub
    
    
    idRut = txtRut.Text
    IdDig = txtDigito.Text
    IdCod = IIf(TxtCodigo.Text = "", 0, TxtCodigo.Text)
    Call Busca_Cliente(idRut, IdDig, IdCod)

End Sub

Function Busca_Cliente(nRut As Long, nDigito As String, nCodigo As Long) As Boolean
Dim Sql As String
Dim Datos()
Dim datosSTR As String
Dim nCont As Integer

Screen.MousePointer = 11
Busca_Cliente = False
   
Envia = Array()
AddParam Envia, CDbl(nRut)
AddParam Envia, nDigito
AddParam Envia, CDbl(nCodigo)
AddParam Envia, TraeValor(Trim(Right(CmbTipoCliente.Text, 5)))
AddParam Envia, TraeValor(Trim(Right(CmbSectorEconomico.Text, 5)))
          
If Not Bac_Sql_Execute("sp_Lee_Cliente_FWD ", Envia) Then
   MsgBox "Consulta en BacParametros Ha Fallado. Servidor SQL No Responde", vbCritical, TITSISTEMA
   Exit Function
End If

If Bac_SQL_Fetch(Datos()) Then
   txtRut.Text = Val(Datos(1))
   txtDigito.Text = Datos(2)
   TxtCodigo.Text = Val(Datos(3))
   TxtNombre.Text = Datos(4)
   txtRut.Enabled = False
   txtDigito.Enabled = False
   TxtCodigo.Enabled = True
   TxtNombre.Enabled = False
Else
   MsgBox "El Cliente Buscado no Existe", 16, TITSISTEMA
   txtRut.Text = ""
   txtDigito.Text = ""
   TxtCodigo.Text = ""
   TxtNombre.Text = ""
   txtRut.Enabled = True
   txtRut.SetFocus
End If
Screen.MousePointer = 0
End Function

Private Sub txtrut_DblClick()

    Call Valida_Combos
    
    If Valida_Combo = True Then Exit Sub
       
    Tipo_Cliente = TraeValor(Trim(Right(CmbTipoCliente.Text, 5)))
    Sector_Economico = TraeValor(Trim(Right(CmbSectorEconomico.Text, 5)))
    BacControlWindows 100
    BacAyuda.Tag = "FILTRO_CL"
    BacAyuda.Show 1
    
    If giAceptar = True Then
       txtRut.Text = gscodigo
       txtDigito.Text = gsDigito
       TxtCodigo.Text = gsCodCli
       TxtNombre.Text = gsnombre
       Opt_Codigo_Unico.Value = True
       
       Call txtCodigo_LostFocus
       TxtCodigo.Enabled = True
    End If

End Sub

Public Function BacDevuelveDig(Rut As String) As String

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Multi   As Double

   BacDevuelveDig = ""
    
   Rut = Format(Rut, "00000000")
   D = 2
   For i = 8 To 1 Step -1
      Multi = Val(Mid$(Rut, i, 1)) * D
     Suma = Suma + Multi
      D = D + 1
      
      If D = 8 Then
         D = 2
      End If
   Next i
    
   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))
    
   If Digito = "10" Then
      Digito = "K"
   
   End If
    
   If Digito = "11" Then
      Digito = "0"
   
   End If
   BacDevuelveDig = UCase(Digito)

End Function

Private Function TraeValor(xValor As Variant) As Double

If xValor = "" Then
   TraeValor = 0
Else
   TraeValor = xValor
End If

End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
 Select Case Button.Index
    Case 1
        Call PROC_CARGA_COMBOS(Trim(Right(CmbSistemas.Text, 3)))

    Case 2
        Call Proc_Pantalla

    Case 3
        Call Proc_Imprimir
        
    Case 4
        Call Proc_Imprimir_a_Excel
        
    Case 5
        Call Limpiar

    Case 6
         Me.Top = 0
         Call Limpiar
         Me.Left = 0
         Toolbar1.Enabled = True
         Toolbar1.Buttons(1).Enabled = True
         Toolbar1.Buttons(2).Enabled = False
         Toolbar1.Buttons(3).Enabled = False
         Toolbar1.Buttons(4).Enabled = False
         Toolbar1.Buttons(5).Enabled = False
         Toolbar1.Buttons(6).Enabled = False
         SSFrm_Sistema.Enabled = True
         FRMReporteDinamicoMX.Height = 1560
         FRMReporteDinamicoMX.Width = 11700
         

    Case 7
        Unload Me
End Select

    
End Sub

Private Sub Proc_Pantalla()

Call Datos_Necesarios

If Datos_Necesario = True Then
   Exit Sub
Else

   If Parametros = False Then
    Exit Sub
   End If
   Screen.MousePointer = vbHourglass
       
   If sSistema = "BFW" Then
      Call Pantalla_Fwd
   ElseIf sSistema = "BCC" Then
      Call Pantalla_Spt
   ElseIf sSistema = "PCS" Then
      Call Pantalla_Swp
   End If
     
       
   Screen.MousePointer = vbDefault
End If

Exit Sub
Err_RPT:
    MsgBox err.Description, vbCritical, TITSISTEMA
    Screen.MousePointer = vbDefault
End Sub

Private Sub Proc_Imprimir()
    
Call Datos_Necesarios
    
If Datos_Necesario = True Then
   Exit Sub
Else
   Call Parametros
   Screen.MousePointer = vbHourglass
       
   If sSistema = "BFW" Then
      Call Imprime_Fwd

   ElseIf sSistema = "BCC" Then
      Call Imprime_Spt

   ElseIf sSistema = "PCS" Then
      Call Pantalla_Swp

   End If

       
   Screen.MousePointer = vbDefault
End If

Exit Sub
Err_RPT:
    MsgBox err.Description, vbCritical, TITSISTEMA
    Screen.MousePointer = vbDefault
End Sub

Private Sub Proc_Imprimir_a_Excel()
    
Call Datos_Necesarios
    
If Datos_Necesario = True Then
   Exit Sub
Else
   Call Parametros
   Screen.MousePointer = vbHourglass
       
   If sSistema = "BFW" Then
      Call EjecutaExcel_Fwd
   ElseIf sSistema = "BCC" Then
      Call EjecutaExcel_Spt
   ElseIf sSistema = "PCS" Then
      Call EjecutaExcel_Swp
   End If
    
   Screen.MousePointer = vbDefault
End If

Exit Sub
Err_RPT:
    MsgBox err.Description, vbCritical, TITSISTEMA
    Screen.MousePointer = vbDefault
End Sub

Private Function Parametros() As Boolean
On Error GoTo ErrParametros

Let Parametros = True

sSistema = Trim(Right$(CmbSistemas.Text, 3))
Sproducto = Trim(Right$(CmbProducto.Text, 7))

If sSistema = "PCS" Then
    If Sproducto = "ST" Then
        Sproducto = Trim("1")
    Else
        If Sproducto = "SM" Then
            Sproducto = Trim("2")
        Else
            Sproducto = Trim("4")
        End If
    End If
End If

If sSistema = "BFW" Then
    'MODIFICADO PARA LD1-COR-035
    STipo_Cartera = Trim(Right(CmbTipoCartera.text, 5))
    'STipo_Cartera = CInt(Trim(Right$(CmbTipoCartera.text, 7)))
End If

If sSistema = "BCC" Then
   Smodalida = "0"
   SMercado = "0"
Else
   Smodalida = Trim(Right$(CmbModalidad.Text, 7))
   SMercado = Trim(Right$(cmbMercado.Text, 7))
End If
   
Sforma_pago_mn = Trim(Right$(CmbFormadePagoMN.Text, 7))
Sforma_pago_mx = Trim(Right$(CmbFormadePagoMX.Text, 7))
SMoneda_Inicial = Trim(Right$(CmbMonedaInicial.Text, 7))
SMoneda_Final = Trim(Right$(CmbMonedaFinal.Text, 7))
        
If Opt_Compra.Value Then
   SCompra = "C"
   SVenta = "C"
ElseIf Opt_Venta.Value Then
   SCompra = "V"
   SVenta = "V"
Else
   SCompra = "C"
   SVenta = "V"
End If

If Opt_NRut.Value Then
   SRutEntre = txtRut.Text
   SRutHasta = txtRut.Text
   
   If Opt_Codigo_Unico.Value Then
      SCodigoEntre = TxtCodigo.Text
      SCodigoHasta = TxtCodigo.Text
   ElseIf Opt_Codigo_Entre.Value Then
      SCodigoEntre = Txt_CodigoEntre.Text
      SCodigoHasta = Txt_CodigoHasta.Text
   Else
      SCodigoEntre = 0
      SCodigoHasta = 9999999
   End If
ElseIf Opt_EntreRut.Value Then
   SRutEntre = CmbRutEntre.Text
   SRutHasta = CmbRutHasta.Text
   SCodigoEntre = 0
   SCodigoHasta = 9999999
Else
   SRutEntre = 1
   SRutHasta = 999999999
   SCodigoEntre = 0
   SCodigoHasta = 9999999
End If

If Opt_sfiltro.Value Then
   SFecha_desde = "19000101"
   SFecha_hasta = "29990101"
Else
   If Opt_Especifica1.Value Then
      SFecha_desde = Format(TxtFechaEspecifica.Text, "yyyymmdd")
      SFecha_hasta = Format(TxtFechaEspecifica.Text, "yyyymmdd")
   Else
      SFecha_desde = Format(TxtFechaRango.Text, "yyyymmdd")
      SFecha_hasta = Format(TxtFechaHasta.Text, "yyyymmdd")
   End If
End If

If Opt_Desde1.Value Then
   SN_OpeDesde = txtN_OpeDesde.Text
   SN_OpeHasta = txtN_OpeHasta.Text
Else
   SN_OpeDesde = 1
   SN_OpeHasta = 9999999
End If
    
If Opt_Desde2.Value Then
   SValor_Inicial = CDbl(TxtValor_Inicial.Text)
   SValor_Final = CDbl(txtValor_Final.Text)
Else
   SValor_Inicial = 0
   SValor_Final = 99999999999999#
                  
End If
    
If Opt_Desde4.Value Then
   SValor_Inicial2 = CDbl(TxtValor_Inicial2.Text)
   SValor_Final2 = CDbl(txtValor_Final2.Text)
Else
   SValor_Inicial2 = 0
   SValor_Final2 = 99999999999999#
 End If
    
If Opt_Fecha.Value Then
   STipo_Fecha = "F"
Else
   STipo_Fecha = "V"
End If

If Val(Right(CmbTipoCliente.Text, 3)) = 0 Then
   STipo_Cliente_Desde = 1
   STipo_Cliente_Hasta = 999
Else
   STipo_Cliente_Desde = Val(Right(CmbTipoCliente.Text, 3))
   STipo_Cliente_Hasta = Val(Right(CmbTipoCliente.Text, 3))
End If

If Val(Right(CmbSectorEconomico.Text, 3)) = 0 Then
   SSector_Economico_Desde = 1
   SSector_Economico_Hasta = 999
Else
   SSector_Economico_Desde = Val(Right(CmbSectorEconomico.Text, 3))
   SSector_Economico_Hasta = Val(Right(CmbSectorEconomico.Text, 3))
End If
   
If Opt_todos.Value Then
   sAfavor = 99999999990#
   sEncontra = -99999999990#
ElseIf Opt_Afavor.Value Then
   sAfavor = 99999999990#
   sEncontra = 1
ElseIf Opt_Encontra.Value Then
   sAfavor = -1
   sEncontra = -99999999990#
End If

STipo_Select = "0"

If Trim(Right$(CmbSistemas.Text, 3)) = "BFW" Or Trim(Right$(CmbSistemas.Text, 3)) = "PCS" Then
    If Sproducto = "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) Then
            STipo_Select = 1
    ElseIf Sproducto = "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) Then
            STipo_Select = 2
    ElseIf Sproducto = "0" And Smodalida = "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) Then
            STipo_Select = 3
    ElseIf Sproducto = "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) Then
            STipo_Select = 4
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 5
    ElseIf Sproducto = "0" And Smodalida = "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) Then
            STipo_Select = 6
    ElseIf Sproducto = "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) Then
            STipo_Select = 7
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 8
    ElseIf Sproducto = "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) Then
            STipo_Select = 9
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 10
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Final <> 0 Then
            STipo_Select = 11
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 23
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 24
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 25
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 26
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 27
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 28
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 29
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 30

' Por Fecha de Vcto.

    ElseIf Sproducto = "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value Then
            STipo_Select = 12
    ElseIf Sproducto = "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And Opt_FechaVcto.Value Then
            STipo_Select = 13
    ElseIf Sproducto = "0" And Smodalida = "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And Opt_FechaVcto.Value Then
            STipo_Select = 14
    ElseIf Sproducto = "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And Opt_FechaVcto.Value Then
            STipo_Select = 15
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 16
    ElseIf Sproducto = "0" And Smodalida = "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value Then
            STipo_Select = 17
    ElseIf Sproducto = "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value Then
            STipo_Select = 18
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 19
    ElseIf Sproducto = "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value Then
            STipo_Select = 20
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value Then
            STipo_Select = 21
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 22
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 31
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 32
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 33
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 34
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 35
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 36
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 37
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 38
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 39
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 40
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 41
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 42
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 43
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 44
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 45
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 46
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 47

   ''''''''''''''''''''''''''''''''''''''''''''''
   ''''''''''''''''''''''''''''''''''''''''''''''
   '''        Por Fecha de Vigencia           '''
   ''''''''''''''''''''''''''''''''''''''''''''''
   ''''''''''''''''''''''''''''''''''''''''''''''
    ElseIf Sproducto = "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value Then
            STipo_Select = 48
    ElseIf Sproducto = "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And Opt_Vigencia.Value Then
            STipo_Select = 49
    ElseIf Sproducto = "0" And Smodalida = "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And Opt_Vigencia.Value Then
            STipo_Select = 50
    ElseIf Sproducto = "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And Opt_Vigencia.Value Then
            STipo_Select = 51
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And Opt_Vigencia.Value And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 52
    ElseIf Sproducto = "0" And Smodalida = "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value Then
            STipo_Select = 53
    ElseIf Sproducto = "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value Then
            STipo_Select = 54
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 55
    ElseIf Sproducto = "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value Then
            STipo_Select = 56
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value Then
            STipo_Select = 57
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 58
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 59
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 60
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 61
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 62
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 63
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 64
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 65
    ElseIf Sproducto <> "0" And Smodalida = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_Vigencia.Value And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 66
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Vigencia.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 67
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Vigencia.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 68
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Vigencia.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 69
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And (Opt_Vigencia.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 70
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And (Opt_Vigencia.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 71
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And (Opt_Vigencia.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 72
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And (Opt_Vigencia.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 73
    ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And (Opt_Vigencia.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 74
   ElseIf Sproducto <> "0" And Smodalida <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And (Opt_Vigencia.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 75
   End If
Else
    If Sproducto = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 1
    ElseIf Sproducto = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) Then
            STipo_Select = 2
    ElseIf Sproducto = "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) Then
            STipo_Select = 3
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 4
    ElseIf Sproducto = "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) Then
            STipo_Select = 5
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 6
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 7
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 8
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 9
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 10
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 11
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 12
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 13
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 14
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 15
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 16
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 17
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 18
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 19
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 20
    ElseIf Sproducto = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 21
    ElseIf Sproducto = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 22
    ElseIf Sproducto = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And (Opt_Fecha.Value Or Opt_sfiltro.Value) And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 23

'--------------------------------------
    ElseIf Sproducto = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 24
    ElseIf Sproducto = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And Opt_FechaVcto.Value Then
            STipo_Select = 25
    ElseIf Sproducto = "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value Then
            STipo_Select = 26
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 27
    ElseIf Sproducto = "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And Opt_FechaVcto.Value Then
            STipo_Select = 28
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 29
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 30
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final = 0 Then
            STipo_Select = 31
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 32
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 33
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 34
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 35
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 36
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 37
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 38
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 39
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 40
    ElseIf Sproducto <> "0" And Sforma_pago_mn = 0 And Sforma_pago_mx <> 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 41
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 42
    ElseIf Sproducto <> "0" And Sforma_pago_mn <> 0 And Sforma_pago_mx <> 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 43
    ElseIf Sproducto = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final = 0 Then
            STipo_Select = 44
    ElseIf Sproducto = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial = 0 And SMoneda_Final <> 0 Then
            STipo_Select = 45
    ElseIf Sproducto = "0" And Sforma_pago_mn = 0 And Sforma_pago_mx = 0 And Opt_FechaVcto.Value And SMoneda_Inicial <> 0 And SMoneda_Final <> 0 Then
            STipo_Select = 46
    End If
End If

On Error GoTo 0
Exit Function
ErrParametros:
Let Parametros = False
Call MsgBox(err.Description, vbExclamation, App.Title)
On Error GoTo 0

End Function

Private Sub Datos_Necesarios()
Datos_Necesario = False

If CmbProducto.ListIndex = -1 Then
        MsgBox "Debe Seleccionar el Producto", 16, TITSISTEMA
        Datos_Necesario = True
        CmbProducto.SetFocus
        Exit Sub

ElseIf CmbModalidad.ListIndex = -1 Then
        If Left(CmbSistemas.Text, 4) <> "SPOT" Then
            MsgBox "Debe Seleccionar la Modalidad de Pago", 16, TITSISTEMA
            Datos_Necesario = True
            CmbModalidad.SetFocus
            Exit Sub
        End If

ElseIf CmbFormadePagoMN.ListIndex = -1 Then
        MsgBox "Debe Seleccionar la Forma de Pago Moneda Nacional", 16, TITSISTEMA
        Datos_Necesario = True
        CmbFormadePagoMN.SetFocus
        Exit Sub

ElseIf CmbFormadePagoMX.ListIndex = -1 Then
        MsgBox "Debe Seleccionar la Forma de Pago Moneda Extranjera", 16, TITSISTEMA
        Datos_Necesario = True
        CmbFormadePagoMX.SetFocus
        Exit Sub

ElseIf CmbMonedaInicial.ListIndex = -1 Then
        MsgBox "Debe Seleccionar la Moneda Inicial", 16, TITSISTEMA
        Datos_Necesario = True
        CmbMonedaInicial.SetFocus
        Exit Sub

ElseIf CmbMonedaFinal.ListIndex = -1 Then
        MsgBox "Debe Seleccionar la Moneda Final", 16, TITSISTEMA
        Datos_Necesario = True
        CmbMonedaFinal.SetFocus
        Exit Sub
      
ElseIf Opt_NRut.Value = True And txtRut.Enabled = True Then
        MsgBox "Debe Seleccionar al Cliente", 16, TITSISTEMA
        Datos_Necesario = True
        txtRut.SetFocus
        Exit Sub

ElseIf Opt_EntreRut.Value = True And (CmbRutEntre.Text = "" Or CmbRutHasta.Text = "") Then
        MsgBox "Debe Seleccionar el Intervalo de Rut", 16, TITSISTEMA
        Datos_Necesario = True
        CmbRutEntre.SetFocus
        Exit Sub

ElseIf Opt_Desde1.Value = True And (txtN_OpeDesde.Text = "" Or txtN_OpeHasta.Text = "") Then
        MsgBox "Debe Ingresar el Intervalo de Numeros de Operación", 16, TITSISTEMA
        Datos_Necesario = True
        txtN_OpeDesde.SetFocus
        Exit Sub

ElseIf Opt_Desde2.Value = True And (TxtValor_Inicial.Text = 0 Or txtValor_Final.Text = 0) Then
        MsgBox "Debe Ingresar el Intervalo de Valores de Moneda Inicial", 16, TITSISTEMA
        Datos_Necesario = True
        TxtValor_Inicial.SetFocus
        Exit Sub

ElseIf Opt_Desde4.Value = True And (TxtValor_Inicial2.Text = 0 Or txtValor_Final2.Text = 0) Then
        MsgBox "Debe Ingresar el Intervalo de Valores de Moneda Final", 16, TITSISTEMA
        Datos_Necesario = True
        TxtValor_Inicial2.SetFocus
        Exit Sub

ElseIf Opt_Desde4.Value = True And (TxtValor_Inicial2.Text = 0 Or txtValor_Final2.Text = 0) Then
        MsgBox "Debe Ingresar el Intervalo de Valores de Moneda Final", 16, TITSISTEMA
        Datos_Necesario = True
        TxtValor_Inicial2.SetFocus
        Exit Sub
ElseIf Val(CmbRutEntre.Text) > Val(CmbRutHasta.Text) Then
        MsgBox ("El primer campo no puede ser mayor que el segundo"), 16, TITSISTEMA
        CmbRutEntre.Text = 0
        CmbRutEntre.SetFocus
        Exit Sub
    

End If
   
End Sub

Sub Limpiar()
Opt_Todos1.Value = True
If CmbProducto.ListIndex > 0 Then
    CmbProducto.ListIndex = 0
Else
    CmbProducto.ListIndex = -1
End If

If Left(CmbSistemas.Text, 4) <> "SPOT" Then
   CmbModalidad.ListIndex = 0
End If
If CmbFormadePagoMN.ListIndex > 0 Then
    CmbFormadePagoMN.ListIndex = 0
Else
    CmbFormadePagoMN.ListIndex = -1
End If
If CmbFormadePagoMX.ListIndex > 0 Then
    CmbFormadePagoMX.ListIndex = 0
Else
    CmbFormadePagoMX.ListIndex = -1
End If
If CmbTipoCliente.ListIndex > 0 Then
    CmbTipoCliente.ListIndex = 0
Else
    CmbTipoCliente.ListIndex = -1
End If
If CmbSectorEconomico.ListIndex > 0 Then
    CmbSectorEconomico.ListIndex = 0
Else
    CmbSectorEconomico.ListIndex = -1
End If
If CmbMonedaInicial.ListIndex > 0 Then
    CmbMonedaInicial.ListIndex = 0
Else
    CmbMonedaInicial.ListIndex = -1
End If
If CmbMonedaFinal.ListIndex > 0 Then
    CmbMonedaFinal.ListIndex = 0
Else
    CmbMonedaFinal.ListIndex = -1
End If

CmbRutEntre.Text = ""
CmbRutHasta.Text = ""

TxtFechaEspecifica.Text = gsBac_Fecp
TxtFechaRango.Text = gsBac_Fecp
TxtFechaHasta.Text = gsBac_Fecp


Opt_Ambas.Value = True
Opt_Compra.Value = False
Opt_Venta.Value = False

txtRut.Text = ""
txtDigito.Text = ""
TxtCodigo.Text = ""
TxtNombre.Text = ""

txtN_OpeDesde.Text = ""
txtN_OpeHasta.Text = ""
TxtValor_Inicial.Text = ""
txtValor_Final.Text = ""
TxtValor_Inicial2.Text = ""
txtValor_Final2.Text = ""

End Sub

Private Sub Opt_NRut_Click()

   If Opt_NRut.Value = True Then
      CmbRutEntre.Enabled = False
      CmbRutHasta.Enabled = False
      Frame_SubCliente.Enabled = True
      Label(7).Enabled = False
      Opt_Codigo_Unico.Enabled = True
      Opt_Codigo_Entre.Enabled = True
      Opt_Codigo_Todos.Enabled = True
      txtRut.Text = ""
      txtDigito.Text = ""
      TxtCodigo.Text = ""
      TxtNombre.Text = ""
      txtRut.Enabled = True
      txtDigito.Enabled = True
      TxtCodigo.Enabled = False
      txtRut.SetFocus
      CmbRutEntre.Text = 0
      CmbRutHasta.Text = 0
   End If
End Sub

Private Sub Opt_EntreRut_Click()
If Opt_EntreRut.Value = True Then
        Call Valida_Combos
        If Valida_Combo = True Then Exit Sub
         CmbRutEntre.Enabled = True
         CmbRutHasta.Enabled = True
         Opt_Codigo_Todos.Value = True
         Frame_SubCliente.Enabled = False
         Opt_Codigo_Unico.Enabled = False
         Opt_Codigo_Entre.Enabled = False
         Opt_Codigo_Todos.Enabled = False
         Label(7).Enabled = True
         CmbRutEntre.SetFocus
         txtRut.Enabled = False
         txtDigito.Enabled = False
         TxtCodigo.Enabled = False
End If

End Sub

Private Sub Opt_Todos1_Click()
   If Opt_Todos1.Value = True Then
      CmbRutEntre.Enabled = False
      CmbRutHasta.Enabled = False
      txtRut.Text = ""
      txtDigito.Text = ""
      TxtNombre.Text = ""
      txtRut.Enabled = False
      TxtCodigo.Text = ""
      txtDigito.Enabled = False
      TxtCodigo.Enabled = False
      Opt_Codigo_Todos.Value = True
      Frame_SubCliente.Enabled = False
      Label(7).Enabled = False
      Opt_Codigo_Unico.Enabled = False
      Opt_Codigo_Entre.Enabled = False
      Opt_Codigo_Todos.Enabled = False
      CmbRutEntre.Text = 0
      CmbRutHasta.Text = 0
   End If
End Sub

Private Sub CmbRutEntre_LostFocus()
    If CmbRutEntre.Text = "" Then Exit Sub
    If CmbRutHasta.Text = "" Then Exit Sub
    If Val(CmbRutEntre.Text) > Val(CmbRutHasta.Text) Then
        MsgBox ("El primer campo no puede ser mayor que el segundo"), 16, TITSISTEMA
        CmbRutEntre.Text = 0
        CmbRutEntre.SetFocus
        Exit Sub
    End If
End Sub

Private Sub CmbRutHasta_LostFocus()
    If Val(CmbRutEntre.Text) > Val(CmbRutHasta.Text) Then
        MsgBox "El primer campo no puede ser mayor que el segundo", 16, TITSISTEMA
        CmbRutHasta.Text = 0
        CmbRutHasta.Enabled = True
        CmbRutHasta.SetFocus
        Exit Sub
    End If
End Sub

Private Sub Opt_Especifica1_Click()
    If Opt_Especifica1.Value = True Then
       TxtFechaRango.Enabled = False
       TxtFechaHasta.Enabled = False
       TxtFechaEspecifica.Enabled = True
       TxtFechaEspecifica.SetFocus
    Else
       TxtFechaRango.Enabled = True
       TxtFechaHasta.Enabled = True
       TxtFechaEspecifica.Enabled = False
       TxtFechaRango.SetFocus
        End If
End Sub

Private Sub TxtFechaEspecifica_LostFocus()
    If Opt_Fecha.Value = True Then
    Else
    End If
End Sub

Private Sub Opt_Rango_Click()
    If Opt_Rango.Value = True Then
       TxtFechaRango.Enabled = True
       TxtFechaHasta.Enabled = True
       TxtFechaEspecifica.Enabled = False
       TxtFechaRango.SetFocus
    Else
       TxtFechaRango.Enabled = False
       TxtFechaHasta.Enabled = False
       TxtFechaEspecifica.Enabled = True
       TxtFechaEspecifica.SetFocus
    End If
End Sub

Private Sub TxtFechaRango_LostFocus()
     If Opt_Fecha.Value = True Then
        If CDate(TxtFechaHasta.Text) < CDate(TxtFechaRango.Text) Then
            MsgBox "La Fecha NO puede ser mayor que la fecha Final", 16, TITSISTEMA
            TxtFechaRango.Text = TxtFechaHasta.Text
            TxtFechaRango.SetFocus
        End If
    Else
        If CDate(TxtFechaHasta.Text) < CDate(TxtFechaRango.Text) Then
            MsgBox "La Fecha NO puede ser mayor que la fecha Final", 16, TITSISTEMA
            TxtFechaRango.Text = TxtFechaHasta.Text
            TxtFechaRango.SetFocus
        End If
    End If
End Sub

Private Sub TxtFechaHasta_LostFocus()
    If Opt_Fecha.Value Then
        If CDate(TxtFechaHasta.Text) < CDate(TxtFechaRango.Text) Then
            MsgBox "La Fecha NO puede ser menor que la fecha Inicial", 16, TITSISTEMA
            TxtFechaHasta.Text = TxtFechaRango.Text
            TxtFechaHasta.SetFocus
           End If
    Else
        If CDate(TxtFechaHasta.Text) < CDate(TxtFechaRango.Text) Then
            MsgBox "La Fecha NO puede ser menor que la fecha Inicial", 16, TITSISTEMA
            TxtFechaHasta.Text = TxtFechaRango.Text
            TxtFechaHasta.SetFocus
        End If
    End If
End Sub

Private Sub Opt_Desde1_Click()
    If Opt_Desde1.Value = True Then
       txtN_OpeHasta.Enabled = True
       txtN_OpeDesde.Enabled = True
       txtN_OpeDesde.SetFocus
    Else
       txtN_OpeHasta.Enabled = False
       txtN_OpeDesde.Enabled = False
    End If
End Sub

Private Sub Opt_Todos2_Click()
    If Opt_Todos2.Value = True Then
      txtN_OpeHasta.Enabled = False
      txtN_OpeDesde.Enabled = False
      txtN_OpeDesde.Text = ""
      txtN_OpeHasta.Text = ""
    Else
       txtN_OpeHasta.Enabled = True
       txtN_OpeDesde.Enabled = True
    End If
End Sub

Private Sub Opt_Todos3_Click()
    If Opt_Todos3.Value = True Then
       TxtValor_Inicial.Text = 0
       txtValor_Final.Text = 0
       TxtValor_Inicial.Enabled = False
       txtValor_Final.Enabled = False
    Else
       TxtValor_Inicial.Enabled = True
       txtValor_Final.Enabled = True
       TxtValor_Inicial.SetFocus
    End If
End Sub

Private Sub Opt_Desde2_Click()
    If Opt_Desde2.Value = True Then
       TxtValor_Inicial.Enabled = True
       txtValor_Final.Enabled = True
       TxtValor_Inicial.SetFocus
    Else
       TxtValor_Inicial.Enabled = False
       txtValor_Final.Enabled = False
    End If

End Sub

Private Sub txtN_OpeDesde_KeyPress(KeyAscii As Integer)
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      txtN_OpeHasta.Enabled = True
      txtN_OpeHasta.SetFocus
   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
   End If
   BacCaracterNumerico KeyAscii

End Sub

Private Sub txtN_OpeHasta_LostFocus()
    If Opt_Desde1.Value = True Then
        If Val(txtN_OpeDesde.Text) > Val(txtN_OpeHasta.Text) Then
            MsgBox "Número de Operación no Puede Ser Menor", 16, TITSISTEMA
            txtN_OpeHasta.SetFocus
        End If
    End If

End Sub

Private Sub txtN_OpeHasta_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
          KeyAscii% = 0
          CmbMonedaFinal.Enabled = True
          CmbMonedaFinal.SetFocus
       ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
          KeyAscii = 0
       End If
       BacCaracterNumerico KeyAscii
End Sub

Private Sub txtValor_Final_LostFocus()
    If Opt_Desde2.Value = True Then
        If Abs(TxtValor_Inicial.Text) > Abs(txtValor_Final.Text) Then
            MsgBox "El Valor Inicial no puede ser mayor que el valor Final", 16, TITSISTEMA
            txtValor_Final.SetFocus
        End If
    End If
End Sub

Private Sub Opt_Todos6_Click()
    If Opt_Todos6.Value = True Then
       TxtValor_Inicial2.Text = 0
       txtValor_Final2.Text = 0
       TxtValor_Inicial2.Enabled = False
       txtValor_Final2.Enabled = False
    Else
       TxtValor_Inicial2.Enabled = True
       txtValor_Final2.Enabled = True
       TxtValor_Inicial2.SetFocus
    End If
End Sub

Private Sub Opt_Desde4_Click()
    If Opt_Desde4.Value = True Then
       TxtValor_Inicial2.Enabled = True
       txtValor_Final2.Enabled = True
       TxtValor_Inicial2.SetFocus
    Else
       TxtValor_Inicial2.Enabled = False
       txtValor_Final2.Enabled = False
    End If
End Sub

Private Sub txtValor_Final2_LostFocus()
    If Opt_Desde4.Value = True Then
        If Abs(TxtValor_Inicial2.Text) > Abs(txtValor_Final2.Text) Then
            MsgBox "El Valor Inicial no puede ser mayor que el valor Final", 16, TITSISTEMA
            txtValor_Final2.SetFocus
        End If
    End If
End Sub

Sub EjecutaExcel_Spt()

   Dim sCadena       As String
   Dim nUltimaCol    As Integer
   Dim Sql           As String
   Dim i             As Integer
   Dim xFecha_Desde As String
   Dim xFecha_Hasta As String
   Dim cDesde As String
   Dim cHasta As String

On Error GoTo ErrArchivospt

   cDesde = ""
   cHasta = ""
   

If Opt_sfiltro.Value Then
   cDesde = ""
   cHasta = ""
   xFecha_Desde = ""
   xFecha_Hasta = ""
Else
   cDesde = "Consulta Desde"
   cHasta = "Hasta"

   If Opt_Especifica1.Value Then
      xFecha_Desde = Format(TxtFechaEspecifica.Text, "dd/mm/yyyy")
      xFecha_Hasta = Format(TxtFechaEspecifica.Text, "dd/mm/yyyy")
   Else
      xFecha_Desde = Format(TxtFechaRango.Text, "dd/mm/yyyy")
      xFecha_Hasta = Format(TxtFechaHasta.Text, "dd/mm/yyyy")
   End If
End If

Envia = Array()
' Parametros
AddParam Envia, STipo_Select
AddParam Envia, Sproducto
AddParam Envia, Sforma_pago_mn
AddParam Envia, Sforma_pago_mx
AddParam Envia, SMoneda_Inicial
AddParam Envia, SValor_Inicial
AddParam Envia, SValor_Final
AddParam Envia, SMoneda_Final
AddParam Envia, SValor_Inicial2
AddParam Envia, SValor_Final2
AddParam Envia, SCompra
AddParam Envia, SVenta
AddParam Envia, SRutEntre
AddParam Envia, SRutHasta
AddParam Envia, SCodigoEntre
AddParam Envia, SCodigoHasta
AddParam Envia, SFecha_desde
AddParam Envia, SFecha_hasta
AddParam Envia, SN_OpeDesde
AddParam Envia, SN_OpeHasta
AddParam Envia, STipo_Fecha
AddParam Envia, STipo_Cliente_Desde
AddParam Envia, STipo_Cliente_Hasta
AddParam Envia, SSector_Economico_Desde
AddParam Envia, SSector_Economico_Hasta

If Not Bac_Sql_Execute("SP_REPORTE_FILTRO_DINAMICO_BCC ", Envia) Then
    MsgBox "Grabación no tuvo exito", 16, TITSISTEMA
    Exit Sub
End If


   FileCopy RptList_Path & "Filtro_Mx_Spt.xls", RptList_Path & "Filtro_Spt.xls"
   

   Set oconeccionexcel = New ADODB.Connection

   oconeccionexcel.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & RptList_Path & "Filtro_Spt.xls;Extended Properties=""Excel 8.0;HDR=NO;"""
   
   oconeccionexcel.Execute "UPDATE Fecha SET F1 = '" & CStr(Format(Date, "dd/mm/yyyy")) & "'"
   oconeccionexcel.Execute "UPDATE Hora  SET F1 = '" & CStr(Time) & "'"

   oconeccionexcel.Execute "UPDATE desde  SET F1 =  '" & cDesde & "'"
   oconeccionexcel.Execute "UPDATE hasta  SET F1 =  '" & cHasta & "'"
   oconeccionexcel.Execute "UPDATE desde  SET F2 =  '" & CStr(xFecha_Desde) & "'"
   oconeccionexcel.Execute "UPDATE hasta  SET F2 =  '" & CStr(xFecha_Hasta) & "'"

i = 1
Do While Bac_SQL_Fetch(Datos())

    If i = 1 Then
        oconeccionexcel.Execute "UPDATE Datos SET F1 = '" & Datos(13) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F2 = '" & Datos(16) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F3 = '" & Datos(18) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F4 = '" & Datos(19) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F5 = '" & Datos(1) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F6 = '" & Datos(2) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F7 = '" & Datos(3) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F8 = '" & Datos(4) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F9 = '" & Datos(5) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F10 = '" & Datos(6) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F11 = '" & Datos(7) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F12 = '" & Datos(8) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F13 = '" & Datos(9) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F14 = '" & Datos(10) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F15 = '" & Datos(11) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F16 = '" & Datos(14) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F17 = '" & Datos(15) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F18 = '" & Datos(20) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F19 = '" & Datos(21) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F20 = '" & Datos(22) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F21 = '" & Datos(23) & "'"
    Else
        Sql = "INSERT INTO Datos (F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21)"
        Sql = Sql & " Values ( '" & Datos(13) & "' , '" & _
                                    Datos(16) & "' , '" & _
                                    Datos(18) & "' , '" & _
                                    Datos(19) & "' , '" & _
                                    Datos(1) & "' , '" & _
                                    Datos(2) & "' , '" & _
                                    Datos(3) & "' , '" & _
                                    Datos(4) & "' , '" & _
                                    Datos(5) & "' , '" & _
                                    Datos(6) & "' , '" & _
                                    Datos(7) & "' , '" & _
                                    Datos(8) & "' , '" & _
                                    Datos(9) & "' , '" & _
                                    Datos(10) & "' , '" & _
                                    Datos(11) & "' , '" & _
                                    Datos(14) & "' , '" & _
                                    Datos(15) & "' , '" & _
                                    Datos(20) & "' , '" & _
                                    Datos(21) & "' , '" & _
                                    Datos(22) & "' , '" & _
                                    Datos(23) & "')"

        oconeccionexcel.Execute Sql
    End If
    i = i + 1
Loop
        
   oconeccionexcel.Close
   Set oconeccionexcel = Nothing
    
   DoEvents

   ShellExecute Me.hWnd, "Open", RptList_Path & "Filtro_Spt.xls", "", "C:\", SW_NORMAL

Exit Sub

ErrArchivospt:
If err.Number = 70 Then
   MsgBox "Ya esta abierto el informe debe cerrarlo para una nueva consulta!!!!", vbCritical
Else
   MsgBox err.Description
End If

End Sub

Sub EjecutaExcel_Fwd()
Dim sCadena          As String
Dim nUltimaCol       As Integer
Dim Sql              As String
Dim i                As Integer
Dim oconeccionexcel  As ADODB.Connection
   Dim xFecha_Desde As String
   Dim xFecha_Hasta As String
   Dim cDesde As String
   Dim cHasta As String

On Error GoTo ErrArchivo
   
Envia = Array()

If Opt_sfiltro.Value Then
   cDesde = ""
   cHasta = ""
   xFecha_Desde = ""
   xFecha_Hasta = ""
Else
   cDesde = "Consulta Desde"
   cHasta = "Hasta"


   If Opt_Especifica1.Value Then
      xFecha_Desde = Format(TxtFechaEspecifica.Text, "dd/mm/yyyy")
      xFecha_Hasta = Format(TxtFechaEspecifica.Text, "dd/mm/yyyy")
   Else
      xFecha_Desde = Format(TxtFechaRango.Text, "dd/mm/yyyy")
      xFecha_Hasta = Format(TxtFechaHasta.Text, "dd/mm/yyyy")
   End If
End If

   FileCopy RptList_Path & "Filtro_Mx_Fwd.xls", RptList_Path & "Filtro_Fwd.xls"

   Set oconeccionexcel = New ADODB.Connection

   oconeccionexcel.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & RptList_Path & "Filtro_Fwd.xls;Extended Properties=""Excel 8.0;HDR=NO;"""

   oconeccionexcel.Execute "UPDATE Fecha SET F1 = '" & CStr(Format(Date, "dd/mm/yyyy")) & "'"
   oconeccionexcel.Execute "UPDATE Hora  SET F1 =  '" & CStr(Time) & "'"

   oconeccionexcel.Execute "UPDATE desde  SET F1 =  '" & cDesde & "'"
   oconeccionexcel.Execute "UPDATE hasta  SET F1 =  '" & cHasta & "'"
   oconeccionexcel.Execute "UPDATE desde  SET F2 =  '" & CStr(xFecha_Desde) & "'"
   oconeccionexcel.Execute "UPDATE hasta  SET F2 =  '" & CStr(xFecha_Hasta) & "'"

' Parametros
AddParam Envia, STipo_Select
AddParam Envia, Sproducto
AddParam Envia, Smodalida
AddParam Envia, Sforma_pago_mn
AddParam Envia, Sforma_pago_mx
AddParam Envia, SMoneda_Inicial
AddParam Envia, SValor_Inicial
AddParam Envia, SValor_Final
AddParam Envia, SMoneda_Final
AddParam Envia, SValor_Inicial2
AddParam Envia, SValor_Final2
AddParam Envia, SCompra
AddParam Envia, SVenta
AddParam Envia, SRutEntre
AddParam Envia, SRutHasta
AddParam Envia, SCodigoEntre
AddParam Envia, SCodigoHasta
AddParam Envia, SFecha_desde
AddParam Envia, SFecha_hasta
AddParam Envia, SN_OpeDesde
AddParam Envia, SN_OpeHasta
AddParam Envia, STipo_Fecha
AddParam Envia, sAfavor
AddParam Envia, sEncontra
AddParam Envia, STipo_Cliente_Desde
AddParam Envia, STipo_Cliente_Hasta
AddParam Envia, SSector_Economico_Desde
AddParam Envia, SSector_Economico_Hasta
AddParam Envia, STipo_Cartera
AddParam Envia, SMercado

If Not Bac_Sql_Execute("Sp_Reporte_Filtro_Dinamico_Fwd ", Envia) Then
    MsgBox "Grabación no tuvo exito", 16, TITSISTEMA
    Exit Sub
End If

i = 1

Do While Bac_SQL_Fetch(Datos())
    If i = 1 Then
        oconeccionexcel.Execute "UPDATE Datos SET F1 = '" & Datos(13) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F2 = '" & Datos(16) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F3 = '" & Datos(18) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F4 = '" & Datos(19) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F5 = '" & Datos(1) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F6 = '" & Datos(2) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F7 = '" & Datos(3) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F8 = '" & Datos(4) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F9 = '" & Datos(5) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F10 = '" & Datos(6) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F11 = '" & Datos(8) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F12 = '" & Datos(9) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F13 = '" & Datos(10) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F14 = '" & Datos(11) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F15 = '" & Datos(12) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F16 = '" & Datos(14) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F17 = '" & Datos(15) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F18 = '" & Datos(21) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F19 = '" & Datos(20) & "'"
    Else
        Sql = "INSERT INTO Datos (F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19) "
        Sql = Sql & " Values ( '" & Datos(13) & " ', '" & _
                                    Datos(16) & " ', '" & _
                                    Datos(18) & " ', '" & _
                                    Datos(19) & " ', '" & _
                                    Datos(1) & " ', '" & _
                                    Datos(2) & " ', '" & _
                                    Datos(3) & " ', '" & _
                                    Datos(4) & " ', '" & _
                                    Datos(5) & " ', '" & _
                                    Datos(6) & " ', '" & _
                                    Datos(8) & " ', '" & _
                                    Datos(9) & " ', '" & _
                                    Datos(10) & " ', '" & _
                                    Datos(11) & " ', '" & _
                                    Datos(12) & " ', '" & _
                                    Datos(14) & " ', '" & _
                                    Datos(15) & " ', '" & _
                                    Datos(21) & " ', '" & _
                                    Datos(20) & " ')"

                                    
        oconeccionexcel.Execute Sql
    End If
    i = i + 1
Loop

oconeccionexcel.Close
Set oconeccionexcel = Nothing
    
DoEvents

ShellExecute Me.hWnd, "Open", RptList_Path & "Filtro_Fwd.xls", "", "C:\", 1

Exit Sub

ErrArchivo:
If err.Number = 70 Then
   MsgBox "Ya esta abierto el informe debe cerrarlo para una nueva consulta!!!!", vbCritical
Else
   MsgBox err.Description
End If

End Sub


Sub EjecutaExcel_Swp()
Dim sCadena          As String
Dim nUltimaCol       As Integer
Dim Sql              As String
Dim i                As Integer
Dim oconeccionexcel  As ADODB.Connection
   Dim xFecha_Desde As String
   Dim xFecha_Hasta As String
   Dim cDesde As String
   Dim cHasta As String

On Error GoTo ErrArchivo
   
Envia = Array()

If Opt_sfiltro.Value Then
   cDesde = ""
   cHasta = ""
   xFecha_Desde = ""
   xFecha_Hasta = ""
Else
   cDesde = "Consulta Desde"
   cHasta = "Hasta"


   If Opt_Especifica1.Value Then
      xFecha_Desde = Format(TxtFechaEspecifica.Text, "dd/mm/yyyy")
      xFecha_Hasta = Format(TxtFechaEspecifica.Text, "dd/mm/yyyy")
   Else
      xFecha_Desde = Format(TxtFechaRango.Text, "dd/mm/yyyy")
      xFecha_Hasta = Format(TxtFechaHasta.Text, "dd/mm/yyyy")
   End If
End If

   FileCopy RptList_Path & "Filtro_Mx_Swp.xls", RptList_Path & "Filtro_Swp.xls"

   Set oconeccionexcel = New ADODB.Connection

   oconeccionexcel.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & RptList_Path & "Filtro_Swp.xls;Extended Properties=""Excel 8.0;HDR=NO;"""

   oconeccionexcel.Execute "UPDATE Fecha SET F1 = '" & CStr(Format(Date, "dd/mm/yyyy")) & "'"
   oconeccionexcel.Execute "UPDATE Hora  SET F1 =  '" & CStr(Time) & "'"

   oconeccionexcel.Execute "UPDATE desde  SET F1 =  '" & cDesde & "'"
   oconeccionexcel.Execute "UPDATE hasta  SET F1 =  '" & cHasta & "'"
   oconeccionexcel.Execute "UPDATE desde  SET F2 =  '" & CStr(xFecha_Desde) & "'"
   oconeccionexcel.Execute "UPDATE hasta  SET F2 =  '" & CStr(xFecha_Hasta) & "'"

' Parametros
AddParam Envia, STipo_Select
AddParam Envia, Sproducto
AddParam Envia, Smodalida
AddParam Envia, Sforma_pago_mn
AddParam Envia, Sforma_pago_mx
AddParam Envia, SMoneda_Inicial
AddParam Envia, SValor_Inicial
AddParam Envia, SValor_Final
AddParam Envia, SMoneda_Final
AddParam Envia, SValor_Inicial2
AddParam Envia, SValor_Final2
AddParam Envia, SCompra
AddParam Envia, SVenta
AddParam Envia, SRutEntre
AddParam Envia, SRutHasta
AddParam Envia, SCodigoEntre
AddParam Envia, SCodigoHasta
AddParam Envia, SFecha_desde
AddParam Envia, SFecha_hasta
AddParam Envia, SN_OpeDesde
AddParam Envia, SN_OpeHasta
AddParam Envia, STipo_Fecha
AddParam Envia, sAfavor
AddParam Envia, sEncontra
AddParam Envia, STipo_Cliente_Desde
AddParam Envia, STipo_Cliente_Hasta
AddParam Envia, SSector_Economico_Desde
AddParam Envia, SSector_Economico_Hasta
AddParam Envia, STipo_Cartera
AddParam Envia, SMercado

If Not Bac_Sql_Execute("Sp_Reporte_Filtro_Dinamico_Swap ", Envia) Then
    MsgBox "Grabación no tuvo exito", 16, TITSISTEMA
    Exit Sub
End If

i = 1

Do While Bac_SQL_Fetch(Datos())
    If i = 1 Then
        oconeccionexcel.Execute "UPDATE Datos SET F1 = '" & Datos(13) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F2 = '" & Datos(16) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F3 = '" & Datos(18) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F4 = '" & Datos(19) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F5 = '" & Datos(1) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F6 = '" & Datos(2) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F7 = '" & Datos(3) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F8 = '" & Datos(4) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F9 = '" & Datos(5) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F10 = " & Datos(6)
        oconeccionexcel.Execute "UPDATE Datos SET F11 = '" & Datos(8) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F12 = '" & Datos(9) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F13 = '" & Datos(10) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F14 = '" & Datos(11) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F15 = '" & Datos(12) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F16 = '" & Datos(14) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F17 = '" & Datos(15) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F18 = '" & Datos(21) & "'"
        oconeccionexcel.Execute "UPDATE Datos SET F19 = '" & Datos(20) & "'"
    Else
        Sql = "INSERT INTO Datos (F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19) "
        Sql = Sql & " Values ( '" & Datos(13) & " ', '" & _
                                    Datos(16) & " ', '" & _
                                    Datos(18) & " ', '" & _
                                    Datos(19) & " ', '" & _
                                    Datos(1) & " ', '" & _
                                    Datos(2) & " ', '" & _
                                    Datos(3) & " ', '" & _
                                    Datos(4) & " ', '" & _
                                    Datos(5) & " ', '" & _
                                    Datos(6) & " ', '" & _
                                    Datos(8) & " ', '" & _
                                    Datos(9) & " ', '" & _
                                    Datos(10) & " ', '" & _
                                    Datos(11) & " ', '" & _
                                    Datos(12) & " ', '" & _
                                    Datos(14) & " ', '" & _
                                    Datos(15) & " ', '" & _
                                    Datos(21) & " ', '" & _
                                    Datos(20) & " ')"

                                    
        oconeccionexcel.Execute Sql
    End If
    i = i + 1
Loop

oconeccionexcel.Close
Set oconeccionexcel = Nothing
    
DoEvents

ShellExecute Me.hWnd, "Open", RptList_Path & "Filtro_Swp.xls", "", "C:\", 1

Exit Sub

ErrArchivo:
If err.Number = 70 Then
   MsgBox "Ya esta abierto el informe debe cerrarlo para una nueva consulta!!!!", vbCritical
Else
   MsgBox err.Description
End If

End Sub


Sub Imprime_Fwd()
On Error GoTo ErrArchivo

Call LimpiarCristal

BacTrader.bacrpt.ReportFileName = RptList_Path & "Filtro_Moneda_Extranjera_Fwd.rpt"

' Parametros
BacTrader.bacrpt.StoredProcParam(0) = STipo_Select
BacTrader.bacrpt.StoredProcParam(1) = Sproducto
BacTrader.bacrpt.StoredProcParam(2) = Smodalida
BacTrader.bacrpt.StoredProcParam(3) = Sforma_pago_mn
BacTrader.bacrpt.StoredProcParam(4) = Sforma_pago_mx
BacTrader.bacrpt.StoredProcParam(5) = SMoneda_Inicial
BacTrader.bacrpt.StoredProcParam(6) = SValor_Inicial
BacTrader.bacrpt.StoredProcParam(7) = SValor_Final
BacTrader.bacrpt.StoredProcParam(8) = SMoneda_Final
BacTrader.bacrpt.StoredProcParam(9) = SValor_Inicial2
BacTrader.bacrpt.StoredProcParam(10) = SValor_Final2
BacTrader.bacrpt.StoredProcParam(11) = SCompra
BacTrader.bacrpt.StoredProcParam(12) = SVenta
BacTrader.bacrpt.StoredProcParam(13) = SRutEntre
BacTrader.bacrpt.StoredProcParam(14) = SRutHasta
BacTrader.bacrpt.StoredProcParam(15) = SCodigoEntre
BacTrader.bacrpt.StoredProcParam(16) = SCodigoHasta
BacTrader.bacrpt.StoredProcParam(17) = SFecha_desde
BacTrader.bacrpt.StoredProcParam(18) = SFecha_hasta
BacTrader.bacrpt.StoredProcParam(19) = SN_OpeDesde
BacTrader.bacrpt.StoredProcParam(20) = SN_OpeHasta
BacTrader.bacrpt.StoredProcParam(21) = STipo_Fecha
BacTrader.bacrpt.StoredProcParam(22) = sAfavor
BacTrader.bacrpt.StoredProcParam(23) = sEncontra
BacTrader.bacrpt.StoredProcParam(24) = STipo_Cliente_Desde
BacTrader.bacrpt.StoredProcParam(25) = STipo_Cliente_Hasta
BacTrader.bacrpt.StoredProcParam(26) = SSector_Economico_Desde
BacTrader.bacrpt.StoredProcParam(27) = SSector_Economico_Hasta
BacTrader.bacrpt.StoredProcParam(28) = STipo_Cartera



BacTrader.bacrpt.Connect = CONECCION
BacTrader.bacrpt.Destination = crptToPrinter
BacTrader.bacrpt.WindowState = crptMaximized
BacTrader.bacrpt.Action = 1

Exit Sub

ErrArchivo:
If err.Number = 70 Then
   MsgBox "Ya esta abierto el informe debe cerrarlo para una nueva consulta!!!!", vbCritical
Else
   MsgBox "Error inesperado", vbCritical
End If

End Sub

Sub Pantalla_Fwd()
On Error GoTo ErrArchivo

Call LimpiarCristal

BacTrader.bacrpt.ReportFileName = RptList_Path & "Filtro_Moneda_Extranjera_Fwd.rpt"

' Parametros
BacTrader.bacrpt.StoredProcParam(0) = STipo_Select
BacTrader.bacrpt.StoredProcParam(1) = Sproducto
BacTrader.bacrpt.StoredProcParam(2) = Smodalida
BacTrader.bacrpt.StoredProcParam(3) = Sforma_pago_mn
BacTrader.bacrpt.StoredProcParam(4) = Sforma_pago_mx
BacTrader.bacrpt.StoredProcParam(5) = SMoneda_Inicial
BacTrader.bacrpt.StoredProcParam(6) = SValor_Inicial
BacTrader.bacrpt.StoredProcParam(7) = SValor_Final
BacTrader.bacrpt.StoredProcParam(8) = SMoneda_Final
BacTrader.bacrpt.StoredProcParam(9) = SValor_Inicial2
BacTrader.bacrpt.StoredProcParam(10) = SValor_Final2
BacTrader.bacrpt.StoredProcParam(11) = SCompra
BacTrader.bacrpt.StoredProcParam(12) = SVenta
BacTrader.bacrpt.StoredProcParam(13) = SRutEntre
BacTrader.bacrpt.StoredProcParam(14) = SRutHasta
BacTrader.bacrpt.StoredProcParam(15) = SCodigoEntre
BacTrader.bacrpt.StoredProcParam(16) = SCodigoHasta
BacTrader.bacrpt.StoredProcParam(17) = SFecha_desde
BacTrader.bacrpt.StoredProcParam(18) = SFecha_hasta
BacTrader.bacrpt.StoredProcParam(19) = SN_OpeDesde
BacTrader.bacrpt.StoredProcParam(20) = SN_OpeHasta
BacTrader.bacrpt.StoredProcParam(21) = STipo_Fecha
BacTrader.bacrpt.StoredProcParam(22) = sAfavor
BacTrader.bacrpt.StoredProcParam(23) = sEncontra
BacTrader.bacrpt.StoredProcParam(24) = STipo_Cliente_Desde
BacTrader.bacrpt.StoredProcParam(25) = STipo_Cliente_Hasta
BacTrader.bacrpt.StoredProcParam(26) = SSector_Economico_Desde
BacTrader.bacrpt.StoredProcParam(27) = SSector_Economico_Hasta
BacTrader.bacrpt.StoredProcParam(28) = STipo_Cartera
BacTrader.bacrpt.StoredProcParam(29) = 0


BacTrader.bacrpt.Connect = CONECCION
BacTrader.bacrpt.Destination = crptToWindow
BacTrader.bacrpt.WindowState = crptMaximized
BacTrader.bacrpt.Action = 1

Exit Sub

ErrArchivo:
If err.Number = 70 Then
   MsgBox "Ya esta abierto el informe debe cerrarlo para una nueva consulta!!!!", vbCritical
Else
   MsgBox "Error inesperado", vbCritical
End If

End Sub

Sub Imprime_Swp()
On Error GoTo ErrArchivo

Call LimpiarCristal

BacTrader.bacrpt.ReportFileName = RptList_Path & "Filtro_Moneda_Extranjera_Swp.rpt"

' Parametros
BacTrader.bacrpt.StoredProcParam(0) = STipo_Select
BacTrader.bacrpt.StoredProcParam(1) = Sproducto
BacTrader.bacrpt.StoredProcParam(2) = Smodalida
BacTrader.bacrpt.StoredProcParam(3) = Sforma_pago_mn
BacTrader.bacrpt.StoredProcParam(4) = Sforma_pago_mx
BacTrader.bacrpt.StoredProcParam(5) = SMoneda_Inicial
BacTrader.bacrpt.StoredProcParam(6) = SValor_Inicial
BacTrader.bacrpt.StoredProcParam(7) = SValor_Final
BacTrader.bacrpt.StoredProcParam(8) = SMoneda_Final
BacTrader.bacrpt.StoredProcParam(9) = SValor_Inicial2
BacTrader.bacrpt.StoredProcParam(10) = SValor_Final2
BacTrader.bacrpt.StoredProcParam(11) = SCompra
BacTrader.bacrpt.StoredProcParam(12) = SVenta
BacTrader.bacrpt.StoredProcParam(13) = SRutEntre
BacTrader.bacrpt.StoredProcParam(14) = SRutHasta
BacTrader.bacrpt.StoredProcParam(15) = SCodigoEntre
BacTrader.bacrpt.StoredProcParam(16) = SCodigoHasta
BacTrader.bacrpt.StoredProcParam(17) = SFecha_desde
BacTrader.bacrpt.StoredProcParam(18) = SFecha_hasta
BacTrader.bacrpt.StoredProcParam(19) = SN_OpeDesde
BacTrader.bacrpt.StoredProcParam(20) = SN_OpeHasta
BacTrader.bacrpt.StoredProcParam(21) = STipo_Fecha
BacTrader.bacrpt.StoredProcParam(22) = sAfavor
BacTrader.bacrpt.StoredProcParam(23) = sEncontra
BacTrader.bacrpt.StoredProcParam(24) = STipo_Cliente_Desde
BacTrader.bacrpt.StoredProcParam(25) = STipo_Cliente_Hasta
BacTrader.bacrpt.StoredProcParam(26) = SSector_Economico_Desde
BacTrader.bacrpt.StoredProcParam(27) = SSector_Economico_Hasta
BacTrader.bacrpt.StoredProcParam(28) = STipo_Cartera

BacTrader.bacrpt.Connect = CONECCION
BacTrader.bacrpt.Destination = crptToPrinter
BacTrader.bacrpt.WindowState = crptMaximized
BacTrader.bacrpt.Action = 1

Exit Sub

ErrArchivo:
If err.Number = 70 Then
   MsgBox "Ya esta abierto el informe debe cerrarlo para una nueva consulta!!!!", vbCritical
Else
   MsgBox "Error inesperado", vbCritical
End If

End Sub

Sub Pantalla_Swp()
On Error GoTo ErrArchivo

Call LimpiarCristal

BacTrader.bacrpt.ReportFileName = RptList_Path & "Filtro_Moneda_Extranjera_Swp.rpt"

' Parametros
BacTrader.bacrpt.StoredProcParam(0) = STipo_Select
BacTrader.bacrpt.StoredProcParam(1) = Sproducto
BacTrader.bacrpt.StoredProcParam(2) = Smodalida
BacTrader.bacrpt.StoredProcParam(3) = Sforma_pago_mn
BacTrader.bacrpt.StoredProcParam(4) = Sforma_pago_mx
BacTrader.bacrpt.StoredProcParam(5) = SMoneda_Inicial
BacTrader.bacrpt.StoredProcParam(6) = SValor_Inicial
BacTrader.bacrpt.StoredProcParam(7) = SValor_Final
BacTrader.bacrpt.StoredProcParam(8) = SMoneda_Final
BacTrader.bacrpt.StoredProcParam(9) = SValor_Inicial2
BacTrader.bacrpt.StoredProcParam(10) = SValor_Final2
BacTrader.bacrpt.StoredProcParam(11) = SCompra
BacTrader.bacrpt.StoredProcParam(12) = SVenta
BacTrader.bacrpt.StoredProcParam(13) = SRutEntre
BacTrader.bacrpt.StoredProcParam(14) = SRutHasta
BacTrader.bacrpt.StoredProcParam(15) = SCodigoEntre
BacTrader.bacrpt.StoredProcParam(16) = SCodigoHasta
BacTrader.bacrpt.StoredProcParam(17) = SFecha_desde
BacTrader.bacrpt.StoredProcParam(18) = SFecha_hasta
BacTrader.bacrpt.StoredProcParam(19) = SN_OpeDesde
BacTrader.bacrpt.StoredProcParam(20) = SN_OpeHasta
BacTrader.bacrpt.StoredProcParam(21) = STipo_Fecha
BacTrader.bacrpt.StoredProcParam(22) = sAfavor
BacTrader.bacrpt.StoredProcParam(23) = sEncontra
BacTrader.bacrpt.StoredProcParam(24) = STipo_Cliente_Desde
BacTrader.bacrpt.StoredProcParam(25) = STipo_Cliente_Hasta
BacTrader.bacrpt.StoredProcParam(26) = SSector_Economico_Desde
BacTrader.bacrpt.StoredProcParam(27) = SSector_Economico_Hasta
BacTrader.bacrpt.StoredProcParam(28) = STipo_Cartera
BacTrader.bacrpt.StoredProcParam(29) = 0 ' ---> Mercado

Call MustraCristal(29)

BacTrader.bacrpt.Connect = CONECCION
BacTrader.bacrpt.Destination = crptToWindow
BacTrader.bacrpt.WindowState = crptMaximized
BacTrader.bacrpt.Action = 1

Exit Sub

ErrArchivo:
If err.Number = 70 Then
   MsgBox "Ya esta abierto el informe debe cerrarlo para una nueva consulta!!!!", vbCritical
Else
   MsgBox err.Description, vbCritical
End If

End Sub

Sub Imprime_Spt()

On Error GoTo ErrArchivo

Call LimpiarCristal

BacTrader.bacrpt.ReportFileName = RptList_Path & "Filtro_Moneda_Extranjera_Bcc.Rpt"

' Parametros
BacTrader.bacrpt.StoredProcParam(0) = STipo_Select
BacTrader.bacrpt.StoredProcParam(1) = Sproducto
BacTrader.bacrpt.StoredProcParam(2) = Sforma_pago_mn
BacTrader.bacrpt.StoredProcParam(3) = Sforma_pago_mx
BacTrader.bacrpt.StoredProcParam(4) = SMoneda_Inicial
BacTrader.bacrpt.StoredProcParam(5) = SValor_Inicial
BacTrader.bacrpt.StoredProcParam(6) = SValor_Final
BacTrader.bacrpt.StoredProcParam(7) = SMoneda_Final
BacTrader.bacrpt.StoredProcParam(8) = SValor_Inicial2
BacTrader.bacrpt.StoredProcParam(9) = SValor_Final2
BacTrader.bacrpt.StoredProcParam(10) = SCompra
BacTrader.bacrpt.StoredProcParam(11) = SVenta
BacTrader.bacrpt.StoredProcParam(12) = SRutEntre
BacTrader.bacrpt.StoredProcParam(13) = SRutHasta
BacTrader.bacrpt.StoredProcParam(14) = SCodigoEntre
BacTrader.bacrpt.StoredProcParam(15) = SCodigoHasta
BacTrader.bacrpt.StoredProcParam(16) = SFecha_desde
BacTrader.bacrpt.StoredProcParam(17) = SFecha_hasta
BacTrader.bacrpt.StoredProcParam(18) = SN_OpeDesde
BacTrader.bacrpt.StoredProcParam(19) = SN_OpeHasta
BacTrader.bacrpt.StoredProcParam(20) = STipo_Fecha
BacTrader.bacrpt.StoredProcParam(21) = STipo_Cliente_Desde
BacTrader.bacrpt.StoredProcParam(22) = STipo_Cliente_Hasta
BacTrader.bacrpt.StoredProcParam(23) = SSector_Economico_Desde
BacTrader.bacrpt.StoredProcParam(24) = SSector_Economico_Hasta

BacTrader.bacrpt.Connect = CONECCION
BacTrader.bacrpt.Destination = crptToPrinter
BacTrader.bacrpt.WindowState = crptMaximized
BacTrader.bacrpt.Action = 1

Exit Sub

ErrArchivo:
If err.Number = 70 Then
   MsgBox "Ya esta abierto el informe debe cerrarlo para una nueva consulta!!!!", vbCritical
Else
   MsgBox err.Description, vbCritical
End If

End Sub

Sub Pantalla_Spt()

On Error GoTo ErrArchivo

Call LimpiarCristal

BacTrader.bacrpt.ReportFileName = RptList_Path & "Filtro_Moneda_Extranjera_Bcc.Rpt"

BacTrader.bacrpt.StoredProcParam(0) = STipo_Select
BacTrader.bacrpt.StoredProcParam(1) = Sproducto '"ARBI" '
BacTrader.bacrpt.StoredProcParam(2) = Sforma_pago_mn
BacTrader.bacrpt.StoredProcParam(3) = Sforma_pago_mx
BacTrader.bacrpt.StoredProcParam(4) = SMoneda_Inicial
BacTrader.bacrpt.StoredProcParam(5) = SValor_Inicial
BacTrader.bacrpt.StoredProcParam(6) = SValor_Final
BacTrader.bacrpt.StoredProcParam(7) = SMoneda_Final
BacTrader.bacrpt.StoredProcParam(8) = SValor_Inicial2
BacTrader.bacrpt.StoredProcParam(9) = SValor_Final2
BacTrader.bacrpt.StoredProcParam(10) = SCompra
BacTrader.bacrpt.StoredProcParam(11) = SVenta
BacTrader.bacrpt.StoredProcParam(12) = SRutEntre
BacTrader.bacrpt.StoredProcParam(13) = SRutHasta
BacTrader.bacrpt.StoredProcParam(14) = SCodigoEntre
BacTrader.bacrpt.StoredProcParam(15) = SCodigoHasta
BacTrader.bacrpt.StoredProcParam(16) = SFecha_desde '"20150101" '
BacTrader.bacrpt.StoredProcParam(17) = SFecha_hasta '"20151231" '
BacTrader.bacrpt.StoredProcParam(18) = SN_OpeDesde
BacTrader.bacrpt.StoredProcParam(19) = SN_OpeHasta
BacTrader.bacrpt.StoredProcParam(20) = STipo_Fecha
BacTrader.bacrpt.StoredProcParam(21) = STipo_Cliente_Desde
BacTrader.bacrpt.StoredProcParam(22) = STipo_Cliente_Hasta
BacTrader.bacrpt.StoredProcParam(23) = SSector_Economico_Desde
BacTrader.bacrpt.StoredProcParam(24) = SSector_Economico_Hasta

BacTrader.bacrpt.Connect = CONECCION
BacTrader.bacrpt.Destination = crptToWindow
BacTrader.bacrpt.WindowState = crptMaximized
BacTrader.bacrpt.Action = 1

Exit Sub

ErrArchivo:
If err.Number = 70 Then
   MsgBox "Ya esta abierto el informe debe cerrarlo para una nueva consulta!!!!", vbCritical
Else
   MsgBox err.Description, vbCritical
End If

End Sub

Private Sub TxtValor_Inicial_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   txtValor_Final.SetFocus
End If
End Sub

Private Sub TxtValor_Inicial2_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   txtValor_Final2.SetFocus
End If
End Sub

