Attribute VB_Name = "BacList"

Function PROC_ESTABLECE_UBICACION(Cantidad_Bases As Integer, ObjetoCristal As Object)
On Error GoTo Error_OnError
Dim Posicion_1 As Integer
Dim i
Dim Nueva_DataFile As String

If Cantidad_Bases = 0 Then Exit Function
With ObjetoCristal
    For i = 0 To Cantidad_Bases - 1
            Posicion_1 = InStr(.DataFiles(i), ".")
            Nueva_DataFile = gsSQL_Database & Mid(.DataFiles(i), Posicion_1, ((Len(.DataFiles(i)) - Posicion_1) + 1))
            .DataFiles(i) = Nueva_DataFile
    Next
End With

    Exit Function
Error_OnError:
    MsgBox "Error número: " & err.Number & ", Descripción: " & err.Description, vbCritical
    Screen.MousePointer = 0
End Function



Function Inf_EstadoCuenta(Rut As Long, Codigo As Long) As Boolean
Dim SQL As String
Dim Datos()

    Screen.MousePointer = 11

    SQL = "DELETE FROM ESTADOCUENTA;"
    Inf_EstadoCuenta = True
    db.Execute SQL
    
    SQL = "SP_ESTADO_CUENTA " & Val(Rut) & "," & Val(Codigo)
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO ESTADOCUENTA VALUES( " & Chr(10)
            SQL = SQL + Datos(1) + "," & Chr(10)                                     'Rut Cliente
            SQL = SQL + "'" + Trim(Datos(2)) + "'," & Chr(10)                                    'Codigo Rut
            SQL = SQL + "'" + Trim(Datos(3)) + "'," & Chr(10)                   'Nombre
            SQL = SQL + "'" + Trim(Datos(4)) + "'," & Chr(10)                   'Sistema
            SQL = SQL + Datos(5) + "," & Chr(10)                                     ' Numero Operación
            SQL = SQL + "'" + Trim(Datos(6)) + "'," & Chr(10)                   'Tipo Operación
            SQL = SQL + "'" + Trim(Datos(7)) + " '," & Chr(10) 'Instrumento
            SQL = SQL + "'" + Trim(Datos(8)) + " '," & Chr(10) 'Emisor
            SQL = SQL + Datos(9) + "," & Chr(10) 'Nominal
            SQL = SQL + "'" + Trim(Datos(10)) + " ' ," & Chr(10)                  'Moneda
            SQL = SQL + Datos(11) + "," & Chr(10)                           'Tir/Precio
            SQL = SQL + Datos(12) + "," & Chr(10)   'Monto Operación
            SQL = SQL + "'" + Format(Datos(13), "DD/MM/YYYY") + " '," & Chr(10) 'Fecha Vencimiento
            SQL = SQL + "'" + Trim(Datos(14)) + " '," & Chr(10)  'Moneda Pacto
            SQL = SQL + Datos(15) + "," & Chr(10) 'Tasa Pacto
            SQL = SQL + Datos(16) + "," & Chr(10) 'Valor Final
            SQL = SQL + "'" + Format(Datos(17), "dd/mm/yyyy") + "'," & Chr(10) 'Valor Final
            SQL = SQL + "'" + Trim(Datos(18)) + "'," & Chr(10)                              'Forma Pago
            SQL = SQL + "'" + Format(Datos(19), "dd/mm/yyyy") + "'," & Chr(10) 'Fecha Operación
            SQL = SQL + "' " + Format(Time, "HH:MM:SS") + "' "
            SQL = SQL + " );"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, "Informes"
        Inf_EstadoCuenta = False
    End If
End Function
Function Inf_Recepcionar(Tipo_Informe As Long) As Boolean
Dim Datos()

    Screen.MousePointer = 11

    Inf_Recepcionar = True
     
'    Sql = "SP_INF_RECPINSTRUMENTO " & Val(Tipo_Informe)
    Envia = Array(CDbl(Tipo_Informe))
    
    If Bac_Sql_Execute("SP_INF_RECPINSTRUMENTO", Envia) Then
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, "Informes"
        Inf_Recepcionar = False
    End If

    Screen.MousePointer = 0

End Function
Function Informe_Custodia(xReporte As String, nRut As Long, iCodigo As Long) As Boolean
Dim Datos()
Dim p  As Integer

    Informe_Custodia = False
    p = 0
'   Sql = "SP_INF_CUSTODIA " & nRut & "," & iCodigo
    Envia = Array(CDbl(nRut), CDbl(iCodigo))

    If Bac_Sql_Execute("SP_INF_CUSTODIA", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            p = p + 1
            Exit Do
        Loop
    End If
    
    Informe_Custodia = True
    
End Function


Function Llenar_Voucher() As Boolean
Dim SQL As String
Dim Datos()
Dim p As Integer
p = 0
SQL = "DELETE FROM VOUCHER;"
Llenar_Voucher = False
db.Execute SQL
SQL = "SP_INFVOUCHERS"
If Bac_Sql_Execute(SQL, Envia) Then
   Do While Bac_SQL_Fetch(Datos())
    p = p + 1
     SQL = "INSERT INTO VOUCHER VALUES(" & Chr(10)
     SQL = SQL & Datos(1) & "," & Chr(10)
     SQL = SQL & Datos(2) & "," & Chr(10)
     SQL = SQL & "'" & Datos(3) & "'," & Chr(10)
     SQL = SQL & "'" & Datos(4) & "'," & Chr(10)
     SQL = SQL & Datos(5) & "," & Chr(10)
     SQL = SQL & "'" & Datos(6) & "'," & Chr(10)
     SQL = SQL & "'" & Datos(7) & "'," & Chr(10)
     SQL = SQL & Datos(8) & "," & Chr(10)
     SQL = SQL & "'" & Datos(9) & "'," & Chr(10)
     SQL = SQL & Datos(10) & "," & Chr(10)
     SQL = SQL & "'" & Datos(11) & "'," & Chr(10)
     SQL = SQL & "'" & Datos(12) & "',"
     SQL = SQL & "'" & Datos(13) & "')"
     db.Execute SQL
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
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM MDCOVI;"
    Inf_CertOperVig = True
    db.Execute SQL
    
    SQL = "SP_OPERVIGCERT " + Str(nRutcli)

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "NO" Then
                MsgBox Datos(2), vbExclamation, gsBac_Version
                Inf_CertOperVig = False
                Exit Function
            End If
            SQL = "INSERT INTO MDCOVI VALUES( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + Datos(2) + "," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + Datos(4) + "," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + "'" + Datos(11) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(12) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(13) + "' );"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        Inf_CertOperVig = False
    End If

End Function


Function Inf_OperHisto(nRutcli As Double) As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM MDOPEHI;"
    Inf_OperHisto = True
    db.Execute SQL
    
    SQL = "SP_OPERHISTORICAS " + Str(nRutcli)

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MDOPEHI VALUES( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + Datos(5) + "," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + "'" + Datos(11) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(12) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(13) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(14) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(15) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(16) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(17) + "' );"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        Inf_OperHisto = False
    End If

End Function

Function Inf_Tasas(nSw As Integer) As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM MDTASA"
    Inf_Tasas = True
    db.Execute SQL

    If miSQL.SQL_Execute("SP_INFTASAS") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MDTASA VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + "'" + Datos(12) + "');"
            db.Execute SQL
        Loop
    Else
        Inf_Tasas = False
        If nSw = 1 Then
            MsgBox "Informe no pudo ser Procesado", vbExclamation, gsBac_Version
        End If
    End If

End Function

Function Inf_VctoVcDiarios(Entidad As String, nTipRep) As Boolean '** GUILLERMO CONTRERAS **
Dim SQL As String
Dim Datos()
Dim valor As Integer

    valor = 0
    
    SQL = "DELETE FROM MDVCD;"
    Inf_VctoVcDiarios = False
    db.Execute SQL
    
    SQL = "" '
    SQL = "EXECUTE SP_VCTOSDIARIOS " & CDbl(Entidad) & ", " & nTipRep
    
    If Bac_Sql_Execute(SQL, Envia) Then
  
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO mdvcd VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + Datos(4) + "," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + Datos(6) + "," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "', '" & Datos(11) & "'" & Chr(10)
            SQL = SQL + " );"

            db.Execute SQL
            valor = 1
            Inf_VctoVcDiarios = True
        Loop
    Else
        MsgBox "Informe no pudo ser Procesado", vbExclamation, gsBac_Version
    End If

    If valor = 0 Then
        MsgBox "No se registran vencimientos en el día de hoy de " & IIf(nTipRep = 1, "Cupones ", IIf(nTipRep = 2, "Interbancarios ", "Captaciones ")), vbExclamation, gsBac_Version
    End If
    
End Function


Function LlenaInfoGesPactos(Entidad As String)
Dim Datos()

    gSQL = "DELETE FROM MDGEP;"
    LlenaInfoGesPactos = True
    db.Execute gSQL
    gSQL = ""
    gSQL = "SP_INFOGESTIONPACTOS "
    gSQL = gSQL & Val(Entidad)
    If miSQL.SQL_Execute(gSQL) = 0 Then
        Do While Bac_SQL_Fetch(Datos())
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
            db.Execute gSQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        LlenaInfoGesPactos = False
    End If

End Function

Function LlenaInfoGesCVDef(Entidad As String)
Dim Datos()
   Dim A As Double
    gSQL = "DELETE FROM MDGEV;"
    LlenaInfoGesCVDef = True
    db.Execute gSQL
    gSQL = ""
    gSQL = "SP_INFOGESTIONCVDEF "
    gSQL = gSQL & Val(Entidad)
    If miSQL.SQL_Execute(gSQL) = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            A = A + 1
            gSQL = "INSERT INTO MDGEV VALUES ( " & Chr(10)
            gSQL = gSQL + "'" + Datos(1) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(2) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(3) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(4) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(5) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(6) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(7) + "'," & Chr(10)
            gSQL = gSQL + Datos(8) + "," & Chr(10)
            gSQL = gSQL & Val(A) & "," & Chr(10)
            gSQL = gSQL + "'" + Datos(9) + "' );"
            db.Execute gSQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        LlenaInfoGesCVDef = False
    End If

End Function


Function LlenaInfoOperMes()
Dim Datos()

    LlenaInfoOperMes = True
    db.Execute "DELETE FROM MDOPEMES;"

    If miSQL.SQL_Execute("SP_INFOPERMES") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
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
            db.Execute gSQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        LlenaInfoOperMes = False
    End If

End Function
Function LlenaInfoGesInter()
Dim Datos()

    gSQL = "DELETE FROM MDGEI;"
    LlenaInfoGesInter = True
    db.Execute gSQL

    If miSQL.SQL_Execute("SP_INFOGESTIONINTER") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
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
            db.Execute gSQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        LlenaInfoGesInter = False
    End If

End Function

Function LlenaPuntas(nSw As Integer) As Boolean
Dim SQL As String
Dim Datos()
Dim nNum%, cCar$

    nNum = 0
    cCar = " "

    SQL = "DELETE FROM MDPUNTAS"
    LlenaPuntas = False
    db.Execute SQL

    SQL = "SP_INFPTASPRC " & Chr$(10) & nSw

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If nSw = 1 Then
                SQL = "INSERT INTO MDPUNTAS VALUES ( " & Chr(10)
                SQL = SQL + "'" + Datos(1) + "'," & Chr(10)     '1  Nomemp
                SQL = SQL + "'" + Datos(2) + "'," & Chr(10)     '2  Rutemp
                SQL = SQL + "'" + Datos(3) + "'," & Chr(10)     '3  Informe
                SQL = SQL + Datos(4) + "," & Chr(10)            '4  Punta
                SQL = SQL + "'" + Datos(5) + "'," & Chr(10)     '5  Instser
                SQL = SQL + "'" + cCar + "'," & Chr(10)         '6  Grupo
                SQL = SQL + Datos(6) + "," & Chr(10)            '7  Nomdis
                SQL = SQL + Datos(8) + "," & Chr(10)            '8  Nomint
                SQL = SQL + Str(nNum) + "," & Chr(10)           '9  Nomstock
                SQL = SQL + "'" + Datos(7) + "'," & Chr(10)     '10 Fecven
                SQL = SQL + Str(nNum) + "," & Chr(10)           '11 Año
                SQL = SQL + Str(nNum) + "," & Chr(10)           '12 Mes
                SQL = SQL + Str(nNum) + "," & Chr(10)           '13 Día
                SQL = SQL + "'" + Datos(9) + "'," & Chr(10)     '15 Fecpro
                SQL = SQL + Datos(10) + "," & Chr(10)           '16 Postotal
                SQL = SQL + "'" + Datos(11) + "');"             '17 Fecprox
            Else
                SQL = "INSERT INTO MDPUNTAS VALUES ( " & Chr(10)
                SQL = SQL + "'" + Datos(1) + "'," & Chr(10)     '1  Nomemp
                SQL = SQL + "'" + Datos(2) + "'," & Chr(10)     '2  Rutemp
                SQL = SQL + "'" + Datos(3) + "'," & Chr(10)     '3  Informe
                SQL = SQL + Datos(4) + "," & Chr(10)            '4  Punta
                SQL = SQL + "'" + Datos(5) + "'," & Chr(10)     '5  Instser
                SQL = SQL + "'" + Datos(6) + "'," & Chr(10)     '6  Grupo
                SQL = SQL + Datos(7) + "," & Chr(10)            '7  Nomdis
                SQL = SQL + Str(nNum) + "," & Chr(10)           '8  Nomint
                SQL = SQL + Datos(12) + "," & Chr(10)           '9  Nomstock
                SQL = SQL + "'" + Datos(8) + "'," & Chr(10)     '10 Fecven
                SQL = SQL + Datos(9) + "," & Chr(10)            '11 Año
                SQL = SQL + Datos(10) + "," & Chr(10)           '12 Mes
                SQL = SQL + Datos(11) + "," & Chr(10)           '13 Día
                SQL = SQL + "'" + Datos(13) + "'," & Chr(10)    '15 Fecpro
                SQL = SQL + Str(nNum) + "," & Chr(10)           '16 Postotal
                SQL = SQL + cCar + "'" + Datos(11) + "');"         '17 Fecprox
            End If
            db.Execute SQL
        Loop
        LlenaPuntas = True
    Else
        LlenaPuntas = False
        If nSw = 1 Then
            MsgBox "Informe no puede ser Generado", vbExclamation, gsBac_Version
        End If
    End If

End Function



Function Llenar_Oma(Rectif As String, Observaciones As String) As Boolean
Dim SQL As String
Dim Datos()
Dim Rectificado As String

    If Rectif = True Then
        Rectificado = "S"
    Else
        Rectificado = "N"
    End If

    SQL = "DELETE FROM MD_OMA"
    Llenar_Oma = False
    db.Execute SQL

    If miSQL.SQL_Execute("EXECUTE SP_OMA 1") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO Md_OMA VALUES( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + Datos(4) + "," & Chr(10)
            SQL = SQL + Datos(5) + "," & Chr(10)
            SQL = SQL + Datos(6) + "," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(11) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(12) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(13) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(14) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(15) + "' );"

            db.Execute SQL
        Loop
    Else
        MsgBox "Oma no pudo ser Impreso", vbExclamation, gsBac_Version
        Llenar_Oma = False
        Exit Function
    End If

    SQL = "DELETE FROM MD_OMA2"
    db.Execute SQL

    If miSQL.SQL_Execute("SP_OMA 2") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = ""
            SQL = "INSERT INTO MD_OMA2 VALUES( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + Datos(4) + "," & Chr(10)
            SQL = SQL + Datos(5) + "," & Chr(10)
            SQL = SQL + Datos(6) + "," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + Datos(16) + "," & Chr(10)
            SQL = SQL + Datos(17) + "," & Chr(10)
            SQL = SQL + Datos(18) + "," & Chr(10)
            SQL = SQL + Datos(19) + "," & Chr(10)
            SQL = SQL + Datos(20) + "," & Chr(10)
            SQL = SQL + Datos(21) + "," & Chr(10)
            SQL = SQL + Datos(22) + "," & Chr(10)
            SQL = SQL + Datos(23) + "," & Chr(10)
            SQL = SQL + Datos(24) + "," & Chr(10)
            SQL = SQL + Datos(25) + "," & Chr(10)
            SQL = SQL + Datos(26) + "," & Chr(10)
            SQL = SQL + Datos(27) + "," & Chr(10)
            SQL = SQL + "'" + Mid$(CStr(Time), 1, 8) + "'" + "," & Chr(10)
            SQL = SQL + "'" + Rectificado + "'," & Chr(10)
            SQL = SQL + "'" + Observaciones + "'," & Chr(10)
            SQL = SQL + Datos(28) + "," & Chr(10)
            SQL = SQL + Datos(29) + "," & Chr(10)
            SQL = SQL + Datos(30) + "," & Chr(10)
            SQL = SQL + Datos(31) + "," & Chr(10)
            SQL = SQL + Datos(32) + "," & Chr(10)
            SQL = SQL + Datos(33) + "," & Chr(10)
            SQL = SQL + Datos(34) + "," & Chr(10)
            SQL = SQL + Datos(35) + " );"
            db.Execute SQL
        Loop
        Llenar_Oma = True
    Else
        MsgBox "Informe Oma no pudo ser Impreso", vbExclamation, gsBac_Version
        Llenar_Oma = False
    End If

End Function


Function LlenarPaca(Doc$) As Boolean
Dim SQL As String
Dim Datos()

    LlenarPaca = True
    SQL = "DELETE FROM MDPACA;"
    db.Execute SQL

    If miSQL.SQL_Execute("SP_PASEPORCAJA " + Doc$) = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MDPACA VALUES ( " & Chr(10)
            SQL = SQL + Datos(1) + "," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + Datos(6) + "," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + "'" + Datos(12) + "'," & Chr(10)
            SQL = SQL + Datos(13) + ");" & Chr(10)
            db.Execute SQL
        Loop
    Else
        LlenarPaca = False
    End If

End Function
Function LlenarVctoCapVCa() As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM MDVIVC"
    LlenarVctoCapVCa = True
    db.Execute SQL

    If miSQL.SQL_Execute("SP_VCTOCAPVCAMARA") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "NO" Then
                MsgBox "No existen Vencimientos con Vale Camara", vbExclamation, gsBac_Version
                LlenarVctoCapVCa = False
                Exit Function
            End If
            SQL = "INSERT INTO MDVIVC VALUES( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + Datos(8) + " );"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no puede ser procesado", vbExclamation, gsBac_Version
        LlenarVctoCapVCa = False
    End If

End Function

Function LlenarVctoVI() As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM VCTOVI"
    LlenarVctoVI = True
    db.Execute SQL

    If miSQL.SQL_Execute("SP_INFORMEVCTOVI") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO VCTOVI VALUES ( " & Chr(10)
            SQL = SQL + Datos(1) + "," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'" + "," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'" + "," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'" + "," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'" + "," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'" + "," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + Datos(16) + "," & Chr(10)
            SQL = SQL + Datos(17) + "," & Chr(10)
            SQL = SQL + Datos(18) + "," & Chr(10)
            SQL = SQL + Datos(19) + "," & Chr(10)
            SQL = SQL + Datos(20) + "," & Chr(10)
            SQL = SQL + "'" + Datos(21) + "'," & Chr(10)
            SQL = SQL + Datos(22) + "," & Chr(10)
            SQL = SQL + Datos(23) + "," & Chr(10)
            SQL = SQL + Datos(24) + "," & Chr(10)
            SQL = SQL + Datos(25) + "," & Chr(10)
            SQL = SQL + Datos(26) + "," & Chr(10)
            SQL = SQL + Datos(27) + "," & Chr(10)
            SQL = SQL + Datos(28) + "," & Chr(10)
            SQL = SQL + Datos(29) + "," & Chr(10)
            SQL = SQL + Datos(30) + "," & Chr(10)
            SQL = SQL + Datos(31) + "," & Chr(10)
            SQL = SQL + Datos(32) + "," & Chr(10)
            SQL = SQL + Datos(33) + "," & Chr(10)
            SQL = SQL + Datos(34) + " );"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, gsBac_Version
        LlenarVctoVI = False
    End If

End Function



Function LlenarVctoCI() As Boolean
Dim SQL As String

Dim Datos()

    SQL = "DELETE FROM CAINTER"
    LlenarVctoCI = True
    db.Execute SQL

    If miSQL.SQL_Execute("SP_INFORMEVCTOCI") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO CAINTER VALUES( " & Chr(10)
            SQL = SQL + Datos(1) + "," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + "'" + Datos(12) + "'," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + "'" + Datos(15) + "'," & Chr(10)
            SQL = SQL + Datos(1) + " );"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, gsBac_Version
        LlenarVctoCI = False
    End If

End Function
Function LlenarVctoDEP() As Boolean
Dim SQL As String
Dim Datos()

' se ocupa la misma tabla acces de las cartera de interbancarios y Vcto CI
' por que tiene la misma estructura
' no se puede llegar y modificar la estructura

    SQL = "DELETE FROM CAINTER"
    LlenarVctoDEP = True
    db.Execute SQL

    If miSQL.SQL_Execute("SP_INFORMEDEP") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO CAINTER VALUES ( " & Chr(10)
            SQL = SQL + Datos(1) + "," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + "'" + Datos(12) + "'," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + "'" + Datos(14) + "'," & Chr(10)
            SQL = SQL + Datos(1) + " );"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, gsBac_Version
        LlenarVctoDEP = False
    End If

End Function





Function LlenarRCRV(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()
    SQL = "DELETE FROM MDRCRV"
    LlenarRCRV = True
    db.Execute SQL
    SQL = ""
    SQL = "SP_INFORMERCRV 'RC'," & Val(Entidad)

    If Bac_Sql_Execute(SQL) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MDRCRV VALUES( " & Chr(10)
            SQL = SQL + Datos(1) + "," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + "'" + Datos(9) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "' );"
            db.Execute SQL
            valor = 1
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        LlenarRCRV = False
    End If
End Function

Function LlenarCartIB(cTipOper As String, Xenti As String) As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM CAINTER"
    LlenarCartIB = True
    db.Execute SQL

    SQL = "SP_INFORMEIB " + cTipOper & "," & Val(Xenti)
    
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO CAINTER VALUES ( " & Chr(10)
            SQL = SQL + Datos(1) + "," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + "'" + Datos(12) + "'," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + "'" + Datos(15) + "'," & Chr(10)
            SQL = SQL + Datos(16) + "," & Chr(10)
            SQL = SQL + Datos(17) + "," & Chr(10)
            SQL = SQL + Datos(18) + "," & Chr(10)
            SQL = SQL + Datos(19) + "," & Chr(10)
            SQL = SQL + Datos(20) + "," & Chr(10)
            SQL = SQL + Datos(21) + "," & Chr(10)
            SQL = SQL + Datos(22) + ");"
           db.Execute SQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
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
    
    db.Execute cSql

    cSql = "EXECUTE SP_LISTCARTCAPTACION " & Val(Entidad)
    
    If miSQL.SQL_Execute(cSql) = 0 Then
        Do While Bac_SQL_Fetch(Datos())
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
            
            db.Execute cSql
            
            HayDatos = True
        Loop
    Else
       Exit Function
    End If
    
    
    If Not HayDatos Then
       MsgBox "No existen datos para imprimir el reporte", vbOKOnly + vbExclamation
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
    
    db.Execute cSql

    cSql = "EXECUTE SP_LISTMOVCAPTACION " & Val(Entidad)
    
    If miSQL.SQL_Execute(cSql) = 0 Then
        Do While Bac_SQL_Fetch(Datos())
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
            db.Execute cSql
        Loop
    Else
        LlenarMovCaptacion = False
    End If
    If nValor = 0 Then
        LlenarMovCaptacion = False
        MsgBox "No se registran operaciones de captaciones", vbExclamation, gsBac_Version
        Exit Function
    End If
    
End Function


Function Llenar_Cert1(dRutcli As Double, iAno As Integer) As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM CERTIFICADO1"
    Llenar_Cert1 = False
    db.Execute SQL

    SQL = "SP_L0100 1, " + Str(iAno) + "," + Str(dRutcli)

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO CERTIFICADO1 VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + Datos(2) + "," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + Datos(4) + "," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + Datos(6) + "," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + "'" + Datos(9) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(11) + "'," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + Datos(16) + "," & Chr(10)
            SQL = SQL + Datos(17) + "," & Chr(10)
            SQL = SQL + Datos(18) + "," & Chr(10)
            SQL = SQL + "'" + Datos(19) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(20) + "'," & Chr(10)
            SQL = SQL + Datos(21) + "," & Chr(10)
            SQL = SQL + "'" + Datos(22) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(23) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(24) + "'," & Chr(10)
            SQL = SQL + Datos(25) + " );"
            db.Execute SQL
            Llenar_Cert1 = True
        Loop
        If Llenar_Cert1 = False Then
            MsgBox "Cliente no registra operacciones para procesar", vbInformation, gsBac_Version
        End If
    Else
        MsgBox "Certificado no pudo ser Impreso", vbExclamation, gsBac_Version
        Llenar_Cert1 = False
    End If

End Function



Function LlenarMARKTOMARKET() As Boolean
Dim SQL     As String
Dim Datos()

    SQL = "DELETE FROM MARKTOMARKET;"
    LlenarMARKTOMARKET = True
    db.Execute SQL
    
'    Sql = "SELECT CONVERT(CHAR(10),mmfecini,103), CONVERT(CHAR(10),mmfecter,103), mminstser, mmmoneda, mmnominal, CONVERT(CHAR(10),mmfecven,103), mmtirc, mmvptirc, mmtasarg, mmvalor, mmutil, mmtipoper,mmnomemp, mmrutemp, mmrango1, mmrango2, CONVERT(CHAR(10),mmfecpro,103), mmcodinst FROM MDMM ORDER BY mmtipoper"
    SQL = "SP_LLENA_MARK_TO_MARKET "
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MARKTOMARKET VALUES(  " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)     ' Fecha de Inicio
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)     ' Fecha de termino
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)     ' Serie
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)     ' Moneda
            SQL = SQL + Datos(5) + "," & Chr(10)            ' Nominales
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)     ' Fecha de vencimiento
            SQL = SQL + Datos(7) + "," & Chr(10)            ' TIR Compra
            SQL = SQL + Datos(8) + "," & Chr(10)            ' Valor TIR Compra
            SQL = SQL + Datos(9) + "," & Chr(10)            ' Tasa del Mark to Market
            SQL = SQL + Datos(10) + "," & Chr(10)           ' Valor presente
            SQL = SQL + Datos(11) + "," & Chr(10)           ' Diferencia (utilidad / Perdida)
            SQL = SQL + "'" + Datos(12) + "'," & Chr(10)    ' Tipo de operación
            SQL = SQL + "'" + Datos(13) + "'," & Chr(10)    ' Nombre de la institucion
            SQL = SQL + "'" + Datos(14) + "'," & Chr(10)    ' RUT de la institución
            SQL = SQL + Datos(15) + "," & Chr(10)           ' Rango Inicial
            SQL = SQL + Datos(16) + "," & Chr(10)           ' Rango Final
            SQL = SQL + "'" + Datos(17) + "'," & Chr(10)    ' Fecha de Proceso
            SQL = SQL + "'" + Datos(18) + "'" & Chr(10)     ' Codigo del Instrumento
            'MsgBox SQL
            If Datos(12) = "CP" Or Datos(12) = "VI" Then
               SQL = SQL + ",'      ');"
            Else
               SQL = SQL + ",'OPERACIONES CALZADAS');"
            End If
            db.Execute SQL
         Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        LlenarMARKTOMARKET = False
    End If

End Function



Sub LlamaListados(sdesde$, sHasta$, sList$, nEntidad As Double, nTipoReport As Integer)
   Dim TitRpt As String
   
   Screen.MousePointer = vbHourglass
   
   BacTrader.bacrpt.Destination = 0
   
   Call Limpiar_Cristal
   BacTrader.bacrpt.Connect = CONECCION
   cs = 1
   
   Select Case nTipoReport
      
      Case Is = 1: TitvRpt = "VENCIMIENTOS DE CUPONES"
      Case Is = 2: TitvRpt = "VENCIMIENTOS DE INTERBANCARIOS"
      Case Is = 3: TitvRpt = "VENCIMIENTOS DE PACTOS"
   
   End Select
      
      
   Select Case sList$


      Case Is = "VCTOIB" 'Proceso OK
         
         'Proced. Almacenado : SP_REPORTES_VCTOS_INTERBANCARIOS
         BacTrader.bacrpt.WindowTitle = "Vencimientos de Interbancarios"
         BacTrader.bacrpt.ReportFileName = RptList_Path & "VCTO_IB.RPT"
         BacTrader.bacrpt.StoredProcParam(0) = Format(sHasta$, "yyyymmdd")
         
      
      Case Is = "VCTOPACT" 'Proceso OK
         
         'Proced. Almacenado : SP_REPORTES_VCTOS_PACTOS
         BacTrader.bacrpt.WindowTitle = "Vencimientos de Pactos"
         BacTrader.bacrpt.ReportFileName = RptList_Path & "VCTO_VI.RPT"
         BacTrader.bacrpt.StoredProcParam(0) = Format(sdesde$, "yyyymmdd")
         BacTrader.bacrpt.StoredProcParam(1) = Format(sHasta$, "yyyymmdd")

    
      Case Is = "VCTOPAP" ' Proceso OK
           
         'Proced. Almacenado : SP_INFCONVCTO
         BacTrader.bacrpt.WindowTitle = "Vencimientos de Instrumentos"
         BacTrader.bacrpt.ReportFileName = RptList_Path & "VCTO_CUP.RPT"
         BacTrader.bacrpt.StoredProcParam(0) = Format(sHasta$, "yyyymmdd")

         
      Case Is = "VALMON"
               If LlenarValoresMonedas((sdesde$), (sHasta$)) Then
                    'TitRpt = "MOVIMIENTO DIARIO DE COMPRAS CON PACTO"
                    TitRpt = "VALORES DE MONEDAS DEL " & sdesde$ & " AL " & sHasta$
                    BacTrader.bacrpt.Destination = 0
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTMDVM.RPT"
                        ''Not Format$(DteDesde.Text) < gsBac_Fecp
                    BacTrader.bacrpt.StoredProcParam(0) = sdesde$
                    BacTrader.bacrpt.StoredProcParam(1) = sHasta$
                    BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
                    BacTrader.bacrpt.Connect = CONECCION
                    BacTrader.bacrpt.Action = 1
                    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión de valores de monedas")
               End If
   
      Case Is = "VCTODIA" ' Proceso OK
'''''               If XCarteraSuper = "" Then
'''''                  cs = 2
'''''               End If
'''''               For x = 1 To cs
'''''               If cs > 1 Then
'''''                  If x = 1 Then XCarteraSuper = "T": Titulo = "TRANSABLE"
'''''                  If x = 2 Then XCarteraSuper = "P": Titulo = "PERMANENTE"
'''''               End If

           TitRpt = "REPORTE DE VENCIMIENTOS DEL DÍA "
           BacTrader.bacrpt.ReportFileName = RptList_Path & "MDVCD.RPT"
           BacTrader.bacrpt.StoredProcParam(0) = nEntidad
           BacTrader.bacrpt.StoredProcParam(1) = nTipoReport
           BacTrader.bacrpt.StoredProcParam(2) = TitRpt
           BacTrader.bacrpt.StoredProcParam(3) = TitvRpt

'''''         Next
   
   '(INI) LD1-COR-035-Configuración BAC Corpbanca – Tarea: Incorporación de procesos y reportes de limites de permanecia
    Case Is = "VIRF"
                TitRpt = "VENTAS DEFINITIVAS DE IRF CARTERA TRADING DESDE " & Format(sdesde$, "dd/mm/yyyy") & " " & "HASTA " & Format(sHasta$, "dd/mm/yyyy")
                BacTrader.bacrpt.ReportFileName = RptList_Path & "listvpirf.rpt"
                BacTrader.bacrpt.StoredProcParam(0) = nEntidad
                BacTrader.bacrpt.StoredProcParam(1) = TitRpt
                BacTrader.bacrpt.StoredProcParam(2) = Format(sdesde$, "yyyymmdd")
                BacTrader.bacrpt.StoredProcParam(3) = Format(sHasta$, "yyyymmdd")
                BacTrader.bacrpt.Formulas(0) = "tit='" & TitvRpt & "'"
 
    Case Is = "CIRF"
                TitRpt = "COMPRAS DEFINITIVAS DE IRF CARTERA TRADING DESDE " & Format(sdesde$, "dd/mm/yyyy") & " " & "HASTA " & Format(sHasta$, "dd/mm/yyyy")
                BacTrader.bacrpt.ReportFileName = RptList_Path & "listcpifr.rpt"
                BacTrader.bacrpt.StoredProcParam(0) = nEntidad
                BacTrader.bacrpt.StoredProcParam(1) = TitRpt
                BacTrader.bacrpt.StoredProcParam(2) = Format(sdesde$, "yyyymmdd")
                BacTrader.bacrpt.StoredProcParam(3) = Format(sHasta$, "yyyymmdd")
         
          
    Case Is = "CHOLD"
                TitRpt = "DISPONIBILIDAD Y HOLDING PERIOD  DE IRF CARTERA DE TRADING DESDE " & Format(sdesde$, "dd/mm/yyyy") & " " & "HASTA " & Format(sHasta$, "dd/mm/yyyy")
                BacTrader.bacrpt.ReportFileName = RptList_Path & "listcpholding.rpt"
                BacTrader.bacrpt.StoredProcParam(0) = nEntidad
                BacTrader.bacrpt.StoredProcParam(1) = TitRpt
                BacTrader.bacrpt.StoredProcParam(2) = Format(sdesde$, "yyyymmdd")

     '(FIN) LD1-COR-035-Configuración BAC Corpbanca – Tarea: Incorporación de procesos y reportes de limites de permanecia


   End Select
   
   BacTrader.bacrpt.Action = 1
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
    
   Screen.MousePointer = vbDefault
  
End Sub

Function LlenarMDCI(xent As String, Cartera As String) As Boolean
Dim SQL As String
Dim Datos()
Dim valor As Single
valor = 0
    LlenarMDCI = False
    db.Execute "DELETE FROM MDINFOCI;"
    SQL = "SP_INFOCI "
    SQL = SQL + "'" + Cartera + "',"
    SQL = SQL & Val(xent) & ","
    SQL = SQL + "'N'"
    
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
           SQL = "INSERT INTO MDINFOCI VALUES ( " & Chr(10)
           SQL = SQL + "'" + IIf(Cartera = "112", Datos(1), Trim(Str(Val(Datos(2)))) + " / " + Datos(1)) + "'," & Chr(10)   'Numero operacion
           SQL = SQL + "'" + Datos(3) + "'," & Chr(10)                          'Serie
           SQL = SQL + "'" + Datos(4) + "'," & Chr(10)                          'Fecha Vencimiento
           SQL = SQL + Datos(5) + "," & Chr(10)                                 'Nominal
           SQL = SQL + Datos(6) + "," & Chr(10)                                 'TIR
           SQL = SQL + "'" + Datos(7) + "'," & Chr(10)                          'Moneda del Pacto
           SQL = SQL + "'" + Datos(8) + "'," & Chr(10)                          'Fecha Inicio Pacto
           SQL = SQL + "'" + Datos(9) + "'," & Chr(10)                          'Fecha Vencimiento Pacto
           SQL = SQL + Datos(10) + "," & Chr(10)                               'Plazo
           SQL = SQL + Datos(11) + "," & Chr(10)                                'Valor Inicial
           SQL = SQL + Datos(12) + "," & Chr(10)                                'Valor Final
           SQL = SQL + Datos(13) + "," & Chr(10)                                'Tasa del Pacto
           SQL = SQL + Datos(14) + "," & Chr(10)                                'Interes
           SQL = SQL + Datos(15) + "," & Chr(10)                                'Reajuste
           SQL = SQL + Datos(16) + "," & Chr(10)                                'Intereses Acumulados
           SQL = SQL + Datos(17) + "," & Chr(10)                                'Reajustes Acumulados
           SQL = SQL + "'" + Datos(18) + "'," & Chr(10)                         'Familia
           SQL = SQL + "'" + Datos(19) + "'," & Chr(10)                         'Entidad
           SQL = SQL + "'" + Datos(20) + "'," & Chr(10)                         'Valor Presente
           SQL = SQL + Datos(21) + ","                                                  'Moneda de Emisión
           SQL = SQL + "'" + Datos(22) + "',"                                         'Rut
           SQL = SQL + "'" + Datos(23) + "')"                                        'Nombre
            db.Execute SQL
            valor = 1
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbOKOnly + vbCritical, gsBac_Version
        Exit Function
    End If
    If valor = 0 Then
        MsgBox "No hay datos para imprimir informe", vbOKOnly + vbExclamation
        Exit Function
    End If
 
 LlenarMDCI = True
End Function



Function LlenarValoriza() As Boolean
Dim SQL As String
Dim Datos()

    LlenarValoriza = True
    SQL = "DELETE FROM VALORIZA;"
    db.Execute SQL
    
    If Month(gsBac_Fecp) <> Month(gsBac_Fecx) Then
        dFech2 = CDate("01/" + Str(Month(gsBac_Fecx)) + "/" + Str(Year(gsBac_Fecx)))
        dFech1 = DateAdd("d", -1, dFech2)
        cFecCal$ = Trim(Str(Month(dFech1))) + "/" + Trim(Str(Day(dFech1))) + "/" + Trim(Str(Year(dFech1)))
    Else
        cFecCal$ = Trim(Str(Month(gsBac_Fecp))) + "/" + Trim(Str(Day(gsBac_Fecp))) + "/" + Trim(Str(Year(gsBac_Fecp)))
    End If
    

    SQL = "SP_SBIF_INFVAL '" + Format(cFecCal$, "mm/dd/yyyy") + "'"

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO VALORIZA VALUES(  " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + "'" + Datos(11) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(12) + "'," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + Datos(16) + "," & Chr(10)
            SQL = SQL + Datos(17) + "," & Chr(10)
            SQL = SQL + Datos(18) + "," & Chr(10)
            SQL = SQL + Datos(19) + " );"
            db.Execute SQL
        Loop
    Else
        LlenarValoriza = False
        MsgBox "Informe de Valorización Mercado, No puede ser Impreso", vbExclamation, gsBac_Version
    End If

End Function

Function LlenarVctoPap(sdesde$, sHasta$, xentidad As Double) As Boolean
Dim SQL As String
Dim Datos()
Dim xValor  As String: xValor = 0

    LlenarVctoPap = False
    
    SQL = "DELETE FROM VCTOPROPIO;"
    db.Execute SQL

' VB+ 18/05/2000    Sql = "EXECUTE SP_LISTADOVCTOPAP  "

    SQL = "EXECUTE SP_INFCONVCTO  "
    SQL = SQL + "'" + Format(sdesde, "dd/mm/yyyy") + "','" + Format(sHasta, "dd/mm/yyyy") + "'," & xentidad

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO VCTOPROPIO VALUES(  " & Chr(10)
            SQL = SQL & "'" & Datos(1) & "'," & Chr(10)                 'Tipo de Reporte
            SQL = SQL & "'" & CDbl(Datos(2)) & "'," & Chr(10)         'Numero Operación
            SQL = SQL & "'" & Val(Datos(3)) & "'," & Chr(10)           'Correlativo
            SQL = SQL & "'" + Datos(4) & "'," & Chr(10)                  'Instrumento
            SQL = SQL & Datos(5) + "," & Chr(10)                          'Nominal
            SQL = SQL & Datos(6) + "," & Chr(10)                          'Flujo
            SQL = SQL & "'" & Format(Datos(7), "mm/dd/yyyy") & "'," & Chr(10)  'Fecha de Vencimiento
            SQL = SQL & IIf(Val(Datos(8)) = 0, 1, Val(Datos(8))) & "," & Chr(10) 'N° de Cupon
            SQL = SQL & IIf(Val(Datos(9)) = 0, 1, Val(Datos(9))) & "," & Chr(10) 'Total de Cupones
            SQL = SQL & "'" & Datos(10) & "'," & Chr(10)                'Moneda
            SQL = SQL & "'" & Format(Datos(11), "mm/dd/yyyy") & "'," & Chr(10)  'Fecha de Venta
            SQL = SQL & "'" + Datos(12) & "'," & Chr(10)                'Tipo de Operación
            SQL = SQL & Datos(13) + "," & Chr(10)                       'Flujo en UM
            SQL = SQL & "'" & Format(Datos(14), "mm/dd/yyyy") + "'," & Chr(10)  'Fecha de Emisión
            SQL = SQL & Datos(15) + "," & Chr(10)                       'Tasa de Emisión
            SQL = SQL & Datos(16) + "," & Chr(10)                       'Tir de Compra
            SQL = SQL & "'" & Format(Datos(17), "mm/dd/yyyy") + "'," & Chr(10) 'Fecha de Pago
            SQL = SQL & Datos(18) & "," & Chr(10)                       'Tipo de cambio
            SQL = SQL & Datos(19) & "," & Chr(10)                       'Flujo en Pesos
            SQL = SQL & "'" & Datos(20) + "'," & Chr(10)                'Emisor
            SQL = SQL & "'" & Datos(21) + "'," & Chr(10)                'Familia
            SQL = SQL & "'" & Datos(22) + "' );" & Chr(10)              'Entidad
            db.Execute SQL
            xValor = 1
        Loop
    Else
        Exit Function
    End If
    
    If xValor = 0 Then
        MsgBox "No se encontró información de vencimientos de papeles en el rango seleccionado ", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    LlenarVctoPap = True
    
End Function

Function LlenarVctoPact(Ddesde As String, dHasta As String, xentidad As Double) As Boolean
Dim SQL As String
Dim Datos()
Dim xValor  As Integer: xValor = 0

    LlenarVctoPact = False
    
    SQL = "DELETE FROM VCTOPACT;"
    db.Execute SQL

    SQL = "EXECUTE SP_LISTADOVCTOPACT "
    SQL = SQL & "'" & Format(Ddesde, "dd/mm/yyyy") & "','" & Format(dHasta, "dd/mm/yyyy") & "',"
    SQL = SQL & xentidad
    

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO VCTOPACT VALUES (  " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(9) + "'," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + "'" + Datos(12) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(13) + "'," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + Datos(16) + "," & Chr(10)
            SQL = SQL + Datos(17) + "," & Chr(10)
            SQL = SQL + Datos(18) + "," & Chr(10)
            SQL = SQL + "'" + Datos(19) + "');"
            db.Execute SQL
            xValor = 1
        Loop
    Else
        Exit Function
    End If
    
    If xValor = 0 Then
        MsgBox "No se encontró información de vencimientos de compromisos en el rango seleccionado ", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    LlenarVctoPact = True

End Function




Function LlenarCI(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()
Dim valor As Single: valor = 0

    LlenarCI = False

    SQL = "DELETE FROM MDCILIST;"
    db.Execute SQL
    
    SQL = "EXECUTE SP_LISTADOCI "
    SQL = SQL & Val(Entidad)

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MDCILIST(cliente, cartera,tipcart,numdocu,serie,emisor,fecemi,fecven,tasemi,base,monemi,nominal,tir,"
            SQL = SQL & "pvc,tasest,vcompra,fecinip,fecvenp,tasapacto,basepacto,monpacto,valinip,valvenp,forpai,forpav,familia) VALUES ( " & Chr(10)
            SQL = SQL & "'" & Datos(1) & "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + "'" + Datos(11) + "'," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + Datos(16) + "," & Chr(10)
            SQL = SQL + "'" + Datos(17) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(18) + "'," & Chr(10)
            SQL = SQL + Datos(19) + "," & Chr(10)
            SQL = SQL + Datos(20) + "," & Chr(10)
            SQL = SQL + "'" + Datos(21) + "'," & Chr(10)
            SQL = SQL + Datos(22) + "," & Chr(10)
            SQL = SQL + Datos(23) + "," & Chr(10)
            SQL = SQL + "'" + Datos(24) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(25) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(26) + "' );"
            db.Execute SQL
            valor = 1
        Loop
    End If
    
    
    If valor = 0 Then
        MsgBox "No se encontro información correspondiente a operaciones de Compras con Pacto.", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    LlenarCI = True
      
End Function
Function LlenarValoresMonedas(xDesde As Date, xHasta As Date) As Boolean
Dim Datos()

    LlenarValoresMonedas = False

'    Sql = "SP_LISTVALORESMONEDAS '" & Format(xDesde, "yyyymmdd") & "','" & Format(xHasta, "yyyymmdd") & "'"

    Envia = Array(Format(xDesde, "yyyymmdd"), Format(xHasta, "yyyymmdd"))
    If Bac_Sql_Execute("SP_LISTVALORESMONEDAS", Envia) Then
        LlenarValoresMonedas = True
    Else
        MsgBox "Informe no pudo ser Procesado", vbExclamation, gsBac_Version
    End If

End Function

Function LlenarTablasGenerales() As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM LISTTABG;"
    LlenarTablasGenerales = True
    db.Execute SQL

    If miSQL.SQL_Execute("SP_LISTTABLASGENERALES") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO LISTTABG VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + Datos(4) + "," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "');"
            'MsgBox Sql
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        LlenarTablasGenerales = False
    End If

End Function

Function LlenarFamilias() As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM MANTFAMILIA;"
    LlenarFamilias = True
    db.Execute SQL

    If miSQL.SQL_Execute("execute SP_LISTMANTFAMILIA") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MANTFAMILIA VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + Datos(4) + "," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(11) + "'," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + "'" + Datos(13) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(14) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(15) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(16) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(17) + "');"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        LlenarFamilias = False
    End If

End Function


Function LlenarClientes() As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM CLIENTES;"
    LlenarClientes = True
    db.Execute SQL

    If miSQL.SQL_Execute("EXECUTE SP_LISTCLIENTES") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO CLIENTES VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + Datos(5) + "," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(9) + "'," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + "'" + Datos(11) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(12) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(13) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(14) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(15) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(16) + "');"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        LlenarClientes = False
    End If

End Function

Function LlenarCarteras() As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM CARTERAS;"
    LlenarCarteras = True
    db.Execute SQL

    If miSQL.SQL_Execute("SP_LISTCARTERAS") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO CARTERAS VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + Datos(5) + "," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(9) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "');"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        LlenarCarteras = False
    End If

End Function


Function LlenarEmisores() As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM EMISORES;"
    LlenarEmisores = True
    db.Execute SQL

    If miSQL.SQL_Execute("SP_LISTEMISORES") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO EMISORES VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + Datos(5) + "," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(9) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "');"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        LlenarEmisores = False
    End If

End Function



Function LlenarTM() As Boolean
Dim Datos()

    LlenarTM = True
    db.Execute "DELETE FROM TASAMERCADO;"

    If miSQL.SQL_Execute("SP_SBIF_INFTASAMER") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO TASAMERCADO VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + Datos(9) & "," & Chr(10)
            SQL = SQL + Datos(10) & "" & Chr(10)
            SQL = SQL + ");"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        LlenarTM = False
    End If

End Function




Function LlenarVI(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()
Dim valor As Integer: valor = 0

    LlenarVI = False

    SQL = "DELETE FROM MDVI;"
    db.Execute SQL
    
    
    SQL = " EXECUTE SP_LISTADOVI "
    SQL = SQL & Val(Entidad)
    
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MDVI( cliente,cartera,tipcart,numdocu,serie,emisor,fecemi,fecven,tasemi,base,monemi,nominal,tir,pvp,tasest,venta,"
            SQL = SQL & "fecinip,fecvenp,tasapacto,basepacto,monpacto,valinip,valvenp,forpai,forpav,familia,numoper) VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + "'" + Datos(11) + "'," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + Datos(16) + "," & Chr(10)
            SQL = SQL + "'" + Datos(17) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(18) + "'," & Chr(10)
            SQL = SQL + Datos(19) + "," & Chr(10)
            SQL = SQL + Datos(20) + "," & Chr(10)
            SQL = SQL + "'" + Datos(21) + "'," & Chr(10)
            SQL = SQL + Datos(22) + "," & Chr(10)
            SQL = SQL + Datos(23) + "," & Chr(10)
            SQL = SQL + "'" + Datos(24) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(25) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(26) + "'," & Chr(10)
            SQL = SQL + "'" & CDbl(Datos(27)) & "' );"
 '           Sql = Sql + "'" + Datos(27) + "' );"
            db.Execute SQL
            valor = 1
        Loop
    End If
    
    If valor = 0 Then
        MsgBox "No se encontro información correspondiente a operaciones de Ventas con Pacto.", vbExclamation, gsBac_Version
        Exit Function
    End If
       
    LlenarVI = True
    
End Function


Function LlenarIB(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()
Dim valor As Single: valor = 0


    LlenarIB = False

    SQL = "DELETE FROM MDIB;"
    db.Execute SQL
    
    SQL = "EXECUTE SP_LISTADOIB " & Val(Entidad)
    
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MDIB VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + CStr(Val(Datos(7))) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(11) + "'," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + Datos(16) + "," & Chr(10)
            SQL = SQL + "'" + Datos(17) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(18) + "','" + Datos(19) + "' );"
            db.Execute SQL
            valor = 1
        Loop
    End If
    
    
    If valor = 0 Then
        MsgBox "No se encontro información correspondiente a operaciones de Interbancarios", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    LlenarIB = True
    
End Function

Function LlenarCUCP(Entidad As String) As Boolean
Dim Datos()

    LlenarCUCP = True
    gSQL = "DELETE FROM CUCP;"
    db.Execute gSQL
    gSQL = "EXECUTE SP_LISTADOCUCP " & Val(Entidad)
    If miSQL.SQL_Execute(gSQL) = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            gSQL = "INSERT INTO CUCP VALUES ( " & Chr(10)
            gSQL = gSQL + "'" + Datos(1) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(2) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(3) + "'," & Chr(10)
            gSQL = gSQL + "'" + Datos(4) + "'," & Chr(10)
            gSQL = gSQL + Datos(5) + "," & Chr(10)
            gSQL = gSQL + Datos(6) + "," & Chr(10)
            gSQL = gSQL + Datos(7) + "," & Chr(10)
            gSQL = gSQL + Datos(8) + ",' " & Datos(9) & "','" & Datos(10) & "','" & Datos(11) & "'  );"
            db.Execute gSQL
        Loop
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        LlenarCUCP = False
    End If

End Function


Function LlenarVP(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()
Dim valor As Integer: valor = 0

    LlenarVP = False

    SQL = "DELETE FROM MDVP;"
    db.Execute SQL
    
    
    SQL = "EXECUTE SP_LISTADOVP "
    SQL = SQL & Val(Entidad)
   
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = ""
            SQL = "INSERT INTO MDVP(cliente,cartera,tipcart,numdocu,serie,emisor,fecemi,fecven,tasemi,"
            SQL = SQL & "base,moneda,nominal,tir,pvp,tasest,mtops,valventa,utilidad,forpa,tipcust,phoy,familia,numoper) VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + "'" + Datos(11) + "'," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + Datos(16) + "," & Chr(10)
            SQL = SQL + Datos(17) + "," & Chr(10)
            SQL = SQL + Datos(18) + "," & Chr(10)
            SQL = SQL + "'" + Datos(19) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(20) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(21) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(22) + "'," & Chr(10)
            SQL = SQL + Datos(23) + " );"
            db.Execute SQL
            valor = 1
        Loop
    End If
    
    If valor = 0 Then
        MsgBox "No se encontró información correspondiente a operaciones de Ventas definitivas", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    LlenarVP = True
     
End Function


Function LlenarAN(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()
Dim valor As Integer: valor = 0

    LlenarAN = False

    SQL = "DELETE FROM MDAN;"
    db.Execute SQL
    
    
    SQL = "EXECUTE SP_LISTADOAN " & Val(Entidad)
    
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MDAN VALUES( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + "'" + Datos(13) + "','" + Datos(14) + "','" + Datos(15) + "' );"
            db.Execute SQL
            valor = 1
        Loop
    End If
    
    If valor = 0 Then
        MsgBox "No se encontro información correspondiente a operaciones Anuladas.", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    LlenarAN = True

End Function

Function LlenarRC(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()
Dim valor As Integer: valor = 0

    LlenarRC = False
    
    SQL = "DELETE FROM MDRC;"
    db.Execute SQL
    
    SQL = "EXECUTE SP_LISTADORC " & Val(Entidad)

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MDRC VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + "'" + Datos(13) + "'," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + "'" + Datos(16) + "'," & Chr(10)
            SQL = SQL + Datos(17) + "," & Chr(10)
            SQL = SQL + Datos(18) + "," & Chr(10)
            SQL = SQL + "'" + Datos(19) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(20) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(21) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(22) + "', '" & Datos(23) & "'," & Datos(24) & " );"
           db.Execute SQL
           valor = 1
        Loop
    End If
    
    If valor = 0 Then
        MsgBox "No se encontro información correspondiente a operaciones de Recompras", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    LlenarRC = True
    
End Function

Function Inf_VctoVcPactos(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()
    SQL = "DELETE FROM CAINTER;"
    Inf_VctoVcPactos = True
    db.Execute SQL
    SQL = "SP_INFORMEVCTOCI " & Val(Entidad)
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO CAINTER VALUES( " & Chr(10)
            SQL = SQL + Datos(1) + "," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + "'" + Datos(12) + "'," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + "'" + Datos(15) + "'," & Chr(10)
            SQL = SQL + Datos(1) + " );"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, gsBac_Version
        Inf_VctoVcPactos = False
    End If

End Function
Function Inf_VctoVvPactos(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM VCTOVI"
    Inf_VctoVvPactos = True
    db.Execute SQL
    SQL = "SP_INFORMEVCTOVI " & Val(Entidad)
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO VCTOVI VALUES ( " & Chr(10)
            SQL = SQL + Datos(1) + "," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'" + "," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'" + "," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'" + "," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'" + "," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'" + "," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + Datos(16) + "," & Chr(10)
            SQL = SQL + Datos(17) + "," & Chr(10)
            SQL = SQL + Datos(18) + "," & Chr(10)
            SQL = SQL + Datos(19) + "," & Chr(10)
            SQL = SQL + Datos(20) + "," & Chr(10)
            SQL = SQL + "'" + Datos(21) + "'," & Chr(10)
            SQL = SQL + Datos(22) + "," & Chr(10)
            SQL = SQL + Datos(23) + "," & Chr(10)
            SQL = SQL + Datos(24) + "," & Chr(10)
            SQL = SQL + Datos(25) + "," & Chr(10)
            SQL = SQL + Datos(26) + "," & Chr(10)
            SQL = SQL + Datos(27) + "," & Chr(10)
            SQL = SQL + Datos(28) + "," & Chr(10)
            SQL = SQL + Datos(29) + "," & Chr(10)
            SQL = SQL + Datos(30) + "," & Chr(10)
            SQL = SQL + Datos(31) + "," & Chr(10)
            SQL = SQL + Datos(32) + "," & Chr(10)
            SQL = SQL + Datos(33) + "," & Chr(10)
            SQL = SQL + Datos(34) + " );"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, gsBac_Version
        Inf_VctoVvPactos = False
    End If
End Function





Function LlenarRV(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()
Dim valor As Integer: valor = 0

    LlenarRV = False

    SQL = "DELETE FROM MDRV;"
    db.Execute SQL
    
    SQL = "SP_LISTADORV " & Val(Entidad)
    
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MDRV VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + Datos(10) + "," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + "'" + Datos(13) + "'," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + "'" + Datos(16) + "'," & Chr(10)
            SQL = SQL + Datos(17) + "," & Chr(10)
            SQL = SQL + Datos(18) + "," & Chr(10)
            SQL = SQL + "'" + Datos(19) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(20) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(21) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(22) + "', '" & Datos(23) & "'," & Datos(24) & " );"
           db.Execute SQL
           valor = 1
        Loop
    End If
    
    If valor = 0 Then
        MsgBox "No se encontro información correspondiente a operaciones de Reventas", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    LlenarRV = True
    
End Function
Function Llenarmdb(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()
Dim valor As Integer: valor = 0
    
    Llenarmdb = False
    SQL = "DELETE FROM MOVMDCP;"
    db.Execute SQL
    
    SQL = "SP_LISTCP " & Val(Entidad)
    
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MOVMDCP VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "','" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "','" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "','" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "','" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," + Datos(10) + "," & Chr(10)
            SQL = SQL + "'" + Datos(11) + "'," + Datos(12) + "," & Chr(10)
            SQL = SQL + Datos(13) + "," + Datos(14) + "," & Chr(10)
            SQL = SQL + Datos(15) + "," + Datos(16) + "," & Chr(10)
            SQL = SQL + Datos(17) + ",'" + Datos(18) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(19) + "','" + Datos(20) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(21) + "','" + Datos(22) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(23) + "','" + Format(gsBac_Fecp, "dd/mm/yyyy") + "','" + Datos(25) + "' );"
            db.Execute SQL
            valor = 1
        Loop
    End If
    
    If valor = 0 Then
        MsgBox "No se encontro información correspondiente a operaciones de Compras Propias", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    Llenarmdb = True
    
End Function

Function LlenarINFOMDSE(cSerie$) As Boolean
Dim Datos()

    LlenarINFOMDSE = True
    
'    Sql = "SP_INFOR_SERIES '" + cSerie$ + "'"
    
    Envia = Array(cSerie)
    
    If Bac_Sql_Execute("SP_INFOR_SERIES", Envia) Then
    Else
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
        LlenarINFOMDSE = False
    End If

End Function
Function ImprimePapeleta(sRutCart$, sNumoper$, sTipOper$, sOpT$, Optional RutCli$, Optional Correlativo$, Optional lcgp As Integer) As String

On Error GoTo ErrPrinter

    ImprimePapeleta = "SI"
    gsTipoPapeleta = "P"
    Call Limpiar_Cristal
    BacTrader.bacrpt.Destination = crptToWindow
   ' BacTrader.bacrpt.Destination = gsBac_Papeleta

    If sTipOper = "CI" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDCI1.RPT"    'Hasta aqui voy
            Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.StoredProcParam(3) = GLB_CARTERA_NORMATIVA
            BacTrader.bacrpt.StoredProcParam(4) = GLB_LIBRO
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
            
    ElseIf sTipOper = "CP" Then
            BacTrader.bacrpt.WindowState = crptMaximized
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDCP1.RPT"
            Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.StoredProcParam(3) = GLB_CARTERA
            BacTrader.bacrpt.StoredProcParam(4) = GLB_CARTERA_NORMATIVA
            BacTrader.bacrpt.StoredProcParam(5) = GLB_LIBRO
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1

    ElseIf sTipOper = "VP" Or sTipOper = "ST" Then
        If sTipOper = "VP" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDVP1.RPT"
            Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.StoredProcParam(3) = sTipOper
            BacTrader.bacrpt.StoredProcParam(4) = GLB_CARTERA
            BacTrader.bacrpt.StoredProcParam(5) = GLB_CARTERA_NORMATIVA
            BacTrader.bacrpt.StoredProcParam(6) = GLB_LIBRO
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
        Else
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDST1.RPT"
            Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.StoredProcParam(3) = "VP"
            BacTrader.bacrpt.StoredProcParam(4) = GLB_CARTERA
            BacTrader.bacrpt.StoredProcParam(5) = GLB_CARTERA_NORMATIVA
            BacTrader.bacrpt.StoredProcParam(6) = GLB_LIBRO
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Destination = crptToWindow
            BacTrader.bacrpt.Action = 1
            Exit Function
        End If
   ElseIf sTipOper = "VI" Then
            'REQ Nro 7
            'If RutCli$ = "97029000" And sTipOper = "IB" Then   ' banco central
            '   BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDV2.RPT"
            '   BacTrader.bacrpt.StoredProcParam(0) = RutCli$
            '  Else
           If RutCli$ = "97029000" Then    ' banco central
                BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDVI_RP.RPT"
                If lcgp = 0 Then
                    BacTrader.bacrpt.Formulas(0) = "Titulo ='VENTA CON PACTO REPOS'"
                Else
                    BacTrader.bacrpt.Formulas(0) = "Titulo ='VENTA CON PACTO REPOS LCGP'"
                End If
           Else
           
                BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDVI1.RPT"
                BacTrader.bacrpt.Formulas(0) = "Titulo =''"
           End If

           Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.StoredProcParam(3) = GLB_CARTERA
            BacTrader.bacrpt.StoredProcParam(4) = GLB_CARTERA_NORMATIVA
            BacTrader.bacrpt.StoredProcParam(5) = GLB_LIBRO
'            If lcgp = 0 Then
'                BacTrader.bacrpt.Formulas(0) = "Titulo ='VENTA CON PACTO REPOS'"
'            Else
'                BacTrader.bacrpt.Formulas(0) = "Titulo ='VENTA CON PACTO REPOS LCGP'"
'            End If
            
            'End If
            
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
         
            '--> PROD 6006 Se agrega reporte de agrupacion x Cartera Normativa y Serie
            Call Limpiar_Cristal
            BacTrader.bacrpt.ReportFileName = RptList_Path & "Papeleta_VI_TotxSer.rpt"
            Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
               '--> Procedimiento Almacenado: SP_PAPELETA_VENTA_CON_PACTO
            BacTrader.bacrpt.StoredProcParam(0) = Format(gsBac_Fecp, "YYYY-MM-DD 00:00:00.000")
            BacTrader.bacrpt.StoredProcParam(1) = CDbl(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = "P"
            'BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
            
            If RutCli$ = "97029000" Then    ' banco central
            '   BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDVI_RP.RPT"
                If lcgp = 0 Then
                    BacTrader.bacrpt.Formulas(0) = "Titulo ='TOTALES VENTA CON PACTO REPOS'"
                Else
                    BacTrader.bacrpt.Formulas(0) = "Titulo ='TOTALES VENTA CON PACTO REPOS LCGP'"
                End If
            Else
                BacTrader.bacrpt.Formulas(0) = "Titulo ='TOTALES VENTA CON PACTO'"
            End If
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
         
   ElseIf sTipOper = "IB" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAINTER.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.StoredProcParam(3) = ""    'esto faltaba
            BacTrader.bacrpt.StoredProcParam(4) = ""
            BacTrader.bacrpt.StoredProcParam(5) = ""
            BacTrader.bacrpt.StoredProcParam(6) = ""
            BacTrader.bacrpt.StoredProcParam(7) = ""
            BacTrader.bacrpt.Formulas(0) = "Titulo = '" & "" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
    
   ElseIf sTipOper = "RCA" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDRCA.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = gsBac_RutC
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
            
    ElseIf sTipOper = "RVA" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDRVA.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
        
    ElseIf sTipOper = "ST" Then
    
            If LlenarPAMDVP(sRutCart$, sNumoper$, sTipOper) Then
                BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDST.RPT"
                BacTrader.bacrpt.Action = 1
            Else
                ImprimePapeleta = "NO"
            End If
    ElseIf sTipOper = "IC" Then
            'MODIFICADO LD1-COR-035
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PACAPTA1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(1) = Format(gsBac_Fecp, "YYYY-MM-DD 00:00:00.000")
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
            
    ElseIf sTipOper = "AC" Then
        If LlenarPACAPTAANT(sRutCart$, sNumoper$, "ANTICIPO") Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAANTCAP.RPT"
            BacTrader.bacrpt.Action = 1
        Else
            ImprimePapeleta = "NO"
        End If
        
    ElseIf sTipOper = "CPP" Then
            BacTrader.bacrpt.WindowState = crptMaximized
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAPECPP.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
        
   ElseIf sTipOper = "FLI" Then
        BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMFLI.RPT"
            Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
        BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
        BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
        BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
        BacTrader.bacrpt.StoredProcParam(3) = GLB_CARTERA
        BacTrader.bacrpt.StoredProcParam(4) = GLB_CARTERA_NORMATIVA
        BacTrader.bacrpt.StoredProcParam(5) = GLB_LIBRO

        BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1

    ElseIf sTipOper = "FLIP" Then

        BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMFLI_PAGOS.RPT"
        Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
        BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
        BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
        BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
        BacTrader.bacrpt.StoredProcParam(3) = Correlativo
        BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "" & "'"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
     
        
    End If

    BacTrader.bacrpt.Destination = 0
    Exit Function
    
ErrPrinter:

    MsgBox "Problemas en impresión de comprobantes de operación: " & err.Description, vbExclamation, gsBac_Version
    Exit Function
    
End Function



Function LlenarPAINTER(Rut$, Doc$) As Boolean
Dim SQL As String
Dim Datos()

    LlenarPAINTER = True
    SQL = "DELETE FROM PAINTERBAN;"
    db.Execute SQL

    SQL = "SP_PAPELETAIB  "
    SQL = SQL + Rut$ + ","
    SQL = SQL + Doc$ + ","
    SQL = SQL + gsTipoPapeleta

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO PAINTERBAN VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + Datos(5) + "," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(11) + "'," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + "'" + Datos(13) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(14) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(15) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(16) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(17) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(18) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(19) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(20) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(21) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(22) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(23) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(24) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(25) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(26) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(27) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(28) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(29) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(30) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(31) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(32) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(33) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(34) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(35) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(36) + "'," & Chr(10)
            SQL = SQL + Datos(37) + "," & Chr(10)
            SQL = SQL + "'" + Datos(38) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(39) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(40) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(41) + "'," & Chr(10)   'se agrega hora de impresion (Miguel Gajardo)
            SQL = SQL + "'" + Datos(42) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(43) + "');"
            db.Execute SQL
        Loop
    Else
        LlenarPAINTER = False
    End If

End Function


Function Inf_VctoDPosito(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()

' se ocupa la misma tabla access de las cartera de interbancarios y Vcto CI
' por que tiene la misma estructura
' no se puede llegar y modificar la estructura

    SQL = "DELETE FROM CAINTER"
    Inf_VctoDPosito = True
    db.Execute SQL
    SQL = "SP_INFORMEDEP " & Val(Entidad)

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO CAINTER VALUES ( " & Chr(10)
            SQL = SQL + Datos(1) + "," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + "'" + Datos(12) + "'," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + "'" + Datos(14) + "'," & Chr(10)
            SQL = SQL + Datos(1) + " );"
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no puede ser Generado", vbExclamation, gsBac_Version
        Inf_VctoDPosito = False
    End If
End Function
Function Inf_VctoCCamara(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM MDVIVC"
    Inf_VctoCCamara = True
    db.Execute SQL
    SQL = "SP_VCTOCAPVCAMARA " & Val(Entidad)
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "NO" Then
                Inf_VctoCCamara = True
                Exit Function
            End If
            SQL = "INSERT INTO MDVIVC VALUES( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + Datos(8) + "," & Chr(10)
            SQL = SQL + Datos(11) + " ) ; "
            db.Execute SQL
        Loop
    Else
        MsgBox "Informe no puede ser procesado", vbExclamation, gsBac_Version
        Inf_VctoCCamara = False
    End If

End Function
'Nuevas Funcion Aderidas (FIN): Marcos Jimenez
'---------------------------------
'---------------------------------


Function LlenarPAMDCI(Rut$, Doc$) As Boolean
Dim SQL As String
Dim Datos()

    LlenarPAMDCI = True
    SQL = "DELETE FROM PAMDCI;"
    db.Execute SQL

    SQL = "EXECUTE SP_PAPELETACI "
    SQL = SQL + Rut$ + ","
    SQL = SQL + Doc$ + ","
    SQL = SQL + gsTipoPapeleta

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO PAMDCI VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + Datos(6) + "," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + "'" + Datos(14) + "'," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + "'" + Datos(16) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(17) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(18) + "'," & Chr(10)
            SQL = SQL + Datos(19) + "," & Chr(10)
            SQL = SQL + Datos(20) + "," & Chr(10)
            SQL = SQL + Datos(21) + "," & Chr(10)
            SQL = SQL + "'" + Datos(22) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(23) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(24) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(25) + "'," & Chr(10)
            SQL = SQL + Datos(26) + "," & Chr(10)
            SQL = SQL + "'" + Datos(27) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(28) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(29) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(30) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(31) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(32) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(33) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(34) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(35) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(36) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(37) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(38) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(39) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(40) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(41) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(42) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(43) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(44) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(45) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(46) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(47) + "'," & Chr(10)
            SQL = SQL + Datos(48) + "," & Chr(10)
            ' El 49 no se Debe Ocupar
            SQL = SQL + Datos(50) + "," & Chr(10)
            SQL = SQL + Datos(51) + "," + Chr(10)
            SQL = SQL + "'" + Datos(52) + "'," + Chr(10)
            SQL = SQL + "'" + Datos(53) + "'," + Chr(10)
            SQL = SQL + "'" + Datos(54) + "'," + Chr(10)
            SQL = SQL + "'" + Datos(55) + "'," + Chr(10)
            SQL = SQL + "'" + Datos(56) + "');"
            db.Execute SQL
        Loop
    Else
        LlenarPAMDCI = False
    End If

End Function


Function LlenarPAMDRVA(Rut$, Doc$) As Boolean
Dim SQL As String
Dim Datos()

    LlenarPAMDRVA = True
    SQL = "DELETE FROM PAMDRVA;"
    db.Execute SQL

    SQL = "SP_PAPELETARVA "
    SQL = SQL + Rut$ + ","
    SQL = SQL + Doc$ + ","
    SQL = SQL + gsTipoPapeleta

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = ""
            SQL = "INSERT INTO PAMDRVA VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + Datos(6) + "," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL & Val(Datos(9)) & "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL & Val(Datos(11)) & "," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + "'" + Datos(14) + "'," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + "'" + Datos(16) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(17) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(18) + "'," & Chr(10)
            SQL = SQL + Datos(19) + "," & Chr(10)
            SQL = SQL + Datos(20) + "," & Chr(10)
            SQL = SQL + Datos(21) + "," & Chr(10)
            SQL = SQL + "'" + Datos(22) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(23) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(24) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(25) + "'," & Chr(10)
            SQL = SQL + Datos(26) + "," & Chr(10)
            SQL = SQL + "'" + Datos(27) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(28) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(29) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(30) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(31) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(32) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(33) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(34) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(35) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(36) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(37) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(38) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(39) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(40) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(41) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(42) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(43) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(44) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(45) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(46) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(47) + "'," & Chr(10)
            SQL = SQL + Datos(48) + "," & Chr(10)
            ' El 49 no se Debe Ocupar
            SQL = SQL + Datos(50) + "," & Chr(10)
            SQL = SQL + Datos(51) + "," & Chr(10)
            SQL = SQL + "'" + Datos(52) + "'," & Chr(10)
            SQL = SQL + Datos(53) + "," & Chr(10)
            SQL = SQL + Datos(54) + "," & Chr(10)
            SQL = SQL + Datos(55) + "," & Chr(10)
            SQL = SQL + "'" + Datos(56) + "'," & Chr(10)
            SQL = SQL + Datos(57) + "," & Chr(10)
            SQL = SQL & Datos(58) & "," & Chr(10)
            SQL = SQL & "'" & Datos(59) & "' );" & Chr(10)

            db.Execute SQL
        Loop
    Else
        LlenarPAMDRVA = False
    End If

End Function



Function LlenarPAMDCP(Rut$, Doc$) As Boolean
Dim SQL As String
Dim Datos()

    LlenarPAMDCP = True
    
    db.Execute "DELETE * FROM PAMDCP"

    SQL = "SP_PAPELETACP "
    SQL = SQL + Rut$ + ","
    SQL = SQL + Doc$ + ","
    SQL = SQL + gsTipoPapeleta

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO PAMDCP VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + Datos(6) + "," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + "'" + Datos(14) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(15) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(16) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(17) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(18) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(19) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(20) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(21) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(22) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(23) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(24) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(25) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(26) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(27) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(28) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(29) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(30) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(31) + "'," & Chr(10)
            SQL = SQL + Datos(32) + "," & Chr(10)
            SQL = SQL + Datos(33) + "," & Chr(10)
            SQL = SQL + "'" + Datos(34) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(35) + "'," & Chr(10)
            SQL = SQL + Datos(36) + "," & Chr(10)
          ' El 37 no se Debe Ocupar
            SQL = SQL + Datos(38) + "," & Chr(10)
            SQL = SQL + Datos(39) + "," & Chr(10)
            SQL = SQL + Datos(40) + "," & Chr(10)
            SQL = SQL + Datos(41) + "," & Chr(10)
            SQL = SQL + Datos(42) + "," & Chr(10)
            SQL = SQL + "'" + Datos(43) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(44) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(45) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(46) + "'," & Chr(10)
            
            SQL = SQL + "'" + Datos(47) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(48) + "');"
            db.Execute SQL
        Loop
    Else
        LlenarPAMDCP = False
    End If

End Function

Function LlenarPACAPTA(Rut$, Doc$, Estado$) As Boolean
Dim SQL As String
Dim Datos()
Dim p As Boolean
Dim Estado_Operacion As String

    p = False

    LlenarPACAPTA = False
    
    db.Execute "DELETE * FROM PACAPTACION"

    SQL = "SP_PAPELETAIC "
    SQL = SQL + Doc$

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
        
            If Datos(29) = "A" Then
               Estado_Operacion = "ANULADA"
            Else
               Estado_Operacion = Estado$
            End If
            
            SQL = "INSERT INTO PACAPTACION VALUES ( " & Chr(10)
            SQL = SQL & "'" & Datos(1) & "'," & Chr(10)                         '1 Fecha de Proceso
            SQL = SQL & "'" & Datos(2) & "'," & Chr(10)                         '2 Rut Cartera
            SQL = SQL & Datos(3) & "," & Chr(10)                                '3 Numero de Documento
            SQL = SQL & Datos(4) & "," & Chr(10)                                '4 Correlativo
            SQL = SQL & Datos(5) & "," & Chr(10)                                '5 Numero de Operación
            SQL = SQL & "'" & Datos(6) & "'," & Chr(10)                         '6 Tipo de Operación
            SQL = SQL & Datos(7) & "," & Chr(10)                                '7 Nominal
            SQL = SQL & Datos(8) & "," & Chr(10)                                '8 Valor Inicial $$
            SQL = SQL & Datos(9) & "," & Chr(10)                                '9 Tasa
            SQL = SQL & Datos(10) & "," & Chr(10)                               '10 Tasa Transacción
            SQL = SQL & "'" & Datos(11) & "'," & Chr(10)                        '11 Fecha Inicio
            SQL = SQL & "'" & Datos(12) & "'," & Chr(10)                        '12 Fecha Vencimiento
            SQL = SQL & Datos(13) & "," & Chr(10)                               '13 Plazo
            SQL = SQL & Datos(14) & "," & Chr(10)                               '14 Valor Inicio UM
            SQL = SQL & Datos(15) & "," & Chr(10)                               '15 Valor Final UM
            SQL = SQL & "'" & Datos(16) & "'," & Chr(10)                        '16 Moneda
            SQL = SQL & "'" & Datos(17) & "'," & Chr(10)                        '17 Forma de Pago al Inicio
            SQL = SQL & "'" & Datos(18) & "'," & Chr(10)                        '18 Rut Cliente
            SQL = SQL & "'" & Datos(20) & "'," & Chr(10)                        '19 Tipo Retiro
            SQL = SQL & "'" & Datos(21) & "'," & Chr(10)                        '20 Custodia
            SQL = SQL & "'" & Datos(22) & "'," & Chr(10)                        '21 Hora
            SQL = SQL & "'" & Datos(23) & "'," & Chr(10)                        '22 Usuario
            SQL = SQL & "'" & Datos(24) & "'," & Chr(10)                        '23 Terminal
            SQL = SQL & "'" & Datos(25) & "'," & Chr(10)                        '24 Tipo Deposito
            SQL = SQL & "'" & Datos(26) & "'," & Chr(10)                        '25 Entidad
            SQL = SQL & "'" & Datos(27) & "'," & Chr(10)                         '26 Cliente
            SQL = SQL & Datos(28) & ",'" & Estado_Operacion & Chr(10)
            SQL = SQL & "' );"
            db.Execute SQL
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


Function LlenarPACAPTAANT(Rut$, Doc$, Estado$) As Boolean
Dim SQL As String
Dim Datos()
Dim p As Boolean
Dim Estado_Operacion As String

    p = False

    LlenarPACAPTAANT = False
    
    db.Execute "DELETE * FROM papantcapta"

    SQL = "SP_PAPELETAANTIC "
    SQL = SQL + Doc$

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
        
            If Datos(29) = "A" Then
               Estado_Operacion = "ANULADA"
            Else
               Estado_Operacion = Estado$
            End If
            
            SQL = "INSERT INTO papantcapta VALUES ( " & Chr(10)
            SQL = SQL & "'" & Datos(1) & "'," & Chr(10)                         '1 Fecha de Proceso
            SQL = SQL & "'" & Datos(2) & "'," & Chr(10)                         '2 Rut Cartera
            SQL = SQL & Datos(3) & "," & Chr(10)                                '3 Numero de Documento
            SQL = SQL & Datos(4) & "," & Chr(10)                                '4 Correlativo
            SQL = SQL & Datos(5) & "," & Chr(10)                                '5 Numero de Operación
            SQL = SQL & "'" & Datos(6) & "'," & Chr(10)                         '6 Tipo de Operación
            SQL = SQL & Datos(7) & "," & Chr(10)                                '7 Nominal
            SQL = SQL & Datos(8) & "," & Chr(10)                                '8 Valor Inicial $$
            SQL = SQL & Datos(9) & "," & Chr(10)                                '9 Tasa
            SQL = SQL & Datos(10) & "," & Chr(10)                               '10 Tasa Transacción
            SQL = SQL & "'" & Datos(11) & "'," & Chr(10)                        '11 Fecha Inicio
            SQL = SQL & "'" & Datos(12) & "'," & Chr(10)                        '12 Fecha Vencimiento
            SQL = SQL & Datos(13) & "," & Chr(10)                               '13 Plazo
            SQL = SQL & Datos(14) & "," & Chr(10)                               '14 Valor Inicio UM
            SQL = SQL & Datos(15) & "," & Chr(10)                               '15 Valor Final UM
            SQL = SQL & "'" & Datos(16) & "'," & Chr(10)                        '16 Moneda
            SQL = SQL & "'" & Datos(17) & "'," & Chr(10)                        '17 Forma de Pago al Inicio
            SQL = SQL & "'" & Datos(18) & "'," & Chr(10)                        '18 Rut Cliente
            SQL = SQL & "'" & Datos(20) & "'," & Chr(10)                        '19 Tipo Retiro
            SQL = SQL & "'" & Datos(21) & "'," & Chr(10)                        '20 Custodia
            SQL = SQL & "'" & Datos(22) & "'," & Chr(10)                        '21 Hora
            SQL = SQL & "'" & Datos(23) & "'," & Chr(10)                        '22 Usuario
            SQL = SQL & "'" & Datos(24) & "'," & Chr(10)                        '23 Terminal
            SQL = SQL & "'" & Datos(25) & "'," & Chr(10)                        '24 Tipo Deposito
            SQL = SQL & "'" & Datos(26) & "'," & Chr(10)                        '25 Entidad
            SQL = SQL & "'" & Datos(27) & "'," & Chr(10)                         '26 Cliente
            SQL = SQL & Datos(28) & ",'" & Estado_Operacion & "'," & Chr(10)
            SQL = SQL & Datos(30) & ","
            SQL = SQL & Datos(31) & "," & Chr(10)                        '25 Entidad
            SQL = SQL & Datos(32) & "," & Chr(10)
            SQL = SQL & Datos(33) & " );"                                                   '27 Valor Unidad Monetaria
            db.Execute SQL
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


Function LlenarPAMDRCA(Rut$, Doc$) As Boolean
Dim SQL As String
Dim Datos()

    LlenarPAMDRCA = True
    SQL = "DELETE FROM PAMDRCA;"
    db.Execute SQL

    SQL = "SP_PAPELETARCA "
    SQL = SQL + Rut$ + ","
    SQL = SQL + Doc$ + ","
    SQL = SQL + gsTipoPapeleta

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO PAMDRCA VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + Datos(6) + "," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + "'" + Datos(14) + "'," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + "'" + Datos(16) + "'," & Chr(10)
            SQL = SQL + Datos(17) + "," & Chr(10)
            SQL = SQL + Datos(18) + "," & Chr(10)
            SQL = SQL + Datos(19) + "," & Chr(10)
            SQL = SQL + "'" + Datos(20) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(21) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(22) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(23) + "'," & Chr(10)
            SQL = SQL + Datos(24) + "," & Chr(10)
            SQL = SQL + "'" + Datos(25) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(26) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(27) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(28) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(29) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(30) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(31) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(32) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(33) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(34) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(35) + "'," & Chr(10)
            SQL = SQL + Datos(36) + "," & Chr(10)
            SQL = SQL + Datos(37) + "," & Chr(10)
            SQL = SQL + Datos(38) + "," & Chr(10)
            SQL = SQL + "'" + Datos(39) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(40) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(41) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(42) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(43) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(44) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(45) + "'," & Chr(10)
            SQL = SQL + Datos(46) + "," & Chr(10)
            ' el 47 no se debe ocupar
            SQL = SQL + Datos(48) + "," & Chr(10)
            SQL = SQL + Datos(49) + "," & Chr(10)
            SQL = SQL + "'" + Datos(50) & "'," & Chr(10)
            SQL = SQL & "'" & Datos(51) & "'," & Chr(10)
            SQL = SQL & Datos(52) & "," & Chr(10)
            SQL = SQL & Datos(53) & "," & Chr(10)
            SQL = SQL & Datos(54) & "," & Chr(10)
            SQL = SQL & "'" & Datos(55) & "'," & Chr(10)
            SQL = SQL & Datos(56) & "," & Chr(10)
            SQL = SQL & Datos(57) & "," & Chr(10)
            SQL = SQL & Datos(58) & "," & Chr(10)
            SQL = SQL & "'" & Datos(59) & "'" & Chr(10)
            SQL = SQL & ");"
            db.Execute SQL
        Loop
    Else
        LlenarPAMDRCA = False
    End If

End Function

Function LlenarPAMDVI(Rut$, Doc$) As Boolean
Dim SQL As String
Dim Datos()

    LlenarPAMDVI = True
    SQL = "DELETE FROM PAMDVI;"
    db.Execute SQL

    SQL = "SP_PAPELETAVI "
    SQL = SQL + Rut$ + ","
    SQL = SQL + Doc$ + ","
    SQL = SQL + gsTipoPapeleta

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
           If Datos(1) <> "CERO" Then
                SQL = "INSERT INTO PAMDVI VALUES ( " & Chr(10)
                SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
                SQL = SQL + Datos(6) + "," & Chr(10)
                SQL = SQL + Datos(7) + "," & Chr(10)
                SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
                SQL = SQL + Datos(9) + "," & Chr(10)
                SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
                SQL = SQL + Datos(11) + "," & Chr(10)
                SQL = SQL + Datos(12) + "," & Chr(10)
                SQL = SQL + Datos(13) + "," & Chr(10)
                SQL = SQL + "'" + Datos(14) + "'," & Chr(10)
                SQL = SQL + Datos(15) + "," & Chr(10)
                SQL = SQL + "'" + Datos(16) + "'," & Chr(10)
                SQL = SQL + Datos(17) + "," & Chr(10)
                SQL = SQL + Datos(18) + "," & Chr(10)
                SQL = SQL + Datos(19) + "," & Chr(10)
                SQL = SQL + "'" + Datos(20) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(21) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(22) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(23) + "'," & Chr(10)
                SQL = SQL + Datos(24) + "," & Chr(10)
                SQL = SQL + "'" + Datos(25) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(26) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(27) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(28) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(29) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(30) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(31) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(32) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(33) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(34) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(35) + "'," & Chr(10)
                SQL = SQL + Datos(36) + "," & Chr(10)
                SQL = SQL + Datos(37) + "," & Chr(10)
                SQL = SQL + Datos(38) + "," & Chr(10)
                SQL = SQL + "'" + Datos(39) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(40) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(41) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(42) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(43) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(44) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(45) + "'," & Chr(10)
                SQL = SQL + Datos(46) + "," & Chr(10)
                ' el 47 no se debe ocupar
                SQL = SQL + Datos(48) + "," & Chr(10)
                SQL = SQL + Datos(49) + "," & Chr(10)
                SQL = SQL + "'" + Datos(50) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(51) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(52) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(53) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(54) + "'," & Chr(10)
                SQL = SQL + "'" + Datos(55) + "');"

                db.Execute SQL
           End If
        Loop
    Else
        LlenarPAMDVI = False
    End If

End Function

Function LlenarPAMDVP(Rut$, Doc$, sTipOper) As Boolean
Dim SQL As String
Dim Datos()

    LlenarPAMDVP = True
    SQL = "DELETE FROM PAMDVP;"
    db.Execute SQL

    SQL = "SP_PAPELETAVP "
    SQL = SQL + Rut$ + ","
    SQL = SQL + Doc$ + ","
    SQL = SQL + gsTipoPapeleta + ","
    SQL = SQL + sTipOper

    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO PAMDVP VALUES ( " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + Datos(6) + "," & Chr(10)
            SQL = SQL + Datos(7) + "," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + Datos(9) + "," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + Datos(13) + "," & Chr(10)
            SQL = SQL + "'" + Datos(14) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(15) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(16) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(17) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(18) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(19) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(20) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(21) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(22) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(23) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(24) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(25) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(26) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(27) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(28) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(29) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(30) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(31) + "'," & Chr(10)
            SQL = SQL + Datos(32) + "," & Chr(10)
            SQL = SQL + Datos(33) + "," & Chr(10)
            SQL = SQL + "'" + Datos(34) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(35) + "'," & Chr(10)
            SQL = SQL + Datos(36) + "," & Chr(10)
            ' el 37 no se debe ocupar
            SQL = SQL + Datos(38) + "," & Chr(10)
            SQL = SQL + Datos(39) + "," & Chr(10)
            SQL = SQL + Datos(40) + "," & Chr(10)
            SQL = SQL + Datos(41) + "," & Chr(10)
            SQL = SQL + Datos(42) + "," & Chr(10)
            SQL = SQL + "'" + Datos(43) & "'," & Chr(10)
            SQL = SQL + "'" + Datos(44) & "'," & Chr(10)
            SQL = SQL + "'" + Datos(45) & "');"
            db.Execute SQL
        Loop
    Else
        LlenarPAMDVP = False
    End If

End Function

Function LlenarMovDCV(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM MOVDCV"
    LlenarMovDCV = True
    db.Execute SQL

    SQL = "SP_INFMOVDCV "
    SQL = SQL & Val(Entidad)
    
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MOVDCV VALUES (  " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(8) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(9) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(10) + "'," & Chr(10)
            SQL = SQL + Datos(11) + "," & Chr(10)
            SQL = SQL + Datos(12) + "," & Chr(10)
            SQL = SQL + "'" + Datos(13) + "'," & Chr(10)
            SQL = SQL + Datos(14) + "," & Chr(10)
            SQL = SQL + Datos(15) + "," & Chr(10)
            SQL = SQL + "'" + Datos(16) + "' );"
            db.Execute SQL
        Loop
    Else
        LlenarMovDCV = False
        MsgBox "Informe no puede ser Generado", vbExclamation, gsBac_Version
    End If

End Function

Function LlenarCPDCV(Entidad As String) As Boolean
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM MDCPDCV;"
    LlenarCPDCV = True
    db.Execute SQL

    SQL = "SP_CARTERADCV " & Val(Entidad)
    If Bac_Sql_Execute(SQL, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO MDCPDCV VALUES(  " & Chr(10)
            SQL = SQL + "'" + Datos(1) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(2) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(3) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(4) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(5) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(6) + "'," & Chr(10)
            SQL = SQL + "'" + Datos(7) + "'," & Chr(10)
            SQL = SQL & Val(Datos(8)) & "," & Chr(10)
            SQL = SQL + "'" + Datos(9) + "'," & Chr(10)
            SQL = SQL & CDbl(Datos(15)) & "," & Chr(10)
            SQL = SQL & Datos(14) & "," & Chr(10)
            SQL = SQL & Val(Datos(12)) & "," & Chr(10)
            SQL = SQL + "'" + Datos(13) + "' );"
            db.Execute SQL
        Loop
    Else
        LlenarCPDCV = False
        MsgBox "Informe no pudo ser procesado", vbExclamation, gsBac_Version
    End If

End Function







Function LlenarmdbTD()
Dim SQL As String
Dim Datos()

    SQL = "DELETE FROM TDESA;"
    db.Execute SQL

    If miSQL.SQL_Execute("SP_PRUEBA") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            SQL = "INSERT INTO TDESA VALUES ( " & Chr(10)
            SQL = SQL + Datos(1) + "," + Datos(2) + "," & Chr(10)
            SQL = SQL + Datos(3) + "," + Datos(4) + "," & Chr(10)
            SQL = SQL + Datos(5) + ",'" + Datos(6) + "'  );"
            db.Execute SQL
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

Function LlenarBloter() As Boolean
Dim cSql As String
Dim Datos()
Dim nValor As Integer
Dim Titulo As String


BacIniBlo.Show 1
Titulo = "BLOTTER  DEL (" & CStr(xFecha) & "  RENTA  FIJA)"
If giAceptar% Then
    If Not Llenar_Parametros(Titulo) Then Exit Function

        nValor = 0
        cSql = "DELETE FROM OPESIS"
        LlenarBloter = True
    
        db.Execute cSql

        cSql = "EXECUTE SP_CBLOTER  '" & Format(xFecha, "yyyymmdd") & "'"
    
        If miSQL.SQL_Execute(cSql) = 0 Then
            Do While Bac_SQL_Fetch(Datos())
               cSql = "INSERT INTO OPESIS VALUES ( " & Chr(10)
               cSql = cSql & Val(Datos(1)) & "," & Chr(10)
               cSql = cSql & Val(Datos(2)) & "," & Chr(10)
               cSql = cSql & "'" & Trim(Datos(3)) & "'," & Chr(10)
               cSql = cSql & "'" & Trim(Datos(4)) & "'," & Chr(10)
               cSql = cSql & Datos(5) + "," & Chr(10)
               cSql = cSql & Datos(6) + "," & Chr(10)
               cSql = cSql & Datos(7) + "," & Chr(10)
               cSql = cSql & "'" & Trim(Datos(8)) & "'," & Chr(10)
               cSql = cSql & Datos(9) & "," & Chr(10)
               cSql = cSql & "'" & CDate(Datos(10)) & "'," & Chr(10)
               cSql = cSql & "'" & Trim(Datos(11)) & "'," & Chr(10)
               cSql = cSql & "'" & Trim(Datos(12)) & "'," & Chr(10)
               cSql = cSql & "'" & Trim(Datos(13)) & "');"
               nValor = 1
               db.Execute cSql
            Loop
        Else
            LlenarBloter = False
        End If
        If nValor = 0 Then
            LlenarBloter = False
            MsgBox "No se registran operaciones ", vbExclamation, gsBac_Version
            Exit Function
        End If
        
End If
End Function
