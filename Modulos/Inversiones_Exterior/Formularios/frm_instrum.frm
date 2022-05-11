VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_instrumentos 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Instrumentos Financieros"
   ClientHeight    =   7125
   ClientLeft      =   315
   ClientTop       =   1440
   ClientWidth     =   9945
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "frm_instrum.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7125
   ScaleWidth      =   9945
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9945
      _ExtentX        =   17542
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   2
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "frm_instrum.frx":030A
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   4800
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
               Picture         =   "frm_instrum.frx":0624
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_instrum.frx":0A76
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_instrum.frx":0B88
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_instrum.frx":0C9A
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_instrum.frx":0FB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_instrum.frx":12CE
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frm_coltes 
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
      Height          =   870
      Left            =   8760
      TabIndex        =   69
      Top             =   440
      Width           =   1193
      Begin VB.CheckBox Chk_Coltes 
         Caption         =   "Check1"
         Height          =   255
         Left            =   840
         TabIndex        =   71
         Top             =   240
         Width           =   255
      End
      Begin VB.Label Lbl_coltes 
         Caption         =   "COLTES"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   70
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame frm_instr 
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
      Height          =   870
      Left            =   0
      TabIndex        =   32
      Top             =   440
      Width           =   8745
      Begin VB.TextBox txt_descripcion 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1905
         MaxLength       =   50
         TabIndex        =   3
         Top             =   510
         Width           =   6570
      End
      Begin BACControles.TXTFecha txt_fec_vcto 
         Height          =   285
         Left            =   6960
         TabIndex        =   2
         Top             =   180
         Width           =   1530
         _ExtentX        =   2699
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
         Text            =   "22/11/2001"
      End
      Begin VB.TextBox txt_instrum 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   1900
         MaxLength       =   20
         MouseIcon       =   "frm_instrum.frx":1720
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   1
         Top             =   200
         Width           =   2655
      End
      Begin VB.Label Label1 
         Caption         =   "Instrumento"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   255
         Left            =   555
         TabIndex        =   34
         Top             =   255
         Width           =   1215
      End
      Begin VB.Label Label2 
         Caption         =   "Fecha Vencimiento"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   255
         Left            =   5280
         TabIndex        =   33
         Top             =   225
         Width           =   1695
      End
   End
   Begin VB.Frame frm_datos_int 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   5925
      Left            =   0
      TabIndex        =   30
      Top             =   1215
      Width           =   9960
      Begin VB.ComboBox cmbCurvas 
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
         Left            =   6105
         Style           =   2  'Dropdown List
         TabIndex        =   63
         Top             =   3195
         Width           =   3780
      End
      Begin VB.Frame Frame1 
         Caption         =   "Identificación"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   960
         Left            =   45
         TabIndex        =   51
         Top             =   3990
         Width           =   9870
         Begin VB.ComboBox txt_mercado 
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
            Left            =   3900
            TabIndex        =   61
            Top             =   555
            Width           =   2175
         End
         Begin VB.ComboBox txt_bbnumber 
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
            Left            =   7110
            TabIndex        =   59
            Top             =   210
            Width           =   2235
         End
         Begin VB.ComboBox txt_cusip 
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
            Left            =   3900
            TabIndex        =   58
            Top             =   210
            Width           =   2175
         End
         Begin VB.ComboBox txt_isin 
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
            Left            =   660
            TabIndex        =   57
            Top             =   210
            Width           =   2235
         End
         Begin VB.ComboBox cbx_serie 
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
            Left            =   660
            TabIndex        =   60
            Top             =   555
            Width           =   2235
         End
         Begin VB.Label Label23 
            AutoSize        =   -1  'True
            Caption         =   "Mercado"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Left            =   3120
            TabIndex        =   56
            Top             =   615
            Width           =   720
         End
         Begin VB.Label Label22 
            AutoSize        =   -1  'True
            Caption         =   "Serie"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Left            =   120
            TabIndex        =   55
            Top             =   615
            Width           =   435
         End
         Begin VB.Label Label7 
            Caption         =   "BB Number"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   4
            Left            =   6150
            TabIndex        =   54
            Top             =   285
            Width           =   915
         End
         Begin VB.Label Label7 
            Caption         =   "Cusip"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   195
            Index           =   3
            Left            =   3120
            TabIndex        =   53
            Top             =   300
            Width           =   495
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "ISIN"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   2
            Left            =   120
            TabIndex        =   52
            Top             =   300
            Width           =   300
         End
      End
      Begin VB.ComboBox CmbTCart 
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
         ItemData        =   "frm_instrum.frx":1932
         Left            =   7725
         List            =   "frm_instrum.frx":1934
         Style           =   2  'Dropdown List
         TabIndex        =   50
         Top             =   1860
         Width           =   2100
      End
      Begin BACControles.TXTNumero txt_Spread 
         Height          =   315
         Left            =   4200
         TabIndex        =   8
         Top             =   1200
         Width           =   1065
         _ExtentX        =   1879
         _ExtentY        =   556
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
      Begin BACControles.TXTFecha txt_fec_pago 
         Height          =   315
         Left            =   2145
         TabIndex        =   11
         Top             =   2265
         Width           =   1410
         _ExtentX        =   2487
         _ExtentY        =   556
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
         Text            =   "02/07/2002"
      End
      Begin BACControles.TXTNumero txt_dias 
         Height          =   315
         Left            =   7710
         TabIndex        =   24
         Top             =   2445
         Width           =   2085
         _ExtentX        =   3678
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
      End
      Begin BACControles.TXTNumero txt_nro_cupo 
         Height          =   315
         Left            =   7725
         TabIndex        =   19
         Top             =   795
         Width           =   2085
         _ExtentX        =   3678
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
      End
      Begin BACControles.TXTNumero txt_tasa_emi 
         Height          =   315
         Left            =   2145
         TabIndex        =   7
         Top             =   1200
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   556
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
      Begin BACControles.TXTNumero txt_monto_emi 
         Height          =   315
         Left            =   2145
         TabIndex        =   6
         Top             =   855
         Width           =   3135
         _ExtentX        =   5530
         _ExtentY        =   556
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
         Max             =   "99999999999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txt_cod_cli 
         Height          =   315
         Left            =   4200
         TabIndex        =   15
         Top             =   3330
         Width           =   1065
         _ExtentX        =   1879
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
      End
      Begin BACControles.TXTNumero txt_rut_emi 
         Height          =   315
         Left            =   2145
         TabIndex        =   14
         Top             =   3330
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
      End
      Begin VB.ComboBox Box_Base 
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
         Left            =   7725
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   1140
         Width           =   2085
      End
      Begin VB.ComboBox box_año 
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
         Left            =   5340
         Style           =   2  'Dropdown List
         TabIndex        =   22
         Top             =   2265
         Visible         =   0   'False
         Width           =   525
      End
      Begin VB.ComboBox box_dia 
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
         Left            =   5355
         Style           =   2  'Dropdown List
         TabIndex        =   21
         Top             =   1905
         Visible         =   0   'False
         Width           =   525
      End
      Begin BACControles.TXTFecha txt_fec_emi 
         Height          =   300
         Left            =   2145
         TabIndex        =   5
         Top             =   525
         Width           =   1410
         _ExtentX        =   2487
         _ExtentY        =   529
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958101
         MinDate         =   2
         Text            =   "01/01/1900"
      End
      Begin VB.ComboBox box_perio_cap 
         Enabled         =   0   'False
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
         ItemData        =   "frm_instrum.frx":1936
         Left            =   2145
         List            =   "frm_instrum.frx":193D
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   1545
         Width           =   3165
      End
      Begin VB.ComboBox box_monpag 
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
         Left            =   2145
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   2970
         Width           =   3165
      End
      Begin VB.ComboBox box_monemi 
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
         Left            =   2145
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   2610
         Width           =   3165
      End
      Begin VB.ComboBox box_tip_tasa 
         Enabled         =   0   'False
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
         ItemData        =   "frm_instrum.frx":1944
         Left            =   2145
         List            =   "frm_instrum.frx":1946
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   165
         Width           =   3165
      End
      Begin VB.ComboBox box_basilea 
         Enabled         =   0   'False
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
         ItemData        =   "frm_instrum.frx":1948
         Left            =   7725
         List            =   "frm_instrum.frx":194A
         Style           =   2  'Dropdown List
         TabIndex        =   23
         Top             =   1500
         Width           =   2085
      End
      Begin VB.ComboBox box_periodo 
         Enabled         =   0   'False
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
         ItemData        =   "frm_instrum.frx":194C
         Left            =   2145
         List            =   "frm_instrum.frx":1953
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   1905
         Width           =   3165
      End
      Begin VB.Frame frm_opciones 
         Height          =   525
         Left            =   7755
         TabIndex        =   31
         Top             =   120
         Width           =   2070
         Begin VB.OptionButton Option2 
            Caption         =   "No"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   255
            Left            =   1260
            TabIndex        =   18
            Top             =   165
            Width           =   675
         End
         Begin VB.OptionButton Option1 
            Caption         =   "Si"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   255
            Left            =   255
            TabIndex        =   17
            Top             =   165
            Width           =   735
         End
      End
      Begin VB.Frame Frm_D05 
         Caption         =   "Informe D05"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   915
         Left            =   60
         TabIndex        =   64
         Top             =   4935
         Width           =   9855
         Begin VB.ComboBox CmbClasificacion 
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
            Left            =   6705
            Style           =   2  'Dropdown List
            TabIndex        =   68
            Top             =   330
            Width           =   2220
         End
         Begin VB.ComboBox CmbAgencia 
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
            Left            =   1290
            Style           =   2  'Dropdown List
            TabIndex        =   66
            Top             =   330
            Width           =   3960
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "CLASIFICACION"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   6
            Left            =   5340
            TabIndex        =   67
            Top             =   390
            Width           =   1260
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "AGENCIA"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   5
            Left            =   480
            TabIndex        =   65
            Top             =   405
            Width           =   720
         End
      End
      Begin VB.Label Label24 
         AutoSize        =   -1  'True
         Caption         =   "Curva de Tasas"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   6120
         TabIndex        =   62
         Top             =   2985
         Width           =   1275
      End
      Begin VB.Label Label21 
         Caption         =   "Tipo cartera por defecto"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   390
         Left            =   6090
         TabIndex        =   49
         Top             =   1875
         Width           =   1530
      End
      Begin VB.Label Label20 
         AutoSize        =   -1  'True
         Caption         =   " %"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   5310
         TabIndex        =   48
         Top             =   1245
         Width           =   180
      End
      Begin VB.Label Label14 
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
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   3585
         TabIndex        =   47
         Top             =   1260
         Width           =   585
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Cód."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   1
         Left            =   3585
         TabIndex        =   46
         Top             =   3390
         Width           =   375
      End
      Begin VB.Label Label11 
         Caption         =   "Nº Días Habiles (Valor Moneda)"
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
         ForeColor       =   &H80000007&
         Height          =   570
         Left            =   6090
         TabIndex        =   25
         Top             =   2385
         Width           =   1395
      End
      Begin VB.Label Label13 
         Alignment       =   2  'Center
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   5580
         TabIndex        =   26
         Top             =   2790
         Visible         =   0   'False
         Width           =   210
      End
      Begin VB.Label Label19 
         AutoSize        =   -1  'True
         Caption         =   "Período Capital"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   510
         TabIndex        =   27
         Top             =   1605
         Width           =   1245
      End
      Begin VB.Label Label18 
         AutoSize        =   -1  'True
         Caption         =   "Bases De Tasas"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   6090
         TabIndex        =   28
         Top             =   1200
         Width           =   1305
      End
      Begin VB.Label Label17 
         AutoSize        =   -1  'True
         Caption         =   "Moneda Pago"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Left            =   510
         TabIndex        =   29
         Top             =   3060
         Width           =   1185
      End
      Begin VB.Label Label15 
         AutoSize        =   -1  'True
         Caption         =   "Moneda Emisión"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   195
         Left            =   510
         TabIndex        =   45
         Top             =   2670
         Width           =   1395
      End
      Begin VB.Label Label16 
         AutoSize        =   -1  'True
         Caption         =   "Monto Emisión"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   510
         TabIndex        =   44
         Top             =   915
         Width           =   1230
      End
      Begin VB.Label lbl_nom_cli 
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
         Left            =   2145
         TabIndex        =   16
         Top             =   3675
         Width           =   7725
      End
      Begin VB.Label Label3 
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
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   510
         TabIndex        =   43
         Top             =   255
         Width           =   1050
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Fecha 1º Pago"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   510
         TabIndex        =   42
         Top             =   2250
         Width           =   1125
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Basilea"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   6090
         TabIndex        =   41
         Top             =   1560
         Width           =   585
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Deducción a Encaje"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   6090
         TabIndex        =   40
         Top             =   270
         Width           =   1560
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Emisor"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   0
         Left            =   510
         TabIndex        =   39
         Top             =   3420
         Width           =   585
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "Tasa de Emisión"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   510
         TabIndex        =   38
         Top             =   1260
         Width           =   1350
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "Período Interés"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   510
         TabIndex        =   37
         Top             =   1965
         Width           =   1290
      End
      Begin VB.Label Label10 
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
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   510
         TabIndex        =   36
         Top             =   570
         Width           =   1440
      End
      Begin VB.Label Label12 
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
         ForeColor       =   &H80000007&
         Height          =   210
         Left            =   6090
         TabIndex        =   35
         Top             =   855
         Width           =   1215
      End
   End
End
Attribute VB_Name = "Bac_instrumentos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Dato As String
Dim resrc As String
Dim SQL As String
Dim Base_Tasa As Double
Dim base_flujo As Double
Dim Dias As Double
Dim Limpio
Dim Calculo
Dim Fecha_pagos
Dim objDCartera As New clsDCarteras
Dim objTipCar   As New clsCodigos

Private Enum QueCarga
    [Agencias] = 1
    [Clasificadoras] = 2
End Enum
   
Function busca_datos()
    Dim SQL       As String, num
    Dim pl
    Dim Datos()
    Dim i         As Double
    
    If txt_instrum.Text = "" Then
        MsgBox "Debe Ingresar Un Instrumento", vbInformation, gsBac_Version
        txt_instrum.SetFocus
        Exit Function
    ElseIf DateDiff("d", gsBac_Fecp, txt_fec_vcto.Text) < 1 Then
        MsgBox "Fecha de Vencimiento No debe ser Menor o Igual A La De Operación", vbExclamation, gsBac_Version
        txt_fec_vcto.SetFocus
        Exit Function
    End If
    instru = txt_instrum.Text
    envia = Array()
    AddParam envia, instru
    AddParam envia, txt_fec_vcto.Text
    If Bac_Sql_Execute("SVC_AYD_SER_INS", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            If Datos(1) = "0" Then
                Exit Do
            End If
            pl = 1
            txt_fec_vcto.Text = Format(Datos(10), "dd/mm/yyyy")
            txt_descripcion = Datos(3)
            
            For i = 0 To cmbCurvas.ListCount - 1
               If cmbCurvas.List(i) = Datos(30) Then
                  cmbCurvas.Text = Datos(30)
                  Exit For
               End If
            Next i
            
            For i = 0 To box_basilea.ListCount - 1
                box_basilea.ListIndex = i
                If box_basilea.ItemData(box_basilea.ListIndex) = Val(Datos(6)) Then
                    Call BacControlWindows(20)
                    Exit For
                End If
                box_basilea.ListIndex = -1
            Next
            For i = 0 To box_periodo.ListCount - 1
                box_periodo.ListIndex = i
                If box_periodo.ItemData(box_periodo.ListIndex) = Val(Datos(7)) Then
                    Call BacControlWindows(20)
                    Exit For
                End If
                box_periodo.ListIndex = -1
            Next
            For i = 0 To box_perio_cap.ListCount - 1
                box_perio_cap.ListIndex = i
                If box_perio_cap.ItemData(box_perio_cap.ListIndex) = Val(Datos(24)) Then
                    Call BacControlWindows(20)
                    Exit For
                End If
                box_perio_cap.ListIndex = -1
            Next
            txt_fec_pago.Text = Format(Datos(15), "dd/mm/yyyy")
            
            
            txt_tasa_emi.Text = CDbl(Datos(12))
            txt_fec_emi.Text = Format(Datos(9), "dd/mm/yyyy")

            For i = 0 To box_año.ListCount - 1
                box_año.ListIndex = i
                If box_año.Text = Datos(13) Then
                    Call BacControlWindows(20)
                    Exit For
                End If
                box_año.ListIndex = -1
            Next
            Box_Base.ListIndex = box_año.ListIndex

            txt_nro_cupo.Text = Val(Datos(8))
            If Datos(11) = "S" Then
                Option1.Value = True
            ElseIf Datos(11) = "N" Then
                Option2.Value = True
            Else
                Option1.Value = False
                Option2.Value = False
            End If
            txt_fec_pago.Text = Format(Datos(15), "dd/mm/yyyy")
            If Datos(16) = "T" Then
                For i = 0 To box_dia.ListCount - 1
                    box_dia.ListIndex = i
                    If UCase(box_dia.Text) = "REAL" Then
                        Call BacControlWindows(20)
                        Exit For
                    End If
                    box_dia.ListIndex = -1
                Next
            ElseIf Datos(16) = "F" Then
                For i = 0 To box_dia.ListCount - 1
                    box_dia.ListIndex = i
                    If box_dia.Text = "30" Then
                        Call BacControlWindows(20)
                        Exit For
                    End If
                    box_dia.ListIndex = -1
                Next
            End If
            ltasfija = Datos(18)
            txt_rut_emi.Text = Datos(4)
            txt_monto_emi.Text = Format(Datos(19), "0.0000")
            
            lbl_nom_cli.Caption = Datos(20)
            txt_fec_pago.Text = Format(Datos(15), "dd/mm/yyyy")
            For i = 0 To box_monemi.ListCount - 1
                box_monemi.ListIndex = i
                If box_monemi.ItemData(box_monemi.ListIndex) = Val(Datos(21)) Then
                    Call BacControlWindows(20)
                    Exit For
                End If
                box_monemi.ListIndex = -1
            Next
            For i = 0 To box_monpag.ListCount - 1
                box_monpag.ListIndex = i
                If box_monpag.ItemData(box_monpag.ListIndex) = Val(Datos(22)) Then
                    Call BacControlWindows(20)
                    Exit For
                End If
                box_monpag.ListIndex = -1
            Next
            
            Call Llena_Combo_tasas
            
            For i = 0 To box_tip_tasa.ListCount - 1
                box_tip_tasa.ListIndex = i
                If box_tip_tasa.ItemData(box_tip_tasa.ListIndex) = Val(Datos(5)) And Val(Trim(Mid(box_tip_tasa, (Len(box_tip_tasa) - 20), 10))) = Val(Datos(28)) Then
                    Call BacControlWindows(20)
                    Exit For
                End If
                box_tip_tasa.ListIndex = -1
            Next
            
            '+++COLTES, jcamposd 20171207
            Chk_Coltes.Value = Datos(33)
            '---COLTES, jcamposd 20171207
            
            Call enable_true
            box_tip_tasa.SetFocus
            txt_cod_cli.Text = CDbl(Datos(25))
            Toolbar1.Buttons(1).Enabled = True
            Toolbar1.Buttons(2).Enabled = True
            Toolbar1.Buttons(3).Enabled = False
            frm_datos_int.Enabled = True
            frm_instr.Enabled = False
            txt_dias.Text = CDbl(Datos(26))
            If Datos(11) = "S" Then
                Option1.Value = True
            ElseIf Datos(11) = "N" Then
                Option2.Value = True
            Else
                Option1.Value = False
                Option2.Value = False
            End If
            txt_fec_pago.Text = Format(Datos(15), "dd/mm/yyyy")
            
            '**Consulta Incluir campos Identificacion y mercados
              Call Busca_Identificadores(instru)
            
            '**fin
            txt_Spread.Text = CDbl(Datos(27))
            If box_tip_tasa.ListIndex <> -1 Then
               If box_tip_tasa.ItemData(box_tip_tasa.ListIndex) = 1 Or box_tip_tasa.ItemData(box_tip_tasa.ListIndex) = 0 Then
                   txt_Spread.Enabled = False
               Else
                   txt_Spread.Enabled = True
               End If
            End If
           
           
            For i = 0 To CmbTCart.ListCount - 1
                CmbTCart.ListIndex = i
                If CmbTCart.ItemData(CmbTCart.ListIndex) = Val(Datos(29)) Then
                    Exit For
                End If
                CmbTCart.ListIndex = -1
            Next
            
            For i = 0 To CmbAgencia.ListCount - 1
                If CmbAgencia.ItemData(i) = Val(Datos(31)) Then
                    CmbAgencia.ListIndex = i
                    CmbClasificacion.Text = Datos(32)
                    Exit For
                End If
            Next i
            
            Call BacControlWindows(20)
            
            'coltes aqui
            If Chk_Coltes Then
                Box_Base.Enabled = False
            Else
                Box_Base.Enabled = True
            End If
            Chk_Coltes.Enabled = False

            Exit Function
        Loop
            resrc = MsgBox("Instrumento No Existe, ¿ Desea Ingresarlo ? ", vbQuestion + vbYesNo + vbDefaultButton1, gsBac_Version)
            
             If resrc = vbYes Then
                Limpio = False
                txt_instrum.Enabled = False
                txt_fec_vcto.Enabled = False
                txt_descripcion.Enabled = True
                frm_datos_int.Enabled = True
                
                Dim OpC
                OpC = txt_instrum.Text
                Call Clear_Objetos("S")
                Toolbar1.Buttons(1).Enabled = False
                Toolbar1.Buttons(2).Enabled = False
                'txt_fec_vcto.Text = Format(paso, "dd/mm/yyyy")
                Toolbar1.Buttons(3).Enabled = False
                txt_instrum.Text = OpC
                txt_descripcion.Enabled = True
                txt_descripcion.SetFocus
            Else
                Call Clear_Objetos(" ")
                Me.txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
            End If
    End If
End Function


Sub Busca_Identificadores(nemo As String)
    Dim SQL As String
    Dim Datos()

    txt_isin.Clear
    txt_cusip.Clear
    txt_bbnumber.Clear
    txt_mercado.Clear
    cbx_serie.Clear
    
    txt_isin.AddItem ("Nuevo"): txt_isin.ItemData(txt_isin.NewIndex) = 0
    txt_cusip.AddItem ("Nuevo"): txt_cusip.ItemData(txt_cusip.NewIndex) = 0
    txt_bbnumber.AddItem ("Nuevo"): txt_bbnumber.ItemData(txt_bbnumber.NewIndex) = 0
    txt_mercado.AddItem ("Nuevo"): txt_mercado.ItemData(txt_mercado.NewIndex) = 0
    cbx_serie.AddItem ("Nuevo"): cbx_serie.ItemData(cbx_serie.NewIndex) = 0

    envia = Array()
    AddParam envia, Trim(nemo)
    If Bac_Sql_Execute("SVC_BUS_IDENT", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            If Datos(1) = "0" Then
                Exit Do
            End If
            If Datos(2) <> "" Then
                txt_isin.AddItem Datos(2)
                txt_isin.ItemData(txt_isin.NewIndex) = Val(Datos(1))
            End If
            If Datos(3) <> "" Then
                txt_cusip.AddItem (Datos(3))
                txt_cusip.ItemData(txt_cusip.NewIndex) = Val(Datos(1))
            End If
            If Datos(4) <> "" Then
                txt_bbnumber.AddItem (Datos(4))
                txt_bbnumber.ItemData(txt_bbnumber.NewIndex) = Val(Datos(1))
            End If
            If Datos(5) <> "" Then
                txt_mercado.AddItem (Datos(5))
                txt_mercado.ItemData(txt_mercado.NewIndex) = Val(Datos(1))
            End If
            If Datos(6) <> "" Then
                cbx_serie.AddItem (Datos(6))
                cbx_serie.ItemData(cbx_serie.NewIndex) = Val(Datos(1))
            End If
            
        Loop
    End If
End Sub


Function busca_emisor(rut, Cod_cli)
    busca_emisor = 0
    If rut = "0" Or Not IsNumeric(rut) Then
        Exit Function
    End If
    Dim Datos()
    envia = Array()
    AddParam envia, CDbl(rut)
    AddParam envia, CDbl(Cod_cli)
    If Bac_Sql_Execute("SVC_OPE_DAT_EMI", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            If Datos(1) <> 0 Then
                lbl_nom_cli.Caption = Datos(1)
            End If
        Loop
    End If
    If Datos(1) = 0 Then
        MsgBox "Rut Inexsistente", vbExclamation, gsBac_Version
        lbl_nom_cli.Caption = " "
        txt_rut_emi.Text = ""
'        txt_rut_emi.SetFocus
        Exit Function
    End If
    busca_emisor = Datos(1)
End Function

Function buscar_datos_ayuda()
    Dim SQL As String
    Dim Datos()
    Dim reg As Integer
    
    If Bac_Sql_Execute("SVC_INS_VER_DAT") Then
       Do While Bac_SQL_Fetch(Datos)
            reg = Datos(1)
       Loop
    Else
        MsgBox "Problemas En SQL", vbCritical, gsBac_Version
    End If
    If reg = 0 Then
        MsgBox "No Exixten Elementos De Ayuda ", vbExclamation, gsBac_Version
    Else
        BacAyuda.Tag = "INSTRU"
        BacAyuda.Show 1
        If giAceptar% = True Then
            txt_instrum.Text = gsBac_VarString
            txt_fec_vcto.Text = gsBac_VarString2
            Call busca_datos
            frm_instr.Enabled = False
            Limpio = False
        Else
            SendKeys "{TAB 2}"
        End If
    End If
    
'    If Trim(Fecha_pagos) <> "" Then
'        txt_fec_pago.Text = Fecha_pagos
'    End If
End Function

Function Clear_Objetos(Op)
    Limpio = True
    If Op = " " Then
        txt_dias.Text = ""

        txt_instrum.Enabled = True
        box_perio_cap.ListIndex = -1
        txt_instrum.Text = ""
        txt_descripcion.Text = ""
        box_tip_tasa.ListIndex = -1
        box_periodo.ListIndex = -1
        box_basilea.ListIndex = -1
        Option1.Value = False
        Option2.Value = False
        box_año.ListIndex = -1
        box_dia.ListIndex = -1
        Box_Base.ListIndex = -1
        txt_tasa_emi.Text = ""
        
        '+++jcamposd bono colombiano, tener fecha 1900 induce a error en grabación
        txt_fec_emi.Text = Format(gsBac_Feca, "DD/MM/YYYY")  '"01/01/1900"
        txt_fec_pago.Text = Format(gsBac_Fecx, "DD/MM/YYYY") '"01/01/1900"
        '---jcamposd bono colombiano, tener fecha 1900 induce a error en grabación

        txt_nro_cupo.Text = ""
        
        txt_rut_emi.Text = 0
        txt_monto_emi.Text = 0
        lbl_nom_cli.Caption = " "
        Toolbar1.Buttons(1).Enabled = False
        Toolbar1.Buttons(2).Enabled = False
        frm_instr.Enabled = True
        txt_descripcion.Enabled = False
        Toolbar1.Buttons(3).Enabled = True
        frm_datos_int.Enabled = False
        txt_instrum.Enabled = True
        txt_fec_vcto.Enabled = True
        box_monemi.ListIndex = -1
        box_monpag.ListIndex = -1
        box_monemi.Enabled = False
        box_monpag.Enabled = False
        txt_Spread.Text = ""
        txt_isin.Text = ""
        txt_cusip.Text = ""
        txt_bbnumber.Text = ""
        cbx_serie.Clear
        txt_mercado.Text = ""
        
        CmbAgencia.ListIndex = -1
        CmbClasificacion.ListIndex = -1
        
        '+++COLTES, jcamposd 20171207
        Chk_Coltes.Value = 0
        Chk_Coltes.Enabled = True
        '---COLTES, jcamposd 20171207

        Call enable_false
    Else
        txt_dias.Text = ""

        box_perio_cap.ListIndex = -1
        box_monemi.ListIndex = -1
        box_monpag.ListIndex = -1
        box_monemi.Enabled = False
        box_monpag.Enabled = False
        txt_instrum.Text = ""
        txt_descripcion.Text = ""
        box_tip_tasa.ListIndex = -1
        box_periodo.ListIndex = -1
        box_basilea.ListIndex = -1
        Option1.Value = False
        Option2.Value = False
'       Option3.Value = False
'       Option4.Value = False
        txt_tasa_emi.Text = ""
        
        '+++jcamposd bono colombiano, tener fecha 1900 induce a error en grabación
        txt_fec_emi.Text = Format(gsBac_Feca, "DD/MM/YYYY")  '"01/01/1900"
        txt_fec_pago.Text = Format(gsBac_Fecx, "DD/MM/YYYY") '"01/01/1900"
        '---jcamposd bono colombiano, tener fecha 1900 induce a error en grabación
        
'       txt_base_tasa.Text = "   "
        txt_nro_cupo.Text = ""
                
        txt_rut_emi.Text = 0
        txt_monto_emi.Text = 0
        lbl_nom_cli.Caption = " "
        txt_Spread.Text = ""
        
        txt_isin.Clear
        txt_cusip.Clear
        txt_bbnumber.Clear
        cbx_serie.Clear
        txt_mercado.Clear
        
        Toolbar1.Buttons(1).Enabled = False
        Toolbar1.Buttons(2).Enabled = False
        frm_instr.Enabled = True
        txt_descripcion.Enabled = False
        Toolbar1.Buttons(3).Enabled = True
        frm_datos_int.Enabled = False
        
        CmbAgencia.ListIndex = -1
        CmbClasificacion.ListIndex = -1

        '+++COLTES, jcamposd 20171207
        Chk_Coltes.Value = 0
        '---COLTES, jcamposd 20171207


        Call enable_false
    End If
End Function

Function diferencia_fechas()
    If txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY") Or txt_fec_pago.Text = Format(gsBac_Fecp, "DD/MM/YYYY") Or box_periodo.ListIndex = -1 Then
        Exit Function
    End If
    Dim sw
    Dim total
    total = Round(DateDiff("m", txt_fec_emi.Text, Me.txt_fec_vcto.Text) / (box_periodo.ItemData(box_periodo.ListIndex)), 0)
    If CDbl(Val(total)) > 0 Then
        txt_nro_cupo.Text = (Val(total))
    Else
        txt_nro_cupo.Text = 1
    End If
End Function

Function eliminar_de_la_tabla_instrumentos()
    Dim SQL As String
    Dim Datos()
    envia = Array()
    AddParam envia, 2000
    AddParam envia, txt_instrum.Text
    AddParam envia, txt_fec_vcto.Text
    If Bac_Sql_Execute("SVA_INS_ELI_REG", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            If Datos(1) = "NO" Then
                MsgBox Datos(2), vbExclamation, gsBac_Version
                Exit Function
            End If

        Loop

        Call Clear_Objetos("S")
        Call Clear_Objetos(" ")
        Call enable_false
        txt_instrum.Text = ""
        txt_fec_vcto.Text = "01/01/1900"
        txt_instrum.SetFocus
    Else
        MsgBox "Error al Eliminar Instrumentos", vbExclamation, gsBac_Version
    End If

End Function
Function enable_false()
    txt_fec_pago.Enabled = False
    box_perio_cap.Enabled = False
    box_tip_tasa.Enabled = False
    box_basilea.Enabled = False
    Option1.Enabled = False
    Option2.Enabled = False
    txt_tasa_emi.Enabled = False
    box_periodo.Enabled = False
    txt_fec_emi.Enabled = False
    box_año.Enabled = False
    box_dia.Enabled = False
    Box_Base.Enabled = False
    frm_datos_int.Enabled = False
    box_perio_cap.Enabled = False
    txt_rut_emi.Enabled = False
    txt_monto_emi.Enabled = False
    txt_cod_cli.Enabled = False
    box_monpag.Enabled = False
    box_monemi.Enabled = False
    txt_Spread.Enabled = False
End Function

Function enable_true()
    
    txt_fec_pago.Enabled = True
    box_perio_cap.Enabled = True
    box_tip_tasa.Enabled = True
    box_basilea.Enabled = True
    Option1.Enabled = True
    Option2.Enabled = True
    txt_tasa_emi.Enabled = True
    box_periodo.Enabled = True
    txt_fec_emi.Enabled = True
    box_dia.Enabled = True
    box_año.Enabled = True
    Box_Base.Enabled = True
    frm_datos_int.Enabled = True
    box_perio_cap.Enabled = True
    txt_rut_emi.Enabled = True
    txt_monto_emi.Enabled = True
    txt_cod_cli.Enabled = True
    box_monpag.Enabled = True
    box_monemi.Enabled = True
    txt_Spread.Enabled = True
    
End Function

Function Fecha_de_pago()
'If Calculo = True Then
'    If box_periodo.ListIndex <> -1 Then
'        If txt_fec_emi.Text <> Format(gsBac_Fecp, "DD/MM/YYYY") Then
'            Dim Periodo As Double
'            Periodo = box_periodo.ItemData(box_periodo.ListIndex)
'            txt_fec_pago.Text = Format(DateAdd("M", Periodo, txt_fec_emi.Text), "DD/MM/YYYY")
'            Calculo = False
'        End If
'    End If
'End If
End Function

Function grabar_datos()
   Dim SQL    As String
   Dim p      As Integer
   Dim num    As Double
   Dim rut    As Double
   Dim res
   Dim res1
   Dim Datos()

   num = 2000
   rut = CDbl(txt_rut_emi.Text)
    
   envia = Array()
   AddParam envia, num                                             '--> 01
   AddParam envia, txt_instrum.Text                                '--> 02
   AddParam envia, txt_descripcion.Text                            '--> 03
   AddParam envia, rut                                             '--> 04
   AddParam envia, box_tip_tasa.ItemData(box_tip_tasa.ListIndex)   '--> 05
   AddParam envia, box_basilea.ItemData(box_basilea.ListIndex)     '--> 06
   AddParam envia, box_periodo.ItemData(box_periodo.ListIndex)     '--> 07
   AddParam envia, Val(txt_nro_cupo.Text)                          '--> 08
   AddParam envia, txt_fec_emi.Text                                '--> 09
   AddParam envia, txt_fec_vcto.Text                               '--> 10
   AddParam envia, IIf(Option1.Value = True, "S", "N")             '--> 13
   AddParam envia, CDbl(txt_tasa_emi.Text)                         '--> 12
   AddParam envia, CDbl(box_año.Text)                              '--> 13
   AddParam envia, CDbl(txt_tasa_emi.Text)                                                          '--> 14
   AddParam envia, txt_fec_pago.Text                                                                '--> 15
   AddParam envia, IIf(box_dia.ListIndex = 0, "F", "T")                                             '--> 16
   AddParam envia, CDbl(box_año.Text)                                                               '--> 17
   AddParam envia, IIf(Val(Mid(box_tip_tasa.ItemData(box_tip_tasa.ListIndex), 1, 1)) = 1, "T", "F") '--> 18
   AddParam envia, CDbl(txt_monto_emi.Text)                        '--> 19
   AddParam envia, box_monemi.ItemData(box_monemi.ListIndex)
   AddParam envia, box_monpag.ItemData(box_monpag.ListIndex)
   AddParam envia, 0
   AddParam envia, box_perio_cap.ItemData(box_perio_cap.ListIndex)
   AddParam envia, CDbl(txt_cod_cli.Text)
   AddParam envia, txt_dias.Text
   AddParam envia, CDbl(txt_Spread.Text)
   AddParam envia, CDbl(Trim(Mid(box_tip_tasa, (Len(box_tip_tasa) - 20), 10)))
   AddParam envia, CDbl(CmbTCart.ItemData(CmbTCart.ListIndex))
   AddParam envia, IIf(cmbCurvas.ListIndex = -1, "", cmbCurvas.Text)
   
   AddParam envia, CmbAgencia.ItemData(CmbAgencia.ListIndex)                '--> (Informe Normativo D-05)
   AddParam envia, Trim(CmbClasificacion.List(CmbClasificacion.ListIndex))  '--> (Informe Normativo D-05)
   AddParam envia, Chk_Coltes.Value  '--> (Informe Normativo D-05)
   
   If Bac_Sql_Execute("SVA_INS_GRB_DAT", envia) Then
      '**Incorporar datos de Identificación y mercado
      envia = Array()
      AddParam envia, Trim(txt_instrum.Text)
      AddParam envia, Trim(txt_isin.Text)
      AddParam envia, Trim(txt_cusip.Text)
      AddParam envia, Trim(txt_bbnumber.Text)
      AddParam envia, Trim(cbx_serie.Text)
      AddParam envia, Trim(txt_mercado.Text)
      If txt_isin.ListIndex = -1 Then
         AddParam envia, 0
      Else
         AddParam envia, txt_isin.ItemData(txt_isin.ListIndex)
      End If


      If Bac_Sql_Execute("SVA_INS_GRB_DAT_SI", envia) Then
         Do While Bac_SQL_Fetch(Datos)
         Loop
         Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Datos del Instrumento " & txt_descripcion.Text & " se grabaron con éxito.")
         MsgBox "Datos Grabados Con Exito", vbInformation, TITSISTEMA
         Clear_Objetos (" ")
         txt_fec_vcto.Text = "01/01/1900"
         Exit Function
      Else
         Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas al grabar Datos del Instrumento " & txt_descripcion.Text)
         MsgBox "Problemas Con SQL", vbCritical, TITSISTEMA
         Exit Function
      End If
   Else
      Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas al grabar Datos del Instrumento " & txt_descripcion.Text)
      MsgBox "Problemas Con SQL", vbCritical, TITSISTEMA
      Exit Function
   End If

End Function


Function llena_all_combos_basilea()
 Dim SQL As String
    Dim Datos()
    Dim num
        
    If Bac_Sql_Execute("SVC_INS_LEE_DAT") Then
        Do While Bac_SQL_Fetch(Datos)
            box_basilea.ListIndex = 0
            num = 0
            num = Val(Datos(6))
            box_basilea.ItemData(box_basilea.ListIndex) = num
        Loop
    End If
        
End Function
Function Llena_Combo_modedas_emi()
    Dim Datos()
    box_monemi.Clear
    If Bac_Sql_Execute("SVC_OPE_COD_MON") Then
        Do While Bac_SQL_Fetch(Datos)
            box_monemi.AddItem Datos(2)
            box_monemi.ItemData(box_monemi.NewIndex) = Val(Datos(1))
        Loop
            
    End If
End Function
Function Llena_Combo_monedas_pag()
    Dim Datos()
    box_monpag.Clear
    If Bac_Sql_Execute("SVC_OPE_COD_MON") Then
        Do While Bac_SQL_Fetch(Datos)
            box_monpag.AddItem Datos(2)
            box_monpag.ItemData(box_monpag.NewIndex) = Val(Datos(1))
        Loop
            
    End If
End Function


Function LLENA_COMBO_TASA_BASE()
   Dim Datos()
    
   box_dia.Clear
   box_año.Clear
   Box_Base.Clear
   If Bac_Sql_Execute("SVC_OPE_LEE_TAS") Then
      Do While Bac_SQL_Fetch(Datos)
         box_dia.AddItem Datos(1)
         box_año.AddItem Datos(2)
         Box_Base.AddItem Datos(3)
      Loop
   End If
   
End Function


Function valida_datos()
   Dim Datos()
   
   envia = Array()
   AddParam envia, txt_rut_emi.Text
   AddParam envia, txt_cod_cli.Text
   If Bac_Sql_Execute("SVC_OPE_DAT_EMI", envia) Then
      If Bac_SQL_Fetch(Datos) Then
         If Datos(1) = 0 Then
            MsgBox "Rut o código del Emisor no son válidos", vbExclamation, TITSISTEMA
            txt_rut_emi.SetFocus
            Exit Function
         End If
      End If
   End If
    
   If txt_cod_cli.Text = " " Then
      MsgBox "Ingrese Código de Emisor", vbExclamation, TITSISTEMA
      txt_cod_cli.SetFocus
   ElseIf txt_fec_emi.Text = Format(gsBac_Fecp, "DD/MM/YYYY") Then
      MsgBox "Ingrese Fecha De Emisión", vbExclamation, Caption
      txt_fec_emi.SetFocus
   ElseIf box_basilea.Text = "" Then
      MsgBox "Ingrese Indice Basilea", vbExclamation, TITSISTEMA
      box_basilea.SetFocus
   ElseIf box_tip_tasa.Text = "" Then
      MsgBox "Ingrese Tipo De Tasa", vbExclamation, TITSISTEMA
      box_tip_tasa.SetFocus
   ElseIf box_periodo.Text = "" Then
      MsgBox "Ingrese Período de Interes", vbExclamation, TITSISTEMA
      box_periodo.SetFocus
   ElseIf (Option1.Value = False And Option2.Value = False) Then
      MsgBox "Seleccione Deducción de Encaje", vbExclamation, TITSISTEMA
      Option1.SetFocus
   ElseIf box_dia.ListIndex = -1 Then
      MsgBox "Seleccione Días ", vbExclamation, TITSISTEMA
      box_dia.SetFocus
   ElseIf box_año.ListIndex = -1 Then
      MsgBox "Seleccione Base", vbExclamation, TITSISTEMA
      Box_Base.SetFocus
   ElseIf box_año.ListIndex = -1 Then
      MsgBox "Seleccione Base", vbExclamation, TITSISTEMA
      Box_Base.SetFocus
   ElseIf txt_tasa_emi.Text = "" Then
      MsgBox "Ingrese Tasa De Emisión", vbExclamation, TITSISTEMA
      txt_tasa_emi.SetFocus
   ElseIf txt_rut_emi.Text = " " Then
      MsgBox "Ingrese Rut Emisor", vbExclamation, TITSISTEMA
      txt_rut_emi.SetFocus
   ElseIf CDbl(txt_monto_emi.Text) = 0 Then
      MsgBox "Ingrese Monto de Emisión", vbExclamation, TITSISTEMA
      txt_monto_emi.SetFocus
   ElseIf box_perio_cap.ListIndex = -1 Then
      MsgBox "Ingrese Periódo Capital", vbExclamation, TITSISTEMA
      box_perio_cap.SetFocus
   ElseIf CmbTCart.ListIndex = -1 Then
      MsgBox "Ingrese Tipo de Cartera por defecto", vbExclamation, TITSISTEMA
      CmbTCart.SetFocus
   ElseIf DateDiff("D", txt_fec_emi.Text, txt_fec_vcto.Text) < 0 Then
      MsgBox "Fecha de emisión no Puede ser mayor que la de Vencimiento", vbExclamation, TITSISTEMA
   ElseIf DateDiff("d", txt_fec_pago.Text, txt_fec_vcto.Text) < 0 Then
      MsgBox "Fecha de Pago No Puede Ser Mayor que La de Vencimiento", vbExclamation, TITSISTEMA
      txt_fec_pago.SetFocus
   ElseIf DateDiff("d", txt_fec_emi.Text, txt_fec_pago.Text) < 0 Then
      MsgBox "Fecha de Pago No Puede Ser Menor que La de Emisión", vbExclamation, TITSISTEMA
      txt_fec_pago.SetFocus
   ElseIf DateDiff("D", txt_fec_emi.Text, txt_fec_vcto.Text) < 0 Then
      MsgBox "Fecha de Emisión No Puede Ser Mayor que La de Vencimiento", vbExclamation, TITSISTEMA
      txt_fec_emi.SetFocus
   ElseIf box_monemi.ListIndex = -1 Then
      MsgBox "Seleccione Moneda De Emisión", vbExclamation, TITSISTEMA
      box_monemi.SetFocus
   ElseIf box_monpag.ListIndex = -1 Then
      MsgBox "Seleccione Moneda De Pago", vbExclamation, TITSISTEMA
      box_monpag.SetFocus

    ElseIf CmbAgencia.ListIndex = -1 Then
        Call MsgBox("Debe seleccionar una agencia clasificadora de riesgo de instrumentos.", vbExclamation, App.Title)
        CmbAgencia.SetFocus
    ElseIf CmbClasificacion.ListIndex = -1 Then
        Call MsgBox("Debe seleccionar una clasificación de riesgo para el instrumento.", vbExclamation, App.Title)
        CmbClasificacion.SetFocus
    Else
        Toolbar1.Buttons(1).Enabled = True
        Call grabar_datos
    End If
End Function


Private Sub box_base_Click()
    box_dia.ListIndex = Box_Base.ListIndex
    box_año.ListIndex = Box_Base.ListIndex

End Sub

Private Sub Box_Base_DblClick()
    'box_dia.ListIndex = Box_Base.ListIndex
    'box_año.ListIndex = Box_Base.ListIndex
End Sub


Private Sub box_base_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub box_basilea_Click()
'    SendKeys "{TAB 1}"
End Sub

Private Sub box_basilea_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
Case 13
    
    SendKeys "{TAB 1}"

End Select
End Sub


Private Sub box_monemi_Click()
    box_monemi.Enabled = True
    If box_monemi.ListIndex > -1 Then
        If box_monemi.ItemData(box_monemi.ListIndex) = 998 Then
            txt_dias.Text = ""
            Label11.Enabled = True
            txt_dias.Enabled = True
        Else
            txt_dias.Text = ""
            Label11.Enabled = False
            txt_dias.Enabled = False
        End If
    End If
'   SendKeys "{TAB}"
End Sub


Private Sub box_monemi_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub


Private Sub box_monpag_Click()
'SendKeys "{TAB}"
End Sub


Private Sub box_monpag_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub


Private Sub box_perio_cap_Click()
'    SendKeys "{TAB}"
End Sub


Private Sub box_perio_cap_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub


Private Sub box_periodo_Click()
        If box_periodo.ListIndex <> -1 Then
            If box_periodo.ItemData(box_periodo.ListIndex) = 99 Then
                txt_nro_cupo.Enabled = False
                txt_nro_cupo.Text = "1"
                Call Fecha_de_pago
            Else
                Call diferencia_fechas
'                Calculo = True
'                Call Fecha_de_pago
                
            End If
        End If
End Sub

Private Sub box_periodo_LostFocus()
    Calculo = False
    Call Fecha_de_pago
End Sub

Private Sub box_tip_tasa_LostFocus()
Dim numo
    If box_tip_tasa.ListIndex <> -1 Then
        numo = Mid(box_tip_tasa.ItemData(box_tip_tasa.ListIndex), 1, 1)
        If Val(numo) = 1 Then
            ltasfija = "T"
            txt_Spread.Text = 0
            txt_Spread.Enabled = False
        Else
            ltasfija = "F"
            Me.txt_tasa_emi.Text = IIf(IsNumeric(Trim(Right(box_tip_tasa, 6))), Trim(Right(box_tip_tasa, 6)), 0)
            txt_Spread.Enabled = True
        End If
    End If
End Sub

Function llena_datos_inst()

    Dim SQL As String, num
    Dim Datos()
    Dim i As Double
    instru = txt_instrum.Text
    envia = Array()
    AddParam envia, instru
    If Bac_Sql_Execute("SVC_GEN_AYD_SER2", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            txt_fec_vcto.Text = Format(Datos(10), "dd/mm/yyyy")
            txt_fec_emi = Format(Datos(9), "dd/mm/yyyy")
            txt_descripcion = Datos(3)

            For i = 0 To box_tip_tasa.ListCount - 1
                box_tip_tasa.ListIndex = i
                If box_tip_tasa.ItemData(box_tip_tasa.ListIndex) = Val(Datos(5)) Then
                    Exit For
                End If
                box_tip_tasa.ListIndex = -1
            Next
            For i = 0 To box_basilea.ListCount - 1
                box_basilea.ListIndex = i
                If box_basilea.ItemData(box_basilea.ListIndex) = Val(Datos(6)) Then
                    Exit For
                End If
                box_basilea.ListIndex = -1
            Next
            For i = 0 To box_periodo.ListCount - 1
                box_periodo.ListIndex = i
                If box_periodo.ItemData(box_periodo.ListIndex) = Val(Datos(7)) Then
                    Exit For
                End If
                box_periodo.ListIndex = -1
            Next
            txt_fec_pago.Text = Format(Datos(15), "dd/mm/yyyy")
            txt_tasa_emi.Text = CDbl(Datos(12))
            txt_fec_emi.Text = Format(Datos(9), "dd/mm/yyyy")
            txt_base_tasa.Text = Val(Datos(13))
            txt_nro_cupo.Text = Val(Datos(8))
            txt_base_flujo.Text = Val(Datos(17))
            ltasfija = Datos(18)
            If Datos(11) = "S" Then
                Option1.Value = True
            ElseIf Datos(11) = "N" Then
                Option2.Value = True
            Else
                Option1.Value = False
                Option2.Value = False
            End If
            If Datos(16) = "T" Then
                Option3.Value = True
            ElseIf Datos(16) = "F" Then
                Option4.Value = True
            Else
                Option3.Value = False
                Option4.Value = False
            End If
            box_tip_tasa.Enabled = True
            box_basilea.Enabled = True
            'txt_fec_pago.Enabled = True
            Option1.Enabled = True
            Option2.Enabled = True
            txt_tasa_emi.Enabled = True
            box_periodo.Enabled = True
            txt_fec_emi.Enabled = True
            txt_base_flujo.Enabled = True
            Option3.Enabled = True
            Option4.Enabled = True
            txt_fec_vcto.Enabled = True
            txt_base_tasa.Enabled = True
            txt_rut_emi.Enabled = True
            frm_datos_int.Enabled = True
            box_tip_tasa.SetFocus

            
        Loop
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = True
        frm_instr.Enabled = False
        Toolbar1.Buttons(3).Enabled = False
    End If
    
End Function

Private Sub Option3_Click()
    SendKeys "{TAB}"
End Sub

Private Sub Option3_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If

End Sub

Private Sub Option4_Click()
    SendKeys "{TAB}"
    
End Sub



Private Sub cbx_serie_Click()
  If KeyAscii <> 13 Then
   If cbx_serie.ListIndex = 0 Then
    txt_cusip.ListIndex = -1
    txt_isin.ListIndex = -1
    txt_bbnumber.ListIndex = -1
    cbx_serie.ListIndex = -1
    txt_mercado.ListIndex = -1
    cbx_serie.ListIndex = -1
   End If
  End If
End Sub

Private Sub cbx_serie_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
     txt_mercado.SetFocus
   End If
End Sub


Private Sub CmbAgencia_Click()
    Call Llena_Combo_Clasificadoras(Clasificadoras)
End Sub


Private Sub txt_bbnumber_Click()
    If KeyAscii <> 13 Then
   If txt_bbnumber.ListIndex = 0 Then
    txt_cusip.ListIndex = -1
    txt_isin.ListIndex = -1
    txt_bbnumber.ListIndex = -1
    cbx_serie.ListIndex = -1
    txt_mercado.ListIndex = -1
    cbx_serie.ListIndex = -1
   End If
  End If
  
End Sub

Private Sub txt_bbnumber_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
     cbx_serie.SetFocus
   End If
End Sub


Private Sub txt_cod_cli_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If

End Sub

Private Sub txt_cod_cli_LostFocus()
    lbl_nom_cli.Caption = busca_emisor(txt_rut_emi.Text, txt_cod_cli.Text)
End Sub

Private Sub txt_cusip_Click()
  If KeyAscii <> 13 Then
   If txt_cusip.ListIndex = 0 Then
    txt_cusip.ListIndex = -1
    txt_isin.ListIndex = -1
    txt_bbnumber.ListIndex = -1
    cbx_serie.ListIndex = -1
    txt_mercado.ListIndex = -1
    cbx_serie.ListIndex = -1
   End If
  End If
End Sub

Private Sub txt_cusip_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
     txt_bbnumber.SetFocus
   End If
End Sub


Private Sub txt_descripcion_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
    Case 39
        KeyAscii = 0
        
    Case 13
    Call enable_true
    txt_descripcion.Text = UCase(txt_descripcion.Text)
    Toolbar1.Buttons(1).Enabled = True
    SendKeys "{TAB}"
    frm_instr.Enabled = False
    
    box_basilea.ListIndex = 0
    box_perio_cap.ListIndex = 0
    box_periodo.ListIndex = 0

    box_dia.ListIndex = 0
    box_año.ListIndex = 0
    Box_Base.ListIndex = 0
    For i = 0 To box_monemi.ListCount - 1
                box_monemi.ListIndex = i
                If box_monemi.ItemData(box_monemi.ListIndex) = 13 Then
                    Exit For
                End If
                box_monemi.ListIndex = -1
    Next
    For i = 0 To box_monpag.ListCount - 1
                box_monpag.ListIndex = i
                If box_monpag.ItemData(box_monpag.ListIndex) = 13 Then
                    Exit For
                End If
                box_monpag.ListIndex = -1
    Next
    Call Llena_Combo_tasas
    box_tip_tasa.ListIndex = 0

    'COLTES
    If Chk_Coltes Then
        If Box_Base.ListCount > 0 Then
            Box_Base.ListIndex = 2
            Box_Base.Enabled = False
            Chk_Coltes.Enabled = False
            
             For i = 0 To box_monemi.ListCount - 1
                box_monemi.ListIndex = i
                If box_monemi.ItemData(box_monemi.ListIndex) = 129 Then
                    Exit For
                End If
                box_monemi.ListIndex = -1
            Next
            For i = 0 To box_monpag.ListCount - 1
                        box_monpag.ListIndex = i
                        If box_monpag.ItemData(box_monpag.ListIndex) = 129 Then
                            Exit For
                        End If
                        box_monpag.ListIndex = -1
            Next
            
            box_monemi.Enabled = False
            box_monpag.Enabled = False
        End If
    Else
        Box_Base.Enabled = True
        Chk_Coltes.Enabled = False
    End If
    
    
    Option2 = True
    Option3 = True
    Exit Sub
End Select


KeyAscii = Asc(UCase(Chr(KeyAscii)))

End Sub

Private Sub txt_dias_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_fec_emi_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
    Case 13
        If IsDate(txt_fec_emi.Text) Then
            SendKeys "{TAB}"
            Calculo = True
            Call Fecha_de_pago
        Else
            txt_fec_emi.Text = "01/01/1900"
        End If
    End Select
End Sub


Private Sub txt_fec_emi_LostFocus()
    Calculo = True
    Call diferencia_fechas
    Call Fecha_de_pago
End Sub

Private Sub txt_fec_vcto_KeyPress(KeyAscii As Integer)
Dim paso

Select Case KeyAscii
    Case 13

        Dim Op
        Dim Fecha
        If txt_instrum.Text <> "" Then
            Fecha = Format(gsBac_Fecp, "DD/MM/YYYY")
            Op = CDbl(DateDiff("D", Fecha, txt_fec_vcto.Text))
            If Op <= 0 Then
                    MsgBox "La Fecha De Vencimiento No Debe Ser  Igual o Menor Que La De Proceso", vbExclamation, gsBac_Version
                    txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
                    Exit Sub
            End If
            SendKeys "{TAB}"
            paso = txt_fec_vcto.Text
            busca_datos
        End If

End Select
End Sub

Function llena_all_periodo()
    Dim SQL As String
    Dim Datos()
    Dim num
        
    If Bac_Sql_Execute("SVC_INS_LEE_DAT") Then
    
        
        Do While Bac_SQL_Fetch(Datos)
            box_periodo.ListIndex = 0
            num = 0
            num = Val(Datos(7))
            box_periodo.ItemData(box_periodo.ListIndex) = num
        Loop
        
    End If
    
End Function
Function llena_all_combos_tip_tas()


    Dim SQL As String
    Dim Datos()
    Dim num
        
    If Bac_Sql_Execute("SVC_INS_LEE_DAT") Then
    
        
        Do While Bac_SQL_Fetch(Datos)
            box_tip_tasa.ListIndex = 0
            num = 0
            num = Val(Datos(5))
            box_tip_tasa.ItemData(box_tip_tasa.ListIndex) = num
            
        Loop
    End If
End Function

Private Sub box_periodo_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
        Case 13
           SendKeys "{TAB}"
            If box_periodo.ListIndex <> -1 Then
            If box_periodo.ItemData(box_periodo.ListIndex) = 99 Then
                txt_nro_cupo.Enabled = False
                txt_nro_cupo.Text = "1"
                txt_fec_pago.Text = txt_fec_vcto.Text
                Call Fecha_de_pago
            Else
                Call diferencia_fechas
                Calculo = True
                Call Fecha_de_pago
            End If
        End If
    End Select
End Sub

Private Sub box_tip_tasa_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
Case 13
    Dim numo
    numo = Mid(box_tip_tasa.ItemData(box_tip_tasa.ListIndex), 1, 1)
    If Val(numo) = 1 Then
        ltasfija = "T"
        txt_Spread.Text = 0
        txt_Spread.Enabled = False
    Else
        ltasfija = "F"
        txt_Spread.Enabled = True
    End If
    SendKeys "{TAB}"
    End Select
End Sub

Private Sub Form_Load()
    Move 0, 0
    Calculo = False
    Icon = BAC_INVERSIONES.Icon
    Call Llena_Combo_periodos
    Call Llena_Combo_basilea
    Call Llena_Combo_monedas_pag
    Call Llena_Combo_modedas_emi
    Call Llena_Combo_tasas
    
    Call Llena_Combo_Clasificadoras(Agencias)
    
    LLENA_COMBO_TASA_BASE
    enable_false
    '+++jcamposd bono colombiano, tener fecha 1900 induce a error en grabación
    txt_fec_emi.Text = Format(gsBac_Feca, "DD/MM/YYYY")  '"01/01/1900"
    txt_fec_pago.Text = Format(gsBac_Fecx, "DD/MM/YYYY") '"01/01/1900"
    '---jcamposd bono colombiano, tener fecha 1900 induce a error en grabación
    
    Limpio = True
    Me.txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
         
         
    Set objDCartera = New clsDCarteras
    Call objTipCar.LeerCodigos(204)
    Call objTipCar.Coleccion2Control(CmbTCart)
    CmbTCart.Enabled = True
    CmbTCart.ListIndex = IIf(CmbTCart.ListCount > 0, 0, -1)
 
    Call CargarCurvas
End Sub

Function Llena_Combo_basilea()

    Dim SQL As String
    Dim Datos()
    
    Bac_instrumentos.box_basilea.Clear
    
    
    If Bac_Sql_Execute("SVC_GEN_IND_BAS") Then
    
        Do While Bac_SQL_Fetch(Datos)
            Bac_instrumentos.box_basilea.AddItem Datos(2)
            Bac_instrumentos.box_basilea.ItemData(Bac_instrumentos.box_basilea.NewIndex) = Val(Datos(1))
        Loop
    
    End If
End Function

Function Llena_Combo_periodos()

    Dim SQL As String
    Dim Datos()
    
    box_periodo.Clear
    box_perio_cap.Clear
    
    If Bac_Sql_Execute("SVC_INS_LEE_PER") Then
    
        Do While Bac_SQL_Fetch(Datos)
        
            box_periodo.AddItem Datos(2)
            box_periodo.ItemData(box_periodo.NewIndex) = Val(Datos(1))
        
            box_perio_cap.AddItem Datos(2)
            box_perio_cap.ItemData(box_periodo.NewIndex) = Val(Datos(1))
        Loop
    
    End If


End Function


    

Function Llena_Combo_tasas()

    Dim SQL As String
    Dim Datos()
    
    Bac_instrumentos.box_tip_tasa.Clear
    envia = Array()
    
    box_tip_tasa.AddItem "FIJA" & Space(60) & "1" & Space(15)
    box_tip_tasa.ItemData(box_tip_tasa.NewIndex) = 1
        
    If box_monemi.ListIndex > 0 Then
        AddParam envia, box_monemi.ItemData(box_monemi.ListIndex)                                        '1
    Else
        AddParam envia, 0
    End If
    AddParam envia, 0                            '2
    AddParam envia, 0 '3
    AddParam envia, gsBac_Fecp  '4
    
    If Bac_Sql_Execute("SVC_INS_LEE_TAS", envia()) Then
    
        Do While Bac_SQL_Fetch(Datos)
                                                                            'tasa           -               periodo             -           cod periodo     -               valor tasa
            Bac_instrumentos.box_tip_tasa.AddItem Datos(4) & Space(5) & Datos(6) & Space(50) & Datos(5) & Space(10) & Datos(8)
            Bac_instrumentos.box_tip_tasa.ItemData(Bac_instrumentos.box_tip_tasa.NewIndex) = Val(Datos(3))   ' cod tasa
        
        Loop
    
    End If
End Function


Private Sub Option1_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 And Option1.Value = True Then

    SendKeys "{TAB}"

End If

End Sub

Private Sub Option2_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 And Option2.Value = True Then
    
    SendKeys "{TAB}"

End If

End Sub



Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call valida_datos
      Case 2
         If MsgBox("¿ Está seguro de eliminar este registro. ?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
            Call eliminar_de_la_tabla_instrumentos
         End If
      Case 3
         Call busca_datos
      Case 4
         txt_instrum.Text = ""
         txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY") '"01/01/1900" COLTES
         Call Clear_Objetos(" ")
         Call enable_false
         txt_instrum.SetFocus
      Case 5
         If Toolbar1.Buttons(1).Value = tbrUnpressed Then
            Unload Me
         End If
   End Select
End Sub



Private Sub txt_base_tasa_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
    Case 13
            SendKeys "{TAB}"
    End Select
End Sub


Private Sub txt_fec_vcto_LostFocus()
'        Dim Op
'        Dim Fecha
'        If txt_instrum.Text <> "" Then
'            Fecha = Format(gsBac_Fecp, "DD/MM/YYYY")
'            Op = CDbl(DateDiff("D", Fecha, txt_fec_vcto.Text))
'            If Op <= 0 Then
'                    MsgBox "La Fecha De Vencimiento No Debe Ser  Igual o Menor Que La De Proceso", vbExclamation, gsBac_Version
'                    txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
'                    Exit Sub
'            End If
'            SendKeys "{TAB}"
'            paso = txt_fec_vcto.Text
'            busca_datos
'        End If
End Sub

Private Sub txt_fec_pago_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
Case 13
      If IsDate(txt_fec_pago.Text) Then
          SendKeys "{TAB}"
      Else
          txt_fec_pago.Text = "01/01/1900"
          txt_fec_pago.SetFocus
      End If
End Select
End Sub



Private Sub txt_instrum_DblClick()
    Call buscar_datos_ayuda
End Sub

Private Sub txt_instrum_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
    Case 13
        SendKeys "{TAB}"
        Exit Sub
    Case 39
        KeyAscii = 0
End Select
KeyAscii = Asc(UCase(Chr(KeyAscii)))

End Sub


Private Sub txt_isin_Click()
   Dim iContador As Integer
  
        If txt_isin.ListIndex = 0 Then
            txt_isin.ListIndex = -1
            txt_cusip.ListIndex = -1
            txt_bbnumber.ListIndex = -1
            cbx_serie.ListIndex = -1
            txt_mercado.ListIndex = -1
            cbx_serie.ListIndex = -1
        End If
    
        For iContador = 0 To txt_cusip.ListCount - 1
            If txt_isin.ListIndex = -1 Then Exit Sub
            If txt_cusip.ItemData(iContador) = txt_isin.ItemData(txt_isin.ListIndex) Then
               txt_cusip.ListIndex = iContador
               Exit For
            Else
               txt_cusip.Text = ""
            End If
        Next iContador
        For iContador = 0 To txt_bbnumber.ListCount - 1
            
            If txt_bbnumber.ItemData(iContador) = txt_isin.ItemData(txt_isin.ListIndex) Then
               txt_bbnumber.ListIndex = iContador
               Exit For
            Else
              txt_bbnumber.Text = ""
            End If
        Next iContador
        For iContador = 0 To txt_mercado.ListCount - 1
            If txt_mercado.ItemData(iContador) = txt_isin.ItemData(txt_isin.ListIndex) Then
               txt_mercado.ListIndex = iContador
               Exit For
            Else
               txt_mercado.Text = ""
            End If
        Next iContador
        
        For iContador = 0 To cbx_serie.ListCount - 1
            If cbx_serie.ItemData(iContador) = txt_isin.ItemData(txt_isin.ListIndex) Then
               cbx_serie.ListIndex = iContador
               Exit For
            Else
               cbx_serie.Text = ""
            End If
        Next iContador
        
        For iContador = 0 To cbx_serie.ListCount - 1
            If cbx_serie.ItemData(iContador) = txt_isin.ItemData(txt_isin.ListIndex) Then
               cbx_serie.ListIndex = iContador
               Exit For
            Else
               cbx_serie.ListIndex = -1
            End If
        Next iContador
        
End Sub



Private Sub txt_isin_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     txt_cusip.SetFocus
   End If
End Sub

Private Sub txt_mercado_Click()
  If KeyAscii <> 13 Then
   If txt_mercado.ListIndex = 0 Then
    txt_cusip.ListIndex = -1
    txt_isin.ListIndex = -1
    txt_bbnumber.ListIndex = -1
    cbx_serie.ListIndex = -1
    txt_mercado.ListIndex = -1
    cbx_serie.ListIndex = -1
   End If
  End If
End Sub

Private Sub txt_monto_emi_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Me.frm_instr.Enabled = True
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_nro_cupo_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    If txt_nro_cupo.Text = "" Then
        MsgBox ("Debe ingresar el Dato Requerido ..."), vbExclamation, gsBac_Version
        txt_nro_cupo.SetFocus
    ElseIf Val(txt_nro_cupo.Text) > 0 Then
        SendKeys "{TAB}"
    Else
        MsgBox ("Debe ingresar Solo Números ..."), vbExclamation, gsBac_Version
        txt_nro_cupo.Text = Empty
        txt_nro_cupo.SetFocus
    End If
    
End If

End Sub

Private Sub txt_rut_emi_Change()
    txt_cod_cli.Text = " "
    lbl_nom_cli.Caption = " "
End Sub

Private Sub txt_rut_emi_DblClick()
    giAceptar% = False
    BacAyuda.Tag = "EMISOR"
    BacAyuda.Show vbModal
    If giAceptar% = True Then
        txt_rut_emi.Text = CDbl(Trim(Mid(gsrut$, 44, 9)))
        lbl_nom_cli.Caption = Trim(Mid(gsrut$, 1, 40))
        txt_cod_cli.Text = CDbl(Trim(Mid(gsrut$, 58, 1)))

'        txt_rut_emi.Text = Val(gsrut$)
'        lbl_nom_cli.Caption = gsDescripcion$
'        txt_cod_cli.Text = CDbl(gsvalor$)
    Else
        SendKeys "{TAB}"
    End If

End Sub

Private Sub txt_rut_emi_KeyPress(KeyAscii As Integer)
    BacCaracterNumerico KeyAscii
    
    If KeyAscii = 13 Then SendKeys "{TAB}"

End Sub


Private Sub txt_Spread_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
    If IsNumeric(txt_Spread.Text) Then
        SendKeys "{TAB}"
    End If
End If

End Sub

Private Sub txt_tasa_emi_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      If txt_Spread.Enabled = True Then
         txt_Spread.SetFocus
      Else
         box_perio_cap.SetFocus
      End If
      If IsNumeric(txt_tasa_emi.Text) Then
      End If
   End If
End Sub

Private Sub CargarCurvas()
   Dim Datos()
   Dim SQL  As String
   
   SQL = "SELECT DISTINCT IdCurva FROM BacTraderSuda..CURVA_CAPTACIONES_IBS"
   If Bac_Sql_Execute(SQL) Then
      Do While Bac_SQL_Fetch(Datos())
         cmbCurvas.AddItem UCase(Datos(1))
      Loop
   End If
End Sub


Private Function Llena_Combo_Clasificadoras(ByVal nValor As QueCarga)
    On Error GoTo ErrorCarga
    Dim Datos()
    Dim TieneDatos  As Boolean
    
    Let TieneDatos = False
    
    If nValor = Agencias Then
        Let CmbAgencia.Enabled = False:             Call CmbAgencia.Clear
        Let CmbClasificacion.Enabled = False:       Call CmbClasificacion.Clear
    End If
    If nValor = Clasificadoras Then
        Let CmbClasificacion.Enabled = False:       Call CmbClasificacion.Clear
        If CmbAgencia.ListIndex = -1 Then
            Exit Function
        End If
    End If

    envia = Array()
    AddParam envia, CDbl(nValor)
    If nValor = Agencias Then
        AddParam envia, CDbl(0)
    Else
        AddParam envia, CDbl(CmbAgencia.ItemData(CmbAgencia.ListIndex))
    End If
    
    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Leer_Parametros_D05", envia) Then
        Exit Function
    End If
    Do While Bac_SQL_Fetch(Datos())
        If nValor = Agencias Then
            Call CmbAgencia.AddItem(Datos(2)):          Let CmbAgencia.ItemData(CmbAgencia.NewIndex) = Datos(1)
        End If
        If nValor = Clasificadoras Then
            Call CmbClasificacion.AddItem(Datos(2)):    Let CmbClasificacion.ItemData(CmbClasificacion.NewIndex) = Datos(1)
        End If
        Let TieneDatos = True
    Loop

    If nValor = Agencias Then
        Let CmbAgencia.Enabled = True
        If TieneDatos = True Then
            Let CmbAgencia.ListIndex = -1
        End If
    Else
        Let CmbClasificacion.Enabled = True
        If TieneDatos = True Then
            Let CmbClasificacion.ListIndex = 0
        End If
    End If
    
    On Error GoTo 0
Exit Function
ErrorCarga:

    If nValor = Agencias Then
        Call MsgBox("No se han cargado las Agencias de clasificación.", vbExclamation, App.Title)
    Else
        Call MsgBox("No se han cargado las clasificaciones de riesgo.", vbExclamation, App.Title)
    End If

    On Error GoTo 0
End Function
