Attribute VB_Name = "BacSql"
Option Explicit

Dim SqlConn%
Dim QryNumColumns%

Private Function Fnull(variable As Variant, Valor As Variant) As Variant
   
   Fnull = IIf(IsNull(variable), Valor, variable)

End Function

Sub SQL_CancelQry()

   Dim Results%

   Results% = SQLCancel(SqlConn%)
  
End Sub

Sub SQL_Close()

   If SqlConn <> 0 Then
      SqlClose (SqlConn)
   
   End If
  
End Sub

'Envía la consulta al servidor
Function SQL_Execute%(cmd$)
   
   Dim Results%
   Dim Num%

   SQL_Execute = 0  'Ok
   Results% = SQLCancel(SqlConn%)
  
   If SqlCmd(SqlConn%, cmd$) = FAIL% Then
      SQL_Execute = 1  'Error
      
   End If
  
   If SqlExec(SqlConn%) = FAIL% Then
      SQL_Execute = 1  'Error

   End If
   
   If SqlResults%(SqlConn%) = FAIL% Then
      SQL_Execute = 1  'Error

   End If
   
   '***********************************
   'CRISTIAN HERRERA
   '***********************************
   'retorna el número de estado para el
   'actual procedimiento almacenado o
   'uno remoto
   If SqlRetStatus(SqlConn%) <> 0 Then
      SQL_Execute = 1  'Error
   
   End If
   '***********************************
   
   QryNumColumns% = SqlNumCols(SqlConn%)
   
End Function

Public Function SQL_ExeCursor(cmd$)

   Dim nResult%

   SQL_ExeCursor = 0

   If SqlConn% = 0 Then
      SQL_ExeCursor = 1
      Exit Function

   End If

   nResult% = SQLCancel(SqlConn%)

   If SqlCmd(SqlConn, cmd$) = FAIL% Then
      SQL_ExeCursor = 1
      Exit Function

   End If

   If SqlExec(SqlConn) = FAIL% Then
      SQL_ExeCursor = 1
      Exit Function

   End If

   Do Until nResult% = NOMORERESULTS

      nResult% = SqlResults(SqlConn)

      While SqlNextRow(SqlConn) <> NOMOREROWS
         SQL_ExeCursor = 0

      Wend

   Loop

End Function

Sub SQL_Exit()

   SqlExit
   SqlWinExit
  
End Sub

Function SQL_Fetch(campo() As Variant) As Integer

   'Devuelve la consulta hecha al servidor y la carga a un arreglo
   
   Dim Indice As Long
   Dim Max As Long     'Indice máximo del arreglo

   'Ok
   SQL_Fetch = 0

   If SqlNextRow%(SqlConn%) <> NOMOREROWS Then
      ReDim campo(QryNumColumns%)
      Max = UBound(campo, 1)
      For Indice = 1 To Max
         campo(Indice) = Trim$(Sqldata(SqlConn%, Indice))
      
      Next Indice
   
   Else
      SQL_Fetch = -1
   
   End If

End Function

Sub SQL_Init()

   'Inicializa la DB-Library
   If SqlInit$() = "" Then
      MsgBox "DB-Library for Visual Basic Library has not been initialized."
      End

   End If

End Sub


Function SQL_Open%(ServerName$, LoginID$, Password$, DatabaseName$, ByVal iLOGIN_TIMEOUT%, ByVal iQUERY_TIMEOUT%)

   'Abre una conección con el servidor
   
   Dim Status%, ProgramName$, Result%, Msg$

   ProgramName$ = App.EXEName
   SQL_Open = 0
   
   'Si existe una conección la cierra
   If SqlConn <> 0 Then
      SqlClose (SqlConn)
   
   End If
   
   Status% = SqlSetLoginTime%(iLOGIN_TIMEOUT%)
   SqlConn = SqlOpenConnection(ServerName$, LoginID$, Password$, ProgramName$, ProgramName$)

   If SqlConn <> 0 Then
      Result% = SqlSetTime%(iQUERY_TIMEOUT%)
      Result% = SqlUse(SqlConn%, DatabaseName$)

      If Result% = FAIL Then

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



Function SQL_Proc(cmd$, name$) As Integer

   Dim Num%, I%, a$, Results%

   SQL_Proc = 0
    
   If SqlRpcInit(SqlConn%, name$, 0) = FAIL% Then
      SQL_Proc = -1
    
   End If
      
   Num% = SqlNumRets%(SqlConn%)
   Do While SqlNextRow%(SqlConn%) <> NOMOREROWS
      For I% = 1 To Num%
         a$ = SqlRetData$(SqlConn%, I%)
      
      Next I%
   
   Loop
    
   If SqlHasRetStat(SqlConn%) = FAIL% Then
      SQL_Proc = -1
   
   End If

End Function

Function UserSqlErrorHandler%(SqlConn As Integer, Severity As Integer, ErrorNum As Integer, OsErr As Integer, ErrorStr As String, OsErrStr As String)
   
   If ErrorNum% <> SQLESMSG% Then
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

