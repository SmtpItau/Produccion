VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacMntSb 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tasa de Mercado"
   ClientHeight    =   5670
   ClientLeft      =   1410
   ClientTop       =   1485
   ClientWidth     =   10380
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmntsb.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5670
   ScaleWidth      =   10380
   Begin Threed.SSPanel Pnl_Avance 
      Height          =   405
      Left            =   45
      TabIndex        =   13
      Top             =   5250
      Width           =   10275
      _Version        =   65536
      _ExtentX        =   18124
      _ExtentY        =   714
      _StockProps     =   15
      ForeColor       =   -2147483634
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   1
      BevelOuter      =   1
      BevelInner      =   2
      RoundedCorners  =   0   'False
      FloodType       =   1
      FloodColor      =   -2147483635
   End
   Begin VB.Frame frm_series 
      BackColor       =   &H80000002&
      Caption         =   "Series con tasa cero"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000009&
      Height          =   2055
      Left            =   5355
      TabIndex        =   11
      Top             =   1635
      Visible         =   0   'False
      Width           =   4935
      Begin VB.ListBox List_ceros 
         BackColor       =   &H00808080&
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1740
         Left            =   90
         TabIndex        =   12
         Top             =   210
         Width           =   4740
      End
   End
   Begin BACControles.TXTNumero TxtGrilla 
      Height          =   375
      Left            =   480
      TabIndex        =   9
      Top             =   2640
      Visible         =   0   'False
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   661
      BackColor       =   -2147483646
      ForeColor       =   -2147483639
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Text            =   "0,0000"
      Text            =   "0,0000"
      Max             =   "99,9999"
      CantidadDecimales=   "4"
      Separator       =   -1  'True
   End
   Begin MSFlexGridLib.MSFlexGrid Table1 
      Height          =   3675
      Left            =   45
      TabIndex        =   7
      Top             =   1560
      Width           =   10305
      _ExtentX        =   18177
      _ExtentY        =   6482
      _Version        =   393216
      FixedCols       =   0
      RowHeightMin    =   315
      BackColor       =   -2147483633
      ForeColor       =   -2147483641
      BackColorFixed  =   -2147483646
      ForeColorFixed  =   -2147483639
      BackColorBkg    =   -2147483636
      AllowBigSelection=   0   'False
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
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5490
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntsb.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntsb.frx":0624
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntsb.frx":093E
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntsb.frx":0C58
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntsb.frx":10AA
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntsb.frx":14FC
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntsb.frx":1816
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntsb.frx":26F0
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tool 
      Height          =   555
      Left            =   15
      TabIndex        =   8
      Top             =   0
      Width           =   10365
      _ExtentX        =   18283
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   10
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "cmdTabular"
            Description     =   "Tabular"
            Object.ToolTipText     =   "Tabular "
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdValorizar"
            Description     =   "Valorizar"
            Object.ToolTipText     =   "Valoriza"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdBuscar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdCerrar"
            Description     =   "Cerrar"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
            Object.Width           =   1e-4
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Importar_detos_ desde_exel"
            Description     =   "Importar datos desde excel"
            Object.ToolTipText     =   "Importar datos desde exel"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "informacion_ceros"
            Object.ToolTipText     =   "Valores de tasas en Ceros"
            ImageIndex      =   8
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   960
      Left            =   60
      TabIndex        =   0
      Top             =   540
      Width           =   10260
      _Version        =   65536
      _ExtentX        =   18098
      _ExtentY        =   1693
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
      Begin BACControles.TXTFecha DateTextTabulacion 
         Height          =   315
         Left            =   8700
         TabIndex        =   6
         Top             =   450
         Visible         =   0   'False
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "09/11/2000"
      End
      Begin BACControles.TXTFecha DateTextFechaVal 
         Height          =   315
         Left            =   500
         TabIndex        =   5
         Top             =   465
         Width           =   1455
         _ExtentX        =   2566
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "09/11/2000"
      End
      Begin BACControles.TXTFecha DateTextCarga 
         Height          =   315
         Left            =   6420
         TabIndex        =   4
         Top             =   450
         Visible         =   0   'False
         Width           =   1320
         _ExtentX        =   2328
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "09/11/2000"
      End
      Begin VB.Label Label1 
         Caption         =   "Ultima Carga"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Left            =   6510
         TabIndex        =   3
         Top             =   240
         Visible         =   0   'False
         Width           =   1185
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "Ultima Tabulación"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   8580
         TabIndex        =   2
         Top             =   240
         Visible         =   0   'False
         Width           =   1635
      End
      Begin VB.Label Label3 
         Caption         =   "Fecha Valorización"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   500
         TabIndex        =   1
         Top             =   225
         Width           =   1815
      End
      Begin VB.Label Lbl_Fecha 
         Caption         =   " Actualizado registros "
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   420
         Left            =   2190
         TabIndex        =   10
         Top             =   375
         Visible         =   0   'False
         Width           =   6405
      End
   End
End
Attribute VB_Name = "BacMntSb"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Con As Integer
Dim Datos()

'CONSTANTES DE BOTONES DE TOOLBAR
' boton 1 es un separador
Const nBtnTabular = 2
Const nBtnGrabar = 3
Const nBtnValorizar = 4
Const nBtnBuscar = 5
Const nBtnLimpiar = 6
Const nBtnCerrar = 7
' boton 8 es un separador
Const nBtnImpExcel = 9
Const nBtnInfCeros = 10

'CONSTANTES DE COLUMNAS DE GRILLA TABLE1
Const nColSerie = 0
Const nColEmisor = 1
Const nColFecVcto = 2
Const nColTasaMerc = 3
Const nColTasaMark = 4
Const nColTasaMarkII = 5
Const nColTasaMarkIII = 6
Const nColCodIns = 7
Const nColRutEmi = 8
Const nColCodMon = 9
Const nColNominal = 10
Const nColRutCart = 11
Const nColFecCompra = 12
Const nColNumOper = 13
Const nColCorrela = 14
Const cTipoCurva = 15

Private Sub HabilitaControles(valor As Boolean)
   Tool.Buttons(1).Enabled = valor
   Tool.Buttons(2).Enabled = valor
   Tool.Buttons(3).Enabled = valor
   Tool.Buttons(4).Enabled = valor
   Tool.Buttons(9).Enabled = valor
   Tool.Buttons(10).Enabled = valor
   
   DateTextCarga.Enabled = False
   DateTextTabulacion.Enabled = False
End Sub

Private Sub Leer_Fechas()
   Dim Datos()
             
   If Bac_Sql_Execute("SP_SBIF_LEERFECHAS") Then
      Do While Bac_SQL_Fetch(Datos())
         DateTextCarga.Text = Datos(1)
         DateTextTabulacion.Text = Datos(2)
      Loop
   Else
      MsgBox "Sql-Server No Responde. Intentelo Nuevamente", vbCritical, Me.Caption
   End If
    
   If Month(gsBac_Fecp) <> Month(gsBac_Fecx) Then
      DateTextFechaVal.Text = Format(DateAdd("d", -1, CDate("01/" + Str(Month(gsBac_Fecx)) + "/" + Str(Year(gsBac_Fecx)))), "dd/mm/yyyy")
   Else
      DateTextFechaVal.Text = Format(gsBac_Fecp, "dd/mm/yyyy")
   End If

End Sub

Private Sub Llenar_Grilla()
   Dim Sql     As String
   Dim SWtext  As Integer
   Dim I       As Integer
   Dim Conta   As Long
   Dim Datos()
   Dim iContador  As Long
   
   Table1.Rows = 1
    
   Envia = Array()
   AddParam Envia, Format(DateTextFechaVal.Text, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_FIN_DE_MES", Envia) Then
      MsgBox "Error Lectura SQL." & vbCrLf & vbCrLf & "Error al consultar. Comuniquese con el Adminisrador." & vbCrLf & vbCrLf & VerSql, vbCritical, TITSISTEMA
      Exit Sub
   End If
   Do While Bac_SQL_Fetch(Datos)
      Sw_Fin_De_Mes = Datos(1)
   Loop
    
   List_ceros.Clear
    
   Envia = Array()
   AddParam Envia, "BTR"
   AddParam Envia, Format(DateTextFechaVal.Text, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_SBIF_LEERMDTM1_NUEVO", Envia) Then
      MsgBox "Error Carga SQL." & vbCrLf & vbCrLf & "Error al Buscar Tasas de Mercado " & Me.Caption, vbCritical, TITSISTEMA
   End If
   
   Let Pnl_Avance.FloodPercent = 0
   Let Pnl_Avance.ForeColor = &H8000000D
   Let iContador = 0
   Do While Bac_SQL_Fetch(Datos())
      Let iContador = iContador + 1
      Pnl_Avance.FloodPercent = (iContador * 100) / (CDbl(Datos(22)))
      If Pnl_Avance.FloodPercent >= 50 Then
         Pnl_Avance.ForeColor = &H8000000E
      End If

      Table1.Rows = Table1.Rows + 1
      If Datos(1) = "NO" Then
         Call HabilitaControles(False)
         Exit Sub
      End If
      Table1.TextMatrix(Table1.Rows - 1, 0) = Datos(1)
      Table1.TextMatrix(Table1.Rows - 1, 1) = Datos(2)
      Table1.TextMatrix(Table1.Rows - 1, 2) = Datos(3)
      Table1.TextMatrix(Table1.Rows - 1, 3) = Format(Datos(19), FDecimal) '--> Format(Datos(4), FDecimal)
      Table1.TextMatrix(Table1.Rows - 1, 4) = Format(Datos(5), FDecimal)
      Table1.TextMatrix(Table1.Rows - 1, 5) = Format(Datos(6), FDecimal)
      Table1.TextMatrix(Table1.Rows - 1, 6) = Format(Datos(7), FDecimal)
      Table1.TextMatrix(Table1.Rows - 1, 7) = Datos(8)
      Table1.TextMatrix(Table1.Rows - 1, 8) = Datos(9)
      Table1.TextMatrix(Table1.Rows - 1, 9) = Datos(10)
      Table1.TextMatrix(Table1.Rows - 1, 10) = Datos(11)
      Table1.TextMatrix(Table1.Rows - 1, cTipoCurva) = Datos(21)
         
      If CDbl(Datos(19)) = 0 Then
         SWtext = 1
         List_ceros.AddItem "Serie con tasa en cero" & "  " & Datos(1) & "  " & Datos(2) & " "
         List_ceros.ItemData(List_ceros.NewIndex) = (Table1.Rows - 1)
      End If
   Loop
   Let Pnl_Avance.FloodPercent = 0
   Let Pnl_Avance.ForeColor = &H8000000D


   If SWtext = 1 Then
      frm_series.Visible = True
      List_ceros.SetFocus
   End If
   Call HabilitaControles(True)
   
End Sub

Private Sub List_ceros_DblClick()
   frm_series.Visible = False
   Table1.SetFocus
   Table1.Row = List_ceros.ItemData(List_ceros.ListIndex)
   Table1.TopRow = List_ceros.ItemData(List_ceros.ListIndex)
   Table1.Col = 3
End Sub

Private Sub Table1_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
   If Button = 2 Then
      frm_series.Visible = True
      List_ceros.SetFocus
   Else
      Table1.SetFocus
      frm_series.Visible = False
   End If
End Sub


Private Function Grabar_tm() As Boolean
   Dim cInstser$, dFecvcto$, cEmisor$, dMonemi#, dTasaMerc#, dTasaMark#, dTasaMark2#, dTasaMark3#
   Dim dRutemi#, dCodinst#, dCodmon#, dNominal#, dNumoper#, dcorrela#
   Dim I    As Long
   Dim Sql2 As String
   Dim SWtext
   Dim Datos()
   
   SWtext = 0
   Grabar_tm = False
    
   Screen.MousePointer = vbHourglass
        
   Envia = Array()
   AddParam Envia, Format(DateTextFechaVal.Text, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_FIN_DE_MES", Envia) Then
      MsgBox "Error en la Grabación." & vbCrLf & "Ha ocurrido un error durante la grabación." & vbCrLf & err.Description, vbCritical, TITSISTEMA
      Exit Function
   End If
   Do While Bac_SQL_Fetch(Datos)
      Sw_Fin_De_Mes = Datos(1)
   Loop
   List_ceros.Clear
   
   With Table1
      For I = 1 To Table1.Rows - 1
         If CDbl(Table1.TextMatrix(I, 3)) = 0 Then
            If CDbl(Table1.TextMatrix(I, 3)) = 0 Then
               SWtext = 1
               List_ceros.AddItem "Serie con tasa en cero." & "  " & Table1.TextMatrix(I, 0) & "  " & Table1.TextMatrix(I, 1)
               List_ceros.ItemData(List_ceros.NewIndex) = I
            End If
         End If
      Next I
   End With
   
   If SWtext = 1 Then
      Screen.MousePointer = vbDefault
      MsgBox "Existen Tasas en cero, No se puede valorizar", vbExclamation, gsBac_Version
      Exit Function
   End If
   
   Envia = Array()
   AddParam Envia, "BTR"
   AddParam Envia, Format(DateTextFechaVal.Text, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_SBIF_BORRATM", Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "Fallo en Borrado de Tasas de Mercado", vbCritical, gsBac_Version
      Exit Function
   End If
   
   With Table1
      Pnl_Avance.FloodType = 1
      Pnl_Avance.FloodPercent = 0
      Pnl_Avance.ForeColor = &H8000000D
      
      For I = 1 To Table1.Rows - 1
         cInstser = Table1.TextMatrix(I, 0)
         cEmisor = Table1.TextMatrix(I, 1)
         dFecvcto = Table1.TextMatrix(I, 2)
         dTasaMerc = Table1.TextMatrix(I, 3)
         dTasaMark = Table1.TextMatrix(I, 4)
         dTasaMark2 = Table1.TextMatrix(I, 5)
         dTasaMark3 = Table1.TextMatrix(I, 6)
         dRutemi = Table1.TextMatrix(I, 7)
         dCodinst = Table1.TextMatrix(I, 8)
         dCodmon = Table1.TextMatrix(I, 9)
         dNominal = Table1.TextMatrix(I, 10)
    
         Envia = Array()
         AddParam Envia, Format(DateTextFechaVal.Text, "yyyymmdd")
         AddParam Envia, cInstser
         AddParam Envia, "BTR"
         AddParam Envia, cEmisor
         AddParam Envia, Format(dFecvcto, "yyyymmdd")
         AddParam Envia, dTasaMerc
         AddParam Envia, dTasaMark
         AddParam Envia, dTasaMark2
         AddParam Envia, dTasaMark3
         AddParam Envia, dRutemi
         AddParam Envia, dCodinst
         AddParam Envia, dCodmon
         AddParam Envia, dNominal
         If Not Bac_Sql_Execute("SP_SBIF_GRABARMDTM", Envia) Then
            Screen.MousePointer = vbDefault
            Pnl_Avance.FloodPercent = 0
            MsgBox "Ha ocurrido un error al intentar grabar las tasas de mercado.", vbCritical, gsBac_Version
            Exit Function
         End If
         Pnl_Avance.FloodPercent = (I * 100) / (Table1.Rows - 1)
         If Pnl_Avance.FloodPercent >= 48 Then
            Pnl_Avance.ForeColor = &H8000000E
         End If
         Call BacControlWindows(20)
      Next I
   End With
   
   Screen.MousePointer = vbDefault
   Pnl_Avance.FloodPercent = 0
   Pnl_Avance.ForeColor = &H8000000D
   MsgBox "Las tasas de mercado han sido grabadas con exito", vbInformation, gsBac_Version

   Grabar_tm = True
   
End Function

Private Sub Form_Load()
   Me.Top = 0: Me.Left = 0
   Me.Icon = BacTrader.Icon
   
   Pnl_Avance.ForeColor = &H8000000D
   
   Call Limpia
End Sub


Sub Nom()
   With Table1
      
      Table1.Cols = 16
      Table1.Rows = 1
      
      Table1.ColWidth(nColSerie) = 1500
      Table1.ColWidth(nColEmisor) = 800
      Table1.ColWidth(nColFecVcto) = 1170
      Table1.ColWidth(nColTasaMerc) = 1300
      Table1.ColWidth(nColTasaMark) = 1100
      Table1.ColWidth(nColTasaMarkII) = 1100
      Table1.ColWidth(nColTasaMarkIII) = 1100
      Table1.ColWidth(nColCodIns) = 0
      Table1.ColWidth(nColRutEmi) = 0
      Table1.ColWidth(nColCodMon) = 0
      Table1.ColWidth(nColNominal) = 0
      Table1.ColWidth(nColRutCart) = 0
      Table1.ColWidth(nColFecCompra) = 0
      Table1.ColWidth(nColNumOper) = 0
      Table1.ColWidth(nColCorrela) = 0
      Table1.ColWidth(cTipoCurva) = 0
      
      Table1.RowHeight(0) = 400
      
      Table1.TextMatrix(0, nColSerie) = "Serie"
      Table1.TextMatrix(0, nColEmisor) = "Emisor"
      Table1.TextMatrix(0, nColFecVcto) = "   Fecha Vcto."
      Table1.TextMatrix(0, nColTasaMerc) = "  Tasa Mercado."
      Table1.TextMatrix(0, nColTasaMark) = " Tasa Market"
      Table1.TextMatrix(0, nColTasaMarkII) = "Tasa Mark (2)"
      Table1.TextMatrix(0, nColTasaMarkIII) = "Tasa Mark (3)"
      Table1.TextMatrix(0, nColCodIns) = "codins"
      Table1.TextMatrix(0, nColRutEmi) = "rutemi"
      Table1.TextMatrix(0, nColCodMon) = "codmon"
      Table1.TextMatrix(0, nColNominal) = "nominal"
      Table1.TextMatrix(0, nColRutCart) = "rutcart"
      Table1.TextMatrix(0, nColFecCompra) = "fecha compral"
      Table1.TextMatrix(0, nColNumOper) = "numoper"
      Table1.TextMatrix(0, nColCorrela) = "correla"
      Table1.TextMatrix(0, cTipoCurva) = "Tipo Curva"

      Table1.Col = 0
   End With
End Sub


Private Sub List_ceros_KeyPress(KeyAscii As Integer)
   If KeyAscii = 27 Then
      frm_series.Visible = False
   End If
   
   If KeyAscii = 13 Then
      frm_series.Visible = False
      Table1.SetFocus
      Table1.Row = List_ceros.ItemData(List_ceros.ListIndex)
      Table1.Col = 3
   End If
End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)
   If Table1.Col >= 3 And Table1.Col < 7 Then
      If KeyAscii = 13 Then
         Call PROC_POSI_TEXTO(Table1, TxtGrilla)
         TxtGrilla.Left = TxtGrilla.Left - 10
         TxtGrilla.Top = TxtGrilla.Top - 15
         TxtGrilla.Height = Table1.CellHeight
         TxtGrilla.Text = BacCtrlTransMonto(Table1.Text)
         TxtGrilla.Visible = True
         TxtGrilla.SetFocus
      Else
         If IsNumeric(Chr(KeyAscii)) Then
            Call PROC_POSI_TEXTO(Table1, TxtGrilla)
            TxtGrilla.Left = TxtGrilla.Left - 10
            TxtGrilla.Top = TxtGrilla.Top - 15
            TxtGrilla.Height = Table1.CellHeight
            TxtGrilla.Visible = True
            TxtGrilla.Text = Chr(KeyAscii)
            TxtGrilla.SetFocus
         End If
      End If
   End If
End Sub

Sub Borrar()
   Dim Largo As Integer
   With Table1
      Table1.Row = Table1.RowSel: Table1.Col = Table1.ColSel
      If Len(Table1.Text) = 0 Then
         Exit Sub
      End If
      Table1.Text = Mid(Table1.Text, 1, Len(Table1.Text) - 1)
   End With
End Sub

Private Sub Tabula()
   Dim Datos()
   Dim Respuesta As String

   If MsgBox("Se Reiniciaran Las Tasas." & vbCrLf & "¿ Desea Continuar ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
      Exit Sub
   End If
    
   Screen.MousePointer = vbHourglass
    
   Call Nom
    
   Table1.Rows = 1
   Table1.Cols = 11
   
   Envia = Array()
   AddParam Envia, "BTR"
   AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")
   AddParam Envia, Format(DateTextTabulacion.Text, "yyyymmdd")
   If Bac_Sql_Execute("SP_SBIF_TRASCARTERA", Envia) Then
      Do While Bac_SQL_Fetch(Datos())
         Table1.Rows = Table1.Rows + 1
         Table1.TextMatrix(Table1.Rows - 1, 0) = Datos(1)
         Table1.TextMatrix(Table1.Rows - 1, 1) = Datos(2)
         Table1.TextMatrix(Table1.Rows - 1, 2) = Datos(3)
         Table1.TextMatrix(Table1.Rows - 1, 3) = Format(Datos(4), FDecimal)
         Table1.TextMatrix(Table1.Rows - 1, 4) = Format(Datos(5), FDecimal)
         Table1.TextMatrix(Table1.Rows - 1, 5) = Format(Datos(6), FDecimal)
         Table1.TextMatrix(Table1.Rows - 1, 6) = Format(Datos(7), FDecimal)
         Table1.TextMatrix(Table1.Rows - 1, 7) = Datos(8)
         Table1.TextMatrix(Table1.Rows - 1, 8) = Datos(9)
         Table1.TextMatrix(Table1.Rows - 1, 9) = Datos(10)
         Table1.TextMatrix(Table1.Rows - 1, 10) = Datos(11)
      Loop
   Else
      Screen.MousePointer = vbDefault
      MsgBox "Error Carga Sql." & vbCrLf & "Problemas al Cargar Tasas de Mercado.", vbCritical, TITSISTEMA
      Exit Sub
   End If
             
   Call Leer_Fechas
    
    Screen.MousePointer = vbDefault
End Sub

Sub Graba()
   
   Screen.MousePointer = vbHourglass
   Call Grabar_tm
   Screen.MousePointer = vbDefault
   
End Sub

Sub Valoriza()
   Dim Sql3        As String
   Dim nContador   As Double
    
   Screen.MousePointer = vbHourglass
   
   Me.Tool.Enabled = False
   Lbl_Fecha.Visible = True
   
   Lbl_Fecha.Caption = "Grabando tasas... por favor espere..."
   
   Call BacControlWindows(10)
   
   If Not Grabar_tm() Then
      Screen.MousePointer = vbDefault
      Lbl_Fecha.Visible = False
      Lbl_Fecha.Caption = "Actualizando Registros."
      Exit Sub
   End If
    
   Screen.MousePointer = vbHourglass
   
   Call BacControlWindows(5)
    
   Pnl_Avance.FloodPercent = 0
   Lbl_Fecha.Caption = "Valorizando... por favor espere..."
    
   Call BacControlWindows(5)
   
   Pnl_Avance.ForeColor = &H8000000D
   
   For nContador = 1 To Table1.Rows - 1
      Envia = Array()
      AddParam Envia, DateTextFechaVal.Text
      AddParam Envia, Trim(Table1.TextMatrix(nContador, nColSerie))
      AddParam Envia, Trim(Table1.TextMatrix(nContador, nColEmisor))
      If Not Bac_Sql_Execute("SP_VALORIZACIONCART", Envia) Then
         GoTo FinForzado
      End If
      
      Envia = Array()
      AddParam Envia, DateTextFechaVal.Text
      AddParam Envia, Trim(Table1.TextMatrix(nContador, nColSerie))
      AddParam Envia, Trim(Table1.TextMatrix(nContador, nColEmisor))
      AddParam Envia, "LT"
      
      If Not Bac_Sql_Execute("SP_VALORIZACIONCART", Envia) Then
         GoTo FinForzadoLt
      End If
      
      If DateTextFechaVal.Text = gsBac_Fecp Then
         Envia = Array()
         AddParam Envia, gsBac_Feca
         AddParam Envia, Trim(Table1.TextMatrix(nContador, nColSerie))
         AddParam Envia, Trim(Table1.TextMatrix(nContador, nColEmisor))
         AddParam Envia, "BT"
         
         If Not Bac_Sql_Execute("SP_VALORIZACIONCART", Envia) Then
            GoTo FinForzadoLt
         End If
      End If
      
      
      Pnl_Avance.FloodPercent = (nContador * 100) / (Table1.Rows - 1)
      If Pnl_Avance.FloodPercent >= 50 Then
         Pnl_Avance.ForeColor = &H8000000E
      Else
         Pnl_Avance.ForeColor = &H8000000D
      End If
      BacControlWindows (20)
      
      Envia = Array()
      AddParam Envia, DateTextFechaVal.Text
      AddParam Envia, Trim(Table1.TextMatrix(nContador, nColSerie))
      AddParam Envia, Trim(Table1.TextMatrix(nContador, nColEmisor))
      AddParam Envia, Trim(Table1.TextMatrix(nContador, cTipoCurva))
      If Not Bac_Sql_Execute("SP_ACTUALIZA_ORIGEN_CURVA", Envia) Then
         GoTo FinForzado
      End If
   Next nContador
        
   Me.Tool.Enabled = True
   Pnl_Avance.FloodPercent = 0
   Pnl_Avance.ForeColor = &H8000000D
   
   Lbl_Fecha.Visible = False
   Lbl_Fecha.Caption = "Actualizando Registros"
    
   Screen.MousePointer = vbDefault
   MsgBox "Valorización a Tasa de Mercado." & vbCrLf & vbCrLf & "La valorización a finalizado con exito.", vbInformation, TITSISTEMA
   
'FM ini 30-05-2008
   Pnl_Avance.FloodPercent = 0
   Lbl_Fecha.Visible = True
   Lbl_Fecha.Caption = "Valorizando Cuotas de Fondos Mutuos... por favor espere..."
   
   Call BacControlWindows(5)
   Envia = Array()
   AddParam Envia, "BTR"
   AddParam Envia, DateTextFechaVal.Text
   If Not Bac_Sql_Execute("SP_VALORIZA_CUOTAS_FMUTUOS", Envia) Then
         GoTo FinForzadoFM
   End If
   
   Screen.MousePointer = vbDefault
   MsgBox "Valorización a Precios Fondos Mutuos." & vbCrLf & vbCrLf & "La valorización a finalizado con exito.", vbInformation, TITSISTEMA

'FM fin 30-05-2008

Exit Sub
FinForzado:
   Screen.MousePointer = vbDefault
   Pnl_Avance.Caption = ""
   Lbl_Fecha.Visible = False
   Lbl_Fecha.Caption = "Actualizando Registros"
   MsgBox "Problemas en la Valorizacion a Mercado", vbCritical
   Me.Tool.Enabled = True
Exit Sub
FinForzadoLt:
   Screen.MousePointer = vbDefault
   Pnl_Avance.Caption = ""
   Lbl_Fecha.Visible = False
   Lbl_Fecha.Caption = "Actualizando Registros"
   MsgBox "Problemas en la Valorizacion a Mercado Libre de Trading", vbCritical
   Me.Tool.Enabled = True
Exit Sub
FinForzadoFM:
   Screen.MousePointer = vbDefault
   Pnl_Avance.Caption = ""
   Lbl_Fecha.Visible = False
   Lbl_Fecha.Caption = "Actualizando Registros"
   MsgBox "Problemas en la Valorizacion de Cuotas de Fondos Mutuos", vbCritical
   Me.Tool.Enabled = True
Exit Sub

End Sub

Private Sub Tool_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case nBtnTabular
         Call Tabula
      Case nBtnGrabar
         Call Graba
      Case nBtnValorizar
         Call Valoriza
      Case nBtnBuscar
         Call Busca
      Case nBtnLimpiar
         Call Limpia
      Case nBtnImpExcel
         Call Proc_Importar
      Case nBtnInfCeros
         If frm_series.Visible = False Then
            frm_series.Visible = True
            List_ceros.SetFocus
         Else
            frm_series.Visible = False
            If Table1.Enabled = True Then
               Table1.SetFocus
            End If
         End If
      Case nBtnCerrar
         Unload Me
    End Select
End Sub

Private Function Limpia()
   
   Call HabilitaControles(False)
   Call Leer_Fechas
   Call Nom
   
   Tool.Buttons(nBtnGrabar).Enabled = False
   Tool.Buttons(nBtnValorizar).Enabled = False
   Tool.Buttons(nBtnBuscar).Enabled = True
   Tool.Buttons(nBtnLimpiar).Enabled = True
   Tool.Buttons(nBtnCerrar).Enabled = True
   
   DateTextFechaVal.Enabled = True
End Function

Private Function Busca()
   Screen.MousePointer = vbHourglass

   Call HabilitaControles(False)
   Call Llenar_Grilla

   Tool.Buttons(3).Enabled = True
   Tool.Buttons(4).Enabled = True
   Tool.Buttons(5).Enabled = False
   Tool.Buttons(6).Enabled = True
   Tool.Buttons(7).Enabled = True

   DateTextFechaVal.Enabled = False

   Screen.MousePointer = vbDefault
End Function

Private Sub TxtGrilla_GotFocus()
   TxtGrilla.SelStart = Len(TxtGrilla.Text) - 5
End Sub

Private Sub TxtGrilla_KeyPress(KeyAscii As Integer)
   Select Case KeyAscii
      Case 13
         KeyAscii = 0
         Table1.Text = Format(TxtGrilla.Text, FDecimal)
         TxtGrilla.Visible = False
         Table1.SetFocus
      Case 27
         TxtGrilla.Visible = False
         Table1.SetFocus
   End Select
End Sub

Private Sub TxtGrilla_LostFocus()
   TxtGrilla.Visible = False
   Table1.SetFocus
End Sub


Private Sub Proc_Importar()
   On Error GoTo Importar_Excel
   
   Dim sNombre$
   Dim xlApp        As EXCEL.Application
   Dim xlBook       As EXCEL.Workbook
   Dim xlSheet      As EXCEL.Worksheet
   Dim iRow         As Integer
   Dim xRow         As Integer
   Dim Serie        As String
   Dim Fecha        As String
   Dim fechacomp    As String
   Dim Nominal      As Double
   Dim Numoper      As Double
   Dim Correla      As Double
   Dim emisor       As String
   Dim SWtext       As Integer
   Dim I            As Long
   Dim nTotalReg    As Double
   Dim nRegAct      As Double

   Screen.MousePointer = vbHourglass

   Envia = Array()
   AddParam Envia, Format(DateTextFechaVal.Text, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_FIN_DE_MES", Envia) Then
      MsgBox "Error Lectura SQL." & vbCrLf & vbCrLf & "Error en la lectura de datos desde Sql." & vbCrLf & VerSql, vbCritical, TITSISTEMA
      Exit Sub
   End If
   Do While Bac_SQL_Fetch(Datos)
      Sw_Fin_De_Mes = Datos(1)
   Loop

   sNombre$ = gsBac_DIREXEL & "tasamer" & Format(DateTextFechaVal.Text, "mmdd") & ".xls"
   
   If Not Dir(sNombre$) <> "" Then
      Screen.MousePointer = vbDefault
      MsgBox "Archivo Excel No existe, debe generarlo  ", vbExclamation
      Exit Sub
   End If
   
   Set xlApp = CreateObject("Excel.Application")
   Set xlBook = xlApp.Workbooks.Open(sNombre$)
   Set xlSheet = xlBook.Worksheets(1)
   
   Pnl_Avance.FloodType = 1
    
   With Table1
      Table1.Redraw = False
      nTotalReg = xlSheet.Columns.End(xlDown).Row - 1
      nRegAct = 0
      Pnl_Avance.FloodPercent = 0
      
      For xRow = 1 To xlSheet.Columns.End(xlDown).Row
         Serie = Func_Leer_Celda(xlSheet, "A" & LTrim(Str(1 + xRow)))
         Fecha = Func_Leer_Celda(xlSheet, "C" & LTrim(Str(1 + xRow)))
         For iRow = 1 To Table1.Rows - 1
            If Table1.TextMatrix(iRow, 0) = Serie And Table1.TextMatrix(iRow, 2) = Fecha Then
               Table1.TextMatrix(iRow, 3) = Format(Func_Leer_Celda(xlSheet, "D" & LTrim(Str(1 + xRow))), "#,##0.0000")
               Table1.TextMatrix(iRow, 4) = Format(Func_Leer_Celda(xlSheet, "E" & LTrim(Str(1 + xRow))), "#,##0.0000")
               Table1.TextMatrix(iRow, 5) = Format(Func_Leer_Celda(xlSheet, "F" & LTrim(Str(1 + xRow))), "#,##0.0000")
               Table1.TextMatrix(iRow, 6) = Format(Func_Leer_Celda(xlSheet, "G" & LTrim(Str(1 + xRow))), "#,##0.0000")
               nRegAct = nRegAct + 1
            End If
         Next iRow
         Pnl_Avance.FloodPercent = (nRegAct * 100) / nTotalReg
      Next xRow
      Table1.Redraw = True
   End With
   
   xlBook.Close
   xlApp.Visible = False
   xlApp.Quit

   Set xlApp = Nothing
   Set xlBook = Nothing
   Set xlSheet = Nothing

   Pnl_Avance.FloodPercent = 0
   Screen.MousePointer = vbDefault
   
   MsgBox "Proceso de carga de tasas desde planilla excel ha finalizado con exito", vbInformation, TITSISTEMA
   
   List_ceros.Clear    ' verifica si existen tasas en ceros
   With Table1
      For I = 1 To Table1.Rows - 1
         If CDbl(Table1.TextMatrix(I, 3)) = 0 Then
            If CDbl(Table1.TextMatrix(I, 3)) = 0 Then
               SWtext = 1
               List_ceros.AddItem "Serie con tasa en cero. " & "  " & Table1.TextMatrix(I, 0) & "  " & Table1.TextMatrix(I, 1)
               List_ceros.ItemData(List_ceros.NewIndex) = I
            End If
         End If
      Next I
   End With
    
   If SWtext = 1 Then
      Screen.MousePointer = vbDefault
      MsgBox "Existen Tasas en Cero. ", vbCritical, TITSISTEMA
      Exit Sub
   End If

Exit Sub
Importar_Excel:
   Screen.MousePointer = vbDefault
   MsgBox "Error N° : (" & err.Number & ")..." & vbCrLf & err.Description, vbExclamation, Me.Caption
End Sub

Private Function Func_Leer_Celda(objSheet As Object, sCelda As String) As Variant  'Double
   Dim nColumna      As Integer
   Dim nFila         As Integer
   
   nColumna = Asc(Mid$(UCase(sCelda), 1, 1)) - 64
   nFila = Val(Trim(Mid$(sCelda, 2, 5)))
   
   If nColumna = 1 Or nColumna = 3 Or nColumna = 13 Or nColumna = 2 Then
      Func_Leer_Celda = objSheet.Cells(nFila, nColumna)
   Else
      Func_Leer_Celda = CDbl(objSheet.Cells(nFila, nColumna))
   End If

End Function
