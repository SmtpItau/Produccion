Attribute VB_Name = "BacLineaRiesgo"
Option Explicit

Function LRCCheck(lRutCliente As Long, dFecha As String, nMonto As Double) As String
Dim nLinBase      As Double
Dim nLinOcup      As Double
Dim nSaldo        As Double
Dim sNombre       As String
Dim sRetorno      As String
Dim Datos()

   'Lectura de las líneas de riesgo del cliente
'   Sql = "EXECUTE SP_LRCCHECK " & lRutCliente & ", '" & dFecha & "', " & nMonto

    Envia = Array(CDbl(lRutCliente), dFecha, nMonto)
    
    If Not Bac_Sql_Execute("SP_LRCCHECK", Envia) Then
        MsgBox "Problemas con la lectura de la clasificación de riesgos", vbCritical, gsBac_Version
        Exit Function
    End If

    LRCCheck = ""

    Do While Bac_SQL_Fetch(Datos())
        If Datos(1) <> "OK" Then
            sRetorno = Space(3) & "Línea Cliente " & Datos(2) & vbCrLf
            sRetorno = sRetorno & Space(7) & "L.Disp. antes de la operación en UF   " & Format(Val(Datos(5)), "###,###,###,##0.0000") & vbCrLf
            sRetorno = sRetorno & Space(7) & "Monto de la operación en UF           " & Format(Val(Datos(8)), "###,###,###,##0.0000") & vbCrLf
            sRetorno = sRetorno & Space(7) & "L.Disp. después de la operación en UF " & Format(Val(Datos(7)), "###,###,###,##0.0000")
         'sRetorno = Space(3) & "Línea Cliente (" & Datos(2) & ") " & Datos(5) & "   " & Datos(8) & "   " & Datos(7)
            LRCCheck = sRetorno
        End If
    Loop

End Function

Function LRECheck(lRutEmisor As Long, dFecha As String, nMonto As Double) As String
Dim nLinBase      As Double
Dim nLinOcup      As Double
Dim nSaldo        As Double
Dim sNombre       As String
Dim sRetorno      As String
Dim Datos()

   'Lectura de las líneas de riesgo del emisor
'   Sql = "SP_LRECHECK " &
    Envia = Array(CDbl(lRutEmisor), dFecha, nMonto)

    If Not Bac_Sql_Execute("SP_LRECHECK", Envia) Then
        MsgBox "Problemas con la lectura de la clasificación de riesgos", vbCritical, gsBac_Version
        Exit Function
    End If

    LRECheck = ""

    Do While Bac_SQL_Fetch(Datos())
        If Datos(1) <> "OK" Then
            sRetorno = Space(3) & "Línea Emisor " & Datos(2) & vbCrLf
            sRetorno = sRetorno & Space(7) & "L.Disp. antes de la operación en UF   " & Format(Val(Datos(5)), "###,###,###,##0.0000") & vbCrLf
            sRetorno = sRetorno & Space(7) & "Monto de la operación en UF           " & Format(Val(Datos(8)), "###,###,###,##0.0000") & vbCrLf
            sRetorno = sRetorno & Space(7) & "L.Disp. después de la operación en UF " & Format(Val(Datos(7)), "###,###,###,##0.0000")
         'sRetorno = Space(3) & "Línea Emisor (" & Datos(2) & "-" & sIntrum & ") UF " & Datos(5) & "   " & Datos(8) & "   " & Datos(7)
            LRECheck = sRetorno
        End If
    Loop

End Function

Function LRICheck(nCodigo As Long, nRutemi, sIntrum As String, dFecha As String, cTipOper As String, nMonto As Double, cFecInic As String, cFecVenc As String) As String
Dim nLinBase      As Double
Dim nLinOcup      As Double
Dim nSaldo        As Double
Dim sNombre       As String
Dim sRetorno      As String
Dim Datos()

   'Lectura de las líneas de riesgo de los instrumentos
'   Sql = "SP_LRICHECK " & vbCrLf
'   Sql = Sql & nCodigo & ", " & vbCrLf
'   Sql = Sql & "'" & dFecha & "', " & vbCrLf
'   Sql = Sql & "'" & cTipOper & "', " & vbCrLf
'   Sql = Sql & "'" & Format(cFecInic, "MM/DD/YYYY") & "', " & vbCrLf
'   Sql = Sql & "'" & Format(cFecVenc, "MM/DD/YYYY") & "', " & vbCrLf
'   Sql = Sql & nRutemi & ", "
'   Sql = Sql & nMonto
   
   Envia = Array(CDbl(nCodigo), _
            dFecha, _
            cTipOper, _
            Format(cFecInic, "MM/DD/YYYY"), _
            Format(cFecVenc, "MM/DD/YYYY"), _
            CDbl(nRutemi), _
            nMonto)

    If Not Bac_Sql_Execute("SP_LRICHECK", Envia) Then
        MsgBox "Problemas con la lectura de la clasificación de riesgos", vbCritical, gsBac_Version
        Exit Function
    End If

    LRICheck = ""

    Do While Bac_SQL_Fetch(Datos())
        If Datos(1) <> "OK" Then
            sRetorno = Space(3) & "Línea Instrumentos " & Datos(2) & vbCrLf
            sRetorno = sRetorno & Space(7) & "L.Disp. antes de la operación en UF   " & Format(Val(Datos(5)), "###,###,###,##0.0000") & vbCrLf
            sRetorno = sRetorno & Space(7) & "Monto de la operación en UF           " & Format(Val(Datos(8)), "###,###,###,##0.0000") & vbCrLf
            sRetorno = sRetorno & Space(7) & "L.Disp. después de la operación en UF " & Format(Val(Datos(7)), "###,###,###,##0.0000")
         'sRetorno = Space(3) & "Línea Instrumentos (" & Datos(2) & "-" & sIntrum & ") UF " & Datos(5) & "   " & Datos(8) & "   " & Datos(7)
            LRICheck = sRetorno
        End If
    Loop

End Function

Function LROObservacion(nNumdocu As Double, sTipOper As String, sObservaciones As String) As Boolean
Dim nBlock  As Double     'Bloques de 255 caracteres
Dim nLoop   As Integer     'Número de Registros

    LROObservacion = False

    nBlock = Len(sObservaciones) / 255

    If nBlock <> Int(nBlock) Then
        nBlock = Int(nBlock) + 1
    Else
        nBlock = Int(nBlock)
    End If

    For nLoop = 0 To (nBlock - 1)
'        Sql = "SP_LROBSPENDIENTE " & nNumdocu & ", '" & sTipOper & "', '"
'        Sql = Sql & Mid$(sObservaciones, (nLoop * 255) + 1, 255) & "'"

        Envia = Array(nNumdocu, _
                Mid$(sObservaciones, (nLoop * 255) + 1, 255))

        If Not Bac_Sql_Execute("SP_LROBSPENDIENTE", Envia) Then
            Exit Function
        End If
    Next nLoop

    LROObservacion = True

End Function

Function LROLeerObservacion(nNumoper As Double) As String
Dim sCadena    As String
Dim Datos()

'    Sql = "SP_LROBSLEER " & nNumoper

   sCadena = ""
   
   Envia = Array(nNumoper)

   If Bac_Sql_Execute("SP_LROBSLEER", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            sCadena = sCadena & Datos(1)
        Loop
    End If

    LROLeerObservacion = sCadena

End Function
