VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRM_ING_TASASPOND 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ingreso de Tasas."
   ClientHeight    =   6585
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7605
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6585
   ScaleWidth      =   7605
   Begin TabDlg.SSTab MITAB 
      Height          =   5355
      Left            =   30
      TabIndex        =   6
      Top             =   930
      Width           =   7560
      _ExtentX        =   13335
      _ExtentY        =   9446
      _Version        =   393216
      Tabs            =   2
      TabHeight       =   520
      TabCaption(0)   =   "IRF"
      TabPicture(0)   =   "FRM_ING_TASASPOND.frx":0000
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "FRA_IRF"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).ControlCount=   1
      TabCaption(1)   =   "IIF"
      TabPicture(1)   =   "FRM_ING_TASASPOND.frx":001C
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "FRA_IIF"
      Tab(1).ControlCount=   1
      Begin VB.Frame FRA_IIF 
         Height          =   4980
         Left            =   -74955
         TabIndex        =   9
         Top             =   330
         Width           =   7455
         Begin MSFlexGridLib.MSFlexGrid GRID_IIF 
            Height          =   4800
            Left            =   30
            TabIndex        =   10
            Top             =   135
            Width           =   7365
            _ExtentX        =   12991
            _ExtentY        =   8467
            _Version        =   393216
            Cols            =   3
            FixedCols       =   0
            BackColor       =   -2147483644
            ForeColor       =   -2147483641
            BackColorFixed  =   -2147483646
            ForeColorFixed  =   -2147483639
            BackColorBkg    =   -2147483645
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            AllowUserResizing=   1
         End
      End
      Begin VB.Frame FRA_IRF 
         Height          =   4980
         Left            =   45
         TabIndex        =   7
         Top             =   330
         Width           =   7455
         Begin MSFlexGridLib.MSFlexGrid GRID_IRF 
            Height          =   4800
            Left            =   30
            TabIndex        =   8
            Top             =   135
            Width           =   7365
            _ExtentX        =   12991
            _ExtentY        =   8467
            _Version        =   393216
            Cols            =   3
            FixedCols       =   0
            BackColor       =   -2147483644
            ForeColor       =   -2147483641
            BackColorFixed  =   -2147483646
            ForeColorFixed  =   -2147483639
            BackColorBkg    =   -2147483645
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            AllowUserResizing=   1
         End
      End
   End
   Begin Threed.SSPanel ProgressPanel 
      Align           =   2  'Align Bottom
      Height          =   300
      Left            =   0
      TabIndex        =   5
      Top             =   6285
      Width           =   7605
      _Version        =   65536
      _ExtentX        =   13414
      _ExtentY        =   529
      _StockProps     =   15
      ForeColor       =   -2147483634
      BackColor       =   13160660
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   1
      BevelInner      =   1
      FloodColor      =   -2147483635
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7605
      _ExtentX        =   13414
      _ExtentY        =   794
      ButtonWidth     =   1799
      ButtonHeight    =   741
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Buscar"
            Object.ToolTipText     =   "Buscar Tasas Almacenadas"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Abrir"
            Object.ToolTipText     =   "Seleccionar Archivo"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Caption         =   "Grabar"
            Object.ToolTipText     =   "Almacenar Informaciòn"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cerrar"
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog Command 
         Left            =   3810
         Top             =   30
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3180
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
               Picture         =   "FRM_ING_TASASPOND.frx":0038
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_TASASPOND.frx":0F12
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_TASASPOND.frx":1DEC
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_TASASPOND.frx":2CC6
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   555
      Left            =   45
      TabIndex        =   1
      Top             =   375
      Width           =   7575
      Begin BACControles.TXTFecha txtFechaProceso 
         Height          =   330
         Left            =   1095
         TabIndex        =   3
         Top             =   165
         Width           =   1470
         _ExtentX        =   2593
         _ExtentY        =   582
         Enabled         =   -1  'True
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25-06-2007"
      End
      Begin VB.Label lblFechaLarga 
         Alignment       =   2  'Center
         Caption         =   "Miercoles, 21 de Septiembre del 2007"
         Height          =   330
         Left            =   2565
         TabIndex        =   4
         Top             =   165
         Width           =   4845
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Fecha."
         Height          =   195
         Left            =   390
         TabIndex        =   2
         Top             =   225
         Width           =   540
      End
   End
End
Attribute VB_Name = "FRM_ING_TASASPOND"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private MiExcell  As New Excel.Application
Private MiLibro   As New Excel.Workbook
Private MiHoja    As New Excel.Worksheet

Private Sub NombresGrilla()
   Let GRID_IRF.Rows = 1
   Let GRID_IRF.Cols = 4
   Let GRID_IRF.TextMatrix(0, 0) = "Emisor":        Let GRID_IRF.ColWidth(0) = 0
   Let GRID_IRF.TextMatrix(0, 1) = "Instrumento":   Let GRID_IRF.ColWidth(1) = 5000
   Let GRID_IRF.TextMatrix(0, 2) = "Tasa":          Let GRID_IRF.ColWidth(2) = 1500
   Let GRID_IRF.TextMatrix(0, 3) = "Monto":         Let GRID_IRF.ColWidth(3) = 0
   Let GRID_IRF.RowHeightMin = 310

   Let GRID_IIF.Rows = 1
   Let GRID_IIF.Cols = 4
   Let GRID_IIF.TextMatrix(0, 0) = "Emisor":        Let GRID_IIF.ColWidth(0) = 2500
   Let GRID_IIF.TextMatrix(0, 1) = "Instrumento":   Let GRID_IIF.ColWidth(1) = 2500
   Let GRID_IIF.TextMatrix(0, 2) = "Tasa":          Let GRID_IIF.ColWidth(2) = 1500
   Let GRID_IIF.TextMatrix(0, 3) = "Monto":         Let GRID_IIF.ColWidth(3) = 0
   Let GRID_IIF.RowHeightMin = 310
End Sub

Private Sub Form_Load()
   Let Me.Icon = BACSwapParametros.Icon
   Let Me.Top = 0: Let Me.Left = 0

   Let ProgressPanel.FloodType = 0

   Call NombresGrilla

   Let TXTFechaProceso.Text = Format(gsbac_fecp, "DD/MM/YYYY")
   Let lblFechaLarga.Caption = FechaLarga(TXTFechaProceso.Text)


   Let MITAB.Tab = 0
   Call Botones(True, False)
End Sub

Private Sub Botones(ByVal valor_ As Boolean, ByVal Grabar_ As Boolean)
   Let Toolbar1.Buttons(2).Enabled = valor_
   Let Toolbar1.Buttons(3).Enabled = valor_
   Let Toolbar1.Buttons(4).Enabled = Grabar_
End Sub

Private Function FechaLarga(ByVal dFecha As Date) As String
   Let FechaLarga = Format(dFecha, "dddd, dd") & " de " & Format(dFecha, "mmmm") & " del " & Format(dFecha, "yyyy")
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call Botones(True, False)
         Call LeerTasasCargadas(TXTFechaProceso.Text)
      Case 3
         Call LeerPlanilla
      Case 5
         Unload Me
   End Select
End Sub

Private Sub txtFechaProceso_Change()
   Let lblFechaLarga.Caption = FechaLarga(TXTFechaProceso.Text)
   
   Call LeerTasasCargadas(TXTFechaProceso.Text)
End Sub

Private Sub LeerTasasCargadas(ByVal Fecha_ As Date)
   Dim Datos()
   Dim iVueltas         As Integer
   Dim iContador        As Long
   Dim nRegistros       As Long
   
   Let GRID_IRF.Redraw = False
   Let GRID_IIF.Redraw = False
   Let GRID_IRF.Rows = 1
   Let GRID_IIF.Rows = 1
   
   Let ProgressPanel.FloodType = 1
   
   For iVueltas = 1 To 2
      Envia = Array()
      AddParam Envia, CDbl(4)
      AddParam Envia, Format(Fecha_, "yyyymmdd")
      AddParam Envia, IIf(iVueltas = 1, "IRF", "IIF")
      If Not Bac_Sql_Execute("SP_CARGA_MERCADO_BOLSA", Envia) Then
         MsgBox "Problemas al Generar el Promedio Ponderado correspondiente a la fecha de Proceso", vbExclamation, TITSISTEMA
         Exit Sub
      End If
      nRegistros = 0
      iContador = 0
      
      Do While Bac_SQL_Fetch(Datos())
         Let iContador = iContador + 1
         If nRegistros = 0 Then Let nRegistros = Datos(5)
      
         If iVueltas = 1 Then
            Let GRID_IRF.Rows = GRID_IRF.Rows + 1
            Let GRID_IRF.TextMatrix(GRID_IRF.Rows - 1, 0) = Datos(1)
            Let GRID_IRF.TextMatrix(GRID_IRF.Rows - 1, 1) = Datos(2)
            Let GRID_IRF.TextMatrix(GRID_IRF.Rows - 1, 2) = Format(Datos(3), FDecimal)
            Let GRID_IRF.TextMatrix(GRID_IRF.Rows - 1, 3) = Format(Datos(4), FDecimal)
         End If
         If iVueltas = 2 Then
            Let GRID_IIF.Rows = GRID_IIF.Rows + 1
            Let GRID_IIF.TextMatrix(GRID_IIF.Rows - 1, 0) = Datos(1)
            Let GRID_IIF.TextMatrix(GRID_IIF.Rows - 1, 1) = Datos(2)
            Let GRID_IIF.TextMatrix(GRID_IIF.Rows - 1, 2) = Format(Datos(3), FDecimal)
            Let GRID_IIF.TextMatrix(GRID_IIF.Rows - 1, 3) = Format(Datos(4), FDecimal)
         End If
         ProgressPanel.FloodPercent = ((iContador * 100#) / nRegistros)
      Loop
   Next iVueltas
   
   Let GRID_IRF.Redraw = True
   Let GRID_IIF.Redraw = True

   Let ProgressPanel.FloodType = 0
   Let ProgressPanel.FloodPercent = 0

End Sub

Private Sub LeerPlanilla()
   On Error GoTo ErrorAction
   Dim Datos()
   Dim oNombre          As String
   
   Let Me.GRID_IRF.Rows = 1
   Let Me.GRID_IIF.Rows = 1
   
   Call Botones(False, False)
   
   Screen.MousePointer = vbHourglass
   
   Let TXTFechaProceso.Text = Format(gsbac_fecp, "DD/MM/YYYY")
   Let oNombre = "TM" & Format(gsbac_fecp, "DDMMYY") & ".xls"
   
ShowOpenAgain:
   Let Command.CancelError = True
   Let Command.Filter = ".XLS"
   Let Command.FileName = oNombre
   Call Command.ShowOpen
   
   If Not Command.FileName Like "*" & oNombre Then
      If MsgBox("Advertencia." & vbCrLf & vbCrLf & "La planilla seleccionada no concuerda con la fecha de proceso." & vbCrLf & vbCrLf & ".... Reintente con otra planilla.", vbExclamation + vbRetryCancel, TITSISTEMA) = vbRetry Then
         GoTo ShowOpenAgain
      Else
         GoTo ErrorAction
      End If
   End If

   Set MiExcell = CreateObject("Excel.Application")
   Set MiLibro = MiExcell.Workbooks.Open(Command.FileName)

   If LeeHojaIRF(Command.FileName) = True Then
      Call LeeHojaIIF(Command.FileName)
   End If
   
   Call BacBeginTransaction
      Envia = Array()
      AddParam Envia, CDbl(3)
      AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
      If Not Bac_Sql_Execute("SP_CARGA_MERCADO_BOLSA", Envia) Then
         Call BacRollBackTransaction
         MsgBox "Problemas al Generar el Promedio Ponderado correspondiente a la fecha de Proceso", vbExclamation, TITSISTEMA
         Exit Sub
      End If
   Call BacCommitTransaction
   
   Call LeerTasasCargadas(gsbac_fecp)
   
   Call Botones(True, True)
   
   MsgBox "Proceso de Generación Promedio Ponderado de Tasas" & vbCrLf & vbCrLf & "Estado: Finalizado sin Problemas.", vbInformation, TITSISTEMA
   
   Screen.MousePointer = vbDefault
Exit Sub
ErrorAction:
   Screen.MousePointer = vbDefault
   If Err.Number = 32755 Then
   Else
      If Err.Number <> 0 Then
         MsgBox "Error en la carga de archivo" & vbCrLf & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
      End If
   End If

   Call Botones(True, False)
End Sub


Private Function LeeHojaIRF(ByVal nFile_ As String) As Boolean
   On Error GoTo Finalizar
   Dim Datos()
   Dim iContador        As Long
   Dim iFilas           As Long
   Dim vDivision        As Double
   
   Let LeeHojaIRF = False

   Let FRA_IRF.Enabled = False
   Let GRID_IRF.Enabled = False
   
   Let ProgressPanel.FloodType = 1
   Let ProgressPanel.FloodPercent = 0

   Set MiHoja = Nothing
   Set MiHoja = MiLibro.Worksheets("IRF")

   '--> Inicia Proceso Transaccional
   If Not BacBeginTransaction Then
      GoTo Finalizar
   End If

   '--> Anula la carga Anterior. para la Fecha y la Hoja IRF.
   Envia = Array()
   AddParam Envia, CDbl(1)
   AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
   AddParam Envia, "IRF"
   If Not Bac_Sql_Execute("SP_CARGA_MERCADO_BOLSA", Envia) Then
      GoTo Rollback
      GoTo Finalizar
   End If
      
   iFilas = MiHoja.Columns.End(xlDown).Row
   
   Let GRID_IRF.Rows = 1
   Let GRID_IRF.Redraw = False
   
   For iContador = 2 To iFilas
'      If MiHoja.Cells(iContador, "H") = "" Then Exit For 'FMO 20210311 correccion carga de tasas
'      If MiHoja.Cells(iContador, "H") <> "PHOD" And MiHoja.Cells(iContador, "H") <> "PMOD" Then
         vDivision = MiHoja.Cells(iContador, "P") / gsBAC_ValmonUF
         If vDivision >= 400# Then
            Envia = Array()
            AddParam Envia, CDbl(2)
            AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
            AddParam Envia, "IRF"
            AddParam Envia, "" '--> MiHoja.Cells(iContador, "H")
            AddParam Envia, MiHoja.Cells(iContador, "G")
            AddParam Envia, CDbl(MiHoja.Cells(iContador, "O"))
            AddParam Envia, CDbl(MiHoja.Cells(iContador, "P"))
            If Not Bac_Sql_Execute("SP_CARGA_MERCADO_BOLSA", Envia) Then
               GoTo Rollback
               GoTo Finalizar
            End If
         End If
'      End If
      Let ProgressPanel.FloodPercent = (iContador * 100 / iFilas)
      Call BacControlWindows(20)
   Next iContador
   
   Call ProgressPanel.Refresh
   Let ProgressPanel.FloodPercent = 100
   
   Let GRID_IRF.Redraw = True
   Let FRA_IRF.Enabled = True
   Let GRID_IRF.Enabled = True

   Set MiHoja = Nothing

   Call BacCommitTransaction
   
   Let LeeHojaIRF = True
   
   GoTo Finalizar
   On Error GoTo 0
Exit Function
Finalizar:
   If Err.Number <> 0 Then
      MsgBox "Problemas en la Carga de Tasas.", vbExclamation, TITSISTEMA
   End If
   On Error GoTo 0
Exit Function
Rollback:
   Call BacRollBackTransaction
   Resume
End Function

Private Function LeeHojaIIF(ByVal nFile_ As String) As Boolean
   On Error GoTo Finalizar
   Dim Datos()
   Dim iContador        As Long
   Dim iFilas           As Long
   Dim vDivision        As Double
   Dim oInstrumento     As String
   Dim iDias            As Double
   Dim dFecVcto         As String
   
   Let LeeHojaIIF = False
   Let FRA_IIF.Enabled = False
   Let GRID_IIF.Enabled = False

   Let ProgressPanel.FloodType = 1
   Let ProgressPanel.FloodPercent = 0

   Set MiHoja = Nothing
   Set MiHoja = MiLibro.Worksheets("IIF")

   '--> Inicia Proceso Transaccional
   If Not BacBeginTransaction Then
      GoTo Finalizar
   End If

   '--> Anula la carga Anterior. para la Fecha y la Hoja IRF.
   Envia = Array()
   AddParam Envia, CDbl(1)
   AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
   AddParam Envia, "IIF"
   If Not Bac_Sql_Execute("SP_CARGA_MERCADO_BOLSA", Envia) Then
      GoTo Rollback
      GoTo Finalizar
   End If

   iFilas = MiHoja.Columns.End(xlDown).Row

   Let GRID_IIF.Rows = 1
   Let GRID_IIF.Redraw = False

   For iContador = 2 To iFilas
'      If MiHoja.Cells(iContador, "H") = "" Then Exit For 'FMO 20210311 carga de tasas
'      If MiHoja.Cells(iContador, "H") <> "PHOD" And MiHoja.Cells(iContador, "H") <> "PMOD" Then
         vDivision = MiHoja.Cells(iContador, "P") / gsBAC_ValmonUF
         If vDivision >= 400# Then

            Let dFecVcto = DateAdd("D", Val(MiHoja.Cells(iContador, "N")), gsbac_fecp)
            Let oInstrumento = UCase(MiHoja.Cells(iContador, "G"))
            Let oInstrumento = IIf(oInstrumento = "PAGARE NR", "DPF-", IIf(oInstrumento = "PAGARE R", "DPR-", oInstrumento)) & Format(dFecVcto, "DDMMYY")

            Envia = Array()
            AddParam Envia, CDbl(2)
            AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
            AddParam Envia, "IIF"
            AddParam Envia, MiHoja.Cells(iContador, "H")
            AddParam Envia, oInstrumento
            AddParam Envia, CDbl(MiHoja.Cells(iContador, "O"))
            AddParam Envia, CDbl(MiHoja.Cells(iContador, "P"))
            If Not Bac_Sql_Execute("SP_CARGA_MERCADO_BOLSA", Envia) Then
               GoTo Rollback
               GoTo Finalizar
            End If
         End If
'      End If
      ProgressPanel.FloodPercent = (iContador * 100 / iFilas)
      Call BacControlWindows(20)
   Next iContador

   Call ProgressPanel.Refresh
    Let ProgressPanel.FloodPercent = 100

   Let GRID_IIF.Redraw = True
   Let FRA_IIF.Enabled = True
   Let GRID_IIF.Enabled = True

   Set MiHoja = Nothing

   Call BacCommitTransaction

   Let LeeHojaIIF = True

   GoTo Finalizar
   On Error GoTo 0
Exit Function
Finalizar:
   If Err.Number <> 0 Then
      MsgBox "Problemas en la Carga de Tasas.", vbExclamation, TITSISTEMA
   End If
   On Error GoTo 0
Exit Function
Rollback:
   Call BacRollBackTransaction
   Resume
End Function
