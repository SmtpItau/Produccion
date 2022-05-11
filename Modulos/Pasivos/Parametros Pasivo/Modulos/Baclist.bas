Attribute VB_Name = "BacList"
Sub LlamaListadosMonedas(año As String, CodMoneda As Long, GlosaMoneda As String, fecha As String)
   Dim TitRpt As String
   Screen.MousePointer = vbHourglass
   
   Call Grabar_Log_Auditoria(gsEntidad _
                                 , gsbac_fecp _
                                 , ComputerName _
                                 , gsUsuario _
                                 , "PCA" _
                                 , "opc_850" _
                                 , "07" _
                                 , "Acceso a Informe de Valores de Monedas " _
                                 , " " _
                                 , " " _
                                 , " ")

   Call limpiar_cristal
   
   BAC_Parametros.BacParam.Destination = crptToWindow
   BAC_Parametros.BacParam.Connect = SwConeccion
   TitRpt = UCase(GlosaMoneda)
   BAC_Parametros.BacParam.WindowTitle = "Valores de Monedas al " & sHasta$
   BAC_Parametros.BacParam.ReportFileName = gsRPT_Path & "LISTMDVM.RPT"
   Call PROC_ESTABLECE_UBICACION(BAC_Parametros.BacParam.RetrieveDataFiles, BAC_Parametros.BacParam)
   BAC_Parametros.BacParam.StoredProcParam(0) = Format(fecha, "yyyymmdd")
   BAC_Parametros.BacParam.StoredProcParam(1) = CodMoneda
   BAC_Parametros.BacParam.StoredProcParam(2) = gsBAC_User
   BAC_Parametros.BacParam.Action = 1
   
   Call Grabar_Log_Auditoria(gsEntidad _
                                 , gsbac_fecp _
                                 , ComputerName _
                                 , gsUsuario _
                                 , "PCA" _
                                 , "opc_850" _
                                 , "08" _
                                 , "Salida desde Informe de Valores de Monedas " _
                                 , " " _
                                 , " " _
                                 , " ")
    
   Screen.MousePointer = vbDefault
  
End Sub



Function LlenarValoresMonedas(xDesde As String, codigo As Long) As Boolean
Dim Datos()
'SQL = "delete  from ListMDVM;"
LlenarValoresMonedas = False
'db.Execute SQL

Envia = Array()
AddParam Envia, xDesde
AddParam Envia, codigo


'Sql = "sp_ListValoresMonedas '" & Format(xDesde, "yyyymmdd") & "','" & Format(xHasta, "yyyymmdd") & "'"
If BAC_SQL_EXECUTE("sp_ListValoresMonedas", Envia) = 0 Then
'            Do While SQL_Fetch(Datos()) = 0
'                    SQL = "Insert into  ListMDVM values( " & Chr(10)
'                    SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
'                    SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
'                    SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
'                    SQL = SQL + Datos(4) + "," & Chr(10)
'                    SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
'                    SQL = SQL + Datos(6) + "," & Chr(10)
'                    SQL = SQL + "'" + Datos(7) + "');"
'                    db.Execute SQL
'            Loop
            LlenarValoresMonedas = True
Else
            MsgBox "Informe no pudo ser procesado, Intente más tarde", vbExclamation
End If

End Function

Function LlenarTablasGenerales() As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM LISTTABG;"
    LlenarTablasGenerales = True
    DB.Execute Sql

    If BAC_SQL_EXECUTE("SP_LISTTABLASGENERALES") Then
        Do While BAC_SQL_FETCH(Datos())
            Sql = "INSERT INTO LISTTABG VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + Datos(4) + "," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "');"
            'MsgBox Sql
            DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation
        LlenarTablasGenerales = False
    End If

End Function

Function LlenarFamilias() As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM MANTFAMILIA;"
    LlenarFamilias = True
    DB.Execute Sql

    If BAC_SQL_EXECUTE("execute SP_LISTMANTFAMILIA") Then
        Do While BAC_SQL_FETCH(Datos())
            Sql = "INSERT INTO MANTFAMILIA VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + Datos(4) + "," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(11) + "'," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + "'" + Datos(13) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(14) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(15) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(16) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(17) + "');"
            DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation
        LlenarFamilias = False
    End If

End Function


Function LlenarClientes() As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM CLIENTE;"
    LlenarClientes = True
    DB.Execute Sql

    If BAC_SQL_EXECUTE("EXECUTE SP_LISTCLIENTES") Then
        Do While BAC_SQL_FETCH(Datos())
            Sql = "INSERT INTO CLIENTES VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + Datos(5) + "," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(9) + "'," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + "'" + Datos(11) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(12) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(13) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(14) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(15) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(16) + "');"
            DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation
        LlenarClientes = False
    End If

End Function

Function LlenarEmisores() As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM EMISOR;"
    LlenarEmisores = True
    DB.Execute Sql

    If BAC_SQL_EXECUTE("SP_LISTEMISORES") Then
        Do While BAC_SQL_FETCH(Datos())
            Sql = "INSERT INTO EMISORES VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + Datos(5) + "," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(9) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "');"
            DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation
        LlenarEmisores = False
    End If

End Function
