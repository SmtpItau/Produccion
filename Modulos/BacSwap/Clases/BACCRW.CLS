VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCristal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'Handler del Reporte y de la ventana del reporte
Private m_printjob%
Private m_Hwnd%

'Características de impresión por pantalla del reporte
Private m_PosX%, m_PosY%
Private m_Ancho%, m_Alto%
Private m_Style&, m_Flag%, m_ParentWindow%

'Indica si hubo error al llamar a las API's
Private Result%

'Variables que controlan el orden del reporte
Private SortFields(0 To 9) As String
Private SortDirect(0 To 9) As Integer
Private nSortFields%

' Variables que controlan las Formula
Private FormulaName() As String
Private FormulaText() As String
Private StoredParam() As String
Private nFormula As Integer
Private nParam As Integer

Private m_OutputType%
Private m_ReportType$
Private m_NumberOfCopies%

'Variables Publicas
Public SelectionFormula$

Public Function PEN_SetProcParam(ByVal ParamN%, ByVal ParamValue$) As Boolean
     
     
        ParamN% = ParamN% + 1
        
        ' Nombre de la Formula
        ReDim Preserve StoredParam(ParamN%)
        StoredParam(ParamN%) = ParamValue$
        nParam = ParamN%
     
End Function
Private Function PEN_LoadStoredParam() As Boolean

    Dim j%
        
    PEN_LoadStoredParam = False
    
    For j = 1 To nParam
    
        If PESetNthParam(m_printjob%, j - 1, StoredParam(j)) <> 1 Then Exit Function
    Next
    
    PEN_LoadStoredParam = True
    
End Function
Private Function PEN_CheckFormula(pFName As String) As Boolean

        If PECheckFormula(m_printjob%, pFName) <> 1 Then
            PEN_CheckFormula = False
        Else
            PEN_CheckFormula = True
        End If
        
End Function

Property Let NumberOfCopies(Copies%)

    'Determina el número de copias para los reportes que no pasan por pantalla
    
    If Copies > 0 Then
    
        m_NumberOfCopies = Copies
        
    End If
    
End Property

Property Let OutputType(tipo%)

    'Determina el tipo de salida
    '   0 ---> Ventana
    '   1 ---> Impresora
    
    m_OutputType = tipo
    
End Property


Private Sub PEN_ErrorHandler()

Dim TextHandle%
Dim TextLength%
Dim ErrorString$
Dim Result%
Dim vRpt_ErrorCode%

vRpt_ErrorCode = PEGetErrorCode(m_printjob%)
Result% = PEGetErrorText(m_printjob%, TextHandle, TextLength)
ErrorString = String$(TextLength + 1, " ")
Result% = PEGetHandleString(TextHandle, ErrorString, TextLength)

If vRpt_ErrorCode <> 0 Then

   MsgBox ErrorString$, vbExclamation + vbOKOnly, "Reporte"
   
End If

End Sub

Private Function PEN_SetPrinter() As Boolean

    Dim DriverName$, PrinterName$, PortName$, PrinterMode&

    PEN_SetPrinter = False

    'Muestra el Common Dialog Box para seleccionar la impresora
'    BACSwap.crwBacFwd.CancelError = True
'    BACSwap.crwBacFwd.ShowPrinter
        
    'Recupera las características de la impresora seleccionada
    PortName = Printer.Port
    DriverName = Printer.DriverName
    PrinterName = Printer.DeviceName
    PrinterMode = 0
    
    'Setea la impresora seleccionada
    If PESelectPrinter(m_printjob%, DriverName$, PrinterName$, PortName$, PrinterMode&) <> 1 Then Exit Function

    PEN_SetPrinter = True
    
End Function

Property Let ReportType(tipo$)

    'Por defecto asume que es un reporte de Sql Server, ya que son mucho mas que los que se han
    'desarrollado en Access
    
    If tipo = "MDB" Or tipo = "SQL" Then
    
        m_ReportType = tipo
        
    Else
    
        m_ReportType = "SQL"
        
    End If
    
End Property

Private Sub Class_Initialize()

    Result = True
    
    'Seteo de Variables para la impresion por pantalla de reporte
    m_PosX = 0
    m_PosY = 0
    
    m_Ancho = 600
    m_Alto = 400
    
    m_Style = WS_CAPTION Or WS_THICKFRAME Or WS_CLIPCHILDREN Or WS_SYSMENU Or WS_MINIMIZEBOX 'Or WS_MAXIMIZEBOX
    m_ParentWindow = BACSwap.hWnd
    
    nSortFields% = 0
    nFormula% = 0
    nParam% = 0
    
    
    m_OutputType = PE_OUT_WINDOW
    m_ReportType = "SQL"
    m_NumberOfCopies = 1

    
    'Wait Until Done
    m_Flag = True
    SelectionFormula = ""
    
End Sub


Private Sub Class_Terminate()

    Call PEClosePrintJob(ByVal m_printjob%)

End Sub


Public Function PEN_ImprimirReporte(Reporte$, Titulo$) As Boolean

    
On Error GoTo BacErrorHandler
    
    Dim cNombre     As String
    
    PEN_ImprimirReporte = False
    
    'Dispara el Job
    cNombre = gsRPT_Path + "\" + Reporte + ".RPT"
    'cNombre = "O:\RPT" + "\" + Reporte + ".RPT"
    m_printjob = PEOpenPrintJob(cNombre)
    If m_printjob = 0 Then GoTo BacErrorHandler
    
    'Carga el orden en que se va a imprimir el reporte
    If PEN_LoadSortFields() = False Then GoTo BacErrorHandler
    
    ' Carga Las formulas
    If PEN_LoadFormulas() = False Then GoTo BacErrorHandler
    
    ' Carga Los parametros del stored procedure
    If PEN_LoadStoredParam() = False Then GoTo BacErrorHandler
    
    ' Carga la Selection Formula del Reporte
    If PEN_LoadSelectionFormula() = False Then GoTo BacErrorHandler
    
    'Setea la Selection Formula para el reporte
    
    If m_ReportType = "MDB" Then
    
        'Reportes donde la fuente es Access
        If PEN_ReporteMDB(Titulo$) = False Then GoTo BacErrorHandler
        
    ElseIf m_ReportType = "SQL" Then
    
        'Reportes donde la fuente es SQL Server
        If PEN_ReporteSQL(Titulo$) = False Then GoTo BacErrorHandler
        
    End If
    
    'Displaya el reporte en la ventana
    If m_OutputType = PE_OUT_WINDOW Then
    
        'Setea las caracteristicas de la ventana
        Result% = PEOutputToWindow(m_printjob%, Titulo$, m_PosX, m_PosY, m_Ancho, m_Alto, m_Style&, m_ParentWindow)

        'Dispara el reporte a ventana
        If PEStartPrintJob(m_printjob%, m_Flag%) <> 1 Then GoTo BacErrorHandler
        
        'Setea el ZOOM del reporte
        Result = PEZoomPreviewWindow(m_printjob%, PE_ZOOM_SIZE_FIT_BOTH_SIDES%)
        
    'Dispara el reporte a la impresora
    ElseIf m_OutputType = PE_OUT_PRINTER Then
    
        'Setea los parámetros de impresión
         If PEN_SetPrinter() = False Then GoTo BacErrorHandler

        'Dispara el reporte a la impresora
        If PEOutputToPrinter(m_printjob%, m_NumberOfCopies%) <> 1 Then GoTo BacErrorHandler
            
        'Dispara el reporte a impresora
        If PEStartPrintJob(m_printjob%, m_Flag%) <> 1 Then GoTo BacErrorHandler
        
    End If
        
    'Recupera el handler de la ventana del reporte
    m_Hwnd% = PEGetWindowHandle(m_printjob)
    
    PEN_ImprimirReporte = True
    
    Exit Function
    
BacErrorHandler:

    Call PEN_ErrorHandler
    Exit Function
    
End Function


Private Function PEN_LoadSortFields()

    Dim SortNumber%, SortFieldName$, Direction%
    
    PEN_LoadSortFields = False
    
    For SortNumber = 0 To 9
    
        SortFieldName = SortFields(SortNumber)
        Direction = SortDirect(SortNumber)
        
        If Trim$(SortFieldName) = "" Then Exit For
        
        If Direction <> PE_SF_ASC And Direction <> PE_SF_DESC Then
        
            Direction = PE_SF_ASC
            
        End If
        
        Result = PESetNthSortField(m_printjob%, SortNumber%, SortFieldName$, Direction%)
        
        If Result <> 1 Then
        
            Exit Function
            
        End If
        
    Next SortNumber
    
    PEN_LoadSortFields = True

End Function


Private Function PEN_ReporteMDB(Titulo$) As Boolean

    Dim Location As PETableLocation
    
    PEN_ReporteMDB = False
    
    'Inicializando Tipos de Datos
    Location.StructSize = PE_SIZEOF_TABLE_LOCATION
    
    Location.Location = gsMDB_Path & gsMDB_Database & Chr(0)
   'Location.Location = "O:\MDB\BACTRD.MDB"

    If PESetNthTableLocation(m_printjob%, 0, Location) <> 1 Then Exit Function

    'Displaya el reporte en la ventana
    If PEOutputToWindow(m_printjob%, Titulo$, m_PosX, m_PosY, m_Ancho, m_Alto, m_Style&, m_ParentWindow) <> 1 Then Exit Function
    
    PEN_ReporteMDB = True

End Function

Private Function PEN_ReporteSQL(Titulo$) As Boolean

    Dim LogOnInfo As PELogOnInfo
    
    Dim Location As PETableLocation
    Dim PosIni%, PosFin%, aux$
    
    PEN_ReporteSQL = False
    
    'Inicializando Tipos de Datos
    LogOnInfo.StructSize = PE_SIZEOF_LOGON_INFO
    Location.StructSize = PE_SIZEOF_TABLE_LOCATION
    
    'Recupera el Location de las Tablas del Reporte
    If PEGetNthTableLocation(m_printjob%, 0, Location) <> 1 Then Exit Function
    
    PosIni = InStr(Location.Location, ".")
    PosFin = InStr(Location.Location, Chr(0))
    aux = Mid$(Location.Location, PosIni, PosFin)
    'Location.Location = gsSQL_Database & aux
    Location.Location = "O:\MDB\BACTRD.MDB"
    
    'Setea el Location de las Tablas del Reporte
    If PESetNthTableLocation(m_printjob%, 0, Location) <> 1 Then Exit Function

    LogOnInfo.ServerName = gsSQL_Server & Chr(0)
    LogOnInfo.DatabaseName = gsSQL_Database & Chr(0)
    LogOnInfo.UserID = gsSQL_Login & Chr(0)
    LogOnInfo.Password = gsSQL_Password & Chr(0)
    
    'Setea los parámetros de la Base de Datos
    If PESetNthTableLogOnInfo(m_printjob%, 0, LogOnInfo, True) <> 1 Then Exit Function

    PEN_ReporteSQL = True
    
End Function

Public Function PEN_SetSortFields(SortNumber%, SortFieldName$, Direction%) As Boolean

    If SortNumber >= 0 And SortNumber <= 9 Then
    
        SortFields(SortNumber) = SortFieldName
        SortDirect(SortNumber) = Direction
        
    End If
    
End Function

Public Function PEN_SetFormula(ByVal FName$, ByVal FText$) As Boolean

    nFormula = nFormula + 1
    
    ' Nombre de la Formula
    ReDim Preserve FormulaName(nFormula)
    FormulaName(nFormula) = FName + Chr$(0)
    
    ' Texto de la Formula
    ReDim Preserve FormulaText(nFormula)
    FormulaText(nFormula) = FText + Chr$(0)
    
    
    
End Function

Private Function PEN_LoadFormulas() As Boolean

    Dim j%
        
    PEN_LoadFormulas = False
    
    For j = 1 To nFormula
    
        If PESetFormula(m_printjob%, FormulaName(j), FormulaText(j)) <> 1 Then Exit Function
        If PEN_CheckFormula(FormulaName(j)) = False Then Exit Function
        
    Next
    
    PEN_LoadFormulas = True
    
End Function
Private Function PEN_LoadSelectionFormula() As Boolean

    Dim j%, TextHandle%, TextLength%, Formula$
        
    PEN_LoadSelectionFormula = False
    
    If PEGetSelectionFormula(m_printjob%, TextHandle%, TextLength) <> 1 Then Exit Function
    
    Formula = String(TextLength, " ")
    If PEGetHandleString(TextHandle, Formula, TextLength) <> 1 Then Exit Function
    
    Formula = Mid$(Formula, 1, Len(Formula) - 1)

    
    If Formula <> "" Then
        SelectionFormula = IIf(SelectionFormula = "", Formula, Formula & " and " & SelectionFormula + Chr$(0))
    End If
    
    If PESetSelectionFormula(m_printjob%, SelectionFormula + Chr(0)) <> 1 Then Exit Function
    

    PEN_LoadSelectionFormula = True
    
End Function
