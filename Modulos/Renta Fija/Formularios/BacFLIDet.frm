VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacFLIDet 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Detalle Operaciones FLI"
   ClientHeight    =   4950
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   12420
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4950
   ScaleWidth      =   12420
   StartUpPosition =   2  'CenterScreen
   Begin BACControles.TXTNumero TxtIngreso 
      Height          =   255
      Left            =   6480
      TabIndex        =   15
      Top             =   1980
      Visible         =   0   'False
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   450
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
      Text            =   "0.0000"
      Text            =   "0.0000"
      CantidadDecimales=   "4"
      Separator       =   -1  'True
      MarcaTexto      =   -1  'True
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   14
      Top             =   0
      Width           =   12420
      _ExtentX        =   21908
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   10680
         Top             =   120
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   25
         ImageHeight     =   25
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacFLIDet.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacFLIDet.frx":0EDA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1095
      Left            =   120
      TabIndex        =   1
      Top             =   540
      Width           =   12195
      Begin VB.Label LblHaircut 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0C0C0&
         Height          =   315
         Left            =   9840
         TabIndex        =   21
         Top             =   180
         Width           =   1335
      End
      Begin VB.Label LblMargen 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0C0C0&
         Height          =   315
         Left            =   7035
         TabIndex        =   20
         Top             =   165
         Width           =   1575
      End
      Begin VB.Label Label7 
         Caption         =   "Haircut"
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
         Left            =   8880
         TabIndex        =   19
         Top             =   240
         Width           =   855
      End
      Begin VB.Label Label6 
         Caption         =   "Margen:"
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
         Left            =   6180
         TabIndex        =   18
         Top             =   240
         Width           =   855
      End
      Begin VB.Label LblNominalVender 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0C0C0&
         Height          =   315
         Left            =   8100
         TabIndex        =   17
         Top             =   600
         Width           =   3075
      End
      Begin VB.Label Label5 
         Caption         =   "Nominal a Vender:"
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
         Left            =   6180
         TabIndex        =   16
         Top             =   660
         Width           =   1635
      End
      Begin VB.Label LblTasa 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0C0C0&
         Height          =   315
         Left            =   3900
         TabIndex        =   7
         Top             =   180
         Width           =   1875
      End
      Begin VB.Label LblCartera 
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0C0C0&
         Height          =   315
         Left            =   1860
         TabIndex        =   6
         Top             =   600
         Width           =   3915
      End
      Begin VB.Label LblPapel 
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0C0C0&
         Height          =   315
         Left            =   840
         TabIndex        =   5
         Top             =   180
         Width           =   1935
      End
      Begin VB.Label Label3 
         Caption         =   "Tasa Ref."
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
         Left            =   2940
         TabIndex        =   4
         Top             =   240
         Width           =   1215
      End
      Begin VB.Label Label2 
         Caption         =   "Cartera Normativa:"
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
         Left            =   120
         TabIndex        =   3
         Top             =   660
         Width           =   1815
      End
      Begin VB.Label Label1 
         Caption         =   "Papel:"
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
         TabIndex        =   2
         Top             =   240
         Width           =   1695
      End
   End
   Begin MSFlexGridLib.MSFlexGrid GRILLA 
      Height          =   3255
      Left            =   120
      TabIndex        =   0
      Top             =   1650
      Width           =   12195
      _ExtentX        =   21511
      _ExtentY        =   5741
      _Version        =   393216
      Cols            =   15
      BackColor       =   12632256
      ForeColor       =   0
      BackColorFixed  =   8388608
      ForeColorFixed  =   16777215
      BackColorSel    =   16744576
      ForeColorSel    =   16777215
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label LblBloqueoPacto 
      Alignment       =   1  'Right Justify
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
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
      Left            =   10500
      TabIndex        =   13
      Top             =   4980
      Width           =   1755
   End
   Begin VB.Label LblTasaValSel 
      Alignment       =   1  'Right Justify
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
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
      Left            =   8700
      TabIndex        =   12
      Top             =   4980
      Width           =   1755
   End
   Begin VB.Label LblNominalSel 
      Alignment       =   1  'Right Justify
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
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
      Left            =   6960
      TabIndex        =   11
      Top             =   4980
      Width           =   1695
   End
   Begin VB.Label LblValTasa 
      Alignment       =   1  'Right Justify
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
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
      Left            =   5100
      TabIndex        =   10
      Top             =   4980
      Width           =   1815
   End
   Begin VB.Label LblNominal 
      Alignment       =   1  'Right Justify
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
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
      Left            =   2100
      TabIndex        =   9
      Top             =   4980
      Width           =   1875
   End
   Begin VB.Label Label4 
      Caption         =   "Totales"
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
      Left            =   180
      TabIndex        =   8
      Top             =   5040
      Width           =   1635
   End
End
Attribute VB_Name = "BacFLIDet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const Col_NomEmisor = 1
Const Col_NumDocumento = 2
Const Col_NumCorrelativo = 3
Const Col_Nominal_Compra = 4
Const Col_Nominal_Venta1 = 5
Const Col_TCmp = 6
Const Col_Tasa_Venta = 7
Const Col_vPresente_Venta = 8
Const Col_vInicial_Venta = 9
Const Col_BloqueoPacto = 10
Const Col_Marca = 11
Const Col_Nominal_Venta = 12
Const Col_vPresente_Venta2 = 13
Const Col_vInicial_Venta2 = 14


Const FDec4Dec = "#,##0.0000"
Const FDec2Dec = "#,##0.00"
Const FDec0Dec = "#,##0"

Dim Valor_Nominal_Compra
Dim Valor_Valor_Presente
Dim Valor_Tasa_Venta
Dim Valor_vPresente_Venta
Dim Valor_vInicial_Venta
Dim Valor_BloqueoPacto
Dim Valor_Marca
Dim Valor_Nominal_Venta
Dim Valor_vPresente_Venta2
Dim Valor_vInicial_Venta2
Dim sMarca As String
Dim bAceptar As Boolean

Private Sub Form_Load()

   Let sMarca = BACFLI.nMarca
   LblPapel.Caption = BACFLI.nSerie
   LblCartera.Caption = BACFLI.sCarteraNorm
   LblTasa.Caption = BACFLI.dTasaRef
   LblNominalSel.Caption = BACFLI.dNominal
   LblNominalVender.Caption = Format(BACFLI.dNominal, FDec4Dec)
   Let bAceptar = False
   
   If sMarca = "P" Then
      Toolbar1.Buttons(1).Enabled = True
   Else
      Toolbar1.Buttons(1).Enabled = False
   End If
   
   Call Sub_Configurar_Grilla
   Call Sub_Leer_Detalle_Fli
   GRILLA.AllowUserResizing = flexResizeColumns
End Sub


Private Sub Sub_Configurar_Grilla()

   Let GRILLA.WordWrap = True

   Let GRILLA.Rows = 2:      Let GRILLA.cols = 15
   Let GRILLA.Row = 1:       Let GRILLA.Col = 1
   Let GRILLA.FixedRows = 1: Let GRILLA.FixedCols = 1



   Let GRILLA.TextMatrix(0, 0) = "":                                          Let GRILLA.ColWidth(0) = 1000:                        Let GRILLA.TextMatrix(1, 0) = ""
   Let GRILLA.TextMatrix(0, Col_NomEmisor) = "Emisor":                        Let GRILLA.ColWidth(Col_NomEmisor) = 800:             Let GRILLA.TextMatrix(1, Col_NomEmisor) = ""
   Let GRILLA.TextMatrix(0, Col_NumDocumento) = "Documento":                  Let GRILLA.ColWidth(Col_NumDocumento) = 800:         Let GRILLA.TextMatrix(1, Col_NumDocumento) = ""
   Let GRILLA.TextMatrix(0, Col_NumCorrelativo) = "Corr.":                    Let GRILLA.ColWidth(Col_NumCorrelativo) = 500:        Let GRILLA.TextMatrix(1, Col_NumCorrelativo) = ""
   Let GRILLA.TextMatrix(0, Col_Nominal_Compra) = "Nominal Disponible":       Let GRILLA.ColWidth(Col_Nominal_Compra) = 2000:       Let GRILLA.TextMatrix(1, Col_Nominal_Compra) = Format(0#, FDec4Dec)
   Let GRILLA.TextMatrix(0, Col_Nominal_Venta1) = "Nominal Selecc.":          Let GRILLA.ColWidth(Col_Nominal_Venta1) = 2000:       Let GRILLA.TextMatrix(1, Col_Nominal_Venta1) = Format(0#, FDec4Dec)
   
   Let GRILLA.TextMatrix(0, Col_TCmp) = "T.Cmp.":                             Let GRILLA.ColWidth(Col_TCmp) = 1000:                 Let GRILLA.TextMatrix(1, Col_TCmp) = Format(0#, FDec4Dec)
   Let GRILLA.TextMatrix(0, Col_Tasa_Venta) = "T.Ref+H.Curt":                 Let GRILLA.ColWidth(Col_Tasa_Venta) = 1000:           Let GRILLA.TextMatrix(1, Col_Tasa_Venta) = Format(0#, FDec0Dec)
   Let GRILLA.TextMatrix(0, Col_vPresente_Venta) = "Valor Tasa Val.Selec.":   Let GRILLA.ColWidth(Col_vPresente_Venta) = 1000:      Let GRILLA.TextMatrix(1, Col_vPresente_Venta) = Format(0#, FDec0Dec)
   Let GRILLA.TextMatrix(0, Col_vInicial_Venta) = "Valor Inicial Selecc.":    Let GRILLA.ColWidth(Col_vInicial_Venta) = 1500:       Let GRILLA.TextMatrix(1, Col_vInicial_Venta) = Format(0#, FDec0Dec)
   Let GRILLA.TextMatrix(0, Col_BloqueoPacto) = "BloqueadoPacto":             Let GRILLA.ColWidth(Col_BloqueoPacto) = 1500:         Let GRILLA.TextMatrix(1, Col_BloqueoPacto) = Format(0#, FDec0Dec)
   
   Let GRILLA.TextMatrix(0, Col_Marca) = "Marca":                             Let GRILLA.ColWidth(Col_Marca) = 2000:                Let GRILLA.TextMatrix(1, Col_Marca) = ""
   Let GRILLA.TextMatrix(0, Col_Nominal_Venta) = "Nominal Venta":             Let GRILLA.ColWidth(Col_Nominal_Venta) = 2000:        Let GRILLA.TextMatrix(1, Col_Nominal_Venta) = Format(0#, FDec0Dec)
   Let GRILLA.TextMatrix(0, Col_vPresente_Venta2) = "Valor Tasa Val.Selec.":  Let GRILLA.ColWidth(Col_vPresente_Venta2) = 2000:     Let GRILLA.TextMatrix(1, Col_vPresente_Venta2) = Format(0#, FDec0Dec)
   Let GRILLA.TextMatrix(0, Col_vInicial_Venta2) = "Valor Inicial Selecc.":   Let GRILLA.ColWidth(Col_vInicial_Venta2) = 2000:      Let GRILLA.TextMatrix(1, Col_vInicial_Venta2) = Format(0#, FDec0Dec)
   
   Let GRILLA.ColWidth(Col_Marca) = 0
   Let GRILLA.ColWidth(Col_Nominal_Venta) = 0
   Let GRILLA.ColWidth(Col_vPresente_Venta2) = 0
   Let GRILLA.ColWidth(Col_vInicial_Venta2) = 0
   
End Sub

Private Sub Sub_Leer_Detalle_Fli()
   
   Dim DATOS()
   Dim nFilas As Integer
   
   Let Valor_Nominal_Compra = 0#
   Let Valor_Valor_Presente = 0#
   Let Valor_BloqueoPacto = 0#
   Let Valor_vPresente_Venta = 0#
   Let Valor_vInicial_Venta = 0#
   
   Envia = Array()
   AddParam Envia, gsBac_User
   AddParam Envia, BACFLI.MihWnd
   AddParam Envia, LblPapel.Caption
   AddParam Envia, BACFLI.sCarteraNormCod
   AddParam Envia, BACFLI.dRutEmisor
   
   If Not Bac_Sql_Execute("SP_DETALLE_FLI", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
      Exit Sub
   End If
   
   Let GRILLA.Rows = 1
   Let GRILLA.Redraw = False
   Let nFilas = 1
   
   Do While Bac_SQL_Fetch(DATOS())

      Let GRILLA.Rows = GRILLA.Rows + 1
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_NomEmisor) = DATOS(1)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_NumDocumento) = DATOS(4)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_NumCorrelativo) = Format(DATOS(5), FDec0Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nominal_Compra) = Format(DATOS(6), FDec4Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nominal_Venta1) = Format(DATOS(7), FDec4Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Tasa_Venta) = Format(DATOS(8), FDec4Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_vPresente_Venta) = Format(DATOS(9), FDec0Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_vInicial_Venta) = Format(DATOS(10), FDec0Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_BloqueoPacto) = Format(DATOS(11), FDec0Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Marca) = Format(DATOS(12), FDec0Dec)
      'Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nominal_Venta) = Format(DATOS(13), FDec0Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nominal_Venta) = Format(DATOS(7), FDec0Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_vPresente_Venta2) = Format(DATOS(9), FDec0Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_vInicial_Venta2) = Format(DATOS(10), FDec0Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_TCmp) = Format(DATOS(13), FDec4Dec)
      
      
      LblMargen.Caption = DATOS(2)
      LblHaircut.Caption = DATOS(3)
      
      Let GRILLA.Row = nFilas
      Let GRILLA.Col = Col_Nominal_Venta1
      Let GRILLA.CellBackColor = vbWhite
      Let GRILLA.CellForeColor = vbBlue

      Let Valor_Nominal_Compra = Valor_Nominal_Compra + CDbl(GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nominal_Compra))
      Let Valor_Valor_Presente = Valor_Valor_Presente + CDbl(GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nominal_Venta1))
      Let Valor_BloqueoPacto = Valor_BloqueoPacto + CDbl(GRILLA.TextMatrix(GRILLA.Rows - 1, Col_BloqueoPacto))
      Let Valor_vPresente_Venta = Valor_vPresente_Venta + CDbl(GRILLA.TextMatrix(GRILLA.Rows - 1, Col_vPresente_Venta))
      Let Valor_vInicial_Venta = Valor_vInicial_Venta + CDbl(GRILLA.TextMatrix(GRILLA.Rows - 1, Col_vInicial_Venta))


      Let nFilas = nFilas + 1
   Loop
   
   Let GRILLA.Rows = GRILLA.Rows + 1
   Let GRILLA.Row = GRILLA.Rows - 1
   Let GRILLA.TextMatrix(GRILLA.Rows - 1, 0) = "TOTALES"

   
   For icol = 0 To GRILLA.cols - 1
      Let GRILLA.Col = icol
      Let GRILLA.CellBackColor = vbBlue
      Let GRILLA.CellForeColor = vbWhite
   Next

   Let GRILLA.Redraw = True

   ''Se suman los Totales
   GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nominal_Compra) = Format(Valor_Nominal_Compra, FDec4Dec)
   GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nominal_Venta1) = Format(Valor_Valor_Presente, FDec4Dec)
   GRILLA.TextMatrix(GRILLA.Rows - 1, Col_BloqueoPacto) = Format(Valor_BloqueoPacto, FDec0Dec)
   GRILLA.TextMatrix(GRILLA.Rows - 1, Col_vPresente_Venta) = Format(Valor_vPresente_Venta, FDec0Dec)
   GRILLA.TextMatrix(GRILLA.Rows - 1, Col_vInicial_Venta) = Format(Valor_vInicial_Venta, FDec0Dec)

   
   Let MousePointer = vbDefault

End Sub

Private Sub Form_Unload(Cancel As Integer)
         If bAceptar = False Then
            If MsgBox("Esta seguro de Salir de la Ventana, perdera la información ingresada", vbQuestion + vbYesNo, gsBac_Version) = vbNo Then
               Cancel = 1
               Exit Sub
            Else
               Unload Me
            End If
         End If
         
End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)

    Dim DATOS()
    
    Let dNominalSel = 0
    
    If sMarca <> "P" Or (GRILLA.ColSel <> Col_Nominal_Venta1 Or (GRILLA.ColSel = Col_Nominal_Venta1 And GRILLA.RowSel = GRILLA.Rows - 1)) Then
        Exit Sub
    End If
    
    Let MousePointer = vbHourglass
    
    Let nColumna = GRILLA.ColSel

    If KeyCode = vbKeyReturn Then
  
            Call PROC_POSI_TEXTO(GRILLA, TxtIngreso)

            TxtIngreso.Text = CDbl(GRILLA.TextMatrix(GRILLA.RowSel, GRILLA.ColSel))
            TxtIngreso.SelLength = Len(TxtIngreso.Text)

            Let TxtIngreso.Visible = True
            Let TxtIngreso.Text = GRILLA.TextMatrix(GRILLA.RowSel, GRILLA.ColSel)
            Let GRILLA.Enabled = False
'            Let Toolbar1.Enabled = False
            Call TxtIngreso.SetFocus
   
    End If
    
    Let GRILLA.Col = nColumna
    Let Me.MousePointer = vbDefault
    
End Sub



Private Sub TxtIngreso_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim cFormato         As Variant
   Dim nFilas           As Integer
   Dim dDiferencia      As Double
   Dim A As Integer
   
   Let dDiferencia = 0#
   
   If KeyCode = vbKeyEscape Then
      Let GRILLA.Enabled = True
      Let Toolbar1.Enabled = True
      Let TxtIngreso.Visible = False
      Call GRILLA.SetFocus
   End If

   If KeyCode = vbKeyReturn Then
      
      ''Se valida que el Nominal seleccionado no sea mayor que el Nominal disponible.
      If CDbl(TxtIngreso.Text) > CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_Compra)) Then
         MsgBox "El Nominal Seleccionado No puede ser Mayor que el Nominal Disponible", vbInformation, App.Title
         Exit Sub
      End If
            
      Let cFormato = IIf(TxtIngreso.CantidadDecimales = 0, FDec0Dec, FDec4Dec)
      
      Let GRILLA.Enabled = True
      
      Let Toolbar1.Enabled = True
      
      Let GRILLA.TextMatrix(GRILLA.RowSel, GRILLA.ColSel) = Format(TxtIngreso.Text, cFormato)
      
      Let TxtIngreso.Visible = False
      
      Call GRILLA.SetFocus
      
      For I = 1 To GRILLA.Rows - 2
      
         If GRILLA.TextMatrix(I, Col_Marca) = "S" Then
            GRILLA.TextMatrix(GRILLA.RowSel, Col_vPresente_Venta) = Format(CDec(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_Venta1) * GRILLA.TextMatrix(I, Col_vPresente_Venta2) / GRILLA.TextMatrix(I, Col_Nominal_Venta)), FDec0Dec)
            GRILLA.TextMatrix(GRILLA.RowSel, Col_vInicial_Venta) = Format(CDec(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_Venta1) * GRILLA.TextMatrix(I, Col_vInicial_Venta2) / GRILLA.TextMatrix(I, Col_Nominal_Venta)), FDec0Dec)
            Call SumTotales
            
            'Cuando el Total Nominal Seleccionado sea igual al Nominal a Vender
            If CDbl(Valor_Valor_Presente) = CDbl(LblNominalVender.Caption) Then
              For A = 1 To GRILLA.Rows - 2
                  If GRILLA.TextMatrix(A, Col_Nominal_Venta1) <> 0 Then
                       Let dDiferencia = (BACFLI.GRILLA.TextMatrix(BACFLI.GRILLA.RowSel, 6) - Valor_vPresente_Venta)
                       GRILLA.TextMatrix(A, Col_vPresente_Venta) = Format(CDbl(GRILLA.TextMatrix(A, Col_vPresente_Venta)) + dDiferencia, FDec0Dec)
                       GRILLA.TextMatrix(A, Col_vInicial_Venta) = Format(CDbl(GRILLA.TextMatrix(A, Col_vInicial_Venta)) + dDiferencia, FDec0Dec)
                       Call SumTotales
                       Exit Sub
                  End If
              Next
            End If

            Exit Sub
         End If
        
        nFilas = nFilas + 1
        
      Next
   End If
End Sub

Private Sub SumTotales()

      Let Valor_Valor_Presente = 0#
      Let Valor_BloqueoPacto = 0#
      Let Valor_vPresente_Venta = 0#
      Let Valor_vInicial_Venta = 0#

      'Sumatoria de las columnas para obtención del Total
      For I = 1 To GRILLA.Rows - 2
        Let Valor_Valor_Presente = Valor_Valor_Presente + CDbl(GRILLA.TextMatrix(I, Col_Nominal_Venta1))
        Let Valor_BloqueoPacto = Valor_BloqueoPacto + CDbl(GRILLA.TextMatrix(I, Col_BloqueoPacto))
        Let Valor_vPresente_Venta = Valor_vPresente_Venta + CDbl(GRILLA.TextMatrix(I, Col_vPresente_Venta))
        Let Valor_vInicial_Venta = Valor_vInicial_Venta + CDbl(GRILLA.TextMatrix(I, Col_vInicial_Venta))
        nFilas = nFilas + 1
      Next
      
      ''Se asignan los Totales
      GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nominal_Venta1) = Format(Valor_Valor_Presente, FDec4Dec)
      GRILLA.TextMatrix(GRILLA.Rows - 1, Col_BloqueoPacto) = Format(Valor_BloqueoPacto, FDec0Dec)
      GRILLA.TextMatrix(GRILLA.Rows - 1, Col_vPresente_Venta) = Format(Valor_vPresente_Venta, FDec0Dec)
      GRILLA.TextMatrix(GRILLA.Rows - 1, Col_vInicial_Venta) = Format(Valor_vInicial_Venta, FDec0Dec)
      
      LblNominalSel.Caption = Format(Valor_Valor_Presente, FDec4Dec)
      
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
         Case 1
               Call Grabar
               Unload Me
         Case 2
               Unload Me
   
   End Select
End Sub

Private Sub Grabar()
         
         Dim nContador As Double

         If CDbl(LblNominalSel.Caption) > CDbl(BACFLI.GRILLA.TextMatrix(BACFLI.GRILLA.RowSel, 3)) Then
            MsgBox "Nominal Seleccionado es Mayor al Indicado en Pantalla de Origen", vbInformation, App.Title
            Exit Sub
         End If
         
         If CDbl(LblNominalSel.Caption) < CDbl(BACFLI.GRILLA.TextMatrix(BACFLI.GRILLA.RowSel, 3)) Then
            MsgBox "Nominal Seleccionado es Menor al indicado en Pantalla de Origen", vbInformation, App.Title
            Exit Sub
         End If

         If Not BacBeginTransaction Then
            Call MsgBox("Se ha producido un error en la grabación de detalles FLI.", vbExclamation, App.Title)
            Exit Sub
         End If

         For nContador = 1 To GRILLA.Rows - 2

            Envia = Array()
            AddParam Envia, gsBac_User
            AddParam Envia, BACFLI.MihWnd
            AddParam Envia, LblPapel.Caption
            AddParam Envia, CLng(GRILLA.TextMatrix(nContador, Col_NumDocumento))
            AddParam Envia, CLng(GRILLA.TextMatrix(nContador, Col_NumCorrelativo))
            AddParam Envia, CDbl(GRILLA.TextMatrix(nContador, Col_Nominal_Venta1))   'Nominal Selecc.
            AddParam Envia, CDbl(GRILLA.TextMatrix(nContador, Col_vPresente_Venta))  'Valor Tasa Val. Selec.
            AddParam Envia, CDbl(GRILLA.TextMatrix(nContador, Col_vInicial_Venta))   'Valor Inicial Selec.
            
            
            If Not Bac_Sql_Execute("SP_ACTUALIZA_DETALLE_FLI", Envia) Then
               Let MousePointer = vbDefault
               Call BacRollBackTransaction
               Call MsgBox("Se ha originado un error en la grabación de detalles FLI." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
               Exit Sub
            End If
            BACFLI.bDistribucionManual = True
         Next
         
         If Not BacCommitTransaction Then
              Call MsgBox("Se ha producido un error en la grabación de detalles FLI.", vbExclamation, App.Title)
              Exit Sub
         End If
 
         Let MousePointer = vbDefault
         Call MsgBox("Operación grabada con éxito ", vbInformation, App.Title)
         bAceptar = True
End Sub
