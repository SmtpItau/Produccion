VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacIniValDef 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Valores por Defecto Spot"
   ClientHeight    =   7020
   ClientLeft      =   4395
   ClientTop       =   1305
   ClientWidth     =   5775
   FillColor       =   &H0000C0C0&
   FillStyle       =   0  'Solid
   ForeColor       =   &H000000C0&
   Icon            =   "Bacivdef.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7020
   ScaleWidth      =   5775
   ShowInTaskbar   =   0   'False
   Begin Threed.SSPanel SSPanel1 
      Height          =   6555
      Left            =   -240
      TabIndex        =   1
      Top             =   480
      Width           =   6015
      _Version        =   65536
      _ExtentX        =   10610
      _ExtentY        =   11562
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
      Begin Threed.SSFrame SSFrame2 
         Height          =   1530
         Index           =   1
         Left            =   120
         TabIndex        =   16
         Top             =   -60
         Width           =   5565
         _Version        =   65536
         _ExtentX        =   9816
         _ExtentY        =   2699
         _StockProps     =   14
         ForeColor       =   16576
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
         Begin VB.ComboBox cboMoneda 
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
            ItemData        =   "Bacivdef.frx":030A
            Left            =   1800
            List            =   "Bacivdef.frx":030C
            Style           =   2  'Dropdown List
            TabIndex        =   28
            Top             =   1020
            Visible         =   0   'False
            Width           =   3690
         End
         Begin BACControles.TXTNumero txtMonto 
            Height          =   315
            Left            =   1800
            TabIndex        =   23
            Top             =   1020
            Width           =   1095
            _ExtentX        =   1931
            _ExtentY        =   556
            ForeColor       =   -2147483635
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0"
            Text            =   "0"
            Min             =   "0"
            Max             =   "999999999"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.OptionButton optArbitraje 
            Caption         =   "&Arbitraje"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   135
            TabIndex        =   17
            Top             =   1080
            Width           =   1335
         End
         Begin VB.OptionButton optEmpresa 
            Caption         =   "&Empresa"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   120
            TabIndex        =   22
            Top             =   750
            Width           =   1335
         End
         Begin VB.OptionButton optPTAS 
            Caption         =   "&Interbancario"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   120
            TabIndex        =   21
            Top             =   360
            Value           =   -1  'True
            Width           =   1695
         End
         Begin VB.ComboBox cmbProducto 
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
            Left            =   1800
            Style           =   2  'Dropdown List
            TabIndex        =   18
            Top             =   405
            Width           =   3690
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
            Left            =   1800
            TabIndex        =   20
            Top             =   165
            Width           =   780
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Monto"
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
            Left            =   1800
            TabIndex        =   19
            Top             =   780
            Width           =   540
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   2520
         Index           =   2
         Left            =   135
         TabIndex        =   2
         Top             =   1425
         Width           =   5565
         _Version        =   65536
         _ExtentX        =   9816
         _ExtentY        =   4445
         _StockProps     =   14
         Caption         =   "Compras"
         ForeColor       =   16576
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
         Begin VB.ComboBox cboDondeCompra 
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
            Left            =   1800
            Style           =   2  'Dropdown List
            TabIndex        =   37
            Top             =   2160
            Width           =   3690
         End
         Begin VB.ComboBox cboDesdeCompra 
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
            Left            =   1800
            Style           =   2  'Dropdown List
            TabIndex        =   36
            Top             =   1800
            Width           =   3690
         End
         Begin VB.ComboBox Cmb_Corres_Compra 
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
            Left            =   1800
            Style           =   2  'Dropdown List
            TabIndex        =   26
            Top             =   1425
            Width           =   3690
         End
         Begin VB.ComboBox FpRecCom 
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
            Left            =   1800
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   1080
            Width           =   3690
         End
         Begin VB.ComboBox FpEntCom 
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
            ItemData        =   "Bacivdef.frx":030E
            Left            =   1800
            List            =   "Bacivdef.frx":0310
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   720
            Width           =   3690
         End
         Begin VB.ComboBox CmbOma 
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
            Left            =   1800
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   360
            Width           =   3690
         End
         Begin VB.Label Label15 
            Caption         =   "En Donde"
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
            Left            =   135
            TabIndex        =   35
            Top             =   2175
            Width           =   1605
         End
         Begin VB.Label Label14 
            Caption         =   "Desde"
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
            Left            =   135
            TabIndex        =   34
            Top             =   1815
            Width           =   1605
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
            Left            =   165
            TabIndex        =   27
            Top             =   1425
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
            TabIndex        =   8
            Top             =   1080
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
            TabIndex        =   7
            Top             =   720
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
            TabIndex        =   6
            Top             =   360
            Width           =   1605
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   2505
         Index           =   0
         Left            =   135
         TabIndex        =   9
         Top             =   3975
         Width           =   5565
         _Version        =   65536
         _ExtentX        =   9816
         _ExtentY        =   4419
         _StockProps     =   14
         Caption         =   "Ventas"
         ForeColor       =   8421376
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
         Begin VB.ComboBox cboDondeVenta 
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
            Left            =   1800
            Style           =   2  'Dropdown List
            TabIndex        =   33
            Top             =   2055
            Width           =   3690
         End
         Begin VB.ComboBox cboDesdeVenta 
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
            Left            =   1800
            Style           =   2  'Dropdown List
            TabIndex        =   32
            Top             =   1695
            Width           =   3690
         End
         Begin VB.ComboBox Cmb_Corres_Venta 
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
            Left            =   1800
            Style           =   2  'Dropdown List
            TabIndex        =   24
            Top             =   1320
            Width           =   3690
         End
         Begin VB.ComboBox FpEntVen 
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
            Left            =   1800
            Style           =   2  'Dropdown List
            TabIndex        =   12
            Top             =   630
            Width           =   3690
         End
         Begin VB.ComboBox FpRecVen 
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
            Left            =   1800
            Style           =   2  'Dropdown List
            TabIndex        =   11
            Top             =   960
            Width           =   3690
         End
         Begin VB.ComboBox CmbOmaV 
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
            Left            =   1800
            Style           =   2  'Dropdown List
            TabIndex        =   10
            Top             =   270
            Width           =   3690
         End
         Begin VB.Label Label13 
            Caption         =   "En Donde"
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
            TabIndex        =   31
            Top             =   2160
            Width           =   855
         End
         Begin VB.Label Label8 
            Caption         =   "Desde"
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
            TabIndex        =   29
            Top             =   1800
            Width           =   855
         End
         Begin VB.Label Label1 
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
            TabIndex        =   25
            Top             =   1440
            Width           =   1695
         End
         Begin VB.Label Label5 
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
            TabIndex        =   15
            Top             =   675
            Width           =   1695
         End
         Begin VB.Label Label7 
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
            TabIndex        =   14
            Top             =   1080
            Width           =   1695
         End
         Begin VB.Label Label11 
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
            TabIndex        =   13
            Top             =   330
            Width           =   1065
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   1350
      Top             =   -60
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
            Picture         =   "Bacivdef.frx":0312
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacivdef.frx":0766
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacivdef.frx":0A8A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5775
      _ExtentX        =   10186
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Label Label12 
      Caption         =   "Desde"
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
      Left            =   0
      TabIndex        =   30
      Top             =   0
      Width           =   3735
   End
End
Attribute VB_Name = "BacIniValDef"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim sData$, iCodigo%

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

Sub Proc_Carga_Corresponsal()
Dim sql$, Datos()

Cmb_Corres_Compra.Clear
Cmb_Corres_Venta.Clear

    sql$ = "SP_LISTA_CORRESPONSALES"
    If MISQL.SQL_Execute(sql$) = 0 Then
    
        Do While MISQL.SQL_Fetch(Datos) = 0
        
            Cmb_Corres_Compra.AddItem Datos(2) & Space(140) & Trim(Datos(1))
            'Cmb_Corres_Compra.ItemData(Cmb_Corres_Compra.ListIndex + 1) = Datos(1)
            
            Cmb_Corres_Venta.AddItem Datos(2) & Space(140) & Trim(Datos(1))
            'Cmb_Corres_Venta.ItemData(Cmb_Corres_Venta.ListIndex + 1) = Datos(1)
            
            cboDesdeCompra.AddItem Datos(2) & Space(140) & Trim(Datos(1))
            cboDondeCompra.AddItem Datos(2) & Space(140) & Trim(Datos(1))
            cboDesdeVenta.AddItem Datos(2) & Space(140) & Trim(Datos(1))
            cboDondeVenta.AddItem Datos(2) & Space(140) & Trim(Datos(1))
            
            
        Loop

    Else
        MsgBox "Problemas en conección para trae datos"
        Exit Sub
    End If

End Sub

Public Sub Carga_Datos()
On Error GoTo Error
Dim sql$, Datos()


    sql = "SP_TRAE_VALOR_DEFECTO 'BCC', "
    sql = sql & " '" & cmbProducto.Tag & "'"
    sql = sql & ",'" & IIf(optPTAS.Value, "PTAS", IIf(optEmpresa.Value, "EMPR", "ARBI")) & "'"
    sql = sql & ",0"
    If MISQL.SQL_Execute(sql) <> 0 Then
        MsgBox "Problemas en conección para trae datos"
        Exit Sub
    End If
    
    If MISQL.SQL_Fetch(Datos) = 0 Then
    
        txtMonto.Text = Val(Datos(15))
        
        bacBuscarCombo CmbOma, Val(Datos(6))
        
        bacBuscarCombo FpEntCom, Val(Datos(4))
        bacBuscarCombo FpRecCom, Val(Datos(5))
        
        bacBuscarCombo CmbOmaV, Val(Datos(11))

        bacBuscarCombo FpRecVen, Val(Datos(9))
        bacBuscarCombo FpEntVen, Val(Datos(10))
        
        
        If optArbitraje.Value = False Then
        If Val(Datos(17)) <> 0 Then
            BuscarCombo Cmb_Corres_Compra, Val(Datos(17))
        End If
        If Val(Datos(18)) <> 0 Then
            BuscarCombo Cmb_Corres_Venta, Val(Datos(18))
        End If
        End If
        
    End If
Exit Sub
Error:
    MsgBox "Error : " & Err.Description, vbCritical, TITSISTEMA
'    Resume
End Sub

Sub Proc_Limpiar()

    cboDesdeCompra.Clear
    cboDondeCompra.Clear
    cboDesdeVenta.Clear
    cboDondeVenta.Clear
    
    optPTAS.Value = True
    optArbitraje.Value = False
    optEmpresa.Value = False

    cmbProducto.Clear
    txtMonto.Text = 0
      
    CmbOma.Clear
    FpRecCom.Clear
    FpEntCom.Clear
    
    CmbOmaV.Clear
    FpRecVen.Clear
    FpEntVen.Clear
    
    '-- deshabilita para evitar evento click vacio
    cmbProducto.Enabled = False
    
    CmbOma.Enabled = False
    FpRecCom.Enabled = False
    FpEntCom.Enabled = False
    
    CmbOmaV.Enabled = False
    FpRecVen.Enabled = False
    FpEntVen.Enabled = False
   
    Call optPTAS_Click
    Call Proc_Carga_Corresponsal
    '-- Carga Productos
    sql = "SP_LEER_FORMAPAGO"
    If MISQL.SQL_Execute(sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos) = 0
            '-- Data = Glosa y Dias Valor
            sData = BacPad(Datos(2), 50) & Datos(8)
            iCodigo = Val(Datos(1))
            '-- Compra
            FpRecCom.AddItem sData
            FpRecCom.ItemData(FpRecCom.NewIndex) = iCodigo
            FpEntCom.AddItem sData
            FpEntCom.ItemData(FpRecCom.NewIndex) = iCodigo
            FpRecCom.Enabled = True
            FpEntCom.Enabled = True
            '-- Venta
            FpRecVen.AddItem sData
            FpRecVen.ItemData(FpRecVen.NewIndex) = iCodigo
            FpEntVen.AddItem sData
            FpEntVen.ItemData(FpRecVen.NewIndex) = iCodigo
            FpRecVen.Enabled = True
            FpEntVen.Enabled = True
        Loop
    End If
        
    '-- Codigos OMA
    sql = "SP_CARGA_OMA_SUDA 'C'"
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
    
    sql = "SP_CARGA_OMA_SUDA 'V'"
    If MISQL.SQL_Execute(sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos) = 0
            '-- Data = Glosa y Dias Valor
            sData = Format(Val(Datos(1)), "000") & " - " & BacPad(Datos(2), 50)
            iCodigo = Val(Datos(1))
            CmbOmaV.AddItem sData
            CmbOmaV.ItemData(CmbOmaV.NewIndex) = iCodigo
            CmbOmaV.Enabled = True
        Loop
    End If


End Sub

Private Sub cboMoneda_Click()

Call LlenaComboCorresponsalMoneda

End Sub

Private Sub CmbOma_Change()
    CmbOma_Click
End Sub

Private Sub CmbOma_Click()
    CmbOma.Tag = ""
    If CmbOma.ListIndex >= 0 And CmbOma.Enabled Then
        CmbOma.Tag = CmbOma.ItemData(CmbOma.ListIndex)
    End If
End Sub
Private Sub CmbOmaV_Change()
    CmbOmaV_Click
End Sub
Private Sub CmbOmaV_Click()
    CmbOmaV.Tag = ""
    If CmbOmaV.ListIndex >= 0 And CmbOmaV.Enabled Then
        CmbOmaV.Tag = CmbOmaV.ItemData(CmbOmaV.ListIndex)
    End If
End Sub
Private Sub cmbProducto_Click()
    cmbProducto.Tag = ""
    If cmbProducto.ListIndex >= 0 And cmbProducto.Enabled Then
        cmbProducto.Tag = Left(cmbProducto, 4)
    End If
    Call Carga_Datos
End Sub
Private Sub cmbProducto_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbProducto_Click
        SendKeys "{TAB}"
    End If
End Sub
Private Sub Form_Activate()
    Screen.MousePointer = 0
End Sub
Private Sub Form_Load()
Dim sql$, Datos()
Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_670" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
    Me.Move 15, 1
    
    Proc_Limpiar
    
    
    
End Sub
Private Sub LlenaComboMoneda()
    sql = "sp_LeeMonedas_Pos"
    
    If Bac_Sql_Execute("sp_LeeMoneda_Pos") Then
        Do While Bac_SQL_Fetch(Datos())
            '--- se verá : nemo, glosa , pais y rrda
            cboMoneda.AddItem BacPad(Datos(3), 5) & BacPad(Datos(2), 35) & Format(Val(Datos(12)), "000") & Space(2) & Datos(1)
            cboMoneda.ItemData(cboMoneda.NewIndex) = Datos(11)    '-- Codigo de Moneda
        Loop
    End If
    
    If cboMoneda.Enabled Then
        cboMoneda.ListIndex = 0
    End If
End Sub

Private Function RetornaIndex(ByVal ComboBox, Item As Integer) As Integer

         
           Dim i, Index As Integer
           i = 0
           Index = 0
           
           Do While (i < ComboBox.ListCount)
                If ComboBox.ItemData(i) = Item Then
                    Index = i
                    RetornaIndex = i
                    i = ComboBox.ListCount
                End If
                i = i + 1
           Loop


End Function


Private Sub LlenaComboCorresponsalMoneda()
    Dim Valor As String
    
    'cboDesdeCompra.Clear
    cboDondeCompra.Clear
    
    cboDesdeVenta.Clear
    'cboDondeVenta.Clear
    
    Cmb_Corres_Venta.Clear
    
    If Bac_Sql_Execute("sp_retorna_corresponsales_moneda " + CStr(cboMoneda.ItemData(cboMoneda.ListIndex))) Then
       
        Do While Bac_SQL_Fetch(Datos())
           
'           cboDesdeCompra.AddItem (BacPad(Datos(6), 100))
'           cboDesdeCompra.ItemData(cboDesdeCompra.NewIndex) = Datos(8)

           cboDondeCompra.AddItem (BacPad(Datos(6), 100))
           cboDondeCompra.ItemData(cboDondeCompra.NewIndex) = Datos(8)

           cboDesdeVenta.AddItem (BacPad(Datos(6), 100))
           cboDesdeVenta.ItemData(cboDesdeVenta.NewIndex) = Datos(8)
           
'           cboDondeVenta.AddItem (BacPad(Datos(6), 100))
'           cboDondeVenta.ItemData(cboDondeVenta.NewIndex) = Datos(8)
           
           Cmb_Corres_Venta.AddItem (BacPad(Datos(6), 100))
           Cmb_Corres_Venta.ItemData(Cmb_Corres_Venta.NewIndex) = Datos(8)
           
            If optArbitraje.Value = True And Trim(Left(CmbOma.Text, 3)) = "009" Then
                           'Call Carga_Correspondal_USD


            End If
        Loop
    End If
    
    Dim i
    i = 0
        If Bac_Sql_Execute("sp_ObtieneValoresDefecto " + CStr(cboMoneda.ItemData(cboMoneda.ListIndex)) + "," + CStr(cmbProducto.ListIndex)) Then
    
            Do While Bac_SQL_Fetch(Datos())
      
               cboDesdeCompra.ListIndex = RetornaIndex(cboDesdeCompra, BacPad(Datos(2), 3))
               cboDesdeVenta.ListIndex = RetornaIndex(cboDesdeVenta, BacPad(Datos(4), 3))
               cboDondeCompra.ListIndex = RetornaIndex(cboDondeCompra, BacPad(Datos(3), 3))
               cboDondeVenta.ListIndex = RetornaIndex(cboDondeVenta, BacPad(Datos(5), 3))
               Cmb_Corres_Compra.ListIndex = RetornaIndex(Cmb_Corres_Compra, BacPad(Datos(8), 3))
               Cmb_Corres_Venta.ListIndex = RetornaIndex(Cmb_Corres_Venta, BacPad(Datos(7), 3))
               i = 1
    
            Loop
        End If
            
            'If cboDesdeCompra.ListCount > 0 Then
            If cboDondeCompra.ListCount > 0 Then
                If i = 0 Then
                
                    If cboDesdeCompra.ListCount > 0 Then cboDesdeCompra.ListIndex = 0
                    If cboDondeCompra.ListCount > 0 Then cboDondeCompra.ListIndex = 0
                    If cboDesdeVenta.ListCount > 0 Then cboDesdeVenta.ListIndex = 0
                    If cboDondeVenta.ListCount > 0 Then cboDondeVenta.ListIndex = 0
                End If
            Else
    
                MsgBox ("No existen corresponsales para la moneda!!!")
            End If
        

End Sub



Private Sub Carga_Correspondal_USD()
   Dim SQL_MX$, SQL_USD$, Datos()
   
   Me.Cmb_Corres_Compra.Clear
   cboDesdeCompra.Clear
   cboDondeVenta.Clear
     'SQL_MX$ = "baccamsuda.dbo.SP_ARBITRAJES_CARGA_CORRESPONSAL 97023000, " & MonMx
     SQL_USD$ = "baccamsuda.dbo.SP_ARBITRAJES_CARGA_CORRESPONSAL 97023000, 13"
     
      If MISQL.SQL_Execute(SQL_USD$) = 0 Then
            Do While MISQL.SQL_Fetch(Datos) = 0
               Me.Cmb_Corres_Compra.AddItem Datos(6) & Space(140) & Trim(Datos(5))
               Me.Cmb_Corres_Compra.ItemData(Cmb_Corres_Compra.NewIndex) = Datos(5)
               
               cboDesdeCompra.AddItem Datos(6) & Space(140) & Trim(Datos(5))
               cboDesdeCompra.ItemData(cboDesdeCompra.NewIndex) = Datos(5)
               
               cboDondeVenta.AddItem Datos(6) & Space(140) & Trim(Datos(5))
               cboDondeVenta.ItemData(cboDondeVenta.NewIndex) = Datos(5)
            Loop
        End If
     
End Sub





Private Sub Grabar() 'pendiente
Dim sProducto$, sArea$
 
    If FpEntCom = "" Or FpRecCom = "" Or CmbOma.Tag = "" Then
        MsgBox "Faltan Datos Compra", vbExclamation, TITSISTEMA
        Exit Sub
        
    ElseIf FpEntVen = "" Or FpRecVen = "" Or CmbOmaV.Tag = "" Then
        MsgBox "Faltan Datos Venta", vbExclamation, TITSISTEMA
        Exit Sub
        
'    ElseIf Val(txtMonto.Text) < 0 Then
'        MsgBox "Faltan Monto", vbExclamation, TITSISTEMA
'        Exit Sub
'
    ElseIf cmbProducto.Tag = "" Then
        MsgBox "Faltan Tipo de Producto", vbExclamation, TITSISTEMA
        Exit Sub
    ElseIf Cmb_Corres_Compra.Text = "" Then
        MsgBox "Falta Seleccionar el Corresponsal Compra", vbExclamation, TITSISTEMA
        Exit Sub
    ElseIf Cmb_Corres_Venta.Text = "" Then
        MsgBox "Falta Seleccionar el Corresponsal Venta", vbExclamation, TITSISTEMA
        Exit Sub
    End If
        
    sArea = (IIf(optPTAS.Value, "PTAS", IIf(optEmpresa.Value, "EMPR", "ARBI")))
    
    Envia = Array()
    
    AddParam Envia, "BCC"
    AddParam Envia, cmbProducto.Tag
    AddParam Envia, sArea
    AddParam Envia, (IIf(optPTAS.Value, 13, IIf(optEmpresa.Value, 13, 142)))
    AddParam Envia, bacTranMontoSql(CDbl(txtMonto.Text))
    AddParam Envia, CmbOma.Tag
    AddParam Envia, ""
    AddParam Envia, ""
    AddParam Envia, FpRecCom.ItemData(FpRecCom.ListIndex)
    AddParam Envia, FpEntCom.ItemData(FpEntCom.ListIndex)
    AddParam Envia, CmbOmaV.Tag
    AddParam Envia, ""
    AddParam Envia, ""
    AddParam Envia, FpRecVen.ItemData(FpRecVen.ListIndex)
    AddParam Envia, FpEntVen.ItemData(FpEntVen.ListIndex)
    AddParam Envia, "S"         '-- PENDIENTE Contabiliza
    AddParam Envia, Val(Right(Cmb_Corres_Compra.Text, 10))
    AddParam Envia, Val(Right(Cmb_Corres_Venta.Text, 10))
    AddParam Envia, 0
    
    If Not Bac_Sql_Execute("SP_GRABAVALORDEFECTO", Envia) Then
        Exit Sub
    Else
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_670 " _
                          , "01" _
                          , "Grabar, Valores Defecto Spot" _
                          , "valor_defecto" _
                          , " " _
                          , " ")
    
    Envia = Array()
    
    AddParam Envia, CStr(cboMoneda.ItemData(cboMoneda.ListIndex))
    AddParam Envia, CStr(cmbProducto.ItemData(cmbProducto.ListIndex))
    AddParam Envia, CStr(cboDesdeCompra.ItemData(cboDesdeCompra.ListIndex))
    AddParam Envia, CStr(cboDondeCompra.ItemData(cboDondeCompra.ListIndex))
    AddParam Envia, CStr(cboDesdeVenta.ItemData(cboDesdeVenta.ListIndex))
    AddParam Envia, CStr(cboDondeVenta.ItemData(cboDondeVenta.ListIndex))
    AddParam Envia, CStr(Cmb_Corres_Venta.ItemData(Cmb_Corres_Venta.ListIndex))
    AddParam Envia, CStr(Cmb_Corres_Compra.ItemData(Cmb_Corres_Compra.ListIndex))
    
    
'    AddParam Envia, CStr((Cmb_Corres_Compra.ListIndex))
'    AddParam Envia, CStr((Cmb_Corres_Venta.ListIndex))
        
    Bac_Sql_Execute "sp_InsertaValoresDefecto", Envia
    
    MsgBox "Datos grabados sin Problemas.", 64, TITSISTEMA
    
    Proc_Limpiar


                          
    End If
                          
'------------------------------------------------------------



End Sub

Private Sub FpEntVen_Click()
    FpEntVen.Tag = 0
    If FpEntVen.ListIndex >= 0 Then
        FpEntVen.Tag = FpEntVen.ItemData(FpEntVen.ListIndex)
    End If
End Sub
Private Sub FpRecCom_Click()
    FpRecCom.Tag = 0
    If FpRecCom.ListIndex >= 0 Then
        FpRecCom.Tag = FpRecCom.ItemData(FpRecCom.ListIndex)
    End If
End Sub
Private Sub ActivaCombo()
    
    txtMonto.Visible = False
    Label3.Caption = "Moneda"
    cboMoneda.Visible = True

End Sub
Private Sub DesactivaCombo()
    txtMonto.Visible = True
    Label3.Caption = "Monto"
    cboMoneda.Visible = False
End Sub

Private Sub optArbitraje_Click()

    Call ActivaCombo
    '-- Carga Productos
    cmbProducto.Clear
    cmbProducto.Enabled = False
    sql = "SP_LEERPRODUCTOSSISTEMAS 'BCC'"
    If MISQL.SQL_Execute(sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos) = 0
            '-- Data = Glosa y Dias Valor
            sData = BacPad(Datos(1), 4) & " - " & BacPad(Datos(2), 50)
            If Datos(1) = "ARBI" Then
                cmbProducto.AddItem sData
                cmbProducto.Enabled = True
            End If
        Loop
    End If
    If cmbProducto.Enabled Then
        cmbProducto.ListIndex = 0
    End If
    
    LlenaComboMoneda
    
    Call Carga_Correspondal_USD
    
    Call LlenaComboCorresponsalMoneda
    
    
    cboDesdeCompra.ListIndex = 0
    cboDesdeVenta.ListIndex = 0
    cboDondeCompra.ListIndex = 0
    cboDondeVenta.ListIndex = 0
    
SSFrame2(2).Height = 2550
SSFrame2(0).Height = 2550
SSFrame2(0).Top = 4000
SSPanel1.Height = 6555
BacIniValDef.Height = 7470
   
End Sub
Private Sub optEmpresa_Click()
    Call DesactivaCombo
    Call Proc_Carga_Corresponsal
    '-- Carga Productos
    cmbProducto.Clear
    cmbProducto.Enabled = False
    sql = "SP_LEERPRODUCTOSSISTEMAS 'BCC'"
    If MISQL.SQL_Execute(sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos) = 0
            '-- Data = Glosa y Dias Valor
            sData = BacPad(Datos(1), 4) & " - " & BacPad(Datos(2), 50)
            If Datos(1) = "EMPR" Or Datos(1) = "ARBI" Then
                cmbProducto.AddItem sData
                cmbProducto.Enabled = True
            End If
        Loop
    End If
    If cmbProducto.Enabled Then
        cmbProducto.ListIndex = 0
    End If
    'Call Proc_Carga_Corresponsal
    SSFrame2(0).Height = 1680
    SSFrame2(2).Height = 1800
    SSFrame2(0).Top = 3240
    SSPanel1.Height = 5000
    BacIniValDef.Height = 5880
    
End Sub
Private Sub optPTAS_Click()
    
    Call DesactivaCombo
    Call Proc_Carga_Corresponsal
    '-- Carga Productos
    cmbProducto.Clear
    cmbProducto.Enabled = False
    sql = "SP_LEERPRODUCTOSSISTEMAS 'BCC'"
    If MISQL.SQL_Execute(sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos) = 0
            '-- Data = Glosa y Dias Valor
            sData = BacPad(Datos(1), 4) & " - " & BacPad(Datos(2), 50)
            cmbProducto.AddItem sData
            cmbProducto.Enabled = True
        Loop
    End If
    If cmbProducto.Enabled Then
        cmbProducto.ListIndex = 0
    End If
    'Call Proc_Carga_Corresponsal

SSFrame2(2).Height = 1800
SSFrame2(0).Height = 1680
SSFrame2(0).Top = 3240
SSPanel1.Height = 5000
BacIniValDef.Height = 5880

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
    Case 1
        Call Grabar
    Case 2
        Call Proc_Limpiar
    Case 3
         Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_670 " _
                          , "08" _
                          , "SALIR DE OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
        Unload Me
    End Select
End Sub

Private Sub txtMonto_KeyPress(KeyAscii As Integer)
    Call bacKeyPress(KeyAscii)
End Sub
