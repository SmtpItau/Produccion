VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_Formulas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Fórmulas y Valorización"
   ClientHeight    =   6795
   ClientLeft      =   210
   ClientTop       =   675
   ClientWidth     =   11595
   Icon            =   "bac_formulas_prueba.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6795
   ScaleWidth      =   11595
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11595
      _ExtentX        =   20452
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "LIMPIAR"
            Object.ToolTipText     =   "Limpiar Pantalla"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar Datos"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Impresion de Formulas"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "salir"
            Object.ToolTipText     =   "Salir De La Ventana"
            ImageIndex      =   12
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3090
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   32
         ImageHeight     =   32
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   18
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":0624
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":0A76
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":0EC8
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":11E2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":14FC
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":194E
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":1AA8
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":1EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":234C
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":2666
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":2980
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":2ADA
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":2F2C
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":337E
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":3698
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":39B2
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_formulas_prueba.frx":3CCC
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   6135
      Left            =   0
      TabIndex        =   17
      Top             =   660
      Width           =   11580
      _ExtentX        =   20426
      _ExtentY        =   10821
      _Version        =   393216
      Style           =   1
      TabHeight       =   520
      ShowFocusRect   =   0   'False
      BackColor       =   -2147483638
      ForeColor       =   -2147483635
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Valorización"
      TabPicture(0)   =   "bac_formulas_prueba.frx":411E
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Frm_Dur"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Frm_Descrip"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "Frm_Valoriza"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "Frm_Instrumento"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).ControlCount=   4
      TabCaption(1)   =   "Tipo Fórmula"
      TabPicture(1)   =   "bac_formulas_prueba.frx":413A
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Frame6"
      Tab(1).ControlCount=   1
      TabCaption(2)   =   "Fórmula"
      TabPicture(2)   =   "bac_formulas_prueba.frx":4156
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "Frame9"
      Tab(2).Control(1)=   "Frame4"
      Tab(2).Control(2)=   "For_Frm_Variables"
      Tab(2).Control(3)=   "For_Frm_Operaciones"
      Tab(2).Control(4)=   "For_Frm_Funciones"
      Tab(2).ControlCount=   5
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
         Height          =   720
         Left            =   225
         TabIndex        =   68
         Top             =   345
         Width           =   11300
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
            Top             =   250
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
            Top             =   250
            Width           =   4215
         End
         Begin VB.Label Label4 
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
            Height          =   255
            Left            =   5460
            TabIndex        =   70
            Top             =   300
            Width           =   1455
         End
         Begin VB.Label Label1 
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
            Height          =   255
            Left            =   150
            TabIndex        =   69
            Top             =   300
            Width           =   585
         End
      End
      Begin VB.Frame Frame9 
         Caption         =   "Fórmulas Anteriormente Creadas"
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
         Height          =   2490
         Left            =   -74925
         TabIndex        =   54
         Top             =   345
         Width           =   11400
         Begin VB.CommandButton For_Cmd_Remove 
            Caption         =   " Remover Línea"
            Height          =   300
            Left            =   135
            TabIndex        =   67
            Top             =   2130
            Width           =   1530
         End
         Begin VB.CommandButton For_Cmd_Agrega 
            Caption         =   "Agregar Línea"
            Height          =   300
            Left            =   8070
            TabIndex        =   66
            Top             =   2130
            Width           =   1530
         End
         Begin VB.CommandButton For_Cmd_Editar 
            Caption         =   "Editar Fórmula"
            Height          =   300
            Left            =   9705
            TabIndex        =   65
            Top             =   2130
            Width           =   1530
         End
         Begin MSFlexGridLib.MSFlexGrid For_Grilla 
            Height          =   1875
            Left            =   90
            TabIndex        =   55
            Top             =   240
            Width           =   11205
            _ExtentX        =   19764
            _ExtentY        =   3307
            _Version        =   393216
            Cols            =   9
            BackColor       =   -2147483644
            ForeColor       =   -2147483641
            BackColorFixed  =   -2147483646
            ForeColorFixed  =   -2147483639
            BackColorBkg    =   -2147483644
            GridColor       =   -2147483642
            GridColorFixed  =   -2147483642
            HighLight       =   2
            GridLines       =   2
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MouseIcon       =   "bac_formulas_prueba.frx":4172
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
         Left            =   210
         TabIndex        =   40
         Top             =   2745
         Width           =   11300
         Begin BACControles.TXTNumero lbl_tas_vig 
            Height          =   330
            Left            =   2250
            TabIndex        =   84
            Top             =   540
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
            Text            =   "0.00000"
            Text            =   "0.00000"
            Min             =   "-999.99999"
            Max             =   "999.99999"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero txt_monto_pag 
            Height          =   330
            Left            =   8805
            TabIndex        =   11
            Top             =   1920
            Width           =   2100
            _ExtentX        =   3704
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
            Text            =   "0.00"
            Text            =   "0.00"
            Min             =   "0"
            Max             =   "9999999999.9999"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero txt_pre_por 
            Height          =   330
            Left            =   8805
            TabIndex        =   10
            Top             =   195
            Width           =   1875
            _ExtentX        =   3307
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
         Begin BACControles.TXTNumero txt_tasa_int 
            Height          =   330
            Left            =   2250
            TabIndex        =   9
            Top             =   1575
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
         Begin BACControles.TXTNumero txt_nominal 
            Height          =   330
            Left            =   2250
            TabIndex        =   8
            Top             =   1230
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
            Text            =   "0.0000"
            Text            =   "0.0000"
            Min             =   "0"
            Max             =   "9999999999.9999"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTFecha txt_fec_val 
            Height          =   330
            Left            =   2250
            TabIndex        =   7
            Top             =   195
            Width           =   1300
            _ExtentX        =   2302
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
            MaxDate         =   2.5462962962963E-04
            MinDate         =   9.9537037037037E-04
            Text            =   "21/06/2002"
         End
         Begin BACControles.TXTNumero txt_Spread 
            Height          =   330
            Left            =   2250
            TabIndex        =   86
            Top             =   885
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
            Text            =   "0.00000"
            Text            =   "0.00000"
            Min             =   "-999.99999"
            Max             =   "999.99999"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label lblFactor 
            Caption         =   "lblFactor"
            ForeColor       =   &H00808000&
            Height          =   255
            Left            =   6930
            TabIndex        =   87
            Top             =   630
            Width           =   1665
         End
         Begin VB.Label Label14 
            Caption         =   "%"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Index           =   1
            Left            =   4530
            TabIndex        =   85
            Top             =   915
            Width           =   255
         End
         Begin VB.Label Label19 
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
            Index           =   1
            Left            =   150
            TabIndex        =   83
            Top             =   990
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
            Left            =   6135
            TabIndex        =   12
            Top             =   630
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
            Height          =   330
            Left            =   8805
            TabIndex        =   13
            Top             =   540
            Width           =   2100
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
            Height          =   330
            Left            =   8805
            TabIndex        =   73
            Top             =   885
            Width           =   2100
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
            Left            =   6135
            TabIndex        =   72
            Top             =   990
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
            Left            =   10740
            TabIndex        =   71
            Top             =   240
            Width           =   525
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
            Height          =   330
            Left            =   8805
            TabIndex        =   52
            Top             =   1230
            Width           =   2100
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
            Height          =   330
            Left            =   2250
            TabIndex        =   51
            Top             =   1920
            Width           =   2205
         End
         Begin VB.Label Label15 
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
            Height          =   255
            Left            =   150
            TabIndex        =   50
            Top             =   270
            Width           =   2055
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
            Left            =   150
            TabIndex        =   49
            Top             =   1320
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
            Left            =   150
            TabIndex        =   48
            Top             =   1620
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
            Left            =   6135
            TabIndex        =   47
            Top             =   1965
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
            Index           =   0
            Left            =   150
            TabIndex        =   46
            Top             =   630
            Width           =   975
         End
         Begin VB.Label Label20 
            Caption         =   "Precio Porcentual"
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
            Left            =   6135
            TabIndex        =   45
            Top             =   270
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
            Left            =   150
            TabIndex        =   44
            Top             =   1965
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
            Left            =   6135
            TabIndex        =   43
            Top             =   1320
            Width           =   1695
         End
         Begin VB.Label Label14 
            Caption         =   "%"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Index           =   0
            Left            =   4530
            TabIndex        =   42
            Top             =   600
            Width           =   255
         End
         Begin VB.Label Label25 
            Caption         =   "%"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   4530
            TabIndex        =   41
            Top             =   1980
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
         Height          =   1665
         Left            =   225
         TabIndex        =   23
         Top             =   1065
         Width           =   11280
         Begin BACControles.TXTFecha txt_fec_vcto 
            Height          =   330
            Left            =   2250
            TabIndex        =   4
            Top             =   555
            Width           =   1300
            _ExtentX        =   2302
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
            Left            =   2250
            TabIndex        =   3
            Top             =   195
            Width           =   1300
            _ExtentX        =   2302
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
            Left            =   2250
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   915
            Width           =   1755
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
            Left            =   8805
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   915
            Width           =   2175
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
            Left            =   150
            TabIndex        =   14
            Top             =   975
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
            TabIndex        =   39
            Top             =   2640
            Visible         =   0   'False
            Width           =   3000
         End
         Begin VB.Label lbl_rut 
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H8000000D&
            Height          =   285
            Left            =   11670
            TabIndex        =   38
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
            Left            =   8805
            TabIndex        =   37
            Top             =   1260
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
            TabIndex        =   36
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
            Left            =   150
            TabIndex        =   35
            Top             =   630
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
            TabIndex        =   34
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
            Left            =   6075
            TabIndex        =   33
            Top             =   1320
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
            Left            =   6075
            TabIndex        =   32
            Top             =   960
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
            Left            =   150
            TabIndex        =   31
            Top             =   1320
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
            TabIndex        =   30
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
            Left            =   6075
            TabIndex        =   29
            Top             =   600
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
            TabIndex        =   28
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
            Left            =   150
            TabIndex        =   27
            Top             =   285
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
            Left            =   6075
            TabIndex        =   26
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
            Left            =   8805
            TabIndex        =   25
            Top             =   555
            Width           =   2175
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
            Left            =   2250
            TabIndex        =   24
            Top             =   1260
            Width           =   2895
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "Esta es la Fórmula que Ud. Está Creando"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   1815
         Left            =   -74925
         TabIndex        =   22
         Top             =   4245
         Width           =   11355
         Begin VB.CommandButton For_Cmd_Limpiar 
            Caption         =   "Limpiar"
            Height          =   270
            Left            =   10200
            TabIndex        =   15
            Top             =   1275
            Width           =   1065
         End
         Begin VB.CommandButton For_Cmd_Cancelar 
            Caption         =   "Cancelar"
            Height          =   270
            Left            =   10200
            TabIndex        =   58
            Top             =   570
            Width           =   1065
         End
         Begin VB.CommandButton For_Cmd_Deshacer 
            Caption         =   "Deshacer"
            Height          =   270
            Left            =   10200
            TabIndex        =   57
            Top             =   930
            Width           =   1065
         End
         Begin VB.CommandButton For_Cmd_Aceptar 
            Caption         =   "Aceptar"
            Height          =   255
            Left            =   10200
            TabIndex        =   56
            Top             =   210
            Width           =   1065
         End
         Begin VB.TextBox For_Text_Formula 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Left            =   75
            TabIndex        =   53
            Top             =   210
            Width           =   10050
         End
         Begin VB.Frame For_Frm_ParFormula 
            Height          =   855
            Left            =   75
            TabIndex        =   74
            Top             =   900
            Width           =   4125
            Begin VB.TextBox For_Txt_Param1 
               Height          =   300
               Left            =   1950
               TabIndex        =   76
               Top             =   150
               Width           =   1965
            End
            Begin VB.TextBox For_Txt_Param2 
               Height          =   300
               Left            =   1950
               TabIndex        =   75
               Top             =   465
               Width           =   1965
            End
            Begin VB.Label For_Lbl_Par1 
               Caption         =   "Parámetro Fórmula 1"
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
               Left            =   75
               TabIndex        =   78
               Top             =   150
               Width           =   1965
            End
            Begin VB.Label For_Lbl_Par2 
               Caption         =   "Parámetro Fórmula 2"
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
               Left            =   75
               TabIndex        =   77
               Top             =   495
               Width           =   1965
            End
         End
         Begin VB.Frame For_Frm_Cupones 
            Height          =   855
            Left            =   6000
            TabIndex        =   79
            Top             =   915
            Width           =   4125
            Begin VB.TextBox For_Txt_Param4 
               Height          =   300
               Left            =   2070
               TabIndex        =   81
               Top             =   465
               Width           =   1965
            End
            Begin VB.TextBox For_Txt_Param3 
               Height          =   300
               Left            =   2070
               TabIndex        =   80
               Top             =   135
               Width           =   1965
            End
            Begin VB.Label For_Lbl_Par4 
               Caption         =   "Hasta Cupón"
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
               Left            =   90
               TabIndex        =   16
               Top             =   525
               Width           =   1965
            End
            Begin VB.Label For_Lbl_Par3 
               Caption         =   "Desde Cupón"
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
               Left            =   90
               TabIndex        =   82
               Top             =   180
               Width           =   1965
            End
         End
      End
      Begin VB.Frame Frame6 
         Caption         =   "Seleccione la Fórmula que Desea Valorizar"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000002&
         Height          =   2175
         Left            =   -74070
         TabIndex        =   18
         Top             =   1620
         Width           =   6645
         Begin VB.OptionButton tip_opt_tir 
            Caption         =   "TIR y Valor de Compra"
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
            Height          =   375
            Left            =   360
            TabIndex        =   21
            Top             =   1440
            Width           =   4215
         End
         Begin VB.OptionButton tip_opt_valor 
            Caption         =   "% Valor de Compra y Monto Tranzado"
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
            Height          =   375
            Left            =   360
            TabIndex        =   20
            Top             =   960
            Width           =   4215
         End
         Begin VB.OptionButton tip_opt_tasa 
            Caption         =   "Tasa de Interés y Monto Tranzado"
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
            Left            =   360
            TabIndex        =   19
            Top             =   600
            Width           =   4215
         End
      End
      Begin VB.Frame For_Frm_Variables 
         Caption         =   "Variables"
         ForeColor       =   &H8000000D&
         Height          =   1440
         Left            =   -74925
         TabIndex        =   59
         Top             =   2805
         Width           =   3645
         Begin VB.ListBox For_Lista_Variables 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   1110
            Left            =   135
            TabIndex        =   62
            Top             =   225
            Width           =   3345
         End
      End
      Begin VB.Frame For_Frm_Operaciones 
         Caption         =   "Operadores"
         ForeColor       =   &H8000000D&
         Height          =   1440
         Left            =   -71235
         TabIndex        =   60
         Top             =   2805
         Width           =   2910
         Begin VB.ListBox For_Lista_Operadores 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   1110
            Left            =   120
            TabIndex        =   63
            Top             =   240
            Width           =   2685
         End
      End
      Begin VB.Frame For_Frm_Funciones 
         Caption         =   "Funciones"
         ForeColor       =   &H8000000D&
         Height          =   1440
         Left            =   -68280
         TabIndex        =   61
         Top             =   2805
         Width           =   4740
         Begin VB.ListBox For_Lista_Funciones 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   1110
            Left            =   120
            TabIndex        =   64
            Top             =   240
            Width           =   4515
         End
      End
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
         Left            =   225
         TabIndex        =   88
         Top             =   5055
         Width           =   11300
         Begin BACControles.TXTNumero txtDur_Mac 
            Height          =   330
            Left            =   1020
            TabIndex        =   90
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
            TabIndex        =   92
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
            TabIndex        =   94
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
            TabIndex        =   93
            Top             =   270
            Width           =   960
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
            TabIndex        =   91
            Top             =   270
            Width           =   1650
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
            TabIndex        =   89
            Top             =   270
            Width           =   1515
         End
      End
   End
End
Attribute VB_Name = "Bac_Formulas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public Formula As String
Dim seriadoSN As String         'MAP 20160803
Dim idInternacionalSN As String 'MAP 20160803
Dim tipoPrecioPrcSN As String      'MAP 20160803
Dim NombreFamilia As String     'MAP 20160803
Dim BaseFamilia As String       'MAP 20160803
Dim UsaBaseFamiliaSN As String    'MAP 20160803
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

Const Btn_Limpiar = 1
Const Btn_Buscar = 2
Const Btn_Grabar = 3
Const Btn_Imprimir = 4
Const Btn_Salir = 5

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
Dim INCTR
Dim FIP As Date
Dim CAP
Dim SPREAD
Dim Dur_Mac As Double
Dim Dur_Mod As Double
Dim Convexi As Double
Dim marcaColtes As Integer

      
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
            lbl_tas_vig.Text = CDbl(Datos(14))
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
            txt_Spread.Text = CDbl(Datos(20))
            marcaColtes = CDbl(Datos(21))
        Loop
    End If
    
    Call llena_datos_tip_tasa(Val(Datos(5)))
    
    
    Call llena_datos_periodo(Val(Datos(7)))
    
    If UCase(lbl_tip_tasa.Caption) = "FIJA" Or UCase(lbl_tip_tasa.Caption) = "FIXED" Then
         txt_Spread.Enabled = False
    Else
        txt_Spread.Enabled = True
    End If
    Call enable_false
    Call enable_true
    
End Function
Function Clear_Objetos()
    
    box_familia.ListIndex = -1
    box_nemo.ListIndex = -1
    txt_fec_emi.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_fec_vcto.Text = Format(gsBac_Fecx, "DD/MM/YYYY") '--COP jcamposd gsBac_Fecp
    txt_fec_val.Text = Format(gsBac_Fecp, "DD/MM/YYYY")

    
'    box_familia.ListIndex = -1
'    box_nemo.ListIndex = -1
'    txt_fec_emi.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
'    txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
'    txt_fec_val.Text = Format(gsBac_Fecp, "DD/MM/YYYY")

    
    lbl_pais.Caption = ""
    lbl_descrip.Caption = ""
    lbl_periodo.Caption = ""
    lbl_ciudad.Caption = ""
    lbl_rut.Caption = ""
    lbl_tip_tasa.Caption = ""
    txt_nominal.Text = ""
    Me.lbl_int_dev.Caption = ""
    Me.lblFactor.Caption = ""

    txt_monto_pag.Text = ""
    txt_pre_por.Text = ""
    txt_tasa_int.Text = ""
    lbl_tas_vig.Text = ""
    txt_por_basilea.Caption = ""
    lbl_val_venc.Caption = ""
    txt_Spread.Text = ""
    box_moneda.ListIndex = -1
    box_base.ListIndex = -1
    txt_Spread.Enabled = True
        
    txtDur_Mac.Text = 0
    txtDur_Mod.Text = 0
    txtConvexi.Text = 0
    
    txtDur_Mac.Enabled = False
    txtDur_Mod.Enabled = False
    txtConvexi.Enabled = False
    
End Function
Function enable_false()

    Frm_Valoriza.Enabled = False
    If box_familia.ListIndex = 0 Then
        txt_fec_emi.Enabled = False
        txt_fec_vcto.Enabled = False
        lbl_tas_vig.Enabled = False
    End If
End Function

Function enable_true()
    Frm_Valoriza.Enabled = True
End Function

Function Func_Imprimir()

    Call limpiar_cristal

    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "formulas_valorizador.rpt"
    BAC_INVERSIONES.BacRpt.WindowTitle = "FORMULAS VALORIZADOR"

    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = box_familia.ItemData(box_familia.ListIndex)
    If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Trim(Mid(box_nemo.Text, 1, 20))
        BAC_INVERSIONES.BacRpt.StoredProcParam(2) = Format(txt_fec_vcto.Text, "YYYYMMDD")
    Else
        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Trim(box_familia.Text)
        BAC_INVERSIONES.BacRpt.StoredProcParam(2) = " "
    End If

    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1

    Call limpiar_cristal

End Function

Function Func_Limpiar()
    
        Dim i As Integer
    
        Call dibuja_grilla
    
        For_Text_Formula.Enabled = False
        For_Frm_Variables.Enabled = False
        For_Frm_Operaciones.Enabled = False
        For_Frm_Funciones.Enabled = False
        
        For_Cmd_Aceptar.Enabled = False
        For_Cmd_Cancelar.Enabled = False
        For_Cmd_Deshacer.Enabled = False
        For_Cmd_Limpiar.Enabled = False
        For_Cmd_Editar.Enabled = True
        For_Cmd_Remove.Enabled = True
        For_Cmd_Agrega.Enabled = True
        For_Text_Formula.Enabled = False
        For_Text_Formula.Text = ""
        Lbl_Mto_Pri.Caption = ""
        For_Grilla.Enabled = True
    
    
        For i = 1 To 100
        
            arreglo_formulas(i, 1) = ""
            arreglo_formulas(i, 2) = ""
            arreglo_formulas(i, 3) = ""
            arreglo_formulas(i, 4) = ""
            arreglo_formulas(i, 5) = ""
            arreglo_formulas(i, 6) = ""
            arreglo_formulas(i, 7) = ""
            arreglo_formulas(i, 8) = ""
            arreglo_formulas(i, 9) = ""
            arreglo_formulas(i, 10) = ""
            
            Arreglo_Variables(i, 1) = ""
            Arreglo_Variables(i, 2) = ""
            Arreglo_Variables(i, 3) = ""
            Arreglo_Variables(i, 4) = ""
            Arreglo_Variables(i, 5) = ""
            Arreglo_Variables(i, 6) = ""
            
            Arreglo_Operadores(i, 1) = ""
            Arreglo_Operadores(i, 2) = ""
            Arreglo_Operadores(i, 3) = ""
            Arreglo_Operadores(i, 4) = ""
            Arreglo_Operadores(i, 5) = ""
            Arreglo_Operadores(i, 6) = ""
            
            Arreglo_Funciones(i, 1) = ""
            Arreglo_Funciones(i, 2) = ""
            Arreglo_Funciones(i, 3) = ""
            Arreglo_Funciones(i, 4) = ""
            Arreglo_Funciones(i, 5) = ""
            Arreglo_Funciones(i, 6) = ""
    
        Next
        
        SSTab1.Tab = 0
        SSTab1.TabEnabled(1) = False
        SSTab1.TabEnabled(2) = False
        
        Call Clear_Objetos
        
        Toolbar1.Buttons(Btn_Buscar).Enabled = True
        Toolbar1.Buttons(Btn_Grabar).Enabled = False
        Toolbar1.Buttons(Btn_Imprimir).Enabled = False
    
        box_familia.Enabled = True
        box_nemo.Enabled = True
        
        
        frm_descrip.Enabled = False
        Frm_Valoriza.Enabled = False
        For_Frm_ParFormula.Visible = False
        For_Frm_Cupones.Visible = False
        lblFactor.Caption = ""
        marcaColtes = 0
        
     
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
    
'   MAP 20160804 Dejar valorizar con tasa cero
    If box_familia.ItemData(box_familia.ListIndex) <> 2004 And box_familia.ItemData(box_familia.ListIndex) <> 2005 Then
         If ModCal = 2 And CDbl(txt_tasa_int.Text) = 0 Then
            Exit Sub
        End If
    End If
    
    
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
    
    Call graba_formulas_temporal
    
    NOM = CDbl(txt_nominal.Text)
    MT = CDbl(txt_monto_pag.Text)
    TR = CDbl(txt_tasa_int.Text)
    PVP = CDbl(txt_pre_por.Text)
    TE = CDbl(lbl_tas_vig.Text)
    TV = CDbl(lbl_tas_vig.Text)
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
    SPREAD = CDbl(txt_Spread.Text)
    Dur_Mac = 0#
    Dur_Mod = 0#
    Convexi = 0#
    
    
    envia = Array()
    AddParam envia, txt_fec_val.Text
    AddParam envia, "P"
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
    AddParam envia, INCTR
    AddParam envia, CAP
    AddParam envia, SPREAD
    AddParam envia, "S"
    AddParam envia, box_moneda.ItemData(box_moneda.ListIndex)
       
    AddParam envia, Dur_Mac
    AddParam envia, Dur_Mod
    AddParam envia, Convexi
    
    Dim num
    
    If Bac_Sql_Execute("SVC_PRC_VAL_INS", envia) Then
        Debug.Print VerSql
        Do While Bac_SQL_Fetch(Datos)
            txt_tasa_int.Text = CDbl(Datos(1))
            lbl_tas_vig.Text = CDbl(Datos(2))
            txt_monto_pag.Text = Format(txt_monto_pag.Text, "0.0")
            '+++jcamposd COP para los cop miestra el valor final
            If box_familia.ItemData(box_familia.ListIndex) = 2006 Then
                txt_monto_pag.Text = Format(CDbl(Datos(9)), "###,###,###,##0.0000") '+++jcamposd debe mostrar monto final. Round(CDbl(Datos(8)), 6)
            Else
                txt_monto_pag.Text = Round(CDbl(Datos(8)), 2)
            End If
            '---jcamposd COP
            
            txt_pre_por.Text = Round(CDbl(Datos(11)), 6)
            txt_fec_val.Text = Format(Datos(13), "DD/MM/YYYY")
            txt_fec_emi.Text = Format(Datos(14), "DD/MM/YYYY")
            txt_fec_vcto.Text = Format(Datos(15), "DD/MM/YYYY")
            lbl_int_dev.Caption = Format(Round(CDbl(Datos(21)), 2), "#,####,###,###,##0.0000")
            lbl_val_venc.Caption = Format(Round(CDbl(Datos(9)), 2), "#,####,###,###,##0.0000")
            Lbl_Mto_Pri.Caption = Format(Round(CDbl(Datos(22)), 2), "#,####,###,###,##0.0000")
            If CDbl(Datos(44)) <> 1 Then
                lblFactor.Caption = "(Factor " & Format(CDbl(Datos(44)), "#0.000000000") & ")"
            End If
            txtDur_Mac.Text = Datos(45)
            txtDur_Mod.Text = Datos(46)
            txtConvexi.Text = Format((Datos(47) / 100#), "#,####,###,###,##0.0000")
        Loop
   End If
   Screen.MousePointer = 0

End Sub

Function graba_formulas_temporal()
    Dim Datos()
    Dim i As Integer
    Dim E As Integer
    envia = Array()
    
    AddParam envia, box_familia.ItemData(box_familia.ListIndex)
    
    If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
        AddParam envia, Trim(Mid(box_nemo.Text, 1, 20))
        AddParam envia, txt_fec_vcto.Text
    Else
        AddParam envia, box_familia.Text
        AddParam envia, ""
    End If
    
    If Bac_Sql_Execute("SVA_FMU_ELI_PRU", envia) Then
        Debug.Print VerSql
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

            If Bac_Sql_Execute("SVA_FMU_GRB_PRU", envia) Then
                Debug.Print VerSql
                Do While Bac_SQL_Fetch(Datos)
                Loop
            End If
        End If
    
    Next
End Function

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
                'Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Formulas del instrumento " & Trim(Mid(box_nemo.Text, 1, 20)) & " se grabaron con exito ")
            Else
               ' Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas al grabar Formulas del instrumento " & Trim(Mid(box_nemo.Text, 1, 20)))
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
    If Bac_Sql_Execute("SVC_GEN_TIP_TAS", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            lbl_tip_tasa.Caption = Datos(2)
        Loop
    End If
End Function



Function llena_For_Lista_Variables()
    Dim Datos()
    Dim i As Integer
    envia = Array()
    For_Lista_Variables.Clear
    AddParam envia, 1
    If Bac_Sql_Execute("SVC_FMU_DAT_CAL", envia) Then
        i = 0
        Do While Bac_SQL_Fetch(Datos)
            For_Lista_Variables.AddItem Trim(Datos(2)) & " - " & Datos(4)
            For_Lista_Variables.ItemData(For_Lista_Variables.NewIndex) = Val(Datos(5))
            Arreglo_Variables(i, 1) = Trim(Datos(2))
            Arreglo_Variables(i, 2) = Trim(Datos(4))
            Arreglo_Variables(i, 3) = Trim(Datos(3))
            Arreglo_Variables(i, 4) = Val(Datos(5))
            Arreglo_Variables(i, 5) = Trim(Datos(7))
            Arreglo_Variables(i, 6) = Trim(Datos(8))

            i = i + 1
        Loop
    End If
    
End Function
Function llena_For_Lista_Operadores()
    Dim Datos()
    Dim i As Integer
    envia = Array()
    AddParam envia, 2
    For_Lista_Operadores.Clear
    If Bac_Sql_Execute("SVC_FMU_DAT_CAL", envia) Then
        i = 0
        Do While Bac_SQL_Fetch(Datos)
            For_Lista_Operadores.AddItem Datos(2) & " (" & Trim(Datos(4)) & ")"
            For_Lista_Operadores.ItemData(For_Lista_Operadores.NewIndex) = Val(Datos(5))
            Arreglo_Operadores(i, 1) = Trim(Datos(2))
            Arreglo_Operadores(i, 2) = Trim(Datos(4))
            Arreglo_Operadores(i, 3) = Trim(Datos(3))
            Arreglo_Operadores(i, 4) = Val(Datos(5))
            Arreglo_Operadores(i, 5) = Trim(Datos(7))
            Arreglo_Operadores(i, 6) = Trim(Datos(8))

            i = i + 1

        Loop
    End If

End Function

Function llena_For_Lista_Funciones()
    Dim Datos()
    Dim i As Integer
    envia = Array()
    AddParam envia, 3
    For_Lista_Funciones.Clear
    If Bac_Sql_Execute("SVC_FMU_DAT_CAL", envia) Then
        i = 0
        Do While Bac_SQL_Fetch(Datos)
            For_Lista_Funciones.AddItem Datos(4)
            For_Lista_Funciones.ItemData(For_Lista_Funciones.NewIndex) = Val(Datos(5))
            Arreglo_Funciones(i, 1) = Trim(Datos(2))
            Arreglo_Funciones(i, 2) = Trim(Datos(4))
            Arreglo_Funciones(i, 3) = Trim(Datos(3))
            Arreglo_Funciones(i, 4) = Val(Datos(5))
            Arreglo_Funciones(i, 5) = Trim(Datos(7))
            Arreglo_Funciones(i, 6) = Trim(Datos(8))
            i = i + 1

        Loop
    End If

End Function


Function llena_arreglo_formulas(cod_familia As Integer, cod_nemo As String)

     Dim Datos()
     Dim pru
     
     Linea_Formula = 0
             
     envia = Array()
     AddParam envia, cod_familia
     If cod_familia = 2000 Then
        AddParam envia, Trim(Mid(box_nemo.Text, 1, 20))
        AddParam envia, txt_fec_vcto.Text
     Else
        AddParam envia, Trim(box_familia.Text)
        AddParam envia, ""
     End If
    
    
     If Bac_Sql_Execute("Svc_Fmu_bus_dat", envia) Then
     
         Do While Bac_SQL_Fetch(Datos)
         
             Linea_Formula = Linea_Formula + 1
             arreglo_formulas(Linea_Formula, 1) = Linea_Formula
             arreglo_formulas(Linea_Formula, 2) = Datos(4)      'Tipo Calculo
             arreglo_formulas(Linea_Formula, 3) = Datos(5)      'Numero Linea
             arreglo_formulas(Linea_Formula, 4) = Datos(6)      'Varaible
             arreglo_formulas(Linea_Formula, 5) = Datos(7)      'Formula
             arreglo_formulas(Linea_Formula, 6) = Datos(8)      'Tipo Formula
             arreglo_formulas(Linea_Formula, 7) = Datos(9)      'Parametro1
             arreglo_formulas(Linea_Formula, 8) = Datos(10)     'Parametro2
             arreglo_formulas(Linea_Formula, 9) = Datos(11)     'Parametro3
             arreglo_formulas(Linea_Formula, 10) = Datos(12)     'Parametro4

        Loop
        
    End If

End Function

Function llena_Grilla_formulas(cod_familia As Integer, cod_nemo As String)

     Dim Datos()
     Dim pru
     Dim i As Integer
     Dim X As Integer
     i = 0
     X = 1
             
     For_Grilla.Rows = 1
     
     For i = 1 To 100
     
        If arreglo_formulas(i, 2) = Opcion Then
     
            For_Grilla.Rows = X + 1
            
             For_Grilla.TextMatrix(X, 1) = arreglo_formulas(i, 3) 'Numero Linea
             For_Grilla.TextMatrix(X, 2) = arreglo_formulas(i, 4) 'Varaible
             For_Grilla.TextMatrix(X, 3) = arreglo_formulas(i, 5) 'Formula
             For_Grilla.TextMatrix(X, 0) = arreglo_formulas(i, 6) 'Tipo Formula
             For_Grilla.TextMatrix(X, 4) = arreglo_formulas(i, 1) 'Linea en Arreglo
             For_Grilla.TextMatrix(X, 5) = arreglo_formulas(i, 7) 'Parametro 1
             For_Grilla.TextMatrix(X, 6) = arreglo_formulas(i, 8) 'Parametro 2
             For_Grilla.TextMatrix(X, 7) = arreglo_formulas(i, 9) 'Parametro 3
             For_Grilla.TextMatrix(X, 8) = arreglo_formulas(i, 10) 'Parametro 4
             
             X = X + 1
             
         End If
             
    Next
        

End Function


Function llena_grilla()
    Dim i As Integer
    Dim E As Integer
    For_Grilla.Rows = 1
    For_Grilla.Clear
    If box_familia.ListIndex <> -1 Then
        i = 0
        For i = 1 To 100
            If arreglo_formulas(i, 1) <> "" And Opcion = arreglo_formulas(i, 3) And arreglo_formulas(i, 2) = box_familia.ItemData(box_familia.ListIndex) Then
                E = E + 1
            End If
        Next
        i = 0
        For_Grilla.Rows = E + 1
        For i = 1 To 100
            If arreglo_formulas(i, 1) <> "" And Opcion = arreglo_formulas(i, 3) And arreglo_formulas(i, 2) = box_familia.ItemData(box_familia.ListIndex) And box_nemo.Text = arreglo_formulas(i, 1) Then
                For_Grilla.TextMatrix(i, 1) = arreglo_formulas(i, 4)
                For_Grilla.TextMatrix(i, 2) = arreglo_formulas(i, 5)
                For_Grilla.TextMatrix(i, 3) = arreglo_formulas(i, 6)
            End If
        Next
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
        
        
        If marcaColtes = 1 Then
            codMonedaSel = 129
        End If
        
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
    'MAP 20160802 Ejecuta según parametrización
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

        Call buscar_datos_nemo
        Call llena_combo_monedas
        box_moneda.Enabled = True
'        box_moneda.SetFocus
        
 
    ElseIf box_familia.ListIndex > 0 Then
        
        txt_fec_emi.Enabled = True
        txt_fec_vcto.Enabled = True
        frm_descrip.Enabled = True
        If UsaBaseFamiliaSN = "S" Then
           box_base.Enabled = False
        Else
           box_base.Enabled = True
        End If
        'Call llena_combo_monedas
        
        
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
    
    Call llena_arreglo_formulas(box_familia.ItemData(box_familia.ListIndex), box_nemo.Text)
   
   
    box_familia.Enabled = False
    box_nemo.Enabled = False
    frm_descrip.Enabled = True
    Frm_Valoriza.Enabled = True
    
   
    Toolbar1.Buttons(Btn_Buscar).Enabled = False
    Toolbar1.Buttons(Btn_Grabar).Enabled = True
    Toolbar1.Buttons(Btn_Imprimir).Enabled = True
    SSTab1.TabEnabled(1) = True
    SSTab1.TabEnabled(2) = True
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
    Call llena_combo_monedas
    envia = Array()
    AddParam envia, Codigo_Familia
    If Bac_Sql_Execute("BacParamSuda.dbo.SP_CONSULTA_DATOS_FAMILIA_BONOS_EXT", envia) Then
        Do While Bac_SQL_Fetch(Datos)
        
           'Txt_rut_Emi.Text = Datos(9)
           'txt_cod_emi.Text = Datos(10)
           'lbl_emisor.Caption = Datos(11)
           'lbl_pais.Caption = Datos(12)
             Call BuscaIDCombo(box_moneda, CStr(Datos(5)))
           'Call BuscaIDCombo(BOX_MON_PAG, CStr(Datos(7)))
           'Call box_mon_pag_LostFocus   ' MAP 20160802 Para evaluar el combo de monedas
           Let seriadoSN = Datos(13)         'MAP 20160803
           Let idInternacionalSN = Datos(14) 'MAP 20160803
           Let tipoPrecioPrcSN = Datos(15)     'MAP 20160803
           Let NombreFamilia = Datos(2)     'MAP 20160803
           Let BaseFamilia = Datos(4)
           Let UsaBaseFamiliaSN = Datos(19)
        Loop
    End If
    
    lbl_tas_vig.Text = "1"  '' MAP 20160802 La idea es que no se requiera el valor
                                   '' Poner algo mas piolita
                                  
    
                                   
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

Private Sub For_box_Variables_Click()

    
    

End Sub

Private Sub For_Cmd_Agrega_Click()

    Dim i As Integer
    
    Linea_Formula = Linea_Formula + 1
    arreglo_formulas(Linea_Formula, 1) = Linea_Formula
    
    For_Grilla.Rows = For_Grilla.Rows + 1
    
    For i = 2 To For_Grilla.Rows
        For_Grilla.TextMatrix(i - 1, 1) = i - 1
        If i < For_Grilla.Rows Then
            arreglo_formulas(For_Grilla.TextMatrix(i - 1, 4), 3) = i - 1
        End If
    Next

    arreglo_formulas(Linea_Formula, 2) = Opcion
    arreglo_formulas(Linea_Formula, 3) = For_Grilla.TextMatrix(For_Grilla.Rows - 1, 1)

    For_Grilla.TextMatrix(For_Grilla.Rows - 1, 4) = Linea_Formula

End Sub

Private Sub For_Cmd_Editar_Click()

    Dim i As Integer

    If For_Grilla.TextMatrix(For_Grilla.row, 0) = "F" Then
        MsgBox "No puede editar una función", vbCritical, gsBac_Version
    Else
    
        For_Frm_Variables.Enabled = True
        For_Frm_Operaciones.Enabled = True
        SSTab1.TabEnabled(0) = False
        SSTab1.TabEnabled(1) = False
        Toolbar1.Buttons(Btn_Grabar).Enabled = False
        Toolbar1.Buttons(Btn_Limpiar).Enabled = False
        Toolbar1.Buttons(Btn_Salir).Enabled = False
        Frame4.Enabled = True
        If For_Grilla.RowSel = 0 Then
            MsgBox "No ha Seleccionado Linea", vbExclamation, gsBac_Version
            Exit Sub
        End If
        
        If For_Grilla.TextMatrix(For_Grilla.row, 0) = "F" Then
            MsgBox "Formula Corresponde a Función NO puede Modificar", vbExclamation, gsBac_Version
            Exit Sub
        End If
        
        If For_Grilla.TextMatrix(For_Grilla.row, 2) = "" Then
            MsgBox "No Ha Ingresado Nombre de Campo", vbExclamation, gsBac_Version
            Exit Sub
        End If
    
    
        For_Text_Formula.Enabled = True
    
        For_Text_Formula.Text = For_Grilla.TextMatrix(For_Grilla.row, 3)
        For_Txt_Param1.Text = For_Grilla.TextMatrix(For_Grilla.row, 5)
        For_Txt_Param2.Text = For_Grilla.TextMatrix(For_Grilla.row, 6)
        For_Txt_Param3.Text = For_Grilla.TextMatrix(For_Grilla.row, 7)
        For_Txt_Param4.Text = For_Grilla.TextMatrix(For_Grilla.row, 8)
    
        If Trim(For_Txt_Param1.Text) <> "" Or Trim(For_Txt_Param2.Text) <> "" Then
            For_Frm_ParFormula.Visible = True
        Else
            For_Frm_ParFormula.Visible = False
        End If
        
        
        If Trim(For_Txt_Param1.Text) <> "" Then
              For_Txt_Param1.Enabled = True
        Else
              For_Txt_Param1.Enabled = False
        End If
        
        
        If Trim(For_Txt_Param2.Text) <> "" Then
            For_Txt_Param2.Enabled = True
        Else
            For_Txt_Param2.Enabled = False
        End If
        
        
        If For_Grilla.TextMatrix(For_Grilla.row, 0) = "D" Then
            For_Frm_Cupones.Visible = True
            For_Txt_Param3.Enabled = True
            For_Txt_Param4.Enabled = True
        Else
            For_Frm_Cupones.Visible = False
            For_Txt_Param3.Enabled = False
            For_Txt_Param4.Enabled = False
        End If
    
        
        For_Frm_Variables.Enabled = True
        For_Frm_Operaciones.Enabled = True
        For_Frm_Funciones.Enabled = True
        
        
        For_Cmd_Aceptar.Enabled = True
        For_Cmd_Cancelar.Enabled = True
        For_Cmd_Deshacer.Enabled = True
        For_Cmd_Limpiar.Enabled = True
        For_Cmd_Editar.Enabled = False
        For_Cmd_Remove.Enabled = False
        For_Cmd_Agrega.Enabled = False
        PosTexto = 0
        
        For_Text_Formula.SetFocus
        
        For i = 1 To For_Lista_Funciones.ListCount
            If Trim(For_Text_Formula.Text) = Arreglo_Funciones(i - 1, 3) Then
                For_Text_Formula.Enabled = False
            End If
        
        Next
        
        
        
        For_Grilla.Enabled = False
        
    End If
    
End Sub

Private Sub For_Cmd_Aceptar_Click()

    Dim Datos()
    
    If For_Txt_Param1.Enabled = True And Trim(For_Txt_Param1.Text) = "" Then
        MsgBox "Falta Ingresar Parametro 1 en Funcion", vbCritical, gsBac_Version
        For_Txt_Param1.SetFocus
        Exit Sub
    End If
    
    If For_Txt_Param2.Enabled = True And Trim(For_Txt_Param2.Text) = "" Then
        MsgBox "Falta Ingresar Parametro 2 en Funcion", vbCritical, gsBac_Version
        For_Txt_Param2.SetFocus
        Exit Sub
    End If
    
    If For_Txt_Param3.Enabled = True And Trim(For_Txt_Param3.Text) = "" Then
        MsgBox "Falta Ingresar Perido Inicio Tabla de Desarrollo", vbCritical, gsBac_Version
        For_Txt_Param3.SetFocus
        Exit Sub
    End If

    If For_Txt_Param4.Enabled = True And Trim(For_Txt_Param4.Text) = "" Then
        MsgBox "Falta Ingresar Perido Final Tabla de Desarrollo", vbCritical, gsBac_Version
        For_Txt_Param4.SetFocus
        Exit Sub
    End If

    
    envia = Array()
    AddParam envia, For_Grilla.TextMatrix(For_Grilla.row, 2)
    AddParam envia, For_Grilla.TextMatrix(For_Grilla.row, 0)
    AddParam envia, For_Text_Formula.Text
    AddParam envia, For_Txt_Param1.Text
    AddParam envia, For_Txt_Param2.Text
    AddParam envia, For_Txt_Param3.Text
    AddParam envia, For_Txt_Param4.Text
    AddParam envia, Trim(Mid(box_nemo.Text, 1, 20))                  '-- MAP 20180104
    
    If Bac_Sql_Execute("SVC_FMU_VAL_PRU", envia) Then
    
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Valores de Fórmulas del instrumento " & Trim(Mid(box_nemo.Text, 1, 20)) & " se grabaron con éxito ")
'       Do While Bac_SQL_Fetch(datos)
'       Loop
        
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 5) = For_Text_Formula.Text
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 7) = For_Txt_Param1.Text
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 8) = For_Txt_Param2.Text
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 9) = For_Txt_Param3.Text
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 10) = For_Txt_Param4.Text
        For_Grilla.TextMatrix(For_Grilla.row, 3) = Trim(For_Text_Formula.Text)
        If Trim(For_Txt_Param1.Text) = "" Then
            For_Grilla.TextMatrix(For_Grilla.row, 5) = " "
        Else
            For_Grilla.TextMatrix(For_Grilla.row, 5) = Trim(For_Txt_Param1.Text)
        End If
        
        If Trim(For_Txt_Param2.Text) = "" Then
            For_Grilla.TextMatrix(For_Grilla.row, 6) = " "
        Else
            For_Grilla.TextMatrix(For_Grilla.row, 6) = Trim(For_Txt_Param2.Text)
        End If
        
        
        If Trim(For_Txt_Param3.Text) = "" Then
            For_Grilla.TextMatrix(For_Grilla.row, 7) = " "
        Else
            For_Grilla.TextMatrix(For_Grilla.row, 7) = Trim(For_Txt_Param3.Text)
        End If

        If Trim(For_Txt_Param4.Text) = "" Then
            For_Grilla.TextMatrix(For_Grilla.row, 8) = " "
        Else
            For_Grilla.TextMatrix(For_Grilla.row, 8) = Trim(For_Txt_Param4.Text)
        End If

        
        For_Frm_Funciones.Enabled = False
        Frame4.Enabled = False
        For_Frm_Variables.Enabled = False
        For_Frm_Operaciones.Enabled = False
        For_Frm_Funciones.Enabled = False
        For_Frm_Variables.Enabled = False
        For_Frm_Operaciones.Enabled = False
        For_Cmd_Aceptar.Enabled = False
        For_Cmd_Cancelar.Enabled = False
        For_Cmd_Deshacer.Enabled = False
        For_Cmd_Limpiar.Enabled = False
        For_Cmd_Editar.Enabled = True
        For_Cmd_Remove.Enabled = True
        For_Cmd_Agrega.Enabled = True
        For_Text_Formula.Enabled = False
        For_Text_Formula.Text = ""
        For_Txt_Param1.Text = ""
        For_Txt_Param2.Text = ""
        For_Txt_Param3.Text = ""
        For_Txt_Param4.Text = ""
        For_Txt_Param1.Enabled = False
        For_Txt_Param2.Enabled = False
        For_Txt_Param3.Enabled = False
        For_Txt_Param4.Enabled = False
        For_Grilla.Enabled = True
        SSTab1.TabEnabled(0) = True
        SSTab1.TabEnabled(1) = True
        Toolbar1.Buttons(Btn_Grabar).Enabled = True
        Toolbar1.Buttons(Btn_Limpiar).Enabled = True
        Toolbar1.Buttons(Btn_Salir).Enabled = True
        
        For_Frm_ParFormula.Visible = False
        For_Frm_Cupones.Visible = False
    Else
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas de Sintaxis en la formula del instrumento " & Trim(Mid(box_nemo.Text, 1, 20)))
        MsgBox "Error de Sintaxis en la formula", vbExclamation, gsBac_Version
        If For_Text_Formula.Enabled = True Then
            For_Text_Formula.SetFocus
        Else
            If For_Txt_Param1.Enabled = True Then
                For_Txt_Param1.SetFocus
            End If
        End If
    End If
    
End Sub

Private Sub For_Cmd_Deshacer_Click()
    Dim largo_f As Integer
    Dim largo_t As Integer
    Dim listo
    largo_f = Len(Formula) + 1
    largo_t = Len(For_Text_Formula.Text)
    listo = largo_t - largo_f
    
    If listo < 1 Then
        listo = 0
    End If
    
    If For_Text_Formula.Text <> "" Then
        For_Text_Formula.Text = Mid(For_Text_Formula.Text, 1, listo)
        Formula = ""
    End If
    For_Text_Formula.Enabled = True
    
    
    For_Txt_Param1.Text = ""
    For_Txt_Param2.Text = ""
    For_Txt_Param1.Enabled = False
    For_Txt_Param2.Enabled = False
    For_Txt_Param3.Text = ""
    For_Txt_Param4.Text = ""
    For_Txt_Param3.Enabled = False
    For_Txt_Param4.Enabled = False
    For_Frm_ParFormula.Visible = False
    For_Frm_Cupones.Visible = False

End Sub


Private Sub for_Cmd_Cancelar_Click()
'   For_Grilla.TextMatrix(For_Grilla.Row, 3) = " "
    
    For_Frm_Variables.Enabled = False
    For_Frm_Operaciones.Enabled = False
    For_Frm_Funciones.Enabled = False
    
    For_Cmd_Aceptar.Enabled = False
    For_Cmd_Cancelar.Enabled = False
    For_Cmd_Deshacer.Enabled = False
    For_Cmd_Limpiar.Enabled = False
    For_Cmd_Editar.Enabled = True
    For_Cmd_Remove.Enabled = True
    For_Cmd_Agrega.Enabled = True
    For_Text_Formula.Enabled = False
    For_Text_Formula.Text = ""
    For_Txt_Param1.Text = ""
    For_Txt_Param2.Text = ""
    For_Txt_Param1.Enabled = False
    For_Txt_Param2.Enabled = False
    For_Txt_Param3.Text = ""
    For_Txt_Param4.Text = ""
    For_Txt_Param3.Enabled = False
    For_Txt_Param4.Enabled = False
    For_Grilla.Enabled = True
    SSTab1.TabEnabled(0) = True
    SSTab1.TabEnabled(1) = True
    Toolbar1.Buttons(Btn_Grabar).Enabled = True
    Toolbar1.Buttons(Btn_Limpiar).Enabled = True
    Toolbar1.Buttons(Btn_Salir).Enabled = True
    Frame4.Enabled = False
    
    For_Frm_ParFormula.Visible = False
    For_Frm_Cupones.Visible = False

End Sub

Private Sub For_Cmd_Limpiar_Click()

    For_Text_Formula.Text = ""
    For_Text_Formula.Enabled = True
    For_Txt_Param1.Text = ""
    For_Txt_Param2.Text = ""
    For_Txt_Param1.Enabled = False
    For_Txt_Param2.Enabled = False
    For_Txt_Param3.Text = ""
    For_Txt_Param4.Text = ""
    For_Txt_Param3.Enabled = False
    For_Txt_Param4.Enabled = False
    For_Frm_ParFormula.Visible = False
    For_Frm_Cupones.Visible = False
    
    For_Text_Formula.SetFocus

End Sub

Private Sub For_Cmd_Remove_Click()

    Dim i As Integer
    
    
    If MsgBox("Esta Seguro de Remover Linea", vbQuestion + vbYesNo, gsBac_Version) <> vbYes Then
        Exit Sub
    End If
    

    If For_Grilla.RowSel > 0 Then
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 2) = ""
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 3) = ""
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 4) = ""
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 5) = ""
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 6) = ""
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 7) = ""
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 8) = ""
    
        If For_Grilla.Rows > 2 Then
            For_Grilla.RemoveItem For_Grilla.RowSel
        Else
            For_Grilla.Rows = 1
        End If
        
    Else
        MsgBox "No ha Seleccionado Linea", vbExclamation, gsBac_Version
    End If

    For i = 2 To For_Grilla.Rows
        For_Grilla.TextMatrix(i - 1, 1) = i - 1
        
        If i < For_Grilla.Rows Then
            arreglo_formulas(For_Grilla.TextMatrix(i - 1, 4), 3) = i - 1
        End If
    Next

    arreglo_formulas(Linea_Formula, 3) = For_Grilla.TextMatrix(For_Grilla.Rows - 1, 1)

End Sub

Private Sub For_Grilla_DblClick()

    If For_Grilla.Col = 2 Then
        instru = ""
        For_Frm_Variables.Enabled = False
        For_Frm_Operaciones.Enabled = False
        Load Bac_Ayuda_Variables
        Bac_Ayuda_Variables.Show vbModal
       
        If instru <> "" Then
        
'           If For_Grilla.TextMatrix(For_Grilla.Row, 0) = "F" Then
'               For_Grilla.TextMatrix(For_Grilla.Row, 3) = " "
'           End If

            arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 6) = For_Grilla.TextMatrix(For_Grilla.row, 0)
            arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 4) = For_Grilla.TextMatrix(For_Grilla.row, 2)
            
        End If
        
    End If
    
End Sub

Private Sub For_Grilla_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode = vbKeyDelete Then
            
        For_Grilla.TextMatrix(For_Grilla.row, 0) = ""
        For_Grilla.TextMatrix(For_Grilla.row, 2) = ""
        For_Grilla.TextMatrix(For_Grilla.row, 3) = ""
        
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 4) = ""
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 5) = ""
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 6) = ""
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 7) = ""
        arreglo_formulas(For_Grilla.TextMatrix(For_Grilla.row, 4), 8) = ""
    
    End If

End Sub

Private Sub For_Text_Formula_GotFocus()
    PosTexto = 0
    For_Text_Formula.SelStart = Len(For_Text_Formula.Text)

End Sub

Private Sub For_Text_Formula_LostFocus()

    PosTexto = For_Text_Formula.SelStart
    PosFormula = 1
    
End Sub

Private Sub For_Txt_Param1_LostFocus()
    PosFormula = 2
End Sub


Private Sub For_Txt_Param2_LostFocus()
    PosFormula = 3
End Sub


Private Sub For_Txt_Param3_LostFocus()
    PosFormula = 4
End Sub


Private Sub For_Txt_Param4_LostFocus()
    PosFormula = 5
End Sub

Private Sub Form_Activate()
marcaColtes = 0
'mostrar_grilla
'dibuja_grilla
'llena_combo_base
'box_familia.SetFocus
'SSTab1.Tab = 0
End Sub

Sub dibuja_grilla()

    For_Grilla.TextMatrix(0, 1) = "Nº"
    For_Grilla.TextMatrix(0, 2) = "Campo"
    For_Grilla.TextMatrix(0, 3) = "Formula"
    For_Grilla.TextMatrix(0, 5) = "Param.1"
    For_Grilla.TextMatrix(0, 6) = "Param.2"
    For_Grilla.TextMatrix(0, 7) = "TD Desde"
    For_Grilla.TextMatrix(0, 8) = "TD Hasta"
    
    For_Grilla.ColWidth(0) = 0
    For_Grilla.ColWidth(1) = 300
    For_Grilla.ColWidth(2) = 700
    For_Grilla.ColWidth(3) = 6000
    For_Grilla.ColWidth(4) = 0
    For_Grilla.ColWidth(5) = 700
    For_Grilla.ColWidth(6) = 700
    For_Grilla.ColWidth(7) = 1150
    For_Grilla.ColWidth(8) = 1150
    
    For_Grilla.ColAlignment(3) = 0
    For_Grilla.ColAlignment(4) = 0
    For_Grilla.ColAlignment(5) = 0
    For_Grilla.ColAlignment(6) = 0
    For_Grilla.ColAlignment(7) = 0
    For_Grilla.ColAlignment(8) = 0
    
End Sub
Sub mostrar_grilla()
    
    For_Grilla.Clear
    For_Grilla.Refresh
    
'   Me.Height = 7845
'   Me.Width = 11640
    
    dibuja_grilla

    'llena_grilla

End Sub

Private Sub Form_Load()

    Move 0, 0

    tip_opt_tasa.Value = True
    Opcion = 1
    PosTexto = 0
    ModCal = 2
    Valorizar = False
    
    'Call llena_For_Frm_Funciones
    Dim i As Integer
    
'   Me.Height = 7350
'   Me.Width = 11730
    
    PosFormula = 1
    
    Call llena_combo_familia
    Call enable_false

    Call mostrar_grilla
    Call dibuja_grilla
    Call llena_combo_base

    
    txt_fec_val.Text = Format(Date, "dd/mm/yyyy")
    
    SSTab1.TabEnabled(1) = False
    SSTab1.TabEnabled(2) = False
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
    
    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Ingreso a Pantalla de Fórmulas")
    
End Sub

Private Sub For_Grilla_Click()

    Dim nCol As Integer
    
    nCol = For_Grilla.Col

    Call Marcar

    For_Grilla.Col = nCol

    
End Sub

Sub Marcar()
'
'   Dim f, C, R, v As Integer
'
'   Dim lrow As Integer
'
'   FilaSeleccionada = For_Grilla.RowSel
'
'   lrow = For_Grilla.TopRow
'
'   With For_Grilla
'
'      f = .RowSel
'
'      .FocusRect = flexFocusHeavy
'      .Redraw = False
'
'    For R = 1 To .Rows - 1
'
'        For C = 0 To .Cols - 1
'
'               .row = R
'               .Col = C
'
'
'                  If R <> f Then
'                     .BackColorSel = &HC0C0C0
'                     .BackColorFixed = &H808000
'                     .ForeColorFixed = &H80000005
'                     .CellBackColor = &HC0C0C0
'                     .CellForeColor = vbBlue
'                  End If
'
'               If f = R Then
'                    .BackColorSel = &H800000
'                    .BackColorFixed = &H808000
'                    .ForeColorFixed = &H80000005
'                    .CellBackColor = vbBlue    ''vbRed
'                    .CellForeColor = vbWhite
'               End If
'        Next C
'    Next R
'      .row = f
'      .Col = 0
'      .FocusRect = flexFocusLight
'      .Redraw = True
'   End With
'
'
'    If lrow > 1 Then
'        For_Grilla.TopRow = lrow
'    End If
'
End Sub


Private Sub For_Lista_Variables_DblClick()
    
    If PosFormula = 1 Then
        
        If PosTexto = 0 Then
            PosTexto = Len(For_Text_Formula.Text)
        End If
    
        If For_Text_Formula.Text = "" Then
            For_Text_Formula.Text = Arreglo_Variables(For_Lista_Variables.ListIndex, 3)
            Formula = Arreglo_Variables(For_Lista_Variables.ListIndex, 3)
        Else
            For_Text_Formula.Text = Mid$(For_Text_Formula.Text, 1, PosTexto) & " " & Trim(Arreglo_Variables(For_Lista_Variables.ListIndex, 3)) & " " & Mid$(For_Text_Formula.Text, PosTexto + 1, Len(For_Text_Formula.Text))
            Formula = Arreglo_Variables(For_Lista_Variables.ListIndex, 3)
        End If
        If For_Text_Formula.Enabled = True Then
            For_Text_Formula.SetFocus
        End If
        
    ElseIf PosFormula = 2 And For_Txt_Param1.Enabled = True Then
        
        For_Txt_Param1.Text = Arreglo_Variables(For_Lista_Variables.ListIndex, 3)
        
        For_Txt_Param1.SetFocus
        
    ElseIf PosFormula = 3 And For_Txt_Param2.Enabled = True Then
        
        For_Txt_Param2.Text = Arreglo_Variables(For_Lista_Variables.ListIndex, 3)
       
        For_Txt_Param2.SetFocus
       
    ElseIf PosFormula = 4 And For_Txt_Param3.Enabled = True Then
        
        If PosTexto = 0 Then
            PosTexto = Len(For_Txt_Param3.Text)
        End If
    
        If For_Txt_Param3.Text = "" Then
            For_Txt_Param3.Text = Arreglo_Variables(For_Lista_Variables.ListIndex, 3)
        Else
            For_Txt_Param3.Text = Mid$(For_Txt_Param3.Text, 1, PosTexto) & " " & Trim(Arreglo_Variables(For_Lista_Variables.ListIndex, 3)) & " " & Mid$(For_Txt_Param3.Text, PosTexto + 1, Len(For_Txt_Param3.Text))
        End If
        
        For_Txt_Param3.SetFocus
       
    ElseIf PosFormula = 5 And For_Txt_Param4.Enabled = True Then
        
        If PosTexto = 0 Then
            PosTexto = Len(For_Txt_Param4.Text)
        End If
    
        If For_Txt_Param4.Text = "" Then
            For_Txt_Param4.Text = Arreglo_Variables(For_Lista_Variables.ListIndex, 3)
        Else
            For_Txt_Param4.Text = Mid$(For_Txt_Param4.Text, 1, PosTexto) & " " & Trim(Arreglo_Variables(For_Lista_Variables.ListIndex, 3)) & " " & Mid$(For_Txt_Param4.Text, PosTexto + 1, Len(For_Txt_Param4.Text))
        End If

        For_Txt_Param4.SetFocus
       
    End If

End Sub

Private Sub For_Lista_Operadores_DblClick()

    Dim X As String
    
    If PosFormula = 1 Then
    
        If PosTexto = 0 Then
            PosTexto = Len(For_Text_Formula.Text)
        End If
    
        If For_Text_Formula.Text = "" Then
            For_Text_Formula.Text = Arreglo_Operadores(For_Lista_Operadores.ListIndex, 3)
            Formula = Arreglo_Operadores(For_Lista_Operadores.ListIndex, 3)
        Else
        
            For_Text_Formula.Text = Mid$(For_Text_Formula.Text, 1, PosTexto) & " " & Trim(Arreglo_Operadores(For_Lista_Operadores.ListIndex, 3)) & " " & Mid$(For_Text_Formula.Text, PosTexto + 1, Len(For_Text_Formula.Text))
            Formula = Arreglo_Operadores(For_Lista_Operadores.ListIndex, 3)
        End If
        If For_Text_Formula.Enabled = True Then
            For_Text_Formula.SetFocus
        End If
    
    ElseIf PosFormula = 4 And For_Txt_Param3.Enabled = True Then
        
        If PosTexto = 0 Then
            PosTexto = Len(For_Txt_Param3.Text)
        End If
    
        If For_Txt_Param3.Text = "" Then
            For_Txt_Param3.Text = Arreglo_Operadores(For_Lista_Operadores.ListIndex, 3)
        Else
            For_Txt_Param3.Text = Mid$(For_Txt_Param3.Text, 1, PosTexto) & " " & Trim(Arreglo_Operadores(For_Lista_Operadores.ListIndex, 3)) & " " & Mid$(For_Txt_Param3.Text, PosTexto + 1, Len(For_Txt_Param3.Text))
        End If

        For_Txt_Param3.SetFocus
        
    ElseIf PosFormula = 5 And For_Txt_Param4.Enabled = True Then
        
        If PosTexto = 0 Then
            PosTexto = Len(For_Txt_Param4.Text)
        End If
    
        If For_Txt_Param4.Text = "" Then
            For_Txt_Param4.Text = Arreglo_Operadores(For_Lista_Operadores.ListIndex, 3)
        Else
            For_Txt_Param4.Text = Mid$(For_Txt_Param4.Text, 1, PosTexto) & " " & Trim(Arreglo_Operadores(For_Lista_Operadores.ListIndex, 3)) & " " & Mid$(For_Txt_Param4.Text, PosTexto + 1, Len(For_Txt_Param4.Text))
        End If
        
        For_Txt_Param4.SetFocus
       
    End If

End Sub


Private Sub For_Lista_Funciones_DblClick()

    Dim X As String
    
    If PosTexto = 0 Then
        PosTexto = Len(For_Text_Formula.Text)
    End If


    For_Text_Formula.Text = Arreglo_Funciones(For_Lista_Funciones.ListIndex, 3)
    Formula = Arreglo_Funciones(For_Lista_Funciones.ListIndex, 3)
    
    If Trim(Arreglo_Funciones(For_Lista_Funciones.ListIndex, 5)) <> "" Or Trim(Arreglo_Funciones(For_Lista_Funciones.ListIndex, 6)) <> "" Then
        For_Frm_ParFormula.Visible = True
    Else
        For_Frm_ParFormula.Visible = False
    End If
   
    
    If Trim(Arreglo_Funciones(For_Lista_Funciones.ListIndex, 5)) <> "" Then
        For_Txt_Param1.Enabled = True
        For_Txt_Param1.SetFocus
    Else
        For_Txt_Param1.Enabled = False
        For_Txt_Param1.Text = ""
    End If
    
    If Trim(Arreglo_Funciones(For_Lista_Funciones.ListIndex, 6)) <> "" Then
        For_Txt_Param2.Enabled = True
    Else
        For_Txt_Param2.Enabled = False
        For_Txt_Param2.Text = ""
    End If
    
   
    For_Text_Formula.Enabled = False
 

End Sub


Private Sub For_Text_Formula_Change()
    If For_Text_Formula.Text <> "" Then
        For_Cmd_Deshacer.Enabled = True
    Else
        For_Cmd_Deshacer.Enabled = False
    End If
End Sub


Private Sub Option1_Click()

End Sub

Private Sub Form_Unload(Cancel As Integer)

    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Salida de Pantalla de Fórmulas")

End Sub

Private Sub lbl_tas_vig_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        KeyAscii = 0
        txt_monto_pag.SetFocus
    Else
        Valorizar = True
    End If
End Sub

Private Sub Lbl_Tas_Vig_LostFocus()
    If Valorizar = True Then
        Valorizar = False
        Call Func_Valorizar(ModCal)
    End If
End Sub


Private Sub SSTab1_Click(PreviousTab As Integer)
'    If SSTab1.Tab = 0 Then
'        opcion = 1
'        tip_opt_tasa.Value = True
'    End If
    If SSTab1.Tab = 2 Then
        Call llena_For_Lista_Variables
        Call llena_For_Lista_Operadores
        Call llena_For_Lista_Funciones
        Call llena_Grilla_formulas(box_familia.ItemData(box_familia.ListIndex), box_familia.Text)
        Frame4.Enabled = False
        For_Frm_Variables.Enabled = False
        For_Frm_Operaciones.Enabled = False
    End If
    
    Call dibuja_grilla
    
    If SSTab1.Tab = 0 Then
        Call Func_Valorizar(ModCal)
    End If
End Sub

Private Sub tip_opt_tasa_Click()
    Opcion = 1
    
End Sub

Private Sub tip_opt_tir_Click()
    Opcion = 3
    
End Sub

Private Sub tip_opt_valor_Click()
    Opcion = 2
    
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case UCase(Button.Key)
        Case "LIMPIAR"
            Call Func_Limpiar
            Call Clear_Objetos
            box_familia.SetFocus

        Case "BUSCAR"
                Call buscar_datos
                If frm_descrip.Enabled = True Then
                    txt_fec_val.Text = Format(txt_fec_val.Text, "DD/MM/YYYY")
                    txt_fec_val.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
                End If

        Case "GRABAR"
                Call guardar_datos

        Case "IMPRIMIR"
            Call Func_Imprimir

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
        txt_tasa_int.SetFocus
    Else
        Valorizar = True
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
'       SendKeys "{TAB 1}"
         If lbl_tas_vig.Enabled = True Then
            lbl_tas_vig.SetFocus
         Else
            txt_tasa_int.SetFocus
         End If
    Else
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
        txt_nominal.SetFocus
    Else
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


Private Sub txt_Spread_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        KeyAscii = 0
        txt_monto_pag.SetFocus
    Else
        Valorizar = True
    End If

End Sub

Private Sub txt_Spread_LostFocus()
  If Valorizar = True Then
        Valorizar = False
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
    Else
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

