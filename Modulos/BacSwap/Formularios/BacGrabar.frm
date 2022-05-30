VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacGrabar 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Grabar Informacion Swap"
   ClientHeight    =   5475
   ClientLeft      =   1740
   ClientTop       =   330
   ClientWidth     =   7080
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5475
   ScaleWidth      =   7080
   Begin ComctlLib.Toolbar TlbHerramientas 
      Height          =   510
      Left            =   45
      TabIndex        =   18
      Top             =   0
      Width           =   7080
      _ExtentX        =   12488
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   3
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Grabar"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Cancelar"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Buscar "
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame fraThreshold 
      Height          =   630
      Left            =   15
      TabIndex        =   33
      Top             =   4830
      Visible         =   0   'False
      Width           =   7035
      _Version        =   65536
      _ExtentX        =   12409
      _ExtentY        =   1111
      _StockProps     =   14
      Caption         =   "Threshold"
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
      Begin Threed.SSOption optNoAplicaThr 
         Height          =   255
         Left            =   3390
         TabIndex        =   35
         Top             =   240
         Width           =   2175
         _Version        =   65536
         _ExtentX        =   3836
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "No Aplica Threshold"
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
         Font3D          =   1
      End
      Begin Threed.SSOption optSiAplicaThr 
         Height          =   255
         Left            =   1155
         TabIndex        =   34
         Top             =   240
         Width           =   1695
         _Version        =   65536
         _ExtentX        =   2990
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Aplica Threshold"
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
         Value           =   -1  'True
         Font3D          =   1
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Carteras"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1470
      Left            =   30
      TabIndex        =   21
      Top             =   1815
      Width           =   7050
      Begin VB.ComboBox CmbMesaOrg 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   330
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   25
         Top             =   1050
         Width           =   2925
      End
      Begin VB.ComboBox cmbCarteraOrig 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   330
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   24
         Top             =   435
         Width           =   2925
      End
      Begin VB.ComboBox CmbMesaDest 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   330
         Left            =   3705
         Style           =   2  'Dropdown List
         TabIndex        =   23
         Top             =   1050
         Width           =   2925
      End
      Begin VB.ComboBox cmbCarteraDest 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   330
         Left            =   3720
         Style           =   2  'Dropdown List
         TabIndex        =   22
         Top             =   450
         Width           =   2925
      End
      Begin VB.Label lblTitulo 
         AutoSize        =   -1  'True
         Caption         =   "Portafolio"
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
         Height          =   210
         Index           =   11
         Left            =   120
         TabIndex        =   29
         Top             =   825
         Width           =   795
      End
      Begin VB.Label label 
         AutoSize        =   -1  'True
         Caption         =   "Cartera Origen"
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
         Height          =   210
         Index           =   1
         Left            =   120
         TabIndex        =   28
         Top             =   195
         Width           =   1215
      End
      Begin VB.Label lblTitulo 
         AutoSize        =   -1  'True
         Caption         =   "Contraparte"
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
         Height          =   210
         Index           =   15
         Left            =   3735
         TabIndex        =   27
         Top             =   840
         Width           =   990
      End
      Begin VB.Label label 
         AutoSize        =   -1  'True
         Caption         =   "Cartera Destino"
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
         Height          =   210
         Index           =   0
         Left            =   3735
         TabIndex        =   26
         Top             =   210
         Width           =   1290
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1335
      Index           =   0
      Left            =   -15
      TabIndex        =   0
      Top             =   525
      Width           =   7095
      _Version        =   65536
      _ExtentX        =   12515
      _ExtentY        =   2355
      _StockProps     =   14
      Caption         =   "Cliente"
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
      Begin VB.CheckBox ChkControlLinea 
         Alignment       =   1  'Right Justify
         Caption         =   "Control de Línea"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   255
         Left            =   1680
         TabIndex        =   39
         Top             =   1020
         Value           =   1  'Checked
         Width           =   1935
      End
      Begin VB.CheckBox Check1 
         Caption         =   "Check1"
         Enabled         =   0   'False
         Height          =   225
         Left            =   1695
         TabIndex        =   37
         Top             =   810
         Width           =   240
      End
      Begin VB.TextBox TxtCliente 
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
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   1695
         TabIndex        =   2
         Top             =   510
         Width           =   5295
      End
      Begin VB.TextBox TxtRut 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   1695
         MouseIcon       =   "BacGrabar.frx":0000
         MousePointer    =   99  'Custom
         TabIndex        =   1
         Top             =   165
         Width           =   1290
      End
      Begin VB.Label Label3 
         BackStyle       =   0  'Transparent
         Caption         =   "Novación a  Comder"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   510
         Left            =   2040
         TabIndex        =   38
         Top             =   795
         Width           =   4875
      End
      Begin VB.Label LblMetodologia 
         Caption         =   "Metodologia LCR"
         Height          =   195
         Left            =   3600
         TabIndex        =   36
         Top             =   240
         Visible         =   0   'False
         Width           =   3135
      End
      Begin VB.Label label 
         Caption         =   "Rut"
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
         Height          =   195
         Index           =   50
         Left            =   120
         TabIndex        =   4
         Top             =   225
         Width           =   870
      End
      Begin VB.Label label 
         Caption         =   "Nombre"
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
         Height          =   315
         Index           =   52
         Left            =   105
         TabIndex        =   3
         Top             =   585
         Width           =   870
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   2640
      Index           =   1
      Left            =   -15
      TabIndex        =   5
      Top             =   1830
      Width           =   7050
      _Version        =   65536
      _ExtentX        =   12435
      _ExtentY        =   4657
      _StockProps     =   14
      Caption         =   "Cartera"
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
      Begin VB.ComboBox cmbCartera 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   330
         Left            =   1695
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   225
         Width           =   5325
      End
      Begin VB.TextBox TxtObservaciones 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   540
         Left            =   1695
         MaxLength       =   255
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   10
         Top             =   2010
         Width           =   5325
      End
      Begin VB.ComboBox CmbArea 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   330
         Left            =   1695
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   585
         Width           =   5325
      End
      Begin VB.ComboBox CmbSubCartera 
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
         Left            =   1695
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   1650
         Width           =   5325
      End
      Begin VB.ComboBox CmbCartNorm 
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
         Left            =   1695
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   1305
         Width           =   5325
      End
      Begin VB.ComboBox CmbLibro 
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
         Left            =   1695
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   945
         Width           =   5325
      End
      Begin VB.Label label 
         AutoSize        =   -1  'True
         Caption         =   "Observaciones"
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
         Height          =   210
         Index           =   57
         Left            =   120
         TabIndex        =   17
         Top             =   2160
         Width           =   1245
      End
      Begin VB.Label label 
         AutoSize        =   -1  'True
         Caption         =   "Cartera Financiera"
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
         Height          =   210
         Index           =   55
         Left            =   105
         TabIndex        =   16
         Top             =   285
         Width           =   1500
      End
      Begin VB.Label lblTitulo 
         AutoSize        =   -1  'True
         Caption         =   "Area Responsable"
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
         Height          =   210
         Index           =   1
         Left            =   105
         TabIndex        =   15
         Top             =   645
         Width           =   1515
      End
      Begin VB.Label LblSubCartera 
         AutoSize        =   -1  'True
         Caption         =   "Sub Cartera"
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
         Height          =   210
         Left            =   105
         TabIndex        =   13
         Top             =   1740
         Width           =   975
      End
      Begin VB.Label LblCartNorm 
         AutoSize        =   -1  'True
         Caption         =   "Cartera Normativa"
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
         Height          =   210
         Left            =   105
         TabIndex        =   12
         Top             =   1380
         Width           =   1485
      End
      Begin VB.Label LblLibro 
         AutoSize        =   -1  'True
         Caption         =   "Libro"
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
         Height          =   210
         Left            =   105
         TabIndex        =   14
         Top             =   1020
         Width           =   435
      End
   End
   Begin VB.Frame frmOperador 
      Height          =   735
      Left            =   15
      TabIndex        =   30
      Top             =   4110
      Visible         =   0   'False
      Width           =   7050
      Begin VB.ComboBox cboOperador 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   3360
         Style           =   2  'Dropdown List
         TabIndex        =   31
         Top             =   240
         Width           =   3615
      End
      Begin VB.Label Label1 
         Caption         =   "Ingrese el Operador"
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
         Height          =   210
         Left            =   120
         TabIndex        =   32
         Top             =   300
         Width           =   3015
      End
   End
   Begin VB.ComboBox CmbOperador 
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
      Left            =   1725
      Style           =   2  'Dropdown List
      TabIndex        =   19
      Top             =   4215
      Visible         =   0   'False
      Width           =   5325
   End
   Begin VB.Label label 
      Caption         =   "Operador"
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
      Height          =   270
      Index           =   56
      Left            =   105
      TabIndex        =   20
      Top             =   4290
      Visible         =   0   'False
      Width           =   1380
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   7290
      Top             =   60
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   3
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacGrabar.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacGrabar.frx":0624
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacGrabar.frx":093E
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacGrabar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public iModificacion       As Boolean
Public MiTipoSwap          As Variant
Public MiFormulario        As Variant
Public CarteraFinanciera   As Variant
Public AreaResponsable     As Variant
Public LibroNegociacion    As Variant
Public CarteraNormativa    As Variant
Public SubCarteraNormativa As Variant
Public Observaciones       As Variant
Public RutCliente          As Variant
Public CodCliente          As Variant
Public grabaOperador       As Boolean  'JBH, 22-12-2209
Public actDigitador        As Boolean  'JBH, 22-12-2009
Public Metodologia_Cliente As Integer  'PROD-10967
Dim strMsgError            As String
Public gModalidad          As String
Public ObjCliente          As Object


Private Sub Proc_SM_BuscarDatos()
    Dim Mantencion As New clsMantencionSwap
    Dim iContador As Integer
        
    With Mantencion
        
        .NumOperacion = oFormulario.Lbl_Num_Oper_Oculto.Caption
        .TipoOperacion = swModTipoOpe
        
        If cOperSwap = "ModificacionCartera" Then
             .TipoOperacion = 4
        End If
       
        If Not .LeerDatos Then
            Set Mantencion = Nothing
            MsgBox "Ha ocurrido un error al intentar rescatar los datos del cliente", vbCritical + vbOKOnly, Msj
        End If
         
        If .coleccion.Count > 0 Then
            For iContador = 1 To .coleccion.Count

                txtCliente.Tag = .coleccion(iContador).swCodCliente
                txtCliente.Text = .coleccion(iContador).swNomCliente
                TxtRut.Tag = Trim(Left(.coleccion(iContador).swRutCliente, Len(.coleccion(iContador).swRutCliente) - 2))
                
                If (.coleccion(iContador).swRutCliente) <> "" Then
                    TxtRut.Text = BacFormatoRut(.coleccion(iContador).swRutCliente)  'Rutpaso
                End If
                
                Dim claseCli As New clsCliente
                
                If claseCli.LeerxRut(Val(.coleccion(iContador).swRutCliente), Val(.coleccion(iContador).swCodCliente)) Then
                    If Tipo_Operacion$ = "SM" Then
                       nPaisOrigen = claseCli.clPais
                    ElseIf Tipo_Operacion$ = "ST" Then
                       nPaisOrigenST = claseCli.clPais
                    End If
                End If
                
                Set claseCli = Nothing
                
                If .coleccion(iContador).swOperadorCliente <> 0 Then
                    Call Operadores(CmbOperador, .coleccion(iContador).swCodCliente, Mid(.coleccion(iContador).swRutCliente, 1, Len(.coleccion(iContador).swRutCliente) - 2))
                    Call bacBuscarCombo(CmbOperador, .coleccion(iContador).swOperadorCliente)
                End If
                
                Call Sub_Busca_Item_Combo(cmbCartera, Trim(Str(.coleccion(iContador).swCarteraInversion)))
                Call Sub_Busca_Item_Combo(CmbArea, .coleccion(iContador).swAreaResp)
                Call Sub_Busca_Item_Combo(CmbCartNorm, .coleccion(iContador).swCartNorm)
                Call Sub_Busca_Item_Combo(CmbSubCartera, .coleccion(iContador).swSubCartNorm)
                Call Sub_Busca_Item_Combo(CmbLibro, .coleccion(iContador).swLibro)
                
                TxtObservaciones.Text = .coleccion(iContador).swObservaciones
            Next iContador
        End If
    End With
End Sub

Sub Proc_ST_BuscarDatos()
    Dim Mantencion As New clsMantencionSwap
   
    With Mantencion
                  
        .NumOperacion = IIf(oFormulario.Lbl_Num_Oper_Oculto.Caption = "", 0, oFormulario.Lbl_Num_Oper_Oculto.Caption)
        .TipoOperacion = swModTipoOpe
        
        If cOperSwapST = "ModificacionCartera" Then
            .TipoOperacion = 4
        End If
            
        If Not .LeerDatos Then
            Set Mantencion = Nothing
            MsgBox "Operación no ha sido encontrada", vbCritical, Msj
            Exit Sub
        End If
            
        If .coleccion.Count > 0 Then
            txtCliente.Tag = .coleccion(1).swCodCliente
            txtCliente.Text = .coleccion(1).swNomCliente
            TxtRut.Text = .coleccion(1).swRutCliente
            TxtRut.Tag = Trim(Left(.coleccion(1).swRutCliente, Len(.coleccion(1).swRutCliente) - 2))
            
            Call Sub_Busca_Item_Combo(cmbCartera, .coleccion(1).swCarteraInversion)
            Call Sub_Busca_Item_Combo(CmbArea, .coleccion(1).swAreaResp)
            Call Sub_Busca_Item_Combo(CmbCartNorm, .coleccion(1).swCartNorm)
            Call Sub_Busca_Item_Combo(CmbSubCartera, .coleccion(1).swSubCartNorm)
            Call Sub_Busca_Item_Combo(CmbLibro, .coleccion(1).swLibro)
            TxtObservaciones.Text = .coleccion(1).swObservaciones
        End If
    End With
    
    Set Mantencion = Nothing
    
End Sub




Private Sub Proc_Valida_Moneda_Swap_LCR(miForm As Form)
    'PROD-10967
    Dim MonedaBac As Integer
    Dim CodigoTasa As Long
    Dim TipoSwap As Integer
    Dim iNumeroFlujos    As Integer
    Dim iTipoFlujo       As Integer
    Dim MiGrilla         As MSFlexGrid
    Dim Swap As New Swap_OP
    Dim Codigo_descuento As Long
    Dim Codigo_forward As Long
   
    For iTipoFlujo = 1 To 2
        Set MiGrillaaux = IIf(iTipoFlujo = 1, miForm.I_Grid, miForm.D_Grid)
        For iNumeroFlujos = 1 To MiGrillaaux.Rows - 1
        
              MonedaBac = IIf(iTipoFlujo = 1 _
                                , miForm.I_Moneda.ItemData(miForm.I_Moneda.ListIndex) _
                                , miForm.D_Moneda.ItemData(miForm.D_Moneda.ListIndex))
                               
              Func_Riesgo_Financiero (MonedaBac) '3   'As Long
              If ParamMoneda_LCR = True Then
                 Exit Sub
              End If
            
              CodigoTasa = IIf(iTipoFlujo = 1, _
                                  miForm.I_Indicador.ItemData(miForm.I_Indicador.ListIndex), _
                                  miForm.D_Indicador.ItemData(miForm.D_Indicador.ListIndex))
              
              TipoSwap = Swap.EntregaTipoSwap(miForm)
              
              Codigo_descuento = Func_CodigoDescuento(MonedaBac, CodigoTasa, TipoSwap, 1) '0 'As Long
              If ParamMoneda_LCR = True Then
                 Exit Sub
              End If
              Codigo_forward = Func_CodigoDescuento(MonedaBac, CodigoTasa, TipoSwap, 2) '1 'As Long
              
              If ParamMoneda_LCR = True Then
                 Exit Sub
              End If
                 
        Next
    Next
End Sub

Private Sub Proc_Valida_Moneda_Fra_LCR(miForm As Form)
    'PROD-10967
    Dim MonedaBac As Integer
    Dim CodigoTasa As Long
    Dim TipoSwap As Integer
    Dim iNumeroFlujos    As Integer
    Dim iTipoFlujo       As Integer
    Dim MiGrilla         As MSFlexGrid
    Dim Codigo_descuento As Long
    Dim Codigo_forward As Long
   
    For iTipoFlujo = 1 To 2
        Set MiGrillaaux = IIf(iTipoFlujo = 1, miForm.I_Grid, miForm.D_Grid)
        For iNumeroFlujos = 1 To MiGrillaaux.Rows - 1
        
              MonedaBac = miForm.Moneda.ItemData(miForm.Moneda.ListIndex)
                              
              Func_Riesgo_Financiero (MonedaBac) '3   'As Long
              If ParamMoneda_LCR = True Then
                 Exit Sub
              End If
            
              CodigoTasa = IIf(iTipoFlujo = 1, _
                                  miForm.Indicador.ItemData(miForm.Indicador.ListIndex), _
                                  miForm.Indicador.ItemData(miForm.Indicador.ListIndex))
              
              TipoSwap = 1 'Swap.EntregaTipoSwap(miForm)
              
              Codigo_descuento = Func_CodigoDescuento(MonedaBac, CodigoTasa, TipoSwap, 1) '0 'As Long
              If ParamMoneda_LCR = True Then
                 Exit Sub
              End If
              Codigo_forward = Func_CodigoDescuento(MonedaBac, CodigoTasa, TipoSwap, 2) '1 'As Long
              
              If ParamMoneda_LCR = True Then
                 Exit Sub
              End If
                 
        Next
    Next
End Sub




Private Sub CmbCartNorm_Click()
        'Call PROC_LLENA_COMBOS(CmbSubCartera, 3, False, GLB_SUB_CARTERA_NORMATIVA, "", Trim(Right(CmbCartNorm.Text, 10)))
        
        Call PROC_LLENA_COMBOS(CmbSubCartera, 11, False, GLB_ID_SISTEMA, Tipo_Producto, Trim(Right(CmbLibro.Text, 10)), GLB_SUB_CARTERA_NORMATIVA, Trim(Right(CmbCartNorm.Text, 10)), gsBAC_User, "")
                        
        If cOperSwap <> "" And cOperSwap <> "Ingreso" Then
            Call PROC_LLENA_COMBOS(CmbSubCartera, 1, False, GLB_SUB_CARTERA_NORMATIVA, Trim(Right(CmbCartNorm.Text, 10)))
        End If

End Sub


Private Sub CmbLibro_Click()

    'Call PROC_LLENA_COMBOS(CmbCartNorm, 6, False, GLB_ID_SISTEMA, Tipo_Producto, Trim(Right(CmbLibro.Text, 10)), GLB_CARTERA_NORMATIVA)
    Call PROC_LLENA_COMBOS(CmbCartNorm, 9, False, GLB_ID_SISTEMA, Tipo_Producto, Trim(Right(CmbLibro.Text, 10)), GLB_CARTERA_NORMATIVA, "", gsBAC_User)
    If CmbCartNorm.ListCount = 0 Then
       CmbSubCartera.Clear
    End If
    
    If CmbCartNorm.ListCount = 0 And Me.Visible = True Then
        MsgBox "El Libro " & Trim(Left(CmbLibro.Text, 50)) & " No Tiene Asociada Ninguna Cartera Super", vbExclamation
    End If
    
    
        If cOperSwap <> "" And cOperSwap <> "Ingreso" Then
            Call PROC_LLENA_COMBOS(CmbCartNorm, 6, False, GLB_ID_SISTEMA, Tipo_Producto, Trim(Right(CmbLibro.Text, 10)), GLB_CARTERA_NORMATIVA)
        End If
    
    
End Sub


Private Sub CmbOperador_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys ("{Tab}")
   End If
End Sub


Private Sub Form_Activate()
   If CmbLibro.ListCount = 0 Then
      MsgBox "No Existen Libros Asociados A Este Producto", vbExclamation
      GLB_bCancelar = True
      Unload Me
      Exit Sub
   End If
   If CmbCartNorm.ListCount = 0 Then
      MsgBox "El Libro " & Trim(Left(CmbLibro.Text, 50)) & " No Tiene Asociada Ninguna Cartera Super", vbExclamation
   End If
End Sub

Private Sub Form_Load()
 '  If MiTipoSwap = 2 Then '--> Swap de Monedas  CCS 'PROD-10967
 '       TlbHerramientas.Buttons(3).Visible = False
 '  End If
   
   gModalidad = FRM_SWAP_OP.Modalidad.Text

   If BACSwap.Height > Me.Height Then
      If BACSwap.Width > Me.Width Then
         Me.Top = (BACSwap.Height / 2) - (Me.Height / 2)
         Me.Left = (BACSwap.Width / 2) - (Me.Width / 2)
      End If
   End If
   TlbHerramientas.Buttons(3).Enabled = False 'PROD-10967
   GLB_bCancelar = False
   
   Call PROC_LLENA_COMBOS(CmbArea, 1, False, GLB_AREA_RESPONSABLE, GLB_ID_SISTEMA)
   'Call PROC_LLENA_COMBOS(CmbLibro, 5, False, GLB_ID_SISTEMA, Tipo_Producto, GLB_LIBRO)
   'Call PROC_LLENA_COMBOS(cmbCartera, 2, False, Tipo_Producto, GLB_CARTERA, GLB_ID_SISTEMA)
   
   Call PROC_LLENA_COMBOS(CmbLibro, 8, False, GLB_ID_SISTEMA, Tipo_Producto, GLB_LIBRO, "", gsBAC_User)
    Call PROC_LLENA_COMBOS(cmbCartera, 7, False, Tipo_Producto, GLB_CARTERA, GLB_ID_SISTEMA, "", gsBAC_User)
   
   If CmbArea.ListCount > 0 Then
      CmbArea.ListIndex = 0
   End If
   TxtRut.Text = ""
   txtCliente.Text = ""
   TxtRut.Enabled = True
   txtCliente.Locked = True
   TxtObservaciones.Text = ""

    If Tipo_Producto = "SM" Then
        If cOperSwap <> "" And cOperSwap <> "Ingreso" Then
            Call Proc_SM_BuscarDatos
        End If
    ElseIf Tipo_Producto = "ST" Then
        If cOperSwapST <> "" And cOperSwapST <> "Ingreso" Then
            Call Proc_ST_BuscarDatos
        End If
    End If
    
    'PRD-4858, jbh, 12-02-2010
    If ope_intramesa = True Then
        'Operaciones intramesas no calculan Threshold
        fraThreshold.Visible = False
       'Me.Height = 6870
    Else
        fraThreshold.Visible = True
       'Me.Height = 7740
    End If

    Let fraThreshold.Visible = False

    If ControlAtribuciones() = True Then    'JBH, 05-01-2010
        'Me.Height = 6900
        frmOperador.Enabled = True
        frmOperador.Visible = True
        cboOperador.Enabled = True
        Call LlenaComboOperadores(cboOperador)
    Else
        'Me.Height = 6105
        cboOperador.Enabled = False
        frmOperador.Enabled = False
        frmOperador.Visible = False
    End If
    'fin JBH, 22-12-2009

    Frame1.Visible = False

    'If FRM_SWAP_OP.chk_intramesa.Value = 1 Then    'JBH, 16-12-2009
    If ope_intramesa = True Then    'JBH, 16-12-2009
        ' 3162
       optSiAplicaThr = False
       fraThreshold.Enabled = False
       fraThreshold.Visible = False
       '
       TxtRut.Enabled = False
       TxtRut.Text = "97023000-9"
       txtCliente.Text = "CorpBanca"
       txtCliente.Tag = 0
       
             
        frame(1).Visible = False
        Frame1.Visible = True
        Frame1.Top = frame(1).Top
        CmbMesaOrg.Enabled = True
        
        'Func_Cartera cmbCarteraOrig, "PCS"
        Call PROC_LLENA_COMBOS(cmbCarteraOrig, 7, False, Tipo_Producto, GLB_CARTERA, GLB_ID_SISTEMA, "", gsBAC_User)
        Func_Cartera cmbCarteraDest, "PCS"
            
        'Call LeerMesasOrig(CmbMesaOrg)
        Call PROC_LLENA_COMBOS(CmbMesaOrg, 10, False, gsBAC_User, "", GLB_CATEG)
        Call LeerMesas(CmbMesaDest)
    Else
        optSiAplicaThr = True
        fraThreshold.Enabled = False
        fraThreshold.Visible = False
    End If
            
    
        If cOperSwap <> "" And cOperSwap <> "Ingreso" Then
            Call LeerMesasOrig(CmbMesaOrg)
            Call LeerMesas(CmbMesaDest)
            Call PROC_LLENA_COMBOS(CmbLibro, 5, False, GLB_ID_SISTEMA, Tipo_Producto, GLB_LIBRO)
            Call PROC_LLENA_COMBOS(cmbCartera, 2, False, Tipo_Producto, GLB_CARTERA, GLB_ID_SISTEMA)
    End If
    
    '// Seteo Original para Campos Comder
'    Let Check1.Value = False

    'prd19111 ini
        Call gsc_Parametros.DatosGenerales
        '->Valida si esta activo el Swicht en la tabla MFAC
        If gsc_Parametros.ActivaComder = "N" Then
           Label3.Enabled = False
           Check1.Enabled = False
        End If
        
        
    'prd19111 fin
End Sub

Function GrabarSwapMonedas() As Boolean
   Dim objGrabaSwap        As New ClsMovimSwaps
   Dim SQL                 As String
   Dim i, Actualiza        As Integer
   Dim fecInteres          As String
   Dim Hasta               As Long
   Dim OperSwap            As String
   Dim Datos()
   
   '********************************************************************
   '* Rutina que graba los datos de operaciones nuevas y Operaciones Modificadas *
   '********************************************************************
   GrabarSwapMonedas = False
   
   With objGrabaSwap
      
      If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
         Exit Function
      End If
      If cOperSwap = "Ingreso" Then
         'Saca numero de ultima operacion
         Envia = Array()
         AddParam Envia, Sistema
         AddParam Envia, Entidad
         If Not Bac_Sql_Execute("SP_ULTIMAOPERACION", Envia) Then
            MsgBox "Problemas para crear número de Operación!", vbCritical, Msj
            Exit Function
         End If
         
         If Bac_SQL_Fetch(Datos()) Then
            objGrabaSwap.swNumOperacion = Val(Datos(1))            'Numero de la Operacion
         Else
            objGrabaSwap.swNumOperacion = 1                              'Primera Operacion creada
         End If
         
        
         nNumoper = objGrabaSwap.swNumOperacion
         FechaCierre = gsBAC_Fecp
         Actualiza = 1
      ElseIf cOperSwap = "Modificacion" Or cOperSwap = "ModificacionCartera" Then
         'modificaciones del diario o de vigentes
         Envia = Array()
         AddParam Envia, Str(nNumoper)
         AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
         AddParam Envia, Format(Time, "HH:MM:SS")
         
         If Not Bac_Sql_Execute("SP_MODIFICASWAPS", Envia) Then
            MsgBox "Problemas al verificar Operación a modificar!", vbCritical, Msj
            Exit Function
         End If
         
         objGrabaSwap.swNumOperacion = nNumoper
         Actualiza = IIf(cOperSwap = "Modificacion", 1, 2)   'Si actualizara la tabla de MovDiario
                                                             ' La fecha de cierre se recupero en funcion BuscarDatos, variable FechaCierre
         Call Lineas_Anular(Sistema, CDbl(.swNumOperacion))  'Primero Anula Monto Anterior
         
            Dim oParametrosLineaAnula As New clsControlLineaIDD
            '+++CONTROL IDD, jcamposd anula toma de linea
            With oParametrosLineaAnula
                .Modulo = Sistema
                .Producto = CDbl(OP_SWAP_MONEDAS) '--> jcamposd, según flujo mas adelante le asigna 3 por defecto
                .Operacion = nNumoper
                .Documento = nNumoper
                .Correlativo = 0
                .Accion = "R"
            
                .RecuperaDatosLineaIDD
                If .numeroiddAnula <> 0 Then
                    .EjecutaProcesoWsLineaIDD
                End If
                
            End With
            
            Set oParametrosLineaAnula = Nothing
            On Error GoTo seguirAnulacionSwapMonedas 'debe seguir con la transaccion BAC
            '---CONTROL IDD, jcamposd anula toma de linea
         
    End If
    
seguirAnulacionSwapMonedas:
    
    If oFormulario.cmbMonedaCompra.ItemData(oFormulario.cmbMonedaCompra.ListIndex) = 13 Then 'DOLAR
        cTipoOperacion$ = "C"
    Else
        cTipoOperacion$ = "V"
    End If
    
   '********** Linea -- Mkilo
   If gsBac_Lineas = "S" Then
      Dim Mensaje     As String
      Dim cCheque     As String
      Dim nRutCheque  As Double
      Dim Mensaje_Con As String
      Dim SwResp      As Integer
      Dim CodMonOp    As Double
      Dim MercadoLc   As String
      Dim Monto_Usd   As Double
      Dim Mensaje_Lin As String
      Dim Mensaje_Lim As String
      
      If cTipoOperacion$ = "C" Then
         Monto_Usd = CDbl(oFormulario.txtCapitalCompra.Text)
         CodMonOp = SacaCodigo(oFormulario.cmbMonedaCompra)
      Else
         Monto_Usd = CDbl(oFormulario.txtCapitalVenta.Text)
         CodMonOp = SacaCodigo(oFormulario.cmbMonedaVenta)
      End If
      cCheque = "N"
      nRutCheque = 0
      Mensaje = ""
             
      If Not Lineas_ChequearGrabar(Sistema, CDbl(OP_SWAP_MONEDAS), CDbl(.swNumOperacion), 0, 0, _
                                            CDbl(TxtRut.Tag), CDbl(txtCliente.Tag), Monto_Usd, 0, _
                                            CDate(oFormulario.txtFecTermino.Text), 0, 0, CDate(gsBAC_Fecp), 0, "N", _
                                            CDbl(CodMonOp), "C", 0, cCheque, nRutCheque, _
                                            CDate(gsBAC_Fecp), 0, SacaCodigo(oFormulario.cmbDocumentoRecibimos), 0, 0) Then 'PROD-10967
            If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
               MsgBox "Problemas en Procedimientos de Lineas", vbCritical, Msj
               Exit Function
            End If
            Exit Function
      End If
                 
      If nPaisOrigen = 6 Then
         MercadoLc = "S"
      Else
         MercadoLc = "N"
      End If
            
      'Prechequeo de los Límites
      Mensaje_Con = Lineas_ConsultaOperacion(Sistema, CDbl(OP_SWAP_MONEDAS), .swNumOperacion, " ", cCheque, MercadoLc)
      If Trim(Mensaje_Con) <> "" Then
         SwResp = MsgBox("ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", vbYesNo + vbExclamation, TITSISTEMA)
         If SwResp <> vbYes Then
            Call Lineas_BorraConsultaOperacion(Sistema, .swNumOperacion)
            If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
               Set objGrabaSwap = Nothing
               MsgBox "Problemas en Procedimientos de Lineas", vbCritical, Msj
               Exit Function
            End If
            Exit Function
         End If
      End If
            
      'Si Acepta y Tiene Errores Sigue Normal
      Mensaje = Mensaje & Lineas_Chequear(Sistema, CDbl(OP_SWAP_MONEDAS), .swNumOperacion, " ", cCheque, MercadoLc)
      If Mensaje <> "" Then
         If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            Set objGrabaSwap = Nothing
            Exit Function
         End If
         MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical, Msj
      End If
   End If

    .swAreaResp = ""
    .swCartNorm = ""
    .swSubCartNorm = ""
    .swLibro = ""
    .swCarteraInversion = 0
    .swObservacion = ""
    
    'Datos Generales
    .swActualizar = Actualiza
    
    .swAreaResp = Trim(Right(Me.CmbArea.Text, 10))
    .swCartNorm = Trim(Right(CmbCartNorm.Text, 10))
    .swSubCartNorm = Trim(Right(CmbSubCartera.Text, 10))
    .swLibro = Trim(Right(CmbLibro.Text, 10))
    .swObservacion = Trim(TxtObservaciones.Text)
    
    .swTipoSwap = OP_SWAP_MONEDAS                                          'Tipo de Swap (Tasa - Monedas)
    .swCarteraInversion = Trim(Right(cmbCartera, 10))                 'Codigo de Cartera de Inversion
    .swTipoOperacion = cTipoOperacion$                                     'Tipo de Operacion (Compra-Venta)
    .swCodCliente = IIf(txtCliente.Tag = "", 0, txtCliente.Tag)            'Codigo cliente
    .swRutCliente = IIf(TxtRut.Tag = "", 0, TxtRut.Tag)                                      'Codigo cliente
    .swOperador = Left(gsBAC_User$, 10)                                    'ingresa nombre usuario con max. de 10 caract.
    .swOperadorCliente = SacaCodigo(CmbOperador)                          'Codigo del Operador
    .swFechaModifica = gsBAC_Fecp
    .swObservaciones = Trim(TxtObservaciones.Text) '"s/o"
    .swFechaCierre = FechaCierre                                                'Fecha del dia en que se realiza operacion
    .swFechaInicio = oFormulario.txtFecInicio.Text                                          'Fecha Primer Vencimiento
    .swFechaTermino = oFormulario.txtFecTermino.Text                                       'Fecha Termino amortizacion
    
    'Datos de Compra [Recibimos]
    .swCMoneda = SacaCodigo(oFormulario.cmbMonedaCompra)                                    'Moneda de Compra
    .swCCapital = CDbl(oFormulario.txtCapitalCompra.Text)                             'Monto Capital
    .swCCodAmoCapital = Val(Trim(Right(oFormulario.cmbAmortizaCapitalCompramos, 10)))       'Codigo tipo amortizacion de capital
    .swCMesAmoCapital = ValorAmort(oFormulario.cmbAmortizaCapitalCompramos, DesgloseAmortST)  'Valor de meses
    .swCCodAmoInteres = Val(Trim(Right(oFormulario.cmbAmortizaInteresCompramos, 10)))       'Codigo tipo amortizacion de interes
    .swCMesAmoInteres = ValorAmort(oFormulario.cmbAmortizaInteresCompramos, DesgloseAmortST)  'Valor de meses
    .swCBase = SacaCodigo(oFormulario.cmbBaseCompra)                                                    'Monto base Compra
    .swCMontoCLP = 0                                                            'Monto compra en Pesos
    .swCMontoUSD = 0                                                            'Monto Compra en moneda pactada
    .swCSpread = CDbl(oFormulario.txtSpreadCompra.Text)
    .swCCodigoTasa = SacaCodigo(oFormulario.cmbTasaCompra)                                  'Codigo de tasa compra
    .swRecMoneda = SacaCodigo(oFormulario.cmbMonedaRecibimos)                               'Codigo Moneda Pagamos
    .swRecDocumento = SacaCodigo(oFormulario.cmbDocumentoRecibimos)                         'Codigo documento Pagamos
    
    'Datos de Venta
    .swVMoneda = 0                          'Codigo Moneda de Venta
    .swVCapital = 0                         'Monto capital Venta
    .swVCodAmoCapital = 0                   'Codigo tipo de amortizacion Tasa
    .swVMesAmoCapital = 0                   'Valor de meses
    .swVCodAmoInteres = 0                   'Codigo tipo amortizacion de interes
    .swVMesAmoInteres = 0                   'Valor de meses
    .swVBase = 0                            'Monto Base Venta
    .swVMontoCLP = 0                        'Monto Venta en Pesos
    .swVMontoUSD = 0                        'Monto Venta en moneda pactada
    .swVCodigoTasa = 0                      'Codigo de tasa Venta
    .swVSpread = 0
    .swPagMoneda = 0                        'Codigo Moneda Pagamos
    .swPagDocumento = 0                     'Codigo documento Pagamos
    .swVAmortiza = 0                        'Monto Amortizado en Venta
    .swVSaldo = 0                           'Monto no amortizado (Saldo) en Venta
    .swVInteres = 0                         'Monto Interes de Compra
    .swVSpread = 0
    .swVValorTasa = 0
    .swVValorTasaHoy = 0                    'Valor Tasa del dia
    .swPagMonto = 0
    .swPagMontoUSD = 0
    .swPagMontoCLP = 0
     
    fecInteres = oFormulario.fgFlujosCompra.TextMatrix(1, 1)
    
    '***   CH = Cartera Historica
    For i = 1 To oFormulario.fgFlujosCompra.Rows - 1
    
        If oFormulario.fgFlujosCompra.TextMatrix(i, 1) <> "" Then
    
            .swTipoFlujo = 1
            .swNumFlujo = oFormulario.fgFlujosCompra.TextMatrix(i, 0)                  'Correlativo de la Operacion
            If oFormulario.fgFlujosCompra.TextMatrix(i, 9) = "" Then
              .swFechaInicioFlujo = oFormulario.txtFecInicio.Text
            Else
               .swFechaInicioFlujo = oFormulario.fgFlujosCompra.TextMatrix(i, 9)
            End If
            .swFechaVenceFlujo = oFormulario.fgFlujosCompra.TextMatrix(i, 1)
            
            .swCAmortiza = CDbl(oFormulario.fgFlujosCompra.TextMatrix(i, 2))     'Monto amortizado en Compra
            If oFormulario.fgFlujosCompra.TextMatrix(i, 8) = "" Then
               .swCSaldo = 0
            Else
               .swCSaldo = CDbl(oFormulario.fgFlujosCompra.TextMatrix(i, 8))        'Monto no amortizado (Saldo) en compra
            End If
            If oFormulario.fgFlujosCompra.TextMatrix(i, 4) = "" Then
               .swCInteres = 0
            Else
               .swCInteres = CDbl(oFormulario.fgFlujosCompra.TextMatrix(i, 4))      'Monto Interes de Compra
            End If
            .swCSpread = CDbl(oFormulario.txtSpreadCompra.Text)
            .swCValorTasa = CDbl(oFormulario.txtTasaCompra.Text)
            .swCValorTasaHoy = .swCValorTasa                               'Valor Tasa del dia
            If oFormulario.fgFlujosCompra.TextMatrix(i, 5) = "" Then
               .swRecMonto = CDbl(oFormulario.fgFlujosCompra.TextMatrix(i, 2))
            Else
               .swRecMonto = CDbl(CDbl(oFormulario.fgFlujosCompra.TextMatrix(i, 2)) + CDbl(oFormulario.fgFlujosCompra.TextMatrix(i, 5)))
            End If
            If oFormulario.fgFlujosCompra.TextMatrix(i, 11) = "" Then
               .swRecMontoUSD = 0
            Else
               .swRecMontoUSD = CDbl(oFormulario.fgFlujosCompra.TextMatrix(i, 11))
            End If
            If oFormulario.fgFlujosCompra.TextMatrix(i, 12) = "" Then
               .swRecMontoCLP = 0
            Else
               .swRecMontoCLP = CDbl(oFormulario.fgFlujosCompra.TextMatrix(i, 12)) '.FormatNum(fgFlujosCompra.TextMatrix(i, 12))
            End If
            .swEstadoFlujo = 1
            .swModalidadPago = Right(oFormulario.fgFlujosVenta.TextMatrix(i, 6), 1)    'cModalidad
            fecInteres = oFormulario.fgFlujosVenta.TextMatrix(i, 1)

            .ParidadCompra = oFormulario.txtValorMonedaCompra.Text
            .ParidadVenta = oFormulario.txtValorMonedaVenta.Text
            
            If Not .Grabar Then
               MsgBox "No terminó proceso de ingreso de datos", vbCritical, Msj
               If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                  MsgBox "Problemas al deshacer la operación", vbCritical, Msj
                  Set objGrabaSwap = Nothing
                  Exit Function
               End If
               Set objGrabaSwap = Nothing
               Exit Function
            End If
        End If
    Next i

    'Datos de Compra
    .swCMoneda = 0          'Moneda de Compra
    .swCCapital = 0         'Monto Capital
    .swCCodAmoCapital = 0   'Codigo tipo amortizacion de capital
    .swCMesAmoCapital = 0   'Valor de meses
    .swCCodAmoInteres = 0   'Codigo tipo amortizacion de interes
    .swCMesAmoInteres = 0   'Valor de meses
    .swCBase = 0            'Monto base Compra
    .swCMontoCLP = 0        'Monto compra en Pesos
    .swCMontoUSD = 0        'Monto Compra en moneda pactada
    .swCSpread = 0
    .swCCodigoTasa = 0      'Codigo de tasa compra
    .swRecMoneda = 0        'Codigo Moneda Recibimos
    .swRecDocumento = 0     'Codigo Documento Recibimos
    .swCAmortiza = 0        'Monto amortizado en Compra
    .swCSaldo = 0           'Monto no amortizado (Saldo) en compra
    .swCInteres = 0         'Monto Interes de Compra
    .swCValorTasa = 0
    .swCValorTasaHoy = 0    'Valor Tasa del dia
    .swRecMonto = 0
    .swRecMontoUSD = 0
    .swRecMontoCLP = 0
        
    'Datos de Venta
    .swVMoneda = SacaCodigo(oFormulario.cmbMonedaVenta)                                 'Codigo Moneda de Venta
    .swVCapital = CDbl(oFormulario.txtCapitalVenta.Text)                          'Monto capital Venta
    .swVCodAmoCapital = Val(Trim(Right(oFormulario.cmbAmortizaCapitalVendemos, 10)))    'Codigo tipo de amortizacion Tasa
    .swVMesAmoCapital = nDiasCapital#                                       'Valor de meses
    .swVCodAmoInteres = Val(Trim(Right(oFormulario.cmbAmortizaInteresVendemos, 10)))    'Codigo tipo amortizacion de interes
    .swVMesAmoInteres = nDiasInteres#                                       'Valor de meses
    .swVBase = SacaCodigo(oFormulario.cmbBaseVenta)                                                 'Monto Base Venta
    .swVMontoCLP = 0                                                        'Monto Venta en Pesos
    .swVMontoUSD = 0                                                        'Monto Venta en moneda pactada
    .swVCodigoTasa = SacaCodigo(oFormulario.cmbTasaVenta)                               'Codigo de tasa Venta
    .swVSpread = CDbl(oFormulario.txtSpreadVenta.Text)
    .swPagMoneda = SacaCodigo(oFormulario.cmbMonedaPagamos)                             'Codigo Moneda Pagamos
    .swPagDocumento = SacaCodigo(oFormulario.cmbDocumentoPagamos)                          'Codigo documento Pagamos
    
    '***   CH = Cartera Historica
    For i = 1 To oFormulario.fgFlujosVenta.Rows - 1
    
        If oFormulario.fgFlujosVenta.TextMatrix(i, 1) <> "" Then
            
            .swNumFlujo = oFormulario.fgFlujosVenta.TextMatrix(i, 0)                                               'Correlativo de la Operacion
            If oFormulario.fgFlujosVenta.TextMatrix(i, 9) = "" Then
               .swFechaInicioFlujo = oFormulario.txtFecInicio.Text
            Else
               .swFechaInicioFlujo = oFormulario.fgFlujosVenta.TextMatrix(i, 9)
            End If
            .swFechaVenceFlujo = oFormulario.fgFlujosVenta.TextMatrix(i, 1)

            .swTipoFlujo = 2
            .swVAmortiza = CDbl(oFormulario.fgFlujosVenta.TextMatrix(i, 2))       'Monto Amortizado en Venta
            If oFormulario.fgFlujosVenta.TextMatrix(i, 8) = "" Then
               .swVSaldo = 0
            Else
               .swVSaldo = CDbl(oFormulario.fgFlujosVenta.TextMatrix(i, 8))          'Monto no amortizado (Saldo) en Venta
            End If
            If oFormulario.fgFlujosVenta.TextMatrix(i, 4) = "" Then
               .swVInteres = 0
            Else
               .swVInteres = CDbl(oFormulario.fgFlujosVenta.TextMatrix(i, 4))        'Monto Interes de Compra
            End If
            .swVSpread = CDbl(oFormulario.txtSpreadVenta.Text)
            .swVValorTasa = CDbl(oFormulario.txtTasaVenta.Text)
            .swVValorTasaHoy = .swVValorTasa                                'Valor Tasa del dia
            If oFormulario.fgFlujosVenta.TextMatrix(i, 10) = "" Then
               .swPagMonto = 0
            Else
               .swPagMonto = CDbl(oFormulario.fgFlujosVenta.TextMatrix(i, 10))
            End If
            If oFormulario.fgFlujosVenta.TextMatrix(i, 11) = "" Then
               .swPagMontoUSD = 0
            Else
               .swPagMontoUSD = CDbl((oFormulario.fgFlujosVenta.TextMatrix(i, 11)))
            End If
            If oFormulario.fgFlujosVenta.TextMatrix(i, 12) = "" Then
               .swPagMontoCLP = 0
            Else
               .swPagMontoCLP = CDbl((oFormulario.fgFlujosVenta.TextMatrix(i, 12)))
            End If
            .swEstadoFlujo = 1
            .swModalidadPago = Right(oFormulario.fgFlujosVenta.TextMatrix(i, 6), 1)
            
            .ParidadCompra = oFormulario.txtValorMonedaCompra.Text
            .ParidadVenta = oFormulario.txtValorMonedaVenta.Text
            
            fecInteres = oFormulario.fgFlujosVenta.TextMatrix(i, 1)

            If Not .Grabar Then
               If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                  MsgBox "Problemas al deshacer la operación", vbCritical, Msj
                  Set objGrabaSwap = Nothing
                  Exit Function
               End If
               MsgBox "No terminó proceso de ingreso de datos", vbCritical, Msj
               Set objGrabaSwap = Nothing
               Exit Function
            End If
        End If
    Next i

   If Not Lineas_GrbOperacion(Sistema, CDbl(OP_SWAP_MONEDAS), .swNumOperacion, CDbl(.swNumOperacion), " ", cCheque, MercadoLc) Then
      If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
         MsgBox "Problemas en Procedimientos al Grabar Lineas Operacion ", vbCritical, Msj
         Set objGrabaSwap = Nothing
         Exit Function
      End If
    Else
        If MarcaAplicaLinea = 1 Then
            '+++CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
            Dim oParametrosLineaSwapMoneda As New clsControlLineaIDD
            
            With oParametrosLineaSwapMoneda
                .Modulo = Sistema
                .Producto = CDbl(OP_SWAP_MONEDAS)
                .Operacion = objGrabaSwap.swNumOperacion
                .Documento = objGrabaSwap.swNumOperacion
                .Correlativo = 0
                .Accion = "Y"
            
            .RecuperaDatosLineaIDD
            
            .MontoArticulo84 = gblSW_MontoReserva 'monto asignado art84 según funcion
            
            .EjecutaProcesoWsLineaIDD
            
            End With
            Set oParametrosLineaSwapMoneda = Nothing
            On Error GoTo seguirGbrSwapMoneda 'debe seguir con el proceso bac
            '---CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
        End If
   End If
     
seguirGbrSwapMoneda:
   '********** Linea -- Mkilo
   Mensaje_Lin = ""
   Mensaje_Lim = ""
   If gsBac_Lineas = "S" Then
      Mensaje_Lin = Lineas_Error(Sistema, .swNumOperacion)
      Mensaje_Lim = Limites_Error(Sistema, .swNumOperacion)
   End If
    
   Envia = Array()
   AddParam Envia, .swNumOperacion
   AddParam Envia, Trim(Mensaje_Lin)
   AddParam Envia, Trim(Mensaje_Lim)
   
   If Not Bac_Sql_Execute("SP_GRABAOBSERVACIONLINEAS", Envia) Then
      If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
         MsgBox "Problemas al Grabar Observacion Lineas." & vbCrLf & "no ha sido posible deshacer la operación", vbCritical, Msj
         Set objGrabaSwap = Nothing
         Exit Function
      End If
      MsgBox "Problemas al Grabar Observacion Lineas", vbCritical, Msj
   End If
  
   If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
      MsgBox "Problemas al grabar datos", vbCritical, Msj
      Set objGrabaSwap = Nothing
      Exit Function
   End If

End With

Set objGrabaSwap = Nothing
GrabarSwapMonedas = True

End Function


Function GrabarDatosST() As Boolean
Dim objGrabaSwap As New ClsMovimSwaps
Dim SQL As String
Dim i, Actualiza As Integer
Dim Datos()
Dim fecInteres As String
Dim Hasta As Long
Dim NumOP As String

'********************************************************************
'* Rutina que graba los datos de operaciones nuevas y Operaciones Modificadas *
'********************************************************************
GrabarDatosST = False

With objGrabaSwap
'hacer begin transaction

    SQL = "BEGIN TRANSACTION"
    
    If MISQL.SQL_Execute(SQL) <> 0 Then
         Set objGrabaSwap = Nothing
        Exit Function
    End If
    
    If cOperSwapST = "Ingreso" Then
    
        'Saca numero de ultima operacion
        SQL = " Exec SP_ULTIMAOPERACION " _
              & "'" & Sistema & "', '" & Entidad & "' "
        
        If MISQL.SQL_Execute(SQL) <> 0 Then
            MsgBox "Problemas para crear número de Operación!", vbCritical, Msj
            Exit Function
            
        Else
            If MISQL.SQL_Fetch(Datos()) = 0 Then
                .swNumOperacion = Val(Datos(1))            'Numero de la Operacion
            Else
                .swNumOperacion = 1                              'Primera Operacion creada
            End If
            
            NumOP = .swNumOperacion
            
        End If
        
        nNumoperST = .swNumOperacion
        FechaCierre = gsBAC_Fecp
        Actualiza = 1
        
    ElseIf cOperSwapST = "Modificacion" Or cOperSwapST = "ModificacionCartera" Then
        'modificaciones del diario o de vigentes
        SQL = " Exec SP_MODIFICASWAPS " _
              & nNumoperST & ", '" & Format(gsBAC_Fecp, "yyyymmdd") & "','" _
              & Format(Time, "HH:MM:SS") & "'"
         If MISQL.SQL_Execute(SQL) <> 0 Then
            MsgBox "Problemas al verificar Operación a modificar!", vbCritical, Msj
            Exit Function
        End If
        
        .swNumOperacion = nNumoperST
         NumOP = nNumoperST
        Actualiza = IIf(cOperSwapST = "Modificacion", 1, 2)   'Si actualizara la tabla de MovDiario
        ' La fecha de cierre se recupero en funcion BuscarDatos, variable FechaCierre
         Call Lineas_Anular(Sistema, CDbl(.swNumOperacion))  'Primero Anula Monto Anterior
         
            Dim oParametrosLineaAnula As New clsControlLineaIDD
            '+++CONTROL IDD, jcamposd anula toma de linea
            With oParametrosLineaAnula
                .Modulo = Sistema
                .Producto = CStr(MiTipoSwap)
                .Operacion = nNumoperST
                .Documento = nNumoperST
                .Correlativo = 0
                .Accion = "R"
            
                .RecuperaDatosLineaIDD
                If .numeroiddAnula <> 0 Then
                    .EjecutaProcesoWsLineaIDD
                End If
                
            End With
            
            Set oParametrosLineaAnula = Nothing
            On Error GoTo seguirAnulacionModi 'debe seguir con la transaccion BAC
            '---CONTROL IDD, jcamposd anula toma de linea
         
    End If
    
seguirAnulacionModi:
    
   If gsBac_Lineas = "S" Then

        Dim Mensaje     As String
        Dim cCheque     As String
        Dim nRutCheque  As Double
        Dim Mensaje_Con As String
        Dim SwResp      As Integer
        Dim CodMonOp1    As Double
        Dim MercadoLc   As String
      
        Dim Mensaje_Lin As String
        Dim Mensaje_Lim As String
        Dim MontoCapDolar As Double
        Dim CodMonOp    As Integer

        If Tipo_Producto = "SP" Then
            CodMonOp = SacaCodigo(oFormulario.CMBMoneda)
            MontoCapDolar = oFormulario.txtCapital.Text
            cCheque = "N"
            nRutCheque = 0
            Mensaje = ""
        Else
            CodMonOp = SacaCodigo(oFormulario.CMBMoneda)
            MontoCapDolar = CDbl(oFormulario.txtCapital.Text) 'ValorMontoADolar(CDbl(oFormulario.txtCapital.Text), CodMonOp, gsBAC_Fecp)
            cCheque = "N"
            nRutCheque = 0
            Mensaje = ""
        End If
        
        If Not Lineas_ChequearGrabar(Sistema, CStr(MiTipoSwap), CDbl(.swNumOperacion), 0, 0, _
                                     CDbl(TxtRut.Tag), CDbl(txtCliente.Tag), MontoCapDolar, 0, _
                                     CDate(oFormulario.txtFecTerminoRecibimos.Text), 0, 0, CDate(gsBAC_Fecp), 0, "N", _
                                     CDbl(CodMonOp), "C", 0, cCheque, nRutCheque, _
                                     CDate(gsBAC_Fecp), 0, CDbl(SacaCodigo(oFormulario.cmbDocumentoRecibimos)), 0, 0) Then 'PROD-10967
        
            SQL = "ROLLBACK TRANSACTION"
            
            If MISQL.SQL_Execute(SQL) <> 0 Then
                MsgBox "Problemas en Procedimientos de Lineas", vbCritical, Msj
                Exit Function
                
            End If
            
            Exit Function
            
        End If
                
        If nPaisOrigenST = 6 Then
           MercadoLc = "S"
        Else
           MercadoLc = "N"
        End If
           
           
        'Si Acepta y Tiene Errores Sigue Normal
        Mensaje = Mensaje & Lineas_Chequear(Sistema, 1, .swNumOperacion, " ", cCheque, MercadoLc)
                
        If Mensaje <> "" Then
            MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical, Msj
            SQL = "ROLLBACK TRANSACTION"
            
            If MISQL.SQL_Execute(SQL) <> 0 Then
                Set objGrabaSwap = Nothing
                Exit Function
                
            End If
         
        End If
    
    End If

    'Datos Generales
    .swActualizar = Actualiza
    .swTipoSwap = MiTipoSwap                                                             'Tipo de Swap (Tasa - Monedas)
    .swCarteraInversion = Trim(Right(cmbCartera, 10))                               'Codigo de Cartera de Inversion
    .swTipoOperacion = OperacionST                                                'Tipo de Operacion (Compra-Venta)
    .swCodCliente = IIf(txtCliente.Tag = "", 0, txtCliente.Tag)                 'Codigo cliente
    .swRutCliente = IIf(TxtRut.Tag = "", 0, TxtRut.Tag)                         'Codigo cliente
    .swFechaCierre = FechaCierre                                                'Fecha del dia en que se realiza operacion
    .swObservaciones = Trim(TxtObservaciones.Text)
    .swFechaModifica = gsBAC_Fecp
    .swOperador = Left(gsBAC_User$, 10)                                         'ingresa nombre usuario con max. de 10 caract.
    .swOperadorCliente = SacaCodigo(CmbOperador)                                'Codigo del Operador
        
    'Datos Solicitados por la Compra
    .swCMoneda = SacaCodigo(oFormulario.CMBMoneda)                                          'Moneda de Compra
    .swCCapital = CDbl(oFormulario.txtCapital.Text)                                         'Monto Capital
    .swCCodAmoCapital = Val(Trim(Right(oFormulario.cmbAmortizaCapitalRecibimos, 10)))       'Codigo tipo amortizacion de capital
    .swCMesAmoCapital = ValorAmort(oFormulario.cmbAmortizaCapitalRecibimos, DesgloseAmortST)  'Valor de meses
    .swCCodAmoInteres = Val(Trim(Right(oFormulario.cmbAmortizaInteresRecibimos, 10)))       'Codigo tipo amortizacion de interes
    .swCMesAmoInteres = ValorAmort(oFormulario.cmbAmortizaInteresRecibimos, DesgloseAmortST)  'Valor de meses
    .swCBase = SacaCodigo(oFormulario.cmbBaseCompra)                                        'Monto base Compra
    .swCCodigoTasa = SacaCodigo(oFormulario.cmbTasaCompra)                                  'Codigo de tasa compra
    .swRecMoneda = SacaCodigo(oFormulario.cmbMonedaRecibimos)                               'Codigo Moneda Recibimos
    .swRecDocumento = SacaCodigo(oFormulario.cmbDocumentoRecibimos)                         'Codigo Documento Recibimos
    .swCSpread = oFormulario.txtSpreadCompra.Text                                           'Valor Spread
    .swCCodigoTasa = SacaCodigo(oFormulario.cmbTasaCompra)                                  'Codigo de tasa compra
    .swEspecial = oFormulario.cmbEspecialRecibimos.ItemData(oFormulario.cmbEspecialRecibimos.ListIndex)
    
    .swAreaResp = Trim(Right(Me.CmbArea.Text, 10))
    .swCartNorm = Trim(Right(CmbCartNorm.Text, 10))
    .swSubCartNorm = Trim(Right(CmbSubCartera.Text, 10))
    .swLibro = Trim(Right(CmbLibro.Text, 10))
    .swObservacion = Trim(TxtObservaciones.Text)
   
    'Datos Solicitados por la Venta
    .swVMoneda = 0                                                              'Codigo Moneda de Venta
    .swVCapital = 0                                                             'Monto capital Venta
    .swVCodAmoCapital = 0                                                       'Codigo tipo de amortizacion Tasa
    .swVMesAmoCapital = 0                                                       'Valor de meses
    .swVCodAmoInteres = 0                                                       'Codigo tipo amortizacion de interes
    .swVMesAmoInteres = 0                                                       'Valor de meses
    .swVBase = 0                                                                'Monto Base Venta
    .swVSpread = 0
    .swCMontoCLP = 0                                                            'Monto compra en Pesos
    .swCMontoUSD = 0                                                            'Monto Compra en moneda pactada
    .swVMontoCLP = 0                                                            'Monto Venta en Pesos
    .swVMontoUSD = 0                                                            'Monto Venta en moneda pactada
    .swPagMonto = 0
    .swPagMontoUSD = 0
    .swPagMontoCLP = 0
    .swVAmortiza = 0                                                            'Monto Amortizado en Venta
    .swVSaldo = 0                                                               'Monto no amortizado (Saldo) en Venta
    .swVInteres = 0                                                             'Monto Interes de Compra
    .swVValorTasa = 0                                                           'Valor Tasa Venta
    .swVValorTasaHoy = 0                                                        'Valor Tasa del dia
    .swPagMoneda = 0                                                            'Codigo Moneda Pagamos
    .swPagDocumento = 0                                                         'Codigo documento Pagamos
    .swVCodigoTasa = 0                                                          'Codigo de tasa Venta
    
    
    'Se Graban Los Flujos Recibimos
    For i = 1 To oFormulario.grdRecibimos.Rows - 1
    
        If oFormulario.grdRecibimos.TextMatrix(i, 13) <> "CH" Then
      
            .swTipoFlujo = 1
            .swNumFlujo = oFormulario.grdRecibimos.TextMatrix(i, 0)                 'Correlativo de la Operacion
            .swFechaInicioFlujo = oFormulario.grdRecibimos.TextMatrix(i, 9)         'fecInteres
            .swFechaVenceFlujo = oFormulario.grdRecibimos.TextMatrix(i, 1)
            .swCAmortiza = CDbl(oFormulario.grdRecibimos.TextMatrix(i, 2))          'Monto amortizado en Compra
            .swCSaldo = CDbl(oFormulario.grdRecibimos.TextMatrix(i, 8))             'Monto no amortizado (Saldo) en compra
            .swCInteres = CDbl(oFormulario.grdRecibimos.TextMatrix(i, 4))           'Monto Interes de Compra
            .swCSpread = CDbl(oFormulario.txtSpreadCompra.Text)
            .swCValorTasa = CDbl(oFormulario.txtTasaCompra.Text)                    ' .FormatNum(grdRecibimos.TextMatrix(i, 3))                'Valor Tasa
            .swCValorTasaHoy = .swCValorTasa                            'Valor Tasa del dia
            .swRecMonto = CDbl(oFormulario.grdRecibimos.TextMatrix(i, 10))
            .swRecMontoUSD = CDbl(oFormulario.grdRecibimos.TextMatrix(i, 11))
            .swRecMontoCLP = CDbl(oFormulario.grdRecibimos.TextMatrix(i, 12))
            .swFechaFijacionTasa = oFormulario.grdRecibimos.TextMatrix(i, 14)
            .swEstadoFlujo = 1
            .swModalidadPago = Right(oFormulario.grdRecibimos.TextMatrix(i, 6), 1)
            .swVCapital = 0
            .swFechaInicio = oFormulario.txtFecInicioRecibimos.Text                                          'Fecha Primer Vencimiento
            .swFechaTermino = oFormulario.txtFecTerminoRecibimos.Text                                        'Fecha Termino amortizacion
            
            
            If Not .Grabar Then
            
                SQL = "ROLLBACK TRANSACTION"
                
                If MISQL.SQL_Execute(SQL) <> 0 Then
                    MsgBox "Problemas al deshacer la operación", vbCritical, Msj
                    Exit Function
                End If
                
                MsgBox "No terminó proceso de ingreso de datos", vbCritical, Msj
                Exit Function
            End If
        End If
    Next

    'Datos Solicitados por la Compra
    .swCMoneda = 0                                                              'Moneda de Compra
    .swCCapital = 0                                                             'Monto Capital
    .swCCodAmoCapital = 0                                                       'Codigo tipo amortizacion de capital
    .swCMesAmoCapital = 0                                                       'Valor de meses
    .swCCodAmoInteres = 0                                                       'Codigo tipo amortizacion de interes
    .swCMesAmoInteres = 0                                                       'Valor de meses
    .swCBase = 0                                                                'Monto base Compra
    .swCCodigoTasa = 0                                                          'Codigo de tasa compra
    .swRecMoneda = 0                                                            'Codigo Moneda Recibimos
    .swRecDocumento = 0                                                         'Codigo Documento Recibimos
    .swCSpread = 0                                                              'Valor Spread
    .swCAmortiza = 0                                                            'Monto amortizado en Compra
    .swCSaldo = 0                                                               'Monto no amortizado (Saldo) en compra
    .swCInteres = 0                                                             'Monto Interes de Compra
    .swCSpread = 0                                                              'Valor Tasa
    .swCValorTasa = 0
    .swCValorTasaHoy = 0                                                        'Valor Tasa del dia
    .swRecMonto = 0
    .swRecMontoUSD = 0
    .swRecMontoCLP = 0
    .swCCodigoTasa = 0
        
    'Datos Solicitados por la Venta
    .swVMoneda = SacaCodigo(oFormulario.CMBMoneda)                                          'Codigo Moneda de Venta
    .swVCapital = CDbl(oFormulario.txtCapital.Text)                                   'Monto capital Venta
    .swVCodAmoCapital = Val(Trim(Right(oFormulario.cmbAmortizaCapitalPagamos, 10)))         'Codigo tipo de amortizacion Tasa
    .swVMesAmoCapital = ValorAmort(oFormulario.cmbAmortizaCapitalPagamos, DesgloseAmortST)    'Valor de meses
    .swVCodAmoInteres = Val(Trim(Right(oFormulario.cmbAmortizaInteresPagamos, 10)))         'Codigo tipo amortizacion de interes
    .swVMesAmoInteres = ValorAmort(oFormulario.cmbAmortizaInteresPagamos, DesgloseAmortST)    'Valor de meses
    .swVBase = SacaCodigo(oFormulario.cmbBaseVenta)                                         'Monto Base Venta
    .swVSpread = CDbl(oFormulario.txtSpreadVenta.Text)
    .swPagMoneda = SacaCodigo(oFormulario.cmbMonedaPagamos)                                 'Codigo Moneda Pagamos
    .swPagDocumento = SacaCodigo(oFormulario.cmbDocumentoPagamos)                           'Codigo documento Pagamos
    .swVCodigoTasa = SacaCodigo(oFormulario.cmbTasaVenta)                                   'Codigo de tasa Venta
    .swEspecial = oFormulario.cmbEspecialPagamos.ItemData(oFormulario.cmbEspecialPagamos.ListIndex)
    .swCMontoCLP = 0                                                                                'Monto compra en Pesos
    .swCMontoUSD = 0                                                                                'Monto Compra en moneda pactada
    .swVMontoCLP = 0                                                                                'Monto Venta en Pesos
    .swVMontoUSD = 0                                                                                'Monto Venta en moneda pactada

    'Se Graban Los Flujos Pagamos
    For i = 1 To oFormulario.grdPagamos.Rows - 1
    
        If oFormulario.grdPagamos.TextMatrix(i, 13) <> "CH" Then
        
            .swTipoFlujo = 2
            .swNumFlujo = oFormulario.grdPagamos.TextMatrix(i, 0)                           'Correlativo de la Operacion
            .swFechaInicioFlujo = oFormulario.grdPagamos.TextMatrix(i, 9)                   'fecInteres
            .swFechaVenceFlujo = oFormulario.grdPagamos.TextMatrix(i, 1)
            .swPagMonto = CDbl(oFormulario.grdPagamos.TextMatrix(i, 10))
            .swPagMontoUSD = CDbl(oFormulario.grdPagamos.TextMatrix(i, 11))
            .swPagMontoCLP = CDbl(oFormulario.grdPagamos.TextMatrix(i, 12))
            .swVAmortiza = CDbl(oFormulario.grdPagamos.TextMatrix(i, 2))               'Monto Amortizado en Venta
            .swVSaldo = CDbl(oFormulario.grdPagamos.TextMatrix(i, 8))                  'Monto no amortizado (Saldo) en Venta
            .swVInteres = CDbl(oFormulario.grdPagamos.TextMatrix(i, 4))                'Monto Interes de Compra
            .swVSpread = CDbl(oFormulario.txtSpreadVenta.Text)
            .swVValorTasa = CDbl(oFormulario.txtTasaVenta.Text)                        '.FormatNum(grdPagamos.TextMatrix(i, 3))                    'Valor Tasa Venta
            .swVValorTasaHoy = .swVValorTasa                                     'Valor Tasa del dia
            .swFechaInicio = oFormulario.txtFecInicioPagamos.Text                                          'Fecha Primer Vencimiento
            .swFechaTermino = oFormulario.txtFecTerminoPagamos.Text                                        'Fecha Termino amortizacion
            .swEstadoFlujo = 1
            .swModalidadPago = Right(oFormulario.grdPagamos.TextMatrix(i, 6), 1)
            .swFechaFijacionTasa = oFormulario.grdPagamos.TextMatrix(i, 14)
        
            If Not .Grabar Then
            
                SQL = "ROLLBACK TRANSACTION"
                
                If MISQL.SQL_Execute(SQL) <> 0 Then
                    MsgBox "Problemas al deshacer la operación", vbCritical, Msj
                    Exit Function
                    
                End If
                
                MsgBox "No terminó proceso de ingreso de datos", vbCritical, Msj
                Exit Function
            End If
        End If
    Next
    

    If Not Lineas_GrbOperacion(Sistema, CStr(MiTipoSwap), .swNumOperacion, CDbl(.swNumOperacion), " ", cCheque, MercadoLc) Then
       SQL = "ROLLBACK TRANSACTION"
       If MISQL.SQL_Execute(SQL) <> 0 Then
          MsgBox "Problemas en Procedimientos al Grabar Lineas Operacion ", vbCritical, Msj
          Set objGrabaSwap = Nothing
          Exit Function
       End If
    Else
        If MarcaAplicaLinea = 1 Then
            '+++CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
            Dim oParametrosLineaSt As New clsControlLineaIDD
            
            With oParametrosLineaSt
                .Modulo = Sistema
                .Producto = CStr(MiTipoSwap)
                .Operacion = objGrabaSwap.swNumOperacion
                .Documento = objGrabaSwap.swNumOperacion
                .Correlativo = 0
                .Accion = "Y"
            
            .RecuperaDatosLineaIDD
            
            .MontoArticulo84 = gblSW_MontoReserva 'monto asignado art84 según funcion
            
            .EjecutaProcesoWsLineaIDD
            End With
            Set oParametrosLineaSt = Nothing
            On Error GoTo seguirprocesoGbrSt 'debe serguir con proceso BAC
            '---CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
        End If
    End If
  
seguirprocesoGbrSt:

    '********** Linea -- Mkilo
    Mensaje_Lin = ""
    Mensaje_Lim = ""
       
    If gsBac_Lineas = "S" Then
        Mensaje_Lin = Lineas_Error(Sistema, .swNumOperacion)
        Mensaje_Lim = Limites_Error(Sistema, .swNumOperacion)
        
    End If
    
    Envia = Array()
    AddParam Envia, .swNumOperacion
    AddParam Envia, Trim(Mensaje_Lin)
    AddParam Envia, Trim(Mensaje_Lim)
    
    If Not Bac_Sql_Execute("SP_GRABAOBSERVACIONLINEAS", Envia) Then
          MsgBox "Problemas al Grabar Observacion Lineas", vbCritical, Msj
          SQL = "ROLLBACK TRANSACTION"
          
          If MISQL.SQL_Execute(SQL) <> 0 Then
              MsgBox "Problemas al deshacer la operación", vbCritical, Msj
              Set objGrabaSwap = Nothing
              Exit Function
              
          End If
                      
    End If
    
    SQL = "COMMIT TRANSACTION"
    If MISQL.SQL_Execute(SQL) <> 0 Then
        MsgBox "Problemas al grabar datos", vbCritical, Msj
        Set objGrabaSwap = Nothing
        Exit Function
    End If

End With

MsgBox "Operación N° " & NumOP & " fué grabada con Exito!", vbInformation, Msj
Set objGrabaSwap = Nothing
GrabarDatosST = True

End Function


Function ValidaDatos()
   Dim nVecesCap As Integer
   Dim nVecesInt As Integer
   Dim nRes      As Integer
  
   ValidaDatos = False
  
'   Call HabilitaPanles(False)

   If Not ChequeaCierreMesa() Then
      MsgBox "No se puede Grabar Operacion, Mesa de Dinero está Cerrada!!!", vbExclamation, Msj
      Exit Function
   End If
   If oFormulario.cmbMonedaCompra.ListIndex = -1 Or oFormulario.cmbMonedaVenta.ListIndex = -1 Then
      MsgBox "No ha indicado las Monedas a Transar", vbInformation, Msj
      If oFormulario.cmbMonedaCompra.Enabled = True Then
         oFormulario.cmbMonedaCompra.SetFocus
      Else
         oFormulario.cmbMonedaVenta.SetFocus
      End If
      Exit Function
   End If
   If Trim(oFormulario.txtCapitalCompra.Text) = 0 Or Trim(oFormulario.txtCapitalCompra.Text) = 0 Then
      MsgBox "No a ingresado los Montos de Capital", vbInformation, Msj
      oFormulario.txtCapitalCompra.SetFocus
      Exit Function
   End If
   If oFormulario.cmbTasaCompra.ListIndex = -1 Then
      MsgBox "No ha definido el Tipo de Tasa", vbInformation, Msj
      oFormulario.cmbTasaCompra.SetFocus
      Exit Function
   End If
   If oFormulario.cmbTasaVenta.ListIndex = -1 Then
      MsgBox "No ha definido el Tipo de Tasa", vbInformation, Msj
      oFormulario.cmbTasaVenta.SetFocus
      Exit Function
   End If
   If Trim(oFormulario.txtTasaCompra.Text) = 0 Or Trim(oFormulario.txtTasaCompra.Text) = 0 Then
      MsgBox "Debe Ingresar valor de Tasas para realizar Cálculo", vbInformation, Msj
      oFormulario.txtTasaCompra.SetFocus
      Exit Function
   End If
   If oFormulario.cmbBaseCompra.ListIndex = -1 Then
      MsgBox "No ha definido la Base de Cálculo", vbInformation, Msj
      oFormulario.cmbBaseCompra.SetFocus
      Exit Function
   End If
   If oFormulario.cmbBaseVenta.ListIndex = -1 Then
      MsgBox "No ha definido la Base de Cálculo", vbInformation, Msj
      oFormulario.cmbBaseVenta.SetFocus
      Exit Function
   End If
   If oFormulario.cmbAmortizaInteresCompramos.ListIndex = -1 Then
      MsgBox "No a definido los períodos de Amortización Compra", vbInformation, Msj
      oFormulario.cmbAmortizaInteresCompramos.SetFocus
      Exit Function
   End If
   If oFormulario.cmbAmortizaInteresVendemos.ListIndex = -1 Then
      MsgBox "No a definido los períodos de Amortización Venta", vbInformation, Msj
      oFormulario.cmbAmortizaInteresVendemos.SetFocus
      Exit Function
   End If
   If oFormulario.cmbAmortizaCapitalCompramos.ListIndex = -1 Then
      MsgBox "No a definido los periodos de Amortización Compras", vbInformation, Msj
      oFormulario.cmbAmortizaCapitalCompramos.SetFocus
      Exit Function
   End If
   If oFormulario.cmbAmortizaCapitalVendemos.ListIndex = -1 Then
      MsgBox "No a definido los periodos de Amortización Ventas", vbInformation, Msj
      oFormulario.cmbAmortizaCapitalVendemos.SetFocus
      Exit Function
   End If
   If Not BacEsHabil(CStr(oFormulario.txtFecInicio.Text)) Then
      MsgBox "Fecha de Inicio no es día hábil", vbCritical, Msj
      oFormulario.txtFecInicio.SetFocus
      oFormulario.MousePointer = vbDefault
      Exit Function
   End If
   If Not BacEsHabil(CStr(oFormulario.txtFecPrimerVcto.Text)) Then
      MsgBox "Fecha Primer Vencimiento de Capital no es día Hábil", vbCritical, Msj
      oFormulario.txtFecPrimerVcto.SetFocus
      oFormulario.MousePointer = vbDefault
      Exit Function
   End If
   If Not BacEsHabil(CStr(oFormulario.txtFecTermino.Text)) Then
      MsgBox "Fecha de Término no es día hábil", vbCritical, Msj
      oFormulario.txtFecTermino.SetFocus
      oFormulario.MousePointer = vbDefault
      Exit Function
   End If
   If CDate(oFormulario.txtFecInicio.Text) = CDate(oFormulario.txtFecTermino.Text) Then
      MsgBox "Fecha Inicio no  puede ser igual a Fecha de Término", vbInformation, Msj
      oFormulario.txtFecTermino.SetFocus
      Exit Function
   End If
   If CDate(oFormulario.txtFecPrimerVcto.Text) > CDate(oFormulario.txtFecTermino.Text) Then
      MsgBox "Fecha Primer Vencimiento NO puede ser posterior a la de Término", vbInformation, Msj
      oFormulario.txtFecTermino.SetFocus
      Exit Function
   End If
   
   ValidaDatos = True

End Function
Private Sub optNoAplicaThr_Click(Value As Integer)
    Thr_AplicaThreshold = False
End Sub
Private Sub optSiAplicaThr_Click(Value As Integer)
Thr_AplicaThreshold = True
End Sub

Private Sub TlbHerramientas_ButtonClick(ByVal Button As ComctlLib.Button)
   Dim OP_Curso As New Swap_OP 'PROD-10967
   Select Case Button.Index
      Case 1
         Call cmdGrabar_Click
      Case 2
         GLB_bCancelar = True
         Unload Me
      Case 3 'PROD-10967
      
     
         EjecutaBtnREC = True
         If TxtRut.Text = "" Or txtCliente.Text = "" Then   '-- Control de Cliente
            MsgBox "Debe Ingresar datos del Cliente", vbExclamation, Msj
            TxtRut.SetFocus
            Screen.MousePointer = vbDefault
            EjecutaBtnREC = False
            Exit Sub
         End If
         FRM_DETALLE_LCR.Show vbModal
        
         
   End Select

End Sub

Private Sub cmdGrabar_Click()

   Screen.MousePointer = vbHourglass
    
   'PROD-10967
    If MiFormulario = "Nuevo Swap" Then
            Proc_Valida_Moneda_Swap_LCR FRM_SWAP_OP
    ElseIf MiFormulario = "Nuevo Fra" Then
             Proc_Valida_Moneda_Fra_LCR FRM_SWAP_OP_FRA
    End If
    
    If ParamMoneda_LCR = True Then
         ParamMoneda_LCR = False
         Screen.MousePointer = vbDefault
         'Exit Sub '20120112 MAP al revisar grabacion de Swap sin moneda parametrizada en REC.
    End If
    'PROD-10967
    
      If TxtRut.Text = "" Or txtCliente.Text = "" Then   '-- Control de Cliente
         MsgBox "Debe Ingresar datos del Cliente", vbExclamation, Msj
         TxtRut.SetFocus
         Screen.MousePointer = vbDefault
         EjecutaBtnREC = False 'PROD-10967
         Exit Sub
      End If
      
      
    If Frame1.Visible = True Then
        If ValidaDatosTicket Then
            If ValidaDatosCyM Then
                gnCodCarteraOrigen = Trim(Right(cmbCarteraOrig.Text, 2)) 'Right(cmbCarteraOrig.Text, 2)
                gnCodMesaOrigen = Trim(Right(CmbMesaOrg.Text, 2))
                gnCodCarteraDestino = cmbCarteraDest.ItemData(cmbCarteraDest.ListIndex) 'Right(cmbCarteraDest.Text, 2)
                gnCodMesaDestino = Trim(Right(CmbMesaDest.Text, 2))
            Else
                MsgBox "Las Mesas y las carteras no pueden ser iguales", vbInformation, TITSISTEMA
                Screen.MousePointer = vbDefault
                Exit Sub
            End If
        Else
            Screen.MousePointer = vbDefault
            Exit Sub
        End If
    Else
      If CmbArea.ListIndex = -1 Then
         Screen.MousePointer = vbDefault
         MsgBox "Debe seleccionar el area responsable", vbExclamation + vbOKOnly, Msj
         CmbArea.SetFocus
         Exit Sub
      End If
      
      If cmbCartera.ListIndex = -1 Then
         Screen.MousePointer = vbDefault
         MsgBox "Debe seleccionar la cartera financiera", vbExclamation + vbOKOnly, Msj
         cmbCartera.SetFocus
         Exit Sub
      End If
      
      If CmbCartNorm.ListIndex = -1 Then
         Screen.MousePointer = vbDefault
         MsgBox "Debe seleccionar la cartera normativa", vbExclamation + vbOKOnly, Msj
         CmbCartNorm.SetFocus
         Exit Sub
      End If
      
      If CmbSubCartera.ListIndex = -1 Then
         Screen.MousePointer = vbDefault
         MsgBox "Debe seleccionar la sub cartera financiera", vbExclamation + vbOKOnly, Msj
         CmbSubCartera.SetFocus
         Exit Sub
      End If
      
      If CmbLibro.ListIndex = -1 Then
         Screen.MousePointer = vbDefault
         MsgBox "Debe seleccionar el libro", vbExclamation + vbOKOnly, Msj
         CmbLibro.SetFocus
         Exit Sub
      End If
    End If
      
   'Ini 22-12-2009
      auxUser = gsBAC_User
      If cboOperador.Enabled And cboOperador.ListIndex = -1 Then
        Screen.MousePointer = vbDefault
        MsgBox "Debe seleccionar el Operador de la Transacción", vbExclamation
        cboOperador.SetFocus
        Exit Sub
      End If
      If cboOperador.Enabled Then
        grabaOperador = True
        actDigitador = True
        gsBAC_User = Trim(Mid$(cboOperador.Text, 111))
        gsusuario = gsBAC_User
      Else
        grabaOperador = False
        actDigitador = True
      End If
   'fin 22-12-2009
      
      
   'PRD-4858, 12-02-2010
   If Thr_Cotizacion = False Then
      If fraThreshold.Enabled = True Then
         If optSiAplicaThr.Value = False And optNoAplicaThr.Value = False Then
            Screen.MousePointer = vbDefault
            gsBAC_User = auxUser
            MsgBox "No ha seleccionado si se aplica o no el Threshold a la operación!", vbExclamation, TITSISTEMA
            Exit Sub
         End If
      End If
      If optSiAplicaThr.Value = True Then
         Thr_AplicaThreshold = True
      ElseIf optNoAplicaThr.Value = True Then
         Thr_AplicaThreshold = False
      End If
      If Thr_AplicaThreshold = True Then
         Thr_RutCliente = RutSinDV(TxtRut.Text)
         Thr_CodCliente = CInt(txtCliente.Tag)
         '--+++CONTROL IDD, jcamposd, se deshabilita controles de línea Threshold en sp
         If Not ClienteCumplePoliticas(CDbl(Thr_RutCliente), Thr_CodCliente, Thr_dPlazoOperacion, Metodologia_Cliente) Then
            Screen.MousePointer = vbDefault
            gsBAC_User = auxUser
            Exit Sub
         End If
      End If
   End If
   'fin PRD-4858
   
   
          'Cambios Artículo 84
          
       If (blnProcesoArt84Activo("PCS")) Then
            If gstrGuardaComo <> "Cotiza" Then
                
                gblSW_MontoReserva = 0 'CONTROL IDD, jcamposd seteo variable en cero
                
                If Not blnValidaNormaArt84(Me.Tag) Then
                    strMsgError = gstrMensajesError ' mensaje obtenido en el proceso WS

                    MsgBox "La Operación no se puede realizar" & vbCrLf & vbCrLf & "El registro no cumple con la Norma Art84, detalle del problema: " & _
                        vbNewLine & "N° de Ticket de la operación : " & glngNroTicket & vbNewLine & vbNewLine & _
                        strMsgGeneral, vbCritical, gsBAC_Version

                    Screen.MousePointer = vbDefault

                    If glngNroTicket > 0 Then
                        Call GeneraConfirmacionProceso(glngNroTicket, 0, "PCS", gstrNrosOperacionesIBS)
                    End If
                    
                    Exit Sub
                End If
            End If
        End If
       'Fin Cambios Artículo 84
                  
        '+++CONTROL IDD, jcamposd marca de control linea IDD
        MarcaAplicaLinea = ChkControlLinea.Value
        '---CONTROL IDD, jcamposd marca de control linea IDD

   
      If MiFormulario = "Nuevo Fra" Then
         FRM_SWAP_OP_FRA.CarteraFinanciera = Val(Trim(Right(cmbCartera.Text, 3)))
         FRM_SWAP_OP_FRA.AreaResponsable = Val(Trim(Right(CmbArea.Text, 3)))
         FRM_SWAP_OP_FRA.LibroNegociacion = Val(Trim(Right(CmbLibro.Text, 3)))
         FRM_SWAP_OP_FRA.CarteraNormativa = Trim(Right(CmbCartNorm.Text, 3))
         FRM_SWAP_OP_FRA.SubCarteraNormativa = Val(Trim(Right(CmbSubCartera.Text, 3)))
         FRM_SWAP_OP_FRA.Observaciones = TxtObservaciones.Text
         FRM_SWAP_OP_FRA.RutCliente = Left(TxtRut.Text, Len(TxtRut.Text) - 2)
         FRM_SWAP_OP_FRA.CodCliente = Val(txtCliente.Tag)
         FRM_SWAP_OP_FRA.iAceptar = True
         
         'Ini 22-12-2009
         If grabaOperador = True Then
            FRM_SWAP_OP_FRA.lblOperador.Caption = gsBAC_User
         Else
            FRM_SWAP_OP_FRA.lblOperador.Caption = ""
         End If
         'Fin 22-12-2009
         
         MiFormulario = ""
         
         'Ini 22-12-2009, reestablecer el usuario original
         gsBAC_User = auxUser
         'fin 22-12-2009
         
         Unload Me
         Exit Sub
      End If
      
      If MiFormulario = "Nuevo Swap" Then
         FRM_SWAP_OP.CarteraFinanciera = Val(Trim(Right(cmbCartera.Text, 3)))
         FRM_SWAP_OP.AreaResponsable = Val(Trim(Right(CmbArea.Text, 3)))
         FRM_SWAP_OP.LibroNegociacion = Val(Trim(Right(CmbLibro.Text, 3)))
         FRM_SWAP_OP.CarteraNormativa = Trim(Right(CmbCartNorm.Text, 3))
         FRM_SWAP_OP.SubCarteraNormativa = Val(Trim(Right(CmbSubCartera.Text, 3)))
         FRM_SWAP_OP.Observaciones = TxtObservaciones.Text
         FRM_SWAP_OP.RutCliente = Left(TxtRut.Text, Len(TxtRut.Text) - 2)
         FRM_SWAP_OP.CodCliente = Val(txtCliente.Tag)
         FRM_SWAP_OP.iAceptar = True
         FRM_SWAP_OP.Lblcheck = Check1.Value
         
         '22-12-2009
         If grabaOperador = True Then
            FRM_SWAP_OP.lblOperador.Caption = gsBAC_User
         Else
            FRM_SWAP_OP.lblOperador.Caption = ""
         End If
         'fin 22-12-2009
         
         MiFormulario = ""
         
         ' 22-12-2009, reestablecer el usuario original
         gsBAC_User = auxUser
         'fin 22-12-2009
         
         Unload Me
         Exit Sub
      End If
      
      If Tipo_Producto = "SM" Then
         If ValidaDatos() Then
            
            If GrabarSwapMonedas() Then
               Screen.MousePointer = vbDefault
               
               
           'Cambios Artículo 84
            
            
            If (blnProcesoArt84Activo("PCS")) Then
            
            
            If (nNumoper > 0) Then
            
            Dim lngNope As Long
            lngNope = nNumoper
                        Call GeneraConfirmacionProceso(glngNroTicket, lngNope, "PCS", gstrNrosOperacionesIBS)
            End If
            
            End If
            
            'Fin Cambios Artículo 84
               
               
               
               
               MsgBox "Operación N°. " & Trim(Str(nNumoper)) & " fue Grabada con Exito", vbInformation, Msj
               
               
               If Right(CmbCartNorm.Text, 1) = "C" Then
                          If MsgBox("Proceso Coberturas." & vbCrLf & vbCrLf & "¿Desea Generar Cobertura para este Derivado?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
                     FRM_MNT_COBERTURA.Derivado = nNumoper
                     FRM_MNT_COBERTURA.Correlativo = 1
                     FRM_MNT_COBERTURA.Modulo = "PCS"
                     FRM_MNT_COBERTURA.Show 1
                  End If
               End If
               
               Unload Me
               
            End If
         End If
      ElseIf Tipo_Producto = "ST" Or Tipo_Producto = "SP" Then
         If ValidaDatosIngreso Then
            If GrabarDatosST Then
               Screen.MousePointer = vbDefault
               
               
               If Right(CmbCartNorm.Text, 1) = "C" Then
                         If MsgBox("Proceso Coberturas." & vbCrLf & vbCrLf & "¿Desea Generar Cobertura para este Derivado?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
                     FRM_MNT_COBERTURA.Derivado = nNumoperST
                     FRM_MNT_COBERTURA.Correlativo = 1
                     FRM_MNT_COBERTURA.Modulo = "PCS"
                     FRM_MNT_COBERTURA.Show 1
                  End If
               End If
               
               Unload Me
               
            End If
         End If
      End If
  
   Screen.MousePointer = vbDefault
   Exit Sub

   
End Sub

Private Function ClienteCumplePoliticas(ByVal RutCliente As Long, _
                                        ByVal CodCliente As Integer, _
                                        ByVal PlazoOperacion As Long, _
                                        ByVal Metodologia_Cliente As Integer) As Boolean
   Dim Datos()

   ClienteCumplePoliticas = False

   Envia = Array()
   AddParam Envia, "PCS"
   AddParam Envia, Thr_CodProducto
   AddParam Envia, RutCliente
   AddParam Envia, CodCliente
   AddParam Envia, PlazoOperacion        '--> Thr_dPlazoOperacion
   AddParam Envia, Metodologia_Cliente   'PROD-10967
   If Not Bac_Sql_Execute("BacParamsuda.dbo.SP_VALIDACION_POLITICA", Envia) Then
       MsgBox "No se ha podido validar el cumplimiento de las Políticas de Derivados para la operación", vbCritical, TITSISTEMA
       Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      Select Case Datos(1)
         Case -2
            ClienteCumplePoliticas = True
            Thr_AplicaThreshold = False
         Case -1
            Call MsgBox(Datos(3), vbExclamation, App.Title)
            ClienteCumplePoliticas = False
            Thr_AplicaThreshold = False
         Case 0
            Call MsgBox(Datos(3), vbExclamation, App.Title)
            ClienteCumplePoliticas = True
            Thr_AplicaThreshold = True
         Case 1
            ClienteCumplePoliticas = True
            Thr_AplicaThreshold = True
      End Select
   End If
   
End Function

Private Function RutSinDV(ByVal recRut As String) As String
Dim p As Integer
Dim l As Integer
Dim i As Integer
Dim xRut As String
RutSinDV = ""
xRut = Trim(recRut)
l = Len(xRut)
p = 0
For i = l To 1 Step -1
    If Mid$(xRut, i, 1) = "-" Then
        p = i
        Exit For
    End If
Next
If p = 0 Then
    RutSinDV = xRut
Else
    RutSinDV = Mid$(xRut, 1, p - 1)
End If
End Function

Function ValidaDatosIngreso() As Boolean

    ValidaDatosIngreso = False
    
    If Not ChequeaCierreMesa() Then
      MsgBox "No se puede Grabar Operacion, Mesa de Dinero está Cerrada!!!", vbExclamation, Msj
      Exit Function
    End If
   
    If oFormulario.CMBMoneda.ListIndex = -1 Then
        MsgBox "Debe Seleccionar Moneda de la Operacion", vbInformation, Msj
        Exit Function
    End If
    
    If oFormulario.cmbMonedaRecibimos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Moneda Recibimos ", vbInformation, Msj
        Exit Function
    End If
    
    If oFormulario.cmbDocumentoRecibimos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Documento Pagamos ", vbInformation, Msj
        Exit Function
    End If
        
    If oFormulario.cmbMonedaPagamos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Moneda Pagamos ", vbInformation, Msj
        Exit Function
    End If
    
    If oFormulario.cmbDocumentoPagamos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Documento Pagamos ", vbInformation, Msj
        Exit Function
    End If
 
    If oFormulario.tabFlujos.TabEnabled(1) = False Then
        MsgBox "Debe realizar Calculo de Flujos!", vbCritical, Msj
        Exit Function
    End If
  
    ValidaDatosIngreso = True

End Function

Private Sub txtCliente_DblClick()
    txtRut_DblClick
End Sub


Private Sub txtRut_DblClick()
   Dim carac       As String
   Dim AyudaCli    As New clsCliente
   Dim oOperadores As New clsCliente
    
   If Not AyudaCli.Ayuda("") Then
      MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
      Exit Sub
   End If
    
   'BacAyudaSwap.Tag = "Cliente"
   'BacAyudaSwap.Show 1
    BacAyudaCliente.Tag = "Cliente"
    BacAyudaCliente.Show 1
   If giAceptar Then
      If AyudaCli.LeerxRut(Val(gsCodigo), Val(gsCodCli)) Then
         TxtRut = Format(AyudaCli.clrut, FormatEsp) & "-" & AyudaCli.cldv
         TxtRut.Tag = AyudaCli.clrut
         txtCliente = AyudaCli.clnombre
         txtCliente.Tag = AyudaCli.clcodigo
         
         'PROD-10967
         Metodologia_Cliente = AyudaCli.clMetodologia_LCR
         Me.LblMetodologia = IIf(Metodologia_Cliente = 1 Or Metodologia_Cliente = 4, "Met. Tradicional", "Metodologia Drv " + Format(Metodologia_Cliente, "##"))
         If Me.MiFormulario = "Nuevo Swap" Then
            FRM_SWAP_OP.Swap_Op_Threshold_LCR = AyudaCli.clThreshold
            FRM_SWAP_OP.Swap_Op_Metodologia_LCR = AyudaCli.clMetodologia_LCR
            FRM_SWAP_OP.Swap_Op_Cliente_LCR = AyudaCli.clnombre
         Else
            FRM_SWAP_OP_FRA.Fra_Threshold_LCR = AyudaCli.clThreshold
            FRM_SWAP_OP_FRA.Fra_Metodologia_LCR = AyudaCli.clMetodologia_LCR
            FRM_SWAP_OP_FRA.Fra_Cliente_LCR = AyudaCli.clnombre
         End If
         
         If Metodologia_Cliente <> 1 And Metodologia_Cliente <> 4 Then
            TlbHerramientas.Buttons(3).Enabled = True
         End If
         'PROD-10967
         
         If Tipo_Operacion$ = "ST" Then
            nPaisOrigenST = AyudaCli.clPais
         ElseIf Tipo_Operacion = "SM" Then
            nPaisOrigen = AyudaCli.clPais
         End If
         
         Call AyudaCli.CargaOperador(CmbOperador, AyudaCli.clrut, AyudaCli.clcodigo)
      End If
      If gsCodigo = "97023000" Then
            frame(1).Visible = False
            Frame1.Visible = True
            Frame1.Top = frame(1).Top
            CmbMesaOrg.Enabled = True
            Func_Cartera cmbCarteraOrig, "PCS"
            Func_Cartera cmbCarteraDest, "PCS"
            
            Call LeerMesasOrig(CmbMesaOrg)
            Call LeerMesas(CmbMesaDest)
            
            Exit Sub
        Else
            frame(1).Visible = True
            Frame1.Visible = False
   End If
   
'      If AyudaCli.LeerxRut(Val(gsCodigo), Val(gsCodCli)) Then
'         TxtRut = Format(AyudaCli.clrut, FormatEsp) & "-" & AyudaCli.cldv
'         TxtRut.Tag = AyudaCli.clrut
'         TxtCliente = AyudaCli.clnombre
'         TxtCliente.Tag = AyudaCli.clcodigo
'
'         If Tipo_Operacion$ = "ST" Then
'            nPaisOrigenST = AyudaCli.clPais
'         ElseIf Tipo_Operacion = "SM" Then
'            nPaisOrigen = AyudaCli.clPais
'         End If
'
'         Call AyudaCli.CargaOperador(CmbOperador, AyudaCli.clrut, AyudaCli.clcodigo)
'      End If
   End If
   
' PROD-19111 ini
    gsc_Periodo = False
    If Trim(TxtRut.Text) <> "" Then
        gsc_Periodo = True
        Call ValidaNovacion(AyudaCli.clrut, AyudaCli.clcodigo, AyudaCli.cltipocliente)
    End If
' PROD-19111 ini


   Exit Sub
    
   With AyudaCli
      If .leepornombre(carac) Then
         BacAyudaSwap.Tag = "Cliente"
         BacAyudaSwap.Show 1
      Else
         MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
         Exit Sub
      End If
   End With
    
   TxtRut = Format(gsCodigo, FormatEsp) & "-" & gsDigito
   txtCliente = gsNombre
   txtCliente.Tag = gsCodCli
    
   With oOperadores
      Call .CargaOperador(CmbOperador, gsCodigo, txtCliente.Tag)
      '.LeerOperadoresCliente (gsCodCli)
      '.Coleccion2Control cmbOperador
   End With
    
   AyudaCli.Limpiar
   
   Set AyudaCli = Nothing
   Set oOperadores = Nothing

End Sub



Private Function ValidaNovacion(ByVal nRutCliente As Long, ByVal nCodCliente As Long, ByVal nTipCliente As Long)
    Dim lRut As Long
    Dim ObjCliente  As New clsCliente

    Call gsc_Parametros.DatosGenerales
    
    'prd 19111 ini

    '->Valida si esta activo el Swicht en la tabla MFAC
    If gsc_Parametros.ActivaComder = "S" Then
    
        '-> Valida que producto esta habilitado para comder
        If Valida_Producto(CStr(Tipo_Producto)) Then
            '-> Valida cliente comder
            lRut = Val(TxtRut.Text)
            
            If ObjCliente.LeerPorRut(nRutCliente, nCodCliente, nTipCliente) Then
                
                If ObjCliente.clvigente = "N" Then
                    LblEstadoCliente.Caption = "Cliente No Se Encuentra Vigente"
                    Exit Function
                End If
            
                If nRutCliente <> 0 Then
                    nMercadoLocal = ObjCliente.LeerPais(ObjCliente.clPais)
                    pais = ObjCliente.clPais
                Else
                    LblEstadoCliente.Caption = "No Existe el Cliente"
                    Exit Function
                End If
            End If
        Else
            'COMDER-COC
            If gsc_Periodo = False Then
                Let Check1.Enabled = False
                Let Check1.Value = 0
                Let Label3.Visible = True
                Let Label3.Caption = "Novación a ComDer, Plazo supera el limite permitido."
                Exit Function
            Else
                Check1.Enabled = False
                Label3.Enabled = False
                Let Label3.Caption = "Novación a ComDer, Producto no habilitado para ComDer."
                Exit Function
            End If
        End If
    Else
         Check1.Enabled = False
         Label3.Enabled = False
         Exit Function
    End If
              
    '-> Valida que la hora de novacion sea entre 08:00 y 16:00
    If Not Valida_hora Then
        'Let Check1.Enabled = False
        'Let nNovacion = 0
        'Let bHoraNovacion = False
' PROD-19111 ini
         Let Check1.Enabled = False
         Let Check1.Value = 0
         Let Label3.Visible = True
         Let Label3.Caption = "Novación  a ComDer Fuera de Horario de Operación ComDer."
         Exit Function
    
    Else
        'Let Check1.Enabled = True       '-> Marca
        If gModalidad = "COMPENSACION" And gsc_Periodo <> False Then
            Let Check1.Enabled = True       '-> Marca
            Let Check1.Value = 1
            Let nNovacion = 1
        End If
    End If
    
    If gModalidad = "COMPENSACION" Then    '-> Indica Compensacion
        Let Label3.Visible = True               '-> Mensaje
        Let Label3.Caption = "Novación a ComDer"
    End If
    
    If gModalidad <> "COMPENSACION" Then   '-> Indica Entrega Fisica
       Let Check1.Enabled = False              '-> Marca
       Let Check1.Value = 0
       Let Label3.Visible = True               '-> Mensaje
       Let Label3.Caption = "Novación a ComDer"
    End If
    
    '-> Indica que el cliente NO tiene la Marca de Comder
    

    If ObjCliente.clComDer = "N" And gModalidad = "ENTREGA FISICA" Then
        Let Check1.Enabled = False              '-> Marca
        Let Check1.Value = 0
        Let Label3.Visible = True               '-> Mensaje
        Let Label3.Caption = "Novación a ComDer no permite Entrega Fisica"
    End If
    
    If ObjCliente.clComDer = "N" And gModalidad = "COMPENSACION" Then
        Let Check1.Enabled = False
        Let Check1.Value = 0
        Let Label3.Visible = True
        Let Label3.Caption = "Novación a ComDer Cliente No Habilitado, firma contrato ComDer no realizado."
    End If
    
    
    If gsc_Periodo = False Then
        Let Check1.Enabled = False
        Let Check1.Value = 0
        Let Label3.Visible = True
        Let Label3.Caption = "Novación a ComDer , Plazo supera el limite permitido."
    End If
    'prd 19111 fin
End Function

Private Function Valida_hora() As Boolean

   Dim Datos()
   Dim horaMaxima As String
   Dim horaMinima As String
   Dim hora As Variant
   
   Valida_hora = False
   If Not Bac_Sql_Execute("BDBOMESA.DBO.COMDER_ValidaHoraComDer") Then
        
        'Valida_hora = False
        Exit Function
'   Else
'       Do While Bac_SQL_Fetch(Datos())
'           horaMaxima = Datos(1) 'horaMaxima
'           horaMinima = Datos(2) 'horaMinima
'       Loop
  End If

If Bac_SQL_Fetch(Datos()) Then
    Valida_hora = Datos(1)
End If


''   'Obtiene la hora en la que se hace la transaccion
'   hora = Time
'    'Valida que la hora no sea mayor que maxima permitida para generar Novacion
'     If hora > horaMaxima Then
'        Valida_hora = False
'     End If
'
'   'Valida que la hora no sea menor que minima permitida para generar Novacion
'     If hora < horaMinima Then
'        Valida_hora = False
'     End If
End Function


Private Function Valida_Producto(Codigo As String) As Boolean

Dim Datos()
Dim Periodo As Integer
Dim Plazo As Integer
Dim estado As Integer
Dim Sistema As String
Dim DiferenciaDias As Double


Envia = Array()
AddParam Envia, GLB_ID_SISTEMA
AddParam Envia, Codigo

'prd19111 ini

If Not Bac_Sql_Execute("BDBOMESA.DBO.COMDER_HabilitaProductoComDer", Envia) Then
        Exit Function
 End If
 
'   Do While Bac_SQL_Fetch(Datos())
'           estado = Datos(4) 'estado
'
'   Loop
           
    If Bac_SQL_Fetch(Datos()) Then
        estado = Datos(4) 'estado
        Periodo = Datos(5) 'periodo
        
   End If
       

    'Plazo = gsc_Operacion.nPlazo
    'Si el codigo el estado del produto es 2 no esta habilitado para novacion entonces es falso
   If estado = 2 Or estado = 0 Then
          
        Valida_Producto = False
        Exit Function
   Else
        If estado = 1 Then
             'Si el codigo el estado del produto es 1 no esta habilitado para novacion entonces es verdadero
             Valida_Producto = True
             
             Plazo = DateDiff("D", FRM_SWAP_OP.I_FechaEfectiva.Text, FRM_SWAP_OP.I_Madurez.Text)
              
            
             If (Plazo - 1) > Periodo And gsc_Periodo = True Then
                
                 Valida_Producto = False
                 
                 gsc_Periodo = False

                 Exit Function
             End If
        
        Else
           Valida_Producto = False
        End If
End If
'prd19111 fin
End Function




Function LeerMesas(ByRef oObjeto As ComboBox) As Long
        Dim Datos()
        
        If Not Bac_Sql_Execute("bacparamsuda..SP_CARGAMESAS") Then
            Exit Function
        End If
        Call oObjeto.Clear
        Do While Bac_SQL_Fetch(Datos())
             oObjeto.AddItem (Datos(2)) & Space(101) & Datos(1)
        Loop
        oObjeto.ListIndex = -1
End Function
    
Function LeerMesasOrig(ByRef oObjeto As ComboBox) As Long
        Dim Datos()
        
        If Not Bac_Sql_Execute("bacparamsuda..SP_CARGAMESAS ") Then
            Exit Function
        End If
        Call oObjeto.Clear
        Do While Bac_SQL_Fetch(Datos())
'            If gsc_Parametros. = DATOS(1) Then
                oObjeto.AddItem (Datos(2)) & Space(101) & Datos(1)
'            End If
        Loop
        oObjeto.ListIndex = 0
        oObjeto.Enabled = False
        
 End Function
 
Private Sub cmbCarteraOrig_Click()
    If cmbCarteraOrig.ItemData(cmbCarteraOrig.ListIndex) <> 0 Then
       If Not ValidaDatosCyM Then
'            MsgBox "Las Mesas y las carteras no pueden ser iguales", vbInformation, TITSISTEMA
        End If
    End If
End Sub

Private Sub cmbCarteraDest_Click()
    If cmbCarteraDest.ItemData(cmbCarteraDest.ListIndex) <> 0 Then
       If Not ValidaDatosCyM Then
'           MsgBox "Las Mesas y las carteras no pueden ser iguales", vbInformation, TITSISTEMA
        End If
    End If
End Sub

Private Sub CmbMesaDest_Click()
    If CmbMesaDest.ItemData(CmbMesaDest.ListIndex) > -1 Then
       If Not ValidaDatosCyM Then
 '          MsgBox "Las Mesas y las carteras no pueden ser iguales", vbInformation, TITSISTEMA
       End If
    End If
End Sub

Function ValidaDatosTicket() As Boolean
    ValidaDatosTicket = True
    
    If cmbCarteraOrig = "" Then
        MsgBox "Debe seleccionar Cartera de Origen ", vbInformation, Msj
        cmbCarteraOrig.SetFocus
        ValidaDatosTicket = False
        Exit Function
    End If
    
    If cmbCarteraOrig = "" Then
        MsgBox "Debe seleccionar Cartera de Origen ", vbInformation, Msj
        cmbCarteraOrig.SetFocus
        ValidaDatosTicket = False
        Exit Function
    End If
    If cmbCarteraDest = "< TODAS >" Then
        MsgBox "Debe seleccionar Cartera de Destino ", vbInformation, Msj
        cmbCarteraDest.SetFocus
        ValidaDatosTicket = False
        Exit Function
    End If
    
    If CmbMesaDest.Text = "" Then
        MsgBox "Debe seleccionar Contraparte ", vbInformation, Msj
        CmbMesaDest.SetFocus
        ValidaDatosTicket = False
        Exit Function
    End If
End Function

Function ValidaDatosCyM() As Boolean
    ValidaDatosCyM = True
    If (Trim(Right(cmbCarteraOrig.Text, 10)) = cmbCarteraDest.ItemData(cmbCarteraDest.ListIndex)) _
        Or Trim(Right(CmbMesaOrg.Text, 10)) = Trim(Right(CmbMesaDest.Text, 10)) Then
            ValidaDatosCyM = False
            'MsgBox "Las Mesas y las carteras no pueden ser iguales", vbInformation, TITSISTEMA
    End If
End Function

Private Function blnValidaNormaArt84(strTag As String) As Boolean
Dim blnResult As Boolean
blnResult = True

Call GeneraArchivoInterfaz(Me)

blnValidaNormaArt84 = gblnProcesoExitoso
End Function

