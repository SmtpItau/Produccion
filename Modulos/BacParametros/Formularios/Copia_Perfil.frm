VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form Copia_Perfil 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Copia de Perfiles Contables"
   ClientHeight    =   6765
   ClientLeft      =   300
   ClientTop       =   1350
   ClientWidth     =   11520
   Icon            =   "Copia_Perfil.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6765
   ScaleWidth      =   11520
   Begin MSComctlLib.ImageList ImageList3 
      Left            =   5520
      Top             =   3120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Copia_Perfil.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Copia_Perfil.frx":075C
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
            Picture         =   "Copia_Perfil.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Copia_Perfil.frx":0D18
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Copia_Perfil.frx":0E82
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4800
      Top             =   960
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
            Picture         =   "Copia_Perfil.frx":12D4
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Copia_Perfil.frx":1726
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Copia_Perfil.frx":1B78
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Copia_Perfil.frx":1E92
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Copia_Perfil.frx":22E4
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Copia_Perfil.frx":25FE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   6135
      Left            =   0
      TabIndex        =   0
      Top             =   600
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
         Height          =   3885
         Left            =   1560
         TabIndex        =   26
         Top             =   60
         Width           =   7980
         _Version        =   65536
         _ExtentX        =   14076
         _ExtentY        =   6853
         _StockProps     =   15
         BackColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   4
         BevelOuter      =   0
         Begin Threed.SSFrame Frm_perfil_PV 
            Height          =   3615
            Left            =   135
            TabIndex        =   27
            Top             =   135
            Width           =   7740
            _Version        =   65536
            _ExtentX        =   13652
            _ExtentY        =   6376
            _StockProps     =   14
            Caption         =   "Condiciones"
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
            Begin VB.TextBox Txt_ingreso_PV 
               BackColor       =   &H00808000&
               BorderStyle     =   0  'None
               ForeColor       =   &H00FFFFFF&
               Height          =   285
               Left            =   2610
               TabIndex        =   29
               Text            =   "Text2"
               Top             =   1665
               Visible         =   0   'False
               Width           =   615
            End
            Begin VB.ComboBox Cmb_Condiciones 
               Height          =   315
               Left            =   1575
               Style           =   2  'Dropdown List
               TabIndex        =   28
               Top             =   300
               Width           =   5175
            End
            Begin MSFlexGridLib.MSFlexGrid Gr_perfil_PV 
               Height          =   2220
               Left            =   135
               TabIndex        =   30
               Top             =   765
               Width           =   7305
               _ExtentX        =   12885
               _ExtentY        =   3916
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
            Begin MSComctlLib.Toolbar Toolbar4 
               Height          =   600
               Left            =   4320
               TabIndex        =   31
               Top             =   120
               Visible         =   0   'False
               Width           =   3360
               _ExtentX        =   5927
               _ExtentY        =   1058
               ButtonWidth     =   609
               ButtonHeight    =   953
               Appearance      =   1
               _Version        =   393216
            End
            Begin MSComctlLib.Toolbar Toolbar3 
               Height          =   420
               Left            =   120
               TabIndex        =   32
               Top             =   3000
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
               Left            =   6480
               TabIndex        =   33
               Top             =   3000
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
               ForeColor       =   &H8000000D&
               Height          =   195
               Left            =   375
               TabIndex        =   34
               Top             =   345
               Width           =   855
            End
         End
      End
      Begin VB.Frame Frm_Perfil 
         Caption         =   "Perfil Contable"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
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
            Left            =   240
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
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
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
            ItemData        =   "Copia_Perfil.frx":291A
            Left            =   9480
            List            =   "Copia_Perfil.frx":291C
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
            ForeColor       =   &H8000000D&
            Height          =   195
            Index           =   0
            Left            =   5265
            TabIndex        =   23
            Top             =   405
            Width           =   1410
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Tipo Operacion"
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
            ForeColor       =   &H8000000D&
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
            ForeColor       =   &H8000000D&
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
            ForeColor       =   &H8000000D&
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
            ForeColor       =   &H8000000D&
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
            Left            =   3930
            TabIndex        =   17
            Top             =   405
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
            ForeColor       =   &H8000000D&
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
   End
End
Attribute VB_Name = "Copia_Perfil"
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

Public Gr_Filas     As Single
Public Filas        As Single
Public varpsSql     As String
Public Folio_Perfil As Long
Public varNumeros  As Integer


Dim Sql$
Dim I&




Function BUSCAR_CUENTA(Cuenta As String) As String
Dim Sql As String
Dim Datos()

Envia = Array()
AddParam Envia, Cuenta

If Not Bac_Sql_Execute("SP_BUSCA_CUENTA_CONTABLE ", Envia) Then
   MsgBox "Error : La Busqueda No Termino", vbCritical, TITSISTEMA
   Exit Function
End If

Do While Bac_SQL_Fetch(Datos())
   BUSCAR_CUENTA = Trim(Datos(1))
Loop
    
End Function

Function FUNC_BUSCAR_PERFIL_VARIABLE(Filas As Single)
Dim Sql  As String
Dim X    As Integer
Dim Datos()

Envia = Array()
AddParam Envia, Filas

If Not Bac_Sql_Execute("EXECUTE Sp_Buscar_Perfiles_Variables ", Envia) Then
   MsgBox "Error : en la Cargatura de Perfiles Variables", vbCritical, TITSISTEMA
   Exit Function
End If

PROC_CREA_GRILLA_PERFIL_PV

X = 0
Do While Bac_SQL_Fetch(Datos())
    X = X + 1
    Call TextMatrix(Gr_perfil_PV, X, 0, Datos(2))
    Call TextMatrix(Gr_perfil_PV, X, 1, Datos(3))
    Call TextMatrix(Gr_perfil_PV, X, 2, Datos(4))
Loop

End Function

Function FUNC_GRABA_PERFIL_VARIABLE(Sistema As String, Tipo_movimiento As String, Tipo_Operacion As String)
Dim Datos()

FUNC_GRABA_PERFIL_VARIABLE = False

'For i% = 1 To Gr_perfil_paso.Rows - 1

'    Gr_perfil_paso.Row = i%
'    Gr_perfil_paso.Col = 0

'    If CDBL(Gr_perfil_paso.Text) = Gr_perfil.Row Then
    
'       sql = "SP_GRABA_PERFIL_VARIABLE "
       
       ' Sistema
'       sql = sql + "'" + Sistema + "',"
       
       ' Tipo Movimiento
'       sql = sql + "'" + Tipo_movimiento + "',"
       
       ' Tipo Operacion
'       sql = sql + "'" + Tipo_Operacion + "',"
              
       ' Producto
'       Gr_perfil_paso.Col = C2_PRODUCTO + 1
'       sql = sql + "'" + Trim(Gr_perfil_paso.Text) + "',"
       
       ' Cuenta
'       Gr_perfil_paso.Col = C2_NCUENTA + 1
'       sql = sql + "'" + Trim(Gr_perfil_paso.Text) + "',"
       
       ' Correlativo
'       sql = sql + Str(Gr_perfil.Row)
       
'       If MISQL.SQL_EXECUTE(sql) <> 0 Then Exit Function
             
'    End If
    
'Next i%

FUNC_GRABA_PERFIL_VARIABLE = True

End Function

Function FUNC_VALIDA_CAMPO(campo As String) As Integer
Dim Datos()

Screen.MousePointer = 11

FUNC_VALIDA_CAMPO = False

Envia = Array()
AddParam Envia, campo
AddParam Envia, Right(Cmb_Sistema.Text, 3)
AddParam Envia, Right(Cmb_Tipo_movimiento.Text, 3)
AddParam Envia, Trim(Right(Cmb_Tipo_operacion.Text, 5))

If Not Bac_Sql_Execute("SP_BUSCA_CAMPO_PERFIL ", Envia) Then
   Screen.MousePointer = 0
   Exit Function
End If

Screen.MousePointer = 0

If Not Bac_SQL_Fetch(Datos()) Then
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

If Not Bac_Sql_Execute("SP_BUSCA_INDICADOR", Envia) Then
     MsgBox "Error : Al Cargar datos", vbCritical, TITSISTEMA
     Exit Function
End If
 If Not Bac_SQL_Fetch(Datos()) Then
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
Dim Con_info    As Integer: Con_info = False
Dim Descripcion$, I%

FUNC_VALIDA_INGRESO_PERFIL = False

If grilla_valida = "PF" Then

   If Trim(Txt_Glosa.Text) = "" Then Exit Function

   For I% = 1 To Gr_perfil.Rows - 1
   
       If Trim(TextMatrix(Gr_perfil, I%, C_CAMPO, "X")) <> "" Then
       
          If Trim(TextMatrix(Gr_perfil, I%, C_TIPO_MOV, "X")) = "" Or Trim(TextMatrix(Gr_perfil, I%, C_PERFIL_FIJO, "X")) = "" Then Exit Function
          
'          If Trim(TextMatrix(Gr_perfil, i%, C_PERFIL_FIJO, "X")) = "N" And (InStr(TextMatrix(Gr_perfil, i%, C_DESC_CUENTA, "X"), "NO") > 0 And Mid(TextMatrix(Gr_perfil, i%, C_DESC_CUENTA, "X"), 1, 3) = "Per") Then Exit Function
          
          If Trim(TextMatrix(Gr_perfil, I%, C_PERFIL_FIJO, "X")) = "S" And Trim(TextMatrix(Gr_perfil, I%, C_NCUENTA, "X")) = "" Then Exit Function
          
          Con_info = True
       End If
       
   Next I%
   
End If

If grilla_valida = "PV" Then

   For I% = 1 To Gr_perfil_PV.Rows - 1
   
       If Trim(TextMatrix(Gr_perfil_PV, I%, C2_CODIGO, "X")) <> "" And Trim(TextMatrix(Gr_perfil_PV, I%, C2_NCUENTA, "X")) = "" Then Exit Function
       
       If Trim(TextMatrix(Gr_perfil_PV, I%, C2_NCUENTA, "X")) <> "" And Trim(TextMatrix(Gr_perfil_PV, I%, C2_CODIGO, "X")) = "" Then Exit Function
       
       If Trim(TextMatrix(Gr_perfil_PV, I%, C2_CODIGO, "X")) <> "" And Trim(TextMatrix(Gr_perfil_PV, I%, C2_NCUENTA, "X")) <> "" Then Con_info = True
       
   Next I%

End If

FUNC_VALIDA_INGRESO_PERFIL = Con_info

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
        
If Not Bac_Sql_Execute("SP_BUSCA_RFI_INSTRUMENTO", Envia) Or Not Bac_SQL_Fetch(Datos()) Then
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

If Not Bac_Sql_Execute("SP_GRABA_BUSCA_MONEDA ", Envia) Or Not Bac_SQL_Fetch(Datos()) Then
   
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
   BACSwapParametros.BacParam.Destination = crptToWindow
   BACSwapParametros.BacParam.ReportFileName = gsRPT_Path & "LISPERFIL.RPT"
   BACSwapParametros.BacParam.StoredProcParam(0) = varNumeros
   BACSwapParametros.BacParam.WindowTitle = "LISTADO DE PERFIL CONTABLE"
   BACSwapParametros.BacParam.Connect = SwConeccion
   BACSwapParametros.BacParam.Action = 1
   Screen.MousePointer = vbDefault

Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0
        
End Sub

Sub PROC_ASIGNA_COMBOS()

For I = 0 To Cmb_Sistema.ListCount - 1
    Cmb_Sistema.ListIndex = I
    If Right(Cmb_Sistema.Text, 3) = Mid(Glob_Registro_Ayuda, 1, 3) Then Exit For
Next I

For I = 0 To Cmb_Tipo_movimiento.ListCount - 1
    Cmb_Tipo_movimiento.ListIndex = I
    If Right(Cmb_Tipo_movimiento.Text, 3) = Mid(Glob_Registro_Ayuda, 4, 3) Then Exit For
Next I

For I = 0 To Cmb_Tipo_operacion.ListCount - 1
    Cmb_Tipo_operacion.ListIndex = I
    If Right(Cmb_Tipo_operacion.Text, 3) = Mid(Glob_Registro_Ayuda, 7, 3) Then Exit For
Next I

End Sub

Sub PROC_BUSCA_PERFIL(Numero As Long)
Dim Datos()
Dim Sql As String
Dim X As Integer
Screen.MousePointer = 11

' Sistema = Right(Cmb_sistema.Text, 3)
' Tipo_movimiento = Right(Cmb_tipo_movimiento.Text, 3)
' Tipo_Operacion = Right(Cmb_tipo_operacion.Text, 3)
' sql = "SP_BUSCA_PERFIL 'PF'," + "'" + Sistema + "','" + Tipo_movimiento + "','" + Tipo_Operacion + "'"
' SP_BUSCAR_DETALLE_PERFILES 2

    '--------------------------------
    Envia = Array()
    AddParam Envia, Numero
    
    Lbl_existe_perfil.Caption = "N"
    If Not Bac_Sql_Execute("sp_buscar_perfiles ", Envia) Then
       Screen.MousePointer = 0
       Exit Sub
    End If

    If Bac_SQL_Fetch(Datos()) Then
       Lbl_existe_perfil.Caption = "S"
       For X = 0 To Cmb_Sistema.ListCount - 1
            If Trim(Right(Cmb_Sistema.List(X), 7)) = Trim(Datos(1)) Then
               Cmb_Sistema.ListIndex = CDbl(X)
               Exit For
            End If
       Next
       
        For X = 0 To Cmb_Tipo_movimiento.ListCount - 1
            If Trim(Right(Cmb_Tipo_movimiento.List(X), 7)) = Trim(Datos(2)) Then
                Cmb_Tipo_movimiento.ListIndex = CDbl(X)
                Exit For
            End If
        Next
        
        For X = 0 To Cmb_Tipo_operacion.ListCount - 1
            If Trim(Right(Cmb_Tipo_operacion.List(X), 7)) = Trim(Datos(3)) Then
                Cmb_Tipo_operacion.ListIndex = CDbl(X)
                Exit For
            End If
        Next
        
        For X = 0 To Cmb_Tipo_Instrumento.ListCount - 1
            If Trim(Mid(Cmb_Tipo_Instrumento.List(X), 1, 5)) = Trim(Datos(5)) Then
                Cmb_Tipo_Instrumento.ListIndex = CDbl(X)
                Exit For
            End If
        Next
        
        For X = 0 To Cmb_Tipo_Moneda.ListCount - 1
             If Trim(Right(Cmb_Tipo_Moneda.List(X), 7)) = Trim(Datos(6)) Then
                Cmb_Tipo_Moneda.ListIndex = CDbl(X)
                Exit For
             End If
        Next
        
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
    
    If Not Bac_Sql_Execute("sp_buscar_detalle_perfiles ", Envia) Then
       Screen.MousePointer = 0
       Exit Sub
    End If
     
    X = 0
    Do While Bac_SQL_Fetch(Datos())
    
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

'If OK% <> -1 Then
'
'   Select Case Trim(Datos(1))
'          Case "I": Cmb_tipo_voucher.ListIndex = 0
'          Case "E": Cmb_tipo_voucher.ListIndex = 1
'          Case "T": Cmb_tipo_voucher.ListIndex = 2
'   End Select
'
'   Txt_glosa.Text = Trim(Datos(2))
'
'   Lbl_existe_perfil.Caption = "S"
'Else
'
'   Lbl_existe_perfil.Caption = "N"
'End If
'
'Gr_perfil.Row = 0
'Gr_perfil.Redraw = False
'
'Do While OK% <> -1
'
'   Gr_perfil.Row = Gr_perfil.Row + 1
'
'   Gr_perfil.TextMatrix(Gr_perfil.Row, C_CAMPO) = Format(Datos(3), "##0")
'
'   Gr_perfil.TextMatrix(Gr_perfil.Row, C_DESC_CAMPO) = Trim(Datos(4))
'
'   Gr_perfil.TextMatrix(Gr_perfil.Row, C_TIPO_MOV) = Trim(Datos(5))
'
'   Gr_perfil.TextMatrix(Gr_perfil.Row, C_PERFIL_FIJO) = Trim(Datos(6))
'
'   Gr_perfil.TextMatrix(Gr_perfil.Row, C_NCUENTA) = Trim(Datos(7))
'
'   Gr_perfil.TextMatrix(Gr_perfil.Row, C_DESC_CUENTA) = Trim(Datos(8))
'
'   If Trim(Datos(6)) = "N" Then Gr_perfil.TextMatrix(Gr_perfil.Row, C_DESC_CUENTA) = "Perfil Variable Completo"
'
'   OK% = MISQL.SQL_FETCH(Datos())
'Loop
'
'Gr_perfil.Redraw = True
'
'If Lbl_existe_perfil.Caption = "N" Then
'   Screen.MousePointer = 0
'
'   PROC_HABILITA False
'   Exit Sub
'End If
'
'' BUSCA SI EXISTEN PERFILES VARIABLES
'
'sql = "SP_BUSCA_PERFIL 'PV'," + "'" + Sistema + "','" + Tipo_movimiento + "','" + Tipo_Operacion + "'"
'
'If MISQL.SQL_EXECUTE(sql) <> 0 Then
'   Screen.MousePointer = 0
'   Exit Sub
'End If
'
'PROC_CREA_GRILLA_PASO
'
'If Gr_perfil_paso.Row = 0 Then
'   Gr_perfil_paso.AddItem ""
'   Gr_perfil_paso.Row = 0
'Else
'   Gr_perfil_paso.Row = Gr_perfil_paso.Rows - 1
'End If
'
'Do While MISQL.SQL_FETCH(Datos()) <> -1
'
'   If Gr_perfil_paso.Row + 1 > Gr_perfil_paso.Rows - 1 Then Gr_perfil_paso.AddItem ""
'
'   Gr_perfil_paso.Row = Gr_perfil_paso.Row + 1
'
'   Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_CODIGO + 1) = Trim(Datos(1))
'
'   Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_INDICADOR + 1) = Trim(Datos(2))
'
'   Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_NCUENTA + 1) = Trim(Datos(3))
'
'   Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_DESC_CUENTA + 1) = Trim(Datos(4))
'
'   Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, 0) = CDBL(Datos(5))
'Loop

Screen.MousePointer = 0

PROC_HABILITA False

End Sub

Sub PROC_CARGA_COMBO_MOVIMIENTO()
' ---------------------------------------------------------------------------
'   SubRutina       :   PROC_CARGA_COMBO_MOVIMIENTO
'   Objetivo        :   Realiza la carga del combo de movimientos
' ---------------------------------------------------------------------------
Dim Datos()
Dim Sql As String
On Error GoTo CargaData

    
  ' Cargo Tipos de Movimientos relacionados con el tipo de movimiento
  ' ======================================================================================
  
    Envia = Array()
    
    AddParam Envia, Right$(Cmb_Sistema.Text, 3)
     

    If Bac_Sql_Execute("sp_cnt_leermovimientos", Envia) Then
        Cmb_Tipo_movimiento.Clear
        Do While Bac_SQL_Fetch(Datos())
            Cmb_Tipo_movimiento.AddItem Trim$(Datos(2)) & Space(50) & Datos(1)
        Loop
        Cmb_Tipo_movimiento.Enabled = True
        If Cmb_Tipo_movimiento.ListCount <> 0 Then Cmb_Tipo_movimiento.ListIndex = 0
    Else
        MsgBox "Problemas en obtención de información del servidor ", vbCritical, TITSISTEMA
        Exit Sub
    End If
  ' ======================================================================================
    
    Exit Sub
CargaData:
    MsgBox "Problemas en carga de información de objetos: " & Err.Description & ". Comunique al Administrador.", vbCritical, TITSISTEMA
    Exit Sub
End Sub

Sub PROC_CARGA_COMBO_TIPO_OPERACION()

' Cmb_tipo_operacion.Clear

' --------------------------------------------------------------------------------------
' NOTA AL PROGRAMADOR:
'
' RIGHT(Cmb_tipo_operacion,3)           = TIPO DE OPERACION O DEVENGO
' MID(RIGHT(Cmb_tipo_operacion,10),1,6) = TIPO DE AYUDA :
'                                         INSTRU = Instrumentos Renta Fija
'                                         INSIND = Instrumentos Renta Fija e Indicador
'                                         MONEDA = Monedas
'                                         ACCION = Acciones
' --------------------------------------------------------------------------------------
Dim Datos()
Dim Sql As String

  ' Cargo datos correspondientes al tipo de operación
  ' ======================================================================================
  
    Cmb_Tipo_operacion.Clear
    Cmb_Control_Instrumento.Clear
    Cmb_Control_Moneda.Clear
  
    Envia = Array()
    AddParam Envia, Right$(Cmb_Sistema.Text, 3)
    AddParam Envia, Right$(Cmb_Tipo_movimiento.Text, 3)
    
    If Bac_Sql_Execute("sp_cnt_leeroperaciones", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
           Cmb_Tipo_operacion.AddItem Trim$(Datos(2)) & Space(150) & Datos(1)
           'Cmb_tipo_operacion.ItemData(Cmb_tipo_operacion.NewIndex) = IIf(Datos(3) = "S", 1, 0)
           Cmb_Control_Instrumento.AddItem Trim$(Datos(3))
           Cmb_Control_Moneda.AddItem Trim$(Datos(4))
        Loop
        Cmb_Tipo_operacion.Enabled = True
        If Cmb_Tipo_operacion.ListCount <> 0 Then Cmb_Tipo_operacion.ListIndex = 0
    Else
        MsgBox "Problemas en obtención de información del servidor ", vbCritical, TITSISTEMA
        Exit Sub
    End If


End Sub



Sub PROC_CARGA_COMBO_MONEDA()
Dim Datos()
Dim Sql As String
On Error GoTo ErrMon


  ' Cargo datos correspondientes al tipo de operación
  ' ======================================================================================
    
    Envia = Array()
    AddParam Envia, Right$(Cmb_Sistema.Text, 3)
    Cmb_Tipo_Moneda.Clear
    
    If Bac_Sql_Execute("sp_cnt_listamonedas", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
             If Datos(1) <> "NO HAY DATOS" Then
                 Cmb_Tipo_Moneda.AddItem Left(Left(Datos(2) & Space(3), 3) & " " & Datos(3) & Space(90), 90) & CDbl(Datos(1))
             End If
        Loop
        Cmb_Tipo_Moneda.Enabled = True
        If Cmb_Tipo_Moneda.ListCount <> 0 Then Cmb_Tipo_Moneda.ListIndex = 0
    Else
        MsgBox "Problemas en obtención de información del servidor ", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    Cmb_Tipo_Moneda.Enabled = IIf(Cmb_Tipo_Moneda.ListCount <= 0, False, True)
    
    Exit Sub
    
ErrMon:
    MsgBox "Problemas en carga de codigos de monedas", vbCritical, TITSISTEMA
    Exit Sub
End Sub


Sub PROC_CARGA_COMBO_INSTRUMENTOS()
Dim Datos()
Dim Cant As Single
Dim Sql As String
On Error GoTo ErrMon

    
    Cmb_Tipo_Instrumento.Clear

  '  If Cmb_tipo_operacion.ItemData(Cmb_tipo_operacion.ListIndex) = 0 Then
  '      Cmb_Tipo_Instrumento.Enabled = False
  '      Exit Sub
   ' End If
    
    ' Cargo datos correspondientes al tipo de operación
    ' ======================================================================================
      Envia = Array()
      AddParam Envia, Right$(Cmb_Sistema.Text, 3)
      
      If Bac_Sql_Execute("sp_cnt_listainstrumentos", Envia) Then
          Do While Bac_SQL_Fetch(Datos())
              If Datos(1) <> "NO HAY DATOS" Then
               Cant = (9 - Len(Trim(Datos(1))))
               Cmb_Tipo_Instrumento.AddItem Trim$(Datos(1)) & Space(Cant) & Datos(2)
              End If
          Loop
          If Cmb_Tipo_Instrumento.ListCount <> 0 Then Cmb_Tipo_Instrumento.ListIndex = 0
      Else
          MsgBox "No Hay Perfiles Cargados ", vbExclamation, TITSISTEMA
          Exit Sub
      End If
      Exit Sub
                
ErrMon:
    MsgBox "No hay Instrumentos Cargados", vbExclamation, TITSISTEMA
    Exit Sub
End Sub



Sub PROC_CREA_GRILLA_PERFIL_PV()

'Gr_perfil_PV.Redraw = False

Gr_perfil_PV.Rows = 1
Gr_perfil_PV.Cols = 1

Gr_perfil_PV.Rows = 23
Gr_perfil_PV.Cols = 3

Gr_perfil_PV.FixedRows = 1
Gr_perfil_PV.FixedCols = 0

Gr_perfil_PV.Row = 0
'VB+- 10/02/2000  Se saco Gr_perfil_PV.Col = C2_CONDICION: Gr_perfil_PV.Text = "Condicion"
Gr_perfil_PV.Col = C2_VALOR: Gr_perfil_PV.Text = "Valor"
Gr_perfil_PV.Col = C2_NCUENTA: Gr_perfil_PV.Text = "Cuenta"
Gr_perfil_PV.Col = C2_DESC_CUENTA: Gr_perfil_PV.Text = "Descripción Cuenta"

' VB+- 10/02/2000 Gr_perfil_PV.ColWidth(C2_CONDICION) = 2000
Gr_perfil_PV.ColWidth(C2_VALOR) = 1500
Gr_perfil_PV.ColWidth(C2_NCUENTA) = 1200
Gr_perfil_PV.ColWidth(C2_DESC_CUENTA) = 4000
' VB+- 10/02/2000 Gr_perfil_PV.ColWidth(C2_CODIGO_CONDICION) = 1
'Gr_perfil_PV.ColWidth(C2_CODIGO_VALOR) = 1

' VB+- 10/02/20000 Gr_perfil_PV.ColAlignment(C2_CONDICION) = flexAlignLeftCenter
Gr_perfil_PV.ColAlignment(C2_VALOR) = flexAlignLeftCenter
Gr_perfil_PV.ColAlignment(C2_NCUENTA) = flexAlignLeftCenter
Gr_perfil_PV.ColAlignment(C2_DESC_CUENTA) = flexAlignLeftCenter

'Gr_perfil_PV.Redraw = True

Gr_perfil_PV.Row = 1
Gr_perfil_PV.Col = 0

End Sub
Sub PROC_ELIMINA_PERFIL()
Dim Datos()
Dim Error            As Integer: Error = False
Dim Sistema          As String * 3
Dim Tipo_movimiento  As String * 3
Dim Tipo_Operacion   As String * 5



If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then Exit Sub

Sistema = Right(Cmb_Sistema.Text, 3)
Tipo_movimiento = Right(Cmb_Tipo_movimiento.Text, 3)
Tipo_Operacion = Trim(Right(Cmb_Tipo_operacion.Text, 5))

'Sql = "SP_ELIMINA_PERFIL '" + Sistema + "','" + Tipo_movimiento + "','" + Tipo_Operacion + "'"
Envia = Array()
AddParam Envia, Folio_Perfil


If Not Bac_Sql_Execute("SP_ELIMINA_PERFIL", Envia) Then
   
   If Not Bac_Sql_Execute("ROLLBACK") Then Error = True
   Error = True
Else
   
   If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then Error = True
   
End If



If Error Then MsgBox "Perfil NO Eliminado.", vbCritical, TITSISTEMA

PROC_LIMPIA
     
Cmb_Sistema.SetFocus

End Sub

Sub PROC_GRABA_PERFIL()
Dim Datos(), r%
Dim Error            As Integer
Dim Sistema          As String * 3
Dim Tipo_movimiento  As String * 3
Dim Tipo_Operacion   As String * 5
Dim crear_perfil     As String * 1



'If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then Exit Sub

Error = False

Screen.MousePointer = 11

Sistema = Right(Cmb_Sistema.Text, 3)
Tipo_movimiento = Right(Cmb_Tipo_movimiento.Text, 3)
Tipo_Operacion = Trim(Right(Cmb_Tipo_operacion.Text, 5))


Envia = Array()
AddParam Envia, Folio_Perfil

If Not Bac_Sql_Execute("SP_ELIMINA_PERFIL ", Envia) Then
   Error = True
   GoTo END_Graba_Perfil:
End If

'Gr_perfil.Redraw = False
crear_perfil = "S"

For r% = 1 To Gr_perfil.Rows - 1

    Gr_perfil.Row = r%
    Gr_perfil.Col = C_CAMPO

    If CDbl(Gr_perfil.Text) > 0 Then
    
       Envia = Array()
       
       ' Crear Encabezado
       AddParam Envia, crear_perfil
       crear_perfil = "N"
      
       ' Folio Perfil
       AddParam Envia, CDbl(Folio_Perfil)
     
       ' Sistema
       AddParam Envia, Sistema
       
       ' Tipo Movimiento
       AddParam Envia, Tipo_movimiento
       
       ' Tipo Operacion
       AddParam Envia, Trim(Tipo_Operacion)
       
       'Codigo Instrumento
       If Cmb_Control_Instrumento.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
          If Trim(Mid(Cmb_Tipo_Instrumento, 1, 5)) = "ICAP" Or Trim(Mid(Cmb_Tipo_Instrumento, 1, 5)) = "ICOL" Then
            AddParam Envia, Trim(Mid(Cmb_Tipo_Instrumento, 1, 5))
          Else
                   AddParam Envia, ""
          End If
       Else
          AddParam Envia, Trim(Mid(Cmb_Tipo_Instrumento, 1, 5))
       End If
       
       ' Codigo Moneda
       If Cmb_Control_Moneda.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
          AddParam Envia, ""
       Else
          AddParam Envia, LTrim(Str(Trim(Right(Cmb_Tipo_Moneda.Text, 5))))
       End If
       
       ' Tipo de Voucher
       AddParam Envia, Trim(Mid(Cmb_Tipo_Voucher.Text, 1, 1))
       
       ' Glosa
       AddParam Envia, Trim(Txt_Glosa.Text)
       
       ' Codigo Campo
       AddParam Envia, Val(TextMatrix(Gr_perfil, r%, C_CAMPO, "X"))

      ' Tipo Movimiento o Cuenta
       AddParam Envia, TextMatrix(Gr_perfil, r%, C_TIPO_MOV, "X")
                    
       ' Perfil Fijo
       AddParam Envia, TextMatrix(Gr_perfil, r%, C_PERFIL_FIJO, "X")
       
       ' Cuenta
       Gr_perfil.Col = 4
       AddParam Envia, TextMatrix(Gr_perfil, r%, C_NCUENTA, "X")

       ' Correlativo
       AddParam Envia, Val((Gr_perfil.Row))
       
       ' Codigo Campo Variable
       AddParam Envia, Val(TextMatrix(Gr_perfil, r%, C_CAMPO_VARIABLE, "X"))
       
       If Not Bac_Sql_Execute("SP_GRABA_PERFIL ", Envia) Then
          Error = True
          Exit For
       End If
       
       If Mid(TextMatrix(Gr_perfil, r%, C_PERFIL_FIJO, "X"), 1, 1) = "N" Then
       
          If Not FUNC_GRABA_PERFIL_VARIABLE(Sistema, Tipo_movimiento, Tipo_Operacion) Then
             Error = True
             Exit For
          End If
          
       End If
       
    End If
    
Next r%

'Gr_perfil.Redraw = True

END_Graba_Perfil:

'If Error Then
'   If Not Bac_Sql_Execute("ROLLBACK") Then Error = False
'
'Else
'   If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then Error = False
'
'End If


   
Screen.MousePointer = 0

If Not Error Then
   MsgBox "Perfil Grabado sin Problemas.", 64, TITSISTEMA
Else
   MsgBox "Información NO Grabada.", 16, TITSISTEMA
End If

End Sub

Sub PROC_HABILITA(modo As Boolean)

Cmb_Sistema.Enabled = modo
Cmb_Tipo_movimiento.Enabled = modo
Cmb_Tipo_operacion.Enabled = modo
cmd_ayuda_perfil.Enabled = modo
Cmb_Tipo_Moneda.Enabled = modo
Cmb_Tipo_Instrumento.Enabled = modo
'Txt_glosa.Enabled = modo
'Cmb_tipo_voucher.Enabled = modo

End Sub
Sub PROC_HABILITA_PV(modo As Integer)
Toolbar1.Buttons(1).Enabled = modo
Toolbar1.Buttons(2).Enabled = modo
Toolbar1.Buttons(4).Enabled = modo
'Cmd_Grabar.Enabled = modo   ' Grabar
'Cmd_Buscar.Enabled = modo   ' Buscar
'Cmd_Eliminar.Enabled = modo ' Anular

Frm_Tipo_movimiento.Enabled = modo
Frm_Perfil.Enabled = modo

End Sub


Sub PROC_LIMPIA()

    Folio_Perfil = 0

    Cmb_Sistema.Enabled = True
    Cmb_Tipo_movimiento.Enabled = True
    Cmb_Tipo_operacion.Enabled = True
    
    PROC_HABILITA_PV True

    PROC_HABILITA True

    SSPanel2.Visible = False

    PROC_CREA_GRILLA_PERFIL

    PROC_CREA_GRILLA_PASO

    Txt_Glosa.Text = ""
    Lbl_msg.Caption = ""
    Lbl_existe_perfil.Caption = "N"
    
    Frm_Perfil.Enabled = False
    Toolbar1.Buttons(4).Enabled = True
    'Cmd_Buscar.Enabled = True
    Toolbar1.Buttons(1).Enabled = True
    'Cmd_Grabar.Enabled = False
    Toolbar1.Buttons(2).Enabled = True
    'Cmd_Eliminar.Enabled = False
    Toolbar1.Buttons(5).Enabled = False
    
'    Cmb_sistema.ListIndex = 0

    Cmb_Tipo_Voucher.ListIndex = -1
    Cmb_Tipo_movimiento.ListIndex = -1
    Cmb_Tipo_Instrumento.ListIndex = -1
    Cmb_Sistema.ListIndex = -1
    Cmb_Tipo_Moneda.ListIndex = -1
    
    Gr_perfil_PV.Refresh
    'Gr_perfil_paso.Refresh
    Gr_perfil.Refresh
    
End Sub



Sub PROC_CARGA_COMBO_SISTEMA()
'   ----------------------------------------------------------------------------------
'   SubRutina   :   Proc_Carga_Combo_sistema - VB
'   Objetivo    :   Realiza la carga de información en los objetos tipo Combos
'   ----------------------------------------------------------------------------------

Dim Datos()
Dim Sql As String

On Error GoTo ErrCarga

  ' Cargo Combo de sistemas
  ' ============================================================================
    
    If Bac_Sql_Execute("SP_BUSCAR_SISTEMAS") Then
        Do While Bac_SQL_Fetch(Datos())
            Cmb_Sistema.AddItem Mid$(Datos(2), 1, 20) & Space(50) & Datos(1)
        Loop
    Else
        MsgBox "No se pudo obtener información del servidor", vbCritical, TITSISTEMA
        Exit Sub
    End If
  ' ============================================================================
  
  
  ' Cargo combo de Tipos de Voucher
  ' ============================================================================
    Cmb_Tipo_Voucher.AddItem "INGRESO"
    Cmb_Tipo_Voucher.AddItem "EGRESO"
    Cmb_Tipo_Voucher.AddItem "TRASPASO"
  ' ============================================================================
  
  ' Cargo combo de Tipos de Voucher
  ' ============================================================================
  ' Cmb_tipo_movimiento.AddItem "MOVIMIENTO"
  ' Cmb_tipo_movimiento.AddItem "DEVENGAMIENTO"
  ' ============================================================================
    Cmb_Tipo_movimiento.ListIndex = -1
    Cmb_Tipo_Instrumento.ListIndex = -1
    Exit Sub
    
ErrCarga:
    MsgBox "Se detectó problemas en carga de información: " & Err.Description & ". Comunique al Administrador.", vbCritical, TITSISTEMA
    Exit Sub
End Sub

Function TextMatrix(Grilla As Control, Fila As Integer, Columna As Integer, Dato As Variant) As Variant
Dim fil_g% ' La puse yo
Dim col_g% ' La puse yo
fil_g% = Grilla.Row
col_g% = Grilla.Col
If Grilla.Rows <= Fila Then Grilla.Rows = Grilla.Rows + 1
Grilla.Row = Fila
Grilla.Col = Columna

If Dato = "X" Then
   TextMatrix = Grilla.Text
Else
   Grilla.Text = Dato
End If

Grilla.Row = fil_g%
Grilla.Col = col_g%

End Function

Private Sub Cmb_Condiciones_Click()
Dim Sql As String
Dim Datos()
Dim X As Integer

    For X = 1 To Gr_perfil.Rows - 1
       Call TextMatrix(Gr_perfil_PV, X, C2_VALOR, "")
       Call TextMatrix(Gr_perfil_PV, X, C2_NCUENTA, "")
       Call TextMatrix(Gr_perfil_PV, X, C2_DESC_CUENTA, "")
    Next X
    
    PROC_CREA_GRILLA_PERFIL_PV
    Envia = Array()
    AddParam Envia, Folio_Perfil
    AddParam Envia, Gr_Filas
    AddParam Envia, CDbl(Right(Cmb_Condiciones.Text, 7))
    
    If Not Bac_Sql_Execute("sp_buscar_periles_variables ", Envia) Then
       MsgBox "Error : Busqueda de Perfiles Variables", vbCritical, TITSISTEMA
       Exit Sub
    End If
    X = 0
    Do While Bac_SQL_Fetch(Datos())
       X = X + 1
       Call TextMatrix(Gr_perfil_PV, X, C2_VALOR, Datos(1))
       Call TextMatrix(Gr_perfil_PV, X, C2_NCUENTA, Datos(2))
       Call TextMatrix(Gr_perfil_PV, X, C2_DESC_CUENTA, Datos(3))
    Loop
    
    
End Sub

Private Sub Cmb_sistema_Click()

     PROC_CARGA_COMBO_MOVIMIENTO
     
End Sub

Private Sub Cmb_sistema_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then Cmb_Tipo_movimiento.SetFocus

End Sub


Private Sub Cmb_Tipo_Movimiento_Click()

PROC_CARGA_COMBO_TIPO_OPERACION     ' Carga Combo de tipos de operación
 
PROC_CARGA_COMBO_MONEDA             ' Carga Combo de monedas

If Cmb_Control_Moneda.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
   Cmb_Tipo_Moneda.ListIndex = -1
End If

PROC_CARGA_COMBO_INSTRUMENTOS       ' Carga Combo de instrumentos

If Cmb_Control_Instrumento.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
   Cmb_Tipo_Instrumento.ListIndex = -1
End If

End Sub

Private Sub Cmb_Tipo_Movimiento_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then Cmb_Tipo_operacion.SetFocus

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

If KeyAscii = 13 Then Txt_Glosa.Enabled = True: Txt_Glosa.SetFocus

End Sub


Sub PROC_CREA_GRILLA_PASO()

' GRILLA PERFIL VARIABLE
'Gr_perfil_paso.Rows = 1
'Gr_perfil_paso.Cols = 3

End Sub


Private Sub Cmd_Agrega_Click()

End Sub

Private Sub Cmd_Agrega_PV_Click()

End Sub

Private Sub Cmd_aceptar_PV_Click()

End Sub

Private Sub Cmd_ayuda_perfil_Click()
On Error GoTo Errores:
    BacAyuda.Tag = "PERFIL"
    BacAyuda.parAyuda = "BAC_CNT_PERFIL"
    BacAyuda.Show 1

    If Trim(gsCodigo$) <> "" And giAceptar Then
    
       Folio_Perfil = CDbl(gsCodigo$)
       varNumeros = Folio_Perfil
    
       PROC_BUSCA_PERFIL Folio_Perfil
       
       Frm_Perfil.Enabled = True
       Toolbar1.Buttons(4).Enabled = False
       'Cmd_Buscar.Enabled = False
       Toolbar1.Buttons(1).Enabled = True
       'Cmd_Grabar.Enabled = True
       Toolbar1.Buttons(2).Enabled = True
       Toolbar1.Buttons(5).Enabled = True
       'Cmd_Eliminar.Enabled = True
    
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
Exit Sub
End Sub

Private Sub Cmd_Buscar_Click()

End Sub





Sub PROC_MARCA_FILA_GRILLA(Objeto_grid As Control, Color1, Color2, Fila, Columna)
Dim fila_actual%, columna_actual%, estilo_fila%

    fila_actual% = Objeto_grid.Row
    'fila_rango% = Objeto_grid.RowSel
    columna_actual% = Objeto_grid.Col
    'columna_rango% = Objeto_grid.ColSel
    estilo_fila% = Objeto_grid.FillStyle
    
    Objeto_grid.Row = Fila
    'Objeto_grid.RowSel = Fila
    Objeto_grid.Col = Columna
    'Objeto_grid.ColSel = Objeto_grid.Cols - 1
    Objeto_grid.FillStyle = flexFillRepeat
    'Objeto_grid.CellBackColor = Color1
    'Objeto_grid.CellForeColor = Color2
    
    Objeto_grid.Row = fila_actual%
    'Objeto_grid.RowSel = fila_rango%
    Objeto_grid.Col = columna_actual%
    'Objeto_grid.ColSel = columna_rango%
    Objeto_grid.FillStyle = estilo_fila%

End Sub

Function FUNC_FMT_NUMERO_TXT(Numero As Double, n_enteros, n_decimales As Integer) As String
Dim fmt_numero    As String
Dim fmt_enteros   As String
Dim fmt_decimales As String

If Numero < 0 Then Numero = Numero * -1

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


Private Sub Cmd_Limpiar_Click()

End Sub

Private Sub Cmd_Grabar_Click()

End Sub



Private Sub Cmd_Perfil_Click()

End Sub

Private Sub Cmd_Elimina_PV_Click()

End Sub

Private Sub Cmd_exit_opciones_Click()
End Sub

Private Sub Form_Activate()

    Screen.MousePointer = vbNormal
    
End Sub

Private Sub Form_Load()

    Me.Top = 0
    Me.Left = 0
        
    'Frm_perfil_PV.Top = 1680
    'Frm_perfil_PV.Left = 300

    Toolbar1.Buttons(5).Enabled = False

    PROC_CARGA_COMBO_SISTEMA    '  Carga Combos iniciales
    
    If Cmb_Sistema.ListCount <= 0 Then
        Exit Sub
    Else
        Txt_Glosa.Enabled = True
        PROC_LIMPIA
    End If
   
End Sub
Function FUNC_FORMATO_CUENTA(Texto As String, Formato As String) As String

If Trim(Texto) = "" Then
   FUNC_FORMATO_CUENTA = ""
   Exit Function
End If
 FUNC_FORMATO_CUENTA = Texto
'If Formato = "F" Then
'   FUNC_FORMATO_CUENTA = Mid(Texto, 1, 2) + "." + Mid(Texto, 3, 2) + "." + Mid(Texto, 5, 2) + "." + Mid(Texto, 7, 3)
'Else
'   FUNC_FORMATO_CUENTA = Mid(Texto, 1, 2) + Mid(Texto, 4, 2) + Mid(Texto, 7, 2) + Mid(Texto, 10, 3)
'End If

End Function


Function FUNC_VALIDA_CUENTA(Cuenta As String, tipo_perfil As String) As Integer
Dim Datos()


Screen.MousePointer = 11

FUNC_VALIDA_CUENTA = False

Envia = Array()
AddParam Envia, Cuenta

If Not Bac_Sql_Execute("sp_busca_cuenta_contable ", Envia) Then
   Screen.MousePointer = 0
   Exit Function
End If

Screen.MousePointer = 0

If Not Bac_SQL_Fetch(Datos()) Then
   MsgBox "Cuenta NO Existe.", vbCritical, TITSISTEMA
   Exit Function
End If

' yo lo saque

'If Trim(DATOS(5)) <> "S" Then  ' Cuenta SVS
'   MsgBox "Cuenta NO Imputable.", vbCritical
'   Exit Function
'End If
'yo lo saque
Select Case tipo_perfil
       Case "PF":  Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_DESC_CUENTA, Trim(Datos(1)))
       Case "PV":  Call TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row, C2_DESC_CUENTA, Trim(Datos(1)))
'       Case "PV2": Call TextMatrix(Gr_perfil_PV2, Gr_perfil_PV2.Row, C3_DESC_CUENTA, Trim(datos(1)))
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

Gr_perfil.ColWidth(C_CAMPO) = 600
Gr_perfil.ColWidth(C_DESC_CAMPO) = 3500
Gr_perfil.ColWidth(C_PERFIL_FIJO) = 400
Gr_perfil.ColWidth(C_TIPO_MOV) = 400
Gr_perfil.ColWidth(C_NCUENTA) = 1100
Gr_perfil.ColWidth(C_DESC_CUENTA) = 4500
Gr_perfil.ColWidth(C_CAMPO_VARIABLE) = 1

Gr_perfil.ColAlignment(C_CAMPO) = 1 'flexAlignRightCenter
Gr_perfil.ColAlignment(C_DESC_CAMPO) = 0 'flexAlignLeftCenter
Gr_perfil.ColAlignment(C_PERFIL_FIJO) = 0 'flexAlignLeftCenter
Gr_perfil.ColAlignment(C_TIPO_MOV) = 0 'flexAlignLeftCenter
Gr_perfil.ColAlignment(C_NCUENTA) = 0 'flexAlignLeftCenter
Gr_perfil.ColAlignment(C_DESC_CUENTA) = 0 'flexAlignLeftCenter
Gr_perfil.ColAlignment(C_CAMPO_VARIABLE) = 0 'flexAlignLeftCenter

'Gr_perfil.Rows = 21
'Gr_perfil.FixedRows = 1
'Gr_perfil.FixedCols = 0
Gr_perfil.Row = 1
Gr_perfil.Col = 0

End Sub
Sub PROC_POSICIONA_TEXTO(Grilla As Control, Texto As Control)
Dim n As Integer
Dim I As Integer
Dim f As Integer

 Texto.Width = Grilla.ColWidth(Grilla.Col)
 Texto.Height = Grilla.RowHeight(Grilla.Row)
 
 If Grilla.TopRow > 1 Then
    Texto.Top = Grilla.Top + (((Grilla.Row - Grilla.TopRow) + 1) * 245)
 Else
    Texto.Top = Grilla.Top + (Grilla.Row * 245)
 End If
 
 n = 0
 f = IIf(Grilla.Col = 0, 0, Grilla.Col - 1)
 
 If Grilla.Col > 0 Then
     For I = 0 To f
        n = n + Grilla.ColWidth(I) + 10
     Next I
 End If
 
 Texto.Left = Grilla.Left + n + 20
 ' Texto.Left = Grilla.Left + (Grilla.Col * 30) + 20
End Sub


Private Sub Gr_perfil_DblClick()
Dim Sql            As String
Dim campo_variable As Integer
Dim Datos()

Gr_Filas = Gr_perfil.Row

If Gr_perfil.Col = C_PERFIL_FIJO Then

   If Trim(Gr_perfil.Text) = "S" Or Trim(Gr_perfil.Text) = "" Then Exit Sub
   
   Screen.MousePointer = 11
   
   PROC_HABILITA_PV False

   PROC_PASA_GRILLA_PV
   
   PROC_MARCA_FILA_GRILLA Gr_perfil, G_COLOR_CLARO, G_COLOR_NEGRO, Gr_perfil.Row, 0
   
   'VicBarra
   
   Envia = Array()
   AddParam Envia, Trim(Right(Cmb_Sistema, 3))
   AddParam Envia, Trim(Right(Cmb_Tipo_movimiento, 3))
   AddParam Envia, Trim(Right(Cmb_Tipo_operacion, 5))
   
   If Not Bac_Sql_Execute("sp_leer_campos ", Envia) Then
      Screen.MousePointer = 0
      MsgBox "Problemas en la Lectura de Campos.", vbCritical, TITSISTEMA
      Exit Sub
   End If
   
   Cmb_Condiciones.Clear
   
   Do While Bac_SQL_Fetch(Datos())
      Cmb_Condiciones.AddItem Datos(5) + Space(80) + Format(CDbl(Datos(4)), "#0")
   Loop
   
   If Cmb_Condiciones.ListCount <> 0 Then
   
      campo_variable = Val(TextMatrix(Gr_perfil, (Gr_perfil.Row), C_CAMPO_VARIABLE, "X"))
   
      If campo_variable > 0 Then
         For r% = 0 To Cmb_Condiciones.ListCount - 1
             Cmb_Condiciones.ListIndex = r%
             If campo_variable = CDbl(Right(Cmb_Condiciones.Text, 3)) Then Exit For
         Next r%
      Else
         Cmb_Condiciones.ListIndex = 0
      End If
      
   End If
      
   FUNC_BUSCAR_PERFIL_VARIABLE (Gr_Filas)
   
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
   BacAyuda.parFiltro = Right(Cmb_Sistema.Text, 3) + Right(Cmb_Tipo_movimiento.Text, 3) + Trim(Right(Cmb_Tipo_operacion.Text, 5))
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
 
   If Trim(TextMatrix(Gr_perfil, Gr_perfil.Row, C_PERFIL_FIJO, "X")) <> "S" Then Exit Sub
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

If KeyAscii = 27 Or Gr_perfil.Col = C_DESC_CAMPO Or Gr_perfil.Col = C_DESC_CUENTA Then Exit Sub

If Not FUNC_VALIDA_LINEA() Then Exit Sub

'If Gr_perfil.Col <> C_CAMPO And Trim(TextMatrix(Gr_perfil, Gr_perfil.Row, C_CAMPO, "X")) = "" Then Exit Sub

'If Gr_perfil.Col = C_NCUENTA Then

'   If Mid(TextMatrix(Gr_perfil, Gr_perfil.Row, C_PERFIL_FIJO, "X"), 1, 1) <> "S" Then Exit Sub
   
'End If

'If Gr_perfil.Col = C_CAMPO Then
'   BacCaracterNumerico KeyAscii

'   If KeyAscii = 0 Then Exit Sub
'Else
'   BacToUCase KeyAscii
'End If

PROC_POSICIONA_TEXTO Gr_perfil, Txt_ingreso_campos

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
       If Trim(TextMatrix(Gr_perfil, Gr_perfil.Row - 1, r%, "X")) = "" Then Exit For
   Next r%
   
   If r% <= C_PERFIL_FIJO Then Exit Function
   
End If

FUNC_VALIDA_LINEA = True

End Function


Private Sub Gr_perfil_PV_DblClick()

If Gr_perfil_PV.Row > 1 Then
   If TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row - 1, C2_CODIGO, "X") = "" Then Exit Sub
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
    BacAyuda.parFiltro = Right(Cmb_Sistema.Text, 3) & Right(Cmb_Tipo_movimiento.Text, 3) & RELLENA_STRING(Trim(Right(Cmb_Tipo_operacion.Text, 4)), "D", 4) & "  " & Trim(Right(Cmb_Condiciones.Text, 5))
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

Function RELLENA_STRING(Dato As String, Pos As String, largo As Integer) As String

'rellena con blancos y completa el largo requerido
' Ejemplo : x$ = RELLENA_STRING(CStr(i#), "I", 10)
' Ejemplo : x$ = RELLENA_STRING(i$, "D", 10)

If Trim(Pos$) = "" Then Pos$ = "I"

If largo < Len(Trim(Dato)) Then
   RELLENA_STRING = Mid(Trim(Dato), 1, largo)
   Exit Function
End If

If Mid(Pos$, 1, 1) = "I" Then 'IZQUIERDA
   RELLENA_STRING = String(largo - Len(Trim(Dato)), " ") + Trim(Dato)
Else                          'DERECHA
   RELLENA_STRING = Trim(Dato) + String(largo - Len(Trim(Dato)), " ")
End If

RELLENA_STRING = Mid(RELLENA_STRING, 1, largo)

End Function

Private Sub Gr_perfil_PV_KeyPress(KeyAscii As Integer)

If Gr_perfil_PV.Col = 0 Or Gr_perfil_PV.Col = 2 Then
   KeyAscii = 0
   Exit Sub
End If
If KeyAscii = 13 Then
   SendKeys "{RIGHT}"
   Exit Sub
End If

If KeyAscii = 27 Or Gr_perfil_PV.Col = C2_DESC_CUENTA Then Exit Sub

If Gr_perfil_PV.Row > 1 Then
   If TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row - 1, C2_CODIGO, "X") = "" Then Exit Sub
End If

'If Gr_perfil_PV.Col = C2_INDICADOR And Mid(Right(Cmb_Tipo_operacion.Text, 10), 1, 6) <> "INSIND" Then Exit Sub
If Gr_perfil_PV.Col = Mid(Right(Cmb_Tipo_operacion.Text, 10), 1, 6) <> "INSIND" Then Exit Sub

BacToUCase KeyAscii

PROC_POSICIONA_TEXTO Gr_perfil_PV, Txt_ingreso_PV

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

PROC_CREA_GRILLA_PERFIL_PV

'Gr_perfil_PV.Redraw = False

'Gr_perfil_PV.Row = 0

'For i% = 1 To Gr_perfil_paso.Rows - 1

'    Gr_perfil_paso.Row = i%
'    Gr_perfil_paso.Col = 0
    
'    If CDBL(Gr_perfil_paso.Text) = Gr_perfil.Row Then
    
'       If Gr_perfil_PV.Row + 1 > Gr_perfil_PV.Rows - 1 Then Gr_perfil_PV.AddItem ""
       
'       Gr_perfil_PV.Row = Gr_perfil_PV.Row + 1
       
'       Gr_perfil_PV.TextMatrix(Gr_perfil_PV.Row, c2_codigo) = Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, c2_codigo + 1)
       
'       Gr_perfil_PV.TextMatrix(Gr_perfil_PV.Row, C2_INDICADOR) = Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_INDICADOR + 1)
       
'       Gr_perfil_PV.TextMatrix(Gr_perfil_PV.Row, C2_NCUENTA) = Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_NCUENTA + 1)
       
'       Gr_perfil_PV.TextMatrix(Gr_perfil_PV.Row, C2_DESC_CUENTA) = Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_DESC_CUENTA + 1)
                     
'    End If
    
'Next i%

'Gr_perfil_PV.Redraw = True

End Sub


Private Sub SSCommand1_Click()

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
On Error Resume Next
    
    Select Case Button.Index
    Case 1
            
           If Not FUNC_VALIDA_INGRESO_PERFIL("PF") Then
              MsgBox "Falta Información para Grabar.", vbCritical, TITSISTEMA
              Exit Sub
           End If
        
           If MsgBox("Seguro de Grabar Perfil ?", 36, TITSISTEMA) <> 6 Then Exit Sub
           
           Screen.MousePointer = 11
           
           PROC_GRABA_PERFIL
                  
           If MsgBox("Seguro de Imprimir Perfil ?", 36, TITSISTEMA) <> 6 Then
            Screen.MousePointer = 0
            Exit Sub
           Else
           
                Call GENERAR_LISTADO
           
                Screen.MousePointer = 0
             
'                PROC_LIMPIA
             
 '               Cmb_Sistema.SetFocus
            End If
    Case 2
            If Mid(Lbl_existe_perfil.Caption, 1, 1) <> "S" Then Exit Sub
            
            If MsgBox("Seguro de Eliminar Perfil ?", 36, TITSISTEMA) = 6 Then
               PROC_ELIMINA_PERFIL
            End If
    Case 3
         PROC_LIMPIA
         Cmb_Sistema.SetFocus
    Case 4
        Dim varsSist    As String
        Dim varsMov     As String
        Dim varsOper    As String
        Dim varsInstr   As String
        Dim varsMone    As String
        Dim cSql        As String
        Dim varData()
        
        varNumeros = 0
        varsSist = Right(Cmb_Sistema.Text, 3)
        varsMov = Right(Cmb_Tipo_movimiento.Text, 3)
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
        If Right(Trim(varsOper), 3) = "ICA" Or Right(Trim(varsOper), 3) = "ICO" Then
            AddParam Envia, Right(Trim(varsOper), 3) + IIf(Right(Trim(varsOper), 3) = "ICA", "P", "L")
        Else
            AddParam Envia, varsInstr
        End If
        AddParam Envia, varsMone
        
'        If Bac_Sql_Execute("sp_leer_perfil_Busca ", Envia) Then
        If Bac_Sql_Execute("sp_leer_perfil_Busca ", Envia) Then
           Do While Bac_SQL_Fetch(Datos())
              varNumeros = CDbl(Datos(1))
              Folio_Perfil = varNumeros
           Loop
'           End If
        End If
        
        If varNumeros = 0 Then
            MsgBox ("Este Perfil no se encuentra")
            Exit Sub
        End If
        
        PROC_BUSCA_PERFIL (varNumeros)
            
        Frm_Perfil.Enabled = True
        Toolbar1.Buttons(4).Enabled = False
        'Cmd_Buscar.Enabled = False
        Toolbar1.Buttons(1).Enabled = True
        'Cmd_Grabar.Enabled = True
        Toolbar1.Buttons(2).Enabled = True
        'Cmd_Eliminar.Enabled = True
         Toolbar1.Buttons(5).Enabled = True
            
        Gr_perfil.Row = 1
        Gr_perfil.Col = C_CAMPO
        Gr_perfil.SetFocus
        SendKeys "^{HOME}"
        
    Case 5
    
    Call GENERAR_LISTADO
    
    Case 6
        Unload Me
    End Select
End Sub

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

Private Sub Toolbar5_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
Case 1
    Dim Sql As String
    Dim Datos()
    Dim X As Integer
    
    Screen.MousePointer = 11
    
    If Not FUNC_VALIDA_INGRESO_PERFIL("PV") Then
       Screen.MousePointer = 0
       MsgBox "Falta Información del Perfil Variable.", vbCritical, TITSISTEMA
       Exit Sub
    End If
    
    Envia = Array()
    AddParam Envia, Gr_Filas
    
    If Not Bac_Sql_Execute("SP_BORRA_PERFIL_VARIABLE ", Envia) Then
       Screen.MousePointer = 0
       Exit Sub
    End If
    
    For X = 1 To Gr_perfil_PV.Rows - 1
        If Trim(TextMatrix(Gr_perfil_PV, X, 1, "X")) <> "" Then
            Envia = Array()
            AddParam Envia, Gr_Filas
            AddParam Envia, TextMatrix(Gr_perfil_PV, X, 0, "X")
            AddParam Envia, TextMatrix(Gr_perfil_PV, X, 1, "X")
            AddParam Envia, TextMatrix(Gr_perfil_PV, X, 2, "X")
            AddParam Envia, CDbl(Right(Cmb_Condiciones, 7))
            
            If Not Bac_Sql_Execute("SP_GRABA_PERFIL_VARIABLE ", Envia) Then
               Screen.MousePointer = 0
               Exit Sub
            End If
        End If
    Next
    
    Screen.MousePointer = 0
    
    Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_DESC_CUENTA, "PERFIL VARIABLE COMPLETO")
    Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_CAMPO_VARIABLE, Trim(Right(Cmb_Condiciones.Text, 3)))
    
    PROC_HABILITA_PV True
    
    SSPanel2.Visible = False
    
    PROC_MARCA_FILA_GRILLA Gr_perfil, G_COLOR_BLANCO, G_COLOR_NEGRO, Gr_perfil.Row, 0
    
    Gr_perfil.SetFocus
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

' VB+- Se desabilita el paso a la grilla despues de la glosa del perfil

'If KeyAscii = 13 And Trim(Txt_glosa.Text) <> "" Then
'
'   Gr_perfil.Row = 1
'   Gr_perfil.Col = C_CAMPO
'   Gr_perfil.Enabled = True
'   Gr_perfil.SetFocus
'   SendKeys "{RIGHT}"
'   SendKeys "{LEFT}"
'
'End If

End Sub


Private Sub Txt_Ingreso_Campos_KeyPress(KeyAscii As Integer)

If KeyAscii = 27 Then
   Gr_perfil.SetFocus
   Exit Sub
End If


Select Case Gr_perfil.Col
       Case C_CAMPO:
            Txt_ingreso_campos.MaxLength = 3
            PROC_FMT_NUMERICO Txt_ingreso_campos, 3, 0, KeyAscii, "+"
       Case C_PERFIL_FIJO:
            Txt_ingreso_campos.MaxLength = 1
            BacToUCase KeyAscii
       Case C_TIPO_MOV:
            Txt_ingreso_campos.MaxLength = 1
            BacToUCase KeyAscii
       Case C_NCUENTA:
            Txt_ingreso_campos.MaxLength = 11
            BacToUCase KeyAscii
End Select

If KeyAscii = 13 And Trim(Txt_ingreso_campos.Text) <> "" Then

   If Not FUNC_VALIDA_INGRESO_FIJO() Then
      Txt_ingreso_campos.Text = ""
      Exit Sub
   End If
   
   Gr_perfil.SetFocus
   
End If

End Sub

Sub PROC_FMT_NUMERICO(Texto As Control, NEnteros, NDecs As Integer, ByRef Tecla, Signo As String)
Dim PosPto%

If Tecla = 13 Or Tecla = 27 Then Exit Sub

If Tecla = 45 And Signo = "+" Then Tecla = 0

If Tecla <> 8 And (Tecla < 48 Or Tecla > 57) Then
   If NDecs = 0 Then
      Tecla = 0
   ElseIf Tecla <> 46 And Tecla <> 45 Then
          Tecla = 0
   End If
End If

If Tecla = 45 And Signo = "-" Then  ' Signo negativo
   If InStr(Texto.Text, "-") > 0 Then
      Tecla = 0
   ElseIf Texto.SelStart > 0 Then
          If Mid(Texto.Text, Texto.SelStart, 1) <> "" Then
             Tecla = 0
          End If
   End If
End If

PosPto% = InStr(Texto.Text, ".")
If PosPto% > 0 And Tecla = 46 Then
   Tecla = 0
   Exit Sub
End If

If NDecs > 0 And PosPto% > 0 And PosPto% <= Texto.SelStart Then
   PosPto% = PosPto% + 1
   If Len(Mid(Texto.Text, PosPto%, NDecs)) = NDecs And Tecla <> 8 Then
      Tecla = 0
   Else
      Exit Sub
   End If
End If

If PosPto% > 0 And Texto.SelStart < PosPto% And Tecla <> 8 Then
   If Len(Mid(Texto.Text, 1, PosPto% - 1)) >= NEnteros Then Tecla = 0
ElseIf PosPto% = 0 And Tecla <> 8 And Chr(Tecla) <> "." Then
       If Len(Texto.Text) >= NEnteros Then Tecla = 0
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
    Txt_ingreso_PV.MaxLength = 11
   
    BacToUCase KeyAscii
    
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









