VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{B32E9168-9676-11D5-B8E1-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacIrfDg 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Datos Generales"
   ClientHeight    =   5160
   ClientLeft      =   1695
   ClientTop       =   1110
   ClientWidth     =   7125
   ClipControls    =   0   'False
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacirfdg.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5160
   ScaleWidth      =   7125
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   465
      Left            =   0
      TabIndex        =   36
      Top             =   0
      Width           =   7125
      _ExtentX        =   12568
      _ExtentY        =   820
      ButtonWidth     =   794
      ButtonHeight    =   767
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbaceptar"
            Description     =   "ACEPTAR"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame Frame 
      Height          =   1230
      Index           =   3
      Left            =   75
      TabIndex        =   1
      Top             =   3720
      Width           =   6945
      _Version        =   65536
      _ExtentX        =   12250
      _ExtentY        =   2170
      _StockProps     =   14
      Caption         =   "Emisor"
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
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   6090
         Top             =   1350
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   23
         ImageHeight     =   23
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   1
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacirfdg.frx":030A
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.TextBox txtRut 
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   1245
         MaxLength       =   9
         MouseIcon       =   "Bacirfdg.frx":075C
         MousePointer    =   99  'Custom
         TabIndex        =   5
         Top             =   360
         Width           =   1215
      End
      Begin VB.TextBox TxtNom 
         Enabled         =   0   'False
         Height          =   285
         Left            =   1200
         TabIndex        =   4
         Top             =   780
         Width           =   5520
      End
      Begin VB.TextBox txtDig 
         Enabled         =   0   'False
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   2580
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   3
         Top             =   360
         Visible         =   0   'False
         Width           =   315
      End
      Begin VB.TextBox TxtGen 
         Enabled         =   0   'False
         Height          =   285
         Left            =   4720
         TabIndex        =   2
         Top             =   360
         Width           =   2000
      End
      Begin VB.Label Label 
         Caption         =   "-"
         Height          =   315
         Index           =   8
         Left            =   2460
         TabIndex        =   9
         Top             =   360
         Visible         =   0   'False
         Width           =   135
      End
      Begin VB.Label Label 
         Caption         =   "Rut"
         Height          =   255
         Index           =   6
         Left            =   240
         TabIndex        =   8
         Top             =   410
         Width           =   735
      End
      Begin VB.Label Label 
         Caption         =   "Nombre"
         Height          =   255
         Index           =   7
         Left            =   240
         TabIndex        =   7
         Top             =   840
         Width           =   735
      End
      Begin VB.Label Label 
         Caption         =   "Genérico"
         Height          =   255
         Index           =   9
         Left            =   3705
         TabIndex        =   6
         Top             =   410
         Width           =   870
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1335
      Index           =   4
      Left            =   90
      TabIndex        =   10
      Top             =   2295
      Width           =   6930
      _Version        =   65536
      _ExtentX        =   12224
      _ExtentY        =   2355
      _StockProps     =   14
      Caption         =   "Operación Original"
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
      Begin VB.TextBox txtNumOPer 
         Enabled         =   0   'False
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   1710
         TabIndex        =   14
         Top             =   360
         Width           =   1455
      End
      Begin VB.TextBox txtTipoper 
         Enabled         =   0   'False
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   1740
         TabIndex        =   13
         Top             =   870
         Width           =   1815
      End
      Begin VB.TextBox txtVctOpe 
         Enabled         =   0   'False
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   5265
         TabIndex        =   12
         Top             =   360
         Width           =   1455
      End
      Begin VB.TextBox txtDispo 
         Enabled         =   0   'False
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   5280
         TabIndex        =   11
         Top             =   855
         Width           =   1455
      End
      Begin VB.Label Label 
         Caption         =   "Tipo Operación"
         Height          =   255
         Index           =   10
         Left            =   225
         TabIndex        =   18
         Top             =   900
         Width           =   1335
      End
      Begin VB.Label Label 
         Caption         =   "Número"
         Height          =   255
         Index           =   11
         Left            =   230
         TabIndex        =   17
         Top             =   390
         Width           =   1335
      End
      Begin VB.Label Label 
         Caption         =   "Fecha Vcto."
         Height          =   255
         Index           =   12
         Left            =   3780
         TabIndex        =   16
         Top             =   405
         Width           =   1290
      End
      Begin VB.Label Label 
         Caption         =   "Días Disponible"
         Height          =   255
         Index           =   14
         Left            =   3780
         TabIndex        =   15
         Top             =   900
         Width           =   1410
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1800
      Index           =   0
      Left            =   90
      TabIndex        =   19
      Top             =   510
      Width           =   2775
      _Version        =   65536
      _ExtentX        =   4895
      _ExtentY        =   3175
      _StockProps     =   14
      Caption         =   "Instrumento"
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
      Begin VB.TextBox txtNemo 
         Enabled         =   0   'False
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   1350
         TabIndex        =   21
         Top             =   480
         Width           =   1370
      End
      Begin VB.ComboBox cmbMonEmi 
         Height          =   315
         ItemData        =   "Bacirfdg.frx":0A66
         Left            =   1350
         List            =   "Bacirfdg.frx":0A68
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   885
         Width           =   1380
      End
      Begin VB.Label Label 
         Caption         =   "Nemotécnico:"
         Height          =   255
         Index           =   0
         Left            =   90
         TabIndex        =   23
         Top             =   510
         Width           =   1125
      End
      Begin VB.Label Label 
         Caption         =   "Moneda"
         Height          =   255
         Index           =   1
         Left            =   105
         TabIndex        =   22
         Top             =   990
         Width           =   870
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1800
      Index           =   2
      Left            =   5115
      TabIndex        =   24
      Top             =   510
      Width           =   1920
      _Version        =   65536
      _ExtentX        =   3387
      _ExtentY        =   3175
      _StockProps     =   14
      Caption         =   "Tasa"
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
      Begin BACControles.TXTNumero ftbTasEmi 
         Height          =   255
         Left            =   840
         TabIndex        =   35
         Top             =   480
         Width           =   975
         _ExtentX        =   1720
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
      End
      Begin VB.ComboBox cmbBasEmi 
         Height          =   315
         ItemData        =   "Bacirfdg.frx":0A6A
         Left            =   870
         List            =   "Bacirfdg.frx":0A77
         Style           =   2  'Dropdown List
         TabIndex        =   25
         Top             =   945
         Width           =   855
      End
      Begin VB.Label Label 
         Caption         =   "Base"
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   27
         Top             =   1030
         Width           =   495
      End
      Begin VB.Label Label 
         Caption         =   "Emisión"
         Height          =   255
         Index           =   4
         Left            =   90
         TabIndex        =   26
         Top             =   540
         Width           =   675
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1800
      Index           =   1
      Left            =   2925
      TabIndex        =   28
      Top             =   510
      Width           =   2145
      _Version        =   65536
      _ExtentX        =   3784
      _ExtentY        =   3175
      _StockProps     =   14
      Caption         =   "Fecha"
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
      Begin BACControles.TXTFecha dtbFecCup 
         Height          =   255
         Left            =   840
         TabIndex        =   34
         Top             =   1440
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/11/2000"
      End
      Begin BACControles.TXTFecha dtbFecVct 
         Height          =   255
         Left            =   840
         TabIndex        =   33
         Top             =   960
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/11/2000"
      End
      Begin BACControles.TXTFecha dtbFecEmi 
         Height          =   255
         Left            =   840
         TabIndex        =   32
         Top             =   480
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/11/2000"
      End
      Begin VB.Label Label 
         Caption         =   "Vcto."
         Height          =   290
         Index           =   3
         Left            =   120
         TabIndex        =   31
         Top             =   1000
         Width           =   675
      End
      Begin VB.Label Label 
         Caption         =   "Emisión"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   30
         Top             =   540
         Width           =   735
      End
      Begin VB.Label Label 
         Caption         =   "Cupon"
         Height          =   255
         Index           =   13
         Left            =   135
         TabIndex        =   29
         Top             =   1440
         Width           =   675
      End
   End
   Begin Threed.SSCommand cmdAceptar 
      Height          =   450
      Left            =   2190
      TabIndex        =   0
      Top             =   5445
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Aceptar"
      ForeColor       =   8388608
      Font3D          =   3
   End
End
Attribute VB_Name = "BacIrfDg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim objMonedas  As New clsMonedas
Dim objEmisor   As New clsEmisor

'Flag para indicar que el Form_Activate los realizo una sola vez
Dim giLoad%


Public varPsSeriado As String


Private Sub cmdAceptar_Click()
'
'    giAceptar% = True
'    Unload Me
    
End Sub




Private Sub Form_Activate()
    
    '¿Viene del evento Load?
    If giLoad% = False Then
        'No
        Exit Sub
    End If
    
    BacControlWindows 10
    
    Call objMonedas.LeerMonedas
    Call objMonedas.Coleccion2Combo(cmbMonEmi)
    Call objEmisor.LeerPorRut(BacDatEmi.lRutemi, "O")
    
    BacControlWindows 10
    
    txtNemo.Text = BacDatEmi.sInstSer
    dtbFecEmi.Text = BacDatEmi.sFecEmi
    dtbFecVct.Text = BacDatEmi.sFecvct
    ftbTasEmi.Text = BacDatEmi.dTasEmi
    dtbFecCup.Text = BacDatEmi.sFecpcup
    TxtNumoper.Text = BacDatEmi.dNumoper
    
    If Mid$(BacDatEmi.sTipOper, 1, 2) = "CP" Then txtTipoper.Text = "Compra Propia" Else txtTipoper.Text = "Compra Pacto"
    txtVctOpe.Text = BacDatEmi.sFecvtop
    txtDispo.Text = BacDatEmi.iDiasdis
    
    txtrut.Text = objEmisor.emrut
    txtDig.Text = objEmisor.emdv
    TxtNom.Text = objEmisor.emnombre
    TxtGen.Text = objEmisor.emgeneric
        
    cmbMonEmi.ListIndex = BacBuscaComboIndice(cmbMonEmi, BacDatEmi.iMonemi)
    cmbBasEmi.ListIndex = BacBuscaComboGlosa(cmbBasEmi, BacDatEmi.iBasemi)
    
    'Deshabilita controles de los que ya se tiene el dato
    dtbFecEmi.Enabled = False
    dtbFecVct.Enabled = False
    dtbFecCup.Enabled = False
    ftbTasEmi.Enabled = False
    txtrut.Enabled = False
    txtDig.Enabled = False
    
    cmbMonEmi.Enabled = False
    cmbBasEmi.Enabled = False
    
    If varPsSeriado = "N" Then
        Label(2).Visible = False
        dtbFecEmi.Visible = False
    Else
        Label(2).Visible = True
        dtbFecEmi.Visible = True
    End If

    giLoad% = False
    
End Sub


Private Sub Form_KeyPress(KeyAscii As Integer)

    If KeyAscii% = vbKeyReturn Then
        SendKeys "{TAB}"
        KeyAscii% = 0
    End If
        
End Sub

Private Sub Form_Load()
   
    BacCentrarPantalla Me
    giAceptar% = False
    giLoad% = True
    
End Sub



Private Sub Form_Unload(Cancel As Integer)

    Set objMonedas = Nothing
    Set objEmisor = Nothing
    
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
    Case "ACEPTAR"
        giAceptar% = True
        Unload Me
End Select
End Sub
