Attribute VB_Name = "BacParcelaInterfaz"
Option Explicit

Private Function FuncCantRegistros(ByVal cFilename As String) As Long
   Dim FILAS      As String
   Dim nContador  As Long
   Dim cLinea           As String
   
   Let FILAS = FreeFile
   Let nContador = 0

   Open cFilename For Input As #FILAS

   If EOF(FILAS) = True Then
      Let FuncCantRegistros = nContador
   End If

   Do Until EOF(FILAS)
      Let nContador = nContador + 1
      Line Input #FILAS, cLinea
   Loop

   Close #FILAS

   Let FuncCantRegistros = nContador

End Function

Public Function FuncParcelaInterfaz(ByVal cFilename As String, ByRef oGrid As MSFlexGrid, ByVal cNomInterfaz As String, ByVal IdSistema As String) As Boolean
   On Error GoTo ErrorLecturaInterfaz
   Dim Sqldatos()
   Dim iFilas           As Integer
   Dim FILAS            As String
   Dim cLinea           As String
   Dim FirstTime        As Boolean
   Dim nFilas           As Long
   Dim iContador        As Long
   Dim nLargoHeader     As Long
   Dim nLargoBody       As Long
   Dim nLargoControl    As Long
   Dim bPrimeraVuelta   As Boolean
   Dim iFlag            As Integer
   Dim nNumRegistro     As Long
   Dim TotalRegistros   As Long
   
   Let FuncParcelaInterfaz = False
   Let FRM_PROC_FDIA.Pnl_Progreso.FloodPercent = 0
   
   Let TotalRegistros = FuncCantRegistros(cFilename)
   
   Let FILAS = FreeFile
   
   Let oGrid.Rows = 1:   Let oGrid.cols = 2
   
   Let FirstTime = True: Let iContador = -1:    Let bPrimeraVuelta = True:    Let nNumRegistro = 0
   
   
   '-> Se inicializa la Bandera que determina el Control de Registros
   Let iFlag = -1

   Envia = Array()
   AddParam Envia, cNomInterfaz
   AddParam Envia, IdSistema
   AddParam Envia, CDbl(0)          '--> IdCampos
   AddParam Envia, 1                '--> Tipo Consulta
   If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_FORMATO_INTERFAZ", Envia) Then
      Call BacParcelaInterfaz.FuncInsertMsgError(IdSistema, cNomInterfaz, 0, 0, 0, "Error en Proceso de parcelacion de Interfaz.", True)
      Call MsgBox("Error en el Control y Generacion de Interfaces", vbExclamation, App.Title)
      Exit Function
   End If

   Do While Bac_SQL_Fetch(Sqldatos())
       Let nNumRegistro = 0
       
      '-> Para controlar los largos de registros
       Let nLargoHeader = Sqldatos(5)
         Let nLargoBody = Sqldatos(6)
      Let nLargoControl = Sqldatos(7)
      '-------------------------------------------

      '->  Abre el Archivo
      Open cFilename For Input As #FILAS

      If EOF(FILAS) = True Then
         Close #FILAS
         Call FuncInsertMsgError(IdSistema, cNomInterfaz, 0, 0, 0, "Interfaz Sin Registros.", True)
         Exit Function
      End If

      '->  Se recorrera todo el archivo
      Do Until EOF(FILAS)

         Let nNumRegistro = nNumRegistro + 1

         '->   Captura de la Linea del Registro (1 a uno)
         Line Input #FILAS, cLinea

         '->   Se controlaran los largos solamente durante el prmer recorrido (Primera Apertura de Archivo)
         '->   Control de Largos de Registros se activara solanete para el Primer Registro
         If Len(cLinea) = nLargoHeader And nLargoHeader > 0 And nNumRegistro = 1 Then
            Let iFlag = 1                                            '->   Largo del Registro Header    (OK ARCHIVO)
         End If
         If Len(cLinea) = nLargoBody And nLargoBody > 0 And nNumRegistro < TotalRegistros Then
            Let iFlag = 2                                            '->   Largo del Registro Body      (OK ARCHIVO CON DATOS)
         End If
         If Len(cLinea) = nLargoControl And nLargoControl > 0 And nNumRegistro = TotalRegistros Then
            Let iFlag = 3                                            '->   Largo del Control            (OK ARCHIVO SIN DATOS)
         End If
         '->   ---------------------------------------------------------------------------

         '->   SOLAMENTE PARCELARA LA COLUMNA DETERMINA POR EL RETORNO DE SQL. (Columna por Columna)
         If iFlag = 2 Then                      '->  Identifica que es la primerca Columna
            If FirstTime = True Then
               Let oGrid.Rows = oGrid.Rows + 1  '-> Setea filas como registros tenga el Archivo
            Else
               Let nFilas = nFilas + 1          '-> Recorre las filas que antes se determinaron como largo del Archivo (No del Registro)
            End If

            If FirstTime = True Then            '->   Si es el primer registro se recorre por la cantidad de filas, de lo contrario por un contador de Filas
               Let oGrid.TextMatrix(oGrid.Rows - 1, oGrid.cols - 2) = Mid(cLinea, Sqldatos(3), Sqldatos(2))
            Else
               Let oGrid.TextMatrix(nFilas, oGrid.cols - 2) = Mid(cLinea, Sqldatos(3), Sqldatos(2))
            End If
         End If

         If iFlag = -1 Then
            Call FuncInsertMsgError(IdSistema, cNomInterfaz, 0, 0, 0, "Largo del Registro no coincide con ningún formato definido.", True)
         End If
      
      Loop
       
      '->   Cierra el Archivo
      Close #FILAS
      
      If iFlag = -1 And FirstTime = True Then
         Call FuncInsertMsgError(IdSistema, cNomInterfaz, 0, 0, 0, "Largo del Registro no coincide con ningún formato definido.", True)
      End If
      
      Let iFlag = -1
      Let oGrid.cols = oGrid.cols + 1
      Let FirstTime = False
      Let nFilas = 0
      Let iContador = iContador + 1
      
      If oGrid.cols < 101 Then
         Let FRM_PROC_FDIA.Pnl_Progreso.FloodPercent = oGrid.cols
         If oGrid.cols >= 49 Then
            Let FRM_PROC_FDIA.Pnl_Progreso.FloodColor = vbBlue:   Let FRM_PROC_FDIA.Pnl_Progreso.ForeColor = vbWhite
         Else
            Let FRM_PROC_FDIA.Pnl_Progreso.FloodColor = vbBlue:   Let FRM_PROC_FDIA.Pnl_Progreso.ForeColor = vbBlack
         End If
      End If
      
   Loop

   Let FuncParcelaInterfaz = True
   Let FRM_PROC_FDIA.Pnl_Progreso.FloodPercent = 100
   Let FRM_PROC_FDIA.Pnl_Progreso.FloodColor = vbBlue
   Let FRM_PROC_FDIA.Pnl_Progreso.ForeColor = vbWhite
   
Exit Function
ErrorLecturaInterfaz:

   Call FuncInsertMsgError(IdSistema, cNomInterfaz, 0, 0, 0, err.Description & " Registro N°: " & nNumRegistro, True)
   
End Function

Public Function FuncValidaInterfaz(ByRef oGrid As MSFlexGrid, ByRef oGrid1 As MSFlexGrid, ByRef oGrid2 As MSFlexGrid, ByRef oGrid3 As MSFlexGrid, ByVal IdSistema As String, ByRef nProgress As SSPanel) As Boolean
'    On Error GoTo ErrorValidaInterfaz
    Dim nFila            As Integer
    Dim nFila2           As Integer
    Dim nFila3           As Integer
    Dim nColOP           As Integer
    Dim nColBO           As Integer
    Dim nColFL           As Integer
    Dim nColDE           As Integer
    Dim nNumRegistro     As Long
    Dim cNumOperacion    As String
    Dim cNumDocumento    As String
    Dim cNumCorrelativo  As String
    Dim nLargoTotal      As Integer
    Dim nLargoCor        As Integer
    Dim cNomInterfaz     As String
    Dim cRegistro        As String
    Dim nRegTotal        As Long
    Dim nTotal           As Long
    Dim Sqldatos()
    
   Dim indicex            As Integer
   Dim indicey            As Integer
    
   '-->
   Let indicex = 0
   Let indicey = 0
   '-->
    Let nColOP = 18
    Let nColBO = 10
    Let nColFL = 6
    Let nColDE = 12
    Let cNomInterfaz = ""
    Let cRegistro = ""
    Let nRegTotal = oGrid1.Rows
    Let nTotal = 0
    Let cNumDocumento = 0
    Let cNumOperacion = 0
    Let cNumCorrelativo = 0
   
    Let FuncValidaInterfaz = False
  
    Let Screen.MousePointer = vbHourglass
    Let nProgress.ForeColor = vbBlack
    
    Let nProgress.Visible = True
    Let nProgress.FloodPercent = 0
    
    
   For nFila = 1 To oGrid1.Rows - 2
        If Mid(oGrid.TextMatrix(2, 1), 1, 2) = "BO" Then
            cNomInterfaz = oGrid.TextMatrix(2, 1)
            cRegistro = oGrid1.TextMatrix(nFila, nColOP - 1)
            
            For nFila2 = 1 To oGrid2.Rows - 1
                If Trim(oGrid1.TextMatrix(nFila, nColOP - 1)) = Trim(oGrid2.TextMatrix(nFila2, nColBO - 1)) Then
                    Exit For
                ElseIf nFila2 = oGrid2.Rows - 1 And Trim(oGrid1.TextMatrix(nFila, nColOP - 1)) <> Trim(oGrid2.TextMatrix(nFila2, nColBO - 1)) Then
                    If (IdSistema = "PCS" Or IdSistema = "BFW") Then
                        cNumOperacion = Trim(oGrid1.TextMatrix(nFila, nColOP - 1))
                    ElseIf (IdSistema = "BTR" Or IdSistema = "BEX") Then
                        nLargoTotal = Len(Trim(oGrid1.TextMatrix(nFila, nColOP - 1)))
                        nLargoCor = nLargoTotal - 10
                        cNumDocumento = Left(Trim(oGrid1.TextMatrix(nFila, nColOP - 1)), 5)
                        cNumOperacion = Right(Trim(oGrid1.TextMatrix(nFila, nColOP - 1)), 5)
                        cNumCorrelativo = Right(Left(Trim(oGrid1.TextMatrix(nFila, nColOP - 1)), 6), nLargoCor)
                    End If
                    
                    Envia = Array()
                    AddParam Envia, CLng(cNumOperacion)
                    AddParam Envia, CLng(cNumDocumento)
                    AddParam Envia, CInt(cNumCorrelativo)
              'If Not Bac_Sql_Execute("BacTaderSuda.dbo.SP_BUSCA_OPERACIONES_BTR", Envia) Then
               If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_BUSCA_OPERACIONES_BTR", Envia) Then
                        Exit Function
                    End If
                    Do While Bac_SQL_Fetch(Sqldatos())
                        If Sqldatos(1) = "NO" Then
                            Call FuncInsertMsgError(IdSistema, cNomInterfaz, CLng(cNumOperacion), CLng(cNumDocumento), CLng(cNumCorrelativo), err.Description & " Registro N°: " & Trim(cRegistro) & ", Operación sin Balance", True)
                        End If
                    Loop
                End If
            Next nFila2
        End If
            
        If Mid(oGrid.TextMatrix(3, 1), 1, 2) = "FL" Then
            cNomInterfaz = oGrid.TextMatrix(3, 1)
            cRegistro = oGrid1.TextMatrix(nFila, nColOP - 1)
            
            For nFila3 = 1 To oGrid3.Rows - 1
                If Trim(oGrid1.TextMatrix(nFila, nColOP - 1)) = Trim(oGrid3.TextMatrix(nFila3, nColFL - 1)) Then
                    Exit For

                ElseIf nFila3 = oGrid3.Rows - 1 Then
                    If (IdSistema = "PCS" Or IdSistema = "BFW") Then
                        cNumOperacion = Trim(oGrid1.TextMatrix(nFila, nColOP - 1))
                    ElseIf (IdSistema = "BTR" Or IdSistema = "BEX") Then
                        nLargoTotal = Len(Trim(oGrid1.TextMatrix(nFila, nColOP - 1)))
                        nLargoCor = nLargoTotal - 10
                        cNumDocumento = Left(Trim(oGrid1.TextMatrix(nFila, nColOP - 1)), 5)
                        cNumOperacion = Right(Trim(oGrid1.TextMatrix(nFila, nColOP - 1)), 5)
                        cNumCorrelativo = Right(Left(Trim(oGrid1.TextMatrix(nFila, nColOP - 1)), 6), nLargoCor)
                    End If
                    
                    Envia = Array()
                    AddParam Envia, CLng(cNumOperacion)
                    AddParam Envia, CLng(cNumDocumento)
                    AddParam Envia, CInt(cNumCorrelativo)
                    If Not Bac_Sql_Execute("SP_BUSCA_OPERACIONES_BTR", Envia) Then
                        Exit Function
                    End If
                    Do While Bac_SQL_Fetch(Sqldatos())
                        If Sqldatos(1) = "NO" Then
                            Call FuncInsertMsgError(IdSistema, cNomInterfaz, CLng(cNumOperacion), CLng(cNumDocumento), CLng(cNumCorrelativo), err.Description & " Registro N°: " & Trim(cRegistro) & ", Operación sin Flujo", True)
                        End If
                    Loop
                End If
            Next nFila3
        End If

        If Mid(oGrid.TextMatrix(3, 1), 1, 2) = "DE" Then
            cNomInterfaz = oGrid.TextMatrix(3, 1)
            cRegistro = oGrid1.TextMatrix(nFila, nColOP - 1)
            
            For nFila3 = 1 To oGrid3.Rows - 1
                If Trim(oGrid1.TextMatrix(nFila, nColOP - 1)) = Trim(oGrid3.TextMatrix(nFila3, nColDE - 1)) Then
                    Exit For
                ElseIf nFila3 = oGrid3.Rows - 1 Then
                    If (IdSistema = "PCS" Or IdSistema = "BFW") Then
                        cNumOperacion = Trim(oGrid1.TextMatrix(nFila, nColOP - 1))
                    ElseIf (IdSistema = "BTR" Or IdSistema = "BEX") Then
                        nLargoTotal = Len(Trim(oGrid1.TextMatrix(nFila, nColOP - 1)))
                        nLargoCor = nLargoTotal - 10
                        cNumDocumento = Left(Trim(oGrid1.TextMatrix(nFila, nColOP - 1)), 5)
                        cNumOperacion = Right(Trim(oGrid1.TextMatrix(nFila, nColOP - 1)), 5)
                        cNumCorrelativo = Right(Left(Trim(oGrid1.TextMatrix(nFila, nColOP - 1)), 6), nLargoCor)
                    End If
                    
                    Envia = Array()
                    AddParam Envia, CLng(cNumOperacion)
                    AddParam Envia, CLng(cNumDocumento)
                    AddParam Envia, CInt(cNumCorrelativo)
              'If Not Bac_Sql_Execute("BacTaderSuda.dbo.SP_BUSCA_OPERACIONES_BTR", Envia) Then
               If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_BUSCA_OPERACIONES_BTR", Envia) Then
                        Exit Function
                    End If
                    Do While Bac_SQL_Fetch(Sqldatos())
                        If Sqldatos(1) = "NO" Then
                            Call FuncInsertMsgError(IdSistema, cNomInterfaz, CLng(cNumOperacion), CLng(cNumDocumento), CLng(cNumCorrelativo), err.Description & " Registro N°: " & Trim(cRegistro) & ", Operación sin Flujo", True)
                        End If
                    Loop
                End If
            Next nFila3
        End If
        
        nTotal = nTotal + 1
        
        nProgress.FloodPercent = (nTotal * 100) / nRegTotal
        If nProgress.FloodPercent >= 49 Then
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbWhite
        Else
            Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack
        End If
    Next nFila
    
    Screen.MousePointer = vbDefault
    
    Let nProgress.FloodPercent = 0: Let nProgress.FloodColor = vbBlue: Let nProgress.ForeColor = vbBlack

End Function

Public Function FuncInsertMsgError(ByVal MiModulo As String, ByVal MiInterfaz As String, ByVal nOperacion As Long, ByVal nDocumento As Long, ByVal nCorrela As Long, ByVal cError As String, ByVal oGrabar As Boolean) As Boolean
   Let FuncInsertMsgError = False
  'generar secuencia para insertar

   Envia = Array()
   AddParam Envia, MiModulo                        '  @cIdSistema       VARCHAR(3)
   AddParam Envia, MiInterfaz                      '  @cNombre_Interfaz VARCHAR(4)
   AddParam Envia, nOperacion                      '  @nNumOperacion    NUMERIC(20) --> Nfila o Registro validado
   AddParam Envia, nDocumento                      '  @nNumDocumento    NUMERIC(20)
   AddParam Envia, nCorrela                        '  @nNumCorrelativo  NUMERIC(20)
   AddParam Envia, cError                          '  @cError           VARCHAR(200)
   AddParam Envia, gsBac_User                      '  @cUsuario         VARCHAR(30)
   AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")  '  @dFecha           DATETIME
   AddParam Envia, Format("19000101 " + Trim(Time), "yyyymmdd hh:mm:ss")        '  @dHora            DATETIME
   If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_GEN_LOG_INTERFAZ", Envia) Then
      Exit Function
   End If
   
   Let FuncInsertMsgError = True
End Function

Public Function FuncCargaDatosInterfaz_SOS() As Boolean

    Let FuncCargaDatosInterfaz_SOS = False

    Envia = Array()
    If Not Bac_Sql_Execute("BacParamSuda.dbo.Sp_Carga_Liquidaciones_SOS", Envia) Then
        Exit Function
    End If

    Let FuncCargaDatosInterfaz_SOS = True

End Function

Public Function FuncEraseErrores(ByVal MiModulo As String) As Boolean
        
    Envia = Array()
    AddParam Envia, MiModulo
    AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_ERRASE_ERRORES_CIERRE", Envia) Then
        Exit Function
    End If

End Function

Public Function FuncLoadErroresProcesos(ByVal MiModulo As String, ByRef MensajeError As String, ByRef Asunto As String) As Boolean
    Dim bandera           As Integer
    Dim Sqldatos()
    
    Let bandera = 0

    Let FuncLoadErroresProcesos = False

    Envia = Array()
    AddParam Envia, MiModulo
    AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LOAD_ERRORES_CIERRE", Envia) Then
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Sqldatos())
        Let FuncLoadErroresProcesos = Sqldatos(2)
        Let MensajeError = MensajeError & Sqldatos(4) & vbCrLf & vbTab
        Let Asunto = Sqldatos(3)

        Let bandera = 1
    Loop

    If bandera = 0 Then
        Let FuncLoadErroresProcesos = True
    End If
    
End Function

Public Function FuncSendMail(ByVal MiModulo As String, ByVal cMensaje As String, ByVal Asunto As String) As Boolean
    Dim Sqldatos()
    Dim Email       As String
    Dim Mensaje     As String

    Let FuncSendMail = False

    Let cMensaje = cMensaje & vbCrLf & vbCrLf & "Favor no responder, e-mail generado en forma automática..."

    Envia = Array()
    AddParam Envia, MiModulo
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEEMAIL_RESPONSABLES", Envia) Then
        Exit Function
    End If
    Do While Bac_SQL_Fetch(Sqldatos())
        Let Email = Email & Sqldatos(2) & ";"
    Loop

    If Len(Trim(email)) <= 0 Then
       Let email = "Adrian.Gonzalez@Corpbanca.cl"
    End If

    Call SendMail("usuarios, ", Asunto, Email, cMensaje & vbCrLf & vbCrLf, "Control de Generacion de Interfaces.")

    Let FuncSendMail = True
End Function

Public Function SendMail(ByVal Contacto As String, ByVal Asunto As String, ByVal Email As String, ByVal Mensaje As String, ByVal Firma As String)
   On Error Resume Next
   Dim Enviar      As Object
   Dim ObjCorreo   As Object

   Set ObjCorreo = CreateObject("Outlook.Application")
   Set Enviar = ObjCorreo.CreateItem(0)

   Enviar.To = Email
   Enviar.cc = ""
   Enviar.Subject = Asunto
   Enviar.Body = "Estimados " & Contacto & vbCrLf & vbTab & Mensaje & vbCrLf & vbCrLf & "Atte." & vbCrLf & Firma
   Enviar.Importance = 1
   Enviar.send

   Set ObjCorreo = Nothing
   Set Enviar = Nothing

   On Error GoTo 0
End Function


Public Function FuncInterfacesVacias(ByRef oGrid As MSFlexGrid, ByRef oGrid1 As MSFlexGrid, ByRef oGrid2 As MSFlexGrid, ByRef oGrid3 As MSFlexGrid, ByVal IdSistema As String)
    Dim msgeOP As String
    Dim msgeBO As String
    Dim msgeFL As String
    
    Let msgeOP = ""
    Let msgeBO = ""
    Let msgeFL = ""
    Let FuncInterfacesVacias = False
    
    If oGrid1.Rows <= 1 Then
        msgeOP = " " & oGrid.TextMatrix(1, 1) & ""
    End If
    
    If oGrid2.Rows <= 1 Then
        If msgeOP = "" Then
            msgeBO = " " & oGrid.TextMatrix(2, 1) & ""
        Else
            msgeBO = ", " & oGrid.TextMatrix(2, 1) & ""
        End If
    End If
    
    If oGrid3.Rows <= 1 Then
        If msgeOP = "" And msgeBO = "" Then
            msgeFL = " " & oGrid.TextMatrix(3, 1) & ""
        Else
            msgeFL = ", " & oGrid.TextMatrix(3, 1) & ""
        End If
    End If
    
    If msgeOP <> "" Or msgeBO <> "" Or msgeFL <> "" Then
       'Call FuncInsertMsgError(IdSistema, "", 0, 0, 0, " Interfaces generadas sin datos " & msgeOP & "" & msgeBO & "" & msgeFL & "", True)
        Call MsgBox(" Se generaron interfaces vacías, favor revisar. ", vbExclamation, App.Title)
    End If
    
    Let FuncInterfacesVacias = True
End Function




