VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{316A9483-A459-11D4-9073-005004A524B9}#1.0#0"; "BacControles.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FrmMantVoucher 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form1"
   ClientHeight    =   8160
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7605
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8160
   ScaleWidth      =   7605
   Begin VB.Frame Frame2 
      Caption         =   "Detalles "
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
      Height          =   5940
      Left            =   0
      TabIndex        =   16
      Top             =   2205
      Width           =   7590
      Begin VB.Frame Frame4 
         Height          =   2805
         Left            =   75
         TabIndex        =   18
         Top             =   3060
         Width           =   7425
         Begin MSFlexGridLib.MSFlexGrid Grilla2 
            Height          =   2520
            Left            =   90
            TabIndex        =   20
            Top             =   195
            Width           =   7215
            _ExtentX        =   12726
            _ExtentY        =   4445
            _Version        =   393216
            Rows            =   3
            Cols            =   4
            FixedRows       =   2
            FixedCols       =   0
            BackColor       =   12632256
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            GridLines       =   2
            GridLinesFixed  =   0
            FormatString    =   ""
         End
      End
      Begin VB.Frame Frame3 
         Height          =   2790
         Left            =   75
         TabIndex        =   17
         Top             =   225
         Width           =   7425
         Begin MSFlexGridLib.MSFlexGrid Grilla 
            Height          =   2520
            Left            =   90
            TabIndex        =   19
            Top             =   180
            Width           =   7245
            _ExtentX        =   12779
            _ExtentY        =   4445
            _Version        =   393216
            Rows            =   3
            Cols            =   3
            FixedRows       =   2
            FixedCols       =   0
            BackColor       =   12632256
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            GridLines       =   2
            GridLinesFixed  =   0
            FormatString    =   ""
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4275
      Top             =   30
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
            Picture         =   "Mant_Voucher.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mant_Voucher.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mant_Voucher.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mant_Voucher.frx":0A86
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   7605
      _ExtentX        =   13414
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Height          =   1665
      Left            =   -15
      TabIndex        =   0
      Top             =   510
      Width           =   7605
      Begin Threed.SSPanel SSPanel2 
         Height          =   1350
         Left            =   3855
         TabIndex        =   3
         Top             =   165
         Width           =   3660
         _Version        =   65536
         _ExtentX        =   6456
         _ExtentY        =   2381
         _StockProps     =   15
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
         Begin VB.ComboBox CmbCuenta 
            Height          =   315
            Left            =   1680
            Style           =   2  'Dropdown List
            TabIndex        =   15
            Top             =   795
            Width           =   1875
         End
         Begin VB.ComboBox CmbProducto 
            Height          =   315
            Left            =   1680
            Style           =   2  'Dropdown List
            TabIndex        =   14
            Top             =   435
            Width           =   1875
         End
         Begin BacControles.txtFecha TxtFechaHasta 
            Height          =   315
            Left            =   1680
            TabIndex        =   13
            Top             =   90
            Width           =   1875
            _ExtentX        =   3307
            _ExtentY        =   556
            Text            =   "19/02/2001"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MinDate         =   -328716
            MaxDate         =   2958465
         End
         Begin VB.Label Label6 
            Caption         =   "Cuenta"
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
            Left            =   195
            TabIndex        =   9
            Top             =   795
            Width           =   1755
         End
         Begin VB.Label Label5 
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
            Height          =   345
            Left            =   195
            TabIndex        =   8
            Top             =   465
            Width           =   2385
         End
         Begin VB.Label Label4 
            Caption         =   "Hasta"
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
            Left            =   195
            TabIndex        =   7
            Top             =   120
            Width           =   1575
         End
      End
      Begin Threed.SSPanel SSPanel1 
         Height          =   1350
         Left            =   90
         TabIndex        =   2
         Top             =   165
         Width           =   3720
         _Version        =   65536
         _ExtentX        =   6562
         _ExtentY        =   2381
         _StockProps     =   15
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
         Begin VB.ComboBox CmbNVoucher 
            Height          =   315
            Left            =   1680
            Style           =   2  'Dropdown List
            TabIndex        =   12
            Top             =   780
            Width           =   1935
         End
         Begin VB.ComboBox CmbSistema 
            Height          =   315
            Left            =   1680
            Style           =   2  'Dropdown List
            TabIndex        =   11
            Top             =   435
            Width           =   1950
         End
         Begin BacControles.txtFecha TxtFechaDesde 
            Height          =   315
            Left            =   1695
            TabIndex        =   10
            Top             =   90
            Width           =   1950
            _ExtentX        =   3440
            _ExtentY        =   556
            Text            =   "19/02/2001"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MinDate         =   -328716
            MaxDate         =   2958465
         End
         Begin VB.Label Label3 
            Caption         =   "Numero Voucher"
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
            Left            =   150
            TabIndex        =   6
            Top             =   855
            Width           =   1470
         End
         Begin VB.Label Label2 
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
            Height          =   345
            Left            =   150
            TabIndex        =   5
            Top             =   495
            Width           =   1515
         End
         Begin VB.Label Label1 
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
            Height          =   285
            Left            =   165
            TabIndex        =   4
            Top             =   120
            Width           =   1410
         End
      End
   End
End
Attribute VB_Name = "FrmMantVoucher"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Load()

   Carga_Grillas
   Carga_Combos

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index

      Case Is = 1:
      
      Case Is = 2:
      
      Case Is = 3:
      
      Case Is = 4: Unload Me
      
   End Select

End Sub

Private Sub TxtFechaDesde_Change()

   If Mid$(TxtFechaDesde.Text, 1, 2) >= Mid$(TxtFechaHasta.Text, 1, 2) And Mid$(TxtFechaDesde.Text, 4, 2) >= Mid$(TxtFechaHasta.Text, 4, 2) And Mid$(TxtFechaDesde.Text, 7, 4) >= Mid$(TxtFechaHasta.Text, 7, 4) Then TxtFechaDesde.Text = TxtFechaHasta.Text

End Sub

Private Sub TxtFechaHasta_Change()

   If Mid$(TxtFechaDesde.Text, 1, 2) >= Mid$(TxtFechaHasta.Text, 1, 2) And Mid$(TxtFechaDesde.Text, 4, 2) >= Mid$(TxtFechaHasta.Text, 4, 2) And Mid$(TxtFechaDesde.Text, 7, 4) >= Mid$(TxtFechaHasta.Text, 7, 4) Then TxtFechaHasta.Text = TxtFechaDesde.Text

End Sub

Sub Carga_Grillas()

   With Grilla
               
         .Row = 0
         .Col = 0
         .CellFontBold = True
         .Col = 1
         .CellFontBold = True
         .Col = 2
         .CellFontBold = True
         .TextMatrix(0, 0) = "Numero"
         .TextMatrix(0, 1) = "Glosa"
         .TextMatrix(0, 2) = "Tipo"
   
   End With

   With Grilla2
               
         .Row = 0
         .Col = 0
         .CellFontBold = True
         .Col = 1
         .CellFontBold = True
         .Col = 2
         .CellFontBold = True
         .Col = 3
         .CellFontBold = True
         .Row = 1
         .Col = 0
         .CellFontBold = True
         .Col = 1
         .CellFontBold = True
         .Col = 2
         .CellFontBold = True
         .Col = 3
         .CellFontBold = True
         
         .ColWidth(0) = 1500
         .TextMatrix(0, 0) = "Fecha"
         .TextMatrix(1, 0) = "Ingreso"
         
         .ColWidth(1) = 1000
         .TextMatrix(0, 1) = "Numero"
         .TextMatrix(1, 1) = "Voucher"
         
         .ColWidth(2) = 2000
         .TextMatrix(0, 2) = "Cuenta"
                  
         .ColWidth(3) = 1500
         .TextMatrix(0, 3) = "Monto"
   
   End With
   
End Sub


Sub Carga_Combos()



End Sub






