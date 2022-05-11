Attribute VB_Name = "Modulo_Interfaces"
Dim Datos()
Dim fechaAnt As String
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
   Let cFechaInterfaz = Format(oFechaGeneracion, feFECHA)
   Let cruta = cPathFile

   Let cNomArchivo = ""
   Let cNomArchivo = cruta & "\" & "C18" + Mid(cFechaInterfaz, 7, 2) + Mid(cFechaInterfaz, 5, 2) + Mid(cFechaInterfaz, 1, 4) + ".CSV"

'cPathFile = "C:\interfaces\"

   If Dir(cNomArchivo) <> "" Then
      Call Kill(cNomArchivo)
   End If

   envia = Array()
   AddParam envia, cFechaInterfaz 'fechaAnt
   If Not Bac_Sql_Execute("BacTraderSuda..SP_INTERFAZ_C18", envia) Then
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

  'Call MsgBox("Interfaz C-18" & vbCrLf & vbCrLf & "La interfaz ha sido generada con exito en: " & vbCrLf & vbCrLf & UCase(cNomArchivo) & ".-", vbOKOnly + vbInformation, "GENERACION C18. ")

   If oMover = True Then
      Let ProgressPanel.FloodPercent = vbDefault
   End If

Exit Function
Error:
    Let Screen.MousePointer = vbDefault
   Call MsgBox("E - Err. en Interfaz C-18" & vbCrLf & vbCrLf & "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "ERROR EN GENERACION C18. ")
End Function

Public Function InterfazDerivadosSWP(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
  On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String

    Let InterfazDerivadosSWP = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    Let total = 0:  Let totalreg = 0:
    Let Screen.MousePointer = vbHourglass
   
    If Not Bac_Sql_Execute("SP_INTERFAZ_DERIVADOS_SWAP") Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(18))), "0000000000000000.00"), gsBac_PtoDec, "")
        cLine = cLine & IIf(Datos(19) = 0, Space(3), BacPad((Datos(19)), 3))
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(20))), "0000000000000000.00"), gsBac_PtoDec, "")
        cLine = cLine & BacPad((Datos(21)), 1) 'Datos(21)

        ' NUEVO
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(26))), "0000000000000000.00"), gsBac_PtoDec, "")
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(27))), "0000000000000000.00"), gsBac_PtoDec, "")
        cLine = cLine & BacPad((Datos(28)), 2)
        cLine = cLine & BacPad((Datos(29)), 2)
        cLine = cLine & BacPad((Datos(30)), 8)
        cLine = cLine & BacPad((Datos(31)), 8)
'        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(DATOS(32))), "0000000000000000.00"), gsc_PuntoDecim, "")
'        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(DATOS(33))), "0000000000000000.00"), gsc_PuntoDecim, "")

        If Val(bacTranMontoSql(Datos(32))) > 0 Then
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(32))), "0000000000000000.00"), gsBac_PtoDec, "")
        Else
        cLine = cLine & BacStrTran(Format$(Abs(Val(bacTranMontoSql(Datos(32)))), "-000000000000000.00"), gsBac_PtoDec, "")
        End If
        If Val(bacTranMontoSql(Datos(33))) > 0 Then
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(33))), "0000000000000000.00"), gsBac_PtoDec, "")
        Else
        cLine = cLine & BacStrTran(Format$(Abs(Val(bacTranMontoSql(Datos(33)))), "-000000000000000.00"), gsBac_PtoDec, "")
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
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786))
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
   
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
  Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   Exit Function
 
End Function

Public Function InterfazOperacionesBEX(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByRef bTieneDatos As Boolean) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long
    Dim ValorTasa      As Double
    Dim ValorTasaStr   As String

    Let InterfazOperacionesBEX = False
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
    
'    If Not Bac_Sql_Execute("SP_INTERFAZ_OPERACIONES_BONOS") Then
'        Let Screen.MousePointer = vbDefault
'        Exit Function
'    End If
'
'    Do While Bac_SQL_Fetch(Datos())
'        Let nRegTotal = nRegTotal + 1
'    Loop
    '--> Solo para obtener numero de filas
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_OPERACIONES_BONOS") Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
        cLine = cLine & Format((Datos(2)), "YYYYMMDD")      '2
        cLine = cLine & Format((Datos(3)), "YYYYMMDD")      '3
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
        cLine = cLine & BacPad((Datos(19)), 20)             '18
        cLine = cLine & Format(Datos(20), "YYYYMMDD")       '19
        cLine = cLine & Format(Datos(21), "YYYYMMDD")       '20
        cLine = cLine & BacPad((Datos(22)), 8)              '21
        cLine = cLine & Datos(23)                           '22
        cLine = cLine & BacPad((Datos(24)), 3)              '23
        cLine = cLine & Datos(25)                           '24
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(26))), "0000000000000000.00"), gsBac_PtoDec, "") '25
        cLine = cLine & Datos(27)                                                           '26
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(28))), "0000000000000000.00"), gsBac_PtoDec, "") '27
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(29))), "0000000000000000.00"), gsBac_PtoDec, "") '28
        cLine = cLine & Datos(30)                           '29
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(31))), "0000000000000000.00"), gsBac_PtoDec, "") '30
        cLine = cLine & Datos(32)                           '31
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(33))), "0000000000000000.00"), gsBac_PtoDec, "") '32
        cLine = cLine & Datos(34)                           '33
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(35))), "0000000000000000.00"), gsBac_PtoDec, "") '34
        cLine = cLine & BacPad((Datos(36)), 2)              '35
        cLine = cLine & BacPad((Datos(37)), 4)              '36
        '-- cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(38))), "00000000.00000000"), gsBac_PtoDec, "") '37
        '-- MAP 2016-06-16 Para soportar tasas negativas
        Let ValorTasa = Datos(38)
        If ValorTasa < 0 Then
            Let ValorTasa = -ValorTasa
            Let ValorTasaStr = BacStrTran(Format$(Val(bacTranMontoSql(ValorTasa)), "00000000.00000000"), gsBac_PtoDec, "")
            Let ValorTasaStr = "-" & Mid(ValorTasaStr, 1, Len(ValorTasaStr) - 1)
        Else
            Let ValorTasaStr = BacStrTran(Format$(Val(bacTranMontoSql(ValorTasa)), "00000000.00000000"), gsBac_PtoDec, "")
        End If
        cLine = cLine & ValorTasaStr '37
        
        
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(39))), "00000000.00000000"), gsBac_PtoDec, "") '38
        cLine = cLine & Datos(40)                           '39
        cLine = cLine & Format(Datos(41), "0000000000000000") '40
        cLine = cLine & BacPad((Datos(42)), 5)              '41
        cLine = cLine & BacPad((Datos(43)), 4)              '42
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(44))), "00000000.00000000"), gsBac_PtoDec, "") '43
        cLine = cLine & Format(Datos(45), "0000000000000000") '44
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(46))), "00000000.00000000"), gsBac_PtoDec, "") ' Format(datos(46), "0000000000000000") '45   - spread de tasa penalidad
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
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(70))), "0000000000000000.00"), gsBac_PtoDec, "")    '69
        cLine = cLine & Format(Datos(71), "000000000000000000")    '70
        cLine = cLine & Format(Datos(72), "000000000000000000")    '71
        cLine = cLine & Format(Datos(73), "000000000000000000")    '72
        cLine = cLine & Format(Datos(74), "000000000000000000")   '73
        cLine = cLine & Format(Datos(75), "000000000000000000")   '74
        cLine = cLine & Format(Datos(76), "000000000000000000")   '75
        cLine = cLine & Format(Datos(77), "000000000000000000")   '76
        cLine = cLine & BacPad((Datos(78)), 1)                     '77
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(79))), "0000000000000000.00"), gsBac_PtoDec, "")    '78
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(80))), "0000000000000000.00"), gsBac_PtoDec, "")    '79
        cLine = cLine & Datos(81)                                 '80
        cLine = cLine & Format(Datos(82), "000")                  '81
        cLine = cLine & Format(Datos(83), "0000")                 '82
        cLine = cLine & Format(Datos(84), "000000000000000000")   '83
        cLine = cLine & BacPad((Datos(85)), 1)                            '84
        cLine = cLine & BacPad((Datos(86)), 1)                            '85
        cLine = cLine & BacPad((Datos(87)), 1)                            '86
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(88))), "0000000000.00"), gsBac_PtoDec, "")          '87
        cLine = cLine & BacPad((Datos(89)), 5)                            '88
        cLine = cLine & BacPad((Datos(90)), 15)                           '89
        cLine = cLine & BacPad((Datos(91)), 4)                            '90
        cLine = cLine & BacPad((Datos(92)), 4)                           '91
        cLine = cLine & BacPad((Datos(93)), 3) '+ Chr(13) + Chr(10)         '92
        cLine = cLine & Ceros("", 16)
        cLine = cLine & Ceros("", 4)

        '>>>> Agregado con Fecha 18-Agosto-2008.- Cambio Estructura Interfaz Neosoft
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 18) '--> 95. Monto Mora 4 en Moneda Local (18,2) [90  y -365 Días]
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 18) '--> 96. Monto Mora 5 en Moneda Local (18,2) [365 y -  3 Años]
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 18) '--> 97. Monto Mora 6 en Moneda Local (18,2) [3   Años y Mas]
        cLine = cLine & "S"            '--> 98. Indicador Sbif               (1)
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 18) '--> 99. Otros cobros para Mora       (18,2)

        
        
                'A solicitud de Carlos Basterrica se agregan los nuevos campos para la intrfaz
        'Eduardo Castillo 19-01-2016
        
        cLine = cLine & Ceros("0", 19)  '--> Monto mora 7 moneda local
        cLine = cLine & Ceros("0", 19)  '--> Monto mora 8 moneda local
        cLine = cLine & Ceros("0", 19)  '--> Monto mora 9 moneda local
        cLine = cLine & Space(1)        '--> Origen Activo
               
        cLine = cLine & Ceros("0", 9)   '--> Fecha del primer vencimiento
        cLine = cLine & Space(1)        '--> Tipo de otorgamiento
        cLine = cLine & Ceros("0", 20)  '--> Precio de la vivienda
        cLine = cLine & Space(1)        '--> Tipo de operación renegociada
        cLine = cLine & Ceros("0", 20)  '--> Monto del pie pagado
        cLine = cLine & Space(1)        '--> Seguro de Remate
        cLine = cLine & Ceros("0", 9)   '--> Dias de morosidad con que se efectuo la renegociación”.

        
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
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786))
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let InterfazOperacionesBEX = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:

    If err.Number = 55 Then
        Close #1
    End If
   
    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    'Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
    Exit Function
End Function

Public Function InterfazBalanceBEX(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByRef bTieneDatos As Boolean) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let InterfazBalanceBEX = False
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
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_BALANCE_BONOS") Then
        Let Screen.MousePointer = vbDefault
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Let nRegTotal = nRegTotal + 1
    Loop
    
    '--> Solo para obtener numero de filas
   
    If Not Bac_Sql_Execute("SP_INTERFAZ_BALANCE_BONOS") Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
        cLine = cLine & Datos(12)
        cLine = cLine & Datos(14) + String(16 - Len(Datos(14)), "0") + "    "
        cLine = cLine & Datos(13)
        cLine = cLine & Datos(15)
        cLine = cLine & BacPad((Datos(16)), 3)
        cLine = cLine & Datos(17)
        
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(18))), "0000000000000000.00"), gsBac_PtoDec, "") '25
        cLine = cLine & Datos(19)
        
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(20))), "0000000000000000.00"), gsBac_PtoDec, "") '25
        cLine = cLine & Datos(21)
        
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(22))), "0000000000000000.00"), gsBac_PtoDec, "") '25
        cLine = cLine & BacPad((Datos(23)), 3)
        cLine = cLine & BacPad((Datos(24)), 10)
        
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
    cLine = cLine & "99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(158)
    
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let InterfazBalanceBEX = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    'Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
    Exit Function

End Function

Public Function InterfazFlujosBEX(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByRef bTieneDatos As Boolean) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let InterfazFlujosBEX = False
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
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_NEOSOFT_FLUJO") Then
        Let Screen.MousePointer = vbDefault
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Let nRegTotal = nRegTotal + 1
    Loop
    
    '--> Solo para obtener numero de filas
   
    If Not Bac_Sql_Execute("SP_INTERFAZ_NEOSOFT_FLUJO") Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
        cLine = cLine & BacPad((Datos(1)), 3)                                          ' 1
        cLine = cLine & Datos(2)                                                       ' 2
        cLine = cLine & BacPad((Datos(3)), 14)                                         ' 3
        cLine = cLine & Datos(4)                                                       ' 4
        cLine = cLine & BacPad((Datos(5)), 16)                                         ' 5
        cLine = cLine & BacPad((Datos(6)), 20)                                         ' 6
        cLine = cLine & Format((Datos(7)), "YYYYMMDD")                                 ' 7
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(8))), "0000000000000000.00"), gsBac_PtoDec, "") '8
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(9))), "0000000000000000.00"), gsBac_PtoDec, "") '9
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(10))), "0000000000000000.00"), gsBac_PtoDec, "") '10
        cLine = cLine & BacPad((Datos(11)), 3)                                         '11
        cLine = cLine & Space(10) '+ Chr(13) + Chr(10)                                 '12
        totalreg = totalreg + 1
        
        If Len(cLine) <> 139 Then
           totalreg = totalreg
        End If
                
        Print #1, cLine
        'Put #1, , cLine
        nProgress.FloodPercent = (totalreg * 100) / nRegTotal
        If nProgress.FloodPercent >= 49 Then
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbWhite
        Else
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
        End If
        
    Loop
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & "99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(119)
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let InterfazFlujosBEX = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
    Exit Function

End Function

Public Function InterfazDireccionesBEX(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let InterfazDireccionesBEX = False

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
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_DIRECCIONES_BONOS") Then
        Let Screen.MousePointer = vbDefault
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Let nRegTotal = nRegTotal + 1
    Loop
    
    '--> Solo para obtener numero de filas
   
    If Not Bac_Sql_Execute("SP_INTERFAZ_DIRECCIONES_BONOS") Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
        cLine = cLine & BacPad((Datos(3) + Datos(4)), 15)
        cLine = cLine & BacPad((Datos(1)), 8)
        cLine = cLine & BacPad((Datos(2)), 8)
        cLine = cLine & BacPad((Datos(5)), 16)
        cLine = cLine & BacPad((Datos(7)), 40)
        cLine = cLine & Space(40)
        cLine = cLine & BacPad((Datos(8)), 8)
        cLine = cLine & BacPad((Datos(9)), 8)
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
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786))
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let InterfazDireccionesBEX = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    'Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
    Exit Function

End Function

Public Function InterfazPosicionBEX(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim EXPUC8         As String
    Dim nRegTotal      As Long
    
    Let InterfazPosicionBEX = False

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
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_POSICION_BONOS") Then
        Let Screen.MousePointer = vbDefault
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Let nRegTotal = nRegTotal + 1
    Loop
    
    '--> Solo para obtener numero de filas
   
    If Not Bac_Sql_Execute("SP_INTERFAZ_POSICION_BONOS") Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
        cLine = cLine & BacPad((Datos(3)), 3)                      '3
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
        cLine = cLine & IIf(Datos(10) = 0, Space(4), BacPad((Datos(10)), 4))                  '17
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
        cLine = cLine & BacPad((Datos(18)), 16)    '35
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
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(30))), "000.000000"), gsBac_PtoDec, "")  '56
        cLine = cLine & Format(Datos(31), "0000")                  '57
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(32))), "000.000000"), gsBac_PtoDec, "")  '58
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
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(33))), "0000000000000.00"), gsBac_PtoDec, "")
        'cLine = cLine & Format(saca_punto(Trim(Str(Datos(34))), 2), "000000000000000") '73
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(34))), "0000000000000.00"), gsBac_PtoDec, "")
        cLine = cLine & Format(0, "000000000000000")               '74
        cLine = cLine & Format(0, "000000000000000")               '75
        'cLine = cLine & Format(saca_punto(Trim(Str(Datos(43))), 6), "00000000000")  '76
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(42))), "00000.000000"), gsBac_PtoDec, "")
        cLine = cLine & Format(0, "000000000000000")               '77
        cLine = cLine & Format(0, "000000000000000")               '78
        cLine = cLine & Space(4)                                   '79
        cLine = cLine & Space(4)                                   '80
        cLine = cLine & Space(4)                                   '81
        cLine = cLine & Space(4)                                   '82
        'cLine = cLine & Format(saca_punto(Trim(Str(Datos(35))), 2), "000000000000000") '83
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(35))), "0000000000000.00"), gsBac_PtoDec, "")
        'cLine = cLine & Format(saca_punto(Trim(Str(Datos(36))), 2), "000000000000000") '84
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(36))), "0000000000000.00"), gsBac_PtoDec, "")
        'cLine = cLine & Format(saca_punto(Trim(Str(Datos(37))), 2), "000000000000000") '85
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(37))), "0000000000000.00"), gsBac_PtoDec, "")
        'cLine = cLine & Format(saca_punto(Trim(Str(Datos(38))), 2), "000000000000000") '86
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(38))), "0000000000000.00"), gsBac_PtoDec, "")
        'cLine = cLine & Format(saca_punto(Trim(Str(Datos(39))), 2), "000000000000000") '87
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(39))), "0000000000000.00"), gsBac_PtoDec, "")
        cLine = cLine & Format(0, "000000000000000")               '88
        cLine = cLine & Format(0, "000000000000000")               '89
        cLine = cLine & Format(0, "000000000000000")               '90
        cLine = cLine & Format(0, "000000000000000")               '91
        cLine = cLine & Format(0, "000000000000000")               '92
        cLine = cLine & Format(0, "000000000000000")               '93
        cLine = cLine & Format(0, "000000000000000")               '94
        'cLine = cLine & Format(saca_punto(Trim(Str(Datos(44))), 2), "000000000000000") '95
        cLine = cLine & BacStrTran(Format$(Val(bacTranMontoSql(Datos(43))), "0000000000000.00"), gsBac_PtoDec, "")
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
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786))
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let InterfazPosicionBEX = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
    Exit Function

End Function

Public Function InterfazDeudoresBEX(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let InterfazDeudoresBEX = False

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
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_DEUDORES_BONOS") Then
        Let Screen.MousePointer = vbDefault
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Let nRegTotal = nRegTotal + 1
    Loop
    
    '--> Solo para obtener numero de filas
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_DEUDORES_BONOS") Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    
    Open cNomArchivo For Output As #1
     
    Do While Bac_SQL_Fetch(Datos())
 
        rut = BacValidaRut((Datos(4)), 0)
        dig = devolver
         
        rut1 = BacValidaRut((Datos(2)), 0)
        dig1 = devolver
         
        cLine = ""
        cLine = cLine & BacPad((Datos(2) + dig1), 15) & BacPad((Datos(3)), 16) & BacPad((Datos(4) + dig), 15)
        cLine = cLine & Datos(5) & Datos(6) & BacStrTran(Format$(Val(bacTranMontoSql(Datos(7))), "000.00"), gsBac_PtoDec, "") & Datos(8)
        'Format(saca_punto(Trim(Str(datos(7))), 2), "00000") & datos(8)
            
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
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786))
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let InterfazDeudoresBEX = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    'Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
    envia = Array()
    AddParam envia, gsBac_Fecp
    If Not Bac_Sql_Execute("SP_INTERFAZ_P40_BANCO", envia) Then
        Let Screen.MousePointer = vbDefault
        
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
      p = p + 1
    
   Loop
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786))
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
   
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786))
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
   
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
   Exit Function

End Function

Public Function InterfazP40BEX(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let InterfazP40BEX = False

    cNomFile = Replace(cNomFile, "P40", "ND51")

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
    envia = Array()
    AddParam envia, Format(gsBac_Fecp, "yyyymmdd")
    If Not Bac_Sql_Execute("SP_INTERFAZ_P40_BANCO_MX", envia) Then
        Let Screen.MousePointer = vbDefault
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Let nRegTotal = nRegTotal + 1
    Loop
    
    '--> Solo para obtener numero de filas
    
'    envia = Array()
'    AddParam envia, Format(gsBac_Fecp, "yyyymmdd")
    If Not Bac_Sql_Execute("SP_INTERFAZ_P40_BANCO_MX", envia) Then
       Let Screen.MousePointer = vbDefault
       Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
       Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
       Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    
    Open cNomArchivo For Output As #1
     
     Do While Bac_SQL_Fetch(Datos())
        nRegistros = Datos(37)

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
        Linea = Linea & ESPACIOS_CL(Trim(Datos(35)), 20, "D")                               '--> Nemotecnico del instrumento
        
        Print #1, Linea
        nContador = nContador + 1
        
        nProgress.FloodPercent = (nContador / nRegistros) * 100 '--> ActualizarBarra(CDbl(p), CDbl(nTotalRegistros))

        If nProgress.FloodPercent >= 49 Then
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbWhite
        Else
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
        End If
        
        Call BacControlWindows(2)
   Loop

    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000") & Space(786))
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault
    
    Let InterfazP40BEX = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    'Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
    Exit Function

End Function

Function ESPACIOS_CL(Dato As String, Largo As Integer, alineacion As String)
If alineacion = "I" Then
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

'Function Ceros(Dato As String, Largo As Integer) As String
'Dim i%
'Dim cero%
'
'cero = (Largo - Len(Dato))
'For i = 1 To cero
'  Ceros = Ceros + "0"
'Next i
'
'End Function

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

Private Function ESPACIOS(Dato As String, Largo As Integer) As String

    ESPACIOS = 0
    If Len(Dato) <= Largo Then
        ESPACIOS = Space((Largo - Len(Dato))) & Dato
    End If

End Function
Function SacaDecim(num) As String
Dim Dec As String
Dim desde As Integer
 
 
desde = (InStr(1, num, gsBac_PtoDec) + 1)

If (desde > 1) Then
    Dec = Mid(num, desde, Len(num))
End If

SacaDecim = IIf(Dec = "", "", Dec)
    

End Function

Public Function TraeFechaAnterior() As Date
  Let TraeFechaAnterior = "01-" & Format(DateAdd("M", -1, gsBac_Fecp), "mm-yyyy")
End Function
Private Function FuncSettingDirectorio()
   On Error GoTo ErrorSetting
   Dim cPathIni   As String
   Let cPathIni = App.Path & "\" & "Bac-Sistemas.ini"

   Let cPathFileC18 = UCase(Func_Read_INI("INTERFAZ", "PATH_C18", cPathIni))

     ' Let Drv_Unidad.drive = cPathFileC18
      'Let Dir_Directorio.Path = cPathFileC18
      dirC18 = cPathFileC18
      UnidadC18 = cPathFileC18
   On Error GoTo 0

Exit Function
ErrorSetting:

  ' Let Drv_Unidad.drive = DefaultDirectory
  ' Let Dir_Directorio.Path = DefaultDirectory

   On Error GoTo 0
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



