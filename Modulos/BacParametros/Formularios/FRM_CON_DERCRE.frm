VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRM_CON_DERCRE 
   Caption         =   "Consulta de Derivados Asociados  a Créditos"
   ClientHeight    =   5430
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9795
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   5430
   ScaleWidth      =   9795
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9795
      _ExtentX        =   17277
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
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar o Refrescar."
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Directo Impresora"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generación de Excel"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog Comando 
         Left            =   4230
         Top             =   15
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3585
         Top             =   15
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
               Picture         =   "FRM_CON_DERCRE.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CON_DERCRE.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CON_DERCRE.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CON_DERCRE.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CON_DERCRE.frx":3B68
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   4755
      Left            =   45
      TabIndex        =   1
      Top             =   375
      Width           =   9720
      Begin MSFlexGridLib.MSFlexGrid GRID 
         Height          =   4575
         Left            =   30
         TabIndex        =   2
         Top             =   135
         Width           =   9660
         _ExtentX        =   17039
         _ExtentY        =   8070
         _Version        =   393216
         Rows            =   3
         Cols            =   13
         FixedCols       =   2
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   3
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
   End
   Begin Threed.SSPanel ProgressPanel 
      Align           =   2  'Align Bottom
      Height          =   300
      Left            =   0
      TabIndex        =   3
      Top             =   5130
      Width           =   9795
      _Version        =   65536
      _ExtentX        =   17277
      _ExtentY        =   529
      _StockProps     =   15
      ForeColor       =   -2147483634
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
End
Attribute VB_Name = "FRM_CON_DERCRE"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Function SETTING_GRID()
   Let GRID.Cols = 17:      Let GRID.FixedRows = 2
   Let GRID.Rows = 3:       Let GRID.FixedCols = 0

   Let GRID.TextMatrix(0, 0) = "Fecha":      Let GRID.TextMatrix(1, 0) = "Relacion":      Let GRID.ColWidth(0) = 950
   Let GRID.TextMatrix(0, 1) = "Número":     Let GRID.TextMatrix(1, 1) = "Crédito":       Let GRID.ColWidth(1) = 900
   Let GRID.TextMatrix(0, 2) = "Número":     Let GRID.TextMatrix(1, 2) = "Derivado":      Let GRID.ColWidth(2) = 950
   Let GRID.TextMatrix(0, 3) = "Producto":   Let GRID.TextMatrix(1, 3) = "Derivado":      Let GRID.ColWidth(3) = 2100
   Let GRID.TextMatrix(0, 4) = "Fecha":      Let GRID.TextMatrix(1, 4) = "Cierre":        Let GRID.ColWidth(4) = 950
   Let GRID.TextMatrix(0, 5) = "Rut":        Let GRID.TextMatrix(1, 5) = "Cliente":       Let GRID.ColWidth(5) = 0
   Let GRID.TextMatrix(0, 6) = "Código":     Let GRID.TextMatrix(1, 6) = "Cliente":       Let GRID.ColWidth(6) = 0
   Let GRID.TextMatrix(0, 7) = "Nombre":     Let GRID.TextMatrix(1, 7) = "Cliente":       Let GRID.ColWidth(7) = 2500
   Let GRID.TextMatrix(0, 8) = "Tipo":       Let GRID.TextMatrix(1, 8) = "Operación":     Let GRID.ColWidth(8) = 950
   Let GRID.TextMatrix(0, 9) = "Modalidad":  Let GRID.TextMatrix(1, 9) = "Cumplimiento":  Let GRID.ColWidth(9) = 1500
   Let GRID.TextMatrix(0, 10) = "Nemo":       Let GRID.TextMatrix(1, 10) = "Moneda":       Let GRID.ColWidth(10) = 950
   Let GRID.TextMatrix(0, 11) = "Tipo":      Let GRID.TextMatrix(1, 11) = "Cambio":       Let GRID.ColWidth(11) = 1500
   Let GRID.TextMatrix(0, 12) = "Monto":     Let GRID.TextMatrix(1, 12) = "Origen":       Let GRID.ColWidth(12) = 2500
   Let GRID.TextMatrix(0, 13) = "Monto":     Let GRID.TextMatrix(1, 13) = "Conversión":   Let GRID.ColWidth(13) = 0
   Let GRID.TextMatrix(0, 14) = "Fecha":     Let GRID.TextMatrix(1, 14) = "Vencimiento":  Let GRID.ColWidth(14) = 950
   Let GRID.TextMatrix(0, 15) = "Valor":     Let GRID.TextMatrix(1, 15) = "Razonable":    Let GRID.ColWidth(15) = 0
   Let GRID.TextMatrix(0, 16) = "Módulo":    Let GRID.TextMatrix(1, 16) = "Origen":       Let GRID.ColWidth(16) = 0
   
   
End Function

Private Sub Form_Load()
   Let Me.Top = 0:       Let Me.Left = 0
   Let Me.Icon = BACSwapParametros.Icon
   Let Me.Caption = "Consulta de derivados asociados a créditos."

   Call SETTING_GRID
   Call LOAD_DATA
End Sub

Private Function LOAD_DATA()
   Dim Datos()
   
   Screen.MousePointer = vbHourglass
   
   If Not Bac_Sql_Execute("dbo.SP_CON_CRED_RELACIONADOS") Then
      Screen.MousePointer = vbHourglass
      Call MsgBox("Ha ocurrido un error al leer Créditos Relacionados.", vbExclamation, App.Title)
      Exit Function
   End If
   GRID.Rows = 2
   Do While Bac_SQL_Fetch(Datos())
       GRID.Rows = GRID.Rows + 1
       Let GRID.TextMatrix(GRID.Rows - 1, 0) = Datos(17)
       Let GRID.TextMatrix(GRID.Rows - 1, 1) = Datos(1)
       Let GRID.TextMatrix(GRID.Rows - 1, 2) = Datos(2)
       Let GRID.TextMatrix(GRID.Rows - 1, 3) = Datos(3)
       Let GRID.TextMatrix(GRID.Rows - 1, 4) = Datos(4)
       Let GRID.TextMatrix(GRID.Rows - 1, 5) = Datos(5)
       Let GRID.TextMatrix(GRID.Rows - 1, 6) = Datos(6)
       Let GRID.TextMatrix(GRID.Rows - 1, 7) = Datos(7)
       Let GRID.TextMatrix(GRID.Rows - 1, 8) = Datos(8)
       Let GRID.TextMatrix(GRID.Rows - 1, 9) = Datos(9)
       Let GRID.TextMatrix(GRID.Rows - 1, 10) = Datos(10)
      Let GRID.TextMatrix(GRID.Rows - 1, 11) = Format(Datos(11), FDecimal)
      Let GRID.TextMatrix(GRID.Rows - 1, 12) = Format(Datos(12), FDecimal)
      Let GRID.TextMatrix(GRID.Rows - 1, 13) = Format(Datos(13), FDecimal)
      Let GRID.TextMatrix(GRID.Rows - 1, 14) = Datos(14)
      Let GRID.TextMatrix(GRID.Rows - 1, 15) = Format(Datos(15), FDecimal)
      Let GRID.TextMatrix(GRID.Rows - 1, 16) = Datos(16)
      

   Loop
   Screen.MousePointer = vbDefault
End Function

Private Sub Form_Resize()
   On Error Resume Next
   
   Frame1.Width = Me.Width - 200
   GRID.Width = Frame1.Width - 50
   
   Frame1.Height = Me.Height - (ProgressPanel.Height + 950)
   GRID.Height = Frame1.Height - 250
   
   On Error GoTo 0
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call LOAD_DATA
      Case 3
         Call GEN_INFORME(False)
      Case 4
         Call GEN_INFORME(True)
      Case 5
         Call EXPORT_FILE
      Case 6
         Call Unload(Me)
   End Select
End Sub

Private Function GEN_INFORME(ByVal ToPrinter As Boolean)
   On Error GoTo PrinterError

   Let Screen.MousePointer = vbHourglass

   Call limpiar_cristal

   Let BACSwapParametros.BACParam.Destination = IIf(ToPrinter = True, crptToPrinter, crptToWindow)
   Let BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "Informe_Credito_Derivado.rpt"
   Let BACSwapParametros.BACParam.WindowTitle = "Informe de Relación entre Créditos y Derivados."
   Let BACSwapParametros.BACParam.StoredProcParam(0) = gsBAC_User
   Let BACSwapParametros.BACParam.Connect = SwConeccion
   Let BACSwapParametros.BACParam.WindowState = crptMaximized
   Let BACSwapParametros.BACParam.Action = 1

   Let Screen.MousePointer = vbDefault

Exit Function
PrinterError:
   Let Screen.MousePointer = vbDefault
   Call MsgBox("Se ha generado un error al imprimir el Documento." & vbCrLf & Err.Description, vbExclamation, App.Title)
End Function

Private Function EXPORT_FILE()
   On Error GoTo ErrorGeneracion
   Dim nFila            As Long
   Dim nColumna         As Long
   Dim iContador        As Long
   Dim MiExcell         As New Excel.Application
   Dim MiLibro          As New Excel.Workbook
   Dim MiHoja           As New Excel.Worksheet
   Dim MiSheet          As Object

   Let ProgressPanel.FloodType = 1
   Let ProgressPanel.FloodPercent = 0

   Let Comando.FileName = "Relación Crédito Derivado.xls"
   Let Comando.Filter = "*.xls"

   Let Comando.CancelError = True

   Call Comando.ShowSave

   If Dir(Comando.FileName & ".XLS") <> "" Then
      Call Kill(Comando.FileName & ".XLS")
   End If

   Set MiExcell = CreateObject("Excel.Application")
   Set MiLibro = MiExcell.Application.Workbooks.Add
   Set MiHoja = MiLibro.Sheets.Add
   Set MiSheet = MiExcell.ActiveSheet
   Let MiSheet.Name = "Créditos Asociados a Derivados."

   For nFila = 2 To GRID.Rows - 1
      If nFila = 2 Then
         Let iContador = 1
         Let MiHoja.Cells(iContador, "A") = "Número Crédito":           Let MiHoja.Range("A:A").HorizontalAlignment = xlRight
         Let MiHoja.Cells(iContador, "B") = "Número Derivado":          Let MiHoja.Range("B:B").HorizontalAlignment = xlRight
         Let MiHoja.Cells(iContador, "C") = "Producto"
         Let MiHoja.Cells(iContador, "D") = "Fecha de Cierre":          Let MiHoja.Range("D:D").HorizontalAlignment = xlRight
         Let MiHoja.Cells(iContador, "E") = "Rut Cliente"
         Let MiHoja.Cells(iContador, "F") = "Nombre Cliente"
         Let MiHoja.Cells(iContador, "G") = "Tipo de Operación"
         Let MiHoja.Cells(iContador, "H") = "Modalidad Cumplimiento"
         Let MiHoja.Cells(iContador, "I") = "Moneda"
         Let MiHoja.Cells(iContador, "J") = "Tipo de Cambio":           Let MiHoja.Range("J:J").HorizontalAlignment = xlRight
         Let MiHoja.Cells(iContador, "K") = "Monto Moneda":             Let MiHoja.Range("K:K").HorizontalAlignment = xlRight
         Let MiHoja.Cells(iContador, "L") = "Monto Conversión":         Let MiHoja.Range("L:L").HorizontalAlignment = xlRight
         Let MiHoja.Cells(iContador, "M") = "Fecha Vencimiento":        Let MiHoja.Range("M:M").HorizontalAlignment = xlRight
      
         Let MiHoja.Range("D:D").Columns.NumberFormat = "DD/MM/yyyy"
         Let MiHoja.Range("M:M").Columns.NumberFormat = "DD/MM/yyyy"
      End If
      Let iContador = iContador + 1

      Let MiHoja.Cells(iContador, "D").NumberFormat = "dd/mm/yyyy"
      Let MiHoja.Cells(iContador, "M").NumberFormat = "dd/mm/yyyy"

      Let MiHoja.Cells(iContador, "A") = GRID.TextMatrix(nFila, 0)
      Let MiHoja.Cells(iContador, "B") = GRID.TextMatrix(nFila, 1)
      Let MiHoja.Cells(iContador, "C") = GRID.TextMatrix(nFila, 2)
      Let MiHoja.Cells(iContador, "D") = " " & GRID.TextMatrix(nFila, 3)
      Let MiHoja.Cells(iContador, "E") = GRID.TextMatrix(nFila, 4)
      Let MiHoja.Cells(iContador, "F") = GRID.TextMatrix(nFila, 6)
      Let MiHoja.Cells(iContador, "G") = GRID.TextMatrix(nFila, 7)
      Let MiHoja.Cells(iContador, "H") = GRID.TextMatrix(nFila, 8)
      Let MiHoja.Cells(iContador, "I") = GRID.TextMatrix(nFila, 9)
      Let MiHoja.Cells(iContador, "J") = Format(GRID.TextMatrix(nFila, 10), FDecimal): Let MiHoja.Cells(iContador, "J").NumberFormat = "#,##0.0000"
      
      Let MiHoja.Cells(iContador, "K") = Format(GRID.TextMatrix(nFila, 11), FDecimal): Let MiHoja.Cells(iContador, "K").NumberFormat = "#,##0.0000"
      Let MiHoja.Cells(iContador, "L") = Format(GRID.TextMatrix(nFila, 12), FDecimal): Let MiHoja.Cells(iContador, "L").NumberFormat = "#,##0.0000"
      Let MiHoja.Cells(iContador, "M") = " " & GRID.TextMatrix(nFila, 13)

      Let ProgressPanel.FloodPercent = ((iContador * 100#) / (GRID.Rows - 1))
      Call BacControlWindows(5)
   Next nFila

   Call MiHoja.SaveAs(Comando.FileName & ".XLS")
   Call MiHoja.Application.Workbooks.Close
   Call MiExcell.Application.Workbooks.Close

   Set MiExcell = Nothing
   Set MiLibro = Nothing
   Set MiHoja = Nothing

   Call MsgBox("Se ha generado archivo con la información.", vbInformation, App.Title)

   Let ProgressPanel.FloodPercent = 0
   Let ProgressPanel.FloodType = 0

Exit Function
ErrorGeneracion:
   If Err.Number = 32755 Then
      Exit Function
   Else
      MsgBox "Error en generación de la Información." & vbCrLf & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
   End If
End Function


