VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{05BDEB52-1755-11D5-9109-000102BF881D}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacVP 
   Caption         =   "Venta definitivas"
   ClientHeight    =   6435
   ClientLeft      =   1110
   ClientTop       =   2175
   ClientWidth     =   10080
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmdvp1.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   NegotiateMenus  =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6435
   ScaleWidth      =   10080
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   21
      Top             =   0
      Width           =   10080
      _ExtentX        =   17780
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "venta"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "restaurar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "filtrar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "seleccionar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "emitir"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "cortar"
            ImageIndex      =   7
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8880
      Top             =   4740
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvp1.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvp1.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvp1.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvp1.frx":0D90
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvp1.frx":10AA
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvp1.frx":13C4
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvp1.frx":16DE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.TextBox Text2 
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   0  'None
      ForeColor       =   &H00800000&
      Height          =   285
      Left            =   1140
      TabIndex        =   20
      Top             =   1800
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.ComboBox Combo1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H00800000&
      Height          =   315
      ItemData        =   "Bacmdvp1.frx":19F8
      Left            =   5100
      List            =   "Bacmdvp1.frx":1A05
      Style           =   2  'Dropdown List
      TabIndex        =   19
      Top             =   1800
      Visible         =   0   'False
      Width           =   1455
   End
   Begin BacControles.txtNumero TEXT1 
      Height          =   255
      Left            =   2160
      TabIndex        =   18
      Top             =   1800
      Visible         =   0   'False
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   450
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
      ForeColor       =   192
      SelStart        =   5
      Text            =   "0.0000"
      Max             =   "99999999999.9999"
      BorderStyle     =   0
   End
   Begin MSFlexGridLib.MSFlexGrid TABLE1 
      Height          =   3135
      Left            =   165
      TabIndex        =   17
      Top             =   1560
      Width           =   9735
      _ExtentX        =   17171
      _ExtentY        =   5530
      _Version        =   393216
      Cols            =   14
      FixedCols       =   2
      BackColor       =   12632256
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      ForeColorSel    =   12632256
      BackColorBkg    =   12632256
      GridLines       =   2
   End
   Begin BacControles.txtNumero Flt_Result 
      Height          =   255
      Left            =   5100
      TabIndex        =   16
      Top             =   1080
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   450
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Text            =   "0"
      CantidadDecimales=   "0"
      Min             =   "-99999999999999.999999"
      Max             =   "99999999999999.999999"
   End
   Begin BacControles.txtNumero TxtTotal 
      Height          =   255
      Left            =   1980
      TabIndex        =   15
      Top             =   1080
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   450
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Text            =   "0"
      CantidadDecimales=   "0"
      Min             =   "-99999999999999.999999"
      Max             =   "99999999999999.999999"
   End
   Begin VB.Frame FrmMontos 
      Height          =   600
      Left            =   150
      TabIndex        =   0
      Top             =   4920
      Width           =   9885
      Begin Threed.SSPanel Panel 
         Height          =   315
         Index           =   3
         Left            =   3525
         TabIndex        =   1
         Top             =   195
         Width           =   1395
         _Version        =   65536
         _ExtentX        =   2461
         _ExtentY        =   556
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
         BorderWidth     =   1
         BevelOuter      =   1
         Autosize        =   3
         Begin BacControles.txtNumero TxtInv 
            Height          =   285
            Left            =   15
            TabIndex        =   12
            Top             =   15
            Width           =   1365
            _ExtentX        =   2408
            _ExtentY        =   503
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0"
            CantidadDecimales=   "0"
            Min             =   "-9999999999999999"
            Max             =   "9999999999999999"
         End
      End
      Begin Threed.SSPanel Panel 
         Height          =   315
         Index           =   9
         Left            =   5955
         TabIndex        =   2
         Top             =   195
         Width           =   1395
         _Version        =   65536
         _ExtentX        =   2461
         _ExtentY        =   556
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
         BorderWidth     =   1
         BevelOuter      =   1
         Autosize        =   3
         Begin BacControles.txtNumero TxtSel 
            Height          =   285
            Left            =   15
            TabIndex        =   13
            Top             =   15
            Width           =   1365
            _ExtentX        =   2408
            _ExtentY        =   503
            Enabled         =   0   'False
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0"
            CantidadDecimales=   "0"
            Min             =   "-9999999999999999"
            Max             =   "9999999999999"
         End
      End
      Begin Threed.SSPanel Panel 
         Height          =   315
         Index           =   11
         Left            =   8295
         TabIndex        =   3
         Top             =   195
         Width           =   1395
         _Version        =   65536
         _ExtentX        =   2461
         _ExtentY        =   556
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
         BorderWidth     =   1
         BevelOuter      =   1
         Autosize        =   3
         Begin BacControles.txtNumero TxtSaldo 
            Height          =   285
            Left            =   15
            TabIndex        =   14
            Top             =   15
            Width           =   1365
            _ExtentX        =   2408
            _ExtentY        =   503
            Enabled         =   0   'False
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0"
            CantidadDecimales=   "0"
            Min             =   "-9999999999999999"
            Max             =   "999999999999999"
         End
      End
      Begin Threed.SSPanel Panel 
         Height          =   315
         Index           =   4
         Left            =   1065
         TabIndex        =   4
         Top             =   195
         Width           =   1395
         _Version        =   65536
         _ExtentX        =   2461
         _ExtentY        =   556
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
         BorderWidth     =   1
         BevelOuter      =   1
         Autosize        =   3
         Begin BacControles.txtNumero TxtCartera 
            Height          =   285
            Left            =   15
            TabIndex        =   11
            Top             =   15
            Width           =   1365
            _ExtentX        =   2408
            _ExtentY        =   503
            Enabled         =   0   'False
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0"
            CantidadDecimales=   "0"
            Max             =   "9999999999999"
         End
      End
      Begin VB.Label Label6 
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   " Cartera"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   220
         TabIndex        =   8
         Top             =   195
         Width           =   795
      End
      Begin VB.Label Label2 
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Inversión"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   2580
         TabIndex        =   7
         Top             =   195
         Width           =   900
      End
      Begin VB.Label Label3 
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   " Selec."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   5050
         TabIndex        =   6
         Top             =   195
         Width           =   855
      End
      Begin VB.Label Label4 
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   " Saldo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   7470
         TabIndex        =   5
         Top             =   195
         Width           =   795
      End
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   "C:\BTRADER\MDBDEUT\BACTRD.MDB"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   210
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   "MDDI"
      Top             =   6105
      Visible         =   0   'False
      Width           =   2910
   End
   Begin VB.Label Label 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Total Operación"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   240
      Left            =   180
      TabIndex        =   10
      Top             =   1095
      Width           =   1695
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Resultado"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   240
      Left            =   3900
      TabIndex        =   9
      Top             =   1080
      Width           =   1080
   End
End
Attribute VB_Name = "BacVP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Tecla As String
Dim FormHandle As Long

'Moneda de Liquidacion
Dim objMonLiq As New clsCodigos

'Indica si estoy en un EnterEdit
Dim iFlagKeyDown As Integer

'Guarda el nominal al hacer el EnterEdit, para no llamar a la rutina
'Leer Cortes si es que no se modificó
Dim bufNominal As Double

'Rut para validar que solo ingrese Registros de la misma Cartera
Dim bufRutCart As Long
Dim objDCartera As New clsDCartera

'Filtro de cartera
Dim sFiltro As String

Dim nRutCartV As String
Dim cDvCartV  As String
Dim cNomCartV As String
Dim Valor As String
Public Fila As Integer
Public FiltroAutomatico As Boolean
Dim z As Integer
Dim Color As String
Dim colorletra As String
Dim columnita As Integer
Dim filita As Integer
Dim bold As String

Dim status_tool As Boolean

Private Sub refresca()

     Dim I As Integer
     Data1.Refresh
    For I = 1 To TABLE1.Rows - 1
          TABLE1.Row = I
          Call Llenar_Grilla
          If Not Data1.Recordset.EOF Then
            Data1.Recordset.MoveNext
          End If
    Next I
        TABLE1.Refresh
End Sub
    
       

Private Function colores()

If Data1.Recordset!tm_venta = "*" Then
  Color = &HC0C0C0
  colorletra = &HC0&
  bold = False
End If
If Data1.Recordset!tm_venta = "V" Then
  Color = &HFF0000
  colorletra = &HFFFFFF
  bold = True
End If
If Data1.Recordset!tm_venta = " " Then
  Color = &HC0C0C0
  colorletra = &H800000
  bold = False
End If

 For z = 2 To TABLE1.Cols - 1
      TABLE1.Col = z
      ' Color = &HFF0000
      TABLE1.CellBackColor = Color
      ' colorletra = &HFFFFFF
      TABLE1.CellForeColor = colorletra
      TABLE1.CellFontBold = bold
  Next z
  TABLE1.Col = 2
  
End Function

Public Function Colocardata1()
Dim I As Integer
  Data1.Recordset.MoveFirst
  For I = 1 To TABLE1.Row - 1
        Data1.Recordset.MoveNext
  Next I
End Function
Private Sub Llenar_Grilla()
If Not Data1.Recordset.EOF Then
    TABLE1.TextMatrix(TABLE1.Row, 0) = Data1.Recordset!tm_venta
    TABLE1.TextMatrix(TABLE1.Row, 1) = Data1.Recordset!TM_INSTSER
    TABLE1.TextMatrix(TABLE1.Row, 2) = Data1.Recordset!TM_NEMMON
    TABLE1.TextMatrix(TABLE1.Row, 3) = Format(Data1.Recordset!tm_nominal, "#,##0.0000")
    TABLE1.TextMatrix(TABLE1.Row, 4) = Format(Data1.Recordset!TM_TIR, "#,##0.0000")
    TABLE1.TextMatrix(TABLE1.Row, 5) = Format(Data1.Recordset!TM_Pvp, "#,##0.0000")
    TABLE1.TextMatrix(TABLE1.Row, 6) = Format(Data1.Recordset!TM_VP, "#,##0.0000")
    TABLE1.TextMatrix(TABLE1.Row, 7) = IIf(IsNull(Data1.Recordset!tm_custodia) = True, " ", Data1.Recordset!tm_custodia)
    TABLE1.TextMatrix(TABLE1.Row, 8) = IIf(IsNull(Data1.Recordset!tm_clave_dcv) = True, " ", Data1.Recordset!tm_clave_dcv)
    TABLE1.TextMatrix(TABLE1.Row, 9) = Format(Data1.Recordset!TM_tircomp, "#,##0.0000")
    TABLE1.TextMatrix(TABLE1.Row, 10) = Format(Data1.Recordset!TM_pvpcomp, "#,##0.0000")
    TABLE1.TextMatrix(TABLE1.Row, 11) = Format(Data1.Recordset!tm_vptirc, "#,##0.0000")
    TABLE1.TextMatrix(TABLE1.Row, 12) = Format(Val(Data1.Recordset!TM_VP) - Val(Data1.Recordset!tm_vptirc), "#,###,###,##0")
'    TABLE1.TextMatrix(TABLE1.Row, 13) = IIf(IsNull(Data1.Recordset!tm_feccomp) = True, " ", Data1.Recordset!tm_feccomp)
    Call colores
    TABLE1.Col = 2
End If
End Sub
Private Sub cmbMonLiq_Change()

End Sub

Private Sub CmdCortes()

   Dim Nominal#

   Fila = TABLE1.RowSel
   If Data1.Recordset.RecordCount = 0 Then
      Exit Sub
   End If

   TABLE1.Row = Fila

   If Not TABLE1.Row = 1 Then
      Call Colocardata1

   Else
      Data1.Recordset.MoveFirst

   End If

   Nominal# = CDbl(TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL))
   bufNominal = Val(Data1.Recordset("tm_nominalo"))

   If Nominal = 0 Then
      Exit Sub
   End If
    
   If VENTA_VerDispon(FormHandle, Data1) = False Then
      Exit Sub

   End If

   Set BacFrmIRF = Me
    
   BacControlWindows 30
   BacIrfCo.Show 1
   BacControlWindows 30

   TABLE1.Row = Fila
    
   If Not TABLE1.Row = 1 Then
      Call Colocardata1

   Else
      Data1.Recordset.MoveFirst

   End If
    
   Data1.Recordset.Edit
   Data1.Recordset!tm_nominal = TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL)
   Data1.Recordset.Update
   
   If Nominal# <> CDbl(TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL)) Then
      If VENTA_Bloquear(FormHandle, Data1) Then
         Data1.Recordset.Edit
         If CDbl(TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL)) < Nominal# Then
            Data1.Recordset!tm_venta = "P"

         Else
            Data1.Recordset!tm_venta = "V"

         End If

         Data1.Recordset.Update

      End If

   Else
      Data1.Recordset.Edit
      Data1.Recordset.Update

   End If
   Call VENTA_Valorizar(2, Data1)
   Call Llenar_Grilla
   Data1.Refresh
   TxtTotal.Text = VENTA_SumarTotal(FormHandle)
   Data1.Refresh
   TABLE1.SetFocus

End Sub


Private Sub CmdEmision()
    BacControlWindows 100
    Data1.Refresh
    If Data1.Recordset.RecordCount = 0 Then
        Exit Sub
    End If
    BacControlWindows 100
    If Not TABLE1.Row = 1 Then
            Call Colocardata1
    Else
            Data1.Recordset.MoveFirst
    End If
    BacControlWindows 100
    If Trim$(Data1.Recordset("tm_instser")) = "" Then
        Beep
        Exit Sub
    End If

    'Guarda datos en variable global
    With BacDatEmi
        .sInstSer = Data1.Recordset("tm_instser")
        .lRutemi = Data1.Recordset("tm_rutemi")
        .iMonemi = Data1.Recordset("tm_monemi")
        .sFecEmi = Data1.Recordset("tm_fecemi")
        .sFecvct = Data1.Recordset("tm_fecven")
        .dTasEmi = Data1.Recordset("tm_tasemi")
        .iBasemi = Data1.Recordset("tm_basemi")
        
        .sFecpcup = Data1.Recordset("tm_fecpcup")
        .dNumoper = Data1.Recordset("tm_numdocu")
        .sTipOper = Data1.Recordset("tm_tipoper")
        .sFecvtop = Data1.Recordset("tm_fecsal")
        .iDiasdis = DateDiff("d", gsBac_Fecp, CDate(Data1.Recordset("tm_fecsal")))
        
    End With
       
    BacIrfDg.Tag = "VP"
    BacIrfDg.Show 1
    
    BacControlWindows 12
    TABLE1.SetFocus

End Sub

Private Sub CmdFiltro()
Dim datos()
Dim nSw%
Dim x As Integer
Dim Envia1 As Variant
On Error GoTo ErrFiltro

        nSw = 0
        BacIrfSl.proTipOper = "VP"
        BacIrfSl.Show vbModal
        Valor = True
        Envia1 = Envia
    
    If giAceptar% = True Then
    
        gsBac_CartRUT = RutCartV
        gsBac_CartDV = DvCartV
        gsBac_CartNOM = NomCartV
        
        nRutCartV = RutCartV
        cDvCartV = DvCartV
        cNomCartV = NomCartV

      '  gSQL = "sp_filtrarcart_vp " & gSQL
           
        Screen.MousePointer = 11
    
        Call VENTA_EliminarBloqueados(Data1, FormHandle)
        Call VENTA_BorrarTx(FormHandle)
    
        Data1.Refresh
        Envia = Envia1
        'If miSQL.SQL_Execute(gSQL) = 0 Then
        If Bac_Sql_Execute("sp_filtrarcart_vp", Envia) Then
           ' sFiltro = gSQL
             TABLE1.Rows = 2
            TABLE1.Redraw = False
             Do While Bac_SQL_Fetch(datos())
                TABLE1.Redraw = False
                If datos(12) > "" Then
                    Call VENTA_Agregar(Data1, datos(), hWnd, "VP")
                    'Data1.Refresh
                    Data1.Recordset.MoveLast
                    Call Llenar_Grilla
                    TABLE1.Rows = TABLE1.Rows + 1
                    TABLE1.Row = TABLE1.Rows - 1
                    nSw = 1
                End If
            Loop
            TABLE1.Redraw = True
             TABLE1.Rows = TABLE1.Rows - 1
            If nSw > 0 Then
                Toolbar1.Buttons(5).Tag = "Ver Sel."
       
                Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1"
                Data1.Refresh
       
                TxtTotal.Text = VENTA_SumarTotal(FormHandle)
                Flt_Result.Text = VENTA_SumarDif(FormHandle)
                TxtCartera.Text = VENTA_SumarCartera(FormHandle, 1, Toolbar1)
                TABLE1.Enabled = True
            Else
                Toolbar1.Buttons(5).Tag = "Ver Sel."
                TABLE1.Col = 1
                Toolbar1.Buttons(5).Enabled = False
                TABLE1.Enabled = False
                TxtInv.Enabled = True
            End If

            If Data1.Recordset.RecordCount > 0 Then
                Toolbar1.Buttons(6).Enabled = True
                Toolbar1.Buttons(5).Enabled = True
                Toolbar1.Buttons(7).Enabled = True
                Toolbar1.Buttons(1).Enabled = True
                Toolbar1.Buttons(2).Enabled = True
                Toolbar1.Buttons(3).Enabled = True
                TxtTotal.Enabled = True
            End If

   
        Else
            TABLE1.Rows = 1
            MsgBox "Servidor SQL no Responde", vbExclamation, gsBac_Version
        End If
    
        Screen.MousePointer = 0
        
    End If
    If TABLE1.Rows <> 1 Then TABLE1.Row = 1: TABLE1.SetFocus
    Exit Sub
ErrFiltro:
    MsgBox "Problemas en filtro de cartera para ventas definitivas: " & Err.Description
    Exit Sub
End Sub

Private Sub CmdRestaura()
   Call Table1_KeyPress(82)

End Sub

Private Sub CmdTipoFiltro()
  
    If Toolbar1.Buttons(5).Tag = "Ver Todos" Then
        Toolbar1.Buttons(5).Tag = "Ver Sel."
        Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1"
        Data1.Refresh
       
            
    Else
        filita = TABLE1.Row
        If Val(TxtTotal.Text) > 0 Then
            Toolbar1.Buttons(5).Tag = "Ver Todos"
            Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
            Data1.Refresh
        End If
    End If
    TABLE1.Rows = 1
    TABLE1.Row = 0
    TABLE1.Redraw = False
    Do While Not Data1.Recordset.EOF
             TABLE1.Rows = TABLE1.Rows + 1
             TABLE1.Row = TABLE1.Rows - 1
             Call Llenar_Grilla
             Data1.Recordset.MoveNext
    Loop
    TABLE1.Redraw = True
    TxtCartera.Text = VENTA_SumarCartera(FormHandle, "1", Toolbar1.Buttons(5).Tag)
    Valor = True
    If filita <= TABLE1.Rows - 1 Then
     TABLE1.Row = filita
    End If
    TABLE1.SetFocus
End Sub


Private Sub CmdVenta()


   Call Table1_KeyPress(86)

End Sub

Private Sub Combo1_GotFocus()
Call PROC_POSI_TEXTO(TABLE1, Combo1)
End Sub

Private Sub Combo1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 27 Then
    Combo1_LostFocus
End If
If KeyCode = 13 Then
      If Not TABLE1.Rows = 1 Then
        Call Colocardata1
      Else
         Data1.Recordset.MoveFirst
      End If
    
        If TABLE1.Col = 7 Then
            Data1.Recordset.Edit
            Select Case Combo1.ListIndex 'UCase$(Left(Combo1.Text, 1)) 'Chr(KeyCode))
            Case 0:
                Data1.Recordset("tm_custodia") = "CLIENTE"
                Data1.Recordset("tm_clave_dcv") = " "
                TABLE1.TextMatrix(TABLE1.Row, 7) = "CLIENTE"
                TABLE1.TextMatrix(TABLE1.Row, 8) = ""
                KeyCode = 13
            Case "1":
               ' If Not IsNull(Data1.Recordset("tm_custodia")) Then
               '     If Trim$(Data1.Recordset("tm_custodia")) <> "DCV" Then
               '         Data1.Recordset("tm_custodia") = "DCV"
               '         Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
               '         Table1.TextMatrix(Table1.Row, 6) = "DCV"
               '         Table1.TextMatrix(Table1.Row, 7) = Data1.Recordset("tm_clave_dcv")
               '         KeyCode = 13
               '     Else
               '         KeyCode = 0
               '     End If
               ' Else
                    Data1.Recordset("tm_custodia") = "DCV"
                    Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
                    TABLE1.TextMatrix(TABLE1.Row, 7) = "DCV"
                    TABLE1.TextMatrix(TABLE1.Row, 8) = Data1.Recordset("tm_clave_dcv")
                        
                    KeyCode = 13
               ' End If
            Case "2":
                Data1.Recordset("tm_custodia") = "PROPIA"
                Data1.Recordset("tm_clave_dcv") = " "
                TABLE1.TextMatrix(TABLE1.Row, 7) = "PROPIA"
                TABLE1.TextMatrix(TABLE1.Row, 8) = ""
                
                KeyCode = 13
            Case Else
                KeyCode = 0
            End Select
            Data1.Recordset.Update
            Combo1.Visible = False
            TABLE1.SetFocus
        End If
End If
End Sub

Private Sub Combo1_LostFocus()

    Combo1.Visible = False
   If Not status_tool Then
     TABLE1.SetFocus
   End If
    

    If TABLE1.Col + 1 < TABLE1.Cols Then
        TABLE1.Col = TABLE1.Col + 1

    End If

End Sub


Private Sub data1_Error(DataErr As Integer, Response As Integer)

    'No Current Record
    If DataErr = 3021 Then
        DataErr = 0
        Response = 0
    End If
    
End Sub

Private Sub Flt_Result_KeyDown(KeyCode As Integer, Shift As Integer)
   KeyCode = 0
End Sub

Private Sub Flt_Result_KeyPress(KeyAscii As Integer)
    KeyAscii% = 0
End Sub


Private Sub Form_Activate()
Dim x As Integer
   
   Me.Tag = "VP"
    
    
   'Refresca Data Control
    Data1.Refresh
  
    iFlagKeyDown = True
    
   'Setear mouse pointer como reloj.-
    Screen.MousePointer = vbHourglass
   
 
   'Recuperar mouse pointer.
    Screen.MousePointer = vbDefault
    
    RutCartV = nRutCartV
    DvCartV = cDvCartV
    NomCartV = cNomCartV
    
        
    Exit Sub

BacErrHnd:
    
    Screen.MousePointer = vbDefault
    On Error GoTo 0
    Exit Sub

End Sub

Private Sub Form_Load()

    Me.Top = 0
    Me.Left = 0
    Me.Width = 11925
    
    Toolbar1.Buttons(6).Enabled = False
    Toolbar1.Buttons(7).Enabled = False
    Toolbar1.Buttons(5).Enabled = False
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(4).Enabled = True
    TxtTotal.Enabled = False

    FormHandle = Me.hWnd
    iFlagKeyDown = True

    Call VENTA_IniciarTx(FormHandle, Data1, "1")
    
    Call objMonLiq.LeerCodigos(22)
    
  ' Configurar las columnas de la grid.-
    TABLE1.TextMatrix(0, 0) = "M"
    TABLE1.TextMatrix(0, 1) = "Serie"
    TABLE1.TextMatrix(0, 2) = "UM"
    TABLE1.TextMatrix(0, 3) = "Nominal"
    TABLE1.TextMatrix(0, 4) = "%Tir"
    TABLE1.TextMatrix(0, 5) = "%Vpar"
    TABLE1.TextMatrix(0, 6) = "Valor Presente"
    TABLE1.TextMatrix(0, 7) = "Custodia"
    TABLE1.TextMatrix(0, 8) = "Clave DCV"
    TABLE1.TextMatrix(0, 9) = "%Tir C."
    TABLE1.TextMatrix(0, 10) = "%Vpar C."
    TABLE1.TextMatrix(0, 11) = "Valor de Compra"
    TABLE1.TextMatrix(0, 12) = "Utilidad"
    TABLE1.TextMatrix(0, 13) = "Fecha Compra"
    TABLE1.ColWidth(0) = 400
    TABLE1.ColWidth(1) = 1500
    TABLE1.ColWidth(2) = 500
    TABLE1.ColWidth(3) = 1800
    TABLE1.ColWidth(4) = 900
    TABLE1.ColWidth(5) = 900
    TABLE1.ColWidth(6) = 1800
    TABLE1.ColWidth(7) = 1200
    TABLE1.ColWidth(8) = 1200
    TABLE1.ColWidth(9) = 900
    TABLE1.ColWidth(10) = 900
    TABLE1.ColWidth(11) = 1800
    TABLE1.ColWidth(12) = 0 '2500
    TABLE1.ColWidth(13) = 1200
'    TABLE1.ColumnCellAttrs(3) = True
'    TABLE1.ColumnCellAttrs(4) = True
'    TABLE1.ColumnCellAttrs(5) = True
'    TABLE1.ColumnCellAttrs(6) = True
'    TABLE1.ColumnCellAttrs(7) = True
'    TABLE1.ColumnCellAttrs(8) = True
'    TABLE1.ColumnCellAttrs(9) = True
'    TABLE1.ColumnCellAttrs(10) = True
'    TABLE1.ColumnCellAttrs(11) = True
'    TABLE1.ColumnCellAttrs(12) = True
'    TABLE1.ColumnCellAttrs(13) = True
'
    Data1.Refresh
    Toolbar1.Buttons(5).Tag = "Ver Sel."
    FiltroAutomatico = False
    Toolbar1.Buttons(5).Enabled = False
    TABLE1.Enabled = False
    TxtInv.Enabled = True
    
End Sub
Private Sub Form_Resize()
On Error GoTo BacErrHnd

Dim lScaleWidth&, lScaleHeight&, lPosIni&
    
    ' Cuando la ventana es minimizada, se ignora la rutina.-
    If Me.WindowState = 1 Then
    
        ' Pinta borde del icono.-
        Dim x!, y!, J%
        
        x = Me.Width
        y = Me.Height
           
        For J% = 1 To 15
            Line (0, 0)-(x, 0), QBColor(Int(Rnd * 15))
            Line (x, 0)-(x, y), QBColor(Int(Rnd * 15))
            Line (x, y)-(0, y), QBColor(Int(Rnd * 15))
            Line (0, y)-(0, 0), QBColor(Int(Rnd * 15))
            DoEvents
        Next
        Exit Sub
           
    End If
     
  ' Escalas de medida de la ventana.-
    lScaleWidth& = Me.ScaleWidth
    lScaleHeight& = Me.ScaleHeight
    
  ' Resize la ventana customizado.-
    If Me.WindowState <> 1 And Me.Width > 400 And Me.Height > 2100 Then
        TABLE1.Width = Me.Width - 300
        TABLE1.Height = Me.Height - 2050
        FrmMontos.Top = Me.Height - 1050
    End If
                
      Exit Sub

BacErrHnd:
    
    On Error GoTo 0
    Resume Next

End Sub

Private Sub Form_Unload(Cancel As Integer)

    'Elimina los registros de la tabla de bloqueados
     Call VENTA_EliminarBloqueados(Data1, FormHandle)
    
    'Eliminar los registros del temporal que tengan hwnd igual
    Call VENTA_BorrarTx(FormHandle)
    
    
    Set objMonLiq = Nothing
    Set objDCartera = Nothing

End Sub

Private Sub SSC_Grabar()
Dim rRs As Recordset
Data1.Refresh
    Set rRs = db.OpenRecordset("SELECT DISTINCT tm_monemi FROM MDVENTA WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )", dbOpenSnapshot)

    If rRs.RecordCount > 0 Then
       If Not IsNull(rRs.Fields("tm_monemi")) Then
          BacIrfGr.proMoneda = IIf(rRs.Fields("tm_monemi") = 13, gsBac_Dolar, "$$")
       End If
    End If
                
    BacIrfGr.proMtoOper = TxtTotal.Text
    BacIrfGr.proHwnd = hWnd
        
    Call BacGrabarTX
    
    BacControlWindows 100
    
    If Not Grabacion_Operacion Then
       Data1.Refresh
    End If
    
End Sub

Private Sub Table1_ColumnChange()
iFlagKeyDown = True
End Sub


Private Sub Table1_EnterEdit()

'    iFlagKeyDown = False
'
'    If TABLE1.ColumnIndex = Ven_NOMINAL Then
'       bufNominal = Val(Data1.Recordset("tm_nominalo"))
'    End If
    
End Sub



Private Sub Table1_ExitEdit()
     iFlagKeyDown = True
End Sub

Private Sub Table1_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)
    
'    If Col = TABLE1.ColumnIndex And Row = TABLE1.RowIndex Then
'        FgColor = BacToolTip.Color_Dest.ForeColor
'        BgColor = BacToolTip.Color_Dest.BackColor
'    Else
'        If Data1.Recordset.RecordCount > 0 Then
'            If TABLE1.ColumnText(Ven_MARCA) = "V" Then
'                FgColor = BacToolTip.Color_VentaNormal.ForeColor
'                BgColor = BacToolTip.Color_VentaNormal.BackColor
'            ElseIf TABLE1.ColumnText(Ven_MARCA) = "P" Then
'                    FgColor = BacToolTip.Color_ParcialED.ForeColor
'                    BgColor = BacToolTip.Color_ParcialED.BackColor
'            ElseIf TABLE1.ColumnText(Ven_MARCA) = "*" Then
'                    FgColor = BacToolTip.Color_Bloqueado.ForeColor
'                    BgColor = BacToolTip.Color_Bloqueado.BackColor
'          ElseIf (Col > 0 And Col < 4) Or Col > 7 Then
'                FgColor = BacToolTip.Color_No_Edit.ForeColor
'                BgColor = BacToolTip.Color_No_Edit.BackColor
'            Else
'                FgColor = BacToolTip.Color_Normal.ForeColor
'                BgColor = BacToolTip.Color_Normal.BackColor
'            End If
'
'        End If
'    End If
'
End Sub

Private Sub SSC_Grabar_Click()

End Sub

Private Sub Table1_DblClick()
 If TABLE1.Col = 7 And (TABLE1.TextMatrix(TABLE1.Row, 0) = "V" Or TABLE1.TextMatrix(TABLE1.Row, 0) = "P") Then
        Combo1.Visible = True
        Combo1.SetFocus
 End If
End Sub

Private Sub Table1_GotFocus()
If Valor = False Then
 Data1.Refresh
End If
Valor = False
End Sub

Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)
columnita = TABLE1.Col
     
 If KeyCode = 13 And KeyCode <> 86 And KeyCode <> 82 And KeyCode <> 118 And KeyCode <> 114 And TABLE1.Col > 2 And TABLE1.Col < 7 Then
            BacControlWindows 100
             TABLE1.Col = columnita
             TEXT1.Top = TABLE1.CellTop + TABLE1.Top + 20
             TEXT1.Left = TABLE1.CellLeft + TABLE1.Left + 20
             TEXT1.Width = TABLE1.CellWidth - 20
           '  Call PROC_POSI_TEXTO(BacVP.TABLE1, TEXT1)
            TEXT1.Visible = True
            If KeyCode > 47 And KeyCode < 58 Then TEXT1.Text = Chr(KeyCode)
            If KeyCode = 13 Then TEXT1.Text = TABLE1.TextMatrix(TABLE1.Row, TABLE1.Col)
            TEXT1.SetFocus
            Exit Sub
 End If
On Error GoTo KeyDownError
    
    'El Flag es false cuando se está editando un campo
    If iFlagKeyDown = False Then
        Exit Sub
    End If
            
    Exit Sub
    
KeyDownError:

    MsgBox error(Err), vbExclamation, "Mensaje"
    Data1.Refresh
    Exit Sub

End Sub


Private Sub Table1_KeyPress(KeyAscii As Integer)

   Dim nPos       As Integer
   Dim mFirst     As Boolean
   Dim reg        As Double
   Dim bloq       As String
   Dim fila_table As Double
   Dim Sql        As String
   Dim datos()

   Call BacToUCase(KeyAscii)

   If TABLE1.Col = 8 And Trim(TABLE1.TextMatrix(TABLE1.Row, 7)) = "DCV" And (Trim(TABLE1.TextMatrix(TABLE1.Row, 0)) = "V" Or Trim(TABLE1.TextMatrix(TABLE1.Row, 0)) = "P") Then
      BacControlWindows 100
      Text2.Text = TABLE1.TextMatrix(TABLE1.Row, TABLE1.Col)
      Text2.Visible = True
      Text2.MaxLength = 9

      If KeyAscii <> 13 Then
         Text2.Text = UCase(Chr(KeyAscii))

      Else
         Text2.Text = TABLE1.TextMatrix(TABLE1.Row, TABLE1.Col)

      End If

      Text2.SetFocus

      BacControlWindows 100

      Exit Sub

   End If

   If KeyAscii <> 86 And KeyAscii <> 82 And TABLE1.Col = 7 And (TABLE1.TextMatrix(TABLE1.Row, 0) = "V" Or TABLE1.TextMatrix(TABLE1.Row, 0) = "P") Then
      If KeyAscii = 80 Or KeyAscii = 112 Then
         Combo1.ListIndex = 2

      ElseIf KeyAscii = 68 Or KeyAscii = 100 Then
         Combo1.ListIndex = 1

      ElseIf KeyAscii = 67 Or KeyAscii = 99 Then
         Combo1.ListIndex = 0

      End If

      Combo1.Visible = True
      Combo1.SetFocus

      Exit Sub

   End If
       
   If KeyAscii <> 86 And KeyAscii <> 82 And KeyAscii <> 118 And KeyAscii <> 114 And TABLE1.Col > 2 And TABLE1.Col < 7 Then
      BacControlWindows 100
      TABLE1.Col = columnita
      TEXT1.Top = TABLE1.CellTop + TABLE1.Top + 20
      TEXT1.Left = TABLE1.CellLeft + TABLE1.Left + 20
      TEXT1.Width = TABLE1.CellWidth - 20

      TEXT1.Visible = True

      If KeyAscii > 47 And KeyAscii < 58 Then
         TEXT1.Text = Chr(KeyAscii)

      End If

      If KeyAscii = 13 Then
         TEXT1.Text = TABLE1.TextMatrix(TABLE1.Row, TABLE1.Col)

      End If

      TEXT1.SetFocus

      Exit Sub

   End If

   filita = TABLE1.Row

   columnita = TABLE1.Col

   fila_table = TABLE1.Row - 1

   If Not TABLE1.Row = 1 Then
      Call Colocardata1

   Else
      Data1.Recordset.MoveFirst

   End If
    
   If UCase$(TABLE1.TextMatrix(TABLE1.Row, TABLE1.Col)) = "CLAVE DCV" Then
      If Trim$(Data1.Recordset("tm_custodia")) <> "DCV" Or (Trim$(Data1.Recordset("tm_venta")) = "" Or Trim$(Data1.Recordset("tm_venta")) = "*") Then
         KeyAscii = 0
         Exit Sub

      End If

   End If

   If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii = Asc(gsBac_PtoDec)

   End If

   If KeyAscii = 27 Then
      iFlagKeyDown = True
      Exit Sub

   End If

   Select Case TABLE1.Col
   Case Ven_NOMINAL:
      If Not iFlagKeyDown Then
         KeyAscii = BacPunto(TABLE1, KeyAscii, 12, 4)

      End If

      If Not IsNumeric(Chr(KeyAscii)) And (KeyAscii <> 44 And KeyAscii <> 46 And KeyAscii <> 8 And KeyAscii <> 82 And KeyAscii <> 86) Then
         KeyAscii = 0

      End If

   Case Ven_TIR, Ven_VPAR
      If Not iFlagKeyDown Then
         KeyAscii = BacPunto(TABLE1, KeyAscii, 3, 4)

      End If

      If Not IsNumeric(Chr(KeyAscii)) And (KeyAscii <> 44 And KeyAscii <> 46 And KeyAscii <> 8 And KeyAscii <> 82 And KeyAscii <> 86) Then
         KeyAscii = 0

      End If

   End Select

   If KeyAscii = 82 Then   ' Tecla "R" - Restaura
      KeyAscii = 0

      nPos = TABLE1.Row
       
      Call VENTA_VerDispon(FormHandle, Data1)
        
      If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
         If VENTA_DesBloquear(FormHandle, Data1) Then
            Call VENTA_Restaurar(Data1)

            Data1.Recordset.Edit
            Data1.Recordset("tm_venta") = " "
            Data1.Recordset.Update
      
            If Toolbar1.Buttons(5).Tag = "Ver Todos" And Data1.Recordset.RecordCount = 1 Then 'Table1.Rows - 1 = 1 Then
               Toolbar1.Buttons(5).Tag = "Ver Sel."
               Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1"
               Data1.Refresh
               mFirst = True
               nPos = 1

            ElseIf Toolbar1.Buttons(5).Tag = "Ver Todos" And Data1.Recordset.RecordCount > 1 Then
               Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
               Data1.Refresh

               If nPos > Data1.Recordset.RecordCount Then
                  nPos = 1

               End If

            End If
     
         
         End If
      
         If Data1.Recordset("tm_venta") = "*" Then
            If VENTA_VerBloqueo(FormHandle, Data1) Then
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = " "
               Data1.Recordset.Update

            End If

         End If
        
         Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))
        
         TxtTotal.Text = VENTA_SumarTotal(FormHandle)
         Flt_Result.Text = VENTA_SumarDif(FormHandle)

         If Val(Flt_Result.Text) < 0 Then
            Flt_Result.ForeColor = &HFF&
            Flt_Result.Text = Abs(Val(Flt_Result.Text))

         Else
            Flt_Result.ForeColor = &H0&

         End If
        
         Data1.Recordset.MoveLast
         TABLE1.Rows = Data1.Recordset.RecordCount + 1

         Call refresca

         Data1.Refresh
         TABLE1.Refresh

         TABLE1.Row = nPos

         KeyAscii = 0

         Exit Sub

      End If

   End If
    
   If KeyAscii = 86 Then   ' Tecla "V" - Venta
      If VENTA_VerDispon(FormHandle, Data1) Then
         If Data1.Recordset("tm_venta") = " " Or Data1.Recordset("tm_venta") = "*" Then
            If VENTA_Bloquear(FormHandle, Data1) Then
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "V"

               If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
                  Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV

               Else
                  Data1.Recordset("tm_clave_dcv") = ""

               End If

               Data1.Recordset.Update
               TABLE1.TextMatrix(TABLE1.Row, 8) = Data1.Recordset("tm_clave_dcv")

            Else
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "*"
               Data1.Recordset.Update
            
            End If
               
         End If
      
      End If
      
      TxtTotal.Text = VENTA_SumarTotal(FormHandle)
      Flt_Result.Text = VENTA_SumarDif(FormHandle)
      
      If Val(Flt_Result.Text) < 0 Then
         Flt_Result.ForeColor = &HFF&
         Flt_Result.Text = Abs(Val(Flt_Result.Text))

      Else
         Flt_Result.ForeColor = &H0&

      End If
      
      TABLE1.TextMatrix(TABLE1.Row, 0) = Data1.Recordset("tm_venta")
    
      KeyAscii = 0

      Call colores
   
   End If

   If filita <= TABLE1.Rows - 1 Then
      TABLE1.Row = filita

   Else
      TABLE1.Row = TABLE1.Rows - 1

   End If

   TABLE1.Col = columnita
   TABLE1.SetFocus

End Sub

Private Sub Table1_Update(Row As Long, Col As Integer, Value As String)
'On Error GoTo ExitEditError
'
'Dim Columna%
'Dim reg As Double
'
'    MousePointer = 11
'
'    Columna = TABLE1.ColumnIndex
'
'    If Data1.Recordset.RecordCount = 0 Then
'        MousePointer = 0
'        Exit Sub
'    End If
'
'    Data1.Recordset.Edit
'    Data1.Recordset.Update
'
'    'Para que el datos aparezca en la grid
'    BacControlWindows 60
'
'    If Columna = Ven_NOMINAL Then
'        If VENTA_VerDispon(FormHandle, Data1) Then
'            If Val(TABLE1.ColumnText(Ven_NOMINAL)) <> Data1.Recordset("tm_nominalo") Then
'                If Val(TABLE1.ColumnText(Ven_NOMINAL)) > bufNominal Then
'                    MsgBox "Valor nominal ingresado es mayor al monto nominal disponible " & vbCrLf & vbCrLf & " Debido a esto se restaurara  el valor nominal original", vbExclamation, "Mensaje"
'                    Data1.Recordset.Edit
'                    Data1.Recordset("tm_nominal") = Data1.Recordset("tm_nominalo")
'                    Data1.Recordset.Update
'                    BacControlWindows 30
'                    If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
'                        If VENTA_DesBloquear(FormHandle, Data1) Then
'                            Data1.Recordset.Edit
'                            Data1.Recordset("tm_venta") = " "
'                            Data1.Recordset("tm_clave_dcv") = " "
'                            Data1.Recordset.Update
'                        End If
'                    End If
'                    Call VENTA_Restaurar(Data1)
'                    Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))
'                Else
'                    If VPVI_LeerCortes(Data1, FormHandle) Then
'                        If Trim(Data1.Recordset("tm_venta")) = "" And Data1.Recordset("tm_nominal") <> Data1.Recordset("tm_nominalo") Then
'                            If VENTA_Bloquear(FormHandle, Data1) Then
'                                Data1.Recordset.Edit
'                                Data1.Recordset("tm_venta") = "P"
'                                If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
'                                   Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
'                                Else
'                                   Data1.Recordset("tm_clave_dcv") = " "
'                                End If
'                                Data1.Recordset.Update
'                            Else
'                                Data1.Recordset.Edit
'                                Data1.Recordset("tm_venta") = "*"
'                                Data1.Recordset.Update
'                            End If
'                        Else
'                            If Data1.Recordset("tm_venta") = "V" Then
'                                Data1.Recordset.Edit
'                                Data1.Recordset("tm_venta") = "P"
'                                If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
'                                   Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
'                                Else
'                                   Data1.Recordset("tm_clave_dcv") = " "
'                                End If
'                                Data1.Recordset.Update
'                            End If
'                        End If
'                    Else
'                        If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
'                            If VENTA_DesBloquear(FormHandle, Data1) Then
'                                Data1.Recordset.Edit
'                                Data1.Recordset("tm_venta") = " "
'                                Data1.Recordset("tm_custodia") = " "
'                                Data1.Recordset.Update
'                            End If
'                        End If
'                        Call VENTA_Restaurar(Data1)
'                        Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlativo"))
'                    End If
'                End If
'            Else
'                If Data1.Recordset("tm_venta") = "P" Then
'                    Data1.Recordset.Edit
'                    Data1.Recordset("tm_venta") = "V"
'                    If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
'                        Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
'                    Else
'                        Data1.Recordset("tm_clave_dcv") = ""
'                    End If
'                        Data1.Recordset.Update
'
'                ElseIf Data1.Recordset("tm_venta") = " " Then
'                        If VENTA_Bloquear(FormHandle, Data1) Then
'                            Data1.Recordset.Edit
'                            Data1.Recordset("tm_venta") = "V"
'                            If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
'                               Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
'                            Else
'                               Data1.Recordset("tm_clave_dcv") = ""
'                            End If
'                            Data1.Recordset.Update
'                        Else
'                            Data1.Recordset.Edit
'                            Data1.Recordset("tm_venta") = "*"
'                            Data1.Recordset.Update
'                        End If
'                End If
'            End If
'        End If
'
'        If Val(TABLE1.ColumnText(Ven_TIR)) <> 0 Then
'            Call VENTA_Valorizar(2, Data1)
'        ElseIf Val(TABLE1.ColumnText(Ven_TIR)) <> 0 Then
'                Call VENTA_Valorizar(1, Data1)
'        ElseIf Val(TABLE1.ColumnText(Ven_VPAR)) <> 0 Then
'                Call VENTA_Valorizar(3, Data1)
'        End If
'
'    ElseIf Columna = Ven_TIR Then
'            Call VENTA_Valorizar(2, Data1)
'    ElseIf Columna = Ven_VPAR Then
'            Call VENTA_Valorizar(1, Data1)
'    ElseIf Columna = Ven_VPS Then
'            Call VENTA_Valorizar(3, Data1)
'    End If
'
'    If Columna = Ven_NOMINAL Or Columna = Ven_TIR Or Columna = Ven_VPAR Then
'    '  Verifica si la TIR se encuentra dentro de
'    '  los rangos calculados.
'        Dim Cota_SUP     As Double
'        Dim Cota_INF     As Double
'        Dim Porcentaje   As Double
'
'      ' If ValidaRango(data1.Recordset("tm_serie"), data1.Recordset("tm_fecven"), data1.Recordset("tm_tir"), Cota_SUP#, Cota_INF#, Porcentaje#) = False Then
'      '     If Cota_SUP# <> 0 Or Cota_INF# <> 0 Then
'      '         MsgBox "La TIR ingresada se encuentra fuera del RANGO establecido" & Chr(10) & "-Rango SUPERIOR   : " & Cota_SUP# & Chr(10) & "-Rango INFERIOR     : " & Cota_INF# & Chr(10) & "-Porcentaje Variación : " & Porcentaje#, 64
'      '     End If
'      ' End If
'    End If
'
'    BacControlWindows 12
'
'   'Sumar el total y desplegar.-
'    If Columna > 3 Then
'        TxtTotal.Text = VENTA_SumarTotal(FormHandle)
'        Flt_Result.Text = VENTA_SumarDif(FormHandle)
'        If Val(Flt_Result.Text) < 0 Then
'            Flt_Result.ForeColor = &HFF&
'            Flt_Result.Text = Abs(Val(Flt_Result.Text))
'        Else
'            Flt_Result.ForeColor = &H0&
'        End If
'    End If
'
'    If Columna = Ven_NOMINAL Then
'       SendKeys "{TAB 1}"
'    ElseIf Columna = Ven_TIR Then
'       SendKeys "{TAB 2}"
'    ElseIf Columna = Ven_VPAR Then
'       SendKeys "{TAB 1}"
'    End If
'
'    MousePointer = 0
'    iFlagKeyDown = True
'
'    Exit Sub
'
'ExitEditError:
'
'    MousePointer = 0
'    MsgBox Error(Err), vbExclamation, "Mensaje"
''    Resume
'    Data1.Refresh
'    iFlagKeyDown = True
'    Exit Sub
'
End Sub
'Private Sub Table1_Validate(Row As Long, Col As Integer, Value As String, Cancel As Integer)
'
'    If Data1.Recordset.RecordCount = 0 Then
'        Value = ""
'    End If
'
'    If UCase(TABLE1.ColumnName(Col)) <> "CLAVE DCV" Then
'        If IsNumeric(Value) = False Then
'            Cancel = True
'        End If
'    End If
'
'End Sub


Private Sub Table1_LeaveCell()

    If TABLE1.Row <> 0 And TABLE1.Col > 1 Then
        TABLE1.CellFontBold = True
        If TABLE1.TextMatrix(TABLE1.Row, 0) = "V" Then
            TABLE1.CellBackColor = vbBlue
            TABLE1.CellForeColor = vbWhite
        ElseIf TABLE1.TextMatrix(TABLE1.Row, 0) = "P" Then
            TABLE1.CellBackColor = vbCyan
            TABLE1.CellForeColor = vbBlack
        ElseIf TABLE1.TextMatrix(TABLE1.Row, 0) = "*" Then
            TABLE1.CellBackColor = vbGreen + vbWhite    'vbBlack
            TABLE1.CellForeColor = vbWhite
        Else
            TABLE1.CellBackColor = vbBlack
            TABLE1.CellForeColor = vbBlack
        
        End If
        TABLE1.CellFontBold = False
        
    End If

End Sub

Private Sub Table1_RowColChange()

    TABLE1.CellBackColor = &H808000
    TABLE1.CellForeColor = vbWhite

End Sub


Private Sub Table1_Scroll()
Text1_LostFocus


End Sub

Private Sub Table1_SelChange()

    If TABLE1.Row <> 0 And TABLE1.Col > 1 Then
        TABLE1.CellFontBold = True
        If TABLE1.TextMatrix(TABLE1.Row, 0) = "V" Then
            TABLE1.CellBackColor = vbBlue
            TABLE1.CellForeColor = vbWhite
        ElseIf TABLE1.TextMatrix(TABLE1.Row, 0) = "P" Then
            TABLE1.CellBackColor = vbCyan
            TABLE1.CellForeColor = vbBlack
        ElseIf TABLE1.TextMatrix(TABLE1.Row, 0) = "*" Then
            TABLE1.CellBackColor = vbGreen + vbWhite    'vbBlack
            TABLE1.CellForeColor = vbWhite
        Else
            TABLE1.CellBackColor = vbBlack
            TABLE1.CellForeColor = vbBlack
        
        End If
        TABLE1.CellFontBold = False
        
    End If

End Sub

Private Sub Text1_GotFocus()
'Text1.Text = Table1.TextMatrix(Table1.Row, Table1.Col)
'Text1.SelStart = 0 'Len(TEXT1)
'Text1.SelLength = Len(Text1)

End Sub


Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)
Dim I As Integer
If KeyCode = 27 Then
   TEXT1.Visible = False
   TEXT1.Text = 0
   TABLE1.SetFocus
End If
Dim v As String
Dim colum As Integer
If KeyCode = 13 Then
   colum = TABLE1.Col
    If Not TABLE1.Row = 1 Then
            Call Colocardata1
    Else
            Data1.Recordset.MoveFirst
    End If
  
 ' ENTEREDIT
    iFlagKeyDown = False
   
    If TABLE1.Col = Ven_NOMINAL Then
       bufNominal = Val(Data1.Recordset("tm_nominalo"))
    End If
 'UPDATE
 On Error GoTo ExitEditError

Dim Columna%
Dim reg As Double

    MousePointer = 11
           
    Columna = TABLE1.Col
    
    If Data1.Recordset.RecordCount = 0 Then
        MousePointer = 0
        Exit Sub
    End If

    Data1.Recordset.Edit
    'Data1.Recordset.Update
    
    'Para que el datos aparezca en la grid
    BacControlWindows 60
    TABLE1.TextMatrix(TABLE1.Row, TABLE1.Col) = TEXT1.Text
    If Columna = Ven_NOMINAL Then
        Data1.Recordset!tm_nominal = TEXT1.Text
        Data1.Recordset.Update
        If VENTA_VerDispon(FormHandle, Data1) Then
            If Val(TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL)) <> Data1.Recordset("tm_nominalo") Then
                If Val(TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL)) > bufNominal Then
                    MsgBox "Valor nominal ingresado es mayor al monto nominal disponible " & vbCrLf & vbCrLf & " Debido a esto se restaurara  el valor nominal original", vbExclamation, "Mensaje"
                    Data1.Recordset.Edit
                    Data1.Recordset("tm_nominal") = Data1.Recordset("tm_nominalo")
                    Data1.Recordset.Update
                    BacControlWindows 30
                    If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
                        If VENTA_DesBloquear(FormHandle, Data1) Then
                            Data1.Recordset.Edit
                            Data1.Recordset("tm_venta") = " "
                            Data1.Recordset("tm_clave_dcv") = " "
                            Data1.Recordset.Update
                        End If
                    End If
                    Call VENTA_Restaurar(Data1)
                    Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))
                Else
                    If VPVI_LeerCortes(Data1, FormHandle) Then
                        If Trim(Data1.Recordset("tm_venta")) = "" And Data1.Recordset("tm_nominal") <> Data1.Recordset("tm_nominalo") Then
                            If VENTA_Bloquear(FormHandle, Data1) Then
                                Data1.Recordset.Edit
                                Data1.Recordset("tm_venta") = "P"
                                If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
                                   Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
                                Else
                                   Data1.Recordset("tm_clave_dcv") = " "
                                End If
                                Data1.Recordset.Update
                            Else
                                Data1.Recordset.Edit
                                Data1.Recordset("tm_venta") = "*"
                                Data1.Recordset.Update
                            End If
                        Else
                            If Data1.Recordset("tm_venta") = "V" Then
                                Data1.Recordset.Edit
                                Data1.Recordset("tm_venta") = "P"
                                If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
                                   Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
                                Else
                                   Data1.Recordset("tm_clave_dcv") = " "
                                End If
                                Data1.Recordset.Update
                            End If
                        End If
                    Else
                        If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
                            If VENTA_DesBloquear(FormHandle, Data1) Then
                                Data1.Recordset.Edit
                                Data1.Recordset("tm_venta") = " "
                                Data1.Recordset("tm_custodia") = " "
                                Data1.Recordset.Update
                            End If
                        End If
                        Call VENTA_Restaurar(Data1)
                        If Trim(Data1.Recordset("tm_venta")) <> "" Then
                            Call VENTA_DesBloquear(FormHandle, Data1)
                            Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlativo"))
                        End If
                    End If
                End If
            Else
                If Data1.Recordset("tm_venta") = "P" Then
                    Data1.Recordset.Edit
                    Data1.Recordset("tm_venta") = "V"
                    If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
                        Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
                    Else
                        Data1.Recordset("tm_clave_dcv") = ""
                    End If
                        Data1.Recordset.Update
                        
                ElseIf Data1.Recordset("tm_venta") = " " Then
                        If VENTA_Bloquear(FormHandle, Data1) Then
                            Data1.Recordset.Edit
                            Data1.Recordset("tm_venta") = "V"
                            If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
                               Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
                            Else
                               Data1.Recordset("tm_clave_dcv") = ""
                            End If
                            Data1.Recordset.Update
                        Else
                            Data1.Recordset.Edit
                            Data1.Recordset("tm_venta") = "*"
                            Data1.Recordset.Update
                        End If
                End If
            End If
        End If
                
        If Val(TABLE1.TextMatrix(TABLE1.Row, Ven_TIR)) <> 0 Then
            Call VENTA_Valorizar(2, Data1)
        ElseIf Val(TABLE1.TextMatrix(TABLE1.Row, Ven_TIR)) <> 0 Then
                Call VENTA_Valorizar(1, Data1)
        ElseIf Val(TABLE1.TextMatrix(TABLE1.Row, Ven_VPAR)) <> 0 Then
                Call VENTA_Valorizar(3, Data1)
        End If
        
    ElseIf Columna = Ven_TIR Then
            Data1.Recordset!TM_TIR = TEXT1.Text
            Data1.Recordset.Update
            Call VENTA_Valorizar(2, Data1)
    ElseIf Columna = Ven_VPAR Then
            Data1.Recordset!TM_Pvp = TEXT1.Text
            Data1.Recordset.Update
            Call VENTA_Valorizar(1, Data1)
    ElseIf Columna = Ven_VPS Then
            Data1.Recordset!TM_VP = TEXT1.Text
            Data1.Recordset.Update
            Call VENTA_Valorizar(3, Data1)
    End If
    
    If Columna = Ven_NOMINAL Or Columna = Ven_TIR Or Columna = Ven_VPAR Then
    '  Verifica si la TIR se encuentra dentro de
    '  los rangos calculados.
        Dim Cota_SUP     As Double
        Dim Cota_INF     As Double
        Dim Porcentaje   As Double
        
      ' If ValidaRango(data1.Recordset("tm_serie"), data1.Recordset("tm_fecven"), data1.Recordset("tm_tir"), Cota_SUP#, Cota_INF#, Porcentaje#) = False Then
      '     If Cota_SUP# <> 0 Or Cota_INF# <> 0 Then
      '         MsgBox "La TIR ingresada se encuentra fuera del RANGO establecido" & Chr(10) & "-Rango SUPERIOR   : " & Cota_SUP# & Chr(10) & "-Rango INFERIOR     : " & Cota_INF# & Chr(10) & "-Porcentaje Variación : " & Porcentaje#, 64
      '     End If
      ' End If
    End If
    
    BacControlWindows 12

   'Sumar el total y desplegar.-
    If Columna > 2 Then
        TxtTotal.Text = VENTA_SumarTotal(FormHandle)
        Flt_Result.Text = VENTA_SumarDif(FormHandle)
        If Val(Flt_Result.Text) < 0 Then
            Flt_Result.ForeColor = &HFF&
            Flt_Result.Text = Abs(Val(Flt_Result.Text))
        Else
            Flt_Result.ForeColor = &H0&
        End If
    End If
    
    If Columna = Ven_NOMINAL Then
       SendKeys "{TAB 1}"
    ElseIf Columna = Ven_TIR Then
       SendKeys "{TAB 2}"
    ElseIf Columna = Ven_VPAR Then
       SendKeys "{TAB 1}"
    End If
    
    MousePointer = 0
    iFlagKeyDown = True
    Llenar_Grilla
    TEXT1.Text = ""
    TEXT1.Visible = False
    TABLE1.Col = colum
End If

    Exit Sub
    
ExitEditError:

    MousePointer = 0
    MsgBox error(Err), vbExclamation, "Mensaje"
'    Resume
    Data1.Refresh
    iFlagKeyDown = True
    Exit Sub

End Sub

Private Sub Text1_LostFocus()
TEXT1.Text = 0
TEXT1.Visible = False
BacControlWindows 100
If Not status_tool Then
   TABLE1.SetFocus
End If

End Sub

Private Sub Text2_GotFocus()
Call PROC_POSI_TEXTO(TABLE1, Text2)
Text2.SelLength = Len(Text2)
Text2.SelStart = Len(Text2)
End Sub

Private Sub Text2_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 27 Then
    Text2_LostFocus
End If

If KeyCode = 13 Then
  If Not TABLE1.Rows = 1 Then
        Call Colocardata1
  Else
         Data1.Recordset.MoveFirst
  End If
        Data1.Recordset.Edit
        Data1.Recordset!tm_clave_dcv = Text2.Text
        Data1.Recordset.Update
        TABLE1.TextMatrix(TABLE1.Row, 8) = Trim(Text2.Text)
        TABLE1.SetFocus
End If
End Sub

Private Sub Text2_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Text2_LostFocus()
Text2.Text = ""
Text2.Visible = False
If Not status_tool Then
   TABLE1.SetFocus
End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
status_tool = True
Select Case Button.Index
Case 1
   Call SSC_Grabar
Case 2
      Call CmdVenta
Case 3
   Call CmdRestaura
Case 4
   Call CmdFiltro
   Toolbar1.Buttons(5).Enabled = False
Case 5
      Call CmdTipoFiltro
Case 6
    Call CmdEmision
Case 7
   Call CmdCortes
End Select
status_tool = False
End Sub

Private Sub TxtInv_Change()
    If TxtInv.Text > 0 Then
       TxtSaldo.Text = TxtSel.Text - TxtInv.Text
    Else
       TxtSaldo.Text = 0
    End If
End Sub

Private Sub TxtSel_Change()
    If TxtInv.Text > 0 Then
       TxtSaldo.Text = TxtSel.Text - TxtInv.Text
    Else
       TxtSaldo.Text = 0
    End If
End Sub

Private Sub TxtTotal_Change()

    TxtSel.Text = TxtTotal.Text
    
    If Toolbar1.Buttons(5).Tag = "Ver Sel." And Val(TxtTotal.Text) = 0 Then
        Toolbar1.Buttons(5).Enabled = False
    Else
        Toolbar1.Buttons(5).Enabled = True
    End If
    
End Sub

Private Sub TxtTotal_GotFocus()
    TxtTotal.Tag = TxtTotal.Text
End Sub

Private Sub TxtTotal_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
     Tecla = "13"
Else
    Tecla = ""
End If
End Sub

Private Sub TxtTotal_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        SendKeys$ "{TAB}"
    End If
End Sub


Private Sub TxtTotal_LostFocus()
Dim dTotalNuevo#, dTotalActual#
Dim I As Integer
If Not Data1.Recordset.RecordCount = 1 Then
            Call Colocardata1
    Else
            Data1.Recordset.MoveFirst
End If
    If TxtTotal.Tag <> TxtTotal.Text Then
        dTotalActual# = Val(TxtTotal.Tag)
        dTotalNuevo# = Val(TxtTotal.Text)
        If VPVI_ChkTipoCambio(FormHandle&) = False Then
            MsgBox "DEBE INGRESAR EL TIPO DE CAMBIO PARA TODOS LOS INSTRUMENTOS", vbExclamation, "Mensaje"
        Else
            Call VENTA_ValorizarTotal(Data1, dTotalNuevo#, dTotalActual#)
             Data1.Refresh
             For I = 1 To TABLE1.Rows - 1
              TABLE1.Row = I
              Call Llenar_Grilla
              If Not Data1.Recordset.EOF Then
                Data1.Recordset.MoveNext
              End If
            Next I
            TABLE1.Refresh
        End If
    End If
    
    Flt_Result.Text = VENTA_SumarDif(FormHandle)
        
    If Val(Flt_Result.Text) < 0 Then
        Flt_Result.ForeColor = &HFF&
        Flt_Result.Text = Abs(Val(Flt_Result.Text))
    Else
        Flt_Result.ForeColor = &H0&
    End If
    Screen.MousePointer = 0
  If Tecla = "13" Then
      TxtTotal.SetFocus
  Else
   '   TABLE1.SetFocus
  End If
    
     
  
End Sub


