VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_PAPELTAS_HISTORICAS 
   Caption         =   "Impresión de Papeletas Historicas"
   ClientHeight    =   6495
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11115
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   6495
   ScaleWidth      =   11115
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11115
      _ExtentX        =   19606
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
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
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   2805
         Top             =   90
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
               Picture         =   "FRM_PAPELTAS_HISTORICAS.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PAPELTAS_HISTORICAS.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PAPELTAS_HISTORICAS.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PAPELTAS_HISTORICAS.frx":2C8E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   615
      Left            =   0
      TabIndex        =   1
      Top             =   450
      Width           =   11115
      Begin VB.Timer Timer1 
         Interval        =   5000
         Left            =   9630
         Top             =   150
      End
      Begin BACControles.TXTFecha FechaProceso 
         Height          =   330
         Left            =   1815
         TabIndex        =   3
         Top             =   165
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   582
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "17/01/2007"
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Fecha de Proceso"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   150
         TabIndex        =   2
         Top             =   210
         Width           =   1575
      End
   End
   Begin VB.Frame Frame2 
      Height          =   5505
      Left            =   0
      TabIndex        =   4
      Top             =   990
      Width           =   11115
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   5325
         Left            =   45
         TabIndex        =   5
         Top             =   135
         Width           =   11040
         _ExtentX        =   19473
         _ExtentY        =   9393
         _Version        =   393216
         Cols            =   8
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483643
         BackColorBkg    =   -2147483636
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_PAPELTAS_HISTORICAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub NombresGrilla()
   Grid.Rows = 2: Grid.cols = 10
   
   Grid.TextMatrix(0, 0) = "Marca":           Grid.ColWidth(0) = 0
   Grid.TextMatrix(0, 1) = "N° Operación":    Grid.ColWidth(1) = 1500
   Grid.TextMatrix(0, 2) = "Tip. Operación":  Grid.ColWidth(2) = 1500
   Grid.TextMatrix(0, 3) = "Rut Cartera":     Grid.ColWidth(3) = 0
   Grid.TextMatrix(0, 4) = "Nom. Cliente":    Grid.ColWidth(4) = 3200
   Grid.TextMatrix(0, 5) = "Monto Operación": Grid.ColWidth(5) = 2000
   Grid.TextMatrix(0, 6) = "Hora":            Grid.ColWidth(6) = 1500
   Grid.TextMatrix(0, 7) = "Usuario":         Grid.ColWidth(7) = 2200
   Grid.TextMatrix(0, 8) = "Estado":          Grid.ColWidth(8) = 1200
   Grid.TextMatrix(0, 9) = "Rut Cliente":     Grid.ColWidth(9) = 0
   
End Sub

Private Sub FechaProceso_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call LeerOperaciones(FechaProceso.text)
   End If
End Sub

Private Sub Form_Load()
   Me.Icon = BacTrader.Icon
   Me.Top = 0: Me.Left = 0
   Me.FechaProceso.text = Format(gsBac_Fecp, "dd/mm/yyyy")
   
   Call NombresGrilla
   Call LeerOperaciones(FechaProceso.text)
End Sub

Private Sub Form_Resize()
   On Error Resume Next
      Frame1.Width = Me.Width - 150
      Frame2.Width = Frame1.Width
      Grid.Width = Frame2.Width - 150
      
      Frame2.Height = Me.Height - 1500
      Grid.Height = Frame2.Height - 350
      
   On Error GoTo 0
End Sub


Private Sub LeerOperaciones(dFecha As Date)
   Dim DATOS()
   
   Envia = Array()
   AddParam Envia, Format(dFecha, "yyyymmdd")
   If Not Bac_Sql_Execute("CONSULTA_OPERACIONES_", Envia) Then
      Clipboard.Clear
      Clipboard.SetText VerSql
      MsgBox "Error en la Consulta de Operaciones.", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   Grid.Rows = 1
   Grid.Redraw = False
   Do While Bac_SQL_Fetch(DATOS())
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, 0) = ""
      Grid.TextMatrix(Grid.Rows - 1, 1) = DATOS(1)
      Grid.TextMatrix(Grid.Rows - 1, 2) = DATOS(2)
      Grid.TextMatrix(Grid.Rows - 1, 3) = DATOS(3)
      Grid.TextMatrix(Grid.Rows - 1, 4) = DATOS(4)
      Grid.TextMatrix(Grid.Rows - 1, 5) = Format(DATOS(5), FEntero)
      Grid.TextMatrix(Grid.Rows - 1, 6) = DATOS(6)
      Grid.TextMatrix(Grid.Rows - 1, 7) = IIf(IsNull(DATOS(7)), "", Mid(DATOS(7), 1, 20))
      Grid.TextMatrix(Grid.Rows - 1, 8) = DATOS(8)
      Grid.TextMatrix(Grid.Rows - 1, 9) = DATOS(9)
       
      If DATOS(8) = "A" Then
         Grid.TextMatrix(Grid.Rows - 1, 8) = DATOS(8) & " - ANULADA"
         Call PintarCelda(3, Grid.Rows - 1)
      End If
      If DATOS(8) = "P" Then
         Grid.TextMatrix(Grid.Rows - 1, 8) = DATOS(8) & " - PENDIENTE"
         Call PintarCelda(4, Grid.Rows - 1)
      End If
   Loop
   Grid.Redraw = True
End Sub


Private Sub PintarCelda(MArca As Integer, iFila As Integer)
   Dim iContador  As Integer
   Dim iCol       As Integer
   
   iCol = Grid.ColSel
   Grid.Row = iFila
   
   For iContador = 0 To Grid.cols - 1
      Grid.Col = iContador
      If MArca = 1 Then 'Defecto
         Grid.TextMatrix(iFila, 0) = ""
         Grid.CellBackColor = &H8000000F   'Gris
         Grid.CellForeColor = &H80000008   'Negro
      End If
      If MArca = 2 Then 'Marcada
         Grid.TextMatrix(iFila, 0) = "M"
         Grid.CellBackColor = &HFF8080     'Azulino
         Grid.CellForeColor = &H80000005  '&H80000008   'Negro
      End If
      If MArca = 3 Then 'Anulada
         Grid.CellBackColor = &H80000008   'Rojo
         Grid.CellForeColor = &HFF&        'Negro
      End If
      If MArca = 4 Then 'Pendiente
         Grid.CellBackColor = &HFFFF00     'Celeste
         Grid.CellForeColor = &H80000008   'Negro
      End If
   Next iContador
   
   Grid.Col = iCol
   
End Sub

Private Sub Grid_DblClick()
   If Grid.TextMatrix(Grid.RowSel, 1) = "" Then
      Exit Sub
   End If
   
   If Grid.TextMatrix(Grid.RowSel, 0) = "M" Then
      Call PintarCelda(1, Grid.RowSel)
      If Mid(Grid.TextMatrix(Grid.RowSel, 8), 1, 1) = "P" Then
         Call PintarCelda(4, Grid.RowSel)
      End If
      If Mid(Grid.TextMatrix(Grid.RowSel, 8), 1, 1) = "A" Then
         Call PintarCelda(3, Grid.RowSel)
      End If
   Else
      Call PintarCelda(2, Grid.RowSel)
   End If
   
   Grid.SetFocus
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeySpace Then
      If Grid.TextMatrix(Grid.RowSel, 1) = "" Then
         Exit Sub
      End If

      If Grid.TextMatrix(Grid.RowSel, 0) = "M" Then
         Call PintarCelda(1, Grid.RowSel)
         If Mid(Grid.TextMatrix(Grid.RowSel, 8), 1, 1) = "P" Then
            Call PintarCelda(4, Grid.RowSel)
         End If
         If Mid(Grid.TextMatrix(Grid.RowSel, 8), 1, 1) = "A" Then
            Call PintarCelda(3, Grid.RowSel)
         End If
      Else
         Call PintarCelda(2, Grid.RowSel)
      End If
      Grid.SetFocus
   End If
End Sub

Private Sub Timer1_Timer()
  ' Call LeerOperaciones(FechaProceso.Text)
  ' Grid.TopRow = Grid.Rows - 1
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call LeerOperaciones(FechaProceso.text)
      Case 2
         Call PreparaImpreSion(crptToPrinter)
      Case 3
         Call PreparaImpreSion(crptToWindow)
      Case 4
         Unload Me
   End Select
End Sub

Private Sub PreparaImpreSion(iDestino As DestinationConstants)
   Dim iContador     As Long
   Dim iRutCliente   As Long
   Dim iRutCartera   As Long
   Dim iNumOperacion As Long
   Dim cTipOperacion As String
   
   For iContador = 1 To Grid.Rows - 1
      
      If Grid.TextMatrix(iContador, 0) = "M" Then
         iRutCartera = Grid.TextMatrix(iContador, 3)
         iNumOperacion = Grid.TextMatrix(iContador, 1)
         cTipOperacion = Grid.TextMatrix(iContador, 2)
         cTipOperacion = IIf(cTipOperacion = "ICAP", "IB", IIf(cTipOperacion = "ICOL", "IB", cTipOperacion))
         iRutCliente = Grid.TextMatrix(iContador, 9)
         Call GeneracionInformes(iDestino, cTipOperacion, iNumOperacion, iRutCliente)
        'Call ImprimePapeleta(iRutCartera, iNumOperacion, cTipOperacion, "N", iRutCliente, "1")
      End If
      
   Next iContador
   
End Sub


Private Sub GeneracionInformes(iDestino As DestinationConstants, iTipoOperacion As String, iNumOperacion As Long, iRutCliente As Long)
   On Error GoTo ErrorImpresion
   Dim cProcedimiento   As String
   
   Call Limpiar_Cristal

  'Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
   BacTrader.bacrpt.Destination = iDestino
   BacTrader.bacrpt.WindowState = crptMaximized

   Select Case iTipoOperacion
      Case "IB", "ICAP", "ICOL"
         Let cProcedimiento = "SP_PAPALETA_INTERBANCARIO"
         
         BacTrader.bacrpt.ReportFileName = RptList_Path & "Papeleta_IB.RPT"
            '--> Procedimiento Almacenado: SP_PAPALETA_INTERBANCARIO
         Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
         BacTrader.bacrpt.StoredProcParam(0) = Format(FechaProceso.text, "YYYY-MM-DD 00:00:00.000")
         BacTrader.bacrpt.StoredProcParam(1) = CDbl(iNumOperacion)
         BacTrader.bacrpt.StoredProcParam(2) = "P"
         BacTrader.bacrpt.StoredProcParam(3) = " "
         BacTrader.bacrpt.StoredProcParam(4) = " "
         BacTrader.bacrpt.StoredProcParam(5) = " "
         BacTrader.bacrpt.StoredProcParam(6) = " "
         BacTrader.bacrpt.StoredProcParam(7) = " "
         BacTrader.bacrpt.Connect = CONECCION
         BacTrader.bacrpt.Action = 1
      Case "CI"
         Let cProcedimiento = "SP_PAPELETA_COMPRAS_PACTO"
         
         BacTrader.bacrpt.ReportFileName = RptList_Path & "Papeleta_CI.rpt"
            '--> Procedimiento Almacenado: SP_PAPELETA_COMPRAS_PACTO
         Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
         BacTrader.bacrpt.StoredProcParam(0) = Format(FechaProceso.text, "YYYY-MM-DD 00:00:00.000")
         BacTrader.bacrpt.StoredProcParam(1) = CDbl(iNumOperacion)
         BacTrader.bacrpt.StoredProcParam(2) = "P"
         BacTrader.bacrpt.Connect = CONECCION
         BacTrader.bacrpt.Action = 1
      Case "CP"
         Let cProcedimiento = "SP_PAPELETA_COMPRAS_PROPIA"
         
         BacTrader.bacrpt.ReportFileName = RptList_Path & "Papeleta_CP.rpt"
            '--> Procedimiento Almacenado: SP_PAPELETA_COMPRAS_PROPIA
         Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
         BacTrader.bacrpt.StoredProcParam(0) = Format(FechaProceso.text, "YYYY-MM-DD 00:00:00.000")
         BacTrader.bacrpt.StoredProcParam(1) = CDbl(iNumOperacion)
         BacTrader.bacrpt.StoredProcParam(2) = "P"
         BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
         BacTrader.bacrpt.Connect = CONECCION
         BacTrader.bacrpt.Action = 1
      Case "VP"
         Let cProcedimiento = "SP_PAPELETA_VENTA_PROPIA"
      
         BacTrader.bacrpt.ReportFileName = RptList_Path & "Papeleta_VP.rpt"
            '--> Procedimiento Almacenado: SP_PAPELETA_VENTA_PROPIA
         Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
         BacTrader.bacrpt.StoredProcParam(0) = Format(FechaProceso.text, "YYYY-MM-DD 00:00:00.000")
         BacTrader.bacrpt.StoredProcParam(1) = CDbl(iNumOperacion)
         BacTrader.bacrpt.StoredProcParam(2) = "P"
         BacTrader.bacrpt.StoredProcParam(3) = "VP"
         BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
         BacTrader.bacrpt.Connect = CONECCION
         BacTrader.bacrpt.Action = 1
      Case "ST"
         Let cProcedimiento = "SP_PAPELETA_SORTEO_LCHR"
         
         BacTrader.bacrpt.ReportFileName = RptList_Path & "Papeleta_ST.RPT"
            '--> Procedimiento Almacenado: SP_PAPELETA_SORTEO_LCHR
         Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
         BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
         BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
         BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
         BacTrader.bacrpt.StoredProcParam(3) = "VP"
         BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
         BacTrader.bacrpt.Connect = CONECCION
         BacTrader.bacrpt.Destination = crptToWindow
         BacTrader.bacrpt.Action = 1
      Case "VI"
         If iRutCliente = "97029000" And sTipOper = "IB" Then   ' banco central
            Let cProcedimiento = "SP_CERTIFICADO_CUSTODIA"

            BacTrader.bacrpt.ReportFileName = RptList_Path & "CertificadoCustodia.rpt"
            Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
               '--> Procedimiento Almacenado: SP_CERTIFICADO_CUSTODIA
            BacTrader.bacrpt.StoredProcParam(0) = Format(FechaProceso.text, "YYYY-MM-DD 00:00:00.000")
            BacTrader.bacrpt.StoredProcParam(1) = CDbl(iNumOperacion)
            BacTrader.bacrpt.StoredProcParam(2) = "P"
            BacTrader.bacrpt.StoredProcParam(3) = CDbl(iRutCliente)
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
         Else
            Let cProcedimiento = "SP_PAPELETA_VENTA_CON_PACTO"
            
            BacTrader.bacrpt.ReportFileName = RptList_Path & "Papeleta_VI.rpt"
            Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
               '--> Procedimiento Almacenado: SP_PAPELETA_VENTA_CON_PACTO
            BacTrader.bacrpt.StoredProcParam(0) = Format(FechaProceso.text, "YYYY-MM-DD 00:00:00.000")
            BacTrader.bacrpt.StoredProcParam(1) = CDbl(iNumOperacion)
            BacTrader.bacrpt.StoredProcParam(2) = "P"
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
            
            '--> PROD 6006 Se agrega reporte de agrupacion x Cartera Normativa y Serie
            BacTrader.bacrpt.ReportFileName = RptList_Path & "Papeleta_VI_TotxSer.rpt"
            Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
               '--> Procedimiento Almacenado: SP_PAPELETA_VENTA_CON_PACTO
            BacTrader.bacrpt.StoredProcParam(0) = Format(FechaProceso.text, "YYYY-MM-DD 00:00:00.000")
            BacTrader.bacrpt.StoredProcParam(1) = CDbl(iNumOperacion)
            BacTrader.bacrpt.StoredProcParam(2) = "P"
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
            
         End If
      Case "RCA"
         Let cProcedimiento = "SP_PAPELETA_RECOMPRA_ANT"
      
         BacTrader.bacrpt.ReportFileName = RptList_Path & "Papeleta_RCA.rpt"
         Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
            '--> Procedimiento Almacenado: SP_PAPELETA_RECOMPRA_ANT
         BacTrader.bacrpt.StoredProcParam(0) = Format(FechaProceso.text, "YYYY-MM-DD 00:00:00.000")
         BacTrader.bacrpt.StoredProcParam(1) = CDbl(iNumOperacion)
         BacTrader.bacrpt.StoredProcParam(2) = "P"
         BacTrader.bacrpt.Connect = CONECCION
         BacTrader.bacrpt.Action = 1
      Case "RVA"
         Let cProcedimiento = "SP_PAPELETA_REVENTA_ANT"
         
         BacTrader.bacrpt.ReportFileName = RptList_Path & "Papeleta_RVA.rpt"
         Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
            '--> Procedimiento Almacenado: SP_PAPELETA_REVENTA_ANT
         BacTrader.bacrpt.StoredProcParam(0) = Format(FechaProceso.text, "YYYY-MM-DD 00:00:00.000")
         BacTrader.bacrpt.StoredProcParam(1) = CDbl(iNumOperacion)
         BacTrader.bacrpt.StoredProcParam(2) = "P"
         BacTrader.bacrpt.Connect = CONECCION
         BacTrader.bacrpt.Action = 1
      Case "FLI"
         Let cProcedimiento = "SP_PAPELETA_FLI"
      
         BacTrader.bacrpt.ReportFileName = RptList_Path & "Papeleta_FLI.rpt"
            '--> Procedimiento Almacenado: SP_PAPELETA_FLI
         If BacTrader.bacrpt.ReportFileName <> "" Then
            Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
         End If
         BacTrader.bacrpt.StoredProcParam(0) = Format(FechaProceso.text, "YYYY-MM-DD 00:00:00.000")
         BacTrader.bacrpt.StoredProcParam(1) = CDbl(iNumOperacion)
         BacTrader.bacrpt.StoredProcParam(2) = "P"
         BacTrader.bacrpt.Connect = CONECCION
         BacTrader.bacrpt.Action = 1
      Case "FLIP"
         Let cProcedimiento = "SP_PAPELETA_FLI_PAGOS"
      
         BacTrader.bacrpt.ReportFileName = RptList_Path & "Papeleta_Pagos_FLI.rpt"
         Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
            '--> Procedimiento Almacenado: SP_PAPELETA_FLI_PAGOS
         BacTrader.bacrpt.StoredProcParam(0) = Format(FechaProceso.text, "YYYY-MM-DD 00:00:00.000")
         BacTrader.bacrpt.StoredProcParam(1) = CDbl(iNumOperacion)
         BacTrader.bacrpt.StoredProcParam(2) = "P"
         BacTrader.bacrpt.StoredProcParam(3) = CDbl(1)
         BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
         BacTrader.bacrpt.Connect = CONECCION
         BacTrader.bacrpt.Action = 1
         
         
     Case "IC" 'Caso captaciones --> ld1-cor-035
        Let cProcedimiento = "SP_PAPELETAIC"
        BacTrader.bacrpt.ReportFileName = RptList_Path & "PACAPTA1.RPT"
         Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
         
        BacTrader.bacrpt.StoredProcParam(0) = CDbl(iNumOperacion)
        BacTrader.bacrpt.StoredProcParam(1) = Format(FechaProceso.text, "YYYY-MM-DD 00:00:00.000")
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
        
     Case "RIC" 'Caso captaciones --> ld1-cor-035
        Let cProcedimiento = "SP_PAPELETARIC"
        BacTrader.bacrpt.ReportFileName = RptList_Path & "PACAPTA2.RPT"
         Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
         
        BacTrader.bacrpt.StoredProcParam(0) = CDbl(iNumOperacion)
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
        
        
   End Select

Exit Sub
ErrorImpresion:
   If err.Number <> 0 Then
      Clipboard.Clear
      Clipboard.SetText BacTrader.bacrpt.ReportFileName & "... " & cProcedimiento
      MsgBox "Error Impresión" & vbCrLf & vbCrLf & BacTrader.bacrpt.LastErrorString, vbExclamation, TITSISTEMA
   End If
End Sub

