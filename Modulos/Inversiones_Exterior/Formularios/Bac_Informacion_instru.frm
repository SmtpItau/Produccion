VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{1A42DF62-3514-11D5-BF5A-00105ACD9C7B}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_Informacion_instru 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informacion Instrumetos"
   ClientHeight    =   4380
   ClientLeft      =   1620
   ClientTop       =   2025
   ClientWidth     =   9285
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4380
   ScaleWidth      =   9285
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   36
      Top             =   0
      Width           =   9285
      _ExtentX        =   16378
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   1
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4095
         Top             =   15
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
               Picture         =   "Bac_Informacion_instru.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":031A
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":076C
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":0BBE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":0ED8
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":11F2
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":1644
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":179E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":1BF0
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":2042
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":235C
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":2676
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":27D0
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":2C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":3074
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":338E
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":36A8
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bac_Informacion_instru.frx":39C2
               Key             =   ""
            EndProperty
         EndProperty
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
      Height          =   930
      Left            =   0
      TabIndex        =   29
      Top             =   600
      Width           =   9255
      Begin VB.TextBox txt_instrum 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1815
         MaxLength       =   20
         TabIndex        =   31
         Top             =   195
         Width           =   2655
      End
      Begin VB.TextBox txt_descripcion 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1815
         MaxLength       =   50
         TabIndex        =   30
         Top             =   540
         Width           =   6855
      End
      Begin MSMask.MaskEdBox txt_fec_ini 
         Bindings        =   "Bac_Informacion_instru.frx":3E14
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "dd/MM/yyyy"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3082
            SubFormatType   =   3
         EndProperty
         Height          =   255
         Left            =   7440
         TabIndex        =   32
         Top             =   165
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   450
         _Version        =   393216
         Enabled         =   0   'False
         MaxLength       =   10
         Mask            =   "##/##/####"
         PromptChar      =   " "
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
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   255
         TabIndex        =   35
         Top             =   180
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
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   5520
         TabIndex        =   34
         Top             =   195
         Width           =   1695
      End
      Begin VB.Label Label15 
         Caption         =   "Descripción"
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
         Left            =   240
         TabIndex        =   33
         Top             =   600
         Width           =   1215
      End
   End
   Begin VB.Frame Frame1 
      Height          =   2850
      Left            =   0
      TabIndex        =   0
      Top             =   1500
      Width           =   9255
      Begin BacControles.txtNumero txtNumero4 
         Height          =   285
         Left            =   7800
         TabIndex        =   28
         Top             =   1110
         Width           =   1230
         _ExtentX        =   2170
         _ExtentY        =   503
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         SelStart        =   5
         Text            =   "0,0000"
      End
      Begin BacControles.txtNumero txtNumero3 
         Height          =   300
         Left            =   7800
         TabIndex        =   27
         Top             =   795
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   529
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         SelStart        =   5
         Text            =   "0,0000"
      End
      Begin BacControles.txtNumero txtNumero2 
         Height          =   285
         Left            =   7800
         TabIndex        =   26
         Top             =   480
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   503
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         SelStart        =   5
         Text            =   "0,0000"
      End
      Begin BacControles.txtNumero txtNumero1 
         Height          =   300
         Left            =   1800
         TabIndex        =   25
         Top             =   1740
         Width           =   1065
         _ExtentX        =   1879
         _ExtentY        =   529
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         SelStart        =   5
         Text            =   "0,0000"
      End
      Begin VB.ComboBox box_emisor 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "Bac_Informacion_instru.frx":3E1F
         Left            =   1785
         List            =   "Bac_Informacion_instru.frx":3E21
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   2415
         Width           =   4935
      End
      Begin VB.ComboBox box_periodo 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "Bac_Informacion_instru.frx":3E23
         Left            =   1800
         List            =   "Bac_Informacion_instru.frx":3E2A
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   2070
         Width           =   2985
      End
      Begin VB.ComboBox box_basilea 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "Bac_Informacion_instru.frx":3E31
         Left            =   1800
         List            =   "Bac_Informacion_instru.frx":3E33
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   825
         Width           =   3015
      End
      Begin VB.ComboBox box_tip_tasa 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "Bac_Informacion_instru.frx":3E35
         Left            =   1800
         List            =   "Bac_Informacion_instru.frx":3E37
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   180
         Width           =   3015
      End
      Begin VB.Frame frm_opciones 
         Height          =   600
         Left            =   1785
         TabIndex        =   4
         Top             =   1110
         Width           =   1440
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
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   120
            TabIndex        =   6
            Top             =   240
            Width           =   735
         End
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
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   870
            TabIndex        =   5
            Top             =   240
            Width           =   510
         End
      End
      Begin VB.Frame Frame3 
         Height          =   810
         Left            =   7800
         TabIndex        =   1
         Top             =   1365
         Width           =   1230
         Begin VB.OptionButton Option3 
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
            ForeColor       =   &H8000000D&
            Height          =   225
            Left            =   225
            TabIndex        =   3
            Top             =   195
            Width           =   615
         End
         Begin VB.OptionButton Option4 
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
            ForeColor       =   &H8000000D&
            Height          =   225
            Left            =   225
            TabIndex        =   2
            Top             =   480
            Width           =   615
         End
      End
      Begin MSMask.MaskEdBox txt_fec_pago 
         Bindings        =   "Bac_Informacion_instru.frx":3E39
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "dd/MM/yyyy"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3082
            SubFormatType   =   3
         EndProperty
         Height          =   255
         Left            =   1800
         TabIndex        =   11
         Top             =   525
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   450
         _Version        =   393216
         Enabled         =   0   'False
         MaxLength       =   10
         Mask            =   "##/##/####"
         PromptChar      =   " "
      End
      Begin MSMask.MaskEdBox txt_fec_emi 
         Bindings        =   "Bac_Informacion_instru.frx":3E44
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "dd/MM/yyyy"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3082
            SubFormatType   =   3
         EndProperty
         Height          =   255
         Left            =   7800
         TabIndex        =   12
         Top             =   195
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   450
         _Version        =   393216
         Enabled         =   0   'False
         MaxLength       =   10
         Mask            =   "##/##/####"
         PromptChar      =   " "
      End
      Begin VB.Label Label14 
         Caption         =   "Días Reales"
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
         Left            =   5880
         TabIndex        =   24
         Top             =   1500
         Width           =   1095
      End
      Begin VB.Label Label13 
         Caption         =   "Base Tasa de Flujo"
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
         Left            =   5880
         TabIndex        =   23
         Top             =   1185
         Width           =   1815
      End
      Begin VB.Label Label12 
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
         Height          =   255
         Left            =   5880
         TabIndex        =   22
         Top             =   885
         Width           =   1335
      End
      Begin VB.Label Label11 
         Caption         =   "Base Tasa de Emisión"
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
         Left            =   5880
         TabIndex        =   21
         Top             =   540
         Width           =   2055
      End
      Begin VB.Label Label10 
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
         Height          =   255
         Left            =   5880
         TabIndex        =   20
         Top             =   225
         Width           =   1695
      End
      Begin VB.Label Label9 
         Caption         =   "Período"
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
         Left            =   240
         TabIndex        =   19
         Top             =   2205
         Width           =   1095
      End
      Begin VB.Label Label8 
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
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   240
         TabIndex        =   18
         Top             =   1770
         Width           =   1695
      End
      Begin VB.Label Label7 
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
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   240
         TabIndex        =   17
         Top             =   2565
         Width           =   855
      End
      Begin VB.Label Label6 
         Caption         =   "Afecto a Encaje"
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
         Left            =   240
         TabIndex        =   16
         Top             =   1230
         Width           =   1455
      End
      Begin VB.Label Label5 
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
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   240
         TabIndex        =   15
         Top             =   870
         Width           =   735
      End
      Begin VB.Label Label4 
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
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   240
         TabIndex        =   14
         Top             =   555
         Width           =   1335
      End
      Begin VB.Label Label3 
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
         Height          =   240
         Left            =   240
         TabIndex        =   13
         Top             =   210
         Width           =   1455
      End
   End
End
Attribute VB_Name = "Bac_Informacion_instru"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
    Case 1
        Unload Me
    End Select
End Sub

