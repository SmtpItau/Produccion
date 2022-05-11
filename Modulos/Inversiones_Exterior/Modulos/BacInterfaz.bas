Attribute VB_Name = "BacInterfaz"
Option Explicit

Public Sub InterfazContable(ruta, Dia)
   On Error GoTo ErrorInterfazContable
   Dim cDia          As String
   Dim cNomArchivo   As String
   Dim cLine         As String
   Dim datos()
   Dim Correla       As Integer
   Dim Numero        As Double
   Dim Dec           As String
   Dim Separa        As String
   Dim i             As Integer
   Dim ok            As Boolean
   Dim FinMesEsp     As Boolean
   Dim cFechoy$
   Dim proceso       As Integer
   Dim hasta         As Integer
   Dim FechaInterfaz
   Dim FechaContaFinMes
  
   FinMesEsp = False
   

   If Month(gsBac_Fecx) <> Month(gsBac_Fecp) Then
      cFechoy$ = "01/" & Month(gsBac_Fecx) & "/" & Year(gsBac_Fecx)
      cFechoy$ = DateAdd("d", -1, cFechoy$)
      FechaContaFinMes = cFechoy$
      If CDate(FechaContaFinMes) <> gsBac_Fecp Then
         FinMesEsp = True
      End If
   End If

   Separa = ""
   ok = True
   proceso = 0

   Do While ok
         cNomArchivo = ruta & "GL51" & Dia & ".DAT"
         ok = False
         cLine = ""
   
      If FinMesEsp Then
         hasta = 2
      Else
         hasta = 1
      End If
      
      For i = 1 To hasta
         envia = Array()
         If i = 1 Then
            FechaInterfaz = gsBac_Fecp
         Else
            FechaInterfaz = FechaContaFinMes
         End If
            AddParam envia, 0
            AddParam envia, FechaInterfaz
        

         If Bac_Sql_Execute("SP_INTERFAZ_CONTABLE", envia) Then
            Do While Bac_SQL_Fetch(datos())
               
               cLine = cLine & datos(1)
               cLine = cLine & datos(2)
               cLine = cLine & datos(3)
               cLine = cLine & datos(4)
               cLine = cLine & datos(5)
               cLine = cLine & datos(6)
               cLine = cLine & datos(7)
               cLine = cLine & datos(8)
               cLine = cLine & datos(9)
               cLine = cLine & datos(10)
               cLine = cLine & datos(11)
               cLine = cLine & datos(12)
               cLine = cLine & datos(13)
               cLine = cLine & datos(14)
               cLine = cLine & datos(15)
               cLine = cLine & datos(16)
               cLine = cLine & datos(17)
               cLine = cLine & datos(18)
               cLine = cLine & datos(19)
               cLine = cLine & datos(20)
               cLine = cLine & datos(21)
               cLine = cLine & datos(22)
               cLine = cLine & datos(23)
               cLine = cLine & datos(24)
               cLine = cLine & datos(25)
               cLine = cLine & datos(26)
               cLine = cLine + Chr(13) + Chr(10)
            Loop
         Else
               MsgBox "Interfaz Contable no ha sido Generada", vbCritical, TITSISTEMA

         End If
      Next i

      If Dir(cNomArchivo) <> "" Then
         Kill cNomArchivo
      End If
   
      Open cNomArchivo For Binary Access Write As #1
      Put #1, , cLine
      Close #1
     

   Loop
      
   Screen.MousePointer = vbDefault
   MsgBox "Acción Finaizada." & vbCrLf & vbCrLf & "Generación de Interfaz Contable Inversiones al Exterior, Ha finalizado correctamente.", vbInformation, TITSISTEMA
Exit Sub
ErrorInterfazContable:
   Screen.MousePointer = vbDefault
   MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "Interfaz no ha sido generada.... Reintente.", vbExclamation, TITSISTEMA
End Sub

Public Function BacEspacios(sCadena, nLargo As Integer) As String

    Dim nCarac          As Integer

    If Len(sCadena) >= nLargo Then
        BacEspacios = Mid$(sCadena, 1, nLargo)

    Else
       BacEspacios = sCadena + Space$(nLargo - Len(sCadena))

    End If

End Function

Function SacaDecim(num) As String
Dim Dec As String
Dim desde As Integer


desde = (InStr(1, num, gsBac_PtoDec) + 1)

If (desde > 1) Then
    Dec = Mid(num, desde, Len(num))
End If

SacaDecim = IIf(Dec = "", "0", Dec)


End Function
 Public Function Enviar_por_ftp(cruta As String, direct_carchivo As String, cual) As Boolean
 Dim X
 Dim fName1
 Dim ifilehost
 Dim arc_scrp As String
 Dim Variable   As String
 
 On Error GoTo Erroftp
 
 arc_scrp = ""
 fName1 = ""
 If cual = 1 Then
 
   fName1 = cruta & "Ftpbemn.txt"
Else
   fName1 = cruta & "Ftpbemx.txt"
End If
 ifilehost = FreeFile
 
 Enviar_por_ftp = True
 Variable = " " & Trim(gsNom_maq)
   Open fName1 For Output As ifilehost
   Close #ifilehost

   Open fName1 For Output As ifilehost
  ' Print #ifilehost, gsNom_maq                                 ' nombre maquina
   Print #ifilehost, gsUser_maq                                 ' USERNAME
   Print #ifilehost, gsPass_maq                                 ' Password
   Print #ifilehost, gsPath_maq                              ' RUTA DE LA MAQUINA
   Print #ifilehost, "put " & direct_carchivo                ' archivo a traspasar
   Print #ifilehost, "bye"   ' termina la secion

   Close #ifilehost
   
    X = Shell("ftp.exe -s:" & fName1 & " " & gsNom_maq)
   
   
   Exit Function
  
Erroftp:
Select Case err.Number
    Case 55
            Close ifilehost
            MsgBox " Error " & err.Number & " " & err.Description
    Case 53
            ifilehost = FreeFile
            Open fName1 For Output As ifilehost
            Close #ifilehost
            MsgBox " Error " & err.Number & " " & err.Description
            'Resume
    Case 0
    MsgBox " Error " & err.Number & " " & err.Description
    '''otro problema
End Select

Enviar_por_ftp = False


Exit Function
Resume
End Function


