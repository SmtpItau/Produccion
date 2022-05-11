VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Begin VB.Form FRM_MATRIZ_RIESGO 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Matriz de Riesgo Interno."
   ClientHeight    =   7035
   ClientLeft      =   9180
   ClientTop       =   3615
   ClientWidth     =   4680
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7035
   ScaleWidth      =   4680
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4680
      _ExtentX        =   8255
      _ExtentY        =   900
      ButtonWidth     =   1958
      ButtonHeight    =   741
      ToolTips        =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      HotImageList    =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Excel     "
            ImageIndex      =   1
            Style           =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   2
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "e"
                  Text            =   "Generar un Excel"
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "r"
                  Text            =   "Cargar un Excel"
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cerrar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog Command 
         Left            =   3120
         Top             =   0
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3585
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MATRIZ_RIESGO.frx":0000
               Key             =   "e"
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MATRIZ_RIESGO.frx":0EDA
               Key             =   "r"
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Filtro Matriz de Riesgo"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1590
      Left            =   30
      TabIndex        =   1
      Top             =   510
      Width           =   4620
      Begin VB.ComboBox CMBTipo 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1725
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   240
         Width           =   2730
      End
      Begin VB.ComboBox CMBParMonedas 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1725
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   915
         Width           =   2730
      End
      Begin VB.ComboBox CMBRiesgo 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1725
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   585
         Width           =   2730
      End
      Begin VB.Label Etiquetas 
         Caption         =   "BID / ASK"
         Height          =   255
         Index           =   3
         Left            =   860
         TabIndex        =   11
         Top             =   310
         Width           =   975
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Par de Monedas"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   465
         TabIndex        =   3
         Top             =   975
         Width           =   1155
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Riesgo"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   1125
         TabIndex        =   2
         Top             =   645
         Width           =   480
      End
   End
   Begin VB.Frame Frame2 
      Height          =   4680
      Left            =   0
      TabIndex        =   6
      Top             =   2160
      Width           =   4605
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   4515
         Left            =   0
         TabIndex        =   7
         Top             =   120
         Width           =   4545
         _ExtentX        =   8017
         _ExtentY        =   7964
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
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
      TabIndex        =   8
      Top             =   6735
      Width           =   4680
      _Version        =   65536
      _ExtentX        =   8255
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
   Begin VB.Label Etiquetas 
      AutoSize        =   -1  'True
      Caption         =   "Riesgo"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   2
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   480
   End
End
Attribute VB_Name = "FRM_MATRIZ_RIESGO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private MiExcell  As Object
Private MiLibro   As Object
Private MiHoja    As Object
Private MiSheet   As Object

'Private MiExcell  As New Excel.Application
'Private MiLibro   As New Excel.Workbook
'Private MiHoja    As New Excel.Worksheet
'Private MiSheet   As New Excel.Worksheet

Private Sub Setting_grid()
   Let Grid.Rows = 2:      Let Grid.Cols = 2
   Let Grid.FixedRows = 1: Let Grid.FixedCols = 0

   Let Grid.TextMatrix(0, 0) = "Plazo":         Let Grid.ColWidth(0) = 2000
   Let Grid.TextMatrix(0, 1) = "Ponderador":    Let Grid.ColWidth(1) = 2000
End Sub

Private Function Load_Riesgo()
   Dim DATOS()
   
   Envia = Array()
   AddParam Envia, CDbl(0)
   If Not Bac_Sql_Execute("SP_LCRRIEPARMDAPON", Envia) Then
      Call MsgBox("Error Lectura." & vbCrLf & "Se ha producido un error de lectura de Items de Riesgo.", vbExclamation, App.Title)
      Exit Function
   End If
   Call CMBRiesgo.Clear
   Do While Bac_SQL_Fetch(DATOS())
      Call CMBRiesgo.AddItem(DATOS(2))
       Let CMBRiesgo.ItemData(CMBRiesgo.NewIndex) = DATOS(1)
   Loop
End Function
Private Function Load_Tipos()
   Dim Datos()

   Envia = Array()
   AddParam Envia, CDbl(7)
   If Not Bac_Sql_Execute("SP_LCRRIEPARMDAPON", Envia) Then
      Call MsgBox("Error Lectura." & vbCrLf & "Se ha producido un error de lectura de Items de Riesgo.", vbExclamation, App.Title)
      Exit Function
   End If
   Call CMBTipo.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call CMBTipo.AddItem(Datos(1))
   Loop
End Function
Private Function Load_ParMonedas()
   Dim DATOS()
   
   Envia = Array()
   AddParam Envia, CDbl(1)
   If Not Bac_Sql_Execute("SP_LCRRIEPARMDAPON", Envia) Then
      Call MsgBox("Error Lectura." & vbCrLf & "Se ha producido un error de lectura de Items de Riesgo.", vbExclamation, App.Title)
      Exit Function
   End If
   Call CMBParMonedas.Clear
  'Call CMBParMonedas.AddItem("TODOS")
   Call CMBParMonedas.AddItem("MX")
   Do While Bac_SQL_Fetch(DATOS())
      Call CMBParMonedas.AddItem(DATOS(1))
   Loop
End Function

Private Function Load_Matriz()
   Dim iRiesgo    As Long
   Dim cParMon    As String
   Dim Tipo       As String
   Dim DATOS()
   
   If CMBRiesgo.ListIndex = -1 Or CMBParMonedas.ListIndex = -1 Then
      Exit Function
   End If
   
   Let iRiesgo = CMBRiesgo.ItemData(CMBRiesgo.ListIndex)
   Let cParMon = CMBParMonedas.Text
   Let Tipo = CMBTipo.Text
   
   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, CDbl(iRiesgo)
   AddParam Envia, cParMon
   AddParam Envia, 0
   AddParam Envia, 0
   AddParam Envia, ""
   AddParam Envia, Tipo
   If Not Bac_Sql_Execute("SP_LCRRIEPARMDAPON", Envia) Then
      Call MsgBox("Error Lectura." & vbCrLf & "Se ha producido un error de lectura de Items de Riesgo.", vbExclamation, App.Title)
      Exit Function
   End If
   Let Grid.Rows = 1
   Do While Bac_SQL_Fetch(DATOS())
      Let Grid.Rows = Grid.Rows + 1
      Let Grid.TextMatrix(Grid.Rows - 1, 0) = Format(CDbl(DATOS(1)), "#,##0.0000000000000000") '--> Format(DATOS(1), FDecimal)
      Let Grid.TextMatrix(Grid.Rows - 1, 1) = Format(CDbl(DATOS(2)), "#,##0.0000000000000000") '--> Format(DATOS(2), FDecimal)
   Loop
End Function

Private Sub CMBParMonedas_Click()
   Call Load_Matriz
End Sub

Private Sub CMBRiesgo_Click()
   Call Load_Matriz
End Sub


Private Sub CMBTipo_Click()
    Call Load_Matriz
End Sub

Private Sub Form_Load()
   Let Me.Top = 0:   Let Me.Left = 0
   Let Me.Icon = BacControlFinanciero.Icon
   
   Call Setting_grid
   Call Load_Riesgo
   Call Load_ParMonedas
   Call Load_Tipos
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call Unload(Me)
   End Select
End Sub

Private Sub Toolbar1_ButtonMenuClick(ByVal ButtonMenu As MSComctlLib.ButtonMenu)
   Select Case ButtonMenu.Index
      Case 1
         Call Write_Excel
      Case 2
         Call Read_Excel
   End Select
End Sub

Private Function Write_Excel()
   On Error GoTo ErrorAction
   Dim nContador  As Long
   Dim cFile      As String
   Dim nFilas     As Long
   Dim MiFila     As Long
   Dim MiSheet    As Object
   Dim Respalda   As Boolean
   Dim DATOS()

   Let Respalda = False
   
   Let Screen.MousePointer = vbHourglass
   Let cFile = App.Path & "\Ponderadores.xls"
   Let cFile = "Ponderadores.xls"

   Let ProgressPanel.FloodType = 1
   Let ProgressPanel.FloodPercent = 0
   Let Command.CancelError = True

   Set MiExcell = CreateObject("Excel.Application")
   Set MiLibro = MiExcell.Application.Workbooks.Add
   Set MiHoja = MiLibro.Sheets.Add
   Set MiSheet = MiExcell.Worksheets(1) '--> MiExcell.ActiveSheet
   Let MiSheet.Name = "PONDERADORES"

   Let MiExcell.DisplayAlerts = False
   Call MiExcell.Worksheets(3).Delete
   Call MiExcell.Worksheets(2).Delete
   Let MiExcell.DisplayAlerts = True

   Let ProgressPanel.Visible = True
   Let Screen.MousePointer = vbHourglass

   Envia = Array()
   AddParam Envia, CDbl(5)
   If Not Bac_Sql_Execute("SP_LCRRIEPARMDAPON", Envia) Then
      Call MsgBox("Error Lectura" & vbCrLf & vbCrLf & "Se ha originado un error en la carga de la información.", vbExclamation, App.Title)
      Exit Function
   End If
   
   '--> PRD 20426
   Let MiFila = 1
   Let MiHoja.Cells(MiFila, 1) = "Tipo BID_ASK": MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
   Let MiHoja.Cells(MiFila, 2) = "Riesgo":     MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
   Let MiHoja.Cells(MiFila, 3) = "Par_Mda":    MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
   Let MiHoja.Cells(MiFila, 4) = "Plazo":      MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
   Let MiHoja.Cells(MiFila, 5) = "Ponderador": MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8
   
   Do While Bac_SQL_Fetch(DATOS())
      Let MiFila = MiFila + 1
      Let MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8: MiHoja.Cells(MiFila, 1) = DATOS(1)
      Let MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8: MiHoja.Cells(MiFila, 2) = DATOS(2)
      Let MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8: MiHoja.Cells(MiFila, 3) = Datos(3)
      Let MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8: MiHoja.Cells(MiFila, 4) = CDbl(DATOS(4))
      Let MiHoja.Cells(MiFila, 1).Font.Name = "Tahoma": MiHoja.Cells(MiFila, 1).Font.Size = 8: MiHoja.Cells(MiFila, 5) = CDbl(Datos(5))
      
      Let ProgressPanel.FloodPercent = ((MiFila - 1) * 100 / CDbl(Datos(6)))
   Loop
   
   Call MiHoja.Range("A1", "A65536").Select
   Call MiHoja.Cells.EntireColumn.AutoFit
    Let MiHoja.Cells.Font.Name = "Tahoma"
    Let MiHoja.Cells.Font.Size = 8
   
   Call MiHoja.Range("B1", "B65536").Select
   Call MiHoja.Cells.EntireColumn.AutoFit
    Let MiHoja.Cells.Font.Name = "Tahoma"
    Let MiHoja.Cells.Font.Size = 8
   
   Call MiHoja.Range("C1", "C65536").Select
   Call MiHoja.Cells.EntireColumn.AutoFit
    Let MiHoja.Cells.Font.Name = "Tahoma"
    Let MiHoja.Cells.Font.Size = 8
    Let MiExcell.Selection.NumberFormat = "#,##0.0000000000000000"
   
   Call MiHoja.Range("D1", "D65536").Select
   Call MiHoja.Cells.EntireColumn.AutoFit
    Let MiHoja.Cells.Font.Name = "Tahoma"
    Let MiHoja.Cells.Font.Size = 8
    Let MiExcell.Selection.NumberFormat = "#,##0.0000000000000000"
   
   Call MiHoja.Range("E1", "D65536").Select
   Call MiHoja.Cells.EntireColumn.AutoFit
    Let MiHoja.Cells.Font.Name = "Tahoma"
    Let MiHoja.Cells.Font.Size = 8
    Let MiExcell.Selection.NumberFormat = "#,##0.0000000000000000"
   
   Call BacControlWindows(10)
   Let Screen.MousePointer = vbDefault
   
   On Error GoTo ErrorAction
   Let Command.CancelError = True
   Let Command.FileName = cFile
   Call Command.ShowSave
   
   If Dir(Command.FileName) <> "" Then
      Call Kill(Command.FileName)
   End If
   
   Let Screen.MousePointer = vbHourglass
   
   Call MiHoja.SaveAs(Command.FileName)
   Call MiHoja.Application.Workbooks.Close
   Call MiExcell.Application.Workbooks.Close

   If Respalda = False Then
      Call MsgBox("Proceso Finalizado" & vbCrLf & vbCrLf & "Archivo ha sido almacenado en la ruta : " & vbCrLf & Command.FileName, vbInformation, App.Title)
   End If
   
   Set MiSheet = Nothing
   Set MiHoja = Nothing
   Set MiLibro = Nothing
   Set MiExcell = Nothing
   
  'Call MiLibro.Close
   
   Let ProgressPanel.FloodPercent = 0
   Let Screen.MousePointer = vbDefault
   On Error GoTo 0

Exit Function
ErrorAction:
   Let Screen.MousePointer = vbDefault
   Let ProgressPanel.FloodPercent = 0
   
   If Err.Number = 32755 Then
      Set MiSheet = Nothing
      Set MiHoja = Nothing
     'Call MiLibro.Close
      Set MiLibro = Nothing
      Set MiExcell = Nothing
   Else
      If Err.Number = 70 Then
         If MsgBox("Error de Escritura..." & vbCrLf & "Archivo se encuentra protegido contra escritura o bien esta en uso ... Reintentar ?", vbQuestion + vbYesNo, App.Title) = vbYes Then
            Resume
         Else
            Let Respalda = True
            Let Command.FileName = "C:\Archivos de programa\MiExcel.Xls"
            Resume
         End If
      End If
      
      If Err.Number <> 0 Then
         Call MsgBox("Error en la carga de archivo" & vbCrLf & vbCrLf & Err.Description, vbExclamation, App.Title)
         Let Screen.MousePointer = vbDefault
      End If
   End If

End Function

Private Function Read_Excel()
   On Error GoTo ErrorAction
   Dim nArchivo   As String
   Dim nContador  As Long
   Dim nFilas     As Long
   Dim xTipo      As String '-->PRD 20426
   Dim xRiesgo    As String
   Dim xItem      As String
   Dim oValor     As Double
   Dim DATOS()
   
   '--> Variables de Barra de Progreso y Cursor
   Let Screen.MousePointer = vbHourglass
   Let ProgressPanel.FloodType = 1
   Let ProgressPanel.FloodPercent = 0
   Let ProgressPanel.Visible = True
   '--> Variables de Barra de Progreso y Cursor

   
   '--> Inicializa la Pantalla Open File de Windows
   Let Command.CancelError = True
   Let Command.Filter = ".XLS"
   Let Command.FileName = ""
   Call Command.ShowOpen
ShowOpenAgain:
   If Command.FileName = "" Then
      If MsgBox("Advertencia." & vbCrLf & vbCrLf & "No se ha seleccionado ninguna planilla. " & vbCrLf & vbCrLf & ".... Reintentar ?", vbExclamation + vbRetryCancel, TITSISTEMA) = vbRetry Then
         GoTo ShowOpenAgain
      Else
         GoTo ErrorAction
      End If
   End If
   '--> Inicializa la Pantalla Open File de Windows


   '--> Levanta las Variables de entorno de Excel
   Set MiExcell = CreateObject("Excel.Application")
   Set MiLibro = MiExcell.Workbooks.Open(Command.FileName)
   Set MiHoja = Nothing
   Set MiHoja = MiExcell.ActiveSheet
   '--> Levanta las Variables de entorno de Excel


   '--> Valida Hojas
   Do While 1 = 1
      If MiHoja.Cells(1, "A") = "" Then
         Set MiHoja = MiLibro.Worksheets(1)
      Else
         Exit Do
      End If
   Loop
   '--> Valida Hojas


   '--> Determina el Largo Aprox de la Hoja Seleccionada
   Let nFilas = MiHoja.Columns.End(xlDown).Row
   '--> Determina el Largo Aprox de la Hoja Seleccionada


   '--> Inicia la Transaccion
   If Not BacBeginTransaction Then
      Let Screen.MousePointer = vbDefault
      Exit Function
   End If
   '--> Inicia la Transaccion


   '--> Inicia Proceso de Carga Eliminando el Contenido de la Tabla, Dado que no tiene fecha.
   Envia = Array()
   AddParam Envia, CDbl(4)
   If Not Bac_Sql_Execute("SP_LCRRIEPARMDAPON", Envia) Then
      Call BacRollBackTransaction
      Let Screen.MousePointer = vbDefault
      Exit Function
   End If
   '--> Inicia Proceso de Carga Eliminando el Contenido de la Tabla, Dado que no tiene fecha.


   '--> Comienza a Recorrer cada una de las filas del Excel
   For nContador = 2 To nFilas

      '--> Excluira las celdas vacias
      If Len(MiHoja.Cells(nContador, "B")) > 0 Then
         
         '--> PRD 20426
         '--> Validacion de Plazos Inversos (Revez)
         If xRiesgo = MiHoja.Cells(nContador, "B") Then              '--> Identifica el Rirsgo seleccionado
            If xItem = MiHoja.Cells(nContador, "C") Then             '--> Identifica el par de Monedas
               If oValor > CDbl(MiHoja.Cells(nContador, "D")) Then   '--> Identifica el Valor de Plazo v/s Plazo Anterior
                  If xTipo = MiHoja.Cells(nContador, "A") Then
                  GoTo Aborta
                  Exit Function
               End If
            End If
         End If
         End If
         '--> Validacion de Plazos Inversos (Revez)
         
         
         '--> Se inicia la Carga de los Poderadores leidos desde el Excel
         Envia = Array()
         AddParam Envia, CDbl(3)                                     '--> Identifica que esta grabando previa validación
         AddParam Envia, CDbl(0)                                     '--> Inicializa Variable de Codigo de riesgo, dado que la planilla lo proporciona como texto
         AddParam Envia, MiHoja.Cells(nContador, "C")                '--> identifica el par de moneda
         AddParam Envia, CDbl(MiHoja.Cells(nContador, "D"))          '--> Identifica el Plazo
         AddParam Envia, CDbl(MiHoja.Cells(nContador, "E"))          '--> Identifica el Ponderador
         AddParam Envia, MiHoja.Cells(nContador, "B")                '--> Identifica el riesgo como texto
         AddParam Envia, MiHoja.Cells(nContador, "A")                '--> Identifica si es BID o ASK
         If Not Bac_Sql_Execute("SP_LCRRIEPARMDAPON", Envia) Then
            GoTo FallaProcesoGrabacion
            Exit Function
         End If

         '--> Lee Resultados de las validaciones, que pueden probocar abortar el proceso
         If Bac_SQL_Fetch(DATOS()) Then
            If DATOS(1) < 0 Then
               GoTo CancelaPorValidacion
               Exit Function
            End If
         End If
         '--> Lee Resultados de las validaciones, que pueden probocar abortar el proceso

         '--> PRD 20426
         '--> Asigna valores para validacion de Ingreso erroneo de Plazos (Inversos)
         Let xTipo = MiHoja.Cells(nContador, "A")
         Let xRiesgo = MiHoja.Cells(nContador, "B")
         Let xItem = MiHoja.Cells(nContador, "C")
         Let oValor = CDbl(MiHoja.Cells(nContador, "D"))
         '--> Asigna valores para validacion de Ingreso erroneo de Plazos (Inversos)
         
         '--> Mueve la barra de progreso
         Let ProgressPanel.FloodPercent = (nContador * 100 / nFilas)
         Call BacControlWindows(1)
         '--> Mueve la barra de progreso
      
      End If
      '--> Excluira las celdas vacias

   Next nContador
   '--> Comienza a Recorrer cada una de las filas del Excel
   

   '--> Confirma la transaccion
   Call BacCommitTransaction
   '--> Confirma la transaccion


   '--> Cierra las variables de entorno de Windows para Excel
   Set MiSheet = Nothing
   Set MiHoja = Nothing
   Call MiLibro.Close
   Set MiLibro = Nothing
   Set MiExcell = Nothing
   '--> Cierra las variables de entorno de Windows para Excel

   '--> PRD 20426
   '--> hay que cerrar la conexión
   '--> Proceso de Validacion de Ponderadores MX
   '-->    Debido al mecanismo, la unica posibilidad de detectar esta validación es post-Carga
   Envia = Array()
   AddParam Envia, CDbl(6)
   Call Bac_Sql_Execute("SP_LCRRIEPARMDAPON", Envia)
   If Bac_SQL_Fetch(DATOS()) Then
      If DATOS(1) < 0 Then
         Let Screen.MousePointer = vbDefault
         Let ProgressPanel.FloodPercent = 0
         Let ProgressPanel.Visible = True

         Call GRABA_LOG_AUDITORIA(1, Trim(gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10017", "00", Trim(Datos(2)), "", "", "")
         Call MsgBox("Validación Ponderador MX" & vbCrLf & DATOS(2), vbExclamation, App.Title)
      End If
   End If
   '--> Proceso de Validacion de Ponderadores MX

   '--> Ejecuta mensaje de Información por que el proceso se ejecuto correctamente
   Let Screen.MousePointer = vbDefault                                                  '--> Cambia Cursor
   Call MsgBox("Planilla ha sido cargada en forma exitosa", vbInformation, App.Title)   '--> Mensaje
   Let ProgressPanel.FloodPercent = 0                                                   '--> Setea Barra de Progreso
   '--> Ejecuta mensaje de Información por que el proceso se ejecuto correctamente

    '--> recarga la matriz para mostrar los datos nuevos
    Load_Matriz '--> PRD 20426
    
   On Error GoTo 0

Exit Function
ErrorAction:
   Let Screen.MousePointer = vbDefault
   If Err.Number = 32755 Then
   Else
      If Err.Number <> 0 Then
         Call MsgBox("Error en la carga de archivo" & vbCrLf & vbCrLf & Err.Description, vbExclamation, App.Title)
      End If
   End If
   Exit Function
Aborta:
   Call BacRollBackTransaction

   Let Screen.MousePointer = vbDefault
   Let ProgressPanel.FloodPercent = 0

   Set MiSheet = Nothing
   Set MiHoja = Nothing
   Call MiLibro.Close
   Set MiLibro = Nothing
   Set MiExcell = Nothing

   Call GRABA_LOG_AUDITORIA(1, Trim(gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10017", "00", "Se han detectado plazos inversos.", "", "", "")

   Call MsgBox("Validación de Plazos Inversos" & vbCrLf & vbCrLf & "Se han detectado uno o más plazos inversos para el riesgo de " & xRiesgo & ", par de monedas " & xItem & ". El primero ocurrió en las líneas " & nContador - 1 & " y " & nContador & " del archivo.", vbExclamation, App.Title)

   Call BacControlWindows(10)
   Exit Function

FallaProcesoGrabacion:
   Call BacRollBackTransaction

   Let Screen.MousePointer = vbDefault
   Let ProgressPanel.FloodPercent = 0

   Set MiSheet = Nothing
   Set MiHoja = Nothing
   Call MiLibro.Close
   Set MiLibro = Nothing
   Set MiExcell = Nothing

   Call GRABA_LOG_AUDITORIA(1, Trim(gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10017", "00", "Se ha originado un error en la actualizacion de Ponderadores", "", "", "")

   Call MsgBox("Error Escritura" & vbCrLf & vbCrLf & "Se ha originado un error en la actualizacion de ponderadores", vbExclamation, App.Title)

   Call BacControlWindows(10)
   Exit Function

CancelaPorValidacion:
   Call BacRollBackTransaction

   Let Screen.MousePointer = vbDefault
   Let ProgressPanel.FloodPercent = 0

   Set MiSheet = Nothing
   Set MiHoja = Nothing
   Call MiLibro.Close
   Set MiLibro = Nothing
   Set MiExcell = Nothing

   Call GRABA_LOG_AUDITORIA(1, Trim(gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10017", "00", Trim(Datos(2)), "", "", "")

   Call MsgBox("Validación de Carga de Archivo" & vbCrLf & vbCrLf & DATOS(2) & vbCrLf & DATOS(3), vbExclamation, App.Title)

   Call BacControlWindows(10)
   Exit Function
End Function

