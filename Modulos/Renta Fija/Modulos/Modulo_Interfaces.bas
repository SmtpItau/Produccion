Attribute VB_Name = "Modulo_Interfaces"
Dim Datos()
Dim fechaAnt As String
Dim dirC18 As String
Dim UnidadC18 As String
Dim cruta            As String

Private Enum TipoCaracter
    [Numerico] = 0
    [Caracter] = 1
    [AlfaNumerico] = 2
    [Fecha YYYYMMDD] = 3
    [Fecha DDMMYYYY] = 4
End Enum

Private Function fCampoInterfaz(Formato As TipoCaracter, oCampo As Variant, Largo As Integer, oCantidadDecimales As Variant) As Variant
    On Error GoTo ErrorXXX
    Dim oRetorno            As Variant
    Dim oDecimales          As Variant
    Dim oEntero             As Variant
    Dim oValorNumerico      As Double
    Dim cSeparador_Decimal  As String
    Dim cFormato_Numero     As String
    Dim nPosicion_punto     As Long
    
    If Formato = Caracter Then
        If Len(oCampo) > Largo Then
            oCampo = Mid(oCampo, 1, Largo)
        End If
        oRetorno = oCampo & String(Largo - Len(oCampo), " ")
    End If

    If Formato = Numerico Then
        If CStr(Format(123.456, "0.000")) = "123.456" Then
            cSeparador_Decimal = "."
        Else
            cSeparador_Decimal = ","
        End If

        If Largo < Len(oCampo) Then
            Let oCampo = Mid(oCampo, 1, Largo)
        End If


        Let cFormato_Numero = "0." + String(oCantidadDecimales, "0")
        Let cValor = Format$(Val(oCampo), cFormato_Numero)
        Let nPosicion_punto = InStr(1, cValor, cSeparador_Decimal)
        Let oRetorno = String(Largo - Len(Replace(cValor, cSeparador_Decimal, "")), "0") + Replace(cValor, cSeparador_Decimal, "")
    End If

    If Formato = [Fecha YYYYMMDD] Then
        oRetorno = Format(CDate(oCampo), "yyyymmdd")
    End If
    If Formato = [Fecha DDMMYYYY] Then
        oRetorno = Format(CDate(oCampo), "ddmmyyyy")
    End If

    fCampoInterfaz = oRetorno
    On Error GoTo 0

Exit Function
ErrorXXX:
    
    If (Formato = [Fecha DDMMYYYY] Or Formato = [Fecha YYYYMMDD]) And err.Number = 13 Then
        Let oCampo = Mid(oCampo, 7, 2) & "/" & Mid(oCampo, 5, 2) & "/" & Mid(oCampo, 1, 4)
        Resume
    End If
    
    On Error GoTo 0
End Function


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
   If Right(cruta, 1) = "\" Then
      Let cNomArchivo = cruta & "C18" + Mid(cFechaInterfaz, 7, 2) + Mid(cFechaInterfaz, 5, 2) + Mid(cFechaInterfaz, 1, 4) + ".CSV"
   Else
   Let cNomArchivo = cruta & "\" & "C18" + Mid(cFechaInterfaz, 7, 2) + Mid(cFechaInterfaz, 5, 2) + Mid(cFechaInterfaz, 1, 4) + ".CSV"
   End If

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

  'Call MsgBox("Interfaz C-18" & vbCrLf & vbCrLf & "La interfaz ha sido generada con exito en: " & vbCrLf & vbCrLf & UCase(cNomArchivo) & ".-", vbOKOnly + vbInformation, "GENERACION C18. ")

   If oMover = True Then
      Let ProgressPanel.FloodPercent = vbDefault
   End If

Exit Function
Error:
    Let Screen.MousePointer = vbDefault
   Call MsgBox("E - Err. en Interfaz C-18" & vbCrLf & vbCrLf & "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "ERROR EN GENERACION C18. ")
End Function

Public Function InterfazOperaciones(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByRef bTieneDatos As Boolean) As Boolean
    On Error GoTo ErrorEscritura
    Dim Total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let InterfazOperaciones = False

    Let bTieneDatos = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If

    Let Total = 0:  Let totalreg = 0:

    Let Screen.MousePointer = vbHourglass
    Let nProgress.ForeColor = vbBlack
    
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
    
    'If Not Bac_Sql_Execute("SP_INTERFAZ_OPERACIONES_TRADER") Then
    '    Let Screen.MousePointer = vbDefault
    '    Exit Function
    'End If
    
    'Do While Bac_SQL_Fetch(DATOS())
    '    Let nRegTotal = nRegTotal + 1
    'Loop
    
    '--> Solo para obtener numero de filas
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_OPERACIONES_TRADER") Then
        Let Screen.MousePointer = vbDefault
        Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "OP15", 0, 0, 0, "Error en Proceso SQL, SP_INTERFAZ_OPERACIONES_TRADER", True)
       'Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
       'Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    nRegTotal = 0
    
    Open cNomArchivo For Output As #1
     Do While Bac_SQL_Fetch(Datos())
        Let bTieneDatos = True
      
        If nRegTotal = 0 Then
           Let nRegTotal = Datos(24)
        End If
      
        totalreg = totalreg + 1
        cLine = ""
        cLine = cLine & "CL "
        cLine = cLine & ESPACIOS_CL((Datos(1)), 8, "D")
        cLine = cLine & Format(gsBac_Fecp, "YYYYMMDD")
        cLine = cLine & ESPACIOS_CL("OP15", 14, "D")
        cLine = cLine & "001"
        cLine = cLine & "1  "
        cLine = cLine & ESPACIOS_CL((Datos(2)), 3, "D")
        cLine = cLine & "1"
        cLine = cLine & "MDIR"
        cLine = cLine & ESPACIOS_CL((Datos(4)), 4, "D")
        cLine = cLine & ESPACIOS_CL("MD01", 16, "D")
        cLine = cLine & Space(1)
        cLine = cLine & "M"
        cLine = cLine & ESPACIOS_CL((Datos(9)), 8, "D")
        cLine = cLine & ESPACIOS_CL((Datos(28)), 8, "D")
        cLine = cLine & ESPACIOS_CL(Datos(5) + Datos(6), 12, "D")
        cLine = cLine & IIf(Datos(7) = 0, Space(10), ESPACIOS_CL(Str(Datos(7)), 10, "D"))
        cLine = cLine & ESPACIOS_CL(Trim(Str(Datos(8))), 20, "D")
        cLine = cLine & Datos(9)
        cLine = cLine & Datos(10) '20
        cLine = cLine & Space(8)
        cLine = cLine & "V"
        cLine = cLine & ESPACIOS_CL((Datos(11)), 3, "D")
        cLine = cLine & Datos(12)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(13))), 2), "000000000000000000")
        cLine = cLine & Datos(14)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(15))), 2), "000000000000000000")
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Datos(16)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(17))), 2), "000000000000000000")
        cLine = cLine & Datos(29)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(30))), 2), "000000000000000000")
        cLine = cLine & Datos(31)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(32))), 2), "000000000000000000")
        cLine = cLine & ESPACIOS_CL((Datos(18)), 2, "D")
        cLine = cLine & ESPACIOS_CL((Datos(33)), 4, "D")
        cLine = cLine & Replace(Format(Datos(34), "00000000.00000000"), gsBac_PtoDec, "")
        cLine = cLine & Ceros("", 16)
        cLine = cLine & Datos(45)
        cLine = cLine & Ceros("", 16) '40
        cLine = cLine & Space(5)
        cLine = cLine & Space(4)
        cLine = cLine & Ceros("", 16)
        cLine = cLine & Ceros("", 16)
        cLine = cLine & Replace(Format(Datos(48), "00000000.00000000"), gsBac_PtoDec, "")   'Ceros("", 16)
        cLine = cLine & Datos(25)
        cLine = cLine & "+"
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Format(Datos(46), "000")
        cLine = cLine & "00" '50
        cLine = cLine & "0"
        cLine = cLine & "+"
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Space(8)
        cLine = cLine & Space(8)
        cLine = cLine & Space(8)
        cLine = cLine & Space(8)
        cLine = cLine & ESPACIOS_CL((Datos(27)), 20, "D")
        cLine = cLine & Format(Datos(35), "0000")
        cLine = cLine & Ceros("", 4) '60
        cLine = cLine & Format(Datos(36), "0000")
        cLine = cLine & Datos(47)
        cLine = cLine & Space(8)
        cLine = cLine & Space(8)
        cLine = cLine & "N"
        cLine = cLine & Space(8)
        If Datos(18) = "V" Then
            cLine = cLine & Datos(37)
            cLine = cLine & Datos(28)
        Else
            cLine = cLine & Space(8)
            cLine = cLine & Space(8)
        End If
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(38))), 2), "000000000000000000")
        cLine = cLine & Ceros("", 18) '70
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(39))), 2), "000000000000000000")
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Space(1)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(20))), 2), "000000000000000000")
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(21))), 2), "000000000000000000")
        cLine = cLine & Datos(40) '80
        cLine = cLine & Ceros("", 3)
        cLine = cLine & Format(Datos(41), "0000")
        cLine = cLine & Ceros("", 18)
        cLine = cLine & Space(1)
        cLine = cLine & IIf(Val(Datos(49)) = 0, Space(1), Datos(49)) '85
        cLine = cLine & Space(1)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(23))), 2), "000000000000")
        cLine = cLine & ESPACIOS_CL((Datos(42)), 5, "D")
        cLine = cLine & ESPACIOS_CL((Datos(43)), 15, "D")
        cLine = cLine & Space(4)
        cLine = cLine & Space(4)
        
        cLine = cLine & ESPACIOS_CL((Datos(50)), 3, "I")    '-> Space(3)    '--> 92

        cLine = cLine & Ceros("", 16)
        cLine = cLine & Ceros("", 4) '94
             
        '>>>> Agregado con Fecha 18-Agosto-2008.- Cambio Estructura Interfaz Neosoft
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 19) '--> Monto Mora 4 en Moneda Local (18,2) [90  y -365 Días]
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 18) '--> Monto Mora 5 en Moneda Local (18,2) [365 y -  3 Años]
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 18) '--> Monto Mora 6 en Moneda Local (18,2) [3   Años y Mas]
        cLine = cLine & "S"            '--> Indicador Sbif               (1)
        cLine = cLine & Format("0", "000000000000000000") '--> Ceros("0", 18) '--> Otros cobros para Mora       (18,2)
             
        '>>>>> Se Agrega en requerimiento N° 8136
        cLine = cLine & Format("0", "000000000000000000") '--> Monto Mora 2 en Moneda Local (lcy_pdo7_amt)
        cLine = cLine & Format("0", "000000000000000000") '--> Monto Mora 7 en Moneda Local (lcy_pdo8_amt)
        cLine = cLine & Format("0", "000000000000000000") '--> Monto Mora 9 en Moneda Local (lcy_pdo9_amt)
        cLine = cLine & " "                                '--> Origen del Activo            (assets_origin)
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

        p = p + 1
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
    Let InterfazOperaciones = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
   'MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    'Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)

    Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "OP15", 0, 0, 0, "E-Error :" & err.Number & vbCrLf & err.Description, True)
    Exit Function
End Function

Public Function InterfazBalance(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByRef bTieneDatos As Boolean) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim Total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let InterfazBalance = False
    Let bTieneDatos = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    
    Let Total = 0:  Let totalreg = 0:
    Let Screen.MousePointer = vbHourglass
    Let nProgress.ForeColor = vbBlack
    
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
    
   ' If Not Bac_Sql_Execute("SP_INTERFAZ_BALANCE_TRADER") Then
   '     Let Screen.MousePointer = vbDefault
   '     Exit Function
   ' End If
    
   ' Do While Bac_SQL_Fetch(DATOS())
   '     Let nRegTotal = nRegTotal + 1
   ' Loop
    
    '--> Solo para obtener numero de filas
   
    If Not Bac_Sql_Execute("SP_INTERFAZ_BALANCE_TRADER") Then
        Let Screen.MousePointer = vbDefault
        Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "BO15", 0, 0, 0, "Error en Proceso SQL, SP_INTERFAZ_BALANCE_TRADER", True)
        
       'Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
       'Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    
    Open cNomArchivo For Output As #1
    Do While Bac_SQL_Fetch(Datos())
        
      If nRegTotal = 0 Then
         Let nRegTotal = Datos(1)
      End If
        
        If Datos(13) <> 0 And Datos(15) <> 0 Then
            Let bTieneDatos = True
            
            
            cLine = ""
            cLine = cLine & ESPACIOS_CL((Datos(2)), 3, "D")
            cLine = cLine & Format(gsBac_Fecp, "yyyymmdd")
            cLine = cLine & ESPACIOS_CL((Datos(3)), 14, "D")
            cLine = cLine & "001"
            cLine = cLine & ESPACIOS_CL((Datos(4)), 4, "D")
            cLine = cLine & ESPACIOS_CL((Datos(5)), 4, "D")
            cLine = cLine & ESPACIOS_CL((Datos(6)), 16, "D")
            cLine = cLine & Space(1)
            cLine = cLine & "M"
            cLine = cLine & ESPACIOS_CL((Datos(7)), 20, "D")
            cLine = cLine & Format(gsBac_Fecp, "yyyymmdd")
            cLine = cLine & ESPACIOS_CL(Datos(9) & (String(16 - Len(Datos(9)), "0")), 20, "D")
            cLine = cLine & Format(Datos(18), "00") & Datos(10)
            cLine = cLine & ESPACIOS_CL((Datos(11)), 3, "D")
            cLine = cLine & Datos(12)
            cLine = cLine & Format(saca_punto(Trim(Str(Datos(13))), 2), "000000000000000000")
            cLine = cLine & Datos(14)
            cLine = cLine & Format(saca_punto(Trim(Str(Datos(15))), 2), "000000000000000000")
            cLine = cLine & Datos(16)
            cLine = cLine & Format(saca_punto(Trim(Str(Datos(13))), 2), "000000000000000000")
            cLine = cLine & "1  "
            cLine = cLine & Space(10)
            
            If Len(cLine) <> 178 Then
               p = p
            End If
            
            p = p + 1
            Print #1, cLine
            

''''            Prg.Max = p
''''            Prg.Value = p
        End If
        
        totalreg = totalreg + 1
        
        nProgress.FloodPercent = (totalreg * 100) / nRegTotal
        If nProgress.FloodPercent >= 49 Then
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbWhite
        Else
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
        End If
        
    Loop
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000")) & Space(158)
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let InterfazBalance = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
   'MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    'Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)

    Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "BO15", 0, 0, 0, "E-Error :" & err.Number & vbCrLf & err.Description, True)
    Exit Function
End Function

Public Function Interfazflujosmutuos(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByRef bTieneDatos As Boolean) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim Total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let Interfazflujosmutuos = False
    Let bTieneDatos = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    
    Let Total = 0:  Let totalreg = 0:
    Let Screen.MousePointer = vbHourglass
    Let nProgress.ForeColor = vbBlack
    Let nProgress.FloodPercent = 0
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
    
   ' If Not Bac_Sql_Execute("SP_INTERFAZ_FLUJO_TRADER") Then
   '     Let Screen.MousePointer = vbDefault
   '     Exit Function
   ' End If
    
   ' Do While Bac_SQL_Fetch(DATOS())
   '     Let nRegTotal = nRegTotal + 1
   ' Loop
    
    '--> Solo para obtener numero de filas
   
    If Not Bac_Sql_Execute("SP_INTERFAZ_FLUJO_TRADER") Then
        Let Screen.MousePointer = vbDefault
        Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "FL15", 0, 0, 0, "Error en Proceso SQL, SP_INTERFAZ_FLUJO_TRADER", True)
       'Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
       'Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    nRegTotal = 0
    Open cNomArchivo For Output As #1
    Do While Bac_SQL_Fetch(Datos())
        Let bTieneDatos = True
        
        If nRegTotal = 0 Then
           Let nRegTotal = Datos(1)
        End If
        
        cLine = ""
        cLine = cLine & ESPACIOS_CL((Datos(2)), 3, "D") & Format(gsBac_Fecp, "yyyymmdd") & ESPACIOS_CL((Datos(3)), 14, "D")
        cLine = cLine & ESPACIOS_CL((Datos(4)), 3, "D") & ESPACIOS_CL(("MD01"), 16, "D") & ESPACIOS_CL((Datos(6)), 20, "D") & Format(Datos(7), "yyyymmdd")
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(8))), 2), "000000000000000000") & Format(saca_punto(Trim(Str(Datos(9))), 2), "000000000000000000")
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(10))), 2), "000000000000000000") & "1  " & Space(10)
'     If Len(cLine) <> 139 Then
'            p = p
'     End If
     
    
        p = p + 1
        Print #1, cLine
        totalreg = totalreg + 1
        
        nProgress.FloodPercent = (totalreg * 100) / nRegTotal
        If nProgress.FloodPercent >= 49 Then
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbWhite
        Else
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
        End If
  
     Loop
    
    cLine = ""
    totalreg = totalreg + 1
    cLine = cLine & ("99" & Format(gsBac_Fecp, "yyyymmdd") & Format(totalreg, "0000000000")) & Space(119)
    Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let Interfazflujosmutuos = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
'    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
'    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
    
    Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "FL15", 0, 0, 0, "E-Error :" & err.Number & vbCrLf & err.Description, True)
    Exit Function

End Function

Public Function InterfazDirecciones(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    Dim Total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let InterfazDirecciones = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    
    Let Total = 0:  Let totalreg = 0:
    Let Screen.MousePointer = vbHourglass
    Let nProgress.ForeColor = vbBlack
    
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
    If Not Bac_Sql_Execute("SP_INTERFAZ_DIRECCIONES_TRADER") Then
        Let Screen.MousePointer = vbDefault
        Exit Function
    End If
    Do While Bac_SQL_Fetch(Datos())
        Let nRegTotal = nRegTotal + 1
    Loop
    
    '--> Solo para obtener numero de filas
    If Not Bac_Sql_Execute("SP_INTERFAZ_DIRECCIONES_TRADER") Then
        Let Screen.MousePointer = vbDefault
      Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "DD15", 0, 0, 0, "Error en Proceso SQL, SP_INTERFAZ_OPERACIONES_TRADER", True)
     'Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
     'Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
            NroTel = Mid$(Datos(10), 1, 7)
            NumeroTel = Format(Val(NroTel), "00000000000")
        Else
           NumeroTel = Format(Val(Datos(10)), "00000000000")
        End If
   
         cLine = ""
         cLine = cLine & ESPACIOS_CL(Datos(3) + Datos(4), 15, "D") & ESPACIOS_CL((Datos(1)), 8, "D") & ESPACIOS_CL((Datos(2)), 8, "D")
         cLine = cLine & ESPACIOS_CL((Datos(5)), 16, "D") & ESPACIOS_CL((Datos(7)), 40, "D") & Space(40) & IIf(Datos(9) = "0", Space(8), ESPACIOS_CL((Datos(8)), 8, "D")) & IIf(Datos(9) = "0", Space(8), ESPACIOS_CL((Datos(9)), 8, "2"))
         cLine = cLine & IIf(NumeroTel = 0, "00000000000", NumeroTel) & Format(Datos(11), "YYYYMMDD")
         
             
         If Len(cLine) <> 162 Then
                p = p
         End If
         
        totalreg = totalreg + 1
        p = p + 1
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

    Let InterfazDirecciones = True

    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "DD15", 0, 0, 0, "E-Error :" & err.Number & vbCrLf & err.Description, True)
    Exit Function
End Function

Public Function InterfazPosicion(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim Total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim EXPUC8         As String
    Dim nRegTotal      As Long
    
    Let InterfazPosicion = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    
    Let Total = 0:  Let totalreg = 0:
    Let Screen.MousePointer = vbHourglass
    Let nProgress.ForeColor = vbBlack
    
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
    
    'If Not Bac_Sql_Execute("SP_INTERFAZ_POSICION_CLIENTE") Then
    '    Let Screen.MousePointer = vbDefault
    '    Exit Function
    'End If
    
    'Do While Bac_SQL_Fetch(DATOS())
    '    Let nRegTotal = nRegTotal + 1
    'Loop
    
    '--> Solo para obtener numero de filas
   
    If Not Bac_Sql_Execute("SP_INTERFAZ_POSICION_CLIENTE") Then
        Let Screen.MousePointer = vbDefault
        Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "PC15", 0, 0, 0, "Error en Proceso SQL, SP_INTERFAZ_OPERACIONES_TRADER", True)
        
       'Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
       'Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    Let nRegTotal = 0
    
    Open cNomArchivo For Output As #1
    Do While Bac_SQL_Fetch(Datos())
        If nRegTotal = 0 Then
          Let nRegTotal = Datos(1)
        End If
     
       ' If FRM_PROC_FDIA.Prg.Max >= 10 Then
       '    FRM_PROC_FDIA.Prg.Max = DATOS(1)
       ' End If
     
        If Datos(36) < 0 Then
           EXPUC8 = "-"
        Else
           EXPUC8 = "+"
        End If
     
        cLine = ""
'        cLine = cLine & datos(2) & datos(3) & "999" & Ceros((datos(5)), 16) + (datos(5))
        cLine = cLine & Datos(2) & Datos(3) & ESPACIOS_CL(Trim(Str(Datos(4))), 3, "I") & Ceros((Datos(5)), 16) + (Datos(5))
        cLine = cLine & Ceros("", 8) & Ceros("", 12) & ESPACIOS_CL((Datos(6)), 4, "D") & ESPACIOS_CL((Datos(7)), 2, "D") & ESPACIOS_CL((Datos(8)), 4, "D") & Ceros((Datos(9)), 2) + Datos(9)
        cLine = cLine & Ceros("", 9) & Space(4) & Space(4) & "CL  " & Space(4) & Space(4) & IIf(Datos(10) = "0", Space(4), ESPACIOS_CL((Datos(10)), 4, "D")) & ESPACIOS_CL((Datos(11)), 4, "D") & Space(4) & Space(4) & Space(6) & Space(4) & Space(4) ''25
        cLine = cLine & Space(4) & ESPACIOS_CL(EXPUC8, 4, "D") & Space(1) & Space(4) & "BTR " & Ceros("", 12) & ESPACIOS_CL((Datos(12)), 35, "D") & Ceros((Datos(13)), 2) + (Datos(13)) & Ceros((Datos(14)), 2) + (Datos(14))
        
        cLine = cLine & Ceros((Datos(15)), 4) + (Datos(15)) & ESPACIOS_CL((Datos(16)), 4, "D") & ESPACIOS_CL((Datos(17)), 16, "D") & Ceros("", 12) & ESPACIOS_CL(Datos(18) + Datos(19), 15, "D")
        cLine = cLine & Space(4) & Ceros("", 6) & Datos(20) & Space(1) & Space(4) & Space(4) & Ceros((Datos(21)), 2) + (Datos(21)) & Ceros((Datos(22)), 2) + (Datos(22)) & Ceros((Datos(23)), 4) + (Datos(23))
        cLine = cLine & Ceros((Datos(24)), 2) + (Datos(24)) & Ceros((Datos(25)), 2) + (Datos(25)) & Ceros((Datos(26)), 4) + (Datos(26)) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 3) & Ceros("", 4) & Ceros("", 1)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(27))), 6), "000000000") & Ceros((Datos(28)), 4) + (Datos(28)) & Format(saca_punto(Trim(Str(Datos(29))), 6), "000000000") & Ceros("", 9) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4)
        cLine = cLine & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Format(saca_punto(Trim(Str(Datos(30))), 2), "000000000000000")
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(31))), 2), "000000000000000") & Ceros("", 15) & Ceros("", 15) & Replace(Format(Datos(42), "00000.000000"), gsBac_PtoDec, "") & Ceros("", 15) & Ceros("", 15) & Space(4) & Space(4) & Space(4) & Space(4) & Format(saca_punto(Trim(Str(Datos(32))), 2), "000000000000000")
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(33))), 2), "000000000000000") & Format(saca_punto(Trim(Str(Datos(34))), 2), "000000000000000") & Format(saca_punto(Trim(Str(Datos(35))), 2), "000000000000000")
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(36))), 2), "000000000000000") & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15)
        cLine = cLine & Format(saca_punto(Trim(Str(Datos(43))), 2), "000000000000000") & Ceros("", 15) & Ceros("", 15) & Ceros("", 15) & Space(4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 15) & Ceros("", 15) & Ceros("", 15)
        cLine = cLine & Ceros("", 4) & Ceros("", 4) & Ceros("", 4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Ceros("", 4) & Ceros("", 4) & Ceros("", 4) & Ceros("", 4) & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Space(2)
        cLine = cLine & Space(4) & Ceros("", 9) & Space(15) & Format(saca_punto(Trim(Str(Datos(38))), 2), "000000000000000") & Ceros("", 2) & Ceros("", 2) & Ceros("", 4) & Datos(39) & "X" & Datos(41)
          
         
        If Len(cLine) <> 864 Then
               p = p
        End If
     
        totalreg = totalreg + 1
        p = p + 1
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
    
'   Print #1, cLine
    Close #1
    Screen.MousePointer = vbDefault

    Let InterfazPosicion = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
'    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
'    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)

    Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "PC15", 0, 0, 0, "E-Error :" & err.Number & vbCrLf & err.Description, True)
    Exit Function
End Function



Public Function InterfazDeudores_resp(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim Total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let InterfazDeudores_resp = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If

    Let Total = 0:  Let totalreg = 0:

    Let Screen.MousePointer = vbHourglass
    Let nProgress.ForeColor = vbBlack
    
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
    
    'If Not Bac_Sql_Execute("SP_INTERFAZ_DEUDORES_TRADER") Then
    '    Let Screen.MousePointer = vbDefault
    '    Exit Function
    'End If
    
    'Do While Bac_SQL_Fetch(DATOS())
    '    Let nRegTotal = nRegTotal + 1
    'Loop
    
    '--> Solo para obtener numero de filas
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_DEUDORES_TRADER") Then
        Let Screen.MousePointer = vbDefault
        Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "PC15", 0, 0, 0, "Error en Proceso SQL, SP_INTERFAZ_OPERACIONES_TRADER", True)
       'Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
       'Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    Let nRegTotal = 0
    
    Open cNomArchivo For Output As #1
    Do While Bac_SQL_Fetch(Datos())
        
         If nRegTotal = 0 Then
            Let nRegTotal = Datos(1)
         End If
        
        'If FRM_PROC_FDIA.Prg.Max >= 10 Then FRM_PROC_FDIA.Prg.Max = DATOS(1)
         
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
    Let InterfazDeudores_resp = True

    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
'   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
'    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)

    Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "CO15", 0, 0, 0, "E-Error :" & err.Number & vbCrLf & err.Description, True)
    Exit Function
End Function


 Public Function SIGUIR(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    Dim Total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long

    Let SIGUIR = False

     Let cNomFile = Replace(cNomFile, "P40", "ND15")
    If Interfaz_P40_Banco_Contingencia(cPathFile, cNomFile) = False Then
       Exit Function
    End If
    
    Let cPathFile = FRM_PROC_FDIA.TraePathDeArchivo("OP15")

    
    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    
    Let Total = 0:  Let totalreg = 0:
    Let Screen.MousePointer = vbHourglass
    Let nProgress.ForeColor = vbBlack
    
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
    
    'Envia = Array()
    'AddParam Envia, gsBac_Fecp
    'If Not Bac_Sql_Execute("SP_INTERFAZ_P40_BANCO", Envia) Then
    '    Let Screen.MousePointer = vbDefault
    '    Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "P40", 0, 0, 0, "Error en Proceso SQL, SP_INTERFAZ_P40_BANCO", True)
    '    Exit Function
    'End If
    
    'Do While Bac_SQL_Fetch(DATOS())
    '    Let nRegTotal = nRegTotal + 1
    'Loop
    
    '--> Solo para obtener numero de filas
    
    Envia = Array()
    AddParam Envia, gsBac_Fecp
    If Not Bac_Sql_Execute("SP_INTERFAZ_P40_BANCO", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "P40", 0, 0, 0, "Error en Proceso SQL, SP_INTERFAZ_P40_BANCO", True)
       'Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
       'Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    Let nRegTotal = 0
    
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
        
        'nProgress.FloodPercent = (p / nTotalRegistros) * 100 '--> ActualizarBarra(CDbl(p), CDbl(nTotalRegistros))
        
        p = p + 1
        totalreg = totalreg + 1
        
        nProgress.FloodPercent = (totalreg * 100) / nTotalRegistros
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

    Let SIGUIR = True
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If
   
    Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "OP15", 0, 0, 0, "E-Error :" & err.Number & vbCrLf & err.Description, True)
    'MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
    'Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
    Exit Function
End Function

Public Function Clientes(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    
    Dim Total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim nRegTotal      As Long
    
    Let Clientes = False

    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    
    Let Total = 0:  Let totalreg = 0:
    Let Screen.MousePointer = vbHourglass
    Let nProgress.ForeColor = vbBlack
    
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
    
    'If Not Bac_Sql_Execute("SP_INTERFAZ_CLIENTE") Then
    '    Let Screen.MousePointer = vbDefault
    '    Exit Function
    'End If
    'Do While Bac_SQL_Fetch(DATOS())
    '    Let nRegTotal = nRegTotal + 1
    'Loop
    
    '--> Solo para obtener numero de filas
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_CLIENTE") Then
        Let Screen.MousePointer = vbDefault
       'Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
       'Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "OP15", 0, 0, 0, "Error en Proceso SQL, SP_INTERFAZ_OPERACIONES_TRADER", True)
        Exit Function
    End If
    
    CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    p = 0
    totalreg = 0
    Let nRegTotal = 0
    
    Open cNomArchivo For Output As #1
          
    Do While Bac_SQL_Fetch(Datos)
        If nRegTotal = 0 Then
           Let nRegTotal = Datos(20)
        End If
        If Len(Datos(14)) > 1 Then
            nrocal = Mid$(Datos(14), 1, 1)
            nrocalidad = Format(Val(nrocal), "0")
        Else
           nrocalidad = Format(Val(Datos(14)), "0")
        End If
            
        If Len(Datos(11)) > 11 Then
            NroTel = Mid$(Datos(11), 1, 7)
            NumeroTel = Format(Val(NroTel), "00000000000")
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
        cLine = cLine & Modulo_Interfaces.ESPACIOS_CL((Datos(1)) + Datos(2), 15, "D") & Format(Datos(3), "00000000") & IIf(Datos(4) = "0", Space(8), Modulo_Interfaces.ESPACIOS_CL(Trim(Datos(4)), 8, "D")) & Modulo_Interfaces.ESPACIOS_CL((Datos(5)), 40, "D")
        cLine = cLine & Modulo_Interfaces.ESPACIOS_CL((Datos(6)), 20, "D") & Modulo_Interfaces.ESPACIOS_CL((Datos(7)), 20, "D") & Modulo_Interfaces.ESPACIOS_CL((Datos(8)), 40, "D") & Space(40)
        cLine = cLine & IIf(Datos(9) = "0", Space(8), Modulo_Interfaces.ESPACIOS_CL((Datos(9)), 8, "D")) & IIf(Datos(10) = "0", Space(8), Modulo_Interfaces.ESPACIOS_CL((Datos(10)), 8, "D")) & NumeroTel
        cLine = cLine & Space(40) & Space(40) & ESPACIOS_CL(("9999"), 8, "D") & Modulo_Interfaces.ESPACIOS_CL(("9999"), 8, "D") & Ceros("", 11) & Space(1) & Space(8) & Modulo_Interfaces.ESPACIOS_CL((Datos(23)), 8, "D") & Modulo_Interfaces.ESPACIOS_CL("9999", 8, "D")
        cLine = cLine & "0000" & Space(8) & "00" & Space(8) & Space(15) & Space(40) & Space(20) & Space(20)
        cLine = cLine & IIf(Datos(12) = "", Space(8), Format(Datos(12), "YYYYMMDD")) & IIf(Datos(21) = "", Space(8), Modulo_Interfaces.ESPACIOS_CL((Datos(21)), 8, "I")) & ESPACIOS_CL((Datos(20)), 1, "D") & Format(Val(Datos(13)), "0") & IIf(nrocalidad = "0", Space(8), Modulo_Interfaces.ESPACIOS_CL((nrocalidad), 8, "D")) & NumeroFax
        cLine = cLine & Modulo_Interfaces.ESPACIOS_CL("MDIN", 8, "D") & Modulo_Interfaces.ESPACIOS_CL((Datos(22)), 8, "D") & Modulo_Interfaces.ESPACIOS_CL("MDIN", 8, "D") & Modulo_Interfaces.ESPACIOS_CL((Datos(16)), 8, "D") & IIf(Datos(17) = "0", Space(8), Modulo_Interfaces.ESPACIOS_CL((Datos(17)), 8, "D")) & Space(8)
        cLine = cLine & Space(1) & Modulo_Interfaces.ESPACIOS_CL((Datos(18)), 4, "D") & Space(30) & Space(8) & Space(1) & Ceros("", 11) & Ceros("", 8) & Ceros("", 8) & Ceros("", 8) & Ceros("", 8) & Ceros("", 14)
        cLine = cLine & "6" & Space(40)

'        cLine = ""
'        cLine = cLine & ESPACIOS(Trim(DATOS(1)) + DATOS(2), 15) & DATOS(3) & ESPACIOS(Trim(DATOS(4)), 10) & ESPACIOS(Trim(DATOS(5)), 40)
'        cLine = cLine & ESPACIOS(Trim(DATOS(1)) + DATOS(2), 15) & DATOS(3) & ESPACIOS(Trim(DATOS(4)), 10) & ESPACIOS(Trim(DATOS(5)), 40)
'        cLine = cLine & ESPACIOS(Trim(DATOS(6)), 20) & ESPACIOS(Trim(DATOS(7)), 20) & ESPACIOS(Trim(DATOS(8)), 40)
'        cLine = cLine & ESPACIOS(Trim(DATOS(9)), 4) & ESPACIOS(Trim(DATOS(10)), 4) & NumeroTel
'        cLine = cLine & Space(40) & Space(4) & Space(4) & "00000000000" & Space(1) & Space(8) & Space(1) & "00000000000"
'        cLine = cLine & "0000" & "0000" & Space(8) & "00" & Space(1) & Space(15) & Space(40) & Space(20)
'        cLine = cLine & Space(20) & Format(DATOS(12), "ddmmyyyy") & DATOS(20) & Format(Val(DATOS(13)), "0") & nrocalidad & NumeroFax
'        cLine = cLine & Space(4) & ESPACIOS(Trim(DATOS(16)), 4) & ESPACIOS(Trim(DATOS(17)), 4) & Space(4)
'        cLine = cLine & Space(1) & ESPACIOS(Trim(DATOS(18)), 4) & Space(30) & Space(4) & "00000000" & "00000000" & "00000000000000" & Space(1)
'        cLine = cLine & Space(40) & Space(1)
        
        p = p + 1
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

    Let Clientes = True
    
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

Exit Function
ErrorEscritura:
     If err.Number = 55 Then
        Close #1
    End If
   
'    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
'    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)

    Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "OP15", 0, 0, 0, "E-Error :" & err.Number & vbCrLf & err.Description, True)
    Exit Function
End Function


Public Function InterfazArt84(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel) As Boolean
    On Error GoTo ErrorEscritura
    Dim Total          As Long
    Dim totalreg       As Long
    Dim cNomArchivo    As String
    Dim cLine          As String
    Dim ErrorRut       As String
    Dim ErrorCliente   As Boolean
    Dim cNomArchivo2   As String
    Dim cLine2          As String
     
    Let ErrorRut = ""
    Let ErrorCliente = False

    Let InterfazArt84 = False
      
    'Genera Archivo CMMD vacio para IBS
    Let cNomArchivo2 = ""
    Let cNomArchivo2 = cPathFile & cNomFile
    
    'Se renombra para LD1
    Let cNomFile = Replace(cNomFile, "CMMD", "CMMD_CORP")
    
    Let cNomArchivo = ""
    Let cNomArchivo = cPathFile & cNomFile
    
    Let nProgress.FloodPercent = 0
    Let nProgress.ForeColor = vbBlack

    If Not Dir(cNomArchivo) = "" Then
        Call Kill(cNomArchivo)
    End If
    
    If Not Dir(cNomArchivo2) = "" Then
        Call Kill(cNomArchivo2)
    End If

    Let Total = 0:  Let totalreg = 0:

    Let Screen.MousePointer = vbHourglass
    Let nProgress.ForeColor = vbBlack
    
    Let nRegTotal = 0
    
    '--> Solo para obtener numero de filas
   '   If Not Bac_Sql_Execute("SP_INTERFAZ_ARTICULO84") Then
   '       Let Screen.MousePointer = vbDefault
   '       Exit Function
   '   End If
   '   Do While Bac_SQL_Fetch(DATOS())
   '       Let nRegTotal = nRegTotal + 1
   '   Loop
    '--> Solo para obtener numero de filas
      
    
    If Not Bac_Sql_Execute("SP_INTERFAZ_ARTICULO84") Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("E-Error" & vbCrLf & vbCrLf & "Error al extraer los datos para la generación.", vbExclamation, "[INTERFAZ_OPERACIONES_TRADER]")
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15  NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
        Exit Function
    End If
    
    Let CPrg = 0

    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    Let p = 0
    Let totalreg = 0
    
    Let cLine2 = ""
    Open cNomArchivo2 For Output As #2
    Print #2, cLine2
    Close #2
    
    Open cNomArchivo For Output As #1
     
    Do While Bac_SQL_Fetch(Datos())
                 
        If FuncValidaRut(Datos(1), ErrorRut) = False Then
            Let ErrorCliente = True
        End If

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
        Total = Total + 1
        Print #1, cLine
        
        nProgress.FloodPercent = IIf(Total >= 90, 90, Total)
       'nProgress.FloodPercent = (Total * 100) / nRegTotal
        If nProgress.FloodPercent >= 49 Then
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbWhite
        Else
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
        End If
    Loop
    
    Let InterfazArt84 = True
    Let nProgress.FloodPercent = 100

    Let cLine = ""
    Let totalreg = totalreg + 1
    
    Print #1, cLine
    Close #1
    
        
    If ErrorCliente = True Then
       Call Kill(cNomArchivo)
       Call Kill(cNomArchivo2)
       Call MsgBox("Favor revisar se encuentre creado como cliente correspondiente al (los) siguiente (s) Rut: " & vbCrLf & ErrorRut & vbCrLf & "Favor Revisar. (Clientes y Emisores). ", vbExclamation, App.Title)
       Let InterfazArt84 = False
    End If

    Let Screen.MousePointer = vbDefault
    
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
Exit Function
ErrorEscritura:
    If err.Number = 55 Then
        Close #1
    End If

    Resume
    MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
'    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "ERROR Interfaz de Operaciones OP15 NO REALIZADA  " & cNomArchivo & err.Number & " Descripción: " & err.Description)
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
Dim y As Integer
If Mid(cValor, 1, 1) = "-" Then
    cValor = Mid(cValor, 2, Len(cValor))
End If
For X = 1 To Len(cValor) 'nDecim
    If Mid(cValor, X, 1) = "." Then
      xvar = xvar & "" 'Mid(cValor, x, 1)
      x1 = Len(Mid(cValor, X + 1, Len(cValor)))
     y = y - 1
    ElseIf Mid(cValor, X, 1) = " " Then
     xvar = xvar & "0"
    ElseIf Mid(Trim(cValor), X, 1) <> " " Then 'cuando es un valor
    y = y + 1
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
Dim Desde As Integer
 
 
Desde = (InStr(1, Num, gsBac_PtoDec) + 1)

If (Desde > 1) Then
    Dec = Mid(Num, Desde, Len(Num))
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
  
   Let FuncGeneracionC18 = False
   
   If Month(gsBac_Feca) = Month(gsBac_Fecp) Then
      Let FuncGeneracionC18 = True
      Exit Function
   End If
  
   Let FechaDesde = TraeFechaAnterior
   Let FechaHasta = DateAdd("D", -1, DateAdd("M", 1, FechaDesde))
        Let nDias = DateDiff("D", FechaDesde, FechaHasta)
   Let nDias = IIf(nTodoMes = False, 0, nDias)

   Let nProgress.Visible = True
   Let nProgress.FloodPercent = 0
    
    '-> Se aplica cambio para generacion Unificada
     Let cFechaInterfaz = Format(FechaDesde, "yyyymmdd")

    Call Generacion_C18_Unificado(cPathFile, cNomFile, nProgress, FechaDesde)

    Call BacControlWindows(1)
     Let FuncGeneracionC18 = True
     Let nProgress.FloodPercent = 0

Exit Function

    '-> Se aplica cambio para generacion Unificada
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
   Let FuncGeneracionC18 = True
   Let nProgress.FloodPercent = 0

End Function



Private Function Interfaz_P40_Banco_Contingencia(ByVal cPathFile As String, ByVal cNomFile As String)
   On Error GoTo ErrorEscrituraP40
   Dim SQL              As String
   Dim nTotalRegistros  As Long

   CPrg = 0
   i = 1
   p = 1

   Let Interfaz_P40_Banco_Contingencia = False

   NOMBRE = cPathFile & cNomFile
   
   Envia = Array()
   AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_INTERFAZ_P40_BANCO_ibs", Envia) Then
      Screen.MousePointer = vbDefault
      Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "P40", 0, 0, 0, "Error en Proceso SQL, SP_INTERFAZ_P40_BANCO_ibs", True)
      On Error GoTo 0
      Exit Function
   End If

   If Dir(NOMBRE) <> "" Then
      Call Kill(NOMBRE)
   End If

   Open NOMBRE For Append As #1

   Do While Bac_SQL_Fetch(Datos())
      nTotalRegistros = Datos(39)
      
      Linea = ""
      Linea = Linea & ESPACIOS_CL(Trim(Datos(1)), 2, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(2)), 3, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(3)), 8, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(4)), 8, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(5)), 1, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(6)), 10, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(7)), 3, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(8)), 2, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(9)), 20, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(10)), 1, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(11)), 1, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(12)), 8, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(13)), 8, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(14)), 8, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(15)), 2, "D")
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(16))), 2, 16)
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(17))), 2, 16)
      Linea = Linea & ESPACIOS_CL(Trim(Datos(18)), 3, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(19)), 3, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(20)), 7, "D")
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(21))), 2, 4)
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(22))), 4, 6)
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(23))), 2, 16)
      Linea = Linea & ESPACIOS_CL(Trim(Datos(24)), 7, "D")
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(25))), 2, 4)
      Linea = Linea & ESPACIOS_CL(Trim(Datos(40)), 1, "D")  '--> Signo debe ir detras del monto
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(26))), 0, 14) '--> 2,14
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(27))), 0, 14) '--> 2,14
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(28))), 0, 14) '--> 2,14
      Linea = Linea & ESPACIOS_CL(Trim(Datos(29)), 7, "D")
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(30))), 2, 4)
      Linea = Linea & ESPACIOS_CL(Trim(Datos(41)), 1, "D")  '--> Signo debe ir detras del monto
      Linea = Linea & ESPACIOS_CL(Trim(Datos(31)), 1, "D")
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(32))), 2, 8)
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(33))), 2, 4)
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(34))), 4, 8)
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(35))), 0, 14)
      Linea = Linea & SACAR_PUNTUACION_nd15cont(Trim(Str(Datos(36))), 0, 1)
      Linea = Linea & ESPACIOS_CL(Trim(Datos(37)), 8, "D")
      Linea = Linea & ESPACIOS_CL(Trim(Datos(38)), 8, "D")
      
      Print #1, Linea
     
      p = p + 1
      Call BacControlWindows(2)
   Loop
      
   'Debug.Print Format(Datos(33), "#,#0.00")

   Close #1

   Let Interfaz_P40_Banco_Contingencia = True
   
   On Error GoTo 0
      
Exit Function
ErrorEscrituraP40:
   On Error Resume Next
   Close #1
   On Error GoTo 0
   
   Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "P40", 0, 0, 0, "", True)
   On Error GoTo 0
End Function


Private Function SACAR_PUNTUACION_nd15cont(cValor As String, nDecim As Integer, nLargo As Integer) As String
    Dim cFormato_Numero As String

    bExistePunto = False

    If CStr(Format(123.456, "0.000")) = "123.456" Then
        cSeparador_Decimal = "."
    Else
        cSeparador_Decimal = ","
    End If

    cFormato_Numero = "0." + String(nDecim, "0")

    cValor = Format$(Val(cValor), cFormato_Numero)

    nPosicion_punto = InStr(1, cValor, cSeparador_Decimal)

    xvar = String(nLargo - Len(Replace(cValor, cSeparador_Decimal, "")), "0") + Replace(cValor, cSeparador_Decimal, "")
    
    SACAR_PUNTUACION_nd15cont = xvar

End Function


Private Function FuncValidaRut(ByVal oRut As String, ByRef Arreglo As Variant) As Boolean
   Dim xRut    As String
   Dim xDig    As String

   If Len(oRut) <= 1 Then
      If Len(oRut) = 0 Then
         Let xRut = "0"
         Let xDig = "0"
      Else
         Let xRut = oRut
         Let xDig = "0"
      End If
   Else
      Let xRut = Left(oRut, Len(oRut) - 1)
      Let xDig = Right(oRut, 1)
   End If

   Let FuncValidaRut = BacValidaRut(xRut, xDig)

   If FuncValidaRut = False Then
      Let Arreglo = Arreglo & "- Rut : " & Trim(xRut) & Trim(xDig) & vbCrLf
   End If

End Function

Private Function BacValidaRut(ByVal cRut As String, ByVal dig As String) As Boolean
   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim Multi   As Double

   BacValidaRut = False
    
   If Trim$(cRut) = "" Or Trim$(dig) = "" Then
      Exit Function
   End If

   Suma = 0
    
   cRut = Format(cRut, "000000000")
   D = 2
   For i = 9 To 1 Step -1
      Multi = Val(Mid$(cRut, i, 1)) * D
      Suma = Suma + Multi
      D = D + 1
      
      If D = 8 Then
         D = 2
      End If
   Next i
    
   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))
    
   If Digito = "10" Then
      Digito = "K"
   End If
    
   If Digito = "11" Then
      Digito = "0"
   End If
    
   If Trim$(UCase$(Digito)) = UCase$(Trim$(dig)) Then
      BacValidaRut = True
   End If

End Function

Public Function Generacion_C18_Unificado(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByVal oFechaGeneracion As Date) As Boolean
    On Error GoTo ErrorGeneracionC18_Unificado
    Dim SqlDatos()
    Dim nNumFile
    Dim cLinea      As String
    
    
    Let Generacion_C18_Unificado = False
    Let Screen.MousePointer = vbHourglass

    If Not Right(cPathFile, 1) = "\" Then
        Let cPathFile = cPathFile & "\"
    End If
    Let cPathFile = cPathFile & "C18" & Format(gsBac_Fecp, "yyyymmdd") & ".DAT"

    If Len(Dir(cPathFile)) > 0 Then
        Call Kill(cPathFile)
    End If

    Envia = Array()
    AddParam Envia, Format(oFechaGeneracion, "yyyymmdd")
    If Not Bac_Sql_Execute("BacTraderSuda.dbo.Sp_C18_Unificado", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Interfaz C-18" & vbCrLf & "Ha ocurrido un error al intentar generar la interfaz C18", vbCritical, App.Title)
        Exit Function
    End If

    Let nNumFile = FreeFile
    Open cPathFile For Append As #nNumFile

    Do While Bac_SQL_Fetch(SqlDatos())
        Let cLinea = ""
        Let cLinea = cLinea & Format(SqlDatos(1), "00")
        Let cLinea = cLinea & SqlDatos(2)
        Let cLinea = cLinea & SqlDatos(3)
        Let cLinea = cLinea & SqlDatos(4)
        Let cLinea = cLinea & SqlDatos(5)
        Let cLinea = cLinea & SqlDatos(6)
        Let cLinea = cLinea & SqlDatos(7)
        Let cLinea = cLinea & Format(SqlDatos(8), "00000000000000")
        Let cLinea = cLinea & SqlDatos(9)
        Let cLinea = cLinea & SqlDatos(10)
        Let cLinea = cLinea & SqlDatos(11)
        Let cLinea = cLinea & SqlDatos(12)
        Let cLinea = cLinea & SqlDatos(13)

        Print #nNumFile, cLinea
    Loop

    Close #nNumFile

    Let Screen.MousePointer = vbDefault
    Let Generacion_C18_Unificado = True

Exit Function
ErrorGeneracionC18_Unificado:

    If err.Number = 55 Then
        If MsgBox(err.Description & vbCrLf & vbCrLf & "Reintentar ?", vbExclamation + vbYesNo, App.Title) = vbYes Then
            Reset
            Resume
        End If
    End If

    Let Screen.MousePointer = vbDefault
   Call MsgBox("E - Err. en Interfaz C-18" & vbCrLf & vbCrLf & "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "ERROR EN GENERACION C18. ")

End Function

Public Function InterfazD16_D17(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByVal oFechaGeneracion As Date) As Boolean
    On Error GoTo ErrorGeneracionD16_D17_Unificado
    Dim SqlDatos()
    Dim nNumFile
    Dim cLinea      As String
    
    Let InterfazD16_D17 = False
    
    Let Screen.MousePointer = vbHourglass

    If Not Right(cPathFile, 1) = "\" Then
        Let cPathFile = cPathFile & "\"
    End If
    
    Let cPathFile = cPathFile & cNomFile

    If Len(Dir(cPathFile)) > 0 Then
        Call Kill(cPathFile)
    End If

    Envia = Array()
    AddParam Envia, Format(oFechaGeneracion, "yyyymmdd")
    If Not Bac_Sql_Execute("BacTraderSuda.dbo.Sp_Interfaz_D16_D17", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Interfaz D16-D17" & vbCrLf & "Ha ocurrido un error al intentar generar la interfaz D16-D17", vbCritical, App.Title)
        Exit Function
    End If

    Let nNumFile = FreeFile
    Open cPathFile For Append As #nNumFile

    Do While Bac_SQL_Fetch(SqlDatos())
        Let cLinea = ""
        Let cLinea = cLinea & fCampoInterfaz(Numerico, SqlDatos(1), 9, 0)
        Let cLinea = cLinea & fCampoInterfaz(Caracter, SqlDatos(2), 45, 0)
        Let cLinea = cLinea & fCampoInterfaz(Caracter, SqlDatos(3), 1, 0)
        Let cLinea = cLinea & fCampoInterfaz(Caracter, SqlDatos(4), 4, 0)
        Let cLinea = cLinea & fCampoInterfaz(Numerico, SqlDatos(5), 20, 0)
        Let cLinea = cLinea & fCampoInterfaz(Caracter, SqlDatos(6), 3, 0)
        Let cLinea = cLinea & fCampoInterfaz(Numerico, SqlDatos(7), 8, 0)
        Let cLinea = cLinea & fCampoInterfaz(Numerico, SqlDatos(8), 8, 0)
        Let cLinea = cLinea & fCampoInterfaz(Numerico, SqlDatos(9), 17, 0)
        Let cLinea = cLinea & fCampoInterfaz(Numerico, SqlDatos(10), 6, 0)
        Let cLinea = cLinea & fCampoInterfaz(Numerico, SqlDatos(11), 6, 0)
        Let cLinea = cLinea & fCampoInterfaz(Caracter, SqlDatos(12), 1, 0)
        Let cLinea = cLinea & fCampoInterfaz(Numerico, SqlDatos(13), 10, 0)
        Let cLinea = cLinea & fCampoInterfaz(Caracter, SqlDatos(14), 1, 0)

        Print #nNumFile, cLinea
    Loop

    Close #nNumFile

    Let Screen.MousePointer = vbDefault
    Let InterfazD16_D17 = True

Exit Function
ErrorGeneracionD16_D17_Unificado:

    If err.Number = 55 Then
        If MsgBox(err.Description & vbCrLf & vbCrLf & "Reintentar ?", vbExclamation + vbYesNo, App.Title) = vbYes Then
            Reset
            Resume
        End If
    End If

    Let Screen.MousePointer = vbDefault
   Call MsgBox("E - Err. en Interfaz C-18" & vbCrLf & vbCrLf & "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "ERROR EN GENERACION C18. ")

End Function

''===========================================================
'' LD1-COR-035-Configuración BAC Corpbanca , Tema: INTERFACES
'' INICIO
''===========================================================
Public Function Genera_GENERA_DTS_GEN_CAP(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByVal oFechaGeneracion As Date) As Boolean
    On Error GoTo ErrorGeneracion_RGENCAP_Unificado
    Dim Datos()
    Dim nNumFile
    Dim cLinea      As String
    
    Let Genera_GENERA_DTS_GEN_CAP = False
    
    Let Screen.MousePointer = vbHourglass

    If Not Right(cPathFile, 1) = "\" Then
        Let cPathFile = cPathFile & "\"
    End If
    
    Let cPathFile = cPathFile & cNomFile

    If Len(Dir(cPathFile)) > 0 Then
        Call Kill(cPathFile)
    End If
    
    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_GENERA_DTS_RENTA_GEN_CAP_5") Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Interfaz Renta Gen Cap" & vbCrLf & "Ha ocurrido un error al intentar generar la interfaz D16-D17", vbCritical, App.Title)
        Exit Function
    End If

    nombre_arch = cPathFile
    Open nombre_arch For Output As #1
        Let cLinea = ""
        Let cLinea = cLinea + """" + "fecha_operacion" + """" + ","
        Let cLinea = cLinea + """" + "fecha_vencimiento" + """" + ","
        Let cLinea = cLinea + """" + "tipo_operacion" + """" + ","
        Let cLinea = cLinea + """" + "numero_operacion" + """" + ","
        Let cLinea = cLinea + """" + "correla_operacion" + """" + ","
        Let cLinea = cLinea + """" + "correla_corte" + """" + ","
        Let cLinea = cLinea + """" + "rut_cliente" + """" + ","
        Let cLinea = cLinea + """" + "codigo_rut" + """" + ","
        Let cLinea = cLinea + """" + "entidad" + """" + ","
        Let cLinea = cLinea + """" + "forma_pago" + """" + ","
        Let cLinea = cLinea + """" + "retiro" + """" + ","
        Let cLinea = cLinea + """" + "monto_inicio" + """" + ","
        Let cLinea = cLinea + """" + "monto_inicio_pesos" + """" + ","
        Let cLinea = cLinea + """" + "moneda" + """" + ","
        Let cLinea = cLinea + """" + "tasa" + """" + ","
        Let cLinea = cLinea + """" + "tasa_tran" + """" + ","
        Let cLinea = cLinea + """" + "plazo" + """" + ","
        Let cLinea = cLinea + """" + "monto_final" + """" + ","
        Let cLinea = cLinea + """" + "estado" + """" + ","
        Let cLinea = cLinea + """" + "fecha_origen" + """" + ","
        Let cLinea = cLinea + """" + "control_renov" + """" + ","
        Let cLinea = cLinea + """" + "custodia" + """" + ","
        Let cLinea = cLinea + """" + "valor_ant_presente" + """" + ","
        Let cLinea = cLinea + """" + "interes_diario" + """" + ","
        Let cLinea = cLinea + """" + "reajuste_diario" + """" + ","
        Let cLinea = cLinea + """" + "interes_acumulado" + """" + ","
        Let cLinea = cLinea + """" + "reajuste_acumulado" + """" + ","
        Let cLinea = cLinea + """" + "valor_presente" + """" + ","
        Let cLinea = cLinea + """" + "interes_extra" + """" + ","
        Let cLinea = cLinea + """" + "reajuste_extra" + """" + ","
        Let cLinea = cLinea + """" + "tipo_deposito" + """" + ","
        Let cLinea = cLinea + """" + "numero_original" + """" + ","
        Let cLinea = cLinea + """" + "Condicion_Captacion" + """" + ","
        Let cLinea = cLinea + """" + "Tipo_Emision" + """"
    
    
    Print #1, cLinea
    Let cLinea = ""
    Do While Bac_SQL_Fetch(Datos())
                
        Let cLinea = cLinea + Format(Datos(1), "yyyy-mm-dd") + ","
        Let cLinea = cLinea + Format(Datos(2), "yyyy-mm-dd") + ","
        Let cLinea = cLinea + """" + Datos(3) + """" + ","
        Let cLinea = cLinea + Datos(4) + ","
        Let cLinea = cLinea + Datos(5) + ","
        Let cLinea = cLinea + Datos(6) + ","
        Let cLinea = cLinea + Datos(7) + ","
        Let cLinea = cLinea + Datos(8) + ","
        Let cLinea = cLinea + Datos(9) + ","
        Let cLinea = cLinea + """" + Datos(10) + """" + ","
        Let cLinea = cLinea + """" + Datos(11) + """" + ","
        'Let cLinea = cLinea + DATOS(12) + ","
        Let cLinea = cLinea + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(12)))) + ","
        'Let cLinea = cLinea + DATOS(13) + ","
        Let cLinea = cLinea + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(13)))) + ","
        Let cLinea = cLinea + Datos(14) + ","
        'Let cLinea = cLinea + DATOS(15) + ","
        Let cLinea = cLinea + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(15)))) + ","
        'Let cLinea = cLinea + DATOS(16) + ","
        Let cLinea = cLinea + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(16)))) + ","
        Let cLinea = cLinea + Datos(17) + ","
        'Let cLinea = cLinea + DATOS(18) + ","
        Let cLinea = cLinea + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(18)))) + ","
        Let cLinea = cLinea + """" + Datos(19) + """" + ","
        Let cLinea = cLinea + Format(Datos(20), "yyyy-mm-dd") + "," + ","
        Let cLinea = cLinea + Datos(21) + ","
        Let cLinea = cLinea + """" + Datos(22) + """" + ","
        'Let cLinea = cLinea + DATOS(23) + ","
        Let cLinea = cLinea + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(23)))) + ","
        'Let cLinea = cLinea + DATOS(24) + ","
        Let cLinea = cLinea + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(24)))) + ","
        'Let cLinea = cLinea + DATOS(25) + ","
        Let cLinea = cLinea + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(25)))) + ","
        'Let cLinea = cLinea + DATOS(26) + ","
        Let cLinea = cLinea + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(26)))) + ","
        'Let cLinea = cLinea + DATOS(27) + ","
        Let cLinea = cLinea + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(27)))) + ","
        'Let cLinea = cLinea + DATOS(28) + ","
        Let cLinea = cLinea + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(28)))) + ","
        'Let cLinea = cLinea + DATOS(29) + ","
        Let cLinea = cLinea + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(29)))) + ","
        'Let cLinea = cLinea + DATOS(30) + ","
        Let cLinea = cLinea + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(30)))) + ","
        Let cLinea = cLinea + """" + Datos(31) + """" + ","
        Let cLinea = cLinea + Datos(32) + ","
        Let cLinea = cLinea + """" + Datos(33) + """" + ","
        Let cLinea = cLinea + Datos(34)
        Print #1, cLinea
        
        cLinea = ""
    Loop
        Close #1
    Reset

    Let Screen.MousePointer = vbDefault
    Let Genera_GENERA_DTS_GEN_CAP = True

Exit Function
ErrorGeneracion_RGENCAP_Unificado:

    If err.Number = 55 Then
        If MsgBox(err.Description & vbCrLf & vbCrLf & "Reintentar ?", vbExclamation + vbYesNo, App.Title) = vbYes Then
            Reset
            Resume
        End If
    End If

    Let Screen.MousePointer = vbDefault
   Call MsgBox("E - Err. en Interfaz RGENCAP" & vbCrLf & vbCrLf & "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "ERROR EN GENERACION RGENCAP. ")

End Function

Public Function Genera_GENERA_DTS_GEN_MDCI(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByVal oFechaGeneracion As Date) As Boolean
    On Error GoTo ErrorGeneracion_RMDCI_Unificado
    Dim Datos()
    Dim nNumFile
    Dim REGISTRO      As String
    
    Let Genera_GENERA_DTS_GEN_MDCI = False
    
    Let Screen.MousePointer = vbHourglass

    If Not Right(cPathFile, 1) = "\" Then
        Let cPathFile = cPathFile & "\"
    End If
    
    Let cPathFile = cPathFile & cNomFile

    If Len(Dir(cPathFile)) > 0 Then
        Call Kill(cPathFile)
    End If
   
    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_GENERA_DTS_RENTA_MDCI_3") Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Interfaz Renta Gen Cap" & vbCrLf & "Ha ocurrido un error al intentar generar la interfaz D16-D17", vbCritical, App.Title)
        Exit Function
    End If

    nombre_arch = cPathFile
    Open nombre_arch For Output As #1
        REGISTRO = ""
        REGISTRO = REGISTRO + """" + "cirutcart" + """" + ","
        REGISTRO = REGISTRO + """" + "citipcart" + """" + ","
        REGISTRO = REGISTRO + """" + "cinumdocu" + """" + ","
        REGISTRO = REGISTRO + """" + "cicorrela" + """" + ","
        REGISTRO = REGISTRO + """" + "cinumdocuo" + """" + ","
        REGISTRO = REGISTRO + """" + "cicorrelao" + """" + ","
        REGISTRO = REGISTRO + """" + "cirutcli" + """" + ","
        REGISTRO = REGISTRO + """" + "cicodcli" + """" + ","
        REGISTRO = REGISTRO + """" + "ciinstser" + """" + ","
        REGISTRO = REGISTRO + """" + "cimascara" + """" + ","
        REGISTRO = REGISTRO + """" + "cinominal" + """" + ","
        REGISTRO = REGISTRO + """" + "cifeccomp" + """" + ","
        REGISTRO = REGISTRO + """" + "civalcomp" + """" + ","
        REGISTRO = REGISTRO + """" + "civalcomu" + """" + ","
        REGISTRO = REGISTRO + """" + "civcum100" + """" + ","
        REGISTRO = REGISTRO + """" + "citircomp" + """" + ","
        REGISTRO = REGISTRO + """" + "citasest" + """" + ","
        REGISTRO = REGISTRO + """" + "cipvpcomp" + """" + ","
        REGISTRO = REGISTRO + """" + "civpcomp" + """" + ","
        REGISTRO = REGISTRO + """" + "cifecemi" + """" + ","
        REGISTRO = REGISTRO + """" + "cifecven" + """" + ","
        REGISTRO = REGISTRO + """" + "ciseriado" + """" + ","
        REGISTRO = REGISTRO + """" + "cicodigo" + """" + ","
        REGISTRO = REGISTRO + """" + "cifecinip" + """" + ","
        REGISTRO = REGISTRO + """" + "cifecvenp" + """" + ","
        REGISTRO = REGISTRO + """" + "civalinip" + """" + ","
        REGISTRO = REGISTRO + """" + "civalvenp" + """" + ","
        REGISTRO = REGISTRO + """" + "citaspact" + """" + ","
        REGISTRO = REGISTRO + """" + "cibaspact" + """" + ","
        REGISTRO = REGISTRO + """" + "cimonpact" + """" + ","
        REGISTRO = REGISTRO + """" + "civptirc" + """" + ","
        REGISTRO = REGISTRO + """" + "cicapitalc" + """" + ","
        REGISTRO = REGISTRO + """" + "ciinteresc" + """" + ","
        REGISTRO = REGISTRO + """" + "cireajustc" + """" + ","
        REGISTRO = REGISTRO + """" + "ciintermes" + """" + ","
        REGISTRO = REGISTRO + """" + "cireajumes" + """" + ","
        REGISTRO = REGISTRO + """" + "cicapitalci" + """" + ","
        REGISTRO = REGISTRO + """" + "ciinteresci" + """" + ","
        REGISTRO = REGISTRO + """" + "cireajustci" + """" + ","
        REGISTRO = REGISTRO + """" + "civptirci" + """" + ","
        REGISTRO = REGISTRO + """" + "cinumucup" + """" + ","
        REGISTRO = REGISTRO + """" + "cirutemi" + """" + ","
        REGISTRO = REGISTRO + """" + "cimonemi" + """" + ","
        REGISTRO = REGISTRO + """" + "cicontador" + """" + ","
        REGISTRO = REGISTRO + """" + "cifecucup" + """" + ","
        REGISTRO = REGISTRO + """" + "cinominalp" + """" + ","
        REGISTRO = REGISTRO + """" + "ciforpagi" + """" + ","
        REGISTRO = REGISTRO + """" + "ciforpagv" + """" + ","
        REGISTRO = REGISTRO + """" + "cifecpcup" + """" + ","
        REGISTRO = REGISTRO + """" + "cidcv" + """" + ","
        REGISTRO = REGISTRO + """" + "cidurat" + """" + ","
        REGISTRO = REGISTRO + """" + "cidurmod" + """" + ","
        REGISTRO = REGISTRO + """" + "ciconvex" + """" + ","
        REGISTRO = REGISTRO + """" + "fecha_compra_original" + """" + ","
        REGISTRO = REGISTRO + """" + "valor_compra_original" + """" + ","
        REGISTRO = REGISTRO + """" + "valor_compra_um_original" + """" + ","
        REGISTRO = REGISTRO + """" + "tir_compra_original" + """" + ","
        REGISTRO = REGISTRO + """" + "valor_par_compra_original" + """" + ","
        REGISTRO = REGISTRO + """" + "porcentaje_valor_par_compra_original" + """" + ","
        REGISTRO = REGISTRO + """" + "codigo_carterasuper" + """" + ","
        REGISTRO = REGISTRO + """" + "Tipo_Cartera_Financiera" + """" + ","
        REGISTRO = REGISTRO + """" + "Mercado" + """" + ","
        REGISTRO = REGISTRO + """" + "Sucursal" + """" + ","
        REGISTRO = REGISTRO + """" + "Id_Sistema" + """" + ","
        REGISTRO = REGISTRO + """" + "Fecha_PagoMañana" + """" + ","
        REGISTRO = REGISTRO + """" + "Laminas" + """" + ","
        REGISTRO = REGISTRO + """" + "Tipo_Inversion" + """" + ","
        REGISTRO = REGISTRO + """" + "Cuenta_Corriente_Inicio" + """" + ","
        REGISTRO = REGISTRO + """" + "Cuenta_Corriente_Final" + """" + ","
        REGISTRO = REGISTRO + """" + "Sucursal_Inicio" + """" + ","
        REGISTRO = REGISTRO + """" + "Sucursal_Final" + """" + ","
        REGISTRO = REGISTRO + """" + "Estado_Operacion_Linea" + """" + ","
        REGISTRO = REGISTRO + """" + "Tasa_Contrato" + """" + ","
        REGISTRO = REGISTRO + """" + "Valor_Contable" + """" + ","
        REGISTRO = REGISTRO + """" + "Fecha_Contrato" + """" + ","
        REGISTRO = REGISTRO + """" + "Numero_Contrato" + """" + ","
        REGISTRO = REGISTRO + """" + "Tipo_Rentabilidad" + """" + ","
        REGISTRO = REGISTRO + """" + "Ejecutivo" + """" + ","
        REGISTRO = REGISTRO + """" + "Tipo_Custodia" + """" + ","
        REGISTRO = REGISTRO + """" + "cigarantia" + """" + ","
        REGISTRO = REGISTRO + """" + "ciind1446" + """"
    
    
    Print #1, REGISTRO
    REGISTRO = ""
    Do While Bac_SQL_Fetch(Datos())

       REGISTRO = REGISTRO + Datos(1) + ","
        REGISTRO = REGISTRO + Datos(2) + ","
        REGISTRO = REGISTRO + Datos(3) + ","
        REGISTRO = REGISTRO + Datos(4) + ","
        REGISTRO = REGISTRO + Datos(5) + ","
        REGISTRO = REGISTRO + Datos(6) + ","
        REGISTRO = REGISTRO + Datos(7) + ","
        REGISTRO = REGISTRO + Datos(8) + ","
        REGISTRO = REGISTRO + """" + Datos(9) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(10) + """" + ","
        'REGISTRO = REGISTRO + DATOS(11) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(11)))) + ","
        REGISTRO = REGISTRO + Format(Datos(12), "yyyy-mm-dd") + ","
        'REGISTRO = REGISTRO + DATOS(13) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(13)))) + ","
        'REGISTRO = REGISTRO + DATOS(14) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(14)))) + ","
        'REGISTRO = REGISTRO + DATOS(15) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(15)))) + ","
        'REGISTRO = REGISTRO + DATOS(16) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(16)))) + ","
        'REGISTRO = REGISTRO + DATOS(17) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(17)))) + ","
        'REGISTRO = REGISTRO + DATOS(18) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(18)))) + ","
        'REGISTRO = REGISTRO + DATOS(19) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(19)))) + ","
        REGISTRO = REGISTRO + Format(Datos(20), "yyyy-mm-dd") + ","
        REGISTRO = REGISTRO + Format(Datos(21), "yyyy-mm-dd") + ","
        REGISTRO = REGISTRO + """" + Datos(22) + """" + ","
        REGISTRO = REGISTRO + Datos(23) + ","
        REGISTRO = REGISTRO + Format(Datos(24), "yyyy-mm-dd") + ","
        REGISTRO = REGISTRO + Format(Datos(25), "yyyy-mm-dd") + ","
        'REGISTRO = REGISTRO + DATOS(26) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(26)))) + ","
        'REGISTRO = REGISTRO + DATOS(27) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(27)))) + ","
        'REGISTRO = REGISTRO + DATOS(28) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(28)))) + ","
        REGISTRO = REGISTRO + Datos(29) + ","
        REGISTRO = REGISTRO + Datos(30) + ","
        'REGISTRO = REGISTRO + DATOS(31) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(31)))) + ","
        'REGISTRO = REGISTRO + DATOS(32) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(32)))) + ","
        'REGISTRO = REGISTRO + DATOS(33) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(33)))) + ","
        'REGISTRO = REGISTRO + DATOS(34) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(34)))) + ","
        'REGISTRO = REGISTRO + DATOS(35) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(35)))) + ","
        'REGISTRO = REGISTRO + DATOS(36) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(36)))) + ","
        'REGISTRO = REGISTRO + DATOS(37) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(37)))) + ","
        'REGISTRO = REGISTRO + DATOS(38) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(38)))) + ","
        'REGISTRO = REGISTRO + DATOS(39) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(39)))) + ","
        'REGISTRO = REGISTRO + DATOS(40) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(40)))) + ","
        REGISTRO = REGISTRO + Datos(41) + ","
        REGISTRO = REGISTRO + Datos(42) + ","
        REGISTRO = REGISTRO + Datos(43) + ","
        REGISTRO = REGISTRO + Datos(44) + ","
        REGISTRO = REGISTRO + Format(Datos(45), "yyyy-mm-dd") + ","
        'REGISTRO = REGISTRO + DATOS(46) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(46)))) + ","
        REGISTRO = REGISTRO + Datos(47) + ","
        REGISTRO = REGISTRO + Datos(48) + ","
        REGISTRO = REGISTRO + Format(Datos(49), "yyyy-mm-dd") + ","
        REGISTRO = REGISTRO + """" + Datos(50) + """" + ","
        'REGISTRO = REGISTRO + DATOS(51) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(51)))) + ","
        'REGISTRO = REGISTRO + DATOS(52) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(52)))) + ","
        'REGISTRO = REGISTRO + DATOS(53) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(53)))) + ","
        REGISTRO = REGISTRO + Format(Datos(54), "yyyy-mm-dd") + ","
        'REGISTRO = REGISTRO + DATOS(55) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(55)))) + ","
        'REGISTRO = REGISTRO + DATOS(56) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(56)))) + ","
        'REGISTRO = REGISTRO + DATOS(57) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(57)))) + ","
        'REGISTRO = REGISTRO + DATOS(58) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(58)))) + ","
        'REGISTRO = REGISTRO + DATOS(59) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(59)))) + ","
        REGISTRO = REGISTRO + """" + Datos(60) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(61) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(62) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(63) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(64) + """" + ","
        REGISTRO = REGISTRO + Format(Datos(65), "yyyy-mm-dd") + ","
        If Datos(66) = "" Then
            REGISTRO = REGISTRO + """" + """" + ","
        Else
            REGISTRO = REGISTRO + Datos(66) + ","
        End If

        REGISTRO = REGISTRO + """" + Datos(67) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(68) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(69) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(70) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(71) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(72) + """" + ","
        'REGISTRO = REGISTRO + DATOS(73) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(73)))) + ","
        'REGISTRO = REGISTRO + DATOS(74) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(74)))) + ","
        If Datos(75) = "01-01-1900" Then
            REGISTRO = REGISTRO + ","
        Else
            REGISTRO = REGISTRO + Format(Datos(75), "yyyy-mm-dd") + ","
        End If
        REGISTRO = REGISTRO + Datos(76) + ","
        REGISTRO = REGISTRO + """" + Datos(77) + """" + ","
        REGISTRO = REGISTRO + Datos(78) + ","
        If Datos(79) = 0 Then
            REGISTRO = REGISTRO + ","
        Else
            REGISTRO = REGISTRO + Datos(79) + ","
        End If

        REGISTRO = REGISTRO + """" + Datos(80) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(81) + """"
        Print #1, REGISTRO

        REGISTRO = ""
    Loop
        Close #1
    Reset

    Let Screen.MousePointer = vbDefault
    
    Let Genera_GENERA_DTS_GEN_MDCI = True

Exit Function
ErrorGeneracion_RMDCI_Unificado:

    If err.Number = 55 Then
        If MsgBox(err.Description & vbCrLf & vbCrLf & "Reintentar ?", vbExclamation + vbYesNo, App.Title) = vbYes Then
            Reset
            Resume
        End If
    End If

    Let Screen.MousePointer = vbDefault
   Call MsgBox("E - Err. en Interfaz RMDCI" & vbCrLf & vbCrLf & "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "ERROR EN GENERACION RMDCI. ")

 On Error GoTo 0

End Function

Public Function Genera_GENERA_DTS_GEN_MDCP(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByVal oFechaGeneracion As Date) As Boolean
    On Error GoTo ErrorGeneracion_RMDCP_Unificado
    Dim Datos()
    Dim nNumFile
    Dim REGISTRO      As String
    
    Let Genera_GENERA_DTS_GEN_MDCP = False
    
    Let Screen.MousePointer = vbHourglass

    If Not Right(cPathFile, 1) = "\" Then
        Let cPathFile = cPathFile & "\"
    End If
    
    Let cPathFile = cPathFile & cNomFile

    If Len(Dir(cPathFile)) > 0 Then
        Call Kill(cPathFile)
    End If

    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_GENERA_DTS_RENTA_MDCP_2") Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Interfaz Renta Gen Cap" & vbCrLf & "Ha ocurrido un error al intentar generar la interfaz D16-D17", vbCritical, App.Title)
        Exit Function
    End If

    nombre_arch = cPathFile
    Open nombre_arch For Output As #1
        REGISTRO = ""
        REGISTRO = REGISTRO + """" + "cprutcart" + """" + ","
        REGISTRO = REGISTRO + """" + "cptipcart" + """" + ","
        REGISTRO = REGISTRO + """" + "cpnumdocu" + """" + ","
        REGISTRO = REGISTRO + """" + "cpcorrela" + """" + ","
        REGISTRO = REGISTRO + """" + "cpnumdocuo" + """" + ","
        REGISTRO = REGISTRO + """" + "cpcorrelao" + """" + ","
        REGISTRO = REGISTRO + """" + "cprutcli" + """" + ","
        REGISTRO = REGISTRO + """" + "cpcodcli" + """" + ","
        REGISTRO = REGISTRO + """" + "cpinstser" + """" + ","
        REGISTRO = REGISTRO + """" + "cpmascara" + """" + ","
        REGISTRO = REGISTRO + """" + "cpnominal" + """" + ","
        REGISTRO = REGISTRO + """" + "cpfeccomp" + """" + ","
        REGISTRO = REGISTRO + """" + "cpvalcomp" + """" + ","
        REGISTRO = REGISTRO + """" + "cpvalcomu" + """" + ","
        REGISTRO = REGISTRO + """" + "cpvcum100" + """" + ","
        REGISTRO = REGISTRO + """" + "cptircomp" + """" + ","
        REGISTRO = REGISTRO + """" + "cptasest" + """" + ","
        REGISTRO = REGISTRO + """" + "cppvpcomp" + """" + ","
        REGISTRO = REGISTRO + """" + "cpvpcomp" + """" + ","
        REGISTRO = REGISTRO + """" + "cpnumucup" + """" + ","
        REGISTRO = REGISTRO + """" + "cpfecemi" + """" + ","
        REGISTRO = REGISTRO + """" + "cpfecven" + """" + ","
        REGISTRO = REGISTRO + """" + "cpseriado" + """" + ","
        REGISTRO = REGISTRO + """" + "cpcodigo" + """" + ","
        REGISTRO = REGISTRO + """" + "cpvptirc" + """" + ","
        REGISTRO = REGISTRO + """" + "cpcapitalc" + """" + ","
        REGISTRO = REGISTRO + """" + "cpinteresc" + """" + ","
        REGISTRO = REGISTRO + """" + "cpreajustc" + """" + ","
        REGISTRO = REGISTRO + """" + "cpcontador" + """" + ","
        REGISTRO = REGISTRO + """" + "cpfecucup" + """" + ","
        REGISTRO = REGISTRO + """" + "cpfecpcup" + """" + ","
        REGISTRO = REGISTRO + """" + "cpvcompori" + """" + ","
        REGISTRO = REGISTRO + """" + "cpdcv" + """" + ","
        REGISTRO = REGISTRO + """" + "cpdurat" + """" + ","
        REGISTRO = REGISTRO + """" + "cpdurmod" + """" + ","
        REGISTRO = REGISTRO + """" + "cpconvex" + """" + ","
        REGISTRO = REGISTRO + """" + "cpintermes" + """" + ","
        REGISTRO = REGISTRO + """" + "cpreajumes" + """" + ","
        REGISTRO = REGISTRO + """" + "fecha_compra_original" + """" + ","
        REGISTRO = REGISTRO + """" + "valor_compra_original" + """" + ","
        REGISTRO = REGISTRO + """" + "valor_compra_um_original" + """" + ","
        REGISTRO = REGISTRO + """" + "tir_compra_original" + """" + ","
        REGISTRO = REGISTRO + """" + "valor_par_compra_original" + """" + ","
        REGISTRO = REGISTRO + """" + "porcentaje_valor_par_compra_original" + """" + ","
        REGISTRO = REGISTRO + """" + "codigo_carterasuper" + """" + ","
        REGISTRO = REGISTRO + """" + "Tipo_Cartera_Financiera" + """" + ","
        REGISTRO = REGISTRO + """" + "Mercado" + """" + ","
        REGISTRO = REGISTRO + """" + "Sucursal" + """" + ","
        REGISTRO = REGISTRO + """" + "Id_Sistema" + """" + ","
        REGISTRO = REGISTRO + """" + "Fecha_PagoMañana" + """" + ","
        REGISTRO = REGISTRO + """" + "Laminas" + """" + ","
        REGISTRO = REGISTRO + """" + "Tipo_Inversion" + """" + ","
        REGISTRO = REGISTRO + """" + "Estado_Operacion_Linea" + """" + ","
        REGISTRO = REGISTRO + """" + "cptipoletra" + """" + ","
        REGISTRO = REGISTRO + """" + "Tasa_Contrato" + """" + ","
        REGISTRO = REGISTRO + """" + "Valor_Contable" + """" + ","
        REGISTRO = REGISTRO + """" + "Fecha_Contrato" + """" + ","
        REGISTRO = REGISTRO + """" + "Numero_Contrato" + """" + ","
        REGISTRO = REGISTRO + """" + "Tipo_Rentabilidad" + """" + ","
        REGISTRO = REGISTRO + """" + "Ejecutivo" + """" + ","
        REGISTRO = REGISTRO + """" + "Tipo_Custodia" + """" + ","
        REGISTRO = REGISTRO + """" + "cpforpagi" + """" + ","
        REGISTRO = REGISTRO + """" + "cpsenala" + """" + ","
        REGISTRO = REGISTRO + """" + "cpvptasemi" + """" + ","
        REGISTRO = REGISTRO + """" + "Valor_a_Diferir" + """" + ","
        REGISTRO = REGISTRO + """" + "Capital_Tasa_Emi" + """" + ","
        REGISTRO = REGISTRO + """" + "Intereses_Tasa_Emi" + """" + ","
        REGISTRO = REGISTRO + """" + "Reajustes_Tasa_Emi" + """"
    
    Print #1, REGISTRO
    REGISTRO = ""
    Do While Bac_SQL_Fetch(Datos())
                
        REGISTRO = REGISTRO + Datos(1) + ","
        REGISTRO = REGISTRO + Datos(2) + ","
        REGISTRO = REGISTRO + Datos(3) + ","
        REGISTRO = REGISTRO + Datos(4) + ","
        REGISTRO = REGISTRO + Datos(5) + ","
        REGISTRO = REGISTRO + Datos(6) + ","
        REGISTRO = REGISTRO + Datos(7) + ","
        REGISTRO = REGISTRO + Datos(8) + ","
        REGISTRO = REGISTRO + """" + Datos(9) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(10) + """" + ","
        'REGISTRO = REGISTRO + DATOS(11) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(11)))) + ","
        REGISTRO = REGISTRO + Format(Datos(12), "yyyy-mm-dd") + ","
        'REGISTRO = REGISTRO + DATOS(13) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(13)))) + ","
        'REGISTRO = REGISTRO + DATOS(14) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(14)))) + ","
        'REGISTRO = REGISTRO + DATOS(15) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(15)))) + ","
        'REGISTRO = REGISTRO + DATOS(16) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(16)))) + ","
        'REGISTRO = REGISTRO + DATOS(17) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(17)))) + ","
        'REGISTRO = REGISTRO + DATOS(18) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(18)))) + ","
        'REGISTRO = REGISTRO + DATOS(19) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(19)))) + ","
        REGISTRO = REGISTRO + Datos(20) + ","
        REGISTRO = REGISTRO + Format(Datos(21), "yyyy-mm-dd") + ","
        REGISTRO = REGISTRO + Format(Datos(22), "yyyy-mm-dd") + ","
        REGISTRO = REGISTRO + """" + Datos(23) + """" + ","
        REGISTRO = REGISTRO + Datos(24) + ","
        'REGISTRO = REGISTRO + DATOS(25) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(25)))) + ","
        'REGISTRO = REGISTRO + DATOS(26) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(26)))) + ","
        'REGISTRO = REGISTRO + DATOS(27) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(27)))) + ","
        'REGISTRO = REGISTRO + DATOS(28) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(28)))) + ","
        REGISTRO = REGISTRO + Datos(29) + ","
        REGISTRO = REGISTRO + Format(Datos(30), "yyyy-mm-dd") + ","
        REGISTRO = REGISTRO + Format(Datos(31), "yyyy-mm-dd") + ","
        'REGISTRO = REGISTRO + DATOS(32) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(32)))) + ","
        REGISTRO = REGISTRO + """" + Datos(33) + """" + "," '
        'REGISTRO = REGISTRO + DATOS(34) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(34)))) + ","
        'REGISTRO = REGISTRO + DATOS(35) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(35)))) + ","
        'REGISTRO = REGISTRO + DATOS(36) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(36)))) + ","
        'REGISTRO = REGISTRO + DATOS(37) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(37)))) + ","
        'REGISTRO = REGISTRO + DATOS(38) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(38)))) + ","
        REGISTRO = REGISTRO + Format(Datos(39), "yyyy-mm-dd") + ","
        'REGISTRO = REGISTRO + DATOS(40) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(40)))) + ","
        'REGISTRO = REGISTRO + DATOS(41) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(41)))) + ","
        'REGISTRO = REGISTRO + DATOS(42) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(42)))) + ","
        'REGISTRO = REGISTRO + DATOS(43) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(43)))) + ","
        'REGISTRO = REGISTRO + DATOS(44) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(44)))) + ","
        REGISTRO = REGISTRO + """" + Datos(45) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(46) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(47) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(48) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(49) + """" + ","
        REGISTRO = REGISTRO + Format(Datos(50), "yyyy-mm-dd") + ","
        REGISTRO = REGISTRO + """" + Datos(51) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(52) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(53) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(54) + """" + ","
        'REGISTRO = REGISTRO + DATOS(55) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(55)))) + ","
        'REGISTRO = REGISTRO + DATOS(56) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(56)))) + ","
        REGISTRO = REGISTRO + Format(Datos(57), "yyyy-mm-dd") + ","
        'REGISTRO = REGISTRO + DATOS(58) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(58)))) + ","
        REGISTRO = REGISTRO + """" + Datos(59) + """" + ","
        REGISTRO = REGISTRO + Datos(60) + ","
        REGISTRO = REGISTRO + Datos(61) + ","
        REGISTRO = REGISTRO + Datos(62) + ","
        REGISTRO = REGISTRO + Datos(63) + ","
        REGISTRO = REGISTRO + Datos(64) + ","
        REGISTRO = REGISTRO + Datos(65) + ","
        REGISTRO = REGISTRO + Datos(66) + ","
        REGISTRO = REGISTRO + Datos(67) + ","
        REGISTRO = REGISTRO + Datos(68)
        Print #1, REGISTRO
        
        REGISTRO = ""
    Loop
        Close #1
    Reset


    Let Screen.MousePointer = vbDefault
    
    Let Genera_GENERA_DTS_GEN_MDCP = True

Exit Function
ErrorGeneracion_RMDCP_Unificado:

    If err.Number = 55 Then
        If MsgBox(err.Description & vbCrLf & vbCrLf & "Reintentar ?", vbExclamation + vbYesNo, App.Title) = vbYes Then
            Reset
            Resume
        End If
    End If

    Let Screen.MousePointer = vbDefault
   Call MsgBox("E - Err. en Interfaz RMDCP" & vbCrLf & vbCrLf & "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "ERROR EN GENERACION RMDCP. ")

End Function


Public Function Genera_GENERA_DTS_MDVI(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByVal oFechaGeneracion As Date) As Boolean
    On Error GoTo ErrorGeneracion_RMDVI_Unificado
    Dim Datos()
    Dim nNumFile
    Dim REGISTRO      As String
    
    Let Genera_GENERA_DTS_MDVI = False
    
    Let Screen.MousePointer = vbHourglass

    If Not Right(cPathFile, 1) = "\" Then
        Let cPathFile = cPathFile & "\"
    End If
    
    Let cPathFile = cPathFile & cNomFile

    If Len(Dir(cPathFile)) > 0 Then
        Call Kill(cPathFile)
    End If

    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_GENERA_DTS_RENTA_MDVI_4") Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Interfaz Renta Gen Cap" & vbCrLf & "Ha ocurrido un error al intentar generar la interfaz D16-D17", vbCritical, App.Title)
        Exit Function
    End If

    nombre_arch = cPathFile
    Open nombre_arch For Output As #1
         REGISTRO = ""
            REGISTRO = REGISTRO + """" + "virutcart" + """" + ","
            REGISTRO = REGISTRO + """" + "vinumdocu" + """" + ","
            REGISTRO = REGISTRO + """" + "vicorrela" + """" + ","
            REGISTRO = REGISTRO + """" + "vinumoper" + """" + ","
            REGISTRO = REGISTRO + """" + "vitipoper" + """" + ","
            REGISTRO = REGISTRO + """" + "virutcli" + """" + ","
            REGISTRO = REGISTRO + """" + "vicodcli" + """" + ","
            REGISTRO = REGISTRO + """" + "viinstser" + """" + ","
            REGISTRO = REGISTRO + """" + "vinominal" + """" + ","
            REGISTRO = REGISTRO + """" + "vifecinip" + """" + ","
            REGISTRO = REGISTRO + """" + "vifecvenp" + """" + ","
            REGISTRO = REGISTRO + """" + "vivalinip" + """" + ","
            REGISTRO = REGISTRO + """" + "vivalvenp" + """" + ","
            REGISTRO = REGISTRO + """" + "vitaspact" + """" + ","
            REGISTRO = REGISTRO + """" + "vibaspact" + """" + ","
            REGISTRO = REGISTRO + """" + "vimonpact" + """" + ","
            REGISTRO = REGISTRO + """" + "vivptirc" + """" + ","
            REGISTRO = REGISTRO + """" + "vivptirci" + """" + ","
            REGISTRO = REGISTRO + """" + "vivptirv" + """" + ","
            REGISTRO = REGISTRO + """" + "vivptirvi" + """" + ","
            REGISTRO = REGISTRO + """" + "vivalcomu" + """" + ","
            REGISTRO = REGISTRO + """" + "vivalcomp" + """" + ","
            REGISTRO = REGISTRO + """" + "vicapitalv" + """" + ","
            REGISTRO = REGISTRO + """" + "viinteresv" + """" + ","
            REGISTRO = REGISTRO + """" + "vireajustv" + """" + ","
            REGISTRO = REGISTRO + """" + "viintermesv" + """" + ","
            REGISTRO = REGISTRO + """" + "vireajumesv" + """" + ","
            REGISTRO = REGISTRO + """" + "vicapitalvi" + """" + ","
            REGISTRO = REGISTRO + """" + "viinteresvi" + """" + ","
            REGISTRO = REGISTRO + """" + "vireajustvi" + """" + ","
            REGISTRO = REGISTRO + """" + "viintermesvi" + """" + ","
            REGISTRO = REGISTRO + """" + "vireajumesvi" + """" + ","
            REGISTRO = REGISTRO + """" + "vivalvent" + """" + ","
            REGISTRO = REGISTRO + """" + "vivvum100" + """" + ","
            REGISTRO = REGISTRO + """" + "vivalvemu" + """" + ","
            REGISTRO = REGISTRO + """" + "vitirvent" + """" + ","
            REGISTRO = REGISTRO + """" + "vitasest" + """" + ","
            REGISTRO = REGISTRO + """" + "vipvpvent" + """" + ","
            REGISTRO = REGISTRO + """" + "vivpvent" + """" + ","
            REGISTRO = REGISTRO + """" + "vinumucupc" + """" + ","
            REGISTRO = REGISTRO + """" + "vinumucupv" + """" + ","
            REGISTRO = REGISTRO + """" + "virutemi" + """" + ","
            REGISTRO = REGISTRO + """" + "vimonemi" + """" + ","
            REGISTRO = REGISTRO + """" + "vifecemi" + """" + ","
            REGISTRO = REGISTRO + """" + "vifecven" + """" + ","
            REGISTRO = REGISTRO + """" + "vifecucup" + """" + ","
            REGISTRO = REGISTRO + """" + "vicodigo" + """" + ","
            REGISTRO = REGISTRO + """" + "vitircomp" + """" + ","
            REGISTRO = REGISTRO + """" + "vifeccomp" + """" + ","
            REGISTRO = REGISTRO + """" + "viseriado" + """" + ","
            REGISTRO = REGISTRO + """" + "vimascara" + """" + ","
            REGISTRO = REGISTRO + """" + "vivalinipci" + """" + ","
            REGISTRO = REGISTRO + """" + "vivalvenpci" + """" + ","
            REGISTRO = REGISTRO + """" + "vifecinipci" + """" + ","
            REGISTRO = REGISTRO + """" + "vifecvenpci" + """" + ","
            REGISTRO = REGISTRO + """" + "vitaspactci" + """" + ","
            REGISTRO = REGISTRO + """" + "vibaspactci" + """" + ","
            REGISTRO = REGISTRO + """" + "viinteresci" + """" + ","
            REGISTRO = REGISTRO + """" + "vicorvent" + """" + ","
            REGISTRO = REGISTRO + """" + "vinominalp" + """" + ","
            REGISTRO = REGISTRO + """" + "viforpagi" + """" + ","
            REGISTRO = REGISTRO + """" + "viforpagv" + """" + ","
            REGISTRO = REGISTRO + """" + "vicorrvent" + """" + ","
            REGISTRO = REGISTRO + """" + "vifecpcup" + """" + ","
            REGISTRO = REGISTRO + """" + "vivcompori" + """" + ","
            REGISTRO = REGISTRO + """" + "vivpcomp" + """" + ","
            REGISTRO = REGISTRO + """" + "vidurat" + """" + ","
            REGISTRO = REGISTRO + """" + "vidurmod" + """" + ","
            REGISTRO = REGISTRO + """" + "viconvex" + """" + ","
            REGISTRO = REGISTRO + """" + "viintacumcp" + """" + ","
            REGISTRO = REGISTRO + """" + "vireacumcp" + """" + ","
            REGISTRO = REGISTRO + """" + "viintacumvi" + """" + ","
            REGISTRO = REGISTRO + """" + "vireacumvi" + """" + ","
            REGISTRO = REGISTRO + """" + "viintacumci" + """" + ","
            REGISTRO = REGISTRO + """" + "vireacumci" + """" + ","
            REGISTRO = REGISTRO + """" + "fecha_compra_original" + """" + ","
            REGISTRO = REGISTRO + """" + "valor_compra_original" + """" + ","
            REGISTRO = REGISTRO + """" + "valor_compra_um_original" + """" + ","
            REGISTRO = REGISTRO + """" + "tir_compra_original" + """" + ","
            REGISTRO = REGISTRO + """" + "valor_par_compra_original" + """" + ","
            REGISTRO = REGISTRO + """" + "porcentaje_valor_par_compra_original" + """" + ","
            REGISTRO = REGISTRO + """" + "codigo_carterasuper" + """" + ","
            REGISTRO = REGISTRO + """" + "Tipo_Cartera_Financiera" + """" + ","
            REGISTRO = REGISTRO + """" + "Mercado" + """" + ","
            REGISTRO = REGISTRO + """" + "Sucursal" + """" + ","
            REGISTRO = REGISTRO + """" + "Id_Sistema" + """" + ","
            REGISTRO = REGISTRO + """" + "Fecha_PagoMañana" + """" + ","
            REGISTRO = REGISTRO + """" + "Laminas" + """" + ","
            REGISTRO = REGISTRO + """" + "Tipo_Inversion" + """" + ","
            REGISTRO = REGISTRO + """" + "Cuenta_Corriente_Inicio" + """" + ","
            REGISTRO = REGISTRO + """" + "Cuenta_Corriente_Final" + """" + ","
            REGISTRO = REGISTRO + """" + "Sucursal_Inicio" + """" + ","
            REGISTRO = REGISTRO + """" + "Sucursal_Final" + """" + ","
            REGISTRO = REGISTRO + """" + "Tasa_Contrato" + """" + ","
            REGISTRO = REGISTRO + """" + "Valor_Contable" + """" + ","
            REGISTRO = REGISTRO + """" + "Fecha_Contrato" + """" + ","
            REGISTRO = REGISTRO + """" + "Numero_Contrato" + """" + ","
            REGISTRO = REGISTRO + """" + "Tipo_Rentabilidad" + """" + ","
            REGISTRO = REGISTRO + """" + "Ejecutivo" + """" + ","
            REGISTRO = REGISTRO + """" + "Tipo_Custodia" + """" + ","
            REGISTRO = REGISTRO + """" + "vivptasemi" + """" + ","
            REGISTRO = REGISTRO + """" + "vimtoadif" + """" + ","
            REGISTRO = REGISTRO + """" + "Capital_Tasa_Emi" + """" + ","
            REGISTRO = REGISTRO + """" + "Intereses_Tasa_Emi" + """" + ","
            REGISTRO = REGISTRO + """" + "Reajustes_Tasa_Emi" + """"
    
    
    Print #1, REGISTRO
    REGISTRO = ""
    Do While Bac_SQL_Fetch(Datos())
                
        REGISTRO = REGISTRO + Datos(1) + ","
        REGISTRO = REGISTRO + Datos(2) + ","
        REGISTRO = REGISTRO + Datos(3) + ","
        REGISTRO = REGISTRO + Datos(4) + ","
        REGISTRO = REGISTRO + """" + Datos(5) + """" + ","
        REGISTRO = REGISTRO + Datos(6) + ","
        REGISTRO = REGISTRO + Datos(7) + ","
        REGISTRO = REGISTRO + """" + Datos(8) + """" + ","
        'REGISTRO = REGISTRO + DATOS(9) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(9)))) + ","
        REGISTRO = REGISTRO + Format(Datos(10), "yyyy-mm-dd") + ","
        REGISTRO = REGISTRO + Format(Datos(11), "yyyy-mm-dd") + ","
        'REGISTRO = REGISTRO + DATOS(12) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(12)))) + ","
        'REGISTRO = REGISTRO + DATOS(13) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(13)))) + ","
        'REGISTRO = REGISTRO + DATOS(14) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(14)))) + ","
        REGISTRO = REGISTRO + Datos(15) + ","
        REGISTRO = REGISTRO + Datos(16) + ","
        'REGISTRO = REGISTRO + DATOS(17) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(17)))) + ","
        'REGISTRO = REGISTRO + DATOS(18) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(18)))) + ","
        'REGISTRO = REGISTRO + DATOS(19) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(19)))) + ","
        'REGISTRO = REGISTRO + DATOS(20) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(20)))) + ","
        'REGISTRO = REGISTRO + DATOS(21) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(21)))) + ","
        'REGISTRO = REGISTRO + DATOS(22) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(22)))) + ","
        'REGISTRO = REGISTRO + DATOS(23) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(23)))) + ","
        'REGISTRO = REGISTRO + DATOS(24) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(24)))) + ","
        'REGISTRO = REGISTRO + DATOS(25) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(25)))) + ","
        'REGISTRO = REGISTRO + DATOS(26) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(26)))) + ","
        'REGISTRO = REGISTRO + DATOS(27) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(27)))) + ","
        'REGISTRO = REGISTRO + DATOS(28) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(28)))) + ","
        'REGISTRO = REGISTRO + DATOS(29) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(29)))) + ","
        'REGISTRO = REGISTRO + DATOS(30) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(30)))) + ","
        'REGISTRO = REGISTRO + DATOS(31) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(31)))) + ","
        'REGISTRO = REGISTRO + DATOS(32) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(32)))) + ","
        'REGISTRO = REGISTRO + DATOS(33) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(33)))) + ","
        'REGISTRO = REGISTRO + DATOS(34) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(34)))) + ","
        'REGISTRO = REGISTRO + DATOS(35) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(35)))) + ","
        'REGISTRO = REGISTRO + DATOS(36) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(36)))) + ","
        'REGISTRO = REGISTRO + DATOS(37) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(37)))) + ","
        'REGISTRO = REGISTRO + DATOS(38) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(38)))) + ","
        'REGISTRO = REGISTRO + DATOS(39) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(39)))) + ","
        REGISTRO = REGISTRO + Datos(40) + ","
        REGISTRO = REGISTRO + Datos(41) + ","
        REGISTRO = REGISTRO + Datos(42) + ","
        REGISTRO = REGISTRO + Datos(43) + ","
        REGISTRO = REGISTRO + Format(Datos(44), "yyyy-mm-dd") + ","
        REGISTRO = REGISTRO + Format(Datos(45), "yyyy-mm-dd") + ","
        REGISTRO = REGISTRO + Format(Datos(46), "yyyy-mm-dd") + ","
        REGISTRO = REGISTRO + Datos(47) + ","
        'REGISTRO = REGISTRO + DATOS(48) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(48)))) + ","
        REGISTRO = REGISTRO + Format(Datos(49), "yyyy-mm-dd") + ","
        REGISTRO = REGISTRO + """" + Datos(50) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(51) + """" + ","
        'REGISTRO = REGISTRO + DATOS(52) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(52)))) + ","
        'REGISTRO = REGISTRO + DATOS(53) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(53)))) + ","
        If Datos(54) = "01-01-1900" Then
            REGISTRO = REGISTRO + ","
        Else
            REGISTRO = REGISTRO + Format(Datos(54), "yyyy-mm-dd") + ","
        End If
        If Datos(55) = "01-01-1900" Then
            REGISTRO = REGISTRO + ","
        Else
            REGISTRO = REGISTRO + Format(Datos(55), "yyyy-mm-dd") + ","
        End If
        'REGISTRO = REGISTRO + DATOS(56) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(56)))) + ","
        REGISTRO = REGISTRO + Datos(57) + ","
        'REGISTRO = REGISTRO + DATOS(58) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(58)))) + ","
        REGISTRO = REGISTRO + Datos(59) + ","
        REGISTRO = REGISTRO + Datos(60) + ","
        REGISTRO = REGISTRO + Datos(61) + ","
        REGISTRO = REGISTRO + Datos(62) + ","
        REGISTRO = REGISTRO + Datos(63) + ","
        REGISTRO = REGISTRO + Format(Datos(64), "yyyy-mm-dd") + ","
        'REGISTRO = REGISTRO + DATOS(65) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(65)))) + ","
        'REGISTRO = REGISTRO + DATOS(66) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(66)))) + ","
        'REGISTRO = REGISTRO + DATOS(67) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(67)))) + ","
        'REGISTRO = REGISTRO + DATOS(68) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(68)))) + ","
        'REGISTRO = REGISTRO + DATOS(69) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(69)))) + ","
        'REGISTRO = REGISTRO + DATOS(70) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(70)))) + ","
        'REGISTRO = REGISTRO + DATOS(71) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(71)))) + ","
        'REGISTRO = REGISTRO + DATOS(72) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(72)))) + ","
        'REGISTRO = REGISTRO + DATOS(73) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(73)))) + ","
        'REGISTRO = REGISTRO + DATOS(74) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(74)))) + ","
        'REGISTRO = REGISTRO + DATOS(75) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(75)))) + ","
        REGISTRO = REGISTRO + Format(Datos(76), "yyyy-mm-dd") + ","
        'REGISTRO = REGISTRO + DATOS(77) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(77)))) + ","
        'REGISTRO = REGISTRO + DATOS(78) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(78)))) + ","
        'REGISTRO = REGISTRO + DATOS(79) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(79)))) + ","
        'REGISTRO = REGISTRO + DATOS(80) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(80)))) + ","
        'REGISTRO = REGISTRO + DATOS(81) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(81)))) + ","
        REGISTRO = REGISTRO + """" + Datos(82) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(83) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(84) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(85) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(86) + """" + ","
        REGISTRO = REGISTRO + Format(Datos(87), "yyyy-mm-dd") + ","
        REGISTRO = REGISTRO + """" + Datos(88) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(89) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(90) + """" + ","
        'REGISTRO = REGISTRO + Reemplaza_Coma_Punto(Trim(Str(DATOS(90)))) + ","
        REGISTRO = REGISTRO + """" + Datos(91) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(92) + """" + ","
        REGISTRO = REGISTRO + """" + Datos(93) + """" + ","
        'REGISTRO = REGISTRO + DATOS(94) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(94)))) + ","
        'REGISTRO = REGISTRO + DATOS(95) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(95)))) + ","
        If Datos(54) = "01-01-1900" Then
            REGISTRO = REGISTRO + ","
        Else
            REGISTRO = REGISTRO + Format(Datos(96), "yyyy-mm-dd") + ","
        End If
        'REGISTRO = REGISTRO + DATOS(97) + ","
        REGISTRO = REGISTRO + REEMPLAZA_COMA_PUNTO(Trim(Str(Datos(97)))) + ","
        REGISTRO = REGISTRO + """" + Datos(98) + """" + ","
        REGISTRO = REGISTRO + Datos(99) + ","
        REGISTRO = REGISTRO + Datos(100) + ","
        REGISTRO = REGISTRO + Datos(101) + ","
        REGISTRO = REGISTRO + Datos(102) + ","
        REGISTRO = REGISTRO + Datos(103) + ","
        REGISTRO = REGISTRO + Datos(104) + ","
        REGISTRO = REGISTRO + Datos(105)
        Print #1, REGISTRO
        
        REGISTRO = ""
    Loop
        Close #1
    Reset


    Let Screen.MousePointer = vbDefault
    
    Let Genera_GENERA_DTS_MDVI = True

Exit Function
ErrorGeneracion_RMDVI_Unificado:

    If err.Number = 55 Then
        If MsgBox(err.Description & vbCrLf & vbCrLf & "Reintentar ?", vbExclamation + vbYesNo, App.Title) = vbYes Then
            Reset
            Resume
        End If
    End If

    Let Screen.MousePointer = vbDefault
   Call MsgBox("E - Err. en Interfaz RMDVI" & vbCrLf & vbCrLf & "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "ERROR EN GENERACION RMDVI. ")

End Function

Private Function REEMPLAZA_COMA_PUNTO(cValor As String) As String
Dim xvar As String

    If Len(cValor) = 1 Then
        xvar = cValor
        
    Else
        If InStr(cValor, ".") > 1 Then
            xvar = Replace(cValor, ",", ".")

        Else
            If InStr(cValor, ".") = 0 Then
                xvar = Replace(cValor, ",", ".")
            Else
                xvar = "0" + Replace(cValor, ",", ".")
            End If
        End If
        'xvar = Replace(cValor, ",", ".")
    End If
       

    REEMPLAZA_COMA_PUNTO = xvar

End Function

''===========================================================
'' LD1-COR-035-Configuración BAC Corpbanca, Tema: INTERFACES
'' FIN
''===========================================================


'---------------------------------------------------------------------------------
'-------------------------------INICIO FUSÍON-------------------------------------
'-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------
'---------------------------------------------------------------------------------

Public Function Genera_BACEN(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByVal oFechaGeneracion As Date) As Boolean
    On Error GoTo ErrorGeneracion_Bacen_Unificado
    'Dim Datos()
    'Dim nNumFile
    'Dim REGISTRO      As String
           
    Dim sPath
    Dim Comando$
    Dim nombre_arch$
    Dim REGISTRO
    Dim Datos()
    Dim datos1()
    Dim El_Path As String
    
    'verifica si es fin de mes
    Dim Fecha_Proceso_Dev      As String         'Fecha Proceso del devengo
    Dim Fecha_Proximo_Dev      As String         'Fecha Proximo Proceso del devengo
    Dim Fecha_Cierre_Mes       As String         'Cierre de Mes
    Dim Fecha_Proceso          As String         'Fecha Proceso
    Dim Fecha_Proximo_Proceso  As String         'Fecha Proximo Proceso
    
     
    Let Genera_BACEN = False

    Let Screen.MousePointer = vbHourglass
    
    If Not Right(cPathFile, 1) = "\" Then
        Let cPathFile = cPathFile & "\"
    End If
    
    Let cPathFile = cPathFile & cNomFile
   
    If Bac_Sql_Execute("sp_chkfechasdevengamiento") Then
        Do While Bac_SQL_Fetch(Datos())
            Fecha_Proceso = Datos(1)
            Fecha_Proximo_Proceso = Datos(2)
            Fecha_Cierre_Mes = Datos(3)
        Loop
    End If
        
    '------------------------------------------------------------------------------------
    ' Genera archivo bacen diario, que contiene operaciones de ventas propias del día
    '------------------------------------------------------------------------------------
    
    nombre_arch = cPathFile + "_INGRESO_" + Format(gsBac_Fecp, "YYYYMMDD") + ".CSV"
    
    If Len(Dir(nombre_arch)) > 0 Then
        Call Kill(nombre_arch)
    End If
    
    Comando$ = ""
    Comando$ = "Sp_genera_interfaz_BACEN_ingresos"
    
    If Not Bac_Sql_Execute(Comando$) Then
        MsgBox "problema al Ejecutar Activos"
        'Exit Sub
    End If

    Open nombre_arch For Output As #1
    
    REGISTRO = ""
        REGISTRO = REGISTRO + "Nr controle dado instituição financeira" + ","
        REGISTRO = REGISTRO + "TipO operação" + ","
        REGISTRO = REGISTRO + "Identificador Captação" + ","
        REGISTRO = REGISTRO + "Data da captação" + ","
        REGISTRO = REGISTRO + "Devedor (CNPJ)" + ","
        REGISTRO = REGISTRO + "Pais do Devedor" + ","
        REGISTRO = REGISTRO + "Credor" + ","
        REGISTRO = REGISTRO + "Indicador de operação intraconglomerado" + ","
        REGISTRO = REGISTRO + "Indicador de operação intragrupo financeiro" + ","
        REGISTRO = REGISTRO + "Moeda" + ","
        REGISTRO = REGISTRO + "Valor da captação" + ","
        REGISTRO = REGISTRO + "Indicador de Captação sem vencimento de principal" + ","
        REGISTRO = REGISTRO + "Data de vencimento prevista da parcela principal" + ","
        REGISTRO = REGISTRO + "valor previsto para parcela de principal" + ","
        REGISTRO = REGISTRO + "Tipo de Juros" + ","
        REGISTRO = REGISTRO + "Código da taxa pós fixada" + ","
        REGISTRO = REGISTRO + "Spread da taxa pós-fixada" + ","
        REGISTRO = REGISTRO + "Custo total na data da captação Modalidadede origem" + ","
        REGISTRO = REGISTRO + "Destinação" + ","
        REGISTRO = REGISTRO + "Conta Cosif" + ","
        REGISTRO = REGISTRO + "Observações"
    
    
    Print #1, REGISTRO
    REGISTRO = ""
    Do While Bac_SQL_Fetch(Datos())

        REGISTRO = REGISTRO + Datos(1) + ","
        REGISTRO = REGISTRO + Datos(2) + ","
        REGISTRO = REGISTRO + Datos(3) + ","
        REGISTRO = REGISTRO + Datos(4) + ","
        REGISTRO = REGISTRO + Datos(5) + ","
        REGISTRO = REGISTRO + Datos(6) + ","
        REGISTRO = REGISTRO + Datos(7) + ","
        REGISTRO = REGISTRO + Datos(8) + ","
        REGISTRO = REGISTRO + Datos(9) + ","
        REGISTRO = REGISTRO + Datos(10) + ","
        REGISTRO = REGISTRO + Datos(11) + ","
        REGISTRO = REGISTRO + Datos(12) + ","
        REGISTRO = REGISTRO + Datos(13) + ","
        REGISTRO = REGISTRO + Datos(14) + ","
        REGISTRO = REGISTRO + Datos(15) + ","
        REGISTRO = REGISTRO + Datos(16) + ","
        REGISTRO = REGISTRO + Datos(17) + ","
        REGISTRO = REGISTRO + Datos(18) + ","
        REGISTRO = REGISTRO + Datos(19) + ","
        REGISTRO = REGISTRO + Datos(20) + ","
        REGISTRO = REGISTRO + Datos(21)
        
        Print #1, REGISTRO
        REGISTRO = ""
    Loop
       
        Close #1
    Reset

    '---------------------------------
    ' interfaz de vencimientos
    '---------------------------------
   
    nombre_arch = cPathFile + "_VENCIMIENTO_" + Format(gsBac_Fecp, "YYYYMMDD") + ".CSV"
    
    If Len(Dir(nombre_arch)) > 0 Then
        Call Kill(nombre_arch)
    End If
    
    Comando$ = ""
    Comando$ = "Sp_genera_interfaz_BACEN_vencimientos"
    
    If Not Bac_Sql_Execute(Comando$) Then
        MsgBox "problema al Ejecutar Activos"
        'Exit Sub
    End If
    
    Open nombre_arch For Output As #1
        
        REGISTRO = ""
        REGISTRO = REGISTRO + "Nr controle dado instituição financeira" + ","
        REGISTRO = REGISTRO + "Numero Captação" + ","
        REGISTRO = REGISTRO + "Data do Pagamento" + ","
        REGISTRO = REGISTRO + "Parcela de Principal sendo paga" + ","
        REGISTRO = REGISTRO + "Data principal recebendo pagamento" + ","
        REGISTRO = REGISTRO + "Valor sendo pago para a parcela"
        
    
        Print #1, REGISTRO
        REGISTRO = ""
    
    Do While Bac_SQL_Fetch(Datos())

        REGISTRO = REGISTRO + Datos(1) + ","
        REGISTRO = REGISTRO + Datos(2) + ","
        REGISTRO = REGISTRO + Datos(3) + ","
        REGISTRO = REGISTRO + Datos(4) + ","
        REGISTRO = REGISTRO + Datos(5) + ","
        REGISTRO = REGISTRO + Datos(6)
        
        Print #1, REGISTRO
        REGISTRO = ""
    Loop
        Close #1
    Reset


        
    If Month(Fecha_Proceso) <> Month(Fecha_Proximo_Proceso) Then

        '----------------------------------------------------------
        ' interfaz de mensual sólo generada para un fin de mes
        '----------------------------------------------------------

        nombre_arch = cPathFile + "_MENSUAL_" + Format(gsBac_Fecp, "YYYYMMDD") + ".CSV"

        If Len(Dir(nombre_arch)) > 0 Then
            Call Kill(nombre_arch)
        End If

        Comando$ = ""
        Comando$ = "Sp_genera_interfaz_BACEN_mensual"

        If Not Bac_Sql_Execute(Comando$) Then
            MsgBox "problema al Ejecutar Activos"
            'Exit Sub
        End If

        Open nombre_arch For Output As #1
            REGISTRO = ""
            REGISTRO = REGISTRO + "Nr controle dado instituição financeira" + ","
            REGISTRO = REGISTRO + "Devedor (CNPJ)" + ","
            REGISTRO = REGISTRO + "Data estoque" + ","
            REGISTRO = REGISTRO + "Moeda do estoque" + ","
            REGISTRO = REGISTRO + "Valor do estoque"



            Print #1, REGISTRO
            REGISTRO = ""
        Do While Bac_SQL_Fetch(Datos())

            REGISTRO = REGISTRO + Datos(1) + ","
            REGISTRO = REGISTRO + Datos(2) + ","
            REGISTRO = REGISTRO + Datos(3) + ","
            REGISTRO = REGISTRO + Datos(4) + ","
            REGISTRO = REGISTRO + Datos(5)


            Print #1, REGISTRO
            REGISTRO = ""
        Loop
            Close #1

    End If


    Let Screen.MousePointer = vbDefault
    
    Let Genera_BACEN = True

Exit Function
ErrorGeneracion_Bacen_Unificado:

    If err.Number = 55 Then
        If MsgBox(err.Description & vbCrLf & vbCrLf & "Reintentar ?", vbExclamation + vbYesNo, App.Title) = vbYes Then
            Reset
            Resume
        End If
    End If

    Let Screen.MousePointer = vbDefault
   Call MsgBox("E - Err. en Interfaz RMDVI" & vbCrLf & vbCrLf & "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "ERROR EN GENERACION RMDVI. ")


End Function
'---------------------------------------------------------------------------------
'-------------------------------FIN FUSÍON----------------------------------------
'-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------
'---------------------------------------------------------------------------------


Public Function Insterfaz_SOS_RutaAlterna(ByVal oSigla As String, ByVal dFecha As Date) As String
    On Error GoTo ErrPathSOS
    Dim cPathFile   As String
    Dim cFileName   As String
    Dim cFormatFile As String
    Dim oPathFile   As String

      Let cPathFile = UCase(Func_Read_INI("SOS", "SOS_PathFile_Respaldo", App.Path & "\" & "Bac-Sistemas.ini"))
    Let cFormatFile = UCase(Func_Read_INI("SOS", "SOS_FORMATO_RESPALDO", App.Path & "\" & "Bac-Sistemas.ini"))
        
    If Mid(oSigla, 1, InStr(1, oSigla, ".") - 1) = "MESTRN" Then
        Let cFileName = UCase(Func_Read_INI("SOS", "SOS_File_MESTRN", App.Path & "\" & "Bac-Sistemas.ini"))
    End If
    If Mid(oSigla, 1, InStr(1, oSigla, ".") - 1) = "MESCTACL" Then
        Let cFileName = UCase(Func_Read_INI("SOS", "SOS_File_MESCTACL", App.Path & "\" & "Bac-Sistemas.ini"))
    End If
    If Mid(oSigla, 1, InStr(1, oSigla, ".") - 1) = "MESCLI" Then
        Let cFileName = UCase(Func_Read_INI("SOS", "SOS_File_MESCLI", App.Path & "\" & "Bac-Sistemas.ini"))
    End If
    If Mid(oSigla, 1, InStr(1, oSigla, ".") - 1) = "MESOFC" Then
        Let cFileName = UCase(Func_Read_INI("SOS", "SOS_File_MESOFC", App.Path & "\" & "Bac-Sistemas.ini"))
    End If

    Let cFormatFile = Format(dFecha, cFormatFile)
    Let cFileName = Mid(cFileName, 1, InStr(1, cFileName, ".") - 1) & cFormatFile & Mid(cFileName, InStr(1, cFileName, "."))

    Let oPathFile = cPathFile
    If Not Right(oPathFile, 1) = "\" Then
        Let oPathFile = oPathFile & "\"
    End If
    
    Let oPathFile = oPathFile & cFileName
    
    If Interfaz_SOS_LimpiaArchivos(oPathFile) = False Then
        Exit Function
    End If
   'If Len(Dir(oPathFile)) > 0 Then
   '    Call Kill(oPathFile)
   'End If

    Let Insterfaz_SOS_RutaAlterna = oPathFile

    On Error GoTo 0
Exit Function
ErrPathSOS:

    Let Insterfaz_SOS_RutaAlterna = "C:\"

    On Error GoTo 0

End Function

Public Function Interfaz_SOS_LimpiaArchivos(ByVal oPathFileString As String) As Boolean
    On Error GoTo ErrorDropFile
    Let Interfaz_SOS_LimpiaArchivos = False
    
    If Len(Dir(oPathFileString)) > 0 Then
        Call Kill(oPathFileString)
    End If

    Let Interfaz_SOS_LimpiaArchivos = True
    
    On Error GoTo 0
Exit Function
ErrorDropFile:

    If err.Number = 75 Then
        Call MsgBox("Err. " & Trim(err.Number) & vbCrLf & vbCrLf & "Ruta de Archivo no ha sido encontrada o no los tiene parmisos requeridos para esta acción", vbExclamation, App.Title)
    Else
        Call MsgBox("Err. " & Trim(err.Number) & vbCrLf & vbCrLf & err.Description, vbExclamation, App.Title)
    End If

    On Error GoTo 0
        
End Function

Public Function Interfaz_SOS_MAESTRN(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByVal dFecha As Date) As Boolean
    On Error GoTo ErrorEscritura_Sos
    Dim nRegistros      As Long
    Dim nRegistro       As Long
    Dim oPathFile       As String
    Dim ooPathFile      As String
    Dim cLinea          As String
    Dim cSqlDatos()
    Dim nNumFile
    Dim nnNumFile
    
    Let Interfaz_SOS_MAESTRN = False
    Let Screen.MousePointer = vbHourglass

    Let oPathFile = cPathFile
    If Not Right(oPathFile, 1) = "\" Then
        Let oPathFile = oPathFile & "\"
    End If
    
    Let oPathFile = oPathFile & cNomFile
    
    If Interfaz_SOS_LimpiaArchivos(oPathFile) = False Then
        Let Screen.MousePointer = vbDefault
        Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "MESTRN", 0, 0, 0, "Error en tratar de limpiar archivo en el destino.", True)
        Exit Function
    End If

    Let ooPathFile = Insterfaz_SOS_RutaAlterna(cNomFile, dFecha)

    Envia = Array()
    AddParam Envia, Format(dFecha, "yyyymmdd")
    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Genera_Interfaz_SOS_Mestrn", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call BacParcelaInterfaz.FuncInsertMsgError("BTR", "MESTRN", 0, 0, 0, "Error procesar consulta [BacParamSuda.dbo.Sp_Genera_Interfaz_SOS_Mestrn]", True)
        Call MsgBox("Interfaz " & cNomFile & vbCrLf & "Ha ocurrido un error al intentar generar la interfaz.", vbCritical, App.Title)
        Exit Function
    End If

    Let nRegistros = -1
    Let nRegistro = 0


    Let nNumFile = FreeFile
    Open oPathFile For Append As #nNumFile

    Let nnNumFile = FreeFile
    Open ooPathFile For Append As #nnNumFile

    Do While Bac_SQL_Fetch(cSqlDatos())
        Let cLinea = ""
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(1)), 2, 0)            '-> 01 - IDENTIFICACIONDELCLIENTETIPO    [01 = RUT; 02 = PASAPORTE]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(2)), 15, 0)           '-> 02 - IDENTIFICADORDELCLIENTENUMERO   [RUT CLIENTE]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(3)), 1, 0)            '-> 03 - NUMTRANSACCION                  [CARGO = 0/ ABONO = 5]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(4)), 2, 0)            '-> 04 - CODIGOTRANSACCION               [Tipo Operacion Truncado a 2]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(5)), 2, 0)            '-> 05 - DISPONIBLE                      [2 ESPACIOS]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(6)), 1, 0)            '-> 06 - ORIGENDELOSFONDOS               [0 = EFECTIVO; 9 = DOCUMENTOS]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(7)), 10, 0)           '-> 07 - DISPONIBLE                      [10 ESPACIOS]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(8)), 4, 0)            '-> 08 - TIPOOPERACION                   [Tabla de Productos]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, CDbl(cSqlDatos(9)), 15, 0)           '-> 09 - NUMERODEOPERACION               [Numero de la Operacion]
        Let cLinea = cLinea & fCampoInterfaz([Fecha DDMMYYYY], Trim(cSqlDatos(10)), 8, 0)   '-> 10 - FECHADELAINFORMACION            [Fecha de la Informacion]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, CDbl(cSqlDatos(11)), 17, 2)          '-> 11 - MONTOENPESOS                    [Monto en Pesos]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, CDbl(cSqlDatos(12)), 17, 2)          '-> 12 - MONTOENUF                       [Monto en UF]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(13)), 12, 0)          '-> 13 - OFICIALCUENTA                   [Codigo Ejecutivo Truncado a 12]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(14)), 17, 0)          '-> 14 - NUMEROCHEQUE                    [Cheque Bancario]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(15)), 4, 0)           '-> 15 - TIPOCUENTA                      [Tabla de Modulos]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, CDbl(cSqlDatos(16)), 20, 0)          '-> 16 - NUMEROCUENTA                    [cuenta corriente]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, CDbl(cSqlDatos(17)), 17, 0)          '-> 17 - ESPECIETRANSADACANTIDAD         [Monto de la operacion en Moneda Origen]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(18)), 3, 0)           '-> 18 - ESPECIETRANSADATIPO             [Moneda de Origen de la Operacion]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(19)), 5, 0)           '-> 19 - CAUSAL                          [DB = Deposito; TH = Compra/Venta; DB = Giro]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(20)), 20, 0)          '-> 20 - BENEFICIARIODELEXTE             [20 ESPACIOS - Rut del Beneficiario Ordenante]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(21)), 19, 0)          '-> 21 - PAISBENEFICIARIOORDENANTE       [19 ESPACIOS - Nombre del Beneficiario Ordenante]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(22)), 1, 0)           '-> 22 - MEDIOPAGO                       [Medio de Pago]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(23)), 3, 0)           '-> 23 - SUCURSAL                        [001 - Valor por Defecto]
        Let cLinea = cLinea & fCampoInterfaz([Fecha DDMMYYYY], Trim(cSqlDatos(24)), 8, 0)   '-> 24 - FECHADELAOPERACION              [Fecha de la Operacion]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(25)), 7, 0)           '-> 25 - CODUSUARIO                      [Id del usuario]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(26)), 4, 0)           '-> 26 - EMPRESA                         [0050 - Valor por Defecto]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(27)), 12, 0)          '-> 27 - BANCOCORRESPONSAL               [12 ESPACIOS]
        
        Print #nNumFile, cLinea
        Print #nnNumFile, cLinea
        
        Let nRegistros = cSqlDatos(28)  '--> Cantidad de Registros
         Let nRegistro = nRegistro + 1
        Call Interfaz_SOS_Control_Progress(nProgress, nRegistros, nRegistro)
    Loop

    Close #nNumFile
    Close #nnNumFile

    Let Screen.MousePointer = vbDefault
    Let Interfaz_SOS_MAESTRN = True

    On Error GoTo 0

Exit Function
ErrorEscritura_Sos:
    Let Screen.MousePointer = vbDefault

    Call MsgBox("Err. " & err.Number & vbCrLf & vbCrLf & err.Description, App.Title)

    On Error GoTo 0
End Function


Public Function Interfaz_SOS_MESCTACL(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByVal dFecha As Date) As Boolean
    On Error GoTo ErrorEscritura_Sos
    Dim nRegistros      As Long
    Dim nRegistro       As Long
    Dim oPathFile       As String
    Dim ooPathFile      As String
    Dim cLinea          As String
    Dim cSqlDatos()
    Dim nNumFile
    Dim nnNumFile
    
    Let Interfaz_SOS_MESCTACL = False
    Let Screen.MousePointer = vbHourglass

    Let oPathFile = cPathFile
    
    If Not Right(oPathFile, 1) = "\" Then
        Let oPathFile = oPathFile & "\"
    End If
    
    Let oPathFile = oPathFile & cNomFile
    
    If Interfaz_SOS_LimpiaArchivos(oPathFile) = False Then
        Exit Function
    End If
    
    Let ooPathFile = Insterfaz_SOS_RutaAlterna(cNomFile, dFecha)

    Envia = Array()
    AddParam Envia, Format(dFecha, "yyyymmdd")
    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Genera_Interfaz_SOS_Mesctacl", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Interfaz " & cNomFile & vbCrLf & "Ha ocurrido un error al intentar generar la interfaz.", vbCritical, App.Title)
        Exit Function
    End If

    Let nNumFile = FreeFile
    Open oPathFile For Append As #nNumFile

    Let nnNumFile = FreeFile
    Open ooPathFile For Append As #nnNumFile

    Do While Bac_SQL_Fetch(cSqlDatos())
        Let cLinea = ""
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(1)), 4, 0)            '-> 01 - TIPOCUENTA                         [Modulo segun tabla de Productos]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(2)), 4, 0)            '-> 02 - FAMILIAPRODUCTO                    [Modulosegun tabla de Productos]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(3)), 15, 0)           '-> 03 - NUMEROCUENTA                       [Numero de la Cuneta]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(4)), 1, 0)            '-> 04 - TIPORELACION                       [T=Titular]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(5)), 2, 0)            '-> 05 - IDENTIFICACIONDELCLIENTETIPO       [01= Rut; 02= Pasaporte]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(6)), 11, 0)           '-> 06 - IDENTIFICACIONDELCLIENTENUMERO     [Rut del Cliente]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(7)), 4, 0)            '-> 07 - DISPONIBLE                         [4 ESPACIOS]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, CDbl(cSqlDatos(8)), 9, 0)            '-> 08 - ORDENRELACION                      [000000000  - Valor por Defecto]
        Let cLinea = cLinea & fCampoInterfaz([Fecha DDMMYYYY], Trim(cSqlDatos(9)), 8, 0)    '-> 09 - FECHAALTA                          [01011900   - Valor por Defecto]
        Let cLinea = cLinea & fCampoInterfaz([Fecha DDMMYYYY], Trim(cSqlDatos(10)), 8, 0)   '-> 10 - FECHABAJA                          [01011900   - Valor por Defecto]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(11)), 1, 0)           '-> 11 - ESTADO                             [1-ACTIVO   - Valor por Defecto]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, CDbl(cSqlDatos(12)), 12, 0)          '-> 12 - NIBS                               [Num. IBS   - Valor por Defecto = 000000000000]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(13)), 4, 0)           '-> 13 - EMPRESA                            [0050       - Valor por Defecto]
        
        Print #nNumFile, cLinea
        Print #nnNumFile, cLinea
        
        Let nRegistros = cSqlDatos(14)  '--> Cantidad de Registros
         Let nRegistro = nRegistro + 1
        Call Interfaz_SOS_Control_Progress(nProgress, nRegistros, nRegistro)
    Loop

    Close #nNumFile
    Close #nnNumFile

    Let Screen.MousePointer = vbDefault
    Let Interfaz_SOS_MESCTACL = True
    
    On Error GoTo 0

Exit Function
ErrorEscritura_Sos:
    Let Screen.MousePointer = vbDefault

    Call MsgBox("Err. " & err.Number & vbCrLf & vbCrLf & err.Description, App.Title)

    On Error GoTo 0
End Function

Public Function Interfaz_SOS_MESCLI(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByVal dFecha As Date) As Boolean
    On Error GoTo ErrorEscritura_Sos
    Dim nRegistros      As Long
    Dim nRegistro       As Long
    Dim oPathFile       As String
    Dim ooPathFile      As String
    Dim cLinea          As String
    Dim cSqlDatos()
    Dim nNumFile
    Dim nnNumFile
    
    Let Interfaz_SOS_MESCLI = False
    Let Screen.MousePointer = vbHourglass

    Let oPathFile = cPathFile
    If Not Right(oPathFile, 1) = "\" Then
        Let oPathFile = oPathFile & "\"
    End If
    
    Let oPathFile = oPathFile & cNomFile
    
    If Interfaz_SOS_LimpiaArchivos(oPathFile) = False Then
        Exit Function
    End If

    Let ooPathFile = Insterfaz_SOS_RutaAlterna(cNomFile, dFecha)

    Envia = Array()
    AddParam Envia, Format(dFecha, "yyyymmdd")
    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Genera_Interfaz_SOS_Mescli", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Interfaz " & cNomFile & vbCrLf & "Ha ocurrido un error al intentar generar la interfaz.", vbCritical, App.Title)
        Exit Function
    End If

    Let nNumFile = FreeFile
    Open oPathFile For Append As #nNumFile

    Let nnNumFile = FreeFile
    Open ooPathFile For Append As #nnNumFile

    Do While Bac_SQL_Fetch(cSqlDatos())
        
        Let cLinea = ""
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(1)), 2, 0)            '-> 01 - IDENTIFICACIONDELCLIENTE       [01=Rut; 02=Pasaporte]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(2)), 11, 0)           '-> 02 - IDENTIFICADORDELCLIENTENUMERO  [Rut del Cliente]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(3)), 4, 0)            '-> 03 - DISPONIBLE                     [4 ESPACIOS]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, Trim(cSqlDatos(4)), 2, 0)            '-> 04 - TIPOCLIENTE                    [02=Juridico; 02=Natural]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(5)), 3, 0)            '-> 05 - SUCURSALAGENCIA                [001 - Valor por Defecto]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(6)), 12, 0)           '-> 06 - OFICIALCUENTA                  [ejecutivo que ingresa la Op]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(7)), 45, 0)           '-> 07 - DENAMINACION                   [Nombre del Cliente]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(8)), 35, 0)           '-> 08 - CALLE                          [Direccion del Cliente]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(9)), 4, 0)            '-> 09 - LOCALIDAD                      [CIUDAD                 - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(10)), 15, 0)          '-> 10 - CODIGOPOSTAL                   [NO APLICA - 15 ESPACIOS]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(11)), 2, 0)           '-> 11 - CODIGOPROVINCIA                [Pais de Residencia     - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(12)), 20, 0)          '-> 12 - CODIGOPAIS                     [Pais de Nacionalidad   - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(13)), 11, 0)          '-> 13 - TELEFONO                       [N° de Telefono]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(14)), 11, 0)          '-> 14 - FAX                            [N° de Fax]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(15)), 40, 0)          '-> 15 - EMAIL                          [E-Mail]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(16)), 1, 0)           '-> 16 - SEXO                           [Sexo del Cliente M=Masc; F=Fem; ?=Sin Datos]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(17)), 2, 0)           '-> 17 - ESTADOCIVIL                    [Estado Civil           - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, CDbl(cSqlDatos(18)), 2, 0)           '-> 18 - CANTIDADHIJOS                  [Cantidad de Hijos]
        Let cLinea = cLinea & fCampoInterfaz([Fecha DDMMYYYY], Trim(cSqlDatos(19)), 8, 0)   '-> 19 - FECHANACIMIENTO                [Fecha de Nacimiento]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(20)), 4, 0)           '-> 20 - NACIONALIDAD                   [Lugar de Residencia    - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(21)), 40, 0)          '-> 21 - LUGARDENACIMIENTO              [Lugar de Residencia    - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(22)), 6, 0)           '-> 22 - UNIDADNEGOCIO                  [Unidad de Negocio      - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(23)), 4, 0)           '-> 23 - SUBSEGMENTO                    [Sub Segmento           - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(24)), 4, 0)           '-> 24 - ESTUDIOS                       [Estudios               - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(25)), 4, 0)           '-> 25 - ULTIMOTITULO                   [Nivel de Estudios      - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(26)), 4, 0)           '-> 26 - CATEGORIA                      [NO MAPLICA             - 4 ESPACIOS]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(27)), 4, 0)           '-> 27 - RESIDENCIASECTOR               [NO MAPLICA             - 4 ESPACIOS]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(28)), 4, 0)           '-> 28 - CODIGOACTIVIDADINTERNO         [Actividad Economica    - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(29)), 1, 0)           '-> 29 - ESTADOCLIENTE                  [2=Activo               - Valor por Defecto]
        Let cLinea = cLinea & fCampoInterfaz([Fecha DDMMYYYY], Trim(cSqlDatos(30)), 8, 0)   '-> 30 - FECHAALTA                      [01011900               - Valor por Defecto]
        Let cLinea = cLinea & fCampoInterfaz([Fecha DDMMYYYY], Trim(cSqlDatos(31)), 8, 0)   '-> 31 - FECHABAJA                      [01011900               - Valor por Defecto]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(32)), 4, 0)           '-> 32 - CARGOFUNCION                   [314=Sin Informacion    - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, Trim(cSqlDatos(33)), 8, 0)           '-> 33 - FECHAINGRESO                   [Fecha de Creacion      - ]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(34)), 4, 0)           '-> 34 - RUBRODELAEMPRESA               [''=Sin Informacion     - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, Trim(cSqlDatos(35)), 4, 0)           '-> 35 - TIPOEMPRESA                    [''=Sin Informacion     - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(36)), 4, 0)           '-> 36 - ACTIVIDADRUBRO                 [''=Sin Informacion     - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(37)), 1, 0)           '-> 37 - TIPOENTIDAD                    [''=Sin Informacion     - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(38)), 3, 0)           '-> 38 - TIPOSOCIEDAD                   ['C'=Sin Informacion    - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz([Fecha DDMMYYYY], Trim(cSqlDatos(39)), 8, 0)   '-> 39 - FECHACONSTITUCIONSOCIEDAD      [01011900               - Valor por Defecto]
        Let cLinea = cLinea & fCampoInterfaz([Fecha DDMMYYYY], Trim(cSqlDatos(40)), 8, 0)   '-> 40 - FECHAINICIOACTIVIDADES         [01011900               - Valor por Defecto]
        Let cLinea = cLinea & fCampoInterfaz([Fecha DDMMYYYY], Trim(cSqlDatos(41)), 8, 0)   '-> 41 - FECHAINSCRIPCIONSOCIEDAD       [01011900               - Valor por Defecto]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(42)), 4, 0)           '-> 42 - COMUNA                         [Comuna                 - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, Trim(cSqlDatos(43)), 15, 0)          '-> 43 - SALARIO                        [Salario Actual]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, Trim(cSqlDatos(44)), 15, 0)          '-> 44 - PATRIMONIO                     [Patrimonio Actual]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, Trim(cSqlDatos(45)), 15, 0)          '-> 45 - INGRESOS                       [Ingreso Actual]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, Trim(cSqlDatos(46)), 15, 0)          '-> 46 - OTROS INGRESOS                 [Ingreso Actual]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(47)), 1, 0)           '-> 47 - EMPLEADO                       [Codigo del Empleado    - Hoja de Anexo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(48)), 4, 0)           '-> 48 - EMPRESA                        [Codigo Empresa  0050   - Valor por Defecto]
        
        Print #nNumFile, cLinea
        Print #nnNumFile, cLinea
        
        Let nRegistros = cSqlDatos(49)  '--> Cantidad de Registros
         Let nRegistro = nRegistro + 1
        Call Interfaz_SOS_Control_Progress(nProgress, nRegistros, nRegistro)

    Loop

    Close #nNumFile
    Close #nnNumFile

    Let Screen.MousePointer = vbDefault
    Let Interfaz_SOS_MESCLI = True

    On Error GoTo 0

Exit Function
ErrorEscritura_Sos:
    Let Screen.MousePointer = vbDefault

    Call MsgBox("Err. " & err.Number & vbCrLf & vbCrLf & err.Description, App.Title)

    On Error GoTo 0
        
End Function


Public Function Interfaz_SOS_MESOFC(ByVal cPathFile As String, ByVal cNomFile As String, ByRef nProgress As SSPanel, ByVal dFecha As Date) As Boolean
    On Error GoTo ErrorEscritura_Sos
    Dim nRegistros      As Long
    Dim nRegistro       As Long
    Dim oPathFile       As String
    Dim ooPathFile      As String
    Dim cLinea          As String
    Dim cSqlDatos()
    Dim nNumFile
    Dim nnNumFile
    
    Let Interfaz_SOS_MESOFC = False
    Let Screen.MousePointer = vbHourglass

    Let oPathFile = cPathFile
    
    If Not Right(oPathFile, 1) = "\" Then
        Let oPathFile = oPathFile & "\"
    End If
    
    Let oPathFile = oPathFile & cNomFile
    
    If Interfaz_SOS_LimpiaArchivos(oPathFile) = False Then
        Exit Function
    End If

    Let ooPathFile = Insterfaz_SOS_RutaAlterna(cNomFile, dFecha)


    Envia = Array()
    AddParam Envia, Format(dFecha, "yyyymmdd")
    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Genera_Interfaz_SOS_Mesofc", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Interfaz " & cNomFile & vbCrLf & "Ha ocurrido un error al intentar generar la interfaz.", vbCritical, App.Title)
        Exit Function
    End If

    Let nNumFile = FreeFile
    Open oPathFile For Append As #nNumFile

    Let nnNumFile = FreeFile
    Open ooPathFile For Append As #nnNumFile

    Do While Bac_SQL_Fetch(cSqlDatos())
        Let cLinea = ""
        
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(1)), 10, 0)            '-> 01 - EUPUSR        [Codigo de Ejecutivo a 10]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(2)), 118, 0)           '-> 02 - DISPONIBLE    [118  ESPACIOS]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(3)), 25, 0)            '-> 03 - EUPOFC        [Codigo de Ejecutivo a 25]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(4)), 3, 0)             '-> 04 - EUPUBR        [Sucursal - 001 - Valor por Defecto]
        Let cLinea = cLinea & fCampoInterfaz(Numerico, Trim(cSqlDatos(5)), 43, 0)            '-> 05 - DISPONIBLE    [48   ESPACIOS]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(6)), 45, 0)            '-> 05 - EUPNME        [Nombre del Ejecutivo]
        Let cLinea = cLinea & fCampoInterfaz(Caracter, Trim(cSqlDatos(7)), 15, 0)            '-> 06 - EUPIDN        [Rut del Ejecutivo]
        
        Print #nNumFile, cLinea
        Print #nnNumFile, cLinea
        
         Let nRegistros = cSqlDatos(8)  '--> Cantidad de Registros
         Let nRegistro = nRegistro + 1
        Call Interfaz_SOS_Control_Progress(nProgress, nRegistros, nRegistro)

    Loop

    Close #nNumFile
    Close #nnNumFile

    Let Screen.MousePointer = vbDefault
    Let Interfaz_SOS_MESOFC = True

    On Error GoTo 0

Exit Function
ErrorEscritura_Sos:
    Let Screen.MousePointer = vbDefault

    Call MsgBox("Err. " & err.Number & vbCrLf & vbCrLf & err.Description, App.Title)

    On Error GoTo 0
        
End Function


'----------------------------------------------------------------------------------------
' INTERFAZ ITAU FUSION
'----------------------------------------------------------------------------------------

Public Function Interfaz_ITAU(ByVal cPathFile As String, ByRef nProgress As SSPanel, ByVal dFecha As Date, ByVal Interfaz As String, ByRef Mensaje As String) As Boolean
    On Error GoTo ErrorInterfaz_ITAU
    
    '-----------------------------------------------------------------------
    ' DECLARACION DE VARIABLES
    '-----------------------------------------------------------------------
     Dim Directorio As String
     Dim nombrearchivo As String
     Dim nNumFile As Integer
     Dim cLinea As String
     Dim ContadorRegistros As Integer
     Dim RegistrosSP As Integer
     Dim SqlDatos()
     Dim Resultado As Boolean
     Dim LargoArchivo As String
     Dim ExisteArchivo As String
     Dim BlancosFin As String
     Dim RutaParametrizada As String
         
     Dim FTP_Activado As String
     Dim FTP_Url As String
     Dim FTP_Hostname As String
     Dim FTP_Usuario As String
     Dim FTP_Password As String
     Dim FTP_Puerto As String
         
     Dim EMAIL_Activado As String
     Dim EMAIL_Servidor As String
     Dim EMAIL_Puerto As String
     Dim EMAIL_From As String
     Dim EMAIL_Asunto As String
     Dim EMAIL_Body As String
     Dim EMAIL_Destinatario As String
     
     
    Let Interfaz_ITAU = False
    
    '-----------------------------------------------------------------------
    ' NOMBRE DE INTERFAZ
    '-----------------------------------------------------------------------
 
    Let Interfaz = Trim(UCase(Interfaz))
    
    '-----------------------------------------------------------------------
    ' SE DEBE BUSCAR LAS CONFIGURACIONES ANEXAS QUE POSEERA ESTE ARCHIVO
    ' PARA ESTE CASO NECESITAREMOS EL NOMBRE DEL ARCHIVO QUE SE ESCRIBIRA
    '-----------------------------------------------------------------------
    Envia = Array()
    AddParam Envia, Interfaz
    AddParam Envia, "BTR"
    AddParam Envia, "ARCHIVO"
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEER_INTERFACES_MODULO_CONFIGURA", Envia) Then
        Let Screen.MousePointer = vbDefault
       Let Mensaje = ""
       Let Mensaje = Mensaje & " Error Interfaz :" & Interfaz & " " & vbCrLf & vbCrLf_
       Let Mensaje = Mensaje & " Ha ocurrido un error al intentar Llamar configuracion de Interfaz."
       
        GoTo ErrorInterfaz_ITAU
    End If
        
    Let nombrearchivo = ""
    
    Do While Bac_SQL_Fetch(SqlDatos())
        '----------------------------------------------------
        'SI EL NOMBRE DEL ARCHIVO VIENE CON LA CONSTITUCION
        ' AAAAMMDD DEBEMOS DAR EL FORMATO CORRESPONDIENTE A
        ' A LA FECHA
        '----------------------------------------------------
         If (SqlDatos(1) = 1 Or SqlDatos(1) = 2) Then
         If UCase(Trim(SqlDatos(3))) = "AAAAMMDD" Then
            Let nombrearchivo = nombrearchivo & Format(dFecha, "yyyymmdd")
         Else
            Let nombrearchivo = nombrearchivo & Trim(SqlDatos(3))
         End If
         End If
                  
         If (SqlDatos(1) = 3) Then
            LargoArchivo = UCase(Trim(SqlDatos(3)))
         End If
         If (SqlDatos(1) = 4) Then
            BlancosFin = UCase(Trim(SqlDatos(3)))
         End If
         If (SqlDatos(1) = 5) Then
            Let RutaParametrizada = UCase(Trim(SqlDatos(3)))
         End If
    Loop
    
    Let nombrearchivo = nombrearchivo & ".TXT"
    
    On Error GoTo 0
        
    '-----------------------------------------------------------------------
    ' BUSQUEDA DE DATA DE SP PARA ESCRIBIR ARCHIVO DE TEXTO
    '-----------------------------------------------------------------------
    If (Trim(UCase(Interfaz)) = "RCO") Then ' REC NORMATIVO
    Envia = Array()
    AddParam Envia, Format(dFecha, "yyyymmdd")
    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_FUSION_INTERFAZ_ART84", Envia) Then
               Let Mensaje = ""
            Let Mensaje = Mensaje & " Error Interfaz :" & Interfaz & " " & vbCrLf & vbCrLf_
            Let Mensaje = Mensaje & " Ha ocurrido un error al intentar llamar rgistros la interfaz."
            GoTo ErrorInterfaz_ITAU
        End If
    End If
        
    If (Trim(UCase(Interfaz)) = "OGMDERIVADOS") Then ' REC INTERNO
        Envia = Array()
        AddParam Envia, Format(dFecha, "yyyymmdd")
        If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_FUSION_INTERFAZ_LCR_Interno_Derivados", Envia) Then
            Let Mensaje = ""
            Let Mensaje = Mensaje & " Error Interfaz :" & Interfaz & " " & vbCrLf & vbCrLf_
            Let Mensaje = Mensaje & " Ha ocurrido un error al intentar llamar rgistros la interfaz."
            GoTo ErrorInterfaz_ITAU
        End If
    End If
        
    If (Trim(UCase(Interfaz)) = "OGMINVERSIONES") Then
        Envia = Array()
        AddParam Envia, Format(dFecha, "yyyymmdd")
        If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_FUSION_INTERFAZ_LCR_Interno_Inversiones", Envia) Then
            Let Mensaje = ""
            Let Mensaje = Mensaje & " Error Interfaz :" & Interfaz & " " & vbCrLf & vbCrLf_
            Let Mensaje = Mensaje & " Ha ocurrido un error al intentar llamar rgistros la interfaz."
            GoTo ErrorInterfaz_ITAU
        End If
    End If
    
    '-----------------------------------------------------------------------
    ' EN CASO DE TENER RUTA PARAMETRIZADA
    '-----------------------------------------------------------------------
    If (Len(RutaParametrizada) > 0) Then
        If Right(RutaParametrizada, 1) = "\" Then
            Let nombrearchivo = RutaParametrizada & nombrearchivo
        Else
            Let nombrearchivo = RutaParametrizada & "\" & nombrearchivo
        End If
    Else
    Let nombrearchivo = cPathFile & "\" & nombrearchivo
    End If
    
  
    '-----------------------------------------------------------------------
    ' SI EXISTE EN ARCHIVO EN DISCO
    '-----------------------------------------------------------------------
    ExisteArchivo = Dir$(nombrearchivo)
    
    If Len(ExisteArchivo) > 0 Then
       Call Kill(nombrearchivo)
    End If
       
    Let ContadorRegistros = 0
    Let nNumFile = FreeFile

    Open nombrearchivo For Output As #nNumFile

    Do While Bac_SQL_Fetch(SqlDatos())
    
        Let cLinea = ""

        If (Trim(UCase(Interfaz)) = "OGMINVERSIONES") Then
           Let cLinea = "    "   'PENDIENTE PARAMETRIZAR como los 10 blancos de al final
        End If
        
        Let cLinea = cLinea & ""
        Let cLinea = cLinea & Trim(SqlDatos(1))
        Let cLinea = cLinea & Space(CInt(BlancosFin))
                                                      
        '-----------------------------------------
        ' SI LA CANTIDAD ES 0 ARCHIVO VIENE VACIO
        '-----------------------------------------
        If (Trim(SqlDatos(2)) = "0") Then
           Exit Do
        End If
        
        '-----------------------------------------
        ' MEDIR LARGO DE LINEA
        '-----------------------------------------
        If (CInt(LargoArchivo) <> Len(cLinea)) Then
            Let Mensaje = ""
            Let Mensaje = Mensaje & "Error Interfaz :" & Interfaz & " " & vbCrLf & vbCrLf_
            Let Mensaje = Mensaje & "Largo establecido de " & LargoArchivo & ", No Coincide con largo de linea calculada actualmente de " & Len(cLinea)
            Let Mensaje = Mensaje & vbCrLf & vbCrLf_
            Let Mensaje = Mensaje & vbCrLf & vbCrLf_
            Let Mensaje = Mensaje & "Numero de Fila " & ContadorRegistros + 1

            Close #nNumFile
            
            Call Kill(nombrearchivo)
            GoTo ErrorInterfaz_ITAU
        End If
        
        Print #nNumFile, cLinea
        Let RegistrosSP = SqlDatos(2)
              
        '-----------------------------------------
        ' SI EL REGISTRO DESDE EL SP ES 0 VOLCA
        ' EL PROCESO
        '-----------------------------------------
        If RegistrosSP = 0 Then
            Exit Do
        End If
        
        Let ContadorRegistros = ContadorRegistros + 1

        Call Interfaz_SOS_Control_Progress(nProgress, RegistrosSP, ContadorRegistros)

    Loop
       
    Close #nNumFile
    
    '-----------------------------------------------------------------------
    ' SI EL REGISTRO ES 0 ES PORQUE NO SE HA ITERADO POR DATOS O
    ' EL PROCESO FUE VOLCADO
    '-----------------------------------------------------------------------
    If RegistrosSP = 0 Then
       Call Kill(nombrearchivo)
        Let Interfaz_ITAU = False
       Exit Function
    End If
    
    '-----------------------------------------------------------------------
    ' EL NUMERO DE REGISTRO CONTADO DEBE COINCIDIR CON EL NUMERO DE
    ' REGISTROS ENVIADOS POR EL SP
    '-----------------------------------------------------------------------

    If RegistrosSP <> ContadorRegistros Then
       Let Mensaje = ""
       Let Mensaje = Mensaje & " Error Interfaz :" & Interfaz & " " & vbCrLf & vbCrLf_
       Let Mensaje = Mensaje & " Numero de Regitros Contados en Iteracion son " & ContadorRegistros
       Let Mensaje = Mensaje & ",Numero de Regitros Enviados por SP en Archivos son " & RegistrosSP
                           
       Call Kill(nombrearchivo)
       GoTo ErrorInterfaz_ITAU
    Else
    
            '---------------------------------------------------------------
            ' ENVIAR CORREO
            '---------------------------------------------------------------
        
            Envia = Array()
            AddParam Envia, Interfaz
            AddParam Envia, "BTR"
            AddParam Envia, "EMAIL"
            If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEER_INTERFACES_MODULO_CONFIGURA", Envia) Then
                Let Mensaje = ""
                Let Mensaje = Mensaje & " Error Interfaz :" & Interfaz & " " & vbCrLf & vbCrLf_
                Let Mensaje = Mensaje & " Ha ocurrido un error al intentar extraer Informacion de Email."
                GoTo ErrorInterfaz_ITAU
            End If
    
            Let EMAIL_Activado = "0"
            Let EMAIL_Servidor = ""
            Let EMAIL_Puerto = ""
            Let EMAIL_From = ""
            Let EMAIL_Asunto = ""
            Let EMAIL_Body = ""
            Let EMAIL_Destinatario = ""

            Do While Bac_SQL_Fetch(SqlDatos())
                '----------------------------------------------------
                ' DEPENDE DEL CASO SE SETAN LOS VALORES
                '----------------------------------------------------
                Select Case SqlDatos(1)
                Case Is = "0":  EMAIL_Activado = Trim(SqlDatos(3))
                Case Is = "1":  EMAIL_Servidor = Trim(SqlDatos(3))
                Case Is = "2":  EMAIL_Puerto = Trim(SqlDatos(3))
                Case Is = "3":  EMAIL_From = Trim(SqlDatos(3))
                Case Is = "4":  EMAIL_Asunto = Trim(SqlDatos(3))
                Case Is = "5":  EMAIL_Body = Trim(SqlDatos(3))
                Case Is = "6":  EMAIL_Destinatario = Trim(SqlDatos(3))
                End Select
            Loop
            
            If (UCase(Trim(EMAIL_Activado)) = "1") Then
            Resultado = EnvioArchivoTextoMail(EMAIL_Servidor _
                                            , CInt(EMAIL_Puerto) _
                                            , EMAIL_From _
                                            , EMAIL_Asunto _
                                            , EMAIL_Body _
                                            , EMAIL_Destinatario _
                                            , nombrearchivo _
                                                , Interfaz _
                                                , Mensaje)
    
                If (Resultado = False) Then
                    GoTo ErrorInterfaz_ITAU
                End If
            End If
       
            '---------------------------------------------------------------
            ' ENVIAR FTP
            '---------------------------------------------------------------
            Envia = Array()
            AddParam Envia, Interfaz
            AddParam Envia, "BTR"
            AddParam Envia, "FTP"
            If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEER_INTERFACES_MODULO_CONFIGURA", Envia) Then
                Let Mensaje = ""
                Let Mensaje = Mensaje & " Error Interfaz :" & Interfaz & " " & vbCrLf & vbCrLf_
                Let Mensaje = Mensaje & " Ha ocurrido un error al intentar extraer Informacion de FTP."
                GoTo ErrorInterfaz_ITAU
            End If
    
            Let FTP_Url = ""
            Let FTP_Hostname = ""
            Let FTP_Usuario = ""
            Let FTP_Password = ""
            Let FTP_Puerto = ""
            Let FTP_Activado = "0"

            Do While Bac_SQL_Fetch(SqlDatos())
                '----------------------------------------------------
                ' DEPENDE DEL CASO SE SETAN LOS VALORES
                '----------------------------------------------------
                Select Case SqlDatos(1)
                Case Is = "0":  FTP_Activado = Trim(SqlDatos(3))
                Case Is = "1":  FTP_Url = Trim(SqlDatos(3))
                Case Is = "2":  FTP_Hostname = Trim(SqlDatos(3))
                Case Is = "3":  FTP_Usuario = Trim(SqlDatos(3))
                Case Is = "4":  FTP_Password = Trim(SqlDatos(3))
                Case Is = "5":  FTP_Puerto = Trim(SqlDatos(3))
                End Select
            Loop
    
            If (UCase(Trim(FTP_Activado)) = "1") Then
                Resultado = EnvioArchivoTextoFTP(FTP_Url _
                                               , FTP_Hostname _
                                               , FTP_Usuario _
                                               , FTP_Password _
                                               , FTP_Puerto _
                                               , nombrearchivo _
                                               , Interfaz _
                                               , cPathFile _
                                               , Mensaje)
                If (Resultado = False) Then
                    GoTo ErrorInterfaz_ITAU
                End If
            End If
    End If
    
    '-----------------------------------------------------------------------
    ' FIN IF CANTIDAD DE REGISTROS
    '-----------------------------------------------------------------------
    
    Let Screen.MousePointer = vbDefault
    
    Let Interfaz_ITAU = True

    On Error GoTo 0

Exit Function
ErrorInterfaz_ITAU:

    If (Len(Trim(Mensaje)) <= 0) Then
        Let Mensaje = "Error General Funcion" & vbCrLf & vbCrLf_
        Let Mensaje = Mensaje & err.Description
    End If

    Let Interfaz_ITAU = False
    Let Screen.MousePointer = vbDefault
 
    On Error GoTo 0
End Function
'----------------------------------------------------------------------------------------
'ENVIO DE ARCHIVOS FTP A DIRECCIONES DE DESTINO SOLICITADAS
'----------------------------------------------------------------------------------------
Public Function EnvioArchivoTextoFTP(Url As String _
                                    , Hostname As String _
                                    , Usuario As String _
                                    , Password As String _
                                    , Puerto As String _
                                    , FileAdjunto As String _
                                    , Interfaz As String _
                                    , Carpeta As String _
                                    , ByRef Mensaje As String) As Boolean

On Error GoTo ErrorEnvioFTP



    '-----------------------------------------------------------------------
    ' DECLARACION DE VARIABLES
    '-----------------------------------------------------------------------
    Dim RemoteFileName As String
    
    
    'Dim FTP As Inet
    'Dim RemoteFileName As String
    
    
    'RemoteFileName = "/" & Dir(FileAdjunto)
    
    
    'Set FTP = New Inet
    'With FTP
    '    .Url = Url
    '    .Protocol = icFTP
    '    .RemoteHost = Hostname
    '    .UserName = Usuario
    '    .Password = Password
    '    .Execute .Url, "put " + FileAdjunto + " " + RemoteFileName
    '    Do While .StillExecuting
    '        DoEvents
    '    Loop
    '    .Execute , "quit"                   'Logoff
    'End With
    'Set FTP = Nothing
    

    '-----------------------------------------------------------------------
    ' SE DEBEN LLENAR VARIABLES GLOBALES Y
    '-----------------------------------------------------------------------
    Let gsUser_maq = Usuario
    Let gsPass_maq = Password
    Let gsPath_maq = Url
    Let gsNom_maq = Hostname
    

    Let Carpeta = Carpeta & "\"
    EnvioArchivoTextoFTP = Enviar_por_ftp(Carpeta, FileAdjunto)

   'Let EnvioArchivoTextoFTP = True
   On Error GoTo 0


Exit Function
ErrorEnvioFTP:

    Let Mensaje = ""
    Let Mensaje = Mensaje & " Error Interfaz :" & Interfaz & " " & vbCrLf & vbCrLf_
    Let Mensaje = Mensaje & " Ha ocurrido un error cuando se trato de Copiar archivo en Ruta FTP."

    EnvioArchivoTextoFTP = False

    On Error GoTo 0
        

End Function

'----------------------------------------------------------------------------------------
'ENVIO DE ARCHIVOS POR EMAIL A DESTINATARIOS DE CORREO
'----------------------------------------------------------------------------------------
Public Function EnvioArchivoTextoMail(IP As String _
                                     , Puerto As Integer _
                                     , From As String _
                                     , Asunto As String _
                                     , Body As String _
                                     , CorreosTO As String _
                                     , FileAdjunto As String _
                                     , Interfaz As String _
                                     , ByRef Mensaje) As Boolean


On Error GoTo ErrorEnvioMail


    '-----------------------------------------------------------------------
    ' DECLARACION DE VARIABLES
    '-----------------------------------------------------------------------
    Dim objEmail As Object
    

    Set objEmail = CreateObject("CDO.Message")

    objEmail.From = From
    objEmail.To = CorreosTO
    objEmail.Subject = Asunto
    objEmail.Textbody = Body
    objEmail.AddAttachment FileAdjunto
    
    objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = IP
    objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = Puerto
    objEmail.Configuration.Fields.Update

    objEmail.send




   Let EnvioArchivoTextoMail = True
   On Error GoTo 0

Exit Function
ErrorEnvioMail:
 

    Let Mensaje = ""
    Let Mensaje = Mensaje & " Error Interfaz :" & Interfaz & " " & vbCrLf & vbCrLf_
    Let Mensaje = Mensaje & " Ha ocurrido un error cuando se trato de enviar Correo Electronico."


    EnvioArchivoTextoMail = False

    On Error GoTo 0
    
End Function


Public Function Interfaz_SOS_Control_Progress(ByRef nProgress As SSPanel, ByVal totalregistros As Long, ByVal nRegistro As Long)
    On Error Resume Next
    
    Let nProgress.FloodPercent = (nRegistro * 100) / totalregistros
    If nProgress.FloodPercent >= 49 Then
        Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbWhite
    Else
        Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
    End If
    On Error GoTo 0
End Function

Public Function Interfaz_ParidadesMensuales(ByVal cPathFile As String, ByVal nNomFile As String, ByRef nProgress As SSPanel, ByVal oFechaGeneracion As Date) As Boolean
    On Error GoTo ErrorInterfaz
    Dim SqlDatos()
    Dim nRegistros      As Long
    Dim nRegistro       As Long
    
    Let Interfaz_ParidadesMensuales = False

    Let Screen.MousePointer = vbHourglass
    
   'If Month(gsBac_Feca) = Month(gsBac_Fecp) Then   '-> Primer Día Hábil del Mes
    If Month(gsBac_Fecp) = Month(gsBac_Fecx) Then   '-> Ultimo Día Hábil del Mes
        On Error GoTo 0
        Let Interfaz_ParidadesMensuales = True
        Exit Function
    End If

    If Not Right(cPathFile, 1) = "\" Then
        Let cPathFile = cPathFile & "\"
    End If

    Let cPathFile = cPathFile & nNomFile

    If Len(Dir(cPathFile)) > 0 Then
        Call Kill(cPathFile)
    End If

    Envia = Array()
    AddParam Envia, Format(oFechaGeneracion, "yyyymmdd")
    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_INTERFAZ_PARIDADESMENSUALESBCCH", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Interfaz C-18" & vbCrLf & "Ha ocurrido un error al intentar generar la interfaz C18", vbCritical, App.Title)
        Exit Function
    End If

    Let nNumFile = FreeFile
    Open cPathFile For Append As #nNumFile
   'Open cPathFile For Output As #nNumFile

    Let nRegistros = -1
    Let nRegistro = 0

    Do While Bac_SQL_Fetch(SqlDatos())
        '-> Solo control de Progress bar
        If nRegistros = -1 Then
            Let nRegistros = SqlDatos(6)    '> nCantidad de Registros (Control Progress Bar)
        End If
        '-> Solo control de Progress bar
    
        '-> Generacion del Archivo
        Let cLinea = ""
        Let cLinea = cLinea & fCampoInterfaz(Caracter, SqlDatos(1), 4, 0)   '>  Año
        Let cLinea = cLinea & fCampoInterfaz(Caracter, SqlDatos(2), 2, 0)   '>  Mes
        Let cLinea = cLinea & fCampoInterfaz(Caracter, SqlDatos(3), 2, 0)   '>  Dia
        Let cLinea = cLinea & fCampoInterfaz(Caracter, SqlDatos(4), 3, 0)   '>  Moneda
        Let cLinea = cLinea & fCampoInterfaz(Numerico, Replace(SqlDatos(5), ",", "."), 11, 6) '>  Paridad

        Print #nNumFile, cLinea
        '-> Generacion del Archivo
        
        '-> Solo control de Progress bar
        Let nRegistro = nRegistro + 1
        Call Interfaz_SOS_Control_Progress(nProgress, nRegistros, nRegistro)
        '-> Solo control de Progress bar
    Loop

    Close #nNumFile
    
    Let Screen.MousePointer = vbDefault

    Let Interfaz_ParidadesMensuales = True

    On Error GoTo 0

Exit Function
ErrorInterfaz:

    If err.Number = 52 Then
        Call MsgBox("Error N° 52, Archivo se encuentra bloqueado por otro proceso o bien presenta problemas de acceso a la ruta.", vbExclamation, App.Title)
    Else
        Call MsgBox("Error N° " & err.Number & " en la generacion de la Interfaz de Paridades Mensuales. " & vbCrLf & err.Description, vbExclamation, App.Title)
    End If
    
    On Error GoTo 0
    Let Screen.MousePointer = vbDefault

End Function

Public Function FnControlParidadesMensuales() As Boolean
    On Error GoTo ErrControl
    Dim cSqlDatos()
    Dim bEstado     As Boolean
    Dim cMensaje    As String
    
    Let bEstado = False

    If Month(gsBac_Fecp) = Month(gsBac_Fecx) Then   '-> Ultimo Día Hábil del Mes
        On Error GoTo 0
        Let FnControlParidadesMensuales = True
        Exit Function
    End If

    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_CONTROL_PARIDADES_MENSUAL") Then
        GoTo ErrControl
        Exit Function
    End If
    
    If Bac_SQL_Fetch(cSqlDatos()) Then
        Let bEstado = IIf(cSqlDatos(1) = 0, True, False)
        Let cMensaje = cSqlDatos(2)
    End If

    If bEstado = False Then
        GoTo Mensajes
        Exit Function
    End If

    Let FnControlParidadesMensuales = bEstado
    
    On Error GoTo 0
    
Exit Function
ErrControl:

    Let FnControlParidadesMensuales = True

    Call MsgBox("Error en el control de Ingreso de Paridades Mensuales Banco Central. " & vbCrLf & "Favor varificar, " & vbCrLf & "Si hoy es el último día hábil del mes, Favor ingresar antes de generar procesos de cierre.", vbExclamation, App.Title)
    On Error GoTo 0

Exit Function
Mensajes:

    Let FnControlParidadesMensuales = False

    Call MsgBox("Paridades Mensuales BCCH" & vbCrLf & cMensaje, vbExclamation, App.Title)
    On Error GoTo 0

End Function

Public Sub Contable_Desacople(nombre_arch As String)

    Dim Tabla() As Variant

    Dim cNomArchivo   As String
    Dim cDia          As String
    Dim cLine         As String
    Dim Datos()
    Dim iContador     As Long

    On Error GoTo ErrorInterfazContable
   
    Screen.MousePointer = vbHourglass
   
    Envia = Array()
    AddParam Envia, 381 ' Interfaz Contable
    If Not Bac_Sql_Execute("sp_BacInterfaces_Archivo", Envia) Then
        Exit Sub
    End If
    If Bac_SQL_Fetch(Datos()) Then
        Let cNomArchivo = Datos(4) + Datos(2) + Format(gsBac_Fecp, "yymmdd") + ""
    Else
        Let cNomArchivo = gsBac_DIRCONTA & "BAC_RISTAS_" & Format(gsBac_Fecp, "yyyymmdd") & ".DAT"
    End If
    
    nombre_arch = cNomArchivo
    
    '--> Formato del Archivo
'    cNomArchivo = gsBac_DIRCONTA & "RISTAS_BAC_" & Format(gsBac_Fecp, "yyyymmdd") & ".DAT"
    '--> Formato del Archivo
   
    Dim objConn As New ADODB.Connection
    Dim objCmd As New ADODB.Command
    Dim objRs As New ADODB.Recordset
  
    objCmd.CommandText = "EXEC SP_INTERFAZ_CONTABILIDAD_BAC "
    objCmd.CommandType = adCmdText 'adCmdText 'adCmdStoredProc SP 'adCmdTable Table
    
    objCmd.Parameters.Append objCmd.CreateParameter("@FECHA", adDBTimeStamp, adParamInput, , gsBac_Fecp)
    
    Set objConn = GetNewConnection
    objCmd.ActiveConnection = objConn
  
    ' Execute once and display...
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set objRs = objCmd.Execute
    On Error GoTo ErrorInterfazContable
    
    Tabla = objRs.GetRows
    
    objRs.Close

    'Obtener largo de la lista
    'Recordar que los datos en Tabla
    'las filas son lo que se ve
    'en consola como columna y
    'vice-versa.
    On Error Resume Next
        LargoLista = UBound(Tabla, 2) '<== Cantidad de Columnas
        ErrorLargoLista = err.Number
    On Error GoTo 0
    
    If ErrorLargoLista <> 0 Then
        Exit Sub
    End If
    
    Open cNomArchivo For Output As #1
'    Open cNomArchivo For Append As #1

    cLine = ""
   
    For i = 0 To LargoLista
        cLine = Tabla(0, i)
        Print #1, cLine
    Next i

    Close #1
   
    MsgBox "Acción Finalizada." & vbCrLf & vbCrLf & "Archivo Contable Generado.... Favor Revisar", vbInformation, TITSISTEMA
    
    Screen.MousePointer = vbDefault
    
    Exit Sub
    
ErrorInterfazContable:
    Screen.MousePointer = vbDefault
    MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "El archivo no se ha generado.... Favor reintentar.", vbCritical, TITSISTEMA
End Sub

Public Function Formulario_SIM03(nombrearchivo As String)

    Dim cNomArchivo   As String
    Dim cDia          As String
    Dim cLine         As String
    Dim Datos()
    Dim iContador     As Long

   
    Screen.MousePointer = vbHourglass
    
    On Error GoTo ErrHandler:
    
    If nombrearchivo = "" Then
        Envia = Array()
        AddParam Envia, 382 ' Interfaz Contable
        If Not Bac_Sql_Execute("sp_BacInterfaces_Archivo", Envia) Then
            Exit Function
        End If
        If Bac_SQL_Fetch(Datos()) Then
            Let cNomArchivo = Datos(4) + Datos(2) + Format(gsBac_Fecp, "yyyymmdd") + ".csv"
        Else
            Let cNomArchivo = gsBac_DIRCONTA & "SIM03_" & Format(gsBac_Fecp, "yyyymmdd") & ".csv"
        End If
    Else
       Let cNomArchivo = nombrearchivo
    End If
  
        
    Dim objConn As New ADODB.Connection
    Dim objCmd As New ADODB.Command
    Dim objRs As New ADODB.Recordset
    
    objCmd.CommandText = "exec Sp_Formulario_SIM03 "
    objCmd.CommandText = objCmd.CommandText & "'" & Format(gsBac_Fecp, "yyyymmdd") & "'"
    objCmd.CommandType = adCmdText
  
    ' Connect to the data source.
    Set objConn = GetNewConnection
    objCmd.ActiveConnection = objConn
  
    ' Execute once and display...
    Set objRs = objCmd.Execute
  
    
    Open cNomArchivo For Output As #1

    cLine = ""
  
    Do While Not objRs.EOF
        cLine = RTrim(objRs(0))
        Print #1, cLine
        objRs.MoveNext
    Loop

    Close #1
  
  
    'clean up
    objRs.Close
    objConn.Close
    Set objRs = Nothing
    Set objConn = Nothing
    Set objCmd = Nothing
    
    MsgBox "Acción Finalizada." & vbCrLf & vbCrLf & "Archivo SIM03 Generado.... Favor Revisar", vbInformation, TITSISTEMA
    
    Screen.MousePointer = vbDefault
    
    Exit Function
  
ErrHandler:
    
    
    If objRs.State = adStateOpen Then
        objRs.Close
    End If
  
    If objConn.State = adStateOpen Then
        objConn.Close
    End If
  
    Set objRs = Nothing
    Set objConn = Nothing
    Set objCmd = Nothing
  
    Screen.MousePointer = vbDefault
    
  
End Function


