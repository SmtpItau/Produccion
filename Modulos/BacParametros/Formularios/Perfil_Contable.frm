VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Begin VB.Form Perfil_contable 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Perfiles Contables"
   ClientHeight    =   6660
   ClientLeft      =   300
   ClientTop       =   1350
   ClientWidth     =   11520
   Icon            =   "Perfil_Contable.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6660
   ScaleWidth      =   11520
   Begin MSComctlLib.ImageList ImageList3 
      Left            =   5625
      Top             =   4320
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
            Picture         =   "Perfil_Contable.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Contable.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Contable.frx":0A78
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   240
      Top             =   3240
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   18
      ImageHeight     =   18
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Contable.frx":0ECA
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Contable.frx":1034
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Contable.frx":119E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3870
      Top             =   4095
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
            Picture         =   "Perfil_Contable.frx":15F0
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Contable.frx":1A42
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Contable.frx":1E94
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Contable.frx":21AE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Contable.frx":2600
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Perfil_Contable.frx":291A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   6135
      Left            =   0
      TabIndex        =   0
      Top             =   510
      Width           =   11505
      _Version        =   65536
      _ExtentX        =   20285
      _ExtentY        =   10821
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
      Begin Threed.SSPanel SSPanel2 
         Height          =   3870
         Left            =   1275
         TabIndex        =   26
         Top             =   1710
         Width           =   8670
         _Version        =   65536
         _ExtentX        =   15293
         _ExtentY        =   6826
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
         BevelWidth      =   2
         BorderWidth     =   5
         BevelInner      =   1
         Begin VB.TextBox Txt_ingreso_PV 
            BackColor       =   &H00808000&
            BorderStyle     =   0  'None
            ForeColor       =   &H00FFFFFF&
            Height          =   285
            Left            =   2850
            TabIndex        =   30
            Text            =   "Text2"
            Top             =   1935
            Visible         =   0   'False
            Width           =   615
         End
         Begin Threed.SSFrame Frm_perfil_PV 
            Height          =   645
            Left            =   210
            TabIndex        =   27
            Top             =   330
            Width           =   8235
            _Version        =   65536
            _ExtentX        =   14526
            _ExtentY        =   1138
            _StockProps     =   14
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
            ShadowStyle     =   1
            Begin VB.ComboBox Cmb_Condiciones 
               Height          =   315
               Left            =   1620
               Style           =   2  'Dropdown List
               TabIndex        =   28
               Top             =   210
               Width           =   6525
            End
            Begin VB.Label Label4 
               AutoSize        =   -1  'True
               Caption         =   "Condición"
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
               Left            =   420
               TabIndex        =   29
               Top             =   300
               Width           =   855
            End
         End
         Begin MSFlexGridLib.MSFlexGrid Gr_perfil_PV 
            Height          =   2265
            Left            =   195
            TabIndex        =   31
            Top             =   975
            Width           =   8265
            _ExtentX        =   14579
            _ExtentY        =   3995
            _Version        =   393216
            FixedCols       =   0
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorBkg    =   -2147483645
            GridLines       =   2
            GridLinesFixed  =   0
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
         Begin MSComctlLib.Toolbar Toolbar3 
            Height          =   420
            Left            =   210
            TabIndex        =   32
            Top             =   3255
            Width           =   795
            _ExtentX        =   1402
            _ExtentY        =   741
            ButtonWidth     =   661
            ButtonHeight    =   635
            Appearance      =   1
            ImageList       =   "ImageList2"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   2
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Insertar Linea"
                  ImageIndex      =   1
               EndProperty
               BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Eliminar Linea"
                  ImageIndex      =   2
               EndProperty
            EndProperty
         End
         Begin MSComctlLib.Toolbar Toolbar5 
            Height          =   480
            Left            =   7545
            TabIndex        =   33
            Top             =   3210
            Width           =   915
            _ExtentX        =   1614
            _ExtentY        =   847
            ButtonWidth     =   767
            ButtonHeight    =   741
            Appearance      =   1
            ImageList       =   "ImageList3"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   2
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Aceptar"
                  ImageIndex      =   1
               EndProperty
               BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Cancelar"
                  ImageIndex      =   2
               EndProperty
            EndProperty
         End
         Begin VB.Label Label3 
            Alignment       =   2  'Center
            Caption         =   "Condición Perfil Variable"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   240
            Left            =   1440
            TabIndex        =   34
            Top             =   1080
            Width           =   8400
         End
      End
      Begin VB.Frame Frm_Perfil 
         Caption         =   "Perfil Contable"
         ForeColor       =   &H00C00000&
         Height          =   3645
         Left            =   120
         TabIndex        =   1
         Top             =   2355
         Width           =   11205
         Begin MSComctlLib.Toolbar Toolbar2 
            Height          =   420
            Left            =   240
            TabIndex        =   25
            Top             =   3120
            Width           =   1185
            _ExtentX        =   2090
            _ExtentY        =   741
            ButtonWidth     =   661
            ButtonHeight    =   635
            Appearance      =   1
            ImageList       =   "ImageList2"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   3
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Agregar Linea"
                  ImageIndex      =   1
               EndProperty
               BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Eliminar Linea"
                  ImageIndex      =   2
               EndProperty
               BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Object.ToolTipText     =   "Perfil Variable"
                  ImageIndex      =   3
               EndProperty
            EndProperty
         End
         Begin VB.TextBox Txt_ingreso_campos 
            BackColor       =   &H00808000&
            BorderStyle     =   0  'None
            ForeColor       =   &H00FFFFFF&
            Height          =   285
            Left            =   1125
            TabIndex        =   2
            Text            =   "Text2"
            Top             =   1035
            Visible         =   0   'False
            Width           =   615
         End
         Begin MSFlexGridLib.MSFlexGrid Gr_perfil 
            Height          =   2850
            Left            =   105
            TabIndex        =   3
            Top             =   240
            Width           =   10980
            _ExtentX        =   19368
            _ExtentY        =   5027
            _Version        =   393216
            FixedCols       =   0
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorBkg    =   -2147483645
            GridLines       =   2
            GridLinesFixed  =   0
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
         Begin VB.Label Lbl_msg 
            BorderStyle     =   1  'Fixed Single
            Height          =   270
            Left            =   4305
            TabIndex        =   4
            Top             =   3240
            Width           =   6720
         End
      End
      Begin VB.Frame Frm_Tipo_movimiento 
         Caption         =   "Tipo Movimiento/Operación"
         ForeColor       =   &H00C00000&
         Height          =   2160
         Left            =   120
         TabIndex        =   5
         Top             =   120
         Width           =   11220
         Begin VB.ComboBox Cmb_Tipo_movimiento 
            Height          =   315
            Left            =   6750
            Style           =   2  'Dropdown List
            TabIndex        =   15
            Top             =   390
            Width           =   2055
         End
         Begin VB.ComboBox Cmb_Tipo_operacion 
            Height          =   315
            Left            =   1395
            Style           =   2  'Dropdown List
            TabIndex        =   14
            Top             =   825
            Width           =   3630
         End
         Begin VB.ComboBox Cmb_Tipo_Instrumento 
            Height          =   315
            Left            =   6750
            Style           =   2  'Dropdown List
            TabIndex        =   13
            Top             =   810
            Width           =   4290
         End
         Begin VB.ComboBox Cmb_Tipo_Moneda 
            Height          =   315
            Left            =   1380
            Style           =   2  'Dropdown List
            TabIndex        =   12
            Top             =   1245
            Width           =   3660
         End
         Begin VB.ComboBox Cmb_Tipo_Voucher 
            Height          =   315
            Left            =   6765
            Style           =   2  'Dropdown List
            TabIndex        =   11
            Top             =   1230
            Width           =   1695
         End
         Begin VB.TextBox Txt_Glosa 
            Height          =   315
            Left            =   1365
            TabIndex        =   10
            Text            =   "Text1"
            Top             =   1650
            Width           =   9100
         End
         Begin VB.CommandButton cmd_ayuda_perfil 
            Caption         =   "?"
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
            Left            =   3600
            TabIndex        =   9
            Top             =   390
            Width           =   255
         End
         Begin VB.ComboBox Cmb_Sistema 
            Height          =   315
            Left            =   1395
            Style           =   2  'Dropdown List
            TabIndex        =   8
            Top             =   390
            Width           =   2175
         End
         Begin VB.ComboBox Cmb_Control_Instrumento 
            Height          =   315
            Left            =   8865
            Style           =   2  'Dropdown List
            TabIndex        =   7
            Top             =   390
            Visible         =   0   'False
            Width           =   585
         End
         Begin VB.ComboBox Cmb_Control_Moneda 
            Height          =   315
            ItemData        =   "Perfil_Contable.frx":2C36
            Left            =   9480
            List            =   "Perfil_Contable.frx":2C38
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   390
            Visible         =   0   'False
            Width           =   585
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Tipo Movimiento"
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
            Left            =   5265
            TabIndex        =   23
            Top             =   405
            Width           =   1410
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Tipo Operación"
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
            Left            =   60
            TabIndex        =   22
            Top             =   870
            Width           =   1320
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Instrum./Moneda"
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
            Left            =   5295
            TabIndex        =   21
            Top             =   870
            Width           =   1455
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
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
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   3
            Left            =   90
            TabIndex        =   20
            Top             =   1275
            Width           =   690
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Glosa Voucher"
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
            Left            =   60
            TabIndex        =   19
            Top             =   1695
            Width           =   1260
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Tipo Voucher"
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
            Left            =   5310
            TabIndex        =   18
            Top             =   1275
            Width           =   1155
         End
         Begin VB.Label Lbl_existe_perfil 
            AutoSize        =   -1  'True
            Caption         =   "No existe perfil"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   225
            Left            =   3885
            TabIndex        =   17
            Top             =   435
            Visible         =   0   'False
            Width           =   1245
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Sistema"
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
            Left            =   60
            TabIndex        =   16
            Top             =   450
            Width           =   675
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   24
      Top             =   0
      Width           =   11520
      _ExtentX        =   20320
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Refrescar Datos"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "Perfil_contable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
' Perfil Fijo
Const C_CAMPO = 0
Const C_DESC_CAMPO = 1
Const C_TIPO_MOV = 2
Const C_PERFIL_FIJO = 3
Const C_NCUENTA = 4
Const C_DESC_CUENTA = 5
Const C_CAMPO_VARIABLE = 6
' Perfil Variable
Const C2_VALOR = 0
Const C2_NCUENTA = 1
Const C2_DESC_CUENTA = 2
Const C2_CODIGO_CONDICION = 4
Const C2_CODIGO_VALOR = 5
Const C2_CODIGO = 0

Public Gr_Filas      As Single
Public Filas         As Single
Public varpsSql      As String
Public Folio_Perfil  As Long
Public varNumeros    As Integer

Dim SQL$
Dim i&

Function BUSCAR_CUENTA(Cuenta As String) As String
   Dim Datos()
   Dim SQL     As String

   Envia = Array()
   AddParam Envia, Cuenta
   If Not Extended.Bac_Sql_Execute("SP_BUSCA_CUENTA_CONTABLE ", Envia) Then
      MsgBox "Error : La Busqueda No Termino", vbCritical, TITSISTEMA
      Exit Function
   End If
   Do While Extended.Bac_SQL_Fetch(Datos())
      BUSCAR_CUENTA = Trim(Datos(1))
   Loop
End Function

Function FUNC_BUSCAR_PERFIL_VARIABLE(Filas As Single)
   Dim Datos()
   Dim SQL  As String
   Dim X    As Integer

   Envia = Array()
   AddParam Envia, Trim(Right(Cmb_Sistema, 7))
   AddParam Envia, gsBAC_User
   AddParam Envia, Filas
   AddParam Envia, Folio_Perfil
   If Not Extended.Bac_Sql_Execute("EXECUTE Sp_Buscar_Perfiles_Variables ", Envia) Then
      MsgBox "Error : en la Cargatura de Perfiles Variables", vbCritical, TITSISTEMA
      Exit Function
   End If
   
   Call PROC_CREA_GRILLA_PERFIL_PV
   X = 0
   
   Do While Extended.Bac_SQL_Fetch(Datos())
      X = X + 1
      Call TextMatrix(Gr_perfil_PV, X, 0, Datos(2))
      Call TextMatrix(Gr_perfil_PV, X, 1, Datos(3))
      Call TextMatrix(Gr_perfil_PV, X, 2, Datos(4))
   Loop

End Function


Function FUNC_VALIDA_CAMPO(campo As String) As Integer
   Dim Datos()

   Screen.MousePointer = 11

   FUNC_VALIDA_CAMPO = False

   Envia = Array()
   AddParam Envia, campo
   AddParam Envia, Trim(Right(Cmb_Sistema.Text, 7))
   AddParam Envia, Trim(Right(Cmb_Tipo_movimiento.Text, 5))
   AddParam Envia, Trim(Right(Cmb_Tipo_operacion.Text, 5))
   If Not Extended.Bac_Sql_Execute("SP_BUSCA_CAMPO_PERFIL ", Envia) Then
      Screen.MousePointer = 0
      Exit Function
   End If
   Screen.MousePointer = 0
   If Not Extended.Bac_SQL_Fetch(Datos()) Then
      MsgBox "Campo NO Existe.", vbCritical, TITSISTEMA
      Call TextMatrix(Gr_perfil, Gr_perfil.Row + 1, C_DESC_CAMPO, "")
      Exit Function
   End If

   Gr_perfil.Col = C_DESC_CAMPO
   Gr_perfil.Text = Trim(Datos(1))
   Gr_perfil.Col = C_CAMPO
   
   FUNC_VALIDA_CAMPO = True
End Function

Function FUNC_VALIDA_INDICADOR(Indicador As String) As Integer
   Dim Datos()

   FUNC_VALIDA_INDICADOR = False

   Envia = Array()
   AddParam Envia, Indicador
   If Not Extended.Bac_Sql_Execute("SP_BUSCA_INDICADOR", Envia) Then
      MsgBox "Error : Al Cargar datos", vbCritical, TITSISTEMA
      Exit Function
   End If
   If Not Extended.Bac_SQL_Fetch(Datos()) Then
      MsgBox "Indicador NO Existe.", vbCritical, TITSISTEMA
      Exit Function
   End If
   If CDbl(Datos(1)) <> 1 Then
      MsgBox "Indicador NO Existe.", vbCritical, TITSISTEMA
      Exit Function
   End If
   FUNC_VALIDA_INDICADOR = True
End Function

Function FUNC_VALIDA_INGRESO_FIJO() As Integer
   FUNC_VALIDA_INGRESO_FIJO = False

   If Gr_perfil.Col = C_CAMPO Then
      If Not FUNC_VALIDA_CAMPO(Txt_ingreso_campos.Text) Then
         Exit Function
      Else
         Gr_perfil.Text = Txt_ingreso_campos.Text
      End If
      SendKeys "{RIGHT 2}"
   End If
   If Gr_perfil.Col = C_NCUENTA Then
      If Not FUNC_VALIDA_CUENTA(FUNC_FORMATO_CUENTA(Txt_ingreso_campos.Text, "F"), "PF") Then
         Exit Function
      Else
         Gr_perfil.Text = FUNC_FORMATO_CUENTA(Txt_ingreso_campos.Text, "F")
      End If
      SendKeys "{DOWN}"
      SendKeys "{HOME}"
   End If

   If Gr_perfil.Col = C_PERFIL_FIJO Then
      If Trim(Txt_ingreso_campos.Text) <> "S" And Trim(Txt_ingreso_campos.Text) <> "N" Then
         Exit Function
      Else
         Gr_perfil.Text = Trim(Txt_ingreso_campos.Text)
         Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_NCUENTA, "")
         Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_DESC_CUENTA, "")
         If Gr_perfil.Text = "N" Then
            Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_DESC_CUENTA, "PERFIL VARIABLE NO COMPLETO")
         Else
            SendKeys "{RIGHT}"
         End If
      End If
   End If
   
   If Gr_perfil.Col = C_TIPO_MOV Then
      If Trim(Txt_ingreso_campos.Text) <> "D" And Trim(Txt_ingreso_campos.Text) <> "H" Then
         Exit Function
      Else
         Gr_perfil.Text = Trim(Txt_ingreso_campos.Text)
      End If
      SendKeys "{RIGHT}"
   End If
   FUNC_VALIDA_INGRESO_FIJO = True
End Function

Function FUNC_VALIDA_INGRESO_PERFIL(grilla_valida As String) As Integer
   Dim Con_info      As Integer
   Dim Descripcion   As String
   Dim i             As Integer

   FUNC_VALIDA_INGRESO_PERFIL = False
   
   Con_info = False

   If grilla_valida = "PF" Then
      If Trim(Txt_Glosa.Text) = "" Then
         Exit Function
      End If
      
      For i% = 1 To Gr_perfil.Rows - 1
         If Trim(TextMatrix(Gr_perfil, i%, C_CAMPO, "X")) <> "" Then
            If Trim(TextMatrix(Gr_perfil, i%, C_TIPO_MOV, "X")) = "" Or Trim(TextMatrix(Gr_perfil, i%, C_PERFIL_FIJO, "X")) = "" Then
               Exit Function
            End If
            If Trim(TextMatrix(Gr_perfil, i%, C_PERFIL_FIJO, "X")) = "S" And Trim(TextMatrix(Gr_perfil, i%, C_NCUENTA, "X")) = "" Then
               Exit Function
            End If
            Con_info = True
         End If
      Next i%
   End If

   If grilla_valida = "PV" Then
      For i% = 1 To Gr_perfil_PV.Rows - 1
         If Trim(TextMatrix(Gr_perfil_PV, i%, C2_CODIGO, "X")) <> "" And Trim(TextMatrix(Gr_perfil_PV, i%, C2_NCUENTA, "X")) = "" Then
            Exit Function
         End If
         If Trim(TextMatrix(Gr_perfil_PV, i%, C2_NCUENTA, "X")) <> "" And Trim(TextMatrix(Gr_perfil_PV, i%, C2_CODIGO, "X")) = "" Then
            Exit Function
         End If
         If Trim(TextMatrix(Gr_perfil_PV, i%, C2_CODIGO, "X")) <> "" And Trim(TextMatrix(Gr_perfil_PV, i%, C2_NCUENTA, "X")) <> "" Then
            Con_info = True
         End If
      Next i%
   End If

   FUNC_VALIDA_INGRESO_PERFIL = True
   
End Function

Function FUNC_VALIDA_INGRESO_PV()
   Dim Datos()
   
   FUNC_VALIDA_INGRESO_PV = False
   If Gr_perfil_PV.Col = 1 Then
      If Not FUNC_VALIDA_CUENTA(FUNC_FORMATO_CUENTA(Txt_ingreso_PV.Text, "F"), "PV") Then
         Exit Function
      Else
         Gr_perfil_PV.Text = FUNC_FORMATO_CUENTA(Txt_ingreso_PV.Text, "F")
      End If
      SendKeys "{RIGHT}"
   End If
   FUNC_VALIDA_INGRESO_PV = True
End Function

Function FUNC_VALIDA_INSTRUMENTO_IRF(familia_instrumento As String)
   Dim Datos()
   FUNC_VALIDA_INSTRUMENTO_IRF = False

   Envia = Array()
   AddParam Envia, familia_instrumento
   If Not Extended.Bac_Sql_Execute("SP_BUSCA_RFI_INSTRUMENTO", Envia) Then
      MsgBox "Instrumento NO Existe.", vbCritical, TITSISTEMA
      Exit Function
   End If
   If Not Extended.Bac_SQL_Fetch(Datos()) Then
      MsgBox "Instrumento NO Existe.", vbCritical, TITSISTEMA
      Exit Function
   End If
   If CDbl(Datos(1)) = 1 Then
      MsgBox "Instrumento NO Existe.", vbCritical, TITSISTEMA
      Exit Function
   End If
   FUNC_VALIDA_INSTRUMENTO_IRF = True
End Function

Function FUNC_VALIDA_MONEDA(Moneda As String) As Integer
   Dim Datos()

   FUNC_VALIDA_MONEDA = False

   Envia = Array()
   AddParam Envia, "B"
   AddParam Envia, Moneda
   AddParam Envia, ""
   If Not Extended.Bac_Sql_Execute("SP_GRABA_BUSCA_MONEDA ", Envia) Then
      MsgBox "Moneda NO Existe.", vbCritical, TITSISTEMA
      Exit Function
   End If
   If Not Extended.Bac_SQL_Fetch(Datos()) Then
      MsgBox "Moneda NO Existe.", vbCritical, TITSISTEMA
      Exit Function
   End If
   FUNC_VALIDA_MONEDA = True
End Function

Sub GENERAR_LISTADO()
   
   If Not FUNC_VALIDA_INGRESO_PERFIL("PF") Then
      MsgBox "Falta Información para Imprimir.", vbCritical, TITSISTEMA
      Exit Sub
   End If
   On Error GoTo Control:
    
   Call limpiar_cristal
   Screen.MousePointer = vbHourglass
   BACSwapParametros.BACParam.Destination = crptToWindow
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacPerfilContable.RPT"
   BACSwapParametros.BACParam.StoredProcParam(0) = Folio_Perfil
   BACSwapParametros.BACParam.StoredProcParam(1) = Trim(Right(Cmb_Sistema, 7))
   
   BACSwapParametros.BACParam.WindowTitle = "LISTADO DE PERFIL CONTABLE"
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.Action = 1
   Screen.MousePointer = vbDefault
Exit Sub
Control:
   MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
   Screen.MousePointer = 0
End Sub

Sub PROC_ASIGNA_COMBOS()

   For i = 0 To Cmb_Sistema.ListCount - 1
      Cmb_Sistema.ListIndex = i
      If Right(Cmb_Sistema.Text, 3) = Mid(Glob_Registro_Ayuda, 1, 3) Then
         Exit For
      End If
   Next i

   For i = 0 To Cmb_Tipo_movimiento.ListCount - 1
      Cmb_Tipo_movimiento.ListIndex = i
      If Right(Cmb_Tipo_movimiento.Text, 3) = Mid(Glob_Registro_Ayuda, 4, 3) Then
         Exit For
      End If
   Next i

   For i = 0 To Cmb_Tipo_operacion.ListCount - 1
      Cmb_Tipo_operacion.ListIndex = i
      If Right(Cmb_Tipo_operacion.Text, 3) = Mid(Glob_Registro_Ayuda, 7, 3) Then
         Exit For
      End If
   Next i

End Sub

Sub PROC_BUSCA_PERFIL(Numero As Long)
   Dim Datos()
   Dim SQL     As String
   Dim X       As Integer
   
   Screen.MousePointer = 11

   Lbl_existe_perfil.Caption = "N"
    
   Envia = Array()
   AddParam Envia, Trim(Right(Cmb_Sistema, 7))
   AddParam Envia, gsBAC_User$
   AddParam Envia, Numero
   If Not Extended.Bac_Sql_Execute("sp_buscar_perfiles ", Envia) Then
      Screen.MousePointer = 0
      Exit Sub
   End If
   If Extended.Bac_SQL_Fetch(Datos()) Then
      Lbl_existe_perfil.Caption = "S"
      For X = 0 To Cmb_Sistema.ListCount - 1
         If Trim(Right(Cmb_Sistema.List(X), 7)) = Trim(Datos(1)) Then
            Cmb_Sistema.ListIndex = CDbl(X)
            Exit For
         End If
      Next X
      
      For X = 0 To Cmb_Tipo_movimiento.ListCount - 1
         If Trim(Right(Cmb_Tipo_movimiento.List(X), 7)) = Trim(Datos(2)) Then
            Cmb_Tipo_movimiento.ListIndex = CDbl(X)
            Exit For
         End If
      Next X
        
      For X = 0 To Cmb_Tipo_operacion.ListCount - 1
         If Trim(Right(Cmb_Tipo_operacion.List(X), 7)) = Trim(Datos(3)) Then
            Cmb_Tipo_operacion.ListIndex = CDbl(X)
            Exit For
         End If
      Next X
        
      For X = 0 To Cmb_Tipo_Instrumento.ListCount - 1
         If Trim(Mid(Cmb_Tipo_Instrumento.List(X), 1, 6)) = Trim(Datos(5)) Then
            Cmb_Tipo_Instrumento.ListIndex = CDbl(X)
            Exit For
         End If
      Next X
      
      For X = 0 To Cmb_Tipo_Moneda.ListCount - 1
         If Trim(Right(Cmb_Tipo_Moneda.List(X), 7)) = Trim(Datos(6)) Then
            Cmb_Tipo_Moneda.ListIndex = CDbl(X)
            Exit For
         End If
      Next X
      Txt_Glosa.Text = Trim(Datos(8))
   Else
      If Cmb_Tipo_movimiento <> "" Then
         Txt_Glosa.Text = Trim(Left(Cmb_Tipo_movimiento, Len(Cmb_Tipo_movimiento) - 3))
         Txt_Glosa.Text = Txt_Glosa.Text & " " & Trim(Left(Cmb_Tipo_operacion, Len(Cmb_Tipo_operacion) - 5))
      Else
         MsgBox "No existen datos", vbCritical, TITSISTEMA
         Screen.MousePointer = 0
         Exit Sub
      End If
   End If

   Envia = Array()
   AddParam Envia, Numero
   AddParam Envia, Trim(Right(Cmb_Sistema, 7))
   If Not Extended.Bac_Sql_Execute("sp_buscar_detalle_perfiles ", Envia) Then
      Screen.MousePointer = 0
      Exit Sub
   End If
   X = 0
   Do While Extended.Bac_SQL_Fetch(Datos())
      X = X + 1
      If X > Gr_perfil.Rows - 2 Then
         Gr_perfil.Rows = Gr_perfil.Rows + 1
      End If
      Call TextMatrix(Gr_perfil, X, 0, CDbl(Datos(2)))
      Call TextMatrix(Gr_perfil, X, 1, Datos(8))
      Call TextMatrix(Gr_perfil, X, 2, Datos(3))
      Call TextMatrix(Gr_perfil, X, 3, Datos(4))
      Call TextMatrix(Gr_perfil, X, 4, Datos(5))
      Call TextMatrix(Gr_perfil, X, 5, IIf(Datos(4) <> "N", Datos(9), "PERFIL VARIABLE COMPLETO"))
      Call TextMatrix(Gr_perfil, X, C_CAMPO_VARIABLE, Format(CDbl(Datos(7)), "##0"))
   Loop
   
   Screen.MousePointer = 0
   PROC_HABILITA False
End Sub

Sub PROC_CARGA_COMBO_MOVIMIENTO()
   On Error GoTo CargaData
   Dim Datos()
   Dim SQL     As String
    
   Envia = Array()
   AddParam Envia, Trim(Right$(Cmb_Sistema.Text, 7))
   If Not Extended.Bac_Sql_Execute("sp_cnt_leermovimientos", Envia) Then
      MsgBox "Problemas en obtención de información del servidor ", vbCritical, TITSISTEMA
      Exit Sub
   End If
   Cmb_Tipo_movimiento.Clear
   Do While Extended.Bac_SQL_Fetch(Datos())
      Cmb_Tipo_movimiento.AddItem Trim$(Datos(2)) & Space(50) & Datos(1)
   Loop
   Cmb_Tipo_movimiento.Enabled = True
      
   If Cmb_Tipo_movimiento.ListCount <> 0 Then
      Cmb_Tipo_movimiento.ListIndex = 0
   End If

Exit Sub
CargaData:
   MsgBox "Problemas en carga de información de objetos: " & Err.Description & ". Comunique al Administrador.", vbCritical, TITSISTEMA
End Sub

Sub PROC_CARGA_COMBO_TIPO_OPERACION()
    Dim Datos()
    Dim SQL         As String

    Cmb_Tipo_operacion.Clear
    Cmb_Control_Instrumento.Clear
    Cmb_Control_Moneda.Clear

    Envia = Array()
    AddParam Envia, Trim(Right$(Cmb_Sistema.Text, 7))
'--> Garantias
    If Cmb_Tipo_movimiento.ListCount > 0 Then
        AddParam Envia, Trim(Right$(Cmb_Tipo_movimiento.Text, 5))
    End If
'--> Garantias
    If Not Extended.Bac_Sql_Execute("sp_cnt_leeroperaciones", Envia) Then
       MsgBox "Problemas en obtención de información del servidor ", vbCritical, TITSISTEMA
       Exit Sub
    End If
    Do While Extended.Bac_SQL_Fetch(Datos())
       Cmb_Tipo_operacion.AddItem Trim$(Datos(2)) & Space(150) & Datos(1)
       Cmb_Control_Instrumento.AddItem Trim$(Datos(3))
       Cmb_Control_Moneda.AddItem Trim$(Datos(4))
    Loop
    Cmb_Tipo_operacion.Enabled = True
    If Cmb_Tipo_operacion.ListCount <> 0 Then
       Cmb_Tipo_operacion.ListIndex = 0
    End If

End Sub



Sub PROC_CARGA_COMBO_MONEDA()
    On Error GoTo ErrMon
    Dim Datos()
    Dim SQL     As String
  
    Envia = Array()
    AddParam Envia, Trim(Right$(Cmb_Sistema.Text, 7))
    '--> Garantias
    If Cmb_Tipo_movimiento.ListCount > 0 Then
        AddParam Envia, Trim(Right$(Cmb_Tipo_movimiento.Text, 5))
    End If
    '--> Garantias

    If Not Extended.Bac_Sql_Execute("sp_cnt_listamonedas", Envia) Then
       MsgBox "Problemas en obtención de información del servidor ", vbCritical, TITSISTEMA
       Exit Sub
    End If
    Cmb_Tipo_Moneda.Clear
    Do While Extended.Bac_SQL_Fetch(Datos())
       If Datos(1) <> "NO HAY DATOS" Then
          Cmb_Tipo_Moneda.AddItem Left(Left(Datos(2) & Space(3), 3) & " " & Datos(3) & Space(90), 90) & CDbl(Datos(1))
       End If
    Loop
    Cmb_Tipo_Moneda.Enabled = True
    If Cmb_Tipo_Moneda.ListCount <> 0 Then
       Cmb_Tipo_Moneda.ListIndex = 0
    End If
    Cmb_Tipo_Moneda.Enabled = IIf(Cmb_Tipo_Moneda.ListCount <= 0, False, True)
   
Exit Sub
ErrMon:
   MsgBox "Problemas en carga de codigos de monedas", vbCritical, TITSISTEMA
End Sub


Sub PROC_CARGA_COMBO_INSTRUMENTOS()
   On Error GoTo ErrMon
   Dim Datos()
   Dim Cant       As Single
   Dim SQL        As String
    
   Cmb_Tipo_Instrumento.Clear

   '-- Esto lo setean las variables ver tabla MOVIMIENTO_CNT
   'If Trim(Right$(CMB_SISTEMA.Text, 7)) = "PCS" Then
   '   Exit Sub
   'End If

   Envia = Array()
   AddParam Envia, Trim(Right$(Cmb_Sistema.Text, 7))
   AddParam Envia, Trim(Right(Cmb_Tipo_movimiento.List(Cmb_Tipo_movimiento.ListIndex), 7))
   If Not Extended.Bac_Sql_Execute("sp_cnt_listainstrumentos", Envia) Then
      MsgBox "No Hay Perfiles Cargados ", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   Do While Extended.Bac_SQL_Fetch(Datos())
      If Datos(1) <> "NO HAY DATOS" Then
         Cant = (9 - Len(Trim(Datos(1))))
         Cmb_Tipo_Instrumento.AddItem Trim$(Datos(1)) & Space(Cant) & Datos(2)
      End If
   Loop
   If Cmb_Tipo_Instrumento.ListCount <> 0 Then
      Cmb_Tipo_Instrumento.ListIndex = 0
   End If

Exit Sub
ErrMon:
   MsgBox "No hay Instrumentos Cargados", vbExclamation, TITSISTEMA
End Sub


Sub PROC_CREA_GRILLA_PERFIL_PV()
   Gr_perfil_PV.Rows = 1
   Gr_perfil_PV.Cols = 1
   
   Gr_perfil_PV.Rows = 23
   Gr_perfil_PV.Cols = 3
   
   Gr_perfil_PV.FixedRows = 1
   Gr_perfil_PV.FixedCols = 0
   
   Gr_perfil_PV.Row = 0
   Gr_perfil_PV.Col = C2_VALOR: Gr_perfil_PV.Text = "Valor"
   Gr_perfil_PV.Col = C2_NCUENTA: Gr_perfil_PV.Text = "Cuenta"
   Gr_perfil_PV.Col = C2_DESC_CUENTA: Gr_perfil_PV.Text = "Descripción Cuenta"
   
   Gr_perfil_PV.ColWidth(C2_VALOR) = 1000
   Gr_perfil_PV.ColWidth(C2_NCUENTA) = 1200
   Gr_perfil_PV.ColWidth(C2_DESC_CUENTA) = 5740 '4800
   
   Gr_perfil_PV.ColAlignment(C2_VALOR) = flexAlignLeftCenter
   Gr_perfil_PV.ColAlignment(C2_NCUENTA) = flexAlignLeftCenter
   Gr_perfil_PV.ColAlignment(C2_DESC_CUENTA) = flexAlignLeftCenter
   
   Gr_perfil_PV.Row = 1
   Gr_perfil_PV.Col = 0
End Sub

Sub PROC_ELIMINA_PERFIL()
   Dim Datos()
   Dim Error            As Integer
   Dim Sistema          As String
   Dim Tipo_movimiento  As String
   Dim Tipo_Operacion   As String

    Error = False
    
   If Not Extended.Bac_Sql_Execute("BEGIN TRANSACTION") Then
      Exit Sub
   End If

   Sistema = Trim(Right(Cmb_Sistema.Text, 7))
   Tipo_movimiento = Trim(Right(Cmb_Tipo_movimiento.Text, 5))
   Tipo_Operacion = Trim(Right(Cmb_Tipo_operacion.Text, 5))

   Envia = Array()
   AddParam Envia, Folio_Perfil
   If Not Extended.Bac_Sql_Execute("SP_ELIMINA_PERFIL", Envia) Then
      If Not Bac_Sql_Execute("ROLLBACK") Then
         Error = True
      End If
      Error = True
   Else
      If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
         Error = True
      End If
   End If
   
   If Error Then
      MsgBox "Perfil NO Eliminado.", vbCritical, TITSISTEMA
   End If

   Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_551 ", "03", "Eliminado", " ", " ", "Eliminado Perfil: " & Sistema & " " & Tipo_movimiento & " " & Tipo_Operacion)
   Call PROC_LIMPIA
     
   Cmb_Sistema.SetFocus
End Sub

Private Sub Grabacion_Perfil()
   On Error GoTo ErrSaveData
   Dim Datos()
   Dim iContador        As Long
   Dim Sistema          As String
   Dim TipoMovimiento   As String
   Dim tipoOperacion    As String
   Dim CreaPerfil       As String
   Dim SQL              As String
   
   If Not Extended.BacBeginTransaction Then
      Exit Sub
   End If
   
   Me.MousePointer = vbHourglass
   
   Sistema = Trim(Right(Cmb_Sistema.Text, 3))
   TipoMovimiento = Trim(Right(Cmb_Tipo_movimiento.Text, 5))
   tipoOperacion = Trim(Right(Cmb_Tipo_operacion.Text, 5))
   
   Envia = Array()
   AddParam Envia, CDbl(Folio_Perfil)
   If Not Extended.Bac_Sql_Execute("SP_ELIMINA_PERFIL ", Envia) Then
      GoTo ErrSaveData
   End If
   If Extended.Bac_SQL_Fetch(Datos()) Then
      If Datos(1) = "ERROR" Then
         GoTo ErrSaveData
      End If
   End If
   
   CreaPerfil = "S"
   For iContador = 1 To Gr_perfil.Rows - 1
      If Val(Gr_perfil.TextMatrix(iContador, C_CAMPO)) > 0 Then
         
         Envia = Array()
         AddParam Envia, CreaPerfil
         AddParam Envia, CDbl(Folio_Perfil)
         AddParam Envia, Sistema
         AddParam Envia, TipoMovimiento
         AddParam Envia, Trim(tipoOperacion)
         
         If Cmb_Tipo_Instrumento.ListIndex = -1 Then
            AddParam Envia, ""
         Else
            If Left(Cmb_Tipo_Instrumento.Text, 5) = "ICAP" Or Left(Cmb_Tipo_Instrumento.Text, 5) = "ICOL" Then
               AddParam Envia, Trim(Left(Cmb_Tipo_Instrumento, 5))
            End If
            AddParam Envia, Trim(Left(Cmb_Tipo_Instrumento, 6))
         End If
         If Cmb_Tipo_Moneda.ListIndex = -1 Then
            AddParam Envia, ""
         Else
            AddParam Envia, LTrim(Str(Trim(Right(Cmb_Tipo_Moneda.Text, 5))))
         End If
         AddParam Envia, Left(Cmb_Tipo_Voucher.Text, 1)
         AddParam Envia, Trim(UCase(Txt_Glosa.Text))
         AddParam Envia, CDbl(Gr_perfil.TextMatrix(iContador, C_CAMPO))
         AddParam Envia, Gr_perfil.TextMatrix(iContador, C_TIPO_MOV)
         AddParam Envia, Gr_perfil.TextMatrix(iContador, C_PERFIL_FIJO)
         AddParam Envia, Gr_perfil.TextMatrix(iContador, C_NCUENTA)
         AddParam Envia, CDbl(iContador)
         AddParam Envia, Val(Gr_perfil.TextMatrix(iContador, C_CAMPO_VARIABLE))
         AddParam Envia, gsBAC_User
         If Gr_perfil.TextMatrix(iContador, 3) = "N" Then                               ' Si graba el perfil vriable
            AddParam Envia, "S"
         Else
            AddParam Envia, "N"
         End If
         CreaPerfil = "N"
         
         If Not Extended.Bac_Sql_Execute("SP_GRABA_PERFIL ", Envia) Then
            GoTo ErrSaveData
         End If
      Else
         Exit For
      End If
   Next iContador
   
   If Not Extended.BacCommitTransaction() Then
      GoTo ErrSaveData
   End If
   
   Me.MousePointer = vbDefault
   
   MsgBox "Perfil Contable ha sido grabado en forma Correcta.", vbInformation, TITSISTEMA
   Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_551", "01", "GRABA", " ", " ", " ")
   On Error GoTo 0
   
Exit Sub
ErrSaveData:
   Me.MousePointer = vbDefault
   Call BacRollBackTransaction
   MsgBox "Acción Cancelada" & vbCrLf & vbCrLf & "Imposible Actualizar el Perfil." & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
End Sub

Sub PROC_GRABA_PERFIL()
   Call Grabacion_Perfil
End Sub

Sub PROC_HABILITA(modo As Boolean)
   Cmb_Sistema.Enabled = modo
   Cmb_Tipo_movimiento.Enabled = modo
   Cmb_Tipo_operacion.Enabled = modo
   cmd_ayuda_perfil.Enabled = modo
   Cmb_Tipo_Moneda.Enabled = modo
   Cmb_Tipo_Instrumento.Enabled = modo
End Sub

Sub PROC_HABILITA_PV(modo As Integer)
   Toolbar1.Buttons(1).Enabled = modo
   Toolbar1.Buttons(2).Enabled = modo
   Toolbar1.Buttons(4).Enabled = modo
   
   Frm_Tipo_movimiento.Enabled = modo
   Frm_Perfil.Enabled = modo
End Sub

Sub PROCESO_LIMPIA_TABLA()
   Envia = Array()
   AddParam Envia, Trim(Right(Cmb_Sistema, 7))
   AddParam Envia, gsBAC_User
   If Folio_Perfil = 0 Then
      AddParam Envia, -1
   Else
      AddParam Envia, -2
   End If
   AddParam Envia, Folio_Perfil
   If Not Extended.Bac_Sql_Execute("SP_BORRA_PERFIL_VARIABLE ", Envia) Then
      Screen.MousePointer = 0
      MsgBox "No se pudo Limpiar datos de Paso", vbCritical, TITSISTEMA
   End If
End Sub

Sub PROC_LIMPIA()
   Call PROCESO_LIMPIA_TABLA
   
   Folio_Perfil = 0
   Perfil_contable.Caption = "Perfiles Contables"
    
   Cmb_Sistema.Enabled = True
   Cmb_Tipo_movimiento.Enabled = True
   Cmb_Tipo_operacion.Enabled = True
    
   Call PROC_HABILITA_PV(True)
   Call PROC_HABILITA(True)

   SSPanel2.Visible = False
   Call PROC_CREA_GRILLA_PERFIL
   Call PROC_CREA_GRILLA_PASO
   
   Txt_Glosa.Text = ""
   Lbl_msg.Caption = ""
   Lbl_existe_perfil.Caption = "N"

   Frm_Perfil.Enabled = False
   Toolbar1.Buttons(4).Enabled = True
   Toolbar1.Buttons(1).Enabled = True
   Toolbar1.Buttons(2).Enabled = True
   Toolbar1.Buttons(5).Enabled = False
    
   Cmb_Tipo_Voucher.ListIndex = -1
   Cmb_Tipo_movimiento.ListIndex = -1
   Cmb_Tipo_Instrumento.ListIndex = -1
   Cmb_Sistema.ListIndex = -1
   Cmb_Tipo_Moneda.ListIndex = -1
   
   Gr_perfil_PV.Refresh
   Gr_perfil.Refresh
End Sub



Sub PROC_CARGA_COMBO_SISTEMA()
   On Error GoTo ErrCarga
   Dim Datos()
   Dim SQL     As String

   If Extended.Bac_Sql_Execute("SP_BUSCAR_SISTEMAS") Then
      Do While Extended.Bac_SQL_Fetch(Datos())
         Cmb_Sistema.AddItem Mid$(Datos(2), 1, 20) & Space(50) & Datos(1)
      Loop
   Else
      MsgBox "No se pudo obtener información del servidor", vbCritical, TITSISTEMA
      Exit Sub
   End If
   Cmb_Tipo_Voucher.AddItem "INGRESO"
   Cmb_Tipo_Voucher.AddItem "EGRESO"
   Cmb_Tipo_Voucher.AddItem "TRASPASO"
   Cmb_Tipo_movimiento.ListIndex = -1
   Cmb_Tipo_Instrumento.ListIndex = -1
Exit Sub
ErrCarga:
   MsgBox "Se detectó problemas en carga de información: " & Err.Description & ". Comunique al Administrador.", vbCritical, TITSISTEMA
   Exit Sub
End Sub

Function TextMatrix(grilla As Control, Fila As Integer, Columna As Integer, dato As Variant) As Variant
   Dim fil_g   As Integer
   Dim col_g   As Integer
   
   fil_g = grilla.Row
   col_g = grilla.Col
   If grilla.Rows <= Fila Then
      grilla.Rows = grilla.Rows + 1
   End If
   If dato = "X" Then
      TextMatrix = grilla.TextMatrix(Fila, Columna)
   Else
      grilla.TextMatrix(Fila, Columna) = dato
   End If
   
   grilla.Row = fil_g
   grilla.Col = col_g
End Function

Private Sub Cmb_Condiciones_Click()
   Dim SQL     As String
   Dim X       As Integer
   Dim Datos()
   
   For X = 1 To Gr_perfil.Rows - 1
      Call TextMatrix(Gr_perfil_PV, X, C2_VALOR, "")
      Call TextMatrix(Gr_perfil_PV, X, C2_NCUENTA, "")
      Call TextMatrix(Gr_perfil_PV, X, C2_DESC_CUENTA, "")
   Next X
    
   Call PROC_CREA_GRILLA_PERFIL_PV
   
   Envia = Array()
   AddParam Envia, Folio_Perfil
   AddParam Envia, Gr_Filas
   AddParam Envia, CDbl(Right(Cmb_Condiciones.Text, 7))
   If Not Extended.Bac_Sql_Execute("SP_BUSCAR_PERILES_VARIABLES ", Envia) Then
      MsgBox "Error : Busqueda de Perfiles Variables", vbCritical, TITSISTEMA
      Exit Sub
   End If
   X = 0
   Do While Extended.Bac_SQL_Fetch(Datos())
      X = X + 1
      Call TextMatrix(Gr_perfil_PV, X, C2_VALOR, Datos(1))
      Call TextMatrix(Gr_perfil_PV, X, C2_NCUENTA, Datos(2))
      Call TextMatrix(Gr_perfil_PV, X, C2_DESC_CUENTA, Datos(3))
   Loop
End Sub

Private Sub Cmb_Sistema_Click()
   Call PROC_CARGA_COMBO_MOVIMIENTO
End Sub

Private Sub Cmb_sistema_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Cmb_Tipo_movimiento.SetFocus
   End If
End Sub

Private Sub Cmb_Tipo_Movimiento_Click()
   Call PROC_CARGA_COMBO_TIPO_OPERACION
   Call PROC_CARGA_COMBO_MONEDA

   If Cmb_Control_Moneda.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
      Cmb_Tipo_Moneda.ListIndex = -1
   End If
   Call PROC_CARGA_COMBO_INSTRUMENTOS
   If Cmb_Control_Instrumento.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
      Cmb_Tipo_Instrumento.ListIndex = -1
   End If
End Sub

Private Sub Cmb_Tipo_Movimiento_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Cmb_Tipo_operacion.SetFocus
   End If
End Sub

Private Sub Cmb_tipo_operacion_Click()
   If Cmb_Control_Instrumento.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
      Cmb_Tipo_Instrumento.ListIndex = -1
      Cmb_Tipo_Instrumento.Enabled = False
   Else
      Cmb_Tipo_Instrumento.Enabled = True
   End If
   If Cmb_Control_Moneda.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
      Cmb_Tipo_Moneda.ListIndex = -1
      Cmb_Tipo_Moneda.Enabled = False
   Else
      Cmb_Tipo_Moneda.Enabled = True
   End If
End Sub

Private Sub Cmb_Tipo_Operacion_KeyPress(KeyAscii As Integer)
   If Cmb_Tipo_Instrumento.Enabled Then
      Cmb_Tipo_Instrumento.SetFocus
   ElseIf Cmb_Tipo_Moneda.Enabled Then
      Cmb_Tipo_Moneda.SetFocus
   Else
      Cmb_Tipo_Voucher.SetFocus
   End If
End Sub

Private Sub Cmb_tipo_voucher_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Txt_Glosa.Enabled = True
      Txt_Glosa.SetFocus
   End If
End Sub


Sub PROC_CREA_GRILLA_PASO()

End Sub

Private Sub Cmd_Agrega_Click()

End Sub

Private Sub Cmd_ayuda_perfil_Click()
   On Error GoTo Errores:
    
   BacAyuda.Tag = "PERFIL"
   BacAyuda.parAyuda = "BAC_CNT_PERFIL"
   BacAyuda.parFiltro = Trim(Right(Cmb_Sistema.Text, 7))
   BacAyuda.Show 1

   If Trim(gsCodigo$) <> "" And giAceptar Then
      Folio_Perfil = CDbl(gsCodigo$)
      varNumeros = Folio_Perfil
      Perfil_contable.Caption = "Perfil Contable Nº: " + CStr(Folio_Perfil)
      Call PROC_BUSCA_PERFIL(Folio_Perfil)
      Frm_Perfil.Enabled = True
      Toolbar1.Buttons(4).Enabled = False
      Toolbar1.Buttons(1).Enabled = True
      Toolbar1.Buttons(2).Enabled = True
      Toolbar1.Buttons(5).Enabled = True
      Gr_perfil.Row = 1
      Gr_perfil.Col = C_CAMPO
      Gr_perfil.SetFocus
      SendKeys "^{HOME}"
   Else
      Cmb_Sistema.SetFocus
   End If

Exit Sub
Errores:
   Screen.MousePointer = 0
   MsgBox Error(Err), vbExclamation, TITSISTEMA
End Sub

Private Sub Cmd_Buscar_Click()

End Sub

Sub PROC_MARCA_FILA_GRILLA(Objeto_grid As Control, Color1, Color2, Fila, Columna)
   Dim fila_actual      As Integer
   Dim columna_actual   As Integer
   Dim estilo_fila      As Integer

   fila_actual% = Objeto_grid.Row
   columna_actual% = Objeto_grid.Col
   estilo_fila% = Objeto_grid.FillStyle
   Objeto_grid.Row = Fila
   Objeto_grid.Col = Columna
   Objeto_grid.FillStyle = flexFillRepeat
   Objeto_grid.Row = fila_actual%
   Objeto_grid.Col = columna_actual%
   Objeto_grid.FillStyle = estilo_fila%
End Sub

Function FUNC_FMT_NUMERO_TXT(Numero As Double, n_enteros, n_decimales As Integer) As String
   Dim fmt_numero    As String
   Dim fmt_enteros   As String
   Dim fmt_decimales As String

   If Numero < 0 Then
      Numero = Numero * -1
   End If

   fmt_enteros = String(n_enteros, "0")
   fmt_decimales = String(n_decimales, "0")
   fmt_numero = Format(Numero, fmt_enteros + "." + fmt_decimales)

   FUNC_FMT_NUMERO_TXT = Mid(fmt_numero, 1, n_enteros) + Mid(fmt_numero, n_enteros + 2, n_decimales)
End Function

Private Sub Cmb_Tipo_Moneda_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Cmb_Tipo_Voucher.Enabled = True
      Cmb_Tipo_Voucher.SetFocus
   End If
End Sub

Private Sub Cmb_Tipo_Instrumento_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      If Cmb_Tipo_Moneda.Enabled Then
         Cmb_Tipo_Moneda.SetFocus
      Else
         Cmb_Tipo_Voucher.SetFocus
      End If
   End If
End Sub

Private Sub Form_Activate()
   Screen.MousePointer = vbNormal
End Sub

Private Sub Form_Load()
   Me.Top = 0: Me.Left = 0
    
   Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_551", "07", "INGRESO A OPCION MENU", " ", " ", " ")
   Toolbar1.Buttons(5).Enabled = False
   Call PROC_CARGA_COMBO_SISTEMA    '  Carga Combos iniciales
   
   If Cmb_Sistema.ListCount <= 0 Then
      Exit Sub
   Else
      Txt_Glosa.Enabled = True
      Call PROC_LIMPIA
   End If
End Sub

Function FUNC_FORMATO_CUENTA(texto As String, Formato As String) As String
   If Trim(texto) = "" Then
      FUNC_FORMATO_CUENTA = ""
      Exit Function
   End If
   FUNC_FORMATO_CUENTA = texto
End Function


Function FUNC_VALIDA_CUENTA(Cuenta As String, tipo_perfil As String) As Integer
   Dim Datos()
   
   Screen.MousePointer = 11
   FUNC_VALIDA_CUENTA = False

   Envia = Array()
   AddParam Envia, Cuenta
   If Not Extended.Bac_Sql_Execute("sp_busca_cuenta_contable ", Envia) Then
      Screen.MousePointer = 0
      Exit Function
   End If
   Screen.MousePointer = 0

   If Not Extended.Bac_SQL_Fetch(Datos()) Then
      MsgBox "Cuenta NO Existe.", vbCritical, TITSISTEMA
      Exit Function
   End If
   
   Select Case tipo_perfil
      Case "PF":  Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_DESC_CUENTA, Trim(Datos(1)))
      Case "PV":  Call TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row, C2_DESC_CUENTA, Trim(Datos(1)))
   End Select

   FUNC_VALIDA_CUENTA = True
End Function

Sub PROC_CREA_GRILLA_PERFIL()
   Gr_perfil.FixedRows = 0
   Gr_perfil.FixedCols = 0
   Gr_perfil.Rows = 1
   Gr_perfil.Cols = 1
   
   Gr_perfil.Rows = 23
   Gr_perfil.Cols = 7
   Gr_perfil.FixedRows = 1
   Gr_perfil.FixedCols = 0
   
   Gr_perfil.Row = 0
   Gr_perfil.Col = C_CAMPO: Gr_perfil.Text = "Campo"
   Gr_perfil.Col = C_DESC_CAMPO: Gr_perfil.Text = "Descripción Campo"
   Gr_perfil.Col = C_PERFIL_FIJO: Gr_perfil.Text = "P/F"
   Gr_perfil.Col = C_TIPO_MOV: Gr_perfil.Text = "T/M"
   Gr_perfil.Col = C_NCUENTA: Gr_perfil = "Cuenta"
   Gr_perfil.Col = C_DESC_CUENTA: Gr_perfil.Text = "Descripción Cuenta"
   
   Gr_perfil.ColWidth(C_CAMPO) = 700
   Gr_perfil.ColWidth(C_DESC_CAMPO) = 3500
   Gr_perfil.ColWidth(C_PERFIL_FIJO) = 430
   Gr_perfil.ColWidth(C_TIPO_MOV) = 400
   Gr_perfil.ColWidth(C_NCUENTA) = 1100
   Gr_perfil.ColWidth(C_DESC_CUENTA) = 4550
   Gr_perfil.ColWidth(C_CAMPO_VARIABLE) = 1
   
   Gr_perfil.ColAlignment(C_CAMPO) = 1
   Gr_perfil.ColAlignment(C_DESC_CAMPO) = 0
   Gr_perfil.ColAlignment(C_PERFIL_FIJO) = 0
   Gr_perfil.ColAlignment(C_TIPO_MOV) = 0
   Gr_perfil.ColAlignment(C_NCUENTA) = 0
   Gr_perfil.ColAlignment(C_DESC_CUENTA) = 0
   Gr_perfil.ColAlignment(C_CAMPO_VARIABLE) = 0
   
   Gr_perfil.Row = 1
   Gr_perfil.Col = 0
End Sub

Sub PROC_POSICIONA_TEXTO(grilla As Control, texto As Control)
   Dim n As Integer
   Dim i As Integer
   Dim f As Integer

   texto.Width = grilla.ColWidth(grilla.Col)
   texto.Height = grilla.RowHeight(grilla.Row)
 
   If grilla.TopRow > 1 Then
      texto.Top = grilla.Top + (((grilla.Row - grilla.TopRow) + 1) * 245)
   Else
      texto.Top = grilla.Top + (grilla.Row * 245)
   End If
   n = 0
   f = IIf(grilla.Col = 0, 0, grilla.Col - 1)
   If grilla.Col > 0 Then
      For i = 0 To f
         n = n + grilla.ColWidth(i) + 10
      Next i
   End If
   texto.Left = grilla.Left + n + 20
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call PROCESO_LIMPIA_TABLA
    Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_551", "08", "INGRESO A OPCION MENU", " ", " ", " ")
End Sub

Private Sub Gr_perfil_DblClick()
   Dim SQL            As String
   Dim campo_variable As Integer
   Dim Datos()

   Gr_Filas = Gr_perfil.Row

   If Gr_perfil.Col = C_PERFIL_FIJO Then
      If Trim(Gr_perfil.Text) = "S" Or Trim(Gr_perfil.Text) = "" Then
         Exit Sub
      End If
      Screen.MousePointer = 11
      Call PROC_HABILITA_PV(False)
      Call PROC_PASA_GRILLA_PV
      Call PROC_MARCA_FILA_GRILLA(Gr_perfil, G_COLOR_CLARO, G_COLOR_NEGRO, Gr_perfil.Row, 0)
   
      Envia = Array()
      AddParam Envia, Trim(Right(Cmb_Sistema, 7))
      AddParam Envia, Trim(Right(Cmb_Tipo_movimiento, 5))
      AddParam Envia, Trim(Right(Cmb_Tipo_operacion, 5))
      If Not Extended.Bac_Sql_Execute("sp_leer_campos ", Envia) Then
         Screen.MousePointer = 0
         MsgBox "Problemas en la Lectura de Campos.", vbCritical, TITSISTEMA
         Exit Sub
      End If
      Cmb_Condiciones.Clear
      Do While Extended.Bac_SQL_Fetch(Datos())
            Cmb_Condiciones.AddItem Trim(Datos(5)) + (Space(150 - Len(Trim(Datos(5))))) + Format(CDbl(Datos(4)), "#0")
      Loop
      
      If Cmb_Condiciones.ListCount <> 0 Then
         campo_variable = Val(TextMatrix(Gr_perfil, (Gr_perfil.Row), C_CAMPO_VARIABLE, "X"))
         If campo_variable > 0 Then
            For r% = 0 To Cmb_Condiciones.ListCount - 1
               Cmb_Condiciones.ListIndex = r%
               If campo_variable = CDbl(Right(Cmb_Condiciones.Text, 3)) Then
                  Exit For
               End If
            Next r%
         Else
            Cmb_Condiciones.ListIndex = 0
         End If
      End If
      
      Call FUNC_BUSCAR_PERFIL_VARIABLE(Gr_Filas)
      Screen.MousePointer = 0

      If Cmb_Condiciones.ListCount > 0 Then
         SSPanel2.Visible = True
         Gr_perfil_PV.SetFocus
         SendKeys "^{HOME}"
      Else
         MsgBox "No existen condiciones lógicas para este tipo de operación", vbInformation, TITSISTEMA
         PROC_HABILITA_PV True
      End If
   End If
   If Gr_perfil.Col = C_CAMPO Then
      BacAyuda.Tag = "CAMPOS"
      BacAyuda.parFiltro = Trim(Right(Cmb_Sistema.Text, 7)) + Trim(Right(Cmb_Tipo_movimiento.Text, 5)) + Trim(Right(Cmb_Tipo_operacion.Text, 5))
      BacAyuda.parAyuda = "CON_CAMPOS_PERFIL"

      BacAyuda.Show 1
      If giAceptar% = True Then
         If Trim(gsCodigo$) <> "" Then
            Txt_ingreso_campos.MaxLength = 5
            Txt_ingreso_campos.Text = Trim(gsCodigo$)
            Txt_Ingreso_Campos_KeyPress 13
         End If
      End If
   End If

   If Gr_perfil.Col = C_NCUENTA Then
      If Trim(TextMatrix(Gr_perfil, Gr_perfil.Row, C_PERFIL_FIJO, "X")) <> "S" Then
         Exit Sub
      End If
      BacAyuda.parAyuda = "CON_PLAN_CUENTAS"
      BacAyuda.Tag = "CUENTAS"
      BacAyuda.parFiltro = ""
      BacAyuda.Show 1
      If giAceptar = True Then
         If Trim(gsCodigo$) <> "" Then
            Txt_ingreso_campos.MaxLength = 12
            Txt_ingreso_campos.Text = FUNC_FORMATO_CUENTA(Trim(gsCodigo$), "D")
            Txt_Ingreso_Campos_KeyPress 13
         End If
      End If
   End If
End Sub

Private Sub Gr_perfil_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      SendKeys "{RIGHT}"
      Exit Sub
   End If
   KeyAscii = Asc(UCase(Chr(KeyAscii)))

   If KeyAscii = 27 Or Gr_perfil.Col = C_DESC_CAMPO Or Gr_perfil.Col = C_DESC_CUENTA Then
      Exit Sub
   End If
   If Not FUNC_VALIDA_LINEA() Then
      Exit Sub
   End If

   Call PROC_POSICIONA_TEXTO(Gr_perfil, Txt_ingreso_campos)

   If KeyAscii = 8 Then
      If Gr_perfil.Col = C_NCUENTA Then
         Txt_ingreso_campos.Text = FUNC_FORMATO_CUENTA(Gr_perfil.Text, "D")
      Else
         Txt_ingreso_campos.Text = Trim(Gr_perfil.Text)
      End If
   Else
      Txt_ingreso_campos.Text = Chr(KeyAscii)
   End If

   Txt_ingreso_campos.Visible = True
   Txt_ingreso_campos.SetFocus
   SendKeys "{END}"
End Sub


Function FUNC_VALIDA_LINEA() As Integer
   FUNC_VALIDA_LINEA = False
   
   If Gr_perfil.Row > 1 Then
      For r% = C_CAMPO To C_PERFIL_FIJO
         If Trim(TextMatrix(Gr_perfil, Gr_perfil.Row - 1, r%, "X")) = "" Then
            Exit For
         End If
      Next r%
      If r% <= C_PERFIL_FIJO Then
         Exit Function
      End If
   End If
   FUNC_VALIDA_LINEA = True
End Function


Private Sub Gr_perfil_PV_DblClick()
   Dim iContador  As Long
   
   If Gr_perfil_PV.Row > 1 Then
      If TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row - 1, C2_CODIGO, "X") = "" Then
         Exit Sub
      End If
   End If

   If Gr_perfil_PV.Col = C2_NCUENTA Or Gr_perfil_PV.Col = 1 Then
      BacAyuda.parAyuda = "CON_PLAN_CUENTAS"
      BacAyuda.parFiltro = ""
      BacAyuda.Tag = "CUENTAS"
      BacAyuda.Show 1
      If giAceptar% = True Then
         If Trim(gsCodigo$) <> "" Then
            Call TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row, C2_NCUENTA, FUNC_FORMATO_CUENTA(Trim(gsCodigo$), "D"))
            Call TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row, C2_DESC_CUENTA, BUSCAR_CUENTA(Trim(gsCodigo$)))
         End If
      End If
   End If

   If Gr_perfil_PV.Col = C2_CODIGO Then
      
      BacAyuda.parAyuda = "GEN_TABLAS1"
'+++fmo 20190212 problemas perfiles LCGP
'     BacAyuda.parFiltro = Trim(Right(Cmb_Sistema.Text, 7)) & Trim(Right(Cmb_Tipo_movimiento.Text, 5)) & RELLENA_STRING(Trim(Right(Cmb_Tipo_operacion.Text, 4)), "D", 4) & "  " & Trim(Right(Cmb_Condiciones.Text, 5))
'---fmo 20190212 problemas perfiles LCGP
      BacAyuda.parFiltro = Trim(Right(Cmb_Sistema.Text, 7)) & Trim(Right(Cmb_Tipo_movimiento.Text, 5)) & RELLENA_STRING(Trim(Right(Cmb_Tipo_operacion.Text, 5)), "D", 5) & "  " & Trim(Right(Cmb_Condiciones.Text, 5))
      BacAyuda.Tag = "CONDICIONES"
      BacAyuda.Show 1
      If giAceptar% = True Then
         If Trim(gsCodigo$) <> "" Then
            Txt_ingreso_PV.MaxLength = 3
            Gr_perfil_PV.Text = Trim(gsCodigo$)
            Txt_ingreso_PV.Text = Trim(gsCodigo$)
            Txt_ingreso_PV_KeyPress 13
         End If
      End If
   End If

End Sub

Function RELLENA_STRING(dato As String, Pos As String, largo As Integer) As String
   If Trim(Pos$) = "" Then
      Pos$ = "I"
   End If
   If largo < Len(Trim(dato)) Then
      RELLENA_STRING = Mid(Trim(dato), 1, largo)
      Exit Function
   End If
   If Mid(Pos$, 1, 1) = "I" Then
      RELLENA_STRING = String(largo - Len(Trim(dato)), " ") + Trim(dato)
   Else
      RELLENA_STRING = Trim(dato) + String(largo - Len(Trim(dato)), " ")
   End If
   RELLENA_STRING = Mid(RELLENA_STRING, 1, largo)
End Function

Private Sub Gr_perfil_PV_KeyPress(KeyAscii As Integer)

   If Gr_perfil_PV.Col = 0 Or Gr_perfil_PV.Col = 2 Then
      KeyAscii = 0
      Exit Sub
   End If
   If KeyAscii = 27 Or Gr_perfil_PV.Col = C2_DESC_CUENTA Then
      Exit Sub
   End If
   If Gr_perfil_PV.Row > 1 Then
      If TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row - 1, C2_CODIGO, "X") = "" Then
         Exit Sub
      End If
   End If

   BacToUCase KeyAscii
   Call PROC_POSICIONA_TEXTO(Gr_perfil_PV, Txt_ingreso_PV)

   If KeyAscii = 8 Then
      If Gr_perfil_PV.Col = C2_NCUENTA Then
         Txt_ingreso_PV.Text = FUNC_FORMATO_CUENTA(Gr_perfil_PV.Text, "D")
      Else
         Txt_ingreso_PV.Text = Trim(Gr_perfil_PV.Text)
      End If
   Else
      Txt_ingreso_PV.Text = Chr(KeyAscii)
   End If

   Txt_ingreso_PV.Visible = True
   Txt_ingreso_PV.SetFocus
   SendKeys "{END}"

End Sub


Private Sub Gr_perfil_SelChange()
   Select Case Gr_perfil.Col
      Case C_CAMPO:       Lbl_msg.Caption = " Nombre Campo a Contabilizar"
      Case C_DESC_CAMPO:  Lbl_msg.Caption = " Descripción Campo"
      Case C_PERFIL_FIJO: Lbl_msg.Caption = " Perfil Fijo (S=Si / N=No), No=Condiciona Campo por Variables, Si=Ingresar Cuenta"
      Case C_TIPO_MOV:    Lbl_msg.Caption = " Tipo Movimiento (D=Debe / H=Haber)"
      Case C_NCUENTA:     Lbl_msg.Caption = " Número de Cuenta Contable"
      Case C_DESC_CUENTA: Lbl_msg.Caption = " Descripción Cuenta"
   End Select
End Sub

Sub PROC_PASA_GRILLA_PV()
   Call PROC_CREA_GRILLA_PERFIL_PV
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   On Error Resume Next
   
   Select Case Button.Index
      Case 1
         If Not FUNC_VALIDA_INGRESO_PERFIL("PF") Then
            MsgBox "Falta Información para Grabar!.", vbCritical, TITSISTEMA
            Exit Sub
         End If
         If MsgBox("Seguro de Grabar Perfil ?", 36, TITSISTEMA) <> 6 Then
            Exit Sub
         End If
         Screen.MousePointer = 11
         Call PROC_GRABA_PERFIL
         Call BUSCA_DETALLE_PERFIL
         
         If MsgBox("¿ Seguro de Imprimir Perfil ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
            Screen.MousePointer = 0
            Exit Sub
         Else
            Call GENERAR_LISTADO
            Screen.MousePointer = 0
         End If
      Case 2
         If Mid(Lbl_existe_perfil.Caption, 1, 1) <> "S" Then
            Exit Sub
         End If
         If MsgBox("Seguro de Eliminar Perfil ?", 36, TITSISTEMA) = 6 Then
            Call PROC_ELIMINA_PERFIL
         End If
      Case 3
         Call PROC_LIMPIA
         Cmb_Sistema.SetFocus
      Case 4
         Call BUSCA_DETALLE_PERFIL
      Case 5
         Call GENERAR_LISTADO
      Case 6
         Unload Me
   End Select
End Sub

Function BUSCA_DETALLE_PERFIL()
   Dim varsSist    As String
   Dim varsMov     As String
   Dim varsOper    As String
   Dim varsInstr   As String
   Dim varsMone    As String
   Dim cSql        As String
   Dim varData()

   varNumeros = 0
   varsSist = Trim(Right(Cmb_Sistema.Text, 7))
   varsMov = Trim(Right(Cmb_Tipo_movimiento.Text, 5))
   varsOper = Trim$(Right(Cmb_Tipo_operacion.Text, 5))
        
   If Cmb_Control_Instrumento.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
      varsInstr = ""
   Else
      varsInstr = Left(Cmb_Tipo_Instrumento.Text, 6)
   End If

   If Cmb_Control_Moneda.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
      varsMone = ""
   Else
      varsMone = CDbl(Right(Cmb_Tipo_Moneda.Text, 6))
   End If

   Envia = Array()
   AddParam Envia, varsSist
   AddParam Envia, varsMov
   AddParam Envia, varsOper
   AddParam Envia, varsInstr
   AddParam Envia, varsMone
   
   If Extended.Bac_Sql_Execute("sp_leer_perfil_Busca ", Envia) Then
      Do While Extended.Bac_SQL_Fetch(Datos())
         varNumeros = CDbl(Datos(1))
         Folio_Perfil = varNumeros
      Loop
   End If
   If varNumeros = 0 Then
      MsgBox "Perfil no ha sido creado ", vbInformation, TITSISTEMA
      If MsgBox("¿ Desea crear perfil ?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
            varNumeros = CDbl(Asigna_folio)
            Folio_Perfil = varNumeros
      Else
            Exit Function
      End If
      
   End If
   
   Call PROC_BUSCA_PERFIL(CLng(varNumeros))
   
   Perfil_contable.Caption = "Perfil Contable Nº: " + CStr(Folio_Perfil)
   
   Frm_Perfil.Enabled = True
   Toolbar1.Buttons(4).Enabled = False
   Toolbar1.Buttons(1).Enabled = True
   Toolbar1.Buttons(2).Enabled = True
   Toolbar1.Buttons(5).Enabled = True
            
   Gr_perfil.Row = 1
   Gr_perfil.Col = C_CAMPO
   Gr_perfil.SetFocus
   SendKeys "^{HOME}"
End Function

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Gr_perfil.AddItem ""
         Gr_perfil.SetFocus
      Case 2
         Gr_perfil.RemoveItem Gr_perfil.Row
         Gr_perfil.AddItem ""
         Gr_perfil.SetFocus
      Case 3
         Gr_perfil.Col = C_PERFIL_FIJO
         Gr_perfil_DblClick
   End Select
End Sub

Private Sub Toolbar3_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Gr_perfil_PV.AddItem ""
         Gr_perfil_PV.SetFocus
      Case 2
         Gr_perfil_PV.RemoveItem Gr_perfil_PV.Row
         Gr_perfil_PV.AddItem ""
         Gr_perfil_PV.SetFocus
   End Select
End Sub

Private Sub Grabacion_Perfil_Variable()
   On Error GoTo ErrSavePerfilVariable
   Dim iContador     As Long
   
   Me.MousePointer = vbHourglass
   
   If Not FUNC_VALIDA_INGRESO_PERFIL("PV") Then
      MsgBox "Falta Información del Perfil Variable.", vbCritical, TITSISTEMA
      Exit Sub
   End If
   
   If Not Extended.BacBeginTransaction Then
      GoTo ErrSavePerfilVariable
   End If
   
   Envia = Array()
   AddParam Envia, Trim(Right(Cmb_Sistema, 3))
   AddParam Envia, gsBAC_User
   AddParam Envia, Gr_Filas
   AddParam Envia, Folio_Perfil
   If Not Extended.Bac_Sql_Execute("SP_BORRA_PERFIL_VARIABLE ", Envia) Then
      GoTo ErrSavePerfilVariable
   End If
   
   For iContador = 1 To Gr_perfil_PV.Rows - 1
      If Val(Gr_perfil_PV.TextMatrix(iContador, 0)) > 0 And Val(Gr_perfil_PV.TextMatrix(iContador, 1)) > 0 Then
         Envia = Array()
         AddParam Envia, Right(Cmb_Sistema, 3)
         AddParam Envia, gsBAC_User
         AddParam Envia, Gr_Filas
         AddParam Envia, Gr_perfil_PV.TextMatrix(iContador, 0)
         AddParam Envia, Gr_perfil_PV.TextMatrix(iContador, 1)
         AddParam Envia, Gr_perfil_PV.TextMatrix(iContador, 2)
         AddParam Envia, Folio_Perfil  '  CDbl(Right(Cmb_Condiciones, 7))
         If Not Extended.Bac_Sql_Execute("SP_GRABA_PERFIL_VARIABLE ", Envia) Then
            GoTo ErrSavePerfilVariable
         End If
      End If
   Next iContador
   
   Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_DESC_CUENTA, "PERFIL VARIABLE COMPLETO")
   Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_CAMPO_VARIABLE, Trim(Right(Cmb_Condiciones.Text, 3)))
    
   Call PROC_HABILITA_PV(True)
   SSPanel2.Visible = False
   Call PROC_MARCA_FILA_GRILLA(Gr_perfil, G_COLOR_BLANCO, G_COLOR_NEGRO, Gr_perfil.Row, 0)
   Gr_perfil.SetFocus
   
   
   Call Extended.BacCommitTransaction
   Me.MousePointer = vbDefault
   
   On Error GoTo 0
Exit Sub
ErrSavePerfilVariable:
   Call Extended.BacRollBackTransaction
End Sub

Private Sub Toolbar5_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call Grabacion_Perfil_Variable
      Case 2
         PROC_HABILITA_PV True
         SSPanel2.Visible = False
         PROC_MARCA_FILA_GRILLA Gr_perfil, G_COLOR_BLANCO, G_COLOR_NEGRO, Gr_perfil.Row, 0
         Gr_perfil.SetFocus
   End Select
End Sub

Private Sub Txt_glosa_KeyPress(KeyAscii As Integer)
   Txt_Glosa.MaxLength = 70
   BacToUCase KeyAscii
End Sub


Private Sub Txt_Ingreso_Campos_KeyPress(KeyAscii As Integer)
   If KeyAscii = 27 Then
      Gr_perfil.SetFocus
      Exit Sub
   End If
   Select Case Gr_perfil.Col
      Case C_CAMPO:
         Txt_ingreso_campos.MaxLength = 3
         Call PROC_FMT_NUMERICO(Txt_ingreso_campos, 3, 0, KeyAscii, "+")
      Case C_PERFIL_FIJO:
         Txt_ingreso_campos.MaxLength = 1
         Call BacToUCase(KeyAscii)
      Case C_TIPO_MOV:
         Txt_ingreso_campos.MaxLength = 1
         Call BacToUCase(KeyAscii)
       Case C_NCUENTA:
         Txt_ingreso_campos.MaxLength = 12 'FSA; VALOR: 11. PARA CUENTAS NY
         Call BacToUCase(KeyAscii)
   End Select

   If KeyAscii = 13 And Trim(Txt_ingreso_campos.Text) <> "" Then
      If Not FUNC_VALIDA_INGRESO_FIJO() Then
         Txt_ingreso_campos.Text = ""
         Exit Sub
      End If
      Gr_perfil.SetFocus
   End If

End Sub

Sub PROC_FMT_NUMERICO(texto As Control, NEnteros, NDecs As Integer, ByRef tecla, Signo As String)
   Dim PosPto  As Integer
   
   If tecla = 13 Or tecla = 27 Then
      Exit Sub
   End If
   If tecla = 45 And Signo = "+" Then
      tecla = 0
   End If
   If tecla <> 8 And (tecla < 48 Or tecla > 57) Then
      If NDecs = 0 Then
         tecla = 0
      ElseIf tecla <> 46 And tecla <> 45 Then
         tecla = 0
      End If
   End If
   If tecla = 45 And Signo = "-" Then
      If InStr(texto.Text, "-") > 0 Then
         tecla = 0
      ElseIf texto.SelStart > 0 Then
         If Mid(texto.Text, texto.SelStart, 1) <> "" Then
            tecla = 0
         End If
      End If
   End If
   PosPto% = InStr(texto.Text, ".")
   If PosPto% > 0 And tecla = 46 Then
      tecla = 0
      Exit Sub
   End If
   If NDecs > 0 And PosPto% > 0 And PosPto% <= texto.SelStart Then
      PosPto% = PosPto% + 1
      If Len(Mid(texto.Text, PosPto%, NDecs)) = NDecs And tecla <> 8 Then
         tecla = 0
      Else
         Exit Sub
      End If
   End If
   If PosPto% > 0 And texto.SelStart < PosPto% And tecla <> 8 Then
      If Len(Mid(texto.Text, 1, PosPto% - 1)) >= NEnteros Then
         tecla = 0
      End If
   ElseIf PosPto% = 0 And tecla <> 8 And Chr(tecla) <> "." Then
      If Len(texto.Text) >= NEnteros Then
         tecla = 0
      End If
   End If
End Sub

Private Sub Txt_Ingreso_Campos_LostFocus()
   Txt_ingreso_campos.Visible = False
End Sub

Private Sub Txt_ingreso_PV_KeyPress(KeyAscii As Integer)
   If KeyAscii = 27 Then
      Gr_perfil_PV.SetFocus
      Exit Sub
   End If
   Txt_ingreso_PV.MaxLength = 12 'FSA; VALOR ANTERIOR: 11. MODIF PARA CUENTAS NY
   
   Call BacToUCase(KeyAscii)
    
   If KeyAscii = 13 And Trim(Txt_ingreso_PV.Text) <> "" Then
      If Not FUNC_VALIDA_INGRESO_PV() Then
         Txt_ingreso_PV.Text = ""
         Exit Sub
      End If
      Gr_perfil_PV.SetFocus
   End If
End Sub

Private Sub Txt_ingreso_PV_LostFocus()
   Txt_ingreso_PV.Visible = False
End Sub

Function Asigna_folio()
      
   
Call Bac_Sql_Execute("BEGIN TRANSACTION")
   
   
      Envia = Array()
      AddParam Envia, "PERFIL"
      If Not Bac_Sql_Execute("Sp_Asigna_folio", Envia) Then
         Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
      End If
   
      If Bac_SQL_Fetch(Datos()) Then
            Asigna_folio = Datos(1)
      End If
   
   Call Bac_Sql_Execute("COMMIT TRANSACTION")
   
      
End Function
