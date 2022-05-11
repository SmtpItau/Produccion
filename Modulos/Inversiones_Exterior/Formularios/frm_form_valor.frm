VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form Bac_form_valor 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Formulas y Valorización"
   ClientHeight    =   5850
   ClientLeft      =   990
   ClientTop       =   1740
   ClientWidth     =   9450
   Icon            =   "frm_form_valor.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5850
   ScaleWidth      =   9450
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   34
      Top             =   0
      Width           =   9450
      _ExtentX        =   16669
      _ExtentY        =   847
      ButtonWidth     =   714
      ButtonHeight    =   688
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3720
         Top             =   120
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   20
         ImageHeight     =   20
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_form_valor.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_form_valor.frx":0624
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame2 
      Height          =   2175
      Left            =   0
      TabIndex        =   25
      Top             =   3960
      Width           =   11175
      Begin MSMask.MaskEdBox MaskEdBox8 
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "#.##0,00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3082
            SubFormatType   =   1
         EndProperty
         Height          =   255
         Left            =   2280
         TabIndex        =   7
         Top             =   1440
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   450
         _Version        =   393216
         MaxLength       =   12
         Mask            =   "############"
         PromptChar      =   " "
      End
      Begin MSMask.MaskEdBox MaskEdBox7 
         Height          =   255
         Left            =   2280
         TabIndex        =   6
         Top             =   1080
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   450
         _Version        =   393216
         ForeColor       =   -2147483635
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox MaskEdBox6 
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "#.##0,00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3082
            SubFormatType   =   1
         EndProperty
         Height          =   255
         Left            =   2280
         TabIndex        =   5
         Top             =   720
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   450
         _Version        =   393216
         MaxLength       =   12
         Mask            =   "############"
         PromptChar      =   " "
      End
      Begin MSMask.MaskEdBox MaskEdBox5 
         Height          =   255
         Left            =   2280
         TabIndex        =   4
         Top             =   360
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   450
         _Version        =   393216
         MaxLength       =   10
         Mask            =   "##/##/####"
         PromptChar      =   " "
      End
      Begin MSMask.MaskEdBox MaskEdBox2 
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "0,000000%"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3082
            SubFormatType   =   5
         EndProperty
         Height          =   255
         Left            =   7800
         TabIndex        =   9
         Top             =   720
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   450
         _Version        =   393216
         MaxLength       =   9
         Mask            =   "#########"
         PromptChar      =   " "
      End
      Begin MSMask.MaskEdBox MaskEdBox1 
         Height          =   255
         Left            =   7800
         TabIndex        =   8
         Top             =   360
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   450
         _Version        =   393216
         PromptChar      =   "_"
      End
      Begin VB.Label Label26 
         BorderStyle     =   1  'Fixed Single
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
         Height          =   255
         Left            =   7800
         TabIndex        =   47
         Top             =   1440
         Width           =   1695
      End
      Begin VB.Label Label25 
         BorderStyle     =   1  'Fixed Single
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
         Height          =   255
         Left            =   7800
         TabIndex        =   46
         Top             =   1080
         Width           =   1695
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
         Left            =   120
         TabIndex        =   33
         Top             =   360
         Width           =   2055
      End
      Begin VB.Label Label16 
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
         Height          =   255
         Left            =   120
         TabIndex        =   32
         Top             =   720
         Width           =   1455
      End
      Begin VB.Label Label17 
         Caption         =   "Tasa de Intereses"
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
         Left            =   120
         TabIndex        =   31
         Top             =   1080
         Width           =   1575
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
         ForeColor       =   &H8000000D&
         Height          =   375
         Left            =   120
         TabIndex        =   30
         Top             =   1440
         Width           =   1575
      End
      Begin VB.Label Label19 
         Caption         =   "Tasa Vigente"
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
         Left            =   6120
         TabIndex        =   29
         Top             =   360
         Width           =   1215
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
         Left            =   6120
         TabIndex        =   28
         Top             =   720
         Width           =   1935
      End
      Begin VB.Label Label21 
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
         Height          =   255
         Left            =   6120
         TabIndex        =   27
         Top             =   1080
         Width           =   1815
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
         Left            =   6120
         TabIndex        =   26
         Top             =   1440
         Width           =   1695
      End
   End
   Begin VB.Frame Frame1 
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
      Height          =   2775
      Left            =   0
      TabIndex        =   11
      Top             =   840
      Width           =   11175
      Begin VB.ComboBox box_familia 
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   240
         Width           =   3615
      End
      Begin VB.ComboBox box_nemo 
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   600
         Width           =   3015
      End
      Begin VB.ComboBox box_moneda 
         Height          =   315
         Left            =   8280
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1320
         Width           =   2655
      End
      Begin VB.Label lbl_pais 
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   2160
         TabIndex        =   45
         Top             =   2400
         Width           =   3015
      End
      Begin VB.Label lbl_basilea 
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   2160
         TabIndex        =   44
         Top             =   2040
         Width           =   3015
      End
      Begin VB.Label lbl_fecha_vcto 
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   2160
         TabIndex        =   43
         Top             =   1680
         Width           =   1575
      End
      Begin VB.Label lbl_encaje 
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   2160
         TabIndex        =   42
         Top             =   1320
         Width           =   3015
      End
      Begin VB.Label lbl_fecha_emi 
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   2160
         TabIndex        =   41
         Top             =   960
         Width           =   1575
      End
      Begin VB.Label lbl_tasa 
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   8280
         TabIndex        =   40
         Top             =   2040
         Width           =   2295
      End
      Begin VB.Label lbl_rut 
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   8280
         TabIndex        =   39
         Top             =   1680
         Width           =   2295
      End
      Begin VB.Label lbl_cupones 
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   8280
         TabIndex        =   38
         Top             =   960
         Width           =   1215
      End
      Begin VB.Label lbl_ciudad 
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   8280
         TabIndex        =   37
         Top             =   600
         Width           =   2775
      End
      Begin VB.Label lbl_vcto 
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   8280
         TabIndex        =   36
         Top             =   240
         Width           =   2775
      End
      Begin VB.Label Label3 
         Caption         =   "Deducción de Encaje"
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
         TabIndex        =   24
         Top             =   1320
         Width           =   1935
      End
      Begin VB.Label Label4 
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
         Left            =   120
         TabIndex        =   23
         Top             =   600
         Width           =   1455
      End
      Begin VB.Label Label5 
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
         Height          =   255
         Left            =   120
         TabIndex        =   22
         Top             =   1680
         Width           =   1935
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
         Left            =   6000
         TabIndex        =   21
         Top             =   600
         Width           =   1455
      End
      Begin VB.Label Label10 
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
         Left            =   6000
         TabIndex        =   20
         Top             =   960
         Width           =   1455
      End
      Begin VB.Label Label13 
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
         Height          =   255
         Left            =   6000
         TabIndex        =   19
         Top             =   1320
         Width           =   975
      End
      Begin VB.Label Label12 
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
         Height          =   255
         Left            =   6000
         TabIndex        =   18
         Top             =   2040
         Width           =   1335
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
         Left            =   6000
         TabIndex        =   17
         Top             =   1680
         Width           =   1095
      End
      Begin VB.Label Label9 
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
         Height          =   255
         Left            =   6000
         TabIndex        =   16
         Top             =   240
         Width           =   2175
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
         Left            =   120
         TabIndex        =   15
         Top             =   2400
         Width           =   495
      End
      Begin VB.Label Label6 
         Caption         =   "Indice de Basilea"
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
         TabIndex        =   14
         Top             =   2040
         Width           =   1815
      End
      Begin VB.Label Label2 
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
         Left            =   120
         TabIndex        =   13
         Top             =   960
         Width           =   1815
      End
      Begin VB.Label Label1 
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
         Left            =   120
         TabIndex        =   12
         Top             =   240
         Width           =   615
      End
   End
   Begin VB.Label Label24 
      Caption         =   "DESCRIPCIÓN"
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
      TabIndex        =   35
      Top             =   600
      Width           =   1455
   End
   Begin VB.Label Label23 
      Caption         =   "VALORIZACION"
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
      TabIndex        =   10
      Top             =   3720
      Width           =   1455
   End
   Begin VB.Label Label14 
      Caption         =   "DESCRIPCION"
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
      TabIndex        =   0
      Top             =   120
      Width           =   1455
   End
End
Attribute VB_Name = "Bac_form_valor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub box_familia_Click()

'traer todos los nemotecnicos correspondientes

End Sub



Private Sub box_nemo_Click()

'traer todos los datos correspondientes

End Sub

Private Sub Form_Load()
' traer todos los datos de los diferentes bases para llenar los label y cuadros en blanco

Me.Height = 6660
Me.Width = 11340

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
Case 1
       Unload Me
       Bac_menu_formulas.Show

Case 2


Case 3

End Select

End Sub
