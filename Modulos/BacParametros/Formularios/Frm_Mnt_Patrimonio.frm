VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form Frm_Mnt_Patrimonio 
   Caption         =   "Ctas de Patrimonio por Contrato"
   ClientHeight    =   4890
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   11175
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   4890
   ScaleWidth      =   11175
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11175
      _ExtentX        =   19711
      _ExtentY        =   794
      ButtonWidth     =   2117
      ButtonHeight    =   741
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
            Caption         =   "Actualizar"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Plantilla"
            Object.ToolTipText     =   "Generar Plantilla"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cargar"
            Object.ToolTipText     =   "Cargar Plantilla"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Caption         =   "Grabar"
            Object.ToolTipText     =   "Actualizar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cerrar"
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog Commond 
         Left            =   5040
         Top             =   30
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   8925
         Top             =   30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   6
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Patrimonio.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Patrimonio.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Patrimonio.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Patrimonio.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Patrimonio.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Mnt_Patrimonio.frx":3E82
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   4500
      Left            =   0
      TabIndex        =   1
      Top             =   375
      Width           =   8475
      Begin MSComCtl2.DTPicker TxtFecha 
         Height          =   300
         Left            =   735
         TabIndex        =   4
         Top             =   150
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   529
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
         Format          =   17301505
         CurrentDate     =   41163
      End
      Begin MSComctlLib.ListView Listado 
         Height          =   3945
         Left            =   60
         TabIndex        =   2
         Top             =   465
         Width           =   8340
         _ExtentX        =   14711
         _ExtentY        =   6959
         View            =   3
         LabelEdit       =   1
         LabelWrap       =   0   'False
         HideSelection   =   0   'False
         OLEDropMode     =   1
         AllowReorder    =   -1  'True
         FullRowSelect   =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         BorderStyle     =   1
         Appearance      =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         OLEDropMode     =   1
         NumItems        =   0
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Fecha"
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
         Left            =   165
         TabIndex        =   3
         Top             =   195
         Width           =   495
      End
   End
End
Attribute VB_Name = "Frm_Mnt_Patrimonio"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private MiExcell  As New Excel.Application
Private MiLibro   As New Excel.Workbook
Private MiHoja    As New Excel.Worksheet

Private Sub Form_Load()
   Let Me.Icon = BACSwapParametros.Icon
   Let TxtFecha.Value = MOD_FUNCIONES.FuncFechaCierreMes

   Call FuncSettingListado
   Call FuncLoadCargaPatrimonio
   
   Let Toolbar1.Buttons(3).Visible = False
   
End Sub

Private Function FuncSettingListado()
   Let Listado.Font.Name = "Tahoma": Let Listado.Font.Size = 8:  Let Listado.Font.Bold = False
   Call Listado.ColumnHeaders.Clear

   Call Listado.ColumnHeaders.Add(1, "A", "Fecha", 1500)
   Call Listado.ColumnHeaders.Add(2, "B", "Origen", 1500)
   Call Listado.ColumnHeaders.Add(3, "C", "Contrato", 1600)
   Call Listado.ColumnHeaders.Add(4, "d", "Cuenta", 2000)
   Call Listado.ColumnHeaders.Add(5, "E", "Ajuste", 2500)
End Function

Private Function FuncLoadCargaPatrimonio()
   Dim oSqlDatos()
   
  
   Envia = Array()
   Call AddParam(Envia, Format(TxtFecha.Value, "yyyymmdd"))
   If Bac_Sql_Execute("BacParamSuda.dbo.SP_MNT_PATRIMONIO_LEER_CUENTAS", Envia) = False Then
      Let cLogString = cLogString & "E-Error. En la Grabación  [Fecha: " & cFecha & ", Origen : " & cOrigen & "Contrato : " & Trim(nContrato) & "]"
   End If
   Call Listado.ListItems.Clear
   Do While Bac_SQL_Fetch(oSqlDatos)
      Call Listado.ListItems.Add(, , oSqlDatos(1))
      Call Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add(, , oSqlDatos(2))
      Call Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add(, , oSqlDatos(3))
      Call Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add(, , oSqlDatos(4))
      Call Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add(, , oSqlDatos(5))
       Let Listado.ListItems.Item(Listado.ListItems.Count).Key = Chr((64 + oSqlDatos(6)))
   Loop
End Function

Private Sub Form_Resize()
   On Error Resume Next
   Me.Frame1.Width = Me.Width - 130
   Me.Frame1.Height = Me.Height - 1000
   
   Me.Listado.Width = Me.Frame1.Width - 180
   Me.Listado.Height = Me.Frame1.Height - 550
   On Error GoTo 0
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call FuncLoadCargaPatrimonio
      Case 3
         Call FuncGeneraExcel
      Case 4
         Call FuncCargarExcel
      Case 6
         Call Unload(Me)
   End Select
End Sub


Private Function FuncCargarExcel()
   On Error GoTo ErrorOper
   
   Me.Listado.ListItems.Clear
   Me.Listado.Refresh
   
   Commond.DialogTitle = "Plantilla"
   Commond.InitDir = "C:\"
   Commond.Flags = cdlOFNLongNames
   Commond.DefaultExt = "xlsx"
   Commond.Filter = ".xlsx"
   Commond.CancelError = True
   Commond.FileName = "Plantilla_Coberturas.xlsx"

   Call Commond.ShowOpen

   Reset

   If Not Commond.FileName Like "*Coberturas*.*" Then
      GoTo ErrorOper
   End If


   Call AbrirExcel(MiExcell, False)
   
  'Set MiExcell = CreateObject("Excel.Application")
   Set MiLibro = MiExcell.Workbooks.Open(Commond.FileName)

   Set MiHoja = Nothing
   Set MiHoja = MiLibro.Worksheets(1)

   Dim iFilas               As Long
   Dim iContador            As Long
   Dim cFecha               As String
   Dim cOrigen              As String
   Dim nContrato            As Long
   Dim cCuenta              As String
   Dim nAjuste              As Double
   Dim cLogString           As String
   Dim nAjusteCorteCupon    As Double
   
   Let cLogString = ""
       Let iFilas = MiHoja.Columns.End(xlDown).Row

   '->    Validacion de Columnas Requeridas
    If Not UCase(MiHoja.Cells(1, "A")) Like "*FECHA*" Then
        Call MsgBox("En la columna A, debe indicar Fecha", vbExclamation, App.Title)
        GoTo CloseData
        Exit Function
    End If
    If Not UCase(MiHoja.Cells(1, "C")) Like "*CUENTA*" Then
        Call MsgBox("En la columna C, debe indicar Cuenta", vbExclamation, App.Title)
        GoTo CloseData
        Exit Function
    End If
    If Not UCase(MiHoja.Cells(1, "F")) Like "*INSTRUMENTO*" Then
        Call MsgBox("En la columna F, debe indicar Instrumento", vbExclamation, App.Title)
        GoTo CloseData
        Exit Function
    End If
    If Not UCase(MiHoja.Cells(1, "G")) Like "*NUMERO*" Then
        Call MsgBox("En la columna G, debe indicar Numero", vbExclamation, App.Title)
        GoTo CloseData
        Exit Function
    End If
    
'    If Not UCase(MiHoja.Cells(1, "I")) Like "*AJUSTE*" Then
'        Call MsgBox("En la columna I, debe indicar Ajuste", vbExclamation, App.Title)
'        GoTo CloseData
'        Exit Function
'    End If
'    If Not UCase(MiHoja.Cells(1, "J")) Like "*CUPON*" Then
'        Call MsgBox("En la columna J, debe indicar Ajuste", vbExclamation, App.Title)
'        GoTo CloseData
'        Exit Function
'    End If
    
    If Not UCase(MiHoja.Cells(1, "J")) Like "*AJUSTE*" Then
        Call MsgBox("En la columna J, debe indicar Ajuste", vbExclamation, App.Title)
        GoTo CloseData
        Exit Function
    End If
    
    '->    Validacion de Columnas Requeridas

    '->    Validacion de Sincronizacion de Fecha
    If MiHoja.Cells(2, "A") <> TxtFecha.Value Then
        Call MsgBox("Fecha de los datos : " & MiHoja.Cells(2, "A") & " y la fecha seleccionada de análisis son distintas.", vbExclamation, App.Title)
        GoTo CloseData
        Exit Function
    End If
    '->    Validacion de Sincronizacion de Fecha
    
    Let cFecha = Format(TxtFecha.Value, "yyyymmdd")

    Envia = Array()
    Call AddParam(Envia, cFecha)
    If Bac_Sql_Execute("BacParamSuda.dbo.SP_MNT_PATRIMONIO_LIMPIA_CUENTAS", Envia) = False Then
       Exit Function
    End If

    For iContador = 2 To iFilas
        
        If MiHoja.Cells(iContador, "A") = "" Then
            If iContador = 2 Then
                Call MsgBox("Planilla no contiene información", vbExclamation, App.Title)
                GoTo CloseData
                Exit For
            End If

            If iContador > 2 Then
                GoTo CloseData
                Exit For
            End If
        End If
      
        '->   Limpia Variables
        Let cFecha = "":    Let cCuenta = "":   Let cOrigen = "":   Let nContrato = 0:  Let nAjuste = 0:    Let nAjusteCorteCupon = 0
        '->   Limpia Variables
        
        '->   Lectura de los Datos requeridos
        Let cFecha = Format(CDate(MiHoja.Cells(iContador, "A")), "YYYYMMDD")
        Let cCuenta = MiHoja.Cells(iContador, "C")
        Let cOrigen = MiHoja.Cells(iContador, "F")
               If cOrigen Like "*SWAP*" Then Let cOrigen = "PCS"
            If cOrigen Like "*FORWARD*" Then Let cOrigen = "BFW"
             If cOrigen Like "*OPCION*" Then Let cOrigen = "OPC"
        Let nContrato = MiHoja.Cells(iContador, "G")

       'Let nAjuste = MiHoja.Cells(iContador, "I")
        Let nAjusteCorteCupon = MiHoja.Cells(iContador, "J")
       'Let nAjuste = IIf(nAjusteCorteCupon <> 0, nAjusteCorteCupon, nAjuste)

        Let nAjuste = nAjusteCorteCupon
        '->   Lectura de los Datos requeridos

        '->   Inserta los Datos
        Envia = Array()
        Call AddParam(Envia, cFecha)
        Call AddParam(Envia, cOrigen)
        Call AddParam(Envia, nContrato)
        Call AddParam(Envia, cCuenta)
        Call AddParam(Envia, nAjuste)
        If Bac_Sql_Execute("BacParamSuda.dbo.SP_MNT_PATRIMONIO_GRABA_CUENTAS", Envia) = False Then
           Let cLogString = cLogString & "E-Error. En la Grabación  [Fecha: " & cFecha & ", Origen : " & cOrigen & "Contrato : " & Trim(nContrato) & "]"
        End If
        '->   Inserta los Datos

    Next iContador

    If Len(cLogString) > 0 Then
       Call MsgBox("E-Error" & vbCrLf & cLogString, vbCritical, App.Title)
    Else
       Call MsgBox("OK- Actualización ha finalizado sin problemas.", vbInformation, App.Title)
    End If

    Call FuncLoadCargaPatrimonio

    Call MiLibro.SaveAs(Replace(Commond.FileName, Commond.FileTitle, "OK " & Commond.FileTitle))

    Call MiLibro.Close

    Set MiHoja = Nothing
    Set MiLibro = Nothing
    Set MiExcell = Nothing

    On Error GoTo 0
    On Error GoTo ErrorKill
    Call Kill(Commond.FileName)
    On Error GoTo 0

Exit Function
ErrorKill:
    If Err.Number = 75 Then
        Call Kill("OK " & Commond.FileTitle)
    End If

    Exit Function
Exit Function
ErrorOper:

    If Err.Number = 1004 Then
        If MsgBox("Archivo está siendo utilizado por otra aplicación", vbExclamation, App.Title) = vbRetry Then
            Exit Function
        End If
    End If

    If Err.Number = 32755 Then
       Exit Function
    Else
        Call MsgBox(Err.Description, vbExclamation, App.Title)
    End If
   
    If Err.Number = 429 Then
        Exit Function
    End If
    
    GoTo CloseData:
Exit Function
CloseData:

    Call MiLibro.Close

    Set MiHoja = Nothing
    Set MiLibro = Nothing
    Set MiExcell = Nothing

End Function

Private Function FuncGeneraExcel()
  
   Commond.DialogTitle = "Plantilla"
   Commond.InitDir = "C:\"
   Commond.Flags = cdlOFNLongNames
   Commond.DefaultExt = "xls"
   Commond.Filter = ".xls"
   Commond.CancelError = True
   Commond.FileName = "Plantilla_Coberturas.xls"
   Commond.ShowSave

   If Commond.FileName = "" Then   'Si presiona cancelar y no genera el archivo xls
      Call MsgBox("Debe especificar un nombre de archivo", vbOKOnly, App.Title)
      Exit Function
   End If
   If Dir(Commond.FileName) <> "" Then
      If MsgBox("El archivo " + vbCrLf + vbCrLf + Commond.FileName + vbCrLf + vbCrLf + " Ya existe, ¿Desea reemplazar el existente.?", vbQuestion + vbYesNo) = vbNo Then
         Let Screen.MousePointer = vbDefault
         Exit Function
      Else
         Call Kill(Commond.FileName)
      End If
   End If

   Set xlapp = CreateObject("Excel.Application")
   Set xlbook = xlapp.Workbooks.Add
   Set xlsheet = xlbook.Worksheets(1)
   
   xlbook.Worksheets(3).Delete
   xlbook.Worksheets(2).Delete
   
  ' xlbook.Worksheets.Add
   xlbook.Worksheets(1).Name = "Plantilla"
   
   xlbook.Sheets("Plantilla").Activate
   Set xlsheet = xlbook.ActiveSheet
   
   xlsheet.Cells(1, 1).Value = "Fecha"
   xlsheet.Cells(1, 2).Value = "Origen"
   xlsheet.Cells(1, 3).Value = "Contrato"
   xlsheet.Cells(1, 4).Value = "Cuenta"
   xlsheet.Cells(1, 5).Value = "Ajuste"
   
   xlbook.Application.DisplayAlerts = False
   Call xlbook.SaveAs("C:\Plantilla_Coberturas.xls")
   xlbook.Application.Workbooks.Close
   
   xlapp.Visible = True
   
   Set xlsheet = Nothing
   Set xlbook = Nothing
   Set xlapp = Nothing
   
End Function


Private Function FuncCreaMarco()
On Error Resume Next
    Selection.Borders(xlDiagonalDown).LineStyle = xlNone
    Selection.Borders(xlDiagonalUp).LineStyle = xlNone
    With Selection.Borders(xlEdgeLeft)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
    With Selection.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
    With Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
    With Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
    Selection.Borders(xlInsideVertical).LineStyle = xlNone
    Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
On Error GoTo 0
End Function

Public Sub CerrarPlanillaExcel(ByRef AppExcel As Object)
   AppExcel.ActiveWorkbook.Close
End Sub
Public Sub ActivaHojaExcel(ByRef AppExcel As Object, Nombre_Hoja)
   AppExcel.Sheets(Nombre_Hoja).Select
End Sub
Public Sub AbrePlanillaExcel(ByRef AppExcel As Object, Nombre_Archivo As String)
   AppExcel.Workbooks.Open FileName:=Nombre_Archivo, UpdateLinks:=False, ReadOnly:=True
End Sub

Public Sub AbrirExcel(ByRef AppExcel As Object, Visible As Boolean)
   Dim intErr As Integer
   On Error GoTo ErrorOpen

   Set AppExcel = GetObject(, "Excel.Application")
Salir:
    On Error GoTo 0

Exit Sub
ErrorOpen:
   Set AppExcel = CreateObject("Excel.Application")
   GoTo Salir
End Sub



