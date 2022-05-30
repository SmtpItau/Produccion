Attribute VB_Name = "BACSql"
Option Explicit
Public SqlConn                As Long
Dim QryNumColumns             As Long

Private Function Fnull(variable As Variant, Valor As Variant) As Variant

   Fnull = IIf(IsNull(variable), Valor, variable)

End Function

Sub SQL_CancelQry()

   Dim Results          As Long

   Results = SqlCancel(SqlConn)
  
End Sub

Sub SQL_Close()

   If MISQL.SQL_Coneccion <> 0 Then
      MISQL.SQL_Close '(MISQL.SQL_Coneccion)
'      Call PECloseEngine

   End If
  
End Sub

Function SQL_Execute(cmd$) As Long

   'Envía la consulta al servidor
   Dim Results          As Long
   Dim num              As Long

   SQL_Execute = 0  'Ok

   Results = SqlCancel(SqlConn)
   If SqlCmd(SqlConn, cmd$) = FAIL Then
      SQL_Execute = 1  'Error

   End If

   If SqlExec(SqlConn) = FAIL Then
      SQL_Execute = 1  'Error
   
   End If

   If SqlResults(SqlConn) = FAIL Then
      SQL_Execute = 1  'Error

   End If

   'If SqlRetStatus(SqlConn) = 0 Then
      'SQL_Execute = 1  'Error

   'End If

   QryNumColumns = SqlNumCols(SqlConn)
   
   If SQL_Execute = 1 Then
      MsgBox "ERROR con procedimiento " & cmd, vbCritical, "Control SQL"
   End If

End Function

Sub SQL_Exit()
   ' SqlExit
   ' SqlWinExit
End Sub
Function SQL_Fetch(campo() As Variant) As Integer

   'Devuelve la consulta hecha al servidor y la carga a un arreglo
   Dim Indice        As Long
   Dim Max           As Long     'Indice máximo del arreglo

   'Ok
   MISQL.SQL_Fetch = 0

   If SqlNextRow(SqlConn) <> NOMOREROWS Then
      ReDim campo(QryNumColumns)
      Max = UBound(campo, 1)

      For Indice = 1 To Max
         campo(Indice) = RTrim$(SqlData(SqlConn, Indice))

      Next Indice

   Else
      MISQL.SQL_Fetch = -1

   End If

End Function
Sub SQL_Init()

   'Inicializa la DB-Library
   'If SqlInit$() = "" Then
   '   MsgBox "DB-Library for Visual Basic Library has not been initialized."

   'End If

End Sub

Function SQL_Open%(ServerName$, LoginID$, Password$, DatabaseName$, ByVal iLOGIN_TIMEOUT As Long, ByVal iQUERY_TIMEOUT As Long)

   'Abre una conección con el servidor

   Dim Status        As Long
   Dim Result        As Long
   Dim ProgramName$
   Dim Msg$

   ProgramName$ = App.EXEName
   SQL_Open = 0

   'Si existe una conección la cierra
   If SqlConn <> 0 Then
      SqlClose (SqlConn)

   End If

   Status = SqlSetLoginTime(iLOGIN_TIMEOUT)

   SqlConn = SqlOpenConnection(ServerName$, LoginID$, Password$, ProgramName$, ProgramName$)

   'Call clsSql.Sql_Conneccion(SqlConn)

   If SqlConn <> 0 Then
      Result = SqlSetTime(iQUERY_TIMEOUT)
      Result = SqlUse(SqlConn, DatabaseName$)

      If Result = FAIL Then
         Beep

         Msg$ = "Base de datos (" & DatabaseName$ + ")," & Chr$(13) + Chr$(10)
         Msg$ = Msg$ + "no se encuentra en servidor (" + ServerName$ + ")."

         MsgBox "SQL_Open: " & Chr$(10) & Msg$, 48, App.Title

         'Error de Conección
         SQL_Open = 1

      End If

   Else
      'Error de Conección
      SQL_Open = 1

   End If

End Function

Function SQL_Proc(cmd$, Name$) As Long

   Dim num              As Long
   Dim i                As Long
   Dim Results          As Long
   Dim A$

   SQL_Proc = 0

   If SqlRpcInit(SqlConn, Name$, 0) = FAIL Then
      SQL_Proc = -1

   End If

   'If SqlRpcExecute(Sqlconn%) = FAIL Then
   '   SQL_Proc = -1  'Error
   'End If

   num = SqlNumRets(SqlConn)

   Do While SqlNextRow(SqlConn) <> NOMOREROWS
      For i = 1 To num
         A$ = SqlRetData$(SqlConn, i)

      Next i

   Loop

   If SqlHasRetStat(SqlConn) = FAIL Then
      SQL_Proc = -1

   End If

End Function

Function UserSqlErrorHandler(SqlConn As Long, Severity As Long, ErrorNum As Long, OsErr As Long, ErrorStr As String, OsErrStr As String) As Long

   If ErrorNum <> SQLESMSG Then
      MsgBox ("DBLibrary Error: " + Str$(ErrorNum) + " " + ErrorStr$)

   End If

   If OsErr <> -1 Then
      MsgBox ("Operating-System Error: " + OsErrStr$)

   End If

   If Severity = EXFATAL Then
      UserSqlErrorHandler = INTEXIT

   Else
      UserSqlErrorHandler = INTCANCEL

   End If
  
End Function

Sub UserSqlMsgHandler(SqlConn As Long, Message As Long, State As Long, Severity As Long, MsgStr As String)

   Dim NL$
   Dim Msg$

   NL$ = Chr$(13) + Chr$(10)

   If Message& <> 5701 And Message& <> 5703 Then
      Msg$ = "SQL Server Error: " + Str$(Message&) + " " + MsgStr$ + NL$
      Msg$ = Msg$ + "State=" + Str$(State) + ", Severity=" + Str$(Severity)

      MsgBox Msg$

   End If

End Sub

Public Function SQL_ExeCursor(cmd$)

   Dim nResult%
   Dim nI%

   SQL_ExeCursor = 0

   If SqlConn = 0 Then
      SQL_ExeCursor = 1
      Exit Function

   End If

   nResult% = SqlCancel(SqlConn)

   If SqlCmd(SqlConn, cmd$) = FAIL Then
      SQL_ExeCursor = 1
      Exit Function

   End If

   If SqlExec(SqlConn) = FAIL Then
      SQL_ExeCursor = 1
      Exit Function

   End If

   nI = 2

   Do Until nResult% = NOMORERESULTS

      nResult% = SqlResults(SqlConn)

      While SqlNextRow(SqlConn) <> NOMOREROWS
'         Call oControl.LeerCursor
         SQL_ExeCursor = 0

      Wend

   Loop

End Function

