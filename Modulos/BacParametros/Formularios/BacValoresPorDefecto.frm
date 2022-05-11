VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacValoresPorDefecto 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Valores por Defecto"
   ClientHeight    =   7740
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   13305
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7740
   ScaleWidth      =   13305
   Begin VB.Frame frmValoresFwd 
      Height          =   4095
      Left            =   6360
      TabIndex        =   35
      Top             =   3480
      Width           =   6855
      Begin VB.ComboBox cmbFwdBroker 
         Height          =   315
         Left            =   2760
         Style           =   2  'Dropdown List
         TabIndex        =   52
         Top             =   2040
         Width           =   3810
      End
      Begin VB.ComboBox cmbFwdTipoRetiro 
         Height          =   315
         Left            =   2760
         Style           =   2  'Dropdown List
         TabIndex        =   41
         Top             =   2400
         Width           =   3810
      End
      Begin VB.ComboBox cmbFwdAreaResponsable 
         Height          =   315
         Left            =   2760
         Style           =   2  'Dropdown List
         TabIndex        =   40
         Top             =   1680
         Width           =   3810
      End
      Begin VB.ComboBox cmbFwdCartera 
         Height          =   315
         Left            =   2760
         Style           =   2  'Dropdown List
         TabIndex        =   39
         Top             =   1320
         Width           =   3810
      End
      Begin VB.ComboBox cmbFwdLibro 
         Height          =   315
         Left            =   2760
         Style           =   2  'Dropdown List
         TabIndex        =   38
         Top             =   960
         Width           =   3810
      End
      Begin VB.ComboBox cmbFwdSubCartNorm 
         Height          =   315
         Left            =   2760
         Style           =   2  'Dropdown List
         TabIndex        =   37
         Top             =   600
         Width           =   3810
      End
      Begin VB.ComboBox cmbFwdCartNorm 
         Height          =   315
         Left            =   2760
         Style           =   2  'Dropdown List
         TabIndex        =   36
         Top             =   240
         Width           =   3810
      End
      Begin VB.Label txtFwdTipoRetiro 
         Caption         =   "Tipo Retiro"
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
         Height          =   255
         Left            =   120
         TabIndex        =   48
         Top             =   2400
         Width           =   1815
      End
      Begin VB.Label txtFwdBroker 
         Caption         =   "Broker"
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
         Height          =   255
         Left            =   120
         TabIndex        =   47
         Top             =   2040
         Width           =   1815
      End
      Begin VB.Label txtFwdAreaResp 
         Caption         =   "Area Responsable"
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
         Height          =   255
         Left            =   120
         TabIndex        =   46
         Top             =   1680
         Width           =   1815
      End
      Begin VB.Label txtFwdCartera 
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
         Height          =   252
         Left            =   120
         TabIndex        =   45
         Top             =   1320
         Width           =   1812
      End
      Begin VB.Label txtFwdCodLibro 
         Caption         =   "Libro"
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
         Height          =   252
         Left            =   120
         TabIndex        =   44
         Top             =   960
         Width           =   1812
      End
      Begin VB.Label txtFwdSubCartNorm 
         Caption         =   "Sub Cart. Normativa"
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
         Height          =   252
         Left            =   120
         TabIndex        =   43
         Top             =   600
         Width           =   1812
      End
      Begin VB.Label txtFwdCartNorm 
         Caption         =   "Cartera Normativa"
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
         Height          =   252
         Left            =   120
         TabIndex        =   42
         Top             =   240
         Width           =   1812
      End
   End
   Begin VB.Frame Frame2 
      Height          =   4095
      Left            =   120
      TabIndex        =   13
      Top             =   3480
      Width           =   6135
      Begin VB.ComboBox CmbOperadorSpot 
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   33
         Top             =   3600
         Width           =   3810
      End
      Begin VB.ComboBox cmbCodigoComercio 
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   31
         Top             =   3240
         Width           =   3810
      End
      Begin VB.ComboBox cmdModalidad 
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   30
         Top             =   240
         Width           =   3810
      End
      Begin VB.ComboBox Cmb_Corres_Aquien 
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   24
         Top             =   2040
         Width           =   3810
      End
      Begin VB.ComboBox Cmb_Corres_Donde 
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   23
         Top             =   2865
         Width           =   3810
      End
      Begin VB.ComboBox Cmb_Corres_Desde 
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   22
         Top             =   2445
         Width           =   3810
      End
      Begin VB.ComboBox Cmb_Corresponsal 
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   1680
         Width           =   3810
      End
      Begin VB.ComboBox FpRecCom 
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   17
         Top             =   1320
         Width           =   3810
      End
      Begin VB.ComboBox FpEntCom 
         ForeColor       =   &H00000000&
         Height          =   315
         ItemData        =   "BacValoresPorDefecto.frx":0000
         Left            =   2160
         List            =   "BacValoresPorDefecto.frx":0002
         Style           =   2  'Dropdown List
         TabIndex        =   16
         Top             =   960
         Width           =   3810
      End
      Begin VB.ComboBox CmbOmaSpot 
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   600
         Width           =   3810
      End
      Begin VB.Label Label1 
         Caption         =   "Operador"
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
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   34
         Top             =   3600
         Width           =   1050
      End
      Begin VB.Label txtCodigoComercio 
         Caption         =   "Codigo Comercio"
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
         Height          =   255
         Left            =   120
         TabIndex        =   32
         Top             =   3240
         Width           =   2250
      End
      Begin VB.Label Label17 
         Caption         =   "Modalidad"
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
         Height          =   255
         Left            =   120
         TabIndex        =   29
         Top             =   240
         Width           =   1455
      End
      Begin VB.Label txtCorresponsalAquien 
         Caption         =   "Corresponsal A Quien"
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
         Height          =   255
         Left            =   120
         TabIndex        =   27
         Top             =   2040
         Width           =   2250
      End
      Begin VB.Label txtCorresponsalDonde 
         Caption         =   "Corresponsal Donde"
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
         Height          =   255
         Left            =   120
         TabIndex        =   26
         Top             =   2865
         Width           =   2250
      End
      Begin VB.Label txtCorresponsalDesde 
         Caption         =   "Corresponsal Desde"
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
         Height          =   255
         Left            =   120
         TabIndex        =   25
         Top             =   2445
         Width           =   2250
      End
      Begin VB.Label Label6 
         Caption         =   "Corresponsal"
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
         TabIndex        =   21
         Top             =   1680
         Width           =   1605
      End
      Begin VB.Label Label10 
         Caption         =   "F. P. Recibimos"
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
         TabIndex        =   19
         Top             =   1320
         Width           =   1605
      End
      Begin VB.Label Label4 
         Caption         =   "F. P. Entregamos"
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
         TabIndex        =   18
         Top             =   960
         Width           =   1605
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Código OMA"
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
         TabIndex        =   15
         Top             =   600
         Width           =   1605
      End
   End
   Begin VB.Frame Frame1 
      Height          =   2775
      Left            =   120
      TabIndex        =   0
      Top             =   600
      Width           =   13095
      Begin VB.TextBox txtRutCliente 
         Alignment       =   1  'Right Justify
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   2160
         MaxLength       =   10
         MouseIcon       =   "BacValoresPorDefecto.frx":0004
         MousePointer    =   99  'Custom
         MultiLine       =   -1  'True
         TabIndex        =   6
         Top             =   2040
         Width           =   1140
      End
      Begin VB.TextBox txtCodRut 
         Height          =   315
         Left            =   4560
         TabIndex        =   8
         Top             =   2040
         Width           =   975
      End
      Begin VB.TextBox txtDig_Cliente 
         Height          =   315
         Left            =   3360
         TabIndex        =   7
         Top             =   2040
         Width           =   375
      End
      Begin VB.ComboBox cmbPlataforma 
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   600
         Width           =   2535
      End
      Begin VB.ComboBox cmbCV 
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   1680
         Width           =   1635
      End
      Begin VB.ComboBox cmbMoneda2 
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   1320
         Width           =   2550
      End
      Begin VB.ComboBox cmbMoneda1 
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   960
         Width           =   2550
      End
      Begin VB.ComboBox cmbProducto 
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   2160
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   240
         Width           =   3810
      End
      Begin VB.Label Label3 
         Caption         =   "Código"
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
         Height          =   255
         Left            =   3840
         TabIndex        =   51
         Top             =   2040
         Width           =   615
      End
      Begin VB.Label Label12 
         Caption         =   "Plataforma"
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
         Height          =   255
         Left            =   120
         TabIndex        =   49
         Top             =   600
         Width           =   1095
      End
      Begin VB.Label Label16 
         Caption         =   "Rut Cliente"
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
         Height          =   255
         Left            =   120
         TabIndex        =   28
         Top             =   2040
         Width           =   1095
      End
      Begin VB.Label lbCV 
         Caption         =   "Compra / Venta"
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
         Height          =   255
         Left            =   120
         TabIndex        =   12
         Top             =   1680
         Width           =   1575
      End
      Begin VB.Label txtMdaFwd 
         Caption         =   "Moneda 2"
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
         Height          =   255
         Left            =   120
         TabIndex        =   11
         Top             =   1320
         Width           =   1620
      End
      Begin VB.Label lbMoneda 
         Caption         =   "Moneda 1"
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
         Height          =   255
         Left            =   120
         TabIndex        =   10
         Top             =   960
         Width           =   1140
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
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
         Left            =   120
         TabIndex        =   9
         Top             =   240
         Width           =   780
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   50
      Top             =   0
      Width           =   13305
      _ExtentX        =   23469
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "IconImageList"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
            Object.Width           =   1e-4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "NUEVO"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "BUSCAR"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "GRABAR"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "SALIR"
            ImageIndex      =   4
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList IconImageList 
         Left            =   5640
         Top             =   120
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   4
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacValoresPorDefecto.frx":030E
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacValoresPorDefecto.frx":11E8
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacValoresPorDefecto.frx":20C2
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacValoresPorDefecto.frx":2F9C
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacValoresPorDefecto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim GLB_CARTERA As String
Dim GLB_CARTERA_NORMATIVA As String
Dim GLB_LIBRO As String
Dim GLB_AREA_RESPONSABLE As String
Dim GLB_SUB_CARTERA_NORMATIVA As String
Dim GLB_ID_SISTEMA As String

Private objCliente As Object

Private Sub Cmb_Corres_Aquien_Click()
    Cmb_Corres_Desde.SetFocus
End Sub

Private Sub Cmb_Corres_Aquien_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Cmb_Corres_Desde.SetFocus
    End If
End Sub

Private Sub Cmb_Corres_Desde_Click()
    Cmb_Corres_Donde.SetFocus
End Sub

Private Sub Cmb_Corres_Desde_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Cmb_Corres_Donde.SetFocus
    End If
End Sub

Private Sub Cmb_Corres_Donde_Click()
    cmbCodigoComercio.SetFocus
End Sub

Private Sub Cmb_Corres_Donde_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbCodigoComercio.SetFocus
    End If
End Sub

Private Sub Cmb_Corresponsal_Click()
    Cmb_Corres_Aquien.SetFocus
End Sub

Private Sub Cmb_Corresponsal_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Cmb_Corres_Aquien.SetFocus
    End If
End Sub

Private Sub cmbCodigoComercio_Click()
    CmbOperadorSpot.SetFocus
End Sub

Private Sub cmbCodigoComercio_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        CmbOperadorSpot.SetFocus
    End If
End Sub

Private Sub cmbCV_Click()
    If cmbMoneda1.ListIndex <> -1 Then
        Call Proc_Carga_Corresponsal
        Call CargaCodOMA
        txtRutCliente.SetFocus
    End If
End Sub

Private Sub cmbCV_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Call Proc_Carga_Corresponsal
        Call CargaCodOMA
        txtRutCliente.SetFocus
    End If
End Sub

Private Sub cmbCV_LostFocus()
    Call Proc_Carga_Corresponsal
    Call CargaCodOMA
End Sub


Private Sub cmbFwdAreaResponsable_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbFwdBroker.SetFocus
    End If
End Sub

Private Sub cmbFwdBroker_Click()
    cmbFwdTipoRetiro.SetFocus
End Sub

Private Sub cmbFwdBroker_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbFwdTipoRetiro.SetFocus
    End If
End Sub

Private Sub cmbFwdCartera_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbFwdAreaResponsable.SetFocus
    End If
End Sub

Private Sub cmbFwdCartNorm_Click()
    Call PROC_LLENA_COMBOS_FWD(Me.cmbFwdSubCartNorm, 3, False, GLB_SUB_CARTERA_NORMATIVA, Trim(Right(Me.cmbFwdCartNorm.Text, 10)))
End Sub

Private Sub cmbFwdCartNorm_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbFwdSubCartNorm.SetFocus
    End If
End Sub

Private Sub cmbFwdLibro_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbFwdCartera.SetFocus
    End If
End Sub

Private Sub cmbFwdSubCartNorm_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbFwdLibro.SetFocus
    End If
End Sub

    Private Sub cmbMoneda1_Click()
    cmbMoneda2.SetFocus
End Sub

Private Sub cmbMoneda1_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbMoneda2.SetFocus
    End If
End Sub

Private Sub cmbMoneda2_Click()
If cmbMoneda1.Text <> "" And cmbMoneda2.Text <> "" Then
    If cmbMoneda1.Text = cmbMoneda2.Text Then
        MsgBox "No puede ingresar las mismas Monedas", vbCritical
        cmbMoneda2.ListIndex = -1
        cmbMoneda2.SetFocus
        Exit Sub
    End If
    cmbCV.SetFocus
End If
End Sub

Private Sub cmbMoneda2_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If cmbMoneda1.Text = cmbMoneda2.Text Then
            MsgBox "No puede ingresar las mismas Monedas", vbCritical
            cmbMoneda2.ListIndex = -1
            cmbMoneda2.SetFocus
            Exit Sub
        End If
        cmbCV.SetFocus
    End If
End Sub

Private Sub cmbMoneda2_LostFocus()
If cmbMoneda1.Text <> "" And cmbMoneda2.Text <> "" Then
    If cmbMoneda1.Text = cmbMoneda2.Text Then
        MsgBox "No puede ingresar las mismas Monedas", vbCritical
        cmbMoneda2.ListIndex = -1
        cmbMoneda2.SetFocus
        Exit Sub
    End If
End If
End Sub

Private Sub CmbOmaSpot_Click()
    FpEntCom.SetFocus
End Sub

Private Sub CmbOmaSpot_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        FpEntCom.SetFocus
    End If
End Sub

Private Sub CmbOperadorSpot_Click()
    cmbFwdCartNorm.SetFocus
End Sub

Private Sub CmbOperadorSpot_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbFwdCartNorm.SetFocus
    End If
End Sub

Private Sub cmbPlataforma_Click()
    cmbMoneda1.SetFocus
End Sub

Private Sub cmbPlataforma_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbMoneda1.SetFocus
    End If
End Sub

Private Sub cmbProducto_Click()
    Call CargaPlataformas
    cmbPlataforma.SetFocus
End Sub

Private Sub cmbProducto_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbPlataforma.SetFocus
    End If
End Sub

Private Sub cmdModalidad_Click()
    CmbOmaSpot.SetFocus
End Sub

Private Sub cmdModalidad_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        CmbOmaSpot.SetFocus
    End If
End Sub

Private Sub Form_Load()
    Me.Top = 0: Me.Left = 0
    Me.Icon = BACSwapParametros.Icon
    
    Set objCliente = New clsCliente

    GLB_CARTERA = "204"
    GLB_CARTERA_NORMATIVA = "1111"
    GLB_LIBRO = "1552"
    GLB_SUB_CARTERA_NORMATIVA = "1554"
    GLB_AREA_RESPONSABLE = "1553"
    GLB_ID_SISTEMA = "BFW"
    
    Call CargaProducto
    Call LlenaComboMoneda(cmbMoneda1)
    Call LlenaComboMoneda(cmbMoneda2)
    Call CargaCompraVenta
    Call CargaModalidad
    Call Carga_FormPago(FpEntCom)
    Call Carga_FormPago(FpRecCom)
    Call Carga_Comercio(cmbCodigoComercio)
    Call LlenaComboOperadores(CmbOperadorSpot)
    
    Call PROC_LLENA_COMBOS_FWD(Me.cmbFwdAreaResponsable, 1, False, GLB_AREA_RESPONSABLE, GLB_ID_SISTEMA)
    Call PROC_LLENA_COMBOS_FWD(Me.cmbFwdLibro, 5, False, GLB_ID_SISTEMA, 2, GLB_LIBRO)
    Call PROC_LLENA_COMBOS_FWD(Me.cmbFwdCartera, 2, False, Trim(CStr(2)), GLB_CARTERA, GLB_ID_SISTEMA)
    
    Call PROC_LLENA_COMBOS_FWD(Me.cmbFwdCartNorm, 6, False, GLB_ID_SISTEMA, 2, Trim(Right(Me.cmbFwdLibro.Text, 10)), GLB_CARTERA_NORMATIVA)
    
    Call LeerBroker(cmbFwdBroker)
    
    cmbFwdTipoRetiro.Clear
    Me.cmbFwdTipoRetiro.AddItem "VAMOS"
    cmbFwdTipoRetiro.ItemData(cmbFwdTipoRetiro.NewIndex) = 1
    Me.cmbFwdTipoRetiro.AddItem "NO APLICA"
    cmbFwdTipoRetiro.ItemData(cmbFwdTipoRetiro.NewIndex) = 2
    
End Sub

Public Function LeerBroker(p_cmbBroker As ComboBox) As Boolean
   
Dim sql           As String
Dim Datos()

    LeerBroker = False
   
    If Not Bac_Sql_Execute("bacfwdsuda.dbo.SP_LEERMFBROKER") Then
        Exit Function
    End If
   
    Do While Bac_SQL_Fetch(Datos())
        p_cmbBroker.AddItem Datos(3) & Space(200) & Datos(1) & "-" & Datos(2)
        p_cmbBroker.ItemData(p_cmbBroker.NewIndex) = Datos(1)
    Loop
    
    p_cmbBroker.AddItem "NO APLICA" & Space(200) & 99
    p_cmbBroker.ItemData(p_cmbBroker.NewIndex) = 99
   
    LeerBroker = True
End Function

Private Sub LlenaComboMoneda(ByRef MiCombo As ComboBox)
    sql = "sp_LeeMonedas_Pos"
    
    If Bac_Sql_Execute("sp_LeeMoneda_Pos") Then
        Do While Bac_SQL_Fetch(Datos())
            '--- se verá : nemo, glosa , pais y rrda
            MiCombo.AddItem BacPad(Datos(3), 5) & BacPad(Datos(2), 35) & Format(Val(Datos(12)), "000") & Space(2) & Datos(1)
            MiCombo.ItemData(MiCombo.NewIndex) = Datos(11)
        Loop
    End If
    
'    If MiCombo.Enabled Then
'        MiCombo.ListIndex = 0
'    End If
End Sub

Private Sub CargaCompraVenta()

    cmbCV.AddItem "COMPRA"
    cmbCV.ItemData(cmbCV.NewIndex) = "1"
    cmbCV.AddItem "VENTA"
    cmbCV.ItemData(cmbCV.NewIndex) = "2"
    
End Sub

Private Sub CargaProducto()

    cmbProducto.AddItem "SPOT"
    cmbProducto.ItemData(cmbProducto.NewIndex) = "1"
    cmbProducto.AddItem "FORWARD"
    cmbProducto.ItemData(cmbProducto.NewIndex) = "2"
    cmbProducto.AddItem "SWAP"
    cmbProducto.ItemData(cmbProducto.NewIndex) = "3"
    cmbProducto.AddItem "SPOT INTERBANCARIO"
    cmbProducto.ItemData(cmbProducto.NewIndex) = "4"
    cmbProducto.AddItem "SPOT EMPRESA"
    cmbProducto.ItemData(cmbProducto.NewIndex) = "5"
    cmbProducto.AddItem "SPOT ARBITRAJE"
    cmbProducto.ItemData(cmbProducto.NewIndex) = "6"
    
    
End Sub

Private Sub CargaModalidad()

    cmdModalidad.AddItem "COMPENSACION"
    cmdModalidad.ItemData(cmdModalidad.NewIndex) = "1"
    cmdModalidad.AddItem "ENTREGA FISICA"
    cmdModalidad.ItemData(cmdModalidad.NewIndex) = "2"
    cmdModalidad.AddItem "NO APLICA"
    cmdModalidad.ItemData(cmdModalidad.NewIndex) = "3"
    
End Sub

Private Sub CargaPlataformas()
Dim sSQL As String
Dim TipPlataforma As Integer

    cmbPlataforma.Clear
    If cmbProducto = "SPOT" Or cmbProducto = "FORWARD" Or cmbProducto = "SWAP" Then
        TipPlataforma = 1
    Else
        TipPlataforma = 2
    End If
    
    sSQL = "bacparamsuda.dbo.SP_BUSCA_PLATAFORMAS_VALOR_DEFECTO '" & TipPlataforma & "'"
    
    If Bac_Sql_Execute(sSQL) Then
        Do While Bac_SQL_Fetch(Datos())
            cmbPlataforma.AddItem Datos(2)
            cmbPlataforma.ItemData(cmbPlataforma.NewIndex) = Datos(1)
        Loop
    End If
End Sub

Private Sub CargaCodOMA()

    sql = "SP_CARGA_OMA_SUDA '" & Mid(Me.cmbCV.Text, 1, 1) & "'"
    If MISQL.SQL_Execute(sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos) = 0
            '-- Data = Glosa y Dias Valor
            sData = Format(Val(Datos(1)), "000") & " - " & BacPad(Datos(2), 50)
            iCodigo = Val(Datos(1))
            CmbOmaSpot.AddItem sData
            CmbOmaSpot.ItemData(CmbOmaSpot.NewIndex) = iCodigo
            CmbOmaSpot.Enabled = True
        Loop
    End If
    CmbOmaSpot.AddItem "NO APLICA"
    CmbOmaSpot.ItemData(CmbOmaSpot.NewIndex) = 99
    
End Sub

Sub Carga_FormPago(cmbFp As Object)
   Dim Datos()
   
   cmbFp.Enabled = False
   cmbFp.Clear
   
   sql = "SP_LEER_FORMAPAGO"
    If MISQL.SQL_Execute(sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos) = 0
            sData = BacPad(Datos(2), 50) & Datos(8)
            iCodigo = Val(Datos(1))
            cmbFp.AddItem Trim(Mid$(sData, 1, Len(sData) - 5))
            cmbFp.ItemData(cmbFp.NewIndex) = iCodigo
           
        Loop
    End If
    cmbFp.AddItem "NO APLICA"
    cmbFp.ItemData(cmbFp.NewIndex) = 999
    
    cmbFp.Enabled = True
End Sub

Sub Proc_Carga_Corresponsal()
Dim sql$, Datos()
Dim SQL_MX$, SQL_USD$

    MonMx = cmbMoneda1.ItemData(cmbMoneda1.ListIndex)

    Cmb_Corresponsal.Clear
    sql$ = "SP_LISTA_CORRESPONSALES"
    If MISQL.SQL_Execute(sql$) = 0 Then
        Do While MISQL.SQL_Fetch(Datos) = 0
            
            Cmb_Corresponsal.AddItem Datos(2) & Space(140) & Trim(Datos(1))
            
        Loop
    Else
        MsgBox "Problemas en conección para trae datos"
        Exit Sub
    End If
    Cmb_Corresponsal.AddItem "NO APLICA" & Space(140) & 9999
    
    SQL_MX$ = "baccamsuda.dbo.SP_ARBITRAJES_CARGA_CORRESPONSAL 97023000, " & MonMx
    SQL_USD$ = "baccamsuda.dbo.SP_ARBITRAJES_CARGA_CORRESPONSAL 97023000, 13"
     
    Me.Cmb_Corres_Aquien.Clear
    Me.Cmb_Corres_Desde.Clear
    Me.Cmb_Corres_Donde.Clear
     
    If Mid(cmbCV, 1, 1) = "C" Then
        
        If MISQL.SQL_Execute(SQL_USD$) = 0 Then
            Do While MISQL.SQL_Fetch(Datos) = 0
                Me.Cmb_Corres_Desde.AddItem Datos(6) & Space(140) & Trim(Datos(5))
                Me.Cmb_Corres_Desde.ItemData(Cmb_Corres_Desde.NewIndex) = Datos(5)
               
                Me.Cmb_Corres_Aquien.AddItem Datos(6) & Space(140) & Trim(Datos(5))
                Me.Cmb_Corres_Aquien.ItemData(Cmb_Corres_Aquien.NewIndex) = Datos(5)
            Loop
        End If
        Cmb_Corres_Desde.AddItem "NO APLICA" & Space(140) & 999
        Me.Cmb_Corres_Desde.ItemData(Cmb_Corres_Desde.NewIndex) = 999
        Cmb_Corres_Aquien.AddItem "NO APLICA" & Space(140) & 999
        Me.Cmb_Corres_Aquien.ItemData(Cmb_Corres_Aquien.NewIndex) = 999
        
        If MISQL.SQL_Execute(SQL_MX$) = 0 Then
            Do While MISQL.SQL_Fetch(Datos) = 0
                Me.Cmb_Corres_Donde.AddItem Datos(6) & Space(140) & Trim(Datos(5))
                Me.Cmb_Corres_Donde.ItemData(Cmb_Corres_Donde.NewIndex) = Datos(5)
            Loop
        End If
        Me.Cmb_Corres_Donde.AddItem "NO APLICA" & Space(140) & 999
        Me.Cmb_Corres_Donde.ItemData(Cmb_Corres_Donde.NewIndex) = 999
        
    
    ElseIf Mid(cmbCV, 1, 1) = "V" Then
     
        If MISQL.SQL_Execute(SQL_MX$) = 0 Then
            Do While MISQL.SQL_Fetch(Datos) = 0
                Me.Cmb_Corres_Desde.AddItem Datos(6) & Space(140) & Trim(Datos(5))
                Me.Cmb_Corres_Desde.ItemData(Cmb_Corres_Desde.NewIndex) = Datos(5)
               
                Me.Cmb_Corres_Aquien.AddItem Datos(6) & Space(140) & Trim(Datos(5))
                Me.Cmb_Corres_Aquien.ItemData(Cmb_Corres_Aquien.NewIndex) = Datos(5)
            Loop
        End If
        Me.Cmb_Corres_Desde.AddItem "NO APLICA" & Space(140) & 999
        Me.Cmb_Corres_Desde.ItemData(Cmb_Corres_Desde.NewIndex) = 999
               
        Me.Cmb_Corres_Aquien.AddItem "NO APLICA" & Space(140) & 999
        Me.Cmb_Corres_Aquien.ItemData(Cmb_Corres_Aquien.NewIndex) = 999
        
        If MISQL.SQL_Execute(SQL_USD$) = 0 Then
            Do While MISQL.SQL_Fetch(Datos) = 0
                Me.Cmb_Corres_Donde.AddItem Datos(6) & Space(140) & Trim(Datos(5))
                Me.Cmb_Corres_Donde.ItemData(Cmb_Corres_Donde.NewIndex) = Datos(5)
            Loop
        End If
    End If
    Me.Cmb_Corres_Donde.AddItem "NO APLICA" & Space(140) & 999
    Me.Cmb_Corres_Donde.ItemData(Cmb_Corres_Donde.NewIndex) = 999
     
End Sub

Sub Carga_Comercio(OBJCOMBO As Object)
    
    Dim Datos()
    
    OBJCOMBO.Enabled = False
    OBJCOMBO.Clear
    
    If Bac_Sql_Execute("baccamsuda.dbo.SP_LEER_CODIGOS_COMERCIO '', ''") Then
        Do While Bac_SQL_Fetch(Datos())
            OBJCOMBO.AddItem Datos(4)
            OBJCOMBO.ItemData(OBJCOMBO.NewIndex) = Datos(2)
        Loop
    End If
    OBJCOMBO.AddItem "NO APLICA"
    OBJCOMBO.ItemData(OBJCOMBO.NewIndex) = 99999
    
    OBJCOMBO.Enabled = True
    
End Sub

Public Sub LlenaComboOperadores(ByRef Combo As ComboBox)
'JBH, 22-12-2009
'Llena combo con Operadores
Dim nomSp As String
Dim xUsuario As String
Dim xNombre As String
Dim l1 As Integer
Dim l2 As Integer
Dim Linea As String
Dim dif As Integer
Dim Datos()
nomSp = "bacparamsuda.dbo.SP_CARGAOPERADORES"
Envia = Array()
If Not Bac_Sql_Execute(nomSp, Envia) Then
    Screen.MousePointer = 0
    Exit Sub
End If
Do While Bac_SQL_Fetch(Datos)
    xUsuario = Datos(1)
    xNombre = Datos(2)
    l1 = Len(xUsuario)
    l2 = Len(xNombre)
    dif = 110 - l2
    Linea = xNombre + Space(200) + "<|COD|>" + xUsuario
    Combo.AddItem (Linea)
Loop
Linea = "NO APLICA" + Space(200) + "<|COD|>" + "NO APLICA"
Combo.AddItem (Linea)

End Sub

Sub PROC_LLENA_COMBOS_FWD(Combo As Object, opcion As Integer, bTodos As Boolean, cParametro1 As String, Optional cParametro2 As String, Optional cParametro3 As String, Optional cParametro4 As String, Optional cParametro5 As String)
Dim Datos()

    Envia = Array()
    AddParam Envia, opcion
    AddParam Envia, IIf(Trim(cParametro1) <> "", Trim(cParametro1), "")
    AddParam Envia, IIf(Trim(cParametro2) <> "", Trim(cParametro2), "")
    AddParam Envia, IIf(Trim(cParametro3) <> "", Trim(cParametro3), "")
    AddParam Envia, IIf(Trim(cParametro4) <> "", Trim(cParametro4), "")
    AddParam Envia, IIf(Trim(cParametro5) <> "", Trim(cParametro5), "")
        
    If Not Bac_Sql_Execute("bacfwdsuda.dbo.SP_CON_INFO_COMBO", Envia) Then
        MsgBox "Problemas al Intentar llanar el combo", vbCritical + vbOKOnly
        Exit Sub
    End If
    
    Combo.Clear
    
    If bTodos = True Then
        Combo.AddItem "< TODOS (AS) >" & Space(110)
    End If
    
    Do While Bac_SQL_Fetch(Datos())
               
        Combo.AddItem Datos(6) & Space(110) & Datos(2)
                        
    Loop
    Combo.AddItem "NO APLICA" & Space(110) & 9999
    
    If Combo.ListCount > 0 Then
        Combo.ListIndex = 0
    End If
End Sub

Private Sub FpEntCom_Click()
    FpRecCom.SetFocus
End Sub

Private Sub FpEntCom_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        FpRecCom.SetFocus
    End If
End Sub

Private Sub FpRecCom_Click()
    Cmb_Corresponsal.SetFocus
End Sub

Private Sub FpRecCom_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Cmb_Corresponsal.SetFocus
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 2 'limpiar
        
            Call Limpia(True)
            
        Case 3 'Cargar
        
            If cmbProducto.Text <> "" And cmbPlataforma.Text <> "" And cmbMoneda1.Text <> "" And cmbMoneda2.Text <> "" And cmbCV.Text <> "" Then
                Call Cargar_Datos
            Else
                Call MsgBox("Debe Seleccionar los campos en Filtro", vbExclamation)
            End If
            
        Case 4 'Grabar
        
            If Validacion Then
                If MsgBox("¿Esta seguro que desea grabar los datos?", vbQuestion + vbOKCancel, "Grabación Valores por Defecto Spot") = vbOK Then
                    Call Grabar
                    Call Limpia(True)
                End If
            Else
                MsgBox "Error. No todos los campos tienen valor", vbExclamation
            End If
                
            
        Case 5 'Salir
        
        Unload Me
            
    End Select
End Sub

Private Sub Limpia(tambienFiltro As Boolean)
 
    Me.cmbProducto.ListIndex = -1
    Me.cmbPlataforma.ListIndex = -1
    Me.cmbMoneda1.ListIndex = -1
    Me.cmbMoneda2.ListIndex = -1
    Me.cmbCV.ListIndex = -1
    txtRutCliente = ""
    txtDig_Cliente = ""
    txtCodRut = ""
    Me.cmdModalidad.ListIndex = -1
    Me.CmbOmaSpot.ListIndex = -1
    Me.FpEntCom.ListIndex = -1
    Me.FpRecCom.ListIndex = -1
    Me.Cmb_Corresponsal.ListIndex = -1
    Me.Cmb_Corres_Aquien.ListIndex = -1
    Me.Cmb_Corres_Desde.ListIndex = -1
    Me.Cmb_Corres_Donde.ListIndex = -1
    Me.cmbCodigoComercio.ListIndex = -1
    Me.CmbOperadorSpot.ListIndex = -1
    Me.cmbFwdCartNorm.ListIndex = 0
    Me.cmbFwdSubCartNorm.ListIndex = 0
    Me.cmbFwdLibro.ListIndex = 0
    Me.cmbFwdCartera.ListIndex = 0
    Me.cmbFwdAreaResponsable.ListIndex = 0
    Me.cmbFwdBroker.ListIndex = -1
    Me.cmbFwdTipoRetiro.ListIndex = -1
    Me.cmbProducto.SetFocus
   
 End Sub

Private Function Grabar() As String
Dim Producto As Integer
Dim Plataforma As Integer
Dim Moneda1 As Integer
Dim Moneda2 As Integer
Dim CompraVenta As Integer
Dim RutCliente As Long
Dim Modalidad As String
Dim CodOma As String
Dim FP_Entrega As Integer
Dim FP_Recibo As Integer
Dim Corresponsal As Integer
Dim Corres_A_Quien As Integer
Dim Corres_Donde As Integer
Dim Corres_Desde As Integer
Dim Cod_Comercio As String
Dim Operador As String
Dim Cartera_Norm As String
Dim Sub_Cartera_Norm As String
Dim Libro As String
Dim cartera As Integer
Dim Area As String
Dim Broker As Integer
Dim Tipo_Retiro As Integer

    If FpEntCom = "" Or FpRecCom = "" Or CmbOmaSpot = "" Then
        MsgBox "Faltan Datos", vbExclamation, TITSISTEMA
        Exit Function
    ElseIf cmbProducto = "" Then
        MsgBox "Falta Tipo de Producto", vbExclamation, TITSISTEMA
        Exit Function
    ElseIf Cmb_Corresponsal.Text = "" Then
        MsgBox "Falta Seleccionar el Corresponsal", vbExclamation, TITSISTEMA
        Exit Function
    End If
     
    Producto = cmbProducto.ItemData(cmbProducto.ListIndex)
    Plataforma = cmbPlataforma.ItemData(cmbPlataforma.ListIndex)
    Moneda1 = cmbMoneda1.ItemData(cmbMoneda1.ListIndex)
    Moneda2 = cmbMoneda2.ItemData(cmbMoneda2.ListIndex)
    CompraVenta = cmbCV.ItemData(cmbCV.ListIndex)
    If txtRutCliente = "" Then
        RutCliente = 0
    Else
        RutCliente = txtRutCliente
    End If
    
    If cmdModalidad.ItemData(cmdModalidad.ListIndex) = "1" Then
        Modalidad = "C"
    ElseIf cmdModalidad.ItemData(cmdModalidad.ListIndex) = "2" Then
        Modalidad = "F"
    End If
    
    CodOma = CmbOmaSpot.ItemData(CmbOmaSpot.ListIndex)
    FP_Entrega = FpEntCom.ItemData(FpEntCom.ListIndex)
    FP_Recibo = FpRecCom.ItemData(FpRecCom.ListIndex)
    Corresponsal = Cmb_Corresponsal.ItemData(Cmb_Corresponsal.ListIndex)
    Corres_A_Quien = Cmb_Corres_Aquien.ItemData(Cmb_Corres_Aquien.ListIndex)
    Corres_Donde = Cmb_Corres_Donde.ItemData(Cmb_Corres_Donde.ListIndex)
    Corres_Desde = Cmb_Corres_Desde.ItemData(Cmb_Corres_Desde.ListIndex)
    Cod_Comercio = cmbCodigoComercio.ItemData(cmbCodigoComercio.ListIndex)
    Operador = Mid(CmbOperadorSpot.Text, Trim(InStr(CmbOperadorSpot.Text, ">")) + 1, Len(CmbOperadorSpot.Text))
    
    Cartera_Norm = cmbFwdCartNorm.ItemData(cmbFwdCartNorm.ListIndex)
    Sub_Cartera_Norm = cmbFwdSubCartNorm.ItemData(cmbFwdSubCartNorm.ListIndex)
    Libro = cmbFwdLibro.ItemData(cmbFwdLibro.ListIndex)
    cartera = cmbFwdCartera.ItemData(cmbFwdCartera.ListIndex)
    Area = cmbFwdAreaResponsable.ItemData(cmbFwdAreaResponsable.ListIndex)
    If cmbFwdBroker.Text <> "" Then
        Broker = cmbFwdBroker.ItemData(cmbFwdBroker.ListIndex)
    End If
    Tipo_Retiro = cmbFwdTipoRetiro.ItemData(cmbFwdTipoRetiro.ListIndex)
    
    Envia = Array()
    AddParam Envia, Producto
    AddParam Envia, CompraVenta
    AddParam Envia, Moneda1
    AddParam Envia, Moneda2
    AddParam Envia, Plataforma
    AddParam Envia, RutCliente
    AddParam Envia, Modalidad
    AddParam Envia, FP_Entrega
    AddParam Envia, FP_Recibo
    AddParam Envia, Corresponsal
    AddParam Envia, Corres_Desde
    AddParam Envia, Corres_Donde
    AddParam Envia, Corres_A_Quien
    AddParam Envia, Cod_Comercio
    AddParam Envia, CodOma
    AddParam Envia, Operador
    AddParam Envia, Area
    AddParam Envia, Cartera_Norm
    AddParam Envia, Sub_Cartera_Norm
    AddParam Envia, Libro
    AddParam Envia, cartera
    AddParam Envia, Broker
    AddParam Envia, Tipo_Retiro
    
    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GRABAR_VALOR_DEFECTO", Envia) Then
         MsgBox "No es posible grabar los valores por defecto"
    Else
         If Bac_SQL_Fetch(Datos()) Then
            If Datos(1) = 0 Then
                MsgBox Datos(2), vbInformation, "GRABACION VALORES POR DEFECTO"
            Else
                MsgBox Datos(2), vbCritical, "GRABACION VALORES POR DEFECTO"
            End If
        End If
    End If
     
 End Function

Private Sub txtCodRut_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        objCliente.clrut = txtRutCliente.Text
        objCliente.cldv = txtDig_Cliente.Text
        objCliente.clcodigo = Val(txtCodRut.Text)
        
        If Not objCliente.LeerPorRut(objCliente.clrut, objCliente.clcodigo) Then
            IdCod = 0
            If objCliente.clcodigo = 0 Then
                If objCliente.LeerPorRut(Val(IdRut), 1) Then
                    IdCod = 1
                End If
            End If
            If IdCod = 0 Then
                MsgBox "Error : Cliente no se encuentra", 16, "Bac-Parametros"
                txtRutCliente = ""
                txtDig_Cliente = ""
                txtRutCliente.SetFocus
                Exit Sub
            End If
        End If
        cmdModalidad.SetFocus
    End If
End Sub

Private Sub txtDig_Cliente_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If BacValidaRut(CStr(txtRutCliente.Text), CStr(txtDig_Cliente.Text)) = False Then
            MsgBox "El rut ingresado no es válido", vbExclamation, TITSISTEMA
            txtDig_Cliente.Text = ""
            txtDig_Cliente.SetFocus
            Exit Sub
        End If
        
        txtCodRut.SetFocus
    End If
End Sub

Private Sub txtRutCliente_DblClick()
Dim xx
On Error GoTo Error
    
    BacControlWindows 100
    'BacAyuda.Tag = "MDCL" original
    'BacAyuda.Show 1
    BacAyudaCliente.Tag = "MDCL"
    BacAyudaCliente.Show 1
       
    If giAceptar = True Then
        
        txtRutCliente.Text = Val(gsrut$)
        txtDig_Cliente.Text = gsDigito$
        txtCodRut.Text = gsCodCli
        
        txtDig_Cliente.SetFocus
        SendKeys "{ENTER}"
    End If

Error:
  If Err.Number <> 0 Then MsgBox Err.Description
  
End Sub

Private Sub txtRutCliente_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF3 Then Call txtRutCliente_DblClick
End Sub

Private Sub txtRutCliente_KeyPress(KeyAscii As Integer)
   
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
     
   End If
     
   BacCaracterNumerico KeyAscii
End Sub

Private Function Validacion() As Boolean
   
    Validacion = True
    If Me.cmbProducto.ListIndex = -1 _
        Or Me.cmbPlataforma.ListIndex = -1 _
        Or Me.cmbMoneda1.ListIndex = -1 _
        Or Me.cmbMoneda2.ListIndex = -1 _
        Or Me.cmbCV.ListIndex = -1 _
        Or Me.cmdModalidad.ListIndex = -1 _
        Or Me.CmbOmaSpot.ListIndex = -1 _
        Or Me.FpEntCom.ListIndex = -1 _
        Or Me.FpRecCom.ListIndex = -1 _
        Or Me.Cmb_Corresponsal.ListIndex = -1 _
        Or Me.Cmb_Corres_Aquien.ListIndex = -1 _
        Or Me.Cmb_Corres_Desde.ListIndex = -1 _
        Or Me.Cmb_Corres_Donde.ListIndex = -1 _
        Or Me.cmbCodigoComercio.ListIndex = -1 _
        Or Me.CmbOperadorSpot.ListIndex = -1 _
        Or Me.cmbFwdCartNorm.ListIndex = -1 _
        Or Me.cmbFwdSubCartNorm.ListIndex = -1 _
        Or Me.cmbFwdLibro.ListIndex = -1 _
        Or Me.cmbFwdCartera.ListIndex = -1 _
        Or Me.cmbFwdAreaResponsable.ListIndex = -1 _
        Or Me.cmbFwdTipoRetiro.ListIndex = -1 Then
           Validacion = False
    End If
    
End Function

Public Function BacDevuelveDig(Rut As String) As String

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim Multi   As Double

   BacDevuelveDig = ""

   Rut = Format(Rut, "000000000")
   D = 2
   Suma = 0
   For i = 9 To 1 Step -1
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

Private Sub Cargar_Datos()
Dim Datos()
     
    Envia = Array()
    AddParam Envia, Me.cmbProducto.ItemData(cmbProducto.ListIndex)
    AddParam Envia, IIf(Me.cmbCV = "COMPRA", "1", "2")
    AddParam Envia, Me.cmbMoneda1.ItemData(cmbMoneda1.ListIndex)
    AddParam Envia, Me.cmbMoneda2.ItemData(cmbMoneda2.ListIndex)
    AddParam Envia, Me.cmbPlataforma.ItemData(cmbPlataforma.ListIndex)
    If txtRutCliente <> "" Then
        AddParam Envia, txtRutCliente
    Else
        AddParam Envia, 0
    End If

    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_TRAE_VALOR_DEFECTO_CARGA", Envia) Then
        MsgBox "No es posible traer los valores por defecto"
    Else
        If Bac_SQL_Fetch(Datos()) Then
            
            If Trim(Datos(1)) = "C" Then
                Call BuscaEnCombo(Me.cmdModalidad, 1)
            Else
                Call BuscaEnCombo(Me.cmdModalidad, 2)
            End If
            Call BuscaEnCombo(Me.FpEntCom, IIf(Trim(Datos(2)) = "", 0, Trim(Datos(2))))
            Call BuscaEnCombo(Me.FpRecCom, IIf(Trim(Datos(3)) = "", 0, Trim(Datos(3))))
            Call BuscaEnCombo(Me.Cmb_Corresponsal, IIf(Trim(Datos(4)) = "", 0, Trim(Datos(4))))
            Call BuscaEnCombo(Me.Cmb_Corres_Desde, IIf(Trim(Datos(5)) = "", 0, Trim(Datos(5))))
            Call BuscaEnCombo(Me.Cmb_Corres_Donde, IIf(Trim(Datos(6)) = "", 0, Trim(Datos(6))))
            Call BuscaEnCombo(Me.Cmb_Corres_Aquien, IIf(Trim(Datos(7)) = "", 0, Trim(Datos(7))))
            Call BuscaEnCombo(Me.cmbCodigoComercio, IIf(Trim(Datos(11)) = "", 0, Trim(Datos(11))))
            Call BuscaEnCombo(Me.CmbOmaSpot, IIf(Trim(Datos(12)) = "", 0, Trim(Datos(12))))
            CmbOperadorSpot.ListIndex = FUNC_POSICION_COMBO(CmbOperadorSpot, Trim(Datos(14)))
            Call BuscaEnCombo(Me.cmbFwdAreaResponsable, IIf(Trim(Datos(15)) = "", 0, Trim(Datos(15))))
            Call BuscaEnCombo(Me.cmbFwdCartNorm, IIf(Trim(Datos(16)) = "", 0, Trim(Datos(16))))
            Call BuscaEnCombo(Me.cmbFwdSubCartNorm, IIf(Trim(Datos(17)) = "", 0, Trim(Datos(17))))
            Call BuscaEnCombo(Me.cmbFwdLibro, IIf(Trim(Datos(18)) = "", 0, Trim(Datos(18))))
            Call BuscaEnCombo(Me.cmbFwdCartera, IIf(Trim(Datos(19)) = "", 0, Trim(Datos(19))))
            Call BuscaEnCombo(Me.cmbFwdBroker, IIf(Trim(Datos(20)) = "", 0, Trim(Datos(20))))
            Call BuscaEnCombo(Me.cmbFwdTipoRetiro, IIf(Trim(Datos(21)) = "", 0, Trim(Datos(21))))
               
        Else
            MsgBox "No se encontraron datos para los valores seleccionados", vbInformation
        End If
    End If
End Sub

Function BuscaEnCombo(cControl As Object, nValor As Long) As Integer
Dim iLin As Long
    
    BuscaEnCombo = -1
    For iLin = 0 To cControl.ListCount - 1
        
        If cControl.ItemData(iLin) = nValor Then
            BuscaEnCombo = iLin
            Exit For
        End If
        If BuscaEnCombo = iLin And iLin > -1 Then
            cControl.ListIndex = iLin
            Exit For
        End If
    Next iLin
    
    cControl.ListIndex = BuscaEnCombo
    
End Function

Function BuscarCombo_MO(cControl As Object, nValor As Variant) As Integer
Dim iLin    As Integer

    BuscarCombo_OP = -1
    
    If nValor = "C" Then
        nValor = 1
    Else
        nValor = 2
    End If

    For iLin = 0 To cControl.ListCount - 1
        If Trim(Right(cControl.List(iLin), Len(nValor))) = Trim(nValor) Then
            BuscarCombo_OP = iLin
            cControl.ListIndex = iLin
            Exit For
        End If
    Next iLin

End Function

Function FUNC_POSICION_COMBO(Cmb_Control As Control, texto As String) As Integer
Dim i%, I_Posicion%

FUNC_POSICION_COMBO = -1

For i% = 0 To Cmb_Control.ListCount - 1
    
    'Cmb_Control.ListIndex = I%
    
    I_Posicion = InStr(Cmb_Control.List(i), "<|COD|>")
    
    If Trim(Mid(Cmb_Control.List(i), I_Posicion + 7)) = Trim(texto) Then
       FUNC_POSICION_COMBO = i%
       Exit For
    End If
    
Next i%

End Function
