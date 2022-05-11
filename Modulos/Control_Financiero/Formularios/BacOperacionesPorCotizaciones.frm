VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacOperacionesPorCotizaciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Reemplazar Operaciones por Cotizaciones"
   ClientHeight    =   7890
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   11295
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7890
   ScaleWidth      =   11295
   Begin VB.Frame FrmNovaciones 
      Caption         =   "Novaciones"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   8280
      TabIndex        =   8
      Top             =   480
      Width           =   3015
      Begin VB.CheckBox ChNovacion 
         Caption         =   "Novación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   840
         TabIndex        =   9
         Top             =   360
         Width           =   1335
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   11295
      _ExtentX        =   19923
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   10755
      Top             =   285
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacOperacionesPorCotizaciones.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacOperacionesPorCotizaciones.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacOperacionesPorCotizaciones.frx":11F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacOperacionesPorCotizaciones.frx":20CE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacOperacionesPorCotizaciones.frx":2FA8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame2 
      Caption         =   "Cotizaciones"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   930
      Left            =   4125
      TabIndex        =   1
      Top             =   465
      Width           =   4050
      Begin VB.ComboBox Cmb_Cotizacion 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   315
         Left            =   240
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   480
         Width           =   2295
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "Numero Cotización"
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
         Left            =   240
         TabIndex        =   5
         Top             =   270
         Width           =   1575
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Operaciones"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   930
      Left            =   15
      TabIndex        =   0
      Top             =   480
      Width           =   4080
      Begin VB.ComboBox Cmb_Operacion 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   315
         Left            =   240
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   480
         Width           =   2295
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Numero Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   240
         TabIndex        =   3
         Top             =   270
         Width           =   1590
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   6480
      Left            =   75
      TabIndex        =   7
      Top             =   1410
      Width           =   11220
      _ExtentX        =   19791
      _ExtentY        =   11430
      _Version        =   393216
      BackColor       =   -2147483633
      BackColorFixed  =   -2147483646
      ForeColorFixed  =   -2147483639
      BackColorBkg    =   -2147483636
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483642
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
      AllowUserResizing=   1
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
End
Attribute VB_Name = "BacOperacionesPorCotizaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Enum Marcar
   [SI] = 1
   [NO] = 0
End Enum

Private Sub PintarCelda(MArca As Marcar, iFila As Integer)
   Dim iContador  As Integer
    
   Grid.Row = iFila
   
   For iContador = 1 To Grid.Cols - 1
      Grid.Col = iContador
      
      If MArca = SI Then
         Grid.CellForeColor = vbRed
      Else
         Grid.CellForeColor = vbBlack
      End If
   Next iContador
End Sub

Sub Nombres_Grilla()
   Dim nAltoFila  As Integer
   Let nAltoFila = 260
   
   Grid.Rows = 24:       Grid.Cols = 4
   Grid.Font.Name = "Thaoma": Grid.Font.Size = 8:  Grid.Font.Bold = False
   Grid.FocusRect = flexFocusNone
   
   'Grid.FixedRows = 2:  Grid.FixedCols = 0
   Grid.ColWidth(0) = 3000:   Grid.ColAlignment(0) = flexAlignLeftCenter
   Grid.ColWidth(1) = 3500:   Grid.ColAlignment(1) = flexAlignLeftCenter
   Grid.ColWidth(2) = 3500:   Grid.ColAlignment(2) = flexAlignLeftCenter
   Grid.ColWidth(3) = 750:    Grid.ColAlignment(3) = flexAlignCenterCenter
   
    Grid.TextMatrix(0, 0) = "I T E M S":                  Grid.TextMatrix(0, 1) = "DATOS OPERACION":   Grid.TextMatrix(0, 2) = "DATOS COTIZACION"
   
    Grid.TextMatrix(1, 0) = "RUT":                       Grid.RowHeight(1) = nAltoFila '-->RUT
    Grid.TextMatrix(2, 0) = "NOMBRE":                    Grid.RowHeight(2) = nAltoFila '-->NOMBRE CLIENTE
    Grid.TextMatrix(3, 0) = "MONEDAS":                   Grid.RowHeight(3) = nAltoFila
    Grid.TextMatrix(4, 0) = "NOCIONALES":                Grid.RowHeight(4) = nAltoFila
    Grid.TextMatrix(5, 0) = "FRECUENCIA PAGO":           Grid.RowHeight(5) = nAltoFila
    Grid.TextMatrix(6, 0) = "FRECUENCIA CAPITAL":        Grid.RowHeight(6) = nAltoFila
    Grid.TextMatrix(7, 0) = "INDICADOR":                 Grid.RowHeight(7) = nAltoFila
    Grid.TextMatrix(8, 0) = "TASA":                      Grid.RowHeight(8) = nAltoFila
    Grid.TextMatrix(9, 0) = "SPREAD":                    Grid.RowHeight(9) = nAltoFila
   
    Grid.TextMatrix(10, 0) = "FECHA EFECTIVA":            Grid.RowHeight(10) = nAltoFila
    Grid.TextMatrix(11, 0) = "FECHA MADUREZ":             Grid.RowHeight(11) = nAltoFila
    Grid.TextMatrix(12, 0) = "MONEDA DE PAGO":            Grid.RowHeight(12) = nAltoFila

    Grid.TextMatrix(13, 0) = "CARTERA NORMATIVA":         Grid.RowHeight(13) = nAltoFila
    Grid.TextMatrix(14, 0) = "CONTEO DE DIAS":            Grid.RowHeight(14) = nAltoFila
    Grid.TextMatrix(15, 0) = "MEDIO DE PAGO":             Grid.RowHeight(15) = nAltoFila
    Grid.TextMatrix(16, 0) = "MODALIDAD DE PAGO":        Grid.RowHeight(16) = nAltoFila
    Grid.TextMatrix(17, 0) = "CARTERA FINANCIERA":       Grid.RowHeight(17) = nAltoFila
    Grid.TextMatrix(18, 0) = "SUB CARTERA NORMATIVA":    Grid.RowHeight(18) = nAltoFila
    Grid.TextMatrix(19, 0) = "LIBRO NEGOCIACION":        Grid.RowHeight(19) = nAltoFila
    Grid.TextMatrix(20, 0) = "TIPO SWAP":                Grid.RowHeight(20) = nAltoFila
    Grid.TextMatrix(21, 0) = "OPERADOR":                 Grid.RowHeight(21) = nAltoFila
    Grid.TextMatrix(22, 0) = "VALOR RAZONABLE":          Grid.RowHeight(22) = nAltoFila
    Grid.TextMatrix(23, 0) = "NOVACION":                 Grid.RowHeight(23) = nAltoFila
End Sub

Private Function FuncPareo()
   Dim nContador  As Long
   
   For nContador = 1 To Grid.Rows - 1
      
      If Len(Grid.TextMatrix(nContador, 1)) > 0 And Len(Grid.TextMatrix(nContador, 2)) > 0 Then
         If Grid.TextMatrix(nContador, 1) = Grid.TextMatrix(nContador, 2) Then
            Grid.TextMatrix(nContador, 3) = "Ok"
            Call PintarCelda(NO, Val(nContador))
         Else
            Grid.TextMatrix(nContador, 3) = "Err"
            Call PintarCelda(SI, Val(nContador))
         End If
      End If
   Next nContador
   
End Function

Private Function FuncLimpiarLado(ByVal Opercion As Boolean)
   Dim nContador  As Long
   Dim nColumna   As Integer
   
   FrmNovaciones.Enabled = False
   ChNovacion.Enabled = False
      
   Let nColumna = IIf(Opercion = True, 1, 2)
   
   For nContador = 1 To Grid.Rows - 1
       Grid.TextMatrix(1, nColumna) = "":   Grid.TextMatrix(1, 3) = ""
       Grid.TextMatrix(2, nColumna) = "":   Grid.TextMatrix(2, 3) = ""
       Grid.TextMatrix(3, nColumna) = "":   Grid.TextMatrix(3, 3) = ""
       Grid.TextMatrix(4, nColumna) = "":   Grid.TextMatrix(4, 3) = ""
       Grid.TextMatrix(5, nColumna) = "":   Grid.TextMatrix(5, 3) = ""
       Grid.TextMatrix(6, nColumna) = "":   Grid.TextMatrix(6, 3) = ""
       Grid.TextMatrix(7, nColumna) = "":   Grid.TextMatrix(7, 3) = ""
       Grid.TextMatrix(8, nColumna) = "":   Grid.TextMatrix(8, 3) = ""
       Grid.TextMatrix(9, nColumna) = "":   Grid.TextMatrix(9, 3) = ""
      Grid.TextMatrix(10, nColumna) = "":  Grid.TextMatrix(10, 3) = ""
      Grid.TextMatrix(11, nColumna) = "":  Grid.TextMatrix(11, 3) = ""
      Grid.TextMatrix(12, nColumna) = "":  Grid.TextMatrix(12, 3) = ""
      Grid.TextMatrix(13, nColumna) = "":  Grid.TextMatrix(13, 3) = ""
      Grid.TextMatrix(14, nColumna) = "":  Grid.TextMatrix(14, 3) = ""
      Grid.TextMatrix(15, nColumna) = "":  Grid.TextMatrix(15, 3) = ""
      Grid.TextMatrix(16, nColumna) = "":  Grid.TextMatrix(16, 3) = ""
      Grid.TextMatrix(17, nColumna) = "":  Grid.TextMatrix(17, 3) = ""
      Grid.TextMatrix(18, nColumna) = "":  Grid.TextMatrix(18, 3) = ""
      Grid.TextMatrix(19, nColumna) = "":  Grid.TextMatrix(19, 3) = ""
      Grid.TextMatrix(20, nColumna) = "":  Grid.TextMatrix(20, 3) = ""
      Grid.TextMatrix(21, nColumna) = "":  Grid.TextMatrix(21, 3) = ""
      Grid.TextMatrix(22, nColumna) = "":  Grid.TextMatrix(22, 3) = ""
      Grid.TextMatrix(23, nColumna) = "":  Grid.TextMatrix(23, 3) = ""
   Next nContador
   
End Function


Private Sub ChNovacion_Click()
       If Me.ChNovacion.Value = 1 Then
               Grid.TextMatrix(23, 1) = "ES NOVACION"
               Grid.TextMatrix(23, 2) = "ES NOVACION"
               Grid.TextMatrix(23, 3) = "ok"
       Else
               Grid.TextMatrix(23, 1) = "NO ES NOVACION"
               Grid.TextMatrix(23, 2) = "NO ES NOVACION"
               Grid.TextMatrix(23, 3) = "Err"
       End If
        
End Sub

Private Sub Cmb_Operacion_Click()
   
   If Cmb_Operacion.ListIndex < 0 Then
      Exit Sub
   End If
   If Cmb_Operacion.Text = "" Then
      Exit Sub
   End If

   Call FuncLeeOperacion(Cmb_Operacion.List(Cmb_Operacion.ListIndex))
   Call FuncValidaNovacion
   
End Sub

Private Sub Cmb_Cotizacion_Click()
   If Cmb_Cotizacion.ListIndex < 0 Then
      Exit Sub
   End If
   If Cmb_Cotizacion.Text = "" Then
      Exit Sub
   End If
   
   Call FuncLeeCotizacion(Cmb_Cotizacion.List(Cmb_Cotizacion.ListIndex))
End Sub

Private Function FuncLeeOperacion(ByVal nOperacion As Long)
   Dim SqlDatos()
   
   Call FuncLimpiarLado(True)

   Envia = Array()
   AddParam Envia, nOperacion
   AddParam Envia, "O"
   If Not Bac_Sql_Execute("SP_BUSCA_OPER_COT", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(SqlDatos()) Then
         Grid.TextMatrix(1, 1) = SqlDatos(3)    '--> Rut Cliente
         Grid.TextMatrix(2, 1) = SqlDatos(4)    '--> Nombre Cliente
         Grid.TextMatrix(3, 1) = SqlDatos(8)    '--> Moneda
         Grid.TextMatrix(4, 1) = SqlDatos(9)    '--> Nocionales
         Grid.TextMatrix(5, 1) = SqlDatos(10)   '--> Frecuencia de Pago
         Grid.TextMatrix(6, 1) = SqlDatos(11)   '--> Frecuencia de Capital
         Grid.TextMatrix(7, 1) = SqlDatos(12)   '--> Indicador
         Grid.TextMatrix(8, 1) = SqlDatos(13)   '--> Tasa
         Grid.TextMatrix(9, 1) = SqlDatos(14)   '--> Spread         --Conteo de Dias
      
         Grid.TextMatrix(10, 1) = SqlDatos(6)   '--> Fecha Efectiva
         Grid.TextMatrix(11, 1) = SqlDatos(7)   '--> Fecha Madurez
         Grid.TextMatrix(12, 1) = SqlDatos(16)  '--> Moneda de Pago
      
         Grid.TextMatrix(13, 1) = SqlDatos(19)  '--> Cartera Normativa
         Grid.TextMatrix(14, 1) = SqlDatos(15)  '--> Conteo de Dias --Fecha Efectiva
         Grid.TextMatrix(15, 1) = SqlDatos(17)  '--> Medio de Pago
         Grid.TextMatrix(16, 1) = SqlDatos(23)  '--> Modalidad de Pago
         Grid.TextMatrix(17, 1) = SqlDatos(18)  '--> Cartera Financiera
         Grid.TextMatrix(18, 1) = SqlDatos(20)  '--> Sub Cartera Normativa
         Grid.TextMatrix(19, 1) = SqlDatos(21)  '--> Libro de Negociacion
         Grid.TextMatrix(20, 1) = SqlDatos(24)  '--> Tipo Swap
         Grid.TextMatrix(21, 1) = SqlDatos(25)  '--> Operador
         Grid.TextMatrix(22, 1) = SqlDatos(26)  '--> MTM Valor Razonable
         Grid.TextMatrix(23, 1) = "NO ES NOVACION"
   End If

   Grid.Redraw = False

   Call FuncPareo
   
   Grid.Redraw = True
   
End Function

Private Function FuncLeeCotizacion(ByVal nOperacion As Long)
   Dim SqlDatos()
   FrmNovaciones.Enabled = False
   ChNovacion.Enabled = False
   ChNovacion.Value = False
   
   Call FuncLimpiarLado(False)

   Envia = Array()
   AddParam Envia, nOperacion
   AddParam Envia, "C"
   If Not Bac_Sql_Execute("SP_BUSCA_OPER_COT", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(SqlDatos()) Then
      Grid.TextMatrix(1, 2) = SqlDatos(3)        '--> Rut Cliente
      Grid.TextMatrix(2, 2) = SqlDatos(4)        '--> Nombre Cliente
      Grid.TextMatrix(3, 2) = SqlDatos(8)        '--> Moneda
      Grid.TextMatrix(4, 2) = SqlDatos(9)        '--> Nocionales
      Grid.TextMatrix(5, 2) = SqlDatos(10)       '--> Frecuencia de Pago
      Grid.TextMatrix(6, 2) = SqlDatos(11)       '--> Frecuencia de Capital
      Grid.TextMatrix(7, 2) = SqlDatos(12)       '--> Indicador
      Grid.TextMatrix(8, 2) = SqlDatos(13)       '--> Tasa
      Grid.TextMatrix(9, 2) = SqlDatos(14)       '--> Spred --Conteo de Dias
      'Grid.TextMatrix(11, 2) = "--" '--> Primer Pago
      'Grid.TextMatrix(12, 2) = "--" '--> Penultimo Pago
      Grid.TextMatrix(10, 2) = SqlDatos(6)       '--> Fecha Efectiva
      Grid.TextMatrix(11, 2) = SqlDatos(7)       '--> Fecha Madurez
      Grid.TextMatrix(12, 2) = SqlDatos(16)      '--> Moneda de Pago
      
      Grid.TextMatrix(13, 2) = SqlDatos(19)      '--> Cartera Normativa
       Grid.TextMatrix(14, 2) = SqlDatos(15)     '--> Conteo de Dias --Fecha Efectiva
       Grid.TextMatrix(15, 2) = SqlDatos(17)     '--> Medio de Pago
       Grid.TextMatrix(16, 2) = SqlDatos(23)     '-->Modalidad de Pago
       Grid.TextMatrix(17, 2) = SqlDatos(18)     '-->Cartera Financiera
       Grid.TextMatrix(18, 2) = SqlDatos(20)     '-->Sub Cartera Normativa
       Grid.TextMatrix(19, 2) = SqlDatos(21)     '--> Libro de Negociacion
       Grid.TextMatrix(20, 2) = SqlDatos(24)     '--> Tipo Swap
       Grid.TextMatrix(21, 2) = SqlDatos(25)     '--> Operador
       Grid.TextMatrix(22, 2) = SqlDatos(26)     '--> MTM Valor Razonable
       Grid.TextMatrix(23, 2) = "NO ES NOVACION"
   End If
   
   Grid.Redraw = False
   
   Call FuncPareo
   
   Grid.Redraw = True
   
   Call FuncValidaNovacion
   
End Function



Private Function CargaComboOperacion()
   Dim Datos()
   
   Screen.MousePointer = vbHourglass
   
   If Not Bac_Sql_Execute(gsSQL_DatabasePCS & "..SP_CARGA_NUM_OPERACIONES") Then
      Screen.MousePointer = vbDefault
      MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
      Exit Function
   End If
   Call Cmb_Operacion.Clear
   Do While Bac_SQL_Fetch(Datos())
      Cmb_Operacion.AddItem (Datos(1))
   Loop

   Screen.MousePointer = vbDefault
End Function

Private Function CargaComboCotizacion()
   Dim Datos()
   
   Screen.MousePointer = vbHourglass

   If Not Bac_Sql_Execute(gsSQL_DatabasePCS & "..SP_CARGA_NUM_COTIZACIONES") Then
      Screen.MousePointer = vbDefault
      MsgBox "Error al leer el archivo", vbCritical, TITSISTEMA
      Exit Function
   End If
   Call Cmb_Cotizacion.Clear
   Do While Bac_SQL_Fetch(Datos())
      Cmb_Cotizacion.AddItem (Datos(1))
   Loop
   Screen.MousePointer = vbDefault
End Function

Private Sub Form_Load()
   Me.top = 0: Me.Left = 0
   Me.Icon = BacControlFinanciero.Icon
   FrmNovaciones.Enabled = False
   ChNovacion.Enabled = False
   ChNovacion.Value = False
   
   Call CargaComboOperacion
   Call CargaComboCotizacion
   Call Nombres_Grilla
   

End Sub


Private Function FuncGrabarRegistro(ByVal nFolioContrato As Long, ByVal nFolioCotizacion As Long)
   Dim SqlDatos()
   Dim nFolioModificacion  As Long
   Dim nContador           As Long
   
   Let nFolioModificacion = 0
   
   For iContador = 1 To Grid.Rows - 1
      
      Envia = Array()
      AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
      AddParam Envia, "PCS"
      AddParam Envia, nFolioContrato
      AddParam Envia, nFolioCotizacion
      AddParam Envia, nFolioModificacion
      AddParam Envia, Grid.TextMatrix(iContador, 0)
      AddParam Envia, Grid.TextMatrix(iContador, 1)
      AddParam Envia, Grid.TextMatrix(iContador, 2)
      AddParam Envia, CDbl(iContador)
      If iContador = 23 Then
        If Me.ChNovacion.Value = 1 Then
            Envia = Array()
            AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
            AddParam Envia, "PCS"
            AddParam Envia, nFolioContrato
            AddParam Envia, nFolioCotizacion
            AddParam Envia, nFolioModificacion
            AddParam Envia, Grid.TextMatrix(iContador, 0)
            AddParam Envia, Grid.TextMatrix(iContador, 1)
            AddParam Envia, Grid.TextMatrix(iContador, 2)
            AddParam Envia, CDbl(iContador)
        Else
            Envia = Array()
            AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
            AddParam Envia, "PCS"
            AddParam Envia, nFolioContrato
            AddParam Envia, nFolioCotizacion
            AddParam Envia, nFolioModificacion
            AddParam Envia, Grid.TextMatrix(iContador, 0) 'Verrifica que diga que no es novación
            AddParam Envia, Grid.TextMatrix(iContador, 1)
            AddParam Envia, Grid.TextMatrix(iContador, 2)
            AddParam Envia, CDbl(iContador)
        
        End If
      End If
      If Not Bac_Sql_Execute("SP_GRABA_REGISTRO_MODIFICAIONES", Envia) Then
         Exit Function
      End If
      If Bac_SQL_Fetch(SqlDatos()) Then
         Let nFolioModificacion = SqlDatos(3)
      End If
   
   Next iContador
   
End Function


Private Function FuncSavedata() As Boolean
   Dim Datos()
   Dim nOperacion       As Long
   Dim nCotizacion      As Long
   Dim sCadenaN         As String
   Dim sCadenaA         As String
   Dim cSeprador        As String
   Dim cSepLista        As String
   Dim nLargoStandard   As Long

   Let nLargoStandard = 18

   If Me.Grid.TextMatrix(1, 1) = "" Or Me.Grid.TextMatrix(1, 2) = "" Then
      Call MsgBox("Faltan datos por ingresar. Favor revizar", vbExclamation, TITSISTEMA)
      Exit Function
   End If

    Let nOperacion = CDbl(Cmb_Operacion.List(Cmb_Operacion.ListIndex))
   Let nCotizacion = CDbl(Cmb_Cotizacion.List(Cmb_Cotizacion.ListIndex))
   
   If MsgBox("¿ Esta Ud. seguro que desea reemplazar la Operación N°: " & nOperacion & " por Cotización N°: " & nCotizacion, vbQuestion + vbYesNo + vbDefaultButton2, App.Title) = vbNo Then
      Exit Function
   End If
   
   Envia = Array()
   AddParam Envia, nOperacion
   AddParam Envia, nCotizacion
   AddParam Envia, 0
   If Not Bac_Sql_Execute(gsSQL_DatabasePCS & "..SP_REMPLAZA_OPERACION_CON_COTIZACION", Envia) Then
      Call MsgBox("Error al leer el archivo", vbCritical, App.Title)
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) = -1 Then
         Call MsgBox(Datos(2), vbExclamation + vbOKOnly, App.Title)
      Else
         GoTo GrabaLog
      End If
   End If

Exit Function
GrabaLog:
   
   Call FuncGrabarRegistro(nOperacion, nCotizacion)
   
   Call MsgBox("Se ha efectuado el reemplazo, favor revisar.", vbInformation, App.Title)
   Call FuncLimpiarLado(True)
   Call FuncLimpiarLado(False)
   Call CargaComboOperacion
   Call CargaComboCotizacion
   
Exit Function
   
   
   Let cSeprador = " : "
   Let cSepLista = "   "

   Let sCadenaA = ""
   Let sCadenaN = ""

   For iContador = 1 To Grid.Rows - 1
      If Grid.TextMatrix(iContador, 3) = "Err" Then
         If iContador = 1 Then
            Let sCadenaA = sCadenaA & Grid.TextMatrix(iContador, 0) & String(nLargoStandard - Len(Trim(Grid.TextMatrix(iContador, 0))), " ") & cSeprador & Grid.TextMatrix(iContador, 1)
            Let sCadenaN = sCadenaN & Grid.TextMatrix(iContador, 0) & String(nLargoStandard - Len(Trim(Grid.TextMatrix(iContador, 0))), " ") & cSeprador & Grid.TextMatrix(iContador, 2)
         End If
         If iContador > 1 And iContador < Grid.Rows - 1 Then
            Let sCadenaA = sCadenaA & cSepLista & Chr(13) & Grid.TextMatrix(iContador, 0) & String(nLargoStandard - Len(Trim(Grid.TextMatrix(iContador, 0))), " ") & cSeprador & Grid.TextMatrix(iContador, 1)
            Let sCadenaN = sCadenaN & cSepLista & Chr(13) & Grid.TextMatrix(iContador, 0) & String(nLargoStandard - Len(Trim(Grid.TextMatrix(iContador, 0))), " ") & cSeprador & Grid.TextMatrix(iContador, 2)
         End If
      End If
   Next iContador

   Call GRABA_LOG_AUDITORIA("1", Str(gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10021", "01", "OPERACION N° " & nOperacion & " REEMPLAZADA POR COTIZACION N° " & nCotizacion, "REEMPLAZO", sCadenaA, sCadenaN)

   Call MsgBox("Se ha efectuado el reemplazo, favor revisar.", vbInformation, App.Title)
   Call FuncLimpiarLado(True)
   Call FuncLimpiarLado(False)
   Call CargaComboOperacion
   Call CargaComboCotizacion
End Function


Private Sub Label11_Click()
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call FuncSavedata
      Case 2
         Let swModulo = 1
         Let BacInformeModificaciones.bDesdeReemplazo = True
         Call BacInformeModificaciones.Show(vbModal)
      Case 3
         Call Unload(Me)
   End Select
End Sub


Private Function FuncValidaNovacion()
   Dim nContador  As Long
   Dim nColumna   As Integer
   Dim validador As String
   
   Let nColumna = IIf(Opercion = True, 1, 2)
   
   For nContador = 3 To Grid.Rows - 2
      If Grid.TextMatrix(nContador, 3) = "Ok" And Grid.TextMatrix(1, 3) = "Err" Then
        Grid.TextMatrix(23, 1) = "NO ES NOVACION"
        Grid.TextMatrix(23, 2) = "NO ES NOVACION"
        Grid.TextMatrix(23, 3) = "Err"
        Grid.Row = 23
        Grid.Col = 1
        Grid.CellForeColor = vbBlack
        Grid.Col = 2
        Grid.CellForeColor = vbBlack
        Grid.Col = 3
        Grid.CellForeColor = vbBlack
        FrmNovaciones.Enabled = True
        ChNovacion.Enabled = True
        ChNovacion.Value = 0
      Else
        Grid.TextMatrix(23, 1) = "NO ES NOVACION"
        Grid.TextMatrix(23, 2) = "NO ES NOVACION"
        Grid.TextMatrix(23, 3) = "Err"
        Grid.Row = 23
        Grid.Col = 1
        Grid.CellForeColor = vbRed
        Grid.Col = 2
        Grid.CellForeColor = vbRed
        Grid.Col = 3
        Grid.CellForeColor = vbRed
        
        Exit For
      End If
    
      
   Next nContador
   
''   If Grid.TextMatrix(23, 1) = "ES NOVACION" And Grid.TextMatrix(23, 2) = "ES NOVACION" Then
''        FrmNovaciones.Enabled = True
''        ChNovacion.Enabled = True
''    Else
''        FrmNovaciones.Enabled = False
''        ChNovacion.Enabled = False
''   End If
End Function




