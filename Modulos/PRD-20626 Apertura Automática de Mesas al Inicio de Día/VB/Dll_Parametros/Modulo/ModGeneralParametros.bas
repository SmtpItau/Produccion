Attribute VB_Name = "ModGeneralParametros"
Option Explicit
Public miSQL            As New BTPADODB.CADODB
Public ENVIA()          As Variant
Public gsBac_LineasDB   As String
Public gsBAC_Fecp       As String
Public VerSql           As String

Public Function Bac_Sql_Execute(Procedimiento As String, Optional Arreglo As Variant) As Boolean
    Dim i               As Integer
    Dim Conta           As Integer, Mc
    Dim SQL             As String
    Dim gsc_PuntoDecim  As String
    
    On Error GoTo ErroresFuncion

    Bac_Sql_Execute = True

    SQL = Procedimiento

    gsc_PuntoDecim = Mid$(Format(0#, "0.0"), 2, 1)
    
    If IsMissing(Arreglo) Then
        Conta = -1
    Else
        Conta = UBound(Arreglo)
    End If

    For i = 0 To Conta
        If TypeName(Arreglo(i)) = "String" Then
            If IsDate(Arreglo(i)) Then
                SQL = SQL & " '" & Format(Arreglo(i), "YYYYMMDD") & "',"
            Else
                SQL = SQL & " '" & Arreglo(i) & "',"
            End If
        ElseIf TypeName(Arreglo(i)) = "Date" Then
            SQL = SQL & " '" & Format(Arreglo(i), "YYYYMMDD") & "',"
        Else
            If gsc_PuntoDecim = "," Then
                Mc = InStr(1, Arreglo(i), ",")
                If Mc > 0 Then
                    Arreglo(i) = Mid(Arreglo(i), 1, Mc - 1) & "." & Mid(Arreglo(i), Mc + 1)
                End If
            End If
            SQL = SQL & " " & Arreglo(i) & ","
        End If
    Next i

    If Conta > -1 Then
        SQL = Mid(SQL, 1, Len(SQL) - 1)
    End If

    VerSql = SQL

    If miSQL.SQL_Execute(SQL) <> 0 Then
        Bac_Sql_Execute = False
    End If

Exit Function
ErroresFuncion:
    If Err.Number = 9 Then
        Conta = -1
        Resume Next
    End If
End Function

Function Bac_SQL_Fetch(ByRef Arreglo As Variant) As Boolean
    Dim Datos()
    Dim i               As Integer
    Dim Conta           As Integer
    Dim Mc              As Integer
    Dim dblValor        As Double
    Dim strNumero       As String
    Dim tmpValor        As Variant
    Dim gsc_PuntoDecim  As String
   
    Bac_SQL_Fetch = False
    
    gsc_PuntoDecim = Mid$(Format(0#, "0.0"), 2, 1)
    
    If miSQL.SQL_Fetch(Datos) = 0 Then
        
        Conta = UBound(Datos)
        ReDim Arreglo(Conta)
        
        For i = 1 To Conta
            Bac_SQL_Fetch = True
            tmpValor = Trim(Datos(i))
            If IsNumeric(tmpValor) Then
                If gsc_PuntoDecim = "." Then
                    Mc = InStr(1, tmpValor, ",")
                    If Mc > 0 Then
                        tmpValor = Mid(tmpValor, 1, Mc - 1) & "." & Mid(tmpValor, Mc + 1)
                    End If
                End If
            ElseIf IsDate(tmpValor) Then
                Arreglo(i) = Format(tmpValor, "DD/MM/YYYY")
            End If
            Arreglo(i) = tmpValor
        Next
    End If

End Function


Public Function BacCtrlTransMonto(xMonto As Variant) As String
    Exit Function
End Function


Public Sub AddParam(ByRef Arreglo As Variant, Parametro As Variant)
    Dim Cuenta  As Long
    
    On Error GoTo errorcuenta:
   
    Cuenta = UBound(Arreglo) + 1
    ReDim Preserve Arreglo(Cuenta)
    Arreglo(Cuenta) = Parametro
   
Exit Sub
errorcuenta:
    Cuenta = 1
    Resume Next
End Sub

Public Function BacBeginTransaction() As Boolean

    BacBeginTransaction = True

    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        BacBeginTransaction = False
    End If
End Function

Public Function BacRollBackTransaction() As Boolean

    BacRollBackTransaction = True
    If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
        BacRollBackTransaction = False
    End If
End Function

Public Function BacCommitTransaction() As Boolean

    BacCommitTransaction = True
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        BacCommitTransaction = False
    End If
End Function



