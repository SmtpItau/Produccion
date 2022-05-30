Attribute VB_Name = "Modulo_Interfaces"
Dim Datos()
Dim FechaAnt As String
Dim dirC18 As String
Dim UnidadC18 As String
Dim cruta            As String

Public Function GeneracionInterfazC18(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByVal oFechaGeneracion As Date) As Boolean
 'On Error GoTo ErrorEscritura
    
   Dim Datos()
   Dim cLine$
   Dim Filler$
   Dim oDatos
   Dim nNumeroArchivo
   Dim cNomArchivo      As String
   
   Dim cFechaInterfaz   As String
   Dim bPrimerReg       As Boolean
   Dim iRegistros       As Long
   Dim iRegistro        As Long

   On Error GoTo Error
    
   Let Screen.MousePointer = vbHourglass
   Let cFechaInterfaz = Format(oFechaGeneracion, FEFecha)
   Let cruta = cPathFile

   Let cNomArchivo = ""
   Let cNomArchivo = cruta & "\" & "C18" + Mid(cFechaInterfaz, 7, 2) + Mid(cFechaInterfaz, 5, 2) + Mid(cFechaInterfaz, 1, 4) + ".CSV"

   If Dir(cNomArchivo) <> "" Then
      Call Kill(cNomArchivo)
   End If

   Envia = Array()
   AddParam Envia, cFechaInterfaz 'fechaAnt
   If Not Bac_Sql_Execute("BacTraderSuda..SP_INTERFAZ_C18", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Interfaz C-18" & vbCrLf & "Ha ocurrido un error al intentar generar la interfaz C18", vbCritical, App.Title)
      Exit Function
   End If

   Let nNumeroArchivo = FreeFile
   Let bPrimerReg = True

   Open cNomArchivo For Append As #nNumeroArchivo

   Let iRegistro = 0

   Do While Bac_SQL_Fetch(Datos())

      Let iRegistro = iRegistro + 1

      If bPrimerReg = True Then
         Let bPrimerReg = False
         Let iRegistros = CDbl(Datos(15))

         Let cLine = Datos(1) + ";"                                        '01 - CODIGO DE LA IF
         Let cLine = cLine & Datos(2) + ";"                                '02 - IDENTIFICACION DEL ARCHIVO
         Let cLine = cLine & Datos(3) + ";"                                '03 - PERIODO AAAAMM
         Let cLine = cLine & Datos(4)                                      '04 - FILLER
      Else
         Let cLine = Datos(1) + ";"                                        '01 - DIA
         Let cLine = cLine & Datos(2) + ";"                                '02 - ACTIVO CIRCULANTE
         Let cLine = cLine & Datos(3) + ";"                                '03 - CODIGO DEL BANCO ACREEDOR
         Let cLine = cLine & Datos(4) + ";"                                '04 - PLAZO RESIDUAL DE VENCIMIENTO
         Let cLine = cLine & Datos(5) + ";"                                '05 - MONEDA DE PAGO
         Let cLine = cLine & Datos(6) + ";"                                '06 - CUENTAS CORRIENTES
         Let cLine = cLine & Datos(7) + ";"                                '07 - OTRAS OBLIGACIONES A LA VISTA
         Let cLine = cLine & Space(14 - Len(Datos(8))) & Datos(8) + ";"    '08 - OPERACIONES CON LIQUIDACION EN CURSO
         Let cLine = cLine & Datos(9) + ";"                                '09 - CONTRATOS DE RETROCOMPRA Y PRESTAMOS DE VALORES
         Let cLine = cLine & Datos(10) + ";"                               '10 - DEPOSITOS Y OTRAS CAPTACIONES A PLAZO
         Let cLine = cLine + Datos(11) + ";"                               '11 - CONTRATOS DE DERIVADOS FINANCIEROS
         Let cLine = cLine + Datos(12) + ";"                               '12 - OBLIGACIONES CON BANCOS
         Let cLine = cLine + Datos(13) + ";"                               '13 - MONTO CUBIERTO CON GARANTIAS VALIDAS PARA LIMITES
         Let cLine = cLine + Datos(14)                                     '14 - FILLER
      End If

      Print #nNumeroArchivo, cLine

   Loop

   Close #nNumeroArchivo

   Let Screen.MousePointer = vbDefault

   If oMover = True Then
      Let ProgressPanel.FloodPercent = vbDefault
   End If

Exit Function
Error:
    Let Screen.MousePointer = vbDefault
   Call MsgBox("E - Err. en Interfaz C-18" & vbCrLf & vbCrLf & "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "ERROR EN GENERACION C18. ")
End Function

Public Function InterfazDerivadosSWP(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByRef bTieneDatos As Boolean) As Boolean
  On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let InterfazDerivadosSWP = False
    Let bTieneDatos = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    Let total = 0:  Let totalreg = 0:
    Let Screen.MousePointer = vbHourglass
    Let nProgress.ForeColor = vbBlack
    
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_DERIVADOS_SWAP") Then
        Let Screen.MousePointer = vbDefault
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Let nRegTotal = nRegTotal + 1
    Loop
    
    '--> Solo para obtener numero de filas
   
    If Not Bac_Sql_Execute("SP_INTERFAZ_DERIVADOS_SWAP") Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    
    Open cNomArchivo For Output As #1
      
     Do While Bac_SQL_Fetch(Datos())
        Let bTieneDatos = True
       
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
        
        nProgress.FloodPercent = (totalreg * 100) / nRegTotal
        If nProgress.FloodPercent >= 49 Then
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbWhite
        Else
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
        End If
        
     Loop
   
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & "99" & Format(gsBAC_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(234)
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let InterfazDerivadosSWP = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    
    If err.Number = 55 Then
        Close #1
    End If
   
    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    Exit Function
 
End Function

Public Function InterfazOperacionesSWP(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByRef bTieneDatos As Boolean) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let InterfazOperacionesSWP = False
    Let bTieneDatos = False

    
    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If

    Let total = 0:  Let totalreg = 0:

    Let Screen.MousePointer = vbHourglass
    Let nProgress.ForeColor = vbBlack
    
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
    
'    If Not Bac_Sql_Execute("SP_INTERFAZ_OPERACIONES_SWAP") Then
'        Let Screen.MousePointer = vbDefault
'        Exit Function
'    End If
'
'    Do While Bac_SQL_Fetch(Datos())
'        Let nRegTotal = nRegTotal + 1
'    Loop
    
    '--> Solo para obtener numero de filas
    
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_OPERACIONES_SWAP") Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
        
    Open cNomArchivo For Output As #1
    Do While Bac_SQL_Fetch(Datos())
        Let bTieneDatos = True
        
        Let nRegTotal = Datos(94)
        
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


        'A solicitud de Carlos Basterrica se agregan los nuevos campos para la intrfaz
        'Eduardo Castillo 19-01-2016
        cLine = cLine & Ceros("0", 9)   '--> Fecha del primer vencimiento
        cLine = cLine & Space(1)        '--> Tipo de otorgamiento
        cLine = cLine & Ceros("0", 20)  '--> Precio de la vivienda
        cLine = cLine & Space(1)        '--> Tipo de operación renegociada
        cLine = cLine & Ceros("0", 20)  '--> Monto del pie pagado
        cLine = cLine & Space(1)        '--> Seguro de Remate
        cLine = cLine & Ceros("0", 9)   '--> Dias de morosidad con que se efectuo la renegociación”.


        totalreg = totalreg + 1
        'total = total + 1
        If Len(cLine) <> 786 Then
           totalreg = totalreg
        End If
        
        Print #1, cLine
        
        nProgress.FloodPercent = (totalreg * 100) / nRegTotal
        If nProgress.FloodPercent >= 49 Then
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbWhite
        Else
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
        End If
        
    Loop
   

    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & ("99" & Format(gsBAC_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786))
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let InterfazOperacionesSWP = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    Exit Function
End Function

Public Function InterfazBalanceSWP(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByRef bTieneDatos As Boolean) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let InterfazBalanceSWP = False
    Let bTieneDatos = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    
    Let total = 0:  Let totalreg = 0:
    Let Screen.MousePointer = vbHourglass
    Let nProgress.ForeColor = vbBlack
    
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_BALANCE_SWAP") Then
        Let Screen.MousePointer = vbDefault
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Let nRegTotal = nRegTotal + 1
    Loop
    
    '--> Solo para obtener numero de filas
   
    If Not Bac_Sql_Execute("SP_INTERFAZ_BALANCE_SWAP") Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    
    Open cNomArchivo For Output As #1
    Do While Bac_SQL_Fetch(Datos())
        Let bTieneDatos = True
     
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
        
        nProgress.FloodPercent = (totalreg * 100) / nRegTotal
        If nProgress.FloodPercent >= 49 Then
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbWhite
        Else
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
        End If
    Loop
   
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & "99" & Format(gsBAC_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(158)
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let InterfazBalanceSWP = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
   
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Exit Function

End Function

Public Function InterfazFlujosSWP(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let Interfazflujosmutuos = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    
    Let total = 0:  Let totalreg = 0:
    Let Screen.MousePointer = vbHourglass
     Let nProgress.ForeColor = vbBlack
    
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_FLUJOS_SWAP") Then
        Let Screen.MousePointer = vbDefault
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Let nRegTotal = nRegTotal + 1
    Loop
    
    '--> Solo para obtener numero de filas
   
    If Not Bac_Sql_Execute("SP_INTERFAZ_FLUJOS_SWAP") Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    
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
        
        nProgress.FloodPercent = (totalreg * 100) / nRegTotal
        If nProgress.FloodPercent >= 49 Then
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbWhite
        Else
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
        End If
        
    Loop
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & "99" & Format(gsBAC_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(120)
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    Exit Function

End Function

Public Function InterfazDireccionesSWP(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let InterfazDireccionesSWP = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    
    Let total = 0:  Let totalreg = 0:
    Let Screen.MousePointer = vbHourglass
    
    Let nProgress.ForeColor = vbBlack
    
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_DIRECCIONES_SWAP") Then
        Let Screen.MousePointer = vbDefault
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Let nRegTotal = nRegTotal + 1
    Loop
    
    '--> Solo para obtener numero de filas
   
    If Not Bac_Sql_Execute("SP_INTERFAZ_DIRECCIONES_SWAP") Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    
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
        
        nProgress.FloodPercent = (totalreg * 100) / nRegTotal
        If nProgress.FloodPercent >= 49 Then
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbWhite
        Else
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
        End If
        
    Loop
   
    
    
    cLine = ""
    totalreg = totalreg + 1
    
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    Exit Function

End Function

Public Function InterfazPosicionSWP(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim EXPUC8         As String
    Dim nRegTotal      As Long
    
    Let InterfazPosicionSWP = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    
    Let total = 0:  Let totalreg = 0:
    Let Screen.MousePointer = vbHourglass
    Let nProgress.ForeColor = vbBlack
    
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_POSICION_CLIENTE_SWP") Then
        Let Screen.MousePointer = vbDefault
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Let nRegTotal = nRegTotal + 1
    Loop
    
    '--> Solo para obtener numero de filas
   
    If Not Bac_Sql_Execute("SP_INTERFAZ_POSICION_CLIENTE_SWP") Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    
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
        nProgress.FloodPercent = (totalreg * 100) / nRegTotal
        If nProgress.FloodPercent >= 49 Then
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbWhite
        Else
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
        End If
    Loop
    
    cLine = ""
    totalreg = totalreg + 1
    
'-> Print #1, cLine '--> Esta generando linea en Blanco al Final del Archivo
    Close #1
    Screen.MousePointer = vbDefault

    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    Exit Function

End Function



Public Function InterfazDeudores_resp(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String

    Let InterfazDeudores_resp = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If

    Let total = 0:  Let totalreg = 0:

    Let Screen.MousePointer = vbHourglass
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_DEUDORES_TRADER") Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    
    Open cNomArchivo For Output As #1
    Do While Bac_SQL_Fetch(Datos())
        
     If FRM_PROC_FDIA.Prg.Max >= 10 Then FRM_PROC_FDIA.Prg.Max = Datos(1)
      
     Rut = BacValidaRut((Datos(4)), 0)
     dig = devolver
      
     rut1 = BacValidaRut((Datos(2)), 0)
     dig1 = devolver
      
     cLine = ""
     cLine = cLine & IIf(Datos(2) = "0", Space(15), ESPACIOS_CL(Trim(Str(Datos(2))) + dig1, 15, "D")) & ESPACIOS_CL((Datos(3)), 16, "D") & IIf(Datos(4) = "0", Space(15), ESPACIOS_CL(Trim(Str(Datos(4))) + dig, 15, "D"))
     cLine = cLine & Datos(5) & Datos(6) & Format(saca_punto(Trim(Str(Datos(7))), 2), "00000") & Datos(8)
              
     If Len(cLine) <> 56 Then
            p = p
     End If
     
    totalreg = totalreg + 1
    p = p + 1
    Print #1, cLine
    FRM_PROC_FDIA.Pnl_Progreso.FloodPercent = ((totalreg * 100) / Datos(1))
    FRM_PROC_FDIA.Prg.Max = p
    FRM_PROC_FDIA.Prg.Value = p
    Loop
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & ("99" & Format(gsBAC_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786))
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
   
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Exit Function
End Function


 Public Function SIGUIR(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
   
    Let SIGUIR = False
    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    Let total = 0:  Let totalreg = 0:
    Let Screen.MousePointer = vbHourglass
    Envia = Array()
    AddParam Envia, gsBAC_Fecp
    If Not Bac_Sql_Execute("SP_INTERFAZ_P40_BANCO", Envia) Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    
    Open cNomArchivo For Output As #1
     
   Do While Bac_SQL_Fetch(Datos())
      nTotalRegistros = Datos(37)
      
      Linea = ""
      Linea = Linea & ESPACIOS_CL(Trim(Datos(1)), 3, "D")                                 '--> Codigo ISO del Pais
      Linea = Linea & ESPACIOS_CL(Trim(Datos(2)), 8, "D")                                 '--> Fecha de la Interfaz
      Linea = Linea & ESPACIOS_CL(Trim(Datos(3)), 14, "D")                                '--> N° de Identificador de la Fuente
      Linea = Linea & ESPACIOS_CL(Trim(Datos(4)), 3, "D")                                 '--> Codigo de la Empresa
      Linea = Linea & ESPACIOS_CL(Trim(Datos(5)), 16, "D")                                '--> Codigo Interno del Producto
      Linea = Linea & ESPACIOS_CL(Trim(Datos(6)), 8, "D")                                 '--> Fecha Contable
      Linea = Linea & ESPACIOS_CL(Trim(Datos(36)), 20, "D")                               '--> Numero de la Operacion
      Linea = Linea & ESPACIOS_CL(Trim(Datos(10)), 12, "D")                               '--> Identificador del Tenedor
      Linea = Linea & ESPACIOS_CL(Trim(Val(Datos(11))), 1, "D")                           '--> Tipo de Registro
      Linea = Linea & ESPACIOS_CL(Trim(Datos(12)), 2, "D")                                '--> Familia de Instrumento
      Linea = Linea & ESPACIOS_CL(Trim(Datos(13)), 1, "D")                                '--> Tipo
      Linea = Linea & ESPACIOS_CL(Trim(Datos(14)), 8, "D")                                '--> Fecha Proximo Corte de Cupon
      Linea = Linea & ESPACIOS_CL(Trim(Datos(15)), 2, "D")                                '--> Derivados Incrustados
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(16))), 4), "000000000000000000")   '--> Nominal Actual
      Linea = Linea & ESPACIOS_CL(Trim(Datos(17)), 4, "D")                                '--> Moneda Reajustable
      Linea = Linea & ESPACIOS_CL(Trim(Datos(18)), 7, "D")                                '--> Tipo Tasa Emision
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(19))), 8), "0000000000000000")     '--> Tera
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(20))), 4), "000000000000000000")   '--> Valor Par
      Linea = Linea & ESPACIOS_CL(Trim(Datos(21)), 7, "D")                                '--> Tipo de Tasa Compra
      Linea = Linea & Trim(Datos(38))                                                     '--> Signo de Tasa de Compra
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(22))), 8), "000000000000000")      '--> Tasa de Compra       ( Cambia Lago de 16 a 15 )
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(23))), 4), "000000000000000000")   '--> Costo de Adquisicion
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(24))), 4), "000000000000000000")   '--> Costo Amortizado
      Linea = Linea & ESPACIOS_CL(Trim(Datos(25)), 7, "D")                                '--> Tipo de tasa de valorizacion
      Linea = Linea & Trim(Datos(39))                                                     '--> Signo de Tasa de Valorizacion
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(26))), 8), "000000000000000")      '--> Tasa de Valorizacion ( Cambia Lago de 16 a 15 )
      Linea = Linea & ESPACIOS_CL(Trim(Datos(27)), 1, "D")                                '--> Tipo de Valorizacion
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(28))), 8), "0000000000000000")     '--> Precio del Instrumento
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(29))), 8), "0000000000000000")     '--> Duracion Modificada
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(30))), 8), "0000000000000000")     '--> Convexidad
      Linea = Linea & Format(saca_punto(Trim(Str(Datos(31))), 2), "000000000000000000")   '--> Valor del Deterioro
      Linea = Linea & ESPACIOS_CL(Trim(Datos(32)), 1, "D")                                '--> Condicion del Instrumento
      Linea = Linea & ESPACIOS_CL(Trim(Datos(33)), 8, "D")                                '--> Fecha Inicio Condicion
      Linea = Linea & ESPACIOS_CL(Trim(Datos(34)), 8, "D")                                '--> Fecha Termino Condicion
      Linea = Linea & ESPACIOS_CL(Trim(Datos(35)), 20, "D")
      
      Print #1, Linea
      
    '  Pnl_Progreso.FloodPercent = (p / nTotalRegistros) * 100 '--> ActualizarBarra(CDbl(p), CDbl(nTotalRegistros))
      
      p = p + 1
    
   Loop
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & ("99" & Format(gsBAC_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786))
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
   
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Exit Function

End Function

Public Function Clientes(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Let Clientes = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    Let total = 0:  Let totalreg = 0:
    Let Screen.MousePointer = vbHourglass
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_CLIENTE") Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    
    Open cNomArchivo For Output As #1
     Do While Bac_SQL_Fetch(Datos)

 
          
    If Len(Datos(14)) > 1 Then
        nrocal = Mid$(Datos(14), 1, 1)
        nrocalidad = Format(Val(nrocal), "0")
    Else
       nrocalidad = Format(Val(Datos(14)), "0")
    End If
        
    If Len(Datos(11)) > 11 Then
        nrotel = Mid$(Datos(11), 1, 7)
        NumeroTel = Format(Val(nrotel), "00000000000")
    Else
       NumeroTel = Format(Val(Datos(11)), "00000000000")
    End If
    
    If Len(Datos(15)) > 11 Then
        NroFax = Mid$(Datos(15), 1, 7)
        NumeroFax = Format(Val(NroFax), "00000000000")
    Else
       NumeroFax = Format(Val(Datos(15)), "00000000000")
    End If
    
    cLine = ""
    
    cLine = cLine & ESPACIOS(Trim(Datos(1)) + Datos(2), 15) & Datos(3) & ESPACIOS(Trim(Datos(4)), 10) & ESPACIOS(Trim(Datos(5)), 40)
    cLine = cLine & ESPACIOS(Trim(Datos(6)), 20) & ESPACIOS(Trim(Datos(7)), 20) & ESPACIOS(Trim(Datos(8)), 40)
    cLine = cLine & ESPACIOS(Trim(Datos(9)), 4) & ESPACIOS(Trim(Datos(10)), 4) & NumeroTel
    cLine = cLine & Space(40) & Space(4) & Space(4) & "00000000000" & Space(1) & Space(8) & Space(1) & "00000000000"
    cLine = cLine & "0000" & "0000" & Space(8) & "00" & Space(1) & Space(15) & Space(40) & Space(20)
    cLine = cLine & Space(20) & Format(Datos(12), "ddmmyyyy") & Datos(20) & Format(Val(Datos(13)), "0") & nrocalidad & NumeroFax
    cLine = cLine & Space(4) & ESPACIOS(Trim(Datos(16)), 4) & ESPACIOS(Trim(Datos(17)), 4) & Space(4)
    cLine = cLine & Space(1) & ESPACIOS(Trim(Datos(18)), 4) & Space(30) & Space(4) & "00000000" & "00000000" & "00000000000000" & Space(1)
    cLine = cLine & Space(40) & Space(1)
    
    p = p + 1
  
    Print #1, cLine
Loop

    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & ("99" & Format(gsBAC_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786))
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
   
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Exit Function

End Function


Public Function InterfazArt84(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String

    Let InterfazArt84 = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If

    Let total = 0:  Let totalreg = 0:

    Let Screen.MousePointer = vbHourglass
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_ARTICULO84") Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    
    Open cNomArchivo For Output As #1
     
     Do While Bac_SQL_Fetch(Datos())
                 
     cLine = ""
     cLine = cLine & ESPACIOS_CL((Datos(1)), 15, "D")
     cLine = cLine & ESPACIOS_CL((Datos(2)), 10, "D")
     cLine = cLine & ESPACIOS_CL((Datos(3)), 10, "D")
     cLine = cLine & Datos(4)
     cLine = cLine & Datos(5)
     
     If Len(cLine) <> 786 Then
            p = p
     End If
     
    
    p = p + 1
    Print #1, cLine
    Loop
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & ("99" & Format(gsBAC_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786))
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
   
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Exit Function

End Function

Function ESPACIOS_CL(Dato As String, Largo As Integer, Alineacion As String)
If Alineacion = "I" Then
    ESPACIOS_CL = 0
    If Len(Dato) <= Largo Then
        ESPACIOS_CL = Space((Largo - Len(Dato))) & Dato
    End If
Else
    ESPACIOS_CL = 0
    If Len(Dato) <= Largo Then
        ESPACIOS_CL = Dato & Space((Largo - Len(Dato)))
    End If
End If
End Function
Private Function saca_punto(cValor As String, nDecim As Integer) As String
Dim X As Integer
Dim x1 As Integer
Dim xvar As String
Dim yvar As String
Dim Y As Integer
If Mid(cValor, 1, 1) = "-" Then
    cValor = Mid(cValor, 2, Len(cValor))
End If
For X = 1 To Len(cValor) 'nDecim
    If Mid(cValor, X, 1) = "." Then
      xvar = xvar & "" 'Mid(cValor, x, 1)
      x1 = Len(Mid(cValor, X + 1, Len(cValor)))
     Y = Y - 1
    ElseIf Mid(cValor, X, 1) = " " Then
     xvar = xvar & "0"
    ElseIf Mid(Trim(cValor), X, 1) <> " " Then 'cuando es un valor
    Y = Y + 1
    xvar = xvar & Mid(cValor, X, 1)
    End If
Next

If Len(Trim(cValor)) = 1 Then
 xvar = xvar & "00"  ''"0000"
 saca_punto = xvar
 Exit Function
End If

For x1 = 1 To nDecim - x1
 xvar = xvar & "0"
Next
saca_punto = xvar

End Function

Function Ceros(Dato As String, Largo As Integer) As String
Dim i%
Dim cero%

cero = (Largo - Len(Dato))
For i = 1 To cero
  Ceros = Ceros + "0"
Next i

End Function

Private Function saca_menos2(xValor As Variant) As String
Dim xstring As String
Dim Signo As String
xstring = Trim(Str(Abs(xValor)))

For i = Len(xstring) + 1 To 15
If i = 15 Then
  Signo = Signo & Trim("-")
  Else
  Signo = Signo & "0"
  End If
Next

saca_menos2 = Trim(Signo) & Trim(xstring)

End Function

Function ESPACIOS(Dato As String, Largo As Integer) As String

    ESPACIOS = 0
    If Len(Dato) <= Largo Then
        ESPACIOS = Space((Largo - Len(Dato))) & Dato
    End If

End Function
Function SacaDecim(Num) As String
Dim Dec As String
Dim desde As Integer
 
 
desde = (InStr(1, Num, gsBac_PtoDec) + 1)

If (desde > 1) Then
    Dec = Mid(Num, desde, Len(Num))
End If

SacaDecim = IIf(Dec = "", "", Dec)
    

End Function

Public Function TraeFechaAnterior() As Date
  Let TraeFechaAnterior = "01-" & Format(DateAdd("M", -1, gsBAC_Fecp), "mm-yyyy")
End Function


Public Function FuncGeneracionC18(ByVal nTodoMes As Boolean, ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
   Dim FechaDesde          As Date
   Dim FechaHasta          As Date
   Dim nDias               As Long
   Dim nContador           As Long
   Dim cFechaInterfaz      As String

   Let FechaDesde = TraeFechaAnterior
   Let FechaHasta = DateAdd("D", -1, DateAdd("M", 1, FechaDesde))
        Let nDias = DateDiff("D", FechaDesde, FechaHasta)

   Let nDias = IIf(nTodoMes = False, 0, nDias)

   Let nProgress.Visible = True
   Let nProgress.FloodPercent = 0

   For nContador = 0 To nDias

       Let cFechaInterfaz = Format(FechaDesde, "yyyymmdd")

      Call GeneracionInterfazC18(cPathFile, cNomFile, nProgress, FechaDesde)

       Let FechaDesde = DateAdd("D", 1, FechaDesde)

      Let nProgress.Visible = True
      Let nProgress.FloodPercent = IIf(nDias = 0, 100, ((nContador * 100#) / IIf(nDias = 0, 1, nDias)))

      If nProgress.FloodPercent >= 48 Then
         Let nProgress.ForeColor = vbWhite
      Else
         Let nProgress.ForeColor = vbBlack
      End If
   Next nContador

   Call BacControlWindows(1)

   Let nProgress.FloodPercent = 0
End Function



