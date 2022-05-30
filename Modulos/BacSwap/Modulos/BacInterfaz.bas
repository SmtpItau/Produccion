Attribute VB_Name = "BacInterfaz"
Option Explicit
'Public Sub InterfazC08C09(cRuta As String)
'
'Dim cLine As String
'Dim cNomArchivo
'
'On Error GoTo Herror
'
'   If Not Bac_Sql_Execute("sp_interfazC08C09") Then
'        MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
'        Exit Sub
'   End If
'
'   cNomArchivo = cRuta & "SWC08C09" & ".TXT"
'
'   Do While Bac_SQL_Fetch(Datos())
'       cLine = cLine & Datos(1)                               ' fecha proceso
'       cLine = cLine & Datos(2)                               ' Fw
'       cLine = cLine & Datos(3)                               ' cuenta contable
'       cLine = cLine & Format$(Val(Datos(4)), "000")          ' codmon
'       cLine = cLine & Format$(Val(Datos(5)), "0")            ' tipo de tasa
'       cLine = cLine & Datos(6)                               'fecha vcto
'       cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(7))), "00000000000000.0000"), gsc_PuntoDecim, "") 'monto
'       cLine = cLine & "00000000"                              'tasa interes
'       cLine = cLine & "000000000000000000"                   'saldo remanente
'       cLine = cLine & "0000"                                 'tipo inst. financiera
'       cLine = cLine & Datos(12)                                    'tipo cuenta
'       cLine = cLine + Chr(13) + Chr(10)
'
'   Loop
'
'   If Dir(cNomArchivo) <> "" Then
'        Kill cNomArchivo
'   End If
'
'   Open cNomArchivo For Binary Access Write As #1
'   Put #1, , cLine
'   Close #1
'
'   MsgBox "Interfaz C08-C09 Generada", vbOKOnly + vbInformation, Msj
'
'   Exit Sub
'
'Herror:
'   MsgBox "Error: " & Err.Number & " Descripción: " & Err.Description, vbCritical, "Interfaz"
'   Exit Sub
'
'End Sub
'Public Sub Interfazc14c15(cRuta As String)
'   Dim cLine As String
'   Dim cNomArchivo
'
'   On Error GoTo Herror
'
'    If Not Bac_Sql_Execute("sp_InterfazC14C15") Then
'
'      MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
'      Exit Sub
'
'   End If
'
'   cNomArchivo = cRuta & "SWC14C15" & ".TXT"
'
'   Do While Bac_SQL_Fetch(Datos())
'       cLine = cLine & Datos(1)                               ' fecha proceso
'       cLine = cLine & Datos(2)                               ' codigo
'       cLine = cLine & Format$(Val(Datos(3)), "000000000") & Datos(4)  'rutcli
'       cLine = cLine & Datos(5)                               'cuenta contable
'       cLine = cLine & Datos(7)                               'codmon
'       cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(6))), "00000000000000.0000"), gsc_PuntoDecim, "") 'monto
'       cLine = cLine & Datos(8)                               'fecha vcto
'       cLine = cLine + Chr(13) + Chr(10)
'
'   Loop
'
'   If Dir(cNomArchivo) <> "" Then
'        Kill cNomArchivo
'   End If
'
'
'   Open cNomArchivo For Binary Access Write As #1
'   Put #1, , cLine
'   Close #1
'
'   MsgBox "Interfaz C14-C15 ha sido Generada con exito ", vbOKOnly + vbInformation, Msj
'   Exit Sub
'
'Herror:
'   MsgBox "Error: " & Err.Number & " Descripción: " & Err.Description, vbCritical, "Interfaz"
'   Exit Sub
'
'
'End Sub
'Function BacInterfazContable(cRuta As String, cFecCon As String)
'
'Dim cNomArchivo
'Dim cLine As String
'Dim nCon As Integer
'Dim nFolio As Long
'Dim nDebe  As Double
'Dim nHaber As Double
'Dim nMoneda As Integer
'Dim nPrimer As Integer
'Dim nNumVoucher As Double
'Dim nNumeroper As Double
'Dim cFecha As String
'Dim cNomCli As String
'Dim nRut As Double
'Dim nMonSup As Integer
'
'On Error GoTo Herror
'
'nNumVoucher = 0
'nMoneda = 0
'nMonSup = 0
'nFolio = 502000
'cFecha = "000000"
'nNumeroper = 0
'nRut = 0
'cNomCli = ""
'nCon = 0
'
'nPrimer = 1
'
'
'cNomArchivo = cRuta & "MDINTCO" & ".DTA"
'
'If Not Bac_Sql_Execute("Sp_VoucherConsolidado" & "'" & Trim(cFecCon) & "'") Then
'   MsgBox "Problemas al leer interfaz contable", vbCritical, "MENSAJE"
'   Exit Function
'End If
'
'Do While Bac_SQL_Fetch(Datos())
'
''****total****
'
'   If (Val(Datos(9)) <> nMoneda Or Val(Datos(1)) <> nNumVoucher) And nPrimer = 0 Then
'      nCon = 0
'      cLine = cLine & Format$(Val(nMonSup), "00")     '-- Moneda
'      cLine = cLine & "71"                            '-- Oficina
'      cLine = cLine & "49"                            '-- Dpto
'      cLine = cLine & "645"                           '-- Bach
'      cLine = cLine & Format$(nFolio, "000000")       '-- fOLIO
'      cLine = cLine & "21"                            '-- EMISORA
'      cLine = cLine & "19"                            '-- DEPARTA
'      cLine = cLine & BacPad(Trim(cFecha), 6)         '-- fecha proceso
'      cLine = cLine & Space(40)                       '--
'      cLine = cLine & "0000000000"                    '-- Cuenta
'      cLine = cLine & "0000"                          '-- Correspon
'      cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(nDebe)), "0000000000000.00"), gsc_PuntoDecim, "") '--debe
'      cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(nHaber)), "0000000000000.00"), gsc_PuntoDecim, "") '--Haber
'      cLine = cLine & "000000000000"                  '-- Tc Cambio
'      cLine = cLine & Format$(nNumeroper, "0000000000")  '-- NumOpe
'      cLine = cLine & "00"                            '-- NumCuota
'      cLine = cLine & " "
'      cLine = cLine & "000000"                              '-- Feccontaparte
'      cLine = cLine & "000000"                              '-- Tasainter
'      cLine = cLine & "000000"                              '-- FecValuta
'      cLine = cLine & Format$(nRut, "000000000")        '-- RutCli
'      cLine = cLine & BacPad(Trim(cNomCli), 35)           '-- Nombre Cliente
'      cLine = cLine & "000"                                 '-- FinProd
'      cLine = cLine & " "                                   '-- Filler1
'      cLine = cLine & "0000"                                '--BcoCorrespons
'      cLine = cLine & " "                                   '--Gedin
'      cLine = cLine & "        "                            '--Filler2
'      cLine = cLine & "99"                                  '--Secuencia
'      cLine = cLine & "2"                                   '--TipoReg
'
'      cLine = cLine + Chr(13) + Chr(10)
'      nDebe = 0
'      nHaber = 0
'      nFolio = nFolio + 1
'
'   End If
'
'   '***Detalle****
'   nPrimer = 0
'   nMoneda = Val(Datos(9))
'   nMonSup = Val(Mid(Datos(28), 1, 2))
'   nNumVoucher = Val(Datos(1))
'   cFecha = Left(Datos(20), 2) & Mid(Datos(20), 4, 2) & Right(Datos(20), 2)
'   nNumeroper = Val(Datos(10))
'   nRut = Val(Datos(18))
'   cNomCli = Datos(16)
'   nCon = nCon + 1
'
'   cLine = cLine & Format$(Val(Mid(Datos(28), 1, 2)), "00") '-- Moneda
'   cLine = cLine & "71"                            '-- Oficina
'   cLine = cLine & "49"                            '-- Dpto
'   cLine = cLine & "645"                           '-- Bach
'   cLine = cLine & Format$(nFolio, "000000") '-- fOLIO
'   cLine = cLine & "21"                            '-- EMISORA
'   cLine = cLine & "19"                            '-- DEPARTA
'   cLine = cLine & Left(Datos(20), 2) & Mid(Datos(20), 4, 2) & Right(Datos(20), 2) '-- fecha proceso
'   cLine = cLine & BacPad(Trim(Datos(21)), 40)     '-- Glosa Cuenta
'   cLine = cLine & BacPad(Trim(Datos(3)), 10)      '-- Cuenta
'   cLine = cLine & "0000"                          '-- Correspon
'
'   If Datos(7) = "D" Then
'      cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(8))), "0000000000000.00"), gsc_PuntoDecim, "") '--debe
'      cLine = cLine & "000000000000000" '--Haber
'      nDebe = nDebe + CDbl(Datos(8))      '--debe
'   Else
'      cLine = cLine & "000000000000000" '--Debe
'      cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(8))), "0000000000000.00"), gsc_PuntoDecim, "") '--haber
'      nHaber = nHaber + CDbl(Datos(8))    '--haber
'   End If
'
'   If Val(Datos(22)) = 3 Then     'uf/clp
'     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(15))), "00000000.0000"), gsc_PuntoDecim, "")                '-- Tc Cambio
'   Else  '--obs
'     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(14))), "00000000.0000"), gsc_PuntoDecim, "")                '-- Tc Cambio
'   End If
'
'   cLine = cLine & Format$(Val(Datos(10)), "0000000000") '-- NumOpe
'   cLine = cLine & "00"                            '-- NumCuota
'
'   If Trim(Datos(3)) = "989963000" Then
'
'      If Trim(Datos(27)) = "I" Then
'         cLine = cLine & "V"
'         cLine = cLine & Left(Datos(25), 2) & Mid(Datos(25), 4, 2) & Right(Datos(25), 2)        '--Fecha Vcto
'      ElseIf Trim(Datos(27)) = "V" Then
'         cLine = cLine & "C"
'         cLine = cLine & Left(Datos(24), 2) & Mid(Datos(24), 4, 2) & Right(Datos(24), 2)        '--Fecha Vcto
'      Else
'        cLine = cLine & " "
'        cLine = cLine & "000000"
'      End If
'
'   Else
'      cLine = cLine & " "
'      cLine = cLine & "000000" '--Fecha Vcto
'   End If
'
'   cLine = cLine & "000000"                              '-- Tasainter
'   cLine = cLine & "000000"                              '-- FecValuta
'   cLine = cLine & Format$(Val(Datos(18)), "000000000")  '-- RutCli
'   cLine = cLine & BacPad(Trim(Datos(16)), 35)           '-- Nombre Cliente
'   cLine = cLine & "000"                                 '-- FinProd
'   cLine = cLine & " "                                   '-- Filler1
'   cLine = cLine & "0000"                                '--BcoCorrespons
'   cLine = cLine & " "                                   '--Gedin
'   cLine = cLine & "        "                            '--Filler2
'   cLine = cLine & Format$(Val(nCon), "00")         '--Secuencia
'   cLine = cLine & "1"                                   '--TipoReg
'   cLine = cLine + Chr(13) + Chr(10)
'
'
'
'Loop
'
'   '*****ultimo
'
'      cLine = cLine & Format$(Val(nMonSup), "00")   '-- Moneda
'      cLine = cLine & "71"                            '-- Oficina
'      cLine = cLine & "49"                            '-- Dpto
'      cLine = cLine & "645"                           '-- Bach
'      cLine = cLine & Format$(nFolio, "000000")  '-- fOLIO
'      cLine = cLine & "21"                            '-- EMISORA
'      cLine = cLine & "19"                            '-- DEPARTA
'      cLine = cLine & BacPad(Trim(cFecha), 6) '-- fecha proceso
'      cLine = cLine & Space(40)                       '--
'      cLine = cLine & "0000000000"                    '-- Cuenta
'      cLine = cLine & "0000"                          '-- Correspon
'      cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(nDebe)), "0000000000000.00"), gsc_PuntoDecim, "") '--debe
'      cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(nHaber)), "0000000000000.00"), gsc_PuntoDecim, "") '--Haber
'      cLine = cLine & "000000000000"        '-- Tc Cambio
'      cLine = cLine & Format$(nNumeroper, "0000000000")  '-- NumOpe
'      cLine = cLine & "00"                            '-- NumCuota
'      cLine = cLine & " "
'      cLine = cLine & "000000"                              '-- Feccontaparte
'      cLine = cLine & "000000"                              '-- Tasainter
'      cLine = cLine & "000000"                              '-- FecValuta
'      cLine = cLine & Format$(nRut, "000000000")  '-- RutCli
'      cLine = cLine & BacPad(Trim(cNomCli), 35)           '-- Nombre Cliente
'      cLine = cLine & "000"                                 '-- FinProd
'      cLine = cLine & " "                                   '-- Filler1
'      cLine = cLine & "0000"                                '--BcoCorrespons
'      cLine = cLine & " "                                   '--Gedin
'      cLine = cLine & "        "                            '--Filler2
'      cLine = cLine & "99"                                  '--Secuencia
'      cLine = cLine & "2"                                   '--TipoReg
'
'
'   If Dir(cNomArchivo) <> "" Then
'        Kill cNomArchivo
'   End If
'
'
'   Open cNomArchivo For Binary Access Write As #1
'   Put #1, , cLine
'   Close #1
'
'   MsgBox "Interfaz contable Generada con Exito! ", vbOKOnly + vbInformation, Msj
'   Exit Function
'
'Herror:
'   MsgBox "Error: " & Err.Number & " Descripción: " & Err.Description, vbCritical, "Interfaz"
'   Exit Function
'
'End Function

Sub InterfazBalance(cruta As String)

 Dim total          As Integer
 Dim totalreg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
 Dim nrotel         As String
 Dim NumeroTel      As String
 
 On Error GoTo Herror1
 total = 0
 totalreg = 0
 cNomArchivo = ""
 cDia = Format(gsBAC_Fecp, "yymmdd")
 cNomArchivo = cruta & "BO52" & cDia & ".DAT"

 If Not Bac_Sql_Execute("SP_INTERFAZ_BALANCE_SWAP") Then
    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
    Call GRABA_LOG_AUDITORIA("Opc_60150", "09", "Problemas Procedimiento", "", "", "")
    Exit Sub
 End If
  
 If Dir(cNomArchivo) <> "" Then
    Kill cNomArchivo
 End If

   Open cNomArchivo For Output As #1
      
   Do While Bac_SQL_Fetch(Datos())
     If Datos(15) = "11" Then
        totalreg = totalreg
     End If
       
     cLine = ""
     cLine = cLine & BacPad((Datos(2)), 3)
     cLine = cLine & Format(Datos(3), "YYYYMMDD")
     cLine = cLine & BacPad((Datos(4)), 14)
     cLine = cLine & Datos(5)
     cLine = cLine & Datos(6)
     cLine = cLine & Datos(7)
     cLine = cLine & BacPad((Datos(8)), 16)
     cLine = cLine & Space(1)
     cLine = cLine & Datos(10)
     cLine = cLine & BacPad((Datos(11)), 20)
     cLine = cLine & Format(Datos(12), "YYYYMMDD")
     cLine = cLine & BacPad((Datos(13)), 20)
     cLine = cLine & Format(Datos(14), "00")
     cLine = cLine & Datos(15)
     cLine = cLine & BacPad((Datos(16)), 3)
     cLine = cLine & Datos(17)
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(18))), 2), "000000000000000000")
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(18))), "0000000000000000.00"), gsc_PuntoDecim, "") '25
     cLine = cLine & Datos(19)
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(20))), 2), "000000000000000000")
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(20))), "0000000000000000.00"), gsc_PuntoDecim, "") '25
     cLine = cLine & BacPad((Datos(21)), 1)
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(22))), 2), "000000000000000000")
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(22))), "0000000000000000.00"), gsc_PuntoDecim, "") '25
     cLine = cLine & BacPad((Datos(23)), 3)
     cLine = cLine & BacPad((Datos(24)), 10)
     
     totalreg = totalreg + 1
     If Len(cLine) = 178 Then
        totalreg = totalreg
     End If
    
    Print #1, cLine
    Loop
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & "99" & Format(gsBAC_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(158)
    Print #1, cLine
    Close #1
        
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, TITSISTEMA
   Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call GRABA_LOG_AUDITORIA("Opc_60150", "09", "Interfaz Error", "", "", cNomArchivo & " " & err.Description)
   Exit Sub

End Sub


Sub InterfazDerivados(cruta As String)
 Dim total          As Integer
 Dim totalreg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
  
 On Error GoTo Herror1

     total = 0
     totalreg = 0
     cNomArchivo = ""
     cDia = Format(gsBAC_Fecp, "yymmdd")
     cNomArchivo = cruta & "DE52" & cDia & ".DAT"
    
     If Not Bac_Sql_Execute("SP_INTERFAZ_DERIVADOS_SWAP") Then
        MsgBox "Problemas al leer operaciones", vbCritical, TITSISTEMA
        Call GRABA_LOG_AUDITORIA("Opc_60170", "03", "Problemas Procedimiento", "", "", "")
        Exit Sub
     End If
      
     If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
     End If
    
     Open cNomArchivo For Output As #1
      
     Do While Bac_SQL_Fetch(Datos())
       
        cLine = ""
        cLine = cLine & BacPad((Datos(1)), 3)
        cLine = cLine & Datos(2)
        cLine = cLine & BacPad((Datos(3)), 14)
        cLine = cLine & Datos(4)
        cLine = cLine & Datos(5)
        cLine = cLine & Datos(6)
        cLine = cLine & BacPad((Datos(7)), 16)
        cLine = cLine & Space(1)
        cLine = cLine & Datos(9)
        cLine = cLine & Datos(10)
        cLine = cLine & BacPad((Datos(11)), 3)
        cLine = cLine & BacPad((Datos(24)), 20)
        cLine = cLine & BacPad(Datos(13) + Datos(14), 12)
        cLine = cLine & Datos(15)
        cLine = cLine & Datos(16)
        cLine = cLine & IIf(Datos(17) = 0, Space(3), BacPad(CStr(Datos(17)), 3))
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(18))), "0000000000000000.00"), gsc_PuntoDecim, "")
        cLine = cLine & IIf(Datos(19) = 0, Space(3), BacPad((Datos(19)), 3))
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(20))), "0000000000000000.00"), gsc_PuntoDecim, "")
        cLine = cLine & BacPad((Datos(21)), 1) 'Datos(21)

        ' NUEVO
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(26))), "0000000000000000.00"), gsc_PuntoDecim, "")
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(27))), "0000000000000000.00"), gsc_PuntoDecim, "")
        cLine = cLine & BacPad((Datos(28)), 2)
        cLine = cLine & BacPad((Datos(29)), 2)
        cLine = cLine & BacPad((Datos(30)), 8)
        cLine = cLine & BacPad((Datos(31)), 8)
'        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(DATOS(32))), "0000000000000000.00"), gsc_PuntoDecim, "")
'        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(DATOS(33))), "0000000000000000.00"), gsc_PuntoDecim, "")

        If Val(bacTranMontoSql(Datos(32))) > 0 Then
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(32))), "0000000000000000.00"), gsc_PuntoDecim, "")
        Else
        cLine = cLine & BacStrTran(Format$(Abs(Val(bacTranMontoSql(Datos(32)))), "-000000000000000.00"), gsc_PuntoDecim, "")
        End If
        If Val(bacTranMontoSql(Datos(33))) > 0 Then
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(33))), "0000000000000000.00"), gsc_PuntoDecim, "")
        Else
        cLine = cLine & BacStrTran(Format$(Abs(Val(bacTranMontoSql(Datos(33)))), "-000000000000000.00"), gsc_PuntoDecim, "")
        End If


        cLine = cLine & IIf(Datos(34) = 0, Space(3), BacPad(CStr(Datos(34)), 3))
        cLine = cLine & IIf(Datos(35) = 0, Space(3), BacPad(CStr(Datos(35)), 3))

        totalreg = totalreg + 1
        
        If Len(cLine) <> 212 Then
           totalreg = totalreg
        End If
                
        Print #1, cLine
        
     Loop
 
     cLine = ""
     totalreg = totalreg + 1
     cLine = cLine & "99" & Format(gsBAC_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(234)
     Print #1, cLine
     Close #1
        
     MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, TITSISTEMA

     Exit Sub
   
Herror1:

   Close #1
   
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   
   Call GRABA_LOG_AUDITORIA("Opc_60170", "09", "Interfaz Error", "", "", cNomArchivo & " " & err.Description)
   Exit Sub


End Sub

Sub InterfazDirecciones(cruta As String)
 Dim total          As Integer
 Dim totalreg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
 Dim NumeroTel      As String
 Dim nrotel         As String
 On Error GoTo Herror1
     total = 0
     totalreg = 0
     cNomArchivo = ""
 cDia = Format(gsBAC_Fecp, "yymmdd")
  cNomArchivo = cruta & "DD52" & cDia & ".DAT"

 If Not Bac_Sql_Execute("SP_INTERFAZ_DIRECCIONES_SWAP") Then
    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
    Call GRABA_LOG_AUDITORIA("Opc_60180", "03", "Problemas Procedimiento", "", "", "")
    Exit Sub
 End If
  
  If Dir(cNomArchivo) <> "" Then
    Kill cNomArchivo
 End If

 Open cNomArchivo For Output As #1
   
 Do While Bac_SQL_Fetch(Datos())
 
    If Len(Datos(10)) > 11 Then
        nrotel = Mid$(Datos(10), 1, 7)
        NumeroTel = Format(Val(nrotel), "00000000000")
    Else
       NumeroTel = Format(Val(Datos(10)), "00000000000")
    End If
   
     cLine = ""
     cLine = cLine & BacPad((Datos(1) + Datos(2)), 15)  'ESPACIOS(Datos(1) + Datos(2), 15, "D")
     cLine = cLine & BacPad((Datos(3)), 8)
     cLine = cLine & BacPad((Datos(4)), 8)
     cLine = cLine & BacPad((Datos(5)), 16)
     cLine = cLine & BacPad((Datos(6)), 40)
     cLine = cLine & Space(40)
     cLine = cLine & IIf(Datos(8) = "0", BacPad(("9999"), 8), BacPad((Datos(8)), 8))
     cLine = cLine & IIf(Datos(9) = "0", BacPad(("9999"), 8), BacPad((Datos(9)), 8))
     cLine = cLine & IIf(NumeroTel = 0, "00000000000", NumeroTel)
     cLine = cLine & Format(Datos(11), "YYYYMMDD")
         
     If Len(cLine) <> 162 Then
           
     End If
     
    totalreg = totalreg + 1
    Print #1, cLine
    Loop
    
    Close #1
       
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, TITSISTEMA
    'Label2.Visible = False
    Exit Sub
   
Herror1:
  MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
  Call GRABA_LOG_AUDITORIA("Opc_60180", "09", "Interfaz Error", "", "", cNomArchivo & " " & err.Description)
  Exit Sub

End Sub


Sub InterfazFlujos(cruta As String)
 Dim total          As Integer
 'Dim totalreg       As Integer  '20100106 Aumenta la cantidad de registros
 Dim totalreg       As Long  '20100106 Aumenta la cantidad de registros
 
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
  
 On Error GoTo Herror1

     total = 0
     totalreg = 0
     cNomArchivo = ""
     cDia = Format(gsBAC_Fecp, "yymmdd")
     cNomArchivo = cruta & "FD52" & cDia & ".DAT"
    
     If Not Bac_Sql_Execute("SP_INTERFAZ_FLUJOS_SWAP") Then
        MsgBox "Problemas al leer operaciones", vbCritical, TITSISTEMA
        Call GRABA_LOG_AUDITORIA("Opc_60160", "03", "Problemas Procedimiento", "", "", "")
        Exit Sub
     End If
      
     If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
     End If
    
     Open cNomArchivo For Output As #1
      
     Do While Bac_SQL_Fetch(Datos())

        cLine = ""
        cLine = cLine & BacPad((Datos(1)), 3)
        cLine = cLine & Format((Datos(2)), "YYYYMMDD")
        cLine = cLine & BacPad((Datos(3)), 14)
        cLine = cLine & BacPad((Datos(4)), 3)
        cLine = cLine & BacPad((Datos(5)), 16)
        cLine = cLine & BacPad((Datos(6)), 20)
        cLine = cLine & Format((Datos(7)), "YYYYMMDD")
        'MAP -- 20091026 Envio de MOntos Negativos
        If Datos(8) < 0 Then
           cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Abs(Datos(8)))), "-000000000000000.00"), gsc_PuntoDecim, "")
        Else
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(8))), "0000000000000000.00"), gsc_PuntoDecim, "")
        End If
        If Datos(9) < 0 Then
           cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Abs(Datos(9)))), "-000000000000000.00"), gsc_PuntoDecim, "")
        Else
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(9))), "0000000000000000.00"), gsc_PuntoDecim, "")
        End If
        If Datos(10) < 0 Then
           cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Abs(Datos(10)))), "-000000000000000.00"), gsc_PuntoDecim, "")
        Else
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(10))), "0000000000000000.00"), gsc_PuntoDecim, "")
        End If
        cLine = cLine & BacPad((Datos(11)), 3)
        cLine = cLine & Space(9) & BacPad((Datos(12)), 1)  'MAP 20100204 Corrige identación Waldo S. pidio x e-mail

        ' NUEVO
        cLine = cLine & Mid(Datos(14), 1, 1)

        totalreg = totalreg + 1
        
        If Len(cLine) <> 140 Then
           MsgBox "Interfaz se Descuadro en el largo", vbOKOnly, TITSISTEMA
        End If
                
        Print #1, cLine
        
    Loop
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & "99" & Format(gsBAC_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(120)
    Print #1, cLine
    Close #1
        
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, TITSISTEMA
    Exit Sub
   
Herror1:

   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call GRABA_LOG_AUDITORIA("Opc_60160", "09", "Interfaz Error", "", "", cNomArchivo & " " & err.Description)
   Exit Sub

End Sub


Sub InterfazOperaciones(cruta As String)
    Dim total          As Integer
    Dim totalreg       As Integer
    Dim cDia           As String
    Dim cNomArchivo    As String
    Dim cLine          As String

 On Error GoTo Herror1
    total = 0
    totalreg = 0
    cNomArchivo = ""
    cDia = Format(gsBAC_Fecp, "yymmdd")
    cNomArchivo = cruta & "OP52" & cDia & ".DAT"

    If Not Bac_Sql_Execute("SP_INTERFAZ_OPERACIONES_SWAP") Then
        MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
        Call GRABA_LOG_AUDITORIA("Opc_60140", "09", "Problemas Procedimiento", "", "", "")
        Exit Sub
    End If
    
    If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
    End If

    'Open cNomArchivo For Binary Access Write As #1
    Open cNomArchivo For Output As #1
  
    Do While Bac_SQL_Fetch(Datos())
        cLine = ""
        cLine = cLine & BacPad((Datos(1)), 3)               '1
        cLine = cLine & Format(gsBAC_Fecp, "YYYYMMDD")      '2
        cLine = cLine & Format(gsBAC_Fecp, "YYYYMMDD")      '3
        cLine = cLine & BacPad((Datos(4)), 14)              '4
        cLine = cLine & BacPad((Datos(5)), 3)               '5
        cLine = cLine & BacPad((Datos(6)), 3)               '6
        cLine = cLine & BacPad((Datos(7)), 3)               '7
        cLine = cLine & "1"                                 '8
        cLine = cLine & BacPad((Datos(9)), 4)               '9
        cLine = cLine & BacPad((Datos(10)), 4)              '10
        cLine = cLine & BacPad((Datos(11)), 16)             '11
        cLine = cLine & Space(1)                            '12
        cLine = cLine & "M"                                 '13
        cLine = cLine & Format(Datos(14), "YYYYMMDD")       '14
        cLine = cLine & Format(Datos(15), "YYYYMMDD")       '15
        cLine = cLine & BacPad(Datos(16) + Datos(17), 12)   '16
        cLine = cLine & BacPad((Datos(18)), 10)             '17
        cLine = cLine & BacPad((Datos(96)), 20)             '18
        cLine = cLine & Format(Datos(20), "YYYYMMDD")       '19
        cLine = cLine & Format(Datos(21), "YYYYMMDD")       '20
        cLine = cLine & BacPad((Datos(22)), 8)              '21
        cLine = cLine & Datos(23)                           '22
        cLine = cLine & BacPad((Datos(24)), 3)              '23
        cLine = cLine & Datos(25)                           '24
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(26))), "0000000000000000.00"), gsc_PuntoDecim, "") '25
        cLine = cLine & Datos(27)                                                           '26
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(28))), "0000000000000000.00"), gsc_PuntoDecim, "") '27
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(29))), "0000000000000000.00"), gsc_PuntoDecim, "") '28
        cLine = cLine & Datos(30)                           '29
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(31))), "0000000000000000.00"), gsc_PuntoDecim, "") '30
        cLine = cLine & Datos(32)                           '31
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(33))), "0000000000000000.00"), gsc_PuntoDecim, "") '32
        cLine = cLine & Datos(34)                           '33
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(35))), "0000000000000000.00"), gsc_PuntoDecim, "") '34
        cLine = cLine & BacPad((Datos(36)), 2)              '35
        cLine = cLine & BacPad((Datos(37)), 4)              '36
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(38))), "00000000.00000000"), gsc_PuntoDecim, "") '37
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(39))), "00000000.00000000"), gsc_PuntoDecim, "") '38
        cLine = cLine & Datos(40)                           '39
        cLine = cLine & Format(Datos(41), "0000000000000000") '40
        cLine = cLine & BacPad((Datos(42)), 5)              '41
        cLine = cLine & BacPad((Datos(43)), 4)              '42
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(44))), "00000000.00000000"), gsc_PuntoDecim, "") '43
        cLine = cLine & Format(Datos(45), "0000000000000000") '44
        cLine = cLine & Format(Datos(46), "0000000000000000") '45
        cLine = cLine & Datos(47)                           '46
        cLine = cLine & Datos(48)                           '47
        cLine = cLine & Format(Datos(49), "000000000000000000")    '48
        cLine = cLine & Format(Datos(50), "000")            '49
        cLine = cLine & Format(Datos(51), "00")             '50
        cLine = cLine & Format(Datos(52), "0")              '51
        cLine = cLine & Datos(53)                           '52
        cLine = cLine & Format(Datos(54), "000000000000000000") '53
        cLine = cLine & BacPad((Datos(55)), 8)              '54
        cLine = cLine & BacPad((Datos(56)), 8)              '55
        cLine = cLine & BacPad((Datos(57)), 8)              '56
        cLine = cLine & BacPad((Datos(58)), 8)              '57
        cLine = cLine & BacPad((Datos(59)), 20)             '58
        cLine = cLine & Format(Datos(60), "0000")           '59
        cLine = cLine & Format(Datos(61), "0000")           '60
        cLine = cLine & Format(Datos(62), "0000")           '61
        cLine = cLine & Format(Datos(63), "000")            '62
        cLine = cLine & BacPad((Datos(64)), 8)              '63
        cLine = cLine & BacPad((Datos(65)), 8)              '64
        cLine = cLine & BacPad((Datos(66)), 1)              '65
        cLine = cLine & BacPad((Datos(67)), 8)              '66
        cLine = cLine & BacPad((Datos(68)), 8)              '67
        cLine = cLine & BacPad((Datos(69)), 8)              '68
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(70))), "0000000000000000.00"), gsc_PuntoDecim, "")    '69
        cLine = cLine & Format(Datos(71), "000000000000000000")    '70
        cLine = cLine & Format(Datos(72), "000000000000000000")    '71
        cLine = cLine & Format(Datos(73), "000000000000000000")    '72
        cLine = cLine & Format(Datos(74), "000000000000000000")   '73
        cLine = cLine & Format(Datos(75), "000000000000000000")   '74
        cLine = cLine & Format(Datos(76), "000000000000000000")   '75
        cLine = cLine & Format(Datos(77), "000000000000000000")   '76
        cLine = cLine & BacPad((Datos(78)), 1)                     '77
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(79))), "0000000000000000.00"), gsc_PuntoDecim, "")    '78
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(80))), "0000000000000000.00"), gsc_PuntoDecim, "")    '79
        cLine = cLine & Datos(81)                                 '80
        cLine = cLine & Format(Datos(82), "000")                  '81
        cLine = cLine & Format(Datos(83), "0000")                 '82
        cLine = cLine & Format(Datos(84), "000000000000000000")  '83
        cLine = cLine & BacPad((Datos(85)), 1)                            '84
        cLine = cLine & BacPad((Datos(86)), 1)                            '85
        cLine = cLine & BacPad((Datos(87)), 1)                            '86
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(88))), "0000000000.00"), gsc_PuntoDecim, "")          '87
        cLine = cLine & BacPad((Datos(89)), 5)                            '88
        cLine = cLine & BacPad((Datos(90)), 15)                           '89
        cLine = cLine & BacPad((Datos(91)), 4)                            '90
        cLine = cLine & BacPad((Datos(92)), 4)                           '91
        cLine = cLine & BacPad((Datos(93)), 3) '+ Chr(13) + Chr(10)         '92
        cLine = cLine & "0000000000000000"                              '93
        cLine = cLine & "0000"                                          '94

        '>>>> Agregado con Fecha 18-Agosto-2008.- Cambio Estructura Interfaz Neosoft
        cLine = cLine & "000000000000000000"    '--> 95. >> Monto Mora 4 en Moneda Local (18,2)
        cLine = cLine & "000000000000000000"    '--> 96. >> Monto Mora 5 en Moneda Local (18,2)
        cLine = cLine & "000000000000000000"    '--> 97. >> Monto Mora 6 en Moneda Local (18,2)
        cLine = cLine & "S"                     '--> 98. >> Indicador Sbif               (1)
        cLine = cLine & "000000000000000000"    '--> 99. >> Otros cobros para Deuda      (18,2)

        '>>>>> Se Agrega en requerimiento N° 8136
        cLine = cLine & "000000000000000000"   '--> Monto Mora 2 en Moneda Local (lcy_pdo7_amt)
        cLine = cLine & "000000000000000000"   '--> Monto Mora 7 en Moneda Local (lcy_pdo8_amt)
        cLine = cLine & "000000000000000000"   '--> Monto Mora 9 en Moneda Local (lcy_pdo9_amt)
        cLine = cLine & " "                    '--> Origen del Activo            (assets_origin)
        '>>>>> Se Agrega en requerimiento N° 8136

        totalreg = totalreg + 1
        If Len(cLine) <> 786 Then
           totalreg = totalreg
        End If
        
        Print #1, cLine
    Loop
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & "99" & Format(gsBAC_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786)
    Print #1, cLine
    Close #1
        
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, TITSISTEMA
    Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call GRABA_LOG_AUDITORIA("Opc_60140", "09", "Interfaz Error", "", "", cNomArchivo & " " & err.Description)
   Exit Sub

End Sub

Sub InterfazPosicion(cruta As String)

 Dim total          As Integer
 Dim totalreg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cLine          As String
 Dim nrotel         As String
 Dim NumeroTel      As String
 
 On Error GoTo Herror1
 total = 0
 totalreg = 0
 cNomArchivo = ""
 cDia = Format(gsBAC_Fecp, "yymmdd")
 cNomArchivo = cruta & "PC52" & cDia & ".DAT"

 If Not Bac_Sql_Execute("SP_INTERFAZ_POSICION_CLIENTE_SWP") Then
    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
    Call GRABA_LOG_AUDITORIA("Opc_60180", "09", "Problemas Procedimiento", "", "", "")
    Exit Sub
 End If
  
 If Dir(cNomArchivo) <> "" Then
    Kill cNomArchivo
 End If

   Open cNomArchivo For Output As #1
      
   Do While Bac_SQL_Fetch(Datos())
       
     cLine = ""
     cLine = cLine & Datos(1)                                   '1
     cLine = cLine & Datos(2)                                   '2
     cLine = cLine & Datos(3) & String(3 - Len(Datos(3)), " ")  '3
     cLine = cLine & Format(Datos(4), "0000000000000000")       '4
     cLine = cLine & Format(0, "00000000")                      '5
     cLine = cLine & Format(0, "000000000000")                  '6
     cLine = cLine & Datos(5)                                   '7
     cLine = cLine & Datos(6)                                   '8
     cLine = cLine & Datos(7)                                   '9
     cLine = cLine & Format(Datos(8), "00")                     '10
     cLine = cLine & Format(0, "000000000")                     '11
     cLine = cLine & Space(4)                                   '12
     cLine = cLine & Space(4)                                   '13
     cLine = cLine & BacPad((Datos(9)), 4)                      '14
     cLine = cLine & Space(4)                                   '15
     cLine = cLine & Space(4)                                   '16
     cLine = cLine & IIf(Datos(10) = "0", Space(4), BacPad((Datos(10)), 4))    '17
     cLine = cLine & BacPad((Datos(11)), 4)                     '18
     cLine = cLine & Space(4)                                   '19
     cLine = cLine & Space(4)                                   '20
     cLine = cLine & Space(6)                                   '21
     cLine = cLine & Space(4)                                   '22
     cLine = cLine & Space(4)                                   '23
     cLine = cLine & Space(4)                                   '24
     cLine = cLine & BacPad("+", 4)                             '25
     cLine = cLine & Space(1)                                   '26
     cLine = cLine & Space(4)                                   '27
     cLine = cLine & BacPad((Datos(12)), 4)                     '28
     cLine = cLine & Format(0, "000000000000")                  '29
     cLine = cLine & BacPad((Datos(13)), 35)                    '30
     cLine = cLine & Format(Datos(14), "00")                    '31
     cLine = cLine & Format(Datos(15), "00")                    '32
     cLine = cLine & Format(Datos(16), "0000")                  '33
     cLine = cLine & BacPad((Datos(17)), 4)                     '34
     cLine = cLine & BacPad((Datos(46)), 16)   '35
     cLine = cLine & Format(0, "000000000000")                  '36
     cLine = cLine & BacPad(Datos(19) + Datos(20), 15)          '37
     cLine = cLine & Space(4)                                   '38
     cLine = cLine & Format(0, "000000")                        '39
     cLine = cLine & Datos(21)                                  '40
     cLine = cLine & Space(1)                                   '41
     cLine = cLine & Space(4)                                   '42
     cLine = cLine & Space(4)                                   '43
     cLine = cLine & Format(Datos(22), "00")                    '44
     cLine = cLine & Format(Datos(23), "00")                    '45
     cLine = cLine & Format(Datos(24), "0000")                  '46
     cLine = cLine & Format(Datos(25), "00")                    '47
     cLine = cLine & Format(Datos(26), "00")                    '48
     cLine = cLine & Format(Datos(27), "0000")                  '49
     cLine = cLine & Format(0, "00")                            '50
     cLine = cLine & Format(0, "00")                            '51
     cLine = cLine & Format(0, "0000")                          '52
     cLine = cLine & Format(0, "000")                           '53
     cLine = cLine & Format(Datos(28), "0000")                  '54
     cLine = cLine & Datos(29)                                  '55
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(30))), "000.000000"), gsc_PuntoDecim, "")  '56
     cLine = cLine & Format(Datos(31), "0000")                  '57
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(32))), "000.000000"), gsc_PuntoDecim, "")  '58
     cLine = cLine & Format(0, "000000000")                     '59
     cLine = cLine & Format(0, "00")                            '60
     cLine = cLine & Format(0, "00")                            '61
     cLine = cLine & Format(0, "0000")                          '62
     cLine = cLine & Format(0, "00")                            '63
     cLine = cLine & Format(0, "00")                            '64
     cLine = cLine & Format(0, "0000")                          '65
     cLine = cLine & Format(0, "00")                            '66
     cLine = cLine & Format(0, "00")                            '67
     cLine = cLine & Format(0, "0000")                          '68
     cLine = cLine & Format(0, "00")                            '69
     cLine = cLine & Format(0, "00")                            '70
     cLine = cLine & Format(0, "0000")                          '71
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(33))), 2), "000000000000000") '72
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(33))), "0000000000000.00"), gsc_PuntoDecim, "")
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(34))), 2), "000000000000000") '73
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(34))), "0000000000000.00"), gsc_PuntoDecim, "")
     cLine = cLine & Format(0, "000000000000000")               '74
     cLine = cLine & Format(0, "000000000000000")               '75
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(43))), 6), "00000000000")  '76
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(43))), "00000.000000"), gsc_PuntoDecim, "")
     cLine = cLine & Format(0, "000000000000000")               '77
     cLine = cLine & Format(0, "000000000000000")               '78
     cLine = cLine & Space(4)                                   '79
     cLine = cLine & Space(4)                                   '80
     cLine = cLine & Space(4)                                   '81
     cLine = cLine & Space(4)                                   '82
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(35))), 2), "000000000000000") '83
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(35))), "0000000000000.00"), gsc_PuntoDecim, "")
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(36))), 2), "000000000000000") '84
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(36))), "0000000000000.00"), gsc_PuntoDecim, "")
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(37))), 2), "000000000000000") '85
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(37))), "0000000000000.00"), gsc_PuntoDecim, "")
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(38))), 2), "000000000000000") '86
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(38))), "0000000000000.00"), gsc_PuntoDecim, "")
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(39))), 2), "000000000000000") '87
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(39))), "0000000000000.00"), gsc_PuntoDecim, "")
     cLine = cLine & Format(0, "000000000000000")               '88
     cLine = cLine & Format(0, "000000000000000")               '89
     cLine = cLine & Format(0, "000000000000000")               '90
     cLine = cLine & Format(0, "000000000000000")               '91
     cLine = cLine & Format(0, "000000000000000")               '92
     cLine = cLine & Format(0, "000000000000000")               '93
     cLine = cLine & Format(0, "000000000000000")               '94
     'cLine = cLine & Format(saca_punto(Trim(Str(Datos(44))), 2), "000000000000000") '95
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(44))), "0000000000000.00"), gsc_PuntoDecim, "")
     cLine = cLine & Format(0, "000000000000000")               '96
     cLine = cLine & Format(0, "000000000000000")               '97
     cLine = cLine & Format(0, "000000000000000")               '98
     cLine = cLine & Space(4)                                   '99
     cLine = cLine & Format(0, "00")                            '100
     cLine = cLine & Format(0, "00")                            '101
     cLine = cLine & Format(0, "0000")                          '102
     cLine = cLine & Format(0, "000000000000000")               '103
     cLine = cLine & Format(0, "000000000000000")               '104
     cLine = cLine & Format(0, "000000000000000")               '105
     cLine = cLine & Format(0, "0000")                          '106
     cLine = cLine & Format(0, "0000")                          '107
     cLine = cLine & Format(0, "0000")                          '108
     cLine = cLine & Format(0, "00")                            '109
     cLine = cLine & Format(0, "00")                            '110
     cLine = cLine & Format(0, "0000")                          '111
     cLine = cLine & Format(0, "0000")                          '112
     cLine = cLine & Format(0, "0000")                          '113
     cLine = cLine & Format(0, "0000")                          '114
     cLine = cLine & Format(0, "0000")                          '115
     cLine = cLine & Format(0, "00")                            '116
     cLine = cLine & Format(0, "00")                            '117
     cLine = cLine & Format(0, "0000")                          '118
     cLine = cLine & Space(2)                                   '119
     cLine = cLine & Space(4)                                   '120
     cLine = cLine & Format(0, "000000000")                     '121
     cLine = cLine & Space(15)                                  '122
     cLine = cLine & Format(0, "000000000000000")               '123
     cLine = cLine & Format(0, "00")                            '124
     cLine = cLine & Format(0, "00")                            '125
     cLine = cLine & Format(0, "0000")                          '126
     cLine = cLine & Datos(40)                                  '127
     cLine = cLine & "X"                                        '128
     cLine = cLine & Datos(41)                                  '129
          
     totalreg = totalreg + 1
     If Len(cLine) <> 865 Then
        totalreg = totalreg
     End If
    
    Print #1, cLine
    Loop
    Close #1
        
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, TITSISTEMA
   Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call GRABA_LOG_AUDITORIA("Opc_60180", "09", "Interfaz Error", "", "", cNomArchivo & " " & err.Description)
   Exit Sub

End Sub

Function BacConsolidadoCuentas(cFecha As String)
 On Error GoTo ErrorInforme
   
   Call BacLimpiaParamCrw
   
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "BacConsolCuenta.rpt"
   BACSwap.Crystal.Destination = crptToWindow 'crptToPrinter
   BACSwap.Crystal.WindowTitle = TITSISTEMA & "Informe Cuentas Contables"
   BACSwap.Crystal.StoredProcParam(0) = Trim(cFecha)
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.WindowState = crptMaximized
   BACSwap.Crystal.Action = 1

   Exit Function

ErrorInforme:
   

End Function

Public Sub BacInterfazContable(cruta As String, Codigo As Integer)
   On Error GoTo ErrorInterfazSwap
   Dim cLine         As String
   Dim cNomArchivo   As String
   Dim cDia          As String
   Dim archivo       As String
   Dim iContador     As Long
   Dim iCont         As Integer
   
   
   Let Screen.MousePointer = vbHourglass
   
   If Len(cruta) = 0 Then
      Let cruta = "C:\"
   End If
   
   Let cDia = Format(gsBAC_Fecp, "yymmdd")
   Let cNomArchivo = cruta & "GL52" & cDia & IIf(Codigo = 0, ".DIV", ".DAT")
   Let archivo = "GL52" & cDia & IIf(Codigo = 0, ".DIV", ".DAT")

   Envia = Array()
   AddParam Envia, Codigo
   If Not Bac_Sql_Execute("dbo.SP_INTER_CONTABLE", Envia) Then
      GoTo ErrorInterfazSwap
   End If
      
   Let cLine = ""
   Let iContador = 0
   
   If Dir(cNomArchivo) <> "" Then
      Call Kill(cNomArchivo)
   End If

   Open cNomArchivo For Output As #1

   Do While Bac_SQL_Fetch(Datos())

      Let iContador = iContador + 1
      Let cLine = ""

      For iCont = 1 To UBound(Datos)
         Let cLine = cLine & Datos(iCont)
      Next iCont

      Print #1, cLine
   Loop
   
   Close #1
    
   Let Screen.MousePointer = vbDefault
   Call MsgBox("Acción Finalizada." & vbCrLf & vbCrLf & "Interfaz Contable de Swap Generada Correctamente." & vbCrLf & cNomArchivo, vbInformation, TITSISTEMA)
   

'''
'-->  Se modifica el codigo por el de mas arriba por ineficiente.
'''   Do While Bac_SQL_Fetch(DATOS())
'''
'''      Let iContador = iContador + 1
'''
'''      cLine = cLine & DATOS(1)
'''      cLine = cLine & DATOS(2)
'''      cLine = cLine & DATOS(3)
'''      cLine = cLine & DATOS(4)
'''      cLine = cLine & DATOS(5)
'''      cLine = cLine & DATOS(6)
'''      cLine = cLine & DATOS(7)
'''      cLine = cLine & DATOS(8)
'''      cLine = cLine & DATOS(9)
'''      cLine = cLine & DATOS(10)
'''      cLine = cLine & DATOS(11)
'''      cLine = cLine & DATOS(12)
'''      cLine = cLine & DATOS(13)
'''      cLine = cLine & DATOS(14)
'''      cLine = cLine & DATOS(15)
'''      cLine = cLine & DATOS(16)
'''      cLine = cLine & DATOS(17)
'''      cLine = cLine & DATOS(18)
'''      cLine = cLine & DATOS(19)
'''      cLine = cLine & DATOS(20)
'''      cLine = cLine & DATOS(21)
'''      cLine = cLine & DATOS(22)
'''      cLine = cLine & DATOS(23)
'''      cLine = cLine & DATOS(24)
'''      cLine = cLine & DATOS(25)
'''      cLine = cLine & DATOS(26)
'''      cLine = cLine + Chr(13) + Chr(10)
'''   Loop

'''   If Dir(cNomArchivo) <> "" Then
'''      Kill cNomArchivo
'''   End If
'''
'''   Open cNomArchivo For Binary Access Write As #1
'''   Put #1, , cLine
'''   Close #1

'''   Screen.MousePointer = vbDefault
'''   MsgBox "Acción Finalizada." & vbCrLf & vbCrLf & "Interfaz Contable de Swap Generada Correctamente." & vbCrLf & cNomArchivo, vbInformation, TITSISTEMA

Exit Sub
ErrorInterfazSwap:
   Let Screen.MousePointer = vbDefault
   Call MsgBox("Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz")
End Sub


Public Sub BacInterfazxFil(cruta As String)
 Dim cLine As String
 Dim cNomArchivo As String
 Dim cDia As String
 Dim total As Double
 Dim totalreg As Long
 Dim MENU As String
 total = 0
 totalreg = 0
 
 On Error GoTo Herror1
 cDia = Mid(Format(gsBAC_Fecp, "ddmmyyyy"), 1, 4)
cNomArchivo = cruta & "BSWOPE" & cDia & ".FIL"
MENU = "Opc_60120"
  
   If Not Bac_Sql_Execute("SP_INTERFAZ_XFIL") Then
      MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
      Call GRABA_LOG_AUDITORIA(MENU, "01", "Problemas Procedimiento", "", "", "")
      Exit Sub
   End If
    
    cLine = ""
   Do While Bac_SQL_Fetch(Datos())
     cLine = cLine & Datos(1)
     cLine = cLine & IIf(Len(Datos(2)) < 10, "0" & Datos(2), Datos(2))
     cLine = cLine & Format$(Datos(3), "00000000000000000000")
     cLine = cLine & Datos(4)
     cLine = cLine & Space(4)
     cLine = cLine & Datos(6)
     cLine = cLine & Datos(7)
     cLine = cLine & Datos(8)
     cLine = cLine & Datos(9)
     cLine = cLine & Datos(10)
     cLine = cLine & Space(3)
     cLine = cLine & Datos(12)
     cLine = cLine & Format(Datos(13), "ddmmyyyy")
     cLine = cLine & Format(Datos(14), "000000000000000")
     cLine = cLine & Datos(15)
     cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(16))), "00000000.0000"), gsc_PuntoDecim, "") 'BacStrTran(Format$(Val(bacTranMontoSql(Datos(16))), "000000000000.0000"), gsc_PuntoDecim, "")
     cLine = cLine & Left(Datos(17), 2)
     cLine = cLine & Left(Datos(18), 2)
     cLine = cLine & Format$(Datos(19), "000")
     cLine = cLine & Datos(20)
     cLine = cLine & Datos(21)
     cLine = cLine & Space(3)
     cLine = cLine & Datos(23)
     cLine = cLine & Datos(24)
     cLine = cLine & Format(Datos(25), "ddmmyyyy")
     cLine = cLine & Format(Datos(26), "ddmmyyyy")
     cLine = cLine & Format(Datos(27), "000000000000000")
     cLine = cLine & Datos(28)
     cLine = cLine & Datos(29)
     cLine = cLine & Datos(30)
     cLine = cLine & Datos(31)
     cLine = cLine & Datos(32)
     cLine = cLine & Datos(33)
     cLine = cLine & Datos(34)
     cLine = cLine & Datos(35)
     cLine = cLine & Space(3)
     cLine = cLine & Datos(37)
     cLine = cLine & Format(Datos(38), "ddmmyyyy")
     cLine = cLine & Format(Datos(39), "000")
     cLine = cLine & Format(Datos(40), "000")
     cLine = cLine & Datos(41)
     cLine = cLine & Format(Datos(42), "000000000000000")
     cLine = cLine & Datos(43)
     cLine = cLine & Datos(44)
     cLine = cLine & Space(1)
     cLine = cLine & Datos(46)
     cLine = cLine & Space(15)
     
     cLine = cLine + Chr(13) + Chr(10)
     total = total + CDbl(Datos(27))
     totalreg = totalreg + 1
     
  Loop
     
    cLine = cLine & "3" & Space(57) & Format(gsBAC_Fecp, "ddmmyyyy") & Space(15)
    cLine = cLine & Format$(totalreg, "000000000000000") & Space(63)
    cLine = cLine & Format$(total, "000000000000000") & Space(116)
    cLine = cLine + Chr(13) + Chr(10)
   
   If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
   End If
         
   Open cNomArchivo For Binary Access Write As #1
   Put #1, , cLine
   Close #1
   
   If Not Enviar_por_ftp(cruta, cNomArchivo) Then
         MsgBox "interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
    End If
   
   MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, "MENSAJE"
   Exit Sub
   
Herror1:
   MsgBox "Error: " & cNomArchivo & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call GRABA_LOG_AUDITORIA(MENU, "01", "Interfaz Error", "", "", cNomArchivo & " " & err.Description)
   Exit Sub
   
End Sub

Public Sub InterfazVencimientos_xFlu(cruta As String)
Dim cLine As String
Dim cNomArchivo As String
Dim cDia As String
Dim total As Variant
Dim totalreg As Long

On Error GoTo Herror1
   total = 0
   totalreg = 0
   cDia = Mid(Format(gsBAC_Fecp, "ddmmyyyy"), 1, 4)
   cNomArchivo = cruta & "BSWVCT" & cDia & ".FLU"

   If Not Bac_Sql_Execute("SP_INTER_VENCIMIENTOS_XFLU") Then
         MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
         Call GRABA_LOG_AUDITORIA("Opc_60130", "09", "Problemas Procedimiento", "", "", "")
         Exit Sub
   End If
  
   cLine = ""
   Do While Bac_SQL_Fetch(Datos())
         cLine = cLine & Datos(1)
         cLine = cLine & IIf(Len(Datos(2)) < 10, "0" & Datos(2), Datos(2))
         cLine = cLine & Format(Datos(3), "00000000000000000000")
         cLine = cLine & Datos(4)
         cLine = cLine & Datos(5)
         cLine = cLine & Format(Datos(6), "000")
         cLine = cLine & Datos(7)
         cLine = cLine & Datos(8)
         cLine = cLine & Format(Datos(9), "000")
         cLine = cLine & Format(Datos(10), "ddmmyyyy")
         cLine = cLine & Format(Datos(11), "000000000000000")
         cLine = cLine & Format(Datos(12), "000000000000000")
         cLine = cLine & Datos(13)
         cLine = cLine & Format(Datos(14), "000000000000000")
         cLine = cLine & Format(Datos(15), "000000000000000")
         cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(16))), "000.0000"), gsc_PuntoDecim, "")
         cLine = cLine & Space(8)
         cLine = cLine + Chr(13) + Chr(10)
         total = total + Datos(11)
         totalreg = totalreg + 1
   Loop
   
    cLine = cLine & "3" & "   TRAILER" & Space(37) & Format(gsBAC_Fecp, "ddmmyyyy")
    cLine = cLine & Space(45) & Format(totalreg, "000000000000000") & Format(total, "000000000000000")
    cLine = cLine & Space(15)
    cLine = cLine + Chr(13) + Chr(10)
    
     If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
   End If
    
    Open cNomArchivo For Binary Access Write As #1
    Put #1, , cLine
    Close #1
    
    If Not Enviar_por_ftp(cruta, cNomArchivo) Then
         MsgBox "interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
    End If
        
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, "MENSAJE"
   Exit Sub
   
Herror1:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call GRABA_LOG_AUDITORIA("Opc_60130", "09", "Interfaz Error", "", "", cNomArchivo & " " & err.Description)
   Exit Sub
   
End Sub
 

Public Function InterfazCapIXAnexo3(Mes, Year, cruta As String) 'cruta As String)
'PRD-12713
   
   Dim cNomArchivo As String
   Dim SQL         As String
   Dim Datos()
   Dim bInicio     As Boolean
   Dim cString     As String
   Dim cAcu        As String
   Dim nMtoEnt     As Double
   Dim nMtoRec     As Double
   Dim nCanOpe     As Integer
   Dim cNombre     As String
   Dim bInicio2    As Boolean
   Dim cFecha      As String
   
   
   nMtoEnt = 0
   nMtoRec = 0
   nCanOpe = 0
   
    cFecha = Format(gsBAC_Fecp, "yyyymmdd")
   
  '' cNombre = Format(Val(Mid(cFecha, 7, 2)), "00") & Format(Val(Mid(cFecha, 5, 2)), "00")

   cNombre = Format(Mes, "00") & Format(Val(Mid(Year, 3, 2)), "00")
   
   bInicio = True
   cAcu = ""
   cString = ""
   
   On Error GoTo Herror
   
   SQL = ""
   
   Call gsc_Parametros.DatosGenerales
      
   'Llamando procedimiento almacenado
   
   If Not Bac_Sql_Execute("SP_INTERFAZCAP9ANEXO3", Array(Mes, Year)) Then  '', 8346589
      MsgBox "Problemas al Generar Información para Interfaz", vbCritical, "MENSAJE"
      Call GRABA_LOG_AUDITORIA("Opc_40113", "09", "Problemas Procedimientos", "", "", "")
      Exit Function

   End If

   cNomArchivo = cruta & "STASAS" & cNombre & ".txt"

   Do While Bac_SQL_Fetch(Datos())

    If Trim(Datos(1)) = "Vacio" Then
       cAcu = "IIIIIIIIII" + Format$(Val(Datos(2)), "000000000")
       cAcu = cAcu + Datos(3)
       cAcu = cAcu + "0000" + "000000000000000000000" + "000000000000000000000" + BacPad("SWAP-CONTRATO SWAP", 30) + Datos(4) + Format$(Val(Datos(5)), "000") + Space(44) + Chr(13) + Chr(10)

    Else
      If bInicio Then
         cAcu = "IIIIIIIIII"
         cAcu = cAcu + Format$(Val(Datos(3)), "000000000") + Datos(4)                        'Rut y Digito Reportante
         cAcu = cAcu + Format$(Val(Datos(1)), "0000")                                        'Cantidad de operaciones
         cAcu = cAcu + Datos(5)                                                              'Fecha
         cAcu = cAcu + Space(119) + Chr(13) + Chr(10)                                        'Espacio libre para completar 151 caracteres
         
      End If

         bInicio = False
         
         If Datos(28) = "O" Then
            cAcu = cAcu + "OOOOOOOOOO"                                                                 'Flag de Control Operación
            cAcu = cAcu + Format$(Val(Datos(6)), "000000000") + Datos(7)                        'Rut y Dig Contraparte
            cAcu = cAcu + BacPad(Trim(Datos(8)), 5)                                             'Instrumento
            cAcu = cAcu + Format$(Val(bacTranMontoSql(Datos(9))), "000000000000")               'Numero de Contrato
            cAcu = cAcu + Datos(11)                                                             'Tasa Interes Pagada
            cAcu = cAcu + Datos(12)                                                             'Tasa Interes Recibida
            cAcu = cAcu + Datos(13)                                                             'Fecha Suscripción
            cAcu = cAcu + Datos(14)                                                             'Fecha Efectiva
            cAcu = cAcu + Datos(15)                                                             'Fecha Término
            cAcu = cAcu + Format$(Val(Datos(16)), "0000")                                       'Codigo Moneda
            cAcu = cAcu + Format$(Val(Datos(2)), "0000")                                        'Cantidad de Reg Compensaciones
            cAcu = cAcu + BacPad(Trim(Datos(17)), 160) ''+ Space(44) + Chr(13) + Chr(10)          'Oservaciones
            
         Else
            cAcu = cAcu + "CCCCCCCCCC"                                                                 'Flag de Control Compensaciones
            cAcu = cAcu + Datos(18)                                                             'Fecha Desde
            cAcu = cAcu + Datos(19)                                                             'Fecha Hasta
            cAcu = cAcu + BacStrTran(Format$(Val(bacTranMontoSql(Datos(20))), "00000000000000000.00"), gsc_PuntoDecim, "")   'Saldo
            cAcu = cAcu + BacStrTran(Format$(Val(bacTranMontoSql(Datos(21))), "00.0000"), gsc_PuntoDecim, "")                'Tasa Fija 1
            cAcu = cAcu + BacStrTran(Format$(Val(bacTranMontoSql(Datos(22))), "00.0000"), gsc_PuntoDecim, "")                'Tasa Fija 2
            cAcu = cAcu + Format$(Val(bacTranMontoSql(Datos(23))), "000")                                                    'Base Tasa Fija
            cAcu = cAcu + Format$(Val(bacTranMontoSql(Datos(24))), "000000")                                                 'Codigo Tasa Interes Variable
            cAcu = cAcu + BacStrTran(Format$(Val(bacTranMontoSql(Datos(25))), "00.0000"), gsc_PuntoDecim, "")                'Dpread
            cAcu = cAcu + Format$(Val(bacTranMontoSql(Datos(26))), "000")                                                    'Base Tasa Variable
            cAcu = cAcu + BacStrTran(Format$(Val(bacTranMontoSql(Datos(27))), "00000000.00"), gsc_PuntoDecim, "")                'Dpread

            
         End If
            
         cAcu = cAcu + Chr(13) + Chr(10)

      End If
   Loop

   cAcu = cAcu + "FFFFFFFFFF" + Space(141)

   If Dir(cNomArchivo) <> "" Then
      Kill cNomArchivo
   End If

   Open cNomArchivo For Binary Access Write As #1

   Put #1, , cAcu

   Close #1



   MsgBox "Interfaz Cap. IX Anexo 3 Generada", vbOKOnly + vbInformation, "MENSAJE"
   Call GRABA_LOG_AUDITORIA("Opc_40112", "01", "Interfaz Capítulo IX Anexo 3 Generada", "", "", cNomArchivo)

Exit Function

Herror:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call GRABA_LOG_AUDITORIA("Opc_40112", "01", "Interfaz Capítulo IX Anexo 3 Error", "", "", cNomArchivo & " " & err.Description)
   Exit Function

'PRD-12713
End Function


Public Function InterfazCapIXAnexo3Cartera_Vigente(Fecha As String, cruta As String)  'cruta As String)
'PRD-12713
   
   Dim cNomArchivo As String
   Dim SQL         As String
   Dim Datos()
   Dim bInicio     As Boolean
   Dim cString     As String
   Dim cAcu        As String
   Dim nMtoEnt     As Double
   Dim nMtoRec     As Double
   Dim nCanOpe     As Integer
   Dim cNombre     As String
   Dim bInicio2    As Boolean
   Dim cFecha      As String
   
   
   nMtoEnt = 0
   nMtoRec = 0
   nCanOpe = 0
   
    cFecha = Format(Fecha, "yyyymmdd")
   
    cNombre = Format(Val(Mid(cFecha, 7, 2)), "00") & Format(Val(Mid(cFecha, 5, 2)), "00")

'''   cNombre = Format(Mes, "00") & Format(Val(Mid(Year, 3, 2)), "00")
   
   bInicio = True
   cAcu = ""
   cString = ""
   
   On Error GoTo Herror
   
   SQL = ""
   
   Call gsc_Parametros.DatosGenerales
      
   'Llamando procedimiento almacenado
   
   If Not Bac_Sql_Execute("SP_INTERFAZCAP9ANEXO3CART_VIGENTE", Array(cFecha)) Then  '', 8346589
      MsgBox "Problemas al Generar Información para Interfaz", vbCritical, "MENSAJE"
      Call GRABA_LOG_AUDITORIA("Opc_40113", "09", "Problemas Procedimientos", "", "", "")
      Exit Function

   End If

   cNomArchivo = cruta & "STASAS_CART_VIG" & cNombre & ".txt"

   Do While Bac_SQL_Fetch(Datos())

    If Trim(Datos(1)) = "Vacio" Then
       cAcu = "IIIIIIIIII" + Format$(Val(Datos(2)), "000000000")
       cAcu = cAcu + Datos(3)
       cAcu = cAcu + "0000" + "000000000000000000000" + "000000000000000000000" + BacPad("SWAP-CONTRATO SWAP", 30) + Datos(4) + Format$(Val(Datos(5)), "000") + Space(44) + Chr(13) + Chr(10)

    Else
      If bInicio Then
         cAcu = "IIIIIIIIII"
         cAcu = cAcu + Format$(Val(Datos(3)), "000000000") + Datos(4)                        'Rut y Digito Reportante
         cAcu = cAcu + Format$(Val(Datos(1)), "0000")                                        'Cantidad de operaciones
         cAcu = cAcu + Datos(5)                                                              'Fecha
         cAcu = cAcu + Space(119) + Chr(13) + Chr(10)                                        'Espacio libre para completar 151 caracteres
         
      End If

         bInicio = False
         
         If Datos(28) = "O" Then
            cAcu = cAcu + "OOOOOOOOOO"                                                                 'Flag de Control Operación
            cAcu = cAcu + Format$(Val(Datos(6)), "000000000") + Datos(7)                        'Rut y Dig Contraparte
            cAcu = cAcu + BacPad(Trim(Datos(8)), 5)                                             'Instrumento
            cAcu = cAcu + Format$(Val(bacTranMontoSql(Datos(9))), "000000000000")               'Numero de Contrato
            cAcu = cAcu + Datos(11)                                                             'Tasa Interes Pagada
            cAcu = cAcu + Datos(12)                                                             'Tasa Interes Recibida
            cAcu = cAcu + Datos(13)                                                             'Fecha Suscripción
            cAcu = cAcu + Datos(14)                                                             'Fecha Efectiva
            cAcu = cAcu + Datos(15)                                                             'Fecha Término
            cAcu = cAcu + Format$(Val(Datos(16)), "0000")                                       'Codigo Moneda
            cAcu = cAcu + Format$(Val(Datos(2)), "0000")                                        'Cantidad de Reg Compensaciones
            cAcu = cAcu + BacPad(Trim(Datos(17)), 160) ''+ Space(44) + Chr(13) + Chr(10)          'Oservaciones
            
         Else
            cAcu = cAcu + "CCCCCCCCCC"                                                                 'Flag de Control Compensaciones
            cAcu = cAcu + Datos(18)                                                             'Fecha Desde
            cAcu = cAcu + Datos(19)                                                             'Fecha Hasta
            cAcu = cAcu + BacStrTran(Format$(Val(bacTranMontoSql(Datos(20))), "00000000000000000.00"), gsc_PuntoDecim, "")   'Saldo
            cAcu = cAcu + BacStrTran(Format$(Val(bacTranMontoSql(Datos(21))), "00.0000"), gsc_PuntoDecim, "")                'Tasa Fija 1
            cAcu = cAcu + BacStrTran(Format$(Val(bacTranMontoSql(Datos(22))), "00.0000"), gsc_PuntoDecim, "")                'Tasa Fija 2
            cAcu = cAcu + Format$(Val(bacTranMontoSql(Datos(23))), "000")                                                    'Base Tasa Fija
            cAcu = cAcu + Format$(Val(bacTranMontoSql(Datos(24))), "000000")                                                 'Codigo Tasa Interes Variable
            cAcu = cAcu + BacStrTran(Format$(Val(bacTranMontoSql(Datos(25))), "00.0000"), gsc_PuntoDecim, "")                'Dpread
            cAcu = cAcu + Format$(Val(bacTranMontoSql(Datos(26))), "000")                                                    'Base Tasa Variable
            cAcu = cAcu + BacStrTran(Format$(Val(bacTranMontoSql(Datos(27))), "00000000.00"), gsc_PuntoDecim, "")                'Dpread

            
         End If
            
         cAcu = cAcu + Chr(13) + Chr(10)

      End If
   Loop

   cAcu = cAcu + "FFFFFFFFFF" + Space(141)

   If Dir(cNomArchivo) <> "" Then
      Kill cNomArchivo
   End If

   Open cNomArchivo For Binary Access Write As #1

   Put #1, , cAcu

   Close #1



   MsgBox "Interfaz Cap. IX Anexo 3 Cartera Vigente Generada", vbOKOnly + vbInformation, "MENSAJE"
   Call GRABA_LOG_AUDITORIA("Opc_40113", "01", "Interfaz Capítulo IX Anexo 3 Cartera Vigente Generada", "", "", cNomArchivo)

Exit Function

Herror:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call GRABA_LOG_AUDITORIA("Opc_40113", "01", "Interfaz Capítulo IX Anexo 3 Cartera Vigente Error", "", "", cNomArchivo & " " & err.Description)
   Exit Function

'PRD-12713
End Function


