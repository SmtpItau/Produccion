VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacSH 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form2"
   ClientHeight    =   4605
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9915
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4605
   ScaleWidth      =   9915
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   "C:\BTRADER\Mdb\BACTRD.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   2505
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   "MDDI"
      Top             =   4620
      Visible         =   0   'False
      Width           =   2415
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   24
      Top             =   0
      Width           =   9915
      _ExtentX        =   17489
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   9
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbgrabar"
            Description     =   "GRABAR"
            Object.ToolTipText     =   "Grabar Operación"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbvende"
            Description     =   "VENDE"
            Object.ToolTipText     =   "Vender (marcar operación)"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbrestaura"
            Description     =   "RESTAURAR"
            Object.ToolTipText     =   "Restaurar (desmarcar operación)"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbfiltrar"
            Description     =   "FILTRAR"
            Object.ToolTipText     =   "Filtrar Documentos"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbversel"
            Description     =   "VERSELEC"
            Object.ToolTipText     =   "Ver selección"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbemision"
            Description     =   "EMISION"
            Object.ToolTipText     =   "Datos del Emisor"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcortes"
            Description     =   "CORTES"
            Object.ToolTipText     =   "Cortes del documento"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "valorizaciones"
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin BACControles.TXTNumero TEXT1 
      Height          =   315
      Left            =   855
      TabIndex        =   22
      Top             =   1455
      Visible         =   0   'False
      Width           =   510
      _ExtentX        =   900
      _ExtentY        =   556
      BackColor       =   -2147483644
      ForeColor       =   -2147483646
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   0
      Text            =   "0"
      Text            =   "0"
      Min             =   "-99"
      Max             =   "99999999999.9999"
      Separator       =   -1  'True
   End
   Begin VB.ComboBox Combo1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000004&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000002&
      Height          =   330
      ItemData        =   "BacSH.frx":0000
      Left            =   1470
      List            =   "BacSH.frx":000D
      Style           =   2  'Dropdown List
      TabIndex        =   21
      Top             =   1440
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.TextBox Text2 
      BackColor       =   &H80000004&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000002&
      Height          =   315
      Left            =   210
      TabIndex        =   20
      Top             =   1455
      Visible         =   0   'False
      Width           =   480
   End
   Begin MSFlexGridLib.MSFlexGrid TABLE1 
      Height          =   2940
      Left            =   30
      TabIndex        =   1
      Top             =   1110
      Width           =   9885
      _ExtentX        =   17436
      _ExtentY        =   5186
      _Version        =   393216
      Cols            =   17
      FixedCols       =   2
      RowHeightMin    =   315
      BackColor       =   12632256
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      ForeColorSel    =   12632256
      BackColorBkg    =   12632256
      GridLines       =   2
      GridLinesFixed  =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Frame FrmMontos 
      Height          =   600
      Left            =   30
      TabIndex        =   7
      Top             =   3990
      Width           =   9885
      Begin Threed.SSPanel Panel 
         Height          =   315
         Index           =   3
         Left            =   3420
         TabIndex        =   8
         Top             =   195
         Width           =   1485
         _Version        =   65536
         _ExtentX        =   2619
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   12632256
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         Autosize        =   3
         Begin BACControles.TXTNumero TxtInv 
            Height          =   285
            Left            =   15
            TabIndex        =   9
            Top             =   15
            Width           =   1455
            _ExtentX        =   2566
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
            Text            =   "0,00"
            Text            =   "0,00"
            Min             =   "-9999999999999999"
            Max             =   "9999999999999999"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
         End
      End
      Begin Threed.SSPanel Panel 
         Height          =   315
         Index           =   9
         Left            =   5685
         TabIndex        =   10
         Top             =   195
         Width           =   1500
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   12632256
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         Autosize        =   3
         Begin BACControles.TXTNumero TxtSel 
            Height          =   285
            Left            =   15
            TabIndex        =   11
            Top             =   15
            Width           =   1470
            _ExtentX        =   2593
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
            Text            =   "0,00"
            Text            =   "0,00"
            Min             =   "-9999999999999999"
            Max             =   "9999999999999"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
         End
      End
      Begin Threed.SSPanel Panel 
         Height          =   315
         Index           =   11
         Left            =   8040
         TabIndex        =   12
         Top             =   195
         Width           =   1605
         _Version        =   65536
         _ExtentX        =   2831
         _ExtentY        =   556
         _StockProps     =   15
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
         BorderWidth     =   1
         BevelOuter      =   1
         Autosize        =   3
         Begin BACControles.TXTNumero TxtSaldo 
            Height          =   285
            Left            =   15
            TabIndex        =   13
            Top             =   15
            Width           =   1575
            _ExtentX        =   2778
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
            Text            =   "0,00"
            Text            =   "0,00"
            Min             =   "-9999999999999999"
            Max             =   "999999999999999"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
         End
      End
      Begin Threed.SSPanel Panel 
         Height          =   315
         Index           =   4
         Left            =   885
         TabIndex        =   14
         Top             =   195
         Width           =   1590
         _Version        =   65536
         _ExtentX        =   2805
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   12632256
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         Autosize        =   3
         Begin BACControles.TXTNumero TxtCartera 
            Height          =   285
            Left            =   15
            TabIndex        =   15
            Top             =   15
            Width           =   1560
            _ExtentX        =   2752
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
            Text            =   "0,00"
            Text            =   "0,00"
            Max             =   "9999999999999"
            CantidadDecimales=   "2"
            Separator       =   -1  'True
         End
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
         Left            =   7230
         TabIndex        =   19
         Top             =   195
         Width           =   795
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
         Left            =   4950
         TabIndex        =   18
         Top             =   195
         Width           =   735
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
         Left            =   2505
         TabIndex        =   17
         Top             =   195
         Width           =   900
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
         Left            =   75
         TabIndex        =   16
         Top             =   195
         Width           =   795
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6855
      Top             =   30
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
            Picture         =   "BacSH.frx":0027
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacSH.frx":0F01
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacSH.frx":121B
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacSH.frx":20F5
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacSH.frx":2FCF
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacSH.frx":3EA9
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacSH.frx":4D83
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Cuadro1 
      Height          =   660
      Left            =   30
      TabIndex        =   2
      Top             =   435
      Width           =   9885
      Begin BACControles.TXTFecha txtFechaSorteo 
         Height          =   300
         Left            =   7410
         TabIndex        =   0
         Top             =   225
         Width           =   1245
         _ExtentX        =   2196
         _ExtentY        =   529
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "31/03/2005"
      End
      Begin BACControles.TXTNumero TxtTotal 
         Height          =   300
         Left            =   1470
         TabIndex        =   3
         Top             =   225
         Width           =   1890
         _ExtentX        =   3334
         _ExtentY        =   529
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,00"
         Text            =   "0,00"
         Min             =   "-99999999999999.999999"
         Max             =   "99999999999999.999999"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin VB.Label lblDiaSemana 
         AutoSize        =   -1  'True
         Caption         =   "Miércoles"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   8700
         TabIndex        =   25
         Top             =   270
         Width           =   945
      End
      Begin VB.Label Label5 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha de Sorteo"
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
         Left            =   5985
         TabIndex        =   23
         Top             =   270
         Width           =   1335
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Resultado"
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
         Left            =   3495
         TabIndex        =   6
         Top             =   270
         Width           =   825
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Total Operación"
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
         Left            =   45
         TabIndex        =   5
         Top             =   270
         Width           =   1290
      End
      Begin VB.Label Flt_Result 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   4395
         TabIndex        =   4
         Top             =   225
         Width           =   1455
      End
   End
End
Attribute VB_Name = "BacSH"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public FiltraVentaAutomatico    As Boolean
Public bFlagDpx            As Boolean      'Permite solo el ingreso de los dpx
Dim SWPintando             As Boolean
Dim Monto                  As Double
Dim Tecla                  As String
Dim FormHandle             As Long
Dim Columna                As Integer
Dim objMonLiq              As New clsCodigos
Dim iFlagKeyDown           As Integer
Dim bufNominal             As Double
Dim bufRutCart             As Long
Dim objDCartera            As New clsDCartera
Dim sFiltro                As String
Dim nRutCartV              As String
Dim cDvCartV               As String
Dim cNomCartV              As String
Dim valor                  As String
Public Fila                As Integer
Public FiltroAutomatico    As Boolean
Dim z                      As Integer
Dim Color                  As String
Dim colorletra             As String
Dim columnita              As Integer
Dim filita                 As Integer
Dim bold                   As String


'constantes de posicion de datos en arreglo de consulta para
'procedimiento SP_FILTRARCART_VP
Const Pos_RutCartera = 0
Const Pos_CartFin = 1
Const Pos_CadenaFamilia = 2
Const Pos_CadenaEmisor = 3
Const Pos_CadenaMoneda = 4
Const Pos_CadenaSerie = 5
Const Pos_CartSuper = 6
Const Pos_Usuario = 7
Const Pos_Libro = 8

Public cCodCartFin        As String
Public cCodLibro          As String

Private Sub desbloquear()

   Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_venta = " & "'V'" & " OR tm_venta = " & " 'P'"
   Data1.Refresh
    
   Do While Not Data1.Recordset.EOF
      Call VENTA_DesBloquear(FormHandle, Data1)
      Data1.Recordset.MoveNext
   Loop

End Sub

Private Sub refresca()
     Dim I As Integer
     Data1.Refresh
    
   For I = 1 To Table1.Rows - 1
      Table1.Row = I
      Call Llenar_Grilla
      
      If Not Data1.Recordset.EOF Then
      Data1.Recordset.MoveNext
      End If
   Next I
   
   Table1.Refresh
End Sub
    
       
Private Function colores()
Dim Fila As Integer

Table1.Redraw = False
     
For Fila = 1 To Table1.Rows - 1
 
    If Table1.TextMatrix(Fila, 0) = "*" Then
         Color = &HC0C0C0
         colorletra = &HC0&
         bold = False
    End If
    
    If Table1.TextMatrix(Fila, 0) = "V" Then
         Color = &HFF0000
         colorletra = &HFFFFFF
         bold = True
    End If
    
    If Table1.TextMatrix(Fila, 0) = "P" Then
         Color = vbCyan
         colorletra = vbBlack
         bold = False
    End If

    If Table1.TextMatrix(Fila, 0) = "B" Then
       Color = vbBlack + vbWhite    'vbBlack
       colorletra = vbBlack
       bold = False
    End If
    
    If Table1.TextMatrix(Fila, 0) = " " Then
         Color = &HC0C0C0
         colorletra = &H800000
         bold = False
    End If
    
    
   Dim z%
   Table1.Row = Fila
      
   For z = 2 To Table1.cols - 1
      Table1.Col = z
      Table1.CellBackColor = Color
      Table1.CellForeColor = colorletra
      Table1.CellFontBold = bold
   Next z
  
Next Fila
   
   Table1.Redraw = True
   Table1.Col = 2

End Function

Public Function Colocardata1() As Boolean
Dim I As Integer
Colocardata1 = False
If Table1.TextMatrix(1, 0) = "" Then
    Exit Function
End If
  Monto = CDbl(Table1.TextMatrix(Table1.Row, 3))
  Data1.Recordset.MoveFirst
  
  For I = 1 To Table1.Row - 1
        Data1.Recordset.MoveNext
  Next I
Colocardata1 = True
End Function

Private Sub Llenar_Grilla()
   Dim x As Integer
   Dim oDatos()
   
   If Data1.Recordset.RecordCount > 0 Then
      
      Data1.Recordset.MoveFirst
   
   End If
   
   
   Table1.Redraw = False
   Table1.Rows = 1
   
   Do While Not Data1.Recordset.EOF
      x = Table1.Rows
      Table1.Rows = Table1.Rows + 1
      
      With Table1
         .TextMatrix(x, 0) = Data1.Recordset!tm_venta
         .TextMatrix(x, 1) = Data1.Recordset!TM_INSTSER
          If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
            .ColWidth(4) = 1800
          End If
         .TextMatrix(x, 2) = Data1.Recordset!TM_NEMMON
         .TextMatrix(x, 3) = Format(Data1.Recordset!tm_nominal, "#,##0.0000")
         .TextMatrix(x, 4) = Format(Data1.Recordset!TM_TIR, "#,##0.0000")
         .TextMatrix(x, 5) = Format(Data1.Recordset!TM_Pvp, "#,##0.0000")
         .TextMatrix(x, 6) = Format(Data1.Recordset!TM_VP, "#,##0.0000")
         .TextMatrix(x, 7) = IIf(IsNull(Data1.Recordset!tm_custodia) = True, " ", Data1.Recordset!tm_custodia)
         .TextMatrix(x, 8) = IIf(IsNull(Data1.Recordset!tm_clave_dcv) = True, " ", Data1.Recordset!tm_clave_dcv)
         .TextMatrix(x, 9) = Format(Data1.Recordset!TM_tircomp, "#,##0.0000")
         .TextMatrix(x, 10) = Format(Data1.Recordset!TM_pvpcomp, "#,##0.0000")
         .TextMatrix(x, 11) = Format(Data1.Recordset!tm_vptirc, "#,##0.0000")
         .TextMatrix(x, 12) = Format(CDbl(Data1.Recordset!TM_VP) - CDbl(Data1.Recordset!tm_vptirc), "#,###,###,##0")
         .TextMatrix(x, 14) = Format(Data1.Recordset!tm_durmacori, FDecimal)
         .TextMatrix(x, 15) = Format(Data1.Recordset!tm_durmodori, FDecimal)
         .TextMatrix(x, 16) = Format(Data1.Recordset!tm_convex, FDecimal)
         
         Envia = Array()
         AddParam Envia, GLB_CARTERA_NORMATIVA
         AddParam Envia, Trim(Data1.Recordset!tm_carterasuper)
                
         If Bac_Sql_Execute("SP_CON_INFO_COMBO", Envia) Then
           
             Do While Bac_SQL_Fetch(oDatos())
                 .TextMatrix(x, 13) = Trim(oDatos(6))
             Loop
         Else
             .TextMatrix(x, 13) = "NO ESPECIFICADO"
         End If
         
'''''         Select Case Data1.Recordset!tm_carterasuper
'''''            Case Is = "T": .TextMatrix(x, 13) = "TRANSABLE"
'''''            Case Is = "P": .TextMatrix(x, 13) = "PERMANENTE"
'''''            Case Else: .TextMatrix(x, 13) = ""
'''''         End Select
''''''         TABLE1.Redraw = True
      
      End With
      Data1.Recordset.MoveNext
   Loop
   Call colores
   Table1.Col = 2
   Table1.Redraw = True
   
   
   
  
End Sub
Private Sub cmbMonLiq_Change()

End Sub


Private Sub Combo1_GotFocus()
   Call PROC_POSI_TEXTO(Table1, Combo1)
End Sub

Private Sub Combo1_KeyDown(KeyCode As Integer, Shift As Integer)
   
If KeyCode = 27 Then
    Combo1_LostFocus
End If

If KeyCode = 13 Then
      If Not Table1.Rows = 1 Then
        Call Colocardata1
      Else
         Data1.Recordset.MoveFirst
      End If
    
        If Table1.Col = 7 Then
            Data1.Recordset.Edit
            Select Case Combo1.ListIndex 'UCase$(Left(Combo1.Text, 1)) 'Chr(KeyCode))
            Case 0:
                Data1.Recordset("tm_custodia") = "CLIENTE"
                Data1.Recordset("tm_clave_dcv") = " "
                Table1.TextMatrix(Table1.Row, 7) = "CLIENTE"
                Table1.TextMatrix(Table1.Row, 8) = ""
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
                    Table1.TextMatrix(Table1.Row, 7) = "DCV"
                    Table1.TextMatrix(Table1.Row, 8) = Data1.Recordset("tm_clave_dcv")
                        
                    KeyCode = 13
               ' End If
            Case "2":
                Data1.Recordset("tm_custodia") = "PROPIA"
                Data1.Recordset("tm_clave_dcv") = " "
                Table1.TextMatrix(Table1.Row, 7) = "PROPIA"
                Table1.TextMatrix(Table1.Row, 8) = ""
                
                KeyCode = 13
            Case Else
                KeyCode = 0
            End Select
            Data1.Recordset.Update
            Combo1.Visible = False
            Table1.SetFocus
        End If
End If
End Sub

Private Sub Combo1_LostFocus()

    Combo1.Visible = False
    Table1.SetFocus

    If Table1.Col + 1 < Table1.cols Then
        Table1.Col = Table1.Col + 1

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
    KeyAscii = 0
End Sub

Sub Nombre_Grilla()
  ' Configurar las columnas de la grid.-
    Table1.TextMatrix(0, 0) = "M"
    Table1.TextMatrix(0, 1) = "Serie"
    Table1.TextMatrix(0, 2) = "UM"
    Table1.TextMatrix(0, 3) = "Nominal"
    Table1.TextMatrix(0, 4) = "%Tir"
    Table1.TextMatrix(0, 5) = "%Vpar"
    Table1.TextMatrix(0, 6) = "Valor Presente"
    Table1.TextMatrix(0, 7) = "Custodia"
    Table1.TextMatrix(0, 8) = "Clave DCV"
    Table1.TextMatrix(0, 9) = "%Tir C."
    Table1.TextMatrix(0, 10) = "%Vpar C."
    Table1.TextMatrix(0, 11) = "Valor de Compra"
    Table1.TextMatrix(0, 12) = "Utilidad"
    Table1.TextMatrix(0, 13) = "Nombre Cartera Super"
    Table1.ColWidth(0) = 400
    Table1.ColWidth(1) = 1500
    Table1.ColWidth(2) = 500
    Table1.ColWidth(3) = 1800
    Table1.ColWidth(4) = 900
    Table1.ColWidth(5) = 900
    Table1.ColWidth(6) = 2800 'antes 1800
    Table1.ColWidth(7) = 1200
    Table1.ColWidth(8) = 1200
    Table1.ColWidth(9) = 900
    Table1.ColWidth(10) = 900
    Table1.ColWidth(11) = 1800
    Table1.ColWidth(12) = 0 '2500
    Table1.ColWidth(13) = 0 '1500 'insertado
    Table1.ColWidth(14) = 0 'Tm_Duracori
    Table1.ColWidth(15) = 0 'Tm_Durmodori
    Table1.ColWidth(16) = 0 'Tm_Convex
End Sub

Private Sub Form_Activate()
   Dim x As Integer
   
   Me.Tag = "ST"
   Tipo_Operacion = "ST"
      
   Data1.Refresh
   iFlagKeyDown = True
   Screen.MousePointer = vbHourglass
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
   Me.Icon = BacTrader.Icon
   Me.Top = 0: Me.Left = 0
   
   txtFechaSorteo.Text = DateAdd("M", 1, gsBac_Fecx)
   txtFechaSorteo.Text = "01/" & IIf(Len(Month(txtFechaSorteo.Text)) = 1, "0" & Month(txtFechaSorteo.Text), Month(txtFechaSorteo.Text)) & "/" & Year(txtFechaSorteo.Text)
   TxtInv.SelStart = 0

   Toolbar1.Buttons(7).Enabled = False
   Toolbar1.Buttons(8).Enabled = False
   Toolbar1.Buttons(6).Enabled = False
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False
   Toolbar1.Buttons(5).Enabled = True
   TxtTotal.Enabled = False

   FormHandle = Me.Hwnd
   iFlagKeyDown = True

    Call VENTA_IniciarTx(FormHandle, Data1, "1")
    Call objMonLiq.LeerCodigos(22)
    
  ' Configurar las columnas de la grid.-
    Table1.TextMatrix(0, 0) = "M"
    Table1.TextMatrix(0, 1) = "Serie"
    Table1.TextMatrix(0, 2) = "UM"
    Table1.TextMatrix(0, 3) = "Nominal"
    Table1.TextMatrix(0, 4) = "%Tir"
    Table1.TextMatrix(0, 5) = "%Vpar"
    Table1.TextMatrix(0, 6) = "Valor Presente"
    Table1.TextMatrix(0, 7) = "Custodia"
    Table1.TextMatrix(0, 8) = "Clave DCV"
    Table1.TextMatrix(0, 9) = "%Tir C."
    Table1.TextMatrix(0, 10) = "%Vpar C."
    Table1.TextMatrix(0, 11) = "Valor de Compra"
    Table1.TextMatrix(0, 12) = "Utilidad"
    Table1.TextMatrix(0, 13) = "Nombre Cartera Super"
    Table1.ColWidth(0) = 400
    Table1.ColWidth(1) = 1500
    Table1.ColWidth(2) = 500
    Table1.ColWidth(3) = 1800
    Table1.ColWidth(4) = 900
    Table1.ColWidth(5) = 900
    Table1.ColWidth(6) = 2800 'antes 1800
    Table1.ColWidth(7) = 1200
    Table1.ColWidth(8) = 1200
    Table1.ColWidth(9) = 900
    Table1.ColWidth(10) = 900
    Table1.ColWidth(11) = 1800
    Table1.ColWidth(12) = 0 '2500
    Table1.ColWidth(13) = 1500 'insertado
    
    Data1.Refresh
    Toolbar1.Buttons(6).Tag = "Ver Sel."
    FiltroAutomatico = False
    Toolbar1.Buttons(6).Enabled = False
    Table1.Enabled = False
    TxtInv.Enabled = True
    Flt_Result.Enabled = True
    
    Set BacFrmIRF = Me
    
End Sub

Private Sub Form_Resize()
'On Error GoTo BacErrHnd
'
'Dim lScaleWidth&, lScaleHeight&, lPosIni&
'
'    ' Cuando la ventana es minimizada, se ignora la rutina.-
'    If Me.WindowState = 1 Then
'        ' Pinta borde del icono.-
'        Dim x!, Y!, J%
'
'        x = Me.Width
'        Y = Me.Height
'        For J% = 1 To 15
'            Line (0, 0)-(x, 0), QBColor(Int(Rnd * 15))
'            Line (x, 0)-(x, Y), QBColor(Int(Rnd * 15))
'            Line (x, Y)-(0, Y), QBColor(Int(Rnd * 15))
'            Line (0, Y)-(0, 0), QBColor(Int(Rnd * 15))
'            DoEvents
'        Next
'        Exit Sub
'
'    End If
'
'  ' Escalas de medida de la ventana.-
'    lScaleWidth& = Me.ScaleWidth
'    lScaleHeight& = Me.ScaleHeight
'
'  ' Resize la ventana customizado.-
'    If Me.WindowState <> 1 And Me.Width > 400 And Me.Height > 2100 Then
'        TABLE1.Width = Me.Width - 300
'        TABLE1.Height = Me.Height - 2050
'        FrmMontos.Top = Me.Height - 1050
'    End If
'
'      Exit Sub
'
'BacErrHnd:
'
'    On Error GoTo 0
'    Resume Next
'
End Sub

Private Sub Form_Unload(Cancel As Integer)
   'Elimina los registros de la tabla de bloqueados
   Call VENTA_EliminarBloqueados(Data1, FormHandle)
   'Eliminar los registros del temporal que tengan hwnd igual
   Call VENTA_BorrarTx(FormHandle)
   
   Set objMonLiq = Nothing
   Set objDCartera = Nothing
End Sub

Private Sub SSC_Grabar_Click()
'Dim rRs As Recordset
'Data1.Refresh
'    Set rRs = db.OpenRecordset("SELECT DISTINCT tm_monemi FROM MDVENTA WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )", dbOpenSnapshot)
'
'    If rRs.RecordCount > 0 Then
'       If Not IsNull(rRs.Fields("tm_monemi")) Then
'          BacIrfGr.proMoneda = IIf(rRs.Fields("tm_monemi") = 13, gsBac_Dolar, "$$")
'       End If
'    End If
'
'    BacIrfGr.proMtoOper = TxtTotal.Text
'    BacIrfGr.proHwnd = hWnd
'
'    Call BacGrabarTX
'
'    BacControlWindows 100
'
'    If Not Grabacion_Operacion Then
'       Data1.Refresh
'    End If
    
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

Private Sub Table1_DblClick()
   If Table1.Col = 7 And (Table1.TextMatrix(Table1.Row, 0) = "V" Or Table1.TextMatrix(Table1.Row, 0) = "P") Then
      Combo1.Visible = True
      Combo1.SetFocus
   End If
End Sub

Private Sub Table1_GotFocus()
'If Valor = False Then
' Data1.Refresh
'End If
'Valor = False
End Sub

Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)
columnita = Table1.Col
     
 If KeyCode = 13 And KeyCode <> 86 _
                 And KeyCode <> 82 _
                 And KeyCode <> 118 _
                 And KeyCode <> 114 _
                 And Table1.Col > 2 _
                 And Table1.Col < 7 Then
      
      BacControlWindows 100
      Table1.Col = columnita
      Text1.Top = Table1.CellTop + Table1.Top + 20
      Text1.Left = Table1.CellLeft + Table1.Left + 20
      Text1.Width = Table1.CellWidth - 20
      Text1.Visible = True
      
      If KeyCode > 47 And KeyCode < 58 Then
         Text1.Text = Chr(KeyCode)
      End If
      
      If KeyCode = 13 Then
         Text1.Text = CDbl(Table1.TextMatrix(Table1.Row, Table1.Col))
      End If
      
      Text1.SetFocus
      Exit Sub
      
 End If

On Error GoTo KeyDownError
    'El Flag es false cuando se está editando un campo
    If iFlagKeyDown = False Then
        Exit Sub
    End If
            
    Exit Sub
    
KeyDownError:

    MsgBox error(err), vbExclamation, "Mensaje"
    Data1.Refresh
    Exit Sub

End Sub


Private Sub Table1_KeyPress(KeyAscii As Integer)
Dim I          As Integer
Dim Sql        As String
Dim Datos()
Dim reg        As Double
Dim bloq       As String
Dim fila_table As Double
Dim Fila As Integer
Dim nRowTop As Integer

   nRowTop = Table1.TopRow

   Columna = Table1.Col

   If Table1.Col = 8 And Trim(Table1.TextMatrix(Table1.Row, 7)) = "DCV" _
                    And (Trim(Table1.TextMatrix(Table1.Row, 0)) = "V" _
                    Or Trim(Table1.TextMatrix(Table1.Row, 0)) = "P") Then
    
      BacControlWindows 100
      Text2.Text = Table1.TextMatrix(Table1.Row, Table1.Col)
      Text2.Visible = True
      Text2.MaxLength = 9
       
      If KeyAscii <> 13 Then
         Text2.Text = UCase(Chr(KeyAscii))
      Else
         Text2.Text = Table1.TextMatrix(Table1.Row, Table1.Col)
      End If
       
      Text2.SetFocus
      BacControlWindows 100
      Exit Sub
       
   End If

   If KeyAscii <> 86 And KeyAscii <> 82 _
                     And KeyAscii <> 118 _
                     And KeyAscii <> 114 _
                     And Table1.Col = 7 _
                     And (Table1.TextMatrix(Table1.Row, 0) = "V" _
                     Or Table1.TextMatrix(Table1.Row, 0) = "P") Then
        
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
       
   If KeyAscii <> 86 And KeyAscii <> 82 _
                     And KeyAscii <> 118 _
                     And KeyAscii <> 114 _
                     And Table1.Col > 2 _
                     And Table1.Col < 7 Then
      BacControlWindows 100
      Table1.Col = columnita
      Text1.Top = Table1.CellTop + Table1.Top + 20
      Text1.Left = Table1.CellLeft + Table1.Left + 20
      Text1.Width = Table1.CellWidth - 20
      Text1.Visible = True

      If Table1.Col = 6 Then
         If Trim(Table1.TextMatrix(Table1.Row, 2)) = "USD" Then
            Text1.CantidadDecimales = 2
         Else
            Text1.CantidadDecimales = 0
         End If

      Else
         If bFlagDpx Then
            Text1.CantidadDecimales = 2

         Else
            Text1.CantidadDecimales = 4

         End If

      End If

      If KeyAscii > 47 And KeyAscii < 58 Then
         Text1.Text = Chr(KeyAscii)

      End If

      If KeyAscii = 13 Then
         Text1.Text = CDbl(Table1.TextMatrix(Table1.Row, Table1.Col))

      End If

      Text1.SetFocus
      Exit Sub

   End If

   filita = Table1.Row
   columnita = Table1.Col
   fila_table = Table1.Row - 1

   If Not Table1.Row = 1 Then
      Call Colocardata1

   Else
      Data1.Recordset.MoveFirst

   End If

   BacToUCase KeyAscii

   If UCase$(Table1.TextMatrix(Table1.Row, Table1.Col)) = "CLAVE DCV" Then
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

   Select Case Table1.Col
   Case Ven_NOMINAL:

      If Not iFlagKeyDown Then
         KeyAscii = BacPunto(Table1, KeyAscii, 12, 4)

      End If

      If Not IsNumeric(Chr(KeyAscii)) And (KeyAscii <> 44 And KeyAscii <> 46 And KeyAscii <> 8 And KeyAscii <> 82 And KeyAscii <> 86) Then
         KeyAscii = 0

      End If

   Case Ven_TIR, Ven_VPAR
      If Not iFlagKeyDown Then
         KeyAscii = BacPunto(Table1, KeyAscii, 3, 4)

      End If

      If Not IsNumeric(Chr(KeyAscii)) And (KeyAscii <> 44 And KeyAscii <> 46 And KeyAscii <> 8 And KeyAscii <> 82 And KeyAscii <> 86) Then
         KeyAscii = 0

      End If

   End Select

   ' Tecla "R" - Restaura
   If KeyAscii = 82 Then
      KeyAscii = 0

      Call VENTA_VerDispon(FormHandle, Data1)
      If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
         If DesloquearPapeles_SorteoLetras(FormHandle, Data1, txtFechaSorteo.Text) Then
            Data1.Recordset.Edit
            Data1.Recordset("tm_venta") = " "
            Data1.Recordset("tm_clave_dcv") = ""
            Data1.Recordset.Update

            If Toolbar1.Buttons(6).Tag = "Ver Todos" And Table1.Rows - 1 = 1 Then
               Toolbar1.Buttons(6).Tag = "Ver Sel."
               Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= 1"
               Data1.Refresh

            ElseIf Toolbar1.Buttons(6).Tag = "Ver Todos" And Data1.Recordset.RecordCount > 1 Then
               Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
               Data1.Refresh

            End If

         End If

         If Data1.Recordset("tm_venta") = "*" Then
            If BloquearPapeles_SorteoLetras(FormHandle, Data1, txtFechaSorteo.Text) Then
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = " "
               Data1.Recordset.Update

            End If

         End If

         If Data1.Recordset.RecordCount > 0 Then
            Call VENTA_Restaurar(Data1)

         End If

         Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))

         TxtTotal.Text = VENTA_SumarTotal(FormHandle)
         Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")

         If CDbl(Flt_Result.Caption) < 0 Then
            Flt_Result.ForeColor = &HFF&
            Flt_Result.Caption = Format(Abs(CDbl(Flt_Result.Caption)), "###,###,###,##0.00")

         Else
            Flt_Result.ForeColor = &H0&

         End If

         Data1.Recordset.MoveLast
         Table1.Rows = Data1.Recordset.RecordCount + 1
         Data1.Refresh

         Call Llenar_Grilla

         KeyAscii = 0

      ElseIf Data1.Recordset("tm_venta") = "B" Then
         If DesloquearPapeles_SorteoLetras(0, Data1, txtFechaSorteo.Text) Then
            Data1.Recordset.Edit
            Data1.Recordset("tm_venta") = " "
            Data1.Recordset.Update

            Call VENTA_Restaurar(Data1)

            Table1.TextMatrix(Table1.Row, 0) = Data1.Recordset("tm_venta")

            For I = 0 To Table1.cols - 1
               Table1.Col = I
               Call Table1_LeaveCell

            Next I

         End If

      End If

   End If

   'V
   If KeyAscii = 86 Then   ' Tecla "V" - Venta
      Fila = Table1.Row
      Columna = Table1.Col
      Table1.ScrollBars = flexScrollBarNone

      If VENTA_VerDispon(FormHandle, Data1) Then
         If Data1.Recordset("tm_venta") = " " Or Data1.Recordset("tm_venta") = "*" Or Data1.Recordset("tm_venta") = "B" Then
            If BloquearPapeles_SorteoLetras(FormHandle, Data1, txtFechaSorteo.Text) Then
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "V"
               If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
                  Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
               Else
                  Data1.Recordset("tm_clave_dcv") = ""
               End If
               Data1.Recordset.Update
               Table1.TextMatrix(Table1.Row, 8) = Data1.Recordset("tm_clave_dcv")
               Call funcFindDatGralMoneda(Val(Data1.Recordset("tm_monemi")))
               SwMx = BacDatGrMon.mnmx
            Else
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "*"
               Data1.Recordset.Update
            End If
         End If
      End If
      TxtTotal.Text = VENTA_SumarTotal(FormHandle)
      Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")
      If CDbl(Flt_Result.Caption) < 0 Then
         Flt_Result.ForeColor = &HFF&
         Flt_Result.Caption = Format(Abs(CDbl(Flt_Result.Caption)), "###,###,###,##0.00")
      Else
         Flt_Result.ForeColor = &H0&
      End If
      Table1.TextMatrix(Table1.Row, 0) = Data1.Recordset("tm_venta")
      KeyAscii = 0
      Call Llenar_Grilla
      Table1.Row = Fila
      
      Table1.Col = Ven_VPAR
      Text1.CantidadDecimales = 4
      Text1.Text = "100"  '' "100.0000"  VGS (03/07/2005)
      Call Text1_KeyDown(vbKeyReturn, 0)
   End If

   If KeyAscii = 66 Then
      If VENTA_VerDispon(FormHandle, Data1) Then
         If Data1.Recordset("tm_venta") = " " Or Data1.Recordset("tm_venta") = "*" Then
            If VENTA_Bloquear(0, Data1) Then
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "B"
               Data1.Recordset.Update

            Else
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "*"
               Data1.Recordset.Update

            End If

            Table1.TextMatrix(Table1.Row, 0) = Data1.Recordset("tm_venta")

            For I = 0 To Table1.cols - 1
               Table1.Col = I
               Call Table1_LeaveCell

            Next I

         End If

      End If

   End If

   If filita <= Table1.Rows - 1 Then
      Table1.Row = filita

   Else
      Table1.Row = Table1.Rows - 1

   End If

   Table1.Col = Columna
   Table1.SetFocus

   Table1.ScrollBars = flexScrollBarBoth
   Table1.TopRow = nRowTop

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
'        Flt_Result.caption = VENTA_SumarDif(FormHandle)
'        If Val(Flt_Result.caption) < 0 Then
'            Flt_Result.ForeColor = &HFF&
'            Flt_Result.caption = Abs(Val(Flt_Result.caption))
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

   If Table1.Row <> 0 And Table1.Col > 1 Then
        Table1.CellFontBold = True
        If Table1.TextMatrix(Table1.Row, 0) = "V" Then
            Table1.CellBackColor = vbBlue
            Table1.CellForeColor = vbWhite
        ElseIf Table1.TextMatrix(Table1.Row, 0) = "P" Then
            Table1.CellBackColor = vbCyan
            Table1.CellForeColor = vbBlack
        ElseIf Table1.TextMatrix(Table1.Row, 0) = "*" Then
            Table1.CellBackColor = vbGreen + vbWhite    'vbBlack
            Table1.CellForeColor = vbWhite
        ElseIf Table1.TextMatrix(Table1.Row, 0) = "B" Then
            Table1.CellBackColor = vbBlack + vbWhite    'vbBlack
            Table1.CellForeColor = vbBlack
        Else
            Table1.CellBackColor = vbBlack
            Table1.CellForeColor = vbBlack

        End If
        Table1.CellFontBold = False

    End If

End Sub

Private Sub Table1_RowColChange()

    Table1.CellBackColor = &H808000
    Table1.CellForeColor = vbWhite

End Sub


Private Sub Table1_Scroll()
Text1_LostFocus
End Sub

Private Sub Table1_SelChange()

'    If Table1.Row <> 0 And Table1.Col > 1 Then
'        Table1.CellFontBold = True
'        If Table1.TextMatrix(Table1.Row, 0) = "V" Then
'            Table1.CellBackColor = vbBlue
'            Table1.CellForeColor = vbWhite
'        ElseIf Table1.TextMatrix(Table1.Row, 0) = "P" Then
'            Table1.CellBackColor = vbCyan
'            Table1.CellForeColor = vbBlack
'        ElseIf Table1.TextMatrix(Table1.Row, 0) = "*" Then
'            Table1.CellBackColor = vbGreen + vbWhite    'vbBlack
'            Table1.CellForeColor = vbWhite
'        Else
'            Table1.CellBackColor = vbBlack
'            Table1.CellForeColor = vbBlack
'
'        End If
'        Table1.CellFontBold = False
'
'    End If

End Sub

Private Sub Text1_GotFocus()
'Text1.Text = Table1.TextMatrix(Table1.Row, Table1.Col)
'Text1.SelStart = 0 'Len(TEXT1)
'Text1.SelLength = Len(Text1)
 If Table1.Col = 6 Then
    
    Text1.SelStart = Len(Text1.Text)
 Else
    If bFlagDpx Then
         Text1.SelStart = Len(Text1.Text) - 3
    Else
        Text1.SelStart = Len(Text1.Text) - 5
    End If
 End If

End Sub


Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)
Dim I As Integer
Dim Fila As Integer
Dim Anterior As Double

If KeyCode = 27 Then
   Text1.Visible = False
   Text1.Text = 0
   Table1.SetFocus
End If

Dim v As String
Dim Colum As Integer
Dim nTopRow As Integer

nTopRow = Table1.TopRow

Fila = Table1.Row
Antes_Flag = True
tipo = "VP"
Anterior = Table1.TextMatrix(Table1.Row, Table1.Col)

If KeyCode = 13 Then
   Colum = Table1.Col
    If Not Table1.Row = 1 Then
            Call Colocardata1
    Else
            Data1.Recordset.MoveFirst
    End If
  
 ' ENTEREDIT
   iFlagKeyDown = False
   
    If Table1.Col = Ven_NOMINAL Then
       bufNominal = Val(Data1.Recordset("tm_nominalo"))
    End If
 'UPDATE
 On Error GoTo ExitEditError

Dim Columna%
Dim reg As Double

    MousePointer = 11
           
    Columna = Table1.Col
    
    If Data1.Recordset.RecordCount = 0 Then
        MousePointer = 0
        Exit Sub
    End If

    Data1.Recordset.Edit
    'Data1.Recordset.Update
    
    'Para que el datos aparezca en la grid
    BacControlWindows 60
    Table1.TextMatrix(Table1.Row, Table1.Col) = Text1.Text
    If Columna = Ven_NOMINAL Then
        Data1.Recordset!tm_nominal = Text1.Text
        Data1.Recordset.Update
        If VENTA_VerDispon(FormHandle, Data1) Then
            If CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL)) <> Data1.Recordset("tm_nominalo") Then
                If CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL)) > bufNominal Then
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
                
        If CDbl(Table1.TextMatrix(Table1.Row, Ven_TIR)) <> 0 Then
            Call VENTA_Valorizar(2, Data1, txtFechaSorteo.Text)
        ElseIf CDbl(Table1.TextMatrix(Table1.Row, Ven_TIR)) <> 0 Then
                Call VENTA_Valorizar(1, Data1, txtFechaSorteo.Text)
        ElseIf CDbl(Table1.TextMatrix(Table1.Row, Ven_VPAR)) <> 0 Then
                Call VENTA_Valorizar(3, Data1, txtFechaSorteo.Text)
        End If
        
    ElseIf Columna = Ven_TIR Then
      If Data1.Recordset!tm_codigo <> 98 Then
' se quita esta funcion ya que ahora es por Control Financiero
'           If Not Validar_Tasa("VP", Data1.Recordset("tm_monemi"), CDbl(text1.Text)) Then
'               Table1.TextMatrix(Table1.Row, Table1.Col) = Format(Anterior, "###,###.###0")
'               MousePointer = 0
'               Table1.SetFocus
'              Exit Sub
'           End If
      End If
            Data1.Recordset!TM_TIR = Text1.Text
            Data1.Recordset.Update
            Call VENTA_Valorizar(2, Data1, txtFechaSorteo.Text)
            
    ElseIf Columna = Ven_VPAR Then
            Data1.Recordset!TM_Pvp = Text1.Text
            Data1.Recordset.Update
            Call VENTA_Valorizar(1, Data1, txtFechaSorteo.Text)
            If Not Antes_Flag Then
                Table1.TextMatrix(Table1.Row, Table1.Col) = Anterior
                Data1.Recordset.Edit
                Data1.Recordset!TM_Pvp = Anterior
                Data1.Recordset.Update
            
            End If
            
    ElseIf Columna = Ven_VPS Then
            Data1.Recordset!TM_VP = Text1.Text
            Data1.Recordset.Update
            Call VENTA_Valorizar(3, Data1, txtFechaSorteo.Text)
            If Not Antes_Flag Then
                Table1.TextMatrix(Table1.Row, Table1.Col) = Anterior
                Data1.Recordset.Edit
                Data1.Recordset!TM_VP = Anterior
                Data1.Recordset.Update
            
            End If
            
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
        Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")
        If CDbl(Flt_Result.Caption) < 0 Then
            Flt_Result.ForeColor = &HFF&
            Flt_Result.Caption = Format(Abs(CDbl(Flt_Result.Caption)), "###,###,###,##0.00")
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
    Text1.Text = ""
    Text1.Visible = False
    Table1.Col = Colum
    Table1.Row = Fila
   Table1.TopRow = nTopRow
End If

    Exit Sub
    
ExitEditError:

    MousePointer = 0
    'MsgBox Error(Err), vbExclamation, "Mensaje"
'    Resume
'    Data1.Refresh
    ' hipolito
    iFlagKeyDown = True
    Table1.Row = Table1.Rows - 1
    Table1.TextMatrix(Table1.Row, 3) = Format(Monto, "###,###,###,##0.0000")
    Text1.Visible = False
    Exit Sub

End Sub

Private Sub Text1_LostFocus()
On Error Resume Next
'text1.Text = 0
Text1.Visible = False
BacControlWindows 100
Table1.SetFocus
'SendKeys "{right}"
End Sub

Private Sub Text2_GotFocus()
Call PROC_POSI_TEXTO(Table1, Text2)
Text2.SelLength = Len(Text2)
Text2.SelStart = Len(Text2)
End Sub

Private Sub Text2_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 27 Then
    Text2_LostFocus
End If

If KeyCode = 13 Then
  If Not Table1.Rows = 1 Then
        Call Colocardata1
  Else
         Data1.Recordset.MoveFirst
  End If
        Data1.Recordset.Edit
        Data1.Recordset!tm_clave_dcv = Text2.Text
        Data1.Recordset.Update
        Table1.TextMatrix(Table1.Row, 8) = Trim(Text2.Text)
        Table1.SetFocus
End If
End Sub

Private Sub Text2_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Text2_LostFocus()
Text2.Text = ""
Text2.Visible = False
Table1.SetFocus
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Key
      Case Is = "cmbgrabar"
         Call TOOLGRABAR
         BacIrfNueVentana "ST"
         Unload Me
      Case Is = "cmbvende"
         'Call TOOLVENDE
         Table1_KeyPress (118)
      Case Is = "cmbrestaura"
         Table1_KeyPress (114)
        'Call TOOLRESTAURAR
      Case Is = "cmbfiltrar"
         Call TOOLFILTRAR
      Case Is = "cmbversel"
         Call TOOLVER_SELEC
      Case Is = "cmbemision"
         Call TOOLEMISION
      Case Is = "cmbcortes"
         Call TOOLCORTES
      Case Is = "valorizaciones"
         If Table1.TextMatrix(1, 1) <> "" Then
            tir = CDbl(Table1.TextMatrix(Table1.Row, 4))
            ValorTir = Table1.TextMatrix(Table1.Row, 6)
            Durmacori = Table1.TextMatrix(Table1.Row, 14)
            Durmodori = Table1.TextMatrix(Table1.Row, 15)
            Convex = Table1.TextMatrix(Table1.Row, 16)
            BacVaTasasVp.Show 1
      End If
   End Select
   BacControlWindows 30
End Sub

Function TOOLGRABAR()
   Dim rRs As Recordset

   Data1.Refresh
   Set rRs = db.OpenRecordset("SELECT DISTINCT tm_monemi FROM MDVENTA WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )", dbOpenSnapshot)

   If rRs.RecordCount > 0 Then
      If Not IsNull(rRs.Fields("tm_monemi")) Then
         BacIrfGr.proMoneda = IIf(rRs.Fields("tm_monemi") = 13, gsBac_Dolar, "$$")
      End If
   End If
   If FUNC_Verifica_Papeles() Then
      MsgBox "No puede mesclar monedas MX/$ o MX/MX diferentes", vbExclamation, TITSISTEMA
      Table1.SetFocus
      Exit Function
   End If
   
   BacIrfGr.proMtoOper = TxtTotal.Text
   BacIrfGr.proHwnd = Hwnd
   BacIrfGr.FechaSorteoLetras = txtFechaSorteo.Text
   BacIrfGr.FechaReal = txtFechaSorteo.Tag
   BacIrfGr.cCodLibro = BacSH.cCodLibro
   BacIrfGr.cCodCartFin = BacSH.cCodCartFin
   
   Call BacGrabarTX
   
   BacControlWindows 100
   
   If Not Grabacion_Operacion Then
      Data1.Refresh
   Else
      FiltraVentaAutomatico = True
      giAceptar = True
      Call Nombre_Grilla
     'Call TipoFiltro
      Me.Tag = "ST"
   End If
End Function

Function FUNC_Verifica_Papeles() As Boolean
Dim nMoneda As Long

FUNC_Verifica_Papeles = False

With Data1.Recordset

    .MoveFirst
    
    Do While Not .EOF
        
        If .Fields("Tm_Venta") = "V" Or .Fields("Tm_Venta") = "P" Then
        
            If nMoneda = 0 Then
                nMoneda = .Fields("Tm_Monemi")
            End If
            
            If nMoneda <> .Fields("Tm_Monemi") Then
                Select Case nMoneda
                    Case 999, 998, 997, 995, 994
                        If .Fields("Tm_Monemi") = 999 Or _
                            .Fields("Tm_Monemi") = 998 Or _
                            .Fields("Tm_Monemi") = 997 Or _
                            .Fields("Tm_Monemi") = 995 Or _
                            .Fields("Tm_Monemi") = 994 Then
                            
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
            
        End If
        
        .MoveNext
        
    Loop
    .MoveFirst
    
End With

End Function


Sub TipoFiltro()

 If Toolbar1.Buttons(6).Tag = "Ver Todos" Then
        Toolbar1.Buttons(6).Tag = "Ver Sel."
        Toolbar1.Buttons(6).ToolTipText = "Ver Selección"
            'CmdTipoFiltro.Caption = "Ver Sel."
       ' Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= " & "0" ' txtplazo.Text
       ' Data1.Refresh
    Else
        filita = Table1.Row
        If TxtTotal.Text > 0 Then
         Toolbar1.Buttons(6).Tag = "Ver Todos"
         Toolbar1.Buttons(6).ToolTipText = "Ver Todos"
            'CmdTipoFiltro.Caption = "Ver Todos"
        '    Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= " & "0" ' txtplazo.Text & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
        '    Data1.Refresh
        End If
    End If
    
    'TxtCartera.Text = VENTA_SumarCartera(FormHandle, txtplazo.Text, Toolbar1)
    
    Table1.Rows = 2
    Table1.Row = 0
    'Do While Not Data1.Recordset.EOF
    '   TABLE1.Rows = TABLE1.Rows + 1
    '   TABLE1.Row = TABLE1.Rows - 1
       Call Llenar_Grilla
    '   If Not Data1.Recordset.EOF Then
    '        Data1.Recordset.MoveNext
    '   End If
    'Loop
    If filita <= Table1.Rows - 1 Then
    Table1.Row = filita
   End If
    'Table1.SetFocus
 
End Sub



Function TOOLVENDE()
   filita = Table1.Row
Dim fila_table As Integer
If Table1.Row = 0 Then Exit Function 'insertado05/02/2001
If Data1.Recordset.RecordCount = 0 Then Exit Function

fila_table = Table1.Row - 1

If VENTA_VerDispon(FormHandle, Data1) Then
    If Not Table1.Row = 1 Then
            Call Colocardata1
    Else
            Data1.Recordset.MoveFirst
    End If
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
         Table1.TextMatrix(Table1.Row, 8) = Data1.Recordset("tm_clave_dcv")
      Else
         Data1.Recordset.Edit
         Data1.Recordset("tm_venta") = "*"
         Data1.Recordset.Update
      End If
       Table1.TextMatrix(Table1.Row, 0) = Data1.Recordset("tm_venta")
   End If

End If

TxtTotal.Text = VENTA_SumarTotal(FormHandle)
Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")

Data1.Refresh
Data1.Recordset.Move fila_table
Call colores
Table1.SetFocus
Table1.Refresh
If filita <= Table1.Rows - 1 Then
    Table1.Row = filita
Else
    Table1.Row = Table1.Rows - 1
End If

Table1.Col = 2
Table1.SetFocus
End Function
Function TOOLRESTAURAR()
  filita = Table1.Row

valor = True

If Table1.Row = 0 Then
   Exit Function 'insertado05/02/2001
End If

If Data1.Recordset.RecordCount = 0 Then
   Exit Function
End If

If Not Table1.Row = 1 Then
    Call Colocardata1
Else
    Data1.Recordset.MoveFirst
End If

Call VENTA_VerDispon(FormHandle, Data1)

If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then

       If VENTA_DesBloquear(FormHandle, Data1) Then

            Data1.Recordset.Edit
            Data1.Recordset("tm_venta") = " "
            Data1.Recordset("tm_clave_dcv") = ""
            Data1.Recordset.Update
            Table1.TextMatrix(Table1.Row, 0) = Data1.Recordset("tm_venta")
            Table1.TextMatrix(Table1.Row, 7) = Data1.Recordset("tm_clave_dcv")

            If Toolbar1.Buttons(6).Tag = "Ver Todos" And Table1.Rows - 1 = 1 Then
               Toolbar1.Buttons(6).Tag = "Ver Sel."
               Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= 1"
               Data1.Refresh
            ElseIf Toolbar1.Buttons(6).Tag = "Ver Todos" And Data1.Recordset.RecordCount > 1 Then
               Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
               Data1.Refresh
            End If

       End If

    If Data1.Recordset("tm_venta") = "*" Then

       If VENTA_VerBloqueo(FormHandle, Data1) Then
          Data1.Recordset.Edit
          Data1.Recordset("tm_venta") = " "
          Data1.Recordset.Update
       End If

    End If

    If Data1.Recordset.RecordCount > 0 Then
       Call VENTA_Restaurar(Data1)
    End If
      
    Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))

      TxtTotal.Text = VENTA_SumarTotal(FormHandle)
      Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")
      Data1.Recordset.MoveLast
      Table1.Rows = Data1.Recordset.RecordCount + 1
      Data1.Refresh
      Call refresca

   If filita <= Table1.Rows - 1 Then
      Table1.Row = filita
   Else
      Table1.Row = Table1.Rows - 1
   End If

    Table1.Refresh
    Table1.Col = 2
    Table1.SetFocus
    
End If

End Function


Function TOOLFILTRAR()
   
   Dim Envia1 As Variant
   Dim Sql    As String
   Dim Datos()
   Dim nSw%
   Dim x As Integer
   On Error GoTo ErrFiltro
'   Call desbloquear
   nSw = 0
   BacIrfSl.ProTipOper = "VP"
   BacIrfSl.bFlagDpx = bFlagDpx
   BacIrfSl.Show vbModal
   Envia1 = Envia
   valor = True

   If giAceptar% = True Then
        Call VENTA_EliminarBloqueados(Data1, FormHandle)
        Call VENTA_BorrarTx(FormHandle)
        
        Envia = Envia1
        Envia(Pos_Libro) = Trim(Right(Envia(Pos_Libro), 10))
        
        BacSH.cCodCartFin = Trim(Right(Envia(Pos_CartFin), 10))
        BacSH.cCodLibro = Trim(Right(Envia(Pos_Libro), 10))
        
    
        gsBac_CartRUT = RutCartV
        gsBac_CartDV = DvCartV
        gsBac_CartNOM = NomCartV

        nRutCartV = RutCartV
        cDvCartV = DvCartV
        cNomCartV = NomCartV

        Screen.MousePointer = vbHourglass

        If bFlagDpx Then
            Sql = "SP_FILTRARCART_VU"
        Else
            Sql = "SP_FILTRARCART_VP"
        End If

        If Bac_Sql_Execute(Sql, Envia) Then
            sFiltro = gSQL
            
            If Data1.Recordset.RecordCount > 0 Then
               db.Execute "DELETE * FROM mdventa"
               Data1.Refresh
            End If
            Do While Bac_SQL_Fetch(Datos())
                If Datos(12) <> "" Then
                  Call VENTA_Agregar(Data1, Datos(), Hwnd, "VP")
                  Data1.Recordset.MoveLast
                  nSw = 1
                End If
            Loop
                     
            Table1.Clear
            Table1.Rows = 2
            Call Nombre_Grilla
            
            Call Llenar_Grilla


            If nSw > 0 Then
                Toolbar1.Buttons(6).Tag = "Ver Sel."
                Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= 1"
                Data1.Refresh

                TxtTotal.Text = VENTA_SumarTotal(FormHandle)
                Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")
                TxtCartera.Text = VENTA_SumarCartera(FormHandle, "1", Toolbar1)
                Table1.Enabled = True
            Else
                Toolbar1.Buttons(6).Tag = "Ver Sel."
                Table1.Col = 1
                Toolbar1.Buttons(6).Enabled = False
                Table1.Enabled = False
                TxtInv.Enabled = True
            End If

If Table1.Row = 0 Then
   Toolbar1.Buttons(7).Enabled = False
   Toolbar1.Buttons(6).Enabled = False
   Toolbar1.Buttons(8).Enabled = False
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False
   TxtTotal.Enabled = False
End If


            If Data1.Recordset.RecordCount > 0 Then
                Toolbar1.Buttons(7).Enabled = True
                Toolbar1.Buttons(6).Enabled = True
                Toolbar1.Buttons(8).Enabled = True
                Toolbar1.Buttons(2).Enabled = True
                Toolbar1.Buttons(3).Enabled = True
                Toolbar1.Buttons(4).Enabled = True
                TxtTotal.Enabled = True
            End If


        Else
            Table1.Rows = 1

        End If

        Screen.MousePointer = 0

    End If
    
    Exit Function
ErrFiltro:
    Table1.Redraw = True
    MsgBox "Problemas en filtro de cartera para ventas definitivas: " & err.Description
    Screen.MousePointer = 0
    Exit Function
End Function


Function TOOLVER_SELEC()
   
   If Toolbar1.Buttons(6).ToolTipText = "Ver Todos" Then

      Toolbar1.Buttons(6).ToolTipText = "Ver Seleccion"
      Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= 1"
      Data1.Refresh
    
   Else
      filita = Table1.Row
      If CDbl(TxtTotal.Text) > 0 Then
         'CmdTipoFiltro.Caption = "Ver Todos"
          Toolbar1.Buttons(6).Tag = "Ver Todos"
          Toolbar1.Buttons(6).ToolTipText = "Ver Todos"
          Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
          Data1.Refresh
      End If
   End If
   
   Do While Not Data1.Recordset.EOF
      Call Llenar_Grilla
   Loop

   TxtCartera.Text = VENTA_SumarCartera(FormHandle, "1", Toolbar1)
   valor = True
   If filita <= Table1.Rows - 1 Then
    Table1.Row = filita
   End If
   Table1.SetFocus

End Function
Function TOOLEMISION()
If Table1.Row = 0 Then Exit Function 'insertado05/02/2001
    BacControlWindows 100
    Data1.Refresh
    If Data1.Recordset.RecordCount = 0 Then
        Exit Function
    End If
    BacControlWindows 100
    If Not Table1.Row = 1 Then
            Call Colocardata1
    Else
            Data1.Recordset.MoveFirst
    End If
    BacControlWindows 100
    If Trim$(Data1.Recordset("tm_instser")) = "" Then
        Beep
        Exit Function
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
    Table1.SetFocus

End Function

Function TOOLCORTES()

Dim Nominal#
If Table1.Row = 0 Then Exit Function 'insertado05/02/2001
   Fila = Table1.RowSel
   If Data1.Recordset.RecordCount = 0 Then
      Exit Function
   End If

   Table1.Row = Fila

   If Not Table1.Row = 1 Then
      Call Colocardata1

   Else
      Data1.Recordset.MoveFirst

   End If

   Nominal# = CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL))
   bufNominal = Val(Data1.Recordset("tm_nominalo"))

   If Nominal = 0 Then
      Exit Function
   End If
    
   If VENTA_VerDispon(FormHandle, Data1) = False Then
      Exit Function

   End If

   Set BacFrmIRF = Me
   'Fila = Table1.Row
   BacControlWindows 30
   BacIrfCo.Show 1
   BacControlWindows 30

   
    
   If Not Table1.Row = 1 Then
      Call Colocardata1

   Else
      Data1.Recordset.MoveFirst

   End If
    
   If Table1.TextMatrix(Table1.Row, 0) <> "N" Then
      Data1.Recordset.Edit
      Data1.Recordset!tm_nominal = Table1.TextMatrix(Table1.Row, Ven_NOMINAL)
      Text1.Text = Table1.TextMatrix(Table1.Row, Ven_NOMINAL)
      Data1.Recordset.Update

      If Nominal# <> CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL)) Or (Table1.TextMatrix(Table1.Row, 0) = "V") Then
         If Data1.Recordset!tm_venta <> "*" And Data1.Recordset!tm_venta <> " " Then Call VENTA_DesBloquear(FormHandle, Data1)
            If VENTA_Bloquear(FormHandle, Data1) Then
               Data1.Recordset.Edit
               If CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL)) < Nominal# Then
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

      Call Llenar_Grilla
      Table1.Row = Fila
      Table1.Col = 3
      Call Text1_KeyDown(13, 0)
   Else
      Table1.TextMatrix(Table1.Row, 0) = " "

  End If
'   If table1.TextMatrix(table1.Row, 0) = "N" Then table1.TextMatrix(table1.Row, 0) = " "
'   Call Llenar_Grilla
'   table1.Row = Fila
   Table1.Col = 3
'   Call Text1_KeyDown(13, 0)
   Table1.SetFocus


End Function



Private Sub txtFechaSorteo_Change()
   lblDiaSemana.Caption = BacDiaSem(CStr(txtFechaSorteo.Text))
   lblDiaSemana.ForeColor = vbBlue
   If Weekday(txtFechaSorteo.Text) = 1 Or Weekday(txtFechaSorteo.Text) = 7 Then lblDiaSemana.ForeColor = vbRed
   
   If CDate(txtFechaSorteo.Text) <= CDate(gsBac_Fecp) Then
      MsgBox "La fecha de Sorteo de debe ser menor a la fecha de próximo proceso.", vbExclamation, TITSISTEMA
      txtFechaSorteo.Text = Format(gsBac_Fecx, "dd/mm/yyyy")
      Exit Sub
   End If
   txtFechaSorteo.Tag = txtFechaSorteo.Text
   If BacEsHabil(txtFechaSorteo.Text) = False Then
      lblDiaSemana.ForeColor = vbRed
      txtFechaSorteo.Tag = BacProxHabil(txtFechaSorteo.Text)
   End If
   
   Me.MousePointer = 11
   Table1.Redraw = False
   Dim iContador  As Long
   For iContador = 0 To Table1.Rows - 1
      If Table1.TextMatrix(iContador, 0) = "V" Then
         Text1.Text = Table1.TextMatrix(iContador, 5)
         Table1.Row = iContador
         Table1.Col = 5
         Call Text1_KeyDown(vbKeyReturn, 0)
      End If
   Next iContador
   Me.MousePointer = 0
   Table1.Redraw = True
   
   If Table1.Enabled = True And Table1.TextMatrix(1, 1) <> "" Then Table1.SetFocus
   
End Sub

Private Sub TxtInv_Change()
    If TxtInv.Text > 0 Then
       TxtSaldo.Text = TxtSel.Text - TxtInv.Text
    Else
       TxtSaldo.Text = 0
    End If
End Sub

Private Sub TxtInv_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      KeyAscii = 0
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
    TxtTotal.Text = IIf(TxtTotal.Text = "", "0", TxtTotal.Text)
    If Toolbar1.Buttons(6).Tag = "Ver Sel." And CDbl(TxtTotal.Text) = 0 Then
        Toolbar1.Buttons(6).Enabled = False
    Else
        Toolbar1.Buttons(6).Enabled = True
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
            If Colocardata1 = False Then
               Exit Sub
            End If
            
    Else
            Data1.Recordset.MoveFirst
End If
    If TxtTotal.Tag <> TxtTotal.Text Then
        If TxtTotal.Tag = "" Then
           TxtTotal.Tag = 0#
        End If
        
        dTotalActual# = CDbl(TxtTotal.Tag)
        dTotalNuevo# = CDbl(TxtTotal.Text)
        If VPVI_ChkTipoCambio(FormHandle&) = False Then
            MsgBox "DEBE INGRESAR EL TIPO DE CAMBIO PARA TODOS LOS INSTRUMENTOS", vbExclamation, "Mensaje"
        Else
            Call VENTA_ValorizarTotal(Data1, dTotalNuevo#, dTotalActual#)
             Data1.Refresh
'             For I = 1 To TABLE1.Rows - 1
              Table1.Row = I
              Call Llenar_Grilla
'              If Not Data1.Recordset.EOF Then
'                Data1.Recordset.MoveNext
'              End If
'            Next I
            Table1.Refresh
        End If
    End If
    
    Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")
        
    If CDbl(Flt_Result.Caption) < 0 Then
        Flt_Result.ForeColor = &HFF&
        Flt_Result.Caption = Format(Abs(CDbl(Flt_Result.Caption)), "###,###,###,##0.00")
    Else
        Flt_Result.ForeColor = &H0&
    End If
    
    Screen.MousePointer = 0
'  If Tecla = "13" Then
'      TxtTotal.SetFocus
'  Else
'      Table1.SetFocus
'  End If
    
    
  
End Sub





Private Sub CmdCortes_Click()
'
'   Dim Nominal#
'
'   Fila = TABLE1.RowSel
'   If Data1.Recordset.RecordCount = 0 Then
'      Exit Sub
'   End If
'
'   TABLE1.Row = Fila
'
'   If Not TABLE1.Row = 1 Then
'      Call Colocardata1
'
'   Else
'      Data1.Recordset.MoveFirst
'
'   End If
'
'   Nominal# = CDbl(TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL))
'   bufNominal = Val(Data1.Recordset("tm_nominalo"))
'
'   If Nominal = 0 Then
'      Exit Sub
'   End If
'
'   If VENTA_VerDispon(FormHandle, Data1) = False Then
'      Exit Sub
'
'   End If
'
'   Set BacFrmIRF = Me
'
'   BacControlWindows 30
'   BacIrfCo.Show 1
'   BacControlWindows 30
'
'   TABLE1.Row = Fila
'
'   If Not TABLE1.Row = 1 Then
'      Call Colocardata1
'
'   Else
'      Data1.Recordset.MoveFirst
'
'   End If
'
'   Data1.Recordset.Edit
'   Data1.Recordset!tm_nominal = TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL)
'   Data1.Recordset.Update
'
'   If Nominal# <> CDbl(TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL)) Then
'      If VENTA_Bloquear(FormHandle, Data1) Then
'         Data1.Recordset.Edit
'         If CDbl(TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL)) < Nominal# Then
'            Data1.Recordset!tm_venta = "P"
'
'         Else
'            Data1.Recordset!tm_venta = "V"
'
'         End If
'
'         Data1.Recordset.Update
'
'      End If
'
'   Else
'      Data1.Recordset.Edit
'      Data1.Recordset.Update
'
'   End If
'
'   Call Llenar_Grilla
'
'   TABLE1.SetFocus
'
End Sub


Private Sub CmdEmision_Click()
'    BacControlWindows 100
'    Data1.Refresh
'    If Data1.Recordset.RecordCount = 0 Then
'        Exit Sub
'    End If
'    BacControlWindows 100
'    If Not TABLE1.Row = 1 Then
'            Call Colocardata1
'    Else
'            Data1.Recordset.MoveFirst
'    End If
'    BacControlWindows 100
'    If Trim$(Data1.Recordset("tm_instser")) = "" Then
'        Beep
'        Exit Sub
'    End If
'
'    'Guarda datos en variable global
'    With BacDatEmi
'        .sInstSer = Data1.Recordset("tm_instser")
'        .lRutemi = Data1.Recordset("tm_rutemi")
'        .iMonemi = Data1.Recordset("tm_monemi")
'        .sFecEmi = Data1.Recordset("tm_fecemi")
'        .sFecvct = Data1.Recordset("tm_fecven")
'        .dTasEmi = Data1.Recordset("tm_tasemi")
'        .iBasemi = Data1.Recordset("tm_basemi")
'
'        .sFecpcup = Data1.Recordset("tm_fecpcup")
'        .dNumoper = Data1.Recordset("tm_numdocu")
'        .sTipoper = Data1.Recordset("tm_tipoper")
'        .sFecvtop = Data1.Recordset("tm_fecsal")
'        .iDiasdis = DateDiff("d", gsBac_Fecp, CDate(Data1.Recordset("tm_fecsal")))
'
'    End With
'
'    BacIrfDg.Tag = "VP"
'    BacIrfDg.Show 1
'
'    BacControlWindows 12
'    TABLE1.SetFocus

End Sub

Private Sub CmdFiltro_Click()
'Dim datos()
'Dim nSw%
'Dim X As Integer
'On Error GoTo ErrFiltro
'
'        nSw = 0
'        BacIrfSl.proTipOper = "VP"
'        BacIrfSl.Show vbModal
'        Valor = True
'
'    If giAceptar% = True Then
'
'        gsBac_CartRUT = RutCartV
'        gsBac_CartDV = DvCartV
'        gsBac_CartNOM = NomCartV
'
'        nRutCartV = RutCartV
'        cDvCartV = DvCartV
'        cNomCartV = NomCartV
'
'        gSQL = "SP_FILTRARCART_VP " & gSQL
'
'        Screen.MousePointer = 11
'
'        Call VENTA_EliminarBloqueados(Data1, FormHandle)
'        Call VENTA_BorrarTx(FormHandle)
'
'        Data1.Refresh
'
'        If miSQL.SQL_Execute(gSQL) = 0 Then
'
'            sFiltro = gSQL
'             TABLE1.Rows = 2
'            Do While Bac_SQL_Fetch(Datos())
'
'                If datos(12) > "" Then
'                    Call VENTA_Agregar(Data1, datos(), hWnd, "VP")
'                    'Data1.Refresh
'                    Data1.Recordset.MoveLast
'                    Call Llenar_Grilla
'                    TABLE1.Rows = TABLE1.Rows + 1
'                    TABLE1.Row = TABLE1.Rows - 1
'                    nSw = 1
'                End If
'            Loop
'
'             TABLE1.Rows = TABLE1.Rows - 1
'            If nSw > 0 Then
'                CmdTipoFiltro.Caption = "Ver Sel."
'
'                Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1"
'                Data1.Refresh
'
'                TxtTotal.Text = VENTA_SumarTotal(FormHandle)
'                Flt_Result.caption = VENTA_SumarDif(FormHandle)
'                TxtCartera.Text = VENTA_SumarCartera(FormHandle, "1", CmdTipoFiltro)
'                TABLE1.Enabled = True
'            Else
'                CmdTipoFiltro.Caption = "Ver Sel."
'                TABLE1.Col = 1
'                CmdTipoFiltro.Enabled = False
'                TABLE1.Enabled = False
'                TxtInv.Enabled = True
'            End If
'
'            If Data1.Recordset.RecordCount > 0 Then
'                CmdEmision.Enabled = True
'                CmdTipoFiltro.Enabled = True
'                CmdCortes.Enabled = True
'                SSC_Grabar.Enabled = True
'                CmdVenta.Enabled = True
'                CmdRestaura.Enabled = True
'                TxtTotal.Enabled = True
'            End If
'
'
'        Else
'            TABLE1.Rows = 1
'            MsgBox "Servidor SQL no Responde", vbExclamation, gsBac_Version
'        End If
'
'        Screen.MousePointer = 0
'
'    End If
'    If TABLE1.Rows <> 1 Then TABLE1.Row = 1: TABLE1.SetFocus
'    Exit Sub
'ErrFiltro:
'    MsgBox "Problemas en filtro de cartera para ventas definitivas: " & Err.Description
'    Exit Sub
End Sub

Private Sub CmdRestaura_Click()
' filita = TABLE1.Row
'Valor = True
'
'If Data1.Recordset.RecordCount = 0 Then Exit Sub
'If Not TABLE1.Row = 1 Then
'            Call Colocardata1
'    Else
'            Data1.Recordset.MoveFirst
'End If
'
'Call VENTA_VerDispon(FormHandle, Data1)
'
'If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
'
'       If VENTA_DesBloquear(FormHandle, Data1) Then
'
'          Data1.Recordset.Edit
'          Data1.Recordset("tm_venta") = " "
'          Data1.Recordset("tm_clave_dcv") = ""
'          Data1.Recordset.Update
'          TABLE1.TextMatrix(TABLE1.Row, 0) = Data1.Recordset("tm_venta")
'          TABLE1.TextMatrix(TABLE1.Row, 7) = Data1.Recordset("tm_clave_dcv")
'          If CmdTipoFiltro.Caption = "Ver Todos" And TABLE1.Rows - 1 = 1 Then
'             CmdTipoFiltro.Caption = "Ver Sel."
'             Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1"
'             Data1.Refresh
'          ElseIf CmdTipoFiltro.Caption = "Ver Todos" And Data1.Recordset.RecordCount > 1 Then
'                 Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
'                 Data1.Refresh
'          End If
'
'       End If
'
'    'End If
'
'    If Data1.Recordset("tm_venta") = "*" Then
'
'       If VENTA_VerBloqueo(FormHandle, Data1) Then
'
'          Data1.Recordset.Edit
'          Data1.Recordset("tm_venta") = " "
'          Data1.Recordset.Update
'       End If
'
'    End If
'
'    If Data1.Recordset.RecordCount > 0 Then
'       Call VENTA_Restaurar(Data1)
'    End If
'
'    Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))
'
'    TxtTotal.Text = VENTA_SumarTotal(FormHandle)
'    Flt_Result.caption = VENTA_SumarDif(FormHandle)
'     Data1.Recordset.MoveLast
'     TABLE1.Rows = Data1.Recordset.RecordCount + 1
'     Data1.Refresh
'     Call refresca
'    'For z = 2 To TABLE1.Cols - 1
'    '  TABLE1.Col = z
'    '  TABLE1.CellBackColor = &HC0C0C0
'    '  TABLE1.CellForeColor = &H800000
'    'Next z
'    'TABLE1.Col = 0
'    'Call colores
'    'Call refresca
'
'   If filita <= TABLE1.Rows - 1 Then
'    TABLE1.Row = filita
'   Else
'    TABLE1.Row = TABLE1.Rows - 1
'   End If
'
'    TABLE1.Refresh
'    TABLE1.Col = 2
'    TABLE1.SetFocus
'End If
End Sub

Private Sub CmdTipoFiltro_Click()
'
'    If CmdTipoFiltro.Caption = "Ver Todos" Then
'        CmdTipoFiltro.Caption = "Ver Sel."
'        Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1"
'        Data1.Refresh
'
'
'    Else
'        filita = TABLE1.Row
'        If Val(TxtTotal.Text) > 0 Then
'            CmdTipoFiltro.Caption = "Ver Todos"
'            Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
'            Data1.Refresh
'        End If
'    End If
'    TABLE1.Rows = 1
'    TABLE1.Row = 0
'    Do While Not Data1.Recordset.EOF
'             TABLE1.Rows = TABLE1.Rows + 1
'             TABLE1.Row = TABLE1.Rows - 1
'             Call Llenar_Grilla
'             Data1.Recordset.MoveNext
'    Loop
'
'    TxtCartera.Text = VENTA_SumarCartera(FormHandle, "1", CmdTipoFiltro)
'    Valor = True
'    If filita <= TABLE1.Rows - 1 Then
'     TABLE1.Row = filita
'    End If
'    TABLE1.SetFocus
End Sub


Private Sub CmdVenta_Click()
'filita = TABLE1.Row
'Dim fila_table As Integer
'
'If Data1.Recordset.RecordCount = 0 Then Exit Sub
'
'fila_table = TABLE1.Row - 1
'
'If VENTA_VerDispon(FormHandle, Data1) Then
'    If Not TABLE1.Row = 1 Then
'            Call Colocardata1
'    Else
'            Data1.Recordset.MoveFirst
'    End If
'   If Data1.Recordset("tm_venta") = " " Or Data1.Recordset("tm_venta") = "*" Then
'
'      If VENTA_Bloquear(FormHandle, Data1) Then
'         Data1.Recordset.Edit
'         Data1.Recordset("tm_venta") = "V"
'
'         If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
'            Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
'         Else
'            Data1.Recordset("tm_clave_dcv") = ""
'         End If
'
'         Data1.Recordset.Update
'         TABLE1.TextMatrix(TABLE1.Row, 8) = Data1.Recordset("tm_clave_dcv")
'      Else
'         Data1.Recordset.Edit
'         Data1.Recordset("tm_venta") = "*"
'         Data1.Recordset.Update
'      End If
'       TABLE1.TextMatrix(TABLE1.Row, 0) = Data1.Recordset("tm_venta")
'   End If
'
'End If
'
'TxtTotal.Text = VENTA_SumarTotal(FormHandle)
'Flt_Result.caption = VENTA_SumarDif(FormHandle)
'
'Data1.Refresh
'Data1.Recordset.Move fila_table
'Call colores
'TABLE1.SetFocus
'TABLE1.Refresh
'If filita <= TABLE1.Rows - 1 Then
'    TABLE1.Row = filita
'Else
'    TABLE1.Row = TABLE1.Rows - 1
'End If
'
'TABLE1.Col = 2
'TABLE1.SetFocus
   
End Sub

