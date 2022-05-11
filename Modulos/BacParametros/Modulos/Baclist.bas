Attribute VB_Name = "BacList"

Function Inf_EstadoCuenta(rut As Long, codigo As Long) As Boolean

Dim Sql As String
Dim Datos()

Screen.MousePointer = 11

    Sql = "DELETE FROM ESTADOCUENTA;"
    Inf_EstadoCuenta = True
    DB.Execute Sql
    
    ''''''''''''''''Sql = "SP_ESTADO_CUENTA" & Val(rut) & "," & Val(codigo)
    
    Envia = Array()
    
    AddParam Envia, CDbl(rut)
    AddParam Envia, CDbl(codigo)
    
    If Bac_Sql_Execute("SP_ESTADO_CUENTA", Envia) Then
        
        Do While Bac_SQL_Fetch(Datos())
            
            Sql = "INSERT INTO ESTADOCUENTA VALUES( " & Chr(10)
            Sql = Sql + Datos(1) + "," & Chr(10)                                     'Rut Cliente
            Sql = Sql + "'" + Trim(Datos(2)) + "'," & Chr(10)                                    'Codigo Rut
            Sql = Sql + "'" + Trim(Datos(3)) + "'," & Chr(10)                   'Nombre
            Sql = Sql + "'" + Trim(Datos(4)) + "'," & Chr(10)                   'Sistema
            Sql = Sql + Datos(5) + "," & Chr(10)                                     ' Numero Operación
            Sql = Sql + "'" + Trim(Datos(6)) + "'," & Chr(10)                   'Tipo Operación
            Sql = Sql + "'" + Trim(Datos(7)) + " '," & Chr(10) 'Instrumento
            Sql = Sql + "'" + Trim(Datos(8)) + " '," & Chr(10) 'Emisor
            Sql = Sql + Datos(9) + "," & Chr(10) 'Nominal
            Sql = Sql + "'" + Trim(Datos(10)) + " ' ," & Chr(10)                  'Moneda
            Sql = Sql + Datos(11) + "," & Chr(10)                           'Tir/Precio
            Sql = Sql + Datos(12) + "," & Chr(10)   'Monto Operación
            Sql = Sql + "'" + Format(Datos(13), "DD/MM/YYYY") + " '," & Chr(10) 'Fecha Vencimiento
            Sql = Sql + "'" + Trim(Datos(14)) + " '," & Chr(10)  'Moneda Pacto
            Sql = Sql + Datos(15) + "," & Chr(10) 'Tasa Pacto
            Sql = Sql + Datos(16) + "," & Chr(10) 'Valor Final
            Sql = Sql + "'" + Format(Datos(17), "dd/mm/yyyy") + "'," & Chr(10) 'Valor Final
            Sql = Sql + "'" + Trim(Datos(18)) + "'," & Chr(10)                              'Forma Pago
            Sql = Sql + "'" + Format(Datos(19), "dd/mm/yyyy") + "'," & Chr(10) 'Fecha Operación
            Sql = Sql + "' " + Format(Time, "HH:MM:SS") + "' "
            Sql = Sql + " );"
            
            DB.Execute Sql
        
        Loop
    
    Else
        
        MsgBox "Informe no puede ser Generado", vbExclamation, TITSISTEMA
        Inf_EstadoCuenta = False
    
    End If

End Function
Function Inf_Recepcionar(Tipo_Informe As Long) As Boolean
Dim Sql As String
Dim Datos()

Screen.MousePointer = 11

 
    Inf_Recepcionar = True
 
    
    ''''''''''''''''''''''''Sql = "SP_INF_RECPINSTRUMENTO" & Val(Tipo_Informe)
    
    Envia = Array()
    
    AddParam Envia, CDbl(Tipo_Informe)
    
    If Not Bac_Sql_Execute("SP_INF_RECPINSTRUMENTO", Envia) Then
     
        MsgBox "Informe no puede ser Generado", vbExclamation, TITSISTEMA
        Inf_Recepcionar = False
    
    End If

Screen.MousePointer = 0

End Function
'Function Informe_Custodia(xReporte As String, nRut As Long, iCodigo As Long) As Boolean
'Informe_Custodia = False
'Dim Sql As String
'Dim Datos()
'Dim p  As Integer
'If Not Llenar_Parametros(xReporte) Then
'  Exit Function
'End If
''db.Execute "Delete * from INFCUSTODIA"
'p = 0
'Sql = "EXECUTE sp_inf_custodia " & nRut & "," & iCodigo
'If SQL_Execute(Sql) = 0 Then
'  Do While SQL_Fetch(Datos()) = 0
'   p = p + 1
'   Exit Do
''   SQL = "INSERT INTO INFCUSTODIA VALUES(" & Chr(10)
''   SQL = SQL & Val(Datos(2)) & "," & Chr(10)
''   SQL = SQL & Val(Datos(3)) & "," & Chr(10)
''   SQL = SQL & Val(Datos(4)) & "," & Chr(10)
''   SQL = SQL & Val(Datos(5)) & "," & Chr(10)
''   SQL = SQL & "'" & Datos(6) & "'," & Chr(10)
''   SQL = SQL & "'" & Datos(7) & "'," & Chr(10)
''   SQL = SQL & "'" & Datos(8) & "'," & Chr(10)
''   SQL = SQL & "'" & Datos(9) & "'," & Chr(10)
''   SQL = SQL & Val(Datos(10)) & "," & Chr(10)
''   SQL = SQL & "'" & Val(Datos(1)) & "'," & Chr(10)
''   SQL = SQL & "'" & Datos(12) & "'," & Chr(10)
''   SQL = SQL & "'" & Datos(11) & "'," & Chr(10)
''   SQL = SQL & "'" & Val(Datos(14)) & "'," & Chr(10)
''   SQL = SQL & "'" & Datos(15) & "'," & Chr(10)
''   SQL = SQL & "'" & Datos(16) & "')"
''   db.Execute SQL
'  Loop
'End If
'If p = 0 Then
'  Exit Function
'End If
'Informe_Custodia = True
'End Function


Function Llenar_Voucher() As Boolean
Dim Sql As String
Dim Datos()
Dim p As Integer

p = 0
Sql = "DELETE FROM VOUCHER;"
Llenar_Voucher = False
DB.Execute Sql

'Sql = "Sp_InfVouchers"

If Bac_Sql_Execute("SP_INFVOUCHERS") Then
   
   Do While Bac_SQL_Fetch(Datos())
    
    p = p + 1
     Sql = "INSERT INTO VOUCHER VALUES(" & Chr(10)
     Sql = Sql & Datos(1) & "," & Chr(10)
     Sql = Sql & Datos(2) & "," & Chr(10)
     Sql = Sql & "'" & Datos(3) & "'," & Chr(10)
     Sql = Sql & "'" & Datos(4) & "'," & Chr(10)
     Sql = Sql & Datos(5) & "," & Chr(10)
     Sql = Sql & "'" & Datos(6) & "'," & Chr(10)
     Sql = Sql & "'" & Datos(7) & "'," & Chr(10)
     Sql = Sql & Datos(8) & "," & Chr(10)
     Sql = Sql & "'" & Datos(9) & "'," & Chr(10)
     Sql = Sql & Datos(10) & "," & Chr(10)
     Sql = Sql & "'" & Datos(11) & "'," & Chr(10)
     Sql = Sql & "'" & Datos(12) & "',"
     Sql = Sql & "'" & Datos(13) & "')"
     DB.Execute Sql
   
   Loop

Else
 
 Exit Function

End If

If p = 0 Then
  
  Exit Function

End If

Llenar_Voucher = True

End Function

Function Inf_CertOperVig(nRutcli As Double) As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM MDCOVI;"
    Inf_CertOperVig = True
    DB.Execute Sql
    
    ''''''''''''''''''''''''' Sql = "SP_OPERVIGCERT " + Str(nRutcli)

    Envia = Array()
    
    AddParam Envia, Str(nRutcli)

    If Bac_Sql_Execute("SP_OPERVIGCERT ", Envia) Then
        
        Do While Bac_SQL_Fetch(Datos())
            
            If Datos(1) = "NO" Then
                
                MsgBox Datos(2), vbExclamation, TITSISTEMA
                Inf_CertOperVig = False
                Exit Function
            
            End If
            
            Sql = "INSERT INTO MDCOVI VALUES( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + Datos(2) + "," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + Datos(4) + "," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + "'" + Datos(11) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(12) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(13) + "' );"
            DB.Execute Sql
        
        Loop
    
    Else
        
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        Inf_CertOperVig = False
    
    End If

End Function


Function Inf_OperHisto(nRutcli As Double) As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM MDOPEHI;"
    Inf_OperHisto = True
    DB.Execute Sql
    
    Sql = "SP_OPERHISTORICAS " + Str(nRutcli)
    
    Envia = Array()
    
    AddParam Envia, Str(nRutcli)

    If Bac_Sql_Execute("SP_OPERHISTORICAS") Then
        
        Do While Bac_SQL_Fetch(Datos())
        
            Sql = "INSERT INTO MDOPEHI VALUES( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + Datos(5) + "," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + "'" + Datos(11) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(12) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(13) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(14) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(15) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(16) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(17) + "' );"
            DB.Execute Sql
        
        Loop
    
    Else
        
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        Inf_OperHisto = False
    
    End If

End Function

Function Inf_Tasas(nSw As Integer) As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM MDTASA"
    Inf_Tasas = True
    DB.Execute Sql

    If Bac_Sql_Execute("SP_INFTASAS") Then
        
        Do While Bac_SQL_Fetch(Datos())
            
            Sql = "INSERT INTO MDTASA VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + "'" + Datos(12) + "');"
            DB.Execute Sql
        
        Loop
    
    Else
        
        Inf_Tasas = False
        
        If nSw = 1 Then
            
            MsgBox "Informe no pudo ser Procesado", vbExclamation, TITSISTEMA
        
        End If
    
    End If

End Function

Function Inf_VctoVcDiarios(Entidad As String, nTipRep) As Boolean '** GUILLERMO CONTRERAS **
Dim Sql As String
Dim Datos()
Dim Valor As Integer

    Valor = 0
    
    Sql = "DELETE FROM MDVCD;"
    Inf_VctoVcDiarios = False
    DB.Execute Sql
    
'''''''''''''''''''''''''''    Sql = ""
'''''''''''''''''''''''''''    Sql = "EXECUTE sp_vctosdiarios " & CDbl(Entidad) & ", " & nTipRep
    
    Envia = Array()
    
    AddParam Envia, CDbl(Entidad)
    AddParam Envia, CDbl(nTipRep)
    
    If Bac_Sql_Execute("SP_VCTOSDIARIOS", Envia) Then
  
        Do While Bac_SQL_Fetch(Datos())
            
            Sql = "INSERT INTO mdvcd VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + Datos(4) + "," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + Datos(6) + "," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "', '" & Datos(11) & "'" & Chr(10)
            Sql = Sql + " );"

            DB.Execute Sql
            Valor = 1
            
            Inf_VctoVcDiarios = True
        Loop
    
    Else
        
        MsgBox "Informe no pudo ser Procesado", vbExclamation, TITSISTEMA
    
    End If

    If Valor = 0 Then
        MsgBox "No se registran vencimientos en el día de hoy de " & IIf(nTipRep = 1, "Cupones ", IIf(nTipRep = 2, "Interbancarios ", "Captaciones ")), vbExclamation, TITSISTEMA
    End If
    
End Function


Function LlenaInfoGesPactos(Entidad As String)
Dim Datos()

    gSQL = "DELETE FROM MDGEP;"
    LlenaInfoGesPactos = True
    DB.Execute gSQL
    gSQL = ""
    gSQL = "SP_INFOGESTIONPACTOS "
    gSQL = gSQL & Val(Entidad)
    
    If MISQL.SQL_Execute(gSQL) = 0 Then
        
        Do While MISQL.SQL_Fetch(Datos()) = 0
            
            gSQL = "INSERT INTO MDGEP VALUES( " & Chr(10)
            gSQL = gSQL + "'" + Datos(1) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(2) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(3) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(4) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(5) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(6) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(7) + "'," & Chr(10)
            gSQL = gSQL + Datos(8) + "," & Chr(10)
            gSQL = gSQL + "'" + Datos(9) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(10) + "' );"
            DB.Execute gSQL
        
        Loop
    
    Else
        
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        LlenaInfoGesPactos = False
    
    End If

End Function

Function LlenaInfoGesCVDef(Entidad As String)
Dim Datos()
   Dim a As Double
    gSQL = "DELETE FROM MDGEV;"
    LlenaInfoGesCVDef = True
    DB.Execute gSQL
    gSQL = ""
    gSQL = "SP_INFOGESTIONCVDEF "
    gSQL = gSQL & Val(Entidad)
    If MISQL.SQL_Execute(gSQL) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            a = a + 1
            gSQL = "INSERT INTO MDGEV VALUES ( " & Chr(10)
            gSQL = gSQL + "'" + Datos(1) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(2) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(3) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(4) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(5) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(6) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(7) + "'," & Chr(10)
            gSQL = gSQL + Datos(8) + "," & Chr(10)
            gSQL = gSQL & Val(a) & "," & Chr(10)
            gSQL = gSQL + "'" + Datos(9) + "' );"
            DB.Execute gSQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        LlenaInfoGesCVDef = False
    End If

End Function


Function LlenaInfoOperMes()
Dim Datos()

    LlenaInfoOperMes = True
    DB.Execute "DELETE FROM MDOPEMES;"

    If MISQL.SQL_Execute("SP_INFOPERMES") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            gSQL = "INSERT INTO MDOPEMES VALUES( " & Chr(10)
            gSQL = gSQL + "'" + Datos(1) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(2) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(3) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(4) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(5) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(6) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(7) + "'," & Chr(10)
            gSQL = gSQL + Datos(8) + "," & Chr(10)
            gSQL = gSQL + Datos(9) + "," & Chr(10)
            gSQL = gSQL + Datos(10) + "," & Chr(10)
            gSQL = gSQL + Datos(11) + "," & Chr(10)
            gSQL = gSQL + "'" + Datos(12) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(13) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(14) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(15) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(16) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(17) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(18) + "'," & Chr(10)
            gSQL = gSQL + Datos(19) + " );"
            DB.Execute gSQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        LlenaInfoOperMes = False
    End If

End Function
Function LlenaInfoGesInter()
Dim Datos()

    gSQL = "DELETE FROM MDGEI;"
    LlenaInfoGesInter = True
    DB.Execute gSQL

    If MISQL.SQL_Execute("SP_INFOGESTIONINTER") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            gSQL = "INSERT INTO MDGEI VALUES( " & Chr(10)
            gSQL = gSQL + "'" + Datos(1) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(2) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(3) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(4) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(5) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(6) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(7) + "'," & Chr(10)
            gSQL = gSQL + Datos(8) + "," & Chr(10)
            gSQL = gSQL + Datos(9) + "," & Chr(10)
            gSQL = gSQL + "'" + Datos(10) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(11) + "' );"
            DB.Execute gSQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        LlenaInfoGesInter = False
    End If

End Function

Function LlenaPuntas(nSw As Integer) As Boolean
Dim Sql As String
Dim Datos()
Dim nNum%, cCar$

    nNum = 0
    cCar = " "

    Sql = "DELETE FROM MDPUNTAS"
    LlenaPuntas = False
    DB.Execute Sql

    Sql = "SP_INFPTASPRC " & Chr$(10) & nSw

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            If nSw = 1 Then
                Sql = "INSERT INTO MDPUNTAS VALUES ( " & Chr(10)
                Sql = Sql + "'" + Datos(1) + "'," & Chr(10)     '1  Nomemp
                Sql = Sql + "'" + Datos(2) + "'," & Chr(10)     '2  Rutemp
                Sql = Sql + "'" + Datos(3) + "'," & Chr(10)     '3  Informe
                Sql = Sql + Datos(4) + "," & Chr(10)            '4  Punta
                Sql = Sql + "'" + Datos(5) + "'," & Chr(10)     '5  Instser
                Sql = Sql + "'" + cCar + "'," & Chr(10)         '6  Grupo
                Sql = Sql + Datos(6) + "," & Chr(10)            '7  Nomdis
                Sql = Sql + Datos(8) + "," & Chr(10)            '8  Nomint
                Sql = Sql + Str(nNum) + "," & Chr(10)           '9  Nomstock
                Sql = Sql + "'" + Datos(7) + "'," & Chr(10)     '10 Fecven
                Sql = Sql + Str(nNum) + "," & Chr(10)           '11 Año
                Sql = Sql + Str(nNum) + "," & Chr(10)           '12 Mes
                Sql = Sql + Str(nNum) + "," & Chr(10)           '13 Día
                Sql = Sql + "'" + Datos(9) + "'," & Chr(10)     '15 Fecpro
                Sql = Sql + Datos(10) + "," & Chr(10)           '16 Postotal
                Sql = Sql + "'" + Datos(11) + "');"             '17 Fecprox
            Else
                Sql = "INSERT INTO MDPUNTAS VALUES ( " & Chr(10)
                Sql = Sql + "'" + Datos(1) + "'," & Chr(10)     '1  Nomemp
                Sql = Sql + "'" + Datos(2) + "'," & Chr(10)     '2  Rutemp
                Sql = Sql + "'" + Datos(3) + "'," & Chr(10)     '3  Informe
                Sql = Sql + Datos(4) + "," & Chr(10)            '4  Punta
                Sql = Sql + "'" + Datos(5) + "'," & Chr(10)     '5  Instser
                Sql = Sql + "'" + Datos(6) + "'," & Chr(10)     '6  Grupo
                Sql = Sql + Datos(7) + "," & Chr(10)            '7  Nomdis
                Sql = Sql + Str(nNum) + "," & Chr(10)           '8  Nomint
                Sql = Sql + Datos(12) + "," & Chr(10)           '9  Nomstock
                Sql = Sql + "'" + Datos(8) + "'," & Chr(10)     '10 Fecven
                Sql = Sql + Datos(9) + "," & Chr(10)            '11 Año
                Sql = Sql + Datos(10) + "," & Chr(10)           '12 Mes
                Sql = Sql + Datos(11) + "," & Chr(10)           '13 Día
                Sql = Sql + "'" + Datos(13) + "'," & Chr(10)    '15 Fecpro
                Sql = Sql + Str(nNum) + "," & Chr(10)           '16 Postotal
                Sql = Sql + cCar + "'" + Datos(11) + "');"         '17 Fecprox
            End If
            DB.Execute Sql
        Loop
        LlenaPuntas = True
    Else
        LlenaPuntas = False
        If nSw = 1 Then
            MsgBox "Informe no puede ser Generado", vbExclamation, TITSISTEMA
        End If
    End If

End Function



Function Llenar_Oma(Rectif As String, Observaciones As String) As Boolean
Dim Sql As String
Dim Datos()
Dim Rectificado As String

    If Rectif = True Then
        Rectificado = "S"
    Else
        Rectificado = "N"
    End If

    Sql = "DELETE FROM MD_OMA"
    Llenar_Oma = False
    DB.Execute Sql

    If MISQL.SQL_Execute("EXECUTE SP_OMA 1") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO Md_OMA VALUES( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + Datos(4) + "," & Chr(10)
            Sql = Sql + Datos(5) + "," & Chr(10)
            Sql = Sql + Datos(6) + "," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(11) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(12) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(13) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(14) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(15) + "' );"

            DB.Execute Sql
        Loop
    Else
        MsgBox "Oma no pudo ser Impreso", vbExclamation, TITSISTEMA
        Llenar_Oma = False
        Exit Function
    End If

    Sql = "DELETE FROM MD_OMA2"
    DB.Execute Sql

    If MISQL.SQL_Execute("SP_OMA 2") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = ""
            Sql = "INSERT INTO MD_OMA2 VALUES( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + Datos(4) + "," & Chr(10)
            Sql = Sql + Datos(5) + "," & Chr(10)
            Sql = Sql + Datos(6) + "," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + Datos(16) + "," & Chr(10)
            Sql = Sql + Datos(17) + "," & Chr(10)
            Sql = Sql + Datos(18) + "," & Chr(10)
            Sql = Sql + Datos(19) + "," & Chr(10)
            Sql = Sql + Datos(20) + "," & Chr(10)
            Sql = Sql + Datos(21) + "," & Chr(10)
            Sql = Sql + Datos(22) + "," & Chr(10)
            Sql = Sql + Datos(23) + "," & Chr(10)
            Sql = Sql + Datos(24) + "," & Chr(10)
            Sql = Sql + Datos(25) + "," & Chr(10)
            Sql = Sql + Datos(26) + "," & Chr(10)
            Sql = Sql + Datos(27) + "," & Chr(10)
            Sql = Sql + "'" + Mid$(CStr(Time), 1, 8) + "'" + "," & Chr(10)
            Sql = Sql + "'" + Rectificado + "'," & Chr(10)
            Sql = Sql + "'" + Observaciones + "'," & Chr(10)
            Sql = Sql + Datos(28) + "," & Chr(10)
            Sql = Sql + Datos(29) + "," & Chr(10)
            Sql = Sql + Datos(30) + "," & Chr(10)
            Sql = Sql + Datos(31) + "," & Chr(10)
            Sql = Sql + Datos(32) + "," & Chr(10)
            Sql = Sql + Datos(33) + "," & Chr(10)
            Sql = Sql + Datos(34) + "," & Chr(10)
            Sql = Sql + Datos(35) + " );"
            DB.Execute Sql
        Loop
        Llenar_Oma = True
    Else
        MsgBox "Informe Oma no pudo ser Impreso", vbExclamation, TITSISTEMA
        Llenar_Oma = False
    End If

End Function


Function LlenarPaca(Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarPaca = True
    Sql = "DELETE FROM MDPACA;"
    DB.Execute Sql

    If MISQL.SQL_Execute("SP_PASEPORCAJA " + Doc$) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO MDPACA VALUES ( " & Chr(10)
            Sql = Sql + Datos(1) + "," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + Datos(6) + "," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + "'" + Datos(12) + "'," & Chr(10)
            Sql = Sql + Datos(13) + ");" & Chr(10)
            DB.Execute Sql
        Loop
    Else
        LlenarPaca = False
    End If

End Function
Function LlenarVctoCapVCa() As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM MDVIVC"
    LlenarVctoCapVCa = True
    DB.Execute Sql

    If MISQL.SQL_Execute("SP_VCTOCAPVCAMARA") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            If Datos(1) = "NO" Then
                MsgBox "No existen Vencimientos con Vale Camara", vbExclamation, TITSISTEMA
                LlenarVctoCapVCa = False
                Exit Function
            End If
            Sql = "INSERT INTO MDVIVC VALUES( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + Datos(8) + " );"
            DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no puede ser procesado", vbExclamation, TITSISTEMA
        LlenarVctoCapVCa = False
    End If

End Function

Function LlenarVctoVI() As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM VCTOVI"
    LlenarVctoVI = True
    DB.Execute Sql

    If MISQL.SQL_Execute("SP_INFORMEVCTOVI") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO VCTOVI VALUES ( " & Chr(10)
            Sql = Sql + Datos(1) + "," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'" + "," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'" + "," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'" + "," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'" + "," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'" + "," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + Datos(16) + "," & Chr(10)
            Sql = Sql + Datos(17) + "," & Chr(10)
            Sql = Sql + Datos(18) + "," & Chr(10)
            Sql = Sql + Datos(19) + "," & Chr(10)
            Sql = Sql + Datos(20) + "," & Chr(10)
            Sql = Sql + "'" + Datos(21) + "'," & Chr(10)
            Sql = Sql + Datos(22) + "," & Chr(10)
            Sql = Sql + Datos(23) + "," & Chr(10)
            Sql = Sql + Datos(24) + "," & Chr(10)
            Sql = Sql + Datos(25) + "," & Chr(10)
            Sql = Sql + Datos(26) + "," & Chr(10)
            Sql = Sql + Datos(27) + "," & Chr(10)
            Sql = Sql + Datos(28) + "," & Chr(10)
            Sql = Sql + Datos(29) + "," & Chr(10)
            Sql = Sql + Datos(30) + "," & Chr(10)
            Sql = Sql + Datos(31) + "," & Chr(10)
            Sql = Sql + Datos(32) + "," & Chr(10)
            Sql = Sql + Datos(33) + "," & Chr(10)
            Sql = Sql + Datos(34) + " );"
            DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, TITSISTEMA
        LlenarVctoVI = False
    End If

End Function



Function LlenarVctoCI() As Boolean
Dim Sql As String

Dim Datos()

    Sql = "DELETE FROM CAINTER"
    LlenarVctoCI = True
    DB.Execute Sql

    If MISQL.SQL_Execute("SP_INFORMEVCTOCI") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO CAINTER VALUES( " & Chr(10)
            Sql = Sql + Datos(1) + "," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + "'" + Datos(12) + "'," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + "'" + Datos(15) + "'," & Chr(10)
            Sql = Sql + Datos(1) + " );"
            DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, TITSISTEMA
        LlenarVctoCI = False
    End If

End Function
Function LlenarVctoDEP() As Boolean
Dim Sql As String
Dim Datos()

' se ocupa la misma tabla acces de las cartera de interbancarios y Vcto CI
' por que tiene la misma estructura
' no se puede llegar y modificar la estructura

    Sql = "DELETE FROM CAINTER"
    LlenarVctoDEP = True
    DB.Execute Sql

    If MISQL.SQL_Execute("SP_INFORMEDEP") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO CAINTER VALUES ( " & Chr(10)
            Sql = Sql + Datos(1) + "," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + "'" + Datos(12) + "'," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + "'" + Datos(14) + "'," & Chr(10)
            Sql = Sql + Datos(1) + " );"
            DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, TITSISTEMA
        LlenarVctoDEP = False
    End If

End Function





Function LlenarRCRV(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()
    Sql = "DELETE FROM MDRCRV"
    LlenarRCRV = True
    DB.Execute Sql
    Sql = ""
    Sql = "SP_INFORMERCRV " & Val(Entidad)

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO MDRCRV VALUES( " & Chr(10)
            Sql = Sql + Datos(1) + "," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + "'" + Datos(9) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "' );"
            DB.Execute Sql
            Valor = 1
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        LlenarRCRV = False
    End If
End Function

Function LlenarCartIB(cTipOper As String, Xenti As String) As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM CAINTER"
    LlenarCartIB = True
    DB.Execute Sql

    sql = "EXECUTE SP_INFORMEIB " + cTipOper & "," & Val(Xenti)
    
    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO CAINTER VALUES ( " & Chr(10)
            Sql = Sql + Datos(1) + "," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + "'" + Datos(12) + "'," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + "'" + Datos(15) + "'," & Chr(10)
            Sql = Sql + Datos(16) + "," & Chr(10)
            Sql = Sql + Datos(17) + "," & Chr(10)
            Sql = Sql + Datos(18) + "," & Chr(10)
            Sql = Sql + Datos(19) + "," & Chr(10)
            Sql = Sql + Datos(20) + "," & Chr(10)
            Sql = Sql + Datos(21) + "," & Chr(10)
            Sql = Sql + Datos(22) + ");"
           DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        LlenarCartIB = False
    End If

End Function
Function LlenarCartCaptacion(Entidad As String) As Boolean
Dim cSql As String
Dim Datos()
Dim HayDatos As Boolean

    cSql = "DELETE FROM CARTCAPTA"
    LlenarCartCaptacion = False
    HayDatos = False
    
    DB.Execute cSql

    cSql = "EXECUTE SP_LISTCARTCAPTACION " & Val(Entidad)
    
    If MISQL.SQL_Execute(cSql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            cSql = "INSERT INTO CARTCAPTA VALUES ( " & Chr(10)
            cSql = cSql & "'" & Datos(1) & IIf(Trim$(Datos(20)) = "V", " * ", "") & "'," & Chr(10)
            cSql = cSql & "'" & Datos(2) + "'," & Chr(10)
            cSql = cSql & "'" & Datos(3) & "'," & Chr(10)
            cSql = cSql & Datos(4) + "," & Chr(10)
            cSql = cSql & Datos(5) + "," & Chr(10)
            cSql = cSql & Datos(6) + "," & Chr(10)
            cSql = cSql & Datos(7) + "," & Chr(10)
            cSql = cSql & "'" & Datos(8) & "'," & Chr(10)
            cSql = cSql & "'" & Datos(9) & "'," & Chr(10)
            cSql = cSql & Datos(10) & "," & Chr(10)
            cSql = cSql & Datos(11) & "," & Chr(10)
            cSql = cSql & Datos(12) + "," & Chr(10)
            cSql = cSql + Datos(13) + "," & Chr(10)
            cSql = cSql + Datos(14) + "," & Chr(10)
            cSql = cSql & Datos(15) & "," & Chr(10)
            cSql = cSql & Datos(16) & "," & Chr(10)
            cSql = cSql & "'" & Datos(17) & "'," & Chr(10)
            cSql = cSql & "'" & Datos(18) & "'," & Chr(10)
            cSql = cSql & "'" & Datos(19) & "'," & Chr(10)
            cSql = cSql & "'" & Datos(21) & "');"
            
            DB.Execute cSql
            
            HayDatos = True
        Loop
    Else
       Exit Function
    End If
    
    
    If Not HayDatos Then
       MsgBox "No existen datos para imprimir el reporte", vbOKOnly + vbExclamation, TITSISTEMA
       Exit Function
    End If
       
    LlenarCartCaptacion = True
End Function
Function LlenarMovCaptacion(Entidad As String) As Boolean
Dim cSql As String
Dim Datos()
Dim nValor As Integer

    nValor = 0
    cSql = "DELETE FROM CARTCAPTA"
    LlenarMovCaptacion = True
    
    DB.Execute cSql

    cSql = "EXECUTE SP_LISTMOVCAPTACION " & Val(Entidad)
    
    If MISQL.SQL_Execute(cSql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            cSql = "INSERT INTO CARTCAPTA VALUES ( " & Chr(10)
            cSql = cSql & "'" & Trim$(Datos(1)) & "'," & Chr(10)
            cSql = cSql & "'" & Datos(2) + "'," & Chr(10)
            cSql = cSql & "'" & Datos(3) & "'," & Chr(10)
            cSql = cSql & Datos(4) + "," & Chr(10)
            cSql = cSql & Datos(5) + "," & Chr(10)
            cSql = cSql & Datos(6) + "," & Chr(10)
            cSql = cSql & Datos(7) + "," & Chr(10)
            cSql = cSql & "'" & Datos(8) & "'," & Chr(10)
            cSql = cSql & "'" & Datos(9) & "'," & Chr(10)
            cSql = cSql & Datos(10) & "," & Chr(10)
            cSql = cSql & Datos(11) & "," & Chr(10)
            cSql = cSql & Datos(12) + "," & Chr(10)
            cSql = cSql + Datos(13) + "," & Chr(10)
            cSql = cSql + Datos(14) + "," & Chr(10)
            cSql = cSql & Datos(15) & "," & Chr(10)
            cSql = cSql & Datos(16) & "," & Chr(10)
            cSql = cSql & "'" & Datos(17) & "'," & Chr(10)
            cSql = cSql & "'" & Datos(18) & "'," & Chr(10)
            cSql = cSql & "'" & Datos(19) & "'," & Chr(10)
            cSql = cSql & "'" & Datos(20) & "');"
            nValor = 1
            DB.Execute cSql
        Loop
    Else
        LlenarMovCaptacion = False
    End If
    If nValor = 0 Then
        LlenarMovCaptacion = False
        MsgBox "No se registran operaciones de captaciones", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
End Function


Function Llenar_Cert1(dRutcli As Double, iAno As Integer) As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM CERTIFICADO1"
    Llenar_Cert1 = False
    DB.Execute Sql

    Sql = "SP_L0100 1, " + Str(iAno) + "," + Str(dRutcli)

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO CERTIFICADO1 VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + Datos(2) + "," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + Datos(4) + "," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + Datos(6) + "," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + "'" + Datos(9) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(11) + "'," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + Datos(16) + "," & Chr(10)
            Sql = Sql + Datos(17) + "," & Chr(10)
            Sql = Sql + Datos(18) + "," & Chr(10)
            Sql = Sql + "'" + Datos(19) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(20) + "'," & Chr(10)
            Sql = Sql + Datos(21) + "," & Chr(10)
            Sql = Sql + "'" + Datos(22) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(23) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(24) + "'," & Chr(10)
            Sql = Sql + Datos(25) + " );"
            DB.Execute Sql
            Llenar_Cert1 = True
        Loop
        If Llenar_Cert1 = False Then
            MsgBox "Cliente no registra operacciones para procesar", vbInformation, TITSISTEMA
        End If
    Else
        MsgBox "Certificado no pudo ser Impreso", vbExclamation, TITSISTEMA
        Llenar_Cert1 = False
    End If

End Function


Sub LlamaListados(sdesde$, sHasta$, sList$, nEntidad As Double, nTipoReport As Integer)
   Dim TitRpt As String
   Screen.MousePointer = vbHourglass
   Call limpiar_cristal
   BACSwapParametros.BACParam.Destination = crptToWindow
   BACSwapParametros.BACParam.Connect = SwConeccion
   
   Select Case nTipoReport
      
      Case Is = 1: TitvRpt = "VENCIMIENTOS DE CUPONES"
      Case Is = 2: TitvRpt = "VENCIMIENTOS DE INTERBANCARIOS"
      Case Is = 3: TitvRpt = "VENCIMIENTOS DE CAPTACIONES"
   
   End Select
      
      
   Select Case sList$
         
      
      Case Is = "VCTOPACT" 'Proceso OK
         
         'Nombre llamada     : LlenarVctoPact
         'Proced. Almacenado : sp_listvctopact
      
         TitRpt = "VENCIMIENTO DE PACTOS DEL " & Format(sdesde$, "dd/mm/yyyy") & " AL " & Format(sHasta$, "dd/mm/yyyy")
         BacTrader.bacrpt.ReportFileName = RptList_Path & "VCTOPACT.RPT"
         BacTrader.bacrpt.StoredProcParam(0) = Format(sdesde$, "dd/mm/yyyy")
         BacTrader.bacrpt.StoredProcParam(1) = Format(sHasta$, "dd/mm/yyyy")
         BacTrader.bacrpt.StoredProcParam(2) = nEntidad
         BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
    
      Case Is = "VCTOPAP" ' Proceso OK
           
         'Nombre llamada     : LlenarVctoPap
         'Proced. Almacenado : sp_infconvcto
         
         TitRpt = "VCTO. CARTERA PROPIA DEL " & Format(sdesde$, "dd/mm/yyyy") & " AL " & Format(sHasta$, "dd/mm/yyyy")
         BacTrader.bacrpt.ReportFileName = RptList_Path & "VCTOPAP.RPT"
         BacTrader.bacrpt.StoredProcParam(0) = Format(sdesde$, "dd/mm/yyyy")
         BacTrader.bacrpt.StoredProcParam(1) = Format(sHasta$, "dd/mm/yyyy")
         BacTrader.bacrpt.StoredProcParam(2) = nEntidad
         BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
             
      Case Is = "VALMON"
         
           '  If sList$ = "VALMON" Then
                 'If Llenar_Parametros("VALORES DE MONEDAS DEL " & sdesde$ & " AL " & sHasta$) Then
               If LlenarValoresMonedas((sdesde$), (sHasta$)) Then
                    'TitRpt = "MOVIMIENTO DIARIO DE COMPRAS CON PACTO"
                    TitRpt = "VALORES DE MONEDAS DEL " & sdesde$ & " AL " & sHasta$
                    BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacValoresMonedas.RPT"
                   ' BACSwapParametros.BACParam.WindowTitle = "LISTADO DE MONEDAS POR VALORES"
                    BACSwapParametros.BACParam.StoredProcParam(0) = Format(sdesde$, "yyyymmdd")
                    BACSwapParametros.BACParam.StoredProcParam(1) = Format(sHasta$, "yyyymmdd")
                   ' BACSwapParametros.BACParam.Formulas(0) = "tit='" & TitRpt & "'"
               End If
   
      Case Is = "VCTODIA" ' Proceso OK
      
           'Nombre llamada     : Inf_VctoVcDiarios
           'Proced. Almacenado : sp_vctosdiarios
      
           TitRpt = "REPORTE DE VENCIMIENTOS DEL DÍA "
           BacTrader.bacrpt.ReportFileName = RptList_Path & "MDVCD.RPT"
           BacTrader.bacrpt.StoredProcParam(0) = nEntidad
           BacTrader.bacrpt.StoredProcParam(1) = nTipoReport
           BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
           BacTrader.bacrpt.Formulas(1) = "titv='" & TitvRpt & "'"
   
   End Select
   
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Action = 1
   Call Grabar_Log("BTR", gsBAC_User, gsbac_fecp, "Impresión " & TitRpt)
    
   Screen.MousePointer = vbDefault
  
End Sub

Function LlenarMDCI(xent As String, cartera As String) As Boolean
Dim Sql As String
Dim Datos()
Dim Valor As Single
Valor = 0
    LlenarMDCI = False
    DB.Execute "DELETE FROM MDINFOCI;"
    Sql = "SP_INFOCI "
    Sql = Sql + "'" + cartera + "',"
    Sql = Sql & Val(xent) & ","
    Sql = Sql + "'N'"
    
    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
           Sql = "INSERT INTO MDINFOCI VALUES ( " & Chr(10)
           Sql = Sql + "'" + IIf(cartera = "112", Datos(1), Trim(Str(Val(Datos(2)))) + " / " + Datos(1)) + "'," & Chr(10)   'Numero operacion
           Sql = Sql + "'" + Datos(3) + "'," & Chr(10)                          'Serie
           Sql = Sql + "'" + Datos(4) + "'," & Chr(10)                          'Fecha Vencimiento
           Sql = Sql + Datos(5) + "," & Chr(10)                                 'Nominal
           Sql = Sql + Datos(6) + "," & Chr(10)                                 'TIR
           Sql = Sql + "'" + Datos(7) + "'," & Chr(10)                          'Moneda del Pacto
           Sql = Sql + "'" + Datos(8) + "'," & Chr(10)                          'Fecha Inicio Pacto
           Sql = Sql + "'" + Datos(9) + "'," & Chr(10)                          'Fecha Vencimiento Pacto
           Sql = Sql + Datos(10) + "," & Chr(10)                               'Plazo
           Sql = Sql + Datos(11) + "," & Chr(10)                                'Valor Inicial
           Sql = Sql + Datos(12) + "," & Chr(10)                                'Valor Final
           Sql = Sql + Datos(13) + "," & Chr(10)                                'Tasa del Pacto
           Sql = Sql + Datos(14) + "," & Chr(10)                                'Interes
           Sql = Sql + Datos(15) + "," & Chr(10)                                'Reajuste
           Sql = Sql + Datos(16) + "," & Chr(10)                                'Intereses Acumulados
           Sql = Sql + Datos(17) + "," & Chr(10)                                'Reajustes Acumulados
           Sql = Sql + "'" + Datos(18) + "'," & Chr(10)                         'Familia
           Sql = Sql + "'" + Datos(19) + "'," & Chr(10)                         'Entidad
           Sql = Sql + "'" + Datos(20) + "'," & Chr(10)                         'Valor Presente
           Sql = Sql + Datos(21) + ","                                                  'Moneda de Emisión
           Sql = Sql + "'" + Datos(22) + "',"                                         'Rut
           Sql = Sql + "'" + Datos(23) + "')"                                        'Nombre
            DB.Execute Sql
            Valor = 1
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbOKOnly + vbCritical, TITSISTEMA
        Exit Function
    End If
    If Valor = 0 Then
        MsgBox "No hay datos para imprimir informe", vbOKOnly + vbExclamation, TITSISTEMA
        Exit Function
    End If
 
 LlenarMDCI = True
End Function



Function LlenarValoriza() As Boolean
Dim Sql As String
Dim Datos()

    LlenarValoriza = True
    Sql = "DELETE FROM VALORIZA;"
    DB.Execute Sql
    
    If Month(gsbac_fecp) <> Month(gsBac_Fecx) Then
        dFech2 = CDate("01/" + Str(Month(gsBac_Fecx)) + "/" + Str(Year(gsBac_Fecx)))
        dFech1 = DateAdd("d", -1, dFech2)
        cFeccal$ = Trim(Str(Month(dFech1))) + "/" + Trim(Str(Day(dFech1))) + "/" + Trim(Str(Year(dFech1)))
    Else
        cFeccal$ = Trim(Str(Month(gsbac_fecp))) + "/" + Trim(Str(Day(gsbac_fecp))) + "/" + Trim(Str(Year(gsbac_fecp)))
    End If
    

    Sql = "SP_SBIF_INFVAL '" + Format(cFeccal$, "mm/dd/yyyy") + "'"

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO VALORIZA VALUES(  " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + "'" + Datos(11) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(12) + "'," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + Datos(16) + "," & Chr(10)
            Sql = Sql + Datos(17) + "," & Chr(10)
            Sql = Sql + Datos(18) + "," & Chr(10)
            Sql = Sql + Datos(19) + " );"
            DB.Execute Sql
        Loop
    Else
        LlenarValoriza = False
        MsgBox "Informe de Valorización Mercado, No puede ser Impreso", vbExclamation, TITSISTEMA
    End If

End Function

Function LlenarVctoPap(sdesde$, sHasta$, xentidad As Double) As Boolean
Dim Sql As String
Dim Datos()
Dim xValor  As String: xValor = 0

    LlenarVctoPap = False
    
    Sql = "DELETE FROM VCTOPROPIO;"
    DB.Execute Sql

' VB+ 18/05/2000    Sql = "EXECUTE sp_listadovctopap  "

    sql = "EXECUTE SP_INFCONVCTO  "
    sql = sql + "'" + Format(sdesde, "dd/mm/yyyy") + "','" + Format(sHasta, "dd/mm/yyyy") + "'," & xentidad

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO VCTOPROPIO VALUES(  " & Chr(10)
            Sql = Sql & "'" & Datos(1) & "'," & Chr(10)                 'Tipo de Reporte
            Sql = Sql & "'" & CDbl(Datos(2)) & "'," & Chr(10)         'Numero Operación
            Sql = Sql & "'" & Val(Datos(3)) & "'," & Chr(10)           'Correlativo
            Sql = Sql & "'" + Datos(4) & "'," & Chr(10)                  'Instrumento
            Sql = Sql & Datos(5) + "," & Chr(10)                          'Nominal
            Sql = Sql & Datos(6) + "," & Chr(10)                          'Flujo
            Sql = Sql & "'" & Format(Datos(7), "mm/dd/yyyy") & "'," & Chr(10)  'Fecha de Vencimiento
            Sql = Sql & IIf(Val(Datos(8)) = 0, 1, Val(Datos(8))) & "," & Chr(10) 'N° de Cupon
            Sql = Sql & IIf(Val(Datos(9)) = 0, 1, Val(Datos(9))) & "," & Chr(10) 'Total de Cupones
            Sql = Sql & "'" & Datos(10) & "'," & Chr(10)                'Moneda
            Sql = Sql & "'" & Format(Datos(11), "mm/dd/yyyy") & "'," & Chr(10)  'Fecha de Venta
            Sql = Sql & "'" + Datos(12) & "'," & Chr(10)                'Tipo de Operación
            Sql = Sql & Datos(13) + "," & Chr(10)                       'Flujo en UM
            Sql = Sql & "'" & Format(Datos(14), "mm/dd/yyyy") + "'," & Chr(10)  'Fecha de Emisión
            Sql = Sql & Datos(15) + "," & Chr(10)                       'Tasa de Emisión
            Sql = Sql & Datos(16) + "," & Chr(10)                       'Tir de Compra
            Sql = Sql & "'" & Format(Datos(17), "mm/dd/yyyy") + "'," & Chr(10) 'Fecha de Pago
            Sql = Sql & Datos(18) & "," & Chr(10)                       'Tipo de cambio
            Sql = Sql & Datos(19) & "," & Chr(10)                       'Flujo en Pesos
            Sql = Sql & "'" & Datos(20) + "'," & Chr(10)                'Emisor
            Sql = Sql & "'" & Datos(21) + "'," & Chr(10)                'Familia
            Sql = Sql & "'" & Datos(22) + "' );" & Chr(10)              'Entidad
            DB.Execute Sql
            xValor = 1
        Loop
    Else
        Exit Function
    End If
    
    If xValor = 0 Then
        MsgBox "No se encontró información de vencimientos de papeles en el rango seleccionado ", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    LlenarVctoPap = True
    
End Function

Function LlenarVctoPact(Ddesde As String, dHasta As String, xentidad As Double) As Boolean
Dim Sql As String
Dim Datos()
Dim xValor  As Integer: xValor = 0

    LlenarVctoPact = False
    
    Sql = "DELETE FROM VCTOPACT;"
    DB.Execute Sql

    sql = "EXECUTE SP_LISTADOVCTOPACT "
    sql = sql & "'" & Format(Ddesde, "dd/mm/yyyy") & "','" & Format(dHasta, "dd/mm/yyyy") & "',"
    sql = sql & xentidad
    

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO VCTOPACT VALUES (  " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(9) + "'," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + "'" + Datos(12) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(13) + "'," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + Datos(16) + "," & Chr(10)
            Sql = Sql + Datos(17) + "," & Chr(10)
            Sql = Sql + Datos(18) + "," & Chr(10)
            Sql = Sql + "'" + Datos(19) + "');"
            DB.Execute Sql
            xValor = 1
        Loop
    Else
        Exit Function
    End If
    
    If xValor = 0 Then
        MsgBox "No se encontró información de vencimientos de compromisos en el rango seleccionado ", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    LlenarVctoPact = True

End Function




Function LlenarCI(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()
Dim Valor As Single: Valor = 0

    LlenarCI = False

    Sql = "DELETE FROM MDCILIST;"
    DB.Execute Sql
    
    sql = ""
    sql = "EXECUTE SP_LISTADOCI "
    sql = sql & Val(Entidad)

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = ""
            Sql = "INSERT INTO MDCILIST(cliente, cartera,tipcart,numdocu,serie,emisor,fecemi,fecven,tasemi,base,monemi,nominal,tir,"
            Sql = Sql & "pvc,tasest,vcompra,fecinip,fecvenp,tasapacto,basepacto,monpacto,valinip,valvenp,forpai,forpav,familia) VALUES ( " & Chr(10)
            Sql = Sql & "'" & Datos(1) & "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + "'" + Datos(11) + "'," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + Datos(16) + "," & Chr(10)
            Sql = Sql + "'" + Datos(17) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(18) + "'," & Chr(10)
            Sql = Sql + Datos(19) + "," & Chr(10)
            Sql = Sql + Datos(20) + "," & Chr(10)
            Sql = Sql + "'" + Datos(21) + "'," & Chr(10)
            Sql = Sql + Datos(22) + "," & Chr(10)
            Sql = Sql + Datos(23) + "," & Chr(10)
            Sql = Sql + "'" + Datos(24) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(25) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(26) + "' );"
            DB.Execute Sql
            Valor = 1
        Loop
    End If
    
    
    If Valor = 0 Then
        MsgBox "No se encontro información correspondiente a operaciones de Compras con Pacto.", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    LlenarCI = True
      
End Function
Function LlenarValoresMonedas(xDesde As Date, xHasta As Date) As Boolean
Dim Sql As String
Dim Datos()
'SQL = "delete  from ListMDVM;"
LlenarValoresMonedas = False
'db.Execute SQL

sql = "SP_LISTVALORESMONEDAS '" & Format(xDesde, "yyyymmdd") & "','" & Format(xHasta, "yyyymmdd") & "'"
If MISQL.SQL_Execute(sql) = 0 Then
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
            MsgBox "Informe no pudo ser procesado, Intente más tarde", vbExclamation, TITSISTEMA
End If

End Function

Function LlenarTablasGenerales() As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM LISTTABG;"
    LlenarTablasGenerales = True
    DB.Execute Sql

    If MISQL.SQL_Execute("SP_LISTTABLASGENERALES") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
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
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        LlenarTablasGenerales = False
    End If

End Function

Function LlenarFamilias() As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM MANTFAMILIA;"
    LlenarFamilias = True
    DB.Execute Sql

    If MISQL.SQL_Execute("execute SP_LISTMANTFAMILIA") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
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
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        LlenarFamilias = False
    End If

End Function


Function LlenarClientes() As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM CLIENTE;"
    LlenarClientes = True
    DB.Execute Sql

    If MISQL.SQL_Execute("EXECUTE SP_LISTCLIENTES") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
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
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        LlenarClientes = False
    End If

End Function

Function LlenarCarteras() As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM CARTERAS;"
    LlenarCarteras = True
    DB.Execute Sql

    If MISQL.SQL_Execute("SP_LISTCARTERAS") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO CARTERAS VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + Datos(5) + "," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(9) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "');"
            DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        LlenarCarteras = False
    End If

End Function


Function LlenarEmisores() As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM EMISOR;"
    LlenarEmisores = True
    DB.Execute Sql

    If MISQL.SQL_Execute("SP_LISTEMISORES") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
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
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        LlenarEmisores = False
    End If

End Function



Function LlenarTM() As Boolean
Dim Datos()

    LlenarTM = True
    DB.Execute "DELETE FROM TASAMERCADO;"

    If MISQL.SQL_Execute("SP_SBIF_INFTASAMER") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO TASAMERCADO VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(9) & "," & Chr(10)
            Sql = Sql + Datos(10) & "" & Chr(10)
            Sql = Sql + ");"
            DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        LlenarTM = False
    End If

End Function




Function LlenarVI(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()
Dim Valor As Integer: Valor = 0

    LlenarVI = False

    Sql = "DELETE FROM MDVI;"
    DB.Execute Sql
    
    
    sql = " EXECUTE SP_LISTADOVI "
    sql = sql & Val(Entidad)
    
    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO MDVI( cliente,cartera,tipcart,numdocu,serie,emisor,fecemi,fecven,tasemi,base,monemi,nominal,tir,pvp,tasest,venta,"
            Sql = Sql & "fecinip,fecvenp,tasapacto,basepacto,monpacto,valinip,valvenp,forpai,forpav,familia,numoper) VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + "'" + Datos(11) + "'," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + Datos(16) + "," & Chr(10)
            Sql = Sql + "'" + Datos(17) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(18) + "'," & Chr(10)
            Sql = Sql + Datos(19) + "," & Chr(10)
            Sql = Sql + Datos(20) + "," & Chr(10)
            Sql = Sql + "'" + Datos(21) + "'," & Chr(10)
            Sql = Sql + Datos(22) + "," & Chr(10)
            Sql = Sql + Datos(23) + "," & Chr(10)
            Sql = Sql + "'" + Datos(24) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(25) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(26) + "'," & Chr(10)
            Sql = Sql + "'" & CDbl(Datos(27)) & "' );"
 '           Sql = Sql + "'" + Datos(27) + "' );"
            DB.Execute Sql
            Valor = 1
        Loop
    End If
    
    If Valor = 0 Then
        MsgBox "No se encontro información correspondiente a operaciones de Ventas con Pacto.", vbExclamation, TITSISTEMA
        Exit Function
    End If
       
    LlenarVI = True
    
End Function


Function LlenarIB(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()
Dim Valor As Single: Valor = 0


    LlenarIB = False

    Sql = "DELETE FROM MDIB;"
    DB.Execute Sql
    
    sql = "EXECUTE SP_LISTADOIB " & Val(Entidad)
    
    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO MDIB VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + CStr(Val(Datos(7))) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(11) + "'," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + Datos(16) + "," & Chr(10)
            Sql = Sql + "'" + Datos(17) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(18) + "','" + Datos(19) + "' );"
            DB.Execute Sql
            Valor = 1
        Loop
    End If
    
    
    If Valor = 0 Then
        MsgBox "No se encontro información correspondiente a operaciones de Interbancarios", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    LlenarIB = True
    
End Function

Function LlenarCUCP(Entidad As String) As Boolean
Dim Datos()

    LlenarCUCP = True
    gSQL = "DELETE FROM CUCP;"
    DB.Execute gSQL
    gSQL = "EXECUTE SP_LISTADOCUCP " & Val(Entidad)
    If MISQL.SQL_Execute(gSQL) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            gSQL = "INSERT INTO CUCP VALUES ( " & Chr(10)
            gSQL = gSQL + "'" + Datos(1) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(2) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(3) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(4) + "'," & Chr(10)
            gSQL = gSQL + Datos(5) + "," & Chr(10)
            gSQL = gSQL + Datos(6) + "," & Chr(10)
            gSQL = gSQL + Datos(7) + "," & Chr(10)
            gSQL = gSQL + Datos(8) + ",' " & Datos(9) & "','" & Datos(10) & "','" & Datos(11) & "'  );"
            DB.Execute gSQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        LlenarCUCP = False
    End If

End Function


Function LlenarVP(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()
Dim Valor As Integer: Valor = 0

    LlenarVP = False

    Sql = "DELETE FROM MDVP;"
    DB.Execute Sql
    
    
    sql = "EXECUTE SP_LISTADOVP "
    sql = sql & Val(Entidad)
   
    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = ""
            Sql = "INSERT INTO MDVP(cliente,cartera,tipcart,numdocu,serie,emisor,fecemi,fecven,tasemi,"
            Sql = Sql & "base,moneda,nominal,tir,pvp,tasest,mtops,valventa,utilidad,forpa,tipcust,phoy,familia,numoper) VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + "'" + Datos(11) + "'," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + Datos(16) + "," & Chr(10)
            Sql = Sql + Datos(17) + "," & Chr(10)
            Sql = Sql + Datos(18) + "," & Chr(10)
            Sql = Sql + "'" + Datos(19) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(20) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(21) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(22) + "'," & Chr(10)
            Sql = Sql + Datos(23) + " );"
            DB.Execute Sql
            Valor = 1
        Loop
    End If
    
    If Valor = 0 Then
        MsgBox "No se encontró información correspondiente a operaciones de Ventas definitivas", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    LlenarVP = True
     
End Function


Function LlenarAN(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()
Dim Valor As Integer: Valor = 0

    LlenarAN = False

    Sql = "DELETE FROM MDAN;"
    DB.Execute Sql
    
    
    sql = "EXECUTE SP_LISTADOAN " & Val(Entidad)
    
    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO MDAN VALUES( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + "'" + Datos(13) + "','" + Datos(14) + "','" + Datos(15) + "' );"
            DB.Execute Sql
            Valor = 1
        Loop
    End If
    
    If Valor = 0 Then
        MsgBox "No se encontro información correspondiente a operaciones Anuladas.", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    LlenarAN = True

End Function

Function LlenarRC(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()
Dim Valor As Integer: Valor = 0

    LlenarRC = False
    
    Sql = "DELETE FROM MDRC;"
    DB.Execute Sql
    
    sql = "EXECUTE SP_LISTADORC " & Val(Entidad)

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO MDRC VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + "'" + Datos(13) + "'," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + "'" + Datos(16) + "'," & Chr(10)
            Sql = Sql + Datos(17) + "," & Chr(10)
            Sql = Sql + Datos(18) + "," & Chr(10)
            Sql = Sql + "'" + Datos(19) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(20) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(21) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(22) + "', '" & Datos(23) & "'," & Datos(24) & " );"
           DB.Execute Sql
           Valor = 1
        Loop
    End If
    
    If Valor = 0 Then
        MsgBox "No se encontro información correspondiente a operaciones de Recompras", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    LlenarRC = True
    
End Function

'Nuevas Funcion Aderidas (Inicio): Marcos Jimenez
'---------------------------------
'---------------------------------
Function Inf_VctoVcPactos(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()
    Sql = "DELETE FROM CAINTER;"
    Inf_VctoVcPactos = True
    DB.Execute Sql
    Sql = "SP_INFORMEVCTOCI " & Val(Entidad)
    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO CAINTER VALUES( " & Chr(10)
            Sql = Sql + Datos(1) + "," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + "'" + Datos(12) + "'," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + "'" + Datos(15) + "'," & Chr(10)
            Sql = Sql + Datos(1) + " );"
            DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, TITSISTEMA
        Inf_VctoVcPactos = False
    End If

End Function
Function Inf_VctoVvPactos(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM VCTOVI"
    Inf_VctoVvPactos = True
    DB.Execute Sql
    Sql = "SP_INFORMEVCTOVI " & Val(Entidad)
    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO VCTOVI VALUES ( " & Chr(10)
            Sql = Sql + Datos(1) + "," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'" + "," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'" + "," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'" + "," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'" + "," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'" + "," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + Datos(16) + "," & Chr(10)
            Sql = Sql + Datos(17) + "," & Chr(10)
            Sql = Sql + Datos(18) + "," & Chr(10)
            Sql = Sql + Datos(19) + "," & Chr(10)
            Sql = Sql + Datos(20) + "," & Chr(10)
            Sql = Sql + "'" + Datos(21) + "'," & Chr(10)
            Sql = Sql + Datos(22) + "," & Chr(10)
            Sql = Sql + Datos(23) + "," & Chr(10)
            Sql = Sql + Datos(24) + "," & Chr(10)
            Sql = Sql + Datos(25) + "," & Chr(10)
            Sql = Sql + Datos(26) + "," & Chr(10)
            Sql = Sql + Datos(27) + "," & Chr(10)
            Sql = Sql + Datos(28) + "," & Chr(10)
            Sql = Sql + Datos(29) + "," & Chr(10)
            Sql = Sql + Datos(30) + "," & Chr(10)
            Sql = Sql + Datos(31) + "," & Chr(10)
            Sql = Sql + Datos(32) + "," & Chr(10)
            Sql = Sql + Datos(33) + "," & Chr(10)
            Sql = Sql + Datos(34) + " );"
            DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, TITSISTEMA
        Inf_VctoVvPactos = False
    End If
End Function





Function LlenarRV(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()
Dim Valor As Integer: Valor = 0

    LlenarRV = False

    Sql = "DELETE FROM MDRV;"
    DB.Execute Sql
    
    sql = "EXECUTE SP_LISTADORV " & Val(Entidad)
    
    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO MDRV VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + "'" + Datos(13) + "'," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + "'" + Datos(16) + "'," & Chr(10)
            Sql = Sql + Datos(17) + "," & Chr(10)
            Sql = Sql + Datos(18) + "," & Chr(10)
            Sql = Sql + "'" + Datos(19) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(20) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(21) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(22) + "', '" & Datos(23) & "'," & Datos(24) & " );"
           DB.Execute Sql
           Valor = 1
        Loop
    End If
    
    If Valor = 0 Then
        MsgBox "No se encontro información correspondiente a operaciones de Reventas", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    LlenarRV = True
    
End Function









Function Llenarmdb(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()
Dim Valor As Integer: Valor = 0
    
    Llenarmdb = False
    Sql = "DELETE FROM MOVMDCP;"
    DB.Execute Sql
    
    sql = ""
    sql = "EXECUTE SP_LISTCP " & Val(Entidad)
    
    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO MOVMDCP VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "','" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "','" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "','" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "','" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," + Datos(10) + "," & Chr(10)
            Sql = Sql + "'" + Datos(11) + "'," + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," + Datos(16) + "," & Chr(10)
            Sql = Sql + Datos(17) + ",'" + Datos(18) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(19) + "','" + Datos(20) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(21) + "','" + Datos(22) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(23) + "','" + Format(gsbac_fecp, "dd/mm/yyyy") + "','" + Datos(25) + "' );"
            DB.Execute Sql
            Valor = 1
        Loop
    End If
    
    If Valor = 0 Then
        MsgBox "No se encontro información correspondiente a operaciones de Compras Propias", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    Llenarmdb = True
    
End Function

Function LlenarINFOMDSE(cSerie$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarINFOMDSE = True
    
    'SQL = "SP_INFOMDSE '" + cSerie$ + "'"
    sql = "SP_INFOR_SERIES '" + cSerie$ + "'"
    
    If MISQL.SQL_Execute(Sql) = 0 Then
      
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
        LlenarINFOMDSE = False
    End If

End Function


Function ImprimePapeleta(sRutCart$, sNumoper$, sTipoper$, sOpT$) As String

On Error GoTo ErrPrinter

    ImprimePapeleta = "SI"
    gsTipoPapeleta = "P"
    Call limpiar_cristal
    
    BacTrader.bacrpt.Destination = gsBac_Papeleta 'crptToWindow

    If sTipoper = "CI" Then
        'If LlenarPAMDCI(sRutCart$, sNumoper$) Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDCI1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
        'Else
            'ImprimePapeleta = "NO"
       ' End If
    ElseIf sTipoper = "CP" Then
        'If LlenarPAMDCP(sRutCart$, sNumoper$) Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDCP1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
            BacTrader.bacrpt.Action = 1
        'Else
        '    ImprimePapeleta = "NO"
        'End If
    ElseIf sTipoper = "VP" Then
        'If LlenarPAMDVP(sRutCart$, sNumoper$, sTipoper) Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDVP1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.StoredProcParam(3) = sTipoper
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
        'Else
        '    ImprimePapeleta = "NO"
       ' End If
    ElseIf sTipoper = "VI" Then
        'If LlenarPAMDVI(sRutCart$, sNumoper$) Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDVI1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
         
       ' Else
        '    ImprimePapeleta = "NO"
       ' End If
    ElseIf sTipoper = "IB" Then
      ''If LlenarPAINTER(sRutCart$, sNumoper$) Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAINTER.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Formulas(0) = "Titulo = '" & "" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
      ''       BacTrader.bacrpt.Action = 1
      ''   Else
      ''       ImprimePapeleta = "NO"
      ''   End If
     
    ElseIf sTipoper = "RCA" Then
        ''If LlenarPAMDRCA(sRutCart$, sNumoper$) Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDRCA.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
            
            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
        ''    BacTrader.bacrpt.Action = 1
        ''Else
        ''    ImprimePapeleta = "NO"
        ''End If
    ElseIf sTipoper = "RVA" Then
      ''  If LlenarPAMDRVA(sRutCart$, sNumoper$) Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDRVA.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
        
           ' BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
      ''      BacTrader.bacrpt.Action = 1
      ''  Else
      ''      ImprimePapeleta = "NO"
      ''  End If
    ElseIf sTipoper = "ST" Then
        If LlenarPAMDVP(sRutCart$, sNumoper$, sTipoper) Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDST.RPT"
     'no va      * BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
            BacTrader.bacrpt.Action = 1
        Else
            ImprimePapeleta = "NO"
        End If
    ElseIf sTipoper = "IC" Then
        'If LlenarPACAPTA(sRutCart$, sNumoper$, "") Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PACAPTA1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sNumoper$
            BacTrader.bacrpt.Connect = CONECCION
            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
            BacTrader.bacrpt.Action = 1
        'Else
        '    ImprimePapeleta = "NO"
        'End If
    ElseIf sTipoper = "AC" Then
        If LlenarPACAPTAANT(sRutCart$, sNumoper$, "ANTICIPO") Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAANTCAP.RPT"
            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
            BacTrader.bacrpt.Action = 1
        Else
            ImprimePapeleta = "NO"
        End If
    End If

    BacTrader.bacrpt.Destination = 0
    Exit Function
    
ErrPrinter:

    MsgBox "Problemas en impresión de comprobantes de operación: " & Err.Description, vbExclamation, TITSISTEMA
    Exit Function
    
End Function



Function LlenarPAINTER(rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarPAINTER = True
    Sql = "DELETE FROM PAINTERBAN;"
    DB.Execute Sql

    Sql = "SP_PAPELETAIB  "
    Sql = Sql + rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO PAINTERBAN VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + Datos(5) + "," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(11) + "'," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + "'" + Datos(13) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(14) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(15) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(16) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(17) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(18) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(19) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(20) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(21) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(22) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(23) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(24) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(25) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(26) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(27) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(28) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(29) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(30) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(31) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(32) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(33) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(34) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(35) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(36) + "'," & Chr(10)
            Sql = Sql + Datos(37) + "," & Chr(10)
            Sql = Sql + "'" + Datos(38) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(39) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(40) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(41) + "'," & Chr(10)   'se agrega hora de impresion (Miguel Gajardo)
            Sql = Sql + "'" + Datos(42) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(43) + "');"
            DB.Execute Sql
        Loop
    Else
        LlenarPAINTER = False
    End If

End Function


Function Inf_VctoDPosito(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()

' se ocupa la misma tabla access de las cartera de interbancarios y Vcto CI
' por que tiene la misma estructura
' no se puede llegar y modificar la estructura

    Sql = "DELETE FROM CAINTER"
    Inf_VctoDPosito = True
    DB.Execute Sql
    Sql = "SP_INFORMEDEP " & Val(Entidad)

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO CAINTER VALUES ( " & Chr(10)
            Sql = Sql + Datos(1) + "," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + "'" + Datos(12) + "'," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + "'" + Datos(14) + "'," & Chr(10)
            Sql = Sql + Datos(1) + " );"
            DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, TITSISTEMA
        Inf_VctoDPosito = False
    End If
End Function
Function Inf_VctoCCamara(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM MDVIVC"
    Inf_VctoCCamara = True
    DB.Execute Sql
    Sql = "SP_VCTOCAPVCAMARA " & Val(Entidad)
    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            If Datos(1) = "NO" Then
                Inf_VctoCCamara = True
                Exit Function
            End If
            Sql = "INSERT INTO MDVIVC VALUES( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(11) + " ) ; "
            DB.Execute Sql
        Loop
    Else
        MsgBox "Informe no puede ser procesado", vbExclamation, TITSISTEMA
        Inf_VctoCCamara = False
    End If

End Function
'Nuevas Funcion Aderidas (FIN): Marcos Jimenez
'---------------------------------
'---------------------------------


Function LlenarPAMDCI(rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarPAMDCI = True
    Sql = "DELETE FROM PAMDCI;"
    DB.Execute Sql

    sql = "EXECUTE SP_PAPELETACI "
    sql = sql + rut$ + ","
    sql = sql + Doc$ + ","
    sql = sql + gsTipoPapeleta

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO PAMDCI VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + Datos(6) + "," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + "'" + Datos(14) + "'," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + "'" + Datos(16) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(17) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(18) + "'," & Chr(10)
            Sql = Sql + Datos(19) + "," & Chr(10)
            Sql = Sql + Datos(20) + "," & Chr(10)
            Sql = Sql + Datos(21) + "," & Chr(10)
            Sql = Sql + "'" + Datos(22) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(23) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(24) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(25) + "'," & Chr(10)
            Sql = Sql + Datos(26) + "," & Chr(10)
            Sql = Sql + "'" + Datos(27) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(28) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(29) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(30) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(31) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(32) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(33) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(34) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(35) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(36) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(37) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(38) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(39) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(40) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(41) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(42) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(43) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(44) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(45) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(46) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(47) + "'," & Chr(10)
            Sql = Sql + Datos(48) + "," & Chr(10)
            ' El 49 no se Debe Ocupar
            Sql = Sql + Datos(50) + "," & Chr(10)
            Sql = Sql + Datos(51) + "," + Chr(10)
            Sql = Sql + "'" + Datos(52) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(53) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(54) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(55) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(56) + "');"
            DB.Execute Sql
        Loop
    Else
        LlenarPAMDCI = False
    End If

End Function


Function LlenarPAMDRVA(rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarPAMDRVA = True
    Sql = "DELETE FROM PAMDRVA;"
    DB.Execute Sql
    Sql = ""
    Sql = "SP_PAPELETARVA "
    Sql = Sql + rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = ""
            Sql = "INSERT INTO PAMDRVA VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + Datos(6) + "," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql & Val(Datos(9)) & "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql & Val(Datos(11)) & "," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + "'" + Datos(14) + "'," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + "'" + Datos(16) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(17) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(18) + "'," & Chr(10)
            Sql = Sql + Datos(19) + "," & Chr(10)
            Sql = Sql + Datos(20) + "," & Chr(10)
            Sql = Sql + Datos(21) + "," & Chr(10)
            Sql = Sql + "'" + Datos(22) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(23) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(24) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(25) + "'," & Chr(10)
            Sql = Sql + Datos(26) + "," & Chr(10)
            Sql = Sql + "'" + Datos(27) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(28) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(29) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(30) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(31) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(32) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(33) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(34) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(35) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(36) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(37) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(38) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(39) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(40) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(41) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(42) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(43) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(44) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(45) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(46) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(47) + "'," & Chr(10)
            Sql = Sql + Datos(48) + "," & Chr(10)
            ' El 49 no se Debe Ocupar
            Sql = Sql + Datos(50) + "," & Chr(10)
            Sql = Sql + Datos(51) + "," & Chr(10)
            Sql = Sql + "'" + Datos(52) + "'," & Chr(10)
            Sql = Sql + Datos(53) + "," & Chr(10)
            Sql = Sql + Datos(54) + "," & Chr(10)
            Sql = Sql + Datos(55) + "," & Chr(10)
            Sql = Sql + "'" + Datos(56) + "'," & Chr(10)
            Sql = Sql + Datos(57) + "," & Chr(10)
            Sql = Sql & Datos(58) & "," & Chr(10)
            Sql = Sql & "'" & Datos(59) & "' );" & Chr(10)

            DB.Execute Sql
        Loop
    Else
        LlenarPAMDRVA = False
    End If

End Function



Function LlenarPAMDCP(rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarPAMDCP = True
    
    DB.Execute "DELETE * FROM PAMDCP"

    Sql = "SP_PAPELETACP "
    Sql = Sql + rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO PAMDCP VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + Datos(6) + "," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + "'" + Datos(14) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(15) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(16) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(17) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(18) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(19) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(20) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(21) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(22) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(23) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(24) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(25) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(26) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(27) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(28) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(29) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(30) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(31) + "'," & Chr(10)
            Sql = Sql + Datos(32) + "," & Chr(10)
            Sql = Sql + Datos(33) + "," & Chr(10)
            Sql = Sql + "'" + Datos(34) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(35) + "'," & Chr(10)
            Sql = Sql + Datos(36) + "," & Chr(10)
          ' El 37 no se Debe Ocupar
            Sql = Sql + Datos(38) + "," & Chr(10)
            Sql = Sql + Datos(39) + "," & Chr(10)
            Sql = Sql + Datos(40) + "," & Chr(10)
            Sql = Sql + Datos(41) + "," & Chr(10)
            Sql = Sql + Datos(42) + "," & Chr(10)
            Sql = Sql + "'" + Datos(43) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(44) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(45) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(46) + "'," & Chr(10)
            
            Sql = Sql + "'" + Datos(47) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(48) + "');"
            DB.Execute Sql
        Loop
    Else
        LlenarPAMDCP = False
    End If

End Function

Function LlenarPACAPTA(rut$, Doc$, Estado$) As Boolean
Dim Sql As String
Dim Datos()
Dim p As Boolean
Dim Estado_Operacion As String

p = False

    LlenarPACAPTA = False
    
    DB.Execute "DELETE * FROM PACAPTACION"

    sql = "EXECUTE SP_PAPELETAIC "
    sql = sql + Doc$

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
        
            If Datos(29) = "A" Then
               Estado_Operacion = "ANULADA"
            Else
               Estado_Operacion = Estado$
            End If
            
            Sql = "INSERT INTO PACAPTACION VALUES ( " & Chr(10)
            Sql = Sql & "'" & Datos(1) & "'," & Chr(10)                         '1 Fecha de Proceso
            Sql = Sql & "'" & Datos(2) & "'," & Chr(10)                         '2 Rut Cartera
            Sql = Sql & Datos(3) & "," & Chr(10)                                '3 Numero de Documento
            Sql = Sql & Datos(4) & "," & Chr(10)                                '4 Correlativo
            Sql = Sql & Datos(5) & "," & Chr(10)                                '5 Numero de Operación
            Sql = Sql & "'" & Datos(6) & "'," & Chr(10)                         '6 Tipo de Operación
            Sql = Sql & Datos(7) & "," & Chr(10)                                '7 Nominal
            Sql = Sql & Datos(8) & "," & Chr(10)                                '8 Valor Inicial $$
            Sql = Sql & Datos(9) & "," & Chr(10)                                '9 Tasa
            Sql = Sql & Datos(10) & "," & Chr(10)                               '10 Tasa Transacción
            Sql = Sql & "'" & Datos(11) & "'," & Chr(10)                        '11 Fecha Inicio
            Sql = Sql & "'" & Datos(12) & "'," & Chr(10)                        '12 Fecha Vencimiento
            Sql = Sql & Datos(13) & "," & Chr(10)                               '13 Plazo
            Sql = Sql & Datos(14) & "," & Chr(10)                               '14 Valor Inicio UM
            Sql = Sql & Datos(15) & "," & Chr(10)                               '15 Valor Final UM
            Sql = Sql & "'" & Datos(16) & "'," & Chr(10)                        '16 Moneda
            Sql = Sql & "'" & Datos(17) & "'," & Chr(10)                        '17 Forma de Pago al Inicio
            Sql = Sql & "'" & Datos(18) & "'," & Chr(10)                        '18 Rut Cliente
            Sql = Sql & "'" & Datos(20) & "'," & Chr(10)                        '19 Tipo Retiro
            Sql = Sql & "'" & Datos(21) & "'," & Chr(10)                        '20 Custodia
            Sql = Sql & "'" & Datos(22) & "'," & Chr(10)                        '21 Hora
            Sql = Sql & "'" & Datos(23) & "'," & Chr(10)                        '22 Usuario
            Sql = Sql & "'" & Datos(24) & "'," & Chr(10)                        '23 Terminal
            Sql = Sql & "'" & Datos(25) & "'," & Chr(10)                        '24 Tipo Deposito
            Sql = Sql & "'" & Datos(26) & "'," & Chr(10)                        '25 Entidad
            Sql = Sql & "'" & Datos(27) & "'," & Chr(10)                         '26 Cliente
            Sql = Sql & Datos(28) & ",'" & Estado_Operacion & Chr(10)
            Sql = Sql & "' );"
            DB.Execute Sql
            p = True
        Loop
    Else
        Exit Function
    End If
    If Not p Then
       Exit Function
    End If
     LlenarPACAPTA = True
End Function


Function LlenarPACAPTAANT(rut$, Doc$, Estado$) As Boolean
Dim Sql As String
Dim Datos()
Dim p As Boolean
Dim Estado_Operacion As String

p = False

    LlenarPACAPTAANT = False
    
    DB.Execute "DELETE * FROM papantcapta"

    sql = "EXECUTE SP_PAPELETAANTIC "
    sql = sql + Doc$

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
        
            If Datos(29) = "A" Then
               Estado_Operacion = "ANULADA"
            Else
               Estado_Operacion = Estado$
            End If
            
            Sql = "INSERT INTO papantcapta VALUES ( " & Chr(10)
            Sql = Sql & "'" & Datos(1) & "'," & Chr(10)                         '1 Fecha de Proceso
            Sql = Sql & "'" & Datos(2) & "'," & Chr(10)                         '2 Rut Cartera
            Sql = Sql & Datos(3) & "," & Chr(10)                                '3 Numero de Documento
            Sql = Sql & Datos(4) & "," & Chr(10)                                '4 Correlativo
            Sql = Sql & Datos(5) & "," & Chr(10)                                '5 Numero de Operación
            Sql = Sql & "'" & Datos(6) & "'," & Chr(10)                         '6 Tipo de Operación
            Sql = Sql & Datos(7) & "," & Chr(10)                                '7 Nominal
            Sql = Sql & Datos(8) & "," & Chr(10)                                '8 Valor Inicial $$
            Sql = Sql & Datos(9) & "," & Chr(10)                                '9 Tasa
            Sql = Sql & Datos(10) & "," & Chr(10)                               '10 Tasa Transacción
            Sql = Sql & "'" & Datos(11) & "'," & Chr(10)                        '11 Fecha Inicio
            Sql = Sql & "'" & Datos(12) & "'," & Chr(10)                        '12 Fecha Vencimiento
            Sql = Sql & Datos(13) & "," & Chr(10)                               '13 Plazo
            Sql = Sql & Datos(14) & "," & Chr(10)                               '14 Valor Inicio UM
            Sql = Sql & Datos(15) & "," & Chr(10)                               '15 Valor Final UM
            Sql = Sql & "'" & Datos(16) & "'," & Chr(10)                        '16 Moneda
            Sql = Sql & "'" & Datos(17) & "'," & Chr(10)                        '17 Forma de Pago al Inicio
            Sql = Sql & "'" & Datos(18) & "'," & Chr(10)                        '18 Rut Cliente
            Sql = Sql & "'" & Datos(20) & "'," & Chr(10)                        '19 Tipo Retiro
            Sql = Sql & "'" & Datos(21) & "'," & Chr(10)                        '20 Custodia
            Sql = Sql & "'" & Datos(22) & "'," & Chr(10)                        '21 Hora
            Sql = Sql & "'" & Datos(23) & "'," & Chr(10)                        '22 Usuario
            Sql = Sql & "'" & Datos(24) & "'," & Chr(10)                        '23 Terminal
            Sql = Sql & "'" & Datos(25) & "'," & Chr(10)                        '24 Tipo Deposito
            Sql = Sql & "'" & Datos(26) & "'," & Chr(10)                        '25 Entidad
            Sql = Sql & "'" & Datos(27) & "'," & Chr(10)                         '26 Cliente
            Sql = Sql & Datos(28) & ",'" & Estado_Operacion & "'," & Chr(10)
            Sql = Sql & Datos(30) & ","
            Sql = Sql & Datos(31) & "," & Chr(10)                        '25 Entidad
            Sql = Sql & Datos(32) & "," & Chr(10)
            Sql = Sql & Datos(33) & " );"                                                   '27 Valor Unidad Monetaria
            DB.Execute Sql
            p = True
        Loop
    Else
        Exit Function
    End If
    If Not p Then
       Exit Function
    End If
     LlenarPACAPTAANT = True
End Function


Function LlenarPAMDRCA(rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarPAMDRCA = True
    Sql = "DELETE FROM PAMDRCA;"
    DB.Execute Sql

    sql = "EXECUTE SP_PAPELETARCA "
    sql = sql + rut$ + ","
    sql = sql + Doc$ + ","
    sql = sql + gsTipoPapeleta

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO PAMDRCA VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + Datos(6) + "," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + "'" + Datos(14) + "'," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + "'" + Datos(16) + "'," & Chr(10)
            Sql = Sql + Datos(17) + "," & Chr(10)
            Sql = Sql + Datos(18) + "," & Chr(10)
            Sql = Sql + Datos(19) + "," & Chr(10)
            Sql = Sql + "'" + Datos(20) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(21) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(22) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(23) + "'," & Chr(10)
            Sql = Sql + Datos(24) + "," & Chr(10)
            Sql = Sql + "'" + Datos(25) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(26) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(27) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(28) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(29) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(30) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(31) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(32) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(33) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(34) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(35) + "'," & Chr(10)
            Sql = Sql + Datos(36) + "," & Chr(10)
            Sql = Sql + Datos(37) + "," & Chr(10)
            Sql = Sql + Datos(38) + "," & Chr(10)
            Sql = Sql + "'" + Datos(39) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(40) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(41) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(42) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(43) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(44) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(45) + "'," & Chr(10)
            Sql = Sql + Datos(46) + "," & Chr(10)
            ' el 47 no se debe ocupar
            Sql = Sql + Datos(48) + "," & Chr(10)
            Sql = Sql + Datos(49) + "," & Chr(10)
            Sql = Sql + "'" + Datos(50) & "'," & Chr(10)
            Sql = Sql & "'" & Datos(51) & "'," & Chr(10)
            Sql = Sql & Datos(52) & "," & Chr(10)
            Sql = Sql & Datos(53) & "," & Chr(10)
            Sql = Sql & Datos(54) & "," & Chr(10)
            Sql = Sql & "'" & Datos(55) & "'," & Chr(10)
            Sql = Sql & Datos(56) & "," & Chr(10)
            Sql = Sql & Datos(57) & "," & Chr(10)
            Sql = Sql & Datos(58) & "," & Chr(10)
            Sql = Sql & "'" & Datos(59) & "'" & Chr(10)
            Sql = Sql & ");"
            DB.Execute Sql
        Loop
    Else
        LlenarPAMDRCA = False
    End If

End Function

Function LlenarPAMDVI(rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarPAMDVI = True
    Sql = "DELETE FROM PAMDVI;"
    DB.Execute Sql
    Sql = ""
    Sql = "SP_PAPELETAVI "
    Sql = Sql + rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
           If Datos(1) <> "CERO" Then
                Sql = "INSERT INTO PAMDVI VALUES ( " & Chr(10)
                Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
                Sql = Sql + Datos(6) + "," & Chr(10)
                Sql = Sql + Datos(7) + "," & Chr(10)
                Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
                Sql = Sql + Datos(9) + "," & Chr(10)
                Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
                Sql = Sql + Datos(11) + "," & Chr(10)
                Sql = Sql + Datos(12) + "," & Chr(10)
                Sql = Sql + Datos(13) + "," & Chr(10)
                Sql = Sql + "'" + Datos(14) + "'," & Chr(10)
                Sql = Sql + Datos(15) + "," & Chr(10)
                Sql = Sql + "'" + Datos(16) + "'," & Chr(10)
                Sql = Sql + Datos(17) + "," & Chr(10)
                Sql = Sql + Datos(18) + "," & Chr(10)
                Sql = Sql + Datos(19) + "," & Chr(10)
                Sql = Sql + "'" + Datos(20) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(21) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(22) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(23) + "'," & Chr(10)
                Sql = Sql + Datos(24) + "," & Chr(10)
                Sql = Sql + "'" + Datos(25) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(26) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(27) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(28) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(29) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(30) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(31) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(32) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(33) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(34) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(35) + "'," & Chr(10)
                Sql = Sql + Datos(36) + "," & Chr(10)
                Sql = Sql + Datos(37) + "," & Chr(10)
                Sql = Sql + Datos(38) + "," & Chr(10)
                Sql = Sql + "'" + Datos(39) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(40) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(41) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(42) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(43) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(44) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(45) + "'," & Chr(10)
                Sql = Sql + Datos(46) + "," & Chr(10)
                ' el 47 no se debe ocupar
                Sql = Sql + Datos(48) + "," & Chr(10)
                Sql = Sql + Datos(49) + "," & Chr(10)
                Sql = Sql + "'" + Datos(50) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(51) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(52) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(53) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(54) + "'," & Chr(10)
                Sql = Sql + "'" + Datos(55) + "');"

                DB.Execute Sql
           End If
        Loop
    Else
        LlenarPAMDVI = False
    End If

End Function

Function LlenarPAMDVP(rut$, Doc$, sTipoper) As Boolean
Dim Sql As String
Dim Datos()

    LlenarPAMDVP = True
    Sql = "DELETE FROM PAMDVP;"
    DB.Execute Sql

    Sql = "SP_PAPELETAVP "
    Sql = Sql + rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta + ","
    Sql = Sql + sTipoper

    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO PAMDVP VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + Datos(6) + "," & Chr(10)
            Sql = Sql + Datos(7) + "," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + "'" + Datos(14) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(15) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(16) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(17) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(18) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(19) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(20) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(21) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(22) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(23) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(24) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(25) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(26) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(27) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(28) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(29) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(30) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(31) + "'," & Chr(10)
            Sql = Sql + Datos(32) + "," & Chr(10)
            Sql = Sql + Datos(33) + "," & Chr(10)
            Sql = Sql + "'" + Datos(34) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(35) + "'," & Chr(10)
            Sql = Sql + Datos(36) + "," & Chr(10)
            ' el 37 no se debe ocupar
            Sql = Sql + Datos(38) + "," & Chr(10)
            Sql = Sql + Datos(39) + "," & Chr(10)
            Sql = Sql + Datos(40) + "," & Chr(10)
            Sql = Sql + Datos(41) + "," & Chr(10)
            Sql = Sql + Datos(42) + "," & Chr(10)
            Sql = Sql + "'" + Datos(43) & "'," & Chr(10)
            Sql = Sql + "'" + Datos(44) & "'," & Chr(10)
            Sql = Sql + "'" + Datos(45) & "');"
            DB.Execute Sql
        Loop
    Else
        LlenarPAMDVP = False
    End If

End Function

Function LlenarMovDCV(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM MOVDCV"
    LlenarMovDCV = True
    DB.Execute sql
    sql = ""
    sql = "EXECUTE SP_INFMOVDCV "
    sql = sql & Val(Entidad)
    
    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO MOVDCV VALUES (  " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(8) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(9) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(10) + "'," & Chr(10)
            Sql = Sql + Datos(11) + "," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + "'" + Datos(13) + "'," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + "'" + Datos(16) + "' );"
            DB.Execute Sql
        Loop
    Else
        LlenarMovDCV = False
        MsgBox "Informe no puede ser Generado", vbExclamation, TITSISTEMA
    End If

End Function

Function LlenarCPDCV(Entidad As String) As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM MDCPDCV;"
    LlenarCPDCV = True
    DB.Execute Sql
    Sql = ""
    Sql = "SP_CARTERADCV " & Val(Entidad)
    If MISQL.SQL_Execute(Sql) = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO MDCPDCV VALUES(  " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(5) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql & Val(Datos(8)) & "," & Chr(10)
            Sql = Sql + "'" + Datos(9) + "'," & Chr(10)
            Sql = Sql & CDbl(Datos(15)) & "," & Chr(10)
            Sql = Sql & Datos(14) & "," & Chr(10)
            Sql = Sql & Val(Datos(12)) & "," & Chr(10)
            Sql = Sql + "'" + Datos(13) + "' );"
            DB.Execute Sql
        Loop
    Else
        LlenarCPDCV = False
        MsgBox "Informe no pudo ser procesado", vbExclamation, TITSISTEMA
    End If

End Function







Function LlenarmdbTD()
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM TDESA;"
    DB.Execute Sql

    If MISQL.SQL_Execute("SP_PRUEBA") = 0 Then
        Do While MISQL.SQL_Fetch(Datos()) = 0
            Sql = "INSERT INTO TDESA VALUES ( " & Chr(10)
            Sql = Sql + Datos(1) + "," + Datos(2) + "," & Chr(10)
            Sql = Sql + Datos(3) + "," + Datos(4) + "," & Chr(10)
            Sql = Sql + Datos(5) + ",'" + Datos(6) + "'  );"
            DB.Execute Sql
        Loop
    End If

End Function


Function LlenarVencimientocaptacion() As Boolean
   Dim TitRpt As String
   Dim cSql As String
   Dim Datos()
   Dim nValor As Integer

   BacIniBlo.Show 1

   If giAceptar% Then
      TitRpt = "VENCIMIENTOS DE CAPTACIONES DEL DIA " & CStr(xFecha)
      Screen.MousePointer = vbHourglass
      
      BacTrader.bacrpt.Destination = 0
      BacTrader.bacrpt.ReportFileName = RptList_Path & "VCTOCAP.RPT"
      BacTrader.bacrpt.StoredProcParam(0) = ""
      BacTrader.bacrpt.StoredProcParam(1) = ""
      BacTrader.bacrpt.StoredProcParam(2) = ""
      BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
      BacTrader.bacrpt.Formulas(1) = ""
      BacTrader.bacrpt.Formulas(2) = ""
      BacTrader.bacrpt.Connect = CONECCION
      BacTrader.bacrpt.Action = 1

   End If

   Screen.MousePointer = vbDefault
   
   Exit Function

End Function

'Function LlenarBloter() As Boolean
'Dim cSql As String
'Dim Datos()
'Dim nValor As Integer
'Dim Titulo As String
'
'
'BacIniBlo.Show 1
'Titulo = "BLOTTER  DEL (" & CStr(xFecha) & "  RENTA  FIJA)"
'If giAceptar% Then
'    If Not Llenar_Parametros(Titulo) Then Exit Function
'
'        nValor = 0
'        cSql = "DELETE FROM OPESIS"
'        LlenarBloter = True
'
'        DB.Execute cSql
'
'        cSql = "EXECUTE sp_cbloter  '" & Format(xFecha, "yyyymmdd") & "'"
'
'        If SQL_Execute(cSql) = 0 Then
'            Do While SQL_Fetch(Datos()) = 0
'               cSql = "INSERT INTO OPESIS VALUES ( " & Chr(10)
'               cSql = cSql & Val(Datos(1)) & "," & Chr(10)
'               cSql = cSql & Val(Datos(2)) & "," & Chr(10)
'               cSql = cSql & "'" & Trim(Datos(3)) & "'," & Chr(10)
'               cSql = cSql & "'" & Trim(Datos(4)) & "'," & Chr(10)
'               cSql = cSql & Datos(5) + "," & Chr(10)
'               cSql = cSql & Datos(6) + "," & Chr(10)
'               cSql = cSql & Datos(7) + "," & Chr(10)
'               cSql = cSql & "'" & Trim(Datos(8)) & "'," & Chr(10)
'               cSql = cSql & Datos(9) & "," & Chr(10)
'               cSql = cSql & "'" & CDate(Datos(10)) & "'," & Chr(10)
'               cSql = cSql & "'" & Trim(Datos(11)) & "'," & Chr(10)
'               cSql = cSql & "'" & Trim(Datos(12)) & "'," & Chr(10)
'               cSql = cSql & "'" & Trim(Datos(13)) & "');"
'               nValor = 1
'               DB.Execute cSql
'            Loop
'        Else
'            LlenarBloter = False
'        End If
'        If nValor = 0 Then
'            LlenarBloter = False
'            MsgBox "No se registran operaciones ", vbExclamation, gsBac_Version
'            Exit Function
'        End If
'
'End If
'End Function

