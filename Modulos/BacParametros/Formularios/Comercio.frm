VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacMntComercioConcepto 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Códigos de Comercio y Conceptos"
   ClientHeight    =   4830
   ClientLeft      =   885
   ClientTop       =   1170
   ClientWidth     =   8595
   FillStyle       =   0  'Solid
   Icon            =   "Comercio.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4830
   ScaleWidth      =   8595
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5580
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Comercio.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Comercio.frx":0624
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Comercio.frx":093E
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Comercio.frx":0D90
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Comercio.frx":11E2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   14
      Top             =   0
      Width           =   8595
      _ExtentX        =   15161
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4170
      Left            =   0
      TabIndex        =   0
      Top             =   600
      Width           =   8550
      _Version        =   65536
      _ExtentX        =   15081
      _ExtentY        =   7355
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSFrame fraComercioConcepto 
         Height          =   1800
         Left            =   60
         TabIndex        =   6
         Top             =   15
         Width           =   8370
         _Version        =   65536
         _ExtentX        =   14764
         _ExtentY        =   3175
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
         ShadowStyle     =   1
         Begin VB.Frame Frame1 
            Height          =   90
            Left            =   2115
            TabIndex        =   15
            Top             =   870
            Width           =   6165
         End
         Begin VB.TextBox txtComercio 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   645
            MaxLength       =   6
            MouseIcon       =   "Comercio.frx":14FC
            MousePointer    =   99  'Custom
            TabIndex        =   1
            Top             =   360
            Width           =   705
         End
         Begin VB.TextBox txtConcepto 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   9675
            MaxLength       =   3
            TabIndex        =   5
            Top             =   825
            Width           =   615
         End
         Begin VB.TextBox txtGlosa 
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
            Left            =   2430
            MaxLength       =   60
            TabIndex        =   2
            Top             =   360
            Width           =   5805
         End
         Begin VB.ListBox lstLista 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   540
            Left            =   75
            TabIndex        =   7
            Top             =   2940
            Width           =   6885
         End
         Begin VB.ComboBox cmbDocumento 
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
            Left            =   105
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   1350
            Width           =   3330
         End
         Begin VB.ComboBox cmbCodigoOMA 
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
            Left            =   3585
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   1350
            Width           =   4710
         End
         Begin VB.Label Label 
            Caption         =   " Código de Comercio "
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
            Left            =   135
            TabIndex        =   13
            Top             =   135
            Width           =   1875
         End
         Begin VB.Label Label 
            Caption         =   " Concepto"
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
            Index           =   1
            Left            =   9420
            TabIndex        =   12
            Top             =   555
            Width           =   915
         End
         Begin VB.Label Label 
            Caption         =   " Descripción"
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
            Left            =   4620
            TabIndex        =   11
            Top             =   120
            Width           =   1275
         End
         Begin VB.Label Label 
            Caption         =   " Tipo de Documento"
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
            Index           =   3
            Left            =   75
            TabIndex        =   10
            Top             =   1110
            Width           =   1875
         End
         Begin VB.Label Label1 
            Caption         =   "Relacionada con ..."
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   330
            Left            =   75
            TabIndex        =   9
            Top             =   795
            Width           =   2565
         End
         Begin VB.Label Label 
            Caption         =   " Codigo OMA"
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
            Index           =   4
            Left            =   3555
            TabIndex        =   8
            Top             =   1110
            Width           =   1995
         End
      End
      Begin Threed.SSFrame fraComplementos 
         Height          =   2235
         Left            =   60
         TabIndex        =   16
         Top             =   1800
         Width           =   4725
         _Version        =   65536
         _ExtentX        =   8334
         _ExtentY        =   3942
         _StockProps     =   14
         Caption         =   " Datos a Incorporar para este Código ..."
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
         ShadowStyle     =   1
         Begin Threed.SSCheck chkPantalla 
            Height          =   285
            Index           =   6
            Left            =   100
            TabIndex        =   17
            Top             =   1875
            Width           =   4600
            _Version        =   65536
            _ExtentX        =   8114
            _ExtentY        =   503
            _StockProps     =   78
            Caption         =   "Relación con Planillas ..."
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
         End
         Begin Threed.SSCheck chkPantalla 
            Height          =   285
            Index           =   5
            Left            =   100
            TabIndex        =   18
            Top             =   1620
            Width           =   4600
            _Version        =   65536
            _ExtentX        =   8114
            _ExtentY        =   503
            _StockProps     =   78
            Caption         =   "Acuerdos"
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
         End
         Begin Threed.SSCheck chkPantalla 
            Height          =   285
            Index           =   4
            Left            =   100
            TabIndex        =   19
            Top             =   1365
            Width           =   4600
            _Version        =   65536
            _ExtentX        =   8114
            _ExtentY        =   503
            _StockProps     =   78
            Caption         =   "Autorización del BCCH"
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
         End
         Begin Threed.SSCheck chkPantalla 
            Height          =   285
            Index           =   3
            Left            =   100
            TabIndex        =   20
            Top             =   1110
            Width           =   4600
            _Version        =   65536
            _ExtentX        =   8114
            _ExtentY        =   503
            _StockProps     =   78
            Caption         =   "Exportaciones"
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
         End
         Begin Threed.SSCheck chkPantalla 
            Height          =   285
            Index           =   2
            Left            =   100
            TabIndex        =   21
            Top             =   855
            Width           =   4600
            _Version        =   65536
            _ExtentX        =   8114
            _ExtentY        =   503
            _StockProps     =   78
            Caption         =   "Cobertura de Importaciones (Detalle de Intereses)"
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
         End
         Begin Threed.SSCheck chkPantalla 
            Height          =   285
            Index           =   1
            Left            =   100
            TabIndex        =   22
            Top             =   600
            Width           =   4600
            _Version        =   65536
            _ExtentX        =   8114
            _ExtentY        =   503
            _StockProps     =   78
            Caption         =   "Derivados"
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
         End
         Begin Threed.SSCheck chkPantalla 
            Height          =   285
            Index           =   0
            Left            =   100
            TabIndex        =   23
            Top             =   345
            Width           =   4600
            _Version        =   65536
            _ExtentX        =   8114
            _ExtentY        =   503
            _StockProps     =   78
            Caption         =   "Operación con Financiamiento Internacional"
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
         End
      End
      Begin Threed.SSFrame fraBCCH 
         Height          =   2235
         Left            =   4830
         TabIndex        =   24
         Top             =   1800
         Width           =   3600
         _Version        =   65536
         _ExtentX        =   6350
         _ExtentY        =   3942
         _StockProps     =   14
         Caption         =   " Datos condicionales para BCCH ..."
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
         ShadowStyle     =   1
         Begin Threed.SSCheck chkEstadistica 
            Height          =   285
            Left            =   105
            TabIndex        =   25
            Top             =   375
            Width           =   2835
            _Version        =   65536
            _ExtentX        =   5001
            _ExtentY        =   503
            _StockProps     =   78
            Caption         =   "Es una planilla Estadística"
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
         End
         Begin Threed.SSCheck chkPaisBCCH 
            Height          =   285
            Left            =   1425
            TabIndex        =   26
            Top             =   1080
            Width           =   1515
            _Version        =   65536
            _ExtentX        =   2672
            _ExtentY        =   503
            _StockProps     =   78
            Caption         =   "País"
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
         End
         Begin Threed.SSCheck chkRutBCCH 
            Height          =   285
            Left            =   1425
            TabIndex        =   27
            Top             =   825
            Width           =   1515
            _Version        =   65536
            _ExtentX        =   2672
            _ExtentY        =   503
            _StockProps     =   78
            Caption         =   "Rut de Cliente"
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
         End
         Begin VB.Label Label 
            Caption         =   "No informa ..."
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
            Index           =   5
            Left            =   120
            TabIndex        =   28
            Top             =   840
            Width           =   1275
         End
      End
   End
End
Attribute VB_Name = "BacMntComercioConcepto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim nEstado%, cEstado$

Private Datos()
Private xLine$
Private xStr$
Private I%

Private Sub ActivaBotones(Enabled As Boolean)

    Toolbar1.Buttons(4).Enabled = Enabled
    Toolbar1.Buttons(3).Enabled = Enabled
    
    txtComercio.Enabled = Not Enabled
    txtConcepto.Enabled = Not Enabled
    TxtGlosa.Enabled = Enabled
   
    cmbCodigoOMA.Enabled = Enabled
    cmbDocumento.Enabled = Enabled
    fraBCCH.Enabled = Enabled
    fraComplementos.Enabled = Enabled
        
End Sub

Private Sub chkPantalla_Click(Index As Integer, Value As Integer)
    If Index = 2 Or Index = 3 Then
        I = IIf(Index = 2, 3, 2)
        If chkPantalla(I).Value Then
            chkPantalla(I).Value = Not chkPantalla(Index).Value
        End If
    End If
End Sub

Private Sub chkPantalla_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii = 13 Then
        chkPantalla(Index).Value = Not chkPantalla(Index).Value
    End If
End Sub
Private Sub cmbCodigoOMA_Click()

   Toolbar1.Buttons(3).Enabled = True

End Sub
Private Sub cmbCodigoOMA_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
       cmbCodigoOMA_Click
   End If
End Sub
Private Sub cmbDocumento_Click()
Dim I%

    I = Val(Left(cmbDocumento, 2))
    
    '-- opciones de transferencias (8..11), carga idem a divisas (1..4)
    If I > 7 Then
        I = I - 7
    End If
    
    Carga_Listas I & "OPERACIONESXDOCUMENTO", cmbCodigoOMA

End Sub
Private Sub cmbDocumento_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then
        cmbCodigoOMA_Click
        cmbCodigoOMA.SetFocus
    End If

End Sub

Private Sub cmdlimpiar_Click()
    txtComercio.Text = ""
    txtConcepto.Text = ""
    TxtGlosa.Text = ""
    txtComercio.Enabled = True
    txtConcepto.Enabled = txtComercio.Enabled
    TxtGlosa.Enabled = Not txtComercio.Enabled
    cmbDocumento.Enabled = Not txtComercio.Enabled
    cmbCodigoOMA.Enabled = Not txtComercio.Enabled
    Carga_Listas "TIPODOCUMENTO", cmbDocumento
    
    If cmbDocumento.ListCount - 1 >= 0 Then
        cmbDocumento.ListIndex = 0
        Carga_Listas Left(cmbDocumento, 1) & "OPERACIONESXDOCUMENTO", cmbCodigoOMA
    Else
        Carga_Listas "CODIGOSOMA", cmbCodigoOMA
    End If
    
    If cmbCodigoOMA.ListCount - 1 >= 0 Then
        cmbCodigoOMA.ListIndex = 0
    End If
    
    For I = 0 To 6
        chkPantalla(I).Value = False
    Next I
    
    Call ActivaBotones(False)
    
End Sub

Private Sub Form_Load()
    
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_652" _
                          , "07" _
                          , "Ingreso a Opción de Comercio/Concepto" _
                          , " " _
                          , " " _
                          , " ")
    
    
    Move 15, 1
    
    txtComercio.Text = ""
    txtConcepto.Text = ""
    TxtGlosa.Text = ""
    
    txtComercio.Enabled = True
    txtConcepto.Enabled = txtComercio.Enabled
    TxtGlosa.Enabled = Not txtComercio.Enabled
    cmbDocumento.Enabled = Not txtComercio.Enabled
    cmbCodigoOMA.Enabled = Not txtComercio.Enabled
    Carga_Listas "TIPODOCUMENTO", cmbDocumento
    
    If cmbDocumento.ListCount - 1 >= 0 Then
        cmbDocumento.ListIndex = 0
        Carga_Listas Left(cmbDocumento, 1) & "OPERACIONESXDOCUMENTO", cmbCodigoOMA
    Else
        Carga_Listas "CODIGOSOMA", cmbCodigoOMA
    End If
    
    If cmbCodigoOMA.ListCount - 1 >= 0 Then
        cmbCodigoOMA.ListIndex = 0
    End If
    
    Call ActivaBotones(False)
    
    Toolbar1.Buttons(2).Enabled = False
    
End Sub

Private Sub lstLista_DblClick()
    
    If lstLista.ListIndex < 0 Then
        Exit Sub
    End If

    Toolbar1.Buttons(3).Enabled = True
    If Left(lstLista.List(lstLista.ListIndex), 2) = "<<" Then
       Call Toolbar1_ButtonClick(Toolbar1.Buttons(1))
        Toolbar1.Buttons(3).Enabled = True
    Else
        xLine = lstLista.List(lstLista.ListIndex)
        txtComercio.Text = Left(xLine, 6)
        txtConcepto.Text = Mid(xLine, 10, 3)
        TxtGlosa.Text = Trim(Mid(xLine, 14, 70))
        Toolbar1.Buttons(1).Enabled = True
    End If
    txtComercio.Enabled = Toolbar1.Buttons(3).Enabled
    txtConcepto.Enabled = Toolbar1.Buttons(3).Enabled
    TxtGlosa.Enabled = Toolbar1.Buttons(3).Enabled
    If txtComercio.Enabled = True Then
        txtComercio.SetFocus
    End If
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim sAux$

    Select Case Button.Index
         Case 1
            txtComercio.Text = ""
            txtConcepto.Text = ""
            TxtGlosa.Text = ""
            
            Carga_Listas "TIPODOCUMENTO", cmbDocumento
            
            ActivaBotones False
            
            For I = 0 To 6
                chkPantalla(I).Value = False
            Next I
            
            chkEstadistica = False
            chkPaisBCCH = False
            chkRutBCCH = False
            
            Toolbar1.Buttons(3).Enabled = False
                 
        Case 2
                 
                 'Call bacImpCodigosComercio
        
        Case 3
        
             sAux = ""
             For I = 0 To 6
                 sAux = sAux & IIf(chkPantalla(I), "1", "0")
             Next I
                 
             Envia = Array()
             AddParam Envia, txtComercio.Text
             AddParam Envia, txtConcepto.Text
             AddParam Envia, TxtGlosa.Text
             AddParam Envia, CDbl(Left(cmbDocumento, 1))
             AddParam Envia, CDbl(Left(cmbCodigoOMA, 3))
             AddParam Envia, IIf(chkEstadistica, "S", "N")
             AddParam Envia, sAux
             AddParam Envia, IIf(chkPaisBCCH, "S", "N")
             AddParam Envia, IIf(chkRutBCCH, "S", "N")
                 
             If Bac_Sql_Execute("SP_GRABA_CODIGO_COMERCIO", Envia) Then
                 Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                         , gsbac_fecp _
                                         , gsBac_IP _
                                         , gsBAC_User _
                                         , "PCA" _
                                         , "OPC_652 " _
                                         , "01" _
                                         , "Grabar Codigo Comercio" _
                                         , "CODIGO_COMERCIO" _
                                         , " " _
                                         , "Grabar Codigo Comercio" & " " & Trim(txtComercio.Text) & " Concepto " & Trim(txtConcepto.Text))
                 cmdlimpiar_Click
                 MsgBox "Información Grabada", vbInformation, TITSISTEMA
                 'Call Carga
             
             Else
                 
                 MsgBox "No se Puede Grabar", vbCritical, TITSISTEMA
             
             End If
        
        Case 4
        
                Dim Borrar$
                Dim ww
                
                ww = MsgBox("Seguro de Eliminar", vbQuestion + vbYesNo, TITSISTEMA)
                
                If ww = 6 Then
                
                Borrar = "N"
                
Retry_Save:
                nEstado = -1
                cEstado = "No se puede Eliminar este Código de Comercio "
                
                ''''''''''''''''''''''''''''''''    Sql = "sp_Borrar_Codigo_Comercio '" & txtComercio & "'"
                ''''''''''''''''''''''''''''''''    Sql = Sql & ", '" & TxtConcepto.Text & "'"
                ''''''''''''''''''''''''''''''''    Sql = Sql & ", '" & Borrar & "'"
                
                Envia = Array()
                
                AddParam Envia, txtComercio
                AddParam Envia, txtConcepto.Text
                AddParam Envia, Borrar
                
                If Bac_Sql_Execute("SP_BORRAR_CODIGO_COMERCIO ", Envia) Then
                    
                    nEstado = 0
                
                End If
                
                If Bac_SQL_Fetch(Datos()) Then
                    
                    nEstado = Datos(1)
                    cEstado = cEstado & vbCrLf & vbCrLf & Datos(2)
                
                End If
                
                If nEstado <> 0 Then
                    
                    If nEstado <> -2 Then
                        
                        nEstado = vbOKOnly
                    
                    Else
                        
                        nEstado = vbRetryCancel
                        cEstado = cEstado & vbCrLf & vbCrLf & "¿ Forzar Eliminación ?"
                        Borrar = "S"
                    
                    End If
                    
                    If MsgBox(cEstado, vbExclamation + nEstado, TITSISTEMA) = IIf(nEstado = vbOKOnly, vbOK, vbCancel) Then
                        
                        Exit Sub
                    
                    End If
                    
                    GoTo Retry_Save
                
                End If
                
                Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                                , gsbac_fecp _
                                                , gsBac_IP _
                                                , gsBAC_User _
                                                , "PCA" _
                                                , "OPC_652 " _
                                                , "03" _
                                                , " Elimina, Codigo Comercio" _
                                                , "CODIGO_COMERCIO" _
                                                , " " _
                                                , " Elimina, Codigo Comercio" & " " & Trim(txtComercio.Text) & " Concepto " & Trim(txtConcepto.Text))
                txtComercio.Text = ""
                txtConcepto.Text = ""
                TxtGlosa.Text = ""
                txtComercio.Enabled = True
                txtConcepto.Enabled = txtComercio.Enabled
                TxtGlosa.Enabled = Not txtComercio.Enabled
                cmbDocumento.Enabled = Not txtComercio.Enabled
                cmbCodigoOMA.Enabled = Not txtComercio.Enabled
                Carga_Listas "TIPODOCUMENTO", cmbDocumento
                
                If cmbDocumento.ListCount - 1 >= 0 Then
                    cmbDocumento.ListIndex = 0
                    Carga_Listas Left(cmbDocumento, 1) & "OPERACIONESXDOCUMENTO", cmbCodigoOMA
                Else
                    Carga_Listas "CODIGOSOMA", cmbCodigoOMA
                End If
                
                If cmbCodigoOMA.ListCount - 1 >= 0 Then
                    cmbCodigoOMA.ListIndex = 0
                End If
                
                cmdlimpiar_Click
                
                Call ActivaBotones(False)
                
                End If
                
        Case 5
                Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                         , gsbac_fecp _
                                         , gsBac_IP _
                                         , gsBAC_User _
                                         , "PCA" _
                                         , "OPC_652 " _
                                         , "08" _
                                         , "Salir Opcion de Comercio/concepto" _
                                         , "CODIGO_COMERCIO" _
                                         , " " _
                                         , " ")
               Unload Me
               
    End Select
    
End Sub

Private Sub txtComercio_DblClick()
    
    BacControlWindows 100
    BacAyuda.Tag = "TBCODIGOSCOMERCIO"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
    
        Call ActivaBotones(True)
        
        txtComercio.Text = gsCodigo$
        txtConcepto.Text = gsDigito$
        TxtGlosa.Text = gsGlosa$
 
    Envia = Array()
    AddParam Envia, txtComercio
    AddParam Envia, txtConcepto

    If Bac_Sql_Execute("SP_LEER_CODIGOS_COMERCIO", Envia) Then

        If Bac_SQL_Fetch(Datos()) Then

            TxtGlosa = Datos(4)
            bacBuscarCombo cmbDocumento, Datos(5)
            bacBuscarCombo cmbCodigoOMA, Datos(6)

            chkEstadistica.Value = (UCase(Datos(7)) = "S")

            For I = 0 To 6
                chkPantalla(I).Value = (Mid(Datos(8), I + 1, 1) = "1")
            Next I

            chkPaisBCCH.Value = (UCase(Datos(9)) = "S")
            chkRutBCCH.Value = (UCase(Datos(10)) = "S")

            SendKeys "{TAB}"

            ActivaBotones True

         End If
     End If
 End If
End Sub
Private Sub txtComercio_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode = vbKeyF3 Then
        Call txtComercio_DblClick
    End If

End Sub
Private Sub txtComercio_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Envia = Array()
        AddParam Envia, txtComercio
        AddParam Envia, txtConcepto
    
        If Bac_Sql_Execute("SP_LEER_CODIGOS_COMERCIO", Envia) Then
    
            If Bac_SQL_Fetch(Datos()) Then
    
                TxtGlosa = Datos(4)
                bacBuscarCombo cmbDocumento, Datos(5)
                bacBuscarCombo cmbCodigoOMA, Datos(6)
    
                chkEstadistica.Value = (UCase(Datos(7)) = "S")
    
                For I = 0 To 6
                    chkPantalla(I).Value = (Mid(Datos(8), I + 1, 1) = "1")
                Next I
    
                chkPaisBCCH.Value = (UCase(Datos(9)) = "S")
                chkRutBCCH.Value = (UCase(Datos(10)) = "S")
    
                SendKeys "{TAB}"
    
                ActivaBotones True
    
             Else
                
                SendKeys "{TAB}"
    
                ActivaBotones True
                
             End If
         End If
        'gsCodigo$ = txtComercio.Text
        'BacAyuda.Tag = "TBCODIGOSCOMERCIO"
        'BacAyuda.txtNombre.Text = LTrim(txtComercio.Text)
        'BacAyuda.Refresh
        'Call txtComercio_DblClick
        'txtComercio.Text = BacPad(Trim(txtComercio.Text), 6, "L")
        'txtConcepto.SetFocus
    ElseIf KeyAscii = 8 Then
    '-------- Elimina caracter
    ElseIf InStr("0123456789Kk", Chr(KeyAscii)) = 0 Then
        KeyAscii = 0
    Else
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
    
End Sub
'Private Sub txtComercio_LostFocus()
'
'    If Trim(txtComercio.Text) = "" Then
'        Exit Sub
'    End If
'
'    txtComercio.Text = BacPad(Trim(txtComercio.Text), 6, "L")
'
'    If txtConcepto.Text <> "" Then
'        txtConcepto.Text = Format(Val(Left(txtConcepto.Text, Len(txtConcepto.Text) - 1)), "00") & IIf(Right(txtConcepto.Text, 1) = " ", "0", Right(txtConcepto.Text, 1))    'Format(Val(Left(txtConcepto.Text, 5)), "00000") & IIf(Right(txtConcepto.Text, 1) = " ", "0", Right(txtConcepto.Text, 1))
'
'        Envia = Array()
'        AddParam Envia, txtComercio
'        AddParam Envia, txtConcepto
'
'        If Bac_Sql_Execute("sp_Leer_Codigos_Comercio ", Envia) Then
'
'            If Bac_SQL_Fetch(datos()) Then
'
'                txtConcepto = datos(3)
'                TxtGlosa = datos(4)
'                bacBuscarCombo cmbDocumento, datos(5)
'                bacBuscarCombo cmbCodigoOMA, datos(6)
'
'                Toolbar1.Buttons(3).Enabled = True
'
'            End If
'
'        End If
'
'    End If
'
'End Sub

Private Sub txtConcepto_KeyPress(KeyAscii As Integer)
'
'    If KeyAscii = 13 Then
'        TxtConcepto_LostFocus
'
'    ElseIf KeyAscii = 8 Then
'    '-------- Elimina caracter
'    ElseIf InStr("0123456789Kk", Chr(KeyAscii)) = 0 Then
'        KeyAscii = 0
'    Else
'        KeyAscii = Asc(UCase(Chr(KeyAscii)))
'    End If
'
End Sub
Private Sub TxtConcepto_LostFocus()
    
'    If Trim(txtComercio.Text) = "" Then
'        Exit Sub
'    End If
'
'    txtComercio.Text = BacPad(Trim(txtComercio.Text), 6, "L")
'
'    If txtConcepto.Text <> "" Then
'       txtConcepto.Text = Format(Val(Left(txtConcepto.Text, Len(txtConcepto.Text) - 1)), "00") & IIf(Right(txtConcepto.Text, 1) = " ", "0", Right(txtConcepto.Text, 1))
'
'    End If
'
'    Envia = Array()
'    AddParam Envia, txtComercio
'    AddParam Envia, txtConcepto
'
'    If Bac_Sql_Execute("sp_Leer_Codigos_Comercio", Envia) Then
'
'        If Bac_SQL_Fetch(datos()) Then
'
'            TxtGlosa = datos(4)
'            bacBuscarCombo cmbDocumento, datos(5)
'            bacBuscarCombo cmbCodigoOMA, datos(6)
'
'            chkEstadistica.Value = (UCase(datos(7)) = "S")
'
'            For I = 0 To 6
'                chkPantalla(I).Value = (Mid(datos(8), I + 1, 1) = "1")
'            Next I
'
'            chkPaisBCCH.Value = (UCase(datos(9)) = "S")
'            chkRutBCCH.Value = (UCase(datos(10)) = "S")
'
'            SendKeys "{TAB}"
'
'            ActivaBotones True
'
'        End If
'
'        ActivaBotones True
'
'    End If
'
    BacControlWindows 50
'
End Sub
Private Sub txtGlosa_Change()

    If Len(Trim(TxtGlosa.Text)) > 0 And Len(Trim(txtComercio.Text)) = 5 Then 'And Len(Trim(txtConcepto.Text)) = 3 Then
        Toolbar1.Buttons(3).Enabled = True
    Else
        Toolbar1.Buttons(3).Enabled = False
    End If
    
End Sub

Private Sub txtGlosa_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbDocumento.SetFocus
    ElseIf KeyAscii = 8 Then
    '----  Elimina caracter
    Else
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
End Sub

