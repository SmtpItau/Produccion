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

Sub InterfazOperaciones(cRuta As String, Fecha_interfaz As Date)
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
    cDia = Format(Fecha_interfaz, "yymmdd")
    cNombre = "OP50" & cDia & ".Dat"
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

    GLB_Envia = Array(Fecha_interfaz)
    
    If Not FUNC_EXECUTA_COMANDO_SQL("Sp_Interfaz_Operaciones", GLB_Envia) Then
        Screen.MousePointer = 0
            FRM_INTERFACES_SIGIR.Lst_Interfaces.ForeColor = "&HFF&"
            FRM_INTERFACES_SIGIR.Lst_Interfaces.AddItem ("Problemas al leer operaciones")
        Exit Sub
    End If
    
    Open cNomArchivo For Binary Access Write As #1
  
    Do While FUNC_LEE_RETORNO_SQL(Datos)
        cLine = ""
        cLine = Trim(Datos(1)) & Chr(13) & Chr(10)
        Put #1, , cLine
    Loop
    
    Close #1
        
    Screen.MousePointer = 0
    FRM_INTERFACES_SIGIR.Lst_Interfaces.AddItem ("Interfaz SIGIR Operaciones Generada")
    Exit Sub
   
Herror1:
   Close #1
   Screen.MousePointer = 0
       FRM_INTERFACES_SIGIR.Lst_Interfaces.ForeColor = "&HFF&"
       FRM_INTERFACES_SIGIR.Lst_Interfaces.AddItem ("Error: Interfaz SIGIR Operaciones No Generada")
   Exit Sub

End Sub

Sub InterfazBalanceXOperacion(cRuta As String, Fecha_interfaz As Date)
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
    cDia = Format(Fecha_interfaz, "yymmdd")
    cNombre = "BO50" & cDia & ".Dat"
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
    
    GLB_Envia = Array(Fecha_interfaz)
    
    If Not FUNC_EXECUTA_COMANDO_SQL("Sp_interfaz_Balance_Pasivos", GLB_Envia) Then
        Screen.MousePointer = 0
            FRM_INTERFACES_SIGIR.Lst_Interfaces.ForeColor = "&HFF&"
            FRM_INTERFACES_SIGIR.Lst_Interfaces.AddItem ("Problemas al leer operaciones")
        Exit Sub
    End If

    Open cNomArchivo For Binary Access Write As #1
  
    Do While FUNC_LEE_RETORNO_SQL(Datos)
        cLine = ""
        cLine = Trim(Datos(1)) & Chr(13) & Chr(10)
        Put #1, , cLine
    Loop
    
    Close #1
    
     
    Screen.MousePointer = 0
    FRM_INTERFACES_SIGIR.Lst_Interfaces.AddItem ("Interfaz SIGIR Balance Generada")
    Exit Sub
   
Herror1:
   Close #1
   Screen.MousePointer = 0
   FRM_INTERFACES_SIGIR.Lst_Interfaces.ForeColor = "&HFF&"
   FRM_INTERFACES_SIGIR.Lst_Interfaces.AddItem ("Error: Interfaz SIGIR Balance No Generada")
   Exit Sub
End Sub

Sub InterfazFlujoXOperacion(cRuta As String, Fecha_interfaz As Date)
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
    cDia = Format(Fecha_interfaz, "yymmdd")
    cNombre = "FL50" & cDia & ".Dat"
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
    
    GLB_Envia = Array(Fecha_interfaz)
    
    If Not FUNC_EXECUTA_COMANDO_SQL("Sp_Interfaz_FlujoXOperacion", GLB_Envia) Then
        Screen.MousePointer = 0
        FRM_INTERFACES_SIGIR.Lst_Interfaces.ForeColor = "&HFF&"
        FRM_INTERFACES_SIGIR.Lst_Interfaces.AddItem ("Problemas al leer operaciones")
        Exit Sub
    End If

    Open cNomArchivo For Binary Access Write As #1
  
    Do While FUNC_LEE_RETORNO_SQL(Datos)
        cLine = ""
        cLine = Trim(Datos(1)) & Chr(13) & Chr(10)
        Put #1, , cLine
    Loop
    
    Close #1
            
    Screen.MousePointer = 0
    FRM_INTERFACES_SIGIR.Lst_Interfaces.AddItem ("Interfaz SIGIR Flujos Generada")
    Exit Sub
   
Herror1:
   Close #1
   Screen.MousePointer = 0
   FRM_INTERFACES_SIGIR.Lst_Interfaces.ForeColor = "&HFF&"
   FRM_INTERFACES_SIGIR.Lst_Interfaces.AddItem ("Error: Interfaz SIGIR Flujos No Generada")
   Exit Sub
End Sub

Sub InterfazClienteOperacion(cRuta As String, Fecha_interfaz As Date)
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
    cDia = Format(Fecha_interfaz, "yymmdd")
    cNombre = "CO50" & cDia & ".Dat"
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
    
    If Not FUNC_EXECUTA_COMANDO_SQL("Sp_Interfaz_Cliente_Operacion") Then
        Screen.MousePointer = 0
        FRM_INTERFACES_SIGIR.Lst_Interfaces.ForeColor = "&HFF&"
        FRM_INTERFACES_SIGIR.Lst_Interfaces.AddItem ("Problemas al leer operaciones")
        Exit Sub
    End If

    Open cNomArchivo For Binary Access Write As #1
  
    Do While FUNC_LEE_RETORNO_SQL(Datos)
        cLine = ""
        cLine = Trim(Datos(1)) & Chr(13) & Chr(10)
        Put #1, , cLine
    Loop
    
    Close #1
    
        
    Screen.MousePointer = 0
    FRM_INTERFACES_SIGIR.Lst_Interfaces.AddItem ("Interfaz SIGIR Clientes Generada")
    Exit Sub
   
Herror1:
   Close #1
   Screen.MousePointer = 0
   FRM_INTERFACES_SIGIR.Lst_Interfaces.ForeColor = "&HFF&"
   FRM_INTERFACES_SIGIR.Lst_Interfaces.AddItem ("Error: Interfaz Clientes No Generada")
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
     cNomArchivo = cRuta & "FL50" & cDia & ".Dat"
     sSeparador = ","
    
     If Not FUNC_EXECUTA_COMANDO_SQL("sp_Interfaz_Flujo") Then
        MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
        Exit Sub
     End If
      
     If Dir(cNomArchivo) <> "" Then
        Kill cNomArchivo
     End If
    
    Open cNomArchivo For Binary Access Write As #1
      
    Do While FUNC_LEE_RETORNO_SQL(Datos)
        cLine = ""
        cLine = Trim(Datos(1)) & Chr(13) & Chr(10)
        Put #1, , cLine
    Loop
    
    Close #1
    
    If Not Enviar_por_ftp_neo(cRuta, cNomArchivo, cNombre) Then
         'MsgBox "Interfaz " & cNombre & "  via FTP no fue traspasada ", vbCritical
    Else
         'MsgBox "Interfaz " & cNombre & "  via FTP fue traspasada exitosamente ", vbInformation
    End If
        
    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, "MENSAJE"
    
    Exit Sub
   
Herror1:
   MsgBox "Error: " & Err.Number & " Descripción: " & Err.Description, vbCritical, "Interfaz"
   Exit Sub

End Sub
Public Function Interfaz_P36()
Dim Archivo As String
Dim Largo As Integer
Dim Texto As String
Dim Datos()
Dim sNameofFile As String

On Error GoTo Error_Interfaz

  ' VB- 14/10/2010
  ' --------------------------------
    Let sNameofFile = "P36" & IIf(Day(GLB_Fecha_Proceso) < 10, "0" & Day(GLB_Fecha_Proceso), Day(GLB_Fecha_Proceso)) & IIf(Month(GLB_Fecha_Proceso) < 10, "0" & Month(GLB_Fecha_Proceso), Month(GLB_Fecha_Proceso)) & ".TXT"
    Archivo = GLB_Ruta_Int_P36 & sNameofFile
  ' ________________________________
  ' VB+ 14/10/2010

If Dir(Archivo) <> "" Then
        If MsgBox("El Archivo " & Archivo & " ya existe, ¿Desea reemplazarlo?", vbExclamation + vbYesNo, "") <> 6 Then
            Screen.MousePointer = 0
            Exit Function
        End If
   Call Kill(Archivo)
End If


Open Archivo For Binary Access Write As #1
   
GLB_Envia = Array(GLB_Fecha_Proceso)

If FUNC_EXECUTA_COMANDO_SQL("sp_interfaz_P36", GLB_Envia) Then
    
    Do While FUNC_LEE_RETORNO_SQL(Datos())
    
        Largo = 0
        If Len(Datos(1)) < 228 Then
            Largo = 228 - Len(Datos(1))
        End If
        Texto = Datos(1) & Space(Largo) & Chr(13) & Chr(10)
        Put #1, , Texto
    Loop
End If

Close #1

MsgBox "Interfaz Generada" & " " & Archivo, vbOKOnly, "MENSAJE"


            Call PROC_LIMPIAR_CRISTAL
            
            FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_INTERFAZ_P36.rpt"
            FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = Format(GLB_Fecha_Proceso, "YYYYMMDD")
            FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = " "
            FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
            FRM_MDI_PASIVO.Pasivo_Rpt.Destination = crptToWindow
            FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1


Exit Function

Error_Interfaz:
If Err.Number = 20510 Then
    MsgBox "Problemas en generaciòn de Reporte", vbCritical
    FRM_MDI_PASIVO.Pasivo_Rpt.WindowParentHandle = FRM_MDI_PASIVO.hwnd
Else
    MsgBox "Problemas en generaciòn de interfaz", vbCritical
    FRM_MDI_PASIVO.Pasivo_Rpt.WindowParentHandle = FRM_MDI_PASIVO.hwnd
End If

End Function
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
  'Envio de nuevos datos
  Print #ifilehost, gsIp_MaqCtbNeo                ' nombre maquina
  Print #ifilehost, gsUser_maqNeo                 ' USERNAME
  Print #ifilehost, gsPass_maqNeo                 ' Password
  Print #ifilehost, gsPath_maqNeo                 ' PATH
  Print #ifilehost, "put " & direct_carchivo      ' archivo a traspasar
  Print #ifilehost, "close"
  Print #ifilehost, "bye"                         ' termina la secion
  Close #ifilehost
  X = Shell("ftp.exe -s:" & fName1)

  Exit Function

Erroftp:
   
   Enviar_por_ftp_neo = False

Exit Function
Resume

End Function
Public Function Interfaz_C40()
Dim Archivo As String
Dim Largo As Integer
Dim Texto As String
Dim Datos()

On Error GoTo Error_Interfaz

Archivo = LTrim(RTrim(GLB_Ruta_Int_C40)) + "BonRM.dat"

If Dir(Archivo) <> "" Then
   Kill (Archivo)
End If


Open Archivo For Binary Access Write As #1
   
GLB_Envia = Array(GLB_Fecha_Proceso)

If FUNC_EXECUTA_COMANDO_SQL("sp_interfaz_C40", GLB_Envia) Then
    
    Do While FUNC_LEE_RETORNO_SQL(Datos())
    
        Largo = 0
        If Len(Datos(1)) < 100 Then
            Largo = 100 - Len(Datos(1))
        End If
        Texto = Datos(1) & Space(Largo) & Chr(13) & Chr(10)
        Put #1, , Texto
    Loop
End If

Close #1

MsgBox "Interfaz Generada" & " " & Archivo, vbOKOnly, "MENSAJE"
Exit Function


Error_Interfaz:
MsgBox "Problemas en generaciòn de interfaz", vbCritical
FRM_MDI_PASIVO.Pasivo_Rpt.WindowParentHandle = FRM_MDI_PASIVO.hwnd

End Function
