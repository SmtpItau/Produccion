VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_Valorizador 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Valorización de Instrumentos"
   ClientHeight    =   6945
   ClientLeft      =   -510
   ClientTop       =   90
   ClientWidth     =   11295
   Icon            =   "bac_valorizador.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6945
   ScaleWidth      =   11295
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11295
      _ExtentX        =   19923
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "BUSCAR"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "salir"
            Object.ToolTipText     =   "Salir De La Ventana"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3360
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   25
         ImageHeight     =   25
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   4
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_valorizador.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_valorizador.frx":075C
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_valorizador.frx":0A76
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_valorizador.frx":0EC8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   6375
      Left            =   15
      TabIndex        =   13
      Top             =   555
      Width           =   11265
      _ExtentX        =   19870
      _ExtentY        =   11245
      _Version        =   393216
      Style           =   1
      Tabs            =   1
      TabHeight       =   520
      ShowFocusRect   =   0   'False
      BackColor       =   -2147483638
      ForeColor       =   -2147483635
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Valorizador"
      TabPicture(0)   =   "bac_valorizador.frx":1022
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Frm_Descrip"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Frm_Valoriza"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "Frm_Instrumento"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "Frm_Dur"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).ControlCount=   4
      Begin VB.Frame Frm_Dur 
         Caption         =   "Calculos de Duracion y Convexidad"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   915
         Left            =   75
         TabIndex        =   57
         Top             =   5385
         Width           =   11040
         Begin BACControles.TXTNumero txtDur_Mac 
            Height          =   330
            Left            =   1020
            TabIndex        =   58
            Top             =   495
            Width           =   2205
            _ExtentX        =   3889
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
            Text            =   "0.0000000"
            Text            =   "0.0000000"
            Min             =   "0"
            Max             =   "9999999999.9999"
            CantidadDecimales=   "7"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
            SelStart        =   4
         End
         Begin BACControles.TXTNumero txtDur_Mod 
            Height          =   330
            Left            =   3975
            TabIndex        =   59
            Top             =   495
            Width           =   2205
            _ExtentX        =   3889
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
            Text            =   "0.0000000"
            Text            =   "0.0000000"
            Min             =   "0"
            Max             =   "9999999999.9999"
            CantidadDecimales=   "7"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
            SelStart        =   4
         End
         Begin BACControles.TXTNumero txtConvexi 
            Height          =   330
            Left            =   7020
            TabIndex        =   60
            Top             =   495
            Width           =   2205
            _ExtentX        =   3889
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
            Text            =   "0.0000000"
            Text            =   "0.0000000"
            Min             =   "0"
            Max             =   "9999999999.9999"
            CantidadDecimales=   "7"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
            SelStart        =   4
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Duración Macaulay"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Index           =   0
            Left            =   1035
            TabIndex        =   63
            Top             =   270
            Width           =   1515
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Duración Modificada"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Index           =   1
            Left            =   3990
            TabIndex        =   62
            Top             =   270
            Width           =   1650
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Convexidad"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Index           =   2
            Left            =   7020
            TabIndex        =   61
            Top             =   270
            Width           =   960
         End
      End
      Begin VB.Frame Frm_Instrumento 
         BackColor       =   &H8000000B&
         Caption         =   "Instrumentos"
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
         Height          =   615
         Left            =   90
         TabIndex        =   43
         Top             =   345
         Width           =   11050
         Begin VB.ComboBox box_familia 
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
            Left            =   2250
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   180
            Width           =   3015
         End
         Begin VB.ComboBox box_nemo 
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
            Left            =   6720
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   180
            Width           =   4215
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            BackColor       =   &H8000000A&
            Caption         =   "Nemotécnico"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   5460
            TabIndex        =   45
            Top             =   225
            Width           =   1080
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            BackColor       =   &H8000000A&
            Caption         =   "Familia"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   225
            TabIndex        =   44
            Top             =   240
            Width           =   570
         End
      End
      Begin VB.Frame Frm_Valoriza 
         Caption         =   "Valorización"
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
         Height          =   2325
         Left            =   75
         TabIndex        =   31
         Top             =   3045
         Width           =   11050
         Begin BACControles.TXTNumero txt_monto_pag 
            Height          =   315
            Left            =   8670
            TabIndex        =   51
            Top             =   1845
            Width           =   2235
            _ExtentX        =   3942
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
            Text            =   "0.00000000"
            Text            =   "0.00000000"
            Min             =   "-999999999.99"
            Max             =   "999999999.99"
            CantidadDecimales=   "8"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero txt_pre_por 
            Height          =   315
            Left            =   8670
            TabIndex        =   50
            Top             =   195
            Width           =   1455
            _ExtentX        =   2566
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
            Text            =   "0.0000000"
            Text            =   "0.0000000"
            CantidadDecimales=   "7"
            Separator       =   -1  'True
            SelStart        =   4
         End
         Begin BACControles.TXTNumero txt_tasa_int 
            Height          =   315
            Left            =   2160
            TabIndex        =   49
            Top             =   1515
            Width           =   2055
            _ExtentX        =   3625
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
            Text            =   "0.0000000"
            Text            =   "0.0000000"
            Min             =   "0"
            Max             =   "999.9999999"
            CantidadDecimales=   "7"
            Separator       =   -1  'True
            SelStart        =   4
         End
         Begin BACControles.TXTNumero txt_nominal 
            Height          =   315
            Left            =   2160
            TabIndex        =   48
            Top             =   1185
            Width           =   2055
            _ExtentX        =   3625
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
            Text            =   "0.0000"
            Text            =   "0.0000"
            Min             =   "0"
            Max             =   "9999999999.9999"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero lbl_tas_vig 
            Height          =   315
            Left            =   2160
            TabIndex        =   47
            Top             =   525
            Width           =   2055
            _ExtentX        =   3625
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
            Text            =   "0.00000"
            Text            =   "0.00000"
            Min             =   "0"
            Max             =   "999.99999"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTFecha txt_fec_val 
            Height          =   315
            Left            =   2160
            TabIndex        =   6
            Top             =   195
            Width           =   1635
            _ExtentX        =   2884
            _ExtentY        =   556
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
            MaxDate         =   2958465
            MinDate         =   2
            Text            =   "01/01/1900"
         End
         Begin BACControles.TXTNumero txtSpread 
            Height          =   315
            Left            =   2160
            TabIndex        =   52
            Top             =   855
            Width           =   2055
            _ExtentX        =   3625
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
            Text            =   "0.00000"
            Text            =   "0.00000"
            Min             =   "0"
            Max             =   "999.99999"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
         End
         Begin VB.Label lblFactor 
            Caption         =   "lblFactor"
            ForeColor       =   &H00808000&
            Height          =   255
            Left            =   6870
            TabIndex        =   56
            Top             =   555
            Width           =   1665
         End
         Begin VB.Label Label6 
            Caption         =   "%"
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
            Height          =   255
            Left            =   4245
            TabIndex        =   55
            Top             =   600
            Width           =   255
         End
         Begin VB.Label lblpspread 
            Caption         =   "%"
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
            Height          =   255
            Left            =   4245
            TabIndex        =   54
            Top             =   900
            Width           =   255
         End
         Begin VB.Label lblspread 
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
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   200
            TabIndex        =   53
            Top             =   915
            Width           =   585
         End
         Begin VB.Label Label24 
            AutoSize        =   -1  'True
            Caption         =   "Principal"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   6045
            TabIndex        =   8
            Top             =   555
            Width           =   705
         End
         Begin VB.Label Lbl_Mto_Pri 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   315
            Left            =   8670
            TabIndex        =   9
            Top             =   525
            Width           =   2220
         End
         Begin VB.Label Lbl_int_Dev 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   315
            Left            =   8670
            TabIndex        =   10
            Top             =   855
            Width           =   2220
         End
         Begin VB.Label Label30 
            Caption         =   "Interés Devengado"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   6045
            TabIndex        =   11
            Top             =   915
            Width           =   1680
         End
         Begin VB.Label Label26 
            Caption         =   "%"
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
            Height          =   255
            Left            =   10170
            TabIndex        =   46
            Top             =   270
            Width           =   855
         End
         Begin VB.Label lbl_val_venc 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   315
            Left            =   8670
            TabIndex        =   42
            Top             =   1185
            Width           =   2220
         End
         Begin VB.Label txt_por_basilea 
            BorderStyle     =   1  'Fixed Single
            Caption         =   " "
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   315
            Left            =   2160
            TabIndex        =   41
            Top             =   1845
            Width           =   2055
         End
         Begin VB.Label Label15 
            AutoSize        =   -1  'True
            Caption         =   "Fecha de Valorización"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   200
            TabIndex        =   40
            Top             =   240
            Width           =   1785
         End
         Begin VB.Label Label16 
            AutoSize        =   -1  'True
            Caption         =   "Nominal"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   195
            TabIndex        =   39
            Top             =   1230
            Width           =   660
         End
         Begin VB.Label Label17 
            AutoSize        =   -1  'True
            Caption         =   "Tir"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   200
            TabIndex        =   38
            Top             =   1575
            Width           =   225
         End
         Begin VB.Label Label18 
            Caption         =   "Monto a Pagar"
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
            Height          =   255
            Left            =   6045
            TabIndex        =   37
            Top             =   1890
            Width           =   1575
         End
         Begin VB.Label Label19 
            AutoSize        =   -1  'True
            Caption         =   "Tasa Cupón"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   195
            TabIndex        =   36
            Top             =   555
            Width           =   975
         End
         Begin VB.Label Label20 
            Caption         =   "Precio"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   6045
            TabIndex        =   35
            Top             =   240
            Width           =   1455
         End
         Begin VB.Label Label21 
            AutoSize        =   -1  'True
            Caption         =   "Porcentaje Basilea"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   200
            TabIndex        =   34
            Top             =   1890
            Width           =   1515
         End
         Begin VB.Label Label22 
            Caption         =   "Valor Vencimiento"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   6045
            TabIndex        =   33
            Top             =   1230
            Width           =   1695
         End
         Begin VB.Label Label25 
            Caption         =   "%"
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
            Height          =   255
            Left            =   4245
            TabIndex        =   32
            Top             =   1890
            Width           =   255
         End
      End
      Begin VB.Frame Frm_Descrip 
         Caption         =   "Descipción"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   1785
         Left            =   90
         TabIndex        =   14
         Top             =   930
         Width           =   11070
         Begin BACControles.TXTFecha txt_fec_vcto 
            Height          =   330
            Left            =   2280
            TabIndex        =   4
            Top             =   570
            Width           =   1695
            _ExtentX        =   2990
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
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "22/11/2001"
         End
         Begin BACControles.TXTFecha txt_fec_emi 
            Height          =   330
            Left            =   2280
            TabIndex        =   3
            Top             =   210
            Width           =   1695
            _ExtentX        =   2990
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
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "22/11/2001"
         End
         Begin VB.ComboBox box_base 
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
            Left            =   2280
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   930
            Visible         =   0   'False
            Width           =   1680
         End
         Begin VB.ComboBox box_moneda 
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
            Left            =   8655
            Style           =   2  'Dropdown List
            TabIndex        =   7
            Top             =   930
            Visible         =   0   'False
            Width           =   2265
         End
         Begin VB.Label Label23 
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
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   200
            TabIndex        =   12
            Top             =   975
            Visible         =   0   'False
            Width           =   405
         End
         Begin VB.Label lbl_pais 
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
            ForeColor       =   &H8000000D&
            Height          =   285
            Left            =   11670
            TabIndex        =   30
            Top             =   2640
            Visible         =   0   'False
            Width           =   3000
         End
         Begin VB.Label lbl_rut 
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H8000000D&
            Height          =   285
            Left            =   11670
            TabIndex        =   29
            Top             =   2640
            Visible         =   0   'False
            Width           =   2655
         End
         Begin VB.Label lbl_cupones 
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   330
            Left            =   8655
            TabIndex        =   28
            Top             =   1290
            Width           =   1215
         End
         Begin VB.Label lbl_ciudad 
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
            ForeColor       =   &H8000000D&
            Height          =   285
            Left            =   11670
            TabIndex        =   27
            Top             =   2640
            Visible         =   0   'False
            Width           =   2655
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "Fecha de Vencimiento"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   200
            TabIndex        =   26
            Top             =   615
            Width           =   1830
         End
         Begin VB.Label Label8 
            Caption         =   "Ciudad"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   11670
            TabIndex        =   25
            Top             =   2640
            Visible         =   0   'False
            Width           =   1455
         End
         Begin VB.Label Label10 
            AutoSize        =   -1  'True
            Caption         =   "Nº de Cupones"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   6015
            TabIndex        =   24
            Top             =   1335
            Width           =   1215
         End
         Begin VB.Label Label13 
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
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   6015
            TabIndex        =   23
            Top             =   975
            Visible         =   0   'False
            Width           =   660
         End
         Begin VB.Label Label12 
            AutoSize        =   -1  'True
            Caption         =   "Tipo de Tasa"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   200
            TabIndex        =   22
            Top             =   1335
            Width           =   1050
         End
         Begin VB.Label Label11 
            Caption         =   "Rut Ficticio"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   11670
            TabIndex        =   21
            Top             =   2640
            Visible         =   0   'False
            Width           =   1095
         End
         Begin VB.Label Label9 
            AutoSize        =   -1  'True
            Caption         =   "Período de Vencimiento"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   6015
            TabIndex        =   20
            Top             =   615
            Width           =   1995
         End
         Begin VB.Label Label7 
            Caption         =   "País"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   11670
            TabIndex        =   19
            Top             =   2640
            Visible         =   0   'False
            Width           =   495
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Fecha de Emisión"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   210
            Left            =   200
            TabIndex        =   18
            Top             =   255
            Width           =   1440
         End
         Begin VB.Label lbl_descrip 
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   330
            Left            =   6090
            TabIndex        =   17
            Top             =   210
            Width           =   4905
         End
         Begin VB.Label lbl_periodo 
            BorderStyle     =   1  'Fixed Single
            Caption         =   " "
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   330
            Left            =   8655
            TabIndex        =   16
            Top             =   570
            Width           =   2265
         End
         Begin VB.Label lbl_tip_tasa 
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   330
            Left            =   2265
            TabIndex        =   15
            Top             =   1290
            Width           =   2655
         End
      End
   End
End
Attribute VB_Name = "Bac_Valorizador"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public Formula As String
Dim Opcion As Integer

Dim arreglo_formulas(100, 10)
Dim Linea_Formula As Integer

Dim Arreglo_Variables(100, 6)
Dim Arreglo_Operadores(100, 6)
Dim Arreglo_Funciones(100, 6)


Dim FilaSeleccionada   As Integer
Dim PosTexto           As Integer
Dim PosFormula         As Integer
Dim ModCal             As Integer
Dim Valorizar          As Integer

Dim seriadoSN As String         'MAP 20160803
Dim idInternacionalSN As String 'MAP 20160803
Dim tipoPrecioPrcSN As String      'MAP 20160803
Dim NombreFamilia As String     'MAP 20160803
Dim BaseFamilia As String       'MAP 20160803
Dim UsaBaseFamiliaSN As String    'MAP 20160803
Const Btn_Buscar = 1
Const Btn_Limpiar = 2
Const Btn_Salir = 3#

Dim TR
Dim TE
Dim TV
Dim TT
Dim BA
Dim BF
Dim NOM
Dim MT
Dim VV
Dim VP
Dim PVP
Dim VAN
Dim FP  As Date
Dim FE  As Date
Dim FV  As Date
Dim FU  As Date
Dim FX  As Date
Dim FC  As Date
Dim CI
Dim CT
Dim INDEV
Dim PRINC
Dim FIP  As Date
Dim INCTR
Dim CAP
Dim SPREAD As Double

      
Function buscar_datos_nemo()

    Dim Datos()
    Dim tip_tasa
    Dim Basilea
    Dim Periodo
    envia = Array()
 
    AddParam envia, Trim(Mid(box_nemo.Text, 1, 20))
    AddParam envia, Trim(Mid(box_nemo.Text, 21, 10))
    If Bac_Sql_Execute("SVC_GEN_AYD_SER", envia) Then
    
        Do While Bac_SQL_Fetch(Datos)
            txt_fec_emi.Text = Format(Datos(9), "dd/mm/yyyy")
            txt_fec_vcto.Text = Format(Datos(10), "dd/mm/yyyy")
            lbl_cupones.Caption = Datos(8)
            lbl_descrip.Caption = Datos(3)
            If Datos(6) = "1" Then
                txt_por_basilea.Caption = "30"
            ElseIf Datos(6) = "2" Then
                txt_por_basilea.Caption = "70"
            End If
'           Lbl_Tas_Vig.Text = Format(Lbl_Tas_Vig.Text, "0.0%")
            lbl_tas_vig.Text = CDbl(Datos(14)) + CDbl(Datos(20))
            
            txtspread.Text = CDbl(Datos(20))
            
            SPREAD = CDbl(Datos(20))
            
            BA = CDbl(Datos(17))
            Dim i
            i = 0
            For i = 0 To box_base.ListCount - 1
                box_base.ListIndex = i
                If box_base.ItemData(box_base.ListIndex) = BA Then
                    Exit For
                End If
                box_base.ListIndex = -1
            Next
            
        Loop
    End If
    
    Call llena_datos_tip_tasa(Val(Datos(5)))
    Call llena_datos_periodo(Val(Datos(7)))
    
    Call enable_false
    Call enable_true
    
End Function
Function Clear_Objetos()
    
    box_familia.ListIndex = -1
    box_nemo.ListIndex = -1
    txt_fec_emi.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_fec_vcto.Text = Format(gsBac_Fecx, "DD/MM/YYYY") '--jcamposd COP gsBac_Fecp
    txt_fec_val.Text = Format(gsBac_Fecp, "DD/MM/YYYY")

    
    
    lbl_pais.Caption = ""
    lbl_descrip.Caption = ""
    lbl_periodo.Caption = ""
    lbl_ciudad.Caption = ""
    lbl_rut.Caption = ""
    lbl_tip_tasa.Caption = ""
    txt_nominal.Text = ""
    Me.lbl_int_dev.Caption = ""
    Me.lblFactor.Caption = ""
    Me.Lbl_Mto_Pri.Caption = ""


    txt_monto_pag.Text = ""
    txt_pre_por.Text = ""
    txt_tasa_int.Text = ""
    lbl_tas_vig.Text = ""
    txt_por_basilea.Caption = ""
    lbl_val_venc.Caption = ""
    
    box_moneda.ListIndex = -1
    box_base.ListIndex = -1
    
    txtDur_Mac.Text = 0
    txtDur_Mod.Text = 0
    txtConvexi.Text = 0
    
    txtDur_Mac.Enabled = False
    txtDur_Mod.Enabled = False
    txtConvexi.Enabled = False
    Label26.Caption = "%"
    Label26.FontSize = 9.75
    
End Function
Function enable_false()

    Frm_Valoriza.Enabled = False
    If box_familia.ListIndex = 0 Then
        txt_fec_emi.Enabled = False
        txt_fec_vcto.Enabled = False
        lbl_tas_vig.Enabled = False
        txtspread.Enabled = False
    End If
End Function

Function enable_true()
    Frm_Valoriza.Enabled = True
End Function

Function Func_Limpiar()
    
        Dim i As Integer
    
        
        Call Clear_Objetos
        
        Toolbar1.Buttons(Btn_Buscar).Enabled = True
    
        box_familia.Enabled = True
        box_nemo.Enabled = True
        
        
        frm_descrip.Enabled = False
        Frm_Valoriza.Enabled = False
     
End Function

Sub Func_Valorizar(ModCal As Integer)

    Dim Datos()

    If Not IsDate(txt_fec_val.Text) Then
        Exit Sub
    End If
    
    If CDbl(txt_nominal.Text) = 0 Then
        Exit Sub
    End If
    
    If ModCal = 1 And CDbl(txt_pre_por.Text) = 0 Then
        Exit Sub
    End If
    
   ' If ModCal = 2 And CDbl(txt_tasa_int.Text) = 0 Then
   '     Exit Sub
   ' End If
    
    '+++COLTES jcamposd se homologa contra frm bac_formulas_prueba.frm
    '   MAP 20160804 Dejar valorizar con tasa cero
    If box_familia.ItemData(box_familia.ListIndex) <> 2004 And box_familia.ItemData(box_familia.ListIndex) <> 2005 Then
         If ModCal = 2 And CDbl(txt_tasa_int.Text) = 0 Then
            Exit Sub
        End If
    End If
    '---COLTES, jcamposd
    
    If ModCal = 3 And CDbl(txt_monto_pag.Text) = 0 Then
        Exit Sub
    End If
    
    
    If Not IsDate(txt_fec_emi.Text) Then
        Exit Sub
    End If
    
    
    If Not IsDate(txt_fec_vcto.Text) Then
        Exit Sub
    End If
    
    If Not IsDate(txt_fec_vcto.Text) Then
        Exit Sub
    End If

    If CDbl(lbl_tas_vig.Text) = 0 Then
        Exit Sub
    End If

    
    Screen.MousePointer = 11
    
    
    NOM = CDbl(txt_nominal.Text)
    MT = CDbl(txt_monto_pag.Text)
    TR = CDbl(txt_tasa_int.Text)
    PVP = CDbl(txt_pre_por.Text)
    '+++COLTES jcamposd se homologa contra frm bac_formulas_prueba.frm
    TE = CDbl(lbl_tas_vig.Text)
    TV = CDbl(lbl_tas_vig.Text)
    'TE = CDbl(lbl_tas_vig.Text) - SPREAD
    'TV = CDbl(lbl_tas_vig.Text) - SPREAD
    '---COLTES jcamposd se homologa contra frm bac_formulas_prueba.frm
    TT = 0
    BF = 0
    VV = 0
    VP = 0
    VAN = 0
    FP = txt_fec_val.Text
    FE = txt_fec_emi.Text
    FV = txt_fec_vcto.Text
    FC = txt_fec_val.Text
    FP = Format(FP, "DD/MM/YYYY")
    FE = Format(FE, "DD/MM/YYYY")
    FV = Format(FV, "DD/MM/YYYY")
    FC = Format(FC, "DD/MM/YYYY")
    INDEV = 0
    PRINC = 0
    FIP = Format(FIP, "DD/MM/YYYY")
    INCTR = 0
    CAP = 0
    
    'SPREAD = CDbl(txt_Spread.Text)
    'Dur_Mac = 0#
    'Dur_Mod = 0#
    'Convexi = 0#
    
    
    envia = Array()
    AddParam envia, txt_fec_val.Text
    AddParam envia, " "
    AddParam envia, ModCal
    AddParam envia, box_familia.ItemData(box_familia.ListIndex)
    
    If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
       AddParam envia, Trim(Mid(box_nemo.Text, 1, 20))
    Else
       AddParam envia, Trim(box_familia.Text)
    End If

    AddParam envia, txt_fec_vcto.Text
    AddParam envia, TR
    AddParam envia, TE
    AddParam envia, TV
    AddParam envia, TT
    AddParam envia, BA
    AddParam envia, BF
    AddParam envia, NOM
    AddParam envia, MT
    AddParam envia, VV
    AddParam envia, VP
    AddParam envia, PVP
    AddParam envia, VAN
    AddParam envia, FP
    AddParam envia, FE
    AddParam envia, FV
    AddParam envia, FU
    AddParam envia, FX
    AddParam envia, FC
    AddParam envia, CI
    AddParam envia, CT
    AddParam envia, INDEV
    AddParam envia, PRINC
    AddParam envia, FIP
    
    AddParam envia, CAP
    AddParam envia, INCTR
    AddParam envia, SPREAD
        
    'AddParam envia, INCTR
    'AddParam envia, CAP
    
    AddParam envia, "S"
    AddParam envia, box_moneda.ItemData(box_moneda.ListIndex)
    
    Dim num
    
    If Bac_Sql_Execute("SVC_PRC_VAL_INS", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            txt_tasa_int.Text = Round(CDbl(Datos(1)), 7)
            lbl_tas_vig.Text = CDbl(Datos(2))
            txt_monto_pag.Text = Format(CDbl(txt_monto_pag.Text), "###,###,###,###,##0.0000")
            '+++jcamposd COP, para los cop muestra el valor final
            If box_familia.ItemData(box_familia.ListIndex) = 2006 Then
                txt_monto_pag.Text = Format(CDbl(Datos(9)), "###,###,###,##0.0000") '+++jcamposd debe mostrar monto final. Round(CDbl(Datos(8)), 6)
            Else
                txt_monto_pag.Text = Format(CDbl(Datos(8)), "###,###,###,###,##0.0000")
            End If
            '---jcamposd COP
            txt_pre_por.Text = Round(CDbl(Datos(11)), 7)
            txt_fec_val.Text = Format(Datos(13), "DD/MM/YYYY")
            txt_fec_emi.Text = Format(Datos(14), "DD/MM/YYYY")
            txt_fec_vcto.Text = Format(Datos(15), "DD/MM/YYYY")
            lbl_int_dev.Caption = Format(CDbl(Datos(21)), "###,###,###,###,##0.0000")
            lbl_val_venc.Caption = Format(CDbl(Datos(9)), "###,###,###,###,##0.0000")
            Lbl_Mto_Pri.Caption = Format(CDbl(Datos(22)), "###,###,###,###,##0.0000")
            If CDbl(Datos(44)) <> 1 Then
                lblFactor.Caption = "(Factor " & Format(CDbl(Datos(44)), "#0.000000000") & ")"
            End If
            txtDur_Mac.Text = CDbl(Datos(45))
            txtDur_Mod.Text = CDbl(Datos(46))
            txtConvexi.Text = Format((Datos(47) / 100#), "#,####,###,###,##0.0000")
        Loop
   End If


    Screen.MousePointer = 0

End Sub

Function guardar_datos()
Dim E
Dim i
Dim Datos()

    envia = Array()

    AddParam envia, box_familia.ItemData(box_familia.ListIndex)
    
    If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
        AddParam envia, Trim(Mid(box_nemo.Text, 1, 20))
        AddParam envia, txt_fec_vcto.Text
    Else
        AddParam envia, box_familia.Text
        AddParam envia, ""
    End If
    
    If Bac_Sql_Execute("SVA_FMU_ELI_FOR", envia) Then
        Do While Bac_SQL_Fetch(Datos)
        Loop
    End If
    
    E = 0
    For i = 1 To 100
    
        If arreglo_formulas(i, 2) <> "" Then
        
            envia = Array()
            AddParam envia, box_familia.ItemData(box_familia.ListIndex)
            
            If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
                AddParam envia, Trim(Mid(box_nemo.Text, 1, 20))
                AddParam envia, txt_fec_vcto.Text
            Else
                AddParam envia, box_familia.Text
                AddParam envia, ""
            End If
            AddParam envia, arreglo_formulas(i, 2)
            AddParam envia, arreglo_formulas(i, 3)
            AddParam envia, arreglo_formulas(i, 4)
            AddParam envia, arreglo_formulas(i, 5)
            AddParam envia, arreglo_formulas(i, 6)
            If Trim(arreglo_formulas(i, 7)) = "" Then
                AddParam envia, " "
            Else
                AddParam envia, arreglo_formulas(i, 7)
            End If
            
            If Trim(arreglo_formulas(i, 8)) = "" Then
                AddParam envia, " "
            Else
                AddParam envia, arreglo_formulas(i, 8)
            End If
            If Trim(arreglo_formulas(i, 9)) = "" Then
                AddParam envia, " "
            Else
                AddParam envia, arreglo_formulas(i, 9)
            End If
            
            If Trim(arreglo_formulas(i, 10)) = "" Then
                AddParam envia, " "
            Else
                AddParam envia, arreglo_formulas(i, 10)
            End If
    
    
            If Bac_Sql_Execute("SVA_FMU_GRB_DAT", envia) Then
                Do While Bac_SQL_Fetch(Datos)
                Loop
            End If
        End If
        
    Next
    
    MsgBox "Información Grabada Correctamente", vbInformation, gsBac_Version
    
    
End Function
Function llena_combo_base()
    box_base.Clear
    box_base.AddItem "30"
    box_base.ItemData(box_base.NewIndex) = 30
    box_base.AddItem "360"
    box_base.ItemData(box_base.NewIndex) = 360
    box_base.AddItem "365"
    box_base.ItemData(box_base.NewIndex) = 365
    box_base.AddItem "252"                      'MAP 20160804
    box_base.ItemData(box_base.NewIndex) = 252  'MAP 20160804
End Function

Function llena_combo_familia()
    Dim SQL As String
    Dim Datos()
    
    box_familia.Clear
        
    If Bac_Sql_Execute("SVC_GEN_FAM_INS") Then
        Do While Bac_SQL_Fetch(Datos)
            box_familia.AddItem Datos(2)
            box_familia.ItemData(box_familia.NewIndex) = Val(Datos(1))
            
        Loop
        
    End If

End Function


Function llena_combo_nemotecnico()
Dim SQL As String
    Dim Datos()
    
    box_nemo.Clear
        
    If Bac_Sql_Execute("SVC_GEN_LEE_SER") Then
        Do While Bac_SQL_Fetch(Datos)
            box_nemo.AddItem Datos(2) & Space(20 - Len(Datos(2))) & Format(Datos(3), "dd/mm/yyyy")
            box_nemo.ItemData(box_nemo.NewIndex) = Val(Datos(1))
            
        Loop
        
    End If

End Function




Function llena_datos_periodo(dat)
Dim Datos()
    envia = Array()
    AddParam envia, dat
    If Bac_Sql_Execute("SVC_FMU_LEE_PER", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            lbl_periodo.Caption = Datos(2)
        Loop
    End If
End Function

Function llena_datos_tip_tasa(dat)
    Dim Datos()
    envia = Array()
    AddParam envia, dat
    If Bac_Sql_Execute(" SVC_GEN_TIP_TAS", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            lbl_tip_tasa.Caption = Datos(2)
        Loop
    End If
End Function

Function llena_combo_monedas()
    Dim Datos()
    Dim i
    i = 0
    box_moneda.Clear
    If Bac_Sql_Execute("SVC_OPE_COD_MON") Then
        Do While Bac_SQL_Fetch(Datos)
            box_moneda.AddItem Datos(2)
            box_moneda.ItemData(box_moneda.NewIndex) = Val(Datos(1))
        Loop
        
        '--+++jcamposd para selecionar monedas (COP)
        Dim codMonedaSel As Integer
        
        If box_familia.ItemData(box_familia.ListIndex) = 2006 Then
            codMonedaSel = 129
        Else
            codMonedaSel = 13
        End If
        '-----jcamposd para selecionar monedas (COP)
        
        
        For i = 0 To box_moneda.ListCount - 1
            box_moneda.ListIndex = i
            If box_moneda.ItemData(box_moneda.ListIndex) = codMonedaSel Then '--+++jcamposd 13 Then
                Exit For
            End If
            box_moneda.ListIndex = -1
        Next
    End If
End Function

Private Sub box_base_Click()
    If box_familia.ListIndex <> 0 And box_base.ListIndex <> -1 Then
        BA = CDbl(box_base.Text)
    End If
End Sub


Private Sub box_base_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub box_familia_Click()

    If box_familia.ListIndex = -1 Then
        Exit Sub
    End If

    If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
        
        box_nemo.Enabled = True
        Call llena_combo_nemotecnico
        
        box_nemo.SetFocus
        
    ElseIf box_familia.ItemData(box_familia.ListIndex) = 2001 Then
        
        box_nemo.Enabled = False
        box_nemo.Clear
        
    ElseIf box_familia.ItemData(box_familia.ListIndex) = 2002 Then
        
        box_nemo.Enabled = False
        box_nemo.Clear
        
    End If
    
    Call Definicion_Familia(box_familia.ItemData(box_familia.ListIndex))

End Sub



Private Sub buscar_datos()
    Dim i
    i = 0
    If box_familia.ListIndex = -1 Then
        MsgBox "No ha Selecccionado Familia", vbExclamation, gsBac_Version
        Exit Sub
    End If


    If box_familia.ListIndex = 0 Then
    
        If box_nemo.ListIndex = -1 Then
            MsgBox "No ha Selecccionado Instrumento", vbExclamation, gsBac_Version
            Exit Sub
        End If
        box_base.Enabled = False
        Call llena_combo_monedas
        Call buscar_datos_nemo
        box_moneda.Enabled = True
'        box_moneda.SetFocus
        
 
    ElseIf box_familia.ListIndex > 0 Then
        If box_familia.ItemData(box_familia.ListIndex) = 2004 Then
           Label26.Caption = "x Tít."
           Label26.FontSize = 3.75
        End If
        If box_familia.ItemData(box_familia.ListIndex) = 2005 Then
           Label26.Caption = "x Tít."
           Label26.FontSize = 3.75
        End If
        txt_fec_emi.Enabled = True
        txt_fec_vcto.Enabled = True
        frm_descrip.Enabled = True
        box_base.Enabled = True
        If UsaBaseFamiliaSN = "S" Then
           box_base.Enabled = False
        Else
           box_base.Enabled = True
                End If
         Call llena_combo_monedas
'            For i = 0 To box_base.ListCount - 1
'                box_base.ListIndex = i
'                If box_base.ItemData(box_base.ListIndex) = 360 Then
'                    Exit For
'                End If
'                box_base.ListIndex = -1
'            Next
        txt_fec_emi.SetFocus
    ElseIf box_familia.ListIndex = 2 Then
        
        box_nemo.Enabled = False
        txt_fec_emi.Enabled = True
        txt_fec_vcto.Enabled = True
        frm_descrip.Enabled = True
        box_base.Enabled = True

        For i = 0 To box_base.ListCount - 1
            box_base.ListIndex = i
            If box_base.ItemData(box_base.ListIndex) = 360 Then
                Exit For
            End If
            box_base.ListIndex = -1
        Next
        Call llena_combo_monedas
        txt_fec_emi.SetFocus
    End If
    
   
    box_familia.Enabled = False
    box_nemo.Enabled = False
    frm_descrip.Enabled = True
    Frm_Valoriza.Enabled = True
    
   
    Toolbar1.Buttons(Btn_Buscar).Enabled = False
End Sub


Private Sub box_familia_LostFocus()

'    If box_familia.ListIndex <> -1 Then
'        If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
'            Call llena_combo_nemotecnico
'        End If
'    End If
'    If box_familia.ListIndex > 0 And txt_fec_emi.Enabled = True Then
'        txt_fec_emi.SetFocus
'    End If
    
End Sub


Private Sub box_moneda_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Frm_Valoriza.Enabled = True
        SendKeys "{TAB}"
    End If
End Sub


Private Sub box_nemo_Click()

'    If box_familia.ListIndex = 0 Then
'        Call buscar_datos_nemo
'
'    End If
'
'    txt_fec_val.Text = Format(Date, "dd/mm/yyyy")

End Sub

Function Definicion_Familia(Codigo_Familia As Integer)
    Dim Datos()
    envia = Array()
    AddParam envia, Codigo_Familia
    If Bac_Sql_Execute("BacParamSuda.dbo.SP_CONSULTA_DATOS_FAMILIA_BONOS_EXT", envia) Then
        Do While Bac_SQL_Fetch(Datos)
        
           'Txt_rut_Emi.Text = Datos(9)
           'txt_cod_emi.Text = Datos(10)
           'lbl_emisor.Caption = Datos(11)
           'lbl_pais.Caption = Datos(12)
           'Call BuscaIDCombo(box_mon_emi, CStr(Datos(5)))
           'Call BuscaIDCombo(BOX_MON_PAG, CStr(Datos(7)))
           'Call box_mon_pag_LostFocus   ' MAP 20160802 Para evaluar el combo de monedas
           Let seriadoSN = Datos(13)         'MAP 20160803
           Let idInternacionalSN = Datos(14) 'MAP 20160803
           Let tipoPrecioPrcSN = Datos(15)     'MAP 20160803
           Let NombreFamilia = Datos(2)     'MAP 20160803
           Let BaseFamilia = Datos(4)           'MAP 20160804
           Let UsaBaseFamiliaSN = Datos(19)  'MAP 20160804
        

        Loop
    End If
    
    lbl_tas_vig.Text = "1"  '' MAP 20160802 La idea es que no se requiera el valor
                            '' Poner valor chico sin decimales
    Call Func_Valorizar(ModCal)
    Label20.Caption = IIf(tipoPrecioPrcSN = "S", "Precio Porcentual", "Precio")
    Label26.Caption = IIf(tipoPrecioPrcSN = "S", "%", "x Tit.")

    Call llena_combo_base
    Call BuscaIDCombo(box_base, BaseFamilia)
  
    
End Function
Private Sub box_nemo_KeyPress(KeyAscii As Integer)
'    If KeyAscii = 13 And box_familia.ListIndex = 0 Then
'        Call enable_false
'        box_moneda.SetFocus
'    End If
End Sub

Private Sub Form_Activate()

    llena_combo_base

End Sub

Private Sub Form_Load()

    Move 0, 0

    Opcion = 1
    PosTexto = 0
    ModCal = 2
    Valorizar = False
    
    Dim i As Integer
    
    PosFormula = 1
    
    Call llena_combo_familia
    Call enable_false
    
    txt_fec_val.Text = Format(Date, "dd/mm/yyyy")
    
    txt_pre_por.Text = 0
    
    Call Func_Limpiar
    TR = 0
    TE = 0
    TV = 0
    TT = 0
    BA = 0
    BF = 0
    NOM = 0
    MT = 0
    VV = 0
    VP = 0
    PVP = 0
    VAN = 0
    CI = 0
    CT = 0
    INDEV = 0
    INCTR = 0
    CAP = 0

    
End Sub
Private Sub lbl_tas_vig_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
        SendKeys "{TAB}"
        Valorizar = True
    End If
End Sub


Private Sub Lbl_Tas_Vig_LostFocus()
    If Valorizar = True Then
        Valorizar = False
        Call Func_Valorizar(ModCal)
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case UCase(Button.Key)
        Case "BUSCAR"
                Call buscar_datos
                If frm_descrip.Enabled = True Then
                    txt_fec_val.Text = Format(txt_fec_val.Text, "DD/MM/YYYY")
                    txt_fec_val.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
                End If
        Case "LIMPIAR"
            Call Func_Limpiar
            Call Clear_Objetos
            box_familia.SetFocus
        Case "SALIR"
            Unload Me
                    
    End Select
    
    
End Sub


Private Sub txt_fec_emi_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    Else
        Valorizar = True
    End If
End Sub


Private Sub txt_fec_emi_LostFocus()
    If Valorizar = True Then
        Call Func_Valorizar(ModCal)
        Valorizar = False
    End If

End Sub

Private Sub txt_fec_val_GotFocus()
    txt_fec_val.Tag = txt_fec_val.Text
End Sub

Private Sub txt_fec_val_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        KeyAscii = 0
        txt_nominal.SetFocus
    Else
        Valorizar = True
    End If
End Sub


Private Sub txt_fec_val_LostFocus()
    If Valorizar = True Then
        Call Func_Valorizar(ModCal)
        Valorizar = False
    End If
End Sub


Private Sub txt_fec_vcto_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    Else
        Valorizar = True
    End If
End Sub


Private Sub txt_fec_vcto_LostFocus()
    Dim NemoArtificial As String
    '  if box_familia.ItemData(box_familia.ListIndex)
    If box_familia.ListIndex <> -1 Then
       If seriadoSN = "N" And idInternacionalSN = "S" Then
          Let NemoArtificial = "BRLTF20160907"
          Let NemoArtificial = NombreFamilia + Format(txt_fec_vcto.Text, "yyyymmdd")
          'Let box_nemo.Text = IIf(seriadoSN = "S", box_nemo.Text, NemoArtificial)
          box_nemo.AddItem NemoArtificial
          box_nemo.ItemData(box_nemo.NewIndex) = 99
          box_nemo.ListIndex = box_nemo.ListCount - 1
       End If
    End If
    If Valorizar = True Then
        Call Func_Valorizar(ModCal)
        Valorizar = False
    End If

End Sub

Private Sub Txt_Monto_Pag_GotFocus()
    txt_monto_pag.Tag = txt_monto_pag.Text
End Sub

Private Sub txt_monto_pag_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
        txt_nominal.SetFocus
        Valorizar = True   'Map... al parecer no funciona para otros papeles
    End If
End Sub


Private Sub txt_monto_pag_LostFocus()
    If Valorizar = True Then
        Valorizar = False
        ModCal = 3
        Call Func_Valorizar(ModCal)
    End If
End Sub


Private Sub Txt_Nominal_GotFocus()

    txt_nominal.Tag = txt_nominal.Text
    
End Sub

Private Sub txt_nominal_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        KeyAscii = 0
        txt_tasa_int.SetFocus
        Valorizar = True
    End If
End Sub

Private Sub Txt_Nominal_LostFocus()
'   If Txt_Nominal.Tag = Txt_Nominal.Text Then
    If Valorizar = True Then
        Call Func_Valorizar(ModCal)
        Valorizar = False
    End If

End Sub


Private Sub Txt_Pre_Por_GotFocus()

    txt_pre_por.Tag = txt_pre_por.Text
    
End Sub

Private Sub txt_pre_por_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
        txt_monto_pag.SetFocus
        Valorizar = True
    End If

End Sub

Private Sub txt_pre_por_LostFocus()
    If Valorizar = True Then
        Valorizar = False
        ModCal = 1
        Call Func_Valorizar(ModCal)
    End If
End Sub


Private Sub Txt_tasa_int_GotFocus()

    txt_tasa_int.Tag = txt_tasa_int.Text

End Sub

Private Sub txt_tasa_int_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        KeyAscii = 0
        txt_pre_por.SetFocus
        Valorizar = True
    End If
End Sub


Private Sub txt_tasa_int_LostFocus()
    If Valorizar = True Then
        Valorizar = False
        ModCal = 2
        Call Func_Valorizar(ModCal)
    End If
End Sub
Private Sub BuscaIDCombo(COMBO As ComboBox, Valor As String)

    Dim Contador As Integer
    Contador = 0

    
    Do While Contador <= COMBO.ListCount - 1
        
       COMBO.ListIndex = Contador
       
       If COMBO.ItemData(COMBO.ListIndex) = Valor Then
           Exit Do
       End If
              
       Contador = Contador + 1
       
    Loop
    
    If Contador = COMBO.ListCount Then
       COMBO.ListIndex = 0
    End If


End Sub
