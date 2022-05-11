VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Begin VB.Form BacInformeMov 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informes de Movimientos Diarios"
   ClientHeight    =   4245
   ClientLeft      =   2100
   ClientTop       =   2970
   ClientWidth     =   7920
   ForeColor       =   &H8000000F&
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4245
   ScaleWidth      =   7920
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   315
      Index           =   8
      Left            =   4500
      Picture         =   "BacInfMov.frx":0000
      ScaleHeight     =   315
      ScaleWidth      =   285
      TabIndex        =   54
      Top             =   4890
      Visible         =   0   'False
      Width           =   285
   End
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   270
      Index           =   7
      Left            =   6375
      Picture         =   "BacInfMov.frx":015A
      ScaleHeight     =   270
      ScaleWidth      =   285
      TabIndex        =   53
      Top             =   4890
      Visible         =   0   'False
      Width           =   285
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   270
      Index           =   8
      Left            =   4500
      Picture         =   "BacInfMov.frx":02B4
      ScaleHeight     =   270
      ScaleWidth      =   285
      TabIndex        =   50
      Top             =   4590
      Width           =   285
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   270
      Index           =   7
      Left            =   6375
      Picture         =   "BacInfMov.frx":040E
      ScaleHeight     =   270
      ScaleWidth      =   285
      TabIndex        =   49
      Top             =   4590
      Width           =   285
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3720
      Left            =   0
      TabIndex        =   0
      Top             =   540
      Width           =   7935
      _Version        =   65536
      _ExtentX        =   13996
      _ExtentY        =   6562
      _StockProps     =   15
      Caption         =   "SSPanel1"
      ForeColor       =   12632256
      BackColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelInner      =   1
      Begin VB.Frame Frame3 
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   1470
         Left            =   75
         TabIndex        =   1
         Top             =   90
         Width           =   7770
         Begin VB.Frame Ssf_Entidad 
            Caption         =   "Entidad"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   600
            Left            =   90
            TabIndex        =   55
            Top             =   150
            Width           =   3795
            Begin VB.ComboBox Combo1 
               BeginProperty Font 
                  Name            =   "Courier New"
                  Size            =   9
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   345
               Left            =   60
               Style           =   2  'Dropdown List
               TabIndex        =   56
               Top             =   195
               Width           =   3675
            End
         End
         Begin VB.Frame fr_Cartera 
            Caption         =   "Cartera de Inversión"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   600
            Left            =   90
            TabIndex        =   45
            Top             =   795
            Width           =   3795
            Begin VB.ComboBox Cmb_Cartera 
               Height          =   315
               Left            =   60
               Style           =   2  'Dropdown List
               TabIndex        =   46
               Top             =   210
               Width           =   3675
            End
         End
         Begin VB.Frame Ssf_Cartera_Normativa 
            Caption         =   "Cartera Normativa"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   600
            Left            =   3915
            TabIndex        =   26
            Top             =   150
            Width           =   3795
            Begin VB.ComboBox Cmb_Cartera_Normativa 
               Height          =   315
               Left            =   60
               Style           =   2  'Dropdown List
               TabIndex        =   57
               Top             =   195
               Width           =   3675
            End
         End
         Begin VB.Frame Frame2 
            BorderStyle     =   0  'None
            Height          =   405
            Index           =   0
            Left            =   60
            TabIndex        =   2
            Top             =   660
            Width           =   3825
         End
         Begin VB.Frame Fr_Libro 
            Caption         =   "Libro"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   600
            Left            =   3915
            TabIndex        =   47
            Top             =   795
            Width           =   3795
            Begin VB.ComboBox Cmb_Libro 
               Height          =   315
               Left            =   60
               Style           =   2  'Dropdown List
               TabIndex        =   48
               Top             =   225
               Width           =   3675
            End
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "Listados  de Movimientos"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   2130
         Left            =   75
         TabIndex        =   3
         Top             =   1515
         Width           =   7770
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   14
            Left            =   4065
            Picture         =   "BacInfMov.frx":0568
            ScaleHeight     =   270
            ScaleWidth      =   375
            TabIndex        =   43
            Top             =   1770
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   14
            Left            =   7245
            Picture         =   "BacInfMov.frx":06C2
            ScaleHeight     =   270
            ScaleWidth      =   330
            TabIndex        =   42
            Top             =   1770
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   13
            Left            =   7230
            Picture         =   "BacInfMov.frx":081C
            ScaleHeight     =   270
            ScaleWidth      =   330
            TabIndex        =   40
            Top             =   1470
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   13
            Left            =   4065
            Picture         =   "BacInfMov.frx":0976
            ScaleHeight     =   270
            ScaleWidth      =   375
            TabIndex        =   39
            Top             =   1470
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   300
            Index           =   12
            Left            =   7215
            Picture         =   "BacInfMov.frx":0AD0
            ScaleHeight     =   300
            ScaleWidth      =   330
            TabIndex        =   37
            Top             =   2175
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   300
            Index           =   12
            Left            =   4065
            Picture         =   "BacInfMov.frx":0C2A
            ScaleHeight     =   300
            ScaleWidth      =   375
            TabIndex        =   36
            Top             =   2175
            Visible         =   0   'False
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   11
            Left            =   7230
            Picture         =   "BacInfMov.frx":0D84
            ScaleHeight     =   270
            ScaleWidth      =   330
            TabIndex        =   34
            Top             =   1170
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   11
            Left            =   4065
            Picture         =   "BacInfMov.frx":0EDE
            ScaleHeight     =   270
            ScaleWidth      =   375
            TabIndex        =   33
            Top             =   1170
            Width           =   375
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   10
            Left            =   4065
            Picture         =   "BacInfMov.frx":1038
            ScaleHeight     =   270
            ScaleWidth      =   375
            TabIndex        =   31
            Top             =   870
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   10
            Left            =   7230
            Picture         =   "BacInfMov.frx":1192
            ScaleHeight     =   270
            ScaleWidth      =   330
            TabIndex        =   30
            Top             =   870
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   9
            Left            =   7230
            Picture         =   "BacInfMov.frx":12EC
            ScaleHeight     =   270
            ScaleWidth      =   330
            TabIndex        =   28
            Top             =   570
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   9
            Left            =   4065
            Picture         =   "BacInfMov.frx":1446
            ScaleHeight     =   270
            ScaleWidth      =   375
            TabIndex        =   27
            Top             =   570
            Width           =   375
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   6
            Left            =   4065
            Picture         =   "BacInfMov.frx":15A0
            ScaleHeight     =   270
            ScaleWidth      =   375
            TabIndex        =   17
            Top             =   270
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   6
            Left            =   7230
            Picture         =   "BacInfMov.frx":16FA
            ScaleHeight     =   270
            ScaleWidth      =   330
            TabIndex        =   16
            Top             =   270
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   5
            Left            =   240
            Picture         =   "BacInfMov.frx":1854
            ScaleHeight     =   270
            ScaleWidth      =   375
            TabIndex        =   15
            Top             =   1770
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   5
            Left            =   3405
            Picture         =   "BacInfMov.frx":19AE
            ScaleHeight     =   270
            ScaleWidth      =   330
            TabIndex        =   14
            Top             =   1770
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   0
            Left            =   240
            Picture         =   "BacInfMov.frx":1B08
            ScaleHeight     =   270
            ScaleWidth      =   375
            TabIndex        =   13
            Top             =   270
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   0
            Left            =   3405
            Picture         =   "BacInfMov.frx":1C62
            ScaleHeight     =   270
            ScaleWidth      =   330
            TabIndex        =   12
            Top             =   270
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   1
            Left            =   240
            Picture         =   "BacInfMov.frx":1DBC
            ScaleHeight     =   270
            ScaleWidth      =   375
            TabIndex        =   11
            Top             =   570
            Width           =   375
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   3
            Left            =   240
            Picture         =   "BacInfMov.frx":1F16
            ScaleHeight     =   270
            ScaleWidth      =   375
            TabIndex        =   10
            Top             =   1170
            Width           =   375
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   4
            Left            =   240
            Picture         =   "BacInfMov.frx":2070
            ScaleHeight     =   330
            ScaleWidth      =   375
            TabIndex        =   9
            Top             =   1470
            Width           =   375
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   2
            Left            =   240
            Picture         =   "BacInfMov.frx":21CA
            ScaleHeight     =   270
            ScaleWidth      =   375
            TabIndex        =   8
            Top             =   870
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   1
            Left            =   3405
            Picture         =   "BacInfMov.frx":2324
            ScaleHeight     =   270
            ScaleWidth      =   330
            TabIndex        =   7
            Top             =   570
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   2
            Left            =   3405
            Picture         =   "BacInfMov.frx":247E
            ScaleHeight     =   270
            ScaleWidth      =   330
            TabIndex        =   6
            Top             =   870
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   3
            Left            =   3405
            Picture         =   "BacInfMov.frx":25D8
            ScaleHeight     =   270
            ScaleWidth      =   330
            TabIndex        =   5
            Top             =   1170
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   4
            Left            =   3405
            Picture         =   "BacInfMov.frx":2732
            ScaleHeight     =   270
            ScaleWidth      =   330
            TabIndex        =   4
            Top             =   1470
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Facilidad de Liquidez Intradía"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   14
            Left            =   4515
            TabIndex        =   44
            Top             =   1800
            Width           =   2085
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Informe de Liquidez"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   13
            Left            =   4545
            TabIndex        =   41
            Top             =   1485
            Width           =   1740
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Informe Pasivos"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   12
            Left            =   4545
            TabIndex        =   38
            Top             =   2175
            Visible         =   0   'False
            Width           =   1125
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Informe D31"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   11
            Left            =   4560
            TabIndex        =   35
            Top             =   1185
            Width           =   1230
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Ventas con pacto del día"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   10
            Left            =   4545
            TabIndex        =   32
            Top             =   885
            Width           =   1800
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Anulaciones"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   9
            Left            =   4545
            TabIndex        =   29
            Top             =   585
            Width           =   870
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Interbancarios"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   6
            Left            =   4545
            TabIndex        =   24
            Top             =   285
            Width           =   1005
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Reventas"
            ForeColor       =   &H00800000&
            Height          =   180
            Index           =   5
            Left            =   720
            TabIndex        =   23
            Top             =   1800
            Width           =   690
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Compras Definitivas"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   0
            Left            =   720
            TabIndex        =   22
            Top             =   300
            Width           =   1395
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Ventas Definitivas"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   1
            Left            =   720
            TabIndex        =   21
            Top             =   585
            Width           =   1275
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Compras con Pacto"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   2
            Left            =   720
            TabIndex        =   20
            Top             =   900
            Width           =   1395
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Ventas con Pacto"
            ForeColor       =   &H00800000&
            Height          =   180
            Index           =   3
            Left            =   720
            TabIndex        =   19
            Top             =   1200
            Width           =   1275
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Recompras"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   4
            Left            =   720
            TabIndex        =   18
            Top             =   1500
            Width           =   810
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2805
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacInfMov.frx":288C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacInfMov.frx":2BA6
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacInfMov.frx":2FFA
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   0
      TabIndex        =   25
      Top             =   15
      Width           =   7965
      _ExtentX        =   14049
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar Informe a Pantalla"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir Informe"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Label Etiqueta 
      AutoSize        =   -1  'True
      Caption         =   "Transable"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   4950
      TabIndex        =   52
      Top             =   4635
      Width           =   1065
      WordWrap        =   -1  'True
   End
   Begin VB.Label Etiqueta 
      AutoSize        =   -1  'True
      Caption         =   "Permanente"
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   7
      Left            =   6870
      TabIndex        =   51
      Top             =   4635
      Width           =   1005
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "BacInformeMov"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim SQL As String
Dim Datos()
Dim TCartera As String

Private Sub Generar_Listado(Donde As String)
Dim Nombre_Rpt      As String: Nombre_Rpt = ""
Dim TipRep          As String
Dim Fecha           As String
Dim Fechaprox       As String
Dim Titulo          As String
Dim nContador       As Integer

On Error GoTo Control:

xentidad = Val(Trim$(Right$(Combo1, 10)))

Screen.MousePointer = vbHourglass

If Donde = "Impresora" Then
    BacTrader.bacrpt.Destination = 0
Else
    BacTrader.bacrpt.Destination = 1
End If


'Opciones de Cartera
    Dim Inf%, X%, Marca, Entidades        As Boolean
        Marca = False
        Entidades = False
        Inf = 1
    
    For m = 0 To 6
        If ConCheck.Item(m).Visible = True Then Entidades = True
    Next m
    
    If ConCheck.Item(9).Visible = True Then Entidades = True
    If ConCheck.Item(10).Visible = True Then Entidades = True
    If ConCheck.Item(11).Visible = True Then Entidades = True
    If ConCheck.Item(12).Visible = True Then Entidades = True
    If ConCheck.Item(13).Visible = True Then
        Entidades = True
        Marca = True
    End If
    If ConCheck.Item(14).Visible = True Then
        Entidades = True
        Marca = True
    End If
    
    If Entidades = False Then
        MsgBox "Debe Seleccionar Tipo de Listado ", vbInformation, TITSISTEMA
        Screen.MousePointer = vbDefault
        Exit Sub
    End If
       
    If ConCheck.Item(0).Visible = True Then
        nContador = IIf(Cmb_Cartera_Normativa.ListIndex > 0, 1, Cmb_Cartera_Normativa.ListCount - 1)
        For X = 1 To nContador 'inf
         
            AuxTit = ""
            TCartera = ""
        
            TCartera = Trim(Right(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, X)), 10))
            AuxTit = Trim(Left(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, X)), 50))
               
            Call Limpiar_Cristal
        
            TitRpt = "MOVIMIENTO DIARIO DE COMPRAS DEFINITIVAS " + AuxTit
            
            BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTCP.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
            BacTrader.bacrpt.StoredProcParam(1) = TCartera
            BacTrader.bacrpt.StoredProcParam(2) = TitRpt
            BacTrader.bacrpt.StoredProcParam(3) = Trim(Right(Cmb_Cartera.text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
            '------------------------------------------------------------------------------
            'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
            BacTrader.bacrpt.StoredProcParam(4) = GLB_LIBRO
            BacTrader.bacrpt.StoredProcParam(5) = GLB_CARTERA
            '------------------------------------------------------------------------------
            BacTrader.bacrpt.StoredProcParam(6) = Trim(Right(Cmb_Libro.text, 10))
            BacTrader.bacrpt.Formulas(0) = "titulo='" & TitRpt & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.WindowTitle = TitRpt
            BacTrader.bacrpt.Action = 1
            
            Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
        Next X
    End If
    
    If ConCheck.Item(1).Visible = True Then
        nContador = IIf(Cmb_Cartera_Normativa.ListIndex > 0, 1, Cmb_Cartera_Normativa.ListCount - 1)
        For X = 1 To nContador
         
            AuxTit = ""
            TCartera = ""
        
            TCartera = Trim(Right(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, X)), 10))
            AuxTit = Trim(Left(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, X)), 50))
    
            Call Limpiar_Cristal

            TitRpt = "MOVIMIENTO DIARIO DE VENTAS DEFINITIVAS " + AuxTit
            
            BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTVP.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
            BacTrader.bacrpt.StoredProcParam(1) = TCartera
            BacTrader.bacrpt.StoredProcParam(2) = TitRpt
            BacTrader.bacrpt.StoredProcParam(3) = Trim(Right(Cmb_Cartera.text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
            
            '------------------------------------------------------------------------------
            'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
            BacTrader.bacrpt.StoredProcParam(4) = GLB_LIBRO
            '------------------------------------------------------------------------------
            BacTrader.bacrpt.StoredProcParam(5) = Trim(Right(Cmb_Libro.text, 10))
            
            BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.WindowTitle = TitRpt
            BacTrader.bacrpt.Action = 1
            
            Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
        Next X
    End If
    
    If ConCheck.Item(2).Visible = True Then
        Call Limpiar_Cristal
        
        TitRpt = "MOVIMIENTO DIARIO DE COMPRAS CON PACTO"
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTCI.RPT"
        If xentidad = "" Then xentidad = 0
        BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
        BacTrader.bacrpt.StoredProcParam(1) = TitRpt
        BacTrader.bacrpt.StoredProcParam(2) = Trim(Right(Cmb_Cartera.text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
        '------------------------------------------------------------------------------
        'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
        BacTrader.bacrpt.StoredProcParam(3) = GLB_LIBRO
        '------------------------------------------------------------------------------
        BacTrader.bacrpt.StoredProcParam(4) = Trim(Right(Cmb_Libro.text, 10))
        
        BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.Action = 1
        
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión" & TitRpt)
    End If
    
    If ConCheck.Item(3).Visible = True Then 'Ok
        Call Limpiar_Cristal
        
        TitRpt = "MOVIMIENTO DIARIO DE VENTAS CON PACTO"
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTVI.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
        BacTrader.bacrpt.StoredProcParam(1) = TitRpt
        BacTrader.bacrpt.StoredProcParam(2) = Trim(Right(Cmb_Cartera.text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
        '------------------------------------------------------------------------------
        'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
        BacTrader.bacrpt.StoredProcParam(3) = GLB_LIBRO
        '------------------------------------------------------------------------------
        BacTrader.bacrpt.StoredProcParam(4) = Trim(Right(Cmb_Libro.text, 10))
        
        BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.Action = 1
        
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
    End If
    
    If ConCheck.Item(4).Visible = True Then 'Ok
        Call Limpiar_Cristal
        
        TitRpt = "MOVIMIENTO DIARIO DE RECOMPRAS"
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTRC.RPT"
'        BacTrader.bacrpt.RetrieveStoredProcParams
        BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
        BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
        BacTrader.bacrpt.StoredProcParam(1) = TitRpt
        BacTrader.bacrpt.StoredProcParam(2) = IIf(Trim(Right(Cmb_Cartera.text, 10)) = "", 0, Trim(Right(Cmb_Cartera.text, 10))) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
        '------------------------------------------------------------------------------
        'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
        BacTrader.bacrpt.StoredProcParam(3) = GLB_LIBRO
        '------------------------------------------------------------------------------
        BacTrader.bacrpt.StoredProcParam(4) = IIf(Trim(Right(Cmb_Libro.text, 10)) = "", "", Trim(Right(Cmb_Libro.text, 10)))
        
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.Action = 1
        
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
    End If
    
    If ConCheck.Item(5).Visible = True Then 'oK
        Call Limpiar_Cristal
        
        TitRpt = "MOVIMIENTO DIARIO DE REVENTAS"
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTRV.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
        BacTrader.bacrpt.StoredProcParam(1) = TitRpt
        BacTrader.bacrpt.StoredProcParam(2) = Trim(Right(Cmb_Cartera.text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
        '------------------------------------------------------------------------------
        'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
        BacTrader.bacrpt.StoredProcParam(3) = GLB_LIBRO
        '------------------------------------------------------------------------------
        BacTrader.bacrpt.StoredProcParam(4) = Trim(Right(Cmb_Libro.text, 10))
        BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.Action = 1
        
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
    End If
                               
    If ConCheck.Item(6).Visible = True Then 'Ok
        Call Limpiar_Cristal
        
        TitRpt = "MOVIMIENTO DIARIO DE INTERBANCARIOS"
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTIB.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
        BacTrader.bacrpt.StoredProcParam(1) = Trim(Right(Cmb_Cartera.text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
        
        '------------------------------------------------------------------------------
        'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
        BacTrader.bacrpt.StoredProcParam(2) = GLB_LIBRO
        '------------------------------------------------------------------------------
        BacTrader.bacrpt.StoredProcParam(3) = Trim(Right(Cmb_Libro.text, 10))
    
        BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.Action = 1
        
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
    End If
    
    If ConCheck.Item(9).Visible = True Then 'Ok
        Call Limpiar_Cristal
        
        TitRpt = "MOVIMIENTO DIARIO DE OPERACIONES ANULADAS "
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTAN.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
        BacTrader.bacrpt.StoredProcParam(1) = XCarteraSuper
        BacTrader.bacrpt.StoredProcParam(2) = Trim(Right(Cmb_Cartera.text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
        '------------------------------------------------------------------------------
        'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
        BacTrader.bacrpt.StoredProcParam(3) = GLB_LIBRO
        '------------------------------------------------------------------------------
        BacTrader.bacrpt.StoredProcParam(4) = Trim(Right(Cmb_Libro.text, 10))
        
        BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.Action = 1
        
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
    End If
    
    If ConCheck.Item(10).Visible = True Then
        Call Limpiar_Cristal
        
        TitRpt = "VENTAS CON PACTO DEL DIA "
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "VTAPACT.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = TitRpt
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.Action = 1
        
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
    End If
    
    If ConCheck.Item(11).Visible = True Then
        Call Limpiar_Cristal
        
        TitRpt = "INFORME D31"
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "Informed31.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = Format(gsBac_Fecp, "yyyymmdd")
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.Action = 1
        
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
    End If
    
    If ConCheck.Item(12).Visible = True Then
        Call Limpiar_Cristal
        
        TitRpt = "INFORME PASIVOS"
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "movpasivo.RPT"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.Action = 1
        
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
    End If
           
    If ConCheck.Item(13).Visible = True Then
        Call Limpiar_Cristal
        
        TitRpt = "INFORME DE LIQUIDEZ - Mensaje 139"
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "Mensaje_139.rpt"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.WindowState = crptMaximized
        BacTrader.bacrpt.Action = 1

        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "MENSJAE 139" & TitRpt)

        '    TitRpt = "INFORME DE LIQUIDEZ"
        '
        '    BacTrader.bacrpt.ReportFileName = RptList_Path & "Informe_liquidez.rpt"
        '    BacTrader.bacrpt.Connect = CONECCION
        '    BacTrader.bacrpt.WindowTitle = TitRpt
        '    BacTrader.bacrpt.Action = 1
        '
        '    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "INFORME DE LIQUIDEZ" & TitRpt)
        '
        '    Call Limpiar_Cristal
        '
        '    TitRpt = "INFORME DE LIQUIDEZ"
        '
        '    BacTrader.bacrpt.ReportFileName = RptList_Path & "Informe_liquidez_PAG2.rpt"
        '    BacTrader.bacrpt.Connect = CONECCION
        '    BacTrader.bacrpt.WindowTitle = TitRpt
        '    BacTrader.bacrpt.Action = 1
        '    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "INFORME DE LIQUIDEZ" & TitRpt)
    End If
    
    If ConCheck.Item(14).Visible = True Then
        Call Limpiar_Cristal
        
        TitRpt = "MOVIMIENTO DIARIO DE FACILIDAD DE LIQUIDEZ INTRADÍA"
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTFLI.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
        BacTrader.bacrpt.StoredProcParam(1) = TitRpt
        '------------------------------------------------------------------------------
        'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
        BacTrader.bacrpt.StoredProcParam(2) = GLB_LIBRO
        '------------------------------------------------------------------------------
        BacTrader.bacrpt.StoredProcParam(3) = Trim(Right(Cmb_Libro.text, 10))
    
        BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.Action = 1
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
    End If
           
           
Screen.MousePointer = vbDefault

Exit Sub

Control:

    MsgBox "Problemas al generar Listado de Movimientos. " & err.Description & ", " & err.Number, vbCritical, "BACTRADER"
    Screen.MousePointer = vbDefault

End Sub

Private Sub ConCheck_Click(Index As Integer)

    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
    
    If Index = 0 Or Index = 1 Then
        If ConCheck.Item(0).Visible = False And ConCheck.Item(1).Visible = False Then
           Ssf_Cartera_Normativa.Enabled = False
           Cmb_Cartera_Normativa.Enabled = False
        End If
    End If

End Sub


Private Sub Form_Load()

Dim X As Integer

'    SinCheck(0).Top = 360
'    ConCheck(0).Top = 360
'    Etiqueta(0).Top = 405
    
    
    Me.Top = 0
    Me.Left = 0
    Me.Icon = BacTrader.Icon
    
    
    Screen.MousePointer = vbHourglass
    giAceptar% = False

    Combo1.Clear

    If Bac_Sql_Execute("SP_LEER_ENTIDADES") Then
        Combo1.AddItem "TODAS LAS ENTIDADES                                                 "
        Do While Bac_SQL_Fetch(Datos())
            Combo1.AddItem Datos(1) & Space(50 + (30 - Len(Datos(1)))) & Str(Datos(2))
        Loop
    Else
        MsgBox "Proceso " & SQL & "no existe", vbOKOnly + vbCritical, "Entidades"
        Unload Me
    End If
    
    If Combo1.ListCount > 0 Then
        Combo1.ListIndex = 0
    End If
    
    ''''Call PROC_LLENA_COMBOS(GLB_LIBRO, Cmb_Libro, True)
    ''''Call PROC_LLENA_COMBOS(GLB_CARTERA_NORMATIVA, Cmb_Cartera_Normativa, True)
    
    Call PROC_LLENA_COMBOS(Cmb_Libro, 3, True, GLB_LIBRO)
    Call PROC_LLENA_COMBOS(Cmb_Cartera_Normativa, 3, True, GLB_CARTERA_NORMATIVA)
    Call PROC_LLENA_COMBOS(Cmb_Cartera, 4, True, "", GLB_CARTERA, GLB_ID_SISTEMA)
    
    Ssf_Cartera_Normativa.Enabled = False
    Cmb_Cartera_Normativa.Enabled = False
    
    Screen.MousePointer = vbDefault
    'Func_Cartera Cmb_Cartera, "BTR"
End Sub

Private Sub SinCheck_Click(Index As Integer)
 
' ============================================= '
' Opción de informes de movimientos de compras definitivas
' ============================================= '

    ConCheck.Item(Index).Left = SinCheck.Item(Index).Left
    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
    
    If Index = 0 Or Index = 1 Then
        Ssf_Cartera_Normativa.Enabled = True
        Cmb_Cartera_Normativa.Enabled = True
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index
Case 1
    Call Generar_Listado("Impresora")
Case 2
    Call Generar_Listado("Pantalla")
Case 3
    Unload Me

End Select

End Sub

