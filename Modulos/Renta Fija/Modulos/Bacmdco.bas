Attribute VB_Name = "modMDCO"
Option Explicit

Public Function CO_GrabarCortesSQL(Rutcart&, NumDocu#, correla%, ByVal Nominal#, Correlativo&, CorteMin#) As Boolean
'Graba los cortes almacenados en la tabla temporal
'En caso no haya cortes, asume un corte único

Dim rs As Recordset
Dim Cortes&

    CO_GrabarCortesSQL = False

    Sql = "SELECT * FROM mdco WHERE tm_correlativo = " & Correlativo
    Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)
    
    If rs.RecordCount > 0 Then
        'Agrega los cortes almacenados en la MDB
        rs.MoveFirst
        Do While Not rs.EOF
'            Sql = "EXECUTE SP_COGRABCORTES " & Chr(10)
'            Sql = Sql & Rutcart & "," & Chr(10)
'            Sql = Sql & NumDocu & "," & Chr(10)
'            Sql = Sql & Correla & "," & Chr(10)
'            Sql = Sql & BacFormatoSQL(rs("tm_cantcortd")) & "," & Chr(10)
'            Sql = Sql & BacFormatoSQL(rs("tm_mtocort"))

            Envia = Array(CDbl(Rutcart), _
                    NumDocu, _
                    CDbl(correla), _
                    CDbl(rs("tm_cantcortd")), _
                    CDbl(rs("tm_mtocort")))
                    
            If Not Bac_Sql_Execute("SP_COGRABCORTES", Envia) Then
                Exit Function
            End If
            
            rs.MoveNext
            
        Loop
    Else
    
        If CorteMin# <> 0 Then
            Cortes = Nominal / CorteMin#
            Nominal = CorteMin#
        Else
            Cortes = 1
        End If
           
        'Agrega un corte único con el nominal total
'        Sql = "SP_COGRABCORTES "
'        Sql = Sql & Rutcart & ","
'        Sql = Sql & NumDocu & ","
'        Sql = Sql & Correla & ","
'        Sql = Sql & BacFormatoSQL(Cortes) & ","
'        Sql = Sql & BacFormatoSQL(Nominal)

        Envia = Array(CDbl(Rutcart), _
                NumDocu, _
                CDbl(correla), _
                CDbl(Cortes), _
                CDbl(Nominal))
                
        If Not Bac_Sql_Execute("SP_COGRABCORTES", Envia) Then
            Exit Function
        End If
        
    End If

    CO_GrabarCortesSQL = True
    
End Function

Public Sub CO_EliminarCortesMDB(FormHandle&, Correlativo&)
Dim Sql$

    'Elimina los cortes del temporal
    Sql = "DELETE * FROM mdco WHERE  tm_hwnd = " & FormHandle& & " AND tm_correlativo = " & Correlativo
    db.Execute Sql

End Sub

Public Function CO_ChkCortes(ByRef Nominal#, ByVal CorteMin#)
Dim Residuo#
On Error GoTo ErrCortes

    CO_ChkCortes = False
    
    If CorteMin# <> 0 Then
    
  '      Residuo# = Nominal# Mod CorteMin#
        Residuo# = Nominal# - Int(Nominal# / CorteMin#) * CorteMin#
         
        'Realiza las validaciones para el corte minimo
        If Nominal# < CorteMin# Then
            MsgBox "Monto nominal debe ser mayor o igual al corte minimo " & vbCrLf & vbCrLf & "Corte minimo : " & Format$(CorteMin#, "#,##0.0000"), vbExclamation, gsBac_Version
            Nominal# = CorteMin#
            
            Exit Function
        ElseIf Residuo# <> 0 Then
            MsgBox "Nominal debe ser divisible por el valor del corte mínimo del papel: " & vbCrLf & "Corte Mínimo: " & Format(CorteMin#, "#,##0.0000"), vbExclamation, gsBac_Version
          ' Residuo# = Nominal# \ CorteMin#
            Residuo# = Int(Nominal# / CorteMin#)
            Nominal# = CorteMin# * Residuo#
            Exit Function
        End If
        
    End If
    
    CO_ChkCortes = True
    Exit Function
    
ErrCortes:
    MsgBox "Problemas en chequeo de cortes: " & err.Description & ". Comunique al Administrador.", vbExclamation, gsBac_Version
    Exit Function
End Function


Function CO_EliminarCortesSQL(Rutcart&, NumDocu#, correla%) As Boolean

    CO_EliminarCortesSQL = False
    
'    Sql = "SP_COELIMCORTES " & Chr(10)
'    Sql = Sql & Rutcart & "," & Chr(10)
'    Sql = Sql & NumDocu & "," & Chr(10)
'    Sql = Sql & Correla

    Envia = Array(CDbl(Rutcart), _
            NumDocu, _
            CDbl(correla))
    
    If Not Bac_Sql_Execute("SP_COELIMCORTES", Envia) Then
        Exit Function
    End If
    
    CO_EliminarCortesSQL = True

End Function
Public Function CO_ChkCortesDAP(Nominal#, MominalOrg#, Moneda) As Boolean
Dim Residuo#
Dim CorteMinimo#
Dim cFormato$
On Error GoTo ErrCortes
    CO_ChkCortesDAP = False
    If CDbl(Nominal#) > CDbl(MominalOrg#) Then
        MsgBox "Nominal debe ser menor o Igual al valor Total del Corte: " & vbCrLf & "Corte Total: " & Format(MominalOrg#, "###,###,##0.###0"), vbExclamation, gsBac_Version
        Exit Function
    ElseIf CDbl(Nominal#) < 0 Then
        MsgBox "Monto nominal debe ser mayor o igual al corte minimo " & vbCrLf & vbCrLf & "Corte minimo : " & Format$(CorteMinimo#, "###,###,##0.###0"), vbExclamation, gsBac_Version
        Exit Function
    End If
    Select Case Moneda
        Case "999":
            CorteMinimo# = 1
            cFormato$ = "#,##0"
            Residuo# = Nominal# - Int(Nominal# / CorteMinimo#) * CorteMinimo#
        Case "998":
            CorteMinimo# = 0.0001
            cFormato$ = "#,##0.0000"
            Residuo# = Nominal# - Round(Int(Round(Nominal# / CorteMinimo#, 4)) * CorteMinimo#, 4)
        Case Else
            CorteMinimo# = 0.01
            cFormato$ = "#,##0.00"
            Residuo# = Nominal# - Round(Int(Round(Nominal# / CorteMinimo#, 2)) * CorteMinimo#, 2)
    End Select
    If Nominal# < CorteMinimo# Then
        MsgBox "Monto nominal debe ser mayor o igual al corte minimo " & vbCrLf & vbCrLf & "Corte minimo : " & Format$(CorteMinimo#, cFormato$), vbExclamation, gsBac_Version
        Nominal# = CorteMinimo#
        Exit Function
    ElseIf Residuo# <> 0 Then
        MsgBox "Nominal debe ser divisible por el valor del corte mínimo del papel: " & vbCrLf & "Corte Mínimo: " & Format(CorteMinimo#, cFormato$), vbExclamation, gsBac_Version
        Residuo# = Int(Nominal# / CorteMinimo#)
        Nominal# = CorteMinimo# * Residuo#
        Exit Function
    End If
    CO_ChkCortesDAP = True
    Exit Function
ErrCortes:
    MsgBox "Problemas en Fungibilización de Cortes DAP: " & err.Description & ". Comunique al Administrador.", vbExclamation, gsBac_Version
    Exit Function
End Function

