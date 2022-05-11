VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FrmAuditoria 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Log Auditoria"
   ClientHeight    =   4890
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   9060
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4890
   ScaleWidth      =   9060
   Begin VB.Frame Frame1 
      Caption         =   "Opciones de Consulta"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   3990
      Left            =   0
      TabIndex        =   7
      Top             =   720
      Width           =   9000
      Begin VB.Frame Frame4 
         Caption         =   "Eventos"
         Height          =   2295
         Left            =   120
         TabIndex        =   15
         Top             =   1605
         Width           =   8790
         Begin MSComctlLib.ListView ListEvento 
            Height          =   1710
            Left            =   1620
            TabIndex        =   5
            Top             =   510
            Width           =   4875
            _ExtentX        =   8599
            _ExtentY        =   3016
            View            =   2
            LabelWrap       =   -1  'True
            HideSelection   =   -1  'True
            FullRowSelect   =   -1  'True
            GridLines       =   -1  'True
            _Version        =   393217
            ForeColor       =   -2147483640
            BackColor       =   -2147483643
            BorderStyle     =   1
            Appearance      =   1
            NumItems        =   1
            BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
               Text            =   "Eventos"
               Object.Width           =   4410
            EndProperty
         End
         Begin VB.CheckBox ChkTodos 
            Caption         =   "Todos"
            Height          =   255
            Left            =   1095
            TabIndex        =   6
            Top             =   240
            Width           =   855
         End
         Begin MSComDlg.CommonDialog Commando 
            Left            =   360
            Top             =   1080
            _ExtentX        =   847
            _ExtentY        =   847
            _Version        =   393216
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Rango Fechas"
         ForeColor       =   &H00800000&
         Height          =   1380
         Left            =   5880
         TabIndex        =   8
         Top             =   225
         Width           =   3015
         Begin BACControles.TXTFecha cmbFechaTermino 
            Height          =   300
            Left            =   1080
            TabIndex        =   4
            Top             =   765
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   529
            Enabled         =   -1  'True
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
            ForeColor       =   8388608
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/06/2001"
         End
         Begin BACControles.TXTFecha cmbFechaInicio 
            Height          =   300
            Left            =   1080
            TabIndex        =   3
            Top             =   360
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   529
            Enabled         =   -1  'True
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
            ForeColor       =   8388608
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/06/2001"
         End
         Begin VB.Label Label4 
            Caption         =   "Desde"
            ForeColor       =   &H00C00000&
            Height          =   255
            Left            =   480
            TabIndex        =   14
            Top             =   405
            Width           =   540
         End
         Begin VB.Label Label6 
            Caption         =   "Hasta"
            ForeColor       =   &H00C00000&
            Height          =   255
            Left            =   480
            TabIndex        =   9
            Top             =   720
            Width           =   480
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Flitros"
         ForeColor       =   &H00800000&
         Height          =   1365
         Left            =   105
         TabIndex        =   10
         Top             =   225
         Width           =   5535
         Begin VB.ComboBox CmbUsuario 
            Height          =   315
            Left            =   1005
            Style           =   2  'Dropdown List
            TabIndex        =   0
            Top             =   240
            Width           =   2295
         End
         Begin VB.ComboBox CmbModulo 
            Height          =   315
            Left            =   1005
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   600
            Width           =   2295
         End
         Begin VB.ComboBox CmbMenu 
            Height          =   315
            Left            =   1005
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   945
            Width           =   4395
         End
         Begin VB.Label Label3 
            Caption         =   "Menu"
            Height          =   180
            Left            =   255
            TabIndex        =   13
            Top             =   1005
            Width           =   615
         End
         Begin VB.Label Label2 
            Caption         =   "Sistema"
            Height          =   180
            Left            =   240
            TabIndex        =   12
            Top             =   660
            Width           =   720
         End
         Begin VB.Label Label1 
            Caption         =   "Usuario"
            Height          =   195
            Left            =   240
            TabIndex        =   11
            Top             =   285
            Width           =   735
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8385
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
            Picture         =   "FrmAuditoria.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmAuditoria.frx":031A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmAuditoria.frx":11DC
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmAuditoria.frx":14F6
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmAuditoria.frx":1810
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   16
      Top             =   0
      Width           =   9060
      _ExtentX        =   15981
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
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Excel"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "FrmAuditoria"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim EventoFinal As String
Dim Ordenado, FechaInim, FechaTer As String
Dim SQL_Final As String
Dim Valor(6) As String
Dim ValorRPT(6) As String
Dim sis As String


Const nBtnLimpiar = 1
Const nBtnImprimir = 3
Const nBtnSalir = 4

Const nColNombreUsu = "A"
Const nColBloqueado = "B"
Const nColFechaProc = "C"
Const nColHoraProc = "D"
Const nColSistema = "E"
Const nColMenu = "F"
Const nColEvento = "G"
Const nColNumOper = "H"
Const nColIp = "I"

Function ValidaCriterios() As Boolean
   Dim nContador As Integer
   Dim ListaMarcada As Boolean

   ValidaCriterios = True

   
   If CmbUsuario.ListIndex = -1 Then
      MsgBox "Debe Seleccionar uno o todos los usuarios", vbExclamation
      ValidaCriterios = False
      Exit Function
   End If
   If CmbModulo.ListIndex = -1 Then
      MsgBox "Debe Seleccionar uno o todos los sistemas", vbExclamation
      ValidaCriterios = False
      Exit Function
   End If
   If CmbMenu.ListCount > 0 And CmbMenu.ListIndex = -1 Then
      MsgBox "Debe Seleccionar un menu", vbExclamation
      ValidaCriterios = False
      Exit Function
   Else
         If CmbMenu.ListCount = 0 Then
         MsgBox "El Sistema seleccionado NO tiene Menus con LOG, favor elija otro Sistema", vbExclamation
           ValidaCriterios = False
            Exit Function
         End If
   End If

   If ListEvento.ListItems.Count = -1 Then
      MsgBox "Debe Seleccionar un Evento", vbExclamation
      ValidaCriterios = False
      Exit Function
      
   End If
   
   nContador = 1
   ListaMarcada = False
   If ListEvento.ListItems.Count > 0 Then
    Do While nContador <= ListEvento.ListItems.Count
 
        If ListEvento.ListItems.Item(nContador).Checked = True Then
            ValidaCriterios = True
            Exit Function
         Else
            ValidaCriterios = False
            nContador = nContador + nContador
        End If
    Loop
         If ValidaCriterios = False Then
            MsgBox "Debe Seleccionar un Evento", vbExclamation
         End If
   End If
End Function

Private Sub Proc_Imprimir()
'On Error GoTo Control:
   
    Dim sCadena As String
    Dim nContador   As Integer
   
If ValidaCriterios Then
On Error GoTo Control:
    sCadena = ""
   
    With ListEvento
    
        For nContador = 1 To .ListItems.Count
            If .ListItems.Item(nContador).Checked = True Then
                If Len(Trim(sCadena)) = 0 Then
                    sCadena = .ListItems.Item(nContador).ListSubItems(1).Text
                Else
                    sCadena = sCadena + "," + .ListItems.Item(nContador).ListSubItems(1).Text
                End If
            End If
        Next nContador
    End With
   

   FechaDesde = Format(cmbFechaInicio.Text, "yyyymmdd")
   FechaHasta = Format(cmbFechaTermino.Text, "yyyymmdd")
    
   Screen.MousePointer = vbHourglass
   
   Call limpiar_cristal
   
   BACSwapParametros.BACParam.Destination = crptToWindow
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacLogAuditoria2.RPT"
   BACSwapParametros.BACParam.StoredProcParam(0) = Trim(CmbUsuario.Text)                'Usuario
   BACSwapParametros.BACParam.StoredProcParam(1) = IIf(CmbModulo.ListIndex > 0, Trim(Right(CmbModulo.Text, 5)), Trim(CmbModulo.Text))
   
   BACSwapParametros.BACParam.StoredProcParam(2) = Trim(sCadena)                        'EventoFinal
   BACSwapParametros.BACParam.StoredProcParam(3) = Trim(Right(CmbMenu.Text, 50))        'menu
   
   BACSwapParametros.BACParam.StoredProcParam(4) = FechaDesde                           'FechaDesde
   BACSwapParametros.BACParam.StoredProcParam(5) = FechaHasta                           'FechaHasta
   
   BACSwapParametros.BACParam.WindowTitle = "INFORME DE LOG'S"
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.Action = 1
   
   Screen.MousePointer = vbDefault
   Exit Sub
   
Control:
   MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
   Screen.MousePointer = vbDefault
End If
End Sub

Private Sub chkTodo_Click(Value As Integer)

    If chkTodo.Value = True And Value = -1 Then
        Call Proc_SelectAll(True)
    ElseIf chkTodo.Value = False And Value = 0 Then
        Call Proc_SelectAll(False)
    End If

End Sub

Private Sub ChkTodos_Click()
    If ChkTodos.Value = 1 Then
        Call Proc_SelectAll(True)
    Else
        Call Proc_SelectAll(False)
    End If
End Sub

Private Sub Proc_SelectAll(Opt As Boolean)
   Dim nContador As Integer
   
   For nContador = 1 To ListEvento.ListItems.Count
      ListEvento.ListItems(nContador).Checked = Opt
   Next nContador
   
End Sub


Private Sub CmbMenu_Click()
ChkTodos.Value = 0
   If CmbUsuario.ListIndex = -1 Or CmbModulo.ListIndex = -1 Or CmbMenu.ListIndex = -1 Then
      Exit Sub
   End If

   
   Envia = Array()
   AddParam Envia, IIf(CmbModulo.ListIndex > 0, Trim(Right(CmbModulo.Text, 3)), Trim(CmbModulo.Text))
   AddParam Envia, Trim(Right(CmbMenu.Text, 30))
   AddParam Envia, IIf(CmbUsuario.ListIndex > 0, Trim(Right(CmbUsuario.Text, 10)), Trim(CmbUsuario.Text))
    
         
    Screen.MousePointer = VBGLASS
         
    If Not Bac_Sql_Execute("SP_BUSCA_EVENTO_MENU ", Envia) Then
        Exit Sub
    Else
        ''''ListEventos.Clear
        ListEvento.ListItems.Clear
        
        Do While Bac_SQL_Fetch(Datos())
            ListEvento.ListItems.Add , , Trim(Datos(2))
            ListEvento.ListItems.Item(ListEvento.ListItems.Count).ListSubItems.Add , , Datos(1)
        Loop
    End If
    
    Screen.MousePointer = vbDefault



End Sub






Private Sub Command1_Click()
    Call GeneraExcell

End Sub
Private Sub GeneraExcell()
On Error GoTo ErrorGeneracion
    
    Dim sCadena As String
    Dim nContador   As Integer
    Dim iContador        As Long
    Dim Archivo          As String
    Dim Estado           As String
    Dim Datos()
   
   Dim MiExcell         As New Excel.Application
   Dim MiLibro          As New Excel.Workbook
   Dim MiHoja           As New Excel.Worksheet
''''   Dim MiSheet          As Object
       
If ValidaCriterios Then
On Error GoTo ErrorGeneracion
    Commando.DialogTitle = "Genera Archivo Excel"
    Commando.InitDir = "C:\"
    Commando.FileName = ""
    Commando.Flags = cdlOFNLongNames
    Commando.DefaultExt = "xlsx"
    Commando.Filter = "Libro Excel 2007|*.xlsx |Libro Excel 97-2003|*.xls|"
    Commando.CancelError = True
    Commando.ShowSave
  
   If Dir(Commando.FileName) <> "" Then
      Call Kill(Commando.FileName)
   End If
   
    Screen.MousePointer = vbHourglass
   
    Set MiExcell = CreateObject("Excel.Application")
    Set MiLibro = MiExcell.Application.Workbooks.Add
    Set MiHoja = MiExcell.ActiveSheet ''''MiLibro.Sheets.Add
''''   Set MiSheet = MiExcell.ActiveSheet
   
    MiLibro.Worksheets(1).Name = "Informe Auditoria"
    MiLibro.Worksheets(2).Delete
   'MiLibro.Worksheets(3).Delete
    
   '/*****BUSCA EVENTO*****/
    sCadena = ""
   
    With ListEvento
    
        For nContador = 1 To .ListItems.Count
            If .ListItems.Item(nContador).Checked = True Then
                If Len(Trim(sCadena)) = 0 Then
                    sCadena = .ListItems.Item(nContador).ListSubItems(1).Text
                Else
                    sCadena = sCadena + "," + .ListItems.Item(nContador).ListSubItems(1).Text
                End If
            End If
        Next nContador
    End With
    
    iContador = 1
    
    MiHoja.Cells(iContador, nColNombreUsu) = "Nombre Usuario"
    MiHoja.Cells(iContador, nColBloqueado) = "Bloqueado"
    MiHoja.Cells(iContador, nColFechaProc) = "Fecha Proc."                               '--> TipoOperacion
    MiHoja.Cells(iContador, nColHoraProc) = "Hora Proc."
    MiHoja.Cells(iContador, nColSistema) = "Sistema"
    MiHoja.Cells(iContador, nColMenu) = "Opc. Menu"
    MiHoja.Cells(iContador, nColEvento) = "Evento"
    MiHoja.Cells(iContador, nColNumOper) = "Num Oper."
    MiHoja.Cells(iContador, nColIp) = "Ip"
    
    Envia = Array()
   
    AddParam Envia, Trim(CmbUsuario.Text)                'Usuario
    'AddParam Envia, Trim(Right(CmbModulo.Text, 5))       'sistema
    AddParam Envia, IIf(CmbModulo.ListIndex > 0, Trim(Right(CmbModulo.Text, 5)), Trim(CmbModulo.Text))
    AddParam Envia, Trim(sCadena) ''''EventoFinal        'Envento
    AddParam Envia, Trim(Right(CmbMenu.Text, 50))        'menu
    AddParam Envia, Format(cmbFechaInicio.Text, "yyyymmdd")
    AddParam Envia, Format(cmbFechaTermino.Text, "yyyymmdd")
   
    If Not Bac_Sql_Execute("dbo.SP_LOG_AUDITORIA_CONSULTA", Envia) Then
       Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        iContador = iContador + 1
        MiHoja.Cells(iContador, nColNombreUsu) = Datos(1)                                '--> Usuario
        MiHoja.Cells(iContador, nColBloqueado) = Datos(2)                                '--> Sistema
        MiHoja.Cells(iContador, nColFechaProc) = Datos(3)                                '--> TipoOperacion
        MiHoja.Cells(iContador, nColHoraProc) = Datos(4)                                            '--> RutCliente
        MiHoja.Cells(iContador, nColSistema) = Datos(5)                                                   '--> Moneda Mx
        MiHoja.Cells(iContador, nColMenu) = Datos(6)                                '--> Monto Moneda Mx
        MiHoja.Cells(iContador, nColEvento) = Datos(8)
        MiHoja.Cells(iContador, nColNumOper) = Datos(9)
        MiHoja.Cells(iContador, nColIp) = Datos(10)
    Loop
   
    MiHoja.Range("A1").Select
    MiHoja.Range(MiExcell.Selection, MiExcell.Selection.End(xlToRight)).Select
       
    MiExcell.Selection.Interior.ColorIndex = 1
    MiExcell.Selection.Interior.Pattern = xlSolid
    MiExcell.Selection.Font.ColorIndex = 2
   
    MiHoja.Range(MiExcell.Selection, MiExcell.Selection.End(xlDown)).Select
    MiExcell.Selection.Borders(xlDiagonalDown).LineStyle = xlNone
    MiExcell.Selection.Borders(xlDiagonalUp).LineStyle = xlNone
   
   
   
   With MiExcell.Selection.Borders(xlEdgeLeft)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With MiExcell.Selection.Borders(xlEdgeTop)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With MiExcell.Selection.Borders(xlEdgeBottom)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With MiExcell.Selection.Borders(xlEdgeRight)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With MiExcell.Selection.Borders(xlInsideVertical)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   With MiExcell.Selection.Borders(xlInsideHorizontal)
       .LineStyle = xlContinuous
       .ColorIndex = 0
       .Weight = xlThin
   End With
   
    MiHoja.Cells.Select
    MiHoja.Cells.EntireColumn.AutoFit
    MiHoja.Cells(1, 1).Select
  
    MiHoja.SaveAs (Commando.FileName)
    MiHoja.Application.Workbooks.Close
    MiExcell.Application.Workbooks.Close
   
    Set MiExcell = Nothing
    Set MiLibro = Nothing
    Set MiHoja = Nothing
   
    Screen.MousePointer = vbDefault

Exit Sub

ErrorGeneracion:
    Screen.MousePointer = vbDefault
    
    If Err.Number = 32755 Then
        Exit Sub
    Else
        MsgBox "Error en generación de planilla" & vbCrLf & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
    End If
End If
End Sub

Private Sub Selecciona_Eventos()
Dim menu        As String
Dim f           As Long
Dim Evento      As String


    EventoFinal = ""
    Evento = ""

    For f = 1 To ListEvento.ListItems.Count

      If ListEvento.ListItems.Item(f).Checked = True Then

         Evento = ListEvento.ListItems.Item(f).Text
         cCodigo = ListEvento.ListItems(f).ListSubItems(1).Text

         If EventoFinal <> "" Then
            EventoFinal = Trim(EventoFinal) + ",'" + Trim(cCodigo) + "'"
         Else
            EventoFinal = Trim(EventoFinal) + "" + Trim(cCodigo) + ""
        End If

      End If

   Next f
End Sub






Private Sub CmbUsuario_Click()
   CmbModulo.ListIndex = -1
   CmbMenu.ListIndex = -1
   ListEvento.ListItems.Clear
   ChkTodos.Value = 0
End Sub



Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    Call Limpiar_Controles
    
    cmbFechaInicio.Text = Format(Date, "dd/mm/yyyy")
    cmbFechaTermino.Text = Format(Date, "dd/mm/yyyy")
    'Define_Cabecera
    LLena_Combos
    
    Toolbar1.Buttons(nBtnImprimir).Enabled = True
End Sub

Sub LLena_Combos()

    If Not Bac_Sql_Execute("SP_FILTRO_LOG_AUDITORIA USUARIO,''") Then
        MsgBox "Problemas al Cargar Opciones para la Consulta.", vbInformation, TITSISTEMA
    Else
        CmbUsuario.AddItem "TODOS" & Space(80)
        Do While Bac_SQL_Fetch(Datos())
                CmbUsuario.AddItem Datos(1)
        Loop
        
    End If
    
    ListEvento.ListItems.Clear
   
    If Not Bac_Sql_Execute("SP_FILTRO_LOG_AUDITORIA MODULO,''") Then
        MsgBox "Problemas al Cargar Opciones para la Consulta.", vbInformation, TITSISTEMA
    Else
        CmbModulo.AddItem "TODOS" & Space(80)
        Do While Bac_SQL_Fetch(Datos())
                CmbModulo.AddItem Datos(2) & Space(50) & Datos(1)
        Loop
    End If
    
End Sub

Private Sub cmbModulo_Click()
      ListEvento.ListItems.Clear
      ChkTodos.Value = 0
    Screen.MousePointer = vbHourglass
    
    Envia = Array()
    AddParam Envia, Trim(CmbUsuario.Text)
    AddParam Envia, IIf(CmbModulo.ListIndex > 0, Trim(Right(CmbModulo.Text, 3)), Trim(CmbModulo.Text))
    
    
    If Not Bac_Sql_Execute("SP_BUSCA_MENU_CON_LOG ", Envia) Then
        Exit Sub
    Else
        CmbMenu.Clear
        Do While Bac_SQL_Fetch(Datos())
            CmbMenu.AddItem Datos(3) & Space(110) & Datos(2)
        Loop
    End If
        
    Screen.MousePointer = vbDefault


End Sub




Private Sub ListEvento_Click()
Dim nContador As Integer
Dim TodosSelec As Integer
nContador = 1
TodosSelec = 0

   If ListEvento.ListItems.Count > 0 Then
      Do While nContador <= ListEvento.ListItems.Count
         If ListEvento.ListItems.Item(nContador).Checked = True Then
            TodosSelec = TodosSelec + 1
      End If
        nContador = nContador + 1
      Loop
   End If
   If TodosSelec = ListEvento.ListItems.Count Then
            ChkTodos.Value = 1
   Else
            ChkTodos.Value = 0
            
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        
        Case 1
            Limpiar_Controles
            LLena_Combos
            
'            Toolbar1.Buttons(3).Enabled = False
            Ordenado = ""
            CmbUsuario.SetFocus
            
        Case 2
            Proc_Imprimir
                    
        Case 3
            Call GeneraExcell
             
        Case 4
          Unload Me
          
    
    End Select

End Sub

Sub Limpiar_Controles()
    CmbUsuario.Refresh
    CmbUsuario.Clear
    CmbModulo.Clear
    CmbMenu.Clear

    cmbFechaInicio.Text = Date
    cmbFechaTermino.Text = Date
    ListEvento.MultiSelect = True
    ListEvento.CheckBoxes = True
    ListEvento.FullRowSelect = False
    ListEvento.ColumnHeaders.Add , , "Eventos", 2500
    ListEvento.LabelEdit = lvwManual
    ListEvento.View = lvwList
End Sub

