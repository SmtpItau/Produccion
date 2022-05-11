VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form BacCP 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Compras Propias"
   ClientHeight    =   6075
   ClientLeft      =   450
   ClientTop       =   2055
   ClientWidth     =   11415
   DrawWidth       =   2
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
   Icon            =   "Bacmdcp.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   NegotiateMenus  =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6075
   ScaleWidth      =   11415
   Visible         =   0   'False
   Begin VB.CommandButton Cmb_cargar 
      Caption         =   "Cargar"
      Height          =   315
      Left            =   3420
      TabIndex        =   9
      Top             =   7350
      Width           =   630
   End
   Begin MSFlexGridLib.MSFlexGrid Errores 
      Height          =   510
      Left            =   1095
      TabIndex        =   8
      Top             =   7200
      Width           =   960
      _ExtentX        =   1693
      _ExtentY        =   900
      _Version        =   393216
      Rows            =   5
      Cols            =   8
      FixedCols       =   0
      AllowUserResizing=   1
   End
   Begin MSFlexGridLib.MSFlexGrid Grupo 
      Height          =   510
      Left            =   150
      TabIndex        =   7
      Top             =   7185
      Width           =   960
      _ExtentX        =   1693
      _ExtentY        =   900
      _Version        =   393216
      Rows            =   5
      Cols            =   8
      FixedCols       =   0
      AllowUserResizing=   1
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   495
      Left            =   2055
      TabIndex        =   6
      Top             =   7200
      Width           =   1320
      _ExtentX        =   2328
      _ExtentY        =   873
      _Version        =   393216
      Rows            =   5
      Cols            =   8
      FixedCols       =   0
      HighLight       =   2
      AllowUserResizing=   1
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   "C:\BTRADER\Mdb\BACTRD.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   7380
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   "MDCP"
      Top             =   6810
      Width           =   3885
   End
   Begin VB.TextBox Text1 
      BackColor       =   &H00800000&
      BorderStyle     =   0  'None
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   150
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   2385
      Visible         =   0   'False
      Width           =   980
   End
   Begin VB.ComboBox cboCarteraSuper 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00800000&
      Height          =   315
      ItemData        =   "Bacmdcp.frx":030A
      Left            =   9315
      List            =   "Bacmdcp.frx":030C
      Sorted          =   -1  'True
      Style           =   2  'Dropdown List
      TabIndex        =   5
      Top             =   7185
      Visible         =   0   'False
      Width           =   1815
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   -15
      TabIndex        =   0
      Top             =   -15
      Width           =   11295
      _ExtentX        =   19923
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   8
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdEmision"
            Description     =   "Emision"
            Object.ToolTipText     =   "Datos de Emisión"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdCortes"
            Description     =   "Cortes"
            Object.ToolTipText     =   "Cortes"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar Pantalla"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Abrir"
            Object.ToolTipText     =   "Importar desde Archivo"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdCarga"
            Description     =   "Carga Tickers"
            Object.ToolTipText     =   "CARGA TICKERS"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   7
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog Commond 
         Left            =   4920
         Top             =   0
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
   End
   Begin BACControles.TXTNumero TEXT2 
      Height          =   315
      Left            =   135
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   2835
      Visible         =   0   'False
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   556
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
      BorderStyle     =   0
      Text            =   "0"
      Text            =   "0"
      Min             =   "-99"
      Max             =   "999999999999,9999"
      Separator       =   -1  'True
   End
   Begin VB.ComboBox Combo1 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00800000&
      Height          =   315
      ItemData        =   "Bacmdcp.frx":030E
      Left            =   7410
      List            =   "Bacmdcp.frx":031B
      Sorted          =   -1  'True
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Top             =   7185
      Visible         =   0   'False
      Width           =   1815
   End
   Begin MSFlexGridLib.MSFlexGrid Table1 
      Height          =   4020
      Left            =   45
      TabIndex        =   1
      Top             =   1650
      Width           =   11310
      _ExtentX        =   19950
      _ExtentY        =   7091
      _Version        =   393216
      Cols            =   16
      FixedCols       =   0
      RowHeightMin    =   315
      BackColor       =   -2147483633
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   8388608
      ForeColorSel    =   -2147483643
      BackColorBkg    =   12632256
      GridColor       =   4210816
      GridColorFixed  =   -2147483635
      ScrollTrack     =   -1  'True
      Enabled         =   0   'False
      FocusRect       =   0
      AllowUserResizing=   1
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
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8715
      Top             =   -30
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdcp.frx":0335
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdcp.frx":0787
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdcp.frx":0AA1
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdcp.frx":0DBB
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdcp.frx":10D5
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdcp.frx":1FB1
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdcp.frx":2E8D
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdcp.frx":31A7
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Height          =   1125
      Left            =   45
      TabIndex        =   10
      Top             =   480
      Width           =   11280
      Begin VB.CheckBox Chk_Dif_CLP 
         Height          =   195
         Left            =   10350
         TabIndex        =   23
         Top             =   705
         Width           =   225
      End
      Begin VB.ComboBox TipoPago 
         Height          =   315
         ItemData        =   "Bacmdcp.frx":4081
         Left            =   1350
         List            =   "Bacmdcp.frx":4083
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   570
         Width           =   3075
      End
      Begin VB.ComboBox CmbLibro 
         Height          =   315
         Left            =   1350
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   210
         Width           =   3060
      End
      Begin BACControles.TXTNumero TxtTotal 
         Height          =   315
         Left            =   6840
         TabIndex        =   13
         Top             =   570
         Width           =   2205
         _ExtentX        =   3889
         _ExtentY        =   556
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
         Text            =   "0,00"
         Text            =   "0,00"
         Max             =   "99999999999999.99999999999"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTFecha FechaPago 
         Height          =   315
         Left            =   7665
         TabIndex        =   17
         Top             =   210
         Width           =   1395
         _ExtentX        =   2461
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   2
         Text            =   "01/01/1900"
      End
      Begin VB.Frame Cuadrodvp 
         Caption         =   "DVP"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   795
         Left            =   4500
         TabIndex        =   19
         Top             =   120
         Visible         =   0   'False
         Width           =   1455
         Begin VB.OptionButton OptDvp 
            Caption         =   "&No"
            BeginProperty Font 
               Name            =   "Verdana"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   0
            Left            =   105
            TabIndex        =   21
            TabStop         =   0   'False
            Top             =   330
            Width           =   600
         End
         Begin VB.OptionButton OptDvp 
            Caption         =   "&Si"
            BeginProperty Font 
               Name            =   "Verdana"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   1
            Left            =   765
            TabIndex        =   20
            TabStop         =   0   'False
            Top             =   330
            Width           =   555
         End
      End
      Begin VB.Label Label1 
         Caption         =   "Resultado Trans. CLP"
         ForeColor       =   &H00800000&
         Height          =   405
         Left            =   10020
         TabIndex        =   22
         Top             =   195
         Width           =   1200
      End
      Begin VB.Label Etiquetas 
         Caption         =   "Fecha de Pago"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   14
         Left            =   4875
         TabIndex        =   18
         Top             =   255
         Width           =   1485
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Modo de Pago"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   2
         Left            =   60
         TabIndex        =   16
         Top             =   600
         Width           =   1290
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Total Operación"
         ForeColor       =   &H00800000&
         Height          =   240
         Left            =   4875
         TabIndex        =   14
         Top             =   600
         Width           =   1695
      End
      Begin VB.Label lbllibro 
         Caption         =   "Libro"
         ForeColor       =   &H00800000&
         Height          =   165
         Left            =   60
         TabIndex        =   12
         Top             =   255
         Width           =   570
      End
   End
End
Attribute VB_Name = "BacCP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim SwLimpia            As Boolean


Public bFlagDpx         As Boolean      'Permite solo el ingreso de los dpx
Public bajoOk           As Boolean
Public glBacCpDvpCp     As DvpCp
Public oTipoPago        As Integer

Dim SwEmision           As Boolean
Dim FormHandle          As Long
Dim tblTabla            As Recordset
Dim objMonLiq           As New ClsCodigos
Dim bufNominal          As Double

Dim REGISTRO            As Integer
Dim Tecla               As String
Dim Monto               As Double
Dim Antes               As Double
Dim bCancelar           As Boolean
Dim nContador           As Integer
Dim iFlagKeyDown
        
Const Tip_Oper = "CP"
Const nCol_EMISOR = 14
Const cSuma = 0
Const cInstrumento = 1
Const cCantidad = 2
Const cTir = 3
Const cPrecio = 4
Const cMonto = 5
Const cCustodia = 6
Const cClave = 7
Const cCartera = 8
Dim SW As Integer
Dim clave As String
Dim salida As BacValorizaOutput
Dim tickeraux As Integer
Dim cuentticker As Integer
Dim fl, Posicion As Integer
Dim tipopapel As String
Public Fila, Columna As Integer
Public Existe As String
Dim sFiltro   As String
Public Color As Long
Public aGrabar As String
Public cCodLibro As String
Public cadena, CadenaMnt As String
Public cadena1 As String
Public Filas As Integer

Private Function Func_Leer_Celda(objSheet As Object, sCelda As String) As Variant
   Dim nColumna      As Integer
   Dim nFila         As Integer

   Let nColumna = Asc(Mid$(UCase(sCelda), 1, 1)) - 64
   Let nFila = Val(Trim(Mid$(sCelda, 2, 5)))
   
   Let Func_Leer_Celda = objSheet.Cells(nFila, nColumna)
End Function

Private Function Colocardata1()
   Dim iContador  As Integer
   
   Let Monto = CDbl(Table1.TextMatrix(Table1.RowSel, 3))
   Call Data1.Recordset.MoveFirst
   
   For iContador = 1 To Table1.Row - 1
      Call Data1.Recordset.MoveNext
   Next iContador
End Function

Function Func_Ultima_Fila(nRow As Integer) As Integer
   Dim iContador  As Integer

   For iContador = 1 To Table1.Rows - 1
      If Trim(Table1.TextMatrix(iContador, 0)) = "" Then
         Let Func_Ultima_Fila = iContador
         Exit Function
      End If
   Next iContador
    
   If Grupo.Rows - 1 > nRow Then
      Call Table1_KeyDown(45, 0)
      Let Func_Ultima_Fila = Table1.Rows - 1
   End If

End Function

Function FUNC_Valida_Papeles_PM_ICP() As Boolean
Dim nMoneda As Integer

    Let FUNC_Valida_Papeles_PM_ICP = False
    
    
    With Data1.Recordset
    
        .MoveFirst
        nMoneda = .Fields("Tm_Monemi")
    
        Do While Not .EOF
        
            If nMoneda = 800 Or nMoneda = 801 Then
                FUNC_Valida_Papeles_PM_ICP = True
                Exit Do
            End If
            .MoveNext
        Loop
        .MoveFirst
    End With
    
    
    
    
End Function

Private Sub Limpia_grilla()

   Let cboCarteraSuper.ListIndex = IIf(cboCarteraSuper.ListCount > 0, 0, -1)
   
   Let Table1.TextMatrix(Table1.RowSel, nCol_NOMINAL) = "0.0000"
   Let Table1.TextMatrix(Table1.RowSel, nCol_TIR) = "0.0000"
   Let Table1.TextMatrix(Table1.RowSel, nCol_VPAR) = "0.0000"
   Let Table1.TextMatrix(Table1.RowSel, nCol_VPS) = "0.00"
   Let Table1.TextMatrix(Table1.RowSel, nCol_CUST) = Combo1.text
   
   Let Table1.TextMatrix(Table1.RowSel, nCol_TTRAN) = "0.0000"
   Let Table1.TextMatrix(Table1.RowSel, nCol_PTRAN) = "0"
   Let Table1.TextMatrix(Table1.RowSel, nCol_VPTRAN) = "0"
   Let Table1.TextMatrix(Table1.RowSel, nCol_UTIL) = "0"
   Let Table1.TextMatrix(Table1.RowSel, nCol_DifTran_CLP) = "0"
   Let Table1.TextMatrix(Table1.RowSel, nCol_TCSP) = cboCarteraSuper.text
   
   Chk_Dif_CLP.Value = 0 'oculta la columna
   
End Sub

Private Sub Llena_Grilla()
   Dim nContador    As Integer
   Dim nTipoCambio  As Double
   
    Let Table1.TextMatrix(Table1.Row, nCol_UM) = Data1.Recordset!TM_NEMMON
      
    Let Table1.TextMatrix(Table1.Row, nCol_NOMINAL) = Format(Data1.Recordset!tm_nominal, "#,###0.0000")
    Let Table1.TextMatrix(Table1.Row, nCol_VPAR) = Format(Data1.Recordset!TM_Pvp, "#,##0.0000")
     
    If Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" Then
         If Table1.TextMatrix(Table1.Row, nCol_UM) = "CLP" Then
            Let Table1.TextMatrix(Table1.Row, nCol_VPS) = Format(Data1.Recordset!TM_MT, "#,##0.0000")
         Else
            Let Table1.TextMatrix(Table1.Row, nCol_VPS) = Format(Data1.Recordset!TM_MT, "#,##0.0000")
         End If
    Else
      Let Table1.TextMatrix(Table1.Row, nCol_VPS) = Format(Data1.Recordset!TM_MT, "#,###,###,##0" + IIf(Table1.TextMatrix(Table1.Row, nCol_UM) <> "USD", IIf(bFlagDpx, ".0000", ""), ".00"))
    End If
   
    Let Table1.TextMatrix(Table1.Row, nCol_TIR) = Format(Data1.Recordset!TM_TIR, "#,##0.0000")
    
    
    Let Table1.TextMatrix(Table1.Row, nCol_CUST) = IIf(Trim(Table1.TextMatrix(Table1.Row, nCol_CUST)) <> "", Table1.TextMatrix(Table1.Row, nCol_CUST), Trim(IIf(IsNull(Data1.Recordset!tm_custodia) = True, " ", Data1.Recordset!tm_custodia)))
    Let Table1.TextMatrix(Table1.Row, nCol_CDCV) = Trim(IIf(IsNull(Data1.Recordset!tm_clave_dcv) = True, " ", Data1.Recordset!tm_clave_dcv))
    
    Let Table1.TextMatrix(Table1.Row, nCol_TTRAN) = Format(Data1.Recordset!tm_tirmcd, "#,##0.0000")
    Let Table1.TextMatrix(Table1.Row, nCol_PTRAN) = Format(Data1.Recordset!tm_pvpmcd, "#,##0.0000")
    Let Table1.TextMatrix(Table1.Row, nCol_VPTRAN) = Format(Data1.Recordset!tm_mtmcd, "#,###,###,##0" + IIf(Table1.TextMatrix(Table1.Row, nCol_UM) <> "USD", IIf(bFlagDpx, ".0000", ""), ".00"))
        
    'SE REUTILIZA ESTA COLUMNA PARA OBTENER LA DIFERENCIA ENTRE VALORES PRESENTE Y VP TRANSFERENCIA
''''    Let Table1.TextMatrix(Table1.Row, nCol_UTIL) = Format(Val(Data1.Recordset!TM_MT) - Val(Data1.Recordset!tm_mtmcd), "#,###,###,##0")
    Let Table1.TextMatrix(Table1.Row, nCol_UTIL) = Format(Val(Data1.Recordset!TM_VPMO) - Val(Data1.Recordset!tm_VPTRANMO), "#,###,###,##0" + IIf(Table1.TextMatrix(Table1.Row, nCol_UM) <> "CLP", ".0000", ""))
    
    If Table1.TextMatrix(Table1.Row, nCol_UM) <> "CLP" And Data1.Recordset!TM_MT <> Data1.Recordset!TM_VPMO Then
        nTipoCambio = 0
        nTipoCambio = funcBuscaTipcambio(Data1.Recordset!tm_monemi, gsBac_Fecp)
        
        Table1.TextMatrix(Table1.Row, nCol_DifTran_CLP) = Format((Table1.TextMatrix(Table1.Row, nCol_UTIL) * nTipoCambio), "#,###,###,##0")
    Else
        Table1.TextMatrix(Table1.Row, nCol_DifTran_CLP) = Format(Val(Data1.Recordset!TM_MT) - Val(Data1.Recordset!tm_mtmcd), "#,###,###,##0")
    End If
    
    For nContador = 0 To cboCarteraSuper.ListCount - 1
       If Trim(Right(Data1.Recordset!tm_carterasuper, 10)) = Trim(Right(cboCarteraSuper.List(nContador), 10)) Then
          Let cboCarteraSuper.ListIndex = nContador
          Let Table1.TextMatrix(Table1.Row, nCol_TCSP) = cboCarteraSuper.text
          Exit Sub
       End If
    Next nContador
    

    'esto quiere decir que no encontro el codigo
    Let cboCarteraSuper.ListIndex = -1
    

End Sub

Private Sub Limpia_Pantalla()
   Dim iCol As Integer
   Let Table1.Rows = 2
   Table1.CellBackColor = 0
   If Table1.Rows > 2 Then
      Call Table1.RemoveItem(Table1.Row)
      
   Else
      Let Table1.TextMatrix(1, 0) = ""
      Let Table1.TextMatrix(1, 1) = ""
''''      Let Table1.TextMatrix(1, 2) = "0.0000"
''''      Let Table1.TextMatrix(1, 3) = "0.0000"
''''      Let Table1.TextMatrix(1, 4) = "0.0000"
''''      Let Table1.TextMatrix(1, 5) = "0"
''''      Let Table1.TextMatrix(1, 8) = "0.0000"
''''      Let Table1.TextMatrix(1, 9) = "0.0000"
''''      Let Table1.TextMatrix(1, 10) = "0"
''''      Let Table1.TextMatrix(1, 11) = "0"
''''      Let Table1.TextMatrix(1, 12) = cboCarteraSuper.Text
        Call Limpia_grilla
         With Table1
            For iCol = 0 To Table1.cols - 1
                Table1.Col = iCol
                Table1.CellBackColor = 0
               
            Next iCol
    End With
        
   End If
End Sub
Private Sub Genera_Grilla()
    Let Table1.cols = 16

    Let Table1.ColWidth(nCol_SERIE) = 1400
    Let Table1.ColWidth(nCol_UM) = 500
    Let Table1.ColWidth(nCol_NOMINAL) = 2200
    Let Table1.ColWidth(nCol_TIR) = 900
    Let Table1.ColWidth(nCol_VPAR) = 900
    Let Table1.ColWidth(nCol_VPS) = 2200
    Let Table1.ColWidth(nCol_CUST) = 1200
    Let Table1.ColWidth(nCol_CDCV) = 1500
    Let Table1.ColWidth(nCol_TTRAN) = 1000
    Let Table1.ColWidth(nCol_PTRAN) = 1100
    Let Table1.ColWidth(nCol_VPTRAN) = 2000
    Let Table1.ColWidth(nCol_UTIL) = 2000
    Let Table1.ColWidth(nCol_DifTran_CLP) = 0
    Let Table1.ColWidth(nCol_TCSP) = 3000
    Let Table1.ColWidth(nCol_EMISOR) = 1500 'Rq_6012
    Let Table1.ColWidth(15) = 0
    
    Let Table1.TextMatrix(0, nCol_SERIE) = "Serie"
    Let Table1.TextMatrix(0, nCol_UM) = "UM"
    Let Table1.TextMatrix(0, nCol_NOMINAL) = "Nominal"
    Let Table1.TextMatrix(0, nCol_TIR) = "% Tir"
    Let Table1.TextMatrix(0, nCol_VPAR) = "% Var"
    Let Table1.TextMatrix(0, nCol_VPS) = "Valor Presente"
    Let Table1.TextMatrix(0, nCol_CUST) = "Custodia"
    Let Table1.TextMatrix(0, nCol_CDCV) = "Clave DCV"
    Let Table1.TextMatrix(0, nCol_TTRAN) = "T. Trans."
    Let Table1.TextMatrix(0, nCol_PTRAN) = "Prec. Trans"
    Let Table1.TextMatrix(0, nCol_VPTRAN) = "Valor Presente Trans."
    Let Table1.TextMatrix(0, nCol_UTIL) = "Dif Comp-Trans UM"
    Let Table1.TextMatrix(0, nCol_DifTran_CLP) = "Dif Comp-Trans CLP"
    Let Table1.TextMatrix(0, nCol_TCSP) = "Categoría Cartera Súper"
    Let Table1.TextMatrix(0, nCol_EMISOR) = "Emisor" 'Rq_6012
    Let Table1.TextMatrix(0, 15) = "Rut.Emi" 'Rq_6012
    
    
    Let Table1.TextMatrix(1, nCol_NOMINAL) = "0.0000"
    Let Table1.TextMatrix(1, nCol_TIR) = "0.0000"
    Let Table1.TextMatrix(1, nCol_VPAR) = "0.0000"
    Let Table1.TextMatrix(1, nCol_VPS) = "0.00"
    Let Table1.TextMatrix(1, nCol_TTRAN) = "0.0000"
    Let Table1.TextMatrix(1, nCol_PTRAN) = "0.0000"
    Let Table1.TextMatrix(1, nCol_VPTRAN) = "0"
    Let Table1.TextMatrix(1, nCol_UTIL) = "0"
    Let Table1.TextMatrix(1, nCol_DifTran_CLP) = "0"
    Let Table1.TextMatrix(1, nCol_TCSP) = cboCarteraSuper.text
    
   'Table1.FillStyle = flexFillSingle
   'Table1.FocusRect = flexFocusLight
    
End Sub

Private Sub ChkMoneda(Columna%)
   Dim MonLiq           As Integer
   Dim Mt#
   Dim MtMl#
   Dim TcMl#

Exit Sub

   Mt# = Data1.Recordset("tm_mt")
   MtMl# = Data1.Recordset("tm_mtml")
   TcMl# = Data1.Recordset("tm_tcml")

   If MonLiq = giMonLoc Then
      If Data1.Recordset("tm_monemi") = MonLiq Then
         TcMl# = 1
         MtMl# = Mt#
      Else
         If Columna = nCol_VPS Then
            MtMl# = Mt# * TcMl#
         ElseIf Columna = 8 Then
            MtMl# = Mt# * TcMl#
         ElseIf Columna = 9 Then
            Mt# = MtMl# * TcMl#
         Else
            MtMl# = Mt# * TcMl#
         End If
      End If
   Else
      If Data1.Recordset("tm_monemi") = MonLiq Then
         TcMl# = 1
         MtMl# = Mt#
      Else
         If TcMl# = 0 Then
            MtMl# = 0
         Else
            If Columna = 7 Then
               MtMl# = Mt# / TcMl#
            ElseIf Columna = 8 Then
               MtMl# = Mt# / TcMl#

            ElseIf Columna = 9 Then
               Mt# = MtMl# / TcMl#
            Else
               MtMl# = Mt# / TcMl#
            End If
         End If
      End If
   End If

   Call BacControlWindows(30)

   Call Data1.Recordset.Edit
    Let Data1.Recordset("tm_mt") = Mt#
    Let Data1.Recordset("tm_mtml") = MtMl#
    Let Data1.Recordset("tm_tcml") = TcMl#
   Call Data1.Recordset.Update
End Sub

Private Sub Func_Cortes()
   Dim Nominal#

   If IsNull(Table1.TextMatrix(Table1.Row, nCol_NOMINAL)) Then
      Exit Sub
   End If
   
   Let Nominal# = CDbl(Table1.TextMatrix(Table1.Row, nCol_NOMINAL))

   If Nominal# = 0 Then
      Exit Sub
   End If

   If Not Data1.Recordset.RecordCount = 1 Then
      Call Colocardata1
   Else
      Call Data1.Recordset.MoveFirst
   End If

   Set BacFrmIRF = Me
   Call BacControlWindows(100)
   Call BacIrfCo.Show(vbModal)
   Call BacControlWindows(100)

   If Nominal# <> CDbl(Table1.TextMatrix(Table1.Row, nCol_NOMINAL)) Then
   Else
      Call Data1.Recordset.Edit
      Call Data1.Recordset.Update
   End If

   If Table1.Enabled = True Then
      Call Table1.SetFocus
   End If

End Sub

Private Sub Func_Emision()
   Dim nContador1 As Integer
   Dim bufFecVen$
   Dim Fila As Integer
   'If Trim$(Data1.Recordset("tm_instser")) = "FMUTUO" Then
   'ARM - valida asignar emisor al papel seleccionado
    Fila = Table1.RowSel
    If Table1.TextMatrix(Fila, 0) = "FMUTUO" Then
      Exit Sub
   End If
   'ARM - valida asignar emisor al papel seleccionado

   If Mid(Text1.text, 1, 6) = "FMUTUO" Then
'       Call Data1.Recordset.MoveFirst
       If Not Table1.Rows - 1 = 1 Then
           Call Colocardata1
       Else
           Call Data1.Recordset.MoveFirst
       End If
   Else
        If Not Table1.Rows - 1 = 1 Then
           Call Colocardata1
        Else
           Call Data1.Recordset.MoveFirst
        End If
   End If

   If Trim$(Data1.Recordset("tm_instser")) = "" Then
      Exit Sub
   End If

   'Guarda datos en variable global
   Let BacDatEmi.sInstSer = Data1.Recordset("tm_instser")
   Let BacDatEmi.lRutemi = Data1.Recordset("tm_rutemi")
   Let BacDatEmi.lCodemi = Data1.Recordset("tm_codemi")
   Let BacDatEmi.iMonemi = Data1.Recordset("tm_monemi")
   Let BacDatEmi.sFecEmi = Data1.Recordset("tm_fecemi")
   Let BacDatEmi.sFecvct = Data1.Recordset("tm_fecven")
   Let BacDatEmi.dTasEmi = Data1.Recordset("tm_tasemi")
   Let BacDatEmi.iBasemi = Data1.Recordset("tm_basemi")
   Let BacDatEmi.sRefNomi = Data1.Recordset("tm_refnomi")
   Let BacDatEmi.sGeneri = Data1.Recordset("tm_genemi")

   Let bufFecVen = BacDatEmi.sFecvct

   If Tipo_Carga = "MN" Or (Tipo_Carga = "AU" And Mid(Trim(BacDatEmi.sInstSer), 1, 2) = "DP") Then
       Let BacIrfEm.varPsSeriado = Data1.Recordset("tm_mdse")
       Let BacIrfEm.Tag = "CP"
       If Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" Or Mid(Text1.text, 1, 6) = "FMUTUO" Then
           
           Let BacIrfEm.Tag = "CP;FMUTUO"
           'Let BacDatEmi.lRutemi = 0
       End If
       Call BacIrfEm.Show(vbModal)
   End If

   If giAceptar% = True Then
      Call Data1.Recordset.Edit
       Let Data1.Recordset("tm_instser") = BacDatEmi.sInstSer
       Let Data1.Recordset("tm_rutemi") = BacDatEmi.lRutemi
       Let Data1.Recordset("tm_codemi") = BacDatEmi.lCodemi
       Let Data1.Recordset("tm_monemi") = BacDatEmi.iMonemi
       Let Data1.Recordset("tm_nemmon") = BacDatEmi.sNemo
       Let Data1.Recordset("tm_fecemi") = BacDatEmi.sFecEmi
       Let Data1.Recordset("tm_fecven") = BacDatEmi.sFecvct
       Let Data1.Recordset("tm_tasemi") = BacDatEmi.dTasEmi
       Let Data1.Recordset("tm_basemi") = BacDatEmi.iBasemi
       Let Data1.Recordset("tm_genemi") = BacDatEmi.sGeneri
       
 
       'Rq_6012 20101214
       Table1.TextMatrix(Table1.Row, nCol_EMISOR) = BacDatEmi.sGeneri
       
       'Mejoras Art84
       Table1.TextMatrix(Table1.Row, 15) = BacDatEmi.lRutemi
       
       
      If bufFecVen <> BacDatEmi.sFecvct Then
          Let Data1.Recordset("tm_valmcd") = "N"
      End If
      Call Data1.Recordset.Update
   End If

   Call BacControlWindows(12)
   If Table1.Enabled = True Then
      Call Table1.SetFocus
   End If

End Sub
Private Function saca_marca()
 Dim i, Col As Integer
   With Table1
     For i = 1 To Table1.Rows - 1
      If Table1.TextMatrix(i, 15) = "." Then
         Table1.Row = i
          For Col = 0 To Table1.cols - 1
            Table1.Col = Col
            Table1.CellBackColor = 0
            Table1.TextMatrix(i, 15) = " "
          Next Col
      End If
     Next i
   End With
End Function

Private Function llena_grilla_acces()
 
 Dim Total As Double
 Dim cbosuper As String
 Dim Cuenta As Integer
 Dim i, Col As Integer
 Dim ini, lar As Integer
 
 Dim nTipoCambio  As Double
  ini = 1
  lar = 10
 'Funcion que quita el color a la lineas cuando se carga la grilla. ARM
 Call saca_marca
 'Funcion que quita el color a la lineas cuando se carga la grilla. ARM
 Col = 0
    Data1.DatabaseName = gsMDB_Path & gsMDB_Database
    Data1.RecordsetType = 1
    Data1.RecordSource = "SELECT * FROM MDCP WHERE tm_hwnd = " & hWnd
    Data1.Recordset.MoveFirst

    Filas = 1

  Let Table1.Rows = 2
 Do While Not Data1.Recordset.EOF
    
    If Data1.Recordset(3) <> "" Then
      Table1.Rows = Table1.Rows + 1
     ' Table1.TextMatrix(iRow, 15) = " "
      Let Table1.TextMatrix(Filas, 0) = Data1.Recordset("tm_instser")
      Let Table1.TextMatrix(Filas, 1) = Data1.Recordset("tm_nemmon")
      Let Table1.TextMatrix(Filas, 2) = Format(Data1.Recordset("tm_nominal"), "##,###.#000")
      Let Table1.TextMatrix(Filas, 3) = Format(Data1.Recordset("tm_tir"), FDecimal) '"##,###.#000")
      Let Table1.TextMatrix(Filas, 4) = Format(Data1.Recordset("tm_pvp"), FDecimal) '"##,###.#000")
      Let Table1.TextMatrix(Filas, 5) = Format(Data1.Recordset("tm_mt"), "##,###")
      Total = Total + Format(Data1.Recordset("tm_mt"), "##,###.#000")
      'Total = Total + Format(Data1.Recordset("tm_mt"), FDecimal)
      Let Table1.TextMatrix(Filas, 6) = "DCV"
      Let Table1.TextMatrix(Filas, 7) = Data1.Recordset("tm_clave_dcv") '
      Let Table1.TextMatrix(Filas, 8) = Format(Data1.Recordset("tm_tir"), FDecimal)
      Let Table1.TextMatrix(Filas, 9) = Format(Data1.Recordset("tm_pvp"), FDecimal)
      Let Table1.TextMatrix(Filas, 10) = Format(Data1.Recordset("tm_mt"), "##,###")
      Let Table1.TextMatrix(Filas, 11) = Format(0, "#0,###.#0")
      Let Table1.TextMatrix(Filas, 13) = Me.cboCarteraSuper.text
      Let Table1.TextMatrix(Filas, 14) = Data1.Recordset("tm_genemi")
          
      '--> Se agrega por precio de Transferencia
      Let Table1.TextMatrix(Filas, nCol_TTRAN) = Format(Data1.Recordset!tm_tirmcd, "#,##0.0000")
      Let Table1.TextMatrix(Filas, nCol_PTRAN) = Format(Data1.Recordset!tm_pvpmcd, "#,##0.0000")
      Let Table1.TextMatrix(Filas, nCol_VPTRAN) = Format(Data1.Recordset!tm_mtmcd, "#,###,###,##0" + IIf(Table1.TextMatrix(Table1.Row, nCol_UM) <> "USD", IIf(bFlagDpx, ".0000", ""), ".00"))
      Let Table1.TextMatrix(Filas, nCol_UTIL) = Format(Val(Data1.Recordset!TM_VPMO) - Val(Data1.Recordset!tm_VPTRANMO), "#,###,###,##0" + IIf(Table1.TextMatrix(Table1.Row, nCol_UM) <> "CLP", ".0000", ""))

      If Table1.TextMatrix(Filas, nCol_UM) <> "CLP" And Data1.Recordset!TM_MT <> Data1.Recordset!TM_VPMO Then
         nTipoCambio = 0
         nTipoCambio = funcBuscaTipcambio(Data1.Recordset!tm_monemi, gsBac_Fecp)
         Table1.TextMatrix(Filas, nCol_DifTran_CLP) = Format((Table1.TextMatrix(Table1.Row, nCol_UTIL) * nTipoCambio), "#,###,###,##0")
      Else
         Table1.TextMatrix(Filas, nCol_DifTran_CLP) = Format(Val(Data1.Recordset!TM_MT) - Val(Data1.Recordset!tm_mtmcd), "#,###,###,##0")
      End If
      '--> Se agrega por precio de Transferencia
          
     'Marca linea amarilla las operaciones anuladas -->ini
     cadena1 = Mid(cadena, ini, lar)
      If cadena1 = Data1.Recordset("tm_instser") Then
        Call marca_grilla
        ini = ini + 10
       Else
        Table1.BackColor = &H8000000F
      End If
     'Marca linea amarilla las operaciones anuladas -->Fin
     
     '--> Se agrega por precio de Transferencia
      Data1.Recordset.Edit
      'Data1.Recordset("tm_mt") = Total
      Data1.Recordset.Update
   'ARM
    End If
    Data1.Recordset.MoveNext
    Filas = Filas + 1

 Loop
     Table1.Enabled = True
     Toolbar1.Buttons(2).Enabled = True
     Toolbar1.Buttons(3).Enabled = True
     Toolbar1.Buttons(4).Enabled = True
     Toolbar1.Buttons(6).Enabled = True
     Table1.Rows = Table1.Rows - 1
     Me.TxtTotal.text = Total
     Total = 0
  'Call marca_grilla
  Call bloquea_pantalla
    cadena1 = ""
    cadena = ""
   
End Function

Private Function valida_papeles()
 Dim SqlDatos()
 Dim Nemo As String
 tickeraux = 0
       Envia = Array()
       AddParam Envia, ""
        If Not Bac_Sql_Execute("dbo.SP_CARGA_TICKER", Envia) Then
            Exit Function
        End If
        
        Do While Bac_SQL_Fetch(SqlDatos())
             Nemo = SqlDatos(1)
            tickeraux = tickeraux + 1
        Loop
End Function

Private Function bloquea_pantalla()
      Dim nContador As Integer
      
      With Table1
        For nContador = 1 To .Rows - 1
            Envia = Array()
            AddParam Envia, 1
            AddParam Envia, Table1.TextMatrix(nContador, 0)
            AddParam Envia, 0
            AddParam Envia, "USR"
            AddParam Envia, gsBac_User
          If Not Bac_Sql_Execute("dbo.SP_ACTUALIZA_TICKERS", Envia) Then
            ' Exit Sub
          End If
         Next nContador
       End With
 End Function
 
Private Function marca_grilla()
    Dim iRow            As Long
    Dim iCol            As Integer
    Dim lCurrentColor   As Long
    Dim nContador As Integer
     
     iRow = 1
     With Table1
        For nContador = 1 To .Rows - 1
          
           Table1.RowSel = Filas
           If Table1.TextMatrix(Filas, 0) = cadena1 Then
            For iCol = 0 To Table1.cols - 1
                Table1.Row = Filas
                Table1.Col = iCol
                Table1.CellBackColor = RGB(255, 255, 0)
            Next iCol
            Exit For
           End If
            Table1.Col = 0
            iRow = iRow + 1
             
       Next nContador
    End With
  
End Function

 
Private Function libera_papeles()
    Dim nContador As Integer
     With Table1
        For nContador = 1 To .Rows - 1
            Envia = Array()
            AddParam Envia, 1
            AddParam Envia, Table1.TextMatrix(nContador, 0)
            AddParam Envia, 0
            AddParam Envia, "USR"
            AddParam Envia, " "
          If Not Bac_Sql_Execute("dbo.SP_ACTUALIZA_TICKERS", Envia) Then
            ' Exit Sub
          End If
         Next nContador
       End With
   
  
End Function
Private Function valida_emisor()
  'ARM
 Dim i As Integer
 Dim X As Integer
  i = 0
  
  Posicion = 0
  With Table1
        For i = 0 To Table1.Rows - 1
            If Table1.TextMatrix(i, 14) = "?????" Then
               Color = 65535
               fl = 1
                If X = 0 Then
                   Posicion = i
                   X = 1
               End If
            End If
        Next i
     End With
  X = 0
End Function
 
Sub Proc_Agrupa_Operacions()
   Dim iRow As Integer
   Dim jRow As Integer
   Dim kRow As Integer
   
   With Grupo
        Call Grupo.Clear
         Let Grupo.cols = 9
         Let Grupo.Rows = 2
         Let Grupo.TextMatrix(0, cSuma) = "Suma"
         Let Grupo.TextMatrix(0, cInstrumento) = "Instrumento"
         Let Grupo.TextMatrix(0, cCantidad) = "Cantidad"
         Let Grupo.TextMatrix(0, cTir) = "Tir"
         Let Grupo.TextMatrix(0, cPrecio) = "Precio"
         Let Grupo.TextMatrix(0, cMonto) = "Monto $"
         Let Grupo.TextMatrix(0, cCustodia) = "Custodia"
         Let Grupo.TextMatrix(0, cClave) = "Clave DCV"
         Let Grupo.TextMatrix(0, cCartera) = "Cartera"
   End With
   
   kRow = 1

   For iRow = 1 To Grid.Rows - 1
      If Trim(Grid.TextMatrix(iRow, cInstrumento)) = "" Then
         Exit For
      End If
         
      If Grid.TextMatrix(iRow, cSuma) <> "*" Then
         For jRow = iRow + 1 To Grid.Rows - 1
            If Grid.TextMatrix(jRow, cSuma) <> "*" Then
               If Trim(Grid.TextMatrix(iRow, cInstrumento)) = Trim(Grid.TextMatrix(jRow, cInstrumento)) And Grid.TextMatrix(iRow, cTir) = Grid.TextMatrix(jRow, cTir) Then
                  If kRow = Grupo.Rows Then
                      Let Grupo.Rows = Grupo.Rows + 1
                  End If
                  Let Grupo.TextMatrix(kRow, cSuma) = ""
                  Let Grid.TextMatrix(jRow, cSuma) = "*"
                  Let Grupo.TextMatrix(kRow, cInstrumento) = Trim(Grid.TextMatrix(iRow, cInstrumento))
                  Let Grupo.TextMatrix(kRow, cCantidad) = Val(Grupo.TextMatrix(kRow, cCantidad)) + (Val(Grid.TextMatrix(jRow, cCantidad)))
                  Let Grupo.TextMatrix(kRow, cTir) = Grid.TextMatrix(iRow, cTir)
                  Let Grupo.TextMatrix(kRow, cPrecio) = Grid.TextMatrix(iRow, cPrecio)
                  Let Grupo.TextMatrix(kRow, cMonto) = Val(Grupo.TextMatrix(kRow, cMonto)) + (Val(Grid.TextMatrix(jRow, cMonto)))
                  Let Grupo.TextMatrix(kRow, cCustodia) = Grid.TextMatrix(iRow, cCustodia)
                  Let Grupo.TextMatrix(kRow, cClave) = Grid.TextMatrix(iRow, cClave)
                  Let Grupo.TextMatrix(kRow, cCartera) = Grid.TextMatrix(iRow, cCartera)
               End If
               If jRow = Grid.Rows - 1 Then
                  If kRow = Grupo.Rows Then
                     Let Grupo.Rows = Grupo.Rows + 1
                  End If
                  Let Grupo.TextMatrix(kRow, cSuma) = ""
                  Let Grid.TextMatrix(iRow, cSuma) = "*"
                  
                  Let Grupo.TextMatrix(kRow, cInstrumento) = Trim(Grid.TextMatrix(iRow, cInstrumento))
                  Let Grupo.TextMatrix(kRow, cCantidad) = Val(Grupo.TextMatrix(kRow, cCantidad)) + Val(Grid.TextMatrix(iRow, cCantidad))
                  Let Grupo.TextMatrix(kRow, cTir) = Grid.TextMatrix(iRow, cTir)
                  Let Grupo.TextMatrix(kRow, cPrecio) = Grid.TextMatrix(iRow, cPrecio)
                  Let Grupo.TextMatrix(kRow, cMonto) = Val(Grupo.TextMatrix(kRow, cMonto)) + Val(Grid.TextMatrix(iRow, cMonto))
                  Let Grupo.TextMatrix(kRow, cCustodia) = Grid.TextMatrix(iRow, cCustodia)
                  Let Grupo.TextMatrix(kRow, cClave) = Grid.TextMatrix(iRow, cClave)
                  Let Grupo.TextMatrix(kRow, cCartera) = Grid.TextMatrix(iRow, cCartera)
               End If
            End If
         Next jRow
         Let Grid.TextMatrix(iRow, cSuma) = "*"
         Let kRow = kRow + 1
      End If
   Next iRow
End Sub

Sub Proc_Grabar()
   Dim nContador As Integer
   Dim i As Integer
   Dim iRow  As Integer
   Dim C As Integer
   Existe = "NO"
  
   'Arm valida que exista uno o mas papeles seleccionados
  If tipopapel = "Automatica" Then
    With Table1
'       If COLOR = 65535 Then
'          Table1.CellBackColor = 65535
'       End If
        Table1.Row = 0
            For C = 0 To Table1.Rows - 1
               If Table1.Row >= 1 Then
                If Table1.TextMatrix(Table1.Row, 15) = "." Then
                    Existe = "SI"
               Color = 0
                End If
               End If
              If Table1.Row < Table1.Rows - 1 Then
                 Table1.Row = Table1.Row + 1
                 
                End If
              
             Next
    End With
    
    If Existe <> "SI" Then
       MsgBox "Debe seleccionar almenos un papel", vbInformation
       
       Exit Sub
    End If
  End If
  
'

   'ARM valida que grabe solo los papeles seleccionado cuando es carga automatica
   Dim sum#
  
  If tipopapel = "Automatica" Then
    With Table1
        Table1.Row = 0
         sum = 0
            For C = 0 To Table1.Rows - 1
              
                If Table1.Row >= 1 Then
                If Table1.TextMatrix(Table1.Row, 15) <> "." Then
                    Table1.RemoveItem Table1.Row
                    C = 0
                    Table1.Row = 0
                    Existe = "SI"
                
                   End If
                If Table1.Row < Table1.Rows - 1 Then
                 Table1.Row = Table1.Row + 1
                 
                End If
                 Else
                 Table1.Row = Table1.Row + 1
                End If
             Next
    End With
    C = 0
    TxtTotal.text = 0
     With Table1
      For C = 1 To Table1.Rows - 1
        If Table1.TextMatrix(Table1.Row, 15) = "." Then
           TxtTotal.text = CDbl(TxtTotal.text) + CDbl(Table1.TextMatrix(C, 10))
        End If
      Next C
     End With
    
   End If
   'Arm antes de grabar verifica si se ingreso un nuevo papel
   'Call graba_filas
   
   If tipopapel = "Automatica" Then
      Call valida_papeles
      If tickeraux > cuentticker Then
         MsgBox ("Se ha ingresado un nuevo papel, es necesario recargara informacion")
         Call carga_ticker
         Exit Sub
      End If
   End If
   
    'Arm valida que cada papel tenga asociado un emisor
     fl = 0
     Call valida_emisor
     If fl = 1 Then
        MsgBox ("Existen uno o mas papeles seleccionados sin emisor, verifique "), vbCritical, TITSISTEMA
        Exit Sub
     End If
    
    
   If FUNC_Verifica_Papeles() Then
      MsgBox "No puede mezclar monedas MX/$ o MX/MX diferentes", vbExclamation, TITSISTEMA
      If Table1.Enabled = True Then: Table1.SetFocus
      Exit Sub
   End If

 ' VB+- 21/06/2010 Se agrega validacion
    If Me.TipoPago <> "HOY" Then
        If FUNC_Valida_Papeles_PM_ICP Then
            MsgBox "No se puede realizar operacion PM con papeles en ICP", vbExclamation, TITSISTEMA
            If Table1.Enabled = True Then: Table1.SetFocus
            Exit Sub
        End If
    End If
        
  If CmbLibro.ListIndex = -1 Then
      MsgBox "No existen libros asociados para esta operacion", vbExclamation
      Exit Sub
   End If
    
   Let Screen.MousePointer = vbHourglass
    
   Let Table1.Row = 1
   Let BacIrfGr.proMoneda = IIf(Trim$(Table1.TextMatrix(Table1.Row, nCol_UM)) = gsBac_Dolar Or Mid$((Table1.TextMatrix(Table1.Row, nCol_SERIE)), 1, 3) = "DPX", gsBac_Dolar, "$$")
   Let BacIrfGr.ProDpx = IIf(Mid$((Table1.TextMatrix(Table1.Row, nCol_SERIE)), 1, 3) = "DPX", "S", "N")
   Let BacIrfGr.proMtoOper = TxtTotal.text
   Let BacIrfGr.proHwnd = hWnd
   Let BacIrfGr.proTIPINST = Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6)
   Let BacIrfGr.cCodLibro = BacCP.cCodLibro
      

   If Not valida_custodia() Then
      Let Screen.MousePointer = vbDefault
      If Table1.Enabled = True Then
         Call Table1.SetFocus
      End If
      Exit Sub
   End If
    
   With Table1
      For nContador = 1 To .Rows - 1
         If Trim(Table1.TextMatrix(nContador, nCol_TCSP) = "") Then 'cartera super
            Let Screen.MousePointer = vbDefault
            MsgBox "Debe Seleccionar una Cartera Super", vbExclamation
            Table1.Col = nCol_TCSP 'cartera super
            Table1.Row = nContador
            Exit Sub
         End If
         
         If Not Proc_Valida_Tasa_Transferencia(Table1.TextMatrix(nContador, nCol_TIR), Table1.TextMatrix(nContador, nCol_TTRAN)) Then
            Table1.Col = nCol_TTRAN
            Table1.Row = nContador
            Table1.SetFocus
            Exit Sub
         End If
      Next nContador
   End With
    
   Let BacIrfGr.oValorDVP = "glBacCpDvpCp"
   Let BacIrfGr.oDVP = glBacCpDvpCp
   Let BacIrfGr.cCodLibro = Trim(Right(CmbLibro.text, 10))
   Let BacIrfGr.MiTipoPago = oTipoPago
   
   
   Call BacGrabarTX
    
   Call BacControlWindows(100)
    
   If Not Grabacion_Operacion Then
      Let Screen.MousePointer = vbDefault
      Call Data1.Refresh
   Else
      Call Func_Limpiar_Pantalla
      Call Limpia_grilla
      Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_20100", "01", "", "", "", " ")
   End If
    
   If Table1.Enabled = True Then
      Call Table1.SetFocus
   End If
    
End Sub

Function Aprobacion_Automatica()
Dim Datos()

        Envia = Array()
        AddParam Envia, gsNum_Oper
        If Not Bac_Sql_Execute("SP_APROB_AUTOMATICA", Envia) Then
            MsgBox "Sql-Server No Responde. Intentelo Nuevamente", 16, "BacTrader"
            Exit Function
        End If
                
End Function

Function valida_custodia() As Boolean
   Dim t As Integer

   Let valida_custodia = True

   For t = 1 To Table1.Rows - 1
      If Trim(Table1.TextMatrix(t, 6)) = "" Then
         MsgBox "Debe Definir Custodia en Registro " & t, vbExclamation, TITSISTEMA
         valida_custodia = False
         Exit Function
       Else
         If Trim(Table1.TextMatrix(t, 6)) = "DCV" And Trim(Table1.TextMatrix(t, 7)) = "" Then
            MsgBox "Debe Definir Clave DCV en Registro " & t, vbExclamation, TITSISTEMA
            valida_custodia = False
            Exit Function
         End If
      End If
   Next t
End Function

Private Sub Func_Limpiar_Pantalla()
 
   On Error GoTo ErrLimpiar

   Call Data1.Refresh
   If Data1.Recordset.RecordCount < 1 Then
      Exit Sub
   End If

   With Data1.Recordset
      Call Data1.Recordset.MoveFirst
      Do While Not Data1.Recordset.EOF
         Call Data1.Recordset.Delete
         Call Data1.Recordset.MoveNext
      Loop
   End With

   Call Data1.Refresh
   Call Limpia_Pantalla
   Call CP_Agregar(hWnd, Data1)
   Call Table1.Refresh
   Let TxtTotal.text = 0
   Let TipoPago.Enabled = True
   
   On Error GoTo 0
Exit Sub
ErrLimpiar:
   On Error GoTo 0
   MsgBox "No se pudo realizar limpieza de pantalla de compras propias", vbExclamation, gsBac_Version
 
End Sub


Private Sub cboCarteraSuper_GotFocus()
   Dim nContador As Integer

   Let bCancelar = True
   
   For nContador = 0 To cboCarteraSuper.ListCount - 1
      If Trim(Right(Table1.TextMatrix(Table1.Row, nCol_TCSP), 10)) = Trim(Right(cboCarteraSuper.List(nContador), 10)) Then
         Let cboCarteraSuper.ListIndex = nContador
        Exit Sub
    End If
   Next nContador

   Let cboCarteraSuper.ListIndex = -1
End Sub


Private Sub cboCarteraSuper_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyEscape Then
      Call cboCarteraSuper_LostFocus
   ElseIf KeyAscii = vbKeyReturn Then
      bCancelar = False
      Call cboCarteraSuper_LostFocus
   End If
End Sub

Private Sub cboCarteraSuper_LostFocus()
   Dim letra1     As String
   Dim Indice1    As Integer
        
   If bCancelar = False Then
      If Not Data1.Recordset.RecordCount = 1 Then
         Call Colocardata1
      Else
         Call Data1.Recordset.MoveFirst
      End If
      If Table1.Col = nCol_TCSP Then
         Call Data1.Recordset.Edit
         Let Data1.Recordset("tm_carterasuper") = Trim(Right(cboCarteraSuper.text, 10))
         Let Table1.TextMatrix(Table1.Row, nCol_TCSP) = cboCarteraSuper.text
         Call Data1.Recordset.Update
      End If
   End If
     
   Let Table1.Enabled = True
   Let cboCarteraSuper.Visible = False
   Let Screen.MousePointer = vbDefault

   If Table1.Enabled = True Then
      Call Table1.SetFocus
   End If
End Sub

Function Exporta_Excel(tipo As Boolean) As Boolean
   On Error GoTo Error_Exel
   Dim Linea   As String
   Dim i       As Double
   Dim Ruta    As String
   Dim Exc
   Dim Hoja
   Dim Sheet

   Let Exporta_Excel = False
   
   Set Exc = CreateObject("Excel.Application")
   Set Hoja = Exc.Application.Workbooks.Add.Sheets.Add
   Set Sheet = Exc.ActiveSheet

   Let Ruta = gsBac_DIREXEL & "Detalles_Carga" & Trim(Minute(Time)) & Trim(Second(Time)) & ".xls"
   Let Screen.MousePointer = 11
   
   DoEvents

   Call Clipboard.Clear

   Let Linea = ""
   If tipo = False Then
      Let Linea = Linea & "Revisar los Errores que encontro la carga automatica,"
      Let Linea = Linea & " este archivo fisico esta en la siguiente dirección : " & Ruta
   Else
      Let Linea = Linea & "Carga Correcta, "
      Let Linea = Linea & " este archivo fisico esta en la siguiente dirección : " & Ruta
   End If

   Call Clipboard.Clear
   Call Clipboard.SetText(Linea)
   
   Sheet.Range("A1").Select
   Sheet.Paste
   
   Linea = ""
   Linea = Linea & "Instrumento" & vbTab
   Linea = Linea & "Nominal" & vbTab
   Linea = Linea & "Tir" & vbTab
   Linea = Linea & "% Var" & vbTab
   Linea = Linea & "Valor Presente" & vbTab
   Linea = Linea & "Custodia" & vbTab
   Linea = Linea & "Clave DCV" & vbTab
   Linea = Linea & "Cartera" & vbTab
   
   Clipboard.Clear
   Clipboard.SetText Linea
   
   Sheet.Range("A3").Select
   Sheet.Paste
   
   Linea = ""
   Clipboard.Clear
   
   With Errores
      For i = 1 To .Rows - 1
         Linea = ""
         Linea = Linea & .TextMatrix(i, cInstrumento) & vbTab
         Linea = Linea & Format(.TextMatrix(i, cCantidad), "###,###.#000") & vbTab
         Linea = Linea & .TextMatrix(i, cTir) & vbTab
         Linea = Linea & .TextMatrix(i, cPrecio) & vbTab
         Linea = Linea & Format(.TextMatrix(i, cMonto), "###,###") & vbTab
         Linea = Linea & .TextMatrix(i, cCustodia) & vbTab
         Linea = Linea & .TextMatrix(i, cClave) & vbTab
         Linea = Linea & .TextMatrix(i, cCartera) & vbTab
      
         Clipboard.Clear
         Clipboard.SetText Linea
         
         Sheet.Range("A" & i + 3).Select
         Sheet.Paste
      Next i
   End With

   Sheet.Range("A1").Select
   Hoja.Application.DisplayAlerts = False
   Hoja.SaveAs (Ruta)
   Hoja.Application.Workbooks.Close
   Screen.MousePointer = 0
   Shell (gsBac_Office & "EXCEL.EXE  " & Ruta)
   Exporta_Excel = True

Exit Function
Error_Exel:
   MsgBox "Error : " & err.Description, vbExclamation, TITSISTEMA
   Exit Function
   Resume
End Function

Private Sub Chk_Dif_CLP_Click()

    If Chk_Dif_CLP.Value = 0 Then
        Table1.ColWidth(nCol_DifTran_CLP) = 0
    Else
        Table1.ColWidth(nCol_DifTran_CLP) = 2000
    End If

End Sub

Private Sub Cmb_cargar_Click()
   Dim nRow    As Integer
   Dim iRow    As Integer

   With Grupo
      Let Table1.Rows = 1:       Let Table1.Rows = 2
      Let Table1.Redraw = False: Let Table1.Enabled = False
      Let Termino_Carga = "NO"
      
      If glBacCpDvpCp = Si Then
         If Grupo.Rows > 10 Then
            MsgBox "¡ No es posible agregar más de 10 documentos al utilizar pago DVP Combanc. !", vbExclamation, TITSISTEMA
            If Table1.Enabled = True Then
               Table1.SetFocus
            End If
            Exit Sub
         End If
      End If

      Let Tipo_Carga = "AU"
      
      For iRow = 1 To .Rows - 1
         Call BacControlWindows(60)
         Let nRow = Func_Ultima_Fila(nRow)

         'Instrumento Serie
         Let Table1.Col = nCol_SERIE
         Let Table1.Row = nRow
         Let Text1.text = Trim(.TextMatrix(iRow, cInstrumento))
         Let Table1.TextMatrix(nRow, nCol_SERIE) = Trim(.TextMatrix(iRow, cInstrumento))
         Call Text1_KeyDown(vbKeyReturn, 0)
         Let TEXT2.text = 0
         Let Text1.text = ""

         'Nominal
         Let Table1.Col = nCol_NOMINAL
         Let Table1.Row = nRow
         Print Trim(.TextMatrix(iRow, cCantidad))
         Let TEXT2.text = Trim(.TextMatrix(iRow, cCantidad))
         Let Table1.TextMatrix(nRow, nCol_NOMINAL) = Trim(.TextMatrix(iRow, cCantidad))
         Call Text1_KeyDown(vbKeyReturn, 0)
         Let TEXT2.text = 0
         Let Text1.text = ""

         'Valor Presente Monto $
         Let Table1.Col = nCol_VPS
         Let Table1.Row = nRow
         Let TEXT2.text = Trim(.TextMatrix(iRow, cMonto))
         Let Table1.TextMatrix(nRow, nCol_VPS) = Trim(.TextMatrix(iRow, cMonto))
         Call Text1_KeyDown(vbKeyReturn, 0)
         Let TEXT2.text = 0
         Let Text1.text = ""

         'Custodia
         Let Table1.Col = nCol_CUST
         Let Table1.Row = nRow

         'Combo1.Text = Trim(.TextMatrix(iRow, CCustodia))
         If UCase(Trim(.TextMatrix(iRow, cCustodia))) = "" Then
            Let Table1.TextMatrix(nRow, nCol_CUST) = "DCV"
            Let .TextMatrix(iRow, cCustodia) = "DCV"
         Else
            Let Table1.TextMatrix(nRow, nCol_CUST) = UCase(Trim(.TextMatrix(iRow, cCustodia)))
         End If
         Let TEXT2.text = 0
         Let Text1.text = ""

         'Clave
         Let Table1.Col = nCol_CDCV
         Let Table1.Row = nRow
         If UCase(Trim(.TextMatrix(iRow, cCustodia))) = "DCV" Then
            If UCase(Trim(.TextMatrix(iRow, cClave))) <> "" Then
               Let Table1.TextMatrix(nRow, nCol_CDCV) = Trim(.TextMatrix(iRow, cClave))
            Else
               Let Table1.TextMatrix(nRow, nCol_CDCV) = "FALTA-"
            End If
         End If
         Let TEXT2.text = 0
         Let Text1.text = ""

         'Cartera
         Let Table1.Col = nCol_TCSP
         Let Table1.Row = nRow
         
         If UCase(Trim(.TextMatrix(iRow, cCartera))) = "" Then
            Let Table1.TextMatrix(nRow, nCol_TCSP) = cboCarteraSuper.List(0) ''''''"TRANSABLE"
         Else
            Let Table1.TextMatrix(nRow, nCol_TCSP) = UCase(Trim(.TextMatrix(iRow, cCartera)))
         End If
         Let TEXT2.text = 0
         Let Text1.text = ""
      Next iRow

      Let Table1.Redraw = True
      Let Table1.Enabled = True

      If Func_Valida_Carga = False Then
         Let Toolbar1.Buttons(2).Enabled = True
         Call Exporta_Excel(False)
         MsgBox "DEBE regularizar los problemas detectados," & Chr(10) & "que aparecierón en la planilla excel adjunta," & Chr(10) & "y luego continuar con la grabación", vbCritical, TITSISTEMA
      Else
         Let Toolbar1.Buttons(2).Enabled = True
         Call Exporta_Excel(True)
         MsgBox "Carga efectuada correctamente " & Chr(10) & "Se genero una planilla Excel con el detalle", vbInformation, TITSISTEMA
      End If
      Let Toolbar1.Buttons(6).Enabled = False
      Let TxtTotal.Enabled = False
   End With
   Let Termino_Carga = "NO"
End Sub

Function Func_Valida_Carga() As Boolean
   Dim i             As Integer
   Dim Aprueba       As String
   Dim Error         As Integer
   Dim Glosa_Error   As String
   Dim nContador     As Integer
   Dim Datos()

   Let Aprueba = "SI"
   Let Func_Valida_Carga = False

   With Errores
      Errores.Clear
      Errores.cols = 9
      Errores.Rows = 5
      Errores.TextMatrix(0, cSuma) = "Suma"
      Errores.TextMatrix(0, cInstrumento) = "Instrumento"
      Errores.TextMatrix(0, cCantidad) = "Cantidad"
      Errores.TextMatrix(0, cTir) = "Tir"
      Errores.TextMatrix(0, cPrecio) = "Precio"
      Errores.TextMatrix(0, cMonto) = "Monto $"
      Errores.TextMatrix(0, cCustodia) = "Custodia"
      Errores.TextMatrix(0, cClave) = "Clave DCV"
      Errores.TextMatrix(0, cCartera) = "Cartera"
   End With

   With Table1
      For i = 1 To Table1.Rows - 1
         'Validar Serie
         Envia = Array(.TextMatrix(i, nCol_SERIE))
         If Not Bac_Sql_Execute("SP_CHKINSTSER", Envia) Then
         End If
         If Bac_SQL_Fetch(Datos()) Then
            Error = Val(Datos(1))
            Glosa_Error = Trim(.TextMatrix(i, nCol_SERIE))
            If Error = 0 Then
               If Format(Datos(10), "yyyymmdd") <= Format(gsBac_Fecp, "yyyymmdd") Then
                  Glosa_Error = Glosa_Error & " Serie ingresada esta vencida " & Format(Datos(10), "dd/mm/yyyy")
                  Aprueba = "NO"
               End If
            Else
               Aprueba = "NO"
               Select Case Error
                  Case 1:    Glosa_Error = Glosa_Error & " 'DD' no es dia"
                  Case 2:    Glosa_Error = Glosa_Error & " 'MM' no es fecha"
                  Case 3:    Glosa_Error = Glosa_Error & " 'YY' no es año"
                  Case 4:    Glosa_Error = Glosa_Error & " 'DDMMAA' o 'AAMMDD' no es fecha"
                  Case 5:    Glosa_Error = Glosa_Error & " ' ' no es blanco"
                  Case 6:    Glosa_Error = Glosa_Error & " 'N' no es número"
                  Case 7:    Glosa_Error = Glosa_Error & " No Coincidió con ninguna máscara"
                  Case 8:    Glosa_Error = Glosa_Error & " No existe en familia de instrumentos"
                  Case 9:    Glosa_Error = Glosa_Error & " No existe en series"
                  Case 10:   Glosa_Error = Glosa_Error & " No fue posible determinar fecha de vencimiento"
                  Case 11:   Glosa_Error = Glosa_Error & " Fecha de la serie no es válida"
                  Case 12:   Aprueba = "SI"
                  Case 15:   Glosa_Error = Glosa_Error & " Serie ingresada no es valida"
                  Case 30:   Glosa_Error = Glosa_Error & " Plazo residual debe ser menor o igual a 180 días"
                  Case 31:   Glosa_Error = Glosa_Error & " Plazo residual debe ser mayor a 180 días"
                  Case Else: Glosa_Error = Glosa_Error & " No se encontró máscara"
               End Select
            End If
         End If
        
         If Errores.Rows = i Then Errores.Rows = Errores.Rows + 1
            Errores.TextMatrix(i, cInstrumento) = Glosa_Error
            'Nominal
            If Format(.TextMatrix(i, nCol_NOMINAL), "###.###,0#") = 0# Then
               Errores.TextMatrix(i, cCantidad) = Trim(.TextMatrix(i, nCol_NOMINAL)) & " Nominal, debe ser mayor a Cero"
               Aprueba = "NO"
            Else
            Errores.TextMatrix(i, cCantidad) = Trim(.TextMatrix(i, nCol_NOMINAL))
         End If

         'Valor Presente
         If (.TextMatrix(i, nCol_VPS)) = "0" Then
            Errores.TextMatrix(i, cMonto) = Trim(.TextMatrix(i, nCol_VPS)) & " Valor Presente, debe ser Mayor a Cero"
            Aprueba = "NO"
         Else
            Errores.TextMatrix(i, cMonto) = Trim(.TextMatrix(i, nCol_VPS))
         End If
         
         'Tir
         If Trim(.TextMatrix(i, nCol_TIR)) <> Grupo.TextMatrix(i, cTir) Then
            Errores.TextMatrix(i, cTir) = "Excel " & Grupo.TextMatrix(i, cTir) & " Calculada " & Trim(.TextMatrix(i, nCol_TIR))
         Else
            Errores.TextMatrix(i, cTir) = Trim(.TextMatrix(i, nCol_TIR))
         End If
   
         'Valor Par
         If Trim(.TextMatrix(i, nCol_VPAR)) <> Grupo.TextMatrix(i, cPrecio) Then
            Errores.TextMatrix(i, cPrecio) = "Excel " & Grupo.TextMatrix(i, cPrecio) & " Calculada " & Trim(.TextMatrix(i, nCol_VPAR))
         Else
            Errores.TextMatrix(i, cPrecio) = Trim(.TextMatrix(i, nCol_VPAR))
         End If
   
         'Custodia
         If OptDvp(1).Value = False Then
            If UCase(Trim(.TextMatrix(i, nCol_CUST))) <> "PROPIA" And UCase(Trim(.TextMatrix(i, nCol_CUST))) <> "DCV" And UCase(Trim(.TextMatrix(i, nCol_CUST))) <> "CLIENTE" Then
               Errores.TextMatrix(i, cCustodia) = Trim(.TextMatrix(i, nCol_CUST)) & " Custodia Ingresada Incorrecta"
               Aprueba = "NO"
            Else
               Errores.TextMatrix(i, cCustodia) = Trim(.TextMatrix(i, nCol_CUST))
            End If
         Else
            Errores.TextMatrix(i, cCustodia) = Trim(.TextMatrix(i, nCol_CUST)) & " Custodia Ingresada DEBE ser solamente DCV, por DVP"
            Aprueba = "NO"
         End If

         'Clave DCV
         If UCase(Trim(.TextMatrix(i, nCol_CUST))) = "DCV" And UCase(Trim(.TextMatrix(i, nCol_CDCV))) = "FALTA-" Then
            Errores.TextMatrix(i, cClave) = "Debe Ingresar la Clave DCV"
            Aprueba = "NO"
         Else
            Errores.TextMatrix(i, cClave) = Trim(.TextMatrix(i, nCol_CDCV))
         End If
   
         'Cartera
         For nContador = 0 To cboCarteraSuper.ListCount - 1
            If Trim(Right(.TextMatrix(i, nCol_TCSP), 10)) = Trim(Right(cboCarteraSuper.List(nContador), 10)) Then
               Exit For
            End If
         Next nContador
         
         If nContador = cboCarteraSuper.ListCount Then
            Errores.TextMatrix(i, cCartera) = Trim(.TextMatrix(i, nCol_TCSP)) & " Custodia Ingresada Incorrecta"
            Aprueba = "NO"
         Else
            Errores.TextMatrix(i, cCartera) = Trim(Right(.TextMatrix(i, nCol_TCSP), 10))
         End If
      Next i
   
      If Aprueba = "NO" Then
         Func_Valida_Carga = False
      Else
         Func_Valida_Carga = True
      End If
   End With

End Function
Private Sub CmbLibro_Click()
    
    'Call PROC_LLENA_COMBOS(cboCarteraSuper, 6, False, GLB_ID_SISTEMA, Tipo_Operacion, Trim(Right(CmbLibro.Text, 10)), GLB_CARTERA_NORMATIVA)
    Call PROC_LLENA_COMBOS(cboCarteraSuper, 9, False, GLB_ID_SISTEMA, Tipo_Operacion, Trim(Right(CmbLibro.text, 10)), GLB_CARTERA_NORMATIVA, "", gsBac_User)
    
    With Table1
      For nContador = 1 To .Rows - 1
         .TextMatrix(nContador, nCol_TCSP) = cboCarteraSuper.text
      Next nContador
    End With
    
    If cboCarteraSuper.ListCount = 0 And Me.Visible = True And CmbLibro.ListIndex > -1 Then
       MsgBox "El Libro " & Trim(Left(CmbLibro.text, 50)) & " no tiene asociada ninguna Cartera Super", vbExclamation
       Exit Sub
    End If
    'ARM
         
      If cboCarteraSuper.text <> "" And SW = 0 Then
         Combo1.Clear
         Combo1.AddItem "CLIENTE"
         Combo1.AddItem "PROPIA"
         Combo1.AddItem "DCV"
         Combo1.ListIndex = 1
         Table1.Enabled = True
         Toolbar1.Buttons(6).Enabled = True
         SW = 1
      End If
'    Arm
    
    CmbLibro.Enabled = False
End Sub

Private Sub Combo1_Click()
If tipopapel = "Manual" Then

   'hoy
   Table1.Col = nCol_CUST
   Table1.text = Combo1.text
 ' If sw = 0 Then
 
    
   If Table1.Col = nCol_CUST Then
   '   Call Combo1_KeyDown(vbKeyReturn, 0)
      If Mid(Table1.TextMatrix(Table1.Row, nCol_CUST), 1, 3) = Combo1.text Then
         Table1.TextMatrix(Table1.Row, nCol_CDCV) = FUNC_GENERA_CLAVE_DCV
         Table1.Col = nCol_CDCV
         Data1.Recordset.Edit
         Data1.Recordset!tm_clave_dcv = Table1.TextMatrix(Table1.Row, nCol_CDCV)
         Data1.Recordset.Update
         clave = Table1.TextMatrix(Table1.Row, nCol_CDCV)
      Else
         Table1.TextMatrix(Table1.Row, nCol_CDCV) = " "
      End If
   End If
   
    
  ' End If
    
   If Me.Visible = True Then
      If Combo1.Visible = True Then
         If Table1.Enabled = True Then: Table1.SetFocus
      End If
   End If
Else
       Select Case Table1.Col
        Case 6: Exit Sub
   End Select
End If
 
End Sub

Private Sub Combo1_GotFocus()
   Call PROC_POSI_TEXTO(Table1, Combo1)
End Sub

Private Sub Combo1_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim Letra   As String
   Dim indice  As Integer

   If KeyCode = 37 Or KeyCode = 38 Or KeyCode = 39 Or KeyCode = 40 Then
      Exit Sub
   End If

   If KeyCode = vbKeyReturn Then
      If Not Data1.Recordset.RecordCount = 1 Then
         Call Colocardata1
      Else
         Data1.Recordset.MoveFirst
      End If

      If Table1.Col = nCol_CUST Then
         If Data1.Recordset.EOF = False Then
            Data1.Recordset.Edit
         Else
            Data1.Recordset.MoveFirst
            Data1.Recordset.Edit
         End If
         
         If glBacCpDvpCp = Si Then
            Data1.Recordset("tm_custodia") = "DCV"
            Data1.Recordset("tm_clave_dcv") = " "
            Table1.TextMatrix(Table1.Row, nCol_CUST) = "DCV"
            Table1.TextMatrix(Table1.Row, nCol_CDCV) = ""
            KeyCode = vbKeyReturn
         Else
            Data1.Recordset("tm_custodia") = Combo1.text
            Data1.Recordset("tm_clave_dcv") = ""
            Table1.TextMatrix(Table1.Row, nCol_CUST) = Combo1.text
            Table1.TextMatrix(Table1.Row, nCol_CDCV) = ""
            KeyCode = vbKeyReturn
         End If
         
         Data1.Recordset.Update
         Combo1.Visible = False
         If Table1.Enabled = True Then: Table1.SetFocus
      End If
         Combo1.Visible = False
   End If

   If KeyCode = vbKeyEscape Then
      Combo1.Visible = False
      If Table1.Enabled = True Then: Table1.SetFocus
   End If

   If KeyCode <> vbKeyReturn Then
      Letra = UCase(Chr(KeyCode))
' ------------------------------------------------------------------------------------
' +++VFBF 20180620 SE AGREGA NUEVO OPCION DE TIPO DE PAGO
' ------------------------------------------------------------------------------------
      If TipoPago.ListIndex = 2 Then
        If Letra = "P" Or Letra = "C" Then
            MsgBox "Para operaciones T+2 (Contado Normal) la custodia valida solo es DCV", vbExclamation, TITSISTEMA
            Combo1.ListIndex = 2
            Exit Sub
        End If
      End If
' ------------------------------------------------------------------------------------
' ---VFBF 20180620 SE AGREGA NUEVO OPCION DE TIPO DE PAGO
' ------------------------------------------------------------------------------------
       
      
      For indice = 0 To Combo1.ListCount - 1
         Combo1.ListIndex = indice
         If Trim(Letra) = Mid(Trim(Combo1.text), 1, 1) Then
            Exit For
         End If
      Next indice
   End If
End Sub

Private Sub Combo1_LostFocus()
   
   On Error Resume Next
   Combo1.Visible = False
   If Table1.Enabled = True Then
      Table1.SetFocus
   End If

End Sub





Private Sub data1_Error(DataErr As Integer, Response As Integer)

   MsgBox "ERROR POR DATA CONTROL : " & DataErr, vbExclamation, "Mensaje"

End Sub

Private Sub Form_Activate()

   Me.Tag = "CP"
   Tipo_Operacion = "CP"
   Screen.MousePointer = vbHourglass
   Screen.MousePointer = vbDefault
   
   If CmbLibro.ListCount = 0 Then
      MsgBox "Este producto no tiene asociado ningun libro", vbExclamation
      'Unload Me
      Exit Sub
   End If
   
   If cboCarteraSuper.ListCount = 0 And CmbLibro.ListIndex > 0 Then
      MsgBox "El Libro " & Trim(Left(CmbLibro.text, 50)) & " no tiene asociada ninguna Cartera Super", vbExclamation
   End If
   'ARM
   'glBacCpDvpCp = Si
   CmbLibro.ListIndex = 0
   

   If SwLimpia = True Then
       '*************************
       ' Elimna registros asociados a la CP.-
      Call CP_BorrarTx(Me.hWnd)
      Call Limpiar_Datos
      'Call Form_Load
   ' Desactivar botones asociados a la operación.-
   'BacHabilitaBotones ""

   'Set objMonLiq = Nothing
    '*************************
      Let SwLimpia = False
   End If
End Sub

Private Sub Form_Deactivate()
   Screen.MousePointer = vbHourglass
   Screen.MousePointer = vbDefault
End Sub

Private Sub Limpiar_Datos()
   On Error GoTo BacErrHnd
   Dim i       As Integer
   Dim Datos()
   
   Me.Top = 0: Me.Left = 0
   Screen.MousePointer = vbHourglass
   
   FormHandle = Me.hWnd
   Tipo_Operacion = "CP"

   'Let Tipo_Carga = "MN"
   Let Termino_Carga = "NO"
   
   Let tipopapel = "Manual"
''''   If Tipo_Carga = "AU" Then
''''      Let Me.Height = 9000
''''   Else
''''      Let Me.Height = 5820
''''   End If

   Call CP_IniciarTx(FormHandle, Data1)
'   Call PROC_LLENA_COMBOS(CmbLibro, 5, False, GLB_ID_SISTEMA, "CP", GLB_LIBRO)
    Call PROC_LLENA_COMBOS(CmbLibro, 8, False, GLB_ID_SISTEMA, "CP", GLB_LIBRO, "", gsBac_User)
    
 
    CmbLibro.Enabled = False
   'Let CmbLibro.ListIndex = -1
   Let CmbLibro.ListIndex = 0
   Let cboCarteraSuper.Visible = False
   Let CmbLibro.Enabled = True
   
   Let iFlagKeyDown = True
   Let gsBac_Valmon = 1

   Call objMonLiq.LeerCodigos(22)

   Let TxtTotal.Enabled = False
   Let Toolbar1.Buttons(2).Enabled = False
   Let Toolbar1.Buttons(3).Enabled = False
   Let Toolbar1.Buttons(4).Enabled = False
   Let Toolbar1.Buttons(6).Enabled = False
    
   Let Grid.Visible = False
   Let Grupo.Visible = False
   Let Errores.Visible = False
   Let Cmb_cargar.Visible = False
    
   Call Data1.Refresh
   Call Genera_Grilla
   Call Limpia_grilla
   Call Func_Limpiar_Pantalla
   
   'Let Table1.Col = nCol_SERIE

   'Call TipoPago.AddItem("HOY"):    Let TipoPago.ItemData(TipoPago.NewIndex) = 0
   'Call TipoPago.AddItem("MAÑANA"): Let TipoPago.ItemData(TipoPago.NewIndex) = 1
   
   Let TipoPago.ListIndex = 0
   Let oTipoPago = TipoPago.ListIndex
   
   Call Proc_Consulta_Porcentaje_Transacciones("CP")
    
   Call LeeModoControlPT    'PRD-3860, modo silencioso
    
   On Error GoTo 0
   Let Screen.MousePointer = vbDefault
Exit Sub
BacErrHnd:
   On Error GoTo 0
   Resume
End Sub

Private Sub Form_Load()
   On Error GoTo BacErrHnd
   Dim i       As Integer
   Dim Datos()
   
   Let SwLimpia = True
   
   Me.Top = 0: Me.Left = 0
   Screen.MousePointer = vbHourglass
   
   FormHandle = Me.hWnd
   Tipo_Operacion = "CP"

   Let Tipo_Carga = "MN"
   Let Termino_Carga = "NO"
   Table1.Enabled = True
   Let tipopapel = "Manual"
''''   If Tipo_Carga = "AU" Then
''''      Let Me.Height = 9000
''''   Else
''''      Let Me.Height = 5820
''''   End If

   Call CP_IniciarTx(FormHandle, Data1)
'   Call PROC_LLENA_COMBOS(CmbLibro, 5, False, GLB_ID_SISTEMA, "CP", GLB_LIBRO)
    Call PROC_LLENA_COMBOS(CmbLibro, 8, False, GLB_ID_SISTEMA, "CP", GLB_LIBRO, "", gsBac_User)
    
 
    CmbLibro.Enabled = False
   'Let CmbLibro.ListIndex = -1
   Let cboCarteraSuper.Visible = False
   Let CmbLibro.Enabled = True
   
   Let iFlagKeyDown = True
   Let gsBac_Valmon = 1

   Call objMonLiq.LeerCodigos(22)

   Let TxtTotal.Enabled = False
   Let Toolbar1.Buttons(2).Enabled = False
   Let Toolbar1.Buttons(3).Enabled = False
   Let Toolbar1.Buttons(4).Enabled = False
   Let Toolbar1.Buttons(6).Enabled = False
    
   Let Grid.Visible = False
   Let Grupo.Visible = False
   Let Errores.Visible = False
   Let Cmb_cargar.Visible = False
    
   Call Data1.Refresh
   Call Genera_Grilla
   Call Limpia_grilla
   Call Func_Limpiar_Pantalla
   
   'Let Table1.Col = nCol_SERIE

   Call TipoPago.AddItem("HOY"):    Let TipoPago.ItemData(TipoPago.NewIndex) = 0
   Call TipoPago.AddItem("MAÑANA"): Let TipoPago.ItemData(TipoPago.NewIndex) = 1
   
' ------------------------------------------------------------------------------------
' +++VFBF 20180620 SE AGREGA NUEVO OPCION DE TIPO DE PAGO
' ------------------------------------------------------------------------------------
   Call TipoPago.AddItem("T+2"): Let TipoPago.ItemData(TipoPago.NewIndex) = 2
' ------------------------------------------------------------------------------------
' ---VFBF 20180620 SE AGREGA NUEVO OPCION DE TIPO DE PAGO
' ------------------------------------------------------------------------------------

   Let TipoPago.ListIndex = 0
   Let oTipoPago = TipoPago.ListIndex
   
   Call Proc_Consulta_Porcentaje_Transacciones("CP")
    
   Call LeeModoControlPT    'PRD-3860, modo silencioso
    
   On Error GoTo 0
   Let Screen.MousePointer = vbDefault
Exit Sub
BacErrHnd:
   On Error GoTo 0
   Resume
End Sub

Private Sub Form_Resize()
   On Error GoTo BacErrHnd
   Dim X!, Y!, j%
   Dim lScaleWidth&, lScaleHeight&, lPosIni&

   If Me.WindowState = 1 Then
      X = Me.Width
      Y = Me.Height
      For j% = 1 To 15
         Line (0, 0)-(X, 0), QBColor(Int(Rnd * 15))
         Line (X, 0)-(X, Y), QBColor(Int(Rnd * 15))
         Line (X, Y)-(0, Y), QBColor(Int(Rnd * 15))
         Line (0, Y)-(0, 0), QBColor(Int(Rnd * 15))
         DoEvents
      Next
      On Error GoTo 0
      Exit Sub
   End If

   ' Escalas de medida de la ventana.-
   Let lScaleWidth& = Me.ScaleWidth
   Let lScaleHeight& = Me.ScaleHeight

   ' Resize la ventana customizado.-
   If Me.WindowState <> 1 And Me.Width > 400 And Me.Height > 1600 Then
     ' Let Table1.Width = Me.Width - 300
     ' Let Table1.Height = Me.Height - 2000
   End If
   On Error GoTo 0
Exit Sub
BacErrHnd:
   On Error GoTo 0
Resume
End Sub

Private Sub Form_Unload(Cancel As Integer)

   'LIBERA PAPELES
   Call libera_papeles
   ' Elimna registros asociados a la CP.-
      Call CP_BorrarTx(Me.hWnd)
 
   ' Desactivar botones asociados a la operación.-
   BacHabilitaBotones ""

   Set objMonLiq = Nothing

End Sub

Private Sub SSRibbon1_Click(Value As Integer)

    Table1.ColWidth(1) = IIf(Value = True, 0, 500)

End Sub

Private Sub Label_DblClick()
If Grid.Visible = True Then
    Grid.Visible = False
    Grupo.Visible = False
    Errores.Visible = False
    Cmb_cargar.Visible = False
Else
    Grid.Visible = True
    Grupo.Visible = True
    Errores.Visible = True
    Cmb_cargar.Visible = True
End If
End Sub

Private Sub OptDvp_Click(Index As Integer)

    If CmbLibro.ListIndex > -1 And CmbLibro.Enabled = True Then
        MsgBox "El Libro " & Trim(Left(CmbLibro.text, 50)) & " no tiene asociada ninguna Cartera Super", vbExclamation
        OptDvp(Index).Value = False
        Exit Sub
    ElseIf CmbLibro.ListIndex = -1 Then
        MsgBox "Antes Debe Seleccionar Un Libro", vbExclamation
        OptDvp(Index).Value = False
        Exit Sub
    End If
    
   Select Case Index
      Case 0
         glBacCpDvpCp = No
         Combo1.Clear
         
         Combo1.AddItem "CLIENTE"
         Combo1.AddItem "PROPIA"
         Combo1.AddItem "DCV"
         Combo1.ListIndex = 1
      Case 1
         glBacCpDvpCp = Si
         Combo1.Clear
         Combo1.AddItem "DCV"
         Combo1.ListIndex = 0
   End Select

   Cuadrodvp.Enabled = False
   Table1.Enabled = True
   Toolbar1.Buttons(6).Enabled = True
   TipoPago.Enabled = False
   
End Sub

Private Sub Table1_Click()
 Dim iRow, i As Integer
 Dim Col As Integer
 Dim nContador As Integer
 Dim iCol
 Col = Table1.cols
 iRow = Table1.RowSel
 'Pinta fila seleccionada cuando es carga automatica
  
 If Table1.CellBackColor = 0 Then
 If tipopapel = "Automatica" Then
    If Table1.TextMatrix(Table1.RowSel, 14) = "?????" Then
      MsgBox "Para Grabar este papel debe asociar Emisor", vbExclamation, TITSISTEMA
      Call Func_Emision
      Exit Sub
    End If
    
  With Table1
            For iCol = 0 To Table1.cols - 1
                Table1.Col = iCol
                Table1.CellBackColor = &HFFFF80
                Table1.TextMatrix(iRow, 15) = "."
            Next iCol
    End With
 End If
 Exit Sub
 End If
 
 'quita el color amarillo a la fila
 If Table1.CellBackColor = &HFFFF80 Then
 If tipopapel = "Automatica" Then
   With Table1
            For iCol = 0 To Table1.cols - 1
                Table1.Col = iCol
                Table1.CellBackColor = 0
                Table1.TextMatrix(iRow, 15) = " "
            Next iCol
    End With
 End If
 Exit Sub
 End If
 
End Sub

Private Sub Table1_DblClick()
If tipopapel = "Manual" Then
If Termino_Carga = "SI" Then Exit Sub
   Dim X  As Integer
   
   If Table1.Col = nCol_CUST Then
        If Not Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" Then
            For X = 0 To Combo1.ListCount - 1
               Combo1.ListIndex = X
               If Combo1 = Table1.TextMatrix(Table1.RowSel, Table1.ColSel) Then
                  Exit For
               End If
            Next
            
            Combo1.Visible = True
            Combo1.SetFocus
        End If
   End If
   
   If Table1.Col = nCol_TCSP Then
      cboCarteraSuper.Visible = True
      cboCarteraSuper.SetFocus
   End If
Else
       Select Case Table1.Col
        Case 6: Exit Sub
   End Select
End If
End Sub

Private Sub Table1_GotFocus()
If Termino_Carga = "SI" Then Exit Sub
   Table1.CellBackColor = &H8000000F: Text1.Font.bold = True

End Sub

Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode = 45 Then
        If tipopapel <> "Manual" Then
            MsgBox "No puede insertar Series con Carga Automatica", vbExclamation, TITSISTEMA
            Exit Sub
        End If
    End If
    
    If Termino_Carga = "SI" Then Exit Sub
    On Error GoTo KeyDownError

    Dim aux&
    Dim letra1 As String
    Dim Indice1 As Integer
   
    If iFlagKeyDown = False Then
       On Error GoTo 0
       Exit Sub
    End If


    If KeyCode = vbKeyInsert Then
        ' -------------------------------------------------------------------------------------------------------------------
        ' +++ VFBF 20180619 VALIDACION DE LA CUSTODIA PARA OPERACIONES T+2
        ' -------------------------------------------------------------------------------------------------------------------
          If Trim$(Table1.TextMatrix(Table1.Row, nCol_SERIE)) <> "" Then
          aux& = Table1.Row
            If Trim$(Table1.TextMatrix(Table1.Row, nCol_CUST)) <> "" Then
                If Trim$(Table1.TextMatrix(Table1.Row, nCol_CUST)) <> "DCV" Then
                    If Me.TipoPago.ListIndex = 2 Then
                        MsgBox "Para operaciones T+2 (Contado Normal) la custodia valida solo es DCV", vbExclamation, TITSISTEMA
                        If Table1.Enabled = True Then: Table1.SetFocus
                        On Error GoTo 0
                        Table1.Row = aux&
                        Exit Sub
                    End If
                End If
            End If
          End If
        ' -------------------------------------------------------------------------------------------------------------------
        ' ---- VFBF 20180619 VALIDACION DE LA CUSTODIA PARA OPERACIONES T+2
        ' -------------------------------------------------------------------------------------------------------------------
        If Trim$(Table1.TextMatrix(Table1.Row, nCol_SERIE)) <> "" Then
            If (Val(Table1.TextMatrix(Table1.Row, nCol_VPS)) = 0 And Val(Table1.TextMatrix(Table1.Row, nCol_TIR)) = 0) Or Val(Table1.TextMatrix(Table1.Row, nCol_NOMINAL)) = 0 Then
                MsgBox "¡ No se puede agregar nuevo registro si no tiene valores resgistro actual!", vbExclamation, TITSISTEMA
                If Table1.Enabled = True Then: Table1.SetFocus
                Exit Sub
            End If
        End If
        If Trim(Table1.TextMatrix(Table1.RowSel, 6)) = "DCV" And Trim(Table1.TextMatrix(Table1.RowSel, 7)) = "" Then
            MsgBox "¡ Al seleccionar custodia DCV, debe ingresar una clave. !", vbExclamation, TITSISTEMA
            If Table1.Enabled = True Then: Table1.SetFocus
            Exit Sub
        End If
        
        If glBacCpDvpCp = Si Then
            If Table1.Rows > 10 Then
                MsgBox "¡ No es posible agregar más de 10 documentos al utilizar pago DVP Combanc. !", vbExclamation, TITSISTEMA
                If Table1.Enabled = True Then: Table1.SetFocus
                Exit Sub
            End If
        End If
   
        aux& = Table1.Row
        
        If Table1.Enabled = True Then: Table1.SetFocus 'probando1
        
        BacControlWindows 60
        Bac_SendKey vbKeyHome
      
        'ACAMODIF
        If Trim$(Table1.TextMatrix(Table1.Row, nCol_SERIE)) = "" Then
            MsgBox "Ingrese serie antes de insertar otra Fila", vbInformation, TITSISTEMA
            If Table1.Enabled = True Then: Table1.SetFocus
            Exit Sub
        End If
        'ACAMODIF

      ' VB+- 09/06/2000  se valida que no se pueda agregar otro registro si no tiene definido custodia
        If Trim$(Table1.TextMatrix(Table1.Row, nCol_CUST)) = "" Then
            MsgBox "Antes de agregar otro instrumento" & vbCrLf & vbCrLf & "debe definir custodia para instrumento", vbExclamation, TITSISTEMA
            If Table1.Enabled = True Then: Table1.SetFocus
            On Error GoTo 0
            Exit Sub
        Else
            Data1.Refresh
            BacControlWindows 60

            If Trim$(Table1.TextMatrix(Table1.Row, nCol_UM) <> "" And Table1.TextMatrix(Table1.Row, nCol_TIR) <> 0 And Val(Table1.TextMatrix(Table1.Row, nCol_VPS))) <> 0 Then
                BacControlWindows 60
                Call CP_Agregar(hWnd, Data1)
                TxtTotal.Enabled = False
                Toolbar1.Buttons(2).Enabled = False
                Table1.Col = nCol_SERIE
            Else
                If Trim$(Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" And Val(Table1.TextMatrix(Table1.Row, nCol_VPS))) <> 0 Then
                    BacControlWindows 60
                    Call CP_Agregar(hWnd, Data1)
                    TxtTotal.Enabled = False
                    Toolbar1.Buttons(2).Enabled = False
                    Table1.Col = nCol_SERIE
                Else
                    Table1.Row = aux&
                End If
            End If
        End If

        Table1.Rows = Table1.Rows + 1
        Table1.Row = Table1.Rows - 1
      
        Call Limpia_grilla
        If KeyCode = vbKeyInsert Then
            Table1.TextMatrix(Table1.Row, nCol_CDCV) = FUNC_GENERA_CLAVE_DCV
        End If
        Table1.Col = nCol_SERIE
        Table1.ColSel = nCol_SERIE
    ElseIf KeyCode = vbKeyUp Then
        If Trim$(Table1.TextMatrix(Table1.Row, nCol_SERIE)) = "" Then
            BacControlWindows 60
            If Data1.Recordset.RecordCount > 1 Then
                Call CP_Eliminar(Data1)
                Data1.Refresh
                TxtTotal.text = CP_SumarTotal(FormHandle)

              ' VB+ 02/03/2000 es para habilitar o desabilitar botones
              ' ===========================================================
                If Len(Data1.Recordset("tm_instser")) <> 0 And Toolbar1.Buttons(3).Enabled = False Then
                    Toolbar1.Buttons(3).Enabled = True
                End If
                If Data1.Recordset("tm_nominal") <> 0 And Toolbar1.Buttons(4).Enabled = False Then
                   Toolbar1.Buttons(4).Enabled = True
                End If
                If Data1.Recordset("tm_mt") <> 0 Then
                   TxtTotal.Enabled = True
                   Toolbar1.Buttons(2).Enabled = True
                Else
                   TxtTotal.Enabled = False
                   Toolbar1.Buttons(2).Enabled = False
                End If
              ' ===========================================================
              ' VB- 02/03/2000
            End If
        End If
    ElseIf KeyCode = vbKeyDelete Then
        If Not Data1.Recordset.RecordCount = 1 Then
            Call Colocardata1
        Else
            Data1.Recordset.MoveFirst
        End If

      Call CP_Eliminar(Data1)

      If Not Table1.Rows = 2 Then
         Table1.RemoveItem Table1.Row
         Table1.Col = nCol_SERIE
         Table1.ColSel = nCol_SERIE

      Else
         Table1.TextMatrix(1, 0) = ""
         Table1.TextMatrix(1, 1) = ""
         Limpia_grilla

      End If

      
      Table1.Refresh
      Data1.Refresh
      TxtTotal.text = CP_SumarTotal(FormHandle)

      ' VB+ 02/03/2000 es para habilitar o desabilitar botones
      ' ===========================================================
      If Len(Data1.Recordset("tm_instser")) <> 0 And Toolbar1.Buttons(3).Enabled = False Then
         Toolbar1.Buttons(3).Enabled = True

      End If

      If Data1.Recordset("tm_nominal") <> 0 And Toolbar1.Buttons(4).Enabled = False Then
         Toolbar1.Buttons(4).Enabled = True

      End If

      If Data1.Recordset("tm_mt") <> 0 Then
         TxtTotal.Enabled = True
         Toolbar1.Buttons(2).Enabled = True

      Else
         TxtTotal.Enabled = False
         Toolbar1.Buttons(2).Enabled = False

      End If
      ' ===========================================================
      ' VB- 02/03/2000

   End If

   On Error GoTo 0
   Exit Sub

KeyDownError:
   On Error GoTo 0
   MsgBox "Problemas en tabla de ingreso de datos: " & err.Description, vbExclamation, gsBac_Version
   Data1.Refresh
   Exit Sub

End Sub
Private Sub Table1_KeyPress(KeyAscii As Integer)
If tipopapel = "Manual" Then
   Dim indice, Indice1 As Integer
   Dim Letra, letra1 As String

   If Termino_Carga = "SI" Then Exit Sub
      
    ' -------------------------------------------------------------------------------------------------------------------
    ' +++ VFBF 20180619 VALIDACION DE LA CUSTODIA PARA OPERACIONES T+2
    ' -------------------------------------------------------------------------------------------------------------------
    If Table1.Col = nCol_CUST Then
        If Me.TipoPago.ListIndex = 2 Then
            If UCase$(Chr(KeyAscii)) = "C" Or UCase$(Chr(KeyAscii)) = "P" Then
                MsgBox "Para operaciones T+2 (Contado Normal) la custodia valida solo es DCV", vbExclamation, TITSISTEMA
                Combo1.text = "DCV"
                If Table1.Enabled = True Then: Table1.SetFocus
                On Error GoTo 0
                Exit Sub
            End If
        End If
    End If
  ' -------------------------------------------------------------------------------------------------------------------
  ' --- VFBF 20180619 VALIDACION DE LA CUSTODIA PARA OPERACIONES T+2
  ' -------------------------------------------------------------------------------------------------------------------
      
      
   If Table1.Col = nCol_SERIE Then
      BacControlWindows 100
      Text1.Enabled = True
      Text1.Visible = True

      If KeyAscii <> vbKeyReturn Then
         Text1.text = UCase(Chr(KeyAscii))
      Else
         Text1.text = Trim(Table1.TextMatrix(Table1.Row, Table1.Col))
      End If

      Text1.MaxLength = 12
      Text1.SetFocus
      BacControlWindows 100
      Exit Sub
   End If

   If Table1.Col = nCol_CDCV And Trim(Table1.TextMatrix(Table1.Row, nCol_CDCV)) = "DCV" Then 'Or Table1.Col = 0 Then
      
      If Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" Then
          Text1.Enabled = False
          Exit Sub
      Else
          Text1.Enabled = True
          BacControlWindows 100
          Text1.text = Trim(Table1.TextMatrix(Table1.Row, Table1.Col))
          Text1.Visible = True
          Text1.MaxLength = 9
    
          If KeyAscii <> vbKeyReturn Then
             Text1.text = UCase(Chr(KeyAscii))
          Else
             Text1.text = Trim(Table1.TextMatrix(Table1.Row, Table1.Col))
          End If
    
          Text1.SetFocus
          BacControlWindows 100
          Exit Sub
       End If
   End If

   If Table1.Col = nCol_CUST Then
   
     ' -------------------------------------------------------------------------------------------------------------------
     ' +++ VFBF 20180619 VALIDACION DE LA CUSTODIA PARA OPERACIONES T+2
     ' -------------------------------------------------------------------------------------------------------------------
      If Me.TipoPago.ListIndex = 2 Then
         Combo1.text = "DCV"
      End If
     ' -------------------------------------------------------------------------------------------------------------------
     ' --- VFBF 20180619 VALIDACION DE LA CUSTODIA PARA OPERACIONES T+2
     ' -------------------------------------------------------------------------------------------------------------------
      
      If Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" Then
         Combo1.text = "DCV"
      Else
        If glBacCpDvpCp = No Then
           If KeyAscii = 80 Or KeyAscii = 112 Then
              Combo1.ListIndex = 2
           ElseIf KeyAscii = 68 Or KeyAscii = 100 Then
              Combo1.ListIndex = 1
           ElseIf KeyAscii = 67 Or KeyAscii = 99 Then
              Combo1.ListIndex = 0
           End If
        Else
           Combo1.ListIndex = 0
        End If
        
        
        
        If UCase(Chr(KeyAscii)) = "C" Or UCase(Chr(KeyAscii)) = "D" Or UCase(Chr(KeyAscii)) = "P" Or KeyAscii = vbKeyReturn Then
           Table1.Col = nCol_CUST
           
           Call PROC_POSI_TEXTO(Table1, Combo1)
           
           Combo1.Visible = True
           Combo1.SetFocus
        End If
        BacControlWindows 100
      End If

      Exit Sub
   End If
   
   If Table1.Col = nCol_TCSP Then
      Call PROC_POSI_TEXTO(Table1, cboCarteraSuper)
      cboCarteraSuper.Visible = True
      cboCarteraSuper.SetFocus
      Exit Sub
   End If
   
   Call FUNC_Decimales_de_Moneda(Table1.TextMatrix(Table1.Row, nCol_UM))
  
''''   If Table1.Col < nCol_CUST And Table1.Col <> nCol_UM And Table1.Col <> nCol_SERIE Then
   If Table1.Col <> nCol_SERIE And _
      Table1.Col <> nCol_UM And _
      Table1.Col <> nCol_CUST And _
      Table1.Col <> nCol_CDCV And _
      Table1.Col <> nCol_UTIL And _
      Table1.Col <> nCol_TCSP And _
      Table1.Col <> nCol_DifTran_CLP And _
      Table1.Col <> nCol_EMISOR Then

        
        If Table1.Col = nCol_TIR And Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" Then
          TEXT2.Enabled = False
          Combo1.ListIndex = 1
          Combo1.Enabled = False
          Exit Sub
        Else
          TEXT2.Enabled = True
          Combo1.Enabled = True
          If Table1.Col = nCol_NOMINAL Then
          TEXT2.text = BacCtrlTransMonto(CDbl(Table1.TextMatrix(Table1.Row, Table1.Col)))
          End If
          
          If Table1.Col = nCol_VPS Or Table1.Col = nCol_VPTRAN Then
            If Table1.TextMatrix(Table1.Row, nCol_UM) = "USD" Then
                TEXT2.CantidadDecimales = 2 'gsMONEDA_Decimales '-->Se cambia a 4 decimales ya que el usuario no podia ingresar decimales.
               Else
                TEXT2.CantidadDecimales = gsMONEDA_Decimales
            End If
          Else
              If Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" Then
                If Table1.TextMatrix(Table1.Row, nCol_UM) = "CLP" Then
                   If Table1.Col = nCol_VPAR Then
                      TEXT2.CantidadDecimales = 4
                   Else
                      TEXT2.CantidadDecimales = 4 '--> 0
                   End If
                Else
                   TEXT2.CantidadDecimales = 4
                End If
              Else
                If bFlagDpx Then
                    TEXT2.CantidadDecimales = 2
                Else
                    TEXT2.CantidadDecimales = 4
                End If
              End If
           End If
           TEXT2.Visible = True
           If KeyAscii > 47 And KeyAscii < 58 Then TEXT2.text = Chr(KeyAscii)
              TEXT2.SetFocus
          Exit Sub
        End If
   End If

   BacToUCase KeyAscii

   If Table1.Col = nCol_CDCV Then
      If IsNull(Table1.TextMatrix(Table1.Row, nCol_CUST)) Or Trim$(Table1.TextMatrix(Table1.Row, nCol_CUST)) <> "DCV" Then
         KeyAscii = 0
      End If
   End If

   If Table1.Col = nCol_CUST Then
  ' -------------------------------------------------------------------------------------------------------------------
  ' +++ VFBF 20180619 VALIDACION DE LA CUSTODIA PARA OPERACIONES T+2
  ' -------------------------------------------------------------------------------------------------------------------
    If Me.TipoPago.ListIndex = 2 Then
        If UCase$(Chr(KeyAscii)) = "C" Or UCase$(Chr(KeyAscii)) = "P" Then
            MsgBox "Para operaciones T+2 (Contado Normal) la custodia valida solo es DCV", vbExclamation, TITSISTEMA
            If Table1.Enabled = True Then: Table1.SetFocus
            On Error GoTo 0
            Exit Sub
        End If
    End If
  ' -------------------------------------------------------------------------------------------------------------------
  ' ---- VFBF 20180619 VALIDACION DE LA CUSTODIA PARA OPERACIONES T+2
  ' -------------------------------------------------------------------------------------------------------------------

      If Not Data1.Recordset.RecordCount = 1 Then
         Call Colocardata1
      Else
         Data1.Recordset.MoveFirst
      End If

      Data1.Recordset.Edit

      Select Case UCase$(Chr(KeyAscii))
      Case "C":
         Data1.Recordset("tm_custodia") = "CLIENTE"
         Data1.Recordset("tm_clave_dcv") = " "
         KeyAscii = vbKeyReturn

      Case "D":
         If Not IsNull(Data1.Recordset("tm_custodia")) Then
            If Trim$(Data1.Recordset("tm_custodia")) <> "DCV" Then
               Data1.Recordset("tm_custodia") = "DCV"
               KeyAscii = vbKeyReturn
            Else
               KeyAscii = 0
            End If
         Else
            Data1.Recordset("tm_custodia") = "DCV"
            KeyAscii = vbKeyReturn
         End If

      Case "P":
         Data1.Recordset("tm_custodia") = "PROPIA"
         Data1.Recordset("tm_clave_dcv") = " "
         KeyAscii = vbKeyReturn
      Case Else
         KeyAscii = 0
      End Select

      Data1.Recordset.Update
   End If

   If Table1.Col > nCol_SERIE Then
      If Len(Trim$(Table1.TextMatrix(Table1.Row, nCol_SERIE))) = 0 Then
         KeyAscii = 0
      End If
   End If

   If KeyAscii = 27 Then iFlagKeyDown = True

   Select Case Table1.Col
    
    Case nCol_NOMINAL, nCol_VPS
      If KeyAscii <> 27 Then
         If Not iFlagKeyDown Then
            KeyAscii = BacPunto(Table1, KeyAscii, 12, 4)
         End If

         KeyAscii = BACValIngNumGrid(KeyAscii)

      End If

    Case nCol_TIR, nCol_VPAR
      If KeyAscii <> 27 Then
         If Not iFlagKeyDown Then
            KeyAscii = BacPunto(Table1, KeyAscii, 3, 4)
         End If

         KeyAscii = BACValIngNumGrid(KeyAscii)
      End If
   End Select
   
Else

    'Select Case Grid_CostoComx.Col
    Select Case Table1.Col
        Case 6: Exit Sub
   End Select
 
If tipopapel = "Automatica" Then
Table1.Col = 13
    If Table1.Col = nCol_TCSP Then
      Call PROC_POSI_TEXTO(Table1, cboCarteraSuper)
      cboCarteraSuper.Visible = True
      cboCarteraSuper.SetFocus
      Exit Sub
  End If
End If

End If
End Sub

Private Sub Table1_LeaveCell()
    If Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" Then
        Me.Combo1.Enabled = False
    Else
        Me.Combo1.Enabled = True
    End If
   If Termino_Carga = "SI" Then
      Exit Sub
   End If

  'Table1.CellBackColor = &H8000000F

End Sub

Private Sub Table1_Scroll()
If Termino_Carga = "SI" Then Exit Sub
    Me.Combo1.Visible = False
    Me.Text1.Visible = False
    Me.TEXT2.Visible = False
End Sub

Private Sub Table1_SelChange()
If Termino_Carga = "SI" Then Exit Sub
  'Table1.CellBackColor = &H808000
   Text1.Font.bold = True

End Sub

Private Sub Text1_GotFocus()

   Call PROC_POSI_TEXTO(Table1, Text1)
   Text1.SelStart = Len(Text1)

End Sub
Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)
   On Error GoTo ExitEditError

   Dim Cota_SUP         As Double
   Dim Cota_INF         As Double
   Dim Porcentaje       As Double
   Dim Nominal          As Double
   Dim Col              As Integer
   Dim Value            As String
   Dim CorteMin#
   Dim iOK%
   Dim Columna%
   Dim LeeEmi$
   Dim nFilaValida      As Integer
   Dim cFormato         As String
   
   Dim dPlazo           As Long     '-> As Integer
   
   If KeyCode = vbKeyEscape Then
      Let Text1.text = ""
      Let Text1.Visible = False
   End If
   
   Antes_Flag = True
   tipo = "CP"
    
   If Table1.Col = nCol_NOMINAL Then
      bufNominal = Table1.TextMatrix(Table1.Row, nCol_VPAR)
   End If
    
   If KeyCode = vbKeyReturn Then
   
    
    Me.TipoPago.Enabled = False
    
      If Table1.Col = nCol_SERIE Then
         If Not Validar_SerieFM(Text1.text) Then
            MsgBox "Serie ingresada no corresponde"
            Exit Sub
         End If
         If Not bFlagDpx Then
            Table1.ColWidth(3) = 900
            If Text1.text = "FMUTUO" Then
               Table1.ColWidth(3) = 1800
           'ElseIf Mid$(Text1.Text, 1, 3) = "DPX" Then
           '   MsgBox "PAPEL NO VALIDO", vbExclamation, Me.Caption
           '   Text1.SetFocus
           '   Exit Sub
            End If
         Else
            If Mid$(Text1.text, 1, 3) <> "DPX" Then
               MsgBox "PAPEL NO VALIDO", vbExclamation, Me.Caption
               Text1.SetFocus
               Exit Sub
            End If
         End If
      End If

      If Not Data1.Recordset.RecordCount = 1 Then
         Call Colocardata1
      Else
         Data1.Recordset.MoveFirst
      End If

      If Table1.Col <> nCol_CDCV And Table1.Col <> nCol_SERIE Then
         Value = CDec(TEXT2.text)
      End If

      Col% = Table1.Col

      If (Col% > nCol_UM And Col% < nCol_CUST) Or (Col% > nCol_CDCV And Col% < nCol_UTIL) Then
         If IsNumeric(Value) = False Then
            iFlagKeyDown = False
            Text1.Visible = False
            If Table1.Enabled = True Then
               Table1.SetFocus
            End If
            Exit Sub
         End If
      End If

      Select Case Col%
      
         Case nCol_SERIE:
            Value = Text1.text
            
            iOK = CP_ChkSerie(Value, Data1)
            If iOK = False Then
               Exit Sub
               iFlagKeyDown = False
            Else
               Data1.Recordset.Edit
               Data1.Recordset!TM_INSTSER = Text1.text
               Data1.Recordset!tm_custodia = "DCV"
               Data1.Recordset!tm_carterasuper = IIf(cboCarteraSuper.ListCount = 0, 0, Trim(Right(cboCarteraSuper.text, 10)))
               Table1.TextMatrix(Table1.Row, nCol_CUST) = "DCV"
               Data1.Recordset.Update
               Call Limpia_grilla
               Columna = Table1.Col
               Data1.Recordset.Edit
               LeeEmi$ = Data1.Recordset("tm_leeemi")
               SwEmision = True
               
               If InStr("S", LeeEmi$) Then
                  SwEmision = False
                  Call Func_Emision
               End If
               Text1.text = Value
               Call Limpia_grilla
               
               
                If Me.TipoPago.ListIndex = 2 Then
                    Data1.Recordset.Edit
                    Data1.Recordset!tm_custodia = "DCV"
                    Table1.TextMatrix(Table1.Row, nCol_CUST) = "DCV"
                    Data1.Recordset.Update
                End If
               
            End If
            
            GoTo ClaveDCV:
Serie:
            Table1.Col = Col%
            Table1.TextMatrix(Table1.Row, Table1.Col) = Trim(Text1.text)

         Case nCol_NOMINAL:
            If CDbl(Value) < 0 Or Len(Value) > 22 Then
               MsgBox "Nominal ingresado NO es valido.", 16, gsBac_Version
               Value = 0
               Exit Sub
            End If
            
            Data1.Recordset.Edit
            CorteMin# = Data1.Recordset("tm_cortemin")
            
            If Not IsNumeric(Value) Then
               Value = 0
            End If
            
            Nominal# = CDbl(Value)
            
            If CO_ChkCortes((Nominal#), CorteMin#) = False Then
               TEXT2.text = CorteMin#
               If Table1.Enabled = True Then
                  Table1.SetFocus
               End If
            End If

            Table1.TextMatrix(Table1.Row, Table1.Col) = Format(TEXT2.text, "#,##0." & String(gsMONEDA_Decimales, "0"))
            Data1.Recordset("tm_nominal") = TEXT2.text
            
            If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
               Data1.Recordset!TM_MT = Data1.Recordset!TM_TIR * CDbl(TEXT2.text)
               Data1.Recordset.Update
            Else
               Data1.Recordset.Update
               
               If Val(Table1.TextMatrix(Table1.Row, nCol_TIR)) <> 0 Then
                  Call CPCI_Valorizar(2, Data1, FechaPago.text)
               ElseIf Val(Table1.TextMatrix(Table1.Row, nCol_VPAR)) <> 0 Then
                  Call CPCI_Valorizar(1, Data1, FechaPago.text)
               ElseIf Val(Table1.TextMatrix(Table1.Row, nCol_VPS)) <> 0 Then
                  Call CPCI_Valorizar(3, Data1, FechaPago.text)
               End If
               
               If Val(Table1.TextMatrix(Table1.Row, nCol_TTRAN)) <> 0 Then
                  Call CPCI_Valorizar(2, Data1, FechaPago.text, "TRAN")
               ElseIf Val(Table1.TextMatrix(Table1.Row, nCol_PTRAN)) <> 0 Then
                  Call CPCI_Valorizar(1, Data1, FechaPago.text, "TRAN")
               ElseIf Val(Table1.TextMatrix(Table1.Row, nCol_VPTRAN)) <> 0 Then
                  Call CPCI_Valorizar(3, Data1, FechaPago.text, "TRAN")
               End If
               
               
               'Si cambia el nominal Elimino los cortes y valorizo a mercado
               If BacFormatoSQL(bufNominal) <> BacFormatoSQL(Table1.TextMatrix(Table1.Row, nCol_NOMINAL)) Then
                  Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlativo"))
               End If
            End If
         
         Case nCol_CDCV:
ClaveDCV:
            nFilaValida = Table1.Row
            If Col% = nCol_CDCV And Trim(Text1.text) <> "" Then
               If FUNC_VALIDA_CLAVE_DCV_DIARIA(Table1, nFilaValida, nCol_CDCV, IIf(Col% = nCol_SERIE, Trim(Table1.TextMatrix(Table1.Row, nCol_CDCV)), Trim(Text1.text))) Then
                  Table1.Row = nFilaValida
                  Table1.Col = nCol_CDCV
                  Value = Text1.text
               Else
                  Value = ""
                  Text1.text = Trim(Table1.TextMatrix(Table1.Row, nCol_CDCV))
               End If
            End If
            Data1.Recordset.Edit
            Data1.Recordset!tm_clave_dcv = IIf((Col% = nCol_SERIE), Trim(Table1.TextMatrix(Table1.Row, nCol_CDCV)), Text1.text)
            Data1.Recordset.Update
            If Col% <> nCol_SERIE Then
               Table1.TextMatrix(Table1.Row, Table1.Col) = Text1.text
            ElseIf Col% = nCol_SERIE Then
               GoTo Serie:
            End If
            
        Case nCol_TIR:
            Data1.Recordset.Edit
            If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
               Data1.Recordset!TM_TIR = CDbl(TEXT2.text)
               If CDbl(TEXT2.text) <> 0 Then
                  Data1.Recordset!tm_nominal = Data1.Recordset!TM_MT / CDbl(TEXT2.text)
               End If
               Data1.Recordset.Update
            Else
               Data1.Recordset!TM_TIR = TEXT2.text
               Data1.Recordset.Update
               Call CPCI_Valorizar(2, Data1, FechaPago.text)
               'Aqui agregar el control
               dPlazo = DateDiff("D", FechaPago.text, CDate(Data1.Recordset("tm_fecven")))
               
               'Como aun no conozco al cliente...
               Ctrlpt_RutCliente = "0"
               Ctrlpt_CodCliente = "0"

               If ControlPreciosTasas("CP", Data1.Recordset("tm_codigo"), dPlazo, TEXT2.text) = "S" Then
                If Ctrlpt_ModoOperacion <> "S" Then 'PRD-3860, modo silencioso
                    MsgBox Ctrlpt_Mensaje, vbExclamation, TITSISTEMA
                    Table1.SetFocus
               End If
               End If
            End If
            
            '-->  Copia los valores a las columnas de Precio. Trasnferencia
            Data1.Recordset.Edit
            Data1.Recordset!tm_pvpmcd = Data1.Recordset("tm_pvp")
            Data1.Recordset!tm_tirmcd = Data1.Recordset("tm_tir")
            Data1.Recordset!tm_mtmcd = Data1.Recordset("tm_mt")
            Data1.Recordset!tm_VPTRANMO = Data1.Recordset("tm_VPMo")
            Data1.Recordset.Update
            '-->  Copia los valores a las columnas de Precio. Trasnferencia
            
        Case nCol_TTRAN:
            Data1.Recordset.Edit
            If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
               Data1.Recordset!tm_tirmcd = CDbl(TEXT2.text)
               If CDbl(TEXT2.text) <> 0 Then
                  Data1.Recordset!tm_nominal = Data1.Recordset!tm_mtmcd / CDbl(TEXT2.text)
               End If
               Data1.Recordset.Update
            Else
               Data1.Recordset!tm_tirmcd = TEXT2.text
               Data1.Recordset.Update
               
               Call CPCI_Valorizar(2, Data1, FechaPago.text, "TRAN")
            End If
            
        Case nCol_VPAR
            Data1.Recordset.Edit
            If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
               Data1.Recordset!TM_Pvp = 0
               Data1.Recordset.Update
            Else
               Data1.Recordset!TM_Pvp = TEXT2.text
               Data1.Recordset.Update
               Call CPCI_Valorizar(1, Data1, FechaPago.text)
               If Not Antes_Flag Then
                  Table1.TextMatrix(Table1.Row, Table1.Col) = Antes
                  Data1.Recordset.Edit
                  Data1.Recordset!TM_Pvp = Antes
                  Data1.Recordset.Update
               End If
            End If
            '-->  Copia los valores a las columnas de Precio. Trasnferencia
            Data1.Recordset.Edit
            Data1.Recordset!tm_pvpmcd = Data1.Recordset("tm_pvp")
            Data1.Recordset!tm_tirmcd = Data1.Recordset("tm_tir")
            Data1.Recordset!tm_mtmcd = Data1.Recordset("tm_mt")
            Data1.Recordset!tm_VPTRANMO = Data1.Recordset("tm_VPMo")
            Data1.Recordset.Update
            '-->  Copia los valores a las columnas de Precio. Trasnferencia
        
        Case nCol_PTRAN
            Data1.Recordset.Edit
            If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
               Data1.Recordset!tm_pvpmcd = 0
               Data1.Recordset.Update
            Else
               Data1.Recordset!tm_pvpmcd = TEXT2.text
               Data1.Recordset.Update
               
               Call CPCI_Valorizar(1, Data1, FechaPago.text, "TRAN")
               
               If Not Antes_Flag Then
                  Table1.TextMatrix(Table1.Row, Table1.Col) = Antes
                  Data1.Recordset.Edit
                  Data1.Recordset!tm_pvpmcd = Antes
                  Data1.Recordset.Update
               End If
            End If
            
        Case nCol_VPS:
            If CDbl(Value) < 0 Or Len(Value) > 16 Then
               MsgBox "Valor presente ingresado NO es valido.", 16, gsBac_Version
               Value = 0
               If Table1.Enabled = True Then
                  Table1.SetFocus
               End If
               Exit Sub
            End If
            Data1.Recordset.Edit
            
            If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
               Data1.Recordset!TM_MT = CDbl(TEXT2.text)
               If Data1.Recordset!TM_TIR <> 0 Then
                  Data1.Recordset!tm_nominal = CDbl(TEXT2.text) / Data1.Recordset!TM_TIR
               End If
               Data1.Recordset.Update
            Else
               Data1.Recordset!TM_MT = TEXT2.text
               Data1.Recordset.Update
               Call CPCI_Valorizar(3, Data1, FechaPago.text)
               
               If Not Antes_Flag Then
                  Table1.TextMatrix(Table1.Row, Table1.Col) = Antes
                  Data1.Recordset.Edit
                  Data1.Recordset!TM_MT = Antes
                  Data1.Recordset.Update
               End If
            End If
            
            '-->  Copia los valores a las columnas de Precio. Trasnferencia
            Data1.Recordset.Edit
            Data1.Recordset!tm_pvpmcd = Data1.Recordset("tm_pvp")
            Data1.Recordset!tm_tirmcd = Data1.Recordset("tm_tir")
            Data1.Recordset!tm_mtmcd = Data1.Recordset("tm_mt")
            Data1.Recordset!tm_VPTRANMO = Data1.Recordset("tm_VPMo")
            Data1.Recordset.Update
            '-->  Copia los valores a las columnas de Precio. Trasnferencia
            
        Case nCol_VPTRAN:
            If CDbl(Value) < 0 Or Len(Value) > 16 Then
                MsgBox "Valor presente ingresado NO es valido.", vbExclamation, gsBac_Version
                Value = 0
                If Table1.Enabled = True Then
                    Table1.SetFocus
                End If
                Exit Sub
            End If
            Data1.Recordset.Edit
            'SE REUTILIZAN VARIABLES EXSISTENTES PARA VALORES DE TRANSACCION
            If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
                Data1.Recordset!tm_mtmcd = CDbl(TEXT2.text)
                If Data1.Recordset!tm_tirmcd <> 0 Then
                   Data1.Recordset!tm_nominal = CDbl(TEXT2.text) / Data1.Recordset!tm_tirmcd
                End If
                Data1.Recordset.Update
            Else
                Data1.Recordset!tm_mtmcd = TEXT2.text
                Data1.Recordset.Update
                
                Call CPCI_Valorizar(3, Data1, FechaPago.text, "TRAN")
                
                If Not Antes_Flag Then
                   Table1.TextMatrix(Table1.Row, Table1.Col) = Antes
                   Data1.Recordset.Edit
                   Data1.Recordset!tm_mtmcd = Antes
                   Data1.Recordset.Update
                End If
            End If
      End Select
      
      If Table1.Col <> nCol_SERIE And Table1.Col <> nCol_CDCV Then
         If Mid(Trim(Data1.Recordset!TM_INSTSER), 1, 6) = "FMUTUO" Then
            cFormato = "#,##0." & String(4, "0")
            ''''Table1.TextMatrix(Table1.Row, Table1.Col) = Format(TEXT2.Text, "#,##0." & String(4, "0"))
            Table1.TextMatrix(Table1.Row, Table1.Col) = Format(TEXT2.text, cFormato)
         Else
            cFormato = "#,##0." & String(gsMONEDA_Decimales, "0")
            ''''Table1.TextMatrix(Table1.Row, Table1.Col) = Format(TEXT2.Text, "#,##0." & String(gsMONEDA_Decimales, "0"))
            Table1.TextMatrix(Table1.Row, Table1.Col) = Format(TEXT2.text, cFormato)
         End If
      End If
      
      Columna = Table1.Col
      BacControlWindows 20
      
      If Columna > nCol_UM And Columna < nCol_CUST Then
         Call ChkMoneda(Columna%)
         BacControlWindows 12
         TxtTotal.text = BacCtrlTransMonto(CP_SumarTotal(FormHandle))
      End If

      iFlagKeyDown = True

      If Columna = nCol_SERIE Then
         Table1.Col = Columna + 2
      ElseIf Columna = nCol_NOMINAL Then
        
         If Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" Then
             Table1.Col = Columna + 2
         Else
            Table1.Col = Columna + 1
         End If

      ElseIf Columna = nCol_TIR Or Columna = nCol_VPAR Or Columna = nCol_VPS Then
         Table1.Col = nCol_CUST
      End If

      If Len(Data1.Recordset("tm_instser")) <> 0 And Toolbar1.Buttons(3).Enabled = False Then
         Toolbar1.Buttons(3).Enabled = True
      End If

      If Data1.Recordset("tm_nominal") <> 0 And Toolbar1.Buttons(4).Enabled = False Then
         Toolbar1.Buttons(4).Enabled = True
      End If

      If Data1.Recordset("tm_mt") <> 0 Then
         TxtTotal.Enabled = True
         Toolbar1.Buttons(2).Enabled = True
      Else
         TxtTotal.Enabled = False
         Toolbar1.Buttons(2).Enabled = False
      End If

      Text1.text = ""
      
      Text1.Visible = False
      TEXT2.text = 0
      TEXT2.Visible = False

      If Table1.Col <> nCol_NOMINAL Then
         Llena_Grilla
                
        If Table1.Col = nCol_TTRAN Or Table1.Col = nCol_PTRAN Or Table1.Col = nCol_VPTRAN Then
            If Not Proc_Valida_Tasa_Transferencia(Table1.TextMatrix(Table1.Row, nCol_TIR), Table1.TextMatrix(Table1.Row, nCol_TTRAN)) Then
                Table1.Col = nCol_TTRAN
                Table1.SetFocus
            End If
        End If
      Else
         Table1.TextMatrix(Table1.Row, nCol_UM) = Data1.Recordset!TM_NEMMON
         Limpia_grilla
      End If
   End If
   
             Table1.TextMatrix(Table1.Row, nCol_CORR) = Data1.Recordset!tm_genemi
             Table1.TextMatrix(Table1.Row, 15) = Data1.Recordset!tm_rutemi

   On Error GoTo 0

Exit Sub
ExitEditError:
   On Error GoTo 0
   iFlagKeyDown = True
   Table1.Row = Table1.Rows - 1
   Table1.TextMatrix(Table1.Row, nCol_TIR) = Format(Monto, "###,###,###,##0.0000")
 If Text1.text <> "" Then
   Table1.TextMatrix(Table1.Row, nCol_SERIE) = Text1.text
   'Text1.Visible = False
 End If
End Sub


Private Sub Text1_KeyPress(KeyAscii As Integer)

   KeyAscii = Asc(UCase(Chr(KeyAscii)))
   SwEmision = True

End Sub

Private Sub Text1_LostFocus()

   Text1.text = ""
   Text1.Visible = False

   If SwEmision Then
      If Table1.Enabled = True Then: Table1.SetFocus
   End If

End Sub

Private Sub Text2_GotFocus()

   If Table1.TextMatrix(Table1.Row, Table1.Col) = "" Then
            TEXT2.Visible = False
            Exit Sub
   End If
   
   Call PROC_POSI_TEXTO(Table1, TEXT2)
      
   If Table1.Col = nCol_VPS Or Table1.Col = nCol_VPTRAN Then
     If TEXT2.CantidadDecimales <> 0 Then
        TEXT2.SelStart = Len(TEXT2.text) - (TEXT2.CantidadDecimales - 1)
        TEXT2.SelStart = Len(TEXT2.text) - 3
      Else
        TEXT2.SelStart = Len(TEXT2.text)
     End If
   Else
        If Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" Then
          If Table1.TextMatrix(Table1.Row, nCol_UM) = "CLP" Then
              If Table1.Col = nCol_VPAR Then
                 TEXT2.SelStart = Len(TEXT2.text) - 5
              Else
                 TEXT2.SelStart = Len(TEXT2.text)
              End If
          Else
              TEXT2.SelStart = Len(TEXT2.text) - 5
          End If
        Else
            If bFlagDpx Then
              TEXT2.SelStart = Len(TEXT2.text) - 3
            Else
              TEXT2.SelStart = Len(TEXT2.text) - 5
            End If
          End If
   End If

End Sub

Private Sub Text2_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyEscape Then
      TEXT2.text = ""
      TEXT2.Visible = False

   End If

   If KeyCode = vbKeyReturn Then
       Antes = Table1.TextMatrix(Table1.RowSel, Table1.ColSel)
      Table1.TextMatrix(Table1.RowSel, Table1.ColSel) = CDec(TEXT2.text)
      
      TEXT2.Visible = False
      
      Call Text2_LostFocus
      Call Text1_KeyDown(13, 1)

   End If

End Sub

Private Sub Text2_LostFocus()
   On Error Resume Next
   
   TEXT2.Visible = False
   If Table1.Enabled = True Then: Table1.SetFocus

End Sub

Private Sub TipoPago_Click()
   Dim nCont   As Integer
   Dim nSw     As Integer

   Select Case TipoPago.ListIndex
      Case Is = 0
         FechaPago.text = Format(gsBac_Fecp, "dd/mm/yyyy")
      Case Is = 1
         FechaPago.text = Format(gsBac_Fecx, "dd/mm/yyyy")
      Case Is = 2
         nSw = 0
         nCont = 1
         Do While nSw = 0
            FechaPago.text = Format$(DateAdd("d", nCont, gsBac_Fecx), "dd/mm/yyyy")
            If EsFeriado(CDate(FechaPago.text), "00001") Then
               nCont = nCont + 1
            Else
               nSw = 1
            End If
         Loop
         
         
      Case Else
         MsgBox "Problemas con el tipo de pago"
   End Select
   Let oTipoPago = TipoPago.ListIndex
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Dim Cont As Long
    
   Select Case UCase(Button.Description)
      Case "GRABAR"
         
          'LD1-COR-05 LIMITES ALCO
              '-------LIMITES-ALCO--9-NOV-2001
              Data1.Recordset.MoveFirst
              Cont = 1
              TOTAL_GRILLA_VALOR_PRESENTE = 0
              Total_Nominal = 0
        
              Series = Array()
              Montos_Series = Array()
              Nominal_Series = Array()
              Plazos = Array()
              Codigos = Array()
              Emisores = Array()
              Do
        
                    ReDim Preserve Series(Cont)
                    ReDim Preserve Montos_Series(Cont)
                    ReDim Preserve Nominal_Series(Cont)
                    ReDim Preserve Plazos(Cont)
                    ReDim Preserve Codigos(Cont)
                    ReDim Preserve Emisores(Cont)
                    
                    Emisores(Cont) = Data1.Recordset("tm_rutemi")
                    Codigos(Cont) = Data1.Recordset("tm_codigo")
                    Series(Cont) = Table1.TextMatrix(Cont, 0)
                    Montos_Series(Cont) = Table1.TextMatrix(Cont, 5)
                    Nominal_Series(Cont) = Table1.TextMatrix(Cont, 2)
                    Plazos(Cont) = PLAZO_PAPEL_TRADING(Table1.TextMatrix(Cont, 0))
                    Total_Nominal = Total_Nominal + Table1.TextMatrix(Cont, 2)
                    TOTAL_GRILLA_VALOR_PRESENTE = TOTAL_GRILLA_VALOR_PRESENTE + Table1.TextMatrix(Cont, 5)
                    Cont = Cont + 1
        
                Data1.Recordset.MoveNext
              Loop Until Data1.Recordset.EOF   ''Cont = Table1.Rows
            '-------LIMITES-ALCO--9-NOV-2001
            
         Let SwLimpia = True
         aGrabar = "Verdadero"
         Call Proc_Grabar
         
         If AutorizaVP = True Then
               Call Busca_Oper_MDDI
         End If
         Call Form_Activate
         
         Let SwLimpia = False
         
      Case "EMISION"
         Call Func_Emision
      Case "CORTES"
         Call Func_Cortes
      Case "LIMPIAR"
         Let SwLimpia = True
         Tipo_Carga = "MN"
         Termino_Carga = "NO"
         
         Call Form_Activate
         
         If Tipo_Carga = "AU" Then
            Me.Height = 9000
         Else
            'Me.Height = 5985
            Me.Height = 6200
         End If
         
         Call Func_Limpiar_Pantalla
         'Call Limpia_grilla

         If Table1.Rows > 2 Then
            Table1.RemoveItem Table1.Row
                     
         Else
            Table1.TextMatrix(1, 0) = ""
            Table1.TextMatrix(1, 1) = ""
            Table1.TextMatrix(1, 15) = ""
            
            
         End If
         Cuadrodvp.Enabled = True
         Me.OptDvp(0).Value = False
         Me.OptDvp(1).Value = False
         'Table1.Enabled = False
         Table1.Enabled = True
            
         Toolbar1.Buttons(2).Enabled = False
         Toolbar1.Buttons(3).Enabled = False
         Toolbar1.Buttons(4).Enabled = False
         Toolbar1.Buttons(6).Enabled = False
         Grid.Visible = False
         Grupo.Visible = False
         Errores.Visible = False
         Cmb_cargar.Visible = False
         
         'CmbLibro.ListIndex = -1
         CmbLibro.ListIndex = 0
         cboCarteraSuper.Visible = False
         'CmbLibro.Enabled = True
         CmbLibro.Enabled = False
         Let Table1.TextMatrix(Table1.RowSel, nCol_EMISOR) = ""
      
         Call Limpiar_Datos
         
      Case "ABRIR"
         Tipo_Carga = "AU"
         Call Proc_Carga_Grilla
      Case "SALIR"
         SW = 0
         Unload Me
      Case "CARGA TICKERS"
         Tipo_Carga = "AU"
         Call Form_Activate
         Call carga_ticker
   End Select
End Sub

Function Busca_Oper_MDDI()
On Error Resume Next
Dim Datos()
Dim datos1()
Dim i, SW        As Integer
Dim Mensaje      As String
Dim nContador    As Integer
Dim SQL        As String
Dim Rutcart   As String
Dim CdoCartSup As String
Dim SqlCad
Dim SumaTotal_Venta As Double
Dim SumaDif As Double
'Variables para control de Tasas y Precios
Dim ptPlazo             As Long     '-> As Integer
Dim ptTasa As Double
Dim ptInstr As String
Dim oMensaje   As String
Let oMensaje = ""

   Mensaje = ""
   nContador = 0
   
   If Data1.Recordset.RecordCount > 0 Then
         db.Execute "DELETE * FROM mdventa"
         Data1.Refresh
   End If
   
   'Envia = Array(gsNum_Oper)
   Envia = Array()
   AddParam Envia, gsNum_Oper
   AddParam Envia, gsBac_User
   If Not Bac_Sql_Execute("SP_BUSCA_OPER_MDDI", Envia) Then
      Exit Function
   Else
      
      Call VENTA_IniciarTx(hWnd, Data1, 0)
      Call VENTA_EliminarBloqueados(Data1, FormHandle)
      Call VENTA_BorrarTx(FormHandle)
            
      Do While Bac_SQL_Fetch(datos1())
         If datos1(12) <> "" Then
            Call VENTA_Agregar(Data1, datos1(), hWnd, "VP")
            Data1.Recordset.MoveLast
         End If
      Loop
   End If

   Let Tipo_Carga = "AU"
   
   Data1.Recordset.MoveFirst
         
   Do While Not Data1.Recordset.EOF
         If VENTA_VerDispon(FormHandle, Data1) Then
            If Data1.Recordset("tm_venta") = " " Or Data1.Recordset("tm_venta") = "*" Or Data1.Recordset("tm_venta") = "B" Then
               If VENTA_Bloquear(FormHandle, Data1) Then
                  Data1.Recordset.Edit
                  Data1.Recordset("tm_venta") = "V"

                  If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
                     Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
                  Else
                     Data1.Recordset("tm_clave_dcv") = ""
                  End If

                  Data1.Recordset.Update
                  'Aplicar Control de Precios y Tasas
                  ptPlazo = DateDiff("D", gsBac_Fecp, Data1.Recordset("tm_fecsal"))
                  'ptInstr = Data1.Recordset("tm_instser")
                   ptInstr = Data1.Recordset("tm_codigo")
                  ptTasa = Data1.Recordset("tm_tir")
               
                  'Como aun no conozco al cliente...
                  Ctrlpt_RutCliente = "0"
                  Ctrlpt_CodCliente = "0"

                  If ControlPreciosTasas("VP", ptInstr, ptPlazo, ptTasa) = "S" Then
                     If Ctrlpt_ModoOperacion <> "S" Then 'PRD-3860, modo silencioso
                       '-> Se Almacena el mensaje en otra variable para el despliege al final
                        Let oMensaje = Ctrlpt_Mensaje
                       'MsgBox Ctrlpt_Mensaje, vbExclamation, TITSISTEMA
                       'Table1.SetFocus
                     End If
                  End If
                  
                  'Table1.TextMatrix(Table1.Row, nColClaveDCV) = Data1.Recordset("tm_clave_dcv")
                  Call funcFindDatGralMoneda(Val(Data1.Recordset("tm_monemi")))
                  SwMx = BacDatGrMon.mnmx

               Call VENTA_Valorizar(2, Data1, FechaPago.text, "TRAN")   '-->  Call VENTA_Valorizar(2, Data1, FechaPago.Text, "TRAN")
               Call VENTA_Valorizar(3, Data1, FechaPago.text, "")       '-->  Call VENTA_Valorizar(2, Data1, FechaPago.Text, "")
               Else
                  Data1.Recordset.Edit
                  Data1.Recordset("tm_venta") = "*"
                  Data1.Recordset.Update
               End If
            End If
         End If
   
      Call VENTA_Valorizar(3, Data1, FechaPago.text)  '-> Call VENTA_Valorizar(2, Data1, FechaPago.Text)
      
         'TxtTotal.Text = VENTA_SumarTotal(FormHandle)
         SumaTotal_Venta = VENTA_SumarTotal(FormHandle)
         'Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")
         SumaDif = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")

         If CDbl(SumaDif) < 0 Then
             SumaDif = Format(Abs(CDbl(SumaDif)), "###,###,###,##0.00")
         End If
         
         Data1.Recordset.MoveNext
   Loop
 
   Call Genera_VP
   Call Valida_Montos_VP_Automatica
   
   '-> Se mueve el Mensaje del Control de Precios y Tasas... por motivos tecnicos
   If Len(oMensaje) > 0 Then
      'Call MsgBox(Ctrlpt_Mensaje, vbExclamation, TITSISTEMA)
      Call MsgBox(oMensaje, vbExclamation, TITSISTEMA)
   End If
                       

   
Exit Function
ErrFiltro:
    Table1.Redraw = True
    MsgBox "Problemas en filtro de cartera para ventas definitivas: " & err.Description
    Screen.MousePointer = vbDefault
    Exit Function
    
    
 
End Function

Function Genera_VP()
   
Dim dNumdocu#, i%
Dim dNumVVista#, dNumVVCom#
Dim nVista%, sObser1$, sObser2$, nI%, sObserv$
Dim Datos()
    Dim SQL As String
    Dim FecPaso$
    Dim auxUser As String
    Dim Mensaje_CPT As String
  'Dim NumDocu As Integer
  
If miSQL.SQL_Execute("SP_PARAMETROS_SISTEMA") = 0 Then
        If Bac_SQL_Fetch(Datos()) Then
            FecPaso$ = Datos(1)
        End If
    End If

    dNumdocu# = 0
    dNumVVista# = 0
    dNumVVCom# = 0
    nVista = 0
    
auxUser = gsBac_User    'Salvar el contenido del usuario actual (Digitador)

Me.Tag = "VP"

    Select Case Me.Tag

        Case "VP": dNumdocu# = GrabarVP()

    End Select
    
 


    If dNumdocu <> 0 Then
    
        '********** Linea -- Mkilo
        Dim Mensaje_Lin     As String
        Dim Mensaje_Lim     As String

        Mensaje_Lin = ""
        Mensaje_Lim = ""
         
        If gsBac_Lineas = "S" Then
        
            Mensaje_Lin = Lineas_Error("BTR", dNumdocu)
            Mensaje_Lim = Limites_Error("BTR", dNumdocu)
             
        End If
        '********** Fin
    
        'PRD-3860
        If Ctrlpt_ModoOperacion = "S" Then
            Mensaje_CPT = ""
        Else
            Mensaje_CPT = Ctrlpt_Mensaje
        End If
        
        If Trim(Mensaje_Lin) <> "" Then
            Mensaje_CPT = ""
        ElseIf Trim(Mensaje_CPT) <> "" Then
            Mensaje_CPT = vbCrLf & vbCrLf & Mensaje_CPT
        End If
        'fin PRD-3860
    
'        sObserv$ = IIf(Len(TxtObserv.Text) > 0, TxtObserv.Text, " ")
'        nI = Len(sObserv$)
'        nTope = IIf(nI > 70, 70, nI)
        
        
'        If Mid(RTrim(sObserv$), nTope, 1) <> " " And nI > nTope Then
'            Do While Mid(RTrim(sObserv$), nTope, 1) <> " "
'                nTope = nTope - 1
'            Loop
'            nTope = nTope - 1
'        End If
                
        'sObser1$ = RTrim(Mid(RTrim(sObserv$), 1, nTope))
        'sObser2$ = RTrim(Mid(RTrim(sObserv$), nTope + 2, Len(sObserv$) - nTope))
        
        '********** Linea -- Mkilo
        MsgBox "Venta Propia Automatica se genero y grabo correctamente " & vbCrLf & vbCrLf & "Número de Operación: " & dNumdocu & Mensaje_Lin & Mensaje_Lim & Mensaje_CPT, vbInformation, gsBac_Version

         Let gsNum_Oper = dNumdocu

   End If
   
End Function

Function Valida_Montos_VP_Automatica()
   Dim Datos()

        Envia = Array()
        AddParam Envia, gsNum_Oper
        'AddParam Envia, NumDocu
        If Not Bac_Sql_Execute("SP_VALIDA_MONTOS_VP_AUTOMATICA", Envia) Then
            'MsgBox "Sql-Server No Responde. Intentelo Nuevamente", 16, "BacTrader"
            Exit Function
        End If

End Function

Private Function FuncLeeDatosVentaDef(ByRef oCliente As Variant, ByRef oCodigo As Variant, ByRef oFpago As Variant)
   Dim SqlDatos()

   Let oCliente = 96665450:    Let oCodigo = 1:     Let oFpago = 0

   Envia = Array()
   If Not Bac_Sql_Execute("SP_SETTING_VENTA_AUTOMATICA") Then
      Exit Function
   End If
   If Bac_SQL_Fetch(SqlDatos()) Then
      Let oCliente = SqlDatos(1)
       Let oCodigo = SqlDatos(2)
        Let oFpago = SqlDatos(3)
   End If

End Function

Private Function GrabarVP()
   Dim TCart$, Mercado$, Sucursal$, AreaResponsable$
   Dim Fecha_PagoMañana$, Laminas$, Tipo_Inversion$
   Dim CodLibro$, CodCli&

   GrabarVP = 0
   
   Call FuncLeeDatosVentaDef(iRutCli&, CodCli&, iForPagI&)
                           'Fecha_PagoMañana$,
   GrabarVP = VPVI_GrabarTx(iRutCar&, _
                           TCart$, _
                           iForPagI&, _
                           sTipCus$, _
                           sRetiro$, _
                           sPagMan$, _
                           sObserv$, _
                           iRutCli&, _
                           CodCli&, _
                           BacFrmIRF, _
                           TCart$, _
                           Mercado$, _
                           Sucursal$, _
                           AreaResponsable$, _
                           gFecha_PagoMañana, _
                           Laminas$, _
                           Tipo_Inversion$)
    

End Function


Sub Proc_Carga_Grilla()
   On Error GoTo Error
    Dim xlApp      As EXCEL.Application
    Dim xlBook     As EXCEL.Workbook
    Dim xlSheet    As EXCEL.Worksheet
    Dim xRow       As Long
    
    On Error GoTo ErrHandler
    
    Commond.CancelError = True
    Commond.FileName = ""
    Commond.Filter = "Archivo Terminal Bolsa *.xls"
    Commond.DialogTitle = "Abrir Archivo Terminal Bolsa"
    Commond.ShowOpen

    If Dir(Commond.FileName) = "" Then
       MsgBox "Debe Seleccionar un Archivo Valido para Procesar", vbExclamation, TITSISTEMA
       Exit Sub
    End If
    
    If Tipo_Carga = "AU" Then
       Me.Height = 9000
    End If
    
    Screen.MousePointer = vbHourglass
   
    Set xlApp = CreateObject("Excel.Application")
    Set xlBook = xlApp.Workbooks.Open(Commond.FileName)
    Set xlSheet = xlBook.Worksheets(1)
    
    With Grid
        .Clear
        .cols = 9
        
        .TextMatrix(0, cSuma) = "Suma"
        .TextMatrix(0, cInstrumento) = "Instrumento"
        .TextMatrix(0, cCantidad) = "Cantidad"
        .TextMatrix(0, cTir) = "Tir"
        .TextMatrix(0, cPrecio) = "Precio"
        .TextMatrix(0, cMonto) = "Monto $"
        .TextMatrix(0, cCustodia) = "Custodia"
        .TextMatrix(0, cClave) = "Clave DCV"
        .TextMatrix(0, cCartera) = "Cartera"
        
        For xRow = 1 To xlSheet.Columns.End(xlDown).Row
            If xRow = .Rows Then .Rows = .Rows + 1
            If Trim(Func_Leer_Celda(xlSheet, "G" & LTrim(Str(1 + xRow)))) = "" Then Exit For
            .TextMatrix(xRow, cSuma) = ""
            .TextMatrix(xRow, cInstrumento) = Func_Leer_Celda(xlSheet, "G" & LTrim(Str(1 + xRow)))
            .TextMatrix(xRow, cCantidad) = Func_Leer_Celda(xlSheet, "J" & LTrim(Str(1 + xRow)))
            .TextMatrix(xRow, cTir) = Func_Leer_Celda(xlSheet, "L" & LTrim(Str(1 + xRow)))  ''Func_Leer_Celda(xlSheet, "M" & LTrim(Str(1 + xRow)))
            .TextMatrix(xRow, cPrecio) = Func_Leer_Celda(xlSheet, "L" & LTrim(Str(1 + xRow)))
            .TextMatrix(xRow, cMonto) = Func_Leer_Celda(xlSheet, "M" & LTrim(Str(1 + xRow))) ''Func_Leer_Celda(xlSheet, "N" & LTrim(Str(1 + xRow)))
            .TextMatrix(xRow, cCustodia) = Func_Leer_Celda(xlSheet, "O" & LTrim(Str(1 + xRow)))
            .TextMatrix(xRow, cClave) = Func_Leer_Celda(xlSheet, "P" & LTrim(Str(1 + xRow)))
            .TextMatrix(xRow, cCartera) = Func_Leer_Celda(xlSheet, "Q" & LTrim(Str(1 + xRow)))
        Next xRow
    
        xlBook.Close
    End With
   
    Call Proc_Agrupa_Operacions
    Call Cmb_cargar_Click

   Screen.MousePointer = vbDefault

Exit Sub
Error:
    MsgBox "Error : " & err.Description, vbExclamation, TITSISTEMA
    Screen.MousePointer = 0
Exit Sub
ErrHandler:
    Screen.MousePointer = 0
Exit Sub
End Sub

Private Sub TxtTotal_GotFocus()
   TxtTotal.Tag = TxtTotal.text
End Sub

Private Sub TxtTotal_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Tecla = "13"
   Else
      Tecla = ""
   End If
End Sub

Private Sub TxtTotal_KeyPress(KeyAscii As Integer)

   If KeyAscii = 27 Then
      TxtTotal.text = TxtTotal.Tag
      KeyAscii = vbKeyReturn
   End If

   If KeyAscii% = vbKeyReturn Then
      Bac_SendKey vbKeyTab
   End If

End Sub

Private Sub TxtTotal_LostFocus()
   Dim i                As Integer
   Dim dTotalNuevo#
   Dim dTotalActual#

   If TxtTotal.Tag <> TxtTotal.text Then
      dTotalActual# = Val(Str(TxtTotal.Tag))
      dTotalNuevo# = Val(Str(TxtTotal.text))
      
      If Tipo_Carga <> "AU" And Val(TxtTotal.text) > 0 Then
         Call CPCI_ValorizarTotal(Data1, dTotalNuevo#, dTotalActual#)
         Call Data1.Refresh
         
         For i = 1 To Table1.Rows - 1
            Let Table1.Row = i
            Call Llena_Grilla
            If Not Data1.Recordset.EOF Then
               Call Data1.Recordset.MoveNext
            End If
         Next i
         Call Table1.Refresh
      End If
   End If
   
End Sub

Function FUNC_Verifica_Papeles() As Boolean
Dim nMoneda As Long

FUNC_Verifica_Papeles = False

With Data1.Recordset
    .MoveFirst
    nMoneda = .Fields("Tm_Monemi")
    Do While Not .EOF
        
        If nMoneda = 0 Then
            nMoneda = .Fields("Tm_Monemi")
        End If
        
        If nMoneda <> .Fields("Tm_Monemi") Then
            Select Case nMoneda
                Case 999, 998, 997, 995, 994, 800, 801 ' VB+- 18-06-2010 Se agregan codigos de monedas 800, 801 para depsoitos en ICP y ICPR
                    If .Fields("Tm_Monemi") = 999 Or _
                        .Fields("Tm_Monemi") = 998 Or _
                        .Fields("Tm_Monemi") = 997 Or _
                        .Fields("Tm_Monemi") = 995 Or _
                        .Fields("Tm_Monemi") = 994 Or _
                        .Fields("Tm_Monemi") = 800 Or _
                        .Fields("Tm_Monemi") = 801 Then
                        FUNC_Verifica_Papeles = False
                        
                    Else
                        FUNC_Verifica_Papeles = True
                        Exit Do
                    End If
                Case Else
                    FUNC_Verifica_Papeles = True
                    Exit Do
            End Select
        End If
        Call funcFindDatGralMoneda(Val(nMoneda))
        SwMx = BacDatGrMon.mnmx
        .MoveNext
    Loop
    .MoveFirst
    
End With

End Function

Public Function carga_ticker()
    Dim SqlDatos()
    Dim Filas As Integer
    Dim Serie As String
    Dim oMensaje    As String
    Dim oSerie As String
    Dim cadena1 As String
    On Error GoTo ErrorGrabacion
    cuentticker = 0
    tipopapel = "Automatica"
    TipoPago.Enabled = False
        
    'limpia pantalla
'    Call Func_Limpiar_Pantalla
'    Call Limpia_grilla
     Me.CmbLibro.Enabled = False
       
    '*************************
       ' Elimna registros asociados a la CP.-
      Call CP_BorrarTx(Me.hWnd)
   ' Desactivar botones asociados a la operación.-
   BacHabilitaBotones ""
   Set objMonLiq = Nothing
    '*************************
      Call Func_Limpiar_Pantalla
    Call Limpia_grilla
    Dim filll As String
    
    Envia = Array()
    AddParam Envia, ""
    If Not Bac_Sql_Execute("SP_CARGA_TICKER", Envia) Then
      oMensaje = "Existe un problema con la carga de los tickers. " & vbCrLf
      GoTo ErrorGrabacion
      'Exit Function
   End If
   
   If Data1.Recordset.RecordCount = 1 Then
          Data1.Recordset.Delete
   End If

   Do While Bac_SQL_Fetch(SqlDatos())
      If SqlDatos(1) = "NoIngresada" Then
         oSerie = oSerie + ", " + SqlDatos(4)
         'oMensaje = "No es posible cargar los Tickers : " & vbCrLf & "Serie " & SqlDatos(3) & " no esta ingresada en el BAC."
         oMensaje = "No es posible cargar los Tickers : " & vbCrLf & "Serie " & oSerie & " no esta ingresada en el BAC."
         GoTo ErrorGrabacion
      Else
          Data1.Recordset.AddNew
          Call CP_Limpiar(Data1)
          SqlDatos(35) = FormHandle
          Data1.Recordset("tm_instser") = SqlDatos(1)
          Data1.Recordset("tm_genemi") = SqlDatos(2)
          Data1.Recordset("tm_nemmon") = SqlDatos(3)
          Data1.Recordset("tm_nominal") = SqlDatos(4)
          Data1.Recordset("tm_tir") = SqlDatos(5) '(38)
          Data1.Recordset("tm_pvp") = SqlDatos(39) '(6)
          Data1.Recordset("tm_vpar") = SqlDatos(44) '(7)
        ' Data1.Recordset("tm_pvp") = SqlDatos(8)
          Data1.Recordset("tm_mt100") = SqlDatos(42) '(9)
          Data1.Recordset("tm_tirmcd") = SqlDatos(38) '(10) '10
          Data1.Recordset("tm_pvpmcd") = SqlDatos(39) '(11)
          Data1.Recordset("tm_mtmcd") = SqlDatos(40) '(12)
          Data1.Recordset("tm_mtmcd100") = SqlDatos(42) '(13)
          Data1.Recordset("tm_mtml") = SqlDatos(14)
          Data1.Recordset("tm_tcml") = SqlDatos(15) '(16)
          Data1.Recordset("tm_monemi") = SqlDatos(17)
          Data1.Recordset("tm_rutemi") = SqlDatos(16)
          Data1.Recordset("tm_basemi") = SqlDatos(18)
          Data1.Recordset("tm_fecemi") = SqlDatos(19)
          Data1.Recordset("tm_fecven") = SqlDatos(20)
          Data1.Recordset("tm_tasemi") = SqlDatos(21) '20
          Data1.Recordset("tm_mascara") = SqlDatos(22)
          Data1.Recordset("tm_numucup") = SqlDatos(45) '0# 'SqlDatos(23)
          Data1.Recordset("tm_tasest") = 0#
          Data1.Recordset("tm_codigo") = SqlDatos(25)
          Data1.Recordset("tm_refnomi") = SqlDatos(29)
          Data1.Recordset("tm_mt") = SqlDatos(40) '(27)
          Data1.Recordset("tm_serie") = SqlDatos(28)
          Data1.Recordset("tm_cortemin") = SqlDatos(30)
          Data1.Recordset("tm_mdse") = SqlDatos(31)
          Data1.Recordset("tm_leeemi") = SqlDatos(32)
          Data1.Recordset("tm_fecpcup") = SqlDatos(51) '(33)
          Data1.Recordset("tm_custodia") = "DCV" '30
          Data1.Recordset("tm_clave_dcv") = SqlDatos(58)
          Data1.Recordset("tm_hwnd") = SqlDatos(35)
        ' Data1.Recordset("tm_mtmcd") = SqlDatos(35) '33
          Data1.Recordset("tm_convexidad") = SqlDatos(56)
    '     Data1.Recordset("tm_codexceso") = SqlDatos(36)
    '     Data1.Recordset("tm_mtoexceso") = SqlDatos(37)
          Data1.Recordset("tm_carterasuper") = "T"
    '     Data1.Recordset("tm_codemi") = SqlDatos(39)
          Data1.Recordset("tm_VpMo") = SqlDatos(40) '(27)
          Data1.Recordset("tm_durationmac") = SqlDatos(55)
          Data1.Recordset("tm_durationmod") = SqlDatos(57)
          Data1.Recordset("tm_VpTranMo") = SqlDatos(40)
         'Data1.Recordset("
  
          Data1.Recordset!tm_pvpmcd = Data1.Recordset("tm_pvp")
          Data1.Recordset!tm_tirmcd = Data1.Recordset("tm_tir")
          Data1.Recordset!tm_mtmcd = Data1.Recordset("tm_mt")
          Data1.Recordset!tm_VPTRANMO = Data1.Recordset("tm_VPMo")
          Data1.Recordset.Update
          Data1.Recordset.MoveLast
          cuentticker = cuentticker + 1
          
          If SqlDatos(37) = "2" Then
            cadena = cadena + SqlDatos(1)
            'Call marca_grilla
          End If
    End If
  Loop
          If Data1.Recordset.RecordCount > 0 Then
               Call llena_grilla_acces
              Me.CmbLibro.Enabled = True
          Else
            Call Limpiar_Datos
          End If
  ' End If

Exit Function
ErrorGrabacion:
            'MsgBox ("En este momento no existen Tickers"), vbExclamation, TITSISTEMA
            MsgBox oMensaje, vbExclamation, TITSISTEMA
End Function

Private Sub CP_Limpiar(Data1 As Control)

    Data1.Recordset("tm_instser") = ""
    Data1.Recordset("tm_genemi") = ""
    Data1.Recordset("tm_nemmon") = ""
    Data1.Recordset("tm_nominal") = 0#
    Data1.Recordset("tm_tir") = 0#
    Data1.Recordset("tm_pvp") = 0#
    Data1.Recordset("tm_vpar") = 0#
    Data1.Recordset("tm_mt") = 0#
    Data1.Recordset("tm_mt100") = 0#
    Data1.Recordset("tm_tirmcd") = 0#
    Data1.Recordset("tm_pvpmcd") = 0#
    Data1.Recordset("tm_mtmcd") = 0#
    Data1.Recordset("tm_mtmcd100") = 0#
    Data1.Recordset("tm_mtml") = 0#
    Data1.Recordset("tm_tcml") = 0#
    Data1.Recordset("tm_rutemi") = 0#
    Data1.Recordset("tm_codemi") = 0#
    Data1.Recordset("tm_monemi") = 0#
    Data1.Recordset("tm_basemi") = 0#
    Data1.Recordset("tm_fecemi") = ""
    Data1.Recordset("tm_fecven") = ""
    Data1.Recordset("tm_tasemi") = 0#
    Data1.Recordset("tm_mascara") = ""
    Data1.Recordset("tm_numucup") = 0#
    Data1.Recordset("tm_tasest") = 0#
    Data1.Recordset("tm_mdse") = ""
    Data1.Recordset("tm_codigo") = 0#
    Data1.Recordset("tm_refnomi") = ""
    Data1.Recordset("tm_serie") = ""
    Data1.Recordset("tm_cortemin") = 0#
    Data1.Recordset("tm_valmcd") = "N"
    Data1.Recordset("tm_leeemi") = ""
    Data1.Recordset("tm_fecpcup") = ""
    Data1.Recordset("tm_clave_dcv") = ""
    Data1.Recordset("tm_custodia") = ""
    Data1.Recordset("tm_carterasuper") = "T"
    
End Sub

Function Validar_SerieFM(Serie As String) As Boolean
Dim iRow As Integer
Dim noOk As Boolean

noOk = True

    If Mid(Serie, 1, 6) = "FMUTUO" Then
       For iRow = 1 To Table1.Rows - 2
            If Table1.TextMatrix(iRow, nCol_SERIE) <> Serie Then
                noOk = False
                Exit Function
            End If
       Next iRow
    Else
       For iRow = 1 To Table1.Rows - 2
            If Mid(Table1.TextMatrix(iRow, nCol_SERIE), 1, 6) = "FMUTUO" Then
                noOk = False
                Exit Function
            End If
       Next iRow
    End If

Validar_SerieFM = noOk

End Function

