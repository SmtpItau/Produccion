Attribute VB_Name = "BacLisHistor"
Option Explicit
Function ImprimeAnulacionPapeleta(sRutCart$, sNumoper$, sTipOper$) As String
Dim Sql As String

    ImprimeAnulacionPapeleta = "SI"
    gsTipoPapeleta = "P"
    Call Limpiar_Cristal
    BacTrader.bacrpt.Destination = 1 ' gsBac_Papeleta
    
    
    If sTipOper = "CI" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDCI1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "ANULACION" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
        
        
    ElseIf sTipOper = "CP" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDCP1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "ANULACION" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
    
    ElseIf sTipOper = "VP" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDVP1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.StoredProcParam(3) = sTipOper
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "ANULACION" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
    
    ElseIf sTipOper = "VI" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDVI1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "ANULACION" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
            
    ElseIf sTipOper = "IB" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAINTER.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = Trim(sRutCart$)
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.StoredProcParam(4) = ""
            BacTrader.bacrpt.StoredProcParam(5) = ""
            BacTrader.bacrpt.StoredProcParam(6) = ""
            BacTrader.bacrpt.StoredProcParam(7) = ""
            BacTrader.bacrpt.Formulas(0) = "Titulo = '" & "ANULACION" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
         
    ElseIf sTipOper = "IC" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PACAPTA1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sNumoper$
            BacTrader.bacrpt.StoredProcParam(1) = Format(gsBac_Fecp, "YYYY-MM-DD 00:00:00.000")
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
            
    ElseIf sTipOper = "RVA" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDRVA.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "ANULACION" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1

    ElseIf sTipOper = "RCA" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDRCA.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "ANULACION" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
        
    ElseIf sTipOper = "FLI" Then
    BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMFLI.RPT"
    BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
    BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
    BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
    BacTrader.bacrpt.Formulas(0) = "Titulo ='" & "ANULACION" & "'"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    
        
    End If

    BacTrader.bacrpt.Destination = 0

End Function
Function ImprimeModificacionPapeleta(sRutCart$, sNumoper$, sTipOper$) As String
Dim Sql As String
On Error GoTo errores
    ImprimeModificacionPapeleta = "SI"
    gsTipoPapeleta = "P"
    Call Limpiar_Cristal
    BacTrader.bacrpt.Destination = gsBac_Papeleta
    
    If sTipOper = "CI" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDCI1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Formulas(0) = "Titulo = '" & "MODIFICACION" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
         'If LlenarPAMDCI(sRutCart$, sNumoper$) Then
'            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMOMDCI.RPT"
'            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
'            BacTrader.bacrpt.Action = 1
'        Else
'            ImprimeModificacionPapeleta = "NO"
'        End If
    ElseIf sTipOper = "CP" Then
            
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDCP1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Formulas(0) = "Titulo = '" & "MODIFICACION" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            
            BacTrader.bacrpt.Action = 1
          '  If LlenarPAMDCP(sRutCart$, sNumoper$) Then
           ' bacTrader.bacrpt.ReportFileName = RptList_Path & "PAMOMDCP.RPT"
    ElseIf sTipOper = "VP" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDVP1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.StoredProcParam(3) = sTipOper
            BacTrader.bacrpt.Formulas(0) = "Titulo = '" & "MODIFICACION" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
'        If LlenarPAMDVP(sRutCart$, sNumoper$, sTipoper) Then
'            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMOMDVP.RPT"
'            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
'            BacTrader.bacrpt.Action = 1
'        Else
'            ImprimeModificacionPapeleta = "NO"
'        End If
    ElseIf sTipOper = "VI" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDVI1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.Formulas(0) = "Titulo = '" & "MODIFICACION" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
    
'        If LlenarMoPAMDVI(sRutCart$, sNumoper$) Then
'            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMOMDVI.RPT"
'            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
'            BacTrader.bacrpt.Action = 1
'        Else
'            ImprimeModificacionPapeleta = "NO"
'        End If
    ElseIf sTipOper = "IB" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAINTER.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sRutCart$
            BacTrader.bacrpt.StoredProcParam(1) = Trim(sNumoper$)
            BacTrader.bacrpt.StoredProcParam(2) = gsTipoPapeleta
            BacTrader.bacrpt.StoredProcParam(4) = ""
            BacTrader.bacrpt.StoredProcParam(5) = ""
            BacTrader.bacrpt.StoredProcParam(6) = ""
            BacTrader.bacrpt.StoredProcParam(7) = ""
            BacTrader.bacrpt.Formulas(0) = "Titulo = '" & "MODIFICACION" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
    
        'If LlenarMoPAINT(sRutCart$, sNumoper$) Then
        '    BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMOINT.RPT"
        '    'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
        '    BacTrader.bacrpt.Action = 1
        'Else
        '    ImprimeModificacionPapeleta = "NO"
        'End If
    ElseIf sTipOper = "IC" Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PACAPTA1.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = sNumoper$
            BacTrader.bacrpt.StoredProcParam(1) = Format(gsBac_Fecp, "YYYY-MM-DD 00:00:00.000")
            BacTrader.bacrpt.Formulas(0) = "@titulo='" & "MODIFICACION" & "'"
            BacTrader.bacrpt.Connect = CONECCION
            
            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
            BacTrader.bacrpt.Action = 1
    End If
    BacTrader.bacrpt.Destination = 0
Exit Function

errores:
MsgBox err.Description, vbCritical
BacTrader.bacrpt.Destination = 0
End Function

Function LlenarAnPAMDCP(Rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarAnPAMDCP = True
    Sql = "DELETE FROM PAMDCP;"
    db.Execute Sql

    Sql = "EXECUTE SP_PAPELANULCP "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            Sql = Sql + "'" & Datos(43) + "'," & Chr(10)
            Sql = Sql + "'" & Datos(44) + "'," & Chr(10)
            Sql = Sql + "'" & Datos(45) + "'," & Chr(10)
            Sql = Sql + "'" & Datos(46) + "'," & Chr(10)
            Sql = Sql + "'" & Datos(47) + "'," & Chr(10)
            Sql = Sql + "'" & Datos(48) + "');"
            db.Execute Sql
        Loop
    Else
        LlenarAnPAMDCP = False
    End If

End Function
Function LlenarMoPAMDCP(Rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarMoPAMDCP = True
    Sql = "DELETE FROM PAMDCP;"
    db.Execute Sql

    Sql = "EXECUTE SP_PAPELMODICP "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            Sql = Sql + "'" + Datos(43) + "," & Chr(10) 'se agrega hora de impresion (Miguel Gajardo)
            Sql = Sql + "'" + Datos(44) + "," & Chr(10)
            Sql = Sql + "'" + Datos(45) + "," & Chr(10)
            Sql = Sql + "'" + Datos(46) + "," & Chr(10)
            Sql = Sql + "'" + Datos(47) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(48) + "');"
            db.Execute Sql
        Loop
    Else
        LlenarMoPAMDCP = False
    End If

End Function

Function LlenarAnPAMDVI(Rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarAnPAMDVI = True
    Sql = "DELETE FROM PAMDVI;"
    db.Execute Sql

    Sql = "SP_PAPELANULVI "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            Sql = Sql + "'" + Datos(50) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(51) + "'," + Chr(10) 'se agrega la hora de impresion (Miguel Gajardo)
            Sql = Sql + "'" + Datos(52) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(53) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(54) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(55) + "');"
            
            db.Execute Sql
        Loop
    Else
        LlenarAnPAMDVI = False
    End If

End Function
Function LlenarMoPAMDVI(Rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarMoPAMDVI = True
    Sql = "DELETE FROM PAMDVI;"
    db.Execute Sql

    Sql = "SP_PAPELMODIVI "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            Sql = Sql + "'" + Datos(50) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(51) + "'," + Chr(10)       'se agrega la hora de impresion (Miguel Gajardo)
            Sql = Sql + "'" + Datos(52) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(53) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(54) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(55) + "');"
            db.Execute Sql
        Loop
    Else
        LlenarMoPAMDVI = False
    End If

End Function

Function LlenarAnPAMDVP(Rut$, Doc$, sTipOper) As Boolean
Dim Sql As String
Dim Datos()

    LlenarAnPAMDVP = True
    Sql = "DELETE FROM PAMDVP;"
    db.Execute Sql

    Sql = "EXECUTE SP_PAPELANULVP "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta + ","
    Sql = Sql + sTipOper

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            Sql = Sql + "'" & Datos(43) + "'," & Chr(10)
            Sql = Sql + "'" & Datos(44) + "'," & Chr(10)
            Sql = Sql + "'" & Datos(45) + "');" & Chr(10)

            db.Execute Sql
        Loop
    Else
        LlenarAnPAMDVP = False
    End If

End Function
Function LlenarMoPAMDVP(Rut$, Doc$, sTipOper) As Boolean
Dim Sql As String
Dim Datos()

    LlenarMoPAMDVP = True
    Sql = "DELETE FROM PAMDVP;"
    db.Execute Sql

    Sql = "SP_PAPELMODIVP "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta + ","
    Sql = Sql + sTipOper

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            Sql = Sql + "'" + Datos(43) + "'," & Chr(10)  'se agrega hora de impresion (Miguel Gajardo)
            Sql = Sql + "'" + Datos(44) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(45) + "');"
            db.Execute Sql
        Loop
    Else
        LlenarMoPAMDVP = False
    End If

End Function

Function LlenarAnPAINT(Rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarAnPAINT = True
    Sql = "DELETE FROM PAINTERBAN;"
    db.Execute Sql

    Sql = "EXECUTE SP_PAPELANULIB "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            db.Execute Sql
        Loop
    Else
        LlenarAnPAINT = False
    End If

End Function
Function LlenarMoPAINT(Rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarMoPAINT = True
    Sql = "DELETE FROM PAINTERBAN;"
    db.Execute Sql

    Sql = "SP_PAPELMODIIB "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            db.Execute Sql
        Loop
    Else
        LlenarMoPAINT = False
    End If

End Function

Function LlenarAnPAMDCI(Rut$, Doc$) As Boolean

Dim Sql As String
Dim Datos()

    LlenarAnPAMDCI = True
    Sql = "DELETE FROM PAMDCI;"
    db.Execute Sql
    
    Sql = ""
    Sql = "EXECUTE SP_PAPELANULCI "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            Sql = Sql + Datos(51) + "," & Chr(10)
            Sql = Sql + "'" + Datos(52) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(53) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(54) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(55) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(56) + "');"
            db.Execute Sql
        Loop
    Else
        LlenarAnPAMDCI = False
    End If

End Function
Function LlenarMoPAMDCI(Rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarMoPAMDCI = True
    Sql = "DELETE FROM PAMDCI;"
    db.Execute Sql
    Sql = "SP_PAPELMODICI "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            Sql = Sql + Datos(51) + "," & Chr(10)
            Sql = Sql + "'" + Datos(52) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(53) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(54) + "'," + Chr(10)
            Sql = Sql + "'" + Datos(55) + "');"
            db.Execute Sql
        Loop
    Else
        LlenarMoPAMDCI = False
    End If

End Function


Function LlenarHisInter(Rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarHisInter = True
    Sql = "DELETE FROM PAINTERBAN;"
    db.Execute Sql

    Sql = "SP_PAPELETAHIS_IB "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            Sql = Sql + "'" + Datos(40) + "');"
            db.Execute Sql
        Loop
    Else
        LlenarHisInter = False
    End If

End Function

Function LlenarCTDIS() As Boolean
Dim Sql As String
Dim Datos()

    LlenarCTDIS = False

    Sql = "DELETE FROM CACTDIS;"
    db.Execute Sql

    If miSQL.SQL_Execute("SP_LISTADOCTDIS") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            Sql = "INSERT INTO CACTDIS VALUES (  " & Chr(10)
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
            Sql = Sql + Datos(15) + ",'" + Datos(16) + "','" + Datos(17) + "' );"

            db.Execute Sql
            
        Loop
        LlenarCTDIS = True
    Else
        LlenarCTDIS = False
        MsgBox "Reporte no puede ser impreso", vbExclamation, gsBac_Version
    End If

End Function

Function LlenarCpINT(xent As String) As Boolean
Dim Sql As String
Dim Datos()

    Sql = "DELETE FROM CACPCON;"

    LlenarCpINT = False

    db.Execute Sql
    
    If miSQL.SQL_Execute("SP_LISTADOCPINT " & Val(xent)) = 0 Then
    
    Do While Bac_SQL_Fetch(Datos())
             Sql = "INSERT INTO CACPCON VALUES (  " & Chr(10)
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
             Sql = Sql + Datos(18) + ",'" + Datos(19) + " ','" + Datos(20) + "'," '
                
             ' LLENAR CON DATOS REALES
                
             Sql = Sql + "' ',"  ' EMISOR
             Sql = Sql + "' ',"  ' FECHA VENCIMIENTO CUPON
             Sql = Sql + "0  ,"  ' VALOR PROXIMO CUPON
             Sql = Sql + "0  ,"  ' DURATION
             Sql = Sql + "0  ,"  ' DURATION MOD.
             Sql = Sql + "' ',"  ' FECHA COMPRA
             Sql = Sql + "0  ,"  ' VALOR MONEDA COMPRA
             Sql = Sql + "0  ,"  ' TIR COMPRA
             Sql = Sql + "0  ,"  ' PVC COMPRA
             Sql = Sql + "0  ,"  ' CAPITAL
             Sql = Sql + "0  ,"  ' CAPITAL U.M.
             Sql = Sql + "0  ,"  ' INTERES ACUM.
             Sql = Sql + "0  ,"  ' REAJUSTE ACUM.
             Sql = Sql + "0  ,"  ' VALOR CUPON
             Sql = Sql + "'I');" ' TIPO CARTERA P = PROPIA, I = INTERMEDIADA
 
             db.Execute Sql
       Loop
       
       LlenarCpINT = True
            
    Else
        MsgBox "Reporte no puede ser impreso", vbExclamation, gsBac_Version
        LlenarCpINT = False
    End If
'********************************************
End Function

Function LlenarCAVI(xent As String) As Boolean
Dim Sql As String
Dim Datos()

    LlenarCAVI = False
    
    db.Execute "DELETE FROM MDINFOCI;"

    If miSQL.SQL_Execute("SP_LISTADOCAVI " & Val(xent)) = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            Sql = "INSERT INTO MDINFOCI VALUES ( " & Chr(10)
            Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
            Sql = Sql + Datos(5) + "," & Chr(10)
            Sql = Sql + "'" + Datos(6) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
            Sql = Sql + Datos(8) + "," & Chr(10)
            Sql = Sql + Datos(9) + "," & Chr(10)
            Sql = Sql + Datos(10) + "," & Chr(10)
            Sql = Sql + "'" + Datos(11) + "'," & Chr(10)
            Sql = Sql + "'" + Datos(12) + "'," & Chr(10)
            Sql = Sql + Datos(13) + ","
            
            ' LLENAR CON DATOS
            Sql = Sql + "' ',"     ' EMISOR
            Sql = Sql + "' ',"     ' FECHA VCTO.
            Sql = Sql + "  0,"     ' BASE
            Sql = Sql + "' ',"     ' MONEDA EMISION
            Sql = Sql + "  0,"     ' TIR
            Sql = Sql + "  0,"     ' VALOR INICIAL
            Sql = Sql + "  0,"     ' VALOR FINAL
            Sql = Sql + "  0,"     ' TASA PACTO
            Sql = Sql + "  0,"     ' INTERES ACUMULADO
            Sql = Sql + "  0,"     ' REAJUSTE ACUMULADO
            Sql = Sql + "  0,"     ' INTERES
            Sql = Sql + "  0,"     ' REAJUSTE
            Sql = Sql + "  0,"     ' VALOR PRESENTE
            Sql = Sql + "  0,"     ' VALOR PROXIMO
            Sql = Sql + "  0,"     ' CLIENTE PACTO
            Sql = Sql + "'V' );"   ' TIPO CARTERA
                        
            db.Execute Sql
            
        Loop
            LlenarCAVI = True
    Else
        LlenarCAVI = False
        MsgBox "Listado no pudo ser Procesado, Comunicarse con Bac Ltda.", vbExclamation, gsBac_Version
    End If
End Function

Function LlenarCpDis(xent As String) As Boolean
Dim Sql As String
Dim Datos()

    LlenarCpDis = False
    Sql = "DELETE FROM CACPDIS;"
    db.Execute Sql

    If miSQL.SQL_Execute("EXECUTE SP_LISTADOCPDIS " & Val(xent)) = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            Sql = "INSERT INTO CACPDIS VALUES (  " & Chr(10)
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
            Sql = Sql + "'" + Datos(11) + "'" + "," & Chr(10)
            Sql = Sql + Datos(12) + "," & Chr(10)
            Sql = Sql + Datos(13) + "," & Chr(10)
            Sql = Sql + Datos(14) + "," & Chr(10)
            Sql = Sql + Datos(15) + "," & Chr(10)
            Sql = Sql + Datos(16) + "," & Chr(10)
            Sql = Sql + Datos(17) + "," & Chr(10)
            Sql = Sql + Datos(18) + ",'" + Datos(19) + "','" + Datos(20) + "' );"

            db.Execute Sql
            
        Loop
        LlenarCpDis = True
    Else
        LlenarCpDis = False
        MsgBox "REPORTE NO PUEDE SER IMPRESO POR EL MOMENTO, INTENTE MAS TARDE", vbExclamation, gsBac_Version
    End If

End Function


Function LlenarHisMDCI(Rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarHisMDCI = True
    Sql = "DELETE FROM PAMDCI;"
    db.Execute Sql

    Sql = "SP_PAPELETAHIS_CI "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            Sql = Sql + Datos(51) + " );"
            db.Execute Sql
        Loop
    Else
        LlenarHisMDCI = False
    End If

End Function

Function LlenarHisMDCP(Rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarHisMDCP = True
    Sql = "DELETE FROM PAMDCP;"
    db.Execute Sql

    Sql = "SP_PAPELETAHIS_CP "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            Sql = Sql + Datos(42) + " );"
            db.Execute Sql
        Loop
    Else
        LlenarHisMDCP = False
    End If

End Function


Function LlenarHisMDVI(Rut$, Doc$) As Boolean
Dim Sql As String
Dim Datos()

    LlenarHisMDVI = True
    Sql = "DELETE FROM PAMDVI;"
    db.Execute Sql

    Sql = "SP_PAPELETAHIS_VI "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            Sql = Sql + "'" + Datos(50) + "');"
            db.Execute Sql
        Loop
    Else
        LlenarHisMDVI = False
    End If

End Function
Function LlenarHisMDVP(Rut$, Doc$, sTipOper) As Boolean
Dim Sql As String
Dim Datos()

    LlenarHisMDVP = True
    Sql = "DELETE FROM PAMDVP;"
    db.Execute Sql

    Sql = "SP_PAPELETAHIS_VP "
    Sql = Sql + Rut$ + ","
    Sql = Sql + Doc$ + ","
    Sql = Sql + gsTipoPapeleta + ","
    Sql = Sql + sTipOper

    If Bac_Sql_Execute(Sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
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
            Sql = Sql + Datos(42) + " );"
            db.Execute Sql
        Loop
    Else
        LlenarHisMDVP = False
    End If

End Function




Function PrintPapeletaHistoricas(sRutCart$, sNumoper$, sTipOper$) As Boolean
Dim Sql As String

    PrintPapeletaHistoricas = True
    gsTipoPapeleta = "P"
    Call Limpiar_Cristal
    BacTrader.bacrpt.Destination = 1

    If sTipOper = "CI" Then
        If LlenarHisMDCI(sRutCart$, sNumoper$) Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDCI.RPT"
            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
            BacTrader.bacrpt.Action = 1
        Else
            PrintPapeletaHistoricas = False
        End If
    ElseIf sTipOper = "CP" Then
        If LlenarHisMDCP(sRutCart$, sNumoper$) Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDCP.RPT"
            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
            BacTrader.bacrpt.Action = 1
        Else
            PrintPapeletaHistoricas = False
        End If
    ElseIf sTipOper = "VP" Then
        If LlenarHisMDVP(sRutCart$, sNumoper$, sTipOper) Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDVP.RPT"
            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
            BacTrader.bacrpt.Action = 1
        Else
            PrintPapeletaHistoricas = False
        End If
    ElseIf sTipOper = "VI" Then
        If LlenarHisMDVI(sRutCart$, sNumoper$) Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDVI.RPT"
            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
            BacTrader.bacrpt.Action = 1
        Else
            PrintPapeletaHistoricas = False
        End If
    ElseIf sTipOper = "IB" Then
        If LlenarHisInter(sRutCart$, sNumoper$) Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAINTER.RPT"
            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
            BacTrader.bacrpt.Action = 1
        Else
            PrintPapeletaHistoricas = False
        End If
    ElseIf sTipOper = "ST" Then
        If LlenarHisMDVP(sRutCart$, sNumoper$, sTipOper) Then
            BacTrader.bacrpt.ReportFileName = RptList_Path & "PAMDST.RPT"
            'BacTrader.bacrpt.WindowParentHandle = BacTrader.hWnd
            BacTrader.bacrpt.Action = 1
        Else
            PrintPapeletaHistoricas = False
        End If

    End If
    BacTrader.bacrpt.Destination = 0

End Function



Function Validar_Papeletas_Historicas(Numoper$, tipo$)
Dim Datos()
  
    Validar_Papeletas_Historicas = True
'    Sql = "SP_VALHISTORICA_PAP_CONT "
'    Sql = Sql & NumOper$ & ","
'    Sql = Sql & "'" & TipO$ & "'"

    Envia = Array(CDbl(Numoper), tipo)
    
    If Not Bac_Sql_Execute("SP_VALHISTORICA_PAP_CONT", Envia) Then
        MsgBox "No se Pudo Validar Papeletas y Contratos", vbExclamation, gsBac_Version
        Validar_Papeletas_Historicas = False
        Exit Function
    End If
  
    Do While Bac_SQL_Fetch(Datos())
        If Val(Datos(1)) = 0 Then
            Validar_Papeletas_Historicas = False
        End If
    Loop
  
End Function

Function LlenarCTINT() As Boolean
Dim Sql As String
Dim Datos()

    LlenarCTINT = False
    
    Sql = "DELETE FROM CACTINT;"
    db.Execute Sql

    If miSQL.SQL_Execute("SP_LISTADOCTINT") = 0 Then
        Do While Bac_SQL_Fetch(Datos())
            Sql = "INSERT INTO CACTINT VALUES (  " & Chr(10)
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
            Sql = Sql + Datos(18) + ",'" + Datos(19) + "','" + Datos(20) + "' );"

            db.Execute Sql
            
        Loop
        LlenarCTINT = True
    Else
        LlenarCTINT = False
        MsgBox "Reporte no puede ser impreso", vbExclamation, gsBac_Version
    End If

End Function
'el SP_LISTADOCPCON fue modificado si ocupan esta funcion deben arreglar dicho sp
Function LlenarCpcon(Entidad As String, tipo As String) As Boolean
Dim Sql As String
Dim Datos()
Dim bDatos As Boolean

Sql = "DELETE FROM CACPCON;"

LlenarCpcon = False

db.Execute Sql
    
Sql = "SP_LISTADOCPCON "
Sql = Sql + "'" + tipo + "',"
Sql = Sql & Val(Entidad)
bDatos = False
If Bac_Sql_Execute(Sql, Envia) Then Exit Function

Do While Bac_SQL_Fetch(Datos())
       
   Sql = "INSERT INTO CACPCON VALUES (  " & Chr(10)
   Sql = Sql + "'" + Datos(1) + "'," & Chr(10)
   Sql = Sql + "'" + Datos(2) + "'," & Chr(10)
   Sql = Sql + "'" + Datos(3) + "'," & Chr(10)
   Sql = Sql + "'" + Datos(4) + "'," & Chr(10)
   Sql = Sql + Datos(5) + "," & Chr(10)
   Sql = Sql + Datos(6) + "," & Chr(10)
   Sql = Sql + "'" + Datos(7) + "'," & Chr(10)
   Sql = Sql + Datos(8) + "," & Chr(10)
   Sql = Sql + Datos(9) + "," & Chr(10)
   Sql = Sql + Datos(10) + "," & Chr(10)
   Sql = Sql + Datos(11) + "," & Chr(10)
   Sql = Sql + Datos(12) + "," & Chr(10)
   Sql = Sql + Datos(13) + "," & Chr(10)
   Sql = Sql + Datos(14) + "," & Chr(10)
   Sql = Sql + Datos(15) + "," & Chr(10)
   Sql = Sql + "'" + Datos(16) + "'," & Chr(10)
   Sql = Sql + "'" + Datos(17) + "'," & Chr(10)  ' EMISOR
   Sql = Sql + "'" + Datos(18) + "'," & Chr(10)  ' FEC. VEN. CUP.
   Sql = Sql + Datos(19) + "," & Chr(10)         ' VALOR PROXIMO CUPON
   Sql = Sql + Datos(20) + "," & Chr(10)         ' DURATION
   Sql = Sql + Datos(21) + "," & Chr(10)         ' DURATION MOD.
   Sql = Sql + "'" + Datos(22) + "'," & Chr(10)  ' FECHA COMPRA
   Sql = Sql + Datos(23) + "," & Chr(10)         ' VALOR MONEDA COMPRA
   Sql = Sql + Datos(24) + "," & Chr(10)         ' TIR COMPRA
   Sql = Sql + Datos(25) + "," & Chr(10)         ' PVC COMPRA
   Sql = Sql + Datos(26) + "," & Chr(10)         ' CAPITAL
   Sql = Sql + Datos(27) + "," & Chr(10)         ' CAPITAL U.M.
   Sql = Sql + Datos(28) + "," & Chr(10)         ' INTERES ACUM.
   Sql = Sql + Datos(29) + "," & Chr(10)         ' REAJUSTE ACUM.
   Sql = Sql + Datos(30) + "," & Chr(10)        ' VALOR CUPON
   Sql = Sql + "'" + Datos(31) + "'" + ");" & Chr(10)     ' VALOR CUPON
   
   db.Execute Sql
   bDatos = True
Loop
        
If Not bDatos Then
    MsgBox "No existe información en cartera seleccionada", vbExclamation, gsBac_Version
    Exit Function
End If
LlenarCpcon = True
    
End Function

