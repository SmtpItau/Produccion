VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form BacMntCargOpExt 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Valores por  defecto operaciones Externas"
   ClientHeight    =   5985
   ClientLeft      =   930
   ClientTop       =   1725
   ClientWidth     =   6675
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5985
   ScaleWidth      =   6675
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   9
      Top             =   0
      Width           =   6675
      _ExtentX        =   11774
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
               Picture         =   "BacMntCargOpExt.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntCargOpExt.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntCargOpExt.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntCargOpExt.frx":2C8E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin TabDlg.SSTab tabSpotFwd 
      Height          =   5295
      Left            =   105
      TabIndex        =   0
      Top             =   570
      Width           =   6495
      _ExtentX        =   11456
      _ExtentY        =   9340
      _Version        =   393216
      Tabs            =   2
      Tab             =   1
      TabsPerRow      =   2
      TabHeight       =   520
      TabCaption(0)   =   "Operaciones Spot"
      TabPicture(0)   =   "BacMntCargOpExt.frx":2FA8
      Tab(0).ControlEnabled=   0   'False
      Tab(0).Control(0)=   "frmFiltro"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "frmCompras"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).ControlCount=   2
      TabCaption(1)   =   "Operaciones Forward"
      TabPicture(1)   =   "BacMntCargOpExt.frx":2FC4
      Tab(1).ControlEnabled=   -1  'True
      Tab(1).Control(0)=   "frmFiltroFwd"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).Control(1)=   "frmValoresFwd"
      Tab(1).Control(1).Enabled=   0   'False
      Tab(1).ControlCount=   2
      Begin VB.Frame frmValoresFwd 
         Height          =   3972
         Left            =   120
         TabIndex        =   29
         Top             =   1200
         Width           =   6252
         Begin VB.ComboBox CmbOperadorFwd 
            Height          =   288
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   50
            Top             =   3480
            Width           =   3375
         End
         Begin VB.ComboBox cmbFwdTipoRetiro 
            Height          =   288
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   47
            Top             =   3120
            Width           =   3375
         End
         Begin VB.ComboBox cmbFwdBroker 
            Height          =   288
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   46
            Top             =   2760
            Width           =   3375
         End
         Begin VB.ComboBox cmbFwdAreaResponsable 
            Height          =   288
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   45
            Top             =   2400
            Width           =   3375
         End
         Begin VB.ComboBox cmbFwdFPRecibe 
            Height          =   288
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   41
            Top             =   2040
            Width           =   3375
         End
         Begin VB.ComboBox cmbFwdFPEntrega 
            Height          =   288
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   40
            Top             =   1680
            Width           =   3375
         End
         Begin VB.ComboBox cmbFwdCartera 
            Height          =   288
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   39
            Top             =   1320
            Width           =   3375
         End
         Begin VB.ComboBox cmbFwdLibro 
            Height          =   288
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   38
            Top             =   960
            Width           =   3375
         End
         Begin VB.ComboBox cmbFwdSubCartNorm 
            Height          =   288
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   37
            Top             =   600
            Width           =   3375
         End
         Begin VB.ComboBox cmbFwdCartNorm 
            Height          =   288
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   36
            Top             =   240
            Width           =   3375
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
            Height          =   252
            Index           =   1
            Left            =   120
            TabIndex        =   51
            Top             =   3480
            Width           =   2256
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
            Height          =   252
            Left            =   120
            TabIndex        =   44
            Top             =   3120
            Width           =   1812
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
            Height          =   252
            Left            =   120
            TabIndex        =   43
            Top             =   2760
            Width           =   1812
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
            Height          =   252
            Left            =   120
            TabIndex        =   42
            Top             =   2400
            Width           =   1812
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
            Height          =   252
            Left            =   120
            TabIndex        =   35
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
            Height          =   252
            Left            =   120
            TabIndex        =   34
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
            Height          =   252
            Left            =   120
            TabIndex        =   33
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
            Height          =   252
            Left            =   120
            TabIndex        =   32
            Top             =   240
            Width           =   1812
         End
         Begin VB.Label txtFwdFPRec 
            Caption         =   "F.P. Recibe"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   252
            Left            =   120
            TabIndex        =   31
            Top             =   2040
            Width           =   1812
         End
         Begin VB.Label txtFwdFPEnt 
            Caption         =   "F.P. Entrega"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   252
            Left            =   120
            TabIndex        =   30
            Top             =   1680
            Width           =   1812
         End
      End
      Begin VB.Frame frmFiltroFwd 
         Height          =   852
         Left            =   120
         TabIndex        =   22
         Top             =   360
         Width           =   6252
         Begin VB.ComboBox cmbFwdOrigen 
            Height          =   315
            Left            =   4110
            Style           =   2  'Dropdown List
            TabIndex        =   28
            Top             =   480
            Width           =   2025
         End
         Begin VB.ComboBox cmbFwdMoneda 
            Height          =   315
            Left            =   1530
            Style           =   2  'Dropdown List
            TabIndex        =   27
            Top             =   480
            Width           =   2550
         End
         Begin VB.ComboBox cmbFwdTipoCV 
            Height          =   315
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   26
            Top             =   480
            Width           =   1395
         End
         Begin VB.Label txtOrigenFwd 
            Caption         =   "Origen"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   4110
            TabIndex        =   25
            Top             =   240
            Width           =   765
         End
         Begin VB.Label txtMdaFwd 
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
            Height          =   255
            Left            =   1665
            TabIndex        =   24
            Top             =   240
            Width           =   1620
         End
         Begin VB.Label txtCVFwd 
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
            Height          =   252
            Left            =   120
            TabIndex        =   23
            Top             =   240
            Width           =   2052
         End
      End
      Begin VB.Frame frmFiltro 
         Height          =   852
         Left            =   -74880
         TabIndex        =   11
         Top             =   360
         Width           =   6255
         Begin VB.ComboBox cmbOrigen 
            Height          =   315
            Left            =   4110
            Style           =   2  'Dropdown List
            TabIndex        =   14
            Top             =   480
            Width           =   2025
         End
         Begin VB.ComboBox cmbMoneda 
            Height          =   315
            Left            =   1530
            Style           =   2  'Dropdown List
            TabIndex        =   13
            Top             =   480
            Width           =   2550
         End
         Begin VB.ComboBox cmbCV 
            Height          =   315
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   12
            Top             =   480
            Width           =   1395
         End
         Begin VB.Label lbOrigen 
            Caption         =   "Origen"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   4110
            TabIndex        =   17
            Top             =   240
            Width           =   1485
         End
         Begin VB.Label lbMoneda 
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
            Height          =   255
            Left            =   1665
            TabIndex        =   16
            Top             =   240
            Width           =   1140
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
            Height          =   252
            Left            =   120
            TabIndex        =   15
            Top             =   240
            Width           =   1692
         End
      End
      Begin VB.Frame frmCompras 
         Height          =   3972
         Left            =   -74880
         TabIndex        =   1
         Top             =   1200
         Width           =   6252
         Begin VB.ComboBox Cmb_Corres_Aquien 
            Height          =   315
            Left            =   2775
            Style           =   2  'Dropdown List
            TabIndex        =   52
            Top             =   1590
            Width           =   3375
         End
         Begin VB.ComboBox CmbOperadorSpot 
            Height          =   315
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   48
            Top             =   2820
            Width           =   3375
         End
         Begin VB.ComboBox cmbCodigoComercio 
            Height          =   315
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   21
            Top             =   3570
            Visible         =   0   'False
            Width           =   3375
         End
         Begin VB.ComboBox Cmb_Corres_Donde 
            Height          =   315
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   18
            Top             =   2415
            Width           =   3375
         End
         Begin VB.ComboBox CmbOma 
            Height          =   288
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   10
            Top             =   360
            Width           =   3375
         End
         Begin VB.ComboBox Cmb_Corres_Desde 
            Height          =   315
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   8
            Top             =   1995
            Width           =   3375
         End
         Begin VB.ComboBox FpRec 
            Height          =   315
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   7
            Top             =   1185
            Width           =   3375
         End
         Begin VB.ComboBox FpEnt 
            Height          =   315
            Left            =   2760
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   780
            Width           =   3375
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
            Height          =   255
            Left            =   135
            TabIndex        =   53
            Top             =   1590
            Width           =   2250
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
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   49
            Top             =   2820
            Width           =   2250
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
            Height          =   255
            Left            =   120
            TabIndex        =   20
            Top             =   3570
            Visible         =   0   'False
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
            Height          =   255
            Left            =   120
            TabIndex        =   19
            Top             =   2415
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
            Height          =   255
            Left            =   120
            TabIndex        =   5
            Top             =   1995
            Width           =   2250
         End
         Begin VB.Label txtFPRecibeC 
            Caption         =   "F.P. Recibe"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   120
            TabIndex        =   4
            Top             =   1185
            Width           =   2250
         End
         Begin VB.Label txtFPEntregaC 
            Caption         =   "F.P. Entrega"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   120
            TabIndex        =   3
            Top             =   780
            Width           =   2250
         End
         Begin VB.Label txtCodOmaC 
            Caption         =   "Codigo OMA"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   252
            Left            =   120
            TabIndex        =   2
            Top             =   360
            Width           =   2256
         End
      End
   End
End
Attribute VB_Name = "BacMntCargOpExt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Dim sData As String
Dim iCodigo As Integer

Dim GLB_CARTERA As String
Dim GLB_CARTERA_NORMATIVA As String
Dim GLB_LIBRO As String
Dim GLB_AREA_RESPONSABLE As String
Dim GLB_SUB_CARTERA_NORMATIVA As String
Dim GLB_ID_SISTEMA As String





Private Sub cmbFwdMoneda_Click()
    Call Limpia(False)
End Sub

Private Sub cmbFwdOrigen_Click()
    Call Limpia(False)
    
    If cmbFwdOrigen.ListIndex < 0 Then
        Exit Sub
    End If

    Call CargaMoneda(cmbFwdMoneda, cmbFwdOrigen.List(cmbFwdOrigen.ListIndex))

End Sub


Private Sub cmbFwdTipoCV_Click()
    Call Limpia(False)
End Sub

Private Sub cmbCV_Click()
    Call Limpia(False)
   
    If cmbMoneda.ListIndex < 0 Then
        Exit Sub
    End If
   
    Call Carga_Corresponsal(Me.cmbCV.Text, Me.cmbMoneda.ItemData(Me.cmbMoneda.ListIndex))
    
End Sub

Private Sub cmbMoneda_Click()
   Call Limpia(False)
    If Me.cmbMoneda.ListIndex >= 0 Then
   Call Carga_Corresponsal(Me.cmbCV.Text, Me.cmbMoneda.ItemData(Me.cmbMoneda.ListIndex))
    End If
End Sub


Private Sub cmbOrigen_Click()
    Call Limpia(False)

    If cmbOrigen.ListIndex < 0 Then
        Exit Sub
    End If

    Call CargaMoneda(cmbMoneda, cmbOrigen.List(cmbOrigen.ListIndex))
    
End Sub

Private Sub cmbFwdCartNorm_Change()
    Call PROC_LLENA_COMBOS_FWD(Me.cmbFwdSubCartNorm, 3, False, GLB_SUB_CARTERA_NORMATIVA, Trim(Right(Me.cmbFwdCartNorm.Text, 10)))
End Sub

Private Sub cmbFwdLibro_Change()
    Call PROC_LLENA_COMBOS_FWD(Me.cmbFwdCartNorm, 6, False, GLB_ID_SISTEMA, 2, Trim(Right(Me.cmbFwdLibro.Text, 10)), GLB_CARTERA_NORMATIVA)
End Sub


Private Sub Form_Load()
    Me.Top = 0: Me.Left = 0
    Me.Icon = BACSwapParametros.Icon
    
    
    GLB_CARTERA = "204"
    GLB_CARTERA_NORMATIVA = "1111"
    GLB_LIBRO = "1552"
    GLB_SUB_CARTERA_NORMATIVA = "1554"
    GLB_AREA_RESPONSABLE = "1553"
    GLB_ID_SISTEMA = "BFW"
    
    Call PROC_CARGA_FILTROS
    
    Call Carga_Spot
    Call Carga_Forward
    
    Call LlenaComboOperadores(CmbOperadorSpot)
    Call LlenaComboOperadores(CmbOperadorFwd)
    Call Limpia(False)

    tabSpotFwd.Tab = 1
    Call Limpia(False)
    tabSpotFwd.Tab = 0
    
End Sub



Function BuscarCombo(cControl As Object, nValor As Variant) As Integer
Dim iLin    As Integer

    BuscarCombo = -1

    For iLin = 0 To cControl.ListCount - 1
        
        If Val(Trim(Right(cControl.List(iLin), Len(nValor)))) = nValor Then
           BuscarCombo = iLin
           Exit For
        End If
          
    Next iLin
If iLin >= 0 Then
    cControl.ListIndex = iLin
End If
End Function



Sub Carga_Forward()
    
    Call Carga_FormPago(Me.cmbFwdFPRecibe)
    Call Carga_FormPago(Me.cmbFwdFPEntrega)
    
    Envia = Array()
    AddParam Envia, "1"
    AddParam Envia, GLB_AREA_RESPONSABLE
    AddParam Envia, GLB_ID_SISTEMA
    
    'Call PROC_LLENA_COMBOS("sp_con_info_combo", Envia, cmbFwdAreaResponsable, False, 2, 6)
    
    Call PROC_LLENA_COMBOS_FWD(Me.cmbFwdAreaResponsable, 1, False, GLB_AREA_RESPONSABLE, GLB_ID_SISTEMA)
    Call PROC_LLENA_COMBOS_FWD(Me.cmbFwdLibro, 5, False, GLB_ID_SISTEMA, 2, GLB_LIBRO)
    Call PROC_LLENA_COMBOS_FWD(Me.cmbFwdCartera, 2, False, Trim(CStr(2)), GLB_CARTERA, GLB_ID_SISTEMA)
    
    Call PROC_LLENA_COMBOS_FWD(Me.cmbFwdCartNorm, 6, False, GLB_ID_SISTEMA, 2, Trim(Right(Me.cmbFwdLibro.Text, 10)), GLB_CARTERA_NORMATIVA)
    Call PROC_LLENA_COMBOS_FWD(Me.cmbFwdSubCartNorm, 3, False, GLB_SUB_CARTERA_NORMATIVA, Trim(Right(Me.cmbFwdCartNorm.Text, 10)))
    
    Call LeerBroker(Me.cmbFwdBroker)
    
    cmbFwdTipoRetiro.Clear
    Me.cmbFwdTipoRetiro.AddItem "VAMOS"
    cmbFwdTipoRetiro.ItemData(cmbFwdTipoRetiro.NewIndex) = 1
 
End Sub

Public Function LeerBroker(p_cmbBroker As Object) As Boolean
   
   Dim sql           As String
   Dim Datos()

   LeerBroker = False
   
   If Not Bac_Sql_Execute("bacfwdsuda.dbo.SP_LEERMFBROKER") Then
      Exit Function
   End If
   
   Do While Bac_SQL_Fetch(Datos())
      p_cmbBroker.AddItem = Datos(3) & Space(50) & Datos(1) & "-" & Datos(2)
      p_cmbBroker.ItemData(p_cmbBroker.cmbFwdOrigen.NewIndex) = Datos(1)
   Loop
   LeerBroker = True
End Function



Sub Carga_Spot()
          
    CmbOma.Clear
    FpRec.Clear
    FpEnt.Clear
        
    CmbOma.Enabled = False
    FpRec.Enabled = False
    FpEnt.Enabled = False

    'Call Proc_Carga_Corresponsal
    
    If cmbMoneda.ListIndex < 0 Then
        If cmbMoneda.ListCount > 0 Then
            cmbMoneda.ListIndex = 0
        End If
        Exit Sub
    End If
    
    Call Carga_Corresponsal(Me.cmbCV.Text, cmbMoneda.ItemData(Me.cmbMoneda.ListIndex))
    Call Carga_Comercio(Me.cmbCodigoComercio)
    Call Carga_FormPago(Me.FpEnt)
    Call Carga_FormPago(Me.FpRec)
    
    '-- Codigos OMA
    sql = "SP_CARGA_OMA_SUDA '" & Mid(Me.cmbCV.Text, 1, 1) & "'"
    If MISQL.SQL_Execute(sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos) = 0
            '-- Data = Glosa y Dias Valor
            sData = Format(Val(Datos(1)), "000") & " - " & BacPad(Datos(2), 50)
            iCodigo = Val(Datos(1))
            CmbOma.AddItem sData
            CmbOma.ItemData(CmbOma.NewIndex) = iCodigo
            CmbOma.Enabled = True
        Loop
    End If

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
    
    cmbFp.Enabled = True
End Sub

'Sub Proc_Carga_Corresponsal()
'Dim SQL$, DATOS()
'
'Me.Cmb_Corres_Desde.Clear
'Me.Cmb_Corres_Donde.Clear
'
'    SQL$ = "Sp_Lista_Corresponsales"
'    If MISQL.SQL_Execute(SQL$) = 0 Then
'
'        Do While MISQL.SQL_Fetch(DATOS) = 0
'
'           Me.Cmb_Corres_Desde.AddItem DATOS(2) & Space(140) & Trim(DATOS(1))
'           Cmb_Corres_Desde.ItemData(Cmb_Corres_Desde.NewIndex) = DATOS(1)
'           'Cmb_Corres_Desde.ItemData(Cmb_Corres_Desde.ListIndex + 1) = Datos(1)
'
'            Me.Cmb_Corres_Donde.AddItem DATOS(2) & Space(140) & Trim(DATOS(1))
'            Cmb_Corres_Donde.ItemData(Cmb_Corres_Donde.NewIndex) = DATOS(1)
'            'Cmb_Corres_Donde.ItemData(Cmb_Corres_Desde.ListIndex + 1) = Datos(1)
'        Loop
'
'    Else
'        MsgBox "Problemas en conección para trae datos"
'        Exit Sub
'    End If
'End Sub


Sub Carga_Corresponsal(TipoCv As String, MonMx As Long)
     Dim SQL_MX$, SQL_USD$, Datos()
     SQL_MX$ = "baccamsuda.dbo.SP_ARBITRAJES_CARGA_CORRESPONSAL 97023000, " & MonMx
     SQL_USD$ = "baccamsuda.dbo.SP_ARBITRAJES_CARGA_CORRESPONSAL 97023000, 13"
     
     Me.Cmb_Corres_Aquien.Clear
     Me.Cmb_Corres_Desde.Clear
     Me.Cmb_Corres_Donde.Clear
     
     If Mid(TipoCv, 1, 1) = "C" Then
        
        If MISQL.SQL_Execute(SQL_USD$) = 0 Then
            Do While MISQL.SQL_Fetch(Datos) = 0
               Me.Cmb_Corres_Desde.AddItem Datos(6) & Space(140) & Trim(Datos(5))
               Me.Cmb_Corres_Desde.ItemData(Cmb_Corres_Desde.NewIndex) = Datos(5)
               
               Me.Cmb_Corres_Aquien.AddItem Datos(6) & Space(140) & Trim(Datos(5))
               Me.Cmb_Corres_Aquien.ItemData(Cmb_Corres_Aquien.NewIndex) = Datos(5)
            Loop
        End If
        
        If MISQL.SQL_Execute(SQL_MX$) = 0 Then
            Do While MISQL.SQL_Fetch(Datos) = 0
               Me.Cmb_Corres_Donde.AddItem Datos(6) & Space(140) & Trim(Datos(5))
               Me.Cmb_Corres_Donde.ItemData(Cmb_Corres_Donde.NewIndex) = Datos(5)
            Loop
        End If
    
     ElseIf Mid(TipoCv, 1, 1) = "V" Then
     
        If MISQL.SQL_Execute(SQL_MX$) = 0 Then
            Do While MISQL.SQL_Fetch(Datos) = 0
               Me.Cmb_Corres_Desde.AddItem Datos(6) & Space(140) & Trim(Datos(5))
               Me.Cmb_Corres_Desde.ItemData(Cmb_Corres_Desde.NewIndex) = Datos(5)
               
               Me.Cmb_Corres_Aquien.AddItem Datos(6) & Space(140) & Trim(Datos(5))
               Me.Cmb_Corres_Aquien.ItemData(Cmb_Corres_Aquien.NewIndex) = Datos(5)
            Loop
        End If
        
        If MISQL.SQL_Execute(SQL_USD$) = 0 Then
            Do While MISQL.SQL_Fetch(Datos) = 0
               Me.Cmb_Corres_Donde.AddItem Datos(6) & Space(140) & Trim(Datos(5))
               Me.Cmb_Corres_Donde.ItemData(Cmb_Corres_Donde.NewIndex) = Datos(5)
            Loop
        End If
     End If


End Sub



Function CargaMoneda(ByRef MiCombo As ComboBox, ByVal miSwift As String) As Boolean
    Dim Sqldatos()
    
    CargaMoneda = False
    
    Envia = Array()
    AddParam Envia, Trim(miSwift)
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEE_MONEDAS_CORRESPONSAL", Envia) Then
        Call MsgBox("Se ha generado un error en la carga de monedas.", vbExclamation, App.Title)
        Exit Function
    End If
    Call MiCombo.Clear
    
    Do While Bac_SQL_Fetch(Sqldatos())
        If Trim(Sqldatos(2)) <> "USD" Then
            Call MiCombo.AddItem(Sqldatos(2) + " - " + Sqldatos(3))
            Let MiCombo.ItemData(MiCombo.NewIndex) = Sqldatos(1)
        End If
    Loop

    If MiCombo.ListCount = 0 Then
        Call MiCombo.AddItem("NO TIENE MONEDAS")
        Let MiCombo.ItemData(MiCombo.NewIndex) = -1
    Else
        Let MiCombo.ListIndex = 0
    End If

End Function

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
    OBJCOMBO.Enabled = True
    
End Sub



Sub PROC_CARGA_FILTROS()

    '
    '   jdm, 20100930
    '
    Dim sSQL As String
    
    sSQL = "bacparamsuda.dbo.SP_PLATAFORMASEXTERNAS"
   
    If Bac_Sql_Execute(sSQL) Then
        Do While Bac_SQL_Fetch(Datos())
            '
            '   Fwd
            '
            cmbFwdOrigen.AddItem Datos(3)
            cmbFwdOrigen.ItemData(cmbFwdOrigen.NewIndex) = Datos(5)
    
            '
            '   Spot
            '
            cmbOrigen.AddItem Datos(3)
            cmbOrigen.ItemData(cmbOrigen.NewIndex) = Datos(5)
        Loop
    End If
    Me.cmbFwdOrigen.ListIndex = 0
    Me.cmbOrigen.ListIndex = 0
    
    Call CargaMoneda(Me.cmbFwdMoneda, Me.cmbFwdOrigen.List(cmbFwdOrigen.ListIndex))
    Call CargaMoneda(Me.cmbMoneda, cmbOrigen.List(cmbOrigen.ListIndex))
    
    'Spot
    
'    Me.cmbOrigen.AddItem "BARCLAYS"
'    Me.cmbOrigen.AddItem "STANDARD"
'    Me.cmbOrigen.AddItem "CITIBANK"
    
    
    Me.cmbCV.AddItem "COMPRA"
    Me.cmbCV.AddItem "VENTA"
    Me.cmbCV.ListIndex = 0
    
    
    'Forward
'    Me.cmbFwdOrigen.AddItem "BARCLAYS"
'    Me.cmbFwdOrigen.AddItem "STANDARD"
'    Me.cmbFwdOrigen.AddItem "CITIBANK"
    
    Me.cmbFwdTipoCV.AddItem "COMPRA"
    Me.cmbFwdTipoCV.AddItem "VENTA"
    Me.cmbFwdTipoCV.ListIndex = 0
    

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
    Linea = xNombre & Space(dif) & xUsuario
    Combo.AddItem (Linea)
Loop
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 2 'limpiar
        
            Call Limpia(True)
            
        Case 3 'Cargar
        
            If tabSpotFwd.Tab = 0 Then
            
                If Me.cmbMoneda.Text <> "" And Me.cmbCV.Text <> "" And Me.cmbOrigen.Text <> "" Then
                    Call Limpia(False)
                    Call Cargar_Datos_Spot
                Else
                    Call MsgBox("Debe Seleccionar los campos en Filtro", vbExclamation)
                End If
                
            ElseIf tabSpotFwd.Tab = 1 Then
                
                If Me.cmbFwdTipoCV.Text <> "" And Me.cmbFwdMoneda.Text <> "" And Me.cmbFwdOrigen.Text <> "" Then
                    Call Limpia(False)
                    Call Cargar_Datos_Forward
                Else
                    Call MsgBox("Debe Seleccionar los campos en Filtro", vbExclamation)
                End If
                
            End If
            
        Case 4 'Grabar
        
            If tabSpotFwd.Tab = 0 Then
                
                If Validacion Then
                    If MsgBox("¿Esta seguro que desea grabar los datos?", vbQuestion + vbOKCancel, "Grabación Valores por Defecto Spot") = vbOK Then
                        Call Grabar
                    End If
                Else
                    MsgBox "Error. No todos los campos tienen valor", vbExclamation
                End If
                
            Else
            
                If Validacion Then
                    If MsgBox("¿Esta seguro que desea grabar los datos?", vbQuestion + vbOKCancel, "Grabación Valores por Defecto Forward") = vbOK Then
                        Call Grabar_Fwd
                    End If
                Else
                    Call MsgBox("Error. No todos los campos tienen valor", vbExclamation)
                End If
                
            End If
            
        Case 5 'Salir
        
            Unload Me
            
    End Select
    
End Sub

 Private Function Grabar_Fwd() As String
Dim origen As String
Dim CodMon As Long
Dim TipoCv As String
Dim FORMA_PAGOMN As Long
Dim FORMA_PAGOMX As Long
Dim CODAREARESPONABLE As String
Dim CodCartNorm As String
Dim CODSUBCARTNORM As String
Dim CodLibro As String
Dim CODCART As Long
Dim NBROKER As Long
Dim TIPRETIRO As Long
 
    FORMA_PAGOMN = IIf(Me.cmbFwdTipoCV = "COMPRA", Me.cmbFwdFPEntrega.ItemData(cmbFwdFPEntrega.ListIndex), Me.cmbFwdFPRecibe.ItemData(cmbFwdFPRecibe.ListIndex))
    FORMA_PAGOMX = IIf(Me.cmbFwdTipoCV = "COMPRA", Me.cmbFwdFPRecibe.ItemData(cmbFwdFPRecibe.ListIndex), Me.cmbFwdFPEntrega.ItemData(cmbFwdFPEntrega.ListIndex))

    '--> Mn   Compras = EUR --> Telex 72
    '--> Mx   Compras = USD --> Cheque
    
    '--> Mn   Ventas  = USD --> Cheque
    '--> Mx   Ventas  = EUR --> Telex 72
'    FORMA_PAGOMN = Me.cmbFwdFPRecibe.ItemData(cmbFwdFPRecibe.ListIndex)
'    FORMA_PAGOMX = Me.cmbFwdFPEntrega.ItemData(cmbFwdFPEntrega.ListIndex)
    
   

    origen = Me.cmbFwdOrigen.Text
    CodMon = Me.cmbFwdMoneda.ItemData(Me.cmbFwdMoneda.ListIndex)
    TipoCv = Mid(Me.cmbFwdTipoCV.Text, 1, 1)
    CODAREARESPONABLE = CInt(Right(Me.cmbFwdAreaResponsable.Text, 5))
    CodCartNorm = Trim(Right(Me.cmbFwdCartNorm.Text, 5))
    CODSUBCARTNORM = CInt(Right(Me.cmbFwdSubCartNorm.Text, 5))
    CodLibro = CInt(Right(Me.cmbFwdLibro.Text, 5))
    CODCART = CInt(Right(Me.cmbFwdCartera.Text, 5))
    NBROKER = 0
    TIPRETIRO = 1
                                                             
    Envia = Array()
    AddParam Envia, origen
    AddParam Envia, CodMon
    AddParam Envia, TipoCv
    AddParam Envia, FORMA_PAGOMN
    AddParam Envia, FORMA_PAGOMX
    AddParam Envia, CODAREARESPONABLE
    AddParam Envia, CodCartNorm
    AddParam Envia, CODSUBCARTNORM
    AddParam Envia, CodLibro
    AddParam Envia, CODCART
    AddParam Envia, NBROKER
    AddParam Envia, TIPRETIRO
    AddParam Envia, Trim(Right(Me.CmbOperadorFwd.Text, 12))
    AddParam Envia, 0
     
    If Not Bac_Sql_Execute("BACPARAMSUDA.dbo.SP_GRABAR_VALOR_DEFECTO_CARGA_EXT_FORWARD", Envia) Then
        MsgBox "No es posible grabar los valores por defecto", vbExclamation
    Else
        If Bac_SQL_Fetch(Datos()) Then
            If Datos(1) = 0 Then
                MsgBox Datos(2), vbInformation, "GRABACION VALORES POR DEFECTO OP.EXTERNAS"
            Else
                MsgBox Datos(2), vbCritical, "GRABACION VALORES POR DEFECTO OP.EXTERNAS"
            End If
        End If
    End If

End Function
 
 Private Function Grabar() As String
     
     Dim origen As String
     Dim cMon As Long
     Dim TipoCv As String
     Dim CodMon2 As Long '13
     Dim cCorresp_Desde As Long
     Dim cCorresp_Donde As Long
     Dim cCorresp_Quien As Long 'No
     Dim cPLCorresp_Desde As Long 'No
     Dim cPLCorresp_Donde As Long 'No
     Dim cPLCorresp_Quien As Long 'No
     Dim FORMA_PAGOMN As Long
     Dim FORMA_PAGOMX As Long
     Dim cOma As Long
     Dim cComercio As String
     Dim Datos()
     
     origen = Me.cmbOrigen.Text
     cMon = Me.cmbMoneda.ItemData(cmbMoneda.ListIndex)
     TipoCv = Mid(Me.cmbCV.Text, 1, 1)
     CodMon2 = 13
     cCorresp_Desde = Me.Cmb_Corres_Desde.ItemData(Cmb_Corres_Desde.ListIndex)
     cCorresp_Donde = Me.Cmb_Corres_Donde.ItemData(Cmb_Corres_Donde.ListIndex)
     cCorresp_Quien = Me.Cmb_Corres_Aquien.ItemData(Cmb_Corres_Aquien.ListIndex)
     cPLCorresp_Desde = 0
     cPLCorresp_Donde = 0
     cPLCorresp_Quien = 0
     
    
     FORMA_PAGOMN = IIf(Me.cmbCV = "COMPRA", Me.FpEnt.ItemData(FpEnt.ListIndex), Me.FpRec.ItemData(FpRec.ListIndex))
     FORMA_PAGOMX = IIf(Me.cmbCV = "COMPRA", Me.FpRec.ItemData(FpRec.ListIndex), Me.FpEnt.ItemData(FpEnt.ListIndex))
    
     cOma = Me.CmbOma.ItemData(CmbOma.ListIndex)
     'cComercio = Me.cmbCodigoComercio.ItemData(cmbCodigoComercio.ListIndex)
     cComercio = " "
    
     Envia = Array()
     AddParam Envia, origen
     AddParam Envia, cMon
     AddParam Envia, TipoCv
     AddParam Envia, cCorresp_Quien
     AddParam Envia, cCorresp_Desde
     AddParam Envia, cCorresp_Donde
     AddParam Envia, FORMA_PAGOMN
     AddParam Envia, FORMA_PAGOMX
     AddParam Envia, cOma
     AddParam Envia, cComercio
     AddParam Envia, Trim(Right(Me.CmbOperadorSpot.Text, 12))
     
      If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GRABAR_VALOR_ DEFECTO_CARGA_EXT_SPOT", Envia) Then
          MsgBox "No es posible grabar los valores por defecto"
      Else
          If Bac_SQL_Fetch(Datos()) Then
             If Datos(1) = 0 Then
                MsgBox Datos(2), vbInformation, "GRABACION VALORES POR DEFECTO OP.EXTERNAS"
             Else
                MsgBox Datos(2), vbCritical, "GRABACION VALORES POR DEFECTO OP.EXTERNAS"
             End If
          End If
      
      End If
     
 End Function
 
 
 Function BuscaEnCombo(cControl As Object, nValor As Integer) As Integer
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
 
 Private Function Validacion() As Boolean
   
   Validacion = True
   If tabSpotFwd.Tab = 0 Then
        If Me.cmbOrigen.ListIndex = -1 _
        Or Me.cmbMoneda.ListIndex = -1 _
        Or Me.cmbCV.ListIndex = -1 _
        Or Me.Cmb_Corres_Desde.ListIndex = -1 _
        Or Me.Cmb_Corres_Donde.ListIndex = -1 _
        Or Me.FpEnt.ListIndex = -1 _
        Or Me.FpRec.ListIndex = -1 _
        Or Me.CmbOma.ListIndex = -1 _
        Or Me.CmbOperadorSpot.ListIndex = -1 Then
'        Or Me.cmbCodigoComercio.ListIndex = -1
            Validacion = False
        End If
    ElseIf tabSpotFwd.Tab = 1 Then
        If Me.cmbFwdAreaResponsable.ListIndex = -1 _
        Or Me.cmbFwdCartera.ListIndex = -1 _
        Or Me.cmbFwdCartNorm.ListIndex = -1 _
        Or Me.cmbFwdFPEntrega.ListIndex = -1 _
        Or Me.cmbFwdFPRecibe.ListIndex = -1 _
        Or Me.cmbFwdLibro.ListIndex = -1 _
        Or Me.cmbFwdMoneda.ListIndex = -1 _
        Or Me.cmbFwdOrigen.ListIndex = -1 _
        Or Me.cmbFwdSubCartNorm.ListIndex = -1 _
        Or Me.cmbFwdTipoCV.ListIndex = -1 _
        Or Me.cmbFwdTipoRetiro.ListIndex = -1 _
        Or Me.CmbOperadorFwd.ListIndex = -1 Then
          'Or Me.cmbFwdBroker.ListIndex = -1
           Validacion = False
        End If
    End If
    
 End Function
 
 Private Sub Limpia(tambienFiltro As Boolean)
 
 If tabSpotFwd.Tab = 0 Then
   If tambienFiltro Then
        Me.cmbOrigen.ListIndex = -1
        Me.cmbCV.ListIndex = -1
        Me.cmbMoneda.ListIndex = -1
   End If
   
   Me.Cmb_Corres_Aquien.ListIndex = -1
   Me.Cmb_Corres_Desde.ListIndex = -1
   Me.Cmb_Corres_Donde.ListIndex = -1
   Me.FpEnt.ListIndex = -1
   Me.FpRec.ListIndex = -1
   Me.CmbOma.ListIndex = -1
   Me.cmbCodigoComercio.ListIndex = -1
   Me.CmbOperadorSpot.ListIndex = -1
 ElseIf tabSpotFwd.Tab = 1 Then
   If tambienFiltro Then
    Me.cmbFwdTipoCV.ListIndex = -1
    Me.cmbFwdMoneda.ListIndex = -1
    Me.cmbFwdOrigen.ListIndex = -1
   End If
   
   Me.cmbFwdAreaResponsable.ListIndex = -1
   Me.cmbFwdBroker.ListIndex = -1
   Me.cmbFwdCartera.ListIndex = -1
   Me.cmbFwdCartNorm.ListIndex = -1
   Me.cmbFwdFPEntrega.ListIndex = -1
   Me.cmbFwdFPRecibe.ListIndex = -1
   Me.cmbFwdLibro.ListIndex = -1
   Me.cmbFwdSubCartNorm.ListIndex = -1
   Me.cmbFwdTipoRetiro.ListIndex = -1
   Me.CmbOperadorFwd.ListIndex = -1
 
 
 End If
 End Sub
 
Private Sub Cargar_Datos_Spot()
     Dim Datos()
     Envia = Array()
     AddParam Envia, cmbOrigen.Text
     AddParam Envia, Me.cmbMoneda.ItemData(cmbMoneda.ListIndex)
     AddParam Envia, IIf(Me.cmbCV = "COMPRA", "C", "V")
     AddParam Envia, 0
     
     If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_TRAE_VALOR_DEFECTO_CARGA_EXT_SPOT", Envia) Then
          MsgBox "No es posible traer los valores por defecto"
     Else
            If Bac_SQL_Fetch(Datos()) Then
            
               'Call BuscaEnCombo(Me.cmbFwdFPEntrega, CInt(IIf(Me.cmbFwdTipoCV = "COMPRA", Datos(1), Datos(2))))
               'Call BuscaEnCombo(Me.cmbFwdFPRecibe, CInt(IIf(Me.cmbFwdTipoCV = "COMPRA", Datos(2), Datos(1))))
               
               Call BuscaEnCombo(Me.Cmb_Corres_Aquien, CInt(Datos(1)))
               Call BuscaEnCombo(Me.Cmb_Corres_Desde, CInt(Datos(2)))
               Call BuscaEnCombo(Me.Cmb_Corres_Donde, CInt(Datos(3)))
               Call BuscaEnCombo(Me.FpEnt, CInt(IIf(Me.cmbCV = "COMPRA", Datos(4), Datos(5))))
               Call BuscaEnCombo(Me.FpRec, CInt(IIf(Me.cmbCV = "COMPRA", Datos(5), Datos(4))))
               Call BuscaEnCombo(Me.CmbOma, CInt(Datos(6)))
              'Call BuscaEnCombo(Me.cmbCodigoComercio, CInt(Datos(7)))
               Call BuscarCombo_OP(Me.CmbOperadorSpot, Datos(9))
               
            End If
     End If
 End Sub
 
 Private Sub Cargar_Datos_Forward()
     Dim Datos()
     Envia = Array()
     AddParam Envia, Me.cmbFwdOrigen.Text
     AddParam Envia, Me.cmbFwdMoneda.ItemData(cmbFwdMoneda.ListIndex)
     AddParam Envia, IIf(Me.cmbFwdTipoCV.Text = "COMPRA", "C", "V")
     AddParam Envia, 0
     
     If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_TRAE_VALOR_DEFECTO_CARGA_EXT_FORWARD", Envia) Then
          MsgBox "No es posible traer los valores por defecto"
     Else
            If Bac_SQL_Fetch(Datos()) Then
                                                         
               Call BuscaEnCombo(Me.cmbFwdFPEntrega, CInt(IIf(Me.cmbFwdTipoCV = "COMPRA", Datos(1), Datos(2))))
               Call BuscaEnCombo(Me.cmbFwdFPRecibe, CInt(IIf(Me.cmbFwdTipoCV = "COMPRA", Datos(2), Datos(1))))
               Call BuscarCombo_OP(Me.cmbFwdAreaResponsable, CInt(Datos(3)))
               Call BuscarCombo_OP(Me.cmbFwdCartNorm, Datos(4))
               Call BuscarCombo_OP(Me.cmbFwdSubCartNorm, CInt(Datos(5)))
               Call BuscarCombo_OP(Me.cmbFwdLibro, CInt(Datos(6)))
               Call BuscarCombo_OP(Me.cmbFwdCartera, CInt(Datos(7)))
               Call BuscaEnCombo(Me.cmbFwdBroker, CInt(Datos(8)))
               Call BuscaEnCombo(Me.cmbFwdTipoRetiro, CInt(Datos(9)))
               Call BuscarCombo_OP(Me.CmbOperadorFwd, Datos(10))
               
            End If
     End If
 End Sub

Private Sub txtFPEntFwd_Click()

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
    
    If Combo.ListCount > 0 Then
        Combo.ListIndex = 0
    End If
End Sub

Function BuscarCombo_OP(cControl As Object, nValor As Variant) As Integer
Dim iLin    As Integer

    BuscarCombo_OP = -1

    For iLin = 0 To cControl.ListCount - 1
        If Trim(Right(cControl.List(iLin), Len(nValor))) = Trim(nValor) Then
            BuscarCombo_OP = iLin
            cControl.ListIndex = iLin
            Exit For
        End If
    Next iLin

End Function

