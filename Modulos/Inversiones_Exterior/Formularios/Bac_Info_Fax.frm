VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form Bac_Fax 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Datos Fax Confirmación"
   ClientHeight    =   3525
   ClientLeft      =   5775
   ClientTop       =   4305
   ClientWidth     =   3735
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3525
   ScaleWidth      =   3735
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame2 
      Caption         =   "Operador Contraparte"
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
      Height          =   1350
      Left            =   45
      TabIndex        =   14
      Top             =   2040
      Width           =   3675
      Begin BACControles.TXTNumero txt_fax_con 
         Height          =   240
         Left            =   2355
         TabIndex        =   12
         Top             =   945
         Width           =   1170
         _ExtentX        =   2064
         _ExtentY        =   423
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
         Max             =   "99999999"
      End
      Begin BACControles.TXTNumero txt_tele_con 
         Height          =   240
         Left            =   2360
         TabIndex        =   9
         Top             =   555
         Width           =   1170
         _ExtentX        =   2064
         _ExtentY        =   423
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
         Max             =   "99999999"
      End
      Begin BACControles.TXTNumero txt_ciu_fax_con 
         Height          =   240
         Left            =   1605
         TabIndex        =   11
         Top             =   945
         Width           =   465
         _ExtentX        =   820
         _ExtentY        =   423
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
         Max             =   "999"
      End
      Begin BACControles.TXTNumero txt_ciu_tele_con 
         Height          =   240
         Left            =   1605
         TabIndex        =   8
         Top             =   555
         Width           =   465
         _ExtentX        =   820
         _ExtentY        =   423
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
         Max             =   "999"
      End
      Begin BACControles.TXTNumero txt_pais_fax_con 
         Height          =   240
         Left            =   870
         TabIndex        =   10
         Top             =   945
         Width           =   465
         _ExtentX        =   820
         _ExtentY        =   423
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
         Max             =   "999"
      End
      Begin BACControles.TXTNumero txt_pais_tele_con 
         Height          =   240
         Left            =   870
         TabIndex        =   7
         Top             =   555
         Width           =   465
         _ExtentX        =   820
         _ExtentY        =   423
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
         Max             =   "999"
      End
      Begin VB.Label Label21 
         Alignment       =   2  'Center
         Caption         =   "Teléfono"
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
         Height          =   240
         Left            =   2520
         TabIndex        =   32
         Top             =   300
         Width           =   975
      End
      Begin VB.Label Label20 
         Alignment       =   2  'Center
         Caption         =   "Ciudad"
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
         Height          =   240
         Left            =   1680
         TabIndex        =   31
         Top             =   285
         Width           =   675
      End
      Begin VB.Label Label19 
         Alignment       =   2  'Center
         Caption         =   "País"
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
         Height          =   240
         Left            =   915
         TabIndex        =   30
         Top             =   270
         Width           =   615
      End
      Begin VB.Label Label18 
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
         ForeColor       =   &H8000000D&
         Height          =   225
         Left            =   2130
         TabIndex        =   29
         Top             =   945
         Width           =   165
      End
      Begin VB.Label Label17 
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
         ForeColor       =   &H8000000D&
         Height          =   225
         Left            =   2130
         TabIndex        =   28
         Top             =   555
         Width           =   165
      End
      Begin VB.Label Label16 
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
         ForeColor       =   &H8000000D&
         Height          =   225
         Left            =   1410
         TabIndex        =   27
         Top             =   945
         Width           =   165
      End
      Begin VB.Label Label15 
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
         ForeColor       =   &H8000000D&
         Height          =   225
         Left            =   1410
         TabIndex        =   26
         Top             =   555
         Width           =   165
      End
      Begin VB.Label Label14 
         Caption         =   "Teléfono"
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
         Height          =   345
         Left            =   75
         TabIndex        =   25
         Top             =   555
         Width           =   810
      End
      Begin VB.Label Label13 
         Caption         =   "Fax"
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
         Left            =   75
         TabIndex        =   24
         Top             =   945
         Width           =   570
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   13
      Top             =   0
      Width           =   3735
      _ExtentX        =   6588
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   13
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Caption         =   "Operador Bech"
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
      Height          =   1350
      Left            =   60
      TabIndex        =   0
      Top             =   675
      Width           =   3675
      Begin BACControles.TXTNumero txt_fax_bech 
         Height          =   240
         Left            =   2370
         TabIndex        =   6
         Top             =   900
         Width           =   1170
         _ExtentX        =   2064
         _ExtentY        =   423
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
         Max             =   "99999999"
      End
      Begin BACControles.TXTNumero txt_ciu_fax_bech 
         Height          =   240
         Left            =   1605
         TabIndex        =   5
         Top             =   900
         Width           =   465
         _ExtentX        =   820
         _ExtentY        =   423
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
         Max             =   "999"
      End
      Begin BACControles.TXTNumero txt_pais_fax_bech 
         Height          =   240
         Left            =   870
         TabIndex        =   4
         Top             =   900
         Width           =   465
         _ExtentX        =   820
         _ExtentY        =   423
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
         Max             =   "999"
      End
      Begin BACControles.TXTNumero txt_tele_bech 
         Height          =   240
         Left            =   2370
         TabIndex        =   3
         Top             =   540
         Width           =   1170
         _ExtentX        =   2064
         _ExtentY        =   423
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
         Max             =   "99999999"
      End
      Begin BACControles.TXTNumero txt_Ciu_tele_bech 
         Height          =   240
         Left            =   1605
         TabIndex        =   2
         Top             =   540
         Width           =   465
         _ExtentX        =   820
         _ExtentY        =   423
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
         Max             =   "999"
      End
      Begin BACControles.TXTNumero txt_pais_tele_bech 
         Height          =   240
         Left            =   870
         TabIndex        =   1
         Top             =   540
         Width           =   465
         _ExtentX        =   820
         _ExtentY        =   423
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
         Max             =   "999"
      End
      Begin VB.Label Label9 
         Alignment       =   2  'Center
         Caption         =   "Teléfono"
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
         Height          =   240
         Left            =   2370
         TabIndex        =   23
         Top             =   285
         Width           =   1185
      End
      Begin VB.Label Label8 
         Alignment       =   2  'Center
         Caption         =   "Ciudad"
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
         Height          =   240
         Left            =   1650
         TabIndex        =   22
         Top             =   270
         Width           =   675
      End
      Begin VB.Label Label7 
         Alignment       =   2  'Center
         Caption         =   "País"
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
         Height          =   240
         Left            =   885
         TabIndex        =   21
         Top             =   255
         Width           =   615
      End
      Begin VB.Label Label6 
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
         ForeColor       =   &H8000000D&
         Height          =   225
         Left            =   2130
         TabIndex        =   20
         Top             =   900
         Width           =   255
      End
      Begin VB.Label Label5 
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
         ForeColor       =   &H8000000D&
         Height          =   225
         Left            =   2130
         TabIndex        =   19
         Top             =   540
         Width           =   165
      End
      Begin VB.Label Label4 
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
         ForeColor       =   &H8000000D&
         Height          =   225
         Left            =   1410
         TabIndex        =   18
         Top             =   900
         Width           =   165
      End
      Begin VB.Label Label3 
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
         ForeColor       =   &H8000000D&
         Height          =   225
         Left            =   1410
         TabIndex        =   17
         Top             =   540
         Width           =   165
      End
      Begin VB.Label Label2 
         Caption         =   "Fax"
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
         Height          =   210
         Left            =   60
         TabIndex        =   16
         Top             =   900
         Width           =   885
      End
      Begin VB.Label Label1 
         Caption         =   "Teléfono"
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
         Height          =   345
         Left            =   45
         TabIndex        =   15
         Top             =   540
         Width           =   825
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   10560
      Top             =   7695
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
            Picture         =   "Bac_Info_Fax.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":031A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":0ED8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":11F2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":1644
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":179E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":1BF0
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":2042
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":235C
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":2676
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":27D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":2C22
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":3074
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":338E
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":36A8
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Info_Fax.frx":39C2
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Bac_Fax"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Function Clear_Objetos()
    txt_pais_fax_bech.Text = " "
    txt_ciu_fax_bech.Text = " "
    txt_fax_bech.Text = " "

    txt_pais_fax_con.Text = " "
    txt_ciu_fax_con.Text = " "
    txt_fax_con.Text = " "

    txt_pais_tele_bech.Text = " "
    txt_Ciu_tele_bech.Text = " "
    txt_tele_bech.Text = " "

    txt_pais_tele_con.Text = " "
    txt_ciu_tele_con.Text = " "
    txt_tele_con.Text = " "

    

    txt_pais_fax_bech.Text = 56
    txt_pais_tele_bech.Text = 56

    txt_ciu_fax_bech.Text = 2
    txt_Ciu_tele_bech.Text = 2

End Function



Function valida_datos()
    valida_datos = True
    If CDbl(txt_pais_tele_bech.Text) = 0 Then
        MsgBox "Ingrese Código País Teléfono Bech", vbExclamation, gsBac_Version
        txt_pais_tele_bech.SetFocus
        valida_datos = False
        Exit Function
        
    ElseIf CDbl(txt_Ciu_tele_bech.Text) = 0 Then
        MsgBox "Ingrese Código Ciudad Teléfono Bech", vbExclamation, gsBac_Version
        txt_Ciu_tele_bech.SetFocus
        valida_datos = False
        Exit Function

    ElseIf CDbl(txt_tele_bech.Text) = 0 Then
        MsgBox "Ingrese Teléfono Bech", vbExclamation, gsBac_Version
        txt_tele_bech.SetFocus
        valida_datos = False
        Exit Function


    ElseIf CDbl(txt_pais_fax_bech.Text) = 0 Then
        MsgBox "Ingrese Código País Fax ", vbExclamation, gsBac_Version
        txt_pais_fax_bech.SetFocus
        valida_datos = False
        Exit Function


    ElseIf CDbl(txt_ciu_fax_bech.Text) = 0 Then
        MsgBox "Ingrese Código Ciudad Fax ", vbExclamation, gsBac_Version
        txt_ciu_fax_bech.SetFocus
        valida_datos = False
        Exit Function


    ElseIf CDbl(txt_fax_bech.Text) = 0 Then
        MsgBox "Ingrese Fax Bech", vbExclamation, gsBac_Version
        txt_fax_bech.SetFocus
        valida_datos = False
        Exit Function


    ElseIf CDbl(txt_pais_tele_con.Text) = 0 Then
        MsgBox "Ingrese Código País Teléfono Contraparte", vbExclamation, gsBac_Version
        txt_pais_tele_con.SetFocus
        valida_datos = False
        Exit Function


    ElseIf CDbl(txt_ciu_tele_con.Text) = 0 Then
        MsgBox "Ingrese Código Ciudad Teléfono Contraparte", vbExclamation, gsBac_Version
        txt_ciu_tele_con.SetFocus
        valida_datos = False
        Exit Function


    ElseIf CDbl(txt_tele_con.Text) = 0 Then
        MsgBox "Ingrese Teléfono Contraparte", vbExclamation, gsBac_Version
        txt_tele_con.SetFocus
        valida_datos = False
        Exit Function


    ElseIf CDbl(txt_pais_fax_con.Text) = 0 Then
        MsgBox "Ingrese Código País Fax Contraparte", vbExclamation, gsBac_Version
        txt_pais_fax_con.SetFocus
        valida_datos = False
        Exit Function


    ElseIf CDbl(txt_ciu_fax_con.Text) = 0 Then
        MsgBox "Ingrese Código Ciudad Fax Contraparte", vbExclamation, gsBac_Version
        txt_ciu_fax_con.SetFocus
        valida_datos = False
        Exit Function


    ElseIf CDbl(txt_fax_con.Text) = 0 Then
        MsgBox "Ingrese Fax Contraparte", vbExclamation, gsBac_Version
        txt_fax_con.SetFocus
        valida_datos = False
        Exit Function

    End If

End Function

Private Sub Form_Activate()
    txt_tele_bech.SetFocus
End Sub

Private Sub Form_Load()
    Me.Icon = BAC_INVERSIONES.Icon

    txt_pais_fax_bech.Text = 56
    txt_pais_tele_bech.Text = 56

    txt_ciu_fax_bech.Text = 2
    txt_Ciu_tele_bech.Text = 2

    txt_tele_bech.Enabled = True
    Call Clear_Objetos




End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            If valida_datos Then
                telefono_Bech = txt_pais_tele_bech.Text & " - " & txt_Ciu_tele_bech.Text & " - " & Str(txt_tele_bech.Text)

                Fax_Bech = txt_pais_fax_bech.Text & " - " & txt_ciu_fax_bech.Text & " - " & Str(txt_fax_bech.Text)

                telefono_Contra = txt_pais_tele_con.Text & " - " & txt_ciu_tele_con.Text & " - " & Str(txt_tele_con.Text)
    
                Fax_Contra = txt_pais_fax_con.Text & " - " & txt_ciu_fax_con.Text & " - " & Str(txt_fax_con.Text)
            
                giAceptar = True
                Unload Me
            End If

        Case 2
            txt_tele_bech.SetFocus
            Call Clear_Objetos
        Case 3
            giAceptar = False
            Unload Me
    End Select
End Sub


Private Sub txt_ciu_fax_bech_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_ciu_fax_con_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_Ciu_tele_bech_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_ciu_tele_con_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_fax_bech_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_fax_con_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB1}"
    End If
End Sub

Private Sub txt_pais_fax_bech_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_pais_fax_con_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_pais_tele_bech_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_pais_tele_con_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_tele_bech_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_tele_con_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

