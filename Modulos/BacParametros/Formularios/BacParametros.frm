VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacParametros 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Parámetros de Control de Precio y Tasas"
   ClientHeight    =   6780
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7920
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6780
   ScaleWidth      =   7920
   ShowInTaskbar   =   0   'False
   Begin TabDlg.SSTab Paleta 
      Height          =   6195
      Left            =   60
      TabIndex        =   1
      Top             =   570
      Width           =   7815
      _ExtentX        =   13785
      _ExtentY        =   10927
      _Version        =   393216
      Tabs            =   5
      TabsPerRow      =   5
      TabHeight       =   520
      TabCaption(0)   =   "Renta Fija"
      TabPicture(0)   =   "BacParametros.frx":0000
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Grid1(0)"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "BacParamentros(0)"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "texto(0)"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).ControlCount=   3
      TabCaption(1)   =   "Bonos Exterior"
      TabPicture(1)   =   "BacParametros.frx":001C
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "texto(1)"
      Tab(1).Control(1)=   "BacParamentros(1)"
      Tab(1).Control(2)=   "Grid1(1)"
      Tab(1).ControlCount=   3
      TabCaption(2)   =   "Swap"
      TabPicture(2)   =   "BacParametros.frx":0038
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "texto(2)"
      Tab(2).Control(1)=   "Grid1(2)"
      Tab(2).Control(2)=   "BacParamentros(2)"
      Tab(2).ControlCount=   3
      TabCaption(3)   =   "Spot"
      TabPicture(3)   =   "BacParametros.frx":0054
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "frame_spot"
      Tab(3).Control(1)=   "BacParamentros(3)"
      Tab(3).ControlCount=   2
      TabCaption(4)   =   "Forward"
      TabPicture(4)   =   "BacParametros.frx":0070
      Tab(4).ControlEnabled=   0   'False
      Tab(4).Control(0)=   "texto(4)"
      Tab(4).Control(1)=   "BacParamentros(4)"
      Tab(4).Control(2)=   "Grid1(4)"
      Tab(4).ControlCount=   3
      Begin VB.Frame frame_spot 
         Height          =   795
         Left            =   -74820
         TabIndex        =   39
         Top             =   2250
         Width           =   7515
         Begin BACControles.TXTNumero TxtVolatilidad 
            Height          =   345
            Left            =   1980
            TabIndex        =   40
            Top             =   270
            Width           =   1755
            _ExtentX        =   3096
            _ExtentY        =   609
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0,0000"
            Text            =   "0,0000"
            Min             =   "0.0001"
            Max             =   "99999999999"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Label1 
            Caption         =   "Factor de Volatilidad"
            Height          =   345
            Index           =   0
            Left            =   240
            TabIndex        =   41
            Top             =   330
            Width           =   1575
         End
      End
      Begin BACControles.TXTNumero texto 
         Height          =   250
         Index           =   4
         Left            =   -73890
         TabIndex        =   38
         Top             =   2580
         Visible         =   0   'False
         Width           =   1005
         _ExtentX        =   1773
         _ExtentY        =   450
         BackColor       =   8388608
         ForeColor       =   16777215
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,0000"
         Text            =   "0,0000"
         Min             =   "0"
         Max             =   "99999999999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero texto 
         Height          =   250
         Index           =   2
         Left            =   -73890
         TabIndex        =   36
         Top             =   2040
         Visible         =   0   'False
         Width           =   1005
         _ExtentX        =   1773
         _ExtentY        =   450
         BackColor       =   8388608
         ForeColor       =   16777215
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,0000"
         Text            =   "0,0000"
         Min             =   "-99999999999"
         Max             =   "99999999999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grid1 
         Height          =   3585
         Index           =   2
         Left            =   -74850
         TabIndex        =   35
         Top             =   1710
         Width           =   7425
         _ExtentX        =   13097
         _ExtentY        =   6324
         _Version        =   393216
         Cols            =   4
         BackColor       =   -2147483634
         BackColorFixed  =   8421376
         ForeColorFixed  =   -2147483639
         BackColorSel    =   -2147483643
         GridColorFixed  =   16777215
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
      Begin BACControles.TXTNumero texto 
         Height          =   250
         Index           =   1
         Left            =   -73830
         TabIndex        =   34
         Top             =   2730
         Visible         =   0   'False
         Width           =   1005
         _ExtentX        =   1773
         _ExtentY        =   450
         BackColor       =   8388608
         ForeColor       =   16777215
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,0000"
         Text            =   "0,0000"
         Min             =   "0"
         Max             =   "99999999999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero texto 
         Height          =   255
         Index           =   0
         Left            =   1140
         TabIndex        =   32
         Top             =   2790
         Visible         =   0   'False
         Width           =   1005
         _ExtentX        =   1773
         _ExtentY        =   450
         BackColor       =   8388608
         ForeColor       =   16777215
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Min             =   "0"
         Max             =   "99999999999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Frame BacParamentros 
         Height          =   1275
         Index           =   4
         Left            =   -74880
         TabIndex        =   27
         Top             =   810
         Width           =   7515
         Begin VB.ComboBox cmb_moneda 
            Height          =   315
            Index           =   4
            Left            =   1980
            Style           =   2  'Dropdown List
            TabIndex        =   29
            Top             =   660
            Width           =   5475
         End
         Begin VB.ComboBox cmb_producto 
            Height          =   315
            Index           =   4
            Left            =   1980
            Style           =   2  'Dropdown List
            TabIndex        =   28
            Top             =   180
            Width           =   5475
         End
         Begin VB.Label Label2 
            Caption         =   "Producto"
            Height          =   285
            Index           =   4
            Left            =   120
            TabIndex        =   31
            Top             =   210
            Width           =   1095
         End
         Begin VB.Label lbl_familia 
            Caption         =   "Moneda"
            Height          =   315
            Index           =   3
            Left            =   120
            TabIndex        =   30
            Top             =   720
            Width           =   1305
         End
      End
      Begin VB.Frame BacParamentros 
         Height          =   1275
         Index           =   3
         Left            =   -74820
         TabIndex        =   22
         Top             =   810
         Width           =   7515
         Begin VB.ComboBox cmb_producto 
            Height          =   315
            Index           =   3
            Left            =   1980
            Style           =   2  'Dropdown List
            TabIndex        =   24
            Top             =   180
            Width           =   5475
         End
         Begin VB.ComboBox cmb_moneda 
            Height          =   315
            Index           =   3
            Left            =   1980
            Style           =   2  'Dropdown List
            TabIndex        =   23
            Top             =   660
            Width           =   5475
         End
         Begin VB.Label lbl_familia 
            Caption         =   "Moneda"
            Height          =   315
            Index           =   2
            Left            =   120
            TabIndex        =   26
            Top             =   720
            Width           =   1305
         End
         Begin VB.Label Label2 
            Caption         =   "Producto"
            Height          =   285
            Index           =   3
            Left            =   120
            TabIndex        =   25
            Top             =   210
            Width           =   1095
         End
      End
      Begin VB.Frame BacParamentros 
         Height          =   705
         Index           =   2
         Left            =   -74880
         TabIndex        =   19
         Top             =   810
         Width           =   7515
         Begin VB.ComboBox cmb_producto 
            Height          =   315
            Index           =   2
            Left            =   1980
            Style           =   2  'Dropdown List
            TabIndex        =   20
            Top             =   180
            Width           =   5475
         End
         Begin VB.Label Label2 
            Caption         =   "Producto"
            Height          =   285
            Index           =   2
            Left            =   120
            TabIndex        =   21
            Top             =   210
            Width           =   1095
         End
      End
      Begin VB.Frame BacParamentros 
         Height          =   1515
         Index           =   1
         Left            =   -74880
         TabIndex        =   11
         Top             =   810
         Width           =   7515
         Begin VB.ComboBox cmb_familia 
            Height          =   315
            Index           =   1
            Left            =   1980
            Style           =   2  'Dropdown List
            TabIndex        =   15
            Top             =   600
            Width           =   5475
         End
         Begin VB.ComboBox cmb_moneda 
            Height          =   315
            Index           =   1
            Left            =   1980
            Style           =   2  'Dropdown List
            TabIndex        =   14
            Top             =   600
            Width           =   5475
         End
         Begin VB.ComboBox cmb_producto 
            Height          =   315
            Index           =   1
            Left            =   1980
            Style           =   2  'Dropdown List
            TabIndex        =   13
            Top             =   180
            Width           =   5475
         End
         Begin VB.ComboBox cmb_curvas 
            Height          =   315
            Index           =   1
            Left            =   1980
            Style           =   2  'Dropdown List
            TabIndex        =   12
            Top             =   990
            Width           =   5475
         End
         Begin VB.Label Label2 
            Caption         =   "Producto"
            Height          =   285
            Index           =   1
            Left            =   120
            TabIndex        =   18
            Top             =   210
            Width           =   1095
         End
         Begin VB.Label lbl_familia 
            Caption         =   "Familia/Moneda"
            Height          =   315
            Index           =   1
            Left            =   120
            TabIndex        =   17
            Top             =   660
            Width           =   1305
         End
         Begin VB.Label Label3 
            Caption         =   "Curvas"
            Height          =   375
            Index           =   1
            Left            =   120
            TabIndex        =   16
            Top             =   1050
            Width           =   975
         End
      End
      Begin VB.Frame BacParamentros 
         Height          =   1515
         Index           =   0
         Left            =   120
         TabIndex        =   2
         Top             =   810
         Width           =   7515
         Begin VB.ComboBox cmb_curvas 
            Height          =   315
            Index           =   0
            Left            =   1980
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   990
            Width           =   5475
         End
         Begin VB.ComboBox cmb_producto 
            Height          =   315
            Index           =   0
            Left            =   1980
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   180
            Width           =   5475
         End
         Begin VB.ComboBox cmb_familia 
            Height          =   315
            Index           =   0
            Left            =   1980
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   600
            Width           =   5475
         End
         Begin VB.ComboBox cmb_moneda 
            Height          =   315
            Index           =   0
            Left            =   1980
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   600
            Width           =   5475
         End
         Begin VB.Label Label3 
            Caption         =   "Curvas"
            Height          =   375
            Index           =   0
            Left            =   120
            TabIndex        =   9
            Top             =   1050
            Width           =   975
         End
         Begin VB.Label lbl_familia 
            Caption         =   "Familia/Moneda"
            Height          =   315
            Index           =   0
            Left            =   120
            TabIndex        =   8
            Top             =   660
            Width           =   1305
         End
         Begin VB.Label Label2 
            Caption         =   "Producto"
            Height          =   285
            Index           =   0
            Left            =   120
            TabIndex        =   7
            Top             =   210
            Width           =   1095
         End
      End
      Begin MSFlexGridLib.MSFlexGrid Grid1 
         Height          =   3585
         Index           =   0
         Left            =   120
         TabIndex        =   10
         Top             =   2490
         Width           =   7425
         _ExtentX        =   13097
         _ExtentY        =   6324
         _Version        =   393216
         Cols            =   4
         BackColor       =   -2147483634
         BackColorFixed  =   8421376
         ForeColorFixed  =   -2147483639
         BackColorSel    =   -2147483643
         GridColor       =   32768
         GridColorFixed  =   32768
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
      Begin MSFlexGridLib.MSFlexGrid Grid1 
         Height          =   3585
         Index           =   1
         Left            =   -74880
         TabIndex        =   33
         Top             =   2460
         Width           =   7425
         _ExtentX        =   13097
         _ExtentY        =   6324
         _Version        =   393216
         Cols            =   4
         BackColor       =   -2147483634
         BackColorFixed  =   8421376
         ForeColorFixed  =   -2147483639
         BackColorSel    =   -2147483643
         GridColorFixed  =   16777215
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
      Begin MSFlexGridLib.MSFlexGrid Grid1 
         Height          =   3585
         Index           =   4
         Left            =   -74850
         TabIndex        =   37
         Top             =   2250
         Width           =   7425
         _ExtentX        =   13097
         _ExtentY        =   6324
         _Version        =   393216
         Cols            =   4
         BackColor       =   -2147483634
         BackColorFixed  =   8421376
         ForeColorFixed  =   -2147483639
         BackColorSel    =   -2147483643
         GridColorFixed  =   16777215
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
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   540
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7920
      _ExtentX        =   13970
      _ExtentY        =   953
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
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
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5550
         Top             =   150
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   4
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacParametros.frx":008C
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacParametros.frx":0F66
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacParametros.frx":1E40
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacParametros.frx":2D1A
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacParametros"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public sModulo As String
Public iFrame As Integer
Dim Grilla As Variant

Private Sub Cmb_Familia_Click(Index As Integer)
 Call Carga_Curvas(cmb_curvas(iFrame))
End Sub

Private Sub cmb_familia_KeyPress(Index As Integer, KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      Select Case Paleta.Tab
         Case 0, 1
            cmb_curvas(Index).SetFocus
      End Select
   End If

End Sub

Private Sub Cmb_Moneda_Click(Index As Integer)
If Index = 0 Or Index = 1 Then
 Call Carga_Curvas(cmb_curvas(iFrame))
End If

End Sub

Private Sub cmb_producto_Click(Index As Integer)
   If Index = 0 Or Index = 1 Or Index = 3 Or Index = 4 Then
      Call Carga_Moneda(CMB_MONEDA(iFrame))
   End If
   Call BloquearPaletas(Index)
  If sModulo = "BTR" Or sModulo = "BEX" Then
  'LD1-COR-035
   If Trim(Right(cmb_producto(Index).Text, 4)) = "CI" Or Trim(Right(cmb_producto(Index).Text, 4)) = "VI" Or Trim(Right(cmb_producto(Index).Text, 4)) = "ICOL" Or Trim(Right(cmb_producto(Index).Text, 4)) = "ICAP" Or Trim(Right(cmb_producto(Index).Text, 4)) = "RCA" Or Trim(Right(cmb_producto(Index).Text, 4)) = "RVA" Or Trim(Right(cmb_producto(Index).Text, 4)) = "IC" Then
        Cmb_Familia(Index).Visible = False
        CMB_MONEDA(Index).Visible = True
   Else
           CMB_MONEDA(Index).Visible = False
            Cmb_Familia(Index).Visible = True
   End If
  End If
  
End Sub

Private Sub Command1_Click()
BacMntTasas.Show
End Sub

Private Sub cmb_producto_KeyPress(Index As Integer, KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      Select Case Paleta.Tab
         Case 0, 1
            Cmb_Familia(Index).SetFocus
         Case 3, 4
            CMB_MONEDA(Index).SetFocus
         Case 2
      End Select
   End If

End Sub

Private Sub Form_Load()
   
   If Paleta.Tab = 0 Then
      sModulo = "BTR"
      iFrame = 0
   ElseIf Paleta.Tab = 1 Then
      sModulo = "BEX"
      iFrame = 1
   ElseIf Paleta.Tab = 2 Then
      sModulo = "PCS"
      iFrame = 2
   ElseIf Paleta.Tab = 3 Then
      sModulo = "BCC"
      iFrame = 3
   ElseIf Paleta.Tab = 4 Then
      sModulo = "BFW"
      iFrame = 4
   End If
   
   If Paleta.Tab <> 2 Then
      CMB_MONEDA(iFrame).Visible = True
      
   End If
   
   If Paleta.Tab = 0 Or Paleta.Tab = 1 Then
      Cmb_Familia(iFrame).Visible = True
   End If
      
   If Trim(sProd) = "CP" Or Trim(sProd) = "VP" Then
      Cmb_Familia(iFrame).Visible = True
      CMB_MONEDA(iFrame).Visible = False
   End If
   
   Call Carga_Producto(cmb_producto(iFrame))
   
   If Paleta.Tab = 0 Or Paleta.Tab = 1 Then
      Call Carga_Familia(Cmb_Familia(iFrame))
      Call Carga_Curvas(cmb_curvas(iFrame))
   End If
   
   If Paleta.Tab = 0 Or Paleta.Tab = 1 Or Paleta.Tab = 3 Or Paleta.Tab = 4 Then
      Call Carga_Moneda(CMB_MONEDA(iFrame))
   End If
   
   ' Bloqueo Volatuilidad a spot
   
   Me.frame_spot.Enabled = False
   Me.Grid1(0).Enabled = False
   Me.Grid1(1).Enabled = False
   Me.Grid1(2).Enabled = False
   Me.Grid1(4).Enabled = False

   
   
   Call Limpiar(Paleta.Tab, sModulo)
   Call Carga_Grilla(Grid1(iFrame))
   
   
End Sub

'Private Sub Carga_Modulo()
'
'   Dim Datos()
'
'   Envia = Array()
'   AddParam Envia, 1
'
'   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_CARGA_GRILLA", Envia) Then
'      MsgBox "Problemas en obtención de información del servidor ", vbCritical, TITSISTEMA
'      Exit Sub
'   End If
'
'   cmb_modulo.Clear
'
'   Do While Bac_SQL_Fetch(Datos())
'      cmb_modulo.AddItem Trim$(Datos(2)) & Space(150) & Datos(1)
'   Loop
'
'   cmb_modulo.Enabled = True
'
'   If cmb_modulo.ListCount <> 0 Then
'      cmb_modulo.ListIndex = 0
'   End If
'
'End Sub

Private Sub Carga_Producto(OBJCOMBO As ComboBox)
   
   Dim Datos()
    
   Envia = Array()
   AddParam Envia, 2
   AddParam Envia, Right(Trim(sModulo), 3)
   
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_CARGA_GRILLA1", Envia) Then
      MsgBox "Problemas en obtención de información del servidor ", vbCritical, TITSISTEMA
      Exit Sub
   End If
   
   OBJCOMBO.Clear
   
   'OBJCOMBO.AddItem " "
   
   Do While Bac_SQL_Fetch(Datos())
      OBJCOMBO.AddItem Trim$(Datos(2)) & Space(150) & Datos(1)
   Loop
   
   OBJCOMBO.Enabled = True
      
   If OBJCOMBO.ListCount <> 0 Then
      OBJCOMBO.ListIndex = -1
   End If

End Sub

Private Sub Carga_Familia(OBJCOMBO As ComboBox)
   
   Dim Datos()
    
   
   
   Envia = Array()
   AddParam Envia, 3
   AddParam Envia, sModulo
   AddParam Envia, Trim(Right(cmb_producto(iFrame).Text, 3))

   
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_CARGA_GRILLA1", Envia) Then
      MsgBox "Problemas en obtención de información del servidor ", vbCritical, TITSISTEMA
      Exit Sub
   End If
   
   OBJCOMBO.Clear
   'OBJCOMBO.AddItem " "
   
   Do While Bac_SQL_Fetch(Datos())
      OBJCOMBO.AddItem Trim$(Datos(1)) & Space(150) & Datos(2)
   Loop
   
   OBJCOMBO.Enabled = True
      
   If OBJCOMBO.ListCount <> 0 Then
      OBJCOMBO.ListIndex = -1
   End If

End Sub



Private Sub Carga_Moneda(OBJCOMBO As ComboBox)
   
   Dim Datos()
    
   Envia = Array()
   AddParam Envia, 4
   AddParam Envia, sModulo
   AddParam Envia, Trim(Right(cmb_producto(iFrame).Text, 4))
   
  
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_CARGA_GRILLA1", Envia) Then
      MsgBox "Problemas en obtención de información del servidor ", vbCritical, TITSISTEMA
      Exit Sub
   End If
   
   OBJCOMBO.Clear
   'OBJCOMBO.AddItem " "
   Do While Bac_SQL_Fetch(Datos())
      OBJCOMBO.AddItem Trim$(Datos(2)) & Space(150) & Datos(1)
   Loop
   
   OBJCOMBO.Enabled = True
      
   If OBJCOMBO.ListCount <> 0 Then
      OBJCOMBO.ListIndex = -1
   End If

End Sub

Private Sub Carga_Curvas(OBJCOMBO As ComboBox)
 
   Dim Datos()
    
   Envia = Array()
   AddParam Envia, 5
   AddParam Envia, sModulo
   AddParam Envia, Trim(Right(cmb_producto(iFrame).Text, 6))
   AddParam Envia, IIf(Trim(Right(CMB_MONEDA(iFrame).Text, 3)) = "", 0, Trim(Right(CMB_MONEDA(iFrame).Text, 3)))
   
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_CARGA_GRILLA1", Envia) Then
      MsgBox "Problemas en obtención de información del servidor ", vbCritical, TITSISTEMA
      Exit Sub
   End If
   
   OBJCOMBO.Clear
   'OBJCOMBO.AddItem " "
   
   Do While Bac_SQL_Fetch(Datos())
      OBJCOMBO.AddItem Trim$(Datos(1)) & Space(150)
   Loop
   
   OBJCOMBO.Enabled = True
      
   If OBJCOMBO.ListCount <> 0 Then
      OBJCOMBO.ListIndex = -1
   End If

End Sub

Private Sub Carga_Grilla(objGrid As MSFlexGrid)

   If sModulo = "BTR" Or sModulo = "BEX" Or sModulo = "BFW" Then
      
'      objGrid.Rows = 2:   objGrid.FixedRows = 1
      objGrid.Cols = 3:    objGrid.FixedCols = 0
      
      objGrid.ColWidth(0) = 2200:   objGrid.FixedAlignment(0) = flexAlignRight
      objGrid.ColWidth(1) = 2200:   objGrid.FixedAlignment(1) = flexAlignRight
      objGrid.ColWidth(2) = 2200:   objGrid.FixedAlignment(2) = flexAlignRight
      
      objGrid.TextMatrix(0, 0) = "Plazo Desde":
      objGrid.TextMatrix(0, 1) = "Plazo Hasta":
      
      If sModulo = "BFW" Then
         objGrid.TextMatrix(0, 2) = "Volatilidad (%)":
      Else
         objGrid.TextMatrix(0, 2) = "Volatilidad":
      End If
   
   ElseIf sModulo = "PCS" Then
   
  '    objGrid.Rows = 2:   objGrid.FixedRows = 1
      objGrid.Cols = 4:    objGrid.FixedCols = 0
      
      objGrid.ColWidth(0) = 1700: objGrid.FixedAlignment(0) = flexAlignRigth
      objGrid.ColWidth(1) = 1700: objGrid.FixedAlignment(1) = flexAlignRigth
      objGrid.ColWidth(2) = 1700: objGrid.FixedAlignment(2) = flexAlignRigth
      objGrid.ColWidth(3) = 1700: objGrid.FixedAlignment(3) = flexAlignRigth
      
      objGrid.TextMatrix(0, 0) = "Plazo Desde":
      objGrid.TextMatrix(0, 1) = "Plazo Hasta":
      objGrid.TextMatrix(0, 2) = "Rango Mínimo":
      objGrid.TextMatrix(0, 3) = "Rango Máximo":
      
   End If
   

    
End Sub



Private Sub Grid1_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    
    Grilla = 1
    
    If KeyCode = 45 Then
    
         If Grid1(Index).Rows > 1 Then
            If Grid1(Index).TextMatrix(Grid1(Index).Rows - 1, 2) = 0# Then
                Exit Sub
            End If
         
         
            If CDbl(Format(Grid1(Index).TextMatrix(Grid1(Index).Row, 1), FEntero)) <= 9998 Then
                 Call InsertarRow(Grid1(Index))
            End If
         End If
    End If
    
    If KeyCode = 46 Then
        If Grid1(Index).Row = Grid1(Index).Rows - 1 Then
            RES = MsgBox("¿Está Seguro que Desea Eliminar?", vbQuestion + vbYesNo, TITSISTEMA)
            If RES = vbYes Then
                   Grid1(Index).Rows = Grid1(Index).Rows - (Grid1(Index).Rows - Grid1(Index).RowSel)
                   If Grid1(Index).Rows = Grid1(Index).FixedRows Then
                      Call InsertarRow(Grid1(Index))
                   End If
            End If
            Grid1(Index).SetFocus
        Else
            If Grid1(Index).RowSel = Grid1(Index).Rows - 1 Then
                RES = MsgBox("¿Está Seguro que Desea Eliminar?", vbQuestion + vbYesNo, TITSISTEMA)
                If RES = vbYes Then
                   Grid1(Index).Rows = Grid1(Index).Rows - (Grid1(Index).RowSel - Grid1(Index).Row + 1)
                   If Grid1(Index).Rows = Grid1(Index).FixedRows Then
                      Call InsertarRow(Grid1(Index))
                   End If
                End If
                Grid1(Index).SetFocus
            End If
        End If
    End If
    
    If KeyCode = 13 Then
        If Grid1(Index).Col <> 0 Then
            Call textovisible(Grid1(Index), Texto(Index))
            Texto(Index).Text = Grid1(Index).TextMatrix(Grid1(Index).RowSel, Grid1(Index).ColSel)
        End If
    End If
End Sub

Sub textovisible(Grid As MSFlexGrid, Texto As Control)
    
    If Grid.Col = 1 Then
        Texto.CantidadDecimales = 0
        Texto.Max = "99999"
        Texto.Text = Grid.Text
    ElseIf Grid.Col = 2 Then
        Texto.CantidadDecimales = 4
        Texto.Max = "999999999999"
        Texto.Text = CDbl(Grid.Text) 'CDbl(GRID.Text)
    ElseIf Grid.Col = 3 Then
        Texto.CantidadDecimales = 4
        Texto.Max = "999999999999"
        Texto.Text = Grid.Text
    End If
    
    Call PROC_POSICIONA_TEXTO2(Grid, Texto)
    Texto.Visible = True
    Texto.SetFocus
End Sub


Private Sub Grid1_KeyPress(Index As Integer, KeyAscii As Integer)
    
    If KeyAscii = 27 Then
        Unload Me
        Exit Sub
    End If
    If KeyAscii > 47 And KeyAscii < 58 Then
        TeclaPre = KeyAscii
        If Grid1(Index).Col <> 0 And Grid1(Index).Col <> 4 Then
               Call textovisible(Grid1(Index), Texto(Index))
        End If
    End If
    If KeyAscii <> 13 Then
        Texto(Index).Text = Chr(KeyAscii)
        Texto(Index).SelStart = 1
    End If
    
End Sub

Private Sub Paleta_Click(PreviousTab As Integer)
   Call Form_Load
End Sub

Private Function Activar(Index As Integer) As Boolean
    Toolbar1.Enabled = True
    Grid1(Index).Enabled = True
    Grid1(Index).SetFocus
End Function
Private Function Desactivar(Index As Integer) As Boolean
    Toolbar1.Enabled = False
    Grid1(Index).Enabled = False
End Function

Private Sub Texto_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
   Call Desactivar(Index)
    If KeyCode = vbKeyEscape Then
        Call Activar(Index)
        Texto(Index).Visible = False
        Grid1(Index).SetFocus
    End If
    
    If KeyCode = vbKeyReturn Then
        If Grid1(Index).Col = 1 Then
            If CDbl(Grid1(Index).TextMatrix(Grid1(Index).Row, 0)) >= CDbl(Texto(Index).Text) Then
               MsgBox "Error. El 'Plazo Hasta' debe ser mayor a 'Plazo Desde'.", vbExclamation, TITSISTEMA
               Texto(Index).SetFocus
               Call Activar(Index)
               Exit Sub
            Else
          
              If Grid1(Index).Rows - 1 <> Grid1(Index).Row Then
                If CDbl(Format(Texto(Index).Text, FEntero)) >= CDbl(Format(Grid1(Index).TextMatrix(Grid1(Index).Row + 1, 0), FEntero)) Then
                    MsgBox "Atención!, el valor ingresado rompe el orden del correlativo!", vbExclamation, TITSISTEMA
                    Call Activar(Index)
                    Texto(Index).Visible = False
                    Grid1(Index).SetFocus
                    Exit Sub
                End If
              End If
             
               Grid1(Index).Text = Texto(Index).Text
               Grid1(Index).Text = Format(Grid1(Index).Text, FEntero)
            End If
         End If
         Call Activar(Index)
         If Grid1(Index).Col = 0 Then
                    Grid1(Index).TextMatrix(Grid1(Index).Row, 0) = Format(Texto(Index).Text, FEntero)
         ElseIf Grid1(Index).Col = 1 Then
                    Grid1(Index).TextMatrix(Grid1(Index).Row, 1) = Format(Texto(Index).Text, FEntero)
                    If Grid1(Index).RowSel < Grid1(Index).Rows - 1 Then
                     Grid1(Index).TextMatrix(Grid1(Index).Row + 1, 0) = Format(Texto(Index).Text, FEntero) + 1
                    End If
         ElseIf Grid1(Index).Col = 2 Then
                   If sModulo = "BTR" Or sModulo = "BEX" Or sModulo = "BFW" Then
                        If Texto(Index).Text < 0 Then
                            MsgBox "El valor de la Volatilidad no puede ser negativo!", vbExclamation, TITSISTEMA
                            Texto(Index).Visible = False
                            Grid1(Index).SetFocus
                            Call Activar(Index)
                            Exit Sub
                        End If
                   End If
                   Grid1(Index).TextMatrix(Grid1(Index).Row, 2) = Format(Texto(Index).Text, FDecimal)
         End If
        
         Grid1(Index).SetFocus

      If Grilla = 1 Then
         If Grid1(Index).Col = 2 Or Grid1(Index).Col = 3 Then
            Grid1(Index).Text = BacFormatoMonto(Texto(Index).Text, 4)
         Else
            Grid1(Index).Text = BacFormatoMonto(Texto(Index).Text, 0)
         End If
      End If
      Texto(Index).Visible = False
      Call Activar(Index)
   End If

End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index
      Case 1
         Call Limpiar(Paleta.Tab, sModulo)
      Case 2
         Call Grabar(Paleta.Tab)
      Case 3
         Call BUSCAR(Paleta.Tab, Grid1(Paleta.Tab))
      Case 4
         Unload Me
End Select


End Sub


Sub Grid_KeyPress(KeyAscii As Integer, Grid As MSFlexGrid, Texto As Control)
        
    If KeyAscii > 47 And KeyAscii < 58 Then
        TeclaPre = KeyAscii
        If Grid.Col <> 0 And Grid.Col <> 4 Then
            Call textovisible(Grid, Texto)
        End If
    End If

End Sub

Sub TextoKeyDown(KeyCode As Integer, Shift As Integer, Grid As MSFlexGrid, Texto As Control)
    
If KeyCode = vbKeyEscape Then
        Texto.Visible = False
        Grid.SetFocus
    End If
    If KeyCode = vbKeyReturn Then
        If Grid.Col = 1 Then
            If Grid.Row = Grid.Rows - 1 Then
                If CDbl(Format(Texto.Text, FEntero)) > CDbl(Format(Grid.TextMatrix(Grid.Row, 0), FEntero)) Then
                    Grid.Text = Texto.Text
                Else
                    MsgBox "Datos Mal Ingresados", vbCritical, TITSISTEMA
                End If
            Else
                If CDbl(Format(Texto.Text, FEntero)) > CDbl(Format(Grid.TextMatrix(Grid.Row, 0), FEntero)) _
                    And CDbl(Format(Texto.Text, FEntero)) < CDbl(Format(Grid.TextMatrix(Grid.Row + 1, 1), FEntero)) Then
                    Grid.Text = Texto.Text
                Else
                    MsgBox "Datos Mal Ingresados", vbCritical, TITSISTEMA
                End If
            End If
        ElseIf Grid.Col = 2 Then
                    Grid.Text = Texto.Text
        ElseIf Grid.Col = 3 Then
                   Grid.Text = Texto.Text
        End If
        Grid.SetFocus
    End If
End Sub

Sub InsertarRow(Grid As MSFlexGrid)

    Grid.Rows = Grid.Rows + 1
    Grid.Row = Grid.Rows - 1
    Grid.Col = 0
    
    If Grid.Row > 1 Then
      Grid.TextMatrix(Grid.Row, 0) = Format(CDbl(Grid.TextMatrix(Grid.Row - 1, 1)) + 1, FEntero)
    Else
      Grid.TextMatrix(Grid.Row, 0) = 1 'Cdbl(Format(Grid.TextMatrix(Grid.Row - 1, 1), FEntero))
    End If
    
    Grid.TextMatrix(Grid.Row, 1) = Format(CDbl(Grid.TextMatrix(Grid.Row, 0)) + 1, FEntero)
    Grid.TextMatrix(Grid.Row, 2) = 0
    
    If sModulo = "PCS" Then
        Grid.TextMatrix(Grid.Row, 3) = 0
        Grid.TextMatrix(Grid.Row, 3) = Format(Grid.TextMatrix(Grid.Row, 3), FDecimal)
    End If
    
    Grid.TextMatrix(Grid.Row, 0) = Format(CDbl(Grid.TextMatrix(Grid.Row, 0)), FEntero)
    Grid.TextMatrix(Grid.Row, 1) = Format(CDbl(Grid.TextMatrix(Grid.Row, 1)), FEntero)
    Grid.TextMatrix(Grid.Row, 2) = Format(CDbl(Grid.TextMatrix(Grid.Row, 2)), FDecimal)
    
'    SendKeys "{HOME}"


End Sub


Private Function Grabar(Index As Integer) As Integer

      Dim n As Integer
      Dim I As Integer
      Dim Datos()
      Dim sCodMdaFam As String

      If Trim(Right(cmb_producto(Index).Text, 4)) = "" Then
          MsgBox "No ha seleccionado Producto!", vbExclamation, TITSISTEMA
          cmb_producto(Index).SetFocus
          Exit Function
      End If
      
      If sModulo = "BCC" Or sModulo = "BFW" Or Trim(Right(cmb_producto(Index).Text, 4)) = "CI" Or Trim(Right(cmb_producto(Index).Text, 4)) = "VI" Or Trim(Right(cmb_producto(Index).Text, 4)) = "ICOL" Or Trim(Right(cmb_producto(Index).Text, 4)) = "ICAP" Then
           If Trim(Right(CMB_MONEDA(Index).Text, 4)) = "" Then
                  MsgBox "Falta seleccionar una moneda!, verifque! ", vbExclamation, TITSISTEMA
                  CMB_MONEDA(Index).SetFocus
                  Exit Function
            End If
      End If
    
      If sModulo = "BTR" Or sModulo = "BEX" Then
      
        If Trim(Right(cmb_producto(Index).Text, 4)) = "CP" Or Trim(Right(cmb_producto(Index).Text, 4)) = "VP" Then
          If Trim(Right(Cmb_Familia(Index).Text, 4)) = "" Then
               MsgBox "Falta seleccionar la familia del instrumento!, verifque! ", vbExclamation, TITSISTEMA
               Cmb_Familia(Index).SetFocus
               Exit Function
          End If
        End If
     
        If Trim(cmb_curvas(Index).Text) = "" Then
            MsgBox "Falta seleccionar la curva que utilizará!", vbExclamation, TITSISTEMA
            cmb_curvas(Index).SetFocus
            Exit Function
        End If
      End If
      If sModulo = "BCC" Then
            If CDbl(TxtVolatilidad.Text) <= 0 Then
                MsgBox "El valor de la Volatilidad debe ser positivo y mayor que cero.", vbExclamation, TITSISTEMA
                TxtVolatilidad.SetFocus
                Exit Function
            End If
      End If
      If sModulo <> "BCC" Then
            
            n = Grid1(Index).Rows
         
            If n < 2 Then
               MsgBox "No hay datos para grabar!", vbExclamation, TITSISTEMA
               Exit Function
            End If

            For I = 1 To n - 1
               If CDbl(Grid1(Index).TextMatrix(I, 1)) = 0 Then
                    MsgBox "'Dias Hasta' no puede ser cero.", vbExclamation, TITSISTEMA
                    Grid1(Index).Row = I
                    Grid1(Index).Col = 1
                    falla = True
                    Exit For
                End If
                If CDbl(Grid1(Index).TextMatrix(I, 0)) >= CDbl(Grid1(Index).TextMatrix(I, 1)) Then
                    MsgBox "'Dias Desde' no puede ser mayor o igual a 'Dias Hasta'.", vbExclamation, TITSISTEMA
                    Grid1(Index).Row = I
                    Grid1(Index).Col = 1
                    falla = True
                    Exit For
                End If
            
                If Not ValidaPorcentajes(I, Grid1(Index)) Then
                    Grid1(Index).Row = I
                    falla = True
                    Exit For
                End If
                If sModulo = "BTR" Or sModulo = "BEX" Or sModulo = "BFW" Then
                    If CDbl(Grid1(Index).TextMatrix(I, 2)) <= 0 Then
                        MsgBox "La Volatilidad debe ser positiva y mayor que cero!", vbExclamation, TITSISTEMA
                        Exit Function
                    End If
                End If
                
                'Verificar correlatividad
                
                If I > 2 Then
                    If CDbl(Grid1(Index).TextMatrix(I, 0)) - 1 <> CDbl(Grid1(Index).TextMatrix(I - 1, 1)) Then
                        'Corregir correlatividad
                        Grid1(Index).TextMatrix(I, 0) = Format(CDbl(Grid1(Index).TextMatrix(I - 1, 1)) + 1, FEntero)
                    End If
                End If
            Next I
            
            If falla Then
                Grid1(Index).SetFocus
                Exit Function
            End If
      End If
      
      If MsgBox("¿Confirma la grabación?", vbQuestion + vbYesNo, TITSISTEMA) <> vbYes Then
          Exit Function
      End If
      
      Call BacBeginTransaction
      
      Envia = Array()
      AddParam Envia, Trim(sModulo)
      AddParam Envia, Trim(Right(cmb_producto(Index).Text, 4))
      
      If sModulo = "BTR" Or sModulo = "BEX" Then
         AddParam Envia, Trim(Right(Cmb_Familia(Index).Text, 4))
         AddParam Envia, Trim(Right(CMB_MONEDA(Index).Text, 4))
         AddParam Envia, Trim(cmb_curvas(Index).Text)
      Else
         AddParam Envia, ""
         
         If sModulo = "BCC" Or sModulo = "BFW" Then
               AddParam Envia, Trim(Right(CMB_MONEDA(Index).Text, 4))
         Else
                AddParam Envia, ""
         End If
         
         AddParam Envia, ""
      End If
      
      If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_ELIMINA_TASASPRECIOS", Envia) Then
          Call BacRollBackTransaction
          MsgBox "Problema en la eliminación de Tasas de Instrumentos", vbExclamation, TITSISTEMA
          Exit Function
      End If
      
      Orden = 0
      fallas = 0
      
      If sModulo = "BCC" Then
            If TxtVolatilidad.Text < 0 Then
                MsgBox "El Valor de la Volatilidad no puede ser negativo!", vbExclamation, TITSISTEMA
                Exit Function
            End If
                Envia = Array()
                AddParam Envia, sModulo
                AddParam Envia, Trim(Right(cmb_producto(Index).Text, 4))
                AddParam Envia, Trim(Right(CMB_MONEDA(Index).Text, 4))
                AddParam Envia, CDbl(Format(TxtVolatilidad.Text, FDecimal))
                
                 If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_GRABA_TASASPRECIOS", Envia) Then
                       Call BacRollBackTransaction
                       MsgBox "Problema en la Actualización de Tasas de Instrumentos", vbExclamation, TITSISTEMA
                       Exit Function
                 End If
                 
                 If Bac_SQL_Fetch(Datos()) Then
                      If Datos(1) <> "OK" Then
                         fallas = fallas + 1
                      End If
                  End If
                  
                  GoTo Validacion
            
      End If
      
      For I = 1 To Grid1(Index).Rows - 1
               Orden = Orden + 1
               
               Envia = Array()
               AddParam Envia, sModulo
               AddParam Envia, Trim(Right(cmb_producto(Index).Text, 4))
                
               If sModulo = "BTR" Or sModulo = "BEX" Then
                  AddParam Envia, Trim(Right(CMB_MONEDA(Index).Text, 4))
                  AddParam Envia, CDbl(Grid1(Index).TextMatrix(I, 2))
                  AddParam Envia, Trim(Right(Cmb_Familia(Index).Text, 4))
                  AddParam Envia, Trim(cmb_curvas(Index).Text)
               End If
               
               If sModulo = "PCS" Then
                  AddParam Envia, ""
                  AddParam Envia, CDbl(TxtVolatilidad.Text) 'VOLATILIDAD
                  AddParam Envia, ""   'FAMILIA
                  AddParam Envia, ""   'CURVA
               End If
               
               If sModulo = "BFW" Then
                  AddParam Envia, Trim(Right(CMB_MONEDA(Index).Text, 4))
                  AddParam Envia, CDbl(Grid1(Index).TextMatrix(I, 2))      'VOLATILIDAD
                  AddParam Envia, ""   'FAMILIA
                  AddParam Envia, ""   'CURVA
               End If
            
               If sModulo = "BCC" Then
                  AddParam Envia, ""
                  AddParam Envia, 0
                  AddParam Envia, ""
                  AddParam Envia, ""
               End If
            
               AddParam Envia, CDbl(Grid1(Index).TextMatrix(I, 0)) 'PLAZO DESDE
               AddParam Envia, CDbl(Grid1(Index).TextMatrix(I, 1)) 'PLAZO HASTA
               
               If sModulo = "PCS" Then
                  AddParam Envia, CDbl(Grid1(Index).TextMatrix(I, 2)) 'RANGO DESDE
                  AddParam Envia, CDbl(Grid1(Index).TextMatrix(I, 3)) 'RANGO HASTA
               Else
                  AddParam Envia, 0
                  AddParam Envia, 0
               End If
         
               If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_GRABA_TASASPRECIOS", Envia) Then
                  Call BacRollBackTransaction
                  MsgBox "Problema en la Actualización de Tasas de Instrumentos", vbExclamation, TITSISTEMA
                  Exit Function
               End If
                  
               If Bac_SQL_Fetch(Datos()) Then
                  If Datos(1) <> "OK" Then
                     fallas = fallas + 1
                  End If
               End If
                  
      Next I
      
      GoTo Validacion
      
Validacion:
      
      If fallas = 0 Then
          MsgBox "Grabación Realizada Exitosamente!", vbInformation, TITSISTEMA
      End If
      
      Call BacCommitTransaction
      Toolbar1.Buttons(2).Enabled = False
      Call Limpiar(Index, sModulo)
      
End Function
Sub BUSCAR(Index As Integer, Grid1 As MSFlexGrid)
    Dim I%
    Dim cantFilas As Integer
    Dim Datos()
    Dim cProd As String
    
    If Index < 3 Or Index > 3 Then
      Grid1.Enabled = True
    ElseIf Index = 3 Then
      frame_spot.Enabled = True
    End If
    
    
    cProd = Trim(Right(cmb_producto(Index).Text, 4))
    cantFilas = 0
    
    If Trim(Right(cmb_producto(Index).Text, 4)) = "" Then
       MsgBox "Falta seleccionar un producto para buscar!", vbExclamation, TITSISTEMA
       cmb_producto(Index).SetFocus
       Exit Sub
    End If

    If sModulo = "BCC" Or sModulo = "BFW" Or cProd = "CI" Or cProd = "VI" Or cProd = "ICOL" Or cProd = "ICAP" Then
        If Trim(CMB_MONEDA(Index).Text) = "" Then
               MsgBox "Falta seleccionar una moneda para buscar!, verifque! ", vbExclamation, TITSISTEMA
               CMB_MONEDA(Index).SetFocus
               Exit Sub
         End If
    End If
    
    If sModulo = "BTR" Or sModulo = "BEX" Then
    
        If cProd = "CP" Or cProd = "VP" Or sModulo = "BEX" Then
          If Trim(Right(Trim(Cmb_Familia(Index).Text), 4)) = "" Then
               MsgBox "Falta seleccionar un la familia de instrumento para buscar!, verifque! ", vbExclamation, TITSISTEMA
               Cmb_Familia(Index).SetFocus
               Exit Sub
          End If
        End If
     
        If Trim(cmb_curvas(Index).Text) = "" Then
            MsgBox "Falta seleccionar la curva que utilizará!", vbExclamation, TITSISTEMA
            cmb_curvas(Index).SetFocus
            Exit Sub
        End If
        
    End If

    Envia = Array()
    AddParam Envia, sModulo
    AddParam Envia, Trim(Right(cmb_producto(Index).Text, 4))
    
    If sModulo = "BTR" Or sModulo = "BEX" Then
      AddParam Envia, Trim(Right(CMB_MONEDA(Index).Text, 4))
      AddParam Envia, Trim(Right(Cmb_Familia(Index).Text, 4))
      AddParam Envia, Trim(cmb_curvas(Index).Text)
    End If
    
    If sModulo = "BCC" Or sModulo = "BFW" Then
         AddParam Envia, Trim(Right(CMB_MONEDA(Index).Text, 4))
         AddParam Envia, ""
         AddParam Envia, ""
    End If
          
    If sModulo = "PCS" Then
         AddParam Envia, ""
         AddParam Envia, ""
         AddParam Envia, ""
    End If
          
    If Not Bac_Sql_Execute("bacParamSuda.dbo.SP_BUSCA_TASASPRECIOS", Envia) Then
       MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
       Exit Sub
    End If
    
    If sModulo = "BCC" Then
      If Bac_SQL_Fetch(Datos()) Then
            TxtVolatilidad.Text = CDbl(Datos(1))
            Exit Sub
      Else
            MsgBox "No existen datos para la seleccion solicitada", vbExclamation, TITSISTEMA
            TxtVolatilidad.Text = 0#
            Exit Sub
      End If
    End If
    
    Grid1.Rows = Grid1.FixedRows
    
    Do While Bac_SQL_Fetch(Datos())
        Grid1.Rows = Grid1.Rows + 1
        Grid1.Row = Grid1.Rows - 1
        
        Grid1.TextMatrix(Grid1.Row, 0) = Format(Datos(1), FEntero)
        Grid1.TextMatrix(Grid1.Row, 1) = Format(Datos(2), FEntero)
        Grid1.TextMatrix(Grid1.Row, 2) = Format(Datos(3), FDecimal)
        
        If sModulo = "PCS" Then
           Grid1.TextMatrix(Grid1.Row, 3) = Format(Datos(4), FDecimal)
        End If
        
        cantFilas = cantFilas + 1
    Loop
    Toolbar1.Buttons(3).Enabled = False
    If cantFilas = 0 Then
       MsgBox "No se encontraron datos para el instrumento buscado!", vbInformation, TITSISTEMA
       'Call Limpiar(Index, sModulo)
         Call InsertarRow(Grid1)
       Exit Sub
    Else
      cmb_producto(Index).Enabled = False
      
      If Index = 0 Or Index = 1 Then
        CMB_MONEDA(Index).Enabled = False
        Cmb_Familia(Index).Enabled = False
        cmb_curvas(Index).Enabled = False
      End If
      
      If Index = 4 Then
         CMB_MONEDA(Index).Enabled = False
      End If
      
    End If
    
    If Grid1.Rows = Grid1.FixedRows Then
        Call InsertarRow(Grid1)
    End If
    
    Grid1.Col = 0
    Grid1.Row = Grid1.FixedRows
    
End Sub

Private Sub Limpiar(Index As Integer, sModulo As String)
     
      Toolbar1.Buttons(2).Enabled = True
      Toolbar1.Buttons(3).Enabled = True
      cmb_producto(Index).ListIndex = -1
      cmb_producto(Index).Enabled = True
      
      If sModulo = "BTR" Or sModulo = "BEX" Then
         CMB_MONEDA(Index).ListIndex = -1
         Cmb_Familia(Index).ListIndex = -1
         CMB_MONEDA(Index).Enabled = True
         Cmb_Familia(Index).Enabled = True
      End If
            
      Call LimpiarGrilla(Index, sModulo)
      
      If sModulo = "BCC" Then
         TxtVolatilidad.Text = 0#
      End If
      
      If sModulo <> "BCC" Then
'         Call InsertarRow(Grid1(Index))
      End If
      Call DesbloquearPaletas
End Sub

Private Sub LimpiarGrilla(Index As Integer, sModulo As String)
      Dim iContador As Integer
      
      If sModulo = "BTR" Or sModulo = "BEX" Or sModulo = "PCS" Or sModulo = "BFW" Then
         iContador = 1
         Grid1(Index).Rows = Grid1(Index).Rows - (Grid1(Index).Rows - iContador)
      End If
End Sub


Private Function ValidaPorcentajes(Fila As Integer, Grilla As MSFlexGrid) As Boolean

   If sModulo = "PCS" Then
      If CDbl(Grilla.TextMatrix(Fila, 2)) > CDbl(Grilla.TextMatrix(Fila, 3)) Then
              MsgBox "Error, la Desviación mínima no puede ser mayor a la máxima!", vbExclamation, TITSISTEMA
              Grilla.SetFocus
              ValidaPorcentajes = False
              Exit Function
      End If
      
      If CDbl(Grilla.TextMatrix(Fila, 2)) = CDbl(Grilla.TextMatrix(Fila, 3)) Then
              MsgBox "Error, las Desviaciones mínima y máxima no pueden ser iguales!", vbExclamation, TITSISTEMA
              Grilla.SetFocus
              ValidaPorcentajes = False
              Exit Function
      End If
   End If
   
   ValidaPorcentajes = True
   
End Function
Private Sub BloquearPaletas(ByVal selPaleta As Integer)
Dim I As Integer
Paleta.TabEnabled(selPaleta) = True
For I = 0 To 4
    If I <> selPaleta Then
        Paleta.TabEnabled(I) = False
    End If
Next I
End Sub
Private Sub DesbloquearPaletas()
Dim I As Integer
For I = 0 To 4
    Paleta.TabEnabled(I) = True
Next I
End Sub

