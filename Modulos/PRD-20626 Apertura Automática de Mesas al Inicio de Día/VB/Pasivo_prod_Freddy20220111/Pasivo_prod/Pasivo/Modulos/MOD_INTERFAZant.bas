Attribute VB_Name = "MOD_INTERFACES"
Option Explicit
Dim Datos As Variant
 
Public Function Enviar_por_ftp(cRuta As String, direct_carchivo As String) As Boolean
 Dim X
 Dim fName1
 Dim fName2
 Dim ifiledel
 Dim ifilehost
 Dim arc_scrp As String
 ' de bono
 Dim Variable   As String
 
 On Error GoTo Erroftp
 
  arc_scrp = ""
  fName1 = ""
  fName2 = ""

  fName1 = cRuta & "Ftpswpctb.txt"
  fName2 = cRuta & "Ftpswpdel.txt"
  
  ifilehost = FreeFile
  ifiledel = FreeFile
  
  Enviar_por_ftp = True
  Variable = " " & Trim(GLB_Terminal_Bac) 'Addrian P. Revisar
  
  Open fName1 For Output As ifilehost
  Close #ifilehost

  Open fName2 For Output As ifiledel
  Close #ifiledel

  Open fName2 For Output As ifiledel
  'Print #ifilehost, gsNom_maq                                        ' nombre maquina
  
  'Limpieza de datos antiguos
  Print #ifiledel, GLB_SQL_Login
  Print #ifiledel, GLB_Nombre_Uusario                                      ' USERNAME
  Print #ifiledel, GLB_SQL_Password                                      ' Password
  'Print #ifiledel, gsPath_maq
  Print #ifiledel, "prompt"
  Print #ifiledel, "Asc"
  Print #ifiledel, "mdel SWAP*.TXT"
'  Print #ifilehost, "put FUTU*.TXT"
  Print #ifiledel, "Close"
  Print #ifiledel, "By"
  Close #ifiledel
  X = Shell("ftp.exe -s:" & fName2)
  
 'BacControlWindows 1000000
  
  Open fName1 For Output As ifilehost
  'Envio de nuevos datos
  'Print #ifilehost, gsIp_maq
  'Print #ifilehost, gsUser_maq                                       ' USERNAME
  'Print #ifilehost, gsPass_maq                                       ' Password
  'Print #ifilehost, gsPath_maq                                       ' PATH
  'Print #ifilehost, "put " & direct_carchivo                         ' archivo a traspasar
  Print #ifilehost, "close"
  Print #ifilehost, "bye"                                            ' termina la secion
  Close #ifilehost
  X = Shell("ftp.exe -s:" & fName1)
  
  Exit Function
  
Erroftp:
Select Case Err.Number
    Case 55
            Close #ifilehost
            Close #ifiledel
            MsgBox " Error " & Err.Number & " " & Err.Description
    Case 53
            ifilehost = FreeFile
            Open fName1 For Output As ifilehost
            Close #ifilehost
            MsgBox " Error " & Err.Number & " " & Err.Description
            'Resume
    Case 0
    MsgBox " Error " & Err.Number & " " & Err.Description
    '''otro problema
End Select

Enviar_por_ftp = False
Exit Function
Resume
End Function

Sub InterfazOperaciones(cRuta As String)
    Dim I              As Integer
    Dim total          As Integer
    Dim TotalReg       As Integer
    Dim cDia           As String
    Dim cNomArchivo    As String
    Dim cNombre        As String
    Dim cLine          As String
    Dim sSeparador     As String

 On Error GoTo Herror1
    total = 0
    TotalReg = 0
    cNomArchivo = ""
    cDia = Format(GLB_Fecha_Proceso, "yymmdd")
    cNombre = "OP24" & cDia & ".TCL"
    cNomArchivo = cRuta & cNombre
    sSeparador = ","
    
    Screen.MousePointer = 11
    
    If Dir(cNomArchivo, vbArchive) <> Empty Then
        If MsgBox("El Archivo " & cNomArchivo & " ya existe, ¿Desea reemplazarlo?", vbExclamation + vbYesNo, "") <> 6 Then
            Screen.MousePointer = 0
            Exit Sub
        End If
        Call Kill(cNomArchivo)
    End If

    If Not FUNC_EXECUTA_COMANDO_SQL("Sp_Interfaz_Operaciones") Then
        Screen.MousePointer = 0
        MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
        Exit Sub
    End If
    
    Open cNomArchivo For Binary Access Write As #1
  
    Do While FUNC_LEE_RETORNO_SQL(Datos)
        cLine = ""
        cLine = cLine & Trim(Datos(1)) & sSeparador                   '1
        cLine = cLine & Format(Datos(2), "YYYYMMDD") & sSeparador     '2
        cLine = cLine & Format(Datos(3), "YYYYMMDD") & sSeparador     '3
        cLine = cLine & Trim(Datos(4)) & sSeparador                   '4
        cLine = cLine & Trim(Datos(5)) & sSeparador                   '5
        cLine = cLine & Trim(Datos(6)) & sSeparador                   '6
        cLine = cLine & Trim(Datos(7)) & sSeparador                   '7
        cLine = cLine & Trim(Datos(8)) & sSeparador                   '8
        cLine = cLine & Trim(Datos(9)) & sSeparador                   '9
        cLine = cLine & sSeparador                                    '10
        cLine = cLine & sSeparador                                    '11
        cLine = cLine & Trim(Datos(12)) & sSeparador                  '12
        cLine = cLine & Trim(Datos(13)) & sSeparador                  '13
        cLine = cLine & Trim(Datos(14)) & sSeparador                  '14
        cLine = cLine & Format(Datos(15), "YYYYMMDD") & sSeparador    '15
        cLine = cLine & Format(Datos(16), "YYYYMMDD") & sSeparador    '16
        cLine = cLine & sSeparador                                    '17
        cLine = cLine & sSeparador                                    '18
        cLine = cLine & Trim(Datos(19)) & sSeparador                  '19
        cLine = cLine & Trim(Datos(20)) & sSeparador                  '20
        cLine = cLine & Replace((Format(Datos(21), "000000000000000.0000")), ",", ".") & sSeparador '21
        cLine = cLine & Trim(Datos(22)) & sSeparador                  '22
        cLine = cLine & Replace((Format(Datos(23), "00000000000000000.00")), ",", ".") & sSeparador '23
        cLine = cLine & sSeparador                                    '24
        cLine = cLine & Trim(Datos(25)) & sSeparador                  '25
        cLine = cLine & Replace((Format(Datos(26), "00000000000000000.00")), ",", ".") & sSeparador '26
        cLine = cLine & sSeparador                                    '27
        cLine = cLine & sSeparador                                    '28
        cLine = cLine & sSeparador                                    '29
        cLine = cLine & sSeparador                                    '30
        cLine = cLine & Trim(Datos(31)) & sSeparador                  '31
        cLine = cLine & sSeparador                                    '32
        cLine = cLine & Replace((Format(Datos(33), "00000000.00000000")), ",", ".") & sSeparador '33
        cLine = cLine & Replace((Format(Datos(34), "00000000.00000000")), ",", ".") & sSeparador '34
        cLine = cLine & Trim(Datos(35)) & sSeparador                  '35
        cLine = cLine & sSeparador                                    '36
        cLine = cLine & sSeparador                                    '37
        cLine = cLine & sSeparador                                    '38
        cLine = cLine & sSeparador                                    '39
        cLine = cLine & sSeparador                                    '40
        cLine = cLine & sSeparador                                    '41
        cLine = cLine & Trim(Datos(42)) & sSeparador                  '42
        cLine = cLine & sSeparador                                    '43
        cLine = cLine & sSeparador                                    '44
        cLine = cLine & Datos(45) & sSeparador                        '45
        cLine = cLine & sSeparador                                    '46
        cLine = cLine & Format(Datos(47), "0") & sSeparador           '47
        cLine = cLine & sSeparador                                    '48
        cLine = cLine & sSeparador                                    '49
        cLine = cLine & sSeparador                                    '50 Revisar
        cLine = cLine & sSeparador                                    '51
        cLine = cLine & sSeparador                                    '52
        cLine = cLine & sSeparador                                    '53
        cLine = cLine & sSeparador                                    '54
        cLine = cLine & Format(Datos(55), "0000") & sSeparador        '55
        cLine = cLine & sSeparador                                    '56
        cLine = cLine & Format(Datos(57), "0000") & sSeparador        '57
        cLine = cLine & sSeparador                                    '58
        cLine = cLine & sSeparador                                    '59
        cLine = cLine & Format(Datos(60), "YYYYMMDD") & sSeparador    '60
        cLine = cLine & sSeparador                                    '61
        cLine = cLine & sSeparador                                    '62
        cLine = cLine & sSeparador                                    '63
        cLine = cLine & sSeparador                                    '64
        cLine = cLine & Replace((Format(Datos(65), "000000000000000.0000")), ",", ".") & sSeparador '65
        cLine = cLine & sSeparador                                    '66
        cLine = cLine & sSeparador                                    '67
        cLine = cLine & sSeparador                                    '68
        cLine = cLine & sSeparador                                    '69
        cLine = cLine & sSeparador                                    '70
        cLine = cLine & sSeparador                                    '71
        cLine = cLine & sSeparador                                    '72
        cLine = cLine & sSeparador                                    '73
        cLine = cLine & sSeparador                                    '74
        cLine = cLine & sSeparador                                    '75
        cLine = cLine & sSeparador                                    '76
        cLine = cLine & sSeparador                                    '77
        cLine = cLine & Format(Datos(78), "0000") & sSeparador        '78
        cLine = cLine & Replace((Format(Datos(79), "000000000000000.0000")), ",", ".") & sSeparador '79
        cLine = cLine & sSeparador                                    '80
        cLine = cLine & sSeparador                                    '81
        cLine = cLine & sSeparador                                    '82
        cLine = cLine & sSeparador                                    '83
        cLine = cLine & sSeparador                                    '84
        cLine = cLine & sSeparador                                    '85
        cLine = cLine & sSeparador                                    '86
        cLine = cLine & sSeparador                                    '87
        cLine = cLine & sSeparador                                    '88
        cLine = cLine & sSeparador                                    '89
        cLine = cLine & sSeparador                                    '90
        cLine = cLine & Chr(10)
               
        TotalReg = TotalReg + 1
        
        Put #1, , cLine
    Loop
    
    cLine = ""
    TotalReg = TotalReg + 1
    cLine = cLine & "99" & sSeparador
    cLine = cLine & Format(GLB_Fecha_Proceso, "yyyymmdd") & sSeparador
    cLine = cLine & Format(TotalReg, "0000000000") & sSeparador
    
    For I = 4 To 89
        cLine = cLine & sSeparador
    Next I
        
    Put #1, , cLine
    Close #1
    
    If Not Enviar_por_ftp_neo(cRuta, cNomArchivo, cNombre) Then
         MsgBox "Interfaz " & cNombre & "  via FTP no fue traspasada ", vbCritical
      Else
         MsgBox "Interfaz " & cNombre & "  via FTP fue traspasada exitosamente ", vbInformation
    End If
    
    Screen.MousePointer = 0
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, "MENSAJE"
    Exit Sub
   
Herror1:
   Close #1
   Screen.MousePointer = 0
   MsgBox "Error: " & Err.Number & " Descripción: " & Err.Description, vbCritical, "Interfaz"
   Exit Sub

End Sub

Sub InterfazBalanceXOperacion(cRuta As String)
    Dim I              As Integer
    Dim total          As Integer
    Dim TotalReg       As Integer
    Dim cDia           As String
    Dim cNomArchivo    As String
    Dim cNombre        As String
    Dim cLine          As String
    Dim sSeparador     As String

 On Error GoTo Herror1
    total = 0
    TotalReg = 0
    cNomArchivo = ""
    cDia = Format(GLB_Fecha_Proceso, "yymmdd")
    cNombre = "BO24" & cDia & ".TCL"
    cNomArchivo = cRuta & cNombre
    sSeparador = ","

    Screen.MousePointer = 11
    
    If Dir(cNomArchivo, vbArchive) <> Empty Then
        If MsgBox("El Archivo " & cNomArchivo & " ya existe, ¿Desea reemplazarlo?", vbExclamation + vbYesNo, "") <> 6 Then
            Screen.MousePointer = 0
            Exit Sub
        End If
        Call Kill(cNomArchivo)
    End If

    If Not FUNC_EXECUTA_COMANDO_SQL("Sp_interfaz_Balance_Pasivos") Then
        Screen.MousePointer = 0
        MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
        Exit Sub
    End If

    Open cNomArchivo For Binary Access Write As #1
  
    Do While FUNC_LEE_RETORNO_SQL(Datos)
        cLine = ""
        cLine = cLine & Trim(Datos(1)) & sSeparador                   '1
        cLine = cLine & Format(Datos(2), "YYYYMMDD") & sSeparador     '2
        cLine = cLine & Trim(Datos(3)) & sSeparador                   '3
        cLine = cLine & Trim(Datos(4)) & sSeparador                   '4
        cLine = cLine & Trim(Datos(5)) & sSeparador                   '5
        cLine = cLine & Trim(Datos(6)) & sSeparador                   '6
        cLine = cLine & Format(Datos(7), "YYYYMMDD") & sSeparador     '7
        cLine = cLine & Trim(Datos(8)) & sSeparador                   '8
        cLine = cLine & Trim(Datos(9)) & sSeparador                   '9
        cLine = cLine & Trim(Datos(10)) & sSeparador                  '10
        cLine = cLine & Trim(Datos(11)) & sSeparador                  '11
        cLine = cLine & Replace((Format(Datos(12), "00000000000000000.00")), ",", ".") & sSeparador '12
        cLine = cLine & Trim(Datos(13)) & sSeparador                  '13
        cLine = cLine & Replace((Format(Datos(12), "00000000000000000.00")), ",", ".") & sSeparador '14
        cLine = cLine & Trim(Datos(15)) & sSeparador                  '15
        cLine = cLine & Replace((Format(Datos(16), "00000000000000000.00")), ",", ".") & sSeparador '16
        cLine = cLine & Trim(Datos(17)) & sSeparador                  '17
        cLine = cLine & Trim(Datos(18)) & sSeparador                  '18
        cLine = cLine & Chr(13) + Chr(10)
               
        TotalReg = TotalReg + 1
        
        Put #1, , cLine
    Loop
    
    cLine = ""
    TotalReg = TotalReg + 1
    cLine = cLine & "99" & sSeparador
    cLine = cLine & Format(GLB_Fecha_Proceso, "yyyymmdd") & sSeparador
    cLine = cLine & Format(TotalReg, "0000000000") & sSeparador
    
    For I = 4 To 17
        cLine = cLine & sSeparador
    Next I
    
    Put #1, , cLine
    Close #1
    
     If Not Enviar_por_ftp_neo(cRuta, cNomArchivo, cNombre) Then
         MsgBox "Interfaz " & cNombre & "  via FTP no fue traspasada ", vbCritical
      Else
         MsgBox "Interfaz " & cNombre & "  via FTP fue traspasada exitosamente ", vbInformation
    End If
    
    Screen.MousePointer = 0
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, "MENSAJE"
    Exit Sub
   
Herror1:
   Close #1
   Screen.MousePointer = 0
   MsgBox "Error: " & Err.Number & " Descripción: " & Err.Description, vbCritical, "Interfaz"
   Exit Sub
End Sub
Sub InterfazFlujoXOperacion(cRuta As String)
    Dim I              As Integer
    Dim total          As Integer
    Dim TotalReg       As Integer
    Dim cDia           As String
    Dim cNomArchivo    As String
    Dim cNombre        As String
    Dim cLine          As String
    Dim sSeparador     As String

 On Error GoTo Herror1
    total = 0
    TotalReg = 0
    cNomArchivo = ""
    cDia = Format(GLB_Fecha_Proceso, "yymmdd")
    cNombre = "FL24" & cDia & ".TCL"
    cNomArchivo = cRuta & cNombre
    sSeparador = ","

    Screen.MousePointer = 11
    
    If Dir(cNomArchivo, vbArchive) <> Empty Then
        If MsgBox("El Archivo " & cNomArchivo & " ya existe, ¿Desea reemplazarlo?", vbExclamation + vbYesNo, "") <> 6 Then
            Screen.MousePointer = 0
            Exit Sub
        End If
        Call Kill(cNomArchivo)
    End If
    
    If Not FUNC_EXECUTA_COMANDO_SQL("Sp_Interfaz_FlujoXOperacion") Then
        Screen.MousePointer = 0
        MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
        Exit Sub
    End If

    Open cNomArchivo For Binary Access Write As #1
  
    Do While FUNC_LEE_RETORNO_SQL(Datos)
        cLine = ""
        cLine = cLine & Trim(Datos(1)) & sSeparador                   '1
        cLine = cLine & Format(Datos(2), "YYYYMMDD") & sSeparador     '2
        cLine = cLine & Trim(Datos(3)) & sSeparador                   '3
        cLine = cLine & Trim(Datos(4)) & sSeparador                   '4
        cLine = cLine & Trim(Datos(5)) & sSeparador                   '5
        cLine = cLine & Trim(Datos(6)) & sSeparador                   '6
        cLine = cLine & Format(Datos(7), "YYYYMMDD") & sSeparador     '7
        cLine = cLine & Replace((Format(Datos(8), "00000000000000000.00")), ",", ".") & sSeparador  '8
        cLine = cLine & Replace((Format(Datos(9), "00000000000000000.00")), ",", ".") & sSeparador  '9
        cLine = cLine & Replace((Format(Datos(10), "00000000000000000.00")), ",", ".") & sSeparador '10
        cLine = cLine & Trim(Datos(11)) & sSeparador                  '11
        cLine = cLine & Trim(Datos(12)) & sSeparador                  '12
        cLine = cLine & Chr(10)
               
        TotalReg = TotalReg + 1
        
        Put #1, , cLine
    Loop
    
    cLine = ""
    TotalReg = TotalReg + 1
    cLine = cLine & "99" & sSeparador
    cLine = cLine & Format(GLB_Fecha_Proceso, "yyyymmdd") & sSeparador
    cLine = cLine & Format(TotalReg, "0000000000") & sSeparador
    
    For I = 4 To 11
        cLine = cLine & sSeparador
    Next I
    
    Put #1, , cLine
    Close #1
    
    If Not Enviar_por_ftp_neo(cRuta, cNomArchivo, cNombre) Then
         MsgBox "Interfaz " & cNombre & "  via FTP no fue traspasada ", vbCritical
      Else
         MsgBox "Interfaz " & cNombre & "  via FTP fue traspasada exitosamente ", vbInformation
    End If
        
    Screen.MousePointer = 0
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, "MENSAJE"
    Exit Sub
   
Herror1:
   Close #1
   Screen.MousePointer = 0
   MsgBox "Error: " & Err.Number & " Descripción: " & Err.Description, vbCritical, "Interfaz"
   Exit Sub
End Sub

Sub InterfazFlujos(cRuta As String)
 Dim total          As Integer
 Dim TotalReg       As Integer
 Dim cDia           As String
 Dim cNomArchivo    As String
 Dim cNombre        As String
 Dim cLine          As String
 Dim sSeparador     As String
 
 On Error GoTo Herror1
     total = 0
     TotalReg = 0
     cNomArchivo = ""
     cDia = Format(GLB_Fecha_Proceso, "yymmdd")
     cNomArchivo = cRuta & "FL52" & cDia & ".TCL"
     sSeparador = ","
    
     If Not FUNC_EXECUTA_COMANDO_SQL("sp_Interfaz_Flujo") Then
        MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
        'Call LogAuditoria("09", "Opc_60600", "Interfaz Error", "", "")
        Exit Sub
     End If
      
     If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
     End If
    
    Open cNomArchivo For Binary Access Write As #1
      
    Do While FUNC_LEE_RETORNO_SQL(Datos)
        cLine = ""
        'cLine = cLine & BacPad((Datos(1)), 3) & sSeparador              ' 1
        'cLine = cLine & Format((Datos(2)), "YYYYMMDD") & sSeparador     ' 2
        cLine = cLine & BacPad((Datos(3)), 4) & sSeparador             ' 3
        cLine = cLine & BacPad((Datos(4)), 3) & sSeparador              ' 4
        cLine = cLine & Trim(Datos(5)) & sSeparador             ' 5
        cLine = cLine & Trim(Datos(6)) & sSeparador             ' 6
        cLine = cLine & Format((Datos(7)), "YYYYMMDD") & sSeparador     ' 7
        'cLine = cLine & Replace(PuntoDecimal(Format$(Val(bacTranMontoSql(Datos(8))), "00000000000000000.00")), ",", ".") & sSeparador '8
        'cLine = cLine & Replace(PuntoDecimal(Format$(Val(bacTranMontoSql(Datos(9))), "00000000000000000.00")), ",", ".") & sSeparador '9
        'cLine = cLine & Replace(PuntoDecimal(Format$(Val(bacTranMontoSql(Datos(10))), "00000000000000000.00")), ",", ".") & sSeparador '10
        cLine = cLine & Trim(Datos(11)) & sSeparador             '11
        cLine = cLine & Trim(Datos(12)) + Chr(13) + Chr(10)     '12
        TotalReg = TotalReg + 1
        
        If Len(cLine) <> 156 Then
           TotalReg = TotalReg
        End If
                
        Put #1, , cLine
        
    Loop
    
    cLine = ""
    TotalReg = TotalReg + 1
    cLine = cLine & "99" & sSeparador
    cLine = cLine & Format(GLB_Fecha_Proceso, "yyyymmdd") & sSeparador
    cLine = cLine & Format(TotalReg, "0000000000") & Space(122) & Chr(13) + Chr(10)
    Put #1, , cLine
    Close #1
    
    If Not Enviar_por_ftp_neo(cRuta, cNomArchivo, cNombre) Then
         MsgBox "Interfaz " & cNombre & "  via FTP no fue traspasada ", vbCritical
    Else
         MsgBox "Interfaz " & cNombre & "  via FTP fue traspasada exitosamente ", vbInformation
    End If
        
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, "MENSAJE"
    'Call LogAuditoria("09", "Opc_60600", "Interfaz Generada Correctamente", "", "")

    'If Not Graba_Swicht("flujos", "1") Then
     '  MsgBox "No se pudo actualizar Swicht de flujos", vbOKOnly, TITSISTEMA
    'End If
    'Call gsc_Parametros.DatosGenerales
    Exit Sub
   
Herror1:
   MsgBox "Error: " & Err.Number & " Descripción: " & Err.Description, vbCritical, "Interfaz"
   'Call LogAuditoria("09", "Opc_60600", "Interfaz Error", "", "")
   Exit Sub

End Sub

Public Function BacPad(sCadena As Variant, nLargo As Integer) As String

    Dim nCarac          As Integer

    If Len(sCadena) >= nLargo Then
        BacPad = Mid$(sCadena, 1, nLargo)

    Else
       BacPad = sCadena + Space$(nLargo - Len(sCadena))

    End If

End Function

Public Function Enviar_por_ftp_neo(cRuta As String, direct_carchivo As String, carchivo As String) As Boolean
 
 
  Dim X
 Dim fName1
 Dim fName2
 Dim ifilehost
 Dim ifiledel
 Dim arc_scrp As String
 ' de bono
 Dim Variable   As String

 On Error GoTo Erroftp

  arc_scrp = ""
  fName1 = ""
  fName2 = ""

              If right(cRuta, 1) <> "\" Then
                 fName1 = cRuta & "\" & "Ftptrdneop.txt"
                 fName2 = cRuta & "\" & "Ftptrdneod.txt"
              Else
                 fName1 = cRuta & "Ftptrdneop.txt"
                 fName2 = cRuta & "Ftptrdneod.txt"
              End If


  ifilehost = FreeFile
  ifiledel = FreeFile

  Enviar_por_ftp_neo = True

  Variable = " " & Trim(gsIp_MaqCtbNeo)

  Open fName1 For Output As ifilehost
  Close #ifilehost

  Open fName2 For Output As ifiledel
  Close #ifiledel


  Open fName2 For Output As ifiledel
  'Print #ifilehost, gsNom_maq                                        ' nombre maquina

  'Limpieza de datos antiguos
  Print #ifiledel, gsIp_MaqCtbNeo
  Print #ifiledel, gsUser_maqNeo                                       ' USERNAME
  Print #ifiledel, gsPass_maqNeo                                       ' Password
  Print #ifiledel, gsPath_maqNeo
  Print #ifiledel, "prompt"
  Print #ifiledel, "Asc"
  Print #ifiledel, "mdel " & carchivo + ".TCL"
  Print #ifiledel, "Close"
  Print #ifiledel, "By"
  Close #ifiledel
  X = Shell("ftp.exe -s:" & fName2)

  'BacControlWindows 10000000#  '1000000



  Open fName1 For Output As ifilehost
  'Envio de nuevos datos                                  ' nombre maquina
  Print #ifilehost, gsIp_MaqCtbNeo
  Print #ifilehost, gsUser_maqNeo                                       ' USERNAME
  Print #ifilehost, gsPass_maqNeo                                       ' Password
  Print #ifilehost, gsPath_maqNeo                                       ' PATH
  Print #ifilehost, "put " & direct_carchivo                         ' archivo a traspasar
  Print #ifilehost, "close"
  Print #ifilehost, "bye"                                            ' termina la secion
  Close #ifilehost
  X = Shell("ftp.exe -s:" & fName1)

  Exit Function

Erroftp:
   
   Enviar_por_ftp_neo = False

Exit Function
Resume

End Function

