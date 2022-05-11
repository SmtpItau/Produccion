Attribute VB_Name = "BACSql"
'Modificado 6/8/1999 (Gonzalo Bustos)
Option Explicit

Dim SqlConn&
Dim QryNumColumns&
Dim QryPrimeraFila%
Private Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, nSize As Long) As Long
Private Function devComputer() As String
Dim lSize As Long
Dim sBuffer As String

    devComputer = "NO DEFINIDO"
    sBuffer = Space(255)
    lSize = Len(sBuffer)
    Call GetComputerName(sBuffer, lSize)
    If lSize > 0 Then devComputer = Left(sBuffer, lSize)
            
End Function
Private Function fNull(Variable As Variant, Valor As Variant) As Variant
    fNull = IIf(IsNull(Variable), Valor, Variable)
End Function
Sub SQL_CancelQry()
Dim Results%
    Results% = SqlCancel(SqlConn)
End Sub
Sub SQL_Close()
    If SqlConn <> 0 Then SqlClose (SqlConn)
End Sub

Function SQL_Execute%(Cmd$)
Dim Results&
Dim Num&

    SQL_Execute = 0
    Results = SqlCancel(SqlConn)
      
    If SqlCmd(SqlConn, Cmd$) = FAIL Then SQL_Execute = 1
    If SqlExec(SqlConn) = FAIL Then SQL_Execute = 1
    If SqlResults(SqlConn) = FAIL Then SQL_Execute = 1
    If SqlRetStatus(SqlConn) <> 0 Then SQL_Execute = 1
    
    QryNumColumns = SqlNumCols(SqlConn)
    
    If QryNumColumns = 0 And Results <> NOMORERESULTS And SQL_Execute <> 1 Then
        QryPrimeraFila% = 0
        Do Until Results = NOMORERESULTS
            Results = SqlResults(SqlConn)
            If SqlNextRow(SqlConn) <> NOMOREROWS Then
                SQL_Execute = 0
                QryNumColumns = SqlNumCols(SqlConn)
                QryPrimeraFila% = 1
                Exit Function
            End If
        Loop
    End If
    
    If SQL_Execute = 1 Then MsgBox "Falla SQL_Execute, Comando: " & vbCrLf & vbCrLf & Cmd$, vbCritical, App.Title
  
End Function
Sub SQL_Exit()
    SqlExit
    SqlWinExit
End Sub
Function SQL_Fetch(campo() As Variant) As Integer
Dim Indice As Long
Dim Max    As Long
Dim nresult&

    SQL_Fetch = 0
    If QryPrimeraFila% = 1 Then
        ReDim campo(QryNumColumns)
        Max = UBound(campo, 1)
        For Indice = 1 To Max
            campo(Indice) = RTrim$(SqlData(SqlConn, Indice))
        Next Indice
        QryPrimeraFila% = 0
        Exit Function
    End If

    Do Until nresult& = NOMORERESULTS
        nresult& = SqlResults(SqlConn)
        If SqlNextRow(SqlConn) <> NOMOREROWS Then
            ReDim campo(QryNumColumns)
            Max = UBound(campo, 1)
            For Indice = 1 To Max
                campo(Indice) = RTrim$(SqlData(SqlConn, Indice))
            Next Indice
            SQL_Fetch = 0
            Exit Do
        Else
            SQL_Fetch = -1
        End If
    Loop

End Function
Function SQL_Init%()
    SQL_Init% = 0
    If SqlInit$() = "" Then
        SQL_Init% = -1
    End If
End Function
Function SQL_Open%(Servername$, LoginID$, Password$, DatabaseName$, ByVal iLOGIN_TIMEOUT%, ByVal iQUERY_TIMEOUT%)

'Abre una conección con el servidor

Dim Status%, ProgramName$, Result%, Msg$

    ProgramName$ = App.EXEName
    SQL_Open = 0
    'Si existe una conección la cierra
    If SqlConn <> 0 Then SqlClose (SqlConn)
    Status% = SqlSetLoginTime(iLOGIN_TIMEOUT%)
    SqlConn = SqlOpenConnection(Servername$, LoginID$, Password$, ProgramName$, ProgramName$)
    If SqlConn <> 0 Then
        Result% = SqlSetTime(iQUERY_TIMEOUT%)
        Result% = SqlUse(SqlConn, DatabaseName$)
        If Result% = FAIL Then
            
            Beep
            
            Msg$ = "Base de datos (" & DatabaseName$ + ")," & Chr$(13) + Chr$(10)
            Msg$ = Msg$ + "no se encuentra en servidor (" + Servername$ + ")."
            MsgBox "SQL_Open: " & Chr$(10) & Msg$, vbExclamation, App.Title
            
            'Error de Conección
            SQL_Open = 1

        End If
        
    Else
    
        'Error de Conección
        SQL_Open = 1
        
    End If
    
End Function

Function SQL_Proc(Cmd$, Name$) As Integer
Dim Num&, i&, a$, Results&

    SQL_Proc = 0
    
    If SqlRpcInit(SqlConn, Name$, 0) = FAIL Then
       SQL_Proc = -1
    End If
    
    Num& = SqlNumRets(SqlConn)
    Do While SqlNextRow(SqlConn) <> NOMOREROWS
        For i& = 1 To Num&
            a$ = SqlRetData$(SqlConn, i&)
        Next i&
    Loop
    
    If SqlHasRetStat(SqlConn) = FAIL Then
       SQL_Proc = -1
    End If

End Function
Function UserSqlErrorHandler%(SqlConn As Integer, Severity As Integer, ErrorNum As Integer, OsErr As Integer, ErrorStr As String, OsErrStr As String)

    If ErrorNum% <> SQLESMSG Then
        MsgBox ("DBLibrary Error: " + Str$(ErrorNum%) + " " + ErrorStr$)
    End If
    If OsErr% <> -1 Then
        MsgBox ("Operating-System Error: " + OsErrStr$)
    End If
    If Severity% = EXFATAL Then
        UserSqlErrorHandler% = INTEXIT
    Else
        UserSqlErrorHandler% = INTCANCEL
    End If
  
End Function
Sub UserSqlMsgHandler(SqlConn As Integer, Message As Long, State As Integer, Severity As Integer, MsgStr As String)
Dim NL$: NL$ = Chr$(13) + Chr$(10)
Dim Msg$

    If Message& <> 5701 And Message& <> 5703 Then
        Msg$ = "SQL Server Error: " + Str$(Message&) + " " + MsgStr$ + NL$
        Msg$ = Msg$ + "State=" + Str$(State%) + ", Severity=" + Str$(Severity)
        MsgBox Msg$
    End If
  
End Sub

