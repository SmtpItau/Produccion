VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Anulacion_Anticipo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Anulación de Anticipos"
   ClientHeight    =   6015
   ClientLeft      =   510
   ClientTop       =   1545
   ClientWidth     =   13500
   Icon            =   "Anulacion_Anticipo.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6015
   ScaleWidth      =   13500
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7065
      Top             =   2715
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
            Picture         =   "Anulacion_Anticipo.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Anulacion_Anticipo.frx":0624
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Anulacion_Anticipo.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Anulacion_Anticipo.frx":0EC8
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
      Width           =   13500
      _ExtentX        =   23813
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdGrabar"
            Description     =   "CmdGrabar"
            Object.ToolTipText     =   "Anular Anticipo de SWAP"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdSalir"
            Description     =   "CmdSalir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame frame 
      Height          =   4905
      Index           =   1
      Left            =   60
      TabIndex        =   1
      Top             =   915
      Width           =   13335
      _Version        =   65536
      _ExtentX        =   23521
      _ExtentY        =   8652
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin MSFlexGridLib.MSFlexGrid grdConsulta 
         Height          =   4650
         Left            =   60
         TabIndex        =   2
         Top             =   150
         Width           =   13185
         _ExtentX        =   23257
         _ExtentY        =   8202
         _Version        =   393216
         Cols            =   15
         FixedCols       =   0
         BackColor       =   12632256
         BackColorFixed  =   8421440
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   16777215
         GridColor       =   16777215
         FocusRect       =   2
         HighLight       =   2
         GridLines       =   2
         SelectionMode   =   1
      End
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H00800000&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "ANULAR ANTICIPO"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   345
      Left            =   0
      TabIndex        =   4
      Top             =   585
      Width           =   13965
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00800000&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Consulta"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   345
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   13965
   End
End
Attribute VB_Name = "Anulacion_Anticipo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim SQL   As String
Dim Datos()
Const COL_ESTADO = 0
Const COL_TIPO_PROD = 1
Const COL_NUM_OPER = 2
Const COL_CLIENTE = 3
Const COL_TIPO_OPER = 4
Const COL_MONEDA_RECIBE = 5
Const COL_MONEDA_PAGA = 6
Const COL_MONTO_SALDO_R = 7
Const COL_MONTO_AMORT_R = 8
Const COL_MONTO_SALDO_P = 9
Const COL_MONTO_AMORT_P = 10

Function InicializaGrilla()

   Dim i As Integer


   grdConsulta.Cols = 11
   grdConsulta.Rows = 1
        
        
   grdConsulta.RowHeight(0) = 500
   grdConsulta.TextMatrix(0, COL_ESTADO) = ""
   grdConsulta.TextMatrix(0, COL_TIPO_PROD) = "Tipo"
   grdConsulta.TextMatrix(0, COL_NUM_OPER) = "N° Operación"
   grdConsulta.TextMatrix(0, COL_CLIENTE) = "Cliente"
   grdConsulta.TextMatrix(0, COL_TIPO_OPER) = "Operacion"
   grdConsulta.TextMatrix(0, COL_MONEDA_RECIBE) = "Moneda Recibe"
   grdConsulta.TextMatrix(0, COL_MONEDA_PAGA) = "Moneda Paga"
   grdConsulta.TextMatrix(0, COL_MONTO_SALDO_R) = "Saldo Recibe"
   grdConsulta.TextMatrix(0, COL_MONTO_AMORT_R) = "Amortiza Recibe"
   grdConsulta.TextMatrix(0, COL_MONTO_SALDO_P) = "Saldo Paga"
   grdConsulta.TextMatrix(0, COL_MONTO_AMORT_P) = "Amortiza Paga"

   'grdConsulta.RowHeight(1) = 500
'   grdConsulta.TextMatrix(1, COL_ESTADO) = ""
'   grdConsulta.TextMatrix(1, COL_TIPO_PROD) = "Producto"
'   grdConsulta.TextMatrix(1, COL_NUM_OPER) = ""
'   grdConsulta.TextMatrix(1, COL_CLIENTE) = ""
'   grdConsulta.TextMatrix(1, COL_TIPO_OPER) = ""
'   grdConsulta.TextMatrix(1, COL_MONEDA_RECIBE) = "Recibimos"
'   grdConsulta.TextMatrix(1, COL_MONEDA_PAGA) = "Pagamos"
'   grdConsulta.TextMatrix(1, COL_MONTO_SALDO_R) = "Recibimos"
'   grdConsulta.TextMatrix(1, COL_MONTO_AMORT_R) = "Recibimos"
'   grdConsulta.TextMatrix(1, COL_MONTO_SALDO_P) = "Pagamos"
'   grdConsulta.TextMatrix(1, COL_MONTO_AMORT_P) = "Pagamos"
   
   
   grdConsulta.ColWidth(COL_ESTADO) = 500
   grdConsulta.ColWidth(COL_TIPO_PROD) = 1200
   grdConsulta.ColWidth(COL_NUM_OPER) = 1200
   grdConsulta.ColWidth(COL_CLIENTE) = 3500
   grdConsulta.ColWidth(COL_TIPO_OPER) = 500
   grdConsulta.ColWidth(COL_MONEDA_RECIBE) = 1800
   grdConsulta.ColWidth(COL_MONEDA_PAGA) = 1800
   grdConsulta.ColWidth(COL_MONTO_SALDO_R) = 2500
   grdConsulta.ColWidth(COL_MONTO_AMORT_R) = 2500
   grdConsulta.ColWidth(COL_MONTO_SALDO_P) = 2500
   grdConsulta.ColWidth(COL_MONTO_AMORT_P) = 2500

   'grdConsulta.Row = 0
   

   grdConsulta.Tag = "NO"  'Grilla no tiene datos
End Function

Function FUNC_BUSCA_DATOS() As Boolean

Dim SQL              As String
Dim Datos()
Dim Monto_Saldo_R    As Double
Dim Monto_Amort_R    As Double
Dim Monto_Saldo_P    As Double
Dim Monto_Amort_P    As Double


Envia = Array()

If Not Bac_Sql_Execute("SP_FILTRO_ANTICIPO_ANULACION", Envia) Then Exit Function
    
       
Filas = 0
Numero_Operacion = 0
   
Monto_Saldo_R = 0
Monto_Amort_R = 0
Monto_Saldo_P = 0
Monto_Amort_P = 0
    grdConsulta.Rows = 1
   
    Do While Bac_SQL_Fetch(Datos())
          
            If Numero_Operacion <> Datos(3) Then
               Filas = Filas + 1
               grdConsulta.Rows = grdConsulta.Rows + 1
               Monto_Saldo_R = 0
               Monto_Amort_R = 0
               Monto_Saldo_P = 0
               Monto_Amort_P = 0
            End If
           
            Numero_Operacion = Datos(3)
         
           
            grdConsulta.TextMatrix(Filas, COL_ESTADO) = Datos(1)
            
            grdConsulta.TextMatrix(Filas, COL_TIPO_PROD) = Datos(2)
            grdConsulta.TextMatrix(Filas, COL_NUM_OPER) = Val(Datos(3))
            grdConsulta.TextMatrix(Filas, COL_CLIENTE) = Datos(6)
            grdConsulta.TextMatrix(Filas, COL_TIPO_OPER) = Datos(7)
            grdConsulta.TextMatrix(Filas, COL_MONEDA_RECIBE) = IIf(Trim(Datos(8)) = "", grdConsulta.TextMatrix(Filas, COL_MONEDA_RECIBE), Datos(8))
            grdConsulta.TextMatrix(Filas, COL_MONEDA_PAGA) = IIf(Trim(Datos(9)) = "", grdConsulta.TextMatrix(Filas, COL_MONEDA_PAGA), Datos(9))
            
            Monto_Saldo_R = Monto_Saldo_R + CDbl(Datos(10))
            grdConsulta.TextMatrix(Filas, COL_MONTO_SALDO_R) = Format(Monto_Saldo_R, "#,##0.#0")
            
            Monto_Amort_R = Monto_Amort_R + CDbl(Datos(11))
            grdConsulta.TextMatrix(Filas, COL_MONTO_AMORT_R) = Format(Monto_Amort_R, "#,##0.#0")
                        
            Monto_Saldo_P = Monto_Saldo_P + CDbl(Datos(12))
            grdConsulta.TextMatrix(Filas, COL_MONTO_SALDO_P) = Format(Monto_Saldo_P, "#,##0.#0")
            
            Monto_Amort_P = Monto_Amort_P + CDbl(Datos(13))
            grdConsulta.TextMatrix(Filas, COL_MONTO_AMORT_P) = Format(Monto_Amort_P, "#,##0.#0")
            grdConsulta.Tag = "SI"
            
    Loop

'grdConsulta.Cols = 0
'grdConsulta.Rows = Filas

End Function

Private Function FUNC_ANULA_ANTICIPOS(Numero_Operacion As Double)

   
   Screen.MousePointer = vbHourglass
   
   If CDbl(Numero_Operacion) = 0 Then
      MsgBox "Debe ingresar Número de operacion.", vbCritical
      Exit Function
   End If
   
   
   Envia = Array()
   AddParam Envia, CDbl(Numero_Operacion)


   If Not Bac_Sql_Execute("SP_ANULA_OPERACION_ANTICIPO", Envia) Then
      Exit Function
   End If
   
   MsgBox "Proceso ha finalizado correctamente.", vbInformation, TITSISTEMA
   Screen.MousePointer = vbDefault


End Function

Private Sub Form_Load()
   
   Me.Icon = BACSwap.Icon
   Me.Top = 0
   Me.Left = 0
   InicializaGrilla

   Call FUNC_BUSCA_DATOS
   
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)


If grdConsulta.TextMatrix(grdConsulta.Row, COL_NUM_OPER) = "" And Button.Index = 1 Then MsgBox "Debe seleccionar una operacion", vbCritical: Exit Sub

   Select Case Button.Index
      Case 1
          Call FUNC_ANULA_ANTICIPOS(CDbl(grdConsulta.TextMatrix(grdConsulta.Row, COL_NUM_OPER)))
          InicializaGrilla
          FUNC_BUSCA_DATOS
          FiltrarConsulta_Anticipo.Filtrar
      Case 2
           Unload Me
   End Select
End Sub

