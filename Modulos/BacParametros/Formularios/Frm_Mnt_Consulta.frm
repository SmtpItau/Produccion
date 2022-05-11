VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form Frm_Mnt_Consulta 
   Caption         =   "Consulta.-"
   ClientHeight    =   8175
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9570
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   8175
   ScaleWidth      =   9570
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9570
      _ExtentX        =   16880
      _ExtentY        =   794
      ButtonWidth     =   2408
      ButtonHeight    =   741
      ToolTips        =   0   'False
      AllowCustomize  =   0   'False
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
            Caption         =   "Procesar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "Exportar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cerrar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "Ajuste AVR"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   6300
         Top             =   15
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
               Picture         =   "Frm_Mnt_Consulta.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Consulta.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Consulta.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Consulta.frx":1F0E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   705
      Left            =   45
      TabIndex        =   1
      Top             =   375
      Width           =   9510
      Begin MSComDlg.CommonDialog Comando 
         Left            =   6315
         Top             =   180
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComCtl2.DTPicker TXTFechaProceso 
         Height          =   315
         Left            =   1665
         TabIndex        =   3
         Top             =   225
         Width           =   1710
         _ExtentX        =   3016
         _ExtentY        =   556
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Format          =   92274689
         CurrentDate     =   41190
      End
      Begin VB.Label LBLStatus 
         AutoSize        =   -1  'True
         Caption         =   " Procesando ... "
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
         Left            =   3480
         TabIndex        =   4
         Top             =   270
         Visible         =   0   'False
         Width           =   1260
      End
      Begin VB.Label LblFecha 
         AutoSize        =   -1  'True
         Caption         =   "Fecha a Procesar"
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
         Left            =   135
         TabIndex        =   2
         Top             =   270
         Width           =   1440
      End
   End
   Begin VB.Frame Frame2 
      Enabled         =   0   'False
      Height          =   7140
      Left            =   45
      TabIndex        =   5
      Top             =   1005
      Width           =   9510
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   6945
         Left            =   15
         TabIndex        =   6
         Top             =   120
         Width           =   9465
         _ExtentX        =   16695
         _ExtentY        =   12250
         _Version        =   393216
         AllowUserResizing=   3
      End
   End
End
Attribute VB_Name = "Frm_Mnt_Consulta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public swOnOff As Integer

Private Function FuncLoadTitle()
    Let Grilla.Cols = 21:       Let Grilla.FixedCols = 0
    Let Grilla.Rows = 2:        Let Grilla.FixedRows = 1
    
    Let Grilla.Font.Name = "Thoma"
    Let Grilla.Font.Size = 8
    
    
    Let Grilla.TextMatrix(0, 0) = "Fecha Auxiliar":             Let Grilla.ColWidth(0) = 1500
    Let Grilla.TextMatrix(0, 1) = "Fecha Suscripción":          Let Grilla.ColWidth(1) = 1500
    Let Grilla.TextMatrix(0, 2) = "Fecha Liquidación":          Let Grilla.ColWidth(2) = 1500
    Let Grilla.TextMatrix(0, 3) = "N° Operación":               Let Grilla.ColWidth(3) = 1500
    Let Grilla.TextMatrix(0, 4) = "Tipo Contrato":              Let Grilla.ColWidth(4) = 1500
    Let Grilla.TextMatrix(0, 5) = "Producto":                   Let Grilla.ColWidth(5) = 2500
    Let Grilla.TextMatrix(0, 6) = "Rut Cliente":                Let Grilla.ColWidth(6) = 1500
    Let Grilla.TextMatrix(0, 7) = "Nombre Cliente":             Let Grilla.ColWidth(7) = 4500
    Let Grilla.TextMatrix(0, 8) = "Nombre Cta Balance":         Let Grilla.ColWidth(8) = 2500
    Let Grilla.TextMatrix(0, 9) = "Codigo AVR Activo":          Let Grilla.ColWidth(9) = 2000
    Let Grilla.TextMatrix(0, 10) = "Cuenta Patrimonio":         Let Grilla.ColWidth(10) = 2000
    Let Grilla.TextMatrix(0, 11) = "Cuenta Resultado AVR":      Let Grilla.ColWidth(11) = 2000
    Let Grilla.TextMatrix(0, 12) = "AVR Neto":                  Let Grilla.ColWidth(12) = 2000
    Let Grilla.TextMatrix(0, 13) = "Flujo Caja":                Let Grilla.ColWidth(13) = 2000
    Let Grilla.TextMatrix(0, 14) = "AVR Fecha Proceso":         Let Grilla.ColWidth(14) = 2000
    Let Grilla.TextMatrix(0, 15) = "AVR Patrimonio":            Let Grilla.ColWidth(15) = 2000
    Let Grilla.TextMatrix(0, 16) = "R° AVR Derivados":          Let Grilla.ColWidth(16) = 2000
    Let Grilla.TextMatrix(0, 17) = "R° Liquidación":            Let Grilla.ColWidth(17) = 2000
    Let Grilla.TextMatrix(0, 18) = "Otros Resultados":          Let Grilla.ColWidth(18) = 1500
    Let Grilla.TextMatrix(0, 19) = "Traspaso entre cuentas":    Let Grilla.ColWidth(19) = 1500
    Let Grilla.TextMatrix(0, 20) = "Saldo AVR al Termino":      Let Grilla.ColWidth(20) = 2000
    
End Function

Private Sub Form_Load()
    Let Me.Icon = BACSwapParametros.Icon
    Let Me.TXTFechaProceso.Value = FuncLoadDate
    Call FuncLoadTitle
End Sub

Private Function FuncLoadDate() As String
    Dim oSqlDatos()
    Dim Envia()
    
    Envia = Array()
    Call AddParam(Envia, Format(TXTFechaProceso.Value, "yyyymmdd"))
    Call AddParam(Envia, 1)
    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Tributarios_Valida_Fecha", Envia) Then
        Exit Function
    End If
    If Bac_SQL_Fetch(oSqlDatos()) Then
        Let FuncLoadDate = oSqlDatos(1)
    End If
End Function

Private Sub Form_Resize()
    On Error Resume Next
    Let Frame1.Width = Me.Width - 150
    Let Frame2.Width = Frame1.Width
    Let Grilla.Width = Frame2.Width - 100

    Let Frame2.Height = Me.Height - 1550
    Let Grilla.Height = Frame2.Height - 150
    On Error GoTo 0
End Sub


Private Sub Grilla_DblClick()
    Dim nColumna        As Integer
    
    Let nColumna = Grilla.ColSel
   
    Let Grilla.Sort = nColumna
End Sub

Private Sub Grilla_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim nValorNumerico  As Variant
    Dim nTituloColumna  As String
    
    If Button = 2 Then
        Let nTituloColumna = UCase(Grilla.TextMatrix(0, Grilla.ColSel))
        Let nValorNumerico = InputBox(" ¿ " & nTituloColumna & " ? ", " Buscando ", "")
        Call BuscarIndicador(nValorNumerico, Grilla.ColSel, Grilla)
    End If

End Sub

Private Sub BuscarIndicador(ByVal nValor As Variant, ByVal nColumna As Integer, Grid As MSFlexGrid)
    Dim nContador   As Long
    
    For nContador = 1 To Grid.Rows - 1
        If (Grid.TextMatrix(nContador, nColumna)) Like "*" & nValor & "*" Then
            Let Grid.TopRow = nContador
            Call Grid.Refresh
            Exit For
        End If
    Next nContador
    
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
      
        If FuncChequedDate = True Then
            Let TXTFechaProceso.Enabled = False
            Call FuncExecution
        End If
      
      Case 3
      
        Call FuncGenExcel

      Case 4
      
        Call Unload(Me)
        
      Case 6
        MsgBox ("Funcionalidad en Reestructuracion")
        ' Call FuncCargaAjuste
        
   End Select
End Sub



Public Function FuncExecution()
    Dim Sqldatos()
    Dim Envia()
    Dim oSqlDatos()

    Let Grilla.Rows = 1

    Let LBLStatus.Caption = "Procesando ... "
    Let LBLStatus.Visible = True
    Let Grilla.Redraw = False
    Let Grilla.Enabled = False
    Let Toolbar1.Buttons(6).Enabled = False
   Call LBLStatus.Refresh

    Let Screen.MousePointer = vbHourglass
    Call vbExcel.ControlWindows(4)

    Envia = Array()
    Call AddParam(Envia, Format(TXTFechaProceso.Value, "yyyymmdd"))
    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Tributarios_Generar", Envia) Then
        Let Screen.MousePointer = vbDefault
        Let LBLStatus.Visible = False
        Let Grilla.Redraw = True
        Exit Function
    End If
    If Bac_SQL_Fetch(oSqlDatos()) Then
        If oSqlDatos(1) = -1 Then
            Let Screen.MousePointer = vbDefault
            Let LBLStatus.Visible = False
            Let Grilla.Redraw = True
            Let Grilla.Enabled = True
            Call MsgBox("Warning" & vbCrLf & vbCrLf & oSqlDatos(2), vbExclamation, App.Title)
            Exit Function
        End If
    End If
    
    Envia = Array()
    Call AddParam(Envia, Format(TXTFechaProceso.Value, "yyyymmdd"))
    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Tributarios_GeneraInforme", Envia) Then
        Let Screen.MousePointer = vbDefault
        Let LBLStatus.Visible = False
        Let Grilla.Redraw = True
        Let Grilla.Enabled = True
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(oSqlDatos())
        If oSqlDatos(1) = -1 Then
            Let Screen.MousePointer = vbDefault
            Let LBLStatus.Visible = False
            Let Grilla.Redraw = True
            Let Grilla.Enabled = True
            Call MsgBox("Warning" & vbCrLf & vbCrLf & oSqlDatos(2), vbExclamation, App.Title)
            Exit Do
        End If
        
        Let Grilla.Rows = Grilla.Rows + 1
        Let Grilla.TextMatrix(Grilla.Rows - 1, 0) = oSqlDatos(1)                   '-> "Fecha Auxiliar":            Let Grilla.ColWidth(0) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 1) = oSqlDatos(2)                   '-> "Fecha Suscripción":         Let Grilla.ColWidth(1) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 2) = oSqlDatos(3)                   '-> "Fecha Liquidación":         Let Grilla.ColWidth(2) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 3) = oSqlDatos(4)                   '-> "N° Operación":              Let Grilla.ColWidth(3) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 4) = oSqlDatos(5)                   '-> "Tipo Contrato":             Let Grilla.ColWidth(4) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 5) = oSqlDatos(6)                   '-> "Producto":                  Let Grilla.ColWidth(5) = 2500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 6) = oSqlDatos(7)                   '-> "Rut Cliente":               Let Grilla.ColWidth(6) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 7) = oSqlDatos(8)                   '-> "Nombre Cliente":            Let Grilla.ColWidth(7) = 2500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 8) = oSqlDatos(9)                   '-> "Nombre Cta Balance":        Let Grilla.ColWidth(8) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 9) = oSqlDatos(10)                  '-> "Codigo AVR Activo":         Let Grilla.ColWidth(9) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 10) = oSqlDatos(11)                 '-> "Cuenta Patrimonio":         Let Grilla.ColWidth(10) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 11) = oSqlDatos(12)                 '-> "Cuenta Resultado AVR":      Let Grilla.ColWidth(11) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 12) = oSqlDatos(13)                 '-> "AVR Neto":                  Let Grilla.ColWidth(12) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 13) = oSqlDatos(14)                 '-> "Flujo Caja":                Let Grilla.ColWidth(13) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 14) = oSqlDatos(15)                 '-> "AVR Fecha Proceso":         Let Grilla.ColWidth(14) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 15) = oSqlDatos(16)                 '-> "AVR Patrimonio":            Let Grilla.ColWidth(15) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 16) = oSqlDatos(17)                 '-> "R° AVR Derivados":          Let Grilla.ColWidth(16) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 17) = oSqlDatos(18)                 '-> "R° Liquidación":            Let Grilla.ColWidth(17) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 18) = oSqlDatos(19)                 '-> "Otros Resultados":          Let Grilla.ColWidth(18) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 19) = oSqlDatos(20)                 '-> "Traspaso entre cuentas":    Let Grilla.ColWidth(19) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 20) = oSqlDatos(21)                 '-> "Saldo AVR al Termino":      Let Grilla.ColWidth(20) = 1500
        
        
        Let Toolbar1.Buttons(3).Enabled = True
        Let Toolbar1.Buttons(6).Enabled = True
        If Grilla.Rows >= 30 Then
          'MAP la grilla presenta problemas de memoria
          'se llena una hoja de grilla para la emoción
          'del usuario final.
          Let Grilla.TextMatrix(Grilla.Rows - 1, 7) = "Se interrumple despliegue de datos..."
          GoTo SalirGrillaTributario
        End If
    Loop

SalirGrillaTributario:
    Let Screen.MousePointer = vbDefault
    
    Let LBLStatus.Visible = False
    Let Me.Frame2.Enabled = True
    Let Grilla.Redraw = True
    Let Grilla.Enabled = True

End Function

Private Function FuncChequedDate() As Boolean
    Dim Envia()
    Dim oSqlDatos()

    Let FuncChequedDate = False

    Envia = Array()
    Call AddParam(Envia, Format(TXTFechaProceso.Value, "yyyymmdd"))

    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Tributarios_Valida_Fecha", Envia) Then
        Exit Function
    End If
    If Bac_SQL_Fetch(oSqlDatos()) Then
        If oSqlDatos(1) = 0 Then
            Let FuncChequedDate = True
        End If
    End If

End Function

Public Function FuncGenExcel()
    On Error GoTo ErrorExcel
    Dim MiExcell                    As Object
    Dim MiLibro                     As New Excel.Workbook
    Dim MiHoja                      As New Excel.Worksheet
    Dim vbColorBoxTitle             As Variant
    Dim vbColorFontTitle            As Variant
    Dim nFila                       As Long
    Dim nColumna                    As Long

    Dim dFechaCierrePeriodoAnterior As String

    Me.LBLStatus.Caption = "Generando Excel .... Favor Espere !"
    Me.LBLStatus.Visible = True

    Let vbColorBoxTitle = RGB(192, 192, 192)
    Let vbColorFontTitle = RGB(0, 0, 0)
    
    Let Comando.FileName = "C:\Tributarios.xls"
    Let Comando.Filter = "*.xls"
    Let Comando.CancelError = True
    
    Call Comando.ShowSave
    
    If Dir(Comando.FileName) <> "" Then
        Call Kill(Comando.FileName)
    End If
    
    Call vbExcel.AbrirExcel(MiExcell, False)
    
    Set MiLibro = MiExcell.Application.Workbooks.Add
     Set MiHoja = MiLibro.Sheets.Add
    Set MiSheet = MiExcell.ActiveSheet
    Let MiSheet.Name = "Tributarios"

    Let Screen.MousePointer = vbHourglass

    Let MiExcell.Visible = False
    
    Call vbExcel.ControlWindows(10)
    
    
        
    '-> DEFINE TITULOS EN PLANILLA <-'
    Let nFila = 1
    Let MiHoja.Cells(nFila, "A") = "FECHA DEL AUXILIAR":
    Let MiHoja.Cells(nFila, "B") = "FECHA DE SUSCRIPCION":
    Let MiHoja.Cells(nFila, "C") = "FECHA DE LIQUIDACION":
    Let MiHoja.Cells(nFila, "D") = "N° DE OPERACION":
    Let MiHoja.Cells(nFila, "E") = "TIPO DE CONTRATO":
    Let MiHoja.Cells(nFila, "F") = "PRODUCTO":
    Let MiHoja.Cells(nFila, "G") = "RUT CLIENTE":
    Let MiHoja.Cells(nFila, "H") = "NOMBRE DE CLIENTE":
    Let MiHoja.Cells(nFila, "I") = "NOMBRE CUENTA DE BALANCE":
    Let MiHoja.Cells(nFila, "J") = "CÓDIGO AVR ACTIVO/PASIVO (IBS)":
    Let MiHoja.Cells(nFila, "K") = "CUENTA PATRIMONIO (IBS)":
    Let MiHoja.Cells(nFila, "L") = "CUENTA RESULTADO DERIVADOS (IBS)":
    Let MiHoja.Cells(nFila, "M") = "AVR Neto al " & dFechaCierrePeriodoAnterior:
    Let MiHoja.Cells(nFila, "N") = "Flujos de Caja del Periodo":
    Let MiHoja.Cells(nFila, "O") = "AVR neto  a la fecha del Ejercicio"
    Let MiHoja.Cells(nFila, "P") = "AVR neto  a patrimonio del ejercicio"
    Let MiHoja.Cells(nFila, "Q") = "R° AVR Derivados"
    Let MiHoja.Cells(nFila, "R") = "R° Liquidación derivados "
    Let MiHoja.Cells(nFila, "S") = "Otros resultados "
    Let MiHoja.Cells(nFila, "T") = "Traspasos entre cuentas"
    Let MiHoja.Cells(nFila, "U") = "Saldo AVR al término"
    
    Call MiHoja.Columns("A:U").EntireColumn.AutoFit
      Let MiHoja.Range("A" & nFila, "U" & nFila).RowHeight = 50
      Let MiHoja.Range("A" & nFila, "U" & nFila).ColumnWidth = 15
      Let MiHoja.Range("A" & nFila, "U" & nFila).WrapText = True
      
      Let MiHoja.Range("A" & nFila, "U" & nFila).Font.Name = "Tahoma"
      Let MiHoja.Range("A" & nFila, "U" & nFila).Font.Size = 10
      Let MiHoja.Range("A" & nFila, "U" & nFila).Font.Bold = False
      Let MiHoja.Range("A" & nFila, "U" & nFila).Font.Color = vbColorFontTitle
      Let MiHoja.Range("A" & nFila, "U" & nFila).Interior.Color = vbColorBoxTitle
     Call MiHoja.Range("A" & nFila, "U" & nFila).Select: Call vbExcel.FuncCreaMarco
     Call MiHoja.Columns("A:U").EntireColumn.AutoFit
    
    '-> DEFINE TITULOS EN PLANILLA <-'
    Let nFila = 2
    Let MiHoja.Cells(nFila, "A") = "1":
    Let MiHoja.Cells(nFila, "B") = "2":
    Let MiHoja.Cells(nFila, "C") = "3":
    Let MiHoja.Cells(nFila, "D") = "4":
    Let MiHoja.Cells(nFila, "E") = "5":
    Let MiHoja.Cells(nFila, "F") = "6":
    Let MiHoja.Cells(nFila, "G") = "7":
    Let MiHoja.Cells(nFila, "H") = "8":
    Let MiHoja.Cells(nFila, "I") = "9":
    Let MiHoja.Cells(nFila, "J") = "10":
    Let MiHoja.Cells(nFila, "K") = "11":
    Let MiHoja.Cells(nFila, "L") = "12":
    Let MiHoja.Cells(nFila, "M") = "13":
    Let MiHoja.Cells(nFila, "N") = "14":
    Let MiHoja.Cells(nFila, "O") = "15"
    Let MiHoja.Cells(nFila, "P") = "16"
    Let MiHoja.Cells(nFila, "Q") = "17"
    Let MiHoja.Cells(nFila, "R") = "18"
    Let MiHoja.Cells(nFila, "S") = "19"
    Let MiHoja.Cells(nFila, "T") = "20"
    Let MiHoja.Cells(nFila, "U") = "21"
    
    Let MiHoja.Range("A2", "U2").HorizontalAlignment = xlCenter
      Let MiHoja.Range("A2", "U2").VerticalAlignment = xlCenter

      Let MiHoja.Range("A" & nFila, "U" & nFila).Font.Name = "Tahoma"
      Let MiHoja.Range("A" & nFila, "U" & nFila).Font.Size = 10
      Let MiHoja.Range("A" & nFila, "U" & nFila).Font.Bold = False
      Let MiHoja.Range("A" & nFila, "U" & nFila).Font.Color = vbColorFontTitle
      Let MiHoja.Range("A" & nFila, "U" & nFila).Interior.Color = vbColorBoxTitle
     Call MiHoja.Range("A" & nFila, "U" & nFila).Select: Call vbExcel.FuncCreaMarco
     Call MiHoja.Columns("A:U").EntireColumn.AutoFit
    
    Let nFila = 3
        
    Dim oSqlDatos()
    Dim Envia()
        
        
    Envia = Array()
    Call AddParam(Envia, Format(TXTFechaProceso.Value, "yyyymmdd"))
    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Tributarios_GeneraInforme", Envia) Then
        Let Screen.MousePointer = vbDefault
        Let LBLStatus.Visible = False
        Exit Function
    End If
    Do While Bac_SQL_Fetch(oSqlDatos())
        If oSqlDatos(1) = -1 Then
            Let Screen.MousePointer = vbDefault
            Let LBLStatus.Visible = False
            Call MsgBox("Warning" & vbCrLf & vbCrLf & oSqlDatos(2), vbExclamation, App.Title)
            Exit Do
        End If

        Let MiHoja.Cells(nFila, "A") = " " & oSqlDatos(1)
        Let MiHoja.Cells(nFila, "B") = " " & oSqlDatos(2)
        Let MiHoja.Cells(nFila, "C") = " " & oSqlDatos(3)
        Let MiHoja.Cells(nFila, "D") = oSqlDatos(4)
        Let MiHoja.Cells(nFila, "E") = oSqlDatos(5)
        Let MiHoja.Cells(nFila, "F") = oSqlDatos(6)
        Let MiHoja.Cells(nFila, "G") = oSqlDatos(7)
        Let MiHoja.Cells(nFila, "H") = oSqlDatos(8)
        Let MiHoja.Cells(nFila, "I") = oSqlDatos(9)
        Let MiHoja.Cells(nFila, "J") = oSqlDatos(10)
        Let MiHoja.Cells(nFila, "K") = oSqlDatos(11)
        Let MiHoja.Cells(nFila, "L") = oSqlDatos(12)
        Let MiHoja.Cells(nFila, "M") = oSqlDatos(13)
        Let MiHoja.Cells(nFila, "N") = oSqlDatos(14)
        Let MiHoja.Cells(nFila, "O") = oSqlDatos(15)
        Let MiHoja.Cells(nFila, "P") = oSqlDatos(16)
        Let MiHoja.Cells(nFila, "Q") = oSqlDatos(17)
        Let MiHoja.Cells(nFila, "R") = oSqlDatos(18)
        Let MiHoja.Cells(nFila, "S") = oSqlDatos(19)
        Let MiHoja.Cells(nFila, "T") = oSqlDatos(20)
        Let MiHoja.Cells(nFila, "U") = oSqlDatos(21)

        Let nFila = nFila + 1
    Loop
    
    Let MiHoja.Range("A3", "C" & nFila).NumberFormat = "dd/mm/yyyy"
    Let MiHoja.Range("A3", "C" & nFila).HorizontalAlignment = xlRight
    Let MiHoja.Range("A3", "C" & nFila).VerticalAlignment = xlBottom
    Let MiHoja.Range("A3", "C" & nFila).Orientation = 0

    Let MiHoja.Range("M3", "R" & nFila).NumberFormat = "#,##0"
    Let MiHoja.Range("M3", "R" & nFila).HorizontalAlignment = xlRight
    Let MiHoja.Range("M3", "R" & nFila).VerticalAlignment = xlBottom
    Let MiHoja.Range("M3", "R" & nFila).Orientation = 0

    Let MiHoja.Range("U3", "U" & nFila).NumberFormat = "#,##0"
    Let MiHoja.Range("U3", "U" & nFila).HorizontalAlignment = xlRight
    Let MiHoja.Range("U3", "U" & nFila).VerticalAlignment = xlBottom
    Let MiHoja.Range("U3", "U" & nFila).Orientation = 0

    Let MiHoja.Range("A3", "U" & nFila).Font.Name = "Tahoma"
    Let MiHoja.Range("A3", "U" & nFila).Font.Size = 10
    Let MiHoja.Range("A3", "U" & nFila).Font.Bold = False
    Call MiHoja.Range("A3", "U" & nFila).Select: Call vbExcel.FuncCreaMarco
    Call MiHoja.Columns("A:U").EntireColumn.AutoFit
        
    Call MiHoja.SaveAs(Comando.FileName)
    Call MiHoja.Application.Workbooks.Close
    Call MiExcell.Application.Workbooks.Close
   
    Set MiExcell = Nothing
    Set MiLibro = Nothing
    Set MiHoja = Nothing
    
    Let Me.LBLStatus.Caption = "Generando Excel .... Favor Espere !"
    Let Me.LBLStatus.Visible = False
    
    Let Screen.MousePointer = vbDefault
    Call MsgBox("Formato Generado", vbInformation, "")

Exit Function
ErrorExcel:

    If Err.Number = 91 Then
        Resume Next
    End If

    Set MiExcell = Nothing
    Set MiLibro = Nothing
    Set MiHoja = Nothing

    Call MsgBox("E- Error" & vbCrLf & vbCrLf & Err.Description, vbExclamation, "")

End Function


Private Function FuncLeerDatosFecha()
    Dim Sqldatos()
    Dim Envia()
    Dim oSqlDatos()
    
    
    Let LBLStatus.Visible = True
    Let Screen.MousePointer = vbHourglass
    Let LBLStatus.Caption = "BUSCANDO INFORMACION A LA FECHA ... ESPERE ...."
    Let Grilla.Redraw = False
    Let Grilla.Enabled = False
    
    Call BacControlWindows(1)
    
    Envia = Array()
    Call AddParam(Envia, Format(TXTFechaProceso.Value, "yyyymmdd"))
    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Tributarios_GeneraInforme", Envia) Then
        Let Screen.MousePointer = vbDefault
        Let LBLStatus.Visible = False
        Let Grilla.Redraw = True
        Let Grilla.Enabled = True
        Exit Function
    End If
    
    Let Grilla.Rows = 1
    
    Do While Bac_SQL_Fetch(oSqlDatos())
        Let LBLStatus.Caption = "CARGANDO INFORMACION EXISTENTE PARA LA FECHA ... ESPERE ...."
    
        If oSqlDatos(1) = -1 Then
            Let Screen.MousePointer = vbDefault
            Let LBLStatus.Visible = False
            Call MsgBox("Warning" & vbCrLf & vbCrLf & oSqlDatos(2), vbExclamation, App.Title)
            Let Grilla.Redraw = True
            Let Grilla.Enabled = True
            Exit Do
        End If
        
        Let Grilla.Rows = Grilla.Rows + 1
        Let Grilla.TextMatrix(Grilla.Rows - 1, 0) = oSqlDatos(1)                  '-> "Fecha Auxiliar":             Let Grilla.ColWidth(0) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 1) = Trim(oSqlDatos(2))             '-> "Fecha Suscripción":          Let Grilla.ColWidth(1) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 2) = oSqlDatos(3)                  '-> "Fecha Liquidación":          Let Grilla.ColWidth(2) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 3) = oSqlDatos(4)                  '-> "N° Operación":               Let Grilla.ColWidth(3) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 4) = oSqlDatos(5)                  '-> "Tipo Contrato":              Let Grilla.ColWidth(4) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 5) = oSqlDatos(6)                  '-> "Producto":                   Let Grilla.ColWidth(5) = 2500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 6) = oSqlDatos(7)                  '-> "Rut Cliente":                Let Grilla.ColWidth(6) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 7) = oSqlDatos(8)                  '-> "Nombre Cliente":             Let Grilla.ColWidth(7) = 2500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 8) = oSqlDatos(9)                  '-> "Nombre Cta Balance":         Let Grilla.ColWidth(8) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 9) = oSqlDatos(10)                  '-> "Codigo AVR Activo":          Let Grilla.ColWidth(9) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 10) = oSqlDatos(11)                 '-> "Cuenta Patrimonio":         Let Grilla.ColWidth(10) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 11) = oSqlDatos(12)                 '-> "Cuenta Resultado AVR":      Let Grilla.ColWidth(11) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 12) = oSqlDatos(13)                 '-> "AVR Neto":                  Let Grilla.ColWidth(12) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 13) = oSqlDatos(14)                 '-> "Flujo Caja":                Let Grilla.ColWidth(13) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 14) = oSqlDatos(15)                 '-> "AVR Fecha Proceso":         Let Grilla.ColWidth(14) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 15) = oSqlDatos(16)                 '-> "AVR Patrimonio":            Let Grilla.ColWidth(15) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 16) = oSqlDatos(17)                 '-> "R° AVR Derivados":          Let Grilla.ColWidth(16) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 17) = oSqlDatos(18)                 '-> "R° Liquidación":            Let Grilla.ColWidth(17) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 18) = oSqlDatos(19)                 '-> "Otros Resultados":          Let Grilla.ColWidth(18) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 19) = oSqlDatos(20)                 '-> "Traspaso entre cuentas":    Let Grilla.ColWidth(19) = 1500
        Let Grilla.TextMatrix(Grilla.Rows - 1, 20) = oSqlDatos(21)                 '-> "Saldo AVR al Termino":      Let Grilla.ColWidth(20) = 1500
        
        Let Toolbar1.Buttons(3).Enabled = True
        Let Toolbar1.Buttons(6).Enabled = True
        
    Loop

    Let LBLStatus.Caption = ""
    Let LBLStatus.Visible = False
    Let Grilla.Redraw = True
    Let Grilla.Enabled = True
    Let Screen.MousePointer = vbDefault
    Let Frame1.Enabled = True
    Let Frame2.Enabled = True
    
    
End Function


Private Sub TXTFechaProceso_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        Call FuncLeerDatosFecha
    End If
End Sub


Private Function FuncCargaAjuste()
    On Error GoTo ErrorOper
    Dim MiExcell            As New Excel.Application
    Dim MiLibro             As New Excel.Workbook
    Dim MiHoja              As New Excel.Worksheet
    Dim nContador           As Long
    Dim nContrato           As Long
    Dim nValorBAC           As Double
    Dim nValorMRF           As Double
    Dim cMensaje            As String
    Dim nContadorEfe        As Long
   
    Comando.DialogTitle = "Carga planilla de Ajuste Avr"
    Comando.InitDir = "C:\"
    Comando.Flags = cdlOFNLongNames
    Comando.DefaultExt = "xlsx"
    Comando.Filter = ".xlsx"
    Comando.CancelError = True
    Comando.FileName = "Valorizacion Derivado.xlsx"

    Call Comando.ShowOpen
    Reset
    If Not Comando.FileName Like "*Valorizacion Derivado*.*" Then
        GoTo ErrorOper
    End If
    
    Call AbrirExcel(MiExcell, False)
    
    Set MiLibro = MiExcell.Workbooks.Open(Comando.FileName)
    Set MiHoja = Nothing
    Set MiHoja = MiLibro.Worksheets(1)


   '->    Validacion de Columnas Requeridas
    '->>    Fecha de Informe
    If Not UCase(MiHoja.Cells(2, "C")) Like UCase("*Fecha Informe*") Then
        Call MsgBox("En la columna C, Fila 2, debe indicar [Fecha Informe]", vbExclamation, App.Title)
        GoTo CloseData
        Exit Function
    End If
    If Len(UCase(MiHoja.Cells(2, "D"))) = 0 Then
        Call MsgBox("En la columna D, Fila 2, no tiene datos.", vbExclamation, App.Title)
        GoTo CloseData
        Exit Function
    End If
    
    '->>    Fecha de Cierre Anterior
    If Not UCase(MiHoja.Cells(3, "C")) Like UCase("*Fecha Cierre Anterior*") Then
        Call MsgBox("En la columna C, Fila 2, debe indicar [Fecha Cierre Anterior]", vbExclamation, App.Title)
        GoTo CloseData
        Exit Function
    End If
    If Len(UCase(MiHoja.Cells(3, "D"))) = 0 Then
        Call MsgBox("En la columna D, Fila 3, no tiene datos.", vbExclamation, App.Title)
        GoTo CloseData
        Exit Function
    End If

    '->>    Columnas Valor Mercado BAC y RF
    If Not UCase(MiHoja.Cells(7, "C")) Like UCase("*Valor Mercado BAC*") Then
        Call MsgBox("En la columna C, Fila 8, debe indicar [Fecha Cierre Anterior]", vbExclamation, App.Title)
        GoTo CloseData
        Exit Function
    End If
    If Not UCase(MiHoja.Cells(7, "D")) Like UCase("*Valor Mercado RF*") Then
        Call MsgBox("En la columna C, Fila 2, debe indicar [Fecha Cierre Anterior]", vbExclamation, App.Title)
        GoTo CloseData
        Exit Function
    End If

    If Not UCase(MiHoja.Cells(8, "B")) Like UCase("*Total*") Then
        Call MsgBox("En la columna B, Fila 8, debe indicar [Total]", vbExclamation, App.Title)
        GoTo CloseData
        Exit Function
    End If


    Let nContrato = 0:  Let nContadorEfe = 0:   Let cMensaje = ""
    Let nValorBAC = 0#
    Let nValorMRF = 0#

    Call MsgBox("Recuerde que: Se procesaran los ajustes indicados a partir de (Columna B, Fila 9).", vbInformation, App.Title)

    Call FuncDelAjuste

    For nContador = 9 To 48000
        If Len(UCase(MiHoja.Cells(nContador, "B"))) = 0 Then
            Exit For
        End If
        If Trim(MiHoja.Cells(nContador, "B")) = "0" Then
            Exit For
        End If

        Let nContadorEfe = nContadorEfe + 1
           Let nContrato = Trim(MiHoja.Cells(nContador, "B"))
           Let nValorBAC = Trim(MiHoja.Cells(nContador, "C"))
           Let nValorMRF = Trim(MiHoja.Cells(nContador, "D"))

        If FuncGenAjuste(nContrato, nValorBAC, nValorMRF) = True Then
            Let cMensaje = cMensaje & Trim(nContadorEfe) & ".- Folio : " & nContrato & "  OK.    " & vbCrLf
            Let MiHoja.Cells(nContador, "E") = "-    OK.- "
        Else
            Let cMensaje = cMensaje & Trim(nContadorEfe) & ".- Folio : " & nContrato & "  ERROR. " & vbCrLf
            Let MiHoja.Cells(nContador, "E") = "- ERROR.-"
        End If
    Next nContador
    
    Call MiHoja.SaveAs(MiLibro.Path & "\" & "Ok-" & MiLibro.Name)
    
    GoTo CloseData
    
Exit Function
ErrorOper:

    If Err.Number = 32755 Then
       Exit Function
    Else
       Call MsgBox(Err.Description, vbExclamation, App.Title)
    End If
   
    GoTo CloseData:

Exit Function
CloseData:

    Call MiLibro.Close

    Set MiHoja = Nothing
    Set MiLibro = Nothing
    Set MiExcell = Nothing

    Call Kill(Comando.FileName)

    Call MsgBox("Proceso de Ajuste ha finalizado" & vbCrLf & vbCrLf & cMensaje, vbInformation, App.Title)

End Function


Private Function FuncDelAjuste() As Boolean
    On Error GoTo ErrorActualizacion
    Dim cString     As String
    Dim dFecha      As String

    Let dFecha = Format(TXTFechaProceso.Value, "yyyymmdd")

    Call Bac_Sql_Execute("BEGIN TRANSACTION")

    Let cString = ""
    Let cString = cString & " DELETE FROM dbo.Tbl_Tributarios_Ajustes "
    Let cString = cString & " WHERE  Fecha = '" & dFecha & "'"
    If Not Bac_Sql_Execute(cString) Then
        GoTo ErrorActualizacion
    End If

    Call Bac_Sql_Execute("COMMIT TRANSACTION")
    
   
    On Error GoTo 0
    
Exit Function
ErrorActualizacion:
    
    Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
    
End Function

Private Function FuncGenAjuste(ByVal nContrato As Long, ByVal nValorBAC As Double, ByVal nvalorRf As Double) As Boolean
    On Error GoTo ErrorActualizacion
    Dim cString     As String
    Dim dFecha      As String
    
    Let FuncGenAjuste = False
    
    Let dFecha = Format(TXTFechaProceso.Value, "yyyymmdd")

    Call Bac_Sql_Execute("BEGIN TRANSACTION")

    Let cString = ""
    Let cString = cString & " INSERT INTO dbo.Tbl_Tributarios_Ajustes "
    Let cString = cString & " SELECT Fecha    = '" & dFecha & "'"
    Let cString = cString & "      , Origen   = 'PCS'"
    Let cString = cString & "      , Contrato = " & nContrato
    Let cString = cString & "      , Monto    = " & nvalorRf
    If Not Bac_Sql_Execute(cString) Then
        GoTo ErrorActualizacion
    End If
    'MAP 20140121 Se debe actualizar solamente registros
    'de presentación de AVR
    Let cString = ""
    Let cString = cString & " UPDATE BacParamSuda.dbo.TBL_TRIBUTARIOS "
    Let cString = cString & "    SET nMontoAVRProceso = " & nvalorRf
    
    Let cString = cString & "  WHERE FechaAnalisis    = '" & dFecha & "'"
    Let cString = cString & "    AND FolioContrato    = " & nContrato & " "
    Let cString = cString & "    AND nMontoAVRProceso <> 0 " 'Registro de AVR, buscar algo mas elegante
    If Not Bac_Sql_Execute(cString) Then
        GoTo ErrorActualizacion
    End If

    Let cString = ""
    Let cString = cString & " UPDATE BacParamSuda.dbo.TBL_TRIBUTARIOS "
    Let cString = cString & "    SET nMontoResultado = (nMontoAVRNeto - nMontoAVRProceso) "
    Let cString = cString & "    ,   nSignoAvr       = case when (nMontoAVRNeto - nMontoAVRProceso) >= 0 then '+' else '-' end "
    '-- Faltaba mantener la consistencia con el resto de los campos
    Let cString = cString & "    ,   nMontoSaldoAvrTermino = nMontoCaja + nMontoPatrimonio + nMontoAVRNeto - nMontoAVRProceso + nMontoLiquidacion"
    Let cString = cString & "  WHERE FechaAnalisis    = '" & dFecha & "'"
    Let cString = cString & "    AND FolioContrato    = " & nContrato
    If Not Bac_Sql_Execute(cString) Then
        GoTo ErrorActualizacion
    End If

    Call Bac_Sql_Execute("COMMIT TRANSACTION")
    
    Let FuncGenAjuste = True
    
    On Error GoTo 0
    
Exit Function
ErrorActualizacion:
    
    Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
    
End Function

